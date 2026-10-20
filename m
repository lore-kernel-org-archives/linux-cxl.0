Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485393;
	b=OyBZFTuahsHvXQ5/NYBNZGJ3wWNkySc9HljsIOOtrC68RdQV/DOv7g5QOElATB4gGq2A
	 Lw+Um9JZYryQtlQDrtM+S8Jv84jDRf9zfj9mWIgpT7aMRysHvSjRon+vI+UA59WbQ/u3t
	 L2heIJoEcD6QDk4Mb+yUGFhzlq3WDVA0BlGlROwMXY2akCMlGLOWZUnVsCk6XvkT7n1Rz
	 JQM6QfV9JOvMMYunQDfzvbRTtsBdCgXNQLmWOQG4n4g1hBrhCyYvSh+UByBjmHwN+uLZ3
	 /36ev/Vr5EN+ZqWR0jFyYvfKWjigZiPGdfnBGiuTYDIiJSBVSGF9yIFZbcdULxTwNqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485393;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=01Y+JuD9p603xV9u7S0W1q+kOQsIKRBp8HZobSp84+k=;
	b=onU/K0V08qLfSRJKcG1dw74SGGGLka9Uhb/X1VVeHPLdJgJBQ9ZaH7e+KTp8vi8xRC8g
	 DfqbmOcd7mj+MNlZURzEQyr4qjA5QMYSy3eWhRi1e+Erql3v78PeB2pZAaBLov2W28Rc0
	 y0UXQTyWyKL45gI8uuizFSCVjBf5e/j78PO0XNscYnASQccvtviD/E6F8K6nQoVSNGU4L
	 H8WaCGYkmx4L2u8iW/3hesfXOCgSnKHC8cEZLLOWA2JSrsVgO18GTHdYJXWSCy9UCrtq5
	 FrAF3Gw+HD13O0BLEsJR+JeC3SJPA8WHSXZMvrxI+kdyMchYQYtLqmY8Unh/fjA2AgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJmemMEM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B04606A31C
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJmemMEM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F17C1F000C5;
	Tue, 20 Oct 2026 08:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792485392;
	bh=01Y+JuD9p603xV9u7S0W1q+kOQsIKRBp8HZobSp84+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oJmemMEMVSyQkEs/VDwM9qD4glhVLGUYLgn2GPe83buY0TWB4X0tL//fi0gOqfGxC
	 rww4M34v+2qet2YDH0t1EyHXhJI3kSG9CO89j31lf5XPo6gBA1YLlfraQcHzZxxIOI
	 xNSaVbvaBLkjDa5fybhnFGSxxwisE4TM7ViW8XVLO+xwI9vdsKZNhP38ewcLdZn0O9
	 bR8DQ+KJebLWh3PbFvfWAtRKtwFJyfO3kfcFCRgeC+38uNvlvI81S6HC3LG1kcQ7vT
	 SzMvGY5005c+aMA+VY2hfscKswJkmWHLMT+gL5gY3V7ZqhXK/NUWS5FTuuXyczXR5w
	 XPBMZB/HrzRzg==
Message-ID: <sashiko-outbox-178578@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/4] cxl/region: Start unmapped poison scan at the
 committed decoder boundary
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20261020051403.14186-4-icheng@nvidia.com>
References: <20261020051403.14186-1-icheng@nvidia.com>
 <20261020051403.14186-4-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:36:32 +0000
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] cxl/region: broken ctx.part < 0 fallback in cxl_get_poison_by_en=
dpoint()
--

commit 93c022ba94d2f493a95ecc17f926c1ee71ac336f
Author: Richard Cheng <icheng@nvidia.com>

cxl/region: Start unmapped poison scan at the committed decoder boundary

