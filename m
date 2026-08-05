Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37EE3E5EEC
	for <linux-cxl@vger.kernel.org>; Wed,  5 Aug 2026 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785917155; cv=none; b=HwVv+d9LtIQ7f5eeguwFtdXS+kZqDazBfLkRzELdH2M7jujm0E6cNw8PVokNaOAkyyTSpY0crPu8t/219wLDlRBODQzSVLtuJlJliqKF2bjBaDwGrRV2U1W9UQN6lIiYBtldGVvrKD3EVmHGz5KfURbCoRjejmC0eGmzcC1olhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785917155; c=relaxed/simple;
	bh=2fREaEvA6el9L/qfT572kQlR0g35U7CiN0JsjOqT/PY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BEVHm6CJc8qO1xIU+RfWi5DhhtURVItf4SVSLdDOtKJZ08Tp6SO71bx6PNQLl4G8BIXXLV1YE0+8D1KBdK81Kl5drgvu/9oHTzTHQpPrLe8bTaFX0vLz6DQ9qinFq250gAT+Bh6dMetowEKIQb3A5texzCOXUYPDCjLCwa2O/Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=le3woobJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="le3woobJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7489E1F000E9;
	Wed,  5 Aug 2026 08:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785917137;
	bh=cWwl5BwtqTrogMichxp+DBcQzrO+MczfkNxJhu18X9Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=le3woobJy+WTyFvBdOhK3Hxkvr2+C7nui42X1XZI5DLqfnC8PLYiM253291FxNJaA
	 oMHgTedQC8OsKj3tiu601WlN/BzI8/ZRPGW2F2USTvTl7MPmhf9u5ngoKIDk1A8HaZ
	 +5WueL+AWd5WlRFATS//GztMaepMPqBESfOOMGsWFOxRjFK0S0PcJGJgwxBiHk4nli
	 lYX/yzvNldl/svqIB/Y1teKPUGpcbKJQbXtmEEn6lt3PNiSldPuSq6El0Wa10UbTTK
	 76wYwA9Yd/+7t2OUyyCIJRMwPe/rZg0j2wllg+CcCeDWjNCo97BpshJZgjmAHqk0MY
	 3soDaT5D0Z3/w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/3] cxl/region: Auto-create a region for memdev
 attach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260805074042.30173-3-icheng@nvidia.com>
References: <20260805074042.30173-1-icheng@nvidia.com>
 <20260805074042.30173-3-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 08:05:36 +0000
Message-Id: <20260805080537.7489E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Mixing goto-based error handling with __free() or guard() cleanu=
p in the same function.

Pre-existing issues:
- [High] Self-deadlock in find_committed_attach_region() on the devm_add_ac=
tion_or_reset() error path due to function-scoped read lock on cxl_rwsem.re=
gion.
--

--- Patch [2]: [RFC PATCH 2/3] cxl/region: Auto-create a region for memdev =
attach ---
commit 5faea7eff07e5a585a3f3dc3abd38f41084338fd
Author: Richard Cheng <icheng@nvidia.com>

cxl/region: Auto-create a region for memdev attach

