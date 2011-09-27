package slExtend;

/**
 * This class is a singleton used internally by the override mechanism.
 * It is used as a helper for SLExtend class, so a plugin can extend (=override) a core application method.
 * 
 * @author Raphael HARMEL
 * @date   2011-09-11
 */
class SLFilter
{
	// class instance singleton
	private static var _instance:SLFilter;

	/**
	 *  The "filters" Hash variable is used to store the filters, and contains their name as key, each value beeing an array of {callback:Dynamic, priority:Int}, ordered by priority.
	 */
	private static var _filters : Hash<Filter>;
	
	/**
	 * class constructor
	 */
	public function new()
	{
	}
	
	/**
	 * Gets the instance singleton
	 * 
	 * @return the singleton
	 */
	public static function getInstance():SLFilter
	{
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
	 * This method is called by SLExtend::override (which is called by the plugins),
	 * in order to set the callback which overrides the initial method.
	 * If filters is not having a filter with "filterName" key, it creates a new filter for this key.
	 * Then it adds a FilterElement to this filter.
	 * 
	 * @param	filterName
	 * @param	filterElement:{ filter: FilterCallback, priority: Int }
	 */
	public function addFilter(filterName : String, callbackFunction:Dynamic, priority:Int) : Void
	{
		var filterElement:FilterElement = { filterCallback: callbackFunction, priority: priority };
		
		//If filter doesn't exist, create it.
		if(!_filters.exists(filterName))
		{
			var filter:Filter = { currentIndex:0, elements:new Array<FilterElement>()};
			_filters.set(filterName, filter);
		}
		
		// get the filter corresponding to filterName
		var filter:Filter = _filters.get(filterName);

		// order and and the new filterElement at the correct position
		for (i in 0...filter.elements.length)
		{
			// Iterate over array to find a filterElement with priority >= priority
			if(filter.elements[i].priority >= filterElement.priority)
			{
				// filterElement found, so insert the new filterElement before.
				filter.elements.insert(i, filterElement);
				filter.currentIndex = filter.elements.length-1;
				return;
			}
		}
		// no filterElement found with priority >= priority, so push the new filterElement.
		filter.elements.push(filterElement);
		
		// set currentIndex to "filter.elements.length - 1"
		filter.currentIndex = filter.elements.length-1;
	}
	
	/**
	 * This method is called by the core application when an overridable method is called.
	 * This call replaces the original method code, which is placed in another method named "_slExtend_originalMethodName()" (done by slExtend.Macro).
	 * 
	 * This method calls the callback with the most priority stored in the Filter having "filterName" key within the filters. In other words, this method calls the filters which have been registered to listen to filterName for the whole class.
	 * 
	 * It returns the callback return if any.
	 * 
	 * @param	filterName
	 * @param	parameters
	 * @return	the callback return if any
	 */
	public function applyFilters<T>(filterName:String, parameters:T) : Dynamic
	{
		// If filter exist, launch the callback with the highest priority
		if(_filters.exists(filterName))
		{
			// get the filter corresponding to filterName
			var filter:Filter = _filters.get(filterName);
			// return the last FilterElement callback (which has the highest priority
			return filter.elements[filter.elements.length-1].filterCallback(parameters);
		}
		else
		{
			return parameters;
		}
	}
	
	public function applyNextFilterElement<T>(filterName:String, parameters:T) : Dynamic
	{
		// If filter exist, launch the callback with the highest priority
		if(_filters.exists(filterName))
		{
			// get the filter corresponding to filterName
			var filter:Filter = _filters.get(filterName);
			// if there are lower priority callbacks in filter, decrement filter.currentIndex
			if (filter.currentIndex > 0)
			{
				filter.currentIndex--;
			}
			// if there is no more callbacks, return parameters
			else
			{
				return parameters;
			}
			// return the FilterElement[filterIndex] callback
			return filter.elements[filter.currentIndex].filterCallback(parameters);
		}
		else
		{
			return parameters;
		}
	}
	
}

/**
 * Defines the FilterCallback type (i.e. the callback filtering function).
 */
typedef FilterCallback = Dynamic->Dynamic;

/**
 * Defines the FilterElement type (i.e. FilterCallback + priority).
 */
typedef FilterElement = { filterCallback: FilterCallback, priority: Int };

/**
 * Defines the Filter type (i.e. array of FilterElement and array current index).
 */
typedef Filter = { currentIndex: Int, elements:Array<FilterElement> };
