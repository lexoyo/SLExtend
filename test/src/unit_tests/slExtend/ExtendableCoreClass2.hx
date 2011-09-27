package unit_tests.slExtend;

import haxe.Log;

/**
 * The goal of this test is to use macros to extend this class
 * i.e. to be able to replace its code by another one
 * 
 * The main class uses the "@:build" metadata, used
 * to allow macro to create and alter this class fields
 * at compile-time by calling the Macro.build() static
 * method
 * 
 * @author Raphael HARMEL
 */
//@:build(slExtend.Macro.build())
class ExtendableCoreClass2 
{
	/**
	 * entry point, instantiate the main
	 * class and call the test method
	 * to check that the code of block was
	 * added at compile-time
	 */
	static function main() 
	{
		Log.trace('main');
		var mainInstance:ExtendableCoreClass = new ExtendableCoreClass();
		mainInstance.test1('pouet');
		test3();
		//test2('pouet');
	}

	static function test2() 
	{
		var mainInstance2:ExtendableCoreClass;
		mainInstance2 = new ExtendableCoreClass();
	}

	static function test3() 
	{
		//var classInstance:Class = SLFilter.getInstance().applyFilters("slextend.hook.class.new.MyClass", MyClass);
		var classInstance:Class<Dynamic> = Type.resolveClass('slExtend.slFilter.SLFilter');
		trace(classInstance);
		//var x = new classInstance();
		var x = Type.createInstance(classInstance, null);
		//var x = Type.createEmptyInstance(classInstance);
		x.getInstance();
		x.pouet();
		x.yo;
		//classInstance.getInstance();
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
	 * output. We will add another block of code, also
	 * represented by a trace output before this one.
	 * see Macro.build() method.
	 */
	public function test1(param1:String):Void
	{
		Log.trace("original code block");
	}
	
	/**
	 *  for test only
	 */
	public function applyFilter():Void
	{
		Log.trace("filter applied");
	}

}