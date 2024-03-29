//
//  MockCallRecorder.swift
//  QuizUp
//
//  Created by Jóhann Þorvaldur Bergþórsson on 10/03/16.
//  Copyright © 2016 Plain Vanilla Games. All rights reserved.
//

import Foundation

// This type only exists to complete the generics for the Arg type
// in the AnyObject case
public struct AnyObjectArgument: Equatable {}

public func == (lhs: AnyObjectArgument, rhs: AnyObjectArgument) -> Bool {
    return false
}

// Mark: Arg

public enum Arg<A: AnyObject, B: Equatable> : Equatable {
    case AnyObject(A)
    case Equatable(B)
    case List([B])
    case Nil
}

public func ==<A: AnyObject, B: Equatable>(lhs: Arg<A, B>, rhs: Arg<A, B>) -> Bool {
    switch (lhs, rhs) {
    case (.AnyObject(let x), .AnyObject(let y)):
        return x == y
    case (.Equatable(let x), .Equatable(let y)):
        return x == y
    case (.List(let x), .List(let y)):
        return x == y
    case (.Nil, .Nil):
        return true
    default:
        return false
    }
}

func == (lhs: AnyObject, rhs: AnyObject) -> Bool {
    switch (lhs, rhs) {
    case let (lhs as String, rhs as String):
        return lhs == rhs
    case let (lhs as Int, rhs as Int):
        return lhs == rhs
    case let (lhs as Double, rhs as Double):
        return lhs == rhs
    case let (lhs as Bool, rhs as Bool):
        return lhs == rhs
    case let (lhs as Selector, rhs as Selector):
        return lhs.description == rhs.description
    case let (lhs as NSObject, rhs as NSObject):
        return lhs.isEqual(rhs)
    default:
        return lhs === rhs
    }
}

public func arg(anyObject: AnyObject) -> Arg<AnyObject, AnyObjectArgument> {
    return Arg.AnyObject(anyObject)
}

public func arg(anyObjectList: [AnyObject]) -> Arg<AnyObject, AnyObjectArgument> {
    return Arg.AnyObject(anyObjectList as AnyObject)
}

public func arg(anyObjectList: [AnyObject]?) -> Arg<AnyObject, AnyObjectArgument> {
    return Arg.AnyObject((anyObjectList ?? []) as AnyObject)
}

public func arg(anyClass: AnyClass) -> Arg<AnyObject, AnyObjectArgument> {
    return Arg.AnyObject(anyClass)
}

public func arg<A: Equatable>(equatable: A) -> Arg<AnyObject, A> {
    return Arg.Equatable(equatable)
}

public func arg<A: Equatable>(list: [A]) -> Arg<AnyObject, A> {
    return Arg.List(list)
}

public func arg<A, B>(dict: [A: B]) -> Arg<AnyObject, String> {
    let flattened = dict.map({"\($0):\($1)"})
    return Arg.List(flattened)
}

public func arg<A, B>(dict: [A: B]?) -> Arg<AnyObject, String> {
    return arg(dict ?? [:])
}

public func arg<A: Equatable>(equatable: A?) -> Arg<AnyObject, A> {
    if let equatable = equatable {
        return Arg.Equatable(equatable)
    } else {
        return Arg.Nil
    }
}

// MARK: Args0

public class Args0: Equatable {}

public func == (lhs: Args0, rhs: Args0) -> Bool {
    return true
}

// MARK: Args1

public class Args1<A1: Equatable>: Equatable {
    let arg1: Arg<AnyObject, A1>
    
    public init(_ arg1: Arg<AnyObject, A1>) {
        self.arg1 = arg1
    }
}

public func ==<A1>(lhs: Args1<A1>, rhs: Args1<A1>) -> Bool {
    return lhs.arg1 == rhs.arg1
}

// MARK: Args2

public class Args2<A1: Equatable, A2: Equatable> : Equatable {
    let arg1: Arg<AnyObject, A1>
    let arg2: Arg<AnyObject, A2>
    
