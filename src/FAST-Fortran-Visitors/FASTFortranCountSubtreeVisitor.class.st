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

	aFASTFortranArrayRange children ifNotEmpty: [
		count := count + 1 ].

	aFASTFortranArrayRange lowerBound ifNotNil: [
		aFASTFortranArrayRange lowerBound accept: self ].

	aFASTFortranArrayRange upperBound ifNotNil: [
		aFASTFortranArrayRange upperBound accept: self ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranArrayVariable: aFASTFortranArrayVariable [

	aFASTFortranArrayVariable children ifNotEmpty: [ count := count + 1 ].
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
FASTFortranCountSubtreeVisitor >> visitFASTFortranAssignmentExpression: aFASTFortranAssignmentExpression [

	aFASTFortranAssignmentExpression children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranAssignmentExpression expression ifNotNil: [
		aFASTFortranAssignmentExpression expression accept: self ].
	aFASTFortranAssignmentExpression variable ifNotNil: [
		aFASTFortranAssignmentExpression variable accept: self ].
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranAssignmentStatement: aFASTFortranAssignmentStatement [

	aFASTFortranAssignmentStatement children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranAssignmentStatement expression ifNotNil: [
		aFASTFortranAssignmentStatement expression accept: self ].
	aFASTFortranAssignmentStatement variable ifNotNil: [
		aFASTFortranAssignmentStatement variable accept: self ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranAsterisk: aFASTFortranAsterisk [

	aFASTFortranAsterisk children ifNotEmpty: [ count := count + 1 ].
	aFASTFortranAsterisk entryStatement ifNotNil: [
		aFASTFortranAsterisk entryStatement accept: self ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranBinaryExpression: aFASTFortranBinaryExpression [

	aFASTFortranBinaryExpression children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranBinaryExpression leftOperand ifNotNil: [
		aFASTFortranBinaryExpression leftOperand accept: self ].
	aFASTFortranBinaryExpression rightOperand ifNotNil: [
		aFASTFortranBinaryExpression rightOperand accept: self ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranBooleanLiteral: aFASTFortranBooleanLiteral [

	aFASTFortranBooleanLiteral children ifNotEmpty: [ count := count + 1 ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranCallStatement: aFASTFortranCallStatement [

	aFASTFortranCallStatement children ifNotEmpty: [ count := count + 1 ].
	aFASTFortranCallStatement arguments ifNotEmpty: [
		aFASTFortranCallStatement arguments do: [ :arg | arg accept: self ] ].
	aFASTFortranCallStatement statementContainer ifNotNil: [
		aFASTFortranCallStatement statementContainer accept: self ].
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranCharacterLiteral: aFASTFortranCharacterLiteral [ 
	
	aFASTFortranCharacterLiteral children ifNotEmpty: [
		count := count + 1 ].

]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranCharacterType: aFASTFortranCharacterType [

	aFASTFortranCharacterType children ifNotEmpty: [ count := count + 1 ].
	aFASTFortranCharacterType size ifNotNil: [
		aFASTFortranCharacterType size accept: self ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranComment: aFASTFortranComment [

	aFASTFortranComment children ifNotEmpty: [ count := count + 1 ].
	"aFASTFortranComment statementContainer ifNotNil: [
		aFASTFortranComment statementContainer accept: self ]"
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranCommonGroup: aFASTFortranCommonGroup [

	aFASTFortranCommonGroup children ifNotEmpty: [ count := count + 1 ].
	aFASTFortranCommonGroup declarators ifNotEmpty: [
		aFASTFortranCommonGroup declarators do: [ :decl | decl accept: self ] ].
	aFASTFortranCommonGroup invokedIn ifNotNil: [
		aFASTFortranCommonGroup invokedIn accept: self ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranCommonStatement: aFASTFortranCommonStatement [

	aFASTFortranCommonStatement children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranCommonStatement groups ifNotEmpty: [
		aFASTFortranCommonStatement groups do: [ :grp | grp accept: self ] ].
	"aFASTFortranCommonStatement statementContainer ifNotNil: [
		aFASTFortranCommonStatement statementContainer accept: self ]"
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranContinueStatement: aFASTFortranContinueStatement [

	aFASTFortranContinueStatement children ifNotEmpty: [
		count := count + 1 ].
	"aFASTFortranContinueStatement statementContainer ifNotNil: [
		aFASTFortranContinueStatement statementContainer accept: self ]"
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranDataGroup: aFASTFortranDataGroup [

	aFASTFortranDataGroup children ifNotEmpty: [ count := count + 1 ].
	aFASTFortranDataGroup dataConstants ifNotEmpty: [
		aFASTFortranDataGroup dataConstants do: [ :const |
			const accept: self ] ].
	"aFASTFortranDataGroup withVariableGroups ifNotNil: [
		aFASTFortranDataGroup withVariableGroups accept: self ]"
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranDataStatement: aFASTFortranDataStatement [

	aFASTFortranDataStatement children ifNotEmpty: [ count := count + 1 ].
	aFASTFortranDataStatement variableGroups ifNotEmpty: [
			aFASTFortranDataStatement variableGroups do: [ :grp |
				grp accept: self ] ].
	"aFASTFortranDataStatement statementContainer ifNotNil: [
		aFASTFortranDataStatement statementContainer accept: self ]"
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranDimensionStatement: aFASTFortranDimensionStatement [

	aFASTFortranDimensionStatement children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranDimensionStatement declarators ifNotEmpty: [
			aFASTFortranDimensionStatement declarators do: [ :decl |
				decl accept: self ] ].
	"aFASTFortranDimensionStatement statementContainer ifNotNil: [
		aFASTFortranDimensionStatement statementContainer accept: self ]"
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranDoStatement: aFASTFortranDoStatement [

	aFASTFortranDoStatement children ifNotEmpty: [ count := count + 1 ].
	aFASTFortranDoStatement labelReferences ifNotEmpty: [
		aFASTFortranDoStatement labelReferences do: [ :ref |
			ref accept: self ] ].
	aFASTFortranDoStatement loopControl ifNotNil: [
		aFASTFortranDoStatement loopControl accept: self ].
	aFASTFortranDoStatement body ifNotNil: [
		aFASTFortranDoStatement body accept: self ].
	"aFASTFortranDoStatement statementContainer ifNotNil: [
		aFASTFortranDoStatement statementContainer accept: self ]"
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranDoublePrecisionType: aFASTFortranDoublePrecisionType [

	aFASTFortranDoublePrecisionType children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranDoublePrecisionType size ifNotNil: [
		aFASTFortranDoublePrecisionType size accept: self ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranEntryStatement: aFASTFortranEntryStatement [

	aFASTFortranEntryStatement children ifNotEmpty: [ count := count + 1 ]

]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranEquivalenceGroup: aFASTFortranEquivalenceGroup [

	aFASTFortranEquivalenceGroup children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranEquivalenceGroup variables ifNotEmpty: [
		aFASTFortranEquivalenceGroup variables do: [ :v | v accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranEquivalenceStatement: aFASTFortranEquivalenceStatement [

	aFASTFortranEquivalenceStatement children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranEquivalenceStatement variableGroups ifNotEmpty: [
			aFASTFortranEquivalenceStatement variableGroups do: [ :grp |
				grp accept: self ] ].
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranExitStatement: aFASTFortranExitStatement [

	aFASTFortranExitStatement children ifNotEmpty: [ count := count + 1 ]
	
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranExternalStatement: aFASTFortranExternalStatement [

	aFASTFortranExternalStatement children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranExternalStatement invokedIn ifNotNil: [
		aFASTFortranExternalStatement invokedIn accept: self ].
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranFieldAccess: aFASTFortranFieldAccess [

	aFASTFortranFieldAccess children ifNotEmpty: [ count := count + 1 ].
	aFASTFortranFieldAccess pointer ifNotNil: [
		aFASTFortranFieldAccess pointer accept: self ].
	aFASTFortranFieldAccess field ifNotNil: [
		aFASTFortranFieldAccess field accept: self ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranFormatStatement: aFASTFortranFormatStatement [

	aFASTFortranFormatStatement children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranFormatStatement format ifNotNil: [
		aFASTFortranFormatStatement format accept: self ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranFunction: aFASTFortranFunction [

	aFASTFortranFunction children ifNotEmpty: [ count := count + 1 ].

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
FASTFortranCountSubtreeVisitor >> visitFASTFortranFunctionCall: aFASTFortranFunctionCall [

	aFASTFortranFunctionCall children ifNotEmpty: [ count := count + 1 ].
	aFASTFortranFunctionCall arguments ifNotEmpty: [
		aFASTFortranFunctionCall arguments do: [ :arg | arg accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranFunctionStatement: aFASTFortranFunctionStatement [

	aFASTFortranFunctionStatement children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranFunctionStatement expression ifNotNil: [
		aFASTFortranFunctionStatement expression accept: self ].
	aFASTFortranFunctionStatement invokedIn ifNotNil: [
		aFASTFortranFunctionStatement invokedIn accept: self ].
	aFASTFortranFunctionStatement parameters ifNotEmpty: [
		aFASTFortranFunctionStatement parameters do: [ :p | p accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranFunctionTypeDeclarationStatement: aFASTFortranFunctionTypeDeclarationStatement [

	aFASTFortranFunctionTypeDeclarationStatement children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranFunctionTypeDeclarationStatement declaredType ifNotNil: [
		aFASTFortranFunctionTypeDeclarationStatement declaredType accept:
			self ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranGoToComputedStatement: aFASTFortranGoToComputedStatement [

	aFASTFortranGoToComputedStatement children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranGoToComputedStatement selectorExpression ifNotNil: [
		aFASTFortranGoToComputedStatement selectorExpression accept: self ].
	aFASTFortranGoToComputedStatement labelReferences ifNotEmpty: [
			aFASTFortranGoToComputedStatement labelReferences do: [ :ref |
				ref accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranGoToStatement: aFASTFortranGoToStatement [

	aFASTFortranGoToStatement children ifNotEmpty: [ count := count + 1 ].
	aFASTFortranGoToStatement labelReferences ifNotEmpty: [
			aFASTFortranGoToStatement labelReferences do: [ :ref |
				ref accept: self ] ].
		
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranIOParameter: aFASTFortranIOParameter [ 
	
	aFASTFortranIOParameter children ifNotEmpty: [ count := count + 1 ].
	
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranIfArithmeticStatement: aFASTFortranIfArithmeticStatement [

	aFASTFortranIfArithmeticStatement children ifNotEmpty: [
		count := count + 1 ].
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
FASTFortranCountSubtreeVisitor >> visitFASTFortranIfBlockStatement: aFASTFortranIfBlockStatement [

	aFASTFortranIfBlockStatement children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranIfBlockStatement thenStatementBlock ifNotNil: [
		aFASTFortranIfBlockStatement thenStatementBlock accept: self ].
	aFASTFortranIfBlockStatement elseStatementBlock ifNotNil: [
		aFASTFortranIfBlockStatement elseStatementBlock accept: self ].
	aFASTFortranIfBlockStatement condition ifNotNil: [
		aFASTFortranIfBlockStatement condition accept: self ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranIfLogicalStatement: aFASTFortranIfLogicalStatement [

	aFASTFortranIfLogicalStatement children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranIfLogicalStatement statement ifNotNil: [
		aFASTFortranIfLogicalStatement statement accept: self ].
	aFASTFortranIfLogicalStatement condition ifNotNil: [
		aFASTFortranIfLogicalStatement condition accept: self ].
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranImplicitRange: aFASTFortranImplicitRange [ 
	
	aFASTFortranImplicitRange children ifNotEmpty: [ count := count + 1 ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranImplicitStatement: aFASTFortranImplicitStatement [

	aFASTFortranImplicitStatement children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranImplicitStatement typingRules ifNotEmpty: [
			aFASTFortranImplicitStatement typingRules do: [ :rule |
				rule accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranImplicitTypingRule: aFASTFortranImplicitTypingRule [

	aFASTFortranImplicitTypingRule children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranImplicitTypingRule type ifNotNil: [
		aFASTFortranImplicitTypingRule type accept: self ].
	aFASTFortranImplicitTypingRule ranges ifNotEmpty: [
			aFASTFortranImplicitTypingRule ranges do: [ :range |
				range accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranImpliedDoExpression: aFASTFortranImpliedDoExpression [

	aFASTFortranImpliedDoExpression children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranImpliedDoExpression variables ifNotEmpty: [
			aFASTFortranImpliedDoExpression variables do: [ :var |
				var accept: self ] ].
	aFASTFortranImpliedDoExpression loopControl ifNotNil: [
		aFASTFortranImpliedDoExpression loopControl accept: self ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranInquireStatement: aFASTFortranInquireStatement [

	aFASTFortranInquireStatement children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranInquireStatement ioParameters ifNotEmpty: [
			aFASTFortranInquireStatement ioParameters do: [ :param |
				param accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranIntegerLiteral: aFASTFortranIntegerLiteral [

	aFASTFortranIntegerLiteral children ifNotEmpty: [ count := count + 1 ]
	
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranIntegerType: aFASTFortranIntegerType [

	aFASTFortranIntegerType children ifNotEmpty: [ count := count + 1 ].
	aFASTFortranIntegerType size ifNotNil: [
		aFASTFortranIntegerType size accept: self ].
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranIntrinsicStatement: aFASTFortranIntrinsicStatement [

	aFASTFortranIntrinsicStatement children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranIntrinsicStatement variables ifNotEmpty: [
			aFASTFortranIntrinsicStatement variables do: [ :var |
				var accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranLabelReference: aFASTFortranLabelReference [

	aFASTFortranLabelReference children ifNotEmpty: [ count := count + 1 ].
	"aFASTFortranLabelReference referencer ifNotNil: [
		aFASTFortranLabelReference referencer accept: self ]"
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranLogicalType: aFASTFortranLogicalType [

	aFASTFortranLogicalType children ifNotEmpty: [ count := count + 1 ].
	aFASTFortranLogicalType size ifNotNil: [
		aFASTFortranLogicalType size accept: self ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranLoopControlExpression: aFASTFortranLoopControlExpression [

	aFASTFortranLoopControlExpression children ifNotEmpty: [
		count := count + 1 ].

	aFASTFortranLoopControlExpression init ifNotNil: [
		aFASTFortranLoopControlExpression init accept: self ].
	aFASTFortranLoopControlExpression increment ifNotNil: [
		aFASTFortranLoopControlExpression increment accept: self ].
	aFASTFortranLoopControlExpression limit ifNotNil: [
		aFASTFortranLoopControlExpression limit accept: self ].
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranOpenStatement: aFASTFortranOpenStatement [

	aFASTFortranOpenStatement children ifNotEmpty: [ count := count + 1 ].
	aFASTFortranOpenStatement ioParameters ifNotEmpty: [
		aFASTFortranOpenStatement ioParameters do: [ :p | p accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranParameterStatement: aFASTFortranParameterStatement [

	aFASTFortranParameterStatement children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranParameterStatement declarators ifNotEmpty: [
		aFASTFortranParameterStatement declarators do: [ :d |
			d accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranPauseStatement: aFASTFortranPauseStatement [ 
	
	aFASTFortranPauseStatement children ifNotEmpty: [ count := count + 1 ].
	
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranPrintStatement: aFASTFortranPrintStatement [

	aFASTFortranPrintStatement children ifNotEmpty: [ count := count + 1 ].
	aFASTFortranPrintStatement format ifNotNil: [
		aFASTFortranPrintStatement format accept: self ].
	aFASTFortranPrintStatement arguments ifNotEmpty: [
		aFASTFortranPrintStatement arguments do: [ :arg | arg accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranProgramMain: aFASTFortranProgramMain [

	aFASTFortranProgramMain children ifNotEmpty: [ count := count + 1 ].
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
FASTFortranCountSubtreeVisitor >> visitFASTFortranReadStatement: aFASTFortranReadStatement [

	aFASTFortranReadStatement children ifNotEmpty: [ count := count + 1 ].
	aFASTFortranReadStatement arguments ifNotEmpty: [
		aFASTFortranReadStatement arguments do: [ :arg | arg accept: self ] ].
	aFASTFortranReadStatement ioParameters ifNotEmpty: [
		aFASTFortranReadStatement ioParameters do: [ :arg | arg accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranRealLiteral: aFASTFortranRealLiteral [ 
	
	aFASTFortranRealLiteral children ifNotEmpty: [ count := count + 1 ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranRealType: aFASTFortranRealType [

	aFASTFortranRealType children ifNotEmpty: [ count := count + 1 ].
	aFASTFortranRealType size ifNotNil: [
		aFASTFortranRealType size accept: self ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranReturnStatement: aFASTFortranReturnStatement [

	aFASTFortranReturnStatement children ifNotEmpty: [
		count := count + 1 ].

	aFASTFortranReturnStatement expression ifNotNil: [
		aFASTFortranReturnStatement expression accept: self ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranRewindStatement: aFASTFortranRewindStatement [

	aFASTFortranRewindStatement children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranRewindStatement ioParameters ifNotEmpty: [
			aFASTFortranRewindStatement ioParameters do: [ :param |
				param accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranScalarVariable: aFASTFortranScalarVariable [
	aFASTFortranScalarVariable children ifNotEmpty: [
		count := count + 1 ].
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranStatementBlock: aFASTFortranStatementBlock [

	aFASTFortranStatementBlock children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranStatementBlock statements ifNotEmpty: [
			aFASTFortranStatementBlock statements do: [ :statement |
				statement accept: self ] ].

	aFASTFortranStatementBlock comments ifNotEmpty: [
			aFASTFortranStatementBlock comments do: [ :comment |
				comment accept: self ] ].
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranStopStatement: aFASTFortranStopStatement [ 
	
	aFASTFortranStopStatement children ifNotEmpty: [ count := count + 1 ].
	
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranSubroutine: aFASTFortranSubroutine [

	aFASTFortranSubroutine children ifNotEmpty: [ count := count + 1 ].
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
FASTFortranCountSubtreeVisitor >> visitFASTFortranUnaryExpression: aFASTFortranUnaryExpression [

	aFASTFortranUnaryExpression children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranUnaryExpression expression ifNotNil: [
		aFASTFortranUnaryExpression expression accept: self ].
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement [

	aFASTFortranVariableDeclarationStatement children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranVariableDeclarationStatement declaredType ifNotNil: [
		aFASTFortranVariableDeclarationStatement declaredType accept: self ].
	aFASTFortranVariableDeclarationStatement declarators ifNotEmpty: [
			aFASTFortranVariableDeclarationStatement declarators do: [
				:declarator | declarator accept: self ] ]

]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranVariableDeclarator: aFASTFortranVariableDeclarator [

	aFASTFortranVariableDeclarator children ifNotEmpty: [
		count := count + 1 ].
	aFASTFortranVariableDeclarator dimensions ifNotEmpty: [
			aFASTFortranVariableDeclarator dimensions do: [ :dim |
				dim accept: self ] ]
]

{ #category : 'visiting' }
FASTFortranCountSubtreeVisitor >> visitFASTFortranWriteStatement: aFASTFortranWriteStatement [

	aFASTFortranWriteStatement children ifNotEmpty: [ count := count + 1 ].
	aFASTFortranWriteStatement arguments ifNotEmpty: [
		aFASTFortranWriteStatement arguments do: [ :arg | arg accept: self ] ].
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
