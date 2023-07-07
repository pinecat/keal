# Generated from keal-0.2.0.gem by gem2rpm -*- rpm-spec -*-
%global gem_name keal

Name: rubygem-%{gem_name}
Version: 0.2.0
Release: 1%{?dist}
Summary: Keep alive program for Linux/GNOME
License: MIT
URL: https://github.com/pinecat/keal
Source0: https://rubygems.org/gems/%{gem_name}-%{version}.gem
BuildRequires: ruby(release)
BuildRequires: rubygems-devel
BuildRequires: ruby-devel >= 2.6.0
# Compiler is required for build of gem binary extension.
# https://fedoraproject.org/wiki/Packaging:C_and_C++#BuildRequires_and_Requires
BuildRequires: gcc

%description
Keep alive program for the GNOME desktop environment on Linux, inspired by
caffeinate(8) on MacOS.


%package doc
Summary: Documentation for %{name}
Requires: %{name} = %{version}-%{release}
BuildArch: noarch

%description doc
Documentation for %{name}.

%prep
%setup -q -n %{gem_name}-%{version}

%build
# Create the gem as gem install only works on a gem file
gem build ../%{gem_name}-%{version}.gemspec

# %%gem_install compiles any C extensions and installs the gem into ./%%gem_dir
# by default, so that we can move it into the buildroot in %%install
%gem_install

%install
mkdir -p %{buildroot}%{gem_dir}
cp -a .%{gem_dir}/* \
        %{buildroot}%{gem_dir}/

mkdir -p %{buildroot}%{gem_extdir_mri}
cp -a .%{gem_extdir_mri}/{gem.build_complete,*.so} %{buildroot}%{gem_extdir_mri}/

# Prevent dangling symlink in -debuginfo (rhbz#878863).
rm -rf %{buildroot}%{gem_instdir}/ext/

mkdir -p %{buildroot}%{_bindir}
cp -a .%{_bindir}/* \
        %{buildroot}%{_bindir}/

find %{buildroot}%{gem_instdir}/exe -type f | xargs chmod a+x

%check
pushd .%{gem_instdir}
# Run the test suite.
popd

%files
%dir %{gem_instdir}
%{_bindir}/keal
%{_bindir}/keald
%{gem_extdir_mri}
%{gem_instdir}/.ruby-version
%{gem_instdir}/.standard.yml
%license %{gem_instdir}/LICENSE.txt
%{gem_instdir}/dist
%{gem_instdir}/exe
%{gem_libdir}
%{gem_instdir}/sig
%exclude %{gem_cache}
%{gem_spec}

%files doc
%doc %{gem_docdir}
%doc %{gem_instdir}/CHANGELOG.md
%{gem_instdir}/Gemfile
%{gem_instdir}/Gemfile.lock
%doc %{gem_instdir}/README.md
%{gem_instdir}/Rakefile
%{gem_instdir}/keal.gemspec

%changelog
* Fri Apr 14 2023 Rory Dudley <rory.dudley@gmail.com> - 0.2.0-1
- Initial package
