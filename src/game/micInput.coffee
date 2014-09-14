class MicInput
  constructor: (@conf) ->
    @enabled = false
    window.AudioContext = window.AudioContext || window.webkitAudioContext
    @getUserMedia({audio:true}, @gotStream)

  getUserMedia: (dict, stream) =>
    try
      navigator.getUserMedia =
        navigator.getUserMedia ||
        navigator.webkitGetUserMedia ||
        navigator.mozGetUserMedia
      navigator.getUserMedia(dict, stream, @error)
    catch e
      console.log e
      alert 'Could not get your microphone! Use the space bar instead.'

  gotStream: (stream) =>
    console.log 'Got mic'
    @enabled = true
    @conf()
    @audioContext = new AudioContext()
    @microphone = @audioContext.createMediaStreamSource(stream)
    @analyser = @audioContext.createAnalyser()

    @analyser.smoothingTimeConstant = 0.3
    @analyser.fftSize = 1024
    @microphone.connect(@analyser)

  getSamples: ->
    if @enabled
      bufferLength = @analyser.fftSize
      dataArray = new Uint8Array(bufferLength)
      @analyser.getByteTimeDomainData(dataArray)
      values = 0
      for element in dataArray
        values += element
      average = 128 - (values / bufferLength)


  error: =>
    console.log 'Failed to get mic input'


module.exports = MicInput
