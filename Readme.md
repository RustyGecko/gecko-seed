# Gecko Seed project

This project constains some seed files for starting a Rust project for the EFM32GG microcontrollers using emlib.

## Usage

```shell
# Create a new Rust project
$ cargo new <project-name> --bin
$ cd <project-name>

# Copy seed files
git clone git@github.com:RustyGecko/gecko-seed.git seed
```

Add the following to the `Cargo.toml`.

```toml
[target.thumbv7m-none-eabi.dependencies.core]
git = "https://github.com/RustyGecko/rust-core.git"

[[target.thumbv7m-none-eabi.dependencies.emlib]
git = "https://github.com/RustyGecko/emlib.git"
features = ["stk3700"]
```
Use `dk3750` if you are developing for the Development kit.

Now edit the `src/main.rs`  to run without `libstd` and with `libcore` and `emlib`.

```rust
#![no_std]
#![no_main]
#![feature(lang_items, start, core, no_std)]

#[macro_use]
extern crate core;
extern crate emlib;

use emlib::chip;

fn main() {
    chip::init();
    loop {}
}
```

The binary can now be built with a simple `make`.