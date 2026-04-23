Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F933CFF77
	for <linux-cxl@vger.kernel.org>; Thu, 23 Apr 2026 07:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776928235; cv=fail; b=eaWBOBiNvNTLcrnWBEZU2/8NDvYlPnCMO819JFLhZXekeLSQP7dyH+srLh3jfwo7IwkJiMQhRGxrIjeSzI6u2ZAMCHy45ZjGs0krOf7kl0uqt3gftahkS4Rlyi1lkMvJDNh+Ie2E22xol45a4Aq+sl+h3MvbPenqOomTuzhDJs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776928235; c=relaxed/simple;
	bh=rlLF7PhL00Qpn5dxUhX6GFEj8H8DLXDETDNm3nAFyj4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aRaUuu1+PMBhepCaBSaVBwDh8Hitu87hoVt07qj550KS2SDCOVcijDGxj+Ub3jKMoq+87Hboq7ao/TCk6Ml/RGDP3Nvm0vnP5cQCwGfeiqQ63aHS+HiJ3DHfkemmwN2UF9t8KEqntI3VzuG1M/2e1a638xnb4/GcKCbA54z+qSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cIpft6v7; arc=fail smtp.client-ip=52.101.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cIpft6v7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZmZXGcXAIYxKzgm+KwvsSP7JusiNgtrjgceEniyTt/If6aHHC/yIWnzGtIDgGvLZSRi82WdpjRYeEB5dM07YejjcyKX1l8pznhqrbUX8yUgwkSvK2EM1v/+piommSL9JO0KoN2qKUUWKzV7nmlfAb9uCR/6GSPECEXQfvrbAYCMiCsNw2YffK+IKojSOXFfaoy7sTe82cYq2SX54YaMlW9/ONrUI2vAxd/sa2r8QL5JTZHFh6cJ7KxvIIYZts4Yv13UUrKUZ988Gykqhu5RTh2Ug+OzqkV7gjgg+IImQj2cAqGrNllmp5UWwsygCbbWA+KVw0MI6ESCbozLwr8qtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gp1WezBUz3zUROMNW4si8ryb8iDmAWBg6JeAyEi+TaM=;
 b=TSyDqVlrXXCFuWWbPfih2ZISna1WPu7F/JyxqBcMPFeUkGIp/DDV+fKTpwrrHaz8DwkYmqIu1ONE+HBxPPRLcK8s2PchIMGsGUzrn6QH2Vd/e+BmvQsZ7KTtWJzdQzMtlEanfCvQU/hY0B95q/vtQMIRZg8iRRld2fIoN9gJrypUAV5vXJhdr9LocVeGP/owVfnLsU0EZ7mPhKx/Coa3gi8NVoHDyY4GihnUYPJdKkJrgSII53ktVbQLHEqTMM8z8DyPsiAYzz6TBtt51KkK1byUI/VoB/zSDVZlOKp0qcx1pexjoRheh3slNxp+U7GORnus0bBZDY0AXpGFLORTGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gp1WezBUz3zUROMNW4si8ryb8iDmAWBg6JeAyEi+TaM=;
 b=cIpft6v7gz19teMvsxLlqoi2MYWzwMreyo1RUyQf2wRUiQMZv/xzY0KhovfQtskMLTHRNeCI07AxpTKu+O4vBlCtlvDZTI117TieGR2cRKo6RTywNOC+K5tyOzbHZ7oj/IfJwTE77FzWHlaG4t/K3auc2WaHyioZ9N9HxF9POI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA0PPF9A76BB3A6.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bdc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Thu, 23 Apr
 2026 07:10:31 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 07:10:30 +0000
Message-ID: <e0806e00-f727-4399-ab40-f10fbf881662@amd.com>
Date: Thu, 23 Apr 2026 08:10:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] cxl: Fix double unregistration of CXL regions for
 type2 devices
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org
References: <20260422230237.2599333-1-dave.jiang@intel.com>
 <20260422230237.2599333-8-dave.jiang@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260422230237.2599333-8-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0200.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA0PPF9A76BB3A6:EE_
