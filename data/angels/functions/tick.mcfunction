#Armor Stand Teleporting
execute as @e[tag=angel] at @s run tp @e[tag=angel_stand,sort=nearest,limit=1] @s
execute as @e[tag=angel] at @s unless entity @e[tag=angel_stand,sort=nearest,distance=..1] run effect give @s slowness 1 255 true
execute as @e[tag=angel_stand] at @s unless entity @e[tag=angel,sort=nearest,distance=..1] run tp @s @e[tag=angel,sort=nearest,limit=1]

#Get Follow Data
execute store result entity @e[tag=angel,scores={angel_follow=1},limit=1] WanderTarget.X int 1 run data get entity @a[tag=angel_nearest,limit=1] Pos[0]
execute store result entity @e[tag=angel,scores={angel_follow=1},limit=1] WanderTarget.Y int 1 run data get entity @a[tag=angel_nearest,limit=1] Pos[1]
execute store result entity @e[tag=angel,scores={angel_follow=1},limit=1] WanderTarget.Z int 1 run data get entity @a[tag=angel_nearest,limit=1] Pos[2]

#Tag Nearest Player
execute as @e[tag=angel_stand] at @e[tag=angel_stand] run tag @a[sort=nearest,limit=1] add angel_nearest

#Teleport Players
execute as @e[tag=angel] at @e[tag=angel] unless entity @s[tag=froze] run spreadplayers ~ ~ 0 10000 true @a[tag=!admin,distance=..1]

#Freeze Angel
execute as @a[tag=is_LookingAt_Angel] at @a[tag=is_LookingAt_Angel] run tag @e[tag=angel] add froze
effect give @e[tag=froze] slowness 1 255 true
execute as @a run function angels:in_sight
scoreboard players add @a[limit=1] angel_count 1
execute as @e[scores={angel_count=9..}] run tag @e[tag=froze] remove froze
execute as @e[scores={angel_count=9..}] run scoreboard players set @s angel_count 0

#Remove Wandering Trader Data
execute as @e[tag=angel] at @e[tag=angel] run data modify entity @s HandItems set value [{id: "minecraft:milk_bucket", Count:0b}, {}]
execute as @e[tag=angel] at @e[tag=angel] run data modify entity @s Offers set value {}

