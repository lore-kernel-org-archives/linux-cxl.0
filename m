Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CAE33067C;
	Mon, 12 Jan 2026 21:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252263; cv=fail; b=bCNAHq2ebJTg1wldOUXuHGucm0M30XvaK+79MVBZZCeR0P+aIVv2avS/WEXe0xzgLkLm5umnrpBjbzzxTItk58JYBU5wsD0pLkVToGOGR3y8C6nKBWWs28fmXRATLdZorYBIPNNWHmgtgsAk1vTlksjTgazR7++SgKCCrS1R7cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252263; c=relaxed/simple;
	bh=zJ87+dTkrLLUDLmaPRSvEm0aRONn1eMhFVAf+yNuduw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=hvbrTZsoeeyik6bLzanLhWRrGVxvQF/bsyi7zkBe+KU6lCCPg3zN6D3+lJ1qPVR3/LQepDI3tbtrMojqfFDpg31HMjdHOTEo801DNTh1ZiQiXGUkuT3d8G/2Qz/PtlnDbafKK6QnNOi2xQ3/dvT4ALF71D/hpG4w0stos7iImok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vhD+q3Xr; arc=fail smtp.client-ip=52.101.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vhD+q3Xr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsVfOPBo6zcG6TWzHLIHwEah2AqLhcefu8WFXN6CIiEEZ5hKPpVw5ufJhmazEUK9pzaTuIZRYqw7w4ja+hNdoBratgQB4/UJM0tbzdx+PD6nodLoHfvzVZIpcVGNZWji9fo3ScZKvM6tHwMSRa4QiJgdbF6n8/9k2GV1H0CCFOur0mfsPVXKKdwkg1qZI07P7FXs89WWzktYSGe83EtS9v7NyUWDJpIgTk9RHGdZ4L8NV8cg+TeeWAv2O5jkldmT7NofH8BZcNhXXnLGij1N/H2keA5LHLSRL4+chAycLJXyezOYuUKKpxPvfTQrDVaJUa6r90k1KHc+EBUJZD0oSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Va3pPl5rDp1CyLTBdq+6Lsa7SZU3Ptj992IaIBhAZY=;
 b=tX4oMYtkt0cL7BAUlyWjF2exGyubdt/ubChqZabytVqaMxVnMzcmXJhY/fDqqszC5pvVWT9ObaA8gkeixLDwI1PL4p5GuhNm2WCJOqfgXnni61erpivLv0kntnGomwUfgmWpsSdbWEsXbLB75f095v2W3Qn6Q9au2N1oGQaNQUNylgtWxcp0Vx6DK0/MvUOWvxalIW8py3z8dr6XPTvvfN9+NybMIM4E25+aV2ZR0OFWJL4EKBEDiXQhgIpN79+UeRo9ibaJvo25gl1i6wDqu4FtcllyvkQdJ5YV5xkqQfehuaY/h+CIwWkDA70mdG70s3aigFHUgs3LNEg5TMkDtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gourry.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Va3pPl5rDp1CyLTBdq+6Lsa7SZU3Ptj992IaIBhAZY=;
 b=vhD+q3XrP8/neqUtP+KHL3jiK8RokgVQUOk18gZg4DTvU5J/fjW9BIMU2GxIcn0W6TwPT865gI3/zOoYnLah4gCyULDpf41HqsbKFQDBpPb9VZ5rEJV/cRJTZqS1rw9zllGHPx7FfJKczl29Rlj3V4ADytiG6H1k3yC6nbf80zA=
