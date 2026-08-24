Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8D8370AFD
	for <linux-cxl@vger.kernel.org>; Mon, 24 Aug 2026 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595043; cv=none; b=s4K7HtTEUQLxEi95edNuLy+tNWYSJqsLDefPTDdAUuI4yUoWcnV7ntwdJdSnn91IsfE2s0U/KDEBMviJ24jiGCNCLAdGZJGUX53GZ/WIT5T7haXF67kDk5soFgYJIP5O9lF58d6Huw+gUZLYcvoJUqwKsjBZHyW46X6HApt0Cr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595043; c=relaxed/simple;
	bh=kGYd2XTZuKXShasOeYIELerXf18PJrGVSl1CmRr3isY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sRt86AKsGaIMqwlx/QJjs8XWwJuQ+OVxVloRLk0Lf6yXJOo375TjDp9GsyLajTXz+2UbAmiRyqHrUGcW+AXJSmBjkjp/uZdDDI3/XWzUnYmxW4aXi7+Iy0O40vf53aXZOOTPJGDVWgjIL13nKKYONZ+1h1QvQC4Y67MzUUueiBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTKonjzh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTKonjzh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB301F000E9;
	Mon, 24 Aug 2026 18:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787595041;
	bh=2zMTWuZbMxvWV/pKIE6A+zGDFxBL/wZd/QZ3KMSTAFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NTKonjzhzt7JLMaayR2grxNOTJQFv/IS2yZ9y2EUmav/0kndNcVVe4Td/yFweaPlN
	 5DIfLBadD5xbhYvl7awSdQaDpQHmV12p+3Tco3OTEaCjt6yVaR0jFJpgPYAcFJX+Gf
	 Jx1CU+blttLYF42m7HWhd2RMK475Qwok7uWRuVxx34sQUYsW/VxPOxPvVpFTYiehsP
	 epZxstpbRfike0Hu86QZr8vzpsTYIPo37+GttespzATq666WJLwkXeAOuGMocIzvOq
	 A1u4ToCKMfHUbk/6tWUU+NR2RSDi4HhnAItE8lMNhVEqcPyhXxLySccQTQ30OoWdVU
	 e3Olj9vUPkZOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/13] efi/cper: Reject CPER records with an
 out-of-range error_data_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260824174936.939059-2-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
 <20260824174936.939059-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 18:10:40 +0000
Message-Id: <20260824181041.4AB301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Time-of-Check to Time-of-Use (TOCTOU) double-fetch vulnerability i=
n GHES record parsing allows bypassing length validation.
- [Medium] Out-of-bounds read in CPER record validation due to partial trai=
ling sections.
--

--- Patch [1]: [PATCH v4 01/13] efi/cper: Reject CPER records with an out-o=
f-range error_data_length ---
commit b61df2c17060fd5f4040a122aa6b8bc641dbf1f3
Author: Dave Jiang <dave.jiang@intel.com>

efi/cper: Reject CPER records with an out-of-range error_data_length

This patch prevents acpi_hest_get_record_size() from wrapping small when
adding a large error_data_length. By performing the arithmetic in u64, it
ensures the size check against data_len catches oversized records correctly.

Link: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@int=
el.com?part=3D1

> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 06b4fdb59917a..ec092729caccb 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -752,7 +752,7 @@ EXPORT_SYMBOL_GPL(cper_estatus_check_header);
>  int cper_estatus_check(const struct acpi_hest_generic_status *estatus)
>  {

[Severity: High]
This is a pre-existing issue, but does cper_estatus_check() lack sufficient
context to prevent an out-of-bounds read if the record is modified
concurrently?

When drivers/acpi/apei/ghes.c:ghes_in_nmi_queue_one_entry() allocates the
buffer, it sizes it exactly to a peeked length. Then it fetches the record a
second time from physical memory via __ghes_read_estatus():

    ghes_copy_tofrom_phys(estatus, buf_paddr, buf_len, 1, fixmap_idx);
    if (cper_estatus_check(estatus)) {

If the data_length is maliciously increased in physical memory between these
fetches, the newly copied header will contain an unvalidated length. Because
cper_estatus_check() doesn't verify the length against the originally peeked
allocation size, the loop below can iterate far beyond the bounds of the
allocated buffer.

Would it be possible to pass max_len into cper_estatus_check() to re-verify
it against the newly fetched data_length?

>  	struct acpi_hest_generic_data *gdata;
> -	unsigned int data_len, record_size;
> +	unsigned int data_len;
>  	int rc;

[ ... ]

> @@ -762,11 +762,21 @@ int cper_estatus_check(const struct acpi_hest_gener=
ic_status *estatus)
>  	data_len =3D estatus->data_length;
> =20
>  	apei_estatus_for_each_section(estatus, gdata) {
> +		u64 record_size;
> +
>  		if (acpi_hest_get_size(gdata) > data_len)
>  			return -EINVAL;

[Severity: Medium]
This is a pre-existing issue, but does this loop safely handle trailing
partial sections?

If a malformed CPER record leaves fewer than the required bytes for the
header, calling acpi_hest_get_size(gdata) here will read gdata->revision
beyond the end of the estatus payload before checking against data_len.

Also, in include/acpi/ghes.h, apei_estatus_for_each_section() advances using
acpi_hest_get_next(section). Since the loop update calls
acpi_hest_get_record_size() which calls acpi_hest_get_size(), it could
similarly read out of bounds before the loop terminates if the remaining
data_len is too small.

Could data_len be checked against the minimum section header size before
attempting to access gdata fields?

> -		record_size =3D acpi_hest_get_record_size(gdata);
> -		if (record_size > data_len)
> +		/*
> +		 * acpi_hest_get_record_size() sums these as a signed int (see

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824174936.9390=
59-1-dave.jiang@intel.com?part=3D1
