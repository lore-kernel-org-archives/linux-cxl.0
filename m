Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F20626E714
	for <linux-cxl@vger.kernel.org>; Tue, 19 Aug 2025 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616181; cv=none; b=NyMYaj2hKBPBHV6QvouYT5LUifKWfX0hZ1DMYK5zZSYC9Itl6prMUAtX9cDXkuBhecxHes5ydFWV/LQhbfQWYIJzh/fyGoT4VOUSDTy7dN6P7gmdK9crOmnn8k2rspkEexNJcerO0AzcB0eiQJLsB5e2D4NOEpOXRPKP7PjEc1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616181; c=relaxed/simple;
	bh=xoEx9K5rFZUNaV1N6/DYr96a6HkAker39TpfWy21fMo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjnrg1cCDxC+j8FS3dT9n76ySqx1ogXWTjDLnTeT0TJ8m1EHc4UbqH/n+H2Um22wdUr16Kck5KL5HL0A3mpf3E9YY8edXLESzhjTsT/mvRdLUgN96ytDuwOKI+qUqTESBW7qlTMRZ159MvPEzRLTHcoOatGGfkwXabz4N2wyfGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c5tH333hkz6H7Z6;
	Tue, 19 Aug 2025 23:07:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 988CF14020C;
	Tue, 19 Aug 2025 23:09:33 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 19 Aug
 2025 17:09:33 +0200
Date: Tue, 19 Aug 2025 16:09:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 12/18] cxl/cache: Add CXL Cache ID Route Table
 mapping
Message-ID: <20250819160931.00000ed4@huawei.com>
In-Reply-To: <20250812212921.9548-13-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
	<20250812212921.9548-13-Benjamin.Cheatham@amd.com>
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

On Tue, 12 Aug 2025 16:29:15 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> The CXL Cache ID Route Table is an optional capability implemented by
> CXL host bridges and CXL upstream switch ports. This capability is
> required for having multiple CXL.cache devices below a port (CXL 3.2
> 8.2.4.28).
> 
> Add mapping and allocation of cache ids to be used by the cache id
> route table and decoder capabilities. It's possible the id has already
> been programmed by BIOS, in that case use the preprogrammed value.
> Programming/validation of the capabilities by the OS will come in later
> commits.

Fine to leave this for later, but I'd not set the cached value to
something we haven't written.  Just leave it unset or error out until the
support is there.

> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  drivers/cxl/cache.c     | 87 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/core/regs.c | 13 ++++++
>  drivers/cxl/cxl.h       | 16 ++++++++
>  3 files changed, 115 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
> index 7ef36e4bbce8..fd2ae1fa44bc 100644
> --- a/drivers/cxl/cache.c
> +++ b/drivers/cxl/cache.c
> @@ -55,6 +55,90 @@ struct cxl_cachedev *devm_cxl_add_cachedev(struct device *host,
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_cachedev, "CXL");
> 
> +static int find_cache_id(struct cxl_cachedev *cxlcd)
> +{
> +	struct cxl_cache_state *cstate = &cxlcd->cxlds->cstate;
> +	u32 cap, count, entry, portn;
> +	struct cxl_dport *dport;
> +	struct cxl_port *port;
> +	int id;
> +
> +	if (cstate->cache_id != CXL_CACHE_ID_NO_ID)
> +		return cstate->cache_id;
> +
> +	dport = cxlcd->endpoint->parent_dport;
> +	if (!dport)
> +		return -ENODEV;
> +	port = dport->port;
> +
> +	cap = readl(port->regs.cidrt + CXL_CACHE_IDRT_CAP_OFFSET);
> +	count = FIELD_GET(CXL_CACHE_IDRT_CAP_CNT_MASK, cap);

Need to do the clamping dance for when operating in 68B flit mode?
Described in the register field definition in 82.2.4.28.1

> +
> +	for (id = 0; id < count; id++) {

I'd pull portn, entry and anything else you can into this scope

> +		entry = readl(port->regs.cidrt +
> +			      CXL_CACHE_IDRT_TARGETN_OFFSET(id));
> +		portn = FIELD_GET(CXL_CACHE_IDRT_TARGETN_PORT_MASK, entry);
> +		if (portn != dport->port_id &&
> +		    !(entry & CXL_CACHE_IDRT_TARGETN_VALID))
> +			continue;
> +
> +		cstate->cache_id = id;
> +		return 0;
> +	}
> +
> +	id = ida_alloc(&cache_id_ida, GFP_KERNEL);
> +	if (id < 0)
> +		return id;

ida_alloc_max(ida, count - 1, GFP_KERNEL) 
probably to avoid allocating an ID off the top.

If some IDs were programmed by the BIOS, but not one for this
device (maybe it turned up late) do you reserve the relevant
values in the ida?

> +
> +	cstate->cache_id = id;

Having this half state at the end of this patch makes things complex
to reason about.  If you really want to split it then return an error in
paths you haven't handled yet.


> +	return devm_add_action_or_reset(&cxlcd->dev, free_cache_id, cstate);
> +}
> +
> +static int devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd)
> +{
> +	struct cxl_port *endpoint = cxlcd->endpoint, *port;
> +	struct cxl_dport *dport;
> +	int rc;
> +
> +	for (dport = endpoint->parent_dport, port = parent_port_of(endpoint);
> +	     dport && port && !is_cxl_root(port);
> +	     dport = port->parent_dport, port = parent_port_of(port)) {
> +		guard(device)(&port->dev);
> +		rc = map_cache_idrt_cap(port);
> +		if (rc)
> +			return rc;
> +
> +		if (port == parent_port_of(endpoint)) {
> +			rc = find_cache_id(cxlcd);
> +			if (rc)
> +				return rc;
> +		}
> +	}
> +
> +	return 0;
> +}

>  
>  static struct cxl_driver cxl_cache_driver = {
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 0c8962fcad9b..0924127bd8fd 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -98,6 +98,18 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			length = CXL_SNOOP_FILTER_CAPABILITY_LENGTH;
>  			rmap = &map->snoop;
>  			break;
> +		case CXL_CM_CAP_CAP_ID_CIDRT: {
> +			int entry_cnt;
> +
> +			dev_dbg(dev,
> +				"found Cache ID route table capability (0x%x)\n",
> +				offset);
> +			entry_cnt = FIELD_GET(CXL_CACHE_IDRT_CAP_CNT_MASK,
> +					      hdr);
> +			length = 2 * entry_cnt + 0x010;

I'd drop the leading 0 so 0x10 that will bring it in line with the macro below.

> +			rmap = &map->cidrt;
> +			break;
> +		}
>  		default:
>  			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
>  				offset);
> @@ -218,6 +230,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
>  		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
>  		{ &map->component_map.ras, &regs->ras },
>  		{ &map->component_map.snoop, &regs->snoop },
> +		{ &map->component_map.cidrt, &regs->cidrt },
>  	};
>  	int i;


