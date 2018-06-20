unit LeapMotion.Lib;

interface

uses LeapMotion.Headers, LeapMotion.Lib.ConnectionEventThread;

type
  TConnectionEvent = procedure(const event: LEAP_CONNECTION_EVENT) of object;
  TConnectionLostEvent = procedure(const event: LEAP_CONNECTION_LOST_EVENT) of object;
  TDeviceEvent = procedure(const event: LEAP_DEVICE_EVENT) of object;
  TDeviceFailureEvent = procedure(const event: LEAP_DEVICE_FAILURE_EVENT) of object;
  TPolicyEvent = procedure(const event: LEAP_POLICY_EVENT) of object;
  TTrackingEvent = procedure(const event: LEAP_TRACKING_EVENT) of object;
  TLogEvent = procedure(const event: LEAP_LOG_EVENT) of object;
  TConfigResponseEvent = procedure(const event: LEAP_CONFIG_RESPONSE_EVENT) of object;
  TConfigChangeEvent = procedure(const event: LEAP_CONFIG_CHANGE_EVENT) of object;
  TDeviceStatusChangeEvent = procedure(const event: LEAP_DEVICE_STATUS_CHANGE_EVENT) of object;
  TDroppedFrameEvent = procedure(const event: LEAP_DROPPED_FRAME_EVENT) of object;
  TImageEvent = procedure(const event: LEAP_IMAGE_EVENT) of object;
  TPointMappingChangeEvent = procedure(const event: LEAP_POINT_MAPPING_CHANGE_EVENT) of object;
  TLogEvents = procedure(const event: LEAP_LOG_EVENTS) of object;
  THeadPoseEvent = procedure(const event: LEAP_HEAD_POSE_EVENT) of object;

  TLeapMotionLib = class
    private
      var m_connectionHandle: LEAP_CONNECTION;
      var m_connectionThread: TConnectionEventThread;

      var m_connectionEvent: TConnectionEvent;
      var m_connectionLostEvent: TConnectionLostEvent;
      var m_deviceEvent: TDeviceEvent;
      var m_deviceFailureEvent: TDeviceFailureEvent;
      var m_policyEvent: TPolicyEvent;
      var m_trackingEvent: TTrackingEvent;
      var m_logEvent: TLogEvent;
      var m_deviceLostEvent: TDeviceEvent;
      var m_configResponseEvent: TConfigResponseEvent;
      var m_configChangeEvent: TConfigChangeEvent;
      var m_deviceStatusChangeEvent: TDeviceStatusChangeEvent;
      var m_droppedFrameEvent: TDroppedFrameEvent;
      var m_imageEvent: TImageEvent;
      var m_pointMappingChangeEvent: TPointMappingChangeEvent;
      var m_logEvents: TLogEvents;
      var m_headPoseEvent: THeadPoseEvent;

      procedure OnEvent(const msg: LEAP_CONNECTION_MESSAGE);
    public
      constructor Create;
      destructor Destroy; override;

      function SetPause(pause: Boolean): eLeapRS;
      function SetPolicyFlags(flags: uint64_t; clear: uint64_t): eLeapRS;

      property OnConnectionEvent: TConnectionEvent read m_connectionEvent write m_connectionEvent;
      property OnConnectionLostEvent: TConnectionLostEvent read m_connectionLostEvent write m_connectionLostEvent;
      property OnDeviceEvent: TDeviceEvent read m_deviceEvent write m_deviceEvent;
      property OnFailureEvent: TDeviceFailureEvent read m_deviceFailureEvent write m_deviceFailureEvent;
      property OnPolicyEvent: TPolicyEvent read m_policyEvent write m_policyEvent;
      property OnTrackingEvent: TTrackingEvent read m_trackingEvent write m_trackingEvent;
      property OnLogEvent: TLogEvent read m_logEvent write m_logEvent;
      property OnDeviceLost: TDeviceEvent read m_deviceLostEvent write m_deviceLostEvent;
      property OnConfigResponseEvent: TConfigResponseEvent read m_configResponseEvent write m_configResponseEvent;
      property OnConfigChangeEvent: TConfigChangeEvent read m_configChangeEvent write m_configChangeEvent;
      property OnDeviceStatusChangeEvent: TDeviceStatusChangeEvent read m_deviceStatusChangeEvent write m_deviceStatusChangeEvent;
      property OnDroppedFrameEvent: TDroppedFrameEvent read m_droppedFrameEvent write m_droppedFrameEvent;
      property OnImageEvent: TImageEvent read m_imageEvent write m_imageEvent;
      property OnPointMappingChangeEvent: TPointMappingChangeEvent read m_pointMappingChangeEvent write m_pointMappingChangeEvent;
      property OnLogEvents: TLogEvents read m_logEvents write m_logEvents;
      property OnHeadPoseEvent: THeadPoseEvent read m_headPoseEvent write m_headPoseEvent;
  end;

implementation

