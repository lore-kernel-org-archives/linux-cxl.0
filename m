Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553AB372677
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309188; cv=none; b=aF9QIJkNlGatiIXkBvZMCJMa5KYLapX4uARAGzFACphLBhKilzMgpq6CYWw2ixk44YTsLRtHdQRntHQC1gW19sBqEbSVXpDwsGHOa80hhixC2NZZOgFTPPQ06Cw0JUN3oKv189du71R58HqxOd+LLZ/XAArnv/+m8mwM+0MK678=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309188; c=relaxed/simple;
	bh=k/axJe+KH08p4p+NHXzco0egtjIf+Li82Q6WNaJKlAk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BxODi+F1NZ8dwriMHR45ykZIMkx9U8coTSilohZruLDRdIlrxkv3CKDcjAbzaisAFZisw11OptQ9x97xKQ1QeKGGbA0fuGKp7GHFEiC7I6X55OMbxtgC3QI1Z9/rcO3tfwbR+1ys7YHK75FQOkpIX10FFXU2ZmU2BHEVdX/ts/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSS/Oz1+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSS/Oz1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77E41F000E9;
	Fri, 17 Jul 2026 17:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784309186;
	bh=hP9OVzsbuCVV/EweXU8WVt/+Ki/P7YNiI6OQIjw54ws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LSS/Oz1+RKQ5A/DVMdq3iZwyEXzVAktyXMzpACvqE87EWDX3Gj3twItQb97A+h7/8
	 Y2c1oraOw8iGixYO9PTulDZxOELNIS74lVQ7Bqz/GQ706AZKVP7qnN+5X7OghO4F1q
	 hjoT/uZw3ItppaiEyYqxaXebH16soOAR4kuMIKpqIZfBn4/aKFBb88EAhYDgIfATAO
	 KYVkYFcof14Nlpglww6gFohFkJODyZu5hrH4jYF11MuPxS6N1DqpXLtUn18Xd3J6Du
	 1+KIRGc7ceGsAmbROmQHY/L0Kti/T0EUDfIg8PwWQF0KqKkFQbII6Y4hspE/jIcbf5
	 L5wd5Iga6+0Ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/10] efi/cper: Reject CPER records with an
 out-of-range error_data_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260717161647.1493259-3-dave.jiang@intel.com>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 17:26:26 +0000
Message-Id: <20260717172626.A77E41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `extlog_print` path iterates over CPER sections without valida=
ting the firmware data bounds or lengths, leaving it vulnerable to out-of-b=
ounds reads and integer overflows.
- [High] A malformed CPER record with trailing bytes less than the size of =
a section header causes an out-of-bounds read in `cper_estatus_check()`.
--

--- Patch [2]: [PATCH v3 02/10] efi/cper: Reject CPER records with an out-o=
f-range error_data_length ---
commit dc1e1608d652687fa8e464b2ae6a04fa5c4f8848
Author: Dave Jiang <dave.jiang@intel.com>

efi/cper: Reject CPER records with an out-of-range error_data_length

This commit fixes an integer overflow vulnerability in the shared CPER leng=
th
check. It ensures that error_data_length is not negative and does not exceed
the remaining data length before size arithmetic.

Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@i=
ntel.com?part=3D1

> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 06b4fdb59917a..99a86b2675e39 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -765,6 +765,16 @@ int cper_estatus_check(const struct acpi_hest_generi=
c_status *estatus)
>  		if (acpi_hest_get_size(gdata) > data_len)
>  			return -EINVAL;
> =20

[Severity: High]
This is a pre-existing issue, but could the acpi_hest_get_size() call perfo=
rm
an out-of-bounds read if data_len is very small?

If a malformed record leaves a small number of trailing bytes (for example,
data_len drops to 1), the iteration macro continues because the section
offset is still less than the total data_length.

The acpi_hest_get_size() helper calls acpi_hest_get_version(), which
dereferences gdata->revision at offset 20. Would this read memory past the
end of the validated CPER data region before we check if data_len is large
enough to contain the generic header itself?

[Severity: High]
This isn't a bug introduced by this patch, but is the extlog_print() path
bypassing these safety checks entirely?

Looking at extlog_print(), it iterates over CPER sections without validating
the firmware data bounds:

drivers/acpi/acpi_extlog.c:extlog_print() {
    ...
    tmp =3D (struct acpi_hest_generic_status *)elog_buf;
    ...
    apei_estatus_for_each_section(tmp, gdata) {
    ...
}

It copies up to ELOG_ENTRY_LEN (4096) bytes of estatus from firmware into
elog_buf, but doesn't appear to call cper_estatus_check() to validate it.

If firmware provides a data_length > 4096, will this loop read past the
bounds of elog_buf? Furthermore, does this leave the unvalidated path
vulnerable to the same error_data_length integer overflow issue being fixed
here?

> +		/*
> +		 * error_data_length reaches record_size below as a signed int
> +		 * (see <acpi/ghes.h>), so a value with the sign bit set can
> +		 * wrap record_size small and slip past the bound check. Reject
> +		 * it before the arithmetic.
> +		 */
> +		if (acpi_hest_get_error_length(gdata) < 0 ||
> +		    acpi_hest_get_error_length(gdata) > data_len)
> +			return -EINVAL;
> +
>  		record_size =3D acpi_hest_get_record_size(gdata);
>  		if (record_size > data_len)
>  			return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717161647.1493=
259-1-dave.jiang@intel.com?part=3D2
