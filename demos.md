Demos
=====


Make sure rebase.autoStash is disabled.

Have a fork of linux ready.


1 git help
----------

    # List of common commands
    git help
    # Full list of git commands
    git help -a
    # git help <commind>
    git help log

High quality reference material, but not very good tutorials. Start with
Google, then read the relevant man pages.


2 git init
----------

    git init
    ls -a
    tree .git
    git commit --allow-empty -m 'Initial commit'

It is customary to start off a git repo with an empty commit. In this case,
adding a single empty file. This makes it easier to rewrite history near the
beginning of your repo.


3 Three Stage Thinking
----------------------

    ls
    cat hello.c
    git status
    git log
    # Add #include <stdio.h>
    # Change to "Hello Class\n"
    vi hello.c
    git status
    git diff
    # Use git add to stage files. Unlike svn add, this is used more than once.
    # Stage stdio change
    git add -p
    git status
    git diff
    git diff --staged
    git commit # -m 'Include stdio'
    git log
    git log -p
    git status
    git add hello.c
    git status
    git diff
    git diff --staged
    git commit # -m 'Hello Class'
    git log -p
    git status


4 Trees, Hashes, and Blobs
--------------------------

    tree -a
    git add hello.c
    git status
    tree -a
    cat .git/objects/<sha>
    git cat-file -p <sha>
    # Simple file format that has been zipped. ASCII. Starts with blob, then
    # the number of bytes, then the file contents
    perl -MCompress::Zlib -e 'undef $/; print uncompress(<>)' .git/objects/<sha>
    # In summary, `git add` adds blobs to the database
    rm hello.c
    git status
    git cat-file -p <sha>
    git checkout -- hello.c
    ls
    git status
    # As long as you've added a file, that snapshot is in your database
    git commit -m 'Add hello'
    tree -a
    git cat-file -p <commit>
    git cat-file -p <tree>
    git cat-file -p <blob>
    mv hello.c hola.c
    git add hola.c
    # Renaming a file does not add any new objects
    tree -a
    # This adds a commit object and a tree object. Now we have 5 objects.
    git commit -m 'hola'
    # See that the tree points to the same blob twice.
    git cat-file -p <tree>


5 git rebase --interactive
--------------------------

    git lol
    git rebase -i <Initial commit sha>

Opens your editor with a list of commits. The order is the OPPOSITE as git log.
`git rebase -i` puts the oldest commit on the top.

It presents you with a list of options.

    # Commands:
    #  p, pick = use commit
    #  r, reword = use commit, but edit the commit message
    #  e, edit = use commit, but stop for amending
    #  s, squash = use commit, but meld into previous commit
    #  f, fixup = like "squash", but discard this commit's log message
    #  x, exec = run command (the rest of the line) using shell

Reword a commit

    git lol
    git rebase -i HEAD~7

Reorder a couple commits

    git lol
    git rebase -i <Initial commit sha>

Delete a commit

    git lol
    git rebase -i <Initial commit sha>

Squash two commits together

    git lol
    git rebase -i <Initial commit sha>

Fixup two commits together

    git lol
    git rebase -i <Initial commit sha>

Let's split the commit we just fixuped.

    git help rebase
    /SPLITTING

Edit the commit. Read the prompt when stopped for editing.

    You can amend the commit now, with

        git commit --amend

    Once you are satisfied with your changes, run

        git rebase --continue

We're currently at the commit we marked to edit.

    git status
    # interactive rebase in progress; onto 8db6b4a
    git lol
    git log -p

Undo the commit

    git help reset

--soft undos the commit, --mixed undos the add and commit, --hard drops all
changes to tracked files. Similar to `svn revert `. Be careful!

    git reset HEAD~1
    git status
    git add a.txt
    git commit -m 'Add a.txt'
    git add b.txt
    git commit -m 'Add b.txt'
    git lol
    git log -p

Scroll up to rebase prompt

    git rebase --continue
    git lol


6 git stash
-----------

Two branches with changes:

    git lola
    git log -p foo
    git log -p bar

Unstaged changes:

    git status
    git diff

Merge in foo:

    git merge foo

As expected, git won't overwrite our unstaged changes

    $ git merge foo
    Updating 87f935b..0a0b17f
    error: Your local changes to the following files would be overwritten by merge:
        hello.c
    Please commit your changes or stash them before you merge.
    Aborting

Use stash:

    git stash
    git status

That stashed our unstaged changes. Where did they go?

    git stash list
    git stash show
    git stash show -p
    git lola

Stash shows up as a commit and a merge commit on `git lola`.

Do the merge now that we have a clean working tree:

    git merge foo

Reapply the unstaged changes:

    git stash pop
    git diff
    git stash list

No longer on the list of stashes.

Same procedure for rebase. Let's rebase bar onto master.

    git lola
    git checkout bar
    git stash
    git checkout bar
    git stash pop
    git lola

    git rebase master

You get the idea now.

    git stash
    git rebase master
    git lola

Add '!' to hello.c

    git status
    git diff
    git stash

You can have multiple stashes. The stash list is a stack.

    git stash list
    git stash list -p
    git lola # only shows most recent stash

Apply the stashes

    git stash pop
    git status
    git diff
    git stash list -p

Git stash is conservative

    $ git stash pop
    error: Your local changes to the following files would be overwritten by merge:
        hello.c
    Please commit your changes or stash them before you merge.
    Aborting

Commit changes first

    git diff
    git add hello.c
    git commit -m 'Be emphatic!'
    git stash pop
    git diff

This pattern is so common that there's a config option to do this automatically
on rebase (config.autoStash).


7 git submodule
---------------

I have three projects already setup for this example.

    ls
    ls remotes

Git can use several different file protocols to communicate with remotes. I'm
going to use file system access.

    git clone remotes/hello.git
    cd hello
    git remote -v
    cat hello.c

Hello world program that uses two modules to provide functionality. Color
module to color the console output. Greeting module to print the greeting. I've
already implemented these modules, so this is maybe a bit out of order. Now,
we'll add them as submodules.

    git submodule add `readlink -f ../remotes/color.git`
    git status

The submodule path color is treated like a file.

    cat .gitmodules
    git commit -m 'Add color submodule'
    git log -p

Note that it shows the commit hash of color.

    git submodule add `readlink -f ../remotes/greeting.git`
    git status
    git diff --staged
    git commit -m 'Add greeting submodule'
    git log -p
    make
    ./hello # Does it work?
    git lol

Now we're two commits ahead of origin/master. Push these changes:

    git push origin master
    git lol

Now let's make a change.

    cd color
    vi color.c # Change color
    git status
    cd ..
    git status
    cd color
    git add color.c
    git commit -m 'New color'
    cd ..
    git status
    git add color
    git commit -m 'Change color submodule commit'
    git log -p

Note that the subproject commit has changed.

It is important that you push the submodules first. What happens if you don't?

    git push origin master
    cd ..
    git clone --recursive remotes/hello.git hello2
    ...
    Fetched in submodule path 'color', but it did not contain
    143e8757468247a0a05e32e55ccd77f15f4f4f17. Direct fetching of that commit
    failed.

Let's fix that.

    cd hello/color
    git push origin master
    cd ../../
    git clone --recursive remotes/hello.git hello3
    cd hello3
    make
    ./hello

If we go back one commit, what should happen? Should print in red.

    git checkout HEAD~1
    make
    ./hello # What gives?
    git status

Checkout did not touch the submodule. In this way, submodules are not like
files.

    git submodule update
    git status
    make
    ./hello
