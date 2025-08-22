Class {
	#name : 'FASTFortranCountSubtreeVisitor',
	#superclass : 'Object',
	#instVars : [
		'count'
	],
	#category : 'FAST-Fortran-Visitors-Visitor',
	#package : 'FAST-Fortran-Visitors',
	#tag : 'Visitor'
}

{ #category : 'accessing' }
FASTFortranCountSubtreeVisitor >> count [

	^ count
]

{ #category : 'initialization' }
FASTFortranCountSubtreeVisitor >> initialize [ 

	super initialize.

	count := 0.
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranArrayRange: aFASTFortranArrayRange [

	aFASTFortranArrayRange upperBound children size > 0 ifTrue: [
			count := count + 1.
			aFASTFortranArrayRange upperBound accept: self ].
	aFASTFortranArrayRange lowerBound children size > 0 ifTrue: [
			count := count + 1.
			aFASTFortranArrayRange upperBound accept: self ].
	
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranComment: aFASTFortranComment [

	count := count + 0
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranFunction: aFASTFortranFunction [

	count := count + 1.

	aFASTFortranFunction declaredType isNotNil ifTrue:[
		aFASTFortranFunction declaredType children isNotNil ifTrue: [
			aFASTFortranFunction declaredType children isNotEmpty ifTrue: [
					count := count + 1.
					aFASTFortranFunction declaredType accept: self ] ].

		].
	
	
	aFASTFortranFunction parameters do: [ :aNode |
			aNode children isEmpty ifFalse: [
					count := count + 1.
					aNode accept: self ] ].

	aFASTFortranFunction declarations do: [ :aNode |
			aNode children isEmpty ifFalse: [
					count := count + 1.
					aNode accept: self ] ].
	aFASTFortranFunction statementBlock children isNotEmpty ifTrue: [
			count := count + 1.
			aFASTFortranFunction statementBlock accept: self ].
	aFASTFortranFunction comments do: [ :aNode |
			aNode children isEmpty ifFalse: [
					count := count + 1.
					aNode accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranIntegerType: aFASTFortranIntegerType [

	count := count
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranReturnStatement: aFASTFortranReturnStatement [

	aFASTFortranReturnStatement expression children isNotNil ifTrue: [
			aFASTFortranReturnStatement expression children isNotEmpty ifTrue: [
					count := count + 1.
					aFASTFortranReturnStatement expression accept: self ] ].

]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranScalarVariable: aFASTFortranScalarVariable [

	count := count
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranStatementBlock: aFASTFortranStatementBlock [

	aFASTFortranStatementBlock statements do: [ :aNode |
			count := count + 1.
			aNode accept: self ].
	aFASTFortranStatementBlock comments do: [ :aNode |
			count := count + 1.
			aNode accept: self ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranSubroutine: aFASTFortranSubroutine [

	count := count + 1.
	aFASTFortranSubroutine declarations do: [ :aNode |
			aNode children isEmpty ifFalse: [
					count := count + 1.
					aNode accept: self ] ].
	aFASTFortranSubroutine statementBlock children isNotEmpty ifTrue: [
			count := count + 1.
			aFASTFortranSubroutine statementBlock accept: self ].

	aFASTFortranSubroutine comments do: [ :aNode |
			aNode children isEmpty ifFalse: [
					count := count + 1.
					aNode accept: self ] ].
	aFASTFortranSubroutine parameters do: [ :aNode |
			aNode children isEmpty ifFalse: [
					count := count + 1.
					aNode accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement [

	| declared_types declarators |
	declared_types := aFASTFortranVariableDeclarationStatement
		                  declaredType children.
	declarators := aFASTFortranVariableDeclarationStatement declarators.

	declared_types isNotNil ifTrue: [
			declared_types size > 0 ifTrue: [
					count := count + 1.
					aFASTFortranVariableDeclarationStatement declaredType accept:
						self ] ].

	aFASTFortranVariableDeclarationStatement declarators do: [ :aNode |
			aNode children isEmpty ifFalse: [
					aNode children do: [ :n |
							count := count + 1.
							n accept: self ] ] ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranVariableDeclarator: aFASTFortranVariableDeclarator [

	aFASTFortranVariableDeclarator dimensions do: [ :dim |
			dim children isNotNil ifTrue: [
				dim children size > 0 ifTrue: [ dim children accept: self ] ] ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitModel: aFASTModel [

	count := 0.
	aFASTModel do: [ :elem |
		elem isProgramUnit
			ifTrue: [elem accept: self]
	].

	^ count
]
