Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E14C7EE2F
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Mar 2023 10:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjCCKED (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Mar 2023 05:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjCCKEC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Mar 2023 05:04:02 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4A71166C
        for <linux-cxl@vger.kernel.org>; Fri,  3 Mar 2023 02:04:01 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PSk5R3NGDz6JB1R;
        Fri,  3 Mar 2023 18:01:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 3 Mar
 2023 10:03:58 +0000
Date:   Fri, 3 Mar 2023 10:03:58 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 4/6] hw/cxl: QMP based poison injection support
Message-ID: <20230303100358.00007f66@Huawei.com>
In-Reply-To: <6401446d8d8dc_46c602942@iweiny-mobl.notmuch>
References: <20230302101710.1652-1-Jonathan.Cameron@huawei.com>
        <20230302101710.1652-5-Jonathan.Cameron@huawei.com>
        <6401446d8d8dc_46c602942@iweiny-mobl.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


> > +    memset(out, 0, out_pl_len);
> > +    QLIST_FOREACH(ent, poison_list, node) {
> > +        uint64_t start, stop;
> > +
> > +        /* Check for no overlap */
> > +        if (ent->start >= query_start + query_length ||
> > +            ent->start + ent->length <= query_start) {
> > +            continue;
> > +        }
> > +
> > +        /* Deal with overlap */
> > +        start = MAX(ent->start & 0xffffffffffffffc0, query_start);
> > +        stop = MIN((ent->start & 0xffffffffffffffc0) + ent->length,
> > +                   query_start + query_length);
> > +        stq_le_p(&out->records[i].addr, start | (ent->type & 0x3));  
> 
> Shouldn't the mask here be 0x7?  I see we have not define Vendor Specific
> which I think is good but maybe better to allow it here?  I'm just not
> sure what is going to happen if someone comes along later and wants to
> use that value.

As things stand there is no way to inject a vendor defined poison entry
so expanding the mask has no affect.  However, it'll be one less change needed
if we ever add that support to the qmp interface so I'll make the change
as I'm respinning for your other feedback.

Given we've not supported anything vendor defined yet, I'm not that bothered
about adding the qmp support any time soon ;)

+ where else can poison come from?  It's either in the device or it's not
or it doesn't exist and was injected.  I'll be interested to see the arguement
for another source unless vendor defined really means 'I don't know'.

Thanks for the review and eagle eyed register checking :)

Jonathan



