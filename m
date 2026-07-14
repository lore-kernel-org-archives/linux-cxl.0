Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E7527587D
	for <linux-cxl@vger.kernel.org>; Tue, 14 Jul 2026 23:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784073117; cv=none; b=EMtuo4F6yMbSPDl+gN7D5nLJN82abLMcxJfVuE6pIZmmMtMaL7AQio/yqRrvO2mGWfOcBVFv/rZg7o2SFR+CmexRCdRgfKjsoHyFaNB3ZR5rG9uuskisVHLfmW7Fey9KO2tLO/MD68RRoCKx4/Hrn0h2ND+GVBAgxZuXir4NVnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784073117; c=relaxed/simple;
	bh=NdJ1cB3MSpfybX5fX+WlC7aNbC5zaLywcmmRN1dXhA0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lYEljV2TYuX+Z6X76TsUAugW057TjaH22ozhRr6sFcd6LKTNiuIOH2dn5LagyKwMT9YSPbevtMHgd85+ktmYHlxA7urjBAlKvayKdMyyfDf0FnGuE5Gh9KlvWaR6BkUNalKmFY23ydOP/souEBtdBc6HFQEd2oZ75nt91Sqze3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmoWERWi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmoWERWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F4E1F000E9;
	Tue, 14 Jul 2026 23:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784073115;
	bh=aiRoSCyPuGk7GNEgu5eFOfvi2y+uXQ59d8SKLpkCCPc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nmoWERWihn2NmkoqzEGTz5vdv+EJ50LhCPZPxKWPyxs4X6u62SPIqptfKnxbJjANp
	 +cJTVkOhNrss22S1SdoPSEv3TB+QXpEuZmyONxKwsYTfX7gAIcJAN492qoOjxhgXzY
	 ZtlrvOo+bIVxQRHzfBgB628b0A1KJDxiBxVcxcSrk4aIPOU41sdBarl0aolweNZ9OE
	 XCM0aJaN9pcS5+utdknLRLncxnZTQoUXLKgV0F3WegF2clWA5ljAOTi6LZeJju+lbO
	 U1uBYomxknJJb7MbR39dKggMY9Q4J36f66x2gjXSMbm5C3ebnedu0kL3Upe52cznIc
	 00Lhu/kseVxFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/7] ACPI: extlog: Avoid populating software AER
 metadata from raw hardware buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260714231835.303081-4-dave.jiang@intel.com>
References: <20260714231835.303081-1-dave.jiang@intel.com>
 <20260714231835.303081-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 23:51:54 +0000
Message-Id: <20260714235155.41F4E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] GHES AER handling suffers from the exact same unvalidated hardware=
 data bug being fixed, plus a 4-byte out-of-bounds buffer read.
- [High] cxl_rch_get_aer_info() reads raw MMIO past the hardware capability=
 boundary and populates software struct fields directly, triggering an out-=
of-bounds stack read.
- [High] Missing bounds check on gdata->error_data_length before processing=
 CPER_SEC_CXL_PROT_ERR and CPER_SEC_PCIE payloads.
- [Medium] The patch maps the hardware AER capability buffer to struct aer_=
capability_regs via memcpy, but structural misalignment causes hardware reg=
isters to be logged erroneously as TLP Prefixes.
--

--- Patch [3]: [PATCH v2 3/7] ACPI: extlog: Avoid populating software AER m=
etadata from raw hardware buffer ---
commit abdd5781d57340e81525247f53a52f27296139bd
Author: Dave Jiang <dave.jiang@intel.com>
ACPI: extlog: Avoid populating software AER metadata from raw hardware buff=
er

This commit copies the AER info hardware buffer into a zeroed local struct
to avoid treating raw hardware bytes as software-only metadata. It then
explicitly clears the header_len and flit fields so only known-safe values
reach the TLP log printing routine.

Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.ke=
rnel.org/

> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 06a944dadbc15..fbc88c584c067 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -137,6 +137,7 @@ static void extlog_print_pcie(struct cper_sec_pcie *p=
cie_err,
>  			      int severity)
>  {
>  #ifdef ACPI_APEI_PCIEAER
> +	struct aer_capability_regs aer_regs =3D {};
>  	struct aer_capability_regs *aer;

[ ... ]

> @@ -149,7 +150,12 @@ static void extlog_print_pcie(struct cper_sec_pcie *=
pcie_err,
>  		return;
> =20
>  	aer_severity =3D cper_severity_to_aer(severity);
> -	aer =3D (struct aer_capability_regs *)pcie_err->aer_info;
> +
> +	memcpy(&aer_regs, pcie_err->aer_info, sizeof(pcie_err->aer_info));

[Severity: Medium]
This is a pre-existing issue, but the structural misalignment here appears =
to
cause hardware registers to be logged erroneously as TLP Prefixes.

The software struct embeds a struct pcie_tlp_log that is 60 bytes long,
whereas the actual hardware Header Log is only 16 bytes. Does mapping the
hardware AER capability buffer directly to struct aer_capability_regs cause
the Root Error Command and Root Error Status registers to map into the
aer_regs.header_log.prefix array?

Since flit is set to false below, pcie_print_tlp_log() falls back to
printing the prefix array if prefix[0] is non-zero. Could this erroneously
print raw hardware control registers as End-to-End TLP Prefixes, corrupting
logs?

> +	aer_regs.header_log.header_len =3D 0;
> +	aer_regs.header_log.flit =3D false;
> +	aer =3D &aer_regs;

I noticed a few other related pre-existing issues in the codebase that might
warrant a look:

[Severity: High]
This is a pre-existing issue, but is there a missing bounds check on the
error data length before processing payloads?

In extlog_print(), the code iterates over ACPI HEST generic data sections
and processes them based on section type:

drivers/acpi/acpi_extlog.c:extlog_print() {
    ...
    extlog_print_pcie(pcie_err, gdata->error_severity);
    ...
}

If a malformed or truncated payload is received from the hardware, could th=
is
access out-of-bounds memory when downstream functions dereference the paylo=
ad
fields, since gdata->error_data_length isn't validated to be at least
sizeof(struct cper_sec_pcie)?


[Severity: High]
This is a pre-existing issue, but does ghes_handle_aer() suffer from the
same unvalidated hardware data bug being fixed here, along with an
out-of-bounds read?

drivers/acpi/apei/ghes.c:ghes_handle_aer() {
    ...
    memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_regs)=
);
    ...
}

This memcpy copies 100 bytes (size of the struct) from a 96-byte array,
reading past the payload buffer. Does this also populate the software-only
flit and header_len fields with unvalidated hardware data, potentially
causing pcie_print_tlp_log() to iterate past the end of the dynamically
allocated buffer?


[Severity: High]
This is a pre-existing issue, but does cxl_rch_get_aer_info() read raw MMIO
past the hardware capability boundary?

drivers/cxl/core/ras_rch.c:cxl_rch_get_aer_info() {
    ...
    int read_cnt =3D sizeof(struct aer_capability_regs) / sizeof(u32);
    ...
    for (n =3D 0; n < read_cnt; n++)
        aer_regs_buf[n] =3D readl(aer_base + n * sizeof(u32));
    ...
}

This loop reads 100 bytes from the MMIO address, which exceeds standard AER
capability sizes (56 to 72 bytes).=20

Later, in cxl_handle_rdport_errors(), the polluted struct is allocated on
the stack:

drivers/cxl/core/ras_rch.c:cxl_handle_rdport_errors() {
    ...
    struct aer_capability_regs aer_regs;
    ...
}

Since the raw MMIO read pollutes the flit and header_len fields, could
pcie_print_tlp_log() use these unvalidated fields to iterate past the bounds
of the dw array and leak kernel stack memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714231835.3030=
81-1-dave.jiang@intel.com?part=3D3
