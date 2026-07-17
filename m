Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664F3344DB7
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784316189; cv=none; b=d2EXurDPZ61EjiQPymeuIDO1I9xRlC2m10lDkMZB6vDqMegkx4vNwv09h+H66RTFqzkAeGFn+lt99ppXzH8LxLHFCA1usTBPMTe+4ohxrNtodsu5h4fspaWwD+r9uXACiGkJHoECu1dWfljmMZr/rzBluZsw9AHtWpFfrdkdmAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784316189; c=relaxed/simple;
	bh=CO655sW6M+OohqGD/uMkSR0aNxE/UQKyVTzv+abCE3I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F2OmrYZqlSKGXVh9En5IC+kUEf5TF+sRP3QXCe7jGGIGTqdiJ/ClBFr7sL+jBxs3RxKvmGrfo/EGCIz526dw+Ex2cBkaiIehEu7lF1SrnyhROS9izsvwDanPMREdYtZRyPaAEPRj+n/6ca1uJonAd31QgsPM+BK5LLW9qkEvNSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFtbdNG6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFtbdNG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC9E1F000E9;
	Fri, 17 Jul 2026 19:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784316188;
	bh=hEdLqIUjThBAHEUFnKH/iDMNlk1SF278ofX8ORB86vQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lFtbdNG6c3iwwEZCc1Af4nSpjeGGBfk6Tln9iAiS8YSdYPuVUQbd/eAGmReCxrbp+
	 kvrVhCs8GtbQplSfc6BXsjHT88011e/q5oqN8QXHVaQfNQ2IIPdN/Wziuzw+vw5V5g
	 aJRsGq203O7ZMQESEVz9qf4VHC7Mmcj2yHbZ9bslgPAqYLTgrv9MxhegOpw5/7cErs
	 kRitQzuQydfuYkOR2MUYLrvEwRGD0zuRL7zvlvv/VuPU+xN3CdNnDeIN2rzrF/4JtQ
	 yqn8p5cnXt3dSPamPSiJoe1d9SCaKzqTI03jciIeErJ3Hgk7QI+s6sTU76PAfeyRSe
	 6ZrdaTmuf39hA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/10] ACPI: APEI: GHES: Validate memory error
 section length before payload access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260717161647.1493259-9-dave.jiang@intel.com>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-9-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 19:23:07 +0000
Message-Id: <20260717192307.DAC9E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing payload length bounds checks for PCIe error sections befor=
e payload access in `ghes_handle_aer()`.
- [High] Missing payload length validation in vendor-specific HiSilicon PCI=
e error handler causes out-of-bounds read.
- [High] The `queued` status for synchronous errors is blindly overwritten =
during multi-section generic status blocks.
- [High] Unconditional out-of-bounds read in `cper_mem_err_pack()` for 73-b=
yte legacy memory error records.
- [High] Short memory error records with manipulated validation bits will c=
ause consumers to act on out-of-bounds data.
--

--- Patch [8]: [PATCH v3 08/10] ACPI: APEI: GHES: Validate memory error sec=
tion length before payload access ---
commit 1aac797f010b3f5d2062204450ea2f731ee9a1d5
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: APEI: GHES: Validate memory error section length before payload access

This commit adds a payload length validation for memory error sections
in ghes_do_proc() before allowing report chain consumers to access the
data. The check ensures the length is at least the size of the older
UEFI 2.1/2.2 layout to prevent out-of-bounds reads on truncated
records.

