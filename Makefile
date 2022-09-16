PORTNAME=	Eternal-Lands
DISTVERSION=	g20220915
CATEGORIES=	games
PKGNAMESUFFIX=	-dev
DISTNAME=	${GH_TAGNAME}
DIST_SUBDIR=	${PORTNAME}${PKGNAMESUFFIX}

MAINTAINER=	nope@nothere
COMMENT=	Client for Eternal Lands MMORPG 3d fantasy game

#LICENSE=
BUILD_DEPENDS=	nlohmann-json>=3.6.1:devel/nlohmann-json
#RUN_DEPENDS=
LIB_DEPENDS+=	libcal3d.so:graphics/cal3d \
		libogg.so:audio/libogg \
		libvorbis.so:audio/libvorbis \
		libvorbisfile.so:audio/libvorbis \
		libpng16.so:graphics/png

USES=		cmake ssl openal iconv \
		compiler:c++17-lang gnome \
		openal:al,alut sdl xorg \
		pkgconfig:build

#LDFLAGS+=	-L${ICONV_LIB}
CONFLICTS=	el
CMAKE_ARGS+=	-DIconv_LIBRARIES="-L${LOCALBASE}/lib -liconv" \
		-DBUILD_UNITTESTS="FALSE" \
		-DCMAKE_BUILD_TYPE="MinSizeRel" \
		-DCMAKE_VERBOSE_MAKEFILE="TRUE" \
		-DCUSTOM_EXAMPLE_CONF_DIR="${PREFIX}/etc" \
		-DCUSTOM_MANDIR="${PREFIX}/man" \
		-DOPENGL_xmesa_INCLUDE_DIR="${PREFIX}/lib" \
		-DLOCAL_NLOHMANN_JSON="ON" \
		-DUSE_SYSTEM_JSON="ON" \
		-DJSON_FILES="ON" \
		-DEXEC="el"
USE_GNOME=	libxml2
USE_SDL=	sdl2 net2 image2 ttf2
USE_GL+=	gl glu opengl
#USE_GL+=	gl
#USE_GL+=	egl glx gl glu
USE_XORG+=	x11 sm ice xext xaw
USE_GITHUB=	nodefault
GH_ACCOUNT=	raduprv
GH_PROJECT=	Eternal-Lands
GH_TAGNAME=	4e8d05d27935a6fdc108aeb0792046a466cf183c
CMAKE_MODULE_LINKER_FLAGS=
CMAKE_SHARED_LINKER_FLAGS=

WRKSRC=	${WRKDIR}/${PORTNAME}-${GH_TAGNAME}

OPTIONS_DEFINE=			CURL DOCS EXAMPLES FREETYPE GLES LUAJIT NCURSES NLS SOUND SYSTEM_GMP \
				SYSTEM_JSONCPP
OPTIONS_DEFAULT=		CURL FREETYPE LUAJIT SOUND SYSTEM_GMP SYSTEM_JSONCPP CLIENT GLVND
OPTIONS_MULTI=			COMP
OPTIONS_RADIO=			GRAPHICS

COMP_DESC=			Software components
OPTIONS_MULTI_COMP=		CLIENT

OPTIONS_RADIO_GRAPHICS=		GLVND LEGACY

SYSTEM_GMP_DESC=		Use gmp from ports (ENABLE_SYSTEM_GMP)
SYSTEM_GMP_CMAKE_BOOL=		ENABLE_SYSTEM_GMP
SYSTEM_GMP_CMAKE_ON=		-DGMP_INCLUDE_DIR="${PREFIX}/include"
SYSTEM_GMP_LIB_DEPENDS=		libgmp.so:math/gmp

SYSTEM_JSONCPP_DESC=		Use jsoncpp from ports (ENABLE_SYSTEM_JSONCPP)
SYSTEM_JSONCPP_CMAKE_BOOL=	ENABLE_SYSTEM_JSONCPP
SYSTEM_JSONCPP_CMAKE_ON=	-DJSON_INCLUDE_DIR="${PREFIX}/include/jsoncpp"
SYSTEM_JSONCPP_LIB_DEPENDS=	libjsoncpp.so:devel/jsoncpp

GRAPHICS_DESC=			Graphics support
GLVND_DESC=			Use libOpenGL or libGLX
LEGACY_DESC=			Use libGL - where GLVND may be broken on nvidia
GLES_DESC=			Use libOpenGLES instead of libOpenGL

GLVND_CMAKE_BOOL=		ENABLE_GLVND
GLVND_CMAKE_ON=			-DOPENGL_GL_PREFERENCE="GLVND"
LEGACY_CMAKE_BOOL=		ENABLE_LEGACY
LEGACY_CMAKE_ON=		-DOPENGL_GL_PREFERENCE="LEGACY"
GLES_CMAKE_BOOL=		ENABLE_GLES

OPTIONS_SUB=			yes

CLIENT_DESC=			Build client
CLIENT_CMAKE_BOOL=		BUILD_CLIENT
CLIENT_LIB_DEPENDS=		libpng.so:graphics/png
CLIENT_USES=			gl jpeg xorg
CLIENT_USE=			GL=gl,glu \
				XORG=ice,sm,x11,xext,xxf86vm

CURL_DESC=			Enable cURL support for fetching media
CURL_CMAKE_BOOL=		ENABLE_CURL
CURL_LIB_DEPENDS=		libcurl.so:ftp/curl
SOUND_DESC=			Enable sound via openal-soft
SOUND_CMAKE_BOOL=		ENABLE_SOUND
SOUND_LIB_DEPENDS=		libvorbis.so:audio/libvorbis \
				libvorbisfile.so:audio/libvorbis
FREETYPE_DESC=			Support for TrueType fonts with unicode
FREETYPE_CMAKE_BOOL=		ENABLE_FREETYPE
FREETYPE_LIB_DEPENDS=		libfreetype.so:print/freetype2
NCURSES_DESC=			Enable ncurses console
NCURSES_CMAKE_BOOL=		ENABLE_CURSES
NCURSES_USES=			ncurses

LUAJIT_DESC=			LuaJIT support (lang/luajit-openresty)
LUAJIT_CMAKE_BOOL=		ENABLE_LUAJIT REQUIRE_LUAJIT
LUAJIT_LIB_DEPENDS=		libluajit-5.1.so:lang/luajit-openresty

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
