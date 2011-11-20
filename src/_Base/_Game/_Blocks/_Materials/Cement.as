package _Base._Game._Blocks._Materials
{
	import _Base._Game._Blocks._Base.Block;
	import _Base._Game._Blocks._Headers.IAcidable;
	import _Base._Game._Blocks._Headers.IFireable;
	import _Base._Game._Blocks._Headers.IHealthable;
	import _Base._Game._Blocks._Headers.IIceable;
	import _Base._Game._Blocks._Headers.IJokerable;
	import _Base._Game._Blocks._Headers.IShieldable;
	import _Base._Game._Blocks._Headers.IState;
	import _Base._Game._Blocks._Headers.IWaterable;
	import _Base._Game._Blocks._States.Burn;
	import _Base._Game._Blocks._States.Freeze;
	import _Base._Game._Blocks._States.Shielded;
	import _Base._Game._Blocks._States.Soak;
	import _Base._Game._Blocks._States.Stationary;
	import _Base._Game._States._Base.BlockState;
	import _Base._Game._States._Base.BombEffectState;
	import _Base._Game._Utility.BlockUtilities;
	import _Base._Game._Blocks._Misc.BlockHealth;
	
	public class Cement extends Block implements IFireable, IWaterable, IShieldable, IIceable, IHealthable, IJokerable, IAcidable
	{
		public function Cement()
		{
			super(this,"Cement");
		}
		
		public override function render():void
		{
			super.render();
		}
		
		public override function onBurn(phase:int):void
		{
			
		}
		
		public override function onSoak(phase:int):void
		{
			if(phase == BlockState.TRANSITION)
			{
				if(FSM.NextAttemptedState == "Burn")
				{
					BlockUtilities.ChangeBlock(this,"Brick");
				}
				else if(FSM.NextAttemptedState == "Melt")
				{
					BlockUtilities.ChangeBlock(this, "Glass");
				}
			}
			else
				super.onSoak(phase);
		}
		
		public override function onFreeze(phase:int):void
		{
			if(phase == BlockState.RETURNING)
			{
				super.onFreeze(phase);
			}
			else
				super.onFreeze(phase);
		}
		
		public override function onHealth(phase:int):void
		{
			if(FSM.PreviousState.toString() == "Stationary")
			{
				FSM.goToPreviousState();
			}
			else
			{
				FSM.NextAttemptedState = "Stationary";
				FSM.changeToAttempted(this);
			}
				
		}
		
		public override function onMelt(phase:int):void
		{
			if(phase == BlockState.TRANSITION)
			{
				if(FSM.NextAttemptedState == "Burn")
				{
					BlockUtilities.ChangeBlock(this,"Titanium");
				}
				else if(FSM.NextAttemptedState == "Melt")
				{
					BlockUtilities.ChangeBlock(this, "Crystal");
				}
			}
			else
				super.onMelt(phase);
		}
		
		public override function onStationary(phase:int):void
		{
			if(phase == BlockState.TRANSITION)
			{
				if(FSM.NextAttemptedState != "Burn")
				{
					super.onStationary(phase);
				}
			}
			else
				super.onStationary(phase);
		}
	}	
}