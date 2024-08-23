#ifndef MediaPlayer_H
#define MediaPlayer_H

#include <QFile>
#include <QFileInfo>
#include <QDirIterator>
#include <QUrl>
#include <QGuiApplication>
#include <QObject>
#include <QQmlEngine>
#include <QMediaPlayer>
#include <QAudioOutput>

class MediaPlayer : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY_MOVE(MediaPlayer) // Needed for Singleton pattern.

    // Q_PROPERTY;
    Q_PROPERTY(QString duration READ getDuration NOTIFY durationChanged) // Maximum position in timeline
    Q_PROPERTY(QString position READ getPosition NOTIFY positionChanged) // Current position in timeline
    Q_PROPERTY(qreal currentValue READ getCurrentValue NOTIFY currentValueChanged) // Same as position, but for the UFO_Slider to be used
    Q_PROPERTY(bool isPlaying READ getIsPosition NOTIFY isPlayingChanged) // If not playing, then it must be paused

public:
    enum class Loop
    {
        Infinite = 0,
        Once = 1
    };

    // Constructors, Initializers, Destructor
public:
    explicit MediaPlayer(QObject *parent = nullptr, const QString& name = "No name");
    ~MediaPlayer();

    static MediaPlayer *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static MediaPlayer *cppInstance(QObject *parent = nullptr);

    // Fields
private:
    static MediaPlayer *m_Instance;
    QMediaPlayer* m_MediaPlayer;
    QAudioOutput* m_AudioOutput;
    QString m_duration;
    QString m_position;
    qreal m_currentValue;
    bool m_isPlaying;

    // Signals
signals:
    void videoFilePathsChanged();
    void durationChanged();
    void positionChanged();
    void currentValueChanged();
    void isPlayingChanged();

private slots:
    void onDurationChanged(qint64 duration);
    void onPositionChanged(qint64 position);

    // PUBLIC Methods
public:
    Q_INVOKABLE void setMediaFile(const QString &filePath);
    // Q_INVOKABLE void stop(); // Not sure if this is needed since most of the time we can just pause and play.
    Q_INVOKABLE void play();
    Q_INVOKABLE void pause();
    Q_INVOKABLE void rewind();
    Q_INVOKABLE void forward();
    Q_INVOKABLE void setLoopCount(const Loop &option);

    // PRIVATE Methods
private:
    QString formatIntoTime(qint64 milliseconds);

    // PUBLIC Getters
public:
    QVariantList getVideoFilePaths() const;
    QString getDuration() const;
    QString getPosition() const;
    qreal getCurrentValue() const;
    bool getIsPlaying() const;

    // PUBLIC Setters
public:
    Q_INVOKABLE void setVolume(qreal newVolume);

    // PRIVATE Setters
private:
    void setVideoFilePaths(const QVariantList &newList);
    void setDuration(const QString &newDuration);
    void setPosition(const QString &newPosition);
    void setCurrentValue(qreal newValue);
    void setIsPlaying(bool newState);
};

#endif // MediaPlayer_H
