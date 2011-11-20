package _Base._Game._Blocks._States
{
	import _Base._Game._Managers.BlockManager;
	import _Base._Game._Managers.GameManager;
	import _Base._Game._Managers.PhysicsManager;
	import _Base._Game._Blocks._Base.Block;
	import _Base._Game._States._Base.BlockState;
	import _Base._Game._States._Base.BombEffectState;
	import _Base._Game._Utility.BlockUtilities;
	
	public class Fall extends BlockState
	{
		private var _startingTime:Number = 0;
		private var _collisionDetected:Boolean = false;
		
		private var _targetHeight:Number;
		
		public function Fall(block:Block)
		{
			super(block);
			_targetHeight = BlockUtilities.ROW_HEIGHTS[Math.floor(_self.BID / BlockManager.BLOCKS_PER_ROW)];
		}
		
		public override function update(time:Number):void
		{
			if(_startingTime == 0)
				_startingTime = time;
			
			PhysicsManager.MakeFall(_self,time,_startingTime);
			_collisionDetected = PhysicsManager.CollisionCheck(_self, _targetHeight);
			
			if(_collisionDetected)
			{
				if(_self.BID - BlockManager.BLOCK_VERT >= 0)
					GameManager.blockManager.Blocks[_self.BID - BlockManager.BLOCK_VERT].FSM.changeState(new Slammed(GameManager.blockManager.Blocks[_self.BID - BlockManager.BLOCK_VERT],
						_self.Weight));
					
				
				_self.Y = _targetHeight;
				_self.Z = 10;
				
				_self.FallState = null;
			}
		}
		
		public override function toString():String
		{
			return "Fall";
		}
	}
}