X-MS-Office365-Filtering-Correlation-Id: ab253ac6-8125-45ff-b05f-08dea107675a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	q1lmPTrky7K0mtClOGByQAtFEUGbCYAwNEgQT+SpcHWzevMFUpDleN8JO5tSk19wQWL+UHrmu0n4I2seqsBT7NDl4/r1G+QI62cRgZcvPBCXNWhPumB/YmGIFGSQD1GESz2qYEfiP4DJotUDa+niZOwm5owoiB8hZCrQvWERdkGqoNNrfhyWYvWI/ov1+ZXPLjTkn2ZHpLxbrWN0GkkYj4W11a9RPhUEE3hoyX4txYFlyBieq1pkSShTJVxljTzLPftqVkYm7jjDJL1NnLS/cyABMgKdzk/fRorNZw9pDrL5b4rDWNG4bDwKuyspTB11G/BBSumWkcTCu0InmMKeEa4tOKQW6ESxgZm5fMjIkMw9t7+sHpOlaiO5FIgIl+LAidbCCwcv+/zRUHbnhjP1lq22WLfIaWYxIZr6CM4UKdj0VylcvmduHOjq0YS5e7oRb9OHv/AENBxoDSogUN+cY7AAght1NT4FDGl7q+hflSF5u3n/UCmxinoOyq+L5M5wTo0IwrQrADtJJ0z/TL7WCLF0DW+o4nOiHCBfe0bzgkaBDkgohYsTVElLL+SCoXOcKCAHEhTSr4QXvkP7H4lshsM3fdwbbls3aSA9KzJmfMz1HFDara90yJrYxIMxI2d1ChyQmHoLpNvFReW94Fk9R7SFQ7sh1Brw968ibAmOdaKYo9MnVtriYnsSn4n9ze/f9A7YxTBaSB0flsHrf2UiUFpk5aD/B89ZYkt2Aogvs9M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFJob0hrVERMUjVBTVBpRTF0bjVyR2I3d2RELzhEcVBJbENTRFV1NzFmUFFT?=
 =?utf-8?B?TGlxL3gyUlV5elVKeUwzdnNnc1I1M1RaaGZCc0tjSGRYMmkxUk05R0xUSSth?=
 =?utf-8?B?Q0tZSjh1TXNIWjJmcTRkS0oyZXlZUGZUK2lBcHJvNHZ6dlkxVTJ1WUR1QllG?=
 =?utf-8?B?bjU4UkVxNDJrRjN5L2tGZWQrc0Y3dXY5VmpTWFBESk43SWR2SVlsRTUxRnhj?=
 =?utf-8?B?ay9hZUpXbnZPWU5xZElvaTlzYlBTRDV0cmJ5Z3oxNjhmemFkSU0yOGNRdkQr?=
 =?utf-8?B?WXZZeVZBcWd0NXlYblhpeUV2Ylo1NGxYUEo4ZzYwSnJxMm9ERnNKU25RNWtM?=
 =?utf-8?B?ZTR1YW0xSWV5cnQ0aWtyQlFidkJyNVRPWk9uQ0lLWFZPMmNBTEVHMUpVTnZ5?=
 =?utf-8?B?MUx5WXdEdDFCandvRDBOQ1JVd2NNZ2FGUTZoNjFoM29zai9MUHk1OUcwa0RE?=
 =?utf-8?B?OEZkWkxqRkdQak1GODErYnRDUGt3NzhwUWpGZmtQalU2NGFzRWNpdWtxeXZ6?=
 =?utf-8?B?MUZHMHlKYS9pMHplWUhPeERzRTJIUzVpdnlkMURFaE14VUhaQzJiZU1Bb3lJ?=
 =?utf-8?B?ZlZHTEpMT0ZrMlNNNjNQRXdwSnRHUmVLT0ViNUhCV0dHMkhUd2lXYmFRelRH?=
 =?utf-8?B?SlFrN1JESDB6VjdDcFpsNUc4M3ZuOWt2U0kwKy9Vc2g1cEVFZVlEbzB6RnhU?=
 =?utf-8?B?aDEwdi9PWnZjRlg1VVlneUdOelJNbkdHTXpqdkpydXRONTlDVWVOZ0E1ZTRh?=
 =?utf-8?B?ZVUyTGlsaTliakR0R25nSUF0ZkgwMDdJZFpFM3BPSzVpMmZ6ZkppTklQbmdN?=
 =?utf-8?B?Y3VCZUlzZlB5cEVCQjFGcC9KNVpmcFhwTlRUS2tJSWRoTEhQaWlxYUxjNUtJ?=
 =?utf-8?B?SHpRaThxVU9WRU5jaVptL0hlalpMci9aenplemR2Z0V1TmprbEtVOXRRUDNo?=
 =?utf-8?B?blFpYmNJc0o3Q2wrVm95dWs5UEdFblUzQk9YaHo5WjFtV1krSnBuaE5FQTZU?=
 =?utf-8?B?UmdGRlFuMEZCMjdZUVRPaGdEbit6K2tZOGRxeEZiY2tnTkw1Ums3OWI5OVda?=
 =?utf-8?B?aHJTN2gxaUhCcmFlbEVaY014ekgyWUwrZEN4YkFrTUxCalJINStCN2FyRWth?=
 =?utf-8?B?MjFpbGxQck05bFFZZU1nUmxlbkhIMzBvNWJWKzhuNEVMOURlZzd1L3o4R0FC?=
 =?utf-8?B?SnFtTlRuTlZ6bUZTWExCRWJaOVgxUU5QNkgwMUFWOE5XRHA1bXRYclpKUURX?=
 =?utf-8?B?WEdWdHpXUGRmZDJMUXlMUW5tVEVwYjZaaDNJOTdYbnU5anpyNmoydHJtQzJS?=
 =?utf-8?B?czAwSHZTS0loN2NKSkhMN2tOaG9ub3RETVZlNkNFMk1SaldTYXFwRTc2OHhJ?=
 =?utf-8?B?L3FmVDgzOWJraHllU1NLOVU5WHQ3UTMzcjRuRS9FVzZVSHExdXFXejJOS0wr?=
 =?utf-8?B?c2w2d2crK1V6bjcxeWhPalVhQWxwT3VKTVVUTGJDaG1TWkhPaUNmbUtYVktB?=
 =?utf-8?B?V1pOLzk5VGRpczZtYkFraVMyT2xJeTVqcGxxQW9pbmF3MjhMYXpmQm1TTHF3?=
 =?utf-8?B?T25NRy81TFQzYUMrbEYzS0FHS3NabnBZYVVrSWFWN0R6QTRvQXF2czNpWjhZ?=
 =?utf-8?B?SFR0bEdpTDFxVkljeUQyY3lZa2VSUVZZeE52YU9vL0NBZCthZkZxVk1QdDdz?=
 =?utf-8?B?ZTFZOXBjN1FBcy9pSkJWTkxMVEVoVzNoUmttd1pSbm5NdkJ2NVM3K2x4cldm?=
 =?utf-8?B?ZDN2ZHB4dk9qWjc5eGV5N3BEcElBRmdkM2hmb3VLSjg4dUZKVnk2UjdRby9O?=
 =?utf-8?B?RzBueGJnTkpiVFpNd2pGUUhJY04vSjhiSE8wSHNQejNUZFV0dUowVHovUHF6?=
 =?utf-8?B?NHVsdkk4MDdvODVnaGZMS0s5bmxuUnR2TFZJNUVlU0RsMUIwVHJNcTg5YUpU?=
 =?utf-8?B?RjhpZGsvbnNmUi8wODk2VlovOWZBOWJGV2NHZFk3Y2VyR2pVMFZlb2prNUdW?=
 =?utf-8?B?cEJMUTlNU1VNSEZwYTNQSy9KMUNXd05kVUUrNWFIQnBLaitScHdHMHQza3Qz?=
 =?utf-8?B?dnhuVjM0MTRzNThiaGl6Yzl0bVhhZy9iMjJwUzRPQTRBcUpvTVBmeWluMG9X?=
 =?utf-8?B?amUzaGF5blhobTVsdDZOVjBJM3hhdFBseFJWaGI3d241bDIraDFGcW1lSndJ?=
 =?utf-8?B?VitBN3BPaC9ZWVVVOTcwSXpyUERacTRzMW9PS0RpdUR2TWNYZmFqNVNla1ZR?=
 =?utf-8?B?aUdSRnc0MjRwWkRqVDVuNlhDNU9DTmhobEpKS2lPdEpKdHNjMGFWaEZ4eU1x?=
 =?utf-8?B?bEYwbGEveXpBVEp4bzRHU1E0NzdNU0VpcE5ValRKaHYzYUFqeXJ5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab253ac6-8125-45ff-b05f-08dea107675a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 07:10:30.6499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uOPlw0vAtOYDPefF34bssRUKVI1HYFnbbPLOLD+Z3na6n4gplZ77WU8DQoLYZAxArTND6YNn0WWLQ3fKBVUqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF9A76BB3A6


