/*
“The lazy initializer for a global variable (also for static members of structs and enums)
is run the first time that global is accessed, 
and is launched as `dispatch_once` to make sure that the initialization is atomic. 
This enables a cool way to use `dispatch_once` in your code: 
just declare a global variable with an initializer and mark it private.”
— Apple's Swift Blog
*/

class SomeClass {
    static let sharedInstance = SomeClass()
    private init() { }
    
    // другие методы
}
