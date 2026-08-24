Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF304370AFD
	for <linux-cxl@vger.kernel.org>; Mon, 24 Aug 2026 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595238; cv=none; b=sUzrxzdOYue/0fMTmc9YFimbErmYqsCucCNPMpO5B44BZiy9M2JAgl0IhBZp203jojKCEeE+lgPdb/xcpP1So32KXs5uTncDpOZMreGoO3Yc4DTNNo+P8Yatv03KxrEYkCi5LzxjH3QUqcc6W8+2Fb7fHY0Y92pQpLTGdVrzyqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595238; c=relaxed/simple;
	bh=gu3XkqVXZUbh+38AiZXlJeomS5aUNMvvYR+fDcstFrA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a3/BmPX30a8WjgvN55rlftBqxpekb3Fwgpv/rV31Z5z0P8p/xGpfVA1pKxDuy++StBzR4iQroR9Wtuzc9eD3UvblyQQQKxYUL8FkMikJZeWYOPJTxTlL8/bhBFmmVr6cpGz+eLHHHf13mFAvXcwJryMZwL7xju+93jw1DrYHpuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ml+IYc28; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ml+IYc28"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264D71F000E9;
	Mon, 24 Aug 2026 18:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787595237;
	bh=d2/+3oRd3v1Hu2i49azb1uXE3ZBXKq9gCVMv9zXqMnw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ml+IYc28u7s8wUIKQq9OKQUChzqOAxB4ZyYCtdVENpOuSsZG4GjvDeB2mTg+J510G
	 XZbyMVVVwpjjvxJU1iM9fkZJUoCje5MK1UqACXBtAJwe+fE/ImyDS3Rxs91zbWKXgB
	 X02b+ED68GZuLDlcHrpkx1EBp71y9mID4Kflxz+Mtv7LUF6xpxRU4JhhKDc51Er+md
	 Pxz1KTvPkc/fgXF3KJ5vhxHRayCd0Fo1Jyqg8dnlNe2J/ihOYPBgiTUg8BBed1uuz6
	 whSdfFmPN7puHGZfJoQcviLGhJm3aDrpG46mAMp2eXXXyKBkqmozh3EwwmX4lc2Gdn
	 nP5fMU56YSAIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/13] ACPI: extlog: Avoid populating software AER
 metadata from raw hardware buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260824174936.939059-6-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
 <20260824174936.939059-6-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 18:13:56 +0000
Message-Id: <20260824181357.264D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized AER metadata and invalid MMIO reads lead to an unbou=
nded stack out-of-bounds read in CXL error handling.
--

--- Patch [5]: [PATCH v4 05/13] ACPI: extlog: Avoid populating software AER=
 metadata from raw hardware buffer ---
commit 92c75de48c08c6f2371a87542f1e783f6c2d32a1
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: extlog: Avoid populating software AER metadata from raw hardware buff=
er

extlog_print_pcie() casts pcie_err->aer_info straight to struct
aer_capability_regs *. That struct embeds struct pcie_tlp_log, whose
software-only header_len and flit fields sit at offset 84 - inside the
96-byte aer_info buffer - so the cast fills them with raw firmware bytes.
pcie_print_tlp_log() uses both to bound a loop over dw[], and a large
header_len walks past the end of the array.

Copy aer_info into a zeroed local struct aer_capability_regs and clear
header_len and flit before passing it on.

Closes: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.=
kernel.org/

> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index f6e3da4e13e78..6d5532ec09208 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
[ ... ]
> @@ -149,7 +149,11 @@ static void extlog_print_pcie(struct cper_sec_pcie *=
pcie_err,
>  		return;
> =20
>  	aer_severity =3D cper_severity_to_aer(severity);
> -	aer =3D (struct aer_capability_regs *)pcie_err->aer_info;
> +
> +	memcpy(&aer_regs, pcie_err->aer_info, sizeof(pcie_err->aer_info));
> +	aer_regs.header_log.header_len =3D 0;
> +	aer_regs.header_log.flit =3D false;

[Severity: High]
This isn't a bug introduced by this patch, but does the same pattern exist =
in
the CXL subsystem in drivers/cxl/core/ras_rch.c?

In cxl_rch_get_aer_info(), it appears to read raw MMIO directly into the
software structure, which could populate software-only fields like
header_len with unmapped MMIO values (0xFFFFFFFF):

drivers/cxl/core/ras_rch.c:cxl_rch_get_aer_info() {
    ...
    int read_cnt =3D sizeof(struct aer_capability_regs) / sizeof(u32);
    ...
    for (n =3D 0; n < read_cnt; n++)
        aer_regs_buf[n] =3D readl(aer_base + n * sizeof(u32));
    ...
}

Then in cxl_handle_rdport_errors(), this corrupted stack-allocated struct
is passed to pci_print_aer():

drivers/cxl/core/ras_rch.c:cxl_handle_rdport_errors() {
    ...
    struct aer_capability_regs aer_regs;
    ...
    pci_print_aer(pdev, severity, &aer_regs);
    ...
}

Could this lead to the same unbounded stack out-of-bounds read when
pcie_print_tlp_log() uses the garbage header_len to loop over the log->dw
array?

> +
>  	domain =3D pcie_err->device_id.segment;
>  	bus =3D pcie_err->device_id.bus;
>  	devfn =3D PCI_DEVFN(pcie_err->device_id.device,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824174936.9390=
59-1-dave.jiang@intel.com?part=3D5
