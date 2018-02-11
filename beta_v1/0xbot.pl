#!usr/bin/perl
use LWP::UserAgent;
##########################
system('cls');
print q(
+=====================+
[ 0xBotTwitter {Beta} ]
|---------------------|
[    Version: 1.0     ]
|---------------------|
[  CoDeD By 1337r00t  ]
+---------------------+
[  Twitter: _1337r00t ]
[ Instagram: x1337r00t]
+=====================+
Choo0o0o0o0o0oooose Dude :}:-

1 - Retweets
2 - Likes # Soon In version 2
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
}
if($do == 2){
	print 'Soon [Version 2]';
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
sub retweet($$){
	($token1,$id_tweet) = @_;
	$ct0 = ct0();
	$retweet = LWP::UserAgent->new();
	$retweet->default_header("authorization" => 'Bearer AAAAAAAAAAAAAAAAAAAAAPYXBAAAAAAACLXUNDekMxqa8h%2F40K4moUkGsoc%3DTYfbDKbT3jJPCEVnMYqilB28NHfOPqkca3qaAxGfsyKCs0wRbw');
	$retweet->default_header("x-twitter-auth-type" => 'OAuth2Session');
	$retweet->default_header("x-csrf-token" => $ct0);
	$retweet->default_header("X-Twitter-Active-User" => 'yes');
	$retweet->default_header("Cookie" => 'ct0='.$ct0.'; auth_token='.$token1.';');
	$retweeted = $retweet->post('https://api.twitter.com/1.1/statuses/retweet.json',{id=>$id_tweet});
	if($retweeted->content=~/"created_at":"/){
		return "Success\n";
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
