Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C152C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Mar 2022 11:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352363AbiCYL4Y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Mar 2022 07:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349840AbiCYL4W (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Mar 2022 07:56:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D27AE75
        for <linux-cxl@vger.kernel.org>; Fri, 25 Mar 2022 04:54:49 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KQ0q233WQz684Xd;
        Fri, 25 Mar 2022 19:53:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 25 Mar 2022 12:54:47 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 11:54:47 +0000
Date:   Fri, 25 Mar 2022 11:54:45 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ben.widawsky@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v2 6/6] cxl/mem: Replace redundant debug message with a
 comment
Message-ID: <20220325115445.00000e4f@huawei.com>
In-Reply-To: <164730736948.3806189.17828261054974867700.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164730736948.3806189.17828261054974867700.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 14 Mar 2022 18:22:49 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> cxl_mem_probe() already emits a log message when HDM operation can not
> be established. Delete the similar one in cxl_hdm_decode_init().
> 
> What is less obvious is why global_ctrl being enabled makes positive
> values of info->ranges irrelevant.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Assuming comment on ignore recommendation added for v3.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/mem.c |   13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 3baae1332760..6def7d7b6bfd 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -107,11 +107,16 @@ __mock bool cxl_hdm_decode_init(struct cxl_dev_state *cxlds)
>  	global_ctrl = readl(crb + cmap->hdm_decoder.offset +
>  			    CXL_HDM_DECODER_CTRL_OFFSET);
>  	global_enable = global_ctrl & CXL_HDM_DECODER_ENABLE;
> -	if (!global_enable && info->ranges) {
> -		dev_dbg(cxlds->dev,
> -			"DVSEC ranges already programmed and HDM decoders not enabled.\n");
> +
> +	/*
> +	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
> +	 * [High,Low] when HDM operation is enabled the range register values
> +	 * are ignored by the device, but the spec also recommends matching the
> +	 * DVSEC Range 1,2 to HDM Decoder Range 0,1 so, non-zero info->ranges
> +	 * are expected.
> +	 */
> +	if (!global_enable && info->ranges)
>  		goto out;
> -	}
>  
>  	retval = true;
>  
> 

