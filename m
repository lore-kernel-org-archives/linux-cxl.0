Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF7743E488;
	Wed, 17 Jun 2026 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705713; cv=none; b=k9NynVQhFgbvaF6PS0QRnDQGj8+aTqxBU2akVwExisuKQtgHa6+onnPY013ZcQYKW0gDk4sdLgqd1/tEKT0/KqfOmOeY9+7HR3qpnL7BGMcMaMSQB5hQoeg+blzFu+TtJZ//cUlziT/ebUd7V8dly/CmjTYZsSunBZ+lBMpMsLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705713; c=relaxed/simple;
	bh=aT6EsMpyN2kHvIzzfOlMkl1tsxagZKfNG322pi4LTbs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DSpPMWDzySi8V0SiT3pAwrftQQFL9Ze6p2DclMpw+7+G6EXR3m95DnCnDsUxchyKf7Zm5KE94r7DOvOlfp0tSfXDrtR6P1iLhFId4NHvlykkdfvER/DM6yepkRP7n825o9vLbS40cfy4DiJjmsR+YwzxMK+N+1ZAbR1bmIsXHnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UI+ZGsDv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UI+ZGsDv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13231F000E9;
	Wed, 17 Jun 2026 14:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781705712;
	bh=l5idDmyMZHXtgRmJ3QAeMxDJzHsMw3e6bXX2hV5ODoo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UI+ZGsDvPiYTuVGh3UOjxOu6Nfy0nXYEra4zLomR1Z4D3I5FpP7oig20QuPvGJl1z
	 kxv7W6GbADSPyqM7rgvcRoWwmB+Re7EzEycFhJgRNVUV1KIb6l3z9F1BgmH9LS7R23
	 IH9jLsirvsCVL4ao5lvmloYaC91YRj0NzO9aab6RBDdH2ZQczLaKnySZH1yP9HDFgd
	 C4TLeQqhaCKdc5VPyK0vs03C336+o3/rBY71l4tp+89QUQ6KrfMSPEvS9HQJd0NtQF
	 YeCi3dACCoFDIKwaTTQEEwS4JkGdQnBer7SNNAu0wsrGHFRpduKxxla3trHS+pCHy6
	 jAdUOgC57Dd+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/10] ACPI: APEI: GHES: move CPER read helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ahmed Tiba" <ahmed.tiba@arm.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-cxl@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-2-91f725174aa0@arm.com>
References: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>
 <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-2-91f725174aa0@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 14:15:11 +0000
Message-Id: <20260617141511.F13231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A double fetch (TOCTOU) vulnerability when reading the CPER error =
status block from firmware memory can lead to out-of-bounds reads.
- [High] ghes_ack_error() incorrectly shifts read_ack_preserve and read_ack=
_write by the register bit_offset, unconditionally clearing bits below bit_=
offset and potentially clobbering other hardware state in the register.
--

commit 6a836df1ccfeca08e11c00049d33e954958fa36f
Author: Ahmed Tiba <ahmed.tiba@arm.com>

ACPI: APEI: GHES: move CPER read helpers

This commit relocates the CPER buffer mapping, peek, and clear helpers
from ghes.c into ghes_cper.c so they can be shared with other
firmware-first providers. It only shuffles code without changing
behavior.

Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>

> diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
> new file mode 100644
> index 0000000000000..b365c42efce49
> --- /dev/null
> +++ b/drivers/acpi/apei/ghes_cper.c
> @@ -0,0 +1,196 @@
[ ... ]
> +static void ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
> +{
> +	int rc;
> +	u64 val =3D 0;
> +
> +	rc =3D apei_read(&val, &gv2->read_ack_register);
> +	if (rc)
> +		return;
> +
> +	val &=3D gv2->read_ack_preserve << gv2->read_ack_register.bit_offset;
> +	val |=3D gv2->read_ack_write    << gv2->read_ack_register.bit_offset;

[Severity: High]
This is a pre-existing issue, but does this code unintentionally clobber the
lower bits of the hardware register?

When ghes_ack_error() masks val using:

val &=3D gv2->read_ack_preserve << gv2->read_ack_register.bit_offset;

Any bits in val below bit_offset are unconditionally cleared to zero.

If there is hardware state in those lower bits, wouldn't writing back the
modified val via apei_write() overwrite and destroy it?

> +
> +	apei_write(val, &gv2->read_ack_register);
> +}
[ ... ]
> +int ghes_read_estatus(struct ghes *ghes,
> +		      struct acpi_hest_generic_status *estatus,
> +		      u64 *buf_paddr, enum fixed_addresses fixmap_idx)
> +{
> +	int rc;
> +
> +	rc =3D __ghes_peek_estatus(ghes, estatus, buf_paddr, fixmap_idx);
> +	if (rc)
> +		return rc;
> +
> +	rc =3D __ghes_check_estatus(ghes, estatus);
> +	if (rc)
> +		return rc;
> +
> +	return __ghes_read_estatus(estatus, *buf_paddr, fixmap_idx,
> +				   cper_estatus_len(estatus));

[Severity: High]
This isn't a bug introduced by this patch, but is there a potential double
fetch issue in the error status read path?

Looking at the sequence in ghes_read_estatus(), we first fetch and validate=
 the
header:

__ghes_peek_estatus() copies the header from physical memory into estatus.

__ghes_check_estatus() validates estatus->data_length.

Then we call __ghes_read_estatus() which copies from the same physical memo=
ry
again, overwriting the previously validated estatus header:

__ghes_read_estatus(...) {
    ghes_copy_tofrom_phys(estatus, buf_paddr, buf_len, 1, fixmap_idx);
    if (cper_estatus_check(estatus)) {
    ...
}

If the underlying firmware memory is modified between the peek and the read,
the local estatus will get a new, unvalidated data_length.

Since cper_estatus_check() relies on data_length to iterate over the sectio=
ns,
could this new unvalidated length cause an out-of-bounds read?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-topics-ahm=
tib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com?part=3D2
