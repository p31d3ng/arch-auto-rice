# Usage

- append the content of `xkb_symbols` to `/usr/share/X11/xkb/symbols/us` (yeah I know, I modified /usr/share)
- Add the following to `/usr/share/X11/xkb/rules/evdev.extras.xml`
```
<variant>
  <configItem>
    <name>pei</name>
    <description>English (PEI)</description>
  </configItem>
</variant>
```

- Add the following to `/usr/share/X11/xkb/rules/base.extras.xml`
```
<variant>
  <configItem>
    <name>pei</name>
    <description>English (PEI)</description>
  </configItem>
</variant>
```

- Add a new input method in `English - English (PEI)`
