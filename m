Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B9B342CA7
	for <linux-cxl@vger.kernel.org>; Sat, 30 May 2026 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163300; cv=none; b=fYXBR4ssmpeJo0IUrdNVJpChwlzs/PZQcKtrU69H7Iw/iOKiLJlx/F1FYQEGDAEilGeIzlNYi4E9uWSV7aTbct+9Km7qT0UWfQXsxbebx/QmdV3S/Qr8jFXXrtnV2D10PRAm1wkjLEfXItGzA41Jirp3jNCZjGMjTuJc09M5kuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163300; c=relaxed/simple;
	bh=FTr6OIxCci65gDfl+IG3TsHpoyHzKFZLzvb8jOyZ7yE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Od7HUL+gBchh+umPkh2QYiNNWka0vHU/sxXDXxygR0dJigFe2A+HSlM1MqzUAlW14Mp8UHz+7JqikdVGvrlc+5MU15HZvS40MXCKtOgteYUYdKEUOg/cEkqkxjpV77fUikA+koUmOznleWRSybihRHr8cXYGD52xXeMT/o/Fso4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijZ8OJa5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijZ8OJa5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397561F00898;
	Sat, 30 May 2026 17:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780163299;
	bh=2jrZKmfHCJTxAXzal+rnXLKNCo4h+Ckrr5JFYEibNCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ijZ8OJa5JqQCFSMwu7R63GTdz6HkMlPMAv/xB5Ude953VAa/omiMi8PWI1aUNx6uG
	 xX0XMhS36U6tPxCQP3mifVd3LGxVFmkJZAJA7Pp0HLtWm4REPeIDKv697HEMq4yeEW
	 43eGSHS2ywP9xKFjk7Eh38qVKpaEsZsf+IPwshoJRS7W/ms/sd2CT49NE+Ze0Yv6NS
	 qzmIVwJRs1Wgbsjh8Rd4Rvvc8e34ppjheltEAYHJ1d2UGhCwlTgIbaZ8NoL6215ZEj
	 NlGnu2dtsNNmhSxt2nTqX1pTgv1octsU3tRzOnlkfTerq00k5EL3MOSprJFFljE/7q
	 k7cXXqC1wtByQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 5/9] dax/fsdev: use __va(phys) for kaddr in
 direct_access
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019e79cbe087-d11f77a7-379f-4355-b65c-52b3090e9ddd-000000@email.amazonses.com>
References: <0100019e79cbe087-d11f77a7-379f-4355-b65c-52b3090e9ddd-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 17:48:18 +0000
Message-Id: <20260530174819.397561F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The patch leaves behind dead code for calculating `data_offset` and=
 assigning `dev_dax->virt_addr` in `fsdev_dax_probe()`.

Pre-existing issues:
- [High] `__fsdev_dax_direct_access()` returns `-EFAULT` when the requested=
 `size` crosses a physical range boundary, instead of truncating the return=
 value to the available contiguous pages.
--

commit b771878942b230ec4df1330dccd98b1983cf30b8
Author: John Groves <John@Groves.net>

dax/fsdev: use __va(phys) for kaddr in direct_access

This commit fixes the kernel virtual address calculation in
__fsdev_dax_direct_access() by using __va(phys) instead of a linear
offset from virt_addr. This ensures correct behavior for multi-range
devices with physical gaps.

> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> index 42aac7e952516..a2d2eb20fb4d0 100644
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c
> @@ -51,9 +51,7 @@ static long __fsdev_dax_direct_access(struct dax_device=
 *dax_dev, pgoff_t pgoff,
>  	struct dev_dax *dev_dax =3D dax_get_private(dax_dev);
>  	size_t size =3D nr_pages << PAGE_SHIFT;
>  	size_t offset =3D pgoff << PAGE_SHIFT;
> -	void *virt_addr =3D dev_dax->virt_addr + offset;

[Severity: Low]
By removing this calculation, is virt_addr now entirely unused?

Looking at the rest of the driver, dev_dax->virt_addr doesn't appear to be
read anywhere else. Should the virt_addr field in struct dev_dax and its
assignment in fsdev_dax_probe() be removed to clean up the dead code?

>  	phys_addr_t phys;
> -	unsigned long local_pfn;
> =20
>  	phys =3D dax_pgoff_to_phys(dev_dax, pgoff, size);
>  	if (phys =3D=3D -1) {
>  		dev_dbg(&dev_dax->dev,
>  			"pgoff (%#lx) out of range\n", pgoff);
>  		return -EFAULT;
>  	}

[Severity: High]
This is a pre-existing issue, but does returning -EFAULT here break the
direct_access API contract when a request crosses a physical range boundary?

If the requested size extends beyond the current physical range on a
multi-range device, dax_pgoff_to_phys() returns -1, causing this to fail
entirely. Should this instead truncate the return value to the available
physically contiguous pages rather than failing the whole transfer?

Additionally, the fallback size calculation later in this function:

return PHYS_PFN(min(size, dev_dax->cached_size - offset));

seems to incorrectly assume physical contiguity across range gaps.

> =20
>  	if (kaddr)
> -		*kaddr =3D virt_addr;
> +		*kaddr =3D __va(phys);
> =20
> -	local_pfn =3D PHYS_PFN(phys);
>  	if (pfn)
> -		*pfn =3D local_pfn;
> +		*pfn =3D PHYS_PFN(phys);
> =20
>  	/*
>  	 * Use cached_size which was computed at probe time. The size cannot

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019e79caead2-57=
95328c-af48-4a93-b147-c11df7446e1a-000000@email.amazonses.com?part=3D5
