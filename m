Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D563B38DE3
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737108194; cv=none; b=ofi/MopxaqrpE7RyWEqVInl1h8NNwDnAgH4nQ+LWnTU44nRSHFXZBYUgObK4YBf6NrA3xPxXFG3BtvXR1U3jvNhiTQnWClU+vhSPAajuG8Ux8B7ylJjwgWID8aYkp/I+m9wXW4I+0vMdc/N3x7LnRCOMXYJJwZIPCS7tjBBCJtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737108194; c=relaxed/simple;
	bh=UlAwrGRPttoSXc6WzY6OdrRF+m+wq39oBLiC0eIO4MI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGCeKOUqZx1k9HYe+NsO45g4Ec1llSFEoq4sAdsjVHVaOBAzZHLhBzuNmpHsZgZwa0+QcG6lmSuXCPhyo+XxQrIvceQ7JWLAknwK/JsUWJpfEZbURlkSXoS/ONfijCez7RATqn3MqpOhLMdFjnKXw/KJMho6GnNa4AE3HyP9iPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YZFcc24JZz6M4K4;
	Fri, 17 Jan 2025 18:01:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 306FA1402CB;
	Fri, 17 Jan 2025 18:03:08 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 17 Jan
 2025 11:03:07 +0100
Date: Fri, 17 Jan 2025 10:03:06 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>
Subject: Re: [PATCH 1/4] cxl: Remove the CXL_DECODER_MIXED mistake
Message-ID: <20250117100306.000077ae@huawei.com>
In-Reply-To: <173709423269.753996.17229236572128350685.stgit@dwillia2-xfh.jf.intel.com>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
	<173709423269.753996.17229236572128350685.stgit@dwillia2-xfh.jf.intel.com>
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

On Thu, 16 Jan 2025 22:10:32 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> CXL_DECODER_MIXED is a safety mechanism introduced for the case where
> platform firmware has programmed an endpoint decoder that straddles a
> DPA partition boundary. While the kernel is careful to only allocate DPA
> capacity within a single partition there is no guarantee that platform
> firmware, or anything that touched the device before the current kernel,
> gets that right.
> 
> However, __cxl_dpa_reserve() will never get to the CXL_DECODER_MIXED
> designation because of the way it tracks partition boundaries. A
> request_resource() that spans ->ram_res and ->pmem_res fails with the
> following signature:
> 
>     __cxl_dpa_reserve: cxl_port endpoint15: decoder15.0: failed to reserve allocation
> 
> CXL_DECODER_MIXED is dead defensive programming after the driver has
> already given up on the device. It has never offered any protection in
> practice, just delete it.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/hdm.c    |    8 ++++----
>  drivers/cxl/core/region.c |   12 ------------
>  drivers/cxl/cxl.h         |    4 +---
>  3 files changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 28edd5822486..be8556119d94 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -329,12 +329,12 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  
>  	if (resource_contains(&cxlds->pmem_res, res))
>  		cxled->mode = CXL_DECODER_PMEM;
> -	else if (resource_contains(&cxlds->ram_res, res))
> +	if (resource_contains(&cxlds->ram_res, res))

Logic of removing the else?  I assume there is 0 chance that both conditions
match, but doesn't this mean if the res is not in ram_res we always hit the next
else and print the warning?

>  		cxled->mode = CXL_DECODER_RAM;
>  	else {
> -		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
> -			 port->id, cxled->cxld.id, cxled->dpa_res);
> -		cxled->mode = CXL_DECODER_MIXED;
> +		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
> +			 port->id, cxled->cxld.id, res);
> +		cxled->mode = CXL_DECODER_NONE;
>  	}
>  
>  	port->hdm_end++;

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f6015f24ad38..0fb8d70fa3e5 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -379,7 +379,6 @@ enum cxl_decoder_mode {
>  	CXL_DECODER_NONE,
>  	CXL_DECODER_RAM,
>  	CXL_DECODER_PMEM,
> -	CXL_DECODER_MIXED,
>  	CXL_DECODER_DEAD,
>  };
>  
> @@ -389,10 +388,9 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
>  		[CXL_DECODER_NONE] = "none",
>  		[CXL_DECODER_RAM] = "ram",
>  		[CXL_DECODER_PMEM] = "pmem",
> -		[CXL_DECODER_MIXED] = "mixed",
>  	};
>  
> -	if (mode >= CXL_DECODER_NONE && mode <= CXL_DECODER_MIXED)
> +	if (mode >= CXL_DECODER_NONE && mode <= CXL_DECODER_PMEM)
Maybe just < DEAD is simpler?
>  		return names[mode];
>  	return "mixed";
>  }
> 
> 

