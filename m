Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568652253FC
	for <linux-cxl@vger.kernel.org>; Tue, 19 Aug 2025 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617207; cv=none; b=F3Zjwfr/NxIjokyqvrK8Cad9drYuJoMsRPleTcY6sQ5EFl8Q07yLIZKCq8TIhbH0mB3TWO2RhOChNmq6d2oIyp44/vRrR45YFopAZ+DC08fWcfaw4yKDft0kna+nHkjeksERDcikQzP3Gv1PQHtls8+EnIf3bKZlCsO4aSKxQ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617207; c=relaxed/simple;
	bh=hDq7BtGQ0QwiS9r+A1JN0gs1FMbtCtDzgqqHIWe8vSo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FfHMx7QmajM+Zh7OzqIVbfnOIE1rX+hBShHKOVuX1KhuNkHLSl9u6vVcOzcIvSBlYt7KSgEZgsR/a6Vr8dILOa+CLXfXh4cUuo8G5lG+mP/idlvd30Kz2z8xDHJ7bqnUIBOuPaHUzKcCbC8mViRt7q/Ix+FVx/JW/3i+s4S0Szo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c5tfj5rwTz6GFws;
	Tue, 19 Aug 2025 23:24:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 08982140372;
	Tue, 19 Aug 2025 23:26:36 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 19 Aug
 2025 17:26:35 +0200
Date: Tue, 19 Aug 2025 16:26:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 15/18] cxl/cache: Implement Cache ID Decoder
 programming
Message-ID: <20250819162634.00005f0f@huawei.com>
In-Reply-To: <20250812212921.9548-16-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
	<20250812212921.9548-16-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 12 Aug 2025 16:29:18 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> The CXL Cache ID Decoder capability is an optional capability present on
> CXL downstream switch and CXL-enabled PCIe Root ports. This capability
> is required for having multiple CXL.cache enabled devices under the same
> port (CXL 3.2 8.2.4.29).
> 
> Implement cache id decoder programming. Validate the configuration in the
> case BIOS already programmed the id(s).
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Comments from earlier on how the timeout is calculate apply here as well.
A few other things inline.

Thanks,

Jonathan

> ---
>  drivers/cxl/cache.c     |   4 ++
>  drivers/cxl/core/port.c | 109 ++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |  14 ++++++
>  drivers/cxl/cxlcache.h  |   3 ++
>  4 files changed, 130 insertions(+)
> 
> diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
> index f123d596187d..fa3223165a18 100644
> --- a/drivers/cxl/cache.c
> +++ b/drivers/cxl/cache.c
> @@ -163,6 +163,10 @@ static int devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd)
>  		rc = map_cache_idd_cap(dport);
>  		if (rc)
>  			return rc;
> +
> +		rc = cxl_dport_program_cache_idd(dport, cxlcd);
> +		if (rc)
> +			return rc;
>  	}
>  
>  	return 0;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index f491796f6e60..3606ad557bfb 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c


> +static int cxl_cache_idd_alread_programmed(struct cxl_dport *dport,
already?
> +					   struct cxl_cachedev *cxlcd)
> +{
> +	struct cxl_cache_state *cstate = &cxlcd->cxlds->cstate;
> +	u32 ctrl, status, cache_id;
> +
> +	status = readl(dport->regs.cidd + CXL_CACHE_IDD_STAT_OFFSET);
> +	if (!(status & CXL_CACHE_IDD_STAT_COMMITTED))
> +		return 0;
> +
> +	/*
> +	 * The decoder is probably already committed by BIOS, validate
> +	 * the configuration
> +	 */
> +	ctrl = readl(dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
> +	/* TODO: Check for 68B flit mode */
> +	if (dport == cxlcd->endpoint->parent_dport &&
> +	    !(ctrl & CXL_CACHE_IDD_CTRL_ASGN_ID))
> +		return -EINVAL;
> +
> +	if (dport != cxlcd->endpoint->parent_dport &&
> +	    !(ctrl & CXL_CACHE_IDD_CTRL_FWD_ID))
> +		return -EINVAL;
> +
> +	cache_id = FIELD_GET(CXL_CACHE_IDD_CTRL_LOCAL_ID_MASK, ctrl);
> +	if (cache_id != cstate->cache_id)
> +		return -EINVAL;
> +
> +	if (!!(ctrl & CXL_CACHE_IDD_CTRL_TYPE2) != cstate->hdmd)
> +		return -EINVAL;
> +
> +	return 1;
> +}
> +
> +int cxl_dport_program_cache_idd(struct cxl_dport *dport,
> +				struct cxl_cachedev *cxlcd)
> +{
> +	u32 ctrl;
> +	int rc;
> +
> +	rc = cxl_cache_idd_alread_programmed(dport, cxlcd);
> +	if (rc)
> +		return rc < 0 ? rc : 0;
> +
> +	ctrl = readl(dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
> +
> +	if (cxlcd->cxlds->cstate.hdmd) {
> +		ctrl |= CXL_CACHE_IDD_CTRL_TYPE2;
> +		ctrl &= ~CXL_CACHE_IDD_CTRL_TYPE2_ID_MASK;
> +		ctrl |= FIELD_PREP(CXL_CACHE_IDD_CTRL_TYPE2_ID_MASK, cxlcd->id);
> +	}
> +
> +	/* TODO: Check for 68B flit mode */
> +	if (dport == cxlcd->endpoint->parent_dport)
> +		ctrl |= CXL_CACHE_IDD_CTRL_ASGN_ID;
> +	else
> +		ctrl |= CXL_CACHE_IDD_CTRL_FWD_ID;
> +
> +	ctrl &= ~CXL_CACHE_IDD_CTRL_LOCAL_ID_MASK;
> +	ctrl |= FIELD_PREP(CXL_CACHE_IDD_CTRL_LOCAL_ID_MASK,
> +			   cxlcd->cxlds->cstate.cache_id);
> +
> +	writel(ctrl, dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
> +	return cxl_dport_commit_idd(dport);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dport_program_cache_idd, "CXL");

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 04fde1a994d0..9c475d8c1573 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -178,6 +178,20 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define   CXL_CACHE_IDRT_TARGETN_PORT_MASK GENMASK(15, 8)
>  
>  /* CXL 3.2 8.2.4.29 CXL Cache ID Decoder Capability Structure */
> +#define CXL_CACHE_IDD_CAP_OFFSET 0x0
> +#define   CXL_CACHE_IDD_CAP_COMMIT BIT(0)

Similar to before I'd name this something to indicate it's about
it being explicit / required by this device for things
to work.

> +#define CXL_CACHE_IDD_CTRL_OFFSET 0x4
> +#define   CXL_CACHE_IDD_CTRL_FWD_ID BIT(0)


