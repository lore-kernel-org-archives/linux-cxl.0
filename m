Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E692D3A60
	for <linux-cxl@vger.kernel.org>; Thu,  9 Jul 2026 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616099; cv=none; b=p/C5YSIis574Vs6BS+s2zlcjNe7GMJaoTyAisiw6hP00reZmdJPI0UYZ+7KlDXPQNrQahHE6wDRUmFRJOM9jMg1boRlY5Oi/lGr62grlU0Wdy86Ia39+wuZR+fzZcWSkPTE5hKMjD3NDKR5HIx0K3ZIfH5miLysEAffjSlFSAIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616099; c=relaxed/simple;
	bh=gzeUKoh2UIJ6Xhj7u2b2gIbc6Y/Bh697Hk0DsEhKAuQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZENesxH7uIZDhwvao/k9zFCw4tTsvGjxpmzE84RJ8vaiI6A2M1X3MmsOzgAfuMRfSrxWieCfTr1VlckixZckYpE315ruTbGJWqvhX9SLv7wFpoIwFRrVnadfV+ru/UM96f1dEBn/V48Ck3ZmoN9790Kjm6uGmDf8GC0qwt7eYZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8ql2FnU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8ql2FnU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA181F000E9;
	Thu,  9 Jul 2026 16:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783616098;
	bh=li95YnQcfx6jxQzVnRdzFJWfXXJ2b+v8kQxrVOyYaRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b8ql2FnUoyet1KZTs0Z333NjOG5uyGe01NKR7CNWbLLQZE2CCY8ekCThASQzcOMvj
	 PFv/zqhUMQDUASMRLjPRoWQ9vRvdcD3GCu+zQen3w7eP/zjyx0sCrJxkDzTqJ3GUQN
	 zMzPTqjROr8pjbQCS52E2od+a3hesR8Suieq/C3J4PceJrRfOpPgWFd/FyNMkbwkVp
	 9DTNyyvnckskR24lMLyH1IIrtngqiHZrreGGUYyNMahjmFG3n1djFthA5S7Lk1Dbd/
	 BVlZGZ/uXN2juzCRI1iK1VyL6rLXrDUjQUtzUGJdyvOENrsTHyQzZE2HNPXa6QcIOm
	 /d7/weRXtfppg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard
 typo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260709162807.1957783-4-dave.jiang@intel.com>
References: <20260709162807.1957783-1-dave.jiang@intel.com>
 <20260709162807.1957783-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 16:54:57 +0000
Message-Id: <20260709165457.8BA181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds checking on firmware-provided CPER data lengths bef=
ore accessing or copying PCIe and CXL protocol error structures.
- [High] Calling `cxl_cper_handle_prot_err` synchronously creates an AB-BA =
lock ordering deadlock with PCI `device_lock` and `x86_mce_decoder_chain.rw=
sem`.
- [High] Casting the raw hardware `aer_info` buffer directly to `struct aer=
_capability_regs` populates software-only metadata with unvalidated hardwar=
e data, triggering out-of-bounds array reads.
- [Low] Directly calling `cxl_cper_handle_prot_err()` causes a linkage fail=
ure when `CONFIG_ACPI_EXTLOG=3Dy` and `CONFIG_CXL_BUS` is configured as a m=
odule.
--

--- Patch [3]: [PATCH 3/4] ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard=
 typo ---
commit d29f05a05af2b3add29bfc216f34a5de8a53eb2a
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard typo

This patch fixes a typo in the preprocessor guard for ACPI_APEI_PCIEAER.
It changes the guard to use the correct CONFIG_ prefix, ensuring the
enclosed PCIe AER and CXL CPER handling code is actually built when enabled.

> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 7ad3b36013cc6..60c2b90adf0ae 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c

[ ... ]

> @@ -136,7 +136,7 @@ static int print_extlog_rcd(const char *pfx,
>  static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
>  			      int severity)
>  {
> -#ifdef ACPI_APEI_PCIEAER
> +#ifdef CONFIG_ACPI_APEI_PCIEAER

[Severity: High]
This isn't a bug introduced by this patch, but activating this code exposes
a missing bounds check on firmware-provided CPER data lengths.

If the firmware provides a CPER record where gdata->error_data_length is
smaller than the expected payload structs, or provides a maliciously large
dvsec_len for a CXL Protocol Error, is there a risk of an out-of-bounds
memory read?

When extlog_print() extracts payloads and dispatches to handlers without
verifying gdata->error_data_length >=3D sizeof(...), the code casts the
payload and executes cxl_cper_setup_prot_err_work_data(). This function
performs pointer arithmetic using the unvalidated dvsec_len and executes
a fixed-size memcpy(), which could lead to a kernel panic or data leak.

[Severity: High]
This is a pre-existing issue, but fixing the typo activates a code path in
extlog_print_pcie() that can trigger out-of-bounds array reads.

Does casting the raw 96-byte aer_info hardware buffer directly to struct
aer_capability_regs * populate software-only metadata with unvalidated
hardware data?

In Linux, struct aer_capability_regs embeds struct pcie_tlp_log, placing
software metadata (header_len and flit) at offset 0x54. Casting raw
registers populates these software fields with unvalidated hardware state.

If flit evaluates to true and header_len is read as a large value (up to
255), pcie_print_tlp_log() will iterate up to 255 times, reading
out-of-bounds past the 14-element log->dw array. This read traverses past
the aer_info struct and can cross into unmapped memory.

>  	struct aer_capability_regs *aer;
>  	struct pci_dev *pdev;

[ ... ]

> @@ -167,7 +167,7 @@ static void
>  extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>  				int severity)
>  {
> -#ifdef ACPI_APEI_PCIEAER
> +#ifdef CONFIG_ACPI_APEI_PCIEAER

[Severity: Low]
This is a pre-existing issue, but activating this previously dead code caus=
es
a linkage failure when CONFIG_ACPI_EXTLOG=3Dy and CONFIG_CXL_BUS is configu=
red
as a module.

Because ACPI_EXTLOG does not depend on CXL_BUS in its Kconfig, is it possib=
le
that the direct symbol call to cxl_cper_handle_prot_err() from the built-in
acpi_extlog.o to the module cxl_core.ko cannot be resolved? This would resu=
lt
in an undefined reference to cxl_cper_handle_prot_err.

[Severity: High]
This isn't a bug introduced by this patch, but activating this code exposes=
 a
potential AB-BA lock ordering deadlock with the PCI device_lock and
x86_mce_decoder_chain.rwsem.

When extlog_cxl_cper_handle_prot_err() is called synchronously while the
notifier rwsem is held, does this create a circular dependency?

extlog_print() is registered as an MCE decoder and is called with
down_read(&x86_mce_decoder_chain.rwsem) held. It now synchronously calls
cxl_cper_handle_prot_err(), which acquires the PCI device lock via
guard(device)(&pdev->dev), establishing the lock order:
x86_mce_decoder_chain.rwsem -> device_lock.

Conversely, during system initialization, drivers (like AMD GPU or CXL via
devm_cxl_register_mce_notifier()) execute .probe with the PCI device_lock
held and call mce_register_decode_chain(), taking
down_write(&x86_mce_decoder_chain.rwsem). Could this cause a hard deadlock =
if
an MCE occurs during driver probing or initialization?

>  	struct cxl_cper_prot_err_work_data wd;
> =20
>  	if (cxl_cper_sec_prot_err_valid(prot_err))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709162807.1957=
783-1-dave.jiang@intel.com?part=3D3
