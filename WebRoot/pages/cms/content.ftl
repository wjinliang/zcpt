<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8" />
<title>${content.title?default("")}</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->

<link href="../../themes/media/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>

<link href="../../themes/media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>

<link href="../../themes/media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

<link href="../../themes/media/css/style-metro.css" rel="stylesheet" type="text/css"/>

<link href="../../themes/media/css/style.css" rel="stylesheet" type="text/css"/>

<link href="../../themes/media/css/style-responsive.css" rel="stylesheet" type="text/css"/>

<link href="../../themes/media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>

<link href="../../themes/media/css/uniform.default.css" rel="stylesheet" type="text/css"/>

<link href="../../themes/media/css/jquery.fancybox.css" rel="stylesheet" />

<!-- END GLOBAL MANDATORY STYLES -->

<!-- BEGIN PAGE LEVEL STYLES -->

<link href="../../themes/media/css/news.css" rel="stylesheet" type="text/css"/>

<link href="../../themes/media/css/blog.css" rel="stylesheet" type="text/css"/>

</head>
<body class="page-full-width">
	
	<!-- BEGIN CONTAINER -->   
	<div class="page-container row-fluid">
		
		<!-- BEGIN PAGE -->
		<div class="page-content">

			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
				<!-- BEGIN PAGE CONTENT-->
				<div class="row-fluid">

					<div class="span12 news-page blog-page">

						<div class="row-fluid">

							<div class="span8 blog-tag-data">

								<h1>${content.title?default("")}</h1>


								<div class="row-fluid">

									<div class="span6">

										<ul class="unstyled inline blog-tags">

										</ul>

									</div>

									<div class="span6 blog-tag-data-inner">

										<ul class="unstyled inline">

											<li>发布时间：${content.publishTime}</li>
											<li>发布者：${content.author?default("-")}</li>
											<li>来源：<a href="${content.originUrl?default("#")}">${content.origin?default("")}</a></li>

										</ul>

									</div>

								</div>
								<div class="news-item-page">
									<blockquote class="hero">
										摘要：
										<p>${content.digest?default("")}</p>

									</blockquote>
								</div>
								<div class="news-item-page">
									${content.content}
								</div>

								<hr>
								
								<div class="row-fluid">

									<div class="span6 blog-tag-data-inner">

										<ul class="unstyled inline">

											<li>上一篇：<a href=""></a></li>
											<li>下一篇：<a href=""></a></li>
										</ul>

									</div>

								</div>

								<div class="media">

									<h3>评论</h3>

									<a href="#" class="pull-left">

									<img alt="" src="../../themes/media/image/9.jpg" class="media-object">

									</a>

									<div class="media-body">

										<h4 class="media-heading">Media heading <span>5 hours ago / <a href="#">Reply</a></span></h4>

										<p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>

										<hr>

										<!-- Nested media object -->

										<div class="media">

											<a href="#" class="pull-left">

											<img alt="" src="../../themes/media/image/5.jpg" class="media-object">

											</a>

											<div class="media-body">

												<h4 class="media-heading">Media heading <span>17 hours ago / <a href="#">Reply</a></span></h4>

												<p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>

												<hr>
											
											<div class="media">

											<a href="#" class="pull-left">

											<img alt="" src="../../themes/media/image/7.jpg" class="media-object">

											</a>

											<div class="media-body">

												<h4 class="media-heading">Media heading <span>2 days ago / <a href="#">Reply</a></span></h4>

												<p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>

											</div>
											
											</div>
											

										</div>

										<!--end media-->

										</div>

										<!--end media-->

									</div>

								</div>

								<hr>

								<div class="post-comment">

									<h3>我要评论</h3>

									<form>

										<label>昵称</label>

										<input type="text" class="span7 m-wrap">

										<label>电子邮箱 <span class="color-red">*</span></label>

										<input type="text" class="span7 m-wrap">

										<label>内容</label>

										<textarea class="span10 m-wrap" rows="8"></textarea>

										<p><button class="btn blue" type="submit">Post a Comment</button></p>

									</form>

								</div>

							</div>

							<div class="span4">

								<h2>热点导航</h2>

								<div class="top-news">

									<a href="#" class="btn green">

									<span>Top Week</span>

									<em>Posted on: April 15, 2013</em>

									<em>

									<i class="icon-tags"></i>

									Internet, Music, People

									</em>

									<i class="icon-music top-news-icon"></i>                             

									</a>

									<a href="#" class="btn yellow">

									<span>Study Abroad</span>

									<em>Posted on: April 13, 2013</em>

									<em>

									<i class="icon-tags"></i>

									Education, Students, Canada

									</em>

									<i class="icon-book top-news-icon"></i>                              

									</a>

									<a href="#" class="btn red">

									<span>Metronic News</span>

									<em>Posted on: April 16, 2013</em>

									<em>

									<i class="icon-tags"></i>

									Money, Business, Google

									</em>

									<i class="icon-briefcase top-news-icon"></i>

									</a>

									<a href="#" class="btn blue">

									<span>Gold Price Falls</span>

									<em>Posted on: April 14, 2013</em>

									<em>

									<i class="icon-tags"></i>

									USA, Business, Apple

									</em>

									<i class="icon-globe top-news-icon"></i>                             

									</a>

								</div>

								<div class="space20"></div>

								<h2>News Tags</h2>

								<ul class="unstyled inline sidebar-tags">

									<li><a href="#"><i class="icon-tags"></i> Business</a></li>

									<li><a href="#"><i class="icon-tags"></i> Music</a></li>

									<li><a href="#"><i class="icon-tags"></i> Internet</a></li>

									<li><a href="#"><i class="icon-tags"></i> Money</a></li>

									<li><a href="#"><i class="icon-tags"></i> Google</a></li>

									<li><a href="#"><i class="icon-tags"></i> TV Shows</a></li>

									<li><a href="#"><i class="icon-tags"></i> Education</a></li>

									<li><a href="#"><i class="icon-tags"></i> People</a></li>

									<li><a href="#"><i class="icon-tags"></i> People</a></li>

									<li><a href="#"><i class="icon-tags"></i> Math</a></li>

									<li><a href="#"><i class="icon-tags"></i> Photos</a></li>

									<li><a href="#"><i class="icon-tags"></i> Electronics</a></li>

									<li><a href="#"><i class="icon-tags"></i> Apple</a></li>

									<li><a href="#"><i class="icon-tags"></i> Canada</a></li>

								</ul>

								<div class="space20"></div>

								<h2>Tabs</h2>

								<div class="tabbable tabbable-custom">

									<ul class="nav nav-tabs">

										<li class="active"><a data-toggle="tab" href="#tab_1_1">Section 1</a></li>

										<li class=""><a data-toggle="tab" href="#tab_1_2">Section 2</a></li>

										<li class=""><a data-toggle="tab" href="#tab_1_3">Section 3</a></li>

									</ul>

									<div class="tab-content">

										<div id="tab_1_1" class="tab-pane active">

											<p>I'm in Section 1.</p>

											<p>

												Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat.

											</p>

										</div>

										<div id="tab_1_2" class="tab-pane">

											<p>Howdy, I'm in Section 2.</p>

											<p>

												Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat. Ut wisi enim ad minim veniam, quis nostrud exerci tation.

											</p>

										</div>

										<div id="tab_1_3" class="tab-pane">

											<p>Howdy, I'm in Section 3.</p>

											<p>

												Duis autem vel eum iriure dolor in hendrerit in vulputate.

												Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat

											</p>

										</div>

									</div>

								</div>

								<div class="space20"></div>

								<h2>Recent Twitts</h2>

								<div class="blog-twitter">

									<div class="blog-twitter-block">

										<a href="">@keenthemes</a> 

										<p>At vero eos et accusamus et iusto odio.</p>

										<a href="#"><em>http://t.co/sBav7dm</em></a> 

										<span>5 hours ago</span>

										<i class="icon-twitter blog-twiiter-icon"></i>

									</div>

									<div class="blog-twitter-block">

										<a href="">@keenthemes</a> 

										<p>At vero eos et accusamus et iusto odio.</p>

										<a href="#"><em>http://t.co/sBav7dm</em></a> 

										<span>8 hours ago</span>

										<i class="icon-twitter blog-twiiter-icon"></i>

									</div>

									<div class="blog-twitter-block">

										<a href="">@keenthemes</a> 

										<p>At vero eos et accusamus et iusto odio.</p>

										<a href="#"><em>http://t.co/sBav7dm</em></a> 

										<span>12 hours ago</span>

										<i class="icon-twitter blog-twiiter-icon"></i>

									</div>

								</div>

								<div class="space20"></div>

								<h2>Flickr</h2>

								<ul class="unstyled blog-images">

									<li>

										<a class="fancybox-button" data-rel="fancybox-button" title="390 x 220 - keenthemes.com" href="../../themes/media/image/1.jpg">

										<img alt="" src="../../themes/media/image/1.jpg">

										</a>

									</li>

									<li><a href="#"><img alt="" src="../../themes/media/image/2.jpg"></a></li>

									<li><a href="#"><img alt="" src="../../themes/media/image/3.jpg"></a></li>

									<li><a href="#"><img alt="" src="../../themes/media/image/4.jpg"></a></li>

									<li><a href="#"><img alt="" src="../../themes/media/image/5.jpg"></a></li>

									<li><a href="#"><img alt="" src="../../themes/media/image/6.jpg"></a></li>

									<li><a href="#"><img alt="" src="../../themes/media/image/8.jpg"></a></li>

									<li><a href="#"><img alt="" src="../../themes/media/image/10.jpg"></a></li>

									<li><a href="#"><img alt="" src="../../themes/media/image/11.jpg"></a></li>

									<li><a href="#"><img alt="" src="../../themes/media/image/1.jpg"></a></li>

									<li><a href="#"><img alt="" src="../../themes/media/image/2.jpg"></a></li>

									<li><a href="#"><img alt="" src="../../themes/media/image/7.jpg"></a></li>

								</ul>

							</div>

						</div>

					</div>

				</div>

				<!-- END PAGE CONTENT-->

			</div>

			<!-- END PAGE CONTAINER--> 

		</div>

		<!-- END PAGE -->    

	</div>

	<!-- END CONTAINER -->

	<!-- BEGIN FOOTER -->

	<div class="footer">

		<div class="footer-inner">

			2013 &copy; Metronic by keenthemes.

		</div>

		<div class="footer-tools">

			<span class="go-top">

			<i class="icon-angle-up"></i>

			</span>

		</div>

	</div>

	<!-- END FOOTER -->

	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->

	<!-- BEGIN CORE PLUGINS -->

	<script src="../../themes/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>

	<script src="../../themes/media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

	<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->

	<script src="../../themes/media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      

	<script src="../../themes/media/js/bootstrap.min.js" type="text/javascript"></script>

	<script src="../../themes/media/js/jquery.slimscroll.min.js" type="text/javascript"></script>

	<script src="../../themes/media/js/jquery.blockui.min.js" type="text/javascript"></script>  

	<script src="../../themes/media/js/jquery.cookie.min.js" type="text/javascript"></script>

	<script src="../../themes/media/js/jquery.uniform.min.js" type="text/javascript" ></script>

	<!-- END CORE PLUGINS -->

	<script src="../../themes/media/js/app.js"></script>      

	<script>

		jQuery(document).ready(function() {    

		   App.init();

		});

	</script>

	<!-- END JAVASCRIPTS -->

</body>

</html>