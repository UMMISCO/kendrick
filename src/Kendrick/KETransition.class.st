"
A KETransition is a transition from a compartment to another one in a SAN.
from and to are compartments.

"
Class {
	#name : #KETransition,
	#superclass : #KEEntity,
	#instVars : [
		'from',
		'to',
		'probability'
	],
	#category : #'Kendrick-Core'
}

{ #category : #'as yet unclassified' }
KETransition class >> from: firstCompartment to: secondCompartment probability: aBlockOrAnExpression [
	^ self new
		from: firstCompartment ;
		to: secondCompartment ;
		probability: aBlockOrAnExpression
]

{ #category : #accessing }
KETransition >> = aTransition [
	^ (from = aTransition from) & (to = aTransition to) & (probability = aTransition probability)
]

{ #category : #accessing }
KETransition >> executeOn: model times: times [
	(from at: #status) = #empty
		ifFalse: [ | old new |
			old := model population compartments at: from.
			new := old - times.
			new := new max: 0.
			model population compartments at: from put: new ].
	(to at: #status) = #empty
		ifFalse: [ | old new |
			old := model population compartments at: to.
			new := old + times.
			model population compartments at: to put: new ]
]

{ #category : #accessing }
KETransition >> from [
	^ from
]

{ #category : #accessing }
KETransition >> from: aCompartment [

	| reader |
	aCompartment isDictionary ifTrue: [ ^ from := aCompartment ].
	aCompartment isArray ifTrue: [ 
		^ from := Dictionary newFrom: aCompartment ].
	(reader := STONReader on: aCompartment readStream) 
		allowComplexMapKeys: true.
	^ from := reader next
]

{ #category : #printing }
KETransition >> printOn: aStream [
	| f t |
	f := from isSymbol
		ifTrue: [ from asString ]
		ifFalse: [ from associations asString ].
	t := to isSymbol
		ifTrue: [ to asString ]
		ifFalse: [ to associations asString ].
	aStream
		nextPutAll: 'From: ';
		nextPutAll: f;
		nextPutAll: ' To: ';
		nextPutAll: t
]

{ #category : #accessing }
KETransition >> probability [
	^ probability 
]

{ #category : #accessing }
KETransition >> probability: aBlockOrAnExpression [
	|prob|
	prob := aBlockOrAnExpression.
	aBlockOrAnExpression isString ifTrue: [ prob := aBlockOrAnExpression parseAsAnExpression ].
	probability := prob 
]

{ #category : #accessing }
KETransition >> to [
	^ to
]

{ #category : #accessing }
KETransition >> to: aCompartment [

	| reader |
	aCompartment isDictionary ifTrue: [ ^ to := aCompartment ].
	aCompartment isArray ifTrue: [ 
		^ to := Dictionary newFrom: aCompartment ].
	(reader := STONReader on: aCompartment readStream) 
		allowComplexMapKeys: true.
	^ to := reader next
]
