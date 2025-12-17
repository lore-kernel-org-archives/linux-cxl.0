Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202AF346AF2
	for <linux-cxl@vger.kernel.org>; Wed, 17 Dec 2025 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988643; cv=none; b=rg3Q0sq1qxPTmL6VoS4/o7F+kKV1W193jxi0g63RkbSKQ5sh6++TUfV9an6ElgJI1ZQfLpSnuXlUkca4wPOJB8+MSyiyeNFdGdYhu9T0aaf+5frI4QmVKTNQK39PfB5xfxs3XTkc1Vv7ltJ9/43B3e0Ai7ITPWKu+vR830heu90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988643; c=relaxed/simple;
	bh=Yry1KLND7sK06gaFML0I+uo0BR1Oo2gshmm+0VerkIk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pgAX6MWv1ScuQifwYAX0VbFH9lMAheDSpoQosT05cIUkOsqQmYVLB2sVcv+/+cAwn4ZSTpAPUVeyMhWySs2wJO+8p7bthqzm4GEJUleEwBSGuzQPrG4Y92raYSkE8WBVOcD8d0M3oqZ5+XyEICVZyc3+7T7nOI0+QCBpmbj4C1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dWfHP4Gy7zJ46cM;
	Thu, 18 Dec 2025 00:23:29 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3373440578;
	Thu, 18 Dec 2025 00:23:59 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 17 Dec
 2025 16:23:58 +0000
Date: Wed, 17 Dec 2025 16:23:57 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 10/17] cxl/cache, mem: Prevent RAS register mapping race
Message-ID: <20251217162357.0000209c@huawei.com>
In-Reply-To: <20251111214032.8188-11-Benjamin.Cheatham@amd.com>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
	<20251111214032.8188-11-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 11 Nov 2025 15:40:25 -0600
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> CXL type 2 devices will register both a struct cxl_memdev and struct
> cxl_cachedev, both of which will attempt to map the parent dport's RAS
> registers in cxl_dport_init_ras_reporting(). While the immediate call
> fails gracefully, an error is emitted in the dmesg log by
> cxl_map_component_regs().
> 
> Avoid this error message by checking if the RAS registers are already
> mapped while the port's device lock is held.

This seems misleading. The check seems to be one whether
cdlds->cxlmd or cxlcd have already been configured rather than
just the RAS registers.

> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  drivers/cxl/cache.c | 11 +++++++++++
>  drivers/cxl/mem.c   |  5 +++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
> index 630452d53acc..4c9280c0ea72 100644
> --- a/drivers/cxl/cache.c
> +++ b/drivers/cxl/cache.c
> @@ -58,6 +58,7 @@ static int cxl_cache_probe(struct device *dev)
>  {
>  	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
>  	struct cxl_dev_state *cxlds = cxlcd->cxlds;
> +	struct device *endpoint_parent;
>  	struct cxl_dport *dport;
>  	int rc;
>  
> @@ -72,6 +73,16 @@ static int cxl_cache_probe(struct device *dev)
>  		return -ENXIO;
>  	}
>  
> +	if (dport->rch)
> +		endpoint_parent = parent_port->uport_dev;
> +	else
> +		endpoint_parent = &parent_port->dev;
> +
> +	scoped_guard(device, endpoint_parent) {
> +		if (!cxlds->cxlmd)
> +			cxl_dport_init_ras_reporting(dport, dev);
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 3b230f8c5925..35706ec1b7e1 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -129,9 +129,10 @@ static int cxl_mem_probe(struct device *dev)
>  	else
>  		endpoint_parent = &parent_port->dev;
>  
> -	cxl_dport_init_ras_reporting(dport, dev);
> -
>  	scoped_guard(device, endpoint_parent) {
> +		if (!cxlds->cxlcd)
> +			cxl_dport_init_ras_reporting(dport, dev);
> +
>  		if (!endpoint_parent->driver) {
>  			dev_err(dev, "CXL port topology %s not enabled\n",
>  				dev_name(endpoint_parent));

