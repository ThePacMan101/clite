# C project Makefile
# - Compiles sources in `src/` to `build/`
# - Links to executable `clite` in build/
# - Provides compile, install, uninstall, clean, and help targets

# Project layout
PROJECT   := clite
SRC_DIR   := src
BIN_DIR   ?= $(HOME)/.local/bin

# Compiler and flags
CC           := gcc
CFLAGS_DEBUG := -Wall -g
CFLAGS_RELEASE := -Wall -Wextra -O3

# Debug build (default)
BUILD_DEBUG_DIR   := build/debug
SOURCES           := $(wildcard $(SRC_DIR)/*.c)
OBJECTS_DEBUG     := $(patsubst $(SRC_DIR)/%.c,$(BUILD_DEBUG_DIR)/%.o,$(SOURCES))
EXECUTABLE_DEBUG  := $(BUILD_DEBUG_DIR)/$(PROJECT)

# Release build
BUILD_RELEASE_DIR := build/release
OBJECTS_RELEASE   := $(patsubst $(SRC_DIR)/%.c,$(BUILD_RELEASE_DIR)/%.o,$(SOURCES))
EXECUTABLE_RELEASE := $(BUILD_RELEASE_DIR)/$(PROJECT)

.PHONY: compile debug release clean help install install-debug install-release uninstall

# Default target (always debug)
all: install-release

# Debug build target
debug: compile
	@true

# Release build target
release: $(EXECUTABLE_RELEASE)
	@echo "Build complete (release): $(EXECUTABLE_RELEASE)"

# Compile: always builds debug version
compile: $(EXECUTABLE_DEBUG)
	@echo "Build complete (debug): $(EXECUTABLE_DEBUG)"

# Debug executable
$(EXECUTABLE_DEBUG): $(OBJECTS_DEBUG)
	@mkdir -p $(BUILD_DEBUG_DIR)
	$(CC) $(CFLAGS_DEBUG) -o $@ $^

# Debug object files
$(BUILD_DEBUG_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(BUILD_DEBUG_DIR)
	$(CC) $(CFLAGS_DEBUG) -c -o $@ $<

# Release executable
$(EXECUTABLE_RELEASE): $(OBJECTS_RELEASE)
	@mkdir -p $(BUILD_RELEASE_DIR)
	$(CC) $(CFLAGS_RELEASE) -o $@ $^

# Release object files
$(BUILD_RELEASE_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(BUILD_RELEASE_DIR)
	$(CC) $(CFLAGS_RELEASE) -c -o $@ $<

# Install executable to PATH (defaults to release)
install: install-release

# Install debug version
install-debug: $(EXECUTABLE_DEBUG)
	@mkdir -p $(BIN_DIR)
	@cp $(EXECUTABLE_DEBUG) $(BIN_DIR)/$(PROJECT)
	@chmod +x $(BIN_DIR)/$(PROJECT)
	@echo "Installed (debug): $(BIN_DIR)/$(PROJECT)"
	@if ! grep -q '$$HOME/.local/bin' ~/.bashrc 2>/dev/null || ! grep -q '$$HOME/.local/bin' ~/.profile 2>/dev/null; then \
		echo 'export PATH="$$HOME/.local/bin:$$PATH"' >> ~/.bashrc; \
		echo "Added ~/.local/bin to PATH in ~/.bashrc"; \
	else \
		echo "PATH already configured"; \
	fi

# Install release version
install-release: $(EXECUTABLE_RELEASE)
	@mkdir -p $(BIN_DIR)
	@cp $(EXECUTABLE_RELEASE) $(BIN_DIR)/$(PROJECT)
	@chmod +x $(BIN_DIR)/$(PROJECT)
	@echo "Installed (release): $(BIN_DIR)/$(PROJECT)"
	@if ! grep -q '$$HOME/.local/bin' ~/.bashrc 2>/dev/null || ! grep -q '$$HOME/.local/bin' ~/.profile 2>/dev/null; then \
		echo 'export PATH="$$HOME/.local/bin:$$PATH"' >> ~/.bashrc; \
		echo "Added ~/.local/bin to PATH in ~/.bashrc"; \
	else \
		echo "PATH already configured"; \
	fi

# Uninstall executable from PATH
uninstall:
	@rm -f $(BIN_DIR)/$(PROJECT)
	@echo "Removed: $(BIN_DIR)/$(PROJECT)"

# Clean build artifacts
clean:
	@rm -rf build/
	@echo "Cleaned all build directories"

# Friendly help output
help:
	@echo ""
	@echo "Build targets:"
	@echo "  make            Compile in debug mode (default)"
	@echo "  make debug      Compile in debug mode"
	@echo "  make release    Compile in release mode (-Wall -Wextra -O3)"
	@echo "  make compile    Compile to debug executable"
	@echo ""
	@echo "Install targets:"
	@echo "  make install              Build and install release version (default)"
	@echo "  make install-debug        Build and install debug version"
	@echo "  make install-release      Build and install release version"
	@echo ""
	@echo "Utility:"
	@echo "  make uninstall  Remove executable from $(BIN_DIR)"
	@echo "  make clean      Remove all build artifacts"
	@echo "  make help       Show this help message"
