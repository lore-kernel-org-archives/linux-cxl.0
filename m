Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DE03E765A
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790186316; cv=none; b=D/Nkrc/r4xDQdNG8/x26pEH9IGtAY73LTeOYHNds5UGG5DYWSYXPK+MtqI7YPX23I/DXxbFn9wVgsytOLZ+SCGFc8tVZeGh/W8DY02GH3Ggh3P4renx22eG7190uxkjkfTJxCBl1VfzMH5kNKi2P2bIQzptSLICLzv1Y/aYSvUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790186316; c=relaxed/simple;
	bh=i/WubQ/qvOyg7ws6wo31FLrS16kcKQvh20hl49msPSU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nriQ/fUOeviKfKNqAhMPoI3adgMwGdwqW7dfxNzZJi/41c5CPcfoU+kl4R9UPDsBY1WYF6e3VTsSN7Z68pDzVlUt1FIhw7cwaLRXsPC3snAF9dc/w7SCRU/8v1wiLwEnpCSSdGwbq+iGg0D2GLvLmufeomU841MFb8XDjxNm+Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Chvej8OP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Chvej8OP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A831F000FF;
	Wed, 23 Sep 2026 17:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790186314;
	bh=nq1Db/kZnNFcyetvhRicDNfoIaZdZ0MZMEMdvoYNj9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Chvej8OP9RhO7DWQpZgX/fXu7O4gu+z9XTS7CA5bggCjfJKFSzAAV3PxMmKGL8wi8
	 T7MTr66zy3uavMCNdzqvs8JTHp9H5KmqJaua7uRb1pFlW892EI+9bVxQP4/8YBzlV0
	 NHGTgJpAn/TN3aMFMwts1xTpymuV3lYI/6mZkZLhaUA90ioGosd7bnimBMtgNBJgja
	 +ml0uEvx3kh0AT20oxn0ZR7RUhlXJZHDi6wNm6W0o4iPzrftRvJq6jCgNn7Gl1R4vU
	 TJHotJ5Ny/DhDks3apqtEvsyAN4qlVVsykrXFfo7i6VFA/zB4X5bF86bn+T0PG1N3c
	 KzqlrB5psVOGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/15] cxl/cache: Add snoop filter allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Cheatham" <Benjamin.Cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260923173342.5584-14-Benjamin.Cheatham@amd.com>
References: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
 <20260923173342.5584-14-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 17:58:34 +0000
Message-Id: <20260923175834.B3A831F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] cxl: cxl_cachedev_find_snoop_gid() loop prematurely ignores root d=
ports
- [Medium] cxl: memory bloat from XArray with kernel pointer as index
--

commit 0d6bed69d638badd54cfffcfb59d4229114673a5
Author: Ben Cheatham <Benjamin.Cheatham@amd.com>

cxl/cache: Add snoop filter allocation

This commit adds snoop filter capacity allocation for CXL.cache devices.
Devices are expected to allocate snoop filter capacity equal to the size of
the address range they will cache before using the protocol. It also allows
devices to strictly fail allocations if the filter is full.

> diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
> index 40d1e8330df78..b4574a76ac0b8 100644
> --- a/drivers/cxl/cache.c
> +++ b/drivers/cxl/cache.c
> @@ -179,6 +179,20 @@ struct cxl_cachedev *devm_cxl_add_cachedev(struct cx=
l_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_cachedev, "CXL");
> =20
> +static int cxl_cachedev_find_snoop_gid(struct cxl_cachedev *cxlcd)
> +{
> +	struct cxl_dport *iter;
> +
> +	for (iter =3D cxlcd->endpoint->parent_dport;
> +	     iter && !is_cxl_root(iter->port);
> +	     iter =3D iter->port->parent_dport) {

[Severity: High]
Does this loop prematurely ignore snoop filters located on root ports?

The termination condition !is_cxl_root(iter->port) is evaluated before the
loop body. When iter reaches the cxl_dport of a host bridge (which is a
downstream port of the cxl_root port), iter->port points to the cxl_root
port. This makes is_cxl_root(iter->port) evaluate to true, causing the loop
to terminate immediately before checking iter->snoop.

Consequently, snoop filters located on host bridges are completely ignored.
If no intermediate switch has a snoop filter, will this cause
cxl_cache_probe() to unconditionally fail with -ENXIO for direct attached
devices?

> +		if (iter->snoop !=3D CXL_SNOOP_FILTER_NO_GROUP_ID)
> +			return iter->snoop;
> +	}
> +
> +	return -ENXIO;
> +}

[ ... ]

> diff --git a/drivers/cxl/core/cache.c b/drivers/cxl/core/cache.c
> index f07c49cfacec2..429c997b2ada6 100644
> --- a/drivers/cxl/core/cache.c
> +++ b/drivers/cxl/core/cache.c

[ ... ]

> @@ -638,6 +671,94 @@ static struct cxl_snoop_filter *find_or_add_snoop_fi=
lter(u64 size, int id)
>  	return sf;
>  }
> =20
> +static struct snoop_allocation *
> +snoop_alloc_capacity(struct cxl_snoop_filter *sf, struct cxl_cachedev *c=
xlcd,
> +		     u64 size)
> +{
> +	struct cxl_cache_state *cstate =3D &cxlcd->cxlds->cstate;
> +	struct snoop_allocation *alloc;
> +	int rc;
> +
> +	guard(mutex)(&sf->lock);
> +	if (sf->avail < size) {
> +		/*
> +		 * Either this device or a device already using the filter
> +		 * can't use an oversubscribed filter
> +		 */
> +		if (cstate->strict_snoop || sf->strict > 0)
> +			return ERR_PTR(-ENOSPC);
> +
> +		size =3D sf->avail;
> +	}
> +
> +	alloc =3D kmalloc_obj(*alloc);
> +	if (!alloc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*alloc =3D (struct snoop_allocation) {
> +		.cxlcd =3D cxlcd,
> +		.size =3D size,
> +		.strict =3D cstate->strict_snoop,
> +		.id =3D sf->id,
> +	};
> +
> +	rc =3D xa_insert(&sf->allocations, (unsigned long)alloc, alloc,
> +		       GFP_KERNEL);

[Severity: Medium]
Does using a kernel pointer as an XArray index cause memory bloat here?

On 64-bit architectures, kernel pointers have their high bits set. Using a
dense array structure like XArray for a highly sparse, massive index forces
it to allocate its maximum depth of internal xa_node radix tree levels
(typically 11 levels). This wastes thousands of bytes of memory per
allocation to track a single pointer.

Since the XArray is never used for index-based lookups (elements are only
erased by pointer during cleanup), would a standard struct list_head provide
the same functionality with better performance and no memory bloat?

> +	if (rc) {
> +		kfree(alloc);
> +		return ERR_PTR(rc);
> +	}
> +
> +	if (cstate->strict_snoop)
> +		sf->strict++;
> +
> +	sf->avail -=3D size;
> +	return alloc;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923173342.5584=
-1-Benjamin.Cheatham@amd.com?part=3D13
