package _Base._Game._Blocks._States
{
	import _Base._Game._Managers.BlockManager;
	import _Base._Game._Utility.BlockUtilities;
	import _Base._Game._Blocks._Base.Block;
	import _Base._Game._States._Base.DestructionState;

	public class Destroy extends DestructionState
	{
		public function Destroy(block:Block)
		{
			super(block);
		}
		
		public override function enter(currentOverride:Boolean=false):void
		{
			super.enter();
			this._animationCompleted = true;
		}
		
		public override function toString():String
		{
			return "Destroy";
		}
	}
}