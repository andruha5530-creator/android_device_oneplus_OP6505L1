#!/system/bin/sh
MODDIR=${0%/*}
LOG=/data/adb/winlator_io_boost.log
exec >>"$LOG" 2>&1
echo "=== Winlator I/O Boost v2.1 ==="
date
i=0
while [ "$i" -lt 60 ]; do
  [ "$(getprop sys.boot_completed 2>/dev/null)" = "1" ] && break
  sleep 2
  i=$((i+1))
done
sleep 5

DATA_SRC="$(findmnt -no SOURCE /data 2>/dev/null | head -n 1)"
echo "[*] /data source: $DATA_SRC"

tune_block() {
  dev="$1"
  [ -b "$dev" ] || return
  real="$(readlink -f "$dev" 2>/dev/null)"
  name="$(basename "$real")"
  sys="/sys/block/$name"
  [ -d "$sys" ] || return
  ra="$sys/queue/read_ahead_kb"
  if [ -w "$ra" ]; then
    old="$(cat "$ra" 2>/dev/null)"
    if [ "$old" -lt 4096 ] 2>/dev/null; then
      echo 4096 > "$ra" 2>/dev/null && echo "[+] $name read_ahead_kb $old -> 4096"
    else
      echo "[=] $name read_ahead_kb=$old"
    fi
  fi
  for s in "$sys"/slaves/*; do
    [ -e "$s" ] && tune_block "/dev/block/$(basename "$s")"
  done
}
case "$DATA_SRC" in /dev/*) tune_block "$DATA_SRC";; esac

PKGS=""
for d in /data/user/0/* /data/data/*; do
  [ -d "$d" ] || continue
  n=${d##*/}
  case "$n" in *winlator*|*Winlator*) PKGS="$PKGS $n";; esac
done
[ -n "$PKGS" ] || { echo "[!] Winlator not found."; exit 0; }
echo "[+] Winlator packages:$PKGS"

for pkg in $PKGS; do
  for pid in $(pidof "$pkg" 2>/dev/null); do
    ionice -c 2 -n 0 -p "$pid" 2>/dev/null && echo "[+] ionice $pkg PID $pid"
  done
  app="/data/user/0/$pkg"
  [ -d "$app" ] || app="/data/data/$pkg"
  for dd in "$app"/files "$app"/files/containers "$app"/files/imagefs; do
    [ -d "$dd" ] || continue
    find "$dd" -type l \( -name 'd:' -o -name 'f:' -o -name 'D:' -o -name 'F:' \) 2>/dev/null |
    while IFS= read -r link; do
      target="$(readlink "$link" 2>/dev/null)"
      echo "[drive] $link -> $target"
      case "$target" in
        /storage/emulated/0/*)
          rel="${target#/storage/emulated/0/}"
          real="/data/media/0/$rel"
          [ -e "$real" ] && echo "[candidate] $target -> $real"
        ;;
      esac
    done
  done
done
echo "[*] Done."
