---------------------------
--EuDislin
--Written by Andy P.
--Icy Viking Software
--Copyright (c) 2025
---------------------------
include std/machine.e
include std/ffi.e
include std/os.e

public atom dis

ifdef WINDOWS then
	dis = open_dll("dislnc.dll")
	elsifdef LINUX or FREEBSD then
		dis = open_dll("libdislnc.so")
		elsifdef OSX then
		dis = open_dll("libdislinc.dylib")
end ifdef

if dis = 0 then
	puts(1,"Failed to load dislin!\n")
	abort(0)
end if

public constant SYMBOL_EMPTY = -1,
				SYMBOL_SQUARE = 0,
				SYMBOL_OCTAGON = 1,
				SYMBOL_TRIANGLE_UP = 2,
				SYMBOL_PLUS = 3,
				SYMBOL_CROSS = 4,
				SYMBOL_DIAMOND = 5,
				SYMBOL_TRIANGLE_DOWN = 6,
				SYMBOL_SQUARECROSS = 7,
				SYMBOL_STAR = 8,
				SYMBOL_DIAMONDPLUS = 9,
				SYMBOL_OCTAGONPLUS = 10,
				SYMBOL_DOUBLETRIANGLE = 11,
				SYMBOL_SQUAREPLUS = 12,
				SYMBOL_OCTAGONCROSS = 13,
				SYMBOL_SQUARETRIANGLE = 14,
				SYMBOL_CIRCLE = 15,
				SYMBOL_SQUARE_FILLED = 16,
				SYMBOL_OCTAGON_FILLED = 17,
				SYMBOL_TRIANGLE_UP_FILLED = 18,
				SYMBOL_DIMAOND_FILLED = 19,
				SYMBOL_TRIANGLE_DOWN_FILLED = 20,
				SYMBOL_CIRCLE_FILLED = 21,
				SYMBOL_DOT = 21,
				SYMBOL_HALFCIRCLE = 22,
				SYMBOL_HALFCIRCLE_FILLED = 23
				
public constant LINE_NONE = -1,
				LINE_SOLID = 0,
				LINE_DOT = 1,
				LINE_DASH = 2,
				LINE_CHNDSH = 3,
				LINE_CHNDOT = 4,
				LINE_DASHM = 5,
				LINE_DOTL = 6,
				LINE_DASHL = 7
				
public constant SHADING_NONE = -1,
				SHADING_EMPTY = 0,
				SHADING_LINES = 1,
				SHADING_LINES_BOLD = 4,
				SHADING_GRID = 10,
				SHADING_GRID_BOLD = 14,
				SHADING_FILLED = 16,
				SHADING_DOTS = 17
				
public constant xabs3pt = define_c_proc(dis,"+abs3pt",{C_FLOAT,C_FLOAT,C_FLOAT,C_POINTER,C_POINTER})

public procedure abs3pt(atom x,atom y,atom xp,atom yp)
	c_proc(xabs3pt,{x,y,xp,yp})
end procedure

public constant xaddlab = define_c_proc(dis,"+addlab",{C_STRING,C_FLOAT,C_INT,C_STRING})

public procedure addlab(sequence cstr,atom v,atom itic,sequence cax)
	c_proc(xaddlab,{cstr,v,itic,cax})
end procedure

public constant xangle = define_c_proc(dis,"+angle",{C_INT})

public procedure angle(atom ngrad)
	c_proc(xangle,{ngrad})
end procedure

