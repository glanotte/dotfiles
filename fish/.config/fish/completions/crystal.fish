set -l crystal_commands init build docs env eval play run spec tool help version
complete -f -c crystal -n "not __fish_seen_subcommand_from $crystal_commands" -a init -d 'generate a new project'
complete -f -c crystal -n "not __fish_seen_subcommand_from $crystal_commands" -a build -d 'build an executable'
complete -f -c crystal -n "not __fish_seen_subcommand_from $crystal_commands" -a docs -d 'generate documentation'
complete -f -c crystal -n "not __fish_seen_subcommand_from $crystal_commands" -a env -d 'print Crystal environment information'
complete -f -c crystal -n "not __fish_seen_subcommand_from $crystal_commands" -a eval -d 'eval code form args or standard input'
complete -f -c crystal -n "not __fish_seen_subcommand_from $crystal_commands" -a play -d 'starts Crystal playground server'
complete -f -c crystal -n "not __fish_seen_subcommand_from $crystal_commands" -a run -d '(default) build and run program'
complete -f -c crystal -n "not __fish_seen_subcommand_from $crystal_commands" -a spec -d 'build and run specs (in the spec directory)'
complete -f -c crystal -n "not __fish_seen_subcommand_from $crystal_commands" -a tool -d 'run a tool'
complete -f -c crystal -n "not __fish_seen_subcommand_from $crystal_commands" -a help -d 'show the help'
complete -f -c crystal -n "not __fish_seen_subcommand_from $crystal_commands" -a version -d 'show version'
