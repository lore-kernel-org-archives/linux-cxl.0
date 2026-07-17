Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616762F5313
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784308151; cv=none; b=U0Ab9T8RPQ/Ad/XidSPdWGZAMw2QcIASXNe6Q20u7yaBVtFSPOwoeGSh30cLRGLjCRL6vdC2tPHT4xVc9mRA+PjpPM1boZePr5EA9GwjGBipKfRQsTgifzWnI8HbCfPgbu9cvLkUzo9UTpszayDKZwDp7wS3ENITgtPQhgjLYMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784308151; c=relaxed/simple;
	bh=oWb3fSY9wMYhXemYhVmWCHhYTT1qTeb28hnt46L+bqQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ijVOYYNyzmqy1fSCw1/SyrMPd/kyKmsZPP3sGIUP3b1Ejr3USPlCrn483kc6Omy7DmZ5c2pGatFxgL71T7OFMm/zC8mj+vt+4qYKiV1hHHEeCMb4MNbvCB0dvh/WtCOr4nbvEIFfWqpH+NnS/1fYN8LV3V6Dypa76j96GkblpME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b77IF7iv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b77IF7iv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60F21F000E9;
	Fri, 17 Jul 2026 17:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784308150;
	bh=MiDNsHHh1sXQP+0MKR2MzXlxp0QYtGROmZaOfPKbQP0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b77IF7iv5+HbSBpegEhb8/AgNXYG5SIepA2EnWMu8sifu7xeGrESp7rDnv0lU/+La
	 q+HAGDO4/nPqf1IeIDhOsBDWO3MUEVrLFvp/u7oGtyLP3Vu8QAoj37f0KqriGqxMTg
	 xCC3XbM0oUJ7QKk4WMCZHcmWZLiSmWY/WdEA1B9oZ6UpG32u1FGuS27sxgcYHmcUF1
	 uz6FyuJP3jgA7/DSLFLpu/4a+FpCef/Djws0MnV5yN1ns8he6SbuKFF5hBPxkTEtYI
	 Z17ieR7zStt6Et7SZe3Y4bcYO+Tkjn+In4m/ELPoDDId8gzrOl7twa4+Na8OXJ2yud
	 YEGSvep5DSIzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/10] ACPI: APEI: GHES: Bound CXL event record copy
 to the firmware section length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260717161647.1493259-2-dave.jiang@intel.com>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 17:09:09 +0000
Message-Id: <20260717170909.D60F21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes an out-of-bounds read in cxl_cper_post_event(), bu=
t fails to apply a similar bounds check to the adjacent CXL Protocol Error =
handler for CPER_SEC_CXL_PROT_ERR.
- [High] Missing bounds checks for CPER_SEC_CXL_PROT_ERR and CPER_SEC_PCIE =
in the ACPI Extended Error Log (acpi_extlog.c), leading to out-of-bounds re=
ads.
- [High] Missing bounds check for HISI PCIe vendor-specific error records, =
causing an out-of-bounds read.
- [High] Spinlock deadlock in CXL CPER work queue registration functions du=
e to failure to disable interrupts.
--

--- Patch [1]: [PATCH v3 01/10] ACPI: APEI: GHES: Bound CXL event record co=
py to the firmware section length ---
commit 36a126e36333bbe9036612ec43459f24c942a9bb
Author: Dave Jiang <dave.jiang@intel.com>
Subject: ACPI: APEI: GHES: Bound CXL event record copy to the firmware sect=
ion length

This commit addresses an out-of-bounds read of the firmware CPER section by
adding bounds checking for CXL event records. It updates cxl_cper_post_even=
t()
to verify that the payload length matches expected structure sizes.

Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_i=
nternal_review-v6-0-91f725174aa0@arm.com?part=3D6

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3236a3ce79d6b..a752e152a5a0b 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -949,15 +954,18 @@ static void ghes_do_proc(struct ghes *ghes,
>  		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
>  			struct cxl_cper_event_rec *rec =3D acpi_hest_get_payload(gdata);
> =20
> -			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec);
> +			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec,
> +					    gdata->error_data_length);
>  		} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
>  			struct cxl_cper_event_rec *rec =3D acpi_hest_get_payload(gdata);
> =20
> -			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec);
> +			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec,
> +					    gdata->error_data_length);
>  		} else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
>  			struct cxl_cper_event_rec *rec =3D acpi_hest_get_payload(gdata);
> =20
> -			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
> +			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec,
> +					    gdata->error_data_length);
>  		} else {
>  			void *err =3D acpi_hest_get_payload(gdata);
> =20

[Severity: High]
This is a pre-existing issue, but does CPER_SEC_CXL_PROT_ERR also need a
similar bounds check in ghes_do_proc()?

The payload is passed to cxl_cper_post_prot_err() without validating the ou=
ter
section length:

drivers/acpi/apei/ghes.c:ghes_do_proc()
  else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
      struct cxl_cper_sec_prot_err *prot_err =3D acpi_hest_get_payload(gdat=
a);
      cxl_cper_post_prot_err(prot_err, gdata->error_severity);
  }

Then in cxl_cper_setup_prot_err_work_data(), an out-of-bounds copy can occur
based on an unvalidated dvsec_len:

drivers/acpi/apei/ghes_helpers.c:cxl_cper_setup_prot_err_work_data()
  cap_start =3D dvsec_start + prot_err->dvsec_len;
  memcpy(&wd->ras_cap, cap_start, sizeof(wd->ras_cap));

Could an untrusted firmware payload lead to an out-of-bounds read here?

[Severity: High]
This is a pre-existing issue, but are there missing bounds checks in other
consumers of these error records, like drivers/acpi/acpi_extlog.c?

In extlog_print(), the payload for CXL protocol errors is passed without
checking if gdata->error_data_length is large enough:

drivers/acpi/acpi_extlog.c:extlog_print()
  extlog_cxl_cper_handle_prot_err(prot_err, gdata->error_severity);

Similarly, in extlog_print_pcie(), the payload is dereferenced directly:

drivers/acpi/acpi_extlog.c:extlog_print_pcie()
  if (!(pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID && ...))

Could this result in out-of-bounds reads if the firmware provides truncated
payload sections?

[Severity: High]
This is a pre-existing issue, but does hisi_pcie_notify_error() in
drivers/pci/controller/pcie-hisi-error.c also lack bounds checking for
vendor-specific error records?

The payload from gdata is directly cast and dereferenced without ensuring
gdata->error_data_length covers the structure:

drivers/pci/controller/pcie-hisi-error.c:hisi_pcie_notify_error()
  if (error_data->socket_id !=3D socket)

Could a malformed firmware error record cause an out-of-bounds read here?

[Severity: High]
This is a pre-existing issue, but is there a potential spinlock deadlock in
the CXL CPER work queue registration functions?

In cxl_cper_register_work(), the lock is acquired without disabling interru=
pts:

drivers/acpi/apei/ghes.c:cxl_cper_register_work()
  guard(spinlock)(&cxl_cper_work_lock);

If a hardware error interrupt fires on the same CPU while the lock is held,
the interrupt handler calls cxl_cper_post_event(), which attempts to acquire
the same lock:

drivers/acpi/apei/ghes.c:cxl_cper_post_event()
  guard(spinlock_irqsave)(&cxl_cper_work_lock);

Could this cause a deadlock if the interrupt occurs when the driver is
registering the work queue?

A similar issue appears in cxl_cper_register_prot_err_work() with
cxl_cper_prot_err_work_lock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717161647.1493=
259-1-dave.jiang@intel.com?part=3D1
