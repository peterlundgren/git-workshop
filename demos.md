Demos
=====


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
