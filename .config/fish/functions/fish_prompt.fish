function fish_prompt
    if not set -q -g __fish_robbyrussell_functions_defined
        set -g __fish_robbyrussell_functions_defined
        function _git_branch_name
            set -l branch (git symbolic-ref --quiet HEAD 2>/dev/null)
            if set -q branch[1]
                echo (string replace -r '^refs/heads/' '' $branch)
            else
                echo (git rev-parse --short HEAD 2>/dev/null)
            end
        end

        function _is_git_dirty
            echo (git status -s --ignore-submodules=dirty 2>/dev/null)
        end

        function _is_git_repo
            type -q git
            or return 1
            git rev-parse --git-dir >/dev/null 2>&1
        end

        function _hg_branch_name
            echo (hg branch 2>/dev/null)
        end

        function _is_hg_dirty
            echo (hg status -mard 2>/dev/null)
        end

        function _repo_branch_name
            _$argv[1]_branch_name
        end

        function _is_repo_dirty
            _is_$argv[1]_dirty
        end

        function _repo_type
            if _is_git_repo
                echo 'git'
                return 0
            end
            return 1
        end
    end

    set -l red (set_color -o red)
    set -l blue (set_color -o blue)
    set -l normal (set_color normal)
    set -l grey (set_color 828F8F)

    set -l cwd $color_cwd (basename $PWD)'/'

    if set -l repo_type (_repo_type)
        set -l repo_branch $red(_repo_branch_name $repo_type)

        set -l dirty (_is_repo_dirty $repo_type)
        if test -n "$dirty"
            set repo_info "$blue ($repo_branch*$blue)"
        else
            set repo_info "$blue ($repo_branch$blue)"
        end
    end

    echo -n -s $grey"$USER"$normal ':' $cwd $repo_info $normal ' $ '
end
