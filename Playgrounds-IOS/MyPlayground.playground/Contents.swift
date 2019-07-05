import UIKit

func fizzbuzz(anInteger num:Int) -> String{
    var str = String()
    if num%3 == 0 && num%5 != 0{
        str = "Fizz"
    }else if num%5 == 0 && num%3 != 0{
        str = "Buzz"
    }else if num%3==0 && num%5 == 0{
        str = "Fizz Buzz"
    }else{
        str = "Num: \(num)"
    }
    
    return str
}

fizzbuzz(anInteger: 3)
fizzbuzz(anInteger: 5)
fizzbuzz(anInteger: 15)
fizzbuzz(anInteger: 16)

