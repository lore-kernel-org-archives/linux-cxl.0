Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E953C433EF
	for <linux-cxl@archiver.kernel.org>; Sun, 31 Oct 2021 18:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0784060F02
	for <linux-cxl@archiver.kernel.org>; Sun, 31 Oct 2021 18:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhJaTBF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 31 Oct 2021 15:01:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:20320 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229732AbhJaTBF (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 31 Oct 2021 15:01:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="294365585"
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="294365585"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2021 11:58:33 -0700
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="449028133"
Received: from jwcarin-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.129])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2021 11:58:33 -0700
Date:   Sun, 31 Oct 2021 11:58:31 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Subject: Re: [PATCH] cxl/pmem: Fix reference counting for delayed work
Message-ID: <20211031185831.4gtasmqiqdf3zkv3@intel.com>
References: <163553734757.2509761.3305231863616785470.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163553734757.2509761.3305231863616785470.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-10-29 12:55:47, Dan Williams wrote:
> There is a potential race between queue_work() returning and the
> queued-work running that could result in put_device() running before
> get_device(). Introduce the cxl_nvdimm_bridge_state_work() helper that
> takes the reference unconditionally, but drops it if no new work was
> queued, to keep the references balanced.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Arguably fixes/stable?
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>

> ---
>  drivers/cxl/pmem.c |   17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index ceb2115981e5..38bcbb4e9409 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -266,14 +266,24 @@ static void cxl_nvb_update_state(struct work_struct *work)
>  	put_device(&cxl_nvb->dev);
>  }
>  
> +static void cxl_nvdimm_bridge_state_work(struct cxl_nvdimm_bridge *cxl_nvb)
> +{
> +	/*
> +	 * Take a reference that the workqueue will drop if new work
> +	 * gets queued.
> +	 */
> +	get_device(&cxl_nvb->dev);
> +	if (!queue_work(cxl_pmem_wq, &cxl_nvb->state_work))
> +		put_device(&cxl_nvb->dev);
> +}
> +
>  static void cxl_nvdimm_bridge_remove(struct device *dev)
>  {
>  	struct cxl_nvdimm_bridge *cxl_nvb = to_cxl_nvdimm_bridge(dev);
>  
>  	if (cxl_nvb->state == CXL_NVB_ONLINE)
>  		cxl_nvb->state = CXL_NVB_OFFLINE;
> -	if (queue_work(cxl_pmem_wq, &cxl_nvb->state_work))
> -		get_device(&cxl_nvb->dev);
> +	cxl_nvdimm_bridge_state_work(cxl_nvb);
>  }
>  
>  static int cxl_nvdimm_bridge_probe(struct device *dev)
> @@ -294,8 +304,7 @@ static int cxl_nvdimm_bridge_probe(struct device *dev)
>  	}
>  
>  	cxl_nvb->state = CXL_NVB_ONLINE;
> -	if (queue_work(cxl_pmem_wq, &cxl_nvb->state_work))
> -		get_device(&cxl_nvb->dev);
> +	cxl_nvdimm_bridge_state_work(cxl_nvb);
>  
>  	return 0;
>  }
> 
