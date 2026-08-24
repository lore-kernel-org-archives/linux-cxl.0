Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC7A37E5FB
	for <linux-cxl@vger.kernel.org>; Mon, 24 Aug 2026 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787594825; cv=none; b=qG7llx2dv/P3PR4OHiwmwZ4BRcV/512LWEE3S5ygO/ab9K/RoWN3txDI9qbMAymazHFxhGK0bSIWSe3rSZsjjzvBGnc7bGeadwieUKJtdxhyLBPH8JOoO7M5nbCKFvJAGjb0TJhBlq8/XBawmn49l9NDoyLvZYtT0q+Yyg0Ya9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787594825; c=relaxed/simple;
	bh=QavmKMlZqOwplOZroJ+gpWwH69/sVvoUx3560LFkeBg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WShcm65PdqWuAoYbvdORyufPy1qoE+sZ4JajtBDxse9+4Fafd6ByTYvlC8KHPjFjccPbvr8dwSYSWuAgoewWMa+iQAG94zzflraPy+ioAoHUxtjNPlqmE9hCkyqsSl7ct0IfTyiT+doDL3Qgdp/Croy3Tp1vJjf4OwPTv6ZVCBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9x3Hv9E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9x3Hv9E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109231F000E9;
	Mon, 24 Aug 2026 18:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787594824;
	bh=s5dSOF4Bz6aC0MkaEgi5+5FW6SLhu8UtD2vlnnbW6Qw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C9x3Hv9EirruCD+Pt6RQENELct7JCKSPLKLvnR44xhP4FbCGFHi4HqHJIHQ8PpLQq
	 TFM4mUlhRlLcyr2WKarMaroN2lKihVuM3A7FlhYLFxXRJt0t20RAtDbIYnS8Eaf6sp
	 w/lDIHYqLjWjXjt9i8Pkx2f1aecT8WXJQdVy7ppYQ45JnmRZs/OMe+zW1wPGq9yC/d
	 fTUMmQ1gccLp0y7apARaGupiQqzBg18gCpbIhABongpUXuNxcWTCAY/ewtMJbym+or
	 92kaEjXN8vfrtQSAWfSJ3ef6CmuBw8dEk0H9JaFSDJTPQy9XubWn8POw/kkl9JVcOG
	 6l2KhT2YAf74w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/13] ACPI: extlog: Validate PCIe error section
 length before payload access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260824174936.939059-7-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
 <20260824174936.939059-7-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 18:07:03 +0000
Message-Id: <20260824180704.109231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Structure layout mismatch when copying raw hardware AER capabili=
ties into `struct aer_capability_regs`, corrupting TLP prefix logs and misa=
ligning fields.
--

--- Patch [6]: [PATCH v4 06/13] ACPI: extlog: Validate PCIe error section l=
ength before payload access ---
commit 0c68ab7e511cca4ed3e0656d8522141bd2eb2d1b
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: extlog: Validate PCIe error section length before payload access

extlog_print_pcie() reads fields and copies the aer_info buffer without
checking that the error data length is big enough for a struct cper_sec_pci=
e.
This commit adds a check to reject sections too small to hold the record
before touching any field.

Closes: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.=
kernel.org/

> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 6d5532ec09208..3aec73187b519 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
[ ... ]
> @@ -144,6 +144,12 @@ static void extlog_print_pcie(struct cper_sec_pcie *=
pcie_err,
>  	int aer_severity;
>  	int domain;
> =20
> +	if (len < sizeof(*pcie_err)) {
> +		pr_warn_ratelimited(FW_WARN
> +				    "PCIe error section too small (%u)\n", len);
> +		return;
> +	}
> +
>  	if (!(pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
>  	      pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO))
>  		return;

[Severity: Medium]
This is a pre-existing issue, but does copying raw hardware AER capabilities
into struct aer_capability_regs corrupt TLP prefix logs and misalign fields?

Looking at extlog_print_pcie() right below this hunk:

drivers/acpi/acpi_extlog.c:extlog_print_pcie() {
    ...
	aer_severity =3D cper_severity_to_aer(severity);

	memcpy(&aer_regs, pcie_err->aer_info, sizeof(pcie_err->aer_info));
    ...
}

The memcpy blindly assumes struct aer_capability_regs matches the hardware
register layout, but the struct's header_log field is now much larger. This
causes subsequent hardware fields like root_command (offset 44) to overwrite
aer_regs.header_log.prefix.

Because struct aer_capability_regs uses a 60-byte struct pcie_tlp_log for i=
ts
header_log instead of the 16 bytes defined by the hardware specification, a=
ll
fields after header_log are misaligned. This occurs whenever a valid PCIe A=
ER
CPER record is processed.

The GHES handler in drivers/acpi/apei/ghes.c:ghes_handle_aer() shares the
identical layout mismatch vulnerability:

drivers/acpi/apei/ghes.c:ghes_handle_aer() {
    ...
		memcpy(aer_info, pcie_err->aer_info, sizeof(pcie_err->aer_info));
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824174936.9390=
59-1-dave.jiang@intel.com?part=3D6
