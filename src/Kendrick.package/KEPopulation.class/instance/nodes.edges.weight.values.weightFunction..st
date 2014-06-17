accessing
nodes: aCollection edges: edgeCollection weight: aSymbol values: weightCollection weightFunction: aBlock
	"Simplest DSL that add a collection of sub-population into population"
	"i.e: population nodes: ($a $b $c)"
	self nodes: aCollection.
	((aSymbol = #m) | (aSymbol = #movement)) ifTrue: [ self addParameter: #movement value: true ].
	graph ifNil: [ graph := KEGraph new ].
	graph nodes: aCollection.
	graph edges: edgeCollection weight: aSymbol values: weightCollection weightFunction: aBlock
	
	