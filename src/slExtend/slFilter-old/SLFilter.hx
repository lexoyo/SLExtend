package slExtend.slFilter;

/**
 * This class is a singleton used only internally by the override mechanism.
 * 
 * @author Raphael HARMEL
 * @date   2011-09-11
 */
class SLFilter
{
	/**
	 *  Holds filters. The key is the Chain's ID.
	 */
	private static var _filters : Hash<Filter>;
	
	// class instance singleton
	private static var _instance:SLFilter;
	
	/**
	 * class constructor
	 */
	public function new()
	{
		trace('new() called');
	}
	
	/**
	 * Gets the instance singleton
	 * 
	 * @return the singleton
	 */
	public static function getInstance():SLFilter
	{
		trace('getInstance() called');
		if (_instance == null)
		{
			_instance = new SLFilter();
			
		}
		return _instance;
	}
	
	/**
	 * Initializes the _filters variable.
	 */
	private static function __init__()
	{
		_filters = new Hash<Filter>();
	}
	
	/**
	 * Filters the given value and returns it modified.
	 * If the ChainFilter doesn't exist, returns the unmodified value.
	 * 
	 * @param	filterName
	 * @param	value
	 * @param	context
	 * @return
	 */
	public function applyFilters(filterName : String, value : Dynamic, context : Dynamic) : Dynamic
	{
		trace('applyFilters called with filterName: ' + filterName);
		if(_filters.exists(filterName))
		{
			return _filters.get(filterName).applyFilters(value, context);
		} else
		{
			return value;
		}
	}
	
	/**
	 * Adds a filter to the Filter.
	 * If the Filter doesn't already exist, creates it.
	 * 
	 * @param	filterName
	 * @param	filter
	 * @param	priority
	 */
	public function addFilter(filterName : String, filter : FilterFunction, priority : Int) : Void
	{
		trace('addFilter called');
		//If Filter doesn't exist, creates it.
		if(!_filters.exists(filterName))
		{
			_filters.set(filterName, new Filter());
		}
		
		_filters.get(filterName).addFilter(filter, priority);
	}
	
	/**
	 * Removes a filter from the Filter.
	 * Should take care of closures (use Reflect.compareMethods).
	 */
	public function removeFilter(filterName : String, filter : FilterFunction) : Void
	{
		if(_filters.exists(filterName))
		{
			_filters.get(filterName).removeFilter(filter);
		}
	}
}