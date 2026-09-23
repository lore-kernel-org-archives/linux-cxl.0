Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A40420486
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185770; cv=none; b=tMkE+gJhUk91GAa9vTiQ8iMcs6dhPNLiLj06F8enqAD682mjFLnMpJRJ+OpTCyh6NImhMDHaaKgt64K+QOOHMrpkYwa1BbO9+xo/zdrWl0Q80WbF707vMxzrWaJIUu52MF5AjR0QlX1WqO+nUgkab8esn5Kbw510G0sG+B5TPts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185770; c=relaxed/simple;
	bh=OU5ZGDh8wqNe+PXCiiXrM66mxwBj7wED8tyw6mcXYdk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LplNuSDPmxR9NKb0vMHFIn3Nv56YhOnIj3mEQWRXYKgpkRuhA8hmwwyqX1Sf517zb6OotBVLlZ9kGi3yIKDKOs2vt6jEilKbvjyWDJPlqgDjVcX1FC6Y059Ibc6uEfeF3ApLZDOkXBnHxXA+ZIxb8XhDxtchn4HY7o4bPCn+51k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZu5s/qO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZu5s/qO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86BB1F000FF;
	Wed, 23 Sep 2026 17:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790185767;
	bh=ztaL9DijclDSsLsj27FzmQE7HFHaSplfNZLIGpnYlTc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QZu5s/qOxcCthUu5+vJryqFgcNkJ2/8j1sE/voxYBn+dHdvYdQS59yDOt+qYPG6Us
	 VgGiI4tbP40ftRhEul36pH9cYPrsbLkO9mJbiJ+LKhMB2buYOaQcp1HNGiImbXj6d6
	 LDYD4iNbsuHuHvTu1o8AqzXOe7QnwluLQzld+EIXS024Uvn6hvjZ0SVeLCFI4jFqD3
	 8iviYze3OVLBPu24nNKFsSKVYzDlANIF/BJF7kb4lSCAW4ylbcXnzWtaY0NU9x6ujZ
	 NJTeJ/ZNwn92B3KrobfIyr+IapPEs1IXqTnKGtct6dDyi8nNwJj4GLqpsgddlVezov
	 vMOlHPT/bVOVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/15] cxl/core: Add Cache ID allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Cheatham" <Benjamin.Cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260923173342.5584-11-Benjamin.Cheatham@amd.com>
References: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
 <20260923173342.5584-11-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 17:49:26 +0000
Message-Id: <20260923174926.D86BB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] cxl: reference leak of CXL root device in cxl_cachedev_deprogram_c=
ache_id()
- [High] cxl: cxl_cid_program_decoder() fails to clear HDM-D fields
- [High] cxl: __deprogram_cache_id() clobbers valid routing table entries o=
f other devices
- [High] cxl: modifying decoder and routing registers while COMMIT bit is s=
et
- [High] cxl: toggling COMMIT bit without polling STATUS_COMMITTED causes r=
ace condition
- [Medium] cxl: get_max_cid() improperly returns 0 for zero-capacity routin=
g tables
--

commit 3ec914a55f349bd29cbb06f7c4d3468cbd56c388
Author: Ben Cheatham <Benjamin.Cheatham@amd.com>

    cxl/core: Add Cache ID allocation
   =20
    Add allocation and programming of CXL cache ids for struct
    cxl_cachedevs as part of cxl_cache::probe(). Programming only occurs
    when system firmware has not already programmed an id and the device is
    *not* using HDM-D flows.

