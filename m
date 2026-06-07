Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A611A262D
	for <linux-cxl@vger.kernel.org>; Sun,  7 Jun 2026 19:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780861742; cv=none; b=k0jATW7MN8rifDGYt2K/gABcaerp4DBxjk9vUc6swbZHHINpP5M5cpniu3SZjTB90ki1sETdhVydRP6+8tCxVzFCWE+dNkgI+9ihAfAYGLzgZ+V9HO0dN3BcxALjzNFjK4obbewseUlEmlhDpVOaAJOfWEKQuxMlKogOpNOjWAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780861742; c=relaxed/simple;
	bh=Amm7tx3+jjW0vP09GnfCPt3oQle2q22/FWBmAsz+G84=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L3S6t2f/RSU/h8G07Xjz6EwNqPb/ubeiITvnCVGAB0VQoX/sou3cJVMy60A3xLf2p8S9mPKIshkPmFEYbZwoCScLUCttspBnFXtgdkf7gYAzrHhGebP/KJIX4bAUUdKVhFtrshenrW9SVcaf0wbEWy2vbe+4NO8ZIvX7thd6bIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXxpM/6F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXxpM/6F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC061F00893;
	Sun,  7 Jun 2026 19:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780861741;
	bh=RhaMdjBl5RbS2GJVJPVVm7ukktjmxK/ayYo5HtfnFQE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jXxpM/6Fh9spcxi6mYvF4a3cAFfjXUw1qK8EBtiaDqdbvPip12agCHeZDDopZczhS
	 61eBarVbgp8ct5nnrzyltvzUV5U2CR2cQmztB2iATI864hmT1XzfMYM94UfC5Wnun+
	 gdUduL2xFTfPKLDL+B4VIDbd2Ne29hGdlAx/IPBICr+8Jh6frv8bxlJ8J3U4spJAef
	 becZ7HNe8bdFgH53aM+dgYM91L6VGkDNDtmMGk7fnfI3OS+YoX5RQLo99L3MHuIzDa
	 sWvYlMbYg/oxjzQZPLGLH9Lr/cveMV/BzFeq0TtZu2HvCPfUltPU0ItZ9GgSHRohEU
	 kiEzat7wQF81A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 2/9] dax/fsdev: fix multi-range offset in
 memory_failure handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019ea3934be1-ce7c2c13-b9fd-40b2-9284-14bc42d5cb08-000000@email.amazonses.com>
References: <0100019ea3934be1-ce7c2c13-b9fd-40b2-9284-14bc42d5cb08-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 19:49:00 +0000
Message-Id: <20260607194900.CAC061F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless iteration over the dynamically reallocated `dev_dax->rang=
es` array can cause a Use-After-Free or out-of-bounds access.
--

commit f367744bc128642b975efbceb84c1bfc7d8fa44a
Author: John Groves <John@Groves.net>

dax/fsdev: fix multi-range offset in memory_failure handler

This commit fixes the memory failure offset calculation for multi-range
devices. It introduces fsdev_pfn_to_offset to walk the range list and
compute the correct device-linear byte offset instead of relying on the
start of the first range.

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
This is a pre-existing issue, but does lockless iteration over
dev_dax->ranges expose us to a use-after-free here?

If a privileged user writes to the sysfs mapping attribute concurrently,
it can trigger an array reallocation:

mapping_store()
  alloc_dev_dax_range()
    krealloc()

Since this iteration in fsdev_pfn_to_offset() does not hold a synchronizati=
on
lock like dax_dev_rwsem, a concurrent krealloc() could free the array while
it is being walked during a memory failure event. The previous code
locklessly accessed the first index, but the new loop extends the window
where this could occur.

Would it be safer to iterate over the immutable snapshot stored in
pgmap->ranges instead, since that is populated during probe and passed into
the memory failure handler?

> +
> +		if (phys >=3D range->start && phys <=3D range->end)
> +			return offset + (phys - range->start);
> +		offset +=3D range_len(range);
> +	}
> +	return -1ULL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019ea3929225-a0=
f8e6f7-30ae-4f8e-ae6f-19129666c4c3-000000@email.amazonses.com?part=3D2
