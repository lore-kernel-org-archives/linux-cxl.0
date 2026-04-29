Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E4430B51E
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497293; cv=fail; b=PWcZEfeJa/E6rrodfXKQ3CIJYYYTlseygzghV56aPzIEwLJAeZ6IX/PGGk92IC+EJVxffqPJQu2CTvdxe+KFx4ad+TANt8X6XhByIqRhbwRWJW6jgnAvn4deToR7H+QvmxISbrp/kxMvm2QEiG57dPuPn5sDX9CdCXTP0q29HGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497293; c=relaxed/simple;
	bh=D8ZBsLTx8h4J94IQqd6VhCjSZne5BO1tRh1hRslwqXg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=NTHTAhmHZqge4oT2ACb2ZEdI46HKVt6RrOoaGXHvGq+VAEZzSNyXkWexa8YN+7hK0cpgKlVrF2e9c1KgkYmefsRtxm3tEn622tJWn7Fjgmi9RhOq9nCfog8kobCHHtURp7SkVsG2xEb5cQ/X7tCKtMt2nt2VV/hp8+I+Q4lDrf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yRvvLkGt; arc=fail smtp.client-ip=40.93.194.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yRvvLkGt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXIFfTrjGBc1i++dvg9neqQnQgIbuNWPtTJ+tO+2SxKqqLB4HT8pYc8Mc93QqaGgf83I6T8vb8yLxSMwfZwCjJxYfR4ytWS0gZwbjeT0tQGz/sIidpehFfXNLezTOsh0Y59Wb1UxGWn+bTOPxp0TZb4gvsBQu9zPB++fQQv5Yi78LZpseFAoGDS905Ciff3+nmn6DfbMvSH6Jams3I5us/z0haqFunAaXQzLGyyawBAA6e6a+F1/BB0Xn1tZTkQvzJA3I++RmEmvBS1GFauHmNfhF2QsXrygfRyWmC8a7jdxMAt09wj4PuHGM9+1clem7cv3pzxnrsOgM1+yoEq+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTl1Wof2mrPIMuad6sQovqi1mr+mllvEjXJ7nsVjnpA=;
 b=fO2y9jt/xOZ+/83af6nfFwqPRRRWr9IJ519YVK+Bw30RZX/bIjeATnwTVF0FbeM1deTPV6RJG2XWBmAyifbPH7p7HXDN1KXahLVOUrAI1110fuDTjXxkHdTQFnZiTE/ObP6E33HOhh+zkol6eM6w+QJTr+o2x9P4p3Quip02KUN76qAwNXfOB9s8W0D18knLqw13gG0dupta1TfSFgX3zRhgKOuhrx/fVfU3aMKrCjhb7s5aNUeHqE4y8+WA2W+tVcOIPst5mh3Il9/IpEcy0kOSMaFCpyBGrC8Q7t6jlLYwuTdPyBgEsYopU3lMIJFqMd5//j7Hs7LTyWLnJnrR3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTl1Wof2mrPIMuad6sQovqi1mr+mllvEjXJ7nsVjnpA=;
 b=yRvvLkGtEVis4tc8DXUnfKyw3cEMBjLqrybcnnA37Vo+n29dtTZhYs+3VMDiCdny1TkscTgJmkJlxXmCBUsLmvovCeuSoQ8F+0LaFvNRUum7nVFSFTFeatMtuHQLkguGwhOEv0rc58sxUudj8FJrUPs2vW5720noxKPY7RW92Dg=
Received: from DSSP220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3d3::14) by
 SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 21:14:45 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:8:3d3:cafe::85) by DSSP220CA0002.outlook.office365.com
 (2603:10b6:8:3d3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Wed,
 29 Apr 2026 21:14:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 21:14:45 +0000
Received: from [10.236.188.223] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 16:14:44 -0500
Message-ID: <85abaa2c-7fb2-4963-9909-74ded20c2f0f@amd.com>
Date: Wed, 29 Apr 2026 16:14:43 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v26 1/8] sfc: add cxl support
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<djbw@kernel.org>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Edward Cree <ecree.xilinx@gmail.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
References: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
 <20260423180528.17166-2-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20260423180528.17166-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|SA3PR12MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d743659-69e5-425e-a77c-08dea634566b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	chwWViDujCiF9IQotDBFQZCrvHh4mVXFWQwmmf8sY4qiKDOPTP5nr6MdIdbaf9TSbIfgfG6Byo+VhCq6LFtXY7Y4Jxq2Xv6Nsh5m/dNBL3Gwj7AvZYY4FdXeAVbF+YciJt4hS+GJ0fA1TXVC2h1qkhIkwunJAENswomyJclXxpZ31+5ugTU89qKXThp8KsEhvu5dud6pb6nMQSKJF80DufyWxMAr3Rl/5bj1ac6IzAn5ImiZRyYrBJA5/r+ah8IytAo2Wzyt16XPQcvvh2FM5zL2wMLnGEeNmHd1bzcgqfB6/krxcvFRhqfq+bwg6ebUkl0SaBWc90vSCZ9xVQn1isa2j0rFtoh9x07RcYHVMxx7T2CVw10arE0tHpw5ULIHG1Yt4y9NBF6+dcFp7mAsS3kHX2tE2pZH91n5CeiLuRmDhOsEmj9gCHY8bllVUMjIdQJTqD7r9NFp/TdA7SKZyAKAvBylemCW39F1Xg1tTmqRwIRpBu5ctvkEltV/izuCu/84JWiPysjvtiX6BEAtj9OIbG+mqeYilGjrKDBpgOGyQzysvMlwdwXzjBLsqnE87uQi628ephcLhCXw3sFUzZrWFTxm336SW8kOYyWR6wBDi6dqZdLLGD2XgO61bSKS5rcrI1t6dqylDHeMxEqp8O+CGnKVRSbgtsYHUPoXboXEw5BaxOtDa3w2yR0x5eYulA7c4l61PUNU7ffWuOFtExogTWQbphNob6tp2gnnwiWPDk78dqREGlvTnUOaq1pL4Z0s9dDh7eF2DBimNzh9Mg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qN6d6PTyxAlNOp5YTldhLlQCAVR6yegwCQfr8KK/yW65TnCENJxfTzvLAeJFjjVyIQFb4m29JX1Bon6pW+Bwk2BJUWqrmpDAVfqhG3cXzP6XKGuNRpLNwRZdGQmiqWS9sJNq0hBO94Lm4fFDO+EDpdyQALw5XUs4/aYtNi266guGYSCmBFPIOLFplAFSqf69HX4PPN21889nY1ilwHxycILUSHC12Gjgb7x0zCeQ8dxe6tpVrhTWBSXRNf+JDyW6zTkt60XkmN1AMI9Z7KYDkJYan0/QTBbkt1GIfTFUN3LvwBsio8roBq8E0osVrTf7opfq3p/QI4yDDQj8mbQmqRXQlCsO5PKeEcxR4k74ofYgBkuPnk9/+X3OplbY3m1y6yWqeB2MHxeZMzU0T4IW4oExSaLoGUAjDJuU4uUYqM3XrcX8HEM6cIg7q2aA3S/m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 21:14:45.0955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d743659-69e5-425e-a77c-08dea634566b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998

