#include "library_manager.hpp"

LibraryManager* LibraryManager::m_Instance = nullptr;

// Constructors, Initializers, Destructor
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

LibraryManager::LibraryManager(QObject *parent, const QString& name)
    : QObject{parent}
    , m_VideoFilePaths(QVariantList{})
{
    this->setObjectName(name);



// Debugging
#ifdef QT_DEBUG
    qDebug() << "\n**************************************************\n"
             << "* Object Name :" << this->objectName()  << "\n"
             << "* Function    :" << __FUNCTION__        << "\n"
             << "* Message     : Call to Constructor"
             << "\n**************************************************\n\n";
#endif
}

LibraryManager::~LibraryManager()
{



// Debugging
#ifdef QT_DEBUG
    qDebug() << "\n**************************************************\n"
             << "* Object Name :" << this->objectName()  << "\n"
             << "* Function    :" << __FUNCTION__        << "\n"
             << "* Message     : Call to Destructor"
             << "\n**************************************************\n\n";
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

// TODO This method can potentially be very expensive. Maybe it is a good idea to call this in a seperate thread.
void LibraryManager::obtainVideosUnderDirectory(const QUrl &directoryURL)
{
    QStringList videoExtensions;

    videoExtensions << "*.mp4"
                    << "*.avi"
                    << "*.mov"
                    << "*.mkv"
                    << "*.flv";


    QDirIterator iterator(
        directoryURL.toLocalFile(),                // Start location
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

QString LibraryManager::fileNameFromPath(const QString &filePath)
{
    return QFileInfo(filePath).fileName();
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PRIVATE Methods
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PUBLIC Getters
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

QVariantList LibraryManager::getVideoFilePaths() const
{
    return (m_VideoFilePaths);
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

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]
