package layz.utils
{
	import flash.system.LoaderContext;
	
	public class Definitions
	{
		public static var defaultContext				:LoaderContext;
		
		/**
		 * Check if a class reference exists in a LoaderContext
		 * @param	name
		 * @param	context		search in this LoaderContext instead of the default one
		 * @return
		 */
		public static function hasReference(name:String, context:LoaderContext = null):Boolean
		{
			if (defaultContext == null && context == null)
				throw new Error("# Definition.as # Description: No LoaderContext defined.");
				
			var lc:LoaderContext = (context) ? context : defaultContext;
			
			return lc.applicationDomain.hasDefinition(name);
		}
		
		/**
		 * Get a class reference by name in the default LoaderContext
		 * @param	name		
		 * @param	context		search in this LoaderContext instead of the default one
		 * @return
		 */
		public static function getClassReference(name:String, context:LoaderContext = null):Class
		{
			if (defaultContext == null && context == null)
				throw new Error("# Definition.as # No LoaderContext defined.");
				
			var lc:LoaderContext = (context) ? context : defaultContext;
			
			if (lc.applicationDomain.hasDefinition(name))
			{
				var ref:Class = lc.applicationDomain.getDefinition(name) as Class;
				return ref;
			}
			else
			{
				throw new Error("# Definitions.as # Description: Reference '" + name + "' was not found.");
			}
		}
	}
}