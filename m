Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7CB5013BD
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788545815; cv=none; b=uTU+DmMbpnNeWKw0Sjti21TlX4JOpH3HuYYdcVEDorbnnS9Nl+F1WkQ4YMaDmRfFeVBiRxYt5Us8QHSiR6UEdNaUorNsjNw5+uDuhU4lnBAI9PaHLzFIkJf2fdY0Qi+nAh80NjQLdap3Q3ZzgQSTY9LoNZWxQWBwQJujFDhxYqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788545815; c=relaxed/simple;
	bh=1PVa5um7WfIB/xadIrHIDg6T40sapTrTmLpvJz3q58Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=awlT/3VYkzfPdCskNOG5vCHCBJ+wiWcEiGoNm8zUmxRBcY80lVlOANAePHHRqUYyMK1xTcBhCAqHPjAYI3VBpzyxBw3Okdll7/SOqyejmJyVF7xhkW3krLMXQX/luw6w1vk8LPzNtUoMZpLm6atzXZg9/cfJjjr6avnpH0o3nsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8qDisJt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8qDisJt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEF21F00A3D;
	Fri,  4 Sep 2026 18:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788545813;
	bh=AxOrFdq0S8/uKSt1QxNpDC0Ixdk+SopZvgFK3w9R1zk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K8qDisJtdTNx4EMIFL9JQ6zuwrn9Kz2O7ZeW9+XjIWrMmbAgesgdLhPVMpcHkvzGJ
	 /PXsVOgigC3FPpYn3X2chyJu0ojFlgLE/aV2CLOtl3YGL2zvNhmvriUV6hE+Br1Zgz
	 HPiLRMc+N+HSydgweYLXSWxf4RBkiIXUJBpmCBD6X89Pxpe10d/K+EHdh6QFaKYsQ6
	 8Bpfjjzt3Sxsd3OFdfFiPm4HTi6IxZxB4XbIP5I2DIjxJlEULJMXWzKn4LZtTab0ro
	 1HzTLxP3YCZQvtR5xXpNQVMh9/ylnexmgSCwNBxzSKeZHKmVvcbkCDlryvFB7G2RKM
	 5pCoux7MfEBJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/13] cxl/ras: Make cxl_cper_handle_prot_err()
 static
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260904172337.1409775-14-dave.jiang@intel.com>
References: <20260904172337.1409775-1-dave.jiang@intel.com>
 <20260904172337.1409775-14-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 18:16:52 +0000
Message-Id: <20260904181653.3EEF21F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] bus_find_device() is passed a struct pci_dev pointer instead of a =
struct device pointer, causing the match function to always fail and skippi=
ng CXL CPER endpoint error tracing.
--

commit 8c6686bf6f4e6de777942d8a16f6142155da2ee3
Author: Dave Jiang <dave.jiang@intel.com>

cxl/ras: Make cxl_cper_handle_prot_err() static

The extlog caller went away when extlog switched to
cxl_cper_post_prot_err(), leaving cxl_cper_prot_err_work_fn() in the same
file as the only caller. Drop the export and the declaration in
<cxl/event.h>, and make it static.

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index e307361bb39e4..c91db125a9714 100644
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

[Severity: High]
This is a pre-existing issue, but I noticed a bug in how this function
searches for the memdev using bus_find_device().

Does this code always fail to match the memdev, skipping the CXL CPER
endpoint error tracing entirely?

Inside cxl_cper_handle_prot_err(), bus_find_device() is called with pdev
(a struct pci_dev pointer) as the search context:

drivers/cxl/core/ras.c:cxl_cper_handle_prot_err() {
    ...
	struct device *mem_dev __free(put_device) =3D bus_find_device(
		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
    ...
}

However, match_memdev_by_parent() expects uport to be a pointer to a
struct device in order for the comparison to work:

drivers/cxl/core/ras.c:match_memdev_by_parent() {
	if (is_cxl_memdev(dev) && dev->parent =3D=3D uport)
		return 1;
	return 0;
}

Because struct device is embedded inside struct pci_dev at a non-zero
offset, dev->parent will never equal the pdev pointer. This guarantees
bus_find_device() will return NULL, causing hardware protocol errors on
CXL memory devices to be silently dropped instead of being traced.

Should bus_find_device() be called with &pdev->dev instead of pdev?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904172337.1409=
775-1-dave.jiang@intel.com?part=3D13
