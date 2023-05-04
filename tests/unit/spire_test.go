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
	if err != nil {
		panic(err)
	}
	Describe("Nested", func() {
		It("flag doesn't exist, no note", func() {
			objs, err := ValueStringRender(chart, "{}")
			if err != nil {
				panic(err)
			}
			notes := objs["spire/templates/NOTES.txt"]
			Expect(notes).ShouldNot(ContainSubstring("xperimental"))
		})
		It("flag set to standalone", func() {
			objs, err := ValueStringRender(chart, "{\"global\":{\"spire\":{\"nested\":\"standalone\"}}}")
			if err != nil {
				panic(err)
			}
			notes := objs["spire/templates/NOTES.txt"]
			Expect(notes).ShouldNot(ContainSubstring("xperimental"))
		})
		It("flag set to primary", func() {
			objs, err := ValueStringRender(chart, "{\"global\":{\"spire\":{\"nested\":\"primary\"}}}")
			if err != nil {
				panic(err)
			}
			notes := objs["spire/templates/NOTES.txt"]
			Expect(notes).Should(ContainSubstring("xperimental"))
		})
		It("flag set to secondary", func() {
			objs, err := ValueStringRender(chart, "{\"global\":{\"spire\":{\"nested\":\"secondary\"}}}")
			if err != nil {
				panic(err)
			}
			notes := objs["spire/templates/NOTES.txt"]
			Expect(notes).Should(ContainSubstring("xperimental"))
		})
		It("flag set to other", func() {
			objs, err := ValueStringRender(chart, "{\"global\":{\"spire\":{\"nested\":\"other\"}}}")
			if err != nil {
				panic(err)
			}
			notes := objs["spire/templates/NOTES.txt"]
			Expect(notes).Should(ContainSubstring("xperimental"))
		})
	})
})
