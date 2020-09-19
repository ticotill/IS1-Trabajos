!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'performance' stamp: 'DB 9/18/2020 18:53:56'!
canBeExecuteThis: aBlock lessThan: aLimit
	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < aLimit
	
! !

!CustomerBookTest methodsFor: 'performance' stamp: 'DB 9/18/2020 18:54:33'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self canBeExecuteThis: [customerBook addCustomerNamed: 'Jonh Lennon']  lessThan: 50*millisecond 

	
! !

!CustomerBookTest methodsFor: 'performance' stamp: 'DB 9/18/2020 18:55:00'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.

	self canBeExecuteThis:[customerBook removeCustomerNamed: paulMcCartney.]  lessThan: 100*millisecond 
	
! !


!CustomerBookTest methodsFor: 'cannot' stamp: 'DB 9/18/2020 19:38:39'!
isSuspendIn: aCustomerBook customer: aCustomer include: aCustomerInclude

	[ aCustomerBook suspendCustomerNamed: aCustomer.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: aCustomerBook numberOfCustomers = 1.
			self assert: (aCustomerBook includesCustomerNamed: aCustomerInclude) ]! !

!CustomerBookTest methodsFor: 'cannot' stamp: 'DB 9/18/2020 19:30:11'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''. 
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'cannot' stamp: 'HAW 8/28/2017 08:57:25'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'cannot' stamp: 'DB 9/18/2020 19:41:47'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	
	self isSuspendIn: customerBook customer: 'George Harrison' include: johnLennon.! !

!CustomerBookTest methodsFor: 'cannot' stamp: 'DB 9/18/2020 19:40:42'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self isSuspendIn: customerBook customer: johnLennon include: johnLennon.
! !


!CustomerBookTest methodsFor: 'suspending' stamp: 'DB 9/18/2020 20:10:22'!
bloquecomun: aCustomerBook numberOfSuspended: suspended numberOfCustomers: customers

	|result  paulMcCartney|
	paulMcCartney := 'Paul McCartney'.	
	
	self assert: 0 equals: aCustomerBook numberOfActiveCustomers.
	self assert: suspended equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: customers equals: aCustomerBook numberOfCustomers.
	
	
	result := aCustomerBook includesCustomerNamed: paulMcCartney.
	

! !

!CustomerBookTest methodsFor: 'suspending' stamp: 'DB 9/18/2020 20:12:34'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	
	self bloquecomun: customerBook numberOfSuspended: 1 numberOfCustomers: 1.
	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	
	
	

	
! !

!CustomerBookTest methodsFor: 'suspending' stamp: 'DB 9/18/2020 20:12:47'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self bloquecomun: customerBook numberOfSuspended: 0 numberOfCustomers: 0.
	
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'numbers' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'numbers' stamp: 'DB 9/18/2020 21:38:59'!
numberOfCustomers
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers 
	! !

!CustomerBook methodsFor: 'numbers' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !


!CustomerBook methodsFor: 'signals' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'signals' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !


!CustomerBook methodsFor: 'customer management' stamp: 'DB 9/18/2020 21:54:02'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	
	(self includesCustomerNamed: aName)  ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName! !

!CustomerBook methodsFor: 'customer management' stamp: 'DB 9/18/2020 20:38:16'!
removeCustomerNamed: aCustomer 

	[ ^self remove: aCustomer from: active ]
		on: NotFound 
		do: [ ^self remove: aCustomer from: suspended ]

! !

!CustomerBook methodsFor: 'customer management' stamp: 'DB 9/18/2020 20:50:34'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'helper' stamp: 'DB 9/18/2020 20:32:18'!
remove: aCustomer from: aList
 
	1 to: aList size do: 
	[ :index |
		aCustomer = (aList at: index)
			ifTrue: [
				aList removeAt: index.
				^ aCustomer 
			] 
	].

	^ NotFound signal.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:01:49'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:02:05'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!'! !
