HeartbeatRails.configure do |c|
    # Customize where the engine is mounted, default is `/heartbeat`
    c.mount_on '/heartbeat'
    # Customize where the route is mounted
    # c.append_route!   # default if not specified
    # c.prepend_route!  # to prepend the engine route
    # c.dont_mount!     # if you want to manually mount the route in whatever position
  end