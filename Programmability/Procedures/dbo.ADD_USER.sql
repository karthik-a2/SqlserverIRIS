SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[ADD_USER]
( @p_username varchar(50),
  @p_email varchar(50),
  @p_roleid numeric
 )
as 
BEGIN

declare @v_count numeric;
declare @v_userid numeric;
declare @v_emailcount numeric;
   BEGIN TRY

	IF @p_username is null or @p_email is null or @p_roleid is null
	BEGIN
	select 'Username Email cannot be Blank' msg
	RETURN
	END

	IF @p_email NOT LIKE '%_@__%.__%' 
	BEGIN
	select 'Invalid EMAIL'
	RETURN
	END

	select @v_count = count(1) from USER_ROLE_MSTR
	where user_name = @p_username;

	select @v_emailcount = count(1) from USER_ROLE_MSTR
	where EMAIL_ID = @p_email;

	IF @v_count >0 or @v_emailcount >0
	BEGIN
	select 'UserName/Email Already Present' msg
	return;
	END
	ELSE
	BEGIN
	select @v_userid = isnull(max(userid),0)+1 from USER_ROLE_MSTR;

	insert into USER_ROLE_MSTR
	values( @v_userid, @p_roleid, upper(@p_username), @p_email, getdate(), 'ADMIN');

	select @v_count = max(uid) +1 from IRIS_LOGIN;

	-- user added to login table
	insert into iris_login
	values( @v_count, @v_userid, @p_email, null, getdate(), 'ADMIN', null, null);

	select 'User Added Successfully' msg
	RETURN;
	END
	
	END TRY  

	BEGIN CATCH
	SELECT ERROR_NUMBER() as ErrorNumber,
           Error_Message() as ErrorMessage 

	select 'Something Went wrong!!! Please contact System Administrator' as msg
	END CATCH

END


-- exec add_user 'Sachin8', 'Sachin8@gmail.com', 1

--select * from iris_login;
GO