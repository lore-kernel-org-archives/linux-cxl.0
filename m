Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB0B34574B
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784315255; cv=none; b=MNdUVlUSnfcpXcaMVr3E+bj2oQG6vQjj1HPZ9cFNItKrGwL6rXl8o+5gzF5z53RqJqP3NSW+4wCJQTAvnf4mXm46IQ1uUrbebRbHNRJs2qHkjrP4HOxBVR6FnDeOyuBz5slsxqA/WKbXWFMdzGdHFigC3QHwMgqDd2US5N9gMO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784315255; c=relaxed/simple;
	bh=WzybSPqxmKCmdzd+cffilR6vAEwyvC1m+x5ag5gqP9k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hMGdZIOjXJX9gS3ZHm0fM6TQ1SD3wbVdBOT6j0KtkZMs/C9rUL53ftLXNYf2qYHJyyQGPeBsI9IL0O/MMBiXIe7JElFk+XU+1fL+flshNoQhAxHdLP4vEhjQ098OC4iKJkDNfqzwNAa46kGzl3/FYusgixO5P+AFty6O0Uk+UB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYfj5TWz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYfj5TWz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8881F000E9;
	Fri, 17 Jul 2026 19:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784315254;
	bh=WcixCIsHSaGgFdlFN80eA1vZdkz9BgdjlZlAvQx7SHk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FYfj5TWz59O9YWcZj86bS0ari98O4Q8TOKCA767EFbvVP7VhZiolgM8ueIL0EdK0/
	 5PY5KRf4BMUu3RuLNB7ROyEnC52nb17SV0zOSmnbUPyhXfHytC2dfgVmD/gVITX6fr
	 tByDLNiTIVPSOozCA3ckMhIPekvJDHwBMG/aXiwlJA5TqEBou5HUoQsh+zOIpNwjo4
	 lqOCK6GOlCCK49s9WlL12kQQzLW4YUtpEUmwLh3zCDFt22rzalHaNiCwr6SocxBK3o
	 mz/K+OFlt+Iw8n/5igZjTYfHSBw8RmsOgEm7Prifocb5yRmRKb3aNQhFk6kjj5vzuB
	 ygdcTspwH5bgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/10] ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER
 guard typo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260717161647.1493259-8-dave.jiang@intel.com>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-8-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 19:07:33 +0000
Message-Id: <20260717190734.3C8881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] The commit message incorrectly claims to fix CXL protocol error =
handling, but the patch modifies the standard PCIe error handling function.

Pre-existing issues:
- [High] Software-only metadata in `struct aer_capability_regs` is overwrit=
ten with unvalidated hardware data, leading to massive out-of-bounds reads =
during TLP log printing, compounded by out-of-bounds copies from smaller bu=
ffers.
- [High] Missing bounds validation on firmware-provided `data_length` allow=
s heap out-of-bounds read in `extlog_print()`.
- [Medium] Bulk-copying the raw hardware `aer_info` buffer into `struct aer=
_capability_regs` causes a layout mismatch, resulting in Root Port command/=
status registers being erroneously printed as End-to-End TLP Prefixes.
- [Medium] AER statistics are updated without locking, leading to potential=
 data corruption and lost increments.
--

--- Patch [7]: [PATCH v3 07/10] ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER =
guard typo ---
commit 5975445fed69f606ac825570bf67bde4a1f490fd
Author: Dave Jiang <dave.jiang@intel.com>
Date:   Fri Jul 17 16:16:44 2026 +0000

    ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard typo

    sashiko-bot flagged that a Kconfig macro typo compiles out the extlog
    CXL protocol error handling entirely.

> sashiko-bot flagged that a Kconfig macro typo compiles out the extlog
> CXL protocol error handling entirely.

[Severity: Medium]
Is this commit message accurate? The modified function is extlog_print_pcie=
(),
which parses CPER_SEC_PCIE records (standard PCIe errors), rather than
CPER_SEC_CXL_PROT_ERR (CXL protocol errors).

> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index ae79d090de33b..1fbaf134c04e3 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -136,7 +136,7 @@ static int print_extlog_rcd(const char *pfx,
>  static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
>  			      int severity, u32 len)
>  {
> -#ifdef ACPI_APEI_PCIEAER
> +#ifdef CONFIG_ACPI_APEI_PCIEAER
>  	struct aer_capability_regs aer_regs =3D {};
>  	struct aer_capability_regs *aer;
>  	struct pci_dev *pdev;

[ ... ]

>  	aer_severity =3D cper_severity_to_aer(severity);
>=20
>  	memcpy(&aer_regs, pcie_err->aer_info, sizeof(pcie_err->aer_info));

[Severity: Medium]
This is a pre-existing issue, but does this bulk copy cause a layout
mismatch?=20

The raw hardware aer_info buffer is copied into the Linux struct
aer_capability_regs. Because the software struct embeds a struct pcie_tlp_l=
og
at offset 28, the hardware registers following the 16-byte Header Log might=
 be
erroneously copied into aer_regs.header_log.prefix[].=20

Could this cause pcie_print_tlp_log() to incorrectly print Root Error Comma=
nd
registers as End-to-End TLP Prefixes?

[Severity: High]
This is a pre-existing issue, but can this overwrite software-only metadata
fields in struct aer_capability_regs?

While this function initializes header_len and flit after the copy, other
functions like ghes_handle_aer() copy 100 bytes (sizeof struct
aer_capability_regs) from a 96-byte hardware buffer, reading memory
out-of-bounds.=20

Could unvalidated hardware data corrupting fields like header_len and flit
lead to massive out-of-bounds reads during pcie_print_tlp_log() over the
log->dw[] array?

>  	aer_regs.header_log.header_len =3D 0;
>  	aer_regs.header_log.flit =3D false;
>  	aer =3D &aer_regs;

[Severity: High]
This is a pre-existing issue, but does extlog_print() lack bounds validation
on the firmware-provided data_length?

drivers/acpi/acpi_extlog.c:extlog_print() {
    ...
	memcpy(elog_buf, (void *)estatus, ELOG_ENTRY_LEN);
    ...
	apei_estatus_for_each_section(tmp, gdata) {
    ...
}

Since elog_buf is allocated with a fixed 4096-byte limit, could a
maliciously large data_length from firmware cause the macro to walk off the
end of the heap allocation?

[Severity: Medium]
This is a pre-existing issue, but are the AER statistics updated without
locking?

drivers/pci/pcie/aer.c:pci_dev_aer_stats_incr() {
    ...
    counter[i]++;
    ...
}

Since pci_dev_aer_stats_incr() modifies 64-bit counters concurrently from
multiple execution contexts (like the threaded interrupt handler and
workqueues), could this data race result in corrupted statistics and lost
increments?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717161647.1493=
259-1-dave.jiang@intel.com?part=3D7
