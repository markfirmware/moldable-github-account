Class {
	#name : #MoldedGithubAccount,
	#superclass : #Object,
	#classInstVars : [
		'repositories'
	],
	#category : #MoldedGithubAccount
}

{ #category : #accessing }
MoldedGithubAccount class >> accountOwnerName [
^((IceRepository registry
    detect: [ :repo | repo location = '..' asFileReference]) remotes detect: [ :r | r name = 'origin' ]) owner
]

{ #category : #accessing }
MoldedGithubAccount class >> generateIndexHtml [
	self myIndexHtml
		writeStreamDo: [ :s | 
			| h |
			s truncate.
			h := ZnHtmlOutputStream on: s.
			h html5.
			h
				tag: #html
				do: [ self hHead: h.
					h
						tag: #body
						class: 'font-mono'
						do: [ self hIntroduction: h.
							self hInstructions: h.
							h tag: #div with: 'Repositories in account markfirmware:'.
							self hRepositories: h ] ] ].
	^ self myIndexHtml
]

{ #category : #accessing }
MoldedGithubAccount class >> ghGetSton: url [
	^STON fromString: (ZnEasy get: url) contents
]

{ #category : #accessing }
MoldedGithubAccount class >> hHead: h [
	h
		tag: #head
		do: [ h tag: #meta attributes: #(charset 'UTF-8').
			h
				tag: #meta
				attributes: #(name viewport content 'width=device-width, initial-scale=1.0').
			h
				tag: #link
				attributes:
					#(href 'https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css' rel stylesheet).
			h
				openTag: #script
				attribute: #src
				value:
					'https://cdn.jsdelivr.net/gh/alpine-collective/alpine-magic-helpers@0.5.x/dist/index.min.js'.
			h closeTag: #script.
			h
				openTag: #script
				attribute: #src
				value: 'https://cdnjs.cloudflare.com/ajax/libs/alpinejs/2.8.0/alpine.js'.
			h closeTag: #script ]
]

{ #category : #accessing }
MoldedGithubAccount class >> hInstructions: h [
	h
		tag: #div
		class: 'm-8'
		do: [ h
				tag: #div
				do: [ h tag: #span with: '1. clone '.
					h
						tag: #a
						attributes:
							#(class underline href 'https://github.com/markfirmware/molded-github-account#molded-github-account')
						with: 'molded-github-account' ].
			h tag: #div with: '2. cd clone'.
			h tag: #div with: '3. ./mold' ]
]

{ #category : #accessing }
MoldedGithubAccount class >> hIntroduction: h [
	h
		tag: #div
		class: 'my-4'
		with:
			'This is an alpinejs/tailwindcss page that presents a molded github account. It is produced by gtoolkit and will eventually probably contain pillar/xdoc content.';
		tag: #div
		class: 'my-4'
		with:
			'The Glamorous Toolkit can mold software - this produces molded software. When an entire github account of repositories is so molded, you have a molded github account. This repo represents a molded github account. Which account? The account in which this repo resides (', self accountOwnerName, '.)'
]

{ #category : #accessing }
MoldedGithubAccount class >> hRepositories: h [
	^ h
		tag: #ol
		class: 'list-decimal list-inside'
		do: [ self repositories
				do: [ :r | 
					h
						tag: #li
						class: 'mx-8'
						do: [ h
								tag: #a
								attributes:
									{#class.
									#underline.
									#href.
									(r at: #html_url)}
								with: (r at: #name) ] ] ]
]

{ #category : #accessing }
MoldedGithubAccount class >> myClone [
	^ FileSystem workingDirectory parent
]

{ #category : #accessing }
MoldedGithubAccount class >> myIndexHtml [
    ^ self myClone / 'docs' / 'index.html'
]

{ #category : #accessing }
MoldedGithubAccount class >> refreshRepositories [
	repositories := (self ghGetSton: 'https://api.github.com/users/markfirmware/repos?per_page=100')
				sort: [ :a :b | (a at: #name) < (b at: #name)]
]

{ #category : #accessing }
MoldedGithubAccount class >> repositories [
    ^repositories ifNil:  [ repositories := OrderedCollection new ]
]

{ #category : #accessing }
MoldedGithubAccount class >> serveIndexHtml [
ZnServer startDefaultOn: 8080.
ZnServer default delegate:
	(ZnStaticFileServerDelegate new
		directory: '../docs' asFileReference;
		yourself)
]
