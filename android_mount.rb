def mount_partition(name, check, images)
  return if File.exist?(check)
  puts "checking for #{name} mount point"
  images.each do |img|
    next unless File.exist?(img)
    puts "mounting #{name} from #{img}"
    system("mount #{img} /#{name} -o ro")
    if File.exist?(check)
      puts "found valid #{name} partition: #{img}"
      break
    else
      puts "#{img} is not a valid #{name} partition"
      system("umount /#{name}")
    end
  end
end

if File.exist?("/userdata/super.img")
  puts "mapping super partition"
  system("losetup -r /dev/loop60 /userdata/super.img")
  system('dmsetup create --concise "$(parse-android-dynparts /dev/loop60)"')
end

mount_partition("vendor", "/vendor/build.prop", [
  "/userdata/vendor.img",
  "/var/lib/lxc/android/vendor.img", 
  "/dev/disk/by-partlabel/vendor#{ENV['ab_slot_suffix']}",
  "/dev/disk/by-partlabel/vendor_a",
  "/dev/disk/by-partlabel/vendor_b",
  "/dev/mapper/dynpart-vendor",
  "/dev/mapper/dynpart-vendor#{ENV['ab_slot_suffix']}",
  "/dev/mapper/dynpart-vendor_a", 
  "/dev/mapper/dynpart-vendor_b"
])

mount_partition("vendor_dlkm", "/vendor_dlkm/etc/build.prop", ["/userdata/vendor_dlkm.img"])
mount_partition("odm", "/odm/etc/build.prop", ["/userdata/odm.img"])
