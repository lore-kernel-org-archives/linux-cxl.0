Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5A61552FD
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175602; cv=none; b=gvutZxsrMh0OOw4qN2rnlGq1mSk4tFCSOICZFX+zTCjqeMjT5TpQncLLrt9uy3yzG9T0+47fDLEGnX7BrCZ8CMl66xHUAwT9mdw6/DpVQRwQXxEWaiaxlWGC2JMQP/F70h7flpoo/eVuh8LWAnR7S+tq6fdRZt2sipbmxdgXOyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175602; c=relaxed/simple;
	bh=9v3cgsCivsSZ6WObEvfOaB7mZjay2UlGwdH7OXLDPl8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIivuDaNUqSwsyk0utR2IEAQlzXkrV40twISZF2MqGkosnI67qRuN1E1a4Mv2jt1A716acq4dddwgOQEwP6VCGPBNP0y3GU7joBXCuAHSIbVJ44orUYUCrf40V5g/9e5bF8OIXdWpXjOOtd8w19ywnkIXBU1P4G1F43XcVFTcqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8wwR4vLvz6DBP2;
	Thu,  4 Apr 2024 04:15:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D72C0140B67;
	Thu,  4 Apr 2024 04:19:57 +0800 (CST)
Received: from localhost (10.126.171.13) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 21:19:57 +0100
Date: Wed, 3 Apr 2024 21:19:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/4] cxl/core: Remove cxlr dependency from cxl_poison
 trace events
Message-ID: <20240403211957.000062d3@Huawei.com>
In-Reply-To: <4f1c74748ee880eea9ddf6f966a4266e86f12bee.1711598777.git.alison.schofield@intel.com>
References: <cover.1711598777.git.alison.schofield@intel.com>
	<4f1c74748ee880eea9ddf6f966a4266e86f12bee.1711598777.git.alison.schofield@intel.com>
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

On Wed, 27 Mar 2024 21:36:33 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> cxl_poison trace events pass a pointer to a struct cxl_region
> when poison is discovered in a mapped endpoint. This made for
> easy look up of region name, uuid, and was useful in starting
> the dpa->hpa translation.
> 
> Another set of trace helpers is now available that eliminates
> the need to pass on that cxlr. (It was passed along a lot!)
> 
> In addition to tidying up the cxl_poison calling path, shifting
> to the new helpers also means all CXL trace events will share
> the same code in that regard.
> 
> Switch from a uuid array to the field_struct type uuid_t to
> align on one uuid format in all CXL trace events. That is useful
> when sharing region uuid lookup helpers.
> 
> No externally visible naming changes are made to cxl_poison trace
> events.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Trivial formatting comment inline.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 6ad4998aeb9a..2cd66c04602a 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -681,23 +681,23 @@ TRACE_EVENT(cxl_memory_module,
>  

> @@ -712,27 +712,20 @@ TRACE_EVENT(cxl_poison,
>  		__entry->source = cxl_poison_record_source(record);
>  		__entry->trace_type = trace_type;
>  		__entry->flags = flags;
> -		if (cxlr) {
> -			__assign_str(region, dev_name(&cxlr->dev));
> -			memcpy(__entry->uuid, &cxlr->params.uuid, 16);
> -			__entry->hpa = cxl_trace_hpa(cxlr, cxlmd,
> -						     __entry->dpa);
> -		} else {
> -			__assign_str(region, "");
> -			memset(__entry->uuid, 0, 16);
> -			__entry->hpa = ULLONG_MAX;
> -		}
> +		__assign_str(region, to_region_name(cxlmd, cxl_poison_record_dpa(record)));
> +		store_region_info(cxlmd, __entry->dpa, __entry->uuid,
> +				  __entry->hpa);
>  	    ),
>  
> -	TP_printk("memdev=%s host=%s serial=%lld trace_type=%s region=%s "  \
> -		"region_uuid=%pU hpa=0x%llx dpa=0x%llx dpa_length=0x%x "    \
> +	TP_printk("memdev=%s host=%s serial=%lld trace_type=%s region=%s"  \
> +		"region_uuid=%pUb hpa=0x%llx dpa=0x%llx dpa_length=0x%x "    \

the spaces before the \ could do with tidying up.  

>  		"source=%s flags=%s overflow_time=%llu",
>  		__get_str(memdev),
>  		__get_str(host),
>  		__entry->serial,
>  		show_poison_trace_type(__entry->trace_type),
>  		__get_str(region),
> -		__entry->uuid,
> +		&__entry->uuid,
>  		__entry->hpa,
>  		__entry->dpa,
>  		__entry->dpa_length,

