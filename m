Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46C3421EF8
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536508; cv=none; b=ctkun3hSYUJnIDW9TZUMNhCUPkka3nbmgNhoyfp9/1sLFUjVC/fMGdNuAk45XiKmUwgMm5wYDzMpErU7CaT57+fta5f1mRujSYysvZ+OB8flEvVg18MARi9v0L75m/1cJJOWH0Vm3btDeVGcRikmAFLqnd3JU8bf/Abpv0Nn5pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536508; c=relaxed/simple;
	bh=eVzcsNcX273tGtNmxj372EgdeSzgDmpP6SP/d1LFXdc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JMja1H6G4WDlMuAxlfpUROcDyOkdN3N7ry29qca7LDeBVxYTr66j9XklRx8OMOFV0W1pLMOaoC0OsX00kbQEEXKv3Z9Q2uhVDyMrMfFsKF58nTSDCDN/+kqjoBn1Wwlue1wd//WPAWe2TzRWwCiFB0ZXKcFg8PNq+E4en2PGF7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxNUismP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxNUismP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C061F000E9;
	Wed, 12 Aug 2026 12:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786536507;
	bh=2vcnLyqIJO0q3utlo2EwokV7y/VMv6zo8H6nKpVDR4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KxNUismP4bQX/ZOiuaSZqAbLyTYAzS1hBbUY0zL/WRWwiVQygBfeXmfnKgrvCXDJ9
	 Pf6rymqHxdE88pDKVwjJrnpeIO2R9MMLm320Fw+QLUVVP5mQADe7jJ7cXidE7OxZMZ
	 OcDh//cqYtiAESvZPijhd0LfTbDZAR/Dd8ONBpBJ9XTxwa5Rc2AZnZnnOovB472Kvc
	 XyGu9wjMRYNSkq26KaDBoEmtYI+VRGO3Gk7vkas/8DdtYB+Nxg7oJhXWOPED5RdFr4
	 Ig92MH0j7HiCltQUq+sbcfIXXvHwCHDKGVQDb3769Qu2HWgbYEAZmq5XCKai3flZpy
	 +34AQCwqgGR3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/6] cxl/region: Don't leak tolerated RAM -EFAULT
 from unmapped poison scan
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260812112107.56181-4-icheng@nvidia.com>
References: <20260812112107.56181-1-icheng@nvidia.com>
 <20260812112107.56181-4-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 12:08:26 +0000
Message-Id: <20260812120827.53C061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] cxl_get_poison_by_memdev() fails to break the loop on error, poten=
tially overwriting a failing return code with a success return code from a =
subsequent partition.
--

--- Patch [3]: [PATCH v4 3/6] cxl/region: Don't leak tolerated RAM -EFAULT =
from unmapped poison scan ---
commit a0d57b2595f3317a70e0887bd131f7b1df706fef
Author: Richard Cheng <icheng@nvidia.com>

cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan

cxl_get_poison_unmapped() tolerates the -EFAULT a RAM partition returns
for Get Poison List by skipping that partition, but left rc holding the
error. If the tolerated RAM fault was the last poison query before the
loop ended, the function returned a spurious -EFAULT and the poison-list
read failed even though enumeration succeeded. Reset rc to 0 when
tolerating the fault, matching poison_by_decoder().

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b03f30c04d350..ddf12075b95c0 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2930,8 +2930,10 @@ static int cxl_get_poison_unmapped(struct cxl_memd=
ev *cxlmd,
>  		if (!length)
>  			continue;
>  		rc =3D cxl_mem_get_poison(cxlmd, offset, length, NULL);
> -		if (rc =3D=3D -EFAULT && cxlds->part[i].mode =3D=3D CXL_PARTMODE_RAM)
> +		if (rc =3D=3D -EFAULT && cxlds->part[i].mode =3D=3D CXL_PARTMODE_RAM) {
> +			rc =3D 0;
>  			continue;
> +		}
>  		if (rc)
>  			break;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but was introduced in an earlier
commit be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode"). Seeing the loop
here made me look at similar code in drivers/cxl/core/memdev.c.

Does cxl_get_poison_by_memdev() fail to break the loop on error?=20

drivers/cxl/core/memdev.c:cxl_get_poison_by_memdev() {
	for (int i =3D 0; i < cxlds->nr_partitions; i++) {
		const struct resource *res =3D &cxlds->part[i].res;

		offset =3D res->start;
		length =3D resource_size(res);
		rc =3D cxl_mem_get_poison(cxlmd, offset, length, NULL);
		/*
		 * Invalid Physical Address is not an error for
		 * volatile addresses. Device support is optional.
		 */
		if (rc =3D=3D -EFAULT && cxlds->part[i].mode =3D=3D CXL_PARTMODE_RAM)
			rc =3D 0;
	}
}

If cxl_mem_get_poison() fails for an early partition (like partition 0) due=
 to
a hardware mailbox timeout and returns an error like -EIO, rc is set to the
error code. Since the loop lacks an if (rc) break; statement, it proceeds to
the next partition.

If the subsequent partition succeeds, rc is overwritten with 0, and the
function returns success. This masks the failure on partition 0 and leaves =
the
kernel unaware of poisoned memory.

Could this missing break statement lead to unhandled machine checks and
potential data corruption if that poisoned memory is accessed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812112107.5618=
1-1-icheng@nvidia.com?part=3D3