Received: from PH8PR05CA0006.namprd05.prod.outlook.com (2603:10b6:510:2cc::6)
 by SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 21:10:57 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::2b) by PH8PR05CA0006.outlook.office365.com
 (2603:10b6:510:2cc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Mon,
 12 Jan 2026 21:10:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 21:10:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 15:10:56 -0600
Received: from [10.236.181.95] (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 13:10:56 -0800
Message-ID: <05591180-c299-42e1-b8a0-ddd74c5f2174@amd.com>
Date: Mon, 12 Jan 2026 15:10:55 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 4/6] cxl: add CONFIG_CXL_REGION_CTRL_AUTO_* build config
 options
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-5-gourry@gourry.net>
Content-Language: en-US
In-Reply-To: <20260112163514.2551809-5-gourry@gourry.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|SJ2PR12MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: d07b3c24-7e3e-43a2-9434-08de521f143f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkxRTXp3ajRHYkFmUEE0SllsaUJ6aGl5dXVodzhyVDRpU1c2bFB1aUxIWTlP?=
 =?utf-8?B?SURXdjlFSGRhdXg1OWR1V1RuSyswcHUydkcxZm9xcTE3WHROQW9ZQmtOZTZO?=
 =?utf-8?B?RzA1MTVlSmFEbThQR2NXQVdqV2V5KzF4UVpGKzZyZnNuVnBvcGVvaUZESkUy?=
 =?utf-8?B?djVJREl3c0JnMzRDekJOTWxRMStCK0lVUmxjS3NLcWk2YXV2VEwvQUJNbXVr?=
 =?utf-8?B?dWttTjBTMUpwRjVndXoxWERTUHNnZUxLS3dXS0VEOTZwakpNeW9tSW5KODMz?=
 =?utf-8?B?eE1icCtDLzNQODE4VlZBelltZVYvZllsTzdrQlk5aFg0VGoxQkdXWE5ZbTVE?=
 =?utf-8?B?S2s0OGx5WStVV0ExaGhPRTBFYStkam11cEFybDRCVXRLUnkvZDNHWlZQUEhl?=
 =?utf-8?B?b2c0OEx4QkZXRzR1VXQ4eGRuOW5IU3RIc29YZkk1WEdTNnBvOTkwMHo5YWRa?=
 =?utf-8?B?K2IwYmFrRVNaLzRxeFJnSGNyWm5NR0V5TTZxUjU0bUI3RzYvdklyWDhNd0Nv?=
 =?utf-8?B?WDNtalgwTXh5algvQTJoalpIcG0rUjZBUzdCV0NrQUVkcHQxQkpxdWhEeTVG?=
 =?utf-8?B?c0Fjci9oTDZDbTV2S0lMbU1iL1laYktzR3VoRk9uQmVWV2toN2JwcmE1WUc2?=
 =?utf-8?B?cFF5Sk0vWjI5OGhYWkhTV1FobXcxWDZQYzVhSWQ3Q1NaekZ5c2FEbWYrYWF4?=
 =?utf-8?B?eVVVcTlqQUM5YS8xdHorVHordENpblIrTUlMcDhHNEs2WllIVWJWT3U4UzQ0?=
 =?utf-8?B?dGhRb3h1Y01vUzhKdmN5K084YnowT0hjdm9HaDNiWC82NURVV0lUTTIyeVJw?=
 =?utf-8?B?am9uUzFxQUc1VFpwbDNqdTl3TUNTYlUwdEFFS203dE05L3VQT1ArN0R3Vk1D?=
 =?utf-8?B?QXVEK3dlK2NHR2tQaWV3RGRpSjBRa3lIZzVTbXZyQWpzZzR5NGNMWjVBZ0Vq?=
 =?utf-8?B?VjF5Sk5RY0dwdlB5dW15UVE2Z2V3TGVERWM2aW5LT2llVWxGelVva21OU3BU?=
 =?utf-8?B?ZTNWKzZMWVV4S0lPb08rMng1SnZaSkNkNEpYaVNGUDl2VEpURVE2ZzhXbmVF?=
 =?utf-8?B?Z0kxSUdvT3RnUWJIbzA4dFNzMGlvQWdCWE9xQTVERjM1Szh0VFBrZTNsalZJ?=
 =?utf-8?B?MWtZRklFZzBUR2diN25GUTRQSnhIb2lrTmxGOXRLRFJVMEFzY201eFJTZjlx?=
 =?utf-8?B?cm1FcDFGL2g3VDBCdGZTR09XZ3VRVkYxY2ZHeHBsU2tncXEraFFUS2Y1dlQw?=
 =?utf-8?B?VDdlc1l6Y3krWVhmekxXOXFCUlhtN0hkZ2pxbGZmeGIwaktXcll3eHAxVzY5?=
 =?utf-8?B?N3BtQTRCelN6TW9RRHNoaFJQUUc5ZStVRHJwQzMxOGE5eGtxaE4vU2tGYTUw?=
 =?utf-8?B?MGIyLzNyQmxQbkxyOVo4VDF4S1dZbC9KczBWeHpIZmMyZjd1MzM3ZmtHZC9B?=
 =?utf-8?B?N0tTdlg0eU04ajNoU2FzMm1nSDVOREFjUGlNc2hDNkJMc3dOVkJCZGh3ZHBv?=
 =?utf-8?B?R1RPeCtXcWJ5VjlJcmY3Ym40eDVDUi80dnlhTVAwd3lvQjJObzB4YnRtMEd2?=
 =?utf-8?B?S00wUWVwNGE4L2NtcE5YbndrVko4NW16ZDlCeUdxUXhTWlorV1lkSzFVMW04?=
 =?utf-8?B?Z01VNnlDTkRhcEdXU1U5TDZCcDhQYXdiOHEwb3FEdmNxTWdQVmJGdFpOZ25s?=
 =?utf-8?B?UmFoNUNMNjI3endYV0c3ZEh5dXlWU3VMV1FWN1dkUHZQbXY1eGN5YVZzYkxO?=
 =?utf-8?B?WUh4bVZ4OFo3ODNlVld0UHVualNrL3RuU3QrbnpEcWQ5dUdiekpJNmgvWEk4?=
 =?utf-8?B?d1k2dzY2OWt1dlNaN3hMb0MvT1VkWlZkenNycG1MSEtrRFNPbjRYbmV1WDEr?=
 =?utf-8?B?UVFJUU1DRWNweER0YW5mS2ZtNW1RdW9hMWZoRFh5U0RiY053bkZ5djhtVnhF?=
 =?utf-8?B?ZysycGxoejlPM1VkcElacTduMzNtL2hGNjIwSkQyZ3JNaU9FaWIyMTgxQXA0?=
 =?utf-8?B?RG1YV01McUFXYTJxczJjc25KbjZwb0hvdlovVGI3b0NXK2xDVjROeG9BTlZT?=
 =?utf-8?B?L2Z0Q2ZTMS9xbmx5b2Q2Y0FMcGFEcFFkV1Y0cXp4YW5WSzNFblJCQjFscVVm?=
 =?utf-8?Q?big4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 21:10:56.8780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d07b3c24-7e3e-43a2-9434-08de521f143f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8784

On 1/12/2026 10:35 AM, Gregory Price wrote:
> To give users the option to have the auto-behavior of memory to default
> to SYSRAM, provide a switch.  The default is still recommended to be DAX
> in case of multiple devices being added to the system, but this provides
> simpler systems a path to use the sysram controller for systems already
> configured with auto-regions.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/Kconfig                | 32 ++++++++++++++++++++++++++++++
>  drivers/cxl/core/memctrl/memctrl.c |  2 ++
>  drivers/cxl/cxl.h                  |  2 +-
>  3 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 48b7314afdb8..5aed1524f8f1 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -211,6 +211,38 @@ config CXL_REGION
>  
>  	  If unsure say 'y'
>  
> +choice
> +	prompt "CXL Region Auto Control Mode"
> +	depends on CXL_REGION
> +	default CXL_REGION_CTRL_AUTO_DAX
> +	help
> +	  Select the default controller for CXL regions when ctrl mode is
> +	  set to 'auto'. This determines how CXL memory regions are exposed
> +	  to the system when no explicit control mode is specified.
> +
> +config CXL_REGION_CTRL_AUTO_DAX

This should probably be renamed to CXL_REGION_CTRL_DAX since only DAX is mentioned.

> +	bool "DAX"
> +	help
> +	  When a CXL region's control mode is 'auto', create a DAX region
> +	  controller. This allows fine-grained control over the memory region
> +	  through the DAX subsystem, and the region can later be converted to
> +	  System RAM via daxctl.
> +
> +	  This is the default and recommended option for most use cases.

If you remove the 'auto' mode earlier on, then you can just drop the first sentence here.
I'd also add a note about when a DAX region can be failed to be created (i.e. BIOS already
set up and onlined the memory).

