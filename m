Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EE2CA0EC3
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Sep 2023 12:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbjILMiU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Sep 2023 08:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbjILMiH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Sep 2023 08:38:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0755A10DB
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 05:37:54 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlNQB09FWz6K6Mc;
        Tue, 12 Sep 2023 20:37:22 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 13:37:51 +0100
Date:   Tue, 12 Sep 2023 13:37:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     Gregory Price <gourry.memverge@gmail.com>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>, <junhee.ryu@sk.com>,
        <kwangjin.ko@sk.com>
Subject: Re: [PATCH 5/5] cxl/vendor: SK hynix Niagara Multi-Headed SLD
 Device
Message-ID: <20230912133750.000036bb@Huawei.com>
In-Reply-To: <ZPdRjVjbbe9DkHW5@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
        <20230901012914.226527-6-gregory.price@memverge.com>
        <20230906140445.00002acd@Huawei.com>
        <ZPdRjVjbbe9DkHW5@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 5 Sep 2023 12:04:29 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Wed, Sep 06, 2023 at 02:04:45PM +0100, Jonathan Cameron wrote:
> > On Thu, 31 Aug 2023 21:29:14 -0400
> > Gregory Price <gourry.memverge@gmail.com> wrote:
> > 
> > Hi Gregory,
> > 
> > Some comments inline, but I'm happy to add this to my staging tree in the meantime
> > as it stands (might be a few days until I push a new branch though).
> >   
> 
> I'm going to do one a quick v3 today with the feedback and some cleanup
> in spots i noticed.
> 
> > > Signed-off-by: Gregory Price <gregory.price@memverge.com>
> > > Signed-off-by: Junhee Ryu <junhee.ryu@sk.com>
> > > Signed-off-by: Kwangjin Ko <kwangjin.ko@sk.com>  
> > 
> > The SoB chain needs cleaning up.  Is this a co-developed situation?
> > If it is use the rules in the kernel documentation as I don't think those
> > are yet clearly stated in QEMU docs (and they are confusing so I won't try
> > to restate them here).
> >   
> 
> TL;DR: They gave me the command list, I wrote the model.  We got
> approval to release the model, but I wasn't sure how to capture the
> copyright/SoB list.  I suppose the copyright covers SKh, but since I
> authored the model, it only requires my SoB?

Yes - I think only your SoB is fine.  Maybe some text to explain the other
parts.

> 
> After reading, I'm still not sure how to capture this lol.
> 
> Should I just switch the skh folks to Co-developed-by?
> 
> >   
> > > diff --git a/hw/cxl/vendor/skhynix/meson.build b/hw/cxl/vendor/skhynix/meson.build
> > > new file mode 100644
> > > index 0000000000..4e57db65f1
> > > --- /dev/null
> > > +++ b/hw/cxl/vendor/skhynix/meson.build
> > > @@ -0,0 +1 @@
> > > +system_ss.add(when: 'CONFIG_CXL_VENDOR', if_true: files('skhynix_niagara.c',))
> > > diff --git a/hw/cxl/vendor/skhynix/skhynix_niagara.c b/hw/cxl/vendor/skhynix/skhynix_niagara.c
> > > new file mode 100644
> > > index 0000000000..88e53cc6cc
> > > --- /dev/null
> > > +++ b/hw/cxl/vendor/skhynix/skhynix_niagara.c
> > > @@ -0,0 +1,516 @@
> > > +/*
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + *
> > > + * Copyright (c) 2023 MemVerge Inc.
> > > + * Copyright (c) 2023 SK hynix Inc.
> > > + */
> > > +
> > > +#include <sys/shm.h>  
> > 
> > This will need some osdep.h magic.  There is some there
> > already but it will need relaxing (unless you want to run only on sparc ;)
> > and we may need to make this device linux host only.
> > 
> >   
> 
> Good point, I had not considered osdep issues.  Do you know of any
> examples of linux-only devices I can use to do a quick patch-up? I 
> can come back around on this issue later.

No idea.

> 
> >   
> > > +
> > > +enum {
> > > +    NIAGARA_MHD = 0x55,
> > > +        #define GET_MHD_INFO 0x0  
> > 
> > Is this standard as it's in the normal space?
> > If it is then I'd like the implementation pushed down to the
> > type3 implementation (with some callbacks or similar.)
> >   
> 
> :thinking_face:
> 
> maybe a similar pattern to the callback from before? I suppose I could
> push this down into type3 and add an mhd callback in the class and have
> niagara fill that in with the callback.
> 
> That *feels* right, so i'll go ahead with it.
> 
> 
> 
> If I misunderstood anything, let me know
> 
> ~Gregory

