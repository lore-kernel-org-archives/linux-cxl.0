Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F79423761
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185748; cv=none; b=K9pOPBBKPSi1co7gB7sD5FyZzDHcAfK+QLXmTVMv293dDwI9oaNFosnQ+RUWqwVBlBmHKB63YcZQSg1GckfS7rgQYHY3Z88MRWp/Q/UY9lMPWANDnWXsZ8Rrw/zwv2LMahqIK4f4hZpwzz0PvAsUXoRe9vmAeWA7cLaB2x0x61U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185748; c=relaxed/simple;
	bh=j/ouevxr+F85HZKQ2gM2ReSniqCeXmS4/Yx9C+qFjw0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LvFr/bRpnUhPtOAn3fmO15xxYZFecf+zzhzDoMbqhQaoM2Y0QOnbPXL2Mxn5eV58VFNacOOp5UoiMAUI6qUZ7zTcsdolQ0KO0GjSjQUddBEahG2OPx6GKzJTkVIG67sO6nCIgvWvNABnM3JGJWjmOKUXwTi6orOSTOqZ12ctQfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN2lzs69; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN2lzs69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C9A1F000FF;
	Wed, 23 Sep 2026 17:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790185746;
	bh=3BZNtBFkI3SmgZQeqXPXZf+I2ospM7LDRJ0Qe7i9uOI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eN2lzs69g0i12hTvOWN90rzt5aUsFkOOplaEcmVpyeXkSn0qTWdJO9Rx+ISFk+scw
	 8pCYHyswwJSreOwRdx3yHFbxTmTqwMTs3vgIgmdUvzY29lMZwicGM9UbevVCJ7ZXKh
	 08uEalGaNf0iZKMX2naZ/H3j2DQahw/QEx2F7qT4qFQk/Ne2zaOlkvxOblkx9TqoIs
	 Y9qI3+0BTIUFbqJObc9YRlEpaZMlDaRubKwPOQvwTx3Ewon5QODdr497gXRjjg+bzx
	 Fif3XSr+D9lW05Hw+I9RXECZ8Bhc0b2FXkAkEFJAgKJsjsi1DoUBMvDFOVs/KukLXR
	 FESKOggQYCoCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/15] cxl/cache: Add cxl_cache driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Cheatham" <Benjamin.Cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260923173342.5584-3-Benjamin.Cheatham@amd.com>
References: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
 <20260923173342.5584-3-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 17:49:05 +0000
Message-Id: <20260923174905.E2C9A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] cxl/cache: kernel crash in cxl_clear_cache_enable() on non-PCI moc=
k devices
- [High] cxl/core: race condition in RMW of PCI_DVSEC_CXL_CTRL without lock=
ing
- [High] cxl/cache: NULL pointer dereference in probe due to early clear in=
 unregister
- [Medium] cxl/core: PCI config space corruption due to missing cxl_dvsec c=
apability check
- [Low] cxl/cache: build link failure when built-in driver calls devm_cxl_a=
dd_cachedev
--

commit bd84836a0f10aed3ee9d665572f6ba9474a6ea11
Author: Ben Cheatham <Benjamin.Cheatham@amd.com>
cxl/cache: Add cxl_cache driver

This commit adds the cxl_cache driver for managing CXL.cache capable endpoi=
nts
and validating system configurations. It provides functionality to get cache
information from the CXL device DVSEC and enables or disables CXL.cache dur=
ing
device probe.

> diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
> --- /dev/null
> +++ b/drivers/cxl/cache.c

[ ... ]

