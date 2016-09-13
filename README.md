# Git Powershell Scripts
A collection of functions that makes using git from Powershell a lot faster

## Rationale

Git is kind of silly. If I run `git status` Git tells me exactly what files I can stage using `git add` but I can't just tell `git add` to stage that second file. I have to type in the entire path to the file or come up with some clever search pattern. 

This collection of functions for Powershell makes working with Git a little bit easier and a lot faster. 

For example: 

`git-status` and `git-branch` (notice the dashes) give you a numbered output

```
> git-status
0: M src/path/to/changed/file/foo.cs
1: M src/path/to/changed/file/bar.cs`
```

Which can be fed into functions suchs as `git-add`, `git-checkout`, `git-merge`, `git-diff`, `git-reset`,...

```
> git-add 1
```

Which staged the file `src/path/to/changed/file/bar.cs` without us having to type in the entire path.

I've also written a few helper functions for rebasing and merging.

## List of functions

### Branch functions
`git-branch` numbered output of `git branch`
`git-checkout $n` check out numbered branch
`git-merge $n` merge numbered branch

### File functions
`git-status` numbered output of `git status`
`git-add $n` stage numbered file
`git-checkout-file $n` checkout numbered file, if no argument is given discards all unstaged files (`git checkout --.`)
`git-diff $n` diff current changes to numbered file
`git-diff-previous $n` diff with previous version of numbered file
`git-reset $n` reset numbered file, if no argument is given unstages all staged changes (`git reset`)

### Miscellaneous functions
`git-cop $args` check out a branch that matches the search pattern
`git-rebase-onto $branch` rebases current branch on the latest version of the target branch (target branch is pulled first)
`git-merge-into $branch` merges the current branch into the latest version of the target branch (target branch is pulled first)


## Installation
Run the script using the dot syntax to make all functions available for the current Powershell session or add the following line to your `$profile` (run `notepad $profile` to edit your profile).
```
. "C:\path\to\repostiroy\git_tools.ps1"
```
