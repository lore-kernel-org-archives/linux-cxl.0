Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86067C433EF
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Nov 2021 11:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5735F610A8
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Nov 2021 11:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhKALdD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Nov 2021 07:33:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4046 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhKALdD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Nov 2021 07:33:03 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HjW2z0dXHz68409;
        Mon,  1 Nov 2021 19:27:07 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 1 Nov 2021 12:30:28 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 1 Nov
 2021 11:30:27 +0000
Date:   Mon, 1 Nov 2021 11:30:26 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <ben.widawsky@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH] cxl/pmem: Fix reference counting for delayed work
Message-ID: <20211101113026.00001d2a@Huawei.com>
In-Reply-To: <163553734757.2509761.3305231863616785470.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163553734757.2509761.3305231863616785470.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 29 Oct 2021 12:55:47 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> There is a potential race between queue_work() returning and the
> queued-work running that could result in put_device() running before
> get_device(). Introduce the cxl_nvdimm_bridge_state_work() helper that
> takes the reference unconditionally, but drops it if no new work was
> queued, to keep the references balanced.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Good spot, I'm guessing this was an inspection thing rather than a problem
you've managed to trigger, but either way.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

