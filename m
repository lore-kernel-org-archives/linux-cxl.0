Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CE2260587
	for <linux-cxl@vger.kernel.org>; Wed, 10 Sep 2025 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540237; cv=none; b=olvSy3CWW3mXEA8K3QRQ76vpaBVsJFO7oFIagGVQzmKVJwEjz4ZMFnX1JmGudnPAgvgrsVIKqZ2kpi0yZ12R5duovRaHbBCb+kIRyi4yWcag4LhITRBA0LUrjaYNCHESZV3+UQ9IZH8ScXSSPi+al5rlzdeIGma3umFGmrj2t+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540237; c=relaxed/simple;
	bh=xFg+hKJkwxWZzxqTCKag//2n04qag/hOEaUdQLpRnX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YxE5bUt7lNsZuzyl3a1cSwOHA7YtkC0uhplhuP/gZOC5kwc08CkURr/rdXhiJ5GjiMafTF27zek91LwG1lJKWfTruBGWPpURME/D4KqnXJU16qddBi6remCl03NRAu7hvwvwJvtflCxtbT4keBNhPLe+i6Q248jLAUiBOfbGIOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ip3Spzee; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ip3Spzee"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757540236; x=1789076236;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=xFg+hKJkwxWZzxqTCKag//2n04qag/hOEaUdQLpRnX4=;
  b=ip3SpzeeV+bvv5Iz02Pvg3Y+bPyut6c5hTGnOBd7SLL0TcKb6++BBWwL
   OG3PG+MJDDj0epGgTsEFE6hzD8FX/7AeHJ6E271WS/v8OMPm5ZPEUxSro
   l7noo8JhZ2JpkQrHMBADQpn5BqPKOhlc5JZIGTED0xA4t/h339V9c2JEv
   quThVtyrgtj5D5IjVJiTe4lzvofL5aL8UWvCvgXyj6Yd/lR8L56VbsOqr
   2b+IPFKmkRjevKgl20Gv0PuIrHUVYLic0OHBR6MmBDYHW2GT/GZCRCDy1
   W5boNxOCiWFKrPAI1wo351IraJxAlA1DUjt8mCfjwL7dxpThnoY4IEV8I
   A==;