On 4/23/2026 1:05 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add CXL initialization based on new CXL API for accel drivers and make
> it dependent on kernel CXL configuration.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Code looks good, just some notes on the copyright notices and a tiny nit. With the copyright fixed:

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

[snip]

> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> new file mode 100644
> index 000000000000..b7e8d85a43d3
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/****************************************************************************
> + *
> + * Driver for AMD network controllers and boards
> + * Copyright (C) 2025, Advanced Micro Devices, Inc.

I'm not a lawyer, but I'm pretty sure the year needs to be 2026 here.
> + */
> +
> +#include <linux/pci.h>
> +
> +#include "net_driver.h"
> +#include "efx_cxl.h"
> +
> +#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
> +
> +int efx_cxl_init(struct efx_probe_data *probe_data)
> +{
> +	struct efx_nic *efx = &probe_data->efx;
> +	struct pci_dev *pci_dev = efx->pci_dev;
> +	struct efx_cxl *cxl;
> +	u16 dvsec;
> +
> +	probe_data->cxl_pio_initialised = false;
> +
> +	/* Is the device configured with and using CXL? */
> +	if (!pcie_is_cxl(pci_dev))
> +		return 0;
> +
> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec) {
> +		pci_info(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability not found\n");
> +		return 0;
> +	}
> +
> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
> +
> +	/* Create a cxl_dev_state embedded in the cxl struct using cxl core api
> +	 * specifying no mbox available.
> +	 */
> +	cxl = devm_cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYPE_DEVMEM,
> +					pci_get_dsn(pci_dev), dvsec,
> +					struct efx_cxl, cxlds, false);
> +
> +	if (!cxl)
> +		return -ENOMEM;
> +
> +	probe_data->cxl = cxl;
> +
> +	return 0;
> +}
> +
> +MODULE_IMPORT_NS("CXL");
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
> new file mode 100644
> index 000000000000..04e46278464d
> --- /dev/null
> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/****************************************************************************
> + * Driver for AMD network controllers and boards
> + * Copyright (C) 2025, Advanced Micro Devices, Inc.

Same thing here.

> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation, incorporated herein by reference.
> + */
> +
> +#ifndef EFX_CXL_H
> +#define EFX_CXL_H
> +
> +#ifdef CONFIG_SFC_CXL
> +
> +#include <cxl/cxl.h>
> +
> +struct efx_probe_data;
> +
> +struct efx_cxl {
> +	struct cxl_dev_state cxlds;
> +	struct cxl_memdev *cxlmd;
> +};
> +
> +int efx_cxl_init(struct efx_probe_data *probe_data);
> +#else
> +static inline int efx_cxl_init(struct efx_probe_data *probe_data) { return 0; }
> +#endif
> +#endif
> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index b98c259f672d..3964b2c56609 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -1197,14 +1197,24 @@ struct efx_nic {
>  	atomic_t n_rx_noskb_drops;
>  };
>  
> +#ifdef CONFIG_SFC_CXL
> +struct efx_cxl;
> +#endif
> +
>  /**
>   * struct efx_probe_data - State after hardware probe
>   * @pci_dev: The PCI device
>   * @efx: Efx NIC details
> + * @cxl: details of related cxl objects
> + * @cxl_pio_initialised: cxl initialization outcome.

Tiny nit: The description of the variable should use the english spelling as well (i.e. initialisation).

>   */
>  struct efx_probe_data {
>  	struct pci_dev *pci_dev;
>  	struct efx_nic efx;
> +#ifdef CONFIG_SFC_CXL
> +	struct efx_cxl *cxl;
> +	bool cxl_pio_initialised;
> +#endif
>  };
>  
>  static inline struct efx_nic *efx_netdev_priv(struct net_device *dev)

