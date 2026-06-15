Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C69B40B36E
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jun 2026 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540552; cv=none; b=m6j/dnhYYhXhUv5DUF+J8hllSLaoxJxsSM77SN+45KBIHjIoVifAXyw2aMK26CMjbfsWISSoW6StpSz5NUrbKhew3Z/MQki9ZeFv3p7DWSDtyjaitGCbE+mTOzenbTl6vxMP0BllFC9175MAoh+krZk/gzBkSmVtDJ7TiIfZbGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540552; c=relaxed/simple;
	bh=Tti0QoFn0uAn17yqwCIlksdusiJ1bXCa7YiDO1qhuZs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qbGBcKi4/Ovizw+4120CUVPmsTJpy9N8SZ8U0okvAwSK7P6IYqqq/p4hoSYS7b+f9Q5n0WT8IbTjmmkB/E26TE01Td9k4aEbpL3kG3G9QVUIjKODupqYyUwh9zYtLkroSV2uVoWug2j/9Og1nScFzXen5bIa4o35GEbeutEuIOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPm9c5nB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPm9c5nB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18F01F000E9;
	Mon, 15 Jun 2026 16:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781540551;
	bh=PGfo7RNd1w00NTrCxdZpNo3++pcVh0szu5o44LDACgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fPm9c5nBt20eBMIWJFRL2GTIS273bCbz+FE+66dy1PxcvLEN70wmZ8JhgqmZApYTm
	 ck3Ao7qYxerrUw9ykQL79+JLJXZ1osKCEXwo5sdsLMmtOWlYp5xBYKVO2YAYcPYW8G
	 DUocl+Vx98NAu+iz48GWexkTd2Z11ApEA/JMRLMzTJ4NoJgz1drdEYw8fG1feUhXT2
	 15K4ZKxyON5d0AJgjDz/nbJNBLa6CIMh1uKo7oP23DsQ6ACYrflhkRWr0mSD35MNDc
	 oXcquTvI9ZBMhVKYQU33yDc21jj0sqy8bhVztFpYloacI99v3hvw/ORvWLytzbEJkQ
	 t8OHwg0l/Glpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V6 05/10] dax/fsdev: clear pgmap ops and owner on unbind
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019ecc094b6e-fc163bde-0396-4a33-909f-fb88e740be27-000000@email.amazonses.com>
References: <0100019ecc094b6e-fc163bde-0396-4a33-909f-fb88e740be27-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 16:22:30 +0000
Message-Id: <20260615162230.F18F01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Incorrect devres registration order leaves an error path unprotect=
ed and introduces a concurrent NULL pointer dereference during unbind.

Pre-existing issues:
- [High] Prematurely clearing folio state on unbind can corrupt memory for =
concurrent users.
--

commit 7c895b5292c660c81442978247753fce9d42653f
Author: John Groves <John@Groves.net>
Subject: dax/fsdev: clear pgmap ops and owner on unbind

This commit registers a devm action to clear pgmap->ops and pgmap->owner
on unbind. This prevents stale handlers from being executed if the static
device is later rebound to another driver or if the module is unloaded.

> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> index 0fd5e1293d725..68a4369562f70 100644
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c

[ ... ]

> @@ -306,6 +323,11 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
>  	if (IS_ERR(addr))
>  		return PTR_ERR(addr);
> =20
> +	/* Drop fsdev's pgmap->ops/owner on unbind so no stale ops survive. */
> +	rc =3D devm_add_action_or_reset(dev, fsdev_clear_pgmap_ops, pgmap);
> +	if (rc)
> +		return rc;
> +

[Severity: High]
Does registering this action after devm_memremap_pages() cause an issue with
the devres LIFO unbind order?

Since devres unwinds in reverse order, fsdev_clear_pgmap_ops() will run
before the memory is unmapped by the devm_memremap_pages() release action.
This means pgmap->ops and pgmap->owner are set to NULL while the memory map
is still active and its per-CPU refcount is alive.

If a hardware error occurs concurrently during unbind, could memory_failure=
()
evaluate pgmap_has_memory_failure() as true, but then dereference a newly
NULL pgmap->ops?

mm/memory-failure.c:memory_failure_dev_pagemap() {
    ...
    if (pgmap_has_memory_failure(pgmap)) {
        rc =3D pgmap->ops->memory_failure(pgmap, pfn, 1, flags);
    ...
}

Similarly, could fsdev_pagemap_memory_failure() dereference a NULL dev_dax
pointer since the owner was cleared early?

Also, if devm_memremap_pages() returns an error, the function returns early
before this devm action is registered. Will the shared static pgmap retain
the stale ops and owner pointers on this error path?

Would moving this registration before devm_memremap_pages() fix both issues?

>  	/*
>  	 * Clear any stale compound folio state left over from a previous
>  	 * driver (e.g., device_dax with vmemmap_shift). Also register this
>  	 * as a devm action so folio state is cleared on unbind, ensuring
>  	 * clean pages for subsequent drivers (e.g., kmem for system-ram).
>  	 */
>  	fsdev_clear_folio_state(dev_dax);
>  	rc =3D devm_add_action_or_reset(dev, fsdev_clear_folio_state_action,
>  				      dev_dax);

[Severity: High]
This isn't a bug introduced by this patch, but does the preexisting
fsdev_clear_folio_state_action registration suffer from the same LIFO
devres ordering issue?

Because it is registered after devm_memremap_pages(), this action will
also execute before the active page map references drop during unbind.

Since fsdev_clear_folio_state() calls dax_folio_reset_order() to zero out
folio->mapping and folio->share, could this corrupt memory if threads are
performing direct I/O pins (e.g., via get_user_pages) and actively hold
valid references to these pages as compound folios?

Modifying folio metadata while the pages are actively pinned could lead to
refcount imbalances when concurrent users eventually unpin the folios.

Should this action also be moved before devm_memremap_pages()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019ecc080a68-8d=
c0c99f-ab17-4aa9-83d9-490e9c97ac2e-000000@email.amazonses.com?part=3D5
