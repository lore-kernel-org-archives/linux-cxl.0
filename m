Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0805182D6
	for <linux-cxl@vger.kernel.org>; Mon, 24 Aug 2026 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595450; cv=none; b=qoMPjb8MnU2hBJ8vaKTLi+5XxfIFxCDJHq0BymDlwa92hsjbGgm6NNxvBQX3K0ThVOiakWvAyk6/jUucR/AED2AcsgvqZwnXMXcb1s7O3kXdSBvh7qaTrjAE9JDy7MHjjVdv5vvpz79lvspVpkJE7li3VJcF/ctOv8DQd/MYD60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595450; c=relaxed/simple;
	bh=a4Nq/IBv7GAdeOlBkKa/4oBhngZ+pVjWY81auuCPrCc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G9RkBSljJXG7B4QtMTkGkHKH4cBNCdE/iFqQ1dVjTLkUf7ETUGh1MqQbbq8GD3GkREvQGT3k7+hg0gtmo/QXZ7MtQpqMA6TKD7ekephF4Uvj3N2VJNF8qoe2iSqxljXa2/tulXedkUrpAg3hnMlWKxw36nVFaNByhUkUP0hoSiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEdM3gSG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEdM3gSG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9F01F000E9;
	Mon, 24 Aug 2026 18:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787595448;
	bh=nORgRLldltDf6fe2nAmQxi4zm/3Go2QdQAVloJdcgHk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HEdM3gSGlDqQ9LiKPbIDhJTECy4/5HncZ/fasMxWU9h7xGCU5tIRPcaAVjI5WMtge
	 klAxAWoYauf4wRggWvidpz+hSTJsWpjUd/G/MuzrENTFpLXa1iRj40rhzfvcmLrVne
	 3uk4RL9F7W+YW8IdXIi6YtlN310SoqOa7kTxX2QaxfbIAJa9gWV93BFrdlNqr4jtoe
	 UeJMYFMVSgKmWVc+kjQDW2DhUPZMC9nJ+H94gXZGmxunsPoxRDqa5pblRgnK2bBiDo
	 5/xDk+sak9I+m3uK31MpA0AuqQjKAsuyYstXaQlSyuTTwwMvWSYoDNcMUxn6QsKKXe
	 /LT3iHp/A4dMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/13] ACPI: APEI: GHES: Validate memory error
 section length before payload access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260824174936.939059-12-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
 <20260824174936.939059-12-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 18:17:28 +0000
Message-Id: <20260824181728.6D9F01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unfixed out-of-bounds read and valid record rejection in `cper_pri=
nt_mem()` for CPER_SEC_PLATFORM_MEM records.
--

--- Patch [11]: [PATCH v4 11/13] ACPI: APEI: GHES: Validate memory error se=
ction length before payload access ---
commit 550e022dfc62676e66fb5e0818106e122ddfcbf2
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: APEI: GHES: Validate memory error section length before payload access

This commit adds memory error section length validation to ghes_do_proc()=20
to prevent out-of-bounds reads when handling CPER_SEC_PLATFORM_MEM payloads=
.=20
It checks the validation bits to determine the minimum required length.

Link: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@int=
el.com?part=3D7

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c

[ ... ]

> @@ -940,6 +962,25 @@ static void ghes_do_proc(struct ghes *ghes,
>  		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
>  			struct cper_sec_mem_err *mem_err =3D acpi_hest_get_payload(gdata);
> =20
> +			/*
> +			 * Check once for all three consumers below. The 73-byte
> +			 * UEFI 2.1/2.2 layout is the floor, matching
> +			 * cper_estatus_print_section() and making
> +			 * validation_bits safe to read.
> +			 */
> +			if (gdata->error_data_length <
> +			    sizeof(struct cper_sec_mem_err_old))
> +				continue;
> +
> +			/* Then require what the claimed fields actually need. */
> +			if (gdata->error_data_length <
> +			    ghes_mem_err_min_len(mem_err->validation_bits)) {
> +				pr_warn_ratelimited(FW_WARN GHES_PFX
> +						    "memory error section too small (%u) for the fields it claims\=
n",
> +						    gdata->error_data_length);
> +				continue;
> +			}

[Severity: High]
This is a pre-existing issue, but does this validation happen too late to
prevent out-of-bounds reads when printing the error?

Looking at ghes_proc(), it prints the error status before calling
ghes_do_proc():

drivers/acpi/apei/ghes.c:ghes_proc() {
    ...
    if (!ghes_estatus_cached(estatus)) {
        if (ghes_print_estatus(NULL, ghes->generic, estatus))
            ghes_estatus_cache_add(ghes->generic, estatus);
    }
    ghes_do_proc(ghes, estatus);
    ...
}

The call chain goes through ghes_print_estatus() ->
cper_estatus_print_section() -> cper_print_mem(), which has a strict
73-byte length check that allows lengths 74-79 to bypass validation:

drivers/firmware/efi/cper.c:cper_print_mem() {
    ...
    /* Don't trust UEFI 2.1/2.2 structure with bad validation bits */
    if (len =3D=3D sizeof(struct cper_sec_mem_err_old) &&
        (mem->validation_bits & ~(CPER_MEM_VALID_RANK_NUMBER - 1))) {
        pr_err(FW_WARN "valid bits set for fields beyond structure\n");
        return;
    }
    ...
}

If a malformed payload has a length between 74 and 79 bytes and claims
extended fields, does this lead to an out-of-bounds read during
cper_mem_err_pack() before the new checks in ghes_do_proc() can reject it?

drivers/firmware/efi/cper.c:cper_mem_err_pack() {
    ...
    if (mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE)
        cmem->mem_dev_handle =3D mem->mem_dev_handle;
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824174936.9390=
59-1-dave.jiang@intel.com?part=3D11
