Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FA3349CD2
	for <linux-cxl@vger.kernel.org>; Thu,  2 Jul 2026 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783014072; cv=none; b=GEb2DQoKIaQ+jucYfOJMMZwvh48nxtv2mZHWqd0aTcl1byTREa/Pkf0v38EMKHHQ9fnQ9+SI4DfkgvTXdisEDIaxT1NBGWIXxAXCpd9UYZ0dWKiE0rt2hckkrtFLu1vm6R/8+m57Tz/G4FiDrs1K/Y428Xkktk2yPPNcE1XEDPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783014072; c=relaxed/simple;
	bh=9Jo6CZxgqxSeKSKeIjR/62jsDuzTeEwjOWvFhzyGmno=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PGDr7MAJQZ4Qje1wRzdI40RMdkOkY5YJq/xm3/qyhjZkVOxvTq97sqf8v9xuKkhJCA2G93IiWW8yA5tGeSWunJ0gnRcZYcrlulBMORIb+VRw0ehVi9pJ8cbMMFk95fUWxSFqWtmNmOr9Ep56VYiVVAqWogG+aMDoKlAOjRsRj1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GltCNoOh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GltCNoOh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AB11F000E9;
	Thu,  2 Jul 2026 17:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783014071;
	bh=w+cnEsYCnV8UR0IFgV2L8+7vC0w1E5rPa4hhz5oWUrQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GltCNoOhoWvP2C793CJ+WWgOIn0IusE9zilk9RZOoUx5FoM6GZjdhmITLfwBowp3g
	 RQh/I3X63V8xhjOHTOVpf0mb6pDQNe/Gj7Mz2PlxhdEWu5RRN+qmGguxfSLFgD1W9C
	 eOyA5Vu8sevaDY2jlW8Y9yeNXzp63aS47kl2B+N9DW78P8gBvgUdbzNPDup3DQqU/I
	 KG6S9bnxH/qiZmDAybfFoZ1d0QDSvLgjfxGJVL4jGrBg/W3M5kF1zr5kOUEwNqaXiY
	 5elv7oC5wMJDmT14ARuavGqagdBaWY2fIDeoWRmPj/7KQwhLkR/SYvw6HsJ4JmAss5
	 VPKnO+lMyqUtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mm: decrement MTHP_STAT_NR_ANON in
 free_zone_device_folio()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nico Pache" <npache@redhat.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260702172548.37075-2-npache@redhat.com>
References: <20260702172548.37075-1-npache@redhat.com>
 <20260702172548.37075-2-npache@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 17:41:10 +0000
Message-Id: <20260702174111.46AB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `free_zone_device_folio()` bypasses `folio_unqueue_deferred_split(=
)`, causing list corruption on the deferred split LRU, leaking `MTHP_STAT_N=
R_ANON_PARTIALLY_MAPPED`, and triggering a `WARN_ON_ONCE`.
--

commit e9684c49325471cce57373674f8d1d1d76f029b6
Author: Nico Pache <npache@redhat.com>

mm: decrement MTHP_STAT_NR_ANON in free_zone_device_folio()

When a zone device folio is mapped as anonymous, folio_add_new_anon_rmap()
increments MTHP_STAT_NR_ANON. The corresponding decrement lives in
__free_pages_prepare() in page_alloc.c, but zone device folios are freed
via free_zone_device_folio() which never calls __free_pages_prepare().

> diff --git a/mm/memremap.c b/mm/memremap.c
> index 81766d8224009..accba23aef28c 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -425,6 +425,7 @@ void free_zone_device_folio(struct folio *folio)
>  	if (WARN_ON_ONCE(!pgmap))
>  		return;
> =20
>  	mem_cgroup_uncharge(folio);

[Severity: High]
This is a pre-existing issue, but can bypassing
folio_unqueue_deferred_split() here lead to list corruption on the deferred
split LRU or leak MTHP_STAT_NR_ANON_PARTIALLY_MAPPED?

ZONE_DEVICE folios bypass the normal cleanup path in __folio_put():

mm/swap.c:__folio_put() {
	if (unlikely(folio_is_zone_device(folio))) {
		free_zone_device_folio(folio);
		return;
	}
	...
}

If a ZONE_DEVICE folio (such as MEMORY_DEVICE_COHERENT) mapped as a large
anonymous folio is partially unmapped, folio_remove_rmap_pte() will queue
it on the deferred split list. When its refcount hits 0, it calls
free_zone_device_folio() directly.

When mem_cgroup_uncharge(folio) is called, if memcg is disabled or uncharge=
d,
it returns early, leaving the freed folio linked in the deferred_split_lru.
When the deferred split shrinker runs under memory pressure, could this
iteration over freed memory cause a use-after-free crash? (If memcg is
enabled, the uncharge path forcefully unqueues it but emits a WARN_ON_ONCE).

Would explicitly calling folio_unqueue_deferred_split(folio) before
mem_cgroup_uncharge(folio) prevent this issue?

> =20
>  	if (folio_test_anon(folio)) {
> +		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, -1);
>  		for (i =3D 0; i < nr; i++)
>  			__ClearPageAnonExclusive(folio_page(folio, i));
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702172548.3707=
5-1-npache@redhat.com?part=3D1
