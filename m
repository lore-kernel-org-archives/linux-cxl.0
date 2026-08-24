Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9992C21E8
	for <linux-cxl@vger.kernel.org>; Mon, 24 Aug 2026 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787594588; cv=none; b=NbapGo5gxQnXf740V3d6sTHZdJNRslqaHEwaXS5LKUVYmBK/xIWi80UTcl0+VTVqO5w01aMhWNEx7s5lmGceWXv6cOViYSxpg+IBB8pNzFaGfQfBblH6nFOx8XfAyF5e+C+4Q8GNCCGxM+mgfWJ1yaVbHwYxwrDQUARnyP8KfHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787594588; c=relaxed/simple;
	bh=1Lm5GXhgPkRdo2kcUTy1XNZdxamab3DRrypYpPLB330=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tazSB6jgeKwd6ZCBo3x3yKwyte11AEJ41kT61bWZg4W6RdZfT/zljnOgp2bvnu7J2HkmQJVKxVnGT3SbZwVDKlhGpCZlzQ5XnbWUT4YMdIZmEAr97Du9sTXItwTMkCkrCjnYpiaVkrvQPyl/uJ0ge5mpWH194gEvHE+znlBjuzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QL/rRDBN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QL/rRDBN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7A51F000E9;
	Mon, 24 Aug 2026 18:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787594587;
	bh=sdKoGIXK6ysAJIMWk3gAB0Tm4p5kR86f5mHfqY7nQ9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QL/rRDBNaiqWAvaMoV0J3uVOUuoYXT9WfqeCiV7whXDp58o/mI5WoESuFwltZSAXz
	 E8A02v2t4TRgFfFF52pUa24v6lp35G2e0+bby16yFC2irgUaDgAMk6Xm/QUtX1Cbli
	 GDc0vUmphq+HSml5LkOKmXo1qVEeMuTUTUH0+/pO1uXEa87r5ksoe6mHga/X3mD5Om
	 LPEpvhzYcBeGjDEpvmM5VVkn740ayjJU3Uj+4sBKnPzwQnVlGNzOQEqiZB+z/HS9pT
	 hWVL8760MzwelkJBkyPr6z5uNO8D/HbJDB3nEHQjLRqDFpaMha6Gt0B18DqesR+Pvh
	 Cu2yavQqrqzxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/13] efi/cper: Reject an error status block length
 that wraps a u32
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260824174936.939059-3-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
 <20260824174936.939059-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 18:03:06 +0000
Message-Id: <20260824180307.0A7A51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check before reading section header fields in cper_=
estatus_check(), leading to an out-of-bounds read.
--

--- Patch [2]: [PATCH v4 02/13] efi/cper: Reject an error status block leng=
th that wraps a u32 ---
commit 50e02caac680576dbb8a9d80c6f2e251318a9c08
Author: Dave Jiang <dave.jiang@intel.com>

efi/cper: Reject an error status block length that wraps a u32

This commit prevents an integer overflow in cper_estatus_len() by adding
bounds checks to cper_estatus_check_header(). The new checks ensure that a
firmware-controlled data length cannot wrap a u32, avoiding infinite loops
in callers like bert_print_all().

> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index ec092729caccb..ea1c999089bc1 100644
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
This is a pre-existing issue, but there appears to be a missing bounds
check in cper_estatus_check() that could lead to an out-of-bounds read.

The function iterates over error status sections:

drivers/firmware/efi/cper.c:cper_estatus_check() {
    ...
    apei_estatus_for_each_section(estatus, gdata) {
        u64 record_size;

        if (acpi_hest_get_size(gdata) > data_len)
            return -EINVAL;
    ...
}

The loop condition in apei_estatus_for_each_section() only checks that the
next section starts within the total data_length. If a malformed record
leaves a remaining data_len greater than 0 but less than
sizeof(struct acpi_hest_generic_data), the loop will still process it.

Inside the loop, the very first operation is acpi_hest_get_size(gdata). This
internally evaluates gdata->revision via acpi_hest_get_version():

include/acpi/ghes.h:acpi_hest_get_version() {
    return gdata->revision >> 8;
}

Since gdata->revision is at offset 20, reading it when the remaining
data_len is too small (for example, if only 10 bytes remain) reads memory
beyond the end of estatus->data_length.

Could this cause a kernel panic if the read crosses into an unmapped page?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824174936.9390=
59-1-dave.jiang@intel.com?part=3D2
