package unit_test

import (
	. "github.com/onsi/ginkgo/v2"
	. "github.com/onsi/gomega"

	helmchart "helm.sh/helm/v3/pkg/chart"
	helmloader "helm.sh/helm/v3/pkg/chart/loader"
	helmutil "helm.sh/helm/v3/pkg/chartutil"
	helmengine "helm.sh/helm/v3/pkg/engine"
)

func ValueStringRender(chart *helmchart.Chart, values string) (map[string]string, error) {
	v, err := helmutil.ReadValues([]byte(values))
	if err != nil {
		return nil, err
	}
	ro := helmutil.ReleaseOptions{Name: "spire", Namespace: "spire-server", Revision: 1, IsUpgrade: false, IsInstall: true}
	v, err = helmutil.ToRenderValues(chart, v, ro, helmutil.DefaultCapabilities);
	if err != nil {
		return nil, err
	}
	objs, err := helmengine.Render(chart, v)
	return objs, err
}

var _ = Describe("Spire", func() {
	chart, err := helmloader.Load("../../charts/spire")
	Expect(err).Should(Succeed())
	Describe("spire-server.upstream.cert-manager", func() {
		It("issuer_name when set is passed through", func() {
			objs, err := ValueStringRender(chart, `
spire-server:
  upstreamAuthority:
    certManager:
      enabled: true
      issuer_name: abc123
`)
			if err != nil {
				panic(err)
			}
			notes := objs["spire/charts/spire-server/templates/configmap.yaml"]
			Expect(notes).Should(ContainSubstring("abc123"))
		})
	})
})
