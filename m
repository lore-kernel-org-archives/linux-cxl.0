Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F8A38237A
	for <linux-cxl@vger.kernel.org>; Mon, 24 Aug 2026 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595339; cv=none; b=s/eTA4y+Hm3Q4SXtCpO6rtiOWD15IUdeBOf1hz9jY1XT/PJHKmlvAN1ODAgv8y3lSG6jQPLll6W4No+5PikiMYjyXwMICPttaGAj1VEx2JXXUVWEli5PENLaYVunrlh5C1ruOufzVHBuoXo8/cKs0ZUkYnIbsXxK1FTPefp6uXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595339; c=relaxed/simple;
	bh=L/ayPEX2Z2umeJzObDWmNJ6e208tV+j3WJUmwVktDnI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bt3Lm8dcwez9515yZDYSC7g+zicppmjGQ9ktQrNqLW8UPCRmj8s1DqgRv1B2+VNp/lId08BuOpmQ7/jkdiiCb+bkM+S3LfqFPoZbmKfd5SfOQssVOZ9CQEwp7sDkyHE2labw+ZX5yH5nMeDNKhkO7fs4rnq7xXGWNPmGXGo8KdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZLayyw8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZLayyw8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0491F00A3E;
	Mon, 24 Aug 2026 18:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787595337;
	bh=/Waf04YFuXGcWd7sLOqaWNtE2CpKHQyZqk3xF2vYjqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MZLayyw8dTOYg7ZOr5GtoRUmhEapXqh9BmAYavlfq/97FcIsNbcKzB6YGXFVCVlsH
	 fGsEeSVm0QGNZ205Z1b35JVI/pe63BnpVB0RGy0yEIwMdyvIbgrIwIM7b8O9rnMuHp
	 zPNnAfPoCb+s8hf37eNEBUcpjommAJ+jGkOJeH3P0NAYmZnkMmrVa2mwBGvVgjoGFu
	 jW3lXlQQGblJKccUr2emzQLFC1oNjG4J/KhXMzaAJM//IPeVeUI2eZM9EwHqV9VdN+
	 MGlhFBQEsSgU7zBdxzLnjXODqjBa1fbPg2ERTC1l8UMzbvPIWxyS98M1f0/y8Lo5KT
	 In+cA8jzvIhlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/13] ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER
 guard typo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260824174936.939059-8-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
 <20260824174936.939059-8-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 18:15:37 +0000
Message-Id: <20260824181537.CC0491F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `cxl_rch_get_aer_info()` performs a MMIO read that exceeds the phy=
sical footprint of the AER capability, leading to potential out-of-bounds p=
hysical MMIO accesses.
- [High] Memory leak from the fixed-size `ghes_estatus_pool` when the AER r=
ecovery queue is full.
- [Medium] Activating the AER handler causes corrupted diagnostic output be=
cause `struct aer_capability_regs` no longer maps 1:1 to the hardware AER c=
apability layout.
- [Medium] Concurrent lockless updates to u64 AER stats can lead to dropped=
 counts.
--

--- Patch [7]: [PATCH v4 07/13] ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER =
guard typo ---
commit 6574c6d62d519f2f7bce0f053a2b55a5d05016ce
Author: Dave Jiang <dave.jiang@intel.com>
ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard typo

This commit fixes a typo in the preprocessor guard by adding the missing
CONFIG_ prefix. This change enables the previously compiled-out extlog
PCIe aer handling code.

> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 3aec73187b519..ebedf3b136a88 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -136,7 +136,7 @@ static int print_extlog_rcd(const char *pfx,
>  static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
>  			      int severity, u32 len)
>  {
> -#ifdef ACPI_APEI_PCIEAER
> +#ifdef CONFIG_ACPI_APEI_PCIEAER

[Severity: Medium]
This isn't a bug introduced by this patch, but activating this aer handler
exposes a preexisting issue. Does the memcpy() in this block overwrite
misaligned software fields?

drivers/acpi/acpi_extlog.c:extlog_print_pcie() {
    ...
    memcpy(&aer_regs, pcie_err->aer_info, sizeof(pcie_err->aer_info));
    ...
}

Since struct aer_capability_regs contains struct pcie_tlp_log which was
expanded with software-only fields (header_len, flit), this pushes the
offset of subsequent fields beyond their hardware offsets.=20

Copying the 96-byte hardware aer capability directly into the structure
misaligns these later fields, which could lead to corrupted diagnostic
output when pci_print_aer() reads them.

>  	struct aer_capability_regs aer_regs =3D {};
>  	struct pci_dev *pdev;
>  	unsigned int devfn;

[Severity: High]
This is a pre-existing issue, but I noticed a potential out-of-bounds mmio
read execution in the cxl core related to these aer structures.

drivers/cxl/core/ras_rch.c:cxl_rch_get_aer_info() {
    ...
    aer_regs_buf[n] =3D readl(aer_base + n * sizeof(u32));
    ...
}

Can this loop read past the physical footprint of the aer capability?

Because sizeof(struct aer_capability_regs) grew due to the addition of
header_len and flit, reading this size from the aer_base mmio address
could fetch past the end of the physical aer capability registers.

This might cause bus hangs or trigger kasan violations.

[Severity: Medium]
This is a pre-existing issue, but I noticed potential lockless increment
operations on a 64-bit statistic in the aer core.

drivers/pci/pcie/aer.c:pci_dev_aer_stats_incr() {
    ...
    aer_info->dev_total_cor_errs++;
    ...
}

Can concurrent lockless updates to these u64 aer stats lead to dropped
counts?=20

Since this function is called locklessly from multiple contexts (such as
aer interrupt handlers and nmi-context ghes/extlog handlers), concurrent
read-modify-write operations on u64 variables without locking or atomics
could lead to dropped counts or torn reads/writes on 32-bit architectures.

[Severity: High]
This isn't a bug introduced by this patch, but there appears to be a memory
leak in the aer core failure path when the recovery queue is full.

drivers/pci/pcie/aer.c:aer_recover_queue() {
    ...
    if (!kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
                             &aer_recover_ring_lock)) {
        pr_err("buffer overflow in recovery for %04x:%02x:%02x.%x\n",
               ...);
        return;
    }
    ...
}

Does this failure path drop allocated memory without freeing it?

ghes_handle_aer() allocates memory from the fixed-size ghes_estatus_pool
and passes it to aer_recover_queue().=20

If kfifo_in_spinlocked() fails, the function prints an error and returns.=20

Since the pool is small and fixed-size, repeated overflow events could
permanently exhaust it, causing future hardware errors to be silently dropp=
ed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824174936.9390=
59-1-dave.jiang@intel.com?part=3D7
