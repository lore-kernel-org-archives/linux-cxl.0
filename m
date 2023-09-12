Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94E1CA0ECA
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Sep 2023 11:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbjILLAJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Sep 2023 07:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjILK72 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Sep 2023 06:59:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AEDBE
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 03:59:23 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlL7l59fJz6J7p0;
        Tue, 12 Sep 2023 18:54:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 11:59:20 +0100
Date:   Tue, 12 Sep 2023 11:59:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Fan Ni <fan.ni@gmx.us>
CC:     Davidlohr Bueso <dave@stgolabs.net>, <fan.ni@samsung.com>,
        <dan.j.williams@intel.com>, <alison.schofield@intel.com>,
        <ayush.m55@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/4] cxl/type3: Fix crash in set_cacheline()
Message-ID: <20230912115919.00005897@Huawei.com>
In-Reply-To: <ZPtp63VmaKHl+G+K@debian>
References: <20230908073152.4386-1-dave@stgolabs.net>
        <20230908073152.4386-2-dave@stgolabs.net>
        <ZPtp63VmaKHl+G+K@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 8 Sep 2023 11:37:31 -0700
Fan Ni <fan.ni@gmx.us> wrote:

> On Fri, Sep 08, 2023 at 12:31:49AM -0700, Davidlohr Bueso wrote:
> > Use the correct vmr_size, otherwise a clear poison operation, for
> > example, can crash the emulator.
> >
> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > ---
> >  hw/mem/cxl_type3.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index fd9d134d468f..b90a7397d62f 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -1417,7 +1417,7 @@ static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
> >          as = &ct3d->hostvmem_as;
> >      } else if (dpa_offset < vmr_size + pmr_size) {
> >          as = &ct3d->hostpmem_as;
> > -        dpa_offset -= vmr->size;
> > +        dpa_offset -= vmr_size;  
> 
> Good catch. It is a typo from my DCD patch, not upstreamed yet.
In meantime I squish this into the version of your series I'm carrying and
push out a new tree later today.

Thanks,

Jonathan

> 
> Fan
> >      } else {
> >          as = &ct3d->dc.host_dc_as;
> >          dpa_offset -= (vmr_size + pmr_size);
> > --
> > 2.42.0
> >  

