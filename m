Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5FEC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Mar 2022 11:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242984AbiCYLkH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Mar 2022 07:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238846AbiCYLkG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Mar 2022 07:40:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2043F49F20
        for <linux-cxl@vger.kernel.org>; Fri, 25 Mar 2022 04:38:29 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KQ0SC24Lbz67kB8;
        Fri, 25 Mar 2022 19:37:15 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 25 Mar 2022 12:38:28 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 11:38:27 +0000
Date:   Fri, 25 Mar 2022 11:38:26 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ben.widawsky@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v2 2/6] cxl/pci: Add debug for DVSEC range init failures
Message-ID: <20220325113826.00007549@huawei.com>
In-Reply-To: <164730734812.3806189.2726330688692684104.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164730734812.3806189.2726330688692684104.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Mon, 14 Mar 2022 18:22:28 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for not treating DVSEC range initialization failures as
> fatal to cxl_pci_probe() add individual dev_dbg() statements for each of
> the major failure reasons in cxl_dvsec_ranges().
> 
> The rationale for cxl_dvsec_ranges() failure not being fatal is that
> there is still value for cxl_pci to enable mailbox operations even if
> CXL.mem operation is disabled.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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