public constant xarcell = define_c_proc(dis,"+arcell",{C_INT,C_INT,C_INT,C_INT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure arcell(atom nx,atom ny,atom na,atom nb,atom a,atom b,atom t)
	c_proc(xarcell,{nx,ny,na,nb,a,b,t})
end procedure

public constant xareaf = define_c_proc(dis,"+areaf",{C_POINTER,C_POINTER,C_INT})

public procedure areaf(atom nxray,atom nyray,atom n)
	c_proc(xareaf,{nxray,nyray,n})
end procedure

public constant xautres = define_c_proc(dis,"+autres",{C_INT,C_INT})

public procedure autres(atom ixdim,atom iydim)
	c_proc(xautres,{ixdim,iydim})
end procedure

public constant xautres3d = define_c_proc(dis,"+autres3d",{C_INT,C_INT,C_INT})

public procedure autres3d(atom ixdim,atom iydim,atom izdim)
	c_proc(xautres3d,{ixdim,iydim,izdim})
end procedure

public constant xax2grf = define_c_proc(dis,"+ax2grf",{})

public procedure ax2grf()
	c_proc(xax2grf,{})
end procedure

public constant xax3len = define_c_proc(dis,"+ax3len",{C_INT,C_INT,C_INT})

public procedure ax3len(atom nxl,atom nyl,atom nzl)
	c_proc(xax3len,{nxl,nyl,nzl})
end procedure

public constant xaxclrs = define_c_proc(dis,"+axclrs",{C_INT,C_STRING,C_STRING})

public procedure axclrs(atom nclr,sequence copt,sequence cax)
	c_proc(xaxclrs,{nclr,copt,cax})
end procedure

public constant xaxends = define_c_proc(dis,"+axends",{C_STRING,C_STRING})

public procedure axends(sequence cstr,sequence cax)
	c_proc(xaxends,{cstr,cax})
end procedure

public constant _axgit = define_c_proc(dis,"+axgit",{})

public procedure axgit()
	c_proc(_axgit,{})
end procedure

public constant xaxis3d = define_c_proc(dis,"+axis3d",{C_FLOAT,C_FLOAT,C_FLOAT})

public procedure axis3d(atom x3,atom y3,atom z3)
	c_proc(xaxis3d,{x3,y3,z3})
end procedure

public constant xaxsbgd = define_c_proc(dis,"+axsbgd",{C_INT})

public procedure axsbgd(atom nclr)
	c_proc(xaxsbgd,{nclr})
end procedure

public constant xaxsers = define_c_proc(dis,"+axsers",{})

public procedure axsers()
	c_proc(xaxsers,{})
end procedure

public constant xaxslen = define_c_proc(dis,"+axslen",{C_INT,C_INT})

public procedure axslen(atom nxl,atom nyl)
	c_proc(xaxslen,{nxl,nyl})
end procedure

public constant xaxsorg = define_c_proc(dis,"+axsorg",{C_INT,C_INT})

public procedure axsorg(atom nxa,atom nya)
	c_proc(xaxsorg,{nxa,nya})
end procedure

public constant xaxspos = define_c_proc(dis,"+axspos",{C_INT,C_INT})

public procedure axspos(atom nxa,atom nya)
	c_proc(xaxspos,{nxa,nya})
end procedure

public constant xaxsscl = define_c_proc(dis,"+axsscl",{C_STRING,C_STRING})

public procedure axsscl(sequence cscl,sequence cax)
	c_proc(xaxsscl,{cscl,cax})
end procedure

public constant xaxstyp = define_c_proc(dis,"+axstyp",{C_STRING})

public procedure axstyp(sequence copt)
	c_proc(xaxstyp,{copt})
end procedure

public constant xbarbor = define_c_proc(dis,"+barbor",{C_INT})

public procedure barbor(atom iclr)
	c_proc(xbarbor,{iclr})
end procedure

public constant xbarclr = define_c_proc(dis,"+barclr",{C_INT,C_INT,C_INT})

public procedure barclr(atom ic1,atom ic2,atom ic3)
	c_proc(xbarclr,{ic1,ic2,ic3})
end procedure

public constant xbarmod = define_c_proc(dis,"+barmod",{C_STRING,C_STRING})

public procedure barmod(sequence cmod,sequence copt)
	c_proc(xbarmod,{cmod,copt})
end procedure

public constant xbaropt = define_c_proc(dis,"+baropt",{C_FLOAT,C_FLOAT})

public procedure baropt(atom xf,atom a)
	c_proc(xbaropt,{xf,a})
end procedure

public constant xbarpos = define_c_proc(dis,"+barpos",{C_STRING})

public procedure barpos(sequence copt)
	c_proc(xbarpos,{copt})
end procedure

public constant xbars = define_c_proc(dis,"+bars",{C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure bars(atom xray,atom y1ray,atom y2ray,atom n)
	c_proc(xbars,{xray,y1ray,y2ray,n})
end procedure

public constant xbars3d = define_c_proc(dis,"+bars3d",{C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure bars3d(atom xray,atom yray,atom z1ray,atom z2ray,atom xwray,atom ywray,atom icray,atom n)
	c_proc(xbars3d,{xray,yray,z1ray,z2ray,xwray,ywray,icray,n})
end procedure

public constant xbartyp = define_c_proc(dis,"+bartyp",{C_STRING})

public procedure bartyp(sequence ctyp)
	c_proc(xbartyp,{ctyp})
end procedure

public constant xbarwth = define_c_proc(dis,"+barwth",{C_FLOAT})

public procedure barwth(atom factor)
	c_proc(xbarwth,{factor})
end procedure

public constant xbasalf = define_c_proc(dis,"+basalf",{C_STRING})

public procedure basalf(sequence calph)
	c_proc(xbasalf,{calph})
end procedure

public constant xbasdat = define_c_proc(dis,"+basdat",{C_INT,C_INT,C_INT})

public procedure basdat(atom id,atom im,atom iy)
	c_proc(xbasdat,{id,im,iy})
end procedure

public constant xbezier = define_c_proc(dis,"+bezier",{C_POINTER,C_POINTER,C_INT,C_POINTER,C_POINTER,C_INT})

public procedure bezier(atom xray,atom yray,atom nray,atom x,atom y,atom n)
	c_proc(xbezier,{xray,yray,nray,x,y,n})
end procedure

public constant xbitsi2 = define_c_proc(dis,"+bitsi2",{C_INT,C_SHORT,C_INT,C_SHORT,C_INT})

public procedure bitsi2(atom nbits,atom mher,atom iher,atom mhin,atom ihin)
	c_proc(xbitsi2,{nbits,mher,iher,mhin,ihin})
end procedure

public constant xbitsi4 = define_c_proc(dis,"+bitsi4",{C_INT,C_INT,C_INT,C_INT,C_INT})

public procedure bitsi4(atom nbits,atom mher,atom iher,atom mhin,atom ihin)
	c_proc(xbitsi4,{nbits,mher,iher,mhin,ihin})
end procedure

public constant xbmpfnt = define_c_proc(dis,"+bmpfnt",{C_STRING})

public procedure bmpfnt(sequence copt)
	c_proc(xbmpfnt,{copt})
end procedure

public constant xbmpmod = define_c_proc(dis,"+bmpmod",{C_INT,C_STRING,C_STRING})

public procedure bmpmod(atom n,sequence cval,sequence copt)
	c_proc(xbmpmod,{n,cval,copt})
end procedure

public constant xbox2d = define_c_proc(dis,"+box2d",{})

public procedure box2d()
	c_proc(xbox2d,{})
end procedure

public constant xbox3d = define_c_proc(dis,"+box3d",{})

public procedure box3d()
	c_proc(xbox3d,{})
end procedure

public constant xbufmod = define_c_proc(dis,"+bufmod",{C_STRING,C_STRING})

public procedure bufmod(sequence cmod,sequence ckey)
	c_proc(xbufmod,{cmod,ckey})
end procedure

public constant xcenter = define_c_proc(dis,"+center",{})

public procedure center()
	c_proc(xcenter,{})
end procedure

public constant xcgmbgd = define_c_proc(dis,"+cgmbgd",{C_FLOAT,C_FLOAT,C_FLOAT})

public procedure cgmbgd(atom xr,atom xg,atom xb)
	c_proc(xcgmbgd,{xr,xg,xb})
end procedure

public constant xcgmpic = define_c_proc(dis,"+cgmpic",{C_STRING})

public procedure cgmpic(sequence cstr)
	c_proc(xcgmpic,{cstr})
end procedure

public constant xcgmver = define_c_proc(dis,"+cgmver",{C_INT})

public procedure cgmver(atom nclr)
	c_proc(xcgmver,{nclr})
end procedure

public constant xchaang = define_c_proc(dis,"+chaang",{C_FLOAT})

public procedure chaang(atom angle)
	c_proc(xchaang,{angle})
end procedure

public constant xchacod = define_c_proc(dis,"+chacod",{C_STRING})

public procedure chacod(sequence copt)
	c_proc(xchacod,{copt})
end procedure

public constant xchaspc = define_c_proc(dis,"+chaspc",{C_FLOAT})

public procedure chaspc(atom xspc)
	c_proc(xchaspc,{xspc})
end procedure

public constant xchawth = define_c_proc(dis,"+chawth",{C_FLOAT})

public procedure chawth(atom xwth)
	c_proc(xchawth,{xwth})
end procedure

public constant xchnatt = define_c_proc(dis,"+chnatt",{})

public procedure chnatt()
	c_proc(xchnatt,{})
end procedure

public constant xchncrv = define_c_proc(dis,"+chncrv",{C_STRING})

public procedure chncrv(sequence copt)
	c_proc(xchncrv,{copt})
end procedure

public constant xchndot = define_c_proc(dis,"+chndot",{})

public procedure chndot()
	c_proc(xchndot,{})	
end procedure

public constant xchndsh = define_c_proc(dis,"+chndsh",{})

public procedure chndsh()
	c_proc(xchndsh,{})
end procedure

public constant xchnbar = define_c_proc(dis,"+chnbar",{C_STRING})

public procedure chnbar(sequence copt)
	c_proc(xchnbar,{copt})
end procedure

public constant xchnpie = define_c_proc(dis,"+chnpie",{C_STRING})

public procedure chnpie(sequence copt)
	c_proc(xchnpie,{copt})
end procedure

public constant xcirc3p = define_c_proc(dis,"+circ3p",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_POINTER,C_POINTER,C_POINTER})

public procedure circ3p(atom x1,atom y1,atom x2,atom y2,atom x3,atom y3,atom xm,atom ym,atom r)
	c_proc(xcirc3p,{x1,y1,x2,y2,x3,y3,xm,ym,r})
end procedure

public constant xcircle = define_c_proc(dis,"+circle",{C_INT,C_INT,C_INT})

public procedure circle(atom nx,atom ny,atom nr)
	c_proc(xcircle,{nx,ny,nr})
end procedure

public constant xcircsp = define_c_proc(dis,"+circsp",{C_INT})

public procedure circsp(atom nspc)
	c_proc(xcircsp,{nspc})
end procedure

public constant xclip3d = define_c_proc(dis,"+clip3d",{C_STRING})

public procedure clip3d(sequence ctyp)
	c_proc(xclip3d,{ctyp})
end procedure

public constant xclosfl = define_c_func(dis,"+closfl",{C_INT},C_INT)

public function closfl(atom nu)
	return c_func(xclosfl,{nu})
end function

public constant xclpbor = define_c_proc(dis,"+clpbor",{C_STRING})

public procedure clpbor(sequence copt)
	c_proc(xclpbor,{copt})
end procedure

public constant xclpmod = define_c_proc(dis,"+clpmod",{C_STRING})

public procedure clpmod(sequence copt)
	c_proc(xclpmod,{copt})
end procedure

public constant xclpwin = define_c_proc(dis,"+clpwin",{C_INT,C_INT,C_INT,C_INT})

public procedure clpwin(atom nx,atom ny,atom nw,atom nh)
	c_proc(xclpwin,{nx,ny,nw,nh})
end procedure

public constant xclrcyc = define_c_proc(dis,"+clrcyc",{C_INT,C_INT})

public procedure clrcyc(atom index,atom iclr)
	c_proc(xclrcyc,{index,iclr})
end procedure

public constant xclrmod = define_c_proc(dis,"+clrmod",{C_STRING})

public procedure clrmod(sequence cmode)
	c_proc(xclrmod,{cmode})
end procedure

public constant xclswin = define_c_proc(dis,"+clswin",{C_INT})

public procedure clswin(atom id)
	c_proc(xclswin,{id})
end procedure

public constant xcolor = define_c_proc(dis,"+color",{C_STRING})

public procedure color(sequence col)
	c_proc(xcolor,{col})
end procedure

public constant xcolran = define_c_proc(dis,"+colran",{C_INT,C_INT})

public procedure colran(atom nca,atom nce)
	c_proc(xcolran,{nca,nce})
end procedure

public constant xcolray = define_c_proc(dis,"+colray",{C_POINTER,C_POINTER,C_INT})

public procedure colray(atom zray,atom nray,atom n)
	c_proc(xcolray,{zray,nray,n})
end procedure

public constant xcomplx = define_c_proc(dis,"+complx",{})

public procedure complx()
	c_proc(xcomplx,{})
end procedure

public constant xconclr = define_c_proc(dis,"+conclr",{C_POINTER,C_INT})

public procedure conclr(atom nray,atom n)
	c_proc(xconclr,{nray,n})
end procedure

public constant xconcrv = define_c_proc(dis,"+concrv",{C_POINTER,C_POINTER,C_INT,C_FLOAT})

public procedure concrv(atom xray,atom yray,atom n,atom zlev)
	c_proc(xconcrv,{xray,yray,n,zlev})
end procedure

public constant xcone3d = define_c_proc(dis,"+cone3d",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,C_INT})

public procedure cone3d(atom xm,atom ym,atom zm,atom r,atom h1,atom h2,atom nsk1,atom nsk2)
	c_proc(xcone3d,{xm,ym,zm,r,h1,h2,nsk1,nsk2})
end procedure

public constant xconfll = define_c_proc(dis,"+confll",{C_POINTER,C_POINTER,C_POINTER,C_INT,C_POINTER,C_POINTER,C_POINTER,C_INT,C_POINTER,C_INT})

public procedure confll(atom xray,atom yray,atom zray,atom n,atom i1ray,atom i2ray,atom i3ray,atom ntri,atom zlev,atom nlev)
	c_proc(xconfll,{xray,yray,zray,n,i1ray,i2ray,i3ray,ntri,zlev,nlev})
end procedure

public constant xcongap = define_c_proc(dis,"+congap",{C_FLOAT})

public procedure congap(atom xfac)
	c_proc(xcongap,{xfac})
end procedure

public constant xconlab = define_c_proc(dis,"+conlab",{C_STRING})

public procedure conlab(sequence clab)
	c_proc(xconlab,{clab})
end procedure

public constant xconmat = define_c_proc(dis,"+conmat",{C_POINTER,C_INT,C_INT,C_FLOAT})

public procedure conmat(atom zmat,atom n,atom m,atom zlev)
	c_proc(xconmat,{zmat,n,m,zlev})
end procedure

public constant xconmod = define_c_proc(dis,"+conmod",{C_FLOAT,C_FLOAT})

public procedure conmod(atom xfac,atom xquot)
	c_proc(xconmod,{xfac,xquot})
end procedure

public constant xconn3d = define_c_proc(dis,"+conn3d",{C_FLOAT,C_FLOAT,C_FLOAT})

public procedure conn3d(atom x,atom y,atom z)
	c_proc(xconn3d,{x,y,z})
end procedure

public constant xconnpt = define_c_proc(dis,"+connpt",{C_FLOAT,C_FLOAT})

public procedure connpt(atom x,atom y)
	c_proc(xconnpt,{x,y})
end procedure

public constant xconpts = define_c_proc(dis,"+conpts",{C_POINTER,C_INT,C_POINTER,C_INT,C_POINTER,C_FLOAT,C_POINTER,C_POINTER,C_INT,C_POINTER,C_INT,C_POINTER})

public procedure conpts(atom xray,atom n,atom yray,atom m,atom zmat,atom zlev,atom xpts,atom ypts,atom maxpts,atom nray,atom maxray,atom nlins)
	c_proc(xconpts,{xray,n,yray,m,zmat,zlev,xpts,ypts,maxpts,nray,maxray,nlins})
end procedure

public constant xconshd = define_c_proc(dis,"+conshd",{C_POINTER,C_INT,C_POINTER,C_INT,C_POINTER,C_POINTER,C_INT})

public procedure conshd(atom xray,atom n,atom yray,atom m,atom zmat,atom zlev,atom nlev)
	c_proc(xconshd,{xray,n,yray,m,zmat,zlev,nlev})
end procedure

public constant xconshd2 = define_c_proc(dis,"+conshd2",{C_POINTER,C_POINTER,C_POINTER,C_INT,C_INT,C_POINTER,C_INT})

public procedure conshd2(atom xmat,atom ymat,atom zmat,atom n,atom m,atom zlev,atom nlev)
	c_proc(xconshd2,{xmat,ymat,zmat,n,m,zlev,nlev})
end procedure

public constant xconshd3d = define_c_proc(dis,"+conshd3d",{C_POINTER,C_INT,C_POINTER,C_INT,C_POINTER,C_POINTER,C_INT})

public procedure conshd3d(atom xray,atom n,atom yray,atom m,atom zmat,atom zlev,atom nlev)
	c_proc(xconshd3d,{xray,n,yray,m,zmat,zlev,nlev})
end procedure

public constant xcontri = define_c_proc(dis,"+contri",{C_POINTER,C_POINTER,C_POINTER,C_INT,C_POINTER,C_POINTER,C_POINTER,C_INT,C_FLOAT})

public procedure contri(atom xray,atom yray,atom zray,atom n,atom i1ray,atom i2ray,atom i3ray,atom ntri,atom zlev)
	c_proc(xcontri,{xray,yray,zray,n,i1ray,i2ray,i3ray,ntri,zlev})
end procedure

public constant xcontur = define_c_proc(dis,"+contur",{C_POINTER,C_INT,C_POINTER,C_INT,C_POINTER,C_FLOAT})

public procedure contur(atom xray,atom n,atom yray,atom m,atom zmat,atom zlev)
	c_proc(xcontur,{xray,n,yray,m,zmat,zlev})
end procedure

public constant xcontur2 = define_c_proc(dis,"+contur2",{C_POINTER,C_POINTER,C_POINTER,C_INT,C_INT,C_FLOAT})

public procedure contur2(atom xmat,atom ymat,atom zmat,atom n,atom m,atom zlev)
	c_proc(xcontur2,{xmat,ymat,zmat,n,m,zlev})
end procedure

public constant _cross = define_c_proc(dis,"+cross",{})

public procedure cross()
	c_proc(_cross,{})
end procedure

public constant xcrvmat = define_c_proc(dis,"+crvmat",{C_POINTER,C_INT,C_INT,C_INT,C_INT})

public procedure crvmat(atom zmat,atom n,atom m,atom ixpts,atom iypts)
	c_proc(xcrvmat,{zmat,n,m,ixpts,iypts})
end procedure

public constant xcrvqdr = define_c_proc(dis,"+crvqdr",{C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure crvqdr(atom xray,atom yray,atom zray,atom n)
	c_proc(xcrvqdr,{xray,yray,zray,n})
end procedure

public constant xcrvt3d = define_c_proc(dis,"+crvt3d",{C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure crvt3d(atom xray,atom yray,atom zray,atom rray,atom icray,atom n)
	c_proc(xcrvt3d,{xray,yray,zray,rray,icray,n})
end procedure

public constant xcrvtri = define_c_proc(dis,"+crvtri",{C_POINTER,C_POINTER,C_POINTER,C_INT,C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure crvtri(atom xray,atom yray,atom zray,atom n,atom i1ray,atom i2ray,atom i3ray,atom ntri)
	c_proc(xcrvtri,{xray,yray,zray,n,i1ray,i2ray,i3ray,ntri})
end procedure

public constant xcsrkey = define_c_func(dis,"+csrkey",{},C_INT)

public function csrkey()
	return c_func(xcsrkey,{})
end function

public constant xcsrmod = define_c_proc(dis,"+csrmod",{C_STRING,C_STRING})

public procedure csrmod(sequence cmod,sequence ckey)
	c_proc(xcsrmod,{cmod,ckey})
end procedure

public constant xcsrpol = define_c_proc(dis,"+csrpol",{C_POINTER,C_POINTER,C_INT,C_POINTER,C_POINTER})

public procedure csrpol(atom ix,atom iy,atom nmax,atom n,atom iret)
	c_proc(xcsrpol,{ix,iy,nmax,n,iret})
end procedure

public constant xcsrpos = define_c_func(dis,"+csrpos",{C_POINTER,C_POINTER},C_INT)

public function csrpos(atom ix,atom iy)
	return c_func(xcsrpos,{ix,iy})
end function

public constant xcsrpt1 = define_c_proc(dis,"+csrpt1",{C_POINTER,C_POINTER})

public procedure csrpt1(atom ix,atom iy)
	c_proc(xcsrpt1,{ix,iy})
end procedure

public constant xcsrpts = define_c_proc(dis,"+csrpts",{C_POINTER,C_POINTER,C_INT,C_POINTER,C_POINTER})

public procedure csrpts(atom ix,atom iy,atom nmax,atom n,atom iret)
	c_proc(xcsrpts,{ix,iy,nmax,n,iret})
end procedure

public constant xcsrmov = define_c_proc(dis,"+csrmov",{C_POINTER,C_POINTER,C_INT,C_POINTER,C_POINTER})

public procedure csrmov(atom ix,atom iy,atom nmax,atom n,atom iret)
	c_proc(xcsrmov,{ix,iy,nmax,n,iret})
end procedure

public constant xcsrrec = define_c_proc(dis,"+csrrec",{C_POINTER,C_POINTER,C_POINTER,C_POINTER})

public procedure csrrec(atom ix1,atom iy1,atom ix2,atom iy2)
	c_proc(xcsrrec,{ix1,iy1,ix2,iy2})
end procedure

public constant xcsrtyp = define_c_proc(dis,"+csrtyp",{C_STRING})

public procedure csrtyp(sequence copt)
	c_proc(xcsrtyp,{copt})
end procedure

public constant xcsruni = define_c_proc(dis,"+csruni",{C_STRING})

public procedure csruni(sequence copt)
	c_proc(xcsruni,{copt})
end procedure

public constant xcurv3d = define_c_proc(dis,"+curv3d",{C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure curv3d(atom xray,atom yray,atom zray,atom n)
	c_proc(xcurv3d,{xray,yray,zray,n})
end procedure

public constant xcurv4d = define_c_proc(dis,"+curv4d",{C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure curv4d(atom xray,atom yray,atom zray,atom wray,atom n)
	c_proc(xcurv4d,{xray,yray,zray,wray,n})
end procedure

public constant xcurve = define_c_proc(dis,"+curve",{C_POINTER,C_POINTER,C_INT})

public procedure curve(atom xray,atom yray,atom n)
	c_proc(xcurve,{xray,yray,n})
end procedure

public constant xcurve3 = define_c_proc(dis,"+curve3",{C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure curve3(atom xray,atom yray,atom zray,atom n)
	c_proc(xcurve3,{xray,yray,zray,n})
end procedure

public constant xcurvmp = define_c_proc(dis,"+curvmp",{C_POINTER,C_POINTER,C_INT})

public procedure curvmp(atom xray,atom yray,atom n)
	c_proc(xcurvmp,{xray,yray,n})
end procedure

public constant xcurvx3 = define_c_proc(dis,"+curvx3",{C_POINTER,C_FLOAT,C_POINTER,C_INT})

public procedure curvx3(atom xray,atom y,atom zray,atom n)
	c_proc(xcurvx3,{xray,y,zray,n})
end procedure

public constant xcurvy3 = define_c_proc(dis,"+curvy3",{C_FLOAT,C_POINTER,C_POINTER,C_INT})

public procedure curvy3(atom x,atom yray,atom zray,atom n)
	c_proc(xcurvy3,{x,yray,zray,n})
end procedure

public constant xcyli3d = define_c_proc(dis,"+cyli3d",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,C_INT})

public procedure cyli3d(atom xm,atom ym,atom zm,atom r,atom h,atom nsk1,atom nsk2)
	c_proc(xcyli3d,{xm,ym,zm,r,h,nsk1,nsk2})
end procedure

public constant xdash = define_c_proc(dis,"+dash",{})

public procedure dash()
	c_proc(xdash,{})
end procedure

public constant xdashl = define_c_proc(dis,"+dashl",{})

public procedure dashl()
	c_proc(xdashl,{})
end procedure

public constant xdashm = define_c_proc(dis,"+dashm",{})

public procedure dashm()
	c_proc(xdashm,{})
end procedure

public constant xdbffin = define_c_proc(dis,"+dbffin",{})

public procedure dbffin()
	c_proc(xdbffin,{})
end procedure

public constant xdbfini = define_c_func(dis,"+dbfini",{},C_INT)

public function dbfini()
	return c_func(xdbfini,{})
end function

public constant xdbfmod = define_c_proc(dis,"+dbfmod",{C_STRING})

public procedure dbfmod(sequence copt)
	c_proc(xdbfmod,{copt})
end procedure

public constant xdelglb = define_c_proc(dis,"+delglb",{})

public procedure delglb()
	c_proc(xdelglb,{})
end procedure

public constant xdigits = define_c_proc(dis,"+digits",{C_INT,C_STRING})

public procedure digits(atom ndig,sequence cax)
	c_proc(xdigits,{ndig,cax})
end procedure

public constant xdisalf = define_c_proc(dis,"+disalf",{})

public procedure disalf()
	c_proc(xdisalf,{})
end procedure

public constant xdisenv = define_c_proc(dis,"+disenv",{C_STRING})

public procedure disenv(sequence cenv)
	c_proc(xdisenv,{cenv})
end procedure

public constant xdisfin = define_c_proc(dis,"+disfin",{})

public procedure disfin()
	c_proc(xdisfin,{})
end procedure

public constant xdisini = define_c_proc(dis,"+disini",{})

public procedure disini()
	c_proc(xdisini,{})
end procedure

public constant xdisk3d = define_c_proc(dis,"+disk3d",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,C_INT})

public procedure disk3d(atom xm,atom ym,atom zm,atom r1,atom r2,atom nsk1,atom nsk2)
	c_proc(xdisk3d,{xm,ym,zm,r1,r2,nsk1,nsk2})
end procedure

public constant xdoevnt = define_c_proc(dis,"+doevnt",{})

public procedure doevnt()
	c_proc(xdoevnt,{})
end procedure

public constant xdot = define_c_proc(dis,"+dot",{})

public procedure dot()
	c_proc(xdot,{})
end procedure

public constant xdotl = define_c_proc(dis,"+dotl",{})

public procedure dotl()
	c_proc(xdotl,{})
end procedure

public constant xduplx = define_c_proc(dis,"+duplx",{})

public procedure duplx()
	c_proc(xduplx,{})
end procedure

public constant xdwgbut = define_c_func(dis,"+dwgbut",{C_STRING,C_INT},C_INT)

public function dwgbut(sequence cstr,atom ival)
	return c_func(xdwgbut,{cstr,ival})
end function

public constant xdwgerr = define_c_func(dis,"+dwgerr",{},C_INT)

public function dwgerr()
	return c_func(xdwgerr,{})
end function

public constant xdwgfil = define_c_func(dis,"+dwgfil",{C_STRING,C_STRING,C_STRING},C_POINTER)

public function dwgfil(sequence clab,sequence cstr,sequence cmask)
	return c_func(xdwgfil,{clab,cstr,cmask})
end function

public constant xdwglis = define_c_func(dis,"+dwglis",{C_STRING,C_STRING,C_INT},C_INT)

public function dwglis(sequence clab,sequence clis,atom ilis)
	return c_func(xdwglis,{clab,clis,ilis})
end function

public constant xdwgmsg = define_c_proc(dis,"+dwgmsg",{C_STRING})

public procedure dwgmsg(sequence cstr)
	c_proc(xdwgmsg,{cstr})
end procedure

public constant xdwgtxt = define_c_func(dis,"+dwgtxt",{C_STRING,C_STRING},C_POINTER)

public function dwgtxt(sequence clab,sequence cstr)
	return c_func(xdwgtxt,{clab,cstr})
end function

public constant xellips = define_c_proc(dis,"+ellips",{C_INT,C_INT,C_INT,C_INT})

public procedure ellips(atom nx,atom ny,atom na,atom nb)
	c_proc(xellips,{nx,ny,na,nb})
end procedure

public constant xendgrf = define_c_proc(dis,"+endgrf",{})

public procedure endgrf()
	c_proc(xendgrf,{})
end procedure

public constant xerase = define_c_proc(dis,"+erase",{})

public procedure erase()
	c_proc(xerase,{})
end procedure

public constant xerrbar = define_c_proc(dis,"+errbar",{C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure errbar(atom x,atom y,atom err1,atom err2,atom n)
	c_proc(xerrbar,{x,y,err1,err2,n})
end procedure

public constant xerrdev = define_c_proc(dis,"+errdev",{C_STRING})

public procedure errdev(sequence cdev)
	c_proc(xerrdev,{cdev})
end procedure

public constant xerrfil = define_c_proc(dis,"+errfil",{C_STRING})

public procedure errfil(sequence cfil)
	c_proc(xerrfil,{cfil})
end procedure

public constant xerrmod = define_c_proc(dis,"+errmod",{C_STRING,C_STRING})

public procedure errmod(sequence cstr,sequence copt)
	c_proc(xerrmod,{cstr,copt})
end procedure

public constant xeushft = define_c_proc(dis,"+eushft",{C_STRING,C_STRING})

public procedure eushft(sequence cnat,sequence cshf)
	c_proc(xeushft,{cnat,cshf})
end procedure

public constant xexpimg = define_c_proc(dis,"+expimg",{C_STRING,C_STRING})

public procedure expimg(sequence cfil,sequence copt)
	c_proc(xexpimg,{cfil,copt})
end procedure

public constant xexpzlb = define_c_proc(dis,"+expzlb",{C_STRING})

public procedure expzlb(sequence cstr)
	c_proc(xexpzlb,{cstr})
end procedure

public constant xfbars = define_c_proc(dis,"+fbars",{C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure fbars(atom xray,atom y1ray,atom y2ray,atom y3ray,atom y4ray,atom n)
	c_proc(xfbars,{xray,y1ray,y2ray,y3ray,y4ray,n})
end procedure

public constant xfcha = define_c_func(dis,"+fcha",{C_FLOAT,C_INT,C_POINTER},C_INT)

public function fcha(atom x,atom ndig,sequence cstr)

 atom str = allocate_string(cstr,1)
 
 return c_func(xfcha,{x,ndig,str})
	
end function

public constant xfield = define_c_proc(dis,"+field",{C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_INT,C_INT})

public procedure field(atom xray,atom yray,atom uray,atom vray,atom n,atom ivec)
	c_proc(xfield,{xray,yray,uray,vray,n,ivec})
end procedure

public constant xfield3d = define_c_proc(dis,"+field3d",{C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_INT,C_INT})

public procedure field3d(atom x1ray,atom y1ray,atom z1ray,atom x2ray,atom y2ray,atom z2ray,atom n,atom ivec)
	c_proc(xfield3d,{x1ray,y1ray,z1ray,x2ray,y2ray,z2ray,n,ivec})
end procedure

public constant xfilbox = define_c_proc(dis,"+filbox",{C_INT,C_INT,C_INT,C_INT})

public procedure filbox(atom nx,atom ny,atom nw,atom nh)
	c_proc(xfilbox,{nx,ny,nw,nh})
end procedure

public constant xfilclr = define_c_proc(dis,"+filclr",{C_STRING})

public procedure filclr(sequence copt)
	c_proc(xfilclr,{copt})
end procedure

public constant xfilmod = define_c_proc(dis,"+filmod",{C_STRING})

public procedure filmod(sequence cmod)
	c_proc(xfilmod,{cmod})
end procedure

public constant xfilopt = define_c_proc(dis,"+filopt",{C_STRING,C_STRING})

public procedure filopt(sequence copt,sequence ckey)
	c_proc(xfilopt,{copt,ckey})
end procedure

public constant xfilsiz = define_c_func(dis,"+filsiz",{C_STRING,C_POINTER,C_POINTER},C_INT)

public function filsiz(sequence cfl,atom nw,atom nh)
	return c_func(xfilsiz,{cfl,nw,nh})
end function

public constant xfiltyp = define_c_func(dis,"+filtyp",{C_STRING},C_INT)

public function filtyp(sequence cfl)
	return c_func(xfiltyp,{cfl})
end function

public constant xfilwin = define_c_proc(dis,"+filwin",{C_INT,C_INT,C_INT,C_INT})

public procedure filwin(atom nx,atom ny,atom nw,atom nh)
	c_proc(xfilwin,{nx,ny,nw,nh})
end procedure

public constant xfitscls = define_c_proc(dis,"+fitscls",{})

public procedure fitscls()
	c_proc(xfitscls,{})
end procedure

public constant xfitsflt = define_c_func(dis,"+fitsflt",{C_STRING},C_FLOAT)

public function fitsflt(sequence ckey)
	return c_func(xfitsflt,{ckey})
end function

public constant xfitshdu = define_c_func(dis,"+fitshdu",{C_INT},C_INT)

public function fitshdu(atom nhdu)
	return c_func(xfitshdu,{nhdu})
end function

public constant xfitsimg = define_c_func(dis,"+fitsimg",{C_POINTER,C_INT},C_INT)

public function fitsimg(atom iray,atom nmax)
	return c_func(xfitsimg,{iray,nmax})
end function

public constant xfitsopn = define_c_func(dis,"+fitsopn",{C_STRING},C_INT)

public function fitsopn(sequence cfl)
	return c_func(xfitsopn,{cfl})
end function

public constant xfitsstr = define_c_proc(dis,"+fitsstr",{C_STRING,C_STRING,C_INT})

public procedure fitsstr(sequence ckey,sequence cval,atom nmax)
	c_proc(xfitsstr,{ckey,cval,nmax})
end procedure

public constant xfitstyp = define_c_func(dis,"+fitstyp",{C_STRING},C_INT)

public function fitstyp(sequence ckey)
	return c_func(xfitstyp,{ckey})
end function

public constant xfitsval = define_c_func(dis,"+fitsval",{C_STRING},C_INT)

public function fitsval(sequence ckey)
	return c_func(xfitsval,{ckey})
end function

public constant xfixspc = define_c_proc(dis,"+fixspc",{C_FLOAT})

public procedure fixspc(atom xfac)
	c_proc(xfixspc,{xfac})
end procedure

public constant xflab3d = define_c_proc(dis,"+flab3d",{})

public procedure flab3d()
	c_proc(xflab3d,{})
end procedure

public constant xflen = define_c_func(dis,"+flen",{C_FLOAT,C_INT},C_INT)

public function flen(atom x,atom ndig)
	return c_func(xflen,{x,ndig})
end function

public constant xframe = define_c_proc(dis,"+frame",{C_INT})

public procedure frame(atom nfrm)
	c_proc(xframe,{nfrm})
end procedure

public constant xfreeptr = define_c_proc(dis,"+freeptr",{C_POINTER})

public procedure freeptr(atom p)
	c_proc(xfreeptr,{p})
end procedure

public constant xfrmbar = define_c_proc(dis,"+frmbar",{C_INT})

public procedure frmbar(atom nfrm)
	c_proc(xfrmbar,{nfrm})
end procedure

public constant xfrmclr = define_c_proc(dis,"+frmclr",{C_INT})

public procedure frmclr(atom nclr)
	c_proc(xfrmclr,{nclr})
end procedure

public constant xfrmess = define_c_proc(dis,"+frmess",{C_INT})

public procedure frmess(atom nfrm)
	c_proc(xfrmess,{nfrm})
end procedure

public constant xgapcrv = define_c_proc(dis,"+gapcrv",{C_FLOAT})

public procedure gapcrv(atom xgap)
	c_proc(xgapcrv,{xgap})
end procedure

public constant xgapsiz = define_c_proc(dis,"+gapsiz",{C_FLOAT,C_STRING})

public procedure gapsiz(atom gap,sequence cax)
	c_proc(xgapsiz,{gap,cax})
end procedure

public constant xgaxpar = define_c_proc(dis,"+gaxpar",{C_FLOAT,C_FLOAT,C_STRING,C_STRING,C_POINTER,C_POINTER,C_POINTER,C_POINTER})

public procedure gaxpar(atom a1,atom a2,sequence copt,sequence cax,atom a,atom b,atom org,atom stop,atom ndig)
	c_proc(xgaxpar,{a1,a2,copt,cax,a,b,org,stop,ndig})
end procedure

public constant xgetalf = define_c_func(dis,"+getalf",{},C_STRING)

public function getalf()
	return c_func(xgetalf,{})
end function

public constant xgetang = define_c_func(dis,"+getang",{},C_INT)

public function getang()
	return c_func(xgetang,{})
end function

public constant xgetbpp = define_c_func(dis,"+getbpp",{},C_INT)

public function getbpp()
	return c_func(xgetbpp,{})
end function

public constant xgetclp = define_c_proc(dis,"+getclp",{C_POINTER,C_POINTER,C_POINTER,C_POINTER})

public procedure getclp(atom nx,atom ny,atom nw,atom nh)
	c_proc(xgetclp,{nx,ny,nw,nh})
end procedure

public constant xgetclr = define_c_func(dis,"+getclr",{},C_INT)

public function getclr()
	return c_func(xgetclr,{})
end function

public constant xgetdig = define_c_proc(dis,"+getdig",{C_POINTER,C_POINTER,C_POINTER})

public procedure getdig(atom nxdig,atom nydig,atom nzdig)
	c_proc(xgetdig,{nxdig,nydig,nzdig})
end procedure

public constant xgetdsp = define_c_func(dis,"+getdsp",{},C_POINTER)

public function getdsp()
	return c_func(xgetdsp,{})
end function

public constant xgetfil = define_c_func(dis,"+getfil",{},C_POINTER)

public function getfil()
	return c_func(xgetfil,{})
end function

public constant xgetgrf = define_c_proc(dis,"+getgrf",{C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_STRING})

public procedure getgrf(atom a,atom e,atom org,atom step,sequence cax)
	c_proc(xgetgrf,{a,e,org,step,cax})
end procedure

public constant xgethgt = define_c_func(dis,"+gethgt",{},C_INT)

public function gethgt()
	return c_func(xgethgt,{})
end function

public constant xgethnm = define_c_func(dis,"+gethnm",{},C_INT)

public function gethnm()
	return c_func(xgethnm,{})
end function

public constant xgetico = define_c_proc(dis,"+getico",{C_FLOAT,C_FLOAT,C_POINTER,C_POINTER})

public procedure getico(atom rre,atom rimg,atom zre,atom zimg)
	c_proc(xgetico,{rre,rimg,zre,zimg})
end procedure

public constant xgetind = define_c_proc(dis,"+getind",{C_INT,C_POINTER,C_POINTER,C_POINTER})

public procedure getind(atom index,atom xr,atom xg,atom xb)
	c_proc(xgetind,{index,xr,xg,xb})
end procedure

public constant xgetlab = define_c_proc(dis,"+getlab",{C_POINTER,C_POINTER,C_POINTER})

public procedure getlab(atom cx,atom cy,atom cz)
	c_proc(xgetlab,{cx,cy,cz})
end procedure

public constant xgetlen = define_c_proc(dis,"+getlen",{C_POINTER,C_POINTER,C_POINTER})

public procedure getlen(atom nxl,atom nyl,atom nzl)
	c_proc(xgetlen,{nxl,nyl,nzl})
end procedure

public constant xgetlev = define_c_func(dis,"+getlev",{},C_INT)

public function getlev()
	return c_func(xgetlev,{})
end function

public constant xgetlin = define_c_func(dis,"+getlin",{},C_INT)

public function getlin()
	return c_func(xgetlin,{})
end function

public constant xgetlit = define_c_func(dis,"+getlit",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT},C_INT)

public function getlit(atom xp,atom yp,atom zp,atom xn,atom yn,atom zn)
	return c_func(xgetlit,{xp,yp,zp,xn,yn,zn})
end function

public constant xgetmat = define_c_proc(dis,"+getmat",{C_POINTER,C_POINTER,C_POINTER,C_INT,C_POINTER,C_INT,C_INT,C_FLOAT,C_POINTER,C_POINTER})

public procedure getmat(atom xray,atom yray,atom zray,atom n,atom zmat,atom nx,atom ny,atom zval,atom imat,atom wmat)
	c_proc(xgetmat,{xray,yray,zray,n,zmat,nx,ny,zval,imat,wmat})
end procedure

public constant xgetmfl = define_c_func(dis,"+getmfl",{},C_POINTER)

public function getmfl()
	return c_func(xgetmfl,{})
end function

public constant xgetmix = define_c_func(dis,"+getmix",{C_STRING},C_POINTER)

public function getmix(sequence copt)
	return c_func(xgetmix,{copt})
end function

public constant xgetor = define_c_proc(dis,"+getor",{C_POINTER,C_POINTER})

public procedure getor(atom nx0,atom ny0)
	c_proc(xgetor,{nx0,ny0})
end procedure

public constant xgetpag = define_c_proc(dis,"+getpag",{C_POINTER,C_POINTER})

public procedure getpag(atom nxpag,atom nypag)
	c_proc(xgetpag,{nxpag,nypag})
end procedure

public constant xgetpat = define_c_func(dis,"+getpat",{},C_LONG)

public function getpat()
	return c_func(xgetpat,{})
end function

public constant xgetplv = define_c_func(dis,"+getplv",{},C_INT)

public function getplv()
	return c_func(xgetplv,{})
end function

public constant xgetpos = define_c_proc(dis,"+getpos",{C_POINTER,C_POINTER})

public procedure getpos(atom nxa,atom nya)
	c_proc(xgetpos,{nxa,nya})
end procedure

public constant xgetran = define_c_proc(dis,"+getran",{C_POINTER,C_POINTER})

public procedure getran(atom nca,atom nce)
	c_proc(xgetran,{nca,nce})
end procedure

public constant xgetrco = define_c_proc(dis,"+getrco",{C_FLOAT,C_FLOAT,C_POINTER,C_POINTER})

public procedure getrco(atom zre,atom zimg,atom rre,atom rimg)
	c_proc(xgetrco,{zre,zimg,rre,rimg})
end procedure

public constant xgetres = define_c_proc(dis,"+getres",{C_POINTER,C_POINTER})

public procedure getres(atom npb,atom nph)
	c_proc(xgetres,{npb,nph})
end procedure

public constant xgetrgb = define_c_proc(dis,"+getrgb",{C_POINTER,C_POINTER,C_POINTER})

public procedure getrgb(atom xr,atom xg,atom xb)
	c_proc(xgetrgb,{xr,xg,xb})
end procedure

public constant xgetscl = define_c_proc(dis,"+getscl",{C_POINTER,C_POINTER,C_POINTER})

public procedure getscl(atom nxscl,atom nyscl,atom nzscl)
	c_proc(xgetscl,{nxscl,nyscl,nzscl})
end procedure

public constant xgetscm = define_c_proc(dis,"+getscm",{C_POINTER,C_POINTER,C_POINTER})

public procedure getscm(atom ix,atom iy,atom iz)
	c_proc(xgetscm,{ix,iy,iz})
end procedure

public constant xgetscr = define_c_proc(dis,"+getscr",{C_POINTER,C_POINTER})

public procedure getscr(atom nwidth,atom nheight)
	c_proc(xgetscr,{nwidth,nheight})
end procedure

public constant xgetshf = define_c_func(dis,"+getshf",{C_STRING},C_POINTER)

public function getshf(sequence copt)
	return c_func(xgetshf,{copt})
end function

public constant xgetsp1 = define_c_proc(dis,"+getsp1",{C_POINTER,C_POINTER,C_POINTER})

public procedure getsp1(atom nxdis,atom nydis,atom nzdis)
	c_proc(xgetsp1,{nxdis,nydis,nzdis})
end procedure

public constant xgetsp2 = define_c_proc(dis,"+getsp2",{C_POINTER,C_POINTER,C_POINTER})

public procedure getsp2(atom nxdis,atom nydis,atom nzdis)
	c_proc(xgetsp2,{nxdis,nydis,nzdis})
end procedure

public constant xgetsym = define_c_proc(dis,"+getsym",{C_POINTER,C_POINTER})

public procedure getsym(atom nxsym,atom nysym)
	c_proc(xgetsym,{nxsym,nysym})
end procedure

public constant xgettcl = define_c_proc(dis,"+gettcl",{C_POINTER,C_POINTER})

public procedure gettcl(atom nmaj,atom nmin)
	c_proc(xgettcl,{nmaj,nmin})
end procedure

public constant xgettic = define_c_proc(dis,"+gettic",{C_POINTER,C_POINTER,C_POINTER})

public procedure gettic(atom nxtic,atom nytic,atom nztic)
	c_proc(xgettic,{nxtic,nytic,nztic})
end procedure

public constant xgettyp = define_c_func(dis,"+gettyp",{},C_INT)

public function gettyp()
	return c_func(xgettyp,{})
end function

public constant xgetuni = define_c_func(dis,"+getuni",{},C_POINTER)

public function getuni()
	return c_func(xgetuni,{})
end function

public constant xgetver = define_c_func(dis,"+getver",{},C_FLOAT)

public function getver()
	return c_func(xgetver,{})
end function

public constant xgetvk = define_c_proc(dis,"+getvk",{C_POINTER,C_POINTER,C_POINTER})

public procedure getvk(atom nv,atom nvfx,atom nvfy)
	c_proc(xgetvk,{nv,nvfx,nvfy})
end procedure

public constant xgetvlt = define_c_func(dis,"+getvlt",{},C_POINTER)

public function getvlt()
	return c_func(xgetvlt,{})
end function

public constant xgetwid = define_c_func(dis,"+getwid",{},C_INT)

public function getwid()
	return c_func(xgetwid,{})
end function

public constant xgetwin = define_c_proc(dis,"+getwin",{C_POINTER,C_POINTER,C_POINTER,C_POINTER})

public procedure getwin(atom ix,atom iy,atom nwidth,atom nheight)
	c_proc(xgetwin,{ix,iy,nwidth,nheight})
end procedure

public constant xgetxid = define_c_func(dis,"+getxid",{C_STRING},C_INT)

public function getxid(sequence copt)
	return c_func(xgetxid,{copt})
end function

public constant xgifmod = define_c_proc(dis,"+gifmod",{C_STRING,C_STRING})

public procedure gifmod(sequence cmod,sequence ckey)
	c_proc(xgifmod,{cmod,ckey})
end procedure

public constant xgmxalf = define_c_func(dis,"+gmxalf",{C_STRING,C_POINTER,C_POINTER},C_INT)

public function gmxalf(sequence copt,atom ca,atom cb)
	return c_func(xgmxalf,{copt,ca,cb})
end function

public constant xgothic = define_c_proc(dis,"+gothic",{})

public procedure gothic()
	c_proc(xgothic,{})
end procedure

public constant xgrace = define_c_proc(dis,"+grace",{C_INT})

public procedure grace(atom ngrace)
	c_proc(xgrace,{ngrace})
end procedure

public constant xgraf = define_c_proc(dis,"+graf",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure graf(atom xa,atom xe,atom xorg,atom xstp,atom ya,atom ye,atom yorg,atom ystp)
	c_proc(xgraf,{xa,xe,xorg,xstp,ya,ye,yorg,ystp})
end procedure

public constant xgraf3 = define_c_proc(dis,"+graf3",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure graf3(atom xa,atom xe,atom xorg,atom xstp,atom ya,atom ye,atom yorg,atom ystp,atom za,atom ze,atom zorg,atom zstp)
	c_proc(xgraf3,{xa,xe,xorg,xstp,ya,ye,yorg,ystp,za,ze,zorg,zstp})
end procedure

public constant xgraf3d = define_c_proc(dis,"+graf3d",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure graf3d(atom xa,atom xe,atom xorg,atom xstp,atom ya,atom ye,atom yorg,atom ystp,atom za,atom ze,atom zorg,atom zstp)
	c_proc(xgraf3d,{xa,xe,xorg,xstp,ya,ye,yorg,ystp,za,ze,zorg,zstp})
end procedure

public constant xgrafmp = define_c_proc(dis,"+grafmp",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure grafmp(atom xa,atom xe,atom xorg,atom xstp,atom ya,atom ye,atom yorg,atom ystp)
	c_proc(xgrafmp,{xa,xe,xorg,xstp,ya,ye,yorg,ystp})
end procedure

public constant xgrafp = define_c_proc(dis,"+grafp",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure grafp(atom xe,atom xorg,atom xstp,atom yorg,atom ystp)
	c_proc(xgrafp,{xe,xorg,xstp,yorg,ystp})
end procedure

public constant xgrafr = define_c_proc(dis,"+grafr",{C_POINTER,C_INT,C_POINTER,C_INT})

public procedure grafr(atom zre,atom nre,atom zimg,atom nimg)
	c_proc(xgrafr,{zre,nre,zimg,nimg})
end procedure

public constant xgrdpol = define_c_proc(dis,"+grdpol",{C_INT,C_INT})

public procedure grdpol(atom ixgrid,atom iygrid)
	c_proc(xgrdpol,{ixgrid,iygrid})
end procedure

public constant xgrffin = define_c_proc(dis,"+grffin",{})

public procedure grffin()
	c_proc(xgrffin,{})
end procedure

public constant xgrfini = define_c_proc(dis,"+grfini",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure grfini(atom x1,atom y1,atom z1,atom x2,atom y2,atom z2,atom x3,atom y3,atom z3)
	c_proc(xgrfini,{x1,y1,z1,x2,y2,z2,x3,y3,z3})
end procedure

public constant xgrid = define_c_proc(dis,"+grid",{C_INT,C_INT})

public procedure grid(atom ixgrid,atom iygrid)
	c_proc(xgrid,{ixgrid,iygrid})
end procedure

public constant xgrid3d = define_c_proc(dis,"+grid3d",{C_INT,C_INT,C_STRING})

public procedure grid3d(atom ixgrid,atom iygrid,sequence copt)
	c_proc(xgrid3d,{ixgrid,iygrid,copt})
end procedure

public constant xgridim = define_c_proc(dis,"+gridim",{C_FLOAT,C_FLOAT,C_FLOAT,C_INT})

public procedure gridim(atom zim,atom zre1,atom zre2,atom n)
	c_proc(xgridim,{zim,zre1,zre2,n})
end procedure

public constant xgridmp = define_c_proc(dis,"+gridmp",{C_INT,C_INT})

public procedure gridmp(atom ixgrid,atom iygrid)
	c_proc(xgridmp,{ixgrid,iygrid})
end procedure

public constant xgridre = define_c_proc(dis,"+gridre",{C_FLOAT,C_FLOAT,C_FLOAT,C_INT})

public procedure gridre(atom zre,atom zim1,atom zim2,atom n)
	c_proc(xgridre,{zre,zim1,zim2,n})
end procedure

public constant xgwgatt = define_c_func(dis,"+gwgatt",{C_INT,C_STRING},C_INT)

public function gwgatt(atom id,sequence copt)
	return c_func(xgwgatt,{id,copt})
end function

public constant xgwgbox = define_c_func(dis,"+gwgbox",{C_INT},C_INT)

public function gwgbox(atom id)
	return c_func(xgwgbox,{id})
end function

public constant xgwgbut = define_c_func(dis,"+gwgbut",{C_INT},C_INT)

public function gwgbut(atom id)
	return c_func(xgwgbut,{id})
end function

public constant xgwgfil = define_c_proc(dis,"+gwgfil",{C_INT,C_STRING})

public procedure gwgfil(atom id,sequence cfile)
	c_proc(xgwgfil,{id,cfile})
end procedure

public constant xgwgflt = define_c_func(dis,"+gwgflt",{C_INT},C_FLOAT)

public function gwgflt(atom id)
	return c_func(xgwgflt,{id})
end function

public constant xgwggui = define_c_func(dis,"+gwggui",{},C_INT)

public function gwggui()
	return c_func(xgwggui,{})
end function

public constant xgwgint = define_c_func(dis,"+gwgint",{C_INT},C_INT)

public function gwgint(atom id)
	return c_func(xgwgint,{id})
end function

public constant xgwglis = define_c_func(dis,"+gwglis",{C_INT},C_INT)

public function gwglis(atom id)
	return c_func(xgwglis,{id})
end function

public constant xgwgscl = define_c_func(dis,"+gwgscl",{C_INT},C_FLOAT)

public function gwgscl(atom id)
	return c_func(xgwgscl,{id})
end function

public constant xgwgsiz = define_c_proc(dis,"+gwgsiz",{C_INT,C_POINTER,C_POINTER})

public procedure gwgsiz(atom id,atom nw,atom nh)
	c_proc(xgwgsiz,{id,nw,nh})
end procedure

public constant xgwgtbf = define_c_func(dis,"+gwgtbf",{C_INT,C_INT,C_INT},C_FLOAT)

public function gwgtbf(atom id,atom i,atom j)
	return c_func(xgwgtbf,{id,i,j})
end function

public constant xgwgtbi = define_c_func(dis,"+gwgtbi",{C_INT,C_INT,C_INT},C_INT)

public function gwgtbi(atom id,atom i,atom j)
	return c_func(xgwgtbi,{id,i,j})
end function

public constant xgwgtbl = define_c_proc(dis,"+gwgtbl",{C_INT,C_POINTER,C_INT,C_INT,C_STRING})

public procedure gwgtbl(atom id,atom xray,atom n,atom idx,sequence copt)
	c_proc(xgwgtbl,{id,xray,n,idx,copt})
end procedure

public constant xgwgtbs = define_c_proc(dis,"+gwgtbs",{C_INT,C_INT,C_INT,C_STRING})

public procedure gwgtbs(atom id,atom i,atom j,sequence s)
	c_proc(xgwgtbs,{id,i,j,s})
end procedure

public constant xgwgtxt = define_c_proc(dis,"+gwgtxt",{C_INT,C_STRING})

public procedure gwgtxt(atom id,sequence ctext)
	c_proc(xgwgtxt,{id,ctext})
end procedure

public constant xgwgxid = define_c_func(dis,"+gwgxid",{C_INT},C_INT)

public function gwgxid(atom id)
	return c_func(xgwgxid,{id})
end function

public constant xheight = define_c_proc(dis,"+height",{C_INT})

public procedure height(atom nhchar)
	c_proc(xheight,{nhchar})
end procedure

public constant xhelve = define_c_proc(dis,"+helve",{})

public procedure helve()
	c_proc(xhelve,{})
end procedure

public constant xhelves = define_c_proc(dis,"+helves",{})

public procedure helves()
	c_proc(xhelves,{})
end procedure

public constant xhelvet = define_c_proc(dis,"+helvet",{})

public procedure helvet()
	c_proc(xhelvet,{})
end procedure

public constant xhidwin = define_c_proc(dis,"+hidwin",{C_INT,C_STRING})

public procedure hidwin(atom id,sequence copt)
	c_proc(xhidwin,{id,copt})
end procedure

public constant xhistog = define_c_proc(dis,"+histog",{C_POINTER,C_INT,C_POINTER,C_POINTER,C_POINTER})

public procedure histog(atom xray,atom n,atom x,atom y,atom m)
	c_proc(xhistog,{xray,n,x,y,m})
end procedure

public constant xhname = define_c_proc(dis,"+hname",{C_INT})

public procedure hname(atom nhchar)
	c_proc(xhname,{nhchar})
end procedure

public constant xhpgmod = define_c_proc(dis,"+hpgmod",{C_STRING,C_STRING})

public procedure hpgmod(sequence cmod,sequence ckey)
	c_proc(xhpgmod,{cmod,ckey})
end procedure

public constant xhsvrgb = define_c_proc(dis,"+hsvrgb",{C_FLOAT,C_FLOAT,C_FLOAT,C_POINTER,C_POINTER,C_POINTER})

public procedure hsvrgb(atom xh,atom xs,atom xv,atom xr,atom xg,atom xb)
	c_proc(xhsvrgb,{xh,xs,xv,xr,xg,xb})
end procedure

public constant xhsym3d = define_c_proc(dis,"+hsym3d",{C_FLOAT})

public procedure hsym3d(atom x)
	c_proc(xhsym3d,{x})
end procedure

public constant xhsymbl = define_c_proc(dis,"+hsymbl",{C_INT})

public procedure hsymbl(atom nhsym)
	c_proc(xhsymbl,{nhsym})
end procedure

public constant xhtitle = define_c_proc(dis,"+htitle",{C_INT})

public procedure htitle(atom nhtit)
	c_proc(xhtitle,{nhtit})
end procedure

public constant xhwfont = define_c_proc(dis,"+hwfont",{})

public procedure hwfont()
	c_proc(xhwfont,{})
end procedure

public constant xhwmode = define_c_proc(dis,"+hwmode",{C_STRING,C_STRING})

public procedure hwmode(sequence copt,sequence ckey)
	c_proc(xhwmode,{copt,ckey})
end procedure

public constant xhworig = define_c_proc(dis,"+hworig",{C_INT,C_INT})

public procedure hworig(atom nx,atom ny)
	c_proc(xhworig,{nx,ny})
end procedure

public constant xhwpage = define_c_proc(dis,"+hwpage",{C_INT,C_INT})

public procedure hwpage(atom nw,atom nh)
	c_proc(xhwpage,{nw,nh})
end procedure

public constant xhwscal = define_c_proc(dis,"+hwscal",{C_FLOAT})

public procedure hwscal(atom xfac)
	c_proc(xhwscal,{xfac})
end procedure

public constant ximgbox = define_c_proc(dis,"+imgbox",{C_INT,C_INT,C_INT,C_INT})

public procedure imgbox(atom nx,atom ny,atom nw,atom nh)
	c_proc(ximgbox,{nx,ny,nw,nh})
end procedure

public constant ximgclp = define_c_proc(dis,"+imgclp",{C_INT,C_INT,C_INT,C_INT})

public procedure imgclp(atom nx,atom ny,atom nw,atom nh)
	c_proc(ximgclp,{nx,ny,nw,nh})
end procedure

public constant ximgfin = define_c_proc(dis,"+imgfin",{})

public procedure imgfin()
	c_proc(ximgfin,{})
end procedure

public constant ximgfmt = define_c_proc(dis,"+imgfmt",{C_STRING})

public procedure imgfmt(sequence copt)
	c_proc(ximgfmt,{copt})
end procedure

public constant ximgini = define_c_proc(dis,"+imgini",{})

public procedure imgini()
	c_proc(ximgini,{})
end procedure

public constant ximgmod = define_c_proc(dis,"+imgmod",{C_STRING})

public procedure imgmod(sequence copt)
	c_proc(ximgmod,{copt})
end procedure

public constant ximgsiz = define_c_proc(dis,"+imgsiz",{C_INT,C_INT})

public procedure imgsiz(atom nw,atom nh)
	c_proc(ximgsiz,{nw,nh})
end procedure

public constant ximgtpr = define_c_proc(dis,"+imgtpr",{C_INT})

public procedure imgtpr(atom n)
	c_proc(ximgtpr,{n})
end procedure

public constant xinccrv = define_c_proc(dis,"+inccrv",{C_INT})

public procedure inccrv(atom ncrv)
	c_proc(xinccrv,{ncrv})
end procedure

public constant xincdat = define_c_func(dis,"+incdat",{C_INT,C_INT,C_INT},C_INT)

public function incdat(atom id,atom im,atom iy)
	return c_func(xincdat,{id,im,iy})
end function

public constant xincfil = define_c_proc(dis,"+incfil",{C_STRING})

public procedure incfil(sequence cfil)
	c_proc(xincfil,{cfil})
end procedure

public constant xincmrk = define_c_proc(dis,"+incmrk",{C_INT})

public procedure incmrk(atom nmrk)
	c_proc(xincmrk,{nmrk})
end procedure

public constant xindrgb = define_c_func(dis,"+indrgb",{C_FLOAT,C_FLOAT,C_FLOAT},C_INT)

public function indrgb(atom xr,atom xg,atom xb)
	return c_func(xindrgb,{xr,xg,xb})
end function

public constant xintax = define_c_proc(dis,"+intax",{})

public procedure intax()
	c_proc(xintax,{})
end procedure

public constant xintcha = define_c_func(dis,"+intcha",{C_INT,C_STRING},C_INT)

public function intcha(atom nx,sequence cstr)
	return c_func(xintcha,{nx,cstr})
end function

public constant xintlen = define_c_func(dis,"+intlen",{C_INT},C_INT)

public function intlen(atom nx)
	return c_func(xintlen,{nx})
end function

public constant xintrgb = define_c_func(dis,"+intrgb",{C_FLOAT,C_FLOAT,C_FLOAT},C_INT)

public function intrgb(atom xr,atom xg,atom xb)
	return c_func(xintrgb,{xr,xg,xb})
end function

public constant xintutf = define_c_func(dis,"+intutf",{C_POINTER,C_INT,C_STRING,C_INT},C_INT)

public function intutf(atom iray,atom n,sequence cstr,atom nmax)
	return c_func(xintutf,{iray,n,cstr,nmax})
end function

public constant xisopts = define_c_proc(dis,"+isopts",{C_POINTER,C_INT,C_POINTER,C_INT,C_POINTER,C_INT,C_POINTER,C_FLOAT,C_POINTER,C_POINTER,C_POINTER,C_INT,C_POINTER})

public procedure isopts(atom xray,atom nx,atom yray,atom ny,atom zray,atom nz,atom wmat,atom wlev,atom xtri,atom ytri,atom ztri,atom nmax,atom ntri)
	c_proc(xisopts,{xray,nx,yray,ny,zray,nz,wmat,wlev,xtri,ytri,ztri,nmax,ntri})
end procedure

public constant xitmcat = define_c_proc(dis,"+itmcat",{C_STRING,C_STRING})

public procedure itmcat(sequence clis,sequence cstr)
	c_proc(xitmcat,{clis,cstr})
end procedure

public constant xitmstr = define_c_func(dis,"+itmstr",{C_STRING,C_INT},C_STRING)

public function itmstr(sequence clis,atom nlis)
	return c_func(xitmstr,{clis,nlis})
end function

public constant xjusbar = define_c_proc(dis,"+jusbar",{C_STRING})

public procedure jusbar(sequence copt)
	c_proc(xjusbar,{copt})
end procedure

public constant xlabclr = define_c_proc(dis,"+labclr",{C_INT,C_STRING})

public procedure labclr(atom iclr,sequence copt)
	c_proc(xlabclr,{iclr,copt})
end procedure

public constant xlabdig = define_c_proc(dis,"+labdig",{C_INT,C_STRING})

public procedure labdig(atom ndig,sequence cax)
	c_proc(xlabdig,{ndig,cax})
end procedure

public constant xlabdis = define_c_proc(dis,"+labdis",{C_INT,C_STRING})

public procedure labdis(atom ndis,sequence cax)
	c_proc(xlabdis,{ndis,cax})
end procedure

public constant xlabels = define_c_proc(dis,"+labels",{C_STRING,C_STRING})

public procedure labels(sequence clab,sequence cax)
	c_proc(xlabels,{clab,cax})
end procedure

public constant xlabjus = define_c_proc(dis,"+labjus",{C_STRING,C_STRING})

public procedure labjus(sequence copt,sequence cax)
	c_proc(xlabjus,{copt,cax})
end procedure

public constant xlabl3d = define_c_proc(dis,"+labl3d",{C_STRING})

public procedure labl3d(sequence copt)
	c_proc(xlabl3d,{copt})
end procedure

public constant xlabmod = define_c_proc(dis,"+labmod",{C_STRING,C_STRING,C_STRING})

public procedure labmod(sequence ckey,sequence cval,sequence cax)
	c_proc(xlabmod,{ckey,cval,cax})
end procedure

public constant xlabpos = define_c_proc(dis,"+labpos",{C_STRING,C_STRING})

public procedure labpos(sequence cpos,sequence cax)
	c_proc(xlabpos,{cpos,cax})
end procedure

public constant xlabtyp = define_c_proc(dis,"+labtyp",{C_STRING,C_STRING})

public procedure labtyp(sequence ctyp,sequence cax)
	c_proc(xlabtyp,{ctyp,cax})
end procedure

public constant xldimg = define_c_func(dis,"+ldimg",{C_STRING,C_POINTER,C_INT,C_INT},C_INT)

public function ldimg(sequence cfil,atom iray,atom nmax,atom nc)
	return c_func(xldimg,{cfil,iray,nmax,nc})
end function

public constant xlegbgd = define_c_proc(dis,"+legbgd",{C_INT})

public procedure legbgd(atom iclr)
	c_proc(xlegbgd,{iclr})
end procedure

public constant xlegclr = define_c_proc(dis,"+legclr",{})

public procedure legclr()
	c_proc(xlegclr,{})
end procedure

public constant xlegend = define_c_proc(dis,"+legend",{C_STRING,C_INT})

public procedure legend(sequence cbuf,atom ncor)
	c_proc(xlegend,{cbuf,ncor})
end procedure

public constant xlegini = define_c_proc(dis,"+legini",{C_STRING,C_INT,C_INT})

public procedure legini(sequence cbuf,atom nlin,atom nmaxln)
	c_proc(xlegini,{cbuf,nlin,nmaxln})
end procedure

public constant xleglin = define_c_proc(dis,"+leglin",{C_STRING,C_STRING,C_INT})

public procedure leglin(sequence cbuf,sequence cstr,atom ilin)
	c_proc(xleglin,{cbuf,cstr,ilin})
end procedure

public constant xlegopt = define_c_proc(dis,"+legopt",{C_FLOAT,C_FLOAT,C_FLOAT})

public procedure legopt(atom x1,atom x2,atom x3)
	c_proc(xlegopt,{x1,x2,x3})
end procedure

public constant xlegpat = define_c_proc(dis,"+legpat",{C_INT,C_INT,C_INT,C_INT,C_LONG,C_INT})

public procedure legpat(atom ityp,atom ithk,atom isym,atom iclr,atom ipat,atom ilin)
	c_proc(xlegpat,{ityp,ithk,isym,iclr,ipat,ilin})
end procedure

public constant xlegpos = define_c_proc(dis,"+legpos",{C_INT,C_INT})

public procedure legpos(atom nx,atom ny)
	c_proc(xlegpos,{nx,ny})
end procedure

public constant xlegsel = define_c_proc(dis,"+legsel",{C_POINTER,C_INT})

public procedure legsel(atom nray,atom n)
	c_proc(xlegsel,{nray,n})
end procedure

public constant xlegtbl = define_c_proc(dis,"+legtbl",{C_INT,C_STRING})

public procedure legtbl(atom n,sequence copt)
	c_proc(xlegtbl,{n,copt})
end procedure

public constant xlegtit = define_c_proc(dis,"+legtit",{C_STRING})

public procedure legtit(sequence cstr)
	c_proc(xlegtit,{cstr})
end procedure

public constant xlegtyp = define_c_proc(dis,"+legtyp",{C_STRING})

public procedure legtyp(sequence copt)
	c_proc(xlegtyp,{copt})
end procedure

public constant xlegval = define_c_proc(dis,"+legval",{C_FLOAT,C_STRING})

public procedure legval(atom x,sequence copt)
	c_proc(xlegval,{x,copt})
end procedure

public constant xlfttit = define_c_proc(dis,"+lfttit",{})

public procedure lfttit()
	c_proc(xlfttit,{})
end procedure

public constant xlicmod = define_c_proc(dis,"+licmod",{C_STRING,C_STRING})

public procedure licmod(sequence cmod,sequence ckey)
	c_proc(xlicmod,{cmod,ckey})
end procedure

public constant xlicpts = define_c_proc(dis,"+licpts",{C_POINTER,C_POINTER,C_INT,C_INT,C_POINTER,C_POINTER,C_POINTER})

public procedure licpts(atom xv,atom yv,atom nx,atom ny,atom itmat,atom iwmat,atom wmat)
	c_proc(xlicpts,{xv,yv,nx,ny,itmat,iwmat,wmat})
end procedure

public constant xlight = define_c_proc(dis,"+light",{C_STRING})

public procedure light(sequence copt)
	c_proc(xlight,{copt})
end procedure

public constant xlinclr = define_c_proc(dis,"+linclr",{C_POINTER,C_INT})

public procedure linclr(atom nray,atom n)
	c_proc(xlinclr,{nray,n})
end procedure

public constant xlincyc = define_c_proc(dis,"+lincyc",{C_INT,C_INT})

public procedure lincyc(atom index,atom ityp)
	c_proc(xlincyc,{index,ityp})
end procedure

public constant xline = define_c_proc(dis,"+line",{C_INT,C_INT,C_INT,C_INT})

public procedure line(atom nx,atom ny,atom nu,atom nv)
	c_proc(xline,{nx,ny,nu,nv})
end procedure

public constant xlinesp = define_c_proc(dis,"+linesp",{C_FLOAT})

public procedure linesp(atom xfac)
	c_proc(xlinesp,{xfac})
end procedure

public constant xlinfit = define_c_proc(dis,"+linfit",{C_POINTER,C_POINTER,C_INT,C_POINTER,C_POINTER,C_POINTER,C_STRING})

public procedure linfit(atom x,atom y,atom n,atom a,atom b,atom r,sequence copt)
	c_proc(xlinfit,{x,y,n,a,b,r,copt})
end procedure

public constant xlinmod = define_c_proc(dis,"+linmod",{C_STRING,C_STRING})

public procedure linmod(sequence cmod,sequence ckey)
	c_proc(xlinmod,{cmod,ckey})
end procedure

public constant xlintyp = define_c_proc(dis,"+lintyp",{C_INT})

public procedure lintyp(atom ntyp)
	c_proc(xlintyp,{ntyp})
end procedure

public constant xlinwid = define_c_proc(dis,"+linwid",{C_INT})

public procedure linwid(atom i)
	c_proc(xlinwid,{i})
end procedure

public constant xlitmod = define_c_proc(dis,"+litmod",{C_INT,C_STRING})

public procedure litmod(atom id,sequence copt)
	c_proc(xlitmod,{id,copt})
end procedure

public constant xlitop3 = define_c_proc(dis,"+litop3",{C_INT,C_FLOAT,C_FLOAT,C_FLOAT,C_STRING})

public procedure litop3(atom id,atom xr,atom xg,atom xb,sequence copt)
	c_proc(xlitop3,{id,xr,xg,xb,copt})
end procedure

public constant xlitopt = define_c_proc(dis,"+litopt",{C_INT,C_FLOAT,C_STRING})

public procedure litopt(atom id,atom xval,sequence copt)
	c_proc(xlitopt,{id,xval,copt})
end procedure

public constant xlitpos = define_c_proc(dis,"+litpos",{C_INT,C_FLOAT,C_FLOAT,C_FLOAT,C_STRING})

public procedure litpos(atom id,atom x,atom y,atom z,sequence copt)
	c_proc(xlitpos,{id,x,y,z,copt})
end procedure

public constant xlncap = define_c_proc(dis,"+lncap",{C_STRING})

public procedure lncap(sequence copt)
	c_proc(xlncap,{copt})
end procedure

public constant xlnjoin = define_c_proc(dis,"+lnjoin",{C_STRING})

public procedure lnjoin(sequence copt)
	c_proc(xlnjoin,{copt})
end procedure

public constant xlnmlt = define_c_proc(dis,"+lnmlt",{C_FLOAT})

public procedure lnmlt(atom x)
	c_proc(xlnmlt,{x})
end procedure

public constant xlogtic = define_c_proc(dis,"+logtic",{C_STRING})

public procedure logtic(sequence cmod)
	c_proc(xlogtic,{cmod})
end procedure

public constant xmapbas = define_c_proc(dis,"+mapbas",{C_STRING})

public procedure mapbas(sequence cmod)
	c_proc(xmapbas,{cmod})
end procedure

public constant xmapdir = define_c_proc(dis,"+mapdir",{C_STRING})

public procedure mapdir(sequence cfil)
	c_proc(xmapdir,{cfil})
end procedure

public constant xmapimg = define_c_proc(dis,"+mapimg",{C_STRING,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure mapimg(sequence cfil,atom x1,atom x2,atom x3,atom x4,atom x5,atom x6)
	c_proc(xmapimg,{cfil,x1,x2,x3,x4,x5,x6})
end procedure

public constant xmaplab = define_c_proc(dis,"+maplab",{C_STRING,C_STRING})

public procedure maplab(sequence copt,sequence ckey)
	c_proc(xmaplab,{copt,ckey})
end procedure

public constant xmaplev = define_c_proc(dis,"+maplev",{C_STRING})

public procedure maplev(sequence cmod)
	c_proc(xmaplev,{cmod})
end procedure

public constant xmapmod = define_c_proc(dis,"+mapmod",{C_STRING})

public procedure mapmod(sequence cmod)
	c_proc(xmapmod,{cmod})
end procedure

public constant xmappol = define_c_proc(dis,"+mappol",{C_FLOAT,C_FLOAT})

public procedure mappol(atom xpol,atom ypol)
	c_proc(xmappol,{xpol,ypol})
end procedure

public constant xmapopt = define_c_proc(dis,"+mapopt",{C_STRING,C_STRING})

public procedure mapopt(sequence copt,sequence ckey)
	c_proc(xmapopt,{copt,ckey})
end procedure

public constant xmapref = define_c_proc(dis,"+mapref",{C_FLOAT,C_FLOAT})

public procedure mapref(atom ylower,atom yupper)
	c_proc(xmapref,{ylower,yupper})
end procedure

public constant xmapsph = define_c_proc(dis,"+mapsph",{C_FLOAT})

public procedure mapsph(atom xrad)
	c_proc(xmapsph,{xrad})
end procedure

public constant xmarker = define_c_proc(dis,"+marker",{C_INT})

public procedure marker(atom nsym)
	c_proc(xmarker,{nsym})
end procedure

public constant xmatop3 = define_c_proc(dis,"+matop3",{C_FLOAT,C_FLOAT,C_FLOAT,C_STRING})

public procedure matop3(atom xr,atom xg,atom xb,sequence copt)
	c_proc(xmatop3,{xr,xg,xb,copt})
end procedure

public constant xmatopt = define_c_proc(dis,"+matopt",{C_FLOAT,C_STRING})

public procedure matopt(atom xval,sequence copt)
	c_proc(xmatopt,{xval,copt})
end procedure

public constant xmdfmat = define_c_proc(dis,"+mdfmat",{C_INT,C_INT,C_FLOAT})

public procedure mdfmat(atom nx,atom ny,atom weight)
	c_proc(xmdfmat,{nx,ny,weight})
end procedure

public constant xmessag = define_c_proc(dis,"+messag",{C_STRING,C_INT,C_INT})

public procedure messag(sequence cstr,atom nx,atom ny)
	c_proc(xmessag,{cstr,nx,ny})
end procedure

public constant xmetafl = define_c_proc(dis,"+metafl",{C_STRING})

public procedure metafl(sequence cstr)
	c_proc(xmetafl,{cstr})
end procedure

public constant xmixalf = define_c_proc(dis,"+mixalf",{})

public procedure mixalf()
	c_proc(xmixalf,{})
end procedure

public constant xmixleg = define_c_proc(dis,"+mixleg",{})

public procedure mixleg()
	c_proc(xmixleg,{})
end procedure

public constant xmpaepl = define_c_proc(dis,"+mpaepl",{C_INT})

public procedure mpaepl(atom i)
	c_proc(xmpaepl,{i})
end procedure

public constant xmplang = define_c_proc(dis,"+mplang",{C_FLOAT})

public procedure mplang(atom x)
	c_proc(xmplang,{x})
end procedure

public constant xmplclr = define_c_proc(dis,"+mplclr",{C_INT,C_INT})

public procedure mplclr(atom nbg,atom nfg)
	c_proc(xmplclr,{nbg,nfg})
end procedure

public constant xmplpos = define_c_proc(dis,"+mplpos",{C_INT,C_INT})

public procedure mplpos(atom nx,atom ny)
	c_proc(xmplpos,{nx,ny})
end procedure

public constant xmplsiz = define_c_proc(dis,"+mplsiz",{C_INT})

public procedure mplsiz(atom nsize)
	c_proc(xmplsiz,{nsize})
end procedure

public constant xmpslogo = define_c_proc(dis,"+mpslogo",{C_INT,C_INT,C_INT,C_STRING})

public procedure mpslogo(atom nx,atom ny,atom nsize,sequence copt)
	c_proc(xmpslogo,{nx,ny,nsize,copt})
end procedure

public constant xmrkclr = define_c_proc(dis,"+mrkclr",{C_INT})

public procedure mrkclr(atom nclr)
	c_proc(xmrkclr,{nclr})
end procedure

public constant xmsgbox = define_c_proc(dis,"+msgbox",{C_STRING})

public procedure msgbox(sequence cstr)
	c_proc(xmsgbox,{cstr})
end procedure

public constant xmshclr = define_c_proc(dis,"+mshclr",{C_INT})

public procedure mshclr(atom ic)
	c_proc(xmshclr,{ic})
end procedure

public constant xmshcrv = define_c_proc(dis,"+mshcrv",{C_INT})

public procedure mshcrv(atom n)
	c_proc(xmshcrv,{n})
end procedure

public constant xmylab = define_c_proc(dis,"+mylab",{C_STRING,C_INT,C_STRING})

public procedure mylab(sequence cstr,atom itick,sequence cax)
	c_proc(xmylab,{cstr,itick,cax})
end procedure

public constant xmyline = define_c_proc(dis,"+myline",{C_POINTER,C_INT})

public procedure myline(atom nray,atom n)
	c_proc(xmyline,{nray,n})
end procedure

public constant xmypat = define_c_proc(dis,"+mypat",{C_INT,C_INT,C_INT,C_INT})

public procedure mypat(atom iang,atom itype,atom idens,atom icross)
	c_proc(xmypat,{iang,itype,idens,icross})
end procedure

public constant xmysymb = define_c_proc(dis,"+mysymb",{C_POINTER,C_POINTER,C_INT,C_INT,C_INT})

public procedure mysymb(atom xray,atom yray,atom n,atom isym,atom iflag)
	c_proc(xmysymb,{xray,yray,n,isym,iflag})
end procedure

public constant xmyvlt = define_c_proc(dis,"+myvlt",{C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure myvlt(atom xr,atom xg,atom xb,atom n)
	c_proc(xmyvlt,{xr,xg,xb,n})
end procedure

public constant xnamdis = define_c_proc(dis,"+namdis",{C_INT,C_STRING})

public procedure namdis(atom ndis,sequence cax)
	c_proc(xnamdis,{ndis,cax})
end procedure

public constant xname = define_c_proc(dis,"+name",{C_STRING,C_STRING})

public procedure name(sequence cstr,sequence cax)
	c_proc(xname,{cstr,cax})
end procedure

public constant xnamjus = define_c_proc(dis,"+namjus",{C_STRING,C_STRING})

public procedure namjus(sequence copt,sequence cax)
	c_proc(xnamjus,{copt,cax})
end procedure

public constant xnancrv = define_c_proc(dis,"+nancrv",{C_STRING})

public procedure nancrv(sequence copt)
	c_proc(xnancrv,{copt})
end procedure

public constant xneglog = define_c_proc(dis,"+neglog",{C_FLOAT})

public procedure neglog(atom eps)
	c_proc(xneglog,{eps})
end procedure

public constant xnewmix = define_c_proc(dis,"+newmix",{})

public procedure newmix()
	c_proc(xnewmix,{})
end procedure

public constant xnewpag = define_c_proc(dis,"+newpag",{})

public procedure newpag()
	c_proc(xnewpag,{})
end procedure

public constant xnlmess = define_c_func(dis,"+nlmess",{C_STRING},C_INT)

public function nlmess(sequence cstr)
	return c_func(xnlmess,{cstr})
end function

public constant xnlnumb = define_c_func(dis,"+nlnumb",{C_FLOAT,C_INT},C_INT)

public function nlnumb(atom x,atom ndig)
	return c_func(xnlnumb,{x,ndig})
end function

public constant xnoarln = define_c_proc(dis,"+noarln",{})

public procedure noarln()
	c_proc(xnoarln,{})
end procedure

public constant xnobar = define_c_proc(dis,"+nobar",{})

public procedure nobar()
	c_proc(xnobar,{})
end procedure

public constant xnobgd = define_c_proc(dis,"+nobgd",{})

public procedure nobgd()
	c_proc(xnobgd,{})
end procedure

public constant xnochek = define_c_proc(dis,"+nochek",{})

public procedure nochek()
	c_proc(xnochek,{})
end procedure

public constant xnoclip = define_c_proc(dis,"+noclip",{})

public procedure noclip()
	c_proc(xnoclip,{})
end procedure

public constant xnofill = define_c_proc(dis,"+nofill",{})

public procedure nofill()
	c_proc(xnofill,{})
end procedure

public constant xnograf = define_c_proc(dis,"+nograf",{})

public procedure nograf()
	c_proc(xnograf,{})
end procedure

public constant xnohide = define_c_proc(dis,"+nohide",{})

public procedure nohide()
	c_proc(xnohide,{})
end procedure

public constant xnoline = define_c_proc(dis,"+noline",{C_STRING})

public procedure noline(sequence cax)
	c_proc(xnoline,{cax})
end procedure

public constant xnumber = define_c_proc(dis,"+number",{C_FLOAT,C_INT,C_INT,C_INT})

public procedure number(atom x,atom ndig,atom nx,atom ny)
	c_proc(xnumber,{x,ndig,nx,ny})
end procedure

public constant xnumfmt = define_c_proc(dis,"+numfmt",{C_STRING})

public procedure numfmt(sequence copt)
	c_proc(xnumfmt,{copt})
end procedure

public constant xnumode = define_c_proc(dis,"+numode",{C_STRING,C_STRING,C_STRING,C_STRING})

public procedure numode(sequence cdec,sequence cgrp,sequence cpos,sequence cfix)
	c_proc(xnumode,{cdec,cgrp,cpos,cfix})
end procedure

public constant xnwkday = define_c_func(dis,"+nwkday",{C_INT,C_INT,C_INT},C_INT)

public function nwkday(atom id,atom im,atom iy)
	return c_func(xnwkday,{id,im,iy})
end function

public constant xnxlegn = define_c_func(dis,"+nxlegn",{C_STRING},C_INT)

public function nxlegn(sequence cbuf)
	return c_func(xnxlegn,{cbuf})
end function

public constant xnxpixl = define_c_func(dis,"+nxpixl",{C_INT,C_INT},C_INT)

public function nxpixl(atom ix,atom iy)
	return c_func(xnxpixl,{ix,iy})
end function

public constant xnxposn = define_c_func(dis,"+nxposn",{C_FLOAT},C_INT)

public function nxposn(atom x)
	return c_func(xnxposn,{x})
end function

public constant xnylegn = define_c_func(dis,"+nylegn",{C_STRING},C_INT)

public function nylegn(sequence cbuf)
	return c_func(xnylegn,{cbuf})
end function

public constant xnypixl = define_c_func(dis,"+nypixl",{C_INT,C_INT},C_INT)

public function nypixl(atom ix,atom iy)
	return c_func(xnypixl,{ix,iy})
end function

public constant xnyposn = define_c_func(dis,"+nyposn",{C_FLOAT},C_INT)

public function nyposn(atom y)
	return c_func(xnyposn,{y})
end function

public constant xnzposn = define_c_func(dis,"+nzposn",{C_FLOAT},C_INT)

public function nzposn(atom z)
	return c_func(xnzposn,{z})
end function

public constant xopenfl = define_c_func(dis,"+openfl",{C_STRING,C_INT,C_INT},C_INT)

public function openfl(sequence cfil,atom nu,atom irw)
	return c_func(xopenfl,{cfil,nu,irw})
end function

public constant xopnwin = define_c_proc(dis,"+opnwin",{C_INT})

public procedure opnwin(atom id)
	c_proc(xopnwin,{id})
end procedure

public constant xorigin = define_c_proc(dis,"+origin",{C_INT,C_INT})

public procedure origin(atom nx0,atom ny0)
	c_proc(xorigin,{nx0,ny0})
end procedure

public constant xpage = define_c_proc(dis,"+page",{C_INT,C_INT})

public procedure page(atom nw,atom nh)
	c_proc(xpage,{nw,nh})
end procedure

public constant xpagera = define_c_proc(dis,"+pagera",{})

public procedure pagera()
	c_proc(xpagera,{})
end procedure

public constant xpagfll = define_c_proc(dis,"+pagfll",{C_INT})

public procedure pagfll(atom nclr)
	c_proc(xpagfll,{nclr})
end procedure

public constant xpaghdr = define_c_proc(dis,"+paghdr",{C_STRING,C_STRING,C_INT,C_INT})

public procedure paghdr(sequence cstr1,sequence cstr2,atom iopt,atom idir)
	c_proc(xpaghdr,{cstr1,cstr2,iopt,idir})
end procedure

public constant xpagmod = define_c_proc(dis,"+pagmod",{C_STRING})

public procedure pagmod(sequence cmod)
	c_proc(xpagmod,{cmod})
end procedure

public constant xpagorg = define_c_proc(dis,"+pagorg",{C_STRING})

public procedure pagorg(sequence cpos)
	c_proc(xpagorg,{cpos})
end procedure

public constant xpagwin = define_c_proc(dis,"+pagwin",{C_INT,C_INT})

public procedure pagwin(atom nw,atom nh)
	c_proc(xpagwin,{nw,nh})
end procedure

public constant xpatcyc = define_c_proc(dis,"+patcyc",{C_INT,C_LONG})

public procedure patcyc(atom index,atom ipat)
	c_proc(xpatcyc,{index,ipat})
end procedure

public constant xpdfbuf = define_c_func(dis,"+pdfbuf",{C_STRING,C_INT},C_INT)

public function pdfbuf(sequence buf,atom nmax)
	return c_func(xpdfbuf,{buf,nmax})
end function

public constant xpdfmod = define_c_proc(dis,"+pdfmod",{C_STRING,C_STRING})

public procedure pdfmod(sequence cmod,sequence ckey)
	c_proc(xpdfmod,{cmod,ckey})
end procedure

public constant xpdfmrk = define_c_proc(dis,"+pdfmrk",{C_STRING,C_STRING})

public procedure pdfmrk(sequence cstr,sequence copt)
	c_proc(xpdfmrk,{cstr,copt})
end procedure

public constant xpenwid = define_c_proc(dis,"+penwid",{C_FLOAT})

public procedure penwid(atom x)
	c_proc(xpenwid,{x})
end procedure

public constant xpie = define_c_proc(dis,"+pie",{C_INT,C_INT,C_INT,C_FLOAT,C_FLOAT})

public procedure pie(atom nxm,atom nym,atom nr,atom a,atom b)
	c_proc(xpie,{nxm,nym,nr,a,b})
end procedure

public constant xpiebor = define_c_proc(dis,"+piebor",{C_INT})

public procedure piebor(atom iclr)
	c_proc(xpiebor,{iclr})
end procedure

public function pie_callback()
	return 0
end function

atom pie_id = routine_id("pie_callback")
object pie_cb = call_back(pie_id)

public constant xpiecbk = define_c_proc(dis,"+piecbk",{C_POINTER,C_INT,C_FLOAT,C_FLOAT,C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_POINTER})

public procedure piecbk(object x=pie_cb,atom iseg,atom xdat,atom xper,atom nrad,atom noff,atom angle,atom nvx,atom nvy,atom idrw,atom iann)
	c_proc(xpiecbk,{x,iseg,xdat,xper,nrad,noff,angle,nvx,nvy,idrw,iann})
end procedure

public constant xpieclr = define_c_proc(dis,"+pieclr",{C_POINTER,C_POINTER,C_INT})

public procedure pieclr(atom ic1,atom ic2,atom n)
	c_proc(xpieclr,{ic1,ic2,n})
end procedure

public constant xpieexp = define_c_proc(dis,"+pieexp",{})

public procedure pieexp()
	c_proc(xpieexp,{})
end procedure

public constant xpiegrf = define_c_proc(dis,"+piegrf",{C_STRING,C_INT,C_POINTER,C_INT})

public procedure piegrf(sequence cbuf,atom nlin,atom xray,atom nseg)
	c_proc(xpiegrf,{cbuf,nlin,xray,nseg})
end procedure

public constant xpielab = define_c_proc(dis,"+pielab",{C_STRING,C_STRING})

public procedure pielab(sequence clab,sequence cpos)
	c_proc(xpielab,{clab,cpos})
end procedure

public constant xpieopt = define_c_proc(dis,"+pieopt",{C_FLOAT,C_FLOAT})

public procedure pieopt(atom xf,atom a)
	c_proc(xpieopt,{xf,a})
end procedure

public constant xpierot = define_c_proc(dis,"+pierot",{C_FLOAT})

public procedure pierot(atom angle)
	c_proc(xpierot,{angle})
end procedure

public constant xpietyp = define_c_proc(dis,"+pietyp",{C_STRING})

public procedure pietyp(sequence ctyp)
	c_proc(xpietyp,{ctyp})
end procedure

public constant xpieval = define_c_proc(dis,"+pieval",{C_FLOAT,C_STRING})

public procedure pieval(atom x,sequence copt)
	c_proc(xpieval,{x,copt})
end procedure

public constant xpievec = define_c_proc(dis,"+pievec",{C_INT,C_STRING})

public procedure pievec(atom ivec,sequence copt)
	c_proc(xpievec,{ivec,copt})
end procedure

public constant xpike3d = define_c_proc(dis,"+pike3d",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,C_INT})

public procedure pike3d(atom x1,atom y1,atom z1,atom x2,atom y2,atom z2,atom r,atom nsk1,atom nsk2)
	c_proc(xpike3d,{x1,y1,z1,x2,y2,z2,r,nsk1,nsk2})
end procedure

public constant xplat3d = define_c_proc(dis,"+plat3d",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_STRING})

public procedure plat3d(atom xm,atom ym,atom zm,atom xl,sequence copt)
	c_proc(xplat3d,{xm,ym,zm,xl,copt})
end procedure

public constant xplyfin = define_c_proc(dis,"+plyfin",{C_STRING,C_STRING})

public procedure plyfin(sequence cfl,sequence cobj)
	c_proc(xplyfin,{cfl,cobj})
end procedure

public constant xplyini = define_c_proc(dis,"+plyini",{C_STRING})

public procedure plyini(sequence copt)
	c_proc(xplyini,{copt})
end procedure

public constant xpngmod = define_c_proc(dis,"+pngmod",{C_STRING,C_STRING})

public procedure pngmod(sequence cmod,sequence ckey)
	c_proc(xpngmod,{cmod,ckey})
end procedure

public constant xpoint = define_c_proc(dis,"+point",{C_INT,C_INT,C_INT,C_INT,C_INT})

public procedure point(atom nx,atom ny,atom nb,atom nh,atom ncol)
	c_proc(xpoint,{nx,ny,nb,nh,ncol})
end procedure

public constant xpolar = define_c_proc(dis,"+polar",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure polar(atom xe,atom xorg,atom xstp,atom yorg,atom ystp)
	c_proc(xpolar,{xe,xorg,xstp,yorg,ystp})
end procedure

public constant xpolclp = define_c_func(dis,"+polclp",{C_POINTER,C_POINTER,C_INT,C_POINTER,C_POINTER,C_INT,C_FLOAT,C_STRING},C_INT)

public function polclp(atom xray,atom yray,atom n,atom xout,atom yout,atom nmax,atom xv,sequence cedge)
	return c_func(xpolclp,{xray,yray,n,xout,yout,nmax,xv,cedge})
end function

public constant xpolcrv = define_c_proc(dis,"+polcrv",{C_STRING})

public procedure polcrv(sequence cpol)
	c_proc(xpolcrv,{cpol})
end procedure

public constant xpolmod = define_c_proc(dis,"+polmod",{C_STRING,C_STRING})

public procedure polmod(sequence cpos,sequence cdir)
	c_proc(xpolmod,{cpos,cdir})
end procedure

public constant xpos2pt = define_c_proc(dis,"+pos2pt",{C_FLOAT,C_FLOAT,C_POINTER,C_POINTER})

public procedure pos2pt(atom x,atom y,atom xp,atom yp)
	c_proc(xpos2pt,{x,y,xp,yp})
end procedure

public constant xpos3pt = define_c_proc(dis,"+pos3pt",{C_FLOAT,C_FLOAT,C_FLOAT,C_POINTER,C_POINTER,C_POINTER})

public procedure pos3pt(atom x,atom y,atom z,atom xp,atom yp,atom zp)
	c_proc(xpos3pt,{x,y,z,xp,yp,zp})
end procedure

public constant xposbar = define_c_proc(dis,"+posbar",{C_STRING})

public procedure posbar(sequence copt)
	c_proc(xposbar,{copt})
end procedure

public constant xposifl = define_c_func(dis,"+posifl",{C_INT,C_INT},C_INT)

public function posifl(atom nu,atom nbyte)
	return c_func(xposifl,{nu,nbyte})
end function

public constant xproj3d = define_c_proc(dis,"+proj3d",{C_STRING})

public procedure proj3d(sequence copt)
	c_proc(xproj3d,{copt})
end procedure

public constant xprojct = define_c_proc(dis,"+projct",{C_STRING})

public procedure projct(sequence cproj)
	c_proc(xprojct,{cproj})
end procedure

public constant xpsfont = define_c_proc(dis,"+psfont",{C_STRING})

public procedure psfont(sequence cfont)
	c_proc(xpsfont,{cfont})
end procedure

public constant xpsmeta = define_c_proc(dis,"+psmeta",{C_STRING,C_STRING})

public procedure psmeta(sequence cinf,sequence copt)
	c_proc(xpsmeta,{cinf,copt})
end procedure

public constant xpsmode = define_c_proc(dis,"+psmode",{C_STRING})

public procedure psmode(sequence cmod)
	c_proc(xpsmode,{cmod})
end procedure

public constant xpt2pos = define_c_proc(dis,"+pt2pos",{C_FLOAT,C_FLOAT,C_POINTER,C_POINTER})

public procedure pt2pos(atom x,atom y,atom xp,atom yp)
	c_proc(xpt2pos,{x,y,xp,yp})
end procedure

public constant xpyra3d = define_c_proc(dis,"+pyra3d",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_INT})

public procedure pyra3d(atom xm,atom ym,atom zm,atom xl,atom h1,atom h2,atom n)
	c_proc(xpyra3d,{xm,ym,zm,xl,h1,h2,n})
end procedure

public constant xqplbar = define_c_proc(dis,"+qplbar",{C_POINTER,C_INT})

public procedure qplbar(atom yray,atom n)
	c_proc(xqplbar,{yray,n})
end procedure

public constant xqplclr = define_c_proc(dis,"+qplclr",{C_POINTER,C_INT,C_INT})

public procedure qplclr(atom zmat,atom n,atom m)
	c_proc(xqplclr,{zmat,n,m})
end procedure

public constant xqplcrv = define_c_proc(dis,"+qplcrv",{C_POINTER,C_POINTER,C_INT,C_STRING})

public procedure qplcrv(atom xray,atom yray,atom n,sequence copt)
	c_proc(xqplcrv,{xray,yray,n,copt})
end procedure

public constant xqplcon = define_c_proc(dis,"+qplcon",{C_POINTER,C_INT,C_INT,C_INT})

public procedure qplcon(atom zmat,atom n,atom m,atom nlv)
	c_proc(xqplcon,{zmat,n,m,nlv})
end procedure

public constant xqplot = define_c_proc(dis,"+qplot",{C_POINTER,C_POINTER,C_INT})

public procedure qplot(atom xray,atom yray,atom n)
	c_proc(xqplot,{xray,yray,n})
end procedure

public constant xqplpie = define_c_proc(dis,"+qplpie",{C_POINTER,C_INT})

public procedure qplpie(atom xray,atom n)
	c_proc(xqplpie,{xray,n})
end procedure

public constant xqplsca = define_c_proc(dis,"+qplsca",{C_POINTER,C_POINTER,C_INT})

public procedure qplsca(atom xray,atom yray,atom n)
	c_proc(xqplsca,{xray,yray,n})
end procedure

public constant xqplscl = define_c_proc(dis,"+qplscl",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_STRING})

public procedure qplscl(atom a,atom e,atom org,atom stp,sequence copt)
	c_proc(xqplscl,{a,e,org,stp,copt})
end procedure

public constant xqplsur = define_c_proc(dis,"+qplsur",{C_POINTER,C_INT,C_INT})

public procedure qplsur(atom zmat,atom n,atom m)
	c_proc(xqplsur,{zmat,n,m})
end procedure

public constant xquad3d = define_c_proc(dis,"+quad3d",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure quad3d(atom xm,atom ym,atom zm,atom xl,atom yl,atom zl)
	c_proc(xquad3d,{xm,ym,zm,xl,yl,zl})
end procedure

public constant xrbfpng = define_c_func(dis,"+rbfpng",{C_STRING,C_INT},C_INT)

public function rbfpng(sequence cbuf,atom nmax)
	return c_func(xrbfpng,{cbuf,nmax})
end function

public constant xrbmp = define_c_proc(dis,"+rbmp",{C_STRING})

public procedure rbmp(sequence cfil)
	c_proc(xrbmp,{cfil})
end procedure

public constant xreadfl = define_c_func(dis,"+readfl",{C_INT,C_POINTER,C_INT},C_INT)

public function readfl(atom nu,sequence cbuf,atom nbyte)
	return c_func(xreadfl,{nu,cbuf,nbyte})
end function

public constant xreawgt = define_c_proc(dis,"+reawgt",{})

public procedure reawgt()
	c_proc(xreawgt,{})
end procedure

public constant xrecfll = define_c_proc(dis,"+recfll",{C_INT,C_INT,C_INT,C_INT,C_INT})

public procedure recfll(atom nx,atom ny,atom nw,atom nh,atom ncol)
	c_proc(xrecfll,{nx,ny,nw,nh,ncol})
end procedure

public constant xrectan = define_c_proc(dis,"+rectan",{C_INT,C_INT,C_INT,C_INT})

public procedure rectan(atom nx,atom ny,atom nw,atom nh)
	c_proc(xrectan,{nx,ny,nw,nh})
end procedure

public constant xrel3pt = define_c_proc(dis,"+rel3pt",{C_FLOAT,C_FLOAT,C_FLOAT,C_POINTER,C_POINTER})

public procedure rel3pt(atom x,atom y,atom z,atom xp,atom yp)
	c_proc(xrel3pt,{x,y,z,xp,yp})
end procedure

public constant xresatt = define_c_proc(dis,"+resatt",{})

public procedure resatt()
	c_proc(xresatt,{})
end procedure

public constant xreset = define_c_proc(dis,"+reset",{C_STRING})

public procedure reset(sequence cname)
	c_proc(xreset,{cname})
end procedure

public constant xrevscr = define_c_proc(dis,"+revscr",{})

public procedure revscr()
	c_proc(xrevscr,{})
end procedure

public constant xrgbhsv = define_c_proc(dis,"+rgbhsv",{C_FLOAT,C_FLOAT,C_FLOAT,C_POINTER,C_POINTER,C_POINTER})

public procedure rgbhsv(atom xr,atom xg,atom xb,atom xh,atom xs,atom xv)
	c_proc(xrgbhsv,{xr,xg,xb,xh,xs,xv})
end procedure

public constant xrgif = define_c_proc(dis,"+rgif",{C_STRING})

public procedure rgif(sequence cfil)
	c_proc(xrgif,{cfil})
end procedure

public constant xrgtlab = define_c_proc(dis,"+rgtlab",{})

public procedure rgtlab()
	c_proc(xrgtlab,{})
end procedure

public constant xrimage = define_c_proc(dis,"+rimage",{C_STRING})

public procedure rimage(sequence cfil)
	c_proc(xrimage,{cfil})
end procedure

public constant xrlarc = define_c_proc(dis,"+rlarc",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure rlarc(atom xm,atom ym,atom xa,atom xb,atom a,atom b,atom t)
	c_proc(xrlarc,{xm,ym,xa,xb,a,b,t})
end procedure

public constant xrlarea = define_c_proc(dis,"+rlarea",{C_POINTER,C_POINTER,C_INT})

public procedure rlarea(atom xray,atom yray,atom n)
	c_proc(xrlarea,{xray,yray,n})
end procedure

public constant xrlcirc = define_c_proc(dis,"+rlcirc",{C_FLOAT,C_FLOAT,C_FLOAT})

public procedure rlcirc(atom xm,atom ym,atom r)
	c_proc(xrlcirc,{xm,ym,r})
end procedure

public constant xrlconn = define_c_proc(dis,"+rlconn",{C_FLOAT,C_FLOAT})

public procedure rlconn(atom x,atom y)
	c_proc(xrlconn,{x,y})
end procedure

public constant xrlell = define_c_proc(dis,"+rlell",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure rlell(atom xm,atom ym,atom a,atom b)
	c_proc(xrlell,{xm,ym,a,b})
end procedure

public constant xrline = define_c_proc(dis,"+rline",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure rline(atom x,atom y,atom u,atom v)
	c_proc(xrline,{x,y,u,v})
end procedure

public constant xrlmess = define_c_proc(dis,"+rlmess",{C_STRING,C_FLOAT,C_FLOAT})

public procedure rlmess(sequence cstr,atom x,atom y)
	c_proc(xrlmess,{cstr,x,y})
end procedure

public constant xrlnumb = define_c_proc(dis,"+rlnumb",{C_FLOAT,C_INT,C_FLOAT,C_FLOAT})

public procedure rlnumb(atom x,atom ndig,atom xp,atom yp)
	c_proc(xrlnumb,{x,ndig,xp,yp})
end procedure

public constant xrlpie = define_c_proc(dis,"+rlpie",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure rlpie(atom xm,atom ym,atom r,atom a,atom b)
	c_proc(xrlpie,{xm,ym,r,a,b})
end procedure

public constant xrlpoin = define_c_proc(dis,"+rlpoin",{C_FLOAT,C_FLOAT,C_INT,C_INT,C_INT})

public procedure rlpoin(atom x,atom y,atom nb,atom nh,atom ncol)
	c_proc(xrlpoin,{x,y,nb,nh,ncol})
end procedure

public constant xrlrec = define_c_proc(dis,"+rlrec",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure rlrec(atom x,atom y,atom xw,atom xh)
	c_proc(xrlrec,{x,y,xw,xh})
end procedure

public constant xrlrnd = define_c_proc(dis,"+rlrnd",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_INT})

public procedure rlrnd(atom x,atom y,atom xb,atom xh,atom irnd)
	c_proc(xrlrnd,{x,y,xb,xh,irnd})
end procedure

public constant xrlsec = define_c_proc(dis,"+rlsec",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_INT})

public procedure rlsec(atom xm,atom ym,atom r1,atom r2,atom a,atom b,atom ncol)
	c_proc(xrlsec,{xm,ym,r1,r2,a,b,ncol})
end procedure

public constant xrlsymb = define_c_proc(dis,"+rlsymb",{C_INT,C_FLOAT,C_FLOAT})

public procedure rlsymb(atom nsym,atom x,atom y)
	c_proc(xrlsymb,{nsym,x,y})
end procedure

public constant xrlvec = define_c_proc(dis,"+rlvec",{C_FLOAT,C_FLOAT,C_FLOAT,C_INT})

public procedure rlvec(atom x1,atom y1,atom x2,atom y2,atom ivec)
	c_proc(xrlvec,{x1,y1,x2,y2,ivec})
end procedure

public constant xrlwind = define_c_proc(dis,"+rlwind",{C_FLOAT,C_FLOAT,C_FLOAT,C_INT,C_FLOAT})

public procedure rlwind(atom xk,atom x,atom y,atom nwidth,atom a)
	c_proc(xrlwind,{xk,x,y,nwidth,a})
end procedure

public constant xrndrec = define_c_proc(dis,"+rndrec",{C_INT,C_INT,C_INT,C_INT,C_INT})

public procedure rndrec(atom nx,atom ny,atom nb,atom nh,atom irnd)
	c_proc(xrndrec,{nx,ny,nb,nh,irnd})
end procedure

public constant xrot3d = define_c_proc(dis,"+rot3d",{C_FLOAT,C_FLOAT,C_FLOAT})

public procedure rot3d(atom xa,atom ya,atom za)
	c_proc(xrot3d,{xa,ya,za})
end procedure

public constant xrpixel = define_c_proc(dis,"+rpixel",{C_INT,C_INT,C_POINTER})

public procedure rpixel(atom ix,atom iy,atom iclr)
	c_proc(xrpixel,{ix,iy,iclr})
end procedure

public constant xrpixls = define_c_proc(dis,"+rpixls",{C_POINTER,C_INT,C_INT,C_INT,C_INT})

public procedure rpixls(atom iray,atom ix,atom iy,atom nw,atom nh)
	c_proc(xrpixls,{iray,ix,iy,nw,nh})
end procedure

public constant xrpng = define_c_proc(dis,"+rpng",{C_STRING})

public procedure rpng(sequence cfil)
	c_proc(xrpng,{cfil})
end procedure

public constant xrppm = define_c_proc(dis,"+rppm",{C_STRING})

public procedure rppm(sequence cfil)
	c_proc(xrppm,{cfil})
end procedure

public constant xrpxrow = define_c_proc(dis,"+rpxrow",{C_POINTER,C_INT,C_INT,C_INT})

public procedure rpxrow(sequence iray,atom ix,atom iy,atom n)
	c_proc(xrpxrow,{iray,ix,iy,n})
end procedure

public constant xrtiff = define_c_proc(dis,"+rtiff",{C_STRING})

public procedure rtiff(sequence cfil)
	c_proc(xrtiff,{cfil})
end procedure

public constant xrvynam = define_c_proc(dis,"+rvynam",{})

public procedure rvynam()
	c_proc(xrvynam,{})
end procedure

public constant xscale = define_c_proc(dis,"+scale",{C_STRING,C_STRING})

public procedure scale(sequence cscl,sequence cax)
	c_proc(xscale,{cscl,cax})
end procedure

public constant xsclfac = define_c_proc(dis,"+sclfac",{C_FLOAT})

public procedure sclfac(atom xfac)
	c_proc(xsclfac,{xfac})
end procedure

public constant xsclmod = define_c_proc(dis,"+sclmod",{C_STRING})

public procedure sclmod(sequence cmode)
	c_proc(xsclmod,{cmode})
end procedure

public constant xscrmod = define_c_proc(dis,"+scrmod",{C_STRING})

public procedure scrmod(sequence cmode)
	c_proc(xscrmod,{cmode})
end procedure

public constant xsector = define_c_proc(dis,"+sector",{C_INT,C_INT,C_INT,C_INT,C_FLOAT,C_FLOAT,C_INT})

public procedure sector(atom nx,atom ny,atom nr1,atom nr2,atom a,atom b,atom ncol)
	c_proc(xsector,{nx,ny,nr1,nr2,a,b,ncol})
end procedure

public constant xselwin = define_c_proc(dis,"+selwin",{C_INT})

public procedure selwin(atom id)
	c_proc(xselwin,{id})
end procedure

public constant xsendbf = define_c_proc(dis,"+sendbf",{})

public procedure sendbf()
	c_proc(xsendbf,{})
end procedure

public constant xsendmb = define_c_proc(dis,"+sendmb",{})

public procedure sendmb()
	c_proc(xsendmb,{})
end procedure

public constant xsendok = define_c_proc(dis,"+sendok",{})

public procedure sendok()
	c_proc(xsendok,{})
end procedure

public constant xserif = define_c_proc(dis,"+serif",{})

public procedure serif()
	c_proc(xserif,{})
end procedure

public function set_cb()
	return 0
end function

atom set_id = routine_id("set_cb")
object set_cb1 = call_back(set_id)

public constant xsetcbk = define_c_proc(dis,"+setcbk",{C_POINTER,C_POINTER,C_POINTER,C_STRING})

public procedure setcbk(object cb = set_cb1,atom x,atom y,sequence copt)
	c_proc(xsetcbk,{cb,x,y,copt})
end procedure

public constant xsetclr = define_c_proc(dis,"+setclr",{C_INT})

public procedure setclr(atom ncol)
	c_proc(xsetclr,{ncol})
end procedure

public constant xsetcsr = define_c_proc(dis,"+setcsr",{C_STRING})

public procedure setcsr(sequence copt)
	c_proc(xsetcsr,{copt})
end procedure

public constant xsetexp = define_c_proc(dis,"+setexp",{C_FLOAT})

public procedure setexp(atom fexp)
	c_proc(xsetexp,{fexp})
end procedure

public constant xsetfce = define_c_proc(dis,"+setfce",{C_STRING})

public procedure setfce(sequence copt)
	c_proc(xsetfce,{copt})
end procedure

public constant xsetfil = define_c_proc(dis,"+setfil",{C_STRING})

public procedure setfil(sequence cfil)
	c_proc(xsetfil,{cfil})
end procedure

public constant xsetgrf = define_c_proc(dis,"+setgrf",{C_STRING,C_STRING,C_STRING,C_STRING})

public procedure setgrf(sequence c1,sequence c2,sequence c3,sequence c4)
	c_proc(xsetgrf,{c1,c2,c3,c4})
end procedure

public constant xsetind = define_c_proc(dis,"+setind",{C_INT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure setind(atom index,atom xr,atom xg,atom xb)
	c_proc(xsetind,{index,xr,xg,xb})
end procedure

public constant xsetmix = define_c_proc(dis,"+setmix",{C_STRING,C_STRING})

public procedure setmix(sequence cstr,sequence cmix)
	c_proc(xsetmix,{cstr,cmix})
end procedure

public constant xsetpag = define_c_proc(dis,"+setpag",{C_STRING})

public procedure setpag(sequence cpag)
	c_proc(xsetpag,{cpag})
end procedure

public constant xsetres = define_c_proc(dis,"+setres",{C_INT,C_INT})

public procedure setres(atom npb,atom nph)
	c_proc(xsetres,{npb,nph})
end procedure

public constant xsetres3d = define_c_proc(dis,"+setres3d",{C_FLOAT,C_FLOAT,C_FLOAT})

public procedure setres3d(atom xl,atom yl,atom zl)
	c_proc(xsetres3d,{xl,yl,zl})
end procedure

public constant xsetrgb = define_c_proc(dis,"+setrgb",{C_FLOAT,C_FLOAT,C_FLOAT})

public procedure setrgb(atom xr,atom xg,atom xb)
	c_proc(xsetrgb,{xr,xg,xb})
end procedure

public constant xsetscl = define_c_proc(dis,"+setscl",{C_POINTER,C_INT,C_STRING})

public procedure setscl(atom xray,atom n,sequence cax)
	c_proc(xsetscl,{xray,n,cax})
end procedure

public constant xsetvlt = define_c_proc(dis,"+setvlt",{C_STRING})

public procedure setvlt(sequence cvlt)
	c_proc(xsetvlt,{cvlt})
end procedure

public constant xsetxid = define_c_proc(dis,"+setxid",{C_INT,C_STRING})

public procedure setxid(atom id,sequence copt)
	c_proc(xsetxid,{id,copt})
end procedure

public constant xshdafr = define_c_proc(dis,"+shdafr",{C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure shdafr(atom inray,atom ipray,atom icray,atom n)
	c_proc(xshdafr,{inray,ipray,icray,n})
end procedure

public constant xshdmod = define_c_proc(dis,"+shdmod",{C_STRING,C_STRING})

public procedure shdmod(sequence copt,sequence ctyp)
	c_proc(xshdmod,{copt,ctyp})
end procedure

public constant xshdasi = define_c_proc(dis,"+shdasi",{C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure shdasi(atom inray,atom ipray,atom icray,atom n)
	c_proc(xshdasi,{inray,ipray,icray,n})
end procedure

public constant xshdaus = define_c_proc(dis,"+shdaus",{C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure shdaus(atom inray,atom ipray,atom icray,atom n)
	c_proc(xshdaus,{inray,ipray,icray,n})
end procedure

public constant xshdcha = define_c_proc(dis,"+shdcha",{})

public procedure shdcha()
	c_proc(xshdcha,{})
end procedure

public constant xshdcrv = define_c_proc(dis,"+shdcrv",{C_POINTER,C_POINTER,C_INT,C_POINTER,C_POINTER,C_INT})

public procedure shdcrv(atom x1ray,atom y1ray,atom n1,atom x2ray,atom y2ray,atom n2)
	c_proc(xshdcrv,{x1ray,y1ray,n1,x2ray,y2ray,n2})
end procedure

public constant xshdeur = define_c_proc(dis,"+shdeur",{C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure shdeur(atom inray,atom ipray,atom icray,atom n)
	c_proc(xshdeur,{inray,ipray,icray,n})
end procedure

public constant xshdfac = define_c_proc(dis,"+shdfac",{C_FLOAT})

public procedure shdfac(atom xfac)
	c_proc(xshdfac,{xfac})
end procedure

public constant xshdmap = define_c_proc(dis,"+shdmap",{C_STRING})

public procedure shdmap(sequence cmap)
	c_proc(xshdmap,{cmap})
end procedure

public constant xshdnor = define_c_proc(dis,"+shdnor",{C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure shdnor(atom inray,atom ipray,atom icray,atom n)
	c_proc(xshdnor,{inray,ipray,icray,n})
end procedure

public constant xshdpat = define_c_proc(dis,"+shdpat",{C_LONG})

public procedure shdpat(atom ipat)
	c_proc(xshdpat,{ipat})
end procedure

public constant xshdsou = define_c_proc(dis,"+shdsou",{C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure shdsou(atom inray,atom ipray,atom icray,atom n)
	c_proc(xshdsou,{inray,ipray,icray,n})
end procedure

public constant xshdusa = define_c_proc(dis,"+shdusa",{C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure shdusa(atom inray,atom ipray,atom icray,atom n)
	c_proc(xshdusa,{inray,ipray,icray,n})
end procedure

public constant xshield = define_c_proc(dis,"+shield",{C_STRING,C_STRING})

public procedure shield(sequence carea,sequence cmode)
	c_proc(xshield,{carea,cmode})
end procedure

public constant xshlcir = define_c_proc(dis,"+shlcir",{C_INT,C_INT,C_INT})

public procedure shlcir(atom nx,atom ny,atom nr)
	c_proc(xshlcir,{nx,ny,nr})
end procedure

public constant xshldel = define_c_proc(dis,"+shldel",{C_INT})

public procedure shldel(atom id)
	c_proc(xshldel,{id})
end procedure

public constant xshlell = define_c_proc(dis,"+shlell",{C_INT,C_INT,C_INT,C_INT,C_FLOAT})

public procedure shlell(atom nx,atom ny,atom na,atom nb,atom t)
	c_proc(xshlell,{nx,ny,na,nb,t})
end procedure

public constant xshlind = define_c_func(dis,"+shlind",{},C_INT)

public function shlind()
	return c_func(xshlind,{})
end function

public constant xshlpie = define_c_proc(dis,"+shlpie",{C_INT,C_INT,C_INT,C_FLOAT,C_FLOAT})

public procedure shlpie(atom nx,atom ny,atom nr,atom a,atom b)
	c_proc(xshlpie,{nx,ny,nr,a,b})
end procedure

public constant xshlpol = define_c_proc(dis,"+shlpol",{C_POINTER,C_POINTER,C_INT})

public procedure shlpol(atom nxray,atom nyray,atom n)
	c_proc(xshlpol,{nxray,nyray,n})
end procedure

public constant xshlrct = define_c_proc(dis,"+shlrct",{C_INT,C_INT,C_INT,C_INT,C_FLOAT})

public procedure shlrct(atom nx,atom ny,atom nw,atom nh,atom t)
	c_proc(xshlrct,{nx,ny,nw,nh,t})
end procedure

public constant xshlrec = define_c_proc(dis,"+shlrec",{C_INT,C_INT,C_INT,C_INT})

public procedure shlrec(atom nx,atom ny,atom nw,atom nh)
	c_proc(xshlrec,{nx,ny,nw,nh})
end procedure

public constant xshlres = define_c_proc(dis,"+shlres",{C_INT})

public procedure shlres(atom n)
	c_proc(xshlres,{n})
end procedure

public constant xshlsur = define_c_proc(dis,"+shlsur",{})

public procedure shlsur()
	c_proc(xshlsur,{})
end procedure

public constant xshlvis = define_c_proc(dis,"+shlvis",{C_INT,C_STRING})

public procedure shlvis(atom id,sequence cmode)
	c_proc(xshlvis,{id,cmode})
end procedure

public constant xsimplx = define_c_proc(dis,"+simplx",{})

public procedure simplx()
	c_proc(xsimplx,{})
end procedure

public constant xskipfl = define_c_func(dis,"+skipfl",{C_INT,C_INT},C_INT)

public function skipfl(atom nu,atom nbyte)
	return c_func(xskipfl,{nu,nbyte})
end function

public constant xsmxalf = define_c_proc(dis,"+smxalf",{C_STRING,C_STRING,C_STRING,C_INT})

public procedure smxalf(sequence calph,sequence c1,sequence c2,atom n)
	c_proc(xsmxalf,{calph,c1,c2,n})
end procedure

public constant xsolid = define_c_proc(dis,"+solid",{})

public procedure solid()
	c_proc(xsolid,{})
end procedure

public constant xsortr1 = define_c_proc(dis,"+sortr1",{C_POINTER,C_INT,C_STRING})

public procedure sortr1(atom xray,atom n,sequence copt)
	c_proc(xsortr1,{xray,n,copt})
end procedure

public constant xsortr2 = define_c_proc(dis,"+sortr2",{C_POINTER,C_POINTER,C_INT,C_STRING})

public procedure sortr2(atom xray,atom yray,atom n,sequence copt)
	c_proc(xsortr2,{xray,yray,n,copt})
end procedure

public constant xspcbar = define_c_proc(dis,"+spcbar",{C_INT})

public procedure spcbar(atom n)
	c_proc(xspcbar,{n})
end procedure

public constant xsphe3d = define_c_proc(dis,"+sphe3d",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,C_INT})

public procedure sphe3d(atom xm,atom ym,atom zm,atom r,atom n,atom m)
	c_proc(xsphe3d,{xm,ym,zm,r,n,m})
end procedure

public constant xspline = define_c_proc(dis,"+spline",{C_POINTER,C_POINTER,C_INT,C_POINTER,C_POINTER,C_POINTER})

public procedure spline(atom xray,atom yray,atom n,atom xsray,atom ysray,atom nspl)
	c_proc(xspline,{xray,yray,n,xsray,ysray,nspl})
end procedure

public constant xsplmod = define_c_proc(dis,"+splmod",{C_INT,C_INT})

public procedure splmod(atom ngrad,atom npts)
	c_proc(xsplmod,{ngrad,npts})
end procedure

public constant xstmmod = define_c_proc(dis,"+stmmod",{C_STRING,C_STRING})

public procedure stmmod(sequence cmod,sequence ckey)
	c_proc(xstmmod,{cmod,ckey})
end procedure

public constant xstmopt = define_c_proc(dis,"+stmopt",{C_INT,C_STRING})

public procedure stmopt(atom n,sequence copt)
	c_proc(xstmopt,{n,copt})
end procedure

public constant xstmpts = define_c_proc(dis,"+stmpts",{C_POINTER,C_POINTER,C_INT,C_INT,C_POINTER,C_POINTER,C_FLOAT,C_FLOAT,C_POINTER,C_POINTER,C_INT,C_POINTER})

public procedure stmpts(atom xmat,atom ymat,atom nx,atom ny,atom xp,atom yp,atom x0,atom y0,atom xray,atom yray,atom nmax,atom nray)
	c_proc(xstmpts,{xmat,ymat,nx,ny,xp,yp,x0,y0,xray,yray,nmax,nray})
end procedure

public constant xstmpts3d = define_c_proc(dis,"+stmpts3d",{C_POINTER,C_POINTER,C_POINTER,C_INT,C_INT,C_INT,C_POINTER,C_POINTER,C_POINTER,C_FLOAT,C_FLOAT,C_FLOAT,C_POINTER,C_POINTER,C_POINTER,C_INT,C_POINTER})

public procedure stmpts3d(atom xv,atom yv,atom zv,atom nx,atom ny,atom nz,atom xp,atom yp,atom zp,atom x0,atom y0,atom z0,atom xray,atom yray,atom zray,atom nmax,atom nray)
	c_proc(xstmpts3d,{xv,yv,zv,nx,ny,nz,xp,yp,zp,x0,y0,z0,xray,yray,zray,nmax,nray})
end procedure

public constant xstmtri = define_c_proc(dis,"+stmtri",{C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_INT,C_POINTER,C_POINTER,C_POINTER,C_INT,C_POINTER,C_POINTER,C_INT})

public procedure stmtri(atom xv,atom yv,atom xp,atom yp,atom n,atom i1ray,atom i2ray,atom i3ray,atom ntri,atom xs,atom ys,atom nray)
	c_proc(xstmtri,{xv,yv,xp,yp,n,i1ray,i2ray,i3ray,ntri,xs,ys,nray})
end procedure

public constant xstmval = define_c_proc(dis,"+stmval",{C_FLOAT,C_STRING})

public procedure stmval(atom x,sequence copt)
	c_proc(xstmval,{x,copt})
end procedure

public constant xstream = define_c_proc(dis,"+stream",{C_POINTER,C_POINTER,C_INT,C_INT,C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure stream(atom xmat,atom ymat,atom nx,atom ny,atom xp,atom yp,atom xs,atom ys,atom n)
	c_proc(xstream,{xmat,ymat,nx,ny,xp,yp,xs,ys,n})
end procedure

public constant xstream3d = define_c_proc(dis,"+stream3d",{C_POINTER,C_POINTER,C_POINTER,C_INT,C_INT,C_INT,C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure stream3d(atom xv,atom yv,atom zv,atom nx,atom ny,atom nz,atom xp,atom yp,atom zp,atom xs,atom ys,atom zs,atom n)
	c_proc(xstream3d,{xv,yv,zv,nx,ny,nz,xp,yp,zp,xs,ys,zs,n})
end procedure

public constant xstrt3d = define_c_proc(dis,"+strt3d",{C_FLOAT,C_FLOAT,C_FLOAT})

public procedure strt3d(atom x,atom y,atom z)
	c_proc(xstrt3d,{x,y,z})
end procedure

public constant xstrtpt = define_c_proc(dis,"+strtpt",{C_FLOAT,C_FLOAT})

public procedure strtpt(atom x,atom y)
	c_proc(xstrtpt,{x,y})
end procedure

public constant xsurclr = define_c_proc(dis,"+surclr",{C_INT,C_INT})

public procedure surclr(atom ictop,atom icbot)
	c_proc(xsurclr,{ictop,icbot})
end procedure

public constant xsurfce = define_c_proc(dis,"+surfce",{C_POINTER,C_INT,C_POINTER,C_INT,C_POINTER})

public procedure surfce(atom xray,atom n,atom yray,atom m,atom zmat)
	c_proc(xsurfce,{xray,n,yray,m,zmat})
end procedure

public constant xsurfcp = define_c_proc(dis,"+surfcp",{C_POINTER,C_FLOAT,C_FLOAT,C_INT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure surfcp(object zfun,atom x,atom y,atom i,atom a1,atom a2,atom astp,atom b1,atom b2,atom bstp)
	c_proc(xsurfcp,{zfun,x,y,i,a1,a2,astp,b1,b2,bstp})
end procedure

public constant xsurfun = define_c_proc(dis,"+surfun",{C_POINTER,C_FLOAT,C_FLOAT,C_INT,C_FLOAT,C_INT,C_FLOAT})

public procedure surfun(object zfun,atom x,atom y,atom ixpts,atom xdel,atom iypts,atom ydel)
	c_proc(xsurfun,{zfun,x,y,ixpts,xdel,iypts,ydel})
end procedure

public constant xsuriso = define_c_proc(dis,"+suriso",{C_POINTER,C_INT,C_POINTER,C_INT,C_POINTER,C_INT,C_POINTER,C_FLOAT})

public procedure suriso(atom xray,atom nx,atom yray,atom ny,atom zray,atom nz,atom wmat,atom wlev)
	c_proc(xsuriso,{xray,nx,yray,ny,zray,nz,wmat,wlev})
end procedure

public constant xsurmat = define_c_proc(dis,"+surmat",{C_POINTER,C_INT,C_INT,C_INT,C_INT})

public procedure surmat(atom zmat,atom nx,atom ny,atom ixpts,atom iypts)
	c_proc(xsurmat,{zmat,nx,ny,ixpts,iypts})
end procedure

public constant xsurmsh = define_c_proc(dis,"+surmsh",{C_STRING})

public procedure surmsh(sequence copt)
	c_proc(xsurmsh,{copt})
end procedure

public constant xsuropt = define_c_proc(dis,"+suropt",{C_STRING})

public procedure suropt(sequence copt)
	c_proc(xsuropt,{copt})
end procedure

public constant xsurshc = define_c_proc(dis,"+surshc",{C_POINTER,C_INT,C_POINTER,C_INT,C_POINTER,C_POINTER})

public procedure surshc(atom xray,atom n,atom yray,atom m,atom zmat,atom wmat)
	c_proc(xsurshc,{xray,n,yray,m,zmat,wmat})
end procedure

public constant xsurshd = define_c_proc(dis,"+surshd",{C_POINTER,C_INT,C_POINTER,C_INT,C_POINTER})

public procedure surshd(atom xray,atom n,atom yray,atom m,atom zmat)
	c_proc(xsurshd,{xray,n,yray,m,zmat})
end procedure

public constant xsursze = define_c_proc(dis,"+sursze",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure sursze(atom xmin,atom xmax,atom ymin,atom ymax)
	c_proc(xsursze,{xmin,xmax,ymin,ymax})
end procedure

public constant xsurtri = define_c_proc(dis,"+surtri",{C_POINTER,C_POINTER,C_POINTER,C_INT,C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure surtri(atom xray,atom yray,atom zray,atom n,atom i1ray,atom i2ray,atom i3ray,atom ntri)
	c_proc(xsurtri,{xray,yray,zray,n,i1ray,i2ray,i3ray,ntri})
end procedure

public constant xsurvis = define_c_proc(dis,"+survis",{C_STRING})

public procedure survis(sequence cvis)
	c_proc(xsurvis,{cvis})
end procedure

public constant xswapi2 = define_c_proc(dis,"+swapi2",{C_POINTER,C_INT})

public procedure swapi2(atom iray,atom n)
	c_proc(xswapi2,{iray,n})
end procedure

public constant xswapi4 = define_c_proc(dis,"+swapi4",{C_POINTER,C_INT})

public procedure swapi4(atom iray,atom n)
	c_proc(xswapi4,{iray,n})
end procedure

public constant xswgatt = define_c_proc(dis,"+swgatt",{C_INT,C_STRING,C_STRING})

public procedure swgatt(atom id,sequence cval,sequence copt)
	c_proc(xswgatt,{id,cval,copt})
end procedure

public constant xswgbgd = define_c_proc(dis,"+swgbgd",{C_INT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure swgbgd(atom id,atom xr,atom xg,atom xb)
	c_proc(xswgbgd,{id,xr,xg,xb})
end procedure

public constant xswgbox = define_c_proc(dis,"+swgbox",{C_INT,C_INT})

public procedure swgbox(atom ip,atom ival)
	c_proc(xswgbox,{ip,ival})
end procedure

public constant xswgbut = define_c_proc(dis,"+swgbut",{C_INT,C_INT})

public procedure swgbut(atom ip,atom ival)
	c_proc(xswgbut,{ip,ival})
end procedure

public function swgcb_cb()
	return 0
end function

public atom swcb_id = routine_id("swgcb_cb")
public object swcb_cb = call_back(swcb_id)

public constant xswgcb = define_c_proc(dis,"+swgcb",{C_INT,C_POINTER,C_INT,C_POINTER,C_POINTER})

public procedure swgcb(atom id,object cb=swcb_cb,atom i,atom ir,atom iray)
	c_proc(xswgcb,{id,cb,i,ir,iray})
end procedure

public function swcb_cb2()
	return 0
end function

public atom swcb_id22 = routine_id("swcb_cb2")
public object swcb_cb22 = call_back(swcb_id22)

public constant xswgcb2 = define_c_proc(dis,"+swgcb2",{C_INT,C_POINTER,C_INT,C_INT,C_INT})

public procedure swgcb2(atom id,object cb=swcb_cb22,atom id2,atom irow,atom icol)
	c_proc(xswgcb2,{id,cb,id2,irow,icol})
end procedure

public function swcb_cb3()
	return 0
end function

public atom swcb_id33 = routine_id("swcb_cb3")
public object swcb_cb33 = call_back(swcb_id33)

public constant xswgcb3 = define_c_proc(dis,"+swgcb3",{C_INT,C_POINTER,C_INT,C_INT})

public procedure swgcb3(atom id,object cb=swcb_cb33,atom id2,atom ival)
	c_proc(xswgcb3,{id,cb,id2,ival})
end procedure

public function swg_cb4()
	return 0
end function

public atom swcb_id44 = routine_id("swg_cb4")
public object swcb_cb44 = call_back(swcb_id44)

public constant xswgcbk = define_c_proc(dis,"+swgcbk",{C_INT,C_POINTER,C_INT})

public procedure swgcbk(atom id,object cb=swcb_cb44,atom i)
	c_proc(xswgcbk,{id,cb,i})
end procedure

public constant xswgclr = define_c_proc(dis,"+swgclr",{C_FLOAT,C_FLOAT,C_FLOAT,C_STRING})

public procedure swgclr(atom xr,atom xg,atom xb,sequence copt)
	c_proc(xswgclr,{xr,xg,xb,copt})
end procedure

public constant xswgdrw = define_c_proc(dis,"+swgdrw",{C_FLOAT})

public procedure swgdrw(atom x)
	c_proc(xswgdrw,{x})
end procedure

public constant xswgfgd = define_c_proc(dis,"+swgfgd",{C_INT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure swgfgd(atom id,atom xr,atom xg,atom xb)
	c_proc(xswgfgd,{id,xr,xg,xb})
end procedure

public constant xswgfil = define_c_proc(dis,"+swgfil",{C_INT,C_STRING})

public procedure swgfil(atom ip,sequence cval)
	c_proc(xswgfil,{ip,cval})
end procedure

public constant xswgflt = define_c_proc(dis,"+swgflt",{C_INT,C_FLOAT,C_INT})

public procedure swgflt(atom ip,atom xv,atom ndig)
	c_proc(xswgflt,{ip,xv,ndig})
end procedure

public constant xswgfnt = define_c_proc(dis,"+swgfnt",{C_STRING,C_INT})

public procedure swgfnt(sequence cfnt,atom n)
	c_proc(xswgfnt,{cfnt,n})
end procedure

public constant xswgfoc = define_c_proc(dis,"+swgfoc",{C_INT})

public procedure swgfoc(atom id)
	c_proc(xswgfoc,{id})
end procedure

public constant xswghlp = define_c_proc(dis,"+swghlp",{C_STRING})

public procedure swghlp(sequence cstr)
	c_proc(xswghlp,{cstr})
end procedure

public constant xswgint = define_c_proc(dis,"+swgint",{C_INT,C_INT})

public procedure swgint(atom ip,atom iv)
	c_proc(xswgint,{ip,iv})
end procedure

public constant xswgiop = define_c_proc(dis,"+swgiop",{C_INT,C_STRING})

public procedure swgiop(atom n,sequence copt)
	c_proc(xswgiop,{n,copt})
end procedure

public constant xswgjus = define_c_proc(dis,"+swgjus",{C_STRING,C_STRING})

public procedure swgjus(sequence ctyp,sequence cwidg)
	c_proc(xswgjus,{ctyp,cwidg})
end procedure

public constant xswglis = define_c_proc(dis,"+swglis",{C_INT,C_INT})

public procedure swglis(atom ip,atom ival)
	c_proc(xswglis,{ip,ival})
end procedure

public constant xswgmix = define_c_proc(dis,"+swgmix",{C_STRING,C_STRING})

public procedure swgmix(sequence c,sequence cstr)
	c_proc(xswgmix,{c,cstr})
end procedure

public constant xswgmrg = define_c_proc(dis,"+swgmrg",{C_INT,C_STRING})

public procedure swgmrg(atom ival,sequence cstr)
	c_proc(xswgmrg,{ival,cstr})
end procedure

public constant xswgoff = define_c_proc(dis,"+swgoff",{C_INT,C_INT})

public procedure swgoff(atom nx,atom ny)
	c_proc(xswgoff,{nx,ny})
end procedure

public constant xswgopt = define_c_proc(dis,"+swgopt",{C_STRING,C_STRING})

public procedure swgopt(sequence cval,sequence copt)
	c_proc(xswgopt,{cval,copt})
end procedure

public constant xswgpop = define_c_proc(dis,"+swgpop",{C_STRING})

public procedure swgpop(sequence copt)
	c_proc(xswgpop,{copt})
end procedure

public constant xswgpos = define_c_proc(dis,"+swgpos",{C_INT,C_INT})

public procedure swgpos(atom nx,atom ny)
	c_proc(xswgpos,{nx,ny})
end procedure

public constant xswgray = define_c_proc(dis,"+swgray",{C_POINTER,C_INT,C_STRING})

public procedure swgray(atom xray,atom nray,sequence copt)
	c_proc(xswgray,{xray,nray,copt})
end procedure

public constant xswgscl = define_c_proc(dis,"+swgscl",{C_INT,C_FLOAT})

public procedure swgscl(atom ip,atom xval)
	c_proc(xswgscl,{ip,xval})
end procedure

public constant xswgsiz = define_c_proc(dis,"+swgsiz",{C_INT,C_INT})

public procedure swgsiz(atom nx,atom ny)
	c_proc(xswgsiz,{nx,ny})
end procedure

public constant xswgspc = define_c_proc(dis,"+swgspc",{C_FLOAT,C_FLOAT})

public procedure swgspc(atom xw,atom xh)
	c_proc(xswgspc,{xw,xh})
end procedure

public constant xswgstp = define_c_proc(dis,"+swgstp",{C_FLOAT})

public procedure swgstp(atom step)
	c_proc(xswgstp,{step})
end procedure

public constant xswgtbf = define_c_proc(dis,"+swgtbf",{C_INT,C_FLOAT,C_INT,C_INT,C_INT,C_STRING})

public procedure swgtbf(atom id,atom xval,atom ndig,atom irow,atom icol,sequence copt)
	c_proc(xswgtbf,{id,xval,ndig,irow,icol,copt})
end procedure

public constant xswgtbi = define_c_proc(dis,"+swgtbi",{C_INT,C_INT,C_INT,C_INT,C_STRING})

public procedure swgtbi(atom id,atom ival,atom irow,atom icol,sequence copt)
	c_proc(xswgtbi,{id,ival,irow,icol,copt})
end procedure

public constant xswgtbl = define_c_proc(dis,"+swgtbl",{C_INT,C_POINTER,C_INT,C_INT,C_INT,C_STRING})

public procedure swgtbl(atom id,atom xray,atom nray,atom ndig,atom idx,sequence copt)
	c_proc(xswgtbl,{id,xray,nray,ndig,idx,copt})
end procedure

public constant xswgtbs = define_c_proc(dis,"+swgtbs",{C_INT,C_STRING,C_INT,C_INT,C_STRING})

public procedure swgtbs(atom id,sequence cstr,atom irow,atom icol,sequence copt)
	c_proc(xswgtbs,{id,cstr,irow,icol,copt})
end procedure

public constant xswgtit = define_c_proc(dis,"+swgtit",{C_STRING})

public procedure swgtit(sequence ctit)
	c_proc(xswgtit,{ctit})
end procedure

public constant xswgtxt = define_c_proc(dis,"+swgtxt",{C_INT,C_STRING})

public procedure swgtxt(atom ip,sequence cval)
	c_proc(xswgtxt,{ip,cval})
end procedure

public constant xswgtyp = define_c_proc(dis,"+swgtyp",{C_STRING,C_STRING})

public procedure swgtyp(sequence ctyp,sequence cwidg)
	c_proc(xswgtyp,{ctyp,cwidg})
end procedure

public constant xswgval = define_c_proc(dis,"+swgval",{C_INT,C_FLOAT})

public procedure swgval(atom ip,atom xval)
	c_proc(xswgval,{ip,xval})
end procedure

public constant xswgwin = define_c_proc(dis,"+swgwin",{C_INT,C_INT,C_INT,C_INT})

public procedure swgwin(atom nx,atom ny,atom nw,atom nh)
	c_proc(xswgwin,{nx,ny,nw,nh})
end procedure

public constant xswgwth = define_c_proc(dis,"+swgwth",{C_INT})

public procedure swgwth(atom nchar)
	c_proc(xswgwth,{nchar})
end procedure

public constant xsymb3d = define_c_proc(dis,"+symb3d",{C_INT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure symb3d(atom n,atom xm,atom ym,atom zm)
	c_proc(xsymb3d,{n,xm,ym,zm})
end procedure

public constant xsymbol = define_c_proc(dis,"+symbol",{C_INT,C_INT,C_INT})

public procedure symbol(atom nsym,atom nx,atom ny)
	c_proc(xsymbol,{nsym,nx,ny})
end procedure

public constant xsymfil = define_c_proc(dis,"+symfil",{C_STRING,C_STRING})

public procedure symfil(sequence cdev,sequence cstat)
	c_proc(xsymfil,{cdev,cstat})
end procedure

public constant xsymrot = define_c_proc(dis,"+symrot",{C_FLOAT})

public procedure symrot(atom angle)
	c_proc(xsymrot,{angle})
end procedure

public constant xtellfl = define_c_func(dis,"+tellfl",{C_INT},C_INT)

public function tellfl(atom nu)
	return c_func(xtellfl,{nu})
end function

public constant xtexmod = define_c_proc(dis,"+texmod",{C_STRING})

public procedure texmod(sequence copt)
	c_proc(xtexmod,{copt})
end procedure

public constant xtexopt = define_c_proc(dis,"+texopt",{C_STRING,C_STRING})

public procedure texopt(sequence copt,sequence ctyp)
	c_proc(xtexopt,{copt,ctyp})
end procedure

public constant xtexval = define_c_proc(dis,"+texval",{C_FLOAT,C_STRING})

public procedure texval(atom x,sequence copt)
	c_proc(xtexval,{x,copt})
end procedure

public constant xthkc3d = define_c_proc(dis,"+thkc3d",{C_FLOAT})

public procedure thkc3d(atom x)
	c_proc(xthkc3d,{x})
end procedure

public constant xthkcrv = define_c_proc(dis,"+thkcrv",{C_INT})

public procedure thkcrv(atom nthk)
	c_proc(xthkcrv,{nthk})
end procedure

public constant xthrfin = define_c_proc(dis,"+thrfin",{})

public procedure thrfin()
	c_proc(xthrfin,{})
end procedure

public constant xthrini = define_c_proc(dis,"+thrini",{C_INT})

public procedure thrini(atom n)
	c_proc(xthrini,{n})
end procedure

public constant xticks = define_c_proc(dis,"+ticks",{C_INT,C_STRING})

public procedure ticks(atom itick,sequence cax)
	c_proc(xticks,{itick,cax})
end procedure

public constant xticlen = define_c_proc(dis,"+ticlen",{C_INT,C_INT})

public procedure ticlen(atom nmaj,atom nmin)
	c_proc(xticlen,{nmaj,nmin})
end procedure

public constant xticmod = define_c_proc(dis,"+ticmod",{C_STRING,C_STRING})

public procedure ticmod(sequence copt,sequence cax)
	c_proc(xticmod,{copt,cax})
end procedure

public constant xticpos = define_c_proc(dis,"+ticpos",{C_STRING,C_STRING})

public procedure ticpos(sequence cpos,sequence cax)
	c_proc(xticpos,{cpos,cax})
end procedure

public constant xtifmod = define_c_proc(dis,"+tifmod",{C_INT,C_STRING,C_STRING})

public procedure tifmod(atom n,sequence cval,sequence copt)
	c_proc(xtifmod,{n,cval,copt})
end procedure

public constant xtiforg = define_c_proc(dis,"+tiforg",{C_INT,C_INT})

public procedure tiforg(atom nx,atom ny)
	c_proc(xtiforg,{nx,ny})
end procedure

public constant xtifwin = define_c_proc(dis,"+tifwin",{C_INT,C_INT,C_INT,C_INT})

public procedure tifwin(atom nx,atom ny,atom nw,atom nh)
	c_proc(xtifwin,{nx,ny,nw,nh})
end procedure

public constant xtimopt = define_c_proc(dis,"+timopt",{})

public procedure timopt()
	c_proc(xtimopt,{})
end procedure

public constant xtitjus = define_c_proc(dis,"+titjus",{C_STRING})

public procedure titjus(sequence copt)
	c_proc(xtitjus,{copt})
end procedure

public constant xtitle = define_c_proc(dis,"+title",{})

public procedure title()
	c_proc(xtitle,{})
end procedure

public constant xtitlin = define_c_proc(dis,"+titlin",{C_STRING,C_INT})

public procedure titlin(sequence cstr,atom n)
	c_proc(xtitlin,{cstr,n})
end procedure

public constant xtitpos = define_c_proc(dis,"+titpos",{C_STRING})

public procedure titpos(sequence copt)
	c_proc(xtitpos,{copt})
end procedure

public constant xtorus3d = define_c_proc(dis,"+torus3d",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,C_INT})

public procedure torus3d(atom xm,atom ym,atom zm,atom r1,atom r2,atom h,atom a1,atom a2,atom n,atom m)
	c_proc(xtorus3d,{xm,ym,zm,r1,r2,h,a1,a2,n,m})
end procedure

public constant xtprfin = define_c_proc(dis,"+tprfin",{})

public procedure tprfin()
	c_proc(xtprfin,{})
end procedure

public constant xtprini = define_c_proc(dis,"+tprini",{})

public procedure tprini()
	c_proc(xtprini,{})
end procedure

public constant xtprmod = define_c_proc(dis,"+tprmod",{C_STRING,C_STRING})

public procedure tprmod(sequence cmod,sequence ckey)
	c_proc(xtprmod,{cmod,ckey})
end procedure

public constant xtprval = define_c_proc(dis,"+tprval",{C_FLOAT})

public procedure tprval(atom x)
	c_proc(xtprval,{x})
end procedure

public constant xtr3axs = define_c_proc(dis,"+tr3axs",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure tr3axs(atom x,atom y,atom z,atom a)
	c_proc(xtr3axs,{x,y,z,a})
end procedure

public constant xtr3res = define_c_proc(dis,"+tr3res",{})

public procedure tr3res()
	c_proc(xtr3res,{})
end procedure

public constant xtr3rot = define_c_proc(dis,"+tr3rot",{C_FLOAT,C_FLOAT,C_FLOAT})

public procedure tr3rot(atom a,atom b,atom c)
	c_proc(xtr3rot,{a,b,c})
end procedure

public constant xtr3scl = define_c_proc(dis,"+tr3scl",{C_FLOAT,C_FLOAT,C_FLOAT})

public procedure tr3scl(atom x,atom y,atom z)
	c_proc(xtr3scl,{x,y,z})
end procedure

public constant xtr3shf = define_c_proc(dis,"+tr3shf",{C_FLOAT,C_FLOAT,C_FLOAT})

public procedure tr3shf(atom x,atom y,atom z)
	c_proc(xtr3shf,{x,y,z})
end procedure

public constant xtrfco1 = define_c_proc(dis,"+trfco1",{C_POINTER,C_INT,C_STRING,C_STRING})

public procedure trfco1(atom nxray,atom n,sequence cfrom,sequence cto)
	c_proc(xtrfco1,{nxray,n,cfrom,cto})
end procedure

public constant xtrfco2 = define_c_proc(dis,"+trfco2",{C_POINTER,C_POINTER,C_INT,C_STRING,C_STRING})

public procedure trfco2(atom xray,atom yray,atom n,sequence cfrom,sequence cto)
	c_proc(xtrfco2,{xray,yray,n,cfrom,cto})
end procedure

public constant xtrfco3 = define_c_proc(dis,"+trfco3",{C_POINTER,C_POINTER,C_POINTER,C_INT,C_STRING,C_STRING})

public procedure trfco3(atom xray,atom yray,atom zray,atom n,sequence cfrom,sequence cto)
	c_proc(xtrfco3,{xray,yray,zray,n,cfrom,cto})
end procedure

public constant xtrfdat = define_c_proc(dis,"+trfdat",{C_INT,C_POINTER,C_POINTER,C_POINTER})

public procedure trfdat(atom ndays,atom id,atom im,atom iy)
	c_proc(xtrfdat,{ndays,id,im,iy})
end procedure

public constant xtrfmat = define_c_proc(dis,"+trfmat",{C_POINTER,C_INT,C_INT,C_POINTER,C_INT,C_INT})

public procedure trfmat(atom zmat,atom nx,atom ny,atom zmat2,atom nx2,atom ny2)
	c_proc(xtrfmat,{zmat,nx,ny,zmat2,nx2,ny2})
end procedure

public constant xtrfrel = define_c_proc(dis,"+trfrel",{C_POINTER,C_POINTER,C_INT})

public procedure trfrel(atom xray,atom yray,atom n)
	c_proc(xtrfrel,{xray,yray,n})
end procedure

public constant xtrfres = define_c_proc(dis,"+trfres",{})

public procedure trfres()
	c_proc(xtrfres,{})
end procedure

public constant xtrfrot = define_c_proc(dis,"+trfrot",{C_FLOAT,C_INT,C_INT})

public procedure trfrot(atom xang,atom nx,atom ny)
	c_proc(xtrfrot,{xang,nx,ny})
end procedure

public constant xtrfscl = define_c_proc(dis,"+trfscl",{C_FLOAT,C_FLOAT})

public procedure trfscl(atom xscl,atom yscl)
	c_proc(xtrfscl,{xscl,yscl})
end procedure

public constant xtrfshf = define_c_proc(dis,"+trfshf",{C_INT,C_INT})

public procedure trfshf(atom nx,atom ny)
	c_proc(xtrfshf,{nx,ny})
end procedure

public constant xtria3d = define_c_proc(dis,"+tria3d",{C_POINTER,C_POINTER,C_POINTER})

public procedure tria3d(atom xtri,atom ytri,atom ztri)
	c_proc(xtria3d,{xtri,ytri,ztri})
end procedure

public constant xtriang = define_c_func(dis,"+triang",{C_POINTER,C_POINTER,C_INT,C_POINTER,C_POINTER,C_POINTER,C_INT},C_INT)

public function triang(atom xray,atom yray,atom n,atom i1ray,atom i2ray,atom i3ray,atom nmax)
	return c_func(xtriang,{xray,yray,n,i1ray,i2ray,i3ray,nmax})
end function

public constant xtriflc = define_c_proc(dis,"+triflc",{C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure triflc(atom xray,atom yray,atom iray,atom n)
	c_proc(xtriflc,{xray,yray,iray,n})
end procedure

public constant xtrifll = define_c_proc(dis,"+trifll",{C_POINTER,C_POINTER})

public procedure trifll(atom xray,atom yray)
	c_proc(xtrifll,{xray,yray})
end procedure

public constant xtriplx = define_c_proc(dis,"+triplx",{})

public procedure triplx()
	c_proc(xtriplx,{})
end procedure

public constant xtripts = define_c_proc(dis,"+tripts",{C_POINTER,C_POINTER,C_POINTER,C_INT,C_POINTER,C_POINTER,C_POINTER,C_INT,C_FLOAT,C_POINTER,C_POINTER,C_INT,C_POINTER,C_INT,C_POINTER})

public procedure tripts(atom xray,atom yray,atom zray,atom n,atom i1ray,atom i2ray,atom i3ray,atom ntri,atom zlev,atom xpts,atom ypts,atom maxpts,atom nptray,atom maxray,atom nlins)
	c_proc(xtripts,{xray,yray,zray,n,i1ray,i2ray,i3ray,ntri,zlev,xpts,ypts,maxpts,nptray,maxray,nlins})
end procedure

public constant xtrmlen = define_c_func(dis,"+trmlen",{C_STRING},C_INT)

public function trmlen(sequence cstr)
	return c_func(xtrmlen,{cstr})
end function

public constant xttfont = define_c_proc(dis,"+ttfont",{C_STRING})

public procedure ttfont(sequence cfnt)
	c_proc(xttfont,{cfnt})
end procedure

public constant xtube3d = define_c_proc(dis,"+tube3d",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,C_INT})

public procedure tube3d(atom x1,atom y1,atom z1,atom x2,atom y2,atom z2,atom r,atom nsk1,atom nsk2)
	c_proc(xtube3d,{x1,y1,z1,x2,y2,z2,r,nsk1,nsk2})
end procedure

public constant xtxtbgd = define_c_proc(dis,"+txtbgd",{C_INT})

public procedure txtbgd(atom n)
	c_proc(xtxtbgd,{n})
end procedure

public constant xtxtjus = define_c_proc(dis,"+txtjus",{C_STRING})

public procedure txtjus(sequence copt)
	c_proc(xtxtjus,{copt})
end procedure

public constant xtxture = define_c_proc(dis,"+txture",{C_POINTER,C_INT,C_INT})

public procedure txture(atom itmat,atom nx,atom ny)
	c_proc(xtxture,{itmat,nx,ny})
end procedure

public constant xunit = define_c_proc(dis,"+unit",{C_POINTER})

public procedure unit(atom fp)
	c_proc(xunit,{fp})
end procedure

public constant xunits = define_c_proc(dis,"+units",{C_STRING})

public procedure units(sequence copt)
	c_proc(xunits,{copt})
end procedure

public constant xupstr = define_c_proc(dis,"+upstr",{C_STRING})

public procedure upstr(sequence cstr)
	c_proc(xupstr,{cstr})
end procedure

public constant xutfint = define_c_func(dis,"+utfint",{C_STRING,C_POINTER,C_INT},C_INT)

public function utfint(sequence cstr,atom iray,atom n)
	return c_func(xutfint,{cstr,iray,n})
end function

public constant xvang3d = define_c_proc(dis,"+vang3d",{C_FLOAT})

public procedure vang3d(atom a)
	c_proc(xvang3d,{a})
end procedure

public constant xvclp3d = define_c_proc(dis,"+vclp3d",{C_FLOAT,C_FLOAT})

public procedure vclp3d(atom x1,atom x2)
	c_proc(xvclp3d,{x1,x2})
end procedure

public constant xvecclr = define_c_proc(dis,"+vecclr",{C_INT})

public procedure vecclr(atom iclr)
	c_proc(xvecclr,{iclr})
end procedure

public constant xvecf3d = define_c_proc(dis,"+vecf3d",{C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_INT,C_INT})

public procedure vecf3d(atom xv,atom yv,atom zv,atom xp,atom yp,atom zp,atom n,atom ivec)
	c_proc(xvecf3d,{xv,yv,zv,xp,yp,zp,n,ivec})
end procedure

public constant xvecfld = define_c_proc(dis,"+vecfld",{C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_INT,C_INT})

public procedure vecfld(atom xv,atom yv,atom xp,atom yp,atom n,atom ivec)
	c_proc(xvecfld,{xv,yv,xp,yp,n,ivec})
end procedure

public constant xvecmat = define_c_proc(dis,"+vecmat",{C_POINTER,C_POINTER,C_INT,C_INT,C_POINTER,C_POINTER,C_INT})

public procedure vecmat(atom xmat,atom ymat,atom nx,atom ny,atom xp,atom yp,atom ivec)
	c_proc(xvecmat,{xmat,ymat,nx,ny,xp,yp,ivec})
end procedure

public constant xvecmat3d = define_c_proc(dis,"+vecmat3d",{C_POINTER,C_POINTER,C_POINTER,C_INT,C_INT,C_INT,C_POINTER,C_POINTER,C_POINTER,C_INT})

public procedure vecmat3d(atom xv,atom yv,atom zv,atom nx,atom ny,atom nz,atom xp,atom yp,atom zp,atom ivec)
	c_proc(xvecmat3d,{xv,yv,zv,nx,ny,nz,xp,yp,zp,ivec})
end procedure

public constant xvecopt = define_c_proc(dis,"+vecopt",{C_FLOAT,C_STRING})

public procedure vecopt(atom x,sequence copt)
	c_proc(xvecopt,{x,copt})
end procedure

public constant xvector = define_c_proc(dis,"+vector",{C_INT,C_INT,C_INT,C_INT,C_INT})

public procedure vector(atom nx1,atom ny1,atom nx2,atom ny2,atom ivec)
	c_proc(xvector,{nx1,ny1,nx2,ny2,ivec})
end procedure

public constant xvectr3 = define_c_proc(dis,"+vectr3",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_INT})

public procedure vectr3(atom x1,atom y1,atom z1,atom x2,atom y2,atom z2,atom ivec)
	c_proc(xvectr3,{x1,y1,z1,x2,y2,z2,ivec})
end procedure

public constant xvfoc3d = define_c_proc(dis,"+vfoc3d",{C_FLOAT,C_FLOAT,C_FLOAT,C_STRING})

public procedure vfoc3d(atom x,atom y,atom z,sequence cview)
	c_proc(xvfoc3d,{x,y,z,cview})
end procedure

public constant xview3d = define_c_proc(dis,"+view3d",{C_FLOAT,C_FLOAT,C_FLOAT,C_STRING})

public procedure view3d(atom xvu,atom yvu,atom zvu,sequence cvu)
	c_proc(xview3d,{xvu,yvu,zvu,cvu})
end procedure

public constant xvkxbar = define_c_proc(dis,"+vkxbar",{C_INT})

public procedure vkxbar(atom nvfx)
	c_proc(xvkxbar,{nvfx})
end procedure

public constant xvkybar = define_c_proc(dis,"+vkybar",{C_INT})

public procedure vkybar(atom nvfy)
	c_proc(xvkybar,{nvfy})
end procedure

public constant xvltfil = define_c_proc(dis,"+vltfil",{C_STRING,C_STRING})

public procedure vltfil(sequence cfl,sequence copt)
	c_proc(xvltfil,{cfl,copt})
end procedure

public constant xvscl3d = define_c_proc(dis,"+vscl3d",{C_FLOAT})

public procedure vscl3d(atom x)
	c_proc(xvscl3d,{x})
end procedure

public constant xvtx3d = define_c_proc(dis,"+vtx3d",{C_POINTER,C_POINTER,C_POINTER,C_INT,C_STRING})

public procedure vtx3d(atom xray,atom yray,atom zray,atom n,sequence copt)
	c_proc(xvtx3d,{xray,yray,zray,n,copt})
end procedure

public constant xvtxc3d = define_c_proc(dis,"+vtxc3d",{C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_INT,C_STRING})

public procedure vtxc3d(atom xray,atom yray,atom zray,atom ic,atom n,sequence copt)
	c_proc(xvtxc3d,{xray,yray,zray,ic,n,copt})
end procedure

public constant xvtxn3d = define_c_proc(dis,"+vtxn3d",{C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_INT,C_STRING})

public procedure vtxn3d(atom xray,atom yray,atom zray,atom xn,atom yn,atom zn,atom n,sequence copt)
	c_proc(xvtxn3d,{xray,yray,zray,xn,yn,zn,n,copt})
end procedure

public constant xvup3d = define_c_proc(dis,"+vup3d",{C_FLOAT})

public procedure vup3d(atom a)
	c_proc(xvup3d,{a})
end procedure

public constant xwgapp = define_c_func(dis,"+wgapp",{C_INT,C_STRING},C_INT)

public function wgapp(atom ip,sequence clab)
	return c_func(xwgapp,{ip,clab})
end function

public constant xwgappb = define_c_func(dis,"+wgappb",{C_INT,C_POINTER,C_INT,C_INT},C_INT)

public function wgappb(atom ip,atom iray,atom nw,atom nh)
	return c_func(xwgappb,{ip,iray,nw,nh})
end function

public constant xwgbas = define_c_func(dis,"+wgbas",{C_INT,C_STRING},C_INT)

public function wgbas(atom ip,sequence ctyp)
	return c_func(xwgbas,{ip,ctyp})
end function

public constant xwgbox = define_c_func(dis,"+wgbox",{C_INT,C_STRING,C_INT},C_INT)

public function wgbox(atom ip,sequence cstr,atom isel)
	return c_func(xwgbox,{ip,cstr,isel})
end function

public constant xwgbut = define_c_func(dis,"+wgbut",{C_INT,C_STRING,C_INT},C_INT)

public function wgbut(atom ip,sequence cstr,atom ival)
	return c_func(xwgbut,{ip,cstr,ival})
end function

public constant xwgcmd = define_c_func(dis,"+wgcmd",{C_INT,C_STRING,C_STRING},C_INT)

public function wgcmd(atom ip,sequence clab,sequence cmd)
	return c_func(xwgcmd,{ip,clab,cmd})
end function

public constant xwgdlis = define_c_func(dis,"+wgdlis",{C_INT,C_STRING,C_INT},C_INT)

public function wgdlis(atom ip,sequence cstr,atom isel)
	return c_func(xwgdlis,{ip,cstr,isel})
end function

public constant xwgdraw = define_c_func(dis,"+wgdraw",{C_INT},C_INT)

public function wgdraw(atom ip)
	return c_func(xwgdraw,{ip})
end function

public constant xwgfil = define_c_func(dis,"+wgfil",{C_INT,C_STRING,C_STRING,C_STRING},C_INT)

public function wgfil(atom ip,sequence clab,sequence cstr,sequence cmask)
	return c_func(xwgfil,{ip,clab,cstr,cmask})
end function

public constant xwgfin = define_c_proc(dis,"+wgfin",{})

public procedure wgfin()
	c_proc(xwgfin,{})
end procedure

public constant xwgicon = define_c_func(dis,"+wgicon",{C_INT,C_STRING,C_INT,C_INT,C_STRING},C_INT)

public function wgicon(atom ip,sequence clab,atom nw,atom nh,sequence cfl)
	return c_func(xwgicon,{ip,clab,nw,nh,cfl})
end function

public constant xwgimg = define_c_func(dis,"+wgimg",{C_INT,C_STRING,C_POINTER,C_INT,C_INT},C_INT)

public function wgimg(atom ip,sequence clab,atom iray,atom nw,atom nh)
	return c_func(xwgimg,{ip,clab,iray,nw,nh})
end function

public constant xwgini = define_c_func(dis,"+wgini",{C_STRING},C_INT)

public function wgini(sequence ctyp)
	return c_func(xwgini,{ctyp})
end function

public constant xwglab = define_c_func(dis,"+wglab",{C_INT,C_STRING},C_INT)

public function wglab(atom ip,sequence cstr)
	return c_func(xwglab,{ip,cstr})
end function

public constant xwglis = define_c_func(dis,"+wglis",{C_INT,C_STRING,C_INT},C_INT)

public function wglis(atom ip,sequence cstr,atom isel)
	return c_func(xwglis,{ip,cstr,isel})
end function

public constant xwgltxt = define_c_func(dis,"+wgltxt",{C_INT,C_STRING,C_STRING,C_INT},C_INT)

public function wgltxt(atom ip,sequence clab,sequence ctext,atom iper)
	return c_func(xwgltxt,{ip,clab,ctext,iper})
end function

public constant xwgok = define_c_func(dis,"+wgok",{C_INT},C_INT)

public function wgok(atom ip)
	return c_func(xwgok,{ip})
end function

public constant xwgpbar = define_c_func(dis,"+wgpbar",{C_INT,C_FLOAT,C_FLOAT,C_FLOAT},C_INT)

public function wgpbar(atom ip,atom x1,atom y1,atom xstp)
	return c_func(xwgpbar,{ip,x1,y1,xstp})
end function

public constant xwgpbut = define_c_func(dis,"+wgpbut",{C_INT,C_STRING},C_INT)

public function wgpbut(atom ip,sequence clab)
	return c_func(xwgpbut,{ip,clab})
end function

public constant xwgpicon = define_c_func(dis,"+wgpicon",{C_INT,C_STRING,C_INT,C_INT,C_STRING},C_INT)

public function wgpicon(atom ip,sequence clab,atom nw,atom nh,sequence cfl)
	return c_func(xwgpicon,{ip,clab,nw,nh,cfl})
end function

public constant xwgpimg = define_c_func(dis,"+wgpimg",{C_INT,C_STRING,C_POINTER,C_INT,C_INT},C_INT)

public function wgpimg(atom ip,sequence clab,atom iray,atom nw,atom nh)
	return c_func(xwgpimg,{ip,clab,iray,nw,nh})
end function

public constant xwgpop = define_c_func(dis,"+wgpop",{C_INT,C_STRING},C_INT)

public function wgpop(atom ip,sequence clab)
	return c_func(xwgpop,{ip,clab})
end function

public constant xwgpopb = define_c_func(dis,"+wgpopb",{C_INT,C_POINTER,C_INT,C_INT},C_INT)

public function wgpopb(atom ip,atom iray,atom nw,atom nh)
	return c_func(xwgpopb,{ip,iray,nw,nh})
end function

public constant xwgquit = define_c_func(dis,"+wgquit",{C_INT},C_INT)

public function wgquit(atom ip)
	return c_func(xwgquit,{ip})
end function

public constant xwgscl = define_c_func(dis,"+wgscl",{C_INT,C_STRING,C_FLOAT,C_FLOAT,C_FLOAT,C_INT},C_INT)

public function wgscl(atom ip,sequence cstr,atom x1,atom x2,atom xval,atom ndez)
	return c_func(xwgscl,{ip,cstr,x1,x2,xval,ndez})
end function

public constant xwgsep = define_c_func(dis,"+wgsep",{C_INT},C_INT)

public function wgsep(atom ip)
	return c_func(xwgsep,{ip})
end function

public constant xwgstxt = define_c_func(dis,"+wgstxt",{C_INT,C_INT,C_INT},C_INT)

public function wgstxt(atom ip,atom nsize,atom nmax)
	return c_func(xwgstxt,{ip,nsize,nmax})
end function

public constant xwgtbl = define_c_func(dis,"+wgtbl",{C_INT,C_INT,C_INT},C_INT)

public function wgtbl(atom ip,atom nrows,atom ncols)
	return c_func(xwgtbl,{ip,nrows,ncols})
end function

public constant xwgtxt = define_c_func(dis,"+wgtxt",{C_INT,C_STRING},C_INT)

public function wgtxt(atom ip,sequence cstr)
	return c_func(xwgtxt,{ip,cstr})
end function

public constant xwidbar = define_c_proc(dis,"+widbar",{C_INT})

public procedure widbar(atom nzb)
	c_proc(xwidbar,{nzb})
end procedure

public constant xwimage = define_c_proc(dis,"+wimage",{C_STRING})

public procedure wimage(sequence cfil)
	c_proc(xwimage,{cfil})
end procedure

public constant xwinapp = define_c_proc(dis,"+winapp",{C_STRING})

public procedure winapp(sequence copt)
	c_proc(xwinapp,{copt})
end procedure

public function win_cb()
	return 0
end function

public atom wincb_id = routine_id("win_cb")
public object wincb_cb = call_back(wincb_id)

public constant xwincbk = define_c_proc(dis,"+wincbk",{C_POINTER,C_INT,C_INT,C_INT,C_INT,C_INT,C_STRING})

public procedure wincbk(object cb=wincb_cb,atom id,atom nx,atom ny,atom nw,atom nh,sequence copt)
	c_proc(xwincbk,{cb,id,nx,ny,nw,nh,copt})
end procedure

public constant xwindbr = define_c_proc(dis,"+windbr",{C_FLOAT,C_INT,C_INT,C_INT,C_FLOAT})

public procedure windbr(atom xk,atom nx,atom ny,atom nwidth,atom a)
	c_proc(xwindbr,{xk,nx,ny,nwidth,a})
end procedure

public constant xwindow = define_c_proc(dis,"+window",{C_INT,C_INT,C_INT,C_INT})

public procedure window(atom nx,atom ny,atom nw,atom nh)
	c_proc(xwindow,{nx,ny,nw,nh})
end procedure

public constant xwinfnt = define_c_proc(dis,"+winfnt",{C_STRING})

public procedure winfnt(sequence cfont)
	c_proc(xwinfnt,{cfont})
end procedure

public constant xwinico = define_c_proc(dis,"+winico",{C_STRING})

public procedure winico(sequence cstr)
	c_proc(xwinico,{cstr})
end procedure

public constant xwinid = define_c_func(dis,"+winid",{},C_INT)

public function winid()
	return c_func(xwinid,{})
end function

public constant xwinjus = define_c_proc(dis,"+winjus",{C_STRING})

public procedure winjus(sequence copt)
	c_proc(xwinjus,{copt})
end procedure

public constant xwinkey = define_c_proc(dis,"+winkey",{C_STRING})

public procedure winkey(sequence copt)
	c_proc(xwinkey,{copt})
end procedure

public constant xwinmod = define_c_proc(dis,"+winmod",{C_STRING})

public procedure winmod(sequence copt)
	c_proc(xwinmod,{copt})
end procedure

public constant xwinopt = define_c_proc(dis,"+winopt",{C_INT,C_STRING})

public procedure winopt(atom iopt,sequence copt)
	c_proc(xwinopt,{iopt,copt})
end procedure

public constant xwinsiz = define_c_proc(dis,"+winsiz",{C_INT,C_INT})

public procedure winsiz(atom nw,atom nh)
	c_proc(xwinsiz,{nw,nh})
end procedure

public constant xwintit = define_c_proc(dis,"+wintit",{C_STRING})

public procedure wintit(sequence cstr)
	c_proc(xwintit,{cstr})
end procedure

public constant xwintyp = define_c_proc(dis,"+wintyp",{C_STRING})

public procedure wintyp(sequence copt)
	c_proc(xwintyp,{copt})
end procedure

public constant xwmfmod = define_c_proc(dis,"+wmfmod",{C_STRING,C_STRING})

public procedure wmfmod(sequence cmod,sequence ckey)
	c_proc(xwmfmod,{cmod,ckey})
end procedure

public constant xworld = define_c_proc(dis,"+world",{})

public procedure world()
	c_proc(xworld,{})
end procedure

public constant xwpixel = define_c_proc(dis,"+wpixel",{C_INT,C_INT,C_INT})

public procedure wpixel(atom ix,atom iy,atom iclr)
	c_proc(xwpixel,{ix,iy,iclr})
end procedure

public constant xwpixls = define_c_proc(dis,"+wpixls",{C_POINTER,C_INT,C_INT,C_INT,C_INT})

public procedure wpixls(atom iray,atom ix,atom iy,atom nw,atom nh)
	c_proc(xwpixls,{iray,ix,iy,nw,nh})
end procedure

public constant xwpxrow = define_c_proc(dis,"+wpxrow",{C_POINTER,C_INT,C_INT,C_INT})

public procedure wpxrow(atom iray,atom ix,atom iy,atom n)
	c_proc(xwpxrow,{iray,ix,iy,n})
end procedure

public constant xwritfl = define_c_func(dis,"+writfl",{C_INT,C_POINTER,C_INT},C_INT)

public function writfl(atom nu,atom cbuf,atom nbyte)
	return c_func(xwritfl,{nu,cbuf,nbyte})
end function

public constant xwtiff = define_c_proc(dis,"+wtiff",{C_STRING})

public procedure wtiff(atom cfil)
	c_proc(xwtiff,{cfil})
end procedure

public constant xx11fnt = define_c_proc(dis,"+x11fnt",{C_STRING,C_STRING})

public procedure x11fnt(sequence cfont,sequence copt)
	c_proc(xx11fnt,{cfont,copt})
end procedure

public constant xx11mod = define_c_proc(dis,"+x11mod",{C_STRING})

public procedure x11mod(sequence copt)
	c_proc(xx11mod,{copt})
end procedure

public constant xx2dpos = define_c_func(dis,"+x2dpos",{C_FLOAT,C_FLOAT},C_FLOAT)

public function x2dpos(atom x,atom y)
	return c_func(xx2dpos,{x,y})
end function

public constant xx3dabs = define_c_func(dis,"+x3dabs",{C_FLOAT,C_FLOAT,C_FLOAT},C_FLOAT)

public function x3dabs(atom x,atom y,atom z)
	return c_func(xx3dabs,{x,y,z})
end function

public constant xx3dpos = define_c_func(dis,"+x3dpos",{C_FLOAT,C_FLOAT,C_FLOAT},C_FLOAT)

public function x3dpos(atom x,atom y,atom z)
	return c_func(xx3dpos,{x,y,z})
end function

public constant xx3drel = define_c_func(dis,"+x3drel",{C_FLOAT,C_FLOAT,C_FLOAT},C_FLOAT)

public function x3drel(atom x,atom y,atom z)
	return c_func(xx3drel,{x,y,z})
end function

public constant _xaxgit = define_c_proc(dis,"+xaxgit",{})

public procedure xaxgit()
	c_proc(_xaxgit,{})
end procedure

public constant xxaxis = define_c_proc(dis,"+xaxis",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,C_STRING,C_INT,C_INT,C_INT})

public procedure xaxis(atom xa,atom xe,atom xorg,atom xstp,atom nl,sequence cstr,atom it,atom nx,atom ny)
	c_proc(xxaxis,{xa,xe,xorg,xstp,nl,cstr,it,nx,ny})
end procedure

public constant xxaxlg = define_c_proc(dis,"+xaxlg",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,C_STRING,C_INT,C_INT,C_INT})

public procedure xaxlg(atom xa,atom xe,atom xorg,atom xstp,atom nl,sequence cstr,atom it,atom nx,atom ny)
	c_proc(xxaxlg,{xa,xe,xorg,xstp,nl,cstr,it,nx,ny})
end procedure

public constant xxaxmap = define_c_proc(dis,"+xaxmap",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_STRING,C_INT,C_INT})

public procedure xaxmap(atom xa,atom xe,atom xorg,atom xstp,sequence cstr,atom it,atom ny)
	c_proc(xxaxmap,{xa,xe,xorg,xstp,cstr,it,ny})
end procedure

public constant xxcross = define_c_proc(dis,"+xcross",{})

public procedure xcross()
	c_proc(xxcross,{})
end procedure

public constant xxdraw = define_c_proc(dis,"+xdraw",{C_FLOAT,C_FLOAT})

public procedure xdraw(atom x,atom y)
	c_proc(xxdraw,{x,y})
end procedure

public constant xxinvrs = define_c_func(dis,"+xinvrs",{C_INT},C_FLOAT)

public function xinvrs(atom n)
	return c_func(xxinvrs,{n})
end function

public constant xxmove = define_c_proc(dis,"+xmove",{C_FLOAT,C_FLOAT})

public procedure xmove(atom x,atom y)
	c_proc(xxmove,{x,y})
end procedure

public constant xxposn = define_c_func(dis,"+xposn",{C_FLOAT},C_FLOAT)

public function xposn(atom x)
	return c_func(xxposn,{x})
end function

public constant xy2dpos = define_c_func(dis,"+y2dpos",{C_FLOAT,C_FLOAT},C_FLOAT)

public function y2dpos(atom x,atom y)
	return c_func(xy2dpos,{x,y})
end function

public constant xy3dabs = define_c_func(dis,"+y3dabs",{C_FLOAT,C_FLOAT,C_FLOAT},C_FLOAT)

public function y3dabs(atom x,atom y,atom z)
	return c_func(xy3dabs,{x,y,z})
end function

public constant xy3dpos = define_c_func(dis,"+y3dpos",{C_FLOAT,C_FLOAT,C_FLOAT},C_FLOAT)

public function y3dpos(atom x,atom y,atom z)
	return c_func(xy3dpos,{x,y,z})
end function

public constant xy3drel = define_c_func(dis,"+y3drel",{C_FLOAT,C_FLOAT,C_FLOAT},C_FLOAT)

public function y3drel(atom x,atom y,atom z)
	return c_func(xy3drel,{x,y,z})
end function

public constant xyaxgit = define_c_proc(dis,"+yaxgit",{})

public procedure yaxgit()
	c_proc(xyaxgit,{})
end procedure

public constant xyaxis = define_c_proc(dis,"+yaxis",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,C_STRING,C_INT,C_INT,C_INT})

public procedure yaxis(atom ya,atom ye,atom yor,atom ystp,atom nl,sequence cstr,atom it,atom nx,atom ny)
	c_proc(xyaxis,{ya,ye,yor,ystp,nl,cstr,it,nx,ny})
end procedure

public constant xyaxlg = define_c_proc(dis,"+yaxlg",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,C_STRING,C_INT,C_INT,C_INT})

public procedure yaxlg(atom ya,atom ye,atom yor,atom ystp,atom nl,sequence cstr,atom it,atom nx,atom ny)
	c_proc(xyaxlg,{ya,ye,yor,ystp,nl,cstr,it,nx,ny})
end procedure

public constant xyaxmap = define_c_proc(dis,"+yaxmap",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_STRING,C_INT,C_INT})

public procedure yaxmap(atom ya,atom ye,atom yor,atom ystp,sequence cstr,atom it,atom ny)
	c_proc(xyaxmap,{ya,ye,yor,ystp,cstr,it,ny})
end procedure

public constant xycross = define_c_proc(dis,"+ycross",{})

public procedure ycross()
	c_proc(xycross,{})
end procedure

public constant xyinvrs = define_c_func(dis,"+yinvrs",{C_INT},C_FLOAT)

public function yinvrs(atom n)
	return c_func(xyinvrs,{n})
end function

public constant xypolar = define_c_proc(dis,"+ypolar",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_STRING,C_INT})

public procedure ypolar(atom ya,atom ye,atom yor,atom ystp,sequence cstr,atom ndist)
	c_proc(xypolar,{ya,ye,yor,ystp,cstr,ndist})
end procedure

public constant xyposn = define_c_func(dis,"+yposn",{C_FLOAT},C_FLOAT)

public function yposn(atom y)
	return c_func(xyposn,{y})
end function

public constant xz3dpos = define_c_func(dis,"+z3dpos",{C_FLOAT,C_FLOAT,C_FLOAT},C_FLOAT)

public function z3dpos(atom x,atom y,atom z)
	return c_func(xz3dpos,{x,y,z})
end function

public constant xzaxis = define_c_proc(dis,"+zaxis",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,C_STRING,C_INT,C_INT,C_INT,C_INT})

public procedure zaxis(atom za,atom ze,atom zor,atom zstp,atom nl,sequence cstr,atom it,atom id,atom nx,atom ny)
	c_proc(xzaxis,{za,ze,zor,zstp,nl,cstr,it,id,nx,ny})
end procedure

public constant xzaxlg = define_c_proc(dis,"+zaxlg",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_INT,C_STRING,C_INT,C_INT,C_INT,C_INT})

public procedure zaxlg(atom za,atom ze,atom zor,atom zstp,atom nl,sequence cstr,atom it,atom id,atom nx,atom ny)
	c_proc(xzaxlg,{za,ze,zor,zstp,nl,cstr,it,id,nx,ny})
end procedure

public constant xzbfers = define_c_proc(dis,"+zbfers",{})

public procedure zbfers()
	c_proc(xzbfers,{})
end procedure

public constant xzbffin = define_c_proc(dis,"+zbffin",{})

public procedure zbffin()
	c_proc(xzbffin,{})
end procedure

public constant xzbfini = define_c_func(dis,"+zbfini",{},C_INT)

public function zbfini()
	return c_func(xzbfini,{})
end function

public constant xzbflin = define_c_proc(dis,"+zbflin",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT})

public procedure zbflin(atom x1,atom y1,atom z1,atom x2,atom y2,atom z2)
	c_proc(xzbflin,{x1,y1,z1,x2,y2,z2})
end procedure

public constant xzbfmod = define_c_proc(dis,"+zbfmod",{C_STRING})

public procedure zbfmod(sequence copt)
	c_proc(xzbfmod,{copt})
end procedure

public constant xzbfres = define_c_proc(dis,"+zbfres",{})

public procedure zbfres()
	c_proc(xzbfres,{})
end procedure

public constant xzbfscl = define_c_proc(dis,"+zbfscl",{C_FLOAT})

public procedure zbfscl(atom x)
	c_proc(xzbfscl,{x})
end procedure

public constant xzbftri = define_c_proc(dis,"+zbftri",{C_POINTER,C_POINTER,C_POINTER,C_POINTER})

public procedure zbftri(atom x,atom y,atom z,atom ic)
	c_proc(xzbftri,{x,y,z,ic})
end procedure

public constant xzscale = define_c_proc(dis,"+zscale",{C_FLOAT,C_FLOAT})

public procedure zscale(atom za,atom ze)
	c_proc(xzscale,{za,ze})
end procedure
­585.9