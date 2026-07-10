function git_project_name() {
	if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
  		local project_name=`git remote -v 2>/dev/null | tail -1 | awk '{print $2}'`
  		if [ ! -z "${project_name}" ]; then
    		project_name=$(basename "${project_name}")
    		echo "${project_name}"
		fi
  	fi
}

function precmd() {
  CURRENT_GIT_PROJECT=$(git_project_name)
}

#PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) %{$fg[cyan]%}%c%{$reset_color%}"
PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) %{$fg[cyan]%}%~%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
