Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E885BE4D
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175380; cv=none; b=EXzceXzZsaZdlRttAf5FP8nD9bf3JNoreN6WthR+NUWFADLeZcCQ3cNqpD2LMWBiNOs1ehAbRZdfR1pxe6giA7wVfcJBa/DI6C3UXNsQPyJP5t/+u8estlwIJAgr7JeQnamFYZHRVNMGi7OSwh8V3ylSo8FlkcT5Y73dPg2Saac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175380; c=relaxed/simple;
	bh=6+XSWUmI1cn8jBDF3VjRTeuVNpd6f2tBpEejdEpZLJI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USRqVPr10DWuWpRxB5fpmp5Ts1wnCwJIGzhtVsgi0Ta9pM057ST4P1Hxd+hTM1+QJxRhsGekKuh96mlpwQ00L51F9cNWrQQmtr1t0hkBCTIJO3rdIaox2ixEkX3hHSnu7S2MvqLBMxn/MVasndQIZZ89+4mUR0OTH3QwUXhmbWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8wr83kmLz6DBNq;
	Thu,  4 Apr 2024 04:11:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A8D45140257;
	Thu,  4 Apr 2024 04:16:14 +0800 (CST)
Received: from localhost (10.126.171.13) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 21:16:14 +0100
Date: Wed, 3 Apr 2024 21:16:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/4] cxl/core: Add region info to cxl_general_media and
 cxl_dram events
Message-ID: <20240403211613.0000195d@Huawei.com>
In-Reply-To: <061d1eac5d4e270337911199f0b0633c0ff230b4.1711598777.git.alison.schofield@intel.com>
References: <cover.1711598777.git.alison.schofield@intel.com>
	<061d1eac5d4e270337911199f0b0633c0ff230b4.1711598777.git.alison.schofield@intel.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 27 Mar 2024 21:36:32 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> User space may need to know which region, if any, maps the DPAs
> (device physical addresses) reported in a cxl_general_media or
> cxl_dram event. Since the mapping can change, the kernel provides
> this information at the time the event occurs. This informs user
> space that at event <timestamp> this <region> mapped this <DPA>
> to this <HPA>.
> 
> Add the same region info that is included in the cxl_poison trace
> event: the DPA->HPA translation, region name, and region uuid.
> Introduce and use new helpers that lookup that region info using
> the struct cxl_memdev and a DPA.
> 
> The new fields are inserted in the trace event and no existing
> fields are modified. If the DPA is not mapped, user will see:
> hpa=ULLONG_MAX, region="", and uuid=0
> 
> This work must be protected by dpa_rwsem & region_rwsem since
> it is looking up region mappings.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
One query one the stub.. Otherwise all lgtm
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/core.h   |  6 +++++
>  drivers/cxl/core/mbox.c   | 17 ++++++++++----
>  drivers/cxl/core/region.c |  8 +++++++
>  drivers/cxl/core/trace.h  | 47 ++++++++++++++++++++++++++++++++++-----
>  4 files changed, 69 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 24454a1cb250..848ef6904beb 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -30,8 +30,14 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
>  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
>  u64 cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		  u64 dpa);
> +const char *cxl_trace_to_region_name(const struct cxl_memdev *cxlmd, u64 dpa);
>  
>  #else
> +static inline
> +const char *cxl_trace_to_region_name(const struct cxl_memdev *cxlmd, u64 dpa)
> +{
> +	return NULL;

Is this ever going to be a problem for the reason you have commented below?

Maybe 
return ""
?

...

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 45eb9c560fd6..a5b1eaee1e58 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2723,6 +2723,14 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
>  	return ctx.cxlr;
>  }
>  
> +const char *cxl_trace_to_region_name(const struct cxl_memdev *cxlmd, u64 dpa)
> +{
> +	struct cxl_region *cxlr = cxl_dpa_to_region(cxlmd, dpa);
> +
> +	/* trace __string() assignment requires "", not NULL */
> +	return cxlr ? dev_name(&cxlr->dev) : "";
> +}
> +


