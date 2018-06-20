unit LeapMotion.Lib.ConnectionEventThread;

interface

uses Classes, LeapMotion.Headers;

type

  TEvent = procedure(const msg: LEAP_CONNECTION_MESSAGE) of object;

  TConnectionEventThread = class(TThread)
    private
      procedure Execute; override;
      var m_connection: LEAP_CONNECTION;
      var m_event: TEvent;
    public
      constructor Create(hConnection: LEAP_CONNECTION);
      destructor Destroy; override;
      property OnEvent: TEvent read m_event write m_event;
  end;

implementation

constructor TConnectionEventThread.Create(hConnection: LEAP_CONNECTION);
begin
  inherited Create;
  m_connection := hConnection;
end;

destructor TConnectionEventThread.Destroy;
begin
  inherited;
end;

procedure TConnectionEventThread.Execute;
var
  res: eLeapRS;
  msg: LEAP_CONNECTION_MESSAGE;
  pmsg: PLEAP_CONNECTION_MESSAGE;
const
  timeout = 1000;
begin
  inherited;
  while not Terminated do
  begin
    res := LeapPollConnection(m_connection, timeout, msg);
    pmsg := @msg;
    if not (res = eLeapRS.eLeapRS_Success) then
    begin
      continue;
    end;
    if Assigned(m_event) then
    begin
      Synchronize(procedure
      begin
        m_event(msg);
      end);
    end;
  end;
end;

end.
