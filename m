Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013026.outbound.protection.outlook.com [40.107.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A1A3321BD
	for <linux-cxl@vger.kernel.org>; Thu, 21 May 2026 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373982; cv=fail; b=Ku4yXiNkjQcQGLdD0KMN/mnwGz3nQhs5haqPc6r407SfvXAbdQWs7Mmwg5sg98FTJ3YBv2UjMjJVQ9JXIexUGVvr3awULtnjgFUiNW8plWJkHsX+c+jit9Hy1QuOqxnPV7TirpKzEMl3oarT2jz2stpio9HYwfr6OGbQ/Ecefhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373982; c=relaxed/simple;
	bh=jXO2dHJhCR/pn5TMZgX00Sgoc5RALXJTmP8HWm87Ebg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LKqMwyxOO+XlYFqe4vKB2w/OtHz+7aPanazUjHtE4r0oKHi3eBiWsuYeTrqhHId7Q84XFV7NKyb2w1v4ZJ7o4Xv9mo8hVN1+hC2J3n8XoLc0plEmsyjLvcy7XJLxgLjxcuJDQwXhyLgEaq75zEbWobMmxO8HBVBXPFHJRF27uUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1cf2B71m; arc=fail smtp.client-ip=40.107.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1cf2B71m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ni16CTs/LlPhy74B8XhusV/ozrsSDLnnkatWfmAkAz5FlbMGgKPxhsVCc7AUqE1viDVhXAul9w76eV8NWY9sPHQzv2DK0ssWeXtQpyWitceSL+WbwOzGAyipoq8Ls1M+iLquyakXTO34Awc5phsNhhnJA8o13/Qz0RVdWJlaIJw/DJIRmYbICJD02dmTxOuphpcWRl6ZCd5gQ5/6lnpdp8OXZZawANlaCaaLq9vz+iDlklJwT58w1xhVmCOr8uc52WVH7riR6JlycWMlFqGXSNsAjrEYCh9CmNF7uX5SCMzg0a/wuz4EA6CSuZiDlZBvuXs7aUGl+GhASv567JZA7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUO92vq7stNpXp1miC2LLkaO6ecXx9a3MMqGFcOymc0=;
 b=BtPb1Fqef+Sya6bSzUB9ExykniLo8+VawVKEXeHqFvpdFMcJKw60n6xWFZhNzH8Uiu6muRsgQU7LxcV13si2Syuq+AjXeV7ESlIyiYqtFYdldWomuTmNplk04EBrswnCGQn41SB5gAFYaVzEb9VnSXTh/XeTV1xf8UBLzR9r3FnwxM5kuwK/CTKyiQN1KtuGUrOS8UgnVu9ptFz3PRr5nWmytzts2iUGnzaTKSDD1rX9YNAAmGO2JKzr89wd1Sy8Q4oQvNQw3JYXJUPJe2AIBpH+b8fmoKMrZ+jo9XkvXXyGvshrt3IGl1Kue/4MQuOiLYPUH3F5Ei61YMeB2i+RfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUO92vq7stNpXp1miC2LLkaO6ecXx9a3MMqGFcOymc0=;
 b=1cf2B71mWl7fsUt0vJ09ETN1l49pv1Z6aWDuAARDgUcy6RavWM0gXPowUkjGMmDOJGAE8cOtn2k00vwuBqD3rffYNH6fziwCj8xinkyumM4YIMl+crubPz6UgmLoR+ckl1cLFjesx6Bq0o2vf95nleKY+ydosVTd+TWfgC4GLrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA4PR12MB9809.namprd12.prod.outlook.com (2603:10b6:208:54f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 14:32:58 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.21.0025.023; Thu, 21 May 2026
 14:32:58 +0000
Message-ID: <cfc5360e-4148-4550-b885-a501ad9e9747@amd.com>
Date: Thu, 21 May 2026 15:32:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] cxl/region: Block region delete during region
 creation
Content-Language: en-US
To: Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Cc: dave.jiang@intel.com, alejandro.lucero-palau@amd.com, jic23@kernel.org
References: <20260519210158.1499795-1-djbw@kernel.org>
 <20260519210158.1499795-2-djbw@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260519210158.1499795-2-djbw@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0182.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:376::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA4PR12MB9809:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d937a86-56c3-470c-8f30-08deb745da2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|4143699003|18002099003|56012099003|11063799006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	dRwLoz4SPF9oCUG/3UYulpTzYfXDCtnpTnim0KjBB/Uc7Xbn+NzdAD3AHHEPEiQEYONZqkr4uCIhPsP+uGr/FtIfMtcpBlmYwJfvvI7IxWYN/FgkqRDMwGkqL+Vqq9MYPhZqFlgyA/dKgXbIuXwtbevtryYrUhT2DTBTwxJy7ZS3T7ueRUNPLlq69Gr1CtB8fLeysSYTrA0eHEnxrXAmdY4clj2/YT6/Z6NGoSgKJhu9pP92mfuOA7s9pFxUUOrKnJ62bOSSlc3YzrYcfJBBz2B6kt353OIy/TUvUkwXz+CQAbwTz5xVdvyw1xyj0DqUUYuPl2ZeG42h6HGorKbPBESK423ArqmvVqbEFHZThdLyPzqN0vqABifCIFNjOoW5TgnxagHWJ2Ym4Lh+xxUs9pNNpFkbdzD+R5cbeND2grYji4vraS1z1siB8bT4CDKOKZbmwMWu05itE4glkh96I0vF8ZhQ0kbfXUlWuD0BM5O0lb5n74om5A8vwf8K9pFkZLfbMGiqJbiPhKD+Ids3DbMWx9pQ3b01YeD8cADO/Gg1TbiBwl39zNCe81y1gZ2CmZicljMsTr1JX7mw3fMqtrXVEQGumtz/mMZtBbt8hATyLBY4GutOH3FS4INSvrlQCjaR049vmyLfKESLpMJ7EVZyAV7L29Paqt8Hs1v5CFihabGPrk8L2UIN0LTqCOLc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4143699003)(18002099003)(56012099003)(11063799006)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0x0S3l4WW85YStQTjFyTEQ1ZDY2ak1LOWtXZ2JHUXpvdWM1U0NHdng1N1dY?=
 =?utf-8?B?dWZNZG4zMTRTU3dDQlF0SlFnbXptVnVVUHBxL2JEWmlZYnROVUQwSVVmTlQ5?=
 =?utf-8?B?aW1VU0tweEI1aE9vNWp6dXlkMDBFWjhNZytLS3Y3cTVZcnBHd1lJd3NERkRp?=
 =?utf-8?B?MXNBTmN2Yk11d2dpQWxIQjRMSHNSVlhtaWZxWjdSWjBxYXFXUWtJbUt2QlB5?=
 =?utf-8?B?eUFmZE9PazNadFRBNzc1SWE2dEJqNzA4Ymh2UE9ZdlpycEZWRllUSFF6WkJ5?=
 =?utf-8?B?a0h6Q1Fid0Zpak1zS2pSM0F5YTdRT3k1Ymx4ZUVuSk0rRWZCYjRWRlg4Tys2?=
 =?utf-8?B?b1NzVjduM0d5N1BWTUNXb0JhRHEzK3R1UkRZamlMdWNiVEdYdC83SG82N3Ns?=
 =?utf-8?B?N2RHQ2hoV001TE9Qdi9vUEwyRWw2SHROa0FlTzc3b1U1SVdUQld5SVNycWVK?=
 =?utf-8?B?dXhnTlU4bGNNRkdScXJRNGpiSWxVTUcrVEx5QjhrV1hLQnJzK2swcGlaRmlL?=
 =?utf-8?B?cG4rbUp0dWszRkk4WHUyNlJPOXY4cGllV1ZHanJiNlBvN21aY0JhWjJjRk8v?=
 =?utf-8?B?STdXV1RZUjc1ZndxWlBNaWxNSW5lQUU2NmcwdzdEZEhhZXJFRVFCMmJLYkFC?=
 =?utf-8?B?ejVvcGxDdWlHa0RsczRhL1RpYjlDcGlhZExLNWhnRGtPYVQrN1drdlRhelB2?=
 =?utf-8?B?MnVVMDJRc3MwbnFvRXZzMHZBTUl4eGZYUUtJZE43S2lud2xRbG5tMU5GRDJX?=
 =?utf-8?B?RkVmNzN6ekFRb2FvYnBHdldSc1VjWFZxQUd4ZUluNGJCNWpLeTNORzRneFdk?=
 =?utf-8?B?bUxFME5sZHYvS2wyVUMzaWhUQzV0UHFpNEs0M24raWdaVE5rL0U2Y1FYK0dM?=
 =?utf-8?B?VE5jMmR0U3JLSCtnZlNqQWRKY3ZpZ24xUHMyRzRYbW0xbjVMZ2EyWFZKUEZ3?=
 =?utf-8?B?aWgrNmlLWEFTSE9BRFVZZU1KVW9MNitzWWx6N2JSV1ZuV2FuMWV2bzUrbnB4?=
 =?utf-8?B?OHBRUDBVQXRoSHRZQVF5V0V4VEhLNm9INTJUZlRrbTFvVzJROUxTZ3RNTEhk?=
 =?utf-8?B?SW55MC9WMTJWREVHdDVQdytEa1NydGVTV3N1dTNwZ1FYRGZ1THpvVm1Xaith?=
 =?utf-8?B?WW5ybjVORFpsZEN3QTFxV1JkaVQ4T2JFZm9VNzB6MHZvcWM4VkRLUW1SZDU1?=
 =?utf-8?B?VjdncjBoVFNUek5OcnNvVFJVWWRYa0lPZyttdnhTbDJQR1JuSWxSVmFoY0Ni?=
 =?utf-8?B?ZTZHRzhhWWNZKzZoc1NXYnVPZmZNYlJaWm0wdjFIMUp4TzVxZnlXM0dDcnBT?=
 =?utf-8?B?ZWRDdE5uaFIzVG1tcUNqdm5aYjhURDJGbGNWeExtT25kYWREbFVlZGNJVmQx?=
 =?utf-8?B?ZWsvV3pGYTRwZlNwbDY5Q2xwRnNRSmIycFE2T1lkeU90QVdNNDBjVWZOWG5C?=
 =?utf-8?B?dUUxL3VpMEZ5b3lpU3AxNDdUZEpPYTA5NXdTU1ZzdmNWQXlpN3dQNzJZNVFw?=
 =?utf-8?B?cWNNbmJpdDlPMTZGTDhkYmhjdDk5Nmhrd3ptampBNHNRZ2tVN2lZcXo5MTQ2?=
 =?utf-8?B?MTNWOUdlcExiQ3cvcnhZVkZmcElpc0RPSG54alkrSjAxckxjY3MrTHJzcFFk?=
 =?utf-8?B?Y29wVFZXeFRneGZ0SEZJY0VkcHhIWUlEdHQvNXQ3Sk02VGRydldzb3ZmbVky?=
 =?utf-8?B?MERuNW9vdHlBMCtXU3h6N1F1WW1DczdrRG5HZDdhY2l3ODVHNWtZZWs5Nzh2?=
 =?utf-8?B?QkcwN21lNURvcUI3YWpmYjdId2RoS1J1eEhqSjJNSUtBWWlRS2g4dGxzUjY0?=
 =?utf-8?B?Vm9DUFB3Ymp4WUgxd1JhbHNmNjUrbDZjaHZaL05BLzhRaW42NVJqc0JaRVRP?=
 =?utf-8?B?a3RkdnZGNnVUQTk5akczR2JYNlNwZTNUcHZrZE1YUEtLL1YxU0hvVVY0S2k4?=
 =?utf-8?B?azlZd2t6VFlnK0xqMWpUUWQrSjVGSjczWnN6NEtKTEMwNFluZEFRSFFzMmE4?=
 =?utf-8?B?RW5qWENXYWErVG0wTjQ2SkFzeWFJMTlZalozVC9kK004QWppaldnODZmV3Fr?=
 =?utf-8?B?S0xPd0dNRUI3MlpBMEpSMkU5cFUxTDFKZlVXUXZiYnN5QS9Rek5hQnRhbzdQ?=
 =?utf-8?B?aGM3YzhJMWlhM3JoM3BMQzBnZExiSDEzTmZ5ckpiNVNUUXV4UkZ4RExoNW93?=
 =?utf-8?B?ZWFXMitDaUkveHBnUDdhRjViTnd4RElrMmk3Sjc1SU9qcDZoemdEWitNa2Jl?=
 =?utf-8?B?YW84M1A3bDFrQ0F0U2VoY0s4VEo3Ukh0ajNPYU1USGsvbGIwUTVDZ1hRbHdu?=
 =?utf-8?B?bUc5VTE1d00zaXQ5V2RjT3lnL012cktEU3QraEdiYk05MTdOOEh2UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d937a86-56c3-470c-8f30-08deb745da2b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:32:57.9068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UtXIC0gDtcVHgMZKjynKYqmle9SaY58cza9zuLR0r1AobZorbhParb3LuCu0YPuI0CdrGmHPCpz80Ku1j7boHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9809


