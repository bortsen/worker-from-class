package
{
	import flash.display.Sprite;
	import flash.system.Worker;
	
	import workers.MyWorker;
	
	public class WorkerFromClass extends Sprite
	{
		public function WorkerFromClass()
		{
			var worker:Worker = WorkerFactory.getWorkerFromClass(MyWorker, loaderInfo.bytes);
			worker.start();
		}
	}
}