Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B06C77B7A
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 09:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjESJVj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 05:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjESJVh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 05:21:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086DD19A
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 02:21:35 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QN1XT63zzz67nWm;
        Fri, 19 May 2023 17:20:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 19 May
 2023 10:21:32 +0100
Date:   Fri, 19 May 2023 10:21:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud?= =?ISO-8859-1?Q?=E9?= 
        <philmd@linaro.org>, Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, "Thomas Huth" <thuth@redhat.com>
Subject: Re: [PATCH v5 6/6] hw/cxl: Add clear poison mailbox command
 support.
Message-ID: <20230519102132.00007a15@Huawei.com>
In-Reply-To: <20230519030515-mutt-send-email-mst@kernel.org>
References: <20230423162013.4535-1-Jonathan.Cameron@huawei.com>
        <20230423162013.4535-7-Jonathan.Cameron@huawei.com>
        <20230519030515-mutt-send-email-mst@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index ab600735eb..a247f506b7 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -947,6 +947,42 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
> >       */
> >  }
> >  
> > +static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
> > +{
> > +    MemoryRegion *vmr = NULL, *pmr = NULL;
> > +    AddressSpace *as;
> > +
> > +    if (ct3d->hostvmem) {
> > +        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> > +    }
> > +    if (ct3d->hostpmem) {
> > +        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> > +    }
> > +
> > +    if (!vmr && !pmr) {
> > +        return false;
> > +    }
> > +
> > +    if (dpa_offset + 64 > int128_get64(ct3d->cxl_dstate.mem_size)) {
> > +        return false;
> > +    }  
> 
> Fails build:
> 
> https://gitlab.com/mstredhat/qemu/-/jobs/4313193004

Fix is just dropping the int128_get64 and accessing directly.

Looks like a wrong 'fix' for the wrong type of size variable (the others
are all replaced now with the mem_region access functions).

I'll send a v6 shortly.

Thanks,

Jonathan
