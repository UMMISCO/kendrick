as yet unclassified
plot: aSymbol
(((data at: 1) at: 1) at: 1) isArray ifTrue: [
	"Draw a composite diagram of 3 first elements of the vector"
	|cpDiag diag1 diag2 diag3|	
	diag1 := (ESDiagramRenderer new lineDiagram)	
		y: #second;					
		defaultColor: (Color red);		
		yAxisLabel: 'Number of individuals';		
		regularAxis;		
		startLineAtZero;		
		models: ((self atIndex: aSymbol) at: 1);
		yourself.				
	diag2 := (ESDiagramRenderer new lineDiagram)	
		y: #second;		
		defaultColor: (Color green);			
		models: ((self atIndex: aSymbol) at: 2);
		yourself.
	(data at: 1) size >= 3 ifTrue: [	
	diag3 := (ESDiagramRenderer new lineDiagram)	
		y: #second;					
		defaultColor: (Color blue);				
		models: ((self atIndex: aSymbol) at: 3);
		yourself].
	cpDiag := ESDiagramRenderer new.
	diag3 ifNotNil: [(cpDiag compositeDiagram)
		add: diag1; add: diag2; add: diag3; width: 1200; height: 500; preferredAxisMaxY: 50] 
	ifNil: [(cpDiag compositeDiagram)
		add: diag1; add: diag2; width: 1200; height: 500; preferredAxisMaxY: 50].		
	^ cpDiag open.
	] ifFalse: [
	|diag|
	diag := ESDiagramRenderer new.
		(diag lineDiagram)
		y: #second;				
		defaultColor: (Color blue);		
		yAxisLabel: 'Number of individuals';		
		regularAxis;		
		startLineAtZero;		
		width: 1000;
		height: 500;
		models: (self atIndex: aSymbol).
	^ diag open.
	]