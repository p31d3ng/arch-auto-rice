#--------------------------------------------------------------------------
# Docker
#--------------------------------------------------------------------------
abbr -a -g dl docker ps -l -q
abbr -a -g dps docker ps
abbr -a -g dpa docker ps -a
abbr -a -g di docker images
abbr -a -g dip docker inspect --format '{{ .NetworkSettings.IPAddress }}'
abbr -a -g dkd docker run -d -P
abbr -a -g dki docker run -i -t -P
abbr -a -g dex docker exec -i -t

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
abbr -a -g gcmsg git commit -m
abbr -a -g gp git push
abbr -a -g gd git diff
abbr -a -g gaa git add -A
abbr -a -g gst git status

#--------------------------------------------------------------------------
# Kubernetes
#--------------------------------------------------------------------------
abbr -a -g kcg kubectl config get-contexts
abbr -a -g kcu kubectl config use-context
abbr -a -g kgp kubectl get pods
abbr -a -g kgd kubectl get deployments
abbr -a -g kgs kubectl get services
abbr -a -g klf kubectl logs -f
abbr -a -g klft kubectl logs -f --tail
function kssh
  kubectl exec -it $argv -- /bin/bash
end
abbr -a -g kdp kubectl describe pod
abbr -a -g kds kubectl describe svc
abbr -a -g kdd kubectl describe deployment
abbr -a -g kd kubectl describe
abbr -a -g ke kubectl edit
abbr -a -g kg kubectl get
abbr -a -g kdel kubectl delete

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
