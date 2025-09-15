Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E6F2FD7D6;
	Mon, 15 Sep 2025 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933996; cv=none; b=i9KMfAOY3Fe/+PQ814w8QIeyuUV3+zPNYqQ7tPs0eGSAuELCZ1WL6CI+7EUMEIGbidQ2X+nbU196C3JvJhMSZq/r89KjnzEj/UjgUwMIQZatkFKfiKZf24xvWOA8TZ+tkc1atkdWd2pjW4ldAdwN81F6NIB+iQgU2RjpJ1ar/6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933996; c=relaxed/simple;
	bh=lY7RFPV4gPA2gfgumslg2zAPShgFCGhgWaLAHCRIL+s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gbC8T3YTfhjdX9LgHg3q5zv0sLC82L3BftTmC+iXrz3VFlGwcN/DlzDZTR/pEw/m2I+PleaVB1zrXF7bj08KKTeGnCj5z3YEozlKD/4rXJdhPO5BfhQadIcGOBR1mMuv6X8ogJtYk4PWWcMw9KDGMqHicKICUkCJ/HkB7qEy6FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cQMTC59lkz6K9JR;
	Mon, 15 Sep 2025 18:58:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B319E140372;
	Mon, 15 Sep 2025 18:59:50 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 15 Sep
 2025 12:59:50 +0200
Date: Mon, 15 Sep 2025 11:59:48 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 11/11] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Message-ID: <20250915115948.0000415a@huawei.com>
In-Reply-To: <20250912144514.526441-12-rrichter@amd.com>
References: <20250912144514.526441-1-rrichter@amd.com>
	<20250912144514.526441-12-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 12 Sep 2025 16:45:13 +0200
Robert Richter <rrichter@amd.com> wrote:

> Add AMD Zen5 support for address translation.
>=20
> Zen5 systems may be configured to use 'Normalized addresses'. Then,
> CXL endpoints use their own physical address space and are programmed
> passthrough (DPA =3D=3D HPA), the number of interleaving ways for the
> endpoint is set to one. The Host Physical Addresses (HPAs) need to be
> translated from the endpoint to its CXL host bridge. The HPA of a CXL
> host bridge is equivalent to the System Physical Address (SPA).
>=20
> ACPI Platform Runtime Mechanism (PRM) is used to translate the CXL
> Device Physical Address (DPA) to its System Physical Address. This is
> documented in:
>=20
>  AMD Family 1Ah Models 00h=E2=80=930Fh and Models 10h=E2=80=931Fh
>  ACPI v6.5 Porting Guide, Publication # 58088
>  https://www.amd.com/en/search/documentation/hub.html
>=20
> To implement AMD Zen5 address translation the following steps are
> needed:
>=20
> AMD Zen5 systems support the ACPI PRM CXL Address Translation firmware
> call (Address Translation - CXL DPA to System Physical Address, see
> ACPI v6.5 Porting Guide above) when address translation is enabled.
> The existence of the callback can be identified using a specific GUID
> as documented. The initialization code checks firmware and kernel
> support of ACPI PRM.
>=20
> Introduce a new file core/atl.c to handle ACPI PRM specific address
> translation code. Naming is loosely related to the kernel's AMD
> Address Translation Library (CONFIG_AMD_ATL) but implementation does
> not dependent on it, nor it is vendor specific. Use Kbuild and Kconfig
> options respectively to enable the code depending on architecture and
> platform options.
>=20
> Implement an ACPI PRM firmware call for CXL address translation in the
> new function cxl_prm_to_hpa(). This includes sanity checks. Enable the
> callback for applicable CXL host bridges using the new cxl_atl_init()
> function.
>=20
> Signed-off-by: Robert Richter <rrichter@amd.com>
A few minor additions inline. =20

J
> ---
>  drivers/cxl/Kconfig       |   4 ++
>  drivers/cxl/core/Makefile |   1 +
>  drivers/cxl/core/atl.c    | 138 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/core.h   |   1 +
>  drivers/cxl/core/port.c   |   8 +++
>  5 files changed, 152 insertions(+)
>  create mode 100644 drivers/cxl/core/atl.c
>=20
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 48b7314afdb8..31f9c96ef908 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -233,4 +233,8 @@ config CXL_MCE
>  	def_bool y
>  	depends on X86_MCE && MEMORY_FAILURE
> =20
> +config CXL_ATL
> +       def_bool y

Given no help we can't turn this off manually and it's down to
whether ACPI_PRMT is configured or not.

To me this feels like something we should be able to control.
Not a huge amount of code, but none the less 'so far' it only
applies to particular AMD platforms yet ACPI_PRMT gets built
on ARM platforms and other stuff even on AMD (CONFIG_AMD_ATL_PRM)



> +       depends on ACPI_PRMT
> +
>  endif

> diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
> new file mode 100644
> index 000000000000..5fc21eddaade
> --- /dev/null
> +++ b/drivers/cxl/core/atl.c

> +struct prm_cxl_dpa_spa_data {
> +	u64 dpa;
> +	u8 reserved;
> +	u8 devfn;
> +	u8 bus;
> +	u8 segment;
> +	void *out;

If reality is out is always a u64 * maybe just give it that type.

> +} __packed;
> +
> +static u64 prm_cxl_dpa_spa(struct pci_dev *pci_dev, u64 dpa)
> +{
> +	struct prm_cxl_dpa_spa_data data;
> +	u64 spa;
> +	int rc;
> +
> +	data =3D (struct prm_cxl_dpa_spa_data) {
> +		.dpa     =3D dpa,
> +		.devfn   =3D pci_dev->devfn,
> +		.bus     =3D pci_dev->bus->number,
> +		.segment =3D pci_domain_nr(pci_dev->bus),
> +		.out     =3D &spa,
> +	};
> +
> +	rc =3D acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
> +	if (rc) {
> +		pci_dbg(pci_dev, "failed to get SPA for %#llx: %d\n", dpa, rc);
> +		return ULLONG_MAX;
> +	}
> +
> +	pci_dbg(pci_dev, "PRM address translation: DPA -> SPA: %#llx -> %#llx\n=
", dpa, spa);
> +
> +	return spa;
> +}
> +
> +static u64 cxl_prm_to_hpa(struct cxl_decoder *cxld, u64 hpa)
> +{

> +	pci_dev =3D to_pci_dev(cxlmd->dev.parent);


	return prm_cxl_dpa_spa(to_pci_dev(cxlmd->dev.parent), hpa);
seem fine to me and shortens things a little.

> +
> +	return prm_cxl_dpa_spa(pci_dev, hpa);
> +}
> +
> +static void cxl_prm_init(struct cxl_port *port)
> +{
> +	u64 spa;
> +	struct prm_cxl_dpa_spa_data data =3D { .out =3D &spa, };
> +	int rc;
> +
> +	if (!check_prm_address_translation(port))
> +		return;
> +
> +	/* Check kernel (-EOPNOTSUPP) and firmware support (-ENODEV) */
> +	rc =3D acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
> +	if (rc =3D=3D -EOPNOTSUPP || rc =3D=3D -ENODEV)
> +		return;

So other error values are fine?  IF they don't occur no need to be explicit
just check rc < 0 and return.

> +
> +	port->to_hpa =3D cxl_prm_to_hpa;
> +
> +	dev_dbg(port->host_bridge, "PRM address translation enabled for %s.\n",
> +		dev_name(&port->dev));
> +}
> +
> +void cxl_atl_init(struct cxl_port *port)
> +{
> +	cxl_prm_init(port);
Why not just rename cxl_prm_init() to cxl_atl_init() and get rid of this wr=
apper?

> +}