#Spawn
tag @e[name="weeping_angel_spawner",type=zombie] add spawn_angel
execute at @e[tag=spawn_angel,scores={angel_spawn=1}] as @e[tag=spawn_angel] run summon wandering_trader ~ ~ ~ {Invulnerable:1,PersistenceRequired:1,Silent:1,ActiveEffects:[{Id:14,Amplifier:255,Duration:999999}],Tags:["angel"]}
execute at @e[tag=spawn_angel,scores={angel_spawn=1}] as @e[tag=spawn_angel] run summon armor_stand ~ ~ ~ {OnGround: 1b, Invulnerable: 1b, Pose: {LeftLeg: [0.0f, 0.0f, 0.0f], LeftArm: [-115.0f, 25.0f, 0.0f], RightLeg: [0.0f, 0.0f, 0.0f], RightArm: [-115.0f, -25.0f, 0.0f], Head: [15.0f, 0.001f, 0.0f], Body: [0.0f, 0.001f, 0.0f]}, Rotation: [90.0f, 0.0f], HurtByTimestamp: 0, ArmorItems: [{id: "minecraft:leather_boots", tag: {Damage: 0, display: {color: 10329495}}, Count: 1b}, {id: "minecraft:leather_leggings", tag: {Damage: 0, display: {color: 10329495}}, Count: 1b}, {id: "minecraft:leather_chestplate", tag: {Damage: 0, display: {color: 10329495}}, Count: 1b}, {id: "minecraft:player_head", tag: {SkullOwner: {Id: [I; 1916213983, 781012114, -1489721028, -2105942343], Properties: {textures: [{Value: "ewogICJ0aW1lc3RhbXAiIDogMTcwMTA0NDM2OTMyOCwKICAicHJvZmlsZUlkIiA6ICI3MjM3MWFkZjJlOGQ0YzkyYTczNGE5M2M4Mjc5ZGViOSIsCiAgInByb2ZpbGVOYW1lIiA6ICJTdG9uZSIsCiAgInNpZ25hdHVyZVJlcXVpcmVkIiA6IHRydWUsCiAgInRleHR1cmVzIiA6IHsKICAgICJTS0lOIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS85NmRhNzM1Yzg4ZTA4YjgwYmRmODE0MGIwYWRkOGQxODY5MGI4NWI0ZjkwMjViYjg4MWQ3YTE5MTM0MGYzYjMxIgogICAgfSwKICAgICJDQVBFIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS8yMzQwYzBlMDNkZDI0YTExYjE1YThiMzNjMmE3ZTllMzJhYmIyMDUxYjI0ODFkMGJhN2RlZmQ2MzVjYTdhOTMzIgogICAgfQogIH0KfQ==", Signature: "x+w2/zL3HMB+01GyxY6SYx+OvSTsGdAjyd2Ekt/5cM2/BGmfJQelhkScouyZEvayE7ntpr+DINqg9tfbiSChhDguhcTgfFJGD5c2j5nZAoSAqSqptft/uW66EZapiqqD1QnPz6mkK1URC9Czpmai2fmcTzyphBc7KJhP16BLajsDAtNRvkv3WxvA6IeKDZ2L3JZad1qxWU1a9gotLjadQY+yY2XfvD8twSMuuk4IA7ec0ADoDBGxxEh+FSd3hNrHT+SsX6kBOGVTVN8MemKHHeewOPbp2p/tQuBJW3QHm22RjEp8BbxyxMknIA3xKo33CExOkZ5xUVA6sXnc4jDswqMnI4FN1a7oavEp133x/K+T0aiDOvXpKsaPa7+Kw8nlt+oiShdsf7+is28WV3EO4eEhmxo9UWeVXdoQF0wUG99GzRPHToZ2nG6hYkKE69y/YKeKjjYMZM4XG2WGbL8LZFR7lVE7a8g2ij/RHBFbw8tGXBBDJBi3TRo5BPe0yf9ak2ynG+FjuB/YbuZgShIxMYP22LuXZOtfJrR0deCjiUuIOGSiEVMHTGHnYpg6qVwI6ZsST6Fc1Ijg10jCvyA45Q/FdSS6AcAth0B+iHQZmyxpgMyP15CR+XD4/vCTWr2EDpZQe2BlscQqd1H1VokV+jwCdjGt9aCgKYIiBGeo0Hc="}, {Value: "ewogICJ0aW1lc3RhbXAiIDogMTcwMTA0NDM2OTMyNywKICAicHJvZmlsZUlkIiA6ICI3MjM3MWFkZjJlOGQ0YzkyYTczNGE5M2M4Mjc5ZGViOSIsCiAgInByb2ZpbGVOYW1lIiA6ICJTdG9uZSIsCiAgInNpZ25hdHVyZVJlcXVpcmVkIiA6IHRydWUsCiAgInRleHR1cmVzIiA6IHsKICAgICJTS0lOIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS85NmRhNzM1Yzg4ZTA4YjgwYmRmODE0MGIwYWRkOGQxODY5MGI4NWI0ZjkwMjViYjg4MWQ3YTE5MTM0MGYzYjMxIgogICAgfSwKICAgICJDQVBFIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS8yMzQwYzBlMDNkZDI0YTExYjE1YThiMzNjMmE3ZTllMzJhYmIyMDUxYjI0ODFkMGJhN2RlZmQ2MzVjYTdhOTMzIgogICAgfQogIH0KfQ==", Signature: "usx9Bv3rjvorN46TWC0J0+RBe1YoUHJ/GA0YE/cYQjgfGFneykTit4Eg+wjB0XFuTpgOFpqcgVF2qoY4C8Cs+DXQqeXN29Xu4xH+BD+fTXInoHLdNDEpJSVaztouQwywwRyZdCbXHCkHBaTK7JIn0rrDTTocIGuoSTqHh/7VdRjajIj4wc8MFJooQZ73VucRzo7wsESVb11JNAoN9Mw00qGx9jWXd8lV1x59UMi4+1kN0YVCckM5UKkn0kcNnG/mUSPvLLR0ZgSPuSlWqYaJhN5L78/lvPeuKZafqGGeKI13DrFuptQKvCvqbs+vcuNoszrLPTsJiNIPeOaDKseSAM35s5vxhjFhT9nmElv6ehSlp74+srBjQLXLAH0y8LrOryEQCWylpnRtA4V+RVqrMlp7s4eLZdpIg7w8z03ZdvRYUuPEDYy6Fm81DpSdaG3Ekzn4lHkfx+Y4elXXUrFV57rpp8gTfHXiEO64sj+HsH6WZOTEcp7+YTiYxj30d3qZ83IunNvlGxdJY4DssRWeSS4Qo04ZSd8dZQJRgldaUoH7FK6lu23TNe0YHLBaoZ6rsZ66eGuzVDVyy0QcNcy4aYk4Ey/UCiqCwMU7yEuPMmAt+zzQwQ4TGQ3UMeUe2ME37hqjpcdJ1N+6gF+6eTPvWpJUJQBcVCTrfy9YPAdi2L4="}]}, Name: "Stone"}}, Count: 1b}], DisabledSlots: 4144959, Tags: ["angel_stand"], Air: 300s, NoBasePlate: 0b, Health: 20.0f, ShowArms: 1b, FallFlying: 0b, Fire: -1s, PortalCooldown: 0, Small: 0b}
scoreboard players add @e[tag=spawn_angel] angel_spawn 1
execute as @e[tag=spawn_angel] run data merge entity @s {DeathLootTable:"minecraft:empty"}
execute as @e[scores={angel_spawn=4..}] run kill @e[tag=spawn_angel]

#Effects
effect give @e[tag=angel] minecraft:speed 100000 5 true
effect give @e[tag=angel] resistance 2 255 true
effect give @e[tag=angel_stand] resistance 2 255 true
effect give @e[tag=angel] invisibility 10 255 true

#Player Follow Check
tag @e[tag=angel,limit=1,scores={angel_follow=0}] add angel_follow
scoreboard players add @e[tag=angel_follow] angel_follow 1
tag @e[scores={angel_follow=2..}] remove angel_follow
execute unless entity @e[tag=angel,scores={angel_follow=..1}] run tag @e remove angel_follow
execute unless entity @e[tag=angel,scores={angel_follow=..1}] run scoreboard players set @e[tag=angel] angel_follow 0