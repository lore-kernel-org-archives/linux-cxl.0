Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAF042A166
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784310104; cv=none; b=RHmYi0G/MjMLIu0tRfAHJxQh5ztXUWN2XJhbEZP01EWMdIcYSBp9btHCT0fTuzEeywCKeLO24urX2e5GOag+5iltZ/SKAMAxZ2kMk9+W5jOaA4pHFwNd8QcJInGgrUVjtbWvNNBoWh2wQcTWrh6BsNfgKUNoEM/tGVOxRzKIASg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784310104; c=relaxed/simple;
	bh=lvsVcumpX9RQDJ7l03zzBalh+E9Bo+M/4RptybIQDf4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jJlWtQQgoTrTjOTHjk2/5EZEHQ3V4PC7TM0cwKBz4LshhA9VSt1NIm5NDHVlGWoPbpjp7y78T7gqaIMdXv4gdPhTYiZiYWwuYU3sxCitRjMAXm4ApFgBcvzJkk0DsdsHDl8+2+0oJjD3Pe0wW+aM2QLzV0S5KQeC/0uU/qgyTiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZ3b1cry; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZ3b1cry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BFE1F000E9;
	Fri, 17 Jul 2026 17:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784310103;
	bh=NZrvMsqr239qcAtMGTbkmxbYiCNcnvoXT7sJEII+9EA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YZ3b1crywyGl8xHKPjMmzZFyAAp0mdaxbv8Am4s+vMhEhjx7Nd2EDdEDlA3ep7XfX
	 PINX59dzr//O0p8H1zCnWVUIaPli8Cj0tMiC0lx0nEOFwgiA4dYL316A32j0dCH053
	 KxFRssNyRE+D89oGtkLXE9oKYdKKBV7wmDbsAHKKUM/5KumxuzYwi5MikU5PwF/TXE
	 FyHbOjP5U9IJwxRvTjbdrayUbwPfAbuxNi1Zrm9StXTuwksRvgh5sD86S0++kIiH+m
	 MmH2W99lXOKkPVMw8kgUEmgCYlogpLf6GVztBtfl/ti0FlRQxF9bjZAKEA9Ph+Ymtw
	 AzPH5IENTY1cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/10] ACPI: APEI: GHES: Validate CXL protocol error
 section length before RAS cap copy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260717161647.1493259-4-dave.jiang@intel.com>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 17:41:42 +0000
Message-Id: <20260717174143.21BFE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing payload length validation for PCIe AER error records (`CPE=
R_SEC_PCIE`).
- [High] The exact same out-of-bounds read vulnerability exists in `cxl_cpe=
r_print_prot_err()` when printing the CPER record.
- [High] Potential deadlock due to missing IRQ masking when acquiring `cxl_=
cper_work_lock` and `cxl_cper_prot_err_work_lock` in process context.
- [High] The `#ifdef ACPI_APEI_PCIEAER` guard in `drivers/acpi/acpi_extlog.=
c` is missing the `CONFIG_` prefix.
--

--- Patch [3]: [PATCH v3 03/10] ACPI: APEI: GHES: Validate CXL protocol err=
or section length before RAS cap copy ---
commit d9ae66d42856680b3ac8a462d2465e800e436efc
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: APEI: GHES: Validate CXL protocol error section length before RAS cap=
 copy

sashiko-bot flagged an out-of-bounds read driven by an unvalidated
firmware dvsec_len.

cxl_cper_setup_prot_err_work_data() locates the RAS Capability block at
prot_err + sizeof(*prot_err) + dvsec_len and copies it, but dvsec_len is
firmware controlled and never validated.

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
This isn't a bug introduced by this patch, but does this #ifdef evaluate to
false because it is missing the CONFIG_ prefix?

If so, does that cause the entire CXL protocol error handling and PCIe AER
logging in extlog_print_pcie() to be compiled as dead code?

>  	struct cxl_cper_prot_err_work_data wd;
> =20
> -	if (cxl_cper_sec_prot_err_valid(prot_err))
> +	if (cxl_cper_sec_prot_err_valid(prot_err, len))
>  		return;

[ ... ]

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index a752e152a5a0b..17e4ef5552925 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -753,12 +753,12 @@ static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
>  struct work_struct *cxl_cper_prot_err_work;
> =20
>  static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_er=
r,
> -				   int severity)
> +				   int severity, u32 len)
>  {
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
>  	struct cxl_cper_prot_err_work_data wd;
> =20
> -	if (cxl_cper_sec_prot_err_valid(prot_err))
> +	if (cxl_cper_sec_prot_err_valid(prot_err, len))
>  		return;
> =20
>  	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);

[Severity: High]
This is a pre-existing issue, but while looking at how this lock is used,
I noticed a potential IRQ inversion deadlock.

In drivers/acpi/apei/ghes.c:cxl_cper_register_prot_err_work() and
cxl_cper_register_work(), the locks are acquired from process context using
guard(spinlock), which does not disable interrupts:

    guard(spinlock)(&cxl_cper_prot_err_work_lock);

If a hardware error occurs on the same CPU, the NMI/IRQ handler will call
cxl_cper_post_prot_err() which attempts to acquire the exact same spinlock
using guard(spinlock_irqsave):

    guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);

Could this cause a deadlock during initialization?

[ ... ]

> @@ -950,7 +950,8 @@ static void ghes_do_proc(struct ghes *ghes,
>  		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
>  			struct cxl_cper_sec_prot_err *prot_err =3D acpi_hest_get_payload(gdat=
a);
> =20
> -			cxl_cper_post_prot_err(prot_err, gdata->error_severity);
> +			cxl_cper_post_prot_err(prot_err, gdata->error_severity,
> +					       gdata->error_data_length);

[Severity: High]
This is a pre-existing issue, but I noticed similar validation might be
missing for PCIe AER error records.

When ghes_do_proc() calls ghes_handle_aer() for CPER_SEC_PCIE, it casts
gdata to struct cper_sec_pcie * and reads pcie_err->validation_bits without
first verifying that gdata->error_data_length is at least
sizeof(struct cper_sec_pcie).

Could malicious or buggy firmware supplying an undersized error data length
cause an out-of-bounds read here?

[ ... ]

> diff --git a/drivers/acpi/apei/ghes_helpers.c b/drivers/acpi/apei/ghes_he=
lpers.c
> index bc7111b740afb..d625ec98a24c7 100644
> --- a/drivers/acpi/apei/ghes_helpers.c
> +++ b/drivers/acpi/apei/ghes_helpers.c
> @@ -5,8 +5,15 @@
>  #include <linux/aer.h>
>  #include <cxl/event.h>
> =20
> -int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
> +int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err, =
u32 len)
>  {

[Severity: High]
This is a pre-existing issue, but I noticed another location that might need
similar bounds checking.

In drivers/firmware/efi/cper_cxl.c:cxl_cper_print_prot_err(), the function
uses the unvalidated prot_err->dvsec_len to calculate the offset to the RAS
capability registers:

    cxl_ras =3D (struct cxl_ras_capability_regs *)((long)prot_err + size);
    pr_info("%s cxl_ras_uncor_status: 0x%08x", pfx, cxl_ras->uncor_status);

Since the function isn't passed the section length to perform this check,
could a malformed payload cause print_hex_dump() and subsequent register
accesses to read out of bounds?

> +	if (len < sizeof(*prot_err)) {
> +		pr_err_ratelimited(FW_WARN
> +				   "CXL CPER prot err section too small (%u)\n",
> +				   len);
> +		return -EINVAL;
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717161647.1493=
259-1-dave.jiang@intel.com?part=3D3
