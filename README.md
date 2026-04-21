# Clite

Use make help to see instruction on building the project

```bash
> make help

Build targets:
  make            Compile in debug mode (default)
  make debug      Compile in debug mode
  make release    Compile in release mode (-Wall -Wextra -O3)
  make compile    Compile to debug executable

Install targets:
  make install              Build and install release version (default)
  make install-debug        Build and install debug version
  make install-release      Build and install release version

Utility:
  make uninstall  Remove executable from /root/.local/bin
  make clean      Remove all build artifacts
  make help       Show this help message
```