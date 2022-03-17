Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2767C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Mar 2022 17:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236962AbiCQRi3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Mar 2022 13:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiCQRi2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Mar 2022 13:38:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A489216FBE
        for <linux-cxl@vger.kernel.org>; Thu, 17 Mar 2022 10:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647538631; x=1679074631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1XOO1yw2fVgNJqKtvUGTTHWU3HePWz/tyZyaqrEdEJY=;
  b=kYxJlkhr+5Y5HY71cLF/LY1xLqj2QL0N9sjfSgM0n9n0RchiHDyp1Kas
   fyVUlXkfHmLGn09SwlkGNf02kj0Btz5rs9r/E4AFranMPbWWJnnoMlFIg
   4qXkMAWaImA5SrCmPWGKsRmZM1QuRsfXMQCP116sDLDGYb6TYLfpRyGqj
   mHZcgnnvWfwlFyvLtkiPjYFssbPozf9J9z462hy/PsNEM/JsVt5CtA3Lh
   rg3lZPAWKFVZhFuj3wjlFC8WaDku+cl0+0U5UtYVNNZZpTgfmM0oqCiko
   m3XVZbRPVBhjs5Ur2P1JQcF54dhN3W8bOkh3cbUbmB5kIytoxvhzvwxx1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="256879836"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="256879836"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 10:36:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="599179466"
Received: from dshkut-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.229])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 10:36:46 -0700
Date:   Thu, 17 Mar 2022 10:36:39 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Subject: Re: [PATCH v2 2/6] cxl/pci: Add debug for DVSEC range init failures
Message-ID: <20220317173639.b4tewk7hp4fr3jms@intel.com>
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164730734812.3806189.2726330688692684104.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164730734812.3806189.2726330688692684104.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-03-14 18:22:28, Dan Williams wrote:
> In preparation for not treating DVSEC range initialization failures as
> fatal to cxl_pci_probe() add individual dev_dbg() statements for each of
> the major failure reasons in cxl_dvsec_ranges().
> 
> The rationale for cxl_dvsec_ranges() failure not being fatal is that
> there is still value for cxl_pci to enable mailbox operations even if
> CXL.mem operation is disabled.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/pci.c |   13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 8a7267d116b7..257cf735505d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -467,12 +467,15 @@ static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
>  {
>  	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct device *dev = &pdev->dev;
>  	int d = cxlds->cxl_dvsec;
>  	int hdm_count, rc, i;
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
> @@ -482,8 +485,10 @@ static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
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
> @@ -496,8 +501,10 @@ static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
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
> 

It kind of stinks now that this function has some pdev->dev usages and plain dev
usages now. Either way, it's correct and an improvement.

Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
