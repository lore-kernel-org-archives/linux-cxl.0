Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC0616B75C
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176403; cv=fail; b=IOKkP9mYgkmxEmCTl+XqR09ALviTh+17TEyrfIR/WYyQILW7vFxsYwH9gggri2TvpHFcGZIvweXfVpZlF7FzAhX2tqGwn0qP0v78E2c5HxwGRaPHgXu9KHWeutOhcYVXiK0VqVI2THOZwWFRxqnbpxwNQb3cfbGWr7gCfrLsGeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176403; c=relaxed/simple;
	bh=xrr8qKFAVZ/aozRa+LXrgl5gERc+hLTDMMSlyhrO3ao=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rgrGMHrqG5wQID95x2PJGYhsWB/nkm6ebQ2tgNn094e0/YqoYGru1LSG7GbqFjDfP++hAitNKWxvIVYA9njWcOuViKLnLvS1tUk2ZptFwSPNffAtdq6y+/iqBg7uj5s/aZRVS8SF2swC+gDlKMw494sF+IP/xlXe6h5jiphU+OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qeLsz+QI; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qeLsz+QI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nV0AbCIxXserYdBPKr8+E3vGo6Cnkojpa0iE0C40uzpcqVtnhD7UZ07J8ptiHtAuJTk6JI0UP5R+bI5gwEP2arDwTQWtVKlRU+4sC6gjZj7j/kqOb2MEhddod/MzdWlB0IztrAm+SilcrFDjp9zxHyRoVG11YXo0YR+79FnjdwVai4Oazp0Dy/bYupHBUv0Z0nq6325pCzU6CcwUeTFDdOz9vQSJOYUSpDjahd7azs8hD+UXNI9SNjUDbLvjNqJISjePbE3UEsJkYWCA4iQhdDvir0JS6xrHJFNZjVSp40bxf+FwDfmHRTthgzbAokY9ebsoh7dvDYUc8qUzzQ45ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szSJCrFaZVLpdkaqNtcuk+w2Ot2zV59wgGql9HJyrqM=;
 b=ipuKLmT9wzGJoMViSPlUw/cy1yQQGmil1+q+l7H1puJo9HG3LEAnugaQhcjW7vbH63jjdIu12W/SiKe/+aK7rNlLIkDFzKV4BDqzTkYZnk5F7gQOSvv9I+JwSNRLPoRYlj+MQi/yZrzdDxqaYYHJ7Wuy73VXjuiWB7b/BgP6aZGSzitsVp87MA3GMVKWXB8t/tLvKec7LfAHls9Xe+dQsBsXtRzXmD2lnUnseJ1z0XLOGl7bN7aDK7K3Mjm9et+L1WHV8JZ1rJrODSnp73SuVwLQVQQQK2GNUactfHKyV+kH1LRbHVMCvJiVFtdqNm1uteRJyfos5cs8p5/1Bg8H2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szSJCrFaZVLpdkaqNtcuk+w2Ot2zV59wgGql9HJyrqM=;
 b=qeLsz+QI4csyHbTpSq7kwZAfF2SZlxM1ZIjy435kyRgDVmrz8Z0pDcqjugMpZ/LjSDCID+7O9F0B2yrHZn+A/bcVFD1ZTLPzH/oGmlokOiC0dhfqjQXCtGAa0AD7CMWATdl5cLA18cKDf0sGfUV/OYjGTK8hRg+fn/pYUuGq1UI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 12 Jun
 2024 07:13:18 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 07:13:17 +0000
