Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8FB27587D
	for <linux-cxl@vger.kernel.org>; Tue, 14 Jul 2026 23:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784073000; cv=none; b=nJX5BjTje+tN/ckDbsoloWy/K56ekS7zEjc64S83HKZzaEqHQ+c6taHCysUnOrL01YiBPMtQ7y1gyWpGN7Fz3KYcH75WWkw5jxQbzmnw9k1MtjrwISHgnZa0nofET7P5e8Rx4seuvqKGNW5AI17aVH/3tP4VoOuXtHHraMLIp44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784073000; c=relaxed/simple;
	bh=vnPsTH3mfb7kNRZ+JYjQVUT9+pFake6QLtN9T54wZsU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Is+cQe5WllgUnxhiLCINtmGFu6nb5o82W+lgwzQv6uMhW5y1SY8jKYaClYJJ4uxtd8gcTqBHEXmIkDNRoZB1r9L9rSy0YHs+dp7LINPuwfXDqcPeqSuefKy6aX4gByUzkQxk9GktVzMgkQMPqHKcB+/1NFjKJ6xdPxwioacu2CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9gB9iaA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9gB9iaA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6856C1F000E9;
	Tue, 14 Jul 2026 23:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784072998;
	bh=eTehwSYggv4Xkv84XWhE2/RUzA/PaHDQlgCwSPba+Qc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V9gB9iaAKgN+Jq5baIsgyxlGeAdHJDAg1f83ugWzo0mHkwkG3ngf+nCmEiIr3gDiW
	 RzoHK26wqT3IJFC9+gqncwVBZGH/Q/Hqcz32MaDESk8nj4dfonwa2SdJ5BNiUhCZa7
	 AZUO0OiM+UuWB5yxh4zk10tinZn3O9CTBqGNoVyj0bMzDxcI1mXiPqftYjHi2gvQ8X
	 vXLVt21tvZiwVG1N0s8EhgiC61sO5m6dqN3AYEW5Joqg/Jx4g3LV+GV06w0b/i8sUc
	 3FA8ClXfqR031SZDhtC6b8mKlfzwuqL/Ey+NHbVcaQb2vkAzTA9ZFb8JNYPeRjR2iI
	 az2r73DcpxdzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] ACPI: APEI: GHES: Validate CXL protocol error
 section length before RAS cap copy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260714231835.303081-3-dave.jiang@intel.com>
References: <20260714231835.303081-1-dave.jiang@intel.com>
 <20260714231835.303081-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 23:49:58 +0000
Message-Id: <20260714234958.6856C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] CXL Protocol Error handling in Extlog is permanently disabled due =
to a typo in the Kconfig macro check.
- [High] Unconditional use of `dvsec_len` without checking the `PROT_ERR_VA=
LID_DVSEC` valid bit, leading to incorrect validation and wrong RAS capabil=
ity offset.
- [High] Out-of-bounds read in `cxl_cper_print_prot_err()` because `dvsec_l=
en` is not validated against the section length.
- [High] Deadlock (IRQ inversion) due to acquiring `cxl_cper_prot_err_work_=
lock` and `cxl_cper_work_lock` without disabling IRQs in process context.
--

--- Patch [2]: [PATCH v2 2/7] ACPI: APEI: GHES: Validate CXL protocol error=
 section length before RAS cap copy ---
commit 66f8d9e4b5a4dd7c78d837b5436bcc5297ca8261
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: APEI: GHES: Validate CXL protocol error section length before RAS cap=
 copy

cxl_cper_setup_prot_err_work_data() locates the RAS Capability block by
skipping a firmware-controlled DVSEC. This commit adds checks to verify
the section is large enough to contain the header and capabilities before
accessing any fields.

Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_i=
nternal_review-v6-0-91f725174aa0@arm.com?part=3D6
Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.ke=
rnel.org/

> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 7ad3b36013cc6..06a944dadbc15 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -165,12 +165,12 @@ static void extlog_print_pcie(struct cper_sec_pcie =
*pcie_err,
> =20
>  static void
>  extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> -				int severity)
> +				int severity, u32 len)
>  {
>  #ifdef ACPI_APEI_PCIEAER

[Severity: High]
This is a pre-existing issue, but does this Kconfig macro check have a typo?

It uses ACPI_APEI_PCIEAER instead of CONFIG_ACPI_APEI_PCIEAER, which means =
the
entire body of extlog_cxl_cper_handle_prot_err() is compiled out.

On platforms that use Extlog rather than GHES, CXL protocol errors would be
silently ignored, potentially leaving hardware in a broken state and leading
to system crashes.

>  	struct cxl_cper_prot_err_work_data wd;
> =20
> -	if (cxl_cper_sec_prot_err_valid(prot_err))
> +	if (cxl_cper_sec_prot_err_valid(prot_err, len))
>  		return;

[ ... ]

> diff --git a/drivers/acpi/apei/ghes_helpers.c b/drivers/acpi/apei/ghes_he=
lpers.c
> index bc7111b740afb..7db6a6722fcff 100644
> --- a/drivers/acpi/apei/ghes_helpers.c
> +++ b/drivers/acpi/apei/ghes_helpers.c
> @@ -23,6 +30,19 @@ int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_pr=
ot_err *prot_err)
>  		return -EINVAL;
>  	}
> =20
> +	/*
> +	 * The RAS Capability block follows a firmware-controlled DVSEC of
> +	 * prot_err->dvsec_len bytes. Verify the header, the DVSEC and the RAS
> +	 * Capability block all fit within the CPER section.
> +	 */
> +	if (sizeof(*prot_err) + prot_err->dvsec_len +
> +	    sizeof(struct cxl_ras_capability_regs) > len) {

[Severity: High]
This is a pre-existing issue, but should this bounds check and the offset
calculation in cxl_cper_setup_prot_err_work_data() verify that the
PROT_ERR_VALID_DVSEC bit is set in valid_bits before using dvsec_len?

If the PROT_ERR_VALID_DVSEC bit is clear, dvsec_len is undefined and could
contain garbage.

Using a garbage length here could cause this new bounds check to spuriously
fail, or cause the RAS capability offset to point to arbitrary data that ge=
ts
passed to the PCI AER driver.

> +		pr_err_ratelimited(FW_WARN
> +				   "CXL CPER prot err section too small (%u)\n",
> +				   len);
> +		return -EINVAL;
> +	}

While reviewing this area, I also noticed a couple of other pre-existing
issues related to CXL protocol error handling that might be worth addressin=
g.

[Severity: High]
This is a pre-existing issue, but is there an out-of-bounds read in
cxl_cper_print_prot_err() in drivers/firmware/efi/cper_cxl.c?

When calling print_hex_dump() using prot_err->dvsec_len:

drivers/firmware/efi/cper_cxl.c:cxl_cper_print_prot_err() {
    ...
    print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, (prot_err + 1),
                   prot_err->dvsec_len, 0);
    ...
}

The dvsec_len field is not validated against the actual section length
provided in gdata->error_data_length. If firmware provides a corrupt or
malicious dvsec_len, this could read past the memory buffer, potentially
causing a page fault and kernel panic.


[Severity: High]
This is a pre-existing issue, but is there a potential deadlock (IRQ invers=
ion)
between cxl_cper_register_prot_err_work() and cxl_cper_post_prot_err() in
drivers/acpi/apei/ghes.c?

In process context, cxl_cper_register_prot_err_work() acquires the lock
without disabling interrupts:

drivers/acpi/apei/ghes.c:cxl_cper_register_prot_err_work() {
    ...
    guard(spinlock)(&cxl_cper_prot_err_work_lock);
    ...
}

If an error interrupt arrives on the same CPU while the lock is held, the
interrupt handler calls cxl_cper_post_prot_err(), which tries to acquire the
same lock:

drivers/acpi/apei/ghes.c:cxl_cper_post_prot_err() {
    ...
    guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
    ...
}

Would this cause the interrupt handler to spin forever waiting for the lock?
The same pattern appears to exist for cxl_cper_work_lock in
cxl_cper_register_work().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714231835.3030=
81-1-dave.jiang@intel.com?part=3D2
