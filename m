Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A6C28000A
	for <linux-cxl@vger.kernel.org>; Tue, 19 Aug 2025 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616071; cv=none; b=pgqoAUzPkCpKYDIarazOPy+hXef8vXQWbMHYzVDKQx4hOZNddKhklRloinHKT+PzD8nfikBKvU22Bx+9pERkIVNDBnIAImvns3i8soaOA1ieT6NRp4ArvbcNoZHEyOq2o7FSFtiPf1RnSp8X6reWLoqSkLW4SSWbyHizD4Jnx0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616071; c=relaxed/simple;
	bh=OuUixBNZj9DENyibbsIUeFqKA9pR867qD3MroSNomGY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/lGjpey5guiL6Bg/VRy8efSWISRSymdwctEdVvfPY2EDPIVuCAfZT27vhtvqcZWGgxxGsi2Ofk3Khl2eGaUyMROuYjT03doZ5Dd/lL5M5XfPevJU5lAQYbpxC+ioY67wcmHiYcgT8TZJwLwYUT6wRepROkRyfHKHrtkNiZDLXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c5tCy0p3vz6GBtn;
	Tue, 19 Aug 2025 23:04:46 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 77826140427;
	Tue, 19 Aug 2025 23:07:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 19 Aug
 2025 17:07:46 +0200
Date: Tue, 19 Aug 2025 16:07:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 13/18] cxl/cache: Implement Cache ID Route Table
 programming
Message-ID: <20250819160744.00005535@huawei.com>
In-Reply-To: <20250812212921.9548-14-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
	<20250812212921.9548-14-Benjamin.Cheatham@amd.com>
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

On Tue, 12 Aug 2025 16:29:16 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> The CXL Cache ID Route Table is an optional capability for CXL-enabled
> upstream switch ports and CXL host bridges. This capability is required
> for having multiple CXL.cache enabled devices under a single port
> (CXL 3.2 8.2.4.28).
> 
> Implement route table programming. In the case BIOS has already
> programmed the route table(s), check the configuration for validity.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

Whilst it's a bit big, I'd smash this patch with the previous. They don't
really separate as we end up with things half done but not returning errors.

A lot of my initial comments on that patch were along the lines of
'you didn't check this' when turns out you did in this patch.

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
> +	while (i-- > 3)
> +		timeout *= 10;

I've no idea how that relates to the spec. Perhaps some comments.

> +
> +	timeout *= FIELD_GET(CXL_CACHE_IDRT_STAT_TIMEOUT_BASE_MASK, status);
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

It's 16bit so readw?

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

Maybe just start from 0. There aren't any other fields as long as we stick
to not reading and writing neighboring entry.

> +	entry_n |= FIELD_PREP(CXL_CACHE_IDRT_TARGETN_PORT_MASK, entry->port_num);
> +	entry_n |= CXL_CACHE_IDRT_TARGETN_VALID;
> +	writel(entry_n, port->regs.cidrt + CXL_CACHE_IDRT_TARGETN_OFFSET(id));

writew()

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

How could this happen?

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

I'm always moaning about these but to me combining assignment and
non assignment declarations just ends up hiding stuff.
I'd always burn a line to keep them separate.

> +	u32 cap, max_hdmd;
> +
> +	cap = readl(port->regs.cidrt + CXL_CACHE_IDRT_CAP_OFFSET);
> +	if (FIELD_GET(CXL_CACHE_IDRT_CAP_CNT_MASK, cap) < id)

Check if in 68B flit mode as if we are this number may need capping
to a much lower level (field description talks about this.

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

At this point entry is freed.  So by the time that action gets called
it's a use after free.  Maybe also need the _or_reset() variant
in case this call itself fails.

> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_port_program_cache_idrt, "CXL");

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

I'd get explicit in that name. It is an odd bit of design to have
the option for device to not require it so making it clear that
the absense of this bit doesn't mean it never makes the entrees
active / committed.  Maybe REQUIRES_COMMIT

> +#define CXL_CACHE_IDRT_CTRL_OFFSET 0x4
> +#define   CXL_CACHE_IDRT_CTRL_COMMIT BIT(0)
>  #define CXL_CACHE_IDRT_STAT_OFFSET 0x8
>  #define   CXL_CACHE_IDRT_STAT_COMMITTED BIT(0)
> +#define   CXL_CACHE_IDRT_STAT_ERR_COMMIT BIT(0)

Nope.  They aren't both BIT(0)

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

