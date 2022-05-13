# ps
alias docker-ps='docker ps --format="table {{.ID}}\t{{.Names}}\t{{.Status}}"'
alias docker-ps-a='docker ps -a --format="table {{.ID}}\t{{.Names}}\t{{.Status}}"'

# docker-compose
alias dcu="docker-compose -f docker-compose.dependencies.yml up -d"
alias dcd="docker-compose -f docker-compose.dependencies.yml down"