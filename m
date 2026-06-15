Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65BA40B397
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jun 2026 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545285; cv=none; b=UyfJtbYsE2ABP7eohI7x/UXFDBuM8kenNsntiPPlZ/a3Jr8EhbZSeesa02xGlSZRdLwJiOwbtCmYB1sXZfFzYu+2OC7L6371mC4l93Z+LMYKWzMRVp3NMeoxXvW0Ymnpz5baMgI6sO92KfvqdACuJEAJlzIgjxFj//EmeAxEum8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545285; c=relaxed/simple;
	bh=wLc3GZFTyl0gtbOx4yrqszVHd7GS9WjqjeBfGyR/omk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fdioXN+MIn5lXnaDTWa5kTy22ewKV2r6PUi7Nltabc/RiXIclBrfdR9yL5fO9HwJlwan6V+44uUE/ViOi+GcYOF6w77/ITmEP5PmE02DwPqGRAyF9FPpdSvn9ZoWxll5EWT6inX0u0J9F4rs+SEfpLR05qJKFwd5xR15UgmKjhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQIZlrrh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQIZlrrh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B721F000E9;
	Mon, 15 Jun 2026 17:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781545283;
	bh=/HLCwxbCu+qwHcy6hdKGubNdHguRScgze9SYPF5NmGc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QQIZlrrhfRzZddLEj4lXwxhLZhwyV6UXtheK7Jiva9L4JWfXnZQamJCUyG+17GdrU
	 LBmn4ZUm9wvPdjVTNUUazwOg7bIlFttRwRBm573MKgmQ6oNekm1+cHnWXWfmIrCQ9W
	 oque/fPf5UV/LOUFTW259Rh0HRiWjnI3zturnwayrzvTTz4gn6GBy3ig7O8t8SIqS4
	 NUHrHPgUNCY83r8g3fNvdJIk3RxhiKFobL2b7TheaAhJHXhqJW8xAt7I/pi/sp/jlE
	 iBERmd9om7UQbJwuSxB5mYlDFlChDmSEZAUETLa+9oC31ycsPGaGz+pK0Fyyobpcuq
	 lQkXAgruteOBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] cxl: Add HDM-DB region creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Davidlohr Bueso" <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260615145529.13848-5-dave@stgolabs.net>
References: <20260615145529.13848-5-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 17:41:23 +0000
Message-Id: <20260615174123.73B721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Auto-discovered regions fail to inherit their coherency type from =
the root decoder, violating the design rule and potentially creating invali=
d region configurations.
- [Medium] Spurious `dev_WARN_ONCE` triggers in `cxl_rr_assign_decoder()` w=
hen attaching an endpoint decoder with a stale `DEVMEM` target type to an H=
DM-H (non-BI) region.
- [Medium] `bi_show` incorrectly reports that an auto-discovered endpoint d=
ecoder is configured for HDM-DB (BI=3D1) when it is operating with BI=3D0 i=
n hardware.
--

commit 913c2a59fed5b8381543ceb7345cd15ac2ea9d17
Author: Davidlohr Bueso <dave@stgolabs.net>

cxl: Add HDM-DB region creation

A region inherits its coherency from the chosen root decoder: HDM-DB
if the root has CXL_DECODER_F_BI, otherwise HDM-H.

[ ... ]

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index c5aacd7054f1d..71801dfd614b1 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c

[ ... ]

