Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E953F105E
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 20:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787864318; cv=none; b=uYSrKjE6YawuA4chLavbV2UfzyFc9BWt+9Z09RroQ6G7glScl1lUm4SUnLoBHb8bODEZwrPNVfAVlLFZ/S2hUHsz7qDqU3HribGbqi0EGOcyQG59gkv8s8NzNuhtb9ejYgtRifPLmcJ7vugaVG+dy5ExD6G2MZIBOkgvCLGSIm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787864318; c=relaxed/simple;
	bh=lZdxgOCctt8F1KZVMEQPcw1eihjrH9THl/uBO60E2w4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DFTVm7eWlTh6RDMd0AH8yx6WRRY5nWNHddOI0/RePnchW2lZIm8H1YzqnHglvNC/p7rntVh2EEDSo0UtwGwae69zQJLkADMPUmlnQ/p44kWas/Px5jvIKcvMIIu2rUbDc4CFGN1jYZMwWn39omGGfc/SfWjTNm/S+ly8XlZpSRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAHxTkzQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAHxTkzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468361F000E9;
	Thu, 27 Aug 2026 20:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787864317;
	bh=IXBvMjCJjYhB0e/FwEIZWM+P7omVpB+fHwikfqPsuhw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oAHxTkzQ1ZAHGhLegKYsQFiq9WydS32bJOEUI+GhrMwqGS3W36332V8kljQ7fDYXE
	 sur9hvWdLsqtsNGUGajhYg8d/PJpAuWJUmcL/Uv1sxPwaJHEutl/+LxhUoy42a1iVC
	 V7JAplEGytdk2wwG0penFP7jWaj0XjoJMV6DuI0DO4SSUHF/JNkCEbbQp7shxuOMwk
	 Es81bGbcDVVqfeOQqvCImY/jTsJZe4170gs3WVvs5CSTM8rdZ09rE3UZ3YOKYZCOzv
	 7+F2yC4TSPifYRZ+CurqwfMiHUgCpyr3sxsRB0UH8VUnbyIhVaLmtlMlz5B4+1Ftce
	 Ahtpt0DxWLKZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/13] ACPI: extlog: Avoid populating software AER
 metadata from raw hardware buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260827203726.3027541-6-dave.jiang@intel.com>
References: <20260827203726.3027541-1-dave.jiang@intel.com>
 <20260827203726.3027541-6-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 20:58:36 +0000
Message-Id: <20260827205837.468361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Data loss of TLP Prefix Log / Extended Flit Log due to arbitrary=
 payload truncation.

Pre-existing issues:
- [High] Out-of-bounds MMIO read and stack array bounds poisoning in `cxl_r=
ch_get_aer_info()`.
--

commit 99282f77735a9b69f6cccf74ca39147b80930bf8
Author: Dave Jiang <dave.jiang@intel.com>
ACPI: extlog: Avoid populating software AER metadata from raw hardware buff=
er

This commit addresses an issue in extlog_print_pcie() where casting the raw
CPER aer_info buffer to a software struct populates software-only fields
with raw hardware bytes. It copies only the leading registers and the
Header Log DWORDs into a zeroed local struct to prevent out-of-bounds loop
reads.

Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.ke=
rnel.org/

> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
[ ... ]
> @@ -149,7 +149,17 @@ static void extlog_print_pcie(struct cper_sec_pcie *=
pcie_err,
>  		return;
> =20
>  	aer_severity =3D cper_severity_to_aer(severity);
> -	aer =3D (struct aer_capability_regs *)pcie_err->aer_info;
> +
> +	/*
> +	 * struct pcie_tlp_log is larger than the hardware layout, so only the
> +	 * leading registers and the four Header Log DWORDs of aer_info map onto
> +	 * the struct. Copy that much and leave the rest zero, which covers the
> +	 * software-only header_len and flit.
> +	 */
> +	memcpy(&aer_regs, pcie_err->aer_info,
> +	       offsetof(struct aer_capability_regs, header_log) +
> +	       PCIE_STD_NUM_TLP_HEADERLOG * sizeof(u32));

[Severity: Medium]
Will this truncated copy result in the permanent loss of the TLP Prefix Log?

The CPER aer_info array contains a raw 96-byte snapshot of the hardware AER
capability, with the TLP Prefix Log located at offset 0x38 (56 bytes). By
truncating the memcpy to 44 bytes, the remainder of the CPER payload is
ignored, which silently drops the hardware-provided TLP Prefix Logs or
Extended Flit Logs during PCIe error handling.

Would it be better to explicitly extract the prefix log from offset 56 in
the CPER record into aer_regs.header_log.prefix to avoid data loss?

[ ... ]

This isn't a bug introduced by this patch, but I noticed a similar=20
pre-existing AER software struct issue in drivers/cxl/core/ras_rch.c.

drivers/cxl/core/ras_rch.c:cxl_rch_get_aer_info()
> 	int read_cnt =3D sizeof(struct aer_capability_regs) / sizeof(u32);
> 	u32 *aer_regs_buf =3D (u32 *)aer_regs;
> 	int n;
> ...
> 	for (n =3D 0; n < read_cnt; n++)
> 		aer_regs_buf[n] =3D readl(aer_base + n * sizeof(u32));

[Severity: High]
Does this loop perform an out-of-bounds MMIO read by using the size of the
software structure?

Using sizeof(struct aer_capability_regs) (104 bytes) instead of the actual
hardware capability size directly maps MMIO data into software fields
(header_len and flit at offset 84). Later, when pcie_print_tlp_log() runs,
it uses the MMIO-poisoned header_len (which can be up to 255) as a loop
bound over the 14-element stack array log->dw[]. This leads to a massive
out-of-bounds stack read that can log arbitrary stack memory.

Additionally, in the same file:

drivers/cxl/core/ras_rch.c:cxl_rch_get_aer_severity()
> 		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
> 			*severity =3D AER_FATAL;

[Severity: High]
Does this code misinterpret the flow control protocol error bit?

It tests the Root Error Status flag PCI_ERR_ROOT_FATAL_RCV (0x40) against
the uncor_status register. In the uncor_status register context, 0x40
actually represents PCI_ERR_UNC_FCP, meaning the severity is incorrectly
computed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827203726.3027=
541-1-dave.jiang@intel.com?part=3D5
