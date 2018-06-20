unit LeapMotion.Headers;

interface

const DLL_NAME = 'LeapC.dll';

type
  int32_t = Int32;
  pint64_t = ^int64_t;
  int64_t = Int64;
  puint32_t = ^uint32_t;
  uint32_t = UInt32;
  puint64_t = ^uint64_t;
  uint64_t = UInt64;
  pfloat = ^float;
  float = Single;

{$SCOPEDENUMS ON}
{$Z4}

  eLeapRS = (
    {**
     * The operation completed successfully.
     *}
    eLeapRS_Success                       = $00000000,

    {**
     * An undetermined error has occurred.
     * This is usually the result of an abnormal operating condition in LeapC,
     * the Leap Motion service, or the host computer itself.
     * @since 3.0.0
     *}
    eLeapRS_UnknownError                  = $E2010000,

    {**
     * An invalid argument was specified.
     * @since 3.0.0
     *}
    eLeapRS_InvalidArgument               = $E2010001,

    {**
     * Insufficient resources existed to complete the request.
     * @since 3.0.0
     *}
    eLeapRS_InsufficientResources         = $E2010002,

    {**
     * The specified buffer was not large enough to complete the request.
     * @since 3.0.0
     *}
    eLeapRS_InsufficientBuffer            = $E2010003,

    {**
     * The requested operation has timed out.
     * @since 3.0.0
     *}
    eLeapRS_Timeout                       = $E2010004,

    {**
     * The operation is invalid because there is no current connection.
     * @since 3.0.0
     *}
    eLeapRS_NotConnected                  = $E2010005,

    {**
     * The operation is invalid because the connection is not complete.
     * @since 3.0.0
     *}
    eLeapRS_HandshakeIncomplete           = $E2010006,

    {**
     * The specified buffer size is too large.
     * @since 3.0.0
     *}
    eLeapRS_BufferSizeOverflow            = $E2010007,

    {**
     * A communications protocol error occurred.
     * @since 3.0.0
     *}
    eLeapRS_ProtocolError                 = $E2010008,

    {**
     * The server incorrectly specified zero as a client ID.
     * @since 3.0.0
     *}
    eLeapRS_InvalidClientID               = $E2010009,

    {**
     * The connection to the service was unexpectedly closed while reading or writing a message.
     * The server may have terminated.
     * @since 3.0.0
     *}
    eLeapRS_UnexpectedClosed              = $E201000A,

    {**
     * The specified request token does not appear to be valid
     *
     * Provided that the token value which identifies the request itself was, at one point, valid, this
     * error condition occurs when the request to which the token refers has already been satisfied or
     * is currently being satisfied.
     * @since 3.0.0
     *}
    eLeapRS_UnknownImageFrameRequest      = $E201000B,

    {**
     * The specified frame ID is not valid or is no longer valid
     *
     * Provided that frame ID was, at one point, valid, this error condition occurs when the identifier
     * refers to a frame that occurred further in the past than is currently recorded in the rolling
     * frame window.
     * @since 3.0.0
     *}
    eLeapRS_UnknownTrackingFrameID        = $E201000C,

    {**
     * The specified timestamp references a future point in time
     *
     * The related routine can only operate on time points having occurred in the past, and the
     * provided timestamp occurs in the future.
     * @since 3.1.2
     *}
    eLeapRS_RoutineIsNotSeer              = $E201000D,

    {**
     * The specified timestamp references a point too far in the past
     *
     * The related routine can only operate on time points occurring within its immediate record of
     * the past.
     * @since 3.1.2
     *}
    eLeapRS_TimestampTooEarly             = $E201000E,

    {**
     * LeapPollConnection is called concurrently.
     * @since 3.1.2
     *}
    eLeapRS_ConcurrentPoll                = $E201000F,

    {**
     * A connection to the Leap Motion service could not be established.
     @since 3.0.0
     *}
    eLeapRS_NotAvailable                  = $E7010002,

    {**
     * The requested operation can only be performed while the device is sending data.
     * @since 3.0.0
     *}
    eLeapRS_NotStreaming                  = $E7010004,

    {**
     * The specified device could not be opened. It is possible that the device identifier
     * is invalid, or that the device has been disconnected since being enumerated.
     * @since 3.0.0
     *}
    eLeapRS_CannotOpenDevice              = $E7010005
  );

  PLEAP_CONNECTION = ^LEAP_CONNECTION;
  LEAP_CONNECTION = Pointer;

  PLEAP_DEVICE = ^LEAP_DEVICE;
  LEAP_DEVICE = Pointer;

  LEAP_CALIBRATION = Pointer;

  PLEAP_DEVICE_REF = ^LEAP_DEVICE_REF;
  LEAP_DEVICE_REF = record
    handle: Pointer;
    id: uint32_t;
  end;

  PLEAP_CONNECTION_CONFIG = ^LEAP_CONNECTION_CONFIG;
  LEAP_CONNECTION_CONFIG = packed record
    size: uint32_t;
    flags: uint32_t;
    server_namespace: PAnsiChar;
  end;

  eLeapAllocatorType = (
    {** Signed 8-bit integer (char) @since 4.0.0 *}
    eLeapAllocatorType_Int8 = 0,
    {** Unsigned 8-bit integer (byte) @since 4.0.0 *}
    eLeapAllocatorType_Uint8 = 1,
    {** Signed 16-bit integer @since 4.0.0 *}
    eLeapAllocatorType_Int16 = 2,
    {** Unsigned 16-bit integer @since 4.0.0 *}
    eLeapAllocatorType_UInt16 = 3,
    {** Signed 32-bit integer @since 4.0.0 *}
    eLeapAllocatorType_Int32 = 4,
    {** Unsigned 32-bit integer @since 4.0.0 *}
    eLeapAllocatorType_UInt32 = 5,
    {** Single-precision 32-bit floating-point @since 4.0.0 *}
    eLeapAllocatorType_Float = 6,
    {** Signed 64-bit integer @since 4.0.0 *}
    eLeapAllocatorType_Int64 = 8,
    {** Unsigned 64-bit integer @since 4.0.0 *}
    eLeapAllocatorType_UInt64 = 9,
    {** Double-precision 64-bit floating-point @since 4.0.0 *}
    eLeapAllocatorType_Double = 10
  );

  PLEAP_ALLOCATOR = ^LEAP_ALLOCATOR;
  LEAP_ALLOCATOR = packed record
    allocate: Function(size: uint32_t; typeHint: eLeapAllocatorType; state: Pointer): Pointer;
    deallocate: Procedure(ptr: Pointer; state: Pointer);
    state: Pointer;
  end;

  function LeapGetNow(): int64_t; stdcall; external DLL_NAME;

  function LeapCreateConnection(const pConfig: PLEAP_CONNECTION_CONFIG; const phConnection: PLEAP_CONNECTION): eLeapRS; stdcall; external DLL_NAME;

  function LeapOpenConnection(hConnection: LEAP_CONNECTION): eLeapRS; stdcall; external DLL_NAME;

