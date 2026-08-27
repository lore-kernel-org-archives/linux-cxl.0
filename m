Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08470385D6A
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787864706; cv=none; b=LoCFdQloSA/jy+Vb9BLJu9QEvJbMIzX/IS5ysxhewCuwyGwySl2OD988CCN13Ze0TcZSxnjo9zGE/3XZld0vEZwasPdmPF8ztg4hVGkFGGSaKR/w4qP80SnjzIHmbxZKAoURSRCuVad/H0BNX7/08J6HKDR2e1kmLgB2UN3HpXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787864706; c=relaxed/simple;
	bh=PcIjtj2yzgb6Pz/qNupM3bkI6ZE5R3ksnbO/18hbYic=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=opoqYsmj2zIUjgwBIcPOhbzVRJY9svm/xCIJpwuZoejvplPP8xMYk/sxijTPNauC08SGtgyODL9d+gsvfW4wqbFgN+f96pfZ2qI0DcgSg1SmwfozQJPy1/q5Uc9Jaaka/oAS3mb5SGLDupCjnYh5389YKGMGRjB/RdaYfNoo9S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3JnNqgx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3JnNqgx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673A81F000E9;
	Thu, 27 Aug 2026 21:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787864704;
	bh=OmrYEHzMNqLbU+hMzcxl8F0ktJba5xn12Po28f0xZoc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J3JnNqgx3wpa2vXogQR3g1F+2n7A7hSDJLsdJ+UiPnDNAkSfgRujx7IvCpsNxDmPa
	 PbITvvjSL6IH4blztiIPec4q6opmw6B+ArGnj4LLhkiERGqFV2TajDZ2sgiI2tsamw
	 fGOOuOyef699uexDC7tDUd3BhGthT6cjeZvRwGuRyMsT/+RTRVO60K0Ptsfa+ur2qC
	 xCZtHfJ9tDlAofgjfHmmCymgInK+26yldkPghhtxOwqT6es3D807P8Gq40rsnJsEWD
	 /phbsAUM2T/iSkeBi3/fSOJkkj3LSrBhUfxV3ujCjCcVqMeU1Jz70blE8Ozw4SMPs/
	 moVaRfSfRXgZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/13] ACPI: APEI: GHES: Validate memory error
 section length before payload access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260827203726.3027541-12-dave.jiang@intel.com>
References: <20260827203726.3027541-1-dave.jiang@intel.com>
 <20260827203726.3027541-12-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 21:05:03 +0000
Message-Id: <20260827210504.673A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch identifies but fails to fix an out-of-bounds read vulner=
ability in `cper_print_mem()` and `cper_mem_err_pack()` when handling malfo=
rmed memory error sections.
--

commit af698921ff589a7f79e6f852052dbc3da7191b73
Author: Dave Jiang <dave.jiang@intel.com>

ACPI: APEI: GHES: Validate memory error section length before payload access

ghes_do_proc() hands the CPER_SEC_PLATFORM_MEM payload to the report chain,
arch_apei_report_mem_error() and ghes_handle_memory_failure() without
checking gdata->error_data_length. All three read validation_bits and
physical_addr, at offsets 0 and 16, so a shorter section reads past the
record.

Check the length once in ghes_do_proc(), before any consumer runs. Take the
73-byte struct cper_sec_mem_err_old as the floor: older firmware
legitimately emits that UEFI 2.1/2.2 layout, and it makes validation_bits
safe to read.

Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@i=
ntel.com?part=3D7

> The fields from "extended" on are absent from that layout, so also require
> whatever length the validation bits claim. Derive it per field rather than
> demanding the full 80 bytes: rank needs only 76, and the BANK_GROUP and
> BANK_ADDRESS bits describe "bank" at offset 38, which every record carrie=
s.
> Testing the whole mask against one size, as cper_print_mem() does, gets it
> wrong both ways.

[Severity: High]
This is a pre-existing issue, but since the commit message notes the flaw in
cper_print_mem(), should this patch also fix the out-of-bounds read there?

A CPER memory error record containing a CPER_SEC_PLATFORM_MEM section with a
length between 74 and 79 bytes and CPER_MEM_VALID_MODULE_HANDLE set can tri=
gger
an out-of-bounds read of up to 6 bytes.

When cper_estatus_print_section() in drivers/firmware/efi/cper.c processes =
such
a record:

drivers/firmware/efi/cper.c:cper_estatus_print_section() {
...
		if (gdata->error_data_length >=3D
		    sizeof(struct cper_sec_mem_err_old))
			cper_print_mem(newpfx, mem_err,
				       gdata->error_data_length);
...
}

It calls cper_print_mem(), which bypasses its invalid bits check because
len !=3D 73:

drivers/firmware/efi/cper.c:cper_print_mem() {
...
	if (len =3D=3D sizeof(struct cper_sec_mem_err_old) &&
	    (mem->validation_bits & ~(CPER_MEM_VALID_RANK_NUMBER - 1))) {
		pr_err(FW_WARN "valid bits set for fields beyond structure\n");
		return;
	}
...
	cper_mem_err_pack(mem, &cmem);
...
}

It then unconditionally calls cper_mem_err_pack(), which reads
mem->mem_dev_handle at offset 78 regardless of the record length:

drivers/firmware/efi/cper.c:cper_mem_err_pack() {
...
	if (mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE)
		cmem->mem_dev_handle =3D mem->mem_dev_handle;
...
}

Can this lead to a kernel oops if the struct is located exactly at the end =
of a
mapped page, or leak kernel heap memory into dmesg via DMI handle lookups?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827203726.3027=
541-1-dave.jiang@intel.com?part=3D11
