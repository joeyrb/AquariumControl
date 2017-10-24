--[[

  * * * * lip.lua * * * *

Lua image processing demo program: exercise all LuaIP library routines.

Authors: John Weiss and Alex Iverson
Class: CSC442/542 Digital Image Processing
Date: Spring 2017

--]]

-- LuaIP image processing routines
require "ip"   -- this loads the packed distributable
local viz = require "visual"
local il = require "il"
-- for k,v in pairs( il ) do io.write( k .. "\n" ) end

-- load images listed on command line
local imgs = {...}
for i, fname in ipairs( imgs ) do loadImage( fname ) end

-----------
-- menus --
-----------

local cmarg1 = {name = "color model", type = "string", displaytype = "combo", choices = {"rgb", "yiq", "ihs"}, default = "rgb"}
local cmarg2 = {name = "color model", type = "string", displaytype = "combo", choices = {"yiq", "yuv", "ihs"}, default = "yiq"}
local cmarg3 = {name = "interpolation", type = "string", displaytype = "combo", choices = {"nearest neighbor", "bilinear"}, default = "bilinear"}

imageMenu("Point processes",
  {
    {"Grayscale YIQ\tCtrl-M", il.grayscaleYIQ, hotkey = "C-M"},
    {"Grayscale IHS", il.grayscaleIHS},
    {"Negate\tCtrl-N", il.negate, hotkey = "C-N", {cmarg1}},
    {"Brighten", il.brighten, {{name = "amount", type = "number", displaytype = "slider", default = 0, min = -255, max = 255}, cmarg1}},
    {"Contrast Stretch", il.contrastStretch,
      {{name = "min", type = "number", displaytype = "spin", default = 64, min = 0, max = 255},
       {name = "max", type = "number", displaytype = "spin", default = 191, min = 0, max = 255}}},
    {"Scale Intensities", il.scaleIntensities,
      {{name = "min", type = "number", displaytype = "spin", default = 64, min = 0, max = 255},
       {name = "max", type = "number", displaytype = "spin", default = 191, min = 0, max = 255}}},
    {"Posterize", il.posterize, {{name = "levels", type = "number", displaytype = "spin", default = 4, min = 2, max = 64}, cmarg1}},
    {"Gamma", il.gamma, {{name = "gamma", type = "number", displaytype = "textbox", default = "1.0"}, cmarg1}},
    {"Log", il.logscale, {cmarg1}},
    {"Solarize", il.solarize},
    {"Sawtooth", il.sawtooth, {{name = "levels", type = "number", displaytype = "spin", default = 4, min = 2, max = 64}}},
    {"Bitplane Slice", il.slice, {{name = "plane", type = "number", displaytype = "spin", default = 7, min = 0, max = 7}}},
    {"Cont Pseudocolor", il.pseudocolor1},
    {"Disc Pseudocolor", il.pseudocolor2},
    {"Color Cube", il.pseudocolor3},
    {"Random Pseudocolor", il.pseudocolor4},
    {"Color Sawtooth RGB", il.sawtoothRGB},
    {"Color Sawtooth BGR", il.sawtoothBGR},
  }
)

imageMenu("Histogram processes",
  {
    {"Display Histogram", il.showHistogram,
       {{name = "color model", type = "string", displaytype = "combo", choices = {"yiq", "rgb"}, default = "yiq"}}},
    {"Contrast Stretch", il.stretch, {cmarg2}},
    {"Contrast Specify\tCtrl-H", il.stretchSpecify, hotkey = "C-H",
      {{name = "lp", type = "number", displaytype = "spin", default = 1, min = 0, max = 100},
       {name = "rp", type = "number", displaytype = "spin", default = 99, min = 0, max = 100}, cmarg2}},
    {"Histogram Equalize", il.equalize,
       {{name = "color model", type = "string", displaytype = "combo", choices = {"ihs", "yiq", "yuv", "rgb"}, default = "ihs"}}},
    {"Histogram Equalize Clip", il.equalizeClip,
      {{name = "clip %", type = "number", displaytype = "textbox", default = "1.0"},
       {name = "color model", type = "string", displaytype = "combo", choices = {"ihs", "yiq", "yuv"}, default = "ihs"}}},
    {"Adaptive Equalize", il.adaptiveEqualize,
      {{name = "width", type = "number", displaytype = "spin", default = 15, min = 3, max = 65}}},
    {"Adaptive Contrast Stretch", il.adaptiveContrastStretch,
      {{name = "width", type = "number", displaytype = "spin", default = 15, min = 3, max = 65}}},
  }
)

imageMenu("Neighborhood ops",
  {
    {"Smooth", il.smooth},
    {"Sharpen", il.sharpen},
    {"Mean", il.mean,
      {{name = "width", type = "number", displaytype = "spin", default = 3, min = 3, max = 65}}},
    {"Weighted Mean 1", il.meanW1,
      {{name = "width", type = "number", displaytype = "spin", default = 3, min = 3, max = 65}}},
    {"Weighted Mean 2", il.meanW2,
      {{name = "width", type = "number", displaytype = "spin", default = 3, min = 3, max = 65}}},
    {"Gaussian\tCtrl-G", il.meanW3, hotkey = "C-G",
      {{name = "sigma", type = "number", displaytype = "textbox", default = "1.0"}}},
    {"Minimum", il.minimum},
    {"Maximum", il.maximum},
    {"Median+", il.medianPlus},
    {"Median", il.timed(il.median),
      {{name = "width", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
    -- {"Median 3", il.curry(il.median, 3)}
    {"Emboss", il.emboss},
  }
)

imageMenu("Edge detection",
  {
    {"Sobel Edge Mag\tCtrl-E", il.sobelMag, hotkey = "C-E"},
    {"Sobel Edge Mag/Dir", il.sobel},
    {"Horizontal/Vertical Edges", il.edgeHorVer},
    {"Kirsch Edge Mag/Dir", il.kirsch},
    {"Canny", il.canny,
      {
        {name = "sigma", type = "number", displaytype = "textbox", default = "2.0"},
        {name = "strong edge threshold", type = "number", displaytype = "slider", default = 32, min = 0, max = 255},
        {name = "weak edge threshold", type = "number", displaytype = "slider", default = 16, min = 0, max = 255},
      }},
    {"Laplacian", il.laplacian},
    {"Laplacian for ZC", il.laplacianZero},
    {"Laplacian of Gaussian", il.LoG,
      {{name = "sigma", type = "number", displaytype = "textbox", default = "4.0"}}},
    {"Difference of Gaussians (DoG)", il.DoG,
      {{name = "sigma", type = "number", displaytype = "textbox", default = "2.0"}}},
    {"Marr-Hildreth (LoG with ZC)", il.marrHildrethLoG,
      {{name = "sigma", type = "number", displaytype = "textbox", default = "4.0"}}},
    {"Marr-Hildreth (DoG with ZC)", il.marrHildrethDoG,
      {{name = "sigma", type = "number", displaytype = "textbox", default = "2.0"}}},
    {"Zero Crossings 2D", il.zeroCrossings},
    {"Morph Gradient", il.morphGradient},
    {"Range", il.range},
    {"Variance", il.variance,
      {{name = "width", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
    {"Std Dev", il.stdDev,
      {{name = "width", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
  }
)

imageMenu("Morphological operations",
  {
    {"Dilate+", il.dilate},
    {"Erode+", il.erode},
    {"Dilate", il.dilate,
      {{name = "width", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
    {"Erode", il.erode,
      {{name = "width", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
    {"Open", il.open,
      {{name = "width", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
    {"Close", il.close,
      {{name = "width", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
    {"SmoothOC", il.smoothOC,
      {{name = "width", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
    {"SmoothCO", il.smoothCO,
      {{name = "width", type = "number", displaytype = "spin", default = 3, min = 0, max = 65}}},
    {"Morph Sharpen", il.sharpenMorph},
    {"Morph3D+", il.morph3D,
       {{name = "morph op", type = "string", displaytype = "combo",
         choices = {"erode", "dilate", "open", "close", "smoothCO", "smoothOC"}, default = "erode"}}},
  }
)

imageMenu("Frequency domain",
  {
    {"DFT Magnitude", il.dftMagnitude},
    {"DFT Phase", il.dftPhase},
    {"DFT Mag and Phase", il.dft},
    {"Ideal filter", il.idealFilter,
      {{name = "cutoff", type = "number", displaytype = "spin", default = 10, min = 0, max = 100},
       {name = "boost", type = "number", displaytype = "textbox", default = "0.0"},
       {name = "lowscale", type = "number", displaytype = "textbox", default = "1.0"},
       {name = "highscale", type = "number", displaytype = "textbox", default = "0.0"}}},
    {"Gaussian LP filter", il.gaussLPF,
      {{name = "cutoff", type = "number", displaytype = "spin", default = 10, min = 0, max = 100},
       {name = "boost", type = "number", displaytype = "textbox", default = "0.0"}}},
    {"Gaussian HP filter", il.gaussHPF,
      {{name = "cutoff", type = "number", displaytype = "spin", default = 10, min = 0, max = 100},
       {name = "boost", type = "number", displaytype = "textbox", default = "0.0"}}},
  }
)

imageMenu("Color models",
  {
    {"RGB->YIQ", il.RGB2YIQ}, {"YIQ->RGB", il.YIQ2RGB},
    {"RGB->YUV", il.RGB2YUV}, {"YUV->RGB", il.YUV2RGB},
    {"RGB->IHS", il.RGB2IHS}, {"IHS->RGB", il.IHS2RGB},
    {"R", il.getR}, {"G", il.getG}, {"B", il.getB},
    {"I(HS)", il.getI}, {"H", il.getH}, {"S", il.getS},
    {"Y", il.getY}, {"I(nphase)", il.getInphase}, {"Q", il.getQuadrature},
    {"U", il.getU}, {"V", il.getV},
    {"RGB->RBG", il.RGB2RBG},
    {"RGB->GRB", il.RGB2GRB},
    {"RGB->GBR", il.RGB2GBR},
    {"RGB->BRG", il.RGB2BRG},
    {"RGB->BGR", il.RGB2BGR},
    {"False Color", il.falseColor,
      {{name = "image R", type = "image"}, {name = "image G", type = "image"}, {name = "image B", type = "image"}}},
  }
)

imageMenu("Segment",
  {
    {"Binary Threshold", il.threshold,
      {{name = "threshold", type = "number", displaytype = "slider", default = 128, min = 0, max = 255}}},
    {"Auto Threshold", il.iterativeBinaryThreshold},
    {"Adaptive Threshold", il.adaptiveThreshold,
      {{name = "width", type = "number", displaytype = "spin", default = 15, min = 3, max = 65}}},
    {"Connected Components", il.connComp,
      {{name = "epsilon", type = "number", displaytype = "spin", default = 16, min = 0, max = 128}}},
    {"Size Filter", il.sizeFilter,
      {{name = "epsilon", type = "number", displaytype = "spin", default = 16, min = 0, max = 128},
       {name = "thresh", type = "number", displaytype = "spin", default = 100, min = 0, max = 16000000}}},
    {"Chamfer 3-4 DT", il.chamfer34},
    {"Contours", il.contours,
      {{name = "interval", type = "number", displaytype = "spin", default = 32, min = 1, max = 128}}},
    {"Add Contours", il.addContours,
      {{name = "interval", type = "number", displaytype = "spin", default = 32, min = 1, max = 128}}},
  }
)

imageMenu("Misc",
  {
    {"Resize", il.rescale,
      {{name = "rows", type = "number", displaytype = "spin", default = 1024, min = 1, max = 16384},
       {name = "cols", type = "number", displaytype = "spin", default = 1024, min = 1, max = 16384}, cmarg3}},
    {"Rotate", il.rotate,
      {{name = "theta", type = "number", displaytype = "slider", default = 0, min = -360, max = 360}, cmarg3}},
    {"Stat Diff", il.statDiff,
      {{name = "width", type = "number", displaytype = "spin", default = 3, min = 0, max = 65},
       {name = "k", type = "number", displaytype = "textbox", default = "1.0"}}},
    {"Impulse Noise", il.impulseNoise,
      {{name = "probability", type = "number", displaytype = "slider", default = 64, min = 0, max = 1000}}},
    {"White (salt) Noise", il.whiteNoise,
      {{name = "probability", type = "number", displaytype = "slider", default = 64, min = 0, max = 1000}}},
    {"Black (pepper) Noise", il.blackNoise,
      {{name = "probability", type = "number", displaytype = "slider", default = 64, min = 0, max = 1000}}},
    {"Gaussian noise", il.gaussianNoise,
      {{name = "sigma", type = "number", displaytype = "textbox", default = "16.0"}}},
    {"Add", il.add, {{name = "image", type = "image"}}},
    {"Subtract", il.sub, {{name = "image", type = "image"}}},
  }
)

imageMenu("Help",
  {
    {"Help", viz.imageMessage( "Help", "Abandon all hope, ye who enter here..." )},
    {"About", viz.imageMessage( "LuaIP Demo " .. viz.VERSION, "Authors: JMW and AI\nClass: CSC442/542 Digital Image Processing\nDate: Spring 2017" )},
    {"Debug Console", viz.imageDebug},
  }
)

start()
