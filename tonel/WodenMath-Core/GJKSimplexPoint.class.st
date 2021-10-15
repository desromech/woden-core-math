"
I am a support point inside of a GJK simple. I am used for keeping track of a single support point three different spaces:

- The support point in the minkowski difference space.
- The support point corresponding to the first shape.
- The support point corresponding to the second shape.
"
Class {
	#name : #GJKSimplexPoint,
	#superclass : #Object,
	#instVars : [
		'differencePoint',
		'firstShapePoint',
		'secondShapePoint'
	],
	#category : #'WodenMath-Core-Geometry'
}

{ #category : #construction }
GJKSimplexPoint class >> differenceForDirection: direction firstSupport: firstSupport secondSupport: secondSupport [
	| firstPoint secondPoint |
	firstPoint := firstSupport value: direction.
	secondPoint := secondSupport value: direction negated.
	^ firstPoint - secondPoint
]

{ #category : #construction }
GJKSimplexPoint class >> forDirection: direction firstSupport: firstSupport secondSupport: secondSupport [
	| firstPoint secondPoint |
	firstPoint := firstSupport value: direction.
	secondPoint := secondSupport value: direction negated.
	^ self basicNew
		differencePoint: firstPoint - secondPoint;
		firstShapePoint: firstPoint;
		secondShapePoint: secondPoint;
		yourself
]

{ #category : #comparing }
GJKSimplexPoint >> closeTo: other [
	^ differencePoint closeTo: other differencePoint
]

{ #category : #'as yet unclassified' }
GJKSimplexPoint >> computeDifferencePoint [
	^ firstShapePoint - secondShapePoint
]

{ #category : #accessing }
GJKSimplexPoint >> differencePoint [

	^ differencePoint
]

{ #category : #accessing }
GJKSimplexPoint >> differencePoint: anObject [

	differencePoint := anObject
]

{ #category : #accessing }
GJKSimplexPoint >> firstShapePoint [

	^ firstShapePoint
]

{ #category : #accessing }
GJKSimplexPoint >> firstShapePoint: anObject [

	firstShapePoint := anObject
]

{ #category : #accessing }
GJKSimplexPoint >> secondShapePoint [

	^ secondShapePoint
]

{ #category : #accessing }
GJKSimplexPoint >> secondShapePoint: anObject [

	secondShapePoint := anObject
]