type
  eLeapServiceDisposition = (
    eLeapServiceState_LowFpsDetected           = $00000001,
    eLeapServiceState_PoorPerformancePause     = $00000002,
    eLeapServiceState_ALL = eLeapServiceState_LowFpsDetected or eLeapServiceState_PoorPerformancePause
  );

  {**  \ingroup Structs
   * Received from LeapPollConnection() when a connection to the Leap Motion service is established.
   * @since 3.0.0
   *}
  PLEAP_CONNECTION_EVENT = ^LEAP_CONNECTION_EVENT;
  LEAP_CONNECTION_EVENT = packed record
    {** A combination of eLeapServiceDisposition flags. @since 3.1.3 *}
    flags: uint32_t;
  end;

  PLEAP_CONNECTION_LOST_EVENT = ^LEAP_CONNECTION_LOST_EVENT;
  LEAP_CONNECTION_LOST_EVENT = packed record
    flags: uint32_t;
  end;

  eLeapConnectionStatus = (
    {**
     * The connection is not open.
     * Call LeapOpenConnection() to open a connection to the Leap Motion service.
     * @since 3.0.0
     *}
    eLeapConnectionStatus_NotConnected = 0,

    {**
     * The connection is open.
     * @since 3.0.0
     *}
    eLeapConnectionStatus_Connected,

    {**
     * Opening the connection is underway, but not complete.
     * @since 3.0.0
     *}
    eLeapConnectionStatus_HandshakeIncomplete,

    {**
     * The connection could not be opened because the Leap Motion service does not
     * appear to be running.
     * @since 3.0.0
     *}
    eLeapConnectionStatus_NotRunning    = $E7030004
  );

  PLEAP_CONNECTION_INFO = ^LEAP_CONNECTION_INFO;
  LEAP_CONNECTION_INFO = packed record
    size: uint32_t;
    status: eLeapConnectionStatus;
  end;

  Function LeapGetConnectionInfo(hConnection: LEAP_CONNECTION; pInfo: LEAP_CONNECTION_INFO): eLeapRS; stdcall; external DLL_NAME;

type
  eLeapPolicyFlag = (
    {** The policy allowing an application to receive frames in the background. @since 3.0.0 *}
    eLeapPolicyFlag_BackgroundFrames = $00000001,

    {** The policy specifying whether to automatically stream images from the device. @since 4.0.0 *}
    eLeapPolicyFlag_Images           = $00000002,

    {** The policy specifying whether to optimize tracking for head-mounted device. @since 3.0.0 *}
    eLeapPolicyFlag_OptimizeHMD      = $00000004,

    {** The policy allowing an application to pause or resume service tracking. @since 3.0.0 *}
    eLeapPolicyFlag_AllowPauseResume = $00000008,

    {** The policy allowing an application to receive per-frame map points. @since 4.0.0 *}
    eLeapPolicyFlag_MapPoints        = $00000080
  );

  PLEAP_POLICY_EVENT = ^LEAP_POLICY_EVENT;
  LEAP_POLICY_EVENT = packed record
    reserved: uint32_t;
    current_policy: uint32_t;
  end;

  {** \ingroup Functions
   * Sets or clears one or more policy flags.
   *
   * Changing policies is asynchronous. After you call this function, a subsequent
   * call to LeapPollConnection provides a LEAP_POLICY_EVENT containing the current
   * policies, reflecting any changes.
   *
   * To get the current policies without changes, specify zero for both the set
   * and clear parameters. When ready, LeapPollConnection() provides the
   * a LEAP_POLICY_EVENT containing the current settings.
   *
   * The eLeapPolicyFlag enumeration defines the policy flags.
   *
   * @param hConnection The connection handle created by LeapCreateConnection().
   * @param set A bitwise combination of flags to be set. Set to 0 if not setting any flags.
   * @param clear A bitwise combination of flags to be cleared. Set to 0 to if not clearing any flags.
   * @returns The operation result code, a member of the eLeapRS enumeration.
   * @since 3.0.0
   *}
  Function LeapSetPolicyFlags(hConnection: LEAP_CONNECTION; _set: uint64_t; clear: uint64_t): eLeapRS; stdcall; external DLL_NAME;

  {** \ingroup Functions
   * Pauses the service
   *
   * Attempts to pause or unpause the service depending on the argument.
   * This is treated as a 'user pause', as though a user had requested a pause through the
   * Leap Control Panel. The connection must have the AllowPauseResume policy set
   * or it will fail with eLeapRS_InvalidArgument.
   *
   * @param hConnection The connection handle created by LeapCreateConnection().
   * @param pause Set to 'true' to pause, or 'false' to unpause
   * @returns The operation result code, a member of the eLeapRS enumeration.
   * @since 4.0.0
   *}
  Function LeapSetPause(hConnection: LEAP_CONNECTION; pause: Boolean): eLeapRS; stdcall; external DLL_NAME;

  {** \ingroup Fucntions
   * Sets the allocator functions to use for a particular connection.
   *
   * If user-supplied allocator functions are not supplied, the functions that require
   * dynamic memory allocation will not be available.
   *
   * @param hConnection A handle to the connection object, created by LeapCreateConnection().
   * @param allocator A pointer to a structure containing the allocator functions to be called
   * as needed by the library.
   * @since 4.0.0
   *}
  Function LeapSetAllocator(hConnection: LEAP_CONNECTION; const allocator: PLEAP_ALLOCATOR): eLeapRS; stdcall; external DLL_NAME;

