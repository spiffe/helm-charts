TARGET_BRANCH ?= main

.PHONY: help
help: ## Display this help.
	@$(MAKE) help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Linting:

.PHONY: lint
lint: ## Lint the charts using chart-testing
	@echo Linting charts…
	@ct lint --config ct.yaml --target-branch $(TARGET_BRANCH) --check-version-increment=false

lint-release: ## Lint the charts using chart-testing for release
	@echo Linting charts…
	@ct lint --config ct.yaml --target-branch $(TARGET_BRANCH)

##@ Testing:

.PHONY: clean-lingering-resources
clean-lingering-resources:
	@echo Cleanup potential leftovers…
	@-kubectl delete csidrivers.storage.k8s.io csi.spiffe.io \
		&>/dev/null || true
	@-kubectl delete ns \
		$$(kubectl get ns -o json | jq -r '.items[] | .metadata.name' | grep spire) \
		&>/dev/null || true
	@-kubectl delete validatingwebhookconfigurations.admissionregistration.k8s.io \
		$$(kubectl get validatingwebhookconfigurations.admissionregistration.k8s.io -o json | jq -r '.items[] | .metadata.name' | grep spire) \
		&>/dev/null || true

.PHONY: test
test: ## Run tests using Helm chart-testing (ensure to run on dedicated test cluster)
	@echo Running tests…
	@ct install --debug \
		--charts charts/spire
