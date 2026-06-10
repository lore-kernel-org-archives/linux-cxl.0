Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2C1286881
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 22:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130966; cv=none; b=Hl2Vbgn/dy151WuLeS+aPahpyfIYM5UTYxF1yJUDV5Znyz1froCLbx75KNYWFg4rUihMRUWOTKsjiFYp5JsfliWHLtmTVhEGEBQNMvSXL+PvLY7kkrpGR+eX2zBrg4rblddOrahOoHZtGCDWY0huOtoG3ZQSiwnLWFFjY1kzb3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130966; c=relaxed/simple;
	bh=Qlo7Abt7nT4NDubTai+OYsKZwWh3/x/NUydtN+qov4s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Scg4LDgHx21sQreCa2Hqxkx9wiY875df8qb67q4FEGz2zVq9SVfY9iJHIqnbo+OPVAhRO0TdzxUfMSHbGpxX7PHgmPBUuQJgihkg2eROI+M1gkrsRk/2vqxkvgrtcRCbVupvrPj+v/3cm4Oxi+VlDXr3hsFI/+Wi+Xk9ETLVsmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OR2yp6ZO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OR2yp6ZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3511F00893;
	Wed, 10 Jun 2026 22:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781130965;
	bh=aD0bhJBCTljzQSQ1YDgdmQCPIaA0kezucQDJVuaPMKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OR2yp6ZOjlvecsZ1Gy8ZwGELS40uhzdMdx4VRKonbNn2DIThyzqwRxh/IaZoOLBCe
	 BeI2wgBGzz1bvV80gCJMt7rj36/8vIUUMu2B4GUkg8TK8tZdFkLjmfNqjxqhv+mIOk
	 v0Ylf6pkexc+zl0TXq+uP4tnhqh27sXlQrbW9447mz+Hro8/bsG7ruudbiavwRqz53
	 DWCfrrK76lcC/en2gVoAFrT+ScrptNt1WCAEiyL1pc2gqI8bEqE+z9+I63A216tS0B
	 uMepFmSPECoKOQSMVIfyD2EooPhl1tsS+gFI9RfNMa4Ue6JIcaq/+OTRtF2bF+bS7r
	 zcIevdHi5c15A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] cxl/test: Add hierarchy enumeration support for
 type2 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260610222328.2272427-5-dave.jiang@intel.com>
References: <20260610222328.2272427-5-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 22:36:04 +0000
Message-Id: <20260610223605.0E3511F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Teardown loops iterate backwards but incorrectly use `break` whe=
n encountering a NULL pointer, causing persistent resource leaks on error p=
aths.
--

commit 53bf17c5a72c46ea341694a714ad1ee38917639a
Author: Dave Jiang <dave.jiang@intel.com>

cxl/test: Add hierarchy enumeration support for type2 device

Add enumeration of type2 device hierarchy in cxl-test. The type2 device
is setup to be directly attached to a root port instead of rp -> switch
-> device that type3 hierarchy is setup..

> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index b29be2597064e..5186a13b20aa9 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
[ ... ]
> +static int cxl_type2_mem_init(void)
> +{
> +	int i, rc;
[ ... ]
> +err_mem:
> +	for (i =3D NR_CXL_TYPE2_ACCEL - 1; i >=3D 0; i--) {
> +		struct platform_device *pdev =3D cxl_mem[i];
> +
> +		if (!pdev)
> +			break;
> +		platform_device_unregister(cxl_mem[i]);
> +	}
> +	return rc;
>  }

[Severity: Medium]
Will this teardown loop leak successfully allocated devices if an error
occurs before all iterations complete?

Because cxl_mem is populated sequentially starting from index 0, the higher
indices remain NULL if initialization fails partway through. Since this
teardown loop iterates backwards from the max index, it will immediately
hit an uninitialized NULL pointer at the top and break. This skips the
unregistration for any devices that were successfully allocated at lower
indices.

Could this use continue instead of break? Alternatively, since
platform_device_unregister() handles NULL pointers safely, could the check
be omitted entirely?

This same pattern appears in cxl_type2_mem_exit() and cxl_type3_mem_exit()
in this patch, as well as in pre-existing teardown loops like
cxl_usps_remove().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610222328.2272=
427-1-dave.jiang@intel.com?part=3D4
