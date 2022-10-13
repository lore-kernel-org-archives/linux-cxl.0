Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C401C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Oct 2022 10:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJMK4w (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Oct 2022 06:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJMK4u (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Oct 2022 06:56:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42642FC1FF
        for <linux-cxl@vger.kernel.org>; Thu, 13 Oct 2022 03:56:49 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mp5wy16whz67K2K;
        Thu, 13 Oct 2022 18:53:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Thu, 13 Oct 2022 12:56:46 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 13 Oct
 2022 11:56:46 +0100
Date:   Thu, 13 Oct 2022 11:56:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>,
        Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
        Chris Browy <cbrowy@avery-design.com>, <linuxarm@huawei.com>,
        <ira.weiny@intel.com>
Subject: Re: [PATCH v7 4/5] hw/mem/cxl-type3: Add CXL CDAT Data Object
 Exchange
Message-ID: <20221013115645.00002873@huawei.com>
In-Reply-To: <Y0bk8g2zn2tpUS3a@memverge.com>
References: <20221007152156.24883-1-Jonathan.Cameron@huawei.com>
        <20221007152156.24883-5-Jonathan.Cameron@huawei.com>
        <Y0bk8g2zn2tpUS3a@memverge.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 12 Oct 2022 12:01:54 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> This code contains heap corruption on free, and I think should be
> refactored to pre-allocate all the entries we're interested in putting
> into the table.  This would flatten the code and simplify the error
> handling steps.
> 
> Also, should we consider making a union with all the possible entries to
> make entry allocation easier?  It may eat a few extra bytes of memory,
> but it would simplify the allocation/cleanup code here further.
> 
> Given that every allocation has to be checked, i'm also not convinced
> the use of g_autofree is worth the potential footguns associated with
> it.
> 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 568c9d62f5..3fa5d70662 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -12,9 +12,218 @@
> > +static int ct3_build_cdat_table(CDATSubHeader ***cdat_table,
> > +                                void *priv)
> > +{  
> (snip)
> > +        /* For now, no memory side cache, plausiblish numbers */
> > +        dslbis_nonvolatile = g_malloc(sizeof(*dslbis_nonvolatile) * dslbis_nonvolatile_num);
> > +        if (!dslbis_nonvolatile)
> > +            return -ENOMEM;  
> 
> this allocation creates a table of entries, which is later freed
> incorrectly
> 
> > +
> > +    *cdat_table = g_malloc0(len * sizeof(*cdat_table));  
> 
> this allocation needs to be checked
I just realized that sizeof should be sizeof(**cdat_table)

I've moved to a local autofree pointer after factoring out the
guts of the code so this gets simpler anyway (and was more obviously wrong!)

Jonathan
