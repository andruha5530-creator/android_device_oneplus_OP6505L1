Winlator I/O Boost v2.1

Safe universal mode:
- detects Winlator packages automatically;
- tunes the block device backing /data to read_ahead_kb=4096 when lower;
- applies best-effort ionice to running Winlator processes;
- discovers D:/F: symlink targets and logs /storage/emulated/0 -> /data/media/0 candidates;
- never performs a blind global bind mount, because Android FUSE/scoped-storage
  behavior differs across ROMs.

Log: /data/adb/winlator_io_boost.log
