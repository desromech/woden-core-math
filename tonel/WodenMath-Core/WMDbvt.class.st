"
I am a dynamic bounding volume tree.
"
Class {
	#name : #WMDbvt,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#category : #'WodenMath-Core-DataStructures'
}

{ #category : #updating }
WMDbvt >> balanceFactor [
	^ root
		ifNil: [0]
		ifNotNil: [root balanceFactor]
]

{ #category : #initialization }
WMDbvt >> initialize [
	super initialize.
]

{ #category : #operations }
WMDbvt >> insertLeafNode: node [
	| newRoot |
	root ifNil: [
		^ root := node.
	].

	self assert: node parent isNil.
	self assert: root parent isNil.

	newRoot := WMDbvtInnerNode new
		left: root; 
		right: node;
		boundingBox: (root boundingBox unionWithBox: node boundingBox);
		height: (root height max: node height) + 1;
		yourself.
	root parent: newRoot.
	node parent: newRoot.
	root := newRoot rebalanceBubblingUp.
	
]

{ #category : #operations }
WMDbvt >> insertValue: value withBoundingBox: boundingBox [
	| newLeaf |
	newLeaf := WMDbvtLeafNode new
		value: value;
		boundingBox: boundingBox;
		yourself.
	self insertLeafNode: newLeaf.
	^ newLeaf
]

{ #category : #testing }
WMDbvt >> isEmpty [
	^ root isNil
]

{ #category : #testing }
WMDbvt >> isNotEmpty [
	^ root notNil
]

{ #category : #iteration }
WMDbvt >> leavesIntersectingBox: boxToTest [
	| result |
	result := OrderedCollection new.
	self leavesIntersectingBox: boxToTest do: [:leaf | result add: leaf ].
	^ result
	
]

{ #category : #iteration }
WMDbvt >> leavesIntersectingBox: boxToTest do: aBlock [
	root ifNotNil: [root leavesIntersectingBox: boxToTest do: aBlock]
	
]

{ #category : #iteration }
WMDbvt >> leavesIntersectingFrustum: frustumToTest [
	| result |
	result := OrderedCollection new.
	self leavesIntersectingFrustum: frustumToTest do: [:leaf | result add: leaf ].
	^ result
	
]

{ #category : #iteration }
WMDbvt >> leavesIntersectingFrustum: frustumToTest do: aBlock [
	root ifNotNil: [root leavesIntersectingFrustum: frustumToTest do: aBlock]
	
]

{ #category : #iteration }
WMDbvt >> leavesIntersectingRay: rayToTest [
	| result |
	result := OrderedCollection new.
	self leavesIntersectingRay: rayToTest do: [:leaf | result add: leaf ].
	^ result
	
]

{ #category : #iteration }
WMDbvt >> leavesIntersectingRay: rayToTest do: aBlock [
	root ifNotNil: [root leavesIntersectingRay: rayToTest do: aBlock]
	
]

{ #category : #iteration }
WMDbvt >> leavesIntersectingSphere: sphereToTest [
	| result |
	result := OrderedCollection new.
	self leavesIntersectingSphere: sphereToTest do: [:leaf | result add: leaf ].
	^ result
	
]

{ #category : #iteration }
WMDbvt >> leavesIntersectingSphere: sphereToTest do: aBlock [
	root ifNotNil: [root leavesIntersectingSphere: sphereToTest do: aBlock]
	
]

{ #category : #removing }
WMDbvt >> removeNode: aNode [
	self assert: aNode isInnerNode not.
	root := aNode removeFromTreeAndRebalance.
]

{ #category : #accessing }
WMDbvt >> root [
	^ root
]

{ #category : #operations }
WMDbvt >> updateLeafNode: leafNode boundingBox: newBoundingBox [
	root := leafNode updateAndRebalanceBoundingBox: newBoundingBox
]