Link: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@int=
el.com?part=3D7

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index b8dbd99da47ef..1d2966a437bdb 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -940,6 +940,17 @@ static void ghes_do_proc(struct ghes *ghes,
>  		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
>  			struct cper_sec_mem_err *mem_err =3D acpi_hest_get_payload(gdata);
> =20
> +			/*
> +			 * Several consumers below dereference the record, so
> +			 * check the length once here. Bound against the shorter
> +			 * UEFI 2.1/2.2 layout that older firmware still emits;
> +			 * the extra fields are only used under validation bits
> +			 * such records leave clear.
> +			 */

[Severity: High]
This isn't a bug introduced by this patch, but it looks like short memory
error records with manipulated validation bits could cause consumers to act
on out-of-bounds data.

The commit message states that trailing fields are only acted on under
validation bits that a short record leaves clear. However, does the length
check in ghes_do_proc() enforce this correlation?

If firmware provides a 73-byte record but sets the validation bits for the
extended fields (e.g., CPER_MEM_VALID_MODULE_HANDLE), will consumers like
ghes_edac and the mc_event tracepoint trust the validation bits and actively
consume the out-of-bounds data packed by cper_mem_err_pack()?

> +			if (gdata->error_data_length <
> +			    sizeof(struct cper_sec_mem_err_old))
> +				continue;

[Severity: High]
This isn't a bug introduced by this patch, but explicitly allowing 73-byte
legacy memory error records appears to cause an unconditional out-of-bounds
read downstream.

The payload is passed to ghes_report_chain consumers, such as ghes_edac.
When ghes_edac_report_mem_error() calls cper_mem_err_pack():

drivers/firmware/efi/cper.c:cper_mem_err_pack() {
    ...
    cmem->extended =3D mem->extended;
    cmem->rank =3D mem->rank;
    cmem->mem_array_handle =3D mem->mem_array_handle;
    cmem->mem_dev_handle =3D mem->mem_dev_handle;
    ...
}

Does this unconditionally copy the trailing 7 bytes? If firmware provides a
73-byte record as permitted by this new check, does this cause an
unconditional out-of-bounds read past the end of the CPER section?

> +
>  			atomic_notifier_call_chain(&ghes_report_chain, sev, mem_err);
> =20
>  			arch_apei_report_mem_error(sev, mem_err);

[Severity: High]
This isn't a bug introduced by this patch, but the queued status for
synchronous errors seems to be blindly overwritten during multi-section
generic status blocks.

In ghes_do_proc(), right after handling the memory error:

drivers/acpi/apei/ghes.c:ghes_do_proc() {
    ...
        queued =3D ghes_handle_memory_failure(gdata, sev, sync);
    } else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
        queued =3D ghes_handle_arm_hw_error(gdata, sev, sync);
    ...
}

If a generic status block contains both a CPER_SEC_PLATFORM_MEM and a
CPER_SEC_PROC_ARM section, does the ARM handler's return value overwrite the
MEM handler's return value? If the MEM error cannot be queued, but the ARM
error is successfully queued, queued becomes true. Could this incorrectly
bypass the force_sig(SIGBUS) fallback for unhandled synchronous errors,
potentially causing an infinite exception loop upon returning to userspace?

[Severity: High]
This isn't a bug introduced by this patch, but missing payload length bounds
checks for PCIe error sections before payload access in ghes_handle_aer() c=
an
lead to out-of-bounds reads.

When ghes_handle_aer() accesses the payload:

drivers/acpi/apei/ghes.c:ghes_handle_aer() {
    ...
    struct cper_sec_pcie *pcie_err =3D acpi_hest_get_payload(gdata);
   =20
    if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID && ...
    ...
}

Does this read pcie_err->validation_bits without checking
gdata->error_data_length? If the firmware provides a truncated PCIe section,
could this read past the bounds? If the out-of-bounds memory contains
valid-looking bits, could it copy 96 bytes of aer_info from out-of-bounds
memory into the AER recovery queue, potentially leaking kernel pool memory =
or
corrupting AER state?

[Severity: High]
This isn't a bug introduced by this patch, but there is a missing payload
length validation in the vendor-specific HiSilicon PCIe error handler.

When hisi_pcie_notify_error() accesses the payload:

drivers/pci/controller/pcie-hisi-error.c:hisi_pcie_notify_error() {
    ...
    const struct hisi_pcie_error_data *error_data =3D acpi_hest_get_payload=
(gdata);
    ...
    if (error_data->socket_id !=3D socket)
        return NOTIFY_DONE;
    ...
}

Does this cast the raw payload and read error_data->socket_id without any
length validation? If the section is empty or truncated, could this read pa=
st
the end of the pool allocation? If socket_id randomly matches, could it
further read up to 132 bytes of out-of-bounds memory based on out-of-bounds
val_bits, leaking kernel pool memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717161647.1493=
259-1-dave.jiang@intel.com?part=3D8
