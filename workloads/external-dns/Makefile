logs:
	kubectl logs -f $$(kubectl get po | grep ^external-dns | awk '{ print $$1 }')

apply:
	echo $$GOOGLE_PROJECT_ID
	sed -i "s/GOOGLE_PROJECT_ID/$$GOOGLE_PROJECT_ID/g" manifest.yaml
	kubectl apply -f manifest.yaml
	sed -i "s/$$GOOGLE_PROJECT_ID/GOOGLE_PROJECT_ID/g" manifest.yaml

.PHONY: logs