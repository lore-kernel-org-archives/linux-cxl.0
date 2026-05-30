Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7543189F43
	for <linux-cxl@vger.kernel.org>; Sat, 30 May 2026 00:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100774; cv=none; b=g7LSpa2nbz2r4jc7MEaNJfeK1ToALqzn5QJy9bICkS+Sjk6n/b3tq87Iub1m5KQ43RkeRjyoo9flE2E9qPLP9QlC7fVaLg3vuHfduHh1JBMEFPgHiXEu4etVveAY6h/xtSZHAMhN6wv6EfGj8cvel/g8QOxZ4hQtoXkDfvoca5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100774; c=relaxed/simple;
	bh=+0t9HqMJzfDsMfaM70oWNJ8tdApVlOCSWdh5b/zCg80=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lt1nLOjsV3vIN8JKWD8cMq84Y3O+IRdiSRO/hLrianVjO4iyyLSzRpbKHFbc1Mf/HEIZIZ2/ZAHVGU2KStJ+j8IxDNGF2kfzXnccwa3xlnyoaE+OCEnGwJ4dWbtNRlZL+thjd/xbc1LUWSJuSomrBEDzG5cT+TEmp1uN/VoDwlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJFGyIRb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJFGyIRb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682E71F00893;
	Sat, 30 May 2026 00:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780100773;
	bh=aO76dHXc9Yx7Zaco1FrVpRWXCcfWU1w0vUGKOvOpA4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GJFGyIRbsatZG6xiQlzM0fVE8a3/sXK6QqCZrzQ6ysJNa58af18MV5aOIBrMsZafm
	 G9jgRV4zMK62aDuCJCSj3YatvchlvxB/WFeKeOCaGLwhN5o6dg9vYLaqn7+KZ8uLuS
	 wefZDPRG+XpAoGACCssLSLPOCRZnZ3KUS2r24OaIaYJc2mrlj49K1hvfIcnb+webIB
	 7c7q0lfi5yBpZ6gxrj3oByxFmS82SGd9D+ynTYJ3njjTgm279ReEHUojRb+crk2yoO
	 TrP4gT4wQ2RkAqJ0mVvFp6UK1x6AFTrqW0risQvBpS4K7s0D8uVk9VOwpHQyVGHsaI
	 Ipj7QWsIlDNUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] cxl/region: Derive port granularity from selector
 bits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <4feca2a522e1e380495f22742551dec230ff0618.1780095671.git.alison.schofield@intel.com>
References: <4feca2a522e1e380495f22742551dec230ff0618.1780095671.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:26:13 +0000
Message-Id: <20260530002613.682E71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Passthrough decoders (`iw =3D=3D 1`) in deep topologies fail to co=
nfigure because calculated `ig` exceeds software limits, breaking valid con=
figurations.
--

commit 0b56c23b98964cba7ba9487773eeb9e989d957d3
Author: Alison Schofield <alison.schofield@intel.com>

cxl/region: Derive port granularity from selector bits

Selector-bit validation uses a single same-granularity formula for
user-created regions. This commit changes the layout rules to derive
the programmed port granularity from selector bits, which lets an
interleaving switch beneath a mixed-granularity root claim inner
selector bits instead of colliding.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 87fb1a9f2683f..9d310287d48dc 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1548,7 +1548,23 @@ static int cxl_port_setup_targets(struct cxl_port =
*port,
>  		goto add_target;
>  	}
> =20
> -	ig =3D p->interleave_granularity * parent_distance;
> +	/*
> +	 * Auto regions keep the firmware value, passthrough decoders consume
> +	 * no selector bits, interleaving decoders claim the lowest available
> +	 * selector bit.
> +	 */
> +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> +		ig =3D cxld->interleave_granularity;
> +	} else if (iw =3D=3D 1) {
> +		ig =3D p->interleave_granularity * parent_distance;

[Severity: High]
This is a pre-existing issue, but does this calculation break passthrough
decoders in deep topologies?

If we have a large root interleave width (e.g., an 8-way root),
parent_distance evaluates to 8. For a standard 4K base region granularity,
ig is calculated as 4096 * 8 =3D 32768.

Later in cxl_port_setup_targets(), we unconditionally call:

	rc =3D ways_to_eiw(iw, &eiw);
	if (!rc)
		rc =3D granularity_to_eig(ig, &eig);
	if (rc) {
		...
		return rc;
	}

And granularity_to_eig() explicitly checks for `granularity > SZ_16K`
returning -EINVAL. Since hardware ignores interleave granularity for
passthrough decoders (iw =3D=3D 1), this seems to artificially reject valid
hardware topologies by failing the configuration.

> +	} else if (selector) {
> +		ig =3D 1ULL << __ffs64(selector);
> +	} else {
> +		dev_dbg(&cxlr->dev,
> +			"%s:%s: no selector bits available for iw %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev), iw);
> +		return -ENXIO;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780095671.gi=
t.alison.schofield@intel.com?part=3D2
