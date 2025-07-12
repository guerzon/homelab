template:
	helm template -n vaultwarden -f values-gke.yaml homelab-release vaultwarden/vaultwarden --set database.host=${DB_HOST} --set database.dbName=${DB_NAME} --set database.username=${DB_USER} --set database.password=${DB_PASSWORD} --set adminToken.value=${ADMIN_TOKEN}

upgrade:
	helm upgrade -i -n vaultwarden -f values-gke.yaml homelab-release vaultwarden/vaultwarden --set database.host=${DB_HOST} --set database.dbName=${DB_NAME} --set database.username=${DB_USER} --set database.password=${DB_PASSWORD} --set adminToken.value=${ADMIN_TOKEN}

uninstall:
	helm -n vaultwarden uninstall homelab-release

.SILENT: template upgrade
.PHONY: template upgrade uninstall