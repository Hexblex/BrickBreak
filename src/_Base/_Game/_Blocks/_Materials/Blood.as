package _Base._Game._Blocks._Materials
{
	import _Base._Game._Blocks._Base.Block;
	import _Base._Game._Blocks._Headers.*;
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
	import _Base._Game._States._Destruction.BloodDestruction;
	import _Base._Game._Utility.BlockUtilities;
	
	public class Blood extends Block implements IFireable, IWaterable, IShieldable, IIceable, IHealthable, IJokerable, IAcidable
	{
		public function Blood()
		{
			super(this,"Blood");
		}
		
		public override function render():void
		{
			super.render();
		}
		
		public override function onBurn(phase:int):void
		{	
			if(phase == BlockState.TRANSITION)
			{
				if((FSM.CurrentState as BombEffectState).LatestBombDropped != "Water" && 
					(FSM.CurrentState as BombEffectState).LatestBombDropped != "Acid")
					super.onBurn(phase);
			}
			else
				super.onBurn(phase);
		}
		
		
		public override function onDestroy():void
		{
			FSM.changeState(new BloodDestruction(this));	
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
		
		public override function onSoak(phase:int):void
		{
			if(phase == BlockState.TRANSITION)
			{
				if((FSM.CurrentState as BombEffectState).LatestBombDropped != "Fire" && 
					(FSM.CurrentState as BombEffectState).LatestBombDropped != "Acid")
					super.onSoak(phase);
			}
			else
				super.onSoak(phase);
		}
		
		public override function onFreeze(phase:int):void
		{
			if(phase == BlockState.TRANSITION)
			{
				if(FSM.NextAttemptedState == "Burn")
					FSM.goToPreviousState();
				else
					super.onFreeze(phase);
			}
			else if(phase == BlockState.RETURNING)
			{
				super.onFreeze(phase);
			}
			else
				super.onFreeze(phase);
		}
	
		public override function onMelt(phase:int):void
		{
			if(phase == BlockState.TRANSITION)
			{
				if((FSM.CurrentState as BombEffectState).LatestBombDropped != "Fire" && 
					(FSM.CurrentState as BombEffectState).LatestBombDropped != "Water")
					super.onMelt(phase);
			}
			else
				super.onMelt(phase);
		}
		
		public override function onStationary(phase:int):void
		{
			if(phase == BlockState.RETURNING)
			{
				if(FSM.PreviousState.toString() == "Freeze")
				{
					FSM.changeState(new Soak(this, "Water"));
				}
				else
					super.onStationary(phase);
			}
			else
				super.onStationary(phase);
		}
	
	}	
}