devm_cxl_probe_mem() currently fails when FW has not committed a region,
even when a Type-2 accelerator has usable CXL.mem capacity. This patch
auto-creates a region when no mapped decoder exists by selecting a manual
DEVMEM decoder and a compatible root decoder.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 7fcaddc61180d..4ceabdfdd3b6a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
[ ... ]
> +static struct cxl_region *
> +create_attach_region(struct cxl_endpoint_decoder *cxled,
> +		     struct cxl_root_decoder *cxlrd, resource_size_t size)
> +{
> +	struct cxl_region *cxlr;
> +	int rc;
> +
> +	guard(mutex)(&cxlrd->regions_lock);
> +	do {
[ ... ]
> +	rc =3D device_attach(&cxlr->dev);
> +	if (rc <=3D 0) {
> +		if (!rc)
> +			rc =3D -ENXIO;
> +		goto err_unregister;
> +	}
> +
> +	get_device(&cxlr->dev);
> +	return cxlr;
> +
> +err_unregister:
> +	unregister_region(cxlr, CXL_REGION_RESET_MANAGED_DETACH);
> +	return ERR_PTR(rc);
> +}

[Severity: Medium]
Is it acceptable to mix guard() based cleanup with goto-based error handling
in this function? According to the cleanup subsystem guidelines, functions
should ideally use scope-based cleanup exclusively or goto-based cleanup
exclusively to prevent complex ownership and LIFO ordering bugs.

[ ... ]
> +static int create_memdev_attach_region(struct cxl_memdev *cxlmd,
> +				       struct cxl_attach_region *attach)
> +{
> +	struct cxl_port *endpoint =3D cxlmd->endpoint;
> +	struct device *decoder_dev __free(put_device) =3D NULL;
> +	struct cxl_endpoint_decoder *cxled;
[ ... ]
> +	cxlrd =3D find_attach_root_decoder(cxled);
> +	if (IS_ERR(cxlrd)) {
> +		rc =3D PTR_ERR(cxlrd);
> +		dev_dbg(cxlmd->cxlds->dev,
> +			"no compatible Type-2 root decoder to auto-create a region for %s: %d=
\n",
> +			dev_name(&cxlmd->dev), rc);
> +		goto err_cleanup_dpa;
> +	}

[Severity: Medium]
Similar to create_attach_region() above, does mixing __free() and goto labe=
ls
in the same function conflict with the cleanup subsystem expectations?

[ ... ]
>  /*
> - * Runs in cxl_mem_probe context after successful endpoint probe, assume=
s the
> - * simple case of single mapped decoder per memdev.
> + * Attach to a firmware-precommitted region already mapped to the endpoi=
nt.
> + * Return 0 on success, -ENODEV when no region is present (the caller th=
en
> + * auto-creates one), or a negative errno for a present-but-unusable reg=
ion.
>   */
> -int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
> +static int find_committed_attach_region(struct cxl_memdev *cxlmd,
> +					struct cxl_attach_region *attach)
>  {
> -	struct cxl_attach_region *attach =3D
> -		container_of(cxlmd->attach, typeof(*attach), attach);
>  	struct cxl_port *endpoint =3D cxlmd->endpoint;
>  	struct cxl_endpoint_decoder *cxled;
>  	struct cxl_region *cxlr;
>  	int rc;
> =20
> -	/* hold endpoint lock to setup autoremove of the region */
> -	guard(device)(&endpoint->dev);
> -	if (!endpoint->dev.driver)
> -		return -ENXIO;
>  	guard(rwsem_read)(&cxl_rwsem.region);
>  	guard(rwsem_read)(&cxl_rwsem.dpa);
[ ... ]
> -	/* Only teardown regions that pass validation, ignore the rest */
> +	/* Only teardown regions that pass validation. */
>  	get_device(&cxlr->dev);
> -	rc =3D devm_add_action_or_reset(&endpoint->dev,
> -				      endpoint_unregister_region, cxlr);
> +	rc =3D devm_add_action_or_reset(&endpoint->dev, endpoint_unregister_reg=
ion,
> +				      cxlr);
>  	if (rc)
>  		return rc;

[Severity: High]
This is a pre-existing issue, but can this devm_add_action_or_reset() trigg=
er
a self-deadlock on failure?

Because the function scope is guarded by a read lock on cxl_rwsem.region:

    guard(rwsem_read)(&cxl_rwsem.region);

If devm_add_action_or_reset() fails, it immediately executes its callback
endpoint_unregister_region() inline. This callback eventually calls
unregister_region() and detach_target(), which attempts to acquire a write
lock on the same semaphore:

    ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region)

Since the current thread already holds the function-scoped read lock, would=
n't
this result in an ABBA-style self-deadlock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805074042.3017=
3-1-icheng@nvidia.com?part=3D2
