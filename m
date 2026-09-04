Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B1850C29E
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788543503; cv=none; b=ElSttT2oLLvbTCptdvXMU7UMYjuJE4rFfeCaT1laxDCnPMR4B1zGd1hHUjdJiS0HXYoXjtsWoA+MIGRX+uuqzUvGM8J1qbKCx4vW1qa+aomyAYpwKiMswijdxcSgGBNt+IV4bv3Qbz3I/hX6kkrxRi2xNpidP5WRN/mxQ59tmqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788543503; c=relaxed/simple;
	bh=vCyDTCeZ+U+rA6ofQr0rnRHRcq4BVR2XcwLsBr1VlzQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oPxO+Y579ZA4cR4bC21rj1zs50QqhrUF4S23yvxH4cZ3yzSTMtBgYBAUwn9Ktqdj3HGDixDVwG1L8euRWeJYdFae2kVSJsyO+HLpUW6PhnLugPua4T6zPgrvyD5pYODXABdPgHgqK5I+tOxPnSU2aSGKXpnnLLCVQvAMMZ8wnpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGMb1EiF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGMb1EiF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823D61F00A3D;
	Fri,  4 Sep 2026 17:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788543501;
	bh=DhmIPqJGaJh7HuR1WrJRXeDsniaLgYCTL/zYif5140w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IGMb1EiFcsXVb3Y2pMVZ3QmyIYJUnpUah19JwqqI6o4g4bLrm3Nm5PC+qoSep9Nem
	 qHI8gpv+ZNm4FrRHwdn3BOF3L2PsVbMySYVaQQFkFmsa+G0vxyb+C54/baksJSS+Oh
	 GBbehAXxWwfdjObS+Qm9VrD5vpOoB+JAahQfCzgGcpgUzg6aK6/JbgQoknHCruDAlE
	 I2UAbglFZUZpC7C9sA2KIy/GRQX8dodJwX/yY255HpLxvOBPCz2cWIxsyPT6ghpcfw
	 TZ4R22uG5Q5zFqmSGyRzD+ViZXfwmLHFqwJLTh7BicPmEi0DiK8eC3iSZyamqBWD7C
	 j5nxYC3w2Krtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/13] efi/cper: Reject an error status block length
 that wraps a u32
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260904172337.1409775-3-dave.jiang@intel.com>
References: <20260904172337.1409775-1-dave.jiang@intel.com>
 <20260904172337.1409775-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 17:38:21 +0000
Message-Id: <20260904173821.823D61F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds read in CPER error status validation due to insuffic=
ient remaining length check
--

commit 397f02447210fe6eca20cec521b708fca415a921
Author: Dave Jiang <dave.jiang@intel.com>

efi/cper: Reject an error status block length that wraps a u32

cper_estatus_len() sums the firmware-controlled data_length into a u32,
which can wrap to 0. This patch rejects a length that cannot be expressed in
a u32 in cper_estatus_check_header() to prevent callers from receiving a
short value.

Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@i=
ntel.com?part=3D1

> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 332c78f2d5617..3dcef618ad39f 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -745,6 +745,17 @@ int cper_estatus_check_header(const struct acpi_hest=
_generic_status *estatus)
>  	    estatus->raw_data_offset < sizeof(*estatus) + estatus->data_length)
>  		return -EINVAL;
> =20
> +	/*
> +	 * cper_estatus_len() sums these into a u32, and a wrapped sum reads
> +	 * back smaller than the record. Reject a length that cannot be
> +	 * expressed so no caller is handed the short value.
> +	 */
> +	if ((u64)sizeof(*estatus) + estatus->data_length > U32_MAX)
> +		return -EINVAL;
> +	if (estatus->raw_data_length &&
> +	    (u64)estatus->raw_data_offset + estatus->raw_data_length > U32_MAX)
> +		return -EINVAL;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(cper_estatus_check_header);

[Severity: High]
This isn't a bug introduced by this patch, but while looking at validation
for estatus->data_length here, I noticed an out-of-bounds read issue in how
the sections are parsed by cper_estatus_check().

If firmware provides an estatus block where the data_length leaves between 1
and 63 bytes (smaller than sizeof(struct acpi_hest_generic_data)) after a
valid section, the apei_estatus_for_each_section() loop will erroneously
enter another iteration due to its boundary condition:

include/acpi/ghes.h:apei_estatus_for_each_section()
	for (section =3D (struct acpi_hest_generic_data *)(estatus + 1);	\
	     (void *)section - (void *)(estatus + 1) < estatus->data_length; \
	     section =3D acpi_hest_get_next(section))

The subsequent access to acpi_hest_get_size(gdata) and
gdata->error_data_length in cper_estatus_check() will then read past the
valid data_length.

drivers/firmware/efi/cper.c:cper_estatus_check()
	apei_estatus_for_each_section(estatus, gdata) {
		int record_size;

		if (check_add_overflow(acpi_hest_get_size(gdata),
				       gdata->error_data_length, &record_size))
			return -EINVAL;

A heap out-of-bounds read here can cause a page fault in MCE or NMI context,
leading to a fatal machine check (kernel panic).

Could we tighten the apei_estatus_for_each_section loop boundary or add a
check in cper_estatus_check() to ensure the remaining data_length is at
least the size of a section header before allowing the next iteration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904172337.1409=
775-1-dave.jiang@intel.com?part=3D2
