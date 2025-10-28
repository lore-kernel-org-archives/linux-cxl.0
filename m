Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255FE223DD1
	for <linux-cxl@vger.kernel.org>; Tue, 28 Oct 2025 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662362; cv=none; b=XLy+kDRsDfMH4a4tmtOsPeWGPI2oRpYbl3JQHNRuwscT5R0zWDDtg/9MwRFa0T7rvN4V/NRyhRAN0YKo6+nkXYw5wpPAiU84owilhGQsKYFovg2lKGBKNrD5x1r17gmT8ZNy/YBlzr+ysqKXD7LbXCF5Qf+GAjw1nOP20gxrxQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662362; c=relaxed/simple;
	bh=US8mbcW/wmQC7T/j5bfKhkbTJNns4iPp9+KvyCmd3pw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbDD4gbkDfJ1rllvLpKb0ZpOLgrr+GCHEa64Hg/03mbny6BRJrzZlYzKBX65DZMrfjX7Fndgqlr22b+5P5TtxL9I4dMiZKChJiuEB32H/jqSO6tZYd8f29UEgOem0Pt0pBxau8ygvsF26fu8aTm4qEBBg23GCuxKGfwbNijXHHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4cwtL40cbszJ46XN;
	Tue, 28 Oct 2025 22:39:08 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 624BD140157;
	Tue, 28 Oct 2025 22:39:16 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Oct
 2025 14:39:15 +0000
Date: Tue, 28 Oct 2025 14:39:14 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl: Add handling of locked CXL decoder
Message-ID: <20251028143914.00004f46@huawei.com>
In-Reply-To: <20251021205055.2081800-1-dave.jiang@intel.com>
References: <20251021205055.2081800-1-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 21 Oct 2025 13:50:55 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> When a decoder is locked, it means that its configuration cannot be
> changed. CXL spec r3.2 8.2.4.20.13 discusses the details regarding
> locked decoders. Locking happens when bit 8 of the decoder control
> register is set and then the decoder is committed afterwards (CXL
> spec r3.2 8.2.4.20.7).
> 
> Given that the driver creates a virtual decoder for each CFMWS, the
> Fixed Device Configuration (bit 4) of the Window Restriction field is
> considered as locking for the virtual decoder by the driver.
> 
> The current driver code disregards the locked status and a region can
> be destroyed regardless of the locking state.
> 
> Add a region flag to indicate the region is in a locked configuration.
> The driver will considered a region locked if the CFMWS or any decoder
> is configured as locked. The consideration is all or nothing regarding
> the locked state. It is reasonable to determine the region "locked"
> status while the region is being assembled based on the decoders.
> 
> Add a check in region commit_store() to intercept when a 0 is written
> to the commit sysfs attribute in order to prevent the destruction of a
> region when in locked state. This should be the only entry point from user
> space to destroy a region.
> 
> Add a check is added to cxl_decoder_reset() to prevent resetting a locked
> decoder within the kernel driver.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Fully agree with what should be happening here, but a question below
on the implementation.

> ---
>  drivers/cxl/core/hdm.c    |  3 +++
>  drivers/cxl/core/region.c | 16 ++++++++++++++++
>  drivers/cxl/cxl.h         |  8 ++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d3a094ca01ad..1c5d2022c87a 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -905,6 +905,9 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>  	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
>  		return;
>  
> +	if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags))
> +		return;
> +
>  	if (port->commit_end == id)
>  		cxl_port_commit_reap(cxld);
>  	else
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b06fee1978ba..8647eff4fb78 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -419,6 +419,9 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
>  		return len;
>  	}
>  
> +	if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
> +		return -EPERM;
> +
>  	rc = queue_reset(cxlr);
>  	if (rc)
>  		return rc;
> @@ -1059,6 +1062,16 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>  	return 0;
>  }
>  
> +static void cxl_region_set_lock(struct cxl_region *cxlr,
> +				struct cxl_decoder *cxld)
> +{
> +	if (!test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
> +		return;
> +
> +	set_bit(CXL_REGION_F_LOCK, &cxlr->flags);

The sequence above here looks odd.  If the bit is not set, then don't 
set it? If already set then set it again? Was one of these meant to be
related to the decoder that was passed in? 

Maybe I need more coffee...


> +	clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
> +}
> +
>  /**
>   * cxl_port_attach_region() - track a region's interest in a port by endpoint
>   * @port: port to add a new region reference 'struct cxl_region_ref'
> @@ -1170,6 +1183,8 @@ static int cxl_port_attach_region(struct cxl_port *port,
>  		}
>  	}
>  
> +	cxl_region_set_lock(cxlr, cxld);
> +
>  	rc = cxl_rr_ep_add(cxl_rr, cxled);
>  	if (rc) {
>  		dev_dbg(&cxlr->dev,
> @@ -2439,6 +2454,7 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
>  	dev->bus = &cxl_bus_type;
>  	dev->type = &cxl_region_type;
>  	cxlr->id = id;
> +	cxl_region_set_lock(cxlr, &cxlrd->cxlsd.cxld);
>  
>  	return cxlr;
>  }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 231ddccf8977..6382f1983865 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -517,6 +517,14 @@ enum cxl_partition_mode {
>   */
>  #define CXL_REGION_F_NEEDS_RESET 1
>  
> +/*
> + * Indicate whether this region is locked due to 1 or more decoders that have
> + * been locked. The approach of all or nothing is taken with regard to the
> + * locked attribute. CXL_REGION_F_NEEDS_RESET should not be set if this flag is
> + * set.
> + */
> +#define CXL_REGION_F_LOCK 2
> +
>  /**
>   * struct cxl_region - CXL region
>   * @dev: This region's device
> 
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada

