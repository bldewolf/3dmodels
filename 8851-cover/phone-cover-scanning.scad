
// Module names are of the form poly_<inkscape-path-id>().  As a result,
// you can associate a polygon in this OpenSCAD program with the corresponding
// SVG element in the Inkscape document by looking for the XML element with
// the attribute id="inkscape-path-id".

// fudge value is used to ensure that subtracted solids are a tad taller
// in the z dimension than the polygon being subtracted from.  This helps
// keep the resulting .stl file manifold.
fudge = 0.1;
zsize = 2;
line_fn = 4;
min_line_width = 1.0;
function min_line_mm(w) = max(min_line_width, w) * 96/25.4;


path76583_0_center = [-559.268613,-304.841825];
path76583_0_points = [[-559.267633,-343.770542],[-563.115268,-343.580160],[-566.897743,-343.015841],[-570.589531,-342.088158],[-574.165105,-340.807682],[-577.598938,-339.184988],[-580.865503,-337.230647],[-583.939273,-334.955233],[-586.794721,-332.369318],[-589.380779,-329.514000],[-591.656348,-326.440344],[-593.610852,-323.173877],[-595.233719,-319.740125],[-596.514375,-316.164616],[-597.442244,-312.472875],[-598.006753,-308.690428],[-598.197327,-304.842803],[-598.006933,-300.995043],[-597.442578,-297.212450],[-596.514836,-293.520552],[-595.234281,-289.944880],[-593.611486,-286.510961],[-591.657028,-283.244326],[-589.381478,-280.170504],[-586.795412,-277.315024],[-583.939932,-274.728958],[-580.866110,-272.453408],[-577.599475,-270.498950],[-574.165556,-268.876155],[-570.589884,-267.595600],[-566.897986,-266.667858],[-563.115393,-266.103503],[-559.267633,-265.913109],[-555.420008,-266.103684],[-551.637562,-266.668193],[-547.945821,-267.596063],[-544.370312,-268.876718],[-540.936561,-270.499585],[-537.670095,-272.454090],[-534.596439,-274.729659],[-531.741121,-277.315717],[-529.155207,-280.171165],[-526.879793,-283.244935],[-524.925453,-286.511500],[-523.302758,-289.945332],[-522.022283,-293.520906],[-521.094600,-297.212694],[-520.530281,-300.995168],[-520.339899,-304.842803],[-520.540957,-308.822901],[-521.130912,-312.688026],[-522.090200,-316.418610],[-523.399254,-319.995089],[-525.038509,-323.397896],[-526.988397,-326.607465],[-529.229354,-329.604230],[-531.741812,-332.368625],[-534.506207,-334.881084],[-537.502972,-337.122041],[-540.712541,-339.071930],[-544.115347,-340.711184],[-547.691826,-342.020239],[-551.422410,-342.979528],[-555.287535,-343.569484],[-559.267633,-343.770542],[-559.267633,-343.770542]];
path76583_1_center = [564.731504,-304.841825];
path76583_1_points = [[564.732484,-343.770542],[560.884849,-343.580160],[557.102374,-343.015841],[553.410586,-342.088158],[549.835012,-340.807682],[546.401179,-339.184988],[543.134614,-337.230647],[540.060844,-334.955233],[537.205396,-332.369318],[534.619338,-329.514000],[532.343769,-326.440344],[530.389264,-323.173877],[528.766398,-319.740125],[527.485742,-316.164616],[526.557873,-312.472875],[525.993364,-308.690428],[525.802790,-304.842803],[525.993184,-300.995043],[526.557539,-297.212450],[527.485281,-293.520552],[528.765836,-289.944880],[530.388631,-286.510961],[532.343089,-283.244326],[534.618639,-280.170504],[537.204705,-277.315024],[540.060185,-274.728958],[543.134007,-272.453408],[546.400642,-270.498950],[549.834561,-268.876155],[553.410233,-267.595600],[557.102131,-266.667858],[560.884724,-266.103503],[564.732484,-265.913109],[568.580109,-266.103684],[572.362555,-266.668193],[576.054296,-267.596063],[579.629805,-268.876718],[583.063556,-270.499585],[586.330022,-272.454090],[589.403678,-274.729659],[592.258996,-277.315717],[594.844910,-280.171165],[597.120324,-283.244935],[599.074664,-286.511500],[600.697359,-289.945332],[601.977834,-293.520906],[602.905517,-297.212694],[603.469836,-300.995168],[603.660218,-304.842803],[603.459160,-308.822901],[602.869205,-312.688026],[601.909917,-316.418610],[600.600862,-319.995089],[598.961608,-323.397896],[597.011720,-326.607465],[594.770763,-329.604230],[592.258305,-332.368625],[589.493910,-334.881084],[586.497145,-337.122041],[583.287576,-339.071930],[579.884770,-340.711184],[576.308291,-342.020239],[572.577707,-342.979528],[568.712582,-343.569484],[564.732484,-343.770542],[564.732484,-343.770542]];
path76583_2_center = [-559.268613,231.158233];
path76583_2_points = [[-559.267633,192.229519],[-563.115268,192.419900],[-566.897742,192.984219],[-570.589530,193.911903],[-574.165104,195.192378],[-577.598936,196.815072],[-580.865501,198.769413],[-583.939271,201.044827],[-586.794719,203.630741],[-589.380777,206.486059],[-591.656346,209.559714],[-593.610851,212.826181],[-595.233718,216.259932],[-596.514373,219.835441],[-597.442243,223.527182],[-598.006752,227.309628],[-598.197327,231.157253],[-598.006933,235.005013],[-597.442578,238.787606],[-596.514836,242.479503],[-595.234281,246.055176],[-593.611486,249.489095],[-591.657028,252.755730],[-589.381478,255.829552],[-586.795412,258.685032],[-583.939932,261.271098],[-580.866110,263.546647],[-577.599475,265.501106],[-574.165556,267.123900],[-570.589884,268.404456],[-566.897986,269.332198],[-563.115393,269.896553],[-559.267633,270.086947],[-555.420008,269.896372],[-551.637562,269.331863],[-547.945821,268.403993],[-544.370312,267.123338],[-540.936561,265.500471],[-537.670095,263.545966],[-534.596439,261.270397],[-531.741121,258.684339],[-529.155207,255.828891],[-526.879793,252.755121],[-524.925453,249.488556],[-523.302758,246.054723],[-522.022283,242.479150],[-521.094600,238.787362],[-520.530281,235.004888],[-520.339899,231.157253],[-520.540957,227.177155],[-521.130913,223.312031],[-522.090202,219.581447],[-523.399256,216.004968],[-525.038510,212.602162],[-526.988399,209.392593],[-529.229356,206.395829],[-531.741814,203.631434],[-534.506209,201.118975],[-537.502973,198.878019],[-540.712542,196.928130],[-544.115348,195.288876],[-547.691827,193.979821],[-551.422411,193.020533],[-555.287535,192.430577],[-559.267633,192.229519],[-559.267633,192.229519]];
path76583_3_center = [564.731504,231.158233];
path76583_3_points = [[564.732484,192.229519],[560.884849,192.419900],[557.102375,192.984219],[553.410587,193.911903],[549.835013,195.192378],[546.401181,196.815072],[543.134616,198.769413],[540.060846,201.044827],[537.205398,203.630741],[534.619340,206.486059],[532.343771,209.559714],[530.389266,212.826181],[528.766399,216.259932],[527.485744,219.835441],[526.557874,223.527182],[525.993365,227.309628],[525.802790,231.157253],[525.993184,235.005013],[526.557539,238.787606],[527.485281,242.479503],[528.765836,246.055176],[530.388631,249.489095],[532.343089,252.755730],[534.618639,255.829552],[537.204705,258.685032],[540.060185,261.271098],[543.134007,263.546647],[546.400642,265.501106],[549.834561,267.123900],[553.410233,268.404456],[557.102131,269.332198],[560.884724,269.896553],[564.732484,270.086947],[568.580109,269.896372],[572.362555,269.331863],[576.054296,268.403993],[579.629805,267.123338],[583.063556,265.500471],[586.330022,263.545966],[589.403678,261.270397],[592.258996,258.684339],[594.844910,255.828891],[597.120324,252.755121],[599.074664,249.488556],[600.697359,246.054723],[601.977834,242.479150],[602.905517,238.787362],[603.469836,235.004888],[603.660218,231.157253],[603.459160,227.177155],[602.869204,223.312031],[601.909915,219.581447],[600.600861,216.004968],[598.961607,212.602162],[597.011718,209.392593],[594.770761,206.395829],[592.258303,203.631434],[589.493908,201.118975],[586.497144,198.878019],[583.287575,196.928130],[579.884768,195.288876],[576.308290,193.979821],[572.577706,193.020533],[568.712582,192.430577],[564.732484,192.229519],[564.732484,192.229519]];
module poly_path76583(h, w, s, res=line_fn)
{
  scale([25.4/96, -25.4/96, 1]) union()
  {
    translate (path76583_0_center) linear_extrude(height=h, convexity=10, scale=0.01*s)
      translate (-path76583_0_center) polygon(path76583_0_points);
    translate (path76583_1_center) linear_extrude(height=h, convexity=10, scale=0.01*s)
      translate (-path76583_1_center) polygon(path76583_1_points);
    translate (path76583_2_center) linear_extrude(height=h, convexity=10, scale=0.01*s)
      translate (-path76583_2_center) polygon(path76583_2_points);
    translate (path76583_3_center) linear_extrude(height=h, convexity=10, scale=0.01*s)
      translate (-path76583_3_center) polygon(path76583_3_points);
  }
}

