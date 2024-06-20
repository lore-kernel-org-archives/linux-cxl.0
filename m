Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A011AAE11;
	Thu, 20 Jun 2024 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718882123; cv=none; b=ATE9Z0sskS27i06PiEfPtrpRz+3Zq/ht6yIw7y+vIA/K7hKzM3uYkKikY4Mj2xiPJA79PZcKmJtQ7vV6oBIH2FhIouSSjlVnAxPY+LtbNdA8J+hohJ+8GxFwsoZc6T0vMlFuBWerBQkxJxEFHVML27zbPk5aXAQRZ33B+1a2ErU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718882123; c=relaxed/simple;
	bh=8/Se5HsIJIn0bf7XIDA1NA5bOEV8j/nuQs1YIB1bZYI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kiaIMClun1v10D/EjGxbBCRhRwOZxUqliLQ6ZnA4VXe+yqtXpwxmKiw9AT+qa0BjqXo1s7uyCO8zZRSNTnprpuAPcLCfoR9h3rukWaqwGHbrvsNDHMJd96uAz0gLOXA8DL3vPObmrXKKnVn9NzSSdV7NvRcWQzimRRlrcE+3MSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4dCY1nQdz6K9JD;
	Thu, 20 Jun 2024 19:13:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6808E140D1D;
	Thu, 20 Jun 2024 19:15:18 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Jun
 2024 12:15:17 +0100
Date: Thu, 20 Jun 2024 12:15:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Huang Ying <ying.huang@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
	Bharata B Rao <bharata@amd.com>, Alistair Popple <apopple@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH v3 3/3] cxl/region: Simplify cxl_region_nid()
Message-ID: <20240620121517.00006e3e@Huawei.com>
In-Reply-To: <20240618084639.1419629-4-ying.huang@intel.com>
References: <20240618084639.1419629-1-ying.huang@intel.com>
	<20240618084639.1419629-4-ying.huang@intel.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 18 Jun 2024 16:46:39 +0800
Huang Ying <ying.huang@intel.com> wrote:

> The node ID of the region can be gotten via resource start address
> directly.  This simplifies the implementation of cxl_region_nid().
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/cxl/core/region.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index dc15ceba7ab7..605efe3562c6 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2309,15 +2309,13 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>  static int cxl_region_nid(struct cxl_region *cxlr)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
> -	struct cxl_endpoint_decoder *cxled;
> -	struct cxl_decoder *cxld;
> +	struct resource *res;
>  
>  	guard(rwsem_read)(&cxl_region_rwsem);
> -	cxled = p->targets[0];
> -	if (!cxled)
> +        res = p->res;

Odd indent - I think spaces rather than tab.  Otherwise seems reasonable.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> +	if (!res)
>  		return NUMA_NO_NODE;
> -	cxld = &cxled->cxld;
> -	return phys_to_target_node(cxld->hpa_range.start);
> +	return phys_to_target_node(res->start);
>  }
>  
>  static int cxl_region_perf_attrs_callback(struct notifier_block *nb,

