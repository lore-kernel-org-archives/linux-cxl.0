Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571857;
	b=lwMki8epKdv9sSLQlfrIjalMUVcYlottY261nSSzTG1NDAjAgYqHS+hbTy1S3PBCU3Fj
	 ykYw514IEOT6/RD3PYbGHPT13NIap5OyqAu32kSa6ibudBbOpgqTDI42SrBVHUaDoqVTx
	 uXyj4WeUKm0QKMVuhX3axZQkeH2X35le8zDS7NIw537tOOM8pPguYEc92vWX3MXzHUtoC
	 yTwFkkGpGwPawJu0S7JnEXhUvV8DN7fdVTJ4LT4VaPCsH8FTMwX8yhhXQ6BkyqsaFxjQe
	 9NnkIIRhxbki/giHuOO4wJbzWXiCEmz0bm0fxDgxcf9mzvkearGpafn9dNz2qka2WHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571857;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XsL0I3dILPl644yu1R6hdCjATiRmOsFMtZg1SW8wUJs=;
	b=0kvWsVWXEWZCW+4UK9uBiX0EEf2/5MJkg0VvsVNpkmY54N5qpTueHo93kJrey/+Mc80M
	 YkvSw9uodDNPYrVbRtVaIR5r5VHd0wcA/ss4vfRL5i9HnYXEOdb3Onrz4lbGTMhWUZbj+
	 fPJ/yRfXxkTcg1up6wp8YGE0TgH23vQkO/7OL2esNYqgJyJjJZ0U3qMezIqPdCgMU3uC/
	 dDAaLfdlTdbJuRMx1AGw/Q2b6PK6AICTQFyJdHMsxLKlxaAwFz5uL7upeA4CfIYFCejzz
	 MYTglgFgBwBpf+o+5vOqo/1ihO0j40rXp27mbVXkzJYZR1Da29zbBZzGe+kn9xBODZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MnUZxm7d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CEB606F694
	for <linux-cxl@vger.kernel.org>; Sun,  1 Nov 2026 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MnUZxm7d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E471F00A25;
	Sun,  1 Nov 2026 22:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571857;
	bh=XsL0I3dILPl644yu1R6hdCjATiRmOsFMtZg1SW8wUJs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MnUZxm7d6m+TxvJZ0HOR8xKi2myLcY00unDzVuz0BfpaYopEDxIi4gbSXOm4i2gvM
	 zodhiuY4QYsGK24Q9PipeYMJ5bIXo15HaqctiLoCcjK/8j6IS2nbYMT8Jb8pnyBnM8
	 NPWKvaOEkeYBGVh13lJDQfUaXxN3fymKwMsnmJRDqmgqnTHyUQt/cAQTnJIpxo0UoA
	 7VZbB9cCLhYqRt6sba3YfBnoZQxEKSHJWGc3oH5IjWoHqYrTrls3bZCNDgB2fcp0zi
	 5c0vSmWocliUbAJ/XXFA5jr4dWeN1Fxb5+5bLYMwrYQebl2GNVU/O0EKctS1g8znD5
	 EuPIZkPNw3o/Q==
Message-ID: <sashiko-outbox-192709@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 04/10] cxl: Add HDM-DB region creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Davidlohr Bueso" <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <187374442f21d6cc52ec6b9e390550db198f05c2.1793567979.git.dave@stgolabs.net>
References: <cover.1793567979.git.dave@stgolabs.net>
 <187374442f21d6cc52ec6b9e390550db198f05c2.1793567979.git.dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 22:24:16 +0000
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] cxl/acpi: cxl_acpi_cfmws_verify() rejects Host-only + BI windows=
 on QEMU 11.0+
- [Medium] cxl: stale cxlds->bi state on reset in cxl_region_decode_commit()
- [Low] cxl/acpi: unreachable third coherency check in cxl_acpi_cfmws_verif=
y()
--

commit d4a68ccdfa9e0e2b1d3fcb54967d9cb568d07b31
Author: Davidlohr Bueso <dave@stgolabs.net>

cxl: Add HDM-DB region creation

This commit adds support for creating HDM-DB (device-coherent with
back-invalidate) CXL regions via sysfs and auto-assembly, introduces
CFMWS coherency verification in cxl_acpi_cfmws_verify(), and exposes the
cap_back_invalidate and back_invalidate sysfs attributes.

> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index b7ce6b59c680b..cc7c99d3066d8 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -152,6 +152,8 @@ static unsigned long cfmws_to_decoder_flags(int restr=
ictions)
>  		flags |=3D CXL_DECODER_F_PMEM;
>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
>  		flags |=3D CXL_DECODER_F_LOCK;
> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)
> +		flags |=3D CXL_DECODER_F_BI;
> =20
>  	return flags;
>  }
> @@ -198,6 +200,24 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
>  		dev_dbg(dev, "CFMWS length %d greater than expected %d\n",
>  			cfmws->header.length, expected_len);
> =20
> +	if ((cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM) &&
> +	    (cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)) {
> +		dev_err(dev, "CFMWS cannot have both HDM-H and HDM-DB\n");
> +		return -EINVAL;
> +	}

[Severity: Medium]
As reported by Alison Schofield on v9 [1], does rejecting the entire CFMWS
window in cxl_acpi_cfmws_verify() when both ACPI_CEDT_CFMWS_RESTRICT_HOSTON=
LYMEM
and ACPI_CEDT_CFMWS_RESTRICT_BI are set cause a regression on released QEMU
v11.0+ systems?

