Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7A83AA9E8
	for <linux-cxl@vger.kernel.org>; Wed,  8 Jul 2026 07:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497236; cv=none; b=aSa37Rv+ptd2D1jJoi1g2VriIDswiAJPKmYjHg4POtZSL/VNxejH+7MvjVR8Cyk+MH3oemoHXZfSGdx6ZSzjVVWJcg30+bxRUNSgRHTfJ+YCB344RI3YBatLCp8orACzXPIxIef/Z7B49BftPQzaqNDysc+4a1yGGvCJDJVRWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497236; c=relaxed/simple;
	bh=oPpOA7HJY1l/e280ElqnmiURCVsqjjySngrmMpV+/zA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=soVEmVSdT/Zy2uGMGiy1TxnpjDTqAOWfPL2Wlvv4ge8Md5/KWjPqtVGXPzTHDV1H/IhLk+MxSSqrtalPPj8l/E1MHqkMDrv2VHme6ZyPKJw1xgUWH3KZor+vJsyibtbLhbe6ab/aHGlHtep4ujA3DU1eO6SNbaCELCabEt6GOQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNiA/oBe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNiA/oBe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5F61F000E9;
	Wed,  8 Jul 2026 07:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783497225;
	bh=rqeGCNG70U1Kdqwj8nZaIBFCaDpTu1MduZZIhwNuI0A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LNiA/oBe1oiJqveboqLu1fxNVTQqUTfMWV/RKyyI+ff/al6NnFhV+xn8PaE6kaE88
	 BZP3i9I2IFoehZe3lBzrYb9r6m6ZKrAqxrOKJSi9AhlIl/je/FwORYOLEM/6Sn6OyR
	 j+osSHp7SbKbUJ4axy9hMKMlS/AYazI06tkfXgVk9gMd/ZFs8XBlqb679ZE1ARHLv6
	 GtoZjUpFg2o1A0rr0rG6s3Kti1WHAoxwneDdKRXS240jlVYUq/FXwKrJcasvOtiLqI
	 mOUI69N5CCxY63ZKLsfxgVqQZlhlmvgHajPcotUCKtFK8SXSHL4PG8Yh/ew07NJ9IX
	 FLIpKjf1dAeZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] cxl/region: Don't leak tolerated RAM -EFAULT
 from unmapped poison scan
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260708074228.43654-4-icheng@nvidia.com>
References: <20260708074228.43654-1-icheng@nvidia.com>
 <20260708074228.43654-4-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 07:53:44 +0000
Message-Id: <20260708075345.7A5F61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded infinite loop in cxl_mem_get_poison() if the device retu=
rns 0 records but leaves FLAG_MORE set.
- [Medium] cxl_get_poison_by_memdev() does not abort on failure, silently o=
verwriting earlier errors if subsequent partitions succeed.
--

--- Patch [3]: [PATCH v3 3/5] cxl/region: Don't leak tolerated RAM -EFAULT =
from unmapped poison scan ---
commit 9b48fd52ca70c063c7f4e5fc8516877eba1fee39
Author: Richard Cheng <icheng@nvidia.com>

cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan

cxl_get_poison_unmapped() tolerates the -EFAULT a RAM partition returns
for Get Poison List by skipping that partition, but left rc holding the
error. Reset rc to 0 when tolerating the fault, matching poison_by_decoder(=
).

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index be246fb09c999..52ba8e9e42885 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2933,8 +2933,10 @@ static int cxl_get_poison_unmapped(struct cxl_memd=
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

While reviewing this change, I noticed a couple of related pre-existing
issues in other poison handling functions:

drivers/cxl/core/memdev.c:cxl_get_poison_by_memdev()

> 		rc =3D cxl_mem_get_poison(cxlmd, offset, length, NULL);
> 		/*
> 		 * Invalid Physical Address is not an error for
> 		 * volatile addresses. Device support is optional.
> 		 */
> 		if (rc =3D=3D -EFAULT && cxlds->part[i].mode =3D=3D CXL_PARTMODE_RAM)
> 			rc =3D 0;
> 	}
> 	return rc;

[Severity: Medium]
This is a pre-existing issue, but does cxl_get_poison_by_memdev() overwrite
previous error codes?

If an early partition fails (for example, returning -EIO) but a subsequent
partition succeeds, the loop lacks an if (rc) break; check. The rc variable
is overwritten with 0, masking the earlier failure from userspace.


drivers/cxl/core/mbox.c:cxl_mem_get_poison()

> 		nr_records =3D nr_records + le16_to_cpu(po->count);
> 		if (nr_records >=3D mds->poison.max_errors) {
> 			dev_dbg(&cxlmd->dev, "Max Error Records reached: %d\n",
> 				nr_records);
> 			break;
> 		}
> 	} while (po->flags & CXL_POISON_FLAG_MORE);

[Severity: High]
This is a pre-existing issue, but can this loop in cxl_mem_get_poison()
spin infinitely?

If a hardware device returns a payload with po->count =3D=3D 0 and the
CXL_POISON_FLAG_MORE flag set, nr_records won't increment. The safety bound
nr_records >=3D mds->poison.max_errors is never reached, which could cause a
kernel hang while holding mds->poison.mutex.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708074228.4365=
4-1-icheng@nvidia.com?part=3D3
