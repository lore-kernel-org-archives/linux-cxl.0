Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E9643CEE9
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831157; cv=none; b=o0nOv1ZPlJW9624stMVAXL/YTptjMdUN3u0k4m6BTvvh6ztlMI//x1ezs+1k4ACdq2MFYhxxVaEFkCcSWPzbvc65U+NUplhmOw4foV10pFJqLZZDDM5Z0arPwWxS/HfR5qGstIkS+WyMHUrL12yq3XqVVLiZVBoyMJHu7vjEwX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831157; c=relaxed/simple;
	bh=IPAjdMG47RlnuQGcjGfFcaDWdXXUyM3VbDraR6cvBWM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L2GetHBf/SyNwisbhVJbz/L/pQYd6fVFjS5oiANDGFWp4gD/Texs/iYYmGNQMat6MTu/yjMIqn1uXWvpCZnO6C0EIKr4+85iEFjzPLhbeh11rE9a8OfhGcfUztbQf6ywsYRr/P/5jWXIpEvCd/GJO1GQLw2RIlNutX/6NlkH1PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQ9KV7JY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQ9KV7JY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A0B1F000E9;
	Tue, 30 Jun 2026 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782831154;
	bh=jhJr6abuzEjDZMjnSrijJ/7iNhPj7s2IiddkHCF8PeU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AQ9KV7JYe/IaVlcWte9ebQR3EPvuEcEGxcRPtCPZ9ZFwyDMgOJH2+T3WA9VC36H6y
	 q5KSZUlmFP8oZIuGI6o6zMV3iZmQMWoqba/MsLjb7UoFz8Y7pQnmenc81AEPBqX3oR
	 6fgJ/QADVxqFyg2RuHNl2eF/sTewTSIzdwBgsrSJol4/8eoLvYEl7ztkhzJ7zC6a5Z
	 gz9xB41Bf0IjmEBmyc3ZtPi5XouQUod7HRz8oDJgRMKYm0WBMU4ZbkXwnWg1grytAl
	 ePbr7hU4i3d7TrSqLuuAiI/ozs46HNiLe9p9GLBNn2taS4Ss3eUTzi1ILYsHQWJKf6
	 qFNKweKHDqwQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v31 3/5] sfc: Initialize cxl dpa
Reply-To: sashiko-reviews@lists.linux.dev
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260630151346.31201-4-alejandro.lucero-palau@amd.com>
References: <20260630151346.31201-1-alejandro.lucero-palau@amd.com>
 <20260630151346.31201-4-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 14:52:33 +0000
Message-Id: <20260630145233.E9A0B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The patch adds a call to an undefined function `cxl_set_capacity()`=
, which will cause a build failure.
- [Low] The file includes `<cxl/pci.h>` which does not exist in the source =
tree, causing a build failure.
--

commit 658adf5bd8fde62f9bb534a3960bfeef69a61055
Author: Alejandro Lucero <alucerop@amd.com>

sfc: Initialize cxl dpa

Use cxl_set_capacity() for DPA initialization as no mailbox is
available.

> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sf=
c/efx_cxl.c
> index 704b0ebae9374..18b535b3ea405 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -68,6 +68,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	 */
>  	cxl->cxlds.media_ready =3D true;
> =20
> +	if (cxl_set_capacity(&cxl->cxlds, EFX_CTPIO_BUFFER_SIZE)) {

[Severity: Low]
Are we calling an undefined function here? cxl_set_capacity() is neither
declared nor defined anywhere in the kernel source tree, which causes a bui=
ld
failure.

> +		pci_err(pci_dev, "dpa capacity setup failed\n");
> +		return -ENODEV;
> +	}
> +
>  	probe_data->cxl =3D cxl;
> =20
>  	return 0;

[Severity: Low]
Is there a missing header file in this file? It includes <cxl/pci.h> which
does not exist in the kernel tree, causing a fatal compilation error:

drivers/net/ethernet/sfc/efx_cxl.c:
    ...
    #include <linux/pci.h>

    #include <cxl/cxl.h>
    #include <cxl/pci.h>
    #include "net_driver.h"
    ...

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630151346.3120=
1-1-alejandro.lucero-palau@amd.com?part=3D3
