Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D15344DA4
	for <linux-cxl@vger.kernel.org>; Sat, 30 May 2026 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162115; cv=none; b=CPX++wT+0IEHfcJDzu+2Cxtc8AMxgUiaHWrtwsA+QtEwbWmcUPEiuQDY3bCjkHjDw/lmKHDI55Xw29Z3kKOvuGuVRYx3tmGlNJWtlsGhJ08Svm3+rFj+5rt/m9/EqjSR6VqHq8+jhczjvP7rCqOloJE49NVEYAbv+R3WUcmN/Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162115; c=relaxed/simple;
	bh=G1vtTMj2CR/NpJ/JHfNLJtBm4B4FAWEuhM9ssegjTwk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EqKS9qlLvY5NZm3B8Wf1WNm6phYtSOxm4soTNJBaIEFXgThQ71mBGR6MKFecTZj+RQRyjdMtOKh5dXSviieYqLxrXUnyPf+VChtTvXGfdVbbCnW3rwk5uzmmSYuqN1SYt2bZg8R357qFOBZgRMb8rd17W3ZmwptXwtAZC/nwMgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXaGOZkO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXaGOZkO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393DF1F00898;
	Sat, 30 May 2026 17:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780162113;
	bh=KKHkB9lrl33mvPh+y7r2DWDEuiW2saUIl8H+1WyXlwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hXaGOZkOa1mNz5GksYPHZ5gyQc9HsrBZbz9ATSKocsMIF/uGNDJnv3Z4Edeip4BTg
	 NBST1nIv9DOV4bvRwyfPDTTaywFIzMG+bpHEiOp8/yDNMR3rQjs/Jy3XPmu9VWBk7Y
	 5BSOBcb9Y5/NmEnQsCj9kB0kBPFxSfNxn5W62r3CfEg8v3GRazrg4usT5Wc5lIJsTc
	 KI5OkdAcgvfWDu8LPwMtOnR0VP4k8XpzUo7GEjcWvQ5iRIpPlv2C0OoHpXxqW9h2yE
	 FtN7rPURyjLxrFNKu2PtLb8x5ezbbswcULuEFh9AHDcXxa8tkqXLvyWbUODFp4aHiT
	 2xWwfFWV8tqxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 3/9] dax/fsdev: clear vmemmap_shift when binding
 static pgmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019e79cba76d-76fe26ff-33d2-4842-8eee-bd108eae6990-000000@email.amazonses.com>
References: <0100019e79cba76d-76fe26ff-33d2-4842-8eee-bd108eae6990-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 17:28:32 +0000
Message-Id: <20260530172833.393DF1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Dangling pointer vulnerability (Use-After-Free) in pgmap->ops =
on driver unbind
- [Critical] Invalid Virtual Address Calculation for disjoint DAX ranges ca=
using data corruption
- [High] Probe failure leaves dangling dev_dax->pgmap preventing device reb=
inding
--

commit fd314d6aab8b188d638ba9782dcab88646401f10
Author: John Groves <John@Groves.net>

dax/fsdev: clear vmemmap_shift when binding static pgmap

This commit clears pgmap->vmemmap_shift for static DAX devices before
calling devm_memremap_pages(). This ensures the vmemmap is built for order-0
folios as required by fsdev, explicitly zeroing any stale state left over
from a previous device_dax binding.

> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> index f315533b299e9..dbd722ed7ab05 100644
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c
[ ... ]
> @@ -237,6 +237,7 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
>  		}
> =20
>  		pgmap =3D dev_dax->pgmap;
> +		pgmap->vmemmap_shift =3D 0;
>  	} else {
>  		size_t pgmap_size;
>=20
> 		if (dev_dax->pgmap) {
> 			dev_warn(dev, "dynamic-dax with pre-populated page map\n");
> 			return -EINVAL;
> 		}
>=20
> 		pgmap_size =3D struct_size(pgmap, ranges, dev_dax->nr_range - 1);
> 		pgmap =3D devm_kzalloc(dev, pgmap_size, GFP_KERNEL);
> 		if (!pgmap)
> 			return -ENOMEM;
>=20
> 		pgmap->nr_range =3D dev_dax->nr_range;
> 		dev_dax->pgmap =3D pgmap;

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential
dangling pointer if the probe fails later.

In fsdev_dax_probe(), dev_dax->pgmap is assigned the devm_kzalloc'd pgmap.
If a subsequent probe step fails:

fsdev_dax_probe()
    dev_dax->pgmap =3D pgmap;
    ...
    addr =3D devm_memremap_pages(dev, pgmap);
    if (IS_ERR(addr))
        return PTR_ERR(addr);

The devm framework will free the pgmap memory upon returning the error, but
dev_dax->pgmap is never reset to NULL.

Subsequent attempts to re-bind the driver will see dev_dax->pgmap !=3D NULL
and fail permanently with -EINVAL, erroneously claiming a pre-populated
page map.

Does this need a cleanup action to clear dev_dax->pgmap on failure?

Note that this was fixed later in the series by "dax/fsdev: clear
dev_dax->pgmap on probe failure".

[ ... ]
> 	pgmap->type =3D MEMORY_DEVICE_FS_DAX;
> 	pgmap->ops =3D &fsdev_pagemap_ops;
> 	pgmap->owner =3D dev_dax;
>=20
> 	addr =3D devm_memremap_pages(dev, pgmap);
> 	if (IS_ERR(addr))
> 		return PTR_ERR(addr);

[Severity: Critical]
This is a pre-existing issue, but I am concerned about a dangling pointer
vulnerability on driver unbind.

When binding static DAX devices, fsdev_dax_probe() assigns the module-local
&fsdev_pagemap_ops to pgmap->ops and dev_dax to pgmap->owner.

However, there appears to be no corresponding cleanup action in fsdev_kill()
or fsdev_clear_ops() to clear these fields when the driver is unbound.

If the static device is subsequently bound to device_dax (which reuses the
same pgmap but does not overwrite pgmap->ops), and the dax_fsdev module is
unloaded, pgmap->ops becomes a dangling pointer to freed module memory.

Could a hardware memory failure in the mapped DAX range then trigger
memory_failure_dev_pagemap(), dereferencing the stale
pgmap->ops->memory_failure pointer and causing a kernel panic?

[ ... ]
> 	if (kaddr)
> 		*kaddr =3D dev_dax->virt_addr + offset;

[Severity: Critical]
This is a pre-existing issue, but the virtual address computation here
seems to assume a contiguous virtual memory layout.

For dynamic DAX devices spanning multiple physically disjoint ranges,
__fsdev_dax_direct_access() calculates the kernel virtual address using
linear arithmetic:

    void *virt_addr =3D dev_dax->virt_addr + offset;

Because virt_addr maps directly over physical memory via __va(), wouldn't
a physical gap between ranges cause the linearly calculated virt_addr to
point into the unmapped gap rather than the correctly mapped subsequent
physical memory?

Does this return an invalid pointer for offsets beyond the first range,
leading to data corruption when callers read or write memory?

Note that this was fixed later in the series by "dax/fsdev: use __va(phys)
for kaddr in direct_access".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019e79caead2-57=
95328c-af48-4a93-b147-c11df7446e1a-000000@email.amazonses.com?part=3D3
