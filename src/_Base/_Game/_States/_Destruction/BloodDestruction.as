package _Base._Game._States._Destruction
{
	import _Base._Game._Blocks._Base.Block;
	import _Base._Game._Bombs._Misc.BombDirection;
	import _Base._Game._Managers.GameManager;
	import _Base._Game._States._Base.BombEffectState;
	import _Base._Game._States._Base.DestructionState;
	
	public class BloodDestruction extends DestructionState
	{
		public function BloodDestruction(block:Block)
		{
			super(block);
		}
		
		public override function enter(currentOverride:Boolean=false):void
		{
			super.enter();
			this._animationCompleted = true;
		}
		
		public override function exit():void
		{
			super.exit();
		}
		
		public override function update(time:Number):void
		{
			var type:String;
			var effect:String;
			
			if((_self.FSM.PreviousState as BombEffectState).LatestBombDropped == "Fire")
			{
				type = "Fire";
				effect = "Burn";
			}
			else if((_self.FSM.PreviousState as BombEffectState).LatestBombDropped == "Water")
			{
				type="Water";
				effect = "Soak";
			}
			else
			{
				type="Acid";
				effect="Melt";
			}
			
			GameManager.logicManager.destroyedBlockSearch(_self.BID, {Type: type, Effect: effect}, BombDirection.VERTICAL_DOWN,true);
			
			super.update(time);
		}
	}
}