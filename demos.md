Demos
=====


Make sure rebase.autoStash is disabled.


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
