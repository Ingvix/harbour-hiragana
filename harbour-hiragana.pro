# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-hiragana

CONFIG += sailfishapp

SOURCES += src/harbour-hiragana.cpp \
    src/listelement.cpp \
    src/testclass.cpp \
    src/persistenceclass.cpp

OTHER_FILES += qml/harbour-hiragana.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-hiragana.spec \
    rpm/harbour-hiragana.yaml \
    harbour-hiragana.desktop \
    qml/pages/Test.qml \
    qml/pages/Grid.qml \
    qml/pages/About.qml \
    qml/pages/TestReverse.qml \
    qml/pages/TestFree.qml \
    qml/pages/Hiragana/zu.png \
    qml/pages/Hiragana/zo.png \
    qml/pages/Hiragana/ze.png \
    qml/pages/Hiragana/za.png \
    qml/pages/Hiragana/yu.png \
    qml/pages/Hiragana/yo.png \
    qml/pages/Hiragana/ya.png \
    qml/pages/Hiragana/wo.png \
    qml/pages/Hiragana/wa.png \
    qml/pages/Hiragana/u.png \
    qml/pages/Hiragana/tsu.png \
    qml/pages/Hiragana/to.png \
    qml/pages/Hiragana/te.png \
    qml/pages/Hiragana/ta.png \
    qml/pages/Hiragana/su.png \
    qml/pages/Hiragana/so.png \
    qml/pages/Hiragana/shu.png \
    qml/pages/Hiragana/sho.png \
    qml/pages/Hiragana/shi.png \
    qml/pages/Hiragana/sha.png \
    qml/pages/Hiragana/se.png \
    qml/pages/Hiragana/sa.png \
    qml/pages/Hiragana/ryu.png \
    qml/pages/Hiragana/ryo.png \
    qml/pages/Hiragana/rya.png \
    qml/pages/Hiragana/ru.png \
    qml/pages/Hiragana/ro.png \
    qml/pages/Hiragana/ri.png \
    qml/pages/Hiragana/re.png \
    qml/pages/Hiragana/ra.png \
    qml/pages/Hiragana/pyu.png \
    qml/pages/Hiragana/pyo.png \
    qml/pages/Hiragana/pya.png \
    qml/pages/Hiragana/pu.png \
    qml/pages/Hiragana/po.png \
    qml/pages/Hiragana/pi.png \
    qml/pages/Hiragana/pe.png \
    qml/pages/Hiragana/pa.png \
    qml/pages/Hiragana/o.png \
    qml/pages/Hiragana/nyu.png \
    qml/pages/Hiragana/nyo.png \
    qml/pages/Hiragana/nya.png \
    qml/pages/Hiragana/nu.png \
    qml/pages/Hiragana/no.png \
    qml/pages/Hiragana/ni.png \
    qml/pages/Hiragana/ne.png \
    qml/pages/Hiragana/na.png \
    qml/pages/Hiragana/n.png \
    qml/pages/Hiragana/myu.png \
    qml/pages/Hiragana/myo.png \
    qml/pages/Hiragana/mya.png \
    qml/pages/Hiragana/mu.png \
    qml/pages/Hiragana/mo.png \
    qml/pages/Hiragana/mi.png \
    qml/pages/Hiragana/me.png \
    qml/pages/Hiragana/ma.png \
    qml/pages/Hiragana/kyu.png \
    qml/pages/Hiragana/kyo.png \
    qml/pages/Hiragana/kya.png \
    qml/pages/Hiragana/ku.png \
    qml/pages/Hiragana/ko.png \
    qml/pages/Hiragana/ki.png \
    qml/pages/Hiragana/ke.png \
    qml/pages/Hiragana/ka.png \
    qml/pages/Hiragana/ju.png \
    qml/pages/Hiragana/jo.png \
    qml/pages/Hiragana/ji.png \
    qml/pages/Hiragana/ja.png \
    qml/pages/Hiragana/i.png \
    qml/pages/Hiragana/hyu.png \
    qml/pages/Hiragana/hyo.png \
    qml/pages/Hiragana/hya.png \
    qml/pages/Hiragana/ho.png \
    qml/pages/Hiragana/hi.png \
    qml/pages/Hiragana/he.png \
    qml/pages/Hiragana/ha.png \
    qml/pages/Hiragana/gyu.png \
    qml/pages/Hiragana/gyo.png \
    qml/pages/Hiragana/gya.png \
    qml/pages/Hiragana/gu.png \
    qml/pages/Hiragana/go.png \
    qml/pages/Hiragana/gi.png \
    qml/pages/Hiragana/ge.png \
    qml/pages/Hiragana/ga.png \
    qml/pages/Hiragana/fu.png \
    qml/pages/Hiragana/empty.png \
    qml/pages/Hiragana/e.png \
    qml/pages/Hiragana/dyu.png \
    qml/pages/Hiragana/dyo.png \
    qml/pages/Hiragana/dya.png \
    qml/pages/Hiragana/du.png \
    qml/pages/Hiragana/do.png \
    qml/pages/Hiragana/di.png \
    qml/pages/Hiragana/de.png \
    qml/pages/Hiragana/da.png \
    qml/pages/Hiragana/chu.png \
    qml/pages/Hiragana/cho.png \
    qml/pages/Hiragana/chi.png \
    qml/pages/Hiragana/cha.png \
    qml/pages/Hiragana/byu.png \
    qml/pages/Hiragana/byo.png \
    qml/pages/Hiragana/bya.png \
    qml/pages/Hiragana/bu.png \
    qml/pages/Hiragana/bo.png \
    qml/pages/Hiragana/bi.png \
    qml/pages/Hiragana/be.png \
    qml/pages/Hiragana/ba.png \
    qml/pages/Hiragana/a.png \
    LICENSE.txt \
    harbour-hiragana.png \
    qml/cover/cover.png \
    qml/pages/UpperPanel.qml \
    qml/pages/Settings.qml

HEADERS += \
    src/listelement.h \
    src/testclass.h \
    src/persistenceclass.h

