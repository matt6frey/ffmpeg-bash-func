#!/usr/bin/env bats

setup() {
    # 1. Get the absolute path to the project root
    # $BASH_SOURCE is the path to this .bats file
    REPODIR="$(cd "$(dirname "$BASH_SOURCE")/../.." && pwd)"
    
    source "$REPODIR/functions/.vtrim"
    
    TEST_TEMP_DIR="$(mktemp -d)"
    cd "$TEST_TEMP_DIR"
    touch "test_video.mp4"
}

teardown() {
    rm -rf "$TEST_TEMP_DIR"
}

# Mock ffmpeg
ffmpeg() {
    return 0
}

@test "vtrim displays help with -h" {
    run vtrim -h
    [ "$status" -eq 0 ]
    [[ "${lines[0]}" == "Usage: vtrim"* ]]
}

@test "vtrim displays help with no arguments" {
    run vtrim
    [ "$status" -eq 0 ]
    [[ "${lines[0]}" == "Usage: vtrim"* ]]
}

@test "vtrim attempts to process file and calls ffmpeg" {
    ffmpeg() { 
        touch "test_video.trimmed.mp4"
        return 0 
    }
    run vtrim "test_video.mp4" "00:01:00" "00:02:00"
    [ "$status" -eq 0 ]
    [[ "${lines[1]}" == "Trim successful."* ]]
}

@test "vtrim handles ffmpeg failure" {
    ffmpeg() { return 1; }
    run vtrim "test_video.mp4" "00:01:00" "00:02:00"
    [ "$status" -eq 1 ]
    [[ "${lines[1]}" == "Error: ffmpeg failed."* ]]
    [ -f "test_video.mp4" ] 
}