> +
> +config CXL_REGION_CTRL_AUTO_SYSRAM
> +	bool "System RAM"
> +	help
> +	  When a CXL region's control mode is 'auto', hotplug the region
> +	  directly as System RAM. This makes the CXL memory immediately
> +	  available to the kernel's memory allocator without requiring
> +	  additional userspace configuration.
> +
> +	  Select this if you want CXL memory to be automatically available
> +	  as regular system memory.
> +
> +endchoice
> +
>  config CXL_REGION_INVALIDATION_TEST
>  	bool "CXL: Region Cache Management Bypass (TEST)"
>  	depends on CXL_REGION
> diff --git a/drivers/cxl/core/memctrl/memctrl.c b/drivers/cxl/core/memctrl/memctrl.c
> index 1b661465bdeb..cb6c37f4c0ee 100644
> --- a/drivers/cxl/core/memctrl/memctrl.c
> +++ b/drivers/cxl/core/memctrl/memctrl.c
> @@ -31,6 +31,8 @@ int cxl_enable_memctrl(struct cxl_region *cxlr)
>  					p->res->start, p->res->end, cxlr,
>  					is_system_ram) > 0)
>  			return 0;
> +		if (IS_ENABLED(CONFIG_CXL_REGION_CTRL_AUTO_SYSRAM))
> +			return devm_cxl_add_sysram_region(cxlr);
>  		return devm_cxl_add_dax_region(cxlr);
>  	case CXL_MEMCTRL_DAX:
>  		return devm_cxl_add_dax_region(cxlr);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c69d27a2e97d..1dae6fe4f70c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -506,7 +506,7 @@ enum cxl_partition_mode {
>  /*
>   * Memory Controller modes:
>   *   None - No controller selected
> - *   Auto   - either BIOS-configured as SysRAM, or default to DAX
> + *   Auto   - Auto-select based on BIOS, boot, and build configs.
>   *   DAX    - creates a dax_region controller for the cxl_region
>   *   SYSRAM - hotplugs the region directly as System RAM
>   *   PMEM   - persistent memory controller (nvdimm)

