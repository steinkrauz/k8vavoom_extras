# K8 Vavoom model definition
This guide is written by reading the k8vavoom source code and as accurate as author's undestanding of it. So there may be some errors.

_Implementation note_. For boolean values there are some additional options:
TRUE:
* yes
* tan
* true

FALSE:
* no
* ona
* false

## vavoom_model_definition
This is the only root element in the xml definition. 
_Attributes_
 * noselfshadow [true|**false**]

_Nodes_
 * <model> 
 * <class>

### model
_Attributes_
 * name [string], cannot be empty
 * noselfshadow, ignored
 
_Nodes_
 * <md2>
 * <md3>
 * <kvx>

### model nodes
The md2, md3, and kvx nodes handle model definitions.
_Attributes_ 
 * file [string], cannot be empty
 * mesh_index [int], not compatible with a voxel model
 * version [int]
 * position_file [string], not compatible with a voxel model
 * skin_anim_speed [int], not compatible with a voxel model
 * skin_anim_range [int], not compatible with a voxel model  
 * fullbright [true|**false**]
 * noshadow [true|**false**]
 * usedepth [true|**false**]
 * allowtransparency [true|**false**]
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
 * <frame>
 * <skin>
 * <subskin>
 * <transform>
 
 #### Frame node

_Attributes_
 * index [int], current frame index by default
 * end_index [int], current frame index by default
 * count [int, 0], conflicts with end_index
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
 * <transform>

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
* noselfshadow [true|**false**]
* iwadonly [true|**false**]
* thiswadonly [true|**false**]
* rotation  [true|**false**]
* bobbing  [true|**false**]

_Nodes_
* <state>

#### State node
_Attributes_
* "angle_yaw" [float]
* "angle_pitch" [float]
* "angle_roll" [float]
* "rotate_yaw" [float]
* "rotate_pitch" [float]
* "rotate_roll" [float]
* "rotation"  [true|**false**]
* "bobbing" [true|**false**]
* "gzdoom" [true|**false**]
* "usepitch" [actor|momentum|actor-inverted|momentum-inverted|default]
* "useroll ["actor|momentum|default]
* "index [int,0]", conflicts with sprite
* "last_index [int]"
* "sprite" [string]
* "sprite_frame" [string]
* "model" [string]
* "frame_index" [int,0]
* "submodel_index" [int, -1]
* "hidden" [true|**false**]
* "inter" [float, 0.0]
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
