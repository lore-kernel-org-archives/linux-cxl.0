Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E126F40BCDB
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184969; cv=fail; b=NF/Oqk2jQDpoDAFVmqWI2r3ODzQEIyXrBT8vaIMpNeFuCFKh111ui2KcY3wLg6hEoNeMKP+BVC/AjnYrdScvlG2K5V2/K/vkUcJD4NSt+uwCCjzU4nXwAE9LTdhiwc5flsrULr0dqXfW6StgKoPQhHIghUCBUJvvUeGr1meMwRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184969; c=relaxed/simple;
	bh=RiwQn+IIdrY6LR/DdKvfg/f/J6yNMEDK5ZdrPEIo+RY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FqCZuL4L7aCorPCNHpALXVOLq1ADWvV30yRyBnfFtlvHTXSsV4Z+P6dLFmRdOtmmucs1OguckRlOx5hkrUT2qnvbIp057ANBwIsJB+p9tIq84gdLf3qZ8ofN94YtejmJ7VuPTaTP0jcnRo6FCzHF/EHtUUBoUl/KZhn4Zs0rGOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hokQ/bAp; arc=fail smtp.client-ip=40.107.208.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hokQ/bAp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4BHyMJ0sWKzRI43YTxDdh61rXbc4RMi4RZLtdPyK1G5e6+K6WkG6H6dZbM4Yr4ef25kLkGN2vO8fHGnG3oP7YH8E8j6iwx2Vz6ukd9E5amv4EGunAK1B/T9/YOcURKY4rMmO4VXBUOZUedUhTrNpJ/nfiOL7jwd31+372DtJVZU/dTqpvGq9oQ42gY7cRkUHaKC8mS8eYC8Z+2ObX/pc/y3T2yxlKH9QErZyFL6aeVahuIM3gR8iiQf3OFYwG5I9hc13xcemaLxgbwMn1o3FC6LCxJadfchBI5nP1AcF+H3+e0WFLe1W7w7J4LFy66YeIaijyXp6VGudvgBSuTXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hY5XdPcSVqaLrUMtiR7+DdtlpTBwRDVGVhz4ZDnJexY=;
 b=ufxPK6Dn0w/XwLrITGmdun5Oxl1EVZlRxBDdGKTEbTKqnlq/eyfZrBLxPxeo9YTktHWl5pwvvl8y7hxL353FBJ0FIJ2JBbBR0Z9NUIBr42sEF0lfWUBKWJiSK4lxrTz8k7/BgSvyTCeRfF3rdYSciAYXzFZIn8Vds6ljFlttT74X0CK8CCwQpB+9U8nbFrx+E2eHJZo6a9EkkwfQ9cz0QeAaeriaEU3ia89uvu8QURHAoru3SXAJRz/VLEF2sbgn60RmZx0PY8eJ6qBeOGpU6XYGMdLsGYgmlFBy+pP/1Z9ITTcCqHBKanm1P5EtezPaTcCIMq5GEmdnQdnonwtcaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY5XdPcSVqaLrUMtiR7+DdtlpTBwRDVGVhz4ZDnJexY=;
 b=hokQ/bAp8k0+V/wNThY/UgiKQjtNG3JVWIu2RFUr2caecUMZmEM+theH9OlVWzu4lACewwHXyTKDM1qNaGOGVOesn//ZO45J5oz32wiIT6AH88lQEBNTl0cASvg+MDCENX+GclbRkDnRDt/nTRAvTAZMhp0wqvkYfkWYXgFSLMY=
Received: from CH0PR03CA0277.namprd03.prod.outlook.com (2603:10b6:610:e6::12)
 by CYYPR12MB8731.namprd12.prod.outlook.com (2603:10b6:930:ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 17:35:56 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::62) by CH0PR03CA0277.outlook.office365.com
 (2603:10b6:610:e6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.17 via Frontend Transport; Wed,
 23 Sep 2026 17:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 17:35:55 +0000
Received: from [10.236.178.170] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 12:35:53 -0500
Message-ID: <706e59f6-985f-4cf2-a430-94e8a4079867@amd.com>
Date: Wed, 23 Sep 2026 12:35:52 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] Add initial CXL.cache support
To: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>
CC: <linux-iommu@vger.kernel.org>, <terry.bowman@amd.com>,
	<robert.richter@amd.com>
