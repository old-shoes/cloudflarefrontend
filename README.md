# cloudflarefrontend

Static frontend with GitHub Actions auto-deploy to `https://echoofvoid.com`.

## Auto Deploy

Add one repository secret in GitHub:

- `SERVER_PASSWORD`: the SSH password for user `ubuntu` on `1.14.141.206`

Then every push to `main` will:

- SSH into `1.14.141.206`
- pull the latest code in `/www/wwwroot/cloudflarefrontend`
- run `npm run build`
- publish `dist/` to `/var/www/cloudflarefrontend`
- reload `nginx`
