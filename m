Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113073C3456
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 03:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788492989; cv=none; b=jjtqnWDLxlKDugyRExqWrSJ2a4dtKHQ68pYoY266yPP751Roj4lsWXNDveOuN74VHQufD1XIHdvhZDKFN5XK3e6rbKDAudQu3V9rwLqeBVWd1/wL+Vs4N7kHBFS8BWlYyGU6vce8nZenm51FMfwhw8rwyqG5veMJZzcNsYoQXhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788492989; c=relaxed/simple;
	bh=konP/EqS3FZw4IaPY/OqKyzi3KGpk1zRO9/CBSpn+EI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cv9XCTEuciZ6bfdINCP39t/JApQVElej7VG9X9j/SdzSs74um0foPAl8pP3ss26NBM8eyBdgKgwv187O+f4OrmJkrXFtCcPDuRQ826uP4934QqKY25r5lIM2qLyBaUJNNj0ioWxAE2mTK9ZgJBfmvBU3Hol76kKadRvhdmru0IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5hvLA35; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5hvLA35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58651F00A3D;
	Fri,  4 Sep 2026 03:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788492985;
	bh=cajW7vNeclLEo2Hn+JoEuGR0l5tjqFJgWKuSpqjdYHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L5hvLA35ADl9812LFxsNTmGWSYH/AU9uJ9ZXYrhiV5xNHSIR8O0JvT6AwF9L6i+T0
	 +KpH+cWCV2RDIgJPTYoDrcn18jVq30bqV/gqXJ5QKFjc3Ye5ckpeLy/S3TtUsm9asl
	 colZu/Ij+K1tC97PECWoZ02cEM5BentXVh8Zu0WtZUParIoQrIOPbkhl6nt5By9aD5
	 +KI8et2th7CTlPaOWGr/2ufV/sALT+WE8kvbVez3Z3yPHyMyIQLYaDjkICnBwns7Sj
	 8yoemLYoDLVl+T+oMErtBV5WdCspTLvM7D3sRnfDDgKNQHYrke83kRzVTP/tcUq3FI
	 088tLQRhZu1bQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] cxl/region: Allow regions with an unencodable
 passthrough granularity
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <35566fc6397183a8be89055d1de9979eab9a24a5.1788487020.git.alison.schofield@intel.com>
References: <cover.1788487020.git.alison.schofield@intel.com>
 <35566fc6397183a8be89055d1de9979eab9a24a5.1788487020.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 03:36:24 +0000
Message-Id: <20260904033624.D58651F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] During region auto-discovery, the driver relaxes the interleave gr=
anularity validation for non-interleaving passthrough decoders, but fails t=
o update the decoder's software struct (`cxld->interleave_granularity`) wit=
h the computed logical value. As a result, descendant decoders inherit a st=
ale hardware don't-care value.
--

commit 581b6f11f4646ac877c9eaf9fb81a155a40889d5
Author: Alison Schofield <alison.schofield@intel.com>

cxl/region: Allow regions with an unencodable passthrough granularity

Region creation fails when the interleave granularity accumulated below the
root decoder exceeds 16K, the maximum encodable in the HDM Decoder Control
IG field, even when the decoder that computes it does not interleave.

This patch keeps the computed value for passthrough decoders so it can
seed descendant decoder setup.

Closes: https://lore.kernel.org/all/20260530002613.682E71F00893@smtp.kernel=
.org/

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 27e63e6dab7c8..89693f0181ddb 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

[ ... ]

> @@ -1550,20 +1562,12 @@ static int cxl_port_setup_targets(struct cxl_port=
 *port,
>  	 * Interleave granularity is a multiple of @parent_port granularity.
>  	 * Multiplier is the parent port interleave ways.
>  	 */
> -	rc =3D granularity_to_eig(parent_ig * parent_iw, &eig);
> -	if (rc) {
> +	ig =3D parent_ig * parent_iw;
> +	if (!granularity_is_valid(iw, ig)) {
>  		dev_dbg(&cxlr->dev,
>  			"%s: invalid granularity calculation (%d * %d)\n",
>  			dev_name(&parent_port->dev), parent_ig, parent_iw);
> -		return rc;
> -	}
> -
> -	rc =3D eig_to_granularity(eig, &ig);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			256 << eig);
> -		return rc;
> +		return -EINVAL;
>  	}
> =20
>  	if (iw > 8 || iw > cxlsd->nr_targets) {

[Severity: High]
During region auto-discovery, the driver relaxes the interleave granularity
validation for non-interleaving passthrough decoders. However, looking at t=
he
CXL_REGION_F_AUTO block immediately following this diff in
drivers/cxl/core/region.c:cxl_port_setup_targets():

	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
		if (cxld->interleave_ways !=3D iw ||
		    (iw > 1 && cxld->interleave_granularity !=3D ig) ||
		    !spa_maps_hpa(p, &cxld->hpa_range) ||
		    ((cxld->flags & CXL_DECODER_F_ENABLE) =3D=3D 0)) {
			dev_err(&cxlr->dev,

When iw =3D=3D 1, does this code fail to update cxld->interleave_granularity
with the computed logical ig?

If cxld->interleave_granularity is not updated, it seems descendant decoders
will inherit a stale hardware don't-care value instead of the true accumula=
ted
granularity. Could this cause the kernel to accept physically broken topolo=
gies
during auto-discovery, potentially leading to silent memory corruption or
Machine Check Exceptions (MCEs) when the region is accessed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788487020.gi=
t.alison.schofield@intel.com?part=3D1
