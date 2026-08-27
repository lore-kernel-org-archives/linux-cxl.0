Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C413C3F4B
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787864465; cv=none; b=hkQQ9SR4BwJQAaL9pkgv39LaTWK39Sa0yiORMuDGaBJ069RuKyL3LmeaHM/HGIpN3m/svgA1C7LboizfFl5g8cc/JKzXxOHZJ7xjFBRA90A/q+eKSj0aDMAXARi9BQzHfP+seH7O16ePXGCuBLnbNR8U2gDYda8TlD0A4AOHaIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787864465; c=relaxed/simple;
	bh=iVxrcaly2eraFWTk8uStwkO7yIgPUyCFzvp2erdvkBs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p3LgS0maoPvQB0XCFTbhobNE5pgdAujpTh8q5kps3x2x9A1aJizCYBvKrNb2+hYlW539P1IkLITfzos4KyX2ewfRqOvLsXxg/pDucNTJcYVag2txpjyQtzfB+vm1hABwIAc6esXNs1ZkSALm84103TnQ0QRgR6WDAuF8cX0JeaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIiWcaS5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIiWcaS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A352D1F000E9;
	Thu, 27 Aug 2026 21:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787864463;
	bh=RAWIyeklI0LiQO5bBAoa8RywR8CUnWkw3q6VBX+YrPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fIiWcaS5OD3HOW0pMF7EBQjc18qwhC6+BXzQVsXrFRF+5Acxoq9dLYz4LJAqnzGca
	 dnSZ8JaOZp2Vp2mTU9VZI7PaItQt5z6qX+2iv8BSAXjGacWX1DSYel0yKVekxZFL3z
	 rPBRnc3aloDDkpgwJe8XcEeWHyaTvqgqOytXGGf0E+T8o+D81oltvIHqe6TJ1c783a
	 q94A02qz5xA0uYFdurXxQetMCoDAWHUtzTrzVOc3aqXpOQIKyx17xqIF4QD9lBWZ+r
	 vUe5ieSSV0W5cw2J7xifWC6rV0CNtpEvCg9W4Kc16bGNTZ6eXdmnagTDqX2BlqkEua
	 SaysFoyp/hcPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/13] ACPI: APEI: GHES: Bound AER info copy and
 sanitize software metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260827203726.3027541-13-dave.jiang@intel.com>
References: <20260827203726.3027541-1-dave.jiang@intel.com>
 <20260827203726.3027541-13-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 21:01:03 +0000
Message-Id: <20260827210103.A352D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing memory leak of dynamically allocated `aer_info` in `a=
er_recover_queue()` when the recovery kfifo is full.
- [High] Pre-existing memory leak of pool region in `aer_recover_work_func(=
)` when the PCI device cannot be found.
--

commit 3fa389697c596cc80036725c9cd2026267df97d9
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: APEI: GHES: Bound AER info copy and sanitize software metadata

ghes_handle_aer() copies sizeof(struct aer_capability_regs) out of the
fixed 96-byte pcie_err->aer_info. The struct is larger, so the copy reads
past the section, and it fills the software-only header_len and flit fields
of the embedded struct pcie_tlp_log from firmware bytes. This commit
validates error_data_length, zeroes the destination, and copies only what
maps onto the struct to prevent out-of-bounds loop execution.

Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@i=
ntel.com?part=3D3

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 0cc1e63836356..3df62ec20cf96 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -664,13 +667,21 @@ static void ghes_handle_aer(struct acpi_hest_generi=
c_data *gdata)
>  						  sizeof(struct aer_capability_regs));
>  		if (!aer_info)
>  			return;
> -		memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_regs=
));
> +
> +		/*
> +		 * Copy only what maps onto the struct, as extlog_print_pcie()
> +		 * does: the leading registers and the four Header Log DWORDs.
> +		 * The rest stays zero, so firmware cannot drive the
> +		 * pcie_print_tlp_log() loop over dw[] out of bounds.
> +		 */
> +		memset(aer_info, 0, sizeof(struct aer_capability_regs));
> +		memcpy(aer_info, pcie_err->aer_info,
> +		       offsetof(struct aer_capability_regs, header_log) +
> +		       PCIE_STD_NUM_TLP_HEADERLOG * sizeof(u32));
> =20
>  		aer_recover_queue(pcie_err->device_id.segment,
>  				  pcie_err->device_id.bus,
> -				  devfn, aer_severity,
> -				  (struct aer_capability_regs *)
> -				  aer_info);
> +				  devfn, aer_severity, aer_info);

[Severity: High]
This is a pre-existing issue, but does aer_recover_queue() leak the
dynamically allocated aer_info if the recovery kfifo is full?

In ghes_handle_aer(), aer_info is allocated from the ghes_estatus_pool and
passed to aer_recover_queue(). If the aer_recover_ring is full,
kfifo_in_spinlocked() returns 0 and aer_recover_queue() logs an error:

drivers/pci/pcie/aer.c:aer_recover_queue() {
    ...
	if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
				 &aer_recover_ring_lock))
		schedule_work(&aer_recover_work);
	else
		pr_err("buffer overflow in recovery for %04x:%02x:%02x.%x\n",
		       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
}

The function returns without freeing aer_regs, permanently leaking memory
from the lockless GHES estatus pool.

[Severity: High]
This is also a pre-existing issue, but does aer_recover_work_func() leak
this pool region when a PCI device cannot be found?

When aer_recover_work_func() dequeues entries, it attempts to resolve the
pci_dev. If it fails, it executes continue, skipping the rest of the loop:

drivers/pci/pcie/aer.c:aer_recover_work_func() {
    ...
		pdev =3D pci_get_domain_bus_and_slot(entry.domain, entry.bus,
						   entry.devfn);
		if (!pdev) {
			pr_err_ratelimited("%04x:%02x:%02x.%x: no pci_dev found\n",
					   entry.domain, entry.bus,
					   PCI_SLOT(entry.devfn),
					   PCI_FUNC(entry.devfn));
			continue;
		}
    ...
}

The call to ghes_estatus_pool_region_free() is at the end of the loop body,
so the continue statement bypasses it, permanently leaking the memory from
the GHES estatus pool.

>  	}
>  #endif
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827203726.3027=
541-1-dave.jiang@intel.com?part=3D12
