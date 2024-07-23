Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B3217BD5;
	Tue, 23 Jul 2024 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721756447; cv=none; b=WpTiOhHaDxieyLUBkjiH5ML891ua1i9d22I+jRNLlaWQ0umvPJzbOAGe44L0j8sVlmXvP3HqwrqwBSzpdaIPH/IIv1eEqqHuQ9DXveNb71bgiUHnHVuf3jxY/P0obNTiP/PNT/4L9orCquIRg4kvYnQeozbl3wBRPcgRIpjte9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721756447; c=relaxed/simple;
	bh=iAhFHwAfL5fuXom8Xl8wXKrfmvfDT1wtrd7UrOMlzr4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkr24qprtyofn744/npJ+BBItkDOpMaE3q+1gUNP+24kH89D0gc/FirsljNQYqb4E8G3YcV6LJeU6KUgcNrwM3dbcALD8oFdog4jDMbsKlh7pm0eCzvB/nsO97s2xNITn9uBcpTOsUfuKZNoMBYnFcUD++lvo8aG9M7lD0TOXXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXLfas6f; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXLfas6f"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6659e81bc68so59707027b3.0;
        Tue, 23 Jul 2024 10:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721756444; x=1722361244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IhI6EPi4oXw71sHltnEuSn7Gyx1xl7XCKJZ+6RMV9jQ=;
        b=VXLfas6fuCnHmUGQXhCrMbRY0K8rahfnhLZh2xMokkFmOWQwHBOEE0Lo4bzyrhBhsA
         wNhROvZ3N5oQiYaLf7yoCkkPS+rl0Qa0DFbdYm2VXOJA1AxT+wZXUngvTm334VBngTjx
         9HNdkK2fhRyfRtJ4pJEWlrVMeX5QXrC1NjEwZoyAWaCh/wbqs7N4pWNVXyEJn26rgukv
         1qGHaCBY/tgYP7TjbSIc2sJ9wTjVYYiBdTMJ0nkX9Xsgs6kun9B+1Z8kiMPyGFNUTe+r
         P1dQd1/sPGKw6xtSnS1NQeFj/+YX9H+Tsx7WttHVaFCv6VAvNlgg8JhNYOdfsnwRjKQ+
         9QBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721756444; x=1722361244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhI6EPi4oXw71sHltnEuSn7Gyx1xl7XCKJZ+6RMV9jQ=;
        b=LnZ6tYzIgtsqdtWnYoLyZTuzS9deD/Hd7Z3X4cyPGI/S9/sE71V3NPEmz19yUqpbVR
         XVu0W2yfw02qQ+Mbn6DfwoT4uwJMSCIiv2CNvGi6YayBQMdaX2BK+vHYi9CbDXD0G6A1
         Zd3TCicfsxEi5xxVUXsiyZL10XXk7hDzOvFTzI3VaTrc92/2sZo5rgISllA+vxabIv7G
         Yqg89b2CUlHu2JL4diO0Pfyo1212UoWIdeB5dKjrcAc46tOtm2QKNVpEBiPQio0UrE9z
         GXAJzA+zQSrEGYV5mVj2bEDnE5ZAa4Mb9ZvJ4VrWHGRWnowAmR1ZQEyuHIWmuRmUgaYB
         C5sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVktYc91Dvz2vh7cfqW1HocrM+Q46Ng5ipeY7HX0s30yMMUdtKsx/+yMu1pbWtIdTJ4JNFniU8YQvTJz9XLe9gkZ+P+5Oi3/VBfeGQIW/pVWm/vtBeYcvhH0cVWGYSip4QOyAvBPrUP
X-Gm-Message-State: AOJu0YxkPc3Gx1koZLUuzp4Q4fugf3Br/luMML/xvXBoa/jkLXpE8brC
	FIF/TU5B63y5+GXgsVOLA45RM8zJYTiVN2l16EuZ9sKp733x1ZwaeSXV1g==
X-Google-Smtp-Source: AGHT+IGACdBoTy1BVLFKaFQQ/0K6tMcAW7xuOAF//wRFNkjiNoPJKybgi/skJ7VrgliR7uS7SOQ3+Q==
X-Received: by 2002:a05:690c:397:b0:632:e098:a9e0 with SMTP id 00721157ae682-671f09defd1mr5981967b3.9.1721756444356;
        Tue, 23 Jul 2024 10:40:44 -0700 (PDT)
Received: from gpd ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-669540c3957sm20786047b3.123.2024.07.23.10.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 10:40:44 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@gpd>
Date: Tue, 23 Jul 2024 10:40:29 -0700
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bharata B Rao <bharata@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 2/3] cxl/region: Support to calculate memory tier
 abstract distance
Message-ID: <Zp_rDddyf5097Nwb@gpd>
References: <20240618084639.1419629-1-ying.huang@intel.com>
 <20240618084639.1419629-3-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618084639.1419629-3-ying.huang@intel.com>

On Tue, Jun 18, 2024 at 04:46:38PM +0800, Huang Ying wrote:
> An abstract distance value must be assigned by the driver that makes
> the memory available to the system. It reflects relative performance
> and is used to place memory nodes backed by CXL regions in the appropriate
> memory tiers allowing promotion/demotion within the existing memory tiering
> mechanism.
> 
> The abstract distance is calculated based on the memory access latency
> and bandwidth of CXL regions.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
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

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/region.c | 27 +++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |  2 ++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 51aeef2c012c..dc15ceba7ab7 100644
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
> @@ -2228,6 +2229,7 @@ static void unregister_region(void *_cxlr)
>  	int i;
>  
>  	unregister_memory_notifier(&cxlr->memory_notifier);
> +	unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
>  	device_del(&cxlr->dev);
>  
>  	/*
> @@ -2340,6 +2342,27 @@ static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
>  	return NOTIFY_OK;
>  }
>  
> +static int cxl_region_calculate_adistance(struct notifier_block *nb,
> +					  unsigned long nid, void *data)
> +{
> +	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
> +					       adist_notifier);
> +	struct access_coordinate *perf;
> +	int *adist = data;
> +	int region_nid;
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
> @@ -2382,6 +2405,10 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
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
> index 603c0120cff8..f46252373159 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -522,6 +522,7 @@ struct cxl_region_params {
>   * @params: active + config params for the region
>   * @coord: QoS access coordinates for the region
>   * @memory_notifier: notifier for setting the access coordinates to node
> + * @adist_notifier: notifier for calculating the abstract distance of node
>   */
>  struct cxl_region {
>  	struct device dev;
> @@ -534,6 +535,7 @@ struct cxl_region {
>  	struct cxl_region_params params;
>  	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>  	struct notifier_block memory_notifier;
> +	struct notifier_block adist_notifier;
>  };
>  
>  struct cxl_nvdimm_bridge {
> -- 
> 2.39.2
> 
