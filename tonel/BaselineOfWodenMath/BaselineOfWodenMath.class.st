Class {
	#name : #BaselineOfWodenMath,
	#superclass : #BaselineOf,
	#category : #BaselineOfWodenMath
}

{ #category : #baselines }
BaselineOfWodenMath >> baseline: spec [
    <baseline>
	spec for: #'common' do: [
		spec
			package: #'WodenMath-Core';
			package: #'WodenMath-Core-Tests' with: [
				spec requires: #( #'WodenMath-Core' ).
			]
	].
	spec for: #'squeak' do: [
		spec
			package: #'WodenMath-SqueakCompatibility'
	]
]
