using namespace System
using namespace System.Collections.Generic

Set-StrictMode -Version Latest





###############################################################################
#
# ENUMERATIONS
#
###############################################################################
Enum TIStringMode {
    Sixel
    KGP
}






###############################################################################
#
# CLASS DEFINITIONS
#
###############################################################################
Class TIString {
    [String[]]$Variants

    TIString() {
        $this.Variants = @()
    }

    TIString(
        [String[]]$Variants
    ) {
        $this.Variants = $Variants
    }

    [String]GetModeVariant(
        [TIStringMode]$Mode
    ) {
        Return "$($this.Variants[([Int]$Mode)])"
    }
}

Class AnimatedSodaCan : TIString {
    [TIString[]]$Frames
    [TIStringMode]$Mode
    [Int]$CurrentFrameIndex
    [Int]$DrawRow
    [Int]$DrawColumn
    [Int]$FrameTimeMs

    AnimatedSodaCan() {
        $this.Frames = @()
        $this.Mode = [TIStringMode]::Sixel
        $this.CurrentFrameIndex = 0
        $this.DrawRow = 1
        $this.DrawColumn = 1
        $this.FrameTimeMs = 500

        If($(Get-Variable -Name IsMacOS)) {
            $this.Mode = [TIStringMode]::KGP
        }
    }

    AnimatedSodaCan(
        [TIString[]]$Frames,
        [Int]$FrameTimeMs,
        [Int]$DrawRow,
        [Int]$DrawColumn
    ) {
        $this.Frames = $Frames
        $this.Mode = [TIStringMode]::Sixel
        $this.CurrentFrameIndex = 0
        $this.DrawRow = $DrawRow
        $this.DrawColumn = $DrawColumn
        $this.FrameTimeMs = $FrameTimeMs

        If($(Get-Variable -Name IsMacOS)) {
            $this.Mode = [TIStringMode]::KGP
        }
    }

    [Void]Update() {
        $this.CurrentFrameIndex = ($this.CurrentFrameIndex + 1) % $this.Frames.Length
    }

    [String]GetCurrentFrame() {
        Return "$($this.Frames[$this.CurrentFrameIndex].GetModeVariant($this.Mode))"
    }

    [String]GetAmendedFrame() {
        Return "`e[$($this.DrawRow);$($this.DrawColumn)H$($this.GetCurrentFrame())"
    }
}

