package _Base._Game._Blocks._Base
{
	import _Base._Game._Blocks._Headers.IBlock;
	import _Base._Game._Blocks._Headers.IState;
	import _Base._Game._Blocks._Misc.BlockProperties;
	import _Base._Game._Blocks._Misc.MaterialProperty;
	import _Base._Game._Blocks._States.Melt;
	import _Base._Game._Blocks._States.Shielded;
	import _Base._Game._Blocks._States.Soak;
	import _Base._Game._Blocks._States.Stationary;
	import _Base._Game._Framework.StateMachine;
	import _Base._Game._GUI.HealthBar;
	import _Base._Game._Managers.BlockManager;
	import _Base._Game._Managers.SpriteSheetManager;
	import _Base._Game._States._Base.BlockState;
	import _Base._Game._States._Base.BombEffectState;
	import _Base._Game._States._Base.DestructionState;

	import _Base._Game._Utility.BlockUtilities;
	
	import away3d.containers.ObjectContainer3D;
	import away3d.loaders.Obj;
	import away3d.materials.BitmapMaterial;
	import away3d.materials.Material;
	import away3d.primitives.Cube;
	import away3d.primitives.Plane;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	
	public class Block extends ObjectContainer3D implements IBlock
	{
		protected var _bid:int;
		protected var _fsm:StateMachine;
		protected var _materialProperty:MaterialProperty;
		
		private var _integrity:Number = 100;
		private var _weight:int = 20;
		private var _speed:int = 10;
		
		protected var _mesh:Cube;
		protected var _healthBar:HealthBar;
		protected var _fallState:BlockState;
		
		public function Block(block:Block,materialType:String):void
		{
			super();
			
			if(this !== block)
				throw new IllegalOperationError("You cannot instantiate a new instance of the AbstractBlock class");
			
			_materialProperty = new MaterialProperty();
			
			Type = materialType;
			
			_healthBar = new HealthBar();
			
			_mesh = new Cube();
			_mesh.pushback = true;
			
			this.addChild(_mesh);
			
			this.addChild(_healthBar);
			
			_fsm = new StateMachine();
			
			FSM.changeState(FSM.PreviousState = new Stationary(this));
		}
		
		public function render():void{}
		
		public function get FSM():StateMachine 								{ 		return _fsm; 			  								}		
				
		public function get BID():int										{		return _bid;			  								}
		public function set BID(blockId:int):void							{		_bid = blockId; 		  								}

		public function get Weight():int 									{ 		 return _weight;   	      								}
		public function set Weight(weight:int):void							{ 		_weight = weight;		  								}
		
		public function get Speed():int										{ 		return _speed; 		  	  								}
		public function set Speed(speed:int):void							{ 		_speed = speed;		      								}
		
		public function get Integrity():int 								{ 		return _integrity;	  	  								}
		public function set Integrity(integrity:int):void 					
		{ 		
			_integrity = integrity > 100 ? 100 : integrity;
			_healthBar.adjustHealth(_integrity);
		}
		
		public function get Type():String 									{ 		return _materialProperty.Type; 			  				}
		public function set Type(type:String):void							{ 		_materialProperty.Type = type; 			  				}
		
		public function get CurrentMaterial():String 					 	{ 		return _materialProperty.CurrentMaterial; 	  			}
		public function set CurrentMaterial(currentMaterial:String):void 	{ 		_materialProperty.CurrentMaterial = currentMaterial;	}
		
		public function set Material(material:Material):void				{		_mesh.material = material;								}
		
		public function get X():Number										{		return _mesh.x;											}
		public function set X(x:Number):void								{		_mesh.x = x; _healthBar.x = x + 15;						}
		
		public function get Y():Number										{		return _mesh.y;											}
		public function set Y(y:Number):void								{		_mesh.y = y; _healthBar.y = y + 40;						}
		
		public function get Z():Number										{		return _mesh.z;											}
		public function set Z(z:Number):void								{		_mesh.z = z; _healthBar.z = z -60;						}
		
		public function get MaterialProperties():MaterialProperty 			{ 		return _materialProperty;   							}
		
		public function get Health():HealthBar								{		return _healthBar;										}
		
		public function get FallState():BlockState							{ 		return _fallState;										}
		public function set FallState(fallState:BlockState):void			{		_fallState = fallState;									}
		
		protected function integrityCheck():Boolean							{		return false;											}
		
		public static function GetStateProperties(type:String,state:String,bombDropped:String):Object
		{
			return BlockProperties.GetProperty(type, state, bombDropped);
		}
		
		private function stripMaterial():Boolean
		{
			if(FSM.NextState.toString() == "Shielded"|| FSM.NextState.toString() == "Freeze")
				return false;
			else
				return true;
		}
		
		private function onTransition():void
		{
			if(FSM.CurrentState.toString() == FSM.NextAttemptedState)
				FSM.CurrentState.activateApply(true);
			else
			{	
				if((FSM.CurrentState as BlockState).TransitionPercentage == 100)
					FSM.changeToAttempted(this);		
			}
		}
		
		public function onDestroy():void { FSM.changeState(new DestructionState(this)); }
		
		public function onBurn(phase:int):void 
		{ 
			if(phase == BlockState.ENTER || phase == BlockState.RETURNING)
			{
				integrityCheck();
				_materialProperty.Burnt = true;
				BlockUtilities.ChangeBlockTexture(this);
			}
			else if(phase == BlockState.TRANSITION)
			{
				(FSM.CurrentState as BombEffectState).TransitionPercentage = 100;
				onTransition();
			}
			else if(phase == BlockState.APPLY)
			{
				integrityCheck();
				BlockUtilities.ChangeBlockTexture(this);
			}
			else if(phase == BlockState.EXIT)
			{
				if(stripMaterial())
					_materialProperty.Burnt = false;
			}
		}
		
		public function onFreeze(phase:int):void
		{
			if(phase == BlockState.ENTER || phase == BlockState.RETURNING)
			{
				if(MaterialProperties.Slammed)
				{
					MaterialProperties.Slammed = false;
					FSM.goToPreviousState();
				}
				else
				{
					integrityCheck();
					_materialProperty.Frozen = true;
					BlockUtilities.ChangeBlockTexture(this);
				}
			}
			else if(phase == BlockState.TRANSITION)
			{
				(FSM.CurrentState as BombEffectState).TransitionPercentage = 100;
				onTransition();
			}
			else if(phase == BlockState.APPLY)
			{
					integrityCheck();
					BlockUtilities.ChangeBlockTexture(this);
			}
			else if(phase == BlockState.RETURNING)
			{
				
			}
			else if(phase == BlockState.EXIT)
			{
				if(stripMaterial())
					_materialProperty.Frozen = false;
			}
		}
		
		public function onHealth(phase:int):void
		{
			
		}
		
		public function onMelt(phase:int):void
		{
			if(phase == BlockState.ENTER || phase == BlockState.RETURNING)
			{
				integrityCheck();
				_materialProperty.Melted = true;
				BlockUtilities.ChangeBlockTexture(this);
			}
			else if(phase == BlockState.TRANSITION)
			{
				(FSM.CurrentState as BombEffectState).TransitionPercentage = 100;
				onTransition();
			}
			else if(phase == BlockState.APPLY)
			{
				//if(integrityCheck())
					integrityCheck();
					BlockUtilities.ChangeBlockTexture(this);
			}
			else if(phase == BlockState.EXIT)
			{
				if(stripMaterial())
					_materialProperty.Melted = false;
			}
		}
		
		public function onShield(phase:int):void
		{
			if(phase == BlockState.ENTER)
			{
				_materialProperty.Shielded = true;
				BlockUtilities.ChangeBlockTexture(this);
			}
			else if(phase == BlockState.EXIT)
			{
				_materialProperty.Shielded = false;
			}
		}
		
		public function onSoak(phase:int):void
		{
			if(phase == BlockState.ENTER || phase == BlockState.RETURNING)
			{
				integrityCheck();
				_materialProperty.Soaked = true;
				BlockUtilities.ChangeBlockTexture(this);
			}
			else if(phase == BlockState.TRANSITION)
			{
				(FSM.CurrentState as BombEffectState).TransitionPercentage = 100;
				onTransition();
			}
			else if(phase == BlockState.APPLY)
			{
				//if(integrityCheck())
					integrityCheck();
					BlockUtilities.ChangeBlockTexture(this);
			}
			else if(phase == BlockState.EXIT)
			{
				if(stripMaterial())
					_materialProperty.Soaked = false;
			}
		}
	
		public function onStationary(phase:int):void 
		{ 
			if(phase == BlockState.ENTER || phase == BlockState.RETURNING)
			{
				this.MaterialProperties.resetProperties();
				integrityCheck();
				BlockUtilities.ChangeBlockTexture(this);
			}
			else if(phase == BlockState.TRANSITION)
			{
				(FSM.CurrentState as BombEffectState).TransitionPercentage = 100;
				FSM.changeToAttempted(this);
			}
		}
	}
}