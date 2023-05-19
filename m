Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFB8C77B7A
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 16:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjESQYO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 12:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjESQYK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 12:24:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AED693
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 09:24:08 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QNBw10VsDz67fpR;
        Sat, 20 May 2023 00:22:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 19 May
 2023 17:24:04 +0100
Date:   Fri, 19 May 2023 17:24:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, "Ira Weiny" <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, "Thomas Huth" <thuth@redhat.com>
Subject: Re: [PATCH v6 1/4] bswap: Add the ability to store to an unaligned
 24 bit field
Message-ID: <20230519172404.0000649e@Huawei.com>
In-Reply-To: <27f9ad4f-bdde-f548-860b-34e52493faa2@linaro.org>
References: <20230519141803.29713-1-Jonathan.Cameron@huawei.com>
        <20230519141803.29713-2-Jonathan.Cameron@huawei.com>
        <27f9ad4f-bdde-f548-860b-34e52493faa2@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 19 May 2023 18:08:30 +0200
Philippe Mathieu-Daudé <philmd@linaro.org> wrote:

> On 19/5/23 16:18, Jonathan Cameron wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL has 24 bit unaligned fields which need to be stored to.  CXL is
> > specified as little endian.
> > 
> > Define st24_le_p() and the supporting functions to store such a field
> > from a 32 bit host native value.
> > 
> > The use of b, w, l, q as the size specifier is limiting.  So "24" was
> > used for the size part of the function name.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   docs/devel/loads-stores.rst |  1 +
> >   include/qemu/bswap.h        | 27 +++++++++++++++++++++++++++
> >   2 files changed, 28 insertions(+)
> > 
> > diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
> > index d2cefc77a2..82a79e91d9 100644
> > --- a/docs/devel/loads-stores.rst
> > +++ b/docs/devel/loads-stores.rst
> > @@ -36,6 +36,7 @@ store: ``st{size}_{endian}_p(ptr, val)``
> >   ``size``
> >    - ``b`` : 8 bits
> >    - ``w`` : 16 bits
> > + - ``24`` : 24 bits
> >    - ``l`` : 32 bits
> >    - ``q`` : 64 bits
> >   
> > diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> > index 15a78c0db5..f546b1fc06 100644
> > --- a/include/qemu/bswap.h
> > +++ b/include/qemu/bswap.h
> > @@ -8,11 +8,25 @@
> >   #undef  bswap64
> >   #define bswap64(_x) __builtin_bswap64(_x)
> >   
> > +static inline uint32_t bswap24(uint32_t x)
> > +{
> > +    assert((x & 0xff000000U) == 0);  
> 
> Asserting here is a bit violent. In particular because there is no
> contract description that x should be less than N bits for bswapN()
> in "qemu/bswap.h" API.
> 
> But if you rather to assert ...


I'm fine either way.  You asked for it when reviewing v4...
https://lore.kernel.org/all/28a9d97a-b252-a33f-1ac0-cd36264b29ab@linaro.org/


> 
> > +
> > +    return (((x & 0x000000ffU) << 16) |
> > +            ((x & 0x0000ff00U) <<  0) |
> > +            ((x & 0x00ff0000U) >> 16));
> > +}
> > +
> >   static inline void bswap16s(uint16_t *s)
> >   {
> >       *s = __builtin_bswap16(*s);
> >   }
> >   
> > +static inline void bswap24s(uint32_t *s)
> > +{
> > +    *s = bswap24(*s & 0x00ffffffU);  
> 
> ... and sanitize the value here ...
> 
> > +}
> > +
> >   static inline void bswap32s(uint32_t *s)
> >   {
> >       *s = __builtin_bswap32(*s);
> > @@ -26,11 +40,13 @@ static inline void bswap64s(uint64_t *s)
> >   #if HOST_BIG_ENDIAN
> >   #define be_bswap(v, size) (v)
> >   #define le_bswap(v, size) glue(__builtin_bswap, size)(v)
> > +#define le_bswap24(v) bswap24(v)  
> 
> ... then shouldn't you sanitize also here?
> 

Good point. I forgot that detail whilst fighting with s390
cross builds earlier ;)

> Personally I'd just drop the assertion.

I'm fine with doing that.

Jonathan

> 
> >   #define be_bswaps(v, size)
> >   #define le_bswaps(p, size) \
> >               do { *p = glue(__builtin_bswap, size)(*p); } while (0)
> >   #else
> >   #define le_bswap(v, size) (v)
> > +#define le_bswap24(v) (v)
> >   #define be_bswap(v, size) glue(__builtin_bswap, size)(v)
> >   #define le_bswaps(v, size)
> >   #define be_bswaps(p, size) \
> > @@ -176,6 +192,7 @@ CPU_CONVERT(le, 64, uint64_t)
> >    * size is:
> >    *   b: 8 bits
> >    *   w: 16 bits
> > + *   24: 24 bits
> >    *   l: 32 bits
> >    *   q: 64 bits
> >    *
> > @@ -248,6 +265,11 @@ static inline void stw_he_p(void *ptr, uint16_t v)
> >       __builtin_memcpy(ptr, &v, sizeof(v));
> >   }
> >   
> > +static inline void st24_he_p(void *ptr, uint32_t v)
> > +{
> > +    __builtin_memcpy(ptr, &v, 3);
> > +}
> > +
> >   static inline int ldl_he_p(const void *ptr)
> >   {
> >       int32_t r;
> > @@ -297,6 +319,11 @@ static inline void stw_le_p(void *ptr, uint16_t v)
> >       stw_he_p(ptr, le_bswap(v, 16));
> >   }
> >   
> > +static inline void st24_le_p(void *ptr, uint32_t v)
> > +{
> > +    st24_he_p(ptr, le_bswap24(v));
> > +}
> > +
> >   static inline void stl_le_p(void *ptr, uint32_t v)
> >   {
> >       stl_he_p(ptr, le_bswap(v, 32));  
> 
> Conditional to removing the assertion in bswap24():
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

