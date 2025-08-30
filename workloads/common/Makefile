setup:
	ansible-galaxy collection install prometheus.prometheus
	ansible-galaxy role install antmelekhin.windows_exporter

check:
	ansible-playbook -u guerzonix -i ../inventory --check --diff playbook.yml

run:
	ansible-playbook -u guerzonix -i ../inventory --diff playbook.yml

.PHONY: check run