    public init(_ arg1: Arg<AnyObject, A1>, _ arg2: Arg<AnyObject, A2>) {
        self.arg1 = arg1
        self.arg2 = arg2
    }
}

public func ==<A1, A2>(lhs: Args2<A1, A2>, rhs: Args2<A1, A2>) -> Bool {
    return lhs.arg1 == rhs.arg1 && lhs.arg2 == rhs.arg2
}

// MARK: Args3

public class Args3<A1: Equatable, A2: Equatable, A3: Equatable>: Equatable {
    let arg1: Arg<AnyObject, A1>
    let arg2: Arg<AnyObject, A2>
    let arg3: Arg<AnyObject, A3>
    
    public init(_ arg1: Arg<AnyObject, A1>, _ arg2: Arg<AnyObject, A2>, _ arg3: Arg<AnyObject, A3>) {
        self.arg1 = arg1
        self.arg2 = arg2
        self.arg3 = arg3
    }
}

public func ==<A1, A2, A3>(lhs: Args3<A1, A2, A3>, rhs: Args3<A1, A2, A3>) -> Bool {
    return lhs.arg1 == rhs.arg1 && lhs.arg2 == rhs.arg2 && lhs.arg3 == rhs.arg3
}


// MARK: Args4

public class Args4<A1: Equatable, A2: Equatable, A3: Equatable, A4: Equatable>: Equatable {
    let arg1: Arg<AnyObject, A1>
    let arg2: Arg<AnyObject, A2>
    let arg3: Arg<AnyObject, A3>
    let arg4: Arg<AnyObject, A4>
    
    public init(_ arg1: Arg<AnyObject, A1>, _ arg2: Arg<AnyObject, A2>, _ arg3: Arg<AnyObject, A3>, _ arg4: Arg<AnyObject, A4>) {
        self.arg1 = arg1
        self.arg2 = arg2
        self.arg3 = arg3
        self.arg4 = arg4
    }
}

public func ==<A1, A2, A3, A4>(lhs: Args4<A1, A2, A3, A4>, rhs: Args4<A1, A2, A3, A4>) -> Bool {
    return lhs.arg1 == rhs.arg1 && lhs.arg2 == rhs.arg2 && lhs.arg3 == rhs.arg3 && lhs.arg4 == rhs.arg4
}

// MARK: Args5

public class Args5<A1: Equatable, A2: Equatable, A3: Equatable, A4: Equatable, A5: Equatable>: Equatable {
    let arg1: Arg<AnyObject, A1>
    let arg2: Arg<AnyObject, A2>
    let arg3: Arg<AnyObject, A3>
    let arg4: Arg<AnyObject, A4>
    let arg5: Arg<AnyObject, A5>
    
    public init(_ arg1: Arg<AnyObject, A1>, _ arg2: Arg<AnyObject, A2>, _ arg3: Arg<AnyObject, A3>, _ arg4: Arg<AnyObject, A4>, _ arg5: Arg<AnyObject, A5>) {
        self.arg1 = arg1
        self.arg2 = arg2
        self.arg3 = arg3
        self.arg4 = arg4
        self.arg5 = arg5
    }
}

public func ==<A1, A2, A3, A4, A5>(lhs: Args5<A1, A2, A3, A4, A5>, rhs: Args5<A1, A2, A3, A4, A5>) -> Bool {
    return lhs.arg1 == rhs.arg1 && lhs.arg2 == rhs.arg2 &&
            lhs.arg3 == rhs.arg3 && lhs.arg4 == rhs.arg4 &&
            lhs.arg5 == rhs.arg5
}

// MARK: Args6

public class Args6<A1: Equatable, A2: Equatable, A3: Equatable, A4: Equatable, A5: Equatable, A6: Equatable>: Equatable {
    let arg1: Arg<AnyObject, A1>
    let arg2: Arg<AnyObject, A2>
    let arg3: Arg<AnyObject, A3>
    let arg4: Arg<AnyObject, A4>
    let arg5: Arg<AnyObject, A5>
    let arg6: Arg<AnyObject, A6>
    
