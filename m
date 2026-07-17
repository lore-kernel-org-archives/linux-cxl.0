Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B232ECD35
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784317199; cv=none; b=gwd7YzGgWLN+iXPF9EiZWe+rnr25rACqJiP6ffKugBytt9T4jTYbOzu416/OKphROyvGuXGyxuKxPM4fh4nDOK6fvnEtNyN5s5s/e9Mz7CSNADUxSp+GEoN9xY4AbNnUMXFLvQ3HyAwONQ3TC/VtSgBk6kCDXIe9gihHdSjyqE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784317199; c=relaxed/simple;
	bh=Dnz1LyjM27qyl4X1SlAPJRrGe2xQnQd1DzgprxfXlVg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rKeE1czODF5Pfd6mm9QY3koYBedKzpQahrC6ZM4aWDu+lIEeoPpH7QelcRtCednMMn1BrAg/SgoBbqQNdT2TAPL32EQTfL5ZWmkz8gP5rt0NixN+82JGYXuH9PijChjwipO0L7s2Ji6EYht8eoAt6aSTSQD3Ln45FubWJO7WUl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoCkFbQz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoCkFbQz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480631F000E9;
	Fri, 17 Jul 2026 19:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784317197;
	bh=uY0n5pmKrCyJ0RnYX2Rx+gePOSX5nQEPoBoIUDSZRL4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MoCkFbQz5pIOJ9X+wyE63mGIxM2qKYu9rMPNhDhDu59Fc5fepbfej58NZg93w5Uzw
	 Fs+I/hOXg4ythqxEKQkBg6nUAyH4DBmnmIEfz8AsqZlqcfed3LtYJemOLT1bNPVwUm
	 rBdVc3EupWSzceeJ6F9fCW94HGM9aiD2LKZoVMt52+pF7VhrPml65n7QFDj3At8yDC
	 /+JhVMc5BJDw1s3xiGDj9Ap5NKCAfT4rnmAzx307HiADQjilzmPCeedtyJGUNNrhto
	 OOvjwuUcOUH7q+3AJMfAN+tUfxlOhmcOxPi6KZ1XhQKd4gzJgW3ZCiw2Cs4lqcFqmG
	 6rFoU8tJIfXZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/10] ACPI: APEI: GHES: Bound AER info copy and
 sanitize software metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260717161647.1493259-10-dave.jiang@intel.com>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-10-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 19:39:56 +0000
Message-Id: <20260717193957.480631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory allocated for AER registers from the NMI-safe pool is leake=
d when the aer_recover_ring kfifo is full.
- [High] Memory allocated for AER registers from the NMI-safe pool is leake=
d when the target PCI device cannot be found during asynchronous recovery.
- [High] The CXL RCH driver reads past the physical AER capability into a s=
tack-allocated struct, corrupting software metadata and triggering out-of-b=
ounds stack memory accesses.
--

--- Patch [9]: [PATCH v3 09/10] ACPI: APEI: GHES: Bound AER info copy and s=
anitize software metadata ---
commit 4a70c73fe1d51d5ff3adef3bd4739dd98b4c3b8d
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: APEI: GHES: Bound AER info copy and sanitize software metadata
   =20
Validate error_data_length, zero the destination, bound the copy to the
96-byte source, and clear header_len and flit. This mirrors the
extlog_print_pcie() fix.

Link: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@int=
el.com?part=3D3

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 1d2966a437bdb..bd53509dcab3c 100644
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
> +		 * aer_info is a fixed 96-byte buffer, smaller than struct
> +		 * aer_capability_regs, so bound the copy to the source. Clear
> +		 * the software-only header_len and flit fields afterwards so
> +		 * firmware bytes cannot drive the pcie_print_tlp_log() loop over
> +		 * dw[] out of bounds.
> +		 */
> +		memset(aer_info, 0, sizeof(struct aer_capability_regs));
> +		memcpy(aer_info, pcie_err->aer_info, sizeof(pcie_err->aer_info));
> +		aer_info->header_log.header_len =3D 0;
> +		aer_info->header_log.flit =3D false;

[Severity: High]
This isn't a bug introduced by this patch, but given the sizing fixes here
regarding struct aer_capability_regs, does the CXL RCH driver have a similar
out-of-bounds access?

In cxl_rch_get_aer_info(), the loop reads from MMIO based on the software
struct size rather than the hardware capability:

drivers/cxl/core/ras_rch.c:cxl_rch_get_aer_info() {
    ...
    for (n =3D 0; n < read_cnt; n++)
        aer_regs_buf[n] =3D readl(aer_base + n * sizeof(u32));
    ...
}

Reading past the capability can return 0xFFFFFFFF, which would overwrite
header_len to 0xFF and flit to true in the stack-allocated aer_regs.

When passed to pci_print_aer() in cxl_handle_rdport_errors(), could this
corrupted header_len cause pcie_print_tlp_log() to read far out-of-bounds
on the stack?

>  		aer_recover_queue(pcie_err->device_id.segment,
>  				  pcie_err->device_id.bus,
> -				  devfn, aer_severity,
> -				  (struct aer_capability_regs *)
> -				  aer_info);
> +				  devfn, aer_severity, aer_info);

[Severity: High]
This is a pre-existing issue, but does this code leak the memory allocated
from ghes_estatus_pool if the aer_recover_ring kfifo is full?

If the kfifo insertion fails in aer_recover_queue():

drivers/pci/pcie/aer.c:aer_recover_queue() {
    ...
    if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
                             &aer_recover_ring_lock))
        schedule_work(&aer_recover_work);
    else
        pr_err("buffer overflow in recovery for %04x:%02x:%02x.%x\n",
               domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
}

The function returns void without freeing the aer_regs pointer. Could this
deplete the NMI-safe ghes_estatus_pool during a burst of AER events?

[Severity: High]
This is also a pre-existing issue, but does this same allocation leak
during asynchronous recovery if the PCI device is not found?

When the worker processes the queue in aer_recover_work_func():

drivers/pci/pcie/aer.c:aer_recover_work_func() {
    ...
    if (!pdev) {
        pr_err_ratelimited("%04x:%02x:%02x.%x: no pci_dev found\n",
                           entry.domain, entry.bus,
                           PCI_SLOT(entry.devfn),
                           PCI_FUNC(entry.devfn));
        continue;
    }
    ...
}

If the device lookup fails, the continue statement bypasses the
ghes_estatus_pool_region_free() call at the end of the loop, which
would leave the memory chunk unreleased.

>  	}
>  #endif
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717161647.1493=
259-1-dave.jiang@intel.com?part=3D9
