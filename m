Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B941479862
	for <linux-cxl@vger.kernel.org>; Tue, 29 Sep 2026 03:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651802; cv=none; b=LC868Dbv3jZYFqUgW8EcN7DrMqYh6WMzVhl3mzenCoK2WyTWwiXo+ANWu7B+faXLq13WdL2tuh7XVohE1i5GP6Bz/fgjLWgNklapScoP1qhfdXvYt45nllZk97RpdOHjCKhE10ngwCGqI2pjFcTZO6FenhHMGC0Qfb2MEw/NdYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651802; c=relaxed/simple;
	bh=OknCHU6UdIkhwcBewfqgCDylB6sGic1DLxPh9Xau0+Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g+ZFpreSjvIn5fXA1QkgvTGGCW7/sJ+aknFhOAMenfi+hPP1/3I7AAtPRWDYlqGwPf7el8JpsT/pGd5s0oOpqIIyPY+EmZ1pBRbYdONmDlOz3K6DRKSQldVu10n1C5u85BDVcuWqPWXjFjgytNtJlbqvpvt08mnXnCUC04oKZA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+szm3IU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+szm3IU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DF71F008A0;
	Tue, 29 Sep 2026 03:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790651793;
	bh=/qrDDKeptV4KzFtMft+PkA/mOA3SzEy7UO8b7qBN7Ls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O+szm3IU2LfXuyNDg6UqBaxRUqa5A21AIfx6oONVNdK5NDPRDdazUk/cSXlYox6kG
	 a8FvMq6HeXWf6FYQCSvB1EYNY5o7ii5iv9C7IdZKjbXHCVrgmXvbE7B/ms6uCUQoMx
	 4Fgy+c4zGxsOu8Q7+gYu+R8XWcxBp8pSFCdt0aat9hAuiiRbwLp1nX+blXugIqIAXK
	 v/DIWZVY4VyXleoixQECAzWOEB+1fBwFoMz8IMOd+xCgmErMxsUQ4re0BJj9meDi20
	 Qkx+SL0qOXGAlwRHI7oO6cy1a00sRekAC9By+/qFSa/UuDGVO5l6y+qVxofjVIxpq+
	 1t7EyfU8tdbyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] cxl/mem: Fix no cxl_nvd during pmem region
 auto-assembling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Artem Dinaburg" <artem@trailofbits.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260929030716.86736-1-artem@trailofbits.com>
References: <20260929030716.86736-1-artem@trailofbits.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 03:16:32 +0000
Message-Id: <20260929031633.38DF71F008A0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cxl: fatal probe failure when PMEM is disabled by platform
--

commit 3836a307f91efffcbe3c18ffddeb397cd4ef78b8
Author: Li Ming <ming4.li@intel.com>

cxl/mem: Fix no cxl_nvd during pmem region auto-assembling

When the CXL subsystem is auto-assembling a pmem region during cxl endpoint
port probing, it can hit a null pointer dereference. The cxl_nvd of the
memdev needs to be available during the pmem region probe, so this patch
adjusts the sequence to register the nvdimm bridge earlier.

Link: https://patch.msgid.link/20240612064423.2567625-1-ming4.li@intel.com

> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 317c7548e4e9b..3400d2f2a5ff9 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -153,6 +153,16 @@ static int cxl_mem_probe(struct device *dev)
>  		return -ENXIO;
>  	}
> =20
> +	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
> +		rc =3D devm_cxl_add_nvdimm(parent_port, cxlmd);
> +		if (rc) {
> +			if (rc =3D=3D -ENODEV)
> +				dev_info(dev, "PMEM disabled by platform\n");
> +			put_device(&parent_port->dev);
> +			return rc;

[Severity: High]
Can returning an error here inadvertently cause a fatal probe failure when
the platform disables PMEM?

If a CXL memory expander has a PMEM region but the platform lacks an NVDIMM
bridge, devm_cxl_add_nvdimm() correctly returns -ENODEV.

The new code catches this and logs "PMEM disabled by platform", but then
it unconditionally returns rc. Returning an error here fails the entire
cxl_mem driver probe, meaning the device is rejected and its endpoint is
never registered.

This renders the device completely unusable, blocking access to both its
persistent and volatile memory. The old code correctly swallowed the -ENODEV
error to allow continued probing.

> +		}
> +	}
> +
>  	if (dport->rch)
>  		endpoint_parent =3D parent_port->uport_dev;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929030716.8673=
6-1-artem@trailofbits.com?part=3D1
