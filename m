Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012005.outbound.protection.outlook.com [40.93.195.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9463242B1;
	Wed, 15 Apr 2026 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257839; cv=fail; b=CdZJpgjIr7xpvmPqzkBmWKcmwofH9Q+kdu2O0xVpghk1qoemF68nf8p+TihqWHNhWAw6Pr5kO1GroItymmp/Co3CH6vzHDsfrE/J35db1RijHqiyOGzwtx5IoHvrNGUrz0bjpJwYXa4HhM9OSoTAf21BXbfwkvDJPeA3k+7bUM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257839; c=relaxed/simple;
	bh=DxgXrjCTrwls2CqNq7zprTU+Qzl9bbk7m5ntHqkwq7w=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uq19ul3yHttiblNtuNTMKRhOhEtmUGXdfYVVwG3H6HAh3Z4exV0Qz9fTI2XqcOVvjcrbCPyeueJHuAxvaOt48PqoARy7SThZnhbPYmsFu9vBB7pYV+lDSEQJJTlWAfiR8+o0lx3z8ZBPHFSaEd3JvAUTUhuFv+tURh57rad2Qvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v26trzVx; arc=fail smtp.client-ip=40.93.195.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v26trzVx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JaUnZrHSP5dgs0OV1sEpp+jWFdcc894Ltap0fb0525YiIS+zWn0uSpr2aBz4pOvfgyPOhCbTFbOtgYnxYqBZ+EPCWCeIHpptisTxnFOdu7KbMAiUCHEj+5iAHgOC/ziDF4zJiKR0fgqlQvB9G3TOfJnmSmJgFEcvBu+Z7oSNb3UBBaJqbtE8H6MaPj36AAbHqO/zEPmCrrJgCoW84pCtrYAiD+JQPEoykm1VbBFL+ux4stf0CmjArhKEEx4FqkbU1mwuaOPjoSgAHeec4ziYbR8a47SAC8GPgvlNECkTt9p1cS7sb1fm3qnmn2RzcqYDGW4AXL1gRcG+PT2BuK3mDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uz7b5VlENdJJxbqnJIMLgiZ3x/4bgzLboxbfeFjd9UE=;
 b=SKUfv1xbUtTfsz/7oMaM6B4PRLKAcmltmjpKn7gqFcFwx9GzO0xYC1xvI8PHkfNMhfPMGM9VPbOPdF4XkKTZ7+oWDObuX8CCthF9HKSNLymb3QpxxJJEbv/CNgochVxqBmL+Fr05NPlteoI0Sy9b9RmU+rjnkaNqgXAlkLiDNjjU3+ZPPX12/weTcSoW3+gXu9+b+wDh8NJC5G4ciEpms101BHrhc46Fui7dYkQ+vpfAcROKgLycgs/YnrNEfkNTSOFOCLxLotSHOSigFh5MG/htMemc+8+5w/j9OwXbPzc1KRRhvel0uLH+0TiRyJhXDSKJs+/bod3AotPRRywHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uz7b5VlENdJJxbqnJIMLgiZ3x/4bgzLboxbfeFjd9UE=;
 b=v26trzVx7rAxUVmMz3XQ9+2u2AR6WSfuhI9TSylvX7u9vt6Oywts4f3haiai0pRf5uJWQXi9y6pTM6xoY4rQAet/PhkNLldetjUr748x3CwxIXAQjS5t6jMdp3CK9I94Q7HZYgcZYbkaSfK8Nc/8Tl2hFkDD/aW3m8uVZ8LjAPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 12:57:15 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 12:57:14 +0000
Message-ID: <b2a780eb-4e62-4fde-9af7-8b2410a98187@amd.com>
Date: Wed, 15 Apr 2026 13:57:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] cxl/region: Introduce cxl_memdev_attach_region
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Dan Williams <djbw@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 alejandro.lucero-palau@amd.com
References: <20260403210050.1058650-1-dan.j.williams@intel.com>
 <20260403210050.1058650-5-dan.j.williams@intel.com>
 <1bb8bdd7-1083-4b08-8d9f-21d218e383ca@amd.com>
 <69dac05fd8b20_fdcb410011@djbw-dev.notmuch>
 <b592580e-da0f-41fe-9ac5-d8dcec8fc6d8@amd.com>
