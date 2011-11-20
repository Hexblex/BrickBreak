package _Base._Game._Framework
{
	import de.polygonal.ds.Collection;
	import de.polygonal.ds.IntHashSet;
	import de.polygonal.ds.Itr;

	public class IHSIterator implements Itr
	{
		private var _hashSorted:Array;
		private var _index:int = 0;
		private var _max:int = 0;
		
		private var _landingStore:int = 0;
		
		public function IHSIterator(hashSet:IntHashSet)
		{
			_hashSorted = hashSet.toArray().sort(Array.NUMERIC);
			_max = _hashSorted.length;	
		}
		
		public function hasNext():Boolean
		{
			return _index != _max; 
		}
		
		public function next():Object
		{
			return _hashSorted[_index++];
		}
		
		public function reset():Itr
		{
			
			_index = 0;
			_landingStore = -1;
			
			return null;
		}
		
		public function remove():void{}
		

		public function get LandingStore():int
		{
			return _landingStore;
		}
		
		public function set LandingStore(landingStore:int):void
		{
			_landingStore = landingStore;
		}
	}
}