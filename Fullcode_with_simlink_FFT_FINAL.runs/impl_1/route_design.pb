
Q
Command: %s
53*	vivadotcl2 
route_design2default:defaultZ4-113h px? 
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7z0202default:defaultZ17-347h px? 
?
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7z0202default:defaultZ17-349h px? 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
route_design2default:defaultZ4-22h px? 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px? 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px? 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px? 
V

Starting %s Task
103*constraints2
Routing2default:defaultZ18-103h px? 
}
BMultithreading enabled for route_design using a maximum of %s CPUs17*	routeflow2
22default:defaultZ35-254h px? 
p

Phase %s%s
101*constraints2
1 2default:default2#
Build RT Design2default:defaultZ18-101h px? 
B
-Phase 1 Build RT Design | Checksum: d7924a09
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:28 ; elapsed = 00:00:19 . Memory (MB): peak = 1969.926 ; gain = 0.0002default:defaulth px? 
v

Phase %s%s
101*constraints2
2 2default:default2)
Router Initialization2default:defaultZ18-101h px? 
o

Phase %s%s
101*constraints2
2.1 2default:default2 
Create Timer2default:defaultZ18-101h px? 
A
,Phase 2.1 Create Timer | Checksum: d7924a09
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:00:29 ; elapsed = 00:00:19 . Memory (MB): peak = 1996.289 ; gain = 26.3632default:defaulth px? 
{

Phase %s%s
101*constraints2
2.2 2default:default2,
Fix Topology Constraints2default:defaultZ18-101h px? 
M
8Phase 2.2 Fix Topology Constraints | Checksum: d7924a09
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:00:29 ; elapsed = 00:00:20 . Memory (MB): peak = 2007.059 ; gain = 37.1332default:defaulth px? 
t

Phase %s%s
101*constraints2
2.3 2default:default2%
Pre Route Cleanup2default:defaultZ18-101h px? 
F
1Phase 2.3 Pre Route Cleanup | Checksum: d7924a09
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:00:29 ; elapsed = 00:00:20 . Memory (MB): peak = 2007.059 ; gain = 37.1332default:defaulth px? 
p

Phase %s%s
101*constraints2
2.4 2default:default2!
Update Timing2default:defaultZ18-101h px? 
C
.Phase 2.4 Update Timing | Checksum: 1e0e51ab2
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:00:45 ; elapsed = 00:00:30 . Memory (MB): peak = 2054.816 ; gain = 84.8912default:defaulth px? 
?
Intermediate Timing Summary %s164*route2N
:| WNS=-7.478 | TNS=-39815.773| WHS=-0.249 | THS=-403.102|
2default:defaultZ35-416h px? 
I
4Phase 2 Router Initialization | Checksum: 10a6c019b
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:00:54 ; elapsed = 00:00:36 . Memory (MB): peak = 2397.137 ; gain = 427.2112default:defaulth px? 
p

Phase %s%s
101*constraints2
3 2default:default2#
Initial Routing2default:defaultZ18-101h px? 
C
.Phase 3 Initial Routing | Checksum: 1a7f19e88
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:01:24 ; elapsed = 00:00:54 . Memory (MB): peak = 2397.137 ; gain = 427.2112default:defaulth px? 
s

Phase %s%s
101*constraints2
4 2default:default2&
Rip-up And Reroute2default:defaultZ18-101h px? 
u

Phase %s%s
101*constraints2
4.1 2default:default2&
Global Iteration 02default:defaultZ18-101h px? 
?
Intermediate Timing Summary %s164*route2M
9| WNS=-9.338 | TNS=-57436.629| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
H
3Phase 4.1 Global Iteration 0 | Checksum: 2c1a39ba4
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:02:36 ; elapsed = 00:01:40 . Memory (MB): peak = 2397.137 ; gain = 427.2112default:defaulth px? 
u

Phase %s%s
101*constraints2
4.2 2default:default2&
Global Iteration 12default:defaultZ18-101h px? 
?
Intermediate Timing Summary %s164*route2M
9| WNS=-9.285 | TNS=-57513.781| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
G
2Phase 4.2 Global Iteration 1 | Checksum: 8695f1ac
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:02:56 ; elapsed = 00:01:56 . Memory (MB): peak = 2397.137 ; gain = 427.2112default:defaulth px? 
u

Phase %s%s
101*constraints2
4.3 2default:default2&
Global Iteration 22default:defaultZ18-101h px? 
?
Intermediate Timing Summary %s164*route2M
9| WNS=-9.674 | TNS=-57479.398| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
H
3Phase 4.3 Global Iteration 2 | Checksum: 1a3d10ae8
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:03:15 ; elapsed = 00:02:10 . Memory (MB): peak = 2397.137 ; gain = 427.2112default:defaulth px? 
F
1Phase 4 Rip-up And Reroute | Checksum: 1a3d10ae8
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:03:15 ; elapsed = 00:02:10 . Memory (MB): peak = 2397.137 ; gain = 427.2112default:defaulth px? 
|

Phase %s%s
101*constraints2
5 2default:default2/
Delay and Skew Optimization2default:defaultZ18-101h px? 
p

Phase %s%s
101*constraints2
5.1 2default:default2!
Delay CleanUp2default:defaultZ18-101h px? 
r

Phase %s%s
101*constraints2
5.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
E
0Phase 5.1.1 Update Timing | Checksum: 10d5847dd
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:03:18 ; elapsed = 00:02:11 . Memory (MB): peak = 2397.137 ; gain = 427.2112default:defaulth px? 
?
Intermediate Timing Summary %s164*route2M
9| WNS=-9.170 | TNS=-57263.609| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
C
.Phase 5.1 Delay CleanUp | Checksum: 1e56b81be
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:03:18 ; elapsed = 00:02:12 . Memory (MB): peak = 2397.137 ; gain = 427.2112default:defaulth px? 
z

Phase %s%s
101*constraints2
5.2 2default:default2+
Clock Skew Optimization2default:defaultZ18-101h px? 
M
8Phase 5.2 Clock Skew Optimization | Checksum: 1e56b81be
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:03:19 ; elapsed = 00:02:12 . Memory (MB): peak = 2397.137 ; gain = 427.2112default:defaulth px? 
O
:Phase 5 Delay and Skew Optimization | Checksum: 1e56b81be
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:03:19 ; elapsed = 00:02:12 . Memory (MB): peak = 2397.137 ; gain = 427.2112default:defaulth px? 
n

Phase %s%s
101*constraints2
6 2default:default2!
Post Hold Fix2default:defaultZ18-101h px? 
p

Phase %s%s
101*constraints2
6.1 2default:default2!
Hold Fix Iter2default:defaultZ18-101h px? 
r

Phase %s%s
101*constraints2
6.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
E
0Phase 6.1.1 Update Timing | Checksum: 24aaa7149
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:03:21 ; elapsed = 00:02:14 . Memory (MB): peak = 2397.137 ; gain = 427.2112default:defaulth px? 
?
Intermediate Timing Summary %s164*route2M
9| WNS=-9.170 | TNS=-54082.168| WHS=0.016  | THS=0.000  |
2default:defaultZ35-416h px? 
C
.Phase 6.1 Hold Fix Iter | Checksum: 24078d205
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:03:21 ; elapsed = 00:02:14 . Memory (MB): peak = 2397.137 ; gain = 427.2112default:defaulth px? 
A
,Phase 6 Post Hold Fix | Checksum: 24078d205
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:03:22 ; elapsed = 00:02:14 . Memory (MB): peak = 2397.137 ; gain = 427.2112default:defaulth px? 
o

Phase %s%s
101*constraints2
7 2default:default2"
Route finalize2default:defaultZ18-101h px? 
B
-Phase 7 Route finalize | Checksum: 25148267a
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:03:22 ; elapsed = 00:02:14 . Memory (MB): peak = 2397.137 ; gain = 427.2112default:defaulth px? 
v

Phase %s%s
101*constraints2
8 2default:default2)
Verifying routed nets2default:defaultZ18-101h px? 
I
4Phase 8 Verifying routed nets | Checksum: 25148267a
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:03:22 ; elapsed = 00:02:14 . Memory (MB): peak = 2397.137 ; gain = 427.2112default:defaulth px? 
r

