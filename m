Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DABA481FDF
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788545323; cv=none; b=sWcHt80TRKZcO9Kd7IqDp4XnXTX8cGbMVFtWvOwf0ZIqQAff3pOCMPqESzo0eDC89y1KE/olPC+AVaDjQvW1KYRMrTFkgpK6EGB09DMskokcpt5PYcWtl5rk0U3DaYg8xj+MaMTrpzRSXQxrXIRfBtA3DxS9PbeMhTdMvfOHo0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788545323; c=relaxed/simple;
	bh=Zbt3Hdm1efnmHmAcsG6jcyC9ryW92AEildP0QJmmWqw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ekqtpF5hms3fvdJZdu3kzkQtNB8DbziVv3/Y1MCoC4+4ZW+vvILZY9qlfVxbrvE1yRYSO9Md3AMhT//Wkw6GHKu4VjAL9tulVD4r+yfs5b1/dbATLbbXil9Rj4PUZHj9Tih0yDhhzDOSIiAXKmcpiinYyOC0vRA0hucauUGc7Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiEqieHs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiEqieHs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A9C1F00A3D;
	Fri,  4 Sep 2026 18:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788545322;
	bh=xbVcZoPL/861MPKpSAsb6EsbPoQEXJ5C3WYv1IhRhNY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IiEqieHsLAjvldCXXEdjEsf2fxnTYUB1OE+RG6aVh8tlj0wdbItiBleWRK2Mbd7EO
	 KtXhKCCvxAGLvz1w6lhDC6jLfS9qzhJRqrPQTgknXilufkrhVYOJpjQj6XRcfLrp2y
	 2vubvILJRRxzcREY1PLsMrWnMfA5SBJt9YPY5ZylJ0IrXZtET5emkGbabBLeEsqxuY
	 d8G0J3k1lQGsrtDhatV+nubw2rnr0YRUg9Et39iXrb18ZUBT33RY6EEh4hJroMjLMP
	 q/oivzhnyNKFR7dwEpZdk4W4mat7fHnQ4qL/2a6meL75yJa93/KJVfoXmSlGy09UvO
	 xlz8/Kqu/BGIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/13] ACPI: APEI: GHES: Bound AER info copy and
 sanitize software metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260904172337.1409775-13-dave.jiang@intel.com>
References: <20260904172337.1409775-1-dave.jiang@intel.com>
 <20260904172337.1409775-13-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 18:08:41 +0000
Message-Id: <20260904180842.15A9C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of `aer_capability_regs` allocated from `ghes_estatus_=
pool` in error paths of `aer_recover_queue` and `aer_recover_work_func`.
--

commit 639b51ace1216953e300ae9efcce13516dadf849
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: APEI: GHES: Bound AER info copy and sanitize software metadata

This commit validates the error_data_length in ghes_handle_aer() and ensures
that copying firmware error information into the larger aer_capability_regs
struct does not read out of bounds. It also zeroes out the destination and
properly maps the header log and prefix log to prevent firmware from
manipulating software-only fields.

Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@i=
ntel.com?part=3D3
Fixes: 7e077e6707b3 ("PCI/ERR: Handle TLP Log in Flit mode")

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 2077cc90569a0..08c985e729d6c 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
[ ... ]
> @@ -664,13 +667,25 @@ static void ghes_handle_aer(struct acpi_hest_generi=
c_data *gdata)
>  						  sizeof(struct aer_capability_regs));
>  		if (!aer_info)
>  			return;
> -		memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_regs=
));
> +
> +		/*
> +		 * Map aer_info onto the struct as extlog_print_pcie() does:
> +		 * copy up to the four Header Log DWORDs, then place the TLP
> +		 * Prefix Log from where the hardware keeps it. The rest stays
> +		 * zero, so firmware cannot drive the pcie_print_tlp_log() loop
> +		 * over dw[] out of bounds.
> +		 */
> +		memset(aer_info, 0, sizeof(struct aer_capability_regs));
> +		memcpy(aer_info, pcie_err->aer_info,
> +		       offsetof(struct aer_capability_regs, header_log) +
> +		       PCIE_STD_NUM_TLP_HEADERLOG * sizeof(u32));
> +		memcpy(aer_info->header_log.prefix,
> +		       pcie_err->aer_info + PCI_ERR_PREFIX_LOG,
> +		       sizeof(aer_info->header_log.prefix));
> =20
>  		aer_recover_queue(pcie_err->device_id.segment,
>  				  pcie_err->device_id.bus,
> -				  devfn, aer_severity,
> -				  (struct aer_capability_regs *)
> -				  aer_info);
> +				  devfn, aer_severity, aer_info);

[Severity: High]
This is a pre-existing issue, but does this code leak the newly allocated
aer_info pointer from ghes_estatus_pool if the recovery queue is full or if
the device is not found during workqueue execution?

The memory is allocated from the fixed-size pool earlier in ghes_handle_aer=
():

drivers/acpi/apei/ghes.c:ghes_handle_aer() {
    ...
		aer_info =3D (void *)gen_pool_alloc(ghes_estatus_pool,
						  sizeof(struct aer_capability_regs));
    ...
}

However, in drivers/pci/pcie/aer.c:aer_recover_queue(), if the internal kfi=
fo
is full, the pointer is dropped without being freed:

drivers/pci/pcie/aer.c:aer_recover_queue() {
    ...
	if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
				 &aer_recover_ring_lock))
		schedule_work(&aer_recover_work);
	else
		pr_err("buffer overflow in recovery for %04x:%02x:%02x.%x\n",
		       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
    ...
}

Additionally, in drivers/pci/pcie/aer.c:aer_recover_work_func(), if the tar=
get
PCI device cannot be found (for instance, due to hot-removal), the function
bypasses the pool region free:

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

The continue statement bypasses the subsequent call to
ghes_estatus_pool_region_free(), which leaks the entry.regs pointer. Can th=
is
eventually exhaust the fixed-size ghes_estatus_pool during error storms and
cause subsequent hardware error reports to be silently dropped?

>  	}
>  #endif
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904172337.1409=
775-1-dave.jiang@intel.com?part=3D12