constructor TLeapMotionLib.Create;
begin
  inherited;
  m_connectionThread := nil;
  m_connectionHandle := nil;

  if (LeapCreateConnection(nil, @m_connectionHandle) = eLeapRS.eLeapRS_Success) and
    (LeapOpenConnection(m_connectionHandle) = eLeapRS.eLeapRS_Success) then
  begin
    m_connectionThread := TConnectionEventThread.Create(m_connectionHandle);
    m_connectionThread.OnEvent := OnEvent;
  end;
end;

destructor TLeapMotionLib.Destroy;
begin
  if not (m_connectionThread = nil) then
  begin
    m_connectionThread.Free;
    LeapCloseConnection(m_connectionHandle);
    LeapDestroyConnection(m_connectionHandle);
  end;
  inherited;
end;

procedure DoNothing;
begin
end;

procedure TLeapMotionLib.OnEvent(const msg: LEAP_CONNECTION_MESSAGE);
begin
  case msg._type of
    eLeapEventType.eLeapEventType_None:
    begin
      DoNothing;
    end;
    eLeapEventType.eLeapEventType_Connection:
    begin
      if Assigned(m_connectionEvent) then
      begin
        m_connectionEvent(msg.connection_event^);
      end;
    end;
    eLeapEventType.eLeapEventType_ConnectionLost:
    begin
      if Assigned(m_connectionLostEvent) then
      begin
        m_connectionLostEvent(msg.connection_lost_event^);
      end;
    end;
    eLeapEventType.eLeapEventType_Device:
    begin
      if Assigned(m_deviceEvent) then
      begin
        m_deviceEvent(msg.device_event^);
      end;
    end;
    eLeapEventType.eLeapEventType_DeviceFailure:
    begin
      if Assigned(m_deviceFailureEvent) then
      begin
        m_deviceFailureEvent(msg.device_failure_event^);
      end;
    end;
    eLeapEventType.eLeapEventType_Policy:
    begin
      if Assigned(m_policyEvent) then
      begin
        m_policyEvent(msg.policy_event^);
      end;
    end;
    eLeapEventType.eLeapEventType_Tracking:
    begin
      if Assigned(m_trackingEvent) then
      begin
        m_trackingEvent(msg.tracking_event^);
      end;
    end;
    eLeapEventType.eLeapEventType_ImageRequestError:
    begin
      DoNothing;
    end;
    eLeapEventType.eLeapEventType_ImageComplete:
    begin
      DoNothing;
    end;
    eLeapEventType.eLeapEventType_LogEvent:
    begin
      if Assigned(m_logEvent) then
      begin
        m_logEvent(msg.log_event^);
      end;
    end;
    eLeapEventType.eLeapEventType_DeviceLost:
    begin
      if Assigned(m_deviceLostEvent) then
      begin
        m_deviceLostEvent(msg.device_event^);
      end;
    end;
    eLeapEventType.eLeapEventType_ConfigResponse:
    begin
      if Assigned(m_configResponseEvent) then
      begin
        m_configResponseEvent(msg.config_response_event^);
      end;
    end;
    eLeapEventType.eLeapEventType_ConfigChange:
    begin
      if Assigned(m_configChangeEvent) then
      begin
        m_configChangeEvent(msg.config_change_event^);
      end;
    end;
    eLeapEventType.eLeapEventType_DeviceStatusChange:
    begin
      if Assigned(m_deviceStatusChangeEvent) then
      begin
        m_deviceStatusChangeEvent(msg.device_status_change_event^);
      end;
    end;
    eLeapEventType.eLeapEventType_DroppedFrame:
    begin
      if Assigned(m_droppedFrameEvent) then
      begin
        m_droppedFrameEvent(msg.dropped_frame_event^);
      end;
    end;
    eLeapEventType.eLeapEventType_Image:
    begin
      if Assigned(m_imageEvent) then
      begin
        m_imageEvent(msg.image_event^);
      end;
    end;
    eLeapEventType.eLeapEventType_PointMappingChange:
    begin
      if Assigned(m_pointMappingChangeEvent) then
      begin
        m_pointMappingChangeEvent(msg.point_mapping_change_event^);
      end;
    end;
    eLeapEventType.eLeapEventType_LogEvents:
    begin
      if Assigned(m_logEvents) then
      begin
        m_logEvents(msg.log_events^);
      end;
    end;
    eLeapEventType.eLeapEventType_HeadPose:
    begin
      if Assigned(m_headPoseEvent) then
      begin
        m_headPoseEvent(msg.head_pose_event^);
      end;
    end;
  end;
end;

function TLeapMotionLib.SetPause(pause: Boolean): eLeapRS;
begin
  Result := LeapSetPause(m_connectionHandle, pause);
end;

function TLeapMotionLib.SetPolicyFlags(flags: UInt64; clear: UInt64): eLeapRS;
begin
  Result := LeapSetPolicyFlags(m_connectionHandle, flags, clear);
end;

end.
