/atom/test

/datum/test

/mob/test

/atom/movable/test

/world/New()
	world.log << "kind of works!"
	var/x = new /mob/test()
	del(x)
// ok comments also work!
