package unit_tests.slExtend;

import slExtend.SLExtend;
import slExtend.SLFilter;
import unit_tests.slExtend.ExtendableCoreClass1;

/**
 * This class is used as a plugin which is using SLExtend to extend an existing method
 */
class PluginMethodExtend
{
	// core application nameSpace + className + methodName
	private static inline var _methodPath:String = 'unit_tests.slExtend.ExtendableCoreClass1.test1';
	
	private static function main():Void
	{
		// instanciate core class
		var classInstance:ExtendableCoreClass1 = new ExtendableCoreClass1();

		// test SLExtend 
		testExtend(classInstance);

		//classInstance.test1('unit_tests.slExtend.ExtendableCoreClass1.test1');
		classInstance.test1();
	}
	
	private static function testExtend(classInstance:Dynamic):Void
	{
		// test SLExtend.extend
		SLExtend.extend(_methodPath, pluginMethod1, 1);
		SLExtend.extend(_methodPath, pluginMethod2, 2);
		SLExtend.extend(_methodPath, pluginMethod3, 3);
	}
	
	//private static function pluginMethod1(param1:String):Void
	private static function pluginMethod1():Void
	{
		trace('pluginMethod1 called');
		SLExtend.super(_methodPath,[]);
	}
	
	//private static function pluginMethod2(param1:String):Void
	private static function pluginMethod2():Void
	{
		trace('pluginMethod2 called');
		SLExtend.super(_methodPath,[]);
	}
	
	//private static function pluginMethod2(param1:String):Void
	private static function pluginMethod3():Void
	{
		trace('pluginMethod3 called');
		SLExtend.super(_methodPath,[]);
	}
}