alter table Episode add Score float

use SerialTracker
go

insert into Watcher(Login, Password) values ('login', 'password')
go
insert into Show(Name, ReleaseYear, Timing, Description) values
                ('9-1-1', 2018, 45,
                 'Сериал рассказывает о работе служб спасения Лос-Анджелеса: полицейских, ' +
                 'парамедиков, пожарных и диспетчеров.')
go
insert into Show(Name, ReleaseYear, Timing, Description) values
(
 'Игра престолов', 2011, 55, 'К концу подходит время благоденствия, и лето, длившееся почти десятилетие, угасает. Вокруг средоточия власти Семи королевств, Железного трона, зреет заговор, и в это непростое время король решает искать поддержки у друга юности Эддарда Старка. В мире, где все — от короля до наемника — рвутся к власти, плетут интриги и готовы вонзить нож в спину, есть место и благородству, состраданию и любви. Между тем, никто не замечает пробуждение тьмы из легенд далеко на Севере — и лишь Стена защищает живых к югу от нее.'
)
go
insert into Show(Name, ReleaseYear, Timing, Description) values
(
 'Друзья', 1994, 22,
 'Главные герои — шестеро друзей — Рейчел, Моника, Фиби, Джоуи, Чендлер и Росс. Три девушки и три парня, которые дружат, живут по соседству, вместе убивают время и противостоят жестокой реальности, делятся своими секретами и иногда очень сильно влюбляются.'
)
go
insert into Show(Name, ReleaseYear, Timing, Description) values
(
 'Во все тяжкие', 2008, 47,
 'Школьный учитель химии Уолтер Уайт узнаёт, что болен раком лёгких. Учитывая сложное финансовое состояние дел семьи, а также перспективы, Уолтер решает заняться изготовлением метамфетамина. Для этого он привлекает своего бывшего ученика Джесси Пинкмана, когда-то исключённого из школы при активном содействии Уайта. Пинкман сам занимался «варкой мета», но накануне, в ходе рейда УБН, он лишился подельника и лаборатории…'
)
go
insert into Show(Name, ReleaseYear, Timing, Description) values
(
 'Шерлок', 2010, 90,
 'События разворачиваются в наши дни. Он прошел Афганистан, остался инвалидом. По возвращении в родные края встречается с загадочным, но своеобразным гениальным человеком. Тот в поиске соседа по квартире. Лондон, 2010 год. Происходят необъяснимые убийства. Скотланд-Ярд без понятия, за что хвататься. Существует лишь один человек, который в силах разрешить проблемы и найти ответы на сложные вопросы.'
)
go
insert into Show(Name, ReleaseYear, Timing, Description) values
(
 'Доктор Хаус', 2004, 43,
 'Сериал рассказывает о команде врачей, которые должны правильно поставить диагноз пациенту и спасти его. Возглавляет команду доктор Грегори Хаус, который ходит с тростью после того, как его мышечный инфаркт в правой ноге слишком поздно правильно диагностировали. Как врач Хаус просто гений, но сам не отличается проникновенностью в общении с больными и с удовольствием избегает их, если только есть возможность. Он сам всё время проводит в борьбе с собственной болью, а трость в его руке только подчеркивает его жесткую, ядовитую манеру общения. Порой его поведение можно назвать почти бесчеловечным, и при этом он прекрасный врач, обладающий нетипичным умом и безупречным инстинктом, что снискало ему глубокое уважение. Будучи инфекционистом, он ещё и замечательный диагност, который любит разгадывать медицинские загадки, чтобы спасти кому-то жизнь. Если бы все было по его воле, то Хаус лечил бы больных не выходя из своего кабинета.'
)
go

insert into WatcherShow(WatcherID, ShowID) values (1, 1)
go
insert into WatcherShow(WatcherID, ShowID) values (1, 2)
go

-- @ShowID as int, @Season as int, @Series as int, @Name as varchar(50) = null, @Description as text = null
exec NewEpisode 1, 1, 1, 'Пилот'
go
exec NewEpisode 1, 1, 2, 'Отпусти'
go
exec NewEpisode 1, 1, 3, 'Ближайшие родственники'
go
exec NewEpisode 1, 1, 4, 'Самый худший день'
go
exec NewEpisode 1, 1, 5, 'Источник возгорания'
go
exec NewEpisode 2, 1, 1, 'Зима близко'
go
exec NewEpisode 2, 1, 2, 'Королевский Тракт'
go
exec NewEpisode 2, 1, 3, 'Лорд Сноу'
go

select * from ShowEpisodeView