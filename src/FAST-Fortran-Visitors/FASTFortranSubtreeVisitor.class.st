Class {
	#name : 'FASTFortranSubtreeVisitor',
	#superclass : 'Object',
	#instVars : [
		'subtreeRoots'
	],
	#category : 'FAST-Fortran-Visitors-Visitor',
	#package : 'FAST-Fortran-Visitors',
	#tag : 'Visitor'
}

{ #category : 'initialization' }
FASTFortranSubtreeVisitor >> initialize [ 

	super initialize.

	subtreeRoots := OrderedCollection new.
]

{ #category : 'accessing' }
FASTFortranSubtreeVisitor >> subtreeRoots [

	^ subtreeRoots
]

{ #category : 'accessing' }
FASTFortranSubtreeVisitor >> subtreeRoots: aSubtreeRoot [

	subtreeRoots add: aSubtreeRoot
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranArrayRange: aFASTFortranArrayRange [

	aFASTFortranArrayRange children ifNotEmpty: [ "count := count + 1"
		subtreeRoots add: aFASTFortranArrayRange ].

	aFASTFortranArrayRange lowerBound ifNotNil: [
		aFASTFortranArrayRange lowerBound accept: self ].

	aFASTFortranArrayRange upperBound ifNotNil: [
		aFASTFortranArrayRange upperBound accept: self ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranArrayVariable: aFASTFortranArrayVariable [

	aFASTFortranArrayVariable children ifNotEmpty: [ "count := count + 1" 
		subtreeRoots add:aFASTFortranArrayVariable ].
	aFASTFortranArrayVariable indices ifNotEmpty: [
		aFASTFortranArrayVariable indices do: [ :ind | ind accept: self ] ].
	aFASTFortranArrayVariable pointerIn ifNotNil: [
		aFASTFortranArrayVariable pointerIn accept: self ].
	aFASTFortranArrayVariable fieldIn ifNotNil: [
		aFASTFortranArrayVariable fieldIn accept: self ].
	aFASTFortranArrayVariable entryStatement ifNotNil: [
		aFASTFortranArrayVariable entryStatement accept: self ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranAssignmentExpression: aFASTFortranAssignmentExpression [

	aFASTFortranAssignmentExpression children ifNotEmpty: [ "count := count + 1"
		subtreeRoots add: aFASTFortranAssignmentExpression ].
	aFASTFortranAssignmentExpression expression ifNotNil: [
		aFASTFortranAssignmentExpression expression accept: self ].
	aFASTFortranAssignmentExpression variable ifNotNil: [
		aFASTFortranAssignmentExpression variable accept: self ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranAssignmentStatement: aFASTFortranAssignmentStatement [

	aFASTFortranAssignmentStatement children ifNotEmpty: [ "count := count + 1 "
		subtreeRoots add: aFASTFortranAssignmentStatement ].
	aFASTFortranAssignmentStatement expression ifNotNil: [
		aFASTFortranAssignmentStatement expression accept: self ].
	aFASTFortranAssignmentStatement variable ifNotNil: [
		aFASTFortranAssignmentStatement variable accept: self ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranAsterisk: aFASTFortranAsterisk [

	aFASTFortranAsterisk children ifNotEmpty: [ "count := count + 1"
		subtreeRoots add: aFASTFortranAsterisk ].
	aFASTFortranAsterisk entryStatement ifNotNil: [
		aFASTFortranAsterisk entryStatement accept: self ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranBinaryExpression: aFASTFortranBinaryExpression [

	aFASTFortranBinaryExpression children ifNotEmpty: [ "count := count + 1"
		subtreeRoots add: aFASTFortranBinaryExpression ].
	aFASTFortranBinaryExpression leftOperand ifNotNil: [
		aFASTFortranBinaryExpression leftOperand accept: self ].
	aFASTFortranBinaryExpression rightOperand ifNotNil: [
		aFASTFortranBinaryExpression rightOperand accept: self ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranBooleanLiteral: aFASTFortranBooleanLiteral [

	aFASTFortranBooleanLiteral children ifNotEmpty: [
		subtreeRoots add: aFASTFortranBooleanLiteral ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranCallStatement: aFASTFortranCallStatement [

	aFASTFortranCallStatement children ifNotEmpty: [
		subtreeRoots add: aFASTFortranCallStatement ].
	aFASTFortranCallStatement arguments ifNotEmpty: [
		aFASTFortranCallStatement arguments do: [ :arg | arg accept: self ] ].
	aFASTFortranCallStatement statementContainer ifNotNil: [
		aFASTFortranCallStatement statementContainer accept: self ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranCharacterLiteral: aFASTFortranCharacterLiteral [

	aFASTFortranCharacterLiteral children ifNotEmpty: [
		subtreeRoots add: aFASTFortranCharacterLiteral ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranCharacterType: aFASTFortranCharacterType [

	aFASTFortranCharacterType children ifNotEmpty: [
		subtreeRoots add: aFASTFortranCharacterType ].
	aFASTFortranCharacterType size ifNotNil: [
		aFASTFortranCharacterType size accept: self ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranComment: aFASTFortranComment [

	aFASTFortranComment children ifNotEmpty: [ subtreeRoots add:aFASTFortranComment ].
	"aFASTFortranComment statementContainer ifNotNil: [
		aFASTFortranComment statementContainer accept: self ]"
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranCommonGroup: aFASTFortranCommonGroup [

	aFASTFortranCommonGroup children ifNotEmpty: [
		subtreeRoots add: aFASTFortranCommonGroup ].
	aFASTFortranCommonGroup declarators ifNotEmpty: [
		aFASTFortranCommonGroup declarators do: [ :decl | decl accept: self ] ].
	aFASTFortranCommonGroup invokedIn ifNotNil: [
		aFASTFortranCommonGroup invokedIn accept: self ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranCommonStatement: aFASTFortranCommonStatement [

	aFASTFortranCommonStatement children ifNotEmpty: [
		subtreeRoots add: aFASTFortranCommonStatement ].
	aFASTFortranCommonStatement groups ifNotEmpty: [
		aFASTFortranCommonStatement groups do: [ :grp | grp accept: self ] ]
	"aFASTFortranCommonStatement statementContainer ifNotNil: [
		aFASTFortranCommonStatement statementContainer accept: self ]"
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranContinueStatement: aFASTFortranContinueStatement [

	aFASTFortranContinueStatement children ifNotEmpty: [
		subtreeRoots add: aFASTFortranContinueStatement ]
	"aFASTFortranContinueStatement statementContainer ifNotNil: [
		aFASTFortranContinueStatement statementContainer accept: self ]"
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranDataGroup: aFASTFortranDataGroup [

	aFASTFortranDataGroup children ifNotEmpty: [
		subtreeRoots add: aFASTFortranDataGroup ].
	aFASTFortranDataGroup dataConstants ifNotEmpty: [
		aFASTFortranDataGroup dataConstants do: [ :const |
			const accept: self ] ]
	"aFASTFortranDataGroup withVariableGroups ifNotNil: [
		aFASTFortranDataGroup withVariableGroups accept: self ]"
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranDataStatement: aFASTFortranDataStatement [

	aFASTFortranDataStatement children ifNotEmpty: [
		subtreeRoots add: aFASTFortranDataStatement ].
	aFASTFortranDataStatement variableGroups ifNotEmpty: [
			aFASTFortranDataStatement variableGroups do: [ :grp |
				grp accept: self ] ]
	"aFASTFortranDataStatement statementContainer ifNotNil: [
		aFASTFortranDataStatement statementContainer accept: self ]"
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranDimensionStatement: aFASTFortranDimensionStatement [

	aFASTFortranDimensionStatement children ifNotEmpty: [
		subtreeRoots add: aFASTFortranDimensionStatement ].
	aFASTFortranDimensionStatement declarators ifNotEmpty: [
			aFASTFortranDimensionStatement declarators do: [ :decl |
				decl accept: self ] ]
	"aFASTFortranDimensionStatement statementContainer ifNotNil: [
		aFASTFortranDimensionStatement statementContainer accept: self ]"
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranDoStatement: aFASTFortranDoStatement [

	aFASTFortranDoStatement children ifNotEmpty: [
		subtreeRoots add: aFASTFortranDoStatement ].
	aFASTFortranDoStatement labelReferences ifNotEmpty: [
		aFASTFortranDoStatement labelReferences do: [ :ref |
			ref accept: self ] ].
	aFASTFortranDoStatement loopControl ifNotNil: [
		aFASTFortranDoStatement loopControl accept: self ].
	aFASTFortranDoStatement body ifNotNil: [
		aFASTFortranDoStatement body accept: self ]
	"aFASTFortranDoStatement statementContainer ifNotNil: [
		aFASTFortranDoStatement statementContainer accept: self ]"
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranDoublePrecisionType: aFASTFortranDoublePrecisionType [

	aFASTFortranDoublePrecisionType children ifNotEmpty: [
		subtreeRoots add:aFASTFortranDoublePrecisionType ].
	aFASTFortranDoublePrecisionType size ifNotNil: [
		aFASTFortranDoublePrecisionType size accept: self ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranEntryStatement: aFASTFortranEntryStatement [

	aFASTFortranEntryStatement children ifNotEmpty: [ subtreeRoots add:aFASTFortranEntryStatement ]

]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranEquivalenceGroup: aFASTFortranEquivalenceGroup [

	aFASTFortranEquivalenceGroup children ifNotEmpty: [
		subtreeRoots add:aFASTFortranEquivalenceGroup ].
	aFASTFortranEquivalenceGroup variables ifNotEmpty: [
		aFASTFortranEquivalenceGroup variables do: [ :v | v accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranEquivalenceStatement: aFASTFortranEquivalenceStatement [

	aFASTFortranEquivalenceStatement children ifNotEmpty: [
		subtreeRoots add:aFASTFortranEquivalenceStatement ].
	aFASTFortranEquivalenceStatement variableGroups ifNotEmpty: [
			aFASTFortranEquivalenceStatement variableGroups do: [ :grp |
				grp accept: self ] ].
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranExitStatement: aFASTFortranExitStatement [

	aFASTFortranExitStatement children ifNotEmpty: [ subtreeRoots add:aFASTFortranExitStatement ]
	
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranExternalStatement: aFASTFortranExternalStatement [

	aFASTFortranExternalStatement children ifNotEmpty: [
		subtreeRoots add:aFASTFortranExternalStatement ].
	aFASTFortranExternalStatement invokedIn ifNotNil: [
		aFASTFortranExternalStatement invokedIn accept: self ].
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranFieldAccess: aFASTFortranFieldAccess [

	aFASTFortranFieldAccess children ifNotEmpty: [ subtreeRoots add:aFASTFortranFieldAccess ].
	aFASTFortranFieldAccess pointer ifNotNil: [
		aFASTFortranFieldAccess pointer accept: self ].
	aFASTFortranFieldAccess field ifNotNil: [
		aFASTFortranFieldAccess field accept: self ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranFormatStatement: aFASTFortranFormatStatement [

	aFASTFortranFormatStatement children ifNotEmpty: [
		subtreeRoots add:aFASTFortranFormatStatement ].
	aFASTFortranFormatStatement format ifNotNil: [
		aFASTFortranFormatStatement format accept: self ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranFunction: aFASTFortranFunction [

	aFASTFortranFunction children ifNotEmpty: [ subtreeRoots add:aFASTFortranFunction ].

	aFASTFortranFunction declaredType ifNotNil: [
		aFASTFortranFunction declaredType accept: self ].
	aFASTFortranFunction parameters ifNotEmpty: [
		aFASTFortranFunction parameters do: [ :param | param accept: self ] ].
	aFASTFortranFunction comments ifNotNil: [
		aFASTFortranFunction comments do: [ :comment | comment accept: self ] ].
	aFASTFortranFunction statementBlock ifNotNil: [
		aFASTFortranFunction statementBlock accept: self ].
	aFASTFortranFunction declarations ifNotEmpty: [
			aFASTFortranFunction declarations do: [ :declaration |
				declaration accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranFunctionCall: aFASTFortranFunctionCall [

	aFASTFortranFunctionCall children ifNotEmpty: [ subtreeRoots add:aFASTFortranFunctionCall ].
	aFASTFortranFunctionCall arguments ifNotEmpty: [
		aFASTFortranFunctionCall arguments do: [ :arg | arg accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranFunctionStatement: aFASTFortranFunctionStatement [

	aFASTFortranFunctionStatement children ifNotEmpty: [
	subtreeRoots add:aFASTFortranFunctionStatement ].
	aFASTFortranFunctionStatement expression ifNotNil: [
		aFASTFortranFunctionStatement expression accept: self ].
	aFASTFortranFunctionStatement invokedIn ifNotNil: [
		aFASTFortranFunctionStatement invokedIn accept: self ].
	aFASTFortranFunctionStatement parameters ifNotEmpty: [
		aFASTFortranFunctionStatement parameters do: [ :p | p accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranFunctionTypeDeclarationStatement: aFASTFortranFunctionTypeDeclarationStatement [

	aFASTFortranFunctionTypeDeclarationStatement children ifNotEmpty: [
		subtreeRoots add:aFASTFortranFunctionTypeDeclarationStatement ].
	aFASTFortranFunctionTypeDeclarationStatement declaredType ifNotNil: [
		aFASTFortranFunctionTypeDeclarationStatement declaredType accept:
			self ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranGoToComputedStatement: aFASTFortranGoToComputedStatement [

	aFASTFortranGoToComputedStatement children ifNotEmpty: [
		subtreeRoots add:aFASTFortranGoToComputedStatement ].
	aFASTFortranGoToComputedStatement selectorExpression ifNotNil: [
		aFASTFortranGoToComputedStatement selectorExpression accept: self ].
	aFASTFortranGoToComputedStatement labelReferences ifNotEmpty: [
			aFASTFortranGoToComputedStatement labelReferences do: [ :ref |
				ref accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranGoToStatement: aFASTFortranGoToStatement [

	aFASTFortranGoToStatement children ifNotEmpty: [ subtreeRoots add:aFASTFortranGoToStatement ].
	aFASTFortranGoToStatement labelReferences ifNotEmpty: [
			aFASTFortranGoToStatement labelReferences do: [ :ref |
				ref accept: self ] ].
		
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranIOParameter: aFASTFortranIOParameter [ 
	
	aFASTFortranIOParameter children ifNotEmpty: [ subtreeRoots add:aFASTFortranIOParameter ].
	
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranIfArithmeticStatement: aFASTFortranIfArithmeticStatement [

	aFASTFortranIfArithmeticStatement children ifNotEmpty: [
		subtreeRoots add:aFASTFortranIfArithmeticStatement ].
	aFASTFortranIfArithmeticStatement lessLabel ifNotNil: [
		aFASTFortranIfArithmeticStatement lessLabel accept: self ].
	aFASTFortranIfArithmeticStatement equalLabel ifNotNil: [
		aFASTFortranIfArithmeticStatement equalLabel accept: self ].
	aFASTFortranIfArithmeticStatement greaterLabel ifNotNil: [
		aFASTFortranIfArithmeticStatement greaterLabel accept: self ].
	aFASTFortranIfArithmeticStatement condition ifNotNil: [
		aFASTFortranIfArithmeticStatement condition accept: self ].
	
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranIfBlockStatement: aFASTFortranIfBlockStatement [

	aFASTFortranIfBlockStatement children ifNotEmpty: [
		subtreeRoots add:aFASTFortranIfBlockStatement ].
	aFASTFortranIfBlockStatement thenStatementBlock ifNotNil: [
		aFASTFortranIfBlockStatement thenStatementBlock accept: self ].
	aFASTFortranIfBlockStatement elseStatementBlock ifNotNil: [
		aFASTFortranIfBlockStatement elseStatementBlock accept: self ].
	aFASTFortranIfBlockStatement condition ifNotNil: [
		aFASTFortranIfBlockStatement condition accept: self ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranIfLogicalStatement: aFASTFortranIfLogicalStatement [

	aFASTFortranIfLogicalStatement children ifNotEmpty: [
		subtreeRoots add:aFASTFortranIfLogicalStatement ].
	aFASTFortranIfLogicalStatement statement ifNotNil: [
		aFASTFortranIfLogicalStatement statement accept: self ].
	aFASTFortranIfLogicalStatement condition ifNotNil: [
		aFASTFortranIfLogicalStatement condition accept: self ].
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranImplicitRange: aFASTFortranImplicitRange [ 
	
	aFASTFortranImplicitRange children ifNotEmpty: [subtreeRoots add:aFASTFortranImplicitRange ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranImplicitStatement: aFASTFortranImplicitStatement [

	aFASTFortranImplicitStatement children ifNotEmpty: [
		subtreeRoots add:aFASTFortranImplicitStatement ].
	aFASTFortranImplicitStatement typingRules ifNotEmpty: [
			aFASTFortranImplicitStatement typingRules do: [ :rule |
				rule accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranImplicitTypingRule: aFASTFortranImplicitTypingRule [

	aFASTFortranImplicitTypingRule children ifNotEmpty: [
		subtreeRoots add:aFASTFortranImplicitTypingRule ].
	aFASTFortranImplicitTypingRule type ifNotNil: [
		aFASTFortranImplicitTypingRule type accept: self ].
	aFASTFortranImplicitTypingRule ranges ifNotEmpty: [
			aFASTFortranImplicitTypingRule ranges do: [ :range |
				range accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranImpliedDoExpression: aFASTFortranImpliedDoExpression [

	aFASTFortranImpliedDoExpression children ifNotEmpty: [
		subtreeRoots add:aFASTFortranImpliedDoExpression ].
	aFASTFortranImpliedDoExpression variables ifNotEmpty: [
			aFASTFortranImpliedDoExpression variables do: [ :var |
				var accept: self ] ].
	aFASTFortranImpliedDoExpression loopControl ifNotNil: [
		aFASTFortranImpliedDoExpression loopControl accept: self ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranInquireStatement: aFASTFortranInquireStatement [

	aFASTFortranInquireStatement children ifNotEmpty: [
		subtreeRoots add:aFASTFortranInquireStatement ].
	aFASTFortranInquireStatement ioParameters ifNotEmpty: [
			aFASTFortranInquireStatement ioParameters do: [ :param |
				param accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranIntegerLiteral: aFASTFortranIntegerLiteral [

	aFASTFortranIntegerLiteral children ifNotEmpty: [ subtreeRoots add:aFASTFortranIntegerLiteral ]
	
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranIntegerType: aFASTFortranIntegerType [

	aFASTFortranIntegerType children ifNotEmpty: [ subtreeRoots add:aFASTFortranIntegerType ].
	aFASTFortranIntegerType size ifNotNil: [
		aFASTFortranIntegerType size accept: self ].
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranIntrinsicStatement: aFASTFortranIntrinsicStatement [

	aFASTFortranIntrinsicStatement children ifNotEmpty: [
		subtreeRoots add:aFASTFortranIntrinsicStatement ].
	aFASTFortranIntrinsicStatement variables ifNotEmpty: [
			aFASTFortranIntrinsicStatement variables do: [ :var |
				var accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranLabelReference: aFASTFortranLabelReference [

	aFASTFortranLabelReference children ifNotEmpty: [ subtreeRoots add:aFASTFortranLabelReference ].
	"aFASTFortranLabelReference referencer ifNotNil: [
		aFASTFortranLabelReference referencer accept: self ]"
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranLogicalType: aFASTFortranLogicalType [

	aFASTFortranLogicalType children ifNotEmpty: [ subtreeRoots add:aFASTFortranLogicalType ].
	aFASTFortranLogicalType size ifNotNil: [
		aFASTFortranLogicalType size accept: self ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranLoopControlExpression: aFASTFortranLoopControlExpression [

	aFASTFortranLoopControlExpression children ifNotEmpty: [
		subtreeRoots add:aFASTFortranLoopControlExpression ].

	aFASTFortranLoopControlExpression init ifNotNil: [
		aFASTFortranLoopControlExpression init accept: self ].
	aFASTFortranLoopControlExpression increment ifNotNil: [
		aFASTFortranLoopControlExpression increment accept: self ].
	aFASTFortranLoopControlExpression limit ifNotNil: [
		aFASTFortranLoopControlExpression limit accept: self ].
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranOpenStatement: aFASTFortranOpenStatement [

	aFASTFortranOpenStatement children ifNotEmpty: [ subtreeRoots add:aFASTFortranOpenStatement ].
	aFASTFortranOpenStatement ioParameters ifNotEmpty: [
		aFASTFortranOpenStatement ioParameters do: [ :p | p accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranParameterStatement: aFASTFortranParameterStatement [

	aFASTFortranParameterStatement children ifNotEmpty: [
		subtreeRoots add:aFASTFortranParameterStatement ].
	aFASTFortranParameterStatement declarators ifNotEmpty: [
		aFASTFortranParameterStatement declarators do: [ :d |
			d accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranPauseStatement: aFASTFortranPauseStatement [ 
	
	aFASTFortranPauseStatement children ifNotEmpty: [ subtreeRoots add:aFASTFortranPauseStatement ].
	
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranPrintStatement: aFASTFortranPrintStatement [

	aFASTFortranPrintStatement children ifNotEmpty: [ subtreeRoots add:aFASTFortranPrintStatement ].
	aFASTFortranPrintStatement format ifNotNil: [
		aFASTFortranPrintStatement format accept: self ].
	aFASTFortranPrintStatement arguments ifNotEmpty: [
		aFASTFortranPrintStatement arguments do: [ :arg | arg accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranProgramMain: aFASTFortranProgramMain [

	aFASTFortranProgramMain children ifNotEmpty: [ subtreeRoots add:aFASTFortranProgramMain ].
	aFASTFortranProgramMain declarations ifNotEmpty: [
		aFASTFortranProgramMain declarations do: [ :dec | dec accept: self ] ].
	aFASTFortranProgramMain statementBlock ifNotNil: [
		aFASTFortranProgramMain statementBlock accept: self ].
	aFASTFortranProgramMain parameters ifNotEmpty: [
		aFASTFortranProgramMain parameters do: [ :p | p accept: self ] ].
	aFASTFortranProgramMain comments ifNotEmpty: [
		aFASTFortranProgramMain comments do: [ :c | c accept: self ] ].
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranReadStatement: aFASTFortranReadStatement [

	aFASTFortranReadStatement children ifNotEmpty: [ subtreeRoots add:aFASTFortranReadStatement ].
	aFASTFortranReadStatement arguments ifNotEmpty: [
		aFASTFortranReadStatement arguments do: [ :arg | arg accept: self ] ].
	aFASTFortranReadStatement ioParameters ifNotEmpty: [
		aFASTFortranReadStatement ioParameters do: [ :arg | arg accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranRealLiteral: aFASTFortranRealLiteral [ 
	
	aFASTFortranRealLiteral children ifNotEmpty: [ subtreeRoots add:aFASTFortranRealLiteral ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranRealType: aFASTFortranRealType [

	aFASTFortranRealType children ifNotEmpty: [ subtreeRoots add:aFASTFortranRealType ].
	aFASTFortranRealType size ifNotNil: [
		aFASTFortranRealType size accept: self ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranReturnStatement: aFASTFortranReturnStatement [

	aFASTFortranReturnStatement children ifNotEmpty: [
		subtreeRoots add:aFASTFortranReturnStatement ].

	aFASTFortranReturnStatement expression ifNotNil: [
		aFASTFortranReturnStatement expression accept: self ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranRewindStatement: aFASTFortranRewindStatement [

	aFASTFortranRewindStatement children ifNotEmpty: [
		subtreeRoots add:aFASTFortranRewindStatement ].
	aFASTFortranRewindStatement ioParameters ifNotEmpty: [
			aFASTFortranRewindStatement ioParameters do: [ :param |
				param accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranScalarVariable: aFASTFortranScalarVariable [
	aFASTFortranScalarVariable children ifNotEmpty: [
		subtreeRoots add:aFASTFortranScalarVariable ].
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranStatementBlock: aFASTFortranStatementBlock [

	aFASTFortranStatementBlock children ifNotEmpty: [
		subtreeRoots add:aFASTFortranStatementBlock ].
	aFASTFortranStatementBlock statements ifNotEmpty: [
			aFASTFortranStatementBlock statements do: [ :statement |
				statement accept: self ] ].

	aFASTFortranStatementBlock comments ifNotEmpty: [
			aFASTFortranStatementBlock comments do: [ :comment |
				comment accept: self ] ].
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranStopStatement: aFASTFortranStopStatement [ 
	
	aFASTFortranStopStatement children ifNotEmpty: [ subtreeRoots add:aFASTFortranStopStatement ].
	
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranSubroutine: aFASTFortranSubroutine [

	aFASTFortranSubroutine children ifNotEmpty: [ subtreeRoots add:aFASTFortranSubroutine ].
	aFASTFortranSubroutine declarations ifNotEmpty: [
		aFASTFortranSubroutine declarations do: [ :decl | decl accept: self ] ].

	aFASTFortranSubroutine comments ifNotEmpty: [
		aFASTFortranSubroutine comments do: [ :decl | decl accept: self ] ].
	aFASTFortranSubroutine parameters ifNotEmpty: [
		aFASTFortranSubroutine parameters do: [ :decl | decl accept: self ] ].
	aFASTFortranSubroutine statementBlock ifNotNil: [
		aFASTFortranSubroutine statementBlock accept: self ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranUnaryExpression: aFASTFortranUnaryExpression [

	aFASTFortranUnaryExpression children ifNotEmpty: [
		subtreeRoots add:aFASTFortranUnaryExpression ].
	aFASTFortranUnaryExpression expression ifNotNil: [
		aFASTFortranUnaryExpression expression accept: self ].
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement [

	aFASTFortranVariableDeclarationStatement children ifNotEmpty: [
		subtreeRoots add:aFASTFortranVariableDeclarationStatement ].
	aFASTFortranVariableDeclarationStatement declaredType ifNotNil: [
		aFASTFortranVariableDeclarationStatement declaredType accept: self ].
	aFASTFortranVariableDeclarationStatement declarators ifNotEmpty: [
			aFASTFortranVariableDeclarationStatement declarators do: [
				:declarator | declarator accept: self ] ]

]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranVariableDeclarator: aFASTFortranVariableDeclarator [

	aFASTFortranVariableDeclarator children ifNotEmpty: [
		subtreeRoots add:aFASTFortranVariableDeclarator ].
	aFASTFortranVariableDeclarator dimensions ifNotEmpty: [
			aFASTFortranVariableDeclarator dimensions do: [ :dim |
				dim accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitFASTFortranWriteStatement: aFASTFortranWriteStatement [

	aFASTFortranWriteStatement children ifNotEmpty: [subtreeRoots add:aFASTFortranWriteStatement ].
	aFASTFortranWriteStatement arguments ifNotEmpty: [
		aFASTFortranWriteStatement arguments do: [ :arg | arg accept: self ] ].
]

{ #category : 'visiting' }
FASTFortranSubtreeVisitor >> visitModel: aFASTModel [

	subtreeRoots := OrderedCollection new.

	(aFASTModel allWithSubTypesOf: FASTFortranProgramUnit) do: [ :e |
		e accept: self ].
	^subtreeRoots
	
]
