#include <memory>

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>
#include <QLocale>
#include <QTranslator>
#include <QUrl>

#include "data/Logic.h"
#include "controllers/GameController.h"

int main(int argc, char *argv[])
{   
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Basic");

    // Translator
    QTranslator translator;
    const QStringList uiLanguages = QLocale::system().uiLanguages();
    for (const QString &locale : uiLanguages) {
        const QString baseName = "MultyT_" + QLocale(locale).name();
        if (translator.load(":/i18n/" + baseName)) {
            app.installTranslator(&translator);
            break;
        }
    }

    //Game interface
    std::shared_ptr<Logic> logic = std::make_shared<Logic>();
    auto gameController = QSharedPointer<GameController>(new GameController(logic, &app));

    QQmlApplicationEngine engine;

    // Register custom types
    qmlRegisterSingletonType(QUrl{QStringLiteral("qrc:/qml/common/Common.qml")}   , "com.tu.common"   , 1, 0, "Common");
    qmlRegisterSingletonType(QUrl{QStringLiteral("qrc:/qml/common/Theme.qml")}    , "com.tu.theme"    , 1, 0, "Theme" );
    qmlRegisterSingletonType(QUrl{QStringLiteral("qrc:/qml/common/Global.qml")}   , "com.tu.global"   , 1, 0, "Global");
    qmlRegisterSingletonType(QUrl{QStringLiteral("qrc:/qml/common/Utilities.qml")}, "com.tu.utilities", 1, 0, "Utilities");

    // View
    engine.rootContext()->setContextProperty("gameController", gameController.get());
    engine.rootContext()->setContextProperty("recordsModel", gameController.get()->recordModel());

    engine.addImportPath(":/qml");
    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
