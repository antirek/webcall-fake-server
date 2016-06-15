# webcall-fake-server


## Install

> npm install



## Run

> coffee -c index.coffee

> node index



## Check

> curl http://localhost:3000/{key}/save 

return {ok, callid}

> curl http://localhost:3000/status/{callid}

return text status