This commit updates cxl_get_poison_unmapped() to resume scanning from
ctx->offset on the starting partition and adds a fallback in
cxl_get_poison_by_endpoint() to reset ctx.part and ctx.offset to 0 when
ctx.part is negative.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ddf12075b95c0..18114d25662b3 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2907,7 +2907,6 @@ static int cxl_get_poison_unmapped(struct cxl_memde=
v *cxlmd,
>  {
>  	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
>  	const struct resource *res;
> -	struct resource *p, *last;
>  	u64 offset, length;
>  	int rc =3D 0;
> =20
> @@ -2920,10 +2919,8 @@ static int cxl_get_poison_unmapped(struct cxl_memd=
ev *cxlmd,
>  	 */
>  	for (int i =3D ctx->part; i < cxlds->nr_partitions; i++) {
>  		res =3D &cxlds->part[i].res;
> -		for (p =3D res->child, last =3D NULL; p; p =3D p->sibling)
> -			last =3D p;
> -		if (last)
> -			offset =3D last->end + 1;
> +		if (i =3D=3D ctx->part)
> +			offset =3D ctx->offset;
>  		else
>  			offset =3D res->start;
>  		length =3D res->end - offset + 1;
> @@ -3001,9 +2998,14 @@ int cxl_get_poison_by_endpoint(struct cxl_port *po=
rt)
>  	};
> =20
>  	rc =3D device_for_each_child(&port->dev, &ctx, poison_by_decoder);
> -	if (rc =3D=3D 1)
> +	if (rc =3D=3D 1) {
> +		if (ctx.part < 0) {
> +			ctx.part =3D 0;
> +			ctx.offset =3D 0;
> +		}
>  		rc =3D cxl_get_poison_unmapped(to_cxl_memdev(port->uport_dev),
>  					     &ctx);
> +	}
> =20
>  	return rc;
>  }

[Severity: Medium]
Can this ctx.part < 0 fallback in cxl_get_poison_by_endpoint() work as
intended when gated inside the rc =3D=3D 1 branch?

Looking at poison_by_decoder() in drivers/cxl/core/region.c, it only
returns 1 when reaching port->commit_end on a decoder that has
cxled->dpa_res allocated:

drivers/cxl/core/region.c:poison_by_decoder() {
	...
	cxled =3D to_cxl_endpoint_decoder(dev);
	if (!cxled->dpa_res)
		return rc;

	cxlmd =3D cxled_to_memdev(cxled);
	cxlds =3D cxlmd->cxlds;
	mode =3D cxlds->part[cxled->part].mode;
	...
	offset =3D cxled->dpa_res->start;
	length =3D cxled->dpa_res->end - offset + 1;
	rc =3D cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
	...
	/* Iterate until commit_end is reached */
	if (cxled->cxld.id =3D=3D ctx->port->commit_end) {
		ctx->offset =3D cxled->dpa_res->end + 1;
		ctx->part =3D cxled->part;
		return 1;
	}
}

If the decoder at commit_end has !cxled->dpa_res, poison_by_decoder()
returns 0 before checking commit_end, so device_for_each_child() returns 0
and the rc =3D=3D 1 block is never entered.

Conversely, if rc =3D=3D 1 is reached with ctx.part < 0, then the decoder at
commit_end had a valid cxled->dpa_res with cxled->part < 0. By that point,
poison_by_decoder() has already indexed cxlds->part[cxled->part].mode out
of bounds with a negative index, queried poison for the committed
decoders' DPA ranges via cxl_mem_get_poison(), and recorded the handoff
boundary in ctx->offset =3D cxled->dpa_res->end + 1.

Resetting ctx.part =3D 0 and ctx.offset =3D 0 here discards that handoff
offset and causes cxl_get_poison_unmapped() to re-scan from DPA 0, issuing
duplicate cxl_mem_get_poison() calls over the already-scanned committed
decoder DPA ranges with region set to NULL.

In addition, because cxl_get_poison_by_endpoint() is the only caller of
cxl_get_poison_unmapped(), overwriting ctx.part < 0 before the call makes
the existing check at the start of cxl_get_poison_unmapped() unreachable:

drivers/cxl/core/region.c:cxl_get_poison_unmapped() {
	...
	if (ctx->part < 0)
		return 0;
}

Should poison_by_decoder() guard against cxled->part < 0 before indexing
cxlds->part[], and is the ctx.part < 0 fallback in
cxl_get_poison_by_endpoint() meant to handle a case where
device_for_each_child() returns 0 rather than 1?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020051403.1418=
6-1-icheng@nvidia.com?part=3D3
