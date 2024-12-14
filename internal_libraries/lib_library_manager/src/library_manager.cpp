#include "library_manager.hpp"

#ifdef QT_DEBUG
    #include "logger.hpp"
#endif


LibraryManager* LibraryManager::m_Instance = Q_NULLPTR;

// Constructors, Initializers, Destructor
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

LibraryManager::LibraryManager(QObject *parent, const QString& name)
    : QObject{parent}
    , m_VideoFilePaths(QVariantList{})
    , m_AudioFilePaths(QVariantList{})
{
    this->setObjectName(name);


#ifdef QT_DEBUG
    QString message("Call to Constructor");

    logger::log(logger::LOG_LEVEL::DEBUG, this->objectName(), Q_FUNC_INFO, message);
#endif
}

LibraryManager::~LibraryManager()
{
#ifdef QT_DEBUG
    QString message("Call to Destructor");

    logger::log(logger::LOG_LEVEL::DEBUG, this->objectName(), Q_FUNC_INFO, message);
#endif
}

LibraryManager *LibraryManager::qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    if (!m_Instance)
    {
        m_Instance = new LibraryManager();
    }

    return(m_Instance);
}

LibraryManager *LibraryManager::cppInstance(QObject *parent)
{
    if(m_Instance)
    {
        return(qobject_cast<LibraryManager *>(LibraryManager::m_Instance));
    }

    auto instance = new LibraryManager(parent);
    m_Instance = instance;
    return(instance);
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PUBLIC Methods
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

// TODO (SAVIZ): This method can potentially be very expensive. Maybe it is a good idea to call this in a seperate thread.
void LibraryManager::obtainVideosUnderDirectory(const QUrl &directoryURL)
{
    QStringList videoExtensions;

    videoExtensions << "*.mp4"
                    << "*.avi"
                    << "*.mov"
                    << "*.mkv"
                    << "*.flv";


    QDirIterator iterator(
        directoryURL.toLocalFile(),   // Start location
        videoExtensions,              // File name pattern
        QDir::Files,                  // Filter for files
        QDirIterator::Subdirectories  // Perform recursively
    );

    QVariantList result;

    while (iterator.hasNext())
    {
        result.append(iterator.next());
    }

    setVideoFilePaths(result);
}

// TODO (SAVIZ): This method can potentially be very expensive. Maybe it is a good idea to call this in a seperate thread.
void LibraryManager::obtainAudiosUnderDirectory(const QUrl &directoryURL)
{
    QStringList audioExtensions;

    audioExtensions << "*.mp3"
                    << "*.wav"
                    << "*.aiff"
                    << "*.aif"
                    << "*.acc"
                    << "*.ogg";


    QDirIterator iterator(
        directoryURL.toLocalFile(),   // Start location
        audioExtensions,              // File name pattern
        QDir::Files,                  // Filter for files
        QDirIterator::Subdirectories  // Perform recursively
        );

    QVariantList result;

    while (iterator.hasNext())
    {
        result.append(iterator.next());
    }

    setAudioFilePaths(result);
}

QString LibraryManager::fileNameFromPath(const QString &filePath)
{
    return QFileInfo(filePath).fileName();
}

QUrl LibraryManager::urlFromPath(const QString &filePath)
{
    return (QUrl::fromLocalFile(filePath));
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PUBLIC Getters
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

QVariantList LibraryManager::getVideoFilePaths() const
{
    return (m_VideoFilePaths);
}

QVariantList LibraryManager::getAudioFilePaths() const
{
    return (m_AudioFilePaths);
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PRIVATE Setters
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

void LibraryManager::setVideoFilePaths(const QVariantList &newList)
{
    if (m_VideoFilePaths == newList)
    {
        return;
    }

    m_VideoFilePaths = newList;
    emit videoFilePathsChanged();
}

void LibraryManager::setAudioFilePaths(const QVariantList &newList)
{
    if (m_AudioFilePaths == newList)
    {
        return;
    }

    m_AudioFilePaths = newList;
    emit audioFilePathsChanged();
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]
