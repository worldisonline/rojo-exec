return function()
	local Rojo = script:FindFirstAncestor("Rojo")
	local Roact = require(Rojo.Packages.Roact)

	local Theme = require(Rojo.Plugin.App.Theme)
	local BorderedContainer = require(script.Parent.BorderedContainer)

	local e = Roact.createElement

	describe("BorderedContainer", function()
		it("renders nil, zero, one, and multiple children without a transparency binding", function()
			local cases = {
				{ children = nil, expected = 0 },
				{ children = {}, expected = 0 },
				{ children = { Only = e("Frame") }, expected = 1 },
				{ children = { First = e("Frame"), Second = e("Frame") }, expected = 2 },
			}

			for _, case in cases do
				local target = Instance.new("Frame")
				local handle = Roact.mount(
					e(Theme.StudioProvider, nil, {
						Container = e(BorderedContainer, nil, case.children),
					}),
					target
				)
				task.wait()

				local content = target:FindFirstChild("Content", true)
				expect(content).to.be.ok()
				expect(#content:GetChildren()).to.equal(case.expected)

				Roact.unmount(handle)
				target:Destroy()
			end
		end)
	end)
end
