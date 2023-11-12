{
  segments = {
    os = {
      foreground = "cyan";
      background = "black";
      style = "powerline";
      type = "os";
      template = "{{ if .WSL }}WSL at {{ end }} {{.Icon}} ";
      properties = {macos = "MacOS";};
    };
    session = {
      background = "#c386f1";
      foreground = "white";
      style = "powerline";
      powerline_symbol = "";
      type = "session";
      properties = {template = "{{ .UserName }}";};
    };
    git = {
      background = "green";
      foreground = "white";
      style = "powerline";
      powerline_symbol = "";
      type = "git";
      properties = {
        fetch_status = true;
        template = ":: {{ .HEAD }}{{ .BranchStatus }}{{ if .Staging.Changed }}  {{ .Staging.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Working.Changed }}  {{ .Working.String }}{{ end }} ";
      };
    };
    aws = {
      type = "aws";
      style = "powerline";
      foreground = "white";
      background = "#FFA400";
      powerline_symbol = "";
      properties = {template = "  {{.Profile}}{{if .Region}}@{{.Region}}{{end}}";};
    };
    node = {
      type = "node";
      foreground = "#6CA35E";
      style = "powerline";
      properties = {template = "|  {{ if .PackageManagerIcon }}{{ .PackageManagerIcon }} {{ end }}{{ .Full }} ";};
    };
    python = {
      type = "python";
      foreground = "#4574B6";
      style = "plain";
      properties = {
        display_mode = "context";
        fetch_virtual_env = true;
        template = "|  {{ .Venv }} ";
      };
    };
    battery = {
      type = "battery";
      style = "powerline";
      invert_powerline = true;
      background_templates = [
        "{{if eq \"Charging\" .State.String}}#40c4ff{{end}}"
        "{{if eq \"Discharging\" .State.String}}#ff5722{{end}}"
        "{{if eq \"Full\" .State.String}}#4caf50{{end}}"
      ];
      properties = {
        charged_icon = " ";
        charging_icon = " ";
        discharging_icon = " ";
        template = "| {{ if not .Error }}{{ .Icon }}{{ .Percentage }}{{ end }}";
      };
    };
    time = {
      type = "time";
      foreground = "lightGreen";
      style = "plain";
      properties = {template = "| {{ .CurrentDate | date .Format }} ";};
    };
    path = {
      background = "#FF479C";
      foreground = "white";
      powerline_symbol = "";
      type = "path";
      style = "powerline";
      properties = {
        folder_separator_icon = "  ";
        home_icon = "~";
        style = "agnoster_full";
        template = "   {{ .Path }} ";
      };
    };
    status = {
      alignment = "left";
      type = "status";
      style = "diamond";
      foreground = "#ffffff";
      background = "#00897b";
      background_templates = ["{{ if .Error }}#e91e63{{ end }}"];
      trailing_diamond = "";
      template = "<#193549></>  ";
      properties = {
        always_enabled = true;
      };
    };
  };
}
