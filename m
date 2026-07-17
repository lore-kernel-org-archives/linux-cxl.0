Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D473733F59B
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784318231; cv=none; b=YdMwkcIYvoYS4dbT90sTzN7oJE2NsxBQknyKtI/WJAHZLuVC9dUJcpeE9Ww/3Ev8fg3Fz497Wx853vfYkVaqTC78G/C1AWek/cS+lIwfGjwmrRxDYC9LWzz0NEBfk221FmQDZ9Kgza1GQcdoZJmtwMEkO2y1bfCIDdfFjyg7eB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784318231; c=relaxed/simple;
	bh=NOW2AELnpdb5BnU3z3IRtsxK2zcsVqDAz3WgMuKMUic=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NbGxTO44JuEGJrm5uEpHpes1JKU7nwOe75JrcTaro2TQAb87IbrBSkB5PCrTG7T6bZiFWbJvH1xUjm0rcMMLMLDl7jDG3Bdqp6CxjfMnXf5oCGaYCpQiiig21VUFrxW0T0o2CVPalwKe3VJILCbUG/VeBYpVs2GL3QVTJ3HGBfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIdv+eiC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIdv+eiC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C101F000E9;
	Fri, 17 Jul 2026 19:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784318229;
	bh=r459nW1v67gBcTtIppvenKQG24VEX70o9mdGOEaqrFc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FIdv+eiCHUtuA/Keh4wAaZjoGRWbrKEMRffmegPK3PZr7FErlltWLHmUJvnouSpyp
	 G26ZByORikCtM3fbxJ8NwbItxF7yEmx8LRArudbbKoMvQlXF8ytmCYv76kECU3IbRT
	 eVvzmEKcQrkzFrqW5zlA5q+1TcC9+TcTdQFXrVtZDrUws0qNKtQoqKNvELQy0KOAb7
	 Sc3USn2Vuu0tTMnMaNLNbxLA95xDDvQASD3V5xhXajGIAQu2jpYrivMM8fYZRPSIvm
	 abic3sCoTfoU3FUfjVBq6thikYTJz+XyCC6G33bhoic0f/5t1N8ZTv774oTgMP80WP
	 bw5L8XYkeCfBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/10] ACPI: extlog: Validate elog record length
 before walking sections
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260717161647.1493259-11-dave.jiang@intel.com>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-11-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 19:57:08 +0000
Message-Id: <20260717195709.55C101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The newly added bounds check using `cper_estatus_len()` can be byp=
assed due to an integer truncation, failing to prevent the out-of-bounds re=
ad it was intended to fix.
- [High] An integer overflow in `cper_estatus_check_header()` allows malfor=
med records to bypass the bounds check on 32-bit systems.
- [High] The physical address supplied by firmware is not validated to fall=
 within the memory-mapped `elog_addr` region, allowing out-of-bounds memory=
 accesses.
- [High] The `fru_text` string field within the CPER record is missing a gu=
aranteed null-terminator before being passed to trace events, causing `strl=
en()` to read out of bounds.
--

--- Patch [10]: [PATCH v3 10/10] ACPI: extlog: Validate elog record length =
before walking sections ---
commit a0127a0e48d0e90f30ee3978c528f569d5e624af
Author: Dave Jiang <dave.jiang@intel.com>
Subject: ACPI: extlog: Validate elog record length before walking sections

This commit attempts to fix an out-of-bounds read by adding bounds checks
on the firmware-controlled data_length before walking the elog sections.
Malformed records exceeding ELOG_ENTRY_LEN are now dropped with NOTIFY_DONE
instead of being processed.

Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@i=
ntel.com?part=3D6

> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 1fbaf134c04e3..30863fd3f5b07 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -200,6 +200,13 @@ static int extlog_print(struct notifier_block *nb, u=
nsigned long val,
> =20
>  	tmp =3D (struct acpi_hest_generic_status *)elog_buf;
> =20
> +	/*
> +	 * data_length is firmware controlled, so make sure the record and its
> +	 * sections stay within elog_buf before anything walks them.
> +	 */
> +	if (cper_estatus_len(tmp) > ELOG_ENTRY_LEN || cper_estatus_check(tmp))

[Severity: High]
This is a pre-existing issue in the helper function, but does the 32-bit
truncation in cper_estatus_len() bypass this newly added bounds check?

Looking at cper_estatus_len():

drivers/acpi/apei/apei-internal.h:cper_estatus_len() {
    ...
    return sizeof(*estatus) + estatus->data_length;
}

If a malformed firmware record sets data_length to an extremely large value
like 0xFFFFFFFF, the 64-bit sum evaluates to 0x100000013. Because the
function returns a 32-bit u32, this is implicitly truncated to 19.

Since 19 is not greater than ELOG_ENTRY_LEN (4096), the check passes, and
cper_estatus_check() will validate and loop over the un-truncated large
data_length, allowing the parser to read out of bounds.


[Severity: High]
This is a pre-existing issue, but can malformed records bypass the bounds
check in cper_estatus_check_header() on 32-bit systems?

Looking at cper_estatus_check_header(), which is called by the new
cper_estatus_check() validation:

drivers/firmware/efi/cper.c:cper_estatus_check_header() {
    ...
    if (estatus->raw_data_length &&
        estatus->raw_data_offset < sizeof(*estatus) + estatus->data_length)
        return -EINVAL;
}

On 32-bit architectures, if data_length is close to the 32-bit maximum (e.g=
.,
0xFFFFFFEC), the calculation sizeof(*estatus) + estatus->data_length
overflows to a small value (e.g., 0).

The safety check then evaluates to false and passes, allowing the large
data_length to be used in section parsing and walking past the bounds of the
buffer.

> +		return NOTIFY_DONE;
> +
>  	if (!ras_userspace_consumers()) {
>  		print_extlog_rcd(NULL, tmp, cpu);
>  		goto out;


While reviewing the rest of the file, I noticed a few other pre-existing=20
issues:

[Severity: High]
This is a pre-existing issue, but could a corrupted firmware physical addre=
ss
lead to accessing arbitrary kernel memory?

In drivers/acpi/acpi_extlog.c:extlog_elog_entry_check():

    data &=3D EXT_ELOG_ENTRY_MASK;
    estatus =3D (struct acpi_hest_generic_status *)ELOG_ENTRY_ADDR(data);

    /* if no valid data in elog entry, just return */
    if (estatus->block_status =3D=3D 0)

The physical address data is read directly from the firmware-controlled L1
directory and translated into a virtual address via pointer arithmetic agai=
nst
the elog_addr mapping.

There appears to be no bounds check to ensure the address falls within the
intended elog_base and elog_size region. If firmware supplies a corrupted
address, the resulting pointer will be out-of-bounds, causing a potential
kernel panic upon dereferencing block_status.


[Severity: High]
This is a pre-existing issue, but is it possible for the tracepoint to read
out of bounds when processing the non-terminated fru_text string?

In drivers/acpi/acpi_extlog.c:extlog_print():

    if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
        fru_text =3D gdata->fru_text;
    ...
    trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
                           (u8)gdata->error_severity);

The fru_text string is extracted from a fixed 20-byte array without
enforcing a null terminator.

Since the tracepoint implicitly calls strlen() on fru_text, a firmware
record filled with non-null characters could cause strlen() to read out of
bounds into adjacent kernel heap memory, leaking memory contents to the
tracing infrastructure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717161647.1493=
259-1-dave.jiang@intel.com?part=3D10
