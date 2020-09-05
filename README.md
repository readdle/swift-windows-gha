# Swift Toolchain and SDK Build Tool
[![Build Status](https://github.com/lxbndr/swift-windows-gha/workflows/swift-master/badge.svg)](https://github.com/lxbndr/swift-windows-gha/actions?query=workflow%3Aswift-master) [![Build Status](https://github.com/lxbndr/swift-windows-gha/workflows/swift-5.3/badge.svg)](https://github.com/lxbndr/swift-windows-gha/actions?query=workflow%3Aswift-5.3) [![Build Status](https://github.com/lxbndr/swift-windows-gha/workflows/swift-build-script/badge.svg)](https://github.com/lxbndr/swift-windows-gha/actionshttps://github.com/lxbndr/swift-windows-gha/actions?query=workflow%3Aswift-build-script)

Based on https://github.com/compnerd/swift-build.

### Requirements
- **_Windows 10 RedStone 4 (10.0.17763.0)_** or newer
- **_Developer Mode_**. Enable in _Settings > Update & Security > For developers_. Required to create symlinks without elevation.
- **_Git_**. https://git-scm.com/download/win 
- **_Python 2_**. https://www.python.org/downloads/release/python-2718/. Not used by latest Swift master branch, but still required for 5.3 and older versions. **IMPORTANT: Should be installed to C:\Python27**.
- **_Python 3_**. https://www.python.org/downloads/release/python-385/ 
- **_Visual Studio 2019_**. Any edition. For minimal build system use **_Build Tools_**: https://aka.ms/vs/16/release/vs_buildtools.exe . Required components are:
  - MSVC v142 - VS 2019 C++ x64/x86 build tools
  - Windows 10 SDK
  - C++ CMake tools for Windows
  - C++ ATL for v142 build tools

### Getting Started
1. Run **elevated Command Prompt**. Elevation is required to install clang modules into Visual Studio directory. If you somehow omit this step (e.g. by commenting corresponding script line), elevation is not needed, but make sure you have modues installed already (either manually, or by previous build tool run).
2. Clone this repository (e.g. to `C:\swift-windows-gha`) and CD into it.
3. Run `scripts\configure.cmd`.
4. Answer to all questions with defaults by pressing Enter.
5. Run `scripts\build.cmd`.

### TODO
1. Add detailed description for configuration options.
2. Add Hello World example.
