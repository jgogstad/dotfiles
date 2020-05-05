alias sbt=/usr/local/bin/sbtx

# Splain doesn't work for all projects, aliases to quickly enable/disable
alias nosplain='sed -i -E "s/.*/\/\/&/" ~/.sbt/1.0/plugins/Splain.scala'
alias splain='sed -i .bak -E "s_^\\/\\/+(.*)_\1_" ~/.sbt/1.0/plugins/Splain.scala'
