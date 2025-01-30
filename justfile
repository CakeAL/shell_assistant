default: 
    @just --list

alias b := build
alias d := dev

build: 
    flutter build macos --release

dev: 
    flutter run

build-all: 
    

clippy: 
    cd rust && cargo clippy

clean: 
    cd rust && cargo clean && cd .. && flutter clean

watch: 
    flutter_rust_bridge_codegen generate --watch

get: 
    flutter pub get