rect8505_0_center = [0.000000,0.000000];
rect8505_0_points = [[-661.144604,-353.553746],[-661.144604,353.553746],[661.144604,353.553746],[661.144604,-353.553746],[-661.144604,-353.553746],[-432.839890,-337.700228],[430.017620,-337.700228],[430.017620,180.872088],[-432.839890,180.872088],[-432.839890,-337.700228],[507.968798,-250.139677],[560.720763,-250.139677],[563.312809,-249.879921],[565.724120,-249.134530],[567.903880,-247.954321],[569.801273,-246.390110],[571.365481,-244.492716],[572.545689,-242.312954],[573.291079,-239.901642],[573.550835,-237.309596],[573.550835,-210.063493],[573.291082,-207.471450],[572.545693,-205.060140],[571.365486,-202.880380],[569.801277,-200.982987],[567.903883,-199.418777],[565.724122,-198.238569],[563.312809,-197.493178],[560.720763,-197.233422],[507.968798,-197.233422],[505.376755,-197.493178],[502.965445,-198.238569],[500.785685,-199.418777],[498.888292,-200.982987],[497.324082,-202.880380],[496.143874,-205.060140],[495.398483,-207.471450],[495.138727,-210.063493],[495.138727,-237.309596],[495.398483,-239.901642],[496.143874,-242.312954],[497.324082,-244.492716],[498.888292,-246.390110],[500.785685,-247.954321],[502.965445,-249.134530],[505.376755,-249.879921],[507.968798,-250.139677],[507.968798,-250.139677],[-559.043023,-248.120137],[-506.289118,-248.120137],[-503.697072,-247.860381],[-501.285759,-247.114990],[-499.105997,-245.934781],[-497.208603,-244.370571],[-495.644393,-242.473178],[-494.464184,-240.293418],[-493.718793,-237.882108],[-493.459036,-235.290065],[-493.459036,-208.042013],[-493.718793,-205.449967],[-494.464184,-203.038654],[-495.644393,-200.858892],[-497.208603,-198.961498],[-499.105997,-197.397288],[-501.285759,-196.217079],[-503.697072,-195.471688],[-506.289118,-195.211931],[-559.043023,-195.211931],[-561.635069,-195.471688],[-564.046382,-196.217079],[-566.226143,-197.397288],[-568.123538,-198.961498],[-569.687748,-200.858892],[-570.867957,-203.038654],[-571.613348,-205.449967],[-571.873105,-208.042013],[-571.873105,-235.290065],[-571.613348,-237.882108],[-570.867957,-240.293418],[-569.687748,-242.473178],[-568.123538,-244.370571],[-566.226143,-245.934781],[-564.046382,-247.114990],[-561.635069,-247.860381],[-559.043023,-248.120137],[-559.043023,-248.120137],[507.968798,-174.139669],[560.720763,-174.139669],[563.312809,-173.879913],[565.724120,-173.134522],[567.903880,-171.954313],[569.801273,-170.390102],[571.365481,-168.492708],[572.545689,-166.312946],[573.291079,-163.901634],[573.550835,-161.309588],[573.550835,-134.063485],[573.291082,-131.471442],[572.545693,-129.060132],[571.365486,-126.880372],[569.801277,-124.982979],[567.903883,-123.418770],[565.724122,-122.238561],[563.312809,-121.493170],[560.720763,-121.233414],[507.968798,-121.233414],[505.376755,-121.493170],[502.965445,-122.238561],[500.785685,-123.418770],[498.888292,-124.982979],[497.324082,-126.880372],[496.143874,-129.060132],[495.398483,-131.471442],[495.138727,-134.063485],[495.138727,-161.309588],[495.398483,-163.901634],[496.143874,-166.312946],[497.324082,-168.492708],[498.888292,-170.390102],[500.785685,-171.954313],[502.965445,-173.134522],[505.376755,-173.879913],[507.968798,-174.139669],[507.968798,-174.139669],[-559.043023,-172.120129],[-506.289118,-172.120129],[-503.697072,-171.860373],[-501.285759,-171.114982],[-499.105997,-169.934773],[-497.208603,-168.370564],[-495.644393,-166.473170],[-494.464184,-164.293410],[-493.718793,-161.882100],[-493.459036,-159.290058],[-493.459036,-132.042005],[-493.718793,-129.449959],[-494.464184,-127.038646],[-495.644393,-124.858884],[-497.208603,-122.961490],[-499.105997,-121.397280],[-501.285759,-120.217071],[-503.697072,-119.471680],[-506.289118,-119.211923],[-559.043023,-119.211923],[-561.635069,-119.471680],[-564.046382,-120.217071],[-566.226143,-121.397280],[-568.123538,-122.961490],[-569.687748,-124.858884],[-570.867957,-127.038646],[-571.613348,-129.449959],[-571.873105,-132.042005],[-571.873105,-159.290058],[-571.613348,-161.882100],[-570.867957,-164.293410],[-569.687748,-166.473170],[-568.123538,-168.370564],[-566.226143,-169.934773],[-564.046382,-171.114982],[-561.635069,-171.860373],[-559.043023,-172.120129],[-559.043023,-172.120129],[507.968798,-96.139661],[560.720763,-96.139661],[563.312809,-95.879905],[565.724120,-95.134514],[567.903880,-93.954305],[569.801273,-92.390094],[571.365481,-90.492700],[572.545689,-88.312938],[573.291079,-85.901626],[573.550835,-83.309580],[573.550835,-56.063477],[573.291082,-53.471434],[572.545693,-51.060124],[571.365486,-48.880364],[569.801277,-46.982971],[567.903883,-45.418761],[565.724122,-44.238553],[563.312809,-43.493162],[560.720763,-43.233405],[507.968798,-43.233405],[505.376755,-43.493162],[502.965445,-44.238553],[500.785685,-45.418761],[498.888292,-46.982971],[497.324082,-48.880364],[496.143874,-51.060124],[495.398483,-53.471434],[495.138727,-56.063477],[495.138727,-83.309580],[495.398483,-85.901626],[496.143874,-88.312938],[497.324082,-90.492700],[498.888292,-92.390094],[500.785685,-93.954305],[502.965445,-95.134514],[505.376755,-95.879905],[507.968798,-96.139661],[507.968798,-96.139661],[-559.043023,-94.120121],[-506.289118,-94.120121],[-503.697072,-93.860364],[-501.285759,-93.114974],[-499.105997,-91.934765],[-497.208603,-90.370555],[-495.644393,-88.473162],[-494.464184,-86.293402],[-493.718793,-83.882092],[-493.459036,-81.290049],[-493.459036,-54.041997],[-493.718793,-51.449951],[-494.464184,-49.038638],[-495.644393,-46.858876],[-497.208603,-44.961482],[-499.105997,-43.397272],[-501.285759,-42.217063],[-503.697072,-41.471672],[-506.289118,-41.211915],[-559.043023,-41.211915],[-561.635069,-41.471672],[-564.046382,-42.217063],[-566.226143,-43.397272],[-568.123538,-44.961482],[-569.687748,-46.858876],[-570.867957,-49.038638],[-571.613348,-51.449951],[-571.873105,-54.041997],[-571.873105,-81.290049],[-571.613348,-83.882092],[-570.867957,-86.293402],[-569.687748,-88.473162],[-568.123538,-90.370555],[-566.226143,-91.934765],[-564.046382,-93.114974],[-561.635069,-93.860364],[-559.043023,-94.120121],[-559.043023,-94.120121],[507.968798,-20.139653],[560.720763,-20.139653],[563.312809,-19.879897],[565.724120,-19.134506],[567.903880,-17.954297],[569.801273,-16.390086],[571.365481,-14.492692],[572.545689,-12.312930],[573.291079,-9.901618],[573.550835,-7.309572],[573.550835,19.936531],[573.291082,22.528574],[572.545693,24.939884],[571.365486,27.119644],[569.801277,29.017037],[567.903883,30.581246],[565.724122,31.761455],[563.312809,32.506846],[560.720763,32.766602],[507.968798,32.766602],[505.376755,32.506846],[502.965445,31.761455],[500.785685,30.581246],[498.888292,29.017037],[497.324082,27.119644],[496.143874,24.939884],[495.398483,22.528574],[495.138727,19.936531],[495.138727,-7.309572],[495.398483,-9.901618],[496.143874,-12.312930],[497.324082,-14.492692],[498.888292,-16.390086],[500.785685,-17.954297],[502.965445,-19.134506],[505.376755,-19.879897],[507.968798,-20.139653],[507.968798,-20.139653],[-559.043023,-18.120113],[-506.289118,-18.120113],[-503.697072,-17.860357],[-501.285759,-17.114966],[-499.105997,-15.934757],[-497.208603,-14.370547],[-495.644393,-12.473154],[-494.464184,-10.293394],[-493.718793,-7.882084],[-493.459036,-5.290042],[-493.459036,21.958011],[-493.718793,24.550057],[-494.464184,26.961370],[-495.644393,29.141132],[-497.208603,31.038526],[-499.105997,32.602736],[-501.285759,33.782945],[-503.697072,34.528336],[-506.289118,34.788093],[-559.043023,34.788093],[-561.635069,34.528336],[-564.046382,33.782945],[-566.226143,32.602736],[-568.123538,31.038526],[-569.687748,29.141132],[-570.867957,26.961370],[-571.613348,24.550057],[-571.873105,21.958011],[-571.873105,-5.290042],[-571.613348,-7.882084],[-570.867957,-10.293394],[-569.687748,-12.473154],[-568.123538,-14.370547],[-566.226143,-15.934757],[-564.046382,-17.114966],[-561.635069,-17.860357],[-559.043023,-18.120113],[-559.043023,-18.120113],[507.968798,55.860355],[560.720763,55.860355],[563.312809,56.120111],[565.724120,56.865502],[567.903880,58.045711],[569.801273,59.609921],[571.365481,61.507316],[572.545689,63.687078],[573.291079,66.098390],[573.550835,68.690436],[573.550835,95.936539],[573.291082,98.528582],[572.545693,100.939892],[571.365486,103.119652],[569.801277,105.017045],[567.903883,106.581254],[565.724122,107.761463],[563.312809,108.506854],[560.720763,108.766610],[507.968798,108.766610],[505.376755,108.506854],[502.965445,107.761463],[500.785685,106.581254],[498.888292,105.017045],[497.324082,103.119652],[496.143874,100.939892],[495.398483,98.528582],[495.138727,95.936539],[495.138727,68.690436],[495.398483,66.098390],[496.143874,63.687078],[497.324082,61.507316],[498.888292,59.609921],[500.785685,58.045711],[502.965445,56.865502],[505.376755,56.120111],[507.968798,55.860355],[507.968798,55.860355],[-559.043023,57.879895],[-506.289118,57.879895],[-503.697072,58.139735],[-501.285759,58.885347],[-499.105997,60.065869],[-497.208603,61.630437],[-495.644393,63.528189],[-494.464184,65.708263],[-493.718793,68.119796],[-493.459036,70.711926],[-493.459036,97.958019],[-493.718793,100.550065],[-494.464184,102.961378],[-495.644393,105.141139],[-497.208603,107.038534],[-499.105997,108.602744],[-501.285759,109.782953],[-503.697072,110.528344],[-506.289118,110.788101],[-559.043023,110.788101],[-561.635069,110.528344],[-564.046382,109.782953],[-566.226143,108.602744],[-568.123538,107.038534],[-569.687748,105.141139],[-570.867957,102.961378],[-571.613348,100.550065],[-571.873105,97.958019],[-571.873105,70.711926],[-571.613348,68.119796],[-570.867957,65.708263],[-569.687748,63.528189],[-568.123538,61.630437],[-566.226143,60.065869],[-564.046382,58.885347],[-561.635069,58.139735],[-559.043023,57.879895],[-559.043023,57.879895],[-364.802773,252.790065],[-292.789094,252.790065],[-289.630018,253.106643],[-286.691216,254.015090],[-284.034621,255.453472],[-281.722165,257.359857],[-279.815780,259.672314],[-278.377398,262.328909],[-277.468952,265.267711],[-277.152374,268.426787],[-277.152374,302.559600],[-277.468952,305.718760],[-278.377398,308.657783],[-279.815780,311.314691],[-281.722165,313.627505],[-284.034621,315.534249],[-286.691216,316.972943],[-289.630018,317.881610],[-292.789094,318.198272],[-364.802773,318.198272],[-367.961849,317.881613],[-370.900651,316.972947],[-373.557246,315.534253],[-375.869703,313.627509],[-377.776088,311.314693],[-379.214470,308.657785],[-380.122916,305.718761],[-380.439495,302.559600],[-380.439495,268.426787],[-380.122916,265.267711],[-379.214470,262.328909],[-377.776088,259.672314],[-375.869703,257.359857],[-373.557246,255.453472],[-370.900651,254.015090],[-367.961849,253.106643],[-364.802773,252.790065],[-364.802773,252.790065],[-144.802751,252.790065],[-72.789073,252.790065],[-69.629996,253.106643],[-66.691195,254.015090],[-64.034599,255.453472],[-61.722143,257.359857],[-59.815757,259.672314],[-58.377375,262.328909],[-57.468929,265.267711],[-57.152351,268.426787],[-57.152351,302.559600],[-57.468929,305.718760],[-58.377375,308.657783],[-59.815757,311.314691],[-61.722143,313.627505],[-64.034599,315.534249],[-66.691195,316.972943],[-69.629996,317.881610],[-72.789073,318.198272],[-144.802751,318.198272],[-147.961827,317.881613],[-150.900629,316.972947],[-153.557224,315.534253],[-155.869680,313.627509],[-157.776065,311.314693],[-159.214447,308.657785],[-160.122893,305.718761],[-160.439471,302.559600],[-160.439471,268.426787],[-160.122893,265.267711],[-159.214447,262.328909],[-157.776065,259.672314],[-155.869680,257.359857],[-153.557224,255.453472],[-150.900629,254.015090],[-147.961827,253.106643],[-144.802751,252.790065],[-144.802751,252.790065],[75.197273,252.790065],[147.210950,252.790065],[150.370026,253.106643],[153.308828,254.015090],[155.965424,255.453472],[158.277880,257.359857],[160.184266,259.672314],[161.622648,262.328909],[162.531094,265.267711],[162.847672,268.426787],[162.847672,302.559600],[162.531094,305.718760],[161.622648,308.657783],[160.184266,311.314691],[158.277880,313.627505],[155.965424,315.534249],[153.308828,316.972943],[150.370026,317.881610],[147.210950,318.198272],[75.197273,318.198272],[72.038197,317.881613],[69.099395,316.972947],[66.442799,315.534253],[64.130343,313.627509],[62.223958,311.314693],[60.785576,308.657785],[59.877129,305.718761],[59.560551,302.559600],[59.560551,268.426787],[59.877129,265.267711],[60.785576,262.328909],[62.223958,259.672314],[64.130343,257.359857],[66.442799,255.453472],[69.099395,254.015090],[72.038197,253.106643],[75.197273,252.790065],[75.197273,252.790065],[295.197296,252.790065],[367.210973,252.790065],[370.370049,253.106643],[373.308851,254.015090],[375.965447,255.453472],[378.277903,257.359857],[380.184289,259.672314],[381.622670,262.328909],[382.531117,265.267711],[382.847695,268.426787],[382.847695,302.559600],[382.531117,305.718760],[381.622670,308.657783],[380.184289,311.314691],[378.277903,313.627505],[375.965447,315.534249],[373.308851,316.972943],[370.370049,317.881610],[367.210973,318.198272],[295.197296,318.198272],[292.038220,317.881613],[289.099418,316.972947],[286.442822,315.534253],[284.130366,313.627509],[282.223980,311.314693],[280.785598,308.657785],[279.877152,305.718761],[279.560574,302.559600],[279.560574,268.426787],[279.877152,265.267711],[280.785598,262.328909],[282.223980,259.672314],[284.130366,257.359857],[286.442822,255.453472],[289.099418,254.015090],[292.038220,253.106643],[295.197296,252.790065],[295.197296,252.790065]];
rect8505_0_paths = [[0,1,2,3,4],
				[5,6,7,8,9],
				[10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47],
				[48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85],
				[86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123],
				[124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161],
				[162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199],
				[200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237],
				[238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275],
				[276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313],
				[314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351],
				[352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389],
				[390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427],
				[428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465],
				[466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503],
				[504,505,506,507,508,509,510,511,512,513,514,515,516,517,518,519,520,521,522,523,524,525,526,527,528,529,530,531,532,533,534,535,536,537,538,539,540,541]];
module poly_rect8505(h, w, s, res=line_fn)
{
  scale([25.4/96, -25.4/96, 1]) union()
  {
    translate (rect8505_0_center) linear_extrude(height=h, convexity=10, scale=0.01*s)
      translate (-rect8505_0_center) polygon(rect8505_0_points, rect8505_0_paths);
  }
}

module NAME(h)
{
  difference()
  {
    union()
    {
      translate ([0,0,0]) poly_path76583(3, min_line_mm(1.87871826), 100.0);
      translate ([0,0,0]) poly_rect8505(2, min_line_mm(1.99936998), 100.0);
    }
    union()
    {
    }
  }
}

NAME(zsize);