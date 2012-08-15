using FastOption;


class SimpleTest 
{
  public static inline function toInt (i:String):FastOption<Int> 
  {
    return FastOptions.from(Std.parseInt(i));
  }
  
  public static inline function biggerThen2 (i:Int):Bool 
  {
    return i > 2;
  }
  
  
  
  
  public static function main() 
  {
    
    var s1 = FastOptions.None();
    var s2 = FastOptions.Some("1");
    
    var t1 = s1.flatMap(toInt).map(function (x) return x - 1).map(biggerThen2).getOrElse(false);
    var t2 = s2.flatMap(toInt).map(function (x) return x - 1).map(biggerThen2).getOrElse(false);
    
    trace(t1); // false
    trace(t2); // false
    
    
    
    // check monadic laws
    
    
    function f (x) return FastOptions.Some(x + 1);
    function g (x) return FastOptions.Some(x + 2);
    
    
    
    //Left identity: 	return a >>= f ≡ 	f a
    
    trace(FastOptions.Some(2).flatMap(f) == f(2));

    //Right identity: 	m >>= return ≡ 	m

    trace(FastOptions.Some(2).flatMap(FastOptions.Some) == FastOptions.Some(2));
    
    //Associativity: 	(m >>= f) >>= g ≡ m >>= (\x -> f x >>= g)
    
    trace(FastOptions.Some(2).flatMap(f).flatMap(g) == FastOptions.Some(2).flatMap(function (x) return f(x).flatMap(g)));
    
    
    
    
  }  
}
