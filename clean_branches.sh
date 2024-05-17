#!/bin/env bash
 
branches=$(git --no-pager branch -r | grep -v -- "->")
#remotes_to_keep="origin"
remotes_to_keep="origin"
remote="origin"
keep_branches_regex="^(release\/.*$|master|develop|various-fixes)$"
remote_branches_regex="^(release\/.*$|master|develop)$"
branches_to_keep=$keep_branches_regex
remote_branches_to_keep=$remote_branches_regex

for_real=false
if [ "${1}" = "destroy" ]; then
	for_real=true
fi

# echo "regex is $regex"
kept_branches=()
for ref in $branches; do
	remote=$(echo $ref | cut -d "/" -f1)
	branch=$(echo $ref | cut -d "/" -f2-)
	# echo "Remote: $remote"
	# echo "Branch: $branch"
	if [[ $branch =~ $keep_branches_regex ]]; then
		#echo "Keeping $branch"
		kept_branches+=("Keeping $branch on $remote")
		:
	else
		if [[ $remote =~ $remotes_to_keep ]] && [[ $branch =~ $remote_branches_to_keep ]] ; then
			echo "Keeping $branch on $remote"
			:
		else
			echo "Deleting $ref"
			if $for_real 
			then
				## Delete local branches
				git branch --delete --remotes ${remote}/${branch}
				## Delete remote braches
				if [ "${remote}" != "upstream" ]; then
					git push ${remote} --delete ${branch} # --dry-run
				fi
			else
				echo -e "\tLocal:  git branch --delete --remotes ${remote}/${branch}"
				if [ "${remote}" != "upstream" ]; then
					echo -e "\tRemote: git push ${remote} --delete ${branch}"
				fi
			fi
		fi
	fi
done
for kb in "${kept_branches[@]}";
do
	echo $kb
done
