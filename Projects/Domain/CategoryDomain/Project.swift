import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.module(
    name: ModulePaths.Domain.CategoryDomain.rawValue,
    targets: [
		.interface(module: .domain(.CategoryDomain)),
		.implements(module: .domain(.CategoryDomain), dependencies: [
			.domain(target: .CategoryDomain, type: .interface),
            .domain(target: .BaseDomain),
		]),
		.testing(module: .domain(.CategoryDomain), dependencies: [
			.domain(target: .CategoryDomain)
		])
	]
)
