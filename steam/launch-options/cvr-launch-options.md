
PROTON_LOG=0 PROTON_LOG_DIR=/tmp %command% -skipsteam --disable-videoplayers --melonloader.hideconsole

--disable-videoplayers
--melonloader.hideconsole
-skipsteam
--enable-libvlc
--force-openxr

XR_API_LAYER_PATH=/home/crispypin/proj/forks/xrBinder/build/XR_APILAYER_NOVENDOR_xr_binder XR_ENABLE_API_LAYERS=XR_APILAYER_NOVENDOR_xr_binder %command% --enable-libvlc --melonloader.hideconsole
