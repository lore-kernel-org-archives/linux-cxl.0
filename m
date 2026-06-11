Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00102DC32E
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191912; cv=none; b=FWqfLKjn2EpI2c1OzTiPtV7VLKFlRRGNvwJC1YnYFTcdoJr+7RK5GGohcnjcWKahYx/hur1/ldxTP8MWzbHtZvjLiaXMHQvFD4NI5Zq/glcXqTG6rnbM2TzpAAqVDZe33y8dtFYo71hikyWuokwKBehB2OirVMu2+z+DoQ9Mk1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191912; c=relaxed/simple;
	bh=WB0r9+vcN19nMIkoEz1zoF7JaivmURSHVfl4yD6nSdw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eJhHTfieBnQKU8ozkxOXUQyoAaTBk1l+jrREl9C2UtYjSzDWjg3EBKHZPKVFukk5Y52SHYiEMlcW+vTjRYN6govbF3EWoSBrbE1wiXdVdroAIxUuVErSX0lI0vArYe8gjc/1SeB5CTp//jp+fXO4rscp9RyM2lM9OWl7RY47io4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxUko2JB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxUko2JB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7D31F00893;
	Thu, 11 Jun 2026 15:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781191911;
	bh=/yTBBzxOW3w/qH48Cs7SJ1DlRIUPJkB67j7cpcJoo+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dxUko2JBORu9g83Qv09lubE1Nf08urkwk0Mm9LL+7mW/RXjbCxl5YAE/qndaBaraD
	 I0nf/LdcNBym0OenF9NFea7Z8fcheCzQi7wLebNCgDJLrNBkh9CToNAcMBGHp+yq21
	 pkAtCPYMP0SbhwsMyvXySAwOwUDlW+ToEBoPiFfDtt8hx+FL9QxnwwBHECdHl/uU2W
	 xJ/rlAyc0NG+VWakaSEb0tfULKVkGhbbw7Kygx0wZu6A8mOjb/Kq5a1jm+yqmmpCVD
	 57KjO7Bi5hUqCPoWKwztfo56dp0ItV/kCW2dVz3I4nX/da+izHZfe6DK0U+vBCx2kL
	 8xHin4TYNmEQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/6] cxl/test: Add hierarchy enumeration support for
 type2 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260611152124.3656434-5-dave.jiang@intel.com>
References: <20260611152124.3656434-5-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 15:31:50 +0000
Message-Id: <20260611153151.4A7D31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The topology teardown functions remove devices in forward (parent-=
to-child) order, causing use-after-free and double-free vulnerabilities.
- [High] Double `platform_device_put()` on `cxl_acpi` when `cxl_mock_platfo=
rm_device_add()` fails.
--

commit 7f72f92a89170bc076d1c5ae46854f2ff2fcf32d
Author: Dave Jiang <dave.jiang@intel.com>

cxl/test: Add hierarchy enumeration support for type2 device

Add enumeration of type2 device hierarchy in cxl-test. The type2 device
is setup to be directly attached to a root port instead of rp -> switch
-> device that type3 hierarchy is setup..

> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 71b6203d2fcf0..de4124afa1328 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
[ ... ]
> @@ -2049,6 +2137,92 @@ static int cxl_switches_populate(void)
>  	return 0;
>  }
> =20
> +static void cxl_type2_topo_exit(void)
> +{
> +	host_bridges_remove();
> +	cxl_rootports_remove();
> +}

[Severity: High]
Does this topology teardown order cause a use-after-free? When the parent
device (host bridge) is removed, the driver core recursively unregisters and
frees its child devices. It seems that calling cxl_rootports_remove() after
host_bridges_remove() will operate on already-freed platform_device
pointers. Should the teardown be done in bottom-up (reverse) order?

> +
> +static int cxl_type2_topo_init(void)
> +{
[ ... ]
> +static void cxl_type3_topo_exit(void)
> +{
> +	host_bridges_remove();
> +	cxl_rootports_remove();
> +	cxl_switches_remove();
> +	cxl_single_topo_exit();
> +	cxl_rch_topo_exit();
> +}

[Severity: High]
Similarly here in cxl_type3_topo_exit(), does removing parent devices before
their children cause the subsequent removal functions to access freed memor=
y?

[ ... ]
> @@ -2122,7 +2280,7 @@ static __init int cxl_test_init(void)
> =20
>  	rc =3D cxl_mock_platform_device_add(cxl_acpi, NULL);
>  	if (rc)
> -		goto err_rch;
> +		goto err_root;
> =20
>  	rc =3D cxl_mem_init();
>  	if (rc)
> @@ -2138,16 +2296,8 @@ static __init int cxl_test_init(void)
>  	cxl_mem_exit();
>  err_root:
>  	platform_device_put(cxl_acpi);

[Severity: High]
If cxl_mock_platform_device_add() fails, it drops the reference to cxl_acpi
before returning. Jumping to err_root will call platform_device_put()
a second time on the same pointer. Does this result in a double-free?=20

In the pre-patch code, the error path jumped past this to err_rch, which
bypassed the extraneous put.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611152124.3656=
434-1-dave.jiang@intel.com?part=3D4
