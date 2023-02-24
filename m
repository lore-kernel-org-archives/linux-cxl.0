Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9742C678D5
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Feb 2023 15:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjBXPfQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Feb 2023 10:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjBXPfO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Feb 2023 10:35:14 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537BC6A9E6
        for <linux-cxl@vger.kernel.org>; Fri, 24 Feb 2023 07:35:11 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PNYB24Wzlz67Hqp;
        Fri, 24 Feb 2023 23:06:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 24 Feb
 2023 15:10:55 +0000
Date:   Fri, 24 Feb 2023 15:10:55 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Philippe =?ISO-8859-1?Q?Mathie?= =?ISO-8859-1?Q?u-Daud=E9?= 
        <philmd@linaro.org>, Mike Maslenkin <mike.maslenkin@gmail.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Dave Jiang" <dave.jiang@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH 1/6] hw/cxl: Move enum ret_code definition to
 cxl_device.h
Message-ID: <20230224151055.000071f3@Huawei.com>
In-Reply-To: <63f5742b15896_1dd2fc294da@iweiny-mobl.notmuch>
References: <20230217181812.26995-1-Jonathan.Cameron@huawei.com>
        <20230217181812.26995-2-Jonathan.Cameron@huawei.com>
        <63f5742b15896_1dd2fc294da@iweiny-mobl.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 21 Feb 2023 17:47:23 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> Jonathan Cameron wrote:
> > Needs tidy up and rename to something more generic now it is
> > in a header.  
> 
> I'm not opposed to this change and patch 2 but I don't see where
> CXLRetCode is being used outside of cxl-mailbox-utils.c in this series.
> 
> Despite that reservation I think this is a good clarification.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Ah.  This is a mess due to patch reordering as this was originally
meant as a precursor for your event injection series then I had to drag
it forwards to here to avoid introducing more use of the old naming.

Let me see if I can swap it round and just do the rename in this series
and push the move back to the start of that series - which I'll post
soon.

As it's the same code changes in a different order I'll pick up your RB.
Give me a shout if you'd rather I didn't!

Thanks,

Jonathan



> 
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  | 28 ----------------------------
> >  include/hw/cxl/cxl_device.h | 28 ++++++++++++++++++++++++++++
> >  2 files changed, 28 insertions(+), 28 deletions(-)
> >   

