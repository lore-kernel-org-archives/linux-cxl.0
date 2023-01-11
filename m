Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C163C46467
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Jan 2023 16:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjAKQ7j convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Jan 2023 11:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjAKQ7h (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Jan 2023 11:59:37 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E092C41
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jan 2023 08:59:35 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NsYkJ6gXwz67NQt;
        Thu, 12 Jan 2023 00:56:56 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 16:59:32 +0000
Date:   Wed, 11 Jan 2023 16:59:31 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
Subject: Re: [PATCH 6/8] qemu/bswap: Add const_le64()
Message-ID: <20230111165931.00001b0c@huawei.com>
In-Reply-To: <8cb2447b-a2e6-f137-5cb3-a5439a35bb7f@linaro.org>
References: <20230111142440.24771-1-Jonathan.Cameron@huawei.com>
        <20230111142440.24771-7-Jonathan.Cameron@huawei.com>
        <8cb2447b-a2e6-f137-5cb3-a5439a35bb7f@linaro.org>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 11 Jan 2023 17:40:46 +0100
Philippe Mathieu-Daudé <philmd@linaro.org> wrote:

> On 11/1/23 15:24, Jonathan Cameron via wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Gcc requires constant versions of cpu_to_le* calls.
> > 
> > Add a 64 bit version.
> > 
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   include/qemu/bswap.h | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> > 
> > diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> > index 346d05f2aa..e1eca22f25 100644
> > --- a/include/qemu/bswap.h
> > +++ b/include/qemu/bswap.h
> > @@ -187,6 +187,15 @@ CPU_CONVERT(le, 64, uint64_t)
> >    * used to initialize static variables.
> >    */
> >   #if HOST_BIG_ENDIAN
> > +# define const_le64(_x)                          \
> > +    ((((_x) & 0x00000000000000ffU) << 56) |      \
> > +     (((_x) & 0x000000000000ff00U) << 40) |      \
> > +     (((_x) & 0x0000000000ff0000U) << 24) |      \
> > +     (((_x) & 0x00000000ff000000U) <<  8) |      \
> > +     (((_x) & 0x000000ff00000000U) >>  8) |      \
> > +     (((_x) & 0x0000ff0000000000U) >> 24) |      \
> > +     (((_x) & 0x00ff000000000000U) >> 40) |      \
> > +     (((_x) & 0xff00000000000000U) >> 56))  
> 
> So looking back at 
> https://lore.kernel.org/qemu-devel/20200917163106.49351-4-philmd@redhat.com/
> this patch missed to update the function description:
> 
>   /*
> - * Same as cpu_to_{be,le}{16,32} described below, except that gcc will
> + * Same as cpu_to_{be,le}{16,32,64} described below, except that gcc will
>    * figure the result is a compile-time constant if you pass in a constant.
>    * So this can be used to initialize static variables.
>    */

Good point.  The context is a little difference as your series had combined
several comments into one, but I've put in a similar update.

Obviously if your series lands first we can drop this one, but I'll carry
it forwards for now.

Thanks,

Jonathan

> 
> 

