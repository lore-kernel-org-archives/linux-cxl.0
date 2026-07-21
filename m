Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ABA346FD2
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628934; cv=none; b=At53yJ3dCGH2R4WXGtguaAXZ4niSji2PPnWPxpDcc7MIyYXgDuq8Id+Bs1Z6ml1xxtJrwz1NGVRgUlN2YlsJtfrDIaOBmPxucgOh+XOm65DlUOd9VmL8GW+dpXBc7yUI/VRemyuIlZW8U3oHxwNzDzvR5Hch260SdUB9KDSQlEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628934; c=relaxed/simple;
	bh=nf9efHu7pW+lIHZr6EyPW1FHAZslRSceLzFxgJIF7DA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j341bYmWepxLgizxK3zknhls/gpNBmhFrdqW/jCu9bE0YZ2/sXih3qhgiloLdkbEC2iZeniCt33Qj8ub2hVC+kFS1ZNwpMe2TuAFTds7B41NLVkue5Jc+KGVOYkK95L3diIGry696vPk28dMCl29CZPpJQx7L6gbudgg8e3oi7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DV+jywCS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DV+jywCS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52AF1F00A3A;
	Tue, 21 Jul 2026 10:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784628933;
	bh=/Xs6/J5NWkfYKiTI0Ms2qdT/dwbODzSuWQ3gYMZ5A5s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DV+jywCSjQEMySWBsT6bpwIrQDGVQhx7viJgycWUqAtnZSclpqjVE9ZX2cAH+vbdn
	 3aMR2v8fQRrrNhmT1Y+v21qc1hEec1fhy2ri1X2FSEHnDs9OMA5p72AwNOoRWoBIVO
	 F3fjxtaS3aO6gsLpFvJ5uvgHQuRnWmJapUCzfuBMkN6MWkuNVA7zPHHiEpA9ecPj+G
	 QuU1uSFqE43K65t9Q/Gaw8QzSUAhQpMhkBSSnEleRRnc5oO3340qGImIsjO0WeQQUn
	 yLcYQBp7j9viHUSyWrudsDFt7cOb6IHhZf7n2wtHLiLPyok3RLAg3DVl3nuE/ryDV1
	 +4pCUcXXATFzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] arm64/mm: Check the requested PFN range during
 memory removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260721100026.10408-1-icheng@nvidia.com>
References: <20260721100026.10408-1-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 10:15:32 +0000
Message-Id: <20260721101532.C52AF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The lockless page table walk in `addr_splits_kernel_leaf` derefere=
nces shared PUD and PMD pointers without `READ_ONCE()`, violating ARM64 sub=
system rules.
--

--- Patch [1]: [PATCH v2] arm64/mm: Check the requested PFN range during me=
mory removal ---
commit bacbc9fb9b238d0e34546abe25a64655eea1704f
Author: Richard Cheng <icheng@nvidia.com>
arm64/mm: Check the requested PFN range during memory removal

This commit fixes the memory removal notifier to check the correct
requested PFN range rather than the range following it. It does this
by passing arg->start_pfn into can_unmap_without_split() instead of
the already advanced pfn variable.

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index a25d8beacc831..18a8b0d3714ee 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
[ ... ]
> @@ -2194,7 +2194,7 @@ static int prevent_memory_remove_notifier(struct no=
tifier_block *nb,
>  		}
>  	}
> =20
> -	if (!can_unmap_without_split(pfn, arg->nr_pages))
> +	if (!can_unmap_without_split(arg->start_pfn, arg->nr_pages))

[Severity: High]
This is a pre-existing issue, but does the page table walk in
addr_splits_kernel_leaf() (called by can_unmap_without_split() here) need
to use READ_ONCE() for its shared pointer dereferences?

Looking at addr_splits_kernel_leaf(), it performs a lockless walk of the
kernel page tables. It passes pudp to pmd_offset() and pmdp to
pte_offset_kernel():

arch/arm64/mm/mmu.c:addr_splits_kernel_leaf() {
        ...
        pmdp =3D pmd_offset(pudp, addr);
        pmd =3D pmdp_get(pmdp);
        ...
        ptep =3D pte_offset_kernel(pmdp, addr);
        pte =3D __ptep_get(ptep);
        ...
}

On arm64, the generic implementations of pmd_offset() and
pte_offset_kernel() perform plain loads instead of using READ_ONCE().

If there is a concurrent modification of the kernel page tables (such as a
split of a linear map huge page triggered by secretmem), could the compiler
observe a torn or stale pointer here?

Dereferencing this through pmdp_get() or __ptep_get() might result in
accessing a bogus physical address and causing a kernel panic.

>  		return NOTIFY_BAD;
> =20
>  	return NOTIFY_OK;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721100026.1040=
8-1-icheng@nvidia.com?part=3D1
