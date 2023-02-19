# Swift Toolchain and SDK Build Tool
![Swift on Windows](doc/img/swift-windows-cover.png)
_Based on [//swift/build](https://github.com/compnerd/swift-build) project_

### Project Goals
Swift is a large project consisting of many parts. When it comes to changing or investigating the project, it is crucial to have a comfortable way to tweak the build process.

The goals of this project are to:
- Provide a tool to build and experiment with Swift (Toolchain and SDK) on Windows in a convenient way on a local developer machine.
- Provide binary snapshots of dev and release versions of vanilla Swift, as well as customized versions by Readdle.
- Provide convenient code/script blocks to integrate Swift's build process in an arbitrary CI/CD flow.

### Requirements
- **_Windows 10 RedStone 4 (10.0.17763.0)_** or newer
- **_Developer Mode_**. Enable in _Settings > Update & Security > For developers_. Required to create symlinks without elevation.
- **_Git_**. https://git-scm.com/download/win
- **_Python 3.9_**. https://www.python.org/downloads/release/python-399/
- **_Visual Studio 2022_**. Any edition. Use most recent version, or version from latest successfull check. For minimal build system use **_Build Tools_**: https://aka.ms/vs/17/release/vs_BuildTools.exe. Required components are:
  - MSVC v142 - VS 2022 C++ x64/x86 build tools (_Microsoft.VisualStudio.Component.VC.Tools.x86.x64_)
  - C++ ATL for v142 build tools (_Microsoft.VisualStudio.Component.VC.ATL_)
  - Windows 10 SDK (_Microsoft.VisualStudio.Component.Windows10SDK.18362_ or newer)
  - C++ CMake tools for Windows (_Microsoft.VisualStudio.Component.VC.CMake.Project_). Note that sometimes it is required to use a specific standalone version of CMake. You can always check the [Actions](https://github.com/readdle/swift-windows-gha/actions/workflows/swift.yml) page and look into any fresh build run environment.

### Getting Started
1. Run **elevated Command Prompt**. Elevation is required to install clang modules into Visual Studio directory. If you somehow omit this step (e.g. by commenting corresponding script line), elevation is not needed, but make sure you have modues installed already (either manually, or by previous build tool run).
2. Clone this repository (e.g. to `C:\swift-windows-gha`) and CD into it. Note: don't put it deeply into directory structure, or you will probably get build errors due to file path length restrictions. Or use `subst` command to create a virtual drive from the build directory.
3. Run `scripts\configure.cmd`.
4. Answer to all questions with defaults by pressing Enter. Except the Python path - please specify the full path to Python installation directory, without quotes.
5. Run `scripts\build.cmd`.

Just toolchain alone contains more than 5000 sources to build, so be patient. Build takes about 40 minutes on 3.2GHz 8-core CPU, more than a hour on VM under MacBook Pro 2017, and about 6 hours on GitHub Actions cloud agent.

In the end you will get `Library` folder at the default output path, which contains all built products as well as some intermediates.
