setup:
	kubectl create ns vaultwarden | \
		helm repo add vaultwarden https://guerzon.github.io/vaultwarden | \
		helm repo update | \
		kubectl create secret -n vaultwarden tls homelab-cert \
			--key /data/Projects/homelab/local/homelab.sreafterhours.dev.pem \
			--cert /data/Projects/homelab/local/homelab.sreafterhours.dev.crt | \
		kubectl -n vaultwarden create secret generic prod-db-creds \
			--from-literal=pgusername=${DB_USER} \
			--from-literal=pgpassword=${DB_PASSWORD}

template:
	if [ -z "$$DB_HOST" ]; then \
		echo "Please make sure all required variables are set."; \
		exit 1; \
	fi
	helm template -n vaultwarden \
		homelab-release vaultwarden/vaultwarden \
		--set database.host=${DB_HOST} \
		--set database.dbName=${DB_NAME} \
		--set adminToken.value=${ADMIN_TOKEN} \
		-f values-gke.yaml

upgrade:
	if [ -z "$$DB_HOST" ]; then \
		echo "Please make sure all required variables are set."; \
		exit 1; \
	fi
	helm upgrade -i -n vaultwarden \
		homelab-release vaultwarden/vaultwarden \
		--set database.host=${DB_HOST} \
		--set database.dbName=${DB_NAME} \
		--set adminToken.value=${ADMIN_TOKEN} \
		-f values-gke.yaml

check:
	kubectl -n vaultwarden get po

uninstall:
	helm -n vaultwarden uninstall homelab-release | \
		kubectl delete ns vaultwarden | \
		gcloud dns record-sets delete a-vaultwarden.homelab.sreafterhours.dev. --type TXT --zone apps | \
		gcloud dns record-sets delete vaultwarden.homelab.sreafterhours.dev. --type A --zone apps
		### Workaround to issue with deleting DNS records when uninstalling the chart

logs:
	kubectl -n vaultwarden logs -f $$(kubectl -n vaultwarden get po | grep ^homelab-release-vaultwarden | awk '{ print $$1 }')

.SILENT: template upgrade
.PHONY: setup template upgrade check uninstall logs