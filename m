Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DE333985B;
	Mon, 12 Jan 2026 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252274; cv=fail; b=U9jAaGo9J14+gjhihIZf+8R/cbtrW/DEzX8h2s0ZPVkKgfycV9XS5Yf0xMQiQDGMS0toeXV/RyVxsUVwE4AgP1NusSom8kG6Ap0y0ZCopSmfT3+cobCaPlB74Wkw/wqshDxdrBDuWHJdNk2OsU+D9mJhOsLGvyqnQyZSitEoKDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252274; c=relaxed/simple;
	bh=ag7lbwnmcIceBfVexkujT9LxnQ267nayPGdVfykm/3k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=AzVrl+694+dA9a6jRjQOjocH+j2sAZrAydPc26UbY5aKoz1o6KK4nyYT5ia2u0xviSUjL5zHHioGLrzUr1RAHMVlk62i6UNZ5J+K23Qwb9ueqClgFz2qXFkQOI+pOiBk7X5FPSJXuZo2DK9LiHOCTtpm0QfOUfDSgkfk1gx4RKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lLtk0QbI; arc=fail smtp.client-ip=52.101.53.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lLtk0QbI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MztmPkwsRJYBq4NTvYzRXaN+MitSBA7u2qpGtfsTfM1gEZ6gCbaAp2b70c4QR0qqqVzCsyd6UPGLc2xhxBaa4VPRHVhG0D2cEIHeNMR9xd1SxAde2T5c7krU0B1pa76haPxPwWlRCzlaLAvrytZ8FUNSAsgQ93e1dvN0iQDrsyN+68iFu0oJrUI26sNWrACscwnuHutyMfZtfelCx6zm2K7pP7c+enf4jZZ8HtCSgaNcWtxu/Bg+6yiTKxZo3mNYVjxprXFFFB8yzX32Hs7Ftp3tATQaaYvccj+xRAhGffaP/COYyE+1HXvNcpp732ksFbM1nV3MpCtMm2p1lcXw+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkGRcKVhR1BXX9hUk03iabBPHpH8R+Ztj+AM9S/kec8=;
 b=ThC+GqtgTYWwYX1fzv2H84Y5cW1UNBX9unMR9LaWbQpC/EuFa7ClxNQqFzn0ZVoFY0c2Spglfylj3rizftSqSbq+apoUU+un0F2TK0Dpk9A7yRgvKqOMRfu5dAhaV/w3cU8ykZW47vE6HijKOzwc4YIlm7YL9Cfr5kMetVipqZv6UeelrhF9c7ML4MUS9TQ/b2Jg7DUgACvwOkW0cKtoy5tBeBxyWU4u73F23ZyjT+hOmYXsOIu5y8JyqpGCZSnI+Wue95qygUDrp9mQ5jDlG5dNZRMc82Y4qVIyAFk9q/dfkrtC0egHt6kQ/MvAGP3eRcF+Hi56OlWB17SiW6vsYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gourry.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkGRcKVhR1BXX9hUk03iabBPHpH8R+Ztj+AM9S/kec8=;
 b=lLtk0QbIuVU95ikRcGZ91LAMFzDy12ZvYSUuh/RkyU9qslwaYsWrz3qTqA8bHWXevdN0azeMnCUN7sLjlF7s/aKpY0gjQppHnUAFi4T00KIKgX/o3dMfNXT+k+yeLo7NJx63oy3BeeUn5uA24iaADVYRMIlTgzoVIiSOS8EGPcI=
