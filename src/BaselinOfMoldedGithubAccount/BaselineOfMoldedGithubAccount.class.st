Class {
	#name : #BaselineOfMoldedGithubAccount,
	#superclass : #BaselineOf,
	#category : #BaselinOfMoldedGithubAccount
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
