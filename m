Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE8244A739
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200545; cv=none; b=PXvydSBgMep8E/ebQOTWpUB27dAc3MgNLzLzD0bKpnwjC/2mY9f0ub1kYm8B1IXI2VuL+YWVepX4mdPgq54UpXWpJuBetMElHbAZWVvrSJoC+l4zkr82CAT9/M9WNrbZZkE9zynPIIMIpW1wWrOQfRVKNVhA5U+URqtElSfkgyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200545; c=relaxed/simple;
	bh=00M5Q9nOMOBhJn6s/jbTI5OOILt5wnroWrVX21PAU88=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UDxP6WWFybKBGkxc7drWuYhx30Kff9PiwqTlWWK4VMmBQo20wAYO4Rm+mC1KD01/UVZlxTXdAQBObInq0Mq0OuINdn1rvFKBGvGTxQVAOZo28TS9+fe7V/p4474PiUHWFB7Aq95ZJGkAL+yZnAGbdcjD/Is5glMINJbzECFZBHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4jK7hAs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4jK7hAs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A811F00893;
	Thu, 11 Jun 2026 17:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200542;
	bh=aya6xK9sPOoGdMpf5T3WYzfvY8qlzoNv0jVLr3533N4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P4jK7hAsGSPKpDyp8ryiv8gQEbYHbdXOc7igRgcjmvBgCoA1f3WgEYHKM+/slTMR9
	 0dbGpXKEqSL3+a4XomoVHCrkiP/hBOyDrsc4yFzkJIsyxBwItbZb13xGA4GS+qtWih
	 sVLOxL1M2nlEsgyQJYiSYZVn0m6GiRyF3H8F5reAR14oKOQogkZmqJYZsD9niL/bwS
	 eWXjzoE8cpYZ87fZrj5v7GDlTjuCgnlruqU4rcfgwttbJr6y0UEJGBsa52cVjUo5Hn
	 2rPwyzg6zEbVJ3X4JQ9xBNcV/sk9AH+seFDDUfpuFiSXV85m6+7PZrlVPC0YMUPacH
	 SssqTxOSAgEyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 3/9] dax/fsdev: clear vmemmap_shift when binding
 static pgmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019eb7bdc5a7-f15b011c-0aee-411f-8d7c-2996345048e4-000000@email.amazonses.com>
References: <0100019eb7bdc5a7-f15b011c-0aee-411f-8d7c-2996345048e4-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:55:41 +0000
Message-Id: <20260611175542.10A811F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Rebinding a static DAX device from fsdev_dax to device_dax (or unl=
oading the fsdev_dax module) leaves a dangling `pgmap->ops` pointer on the =
persistent static `pgmap` structure, risking a use-after-free on hardware m=
emory failure.

Pre-existing issues:
- [High] Probe functions in fsdev_dax re-initialize an embedded cdev via `c=
dev_init()`, clobbering its kobject state if there are open file descriptor=
s from a previous bind.
--

commit cfa8354a7e331532bf1a69e2ea2e854ab1b90742
Author: John Groves <John@Groves.net>

dax/fsdev: clear vmemmap_shift when binding static pgmap

Clear pgmap->vmemmap_shift for static DAX devices. When rebinding a
static device from device_dax to fsdev_dax, the stale vmemmap_shift
persists on the shared pgmap. Explicitly zero it before
devm_memremap_pages() so the vmemmap is built for order-0 folios.

> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> index 2c5de3d80a618..52f46b3e245ea 100644
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c
> @@ -237,6 +237,7 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
>  		}
> =20
>  		pgmap =3D dev_dax->pgmap;
> +		pgmap->vmemmap_shift =3D 0;

[Severity: High]
Since we are fixing the stale vmemmap_shift on the shared pgmap here, do we
also need to handle the pgmap->ops pointer?

If fsdev_dax unbinds or the module is unloaded, it doesn't appear that we
clear pgmap->ops, which is set to &fsdev_pagemap_ops later in
fsdev_dax_probe(). Additionally, if device_dax is bound to the same device
instead, it appears to update pgmap->type but leave pgmap->ops unchanged.

If a hardware memory error occurs on the region after unbind, will
memory_failure_dev_pagemap() attempt to call the dangling
pgmap->ops->memory_failure pointer:

mm/memory-failure.c:memory_failure_dev_pagemap()
    if (pgmap->ops && pgmap->ops->memory_failure) {
        rc =3D pgmap->ops->memory_failure(pgmap, pfn, 1, flags);

and cause a use-after-free or panic?

[Severity: High]
This isn't a bug introduced by this patch, but does the embedded cdev
initialization in this probe function clobber the kobject state?

If there are open file descriptors from a previous bind, and
fsdev_dax_probe() re-initializes the embedded cdev later in the function:

drivers/dax/fsdev.c:fsdev_dax_probe()
    cdev_init(cdev, &fsdev_fops);

will cdev_init() destroy the active kobject's refcount and zero out the
cdev->list? Could this cause list corruption when the stale file descriptors
are later closed, or mismatched kobject refcounting that frees the cdev
while the new driver instance is using it?

>  	} else {
>  		size_t pgmap_size;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019eb7bcda4b-3f=
8edae9-d7a4-4bfa-aaea-fcef77fdbbc3-000000@email.amazonses.com?part=3D3
