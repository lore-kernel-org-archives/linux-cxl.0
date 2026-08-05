Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4803DAAB5
	for <linux-cxl@vger.kernel.org>; Wed,  5 Aug 2026 06:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910154; cv=none; b=MXlhtXqqzA004Bk3LaKI3iiZMwiO7kWkekr5pe4mFRrw3+F7/Rwkxj2OQljQUtfX72wqzOjFGIFYhacfZD4tUnXdJwi+jGkVbQjIPXCCxAsczA9Ec4E+KjkqU36aN6lcQK6nP/2RK2k+EwRAFfFpuywmf2+h+IGFeb9bCc4EgrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910154; c=relaxed/simple;
	bh=Gfzb9/Idtejj76zeD0WPA6Tk4XSbAz5x/VAN0o9xyR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PL9Sp0SdDbQjux+Wq+MpG9KIm2fhLfWshWejU2WRp8Lt01UQ9UPSyfBQm22u/3/yw+x+2OLYChKJEE+XcPR/lnCVwNnhbuliRZwQJcg3ZvGsBueuYywrQEznVbJOalM0iOeWbXudw5BDrnaPikqhutGumTTW7n/79i41mLTYX8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bn4Pe+PI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bn4Pe+PI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5321F000E9;
	Wed,  5 Aug 2026 06:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785910150;
	bh=OZ+DpQbdzdUUVzMXmFeacwZ0cfvuCKyfVCrYgfM2AMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bn4Pe+PIUKTETQ9jd0w/N84sVgsvrBL206LTKSux7JTR4hncCMHqbBtmFK/1i8s9y
	 M6W2bY49/uoSvdg8UmE00VarMXlZLBsOO3XxdzwQDOBBOk2PJfxcr5goH/rAjjeDSQ
	 luJTabzJrxepuWiUA27OhI6cgfRiAMRwNDCVVg14Amhrr7oh7Pz+/dUV+rsPx2zNF1
	 5J4arkMaVzHXTaBDXfWQ7y2dM4+LbtIwfpUNYTkIFw4OeS7HA8RckVfhxff6Uiip3n
	 EOrFrh5UvM19CzomAimVFqmwZEez+9FsGhXqqdeyQTRK41zho18Y+c5tQqxEqAinBB
	 A49iZRMunX+tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/3] cxl/hdm: Allow zero sized HDM decoders
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260805055524.22311-3-icheng@nvidia.com>
References: <20260805055524.22311-1-icheng@nvidia.com>
 <20260805055524.22311-3-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 06:09:09 +0000
Message-Id: <20260805060910.0C5321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The teardown logic for 0-sized decoders is broken by an early retu=
rn, causing a resource leak and permanently breaking the DPA LIFO state mac=
hine.
- [Medium] The poison scan for the skip range of an out-of-bounds empty dec=
oder is bypassed, missing hardware error queries.

Pre-existing issues:
- [High] The unmapped poison scan aborts prematurely, missing hardware erro=
r queries for subsequent partitions.
--

--- Patch [2]: [PATCH v9 2/3] cxl/hdm: Allow zero sized HDM decoders ---
commit 129bd5c21519972c027d6ca212a8591b5cea7517
Author: Richard Cheng <icheng@nvidia.com>

    cxl/hdm: Allow zero sized HDM decoders

This commit allows the kernel to accept and process zero-sized HDM decoders=
=20
instead of rejecting them during enumeration. It backs them with a kmalloc'=
d=20
resource and guards paths that do not apply to empty decoders.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b4..3b3cfa0f25074 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
[ ... ]
> @@ -545,7 +572,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  	struct device *dev =3D &cxled->cxld.dev;
> =20
>  	guard(rwsem_write)(&cxl_rwsem.dpa);
> -	if (!cxled->dpa_res)
> +	if (cxled_empty(cxled))
>  		return 0;

[Severity: High]
Does returning 0 here for 0-sized decoders bypass the release action?

If devm_cxl_dpa_release() is not called for 0-sized decoders, it appears
this would leak the reservation and prevent port->hdm_end from being=20
decremented, permanently breaking the DPA LIFO state machine for future=20
teardowns.

[ ... ]
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 45536909cc17d..e6929feb63786 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
[ ... ]
> @@ -2969,24 +2969,31 @@ static int poison_by_decoder(struct device *dev, =
void *arg)
>  	if (!cxled->dpa_res)
>  		return 0;
> =20
> -	cxlmd =3D cxled_to_memdev(cxled);
> -	cxlds =3D cxlmd->cxlds;
> -	mode =3D cxlds->part[cxled->part].mode;
> +	/*
> +	 * Handle the degenerate case of a device with only empty decoders. An
> +	 * empty decoder can still map a non-zero skip range, so advance the
> +	 * walk to commit_end either way.
> +	 */
> +	if (cxled->part >=3D 0) {

[Severity: Medium]
Will this condition skip checking poison in a valid skip range?=20

If firmware commits an empty decoder at an out-of-bounds base, cxled->part=
=20
would be -1. However, if its skip range is large enough to intersect a=20
valid partition, skipping this block seems to prevent querying the skipped=
=20
DPA space for hardware poison.

> +		cxlmd =3D cxled_to_memdev(cxled);
> +		cxlds =3D cxlmd->cxlds;
> +		mode =3D cxlds->part[cxled->part].mode;
> =20
> -	if (cxled->skip) {
> -		offset =3D cxled->dpa_res->start - cxled->skip;
> -		length =3D cxled->skip;
> -		rc =3D cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +		if (cxled->skip) {
> +			offset =3D cxled->dpa_res->start - cxled->skip;
> +			length =3D cxled->skip;
> +			rc =3D cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +			if (rc && !poison_efault_forgiven(rc, mode))
> +				return rc;
> +		}
[ ... ]
> @@ -3008,9 +3015,17 @@ int cxl_get_poison_by_endpoint(struct cxl_port *po=
rt)
>  	};
> =20
>  	rc =3D device_for_each_child(&port->dev, &ctx, poison_by_decoder);
> -	if (rc =3D=3D 1)
> +	if (rc =3D=3D 1) {
> +		/*
> +		 * No decoder with a sized DPA reservation was walked
> +		 * (every committed decoder is zero-size): scan all
> +		 * partitions in full.
> +		 */
> +		if (ctx.part < 0)
> +			ctx.part =3D 0;
>  		rc =3D cxl_get_poison_unmapped(to_cxl_memdev(port->uport_dev),
>  					     &ctx);

[Severity: High]
This is a pre-existing issue, but does cxl_get_poison_unmapped() abort=20
prematurely during its scan?

If a preceding partition is fully mapped, length evaluates to 0. In=20
cxl_get_poison_unmapped():

	for (int i =3D ctx->part; i < cxlds->nr_partitions; i++) {
		...
		length =3D res->end - offset + 1;
		if (!length)
			break;

Using break instead of continue here aborts the loop entirely. Does this=20
incorrectly skip hardware error queries for any subsequent unmapped=20
partitions (like PMEM)?

> +	}
> =20
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805055524.2231=
1-1-icheng@nvidia.com?part=3D2
