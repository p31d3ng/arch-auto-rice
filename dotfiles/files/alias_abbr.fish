#--------------------------------------------------------------------------
# Docker
#--------------------------------------------------------------------------
abbr dl="docker ps -l -q"
abbr dps="docker ps"
abbr dpa="docker ps -a"
abbr di="docker images"
abbr dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
abbr dkd="docker run -d -P"
abbr dki="docker run -i -t -P"
abbr dex="docker exec -i -t"

function clean_docker
  docker rm (docker ps -aq -f status=exited)
  docker rmi (docker images --filter 'dangling=true' -q --no-trunc)
end

function clean_volume
  docker volume rm (docker volume ls -qf dangling=true)
end

#--------------------------------------------------------------------------
# Git
#--------------------------------------------------------------------------
abbr gcmsg='git commit -m'
abbr gp='git push'
abbr gd='git diff'
abbr gaa='git add -A'
abbr gst='git status'

#--------------------------------------------------------------------------
# Kubernetes
#--------------------------------------------------------------------------
abbr kcg="kubectl config get-contexts"
abbr kcu="kubectl config use-context"
abbr kgp="kubectl get pods"
abbr kgd="kubectl get deployments"
abbr kgs="kubectl get services"
abbr klf="kubectl logs -f"
abbr klft="kubectl logs -f --tail"
function kssh
  kubectl exec -it $argv -- /bin/bash
end
abbr kdp="kubectl describe pod"
abbr kds="kubectl describe svc"
abbr kdd="kubectl describe deployment"

#--------------------------------------------------------------------------
# Misc
#--------------------------------------------------------------------------
alias cl='clear;ls -al'
alias lc="leetcode"

function unset
  set --erase $argv
end

function private_key
   openssl pkcs8 -in $argv -inform PEM -outform DER -topk8 -nocrypt | openssl sha1 -c
end
