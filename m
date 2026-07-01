Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBBF3115A5
	for <linux-cxl@vger.kernel.org>; Wed,  1 Jul 2026 22:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782945087; cv=none; b=Qi1T+5WSxxKXWsJ98SkCQkTfIGeITW6u0TPHvYVCO9+SRXgOFVcKhSTDdU0MhKRrn2Pn98bum8NuGslz3nPQBloKd7kRSpEZNBZ3JOmuN5WMOJSejaIAsX6pMZdnCvEqVONYvLz680wN+ys0QRtsV9brQrFBwJqNlFKz3x/afAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782945087; c=relaxed/simple;
	bh=F4R/a8IJSHFiWa7ViWH0I9TblKVZmCLitnyn8IL96fk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PapsHtAHNr5LPuGnCUy/00Y1tYQ6LRR9N7MkjKjrOFO6tMQnAuUR2+HOOvlF4yX7lb9Pt9dcPHO/olWKBRyHQIcXAe9pU1Cx8TO3ofn1nUWhzeMPX7Hgn5nG8fC9qsPm8EQJWekiY/s1Rk7KysajD0A7hecm1nfhSyJU0EgUcKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BORuDMW5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BORuDMW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046131F000E9;
	Wed,  1 Jul 2026 22:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782945086;
	bh=Ut7XMVaSSYS1aFsGNh18udK02l1vfxCA8BTs8mw8DPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BORuDMW5x9xpcGll0TNo4PVUzLktvUGnhzfTp+o7n/mLx14TggvAbyi/lnKhk4FvQ
	 Z8K2nvzeBZ2NBlNoXDlIi+3pR+3vzrRGM5D/4dL9DaUZ6SHsugT1Iu9H5iZvZF1prc
	 LmoGg4yw2OIbHcCgZFL/4KgtkZABohEUFGHA6Sk63dqEqhqDu+Q2nNOBXNOnQNykOS
	 WYeApI07AmhVT+tKtpJ0eF0J4RzcsFBgm7w+Kg5K6QTcmDDR4Tsf2bx7/jNYzDcoMM
	 AWnJ+oI+eLSeVW2wG+n9Ux0l/nURf34FLSZUfn3k+52SZmGaMtOBxfolEzw3qFlrli
	 Gbs5AkkVZ9FbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mm/mm_init: handle alloc_percpu failure in
 free_area_init_core_hotplug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gregory Price" <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260701221613.2818148-1-gourry@gourry.net>
References: <20260701221613.2818148-1-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 22:31:25 +0000
Message-Id: <20260701223126.046131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing NULL check for alloc_percpu() in setup_zone_pageset() caus=
es a kernel panic if allocation fails.
--

commit a2befab1623f901bf46191ea77de8329bd1c4f4a
Author: Gregory Price <gourry@gourry.net>

mm/mm_init: handle alloc_percpu failure in free_area_init_core_hotplug

We miss a failed allocation check for pgdat->per_cpu_nodestats, which
results in a NULL deref when we offset into the per-cpu area. Propagate
-ENOMEM up the stack and leave per_cpu_nodestats pointing at boot_nodestats
so a later online can retry the allocation.

Link: https://sashiko.dev/#/patchset/20260627202243.758289-1-gourry%40gourr=
y.net

> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index cfd0b2722d836..07a8c74cf7ade 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1534,8 +1534,14 @@ void __ref free_area_init_core_hotplug(struct pgli=
st_data *pgdat)
> =20
>  	pgdat_init_internals(pgdat);
> =20
> -	if (pgdat->per_cpu_nodestats =3D=3D &boot_nodestats)
> -		pgdat->per_cpu_nodestats =3D alloc_percpu(struct per_cpu_nodestat);
> +	if (pgdat->per_cpu_nodestats =3D=3D &boot_nodestats) {
> +		struct per_cpu_nodestat __percpu *p;
> +
> +		p =3D alloc_percpu(struct per_cpu_nodestat);
> +		if (!p)
> +			return -ENOMEM;
> +		pgdat->per_cpu_nodestats =3D p;
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but while checking the
alloc_percpu() handling here, I noticed a similar missing NULL check in=20
setup_zone_pageset() over in mm/page_alloc.c:

mm/page_alloc.c:setup_zone_pageset() {
    ...
    if (sizeof(struct per_cpu_zonestat) > 0)
        zone->per_cpu_zonestats =3D alloc_percpu(struct per_cpu_zonestat);

    zone->per_cpu_pageset =3D alloc_percpu(struct per_cpu_pages);
    for_each_possible_cpu(cpu) {
        struct per_cpu_pages *pcp;
        struct per_cpu_zonestat *pzstats;

        pcp =3D per_cpu_ptr(zone->per_cpu_pageset, cpu);
        pzstats =3D per_cpu_ptr(zone->per_cpu_zonestats, cpu);
        per_cpu_pages_init(pcp, pzstats);
    }
    ...
}

If alloc_percpu() fails here due to memory pressure during runtime memory=20
hotplug, could the returned NULL pointers cause a kernel panic when=20
dereferenced by per_cpu_ptr() and per_cpu_pages_init()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701221613.2818=
148-1-gourry@gourry.net?part=3D1
