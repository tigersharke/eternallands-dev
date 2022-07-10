PORTNAME=	Eternal-Lands
DISTVERSION=	g20220312
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
CMAKE_ARGS+=	-DIconv_LIBRARIES="-L${LOCALBASE}/lib -liconv"
USE_GNOME=	libxml2
USE_SDL=	sdl2 net2 image2 ttf2
USE_GL+=	gl
#USE_GL+=	egl glx gl glu
USE_XORG+=	x11 sm ice xext
USE_GITHUB=     nodefault
GH_ACCOUNT=     raduprv
GH_PROJECT=     Eternal-Lands
GH_TAGNAME=	89324a0a9ab2e804cb6eef3bc0f0d224759210de
CMAKE_MODULE_LINKER_FLAGS=
CMAKE_SHARED_LINKER_FLAGS=
CMAKE_VERBOSE_MAKEFILE=

WRKSRC=	${WRKDIR}/${PORTNAME}-${GH_TAGNAME}

# ===>  Staging for Eternal-Lands-dev-g20220312
# ===>   Eternal-Lands-dev-g20220312 depends on file: /usr/local/lib/libcrypto.so.47 - found
# ===>   Eternal-Lands-dev-g20220312 depends on file: /usr/local/libdata/pkgconfig/x11.pc - found
# ===>   Eternal-Lands-dev-g20220312 depends on file: /usr/local/libdata/pkgconfig/sm.pc - found
# ===>   Eternal-Lands-dev-g20220312 depends on file: /usr/local/libdata/pkgconfig/ice.pc - found
# ===>   Eternal-Lands-dev-g20220312 depends on file: /usr/local/libdata/pkgconfig/xext.pc - found
# ===>   Generating temporary packing list
# [  0% 1/1] cd /usr/home/tigersharke/Ported_Software/games/eternallands/work/.build && /usr/local/bin/cmake -DCMAKE_INSTALL_DO_STRIP=1 -P cmake_install.cmake
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
# ===>  Installing for Eternal-Lands-dev-g20220312
# ===>  Checking if Eternal-Lands-dev is already installed
# ===>   Registering installation for Eternal-Lands-dev-g20220312
# Installing Eternal-Lands-dev-g20220312...
# ===>  Cleaning for Eternal-Lands-dev-g20220312

.include <bsd.port.options.mk>

.include <bsd.port.mk>