> diff --git a/drivers/cxl/core/cache.c b/drivers/cxl/core/cache.c
> index be570d3dc6090..9c6c8ea713ef3 100644
> --- a/drivers/cxl/core/cache.c
> +++ b/drivers/cxl/core/cache.c
[ ... ]
> @@ -112,6 +116,260 @@ static int cache_idrt_entry_valid(struct cxl_port *=
port, int id)
[ ... ]
> +static int cxl_cid_commit_decoder(struct cxl_dport *dport)
> +{
> +	void __iomem *ciddc =3D dport->regs.ciddc;
> +	u32 cap, ctrl, status;
> +	u8 scale, base;
> +	int rc;
> +
> +	cap =3D readl(ciddc + CXL_CACHE_ID_DC_CAP_OFFSET);
> +	if (!FIELD_GET(CXL_CACHE_ID_DC_CAP_COMMIT_REQ, cap))
> +		return 0;
> +
> +	status =3D readl(ciddc + CXL_CACHE_ID_DC_STATUS_OFFSET);
> +	scale =3D FIELD_GET(CXL_CACHE_ID_DC_STATUS_TM_SCALE, status);
> +	base =3D FIELD_GET(CXL_CACHE_ID_DC_STATUS_TM_BASE, status);
> +
> +	ctrl =3D readl(ciddc + CXL_CACHE_ID_DC_CTRL_OFFSET);
> +	if (FIELD_GET(CXL_CACHE_ID_DC_CTRL_COMMIT, ctrl)) {
> +		ctrl &=3D ~CXL_CACHE_ID_DC_CTRL_COMMIT;
> +		writel(ctrl, ciddc + CXL_CACHE_ID_DC_CTRL_OFFSET);
> +	}
> +
> +	ctrl |=3D CXL_CACHE_ID_DC_CTRL_COMMIT;
> +	writel(ctrl, ciddc + CXL_CACHE_ID_DC_CTRL_OFFSET);

[Severity: High]
Does toggling the COMMIT bit from 1 to 0 to 1 without polling the status
register cause a race condition? If the hardware hasn't cleared the
STATUS_COMMITTED bit from the uncommit, the subsequent poll might immediate=
ly
succeed on the stale state before hardware processes the cycle.

> +
> +	rc =3D __cxl_cid_wait_commit(dport->dport_dev,
> +				   ciddc + CXL_CACHE_ID_DC_STATUS_OFFSET,
> +				   CXL_CACHE_ID_DC_STATUS_COMMITTED,
> +				   CXL_CACHE_ID_DC_STATUS_COMMIT_ERR, scale,
> +				   base);
[ ... ]
> +static int cxl_cid_program_decoder(struct cxl_dport *dport, int cid,
> +				   bool endpoint)
> +{
> +	void __iomem *ciddc =3D dport->regs.ciddc;
> +	u32 ctrl;
> +
> +	if (!ciddc)
> +		return -EINVAL;
> +
> +	ctrl =3D readl(ciddc + CXL_CACHE_ID_DC_CTRL_OFFSET);
> +
> +	/*
> +	 * The decoder may have been programmed before, so we zero out
> +	 * all the fields before writing to them
> +	 */
> +	ctrl &=3D ~(CXL_CACHE_ID_DC_CTRL_ASGN_ID | CXL_CACHE_ID_DC_CTRL_FWD_ID);

[Severity: High]
Does this actually zero out all the fields as the comment suggests? It looks
like CXL_CACHE_ID_DC_CTRL_HDMD_PRESENT and HDMD_ID are left intact, which
could result in hardware routing using a stale HDMD_ID instead of the
programmed LOCAL_ID if firmware previously set this up in HDM-D mode.

> +	if (endpoint) {
> +		ctrl |=3D CXL_CACHE_ID_DC_CTRL_ASGN_ID;
> +	} else {
> +		ctrl |=3D CXL_CACHE_ID_DC_CTRL_FWD_ID;
> +	}
> +
> +	FIELD_MODIFY(CXL_CACHE_ID_DC_CTRL_LOCAL_ID, &ctrl, cid);
> +	writel(ctrl, ciddc + CXL_CACHE_ID_DC_CTRL_OFFSET);

[Severity: High]
Could writing to the control register fail to take effect if the COMMIT bit
is still set (e.g. by firmware)? The register might ignore writes while
committed, which would cause the new configuration to be lost when
cxl_cid_commit_decoder() subsequently reads and commits the old value.

> +
> +	return cxl_cid_commit_decoder(dport);
> +}
> +
> +static int cxl_cid_commit_table(struct cxl_port *port)
> +{
> +	void __iomem *cidrt =3D port->regs.cidrt;
> +	u32 cap, ctrl, status;
> +	u8 scale, base;
> +	int rc;
> +
> +	cap =3D readl(cidrt + CXL_CACHE_ID_RT_CAP_OFFSET);
> +	if (!FIELD_GET(CXL_CACHE_ID_RT_CAP_COMMIT_REQ, cap))
> +		return 0;
> +
> +	status =3D readl(cidrt + CXL_CACHE_ID_RT_STATUS_OFFSET);
> +	scale =3D FIELD_GET(CXL_CACHE_ID_RT_STATUS_TM_SCALE, status);
> +	base =3D FIELD_GET(CXL_CACHE_ID_RT_STATUS_TM_BASE, status);
> +
> +	ctrl =3D readl(cidrt + CXL_CACHE_ID_RT_CTRL_OFFSET);
> +	if (FIELD_GET(CXL_CACHE_ID_RT_CTRL_COMMIT, ctrl)) {
> +		ctrl &=3D ~CXL_CACHE_ID_RT_CTRL_COMMIT;
> +		writel(ctrl, cidrt + CXL_CACHE_ID_RT_CTRL_OFFSET);
> +	}
> +
> +	ctrl |=3D CXL_CACHE_ID_RT_CTRL_COMMIT;
> +	writel(ctrl, cidrt + CXL_CACHE_ID_RT_CTRL_OFFSET);

[Severity: High]
Similar to cxl_cid_commit_decoder(), does this sequence risk a race conditi=
on
by clearing and setting the COMMIT bit without waiting for the status regis=
ter
to clear?

[ ... ]
> +static int cxl_cid_program_table_entry(struct cxl_port *port, int cid,
> +				       unsigned int dport_id)
> +{
> +	void __iomem *cidrt =3D port->regs.cidrt;
> +	u8 target_cnt, portn;
> +	u16 target_n;
> +	u32 cap;
[ ... ]
> +	target_n =3D CXL_CACHE_ID_RT_TARGETN_VALID;
> +	target_n |=3D FIELD_PREP(CXL_CACHE_ID_RT_TARGETN_PORTN, dport_id);
> +	writew(target_n, cidrt + CXL_CACHE_ID_RT_TARGETN_OFFSET(cid));

[Severity: High]
Can writing the new target to the routing table fail if the table is still
committed? Since the table is uncommitted in cxl_cid_commit_table() after
this write, hardware might ignore the write here.

> +
> +	return cxl_cid_commit_table(port);
> +}
> +
[ ... ]
> +static int get_max_cid(struct cxl_port *endpoint)
> +{
> +	struct cxl_port *port =3D parent_port_of(endpoint);
> +	void __iomem *cidrt;
> +	u32 cap;
> +	u8 cnt;
> +
> +	if (!port)
> +		return -EINVAL;
> +
> +	while (!is_cxl_root(port) && !is_cxl_root(parent_port_of(port)))
> +		port =3D parent_port_of(port);
> +
> +	cidrt =3D port->regs.cidrt;
> +	if (!cidrt)
> +		return -EINVAL;
> +
> +	cap =3D readl(cidrt + CXL_CACHE_ID_RT_CAP_OFFSET);
> +	cnt =3D FIELD_GET(CXL_CACHE_ID_RT_CAP_TARGET_CNT, cap);
> +	if (cnt =3D=3D 0)
> +		return 0;

[Severity: Medium]
Will returning 0 here for a zero-capacity routing table mislead the caller?
This seems to conflate a table with no capacity (0 entries) with a table
that has 1 entry (max ID 0), potentially allowing the IDA to allocate ID 0
and fail later. Should this return an error like -EINVAL instead?

[ ... ]
> @@ -196,4 +465,64 @@ int cxl_cachedev_validate_cache_id(struct cxl_cached=
ev *cxlcd)
>  	return 0;
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_cachedev_validate_cache_id, "cxl_cache");
> +
> +static void __deprogram_cache_id(struct cxl_cachedev *cxlcd,
> +				 struct cxl_port *stop)
> +{
> +	struct cxl_port *iter =3D cxlcd->endpoint->parent_dport->port;
> +
> +	/*
> +	 * Leave cache id decoders programmed; the table entry being invalidated
> +	 * should be enough
> +	 */
> +	while (!is_cxl_root(iter)) {
> +		cxl_cid_invalidate_table_entry(iter, cxlcd->cache_id);
> +
> +		if (iter =3D=3D stop)
> +			return;

[Severity: High]
Does invalidating the entry on the stop port before checking the loop
condition clobber valid routing table entries belonging to other devices?
When cxl_cid_program_table_entry() fails and triggers rollback, running
the invalidation on the failing stop port might destroy a legitimate
configuration owned by another port.

> +
> +		iter =3D parent_port_of(iter);
> +	}
> +}
[ ... ]
> +void cxl_cachedev_deprogram_cache_id(struct cxl_cachedev *cxlcd)
> +{
> +	struct cxl_root *root =3D find_cxl_root(cxlcd->endpoint);
> +
> +	if (!root)
> +		return;
> +
> +	__deprogram_cache_id(cxlcd, &root->port);
> +}

[Severity: High]
Does this leak the reference to the CXL root device? find_cxl_root()
returns a reference-counted device, but it appears to be missing a call
to put_device() before returning, which would pin the root device
in memory and prevent proper teardown.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923173342.5584=
-1-Benjamin.Cheatham@amd.com?part=3D10
