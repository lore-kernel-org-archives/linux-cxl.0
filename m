Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92B0394493
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788543626; cv=none; b=loi2hEHlNj5FPTJR7xlvNX5pBNIXNvtmg4MLUckIwZMKLHV/jVuaU6EJkR/tVcJNMIyhrVDrmebKHk6x9685sRX7fBwaFcs0ZIgLfva9USHMbsfxLZb7qF7r7PUeBQewUbTKb0yV5QQ9YFMuk1icZQJvzyoVbd03FzIs7/VCc9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788543626; c=relaxed/simple;
	bh=Bim1A8WUWqE+JSFpsZnEj7AawBpxyrZJ23hAUpWUaks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NaIaGxH+0fQXFgY2pJMTVzhH/Ju0obTVgwyqVMmYfYqZndpcZk1Kl2Fqgnk30EhQ2sCDZmRSCsAo42+mzytSKcpesp7L4Im5lJeW7+xlGoFDbjfWUE9Cm2yi/ZVARAl/+3Io527cVGLRSvV1XIOV0uFbw1L4yAiwy5kWsy/SlL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8jdOTz9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8jdOTz9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316C11F00A3D;
	Fri,  4 Sep 2026 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788543624;
	bh=URGJxX9XrWw8SJ+UkY18JZaMOt+tY3Pytcg9nNx4qw0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z8jdOTz9SSmSud2HPnCTlRpsfwERQxZoycQuAEKpEP11NvQmj2T5ycQFQlutCL9iG
	 KTdUktVt5tqKyRXOqa+DqZ+EO08Ty9qztwK2Q63UYJWP1ZUBAbtkmU9YLPWyH72Mdc
	 hGlZPMOjRClERe5VgdUboxYU06LYKU79NpVdxLz2Dr0oqLbRzwnjnnH3PtXpZM4s+X
	 L2fJPlCYdGBo7jleeF/Axl0eAvu20hmqwfbdbn7WF8lZINErCaPShsrME11cZwnA3J
	 /9RtuEe3a9gkyNmdoiFTVSIUA8x8Nk+1e7IHP7YIoZADza8axpi3gy+uXgZ32JsVFD
	 oe8njidDafEsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/13] ACPI: extlog: Validate elog record length
 before walking sections
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260904172337.1409775-4-dave.jiang@intel.com>
References: <20260904172337.1409775-1-dave.jiang@intel.com>
 <20260904172337.1409775-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 17:40:23 +0000
Message-Id: <20260904174024.316C11F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check on firmware-supplied physical address allows =
out-of-bounds memory read (and potential kernel panic) when mapped to a vir=
tual address.
--

commit 7d4af53bdefb9af34e8feff4c7e1e31654f51d71
Author: Dave Jiang <dave.jiang@intel.com>
Subject: ACPI: extlog: Validate elog record length before walking sections

This patch adds validation to extlog_print() to bound the length of elog
records and check them via cper_estatus_check() before walking the sections.
It drops malformed records to prevent out-of-bounds reads if data_length
extends past elog_buf.

Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@i=
ntel.com?part=3D6

> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 7ad3b36013cc6..046e92ee195f9 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -208,6 +208,15 @@ static int extlog_print(struct notifier_block *nb, u=
nsigned long val,
> =20
>  	tmp =3D (struct acpi_hest_generic_status *)elog_buf;
> =20
> +	/*
> +	 * Bound the length before cper_estatus_check() walks the sections: it
> +	 * iterates over data_length, which is not yet known to fit elog_buf.
> +	 * cper_estatus_check_header() then rejects a length that wrapped, which
> +	 * the bound cannot see.
> +	 */
> +	if (cper_estatus_len(tmp) > ELOG_ENTRY_LEN || cper_estatus_check(tmp))
> +		return NOTIFY_DONE;
> +

[Severity: High]
This is a pre-existing issue, but since the goal of this code is to protect
against malformed firmware records, there appears to be a missing bounds
check earlier in this path.

In drivers/acpi/acpi_extlog.c:extlog_elog_entry_check():

    data =3D ELOG_ENTRY_DATA(idx);
    if ((data & ELOG_ENTRY_VALID) =3D=3D 0)
        return NULL;

    data &=3D EXT_ELOG_ENTRY_MASK;
    estatus =3D (struct acpi_hest_generic_status *)ELOG_ENTRY_ADDR(data);

    /* if no valid data in elog entry, just return */
    if (estatus->block_status =3D=3D 0)
        return NULL;

The physical address read from the firmware-controlled L1 directory into
data is converted to a virtual pointer via the ELOG_ENTRY_ADDR() macro. It
is then immediately dereferenced by estatus->block_status.

Is there anything verifying that this physical address falls within the
mapped elog_base to elog_base + elog_size boundaries?

If the resulting virtual address points to an unmapped page in the vmalloc
or ioremap region, could this dereference cause a kernel page fault and
panic?

>  	if (!ras_userspace_consumers()) {
>  		print_extlog_rcd(NULL, tmp, cpu);
>  		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904172337.1409=
775-1-dave.jiang@intel.com?part=3D3
