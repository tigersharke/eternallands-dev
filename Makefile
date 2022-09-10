PORTNAME=	Eternal-Lands
DISTVERSION=	g20220520
CATEGORIES=	games
PKGNAMESUFFIX=	-dev
DISTNAME=	${GH_TAGNAME}
DIST_SUBDIR=	${PORTNAME}${PKGNAMESUFFIX}

MAINTAINER=	nope@nothere
COMMENT=	Client for Eternal Lands MMORPG 3d fantasy game

#LICENSE=
#BUILD_DEPENDS=
#RUN_DEPENDS=
LIB_DEPENDS+=	libcal3d.so:graphics/cal3d \
		libvorbis.so:audio/libvorbis \
		libvorbisfile.so:audio/libvorbis \
		libpng16.so:graphics/png

USES=		cmake ssl openal iconv \
		compiler:c++17-lang gnome \
		openal:al,alut sdl xorg

#LDFLAGS+=	-L${ICONV_LIB}
CONFLICTS=	el
CMAKE_ARGS+=	-DIconv_LIBRARIES="-L${LOCALBASE}/lib -liconv" \
		-DBUILD_UNITTESTS="FALSE" \
		-DCMAKE_BUILD_TYPE="MinSizeRel" \
		-DCMAKE_VERBOSE_MAKEFILE="TRUE" \
		-DCUSTOM_EXAMPLE_CONF_DIR="${PREFIX}/etc" \
		-DCUSTOM_MANDIR="${PREFIX}/man" \
		-DOPENGL_xmesa_INCLUDE_DIR="${PREFIX}/lib" \
		-DEXEC="el"
USE_GNOME=	libxml2
USE_SDL=	sdl2 net2 image2 ttf2
USE_GL+=	gl
#USE_GL+=	egl glx gl glu
USE_XORG+=	x11 sm ice xext
USE_GITHUB=	nodefault
GH_ACCOUNT=	raduprv
GH_PROJECT=	Eternal-Lands
GH_TAGNAME=	0c6335c3bf8bdbfbb7bcfb2eab75f00e26ad1a7b
CMAKE_MODULE_LINKER_FLAGS=
CMAKE_SHARED_LINKER_FLAGS=

WRKSRC=	${WRKDIR}/${PORTNAME}-${GH_TAGNAME}