    public init(_ arg1: Arg<AnyObject, A1>, _ arg2: Arg<AnyObject, A2>, _ arg3: Arg<AnyObject, A3>, _ arg4: Arg<AnyObject, A4>, _ arg5: Arg<AnyObject, A5>, _ arg6: Arg<AnyObject, A6>) {
        self.arg1 = arg1
        self.arg2 = arg2
        self.arg3 = arg3
        self.arg4 = arg4
        self.arg5 = arg5
        self.arg6 = arg6
    }
}

public func ==<A1, A2, A3, A4, A5, A6>(lhs: Args6<A1, A2, A3, A4, A5, A6>, rhs: Args6<A1, A2, A3, A4, A5, A6>) -> Bool {
    return lhs.arg1 == rhs.arg1 && lhs.arg2 == rhs.arg2 &&
        lhs.arg3 == rhs.arg3 && lhs.arg4 == rhs.arg4 &&
        lhs.arg5 == rhs.arg5 && lhs.arg6 == rhs.arg6
}

// MARK: Args7

public class Args7<A1: Equatable, A2: Equatable, A3: Equatable, A4: Equatable, A5: Equatable, A6: Equatable, A7: Equatable>: Equatable {
    let arg1: Arg<AnyObject, A1>
    let arg2: Arg<AnyObject, A2>
    let arg3: Arg<AnyObject, A3>
    let arg4: Arg<AnyObject, A4>
    let arg5: Arg<AnyObject, A5>
    let arg6: Arg<AnyObject, A6>
    let arg7: Arg<AnyObject, A7>
    
    public init(_ arg1: Arg<AnyObject, A1>, _ arg2: Arg<AnyObject, A2>, _ arg3: Arg<AnyObject, A3>, _ arg4: Arg<AnyObject, A4>, _ arg5: Arg<AnyObject, A5>, _ arg6: Arg<AnyObject, A6>, _ arg7: Arg<AnyObject, A7>) {
        self.arg1 = arg1
        self.arg2 = arg2
        self.arg3 = arg3
        self.arg4 = arg4
        self.arg5 = arg5
        self.arg6 = arg6
        self.arg7 = arg7
    }
}

public func ==<A1, A2, A3, A4, A5, A6, A7>(lhs: Args7<A1, A2, A3, A4, A5, A6, A7>, rhs: Args7<A1, A2, A3, A4, A5, A6, A7>) -> Bool {
    return lhs.arg1 == rhs.arg1 && lhs.arg2 == rhs.arg2 &&
        lhs.arg3 == rhs.arg3 && lhs.arg4 == rhs.arg4 &&
        lhs.arg5 == rhs.arg5 && lhs.arg6 == rhs.arg6 &&
        lhs.arg7 == rhs.arg7
}

// MARK: Args8

public class Args8<A1: Equatable, A2: Equatable, A3: Equatable, A4: Equatable, A5: Equatable, A6: Equatable, A7: Equatable, A8: Equatable>: Equatable {
    let arg1: Arg<AnyObject, A1>
    let arg2: Arg<AnyObject, A2>
    let arg3: Arg<AnyObject, A3>
    let arg4: Arg<AnyObject, A4>
    let arg5: Arg<AnyObject, A5>
    let arg6: Arg<AnyObject, A6>
    let arg7: Arg<AnyObject, A7>
    let arg8: Arg<AnyObject, A8>
    
    public init(_ arg1: Arg<AnyObject, A1>, _ arg2: Arg<AnyObject, A2>, _ arg3: Arg<AnyObject, A3>, _ arg4: Arg<AnyObject, A4>, _ arg5: Arg<AnyObject, A5>, _ arg6: Arg<AnyObject, A6>, _ arg7: Arg<AnyObject, A7>, _ arg8: Arg<AnyObject, A8>) {
        self.arg1 = arg1
        self.arg2 = arg2
        self.arg3 = arg3
        self.arg4 = arg4
        self.arg5 = arg5
        self.arg6 = arg6
        self.arg7 = arg7
        self.arg8 = arg8
    }
}

