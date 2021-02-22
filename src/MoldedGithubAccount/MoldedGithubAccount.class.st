Class {
	#name : #MoldedGithubAccount,
	#superclass : #Object,
	#category : #MoldedGithubAccount
}

{ #category : #accessing }
MoldedGithubAccount >> generateIndexHtml [

    self myIndexHtml writeStreamDo: [ :s | | h |
    	s truncate.
		h := ZnHtmlOutputStream on: s.
		h html5.
		h tag: #html do: [ 
			h tag: #head do: [
				h tag: #meta attributes: #(charset 'UTF-8').
        		h tag: #meta attributes: #(name viewport content 'width=device-width, initial-scale=1.0').
        		h tag: #link attributes: #(href 'https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css' rel stylesheet).
        		h openTag: #script attribute: #src value: 'https://cdn.jsdelivr.net/gh/alpine-collective/alpine-magic-helpers@0.5.x/dist/index.min.js'.
        		h closeTag: #script.
        		h openTag: #script attribute: #src value: 'https://cdnjs.cloudflare.com/ajax/libs/alpinejs/2.8.0/alpine.js'.
        		h closeTag: #script
			].
			h tag: #body class: 'font-mono' do: [
				h tag: #div with:
					'This is an alpinejs/tailwindcss page that presents a molded github account (markfirmware.) It is produced by gtoolkit and will eventually probably contain pillar/xdoc content.'.
				h tag: #div class: 'm-8' do: [
					h tag: #div do: [
						h tag: #span with: '1. clone '.
						h
							tag: #a
							attributes: #(class underline href 'https://github.com/markfirmware/molded-github-account#molded-github-account')
							with: 'molded-github-account'
					].
					h tag: #div with: '2. cd clone'.
					h tag: #div with: '3. ./mold'
				]
			]
		]
	].
	^self myIndexHtml
]

{ #category : #accessing }
MoldedGithubAccount >> getRepos [
Smalltalk at: #AccountRepos put: (STON fromString: (ZnClient new url: 'https://api.github.com/users/markfirmware/repos?per_page=100'; get))
]

{ #category : #accessing }
MoldedGithubAccount >> myClone [
	^ FileSystem workingDirectory parent
]

{ #category : #accessing }
MoldedGithubAccount >> myIndexHtml [
    ^ self myClone / 'docs' / 'index.html'
]

{ #category : #accessing }
MoldedGithubAccount >> refreshRepos [
Smalltalk at: #AccountRepos put: (STON fromString: (ZnClient new url: 'https://api.github.com/users/markfirmware/repos?per_page=100'; get)). ^Smalltalk at: #AccountRepos
]
