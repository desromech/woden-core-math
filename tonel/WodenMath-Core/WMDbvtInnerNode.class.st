"
I am a dynamic bounding volume tree inner node.
"
Class {
	#name : #WMDbvtInnerNode,
	#superclass : #WMDbvtAbstractNode,
	#instVars : [
		'parent',
		'left',
		'right',
		'height',
		'boundingBox'
	],
	#category : #'WodenMath-Core-DataStructures'
}

{ #category : #updating }
WMDbvtInnerNode >> balanceFactor [
	^ left height - right height
]

{ #category : #accessing }
WMDbvtInnerNode >> boundingBox [

	^ boundingBox
]

{ #category : #accessing }
WMDbvtInnerNode >> boundingBox: anObject [

	boundingBox := anObject
]

{ #category : #accessing }
WMDbvtInnerNode >> height [

	^ height
]

{ #category : #accessing }
WMDbvtInnerNode >> height: anObject [

	height := anObject
]

{ #category : #testing }
WMDbvtInnerNode >> isAVL [
	^ self balanceFactor between: -1 and: 1
]

{ #category : #testing }
WMDbvtInnerNode >> isInnerNode [
	^ true
]

{ #category : #iteration }
WMDbvtInnerNode >> leavesIntersectingBox: boxToTest do: aBlock [
	(boundingBox hasIntersectionWithBox: boxToTest) ifFalse: [ ^ self ].

	left leavesIntersectingBox: boxToTest do: aBlock.
	right leavesIntersectingBox: boxToTest do: aBlock.
]

{ #category : #iteration }
WMDbvtInnerNode >> leavesIntersectingFrustum: frustumToTest do: aBlock [
	(frustumToTest intersectsOrContainsBox: boundingBox) ifFalse: [ ^ self ].

	left leavesIntersectingFrustum: frustumToTest do: aBlock.
	right leavesIntersectingFrustum: frustumToTest do: aBlock.
]

{ #category : #iteration }
WMDbvtInnerNode >> leavesIntersectingRay: rayToTest do: aBlock [
	(boundingBox hasIntersectionWithRay: rayToTest) ifFalse: [ ^ self ].

	left leavesIntersectingRay: rayToTest do: aBlock.
	right leavesIntersectingRay: rayToTest do: aBlock.
]

{ #category : #iteration }
WMDbvtInnerNode >> leavesIntersectingSphere: sphereToTest do: aBlock [
	(boundingBox hasIntersectionWithSphere: sphereToTest) ifFalse: [ ^ self ].

	left leavesIntersectingSphere: sphereToTest do: aBlock.
	right leavesIntersectingSphere: sphereToTest do: aBlock.
]

{ #category : #accessing }
WMDbvtInnerNode >> left [

	^ left
]

{ #category : #accessing }
WMDbvtInnerNode >> left: anObject [

	left := anObject
]

{ #category : #'as yet unclassified' }
WMDbvtInnerNode >> leftRotate [
	| oldParent oldRoot oldLeft oldRight newRoot oldRightLeft |
	self assert: right isInnerNode.
	oldParent := parent.
	oldRoot := self.
	oldLeft := left.
	oldRight := right.
	oldRightLeft := right left.
	
	newRoot := oldRight.
	oldRoot setRightChild: oldRightLeft.
	oldRight setLeftChild: oldRoot.
	newRoot parent: nil.
	oldParent ifNotNil: [ oldParent replaceChild: self with: newRoot ].
	
	^ newRoot
]

{ #category : #accessing }
WMDbvtInnerNode >> parent [

	^ parent
]

{ #category : #accessing }
WMDbvtInnerNode >> parent: anObject [

	parent := anObject
]

{ #category : #updating }
WMDbvtInnerNode >> rebalanceBubblingUp [
	| balanceFactor |
	balanceFactor := self balanceFactor.
	balanceFactor <= -2 ifTrue: [
		"Right heavy"
		self assert: right isInnerNode.
		right balanceFactor >= 2 ifTrue: [ 
			"Child is right heavy. Left - Right rotation"
			right rightRotate.
			^ self leftRotate rebalanceBubblingUp
		] ifFalse: [
			"Single right rotation"
			^ self leftRotate rebalanceBubblingUp
		]
	] ifFalse: [ 
		balanceFactor >= 2 ifTrue: [ 
			"Left heavy"
			self assert: left isInnerNode.
			left balanceFactor <= -2 ifTrue: [ 
				left leftRotate.
				^ self rightRotate rebalanceBubblingUp
			] ifFalse: [ 
				"Single left rotation"
				^ self rightRotate rebalanceBubblingUp
			].
		].
	].
	
	^ parent
		ifNil: [ self ]
		ifNotNil: [ parent rebalanceBubblingUp ]
]

{ #category : #'as yet unclassified' }
WMDbvtInnerNode >> recomputeNodeInternals [
	height := (left height max: right height) + 1.
	boundingBox := left boundingBox unionWithBox: right boundingBox.
	
]

{ #category : #removing }
WMDbvtInnerNode >> removeChildAndRebalance: aChild [
	| remainingChild |
	remainingChild := left == aChild
		ifTrue: [ right]
		ifFalse: [ left ].
		
	remainingChild parent: nil.
	^ remainingChild ifNotNil: [ 
		parent ifNil: [ 
			remainingChild
		] ifNotNil: [
			parent
				replaceChild: self with: remainingChild;
				rebalanceBubblingUp
		]
	] ifNil: [ 
		parent ifNotNil: [ parent removeChildAndRebalance: self ]
	]

]

{ #category : #'as yet unclassified' }
WMDbvtInnerNode >> replaceChild: oldChild with: newChild [
	left == oldChild ifTrue: [ self setLeftChild: newChild ].
	right == oldChild ifTrue: [ self setRightChild: newChild ].
	self recomputeNodeInternals
]

{ #category : #accessing }
WMDbvtInnerNode >> right [

	^ right
]

{ #category : #accessing }
WMDbvtInnerNode >> right: anObject [

	right := anObject
]

{ #category : #'as yet unclassified' }
WMDbvtInnerNode >> rightRotate [
	| oldParent oldRoot oldLeft oldRight oldLeftRight newRoot |
	self assert: left isInnerNode.
	oldParent := parent.
	oldRoot := self.
	oldLeft := left.
	oldRight := right.
	oldLeftRight := left right.
	
	newRoot := oldLeft.
	oldRoot setLeftChild: oldLeftRight.
	oldLeft setRightChild: oldRoot.
	newRoot parent: nil.
	oldParent ifNotNil: [ oldParent replaceChild: self with: newRoot ].
	
	^ newRoot
]

{ #category : #accessing }
WMDbvtInnerNode >> root [
	^ parent ifNil: self ifNotNil: [ parent root ]
]

{ #category : #initialization }
WMDbvtInnerNode >> setLeftChild: newChild [
	newChild parent: self.
	left := newChild.
	self recomputeNodeInternals.
]

{ #category : #initialization }
WMDbvtInnerNode >> setRightChild: newChild [
	newChild parent: self.
	right := newChild.
	self recomputeNodeInternals.
]

{ #category : #updating }
WMDbvtInnerNode >> updateAndRebalanceChildBoundingBox: child [
	(boundingBox includesBox: child boundingBox) ifTrue: [
		^ self root
	].

	boundingBox := left boundingBox unionWithBox: right boundingBox.
	^ parent
		ifNil: [ self ]
		ifNotNil: [ parent updateAndRebalanceChildBoundingBox: self ]
]
