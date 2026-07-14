Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD21F369991
	for <linux-cxl@vger.kernel.org>; Tue, 14 Jul 2026 23:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072762; cv=none; b=go85aa0tTcFctfBNQi1XlnNjUIO2gQMuApuFpklTJdIFvGbiH1NfVomV+AS7WcIF7vsVHVRGKw3f3VDbeFy33hTEp55nPZ3zV1dELihy+zuiWiloyEyeIk4hxLgcnOe0/2Iv5LL+PrcaNa+i2Oq2M1fO/omNerSq0s+UZoLHuao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072762; c=relaxed/simple;
	bh=AdBlnS5W7l6ElqUUCT68eZYvAzBPILh++K4w0QaeKbY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tJVdehM+qr7tsFLr9NK0X73KQlXhQVj3EwSirahz0Zz+7K5/Lxqhj4hQcTpiKqqSHIfumsp6dNY6pcDQpUqbET5t53ovQlrd/QO20TbS3d8okxkevM7Xj6PClqOMFD4PjcZzqpK4FgBX23uFbxW2pEjvjWfm8nVFLlAqQ4yh8Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqSLmg2e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqSLmg2e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604991F000E9;
	Tue, 14 Jul 2026 23:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784072760;
	bh=QG7H/+uaaT/rd39SzVJQXo1133ZH2U0q9FwfFpMDQk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QqSLmg2ePLRDOqt/YTy1guPU+3WEOz1+3q0nGthzs8RSrlbWHpAy9O5PZuiSmeiK1
	 V1GUnQnR90pCx/FG/Nzcfz4kLwjM5EizzCT3/UgDeN0i3DBgZAkKtY440t+4Q683Ch
	 qEJxHcmPwbt8t7bD4wICzwlwdpcA5ZCctE04KHKABResJtAVLvMbPwFPqDx3HlYXyV
	 Nwdt7/pLqgaXCZdouHvSlfBv3/lirmON7W1SaBMT0duUP59jNwSbTI6saX1BCP33Z7
	 4NIMlWlH1KyVj7BkGNkOnZ/yQVtIKPOldMBV0mDbi9G9CEWChXPqSTTY2X0k5vZGj2
	 FbBfpfytQHy7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] ACPI: extlog: Validate PCIe error section length
 before payload access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260714231835.303081-5-dave.jiang@intel.com>
References: <20260714231835.303081-1-dave.jiang@intel.com>
 <20260714231835.303081-5-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 23:45:59 +0000
Message-Id: <20260714234600.604991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Other APEI/GHES CPER payload handlers lack error_data_length valid=
ation before accessing payload structs.
- [High] Hardware PCIe AER capability layout is blindly copied into a softw=
are structure, causing severe field misalignment and OOB reads.
--

--- Patch [4]: [PATCH v2 4/7] ACPI: extlog: Validate PCIe error section len=
gth before payload access ---
commit e17a8b52722d296c5c160626ff1eb6bdf1232531
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: extlog: Validate PCIe error section length before payload access

extlog_print_pcie() reads pcie_err->validation_bits and device_id and
copies the fixed 96-byte pcie_err->aer_info buffer without first checking
that gdata->error_data_length is large enough to hold a struct
cper_sec_pcie.

> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index fbc88c584c067..0c440d75d9a78 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
[ ... ]
> @@ -145,6 +145,9 @@ static void extlog_print_pcie(struct cper_sec_pcie *p=
cie_err,
>  	int aer_severity;
>  	int domain;
> =20
> +	if (len < sizeof(*pcie_err))
> +		return;
> +
>  	if (!(pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
>  	      pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO))
>  		return;

[Severity: High]
This is a pre-existing issue, but does this code correctly handle the
hardware PCIe AER capability layout?

When copying the hardware aer_info (a 96-byte raw CPER array) into the
software struct aer_capability_regs in extlog_print_pcie(), it appears the
software structure expands header_log to 60 bytes to support 14 DWORDs and
prefix arrays, while the hardware TLP log is only 16 bytes.

drivers/acpi/acpi_extlog.c:extlog_print_pcie() {
    ...
    memcpy(&aer_regs, pcie_err->aer_info, sizeof(pcie_err->aer_info));
    ...
}

Does this cause hardware fields starting from root_command to overlap with
header_log.dw[4], losing the root status information and misinterpreting
them as TLP prefixes?

This same misalignment appears to occur in other places too:

drivers/acpi/apei/ghes.c:ghes_handle_aer() {
    ...
    memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_regs)=
);
    ...
}

In ghes_handle_aer(), does copying sizeof(struct aer_capability_regs)
(100 bytes) from a 96-byte array cause a 4-byte out-of-bounds read?

And also blindly casted in CPER:

drivers/firmware/efi/cper.c:cper_print_pcie() {
    ...
    aer =3D (struct aer_capability_regs *)pcie->aer_info;
    ...
}

[ ... ]
> @@ -247,7 +250,8 @@ static int extlog_print(struct notifier_block *nb, un=
signed long val,
>  		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
>  			struct cper_sec_pcie *pcie_err =3D acpi_hest_get_payload(gdata);
> =20
> -			extlog_print_pcie(pcie_err, gdata->error_severity);
> +			extlog_print_pcie(pcie_err, gdata->error_severity,
> +					  gdata->error_data_length);

[Severity: High]
This isn't a bug introduced by this patch, but do other APEI/GHES CPER
payload handlers also lack error_data_length validation before accessing
payload structs?

If firmware provides a CPER payload with an artificially small
error_data_length, could we experience out-of-bounds reads in
ghes_handle_memory_failure()?

drivers/acpi/apei/ghes.c:ghes_handle_memory_failure() {
    ...
    struct cper_sec_mem_err *mem_err =3D acpi_hest_get_payload(gdata);

    if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
    ...
}

Does this risk operating on garbage physical addresses or adjacent
uninitialized padding?

Similarly, in ghes_handle_aer() without a length check:

drivers/acpi/apei/ghes.c:ghes_handle_aer() {
    ...
    struct cper_sec_pcie *pcie_err =3D acpi_hest_get_payload(gdata);

    if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID)
    ...
}

Would adding length validation similar to this patch be needed for those
other handlers as well?

>  		} else {
>  			void *err =3D acpi_hest_get_payload(gdata);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714231835.3030=
81-1-dave.jiang@intel.com?part=3D4
