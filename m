Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8AB4071CA
	for <linux-cxl@vger.kernel.org>; Sun,  7 Jun 2026 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780861494; cv=none; b=QdYmukI63nGSqXgiLbvc6HWC/OII0EslKMTWXPXY0MJ2JmDhAlTB50sZ1KZ7WwiUp0K1rHyvJ4y74V/ginMQMMqiFYrObd53ObsHyf7CWlQybVJXdsHpIBA+7HsuBp8IaI2prF+rOQT68si70gZ3reTedcWqx0kg/L4oqOZOSOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780861494; c=relaxed/simple;
	bh=Fptr++djseQYnfZQr0tTyZ5BTSlmZ6Aw/M2wHj7s+cQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gn70bv0vayrvpwbjEbBTnQdTriujnUaG7p7MkCSSqIPOIaIvvgHiEHzweJWxXNM6+reGhf+kBdrvWFq2fBX74sBAhRsdBQhwobxW0HTY+38cVahSqQeJMsf0OHMCW2Is9bVw7UE7v7ThPg6tbPgCNqKFj5K8tLVMgt1dnD2tECE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhCcpYPq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhCcpYPq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29941F00893;
	Sun,  7 Jun 2026 19:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780861492;
	bh=GMCN4eAmAN3SIy2TBnCUxDTDklx34cJfxNFhEO9K3vw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YhCcpYPq+iP4mco5iKV3XgbwCeyXPLGHLzkIw0P6wKLVZRlFlS4foKr9v8mbWIScF
	 tdTXR5/0pOcmwS0APOlXTHkwtHOletXcc19V7brch8wr4Bk35l2c/C7Uq8FJL6PChs
	 7R9TTsUhl7QSRT14D6TOcqoe0Bnurml91AsqmTxPb9WiLjvO3eMgMW2rgYuVN/OPd9
	 eO25LW1iZqWxKMA+yOfbYiVQdjXyD1gUs/LoNn9XD2GK1P7KitsHxM4ojbknmUH0vS
	 i2PxHFVD6tlnkabueQO9C/vKiSYElp2MyCar3eINgfdow0D2bHpKlEBzcGHZxMcrO3
	 oFj8jnNSdjgRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 5/9] dax/fsdev: use __va(phys) for kaddr in
 direct_access
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019ea393c83d-bf39998e-bd40-4c7b-8f84-a60c26d2efa6-000000@email.amazonses.com>
References: <0100019ea393c83d-bf39998e-bd40-4c7b-8f84-a60c26d2efa6-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 19:44:52 +0000
Message-Id: <20260607194452.B29941F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `__fsdev_dax_direct_access()` returns `-EFAULT` instead of truncat=
ing the returned size when a request crosses a multi-range physical boundar=
y.
--

commit 25e7e6c7d5f413efd9eb57096b8df2c8803d235a
Author: John Groves <John@Groves.net>

dax/fsdev: use __va(phys) for kaddr in direct_access

This commit updates __fsdev_dax_direct_access() to use __va(phys) for the
kaddr return, fixing an issue where multi-range devices with physical gaps
resulted in an incorrect kernel virtual address. It also removes the now
unused virt_addr field from struct dev_dax.

> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> index 0fd5e1293d725..af9ef80c05c6d 100644
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c
> @@ -51,9 +51,7 @@ static long __fsdev_dax_direct_access(struct dax_device=
 *dax_dev, pgoff_t pgoff,
>  	struct dev_dax *dev_dax =3D dax_get_private(dax_dev);
>  	size_t size =3D nr_pages << PAGE_SHIFT;
>  	size_t offset =3D pgoff << PAGE_SHIFT;
> -	void *virt_addr =3D dev_dax->virt_addr + offset;
>  	phys_addr_t phys;
> -	unsigned long local_pfn;
> =20
>  	phys =3D dax_pgoff_to_phys(dev_dax, pgoff, size);
>  	if (phys =3D=3D -1) {

[Severity: High]
This isn't a bug introduced by this patch, but it appears to be a pre-exist=
ing
issue. If a direct_access request spans across a physical gap into the next
DAX range, dax_pgoff_to_phys() returns -1 because it checks if the entire
requested size fits within a single contiguous physical range.

This causes __fsdev_dax_direct_access() to fail the entire operation with
-EFAULT. Should it instead truncate the returned size to the boundary of the
available contiguous length, allowing the caller to safely issue subsequent
requests for the remainder of the pages? Failing completely with -EFAULT
might spuriously break valid I/O accesses on multi-range DAX devices.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019ea3929225-a0=
f8e6f7-30ae-4f8e-ae6f-19129666c4c3-000000@email.amazonses.com?part=3D5
