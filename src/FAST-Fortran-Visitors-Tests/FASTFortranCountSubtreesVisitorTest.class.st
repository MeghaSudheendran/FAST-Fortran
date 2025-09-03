"
A FASTFortranExporterVisitorTest is a test class for testing the behavior of FASTFortranExporterVisitor
"
Class {
	#name : 'FASTFortranCountSubtreesVisitorTest',
	#superclass : 'FASTFortranAbstractVisitorTest',
	#category : 'FAST-Fortran-Visitors-Tests-Visitor',
	#package : 'FAST-Fortran-Visitors-Tests',
	#tag : 'Visitor'
}

{ #category : 'running' }
FASTFortranCountSubtreesVisitorTest >> newVisitor [

	^FASTFortranCountSubtreeVisitor new
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTest >> testArrayDeclaration [

	| stmt |
	stmt := self arrayDeclaration: 'v' dimensions: #( #( '1' '10' ) ).

	stmt accept: visitor.
	self assert: visitor count equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testArrayDeclarationImplicitLowerBound [
	| stmt |
	stmt := self arrayDeclaration: 'v' dimensions: #( #('1' '10') ).
	stmt declarators first dimensions first lowerBound: nil.

	stmt accept: visitor.
	self assert: visitor count equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testArrayDeclarationMultipleDimensions [
	| stmt |
	stmt := self arrayDeclaration: 'v' dimensions: #( #('1' '10') #('-10' '-1') ).

	stmt accept: visitor.
	self assert: visitor count equals: 4
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTest >> testArrayRange [
	| stmt |
	stmt := FASTFortranArrayRange new
			lowerBound: (self integerLiteral: '1') ;
			upperBound: (self scalarVariable: 'max') ;
		yourself.

	stmt accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTest >> testArrayVariable [
	| stmt |
	stmt := FASTFortranArrayVariable new
		name: 'arr'.

	stmt accept: visitor.
	self assert: visitor count equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testAssignementFunctionCall [

	| stmt |
	stmt := self
		assignementStatement: #a 
		value: (self 
			functionCall: 'fct'
			arguments: {
				self integerLiteral: '5' .
				self scalarVariable: 'b' }).

	stmt accept: visitor.
	self assert: visitor count equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testAssignementStatementArrayAssigned [
	| stmt |
	stmt := FASTFortranAssignmentStatement new
		variable: (self 
			array: 'arr' access: { self scalarVariable: 'i' . self integerLiteral: '1'});
		expression: (self makeSimpleExpression: #b);
		yourself.

	stmt accept: visitor.
	self assert: visitor count equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testAssignementStatementLiteralValue [
	| stmt |
	stmt := self assignementStatement: #aVar value: (self logicalLiteral: '.true.').

	stmt accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testAssignementStatementVariable [
	| stmt |
	stmt := self assignementStatement: #a value: #b.

	stmt accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTest >> testBinaryExpression [
	| expr |
	expr := FASTFortranBinaryExpression new
		leftOperand: (self scalarVariable: 'a') ;
		operator: '+' ;
		rightOperand: (self integerLiteral: '5').

	expr accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTest >> testBinaryExpressionNe [
	| expr |
	expr := FASTFortranBinaryExpression new
		leftOperand: (self scalarVariable: 'a') ;
		operator: '.ne.' ;
		rightOperand: (self integerLiteral: '5').

	expr accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testBlockStatementWithCommentAndStatement [
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
	self assert: visitor count equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testCallStatementExpressionArg [
	| stmt |
	stmt := self callStatement: 'subrtn' arguments: {
		self binary: '*' left: #a right: 5 }.

	stmt accept: visitor.
	self assert: visitor count equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testCallStatementNoArgs [
	| stmt |
	stmt := self callStatement: 'subrtn' arguments: #().

	stmt accept: visitor.
	self assert: visitor count equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testCallStatementWithArgs [
	| stmt |
	stmt := self callStatement: 'subrtn' arguments: {
		self scalarVariable: 'a' .
		self integerLiteral: '5' }.

	stmt accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTest >> testComment [

	| cmt |
	cmt := self comment: 'C This is a comment'.

	cmt accept: visitor.

	self assert: visitor count equals: 0
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTest >> testComment72Characters [
	| cmt |
	cmt := self comment: 'C 3456789 123456789 123456789 123456789 123456789 123456789 123456789 12'.

	cmt accept: visitor.

	self assert: visitor count equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testCommonStatement [

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
	self assert: visitor count equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testContinueStatement [
	| stmt |
	stmt := FASTFortranContinueStatement new
		label: '110'.

	stmt accept: visitor.
	self assert: visitor count equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testDataStatement [

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
	self assert: visitor count equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testDimensionStatement [

	| stmt |

	stmt := FASTFortranDimensionStatement new
		declarators: {
			self arrayDeclarator: 'v' dimensions: #( #('1' '10') ) .
			self arrayDeclarator: 'm' dimensions: #( #('100') #('100') ) .
		}.

	stmt accept: visitor.
	self assert: visitor count equals: 4
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testDoStatement [
	| stmt |

	stmt := self doStatement: #(i 1 max 1) statements: #().

	
	stmt accept: visitor.
	self assert: visitor count equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testDoStatementNoIncrement [
	| stmt |

	stmt := self doStatement: #(i 1 max) statements: #().

	
	stmt accept: visitor.
	self assert: visitor count equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testDoStatementWithLabel [

	| stmt |
	stmt := self
		        doStatement: #( i 1 max )
		        statements:
		        { (FASTFortranContinueStatement new label: '110') }.

	stmt labelReferences: { (self labelReference: '110') }.


	stmt accept: visitor.
	self assert: visitor count equals: 4
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTest >> testEmptySubroutineNoParameters [

	| sub |
	sub := self subroutine: 'blah'.

	sub accept: visitor.

	self assert: visitor count equals: 1
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTest >> testEmptySubroutineTwoParameters [

	| sub |
	sub := self subroutine: 'blah'.
	self entity: sub parameters: #( i j ).
	sub accept: visitor.
	self assert: visitor count equals: 1



	"self assert: sub equals: '      subroutine blah(i,j)
      end
'"
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testEntryStatement [

	| stmt |
	stmt := FASTFortranEntryStatement new
		name: 'XYZ' ;
		entryArguments: { self scalarVariable: 'ABC' . FASTFortranAsterisk new } ;
		yourself.

	
	stmt accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testEquivalenceStatement [

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
	self assert: visitor count equals: 4
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testExitStatement [
	| stmt |
	stmt := self exitStatement: nil.

	
	
	stmt accept: visitor.
	self assert: visitor count equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testExternalStatement [
	| stmt |
	stmt := self externalStatement: 'aVar'.

	stmt accept: visitor.

	self assert: visitor count equals:  0
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTest >> testFieldAccess [
	| fct varAccess writeStatement |
	fct := self functionDeclaration: 'blah'.
	fct declaredType: nil.

	varAccess := FASTFortranFieldAccess new
		pointer: (self scalarVariable: #p) ;
		field: (self scalarVariable: #x).
	writeStatement := self writeStatement: {  varAccess }.
	fct statementBlock addStatement: writeStatement.

	
	
	fct accept: visitor.
	self assert: visitor count equals: 4
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testFormatStatement [
	| stmt |
	stmt := FASTFortranFormatStatement new
		formatDescription: '(/8x)' ;
		label: '110' ;
		yourself.

	
	stmt accept: visitor.
	self assert: visitor count equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testFunctionNoParameterNoStatement [

	| node |
	node := self functionDeclaration: 'BLAH'.
	node accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testFunctionNoParameterWithStatement [
	| node stmt |
	stmt := self returnStatement: (self scalarVariable: 'i').

	node := self functionDeclaration: 'BLAH'.
	node statementBlock: (self statementBlock: { stmt }).

	node accept: visitor.
	self assert: visitor count equals: 3
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTest >> testFunctionNoReturnType [
	| fct |
	fct := self functionDeclaration: 'blah'.
	fct declaredType: nil.

	fct accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testFunctionStatement [
	| node |
	node := FASTFortranFunctionStatement new.
	node name: 'fct'.
	node parameters: (self scalarVariables: #(x y)).
	node expression: (self binary: '+' left: #x right: 2).

	node accept: visitor.
	self assert: visitor count equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testFunctionWithParameterNoStatement [
	| node |
	node := self functionDeclaration: 'BLAH'.
	self entity: node parameters: #(i j).

	node accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testGotoComputedStatement [
	| stmt |
	stmt := FASTFortranGoToComputedStatement new
		labelReferences: { self labelReference: '110' . self labelReference: '120' . self labelReference: '130'} ;
		selectorExpression: (self scalarVariable: 'i') ;
		yourself.

	stmt accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testGotoStatement [
	| stmt |
	stmt := self gotoStatement: '110'.

	stmt accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testIfArithmeticStatement [
	| stmt |

	stmt := self ifArithmetic: #a negative: 10 null: 20 positive: 30.

	stmt accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testIfBlockStatementEmpty [
	| stmt |
	stmt := self ifBlock: (self scalarVariable: 'bool') then: #() else: nil.

	stmt accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testIfBlockStatementEmptyBinaryCondition [

	| stmt cond |
	cond := self binary: '.gt.' left: #a right: 0.
	stmt := self ifBlock: cond then: #(  ) else: nil.
	stmt accept: visitor.
	self assert: visitor count equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testIfBlockStatementNested [
	| stmt |
	stmt := self
		ifBlock: (self scalarVariable: 'bool1')
		then: { self
			ifBlock: (self scalarVariable: 'bool2')
			then: #()
			else: nil }
		else: nil.

	stmt accept: visitor.
	self assert: visitor count equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testIfBlockStatementWithElseBlock [
	| stmt |
	stmt := self
		ifBlock: (self scalarVariable: 'bool')
		then: #()
		else:  {  self returnStatement: nil }.

	stmt accept: visitor.
	self assert: visitor count equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testIfBlockStatementWithThenBlock [
	| stmt |
	stmt := self
		ifBlock: (self scalarVariable: 'bool')
		then: {  self returnStatement: nil }
		else: nil.

	stmt accept: visitor.
	self assert: visitor count equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testIfLogicalStatementEmpty [
	| stmt |
	stmt := FASTFortranIfLogicalStatement new
		condition: (self scalarVariable: 'bool') ;
		statement: FASTFortranReturnStatement new ;
		yourself.

	stmt accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testImplicitStatement [
	| stmt |
	stmt := self implicitStatement.

	stmt accept: visitor.
	self assert: visitor count equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testImplicitStatementSeveralRules [

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
	self assert: visitor count equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testImpliedDoExpression [
	| expr |

	expr := FASTFortranImpliedDoExpression new
		loopControl: (self loopControlInit: #(i 1) increment: 1 limit: #max) ;
		variables: (self scalarVariables: #(v i)).

	expr accept: visitor.
	self assert: visitor count equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testInquireStatement [
	| stmt |
	stmt := FASTFortranInquireStatement new
		ioParameters: {
			self integerLiteral: '3' .
			self assignementExpression: #iostat value: #stat .
			self assignementExpression: #err value: 10
		}.

	stmt accept: visitor.
	self assert: visitor count equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testIntrinsicStatement [

	| stmt |

	stmt := FASTFortranIntrinsicStatement new
		variables: (self scalarVariables: #(sin cos)) ;
		yourself.

	
	stmt accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testLabelledStatement [
	| stmt |
	stmt := self returnStatement: nil.
	stmt label: '100'.

	
	stmt accept: visitor.
	self assert: visitor count equals: 0
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTest >> testLongDataStatementLine [

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
	self assert: visitor count equals: 2
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTest >> testLongFormatLine [

	| stmt |

	stmt := FASTFortranFormatStatement new
		formatDescription: '(1h,//36hxabs-(156)intrinsicfunctions--//11x,26habs,iabs(absolutevalue)//20hsubsetref.-15.3)' ;
		label: '110' ;
		yourself.

	
	stmt accept: visitor.
	self assert: visitor count equals: 0
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTest >> testLongLine [
	| stmt |
	stmt := self declarationStatement: #character variables: #(abc1 abc2 abc3 abc4 abc5 abc6 abc7 abc8 abc9 abc10 abc11 abc12 abc13 abc14 abc15 abc16 abc17 abc18 abc19 abc20 abc21 abc22 abc23 abc24 abc25).

	
	stmt accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTest >> testLongLineDontBreak [
	| stmt |
	stmt := self declarationStatement: #character variables: #(abc1 abc2 abc3 abc4 abc5 abc6 abc7 abc8 abc9 abc10 abc11 abc12 abc13 abc14 abc15 abc16 abc17 abc18 abc19 abc20 abc21 abc22 abc23 abc24 abc25).

	"visitor dontBreakLongLines.
"
	
	stmt accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testMainProgram [
	| node |
	node := FASTFortranProgramMain new
		name: 'BLAH' ;
		statementBlock: FASTFortranStatementBlock new
		yourself.

	
	node accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testOneDeclarationCharacterType [
	| stmt |
	stmt := self declarationStatement: #character variables: #(r).

	
	stmt accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testOneDeclarationCharacterTypeStarSize [
	| stmt |
	stmt := self declarationStatement: #(character *) variables: #(str).

	
	stmt accept: visitor.
	self assert: visitor count equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testOneDeclarationCharacterTypeWithSize [
	| stmt |
	stmt := self declarationStatement: #(character 10) variables: #(str).

	
	stmt accept: visitor.
	self assert: visitor count equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testOneDeclarationDoublePrecisionType [
	| stmt |
	stmt := self declarationStatement: (FASTFortranDoublePrecisionType new) variables: #(r).

	
	stmt accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testOneDeclarationIntegerTypeWithSize [
	| stmt |
	stmt := self declarationStatement: #(integer 8) variables: #(i).

	
	stmt accept: visitor.
	self assert: visitor count equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testOneDeclarationLogicalType [
	| stmt |
	stmt := self declarationStatement: #logical variables: #(r).

	
	stmt accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testOneDeclarationRealType [
	| stmt |
	stmt := self declarationStatement: #real variables: #(r).

	
	stmt accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testOneDeclarationTwoVariables [
	| stmt |
	stmt := FASTFortranFunctionTypeDeclarationStatement new
		declaredType: (self makeType: #integer) ;
		name: 'fct';
		startPos: 1 ;
		endPos: 10.

	
	stmt accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testOpenStatement [
	| stmt |
	stmt := FASTFortranOpenStatement new
		ioParameters: {
			self integerLiteral: '3' .
			self ioParameter: #file value: 'projectA/data.test'.
			self ioParameter: #err value: 99
		}.

	
	stmt accept: visitor.
	self assert: visitor count equals: 3
]

{ #category : 'tests - operator precedence' }
FASTFortranCountSubtreesVisitorTest >> testOperatorsPrecedenceNoParentheses [
	
	| expr |
	expr := self binary: '+' left: #v right: 5.

	
	expr accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - operator precedence' }
FASTFortranCountSubtreesVisitorTest >> testOperatorsPrecedenceSubHasHigherPrecedence [
	
	| expr |
	expr := self binary: '+' left: #i right: 5.
	expr rightOperand: (self binary: '*' left: #j right: 5).

		
	expr accept: visitor.
	self assert: visitor count equals: 2
]

{ #category : 'tests - operator precedence' }
FASTFortranCountSubtreesVisitorTest >> testOperatorsPrecedenceSubHasLowerPrecedence [
	
	| expr |
	expr := self binary: '*' left: #i right: 5.
	expr rightOperand: (self binary: '+' left: #j right: 5).

		
	expr accept: visitor.
	self assert: visitor count equals: 2
]

{ #category : 'tests - operator precedence' }
FASTFortranCountSubtreesVisitorTest >> testOperatorsPrecedenceSubUnary [
	
	| expr |
	expr := self binary: '.and.' left: #logical1 right: (self unary: '.not.' operand: #logical2).

		
	expr accept: visitor.
	self assert: visitor count equals: 2
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testPauseStatementEmpty [
	| stmt |
	stmt := FASTFortranPauseStatement new.

		
	stmt accept: visitor.
	self assert: visitor count equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testPauseStatementWithInteger [
	| stmt |
	stmt := FASTFortranParameterStatement new
		declarators: (self variableDeclarators: #(pi msg)) ;
		yourself.
	stmt declarators first expression: (self realLiteral: '3.14159').
	stmt declarators second expression: (self characterLiteral: 'hello').

	
	stmt accept: visitor.
	self assert: visitor count equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testPauseStatementWithString [
	| stmt |
	stmt := FASTFortranPauseStatement new
		displayArgument: '''error''' ;
		yourself.

	
	stmt accept: visitor.
	self assert: visitor count equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testPrintStatement [
	| stmt |
	stmt := self printStatement: { self characterLiteral: 'message' }.

	
	stmt accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testReadStatement [
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
	self assert: visitor count equals: 4
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testReturnStatementEmpty [
	| stmt |
	stmt :=  self returnStatement: nil.

	
	stmt accept: visitor.
	self assert: visitor count equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testReturnStatementLiteralValue [
	| stmt |
	stmt := self returnStatement: (self realLiteral: '3.5').

	
	stmt accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testRewindStatement [
	| stmt |
	stmt := FASTFortranRewindStatement new
		ioParameters: {
			self integerLiteral: '3' .
			self assignementExpression: #iostat value: #stat.
			self assignementExpression: #err value: 10
		}.

	
	stmt accept: visitor.
	self assert: visitor count equals: 3
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testStopStatementEmpty [
	| stmt |
	stmt := FASTFortranStopStatement new.

	
	stmt accept: visitor.
	self assert: visitor count equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testStopStatementWithInteger [
	| stmt |
	stmt := FASTFortranStopStatement new
		displayArgument: '1' ;
		yourself.

	
	stmt accept: visitor.
	self assert: visitor count equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testStopStatementWithString [
	| stmt |
	stmt := FASTFortranStopStatement new
		displayArgument: '''error''' ;
		yourself.

	
	stmt accept: visitor.
	self assert: visitor count equals: 0
]

{ #category : 'tests' }
FASTFortranCountSubtreesVisitorTest >> testStringConcatOperator [
	| stmt |
	stmt := self binary: '//' left: #texte right: ' a string'.

	
	stmt accept: visitor.
	self assert: visitor count equals: 1
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testStringLiteralWithQuote [
	| expr |
	expr := self characterLiteral: 'a ''''string'''' with quotes'.

	
	expr accept: visitor.
	self assert: visitor count equals: 0
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testTwoDeclarationsTwoVariables [
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
	self assert: visitor count equals: 4
]

{ #category : 'tests - statements' }
FASTFortranCountSubtreesVisitorTest >> testWriteStatement [
	| stmt |
	stmt := self writeStatement: #( 'message' ).

	stmt accept: visitor.
	self assert: visitor count equals: 1
]
