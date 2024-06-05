Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0632319306E;
	Wed,  5 Jun 2024 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589423; cv=none; b=S3YGnhSkvuRcwuwKY9VpsFCI0chzGhRyR4fIRdDXpFIw6IlUSHhgQTtk5FdvJ2dsbuzPTMR90FO9VPl6FTEjUn6QiuGm1KWr0V7VsFQifKXLaqKbKcESP7O9iE/1HSBEYHyjyYZKrBNYxAnfvRuULT8uk+g8gYn2wDzySMnghAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589423; c=relaxed/simple;
	bh=uU/kPURlWArfE4CtsM1+ooioKftMO43VsgbrHXq3oG0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntd2ZkDlsRKvdftOn6tMBVNgUbysVqXL2vkFmmyULH50q2XDuBXlnwFbuGHjhS9XEbCZZGRNqYT7TyZ9eVTt1xsx1CR7BdNIgh1eelujdlRA0YpphhwZu6rNOmkIQ/Eg38OzgXWatixGYEJMWUK9bEprgEmt2dTFfP9h2GQtciA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VvR4m2J7Cz6JBDV;
	Wed,  5 Jun 2024 20:06:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A03BB1400D9;
	Wed,  5 Jun 2024 20:10:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Jun
 2024 13:10:18 +0100
Date: Wed, 5 Jun 2024 13:10:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Huang Ying <ying.huang@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Dave Jiang <dave.jiang@intel.com>, Bharata B Rao <bharata@amd.com>, Alistair
 Popple <apopple@nvidia.com>, "Aneesh Kumar K . V"
	<aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] cxl/region: Support to calculate memory tier abstract
 distance
Message-ID: <20240605131017.000069b6@Huawei.com>
In-Reply-To: <20240531024852.282767-1-ying.huang@intel.com>
References: <20240531024852.282767-1-ying.huang@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 31 May 2024 10:48:52 +0800
Huang Ying <ying.huang@intel.com> wrote:

> To place memory nodes backed by CXL regions in the appropriate memory
> tiers.  So that, pages can be promoted/demoted with the existing
> memory tiering mechanism.
> 
> The abstract distance is calculated based on the memory access latency
> and bandwidth of CXL regions.  Which in turn comes from the HMAT
> and CDAT, etc.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Minor comments inline.  Otherwise, looks good to me.

Jonathan


> ---
>  drivers/cxl/core/region.c | 40 +++++++++++++++++++++++++++++++++++----
>  drivers/cxl/cxl.h         |  1 +
>  2 files changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 00a9f0eef8dd..1f8f71a034ae 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -9,6 +9,7 @@
>  #include <linux/uuid.h>
>  #include <linux/sort.h>
>  #include <linux/idr.h>
> +#include <linux/memory-tiers.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
>  #include "core.h"
> @@ -2304,14 +2305,20 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>  	return true;
>  }
>  
> +static int cxl_region_nid(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_endpoint_decoder *cxled = p->targets[0];
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +
> +	return phys_to_target_node(cxld->hpa_range.start);
> +}
> +
>  static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
>  					  unsigned long action, void *arg)
>  {
>  	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
>  					       memory_notifier);
> -	struct cxl_region_params *p = &cxlr->params;
> -	struct cxl_endpoint_decoder *cxled = p->targets[0];
> -	struct cxl_decoder *cxld = &cxled->cxld;
>  	struct memory_notify *mnb = arg;
>  	int nid = mnb->status_change_nid;
>  	int region_nid;
> @@ -2319,7 +2326,7 @@ static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
>  	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
>  		return NOTIFY_DONE;
>  
> -	region_nid = phys_to_target_node(cxld->hpa_range.start);
> +	region_nid = cxl_region_nid(cxlr);
>  	if (nid != region_nid)
>  		return NOTIFY_DONE;
>  
> @@ -2329,6 +2336,27 @@ static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
>  	return NOTIFY_OK;
>  }
>  
> +static int cxl_region_calculate_adistance(struct notifier_block *nb,
> +					  unsigned long nid, void *data)
> +{
> +	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
> +					       adist_notifier);
> +	int region_nid;
> +	struct access_coordinate *perf;
> +	int *adist = data;
Local style looks to be reverse xmas tree subject to any dependencies etc.

> +
> +	region_nid = cxl_region_nid(cxlr);
> +	if (nid != region_nid)
> +		return NOTIFY_OK;
> +
> +	perf = &cxlr->coord[ACCESS_COORDINATE_CPU];
> +
> +	if (mt_perf_to_adistance(perf, adist))
> +		return NOTIFY_OK;
> +
> +	return NOTIFY_STOP;
> +}
> +
>  /**
>   * devm_cxl_add_region - Adds a region to a decoder
>   * @cxlrd: root decoder
> @@ -2380,6 +2408,10 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;
>  	register_memory_notifier(&cxlr->memory_notifier);
>  
> +	cxlr->adist_notifier.notifier_call = cxl_region_calculate_adistance;
> +	cxlr->adist_notifier.priority = 100;
> +	register_mt_adistance_algorithm(&cxlr->adist_notifier);
> +
>  	rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
>  	if (rc)
>  		return ERR_PTR(rc);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 603c0120cff8..6891f87f8ef7 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -534,6 +534,7 @@ struct cxl_region {
This has docs that need an updte.
>  	struct cxl_region_params params;
>  	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>  	struct notifier_block memory_notifier;
> +	struct notifier_block adist_notifier;
>  };
>  
>  struct cxl_nvdimm_bridge {

