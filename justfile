default: 
    @just --list

alias b := build
alias d := dev
alias ba := build-all

build: 
    cargo tauri build

dev: 
    cargo tauri dev

build-all: 
    

clippy: 
    cd rust && cargo clippy

clean: 
    cd rust && cargo clean

watch: 
    flutter_rust_bridge_codegen generate --watch