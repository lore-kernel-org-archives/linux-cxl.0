Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AB843DA2C
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200297; cv=none; b=IFS3Z8mGylqIbw07LzXlp8ZHYLAzOsdq5btXE5PgXAWR9k6aYNsIsrtVwSUj2CJIRs5mrsU9efzIUPqhORiPRg9pRE2ir72yv+x12jPDbmQ+KudVdDYDQ+Yl3wgyElCitwqarqk0ISvYNdGUbBZy9ERkmQNCe7fMSdpG31pkJl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200297; c=relaxed/simple;
	bh=ZnKea/DqPXWlh5cJira3cdNmtCuOYHUARar6VPnDEM0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aqnFjvwvTpZSV+cp3jNtsGZ6J0Cw4Ji1kK4f7Jf26k37xY6bXoUCU/skE5WoHRTrf1HRDW5byupq04lCCXQDqYnPejQKgY3EIFiwELJ/jKFQL9WLWXL97ZstvpMXRa82fzhFXDMHIrUAvTJxfhLRIUfUVLrbHj9EtV3AzYJn1vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLdjE0hL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLdjE0hL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356021F00893;
	Thu, 11 Jun 2026 17:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200296;
	bh=qnKbxtDftLDd/PsNnYRT0Oq8nMG/+20cNFvGcDy6QU4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DLdjE0hLvh/ffZZtSaQtbDQvhaD0UStlaAM8CmK52sdRJqhYpWpnG484d4JBENE+n
	 +cGqxQQKaUQ4xCgmtuDcbTAeLeCPPJ4L4D2Z34zNgi4dlBa9Co02sFmQNWwupdDkPc
	 16sISVbKHJw6uRy/MbxX+p/xBbykqSPUrHswZV7wRNS56cgbpp42Zc3Fv4CT1cdaYv
	 U7KeIgFMn/hv+9k1M3H3JYnw2TLfvXCsrwkacwf5Y6pEkjSkr4hkjoO6QWgy/Prxzs
	 KXWQDYfHedYQDym+uVwG/z0UezK8L1TDPYTxEpyoG2Hxwdr2r6t+7tHfVi1hx1QbAn
	 4cLJ7gcdrg82w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 2/9] dax/fsdev: fix multi-range offset in
 memory_failure handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019eb7bda506-6ba24207-b1c0-4eeb-9b04-61940cf3f80c-000000@email.amazonses.com>
References: <0100019eb7bda506-6ba24207-b1c0-4eeb-9b04-61940cf3f80c-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:51:35 +0000
Message-Id: <20260611175136.356021F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Incorrect memory failure offset calculation for static DAX dev=
ices, causing the wrong filesystem blocks to be marked corrupted.

Pre-existing issues:
- [High] Use-After-Free in dax_pgoff_to_phys() due to concurrent reallocati=
on of dev_dax->ranges array via sysfs.
--

commit 410f6bffae27c2c1b51ab4214947b135248b8594
Author: John Groves <John@Groves.net>

dax/fsdev: fix multi-range offset in memory_failure handler

This commit updates the offset calculation in the memory_failure handler for
multi-range DAX devices. It changes the logic to iterate over the device
pagemap's immutable ranges array instead of the potentially dynamically
reallocated dev_dax ranges array.

>     Walk the pagemap's own range array (pgmap->ranges[]) rather than
>     dev_dax->ranges[]. The pgmap copy is the immutable snapshot populated=
 at
>     probe and is never mutated afterwards, whereas dev_dax->ranges[] can =
be
>     krealloc()'d by a concurrent sysfs mapping_store() (under dax_region_=
rwsem,
>     which this ->memory_failure callback does not hold). For dynamic devi=
ces the
>     two arrays are identical, so the reported offset is unchanged for the
>     multi-range case this targets.

[Severity: High]
This isn't a bug introduced by this patch, but since the commit message
mentions that dev_dax->ranges can be krealloc()'d by a concurrent sysfs
mapping_store(), does this expose a use-after-free risk in
dax_pgoff_to_phys()?

Unlike size_store() which checks if the device is bound to a driver,
mapping_store() appears to lack this check and can invoke
alloc_dev_dax_range() to reallocate the array while the device is
actively in use:

drivers/dax/bus.c:mapping_store() {
    ...
    rc =3D alloc_dev_dax_range(dev_dax, r.start, to_alloc);
    ...
}

Meanwhile, filesystem I/O operations can locklessly iterate over the ranges
array:

drivers/dax/bus.c:dax_pgoff_to_phys() {
    ...
    for (i =3D 0; i < dev_dax->nr_range; i++) {
        struct dev_dax_range *dax_range =3D &dev_dax->ranges[i];
    ...
}

Could a concurrent sysfs write to the mapping attribute cause a
use-after-free if dax_pgoff_to_phys() is iterating the old ranges
array that was freed by krealloc()?

> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> index 188b2526bee45..2c5de3d80a618 100644
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c

[ ... ]

> @@ -135,11 +135,26 @@ static void fsdev_clear_ops(void *data)
>   * The core mm code in free_zone_device_folio() handles the wake_up_var()
>   * directly for this memory type.
>   */
> +static u64 fsdev_pfn_to_offset(struct dev_pagemap *pgmap, unsigned long =
pfn)
> +{
> +	phys_addr_t phys =3D PFN_PHYS(pfn);
> +	u64 offset =3D 0;
> +
> +	for (int i =3D 0; i < pgmap->nr_range; i++) {
> +		struct range *range =3D &pgmap->ranges[i];
> +
> +		if (phys >=3D range->start && phys <=3D range->end)
> +			return offset + (phys - range->start);

[Severity: Critical]
Does this calculation incorrectly include the data_offset padding for static
DAX devices?

For static DAX devices, the device's physical range starts with a metadata
padding area (data_offset). The old code calculated the offset based on
dev_dax->ranges[0].range.start, which represents the start of the actual
user data.

By using pgmap->ranges[0].start instead, which includes this metadata
padding, the logical offset might be inflated by data_offset. Could this
cause the filesystem to receive an incorrect offset in
dax_holder_notify_failure(), potentially resulting in poisoning the wrong
filesystem blocks while leaving the actual corrupted blocks unmarked?

> +		offset +=3D range_len(range);
> +	}
> +	return -1ULL;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019eb7bcda4b-3f=
8edae9-d7a4-4bfa-aaea-fcef77fdbbc3-000000@email.amazonses.com?part=3D2
