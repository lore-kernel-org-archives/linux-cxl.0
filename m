Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F33EC001B0
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Jul 2023 08:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjGLIyE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Jul 2023 04:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjGLIx7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Jul 2023 04:53:59 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9A2127
        for <linux-cxl@vger.kernel.org>; Wed, 12 Jul 2023 01:53:53 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R1BKG4Yryz67jmd;
        Wed, 12 Jul 2023 16:50:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 12 Jul
 2023 09:53:50 +0100
Date:   Wed, 12 Jul 2023 09:53:49 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Adam Manzanares <a.manzanares@samsung.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl: Update MAINTAINERS
Message-ID: <20230712095349.00003693@Huawei.com>
In-Reply-To: <11d50b02-4936-40f2-9071-51d511ff6886@nmtadam.samsung>
References: <CGME20230711224403uscas1p1b4b82b803ddd0cc47ec02ddf574aa604@uscas1p1.samsung.com>
        <168911543699.1871721.9186039943252294173.stgit@dwillia2-xfh.jf.intel.com>
        <11d50b02-4936-40f2-9071-51d511ff6886@nmtadam.samsung>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 11 Jul 2023 22:49:11 +0000
Adam Manzanares <a.manzanares@samsung.com> wrote:

> On Tue, Jul 11, 2023 at 03:43:57PM -0700, Dan Williams wrote:
> > Ben, thank you for all the work to get the CXL subsystem off the ground
> > and establishing QEMU as a place where hardware vendors can collaborate
> > on the new advancements and mechanisms appearing in the CXL
> > specification.
> >   
> 
> +1
> 
> > Jonathan, thank you for your continued review and collaboration, you have
> > been a defacto CXL maintainer for a while now.
> >  
> 
> +1
> 
> > Davidlohr, thank you for getting the background command infrastructure
> > off the ground and your leadership on and off the lists.  
> 
> +1
> 
> > 
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Cc: Ben Widawsky <bwidawsk@kernel.org>
> > Cc: Adam Manzanares <a.manzanares@samsung.com>
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  MAINTAINERS |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3be1bdfe8ecc..eba395274018 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5140,10 +5140,11 @@ S:	Maintained
> >  F:	include/linux/compiler_attributes.h
> >  
> >  COMPUTE EXPRESS LINK (CXL)
> > +M:	Davidlohr Bueso <dave@stgolabs.net>
> > +M:	Jonathan Cameron <jonathan.cameron@huawei.com>
> >  M:	Alison Schofield <alison.schofield@intel.com>
> >  M:	Vishal Verma <vishal.l.verma@intel.com>
> >  M:	Ira Weiny <ira.weiny@intel.com>
> > -M:	Ben Widawsky <bwidawsk@kernel.org>
> >  M:	Dan Williams <dan.j.williams@intel.com>
> >  L:	linux-cxl@vger.kernel.org
> >  S:	Maintained
> >  
> 
> 
> Looks good.
> 
> Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>

Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>

