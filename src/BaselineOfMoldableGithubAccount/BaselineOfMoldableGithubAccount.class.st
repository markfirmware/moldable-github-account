Class {
	#name : #BaselineOfMoldableGithubAccount,
	#superclass : #BaselineOf,
	#category : #BaselineOfMoldableGithubAccount
}

{ #category : #accessing }
BaselineOfMoldableGithubAccount >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'MoldableGithubAccount' ]
]

{ #category : #accessing }
BaselineOfMoldableGithubAccount >> projectClass [
	^ MetacelloCypressBaselineProject
]
