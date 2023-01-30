Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C19DC54EAA
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 13:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjA3NL5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 08:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjA3NL4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 08:11:56 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF7F5B9D
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 05:11:54 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P57pk5gz7z6880d;
        Mon, 30 Jan 2023 21:10:54 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 13:11:51 +0000
Date:   Mon, 30 Jan 2023 13:11:50 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        <alison.schofield@intel.com>, <dave@stgolabs.net>,
        <a.manzanares@samsung.com>, <bwidawsk@kernel.org>,
        <gregory.price@memverge.com>, <hchkuo@avery-design.com.tw>,
        <cbrowy@avery-design.com>, <ira.weiny@intel.com>
Subject: Re: [RFC v4 2/3] tests/qtest/cxl-test: whitespace, line ending
 cleanup
Message-ID: <20230130131150.000023a1@huawei.com>
In-Reply-To: <20230105143807.0000315a@huawei.com>
References: <20221128150157.97724-1-gregory.price@memverge.com>
        <20221128150157.97724-3-gregory.price@memverge.com>
        <20230105143807.0000315a@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 5 Jan 2023 14:38:07 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Mon, 28 Nov 2022 10:01:56 -0500
> Gregory Price <gourry.memverge@gmail.com> wrote:
> 
> > Defines are starting to exceed line length limits, align them for
> > cleanliness before making modifications.
> > 
> > Signed-off-by: Gregory Price <gregory.price@memverge.com>  
> 
> Hi Gregory,
> 
> I was just reordering my tree and noticed that you've only
> gone with 2 space indent.  Given 4 spaces is the convention in QEMU
> for other uses, I've switched my local copy of this over to 4 spaces.
> 
> Note there was also a single inconsistent 1 space indent - see below.
> 
> Jonathan
> 
> > 
> > ---
> >  tests/qtest/cxl-test.c | 99 +++++++++++++++++++++++-------------------
> >  1 file changed, 54 insertions(+), 45 deletions(-)
> > 
> > diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> > index c54f18e76b..e59ba22387 100644
> > --- a/tests/qtest/cxl-test.c
> > +++ b/tests/qtest/cxl-test.c
> > @@ -8,55 +8,64 @@
> >  #include "qemu/osdep.h"
> >  #include "libqtest-single.h"
> >  
> > -#define QEMU_PXB_CMD "-machine q35,cxl=on " \
> > -                     "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
> > -                     "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G "
> > -
> > -#define QEMU_2PXB_CMD "-machine q35,cxl=on "                            \
> > -                      "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
> > -                      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
> > -                      "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
> > -
> > -#define QEMU_VIRT_2PXB_CMD "-machine virt,cxl=on "                      \
> > -                      "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
> > -                      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 "  \
> > -                      "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
> > -
> > -#define QEMU_RP "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
> > +#define QEMU_PXB_CMD \
> > +  "-machine q35,cxl=on " \
> > +  "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
> > +  "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G "
> > +
> > +#define QEMU_2PXB_CMD \
> > +  "-machine q35,cxl=on " \
> > +  "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
> > +  "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
> > + "- M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "  
> This one only has one space.
It also has a space after the - that I somehow missed. Fixed up in the version I'm
carrying. Will push out a new tree once I've caught up with some other pending items.
