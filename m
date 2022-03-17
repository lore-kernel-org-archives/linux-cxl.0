Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F99C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Mar 2022 17:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbiCQRx6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Mar 2022 13:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbiCQRx5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Mar 2022 13:53:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9361FDFEA
        for <linux-cxl@vger.kernel.org>; Thu, 17 Mar 2022 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647539560; x=1679075560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=su+YTzlmF1ib7N5bng6TP5zRQo+ixPEaTn6FJCOcF3c=;
  b=JZ2mNuQWpmRMrrUPPa3x8dUY9UioEnJw/z8csszfyGzuWBfIR79hL+oE
   YLjFNVAUOEmHaQ3VO3PkZuAgN6ryd960feeNc4kzgPcdeprEEhAIEpMAf
   TGPxYFu6xn7pdiZ6yXEGkn6VOXojf2yLkVIKJc7KNHzGgs6tJBGiIBlrO
   cKqUFFWuKbSVnlPRDDk4K6Uo/mr9wT9KDSAO4zABKjQ4GI0F2myQhzd1C
   8VBJf6dzabb4fqDpZE60T34HWgHyB+heSC0bmy73FvzYQQfL2uqOOy4Lp
   0pcKD8zRNYY1xnV8OKPviG1KyRdiVx9vIdJu30qVTdhBTAFnNVrCWU2kn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="320148698"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="320148698"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 10:52:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="821637681"
Received: from dshkut-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.229])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 10:52:37 -0700
Date:   Thu, 17 Mar 2022 10:52:28 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Krzysztof Zach <krzysztof.zach@intel.com>, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Subject: Re: [PATCH v2 4/6] cxl/pci: Make cxl_dvsec_ranges() failure not
 fatal to cxl_pci
Message-ID: <20220317175228.wpzot2nu4snc6bz6@intel.com>
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164730735869.3806189.4032428192652531946.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164730735869.3806189.4032428192652531946.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-03-14 18:22:38, Dan Williams wrote:
> cxl_dvsec_ranges(), the helper for enumerating the presence of an active
> legacy CXL.mem configuration on a CXL 2.0 Memory Expander, is not fatal
> for cxl_pci because there is still value to enable mailbox operations
> even if CXL.mem operation is disabled. Recall that the reason cxl_pci
> does this initialization and not cxl_mem is to preserve the useful
> property (for unit testing) that cxl_mem is cxl_memdev + mmio generic,
> and does not require access to a 'struct pci_dev' to issue config
> cycles.
> 
> Update 'struct cxl_endpoint_dvsec_info' to carry either a positive
> number of non-zero size legacy CXL DVSEC ranges, or the negative error
> code from __cxl_dvsec_ranges() in its @ranges member.
> 
> Reported-by: Krzysztof Zach <krzysztof.zach@intel.com>
> Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/pci.c |   27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 257cf735505d..994c79bf6afd 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -463,13 +463,18 @@ static int wait_for_media_ready(struct cxl_dev_state *cxlds)
>  	return 0;
>  }
>  
> -static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
> +/*
> + * Return positive number of non-zero ranges on success and a negative
> + * error code on failure. The cxl_mem driver depends on ranges == 0 to
> + * init HDM operation.
> + */

It shouldn't depend on 0 ranges, it depends on ranges matching existing HDM
decoder ranges. I took a shortcut by just checking global enable originally
because we didn't yet have code to enumerate decoders (anything else would be a
crazy BIOS bug that's probably not worth working around).

> +static int __cxl_dvsec_ranges(struct cxl_dev_state *cxlds,
> +			      struct cxl_endpoint_dvsec_info *info)
>  {
> -	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	int hdm_count, rc, i, ranges = 0;
>  	struct device *dev = &pdev->dev;
>  	int d = cxlds->cxl_dvsec;
> -	int hdm_count, rc, i;
>  	u16 cap, ctrl;
>  
>  	if (!d) {
> @@ -546,10 +551,17 @@ static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
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
> @@ -618,10 +630,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
