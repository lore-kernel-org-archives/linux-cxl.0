Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C491370AFD
	for <linux-cxl@vger.kernel.org>; Mon, 24 Aug 2026 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595022; cv=none; b=bjd4JA63BqWryWWMI2TZfidpB4n28bXrjdUQH/C+Qn2Ld+JZg1yYb+iI5LTal9StVGt0j3qVwePSItLLDPM1igOl70odCs44QbqEaERaXqeKdc1D41Q5HTkWX+NDPCDK3wMuwNHBwrP42s0OUQX0j2UkrveZKoLQ4Hi6Fp9/ZZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595022; c=relaxed/simple;
	bh=XKcy6btcm6sdOY4v+FKHch7dLEweQiGwYX3nGvCfVWc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b03I/rsV0bhW3gENLdTA2rvWdMqjRWoel5ineL0s+QKw1zslfADsmekcafngWMR1N27Q5V5SwAefAtAbjUlL3XrbygYgBb+RWPY5LBzEhuuzpyQmKhOoSvb0DWD2AL0UtO3eII8JQFo0W0IWXPLo9Lnr/WpE1j/V28psVmx3Ym8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUspthdC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUspthdC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F621F000E9;
	Mon, 24 Aug 2026 18:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787595020;
	bh=tKvM7PWOgWTghz3Qk839+735h5cRPIzRRuZskuN9Ig0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GUspthdCeonPoXNvJfT6RzpqvsKUFjrxqIfuPkFg7sGHrUsToNC1yR/duAr7h19ln
	 ZfaDxzK25Tn/dGbexZ1WS2zmPnlUKJbQnXnFBorNZ+5ixR7lLF+Z/S3L3rTxYDzj2g
	 /fWmitNUCHSNEoh+2pKcnNA8BUsww/pLETaz2R7k9Q5MYnO4UARq3EPvr3Uk1jLJWz
	 Lpjb8qfZi1PUqlRfQ+Ivgk21IsbXRRawimVaz2Y0LPR95vdB4FTltzLUKwOr1DAnR1
	 Tm13me+nDl6voQKvRbXiNtdwQyveMJwOWZsi8PUVI8ITt6364+IGL0u4dZuNjmRWP+
	 Ar9ueCv2Shr0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/13] ACPI: APEI: GHES: Validate CXL protocol error
 section length before RAS cap copy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260824174936.939059-10-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
 <20260824174936.939059-10-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 18:10:20 +0000
Message-Id: <20260824181020.87F621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `cxl_cper_print_prot_err()` reads out-of-bounds memory when dumpin=
g the CXL DVSEC and Error Log if `prot_err->dvsec_len` exceeds the actual e=
rror record data length.
--

--- Patch [9]: [PATCH v4 09/13] ACPI: APEI: GHES: Validate CXL protocol err=
or section length before RAS cap copy ---
commit 86649d90c05d1f4d84b3cdb3e62e7482bd0800ac
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: APEI: GHES: Validate CXL protocol error section length before RAS cap=
 copy

cxl_cper_setup_prot_err_work_data() locates the RAS Capability block at
prot_err + sizeof(*prot_err) + dvsec_len and copies it, but dvsec_len is
firmware controlled and never validated, so it can point the copy outside
the section.

Extend cxl_cper_sec_prot_err_valid() to check that the section can hold
the header, and that the header, DVSEC and RAS Capability block together
fit the reported section length.

Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_i=
nternal_review-v6-0-91f725174aa0@arm.com?part=3D6
Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.ke=
rnel.org/

> diff --git a/drivers/acpi/apei/ghes_helpers.c b/drivers/acpi/apei/ghes_he=
lpers.c
> index bc7111b740afb..df41b993f4130 100644
> --- a/drivers/acpi/apei/ghes_helpers.c
> +++ b/drivers/acpi/apei/ghes_helpers.c

[ ... ]

> @@ -23,6 +30,15 @@ int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_pr=
ot_err *prot_err)
>  		return -EINVAL;
>  	}
> =20
> +	/* The RAS Capability block sits after a firmware-sized DVSEC. */
> +	if (sizeof(*prot_err) + prot_err->dvsec_len +
> +	    sizeof(struct cxl_ras_capability_regs) > len) {
> +		pr_err_ratelimited(FW_WARN
> +				   "CXL CPER prot err DVSEC (%u) overruns section (%u)\n",
> +				   prot_err->dvsec_len, len);
> +		return -EINVAL;
> +	}
> +

[Severity: High]
This is a pre-existing issue, but does this new bounds validation cover the
synchronous print path during CXL protocol error handling?

While this patch adds bounds validation via cxl_cper_sec_prot_err_valid()
for the workqueue execution path, the synchronous print path appears to
completely bypass this new validation.

Earlier in the flow, ghes_proc() calls ghes_print_estatus(), which leads to
cper_estatus_print_section():

drivers/firmware/efi/cper.c:cper_estatus_print_section() {
    ...
		if (gdata->error_data_length >=3D sizeof(*prot_err))
			cxl_cper_print_prot_err(newpfx, prot_err);
		else
			goto err_section_too_small;
    ...
}

This checks that the error section is large enough to hold the base header
structure, but fails to validate that it can also hold the variable-length
DVSEC or the RAS capabilities before passing it to the print routine.

The untrusted dvsec_len is then used directly in cxl_cper_print_prot_err(),
leading to an out-of-bounds memory read:

drivers/firmware/efi/cper_cxl.c:cxl_cper_print_prot_err() {
    ...
		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, (prot_err + 1),
			       prot_err->dvsec_len, 0);
    ...
		cxl_ras =3D (struct cxl_ras_capability_regs *)((long)prot_err + size);
		pr_info("%s cxl_ras_uncor_status: 0x%08x", pfx,
			cxl_ras->uncor_status);
    ...
}

Could firmware still trigger an unhandled page fault or leak kernel memory
to the system log by providing an artificially large dvsec_len that reaches
this print path?

>  	if ((prot_err->agent_type =3D=3D RCD || prot_err->agent_type =3D=3D DEV=
ICE ||
>  	     prot_err->agent_type =3D=3D LD || prot_err->agent_type =3D=3D FMLD=
) &&
>  	    !(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824174936.9390=
59-1-dave.jiang@intel.com?part=3D9