References: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|CYYPR12MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: 157de067-38d0-40bb-6257-08df19991f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|10067099003|56012099006|5023799004|11063799006|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pKcEJK/lqwebyLLW/TPlr7QQF59IbG19Bsz3cyW/lkhl33QAdYq2ScDJ18uLv09DYOHldY3bgcOhGZZufHev3ZOqCyJ/8xlKKidYrXDLQBOUYh9iTyo6CHmNeKggso7kWrOG19vzBv3FxCA5SOvNBCFe+5JJVqXIRLqpsYRJPkWkY4vyYZYdH5dGu0ze/i+B+qydthrxZ4R3orkmebwKaSDA7mxDMzn1m/hbp0424cWUuRWQZFSU9WB2B8812erQ/j9tfAHmOnxzQxbCseMCpebyBagaqLT0ZgeQjA9u3/EUEfXKK+DVEs1vNmsVGfHa80xFOAhhkiPwbUU8xwAFrPDxJEZbRJyG0ANVQ0aavL8L5KZiasNOBbD9WzjCrSBIyufs0ltF9PJmgZAYYRNJDLAmvLsKNsFNwXlWIhcwKlyOdq0U4MlwJvO7T0qnELnsMITW2lEio5PtHGcPOSaLwbSl130bb/P49w4IbsYlAP40VYUGPFusny8wfSJ5vD0Eqd0SoHLOndzZMWJO1CoM1V/OrhXVeqi9xo5AQpDXU+C+pt4zQPMrebN5h9pccBx9o0T2u8CYRVWTwXbkRPTOIM2/5ikvSSJhw7B7sz3v2eRHIQdisZTQENV9UxIA/9kOnBAz0wFjOBeHopl1yzUawbVUU1H13s5YlJqhYMvXOYQ2BFDtoMYFaRGZQP/0KSVcPAU4uR5AYrGI4NQvz7vyGw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(10067099003)(56012099006)(5023799004)(11063799006)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w43Ph7RBcy4nXvZITi5qGTotGEBDrirILbMCaCsFEns1lQcvtE4PF/cTI1VKYIeBQJK67+vXWBAKAdCO2qVNJDq51SJWx5nSbBs9aMXPOAuBXH0ODyv/FkaFO7itWJO6HGbxpfjVx/FLJcD2dZVeMuTiA9FLHAkW4wc4FG5LaGoJBqK1Cp5/1aqbwj3wdkPgy0UDss6XUzwJiLpkVwqddn806uKxfwhvKWqvPB+rm0tsE9fIxMxX3HSCtDiGDGKu8n5m4WlKG7pRdFLts09F1DrMld6OR2T2AeZzosrBgOXp9LjguoDTzv/G71GXAlhEQo9yzp6a5QLHvZ3NvtYtjA7X8tvLSQrvUNuWbiViCOaR2MJ28HIgb+yWpGTCL0vDO6A9puiww8TZNV++agddKeokJnKHmMwwSj5LqVQAohL9SsdmMc621JVMqatOhflz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:35:55.2680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 157de067-38d0-40bb-6257-08df19991f2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8731

This set is RFC, I realized I forgot to mark the cover letter right as I hit send...

Sorry about that!

Thanks,
Ben

