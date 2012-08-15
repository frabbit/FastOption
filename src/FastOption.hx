
private typedef FO<T> = FastOption<Null<T>>;
  
// the tricky stuff, acts as a newtype like in haskell
#if flash
@:native("Object")
#elseif cpp
@:native("Dynamic")
#else
#end
extern class FastOption<T> {}


class FastOptions 
{

  /* constructors */
  @:noUsing public static inline function Some <T>(v:T):FO<T> 
  {
    #if debug 
    if (v == null) throw "NullException: You cannot create Some from null"; 
    #end
    return from(v);
  }
  
  @:noUsing public static inline function None <T>():FO<T> {
    return cast null;
  }
  
  /* conversion */
  @:noUsing public static inline function from <T>(v:T):FO<T> {
    return cast v;
  }
  
  /* internal stuff */
  static inline function unbox <T>(v:FO<T>):T {
    return cast v;
  }
  
  /* Monadic stuff */
  
  public static inline function map <T, X>(x:FO<T>, f:T->X):FO<X> 
  {
    return if (isNone(x)) None() else Some(f(unbox(x)));
  }
  
  public static inline function flatMap <T, X>(x:FO<T>, f:T->FO<X>):FO<X> 
  {
   return if (isNone(x)) None() else f(unbox(x));
  }
  
  public static inline function flatten <X>(x:FO<FO<X>>):FO<X> 
  {
    return if (isNone(x)) None() else unbox(x);
  }
  
  public static inline function getOrElse <T>(x:FO<T>, elseVal:T):T 
  {
    return if (isSome(x)) unbox(x) else elseVal;
  }
  
  public static inline function extract <T>(x:FO<T>):T 
  {
    return 
      if (isNone(x)) throw "NullException: This FastOption has no value" 
      else           unbox(x);
  }
  
  public static inline function isNone <T>(x:FO<T>):Bool 
  {
    return x == None();
  }
  public static inline function isSome <T>(x:FO<T>):Bool 
  {
    return !isNone(x);
  }
}