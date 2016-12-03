# the building blocks of wrytr

The app uses a the [cordux](https://github.com/willowtreeapps/cordux) framework 
(which combines [Khanlou's coordinator pattern]() with a port of [Dan Aberhov's Redux]() written in swift.

It's also inspired from a less verbose version of VIPER: 



wherein there exists a `route` (supplied by cordux), 
and the coordinators know how to bind to and transition between different routes.
