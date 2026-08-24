Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD09381AE2
	for <linux-cxl@vger.kernel.org>; Mon, 24 Aug 2026 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787594825; cv=none; b=u1soT/VsjLi/oOn5jaxQzhrLrQ7+wmKiDjQD0KPdiP6hR7lqh+RZfsbBU3s46rTpworUHK3HzGzpzP13SvjR3uDYWtM022KRT+CM6NjDhFYTcDHOD/nM7+rzsgKD5VBd2djP53q+V9QR6QJ2TOl+jUdXzuFPSaz9gh6AHYETS6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787594825; c=relaxed/simple;
	bh=eLaNOEUKdXIwZXFun8Zl31NmbihLL+fqQHKYD4ZjNBI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V166E9YsygbvLEo5K6FAE5WSZwqiB09/8hT9rT/HpI0+HUo2qSuVbTP3j/Z8XmOHhU3BzntPnS9Y/btFHdfH89/yls7BqTcfbFi24p6oh5f9zd8kUePKjZfy/26RBbz6Mxv6v6hZ7QUyLSz2kwxqgfFfWm2xanp40RIBXeUrnJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvbK5tEh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvbK5tEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743431F00A3A;
	Mon, 24 Aug 2026 18:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787594823;
	bh=a0DdmAjci23au7yA1JPIDJnkB4FvFo/XhEvaxHlHvnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JvbK5tEhSezzFXKvDpzH3L806UWmsB4K2JDpC9i8BWH4T5Ba75yNFcitWflj6kgZD
	 wkdaKQLl4lIoNVGDDd6dxCZCOfRlv6h3rUbh0iEFwtc4LzbllVNzNTgWZgnDtgn37z
	 L/Ha517KMrrJLafTFT81mqkeC/8uAJ9IwDenfBjuWScotMMAIiRmFEYK2OFAt18vim
	 QoRPk4EmVXcE4AQxaL0eUJsO7dxc7or82FfnCwv/RKDHv7+os+FoHsBgRoVJibD6OZ
	 ELgb23EeSSeuNgJmrB24jyLFhDIUX9lhqNYiytcEX16fD/O1ZyqM+qOJwZhE0WCyd5
	 IP91xnZvPak0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/13] ACPI: extlog: Validate elog record length
 before walking sections
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260824174936.939059-4-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
 <20260824174936.939059-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 18:07:03 +0000
Message-Id: <20260824180703.743431F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] cper_estatus_check() fails to verify remaining data_len before cal=
ling acpi_hest_get_size(gdata), leading to an out-of-bounds read of gdata->=
revision.
- [High] Missing bounds check on physical address provided by firmware, lea=
ding to arbitrary memory read and write.
--

--- Patch [3]: [PATCH v4 03/13] ACPI: extlog: Validate elog record length b=
efore walking sections ---
commit b1da2ee38edf690076a81fda05c21b313452f06b
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: extlog: Validate elog record length before walking sections

extlog_print() copies a fixed 4096 bytes from the elog record into
elog_buf and walks the sections using data_length. This patch rejects
records longer than ELOG_ENTRY_LEN and runs cper_estatus_check() to
validate the records and prevent walking past the buffer.

Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@i=
ntel.com?part=3D6

> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 7ad3b36013cc6..9ad0052aa20c9 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -208,6 +208,10 @@ static int extlog_print(struct notifier_block *nb, u=
nsigned long val,
> =20

[Severity: High]
This is a pre-existing issue, but is the physical address provided by firmw=
are
validated before it is accessed here?

Looking at extlog_elog_entry_check() called earlier in this function:

drivers/acpi/acpi_extlog.c:extlog_elog_entry_check() {
    ...
    data &=3D EXT_ELOG_ENTRY_MASK;
    estatus =3D (struct acpi_hest_generic_status *)ELOG_ENTRY_ADDR(data);

    /* if no valid data in elog entry, just return */
    if (estatus->block_status =3D=3D 0)
        return NULL;

The virtual address computed by ELOG_ENTRY_ADDR() doesn't appear to be
checked against the mapped bounds.

Furthermore, in extlog_print(), this unvalidated pointer is read from and
written to:

drivers/acpi/acpi_extlog.c:extlog_print() {
    ...
    memcpy(elog_buf, (void *)estatus, ELOG_ENTRY_LEN);
    /* clear record status to enable BIOS to update it again */
    estatus->block_status =3D 0;

Could a malformed firmware L1 directory provide an out-of-bounds physical
address, leading to arbitrary memory read and write when extlog_print() cop=
ies
the buffer and clears block_status?

>  	tmp =3D (struct acpi_hest_generic_status *)elog_buf;
> =20
> +	/* Keep the firmware-controlled data_length inside elog_buf. */
> +	if (cper_estatus_len(tmp) > ELOG_ENTRY_LEN || cper_estatus_check(tmp))

[Severity: High]
This is a pre-existing issue, but does cper_estatus_check() have an
out-of-bounds read when verifying the sections?

Looking at cper_estatus_check():

drivers/firmware/efi/cper.c:cper_estatus_check() {
    ...
    apei_estatus_for_each_section(estatus, gdata) {
        ...
        if (acpi_hest_get_size(gdata) > data_len)
            return -EINVAL;

And acpi_hest_get_size() calls acpi_hest_get_version(), which unconditional=
ly
reads gdata->revision:

include/acpi/ghes.h:acpi_hest_get_size() {
    ...
    if (acpi_hest_get_version(gdata) >=3D 3)

If a firmware-provided malformed record contains a section where the
remaining data_len is less than the size of the section header, wouldn't
this dereference memory past the end of the payload?

> +		return NOTIFY_DONE;
> +
>  	if (!ras_userspace_consumers()) {
>  		print_extlog_rcd(NULL, tmp, cpu);
>  		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824174936.9390=
59-1-dave.jiang@intel.com?part=3D3
