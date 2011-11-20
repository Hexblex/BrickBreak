package _Base._Game._Managers
{
	import _Base._Game._Blocks._Base.Block;
	
	import away3d.events.IteratorEvent;
	import away3d.materials.ColorMaterial;
	
	import de.polygonal.ds.ArrayedStack;
	import de.polygonal.ds.ArrayedStackIterator;
	import de.polygonal.ds.Itr;
	import de.polygonal.ds.LinkedDeque;
	import de.polygonal.ds.LinkedQueue;
	import de.polygonal.ds.LinkedQueueIterator;
	import de.polygonal.ds.LinkedStack;
	
	import flash.text.TextField;
	import flash.utils.getTimer;
	
	import org.osmf.net.dynamicstreaming.INetStreamMetrics;
	
	public class PhysicsManager
	{
		private static const GRAVITY_FORCE:Number = 0.1;

		public function PhysicsManager() {}
		
		public static function MakeFall(blockToFall:Block, timeNow:Number,startingTime:Number):void
		{
			var t_delta:Number = (timeNow  - startingTime)/1000;
			
			blockToFall.Y -= blockToFall.Speed * t_delta + 0.5 * GRAVITY_FORCE * t_delta * t_delta;
			blockToFall.Speed += GRAVITY_FORCE * t_delta;	
		}
		
		public static function CollisionCheck(fallingBlock:Block,targetHeight:Number):Boolean
		{
			var collisionDetected:Boolean = false;
			
			if(fallingBlock.Y > targetHeight)
				collisionDetected = false;
			else
				collisionDetected = true;
				
			return collisionDetected;
		}
	}
}