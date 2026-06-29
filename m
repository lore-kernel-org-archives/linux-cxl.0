Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C592E7396
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782755564; cv=none; b=hSJNKbBxJ83+ymqY7a5k9lwWPUj2gqwst7VLI16KUoh86JvEBVvrRShQQ5GwTO0+RpLLVjoQyvM71WABPsWaKGpzViyOULzmmiTT0xvgpDKohmXODzaP29MdK8nkYr7tqu7GRmPV16iBxKuHaYueUgwxqixGTY39+i5ZvsxPlWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782755564; c=relaxed/simple;
	bh=R5ISF7+W7mR5k/ogaIgmT+mjqIJ18IcMrJwVxOH/nOw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DhhmtP/iJqA5hiZrENnf4V7ZR4e99kwvbcIMVpag/74U97FahxIdWnv+LO1AzFNyTaDS0FutoW/xnGpzwo3LJujRdBA1CwTfd09e9xH2yYXg9FikQVoBg+kSB3JR01cZsBBpZaMvgbxGZ+YILBdNryMoo+n2iP8tQMGGSL4eK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUkGvQmI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUkGvQmI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEC11F000E9;
	Mon, 29 Jun 2026 17:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782755562;
	bh=d7lxR7lQMdaN52Ohz91zVZ5cW8tT+V9WHh6e3t4iQO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fUkGvQmI783FbnSjB/JEkZawlRnOLZGwoYV84/jh1t0sweUMtdoONRL5uEydzaJZN
	 wW8xGpnUjo+xUKDaPS0MzSzg47z7qzF/qOSKkfOfsKRR69Ce+8/o+PksPp9bKhceWT
	 63bqgJZhkfDHKFg/B5zZ2IZijBXWyTL2U43PCSJ6pL9nen/qwftXD18G6VUlxhmAEx
	 6LW70Tsm40VW2+MnSf6sMegd+/COiTMz3HohFlRZfW00Ufsl54t3k3CY1imrn72X+/
	 6Bg8vWWWtT21oZ36AgtpYbxgoqv/xvRBtK6JzD3alECrBuNifvXWZdBRHdGuIA0mjv
	 ytxQe8hwMGEpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v30 1/2] cxl: Support Type2 cxl regs mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260629183727.51502-2-alejandro.lucero-palau@amd.com>
References: <20260629183727.51502-1-alejandro.lucero-palau@amd.com>
 <20260629183727.51502-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 17:52:40 +0000
Message-Id: <20260629175242.3AEC11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit claims to export core functions for a Type2 driver to=
 discover and map device registers, but it fails to expose the mapping func=
tions in a public header.
--

commit e264e4eb8d1791f45613794c005249488536d8e2
Author: Alejandro Lucero <alucerop@amd.com>

cxl: Support Type2 cxl regs mapping

This commit creates a new public header file for CXL PCI definitions. It
exports the register setup function and register block identifier enum so
that out-of-subsystem Type2 drivers can discover device registers.

> Export cxl core functions for a Type2 driver being able to discover and
> map the device registers.

[ ... ]

> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> new file mode 100644
> index 0000000000000..3e0000015871a
> --- /dev/null
> +++ b/include/cxl/pci.h
> @@ -0,0 +1,22 @@

[ ... ]

> +struct cxl_register_map;
> +struct pci_dev;
> +
> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> +		       struct cxl_register_map *map);
> +#endif

[Severity: Medium]
The commit message mentions exporting functions to both discover and map de=
vice
registers, but are the mapping functions missing from this public header?

While cxl_pci_setup_regs() is exposed here for register discovery, the
functions needed to map those registers, cxl_map_component_regs() and
cxl_map_device_regs(), appear to remain unexported in the private
drivers/cxl/cxl.h header.

Does this regression prevent a Type 2 driver outside of drivers/cxl/ from
cleanly calling the mapping functions without duplicating prototypes or
violating subsystem boundaries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629183727.5150=
2-1-alejandro.lucero-palau@amd.com?part=3D1
