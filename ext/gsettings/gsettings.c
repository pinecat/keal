#include <ruby.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <giomm/init.h>
#include <giomm/settings.h>
#define HOME "HOME"
#define DBUS "DBUS_SESSION_BUS_ADDRESS"

VALUE method_get_idle_delay(VALUE self) {
	uint s = Gio::Settings::create("org.gnome.desktop.session")->get_uint("idle-delay");
	return UINT2NUM(s);
}

VALUE method_set_idle_delay(VALUE self, VALUE s) {
	uint seconds = NUM2UINT(s);
	Gio::Settings::create("org.gnome.desktop.session")->set_uint("idle-delay", seconds);
	g_settings_sync();
	return true;
}

VALUE method_get_lock_screen(VALUE self) {
	bool l = Gio::Settings::create("org.gnome.desktop.lockdown")->get_boolean("disable-lock-screen");
	return l;
}

VALUE method_set_lock_screen(VALUE self, VALUE l) {
	Gio::Settings::create("org.gnome.desktop.lockdown")->set_boolean("disable-lock-screen", l);
	g_settings_sync();
	return true;
}

VALUE method_get_env_uid(VALUE self) {
	return UINT2NUM(getuid());
}

VALUE method_get_env_home(VALUE self) {
	return rb_str_new_cstr(getenv("HOME"));
}

VALUE method_set_environment(VALUE self, VALUE uid, VALUE home, VALUE dbus) {
	uint u = NUM2UINT(uid);
	if (setuid(u) != 0) { return INT2NUM(-1); }
	if (setenv(HOME, StringValueCStr(home), 1) != 0) { return INT2NUM(-2); }
	if (setenv(DBUS, StringValueCStr(dbus), 1) != 0) { return INT2NUM(-3); }
	return true;
}

VALUE gsettings = Qnil;
extern "C" void Init_gsettings() {
	Gio::init();
	gsettings = rb_const_get(rb_cObject, rb_intern("GSettings"));
	rb_define_method(gsettings, "get_idle_delay", method_get_idle_delay, 0);
	rb_define_method(gsettings, "set_idle_delay", method_set_idle_delay, 1);
	rb_define_method(gsettings, "get_lock_screen", method_get_lock_screen, 0);
	rb_define_method(gsettings, "set_lock_screen", method_set_lock_screen, 1);
	rb_define_method(gsettings, "get_env_uid", method_get_env_uid, 0);
	rb_define_method(gsettings, "get_env_home", method_get_env_home, 0);
	rb_define_method(gsettings, "set_environment", method_set_environment, 3);
}