type
  eLeapValueType = (
    {** The type is unknown (which is an abnormal condition). @since 3.0.0 *}
    eLeapValueType_Unknown,
    {** A boolean value. @since 3.0.0 *}
    eLeapValueType_Boolean,
    {** An integer value. @since 3.0.0 *}
    eLeapValueType_Int32,
    {** A floating point value. @since 3.0.0 *}
    eLeapValueType_Float,
    {** A string value. @since 3.0.0 *}
    eLeapValueType_String,
    FORCE_DWORD = $7FFFFFFF
  );

  PLEAP_VARIANT = ^LEAP_VARIANT;
  LEAP_VARIANT = packed record
    _type: eLeapValueType;
    case cardinal of
      1: (
        boolValue: Boolean;
      );
      2: (
        iValue: int32_t;
      );
      3: (
        fValue: float;
      );
      4: (
        strValue: PAnsiChar;
      );
  end;

  PLEAP_CONFIG_RESPONSE_EVENT = ^LEAP_CONFIG_RESPONSE_EVENT;
  LEAP_CONFIG_RESPONSE_EVENT = packed record
    requestID: uint32_t;
    value: LEAP_VARIANT;
  end;

  PLEAP_CONFIG_CHANGE_EVENT = ^LEAP_CONFIG_CHANGE_EVENT;
  LEAP_CONFIG_CHANGE_EVENT = packed record
    requestID: uint32_t;
    status: Boolean;
  end;

  Function LeapSaveConfigValue(hConnection: LEAP_CONNECTION; const key: PAnsiChar; const value: PLEAP_VARIANT; pRequestID: puint32_t): eLeapRS; stdcall; external DLL_NAME;

  Function LeapRequestConfigValue(hConnection: LEAP_CONNECTION; const key: PAnsiChar; pRequestID: puint32_t): eLeapRS; stdcall; external DLL_NAME;

  Function LeapGetDeviceList(hConnection: LEAP_CONNECTION; pArray: LEAP_DEVICE_REF; pnArray: puint32_t): eLeapRS; stdcall; external DLL_NAME;

  Function LeapOpenDevice(rDevice: LEAP_DEVICE_REF; phDevice: PLEAP_DEVICE): eLeapRS; stdcall; external DLL_NAME;

type
  eLeapDeviceCaps = (
    {** The device can send color images. @since 3.0.0 *}
    eLeapDeviceCaps_Color      = $00000001
  );

  eLeapDevicePID = (
    {** An unknown device. @since 3.1.3 *}
    eLeapDevicePID_Unknown         = $0000,

    {** The Leap Motion consumer peripheral. @since 3.0.0 *}
    eLeapDevicePID_Peripheral      = $0003,

    {** Internal research product codename "Dragonfly". @since 3.0.0 *}
    eLeapDevicePID_Dragonfly       = $1102,

    {** Internal research product codename "Nightcrawler". @since 3.0.0 *}
    eLeapDevicePID_Nightcrawler    = $1201,

    {** Research product codename "Rigel". @since 4.0.0 *}
    eLeapDevicePID_Rigel           = $1202,

    {** An invalid device type value. @since 3.1.3 *}
    eLeapDevicePID_Invalid = $FFFFFFFF
  );

  PLEAP_DEVICE_INFO = ^LEAP_DEVICE_INFO;
  LEAP_DEVICE_INFO = packed record
    {** Size of this structure. @since 3.0.0 *}
    size: uint32_t;

    {** A combination of eLeapDeviceStatus flags. @since 3.0.0 *}
    status: uint32_t;

    {** A combination of eLeapDeviceCaps flags. @since 3.0.0 *}
    caps: uint32_t;

    {** One of the eLeapDevicePID members. @since 3.0.0 *}
    pid: eLeapDevicePID;

    {**
     * The device baseline, in micrometers.
     *
     * The baseline is defined as the distance between the center axis of each lens in a stereo camera
     * system. For other camera systems, this value is set to zero.
     * @since 3.0.0
     *}
    baseline: uint32_t;

    {** The required length of the serial number char buffer including the null character. @since 3.0.0 *}
    serial_length: uint32_t;

    {** A pointer to the null-terminated device serial number string. @since 3.0.0 *}
    serial: PAnsiChar;

    {** The horizontal field of view of this device in radians. @since 3.0.0 *}
    h_fov: float;

    {** The vertical field of view of this device in radians. @since 3.0.0 *}
    v_fov: float;

    {** The maximum range for this device, in micrometers. @since 3.0.0 *}
    range: uint32_t;
  end;

  Function LeapGetDeviceInfo(hDevice: LEAP_DEVICE; info: PLEAP_DEVICE_INFO): eLeapRS; stdcall; external DLL_NAME;

