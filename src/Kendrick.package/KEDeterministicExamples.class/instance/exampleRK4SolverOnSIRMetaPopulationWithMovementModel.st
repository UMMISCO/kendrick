examples
exampleRK4SolverOnSIRMetaPopulationWithMovementModel
	"self new exampleRK4SolverOnSIRMetaPopulationWithMovementModel"
	|model simulator db graph1 graph2 output|
	model := KEModel new.
	model population: KEMetaPopulation new.
	model population attributes: '{#status: [#S,#I], #region:[#A,#B,#C,#D,#E]}'.
	graph1 := KEGraph on: model population atAttribute: #region 
					immigrationCoefficient: #m betweenClasses: { #all-> 0.001}.
	graph1 applyGraph: model.
	graph2 := KEGraph on: model population atAttribute: #region 
				couplingInfectionCoefficient: #beta withOutsideClass: { #all->0.0 } 
				insideClass: { #all->0.0001 }.
	graph2 applyGraph: model.
	model buildFromCompartments: {#region->#(A B C D E). #status->#(S I)} 
			cardinalities: #(1000 10 1000 0 1000 0 1000 0 1000 0).
	model addParameter: '{#mu: 0.0001, #gamma: 0.1, #N: 10000}'.
	model addEquation:
		('S:t=mu*N-beta*S*I-mu*S' parseAsAnEquation).
	model addEquation:
		('I:t=beta*S*I-gamma*I-mu*I' parseAsAnEquation).
	simulator := KESimulator new: #RungeKutta from: 0 to: 2910 step: 1.
	simulator executeOn: model.
	output := simulator data.
	db := KEDiagramBuilder new.
	db data: (output dataAt: '{#status: #I}').
	db open
															
														