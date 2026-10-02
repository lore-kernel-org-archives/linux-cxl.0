Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF5F2E3FE;
	Fri,  2 Oct 2026 04:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790915567; cv=fail; b=GTE0sklrgbcastS3zgWfVL5/Yb7UwKj5tl4+gw/g7sFSc1kpSwMv8jge/6sxjel3Q/j1gQUzg4YS0J+STlelu6BjtEmuDPaef7KTFxA4izrky+DBZvpru9ytBkC6yVPH5CiEKg5C0prxFJzrQLkFI4PZekJ0NnY1JtBZtyNJM88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790915567; c=relaxed/simple;
	bh=cDqZhmt0FeRP523MNgR/0781+YQ+bqRbFVj0epfbKoY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WcUzsOmwYwrCVGKxw0h9kCYBrB9MGa016l4Y58mWqEH/KGsgejt82x5zkihyYoXcxz7AN4GB6/k8yZJiB7mZVCMy2GKnNiWV8BKWiqLxS1uncPvqNBKh7zwfyPQ/pe4ywebSs5oJrw2ORJ/vmBwcGerWkh8+/uFbh63+RBSrwJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=100+Kqjg; arc=fail smtp.client-ip=52.101.85.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="100+Kqjg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpBZs/I8wNc/DIo5CAj96sMN4HO7LIdsBF6mDz4JM4uEqDIbUjx/EgwOKrZfA0VPTxevwcab1Mmi6l2QjuS+dH2TYHN6EcAus44g5Jz7XiWvv8QiSkXSLWPvaJWjymwxI79Y/4HRcRABe+zvOPNm6ffENlXYwm5Xc+YPh4GBdfAOPzaj9P5jhM5LagVfTmlWDZtUet/QmCoXbxwyD6AccGSdVqvfv1vJ1gZp/+mYFjdCn//PBOulmqQ0SdsS4vZ75dvbmWAPs5K6Aof717vtb/hQY9Lv9zkN+u31hqauMV1XxtrGROcRUaGJRSVNn43248yD4scb9lz4FNnLvua3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1xao8ztuKFwAcsb4aYNd+QXRAjOTnmrbn39DJS/Stg=;
 b=MO/tlk/VwLvyKhQOMykB49DnA7evZGpi0QS2IcuvngNuIGWN9KsDYEltaO+1FK5BSZ05+gPu5ru4a/SQNfB4ydrIyNl5PmyoFhugftIqhq7r/s+IOoMtmfa574MU2eWRQNaL+3dgBfZYvaWHetwVTAezzj9+TVXlHZlIPKoLIKlA9Bp3P6kxtuvPyUJyvYwmBprYf+tpcbCyixqJkE7fabKn2VBVN2hn4aeDWLg+elkJQUQKiHvlmyxDhMw7UCOv7wafL7uBgJasGj3+Ouv+h53l+/HVFVPZ77rkzlg92s1Wv79lMLYUl7B4dzDaJmNt2ZBwbwa/zg/MNWxkyPj3wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1xao8ztuKFwAcsb4aYNd+QXRAjOTnmrbn39DJS/Stg=;
 b=100+Kqjg6vXFsGn1S8w7M2JR0ZVfJtpjJyynLJNxPHTYSwwGnlAuEB4SUO1pZnHYdGz8KLO3jeUdZJPfvivPtZvablNyAuiQ1NLDu5pWepjIOZ+NRqJvFAsI6RpI6sxw/YVEj/t9yJgjzMXBs5Bs1C2wgO0Oq3/9Bchk64E54XM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 SAWPR12MB999269.namprd12.prod.outlook.com (2603:10b6:806:55e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 04:32:42 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%4]) with mapi id 15.21.0451.022; Fri, 2 Oct 2026
 04:32:42 +0000
Message-ID: <b7fd6cc3-1aca-440f-a87d-d0d94ae9eed3@amd.com>
Date: Fri, 2 Oct 2026 05:32:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] driver core: Check for supplier requiring PM at
 link creation
