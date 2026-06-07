Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B9515746F
	for <linux-cxl@vger.kernel.org>; Sun,  7 Jun 2026 07:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780816406; cv=none; b=BG/y/Yl2lM2EQtTaBsYMcC/8HkXRQb/CoRQ+xSRABi/BhWKZAva+RsmEdXvXBy8fxAs3UUDRXyRi9UznMYy+3e9aQweWJGxYhDTJmoJI8Jt/1W9vNohJtcDblhoeZKk4+CeJEv4XhE2ux+YeoUZXXCXf2H4WMz6Kv+NwVg7+kks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780816406; c=relaxed/simple;
	bh=gKgZ5k/pDeo1wKTOP+n1PofgSw0D4i2tDL2RvD4iBa4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pTb7lZDOx4lNYzX30sgWCRdXnwqnnS3L/gT42ikJLaPChl8eTH0/OIPNrUaImL9o6t7ByIao55fbaA/TOudNq9qEyEAVmauPr5jallOAn5pCjZGZygmYMDtXDDGVz2pFh3TIzMVST28O9jkLqxk80IfWRks7QdOfKAl4PiF2dlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iItcmrdo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iItcmrdo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE021F00893;
	Sun,  7 Jun 2026 07:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780816404;
	bh=6OQThBGtAKce0VPBShvA0hTlpHD2A6wjHAT/HUZtCCI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iItcmrdo1psZq7EGpd1rY0BM7PZoQICQloNQaAwUit/ca1B+oVJ2xpCF7dl0AlDcY
	 mtS8quJwmZT31nzGOZaZ4wzRdOYGpA2B2d0Z98o0J+AQKiQSvs1ci61tR5urBly3mE
	 mCk4uH9cdZhxwhmR2/K5z+0olgOn22nz2Jw+ObzvM6Ltvo3q5PD9W1go0n6/zUchkB
	 aWIGGBFn6A8ckcUO6DUnwa2F65QXkKKw7FPUBsD+4mNmHpL7DLlULKaplMkovIZmVJ
	 nNCP1R0+3V6KXHldfosd3hxduwmKm8UNT0uV6rJY+zstkx53QyfYqyJT5uzPw5TEEk
	 D1UAjp8E1NRvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] cxl/core/regs: Check return value of DVSEC register
 locator reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260607070241.48978-3-icheng@nvidia.com>
References: <20260607070241.48978-3-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 07:13:24 +0000
Message-Id: <20260607071324.8EE021F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added early returns on `pci_read_config_dword()` failure=
s leak intermediate register block state in the `map` output parameter. If =
a previous loop iteration successfully decoded a non-matching block, that s=
tate is retained and erroneously consumed by callers that ignore the return=
 value.
--

commit 33d355daa1f588d8fa2e0001a3651a368f36be29
Author: Richard Cheng <icheng@nvidia.com>

cxl/core/regs: Check return value of DVSEC register locator reads

This commit checks the return value of pci_read_config_dword() when
reading the CXL Register Locator DVSEC. On failure, it converts the
PCIBIOS status to a negative errno to avoid decoding register block
addresses from garbage data.

> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
[ ... ]
> @@ -324,8 +326,12 @@ static int __cxl_find_regblock_instance(struct pci_d=
ev *pdev, enum cxl_regloc_ty
>  	for (i =3D 0; i < regblocks; i++, regloc +=3D 8) {
>  		u32 reg_lo, reg_hi;
> =20
> -		pci_read_config_dword(pdev, regloc, &reg_lo);
> -		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
> +		rc =3D pci_read_config_dword(pdev, regloc, &reg_lo);
> +		if (rc)
> +			return pcibios_err_to_errno(rc);

[Severity: High]
Does this early return leave map->resource populated with stale data?

If a previous loop iteration successfully decoded a non-matching block
(such as CXL_REGLOC_RBI_MEMDEV), map->resource and map->reg_type will
be populated. If a subsequent config read fails, returning early bypasses
the map->resource =3D CXL_RESOURCE_NONE cleanup at the end of the function.

Callers like find_component_registers() in drivers/cxl/core/port.c ignore
the return value of cxl_find_regblock() and blindly consume map.resource.
Will this cause the caller to erroneously map the wrong registers (like
the memdev registers) as component registers?

> +		rc =3D pci_read_config_dword(pdev, regloc + 4, &reg_hi);
> +		if (rc)
> +			return pcibios_err_to_errno(rc);
> =20
>  		if (!cxl_decode_regblock(pdev, reg_lo, reg_hi, map))
>  			continue;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607070241.4897=
8-1-icheng@nvidia.com?part=3D2
