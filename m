Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9571C77B7D
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 09:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjERJgz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 May 2023 05:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjERJgx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 May 2023 05:36:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC3910F5;
        Thu, 18 May 2023 02:36:52 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QMPrx0Kdkz689hv;
        Thu, 18 May 2023 17:32:33 +0800 (CST)
Received: from localhost (10.126.175.163) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 18 May
 2023 10:36:49 +0100
Date:   Thu, 18 May 2023 10:36:48 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] MAINTAINERS: Add additional reviewers for CXL
Message-ID: <20230518103648.00006e93@Huawei.com>
In-Reply-To: <20230426-cxl-fixes-v1-1-870c4c8b463a@intel.com>
References: <20230426-cxl-fixes-v1-0-870c4c8b463a@intel.com>
        <20230426-cxl-fixes-v1-1-870c4c8b463a@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.175.163]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 17 May 2023 14:28:10 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> To get better coverage add Dave Jiang and Jonathan Cameron as reviewers.
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

One comment inline though on capitalization.

Thanks,

Jonathan

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90abe83c02f3..6f8568ec2731 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5169,6 +5169,8 @@ M:	Vishal Verma <vishal.l.verma@intel.com>
>  M:	Ira Weiny <ira.weiny@intel.com>
>  M:	Ben Widawsky <bwidawsk@kernel.org>
>  M:	Dan Williams <dan.j.williams@intel.com>
> +R:	Dave Jiang <dave.jiang@intel.com>
> +R:	Jonathan Cameron <Jonathan.Cameron@Huawei.com>

For consistency go with <jonathan.cameron@huawei.com>
which is what I'm using elsewhere in maintainers and
matches other lower case entries here.
 


>  L:	linux-cxl@vger.kernel.org
>  S:	Maintained
>  F:	drivers/cxl/
> 