To: Dave Jiang <dave.jiang@intel.com>, alucerop@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org
References: <20261001132023.17032-1-alucerop@amd.com>
 <20261001132023.17032-2-alucerop@amd.com>
 <9e8a45df-1755-495f-8e80-52c65b832dc9@intel.com>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <9e8a45df-1755-495f-8e80-52c65b832dc9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0350.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::12) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|SAWPR12MB999269:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a41f920-4362-48a4-41bb-08df203e32c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	u6SuJlcC7Lzj3g6nshxpckpvS/TxlM4bwDUqsMDdWbsIbSDxqr/4VP8LXdNSbRJ2acy6++DVp9nlsZL3lSs8AByiTxcVLYJ5S2Uu/Md1coAv9d3Y4YfvmQaI4ebSZ/d+VEeb/tkyXnDPTPRvHzxn5GlfPl7j964g+vztFnZ2tcZlWSLM1O/28TXEht76mhLKF8vyU1x7ajEJ4xZtIrpDfeJo2MtOnNd12z4fkegf1tHLFIz+pL3/v+HOn0DxvW80hs3xSXF+MS5Ya829x4rVNZ9qRDRjbWZyhHicFdbpiLwHbXh/OPtJh3OO+Rc3Td05rZrUXS3poPHP3vFgAQrqMdrgQ2XmKB0UOw0mMxcDRIJu9wjPG1s4s75LXXwwi9PWyqhWnMumhRN/FszkjFjayW6BifDyX/qVeXOTERxof+LC4DqaTbETUe9Irye4U3KnTzvFpl7TrBvk8mk0qbdOiaovIBt0LA9sjfpekCaxxNjDe0YDacnrP19YC8tyMDyUjSB1B7EiTuMTAftRqQrStVJd0CjMfRfnKlq3cUQrl1ybJ5C/MX+IuIKJSyHhHOgZ3hGsT/Bt1CeOEz6bXJ+pTQdczEavapiaNho7yiiEhJmJdZo2z6zbacfg7nsgd+QZ74IocjRctsLvP/8M9safUg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzlOVEtQU0tMaDVwRHdKaUFqVXNNRkh3VTBneU52TUlrZSt3R3d3UmdNSFpS?=
 =?utf-8?B?OFQyNERHRXp0LzFUTGo5cjBnSUp0L2JjbkdGb3M3N0ZwT3Q2NzVCZ3RjenVE?=
 =?utf-8?B?OTZHSWpBK3UzN1pacVkvTG5RYmZ3ZUVDN2tpRUJaSjBrQjNPakxsNlpRbGJ2?=
 =?utf-8?B?cGpSWWdrbFRjbmYzME9TU3UvRU9BaGFrSUY1cTFERSszTmY5ZDJqUjlrQkVt?=
 =?utf-8?B?RE9jZkJ6SDRzY2x0ME5jUThPNGZCOWJRdEJrbmpYWUk2SW9FWUd2UndRMk01?=
 =?utf-8?B?a0d3enJoYlZSREFNRmxTOGpsKy9EYmY5SVMvdkx0YWZOV0VBeThHdVd3eTN0?=
 =?utf-8?B?SGtMYm5VOVo2Zi8xb1V2VVZKUWwwcFM5K3dxbDBBK3BxWnNVMFFWdFdBeEgv?=
 =?utf-8?B?S2FQQktSZFZPcjJSRUJZRFVmWGJSTzg3OUhiZnhiWVlKUys0QU4xczMzelhS?=
 =?utf-8?B?MjYyamdEaHBXR2pTVmxaa2x2OVpLaHJDejV0eitYOFZXaTA2ME1pdW1qRmlC?=
 =?utf-8?B?bFRaWUVLYS9LTDc4K1VEMGJ5ckhEeVoxY1hPTVMzVlFza2p6c0VicE9WeXAx?=
 =?utf-8?B?VXVjMFFsQUZFNHdwbVV0ZG4zN0NBTGhoRDBiTk40NHl6WFQ2bWo2ZmZrTnlW?=
 =?utf-8?B?SWpjR1pkNUxVVW5vK2ZhRXJhVytUQlVNWC9XTjVMUW42UCtHWDloUWZ6SzRi?=
 =?utf-8?B?WTY0b0hkdGNLNUs5M092cys4TUxQQkw5cU5sczRaSzJSajJ4MXlMNTRnS1My?=
 =?utf-8?B?UVpPSjN1Z1VMU3Nhbkg2Z1NmNFRGd21ZWVp0SERFMnlOM3BSb2p6OHJMZUcx?=
 =?utf-8?B?aVJRUnpxT0xEbWpaZFpidGQvdlNhaG1hczlMdytJM1RBT2Z0aFVOY3NpK3dl?=
 =?utf-8?B?NlNZNzV5NGdNOTZuK0diSlNNUnhJcUtqcDN2Tk02NXdZUTVIc1ZWNzkvcGo0?=
 =?utf-8?B?em9RWEVFQkhEUnVvWjhIQ0lITEtFSExubSthREU0eUcxb1lpcVZGYytYakxh?=
 =?utf-8?B?SFJCMG1jeXcya292Szg4TGMyMGtTMG5ON2c1b29QelZwL05xaXpBRnNGc3ha?=
 =?utf-8?B?Zmp0S2s4KzAyQjNHR2k1a28reXhMcmU3RmpmRmdXM3NHdW9YV2tzcktOV3Y1?=
 =?utf-8?B?RVZPSFBNSS9JNXVacVo2b0U4b3duRTAyZVV3NEZpYnJhdDRYVmpMYXc4RXFX?=
 =?utf-8?B?TVc4QjBnQjBjWi9JMHlYUWpCZHU2R1R5Um5US3ZKOU9DUXNQZWwxWWE3anEx?=
 =?utf-8?B?b1U1aDhtSzhrUi9aL096WHVPb1dHSjB1Y01oaXBxeVA0YlRFYWU0bXhIaDVz?=
 =?utf-8?B?YllwdG5xRExiNkZJYThPaUt5WTlnVUphaThrQ285dTZhSTVtSDRwY2REN1A1?=
 =?utf-8?B?K24rSFlaVXBzL2FaQ1FZVUtHK2k0RnFkSStvbjdPVzAvOW0xbnBzU05ibDc0?=
 =?utf-8?B?UzUvWjlXSlY4NFo4VzNXVk9oQkoyY2xwazFpRHVUSCs4ZlVCM1FCb1NoNUJM?=
 =?utf-8?B?eFJXMHZBQUpLV2lBVnJQdXcyWnV0czVNVDk0Y29aWFk5TWJwZG9laUZxSlRV?=
 =?utf-8?B?MzgvTDRWaXpobWRNMWl4ekZldEtjTSsrSEkrZHBTbk5SSXcrOGFHeVM1VC9H?=
 =?utf-8?B?NElXTHQ5NzRDUjkyNnBEOXpFWUw0Vm5pY0JJVnhxcS9IcFJlY2diTndJdGt0?=
 =?utf-8?B?SHd3MU8rSm9ibXJqNEsxNWNUSUMzVFFySlVmbGl2b1RNRVd2UU5LT3RXcnhF?=
 =?utf-8?B?M205dE1Jb2F4YXZ2NDhtNmk0VmVyaElPWHZSWUpkZnFySDRlekxpdWRHSHYr?=
 =?utf-8?B?aTliYVBlcm1uSkRhd2UyaXFmWnh0Zno1RnUxQ2YweThERGV4NVl4dWwxdExB?=
 =?utf-8?B?OC85Rk52YlE5UStBYWpZSXdhTjUrRkRrUGRnVFpscE5OYW1hZk1BNjBMYU01?=
 =?utf-8?B?WUhoQ0pmZWhFM3E2NTM3QkxvZm1hZ01ZN2pZZjZSdForM2VXekh5aVlKRWVy?=
 =?utf-8?B?VUFUcXI0aWpIWCtXdUU2cW9tL1luR0tzWTJwM2U2MmYvblZpdDJwclBNZ2g1?=
 =?utf-8?B?Q216bWpWRmh2YmdiaDF6UmxtdW55Y0w5Vyt5S3hrVGlvL0NBM1IzUCtTZmFV?=
 =?utf-8?B?Q2ZRNWpSV1NMdzhKQWhORW1ibkZLYUJmQ3ZpS1RqNEY0RUJKQjRvdWRrUE16?=
 =?utf-8?B?SEpMT21XZlV6cWJWblhwVk1JL0lDSG5ISjh1cUlkRkszRmlxU3NUbHpyK0Ri?=
 =?utf-8?B?N1BzMVdKQnpKQXprUGlXWEVqSXhyZlhTZkNkR2g1RXEyN1BZbUpyeUNLd2Ns?=
 =?utf-8?Q?WfVOq8yGQf4zzFLVKM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a41f920-4362-48a4-41bb-08df203e32c2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 04:32:42.2956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTVI1Bl9gp9hNrpVzO+13vso8TsYUY8VLjC9ebF0vmA7l80m5TP7eArNhn8+VisB9O39pTHZqV76+rsugjoxtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999269