Class SodaCanLightBlueBubbles : AnimatedSodaCan {
    SodaCanLightBlueBubbles() : base(
        @(),
        (Get-Random -Minimum 50 -Maximum 250),
        5,
        5
    ) {
        $this.Frames = @(
            [TIString]::new(@(
                "`eP0;1q`"1;1;20;40#0;2;0;0;0#1;2;0;0;0#2;2;9;3;19#3;2;52;62;75#4;2;72;80;87#5;2;11;16;32#6;2;23;22;38#7;2;36;33;51#8;2;44;49;66#0!3?#2!10@#0!7?$#0!2?#2A#3!3A#4!6A#3A#2A#0!6?$#0!2?#2C#5!2C#6C#5C#6!6C#2C#0!6?$#0?#2G#5!4G#6!8G#2G#0!5?$#2O#5!4O#6O#5O#6!6O#5O#6O#2O#0!4?$#2_#5!5_#6!6_#5_#6_#5_#2_#0!4?$-#2@#5!3@#3@#6@#5@#6!4@#5@#6@#5!2@#2@#0!4?$#2A#5!2A#3!3A#6!6A#5!3A#2A#0!4?$#2C#5!3C#3C#6C#5C#6!4C#5C#6C#5!2C#2C#0!4?$#2G#5!5G#6!6G#5!3G#2G#0!4?$#2O#5O#3!3O#6O#5O#6!4O#5O#6O#5!2O#2O#0!4?$#2_#3!5_#6!6_#5!3_#2_#0!4?$-#2@#3!4@#4@#3@#6!4@#5@#6@#5!2@#2@#0!4?$#2A#3!5A#4A#6!5A#5!3A#2A#0!4?$#2C#3!4C#4C#3C#6!4C#5C#6C#5!2C#2C#0!4?$#2G#3!5G#6!6G#5!3G#2G#0!4?$#2O#5O#3!3O#6O#5O#6!4O#5O#6O#5!2O#2O#0!4?$#2_#5!5_#6!6_#5!3_#2_#0!4?$-#2@#5!4@#6@#3@#6!4@#5@#6@#5!2@#2@#0!4?$#2A#3A#5!3A#3A#4!2A#6!4A#5!3A#2A#0!4?$#2C#3!2C#5!2C#6C#3C#6!4C#5C#6C#5!2C#2C#0!4?$#2G#3!3G#5!2G#6!6G#5!3G#2G#0!4?$#2O#3!4O#6O#5O#6!4O#5O#6O#5!2O#2O#0!4?$#2_#3!4_#5_#6!6_#5!3_#2_#0!4?$-#2@#3!4@#6@#5@#6!4@#5@#6@#5!2@#2@#0!4?$#2A#3!3A#5!2A#6!6A#5!3A#2A#0!4?$#2C#3!2C#5!2C#6C#5C#6!4C#5C#6C#5!2C#2C#0!4?$#2G#3G#5!4G#6!6G#5!3G#2G#0!4?$#2O#5!4O#6O#5O#6!4O#5O#6O#5!2O#2O#0!4?$#0?#2_#7!5_#8!5_#7!2_#2_#0!5?$-#0!2?#2@#3!3@#4!7@#2@#0!6?$#0!2?#2!12A#0!6?$#0!20?$#0!20?$#0!20?$#0!20?$-#0!20?$#0!20?$#0!20?$#0!20?$-`e\",
                "`e_Ga=T,f=100,m=0;iVBORw0KGgoAAAANSUhEUgAAABQAAAAoCAYAAAD+MdrbAAAACXBIWXMAAA7EAAAOxAGVKw4bAAABYklEQVR4nGNhQAKSnIb/GYgAz7+fZ8QlBzcQZFju9H64hJGePFYN5y49ZJicWfgfl6EoLpzRNRlMywrwMcz48AlMkwpYYK5jVVSCCz4mYJiSoQEDw3kGrK5kQTcM5kJ8hoLkcBnKgksDPsNgFmIDGAZmlOUybJ21EKuhhAzDMBBkGAh4p8WDDUUHhAzDMBAUy1R1IcxQmGsociHMuyBAsQuRDQMBqoUhDICzHRZDyQpDEADlV5ChW6npQpCh6IAiF1IUhrD0BwNUSYew9IfsGrJdiE2jNyWxDPIusgtBhoEixmhKHUNzThN5LkQ2FOwyaqRDmKEgDVTLKVQvbZA1UsWFyBoHV3mIbhhVcwrFYYgt25HtQlBFLXmf4b+rbzCKhLIMA4OIpiqKmDkQv7l+Gyy3e/NarI0msAtBErs3MxDVWGLwN2NItA5iIKqxBGxVMVAK4Abia/ORZSC1wKiBI8FAAFlcJPJonsstAAAAAElFTkSuQmCC`e\"
            )),
            [TIString]::new(@(
                "`eP0;1q`"1;1;20;40#0;2;0;0;0#1;2;0;0;0#2;2;9;3;19#3;2;52;62;75#4;2;72;80;87#5;2;23;22;38#6;2;11;16;32#7;2;36;33;51#8;2;44;49;66#0!3?#2!10@#0!7?$#0!2?#2A#3!3A#4!6A#3A#2A#0!6?$#0!2?#2C#5!10C#2C#0!6?$#0?#2G#6!2G#5!10G#2G#0!5?$#2O#6!2O#5O#3O#4!2O#5!6O#6O#5O#2O#0!4?$#2_#6!2_#3_#4_#3_#4!2_#5!4_#6_#5_#6_#2_#0!4?$-#2@#6!2@#3!2@#4@#3@#4@#5!3@#3@#5@#6!2@#2@#0!4?$#2A#6!2A#3!3A#4!2A#5!2A#4!2A#3A#6!2A#2A#0!4?$#2C#6!3C#3C#4C#3C#5!4C#3C#5C#6!2C#2C#0!4?$#2G#6!5G#5!6G#6!3G#2G#0!4?$#2O#6!4O#5O#6O#5!2O#4!2O#3O#5O#6!2O#2O#0!4?$#2_#6!5_#5!2_#4!4_#3_#6!2_#2_#0!4?$-#2@#6!2@#3@#6@#5@#6@#4!4@#3@#4@#3@#6@#2@#0!4?$#2A#6A#3!3A#6A#5A#4!5A#3!2A#6A#2A#0!4?$#2C#6!2C#3C#6C#5C#6C#4!4C#3C#4C#3C#6C#2C#0!4?$#2G#6!5G#5!2G#4!4G#3G#6!2G#2G#0!4?$#2O#6!4O#5O#6O#5!2O#4!2O#3O#5O#6!2O#2O#0!4?$#2_#6!5_#5!6_#6!3_#2_#0!4?$-#2@#6!4@#5@#6@#5!4@#6@#5@#3@#6@#2@#0!4?$#2A#6!5A#4!3A#5!3A#3!3A#2A#0!4?$#2C#6!4C#4C#3C#4!3C#5C#6C#5C#3C#6C#2C#0!4?$#2G#6!3G#3!2G#4!5G#5G#6!3G#2G#0!4?$#2O#6!2O#3!2O#4O#3O#4!4O#3O#5O#6!2O#2O#0!4?$#2_#6!2_#3!3_#4!6_#6!3_#2_#0!4?$-#2@#6!2@#3!2@#4@#3@#4!4@#3@#5@#6!2@#2@#0!4?$#2A#6!3A#3!2A#4!5A#5A#6!3A#2A#0!4?$#2C#6!4C#4C#3C#4!3C#5C#6C#5C#6!2C#2C#0!4?$#2G#6!5G#4!3G#5!3G#6!3G#2G#0!4?$#2O#6!4O#5O#6O#5!4O#6O#5O#6!2O#2O#0!4?$#0?#2_#7!5_#8!5_#7!2_#2_#0!5?$-#0!2?#2@#3!3@#4!7@#2@#0!6?$#0!2?#2!12A#0!6?$#0!20?$#0!20?$#0!20?$#0!20?$-#0!20?$#0!20?$#0!20?$#0!20?$-`e\",
                "`e_Ga=T,f=100,m=0;iVBORw0KGgoAAAANSUhEUgAAABQAAAAoCAYAAAD+MdrbAAAACXBIWXMAAA7EAAAOxAGVKw4bAAABzUlEQVR4nO2WMUsDQRCFR4iFjVjYBBQxYmEjxkILa6sggraC2AQFUwhip4V2IlhEMKQTbK2CVf6DAZsUFiIWNhZiYxnzDt45t9nd7B3BRh+EC7ebb9/OzE42J0r5kWJHAvT21RpyjcVAwCrXl/HA4vyU9QcPjy9S3TvouKAJh/f1m5/vkk05uhueLsjrx6dMjo32/VGhuCDSEqvLHGEQYKXydrzds/1TKxALu6CJLROGOOF5fHXSA+Uu8HRuWYswPs0FEWcXzArUUC24jdSF1s6rYUBM3D2qxA511rF1OvSpxyFXt2W733atQMJ0CXG7dJ06hjYYFMU1TQwRP0ymw/rtRWIyk8V5XiAmmVBTTJZPMZAZ1g5N6RrtCyQUYgxRKmYMAQuOIaWzrKFmbQYDza6jz/NA6tBcqOQpHadDXTJ0SBiEBHY7dxgQMN0g2MawEGKYyiFWdnUbQlOdFOhX+iEXqmXJsssh3vnafw+Qx8/lMFM/BNTMMsSEpHJIlbcOnXWY+aQA6jopXof4o84/S2d1bTMxMDMhMj43m3i33P28t5+isWbjznppihxioNmQoMuSrC/JzsqGBF2WbGczrWKg786XCTgo/QP/AvAbsdQ8WZ6dM2QAAAAASUVORK5CYII=`e\"
            )),
            [TIString]::new(@(
                "`eP0;1q`"1;1;20;40#0;2;0;0;0#1;2;0;0;0#2;2;9;3;19#3;2;52;62;75#4;2;72;80;87#5;2;23;22;38#6;2;11;16;32#7;2;36;33;51#8;2;44;49;66#0!3?#2!10@#0!7?$#0!2?#2A#3!3A#4!6A#3A#2A#0!6?$#0!2?#2C#5!10C#2C#0!6?$#0?#2G#6!2G#5!10G#2G#0!5?$#2O#6!2O#5O#6O#5!6O#4!2O#3O#5O#2O#0!4?$#2_#6!3_#5_#6_#5!4_#4!2_#3_#4_#3_#2_#0!4?$-#2@#6!4@#5@#6@#5!3@#4@#3@#4@#3!2@#2@#0!4?$#2A#6!5A#5!4A#4!2A#3!3A#2A#0!4?$#2C#6!4C#5C#6C#5!4C#3C#4C#3C#6C#2C#0!4?$#2G#6!5G#5!6G#6!3G#2G#0!4?$#2O#6!4O#5O#6O#5!4O#6O#5O#6!2O#2O#0!4?$#2_#6!5_#5!6_#6!3_#2_#0!4?$-#2@#6!4@#5@#6@#5!3@#4@#6@#5@#6@#3@#2@#0!4?$#2A#6!5A#5!3A#4!3A#6!2A#3A#2A#0!4?$#2C#6!4C#5C#6C#5!3C#4C#6C#5C#6C#3C#2C#0!4?$#2G#6!5G#5!6G#6!3G#2G#0!4?$#2O#6!4O#5O#6O#5!4O#6O#5O#6!2O#2O#0!4?$#2_#6!5_#5!6_#6!3_#2_#0!4?$-#2@#6!4@#5@#6@#5!4@#6@#5@#6!2@#2@#0!4?$#2A#6!5A#5!6A#6A#3!2A#2A#0!4?$#2C#6!4C#5C#6C#5!4C#6C#4C#3!2C#2C#0!4?$#2G#6!5G#5!5G#4G#3!3G#2G#0!4?$#2O#6!4O#5O#6O#5!3O#4O#3O#4O#3!2O#2O#0!4?$#2_#6!5_#5!4_#4!2_#3!3_#2_#0!4?$-#2@#6!4@#5@#6@#5!3@#4@#3@#4@#3!2@#2@#0!4?$#2A#6!5A#5!5A#4A#3!3A#2A#0!4?$#2C#6!4C#5C#6C#5!4C#6C#4C#3!2C#2C#0!4?$#2G#6!5G#5!6G#6G#3!2G#2G#0!4?$#2O#6!4O#5O#6O#5!4O#6O#5O#6!2O#2O#0!4?$#0?#2_#7!5_#8!5_#7!2_#2_#0!5?$-#0!2?#2@#3!3@#4!7@#2@#0!6?$#0!2?#2!12A#0!6?$#0!20?$#0!20?$#0!20?$#0!20?$-#0!20?$#0!20?$#0!20?$#0!20?$-`e\",
                "`e_Ga=T,f=100,m=0;iVBORw0KGgoAAAANSUhEUgAAABQAAAAoCAYAAAD+MdrbAAAACXBIWXMAAA7EAAAOxAGVKw4bAAABcElEQVR4nGNhQAKSnIb/GYgAz7+fZ8QlBzcQZFju9H64hJGePFYN5y49ZJicWfgfl6EoLtw6ayGCzUAeYIG5jlVRieHxh08MsgJ8BDUpGRowMJxnwOpKFphhIAAyDJ+htVPqwDTI21tnMWA1FMXLMMOwGYpsGDh80+KBYXkBu5eJNRRmGIjGBViwCeLyNiHDcBqIzYXNOU0M3kBvwgyd0TWZcheCktUMoBxVXIhs0WM8hpLkQkKGkeRCULJJiymBy2WU5YKyIHkuhKXBWUt6wIZS7EJQDKO7kCQDsYUhyFBkw0hKNkMzlmnqQlCSAQGikw0+F4KSDtVKG0KGkeRCUDoc3OUhCFDVhbDsR1UXgvIyVWMZJAYyFJYOKXYhTAxXwQA2EFRRS95n+O/qG4wioSzDwCCiqYoiZg7Eb67fBsvt3rwWa6MJ7EKQxO7NDEQ1lhj8zRgSrYMYiGosYcubpAK4gfjafGQZSC0wauBIMBAAdN0YpiCD49gAAAAASUVORK5CYII=`e\"
            )),
            [TIString]::new(@(
                "`eP0;1q`"1;1;20;40#0;2;0;0;0#1;2;0;0;0#2;2;9;3;19#3;2;52;62;75#4;2;72;80;87#5;2;23;22;38#6;2;11;16;32#7;2;36;33;51#8;2;44;49;66#0!3?#2!10@#0!7?$#0!2?#2A#3!3A#4!6A#3A#2A#0!6?$#0!2?#2C#5!10C#2C#0!6?$#0?#2G#6!2G#5!10G#2G#0!5?$#2O#6!2O#5O#6O#5!8O#6O#5O#2O#0!4?$#2_#6!3_#5_#6_#5!6_#6_#5_#6_#2_#0!4?$-#2@#6!4@#5@#6@#5!4@#6@#5@#6!2@#2@#0!4?$#2A#6!5A#5!6A#6!3A#2A#0!4?$#2C#6!4C#5C#6C#5!4C#6C#5C#6!2C#2C#0!4?$#2G#6!5G#5!6G#6!3G#2G#0!4?$#2O#6!4O#5O#6O#5!4O#6O#5O#6!2O#2O#0!4?$#2_#6!5_#5!6_#6!3_#2_#0!4?$-#2@#6!4@#5@#6@#5!4@#6@#5@#6!2@#2@#0!4?$#2A#6!5A#5!6A#6!3A#2A#0!4?$#2C#6!4C#5C#6C#5!4C#6C#5C#6!2C#2C#0!4?$#2G#6!5G#5!6G#6!3G#2G#0!4?$#2O#6!4O#5O#6O#5!4O#6O#5O#6!2O#2O#0!4?$#2_#6!5_#5!6_#6!3_#2_#0!4?$-#2@#6!4@#5@#6@#5!4@#6@#5@#6!2@#2@#0!4?$#2A#6!5A#5!6A#6!3A#2A#0!4?$#2C#6!4C#5C#6C#5!4C#6C#5C#6!2C#2C#0!4?$#2G#6!5G#5!6G#6!3G#2G#0!4?$#2O#6!4O#5O#6O#5!4O#6O#5O#6!2O#2O#0!4?$#2_#6!5_#5!6_#6!3_#2_#0!4?$-#2@#6!4@#5@#6@#5!4@#6@#5@#6!2@#2@#0!4?$#2A#6!5A#5!6A#6!3A#2A#0!4?$#2C#6!4C#5C#6C#5!4C#6C#5C#6!2C#2C#0!4?$#2G#6!5G#5!6G#6!3G#2G#0!4?$#2O#6!4O#5O#6O#5!4O#6O#5O#6!2O#2O#0!4?$#0?#2_#7!5_#8!5_#7!2_#2_#0!5?$-#0!2?#2@#3!3@#4!7@#2@#0!6?$#0!2?#2!12A#0!6?$#0!20?$#0!20?$#0!20?$#0!20?$-#0!20?$#0!20?$#0!20?$#0!20?$-`e\",
                "`e_Ga=T,f=100,m=0;iVBORw0KGgoAAAANSUhEUgAAABQAAAAoCAYAAAD+MdrbAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAA30lEQVR4nGNhQAKSnIb/GYgAz7+fZ8QlBzcQZFju9H64hJGePFYN5y49ZJicWfgfl6EoLtw6ayGCzUAeYIG5jlVRieHxh08MsgJ8BDUpGRowMJxnwOpKFphhIAAyjBhDQWpwGcqCrpCQochqsAEWdAF8hhIyDKuByBrRASHDcBo46sJRF466cNSFoy4cdeGgcCGoopa8z/Df1TcYRUJZhoFBRFMVRcwciN9cvw2W2715LdZGE9iFIIndmxmIaiwx+JsxJFoHMRDVWAK2qhgoBXAD8bX5yDKQWmDUwJFgIABfwAKBei+A8AAAAABJRU5ErkJggg==`e\"
            ))
        )
    }
}

