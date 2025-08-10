setup:
	ansible-galaxy collection install prometheus.prometheus
	ansible-galaxy role install antmelekhin.windows_exporter

check_prom:
	ansible-playbook -C -D -i ../inventory install_prometheus.yaml

run_prom:
	ansible-playbook -D -i ../inventory install_prometheus.yaml

check_graf:
	ansible-playbook -C -D -i ../inventory install_grafana.yaml

run_graf:
	ansible-playbook -D -i ../inventory install_grafana.yaml

check_nodes:
	ansible-playbook -C -D -i ../inventory install_nodeexporters.yaml

run_nodes:
	ansible-playbook -D -i ../inventory install_nodeexporters.yaml

.PHONY: setup check_prom run_prom check_graf run_graf