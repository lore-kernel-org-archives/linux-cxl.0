Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DE4379960
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311110; cv=none; b=Tz7hFfqyGWG83Rsks04TpkqURfpYuKWqr2j+MlU5d3smoX8hKRK8qI7VqbgMgWXzKtwdy6ngfahj8EwlVjM4fN6g29dgcyIxoxxIZtktIvFT1Mir0OqN4s/Kx/itbBjKzzjGg29ZELCoHJ17VExYZchWavNWWXqoVuDg+ULZHMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311110; c=relaxed/simple;
	bh=VB/H1TAEpO0bpd2rIOBGYd7NO9qrrM7pxnGzTeWgqU4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cgkztCkphSixdrYBZXL2Qy3F5ER797k0xSagAsIimR7d6y7+sh2+xzfQXqKgAFlDTwpW7Zv2e2Bwk2y0W9NvR/DO1eOIuFMDqF+qfyH/y4mKqWstqphO67E4G+RzR9kTxXnSHc2AJKnB1R0SbnmMjUNpRpm5EyzGuDnkLBbyFyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j13eik6n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j13eik6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8980D1F000E9;
	Fri, 17 Jul 2026 17:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784311108;
	bh=Td1q+jbV1KN2yGBwjobRME2wUKVxhKFtE6CM3m7d2lI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j13eik6nUXLY+8XQoXU9SUiOrZGKftGTYgG0JsRyiEmOtW6lb72CU4fU9xq9R7Cvq
	 am4jG7eZKKqMN/OK/h9rDT3bX68ne6H+AINM6QopW+AG7kXsFBlepzrEBiszHWa8Im
	 39R7O9O99w3+/t6RpVWHFxrOSP7l9/HhYjK5fJjAMluHY0nyHjBXf/n0X9JndMWIDu
	 7/0N06Snhk08OpVB//X9ByKST6co0Uf9tHJELAZBCWGURJ5vTiBIk4DYe0epYlZceX
	 cXU3gWq2ayo3+kEws7acOyECtPY16ta0KddPoVibfEUdkUxqJg/n+zGw9har2ZXQyR
	 e9b+IYgama1zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/10] ACPI: extlog: Avoid populating software AER
 metadata from raw hardware buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260717161647.1493259-5-dave.jiang@intel.com>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-5-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 17:58:28 +0000
Message-Id: <20260717175828.8980D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but ghes_handle_aer(=
) completely misses the fix applied in this patch. It reads 100 bytes from =
a 96-byte array, triggering a FORTIFY_SOURCE panic, and leaves software-onl=
y fields uncleared, leading to a heap information leak.
- [High] This problem wasn't introduced by this patch, but cxl_rch_get_aer_=
info() calculates MMIO reads using the inflated software struct size, causi=
ng an out-of-bounds MMIO read and populating a stack-allocated struct with =
garbage, driving a stack information leak.
- [High] This problem wasn't introduced by this patch, but aer_recover_queu=
e() fails to free the dynamically allocated aer_capability_regs when the kf=
ifo is full, permanently leaking memory from the critical ghes_estatus_pool.
--

--- Patch [4]: [PATCH v3 04/10] ACPI: extlog: Avoid populating software AER=
 metadata from raw hardware buffer ---
commit 61009f4d553f47557d961ce2fe251ac8b1878dfd
Author: Dave Jiang <dave.jiang@intel.com>
ACPI: extlog: Avoid populating software AER metadata from raw hardware buff=
er

This patch resolves an out-of-bounds read by copying the raw aer_info
buffer into a local struct and clearing the software-only fields.
It prevents hardware data from overwriting header_len and flit.

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
>  	struct pci_dev *pdev;
>  	unsigned int devfn;
[ ... ]
>  	aer_severity =3D cper_severity_to_aer(severity);
> -	aer =3D (struct aer_capability_regs *)pcie_err->aer_info;
> +
> +	memcpy(&aer_regs, pcie_err->aer_info, sizeof(pcie_err->aer_info));
> +	aer_regs.header_log.header_len =3D 0;
> +	aer_regs.header_log.flit =3D false;
> +	aer =3D &aer_regs;
> +
>  	domain =3D pcie_err->device_id.segment;
>  	bus =3D pcie_err->device_id.bus;
>  	devfn =3D PCI_DEVFN(pcie_err->device_id.device,

While reviewing this change, I noticed a few related pre-existing issues in
other files that might need similar attention.

drivers/acpi/apei/ghes.c:ghes_handle_aer() {
[ ... ]
		aer_info =3D (void *)gen_pool_alloc(ghes_estatus_pool,
						  sizeof(struct aer_capability_regs));
		if (!aer_info)
			return;
		memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_regs));
[ ... ]
}

[Severity: High]
This isn't a bug introduced by this patch, but ghes_handle_aer() completely
misses the fix applied in this patch.

Does this read 100 bytes from the 96-byte pcie_err->aer_info array?

Could this trigger a strict fortify source buffer overflow panic?

Also, since the software-only fields aren't cleared, could
pcie_print_tlp_log() read out of bounds from the heap-allocated dw array,
leaking adjacent ghes_estatus_pool memory into the system log?


drivers/cxl/core/ras_rch.c:cxl_rch_get_aer_info() {
[ ... ]
	int read_cnt =3D sizeof(struct aer_capability_regs) / sizeof(u32);
	u32 *aer_regs_buf =3D (u32 *)aer_regs;
	int n;
[ ... ]
	/* Use readl() to guarantee 32-bit accesses */
	for (n =3D 0; n < read_cnt; n++)
		aer_regs_buf[n] =3D readl(aer_base + n * sizeof(u32));
[ ... ]
}

[Severity: High]
This is a pre-existing issue, but cxl_rch_get_aer_info() calculates
mmio reads using the inflated software struct size.

Could this cause an out-of-bounds unmapped mmio read, potentially triggering
a machine check exception or unsupported request error?

Additionally, since the aer_regs struct is allocated on the stack in
cxl_handle_rdport_errors(), couldn't reading unmapped mmio fill the flit
and header_len fields with garbage?

If passed to pcie_print_tlp_log(), this might drive an out-of-bounds loop
that leaks kernel stack frames into the system log.


drivers/pci/pcie/aer.c:aer_recover_queue() {
[ ... ]
	if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
				 &aer_recover_ring_lock))
		schedule_work(&aer_recover_work);
	else
		pr_err("buffer overflow in recovery for %04x:%02x:%02x.%x\n",
		       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
}

[Severity: High]
This is a pre-existing issue, but aer_recover_queue() fails to free the
dynamically allocated aer_capability_regs when the kfifo is full.

Since ghes_handle_aer() allocates this buffer from ghes_estatus_pool and
hands ownership to aer_recover_queue(), does dropping it on the kfifo
overflow error path permanently leak memory from the pool?

Could a burst of pcie aer errors exhaust the pool and break subsequent
ras handling?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717161647.1493=
259-1-dave.jiang@intel.com?part=3D4