Class SodaCanArrowLightGreen : AnimatedSodaCan {
    SodaCanArrowLightGreen() : base(
        @(),
        (Get-Random -Minimum 50 -Maximum 250),
        5,
        7
    ) {
        $this.Frames = @(
            [TIString]::new(@(
                "`eP0;1q`"1;1;20;40#0;2;0;0;0#1;2;0;0;0#2;2;9;3;19#3;2;52;62;75#4;2;72;80;87#5;2;39;61;27#6;2;35;40;15#7;2;22;47;30#8;2;19;25;14#9;2;36;33;51#10;2;44;49;66#0!3?#2!10@#0!7?$#0!2?#2A#3!3A#4!6A#3A#2A#0!6?$#0!2?#2C#5!3C#6!7C#2C#0!6?$#0?#2G#7!2G#5!2G#6!8G#2G#0!5?$#2O#7!2O#5O#7O#5!2O#6!6O#8O#6O#2O#0!4?$#2_#7!3_#5_#7_#5_#6!5_#8_#6_#8_#2_#0!4?$-#2@#7!4@#5@#7@#5@#6!3@#8@#6@#8!2@#2@#0!4?$#2A#7!5A#5!2A#6!4A#8!3A#2A#0!4?$#2C#7!4C#5C#7C#5!2C#6!2C#8C#6C#8!2C#2C#0!4?$#2G#7!5G#5!3G#6!3G#8!3G#2G#0!4?$#2O#8O#7!3O#5O#7O#5!3O#6O#8O#6O#8!2O#2O#0!4?$#2_#8_#7!4_#5!4_#6!2_#8!3_#2_#0!4?$-#2@#8@#7!3@#5@#7@#5!3@#6@#8@#6@#8!2@#2@#0!4?$#2A#7!5A#5!3A#6!3A#8!3A#2A#0!4?$#2C#7!4C#5C#7C#5!2C#6!2C#8C#6C#8!2C#2C#0!4?$#2G#7!5G#5!2G#6!4G#8!3G#2G#0!4?$#2O#7!4O#5O#7O#5O#6!3O#8O#6O#8!2O#2O#0!4?$#2_#7!5_#5_#6!5_#8!3_#2_#0!4?$-#2@#7!4@#5@#7@#6!4@#8@#6@#8!2@#2@#0!4?$#2A#7!5A#6!6A#8!3A#2A#0!4?$#2C#7!4C#5C#8C#6!4C#8C#6C#8!2C#2C#0!4?$#2G#7!4G#8G#6!6G#8!3G#2G#0!4?$#2O#7!4O#6O#8O#6!4O#8O#6O#8!2O#2O#0!4?$#2_#7!3_#8!2_#6!6_#8!3_#2_#0!4?$-#2@#7!3@#8@#6@#8@#6!4@#8@#6@#8!2@#2@#0!4?$#2A#7!2A#8!3A#6!6A#8!3A#2A#0!4?$#2C#7!2C#8!2C#6C#8C#6!4C#8C#6C#8!2C#2C#0!4?$#2G#7G#8!4G#6!6G#8!3G#2G#0!4?$#2O#7O#8!3O#6O#8O#6!4O#8O#6O#8!2O#2O#0!4?$#0?#2_#9!5_#10!5_#9!2_#2_#0!5?$-#0!2?#2@#3!3@#4!7@#2@#0!6?$#0!2?#2!12A#0!6?$#0!20?$#0!20?$#0!20?$#0!20?$-#0!20?$#0!20?$#0!20?$#0!20?$-`e\",
                "`e_Ga=T,f=100,m=0;iVBORw0KGgoAAAANSUhEUgAAABQAAAAoCAYAAAD+MdrbAAAACXBIWXMAAA7EAAAOxAGVKw4bAAABXUlEQVR4nO2WMUvDQBiGXyGI2UUJCCVDhYoIdVDBTXCUgrugo4OIv8JRxEH3zE4dC866RBBsoEGhk4uIW0SU6J1evFzva4IX6IG+y4X7cg/PJeHyOZDiuc0UJfKQXI9RtQzIYHunR1lhcaGmXRDe9HGye5BS0Jzh/fthdn171h/i6JIVR9j5+zPoxsBc/RVFWdtKcBE0tZaOgLEwWDce56O7XENypbeMem8kNLdlARMjBWvMOnwkt0xCFcsimBYoQ9UUwUgg9SxHZ/hyGWFipaE1ZBGWdj5DOaUN5e3qDMVLGZ2hGhkmf9j2GaqHg7Ghr8wbGfpP8cC8kWEYfNlUYhgGdwMwI0OxsBJDdlBE31D7DJmdvNAuQ2FnnyH/UR8jXd/Y/pl9BuangEmvnrt52gMeo5jXOu1zbdPEFVih00apZgmtJeysbqJUs/TZVcE0GXBYz/crYFX5B/4F4Ad6Siv1iPADlgAAAABJRU5ErkJggg==`e\"
            )),
            [TIString]::new(@(
                "`eP0;1q`"1;1;20;40#0;2;0;0;0#1;2;0;0;0#2;2;9;3;19#3;2;52;62;75#4;2;72;80;87#5;2;35;40;15#6;2;39;61;27#7;2;19;25;14#8;2;22;47;30#9;2;36;33;51#10;2;44;49;66#0!3?#2!10@#0!7?$#0!2?#2A#3!3A#4!6A#3A#2A#0!6?$#0!2?#2C#5!2C#6!8C#2C#0!6?$#0?#2G#7!2G#5G#6!8G#5G#2G#0!5?$#2O#7!2O#5O#7O#5O#6!7O#8O#5O#2O#0!4?$#2_#7!3_#5_#7_#6!6_#8_#6_#7_#2_#0!4?$-#2@#7!4@#5@#7@#6!4@#8@#6@#8!2@#2@#0!4?$#2A#7!5A#5A#6!5A#8!3A#2A#0!4?$#2C#7!4C#5C#7C#5C#6!3C#8C#6C#8!2C#2C#0!4?$#2G#7!5G#5!2G#6!4G#8!3G#2G#0!4?$#2O#7!4O#5O#7O#5!2O#6!2O#8O#6O#8!2O#2O#0!4?$#2_#7!5_#5!3_#6!3_#8!3_#2_#0!4?$-#2@#7!4@#5@#7@#5!2@#6!2@#8@#6@#8!2@#2@#0!4?$#2A#7!5A#5!2A#6!4A#8!3A#2A#0!4?$#2C#7!4C#5C#7C#5C#6!3C#8C#6C#8!2C#2C#0!4?$#2G#7!5G#5G#6!5G#8!3G#2G#0!4?$#2O#7!4O#5O#7O#6!4O#8O#6O#8!2O#2O#0!4?$#2_#7!5_#6!6_#8!2_#7_#2_#0!4?$-#2@#7!4@#5@#8@#6!4@#8@#6@#8@#7@#2@#0!4?$#2A#7!4A#8A#6!6A#8A#7!2A#2A#0!4?$#2C#7!4C#6C#8C#6!4C#8C#6C#7!2C#2C#0!4?$#2G#7!3G#8!2G#6!6G#7!3G#2G#0!4?$#2O#7!3O#8O#6O#8O#6!4O#8O#5O#7!2O#2O#0!4?$#2_#7!2_#8!3_#6!5_#5_#7!3_#2_#0!4?$-#2@#7!2@#8!2@#6@#8@#6!4@#7@#5@#7!2@#2@#0!4?$#2A#7A#8!4A#6!4A#5!2A#7!3A#2A#0!4?$#2C#7C#8!3C#6C#8C#6!3C#5C#7C#5C#7!2C#2C#0!4?$#2G#8!5G#6!3G#5!3G#7!3G#2G#0!4?$#2O#8!4O#6O#8O#6!2O#5!2O#7O#5O#7!2O#2O#0!4?$#0?#2_#9!5_#10!5_#9!2_#2_#0!5?$-#0!2?#2@#3!3@#4!7@#2@#0!6?$#0!2?#2!12A#0!6?$#0!20?$#0!20?$#0!20?$#0!20?$-#0!20?$#0!20?$#0!20?$#0!20?$-`e\",
                "`e_Ga=T,f=100,m=0;iVBORw0KGgoAAAANSUhEUgAAABQAAAAoCAYAAAD+MdrbAAAACXBIWXMAAA7EAAAOxAGVKw4bAAABnUlEQVR4nO2Wv0sCYRjHv8FROeTQUDhJlIERgQ5d0BY0RlCzQ1sNDf0lEQ39Ac5NjkJj6HJCkAceGULQEi0Nhgh2z2vv9fr6vvdDTxLqO/jgvbwfPnf6PvcYEJJK5HoIkdd2bUa35gEJdn5z6S3kt9LKDdZDC9dnFz0ddMDw8f6U1YSZRrOGkWJwu5T5AbsBZNeNoD3YK7RxV8wpLQ0OoxDMbnSRRYtZ6vK8mHGhjhI6oMNg39C8qYbVnVlsZDqwil3l+tD9cahVfEK+sKqEUZ3fyQLVl2CgCJXDYX5RAnXPUjSMBJycoVvb1R/L6TQUE4uh+KNMn6F8/MY2lI/fWIbysZMNPyu2+7kQ3pDbxGJI7UmGiYZ9uwhAvlFnaFW0vGEgtaW6A60htTW/RDbk/4BQQNY0ASWMsvLu+MIiG4qviEAgt9MZUhsLgk3OULRTGZId5XcM2Yv6Cr39g2PvYqcJrLk1OZdh35Op/vVlt77ZDjaXgHLpVjk0MUNaKJcQaljC4TZOdo8QalhypyqMGw/oN/ONBIwr/8C/APwCM+MZ+arVQ68AAAAASUVORK5CYII=`e\"
            )),
            [TIString]::new(@(
                "`eP0;1q`"1;1;20;40#0;2;0;0;0#1;2;0;0;0#2;2;9;3;19#3;2;52;62;75#4;2;72;80;87#5;2;35;40;15#6;2;39;61;27#7;2;19;25;14#8;2;22;47;30#9;2;36;33;51#10;2;44;49;66#0!3?#2!10@#0!7?$#0!2?#2A#3!3A#4!6A#3A#2A#0!6?$#0!2?#2C#5!9C#6C#2C#0!6?$#0?#2G#7!2G#5!8G#6!2G#2G#0!5?$#2O#7!2O#5O#7O#5!8O#8O#6O#2O#0!4?$#2_#7!3_#5_#7_#5!6_#7_#6_#8_#2_#0!4?$-#2@#7!4@#5@#7@#5!4@#7@#5@#7@#8@#2@#0!4?$#2A#7!5A#5!6A#7!2A#8A#2A#0!4?$#2C#7!4C#5C#7C#5!4C#7C#5C#7!2C#2C#0!4?$#2G#7!5G#5!6G#7!3G#2G#0!4?$#2O#7!4O#5O#7O#5!4O#7O#5O#7!2O#2O#0!4?$#2_#7!5_#5!6_#7!3_#2_#0!4?$-#2@#7!4@#5@#7@#5!4@#7@#5@#7!2@#2@#0!4?$#2A#7!5A#5!6A#7!3A#2A#0!4?$#2C#7!4C#5C#7C#5!4C#7C#5C#7!2C#2C#0!4?$#2G#7!5G#5!6G#7!2G#8G#2G#0!4?$#2O#7!4O#5O#7O#5!4O#7O#5O#7O#8O#2O#0!4?$#2_#7!5_#5!6_#7_#8!2_#2_#0!4?$-#2@#7!4@#5@#7@#5!4@#7@#5@#8!2@#2@#0!4?$#2A#7!5A#5!6A#8!3A#2A#0!4?$#2C#7!4C#5C#7C#5!4C#7C#6C#8!2C#2C#0!4?$#2G#7!5G#5!5G#6G#8!3G#2G#0!4?$#2O#7!4O#5O#7O#5!4O#8O#6O#8!2O#2O#0!4?$#2_#7!5_#5!4_#6!2_#8!3_#2_#0!4?$-#2@#7!4@#5@#7@#5!3@#6@#8@#6@#8!2@#2@#0!4?$#2A#7!5A#5!3A#6!3A#8!3A#2A#0!4?$#2C#7!4C#5C#7C#5!2C#6!2C#8C#6C#8!2C#2C#0!4?$#2G#7!5G#5!2G#6!4G#8!3G#2G#0!4?$#2O#7!4O#5O#7O#5O#6!3O#8O#6O#8!2O#2O#0!4?$#0?#2_#9!5_#10!5_#9!2_#2_#0!5?$-#0!2?#2@#3!3@#4!7@#2@#0!6?$#0!2?#2!12A#0!6?$#0!20?$#0!20?$#0!20?$#0!20?$-#0!20?$#0!20?$#0!20?$#0!20?$-`e\",
                "`e_Ga=T,f=100,m=0;iVBORw0KGgoAAAANSUhEUgAAABQAAAAoCAYAAAD+MdrbAAAACXBIWXMAAA7EAAAOxAGVKw4bAAABT0lEQVR4nGNhQAKSnIb/GYgAz7+fZ8QlBzcQZFju9H64hJGePFYN5y49ZJicWfgfl6EoLrx6LAOJjd0FnObYLUIxEOQ6SfPPDNdvMTBoqrEwEALeU8QYtuYYYnUlC8wwEAAZdv3WH7yGfj/5kOG+kCpOQ1F0wgzDZyhIzij2F8O122xY5TF04TMUJnZu8V0GDgtN4gxE1ogOYBbhA1gNJORCEP3jxHWgCO8gdiFJBo66kD4uBCfsk08GqQtxZTuyXXifATcg2YWgogsfINmF+Ioukl1oFKuM1zCSXQgyTEuVSi4EVU5aDL8GqQthVSchwwbGhcgV+8C4EFxRnzT87+objBD9wMCgI8bAICIJzBWPEMIW7AwMb3beZlABsndvXou10QR2Akhi92YGohpLDP5mDInWQQxENZaArSoGSgHcQHxtPrIMpBYYNXAkGAgAGCAH/tQLN6sAAAAASUVORK5CYII=`e\"
            )),
            [TIString]::new(@(
                "`eP0;1q`"1;1;20;40#0;2;0;0;0#1;2;0;0;0#2;2;9;3;19#3;2;52;62;75#4;2;72;80;87#5;2;35;40;15#6;2;19;25;14#7;2;36;33;51#8;2;44;49;66#0!3?#2!10@#0!7?$#0!2?#2A#3!3A#4!6A#3A#2A#0!6?$#0!2?#2C#5!10C#2C#0!6?$#0?#2G#6!2G#5!10G#2G#0!5?$#2O#6!2O#5O#6O#5!8O#6O#5O#2O#0!4?$#2_#6!3_#5_#6_#5!6_#6_#5_#6_#2_#0!4?$-#2@#6!4@#5@#6@#5!4@#6@#5@#6!2@#2@#0!4?$#2A#6!5A#5!6A#6!3A#2A#0!4?$#2C#6!4C#5C#6C#5!4C#6C#5C#6!2C#2C#0!4?$#2G#6!5G#5!6G#6!3G#2G#0!4?$#2O#6!4O#5O#6O#5!4O#6O#5O#6!2O#2O#0!4?$#2_#6!5_#5!6_#6!3_#2_#0!4?$-#2@#6!4@#5@#6@#5!4@#6@#5@#6!2@#2@#0!4?$#2A#6!5A#5!6A#6!3A#2A#0!4?$#2C#6!4C#5C#6C#5!4C#6C#5C#6!2C#2C#0!4?$#2G#6!5G#5!6G#6!3G#2G#0!4?$#2O#6!4O#5O#6O#5!4O#6O#5O#6!2O#2O#0!4?$#2_#6!5_#5!6_#6!3_#2_#0!4?$-#2@#6!4@#5@#6@#5!4@#6@#5@#6!2@#2@#0!4?$#2A#6!5A#5!6A#6!3A#2A#0!4?$#2C#6!4C#5C#6C#5!4C#6C#5C#6!2C#2C#0!4?$#2G#6!5G#5!6G#6!3G#2G#0!4?$#2O#6!4O#5O#6O#5!4O#6O#5O#6!2O#2O#0!4?$#2_#6!5_#5!6_#6!3_#2_#0!4?$-#2@#6!4@#5@#6@#5!4@#6@#5@#6!2@#2@#0!4?$#2A#6!5A#5!6A#6!3A#2A#0!4?$#2C#6!4C#5C#6C#5!4C#6C#5C#6!2C#2C#0!4?$#2G#6!5G#5!6G#6!3G#2G#0!4?$#2O#6!4O#5O#6O#5!4O#6O#5O#6!2O#2O#0!4?$#0?#2_#7!5_#8!5_#7!2_#2_#0!5?$-#0!2?#2@#3!3@#4!7@#2@#0!6?$#0!2?#2!12A#0!6?$#0!20?$#0!20?$#0!20?$#0!20?$-#0!20?$#0!20?$#0!20?$#0!20?$-`e\"
                "`e_Ga=T,f=100,m=0;iVBORw0KGgoAAAANSUhEUgAAABQAAAAoCAYAAAD+MdrbAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAA6UlEQVR4nGNhQAKSnIb/GYgAz7+fZ8QlBzcQZFju9H64hJGePFYN5y49ZJicWfgfl6EoLrx6LAOJjc+NnDhlWGCukzT/zHD9FgODphoLAyHgFPudYd9iQ6yuZIEZBgIgw67f+kPQUJAaXIayoCskZCiyGmwAQxc+QwkZhtVAZI3ogJBhOA0cdeGoC0ddOOrCUReOunBQuBBcUZ80/O/qG4wQ/cDAoCPGwCAiqYqiWFySgeHN9dtgud2b12JtNIGdAJLYvZmBqMYSg78ZQ6J1EANRjSVgq4qBUgA3EF+bjywDqQVGDRwJBgIALN4I2nUeFUMAAAAASUVORK5CYII=`e\"
            ))
        )
    }
}






