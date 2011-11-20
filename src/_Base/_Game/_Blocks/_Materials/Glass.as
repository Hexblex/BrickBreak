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
	
	public class Glass extends Block implements IAcidable, IShieldable, IIceable, IHealthable, IJokerable
	{
		public function Glass()
		{
			super(this,"Glass");
		}
		
		public override function render():void
		{
			super.render();
		}
		
		protected override function integrityCheck():Boolean
		{
			if(Integrity >= 50)
			{
				if(_materialProperty.Health != BlockHealth.HEALTHY)
				{
					_materialProperty.Health = BlockHealth.HEALTHY;
					return true;
				}
			}
			else
			{
				if(_materialProperty.Health != BlockHealth.FATAL)
				{
					_materialProperty.Health = BlockHealth.FATAL;
					return true;
				}
			}	
			
			return false;
		}
		
		public override function onBurn(phase:int):void
		{	
			super.onBurn(phase);
		}
		
		public override function onMelt(phase:int):void
		{
			super.onMelt(phase);
		}
		
		public override function onFreeze(phase:int):void
		{
			if(phase == BlockState.RETURNING)
			{
				if(MaterialProperties.Slammed)
				{
					MaterialProperties.Slammed = false;
					FSM.goToPreviousState();
				}
				else
					BlockUtilities.ChangeBlockTexture(this);
			}
			else if(phase == BlockState.TRANSITION)
			{
				if(FSM.NextAttemptedState == "Melt")
				{
					(FSM.CurrentState as BombEffectState).TransitionPercentage += 50;
					
					if((FSM.CurrentState as BombEffectState).TransitionPercentage == 100)
					{
						FSM.goToPreviousState();
					}
				}
			}
			else
				super.onFreeze(phase);
		}
		
	}	
}