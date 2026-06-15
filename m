Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C4F8F7D
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jun 2026 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540709; cv=none; b=hPOd84tYcQQw/HklTMSo4wORFpSuJXYz3SGnA5N7kfZXgZQI6ODYJMmRwzyF03zC/pklIL0QmODB4SbnKdmLMyQCKvakAdjU9GNgShzirVpdy6BsF2mRhN2FfrjJRiiMC/W4y5pttW+w8+6j7owhWez+iNAKOA1tcrKpyFJDddE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540709; c=relaxed/simple;
	bh=IMRGg9qe1CTlixYFxw7fTJj51O/d2O9w2b9tppQgsbk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GdtPs1RRp7gHpB+xfOgjaa1AE6crVk5z1XF6dzH7d8AEQ+VK3rk5YEwl8tEob3o7MSStiLfwK3lzS3UwGZoZOiU4/IWKC9tjv0eUe5WUmh8vEb+j8tzHYnWK79Hdhg5zHtw75Eso6AXTzK3qS5uLeWQoKUqZf3OgqHzlnycfWBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mV1FFd7a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mV1FFd7a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F251F000E9;
	Mon, 15 Jun 2026 16:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781540708;
	bh=NIAX5DCUjQglXsJ6HQnC3EzjjAW2/qsW+2uty9SVlOk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mV1FFd7axvt0mtbWUCpxTLMy43FzaO9pEVoJN5hVfChm4M+mnYC0OMcfm8dGKBNeZ
	 gEOqdiQEuIThksMvB6qVpo2Es9Q8UQmO67fO04teV0kgYauBSUWLF7ZmeIRIblpd3n
	 eLa3pXiCMsfV/04JiSAjcQwQlRLGkBw+wZyLXi5zY6vTY1rEEDXyon6aO63MVjVz/E
	 thQwVS1tztEcOu3NWzRFefdtf1FtZB9yo/TWDd7UyYJUZLyeMVOPJ62Je+rvOgbSGD
	 Je/rgyGoAPdFMR3p41taem9eUh/E/9CnI13lAp03Tw+Sw1DOjTnSplUeB1t2XOFlBF
	 PN7UO38Qlc6PQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V6 02/10] dax/fsdev: fix multi-range offset in
 memory_failure handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019ecc08d74f-ec0d09b8-11e9-4e5b-af48-8c6d382af486-000000@email.amazonses.com>
References: <0100019ecc08d74f-ec0d09b8-11e9-4e5b-af48-8c6d382af486-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 16:25:07 +0000
Message-Id: <20260615162508.29F251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Data Race / Out-Of-Bounds Read / Use-After-Free: Lockless iteratio=
n over mutable dev_dax->ranges causes new Out-Of-Bounds read
--

commit 41ef54df14f24d7b6da66ee222110e1acd13b89c
Author: John Groves <John@Groves.net>

dax/fsdev: fix multi-range offset in memory_failure handler

This commit introduces fsdev_pfn_to_offset() to calculate the correct=20
multi-range offset for a faulting PFN. It changes the calculation to walk=20
the dev_dax->ranges[] array instead of just reading index 0 to account=20
for physical gaps between ranges.

> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c
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
Does this lockless iteration introduce an out-of-bounds read risk?

The commit message notes that reading dev_dax->ranges[0] locklessly is a
pre-existing exposure. However, looping over the array using nr_range
adds a new issue.

If this runs concurrently with alloc_dev_dax_range() in drivers/dax/bus.c,
the ranges array can be reallocated and nr_range incremented:

drivers/dax/bus.c:alloc_dev_dax_range() {
        ranges =3D krealloc(dev_dax->ranges, ...);
        ...
        dev_dax->ranges =3D ranges;
        ranges[dev_dax->nr_range++] =3D (struct dev_dax_range) {
        ...
}

Without read memory barriers here in fsdev_pfn_to_offset(), could a CPU
observe the updated dev_dax->nr_range but still see the old (freed)
dev_dax->ranges pointer?

If so, this loop could iterate past the bounds of the old freed allocation,
causing an out-of-bounds read on the freed slab object.

> +
> +		if (phys >=3D range->start && phys <=3D range->end)
> +			return offset + (phys - range->start);
> +		offset +=3D range_len(range);
> +	}
> +	return -1ULL;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019ecc080a68-8d=
c0c99f-ab17-4aa9-83d9-490e9c97ac2e-000000@email.amazonses.com?part=3D2
