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
	instanceVariableNames: 'customerBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'performance' stamp: 'DB 9/21/2020 18:54:12'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	
	self canBeExecuteThis: [customerBook addCustomerNamed: 'Jonh Lennon']  lessThan: 50*millisecond 

	
! !

!CustomerBookTest methodsFor: 'performance' stamp: 'DB 9/21/2020 19:23:42'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	self addPaul.

	self canBeExecuteThis:[customerBook removeCustomerNamed: 'Paul McCartney'.]  lessThan: 100*millisecond 
	
! !


!CustomerBookTest methodsFor: 'setUp' stamp: 'DB 9/21/2020 18:56:26'!
setUp
	customerBook := CustomerBook new
! !


!CustomerBookTest methodsFor: 'Invalid instance checker' stamp: 'DB 9/21/2020 19:57:11'!
test03CanNotAddACustomerWithEmptyName 

	[ customerBook addCustomerNamed: ''. 
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'Invalid instance checker' stamp: 'DB 9/21/2020 19:24:24'!
test04CanNotRemoveAnInvalidCustomer
	
	self addJohn.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: 'John Lennon') ]
! !

!CustomerBookTest methodsFor: 'Invalid instance checker' stamp: 'DB 9/21/2020 19:56:56'!
test07CanNotSuspendAnInvalidCustomer
	
	self addJohn.

	self isSuspendedIn: customerBook customer: 'George Harrison' include: 'John Lennon'.! !

!CustomerBookTest methodsFor: 'Invalid instance checker' stamp: 'DB 9/21/2020 19:57:01'!
test08CanNotSuspendAnAlreadySuspendedCustomer
		
	self addAndSuspend: customerBook customer: 'John Lennon'.
	
	self isSuspendedIn: customerBook customer: 'John Lennon' include: 'John Lennon'.
! !


!CustomerBookTest methodsFor: 'helper methods' stamp: 'DB 9/21/2020 18:50:15'!
addAndSuspend: aCustomerBook customer: aCustomer
	
	aCustomerBook addCustomerNamed: aCustomer.
	aCustomerBook suspendCustomerNamed: aCustomer.
	
	

! !

!CustomerBookTest methodsFor: 'helper methods' stamp: 'DB 9/21/2020 19:22:47'!
addJohn
	customerBook addCustomerNamed: 'John Lennon'.
! !

!CustomerBookTest methodsFor: 'helper methods' stamp: 'DB 9/21/2020 19:22:12'!
addPaul
	customerBook addCustomerNamed: 'Paul McCartney'.
! !

!CustomerBookTest methodsFor: 'helper methods' stamp: 'DB 9/18/2020 18:53:56'!
canBeExecuteThis: aBlock lessThan: aLimit
	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < aLimit
	
! !

!CustomerBookTest methodsFor: 'helper methods' stamp: 'DB 9/21/2020 18:41:55'!
checkEqualSize: aCustomerBook numberOfSuspended: suspended numberOfCustomers: customers
	
	self assert: 0               equals: aCustomerBook numberOfActiveCustomers.
	self assert: suspended equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: customers  equals: aCustomerBook numberOfCustomers.
	
	

! !

!CustomerBookTest methodsFor: 'helper methods' stamp: 'DB 9/21/2020 20:03:27'!
isSuspendedIn: aCustomerBook customer: aCustomer include: aCustomerInclude

	[ aCustomerBook suspendCustomerNamed: aCustomer.
	self fail ]
		on: CantSuspend 
		do: [ self assert: aCustomerBook numberOfCustomers = 1.
			self assert: (aCustomerBook includesCustomerNamed: aCustomerInclude) ]! !


!CustomerBookTest methodsFor: 'suspending' stamp: 'DB 9/21/2020 20:00:33'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	|  paulMcCartney |

	paulMcCartney := 'Paul McCartney'.
	self addAndSuspend: customerBook customer: paulMcCartney.	
	
	self checkEqualSize: customerBook numberOfSuspended: 1 numberOfCustomers: 1.
	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	
	
	

	
! !

!CustomerBookTest methodsFor: 'suspending' stamp: 'DB 9/21/2020 19:29:01'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	|  paulMcCartney |

	paulMcCartney := 'Paul McCartney'.
	self addAndSuspend: customerBook customer: paulMcCartney.	

	customerBook removeCustomerNamed: paulMcCartney.
	
	self checkEqualSize: customerBook numberOfSuspended: 0 numberOfCustomers: 0.
	
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


!CustomerBook methodsFor: 'customer management' stamp: 'DB 9/21/2020 19:08:15'!
addCustomerNamed: aCustomerName

	aCustomerName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	
	(self includesCustomerNamed: aCustomerName)  ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aCustomerName! !

!CustomerBook methodsFor: 'customer management' stamp: 'DB 9/21/2020 19:05:38'!
removeCustomerNamed: aCustomerName

	[ ^self remove: aCustomerName from: active ]
		on: NotFound 
		do: [ ^self remove: aCustomerName from: suspended ]

! !

!CustomerBook methodsFor: 'customer management' stamp: 'DB 9/18/2020 20:50:34'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'helper methods' stamp: 'DB 9/21/2020 19:06:37'!
remove: aCustomerName from: aCollection
 
	1 to: aCollection size do: 
	[ :index |
		aCustomerName = (aCollection at: index)
			ifTrue: [
				aCollection removeAt: index.
				^ aCustomerName 
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
