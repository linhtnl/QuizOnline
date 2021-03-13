USE [master]
GO
/****** Object:  Database [QuizOnline]    Script Date: 3/8/2021 10:33:57 PM ******/
CREATE DATABASE [QuizOnline]
 CONTAINMENT = NONE
 
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuizOnline].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuizOnline] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuizOnline] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuizOnline] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuizOnline] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuizOnline] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuizOnline] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuizOnline] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuizOnline] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuizOnline] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuizOnline] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuizOnline] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuizOnline] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuizOnline] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuizOnline] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuizOnline] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuizOnline] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuizOnline] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuizOnline] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuizOnline] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuizOnline] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuizOnline] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuizOnline] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuizOnline] SET RECOVERY FULL 
GO
ALTER DATABASE [QuizOnline] SET  MULTI_USER 
GO
ALTER DATABASE [QuizOnline] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuizOnline] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuizOnline] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuizOnline] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuizOnline] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuizOnline', N'ON'
GO
ALTER DATABASE [QuizOnline] SET QUERY_STORE = OFF
GO
USE [QuizOnline]
GO
/****** Object:  User [linhtnl]    Script Date: 3/8/2021 10:33:57 PM ******/

GO
/****** Object:  UserDefinedFunction [dbo].[east_or_west]    Script Date: 3/8/2021 10:33:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[east_or_west] (
	@long DECIMAL(9,6)
)
RETURNS CHAR(4) AS
BEGIN
	DECLARE @return_value CHAR(4);
	SET @return_value = 'same';
    IF (@long > 0.00) SET @return_value = 'east';
    IF (@long < 0.00) SET @return_value = 'west';
 
    RETURN @return_value
END;
GO
/****** Object:  UserDefinedFunction [dbo].[numberOfCorrect]    Script Date: 3/8/2021 10:33:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[numberOfCorrect](@id varchar(20))
returns int as
begin
	declare @total int;
	set @total=(select count(qz.questionID)
		from QuestionQuiz Qz, Question Q
		where quizEnrollID=@id and Qz.questionID = q.QuestionID);
	declare @count int
	set @count=0
	declare @answer_choose nvarchar(500)
	declare @correct_answer nvarchar(500)
	DECLARE cursorProduct CURSOR FOR  -- khai báo con trỏ cursorProduct
	select qz.answer_choose,q.correct_answer
		from QuestionQuiz Qz, Question Q
		where quizEnrollID=@id and Qz.questionID = q.QuestionID     -- dữ liệu trỏ tới
	OPEN cursorProduct                -- Mở con trỏ
	FETCH NEXT FROM cursorProduct     -- Đọc dòng đầu tiên
		  INTO @answer_choose, @correct_answer
	WHILE @@FETCH_STATUS = 0          --vòng lặp WHILE khi đọc Cursor thành công
	BEGIN
									  --In kết quả hoặc thực hiện bất kỳ truy vấn
									  --nào dựa trên kết quả đọc được		
		if @answer_choose =  @correct_answer 
			set @count+=1
		FETCH NEXT FROM cursorProduct -- Đọc dòng tiếp
			  INTO @answer_choose, @correct_answer
	END
	CLOSE cursorProduct              -- Đóng Cursor
	DEALLOCATE cursorProduct         -- Giải phóng tài nguyên
	return @count 
end;
GO
/****** Object:  Table [dbo].[Question]    Script Date: 3/8/2021 10:33:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[QuestionID] [varchar](20) NOT NULL,
	[questionContent] [nvarchar](500) NULL,
	[optionA] [nvarchar](500) NULL,
	[optionB] [nvarchar](500) NULL,
	[optionC] [nvarchar](500) NULL,
	[optionD] [nvarchar](500) NULL,
	[correct_answer] [nvarchar](500) NOT NULL,
	[status] [bit] NULL,
	[createDate] [datetime] NULL,
	[subID] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[QuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestionQuiz]    Script Date: 3/8/2021 10:33:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionQuiz](
	[questionID] [varchar](20) NOT NULL,
	[quizEnrollID] [varchar](20) NOT NULL,
	[answer_choose] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[questionID] ASC,
	[quizEnrollID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quiz]    Script Date: 3/8/2021 10:33:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quiz](
	[QuizID] [varchar](20) NOT NULL,
	[SubID] [varchar](20) NULL,
	[numOfQuestions] [int] NULL,
	[timeOpen] [datetime] NULL,
	[timeClose] [datetime] NULL,
	[userID] [varchar](50) NULL,
	[timeLimit] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[QuizID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuizEnroll]    Script Date: 3/8/2021 10:33:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuizEnroll](
	[QuizId] [varchar](20) NULL,
	[StudentID] [varchar](50) NULL,
	[ID] [varchar](20) NOT NULL,
	[timeEnroll] [datetime] NULL,
	[score] [float] NULL,
	[numOfCorrectQuestions] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblSubject]    Script Date: 3/8/2021 10:33:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSubject](
	[SubID] [varchar](20) NOT NULL,
	[subName] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[SubID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 3/8/2021 10:33:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[UserID] [varchar](50) NOT NULL,
	[password] [varchar](100) NULL,
	[username] [varchar](50) NULL,
	[status] [bit] NULL,
	[role] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG1', N'______? -There are one thousand.', N'How many grams are there in a kilogram?', N'How many are there grams in a kilogram?', N'How many grams are they in a kilogram?', N'How many grams are there of a kilogram?', N'How many grams are there in a kilogram?', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG10', N'How long ______ in Spain on vacation last summer?', N'were they', N'you are been', N'are been', N'was', N'were they', 0, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG11', N'Next weekend, we hope to ______ for a few days.', N'get away', N'get on', N'get through', N'get of', N'get away', 0, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG12', N'They''re tired ______ they worked for ten hours.', N'because', N'however', N'or', N'when', N'because', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG13', N'______ they the first customers of the day?', N'Were', N'Who', N'Was', N'Who were', N'Were', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG14', N'I must go home because my husband ______ for me.', N'is waiting', N'are waiting', N'am waiting', N'waits', N'is waiting', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG15', N'You can''t have your cake ______ eat it too.', N'and', N'although', N'while', N'or', N'and', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG16', N'Who is your daughter''s brother? -______', N'He is my son.', N'He is married to her.', N'He is her husband''s brother.', N'She is his sister.', N'He is my son.', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG1614996860779', N'asd', N'123', N'212', N'321', N'113', N'123', 0, CAST(N'2021-03-06T00:00:00.000' AS DateTime), N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG1615014165210', N'test1', N'5', N'2', N'3', N'4', N'4', 0, CAST(N'2021-03-06T00:00:00.000' AS DateTime), N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG17', N'Had they ______ arrived when you got there?', N'already', N'after', N'before', N'still', N'already', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG18', N'Elizabeth''s been working there ______ only eight months.', N'for', N'in', N'by', N'since', N'for', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG19', N'Who is she talking to on the phone? -______', N'She''s talking to her sister.', N'She talks to Lorenzo Rodriguez', N'Him she is talking to.', N'She''s not talking to me sister.', N'She''s talking to her sister.', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG2', N'Is there a doctor in the house? -______', N'Yes, there is.', N'Yes, is there.', N'No, isn''t.', N'No, they isn''t.', N'Yes, there is.', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG20', N'Thomas can''t get out of bed because he ______ his leg.', N'broke', N'broken', N'break', N'breaks', N'broke', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG21', N'Are these cats bigger than those dogs? -______', N'Yes, they are bigger!', N'Yes, are.', N'No, those dogs are the bigger.', N'No, dogs are the biggest.', N'Yes, they are bigger!', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG22', N'______? -She was at school.', N'Where was Suzanne during the earthquake?', N'Was Suzanne yesterday at home?', N'Suzanne where was yesterday?', N'Where was the sister of Veronica last Friday?', N'Where was Suzanne during the earthquake?', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG222', N'I ___ you', N'miss', N'love', N'like', N'want', N'miss', 0, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG23', N'we are so late because our car ______ down on the highway.', N'broke', N'breaks', N'broken', N'break', N'broke', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG24', N'I have never ______ such a boring book!', N'read', N'saw', N'readed', N'red', N'read', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG25', N'Who is your mother''s sister''s daughter? -______', N'She is my cousin.', N'She is my wife.', N'She is my mother''s nephew.', N'Is my mother''s niece.', N'She is my cousin.', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG256', N'... are you from?', N'How', N'Where', N'Which', N'When', N'Where', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG26', N'She ______ blue velvet to the party last night.', N'wore', N'worn', N'weared', N'wear', N'wore', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG27', N'The little dog ______ my leg.', N'bit', N'bited', N'bite', N'bitten', N'bit', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG28', N'You two are always fighting. Why can''t you ______?', N'get along', N'get over', N'get off', N'get down', N'get along', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG29', N'We must ______ the train at the next stop.', N'get off', N'get over', N'get on', N'get down', N'get off', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG3', N'What hours ______? -From nine to five, Monday through Friday.', N'do you normally work', N'work you normally', N'are you normally working', N'you work normally', N'do you normally work', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG30', N'Which river is bigger: the Amazon or the Nile? -______', N'The Amazon''s bigger than the Nile.', N'The Amazon is the bigger.', N'Bigger the Amazon is.', N'The Amazon is bigger the Nile.', N'The Amazon''s bigger than the Nile.', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG31', N'The milk is ______ the refrigerator.', N'in', N'from', N'of', N'at', N'in', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG32', N'______ is your house? -It''s the small grey one.', N'Which', N'When', N'What', N'Where', N'Which', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG33', N'How tall is that building? -______', N'It''s about 95 stories.', N'Is 378 meters tall.', N'That building is much tall than this one.', N'It is tall 300 meters.', N'It''s about 95 stories.', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG34', N'The train goes ______ many tunnels on the way to Rome.', N'through', N'in', N'past', N'over', N'through', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG35', N'Whose keys are these? -______ are mine.', N'They', N'These', N'It', N'Keys', N'They', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG36', N'We''ve just come ______ the beach and we are thirsty.', N'from', N'for', N'back', N'of', N'from', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG37', N'I can speak English, but I ______ French.', N'can''t speak', N'speak', N'speak not', N'no speak', N'can''t speak', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG38', N'What is she doing? -______', N'She''s waiting for you.', N'She cooking dinner.', N'She are watching TV.', N'She''d talking to Mary on the phone.', N'She''s waiting for you.', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG39', N'Where should Suzanne ______?', N'sit', N'find', N'put', N'repair', N'sit', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG4', N'My hair is longer than ______.', N'hers', N'your', N'your''s', N'she''s', N'hers', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG40', N'Never look directly ______ the sun. It is bad for your eyes.', N'at', N'to', N'for', N'through', N'at', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG41', N'She ______ dinner with Junko when you called last night.', N'was having', N'am having', N'have', N'had had', N'was having', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG42', N'______ tired from working so much?', N'Are you', N'She''s', N'Is', N'You are', N'Are you', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG43', N'Right now, my mother ______ dinner in the kitchen.', N'cooking', N'cooks', N'does cook', N'is cooking', N'is cooking', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG44', N'I''m surprised because rain was not ______ in the weather report.', N'predicted', N'prediction', N'predictable', N'predictably', N'predicted', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG45', N'I told you ______ you didn''t listen.', N'but', N'because', N'for', N'then', N'but', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG46', N'English grammar ______ than German grammar.', N'is worse.', N'is worst.', N'worst.', N'is badder.', N'is worse.', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG47', N'I''m busy, so you will just have to ______.', N'wait', N'avoid', N'like', N'attempt', N'wait', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG48', N'______ are you mad? -Because you are late!', N'Why', N'When', N'Where', N'What', N'Why', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG49', N'These pants ______ mine; that jacket is yours.', N'are', N'is', N'are wearing', N'is wearing', N'are', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG499', N'What What', N'A', N'B', N'Is', N'D', N'A', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG5', N'He was invited ______ he did not come.', N'but', N'if', N'when', N'or', N'but', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG50', N'We get good grades ______ we study.', N'because', N'but', N'except', N'or', N'because', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG500', N'What What', N'A', N'B', N'C', N'D', N'A', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG51', N'I''m sleepy because I ______ at six o''clock this morning.', N'got up', N'got by', N'got down', N'got along', N'got up', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG52', N'Edward has always ______ things very quickly and efficiently.', N'done', N'does', N'doed', N'did', N'done', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG53', N'I''ve ______ a terrible headache.', N'got', N'have', N'gets', N'gottin', N'got', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG54', N'What ______? -This is my new ring.', N'is that', N'is', N'are these', N'those', N'is that', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG55', N'I will speak ______ Suzanne when I see her.', N'to', N'in', N'around', N'at', N'to', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG56', N'______ my wife sleeps, I watch TV late at night.', N'While', N'Through', N'During', N'From', N'While', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG57', N'He ______ all of them.', N'wanted', N'went', N'listened', N'spoke', N'wanted', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG58', N'She cannot talk ______ walk at the same time.', N'and', N'because', N'while', N'but', N'and', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG59', N'What ______ your favorite foods as a child?', N'were', N'will', N'would', N'was', N'were', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG6', N'Where are my car keys? -They are ______ your hand!', N'in', N'on', N'to', N'of', N'in', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG60', N'Monica is tired. She doesn''t want to go ______ school.', N'to', N'at', N'for', N'in', N'to', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG61', N'_____ is your mother''s sister feeling today?', N'How', N'What', N'Why', N'Which', N'How', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG62', N'_____ is your mother''s sister''s son feeling today?', N'Which', N'What', N'Why', N'How', N'How', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG7', N'Whiskey gets better and better as it ______.', N'ages', N'age', N'ageing', N'aged', N'ages', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG8', N'Pamela ______ a big lunch and now she''s sleepy.', N'ate', N'eats', N'eaten', N'eating', N'ate', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'ENG9', N'I have never ______ such a boring book!', N'read', N'saw', N'readed', N'red', N'read', 1, NULL, N'ENG')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ3111', N'Swing components that don''t rely on native GUI are referred to as ___________.', N'lightweight components', N'heavyweight components', N'GUI components', N'non-GUI components', N'lightweight components', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31110', N'What is best to describe the relationship between Component and Color?', N'Association', N'Aggregation', N'Composition', N'Inheritance', N'Association', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31111', N'Which of the following classes are in the java.awt package?', N'Color', N'None of the others', N'JComponent', N'JFrame', N'Color', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31112', N'Which of the following statements is for placing the frame''s upper left corner to (200, 100)?', N'frame.setLocation(200, 100)', N'frame.setLocation(100, 100)', N'frame.setLocation(100, 200)', N'frame.setLocation(200, 200)', N'frame.setLocation(200, 100)', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ311120', N'What is best to describe the relationship between JComponent and JButton?', N'Association', N'Aggregation', N'Composition', N'Inheritance', N'Inheritance', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31113', N'What layout manager should you use so that every component occupies the same size in the container?', N'a GridLayout', N'a FlowLayout', N'a BorderLayout', N'any layout', N'a GridLayout', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31114', N'__________ should be used to position a Button so that the size of the Button is NOT affected by the Frame size.', N'a FlowLayout', N'a GridLayout', N'the center area of a BorderLayout', N'the East or West area of a BorderLayout', N'a FlowLayout', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ3111615014198536', N'______? -There are one thousand.', N'How many grams are there in a kilogram?', N'How many are there grams in a kilogram?', N'How many grams are they in a kilogram?', N'How many grams are there of a kilogram?', N'How many grams are there in a kilogram?', 1, CAST(N'2021-03-06T00:00:00.000' AS DateTime), N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ3111615014208883', N'test1', N'1', N'2', N'3', N'4', N'2', 1, CAST(N'2021-03-06T00:00:00.000' AS DateTime), N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31117', N'The default layout out of a contentPane in a JFrame is __________.', N'BorderLayout', N'FlowLayout', N'GridLayout', N'None', N'BorderLayout', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31118', N'The default layout out of a JPanel is __________.', N'FlowLayout', N'GridLayout', N'BorderLayout', N'None', N'FlowLayout', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31119', N'To create a JPanel of the BorderLayout, use ______________.', N'JPanel p = new JPanel(new BorderLayout());', N'JPanel p = new JPanel();', N'JPanel p = new JPanel(BorderLayout());', N'JPanel p = new JPanel().setLayout(new BorderLayout());', N'JPanel p = new JPanel(new BorderLayout());', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ3112', N'__________ are referred to as heavyweight components.', N'AWT components', N'Swing components', N'GUI components', N'Non-GUI components', N'AWT components', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31120', N'To add a component c to a JPanel p, use _________.', N'p.add(c)', N'p.getContentPane(c)', N'p.insert(c)', N'p.append(c)', N'p.add(c)', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31121', N'Which color is the darkest?', N'new Color(0, 0, 0)', N'new Color(10, 0, 0)', N'new Color(20, 0, 0)', N'new Color(30, 0, 0)', N'new Color(0, 0, 0)', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31122', N'The method __________ sets the font (Helvetica, 20-point bold).', N'setFont(new Font("Helvetica", Font.BOLD, 20))', N'setFont(new Font("Helvetica", Font.bold, 20))', N'setFont(new Font("helvetica", BOLD, 20))', N'setFont(Font("Helvetica", Font.BOLD, 20))', N'setFont(new Font("Helvetica", Font.BOLD, 20))', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31123', N'The setBackground method can be used to set a back ground color for _____.', N'All of the others', N'Component', N'Container', N'JComponent', N'All of the others', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31124', N'The setBorder method can be used to set a border for _____.', N'JComponent', N'Component', N'Container', N'All of the others', N'JComponent', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31125', N'You can use methods ___________ on any instance of java.awt.Component.', N'setBackground', N'setBorder', N'setLayout', N'All of the others', N'setBackground', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31126', N'To create an image icon for a file in c:\book\image\icon, use ____________.', N'new ImageIcon("c:\\book\\image\\icon");', N'new ImageIcon("c:\book\image\icon");', N'new ImageIcon(''c:\book\image\icon'');', N'new ImageIcon(''c:\\book\\image\\icon'');', N'new ImageIcon("c:\\book\\image\\icon");', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31127', N'Which of the following is true?', N'All of the others.', N'You can create a JButton by specifying an icon.', N'You can create a JButton by a text.', N'E. You can create a JButton using its default constructor.', N'All of the others.', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31128', N'The method __________ gets the text (or caption) of the button b.', N'b.getText()', N'b.text()', N'b.findText()', N'b.retrieveText().', N'b.getText()', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31129', N'The method __________ creates a IconImage for file c:\image\us.gif.', N'new ImageIcon("c:\\image\\us.gif");', N'new ImageIcon("c:\image\us.gif");', N'new Icon("c:\image\us.gif");', N'new Icon("c:\\image\\us.gif");', N'new ImageIcon("c:\\image\\us.gif");', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ3113', N'Which of the following statements are true?', N'A container such as JFrame is also a component.', N'Every instance of Component can be added to a container.', N'All Swing GUI components are lightweight.', N'Swing GUI component classes are named with a prefix S.', N'A container such as JFrame is also a component.', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31130', N'Which of the following are valid methods on the button jbt?', N'All of the others', N'jbt.setMnemonic(''A'');', N'jbt.setIconTextGap(50);', N'None of the others', N'All of the others', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31131', N'_________ checks whether the JCheckBox check is selected.', N'check.isSelected()', N'check.getSelected()', N'check.selected()', N'check.select()', N'check.isSelected()', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31132', N'Which of the following statements are true?', N'All of the others.', N'JCheckBox inherits from javax.swing.AbstractButton.', N'All the methods in JCheckBox are also in JButton.', N'You can use an icon on JCheckBox.', N'All of the others.', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31133', N'Which of the following statements are true?', N'To check whether a radio button jrb is selected, use jrb.isSelected().', N'All of the others.', N'ButtonGroup can be added to a container.', N'When a radio button is created, the radio button is selected by default.', N'To check whether a radio button jrb is selected, use jrb.isSelected().', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31134', N'The method __________ assigns the name Result to the Text of variable jlbl.', N'jlbl.setText("Result")', N'jlbl.newText("Result")', N'jlbl.text("Result")', N'jlbl.findText()', N'jlbl.setText("Result")', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31135', N'___________ can be used to enter or display a string.', N'A text field', N'A label', N'A button', N'A check box', N'A text field', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31136', N'Clicking a JButton object generates __________ events.', N'ActionEvent', N'ItemEvent', N'ComponentEvent', N'ContainerEvent', N'ActionEvent', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31137', N'The method __________ appends a string s into the text area jta.', N'jta.append(s)', N'jta.appendString(s)', N'jta.appendText(s)', N'jta.insertText(s)', N'jta.append(s)', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31138', N'Which of the following statements are true?', N'You can specify the number of columns in a text area.', N'You can specify a horizontal text alignment in a text area.', N'You cannot disable editing on a text area.', N'All of the others.', N'You can specify the number of columns in a text area.', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31139', N'To wrap a line in a text area jta, invoke ____________.', N'jta.setLineWrap(true)', N'jta.setLineWrap(false)', N'jta.WrapLine()', N'jta.wrapText()', N'jta.setLineWrap(true)', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ3114', N'Which of the following classes is a heavyweight component?', N'JFrame', N'JButton', N'JTextField', N'JPanel', N'JFrame', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31140', N'The method __________ adds a text area jta to a scrollpane jScrollPane.', N'jScrollPane.add(jta)', N'jScrollPane.insert(jta)', N'jScrollPane.addItem(jta)', N'None of the others', N'jScrollPane.add(jta)', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31141', N'How many items can be selected from a JComboBox object at a time?', N'1', N'0', N'2', N'Unlimited', N'1', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31142', N'_______________ returns the selected item on a JComboBox jcbo.', N'jcbo.getSelectedItem()', N'jcbo.getSelectedIndex()', N'jcbo.getSelectedIndices()', N'jcbo.getSelectedItems()', N'jcbo.getSelectedItem()', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31143', N'The method __________ adds an item s into a JComboBox jcbo.', N'jcbo.addItem(s)', N'jcbo.add(s)', N'jcbo.addChoice(s)', N'jcbo.addObject(s)', N'jcbo.addItem(s)', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31144', N'____________ is a component that enables the user to choose a single value or multiple values.', N'A list', N'A text field', N'A combo box', N'A label', N'A list', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31145', N'______________ allows selections of multiple contiguous items without restrictions.', N'Multiple-interval selection', N'Multiple selection', N'ALl of the others', N'Single selection', N'Multiple-interval selection', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31146', N'Clicking a JList object generates __________ events.', N'ActionEvent and ItemEvent', N'ItemEvent and ComponentEvent', N'ComponentEvent and ContainerEvent', N'ActionEvent and ContainerEvent', N'ActionEvent and ItemEvent', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31147', N'The following is a property of a JScrollBar.', N'All of the others', N'maximum', N'orientation', N'visibleAmount', N'All of the others', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31148', N'The coordinate of the upper-left corner of a frame is __________.', N'(0, 0)', N'(25, 25)', N'(100, 100)', N'(10, 10)', N'(0, 0)', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31149', N'The header for the paintComponent method is ________________.', N'protected void paintComponent(Graphics g)', N'private void paintComponent(Graphics g)', N'public void paintComponent(Graphics g)', N'protected void paintComponent()', N'protected void paintComponent(Graphics g)', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ311495', N'What is the mission of Action Listener?', N'Nothing', N'Listen', N'Waiting', N'Execute', N'Listen', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ3115', N'Which component cannot be added to a container?', N'JFrame', N'JPanel', N'JButton', N'JComponent', N'JFrame', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31150', N'You should override the __________ method to draw things on a Swing component.', N'paintComponent()', N'repaint()', N'update()', N'init()', N'paintComponent()', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31151', N'To repaint graphics, invoke __________ on a Swing component.', N'repaint()', N'update()', N'paintComponent()', N'init()', N'repaint()', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31152', N'The __________ method is used to create an Image object from an ImageIcon object imageIcon.', N'imageIcon.getImage()', N'imageIcon.image()', N'imageIcon.setImage()', N'imageIcon.returnImage()', N'imageIcon.getImage()', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31153', N'When creating a server on a port that is already in use, __________.', N'java.net.BindException occurs.', N'the server is created with no problems.', N'the server is blocked until the port is available.', N'the server encounters a fatal error and must be terminated.', N'java.net.BindException occurs.', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31154', N'When creating a client on a server port that is already in use, __________.', N'the client can connect to the server regardless of whether the port is in use.', N'java.net.BindException occurs.', N'the client is blocked until the port is available.', N'the client encounters a fatal error and must be terminated.', N'the client can connect to the server regardless of whether the port is in use.', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31155', N'The server listens for a connection request from a client using the following statement:', N'Socket s = serverSocket.accept();', N'Socket s = new Socket(ServerName, port);', N'Socket s = serverSocket.getSocket();', N'Socket s = new Socket(ServerName);', N'Socket s = serverSocket.accept();', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31156', N'When a client requests connection to a server that has not yet started, __________.', N'java.net.ConnectionException occurs.', N'java.net.BindException occurs.', N'the client is blocked until the server is started.', N'the client encounters a fatal error and must be terminated.', N'java.net.ConnectionException occurs.', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31157', N'To create an InputStream on a socket s, you use __________.', N'InputStream in = s.getInputStream();', N'InputStream in = new InputStream(s);', N'InputStream in = s.obtainInputStream();', N'InputStream in = s.getStream();', N'InputStream in = s.getInputStream();', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31158', N'You can invoke ______________ on a Socket s, to obtain an InetAddress object.', N's.InetAddress();', N's.getInetAddress();', N's.obtainInetAddress();', N's.retrieveInetAddress();', N's.InetAddress();', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31159', N'The ____________ method in the InetAddress class returns the IP address.', N'getHostAddress()', N'getIP()', N'getIPAddress()', N'getAddress()', N'getHostAddress()', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ3116', N'Which of the following is a subclass of java.awt.Component?', N'Container classes', N'All of the others', N'Helper classes such as Color and Font', N'None of the others', N'Container classes', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31160', N'A ServerSocket can connect to ________ clients.', N'an unlimited number of', N'one', N'two', N'ten', N'an unlimited number of', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31161', N'The _____ layout places the components in rows and columns.', N'GridLayout', N'CardLayout', N'FlowLayout', N'Borderlayout', N'GridLayout', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31162', N'The default alignment of buttons in Flow Layout is ________.', N'CENTER', N'RIGHT', N'LEFT', N'The alignment must be defined when using the FlowLayout Manager.', N'CENTER', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31163', N'The default horizontal and vertical gap in BorderLayout is ________.', N'0 pixel', N'1 pixel', N'5 pixels', N'10 pixels', N'0 pixel', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31164', N'Which method is used to load a JDBC driver?', N'Class.forName()', N'class.load()', N'Class.load()', N'class.forName()', N'Class.forName()', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31165', N'Which method is used to commit the update of a ResultSet?', N'updateRow()', N'CommitRow()', N'commit()', N'update()', N'updateRow()', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31166', N'Which statements are INCORRECT about I18N?', N'The translation of text is the least time-consuming part of the localization process', N'Textual elements are stored outside the source code and retrieved dynamically', N'Localization is the process of adapting software for a specific region', N'None of the others', N'The translation of text is the least time-consuming part of the localization process', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31167', N'________ driver can interpret JDBC calls to the database-specific native call interface.', N'Type-2', N'Type-1', N'Type-4', N'Type-3', N'Type-2', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31168', N'________ driver can use a bridging technology that provides JDBC access via ODBC drivers.', N'Type-1', N'Type-4', N'Type-2', N'Type-3', N'Type-1', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31169', N'The _______ method wakes up all threads that are waiting for a monitor.', N'notifyAll()', N'notify()', N'join()', N'wait()', N'notifyAll()', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ3117', N'What is best to describe the relationship between a container and a SWing GUI object in the container?', N'Composition', N'Association', N'Aggregation', N'Inheritance', N'Composition', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31170', N'What is the name of the Swing class that is used for frames?', N'JFrame', N'Window', N'Frame', N'SwingFrame', N'JFrame', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31171', N'What method sets the size of the displayed JFrame?', N'setSize( int width, int height)', N'setSize( int height, int width)', N'setVisible( int width, int height)', N'setVisible( int height, int width)', N'setSize( int width, int height)', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31172', N'The size of a frame on the screen is measured in:', N'pixels', N'inches', N'nits', N'dots', N'pixels', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ31173', N'What is the one component that nearly all GUI programs will have?', N'Frame', N'Mouse', N'Monitor', N'Button', N'Frame', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ3118', N'What is best to describe the relationship between a container and a layout manager?', N'Aggregation', N'Association', N'Composition', N'Inheritance', N'Aggregation', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[Question] ([QuestionID], [questionContent], [optionA], [optionB], [optionC], [optionD], [correct_answer], [status], [createDate], [subID]) VALUES (N'PRJ3119', N'What is best to describe the relationship between JComponent and JButton?', N'Inheritance', N'Association', N'Aggregation', N'Composition', N'Inheritance', 1, NULL, N'PRJ311')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG1', N'1615140079277', N'How many grams are they in a kilogram?')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG1', N'1615175036632', N'How many are there grams in a kilogram?')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG11', N'1615173981120', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG11', N'1615175036632', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG12', N'1615140079277', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG13', N'1615175036632', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG14', N'1615140079277', N'are waiting')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG14', N'1615173981120', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG14', N'1615175036632', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG17', N'1615140079277', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG17', N'1615175036632', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG19', N'1615173981120', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG2', N'1615173981120', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG20', N'1615140079277', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG22', N'1615140079277', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG222', N'1615173981120', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG24', N'1615173981120', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG24', N'1615175036632', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG25', N'1615140079277', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG25', N'1615175036632', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG256', N'1615140079277', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG27', N'1615173981120', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG27', N'1615175036632', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG29', N'1615173981120', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG3', N'1615175036632', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG30', N'1615173981120', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG33', N'1615140079277', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG33', N'1615175036632', N'That building is much tall than this one.')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG34', N'1615173981120', N'through')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG36', N'1615140079277', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG4', N'1615173981120', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG40', N'1615140079277', N'through')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG41', N'1615140079277', N'have')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG42', N'1615173981120', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG43', N'1615175036632', N'is cooking')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG44', N'1615175036632', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG46', N'1615140079277', N'is badder.')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG46', N'1615175036632', N'is badder.')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG47', N'1615140079277', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG49', N'1615173981120', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG499', N'1615140079277', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG499', N'1615175036632', N'Is')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG50', N'1615140079277', N'or')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG50', N'1615173981120', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG50', N'1615175036632', N'but')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG500', N'1615175036632', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG51', N'1615140079277', N'got down')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG51', N'1615175036632', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG53', N'1615173981120', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG54', N'1615173981120', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG55', N'1615173981120', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG56', N'1615173981120', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG56', N'1615175036632', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG57', N'1615175036632', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG61', N'1615173981120', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG62', N'1615140079277', N'What')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG62', N'1615173981120', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG7', N'1615140079277', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG8', N'1615140079277', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'ENG8', N'1615175036632', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'PRJ31111', N'1615128944238', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'PRJ311120', N'1615128944238', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'PRJ3111615014198536', N'1615128944238', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'PRJ3111615014208883', N'1615128944238', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'PRJ31119', N'1615128944238', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'PRJ31127', N'1615128944238', N'All of the others.')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'PRJ31132', N'1615128944238', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'PRJ31133', N'1615128944238', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'PRJ31135', N'1615128944238', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'PRJ31138', N'1615128944238', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'PRJ3114', N'1615128944238', N'JFrame')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'PRJ31141', N'1615128944238', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'PRJ31144', N'1615128944238', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'PRJ31146', N'1615128944238', N'ActionEvent and ItemEvent')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'PRJ31149', N'1615128944238', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'PRJ31157', N'1615128944238', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'PRJ31161', N'1615128944238', N'GridLayout')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'PRJ31166', N'1615128944238', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'PRJ31169', N'1615128944238', N'')
GO
INSERT [dbo].[QuestionQuiz] ([questionID], [quizEnrollID], [answer_choose]) VALUES (N'PRJ3118', N'1615128944238', N'')
GO
INSERT [dbo].[Quiz] ([QuizID], [SubID], [numOfQuestions], [timeOpen], [timeClose], [userID], [timeLimit]) VALUES (N'Q1', N'PRJ311', 10, CAST(N'2021-03-06T09:00:00.000' AS DateTime), CAST(N'2021-03-06T23:00:00.000' AS DateTime), N'lamlinh20001@gmail.com', 10)
GO
INSERT [dbo].[Quiz] ([QuizID], [SubID], [numOfQuestions], [timeOpen], [timeClose], [userID], [timeLimit]) VALUES (N'Q2', N'PRJ311', 20, CAST(N'2021-03-06T09:00:00.000' AS DateTime), CAST(N'2021-03-07T23:00:00.000' AS DateTime), N'lamlinh20001@gmail.com', 15)
GO
INSERT [dbo].[Quiz] ([QuizID], [SubID], [numOfQuestions], [timeOpen], [timeClose], [userID], [timeLimit]) VALUES (N'Q3', N'ENG', 20, CAST(N'2021-03-06T09:00:00.000' AS DateTime), CAST(N'2021-03-07T23:00:00.000' AS DateTime), N'lamlinh20001@gmail.com', 20)
GO
INSERT [dbo].[Quiz] ([QuizID], [SubID], [numOfQuestions], [timeOpen], [timeClose], [userID], [timeLimit]) VALUES (N'Q4', N'ENG', 20, CAST(N'2021-03-06T09:00:00.000' AS DateTime), CAST(N'2021-03-17T23:00:00.000' AS DateTime), N'lamlinh20001@gmail.com', 10)
GO
INSERT [dbo].[Quiz] ([QuizID], [SubID], [numOfQuestions], [timeOpen], [timeClose], [userID], [timeLimit]) VALUES (N'Q5', N'ENG', 20, CAST(N'2021-03-06T09:00:00.000' AS DateTime), CAST(N'2021-03-10T23:00:00.000' AS DateTime), N'lamlinh20001@gmail.com', 10)
GO
INSERT [dbo].[QuizEnroll] ([QuizId], [StudentID], [ID], [timeEnroll], [score], [numOfCorrectQuestions]) VALUES (N'Q2', N'lamlinh20002@gmail.com', N'1615128944238', CAST(N'2021-03-07T21:55:00.000' AS DateTime), 2, 4)
GO
INSERT [dbo].[QuizEnroll] ([QuizId], [StudentID], [ID], [timeEnroll], [score], [numOfCorrectQuestions]) VALUES (N'Q5', N'lamlinh20002@gmail.com', N'1615140079277', CAST(N'2021-03-08T01:01:00.000' AS DateTime), 0, 0)
GO
INSERT [dbo].[QuizEnroll] ([QuizId], [StudentID], [ID], [timeEnroll], [score], [numOfCorrectQuestions]) VALUES (N'Q4', N'lamlinh20002@gmail.com', N'1615173981120', CAST(N'2021-03-08T10:26:00.000' AS DateTime), 0, 1)
GO
INSERT [dbo].[QuizEnroll] ([QuizId], [StudentID], [ID], [timeEnroll], [score], [numOfCorrectQuestions]) VALUES (N'Q4', N'lamlinh@gmail.com', N'1615175036632', CAST(N'2021-03-08T10:43:00.000' AS DateTime), 0, 1)
GO
INSERT [dbo].[tblSubject] ([SubID], [subName]) VALUES (N'ENG', N'English')
GO
INSERT [dbo].[tblSubject] ([SubID], [subName]) VALUES (N'PRJ311', N'JavaWeb')
GO
INSERT [dbo].[tblUser] ([UserID], [password], [username], [status], [role]) VALUES (N'lamlinh@gmail.com', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'Lam', 1, N'Student')
GO
INSERT [dbo].[tblUser] ([UserID], [password], [username], [status], [role]) VALUES (N'lamlinh20001@gmail.com', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'Linh To', 1, N'teacher')
GO
INSERT [dbo].[tblUser] ([UserID], [password], [username], [status], [role]) VALUES (N'lamlinh20002@gmail.com', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'Linh To', 1, N'Student')
GO
INSERT [dbo].[tblUser] ([UserID], [password], [username], [status], [role]) VALUES (N'linhtnl2000@gmail.com', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'Linh', 1, N'Student')
GO
ALTER TABLE [dbo].[Question] ADD  CONSTRAINT [DF_Question_status]  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD FOREIGN KEY([subID])
REFERENCES [dbo].[tblSubject] ([SubID])
GO
ALTER TABLE [dbo].[QuestionQuiz]  WITH CHECK ADD FOREIGN KEY([questionID])
REFERENCES [dbo].[Question] ([QuestionID])
GO
ALTER TABLE [dbo].[QuestionQuiz]  WITH CHECK ADD FOREIGN KEY([quizEnrollID])
REFERENCES [dbo].[QuizEnroll] ([ID])
GO
ALTER TABLE [dbo].[Quiz]  WITH CHECK ADD FOREIGN KEY([SubID])
REFERENCES [dbo].[tblSubject] ([SubID])
GO
ALTER TABLE [dbo].[Quiz]  WITH CHECK ADD FOREIGN KEY([userID])
REFERENCES [dbo].[tblUser] ([UserID])
GO
ALTER TABLE [dbo].[QuizEnroll]  WITH CHECK ADD  CONSTRAINT [FK_QuizEnroll_Quiz] FOREIGN KEY([QuizId])
REFERENCES [dbo].[Quiz] ([QuizID])
GO
ALTER TABLE [dbo].[QuizEnroll] CHECK CONSTRAINT [FK_QuizEnroll_Quiz]
GO
ALTER TABLE [dbo].[QuizEnroll]  WITH CHECK ADD  CONSTRAINT [FK_QuizEnroll_tblUser] FOREIGN KEY([StudentID])
REFERENCES [dbo].[tblUser] ([UserID])
GO
ALTER TABLE [dbo].[QuizEnroll] CHECK CONSTRAINT [FK_QuizEnroll_tblUser]
GO
USE [master]
GO
ALTER DATABASE [QuizOnline] SET  READ_WRITE 
GO
