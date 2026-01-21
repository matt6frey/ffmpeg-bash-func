#!/usr/bin/env bats

setup() {
    # Source the function file
    # Adjust path if your file is in ./functions/.vtrim
    source "./functions/.vtrim"
    
    # Create a dummy input file for testing
    touch "test_video.mp4"
}

teardown() {
    # Clean up any leftover files
    rm -f "test_video.mp4" "test_video.trimmed.mp4"
}

# Mock ffmpeg to simulate success without needing the binary
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
    # We redefine ffmpeg inside the test to verify it was called
    ffmpeg() { 
        echo "ffmpeg called"
        return 0 
    }
    run vtrim "test_video.mp4" "00:01:00" "00:02:00"
    [ "$status" -eq 0 ]
    [[ "${lines[1]}" == "Trim successful."* ]]
}

@test "vtrim handles ffmpeg failure" {
    # Mock ffmpeg to fail
    ffmpeg() { return 1; }
    
    run vtrim "test_video.mp4" "00:01:00" "00:02:00"
    [ "$status" -eq 1 ]
    [[ "${lines[1]}" == "Error: ffmpeg failed."* ]]
    [ -f "test_video.mp4" ] # Original should still exist
}
