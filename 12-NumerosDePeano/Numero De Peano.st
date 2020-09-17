!classDefinition: #I category: #'Numero De Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Numero De Peano'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'DB 9/16/2020 22:16:40'!
* unNumero
	unNumero  = I ifTrue: [^self].
	^(self+self) * unNumero previous ! !

!I class methodsFor: 'as yet unclassified' stamp: 'DB 9/16/2020 22:14:29'!
+ unNumero
	^unNumero next! !

!I class methodsFor: 'as yet unclassified' stamp: 'DB 9/16/2020 22:15:26'!
- unNumero
	self error: 'Los numeros de peano no soportan ceros o negativos'! !

!I class methodsFor: 'as yet unclassified' stamp: 'DB 9/16/2020 22:17:31'!
/ unNumero
	unNumero  = I ifTrue: [^self].
	self error: 'No se soporta division no entera'! !

!I class methodsFor: 'as yet unclassified' stamp: 'DB 9/16/2020 22:12:56'!
next
	^self createChildNamed: self name, 'I'! !

!I class methodsFor: 'as yet unclassified' stamp: 'DB 9/16/2020 22:14:01'!
previous
	self = I ifTrue: [self error: 'Los numeros de peano no soportan numerso negativos'].
	^self parent.! !


!classDefinition: #II category: #'Numero De Peano'!
I subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Numero De Peano'!
II class
	instanceVariableNames: ''!

!II class methodsFor: 'as yet unclassified' stamp: 'DB 9/16/2020 22:20:24'!
+ unNumero
	^(self previous + unNumero ) next! !

!II class methodsFor: 'as yet unclassified' stamp: 'DB 9/16/2020 22:20:00'!
- unNumero
	unNumero = I ifTrue: [^self previous ].
	^self previous - unNumero previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'DB 9/16/2020 22:21:25'!
/unNumero
	unNumero = I ifTrue: [^self].
	^self - unNumero /  unNumero previous.! !
