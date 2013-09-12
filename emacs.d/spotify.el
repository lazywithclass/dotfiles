(defun spotify-linux-command (command-name) "Execute command for Spotify" (interactive)
  (setq command-text (format "%s%s" "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player." command-name))
  (shell-command command-text))

(defun spotify-toggle () "Play/Pause Spotify" (interactive)
  (spotify-linux-command "PlayPause"))

(defun spotify-previous () "Starts the song over in Spotify" (interactive)
  (spotify-linux-command "Previous"))

(defun spotify-next () "Next song in Spotify" (interactive)
  (spotify-linux-command "Next"))
