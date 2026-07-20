Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED0A72623
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jul 2026 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513969; cv=none; b=rhOO9Ne4wOJlpqckagVHrg1o7KpFAAPtfTyomlEfGtNbVPNK3j0cogMM56nrjo/vNECIzIgKs2Ce0MrLEiVmGGDvX4DoBRTb87KbipitenrdM8uEis+aK0yQ/eWPzpVCh9d2lb86uMbVAKAb8eff9kVVXzBo4XkDLF82nkjTox4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513969; c=relaxed/simple;
	bh=HqvJQf3NBj6mOCIO9D1LcuyUdq0ss97jSgnqaE25+fk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pKVd95SmdsbuX59eIktuLI9lDFNiw2MQ1H/ZKs3eTi9K+9cFv0izZPvsSdvz3yOkQv2GSFXC/vsMPsPsXOiyPmiggucKPDpV0aFPU1RECqzzm3ms7H87ueqMeNz5K62tK9+ut51O/BskZ6318wYs34QIbZiKV7pCOjU+HiOMOnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhVwMfOg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhVwMfOg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C651F000E9;
	Mon, 20 Jul 2026 02:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784513968;
	bh=cAtojhBuYwYB9MtdkujCkDtoHsr5n15RflF+kdnEmWo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IhVwMfOgDOkWH9j+po5TT6lC2MDci2OsC6sQ1+ABlnHjDvQDxDJSOILRMepbIhxey
	 ge4++Ooht5cFVYyyqUyBS2Qq1gYYqlY6GaTdztYOEQ6FphLTnD5hXUKgRbuaGuZ8A5
	 pNuH26IbX+DzrFIG8aZXG+LZ2G1E4aTw58M1zBVxwwgg1yoMG6EVKLSYt2rPuarrV9
	 /SWPPnORO2vcXmWPchd00c9tMZR0oqKMwmROd2NdhWFSTX2UxaWJnd1GTTNmLLF4aX
	 z9VGfFBz4U/toToZtTJesPtln8wGGcDDAoSJ59Mt4cVmtRXXYYQnWxK14Al3w4JwXm
	 eRoMnjwtzd2Yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] arm64/mm: Check the requested PFN range during memoroy
 removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260720020655.9607-1-icheng@nvidia.com>
References: <20260720020655.9607-1-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 02:19:27 +0000
Message-Id: <20260720021928.18C651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `addr_splits_kernel_leaf()` violates ARM64 lockless page table wal=
k guidelines by performing naked dereferences and failing to account for fo=
lded topologies.
--

--- Patch [1]: [PATCH] arm64/mm: Check the requested PFN range during memor=
oy removal ---
commit f65ddd9a8b39c91ebed9695bf77580886a5fd37c
Author: Richard Cheng <icheng@nvidia.com>

arm64/mm: Check the requested PFN range during memoroy removal

prevent_memory_remove_notifier() advances pfn while checking whether the
range contains early memory, which causes can_unmap_without_split() to check
the wrong range. This patch passes arg->start_pfn instead to ensure the
leaf-split check examines the requested range.

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index a25d8beacc831..18a8b0d3714ee 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -2194,7 +2194,7 @@ static int prevent_memory_remove_notifier(struct no=
tifier_block *nb,
>  		}
>  	}
> =20
> -	if (!can_unmap_without_split(pfn, arg->nr_pages))
> +	if (!can_unmap_without_split(arg->start_pfn, arg->nr_pages))

[Severity: High]
This is a pre-existing issue, but does addr_splits_kernel_leaf() (called by
can_unmap_without_split()) violate lockless page table walk guidelines?

In arch/arm64/mm/mmu.c:addr_splits_kernel_leaf():

	p4dp =3D p4d_offset(pgdp, addr);
	p4d =3D p4dp_get(p4dp);

When P4D is folded, p4d_offset() returns pgdp. p4dp_get() then issues a
second READ_ONCE(*pgdp), which can observe a transiently cleared state if
the entry is modified concurrently (e.g. during a Break-Before-Make
sequence).

Additionally, lower down in the same function:

	ptep =3D pte_offset_kernel(pmdp, addr);
	pte =3D __ptep_get(ptep);

Is it possible for pte_offset_kernel() to directly dereference the shared
pmdp pointer without READ_ONCE(), violating lockless walk atomicity
requirements?

If the lockless walk observes a transiently cleared page table entry, it
could incorrectly return false, falsely indicating that the memory range
does not split a leaf mapping. This would allow a memory hot-remove
operation to proceed and unmap an entire leaf, unmapping adjacent live
kernel memory and causing a synchronous data abort on the next kernel
access.

>  		return NOTIFY_BAD;
> =20
>  	return NOTIFY_OK;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720020655.9607=
-1-icheng@nvidia.com?part=3D1
