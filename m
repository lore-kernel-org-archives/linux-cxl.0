Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BF21BB69C;
	Tue,  2 Jul 2024 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719935922; cv=none; b=uDNeF0B0qGX+0INuAxgdaSXBNfTJgki/cVuL8UWHPXUlHxIClq0evWn6aJy/rDTtk1oshcWM+8h6cp9+OiUAqxczYjcYoZVKlKeM0cReY7wR7nnNpaNyj1vQ9/ss39Gl4okKspwvaQKQuY2dwPaBi7j9NhoEi4klEPvzWADNLpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719935922; c=relaxed/simple;
	bh=HGOM6uaJycmbH5iUKR46DNltQSiT7nNQDVmctNm0dbE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWalt1i/o+qjfu1ZL51Z93V+LkA1mUzu79XR064peo7B6wjazxjRODvSmdlbnLHy7jyYc9XZpCTxHNpIJb9wVslp3PxT2mtAAijGsY9+4x+0a16mR3T2O4uoRwYJiK0syCBTttJpVfhvCDCU2o/22IOouLyPAaqPaR0D5A4Ptvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WD6y14lGmz6JB25;
	Tue,  2 Jul 2024 23:58:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B47031400CA;
	Tue,  2 Jul 2024 23:58:37 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 2 Jul
 2024 16:58:37 +0100
Date: Tue, 2 Jul 2024 16:58:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <Terry.Bowman@amd.com>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Yazen.Ghannam@amd.com>,
	<Robert.Richter@amd.com>
Subject: Re: [RFC PATCH 7/9] cxl/pci: Add atomic notifier callback for CXL
 PCIe port AER internal errors
Message-ID: <20240702165836.000045b1@Huawei.com>
In-Reply-To: <6b4b451c-935b-4ce6-ab64-c2e66311099a@amd.com>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
	<20240617200411.1426554-8-terry.bowman@amd.com>
	<20240620140926.000029d2@Huawei.com>
	<6b4b451c-935b-4ce6-ab64-c2e66311099a@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> >> +
> >> +static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev)
> >> +{
> >> +	void __iomem *ras_base =3D NULL; =20
> > Don't initialize and... =20
>=20
> There is possibility the incorrect PCI type is passed and this is intende=
d to
> return NULL for these cases. Should ras_base not be preinitialized in=20
> that for the scenario?

=46rom a code point of view at least, nope - just return NULL directly
give it's an error case.

>=20
> >> +
> >> +	if ((pci_pcie_type(pdev) =3D=3D PCI_EXP_TYPE_ROOT_PORT) ||
> >> +	    (pci_pcie_type(pdev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM)) {
> >> +		struct cxl_dport *dport;
> >> +
> >> +		find_cxl_port(&pdev->dev, &dport);
> >> +		ras_base =3D dport ? dport->regs.ras : NULL; =20
> > 		if (dport)
> > 			return dport->regs.ras; =20
> >> +	} else if (pci_pcie_type(pdev) =3D=3D PCI_EXP_TYPE_UPSTREAM) {
> >> +		struct cxl_port *port =3D pci_to_cxl_uport(pdev);
> >> +
> >> +		ras_base =3D port ? port->regs.ras : NULL; =20
> > 		if (port)
> > 			return port->regs.ras; =20
> >> +	} =20
> > return NULL; =20

This is why you don't need to set ras_base.
If you get here it's always NULL.

> >> +
> >> +	return ras_base;
> >> +}
> >> +
> >> +int port_internal_err_cb(struct notifier_block *unused,
> >> +			 unsigned long event, void *ptr)
> >> +{
> >> +	struct pci_dev *pdev =3D (struct pci_dev *)ptr; =20
> >=20
> > I think you can use this notifier for other types of device in future?
> > If it's going to be global definitely want to check here that we
> > actually have a CXL port of some type.
> >=20
> > It may be that via the various calls any non CXL device
> > will result in a safe error. However that's not obvious, so an
> > upfront check makes sense (or a per device notifier registration!)
> >  =20
>=20
> cxl_pci_port_ras() performs PCIe type check and sets RAS base to NULL if=
=20