Class SodaCanArrowDarkPink : AnimatedSodaCan {
    SodaCanArrowDarkPink() : base(
        @(),
        (Get-Random -Minimum 50 -Maximum 250),
        5,
        9
    ) {
        $this.Frames = @(
            [TIString]::new(@(
                "`eP0;1q`"1;1;20;40#0;2;0;0;0#1;2;0;0;0#2;2;9;3;19#3;2;52;62;75#4;2;72;80;87#5;2;58;15;34#6;2;37;11;26#7;2;49;9;40#8;2;23;9;24#9;2;36;33;51#10;2;44;49;66#0!3?#2!10@#0!7?$#0!2?#2A#3!3A#4!6A#3A#2A#0!6?$#0!2?#2C#5!3C#6!7C#2C#0!6?$#0?#2G#7!2G#5!2G#6!8G#2G#0!5?$#2O#7!2O#5O#7O#5!2O#6!6O#8O#6O#2O#0!4?$#2_#7!3_#5_#7_#5_#6!5_#8_#6_#8_#2_#0!4?$-#2@#7!4@#5@#7@#5@#6!3@#8@#6@#8!2@#2@#0!4?$#2A#7!5A#5!2A#6!4A#8!3A#2A#0!4?$#2C#7!4C#5C#7C#5!2C#6!2C#8C#6C#8!2C#2C#0!4?$#2G#7!5G#5!3G#6!3G#8!3G#2G#0!4?$#2O#8O#7!3O#5O#7O#5!3O#6O#8O#6O#8!2O#2O#0!4?$#2_#8_#7!4_#5!4_#6!2_#8!3_#2_#0!4?$-#2@#8@#7!3@#5@#7@#5!3@#6@#8@#6@#8!2@#2@#0!4?$#2A#7!5A#5!3A#6!3A#8!3A#2A#0!4?$#2C#7!4C#5C#7C#5!2C#6!2C#8C#6C#8!2C#2C#0!4?$#2G#7!5G#5!2G#6!4G#8!3G#2G#0!4?$#2O#7!4O#5O#7O#5O#6!3O#8O#6O#8!2O#2O#0!4?$#2_#7!5_#5_#6!5_#8!3_#2_#0!4?$-#2@#7!4@#5@#7@#6!4@#8@#6@#8!2@#2@#0!4?$#2A#7!5A#6!6A#8!3A#2A#0!4?$#2C#7!4C#5C#8C#6!4C#8C#6C#8!2C#2C#0!4?$#2G#7!4G#8G#6!6G#8!3G#2G#0!4?$#2O#7!4O#6O#8O#6!4O#8O#6O#8!2O#2O#0!4?$#2_#7!3_#8!2_#6!6_#8!3_#2_#0!4?$-#2@#7!3@#8@#6@#8@#6!4@#8@#6@#8!2@#2@#0!4?$#2A#7!2A#8!3A#6!6A#8!3A#2A#0!4?$#2C#7!2C#8!2C#6C#8C#6!4C#8C#6C#8!2C#2C#0!4?$#2G#7G#8!4G#6!6G#8!3G#2G#0!4?$#2O#7O#8!3O#6O#8O#6!4O#8O#6O#8!2O#2O#0!4?$#0?#2_#9!5_#10!5_#9!2_#2_#0!5?$-#0!2?#2@#3!3@#4!7@#2@#0!6?$#0!2?#2!12A#0!6?$#0!20?$#0!20?$#0!20?$#0!20?$-#0!20?$#0!20?$#0!20?$#0!20?$-`e\",
                "`e_Ga=T,f=100,m=0;iVBORw0KGgoAAAANSUhEUgAAABQAAAAoCAYAAAD+MdrbAAAACXBIWXMAAA7EAAAOxAGVKw4bAAABXElEQVR4nO2WMUvEMBiGXyGLOFS8G3QSBREX4QS7uLjoJoL+AsHFwcF/4ebgcIu7Lk63ecvNDgouIqKgix26ZBCXQm0iCUkvny2XwgX0hZKSNA9P0pJ+DEbmJjs5auTj636CGtNAATvunumBtdV554S7hzecH53kFNQyjE67+v7yM8UoYcrucHodCQdmI145abs9g5u047RkCiYiYAmPZBtPtXFLWL5mGQm1lqxgqqVgi4zJllwyBY0jWJZVMCfQhJZTBSOB1F6Oz3CAJ2xi2WkooizD3EMztQ3N5boM1UsZn2E5Jsz8sMMzLB8O3oZgNtDL8J29DPV7GQ74j00jhlc8GYJ5GaqJjRiKgwIZAjWUdsbEsAyVXXiG4kd9AeRbO/u6U1RMC8XVWlmyHm4VV/r4LMf6vWtn0SQVxEC/h1rFEnZjHGzsoVaxVFRV8I0G/lbzjQRsKv/AvwD8BuGVJjHX1GpQAAAAAElFTkSuQmCC`e\"
            )),
            [TIString]::new(@(
                "`eP0;1q`"1;1;20;40#0;2;0;0;0#1;2;0;0;0#2;2;9;3;19#3;2;52;62;75#4;2;72;80;87#5;2;37;11;26#6;2;58;15;34#7;2;23;9;24#8;2;49;9;40#9;2;36;33;51#10;2;44;49;66#0!3?#2!10@#0!7?$#0!2?#2A#3!3A#4!6A#3A#2A#0!6?$#0!2?#2C#5!2C#6!8C#2C#0!6?$#0?#2G#7!2G#5G#6!8G#5G#2G#0!5?$#2O#7!2O#5O#7O#5O#6!7O#8O#5O#2O#0!4?$#2_#7!3_#5_#7_#6!6_#8_#6_#7_#2_#0!4?$-#2@#7!4@#5@#7@#6!4@#8@#6@#8!2@#2@#0!4?$#2A#7!5A#5A#6!5A#8!3A#2A#0!4?$#2C#7!4C#5C#7C#5C#6!3C#8C#6C#8!2C#2C#0!4?$#2G#7!5G#5!2G#6!4G#8!3G#2G#0!4?$#2O#7!4O#5O#7O#5!2O#6!2O#8O#6O#8!2O#2O#0!4?$#2_#7!5_#5!3_#6!3_#8!3_#2_#0!4?$-#2@#7!4@#5@#7@#5!2@#6!2@#8@#6@#8!2@#2@#0!4?$#2A#7!5A#5!2A#6!4A#8!3A#2A#0!4?$#2C#7!4C#5C#7C#5C#6!3C#8C#6C#8!2C#2C#0!4?$#2G#7!5G#5G#6!5G#8!3G#2G#0!4?$#2O#7!4O#5O#7O#6!4O#8O#6O#8!2O#2O#0!4?$#2_#7!5_#6!6_#8!2_#7_#2_#0!4?$-#2@#7!4@#5@#8@#6!4@#8@#6@#8@#7@#2@#0!4?$#2A#7!4A#8A#6!6A#8A#7!2A#2A#0!4?$#2C#7!4C#6C#8C#6!4C#8C#6C#7!2C#2C#0!4?$#2G#7!3G#8!2G#6!6G#7!3G#2G#0!4?$#2O#7!3O#8O#6O#8O#6!4O#8O#5O#7!2O#2O#0!4?$#2_#7!2_#8!3_#6!5_#5_#7!3_#2_#0!4?$-#2@#7!2@#8!2@#6@#8@#6!4@#7@#5@#7!2@#2@#0!4?$#2A#7A#8!4A#6!4A#5!2A#7!3A#2A#0!4?$#2C#7C#8!3C#6C#8C#6!3C#5C#7C#5C#7!2C#2C#0!4?$#2G#8!5G#6!3G#5!3G#7!3G#2G#0!4?$#2O#8!4O#6O#8O#6!2O#5!2O#7O#5O#7!2O#2O#0!4?$#0?#2_#9!5_#10!5_#9!2_#2_#0!5?$-#0!2?#2@#3!3@#4!7@#2@#0!6?$#0!2?#2!12A#0!6?$#0!20?$#0!20?$#0!20?$#0!20?$-#0!20?$#0!20?$#0!20?$#0!20?$-`e\",
                "`e_Ga=T,f=100,m=0;iVBORw0KGgoAAAANSUhEUgAAABQAAAAoCAYAAAD+MdrbAAAACXBIWXMAAA7EAAAOxAGVKw4bAAABkklEQVR4nO2WP0vDQBjGH+EWEYxoh7ooVkVchDpkcemimwi6uDo6OPgBnPwADg4ufgAXp2526ayg4CJFW6iLHbJkKC6BmDf2wvV6b/6YFgv6LC/JcT9+uXB3r4CS+cmyjxT5+Hya4MYiIMFOri6igc2NReOEx+c2Lo9PfQ7aZ9g4Ow+rPVVAkzGwEB8h7VZmptHyPJSEQFJ2CrO4c8pGSyFhFIIRFF0ntOSy4C0HUBihfTrSkKrNwDquhaLlou56xvGB75PQG7eDQ6tohFGtBKv5hodkoArVI2FxMQK5tVQNMwFHZkj1XrEcT0M1QzFUf8r4GerbL7ehvv1yGerbTjeso5HNUNoMxZCOJx2mGnJ2LFBO5Azhgs0AsIK1YCJYQzrW4pLZsCSc75MoDZDs5EST4btoxsIyG6pXRCJQ2nGGdIwlwUZnqNqZDMmO8juGdFFfA/727kH0st2r3fXVsM71nqk6L69YCmqtemtsmkJDGqhVkapZwp6No619pGqWgq4KeRMB43q+HwGHlX/gXwB+ATRXFgyTi1lWAAAAAElFTkSuQmCC`e\"
            )),
            [TIString]::new(@(
                "`eP0;1q`"1;1;20;40#0;2;0;0;0#1;2;0;0;0#2;2;9;3;19#3;2;52;62;75#4;2;72;80;87#5;2;37;11;26#6;2;58;15;34#7;2;23;9;24#8;2;49;9;40#9;2;36;33;51#10;2;44;49;66#0!3?#2!10@#0!7?$#0!2?#2A#3!3A#4!6A#3A#2A#0!6?$#0!2?#2C#5!9C#6C#2C#0!6?$#0?#2G#7!2G#5!8G#6!2G#2G#0!5?$#2O#7!2O#5O#7O#5!8O#8O#6O#2O#0!4?$#2_#7!3_#5_#7_#5!6_#7_#6_#8_#2_#0!4?$-#2@#7!4@#5@#7@#5!4@#7@#5@#7@#8@#2@#0!4?$#2A#7!5A#5!6A#7!2A#8A#2A#0!4?$#2C#7!4C#5C#7C#5!4C#7C#5C#7!2C#2C#0!4?$#2G#7!5G#5!6G#7!3G#2G#0!4?$#2O#7!4O#5O#7O#5!4O#7O#5O#7!2O#2O#0!4?$#2_#7!5_#5!6_#7!3_#2_#0!4?$-#2@#7!4@#5@#7@#5!4@#7@#5@#7!2@#2@#0!4?$#2A#7!5A#5!6A#7!3A#2A#0!4?$#2C#7!4C#5C#7C#5!4C#7C#5C#7!2C#2C#0!4?$#2G#7!5G#5!6G#7!2G#8G#2G#0!4?$#2O#7!4O#5O#7O#5!4O#7O#5O#7O#8O#2O#0!4?$#2_#7!5_#5!6_#7_#8!2_#2_#0!4?$-#2@#7!4@#5@#7@#5!4@#7@#5@#8!2@#2@#0!4?$#2A#7!5A#5!6A#8!3A#2A#0!4?$#2C#7!4C#5C#7C#5!4C#7C#6C#8!2C#2C#0!4?$#2G#7!5G#5!5G#6G#8!3G#2G#0!4?$#2O#7!4O#5O#7O#5!4O#8O#6O#8!2O#2O#0!4?$#2_#7!5_#5!4_#6!2_#8!3_#2_#0!4?$-#2@#7!4@#5@#7@#5!3@#6@#8@#6@#8!2@#2@#0!4?$#2A#7!5A#5!3A#6!3A#8!3A#2A#0!4?$#2C#7!4C#5C#7C#5!2C#6!2C#8C#6C#8!2C#2C#0!4?$#2G#7!5G#5!2G#6!4G#8!3G#2G#0!4?$#2O#7!4O#5O#7O#5O#6!3O#8O#6O#8!2O#2O#0!4?$#0?#2_#9!5_#10!5_#9!2_#2_#0!5?$-#0!2?#2@#3!3@#4!7@#2@#0!6?$#0!2?#2!12A#0!6?$#0!20?$#0!20?$#0!20?$#0!20?$-#0!20?$#0!20?$#0!20?$#0!20?$-`e\",
                "`e_Ga=T,f=100,m=0;iVBORw0KGgoAAAANSUhEUgAAABQAAAAoCAYAAAD+MdrbAAAACXBIWXMAAA7EAAAOxAGVKw4bAAABQElEQVR4nGNhQAKSnIb/GYgAz7+fZ8QlBzcQZFju9H64hJGePFYN5y49ZJicWfgfl6EoLrxZ24xg43CBGbcIAz7AAnOdigAfw70/fxiUWFgYCIEaeTWGlocMWF3JAjMMBECGETL01Nc3DHJ/lHEaiqITZhg+Q0FyZvwfGV585Mcqj6ELn6EwsRUfXzA4MBBpILJGdACzCB/AaiAhF4LoAzjSweBxIUkGjrqQPi50YFBnuMNwepC6EOQ6kgwk5EIGPPFCsgtBRRc+QLIL8RVdJLswgl8Cr2EkuxBkmAS1XAipnD4OUhfCqk5Chg2MC5Er9oFxIaSiNvzv6hsMFwS1mBSBWFhTleEumoaT12+D6d2b12JtNIGdAJLYvZmBqMYSg78ZQ6J1EANRjSVgq4qBUgA3EF+bjywDqQVGDRwJBgIAjDEDaINW05wAAAAASUVORK5CYII=`e\"
            )),
            [TIString]::new(@(
                "`eP0;1q`"1;1;20;40#0;2;0;0;0#1;2;0;0;0#2;2;9;3;19#3;2;52;62;75#4;2;72;80;87#5;2;37;11;26#6;2;23;9;24#7;2;36;33;51#8;2;44;49;66#0!3?#2!10@#0!7?$#0!2?#2A#3!3A#4!6A#3A#2A#0!6?$#0!2?#2C#5!10C#2C#0!6?$#0?#2G#6!2G#5!10G#2G#0!5?$#2O#6!2O#5O#6O#5!8O#6O#5O#2O#0!4?$#2_#6!3_#5_#6_#5!6_#6_#5_#6_#2_#0!4?$-#2@#6!4@#5@#6@#5!4@#6@#5@#6!2@#2@#0!4?$#2A#6!5A#5!6A#6!3A#2A#0!4?$#2C#6!4C#5C#6C#5!4C#6C#5C#6!2C#2C#0!4?$#2G#6!5G#5!6G#6!3G#2G#0!4?$#2O#6!4O#5O#6O#5!4O#6O#5O#6!2O#2O#0!4?$#2_#6!5_#5!6_#6!3_#2_#0!4?$-#2@#6!4@#5@#6@#5!4@#6@#5@#6!2@#2@#0!4?$#2A#6!5A#5!6A#6!3A#2A#0!4?$#2C#6!4C#5C#6C#5!4C#6C#5C#6!2C#2C#0!4?$#2G#6!5G#5!6G#6!3G#2G#0!4?$#2O#6!4O#5O#6O#5!4O#6O#5O#6!2O#2O#0!4?$#2_#6!5_#5!6_#6!3_#2_#0!4?$-#2@#6!4@#5@#6@#5!4@#6@#5@#6!2@#2@#0!4?$#2A#6!5A#5!6A#6!3A#2A#0!4?$#2C#6!4C#5C#6C#5!4C#6C#5C#6!2C#2C#0!4?$#2G#6!5G#5!6G#6!3G#2G#0!4?$#2O#6!4O#5O#6O#5!4O#6O#5O#6!2O#2O#0!4?$#2_#6!5_#5!6_#6!3_#2_#0!4?$-#2@#6!4@#5@#6@#5!4@#6@#5@#6!2@#2@#0!4?$#2A#6!5A#5!6A#6!3A#2A#0!4?$#2C#6!4C#5C#6C#5!4C#6C#5C#6!2C#2C#0!4?$#2G#6!5G#5!6G#6!3G#2G#0!4?$#2O#6!4O#5O#6O#5!4O#6O#5O#6!2O#2O#0!4?$#0?#2_#7!5_#8!5_#7!2_#2_#0!5?$-#0!2?#2@#3!3@#4!7@#2@#0!6?$#0!2?#2!12A#0!6?$#0!20?$#0!20?$#0!20?$#0!20?$-#0!20?$#0!20?$#0!20?$#0!20?$-`e\"
                "`e_Ga=T,f=100,m=0;iVBORw0KGgoAAAANSUhEUgAAABQAAAAoCAYAAAD+MdrbAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAA3klEQVR4nGNhQAKSnIb/GYgAz7+fZ8QlBzcQZFju9H64hJGePFYN5y49ZJicWfgfl6EoLrxZ24xgM5AHWGCuUxHgY7j35w+DEgsLIT0MbiJCDLveGGJ1JQvMMBAAGUaMoSA1uAxlQVdIyFBkNdgAhi58hhIyDKuByBrRASHDcBo46sJRF466cNSFoy4cdeGgcCGkojb87+obDBcEtZgUgVhYUxVFsTAQv7l+Gyy3e/NarI0msBNAErs3MxDVWGLwN2NItA5iIKqxBGxVMVAK4Abia/ORZSC1wKiBI8FAAIoNBF139RyoAAAAAElFTkSuQmCC`e\"
            ))
        )
    }
}





