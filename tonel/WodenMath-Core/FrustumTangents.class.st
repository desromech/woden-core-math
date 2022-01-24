"
I hold a collection of frustum tangents. I am typically used for asymetric frustum rendering which is required for Stereoscopic displays and VR.

Projection matrices can be obtained by multiplying my parameters by the near distance.
"
Class {
	#name : #FrustumTangents,
	#superclass : #Object,
	#instVars : [
		'left',
		'right',
		'top',
		'bottom'
	],
	#category : #'WodenMath-Core-Geometry'
}

{ #category : #symmetric }
FrustumTangents class >> leftPerspectiveFovY: fovy aspect: aspect ipd: ipd focalDistance: focalDistance [
	| fovyRad top focalWidth |
	fovyRad := fovy degreesToRadians * 0.5.
	top := fovyRad tan.
	focalWidth := focalDistance * top * aspect.
	
	^ self new
		left: (focalWidth - (ipd*0.5)) / focalDistance negated;
		right: (focalWidth + (ipd*0.5)) / focalDistance;
		bottom: top negated;
		top: top;
		yourself

]

{ #category : #symmetric }
FrustumTangents class >> perspectiveFovY: fovy aspect: aspect [
	| fovyRad top right |
	fovyRad := fovy degreesToRadians * 0.5.
	top := fovyRad tan.
	right := top * aspect.
	^ self new
		left: right negated;
		right: right;
		bottom: top negated;
		top: top;
		yourself

]

{ #category : #symmetric }
FrustumTangents class >> rightPerspectiveFovY: fovy aspect: aspect ipd: ipd focalDistance: focalDistance [
	| fovyRad top focalWidth |
	fovyRad := fovy degreesToRadians * 0.5.
	top := fovyRad tan.
	focalWidth := focalDistance * top * aspect.
	
	^ self new
		left: (focalWidth + (ipd*0.5)) / focalDistance negated;
		right: (focalWidth - (ipd*0.5)) / focalDistance;
		bottom: top negated;
		top: top;
		yourself

]

{ #category : #accessing }
FrustumTangents >> bottom [

	^ bottom
]

{ #category : #accessing }
FrustumTangents >> bottom: anObject [

	bottom := anObject
]

{ #category : #accessing }
FrustumTangents >> left [

	^ left
]

{ #category : #accessing }
FrustumTangents >> left: anObject [

	left := anObject
]

{ #category : #accessing }
FrustumTangents >> right [

	^ right
]

{ #category : #accessing }
FrustumTangents >> right: anObject [

	right := anObject
]

{ #category : #accessing }
FrustumTangents >> top [

	^ top
]

{ #category : #accessing }
FrustumTangents >> top: anObject [

	top := anObject
]
