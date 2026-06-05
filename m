Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C758629BDBD
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 04:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780633652; cv=none; b=gpXIbhFehyutfRNGogh70yYvxxRfJIdfQ/znfkP8t21CVk+o7w70zl20RTgssjgGRQJ+Kd7CKggBFSRZHDJi3/4xm8P268A/xz+XaKCrsfgcT7V+ljFVAYkiZvo8jJOSRjiddvHp7BPvYz7wmoLWX/7YGBIlxhg1rtZWJfAVXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780633652; c=relaxed/simple;
	bh=xMrIIGUpd9fWb/Z9kD3vcoCppKA//wtNTQ3zsYmh5Ww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oW0Bp21DpKN4Q2V0w9ZcngdvKvrGhzGETYEZzvhwuENJ3bpoG2bC0mhyLz1cR2fWc9Ae2l0q58CVICn+AEDaHYer8NLLAg4YgtEiB8C5VKzidAcqiSxH2zdMphxuiY0rUlCWin8bW5SfMViCUIKHRh85/SVTOW/PrZozoNfs0cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCtceRIS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCtceRIS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE701F00893;
	Fri,  5 Jun 2026 04:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780633651;
	bh=/B1B5s29fIa2J/kAkDhGHQ4fgrwNG9/5tRk2zWb3VcQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CCtceRIS22oJoGctYv6wSUhL4y70zgCzAc/miXvBEFifAk6UDOWEcxYekDVIjdkTc
	 fZyqkj2Faz2Cl/+vgLt/vLqEESF6X98ICkx9PpPs6PU9vCpAJci3DbaWx6WppHxFOe
	 m+LivX/2EZfhF3p32+pHIh/dVPbuO+61gDetqjP0coH5btL0Vl9XE3Lc0f/MZmWO/2
	 JiE6jCxfs/dbHQZg/65w2DgUpSdS6YdMvc97tijItM8dGlE1OR85I2NAKngicxJLzJ
	 6iWn6Z79rpcyaA2m7MzxWnHid58oGz5ePDJM2rlSugcWOlrkMw9DrvZCk0/h0KIgZ5
	 r9NQ+rt1+NPng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/pci: Fix out-of-bounds read of the RAS Header Log
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260605041602.37944-1-icheng@nvidia.com>
References: <20260605041602.37944-1-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 04:27:30 +0000
Message-Id: <20260605042731.3DE701F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Tracepoint comments still reference 512B headerlog data despite the=
 size reduction.

Pre-existing issues:
- [High] Missing bounds check on CPER record length and `dvsec_len` in CXL =
protocol error handling, leading to out-of-bounds read and information leak.
--

commit c3e9e84c0d6db804f921aa7a18334a01bcf77999
Author: Richard Cheng <icheng@nvidia.com>
cxl/pci: Fix out-of-bounds read of the RAS Header Log

This commit reduces the CXL_HEADERLOG_SIZE constant from 512 bytes to 64
bytes to match the actual size of the CXL RAS Header Log. It prevents an
out-of-bounds read and subsequent kernel memory leak that occurs when
the CPER path tracepoints copy 512 bytes from a smaller heap allocation.

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1297594beaec3..f322d7c79ed22 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -158,8 +158,8 @@ static inline int ways_to_eiw(unsigned int ways, u8 *=
eiw)
>  #define CXL_RAS_CAP_CONTROL_FE_MASK GENMASK(5, 0)
>  #define CXL_RAS_HEADER_LOG_OFFSET 0x18
>  #define CXL_RAS_CAPABILITY_LENGTH 0x58
> -#define CXL_HEADERLOG_SIZE SZ_512
> -#define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
> +#define CXL_HEADERLOG_SIZE SZ_64
> +#define CXL_HEADERLOG_SIZE_U32 (CXL_HEADERLOG_SIZE / sizeof(u32))

[Severity: Low]
Are the tracepoint comments now stale?

Looking at cxl_port_aer_uncorrectable_error() and
cxl_aer_uncorrectable_error() in drivers/cxl/core/trace.h, the comments
still state:

    /*
     * Embed the 512B headerlog data for user app retrieval and
     * parsing, but no need to print this in the trace buffer.
     */
    memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);

[Severity: High]
This is a pre-existing issue, but while looking at the CPER path this
commit fixes, is there a missing bounds check on the CPER record length
and dvsec_len?

Looking at cxl_cper_setup_prot_err_work_data() in
drivers/acpi/apei/ghes_helpers.c, cap_start is calculated using an
unvalidated dvsec_len:

    dvsec_start =3D (u8 *)(prot_err + 1);
    cap_start =3D dvsec_start + prot_err->dvsec_len;

    memcpy(&wd->ras_cap, cap_start, sizeof(wd->ras_cap));

Similarly, in cxl_cper_print_prot_err() in drivers/firmware/efi/cper_cxl.c:

    print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, (prot_err + 1),
                   prot_err->dvsec_len, 0);

And in ghes_do_proc() in drivers/acpi/apei/ghes.c:

    struct cxl_cper_sec_prot_err *prot_err =3D acpi_hest_get_payload(gdata);
    cxl_cper_post_prot_err(prot_err, gdata->error_severity);

If gdata->error_data_length is not checked to ensure it contains the CXL
protocol error structure, or if a malformed firmware record specifies a
large dvsec_len, could this lead to out-of-bounds reads and leak
sensitive kernel memory into dmesg?

> =20
>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605041602.3794=
4-1-icheng@nvidia.com?part=3D1