# Bulk of these options pulled from minetest-dev unofficial port.
# Actual cmake options:
#
# FREETYPE_INCLUDE_DIR_freetype2:PATH=/usr/local/include/freetype2
# FREETYPE_INCLUDE_DIR_ft2build:PATH=/usr/local/include/freetype2
# FREETYPE_LIBRARY_DEBUG:FILEPATH=FREETYPE_LIBRARY_DEBUG-NOTFOUND
# FREETYPE_LIBRARY_RELEASE:FILEPATH=/usr/local/lib/libfreetype.so
# FSAA:BOOL=ON
# Fontconfig_INCLUDE_DIR:PATH=/usr/local/include
# Fontconfig_LIBRARY:FILEPATH=/usr/local/lib/libfontconfig.so
# JSON_FILES:BOOL=ON
# LIBXML2_INCLUDE_DIR:PATH=/usr/local/include/libxml2
# LIBXML2_LIBRARY:FILEPATH=/usr/local/lib/libxml2.so
# LIBXML2_XMLLINT_EXECUTABLE:FILEPATH=/usr/local/bin/xmllint
# LOCAL_NLOHMANN_JSON:BOOL=OFF
# MARCHNATIVE:BOOL=OFF
# OPENAL_INCLUDE_DIR:PATH=/usr/local/include/AL
# OPENAL_LIBRARY:FILEPATH=/usr/local/lib/libopenal.so
# OPENGL_EGL_INCLUDE_DIR:PATH=/usr/local/include
# OPENGL_GLX_INCLUDE_DIR:PATH=/usr/local/include
# OPENGL_INCLUDE_DIR:PATH=/usr/local/include
# OPENGL_egl_LIBRARY:FILEPATH=/usr/local/lib/libEGL.so
# OPENGL_gl_LIBRARY:FILEPATH=/usr/local/lib/libGL.so
# OPENGL_glu_LIBRARY:FILEPATH=/usr/local/lib/libGLU.so
# OPENGL_glx_LIBRARY:FILEPATH=/usr/local/lib/libGLX.so
# OPENGL_opengl_LIBRARY:FILEPATH=/usr/local/lib/libOpenGL.so
# OPENGL_xmesa_INCLUDE_DIR:PATH=OPENGL_xmesa_INCLUDE_DIR-NOTFOUND
# OPENSSL_CRYPTO_LIBRARY:FILEPATH=/usr/local/lib/libcrypto.so
# OPENSSL_INCLUDE_DIR:PATH=/usr/local/include
# OPENSSL_SSL_LIBRARY:FILEPATH=/usr/local/lib/libssl.so
# PACKET_COMPRESSION:BOOL=ON
# PKG_CONFIG_ARGN:STRING=
# PKG_CONFIG_EXECUTABLE:FILEPATH=/usr/local/bin/pkg-config
# PNG_LIBRARY_DEBUG:FILEPATH=PNG_LIBRARY_DEBUG-NOTFOUND
# PNG_LIBRARY_RELEASE:FILEPATH=/usr/local/lib/libpng.so
# PNG_PNG_INCLUDE_DIR:PATH=/usr/local/include
# SDL2MAIN_LIBRARY:FILEPATH=/usr/local/lib/libSDL2main.a
# SDL2TTFMAIN_LIBRARY:FILEPATH=/usr/local/lib/libSDL2_ttf.so
# SDL2TTF_INCLUDE_DIR:PATH=/usr/local/include/SDL2
# SDL2TTF_LIBRARY:STRING=/usr/local/lib/libSDL2_ttf.so;/usr/local/lib/libSDL2_ttf.so;-lpthread
# SDL2_IMAGE_INCLUDE_DIR:PATH=/usr/local/include/SDL2
# SDL2_IMAGE_LIBRARY:STRING=/usr/local/lib/libSDL2_image.so
# SDL2_INCLUDE_DIR:PATH=/usr/local/include/SDL2
# SDL2_LIBRARY:STRING=/usr/local/lib/libSDL2main.a;/usr/local/lib/libSDL2.so;-lpthread
# SDL2_NET_INCLUDE_DIR:PATH=/usr/local/include/SDL2
# SDL2_NET_LIBRARY:STRING=/usr/local/lib/libSDL2_net.so
# TTF:BOOL=ON
# USE_SSL:BOOL=ON
# VORBISFILE_INCLUDE_DIR:PATH=/usr/local/include
# VORBISFILE_LIBRARY:FILEPATH=/usr/local/lib/libvorbisfile.so
# VORBISFILE_LIBRARY_DEBUG:FILEPATH=/usr/local/lib/libvorbisfile.so
# VORBIS_INCLUDE_DIR:PATH=/usr/local/include
# VORBIS_LIBRARY:FILEPATH=/usr/local/lib/libvorbis.so
# VORBIS_LIBRARY_DEBUG:FILEPATH=/usr/local/lib/libvorbis.so

OPTIONS_DEFINE=			CURL DOCS EXAMPLES FREETYPE GLES LUAJIT NCURSES NLS SOUND SYSTEM_GMP \
				SYSTEM_JSONCPP
OPTIONS_DEFAULT=		CURL FREETYPE LUAJIT SOUND SYSTEM_GMP SYSTEM_JSONCPP CLIENT GLVND
OPTIONS_MULTI=			COMP
OPTIONS_RADIO=			GRAPHICS
OPTIONS_GROUP=			DATABASE

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

#DATABASE_DESC=			Database support
#OPTIONS_GROUP_DATABASE=		LEVELDB PGSQL REDIS SPATIAL

OPTIONS_SUB=			yes

CLIENT_DESC=			Build client
CLIENT_CMAKE_BOOL=		BUILD_CLIENT
CLIENT_LIB_DEPENDS=		libpng.so:graphics/png
CLIENT_USES=			gl jpeg xorg
CLIENT_USE=			GL=gl,glu \
				XORG=ice,sm,x11,xext,xxf86vm
#SERVER_DESC=			Build server
#SERVER_CMAKE_BOOL=		BUILD_SERVER

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

