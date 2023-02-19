Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F37C61DA4
	for <linux-cxl@archiver.kernel.org>; Sun, 19 Feb 2023 15:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjBSPZd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 19 Feb 2023 10:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjBSPZc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 19 Feb 2023 10:25:32 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581F2FF01
        for <linux-cxl@vger.kernel.org>; Sun, 19 Feb 2023 07:25:31 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PKTpZ1kkGz67PTQ;
        Sun, 19 Feb 2023 23:23:34 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Sun, 19 Feb
 2023 15:25:28 +0000
Date:   Sun, 19 Feb 2023 15:25:27 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        "Mike Maslenkin" <mike.maslenkin@gmail.com>,
        Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 8/8] hw/mem/cxl_type3: Add CXL RAS Error Injection
 Support.
Message-ID: <20230219152527.00005c5f@huawei.com>
In-Reply-To: <b99089d3-d271-14c5-fb8d-c4f0437847cb@intel.com>
References: <20230217172924.25239-1-Jonathan.Cameron@huawei.com>
        <20230217172924.25239-9-Jonathan.Cameron@huawei.com>
        <b99089d3-d271-14c5-fb8d-c4f0437847cb@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


> >   static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
> >                              unsigned size)
> >   {
> > @@ -341,6 +402,83 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
> >           should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
> >           which_hdm = 0;
> >           break;
> > +    case A_CXL_RAS_UNC_ERR_STATUS:
> > +    {
> > +        uint32_t capctrl = ldl_le_p(cache_mem + R_CXL_RAS_ERR_CAP_CTRL);
> > +        uint32_t fe = FIELD_EX32(capctrl, CXL_RAS_ERR_CAP_CTRL, FIRST_ERROR_POINTER);
> > +        CXLError *cxl_err;
> > +        uint32_t unc_err;
> > +
> > +        /*
> > +         * If single bit written that corresponds to the first error
> > +         * pointer being cleared, update the status and header log.
> > +         */
> > +        if (!QTAILQ_EMPTY(&ct3d->error_list)) {
> > +            if ((1 << fe) ^ value) {
> > +                CXLError *cxl_next;
> > +                /*
> > +                 * Software is using wrong flow for multiple header recording
> > +                 * Following behaviour in PCIe r6.0 and assuming multiple
> > +                 * header support. Imdef choice to clear all matching records  
> 
> What does "Imdef" mean?

Good spot. Should have been Impdef, but there is no reason not to spell it out
as "Implementation defined".
What I'm trying to indicate here is that the PCIe r6.0 base specification lets
hardware do one of several different things.  I picked one of those options.

In PCIe it's a little less critical than in CXL as there is an explicit opt in
so you can expect software to do the right thing.  Unfortunately not so for
CXL where we have to assume the capability being there means the hardware will
do it.  I guess there was no need for backwards compatibility for CXL.

Jonathan

> 
> DJ