> @@ -233,6 +234,19 @@ static ssize_t mode_store(struct device *dev, struct=
 device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(mode);
> =20
> +static ssize_t bi_show(struct device *dev, struct device_attribute *attr,
> +		       char *buf)
> +{
> +	struct cxl_endpoint_decoder *cxled =3D to_cxl_endpoint_decoder(dev);
> +	struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
> +
> +	guard(rwsem_read)(&cxl_rwsem.region);
> +	return sysfs_emit(buf, "%d\n", cxlds->bi && cxled->cxld.region &&
> +			  cxled->cxld.target_type =3D=3D CXL_DECODER_DEVMEM);
> +}

[Severity: Medium]
Will this attribute show '1' for an auto-discovered DEVMEM endpoint decoder
even if it operates with BI=3D0 in hardware?

If Linux auto-discovers a DEVMEM decoder that intrinsically supports BI
(cxlds->bi is true), init_hdm_decoder() currently rejects it if the BI
control bit is set, so the hardware must be operating with BI=3D0. However,
this attribute seems to evaluate the state dynamically based on the device
capability rather than the hardware's actual BI configuration, contradicting
the sysfs documentation that says it shows '1' when "currently configured".

> +static DEVICE_ATTR_RO(bi);

[ ... ]

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e82..6eb852b514d3a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1132,11 +1132,13 @@ static int cxl_rr_assign_decoder(struct cxl_port =
*port, struct cxl_region *cxlr,
>  	/*
>  	 * Endpoints should already match the region type, but backstop that
>  	 * assumption with an assertion. Switch-decoders change mapping-type
> -	 * based on what is mapped when they are assigned to a region.
> +	 * based on what is mapped when they are assigned to a region. HDM-DB
> +	 * endpoint decoders inherit their type from cxlr->type below.
>  	 */
>  	dev_WARN_ONCE(&cxlr->dev,
>  		      port =3D=3D cxled_to_port(cxled) &&
> -			      cxld->target_type !=3D cxlr->type,
> +			      cxld->target_type !=3D cxlr->type &&
> +			      !cxl_root_decoder_is_bi(cxlr->cxlrd),
>  		      "%s:%s mismatch decoder type %d -> %d\n",
>  		      dev_name(&cxled_to_memdev(cxled)->dev),
>  		      dev_name(&cxld->dev), cxld->target_type, cxlr->type);

[Severity: Medium]
Does this logic trigger a spurious dev_WARN_ONCE() when attaching an
endpoint decoder with a stale DEVMEM target type to an HDM-H region?

When a region is dismantled, __cxl_decoder_detach() clears the decoder's
region assignment but doesn't reset its target_type, leaving it with a
stale DEVMEM target type. If it is later attached to an HDM-H (non-BI)
region, the check for cxld->target_type !=3D cxlr->type evaluates to true,
and the !cxl_root_decoder_is_bi(cxlr->cxlrd) check also evaluates to true.

Could this generate a spurious warning stack trace in dmesg during valid
user reconfigurations, potentially causing a panic if panic_on_warn is set?

[ ... ]

> @@ -2772,6 +2796,7 @@ static ssize_t create_region_store(struct device *d=
ev, const char *buf,
>  				   size_t len, enum cxl_partition_mode mode)
>  {
>  	struct cxl_root_decoder *cxlrd =3D to_cxl_root_decoder(dev);
> +	enum cxl_decoder_type target_type;
>  	struct cxl_region *cxlr;
>  	int rc, id;
> =20
> @@ -2779,7 +2804,14 @@ static ssize_t create_region_store(struct device *=
dev, const char *buf,
>  	if (rc !=3D 1)
>  		return -EINVAL;
> =20
> -	cxlr =3D __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
> +	/*
> +	 * The CFMWS dictates endpoint coherency: a BI-restricted Window
> +	 * produces an HDM-DB region; otherwise HDM-H.
> +	 */
> +	target_type =3D cxl_root_decoder_is_bi(cxlrd) ?
> +		CXL_DECODER_DEVMEM : CXL_DECODER_HOSTONLYMEM;
> +
> +	cxlr =3D __create_region(cxlrd, mode, id, target_type);

[Severity: High]
Does the auto-discovery path in construct_region() still blindly create
regions using the endpoint decoder's type?

The commit message dictates a strict design rule that a region inherits its
coherency from the chosen root decoder. The sysfs creation path correctly
enforces this here, but construct_region() appears to miss this update:

drivers/cxl/core/region.c:construct_region() {
    ...
		cxlr =3D __create_region(cxlrd, cxlds->part[part].mode,
				       atomic_read(&cxlrd->region_id),
				       cxled->cxld.target_type);
    ...
}

If firmware incorrectly programs an endpoint decoder as DEVMEM under an HDM=
-H
root decoder, could construct_region() create a DEVMEM region? Because both
the region and the endpoint have target_type =3D=3D DEVMEM, the mismatch wa=
rning
in cxl_rr_assign_decoder() would be bypassed, resulting in an invalid HDM-DB
region under a root decoder that cannot generate Back-Invalidates.

>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615145529.1384=
8-1-dave@stgolabs.net?part=3D4
