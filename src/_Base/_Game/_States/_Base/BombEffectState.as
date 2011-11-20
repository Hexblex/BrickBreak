package _Base._Game._States._Base
{
	import _Base._Game._Blocks._Base.Block;
	import _Base._Game._Managers.RulesManager;
	import _Base._Game._Utility.BlockUtilities;
	
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public class BombEffectState extends BlockState
	{
		protected var _start:Number = 0;
		protected var _timeAccumulated:Number = 0;
		protected var _timeDelta:Number;
		protected var _runApply:Boolean = true;
		
		protected var _settings:Object;
		
		public function BombEffectState(block:Block,bombType:String,runApply:Boolean=false) 
		{ 
			super(block);
			
			_runApply = runApply;
			
			_initialBombDropped = bombType;
			_latestBombDropped = bombType;
		}
		
		public override function activateApply(refreshProperties:Boolean = false):void
		{
			if(refreshProperties)
				_settings = Block.GetStateProperties(_self.MaterialProperties.Type,_self.FSM.CurrentState.toString(), LatestBombDropped);
			
			_runApply = true;
		}
		
		public override function deactivateApply():void
		{
			_timeAccumulated = 0;
			_start = 0;
			_runApply = false;
		}
		
		public override function update(time:Number):void
		{
			super.update(time);
		}
		
		public override function enter(currentOverride:Boolean=false):void 
		{ 
			super.enter();
			
			if(!currentOverride)
				_settings = Block.GetStateProperties(_self.MaterialProperties.Type,_self.FSM.PreviousState.toString(), InitialBombDropped);
			else
				_settings = Block.GetStateProperties(_self.MaterialProperties.Type,_self.FSM.CurrentState.toString(), InitialBombDropped);
			
			if(_settings.damage != 0)
			{
				if(_settings.duration == 0)
				{
					_self.Integrity -= _settings.damage;
					
					if(_self.Integrity <= 5)
						_self.onDestroy();
					
					_settings = null;
				}
				else
					activateApply();
			}
		}
		
		public override function apply(time:Number):void
		{
			if(_settings)
			{
				if(_settings.duration > 0)
				{
					if(_start == 0)
						_start = time;
					
					_timeDelta = (time - _start)/_settings.duration;
					
					_timeAccumulated += (_timeDelta * 1000);
					
					if(_timeAccumulated > _settings.duration)
					{
						_self.Integrity = (_self.Integrity - _settings.damage);
				
						deactivateApply();
						
						if(_self.Integrity <= 5)
							_self.onDestroy();
					}
					
				}
				else if(_settings.damage > 0 && _settings.duration == 0)
				{
					_self.Integrity = (_self.Integrity - _settings.damage);
					
					deactivateApply();
					
					if(_self.Integrity <= 5)
						_self.onDestroy();
				}
			}
			else
				_runApply = false;
		}
		
	}
}