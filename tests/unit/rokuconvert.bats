#!/usr/bin/env bats

setup() {
    # Resolve project root and source functions
    REPODIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/../.." && pwd)"
    source "$REPODIR/.main_functions"
    
    # Create temp sandbox
    TEST_TEMP_DIR="$(mktemp -d)"
    cd "$TEST_TEMP_DIR" || exit 1
    touch "test_input.mkv"
}

teardown() {
    rm -rf "$TEST_TEMP_DIR"
}

# Mock ffmpeg
ffmpeg() {
    # Simulate ffmpeg creating the output file
    # The last argument in your function is "$2".mp4
    # We grab the last argument from the command line
    for last; do true; done
    touch "$last"
    return 0
}

@test "rokuconvert fails with no arguments" {
    run rokuconvert
    [ "$status" -eq 1 ]
    [[ "${lines[0]}" == "Usage: rokuconvert"* ]]
}

@test "rokuconvert fails with only one argument" {
    run rokuconvert "video.mkv"
    [ "$status" -eq 1 ]
    [[ "${lines[0]}" == "Usage: rokuconvert"* ]]
}

@test "rokuconvert successfully triggers ffmpeg and creates mp4" {
    run rokuconvert "test_input.mkv" "output_name"
    [ "$status" -eq 0 ]
    [ -f "output_name.mp4" ]
}

@test "rokuconvert passes correct codec parameters to ffmpeg" {
    # Redefine mock to inspect arguments
    ffmpeg() {
        echo "$*"
        return 0
    }
    run rokuconvert "input.mkv" "output"
    # Verify key Roku-compatible flags are present
    [[ "$output" == *"libx264"* ]]
    [[ "$output" == *"aac"* ]]
    [[ "$output" == *"+faststart"* ]]
}