Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3772FD1B3;
	Fri, 13 Mar 2026 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773404838; cv=none; b=tvQYuebAKkAOEATpnfiIlb3x80/9RV6Vma3/sOSZhmCH+omgeS6yQaqKW7n1tsHPqcaHH4GcLgYtsIWA6bHfSLPa9nv4ArFIdsUFPxo4eiBdHw4xfmCI3CFRQrXN80ewCPoy5tpX+xEYBlRzAexcgeQaOCx7INDWT0lv/vBfWzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773404838; c=relaxed/simple;
	bh=xaZe88XqudNdr3tQ//1u1tKjl7Ij9ntcnr7JkA+bozs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YICymGDu9umZZApg4qWRf73tg45mUvXTMeF+e/XYQJW97vjVpfyge4dcK6KasZv9Mu1iD1Z67G0FyCx71mOpLdJ3ddIG9NYcCQe/NQ7RXKqHcuS8TfjOkH4LjRa+v7EXaZ7QAac2F10xt0Wv4ehDbtVXb3gGfx6UQm/XTIrmuBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fXNy81pWzzJ46vs;
	Fri, 13 Mar 2026 20:26:24 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id B67904056E;
	Fri, 13 Mar 2026 20:27:13 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Mar
 2026 12:27:12 +0000
Date: Fri, 13 Mar 2026 12:27:11 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <mhonap@nvidia.com>
CC: <aniketa@nvidia.com>, <ankita@nvidia.com>, <alwilliamson@nvidia.com>,
	<vsethi@nvidia.com>, <jgg@nvidia.com>, <mochs@nvidia.com>,
	<skolothumtho@nvidia.com>, <alejandro.lucero-palau@amd.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <jgg@ziepe.ca>, <yishaih@nvidia.com>,
	<kevin.tian@intel.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 08/20] vfio/pci: Add vfio-cxl Kconfig and build
 infrastructure
Message-ID: <20260313122711.00007986@huawei.com>
In-Reply-To: <20260311203440.752648-9-mhonap@nvidia.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
	<20260311203440.752648-9-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 12 Mar 2026 02:04:28 +0530
mhonap@nvidia.com wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> Introduce the Kconfig option CONFIG_VFIO_CXL_CORE and the necessary
> build rules to compile CXL Type-2 passthrough support into the
> vfio-pci-core module.  The new option depends on VFIO_PCI_CORE,
> CXL_BUS and CXL_MEM.
> 
> Wire up the detection and cleanup entry-point stubs in
> vfio_pci_core_register_device() and vfio_pci_core_unregister_device()
> so that subsequent patches can fill in the CXL-specific logic without
> touching the vfio-pci-core flow again.
> 
> The vfio_cxl_core.c file added here is an empty skeleton; the actual
> CXL detection and initialisation code is introduced in the following
> patch to keep this build-system patch reviewable on its own.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
Hi Manish,
A few trivial things inline.

> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> new file mode 100644
> index 000000000000..7698d94e16be
> --- /dev/null
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * VFIO CXL Core - Common infrastructure for CXL Type-2 device variant drivers
> + *
> + * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> + *
> + * This module provides common functionality for VFIO variant drivers that
> + * support CXL Type-2 devices (cache-coherent accelerators with attached memory).
As I mentioned for docs, that definition needs some finessing as also 
CXL Type3 devices, though intention is not the ones compliant with the class
code as those can be nicely paravirtualized.

There is a whole class of CXL.mem only devices with various forms of accelerator
that never need CXL.cache and so aren't Type 2.

E.g. Compressed memory type 3 devices are known to be in the wild.

> + */
> +
> +#include <linux/vfio_pci_core.h>
> +#include <linux/pci.h>
> +#include <cxl/cxl.h>
> +#include <cxl/pci.h>
> +
> +#include "../vfio_pci_priv.h"
> +#include "vfio_cxl_priv.h"
> +
> +MODULE_IMPORT_NS("CXL");

Most often I've seen this added at the end of file next other MODULE_X calls.
Whilse we don't have any of those here, still feels like a sensible place to put it.


> +
> +/**
> + * vfio_pci_cxl_detect_and_init - Detect and initialize CXL Type-2 device
> + * @vdev: VFIO PCI device
> + *
> + * Called from vfio_pci_core_register_device(). Detects CXL DVSEC capability
> + * and initializes CXL features. On failure vdev->cxl remains NULL and the
> + * device operates as a standard PCI device.
> + */
> +void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev)
> +{
> +}
> +
> +void vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev)
> +{
> +}

