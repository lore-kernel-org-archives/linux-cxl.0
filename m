Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D2AC433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 16:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240384AbiERQlK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 12:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240408AbiERQky (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 12:40:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4662FB866
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 09:40:51 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L3JdN2fnkz6H6sW;
        Thu, 19 May 2022 00:40:40 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 18 May 2022 18:40:49 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 17:40:49 +0100
Date:   Wed, 18 May 2022 17:40:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ben.widawsky@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>
Subject: Re: [PATCH 09/14] cxl/mem: Fix CXL DVSEC Range Sizing
Message-ID: <20220518174047.00007711@Huawei.com>
In-Reply-To: <165237930521.3832067.16931437806464317011.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
        <165237930521.3832067.16931437806464317011.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Thu, 12 May 2022 11:15:05 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Per CXL 2.0 Section 8.1.3.8.4 "DVSEC CXL Range 1 Base Low" there is no
> way to specify decode sizes smaller than 256M. Fix cxl_dvsec_ranges()
> and cxl_hdm_decode_init() to account for that default decode range.

This is effectively the same as the discussion on patch 14.

My reading of the spec suggests that size can be 0 and that would mean
no access is passed on to the hardware.  It's a rather odd corner case
and would mean the device would only work with HDM decoders and might
well fail some compliance tests (I haven't checked)

It's not a corner case I care about... 

> Note, that this means that any BIOS implementation that sets mem_enable,
> but not HDM Decoder Capability enable will cause the driver to fail to
> attach. A later change validates the DVSEC ranges against platform CXL
> decode (CXL CFMWS) to make a decision about overriding the default DVSEC
> Range configuration.

> 
> Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/pci.c |   10 +++++++---
>  drivers/cxl/mem.c      |   10 +---------
>  2 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index f3e59f8b6621..f1c0677a4f52 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -236,7 +236,12 @@ int cxl_dvsec_ranges(struct cxl_dev_state *cxlds,
>  		if (rc)
>  			return rc;
>  
> -		size = (u64)temp << 32;
> +		/*
> +		 * Per CXL 2.0 Section 8.1.3.8.4 "DVSEC CXL Range 1 Base
> +		 * Low", the minimum decode size is 256MB
> +		 */
> +		size = SZ_256M;

This is not how I read the spec.  The match is base <= Addr < base + size.
If size == 0 then there are no matches as base = base + size and so the
right condition isn't met.  Maybe I'm missing something though...


> +		size |= (u64)temp << 32;
>  
>  		rc = pci_read_config_dword(
>  			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(i), &temp);
> @@ -264,8 +269,7 @@ int cxl_dvsec_ranges(struct cxl_dev_state *cxlds,
>  			.end = base + size - 1
>  		};
>  
> -		if (size)
> -			ranges++;
> +		ranges++;
>  	}
>  
>  	info->ranges = ranges;
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 902d1f6e189e..af4a88d3c5fa 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -84,15 +84,7 @@ __mock bool cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
>  			    CXL_HDM_DECODER_CTRL_OFFSET);
>  	global_enable = global_ctrl & CXL_HDM_DECODER_ENABLE;
>  
> -	/*
> -	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
> -	 * [High,Low] when HDM operation is enabled the range register values
> -	 * are ignored by the device, but the spec also recommends matching the
> -	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
> -	 * are expected even though Linux does not require or maintain that
> -	 * match.
> -	 */
> -	if (!global_enable && info->mem_enabled && info->ranges)
> +	if (!global_enable && info->mem_enabled)
>  		goto out;
>  
>  	retval = true;
> 

