#ifndef LIBRARYMANAGER_H
#define LIBRARYMANAGER_H

#include <QFile>
#include <QFileInfo>
#include <QDirIterator>
#include <QUrl>
#include <QGuiApplication>
#include <QObject>
#include <QQmlEngine>
#include <QVariantList>

class LibraryManager : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY_MOVE(LibraryManager) // Needed for Singleton pattern.

    // Q_PROPERTY
    Q_PROPERTY(QVariantList videoFilePaths READ getVideoFilePaths NOTIFY videoFilePathsChanged)

    // Constructors, Initializers, Destructor
public:
    explicit LibraryManager(QObject *parent = nullptr, const QString& name = "No name");
    ~LibraryManager();

    static LibraryManager *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static LibraryManager *cppInstance(QObject *parent = nullptr);

    // Fields
private:
    static LibraryManager *m_Instance;
    QVariantList m_VideoFilePaths;

    // Signals
signals:
    void videoFilePathsChanged();

    // PUBLIC Methods
public:
    Q_INVOKABLE void obtainVideosUnderDirectory(const QUrl &directoryURL);
    Q_INVOKABLE QString fileNameFromPath(const QString &filePath);
    Q_INVOKABLE QUrl urlFromPath(const QString &filePath);

    // PUBLIC Getters
public:
    QVariantList getVideoFilePaths() const;

    // PRIVATE Setters
private:
    void setVideoFilePaths(const QVariantList &newList);
};

#endif // LIBRARYMANAGER_H
