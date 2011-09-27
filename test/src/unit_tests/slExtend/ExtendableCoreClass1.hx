package unit_tests.slExtend;

import haxe.Log;
import slExtend.SLFilter;

/**
 * The goal of this test is to use macros to extend
 * the methods having an "extendable" metadata
 * in this class
 * 
 * The main class uses the "@:build" metadata, used
 * to allow macro to create and alter this class fields
 * at compile-time by calling the Macro.build() static
 * method
 * 
 * @author Raphael HARMEL
 */
@:build(slExtend.Macro.build())
class ExtendableCoreClass1
{
	/**
	 * entry point, instantiate the main
	 * class and call the test method
	 * to check that the code of block was
	 * added at compile-time
	 */
	static function main()
	{
		var mainInstance:ExtendableCoreClass1 = new ExtendableCoreClass1();
		//mainInstance.test1('pouet');
		mainInstance.test1();
		//test2('pouet');
	}

	/**
	 * class constructor
	 */
	public function new()
	{
		
	}

	/**
	 * This test method has an "extendable" metadata
	 * used by the macro to find it. By default, it
	 * calls a block of code, represented by a trace
	 * output. We will replace this block of code with another one,
	 * containing another trace output.
	 * see Macro.build() method.
	 */
	@extendable
	//public function test1(param1:String):Void
	public function test1():Void
	{
		Log.trace("original code block");
		//return 'ok';
	}
	
	//@extendable
	//public static function test2(param1:String):Void
	//{
		//Log.trace("original code block");
		//return 'ok';
	//}
	
}