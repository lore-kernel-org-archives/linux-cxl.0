Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CC94219F2
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185785; cv=none; b=urPRbrZl4PlWiNqvIqq89QXcXXMXNVAiDvEHK+l0hytKRynvNkjSir4Sm0vymw7yz5l9nKakQxGclF9UcGd/fkoqOlt0V6dLbfkAkHCdbOAWFuqJbYHvHjO6KUuWDzejBQdPmd92fFnFN0BZ5zcR/JFqDXZT3qAUVd7spP66iWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185785; c=relaxed/simple;
	bh=zr0+eArNUZPM9G2BX8dSQvTt0XJNdEmIED9WHTZcyc4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UHEsV5G3b72qLq2uaRVF6NwIdilDRO6I8n5in7q0rGUCvIO6O92YSeyBhDUqVvyKAdgQXCwvwMCQoCv3JniiSZIuJv3ln0J8jXRhKRmEQmOGP+OtkpJUt6a/coBy1cF+/6N2F+Ds1xFCIZPdjotPqhZIwwzy+V7dIQP9me0OJkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWy55SVa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWy55SVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792281F00893;
	Wed, 23 Sep 2026 17:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790185783;
	bh=NSvLx4VIRsbr1hQJLnEsrhYVrziSdZNfCnyPS5aR078=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FWy55SVaMJx4TiUO06WYCVsVV2YE8kUeAgUugKPiadXMRNQ6sEsRIAqhQysWBsXI8
	 BU/ZUsaShu5HOIn108Wv+W5HQecZTUMVSS7L+lLyzCWb7D/I7lcdGKJk5JdrkBA3wB
	 YeCICrsxINg09qjvBQAueyAWOGir2Awh1nBEvX6Rrzg5NrT2ZKdKEZWkfXV2TrqgWe
	 RoxdjBKI520FIgTdDfho31+cxvAwnE+xKdK97oMcPeAcstqhpRktJSU9GZdhfUKEEK
	 VPp1EV+ypcpi+KW8bANcb457RKPmn2d0RxBy5t+yJ9gsCADEQz2AEqYrsxa9bYL4Pn
	 xHQF46zly/+2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/15] cxl/core: Add Cache ID verification
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Cheatham" <Benjamin.Cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260923173342.5584-10-Benjamin.Cheatham@amd.com>
References: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
 <20260923173342.5584-10-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 17:49:42 +0000
Message-Id: <20260923174942.792281F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] cxl/cache: missing rcu_read_lock during xa_for_each iteration
- [High] cxl/cache: unconditional probe failure for Restricted CXL Host (RC=
H) topologies
- [High] cxl/cache: use-after-free of parent_dport during asynchronous tear=
down
- [Medium] cxl/core: missing validation of hdmd state against hardware cach=
e ID
- [Low] cxl/core: returning negative error code for truthy boolean condition
--

commit fb180ed6317b83962ae34e684038bcea834c1f39
Author: Ben Cheatham <Benjamin.Cheatham@amd.com>

cxl/core: Add Cache ID verification
   =20
Check if system firmware has pre-programmed a CXL.cache device's cache
id as part of cxl_cache::probe(). A cache id is required when multiple
CXL.cache devices are present under a host bridge, so fail probe if the
id has not been programmed and another device is present.

Also add @hdmd to struct cxl_dev_state for endpoint drivers to indicate
whether their device is using HDM-D flows. This is required for
correctly validating cache id programming.

> diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
> index dfefd301696a2..6c098010149ae 100644
> --- a/drivers/cxl/cache.c
> +++ b/drivers/cxl/cache.c
> @@ -84,6 +84,90 @@ static int cxl_endpoint_cache_enabled(struct cxl_port =
*endpoint)
>  	return 0;
>  }
> =20
> +static struct cxl_port *find_host_bridge(struct cxl_port *endpoint)
> +{
> +	struct cxl_port *parent =3D endpoint->parent_dport->port;

[Severity: High]
Can this result in a use-after-free during asynchronous teardown?

When a CXL host bridge is hot-removed, the upstream CXL port topology can be
torn down, and devres can free parent_dport, before the PCI device is
unbound.

During PCI unbind, the cachedev's devres will call deprogram_cache_id()
which dereferences cxlcd->endpoint->parent_dport->port here, accessing
freed memory.

> +	struct cxl_port *hb =3D endpoint;
> +
> +	if (is_cxl_root(parent))
> +		return NULL;

[Severity: High]
Will this unconditionally fail probes for Restricted CXL Host (RCH)
topologies?

In an RCH topology, the endpoint's parent is the root port, so
is_cxl_root(parent) will evaluate to true immediately, causing
find_host_bridge() to return NULL.

Later in program_cache_id(), this NULL return causes the entire cache
programming and probe sequence to fail with -ENODEV.

> +
> +	while (!is_cxl_root(parent)) {
> +		hb =3D parent;
> +		parent =3D hb->parent_dport->port;
> +	}
> +
> +	return hb;
> +}
> +
> +static int get_num_cachedevs_present(struct cxl_port *host_bridge, u32 *=
num)
> +{
> +	u32 num_cachedevs =3D 0;
> +	unsigned long index;
> +	struct cxl_ep *ep;
> +
> +	xa_for_each(&host_bridge->endpoints, index, ep) {
> +		if (is_cxl_cachedev(ep->ep))
> +			num_cachedevs++;
> +	}

[Severity: High]
Is an rcu_read_lock() or xa_lock() required here when iterating the
host_bridge->endpoints array?

While program_cache_id() holds the host bridge device lock (hb->dev),
concurrent endpoint probes in cxl_add_ep() insert into this array without
holding the higher-level hb->dev lock.=20

Iterating xa_for_each() without RCU protection or the array's lock risks
data races and use-after-free, especially since cxl_ep_remove() can free the
endpoint structures concurrently.

[ ... ]
> diff --git a/drivers/cxl/core/cache.c b/drivers/cxl/core/cache.c
> index 17df0e603b68f..be570d3dc6090 100644
> --- a/drivers/cxl/core/cache.c
> +++ b/drivers/cxl/core/cache.c
> @@ -39,3 +39,161 @@ int cxl_dport_map_cache_id_dc(struct cxl_dport *dport)
>  	return cxl_map_component_regs(map, &dport->regs.component,
>  				      BIT(CXL_CM_CAP_CAP_ID_CACHE_ID_DC));
>  }
> +
> +static int cache_decoder_committed(struct cxl_dport *dport)
> +{
> +	u32 cap, stat;
> +
> +	cap =3D readl(dport->regs.ciddc + CXL_CACHE_ID_DC_CAP_OFFSET);
> +	if (!FIELD_GET(CXL_CACHE_ID_DC_CAP_COMMIT_REQ, cap))
> +		return -ENXIO;

[Severity: Low]
Is it safe to return a negative error code for a truthy boolean condition?

When the COMMIT_REQ bit is not set, this returns -ENXIO, which the caller
evaluates as truthy via negation (e.g., !cache_decoder_committed(dport)
evaluates to false since !(-ENXIO) is false).

While this happens to work in C, returning a negative integer to signify a
successful or truthy condition creates a silent refactoring hazard.

> +
> +	stat =3D readl(dport->regs.ciddc + CXL_CACHE_ID_DC_STATUS_OFFSET);
> +	return FIELD_GET(CXL_CACHE_ID_DC_STATUS_COMMITTED, stat);
> +}
> +
> +static int cache_decoder_get_id(struct cxl_dport *dport)
> +{
> +	u32 ctrl;
> +
> +	ctrl =3D readl(dport->regs.ciddc + CXL_CACHE_ID_DC_CTRL_OFFSET);
> +	if (FIELD_GET(CXL_CACHE_ID_DC_CTRL_HDMD_PRESENT, ctrl))
> +		 return FIELD_GET(CXL_CACHE_ID_DC_CTRL_HDMD_ID, ctrl);
> +
> +	return FIELD_GET(CXL_CACHE_ID_DC_CTRL_LOCAL_ID, ctrl);
> +}

[Severity: Medium]
Does this miss validating the hardware's HDM-D capability against the
endpoint driver's expectation?

The commit message notes that @hdmd is added to struct cxl_dev_state to
indicate whether the device uses HDM-D flows, and that this is required for
correctly validating cache id programming.=20

However, cache_decoder_get_id() parses the ID purely based on the hardware
HDMD_PRESENT bit, and cxl_cachedev_validate_cache_id() never
cross-references this with the software cxlds->hdmd state. Firmware
misconfigurations where the cache ID flow type doesn't match the endpoint
driver's requirement will go undetected.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923173342.5584=
-1-Benjamin.Cheatham@amd.com?part=3D9
