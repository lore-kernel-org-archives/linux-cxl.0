Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B956E21C18A;
	Tue, 15 Jul 2025 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593628; cv=none; b=VY6SWYdFCIQZ/+tK+LjxQwLX+VcBVnnkyKlLD4bYEvtLFfRK+Yo7QiukYA3dXHOCXG+bBbXQTpfQLUyH2Ddjao0rpwi/jRX13Djt+aCmAhkJthzFtIUS+n4zpvfONcekd1XKwOzgg9j1uEmMyuXetKg9EXJ/1AXzyhPMsNcqnBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593628; c=relaxed/simple;
	bh=WDm9zE1TKhqjTbxi84Ch/HbXbONMz/SsFH2YNagjOoc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7S15W0r1tDDHvOJboY/X29wQZmAuVGxbMfSvl5Oi04UTK2CP6hL8Y4/uCA5TI4ui7w9j2mN0qBFpfCDjA5NB8UZ41/EZHnxby+hgOrdRfx8tF6vXSgpF4UL4NanNu7Jm+eFDYkE1lItwhXs2Lx0FrF9i8E1gxtY9YEhSdGAaoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhNRS2xGVz6L5FG;
	Tue, 15 Jul 2025 23:30:12 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8607D140275;
	Tue, 15 Jul 2025 23:33:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Jul
 2025 17:33:42 +0200
Date: Tue, 15 Jul 2025 16:33:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Davidlohr
 Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Peter
 Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH v3 6/8] cxl/region: Move ready-to-probe state check to a
 helper
Message-ID: <20250715163340.00002ddc@huawei.com>
In-Reply-To: <20250711234932.671292-7-dan.j.williams@intel.com>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
	<20250711234932.671292-7-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 11 Jul 2025 16:49:30 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Rather than unlocking the region rwsem in the middle of cxl_region_probe()
> create a helper for determining when the region is ready-to-probe.
I'd maybe mention the odd bit of 
if (rc)
	return rc;

return 0;

Will go away shortly. Or maybe that is overkill for a commit message.

Anyhow, with that in mind LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/region.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3a77aec2c447..2a97fa9a394f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3572,9 +3572,8 @@ static void shutdown_notifiers(void *_cxlr)
>  	unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
>  }
>  
> -static int cxl_region_probe(struct device *dev)
> +static int cxl_region_can_probe(struct cxl_region *cxlr)
>  {
> -	struct cxl_region *cxlr = to_cxl_region(dev);
>  	struct cxl_region_params *p = &cxlr->params;
>  	int rc;
>  
> @@ -3597,15 +3596,28 @@ static int cxl_region_probe(struct device *dev)
>  		goto out;
>  	}
>  
> -	/*
> -	 * From this point on any path that changes the region's state away from
> -	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
> -	 */
>  out:
>  	up_read(&cxl_region_rwsem);
>  
>  	if (rc)
>  		return rc;
> +	return 0;

This is an odd bit of code now.  Why not just

	return rc;

Ah. Patch 8 drops the if (rc) return rc bit.



> +}
> +
> +static int cxl_region_probe(struct device *dev)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_region_params *p = &cxlr->params;
> +	int rc;
> +
> +	rc = cxl_region_can_probe(cxlr);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * From this point on any path that changes the region's state away from
> +	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
> +	 */
>  
>  	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
>  	cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;

