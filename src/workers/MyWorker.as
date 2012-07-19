package workers
{
	import flash.display.Sprite;
	import flash.system.Worker;
	
	public class MyWorker extends Sprite
	{
		public function MyWorker()
		{
			super();
			trace("Hello from the Worker!");
			trace("isPrimordial: " + Worker.current.isPrimordial)
		}
	}
}