Message-ID: <604ede40-c4ec-7fdf-234f-a67619136dc7@amd.com>
Date: Wed, 12 Jun 2024 08:13:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 02/13] cxl: add type2 device basic support
Content-Language: en-US
To: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 pieter.jansen-van-vuuren@amd.com, richard.hughes@amd.com,
 dinan.gunawardena@amd.com
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-3-alucerop@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240516081202.27023-3-alucerop@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0512.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: 964caff9-c0b6-48d0-0692-08dc8aaf2225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|366008|376006|1800799016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXlPcFQvL0p1dnY3VmZ2MElEekE0QVpwTkYyWjFiTCt0bHRYODRnNXp1SkF6?=
 =?utf-8?B?Rmk0QzJ4NTVrdDNmVkd1K1U0b0JKV21yL2FoaGl0N1dNQ1FxMklEWWFHb2pD?=
 =?utf-8?B?bStXd2N5WGpvRWt4ZkdFdmRlYVl0Vk9teUtGUTUvTjVqWFN4UU5CZkNOVUsz?=
 =?utf-8?B?TmFWRkRCQkN3Rk1DWjcvckhIK2FlRUJFb3ZBSmhVQWw3dVpseEx4QlBMVTlo?=
 =?utf-8?B?ZittS1piTHRRWU4vcTVTMDNCMTk0Snp0NEE4ejZNVFVJL1NON0ZTTGY5Qi85?=
 =?utf-8?B?M0hZWUg4dFUvQkpxWlRMK0hHSVRNUDJja1oxbEMyZ01MMXNrVitoNjE1clhk?=
 =?utf-8?B?Mkw0amU0WW4wdThCeExyalp5T3Nmd2VTWCsrdjlLKzVtSVMyUGNqYURWRm93?=
 =?utf-8?B?Z0sxMnhNOHdRZCtvY0lyblRuWEx0WjdiaVRvSFgvODk2aXp3NytUVmN5VVU5?=
 =?utf-8?B?SWxNblZQbFhIelpQQ05PNTIwSFhVZzJCY09Xc2JWb0pReTMxTEwySmpOeXdT?=
 =?utf-8?B?b2k2WUI2dENVK1hLblB1c2lQRzFhVTRsWmlpekJ5ZDY0WGNFblkrZDkyOTBW?=
 =?utf-8?B?TnJkeHFvSm9mMzRXajJLckhMRk1IUEIxeGs4UzV5bVN5ZitVd2pXV2twZUk1?=
 =?utf-8?B?WFpYVHBkWFZTVm43UU9KOVFSeHBtb2FEMEVDTmN5bnVlMkVmeVVBNGVPZHk1?=
 =?utf-8?B?NnVsdUZ6ZUh2ZlNydUwzaGN1ZnZMbWFLK3lnVjBhVVZuZ1JJdkdBS1JZSUp6?=
 =?utf-8?B?MXZRcWNmNjhyeUJEWkZiV0Y3SW9sN09lQVFWSDltMlZ6WVFkNHc4OWdBMERR?=
 =?utf-8?B?TnhjTEt1M2g1dDY3Q2pVaUN1UFR2TGcxWXhtN2VXM041aE5hM3FBZFdINjBm?=
 =?utf-8?B?MkQrN2pyOUlDRjh1UC9GOWdzK0V5a2p2ZzQ5TlBCWTlNeStuREJkUUprcGg0?=
 =?utf-8?B?S1MwdVZiSS8zS0FxRllhWWtObWlDQWRjem1hdE11R20vUlY4eXM0Zk5mQUl0?=
 =?utf-8?B?ZUNCQ0xPRjkrOHhJZlZCamFWNlkxK3pNdWI2QmNYYmdMQS9aSExHMnE1RzZH?=
 =?utf-8?B?aEUwNlhrTWxVeTlNUzhVMm00YUVvbHZyNk1HaUlBUmo5V2lGcDJKWTRrZm1s?=
 =?utf-8?B?c1pmblJkdFN2WkJ1SHNCMmd3eGora3N2UUJOdXloM0EyV1lQZ2VCakdBOXpp?=
 =?utf-8?B?bjVZcUd1SUd0WGRxTnczVGpEV1AxSkM1UzNqRFk5dmNjazhKY21uemxOcHNo?=
 =?utf-8?B?ZVJWc09QQ3gxNmxOR0VlZThmRldScnJVeWQyWTArWSt3T2ZlTDI5b1o3WWE0?=
 =?utf-8?B?aUo3WHQzekF3QzRlQU12N2xDemhJbjlydUpsbDR2S3ZUR2s3MEVXZnZOYzNx?=
 =?utf-8?B?bUg2UEJkYWZnTkl4NkJNNmdKWTRTSkJXVE9ibDBMaDh1UGlvM1lnMElHK1ph?=
 =?utf-8?B?NzRpYjJ4RGdLOW03cjFneWtPZm1mMmxoc01jSzUwMmZ1MDUxRjVBVlI1bys1?=
 =?utf-8?B?bVM3WitwanhBRis3Ri9pc1RxWlBJODhTQ2w1YnA0dFJud2t4TTNScWZtcHRR?=
 =?utf-8?B?UFFpSFpFa1VNNFdtMURENko1cFVwVnBhb1BPU0ozd3NrQVRPS3ZvajA5cTFh?=
 =?utf-8?B?S3pEeXZDcnBQcHVLWnFsSmltMElNajRsc0RMNDcyTkdBTHhxdWMwNkY0UWcv?=
 =?utf-8?Q?hHH2IADOPnTzeb44pnwY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(366008)(376006)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDVGMFVpTWhoVmRoa3dTQmtIbHBjbTlGWGgvM0xoWG85V1M5ald2VkZ6YmNG?=
 =?utf-8?B?OE02RHJsNVZMTDNKVHU0Wk84T3JaN2plTDdmUThpaENSemgyVDV3eDBMekJL?=
 =?utf-8?B?YU9HWDF4b09iV0gwNHEyV3BtcDJjUyt0SjQ4U1ByZ2FZejBndEdGUHp6cmZL?=
 =?utf-8?B?OW9Lcm9yazVCdE1TektUR1pMQ1hTNis2K3YvNzhPQ1JoSUVoOGRELzdDS1pw?=
 =?utf-8?B?TUlBNXlPa3pLRzBBOUNYQnBHOWtsb3hydDVxa01XVHNWRkcwMnYwV2dseVJu?=
 =?utf-8?B?d0RtRkZ4VTBkWm1zNHJydEZJaW9Yak1HcWtCK0dyT1g4Sy9mTlIvcDE3aTA2?=
 =?utf-8?B?bW9udm9HSDh2RlVoVE1pWjlRV1BSclNiSVJMYy9tZ3hkazhyVDF4NllmdTZU?=
 =?utf-8?B?TDRjMUxLVjFxNGR3Mkw1ZzJYeGs4Q3Y5MVBQVFp1OGpvUmxBNUdnVTgwL0FX?=
 =?utf-8?B?NzBqa1lIUjZPNFdxc1lyUlN6Rk1pNVB0cGVUWmRMOFhDSXBWRk44NkJYNWN5?=
 =?utf-8?B?bGpyb2pCaWxNRkp4MW9LM1BpSG9IVmVLYTFmZjJSaWd3bTRrOGJ1RXZFMUdw?=
 =?utf-8?B?MXZaTE9DNmVVL3ZWZkZYSE1DMXJudEg0MFBCd1E5SnZJS3lYb0dsaG04WmQv?=
 =?utf-8?B?NUxRV3RBN09ZVXZzbFg2bi9ROEVHYzg5dDJBYjZpTTJ0a1hwTC8ydzVVNzZG?=
 =?utf-8?B?ZVV5L29TcGs0aDF6d2dOek0rRXRGR1k5R0JEaVpLTlZicjlrQUlCZEg3c3dF?=
 =?utf-8?B?L0RBbkV4Z09McWdxY21rM2ZqTWJtdHIrd0ljcHJuSHhVSkJHQWJRczlnM0Yy?=
 =?utf-8?B?a01SRVk4aW1MQSs2WUpuMU9HNVlHajBINVN0QlBnUWJ6K040aDNvS3plbnlU?=
 =?utf-8?B?M3E4Ym43OGJYN2FWdVdBUWdlbE13MmRRTTE4RDlydlFOUTFNTnF5bnloT3Nq?=
 =?utf-8?B?NDRlWWVPM21MN1Qxak5GcnVtbmxkWG54NDU3R3RRRUZPWi9PYWpad3RDdW43?=
 =?utf-8?B?VkJveTNJb1ZhUGJmNVhvR3J0MXdGVUQyaTNnaGc3Zm9uYTYxaklDQUw3ZkJI?=
 =?utf-8?B?UWl0V1Y2bkw1NVVhM0RndWVKWi9sVWJ1aXFuZlNaanAxNlZmSEl1SEtKTXlB?=
 =?utf-8?B?TkY0Y0Q0amdHVXRBMjc3V2hqWFppV2c5OVM2NWVvaXNLTXRpRDJKdmVCNE5q?=
 =?utf-8?B?UHVPVXAyWlRlYXM2UFc4TFRidkhYNjlGMEF6SFR4T1lZTXNZV1pUZC90Nnhm?=
 =?utf-8?B?QkgxWW1FMnE3QXVTTXBMM0hrUml4OXd4WStCRDYxQUZwZW9MZU53R3JrZ1Bo?=
 =?utf-8?B?MXZJN2lqL2EwR3hzS0xNOWx2c0RyVEtyV0U2dXNrd3ZGcW4rZGJSSEZhZ1Za?=
 =?utf-8?B?L015NzE1Nm8rb1JTS2JDbjdaWWwxN0xCeHJ1V3ArZmg4YjF1d3dycjNVc05G?=
 =?utf-8?B?MHZMWnlNbElhN0UvTDh2OFRvNU8rYnVYMzJiM0M3a1U3bmlLb2JWekdjWXh4?=
 =?utf-8?B?OUZUTjczVGJBTC84QWk0NVorTDQxeDhxRlo0UnZ0UmtIclZDY2VlVjY3UHh0?=
 =?utf-8?B?VkdsaFdwZmdmUDI5SkpjR045T2g2bElnZVg4NWdWc3pKSmVLSkVlUFkyUGkx?=
 =?utf-8?B?dDlkaW1zVm0wK2xvRHE2Q1Y5VHRrOEcrOHdkSXQxTHI4Mit0SjdTa2Nxc0Zi?=
 =?utf-8?B?MzNmY0lIM1FLTHJ4anp1NVNqbmE4cG1taENIYzNTWDJSdGpGSDcybTNxRk5Q?=
 =?utf-8?B?VUNLRUEwRUo2ZUlpcEQ5N3J3eHZEdWdXOW90cGVzb0c5QzBzdUlrVnFHZDFl?=
 =?utf-8?B?UHY4NW1ndVN6dlNuL0dybkhLUTNzdmlROWt2V0FwaHdiZmxqUE5EeXQxeG5H?=
 =?utf-8?B?WCtRN0tCNkROSUROVzc5YXNvWVZ4YTg0ZnlXSzhtZmwvNFJ2QnBvYm4xdUky?=
 =?utf-8?B?U0pyTWNBSzRWdnY4ZGs0YkFUQ2RPbkxNc1h4N2pjZE5xZmlsd2tvZmRBV0tz?=
 =?utf-8?B?U2ZGeUJqN1ZVeHgwTVc0TW9MZlAzMkFlS056blRFeDd4Mk5qUzI0dGNBMVlZ?=
 =?utf-8?B?QlhDUGR4dWQ3Q3I2V1JnTW9IQ1ZNWVQxempsMXkvN1Bvd1dyVjVjUlBlU3M3?=
 =?utf-8?Q?4v0P0LbemPW7WZJvD3Lhb+6Ei?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964caff9-c0b6-48d0-0692-08dc8aaf2225
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 07:13:17.8574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4zr8+R8Er89f9Y8D6mauxut9tVUBhMDDRUqTG7eDOHPl5L50dbWrvCLsR9BU6aujefeZGZHEsmjx4V3CPPYkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734

