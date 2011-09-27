package slExtend;

import slExtend.SLFilter;

/**
 * This class is responsible for managing "extend" functionnality
 * which allows a plugin to extend (also known as override) a specific class (or a method in it)
 * 
 * @author Raphael HARMEL
 * @date   2011-09-11
 */
class SLExtend 
{
	// Array of MethodData
	//var extendableClasses:Array<Dynamic>;
	
	/**
	 * Called by plugins to override a core method.
	 * The callback should have the same signature as the overrided method.
	 * The parameter priority should be in [0,9].
	 * 
	 * @param	classOrInstance
	 * @param	fullMethodPath
	 * @param	callbackFunction
	 * @param	priority
	 */
	public static function extend(fullMethodPath:String, callbackFunction:Dynamic, priority:Int):Void
	{
		// limit priority to 0-9
		if (priority > 9) priority = 9;
		if (priority < 0) priority = 0;
		
		// call SLFilter.addFilter
		SLFilter.getInstance().addFilter(fullMethodPath, callbackFunction, priority );
	}
	
	/**
	 * This method uses SLFilter::applyNextFilterElement in order to call the next callback which overrides the same method.
	 */
	public static function super<T>(fullMethodPath:String,parameters:T):Dynamic
	{
		return SLFilter.getInstance().applyNextFilterElement(fullMethodPath,[]);
	}
}