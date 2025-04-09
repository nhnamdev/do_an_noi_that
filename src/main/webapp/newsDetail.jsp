<%--
  Created by IntelliJ IDEA.
  User: Nam
  Date: 4/9/2025
  Time: 10:28 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title News - Mona Decor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="css/news.css">
    <%--    Ck editor--%>
    <script src="https://cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>
    <%--    Ck editor--%>
</head>
<body>
<jsp:include page="/components/header.jsp"/>
<div class="container" style="margin-top: 6.4rem">
    <div class="row">
        <div class="breadcrumb-wrapper">
            <div class="breadcrumb">
                <div class="container ">
                    <ul style=" padding-top: 14px;text-align: center;height: 54px;display: flex; background-color: #e8e8e8">
                        <li><a href="${pageContext.request.contextPath}/index">Trang chủ</a></li>
                        <li><i class="fas fa-angle-right"></i></li>
                        <li><a href="${pageContext.request.contextPath}/news.jsp">Tin Tức</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <!-- Sidebar -->
        <aside class="col-md-3 sidebar">
            <h5>Tìm kiếm</h5>
            <input type="text" class="form-control mb-3" placeholder="Tìm kiếm...">
            <h5>Chuyên mục</h5>
            <ul class="list-unstyled">
                <li><a href="#">Fashions magazine</a></li>
                <li><a href="#">Images</a></li>
                <li><a href="#">Life style</a></li>
                <li><a href="#">Photography</a></li>
                <li><a href="#">Style</a></li>
            </ul>
            <h5>Bài viết mới nhất</h5>
            <!-- bài viết mới nhất của mỗi danh mục -->
            <div class="latest-post d-flex align-items-center mb-2">
                <img src="img/sofa1.jpg" alt="">
                <div class="ms-2">
                    <small>Fashions magazine</small>
                    <p class="mb-0">Beauty life style classic</p>
                </div>
            </div>
            <!-- bài viết mới nhất của mỗi danh mục -->
        </aside>
        <!-- Main content -->
        <main class="col-md-9">
            <div class="news">
                <div id="content">
                    <article id="post-1187"
                             class="post-1187 post type-post status-publish format-standard has-post-thumbnail hentry category-fashions-magazine tag-beauty tag-classic tag-magazine">
                        <div class="entry-image single-blog-image text-center margin-bottom-30">
                            <img fetchpriority="high" width="1024" height="683"
                                 src="https://noithat-nhadep.monamedia.net/wp-content/uploads/2018/02/Carys-Queen-Bed-1024x683-1.jpg"
                                 class="attachment-post-thumbnail size-post-thumbnail wp-post-image" alt=""
                                 decoding="async"
                                 srcset="https://noithat-nhadep.monamedia.net/wp-content/uploads/2018/02/Carys-Queen-Bed-1024x683-1.jpg 1024w, https://noithat-nhadep.monamedia.net/wp-content/uploads/2018/02/Carys-Queen-Bed-1024x683-1-350x233.jpg 350w, https://noithat-nhadep.monamedia.net/wp-content/uploads/2018/02/Carys-Queen-Bed-1024x683-1-595x397.jpg 595w, https://noithat-nhadep.monamedia.net/wp-content/uploads/2018/02/Carys-Queen-Bed-1024x683-1-150x100.jpg 150w, https://noithat-nhadep.monamedia.net/wp-content/uploads/2018/02/Carys-Queen-Bed-1024x683-1-768x512.jpg 768w, https://noithat-nhadep.monamedia.net/wp-content/uploads/2018/02/Carys-Queen-Bed-1024x683-1-18x12.jpg 18w, https://noithat-nhadep.monamedia.net/wp-content/uploads/2018/02/Carys-Queen-Bed-1024x683-1-450x300.jpg 450w"
                                 sizes="(max-width: 1024px) 100vw, 1024px"></div>

                        <header class="entry-header margin-bottom-25 text-center">
                            <div class="nasa-meta-categories"><a
                                    href="https://noithat-nhadep.monamedia.net/category/fashions-magazine/"
                                    rel="category tag">Fashions magazine</a></div>
                            <h1 class="entry-title nasa-title-single-post">Beauty life style classic</h1>

                            <div class="entry-meta single-posted-info">
                                <span class="meta-author">By <a class="url fn n nasa-bold"
                                                                href="https://noithat-nhadep.monamedia.net/author/monamedia/"
                                                                title="View all posts by monamedia" rel="author">monamedia</a>.</span>
                                Posted on <a href="https://noithat-nhadep.monamedia.net/2018/02/13/" title="5:33 chiều"
                                             rel="bookmark">
                                <time class="entry-date nasa-bold" datetime="2018-02-13T17:33:24+00:00">13 Tháng Hai,
                                    2018
                                </time>
                            </a></div>
                        </header>

                        <div class="entry-content single-entry-content">
                            <div class="section-element">
                                <div class="row">
                                    <div class="large-12 nasa-col columns">
                                        <div class="wpb_text_column wpb_content_element"><p>Lorem ipsum dosectetur
                                            adipisicing elit, sed do.Lorem ipsum dolor sit amet, consectetur Nulla
                                            fringilla purus at leo dignissim congue. Mauris elementum accumsan leo vel
                                            tempor. Sit amet cursus nisl aliquam. Aliquam et elit eu nunc rhoncus
                                            viverra quis at felis.</p>
                                            <blockquote><p>
                                                Be who you are and say what you feel, because those who mind don’t
                                                matter, and those who matter don’t mind.
                                            </p></blockquote>
                                            <p>Lorem ipsum dolor sit amet, consectetur Nulla fringilla purus Lorem ipsum
                                                dosectetur adipisicing elit at leo dignissim congue. Mauris elementum
                                                accumsan leo vel tempor. Aliquam et elit eu nunc rhoncus viverra quis at
                                                felis et netus et malesuada fames ac turpis egestas. Aenean commodo
                                                ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis
                                                dis parturient montes.</p>
                                            <p>Lorem ipsum dolor sit amet, consectetur Nulla fringilla purus Lorem ipsum
                                                dosectetur adipisicing elit at leo dignissim congue. Mauris elementum
                                                accumsan leo vel tempor. Aliquam et elit eu nunc rhoncus viverra quis at
                                                felis et netus et malesuada fames ac turpis egestas. Aenean commodo
                                                ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis
                                                dis parturient montes.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="section-element margin-top-30">
                                <div class="row">
                                    <div class="large-12 nasa-col columns">
                                        <div class="nasa-inner-wrap nasa-pin-wrap nasa-pin-banner-wrap nasa-inited"
                                             data-pin="{&quot;nasa_pin_2&quot;:{&quot;canvas&quot;:{&quot;src&quot;:&quot;https:\/\/noithat-nhadep.monamedia.net\/wp-content\/uploads\/2024\/04\/slider-home-furniture.jpg&quot;,&quot;width&quot;:&quot;0&quot;,&quot;height&quot;:&quot;0&quot;}}}">
                                            <span class="nasa-wrap-relative-image"><div class="easypin"
                                                                                        style="width: 100%; height: 100%; position: relative;"><div
                                                    style="position: relative; height: 100%;"><img height="0" width="0"
                                                                                                   src="https://noithat-nhadep.monamedia.net/wp-content/uploads/2024/04/slider-home-furniture.jpg"
                                                                                                   data-easypin_id="nasa_pin_2"
                                                                                                   alt="Pin Products Home Furniture"
                                                                                                   class="nasa_pin_pb_image"
                                                                                                   style="opacity: 1; position: relative;"></div></div></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="section-element margin-top-30">
                                <div class="row">
                                    <div class="large-12 nasa-col columns">
                                        <div class="wpb_text_column wpb_content_element"><p>Lorem ipsum dolor sit amet,
                                            consectetur Nulla fringilla purus Lorem ipsum dosectetur adipisicing elit at
                                            leo dignissim congue. Mauris elementum accumsan leo vel tempor. Aliquam et
                                            elit eu nunc rhoncus viverra quis at felis et netus et malesuada fames ac
                                            turpis egestas. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis
                                            natoque penatibus et magnis dis parturient montes.</p>
                                            <p>Lorem ipsum dolor sit amet, consectetur Nulla fringilla purus Lorem ipsum
                                                dosectetur adipisicing elit at leo dignissim congue. Mauris elementum
                                                accumsan leo vel tempor. Aliquam et elit eu nunc rhoncus viverra quis at
                                                felis et netus et malesuada fames ac turpis egestas. Aenean commodo
                                                ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis
                                                dis parturient montes.</p>
                                            <p>Lorem ipsum dolor sit amet, consectetur Nulla fringilla purus Lorem ipsum
                                                dosectetur adipisicing elit at leo dignissim congue. Mauris elementum
                                                accumsan leo vel tempor. Aliquam et elit eu nunc rhoncus viverra quis at
                                                felis et netus et malesuada fames ac turpis egestas. Aenean commodo
                                                ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis
                                                dis parturient montes.</p>
                                            <p>Lorem ipsum dolor sit amet, consectetur Nulla fringilla purus Lorem ipsum
                                                dosectetur adipisicing elit at leo dignissim congue. Mauris elementum
                                                accumsan leo vel tempor. Aliquam et elit eu nunc rhoncus viverra quis at
                                                felis et netus et malesuada fames ac turpis egestas. Aenean commodo
                                                ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis
                                                dis parturient montes.Lorem ipsum dolor sit amet, consectetur Nulla
                                                fringilla purus Lorem ipsum dosectetur adipisicing elit at leo dignissim
                                                congue. Mauris elementum accumsan leo vel tempor. Aliquam et elit eu
                                                nunc rhoncus viverra quis at felis et netus et malesuada fames ac turpis
                                                egestas. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis
                                                natoque penatibus et magnis dis parturient montes.</p>
                                            <p>Lorem ipsum dolor sit amet, consectetur Nulla fringilla purus Lorem ipsum
                                                dosectetur adipisicing elit at leo dignissim congue. Mauris elementum
                                                accumsan leo vel tempor. Aliquam et elit eu nunc rhoncus viverra quis at
                                                felis et netus et malesuada fames ac turpis egestas. Aenean commodo
                                                ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis
                                                dis parturient montes.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="section-element">
                                <div class="row">
                                    <div class="large-4 padding-bottom-20 nasa-col columns">
                                        <div class="nasa-compare-images-wrap">
                                            <div class="nasa-compare-images nasa-inited images-compare-container"
                                                 style="display: inline-block; max-width: 519px; max-height: 576px; touch-action: pan-y; user-select: none; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);">
                                                <div class="images-compare-separator" style="left: 137px;"></div>
                                                <div class="images-compare-handle" style="left: 137px;"><span
                                                        class="images-compare-left-arrow"></span><span
                                                        class="images-compare-right-arrow"></span></div>
                                                <div class="hidden-tag images-compare-before"
                                                     style="display: block; width: 273.328px; height: 303.344px; clip: rect(0px, 137px, 303.344px, 0px);"
                                                     ratio="0.5"><img class="nasa-img-compare-item skip-lazy before-img"
                                                                      src="https://noithat-nhadep.monamedia.net/wp-content/uploads/2019/10/before-img.jpg"
                                                                      width="519" height="576" alt=""></div>
                                                <div class="hidden-tag images-compare-after" style="display: block;">
                                                    <img class="nasa-img-compare-item skip-lazy after-img"
                                                         src="https://noithat-nhadep.monamedia.net/wp-content/uploads/2019/10/after-img.jpg"
                                                         width="519" height="576" alt=""></div>
                                            </div>
                                            <a href="#" title="Before - After Makeup - Left"><h5
                                                    class="nasa-compare-images-title margin-top-15 text-left">Before -
                                                After Makeup - Left</h5></a>
                                            <p class="nasa-compare-images-desc margin-bottom-0 text-left">Lorem Ipsum
                                                has been the industry’s standard dummy text.</p></div>
                                    </div>
                                    <div class="large-4 padding-bottom-20 nasa-col columns">
                                        <div class="nasa-compare-images-wrap">
                                            <div class="nasa-compare-images nasa-inited images-compare-container"
                                                 style="display: inline-block; max-width: 519px; max-height: 576px; touch-action: pan-y; user-select: none; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);">
                                                <div class="images-compare-separator" style="left: 137px;"></div>
                                                <div class="images-compare-handle" style="left: 137px;"><span
                                                        class="images-compare-left-arrow"></span><span
                                                        class="images-compare-right-arrow"></span></div>
                                                <div class="hidden-tag images-compare-before"
                                                     style="display: block; width: 273.328px; height: 303.344px; clip: rect(0px, 137px, 303.344px, 0px);"
                                                     ratio="0.5"><img class="nasa-img-compare-item skip-lazy before-img"
                                                                      src="https://noithat-nhadep.monamedia.net/wp-content/uploads/2019/10/before-img.jpg"
                                                                      width="519" height="576" alt=""></div>
                                                <div class="hidden-tag images-compare-after" style="display: block;">
                                                    <img class="nasa-img-compare-item skip-lazy after-img"
                                                         src="https://noithat-nhadep.monamedia.net/wp-content/uploads/2019/10/after-img.jpg"
                                                         width="519" height="576" alt=""></div>
                                            </div>
                                            <a href="#" title="Before - After Makeup - Center"><h5
                                                    class="nasa-compare-images-title margin-top-15 text-center">Before -
                                                After Makeup - Center</h5></a>
                                            <p class="nasa-compare-images-desc margin-bottom-0 text-center">Lorem Ipsum
                                                has been the industry’s standard dummy text.</p></div>
                                    </div>
                                    <div class="large-4 padding-bottom-20 nasa-col columns">
                                        <div class="nasa-compare-images-wrap">
                                            <div class="nasa-compare-images nasa-inited images-compare-container"
                                                 style="display: inline-block; max-width: 519px; max-height: 576px; touch-action: pan-y; user-select: none; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);">
                                                <div class="images-compare-separator" style="left: 137px;"></div>
                                                <div class="images-compare-handle" style="left: 137px;"><span
                                                        class="images-compare-left-arrow"></span><span
                                                        class="images-compare-right-arrow"></span></div>
                                                <div class="hidden-tag images-compare-before"
                                                     style="display: block; width: 273.328px; height: 303.344px; clip: rect(0px, 137px, 303.344px, 0px);"
                                                     ratio="0.5"><img class="nasa-img-compare-item skip-lazy before-img"
                                                                      src="https://noithat-nhadep.monamedia.net/wp-content/uploads/2019/10/before-img.jpg"
                                                                      width="519" height="576" alt=""></div>
                                                <div class="hidden-tag images-compare-after" style="display: block;">
                                                    <img class="nasa-img-compare-item skip-lazy after-img"
                                                         src="https://noithat-nhadep.monamedia.net/wp-content/uploads/2019/10/after-img.jpg"
                                                         width="519" height="576" alt=""></div>
                                            </div>
                                            <a href="#" title="Before - After Makeup - Right"><h5
                                                    class="nasa-compare-images-title margin-top-15 text-right">Before -
                                                After Makeup - Right</h5></a>
                                            <p class="nasa-compare-images-desc margin-bottom-0 text-right">Lorem Ipsum
                                                has been the industry’s standard dummy text.</p></div>
                                    </div>
                                </div>
                            </div>
                            <div class="section-element margin-bottom-20">
                                <div class="row">
                                    <div class="large-12 nasa-col columns">
                                        <div class="wpb_text_column wpb_content_element"><p>Lorem ipsum dolor sit amet,
                                            consectetur Nulla fringilla purus Lorem ipsum dosectetur adipisicing elit at
                                            leo dignissim congue. Mauris elementum accumsan leo vel tempor. Aliquam et
                                            elit eu nunc rhoncus viverra quis at felis et netus et malesuada fames ac
                                            turpis egestas. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis
                                            natoque penatibus et magnis dis parturient montes.</p>
                                            <p>Lorem ipsum dolor sit amet, consectetur Nulla fringilla purus Lorem ipsum
                                                dosectetur adipisicing elit at leo dignissim congue. Mauris elementum
                                                accumsan leo vel tempor. Aliquam et elit eu nunc rhoncus viverra quis at
                                                felis et netus et malesuada fames ac turpis egestas. Aenean commodo
                                                ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis
                                                dis parturient montes.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <footer class="entry-meta footer-entry-meta single-footer-entry-meta">
                            <div class="row">
                                <div class="columns large-7 medium-7 nasa-min-height rtl-right">
                                    <div class="nasa-meta-tags rtl-text-right">
                                        <a href="https://noithat-nhadep.monamedia.net/tag/beauty/"
                                           rel="tag">Beauty</a><a
                                            href="https://noithat-nhadep.monamedia.net/tag/classic/"
                                            rel="tag">Classic</a><a
                                            href="https://noithat-nhadep.monamedia.net/tag/magazine/"
                                            rel="tag">Magazine</a></div>
                                </div>

                                <div class="columns large-5 medium-5 nasa-meta-social mobile-margin-top-20 rtl-left">
                                    <ul class="ns-social social-icons nasa-share text-right mobile-text-left rtl-mobile-text-right rtl-text-left">
                                        <li>
                                            <a href="https://twitter.com/share?url=https://noithat-nhadep.monamedia.net/2018/02/13/beauty-life-style-classic/"
                                               target="_blank" class="icon nasa-tip" title="Share on X" rel="nofollow">
                                                <svg viewBox="0 0 24 24" with="14.5" height="14.5" aria-hidden="true"
                                                     fill="currentColor">
                                                    <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"></path>
                                                </svg>
                                            </a></li>
                                        <li>
                                            <a href="https://www.facebook.com/sharer.php?u=https://noithat-nhadep.monamedia.net/2018/02/13/beauty-life-style-classic/"
                                               target="_blank" class="icon nasa-tip" title="Share on Facebook"
                                               rel="nofollow">
                                                <svg viewBox="0 0 32 32" with="15" height="15" fill="currentColor">
                                                    <path d="M 19.253906 2 C 15.311906 2 13 4.0821719 13 8.8261719 L 13 13 L 8 13 L 8 18 L 13 18 L 13 30 L 18 30 L 18 18 L 22 18 L 23 13 L 18 13 L 18 9.671875 C 18 7.884875 18.582766 7 20.259766 7 L 23 7 L 23 2.2050781 C 22.526 2.1410781 21.144906 2 19.253906 2 z"></path>
                                                </svg>
                                            </a></li>
                                        <li>
                                            <a href="https://pinterest.com/pin/create/button/?url=https://noithat-nhadep.monamedia.net/2018/02/13/beauty-life-style-classic/&amp;media=https://noithat-nhadep.monamedia.net/wp-content/uploads/2018/02/Carys-Queen-Bed-1024x683-1-595x397.jpg&amp;description=Beauty%20life%20style%20classic"
                                               target="_blank" class="icon nasa-tip" title="Pin on Pinterest"
                                               rel="nofollow">
                                                <svg viewBox="0 0 16 16" width="16" height="16" fill="currentColor">
                                                    <path d="M 7.5 1 C 3.910156 1 1 3.910156 1 7.5 C 1 10.253906 2.714844 12.605469 5.132813 13.554688 C 5.074219 13.039063 5.023438 12.25 5.152344 11.6875 C 5.273438 11.183594 5.914063 8.457031 5.914063 8.457031 C 5.914063 8.457031 5.722656 8.066406 5.722656 7.492188 C 5.722656 6.589844 6.246094 5.914063 6.898438 5.914063 C 7.453125 5.914063 7.71875 6.332031 7.71875 6.828125 C 7.71875 7.386719 7.363281 8.222656 7.183594 8.992188 C 7.027344 9.640625 7.507813 10.167969 8.144531 10.167969 C 9.300781 10.167969 10.1875 8.949219 10.1875 7.191406 C 10.1875 5.636719 9.070313 4.546875 7.472656 4.546875 C 5.625 4.546875 4.539063 5.933594 4.539063 7.367188 C 4.539063 7.925781 4.753906 8.527344 5.023438 8.851563 C 5.074219 8.917969 5.082031 8.972656 5.066406 9.039063 C 5.019531 9.242188 4.90625 9.6875 4.886719 9.777344 C 4.859375 9.894531 4.792969 9.921875 4.667969 9.863281 C 3.855469 9.484375 3.347656 8.296875 3.347656 7.34375 C 3.347656 5.292969 4.839844 3.410156 7.644531 3.410156 C 9.898438 3.410156 11.652344 5.015625 11.652344 7.164063 C 11.652344 9.402344 10.238281 11.207031 8.277344 11.207031 C 7.617188 11.207031 7 10.863281 6.789063 10.460938 C 6.789063 10.460938 6.460938 11.703125 6.382813 12.007813 C 6.234375 12.570313 5.839844 13.277344 5.574219 13.710938 C 6.183594 13.898438 6.828125 14 7.5 14 C 11.089844 14 14 11.089844 14 7.5 C 14 3.910156 11.089844 1 7.5 1 Z"></path>
                                                </svg>
                                            </a></li>
                                        <li>
                                            <a href="mailto:enter-your-mail@domain-here.com?subject=Beauty%20life%20style%20classic&amp;body=Check%20this%20out:%20https://noithat-nhadep.monamedia.net/2018/02/13/beauty-life-style-classic/"
                                               target="_blank" class="icon nasa-tip" title="Email to your friends"
                                               rel="nofollow">
                                                <svg viewBox="0 0 24 24" width="17" height="17" fill="currentColor">
                                                    <path d="M19,4H5A3,3,0,0,0,2,7V17a3,3,0,0,0,3,3H19a3,3,0,0,0,3-3V7A3,3,0,0,0,19,4ZM5,6H19a1,1,0,0,1,1,1l-8,4.88L4,7A1,1,0,0,1,5,6ZM20,17a1,1,0,0,1-1,1H5a1,1,0,0,1-1-1V9.28l7.48,4.57a1,1,0,0,0,1,0L20,9.28Z"></path>
                                                </svg>
                                            </a></li>
                                    </ul>
                                </div>
                            </div>
                        </footer>

                    </article>
                </div>
            </div>
        </main>
        <!-- Main content -->
    </div>
</div>
<jsp:include page="components/footer.jsp"/>
</body>
</html>
