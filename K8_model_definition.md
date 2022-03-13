# K8 Vavoom model definition
This guide is written by reading the k8vavoom source code and as accurate as author's undestanding of it. So there may be some errors.
Also, you can use the `specs/unfinished/k8vavoom_models.txt` file from the sources as a reference.

_Implementation note_. For boolean values there are some additional options:

TRUE:
* yes
* tan
* true

FALSE:
* no
* ona
* false

## model list
```
<?xml version="1.0" encoding="UTF-8" ?>
<vavoom_models_list>
  <!-- the only possible node here -->
  <include file="models/ammo/clip.xml" />
</vavoom_models_list>

```

## vavoom_model_definition
This is the only root element in the xml definition. 

_Attributes_
 * noselfshadow [true|**false**]

_Nodes_
 * model 
 * class

### model
_Attributes_
 * name [string], cannot be empty
 * noselfshadow, ignored
 
_Nodes_
 * md2
 * md3
 * kvx

### model nodes
The md2, md3, and kvx nodes handle model definitions.
You can have several of them, and refer to models by their names.
	
_Attributes_ 
 * file [string], cannot be empty
 * mesh_index [int], not compatible with a voxel model
 * version [int] -- model version. this is used to assign different player models to different weapons, using `Weapon.PlayerModelVersion`
 * position_file [string], not compatible with a voxel model, sets "position model"
 * skin_anim_speed [int], not compatible with a voxel model, sets skin animation speed, in seconds; requires `skin_anim_range`
 * skin_anim_range [int], not compatible with a voxel model, number of skins in animation loop
 * fullbright [true|**false**] this model is fullbright
 * noshadow [true|**false**] this model doesn't cast shadow 
 * usedepth [true|**false**] force depth flag (for things like monsters with alpha transaparency)
 * allowtransparency [true|**false**] allow transparency in skin files, for skins that are transparent in solid models
 * shift_x [float]
 * shift_y [float]
 * shift_z [float]
 * offset_x [float]
 * offset_y [float]
 * offset_z [float]
 * scale_x [float]
 * scale_y [float]
 * scale_z [float]
 * pivotz  [true|**false**], for voxels
 
 _Nodes_
 * frame
 * skin
 * subskin
 * transform
 
 #### Frame node
Defines model frames. Each used frame in model file should be listed here, and assigned an index.
Note that "index" is a model frame index.

_Attributes_
 * index [int], current frame index by default
 * end_index [int], model frame end index (inclusive), default: index
 * count [int, 0], conflicts with end_index, number of frames to create
 * position_index [int, 0]
 * alpha_start [float, 1.0]
 * alpha_end [float, 1.0]
 * skin_index [int, -1]
 * shift_x [float]
 * shift_y [float]
 * shift_z [float]
 * offset_x [float]
 * offset_y [float]
 * offset_z [float]
 * scale_x [float]
 * scale_y [float]
 * scale_z [float]
 
_Nodes_
 * transform

#### transform node

contains set of transformations, like this:
```
<transform>
  <offset>
    <z>-10</z>
  </offset>
</transform>
```

Allowed simple transformations: "offset", "scale", "rotate". Those
transformations can have either "value" subtag, or "x", "y", "z".
The transformations are stacked.

You can also specify transformation matrix with:
```
  <matrix>
    1 0 0 0
    0 1 0 0
    0 0 1 0
    0 0 0 1
  </matrix>
```

It's just raw 4x4 matrix values. You can use `absolute="true"` attribute to
replace the current matrix, otherwise matrix multiplication will be used.

WARNING! The matrix must describe a valid affine transformation, but cannot include
shearing. This is because frame interpolator doesn't know what to do with shearing yet.

Each frame can have a local transform tag too.


#### Skin node
Voxel models cannot have skins
	
_Attributes_
 * file [string]
 * shade [string]
 
#### Subskin node
_Attributes_
 * file [string]
 * shade [string]
 * submodel_index [int, -1]

### class
	
_Attributes_
* name [string]
* noselfshadow [true|**false**] this class won't shadow self
* iwadonly [true|**false**] replace frames only if sprites are from IWAD
* thiswadonly [true|**false**]
* rotation  [true|**false**] replace frames only if sprites are from the current WAD/PK3
* bobbing  [true|**false**]

_Nodes_
* state

#### State node
Attaches the model to a state.
You can assign model either to a state with the given number (int index), or to a sprite (string sprite).
	
_Attributes_
* "index [int,0]", conflicts with sprite, starting state index; use `-1` for "all states"
* "last_index [int]" used to assign model to state range
* "sprite" [string] base sprite name (4 chars)
* "sprite_frame" [string] sprite frame (1 char)
* "model" [string]
* "angle_yaw" [float]
* "angle_pitch" [float]
* "angle_roll" [float]
* "rotate_yaw" [float]
* "rotate_pitch" [float]
* "rotate_roll" [float]
* "rotation"  [true|**false**]
* "bobbing" [true|**false**]
* "gzdoom" [true|**false**]
* "usepitch" [**actor**|momentum|actor-inverted|momentum-inverted|default]
* "useroll ["actor|momentum|default|**false**]
* "frame_index" [int,0]
* "submodel_index" [int, -1]
* "hidden" [true|**false**]
* "inter" [float, 0.0]  if you want to assign more than one model to some state/sprite, use this to specify interstate time [0..1]
* "angle_start" float, 0.0]
* "angle_end" float, 0.0]
* "alpha_start" [float, 1.0]
* "alpha_end" [float, 1.0]

## Example
```
<?xml version="1.0" encoding="UTF-8" ?>
<vavoom_model_definition>
	<model name="base">
		<md2 file="models/lights/fbarrel.md2" skin_anim_speed="32" skin_anim_range="8">
			<frame index="0" />
			<frame index="1" />
			<frame index="2" />
		</md2>
	</model>
	<class name="BurningBarrel"  iwadonly="true">
		<!-- Spawn -->
		<state index="0" model="base"  frame_index="0" />
		<state index="1" model="base"  frame_index="1" />
		<state index="2" model="base"  frame_index="2" />
	</class>
</vavoom_model_definition>
```
