$branches = git branch -r
$remote = "john"
$branch_to_keep = "conan"

# Loop through each branch
foreach ($branch in $branches) {
    if ($branch -like "*$remote/*") {
        if ($branch -notlike "*$remote/$branch_to_keep*") {
            echo $branch
            git branch -d -r $branch.Trim()
        }
    }
}

git config remote.$remote.fetch '+refs/heads/$branch_to_keep:refs/remotes/$remote/$branch_to_keep'
