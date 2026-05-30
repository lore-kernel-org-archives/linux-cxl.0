Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123843016E1
	for <linux-cxl@vger.kernel.org>; Sat, 30 May 2026 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161227; cv=none; b=daHmJJh8qW9G+Y+c3h6m9KOWIyvbZLbeTdYWu+J7P4Ob0jsdiM7Xpr8FJrvIOgei3GRO9P/IHso1pEX6w2Z6O0RuGThpWk1gkepU2S2aCFNzrHuo5125kliKZ8GRlYUA8WOdwjz1GdlYgzx4cAszqF3c2yJ9fXG5uo5bo0GjYhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161227; c=relaxed/simple;
	bh=LL5IXhki/urQRS0LZ8ru6pRJhc/1ldc23Rwq6KNpKxs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W9QaWNdrpJVq0+2vwQmTNY0Q/kGa5aaRlarD8rmWVde+HlV9+UiJCmjb97wbKhu/6cELBEYxpYrmtz/WdnZa9qq1KYH+SPf4fcl79mrZvxlM5s69KTm7Ae9VqU0+btUQDp+4uRpCBEanluBLnWVqwbzLew1ahzmKAYdW+T/6FdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTs9+ozL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTs9+ozL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B380F1F00893;
	Sat, 30 May 2026 17:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780161225;
	bh=b+p4J93vLa0hgXzpKfBPkPJisnkhHFqHo+k9shXQR1o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NTs9+ozLNkB0n26c04sP9ClSdBINKDThJjAVCYX3Z9ccVw+hMVkgwSK6xJBL6419C
	 MMlONHIZFTWjt+/VkNrooQNqErK/xuf4hdDIz515r9yxq4t2ufqkuwgplQga02pYje
	 15ZKtzNxhpO4ogAy6ZcP8psbHCkiZSwX8bOiYd7dueoTQBzyyUzG6v4qR0pT3MiqTB
	 9id9SbxPYksuZx8tE/2jRnci/qF9E0Q8qImPZ8o1HPhtWSXtBzB2sp57bjVeUARX/X
	 5t5KtN4GnuJFmEsMdBxWlyDoTa8N0IPKudJqXt36pJ00NRh4s1EpO/h01TxAlrPAr6
	 MsMbGFKH+H8Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 2/9] dax/fsdev: fix multi-range offset in
 memory_failure handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019e79cb8953-e505a8dc-63a4-4bc3-a9bd-3b86ec081838-000000@email.amazonses.com>
References: <0100019e79cb8953-e505a8dc-63a4-4bc3-a9bd-3b86ec081838-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 17:13:45 +0000
Message-Id: <20260530171345.B380F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless iteration over `dev_dax->ranges` in `fsdev_pfn_to_offset`=
 causes a Use-After-Free.
--

commit 104845be5fb1300e103dae52129fee9336fbed14
Author: John Groves <John@Groves.net>
dax/fsdev: fix multi-range offset in memory_failure handler

This commit fixes the memory_failure offset calculation for multi-range
devices by introducing fsdev_pfn_to_offset() to walk the range list and
compute the correct device-linear byte offset.

> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> index 188b2526bee45..f315533b299e9 100644
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c
[ ... ]
> @@ -135,11 +135,26 @@ static void fsdev_clear_ops(void *data)
>   * The core mm code in free_zone_device_folio() handles the wake_up_var()
>   * directly for this memory type.
>   */
> +static u64 fsdev_pfn_to_offset(struct dev_dax *dev_dax, unsigned long pf=
n)
> +{
> +	phys_addr_t phys =3D PFN_PHYS(pfn);
> +	u64 offset =3D 0;
> +
> +	for (int i =3D 0; i < dev_dax->nr_range; i++) {
> +		struct range *range =3D &dev_dax->ranges[i].range;

[Severity: High]
This is a pre-existing issue, but does iterating over dev_dax->ranges here
without locks expose us to a use-after-free?

Because fsdev_pfn_to_offset() is called asynchronously by the memory_failure
handler, it seems possible for it to race with root writing to the mapping
sysfs attribute to append ranges. That write invokes mapping_store().

Unlike size_store(), mapping_store() does not check if the DAX device is
currently bound to a driver before calling alloc_dev_dax_range(). That func=
tion
uses krealloc() to expand the dev_dax->ranges array, freeing the old memory.

If fsdev_pfn_to_offset() executes concurrently with this sysfs write, could=
 it
dereference the freed array pointer?

Would it be safer to pass the pgmap parameter down from the memory failure
handler and iterate over pgmap->ranges instead, since it contains a stable,
immutable snapshot of the ranges created during driver probe?

> +
> +		if (phys >=3D range->start && phys <=3D range->end)
> +			return offset + (phys - range->start);
> +		offset +=3D range_len(range);
> +	}
> +	return -1ULL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019e79caead2-57=
95328c-af48-4a93-b147-c11df7446e1a-000000@email.amazonses.com?part=3D2
