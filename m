Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAAEC77B7F
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 13:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjESNmm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 09:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjESNml (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 09:42:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4A8BB
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 06:42:39 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QN7Js2DVxz67PjK;
        Fri, 19 May 2023 21:40:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 19 May
 2023 14:42:36 +0100
Date:   Fri, 19 May 2023 14:42:34 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 3/6] bswap: Add the ability to store to an unaligned
 24 bit field
Message-ID: <20230519144223.0000551a@huawei.com>
In-Reply-To: <20230519123353.00004a00@huawei.com>
References: <20230423162013.4535-1-Jonathan.Cameron@huawei.com>
        <20230423162013.4535-4-Jonathan.Cameron@huawei.com>
        <20230519123353.00004a00@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 19 May 2023 12:33:53 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Sun, 23 Apr 2023 17:20:10 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
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
> > Reviewed-by: Fan Ni <fan.ni@samsung.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> This doesn't work for s390 (probably big endian hosts in general)
> 
> I'll post a new version of the series with adjusted logic shortly. 
> I think all we can do is special case the 24 bit logic in the block
> dealing with big vs little endian accessors.
> 
> Something like the following.
> I'll drop Fan's tag as this is a substantial change. Fan, if you can
> take a look at v6 when I post it that would be great.
> 
> I'm having issues with gitlab CI minutes running out on my fork.
> Hopefully I can get that resolved and test this properly. 

Got this tested using a cross compile in docker via
make docker-test-build@debian-x390x-cross

and a bunch of docker config.

Anyhow, will send out new version of patches 3-6 shortly. 

Thanks,

Jonathan

> 
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 91ed9c7e2c..f546b1fc06 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -40,11 +40,13 @@ static inline void bswap64s(uint64_t *s)
>  #if HOST_BIG_ENDIAN
>  #define be_bswap(v, size) (v)
>  #define le_bswap(v, size) glue(__builtin_bswap, size)(v)
> +#define le_bswap24(v) bswap24(v)
>  #define be_bswaps(v, size)
>  #define le_bswaps(p, size) \
>              do { *p = glue(__builtin_bswap, size)(*p); } while (0)
>  #else
>  #define le_bswap(v, size) (v)
> +#define le_bswap24(v) (v)
>  #define be_bswap(v, size) glue(__builtin_bswap, size)(v)
>  #define le_bswaps(v, size)
>  #define be_bswaps(p, size) \
> @@ -319,7 +321,7 @@ static inline void stw_le_p(void *ptr, uint16_t v)
> 
>  static inline void st24_le_p(void *ptr, uint32_t v)
>  {
> -    st24_he_p(ptr, le_bswap(v, 24));
> +    st24_he_p(ptr, le_bswap24(v));
>  }
> 
>  static inline void stl_le_p(void *ptr, uint32_t v)
> 
> > 
> > ---
> > v5:
> >   - Added assertion that upper bits of the input parameter aren't set.
> >   - Mask value in bswap24s()
> >   - update docs
> > ---
> >  docs/devel/loads-stores.rst |  1 +
> >  include/qemu/bswap.h        | 25 +++++++++++++++++++++++++
> >  2 files changed, 26 insertions(+)
> > 
> > diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
> > index ad5dfe133e..57b4396f7a 100644
> > --- a/docs/devel/loads-stores.rst
> > +++ b/docs/devel/loads-stores.rst
> > @@ -36,6 +36,7 @@ store: ``st{size}_{endian}_p(ptr, val)``
> >  ``size``
> >   - ``b`` : 8 bits
> >   - ``w`` : 16 bits
> > + - ``24`` : 24 bits
> >   - ``l`` : 32 bits
> >   - ``q`` : 64 bits
> >  
> > diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> > index 15a78c0db5..91ed9c7e2c 100644
> > --- a/include/qemu/bswap.h
> > +++ b/include/qemu/bswap.h
> > @@ -8,11 +8,25 @@
> >  #undef  bswap64
> >  #define bswap64(_x) __builtin_bswap64(_x)
> >  
> > +static inline uint32_t bswap24(uint32_t x)
> > +{
> > +    assert((x & 0xff000000U) == 0);
> > +
> > +    return (((x & 0x000000ffU) << 16) |
> > +            ((x & 0x0000ff00U) <<  0) |
> > +            ((x & 0x00ff0000U) >> 16));
> > +}
> > +
> >  static inline void bswap16s(uint16_t *s)
> >  {
> >      *s = __builtin_bswap16(*s);
> >  }
> >  
> > +static inline void bswap24s(uint32_t *s)
> > +{
> > +    *s = bswap24(*s & 0x00ffffffU);
> > +}
> > +
> >  static inline void bswap32s(uint32_t *s)
> >  {
> >      *s = __builtin_bswap32(*s);
> > @@ -176,6 +190,7 @@ CPU_CONVERT(le, 64, uint64_t)
> >   * size is:
> >   *   b: 8 bits
> >   *   w: 16 bits
> > + *   24: 24 bits
> >   *   l: 32 bits
> >   *   q: 64 bits
> >   *
> > @@ -248,6 +263,11 @@ static inline void stw_he_p(void *ptr, uint16_t v)
> >      __builtin_memcpy(ptr, &v, sizeof(v));
> >  }
> >  
> > +static inline void st24_he_p(void *ptr, uint32_t v)
> > +{
> > +    __builtin_memcpy(ptr, &v, 3);
> > +}
> > +
> >  static inline int ldl_he_p(const void *ptr)
> >  {
> >      int32_t r;
> > @@ -297,6 +317,11 @@ static inline void stw_le_p(void *ptr, uint16_t v)
> >      stw_he_p(ptr, le_bswap(v, 16));
> >  }
> >  
> > +static inline void st24_le_p(void *ptr, uint32_t v)
> > +{
> > +    st24_he_p(ptr, le_bswap(v, 24));
> > +}
> > +
> >  static inline void stl_le_p(void *ptr, uint32_t v)
> >  {
> >      stl_he_p(ptr, le_bswap(v, 32));  
> 
> 

