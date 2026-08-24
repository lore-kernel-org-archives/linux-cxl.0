Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6AC38332F
	for <linux-cxl@vger.kernel.org>; Mon, 24 Aug 2026 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595475; cv=none; b=SKmSub1i20kS1tXQ1o8nqd0wMg4vIcJyqDc7f7qXB/bQPC4rs5AedXMkuGe4jMOYSlk4e+r4B9ruKBIStaPIAt4O4RpJq6PQDgQxfLN1OuPvuNAUdC++FG5BmgmsSco+qPHcs4eMHh0xFKs8doTWcphhycLo75fUr5uuoMdKLbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595475; c=relaxed/simple;
	bh=AVfYWJKe3eJc9ERku6Z54kgQK8snxuWx4IN686qgfbQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KbJJoJPcysf8Sj/apHqm7iXazZ6C7FxrpE48o/vMWB369P+C8nVAg5oCCpHPjnY6z+RA5TWKB9Wf+V8U7ainJ/BT/kX1IZyPVK4PuAQjXg5bNSIOBPN+QJI1q5JxCutERFpfXd+sEsolsJd4RY7+nXkqD8POadIvWZb+f4PxV6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CssEsTeh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CssEsTeh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F681F000E9;
	Mon, 24 Aug 2026 18:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787595474;
	bh=PuQ56z15nGkJG11DTcgP9BpS4oCRcRVYWPlKYD3YSX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CssEsTehePJBhwnO6EfO2S+H8YtvbxbOQ976n2vCVPMP3jDke0fMoouA6FElk/nhX
	 nbMznQMKhzmjQNaazfgSixN/uooZT+hrJu5+qW2V5jUqRlsKZsBdoGNph+y7IGZKTD
	 C1Zpqu7Mh2GAU6o/c4LR94msvX9aw/9kTU4Hoezd+YgSLakNQ+us+iBU4uKaky6PWy
	 cmsZ6ETySHKEuctONivOydYMBpOy5leN5QGSefKqLm3bxxaxhRw1pIWiDuTIg3M+B3
	 I1DuTanascPaKsHvuwKYiTLhDqn49ATMpsRs0zTwwb+Zpw7HGOx21nsRIcJMIXG+R7
	 HvNG8H0wh5oEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/13] ACPI: APEI: GHES: Bound AER info copy and
 sanitize software metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260824174936.939059-13-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
 <20260824174936.939059-13-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 18:17:53 +0000
Message-Id: <20260824181753.F3F681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Hardcoding `header_len =3D 0` and `flit =3D false` in `ghes_handle=
_aer()` actively breaks the parsing and printing of legitimate Flit mode TL=
P logs from CPER AER records.

Pre-existing issues:
- [High] Memory allocated for `aer_capability_regs` from the fixed-size `gh=
es_estatus_pool` is permanently leaked when `aer_recover_queue()` fails to =
insert into the `aer_recover_ring`.
- [High] Memory allocated for `aer_capability_regs` is leaked in `aer_recov=
er_work_func()` when the target PCI device cannot be found.
- [High] Direct `memcpy` of raw CPER AER hardware bytes into `struct aer_ca=
pability_regs` misaligns fields, causing hardware registers to be incorrect=
ly parsed and printed as TLP Prefix Logs.
- [High] Uninitialized and unvalidated software-only fields in `cxl_rch_get=
_aer_info()` lead to a massive out-of-bounds kernel stack read in `pcie_pri=
nt_tlp_log()`.
- [High] Direct `memcpy` of little-endian CPER AER info into native integer=
 fields of `struct aer_capability_regs` corrupts values on big-endian archi=
tectures.
--

--- Patch [12]: [PATCH v4 12/13] ACPI: APEI: GHES: Bound AER info copy and =
sanitize software metadata ---
commit 91c35473296c2f22c740c76f30c6c146671ec39a
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: APEI: GHES: Bound AER info copy and sanitize software metadata

ghes_handle_aer() copies sizeof(struct aer_capability_regs) out of the
fixed 96-byte pcie_err->aer_info. The struct is larger, so the copy reads
past the section. Validate error_data_length, zero the destination,
bound the copy to the 96-byte source, and clear header_len and flit.

Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@i=
ntel.com?part=3D3

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 0cc1e63836356..d6643127a2df0 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c

[ ... ]