In-Reply-To: <b592580e-da0f-41fe-9ac5-d8dcec8fc6d8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0161.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA0PR12MB4447:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9619c4-efc5-4577-df01-08de9aee843c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	izAwCPbf9Prs7I24YDIVIspYKESVsrRDUyOzgvB1g6M/1+UJBNnnEmhhSBxlycKAoc+bGfcKtBiAsgyg4DZHgAnee31tg8btef0/lDRQrbXzFE6vwALIP50ZqsJm6Db/NLRaBpNc5z5DIXUg12zCPKewh+IO2Gb+fQ6k4/xpIZXZjvC1N8Cm1BcsoOJBrBMaDLFEFej8iNThfs6IAX4RQZVgMmjxOvi5X1A/i3Zsx6DkhjqjQTgkspHzVgY4hIQthr3bHriDYgoTL/JXlps1etUPyyDhVtxkidarHIWmtAksWAf5JUHn1TO8NmLhxZNrtZmis4XHANAlLQBLKcVb+ZkjwvQChaqrfCVqzMC2Fo0ATmC1ZJW1PQtj7tPtZGJSjXTe3GmFZb8mz12lbd/t6P9pY2jAL3bFdeqRbk7RNs0OIBYybLRSMKONn/2FoShbbZYoQadjygeFoerxCONgICVTuQhv5HJ3AsHo29Jkf+ooPbMl9qyYhz+oA8r6uDmpY8A7+zcbbZ/OcRSjsjr2cQPH/zS3dtlBv3IfUnWh1AMk6SkjhKUk2OwYi6x1gTFSc3k4rnCIpu4O4bhgr0NXNpJIy9F3K+lUL2Zv9g/koG549ARR6ghM3WMWfjIsa2cNNTYX7zOgXnmpyu67zEY8yiFKKlHH/5ygq32KV+fMv7OGlZKaQqO2R1lNVtY54A7PlrgBU3GAOGzIcApFDT+DAJQxV9jJoxCnNHkB8hKp55KctqQG39zzxTuVJT3bXWEU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUtod1FZVXVYaHBkNmNIVHQxOC9WRkxjRWhySzZpM2lwWkUvZDBJb1F6Q0pa?=
 =?utf-8?B?dFZvWGVkYkJpS2lTYVRndTJKZ1VRZGZzWWJtN3RmejJ4cjJlbFRCZWpnV3BB?=
 =?utf-8?B?MVFPWmhEUWkvd29HK3ZQSnRGVzRWeWw3bHROLzB0dG9IKzBuMDZpamtPRGl1?=
 =?utf-8?B?NzBlZU5BaStzdjdrQmRJNDJVc2piS2dXWmZwRHA3dzZTTk45ajFPMzNsVzQ1?=
 =?utf-8?B?U1VNT3g0YkExbUtwcTNXazNpenI3ajlXKzAvQS9EamlUclJSV1NLMUJqYlM4?=
 =?utf-8?B?RUNYMjBNUHR4TUlFT29wQ2h1T2djTi90VmRJZkdjZGd0ZlhyUGdXNmR4MkNu?=
 =?utf-8?B?NVo2RWlaK1RZRi9neWNyYTArM05CR0pYbjNVQ0hhODZOWHBXTjFoZGpWTWcz?=
 =?utf-8?B?ZHR1aVUvVkRnS2tjRm5ta1gxWStvUHFBNHJMVUx5ZXBTbE5zc1hyUGZQSE03?=
 =?utf-8?B?bUZJWTB0VzV4NTU1RWZ1eFRTUmNNbndTRXVtdytWemQrQzBwY1AyWDY5eVFG?=
 =?utf-8?B?UEZKdGhmVWp4c1hQang0YWNuaFRpMmlQTExiYUJJaWZxN2h1ZFNJemsyVjZk?=
 =?utf-8?B?VmpnVEd1S2hjVjE2NlZsbE1qUVN3dGpOZjRQSW5OVS9tS2U4cWdRWXlBbTlN?=
 =?utf-8?B?dkZ5am5ra2NYbnhnUUFSWHMva0NQWFphTGVrWEd1TUt3ZURuMFRYcVZkczly?=
 =?utf-8?B?Q0dFSlovTmJTQy9FQnl3NllRNWo3OGZXY3lWNUMrRjhJLzRhZVJhZy9ma2NT?=
 =?utf-8?B?KzhwR3lVSHJSTWNJRGdvRDdjOE1aMnFjeElJN0dueElhWi9aQURab1ZJZFpN?=
 =?utf-8?B?Y3p4YjZLVDZBenJVeDM1S1RBOUZpWDVuWW9xMWx0RC90UzdoaGRIUEx2WnRi?=
 =?utf-8?B?Tk4zem9pNlFsREZzRm5oNEFFZUhnZS93MlhaOEJZZXg5ckl6QTF5eC9UT3Br?=
 =?utf-8?B?RjFMa29pQUpLOHFDV2pEbmNwR0tQY1RrTzBpZnVRWXJjTzRLY3lSQm9DSlJ5?=
 =?utf-8?B?aFZhTldVMWhicXU4MmVhS3YwOHhrUTd0UnhoT1VOb1QxZ21pbVN2akxUM1Yx?=
 =?utf-8?B?aU90SERKdGt2WEcwUEtUbzlOV0plM3p5L2l1YWRoeXlaZ3lWY0puVkIyVlVa?=
 =?utf-8?B?aVRyTEFlNVAvZGFzS0RsQ1Jsanc3NGlsVGRyUFVZZ0kzb09wOCtFaWhZbmN3?=
 =?utf-8?B?UzMyN3Z6MldIaUhxSklIbXg3Mkl2dEUxcWFDRUNvZzZrcUMySy9xYUNIMkhp?=
 =?utf-8?B?dWx6a1o3d2xvbW9qd013TUZCMjh1ZzZaZW04QlM0Q1hTd0hGSm1ScUJjK3BH?=
 =?utf-8?B?T0o3eWpFSXlFMHdYbDNTcHNncVpzMHNvSnFyOGRKVFM3T1c1eWNad3Q4cGRT?=
 =?utf-8?B?dzhtK3VkUGxWNGg5N3hnM0pmd0hWU25Xck45aXR5NW92a0hGSk5td0lpMUVS?=
 =?utf-8?B?Y3gyRVhadFkrMU5vQUhPcWVRRnVHaVFXMjA4VnVDWFZqaWt1ckVtckRUYkFG?=
 =?utf-8?B?TU5YVjhYYmFEVEJZbUJxWXFDbkpONjlPS2ozd1JHMk1ubW5MS09lcHdzZnVK?=
 =?utf-8?B?VDc2TlQ2eWovS09FSUs4Y3NLOWUybVNzU2dYem1zQ2lmdzdqVE54Uk1sMVpx?=
 =?utf-8?B?dmhQWFpKTmNhTDlheGI5U2E1R1gxZ3Q0UHNpK2c1MDlvN2ozYTVXYy9wa2pw?=
 =?utf-8?B?T2YyaHA5aFlibi9mdnlYQnUySGsrL0ZYc3VMTVRxL1RqUm9FQ1UrcEQ2R293?=
 =?utf-8?B?RkVGczJMTUdHUW12MmVFeGFrUHRsVGs3Q0xNUmlPOXdXZnFodFRaK3JyalZz?=
 =?utf-8?B?ZENBZVdiZ0toY3JPNGU2WlAwdU1NaW9kMmdocERXRG5RMlF5V1FzN2tGQytZ?=
 =?utf-8?B?eFR1R0ZjZmwwbVUwRkcxd2plaFExSGlnNm5QNkNhMzVWUGhydHE1STRSekda?=
 =?utf-8?B?NG9FRlhrNmFlbnNVVHFHSnBqZDdmc0t4YURBRVY2cEVhbm8xZnFxa0lTdDdR?=
 =?utf-8?B?M3dqVlhGa3FuSW1YOWFxcFlIbXJXbEMyeVl0K29WNjFMaHRkSWF6a2VIZDNK?=
 =?utf-8?B?Q1BFOVoxRGdiKzdZU1Z5SnhNUDM0RlFyaEV6UkFIUlN3eHBOUGNLYlJOUnV1?=
 =?utf-8?B?bHhTZkFLRUUydDNXZm03Y05YSFY0b0NKejFQMUVLWWtPYkRuTmMvU2RDNEd1?=
 =?utf-8?B?UVFMeUFMU05TZWRrV2RPeldaNGh4TkRWd2pEdFNlRGRFRVNiRnlOUUJObk1o?=
 =?utf-8?B?UkpLclVJZlEvbmRlRGQ2MFNVTWFEVzAraVlub1dUTlJtSmpvOEdjckxnY0FH?=
 =?utf-8?B?ZTh3ZU9ONU1iRWRPUEF0OVFqRjdLNUNZWmpTM1RTVVFuK0JwMURzZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9619c4-efc5-4577-df01-08de9aee843c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 12:57:14.7139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: js17n/QtPt8RpCtktZylVVK8Q0p9vfMi6BoPPe7ecHWV4WuySD2yWL9h8EPbRZvkU4+F6rEAFw6lRACEfn8XmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447


On 4/14/26 16:41, Alejandro Lucero Palau wrote:

<snip>
>
> Also, if the cxl_mem unbinding happens after the type2 driver has 
> invoked ioremap, the driver will be using something it should not. 
> Won't it? I do not think that is correct and the type2 driver should 
> somehow get a notification for stopping using such a range, some sort 
> of detach function the cxl core can invoke. That is something I 
> unsuccessfully tried to add in the past:
>
>
> https://lore.kernel.org/linux-cxl/20250624141355.269056-19-alejandro.lucero-palau@amd.com/ 
>
>
>

FWIW, in that v17 I add the callback function in here:


https://lore.kernel.org/linux-cxl/20250624141355.269056-21-alejandro.lucero-palau@amd.com/


which gets completed in the last patch for integrating the sfc driver 
cxl pio buffers unwinding.


I think that is necessary. About this patch, I think it should be part 
of Type2 series with changes for adding the ioremap to the protected cxl 
region "attachment". After that the CXL region can be safely used ... 
until the sfc driver explicitly exits or until the callback is invoked 
triggered by cxl_acpi removal or cxl_mem unbinding. The sfc driver will 
safely stop using pio buffers keeping the normal packet sending using DMA.


I'll work on a v26 with these changes.