During cxl_acpi_probe() -> acpi_table_parse_cedt() -> cxl_parse_cfmws() ->
__cxl_parse_cfmws() -> cxl_acpi_cfmws_verify(), returning -EINVAL for this
combination aborts root decoder registration completely. Because released
QEMU versions from v11.0 onward set both restriction bits by default, CXL
windows are rejected at boot and manual HDM-H region creation is lost on
windows where BI was previously ignored.

Could cfmws_to_decoder_flags() withhold CXL_DECODER_F_BI when
ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM is set (or when
ACPI_CEDT_CFMWS_RESTRICT_DEVMEM is not set) instead of failing the entire
window in cxl_acpi_cfmws_verify()?

> +
> +	if (!(cfmws->restrictions & (ACPI_CEDT_CFMWS_RESTRICT_DEVMEM |
> +				     ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM))) {
> +		dev_err(dev, "CFMWS has no coherency model\n");
> +		return -EINVAL;
> +	}
> +
> +	if ((cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI) &&
> +	    !(cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_DEVMEM)) {
> +		dev_err(dev, "CFMWS BI requires device-coherent\n");
> +		return -EINVAL;
> +	}

[Severity: Low]
Can this third check in cxl_acpi_cfmws_verify() ever be reached?

For (cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI) &&
!(cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_DEVMEM) to evaluate to
true, ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM must be either set or clear:

- If ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM is set, the first check
  ((cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM) &&
  (cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)) already returns
  -EINVAL.

- If ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM is clear (with
  ACPI_CEDT_CFMWS_RESTRICT_DEVMEM also clear), the second check
  (!(cfmws->restrictions & (ACPI_CEDT_CFMWS_RESTRICT_DEVMEM |
  ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM))) already logs "CFMWS has no
  coherency model" and returns -EINVAL.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a048bd5c06cb6..28c61feef06d2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -313,8 +313,25 @@ static int commit_decoder(struct cxl_decoder *cxld)
>  static int cxl_region_decode_commit(struct cxl_region *cxlr)
>  {
>  	struct cxl_region_params *p =3D &cxlr->params;
> +	bool hdm_db;
>  	int i, rc =3D 0;
> =20
> +	hdm_db =3D cxlr->type =3D=3D CXL_DECODER_DEVMEM &&
> +		 cxl_root_decoder_is_bi(cxlr->cxlrd);
> +
> +	/* a reset since attach may have invalidated cxlds->bi */
> +	for (i =3D 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled =3D p->targets[i];
> +		struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
> +
> +		if (hdm_db && !cxlmd->cxlds->bi) {
> +			dev_err(&cxlr->dev, "%s:%s BI not enabled on device\n",
> +				dev_name(&cxlmd->dev),
> +				dev_name(&cxled->cxld.dev));
> +			return -ENXIO;
> +		}
> +	}
> +
>  	for (i =3D 0; i < p->nr_targets; i++) {
>  		struct cxl_endpoint_decoder *cxled =3D p->targets[i];
>  		struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
> @@ -346,6 +363,21 @@ static int cxl_region_decode_commit(struct cxl_regio=
n *cxlr)
>  			cxled->cxld.reset(&cxled->cxld);
>  			goto err;
>  		}
> +
> +		/*
> +		 * A reset after the check above wipes BI Enable, but
> +		 * cxlds->bi is only refreshed from .reset_done, which may
> +		 * not have run. Ask the hardware.
> +		 */
> +		if (hdm_db && !cxl_bi_decoder_enabled(cxled_to_port(cxled))) {
> +			dev_err(&cxlr->dev,
> +				"%s:%s BI disabled by reset during commit\n",
> +				dev_name(&cxlmd->dev),
> +				dev_name(&cxled->cxld.dev));
> +			rc =3D -ENXIO;
> +			i++; /* this target committed, so undo it too */
> +			goto err;
> +		}

[Severity: Medium]
When a reset clears CXL_BI_DECODER_CTRL_BI_ENABLE in hardware without
.reset_done (cxl_bi_reset_detected()) having updated cxlmd->cxlds->bi (for
example, during a concurrent reset before .reset_done runs, a secondary bus
reset that does not invoke .reset_done, or on a Type-2 device driver that
does not call cxl_bi_reset_detected()), doesn't this leave cxlmd->cxlds->bi
stale and transiently commit decoders before rolling them back?

First, in the pre-commit loop at the top of cxl_region_decode_commit(), only
the software flag !cxlmd->cxlds->bi is checked rather than
cxl_bi_decoder_enabled(cxled_to_port(cxled)). If hardware BI Enable was
already cleared while cxlmd->cxlds->bi is still true,
cxl_region_decode_commit() programs and commits the endpoint and switch HDM
decoders in hardware with CXL_HDM_DECODER0_CTRL_BI set before catching the
mismatch in the post-commit check and rolling back via
cxl_region_decode_reset().

Second, when the post-commit check detects
!cxl_bi_decoder_enabled(cxled_to_port(cxled)), it does not clear
cxlmd->cxlds->bi =3D false. If .reset_done never runs, cxlmd->cxlds->bi
remains true indefinitely: back_invalidate_show() in
drivers/cxl/core/port.c continues to report 1 while the decoder is attached,
cxl_region_check_coherency() continues to allow attaching the endpoint to
HDM-DB regions, subsequent commit_store() calls repeat the hardware commit
and rollback cycle, and cxl_bi_release() attempts to disable BI on teardown.

Should the pre-commit check also verify
cxl_bi_decoder_enabled(cxled_to_port(cxled)), and should cxlmd->cxlds->bi be
updated when hardware BI Enable is found cleared?

[1] https://lore.kernel.org/r/ar3TU4IM_TtcGgwl@aschofie-mobl2.lan

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793567979.gi=
t.dave@stgolabs.net?part=3D4