public func ==<A1, A2, A3, A4, A5, A6, A7, A8>(lhs: Args8<A1, A2, A3, A4, A5, A6, A7, A8>, rhs: Args8<A1, A2, A3, A4, A5, A6, A7, A8>) -> Bool {
    return lhs.arg1 == rhs.arg1 && lhs.arg2 == rhs.arg2 &&
        lhs.arg3 == rhs.arg3 && lhs.arg4 == rhs.arg4 &&
        lhs.arg5 == rhs.arg5 && lhs.arg6 == rhs.arg6 &&
        lhs.arg7 == rhs.arg7 && lhs.arg8 == rhs.arg8
}

// MARK: Args9

public class Args9<A1: Equatable, A2: Equatable, A3: Equatable, A4: Equatable, A5: Equatable, A6: Equatable, A7: Equatable, A8: Equatable, A9: Equatable>: Equatable {
    let arg1: Arg<AnyObject, A1>
    let arg2: Arg<AnyObject, A2>
    let arg3: Arg<AnyObject, A3>
    let arg4: Arg<AnyObject, A4>
    let arg5: Arg<AnyObject, A5>
    let arg6: Arg<AnyObject, A6>
    let arg7: Arg<AnyObject, A7>
    let arg8: Arg<AnyObject, A8>
    let arg9: Arg<AnyObject, A9>
    
    public init(_ arg1: Arg<AnyObject, A1>, _ arg2: Arg<AnyObject, A2>, _ arg3: Arg<AnyObject, A3>, _ arg4: Arg<AnyObject, A4>, _ arg5: Arg<AnyObject, A5>, _ arg6: Arg<AnyObject, A6>, _ arg7: Arg<AnyObject, A7>, _ arg8: Arg<AnyObject, A8>, _ arg9: Arg<AnyObject, A9>) {
        self.arg1 = arg1
        self.arg2 = arg2
        self.arg3 = arg3
        self.arg4 = arg4
        self.arg5 = arg5
        self.arg6 = arg6
        self.arg7 = arg7
        self.arg8 = arg8
        self.arg9 = arg9
    }
}

public func ==<A1, A2, A3, A4, A5, A6, A7, A8, A9>(lhs: Args9<A1, A2, A3, A4, A5, A6, A7, A8, A9>, rhs: Args9<A1, A2, A3, A4, A5, A6, A7, A8, A9>) -> Bool {
    return lhs.arg1 == rhs.arg1 && lhs.arg2 == rhs.arg2 &&
        lhs.arg3 == rhs.arg3 && lhs.arg4 == rhs.arg4 &&
        lhs.arg5 == rhs.arg5 && lhs.arg6 == rhs.arg6 &&
        lhs.arg7 == rhs.arg7 && lhs.arg8 == rhs.arg8 &&
        lhs.arg9 == rhs.arg9
}

// MARK: Args10

public class Args10<A1: Equatable, A2: Equatable, A3: Equatable, A4: Equatable, A5: Equatable, A6: Equatable, A7: Equatable, A8: Equatable, A9: Equatable, A10: Equatable>: Equatable {
    let arg1: Arg<AnyObject, A1>
    let arg2: Arg<AnyObject, A2>
    let arg3: Arg<AnyObject, A3>
    let arg4: Arg<AnyObject, A4>
    let arg5: Arg<AnyObject, A5>
    let arg6: Arg<AnyObject, A6>
    let arg7: Arg<AnyObject, A7>
    let arg8: Arg<AnyObject, A8>
    let arg9: Arg<AnyObject, A9>
    let arg10: Arg<AnyObject, A10>
    
