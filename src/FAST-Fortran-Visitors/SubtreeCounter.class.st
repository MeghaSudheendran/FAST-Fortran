Class {
	#name : 'SubtreeCounter',
	#superclass : 'Object',
	#category : 'FAST-Fortran-Visitors-Visitor',
	#package : 'FAST-Fortran-Visitors',
	#tag : 'Visitor'
}

{ #category : 'counter' }
SubtreeCounter >> count: aTree [
	^ (FASTFortranSubtreeVisitor new visitModel: aTree) size
		
]
