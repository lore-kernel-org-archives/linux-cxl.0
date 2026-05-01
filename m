Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012001.outbound.protection.outlook.com [40.107.200.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81B92FFF90
	for <linux-cxl@vger.kernel.org>; Fri,  1 May 2026 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777630035; cv=fail; b=RWwAeFz5eNZGLBsb6wJTfDgrexuGt9mlkDDTC0kIiexiLziW7DK3IWGau3fiIu5kGJL9ODgEVvRyGl/+4h8ce09d/86tJxfc4TvRzTArp2XOm6FkTu5FNza3I2thfKXLUYcvTyVdow5NxYuBrv7bgNFhmcdh71MTWeOQZyHd7ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777630035; c=relaxed/simple;
	bh=MByVsImJQReQ354pKj0+zuS6eQ5GIjUOlJ6BztW1uZs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SB4a49sRJzMdpZ2PZgzDhd2H2MwLUeId0T5sHw2tA8cCcgczTe5Fy25Mo3kAwvM1VRLFkCr/2+3n1JzNUw8N91Z97rGyyhJEmI03Yc9bIT0qvrUj1UODxACJGiEtjKyrEm4uItVc1UPA4nYp2j2PeJKWTWvhFClhEMnA3FFeEnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YfcoLeFT; arc=fail smtp.client-ip=40.107.200.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YfcoLeFT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uijkMO6jF9DaCpvWKktJ0t3Pizn+iwb02OCo1+kJFSHpg/WSx94ORaPgHJAKoIuih2y8fce5GQxOzhfn8IJFGGNUnSZO0WawoC8qN+GyrJ4diD83rn4nCsXrQaTs4V4B00q96cGaZYbNUvVuX0vyFAkJlEVrIZX3xg/rIMvVpIjwz+rXt99wPHa949/O+V/hPLhxo4povaDp36M9Xc0tzstkK7TRhvWhKWEukswYoz2g79xuMdJY2u3afsl6WpLo8dVM3zp46mAsILgPi8+tzBJ4XGcSm/qBSiZZ3rmtWAks41ZN6Z8U5I3fempINoLLQtvsWAseLUiFdOHryo7M7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBTeKdv2qsLFBr5KfVyQyY4PiQxYWrQmLREkXYSH320=;
 b=b8m4zCMz5a/E3S+CrIwvQ7Te7reZ7Yzux6LMIpQygPD6IB25xuqUBnb8WTNC+piq+deSnWGXGxEHPMEXNcGHmUCFIVZc+W+272EKDlRKZL9F+7rpwbCgZIRkc6pRa1WfQj+zA+86tvfCh16VcmrAVT5y4B4kLGEnM2ZRYq6ylfumGmnGWjyM8+wHunTf1Ime81Ahkwnecm6wGwbBxZVbOKAklWjQJujCT4yaFj5BSUEPZIoj5Ud4W8GxOz7sGf4a2E9TUVRlg+IW0fTa1oJZPJez/RE5lbBYNfgBJquEHWribQxjWQTv80HsyYWhH7BEV+oSAcxKZAoPvmhkYXC62w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBTeKdv2qsLFBr5KfVyQyY4PiQxYWrQmLREkXYSH320=;
 b=YfcoLeFTVQCh8IShpIteEdZ1gu33VocLBAbY0nXdTExO/Sw3s9m7sTjBGkWR+caiP5NNaNysEXONDzga8Z846pa4Vo4pix3WcskT4RKiya29dJM5y5pHIJDHwFgDwCCEE8VgGDwOQdkxZ25c01P9+xIbdorsedDTbMVUog9zMHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB8079.namprd12.prod.outlook.com (2603:10b6:208:3fb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Fri, 1 May
 2026 10:07:11 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 10:07:10 +0000
Message-ID: <41219a9e-6876-42eb-ac18-3b4b7495e6e4@amd.com>
Date: Fri, 1 May 2026 11:07:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v26 1/8] sfc: add cxl support
Content-Language: en-US
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org, djbw@kernel.org,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
References: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
 <20260423180528.17166-2-alejandro.lucero-palau@amd.com>
 <85abaa2c-7fb2-4963-9909-74ded20c2f0f@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <85abaa2c-7fb2-4963-9909-74ded20c2f0f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P195CA0020.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::25) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 852e62e8-e341-4df1-deef-08dea76968d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	P7+eVhgAeEwo0QeEgv7ApNW5svlBKBOzuun3j5BMH4wqaS8IAw7CdrrTDt7yvhHXb9nszRyio+m45lfjwgs6inmk5yplA63KLTmocMekInGoWa9rkuqpdlgDz2zUX63VCrMYNFgU30/gDN/2PmgM+lyaC1nSnO8wkl7s+aAeim4ek8GtRwwObJ2Bpzb80qmgiYwAOhrctaa4u0Zg6ZPfawjCNsdWH8EzH6ZGpBzZa5VGgUbf4Ws3xcclNT3LGcEnbdXYAPyN4oJPcL8MOgH8M8fJa7TWoRSFt6Ya+UHHGKpybF7Pj9TZ74Bl9BxW5E9Vd64rWHNrZvFPIkzfeYK2UcTdT1yTy1cv8eUBWoS+PG5CTZ9XFeOXy+8V0ss+pkauhK+tWuZcSX++nfK1qH94P0VZlwGSOJW6yI1ztxk6n+l3Yg5/YjViUuaS/AJ41Yef10xezFovh/9NKTPcUyUe2mapz2ZP79R54xRYz+1H3urnSmN+93vRiAbuQBQaDt3iCKaUmpvoGPvhUHl5NF3gQyfGUshKe19HKIQJ79kD4CbG5r9lJOX0NQzCL//0ZokynQz7sX5qvcXPwRZN8AvARHG12ifPzO79qkW//iBU4ENg6M4+P3b09jRMFl4U6eBvyugZIdB9v9Mrvg8zGVjU5pkxoyVhkrfFZkqVLQ98a4NNi4FVv4br+nDvplkhDy70T+0AFu0w1XH55tp4Q7OWWh0qFdZk7slArs7EiH2mKlY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjM4NzFkUGZlQ09MTGw0ZHNFdDVCcUVrMzB3bDN3UkpPbmkrbjliTm8vakU3?=
 =?utf-8?B?d1Iyemc0QVVRU3g1cVRjRFZBNCtkSE5JL04vZ21PL1cvU3dpaWk4S2Y4MGR4?=
 =?utf-8?B?ZW1zSC9JcDFOWWVXUzRMd3RnWmpwVkY3STlaOUdNcS9Fa2Q5WXhUVHlGVmFl?=
 =?utf-8?B?ME1nWS8yK3Btb1pWbzJkZE95dEhJQ3RWdjRQZkJmTDZBK0RiVnpKTFNJcTd6?=
 =?utf-8?B?VlU4ZE1kNlZwWVVtMVZFRWo1VzMySDdIWWdQMDkxUGh5TmR4L2JqNnphOTJR?=
 =?utf-8?B?ZGJWS1V3dHlPbXVQQXV5TkpiNXpPaFQ0cjFFSTBGeHJqZjl3dTR4dFphMmVt?=
 =?utf-8?B?K0l5dHlXR2c2eVlZdmMzRnhQdnpBZ3UrUFo4YjJsV1BvTHlkVjBKbDNoSjNj?=
 =?utf-8?B?UjZZa0I2T2owTWFKeW82N0JxbkRPTzZwU1hSQW9OYWZPUVR6K2tiZ25RSXlU?=
 =?utf-8?B?WmNid1c1ZnRBbFRsZWVHVnE5VlpkWDZPLytVanBFMUxwUlBaSUY0eStwMWkv?=
 =?utf-8?B?Nm5qWVp2dGJQYUJMdFN1RTJUejlPTW5xSHRpaHdkeXlERjNiVndKVkZLZkVx?=
 =?utf-8?B?NUZ2QXlMVW9mSDdWeTRkM2xlWW1YR2NSakV2c3JoTjYveHQ3MHd4UGw5dVlJ?=
 =?utf-8?B?YVFIS2lmcnZEREVaczB4TXJlL1hhYXAxV1ZvNTh1NmhKdkRqbXFBMFFib3Ar?=
 =?utf-8?B?M1ZHWFBkejFiOE9qM3BHOXBPcXcvTVIydEVYRDNiQmhlNVJ1azJhQk5BM3Vt?=
 =?utf-8?B?WE1FeFYwWkJiSXNJRW5McGNYcURCZmVuVmtNTERLaGlmVnhoWXZIUi96VUdn?=
 =?utf-8?B?SmI5a2VXUlExOURjNHpOcS9jUjJJckM3RTdhSDEyZGo0U0l6eDNCRTBTZCtL?=
 =?utf-8?B?N010TjlvWlEwank3MDRTUUdzN1VFamhHQlE0VzM3VkppSDBEL21RWUxsbk5O?=
 =?utf-8?B?UmJaUkJDcDBnZGJZS0wxbmFDU1d3NWp0VmhhL0lXSS8xVE81NnFiaEFmVXU3?=
 =?utf-8?B?RUFZekVESUtackQ1c1VJdXNyeEFpNHFEQkhFakVKTWJWUkI3QWlOUU1QWS9Q?=
 =?utf-8?B?WGFFUW90c2tKbFd0RWxwTlFYNm0xT0VsQzBYck9rOUx3Wlc2cVRlTm9YZDk5?=
 =?utf-8?B?azR4T3pTTHFHK0JMd2l1dDRaS3hYaFp4SVRvR1ZTTGVvNjQzdkpFYXJWaGNG?=
 =?utf-8?B?Ui9wZnpqbjh1RUhqaSs2bERaMkdGQTd4RVA5ZGx6YjBjTlVGVGJobGwrRG10?=
 =?utf-8?B?ZWhQdWJyVVl4S1piZ1NKbytRR2NwK1ppZTJKQmRKWk1EQjZIVnhhQktIZmx4?=
 =?utf-8?B?MWpGSUFnTXVnZGd5MnFGRkZxaEd1TlZhbStoUWhESEJpZ3RFZGxKMnVQUmd1?=
 =?utf-8?B?N2FjL0d5YkEza0twd2dlanY3bjVLQzUxcFZnVHhTR1BJT2FnVGViY3VUTStz?=
 =?utf-8?B?aXh6RUhENFRsb2NRSEJrWTg4Wjk0U2V3WlZDelFDZ1dtUGNickZCNHpLNmJj?=
 =?utf-8?B?b1A4U0d1QllEMkE1T3JubG90allNMWlyZGNGL2h1SCtZY1hQNWl6YTd0VHEr?=
 =?utf-8?B?RHIwK2NTa3BEeTYvMHBBOGhPRE5WMEh6VkZpUWc2YWpJYmFUcmx4ZXdyYjNG?=
 =?utf-8?B?aWJsSHAzU25NQWZ4R08vTGdPYTJnRU5NeDg2bzhUYUJJV1hndHBDbFRoZ3JR?=
 =?utf-8?B?a2FvQXZmMWVHeWJSWGwrUkZoTzdPeUJUSnB5bE43VGlKWUN4dTlneDQ2QVlN?=
 =?utf-8?B?MG9BYnMyc3dDU2JmQ1diU3Z6cTB6Z1FCdXIwb2JYQUVtK21zeXZwby9Ddmhs?=
 =?utf-8?B?aXduSG9vZmF5VE1hVURTZ3hxZGtYNGNDblNBWG0xWjAzVmdiWDVTTSthVkk2?=
 =?utf-8?B?SmZNYitMdkR2QmhnZTFZb2tXYWdINmpjU3NwU2UxUUdLN3lpYkxLdEQ1MzBk?=
 =?utf-8?B?cWxRcnVvcExJcFdqcEFTVE1IVGNaTG1TSkNzSmJiYjYyTzlNUXN1bVE2Ulkz?=
 =?utf-8?B?TDZ3L2hDT2hSU1RzUGhiQlNNQ3IrenJsVXlFOGowTHRxYjNhOFI1a09INy9x?=
 =?utf-8?B?SUxtK3FkSHhGRVlUMlNtNC8vdTFpQUFDaU5NTWxXdXhVcU5KcGlGT3ExQlVF?=
 =?utf-8?B?d3FKQzdDMjNlZ3lRaEtBTXpqU0ZselRkM0dOdWl0ZThML1ZJZzYyY1lhMVZJ?=
 =?utf-8?B?SlkwMWdGMGdpQ2VlM2tOSHo2VVg0Vm5xZlZadWw0d2hreTNTYzRkMC9VYS9w?=
 =?utf-8?B?RVg0Sm5hRkZ1Tnp3NXdtZmExVkRaVXZNM01Cb2tsd3F0SUNJTEpkd2dicXNy?=
 =?utf-8?B?ZDRsdFo0SmNtdVdQK0hjWHVtSjNmWC96OE9kQzJSZ2hVRFpZNmEzQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852e62e8-e341-4df1-deef-08dea76968d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 10:07:10.7096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hf8lzBVgxPKmcYr8rrR50uYKUhDIc4fvUp1vZ/p2ChGzlfoOac+WRzr/VrZbHb1cQZWDhKxO4hWbtIYiplbUzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8079