Differentiate Type3, aka memory expanders, from Type2, aka device
accelerators, with a new function for initializing cxl_dev_state.

Add a type2 driver for a CXL emulated device inside CXL kernel
testing infrastructure as a client for the functionality added.

Based on: https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#mef63c11ff2ffc265b75785caeb2c2370953ccf44

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>

On 5/16/24 09:11, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>
> Differientiating Type3, aka memory expanders, from Type2, aka device
> accelerators, with a new function for initializing cxl_dev_state.
>
> Adding a type2 driver for a CXL emulated device inside CXL kernel
> testing infrastructure as a client for the functionality added.
>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/cxl/core/memdev.c           | 15 ++++++
>   include/linux/cxlmem.h              |  2 +
>   tools/testing/cxl/Kbuild            |  1 +
>   tools/testing/cxl/type2/Kbuild      |  7 +++
>   tools/testing/cxl/type2/pci_type2.c | 80 +++++++++++++++++++++++++++++
>   5 files changed, 105 insertions(+)
>   create mode 100644 tools/testing/cxl/type2/Kbuild
>   create mode 100644 tools/testing/cxl/type2/pci_type2.c
>
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 07cd0b8b026f..0336b3f14f4a 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -659,6 +659,21 @@ static void detach_memdev(struct work_struct *work)
>   
>   static struct lock_class_key cxl_memdev_key;
>   
> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
> +{
> +	struct cxl_dev_state *cxlds;
> +
> +	cxlds = devm_kzalloc(dev, sizeof(*cxlds), GFP_KERNEL);
> +	if (!cxlds)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cxlds->dev = dev;
> +	cxlds->type = CXL_DEVTYPE_DEVMEM;
> +
> +	return cxlds;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
> +
>   static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>   					   const struct file_operations *fops)
>   {
> diff --git a/include/linux/cxlmem.h b/include/linux/cxlmem.h
> index 0d26a45a4af2..e8d12b543db1 100644
> --- a/include/linux/cxlmem.h
> +++ b/include/linux/cxlmem.h
> @@ -859,4 +859,6 @@ struct cxl_hdm {
>   struct seq_file;
>   struct dentry *cxl_debugfs_create_dir(const char *dir);
>   void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
> +
> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>   #endif /* __CXL_MEM_H__ */
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 030b388800f0..a285719c4db6 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -69,3 +69,4 @@ cxl_core-y += cxl_core_exports.o
>   KBUILD_CFLAGS := $(filter-out -Wmissing-prototypes -Wmissing-declarations, $(KBUILD_CFLAGS))
>   
>   obj-m += test/
> +obj-m += type2/
> diff --git a/tools/testing/cxl/type2/Kbuild b/tools/testing/cxl/type2/Kbuild
> new file mode 100644
> index 000000000000..a96ad4d64924
> --- /dev/null
> +++ b/tools/testing/cxl/type2/Kbuild
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-m += pci_type2.o
> +
> +cxl_pci_type2-y := cxl_pci_type2.o
> +
> +KBUILD_CFLAGS := $(filter-out -Wmissing-prototypes -Wmissing-declarations, $(KBUILD_CFLAGS))
> diff --git a/tools/testing/cxl/type2/pci_type2.c b/tools/testing/cxl/type2/pci_type2.c
> new file mode 100644
> index 000000000000..863ce7dc28ef
> --- /dev/null
> +++ b/tools/testing/cxl/type2/pci_type2.c
> @@ -0,0 +1,80 @@
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/cxl.h>
> +#include <linux/cxlpci.h>
> +#include <linux/cxlmem.h>
> +
> +struct cxl_dev_state *cxlds;
> +
> +#define CXL_TYPE2_MEM_SIZE   (1024*1024*256)
> +
> +static int type2_pci_probe(struct pci_dev *pci_dev,
> +			   const struct pci_device_id *entry)
> +
> +{
> +	u16 dvsec;
> +
> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
> +
> +	if (!dvsec) {
> +		pci_info(pci_dev, "No CXL capability (vendor: %x\n", pci_dev->vendor);
> +		return 0;
> +	} else {
> +		pci_info(pci_dev, "CXL CXL_DVSEC_PCIE_DEVICE capability found");
> +	}
> +
> +	cxlds = cxl_accel_state_create(&pci_dev->dev);
> +	if (IS_ERR(cxlds))
> +		return PTR_ERR(cxlds);
> +
> +	pci_info(pci_dev, "Initializing cxlds...");
> +	cxlds->cxl_dvsec = dvsec;
> +	cxlds->serial = pci_dev->dev.id;
> +
> +	/* Should not this be based on DVSEC range size registers */
> +	cxlds->dpa_res = DEFINE_RES_MEM(0, CXL_TYPE2_MEM_SIZE);
> +	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, CXL_TYPE2_MEM_SIZE, "ram");
> +
> +	return 0;
> +}
> +
> +static void type2_pci_remove(struct pci_dev *pci_dev)
> +{
> +
> +}
> +
> +/* PCI device ID table */
> +static const struct pci_device_id type2_pci_table[] = {
> +	{PCI_DEVICE(PCI_VENDOR_ID_AMD, 0xbabe)},
> +	{0}                     /* end of list */
> +};
> +
> +static struct pci_driver type2_pci_driver = {
> +	.name           = KBUILD_MODNAME,
> +	.id_table       = type2_pci_table,
> +	.probe          = type2_pci_probe,
> +	.remove         = type2_pci_remove,
> +};
> +
> +static int __init type2_cxl_init(void)
> +{
> +	int rc;
> +
> +	rc = pci_register_driver(&type2_pci_driver);
> +
> +	return rc;
> +}
> +
> +static void __exit type2_cxl_exit(void)
> +{
> +	pci_unregister_driver(&type2_pci_driver);
> +}
> +
> +module_init(type2_cxl_init);
> +module_exit(type2_cxl_exit);
> +
> +MODULE_AUTHOR("Alejadro Lucero <alucerop@amd.com>");
> +MODULE_DESCRIPTION("CXL Type2 device support, driver test");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CXL);
> +MODULE_DEVICE_TABLE(pci, type2_pci_table);
