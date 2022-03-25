Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE75C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Mar 2022 11:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348798AbiCYLtK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Mar 2022 07:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345320AbiCYLtK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Mar 2022 07:49:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BD6D3AF7
        for <linux-cxl@vger.kernel.org>; Fri, 25 Mar 2022 04:47:35 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KQ0dP0fHzz67wCQ;
        Fri, 25 Mar 2022 19:45:13 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 25 Mar 2022 12:47:32 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 11:47:32 +0000
Date:   Fri, 25 Mar 2022 11:47:31 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Krzysztof Zach <krzysztof.zach@intel.com>,
        <ben.widawsky@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH v2 4/6] cxl/pci: Make cxl_dvsec_ranges() failure not
 fatal to cxl_pci
Message-ID: <20220325114731.00004af0@huawei.com>
In-Reply-To: <164730735869.3806189.4032428192652531946.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164730735869.3806189.4032428192652531946.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Mon, 14 Mar 2022 18:22:38 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

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
with comment Ben requested

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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

