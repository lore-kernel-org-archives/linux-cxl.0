Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047B02DEA94;
	Tue, 11 Nov 2025 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875057; cv=none; b=aEQsQ04KxpLAqVbhUYHMVPyz552i9Hrwj5BeM4c/6vDOuuS2sCeI1NwHYNOOwxE3jDA3guuEnQWvmIAHiuJgHb3AU/1PyMhXcuaz0AKJlyOL8HCTK5E+rUomhXb2pW7icr+VRtpCjupL7NVRZXq5Oyg8nLIyTEaa2ujNoe/TS5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875057; c=relaxed/simple;
	bh=xtDvONPSXwG37TqXIT6Jc7kPssXCPacNxnapoMLEZHo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Njl07rNV50QcG2XB2pEa6TGCM8dNqiZk+gjmhxeTzZqkPtO2T1qLNbjwfs+9ZeR83g4xqqY8f9gp30hU/nhwIoYi8R6hAvO2zFdChpWPY+DlMlDWsYQzM83/ZBrHYiKEH0qky7FzqvlnrPi1h1oMkyN6CYIC++lcW4l2m9+iZ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5Vpx5zV9zHnH71;
	Tue, 11 Nov 2025 23:30:33 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A43B1402F7;
	Tue, 11 Nov 2025 23:30:51 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 15:30:50 +0000
Date: Tue, 11 Nov 2025 15:30:49 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 10/14] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Message-ID: <20251111153049.00005ef3@huawei.com>
In-Reply-To: <20251103184804.509762-11-rrichter@amd.com>
References: <20251103184804.509762-1-rrichter@amd.com>
	<20251103184804.509762-11-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 3 Nov 2025 19:47:51 +0100
Robert Richter <rrichter@amd.com> wrote:

> Add AMD Zen5 support for address translation.
>=20
> Zen5 systems may be configured to use 'Normalized addresses'. Then,
> host physical addresses (HPA) are different from their system physical
> addresses (SPA). The endpoint has its own physical address space and
> an incoming HPA is already converted to the device's physical address
> (DPA). Thus it has interleaving disabled and CXL endpoints are
> programmed passthrough (DPA =3D=3D HPA).
>=20
> Host Physical Addresses (HPAs) need to be translated from the endpoint
> to its CXL host bridge, esp. to identify the endpoint's root decoder
> and region's address range. ACPI Platform Runtime Mechanism (PRM)
> provides a handler to translate the DPA to its SPA. This is documented
> in:
>=20
>  AMD Family 1Ah Models 00h=E2=80=930Fh and Models 10h=E2=80=931Fh
>  ACPI v6.5 Porting Guide, Publication # 58088
>  https://www.amd.com/en/search/documentation/hub.html
>=20
> With Normalized Addressing this PRM handler must be used to translate
> an HPA of an endpoint to its SPA.
>=20
> Do the following to implement AMD Zen5 address translation:
>=20
> Introduce a new file core/atl.c to handle ACPI PRM specific address
> translation code. Naming is loosely related to the kernel's AMD
> Address Translation Library (CONFIG_AMD_ATL) but implementation does
> not depend on it, nor it is vendor specific. Use Kbuild and Kconfig
> options respectively to enable the code depending on architecture and
> platform options.
>=20
> AMD Zen5 systems support the ACPI PRM CXL Address Translation firmware
> call (see ACPI v6.5 Porting Guide, Address Translation - CXL DPA to
> System Physical Address). Firmware enables the PRM handler if the
> platform has address translation implemented. Check firmware and
> kernel support of ACPI PRM using the specific GUID. On success enable
> address translation by setting up the earlier introduced root port
> callback, see function cxl_prm_translate_hpa_range(). Setup is done in
> cxl_setup_prm_address_translation(), it is the only function that
> needs to be exported. For low level PRM firmware calls, use the ACPI
> framework.
>=20
> Identify the region's interleaving ways by inspecting the address
> ranges. Also determine the interleaving granularity using the address
> translation callback. Note that the position of the chunk from one
> interleaving block to the next may vary and thus cannot be considered
> constant. Address offsets larger than the interleaving block size
> cannot be used to calculate the granularity. Thus, probe the
> granularity using address translation for various HPAs in the same
> interleaving block.
>=20
> Signed-off-by: Robert Richter <rrichter@amd.com>
A few things below.  Given they are just trivial formatting things
and I assume you'll fix the build bot issues.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
> new file mode 100644
> index 000000000000..d6aa7e6d0ac5
> --- /dev/null
> +++ b/drivers/cxl/core/atl.c
> @@ -0,0 +1,195 @@

