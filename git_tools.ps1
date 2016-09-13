# Git Powershell Scripts
# Roy Triesscheijn (roy-t@hotmail.com, @roytries)
# Please check https://github.com/roy-t/git-powershell-scripts/ for the latest version
# Licensed under the MIT license 


# Put a number before each line piped here
function number
{    
    $i = 0;
    foreach($line in $input)
    {
        [string]$i + ":" + $line
        ++$i
    }
}

# Show a compact git status with line numbers
function git-status
{
    git status -s | number
}

# Show all local branches compact with line numbers
function git-branch
{
    git branch --list | number
}

function get-branch-name($n)
{
    return (git branch --list | select -Index $n).Trim()
}

function get-file-name($n)
{
    $line = git status -s | select -Index $n
    return ($line.Split(" ", [System.StringSplitOptions]::RemoveEmptyEntries) | Skip-Object 1)
}

# Checkout branch referenced by the line number from git-branch
function git-checkout($n = 0)
{    
    git checkout (get-branch-name($n))
}

# Merge branch referenced by the line number from git-branch
function git-merge($n = 0)
{    
    git merge (get-branch-name($n))
}

# View the changes made to the file referenced by the line number from git-status
function git-diff($n = 0)
{    
    git diff (get-file-name($n))
}

# Diff with the previous version of this file
function git-diff-previous($name)
{
    git diff HEAD^ $name
}

# Add the file referenced by the line number from git-status to the commit
function git-add($n = 0)
{        
    git add (get-file-name($n))
}

# Discards all unstaged changes, or only the changes to file in the line number from git-status
function git-checkout-file($n = -1)
{
    if($n -eq -1)
    {
        git checkout -- .
    }
    else
    {       
        git checkout (get-file-name($n))
    }
}

# Unstages all staged changes, or unstages only the changes to the file in the line number from git-status
function git-reset($n = -1)
{
    if($n -eq -1)
    {
        git reset
    }
    else
    {        
        git reset (get-file-name($n))
    }
}

# Rebases the current branch on the most recent version of the target branch
function git-rebase-onto()
{
    param
    (
        [Parameter(Mandatory=$true)]
        [string]$targetBranch
    )

    $current = (git rev-parse --abbrev-ref HEAD)
    git checkout $targetBranch
    git pull
    git submodule update
    git rebase $targetBranch $current
}

# Merges the current branch into the specified branch
function git-merge-into()
{
    param
    (
        [Parameter(Mandatory=$true)]
        [string]$targetBranch
    )

    $current = (git rev-parse --abbrev-ref HEAD)
    git checkout $targetBranch
    git pull
    git submodule update
    git merge --no-ff $current
}

# Checkout an exiting branch that matches the search pattern (CheckOut Partial match)
function git-cop
{
    git checkout (git branch | Select-String -Pattern "$args").ToString().Trim()
}