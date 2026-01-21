#!/usr/bin/env bats

setup() {
    # Use BATS_TEST_FILENAME to find the script location
    # tests/unit/vtrim.bats -> go up 2 levels to reach root
    REPODIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/../.." && pwd)"
    
    # Check if file exists before sourcing to prevent silent failures
    if [ ! -f "$REPODIR/functions/.vtrim" ]; then
        echo "Error: Cannot find $REPODIR/functions/.vtrim" >&2
        return 1
    fi

    source "$REPODIR/functions/.vtrim"
    
    TEST_TEMP_DIR="$(mktemp -d)"
    cd "$TEST_TEMP_DIR" || exit 1
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
