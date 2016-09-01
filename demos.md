Demos
=====


01 git help
-----------

    # List of common commands
    git help
    # Full list of git commands
    git help -a
    # git help <commind>
    git help log

High quality reference material, but not very good tutorials. Start with
Google, then read the relevant man pages.


02 git init
-----------

    git init
    ls -a
    tree .git
    git commit --allow-empty -m 'Initial commit'

It is customary to start off a git repo with an empty commit. In this case,
adding a single empty file. This makes it easier to rewrite history near the
beginning of your repo.


03 Three Stage Thinking
-----------------------

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
