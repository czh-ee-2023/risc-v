verdiSetActWin -dock widgetDock_<Decl._Tree>
debImport "-f" "filelist.f" "-l" "verdi.log"
debLoadSimResult /data/chenzh/course/digital_design/risc-v/sim/*.fsdb
wvCreateWindow
verdiWindowResize -win $_Verdi_1 "500" "182" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
wvSetCursor -win $_nWave2 142675399.882309
verdiSetActWin -win $_nWave2
wvRestoreSignal -win $_nWave2 \
           "/data/chenzh/course/digital_design/risc-v/sim/signal_sID.rc" \
           -overWriteAutoAlias on -appendSignals on
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 494139784.946237 -snap {("uart" 7)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tinyriscv_soc_tb.tinyriscv_soc_top_0.uart_0" -win $_nTrace1
srcHBSelect "tinyriscv_soc_tb.tinyriscv_soc_top_0.uart_0" -win $_nTrace1
srcSetScope "tinyriscv_soc_tb.tinyriscv_soc_top_0.uart_0" -delim "." -win \
           $_nTrace1
srcHBSelect "tinyriscv_soc_tb.tinyriscv_soc_top_0.uart_0" -win $_nTrace1
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
uniFindSearchString -widget MTB_SOURCE_TAB_1 -pattern "bit_cnt" -next
wvSetPosition -win $_nWave2 {("ex" 6)}
wvSetPosition -win $_nWave2 {("ex" 7)}
wvSetPosition -win $_nWave2 {("uart" 2)}
wvSetPosition -win $_nWave2 {("uart" 4)}
wvSetPosition -win $_nWave2 {("uart" 6)}
wvSetPosition -win $_nWave2 {("uart" 7)}
wvSetPosition -win $_nWave2 {("uart" 8)}
wvSetPosition -win $_nWave2 {("tb" 0)}
wvSetPosition -win $_nWave2 {("uart" 11)}
wvAddSignal -win $_nWave2 \
           "/tinyriscv_soc_tb/tinyriscv_soc_top_0/uart_0/bit_cnt\[3:0\]"
wvSetPosition -win $_nWave2 {("uart" 11)}
wvSetPosition -win $_nWave2 {("uart" 12)}
wvScrollDown -win $_nWave2 1
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 374677419.354839 -snap {("uart" 11)}
wvSetCursor -win $_nWave2 367437275.985663 -snap {("uart" 12)}
wvSetCursor -win $_nWave2 369247311.827957 -snap {("uart" 12)}
wvSetCursor -win $_nWave2 374677419.354839 -snap {("uart" 11)}
wvSetCursor -win $_nWave2 359292114.695341 -snap {("uart" 12)}
wvSetCursor -win $_nWave2 374677419.354839 -snap {("uart" 12)}
wvSetCursor -win $_nWave2 372867383.512545 -snap {("uart" 11)}
wvSetCursor -win $_nWave2 362007168.458781 -snap {("uart" 12)}
wvSetCursor -win $_nWave2 372867383.512545 -snap {("uart" 11)}
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 514023297.491039 -snap {("uart" 11)}
wvSetCursor -win $_nWave2 503718637.992832 -snap {("uart" 12)}
wvSetCursor -win $_nWave2 510439068.100358 -snap {("uart" 11)}
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvScrollUp -win $_nWave2 1
wvSetCursor -win $_nWave2 491935483.870968 -snap {("uart" 2)}
wvSetCursor -win $_nWave2 513888888.888889 -snap {("uart" 11)}
wvScrollDown -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tinyriscv_soc_tb.tinyriscv_soc_top_0.u_tinyriscv.u_if_id" -win \
           $_nTrace1
srcHBSelect "tinyriscv_soc_tb.tinyriscv_soc_top_0.u_tinyriscv.u_sid" -win \
           $_nTrace1
srcSetScope "tinyriscv_soc_tb.tinyriscv_soc_top_0.u_tinyriscv.u_sid" -delim "." \
           -win $_nTrace1
srcHBSelect "tinyriscv_soc_tb.tinyriscv_soc_top_0.u_tinyriscv.u_sid" -win \
           $_nTrace1
srcHBSelect "tinyriscv_soc_tb.tinyriscv_soc_top_0.u_tinyriscv.u_sid" -win \
           $_nTrace1
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiSetActWin -win $_nWave2
wvScrollUp -win $_nWave2 9
wvScrollUp -win $_nWave2 3
wvScrollUp -win $_nWave2 10
wvSelectGroup -win $_nWave2 {sid}
srcDeselectAll -win $_nTrace1
srcSelect -signal "cycle_cnt" -line 26 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcSelect -signal "byte_cnt" -line 25 -pos 1 -win $_nTrace1
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvSetCursor -win $_nWave2 222634408.602151 -snap {("uart" 12)}
wvScrollUp -win $_nWave2 1
wvSetCursor -win $_nWave2 279650537.634409 -snap {("uart" 12)}
wvSetCursor -win $_nWave2 224444444.444444 -snap {("uart" 12)}
wvSetCursor -win $_nWave2 278745519.713262 -snap {("uart" 12)}
wvSetCursor -win $_nWave2 216299283.154122 -snap {("uart" 12)}
wvSetCursor -win $_nWave2 283270609.318996 -snap {("uart" 12)}
wvSetCursor -win $_nWave2 210869175.627240 -snap {("uart" 12)}
wvSetCursor -win $_nWave2 221729390.681004 -snap {("uart" 12)}
wvSetCursor -win $_nWave2 210869175.627240 -snap {("uart" 12)}
wvSetCursor -win $_nWave2 220824372.759857 -snap {("uart" 12)}
wvSetCursor -win $_nWave2 276935483.870968 -snap {("uart" 12)}
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
