Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F142123B
	for <linux-cxl@vger.kernel.org>; Mon, 21 Sep 2026 20:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021834; cv=none; b=cEnWFfoLUt4rIn6ZgSGWdFVrfU8YTVtLkRdf/4O42sq7FuyBOjiZkDjcG5e1YrjrUvdwg4IwR97z6ivtMaKgEWeItvPbQBAt60Tuw5AFoOG7AxRTowh2anmdNG3MK0myy/UR2kQlhHj3v4ofPYIjfuwabTX1uVi+F4epdo2OwpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021834; c=relaxed/simple;
	bh=BCgnP07t/RP2ZMi9GqtGDnQAs+iBo0GBQoJpWJy0Tec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AqlmAehNhkhqeJtmv7uw5D1ih7NJ4Tb2ulSkR8+nuNuSIvL77pD2qrd6TpS+x4FM+gGMMocDWdLvk9L+Csr0avJnpPnLx1l5xI1diINkrQwqCuDZDGEmBfjUm9kyJ6XriOWZ+EYS2qJGGgXGnheXWqBaQfPu9ERtonQp6QOgjOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebLvmDLv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebLvmDLv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587C31F000FF;
	Mon, 21 Sep 2026 20:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790021832;
	bh=HsZ2cg3OSDEhGhKTC4NOkswsCtOckMdib7eYKaHxnrM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ebLvmDLvsB6GH4X21RkhOVwgtzdOTZMUr6Y5ve+7Lh+f/WnWDEm5pDAMyxzs6dLP7
	 YaOjP2Zf/Em2m7Oa4ijesi09rM8501nWluodVjkJ2BfOBkdh4P0+7vS33vtaIB5ksV
	 aiYUud3n0qrPIFtBq02OUsCXO7vPqM1hmpHwjesx86YRztzaWnHL3wlOHYouOK3KRD
	 f31i2s/LXNQozMmzgg5pLT7T8RKDgLzdqCq/icUS9MbZ3e9YijCcip/JbLISzwRryZ
	 RLLlr8rUUzsGhXSaFem/W8GSkEm3JPqRJSSQ0lG45zeJjZ/iwCtCjmWoZ2M1ctBo4q
	 V+wwA0Z65+1kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/13] mm/sparse: move __highest_used_section_nr
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260921-b4-sparsemem_cleanups-v2-8-54d81d65e125@kernel.org>
References: <20260921-b4-sparsemem_cleanups-v2-0-54d81d65e125@kernel.org>
 <20260921-b4-sparsemem_cleanups-v2-8-54d81d65e125@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 20:17:11 +0000
Message-Id: <20260921201712.587C31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm: uninitialized variable section_nr leads to build failure and=
 logic error
--

commit c9ec175770a339f5cfe5ee3f81573978aba08b75
Author: David Hildenbrand (Arm) <david@kernel.org>

mm/sparse: move __highest_used_section_nr handling

This commit prepares for removing __section_mark_present() by moving
__highest_used_section_nr handling into its callers. In
sparse_sections_init(), it updates the highest used section number to
the last processed section_nr.

> diff --git a/mm/sparse.c b/mm/sparse.c
> index bb89017254f4d..a0f50ca5acf5a 100644
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
> @@ -187,9 +187,9 @@ void __init sparse_sections_init(void)
>  		mminit_validate_memmodel_limits(&start_pfn, &end_pfn);
> =20
>  		for (pfn =3D start_pfn; pfn < end_pfn; pfn +=3D PAGES_PER_SECTION) {
> -			unsigned long section_nr =3D pfn_to_section_nr(pfn);
>  			struct mem_section *ms;
> =20
> +			section_nr =3D pfn_to_section_nr(pfn);
>  			sparse_index_init(section_nr, nid);
[ ... ]
> @@ -201,6 +201,7 @@ void __init sparse_sections_init(void)
>  			__section_mark_present(ms, section_nr);
>  		}
>  	}
> +	__highest_used_section_nr =3D section_nr;

[Severity: Medium]
Does this assignment introduce a regression by copying an uninitialized sta=
ck
value into __highest_used_section_nr?

In sparse_sections_init(), section_nr is declared without initialization.
If no memory regions exist, or if mminit_validate_memmodel_limits() clamps
start_pfn such that start_pfn >=3D end_pfn, the inner loop will not execute.

When the outer loops conclude, this unconditionally copies the potentially
uninitialized stack value into a global state variable. Because
__highest_used_section_nr bounds many loops across the mm subsystem, this
regression could cause infinite loops and kernel hangs during boot.

Additionally, without static proof that the loops execute at least once,
compilers might issue a -Wmaybe-uninitialized warning that breaks kernel
builds enforcing CONFIG_WERROR.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-b4-sparsem=
em_cleanups-v2-0-54d81d65e125@kernel.org?part=3D8
