Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09B2258EC3
	for <linux-cxl@vger.kernel.org>; Wed, 10 Sep 2025 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757539340; cv=none; b=GShFqG8JJDLFBRC3aY007T53/+6p+IQflxd+86qNWcVVepSHmqW1tTjkvzrScHa1nfbgQ1Y23YA3GLUprUJceRBUCzwL9ZerhksagQqVmtodwbaVWS/C+Rb1xWiFRfKkIHdEfl0wiaDXHPi7jh6ArDiV4nbGSLpwy/xQvCxkRbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757539340; c=relaxed/simple;
	bh=oxBa4fEoVX/Zxl43tp0Q8fbIMvhx4asw9bnEZTVQV7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jbGCDYog5l5aZCfrwMOA9T7c690rAOWxmkKNZKt4JW//VNiSbGbKGXeLt9ZfppLX84uZc4fUpLJ41aypzCUDksh8k21myzKsKUTqNidA40NCSxVYH1hdPilemWMrZ5UhDwxceNcO/WAoFGlVyvDF8jP1HDO7VKqk2jZvCL+CrWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M42/W1pv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M42/W1pv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757539339; x=1789075339;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=oxBa4fEoVX/Zxl43tp0Q8fbIMvhx4asw9bnEZTVQV7A=;
  b=M42/W1pvSSus9kbKw+PNJxgWZLDHLAXJ7LjN6caawEKrGJhWXjOUqsmB
   wzeMYtMmI3KrxqjsGkBE8UvwH1xg4+zN04CeSXF9XvmjzF+d2UBiJC9IT
   Wa0s5L+KI6X1LHwG0nkYxVG2FNr21h7RBo+ir6wFjoI2C5ZQhcSHw7x8L
   WxVC3EZqjl4TDCKryGWexQ1DFFrwod667rHZVqh7+b/QcVUx3XNAyWo+E
   PRuZVqYr2fx2OpDjqHPoPL7cbh0hobqIJgaKVlhO29ph+RA8QwZxhxWeE
   NJM7sM7CTsb85psmwG2wgOPznfCKjqWijkwKtN8Hd7hju/IpzWg06XDQM
   g==;
X-CSE-ConnectionGUID: vp52MblHSDWoBqxZCwEacw==
X-CSE-MsgGUID: TTZrMTf4S3SwyMpZTNoubw==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="60007875"
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="60007875"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 14:22:19 -0700
X-CSE-ConnectionGUID: R6o/haTaSk+pMiTNoY9OAQ==
X-CSE-MsgGUID: Y2VQH72ETz6yap9ap2WOFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="173879636"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.110.219]) ([10.125.110.219])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 14:22:18 -0700
Message-ID: <e9c93671-5e4c-4ca2-a521-608fe6544a21@intel.com>
Date: Wed, 10 Sep 2025 14:22:16 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/18] cxl/cache: Add CXL Cache ID Route Table mapping
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, linux-cxl@vger.kernel.org
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-13-Benjamin.Cheatham@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250812212921.9548-13-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/25 2:29 PM, Ben Cheatham wrote:
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
> +static DEFINE_IDA(cache_id_ida);
> +
> +static int map_cache_idrt_cap(struct cxl_port *port)
> +{
> +	if (port->regs.cidrt)
> +		return 0;
> +
> +	if (!port->reg_map.component_map.cidrt.valid)
> +		return -ENXIO;
> +
> +	return cxl_map_component_regs(&port->reg_map, &port->regs.component,
> +				      BIT(CXL_CM_CAP_CAP_ID_CIDRT));
> +}
> +
> +static void free_cache_id(void *data)
> +{
> +	struct cxl_cache_state *cstate = data;
> +
> +	ida_free(&cache_id_ida, cstate->cache_id);
> +}
> +
> +static int find_cache_id(struct cxl_cachedev *cxlcd)

get_cache_id()? since you are returning the id.

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
> +
> +	for (id = 0; id < count; id++) {
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
> +
> +	cstate->cache_id = id;
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

Would it make sense to map this once at enumeration instead of every allocation?

DJ
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
> +
>  static int find_snoop_gid(struct cxl_cachedev *cxlcd, u32 *gid)
>  {
>  	struct cxl_dport *iter = cxlcd->endpoint->parent_dport;
> @@ -122,7 +206,8 @@ static int cxl_cache_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> -	return 0;
> +
> +	return devm_cxl_cachedev_allocate_cache_id(cxlcd);
>  }
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
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 2881e0826829..c147846855e2 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -41,6 +41,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>  #define   CXL_CM_CAP_CAP_ID_RAS 0x2
>  #define   CXL_CM_CAP_CAP_ID_HDM 0x5
>  #define   CXL_CM_CAP_CAP_ID_SNOOP 0x9
> +#define   CXL_CM_CAP_CAP_ID_CIDRT 0xD
>  #define   CXL_CM_CAP_CAP_HDM_VERSION 1
>  
>  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
> @@ -159,6 +160,15 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define   CXL_SNOOP_FILTER_SIZE_MASK GENMASK(31, 0)
>  #define CXL_SNOOP_FILTER_CAPABILITY_LENGTH 0x8
>  
> +/* CXL 3.2 8.2.4.28 CXL Cache ID Route Table Capability Structure */
> +#define CXL_CACHE_IDRT_CAP_OFFSET 0x0
> +#define   CXL_CACHE_IDRT_CAP_CNT_MASK GENMASK(4, 0)
> +#define CXL_CACHE_IDRT_STAT_OFFSET 0x8
> +#define   CXL_CACHE_IDRT_STAT_COMMITTED BIT(0)
> +#define CXL_CACHE_IDRT_TARGETN_OFFSET(n) (0x10 + (2 * (n)))
> +#define   CXL_CACHE_IDRT_TARGETN_VALID BIT(0)
> +#define   CXL_CACHE_IDRT_TARGETN_PORT_MASK GENMASK(15, 8)
> +
>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
>  #define   CXLDEV_CAP_ARRAY_CAP_ID 0
> @@ -223,6 +233,7 @@ struct cxl_regs {
>  		void __iomem *hdm_decoder;
>  		void __iomem *ras;
>  		void __iomem *snoop;
> +		void __iomem *cidrt;
>  	);
>  	/*
>  	 * Common set of CXL Device register block base pointers
> @@ -266,6 +277,7 @@ struct cxl_component_reg_map {
>  	struct cxl_reg_map hdm_decoder;
>  	struct cxl_reg_map ras;
>  	struct cxl_reg_map snoop;
> +	struct cxl_reg_map cidrt;
>  };
>  
>  struct cxl_device_reg_map {
> @@ -618,6 +630,7 @@ struct cxl_port {
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
>  	struct cxl_register_map reg_map;
> +	struct cxl_regs regs;
>  	int total_dports;
>  	int nr_dports;
>  	int hdm_end;
> @@ -766,10 +779,13 @@ struct cxl_dev_ops {
>  	int (*probe)(struct device *cxldev);
>  };
>  
> +#define CXL_CACHE_ID_NO_ID (-1)
> +
>  struct cxl_cache_state {
>  	u64 size;
>  	u32 unit;
>  	u16 snoop_id;
> +	int cache_id;
>  };
>  
>  /**

