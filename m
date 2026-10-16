Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845904611C7
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792153489; cv=none; b=gfTsftPT2OJJOOZMLObLl/FBp++dyS9I1LUipHcItiBK4CdP+bs1Y/lOzZhlRfQvQGwOGhHRA4Ja9MBLvuvnA6zonPheCmKKpBYF69UlhB1CMtDBPYFEeO/DYNbQtinHGa1n1mYC7kgVeJ9YzvULl7i0v3MfMLVKQ3bkGnc94G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792153489; c=relaxed/simple;
	bh=gkci8dcOlutnCTgsG+YcSRmc2Qn5HciAL9x7E+ILFSc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nyCMKkiruhsm5tSkNG1sCGX1EwG0hjlGyXujBY1Z9Oy8ymPgWcpVPV6PVC190LGdD9a6ijeR9htCy9+5+SH7A/slLtG1ey/jAL2ARORVCgvwleHuC6WGINtsXyhwO4QwtHGwSsBqX/xH6aNOiauzNpY82lo6CbDSNiGDObQhS2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEhJdkTq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEhJdkTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349811F000C5;
	Fri, 16 Oct 2026 12:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792153487;
	bh=uZkLliBTAbncT8UcYQIGgYsB3uSF1T6JCa0mfoiL0j0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lEhJdkTqY//IdqQvHfCohAu6GgWoge6REmtuMPjdfVSPuiVSZRgzUzvh/Pvc6khR/
	 w6GTY6IHyoCoJjVspsRpzI9nDLpZGu5rBko0rKaKJ8Ihag1O59V2uuHtbq+/0fXj3/
	 3oEhGVavuWZPA0B4HNfhzoxBgFCVLV+3xiB8YBA8F0F9gXt3mHwuvgJbfWz2nRu8PW
	 sF+NFaYgwbATIPhSdw+CKArNp6zhF6/4d+WfADZNzGDkkCjFU5NhZ720kAqkpo1B45
	 UFiLDLXO4SBGIztOmogAi5x5wa7nv5FKhBpX3SW9bPOOsHkhOfYKVoxg32fWsUVQgg
	 6GhS7qym/oyQg==
Message-ID: <sashiko-outbox-174291@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/7] mm/memory-failure: efi: reserve the inherited
 poisoned-memory units
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>, "Ard Biesheuvel" <ardb@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org, "H.
 Peter Anvin" <hpa@zytor.com>, "Andrew Morton" <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Miaohe Lin" <linmiaohe@huawei.com>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>, "Oscar Salvador" <osalvador@suse.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo
 Krummrich" <dakr@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, kas@kernel.org, kexec@lists.infradead.org, "Brendan
 Jackman" <brendan.jackman@linux.dev>, "Johannes Weiner" <hannes@cmpxchg.org>, "Zi
 Yan" <ziy@nvidia.com>, shakeel.butt@linux.dev
Cc: linux-cxl@vger.kernel.org, rmikey@meta.com, riel@surriel.com, harry@kernel.org, kernel-team@meta.com
In-Reply-To: <20261016-hwpoison-kho-v6-6-f304255147da@debian.org>
References: <20261016-hwpoison-kho-v6-0-f304255147da@debian.org>
 <20261016-hwpoison-kho-v6-6-f304255147da@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 12:24:44 +0000
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] efi: linux_efi_poisoned_memory ABI depends on architecture word si=
ze
- [High] efi: missing PHYS_ADDR_MAX check causes physical address truncation
--

commit 458406c8bb39d60c5c6472cbc3795bf8b4bdc8e3
Author: Breno Leitao <leitao@debian.org>

mm/memory-failure: efi: reserve the inherited poisoned-memory units

This commit parses a new EFI table to inherit hardware-poisoned memory fram=
es=20
from previous kernels during kexec. It prevents the memory allocator from u=
sing=20
these corrupt physical pages.

> diff --git a/drivers/firmware/efi/poison.c b/drivers/firmware/efi/poison.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/firmware/efi/poison.c
> @@ -0,0 +1,174 @@
[ ... ]
> +static bool __init
> +efi_poison_geometry_valid(const struct linux_efi_poisoned_memory *pm)
> +{
> +	const u64 max_end =3D PHYS_ADDR_MAX - PAGE_SIZE;
> +	u64 nbits, span, top, end, len;
> +
> +	/* Whole words, and a bit count that can be taken without wrapping. */
> +	if (!pm->size || !IS_ALIGNED(pm->size, sizeof(unsigned long)) ||
> +	    check_mul_overflow(pm->size, (u64)BITS_PER_BYTE, &nbits))
> +		return false;

[Severity: High]
Does this architecture-dependent validation cause valid tables from mismatc=
hed
architectures to be rejected during kexec?=20

If a 32-bit kernel populates the linux_efi_poisoned_memory table with a size
that is a multiple of 4, a 64-bit kexec kernel will evaluate
IS_ALIGNED(pm->size, sizeof(unsigned long)) where sizeof(unsigned long) is =
8.
This check would fail, and the table would be erroneously discarded.

Additionally, if the table structure uses unsigned long for the bitmap arra=
y,
reading a 32-bit written array as 64-bit words can shift bit indices on
big-endian systems. Could fixed-width types like u64 be used instead to
ensure a stable cross-kernel ABI?

> +
> +	/* And a footprint that can be page aligned without wrapping either. */
> +	len =3D sizeof(*pm) + pm->size;
> +	if (check_add_overflow(efi.poisoned_memory, len, &end) ||
> +	    end > max_end)
> +		return false;
> +
> +	if (pm->unit_size < PAGE_SIZE || !is_power_of_2(pm->unit_size))
> +		return false;
> +
> +	/* Every unit has to lie inside the address space. */
> +	if (check_mul_overflow(nbits, (u64)pm->unit_size, &span) ||
> +	    check_add_overflow(pm->phys_base, span, &top))
> +		return false;

[Severity: High]
Should this validation also check if top exceeds PHYS_ADDR_MAX?

While this calculates the top address in 64-bit space, without an explicit
bounds check, a table specifying a phys_base above 4GB could pass validation
on a 32-bit architecture without PAE.

> +
> +	return IS_ALIGNED(pm->phys_base, pm->unit_size);
> +}
[ ... ]
> +static void __init
> +efi_poison_reserve_units(phys_addr_t table,
> +			 const struct linux_efi_poisoned_memory *hdr)
> +{
[ ... ]
> +		for_each_set_bit(bit, map, nbits) {
> +			u64 unit =3D off * BITS_PER_BYTE + bit;
> +			phys_addr_t base =3D hdr->phys_base + unit * unit_size;

[Severity: High]
Can this lead to physical address truncation on 32-bit systems?

Because hdr->phys_base + unit * unit_size evaluates as a 64-bit integer,
assigning it to phys_addr_t (which is 32 bits on 32-bit systems without PAE)
will silently truncate the upper 32 bits. This could cause valid low memory
to be erroneously marked as poisoned and reserved, potentially leading to
boot failures.

> +			bool overlap;
> +
> +			overlap =3D memblock_is_region_reserved(base, unit_size);
> +			if (memblock_reserve_hwpoison(base, unit_size)) {
> +				nr_skipped++;
> +			} else {
> +				nr_units++;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-hwpoison-k=
ho-v6-0-f304255147da@debian.org?part=3D6
