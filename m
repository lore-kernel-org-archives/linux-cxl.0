Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4FA3793BD
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 20:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787863924; cv=none; b=sR3CB2lr2m91zXRz0xOpXsQkCo6Yy3sdInd2wI2mOXCG7fePev2VpmD9oZDP0C45yJrmsKkEqQ4JDEHx9EiR/QL0s4avHEcDoyexRNlL9VGNBPxbP7eAhKoDzXHnzN6GHgq9w0XKaw7/TUoZu515Rd27yRMyTlg8MN/1iprw9kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787863924; c=relaxed/simple;
	bh=LgTM1cvKqGyjvtLMvG6hvpSJC88vRIoLoVeCuNMfXF8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tEMJRsvsLT9jTMd0JcUrGxA2wHUBYrGwuSrmZgodrUbMnis6VaJBJ1g+7SwtqLxFi49J29wOaGacj9fYVqIo+tZ5infPU0cSlHCWPm0qYT5rn/3q/tFq5P54xHEVGLnEgwDyaQ8Z22RsjtWCzyYnbo9IQBCJwhNkxYJ32WcByAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVCe88g6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVCe88g6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96E91F000E9;
	Thu, 27 Aug 2026 20:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787863923;
	bh=95mFuw354uo+mYbffUwW4A8XuTQVyYg3gZJPl/69FPE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hVCe88g63ZTgG1Ha3xaRXRYTXlV3vtp9XEm+XrjNCNymOger+VitN/sBIARaMWVWF
	 pJ6MjeW7yoz93q/+UY5Z1+cusXB+SEK4DFrxkoKuOVTlYwjo02CMLAy1G3WQaQBLw/
	 Dv41Bcfmt/HIKmUL2innV7kQh3P+WGrkxpbBTZy5nhpV/mRe+NPaU/Cz/tnvaH8FuD
	 IzFFYFRr0nZiW59pPdDsY4j9P3HSr80NiJ1Pb6MMdai1DeTAgnUVouG0hH6AzJfrvC
	 e3cXknipaet3vJ/O/k27G7KDtjEJywW1yRfChVPZhWerhLCwd9NX80GdNS42BWIvF4
	 R6SwGlgVHDpyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/13] efi/cper: Reject an error status block length
 that wraps a u32
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260827203726.3027541-3-dave.jiang@intel.com>
References: <20260827203726.3027541-1-dave.jiang@intel.com>
 <20260827203726.3027541-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 20:52:02 +0000
Message-Id: <20260827205202.D96E91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Double-fetch (TOCTOU) vulnerability in GHES error record parsing l=
eading to out-of-bounds reads in the kernel heap.
--

commit ddc6acba60cbd7b0aee24cf35b70654e2a951cb0
Author: Dave Jiang <dave.jiang@intel.com>

efi/cper: Reject an error status block length that wraps a u32

This commit adds bounds checking to cper_estatus_check_header() to prevent
a u32 wrap-around when calculating the total length of the error status
block. It rejects lengths that cannot be expressed in a u32 to protect
callers like GHES and BERT from processing short values and looping forever.

Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@i=
ntel.com?part=3D1
Fixes: 06d65deade9a ("ACPI, APEI, UEFI Common Platform Error Record (CPER) =
header")

> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 332c78f2d5617..3dcef618ad39f 100644
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

[Severity: High]
This isn't a bug introduced by this patch, but there is a pre-existing=20
double-fetch (TOCTOU) vulnerability that these new checks do not mitigate.

The GHES driver fetches the error status header from shared physical memory
twice. The first fetch in ghes_in_nmi_queue_one_entry() determines the
buffer allocation size:

drivers/acpi/apei/ghes.c:ghes_in_nmi_queue_one_entry() {
        ...
        rc =3D __ghes_peek_estatus(ghes, &tmp_header, &buf_paddr, fixmap_id=
x);
        ...
        len =3D cper_estatus_len(&tmp_header);

The second fetch copies exactly len bytes from shared memory, overwriting
the previously validated header:

        if (__ghes_read_estatus(estatus, buf_paddr, fixmap_idx, len)) {
        ...
}

If the data_length field in physical memory is maliciously or erroneously
increased between these two reads, the newly copied header will contain a
data_length that exceeds the originally allocated buffer size (len).

The new untrusted data_length is then passed to cper_estatus_check():

drivers/firmware/efi/cper.c:cper_estatus_check() {
        ...
        data_len =3D estatus->data_length;
        apei_estatus_for_each_section(estatus, gdata) {
        ...
}

Because the checks here in cper_estatus_check_header() do not verify if
the new data_length exceeds the actual copied buffer size (len), the loop
in cper_estatus_check() will read out of bounds into the kernel heap.

This can lead to an out-of-bounds memory disclosure to dmesg, or a kernel
panic if it crosses into unmapped memory during NMI or IRQ context.

Does it make sense to update the caller to pass the allocated buffer size
into cper_estatus_check_header() so we can ensure the newly fetched length
does not exceed the buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827203726.3027=
541-1-dave.jiang@intel.com?part=3D2
