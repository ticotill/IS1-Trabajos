!classDefinition: #I category: #'Numeros De Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Numeros De Peano'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'DB 9/15/2020 19:12:33'!
+ unNumero
	^unNumero next ! !

!I class methodsFor: 'as yet unclassified' stamp: 'DB 9/15/2020 19:29:29'!
- unNumero
	unNumero = self ifTrue: [self error: 'no se puede restar'].
	^self previous ! !

!I class methodsFor: 'as yet unclassified' stamp: 'DB 9/15/2020 19:10:01'!
next
	"comment stating purpose of message"
	^self createChildNamed: self name,'I' ! !

!I class methodsFor: 'as yet unclassified' stamp: 'DB 9/15/2020 19:28:02'!
previous
	"comment stating purpose of message"
	self = I ifTrue: [self error: 'I no tiene previous'].
	^self parent! !


!classDefinition: #II category: #'Numeros De Peano'!
I subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Numeros De Peano'!
II class
	instanceVariableNames: ''!

!II class methodsFor: 'as yet unclassified' stamp: 'DB 9/15/2020 21:20:06'!
+ unNumero
	"Siguiente del anterior"
	"El siguiente de la suma del anterior mas este numero"
	^(self previous + unNumero) next! !

!II class methodsFor: 'as yet unclassified' stamp: 'DB 9/15/2020 19:56:38'!
- unNumero
	[self = I] whileFalse: [
		| anterior |
		anterior := self previous.
		anterior - unNumero previous.
	].
	^unNumero! !


!classDefinition: #III category: #'Numeros De Peano'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIII category: #'Numeros De Peano'!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIIII category: #'Numeros De Peano'!
IIII subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!