Received: from CYZPR12CA0011.namprd12.prod.outlook.com (2603:10b6:930:8b::12)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 21:11:03 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:8b:cafe::32) by CYZPR12CA0011.outlook.office365.com
 (2603:10b6:930:8b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 21:10:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 21:11:02 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 15:11:00 -0600
Received: from [10.236.181.95] (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 13:11:00 -0800
Message-ID: <d612aaee-6bf4-4a30-aef2-46619cec379c@amd.com>
Date: Mon, 12 Jan 2026 15:11:00 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 5/6] cxl: add CXL_REGION_SYSRAM_DEFAULT_* build options
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-6-gourry@gourry.net>
Content-Language: en-US
In-Reply-To: <20260112163514.2551809-6-gourry@gourry.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f80802-1a98-46af-dfa2-08de521f1742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmttOWtkd1dMODVSTkl2emVvdjkrYUduVTRwWC9MZ0RoSUVNeXB2blRBczlG?=
 =?utf-8?B?OUo5ZTE5QmxGWm85Yk1TbU95NkFBb2tYZytJUnN5Z0NvVlczQ1BZTGIwWUdI?=
 =?utf-8?B?c2FBNEJnWlNoQ0dWUVFEdlpkNHRSVUtFdDNUTGRxcVY0YnU2azdFVlV4Nko1?=
 =?utf-8?B?SlFYbjhKcG1iQnNCcWZqZG1ITkNjelBCdzhCK1FadXlNNTNydS9XLzkzTmpF?=
 =?utf-8?B?cFdVT0MzcmZTc1JsR1hIN01JL25TR3cvemhaUUZ2REQvNHMydGpUZ2ptYW9x?=
 =?utf-8?B?V3FFV0VsZkdIcnhKZDFBbnB3ZFVTL1ZYRzFXWnZFNXlxOTRzYlpRTzd0Y1Vu?=
 =?utf-8?B?MlI0T21HRkJZYUthZG5BUmNGeUkzdlN0Y0pSUzlOdVUrTEpEWEVUcVJVVnhx?=
 =?utf-8?B?elBmSHcvcmpNRTRkUnpnVGwrMitJd1FWN0JPcTJHWDN3Z3BiRE9aU2hYdTNr?=
 =?utf-8?B?bFpvOUt6YWU3VnhVak5KQXZjYlpiMDVBYkZZTGdJd2ZUdk5XaHdhWHFkV1dV?=
 =?utf-8?B?U2ZQVjQvaHpuN1RwUXcyTDJiYmg3Z0w0dWxBR0RPQlNIblFyZXV1TFNqRGM1?=
 =?utf-8?B?ZE9CVVNHbUV0VGxlTGJxUE55WWRHUjdWOXA5aUVqclBVcWtNc2w4N0xKaS9I?=
 =?utf-8?B?RDR5b0dBYnNxV3VFYVE1WjN3T2loRHpiVWVzaHE1S1k2Ymk2WXU4L2R6OGpM?=
 =?utf-8?B?b3dmK21TSjJ0YnQvVVlESDNqZ2VxS2FkREliczFHRkFwK2FNZzNtblg0OVBC?=
 =?utf-8?B?L2d3SEZxRXZSbE55RDNZa1RObElJY3FFN0gzVWdYNTFWTWVDN204UXM4eVE5?=
 =?utf-8?B?UzduWUpaeWtIU0FFY2l3c3VZdzRqZXZoYjlrWS90UHNXYzk4OGRwdTRML1hu?=
 =?utf-8?B?RE5OMFhCb1VIL1piS2FrY0xHMXM2OVhlelZZSlJoQlBiNDZrT0xLTTU2Wncv?=
 =?utf-8?B?ckc1VVgyVUNrL3RZVDhDTkE1cFhRZUdHQlhPVktab1dMWXEyOU1LRkJ4c2w4?=
 =?utf-8?B?WXd4U2htVytMeEhhN0lXdHFjQ0EvZEIySFlqajFZYVpHQlVsZzlBQng5VTNq?=
 =?utf-8?B?eFZIRGdZaTVRZzE1NW1xZS91UElaRExUK01rZS93cWppVVI5bnhTa3VmUHZr?=
 =?utf-8?B?YklWOHFCYXRqOEQvV3lMMFRuczVsRFdPYTJrZzh0NC9SQmdsU2hackthOFFy?=
 =?utf-8?B?V24wWFpOekFZeS9oRWhKUy9ZMnN5aERsbjBDYmt5RnIwU1BTMmZ2SmNPOUFl?=
 =?utf-8?B?R3NubHVuYkpIcTZlREVZOU1KMHBBU2ZhVHRTcXYwaW1FNzZsOUpRcXZyUWRs?=
 =?utf-8?B?aGFONHhWVjZNdUVvS29paGdTUjB5Uis3djNLamRNR2daMWlXR3BFVURPc3k4?=
 =?utf-8?B?eXlBcmxPN3lYVjJoQlp6aDdKS2d6ZDQvcHB6eVJERlJyRTByNURJS1BQL24v?=
 =?utf-8?B?Z01RTnAycWRpSEFvVENndUZrSE1VUTJ6anBuSTdDTThPRnJBSktwM3B3RkZD?=
 =?utf-8?B?UXVhREo1MkI0S3lEbXpNdFl2dmRsWkdzRzB2SFUyK2xJdVBvOHQwODUva2ZF?=
 =?utf-8?B?aGp6SXRTTHc2cFRxUGl4NHQ0NXdyTWxUMjRzRzVHQURLNWhsY3JZUy8yQ2ll?=
 =?utf-8?B?d0RqMEpjWE54OGw5OXlyV2dOLzJrdFBZWWZ3VHdVRFQ0OGM0STZQcjJXWTk1?=
 =?utf-8?B?RUFDUXRBcXBZVTU4WDRzR0RNTTNhQTJOU2h0VjQ0NjMrVnQwYWNiaVJyWitu?=
 =?utf-8?B?NlEzazRNL2ZCRXlwMVpDa0d5M25VTEZISnJBeTUzNWcvZWlmTDJVZU50aXZx?=
 =?utf-8?B?ZzVnVkZxY1B5OFlMdEFDNnhHMHNpUk5ldS9lQ0kwdnc3dGdiaXlrK3JjSUFj?=
 =?utf-8?B?b1Fpd0dBTTRMdldMT0MzV1RiTEZqK1lqdlhhYTlyVHU5bDFqeENaS1B5a0No?=
 =?utf-8?B?dG15RVdic0ZvL01UdW5LREtVUzhQMy93L1RSa2tWTHNFUjdhUUZhN29WcXhM?=
 =?utf-8?B?MTFybXFTVXZhLzZWV0M3dUpGaEM1bkR1NnlrUWJqK3dsMWFxVDhjQWREaTZM?=
 =?utf-8?B?S0dRMjNvdk9Ca29EOHNvU1ZOMVFQK3RSaGdTT1l5QnJtUWZDK3VwQlBpZ1Z5?=
 =?utf-8?Q?MOEg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 21:11:02.0022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f80802-1a98-46af-dfa2-08de521f1742
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336

On 1/12/2026 10:35 AM, Gregory Price wrote:
> DEFAULT_OFFLINE: Blocks will be offline after being created.
> DEFAULT_ONLINE:  Blocks will be onlined in ZONE_MOVABLE
> DEFAULT_ONLINE_NORMAL: Blocks will be onliend in ZONE_NORMAL.
> 
> This prevents users from having to use the MHP auto-online build config,
> which may cause misbehaviors with other devices hotplugging memory.

Isn't the MHP auto-online build config still used in some flows? A quick note on
when that option will still be used would be nice.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/Kconfig                      | 40 ++++++++++
>  drivers/cxl/core/memctrl/sysram_region.c | 94 ++++++++++++++++++------
>  2 files changed, 110 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 5aed1524f8f1..3e087c9d5ea7 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -243,6 +243,46 @@ config CXL_REGION_CTRL_AUTO_SYSRAM
>  
>  endchoice
>  
> +choice
> +	prompt "CXL SYSRAM Auto Online Mode"
> +	depends on CXL_REGION
> +	default CXL_REGION_SYSRAM_DEFAULT_OFFLINE
> +	help
> +	  Select whether CXL memory hotplugged as System RAM should be
> +	  automatically onlined and in which zone. This applies when the
> +	  region controller is set to SYSRAM (either explicitly or via
> +	  the auto control mode).
> +
> +config CXL_REGION_SYSRAM_DEFAULT_OFFLINE
> +	bool "Offline"
> +	help
> +	  Leave the memory offline after hotplug. The memory must be
> +	  manually onlined via sysfs or other mechanisms before it can
> +	  be used by the system.
> +
> +	  This is the default and most conservative option.
> +
> +config CXL_REGION_SYSRAM_DEFAULT_ONLINE
> +	bool "Online (Movable)"
> +	help
> +	  Automatically online the memory as ZONE_MOVABLE after hotplug.
> +	  ZONE_MOVABLE memory can be used for user pages and is eligible
> +	  for memory hotremove, but cannot be used for kernel allocations.
> +
> +	  Select this for memory that may need to be hotremoved later.
> +
> +config CXL_REGION_SYSRAM_DEFAULT_ONLINE_NORMAL
> +	bool "Online (Normal)"
> +	help
> +	  Automatically online the memory as ZONE_NORMAL after hotplug.
> +	  ZONE_NORMAL memory can be used for all allocations including
> +	  kernel allocations, but may not be hotremovable.
> +
> +	  Select this for maximum memory utilization when hotremove is
> +	  not required.
> +
> +endchoice
> +
>  config CXL_REGION_INVALIDATION_TEST
>  	bool "CXL: Region Cache Management Bypass (TEST)"
>  	depends on CXL_REGION
> diff --git a/drivers/cxl/core/memctrl/sysram_region.c b/drivers/cxl/core/memctrl/sysram_region.c
> index a7570c8a54e1..2e2d9b59a725 100644
> --- a/drivers/cxl/core/memctrl/sysram_region.c
> +++ b/drivers/cxl/core/memctrl/sysram_region.c
> @@ -129,12 +129,69 @@ static int offline_memory_block_cb(struct memory_block *mem, void *arg)
>  	return *rc;
>  }
>  
> +static int cxl_sysram_online_memory(struct range *range, int online_type)
> +{
> +	struct online_memory_cb_arg cb_arg = {
> +		.online_type = online_type,
> +		.rc = 0,
> +	};
> +	int rc;
> +
> +	rc = walk_memory_blocks(range->start, range_len(range),
> +				&cb_arg, online_memory_block_cb);
> +	if (!rc)
> +		rc = cb_arg.rc;
> +
> +	return rc;
> +}
> +
> +static int cxl_sysram_offline_memory(struct range *range)
> +{
> +	int offline_rc = 0;
> +	int rc;
> +
> +	rc = walk_memory_blocks(range->start, range_len(range),
> +				&offline_rc, offline_memory_block_cb);
> +	if (!rc)
> +		rc = offline_rc;
> +
> +	return rc;
> +}

