verdiSetActWin -dock widgetDock_<Decl._Tree>
debImport "-f" "filelist.f" "-l" "verdi.log"
debLoadSimResult /data/chenzh/course/digital_design/risc-v/sim/*.fsdb
wvCreateWindow
verdiWindowResize -win $_Verdi_1 "500" "182" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetCursor -win $_nWave2 3243119.266055
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
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
