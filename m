Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DBC30E0EC
	for <linux-cxl@vger.kernel.org>; Sat,  6 Jun 2026 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780733510; cv=none; b=TwtbInTArM2u8Nx3SX10i+ixnADg6FEXKlP5PI2H6f8b+Fi5krTV5ofrV049DbuMRkNH9f6mbXxPSjY5E+AMgx5g/mq/AhxotEGWPvADuijsAf55BunK0bw9Rlxkfa8Mj8MTdzGkzr+sjgkJ5TvGOgn7LdtGD4dE0DlEaOD3Xfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780733510; c=relaxed/simple;
	bh=jG641CZFro19rTlXChEw6/BDwqZW1H+/Fylu5LHr/gs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tGEfI6EygzgHJXs671Go0fNsiHslD1ynqECtkbbUBVfeGa62ZXqPAdTUd9fWBVzWntmA65vP2zH3DLil1mwkrsoU//4Nab/Ds4hiYDPB6sxW3Qw7ex9W5KAeUSPlf2egdLcuz6h5F8NKMcAbh77O2KGIUrLi41M3ZVC1dKWVEYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uw/SRmX8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uw/SRmX8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0F11F00893;
	Sat,  6 Jun 2026 08:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780733509;
	bh=Z3xoU09nf2wys86COvUvcBFmDphTFS4wGzcVkn0PoUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uw/SRmX86NHB5QfxlrEthcIWm9s1lITHZwzJEXNUPJBjrbmDX+MdP2U9rDezoRDbD
	 eVR5P4xdRz+Q9kskZCKyNE1q0CXQJWnElbRDZv6gOMerc9oKcxMq6biZg/G4nxFvQY
	 Jd61DFkAOWWNNu0Cvz62Tq/pxUm7hFB5Zh5qfEQNRRX87fbGMUeVCJGnOMMkUNHtjn
	 uA3woV2Wg+8aRoGPacQA6awAgqLKM1eaFXD1ReC9+38W/hIQIpFE1EfNa4UPWDFzug
	 INozGn0mG9xVamDtanwO4WqAaPM5Ev4dPqndIAlJJYBDmwCVRktohqL3t54fmv7zp2
	 X5aqaLD/Xg96A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] cxl/region: Fill first free targets[] slot during
 auto-discovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Ming" <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260606-fix_two_issues_introduced_by_cxl_cancel_auto_attach-v1-2-5d94ca06c4e4@zohomail.com>
References: <20260606-fix_two_issues_introduced_by_cxl_cancel_auto_attach-v1-2-5d94ca06c4e4@zohomail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 08:11:48 +0000
Message-Id: <20260606081149.1B0F11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Loops iterating over the `p->targets` array up to `p->nr_targets` =
unconditionally dereference elements, leading to NULL pointer dereferences =
because the array can be sparse.
--

commit bf78125f1b0b7a811b9b200d37ed57cc96619a00
Author: Li Ming <ming.li@zohomail.com>

cxl/region: Fill first free targets[] slot during auto-discovery

This commit adjusts the cxl_region_attach_auto logic to find the first free
target slot for endpoint decoder attachment, rather than appending to the t=
ail.
This ensures NULL holes in the target array are filled to avoid accessing an
endpoint decoder via a NULL pointer and miscounting valid endpoint decoders.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c4335ebf19f7f..532dac77bd003 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1848,8 +1848,21 @@ static int cxl_region_attach_auto(struct cxl_regio=
n *cxlr,
>  	 * this means that userspace can view devices in the wrong position
>  	 * before the region activates, and must be careful to understand when
>  	 * it might be racing region autodiscovery.
> +	 *
> +	 * The endpoint decoder will be recorded into the first free slot of
> +	 * the target array.
>  	 */
> -	pos =3D p->nr_targets;
> +	for (pos =3D 0; pos < p->interleave_ways; pos++) {
> +		if (!p->targets[pos])
> +			break;
> +	}
> +
> +	if (pos =3D=3D p->interleave_ways) {
> +		dev_err(&cxlr->dev, "%s: unable to find a free target slot\n",
> +			dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}
> +
>  	p->targets[pos] =3D cxled;

[Severity: High]
This is a pre-existing issue, but since __cxl_decoder_detach() can leave
sparse holes in p->targets without compacting the array, are the loops
that iterate up to p->nr_targets still susceptible to NULL pointer
dereferences?

For instance, in drivers/cxl/core/region.c:cxl_dpa_to_hpa():

    for (int i =3D 0; i < p->nr_targets; i++) {
        if (cxlmd =3D=3D cxled_to_memdev(p->targets[i])) {

If there is a hole at an index less than p->nr_targets, wouldn't
cxled_to_memdev() dereference a NULL pointer?

Similar unprotected iterations seem to exist in
cxl_scrub_get_attrbs_region(), unaligned_region_offset_to_dpa_result(),
and region_offset_to_dpa_result().

Does the array need to be compacted upon detach, or should these loops be
updated to check for NULL pointers before dereferencing p->targets[i]?

>  	cxled->pos =3D pos;
>  	cxled->state =3D CXL_DECODER_STATE_AUTO_STAGED;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606-fix_two_is=
sues_introduced_by_cxl_cancel_auto_attach-v1-0-5d94ca06c4e4@zohomail.com?pa=
rt=3D2
