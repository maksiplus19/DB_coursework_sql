create database SerialTracker
go

use SerialTracker
go

create table Watcher
(
    WatcherID int IDENTITY(1,1) PRIMARY KEY,
    Login varchar(50) not null,
    Password varchar(100) not null
)
go

create table Show
(
    ShowID int identity(1,1) primary key ,
    Name varchar(50) not null ,
    ReleaseYear int not null ,
    Timing int not null ,
    Description text ,
    ShowScore float
)
go

create table Episode
(
    EpisodeId int identity(1,1) primary key ,
    Season int not null ,
    Series int not null ,
    EpisodeScore float ,
    Name varchar(50),
    Description text
)
go

create table WatcherShow
(
    WatcherID int not null ,
    ShowID int not null ,
    Score int
)
go

create table ShowEpisode
(
    ShowID int not null ,
    EpisodeID int not null
)
go

create table WatcherEpisode
(
    WatcherID int not null ,
    EpisodeID int not null ,
    Score int
)
go

create view Stat
as
    select Show.Name, Show.Timing*count(WatcherEpisode.EpisodeID) as Minute, count(WatcherEpisode.EpisodeID) as Episodes
    from Episode, Show, ShowEpisode, WatcherEpisode
    where ShowEpisode.EpisodeID = Episode.EpisodeId and Show.ShowID = ShowEpisode.ShowID and WatcherEpisode.EpisodeID = Episode.EpisodeId
    group by Show.ShowID, Show.Name, Show.Timing
go

create view ShowEpisodeView
as
    select Show.ShowID, Show.Name as ShowName, Episode.EpisodeId, Episode.Name as EpisodeName, Season, Series
    from Show, Episode, ShowEpisode SE
    where Show.ShowID = SE.ShowID and Episode.EpisodeId = SE.EpisodeID
go

alter table WatcherShow
add constraint FK_WatcherShow foreign key (WatcherID)
references Watcher (WatcherID) on delete cascade on update cascade
go

alter table WatcherShow
add constraint FK_ShowWatcher foreign key (ShowID)
references Show (ShowID) on delete cascade on UPDATE cascade
go

alter table ShowEpisode
add constraint FK_ShowEpisode foreign key (ShowID)
references Show (ShowID) on delete cascade on UPDATE cascade
go

alter table ShowEpisode
add constraint FK_EpisodeShow foreign key (EpisodeID)
references Episode (EpisodeID) on delete cascade on UPDATE cascade
go

alter table WatcherEpisode
add constraint FK_WatcherEpisode foreign key (WatcherID)
references Watcher (WatcherID) on delete cascade on update cascade
go

alter table WatcherEpisode
add constraint FK_EpisodeWatcher foreign key (EpisodeID)
references Episode (EpisodeID) on delete cascade on UPDATE cascade
go