- Classes allow to create user-defined data structures. Classes define functions called methods, 
which identify the behaviors and actions that an object created from the class can perform with its data.
- The classic definition is class is blueprint for an instance.

1) Defining Class
   class Person:
    def __init__(self, name, age):
        self.name =  name
        self.age = age

- Init is the constructor that initializes the instance of a class.
- self is used to identify the instance. It is always the first argument for class methods.
- An instance attribute’s value is specific to a particular instance of the class.
- Class attributes are attributes that have the same value for all class instances.

2) Inheritance
One class inherits on the attributes and methods of another.

class Parent:
    eyes = 'black'

class Child(Parent):
    pass

-- To initiate the subclass so that it can handle more information than its original class can : 
  1) Using the super method as follows and pass in the arguments in interest.
  super.__init__()
  2) Call the parent's init method explicitly and pass in the arguments in interest.
  Parent.init(self, first, last, )


  .isinstance(instance, class)
  This method returns the boolean value of whether an instance belongs to a class
  .issubclass(subclass, class)
  This method returns the boolean value of whether a class has inherited from the second class.

  -- When setting a default value for an ungiven argument, avoid using an empty mutable data type. Instead use None

3) Dunder Methods 
Used for operator overloading.

Common Dunder Methods : 
repr,str :
repr is generally used by developers for logging and error handling. It includes representation to recreate the object. 
str is used for readable description of the object.

4) Property Decorators
@property # Using the decorator on the existing function 
def email(self):
    return '{}.{}@email.com'.format(self.first, self.last)

@property # Getter
def fullname(self):
    return '{} {}'.format(self.first, self.last)

@fullname.setter # Setter 
def fullname(self, name):
    first, last = name.split(' ')
    self.first = first
    self.last = last

@fullname.deleter # Deleter 
def fullname(self, name):
    print("Employee Record Deleted")
    self.first = None
    self.last = None
