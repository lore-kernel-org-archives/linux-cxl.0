Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFF5768EA
	for <linux-cxl@vger.kernel.org>; Sat, 30 May 2026 00:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100357; cv=none; b=Ybekz4qau+qiseuJJqJXJfGNlkoDT1tdrpB5f6Xo/4POEXq3Bj1FXLjGmlzCQMt+evL8qBHlDet9JJAfF67V+3ScSPHd7FlWcb2p7vl3Go5rcim7G5KoWN512V82oAPgArRc/b4QqgYMGIglMwhaTy1rSSkCsCvuKwIwldJPJGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100357; c=relaxed/simple;
	bh=GMNTJQva76zlOzaWl0GHyiX/KYx13CZx6ChAAg/yN/M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eLkhABC5l3cZgHIc2YMVBiyQ0J3Ap3lPMaPFJlVH7ffvWrZY77EjDYPnPKB/fgX4q2fsDNdyebAzcLaVwjDkyqxx+YwvXsrf0qxZJ80+sa3vGpJ3OmUjdRvH9lIdIz8q4aAEae4Wjd4lnI/6bdPI3Kbu5vzYBSFdi7/fzx472b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZPf7KJU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZPf7KJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7B21F00893;
	Sat, 30 May 2026 00:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780100355;
	bh=JOLQDEH4aoDuBHa79Y8+4Z+4GxjPLkEjQcWMPSP3vog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mZPf7KJUZsTSVEJzbpExXpCroXjztlgBJStCEmzfyzCbqCU08WRyjyMc1ONDoNbm/
	 1L5AhlR3n5uiY6XWl1xXRl3gWkVs3lAl7AMkaxWUANcd5JRQtd/DVXiU4zHzVIGdW5
	 gGDgpv5Yvd+FDTH104CXWiyBtF4uxCJUy46ArinNPwDM8Fa1/fvPC3OjqfQLwRkDD4
	 KyjM1UMvRqLMBSKbWWv6HfQffKohycnJiIqKxhVC8ll2RGtPGdYmhOSMP6OaXz7IIF
	 N3wE5RnDAkD5HkWFwKgN2H/yCjnXMaP46/Xq3ReNVkfwdkiF953WmxQV3XtRIXlcN5
	 y24znkNVHQlBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] cxl/region: Validate interleave selector bits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <1a8a115cee9eddf5511e4a75f6dcb86783f0fa1e.1780095671.git.alison.schofield@intel.com>
References: <1a8a115cee9eddf5511e4a75f6dcb86783f0fa1e.1780095671.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:19:14 +0000
Message-Id: <20260530001915.7A7B21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch removes interleave granularity validation for auto-disco=
vered regions, leaving the current port's granularity completely unvalidate=
d.
--

commit a2adec3549842d4a09c81232586828cb3b57099d
Author: Alison Schofield <alison.schofield@intel.com>

cxl/region: Validate interleave selector bits

This commit updates multi-level interleave validation to account for
selector bits from the root toward the current port. It accumulates
selector bits, rejects overlaps, and removes the auto-region granularity
equality check, relying on the new selector walk instead.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e82..87fb1a9f2683f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

[ ... ]

> @@ -1452,28 +1475,69 @@ static int cxl_port_setup_targets(struct cxl_port=
 *port,
>  	}
> =20
>  	cxlsd =3D to_cxl_switch_decoder(&cxld->dev);
> -	if (cxl_rr->nr_targets_set) {
> -		int i, distance =3D 1;
> -		struct cxl_region_ref *cxl_rr_iter;
> +	iw =3D cxl_rr->nr_targets;

[ ... ]

> +	/* Accumulated bits must fit within the region selector */
> +	cxlr_sel =3D get_selector(p->interleave_ways, p->interleave_granularity=
);
> +	if ((cxlr_sel & selector) !=3D selector) {
> +		dev_dbg(&cxlr->dev,
> +			"%s:%s: invalid selectors: cxlr %#llx accum %#llx\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			cxlr_sel, selector);
> +		return -ENXIO;
> +	}
> =20
> -		for (i =3D 0; i < cxl_rr->nr_targets_set; i++)
> +	/* Selector bits still available to this port. */
> +	selector =3D cxlr_sel & ~selector;

[Severity: High]
Does this code leave the current port's granularity unvalidated?

The available selector bits are calculated here, but the selector variable
appears to act as a dead store and is never used to validate the current
port's granularity.

I understand this is fixed in a later patch in the series (commit
0b56c23b98964cba7ba9487773eeb9e989d957d3 cxl/region: Derive port
granularity from selector bits). However, shouldn't each patch in the
series be self-contained to avoid introducing temporary regressions
during bisection?

> +
> +	if (cxl_rr->nr_targets_set) {
> +		for (int i =3D 0; i < cxl_rr->nr_targets_set; i++)

[ ... ]

> @@ -1484,87 +1548,20 @@ static int cxl_port_setup_targets(struct cxl_port=
 *port,
>  		goto add_target;
>  	}

[ ... ]

> -	if (iw > 8 || iw > cxlsd->nr_targets) {
> -		dev_dbg(&cxlr->dev,
> -			"%s:%s:%s: ways: %d overflows targets: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
> -		return -ENXIO;
> -	}
> -
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		if (cxld->interleave_ways !=3D iw ||
> -		    (iw > 1 && cxld->interleave_granularity !=3D ig) ||
>  		    !spa_maps_hpa(p, &cxld->hpa_range) ||
>  		    ((cxld->flags & CXL_DECODER_F_ENABLE) =3D=3D 0)) {
>  			dev_err(&cxlr->dev,

[Severity: High]
Is the removal of this explicit granularity check intentional before the
functional replacement using the selector mask is fully implemented?

By removing this check and not using the calculated selector mask
for the current port in cxl_port_setup_targets(), the lowest switch port's
firmware-programmed granularity goes completely unvalidated.

Could this silently accept overlapping or mismatched interleave
granularities, potentially causing incorrect CXL memory region routing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780095671.gi=
t.alison.schofield@intel.com?part=3D1
