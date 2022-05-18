Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD89C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 17:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240961AbiERRWi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 13:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240847AbiERRWf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 13:22:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B4DA0D12
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 10:22:33 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L3KV84VcLz67KdQ;
        Thu, 19 May 2022 01:19:28 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 19:22:31 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 18:22:30 +0100
Date:   Wed, 18 May 2022 18:22:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ben.widawsky@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>
Subject: Re: [PATCH 03/14] cxl/pci: Drop wait_for_valid() from
 cxl_await_media_ready()
Message-ID: <20220518182229.00002908@Huawei.com>
In-Reply-To: <165237927263.3832067.8250303240842350003.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
        <165237927263.3832067.8250303240842350003.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Thu, 12 May 2022 11:14:32 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> A check mem_info_valid already happens in __cxl_dvsec_ranges(). Rely on
> that instead of calling wait_for_valid again.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/pci.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 435f9f89b793..91b266911e52 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -431,10 +431,6 @@ static int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  	u64 md_status;
>  	int rc, i;
>  
> -	rc = wait_for_valid(cxlds);
> -	if (rc)
> -		return rc;
> -
>  	for (i = mbox_ready_timeout; i; i--) {
>  		u32 temp;
>  
> 