X-CSE-ConnectionGUID: 9LCv2VP/TTCAaS3Sf7WDYw==
X-CSE-MsgGUID: gKdRVJckTuS1PY2+ZDj+AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59783493"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59783493"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 14:37:12 -0700
X-CSE-ConnectionGUID: aoPu6frFRFCr/k7VlrP5Qg==
X-CSE-MsgGUID: g/XkWy1HSi2auJvlGH2iiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="204281089"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.110.219]) ([10.125.110.219])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 14:37:11 -0700
Message-ID: <9e075ab1-5a5a-43da-a2a2-6af65f4ba935@intel.com>
Date: Wed, 10 Sep 2025 14:37:10 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/18] cxl/cache: Implement Cache ID Route Table
 programming
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, linux-cxl@vger.kernel.org
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-14-Benjamin.Cheatham@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250812212921.9548-14-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/25 2:29 PM, Ben Cheatham wrote:
> The CXL Cache ID Route Table is an optional capability for CXL-enabled
> upstream switch ports and CXL host bridges. This capability is required
> for having multiple CXL.cache enabled devices under a single port
> (CXL 3.2 8.2.4.28).
> 
> Implement route table programming. In the case BIOS has already
> programmed the route table(s), check the configuration for validity.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  drivers/cxl/cache.c     |   4 ++
>  drivers/cxl/core/port.c | 135 ++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |  10 +++
>  drivers/cxl/cxlcache.h  |   4 ++
>  4 files changed, 153 insertions(+)
> 
> diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
> index fd2ae1fa44bc..24559b9ba8e8 100644
> --- a/drivers/cxl/cache.c
> +++ b/drivers/cxl/cache.c
> @@ -134,6 +134,10 @@ static int devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd)
>  			if (rc)
>  				return rc;
>  		}
> +
> +		rc = devm_cxl_port_program_cache_idrt(port, dport, cxlcd);
> +		if (rc)
> +			return rc;
>  	}
>  
>  	return 0;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 26ea22a2638c..f491796f6e60 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -945,6 +945,141 @@ int cxl_dport_setup_snoop_filter(struct cxl_dport *dport)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dport_setup_snoop_filter, "CXL");
>  
> +static int cxl_port_commit_idrt(struct cxl_port *port)
> +{
> +	unsigned long timeout, start, end;
> +	u32 cap, ctrl, status;
> +	int i;
> +
> +	cap = readl(port->regs.cidrt + CXL_CACHE_IDRT_CAP_OFFSET);
> +	if (!(cap & CXL_CACHE_IDRT_CAP_COMMIT))
> +		return 0;
> +
> +	ctrl = readl(port->regs.cidrt + CXL_CACHE_IDRT_CTRL_OFFSET);
> +	if (ctrl & CXL_CACHE_IDRT_CTRL_COMMIT) {
> +		ctrl &= ~CXL_CACHE_IDRT_CTRL_COMMIT;
> +		writel(ctrl, port->regs.cidrt + CXL_CACHE_IDRT_CTRL_OFFSET);
> +	}
> +
> +	ctrl |= CXL_CACHE_IDRT_CTRL_COMMIT;
> +	writel(ctrl, port->regs.cidrt + CXL_CACHE_IDRT_CTRL_OFFSET);
> +
> +	status = readl(port->regs.cidrt + CXL_CACHE_IDRT_STAT_OFFSET);
> +
> +	i = FIELD_GET(CXL_CACHE_IDRT_STAT_TIMEOUT_SCALE_MASK, status);
> +	timeout = 1 * HZ;

timeout = HZ?

> +	while (i-- > 3)
> +		timeout *= 10;

A bit of magic numbers here. Create some defines to make it easier to understand why >3 and why *10. 
> +
> +	timeout *= FIELD_GET(CXL_CACHE_IDRT_STAT_TIMEOUT_BASE_MASK, status);

Maybe some comments on explaining how the timeout is calculated

DJ

> +	start = jiffies;
> +	do {
> +		status = readl(port->regs.cidrt + CXL_CACHE_IDRT_STAT_OFFSET);
> +		if (status & CXL_CACHE_IDRT_STAT_ERR_COMMIT)
> +			return -EBUSY;
> +
> +		if (status & CXL_CACHE_IDRT_STAT_COMMITTED)
> +			return 0;
> +
> +		end = jiffies;
> +	} while (time_before(end, start + timeout));
> +
> +	return -ETIMEDOUT;
> +}
> +
> +struct cxl_cache_idrt_entry {
> +	struct cxl_port *port;
> +	int port_num;
> +	int id;
> +};
> +
> +static int cxl_port_enable_idrt_entry(struct cxl_cache_idrt_entry *entry)
> +{
> +	struct cxl_port *port = entry->port;
> +	int id = entry->id, port_num;
> +	u32 entry_n;
> +
> +	entry_n = readl(port->regs.cidrt + CXL_CACHE_IDRT_TARGETN_OFFSET(id));
> +	if (entry_n & CXL_CACHE_IDRT_TARGETN_VALID) {
> +		port_num = FIELD_GET(CXL_CACHE_IDRT_TARGETN_PORT_MASK, entry_n);
> +		if (port_num != entry->port_num) {
> +			dev_err(&port->dev,
> +				"Cache ID Route Table entry%d: Invalid port id %d, expected %d\n",
> +				id, port_num, entry->port_num);
> +			return -EINVAL;
> +		}
> +
> +		return 0;
> +	}
> +
> +	entry_n &= ~CXL_CACHE_IDRT_TARGETN_PORT_MASK;
> +	entry_n |= FIELD_PREP(CXL_CACHE_IDRT_TARGETN_PORT_MASK, entry->port_num);
> +	entry_n |= CXL_CACHE_IDRT_TARGETN_VALID;
> +	writel(entry_n, port->regs.cidrt + CXL_CACHE_IDRT_TARGETN_OFFSET(id));
> +
> +	return cxl_port_commit_idrt(port);
> +}
> +
> +static void free_cache_idrt_entry(void *data)
> +{
> +	struct cxl_cache_idrt_entry *entry = data;
> +	struct cxl_port *port = entry->port;
> +	int id = entry->id;
> +	u32 cap, entry_n;
> +
> +	cap = readl(port->regs.cidrt + CXL_CACHE_IDRT_CAP_OFFSET);
> +	if (FIELD_GET(CXL_CACHE_IDRT_CAP_CNT_MASK, cap) < id)
> +		return;
> +
> +	entry_n = readl(port->regs.cidrt + CXL_CACHE_IDRT_TARGETN_OFFSET(id));
> +	entry_n &= ~CXL_CACHE_IDRT_TARGETN_VALID;
> +	writel(entry_n, port->regs.cidrt + CXL_CACHE_IDRT_TARGETN_OFFSET(id));
> +
> +	cxl_port_commit_idrt(port);
> +
> +	kfree(entry);
> +}
> +
> +int devm_cxl_port_program_cache_idrt(struct cxl_port *port,
> +				     struct cxl_dport *dport,
> +				     struct cxl_cachedev *cxlcd)
> +{
> +	struct cxl_cache_state *cstate = &cxlcd->cxlds->cstate;
> +	int id = cstate->cache_id, rc;
> +	u32 cap, max_hdmd;
> +
> +	cap = readl(port->regs.cidrt + CXL_CACHE_IDRT_CAP_OFFSET);
> +	if (FIELD_GET(CXL_CACHE_IDRT_CAP_CNT_MASK, cap) < id)
> +		return -EINVAL;
> +
> +	if (is_cxl_root(parent_port_of(port))) {
> +		max_hdmd = FIELD_GET(CXL_CACHE_IDRT_CAP_T2_MAX_MASK, cap);
> +		if (cxlcd->cxlds->type == CXL_DEVTYPE_DEVMEM && cstate->hdmd)
> +			port->nr_hdmd++;
> +
> +		if (port->nr_hdmd > max_hdmd) {
> +			port->nr_hdmd--;
> +			return -EINVAL;
> +		}
> +	}
> +
> +	struct cxl_cache_idrt_entry *entry __free(kfree) =
> +		kzalloc(sizeof(*entry), GFP_KERNEL);
> +	if (!entry)
> +		return -ENXIO;
> +
> +	entry->port_num = dport->port_id;
> +	entry->port = port;
> +	entry->id = id;
> +
> +	rc = cxl_port_enable_idrt_entry(entry);
> +	if (rc)
> +		return rc;
> +
> +	return devm_add_action(&cxlcd->dev, free_cache_idrt_entry, entry);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_port_program_cache_idrt, "CXL");
> +
>  DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
>  
>  static int cxl_einj_inject(void *data, u64 type)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c147846855e2..1a2918aaee62 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -163,8 +163,15 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  /* CXL 3.2 8.2.4.28 CXL Cache ID Route Table Capability Structure */
>  #define CXL_CACHE_IDRT_CAP_OFFSET 0x0
>  #define   CXL_CACHE_IDRT_CAP_CNT_MASK GENMASK(4, 0)
> +#define   CXL_CACHE_IDRT_CAP_T2_MAX_MASK GENMASK(11, 8)
> +#define   CXL_CACHE_IDRT_CAP_COMMIT BIT(16)
> +#define CXL_CACHE_IDRT_CTRL_OFFSET 0x4
> +#define   CXL_CACHE_IDRT_CTRL_COMMIT BIT(0)
>  #define CXL_CACHE_IDRT_STAT_OFFSET 0x8
>  #define   CXL_CACHE_IDRT_STAT_COMMITTED BIT(0)
> +#define   CXL_CACHE_IDRT_STAT_ERR_COMMIT BIT(0)
> +#define   CXL_CACHE_IDRT_STAT_TIMEOUT_SCALE_MASK GENMASK(11, 8)
> +#define   CXL_CACHE_IDRT_STAT_TIMEOUT_BASE_MASK GENMASK(15, 12)
>  #define CXL_CACHE_IDRT_TARGETN_OFFSET(n) (0x10 + (2 * (n)))
>  #define   CXL_CACHE_IDRT_TARGETN_VALID BIT(0)
>  #define   CXL_CACHE_IDRT_TARGETN_PORT_MASK GENMASK(15, 8)
> @@ -618,6 +625,7 @@ struct cxl_dax_region {
>   * @cdat: Cached CDAT data
>   * @cdat_available: Should a CDAT attribute be available in sysfs
>   * @pci_latency: Upstream latency in picoseconds
> + * @nr_hdmd: Number of HDM-D devices below port
>   */
>  struct cxl_port {
>  	struct device dev;
> @@ -643,6 +651,7 @@ struct cxl_port {
>  	} cdat;
>  	bool cdat_available;
>  	long pci_latency;
> +	int nr_hdmd;
>  };
>  
>  /**
> @@ -786,6 +795,7 @@ struct cxl_cache_state {
>  	u32 unit;
>  	u16 snoop_id;
>  	int cache_id;
> +	bool hdmd;
>  };
>  
>  /**
> diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
> index c4862f7e6edc..d28222123102 100644
> --- a/drivers/cxl/cxlcache.h
> +++ b/drivers/cxl/cxlcache.h
> @@ -28,4 +28,8 @@ struct cxl_cachedev *devm_cxl_add_cachedev(struct device *host,
>  
>  int cxl_dport_setup_snoop_filter(struct cxl_dport *dport);
>  int devm_cxl_snoop_filter_alloc(u32 gid, struct cxl_dev_state *cxlds);
> +
> +int devm_cxl_port_program_cache_idrt(struct cxl_port *port,
> +				     struct cxl_dport *dport,
> +				     struct cxl_cachedev *cxlcd);
>  #endif

