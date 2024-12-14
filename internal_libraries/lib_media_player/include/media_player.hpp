#ifndef MEDIAPLAYER_H
#define MEDIAPLAYER_H

#include <QObject>
#include <QFile>
#include <QFileInfo>
#include <QDirIterator>
#include <QUrl>
#include <QGuiApplication>
#include <QQmlEngine>
#include <QMediaPlayer>
#include <QMediaDevices>
#include <QAudioDevice>
#include <QAudioOutput>

class MediaPlayer : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY_MOVE(MediaPlayer) // Needed for Singleton pattern.

    // Q_PROPERTY
    Q_PROPERTY(QObject* videoSurface READ getVideoSurface WRITE setVideoSurface)
    Q_PROPERTY(QString duration READ getDuration NOTIFY durationChanged) // Maximum position in timeline
    Q_PROPERTY(QString position READ getPosition NOTIFY positionChanged) // Current position in timeline
    Q_PROPERTY(qreal maxValue READ getMaxValue NOTIFY maxValueChanged) // Same as duration, but for the UFO_Slider to be used
    Q_PROPERTY(qreal currentValue READ getCurrentValue NOTIFY currentValueChanged) // Same as position, but for the UFO_Slider to be used
    Q_PROPERTY(qreal volume READ getVolume WRITE setVolume NOTIFY volumeChanged)
    Q_PROPERTY(bool isPlaying READ getIsPlaying NOTIFY isPlayingChanged) // If not playing, then it must be paused

public:
    enum class Loop
    {
        Infinite = 0,
        Once = 1
    };

    Q_ENUM(Loop)

    // Constructors, Initializers, Destructor
public:
    explicit MediaPlayer(QObject *parent = Q_NULLPTR, const QString& name = "No name");
    ~MediaPlayer();

    static MediaPlayer *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static MediaPlayer *cppInstance(QObject *parent = Q_NULLPTR);

    // Fields
private:
    static MediaPlayer *m_Instance;
    QObject* m_VideoOutput;
    QMediaPlayer* m_MediaPlayer;
    QAudioOutput* m_AudioOutput;
    QString m_duration;
    QString m_position;
    qreal m_currentValue;
    qreal m_maxValue;
    qreal m_Volume;
    bool m_isPlaying;

    // Signals
signals:
    void videoFilePathsChanged();
    void durationChanged();
    void positionChanged();
    void currentValueChanged();
    void maxValueChanged();
    void volumeChanged();
    void isPlayingChanged();

private slots:
    void onDurationChanged(qint64 duration);
    void onPositionChanged(qint64 position);

    // PUBLIC Methods
public:
    Q_INVOKABLE void play();
    Q_INVOKABLE void pause();
    Q_INVOKABLE void rewind();
    Q_INVOKABLE void forward();
    Q_INVOKABLE void setLoopCount(const Loop &option);
    Q_INVOKABLE void setPlayBackRate(qreal newRate);
    Q_INVOKABLE void setPosition(qreal newPosition);

    // PRIVATE Methods
private:
    QString formatIntoTime(qint64 milliseconds);

    // PUBLIC Getters
public:
    QObject* getVideoSurface();
    QVariantList getVideoFilePaths() const;
    QString getDuration() const;
    QString getPosition() const;
    qreal getMaxValue() const;
    qreal getCurrentValue() const;
    qreal getVolume() const;
    bool getIsPlaying() const;

    // PUBLIC Setters
public:
    void setVideoSurface(QObject* surface);
    void setVolume(qreal newVolume);
    Q_INVOKABLE void setMediaFile(QUrl filePath);

    // PRIVATE Setters
private:
    void setDuration(const QString &newDuration);
    void setPosition(const QString &newPosition);
    void setMaxValue(qreal newValue);
    void setCurrentValue(qreal newValue);
    void setIsPlaying(bool newState);
};

#endif // MEDIAPLAYER_H
