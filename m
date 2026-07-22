Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F16135C183
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784754250; cv=none; b=j7pJRxMUeEp0NlXcocIMpQHsnfjc9G2LTZC6U/Tp5rUwdW7TcoCWSBetkncxIXQpq6QFmVV6qR3BnzAzfY42RF9fZjhvQWVtL7bqxQx6h6PQbeodJbFPY6KZgoW/t5cBfh5O29T5Jx7CBKZfMuPefYjmie2H7pha67sdgX6kMec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784754250; c=relaxed/simple;
	bh=Q0t1/32TVc9kgcwu284js9lrW8jpZRQ4grrGlz9Ax0w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RGw2Y3ckhJJJgmchOgDYpJdcI25VQfIRSIQK2KhdYryp4uf7u3toXvW8g9/DS2rG2gUTAJCPPqwtgpFHsnjk84S54FWpdHLQ2W+UqKa3GHRdmhBDvEoAl1h7g4fA8rjkSV8ulosp2v6Z8Ug4ycQuSgYhHBUvjvPEN5ShcXpLQFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aow1z1Sz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aow1z1Sz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3225C1F000E9;
	Wed, 22 Jul 2026 21:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784754249;
	bh=uOlKU8KE4rXi05ns5z3yExGUKlkwm5pbnmPN9peRIOs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Aow1z1Szk80e8cDv6CC5XEfItCFGPbBQ9TyYfkOmIRR3UieRN3PoCN00SH3ccLBpN
	 yh47QQqqzJqqHneDjVQ8XHB+E5OOPz103KwXrEc8PTJmuxVXZFNol5wyxR214U31r1
	 zAaQszvYICoUQ3gYTgNK8HaKlqPL8VLwEeTDen+mIvHFJqItVMRxkbKwpUouQBh27q
	 fTQkHnrTy2mHHk2svmHGkuaPZmNRmRCW6Jf9P7SKACkrkqxXJ/M3CGammzN/XHGnob
	 ijQrg6y7BIvLZuoSk8Fh9agOoy85SwUlFk3mPZCtlJK572slgfHMCMMzRM63mWPHWt
	 zC28sCKAd0R6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] cxl/memdev: Don't mask an earlier partition's
 poison query error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260722205303.3184787-4-dave.jiang@intel.com>
References: <20260722205303.3184787-1-dave.jiang@intel.com>
 <20260722205303.3184787-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 21:04:08 +0000
Message-Id: <20260722210409.3225C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect error handling in cxl_get_poison_unmapped for unsupporte=
d RAM poison queries leaks -EFAULT.
- [High] Premature loop termination in cxl_get_poison_unmapped skips subseq=
uent partitions when a partition is fully mapped.
--

--- Patch [3]: [PATCH 3/3] cxl/memdev: Don't mask an earlier partition's po=
ison query error ---
commit 8d306ff8fd6e937d7c00800ee63688acb619e094
Author: Dave Jiang <dave.jiang@intel.com>

cxl/memdev: Don't mask an earlier partition's poison query error

cxl_get_poison_by_memdev() reassigns rc every partition iteration with
no early exit, so an error from an earlier partition is overwritten
when a later partition succeeds. Break on the first failure.

Closes: https://sashiko.dev/#/patchset/20260708074228.43654-1-icheng@nvidia=
.com?part=3D5

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 33a3d2e7b13af..8718964b9c5e8 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -231,6 +231,8 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev=
 *cxlmd)
>  		 */
>  		if (rc =3D=3D -EFAULT && cxlds->part[i].mode =3D=3D CXL_PARTMODE_RAM)
>  			rc =3D 0;
> +		if (rc)
> +			break;
>  	}
>  	return rc;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but since you are fixing the poi=
son
partition loop here, I noticed similar bugs in drivers/cxl/core/region.c in
cxl_get_poison_unmapped().

First, does this break statement skip poison collection for subsequent=20
partitions?

If an earlier partition (e.g., RAM) is fully mapped, length evaluates to 0,
and the loop terminates early:

drivers/cxl/core/region.c:cxl_get_poison_unmapped() {
...
	for (int i =3D ctx->part; i < cxlds->nr_partitions; i++) {
...
		length =3D res->end - offset + 1;
		if (!length)
			break;
...
}

If a partition is fully mapped, shouldn't this be continue so we don't
completely skip checking unmapped capacity in a subsequent PMEM partition?

[Severity: High]
This is a pre-existing issue, but further down in the same function,
if we hit the expected -EFAULT for RAM partitions that don't support volati=
le
poison lists, does it leak the error?

drivers/cxl/core/region.c:cxl_get_poison_unmapped() {
...
		rc =3D cxl_mem_get_poison(cxlmd, offset, length, NULL);
		if (rc =3D=3D -EFAULT && cxlds->part[i].mode =3D=3D CXL_PARTMODE_RAM)
			continue;
		if (rc)
			break;
	}

	return rc;
}

Because continue bypasses the error check but fails to clear rc to 0,
if this happens on the last partition (or the only unmapped one), wouldn't
the function erroneously return -EFAULT on termination?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722205303.3184=
787-1-dave.jiang@intel.com?part=3D3
