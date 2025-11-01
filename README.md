Automatically mounts the Android system partitions. After mapping the super partition, if it exists, it tries mounting the vendor, vendor_dlkm, and odm partitions one after the other from a variety of potential locations, verifying each by looking for build property files.

## Steps in the code:
1. Define a method `mount_partition` that takes:
  - `name`: the partition name (used for mount point and in messages)
  - `check`: the file to check for validity (e.g., "/vendor/build.prop")
  - `images`: an array of image/partition files to try mounting.
2. If the check file already exists, return early (already mounted).
3. Otherwise, iterate over the images and for each that exists:
  - Mount it at `/name` (e.g., /vendor) read-only.
  - Check if the check file exists after mounting.
  - If valid, print and break.
  - If not, unmount and try next.
4. For the super partition, if it exists, set up loop device and dynamic partitions.
5. Call `mount_partition` for vendor, vendor_dlkm, and odm.

## License
[GNU License](https://github.com/MelvinSGjr/android-mount/blob/main/LICENSE)
