# note

we are patching rabbitmq to stop service before erlang cookie is changed. 

This bug is on opscode site but has no signs of being fixed.  So until then we will use this.

Please use `erlang_cookie` branch to make changes.
`fetch upstream` and rebase before pushing back up to sendgrid-ops