###############################################################################
#
# HELPER FUNCTIONS
#
###############################################################################

Function NewPsco {
    Param(
        [Parameter(Mandatory)]
        [Hashtable]$Properties
    )

    Return [PSCustomObject]$Properties
}
Set-Alias -Name 'psco' -Value 'NewPsco'





###############################################################################
#
# PSTEA SETUP
#
###############################################################################

$Init = {
    $SodaCans = [List[AnimatedSodaCan]]::new()
    $SodaCans.Add([SodaCanLightBlueBubbles]::new())
    $SodaCans.Add([SodaCanArrowLightGreen]::new())
    $SodaCans.Add([SodaCanArrowDarkPink]::new())

    Return psco @{
        Model = psco @{
            SodaCans = $SodaCans
            Cmd = $null
        }
    }
}

$Subs = {
    Param($Model)

    Return @(
        TeaTimerSub -IntervalMs $Model.SodaCans[0].FrameTimeMs -Handler { 'SodaCanLightBlueBubblesUpdate' }
        TeaTimerSub -IntervalMs $Model.SodaCans[1].FrameTimeMs -Handler { 'SodaCanArrowLightGreenUpdate' }
        TeaTimerSub -IntervalMs $Model.SodaCans[2].FrameTimeMs -Handler { 'SodaCanArrowDarkPinkUpdate' }
    )
}

$Update = {
    Param($Msg, $Model)

    Switch($Msg) {
        'SodaCanLightBlueBubblesUpdate' {
            $Model.SodaCans[0].Update()

            Return psco @{
                Model = $Model
                Cmd = $null
            }

            Break
        }

        'SodaCanArrowLightGreenUpdate' {
            $Model.SodaCans[1].Update()

            Return psco @{
                Model = $Model
                Cmd = $null
            }

            Break
        }

        'SodaCanArrowDarkPinkUpdate' {
            $Model.SodaCans[2].Update()

            Return psco @{
                Model = $Model
                Cmd = $null
            }

            Break
        }

        Default {}
    }
}

$View = {
    Param($Model)

    TeaBox -Children @(
        TeaText -Content "$($Model.SodaCans[0].GetAmendedFrame())"
        TeaText -Content "$($Model.SodaCans[1].GetAmendedFrame())"
        TeaText -Content "$($Model.SodaCans[2].GetAmendedFrame())"
    )
}

TeaProgram -InitFn $Init -UpdateFn $Update -ViewFn $View -SubscriptionFn $Subs | Out-Null