> +static int cxl_cache_probe(struct device *dev)
> +{
> +	struct cxl_cachedev *cxlcd =3D to_cxl_cachedev(dev);
> +	struct cxl_dev_state *cxlds =3D cxlcd->cxlds;
> +	int rc;
> +
> +	/* Disable CXL.cache until we can validate the device configuration */
> +	cxl_clear_cache_enable(cxlds);

[Severity: High]
Could cxl_clear_cache_enable() panic if a non-PCI device (such as a mock=20
device used in testing) is bound to the driver? It appears we blindly cast=
=20
to a struct pci_dev pointer inside cxl_set_protocol_enable() before any=20
dev_is_pci() check occurs.

[Severity: High]
Additionally, could this probe function race with device unregistration? If=
 a=20
sysfs unbind triggers cxl_cachedev_unregister(), it sets cxlcd->cxlds to=20
NULL before calling device_del(). If this probe runs concurrently, could it=
=20
retrieve the NULL pointer and pass it to cxl_clear_cache_enable(), resultin=
g=20
in a NULL pointer dereference?

> +
> +	rc =3D cxl_accel_read_cache_info(cxlds);
> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +}

[ ... ]

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c

[ ... ]

> -static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
> +static int cxl_set_protocol_enable(struct cxl_dev_state *cxlds, u16 val,
> +				   u16 enable_bit)
>  {
>  	struct pci_dev *pdev =3D to_pci_dev(cxlds->dev);
>  	int d =3D cxlds->cxl_dvsec;
> @@ -191,9 +193,9 @@ static int cxl_set_mem_enable(struct cxl_dev_state *c=
xlds, u16 val)
>  	if (rc)
>  		return pcibios_err_to_errno(rc);
> =20
> -	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) =3D=3D val)
> +	if ((ctrl & enable_bit) =3D=3D val)
>  		return 1;
> -	ctrl &=3D ~PCI_DVSEC_CXL_MEM_ENABLE;
> +	ctrl &=3D ~enable_bit;
>  	ctrl |=3D val;
> =20
>  	rc =3D pci_write_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, ctrl);

[Severity: High]
Is this read-modify-write cycle protected against concurrent modifications?=
 If
the cxl_mem and cxl_cache drivers probe concurrently, could one thread
overwrite the modifications of the other in the shared PCI_DVSEC_CXL_CTRL
register, potentially dropping the MEM_ENABLE bit while setting CACHE_ENABL=
E?

[Severity: Medium]
What happens if an endpoint driver adds a cache device on hardware lacking =
a=20
valid CXL DVSEC capability? If cxlds->cxl_dvsec is 0, this will calculate=20
d + PCI_DVSEC_CXL_CTRL (which is 0x0C) and overwrite the standard PCI Cache
Line Size register. Does this need a cxlds->cxl_dvsec > 0 check?

[ ... ]

> +int cxl_accel_read_cache_info(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_cache_state *cstate =3D &cxlds->cstate;
> +	struct pci_dev *pdev =3D to_pci_dev(cxlds->dev);
> +	int dvsec =3D cxlds->cxl_dvsec;
> +	u16 cap, cap2;
> +	u32 unit;
> +	int rc;
> +
> +	if (!dev_is_pci(cxlds->dev))
> +		return -EINVAL;
> +
> +	rc =3D pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);

[Severity: Medium]
Similarly, could this read garbage capability data from the standard PCI=20
Class Code register (0x0A) if cxlds->cxl_dvsec is 0?

> +	if (rc)
> +		return pcibios_err_to_errno(rc);

[ ... ]

> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h

[ ... ]

>  struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
>  				      struct range *range);
> -
>  int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
> +
> +#if IS_ENABLED(CONFIG_CXL_CACHE)
> +struct cxl_cachedev *devm_cxl_add_cachedev(struct cxl_dev_state *cxlds);
> +#else
> +static inline struct cxl_cachedev *
> +devm_cxl_add_cachedev(struct cxl_dev_state *cxlds)
> +{ return ERR_PTR(-ENXIO); }
> +#endif /* CONFIG_CXL_CACHE */

[Severity: Low]
Can this cause a build link failure if CONFIG_CXL_CACHE is built as a modul=
e=20
(=3Dm) but the endpoint driver calling devm_cxl_add_cachedev() is built-in =
(=3Dy)?=20

IS_ENABLED(CONFIG_CXL_CACHE) evaluates to true in this case, providing the=
=20
external declaration, but the symbol won't be available during vmlinux link=
ing.=20
Should this use IS_REACHABLE(CONFIG_CXL_CACHE) instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923173342.5584=
-1-Benjamin.Cheatham@amd.com?part=3D2
