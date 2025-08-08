Class {
	#name : 'JsonCountSubTreeVisitor',
	#superclass : 'FASTFortranJsonVisitor',
	#category : 'FAST-Fortran-Visitors-Visitor',
	#package : 'FAST-Fortran-Visitors',
	#tag : 'Visitor'
}

{ #category : 'visiting reflectivity' }
JsonCountSubTreeVisitor >> visitJsonArray: aCollection [
	Transcript show: 'Visiting node:visitJsonArray '; cr.
	^aCollection sum: [ :each | self visitJsonElement: each ]
]

{ #category : 'visiting reflectivity' }
JsonCountSubTreeVisitor >> visitJsonElement: aNode [

	1 halt.
	Transcript
		show: 'Visiting node: ' , aNode printString;
		cr.
	aNode ifNil: [ ^ 0 ].
	aNode isEmpty ifTrue: [ ^ 1 ].
	aNode isString ifTrue: [ ^ 1 ].
	aNode isDictionary ifTrue: [ ^ 1 + (self visitJsonMap: aNode) ].
	aNode isArray ifTrue: [ ^ 1 + (self visitJsonArray: aNode) ].
	
	^ 1
]

{ #category : 'visiting reflectivity' }
JsonCountSubTreeVisitor >> visitJsonMap: jsonDictionary [
	"If dicionary contains key 'tag', performs a visit of the whole node for this tag,
	otherwise, perform a visit of each value for their key
	'anno' key always ignored"

	1 halt.
	Transcript show: 'visitJsonMap:'; cr.
	jsonDictionary removeKey: 'anno' ifAbsent: [ "nothing" ].

	"	^ (jsonDictionary includesKey: 'tag')"
	^ self visitJsonTaggedElement: jsonDictionary
	"		  ifFalse: [
			  jsonDictionary associations collect: [ :assoc |
				  self visitKey: assoc key value: assoc value ] ]"
]

{ #category : 'visiting reflectivity' }
JsonCountSubTreeVisitor >> visitJsonMap: jsonDictionary keys: aCollection [
	"visit only the keys listed in aCollection in the jsonDictionary"

	Transcript show: 'visitJsonMap:'; cr.
	^ aCollection sum: [ :key |
		  self visitJsonNode: jsonDictionary key: key ]
]

{ #category : 'visiting reflectivity' }
JsonCountSubTreeVisitor >> visitJsonNode: aJsonNode key: key [
	^ 1
	"^self visitKey: key value: (aJsonNode at: key)"
]

{ #category : 'visiting reflectivity' }
JsonCountSubTreeVisitor >> visitJsonTaggedElement: jsonDictionary [
	"similar to #visitJsonNode: , but removes first the 'tag' key from the JsonDisctionary
	 so that it is not visited again (not sure this is needed ...?)"

	1 halt.
	Transcript
		show: 'visitJsonTaggedElement:';
		cr.
	jsonDictionary removeKey: 'tag' ifAbsent: [ "nothing" ].


	^ 1 + (jsonDictionary sum: [ :each | self visitJsonElement: each ])
	"^ (1+ (self visitKey: key value: jsonDictionary))"
]

{ #category : 'visiting reflectivity' }
JsonCountSubTreeVisitor >> visitKey: key value: aNode [
	| selector |
	1 halt.
	Transcript show: 'visitKey:'; cr.
	selector := ('visit' , key capitalized , ':') asSymbol.
	^self perform: selector with: aNode

]

{ #category : 'visiting prog-unit' }
JsonCountSubTreeVisitor >> visitMeta: aMetaNode [

	1 halt.
	Transcript
		show: 'Visiting node: ' , aMetaNode printString;
		cr.
	^ 1 + (self visitJsonMap: aMetaNode keys: #( miVersion miFilename ))
	"^self visitJsonMap: aMetaNode keys: #(miVersion miFilename)"
]

{ #category : 'visiting prog-unit' }
JsonCountSubTreeVisitor >> visitProgramFile: aProgramFileNode [

	1 halt.
	Transcript
		show: 'Visiting node: ' , aProgramFileNode printString;
		cr.
	^ 1
	  + (aProgramFileNode sum: [ :child | self visitJsonElement: child ])
	"^ 1+ ( super visitProgramFile: aProgramFileNode)."
	"^ (super visitProgramFile: aProgramFileNode) second"
]

{ #category : 'visiting prog-unit' }
JsonCountSubTreeVisitor >> visitSubroutine: aSubroutineNode [

	1 halt.
	Transcript
		show: 'Visiting node: ' , aSubroutineNode printString;
		cr.
	"#(span name arguments blocks)"
	1 + (aSubroutineNode sum: [ :child | self visitJsonElement: child ])
	"| data routine |
	1 halt.
	data := super visitSubroutine: aSubroutineNode.
	1 halt.
	routine := (self
		            newEntity: FASTFortranSubroutine
		            atPosition: data first)
		           name: data second;
		           parameters: data third;
		           statementBlock: data fourth;
		           yourself.

	self addSegmentDeclarationsTo: routine.

	data fourth statements ifEmpty: [ ""only useful for the tests ?""
		self setBodyPosition: routine fromProgramUnitPosition: data first ].

	^ routine"
]
