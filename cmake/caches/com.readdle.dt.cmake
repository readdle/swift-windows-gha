
# --- global settings ---

set(LLVM_ENABLE_PROJECTS
      clang
      clang-tools-extra
      lld
      lldb
    CACHE STRING "")

set(LLVM_EXTERNAL_PROJECTS
      cmark
      swift
    CACHE STRING "")

set(LLVM_ENABLE_RUNTIMES
      compiler-rt
    CACHE STRING "")

# --- compiler-rt ---

set(COMPILER_RT_BUILD_CRT NO CACHE BOOL "")
set(COMPILER_RT_BUILD_LIBFUZZER NO CACHE BOOL "")
set(COMPILER_RT_BUILD_PROFILE YES CACHE BOOL "")
set(COMPILER_RT_BUILD_SANITIZERS NO CACHE BOOL "")
set(COMPILER_RT_BUILD_XRAY NO CACHE BOOL "")

# --- LLVM ---

set(LLVM_ENABLE_ASSERTIONS YES CACHE BOOL "")

set(PACKAGE_VENDOR "Readdle" CACHE STRING "")
set(CLANG_VENDOR "Readdle" CACHE STRING "")
set(CLANG_VENDOR_UTI "com.readdle.dt" CACHE STRING "")

set(LLVM_APPEND_VC_REV NO CACHE BOOL "")
set(LLVM_VERSION_SUFFIX "" CACHE STRING "")

set(LLVM_TARGETS_TO_BUILD AArch64 ARM WebAssembly X86 CACHE STRING "")

set(LLVM_INCLUDE_BENCHMARKS NO CACHE BOOL "")
set(LLVM_INCLUDE_DOCS NO CACHE BOOL "")
set(LLVM_INCLUDE_EXAMPLES NO CACHE BOOL "")
set(LLVM_INCLUDE_GO_TESTS NO CACHE BOOL "")
set(LLVM_TOOL_GOLD_BUILD NO CACHE BOOL "")
set(LLVM_ENABLE_OCAMLDOC NO CACHE BOOL "")
set(LLVM_ENABLE_LIBXML2 NO CACHE BOOL "")
set(LLVM_ENABLE_ZLIB NO CACHE BOOL "")

set(ENABLE_X86_RELAX_RELOCATIONS YES CACHE BOOL "")

set(LLVM_INSTALL_BINUTILS_SYMLINKS YES CACHE BOOL "")

set(LLVM_BUILD_LLVM_DYLIB NO CACHE BOOL "")
set(LLVM_BUILD_LLVM_C_DYLIB NO CACHE BOOL "")
set(LLVM_TOOL_LLVM_SHLIB_BUILD NO CACHE BOOL "")

# set(LLVM_ENABLE_PDB YES CACHE BOOL "")

set(LLVM_INSTALL_TOOLCHAIN_ONLY YES CACHE BOOL "")
set(LLVM_TOOLCHAIN_TOOLS
      addr2line
      ar
      c++filt
      dsymutil
      dwp
      # lipo
      llvm-ar
      llvm-cov
      llvm-cvtres
      llvm-cxxfilt
      llvm-dlltool
      llvm-dwarfdump
      llvm-dwp
      llvm-lib
      llvm-lipo
      llvm-mt
      llvm-nm
      llvm-objcopy
      llvm-objdump
      llvm-pdbutil
      llvm-profdata
      llvm-ranlib
      llvm-rc
      llvm-readelf
      llvm-readobj
      llvm-size
      llvm-strings
      llvm-strip
      llvm-symbolizer
      llvm-undname
      nm
      objcopy
      objdump
      ranlib
      readelf
      size
      strings
    CACHE STRING "")

set(CLANG_TOOLS
      clang
      clangd
      clang-format
      clang-resource-headers
      # clang-rename
      # clang-reorder-fields
      clang-tidy
      # modularize
    CACHE STRING "")

# --- lld ---
set(LLD_TOOLS
      lld
    CACHE STRING "")

# --- lldb ---

set(LLDB_ALLOW_STATIC_BINDINGS YES CACHE BOOL "")
set(LLDB_USE_STATIC_BINDINGS YES CACHE BOOL "")

if(SWIFT_BUILD_DISABLE_LLDB_PYTHON_SCRIPTS)
  set(LLDB_TOOLS
        liblldb
        lldb
        lldb-argdumper
        lldb-server
        lldb-vscode
        repl_swift
      CACHE STRING "")
else()
  set(LLDB_TOOLS
        liblldb
        lldb
        lldb-argdumper
        lldb-python-scripts
        lldb-server
        lldb-vscode
        repl_swift
      CACHE STRING "")
endif()

# --- swift ---

set(SWIFT_VENDOR "Readdle" CACHE STRING "")
set(SWIFT_INCLUDE_DOCS NO CACHE BOOL "")
set(SWIFT_BUILD_SOURCEKIT YES CACHE BOOL "")

set(SWIFT_BUILD_STATIC_STDLIB NO CACHE BOOL "")
set(SWIFT_BUILD_STATIC_SDK_OVERLAY NO CACHE BOOL "")

set(SWIFT_BUILD_DYNAMIC_STDLIB NO CACHE BOOL "")
set(SWIFT_BUILD_DYNAMIC_SDK_OVERLAY NO CACHE BOOL "")

if(BUILD_SOURCEKIT_XPC)
  set(SOURCEKIT_COMPONENT sourcekit-xpc-service)
else()
  set(SOURCEKIT_COMPONENT sourcekit-inproc)
endif()

set(PARSER_LIB_COMPONENT)
if(SWIFT_BUILD_ENABLE_PARSER_LIB)
  set(PARSER_LIB_COMPONENT parser-lib)
endif()

set(SWIFT_INSTALL_COMPONENTS
      autolink-driver
      compiler
      clang-builtin-headers
      editor-integration
      tools
      ${SOURCEKIT_COMPONENT}
      swift-remote-mirror
      swift-remote-mirror-headers
      ${PARSER_LIB_COMPONENT}
    CACHE STRING "")

set(LLVM_DISTRIBUTION_COMPONENTS
      IndexStore
      libclang
      libclang-headers
      LTO
      ${LLVM_TOOLCHAIN_TOOLS}
      ${CLANG_TOOLS}
      ${LLD_TOOLS}
      ${LLDB_TOOLS}
      ${SWIFT_INSTALL_COMPONENTS}
   CACHE STRING "")
