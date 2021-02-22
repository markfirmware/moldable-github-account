Class {
	#name : #BaselineOfMoldedGithubAccount,
	#superclass : #BaselineOf,
	#category : #BaselineOfMoldedGithubAccount
}

{ #category : #accessing }
BaselineOfMoldedGithubAccount >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'MoldedGithubAccount' ]
]

{ #category : #accessing }
BaselineOfMoldedGithubAccount >> projectClass [
	^ MetacelloCypressBaselineProject
]
