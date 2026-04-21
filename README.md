# Clite
To use Clite clone this repository using git clone, open the terminal and use the following command:
```bash
> make install-release
```

Then, to use Clite, just use the command `clite`:
```bash
> clite
== test chunk ==
0000 OP_RETURN
```

Use make help to see instructions on building the program:

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