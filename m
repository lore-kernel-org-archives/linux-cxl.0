Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66475390CAD
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976090; cv=none; b=WsLXjHJZzxB9ZpJhA1SvYzI5CeR6xOm6qc81In0IxiiaMcHQbhygm9IZvuPYu5NpqSy53Hdx5o3PnQ4o80IGBafxmbaAOIE6AYkl8wLHiJO+mMUOLsLInd50oOTckj9NZ3ynaIEmDbaT/rBkFiJA7jXyKXPlY5IAnStCvdLcUII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976090; c=relaxed/simple;
	bh=cNI5rzvW0O00yQKgQd5SLGUXnrNUEKZzsCidFrNT4VA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jqysoGCIClBPFDQaJxDZTROnBqM9tZRTB+6eShuXPoGAnowQjfY9EyNr8iYd4i0HD9jxHjrH06oM83FAAGof0yjW6HBBThTnwCpycCG315MiZqge+fNwDnuXu0r1EcgTDDWxaJXnCXkf1+ZlLMiszmfzwnlX5vEXUwP7q+Q4H5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wjz/GECv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wjz/GECv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE31E1F000FF;
	Wed,  9 Sep 2026 17:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788976088;
	bh=XWc8aX+xxb80swjReVjrENHvUIyaH8mAf8/WyBOmUug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wjz/GECvRSW7YEllsabriDFBLznVCPn7SGKcqvmRVg1tYgMj2uM/74msnbjDZ5+/s
	 iI8W+mn0Jev+KM1c+QVREQnYZbz0Mp24DQUOMrIuOVy4uUQ0+ZCxNYXRSFP6MDhrc1
	 f+eCHMuc96biaNdo3qIMsaGsAveJWgfFHs0a4pIP+URzBKSfXPT4XNuU7oHWOtDhBR
	 SV49rp8tbb4ihHALIf4ZWvWsJJEmTPnue+YJewa5WErg0rdVbhJTuUT5Ha/fKEcz8m
	 ddxR7Omtw/1UxIn1RJaZeMxoKLmUFVspwg+u3owgBhXkPmLBeNiLIbLGPLvOLDOvns
	 qIxbmoe9P9NzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/10] cxl: Add HDM-DB region creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Davidlohr Bueso" <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260909170302.1550680-5-dave@stgolabs.net>
References: <20260909170302.1550680-1-dave@stgolabs.net>
 <20260909170302.1550680-5-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 17:48:08 +0000
Message-Id: <20260909174808.BE31E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The device state flag `cxlds->bi` is read without proper synchroni=
zation, leading to a TOCTOU race with concurrent reset handlers.
--

commit 3909f8bd22c48d8144275584758e210ff08c9e51
Author: Davidlohr Bueso <dave@stgolabs.net>
cxl: Add HDM-DB region creation

This patch introduces region creation for HDM-DB, which inherits coherency
from the root decoder. It enforces topology checks by restricting windows
with BI to device-coherent memory and validates endpoints during attach
and commit phases.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -314,6 +314,20 @@ static int cxl_region_decode_commit(struct cxl_regio=
n *cxlr)
>  	struct cxl_region_params *p =3D &cxlr->params;
>  	int i, rc =3D 0;
> =20
> +	/* a reset since attach may have invalidated cxlds->bi */
> +	for (i =3D 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled =3D p->targets[i];
> +		struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
> +
> +		if (cxlr->type =3D=3D CXL_DECODER_DEVMEM &&
> +		    cxl_root_decoder_is_bi(cxlr->cxlrd) && !cxlmd->cxlds->bi) {

[Severity: High]
Is there a potential TOCTOU race here with concurrent reset handlers?

If a userspace-initiated PCI reset (e.g. pci_reset_function()) runs
concurrently with cxl_region_decode_commit(), the reset path can call
cxl_reset_done() -> cxl_bi_reset_detected(), setting cxlds->bi =3D false
without holding the cxl_rwsem.region lock.

If this reset happens exactly after this unprotected read of cxlds->bi, but
before the endpoint decoder is programmed, could the decoder be committed
with BI enabled via MMIO even though the device-wide BI capability is now
turned off?

Because the decoder was not yet committed when the reset occurred, it
appears cxl_endpoint_decoder_reset_detected() would evaluate to false. This
would bypass the kernel taint and critical warning, potentially leaving the
hardware in a silently mismatched state.

> +			dev_err(&cxlr->dev, "%s:%s BI not enabled on device\n",
> +				dev_name(&cxlmd->dev),
> +				dev_name(&cxled->cxld.dev));
> +			return -ENXIO;
> +		}
> +	}

[ ... ]

> @@ -2105,10 +2118,31 @@ static int cxl_region_attach(struct cxl_region *c=
xlr,
>  		return -ENXIO;
>  	}
> =20
> -	if (cxled->cxld.target_type !=3D cxlr->type) {
> -		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
> -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> -			cxled->cxld.target_type, cxlr->type);
> +	/*
> +	 * Verify the device and HDM are capable of the region's flavor before
> +	 * proceeding. The endpoint decoder's target_type is then inherited
> +	 * from cxlr->type later in cxl_rr_assign_decoder().
> +	 */
> +	if (cxlr->type =3D=3D CXL_DECODER_DEVMEM &&
> +	    cxl_root_decoder_is_bi(cxlrd) && !cxlds->bi) {

[Severity: High]
Does this read of cxlds->bi during region attach also need synchronization?

While a race in this earlier phase might be caught by the second check in
cxl_region_decode_commit(), both reads appear to happen without protecting
against concurrent modifications from PCIe resets.

> +		dev_err(&cxlr->dev, "%s:%s BI not enabled on device\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909170302.1550=
680-1-dave@stgolabs.net?part=3D4
