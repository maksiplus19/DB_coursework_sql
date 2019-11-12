use SerialTracker
go

create proc GetWatchingShow @WatcherID as int
as
    select Show.* from WatcherShow inner join Show on WatcherShow.ShowID = Show.ShowID
    where WatcherID = @WatcherID
go

create proc EpisodeWatched @WatcherID as int, @EpisodeID as int, @Score as int = null
as
    if not exists(select * from WatcherEpisode where @WatcherID = WatcherID and @EpisodeID = EpisodeID)
        begin
            insert into WatcherEpisode(WatcherID, EpisodeID, Score) values (@WatcherID, @EpisodeID, @Score)
            select 1
        end
    else select 0
go

create proc NewShow @Name as int, @Year as int, @Timing as int, @Description as text = null
as
    if not exists(select * from Show where Name = @Name and ReleaseYear = @Year)
    begin
        insert into Show(Name, ReleaseYear, Timing, Description) values (@Name, @Year, @Timing, @Description)
        select 1
    end
    else
    select 0
go

create proc GetWatchedEpisode @WatcherID as int
as
    select * from WatcherEpisode inner join Episode as E on WatcherEpisode.EpisodeID = E.EpisodeId
    where WatcherID = @WatcherID
go

create proc NewEpisode @ShowID as int, @Season as int, @Series as int, @Name as varchar(50) = null, @Description as text = null
as
    if exists(select * from Show where ShowID = @ShowID)
        begin
        if not exists(select * from (
                                        select Episode.EpisodeId, ShowID, Season, Series from Episode inner join ShowEpisode
                                        on Episode.EpisodeId = ShowEpisode.EpisodeID where ShowID = @ShowID
                                    ) as tmp
                        where Season = @Season and Series = @Series)
                insert into Episode(Season, Series, Name, Description) values (@Season, @Series, @Name, @Description)
        else
            begin
                select 0
                return
            end
        insert into ShowEpisode(ShowID, EpisodeID) values
                    (@ShowID, (select top 1 EpisodeID from Episode order by EpisodeId desc))
        select 1
        end
    else select 0
go

create proc ReviewShow @WatcherID as int, @ShowID as int, @Score as int = null
as
    if exists(select * from WatcherShow where @ShowID = ShowID and @WatcherID = WatcherID)
        update WatcherShow set Score = @Score where @WatcherID = WatcherID and @ShowID = ShowID
    else
        insert into WatcherShow(WatcherID, ShowID, Score) values (@WatcherID, @ShowID, @Score)
    exec UpdateScoreShow @ShowID
go

create proc ReviewEpisode @WatcherID as int, @EpisodeID as int, @Score as int = null
as
    if exists(select * from WatcherEpisode where @WatcherID = WatcherID and @EpisodeID = EpisodeID)
        update WatcherEpisode set Score = @Score where @WatcherID = WatcherID and @EpisodeID = EpisodeID
    else
        insert into WatcherEpisode(WatcherID, EpisodeID, Score) values (@WatcherID, @EpisodeID, @Score)
    exec UpdateScoreEpisode @EpisodeID
go

create proc GetAllShows as select * from Show
go

create proc Authorise @Login as varchar(50), @Password as varchar(100)
as
    if exists(select * from Watcher where @Login = Login and @Password = Password)
        select WatcherID from Watcher where @Login = Login
    else select 0
go

create proc Registration @Login as varchar(50), @Password as varchar(100)
as
    if not exists(select * from Watcher where @Login = Login)
    begin
        insert into Watcher(Login, Password) values (@Login, @Password)
        select 1
    end
    else select 0
go


create proc GetEpisodes @ShowID as int
as
    select * from Episode inner join ShowEpisode SE on Episode.EpisodeId = SE.EpisodeID where @ShowID = ShowID
go

create proc UpdateScoreEpisode @EpisodeID as int
as
    update Episode SET EpisodeScore = (select avg(Score) from WatcherEpisode
    where @EpisodeID = EpisodeID) where @EpisodeID = EpisodeId
go

create proc GetWatcherShowScore @WatcherID as int, @ShowID as int
as
    select Score from WatcherShow where @ShowID = ShowID and @WatcherID = WatcherID
go

create proc GetWatcherEpisodeScore @WatcherID as int, @EpisodeID as int
as
    select Score from WatcherEpisode where @WatcherID = WatcherID and @EpisodeID = EpisodeID
go

create proc MarkShow @WatcherID as int, @ShowID as int, @Cond as int = 0
as
    if exists(select * from WatcherShow where @WatcherID = WatcherID and @ShowID = ShowID)
        begin
            if @Cond = 0
                delete from WatcherShow where @ShowID = ShowID and @WatcherID = WatcherID
        end
    else
        insert into WatcherShow(WatcherID, ShowID) values (@WatcherID, @ShowID)
go

create proc MarkEpisode @WatcherID as int, @EpisodeID as int
as
    declare @ShowID as int;
    exec @ShowID = GetShowID @EpisodeID
    if exists(select * from WatcherEpisode where @WatcherID = WatcherID and @EpisodeID = EpisodeID)
        delete from WatcherEpisode  where @WatcherID = WatcherID and @EpisodeID = EpisodeID
    else
        if exists(select * from WatcherShow where @WatcherID = WatcherID and ShowID = @ShowID)
            exec MarkShow @WatcherID, @ShowID, 1
        insert into WatcherEpisode(WatcherID, EpisodeID) values (@WatcherID, @EpisodeID)
go

create proc GetStat
as
    select * from Stat
go

create proc GetShowID @EpisodeID as int
as
    select ShowID from ShowEpisode where @EpisodeID = EpisodeID
go

create proc DelShow @ShowID as int
as
    delete from Show where @ShowID = ShowID
    delete from ShowEpisode where @ShowID = ShowID
go

create proc DelEpisode @EpisodeID as int
as
    delete from Episode where @EpisodeID = EpisodeId
go

create proc CreateBackup @Path as varchar(200)
as
    backup database SerialTracker to disk = @Path
go