> +static int cxl_prm_translate_hpa_range(struct cxl_root *cxl_root, void *=
data)
> +{
> +	struct cxl_region_context *ctx =3D data;
> +	struct cxl_endpoint_decoder *cxled =3D ctx->cxled;
> +	struct cxl_decoder *cxld =3D &cxled->cxld;
> +	struct cxl_memdev *cxlmd =3D ctx->cxlmd;
> +	struct range hpa_range =3D ctx->hpa_range;
> +	struct pci_dev *pci_dev;
> +	u64 spa_len, len =3D range_len(&hpa_range);
> +	u64 addr, base_spa, base =3D hpa_range.start;

This is getting a bit nasty to read. I'd split the declarations
that initialize from the ones that don't. So use a couple more lines
to help readability a little.

> +	int ways, gran;
> +
> +	/*
> +	 * When Normalized Addressing is enabled, the endpoint
> +	 * maintains a 1:1 mapping between HPA and DPA. If disabled,
> +	 * skip address translation and perform only a range check.

Wrap is a little short. 80 chars for code and comments (unless there
is reason to go longer).

> +	 */
> +	if (hpa_range.start !=3D cxled->dpa_res->start)
> +		return 0;
> +
> +	if (!IS_ALIGNED(hpa_range.start, SZ_256M) ||
> +	    !IS_ALIGNED(hpa_range.end + 1, SZ_256M)) {
> +		dev_dbg(cxld->dev.parent,
> +			"CXL address translation: Unaligned decoder HPA range: %#llx-%#llx(%s=
)\n",
> +			hpa_range.start, hpa_range.end, dev_name(&cxld->dev));
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * Endpoints are programmed passthrough in Normalized
> +	 * Addressing mode.

Tiny bit early on the wrap.  Aim for 80 chars, which puts addressing on the=
 line above.

> +	 */
> +	if (ctx->interleave_ways !=3D 1) {
> +		dev_dbg(&cxld->dev, "unexpected interleaving config: ways: %d granular=
ity: %d\n",
> +			ctx->interleave_ways, ctx->interleave_granularity);
> +		return -ENXIO;
> +	}
> +
> +	if (!cxlmd || !dev_is_pci(cxlmd->dev.parent)) {
> +		dev_dbg(&cxld->dev, "No endpoint found: %s, range %#llx-%#llx\n",
> +			dev_name(cxld->dev.parent), hpa_range.start,
> +			hpa_range.end);
> +		return -ENXIO;
> +	}
> +
> +	pci_dev =3D to_pci_dev(cxlmd->dev.parent);
> +
> +	/* Translate HPA range to SPA. */
> +	hpa_range.start =3D base_spa =3D prm_cxl_dpa_spa(pci_dev, hpa_range.sta=
rt);
> +	hpa_range.end =3D prm_cxl_dpa_spa(pci_dev, hpa_range.end);
> +
> +	if (hpa_range.start =3D=3D ULLONG_MAX || hpa_range.end =3D=3D ULLONG_MA=
X) {
> +		dev_dbg(cxld->dev.parent,
> +			"CXL address translation: Failed to translate HPA range: %#llx-%#llx:=
%#llx-%#llx(%s)\n",
> +			hpa_range.start, hpa_range.end, ctx->hpa_range.start,
> +			ctx->hpa_range.end, dev_name(&cxld->dev));
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * Since translated addresses include the interleaving
> +	 * offsets, align the range to 256 MB.
> +	 */
> +	hpa_range.start =3D ALIGN_DOWN(hpa_range.start, SZ_256M);
> +	hpa_range.end =3D ALIGN(hpa_range.end, SZ_256M) - 1;
> +
> +	spa_len =3D range_len(&hpa_range);
> +	if (!len || !spa_len || spa_len % len) {
> +		dev_dbg(cxld->dev.parent,
> +			"CXL address translation: HPA range not contiguous: %#llx-%#llx:%#llx=
-%#llx(%s)\n",
> +			hpa_range.start, hpa_range.end, ctx->hpa_range.start,
> +			ctx->hpa_range.end, dev_name(&cxld->dev));
> +		return -ENXIO;
> +	}
> +
> +	ways =3D spa_len / len;
> +	gran =3D SZ_256;
> +
> +	/*
> +	 * Determine interleave granularity
> +	 *
> +	 * Note: The position of the chunk from one interleaving block
> +	 * to the next may vary and thus cannot be considered
> +	 * constant. Address offsets larger than the interleaving
> +	 * block size cannot be used to calculate the granularity.

Wrap looks short.

> +	 */
> +	while (ways > 1 && gran <=3D SZ_16M) {

As ways isn't modified in here, I think it would clearer as
	if (ways > 1) {
		while (gran < SZ_16M) {
			addr =3D prm_cxl_dpa_spa(pci_dev, base + gran);
			if (addr !=3D base_spa + gran)
				break;
			gran <<=3D 1;
		}
	}
> +		addr =3D prm_cxl_dpa_spa(pci_dev, base + gran);
> +		if (addr !=3D base_spa + gran)
> +			break;
> +		gran <<=3D 1;
> +	}
> +
> +	if (gran > SZ_16M) {
> +		dev_dbg(cxld->dev.parent,
> +			"CXL address translation: Cannot determine granularity: %#llx-%#llx:%=
#llx-%#llx(%s)\n",
> +			hpa_range.start, hpa_range.end, ctx->hpa_range.start,
> +			ctx->hpa_range.end, dev_name(&cxld->dev));
> +		return -ENXIO;
> +	}
> +
> +	ctx->hpa_range =3D hpa_range;
> +	ctx->interleave_ways =3D ways;
> +	ctx->interleave_granularity =3D gran;
> +
> +	dev_dbg(&cxld->dev,
> +		"address mapping found for %s (hpa -> spa): %#llx+%#llx -> %#llx+%#llx=
 ways:%d granularity:%d\n",
> +		dev_name(ctx->cxlmd->dev.parent), base, len, hpa_range.start,
> +		spa_len, ways, gran);
> +
> +	return 0;
> +}
> +
> +void cxl_setup_prm_address_translation(struct cxl_root *cxl_root)
> +{
> +	struct device *host =3D cxl_root->port.uport_dev;
> +	u64 spa;
> +	struct prm_cxl_dpa_spa_data data =3D { .spa =3D &spa, };

Trailing comma is a tiny bit pointless as any change will have to replace
the line anyway.  So I'd drop it. (trivial so ignore if you like ;)

> +	int rc;


