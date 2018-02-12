#!usr/bin/perl
use LWP::UserAgent;
##########################
system('cls');
print q(
+=====================+
[ 0xBotTwitter {Beta} ]
|---------------------|
[    Version: 2.0     ]
|---------------------|
[  CoDeD By 1337r00t  ]
+---------------------+
[  Twitter: _1337r00t ]
[ Instagram: _1337r00t]
+=====================+
Choo0o0o0o0o0oooose Dude :{Enter Any Number}:-

1 - Retweets
2 - Likes
3 - Follows
4 - Both {Retweets+Likes+Follows}
> );
$do = <STDIN>;
chomp($do);
if($do == 1){
	print "CompoList [Ex:admin:12345](list.txt)\n -----\n Input CompoList => ";
	$list = <STDIN>;
	chomp($list);
	print "\n------\nEnter Tweet URL => ";
	$url_tweet = <STDIN>;
	chomp($url_tweet);
	if($url_t = $url_tweet=~/\/status\/(.*)/){
		$my_tweet = $1;
	}
	print "URL Tweet: $url_tweet\nID Tweet: $my_tweet\t Let's Goo :)\n\n";
	open (COMPOFILE, "<$list") || die "[-] Can't Found ($list) !";
	@COMPOS = <COMPOFILE>;
	close COMPOFILE;
	foreach $compolist (@COMPOS ) {
	chomp $compolist;
		$check = auth_token($compolist);
		if($check=~/exit/){
			print "Failed_Login -> ($compolist)\n";
		}else{
			$my_auth_token = $check;
			print retweet($my_auth_token,$my_tweet);
		}
	}
	print "\n./Done";
	sleep(20);
	exit();
}
if($do == 2){
	print "CompoList [Ex:admin:12345](list.txt)\n -----\n Input CompoList => ";
	$list2 = <STDIN>;
	chomp($list2);
	print "\n------\nEnter Tweet URL => ";
	$url_tweet2 = <STDIN>;
	chomp($url_tweet2);
	if($url_t2 = $url_tweet2=~/\/status\/(.*)/){
		$my_tweet2 = $1;
	}
	print "URL Tweet: $url_tweet2\nID Tweet: $my_tweet2\t Let's Goo :)\n";
	open (COMPOFILE2, "<$list2") || die "[-] Can't Found ($list2) !";
	@COMPOS2 = <COMPOFILE2>;
	close COMPOFILE2;
	foreach $compolist2 (@COMPOS2 ) {
	chomp $compolist2;
		$check2 = auth_token($compolist2);
		if($check2=~/exit/){
			print "Failed_Login -> ($compolist2)\n";
		}else{
			$my_auth_token2 = $check2;
			print like($my_auth_token2,$my_tweet2);
		}
	}
	print "\n./Done";
	sleep(20);
	exit();
}
if($do == 3){
	print "CompoList [Ex:admin:12345](list.txt)\n -----\n Input CompoList => ";
	$list3 = <STDIN>;
	chomp($list3);
	print "\n------\nEnter Your Username => ";
	$by_user = <STDIN>;
	chomp($by_user);
	open (COMPOFILE3, "<$list3") || die "[-] Can't Found ($list4) !";
	@COMPOS3 = <COMPOFILE3>;
	close COMPOFILE3;
	foreach $compolist3 (@COMPOS3 ) {
	chomp $compolist3;
		$check3 = auth_token($compolist3);
		if($check3=~/exit/){
			print "Failed_Login -> ($compolist3)\n";
		}else{
			$my_auth_token3 = $check3;
			print follows($my_auth_token3,$by_user);
		}
	}
	print "./Done";
	sleep(20);
	exit();
}
if($do == 4){
	print "CompoList [Ex:admin:12345](list.txt)\n -----\n Input CompoList => ";
	$list4 = <STDIN>;
	chomp($list4);
	print "\n------\nEnter Your Username => ";
	$by_user = <STDIN>;
	chomp($by_user);
	print "\n------\nEnter Tweet URL => ";
	$url_tweet4 = <STDIN>;
	chomp($url_tweet4);
	if($url_t4 = $url_tweet4=~/\/status\/(.*)/){
		$my_tweet4 = $1;
	}
	print "URL Tweet: $url_tweet4\nID Tweet: $my_tweet4\t Let's Goo :)\n";
	open (COMPOFILE4, "<$list4") || die "[-] Can't Found ($list4) !";
	@COMPOS4 = <COMPOFILE4>;
	close COMPOFILE4;
	foreach $compolist4 (@COMPOS4 ) {
	chomp $compolist4;
		$check4 = auth_token($compolist4);
		if($check4=~/exit/){
			print "Failed_Login -> ($compolist4)\n";
		}else{
			$my_auth_token4 = $check4;
			print retweet($my_auth_token4,$my_tweet4);
			print like($my_auth_token4,$my_tweet4);
			print follows($my_auth_token4,$by_user);
		}
	}
	print "./Done";
	sleep(20);
	exit();
}
##########################
sub ct0(){
	$sess = LWP::UserAgent->new();
	$sessed = $sess->get('https://twitter.com/');
	if($myct = $sessed->header('set-cookie')=~/ct0=(.+?);/){
		$c = $1;
	}
	return $c;
}
sub follows($$){
	($token3,$user_follow) = @_;
	$ct0_3 = ct0();
	$follows = LWP::UserAgent->new();
	$follows->default_header("authorization" => 'Bearer AAAAAAAAAAAAAAAAAAAAAPYXBAAAAAAACLXUNDekMxqa8h%2F40K4moUkGsoc%3DTYfbDKbT3jJPCEVnMYqilB28NHfOPqkca3qaAxGfsyKCs0wRbw');
	$follows->default_header("x-twitter-auth-type" => 'OAuth2Session');
	$follows->default_header("x-csrf-token" => $ct0_3);
	$follows->default_header("X-Twitter-Active-User" => 'yes');
	$follows->default_header("Cookie" => 'ct0='.$ct0_3.'; auth_token='.$token3.';');
	$followed = $follows->post('https://api.twitter.com/1.1/friendships/create.json',
	{
		challenges_passed=>'false',
		handles_challenges=>'1',
		include_blocked_by=>'true',
		include_blocking=>'true',
		include_can_dm=>'true',
		include_followed_by=>'true',
		include_mute_edge=>'true',
		skip_status=>'true',
		screen_name=>$user_follow
	}
	);
	if($followed->content=~/"id":/){
		return "Success_FOLLOWS\n";
	}else{
		return "Fail_FOLLOWS\n";
	}
}
sub like($$){
	($token2,$id_tweet2) = @_;
	$ct0_2 = ct0();
	$like = LWP::UserAgent->new();
	$like->default_header("authorization" => 'Bearer AAAAAAAAAAAAAAAAAAAAAPYXBAAAAAAACLXUNDekMxqa8h%2F40K4moUkGsoc%3DTYfbDKbT3jJPCEVnMYqilB28NHfOPqkca3qaAxGfsyKCs0wRbw');
	$like->default_header("x-twitter-auth-type" => 'OAuth2Session');
	$like->default_header("x-csrf-token" => $ct0_2);
	$like->default_header("X-Twitter-Active-User" => 'yes');
	$like->default_header("Cookie" => 'ct0='.$ct0_2.'; auth_token='.$token2.';');
	$liked = $like->post('https://api.twitter.com/1.1/favorites/create.json',{id=>$id_tweet2});
	if($liked->content=~/"created_at":"/){
		return "Success_LIKE\n";
	}else{
		return "Fail_LIKE\n";
	}
}
sub retweet($$){
	($token1,$id_tweet) = @_;
	$ct0_1 = ct0();
	$retweet = LWP::UserAgent->new();
	$retweet->default_header("authorization" => 'Bearer AAAAAAAAAAAAAAAAAAAAAPYXBAAAAAAACLXUNDekMxqa8h%2F40K4moUkGsoc%3DTYfbDKbT3jJPCEVnMYqilB28NHfOPqkca3qaAxGfsyKCs0wRbw');
	$retweet->default_header("x-twitter-auth-type" => 'OAuth2Session');
	$retweet->default_header("x-csrf-token" => $ct0_1);
	$retweet->default_header("X-Twitter-Active-User" => 'yes');
	$retweet->default_header("Cookie" => 'ct0='.$ct0_1.'; auth_token='.$token1.';');
	$retweeted = $retweet->post('https://api.twitter.com/1.1/statuses/retweet.json',{id=>$id_tweet});
	if($retweeted->content=~/"created_at":"/){
		return "Success_Retweet\n";
	}else{
		return "Fail_Retweet\n";
	}
}
sub login($$){
	($username,$password) = @_;
	$login = LWP::UserAgent->new();
	$login->default_header("Cookie" => '_twitter_sess=BAh7CSIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo%250ASGFzaHsABjoKQHVzZWR7ADoPY3JlYXRlZF9hdGwrCE1K6KRgAToMY3NyZl9p%250AZCIlNzM3NzgzMmQ1Mzg5NWJiNTg0Y2Y1YjY3OWVjMjM5M2U6B2lkIiU5NjA2%250AZTQ0MDQwYjNkMzA0NjFjNzJhMzc3NWY3NjNkNA%253D%253D--1883725cde78289b52c5f4fcf6ff219e163feae4;');
	$logged = $login->post('https://twitter.com/sessions',{ 'session[username_or_email]' => $username, 'session[password]' => $password, authenticity_token => '1c2c818e18a36a4c66a9df52063065d63da7c504'});
	$headers = $logged->header('set-cookie');
	if($headers=~/auth_token/){
		if($token = $headers=~/auth_token=(.+?);/){
			$auth_token = $1;
		}
		return $auth_token
	}else{
		return "Fail_Login -> $username,$password";
	}
}
sub auth_token($){
	($compo) = @_;
	if($user = $compo=~/(.*):/){
		$myuser = $1;
	}
	if($pass = $compo=~/$myuser:(.*)/){
		$mypass = $1;
	}
	$log = login($myuser,$mypass);
	if($log=~/Fail_Login/){
		return 'exit';
	}else{
		return login($myuser,$mypass);
	}
}
