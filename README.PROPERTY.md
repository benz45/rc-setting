<!-- หน้าจอ	Window	Fullscreen						
fullscreen	FALSE	TRUE		
				
fullScreenWidth	800							
fullScreenHeight	600							
fullScreenDepth	32							
windowScreenWidth	800							
windowScreenHeight	600							
windowScreenDepth	32				

screenHz	75	

screenAdapter	0							
dwsOn	FALSE							

ระยะการมองเห็น	1000m	900m	800m	700m	600m	500m	400m	300m
sightDistance	0	1	2	3	4	5	6	7

ปริมาณรถ	สูงมาก	สูง	กลาง	ต่ำ	ต่ำมาก			
carCountLevel	0	1	2	3	4	

Texture รถ	สูง	ต่ำ						
carTexLevel	0	1			

รายละเอียด Effect	สูง	ปกติ	ต่ำ	ไม่มี				
carEffectLevel	0	1	2	3	

เงาสะท้อนของรถ	คุณภาพดี	ทั่วไป	ต่ำ	ไม่มี				
envmapLevel	0	1	2	3		

ภาพ 3 มิติของตึก	สูง	ต่ำ						
fieldLevel	0	1			

ข้อความปลีกย่อย	ทั่วไป	ต่ำ	ต่ำมาก					
texDetailLevel	0	1	2		

รายละเอียดของแสง	สูง	ปกติ	ต่ำ					
lightTexDetailLevel	0	1	2	

ภาพสะท้องของตึก	เปิด	ปิด						
reflection	TRUE	FALSE		
				
Environment effect	เปิด	ปิด						
sceneGlowOn	TRUE	FALSE	

Booster effect	เปิด	ปิด						
motionBlurOn	TRUE	FALSE		

Antialiasing	ปิด	เปิด	x2	x4	x8			
multiSampleType	0	1	2	3	4	

โพลิกอนของรถ	สูง	ต่ำ						
carLodLevel	0	1		

ดูข้อมูลสัญลักษณ์	เปิด	ปิด						
renderSignboard	TRUE	FALSE	
					
ภาพสะท้อน	เปิด	ปิด						
waterReflection	TRUE	FALSE	

ระเบิด	ปิด	ต่ำ	ปกติ					
bloomLevel	0	1	2	

แสงไฟหน้า	ปิด	เปิด	ข้อมูล					
dynLight2	0	1	2					 -->


final List<BaseOpntionModel<int>> sightDistanceList = [
  BaseOpntionModel(title: '1000m', value: 0),
  BaseOpntionModel(title: '900m', value: 1),
  BaseOpntionModel(title: '800m', value: 2),
  BaseOpntionModel(title: '700m', value: 3),
  BaseOpntionModel(title: '600m', value: 4),
  BaseOpntionModel(title: '500m', value: 5),
  BaseOpntionModel(title: '400m', value: 6),
  BaseOpntionModel(title: '300m', value: 7),
];

final List<BaseOpntionModel<int>> carCountLevelList = [
  BaseOpntionModel(title: 'สูงมาก', value: 0),
  BaseOpntionModel(title: 'สูง', value: 1),
  BaseOpntionModel(title: 'กลาง', value: 2),
  BaseOpntionModel(title: 'ต่ำ', value: 3),
  BaseOpntionModel(title: 'ต่ำมาก', value: 4),
];

final List<BaseOpntionModel<int>> carTexLevelList = [
  BaseOpntionModel(title: 'สูง', value: 0),
  BaseOpntionModel(title: 'ต่ำ', value: 1),
];

final List<BaseOpntionModel<int>> carEffectLevelList = [
  BaseOpntionModel(title: 'สูง', value: 0),
  BaseOpntionModel(title: 'ปกติ', value: 1),
  BaseOpntionModel(title: 'ต่ำ', value: 2),
  BaseOpntionModel(title: 'ไม่มี', value: 3),
];

final List<BaseOpntionModel<int>> envmapLevelList = [
  BaseOpntionModel(title: 'คุณภาพดี', value: 0),
  BaseOpntionModel(title: 'ทั่วไป', value: 1),
  BaseOpntionModel(title: 'ต่ำ', value: 2),
  BaseOpntionModel(title: 'ไม่มี', value: 3),
];

final List<BaseOpntionModel<int>> fieldLevelList = [
  BaseOpntionModel(title: 'สูง', value: 0),
  BaseOpntionModel(title: 'ต่ำ', value: 1),
];

final List<BaseOpntionModel<int>> texDetailLevelList = [
  BaseOpntionModel(title: 'ทั่วไป', value: 0),
  BaseOpntionModel(title: 'ต่ำ', value: 1),
  BaseOpntionModel(title: 'ต่ำมาก', value: 2),
];

final List<BaseOpntionModel<int>> lightTexDetailLevelList = [
  BaseOpntionModel(title: 'สูง', value: 0),
  BaseOpntionModel(title: 'ปกติ', value: 1),
  BaseOpntionModel(title: 'ต่ำ', value: 2),
];

final List<BaseOpntionModel<bool>> reflectionList = [
  BaseOpntionModel(title: 'เปิด', value: true),
  BaseOpntionModel(title: 'ปิด', value: false),
];

final List<BaseOpntionModel<bool>> sceneGlowOnList = [
  BaseOpntionModel(title: 'เปิด', value: true),
  BaseOpntionModel(title: 'ปิด', value: false),
];

final List<BaseOpntionModel<bool>> motionBlurOnList = [
  BaseOpntionModel(title: 'เปิด', value: true),
  BaseOpntionModel(title: 'ปิด', value: false),
];

final List<BaseOpntionModel<int>> multiSampleTypeList = [
  BaseOpntionModel(title: 'ปิด', value: 0),
  BaseOpntionModel(title: 'เปิด', value: 1),
  BaseOpntionModel(title: 'x2', value: 2),
  BaseOpntionModel(title: 'x4', value: 3),
  BaseOpntionModel(title: 'x8', value: 4),
];

final List<BaseOpntionModel<int>> carLodLevelList = [
  BaseOpntionModel(title: 'สูง', value: 0),
  BaseOpntionModel(title: 'ต่ำ', value: 1),
];

final List<BaseOpntionModel<bool>> renderSignboardList = [
  BaseOpntionModel(title: 'เปิด', value: true),
  BaseOpntionModel(title: 'ปิด', value: false),
];

final List<BaseOpntionModel<bool>> waterReflectionList = [
  BaseOpntionModel(title: 'เปิด', value: true),
  BaseOpntionModel(title: 'ปิด', value: false),
];

final List<BaseOpntionModel<int>> bloomLevelList = [
  BaseOpntionModel(title: 'ปิด', value: 0),
  BaseOpntionModel(title: 'ต่ำ', value: 1),
  BaseOpntionModel(title: 'ปกติ', value: 2),
];

final List<BaseOpntionModel<int>> dynLight2List = [
  BaseOpntionModel(title: 'ปิด', value: 0),
  BaseOpntionModel(title: 'เปิด', value: 1),
  BaseOpntionModel(title: 'ข้อมูล', value: 2),
];
