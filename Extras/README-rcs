This is a quick tutorial for simple use of RCS with some basic aliases
that will do everything you need almost all of the time.

The RCS commands are all athena standard.

To conveniently deal with using the right options with the default
commands, add the following 4 aliases to your .cshrc.mine file:

  alias checkout 'co -l'
  alias checkin 'ci -u'
  alias update 'ci -l'
  alias steal 'rcs -l \!^; ci \!^; co -l \!^;'

Logging out and back in is the simplest way to make this take effect.



More Information:

When using RCS, you still work in the same directory as your files,
while RCS stores backups and revision histories for the files (usually
in a RCS/ subdir).  If a working version of a file is accidently
deleted, simply checking it out and back in will restore the most
recent revision (you can also revert to older revisions; see the man
pages).

To learn the basics of how RCS works, read the 'rcsintro' man pages.
For more detail, read the 'rcs,' 'ci,' and 'co' man pages.




Checking Out/In Files:

When files are checked in, they are read-only.  You can run latex on
them, other files can \input them, etc.

In the dir that contains a file you want to work on, type:

  checkout filename

to check the file out (you will have write access) and lock it (others
can't check it out themselves while you have it locked).  If someone
else has the file locked, rcs will tell you.

Once you have made your changes, type:

  checkin filename

to check in the changes.  You'll be prompted for an description of the
changes you've made, and then the file will be unlocked.  It will
still be in the directory, read-only.

If you want to checkin changes to the file for back-up, but keep
editing, type:

  update filename

which will keep the file locked, so others still can't edit it.  Even
when you haven't checked in a file recently, the present saved
contents are available to all, read-only.




Making New Files:

Create new files as normal.  Then you can check it in for the first
time by typing:

  checkin filename

which will create the first revision.




Making New Directories:

Create a new directory as normal:

  mkdir dirname

Inside it, make an RCS subdir:

  cd dirname
  mkdir RCS

You're done.




Stealing Locks:

When you're done editing a file, _always remember to check it in_.
However, if someone has checked out a file and since logged out
without checking it in, you can "steal" the lock by typing:

  steal filename

You will be prompted for a reason for stealing the lock, which will be
emailed to the user who had it locked in the first place.  This will
steal the lock, checkin the changes the previous owner made, and check
the file out to you.  You will now own the lock.

_Don't steal locks unless you have to.  And again, don't leave files
locked when you logout_.




Viewing File History:

To view the RCS info for a file, including revision history, type:

  rlog filename

This is where you can read what users typed when describing changes
they made when they checked in the file.