#LEVELDB_DESC=			Enable LevelDB backend
#LEVELDB_CMAKE_BOOL=		ENABLE_LEVELDB
#LEVELDB_LIB_DEPENDS=		libleveldb.so:databases/leveldb
#PGSQL_DESC=			Enable PostgreSQL map backend
#PGSQL_USES=			pgsql
#PGSQL_CMAKE_BOOL=		ENABLE_POSTGRESQL
#REDIS_DESC=			Enable Redis backend
#REDIS_CMAKE_BOOL=		ENABLE_REDIS
#REDIS_LIB_DEPENDS=		libhiredis.so:databases/hiredis
#SPATIAL_DESC=			Enable SpatialIndex (Speeds up AreaStores)
#SPATIAL_LIB_DEPENDS=		libspatialindex.so:devel/spatialindex
#SPATIAL_CMAKE_BOOL=		ENABLE_SPATIAL

NLS_DESC=			Native Language Support (ENABLE_GETTEXT)
NLS_CMAKE_BOOL=			ENABLE_GETTEXT
NLS_USES=			gettext
NLS_LDFLAGS=			-L${LOCALBASE}/lib

#TOUCH_DESC=			Build with touch interface support
#TOUCH_CMAKE_BOOL=		ENABLE_TOUCH

#PROMETHEUS_DESC=		Build with Prometheus metrics exporter
#PROMETHEUS_CMAKE_BOOL=		ENABLE_PROMETHEUS
#PROMETHEUS_USES=		gettext

# ===> Staging for Eternal-Lands-dev-g20220312
# ===> Eternal-Lands-dev-g20220312 depends on file: /usr/local/lib/libcrypto.so.47 - found
# ===> Eternal-Lands-dev-g20220312 depends on file: /usr/local/libdata/pkgconfig/x11.pc - found
# ===> Eternal-Lands-dev-g20220312 depends on file: /usr/local/libdata/pkgconfig/sm.pc - found
# ===> Eternal-Lands-dev-g20220312 depends on file: /usr/local/libdata/pkgconfig/ice.pc - found
# ===> Eternal-Lands-dev-g20220312 depends on file: /usr/local/libdata/pkgconfig/xext.pc - found
# ===> Generating temporary packing list
# [ 0% 1/1] cd /usr/home/tigersharke/Ported_Software/games/eternallands/work/.build && /usr/local/bin/cmake -DCMAKE_INSTALL_DO_STRIP=1 -P cmake_install.cmake
# -- Install configuration: "Release"
# -- Installing: /usr/home/tigersharke/Ported_Software/games/eternallands/work/stage/usr/local/bin/el.bsd.bin
# -- Set runtime path of "/usr/home/tigersharke/Ported_Software/games/eternallands/work/stage/usr/local/bin/el.bsd.bin" to "/usr/local/lib"
# ====> Compressing man pages (compress-man)
# ====> Running Q/A tests (stage-qa)
# Error: /usr/local/bin/el.bsd.bin is linked to /usr/local/lib/libGL.so.1 from graphics/libglvnd but it is not declared as a dependency
# Warning: you need USE_GL+=gl
# Error: /usr/local/bin/el.bsd.bin is linked to /usr/local/lib/libGLU.so.1 from graphics/libGLU but it is not declared as a dependency
# Warning: you need USE_GL+=glu
# Error: /usr/local/bin/el.bsd.bin is linked to /usr/local/lib/libiconv.so.2 from converters/libiconv but it is not declared as a dependency
# Warning: you need USES+=iconv, USES+=iconv:wchar_t, or USES+=iconv:translit depending on needs
# ===> Installing for Eternal-Lands-dev-g20220312
# ===> Checking if Eternal-Lands-dev is already installed
# ===> Registering installation for Eternal-Lands-dev-g20220312
# Installing Eternal-Lands-dev-g20220312...
# ===> Cleaning for Eternal-Lands-dev-g20220312
#
# https://github.com/raduprv/Eternal-Lands/search?q=servers.lst
#
# --------------------------------------------------------------------
#
#  This presently builds, and if the data files are installed, and we run el from there, it mostly works.
#  Unsure if a build issue or something else, but although I can get it to connect and function, it seems
#  particularly laggy and often needs a resync, also, quitting the client is not always easy and must be
#  killed instead.
#
#  The servers.lst file was tracked down last time I worked on this using the url above.
#
#  For continuity and certainty, I'll be making an eternal lands data repo as well, so I can update that
#  when it is necessary. Can I incorporate the data install into the el port as it is a requirement?
#  Something to investigate and figure out, something in my collection pulls two git repos, maybe that
#  could be adjusted to have one portion not a build install as this is.

.include <bsd.port.options.mk>

.include <bsd.port.mk>
