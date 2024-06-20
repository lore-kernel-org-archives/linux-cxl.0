Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A2246BF;
	Thu, 20 Jun 2024 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888017; cv=none; b=daKsPfjzpEJgNnKo61RsDAPVo7/v13/PRPKYoU+tEOC55iNk7QzwLKf7+q4I9mYyz/7l21ADi3YBrOwJGC+D0kXHK8E6QrOGxu8zrzENKRYTASQb44sq0Eu5d7mPB+8S8ugidhvh8zpN4AyYjfahNeJ7b+dT6e9FM6rdyv+uhRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888017; c=relaxed/simple;
	bh=7nQ+7f4wihFoFdDBGTkKhLtrG9cRzMLnguTmYW3JZzc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzWGb0p5mDe4kB1WlKXTYsOwZ9R6Y+1IohpNJBVca5RCLi0mgdKWtqcMHJ16l3apVpd3/kZ5lEp+babhnQY8NbSUPqutUZoMTXxOmqYnwuvC2QPdCbBXt+2B25phNJqNmGQA8WhpxQLx/zLXQvUIslbNLJ5bxZdauEycZg1sVF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4gQG25y8z6K6xx;
	Thu, 20 Jun 2024 20:53:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 94C3A1402C6;
	Thu, 20 Jun 2024 20:53:33 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Jun
 2024 13:53:32 +0100
Date: Thu, 20 Jun 2024 13:53:32 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Yazen.Ghannam@amd.com>,
	<Robert.Richter@amd.com>
Subject: Re: [RFC PATCH 6/9] cxl/pci: Add trace logging for CXL PCIe port
 RAS errors
Message-ID: <20240620135332.000053f5@Huawei.com>
In-Reply-To: <20240617200411.1426554-7-terry.bowman@amd.com>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
	<20240617200411.1426554-7-terry.bowman@amd.com>
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

On Mon, 17 Jun 2024 15:04:08 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The cxl_pci driver uses kernel trace functions to log RAS errors for
> endpoints and RCH downstream ports. The same is needed for CXL root ports,
> CXL downstream switch ports, and CXL upstream switch ports.
> 
> Add RAS correctable and RAS uncorrectable trace logging functions for
> CXL PCIE ports.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/trace.h | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index e5f13260fc52..5cfd9952d88a 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -48,6 +48,23 @@
>  	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
>  )
>  
> +TRACE_EVENT(cxl_port_aer_uncorrectable_error,
> +	TP_PROTO(struct device *dev, u32 status),

By comparison with existing code, why no fe or header
log?  Don't exist for ports for some reason?
Serial number of the port might also be useful.

> +	TP_ARGS(dev, status),
> +	TP_STRUCT__entry(
> +		__string(devname, dev_name(dev))
> +		__field(u32, status)
> +	),
> +	TP_fast_assign(
> +		__assign_str(devname, dev_name(dev));
> +		__entry->status = status;
> +	),
> +	TP_printk("device=%s status='%s'",
> +		  __get_str(devname),
> +		  show_uc_errs(__entry->status)
> +	)
> +);
> +
>  TRACE_EVENT(cxl_aer_uncorrectable_error,
>  	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
>  	TP_ARGS(cxlmd, status, fe, hl),
> @@ -96,6 +113,23 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>  	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
>  )
>  
> +TRACE_EVENT(cxl_port_aer_correctable_error,
> +	TP_PROTO(struct device *dev, u32 status),
> +	TP_ARGS(dev, status),
> +	TP_STRUCT__entry(
> +		__string(devname, dev_name(dev))
> +		__field(u32, status)
> +	),
> +	TP_fast_assign(
> +		__assign_str(devname, dev_name(dev));
> +		__entry->status = status;
> +	),
> +	TP_printk("device=%s status='%s'",
> +		  __get_str(devname),
> +		  show_ce_errs(__entry->status)
> +	)
> +);
> +
>  TRACE_EVENT(cxl_aer_correctable_error,
>  	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
>  	TP_ARGS(cxlmd, status),