type
  PLEAP_DEVICE_EVENT = ^LEAP_DEVICE_EVENT;
  LEAP_DEVICE_EVENT = packed record
    {** Reserved for future use. @since 3.0.0 *}
    flags: uint32_t;

    {** The handle reference of to the newly attached device. @since 3.0.0 *}
    device: LEAP_DEVICE_REF;

    {** The status of the connected device. A combination of flags from the eLeapDeviceStatus collection. *}
    status: uint32_t;
  end;

  eLeapDeviceStatus = (
    {** The device is sending out frames. @since 3.0.0*}
    eLeapDeviceStatus_Streaming      = $00000001,

    {** Device streaming has been paused. @since 3.0.0 *}
    eLeapDeviceStatus_Paused         = $00000002,

    {**
     * There are known sources of infrared interference. Device has transitioned to
     * robust mode in order to compensate.  @since 3.1.3
     *}
    eLeapDeviceStatus_Robust         = $00000004,

    {** The device's window is smudged, tracking may be degraded.  @since 3.1.3 *}
    eLeapDeviceStatus_Smudged        = $00000008,

    {** The device has entered low-resource mode. @since 4.0.0 *}
    eLeapDeviceStatus_LowResource    = $00000010,

    {** The device has failed, but the failure reason is not known. @since 3.0.0 *}
    eLeapDeviceStatus_UnknownFailure = $E8010000,

    {** The device has a bad calibration record and cannot send frames. @since 3.0.0 *}
    eLeapDeviceStatus_BadCalibration = $E8010001,

    {** The device reports corrupt firmware or cannot install a required firmware update. @since 3.0.0 *}
    eLeapDeviceStatus_BadFirmware    = $E8010002,

    {** The device USB connection is faulty. @since 3.0.0 *}
    eLeapDeviceStatus_BadTransport   = $E8010003,

    {** The device USB control interfaces failed to initialize. @since 3.0.0 *}
    eLeapDeviceStatus_BadControl     = $E8010004
  );

  PLEAP_DEVICE_FAILURE_EVENT = ^LEAP_DEVICE_FAILURE_EVENT;
  LEAP_DEVICE_FAILURE_EVENT = packed record
    {** The status of this failure event. @since 3.0.0 *}
    status: eLeapDeviceStatus;

    {**
     * A handle to the device generating this failure event, if available, otherwise NULL.
     *
     * You are not responsible for closing this handle.
     * @since 3.0.0
     *}
    hDevice: LEAP_DEVICE;
  end;

  LEAP_FRAME_HEADER = packed record
    {** Reserved, set to zero. @since 3.0.0 *}
    reserved: Pointer;

    {**
     * A unique identifier for this frame
     *
     * All frames carrying this frame ID are part of the same unit of processing. This counter
     * is generally an increasing counter, but may reset to another value if the user stops and
     * restarts streaming.
     *
     * For interpolated frames, this value corresponds to the identifier of the frame upper bound.
     * @since 3.0.0
     *}
    frame_id: int64_t;

    {**
     * The timestamp for this image, in microseconds, referenced against LeapGetNow().
     * @since 3.0.0
     *}
    timestamp: int64_t;
  end;

  eLeapImageType = (
    {** An invalid or unknown type. @since 3.0.0 *}
    eLeapImageType_UNKNOWN = 0,

    {** Default, processed IR images. @since 3.0.0 *}
    eLeapImageType_Default,

    {** Raw images from the device. @since 3.0.0 *}
    eLeapImageType_Raw
  );

  eLeapImageFormat = (
    {** An invalid or unknown format. @since 3.0.0 *}
    eLeapImageFormat_UNKNOWN = 0,

    {** An infrared image. @since 3.0.0 *}
    eLeapImageFormat_IR = $317249,

    {** A Bayer RGBIr image with uncorrected RGB channels. @since 3.0.0 *}
    eLeapImageFormat_RGBIr_Bayer = $49425247
  );

  eLeapPerspectiveType = (
    {** An unknown or invalid type.  @since 3.0.0 *}
    eLeapPerspectiveType_invalid = 0,

    {** A canonically left image. @since 3.0.0 *}
    eLeapPerspectiveType_stereo_left = 1,

    {** A canonically right image. @since 3.0.0 *}
    eLeapPerspectiveType_stereo_right = 2,

    {** Reserved for future use. @since 3.0.0 *}
    eLeapPerspectiveType_mono = 3
  );

  LEAP_IMAGE_PROPERTIES = packed record
    {** The type of this image. @since 3.0.0 *}
    _type: eLeapImageType;

    {** The format of this image. @since 3.0.0 *}
    format: eLeapImageFormat;

    {** The number of bytes per image pixel. @since 3.0.0 *}
    bpp: uint32_t;

    {** The number of horizontal pixels in the image. @since 3.0.0 *}
    width: uint32_t;

    {** The number of rows of pixels in the image. @since 3.0.0 *}
    height: uint32_t;

    {** Reserved for future use. @since 3.0.0 *}
    x_scale: float;
    {** Reserved for future use. @since 3.0.0 *}
    y_scale: float;

    {** Reserved for future use. @since 3.0.0 *}
    x_offset: float;
    {** Reserved for future use. @since 3.0.0 *}
    y_offset: float;
  end;

  Coordonates = packed record
    x: float;
    y: float;
  end;

  PLEAP_DISTORTION_MATRIX = ^LEAP_DISTORTION_MATRIX;
  LEAP_DISTORTION_MATRIX = packed record
    x: Coordonates;
    matrix: array [0..63, 0..63] of Coordonates;
  end;

  LEAP_IMAGE_FRAME_DESCRIPTION = packed record
    {**
     * The ID of the frame corresponding to the desired image. @since 3.0.0
     *}
    frame_id: int64_t;

    {**
     * The type of the desired image. @since 3.0.0
     *}
    _type: eLeapImageType;

    {**
     * Length of your image buffer. The buffer must be large enough to
     * hold the request image.
     *}
    buffer_len: uint64_t;

    {**
     * An allocated buffer large enough to contain the requested image. The buffer
     * must remain valid until the image request completes or fails.
     * @since 3.0.0
     *}
    pBuffer: Pointer;
  end;

  PLEAP_VECTOR = ^LEAP_VECTOR;
  LEAP_VECTOR = packed record
    case Cardinal of
      1: (
        v: array [0..2] of float;
      );
      2: (
        x: float;
        y: float;
        z: float;
      );
  end;

  LEAP_MATRIX_3x3 = packed record
    m: array [0..2] of LEAP_VECTOR;
  end;

  LEAP_QUATERNION = packed record
    case Cardinal of
      1: (
        v: array [0..3 ]of float;
      );
      2: (
        x: float;
        y: float;
        z: float;
        w: float;
      );
  end;

  LEAP_BONE = packed record
    {** The base of the bone, closer to the heart. The bones origin. @since 3.0.0 *}
    prev_joint: LEAP_VECTOR;

    {** The end of the bone, further from the heart. @since 3.0.0 *}
    next_joint: LEAP_VECTOR;

    {** The average width of the flesh around the bone in millimeters. @since 3.0.0 *}
    width: float;

    {** Rotation in world space from the forward direction.
     * Convert the quaternion to a matrix to derive the basis vectors.
     * @since 3.1.2
     *}
    rotation: LEAP_QUATERNION;
  end;

  LEAP_DIGIT_BONES = packed record
    case Cardinal of
      1: (
        bones: array [0..3] of LEAP_BONE;
      );
      2: (
        {**
         * The finger bone wholly inside the hand.
         * For thumbs, this bone is set to have zero length and width, an identity basis matrix,
         * and its joint positions are equal.
         * Note that this is anatomically incorrect; in anatomical terms, the intermediate phalange
         * is absent in a real thumb, rather than the metacarpal bone. In the Leap Motion model,
         * however, we use a "zero" metacarpal bone instead for ease of programming.
         * @since 3.0.0
         *}
        metacarpal: LEAP_BONE;

        {** The phalange extending from the knuckle. @since 3.0.0 *}
        proximal: LEAP_BONE;

        {** The bone between the proximal phalange and the distal phalange. @since 3.0.0 *}
        intermediate: LEAP_BONE;

        {** The distal phalange terminating at the finger tip. @since 3.0.0 *}
        distal: LEAP_BONE;
      );
  end;

  LEAP_DIGIT = packed record
    finger_id: int32_t;
    bones: LEAP_DIGIT_BONES;
    is_extended: uint32_t;
  end;

  LEAP_PALM = packed record
    {**
     * The center position of the palm in millimeters from the Leap Motion origin.
     * @since 3.0.0
     *}
    position: LEAP_VECTOR;

    {**
     * The time-filtered and stabilized position of the palm.
     *
     * Smoothing and stabilization is performed in order to make
     * this value more suitable for interaction with 2D content. The stabilized
     * position lags behind the palm position by a variable amount, depending
     * primarily on the speed of movement.
     * @since 3.0.0
     *}
    stabilized_position: LEAP_VECTOR;

    {**
     * The rate of change of the palm position in millimeters per second.
     * @since 3.0.0
     *}
    velocity: LEAP_VECTOR;

    {**
     * The normal vector to the palm. If your hand is flat, this vector will
     * point downward, or "out" of the front surface of your palm.
     * @since 3.0.0
     *}
    normal: LEAP_VECTOR;

    {**
     * The estimated width of the palm when the hand is in a flat position.
     * @since 3.0.0
     *}
    width: float;

    {**
     * The unit direction vector pointing from the palm position toward the fingers.
     * @since 3.0.0
     *}
    direction: LEAP_VECTOR;

    {**
     * The quaternion representing the palm's orientation
     * corresponding to the basis (normal x direction, -normal, -direction)
     * @since 3.1.3
     *}
    orientation: LEAP_QUATERNION;
  end;

  eLeapHandType = (
    {** A left hand. @since 3.0.0 *}
    eLeapHandType_Left,

    {** A right hand. @since 3.0.0 *}
    eLeapHandType_Right
  );

  Fingers = packed record
    case Cardinal of
      1: (
        {** The thumb. @since 3.0.0 *}
        thumb: LEAP_DIGIT;
        {** The index finger. @since 3.0.0 *}
        index: LEAP_DIGIT;
        {** The middle finger. @since 3.0.0 *}
        middle: LEAP_DIGIT;
        {** The ring finger. @since 3.0.0 *}
        ring: LEAP_DIGIT;
        {** The pinky finger. @since 3.0.0 *}
        pinky: LEAP_DIGIT;
      );
      2: (
        {** The fingers of the hand as an array. @since 3.0.0 *}
        digits: array [0..4] of LEAP_DIGIT;
      )
  end;

  PLEAP_HAND = ^LEAP_HAND;
  LEAP_HAND = packed record
    {**
     * A unique ID for a hand tracked across frames.
     * If tracking of a physical hand is lost, a new ID is assigned when
     * tracking is reacquired.
     * @since 3.0.0
     *}
    id: uint32_t;

    {**
     * Reserved for future use. @since 3.0.0
     *}
    flags: uint32_t;

    {**
     * Identifies the chirality of this hand. @since 3.0.0
     *}
    _type: eLeapHandType;

    {**
     * How confident we are with a given hand pose. Not currently used (always 1.0).
     * @since 3.0.0
     *}
    confidence: float;

    {**
     * The total amount of time this hand has been tracked, in microseconds.
     * @since 3.0.0
     *}
    visible_time: uint64_t;

    {**
     * The distance between index finger and thumb. @since 3.0.0
     *}
    pinch_distance: float;

    {**
     * The average angle of fingers to palm. @since 3.0.0
     *}
    grab_angle: float;

    {**
     * The normalized estimate of the pinch pose.
     * Zero is not pinching; one is fully pinched.
     * @since 3.0.0
     *}
    pinch_strength: float;

    {**
     * The normalized estimate of the grab hand pose.
     * Zero is not grabbing; one is fully grabbing.
     * @since 3.0.0
     *}
    grab_strength: float;

    {**
     * Additional information associated with the palm. @since 3.0.0
     *}
    palm: LEAP_PALM;

    {** The fingers of this hand. @since 3.0.0 *}
    findgers: Fingers;

    {**
     * The arm to which this hand is attached.
     * An arm consists of a single LEAP_BONE struct.
     * @since 3.0.0
     *}
    arm: LEAP_BONE;
  end;

  PLEAP_TRACKING_EVENT = ^LEAP_TRACKING_EVENT;
  LEAP_TRACKING_EVENT = packed record
    {** A universal frame identification header. @since 3.0.0 *}
    info: LEAP_FRAME_HEADER;

    {**
     * An identifier for this tracking frame. This identifier is meant to be monotonically
     * increasing, but values may be skipped if the client application does not poll for messages
     * fast enough. This number also generally increases at the same rate as info.frame_id, but
     * if the server cannot process every image received from the device cameras, the info.frame_id
     * identifier may increase faster.
     * @since 3.0.0
     *}
    tracking_frame_id: int64_t;

    {** The number of hands tracked in this frame, i.e. the number of elements in
     * the pHands array.
     * @since 3.0.0
     *}
    nHands: uint32_t;

    {**
     * A pointer to the array of hands tracked in this frame.
     * @since 3.0.0
     *}
    pHands: PLEAP_HAND;

    {**
     * Current tracking frame rate in hertz.
     *
     * This frame rate is distinct from the image frame rate, which is the rate that images are
     * being read from the device. Depending on host CPU limitations, the tracking frame rate
     * may be substantially less than the device frame rate.
     *
     * This number is generally equal to or less than the device frame rate, but there is one
     * case where this number may be _higher_ than the device frame rate:  When the device rate
     * drops. In this case, the device frame rate will fall sooner than the tracking frame rate.
     *
     * This number is equal to zero if there are not enough frames to estimate frame rate.
     *
     * This number cannot be negative.
     * @since 3.0.0
     *}
    framerate: float;
  end;

  eLeapLogSeverity = (
    {** The message severity is not known or was not specified. @since 3.0.0 *}
    eLeapLogSeverity_Unknown = 0,
    {** A message about a fault that could render the software or device non-functional. @since 3.0.0 *}
    eLeapLogSeverity_Critical,
    {** A message warning about a condition that could degrade device capabilities. @since 3.0.0 *}
    eLeapLogSeverity_Warning,
    {** A system status message. @since 3.0.0 *}
    eLeapLogSeverity_Information
  );

  PLEAP_LOG_EVENT = ^LEAP_LOG_EVENT;
  LEAP_LOG_EVENT = packed record
    {** The type of message. @since 4.0.0 *}
    severity: eLeapLogSeverity;
    {**
     * The timestamp of the message in microseconds.
     * Compare with the current values of LeapGetNow() and the system clock to
     * calculate the absolute time of the message.
     * @since 4.0.0
     *}
    timestamp: int64_t;
    {**
     * A pointer to a null-terminated string containing the current log message.
     * @since 4.0.0
     *}
    _message: PAnsiChar;
  end;

  PLEAP_LOG_EVENTS = ^LEAP_LOG_EVENTS;
  LEAP_LOG_EVENTS = packed record
    {** The number of log events being pointed to by the events field.
     * @since 4.0.0
     *}
    nEvents: uint32_t;

    {** An array of ``nEvent`` LEAP_LOG_EVENT structures.
     * @since 4.0.0
     *}
    events: PLEAP_LOG_EVENT;
  end;

  PLEAP_DEVICE_STATUS_CHANGE_EVENT = ^LEAP_DEVICE_STATUS_CHANGE_EVENT;
  LEAP_DEVICE_STATUS_CHANGE_EVENT = packed record
    {** A reference to the device whose status has changed *}
    device: LEAP_DEVICE_REF;

    {** The last known status of the device. This is a combination of eLeapDeviceStatus flags. @since 3.1.3*}
    last_status: uint32_t;

    {** The current status of the device. This is a combination of eLeapDeviceStatus flags. @since 3.1.3*}
    status: uint32_t;
  end;

  eLeapDroppedFrameType = (
    eLeapDroppedFrameType_PreprocessingQueue,
    eLeapDroppedFrameType_TrackingQueue,
    eLeapDroppedFrameType_Other
  );

  PLEAP_DROPPED_FRAME_EVENT = ^LEAP_DROPPED_FRAME_EVENT;
  LEAP_DROPPED_FRAME_EVENT = packed record
    frame_id: int64_t;
    _type: eLeapDroppedFrameType;
  end;

  {** \ingroup Structs
   * Properties of a sensor image.
   * @since 3.0.0
   *}
  LEAP_IMAGE = packed record
    {** The properties of the received image. *}
    properties: LEAP_IMAGE_PROPERTIES;

    {**
     * A version number for the distortion matrix. When the distortion matrix
     * changes, this number is updated. This number is guaranteed not to repeat
     * for the lifetime of the connection. This version number is also guaranteed
     * to be distinct for each perspective of an image.
     *
     * This value is guaranteed to be nonzero if it is valid.
     *
     * The distortion matrix only changes when the streaming device changes or when the
     * device orientation flips -- inverting the image and the distortion grid.
     * Since building a matrix to undistort an image can be a time-consuming task,
     * you can optimize the process by only rebuilding this matrix (or whatever
     * data type you use to correct image distortion) when the grid actually changes.
     *}
    matrix_version: uint64_t;

    {** Pointers to the camera's distortion matrix. *}
    distortion_matrix: PLEAP_DISTORTION_MATRIX;

    {** A pointer to the image data. *}
    data: Pointer;

    {** Offset, in bytes, from the beginning of the data ptr to the actual beginning of the image data *}
    offset: uint32_t;
  end;

  PLEAP_POINT_MAPPING_CHANGE_EVENT = ^LEAP_POINT_MAPPING_CHANGE_EVENT;
  LEAP_POINT_MAPPING_CHANGE_EVENT = packed record
    {** The ID of the frame corresponding to the source of the currently tracked points. @since 4.0.0 *}
    frame_id: int64_t;
    {** The timestamp of the frame, in microseconds, referenced against LeapGetNow(). @since 4.0.0 *}
    timestamp: int64_t;
    {** The number of points being tracked. @since 4.0.0 *}
    nPoints: uint32_t;
  end;

  PLEAP_POINT_MAPPING = ^LEAP_POINT_MAPPING;
  LEAP_POINT_MAPPING = packed record
    {** The ID of the frame corresponding to the source of the currently tracked points. @since 4.0.0 *}
    frame_id: int64_t;
    {** The timestamp of the frame, in microseconds, referenced against LeapGetNow(). @since 4.0.0 *}
    timestamp: int64_t;
    {** The number of points being tracked. @since 4.0.0 *}
    nPoints: uint32_t;
    {** The 3D points being mapped. @since 4.0.0 *}
    pPoints: PLEAP_VECTOR;
    {** The IDs of the 3D points being mapped. @since 4.0.0 *}
    pIDs: puint32_t;
  end;

  PLEAP_HEAD_POSE_EVENT = ^LEAP_HEAD_POSE_EVENT;
  LEAP_HEAD_POSE_EVENT = packed record
    {**
    * The timestamp for this image, in microseconds, referenced against LeapGetNow().
    * @since 3.2.1
    *}
    timestamp: int64_t;
    {**
    * The position and orientation of the user's head. Positional tracking must be enabled.
    * @since 3.2.1
    *}
    head_position: LEAP_VECTOR;
    head_orientation: LEAP_QUATERNION;
  end;

  {** \ingroup Structs
   * Streaming stereo image pairs from the device.
   *
   * LeapPollConnection() produces this message when an image is available.
   * The struct contains image properties, the distortion grid, and a pointer to
   * the buffer containing the image data -- which was allocated using the allocator
   * function passed to LeapC using the LeapSetAllocator.
   * @since 4.0.0
   *}
  PLEAP_IMAGE_EVENT = ^LEAP_IMAGE_EVENT;
  LEAP_IMAGE_EVENT = packed record
    {** The information header identifying the images tracking frame. *}
    info: LEAP_FRAME_HEADER;

    {** The left and right images. *}
    image: array [0..1] of LEAP_IMAGE;

    {** For internal use only. *}
    calib: LEAP_CALIBRATION;
  end;

  eLeapEventType = (
    {**
     * No event has occurred within the timeout period specified when calling LeapPollConnection().
     * @since 3.0.0
     *}
    eLeapEventType_None = 0,

    {**
     * A connection to the Leap Motion service has been established.
     * @since 3.0.0
     *}
    eLeapEventType_Connection,

    {**
     * The connection to the Leap Motion service has been lost.
     * @since 3.0.0
     *}
    eLeapEventType_ConnectionLost,

    {**
     * A device has been detected or plugged-in.
     * A device event is dispatched after a connection is established for any
     * devices already plugged in. (The system currently only supports one
     * streaming device at a time.)
     * @since 3.0.0
     *}
    eLeapEventType_Device,

    {**
     * A device has failed.
     * Device failure could be caused by hardware failure, USB controller issues, or
     * other system instability. Note that unplugging a device generates an
     * eLeapEventType_DeviceLost event message, not a failure message.
     * @since 3.0.0
     *}
    eLeapEventType_DeviceFailure,

    {**
     * A policy change has occurred.
     * This can be due to setting a policy with LeapSetPolicyFlags() or due to changing
     * or policy-related config settings, including images_mode.
     * (A user can also change these policies using the Leap Motion Control Panel.)
     * @since 3.0.0
     *}
    eLeapEventType_Policy,

    {**
     * A tracking frame. The message contains the tracking data for the frame.
     * @since 3.0.0
     *}
    eLeapEventType_Tracking = $100,

    {**
     * The request for an image has failed.
     * The message contains information about the failure. The client application
     * will not receive the requested image set.
     * @since 3.0.0
     *}
    eLeapEventType_ImageRequestError,

    {**
    * The request for an image is complete.
    * The image data has been completely written to the application-provided
    * buffer.
    * @since 3.0.0
    *}
    eLeapEventType_ImageComplete,

    {**
     * A system message. @since 3.0.0
     *}
    eLeapEventType_LogEvent,

    {**
     * The device connection has been lost.
     *
     * This event is generally asserted when the device has been detached from the system, when the
     * connection to the service has been lost, or if the device is closed while streaming. Generally,
     * any event where the system can conclude no further frames will be received will result in this
     * message. The DeviceEvent field will be filled with the id of the formerly attached device.
     * @since 3.0.0
     *}
    eLeapEventType_DeviceLost,

    {**
     * The asynchronous response to a call to LeapRequestConfigValue().
     * Contains the value of requested configuration item.
     * @since 3.0.0
     *}
    eLeapEventType_ConfigResponse,

    {**
     * The asynchronous response to a call to LeapSaveConfigValue().
     * Reports whether the change succeeded or failed.
     * @since 3.0.0
     *}
    eLeapEventType_ConfigChange,

    {**
     * Notification that a status change has been detected on an attached device
     *
     * @since 3.1.3
     *}
    eLeapEventType_DeviceStatusChange,
    eLeapEventType_DroppedFrame,

    {**
     * Notification that an unrequested stereo image pair is available
     *
     * @since 4.0.0
     *}
    eLeapEventType_Image,

    {**
     * Notification that point mapping has changed
     *
     * @since 4.0.0
     *}
    eLeapEventType_PointMappingChange,

    {**
     * An array of system messages. @since 4.0.0
     *}
    eLeapEventType_LogEvents,
    eLeapEventType_HeadPose
  );

  PLEAP_CONNECTION_MESSAGE = ^LEAP_CONNECTION_MESSAGE;
  LEAP_CONNECTION_MESSAGE = packed record
    {**
     * The size of this message struct. @since 3.0.0
     *}
    size: uint32_t;

    {**
     * The message type. @since 3.0.0
     *}
    _type: eLeapEventType;

    {**
     * A pointer to the event data for the current type of message. @since 3.0.0
     *}
    case Cardinal of
      {** An untyped pointer. @since 3.0.0 *}
      0: (
        _pointer: Pointer;
      );
      {** A connection message. @since 3.0.0 *}
      1: (
        connection_event: PLEAP_CONNECTION_EVENT;
      );
      {** A connection lost. @since 3.0.0 *}
      2: (
        connection_lost_event: PLEAP_CONNECTION_LOST_EVENT;
      );
      {** A device detected message. @since 3.0.0 *}
      3: (
        device_event: PLEAP_DEVICE_EVENT;
      );
      {** A device's status has changed.  @since 3.1.3 *}
      4: (
        device_status_change_event: PLEAP_DEVICE_STATUS_CHANGE_EVENT;
      );
      {** A policy message. @since 3.0.0 *}
      5: (
        policy_event: PLEAP_POLICY_EVENT;
      );
      {** A device failure message. @since 3.0.0 *}
      6: (
        device_failure_event: PLEAP_DEVICE_FAILURE_EVENT;
      );
      {** A tracking message. @since 3.0.0 *}
      7: (
        tracking_event: PLEAP_TRACKING_EVENT;
      );
      {** A log message. @since 3.0.0 *}
      8: (
        log_event: PLEAP_LOG_EVENT;
      );
      {** A log messages. @since 4.0.0 *}
      9: (
        log_events: PLEAP_LOG_EVENTS;
      );
      {** A get config value message. @since 3.0.0 *}
      10: (
        config_response_event: PLEAP_CONFIG_RESPONSE_EVENT;
      );
      {** A set config value message. @since 3.0.0 *}
      11: (
        config_change_event: PLEAP_CONFIG_CHANGE_EVENT;
      );
      12: (
        dropped_frame_event: PLEAP_DROPPED_FRAME_EVENT;
      );
      {** A streaming image message. @since 4.0.0 *}
      13: (
        image_event: PLEAP_IMAGE_EVENT;
      );
      {** A point mapping message. @since 4.0.0 *}
      14: (
        point_mapping_change_event: PLEAP_POINT_MAPPING_CHANGE_EVENT;
      );
      15: (
        head_pose_event: PLEAP_HEAD_POSE_EVENT;
      );
  end;

  function LeapPollConnection(hConnection: LEAP_CONNECTION; timeout: uint32_t; var evt: LEAP_CONNECTION_MESSAGE): eLeapRS; stdcall; external DLL_NAME;
  
  function LeapGetFrameSize(hConnection: LEAP_CONNECTION; timestamp: int64_t; pncbEvent: puint64_t): eLeapRS; stdcall; external DLL_NAME;

  function LeapInterpolateFrame(hConnection: LEAP_CONNECTION; timestamp: int64_t; pEvent: PLEAP_TRACKING_EVENT; ncbEvent: uint64_t): eLeapRS; stdcall; external DLL_NAME;

  function LeapInterpolateFrameFromTime(hConnection: LEAP_CONNECTION; timestamp: int64_t; sourceTimestamp: int64_t;  pEvent: PLEAP_TRACKING_EVENT; ncbEvent: uint64_t): eLeapRS; stdcall; external DLL_NAME;
  
  function LeapInterpolateHeadPose(hConnection: LEAP_CONNECTION; timestamp: int64_t; pEvent: LEAP_HEAD_POSE_EVENT): eLeapRS; stdcall; external DLL_NAME;

  procedure LeapCloseDevice(hDevice: LEAP_DEVICE); stdcall; external DLL_NAME;
  
  procedure LeapCloseConnection(hConnection: LEAP_CONNECTION); stdcall; external DLL_NAME;

  procedure LeapDestroyConnection(hConnection: LEAP_CONNECTION); stdcall; external DLL_NAME;

type
  PLEAP_CLOCK_REBASER = ^LEAP_CLOCK_REBASER;
  LEAP_CLOCK_REBASER = Pointer;

  function LeapCreateClockRebaser(phClockRebaser: PLEAP_CLOCK_REBASER): eLeapRS; stdcall; external DLL_NAME;

  function LeapUpdateRebase(hClockRebaser: LEAP_CLOCK_REBASER; userClock: int64_t; leapClock: int64_t): eLeapRS; stdcall; external DLL_NAME;

  function LeapRebaseClock(hClockRebaser: LEAP_CLOCK_REBASER; userClock: int64_t; pLeapClock: pint64_t): eLeapRS; stdcall; external DLL_NAME;

  procedure LeapDestroyClockRebaser(hClockRebaser: LEAP_CLOCK_REBASER); stdcall; external DLL_NAME;

  function LeapPixelToRectilinear(hConnection: LEAP_CONNECTION; camera: eLeapPerspectiveType; pixel: LEAP_VECTOR): LEAP_VECTOR; stdcall; external DLL_NAME;

  function LeapRectilinearToPixel(hConnection: LEAP_CONNECTION; camera: eLeapPerspectiveType; rectilinear: LEAP_VECTOR): LEAP_VECTOR; stdcall; external DLL_NAME;

  procedure LeapCameraMatrix(hConnection: LEAP_CONNECTION; camera: eLeapPerspectiveType; dest: pfloat); stdcall; external DLL_NAME;

  procedure LeapDistortionCoeffs(hConnection: LEAP_CONNECTION; camera: eLeapPerspectiveType; dest: float); stdcall; external DLL_NAME;

  function LeapDevicePIDToString(pid: eLeapDevicePID): PAnsiChar; stdcall; external DLL_NAME;

  function LeapGetPointMappingSize(hConnection: LEAP_CONNECTION; pSize: puint64_t): eLeapRS; stdcall; external DLL_NAME;

  function LeapGetPointMapping(hConnection: LEAP_CONNECTION; pointMapping: PLEAP_POINT_MAPPING; pSize: uint64_t): eLeapRS; stdcall; external DLL_NAME;

type
  eLeapRecordingFlags = (
    eLeapRecordingFlags_Error = $00000000,
    eLeapRecordingFlags_Reading = $00000001,
    eLeapRecordingFlags_Writing = $00000002,
    eLeapRecordingFlags_Flushing = $00000004,
    eLeapRecordingFlags_Compressed = $00000008
  );

  PLEAP_RECORDING = ^LEAP_RECORDING;
  LEAP_RECORDING = Pointer;
  
  LEAP_RECORDING_PARAMETERS = packed record
    mode: uint32_t;
  end;
  
  PLEAP_RECORDING_STATUS = ^LEAP_RECORDING_STATUS;
  LEAP_RECORDING_STATUS = packed record
    mode: uint32_t;  
  end;

  function LeapRecordingOpen(ppRecording: PLEAP_RECORDING; const filePath: PAnsiChar; params: LEAP_RECORDING_PARAMETERS): eLeapRS; stdcall; external DLL_NAME;

  function LeapRecordingClose(ppRecording: PLEAP_RECORDING): eLeapRS; stdcall; external DLL_NAME;

  function LeapRecordingGetStatus(pRecording: LEAP_RECORDING; pstatus: PLEAP_RECORDING_STATUS): eLeapRS; stdcall; external DLL_NAME;

  function LeapRecordingReadSize(pRecording: LEAP_RECORDING; pncbEvent: puint64_t): eLeapRS; stdcall; external DLL_NAME;

  function LeapRecordingRead(pRecording: LEAP_RECORDING; pEvent: PLEAP_TRACKING_EVENT; ncbEvent: uint64_t): eLeapRS; stdcall; external DLL_NAME;

  function LeapRecordingWrite(pRecording: LEAP_RECORDING; pEvent: PLEAP_TRACKING_EVENT; pnBytesWritten: puint64_t): eLeapRS; stdcall; external DLL_NAME;

type
  PLEAP_TELEMETRY_DATA =^LEAP_TELEMETRY_DATA;
  LEAP_TELEMETRY_DATA = packed record
    thread_id: uint32_t;
    start_time: uint64_t;
    end_time: uint64_t;
    zone_depth: uint32_t;
    file_name: PAnsiChar;
    line_number: uint32_t;
    zone_name: PAnsiChar;
  end;

  function LeapTelemetryProfiling(hConnection: LEAP_CONNECTION; const telemetryData: PLEAP_TELEMETRY_DATA): eLeapRS; stdcall; external DLL_NAME;

{$Z1}
{$SCOPEDENUMS OFF}

implementation

end.
