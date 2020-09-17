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

!I class methodsFor: 'as yet unclassified' stamp: 'DB 9/16/2020 20:28:04'!
* unNumero
	unNumero = I ifTrue: [^self].
	^(self + self) * unNumero previous ! !

!I class methodsFor: 'as yet unclassified' stamp: 'DB 9/15/2020 19:12:33'!
+ unNumero
	^unNumero next ! !

!I class methodsFor: 'as yet unclassified' stamp: 'DB 9/16/2020 22:37:46'!
- unNumero
	self error: 'Los numeros de peano no soportan ceros o negativos.'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'DB 9/16/2020 22:37:54'!
/ unNumero
	unNumero = I ifTrue: [ ^ self ].
	self error: 'No se soporta division no entera'.! !

!I class methodsFor: 'as yet unclassified'!
e #performRealTest stamp: 'DB 9/16/2020 22:38:39'! !

!I class methodsFor: 'as yet unclassified' stamp: 'DB 9/16/2020 22:38:39'!
category: 'Numeros De Peano'! !


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

!II class methodsFor: 'as yet unclassified' stamp: 'DB 9/16/2020 22:37:18'!
+ unNumero
	"Siguiente del anterior"
	"El siguiente de la suma del anterior mas este numero"
	^(self previous + unNumero) next! !

!II class methodsFor: 'as yet unclassified' stamp: 'DB 9/16/2020 22:37:24'!
- unNumero
	unNumero = I ifTrue: [ ^ self previous ].
	^ self previous - unNumero previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'DB 9/16/2020 22:37:31'!
/ unNumero
	unNumero = I ifTrue: [ ^ self ].
	^ self - unNumero / unNumero previous.! !


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


!classDefinition: #IIIIII category: #'Numeros De Peano'!
IIIII subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIIIIII category: #'Numeros De Peano'!
IIIIII subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIIIIIII category: #'Numeros De Peano'!
IIIIIII subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIIIIIIII category: #'Numeros De Peano'!
IIIIIIII subclass: #IIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIIIIIIIII category: #'Numeros De Peano'!
IIIIIIIII subclass: #IIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIIIIIIIIII category: #'Numeros De Peano'!
IIIIIIIIII subclass: #IIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!


!classDefinition: #IIIIIIIIIIII category: #'Numeros De Peano'!
IIIIIIIIIII subclass: #IIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!
