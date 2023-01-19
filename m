Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3B7C004D4
	for <linux-cxl@archiver.kernel.org>; Thu, 19 Jan 2023 17:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjASRbS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 19 Jan 2023 12:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjASRbR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 19 Jan 2023 12:31:17 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7548693
        for <linux-cxl@vger.kernel.org>; Thu, 19 Jan 2023 09:31:15 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NyV1c1Mflz6J79N;
        Fri, 20 Jan 2023 01:27:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 17:31:13 +0000
Date:   Thu, 19 Jan 2023 17:31:12 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     Gregory Price <gourry.memverge@gmail.com>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <a.manzanares@samsung.com>, "Ben Widawsky" <bwidawsk@kernel.org>,
        <hchkuo@avery-design.com.tw>, <cbrowy@avery-design.com>,
        <ira.weiny@intel.com>
Subject: Re: [RFC v4 3/3] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
 and Persistent)
Message-ID: <20230119173112.00005acc@Huawei.com>
In-Reply-To: <Y8l6wYKstOB/iBzT@memverge.com>
References: <20221128150157.97724-4-gregory.price@memverge.com>
        <20221219124211.000032b7@Huawei.com>
        <Y6CNcuIzUVmKL0SM@memverge.com>
        <20221219172502.00001338@Huawei.com>
        <Y6CloIiuruB/h7qp@memverge.com>
        <20221220153453.00000436@Huawei.com>
        <Y6IMoxKZOc7eUPCg@memverge.com>
        <20230103155629.00007466@Huawei.com>
        <CAD3UvdQ7nZab7Y+tbc1Ox-zqzse4C16dwv6qtOAgfe4dA6_crQ@mail.gmail.com>
        <20230103181524.00003e14@huawei.com>
        <Y8l6wYKstOB/iBzT@memverge.com>
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

On Thu, 19 Jan 2023 12:15:45 -0500
Gregory Price <gregory.price@memverge.com> wrote:

> Found a bug, not sure how we missed this, probably happed with rebasing
> and some fixups. We're presently reporting the volatile region as
> non-volatile, 1 line patch.
> 
> Jonathan do you want a separate patch shipped or would you rather just
> apply a fixup to the commit in your current branch?
I'll fix up as I'd only squash the patch in anyway.

If tomorrow is slightly less crazy busy than today I'll push out a new
tree with this and the pass through decoders support RFC
(I'll post that to the lists as well)

Jonathan

> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 919cdf141e..1c5168e2e4 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -187,7 +187,7 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>      /* Now fill them in */
>      if (volatile_mr) {
>          rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
> -                                           true, 0);
> +                                           false, 0);
>          if (rc < 0) {
>              return rc;
>          }

