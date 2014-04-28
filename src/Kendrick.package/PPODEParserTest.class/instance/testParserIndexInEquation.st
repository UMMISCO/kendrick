tests
testParserIndexInEquation

|model compartment dsdt didt|

model := KEModel new.
model atCompartment: #S putNumberOfIndividuals: #(9999 1000 2000).
model atCompartment: #I putNumberOfIndividuals: #(1 0 0).

model atParameter: #beta put: {{0 . 0.02 . 0.02} . {0.02 . 0 . 0} . {0.02 . 0 . 0}}.
model atParameter: #N put: #(10000 1000 2000).
model atParameter: #mu put: {365/30 . 1/20 . 1/20}.
model atParameter: #v put: 52.
model atParameter: #j put: (1 to: 3). 
model atParameter: #i put: (1 to: 3).
self assert: (model atParameter: #j at: 2) equals: 2. "j is an interval"
self assert: (model atParameter: #beta at: 2 at: 3 ) equals: 0.

dsdt := 'S[i]:t=mu[i]*N[i]-I[i-1]*S[i]-mu[i]*S[i]' parseAsAnEquation.
didt := 'I[i]:t=I[i-1]*S[i]-(mu[i]+v)*I[i]' parseAsAnEquation.
model addEquation: dsdt.
model addEquation: didt.
model eqIdVariable: #i.
model eqIdValue: 1.

self assert: ((model equations) size) equals: 6.
self assert: (dsdt variable symbol) equals: #S.
self assert: (dsdt tVariable symbol) equals: #t.
self assert: (dsdt idVariable) equals: #i.
self assert: (didt idVariable) equals: #i.
self assert: (dsdt expression evaluateWithModel: model) equals: (365/30).



