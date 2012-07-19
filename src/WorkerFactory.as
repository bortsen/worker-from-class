package
{
	import com.codeazur.as3swf.SWF;
	import com.codeazur.as3swf.data.SWFSymbol;
	import com.codeazur.as3swf.tags.ITag;
	import com.codeazur.as3swf.tags.TagDoABC;
	import com.codeazur.as3swf.tags.TagEnableDebugger2;
	import com.codeazur.as3swf.tags.TagEnd;
	import com.codeazur.as3swf.tags.TagFileAttributes;
	import com.codeazur.as3swf.tags.TagShowFrame;
	import com.codeazur.as3swf.tags.TagSymbolClass;
	
	import flash.system.Worker;
	import flash.system.WorkerDomain;
	import flash.utils.ByteArray;
	
	import avmplus.getQualifiedClassName;

	public class WorkerFactory
	{
		
		/**
		 * Creates a Worker from a Class.
		 * @param clazz the Class to create a Worker from
		 * @param bytes SWF ByteArray which must contain the Class definition (usually loaderInfo.bytes)
		 * @param debug set to tru if you want to debug the Worker
		 * @param domain the WorkerDomain to create the Worker in
		 * @return the new Worker
		 */
		public static function getWorkerFromClass(clazz:Class, bytes:ByteArray, debug:Boolean = true, domain:WorkerDomain = null):Worker
		{
			var swf:SWF = new SWF(bytes);
			var tags:Vector.<ITag> = swf.tags;
			var className:String = getQualifiedClassName(clazz).replace(/::/g, "."); 
			var abcName:String = className.replace(/\./g, "/");
			var classTag:ITag;
			
			for each (var tag:ITag in tags) 
			{
				if (tag is TagDoABC && TagDoABC(tag).abcName == abcName)
				{
					classTag = tag;
					break;
				}
			}
			
			if (classTag)
			{
				swf = new SWF();
				swf.version = 17;
				swf.tags.push(new TagFileAttributes());
				if (debug)
					swf.tags.push(new TagEnableDebugger2());
				swf.tags.push(classTag);
				var symbolTag:TagSymbolClass = new TagSymbolClass();
				symbolTag.symbols.push(SWFSymbol.create(0, className));
				swf.tags.push(symbolTag);
				swf.tags.push(new TagShowFrame());
				swf.tags.push(new TagEnd());
				
				var swfBytes:ByteArray = new ByteArray();
				swf.publish(swfBytes);
				swfBytes.position = 0;
				
				if (!domain)
					domain = WorkerDomain.current;
				
				return domain.createWorker(swfBytes);	
			}
			
			return null;
		}
	}
}