Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A495370AE0
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 20:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787864399; cv=none; b=ZJzRm9GRzR5IKb1JydpUtY9fKDpsyaHoGNKRXUtX05diSKdNfL+MMXAwHAcuvH/q8okP8rOp+dCb/e8pIhMzD4ubFmKat636YGVdTr674CZ4aKizLkdJbn8p/sjTMHTKVLiewplPeSUI6ADIrEWp+bQyJlKfmRNrdmdyBkeXQIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787864399; c=relaxed/simple;
	bh=4NK6E/lK8+TGe/k7L8gJEV+YNtelFqQULfrLo9v9HNY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pCzjHGVVVIkVkKBMoO9VXPAXSqEntqxXADrZRCfh6bhX717kBYusu3fqj/usxvWE26fsdLZ/iF7IR7u+PCmGmFYQj964ioVyWaBxg2IWB47k/NbxrZZDRsHNemi8adTz7EIpbTLnD7BjXbxyUCP/gCJxCw5jIR9brJmsGfWiMWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5kkqPfD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5kkqPfD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DD71F000E9;
	Thu, 27 Aug 2026 20:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787864398;
	bh=8XpyMpPwSq0JRyJ9TSMCFlb/bGAenfZhFizl3zlh8WI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O5kkqPfD1bKIhGNnqMAyi/S+vp1ordfXG3QCXkLbuT6b0HVWi0vfT5nf1OLC2hj7v
	 marTy4Qe5Sj1Yofr4SPXsCCwmgkkF1avAQKsV6J8rE1SVTrrvjkAMCejdUabZbIeuq
	 LqfD0dppAgk6g9vxzvueb9UUEaQI9+ySSa/tV6oEvGlIxhrgj1nUERDjJ5/0NV8TgJ
	 hv9MaZC3VxhP4zPN0xJ3AlE2616FUKt+WFcbQd8uvEAPpDGU1Sx5HtlihIHO4OLN/I
	 P2ppqDyujulWSiqFHFCApbUQOfph3xK5fVPsWJX6ZXU+tFWe6h/DXDv4/a10WbJKR4
	 fzrG1Ec9OpqcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/13] cxl/ras: Make cxl_cper_handle_prot_err()
 static
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260827203726.3027541-14-dave.jiang@intel.com>
References: <20260827203726.3027541-1-dave.jiang@intel.com>
 <20260827203726.3027541-14-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 20:59:57 +0000
Message-Id: <20260827205957.F3DD71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] CXL protocol error handling for memdevs silently fails because `ma=
tch_memdev_by_parent` incorrectly compares a `struct device *` to a `struct=
 pci_dev *`.
--

commit 4ee43d8db9fe927d9aa6ae55ad362c92db62074c
Author: Dave Jiang <dave.jiang@intel.com>

cxl/ras: Make cxl_cper_handle_prot_err() static

This commit drops the export and declaration of cxl_cper_handle_prot_err()
and makes it static, since its only caller remains in the same file.

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 99fb00949c2fa..eceb33bc534b3 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -77,7 +77,7 @@ static int match_memdev_by_parent(struct device *dev, c=
onst void *uport)
>  	return 0;
>  }
> =20
> -void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
> +static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data =
*data)
>  {

[Severity: High]
This is a pre-existing issue, but does this function silently fail to handl=
e=20
memory device protocol errors due to a pointer mismatch?

In cxl_cper_handle_prot_err(), bus_find_device() is called with pdev=20
(a struct pci_dev *) as the match data:

	struct device *mem_dev __free(put_device) =3D bus_find_device(
		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);

However, match_memdev_by_parent() expects uport to match dev->parent, which=
=20
is a struct device *:

static int match_memdev_by_parent(struct device *dev, const void *uport)
{
	if (is_cxl_memdev(dev) && dev->parent =3D=3D uport)
		return 1;
	return 0;
}

Because the struct device is embedded inside struct pci_dev at a non-zero=20
offset, dev->parent will never equal pdev. This causes bus_find_device() to=
=20
always return NULL, which silently ignores the protocol error instead of=20
tracing it.=20

Should bus_find_device() be passed &pdev->dev instead of pdev?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827203726.3027=
541-1-dave.jiang@intel.com?part=3D13
