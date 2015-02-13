//
//  Array and String slicing extension for Swift
//      0.1
//
//  Copyright (c) David H. Christensen <me@davidh.info>
//  Licensed under the MIT license. Find it on Google if you're in doubt.

import Foundation

extension Array {
    subscript( indices: (Int, Int)) -> Array<T> {
        get {
            let (start, length) = indices
            let end = start+length
            var buffer: [T] = []
            if end > self.count ||
                start > self.count ||
                start < 0 ||
                end < 0 { return [] }
            for i in start..<end {
                buffer.append(self[i])
            }
            return buffer
        } set(newValue) {
            let (start, length) = indices
            var end = start+length
            
            if start > self.count || start < 0 { return; }
            if end > self.count { end = self.count-1 }
            if end < 0 { return; }
            
            for i in start..<end {
                self[i] = newValue[i-start]
            }
        }
    }
}

var myTestArray = [1,2,3,4,5,6,7,8,9]
// Lovely python-esque array slices!
let easyAsOneTwoThree = myTestArray[(0,3)]
myTestArray[(8)] = 10
myTestArray                 // 1, 2, 3, 4, 5, 6, 7, 8, 10

///// -------------------------
// Extrapolating this, we can do the same for the Swift String type

extension String {
    subscript( index: Int ) -> String {
        get {
            return (self as NSString).substringWithRange(NSMakeRange(index, 1))
        } set(newValue) {
            let subst = (self as NSString).stringByReplacingCharactersInRange(NSMakeRange(index,1), withString: newValue)
            self = subst
        }
    }
    subscript( indices: (Int, Int)) -> String {
        get {
            let (start, length) = indices
            var end = start+length
            let count = self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
            if end > count ||
                start > count ||
                start < 0 ||
                end < 0 { return "" }
            return (self as NSString).substringWithRange(NSMakeRange(start,length))
            
        } set(newValue) {
            let (start, length) = indices
            var end = start+length
            let count = self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
            
            if start > count || start < 0 { return; }
            if end > count { end = count-1 }
            if end < 0 { return; }
            
            let subst = (self as NSString).stringByReplacingCharactersInRange(NSMakeRange(start,length), withString: newValue)
            self = subst
        }
    }
}

    // and go crazy!
var helloWorld = "Hello, World!"
var hello = helloWorld[(0,5)]
hello[0] = "Y"                          // and single substitutions...
hello                                   // Yello, World!
hello[(1,3)] = "owz"
hello                                   // Yowzo, World!


