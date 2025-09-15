Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D15F1C4609;
	Mon, 15 Sep 2025 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931827; cv=none; b=HFW7oJnqa5I/J+Qywcd8VJN5zKXNc6SQGaE530AsLgszY3vL4S1n0+MXP5ZyrA5iG6fz4mIs47/sBzz/nP1kE51d+fF+LAFma91XAj/hcpskvSLtpV4esR+IHRFWimZQDqYwRHLh7GT/PxyBrg6Z8Fcodm1taroE7kYqkZ33H4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931827; c=relaxed/simple;
	bh=Z7gBVl8NDSlD7/2DByYfLKQfOzntI2KhxBFRAe94tgQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJvx2HCXD2gG826sM7I/Gtam7PTP3/uZfiC3fH9E5Msor67jjeDVX7B3TEe7DgxuQzVop2dVc67hHkM32t7x9OnjJZKsQ1JSuM2LhLaBvHBJZPqI4fMKbZqvTUyjnMmyBMxB22EARAIfFzeZNXB5R0XuvYx5Y8jIPJt/P1xW5Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cQLf16wMMz6M5gW;
	Mon, 15 Sep 2025 18:20:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A9161402FB;
	Mon, 15 Sep 2025 18:23:43 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 15 Sep
 2025 12:23:42 +0200
Date: Mon, 15 Sep 2025 11:23:41 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 02/11] cxl/region: Store HPA range in struct
 cxl_region
Message-ID: <20250915112341.00000ec6@huawei.com>
In-Reply-To: <20250912144514.526441-3-rrichter@amd.com>
References: <20250912144514.526441-1-rrichter@amd.com>
	<20250912144514.526441-3-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 12 Sep 2025 16:45:04 +0200
Robert Richter <rrichter@amd.com> wrote:

> Each region has a known host physical address (HPA) range it is
> assigned to. Endpoint decoders assigned to a region share the same HPA
> range. The region's address range is the system's physical address
> (SPA) range.
> 
> Endpoint decoders in systems that need address translation use HPAs
> which are not SPAs. To make the SPA range accessible to the endpoint
> decoders, store and track the region's SPA range in struct cxl_region.
> Introduce the @hpa_range member to the struct. Now, the SPA range of
> an endpoint decoder can be determined based on its assigned region.
> 
> Patch is a prerequisite to implement address translation which uses
> struct cxl_region to store all relevant region and interleaving
> parameters.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
Trivial comment inline.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/cxl/core/region.c | 17 +++++++++++++++++
>  drivers/cxl/cxl.h         |  2 ++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 2c37c060d983..777d04870180 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -664,6 +664,11 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  		return PTR_ERR(res);
>  	}
>  
> +	cxlr->hpa_range = (struct range) {
> +		.start = res->start,
> +		.end = res->end,
> +	};
> +
>  	p->res = res;
>  	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
>  
> @@ -700,8 +705,14 @@ static int free_hpa(struct cxl_region *cxlr)
>  	if (p->state >= CXL_CONFIG_ACTIVE)
>  		return -EBUSY;
>  
> +	cxlr->hpa_range = (struct range) {
> +		.start = 0,
> +		.end = -1,
> +	};

There is DEFINE_RANGE() which you could use here
	cxlr->hpa_range = DEFINE_RANGE(0, -1);

Not sure if it is worth bothering though.



> +
>  	cxl_region_iomem_release(cxlr);
>  	p->state = CXL_CONFIG_IDLE;
> +
>  	return 0;
>  }


