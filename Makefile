PORTNAME=	Eternal-Lands
DISTVERSION=	g20221029
CATEGORIES=	games
PKGNAMESUFFIX=	-dev
DISTNAME=	${GH_TAGNAME}
DIST_SUBDIR=	${PORTNAME}${PKGNAMESUFFIX}

MAINTAINER=	nope@nothere
COMMENT=	Client for Eternal Lands MMORPG 3d fantasy game
WWW=		http://www.eternal-lands.com/

#LICENSE=
BUILD_DEPENDS=	nlohmann-json>=3.6.1:devel/nlohmann-json
#RUN_DEPENDS=
LIB_DEPENDS+=	libcal3d.so:graphics/cal3d \
		libogg.so:audio/libogg \
		libvorbis.so:audio/libvorbis \
		libvorbisfile.so:audio/libvorbis \
		libpng.so:graphics/png

USES=		cmake ssl openal iconv \
		compiler:c++17-lang gnome \
		desktop-file-utils \
		openal:al,alut sdl xorg \
		pkgconfig:build

#LDFLAGS+=	-L${ICONV_LIB}
LDFLAGS+=       -L${LOCALBASE}/lib ${ICONV_LIB} -lX11
CONFLICTS=	el
CMAKE_ARGS+=	-DIconv_LIBRARIES="-L${LOCALBASE}/lib -liconv" \
		-DBUILD_UNITTESTS="TRUE" \
		-DCMAKE_BUILD_TYPE="MinSizeRel" \
		-DCMAKE_VERBOSE_MAKEFILE="TRUE" \
		-DCMAKE_BUILD_TYPE="MinSizeRel" \
		-DCUSTOM_EXAMPLE_CONF_DIR="${PREFIX}/etc" \
		-DCUSTOM_MANDIR="${PREFIX}/man" \
		-DOPENGL_xmesa_INCLUDE_DIR="${PREFIX}/lib" \
		-DMARCHNATIVE="ON" \
		-DLOCAL_NLOHMANN_JSON="ON" \
		-DUSE_SYSTEM_JSON="ON" \
		-DJSON_FILES="ON" \
		-DEXEC="el"
USE_GNOME=	libxml2
USE_SDL=	sdl2 net2 image2 ttf2
USE_GL+=	gl glu
#USE_GL+=	gl
#USE_GL+=	egl glx gl glu
USE_XORG+=	ice sm x11 xcb xres xshmfence xau xaw xcomposite \
		xcursor xdamage xdmcp xext xfixes xft xi xinerama \
		xkbfile xmu xpm xrandr xrender xt xv xxf86vm
USE_GITHUB=	nodefault
GH_ACCOUNT=	raduprv
GH_PROJECT=	Eternal-Lands
GH_TAGNAME=	3abbade8466cc1df6a68fc89582a1bfcd4194d2a
#CMAKE_MODULE_LINKER_FLAGS=
#CMAKE_SHARED_LINKER_FLAGS=

WRKSRC=	${WRKDIR}/${PORTNAME}-${GH_TAGNAME}

OPTIONS_DEFINE=			DOCS EXAMPLES FREETYPE NLS SOUND SYSTEM_GMP SYSTEM_JSONCPP
OPTIONS_DEFAULT=		CURL FREETYPE LUAJIT SOUND SYSTEM_GMP SYSTEM_JSONCPP GLVND

OPTIONS_RADIO=			GRAPHICS

SYSTEM_GMP_DESC=		Use gmp from ports (ENABLE_SYSTEM_GMP)
SYSTEM_GMP_CMAKE_BOOL=		ENABLE_SYSTEM_GMP
SYSTEM_GMP_CMAKE_ON=		-DGMP_INCLUDE_DIR="${PREFIX}/include"
SYSTEM_GMP_LIB_DEPENDS=		libgmp.so:math/gmp

SYSTEM_JSONCPP_DESC=		Use jsoncpp from ports (ENABLE_SYSTEM_JSONCPP)
SYSTEM_JSONCPP_CMAKE_BOOL=	ENABLE_SYSTEM_JSONCPP
SYSTEM_JSONCPP_CMAKE_ON=	-DJSON_INCLUDE_DIR="${PREFIX}/include/jsoncpp"
SYSTEM_JSONCPP_LIB_DEPENDS=	libjsoncpp.so:devel/jsoncpp

OPTIONS_RADIO_GRAPHICS=		GLVND LEGACY GLES
GRAPHICS_DESC=			Graphics support

GLVND_DESC=			Use libOpenGL or libGLX
GLVND_CMAKE_BOOL=		ENABLE_GLVND
GLVND_CMAKE_ON=			-DOPENGL_GL_PREFERENCE="GLVND"
GLVND_USE=			GL+=opengl
GLVND_PREVENTS=			GLES

LEGACY_DESC=			Use libGL - where GLVND may be broken on nvidia
LEGACY_CMAKE_BOOL=		ENABLE_LEGACY
LEGACY_CMAKE_ON=		-DOPENGL_GL_PREFERENCE="LEGACY"
LEGACY_USE=			GL+=opengl
LEGACY_PREVENTS=		GLES

GLES_DESC=			Use libOpenGLES instead of libOpenGL
GLES_CMAKE_BOOL=		ENABLE_GLES
GLES_USE=			GL+=glesv2
GLES_PREVENTS=			GLVND LEGACY
# dependency?

OPTIONS_SUB=			yes

SOUND_DESC=			Enable sound via openal-soft
SOUND_CMAKE_BOOL=		ENABLE_SOUND
SOUND_LIB_DEPENDS=		libvorbis.so:audio/libvorbis \
				libvorbisfile.so:audio/libvorbis
FREETYPE_DESC=			Support for TrueType fonts with unicode
FREETYPE_CMAKE_BOOL=		ENABLE_FREETYPE
FREETYPE_LIB_DEPENDS=		libfreetype.so:print/freetype2

NLS_DESC=			Native Language Support (ENABLE_GETTEXT)
NLS_CMAKE_BOOL=			ENABLE_GETTEXT
NLS_USES=			gettext
NLS_LDFLAGS=			-L${LOCALBASE}/lib

# Warning: you need USES+=iconv, USES+=iconv:wchar_t, or USES+=iconv:translit depending on needs
# --------------------------------------------------------------------
#
#  The options need to be adjusted to fit reality, some things are implied optional but are not, such as
#  the client, not sure why one would build this except for the client portion.
#
#  Unsure if a build issue or something else, but although I can get it to connect and function, it seems
#  particularly laggy and often needs a resync, also, quitting the client is not always easy and must be
#  killed instead. This might be a local issue unique to my situation, 4k screen with a somewhat large
#  game window.
#
#  If I need to locate a more current version, maybe:
#  https://github.com/raduprv/Eternal-Lands/search?q=servers.lst
#
#  For continuity and certainty, there is an eternal lands data repo as well, so I can update that
#  when it is necessary. Can I incorporate the data portion of the install into the el port as it is
#  a requirement? Something to investigate and figure out, I believe something in my collection pulls
#  two git repos, maybe that could be adjusted to have one portion not a build install as this is.
#
#  In the eternallands-data port the el.ini file was modified and dos2unix used for files needing it,
#  sane defaults now used in this config file as well as the proper FreeBSD data_dir location defined.
#  The servers.lst file is included among those data files. If the sound or music files are installed
#  as part of the data files, they are located (properly) within the /usr/local/share/Eternal-Lands-data
#  directory.
#
#  The data port installs fonts, perhaps this could be avoided if "linux glue" is smart enough.

.include <bsd.port.options.mk>

.include <bsd.port.mk>
