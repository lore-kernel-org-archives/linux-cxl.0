Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C78423EA4
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790186251; cv=none; b=V/6/oITEv1apCq/Y7eDndDbvdPvcEYJTaB19HBssmoueS150chg/WPhZr6pgZM6gXFl05hIcToWFmr4k941vFKqprrKeyNEDIpj/71v9GEHIpuO7bUFoYhYaWPdfTTUGp1g4ykCyypy0qA/g0Ru8NaIyAnvwskOxHbOH4Hec5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790186251; c=relaxed/simple;
	bh=Y9gPKjvyykgL4HjAAkdKGw+tHpAJwLWyF8HpTOKJWj0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=opwhhxHUUJ96rijxWd1pbD5F9mRREUHboGAqhyMjleLJY41bwn5BIqJmG/G8S7qqXBQdqnHToYKEflUbVus5ZNJbrNVKue29MHjM5bLOLYY3TOuHD6snBE6DEMBd/7KF07H7YF8fgCiUrV0Um1OaMQUJ/RNDVbIw717hVNMXvd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlklWdnN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlklWdnN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9041F000FF;
	Wed, 23 Sep 2026 17:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790186249;
	bh=coqOaQ+d2U8ZnF/LaNCvXZepeTd3RFRcPrWatU/Occ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nlklWdnNK2IySjlArlDTJdQJXh5x6JEsHVmBDuha/jswlX0lS697wQ524y0ff+CoI
	 j+V2IAn7u1IsvX1DT6cn+rYETpZiXww79cxFwfWutCth7Ua+Gefqxmseo67W91vGLN
	 QmHWrlJxb4rPtuyWNFpE6qrEELA3O4FJLIjciL7aBC69k1Hn0sWNDHSZADN2urf5AC
	 X7YECorsw+fM4tmzlrc55pMBPavuS57xSqd2k07ICb+bfAVWU3/Xg/+puzv9lbehYl
	 BwBvx8Mj7IQ9N55tC0RsPyH+yBLBk+XT05TktBLXRqehsQhTp7g7pPJE/Oz8z0EmBh
	 UPYkjWQBSfHBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/15] iommu, cxl: Configure IOMMU for CXL.cache
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Cheatham" <Benjamin.Cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260923173342.5584-15-Benjamin.Cheatham@amd.com>
References: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
 <20260923173342.5584-15-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 17:57:28 +0000
Message-Id: <20260923175729.1B9041F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] iommu/amd: undefined behavior from using undocumented hardware con=
trol bits
- [High] iommu/amd: SEV-SNP hardware restriction bypass for CXL.cache devic=
es
- [Medium] iommu/amd: cxl_cache_configure_iommu() fails due to incorrect -E=
NXIO return code
- [Medium] iommu/amd: CXL.cache devices miss identity domain fallback when =
IOMMU lacks ATS
- [Medium] cxl/cache: missing fallback to identity domain when ATS enableme=
nt fails
--

commit fde91018699b16a94e54a114be24afe059b28c07
Author: Ben Cheatham <Benjamin.Cheatham@amd.com>

iommu, cxl: Configure IOMMU for CXL.cache

Some IOMMU implementations require additional set up for enabling
ATS requests past enabling the base PCI ATS support. Create a callback
in the IOMMU core to be used by the CXL driver during device set up
that configures the IOMMU to handle ATS requests. Update the AMD IOMMU
driver with an implementation of this callback.

> diff --git a/drivers/cxl/core/cache.c b/drivers/cxl/core/cache.c
> index 429c997b2ada6..44323dfdb759d 100644
> --- a/drivers/cxl/core/cache.c
> +++ b/drivers/cxl/core/cache.c

[ ... ]

