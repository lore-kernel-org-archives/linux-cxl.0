Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29305C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Mar 2022 16:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241928AbiCJQ5e (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Mar 2022 11:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiCJQ5d (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 10 Mar 2022 11:57:33 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358E7192E25
        for <linux-cxl@vger.kernel.org>; Thu, 10 Mar 2022 08:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646931392; x=1678467392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ahOMeBeiUmSCC4qb0b4zQnxLhHRMrhlTjLunAjJ6luQ=;
  b=YcPlKFnfQ9oPV9X4zJwlxkYyhcW+qFZHBeND5zaTwdSStbwRzMxfjac+
   xTzLZ1NSsopOLUnhEn+JGJrYj4q7ib8OggL0gC3QjxX2gcOJgcWKxOUYg
   FkxmOhM4/YogSKGzXCL0LgNuJNikeBsB1nkxKMLmluJ9zbMZx++HNrTLs
   8mATyHv90MwGTn87JBw9TKo6WSSyai5bOeBGoumRwJodhsdBsepDxPhDz
   aEONS7gXQ9WGdDFgdUCKg7yK2w1AwPeGhF5B6YIZWK4MBPIfrtvt4kurt
   lyMjMk/YuGMSwBTCKuUoFa0MwGv99AqJg5aHYfnQBh6SFnAvFmlOk7O03
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="318528643"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="318528643"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 08:56:31 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="554726658"
Received: from vrgangil-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.130.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 08:56:31 -0800
Date:   Thu, 10 Mar 2022 08:56:30 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Krzysztof Zach <krzysztof.zach@intel.com>,
        Jonathan.Cameron@huawei.com
Subject: Re: [PATCH 2/2] cxl/pci: Preserve mailbox access after DVSEC probe
 failure
Message-ID: <20220310165630.ui5hxo5oljmyulux@intel.com>
References: <164690155138.3326488.16049914482944930295.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164690156234.3326488.1880097554956913603.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164690156234.3326488.1880097554956913603.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-03-10 00:39:22, Dan Williams wrote:
> The cxl_pci driver is tasked with establishing mailbox communications
> with a CXL Memory Expander and then building a cxl_memdev to represent
> the CXL.mem component of the device. Part of that construction involves
> probing the CXL DVSEC to discover the state of CXL.mem resources on the
> card and whether legacy "range registers" are enabled instead of the HDM
> decoder expectation.
> 
> If that CXL DVSEC probe fails there is still value in preserving cxl_pci
> operations to access the mailbox, or otherwise attempt to debug / repair
> CXL.mem operation.
> 
> Add debug to indicate the reason for CXL DVSEC probe failures, and do
> not fail cxl_pci probe on those failures. Cleanup
> cxl_dvsec_decode_init() to make it clear that any non-zero value of
> info->ranges is a reason to not proceed with enabling HDM operation.

Could you please break the debug message additions into a separate patch? I'm
prepared to slap an r-b on those now. The rest requires more brain power than I
have currently.

> 
> Reported-by: Krzysztof Zach <krzysztof.zach@intel.com>
> Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/mem.c |   20 +++++++++-----------
>  drivers/cxl/pci.c |   40 ++++++++++++++++++++++++++++------------
>  2 files changed, 37 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index cd4e8bba82aa..9363107b438e 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -84,7 +84,7 @@ __mock bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
>  	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
>  	struct cxl_register_map map;
>  	struct cxl_component_reg_map *cmap = &map.component_map;
> -	bool global_enable, do_hdm_init = false;
> +	bool global_enable, do_hdm_init = true;
>  	void __iomem *crb;
>  	u32 global_ctrl;
>  
> @@ -104,26 +104,24 @@ __mock bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
>  	global_ctrl = readl(crb + cmap->hdm_decoder.offset +
>  			    CXL_HDM_DECODER_CTRL_OFFSET);
>  	global_enable = global_ctrl & CXL_HDM_DECODER_ENABLE;
> -	if (!global_enable && info->ranges) {
> +	if (global_enable)
> +		goto out;
> +
> +	if (info->ranges != 0) {
>  		dev_dbg(cxlds->dev,
>  			"DVSEC ranges already programmed and HDM decoders not enabled.\n");
> +		do_hdm_init = false;
>  		goto out;
>  	}
>  
> -	do_hdm_init = true;
> -
>  	/*
>  	 * Permanently (for this boot at least) opt the device into HDM
>  	 * operation. Individual HDM decoders still need to be enabled after
>  	 * this point.
>  	 */
> -	if (!global_enable) {
> -		dev_dbg(cxlds->dev, "Enabling HDM decode\n");
> -		writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
> -		       crb + cmap->hdm_decoder.offset +
> -			       CXL_HDM_DECODER_CTRL_OFFSET);
> -	}
> -
> +	dev_dbg(cxlds->dev, "Enabling HDM decode\n");
> +	writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
> +	       crb + cmap->hdm_decoder.offset + CXL_HDM_DECODER_CTRL_OFFSET);
>  out:
>  	iounmap(crb);
>  	return do_hdm_init;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 8a7267d116b7..2e482969c147 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -463,16 +463,24 @@ static int wait_for_media_ready(struct cxl_dev_state *cxlds)
>  	return 0;
>  }
>  
> -static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
> +/*
> + * Return positive number of non-zero ranges on success and a negative
> + * error code on failure. The cxl_mem driver depends on ranges == 0 to
> + * init HDM operation.
> + */
> +static int __cxl_dvsec_ranges(struct cxl_dev_state *cxlds,
> +			    struct cxl_endpoint_dvsec_info *info)
>  {
> -	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	int hdm_count, rc, i, ranges = 0;
> +	struct device *dev = &pdev->dev;
>  	int d = cxlds->cxl_dvsec;
> -	int hdm_count, rc, i;
>  	u16 cap, ctrl;
>  
> -	if (!d)
> +	if (!d) {
> +		dev_dbg(dev, "No DVSEC Capability\n");
>  		return -ENXIO;
> +	}
>  
>  	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CAP_OFFSET, &cap);
>  	if (rc)
> @@ -482,8 +490,10 @@ static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
>  	if (rc)
>  		return rc;
>  
> -	if (!(cap & CXL_DVSEC_MEM_CAPABLE))
> +	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
> +		dev_dbg(dev, "Not MEM Capable\n");
>  		return -ENXIO;
> +	}
>  
>  	/*
>  	 * It is not allowed by spec for MEM.capable to be set and have 0 legacy
> @@ -496,8 +506,10 @@ static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
>  		return -EINVAL;
>  
>  	rc = wait_for_valid(cxlds);
> -	if (rc)
> +	if (rc) {
> +		dev_dbg(dev, "Failure awaiting MEM_INFO_VALID (%d)\n", rc);
>  		return rc;
> +	}
>  
>  	info->mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
>  
> @@ -539,10 +551,17 @@ static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
>  		};
>  
>  		if (size)
> -			info->ranges++;
> +			ranges++;
>  	}
>  
> -	return 0;
> +	return ranges;
> +}
> +
> +static void cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
> +
> +	info->ranges = __cxl_dvsec_ranges(cxlds, info);
>  }
>  
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> @@ -611,10 +630,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_dvsec_ranges(cxlds);
> -	if (rc)
> -		dev_warn(&pdev->dev,
> -			 "Failed to get DVSEC range information (%d)\n", rc);
> +	cxl_dvsec_ranges(cxlds);
>  
>  	cxlmd = devm_cxl_add_memdev(cxlds);
>  	if (IS_ERR(cxlmd))
> 
