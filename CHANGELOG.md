## [Unreleased]

## [0.2.0] - 2023-04-14

This release gets `keal` up to spec with its uncrealeased prototype (0.0.2). There are some differences, though, primarily that the daemon handles all masking and unmasking of services and options (whereas previously these functions were split up). There is also a custom gsettings exention now, allowing relevant dconf settings to be changed programatically.

### Added

- A gsettings extension (https://developer-old.gnome.org/glibmm/stable/classGio_1_1Settings.html).
- The `keald` daemon, which listens for connections and performs masking and unmasking of services and dconf options.
- The `keal` program, which connects to the `keald` daemon and directs it what services and dconf options to mask/unmask, as well as for how long.
- A `Preferences` module for any shared values between `keal` and `keald`.
- The systemd unit file for the `keald` daemon (cannot be installed via `gem install keal`).

## [0.1.0] - 2023-03-23

- Initial release