On 5/19/26 22:01, Dan Williams wrote:
> Expand the range lock, rename it "regions_lock", to disable region deletion
> in the critical period between construct_region() and attach_target(), as
> well as the period between device_add() and registering the remove actions.
>
> Otherwise, userspace can confuse the kernel. It can violate the assumption
> the region stays registered through the completion of cxl_add_to_region().
> It can violate the assumption that devm_add_action_or_reset() is working
> with a live 'struct cxl_region'.
>
> It is ok for the region to disappear outside of those windows as that
> mirrors device hotplug flows where the proper locks are held.
>
> Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> Signed-off-by: Dan Williams <djbw@kernel.org>


Reviewed-by: Alejandro Lucero <alucerop@amd.com>

Tested-by: ALejandro Lucero <alucerop@amd.com>


> ---
>   drivers/cxl/cxl.h         |  4 ++--
>   drivers/cxl/core/port.c   |  2 +-
>   drivers/cxl/core/region.c | 12 ++++++++++--
>   3 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1297594beaec..3900a0778571 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -359,7 +359,7 @@ struct cxl_rd_ops {
>    * @cache_size: extended linear cache size if exists, otherwise zero.
>    * @region_id: region id for next region provisioning event
>    * @platform_data: platform specific configuration data
> - * @range_lock: sync region autodiscovery by address range
> + * @regions_lock: sync region discovery, construction, and deletion
>    * @qos_class: QoS performance class cookie
>    * @ops: CXL root decoder operations
>    * @cxlsd: base cxl switch decoder
> @@ -369,7 +369,7 @@ struct cxl_root_decoder {
>   	resource_size_t cache_size;
>   	atomic_t region_id;
>   	void *platform_data;
> -	struct mutex range_lock;
> +	struct mutex regions_lock;
>   	int qos_class;
>   	struct cxl_rd_ops ops;
>   	struct cxl_switch_decoder cxlsd;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index c5aacd7054f1..6e7a70d51cfe 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2016,7 +2016,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>   		return ERR_PTR(rc);
>   	}
>   
> -	mutex_init(&cxlrd->range_lock);
> +	mutex_init(&cxlrd->regions_lock);
>   
>   	cxld = &cxlsd->cxld;
>   	cxld->dev.type = &cxl_decoder_root_type;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e8..b5601e89e302 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2779,6 +2779,10 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
>   	if (rc != 1)
>   		return -EINVAL;
>   
> +	ACQUIRE(mutex_intr, regions_lock)(&cxlrd->regions_lock);
> +	if ((rc = ACQUIRE_ERR(mutex_intr, &regions_lock)))
> +		return rc;
> +
>   	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
>   	if (IS_ERR(cxlr))
>   		return PTR_ERR(cxlr);
> @@ -2838,6 +2842,11 @@ static ssize_t delete_region_store(struct device *dev,
>   	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
>   	struct cxl_port *port = to_cxl_port(dev->parent);
>   	struct cxl_region *cxlr;
> +	int rc;
> +
> +	ACQUIRE(mutex_intr, regions_lock)(&cxlrd->regions_lock);
> +	if ((rc = ACQUIRE_ERR(mutex_intr, &regions_lock)))
> +		return rc;
>   
>   	cxlr = cxl_find_region_by_name(cxlrd, buf);
>   	if (IS_ERR(cxlr))
> @@ -3776,12 +3785,11 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>   	 * for the HPA range, one does the construction and the others
>   	 * add to that.
>   	 */
> -	mutex_lock(&cxlrd->range_lock);
> +	guard(mutex)(&cxlrd->regions_lock);
>   	struct cxl_region *cxlr __free(put_cxl_region) =
>   		cxl_find_region_by_range(cxlrd, &ctx.hpa_range);
>   	if (!cxlr)
>   		cxlr = construct_region(cxlrd, &ctx);
> -	mutex_unlock(&cxlrd->range_lock);
>   
>   	rc = PTR_ERR_OR_ZERO(cxlr);
>   	if (rc)