On 4/23/26 00:02, Dave Jiang wrote:
> For a type2 device cxl_memdev_attach_region() is provided as the callback
> to devm_cxl_add_memdev() call. In cxl_memdev_attach_region() a devm
> action cxl_endpoint_region_autoremove() is registered to remove the
> region when the device is removed. And this action calls
> unregister_region() on trigger.
>
> When the endpoint port driver is probed, discover_region() is called
> to register a region. The call tree becomes discover_region() ->
> cxl_add_to_region() -> construct_region() -> __create_region() ->
> devm_cxl_add_region(). In devm_cxl_add_region(), unregister_region()
> is also added as a devm action.
>
> When removing the cxl_test module, the platform devices are removed
> and that triggers the endpoint driver removal and calling of
> unregister_region(). And then when the mock type2 device driver is being
> removed, the devm action of unregister_region() is called again, which
> causes a kernel warning about double unregistration of the same region.
> Add a check to see if the devm action is already removed before calling
> unregister_region() for cxl_endpoint_region_autoremove().
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>
> ---
> - Need to add a fixes tag when the patch commit that introduces
>    cxl_endpoint_region_autoremove() is stable.
> ---
>   drivers/cxl/core/region.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 61a3efdbf3c9..1a7c0895bb88 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -4296,7 +4296,8 @@ static void cxl_endpoint_region_autoremove(void *_cxlr)
>   	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>   	struct cxl_port *port = cxlrd_to_port(cxlrd);
>   
> -	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +	if (!devm_remove_action_nowarn(port->uport_dev, unregister_region, cxlr))
> +		unregister_region(cxlr);
>   }
>   
>   /*


Hi Dave,


Yes, I saw that problem and reported to Dan:


https://lore.kernel.org/linux-cxl/20260403210050.1058650-1-dan.j.williams@intel.com/T/#m467dc88199645865a05b5fef858a67f3a608895b


I thought about adding similar check in my impending v26 but I ended up 
changing the linking of the created region from the root port to the 
endpoint device only. This avoids the problem you report for the cases 
of removing cxl_acpi before accelerator driver or cxl_mem unbinding the 
accelerator memdev.


You will see that later today within v26.


Thank you.