On 9/23/2026 12:33 PM, Ben Cheatham wrote:
> This series adds support for CXL.cache devices to the CXL subsystem. The
> set includes the following:
> 	- Updates to the existing CXL infrastructure to enable adding
> 	  CXL.cache devices (struct cxl_cachedev) to the driver
> 	- Support for cache id and snoop filter capabilities
> 	- IOMMU updates to allow CXL.cache ATS requests
> 	- Driver for struct cxl_cachedev devices that calls all of the above
> 
> The vast majority of the support is gated behind CONFIG_CXL_CACHE since
> CXL.cache devices aren't commonplace. This set is untested since I don't
> (currently) have access to a CXL.cache-capable device. Using multiple
> devices requires cache id capabilties, which may not be available
> depending on the platform (for AMD it's Venice or later).
> 
> There is a major missing piece in this set: There's no endpoint driver that
> adds a cxl_cachedev device, so this code is currently unused. I was
> planning on only sending this out once I had a device, but the plans for
> the device I was planning to support fell through and I didn't want to
> just sit on this.
> 
> Another thing that's missing is mapping host memory for CXL.cache use. I
> think the DMA API *should* just work after these changes, but it's not
> tested. I originally had the CXL core driver set up the DMA range for
> the endpoint driver, but it didn't end up making much sense. So, I've
> left the implementation for the (eventual) endpoint driver.
> 
> Thanks,
> Ben
> 
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935 (v7.3-rc1)
> 
> Ben Cheatham (15):
>   cxl/core: Add CXL.cache device struct
>   cxl/cache: Add cxl_cache driver
>   cxl/core: Change cxl_ep_load() to use device pointer parameter
>   cxl/core: Update devm_cxl_enumerate_ports() for cxl_cachedevs
>   cxl/port: Split endpoint port probe on device type
>   cxl/core: Update devm_cxl_add_endpoint() for cxl_cachedevs
>   cxl/cache: Verify port hierarchy has CXL.cache enabled
>   cxl/core, cache: Add Cache ID register probing and init
>   cxl/core: Add Cache ID verification
>   cxl/core: Add Cache ID allocation
>   cxl/core: Add support for HDM-D cache id programming
>   cxl/cache: Add snoop filter creation and set up
>   cxl/cache: Add snoop filter allocation
>   iommu, cxl: Configure IOMMU for CXL.cache
>   cxl/cache: Enable CXL.cache on successful probe
> 
>  drivers/cxl/Kconfig                 |  14 +
>  drivers/cxl/Makefile                |   6 +-
>  drivers/cxl/cache.c                 | 285 ++++++++++
>  drivers/cxl/core/Makefile           |   2 +
>  drivers/cxl/core/cache.c            | 851 ++++++++++++++++++++++++++++
>  drivers/cxl/core/cachedev.c         | 131 +++++
>  drivers/cxl/core/core.h             |   7 +
>  drivers/cxl/core/memdev.c           |   1 +
>  drivers/cxl/core/pci.c              |  78 ++-
>  drivers/cxl/core/port.c             | 149 +++--
>  drivers/cxl/core/region.c           |  24 +-
>  drivers/cxl/core/regs.c             |  30 +
>  drivers/cxl/cxl.h                   |  74 ++-
>  drivers/cxl/cxlcache.h              |  50 ++
>  drivers/cxl/cxlmem.h                |   4 +-
>  drivers/cxl/mem.c                   |   4 +-
>  drivers/cxl/port.c                  |  97 +++-
>  drivers/iommu/amd/amd_iommu_types.h |   4 +
>  drivers/iommu/amd/init.c            |  14 +
>  drivers/iommu/amd/iommu.c           |  56 +-
>  drivers/iommu/iommu.c               |  28 +
>  include/cxl/cxl.h                   |  78 ++-
>  include/linux/iommu.h               |   8 +
>  include/uapi/linux/pci_regs.h       |   8 +
>  24 files changed, 1911 insertions(+), 92 deletions(-)
>  create mode 100644 drivers/cxl/cache.c
>  create mode 100644 drivers/cxl/core/cache.c
>  create mode 100644 drivers/cxl/core/cachedev.c
>  create mode 100644 drivers/cxl/cxlcache.h
> 

