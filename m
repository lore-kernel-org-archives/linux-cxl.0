Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0D240D567
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 22:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130727; cv=none; b=JKCu3yBMpc50WSUxLohDqyF/wNkarjgLKddQT/lqwVB4QKjQkHE1CAj7TpLXfWI0RbYRF52Orq9DQruN8Cz1nGMvDwCjwDdAwJlepO5x/fiaCDwWptVjIpQpZEqB7XXjHdWNlZJP3dgvidgMYh2cnnuIDIc8KB6cCgQZ00lJdcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130727; c=relaxed/simple;
	bh=v+T2dcG5YSu0OQYsFlwz+KKeFiBedhjksFdnKDEjbx4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pj5ikZgRgkUpGoLZKz0hC97y9p+jtXP9afkflsbebiswuqXhHIumc3ywi4aT0ffkWqS6JNcwYP2HlGuGHACISXkXwLye+miOFSnMg2OoRDg1SZgRdcGqKgH8gzOYK/iGby1jMqloaX+N+9TAELx2acf9BnW3T0W5ORSd7czmBkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcHBKgRB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcHBKgRB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB451F00893;
	Wed, 10 Jun 2026 22:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781130725;
	bh=nQz5HnpI3n/7ljNsosiTJgfSezTqGCGH5dE83ZjpQ6I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DcHBKgRBu8YpoPWGaZ6hQwl9PJm8Q/7fJPNrwqIuDleqIrzjxkJW2I6gh8IeRV5pK
	 3A2AuDzEJcpw3vQueChaBJs8O02mNsNtIwDLTkdDpQLrBUi9kq7DNdp3WBB9dN6tZi
	 a2HRWCYVM5nJzr+9+7jdCjVNUF1vIl/Bs0O+QmbBPkfW2Em8JRFcrZS9hpe2sDwqXE
	 aYdbrfl5PTwuuee+gClzD78v7I/B6EjOfYtEWRLYmzNVDWM2FDqaejzhq8GvnFgGiq
	 AsCIHXhYPBdpvqSOgQB0s3jwVZ5tV+zcZidAofHdaSYAUS4uUM7IpRmsv2DwoLhtxw
	 LvgtB6vjVWmXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] cxl/test: Add test for module parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260610222328.2272427-2-dave.jiang@intel.com>
References: <20260610222328.2272427-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 22:32:05 +0000
Message-Id: <20260610223205.9DB451F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The function `have_multiple_modparms()` fails to check the `hmem=
_test` module parameter, allowing multiple test parameters to be activated =
simultaneously.
- [Low] The newly added function `have_multiple_modparms` is missing the `s=
tatic` modifier, making it globally visible.
--

commit a298e853a144eb87f633b800d6fcf071d2088371
Author: Dave Jiang <dave.jiang@intel.com>

cxl/test: Add test for module parameters

This commit adds a test during module initialization to ensure that only
a single module parameter is activated at a time.

> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 296516eecfd6a..b00f5161b5f0c 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1814,11 +1814,29 @@ static struct attribute *cxl_acpi_attrs[] =3D {
>  };
>  ATTRIBUTE_GROUPS(cxl_acpi);
> =20
> +bool __init have_multiple_modparms(void)

[Severity: Low]
Should this function be declared static? It appears to only be used locally
within this file, and omitting the static keyword exports it to the global
namespace, which might trigger missing-prototype compiler warnings.

> +{
> +	int count =3D 0;
> +
> +	if (interleave_arithmetic)
> +		count++;
> +	if (extended_linear_cache)
> +		count++;
> +	if (fail_autoassemble)
> +		count++;

[Severity: Medium]
Does this check miss the hmem_test parameter? The cxl_test module is built
from both cxl.c and hmem_test.c, and hmem_test.c defines its own parameter.
It seems a user could load the module with hmem_test=3D1 and one of the loc=
al
parameters (like extended_linear_cache=3D1) concurrently, bypassing this ch=
eck.

> +
> +	return count > 1;
> +}
> +

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610222328.2272=
427-1-dave.jiang@intel.com?part=3D1
