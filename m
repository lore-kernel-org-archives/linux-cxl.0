Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3323921DC
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787864151; cv=none; b=Pt1gskUDC/7Uca6JWJqeuM7QELnco7Vlhu2R1tWhTXYKHkmNgjbIcg37LS+QfKVWJf5IIzALqoA5gTqZMKj5hD36w1UhhSIutGmcZITURLfRCXaqaQvmDrP7OQaRwSsVV8bkjClOTCxetYHZDCuAunACwcScRsNl0T8nlvnqULA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787864151; c=relaxed/simple;
	bh=ALqaUPUozJzhlDtRA626KlGLxvMAdLpStq8+GYmkzTg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QP1HrangPb1QQYuROIf4QC9b50Ad9VtMQqcGatSpnbkthYYNdzssoBABU3bYW8N7Y1vLSKyBnnf9KcJs+6qgb8R8u42OZgHqvMXCaFTZZ/9ltwkVb5NX9DMujx6azuwMc+hDNY6zngnpAqCwBXb+loSR6ozG56aGI88jW/vaNQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzEhURzN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzEhURzN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DC71F000E9;
	Thu, 27 Aug 2026 20:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787864150;
	bh=SevFthET9nOuKZ3doN+2M1fipTOQRLA9zEQbJvHC/Gs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dzEhURzNojKTf+4lB4lLPl6D0Zuq3k3Elg9jI6FJbLyl/JbxTgndh+yV2mnqGSdug
	 7tGWZJfpqhQ55xW/avaSrpAVADoOUoKpzTN0HUblUxENJtcDSZ+nkxlByoJ82RUW9y
	 1h1L8MSsmdv2MFR3am5WdDEpwFMYyyEYOWBkHRRxYLLvrAjpFrZrCYuWOGiDVJSnkP
	 e/EM+1ilrh9hTpYOHgMgL4AAvy+CIBPcGX988XCD8gw75qabS/4IF/sNwHPvtczzeL
	 Bv6sZBKEtokvtzLIKRI6hY51anmiNw2Nk6QCmnniElH3+41C48RtxyoinNvLuhMMEL
	 ehwOM1v1a99Yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/13] efi/cper: Read only validated fields in
 cper_mem_err_pack()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260827203726.3027541-11-dave.jiang@intel.com>
References: <20260827203726.3027541-1-dave.jiang@intel.com>
 <20260827203726.3027541-11-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 20:55:49 +0000
Message-Id: <20260827205550.34DC71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] cper_mem_err_pack() remains vulnerable to out-of-bounds reads be=
cause cper_print_mem() bypasses length validation for records slightly larg=
er than the base structure.
--

commit b4317fae697d11738e3b054dc50086b6abb20080
Author: Dave Jiang <dave.jiang@intel.com>

efi/cper: Read only validated fields in cper_mem_err_pack()

cper_mem_err_pack() copies extended, rank, mem_array_handle and
mem_dev_handle unconditionally. Those live at offsets 73 to 79, past the
end of struct cper_sec_mem_err_old, the 73-byte UEFI 2.1/2.2 layout that
older firmware still emits and that cper_estatus_print_section() admits.
On such a record the copy reads up to seven bytes past the payload, and off
the end of the error status block when that section is the last one.

Link: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@int=
el.com?part=3D7

> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 3dcef618ad39f..13b3e72c3b62f 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
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

[Severity: Medium]
This is a pre-existing issue, but does this conditional read still allow an
out-of-bounds read if the record length is between 74 and 79 bytes?

In cper_print_mem(), the length validation only checks if the length is
exactly sizeof(struct cper_sec_mem_err_old) (which is 73 bytes):

drivers/firmware/efi/cper.c:cper_print_mem() {
	...
	/* Don't trust UEFI 2.1/2.2 structure with bad validation bits */
	if (len =3D=3D sizeof(struct cper_sec_mem_err_old) &&
	    (mem->validation_bits & ~(CPER_MEM_VALID_RANK_NUMBER - 1))) {
		pr_err(FW_WARN "valid bits set for fields beyond structure\n");
		return;
	}
	...
	cper_mem_err_pack(mem, &cmem);
	...
}

If the length is slightly larger, such as 74 bytes, this check is completely
bypassed. If firmware provides a record of length 74 with extended validati=
on
bits set (e.g., CPER_MEM_VALID_MODULE_HANDLE), cper_mem_err_pack() will tru=
st
these validation bits and read out of bounds up to 6 bytes, leaking adjacent
memory content.

While a follow-up patch ("ACPI: APEI: GHES: Validate memory error section
length before payload access") fixed this vulnerability for consumers reach=
ed
via ghes_do_proc(), cper_print_mem() remains unchanged.

Could cper_print_mem() be updated to ensure the length covers the fields
indicated by the validation bits?

>  }
>  EXPORT_SYMBOL_GPL(cper_mem_err_pack);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827203726.3027=
541-1-dave.jiang@intel.com?part=3D10
