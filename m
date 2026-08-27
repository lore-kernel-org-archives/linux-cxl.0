Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B8C375F6C
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 20:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787864130; cv=none; b=j3gqKbNb3PamIPvmadwKUghfaa75tefotS04SrWWIdJuuMU2+GaWpNyYPjr+pXVVpPF5KPdXCAZuyltF3ToDRWFb57gY2bTwTxPIBWuf1J390Zj4bo4NTt+rOLXTknKfcE9V8F7GvIXwtxPX6HjVVOEfdCJ91c8vFELArgWMU5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787864130; c=relaxed/simple;
	bh=lNg6jEwpnHyvyTPBiO+dsdooxn2Kp5JTHGuiIHWRNas=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eDLU4UT0Y6NdZqacUfx1tclQdhLFinyWcb5eOzc8YlFSU/EmgTckFOs2Yi90NRkai2GKvbzeyfZO5cJjhKpaJAoFOdB9dso1DVGNDKu2bY/iJrB0tUxvUucEuie2dxaE0sVN+2FfBwfXAEHrgrGqNJJvP+b7EV2fobEP4k08pNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQcmMbkK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQcmMbkK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796001F00A3A;
	Thu, 27 Aug 2026 20:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787864129;
	bh=TkxERo88gunQ2TIZBF/RtLzflnkOYFlZ6MNG0ZdXQe4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JQcmMbkKx16HSv/AwRsSKWK3UY5vSPeg71logfh654sEta2iQwYV8MBCAlHwWtpL2
	 hYiIAevWRTxsaM9ds2Q2lXo8Oq9TiWtYYI70Ii3CHB1bi9WAtsmAbVZG0HRPuVMUwB
	 uZhGAtRnp4vt/lucxPmumArYzTslgHU/2PScF/HrpKN0yVVe8vyCk2ux3JYnJHJjhF
	 97TMQ984zB1/GzxU1ff8olg3JM48ollzP141GdaySyPtJu75SlLKbvw5OD1EjaGk3O
	 IAMGg3IdPIWV+ECFT479bZD/nTzYbKwWPtgKvnNvk3rgoBL8uJH4Bbph1bzaI4uDpP
	 y+Gpu4biERDeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/13] ACPI: extlog: Validate elog record length
 before walking sections
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260827203726.3027541-4-dave.jiang@intel.com>
References: <20260827203726.3027541-1-dave.jiang@intel.com>
 <20260827203726.3027541-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 20:55:29 +0000
Message-Id: <20260827205529.796001F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `cper_estatus_check()` function performs out-of-bounds memory =
reads when validating a malformed record with truncated section headers.
- [High] The firmware-provided physical address for the error log entry is =
not bounds-checked before being mapped to a virtual pointer, leading to arb=
itrary memory read and write.
--

commit 7b87e88b60eed844f533528aa716b4ef4d19ea04
Author: Dave Jiang <dave.jiang@intel.com>
Subject: ACPI: extlog: Validate elog record length before walking sections

This commit adds bounds checking to extlog_print() to ensure the firmware
provided data length does not exceed ELOG_ENTRY_LEN before walking the
sections. It introduces a call to cper_estatus_check() to perform additional
header and section validation.

Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@i=
ntel.com?part=3D6

> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 7ad3b36013cc6..046e92ee195f9 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -208,6 +208,15 @@ static int extlog_print(struct notifier_block *nb, u=
nsigned long val,
> =20
>  	tmp =3D (struct acpi_hest_generic_status *)elog_buf;
> =20

[Severity: High]
This is a pre-existing issue, but does the lack of bounds checking on the
firmware-provided physical address in extlog_elog_entry_check() allow for
an arbitrary memory read and write here?

When extlog_elog_entry_check() retrieves the physical address, it converts =
it
to a virtual address without verifying that it falls within the mapped
window. If a buggy or malicious firmware supplies an out-of-bounds address,
the resulting virtual pointer will point outside the intended
acpi_os_map_iomem region.

The kernel then dereferences this unvalidated pointer in extlog_print() rig=
ht
above this patch's context:

extlog_print() {
    ...
    memcpy(elog_buf, (void *)estatus, ELOG_ENTRY_LEN);
    estatus->block_status =3D 0;
    ...
}

Could this lead to a fatal page fault or the leakage and corruption of
arbitrary kernel memory?

> +	/*
> +	 * Bound the length before cper_estatus_check() walks the sections: it
> +	 * iterates over data_length, which is not yet known to fit elog_buf.
> +	 * cper_estatus_check_header() then rejects a length that wrapped, which
> +	 * the bound cannot see.
> +	 */
> +	if (cper_estatus_len(tmp) > ELOG_ENTRY_LEN || cper_estatus_check(tmp))

[Severity: High]
This isn't a bug introduced by this patch, but does calling
cper_estatus_check() here perform out-of-bounds memory reads when validating
a malformed record with truncated section headers?

In cper_estatus_check(), the apei_estatus_for_each_section() macro iterates=
 as
long as the current offset is strictly less than estatus->data_length. If a
malformed record leaves a very small remainder (e.g., 1 byte) in data_lengt=
h,
the loop still enters for another iteration.

Inside the loop, acpi_hest_get_size(gdata) is evaluated, which dereferences
gdata->revision (at offset 20) and reads gdata->error_data_length:

cper_estatus_check() {
    ...
    apei_estatus_for_each_section(estatus, gdata) {
        if (check_add_overflow(acpi_hest_get_size(gdata),
                               gdata->error_data_length, &record_size))
            return -EINVAL;
    ...
}

Because the remaining valid data length is smaller than the size of the
generic data header itself, these reads access memory well past the end of
the estatus record.

If the record aligns with the end of a heap allocation (such as the 4096-by=
te
elog_buf used here), reading past the boundary can trigger a page fault if =
the
adjacent page is unmapped.

> +		return NOTIFY_DONE;
> +
>  	if (!ras_userspace_consumers()) {
>  		print_extlog_rcd(NULL, tmp, cpu);
>  		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827203726.3027=
541-1-dave.jiang@intel.com?part=3D3
