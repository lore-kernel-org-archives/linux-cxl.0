Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188FF1DA2F5;
	Fri, 13 Sep 2024 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233210; cv=none; b=IR6zpvNkbrq0i+A0qcrq48huOBzgJj42XhwrnBnYEzELbl4JjzfX5Z471hWcvne8ucHjjM9X0EONgyZ3Sl14h1THmq3BaN74htxSf4P6Ebg9FPCqLKgv6G4nDvtTKxZduxrDph4VhS1RJcbnW/3mr6E3wbRO0QMhdlRbduxPz6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233210; c=relaxed/simple;
	bh=VXcDxHOAh7TO4czNZZWoYSUiEXDPphH8+xi/j+NvWA0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Naet8rmubN3nCRJWD59RufWgezPm7QU8pIRkcfEbpQBbbxTABBH9uS/snM+rWcys2VTnmyIVTFQebYIXUoIPQ97LlPVxX/qV8GYmO7GSAMJZayKC1BNmv8nSvQkSyHHbW8pfzpuGgiw3vk85nAKYZTOVmCp8PiK6pyD6gob/9GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X4vlh0zcNz6GDD2;
	Fri, 13 Sep 2024 21:09:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 34FE8140519;
	Fri, 13 Sep 2024 21:13:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Sep
 2024 15:13:23 +0200
Date: Fri, 13 Sep 2024 14:13:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Ying Huang <ying.huang@intel.com>, Dave Jiang <dave.jiang@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, "Vishal Verma"
	<vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] cxl/region: Remove lock from memory notifier
 callback
Message-ID: <20240913141322.000037e0@Huawei.com>
In-Reply-To: <20240904-fix-notifiers-v3-1-576b4e950266@intel.com>
References: <20240904-fix-notifiers-v3-1-576b4e950266@intel.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 04 Sep 2024 09:47:54 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> In testing Dynamic Capacity Device (DCD) support, a lockdep splat
> revealed an ABBA issue between the memory notifiers and the DCD extent
> processing code.[0]  Changing the lock ordering within DCD proved
> difficult because regions must be stable while searching for the proper
> region and then the device lock must be held to properly notify the DAX
> region driver of memory changes.
> 
> Dan points out in the thread that notifiers should be able to trust that
> it is safe to access static data.  Region data is static once the device
> is realized and until it's destruction.  Thus it is better to manage the
> notifiers within the region driver.
> 
> Remove the need for a lock by ensuring the notifiers are active only
> during the region's lifetime.
> 
> Furthermore, remove cxl_region_nid() because resource can't be NULL
> while the region is stable.
> 
> Link: https://lore.kernel.org/all/66b4cf539a79b_a36e829416@iweiny-mobl.notmuch/ [0]
> Cc: Ying Huang <ying.huang@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ying Huang <ying.huang@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
A few comments on looking at this again, but all things that apply equally to old
code so maybe things for another day.

Jonathan

> ---
> Changes in v3:
> - [Ying: Add comment regarding cxl_region_rwsem]
> - [iweiny: pickup tags]
> - Link to v2: https://patch.msgid.link/20240814-fix-notifiers-v2-1-6bab38192c7c@intel.com
> 
> Changes in v2:
> - [djbw: remove cxl_region_nid()]
> - Link to v1: https://patch.msgid.link/20240813-fix-notifiers-v1-1-efd23a18688d@intel.com
> ---
>  drivers/cxl/core/region.c | 54 ++++++++++++++++++++++++++---------------------
>  1 file changed, 30 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 21ad5f242875..dbc9f8a4f603 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2313,8 +2313,6 @@ static void unregister_region(void *_cxlr)
>  	struct cxl_region_params *p = &cxlr->params;
>  	int i;
>  
> -	unregister_memory_notifier(&cxlr->memory_notifier);
> -	unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
>  	device_del(&cxlr->dev);
>  
>  	/*
> @@ -2391,18 +2389,6 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>  	return true;
>  }
>  
> -static int cxl_region_nid(struct cxl_region *cxlr)
> -{
> -	struct cxl_region_params *p = &cxlr->params;
> -	struct resource *res;
> -
> -	guard(rwsem_read)(&cxl_region_rwsem);
> -	res = p->res;
> -	if (!res)
> -		return NUMA_NO_NODE;
> -	return phys_to_target_node(res->start);
> -}
> -
>  static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
>  					  unsigned long action, void *arg)
>  {
> @@ -2415,7 +2401,11 @@ static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
>  	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
>  		return NOTIFY_DONE;
>  
> -	region_nid = cxl_region_nid(cxlr);
> +	/*
> +	 * No need to hold cxl_region_rwsem; region parameters are stable
> +	 * within the cxl_region driver.
> +	 */
> +	region_nid = phys_to_target_node(cxlr->params.res->start);
>  	if (nid != region_nid)
>  		return NOTIFY_DONE;
>  
> @@ -2434,7 +2424,11 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
>  	int *adist = data;
>  	int region_nid;
>  
> -	region_nid = cxl_region_nid(cxlr);
> +	/*
> +	 * No need to hold cxl_region_rwsem; region parameters are stable
> +	 * within the cxl_region driver.
> +	 */
> +	region_nid = phys_to_target_node(cxlr->params.res->start);
>  	if (nid != region_nid)
>  		return NOTIFY_OK;
>  
> @@ -2484,14 +2478,6 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	if (rc)
>  		goto err;
>  
> -	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
> -	cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;
> -	register_memory_notifier(&cxlr->memory_notifier);
> -
> -	cxlr->adist_notifier.notifier_call = cxl_region_calculate_adistance;
> -	cxlr->adist_notifier.priority = 100;
> -	register_mt_adistance_algorithm(&cxlr->adist_notifier);
> -
>  	rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
>  	if (rc)
>  		return ERR_PTR(rc);
> @@ -3386,6 +3372,14 @@ static int is_system_ram(struct resource *res, void *arg)
>  	return 1;
>  }
>  
> +static void shutdown_notifiers(void *_cxlr)
> +{
> +	struct cxl_region *cxlr = _cxlr;
> +
> +	unregister_memory_notifier(&cxlr->memory_notifier);
> +	unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
Flip order.

Makes zero real difference, but if we later end up with more to do
here for some reason there may be ordering requirements that will
care that this doesn't tear down in reverse of setup.

Mind you, see below.

> +}
> +
>  static int cxl_region_probe(struct device *dev)
>  {
>  	struct cxl_region *cxlr = to_cxl_region(dev);
> @@ -3418,6 +3412,18 @@ static int cxl_region_probe(struct device *dev)
>  out:
>  	up_read(&cxl_region_rwsem);
>  
> +	if (rc)
> +		return rc;
> +
> +	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
> +	cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;
> +	register_memory_notifier(&cxlr->memory_notifier);
Can in theory fail.  Today that is EEXIST only but who knows in future.
I think we should handle that and do two devm_add_action_or_reset() perhaps?


> +
> +	cxlr->adist_notifier.notifier_call = cxl_region_calculate_adistance;
> +	cxlr->adist_notifier.priority = 100;
> +	register_mt_adistance_algorithm(&cxlr->adist_notifier);
> +
> +	rc = devm_add_action_or_reset(&cxlr->dev, shutdown_notifiers, cxlr);
>  	if (rc)
>  		return rc;
>  
> 
> ---
> base-commit: 67784a74e258a467225f0e68335df77acd67b7ab
> change-id: 20240813-fix-notifiers-99c350b044a2
> 
> Best regards,

