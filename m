Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13A82FD1B3
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784754611; cv=none; b=K1wkQVNeT2XdXDCpVhvrWXlKjBDzaLXlKyGsx9u0VqCr4x/P3BAE+7RvsKi8VbHPwgVyOnnkPQQrjKYnIb60pK48uf9YuFuwwT/uY/i8C3IMqNYuxOLe+vCaZ5R9eKIe79JmCELu9P7Gev00HM27C4EBfBRnJPrM40fegIEkjfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784754611; c=relaxed/simple;
	bh=kMWqO2vlWwKxmmCeFR4sxQo9LTrO8Icwmc6sSR0HN04=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ags239n+F9iq3JIqTc36aYipT14C0d2WDlb5jRvK2o906BWueNt4s1IBN03SbGAmk9g5iFWNz1y3BwDpj63Wtf2kJ9SgenjOVtJKj7KBO2cb2ZMarshnMRFpanNkfJ2HBS4Pwli7z9rBn4fJg6jd2HuuSNVNrJxHL1AS1DXhaow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+O6Pobi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+O6Pobi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388D81F000E9;
	Wed, 22 Jul 2026 21:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784754610;
	bh=Nd0XvRfD/8WnnDLPiB2UjK7E2yTo3+dGfmMsoxtJYg0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I+O6PobigzcL0Na9wlpLuvdFkHbKNb1UaVWmg89t850AnTGPLYDhsI/griZrCxnYp
	 W9lcuF363cy0XoTeYeBF2agmGYCQxnrWeYcjj5zjn1KK5uB/zx0UvtrmujNezBjv1E
	 8u7DUliroS+vH2ioxrqtCuiRuQDUJ1eeOUdpb5bCypu49U94Y+odz2WA7LqMWR948+
	 qBCifNTYsvxWPOKlUZ3Pnbl0mDSUPTSpWdU5S31/ORzSG1D3G8da0uKq1VuL1FbgD0
	 rbrHNYIQ5KwvRyc/eTNPKcU2e+tuTz7JlC2hdm0AmCW5djepRVvwvf05Iflyx9nQLA
	 wU/U01ICADJpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] cxl/ras: Clear software-only TLP log fields after
 RCH AER copy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260722205303.3184787-3-dave.jiang@intel.com>
References: <20260722205303.3184787-1-dave.jiang@intel.com>
 <20260722205303.3184787-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 21:10:09 +0000
Message-Id: <20260722211010.388D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] cxl_rch_get_aer_info() and cxl_dport_map_rch_aer() use sizeof(stru=
ct aer_capability_regs) (bloated to 100 bytes) for MMIO mapping and reading=
, causing a 44-byte out-of-bounds MMIO read past the actual hardware AER ca=
pability.
- [High] ghes_handle_aer() suffers from a 4-byte out-of-bounds memory read =
when copying firmware-provided CPER records due to the expanded struct aer_=
capability_regs.
- [High] The out-of-bounds array read vulnerability fixed in CXL is left co=
mpletely unpatched in ACPI GHES and EXTLOG drivers, which also pass uniniti=
alized firmware metadata to pcie_print_tlp_log().
--

--- Patch [2]: [PATCH 2/3] cxl/ras: Clear software-only TLP log fields afte=
r RCH AER copy ---
commit 5075cbfef0d94b8fb5de2ea2f5d342f46661acbd
Author: Dave Jiang <dave.jiang@intel.com>

cxl/ras: Clear software-only TLP log fields after RCH AER copy

This commit clears the software-only header_len and flit fields in the
embedded pcie_tlp_log structure after copying the AER capability from
MMIO. This prevents pcie_print_tlp_log() from walking out of bounds and
leaking stack contents into the error log.

Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260717222706.3540281-1-terry.bowma=
n@amd.com?part=3D1

> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index 0a8b3b9b63884..a847727686df5 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -69,6 +69,13 @@ static bool cxl_rch_get_aer_info(void __iomem *aer_bas=
e,
>  	for (n =3D 0; n < read_cnt; n++)
>  		aer_regs_buf[n] =3D readl(aer_base + n * sizeof(u32));

[Severity: High]
This is a pre-existing issue, but does using sizeof(struct aer_capability_r=
egs)
cause an out-of-bounds MMIO read here?

The loop count is calculated earlier in cxl_rch_get_aer_info() as:

    int read_cnt =3D sizeof(struct aer_capability_regs) / sizeof(u32);

Since the software struct is bloated to 100 bytes with the embedded
pcie_tlp_log, but the hardware AER capability is at most 56 to 72 bytes,
won't this loop read undefined or overlapping MMIO registers past the end
of the capability? This can potentially trigger synchronous external aborts
or Machine Checks on some architectures during hardware error handling.

A similar regression appears in cxl_dport_map_rch_aer():

    devm_cxl_iomap_block(host, aer_phys, sizeof(struct aer_capability_regs)=
);

Could this map unbacked RCRB memory or overlap with other capability
registers?

> +	/*
> +	 * header_len and flit are software-only metadata in struct
> +	 * pcie_tlp_log; Clear to remove garbage register contents.
> +	 */
> +	aer_regs->header_log.header_len =3D 0;
> +	aer_regs->header_log.flit =3D false;

While this patch addresses the stack read in cxl/ras, there are pre-existing
regressions in the ACPI GHES and EXTLOG drivers caused by this same struct
expansion.

[Severity: High]
This is a pre-existing issue, but does copying sizeof(struct aer_capability=
_regs)
cause an out-of-bounds memory read in ghes_handle_aer()?

In drivers/acpi/apei/ghes.c:ghes_handle_aer():

    memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_regs)=
);

Since pcie_err->aer_info is strictly defined as a 96-byte array, copying
100 bytes will read past the CPER payload. If the array sits at the end of
a mapped page, could this trigger a fatal page fault during a machine check
or NMI context?

[Severity: High]
This is a pre-existing issue, but are the software-only fields left
uninitialized when passed to pcie_print_tlp_log() from the ACPI drivers?

In drivers/acpi/apei/ghes.c:ghes_handle_aer(), the struct is populated
directly from the firmware payload:

    memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_regs)=
);

And in drivers/acpi/acpi_extlog.c:extlog_print_pcie():

    aer =3D (struct aer_capability_regs *)pcie_err->aer_info;
    ...
    pci_print_aer(pdev, aer_severity, aer);

If firmware provides arbitrary bytes that happen to set flit to true and
header_len to a large value, could pcie_print_tlp_log() iterate up to
255 times, reading out of bounds and leaking adjacent kernel memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722205303.3184=
787-1-dave.jiang@intel.com?part=3D2
