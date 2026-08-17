#!/bin/sh

out_w=2880
out_h=1620
fsr_scale=100

error() {
  echo "windowed: error: $*" >&2
}

usage() {
  cat <<'EOF'
Usage:
  windowed.sh [OPTIONS] -- COMMAND [ARGS...]

Options:
  --fsr PERCENT    Render at PERCENT of the output resolution and upscale
                   with FSR (25-100). 100 disables FSR.
  -h, --help       Show this help.

Examples:
  windowed.sh --fsr 80 -- %command%
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;
    --fsr)
      if [ $# -lt 2 ]; then
        error "--fsr requires a percentage"
        exit 1
      fi
      fsr_scale="$2"
      shift 2
      ;;
    --fsr=*)
      fsr_scale="${1#--fsr=}"
      shift
      ;;
    --)
      shift
      break
      ;;
    *)
      break
      ;;
  esac
done

fsr_scale="${fsr_scale%\%}"

case "$fsr_scale" in
  ''|*[!0-9]*)
    error "invalid --fsr value: $fsr_scale"
    exit 1
    ;;
esac

if [ "$fsr_scale" -lt 25 ] || [ "$fsr_scale" -gt 100 ]; then
  error "--fsr must be between 25 and 100"
  exit 1
fi

if [ $# -eq 0 ]; then
  error "missing COMMAND"
  echo "Try 'windowed.sh --help' for usage." >&2
  exit 1
fi

# gamescope dislikes odd dimensions, so round down to a multiple of 2.
render_w=$(((out_w * fsr_scale / 100) / 2 * 2))
render_h=$(((out_h * fsr_scale / 100) / 2 * 2))

if [ "$fsr_scale" -lt 100 ]; then
  set -- -F fsr --sharpness 2 -- "$@"
else
  set -- -- "$@"
fi

exec gamescope \
  -w "$render_w" \
  -h "$render_h" \
  -W "$out_w" \
  -H "$out_h" \
  -b \
  -o 60 \
  -s 2.5 \
  --force-grab-cursor \
  --hdr-enabled \
  --cursor-scale-height "$out_h" \
  --backend sdl \
  "$@"
