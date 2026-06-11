Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F171E3597B
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 00:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781138533; cv=none; b=FlCh/xFBM1tNFAdI0igT6gnCt1HdmHvb8P6dKxZJW75U0y9XyLUh+72517Rh2CEftp/9GLuvdIeakTgSCw4lEAoeoiiNAW6dS3ZNSJ0GV4KiC8HuKp2OXWbXPZloD3daMUVXeNNNOrtyi38qFzjTrKGlh3ggd3BjE7fFmYu0dp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781138533; c=relaxed/simple;
	bh=bbjpoSKDkghnmOTKL+X7JkSZF/IrpRK2i4/+VydYYKc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SiuNHkGRL5rqmbzATWBuzxpWBfCPvwTMVwvXmP6brHPDCxR4NgEwX/tnuazR5Y1tjvOnaQFWGcXaToCxiDJvwbPUZl8w43RrnZwddhKtZ1TgvS9CwwrNdgHSL/5m5nJRtCKCio02yY27J1xLghuAQoENu2Ar5zSgPVFMjIn6tBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMgbWnaN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMgbWnaN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A091F00893;
	Thu, 11 Jun 2026 00:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781138531;
	bh=vgnNUVfmWscYFTBPxEJBRAPPgeDHFP94lpVHYOxb14Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kMgbWnaNeRxTHOMykSJpOu535tXCENFUiSnVlvW866BGhxFY0WlNAzzha7vVN8XeW
	 5rqry7W2WOHC+eBR6V4y53DUSQfc5evMz3EnPlMkAbIMl2nVRP2DL+fntLWzyFWisg
	 SrA7B0pO2v/CB9YgZ4jtC8cBxAp6aUwMtfLMo5KcTQwRXBACHOW4CQnbJQ9j+PlCx+
	 AAEq11geIqKHZgsvmFk+QmPmjcm1gq4ceSgxNaocxz1CabbuB55JvEGyaicFxPWSSz
	 pZVN4sY/+jM61tx6h/dIAync4MDps1IYXFPQd5GervSS+JULLrKfx1LXOuxoZtTZDZ
	 kpmlOZwBVPPFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] cxl/region: Allow passthrough decoders with >16K
 granularity
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <e8cd395fc7cee8d126449db9d7fd8b37ddd43459.1781136281.git.alison.schofield@intel.com>
References: <e8cd395fc7cee8d126449db9d7fd8b37ddd43459.1781136281.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 00:42:10 +0000
Message-Id: <20260611004211.66A091F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Passthrough decoders in CXL_REGION_F_AUTO mode do not update their=
 `interleave_granularity` to the logically computed `ig`, breaking auto-dis=
covery for downstream interleaving decoders.
--

commit e8de72986281000607b505c71ee58ce7b4899cb6
Author: Alison Schofield <alison.schofield@intel.com>
Subject: cxl/region: Allow passthrough decoders with >16K granularity

This commit relaxes granularity validation for non-interleaving passthrough
decoders. It ensures the computed granularity is kept to seed descendant
decoder setups while programming a don't-care encoding when committing
non-interleaving decoders.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

[ ... ]

> @@ -1538,20 +1546,21 @@ static int cxl_port_setup_targets(struct cxl_port=
 *port,
>  	 * Interleave granularity is a multiple of @parent_port granularity.
>  	 * Multiplier is the parent port interleave ways.
>  	 */
> -	rc =3D granularity_to_eig(parent_ig * parent_iw, &eig);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev,
> -			"%s: invalid granularity calculation (%d * %d)\n",
> -			dev_name(&parent_port->dev), parent_ig, parent_iw);
> -		return rc;
> -	}
> +	ig =3D parent_ig * parent_iw;
> =20
> -	rc =3D eig_to_granularity(eig, &ig);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			256 << eig);
> -		return rc;
> +	/*
> +	 * Keep the computed granularity for descendant setup. Only
> +	 * interleaving decoders require an encodable granularity.
> +	 */
> +	if (iw > 1) {
> +		rc =3D granularity_to_eig(ig, &eig);
> +		if (rc) {
> +			dev_dbg(&cxlr->dev,
> +				"%s: invalid granularity calculation (%d * %d)\n",
> +				dev_name(&parent_port->dev), parent_ig,
> +				parent_iw);
> +			return rc;
> +		}
>  	}
> =20
>  	if (iw > 8 || iw > cxlsd->nr_targets) {

[Severity: High]
This is a pre-existing issue, but since the commit message mentions keeping
the computed value for passthrough decoders to seed descendant setup, does
the auto-discovery path also need to be updated to ensure this?

During region auto-discovery (CXL_REGION_F_AUTO), cxl_port_setup_targets()
checks the configuration but does not appear to update the decoder's
interleave_granularity for passthrough decoders:

	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
		if (cxld->interleave_ways !=3D iw ||
		    (iw > 1 && cxld->interleave_granularity !=3D ig) ||
		    !spa_maps_hpa(p, &cxld->hpa_range) ||
		    ((cxld->flags & CXL_DECODER_F_ENABLE) =3D=3D 0)) {
			// ... validation fails ...
			return -ENXIO;
		}
		// cxld->interleave_granularity is not updated to ig here
	} else {
		// ... manual config path updates it:
		cxld->interleave_granularity =3D ig;
	}

Since cxld->interleave_granularity is never updated to the computed ig in
the auto-discovery block, it retains the hardware don't-care value (such as
256 bytes or 0) read from the register.

When a downstream switch decoder is subsequently evaluated, it loads this
unencodable hardware value as parent_ig. If the downstream decoder is
interleaving (iw > 1), it will calculate a logically incorrect ig from the
garbage parent_ig. This would cause it to fail its own validation and abort
region assembly with -ENXIO.

Should cxld->interleave_granularity be explicitly updated to ig in the
CXL_REGION_F_AUTO path to prevent downstream decoders from inheriting
unencodable don't-care values?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781136281.gi=
t.alison.schofield@intel.com?part=3D1
