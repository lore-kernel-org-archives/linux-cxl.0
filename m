Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2168384
	for <linux-cxl@vger.kernel.org>; Fri, 17 May 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956254; cv=none; b=aEARAoVfETezlAO48aaDh4IOj7Z3kUiJUe0aW3yxmHdiCc+go2g6hWVKlOSDVYtKBFbafAx2et016bSjLquLYPmDCv5V+3d/thHi8pGb4g8H4mWZ+UdXk3HIvphvdTAxhNnFMcr4RPtDuOPddv79f7T/H7t81iIDZg7AlcAgU44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956254; c=relaxed/simple;
	bh=QmtLAArR+9c2WbLrwXzaDzjGmXV4b0iLm51ViuR1u60=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlBvPiQuc8ZAlNkuOc6OsxIW4W1fnnoH8Jpc3EkwHcx2Va5+fJPX9WqtK75hplY3GRoOA5nDcTcMXkZuIM8qWvMcCsYZ1VGmcC7v0Z9H9vnIOYYr+z+qmQYvkzs5GElvLFX9i5I3ssE+sqfeFjTRuN93JtVTJmglw86d4drKRSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vgq9p4gv5z6D8XR;
	Fri, 17 May 2024 22:30:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 46C4E140D1A;
	Fri, 17 May 2024 22:30:49 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 17 May
 2024 15:30:48 +0100
Date: Fri, 17 May 2024 15:30:48 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alucerop@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<pieter.jansen-van-vuuren@amd.com>, <richard.hughes@amd.com>,
	<dinan.gunawardena@amd.com>
Subject: Re: [RFC PATCH 02/13] cxl: add type2 device basic support
Message-ID: <20240517153048.0000480f@Huawei.com>
In-Reply-To: <20240516081202.27023-3-alucerop@amd.com>
References: <20240516081202.27023-1-alucerop@amd.com>
	<20240516081202.27023-3-alucerop@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 16 May 2024 09:11:51 +0100
<alucerop@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differientiating Type3, aka memory expanders, from Type2, aka device
> accelerators, with a new function for initializing cxl_dev_state.
> 
> Adding a type2 driver for a CXL emulated device inside CXL kernel
> testing infrastructure as a client for the functionality added.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

If you are going to keep Dan's sign-off it needs to be clear why.
Either put the author to Dan and swap these two, or use a
Co-developed tag.

A few drive my trivial comments.

> diff --git a/tools/testing/cxl/type2/pci_type2.c b/tools/testing/cxl/type2/pci_type2.c
> new file mode 100644
> index 000000000000..863ce7dc28ef
> --- /dev/null
> +++ b/tools/testing/cxl/type2/pci_type2.c
> @@ -0,0 +1,80 @@
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/cxl.h>
> +#include <linux/cxlpci.h>
> +#include <linux/cxlmem.h>
> +
> +struct cxl_dev_state *cxlds;
> +
> +#define CXL_TYPE2_MEM_SIZE   (1024*1024*256)
> +
> +static int type2_pci_probe(struct pci_dev *pci_dev,
> +			   const struct pci_device_id *entry)
> +
> +{
> +	u16 dvsec;
> +
> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
Add a line break somewhere in there as no real reason it needs to be all in eonline.
> +

Trivial: Drop this blank line to keep error check associated with the call.

> +	if (!dvsec) {
> +		pci_info(pci_dev, "No CXL capability (vendor: %x\n", pci_dev->vendor);
> +		return 0;

Returned, so no point in the else.

> +	} else {
> +		pci_info(pci_dev, "CXL CXL_DVSEC_PCIE_DEVICE capability found");
> +	}
> +
> +	cxlds = cxl_accel_state_create(&pci_dev->dev);
> +	if (IS_ERR(cxlds))
> +		return PTR_ERR(cxlds);
> +
> +	pci_info(pci_dev, "Initializing cxlds...");
> +	cxlds->cxl_dvsec = dvsec;
> +	cxlds->serial = pci_dev->dev.id;
> +
> +	/* Should not this be based on DVSEC range size registers */
> +	cxlds->dpa_res = DEFINE_RES_MEM(0, CXL_TYPE2_MEM_SIZE);
> +	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, CXL_TYPE2_MEM_SIZE, "ram");
> +
> +	return 0;
> +}
> +
> +static void type2_pci_remove(struct pci_dev *pci_dev)
> +{
> +
> +}
> +
> +/* PCI device ID table */
> +static const struct pci_device_id type2_pci_table[] = {
> +	{PCI_DEVICE(PCI_VENDOR_ID_AMD, 0xbabe)},
> +	{0}                     /* end of list */
{} is more common.
> +};
> +
> +static struct pci_driver type2_pci_driver = {
> +	.name           = KBUILD_MODNAME,
> +	.id_table       = type2_pci_table,
> +	.probe          = type2_pci_probe,
> +	.remove         = type2_pci_remove,

Add remove only when it does something.

> +};
> +
> +static int __init type2_cxl_init(void)
> +{
> +	int rc;
> +
> +	rc = pci_register_driver(&type2_pci_driver);
> +
> +	return rc;
> +}
> +
> +static void __exit type2_cxl_exit(void)
> +{
> +	pci_unregister_driver(&type2_pci_driver);

Unless you are adding more in here later in the series there is a macro
to cover all this. module_pci_driver()


> +}
> +
> +module_init(type2_cxl_init);
> +module_exit(type2_cxl_exit);
> +
> +MODULE_AUTHOR("Alejadro Lucero <alucerop@amd.com>");
> +MODULE_DESCRIPTION("CXL Type2 device support, driver test");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CXL);
> +MODULE_DEVICE_TABLE(pci, type2_pci_table);

