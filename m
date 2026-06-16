Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2C7244687
	for <linux-cxl@vger.kernel.org>; Tue, 16 Jun 2026 01:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781571788; cv=none; b=Li/GkdYdinEsYeydKRbyr1L4yNfhsNIBzfLVqaEeMb7dirydAf6+gZtDbg9joReU11OHfdtFCkbmkDtFUvt302C7mRhRjcR6TX6noWJwWFB1pyhTM1Ff+VJWRPPziJNdT68lm2uo9UUHzZ0QZqDPBmF6BGiuhQgQcISvc9w2Nds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781571788; c=relaxed/simple;
	bh=qeJDPGqaUWutYrMiFCA2AWKblYCv2U1Wg2tHw5N6Kzo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QveMc85a/nPv5ih0EnS7J7nTYrlf7/q8pIY0yY564+YFpcVA/gt8dctCPZhm+xQO/A05yafpZhmgUNT6tjNjmkB8PBb+hRobmmUT93lUmp3OViofaXn2BbRrMFUI1ISpuklrSsPMVTU6j7YDewTnx56WTNiohBJoSE0Lz4nxil8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQ1lKd6L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQ1lKd6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314E61F000E9;
	Tue, 16 Jun 2026 01:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781571787;
	bh=Y6htb6krwwy00hPzuUViuOjy4T10xjf/ZjX6evxfSd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hQ1lKd6LZkz6NWrHLSe/ejgGc+tghbQ7YBm9JnilsmYPO8r8SxDBjjXlGBvGdDvi6
	 sHSLBVlYg1tYJ43bm4gmVITI5VNBJMlZzp9ssG852CD0szxdKQi9jS/UU/bjl4fx5P
	 SjO4su4BbWjojnTVmvcqZA9inRN8EhwXy0zC3+bC5z4UsfZyYhR4zSlO6QO1QiCpuk
	 WCYTMecV8xeuMPq5eKdhdYPIQSaY5V27SV9aZU9oSgaQ6MEJgzuTBvKgc3g88MH/nr
	 2A4wjjY65PedMrXy65cEsZdxUQagGlVXq3tWYr7/B6gFJc6bNrpR4n9dthgoKpE2vg
	 2dW4eK6BNMYag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] cxl/mce: Serialize the MCE handler against endpoint
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260616004007.4186004-3-dave.jiang@intel.com>
References: <20260616004007.4186004-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:03:06 +0000
Message-Id: <20260616010307.314E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The MCE notifier accesses a freed `cxlmd` structure and attemp=
ts to lock its mutex if an MCE occurs during device teardown, leading to a =
Use-After-Free and kernel crash.
--

commit a9bb7894eaa94a0fe2d0d4c6dd69b86cf2d1fe0f
Author: Dave Jiang <dave.jiang@intel.com>

cxl/mce: Serialize the MCE handler against endpoint teardown

This commit modifies the MCE handler to take the cxlmd lock before verifying
the endpoint pointer. It then takes a reference on the endpoint device to
ensure it remains alive during access.

> diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
> index 47566015eb006..e684e411921b9 100644
> --- a/drivers/cxl/core/mce.c
> +++ b/drivers/cxl/core/mce.c
> @@ -7,13 +7,27 @@
>  #include <cxlmem.h>
>  #include "mce.h"
> =20
> +static struct device *cxlmd_get_endpoint_dev(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint;
> +
> +	if (!cxlmd)
> +		return NULL;
> +
> +	guard(device)(&cxlmd->dev);

[Severity: Critical]
This is a pre-existing issue, but does accessing cxlmd here lead to a
use-after-free if a Machine Check Exception occurs during device teardown?

During device teardown or driver unbind, devm actions execute in reverse
order. The MCE notifier is registered before the cxl_memdev structure
is allocated, which means cxl_memdev is unregistered and its memory freed
before the MCE notifier is deactivated.

While cxl_memdev_shutdown() clears cxlmd->cxlds, it does not clear
mds->cxlds.cxlmd. This leaves mds->cxlds.cxlmd as a dangling pointer.

If a Machine Check Exception happens during this window, cxl_handle_mce()
will read the freed cxlmd pointer and pass it here. Attempting to lock a
mutex inside freed memory will cause memory corruption or a crash.

> +	endpoint =3D cxlmd->endpoint;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616004007.4186=
004-1-dave.jiang@intel.com?part=3D2
