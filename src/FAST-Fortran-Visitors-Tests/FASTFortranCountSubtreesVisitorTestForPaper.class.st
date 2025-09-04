"
A FASTFortranExporterVisitorTest is a test class for testing the behavior of FASTFortranExporterVisitor
"
Class {
	#name : 'FASTFortranCountSubtreesVisitorTestForPaper',
	#superclass : 'FASTFortranAbstractVisitorTest',
	#category : 'FAST-Fortran-Visitors-Tests-Visitor',
	#package : 'FAST-Fortran-Visitors-Tests',
	#tag : 'Visitor'
}

{ #category : 'running' }
FASTFortranCountSubtreesVisitorTestForPaper >> newVisitor [

	^FASTFortranCountSubtreeVisitorComparing new
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTestForPaper >> testArrayDeclaration [

	| stmt |
	stmt := self arrayDeclaration: 'v' dimensions: #( #( '1' '10' ) ).

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testArrayDeclarationImplicitLowerBound [
	| stmt |
	stmt := self arrayDeclaration: 'v' dimensions: #( #('1' '10') ).
	stmt declarators first dimensions first lowerBound: nil.

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testArrayDeclarationMultipleDimensions [
	| stmt |
	stmt := self arrayDeclaration: 'v' dimensions: #( #('1' '10') #('-10' '-1') ).

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 4
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTestForPaper >> testArrayRange [
	| stmt |
	stmt := FASTFortranArrayRange new
			lowerBound: (self integerLiteral: '1') ;
			upperBound: (self scalarVariable: 'max') ;
		yourself.

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTestForPaper >> testArrayVariable [
	| stmt |
	stmt := FASTFortranArrayVariable new
		name: 'arr'.

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testAssignementFunctionCall [

	| stmt |
	stmt := self
		assignementStatement: #a 
		value: (self 
			functionCall: 'fct'
			arguments: {
				self integerLiteral: '5' .
				self scalarVariable: 'b' }).

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testAssignementStatementArrayAssigned [
	| stmt |
	stmt := FASTFortranAssignmentStatement new
		variable: (self 
			array: 'arr' access: { self scalarVariable: 'i' . self integerLiteral: '1'});
		expression: (self makeSimpleExpression: #b);
		yourself.

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testAssignementStatementLiteralValue [
	| stmt |
	stmt := self assignementStatement: #aVar value: (self logicalLiteral: '.true.').

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testAssignementStatementVariable [
	| stmt |
	stmt := self assignementStatement: #a value: #b.

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTestForPaper >> testBinaryExpression [
	| expr |
	expr := FASTFortranBinaryExpression new
		leftOperand: (self scalarVariable: 'a') ;
		operator: '+' ;
		rightOperand: (self integerLiteral: '5').

	expr accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTestForPaper >> testBinaryExpressionNe [
	| expr |
	expr := FASTFortranBinaryExpression new
		leftOperand: (self scalarVariable: 'a') ;
		operator: '.ne.' ;
		rightOperand: (self integerLiteral: '5').

	expr accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testBlockStatementWithCommentAndStatement [
	"note: positions are approximate, all we need is that the assignement is after the comment"
	| stmt cmt block |

	stmt := self assignementStatement: #i value: 1.
	stmt startPos: 34.
	stmt endPos: 38.

	cmt := self comment: 'C comment before assignement'.
	cmt startPos: 1.
	cmt endPos: 26.

	block := self statementBlock: { stmt }.
	block addComment: cmt.

	block accept: visitor.
	self assert: visitor subtreeRoots size equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testCallStatementExpressionArg [
	| stmt |
	stmt := self callStatement: 'subrtn' arguments: {
		self binary: '*' left: #a right: 5 }.

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testCallStatementNoArgs [
	| stmt |
	stmt := self callStatement: 'subrtn' arguments: #().

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testCallStatementWithArgs [
	| stmt |
	stmt := self callStatement: 'subrtn' arguments: {
		self scalarVariable: 'a' .
		self integerLiteral: '5' }.

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTestForPaper >> testComment [

	| cmt |
	cmt := self comment: 'C This is a comment'.

	cmt accept: visitor.

	self assert: visitor subtreeRoots size equals: 0
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTestForPaper >> testComment72Characters [
	| cmt |
	cmt := self comment: 'C 3456789 123456789 123456789 123456789 123456789 123456789 123456789 12'.

	cmt accept: visitor.

	self assert: visitor subtreeRoots size equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testCommonStatement [

	| stmt |

	stmt := FASTFortranCommonStatement new
		groups: {
			FASTFortranCommonGroup new
				declarators: (self variableDeclarators: #(a b))
			.
			FASTFortranCommonGroup new
				name: 'otherGrp' ;
				declarators: (self variableDeclarators: #(c d))
		} ;
		yourself.

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testContinueStatement [
	| stmt |
	stmt := FASTFortranContinueStatement new
		label: '110'.

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testDataStatement [

	| stmt |

	stmt := FASTFortranDataStatement new
		variableGroups: {
			FASTFortranDataGroup new
				variables: (self scalarVariables: #(a b)) ;
				dataConstants: { self characterLiteral: 'un' . self characterLiteral: 'deux' }
			.
			FASTFortranDataGroup new
				variables: (self scalarVariables: #(c)) ;
				dataConstants: { self characterLiteral: 'trois' }
		} ;
		yourself.

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testDimensionStatement [

	| stmt |

	stmt := FASTFortranDimensionStatement new
		declarators: {
			self arrayDeclarator: 'v' dimensions: #( #('1' '10') ) .
			self arrayDeclarator: 'm' dimensions: #( #('100') #('100') ) .
		}.

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 6
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testDoStatement [
	| stmt |

	stmt := self doStatement: #(i 1 max 1) statements: #().

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testDoStatementNoIncrement [
	| stmt |

	stmt := self doStatement: #(i 1 max) statements: #().

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testDoStatementWithLabel [

	| stmt |
	stmt := self
		        doStatement: #( i 1 max )
		        statements:
		        { (FASTFortranContinueStatement new label: '110') }.

	stmt labelReferences: { (self labelReference: '110') }.


	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 4
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTestForPaper >> testEmptySubroutineNoParameters [

	| sub |
	sub := self subroutine: 'blah'.

	sub accept: visitor.

	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTestForPaper >> testEmptySubroutineTwoParameters [

	| sub |
	sub := self subroutine: 'blah'.
	self entity: sub parameters: #( i j ).
	sub accept: visitor.
	self assert: visitor subtreeRoots size equals: 1



	"self assert: sub equals: '      subroutine blah(i,j)
      end
'"
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testEntryStatement [

	| stmt |
	stmt := FASTFortranEntryStatement new
		name: 'XYZ' ;
		entryArguments: { self scalarVariable: 'ABC' . FASTFortranAsterisk new } ;
		yourself.

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testEquivalenceStatement [

	| stmt |

	stmt := FASTFortranEquivalenceStatement new
		variableGroups: {
			FASTFortranEquivalenceGroup new
				variables: {
					self scalarVariable: #a .
					self arrayVariable: #b indice: '1'
				}
			.
			FASTFortranEquivalenceGroup new
				variables: (self scalarVariables: #(c d e))
		} ;
		yourself.

	
	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 4
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testExitStatement [
	| stmt |
	stmt := self exitStatement: nil.

	
	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testExternalStatement [
	| stmt |
	stmt := self externalStatement: 'aVar'.

	stmt accept: visitor.

	self assert: visitor subtreeRoots size equals:  0
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTestForPaper >> testFieldAccess [
	| fct varAccess writeStatement |
	fct := self functionDeclaration: 'blah'.
	fct declaredType: nil.

	varAccess := FASTFortranFieldAccess new
		pointer: (self scalarVariable: #p) ;
		field: (self scalarVariable: #x).
	writeStatement := self writeStatement: {  varAccess }.
	fct statementBlock addStatement: writeStatement.

	
	
	fct accept: visitor.
	self assert: visitor subtreeRoots size equals: 4
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testFormatStatement [
	| stmt |
	stmt := FASTFortranFormatStatement new
		formatDescription: '(/8x)' ;
		label: '110' ;
		yourself.

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testFunctionNoParameterNoStatement [

	| node |
	node := self functionDeclaration: 'BLAH'.
	node accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testFunctionNoParameterWithStatement [
	| node stmt |
	stmt := self returnStatement: (self scalarVariable: 'i').

	node := self functionDeclaration: 'BLAH'.
	node statementBlock: (self statementBlock: { stmt }).

	node accept: visitor.
	self assert: visitor subtreeRoots size equals: 3
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTestForPaper >> testFunctionNoReturnType [
	| fct |
	fct := self functionDeclaration: 'blah'.
	fct declaredType: nil.

	fct accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testFunctionStatement [
	| node |
	node := FASTFortranFunctionStatement new.
	node name: 'fct'.
	node parameters: (self scalarVariables: #(x y)).
	node expression: (self binary: '+' left: #x right: 2).

	node accept: visitor.
	self assert: visitor subtreeRoots size equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testFunctionWithParameterNoStatement [
	| node |
	node := self functionDeclaration: 'BLAH'.
	self entity: node parameters: #(i j).

	node accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testGotoComputedStatement [
	| stmt |
	stmt := FASTFortranGoToComputedStatement new
		labelReferences: { self labelReference: '110' . self labelReference: '120' . self labelReference: '130'} ;
		selectorExpression: (self scalarVariable: 'i') ;
		yourself.

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testGotoStatement [
	| stmt |
	stmt := self gotoStatement: '110'.

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testIfArithmeticStatement [
	| stmt |

	stmt := self ifArithmetic: #a negative: 10 null: 20 positive: 30.

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testIfBlockStatementEmpty [
	| stmt |
	stmt := self ifBlock: (self scalarVariable: 'bool') then: #() else: nil.

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testIfBlockStatementEmptyBinaryCondition [

	| stmt cond |
	cond := self binary: '.gt.' left: #a right: 0.
	stmt := self ifBlock: cond then: #(  ) else: nil.
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testIfBlockStatementNested [
	| stmt |
	stmt := self
		ifBlock: (self scalarVariable: 'bool1')
		then: { self
			ifBlock: (self scalarVariable: 'bool2')
			then: #()
			else: nil }
		else: nil.

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testIfBlockStatementWithElseBlock [
	| stmt |
	stmt := self
		ifBlock: (self scalarVariable: 'bool')
		then: #()
		else:  {  self returnStatement: nil }.

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testIfBlockStatementWithThenBlock [
	| stmt |
	stmt := self
		ifBlock: (self scalarVariable: 'bool')
		then: {  self returnStatement: nil }
		else: nil.

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testIfLogicalStatementEmpty [
	| stmt |
	stmt := FASTFortranIfLogicalStatement new
		condition: (self scalarVariable: 'bool') ;
		statement: FASTFortranReturnStatement new ;
		yourself.

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testImplicitStatement [
	| stmt |
	stmt := self implicitStatement.

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testImplicitStatementSeveralRules [

	| stmt |
	stmt := self implicitStatement.
	stmt addTypingRule: (FASTFortranImplicitTypingRule new
			 type: (self logicalType: nil);
			 ranges: { (self implicitRange: 'l' to: 'n') }).
	stmt addTypingRule: (FASTFortranImplicitTypingRule new
			 type: (self integerType: nil);
			 ranges: {
					 (self implicitRange: 'c' to: nil).
					 (self implicitRange: 's' to: nil) }).

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testImpliedDoExpression [
	| expr |

	expr := FASTFortranImpliedDoExpression new
		loopControl: (self loopControlInit: #(i 1) increment: 1 limit: #max) ;
		variables: (self scalarVariables: #(v i)).

	expr accept: visitor.
	self assert: visitor subtreeRoots size equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testInquireStatement [
	| stmt |
	stmt := FASTFortranInquireStatement new
		ioParameters: {
			self integerLiteral: '3' .
			self assignementExpression: #iostat value: #stat .
			self assignementExpression: #err value: 10
		}.

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testIntrinsicStatement [

	| stmt |

	stmt := FASTFortranIntrinsicStatement new
		variables: (self scalarVariables: #(sin cos)) ;
		yourself.

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testLabelledStatement [
	| stmt |
	stmt := self returnStatement: nil.
	stmt label: '100'.

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 0
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTestForPaper >> testLongDataStatementLine [

	| stmt |

	stmt := FASTFortranDataStatement new
		variableGroups: {
			FASTFortranDataGroup new
				variables: (self scalarVariables: #(abcde fghijk lmnopq)) ;
				dataConstants: {
					self characterLiteral: '---------------' .
					self characterLiteral: '---------------' .
					self characterLiteral: '---------------' }
		} ;
		yourself.

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 2
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTestForPaper >> testLongFormatLine [

	| stmt |

	stmt := FASTFortranFormatStatement new
		formatDescription: '(1h,//36hxabs-(156)intrinsicfunctions--//11x,26habs,iabs(absolutevalue)//20hsubsetref.-15.3)' ;
		label: '110' ;
		yourself.

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 0
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTestForPaper >> testLongLine [
	| stmt |
	stmt := self declarationStatement: #character variables: #(abc1 abc2 abc3 abc4 abc5 abc6 abc7 abc8 abc9 abc10 abc11 abc12 abc13 abc14 abc15 abc16 abc17 abc18 abc19 abc20 abc21 abc22 abc23 abc24 abc25).

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTestForPaper >> testLongLineDontBreak [
	| stmt |
	stmt := self declarationStatement: #character variables: #(abc1 abc2 abc3 abc4 abc5 abc6 abc7 abc8 abc9 abc10 abc11 abc12 abc13 abc14 abc15 abc16 abc17 abc18 abc19 abc20 abc21 abc22 abc23 abc24 abc25).

	"visitor dontBreakLongLines.
"
	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testMainProgram [
	| node |
	node := FASTFortranProgramMain new
		name: 'BLAH' ;
		statementBlock: FASTFortranStatementBlock new
		yourself.

	
	node accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testOneDeclarationCharacterType [
	| stmt |
	stmt := self declarationStatement: #character variables: #(r).

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testOneDeclarationCharacterTypeStarSize [
	| stmt |
	stmt := self declarationStatement: #(character *) variables: #(str).

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testOneDeclarationCharacterTypeWithSize [
	| stmt |
	stmt := self declarationStatement: #(character 10) variables: #(str).

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testOneDeclarationDoublePrecisionType [
	| stmt |
	stmt := self declarationStatement: (FASTFortranDoublePrecisionType new) variables: #(r).

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testOneDeclarationIntegerTypeWithSize [
	| stmt |
	stmt := self declarationStatement: #(integer 8) variables: #(i).

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testOneDeclarationLogicalType [
	| stmt |
	stmt := self declarationStatement: #logical variables: #(r).

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testOneDeclarationRealType [
	| stmt |
	stmt := self declarationStatement: #real variables: #(r).

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testOneDeclarationTwoVariables [
	| stmt |
	stmt := FASTFortranFunctionTypeDeclarationStatement new
		declaredType: (self makeType: #integer) ;
		name: 'fct';
		startPos: 1 ;
		endPos: 10.

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testOpenStatement [
	| stmt |
	stmt := FASTFortranOpenStatement new
		ioParameters: {
			self integerLiteral: '3' .
			self ioParameter: #file value: 'projectA/data.test'.
			self ioParameter: #err value: 99
		}.

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 3
]

{ #category : 'tests - operator precedence' }
FASTFortranCountSubtreesVisitorTestForPaper >> testOperatorsPrecedenceNoParentheses [
	
	| expr |
	expr := self binary: '+' left: #v right: 5.

	
	expr accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - operator precedence' }
FASTFortranCountSubtreesVisitorTestForPaper >> testOperatorsPrecedenceSubHasHigherPrecedence [
	
	| expr |
	expr := self binary: '+' left: #i right: 5.
	expr rightOperand: (self binary: '*' left: #j right: 5).

		
	expr accept: visitor.
	self assert: visitor subtreeRoots size equals: 2
]

{ #category : 'tests - operator precedence' }
FASTFortranCountSubtreesVisitorTestForPaper >> testOperatorsPrecedenceSubHasLowerPrecedence [
	
	| expr |
	expr := self binary: '*' left: #i right: 5.
	expr rightOperand: (self binary: '+' left: #j right: 5).

		
	expr accept: visitor.
	self assert: visitor subtreeRoots size equals: 2
]

{ #category : 'tests - operator precedence' }
FASTFortranCountSubtreesVisitorTestForPaper >> testOperatorsPrecedenceSubUnary [
	
	| expr |
	expr := self binary: '.and.' left: #logical1 right: (self unary: '.not.' operand: #logical2).

		
	expr accept: visitor.
	self assert: visitor subtreeRoots size equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testPauseStatementEmpty [
	| stmt |
	stmt := FASTFortranPauseStatement new.

		
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testPauseStatementWithInteger [
	| stmt |
	stmt := FASTFortranParameterStatement new
		declarators: (self variableDeclarators: #(pi msg)) ;
		yourself.
	stmt declarators first expression: (self realLiteral: '3.14159').
	stmt declarators second expression: (self characterLiteral: 'hello').

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testPauseStatementWithString [
	| stmt |
	stmt := FASTFortranPauseStatement new
		displayArgument: '''error''' ;
		yourself.

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testPrintStatement [
	| stmt |
	stmt := self printStatement: { self characterLiteral: 'message' }.

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testReadStatement [
	| stmt |
	stmt := self
		readStatement: #(V)
		ioParams: {
			1 .
			self assignementExpression: #rec value: 3 .
			self assignementExpression: #iostat value: #N .
			self assignementExpression: #err value: 8
		}.

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 4
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testReturnStatementEmpty [
	| stmt |
	stmt :=  self returnStatement: nil.

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testReturnStatementLiteralValue [
	| stmt |
	stmt := self returnStatement: (self realLiteral: '3.5').

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testRewindStatement [
	| stmt |
	stmt := FASTFortranRewindStatement new
		ioParameters: {
			self integerLiteral: '3' .
			self assignementExpression: #iostat value: #stat.
			self assignementExpression: #err value: 10
		}.

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testStopStatementEmpty [
	| stmt |
	stmt := FASTFortranStopStatement new.

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testStopStatementWithInteger [
	| stmt |
	stmt := FASTFortranStopStatement new
		displayArgument: '1' ;
		yourself.

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testStopStatementWithString [
	| stmt |
	stmt := FASTFortranStopStatement new
		displayArgument: '''error''' ;
		yourself.

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 0
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTestForPaper >> testStringConcatOperator [
	| stmt |
	stmt := self binary: '//' left: #texte right: ' a string'.

	
	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testStringLiteralWithQuote [
	| expr |
	expr := self characterLiteral: 'a ''''string'''' with quotes'.

	
	expr accept: visitor.
	self assert: visitor subtreeRoots size equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testTwoDeclarationsTwoVariables [
	| sub stmt |
	sub := self subroutine: 'blah'.

	stmt := self
		declarationStatement: #integer
		variables: #(i).
	sub statementBlock addStatement: stmt.

	stmt := self
		declarationStatement: #integer
		variables: #(j).
	stmt startPos: 11.
	stmt endPos: 15.
	sub statementBlock addStatement: stmt.

	sub accept: visitor.
	self assert: visitor subtreeRoots size equals: 4
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTestForPaper >> testWriteStatement [
	| stmt |
	stmt := self writeStatement: #( 'message' ).

	stmt accept: visitor.
	self assert: visitor subtreeRoots size equals: 1
]
