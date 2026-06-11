Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB78627FB37
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781201015; cv=none; b=qhdmddgQnr9L7XdcELrQ5cHgK7qwUsynvkA8rE2zy8lZGORHPzN7ZHEAB1EcTbQOZQ+8E/p5h3/LQmGGDx3Wyx/xh7age0kX9CxFsS4YvCoeh75td8WVboCiaS48hl7dWXa5wcaCl1eX+uIIZtKKaqIFjspou2cGwU7Ag3kAGcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781201015; c=relaxed/simple;
	bh=YSecTdWkg7u13iGTTdNtHVQokITc/ZntU9F1fTWf3To=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T/yUOxz88ZuPlS29zxNB6Tjga45kJ1pNCfFPzui2FVZbtv6RV58Ta5l5l5vAHlmnAeecmc/KXj3kmrEbcpc4fYX9c+kTJlI8CF2aBXcnyBIvkARdaaaJDkTp5pDSshGxO+A2n0gzvesmEhi4LioKrYuyrdiz/p3Kty/587st7M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V++hvYHo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V++hvYHo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC6B1F000E9;
	Thu, 11 Jun 2026 18:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781201014;
	bh=9OUTcU1WFDVttN6kFVYY9pNv2ZWhEywmCeSJPrBbj/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V++hvYHoLUnGo6vch27hNokeF98OzT7AuzXQ4WkIl+rdkvg6PZbC9PaYP2L1MeilN
	 zZWeUX4+XtwNo4ptYn0Ga7oqe1bJHYHzUPmVrqixylQCf04SJZ+OmxK+Uo5QQt0JjV
	 NFHgUUULGl4ITXSTEXF16snxO0wMYDDls+LVI9NsC/k6auuLkbSWKF+5DWi9nVSWqO
	 CgI8b8zZAKIRchHkRNrxUVZm2DoNWdjDDFA/puMHky/FqyofTMsZRP4OzNmLKdVm0F
	 WW1FFb1hNTI94VtNXOXLptSOyccMKaq8a46fhsf1w+6G0tHfdBk9Tl1koSN/FqFOGY
	 REl3pW1ZhVkWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] cxl/region: Validate mixed-granularity at sysfs
 and attach gates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <42da0b69d39207b712d7c27f1af6186febbeaa6f.1781199122.git.alison.schofield@intel.com>
References: <42da0b69d39207b712d7c27f1af6186febbeaa6f.1781199122.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:03:33 +0000
Message-Id: <20260611180334.7EC6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The function `check_interleave_cap()` ignores the return values of=
 `ways_to_eiw()` and `granularity_to_eig()`, leading to the use of uninitia=
lized stack variables (`eiw`, `eig`) in bitmask calculations.
--

commit 999caa321a85ce92543a94c3525b252f33aab308
Author: Alison Schofield <alison.schofield@intel.com>

cxl/region: Validate mixed-granularity at sysfs and attach gates

Replace the same-granularity sysfs check with is_ig_allowed() to permit val=
id
mixed-granularity regions. Call this helper at attach time to enforce the s=
ame
rules for auto regions, and add an explicit span equality check for
3-way-family roots.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 9fff538a9ce16..311b5052bbc8f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

[ ... ]

> @@ -2096,6 +2107,8 @@ static int cxl_region_attach(struct cxl_region *cxl=
r,
>  	struct cxl_dport *dport;
>  	int rc =3D -ENXIO;
>  	int stride;
> +	int root_ways =3D cxlrd->cxlsd.cxld.interleave_ways;
> +	int root_gran =3D cxlrd->cxlsd.cxld.interleave_granularity;
> =20
>  	rc =3D check_interleave_cap(&cxled->cxld, p->interleave_ways,
>  				  p->interleave_granularity);

[Severity: High]
This isn't a bug introduced by this patch, but check_interleave_cap() is
called here with potentially uninitialized (zero) values for interleave_ways
and interleave_granularity prior to state verification.

Inside check_interleave_cap() in drivers/cxl/core/region.c, ways_to_eiw() a=
nd
granularity_to_eig() are called but their return values are ignored:

	ways_to_eiw(iw, &eiw);
	if (eiw =3D=3D 0 || eiw =3D=3D 8)
		return 0;

	granularity_to_eig(ig, &eig);
	if (eiw > 8)
		high_pos =3D eiw + eig - 1;
	else
		high_pos =3D eiw + eig + 7;
	low_pos =3D eig + 8;
	interleave_mask =3D GENMASK(high_pos, low_pos);

If interleave_ways and interleave_granularity are 0, both ways_to_eiw() and
granularity_to_eig() return -EINVAL, leaving eiw and eig uninitialized.
Because eig is an uninitialized u16, low_pos can be as large as 65543.

Passing values greater than 64 to GENMASK() results in an out-of-bounds
bitwise shift.

On systems with CONFIG_UBSAN_TRAP enabled, could this lead to a kernel panic
if a privileged user misorders sysfs writes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781199122.gi=
t.alison.schofield@intel.com?part=3D4
