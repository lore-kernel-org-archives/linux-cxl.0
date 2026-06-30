Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EDC22424C
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830362; cv=none; b=YKv/nvZqbFiHIeWk1ZtSsfrM5WH29t0y7X3rXkb/MKucEP0/OuW3zCQq7+NwjO6Pkiznz7R7PY5tw6aRCz+Ecdys8C4Cn358bEozYtx1JQ2cHYAR4HLJwhzYqBW88kY9eG1vIYMPPADjd/YBEdK2OwzzRdtlwDj+S9dAziir7NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830362; c=relaxed/simple;
	bh=Xkwsv5Ej52KKUnn+o4Rhob8fYe+NGBulGOHwCpttoiY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TWqTdfiCQoVfRYO4ywJwDnm1FYSmgSzvLTqEvuMiy2wST9ZVvZ82hqIZCugGQagUZxCM2qxTzp6/xVu8/2j8jUqh/0eJmqlau0Ki6DMU4WEI3hyjpbreZJxaEgl/kRI4jZT3jEfu0yPE5wLYSfYydBU/9MvWJ0rrhDKrjVObPH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADEleIdG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADEleIdG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF7C1F000E9;
	Tue, 30 Jun 2026 14:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782830361;
	bh=JyLviq3tOycnpGCwc2zW03In/fXLsHtHxP8aVwH4Mc0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ADEleIdGb1UeUKlFqftzgzC+2VQxKG6jwA5qjulK3oAv6t/UMxtZKnmicB3cLUjNL
	 K0rrhVu05fmLTDWk6DvjQ06nAmcv+pLU6Oz1Cx7iSy0ibK3ERR8hj6Ue5uc7K9aVR2
	 lbocExqdmgmCAnHMZqHd83bNhN4U8OKRKXeTm2VaXEYOez2TD1svn0DzIRfAQdM+lN
	 ltOgljmaKGN+Fxge6qCRqkrxV4Wa/nRjTH4O2a+f6izyZbCobAobYhtles8cbxW2++
	 5A5ozAL5BAgtnI8zr9Gna7ANV4ZldlMSCKparycN1BL4LZOhYs8QKWLMbUm1RjreJh
	 QoSDbyTZUuRaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v31 2/5] sfc: Map cxl regs
Reply-To: sashiko-reviews@lists.linux.dev
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260630151346.31201-3-alejandro.lucero-palau@amd.com>
References: <20260630151346.31201-1-alejandro.lucero-palau@amd.com>
 <20260630151346.31201-3-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 14:39:20 +0000
Message-Id: <20260630143920.BCF7C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit adds `#include <cxl/pci.h>`, but `include/cxl/pci.h` doe=
s not exist in the kernel tree, resulting in a fatal compilation error.
--

commit fd1792aaa5cf6782d5137f23ed3db63b260303d5
Author: Alejandro Lucero <alucerop@amd.com>

sfc: Map cxl regs

This commit introduces CXL core functions to the SFC driver for discovering
and mapping CXL device registers. It sets up the component registers and
verifies the presence of HDM and RAS capabilities.

> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sf=
c/efx_cxl.c
> index be252af972ab3..704b0ebae9374 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -7,6 +7,8 @@
> =20
>  #include <linux/pci.h>
> =20
> +#include <cxl/cxl.h>
> +#include <cxl/pci.h>

[Severity: Low]
Is this the correct header path? The cxl/pci.h file doesn't appear to exist
in the kernel tree. The cxl_pci_setup_regs() function and the
CXL_REGLOC_RBI_COMPONENT enum seem to be defined in drivers/cxl/cxlpci.h,
which is internal to the CXL subsystem and not exposed to other drivers.
Will this cause a build failure when compiling the sfc driver?

[ ... ]

> @@ -42,6 +45,29 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	if (!cxl)
>  		return -ENOMEM;
> =20
> +	rc =3D cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
> +				&cxl->cxlds.reg_map);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630151346.3120=
1-1-alejandro.lucero-palau@amd.com?part=3D2
