#include "media_player.hpp"

MediaPlayer* MediaPlayer::m_Instance = nullptr;

// Constructors, Initializers, Destructor
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

MediaPlayer::MediaPlayer(QObject *parent, const QString& name)
    : QObject{parent}
    , m_VideoOutput(nullptr)
    , m_MediaPlayer(new QMediaPlayer(this))
    , m_AudioOutput(new QAudioOutput(this))
    , m_duration(QString("00:00:00"))
    , m_position(QString("00:00:00"))
    , m_maxValue(qreal(0)) // TODO potentially set this to max value of qreal
    , m_currentValue(qreal(0))
    , m_Volume(qreal(0.65))
    , m_isPlaying(false)
{
    this->setObjectName(name);



    m_MediaPlayer->setAudioOutput(m_AudioOutput);

    // TODO (Saviz): Use this list to provide a method for the user to select their audio device.
    for(const auto& device : QMediaDevices::audioOutputs())
    {
        qDebug() << device.description();
    }


    connect(
        this->m_MediaPlayer,
        &QMediaPlayer::durationChanged,
        this,
        &MediaPlayer::onDurationChanged
    );

    connect(
        this->m_MediaPlayer,
        &QMediaPlayer::positionChanged,
        this,
        &MediaPlayer::onPositionChanged
    );

// Debugging
#ifdef QT_DEBUG
    qDebug() << "\n**************************************************\n"
             << "* Object Name :" << this->objectName()  << "\n"
             << "* Function    :" << __FUNCTION__        << "\n"
             << "* Message     : Call to Constructor"
             << "\n**************************************************\n\n";
#endif
}

MediaPlayer::~MediaPlayer()
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

MediaPlayer *MediaPlayer::qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    if (!m_Instance)
    {
        m_Instance = new MediaPlayer();
    }

    return(m_Instance);
}

MediaPlayer *MediaPlayer::cppInstance(QObject *parent)
{
    if(m_Instance)
    {
        return(qobject_cast<MediaPlayer *>(MediaPlayer::m_Instance));
    }

    auto instance = new MediaPlayer(parent);
    m_Instance = instance;
    return(instance);
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PRIVATE Slots
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

void MediaPlayer::onDurationChanged(qint64 duration)
{
    setMaxValue(duration);

    QString newDuration = formatIntoTime(duration);

    setDuration(newDuration);
}

void MediaPlayer::onPositionChanged(qint64 position)
{
    // Change value
    setCurrentValue(position);

    // Change text format
    QString newPosition = formatIntoTime(position);

    setPosition(newPosition);
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PUBLIC Methods
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

// void MediaPlayer::stop()
// {
//     m_MediaPlayer->stop();
// }

void MediaPlayer::play()
{
    m_MediaPlayer->play();

    setIsPlaying(true);
}

void MediaPlayer::pause()
{
    m_MediaPlayer->pause();

    setIsPlaying(false);
}

void MediaPlayer::rewind()
{
    // TODO make a setting for controlling the amount of time.
    m_MediaPlayer->setPosition(
        m_MediaPlayer->position() - 1000 // ms (Miliseconds)
    );
}

void MediaPlayer::forward()
{
    // TODO make a setting for controlling the amount of time.
    m_MediaPlayer->setPosition(
        m_MediaPlayer->position() + 1000 // ms (Miliseconds)
    );
}

void MediaPlayer::setLoopCount(const Loop &option)
{
    if(option == Loop::Infinite)
    {
        m_MediaPlayer->setLoops(
            QMediaPlayer::Infinite
        );

        return;
    }

    m_MediaPlayer->setLoops(
        QMediaPlayer::Once
    );
}

void MediaPlayer::setPlayBackRate(qreal newRate)
{
    m_MediaPlayer->setPlaybackRate(newRate);
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PRIVATE Methods
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

QString MediaPlayer::formatIntoTime(qint64 milliseconds)
{
    qint64 totalSeconds = milliseconds / 1000;
    qint64 hours = totalSeconds / 3600;
    qint64 minutes = (totalSeconds % 3600) / 60;
    qint64 seconds = totalSeconds % 60;

    return(
        QString("%1:%2:%3").arg(hours, 2, 10, QChar('0')).arg(minutes, 2, 10, QChar('0')).arg(seconds, 2, 10, QChar('0'))
    );
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PUBLIC Getters
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

QObject *MediaPlayer::getVideoSurface()
{
    return (m_VideoOutput);
}

QString MediaPlayer::getDuration() const
{
    return (m_duration);
}

QString MediaPlayer::getPosition() const
{
    return (m_position);
}

qreal MediaPlayer::getMaxValue() const
{
    return (m_maxValue);
}

qreal MediaPlayer::getCurrentValue() const
{
    return (m_currentValue);
}

qreal MediaPlayer::getVolume() const
{
    return (m_Volume);
}

bool MediaPlayer::getIsPlaying() const
{
    return (m_isPlaying);
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PUBLIC Setters
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

void MediaPlayer::setVideoSurface(QObject *surface)
{
    m_MediaPlayer->setVideoOutput(surface);
}

void MediaPlayer::setVolume(qreal newVolume)
{
    m_AudioOutput->setVolume(newVolume);
}

void MediaPlayer::setMediaFile(QUrl filePath)
{
    m_MediaPlayer->setSource(filePath);
}



// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PRIVATE Setters
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

void MediaPlayer::setVideoFilePaths(const QVariantList &newList)
{
    // if (m_VideoFilePaths == newList)
    // {
    //     return;
    // }

    // m_VideoFilePaths = newList;
    // emit videoFilePathsChanged();
}

void MediaPlayer::setDuration(const QString &newDuration)
{
    if (m_duration == newDuration)
    {
        return;
    }

    m_duration = newDuration;
    emit durationChanged();
}

void MediaPlayer::setPosition(const QString &newPosition)
{
    if (m_position == newPosition)
    {
        return;
    }

    m_position = newPosition;
    emit positionChanged();
}

void MediaPlayer::setMaxValue(qreal newValue)
{
    if (m_maxValue == newValue)
    {
        return;
    }

    m_maxValue = newValue;
    emit maxValueChanged();
}

void MediaPlayer::setCurrentValue(qreal newValue)
{
    if (m_currentValue == newValue)
    {
        return;
    }

    m_currentValue = newValue;
    emit currentValueChanged();
}

void MediaPlayer::setIsPlaying(bool newState)
{
    if (m_isPlaying == newState)
    {
        return;
    }

    m_isPlaying = newState;
    emit isPlayingChanged();
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]