On 01/10/2026 21:31, Dave Jiang wrote:
>
> On 10/1/26 6:20 AM, alucerop@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> PM initialization could not be necessary for some devices.
>>
>> Avoid checking for supplier PM initialization if so.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/base/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 4c0c373998a1..bf0513beafad 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -840,7 +840,7 @@ struct device_link *device_link_add(struct device *consumer,
>>   	 * SYNC_STATE_ONLY link, we don't check for reverse dependencies
>>   	 * because it only affects sync_state() callbacks.
>>   	 */
>> -	if (!device_pm_initialized(supplier)
>> +	if ((!device_pm_not_required(supplier) && !device_pm_initialized(supplier))
>>   	    || (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
>>   		  device_is_dependent(consumer, supplier))) {
>>   		link = NULL;
> A no PM supplier can now be linked at any point: before device_add(), while it fails, or after device_del(). Maybe replace with a helper like this?


I would say you can not use a device as supplier before device_add() 
happens for such a supplier, and if it does happen after device_del(), 
something is wrong with the caller.


Your suggestion is likely making the code more legible, but it does not 
change the functionality I added. Does it? Not saying it would not help, 
but I can not understand your comment for suggesting it which seems to 
point to potential problems I did not see.


> static bool device_link_supplier_ready(struct device *supplier)
> {
>        /* no PM devices never enter dpm_list, so check registration directly */
>        if (device_pm_not_required(supplier))
>                return device_is_registered(supplier);
>
>        return device_pm_initialized(supplier);
> }
>
> ...
>
>        if (!device_link_supplier_ready(supplier) ||
>            (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
>             device_is_dependent(consumer, supplier))) {
>                link = NULL;
>                goto out;
>        }
