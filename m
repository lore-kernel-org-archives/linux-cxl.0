Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E1A3DDB01
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788545375; cv=none; b=H+RLYV+M4/9WVr5eYMCMi2xoXyajmZ2oI0yyB8H8iA4B3+Kfv0F5/+H5xTTWcjnmgCH71mtsIlTZ5Mxt3jaDwpR0+TH3MM637607fqjOuT6BJycCX9gUCn7q64xiRw3nW884YDObtb9p5O9n9v7zP9fNhQB+DyucFCmbKF7gGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788545375; c=relaxed/simple;
	bh=jcANQlXYCWZmUGCfIyQlYly27bXxPUu15EkCqYFyKEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EtW7wnhkFwiN5vPf/7Ysj8T1KC1i2xHn3VqHeDEehJIxqY2iQ3bZ/ttwijY1G/M5H4vnmhP26VUr4XWlRx7nCYH0oPn8LOSeMLzaKTZK+1n0F5rCpoU01fAVniB1dm+7fo5p7JjNMeDJQrgwCbRZFMvOpFc+wGgQp6Dcp3CtB7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMGoNzwZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMGoNzwZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5491F00A3D;
	Fri,  4 Sep 2026 18:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788545373;
	bh=YOYF9W9YRVDAqajm1cP0L16ekGRUXGqKrauRAvVD2D8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EMGoNzwZ21gUW3tFD04akDOKkfgJSamVgFjeFavAP/e5HpaT0unIhlGfUgh/CnLNR
	 HMOk+oaniFIthwYAyCWLkVI4MusJV8mtIWWztYO/E/6ljLvioYkqyZXS2bfUUWu1jx
	 +8SGcc6opnr9MAOcgGa9La5lvoRYtgULnmNMwrSoq9pntj2ktvZZXKv9mrgbkcq8Zo
	 Z+PQ4FBMEPQ00/ztOmC/x8uAMW5JW5JxYsuC50Dvx3mLLJxNE5xunDHesupXCaVxlb
	 TvmNrsxE/1z4Z6lI75cQkOgkNoGsZpE1Qxhp6FGjVCXvvINnL390MD/ROXCEpd4YOK
	 PKv8stjU+7w8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/13] efi/cper: Read only validated fields in
 cper_mem_err_pack()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260904172337.1409775-11-dave.jiang@intel.com>
References: <20260904172337.1409775-1-dave.jiang@intel.com>
 <20260904172337.1409775-11-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 18:09:32 +0000
Message-Id: <20260904180933.1C5491F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing minimum length validation for error section payloads in `c=
per_print_mem()` leading to out-of-bounds memory reads if firmware provides=
 a heavily truncated record.
- [High] acpi_extlog silently drops valid UEFI 2.1/2.2 73-byte records.
--

commit de79ea2e5b5e1256b6281744b6c0756366762e76
Author: Dave Jiang <dave.jiang@intel.com>

efi/cper: Read only validated fields in cper_mem_err_pack()

This patch modifies cper_mem_err_pack() to conditionally copy extended, ran=
k,
mem_array_handle, and mem_dev_handle fields based on their validation bits,
preventing out-of-bounds reads when processing 73-byte UEFI 2.1/2.2 records.

Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@i=
ntel.com?part=3D7

> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 3dcef618ad39f..13b3e72c3b62f 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c

[ ... ]

> @@ -389,10 +389,28 @@ void cper_mem_err_pack(const struct cper_sec_mem_er=
r *mem,
>  	cmem->requestor_id =3D mem->requestor_id;
>  	cmem->responder_id =3D mem->responder_id;
>  	cmem->target_id =3D mem->target_id;
> -	cmem->extended =3D mem->extended;
> -	cmem->rank =3D mem->rank;
> -	cmem->mem_array_handle =3D mem->mem_array_handle;
> -	cmem->mem_dev_handle =3D mem->mem_dev_handle;
> +
> +	/*
> +	 * These four sit past the end of the UEFI 2.1/2.2 layout, which older
> +	 * firmware still emits, so reading them unconditionally runs off a
> +	 * short record. Every consumer of the compact record gates them on the
> +	 * same validation bits, so leave them zero when firmware does not
> +	 * claim them.
> +	 */
> +	cmem->extended =3D 0;
> +	cmem->rank =3D 0;
> +	cmem->mem_array_handle =3D 0;
> +	cmem->mem_dev_handle =3D 0;
> +
> +	if (mem->validation_bits &
> +	    (CPER_MEM_VALID_ROW_EXT | CPER_MEM_VALID_CHIP_ID))
> +		cmem->extended =3D mem->extended;
> +	if (mem->validation_bits & CPER_MEM_VALID_RANK_NUMBER)
> +		cmem->rank =3D mem->rank;
> +	if (mem->validation_bits & CPER_MEM_VALID_CARD_HANDLE)
> +		cmem->mem_array_handle =3D mem->mem_array_handle;
> +	if (mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE)
> +		cmem->mem_dev_handle =3D mem->mem_dev_handle;

[Severity: High]
This isn't a bug introduced by this patch, but does this code still perform
out-of-bounds reads if the firmware provides a heavily truncated record?

In cper_print_mem(), if the error data length is between 74 and 79 bytes,
the exact-match length check is bypassed:

    if (len =3D=3D sizeof(struct cper_sec_mem_err_old) &&
        (mem->validation_bits & ~(CPER_MEM_VALID_RANK_NUMBER - 1))) {
            pr_err(FW_WARN "valid bits set for fields beyond structure\n");
            return;
    }

Then, cper_print_mem() calls cper_mem_err_pack() which evaluates the
validation bits without verifying if the length is large enough to cover the
claimed fields. If firmware provides a short record (e.g., 74 bytes) and se=
ts
CPER_MEM_VALID_MODULE_HANDLE, wouldn't we still read out-of-bounds from the
estatus buffer here?

Note that a later patch in this series (commit "ACPI: APEI: GHES: Validate
memory error section length before payload access") fixes this issue in
ghes_do_proc(), but the caller path through cper_estatus_print_section() to
cper_print_mem() appears to miss this length validation.

>  }
>  EXPORT_SYMBOL_GPL(cper_mem_err_pack);

[Severity: High]
This is a pre-existing issue, but since this patch series addresses legacy
73-byte records, does the size check in extlog_print() silently drop valid
UEFI 2.1/2.2 records?

drivers/acpi/acpi_extlog.c:extlog_print() {
    ...
    if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
        struct cper_sec_mem_err *mem =3D acpi_hest_get_payload(gdata);

        if (gdata->error_data_length >=3D sizeof(*mem))
            trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
                                   (u8)gdata->error_severity);
    ...
}

Since sizeof(*mem) evaluates to 80 bytes (the size of the newer struct),
wouldn't this check silently reject 73-byte records and prevent them from
being traced?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904172337.1409=
775-1-dave.jiang@intel.com?part=3D10
