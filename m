Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDE83859FC
	for <linux-cxl@vger.kernel.org>; Wed,  2 Sep 2026 05:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328363; cv=none; b=RBaNCNk++qm6kAEzD405yJIJKXOzGcwrcSUdyJGaVj1PFSogKEAhWYtqIKzg7u1G6LQ1G6f7qY4pvmrSI43m2HGLPEm1c0LYArud5QGGCV+Itwn0gQWiFztYgqHTHNKynvhH8mCFe88yss/nAsxaAlSP/SytLkdadxvfYwGoGWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328363; c=relaxed/simple;
	bh=omjG0sdCuFtWHZljUsP4hftTdhR7sQwDFfCQDsJcTbw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pVLeTLASB2Eg0pLSbyks8BgmPuLlnMkLxxDawpHuRRX8RsifJEyI+9oasD1aEh78pDllYazwsEpXt3Q4ykuguJYBUs8QvAiFdnazfICmFodFOrFRG2a8WPuPXSINBOApqabQwqgKlhTRJnqEibz6Qmx/SOIBvhX5qw3FHG5bV2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItCA2fop; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItCA2fop"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4151F00A3A;
	Wed,  2 Sep 2026 05:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328361;
	bh=RyaoT8cVW4SBmI+BVJ4t0isjbHgGk8NwGgu4Qfi3t7U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ItCA2fopQLtgIHzKXwEw8aJiLUusWydoELBB7vPP170gsjL/ZRt0qMJRo5MboP9Zl
	 U8uJ8suHdSs6sgHxjw3P5u0i48iCFXBMPPFdMWJ3NVwRYghEbxVA28viMsJqbx43I9
	 w9CGqQJqsJxFqAEigyHA0O6H4QfBAVnEh21GZcVVAm882ZOmIHs7LKSHp0A9JUZhEZ
	 PZoO+Jir26G6Drd+cy+Y4g9p2sTOohYpTxJD8YE+niky964qTjkhwELKWcN1bGk4PO
	 Z662KBFdQd3StLPBA49CeBc/bD5fUG+cIW3nZ9kP7JDprRbU4lvOTT1KrjRECxXWSu
	 x3K0T04yn5o1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/7] cxl/region: Reject poison scan for decoder
 without a partition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260902053839.25595-7-icheng@nvidia.com>
References: <20260902053839.25595-1-icheng@nvidia.com>
 <20260902053839.25595-7-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 05:52:41 +0000
Message-Id: <20260902055241.AA4151F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Returning -ENODEV in poison_by_decoder() incorrectly aborts the =
iteration over the port's decoders, failing the entire poison scan.

Pre-existing issues:
- [High] The function `cxl_mem_get_poison` does not validate that the numbe=
r of poison records returned by the device (`po->count`) fits within the al=
located buffer, leading to an out-of-bounds read and information leak.
--

commit 38cab4750fe29ee2e45310ad8ff37111d581eb8d
Author: Richard Cheng <icheng@nvidia.com>
Subject: cxl/region: Reject poison scan for decoder without a partition

The __cxl_dpa_reserve() function may leave cxled->part at -1 when a
decoder's DPA range doesn't map to any reported partition. This commit
returns -ENODEV before accessing the partition array when no partition
was assigned.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b7dc5d4988da7..afe3fb57b7fe2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2954,6 +2954,8 @@ static int poison_by_decoder(struct device *dev, vo=
id *arg)
>  	cxled =3D to_cxl_endpoint_decoder(dev);
>  	if (!cxled->dpa_res)
>  		return rc;
> +	if (cxled->part < 0)
> +		return -ENODEV;

[Severity: Medium]
Does returning -ENODEV in poison_by_decoder() incorrectly abort the iterati=
on
over the port's decoders?

When a CXL port has an endpoint decoder that is not mapped to any partition,
the device_for_each_child() iteration will abort prematurely on the first
unmapped decoder. This prevents the remaining valid decoders from being
scanned for poison and skips cxl_get_poison_unmapped() entirely.

Could this return 0 instead to skip the unmapped decoder while allowing the
overall poison scan to continue?

This isn't a bug introduced by this patch, but I noticed another problem in
the cxl_mem_get_poison() function called later in this path:

drivers/cxl/core/mbox.c:cxl_mem_get_poison() {
    ...
		if (!le16_to_cpu(po->count)) {
			dev_dbg(&cxlmd->dev, "Poison empty payload!\n");
			break;
		}

		for (int i =3D 0; i < le16_to_cpu(po->count); i++)
			trace_cxl_poison(cxlmd, cxlr, &po->record[i],
					 po->flags, po->overflow_ts,
					 CXL_POISON_TRACE_LIST);
    ...
}

[Severity: High]
Does this code overflow po->record[] if a buggy or malicious CXL device
returns a large po->count value?

The po->count value from the device payload is used to index the array
without being validated against the size of the list_out buffer allocated
via kvmalloc. If the firmware returns a large count value alongside a
small actual payload size, this could lead to an out-of-bounds read.

Can this leak adjacent kernel memory to the ftrace ring buffer or trigger a
kernel oops if the read crosses into an unmapped page?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902053839.2559=
5-1-icheng@nvidia.com?part=3D6
