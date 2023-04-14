# frozen_string_literal: true

require "mkmf"

# Module name
extension_name = "gsettings"

# Use C++
have_library "stdc++"
CONFIG["CC"] = "g++"

# Need extra flags for including glibmm and giomm (`pkgconf --cflags --libs glibmm-2.4 giomm-2.4`)
$CPPFLAGS << " -I/usr/include/glibmm-2.4 -I/usr/lib64/glibmm-2.4/include -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/sysprof-4 -I/usr/include/sigc++-2.0 -I/usr/lib64/sigc++-2.0/include -I/usr/include/giomm-2.4 -I/usr/lib64/giomm-2.4/include -I/usr/include/libmount -I/usr/include/blkid -pthread -lgiomm-2.4 -lgio-2.0 -lglibmm-2.4 -lgobject-2.0 -lglib-2.0 -lsigc-2.0"
$LDFLAGS << " -I/usr/include/glibmm-2.4 -I/usr/lib64/glibmm-2.4/include -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/sysprof-4 -I/usr/include/sigc++-2.0 -I/usr/lib64/sigc++-2.0/include -I/usr/include/giomm-2.4 -I/usr/lib64/giomm-2.4/include -I/usr/include/libmount -I/usr/include/blkid -pthread -lgiomm-2.4 -lgio-2.0 -lglibmm-2.4 -lgobject-2.0 -lglib-2.0 -lsigc-2.0"

# Create the Makefile
create_makefile "#{extension_name}/#{extension_name}"
