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

license.files = LICENSE.txt
license.path = /usr/share/$${TARGET}

INSTALLS += license

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
    LICENSE.txt \
    harbour-hiragana.png \
    qml/cover/cover.svg \
    qml/pages/UpperPanel.qml \
    qml/pages/Settings.qml \
    qml/pages/TestFreeReverse.qml \
    qml/pages/HiraganaSelector.qml \
    qml/pages/Stats.qml \
    qml/pages/HiraganaSwitch.qml

HEADERS += \
    src/listelement.h \
    src/testclass.h \
    src/persistenceclass.h