    public init(_ arg1: Arg<AnyObject, A1>, _ arg2: Arg<AnyObject, A2>, _ arg3: Arg<AnyObject, A3>, _ arg4: Arg<AnyObject, A4>, _ arg5: Arg<AnyObject, A5>, _ arg6: Arg<AnyObject, A6>, _ arg7: Arg<AnyObject, A7>, _ arg8: Arg<AnyObject, A8>, _ arg9: Arg<AnyObject, A9>, _ arg10: Arg<AnyObject, A10>) {
        self.arg1 = arg1
        self.arg2 = arg2
        self.arg3 = arg3
        self.arg4 = arg4
        self.arg5 = arg5
        self.arg6 = arg6
        self.arg7 = arg7
        self.arg8 = arg8
        self.arg9 = arg9
        self.arg10 = arg10
    }
}

public func ==<A1, A2, A3, A4, A5, A6, A7, A8, A9, A10>(lhs: Args10<A1, A2, A3, A4, A5, A6, A7, A8, A9, A10>, rhs: Args10<A1, A2, A3, A4, A5, A6, A7, A8, A9, A10>) -> Bool {
    return lhs.arg1 == rhs.arg1 && lhs.arg2 == rhs.arg2 &&
        lhs.arg3 == rhs.arg3 && lhs.arg4 == rhs.arg4 &&
        lhs.arg5 == rhs.arg5 && lhs.arg6 == rhs.arg6 &&
        lhs.arg7 == rhs.arg7 && lhs.arg8 == rhs.arg8 &&
        lhs.arg9 == rhs.arg9 && lhs.arg10 == rhs.arg10
}

// MARK: Args11

public class Args11<A1: Equatable, A2: Equatable, A3: Equatable, A4: Equatable, A5: Equatable, A6: Equatable, A7: Equatable, A8: Equatable, A9: Equatable, A10: Equatable, A11: Equatable>: Equatable {
    let arg1: Arg<AnyObject, A1>
    let arg2: Arg<AnyObject, A2>
    let arg3: Arg<AnyObject, A3>
    let arg4: Arg<AnyObject, A4>
    let arg5: Arg<AnyObject, A5>
    let arg6: Arg<AnyObject, A6>
    let arg7: Arg<AnyObject, A7>
    let arg8: Arg<AnyObject, A8>
    let arg9: Arg<AnyObject, A9>
    let arg10: Arg<AnyObject, A10>
    let arg11: Arg<AnyObject, A11>
    
    public init(_ arg1: Arg<AnyObject, A1>, _ arg2: Arg<AnyObject, A2>, _ arg3: Arg<AnyObject, A3>, _ arg4: Arg<AnyObject, A4>, _ arg5: Arg<AnyObject, A5>, _ arg6: Arg<AnyObject, A6>, _ arg7: Arg<AnyObject, A7>, _ arg8: Arg<AnyObject, A8>, _ arg9: Arg<AnyObject, A9>, _ arg10: Arg<AnyObject, A10>, _ arg11: Arg<AnyObject, A11>) {
        self.arg1 = arg1
        self.arg2 = arg2
        self.arg3 = arg3
        self.arg4 = arg4
        self.arg5 = arg5
        self.arg6 = arg6
        self.arg7 = arg7
        self.arg8 = arg8
        self.arg9 = arg9
        self.arg10 = arg10
        self.arg11 = arg11
    }
}

public func ==<A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11>(lhs: Args11<A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11>, rhs: Args11<A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11>) -> Bool {
    return lhs.arg1 == rhs.arg1 && lhs.arg2 == rhs.arg2 &&
        lhs.arg3 == rhs.arg3 && lhs.arg4 == rhs.arg4 &&
        lhs.arg5 == rhs.arg5 && lhs.arg6 == rhs.arg6 &&
        lhs.arg7 == rhs.arg7 && lhs.arg8 == rhs.arg8 &&
        lhs.arg9 == rhs.arg9 && lhs.arg10 == rhs.arg10 &&
        lhs.arg11 == rhs.arg11
}