Phase %s%s
101*constraints2
9 2default:default2%
Depositing Routes2default:defaultZ18-101h px? 
E
0Phase 9 Depositing Routes | Checksum: 22bc9bcc5
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:03:25 ; elapsed = 00:02:18 . Memory (MB): peak = 2397.137 ; gain = 427.2112default:defaulth px? 
t

Phase %s%s
101*constraints2
10 2default:default2&
Post Router Timing2default:defaultZ18-101h px? 
?
Estimated Timing Summary %s
57*route2M
9| WNS=-9.170 | TNS=-54082.168| WHS=0.016  | THS=0.000  |
2default:defaultZ35-57h px? 
B
!Router estimated timing not met.
128*routeZ35-328h px? 
G
2Phase 10 Post Router Timing | Checksum: 22bc9bcc5
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:03:26 ; elapsed = 00:02:18 . Memory (MB): peak = 2397.137 ; gain = 427.2112default:defaulth px? 
@
Router Completed Successfully
2*	routeflowZ35-16h px? 
?

%s
*constraints2q
]Time (s): cpu = 00:03:26 ; elapsed = 00:02:18 . Memory (MB): peak = 2397.137 ; gain = 427.2112default:defaulth px? 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
852default:default2
172default:default2
02default:default2
02default:defaultZ4-41h px? 
^
%s completed successfully
29*	vivadotcl2 
route_design2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
route_design: 2default:default2
00:03:312default:default2
00:02:212default:default2
2397.1372default:default2
427.2112default:defaultZ17-268h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0122default:default2
2397.1372default:default2
0.0002default:defaultZ17-268h px? 
H
&Writing timing data to binary archive.266*timingZ38-480h px? 
D
Writing placer database...
1603*designutilsZ20-1893h px? 
=
Writing XDEF routing.
211*designutilsZ20-211h px? 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px? 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:092default:default2
00:00:032default:default2
2397.1372default:default2
0.0002default:defaultZ17-268h px? 
?
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2?
xC:/Users/there/Downloads/Fullcode_with_simlink_FFT_FINAL/Fullcode_with_simlink_FFT_FINAL.runs/impl_1/Toplayer_routed.dcp2default:defaultZ17-1381h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2&
write_checkpoint: 2default:default2
00:00:122default:default2
00:00:072default:default2
2397.1372default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2?
mExecuting : report_drc -file Toplayer_drc_routed.rpt -pb Toplayer_drc_routed.pb -rpx Toplayer_drc_routed.rpx
2default:defaulth px? 
?
Command: %s
53*	vivadotcl2t
`report_drc -file Toplayer_drc_routed.rpt -pb Toplayer_drc_routed.pb -rpx Toplayer_drc_routed.rpx2default:defaultZ4-113h px? 
>
IP Catalog is up to date.1232*coregenZ19-1839h px? 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px? 
?
#The results of DRC are in file %s.
168*coretcl2?
|C:/Users/there/Downloads/Fullcode_with_simlink_FFT_FINAL/Fullcode_with_simlink_FFT_FINAL.runs/impl_1/Toplayer_drc_routed.rpt|C:/Users/there/Downloads/Fullcode_with_simlink_FFT_FINAL/Fullcode_with_simlink_FFT_FINAL.runs/impl_1/Toplayer_drc_routed.rpt2default:default8Z2-168h px? 
\
%s completed successfully
29*	vivadotcl2

report_drc2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2 
report_drc: 2default:default2
00:00:132default:default2
00:00:072default:default2
2397.1372default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2?
?Executing : report_methodology -file Toplayer_methodology_drc_routed.rpt -pb Toplayer_methodology_drc_routed.pb -rpx Toplayer_methodology_drc_routed.rpx
2default:defaulth px? 
?
Command: %s
53*	vivadotcl2?
?report_methodology -file Toplayer_methodology_drc_routed.rpt -pb Toplayer_methodology_drc_routed.pb -rpx Toplayer_methodology_drc_routed.rpx2default:defaultZ4-113h px? 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px? 
Y
$Running Methodology with %s threads
74*drc2
22default:defaultZ23-133h px? 
?
2The results of Report Methodology are in file %s.
450*coretcl2?
?C:/Users/there/Downloads/Fullcode_with_simlink_FFT_FINAL/Fullcode_with_simlink_FFT_FINAL.runs/impl_1/Toplayer_methodology_drc_routed.rpt?C:/Users/there/Downloads/Fullcode_with_simlink_FFT_FINAL/Fullcode_with_simlink_FFT_FINAL.runs/impl_1/Toplayer_methodology_drc_routed.rpt2default:default8Z2-1520h px? 
d
%s completed successfully
29*	vivadotcl2&
report_methodology2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2(
report_methodology: 2default:default2
00:00:212default:default2
00:00:132default:default2
2397.1372default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2?
}Executing : report_power -file Toplayer_power_routed.rpt -pb Toplayer_power_summary_routed.pb -rpx Toplayer_power_routed.rpx
2default:defaulth px? 
?
Command: %s
53*	vivadotcl2?
preport_power -file Toplayer_power_routed.rpt -pb Toplayer_power_summary_routed.pb -rpx Toplayer_power_routed.rpx2default:defaultZ4-113h px? 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px? 
K
,Running Vector-less Activity Propagation...
51*powerZ33-51h px? 
P
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1h px? 
?
?Detected over-assertion of set/reset/preset/clear net with high fanouts, power estimation might not be accurate. Please run Tool - Power Constraint Wizard to set proper switching activities for control signals.282*powerZ33-332h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
972default:default2
182default:default2
02default:default2
02default:defaultZ4-41h px? 
^
%s completed successfully
29*	vivadotcl2 
report_power2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
report_power: 2default:default2
00:00:152default:default2
00:00:102default:default2
2397.1372default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2q
]Executing : report_route_status -file Toplayer_route_status.rpt -pb Toplayer_route_status.pb
2default:defaulth px? 
?
%s4*runtcl2?
?Executing : report_timing_summary -max_paths 10 -file Toplayer_timing_summary_routed.rpt -pb Toplayer_timing_summary_routed.pb -rpx Toplayer_timing_summary_routed.rpx -warn_on_violation 
2default:defaulth px? 
r
UpdateTimingParams:%s.
91*timing29
% Speed grade: -1, Delay Type: min_max2default:defaultZ38-91h px? 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
22default:defaultZ38-191h px? 
?
rThe design failed to meet the timing requirements. Please see the %s report for details on the timing violations.
188*timing2"
timing summary2default:defaultZ38-282h px? 
?
%s4*runtcl2e
QExecuting : report_incremental_reuse -file Toplayer_incremental_reuse_routed.rpt
2default:defaulth px? 
g
BIncremental flow is disabled. No incremental reuse Info to report.423*	vivadotclZ4-1062h px? 
?
%s4*runtcl2e
QExecuting : report_clock_utilization -file Toplayer_clock_utilization_routed.rpt
2default:defaulth px? 
?
%s4*runtcl2?
?Executing : report_bus_skew -warn_on_violation -file Toplayer_bus_skew_routed.rpt -pb Toplayer_bus_skew_routed.pb -rpx Toplayer_bus_skew_routed.rpx
2default:defaulth px? 
r
UpdateTimingParams:%s.
91*timing29
% Speed grade: -1, Delay Type: min_max2default:defaultZ38-91h px? 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
22default:defaultZ38-191h px? 


End Record