> @@ -806,3 +807,45 @@ void cxl_destroy_snoop_filters(void)
> =20
>  	xa_destroy(&snoop_filters);
>  }
> +
> +/**
> + * cxl_cache_configure_iommu() - Configure a device's IOMMU for CXL.cache
> + * @cxlds: struct cxl_dev_state of a cxl_cachedev that has been through
> + *	   CXL.cache probe
> + *
> + * Fails if the underlying PCI device supports ATS and IOMMU can't be
> + * configured, or if the device doesn't support ATS and is not attached =
to an
> + * identity IOMMU domain.
> + */
> +int cxl_cache_configure_iommu(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev =3D cxlds->dev;
> +	struct iommu_domain *domain;
> +	int rc;
> +
> +	lockdep_assert_held(&dev->mutex);
> +
> +	if (!dev->iommu || !dev->iommu->iommu_dev)
> +		return 0;
> +
> +	if (!device_iommu_capable(dev, IOMMU_CAP_PCI_ATS_SUPPORTED)) {
> +		domain =3D iommu_get_domain_for_dev(dev);
> +		if (!domain || domain->type !=3D IOMMU_DOMAIN_IDENTITY)
> +			return -EINVAL;
> +
> +		return 0;
> +	}
> +
> +	rc =3D iommu_enable_cxl_ats(cxlds->dev);
> +	if (rc =3D=3D -EOPNOTSUPP) {
> +		dev_warn(cxlds->dev,
> +			"IOMMU doesn't support enabling CXL ATS requests; CXL.cache may not f=
unction properly.");
> +		rc =3D 0;
> +	} else if (rc) {
> +		dev_err(cxlds->dev, "Failed to enable CXL ATS requests: %d\n",
> +			rc);
> +	}
> +
> +	return rc;
> +}

[Severity: Medium]
If iommu_enable_cxl_ats() fails (for example, returning -EINVAL because ATS
is disabled at runtime), initialization unconditionally fails here. Since A=
TS
is not strictly required when operating in an identity domain, should this
fall back to checking if the device is already attached to an
IOMMU_DOMAIN_IDENTITY before aborting?

> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_=
iommu_types.h
> index 3dbe20023456b..696d9879ce9b7 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h

[ ... ]

> @@ -107,6 +107,7 @@
> =20
> =20
>  /* Extended Feature 2 Bits */
> +#define FEATURE_CXLMEMATTR	BIT_ULL(0) /* WARNING: This bit isn't in the =
spec as of 09/26 */

[Severity: High]
Is it safe to define and use an undocumented hardware control bit? The comm=
it
explicitly states that FEATURE_CXLMEMATTR is guessed and not present in the
AMD IOMMU specification. Modifying undocumented hardware control bits based=
 on
guesses could trigger undefined behavior, memory corruption, or system pani=
cs
on real silicon.

>  #define FEATURE_SEVSNPIO_SUP	BIT_ULL(1)
>  #define FEATURE_GCR3TRPMODE	BIT_ULL(3)

[ ... ]

> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 40726dfef2733..e11f98db826e0 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c

[ ... ]

> @@ -1125,6 +1125,14 @@ static void iommu_enable_gt(struct amd_iommu *iomm=
u)
>  		iommu_feature_enable(iommu, CONTROL_GCR3TRPMODE);
>  }
> =20
> +static void iommu_enable_cxlmemattr(struct amd_iommu *iommu)
> +{
> +	if (!check_feature2(FEATURE_CXLMEMATTR) || !amd_iommu_iotlb_sup)
> +		return;
> +
> +	iommu_feature_enable(iommu, CONTROL_CXLMEMATTR_EN);
> +}

[Severity: High]
This code evaluates the guessed FEATURE_CXLMEMATTR bit and writes to the
hardware control register. Could this cause unpredictable hardware behavior
since the bit's functionality is not yet defined in the specification?

> +
>  /* sets a specific bit in the device table entry. */
>  static void set_dte_bit(struct dev_table_entry *dte, u8 bit)

[ ... ]

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 4dc306a4b5c62..78d34b9074503 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c

[ ... ]

> @@ -3190,6 +3201,14 @@ static int amd_iommu_def_domain_type(struct device=
 *dev)
>  		return IOMMU_DOMAIN_IDENTITY;
>  	}
> =20
> +	/*
> +	 * CXL.cache devices that have no ATS capability need a passthrough
> +	 * domain to function correctly.
> +	 */
> +	if (dev_is_pci(dev) && !pci_ats_supported(to_pci_dev(dev)) &&
> +	    cxl_cache_supported(to_pci_dev(dev)))
> +		return IOMMU_DOMAIN_IDENTITY;

[Severity: High]
Hardware explicitly prohibits identity mapping (DTE[Mode]=3D0) when SEV-SNP=
 is
active. By unconditionally returning IOMMU_DOMAIN_IDENTITY here, does this
bypass the global encryption checks that prevent this state? Forcing this
prohibited hardware state could cause hardware faults, MCEs, or memory
encryption bypass on SEV-SNP enabled systems.

[Severity: Medium]
Does this properly handle the case where the endpoint supports ATS but the
IOMMU globally lacks ATS capability (!amd_iommu_iotlb_sup)?

If the device has ATS, it is assigned a DMA domain here. But later,
cxl_cache_configure_iommu() will realize the IOMMU cannot support ATS and
will require an identity domain, causing initialization to fail with -EINVA=
L.
Should this also return an identity domain if the IOMMU itself lacks ATS
support?

> +
>  	return 0;
>  }
> =20
> @@ -3199,6 +3218,40 @@ static bool amd_iommu_enforce_cache_coherency(stru=
ct iommu_domain *domain)
>  	return true;
>  }
> =20
> +static int amd_iommu_enable_cxl_ats(struct device *dev)
> +{
> +	struct iommu_dev_data *dev_data =3D dev_iommu_priv_get(dev);
> +	int ret =3D 0;
> +
> +	if (!dev_data || !amd_iommu_iotlb_sup)
> +		return -EINVAL;
> +
> +	if (!check_feature2(FEATURE_CXLMEMATTR))
> +		return -ENXIO;

[Severity: Medium]
The core API contract expects -EOPNOTSUPP if the IOMMU does not support the
required CXL features, but this returns -ENXIO.

Since the caller in cxl_cache_configure_iommu() handles -EOPNOTSUPP
gracefully, will returning -ENXIO here cause CXL.cache device probe to fail
unconditionally on older AMD hardware instead of gracefully falling back?

> +
> +	mutex_lock(&dev_data->mutex);
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923173342.5584=
-1-Benjamin.Cheatham@amd.com?part=3D14
