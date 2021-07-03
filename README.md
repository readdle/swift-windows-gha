# Swift Toolchain and SDK Build Tool
[![Build Status](https://github.com/readdle/swift-windows-gha/workflows/swift-main/badge.svg)](https://github.com/readdle/swift-windows-gha/actions?query=workflow%3Aswift-main) [![Build Status](https://github.com/readdle/swift-windows-gha/workflows/swift-5.4/badge.svg)](https://github.com/readdle/swift-windows-gha/actions?query=workflow%3Aswift-5.4) [![Build Status](https://github.com/readdle/swift-windows-gha/workflows/swift-5.3/badge.svg)](https://github.com/readdle/swift-windows-gha/actions?query=workflow%3Aswift-5.3) [![Build Status](https://github.com/readdle/swift-windows-gha/workflows/swift-build-script/badge.svg)](https://github.com/readdle/swift-windows-gha/actionshttps://github.com/readdle/swift-windows-gha/actions?query=workflow%3Aswift-build-script)

![Swift on Windows](doc/img/swift-windows-cover.png)
_Based on [//swift/build](https://github.com/compnerd/swift-build) project_

### Project Goals
Swift is a large project consisting of many parts. When it comes to changing or investigate something located in, for example, Swift Foundation library, it is crucial to have quick and robust way to rebuild only that part.

The goals of this project are to:
- Provide a tool to build and experiment with Swift (Toolchain and SDK) on Windows in convenient way on local developer machine
- Provide binary snapshots of dev and release versions of vanilla Swift, as well as customized version by Readdle
- Provide convenient code/script blocks to integrate Swift build process in arbitrary CI/CD flow

### Requirements
- **_Windows 10 RedStone 4 (10.0.17763.0)_** or newer
- **_Developer Mode_**. Enable in _Settings > Update & Security > For developers_. Required to create symlinks without elevation.
- **_Git_**. https://git-scm.com/download/win (or VS component Microsoft.VisualStudio.Component.Git)
- **_Python 3_**. https://www.python.org/downloads/release/python-385/ 
- **_Visual Studio 2019_**. Any edition. Use most recent version, or version from latest successfull check. For minimal build system use **_Build Tools_**: https://aka.ms/vs/16/release/vs_buildtools.exe. Required components are:
  - MSVC v142 - VS 2019 C++ x64/x86 build tools (Microsoft.VisualStudio.Component.VC.Tools.x86.x64)
  - C++ ATL for v142 build tools (Microsoft.VisualStudio.Component.VC.ATL)
  - Windows 10 SDK (Microsoft.VisualStudio.Component.Windows10SDK.17763 or newer)
  - C++ CMake tools for Windows (Microsoft.VisualStudio.Component.VC.CMake.Project)

### Additional Requirements (Swift 5.3)
- **_Python 2_**. https://www.python.org/downloads/release/python-2718/. **IMPORTANT: Should be installed to C:\Python27**.
- **_Visual Studio 2019_**. Components:
  - MSVC v142 - VS 2019 C++ x64/x86 build tools (v14.28-16.9) (Microsoft.VisualStudio.Component.VC.14.28.16.9.x86.x64)
  - C++ v14.28 (16.9) ATL for v142 build tools (x86 & x64) (Microsoft.VisualStudio.Component.VC.14.28.16.9.ATL)
  

### Getting Started
1. Run **elevated Command Prompt**. Elevation is required to install clang modules into Visual Studio directory. If you somehow omit this step (e.g. by commenting corresponding script line), elevation is not needed, but make sure you have modues installed already (either manually, or by previous build tool run).
2. Clone this repository (e.g. to `C:\swift-windows-gha`) and CD into it. Note: don't put it deeply into directory structure, or you will probably get build errors due to file path length restrictions.
3. Run `scripts\configure.cmd`.
4. Answer to all questions with defaults by pressing Enter.
5. Run `scripts\build.cmd`.

Just toolchain alone contains more than 5000 sources to build, so be patient. Build takes about 40 minutes on 3.2GHz 8-core CPU, more than a hour on VM under MacBook Pro 2017, and about 6 hours on GitHub Actions cloud agent.

In the end you will get `Library` folder at the default output path, which contains all built products as well as some intermediates.

### Coming Soon...
- Build process details
- Build configuration options
- How-To: Working on SDK
- Troubleshooting
