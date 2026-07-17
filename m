Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580FC3B3BEC
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 07:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271828; cv=none; b=h548iVOdZ1faoCtHJt/6qQIFw8EFIU31Tsd6lIOsWfEkax+ZHaN325p7ffbX9nbNKejwQ+5VCawdc0QHAAm71fxc56408Cx1kH5cSPAOwZheo94kx4J193HiDhNdhFCi5penMWHMb7W6QBMp0ZojiFmS14giGhz8NJTtNNeHvJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271828; c=relaxed/simple;
	bh=h3M4mbi8u6K5T7Aq7sbaiIOXruEgqh1QaodKlfujWM0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GhLDjK5sfBe/0/c3GuqO3V8AHhW8HogTDqwQZXcMjchH14WoeAvGwVjUGwzOsZZFWNastMUdAW9okXAzqdAR1T5ziQKEoQtpxNbVoh+iP8tmCA6FMbDhi2sWNjM6jqLJWG5hyzoa6tHrN285tN0rxny3kdoNPYMEPTdTTTlObDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKHEeXWj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKHEeXWj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23BB1F000E9;
	Fri, 17 Jul 2026 07:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784271826;
	bh=bUyV2ENkly2zzFFQ/4S1yivNMkxzOruc+M2A01RLLqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bKHEeXWjX7byt1afc0P3CeLomv1MmrdS+vwDpYOrQQ4iXviPCs0jL+8v1DoqCQU/4
	 Yl7VIBnZb479Yvb0OMjhkarNl0F4jI8mQ/G6yVHlICxjQHnyagg8wUfIbJr2fwQf2Q
	 d/uM2XeJsCvYAvZLk1R//2eGn5+tD70ZVtA1dDSD56p6Yta1zLkVdgFxeDK56zmI7k
	 epMpemzGZkNZmOXguo7wS3GADArDO/cpUdOUgG9BmY26RKUivtxszUKjHYAIbKNUR4
	 OzoJQp0M6MmqrOdwJhwSliD9zE8g7BrTE9A0g1BvSOJRYMS7kzPJRNE88ql10HA91G
	 m3ts6SFNfehJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] mm: decrement MTHP_STAT_NR_ANON in
 free_zone_device_folio()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nico Pache" <npache@redhat.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260717064502.1980173-2-npache@redhat.com>
References: <20260717064502.1980173-1-npache@redhat.com>
 <20260717064502.1980173-2-npache@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 07:03:46 +0000
Message-Id: <20260717070346.B23BB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Large anonymous ZONE_DEVICE folios are leaked on the deferred =
split list when freed, causing list corruption, Use-After-Free, and permane=
ntly elevated MTHP partially-mapped stats.
--

--- Patch [1]: [PATCH v2 1/2] mm: decrement MTHP_STAT_NR_ANON in free_zone_=
device_folio() ---
commit cd3d1728ead3da706aada7ea30df9436a9ec5060
Author: Nico Pache <npache@redhat.com>

mm: decrement MTHP_STAT_NR_ANON in free_zone_device_folio()

When a zone device folio is mapped as anonymous, folio_add_new_anon_rmap()
increments MTHP_STAT_NR_ANON. The corresponding decrement lives in
__free_pages_prepare() in page_alloc.c, but zone device folios are freed
via free_zone_device_folio() which never calls __free_pages_prepare().
This causes nr_anon to remain permanently elevated after zone device
folios are freed.

Fixes: 5d65c8d758f2 ("mm: count the number of anonymous THPs per size")

> diff --git a/mm/memremap.c b/mm/memremap.c
> index 81766d8224009..accba23aef28c 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -425,6 +425,7 @@ void free_zone_device_folio(struct folio *folio)
>  	mem_cgroup_uncharge(folio);
> =20
>  	if (folio_test_anon(folio)) {
> +		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, -1);

[Severity: Critical]
This isn't a bug introduced by this patch, but since we are handling large
anonymous zone device folios here, is there a missing cleanup for the
deferred split list?

When a large device coherent folio is partially unmapped,
__folio_remove_rmap() can place it on the deferred split list because it is
not device private:

__folio_remove_rmap() {
    ...
    if (partially_mapped && folio_test_anon(folio) &&
        !folio_test_partially_mapped(folio) &&
        !folio_is_device_private(folio))
        deferred_split_folio(folio, true);
    ...
}

Later, when the folio's refcount drops to zero, __folio_put() short-circuits
directly to free_zone_device_folio() and returns, bypassing the call to
folio_unqueue_deferred_split() entirely:

__folio_put() {
    ...
    if (unlikely(folio_is_zone_device(folio))) {
        free_zone_device_folio(folio);
        return;
    }
    ...
    folio_unqueue_deferred_split(folio);
    ...
}

Does free_zone_device_folio() need to call folio_unqueue_deferred_split()
before freeing the folio back to the device allocator?

If the freed folio remains on the deferred split list, could the deferred
split shrinker iterate over a freed or reused list node? It seems this might
cause list corruption or a use-after-free panic, and leave
MTHP_STAT_NR_ANON_PARTIALLY_MAPPED permanently elevated.

>  		for (i =3D 0; i < nr; i++)
>  			__ClearPageAnonExclusive(folio_page(folio, i));
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717064502.1980=
173-1-npache@redhat.com?part=3D1
