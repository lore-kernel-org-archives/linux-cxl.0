Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262D2381AE2
	for <linux-cxl@vger.kernel.org>; Mon, 24 Aug 2026 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787594891; cv=none; b=UiMeIh2S1dQ+1ALxgQuuqYnWJAXt7oDBQliuqZmz+CgTuyed5KHvlCLx2WpwsbgWinEYf23uBez1IfkddFuVxu4LkkBsmkvRhVs7BEgVjZ6YD0S7GCj6mIVule1yn/x8sOQjT/j8sy8a0XHCmvsCsZEdtRMN8cQ4HakPmu/K9KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787594891; c=relaxed/simple;
	bh=m6G4lY10S7AoWGkSDn7d1pLke9tSYiRZT8G3F3/jlhY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LBfuTLH2AP/5ePTTWwe/pIuj9zDN3LnVOV0Cbga2HQou8UyYI/mQL9KQV4YYw45Gc8BBzDQVjy3vqCIsTi3fdar2rtYZaGh3LyaCSsX54s9RG5K7DjVGanhtYvi15x0HCrdHw2L5trhUhr8bUZI7SBNApB947mZyjS0WN7eryV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgsLYi6n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgsLYi6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40641F00A3A;
	Mon, 24 Aug 2026 18:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787594889;
	bh=el1nR8A3i+WH3sajSh/s50LyfnvDfFQFbQcyJi1Q2vM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DgsLYi6nbmGN+1gtf4pyS/bgF3E8b1gTMv5TQLBrvDCnJjNUuDhZTVQ4HAz0/ICZI
	 zZLIk8Yt/EVWfZzAzy2pkQ89U4B9a3keRAdR97cyQaeW9D3nybnPQdyHAwwyDXQ8EU
	 euGjmQc2Ogk1kOIEZDPy7O99YC0Z0riOudJi10pBtSIPEz/TWwA2GaahCyGRZGG41N
	 1FxzGGIJ0VA0GTuy4+eInWbU9mPPaMsImdKHATjTCi2vwKuDYD7fTOhsCiODDuV7i2
	 rNJNc/ENGvRTSle8QBOfa0tVlKtYg118P3ti1ur43qKpGp9p8cpEHMFwtBog0oou79
	 gySawdlcRbv0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/13] efi/cper: Read only validated fields in
 cper_mem_err_pack()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260824174936.939059-11-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
 <20260824174936.939059-11-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 18:08:09 +0000
Message-Id: <20260824180809.B40641F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds read in cper_mem_err_pack() triggered by cper_print_=
mem() for records of length 74-79 bytes.
--

--- Patch [10]: [PATCH v4 10/13] efi/cper: Read only validated fields in cp=
er_mem_err_pack() ---
commit bef2c0319d994ade71f221a3c685230d96b2ab0b
Author: Dave Jiang <dave.jiang@intel.com>

efi/cper: Read only validated fields in cper_mem_err_pack()

This patch updates cper_mem_err_pack() to only copy extended memory error
fields when their respective validation bits are set. This addresses
out-of-bounds reads on older UEFI 2.1/2.2 73-byte layouts where these
fields don't exist. By zeroing unvalidated fields, it also prevents reading
uninitialized stack data.

Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@i=
ntel.com?part=3D7

> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index ea1c999089bc1..6c64a0f06a4e6 100644
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

[Severity: High]
This is a pre-existing issue, but if firmware provides a CPER record with a
length between 74 and 79 bytes and sets validation bits for fields beyond i=
ts
length, can this still cause an out-of-bounds read?

In drivers/firmware/efi/cper.c:cper_print_mem(), the validation bits are on=
ly
sanitized if the length is exactly 73 bytes:

	if (len =3D=3D sizeof(struct cper_sec_mem_err_old) &&
	    (mem->validation_bits & ~(CPER_MEM_VALID_RANK_NUMBER - 1))) {
		...

If the length is 74 to 79 bytes, this sanitization is bypassed.

Then, here in cper_mem_err_pack(), we trust the validation bits without len=
gth
context. If the CPER record is at the end of the mapped estatus block and
aligned at a page boundary, could reading mem_dev_handle cross into an
unmapped page and result in a kernel panic?

In drivers/acpi/apei/ghes.c:ghes_proc(), ghes_print_estatus() is called bef=
ore
length validation is performed in ghes_do_proc():

	if (ghes_print_estatus(NULL, ghes->generic, estatus))
		ghes_estatus_cache_add(ghes->generic, estatus);
	}
	ghes_do_proc(ghes, estatus);

Does cper_mem_err_pack() need to consider the length of the record, or shou=
ld
cper_print_mem() be updated to handle lengths between 74 and 79 bytes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824174936.9390=
59-1-dave.jiang@intel.com?part=3D10