On 4/29/26 22:14, Cheatham, Benjamin wrote:
> On 4/23/2026 1:05 PM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Add CXL initialization based on new CXL API for accel drivers and make
>> it dependent on kernel CXL configuration.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Code looks good, just some notes on the copyright notices and a tiny nit. With the copyright fixed:
>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>


Thanks.  I'll fix those minor issues.


>
> [snip]
>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> new file mode 100644
>> index 000000000000..b7e8d85a43d3
>> --- /dev/null
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -0,0 +1,52 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/****************************************************************************
>> + *
>> + * Driver for AMD network controllers and boards
>> + * Copyright (C) 2025, Advanced Micro Devices, Inc.
> I'm not a lawyer, but I'm pretty sure the year needs to be 2026 here.
>> + */
>> +
>> +#include <linux/pci.h>
>> +
>> +#include "net_driver.h"
>> +#include "efx_cxl.h"
>> +
>> +#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
>> +
>> +int efx_cxl_init(struct efx_probe_data *probe_data)
>> +{
>> +	struct efx_nic *efx = &probe_data->efx;
>> +	struct pci_dev *pci_dev = efx->pci_dev;
>> +	struct efx_cxl *cxl;
>> +	u16 dvsec;
>> +
>> +	probe_data->cxl_pio_initialised = false;
>> +
>> +	/* Is the device configured with and using CXL? */
>> +	if (!pcie_is_cxl(pci_dev))
>> +		return 0;
>> +
>> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
>> +					  PCI_DVSEC_CXL_DEVICE);
>> +	if (!dvsec) {
>> +		pci_info(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability not found\n");
>> +		return 0;
>> +	}
>> +
>> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
>> +
>> +	/* Create a cxl_dev_state embedded in the cxl struct using cxl core api
>> +	 * specifying no mbox available.
>> +	 */
>> +	cxl = devm_cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYPE_DEVMEM,
>> +					pci_get_dsn(pci_dev), dvsec,
>> +					struct efx_cxl, cxlds, false);
>> +
>> +	if (!cxl)
>> +		return -ENOMEM;
>> +
>> +	probe_data->cxl = cxl;
>> +
>> +	return 0;
>> +}
>> +
>> +MODULE_IMPORT_NS("CXL");
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
>> new file mode 100644
>> index 000000000000..04e46278464d
>> --- /dev/null
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
>> @@ -0,0 +1,29 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/****************************************************************************
>> + * Driver for AMD network controllers and boards
>> + * Copyright (C) 2025, Advanced Micro Devices, Inc.
> Same thing here.
>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published
>> + * by the Free Software Foundation, incorporated herein by reference.
>> + */
>> +
>> +#ifndef EFX_CXL_H
>> +#define EFX_CXL_H
>> +
>> +#ifdef CONFIG_SFC_CXL
>> +
>> +#include <cxl/cxl.h>
>> +
>> +struct efx_probe_data;
>> +
>> +struct efx_cxl {
>> +	struct cxl_dev_state cxlds;
>> +	struct cxl_memdev *cxlmd;
>> +};
>> +
>> +int efx_cxl_init(struct efx_probe_data *probe_data);
>> +#else
>> +static inline int efx_cxl_init(struct efx_probe_data *probe_data) { return 0; }
>> +#endif
>> +#endif
>> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
>> index b98c259f672d..3964b2c56609 100644
>> --- a/drivers/net/ethernet/sfc/net_driver.h
>> +++ b/drivers/net/ethernet/sfc/net_driver.h
>> @@ -1197,14 +1197,24 @@ struct efx_nic {
>>   	atomic_t n_rx_noskb_drops;
>>   };
>>   
>> +#ifdef CONFIG_SFC_CXL
>> +struct efx_cxl;
>> +#endif
>> +
>>   /**
>>    * struct efx_probe_data - State after hardware probe
>>    * @pci_dev: The PCI device
>>    * @efx: Efx NIC details
>> + * @cxl: details of related cxl objects
>> + * @cxl_pio_initialised: cxl initialization outcome.
> Tiny nit: The description of the variable should use the english spelling as well (i.e. initialisation).
>
>>    */
>>   struct efx_probe_data {
>>   	struct pci_dev *pci_dev;
>>   	struct efx_nic efx;
>> +#ifdef CONFIG_SFC_CXL
>> +	struct efx_cxl *cxl;
>> +	bool cxl_pio_initialised;
>> +#endif
>>   };
>>   
>>   static inline struct efx_nic *efx_netdev_priv(struct net_device *dev)
