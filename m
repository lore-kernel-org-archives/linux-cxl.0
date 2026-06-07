Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79E54071CA
	for <linux-cxl@vger.kernel.org>; Sun,  7 Jun 2026 19:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780861432; cv=none; b=as2o5Z5gMlRrjmxAMFSnUTTO4FUeft0gIGrXgLLzoAqEz69oKc+ADoYiBdGM7HbJJAb8bW+ZQKyaAyEABcK/mSuqCNOWAEGij0vy95FpW2wlzL70r6lf6HVAmdRVovHFo+TgG2I1OVXKELMoAZs0JOHCT1Dqgz0oyt4c2KJKorM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780861432; c=relaxed/simple;
	bh=YeWiwsyKnbFomljMqUSxN+LAwyfuVikaYjVu+da7Gq4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WY0KjeRHOwHJGfnkFWZX6dqcJkE/bb+jxeZkMBLyNGmWoBwnqFjm7+6RfWBtB7aKgBR63omJhwHzVqvUzANnrCgvHzgMKr3HGoCvsRVdc1WdMwtz00AxUGJEcyMYcZAiYpIVeiDxZe6IVtPKgcZqVjLok3qF78WzHHAVHxLDQgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkxAZC4G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkxAZC4G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1CE1F00893;
	Sun,  7 Jun 2026 19:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780861431;
	bh=dS7cI+gxQuOpJ7CKuWfk8ppi9AfdPab/j6C19bdmFI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YkxAZC4GDVECT5NQHrLfGsK5MZr7tkYaxfqXlcG6KKXRDKXkGaNO6ZSheakvcZnzZ
	 OCvbs1amWGWiJiWpmGQ3dWXKP0rgU8IorMbhTuGG/YQ+I8AZHcvwZLVeVGzM2+bFjO
	 2NZZGt0B+PBMRlDSfAp2JvDh4ZTdF3Lq4GEpZAjAkOFL9dfpL6QheYtCIsq8eoscqP
	 x7GsabIuYYi4Ku7SxeLOOGy5oEDaP9L79xLiveAjf+1q3r0Ut3izG2BHEcQNPx5sDA
	 LLTCd9rAqfvwrWwN/4q0JZNa9HTmpea58h72ndy/MKPs1iiFOGvx7pkOkECztamjqH
	 Yx91psuyLyF6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 6/9] dax/fsdev: fail probe on invalid pgmap offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019ea393f2e0-98d65e1f-5656-4e44-afa4-f9836ab6dd40-000000@email.amazonses.com>
References: <0100019ea393f2e0-98d65e1f-5656-4e44-afa4-f9836ab6dd40-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 19:43:50 +0000
Message-Id: <20260607194351.5D1CE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The validation check for `pgmap_phys > phys` is unreachable in the=
 exact failure case it is meant to handle, resulting in a kernel panic due =
to out-of-bounds `vmemmap` access before the bounds check is evaluated.
--

commit 18b2ee922105fd88cbce7e6ed1c6000666fc3c6c
Author: John Groves <John@Groves.net>
Subject: dax/fsdev: fail probe on invalid pgmap offset

This commit converts a warning into a fatal error during probe when the
remapped region starts after the device's data region. It aims to prevent
virt_addr misalignments by returning an error instead of continuing with a
zero offset.

> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c
[ ... ]
> @@ -320,8 +320,12 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
>  		u64 phys =3D dev_dax->ranges[0].range.start;
>  		u64 pgmap_phys =3D pgmap[0].range.start;
> =20
> -		if (!WARN_ON(pgmap_phys > phys))
> -			data_offset =3D phys - pgmap_phys;
> +		if (pgmap_phys > phys) {
> +			dev_err(dev, "pgmap start %#llx exceeds data start %#llx\n",
> +				pgmap_phys, phys);
> +			return -EINVAL;
> +		}

[Severity: High]
This is a pre-existing issue, but does this new validation check actually
execute before a crash occurs?

Looking at fsdev_dax_probe() in drivers/dax/fsdev.c, the validation block
handling the pgmap_phys > phys state is placed after
fsdev_clear_folio_state() is called.

fsdev_clear_folio_state() iterates unconditionally starting at phys:

drivers/dax/fsdev.c:fsdev_clear_folio_state() {
    ...
    while (pfn < end_pfn) {
        struct folio *folio =3D pfn_folio(pfn);
        ...
}

If phys < pgmap_phys, pfn_folio(pfn) dereferences pfns that fall outside
the remapped pgmap region, because vmemmap is only populated starting at
pgmap_phys via the earlier call to devm_memremap_pages().

Accessing these unpopulated vmemmap pages triggers an out-of-bounds page
fault.

Should the validation check and error return be relocated to execute before
fsdev_clear_folio_state() is invoked so that this graceful failure path is
reachable?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019ea3929225-a0=
f8e6f7-30ae-4f8e-ae6f-19129666c4c3-000000@email.amazonses.com?part=3D6
