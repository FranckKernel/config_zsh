#!/usr/bin/env zsh

# ⚙️ ESP32 Arduino CLI flash helper
# Compiles and uploads a sketch folder containing a .ino file
espflash() {
	local file="$1"
	local fqbn="esp32:esp32:esp32s3"
	local port="/dev/ttyACM0"

	if [[ -z "$file" ]]; then
		echo "Usage: espflash <file.ino>"
		return 1
	fi

	if [[ ! -f "$file" ]]; then
		echo "Error: file not found -> $file"
		return 1
	fi

	local dir
	dir=$(dirname "$file")

	echo "🔧 Compiling sketch: $file"
	arduino-cli compile --fqbn "$fqbn" "$dir" --clean
	if [[ $? -ne 0 ]]; then
		echo "❌ Compile failed"
		return 1
	fi

	echo "🚀 Uploading to board ($port)"
	arduino-cli upload -p "$port" --fqbn "$fqbn" "$dir"
	if [[ $? -ne 0 ]]; then
		echo "❌ Upload failed"
		return 1
	fi

	echo "✅ Done flashing ESP32"
}

# Only run if executed directly (not sourced)
if [[ "${ZSH_EVAL_CONTEXT}" == "toplevel" ]]; then
	espflash "$@"
fi