> @@ -664,13 +667,22 @@ static void ghes_handle_aer(struct acpi_hest_generi=
c_data *gdata)
>  						  sizeof(struct aer_capability_regs));
>  		if (!aer_info)
>  			return;
> -		memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_regs=
));
> +
> +		/*
> +		 * The CPER source is a fixed 96 bytes, shorter than struct
> +		 * aer_capability_regs, so bound the copy to it. header_len and
> +		 * flit are software-only and land inside those 96 bytes; clear
> +		 * them so firmware cannot drive the pcie_print_tlp_log() loop
> +		 * over dw[] out of bounds.
> +		 */
> +		memset(aer_info, 0, sizeof(struct aer_capability_regs));
> +		memcpy(aer_info, pcie_err->aer_info, sizeof(pcie_err->aer_info));

[Severity: High]
This isn't a bug introduced by this patch, but does this direct memcpy
misalign fields in struct aer_capability_regs?

The CPER hardware payload expects Root Error Command and Root Error Status
at offset 44 and 48 respectively. However, struct aer_capability_regs
embeds the software struct pcie_tlp_log at offset 28.

Because pcie_tlp_log is padded for Flit mode and takes up ~60 bytes, doesn't
this incorrectly place the hardware's Root Error Command into
aer_info->header_log.dw[4], which aliases to prefix[0]?

This would cause pcie_print_tlp_log() to dump entirely unrelated hardware
registers as TLP Prefix logs.

[Severity: High]
This is another pre-existing issue, but does this direct copy of little-end=
ian
CPER AER info into native integer fields corrupt the values on big-endian
architectures?

Without le32_to_cpu() conversions, parsing these fields on a big-endian
system will interpret the bytes in reverse order, breaking downstream
bitwise evaluations.

> +		aer_info->header_log.header_len =3D 0;
> +		aer_info->header_log.flit =3D false;

[Severity: High]
Does hardcoding header_len and flit to 0 and false unconditionally break the
parsing and printing of legitimate Flit mode TLP logs from CPER AER records?

If the hardware actually experienced an error in Flit mode, indicated by
PCI_ERR_CAP_TLP_LOG_FLIT in aer_info->cap_control, this forcibly discards
that state. Won't pcie_print_tlp_log() then ignore the extended Flit mode
header DWORDS entirely?

> =20
>  		aer_recover_queue(pcie_err->device_id.segment,
>  				  pcie_err->device_id.bus,
> -				  devfn, aer_severity,
> -				  (struct aer_capability_regs *)
> -				  aer_info);
> +				  devfn, aer_severity, aer_info);
>  	}
>  #endif
>  }

[Severity: High]
This is a pre-existing issue, but does this code leak the memory allocated
for aer_info from the fixed-size ghes_estatus_pool if aer_recover_queue()
fails to insert into the aer_recover_ring?

drivers/pci/pcie/aer.c:aer_recover_queue() {
    ...
    if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
                             &aer_recover_ring_lock))
        schedule_work(&aer_recover_work);
    else
        pr_err("buffer overflow in recovery for ...\n", ...);
}

Since aer_recover_queue() returns void, ghes_handle_aer() cannot detect
the failure to perform cleanup, permanently leaking the pool memory.

[Severity: High]
This is also a pre-existing issue, but is the memory for aer_info leaked
in aer_recover_work_func() if the target PCI device cannot be found?

drivers/pci/pcie/aer.c:aer_recover_work_func() {
    ...
    pdev =3D pci_get_domain_bus_and_slot(entry.domain, entry.bus,
                                       entry.devfn);
    if (!pdev) {
        pr_err_ratelimited("... no pci_dev found\n");
        continue;
    }
    ...
}

The continue statement skips the ghes_estatus_pool_region_free() cleanup
call at the bottom of the loop, permanently leaking the memory.

[Severity: High]
This isn't a bug in this patch either, but does a similar issue with
uninitialized software-only fields exist in cxl_rch_get_aer_info()?

drivers/cxl/core/ras_rch.c:cxl_rch_get_aer_info() {
    ...
    for (n =3D 0; n < read_cnt; n++)
        aer_regs_buf[n] =3D readl(aer_base + n * sizeof(u32));
    ...
}

If it reads from unimplemented MMIO space, it returns 0xFFFFFFFF, which
populates the software-only metadata fields on the stack such that flit
evaluates to true and header_len becomes 255.

Doesn't this lead to an out-of-bounds stack read later?

drivers/pci/pcie/tlp.c:pcie_print_tlp_log() {
    ...
    for (i =3D PCIE_STD_NUM_TLP_HEADERLOG; i < log->header_len; i++) {
        len +=3D scnprintf(buf + len, sizeof(buf) - len,
                         " %#010x", log->dw[i]);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824174936.9390=
59-1-dave.jiang@intel.com?part=3D12
