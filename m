Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B6A55C329
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962820; cv=none; b=KGgv/taVS1CscTZG7hFlnSuFM7SlOt7SPWDSxVUBoCrUHpZn0r2kFGRJ+G5pIO22+AujDATcb8fMuOOFBT8wnAL1Khj8L0dq9bGwLPhP2rHd6gNKDyWr87mtPEw+NAxuhElORxSIzct6nD+dl83N00bWIX+iOEbzQevzdWEjJSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962820; c=relaxed/simple;
	bh=kAIltJ0Zw0YO99uw4qCw4fkSIUYCRT9nUxErhrrhkkc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CNxi6nVj+R4VnMHKlAQaHPWqVSlxDO1YqJlPqwiN0j5W8PiX0ZQ6U8dKb6JbHwMEd6wGZQkBPIM5rVv83QSRDDquwhepIfublu0QJTtJ/jThAK2Uus4A2macXFOR69JX3PCuw5nu3bR38Yd1iIcNOFYYvcIF69K1DKAmwgAjJyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZtyTD+8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZtyTD+8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CC31F00A3D;
	Wed,  9 Sep 2026 14:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788962818;
	bh=5JLaXajg90xYmWo3hM1KaK0nfCsiZnag6hHeu8KVXMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oZtyTD+8oGan9iUTSj/D/BtnCBJkHRqUkChjEm37p89K7xMTjhcbez5I+f4xGxEPh
	 TwgKxxlXjuQqpnbaJ6MjoPkhRX7VV1rqWbnftRr5fXphY/lDCK2tAWl4dX7unTHSBm
	 /VCiq0CCsaQAZsQn74YTuGgmk4zTR2ne7+yBULJ9mJWNPFt8de4oId9uIHNPBUVCbE
	 wo5cDd/Nm/XTjRXGRvW+viA2u4Vc0C/wKwGT8UZf2huIZbgHcMI+SfKnHhZvFTIs2/
	 u2ElGUoJq2Cpe5x1R1ZQMXxMG4/7BneYRYW05rnHYy16123FX4SPV5VjARvkOKRUI/
	 FTEMGqu6/l2Ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/12] mm/sparse: move __highest_used_section_nr
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-8-008fc8d579fe@kernel.org>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-8-008fc8d579fe@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:06:57 +0000
Message-Id: <20260909140658.78CC31F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The local variable `section_nr` is declared without initialization=
 and may be unconditionally assigned to the global `__highest_used_section_=
nr` if the memory iteration loop does not execute.

Pre-existing issues:
- [High] Non-atomic read-modify-write of `ms->section_mem_map` in `sparse_i=
nit_one_section()` can cause concurrent `pfn_to_page()` callers to derefere=
nce a corrupted pointer during subsection hotplug.
--

commit 1d1de8fdca5c2e1ad233b201e49c0d20c64c448b
Author: David Hildenbrand (Arm) <david@kernel.org>

mm/sparse: move __highest_used_section_nr handling

Moves __highest_used_section_nr handling to sparse_init_one_section(), but
also initializes it in sparse_sections_init() to keep early boot working.

> diff --git a/mm/sparse.c b/mm/sparse.c
> index 2b41ae36f20b8..2d0f2db34f4cf 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -177,7 +177,7 @@ static inline unsigned long first_present_section_nr(=
void)
> =20
>  void __init sparse_sections_init(void)
>  {
> -	unsigned long pfn, start_pfn, end_pfn;
> +	unsigned long pfn, start_pfn, end_pfn, section_nr;
>  	int i, nid;
> =20
>  	sparse_extreme_init();

[ ... ]

> @@ -201,6 +201,7 @@ void __init sparse_sections_init(void)
>  			__section_mark_present(ms, section_nr);
>  		}
>  	}
> +	__highest_used_section_nr =3D section_nr;

[Severity: High]
Could this assign an uninitialized value to __highest_used_section_nr?

If the memory iteration loop does not execute, section_nr remains
uninitialized. This could occur if mminit_validate_memmodel_limits() clamps
start_pfn and end_pfn to the same value, or if for_each_mem_pfn_range()
yields no memory ranges.

Writing stack garbage to __highest_used_section_nr could lead to
out-of-bounds array reads and undefined behavior in subsequent boot stages
like sparse_metadata_init().

> diff --git a/mm/sparse.h b/mm/sparse.h
> index 7c5d82ceb7142..a3af4967fd5c5 100644
> --- a/mm/sparse.h
> +++ b/mm/sparse.h
> @@ -97,6 +97,9 @@ static inline void sparse_init_one_section(struct mem_s=
ection *ms,
> =20
>  	BUILD_BUG_ON(SECTION_MAP_LAST_BIT > PFN_SECTION_SHIFT);
> =20
> +	if (section_nr > __highest_used_section_nr)
> +		__highest_used_section_nr =3D section_nr;
> +

[Severity: High]
This is a pre-existing issue, but can the non-atomic update of
ms->section_mem_map in sparse_init_one_section() cause concurrent
pfn_to_page() callers to dereference a corrupted pointer?

During subsection hotplug for ZONE_DEVICE memory, sparse_add_section()
calls sparse_init_one_section() on an already-active memory section. The
shared state is mutated non-atomically in place:

mm/sparse.h:sparse_init_one_section() {
    ...
    ms->section_mem_map &=3D ~SECTION_MAP_MASK;
    ms->section_mem_map |=3D coded_mem_map;
    ...
}

This transiently zeroes the pointer portion of the state. If a lockless
reader on another CPU concurrently calls pfn_to_page() for a different
already-online subsection within the same section, it will extract a zeroed
base pointer in __section_mem_map_addr():

include/linux/mmzone.h:__section_mem_map_addr() {
    ...
    map &=3D SECTION_MAP_MASK;
    return (struct page *)map;
}

Could this produce an invalid struct page pointer and crash the system?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-b4-sparsem=
em_cleanups-v1-0-008fc8d579fe@kernel.org?part=3D8
