Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8B4C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 17:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240846AbiERRVP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 13:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240850AbiERRU6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 13:20:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7092DD7
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 10:20:54 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L3KWZ525Qz6FGNH;
        Thu, 19 May 2022 01:20:42 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 19:20:52 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 18:20:51 +0100
Date:   Wed, 18 May 2022 18:20:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 06/14] cxl/pci: Move cxl_await_media_ready() to the core
Message-ID: <20220518182050.00000963@Huawei.com>
In-Reply-To: <CAPcyv4jkY4txmuxhTk5oebf6yhbCzrJM5okdssz9HJrnqsgXYg@mail.gmail.com>
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
        <165237928899.3832067.7236779148367594501.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20220518172121.000001c0@Huawei.com>
        <CAPcyv4jkY4txmuxhTk5oebf6yhbCzrJM5okdssz9HJrnqsgXYg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 18 May 2022 09:37:24 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Wed, May 18, 2022 at 9:21 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Thu, 12 May 2022 11:14:49 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >  
> > > Allow cxl_await_media_ready() to be mocked for testing purposes rather
> > > than carrying the maintenance burden of an indirect function call in the
> > > mainline driver.
> > >
> > > With the move cxl_await_media_ready() can no longer reuse the mailbox
> > > timeout override, so add a media_ready_timeout module parameter to the
> > > core to backfill.
> > >
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  drivers/cxl/core/pci.c        |   48 +++++++++++++++++++++++++++++++++++++++++
> > >  drivers/cxl/cxlmem.h          |    3 +--
> > >  drivers/cxl/mem.c             |    2 +-
> > >  drivers/cxl/pci.c             |   45 +-------------------------------------
> > >  tools/testing/cxl/Kbuild      |    1 +
> > >  tools/testing/cxl/test/mem.c  |    7 ------
> > >  tools/testing/cxl/test/mock.c |   15 +++++++++++++
> > >  7 files changed, 67 insertions(+), 54 deletions(-)
> > >
> > > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > > index c9a494d6976a..603945f49174 100644
> > > --- a/drivers/cxl/core/pci.c
> > > +++ b/drivers/cxl/core/pci.c
> > > @@ -1,8 +1,11 @@
> > >  // SPDX-License-Identifier: GPL-2.0-only
> > >  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> > > +#include <linux/io-64-nonatomic-lo-hi.h>  
> >
> > Curiously I see the pending branch no longer has this include
> > (which makes sense!)  
> 
> It never had it before since there were no readq calls in core/pci.c
> until this point.

I meant the cxl/pending tree seems to have a subtle difference
from what you have emailed out here in that the unnecessary extra
include isn't there.  Editorial change I guess :)

> 
> > Otherwise looks fine to me.  
> 
> Thanks!

Was thinking I'd give RB for the series, but as a few outstanding
bits and bobs I'll do it per patch.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