I think these two helpers can get moved into patch 2/6 when the 'store' attribute was defined. I don't
see anything that requires they're in this patch and it would help reduce churn.

> +
> +static int cxl_sysram_auto_online(struct device *dev, struct range *range)
> +{
> +	int online_type;
> +	int rc;
> +
> +	if (IS_ENABLED(CONFIG_CXL_REGION_SYSRAM_DEFAULT_OFFLINE))
> +		return 0;
> +
> +	if (IS_ENABLED(CONFIG_CXL_REGION_SYSRAM_DEFAULT_ONLINE))
> +		online_type = MMOP_ONLINE_MOVABLE;
> +	else if (IS_ENABLED(CONFIG_CXL_REGION_SYSRAM_DEFAULT_ONLINE_NORMAL))
> +		online_type = MMOP_ONLINE_KERNEL;
> +	else
> +		online_type = MMOP_ONLINE_MOVABLE;
> +
> +	rc = lock_device_hotplug_sysfs();
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_sysram_online_memory(range, online_type);
> +
> +	unlock_device_hotplug();
> +
> +	if (rc)
> +		dev_warn(dev, "auto-online failed: %d\n", rc);
> +
> +	return rc;
> +}
> +
>  static ssize_t state_store(struct device *dev,
>  			   struct device_attribute *attr,
>  			   const char *buf, size_t len)
>  {
>  	struct cxl_region *cxlr = to_cxl_region(dev);
> -	struct online_memory_cb_arg cb_arg;
>  	struct range range;
>  	int rc;
>  
> @@ -149,30 +206,14 @@ static ssize_t state_store(struct device *dev,
>  	if (rc)
>  		return rc;
>  
> -	if (sysfs_streq(buf, "online")) {
> -		cb_arg.online_type = MMOP_ONLINE_MOVABLE;
> -		cb_arg.rc = 0;
> -		rc = walk_memory_blocks(range.start, range_len(&range),
> -					&cb_arg, online_memory_block_cb);
> -		if (!rc)
> -			rc = cb_arg.rc;
> -	} else if (sysfs_streq(buf, "online_normal")) {
> -		cb_arg.online_type = MMOP_ONLINE;
> -		cb_arg.rc = 0;
> -		rc = walk_memory_blocks(range.start, range_len(&range),
> -					&cb_arg, online_memory_block_cb);
> -		if (!rc)
> -			rc = cb_arg.rc;
> -	} else if (sysfs_streq(buf, "offline")) {
> -		int offline_rc = 0;
> -
> -		rc = walk_memory_blocks(range.start, range_len(&range),
> -					&offline_rc, offline_memory_block_cb);
> -		if (!rc)
> -			rc = offline_rc;
> -	} else {
> +	if (sysfs_streq(buf, "online"))
> +		rc = cxl_sysram_online_memory(&range, MMOP_ONLINE_MOVABLE);
> +	else if (sysfs_streq(buf, "online_normal"))
> +		rc = cxl_sysram_online_memory(&range, MMOP_ONLINE);
> +	else if (sysfs_streq(buf, "offline"))
> +		rc = cxl_sysram_offline_memory(&range);
> +	else
>  		rc = -EINVAL;
> -	}
>  
>  	unlock_device_hotplug();
>  
> @@ -332,6 +373,10 @@ int devm_cxl_add_sysram_region(struct cxl_region *cxlr)
>  	dev_dbg(dev, "%s: added %llu bytes as System RAM\n", dev_name(dev),
>  		(unsigned long long)total_len);
>  
> +	rc = cxl_sysram_auto_online(dev, &range);
> +	if (rc)
> +		goto err_auto_online;
> +
>  	dev_set_drvdata(dev, data);
>  	rc = devm_device_add_group(dev, &cxl_sysram_region_group);
>  	if (rc)
> @@ -341,6 +386,7 @@ int devm_cxl_add_sysram_region(struct cxl_region *cxlr)
>  
>  err_add_group:
>  	dev_set_drvdata(dev, NULL);
> +err_auto_online:
>  	/* if this fails, memory cannot be removed from the system until reboot */
>  	remove_memory(range.start, range_len(&range));
>  err_add_memory:

