Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793384901;
	b=10A550HcI3HpL5ip2uHMWJwqhEVdLjpXKkZTpGjLTiviCc8WnadyaYTZazSJCHwgnQr6
	 kC67TEuXHQv0N3t0mZWk5g1hmZ+tvN3DGBsHv685zpgoaCJH5VAULNtwubOQzyOkyrZok
	 MaCBSE9BAFqGnuBP1zxv6qvgjstNR9QwUdjuBHZUFZvxsNpPPAKIu22qPIOoln+9wWU0x
	 E2kw3PlXrtmK8LMsBRGaElNSZipepx/YSJg7A2bDD6ZRDzeV7im2zhlW18P381hvhsCVI
	 52+FJJBAG56yxR/Ul2wBs9eMQYVW3hjxL86j3wPGLtn59OhE0/toD7mIqqTfgVKwmfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384901;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=wFJT4m+a0FrcqjUIwMzo95HoUdRKMTr7y0Qp0cmc1lA=;
	b=nJlTc7ZSJt1IaB04pZHuOZD2USzOHFXQmQBAgGx21AVbkIgIS2CujKp+E09X+PWtr9yl
	 gq6EWOWzCPOMUxtxxgU7YpMLDZ6rtQHSPg8Ny1dY0a1H+scAgS+f0yCG7zmRAUWnHd18J
	 VM/EYMuDMh2Ih75S5ErvFOdUQhDYwwhUIILG7jfky/5VmX6ZibZqfT7gCyMtw7vnjBNlb
	 u4k4AA7Maj+RCcGcF4UmxYTlUQfpMilgnsPUZZGsKZvMR1nJyfY3oTkfuSCoVI5Q37OGv
	 L4VQgf1TfuHOd4Av1TzWf5+M3FpoRcLigRNy2q1Ya+k0pAS/pdoZdnlc4/uMApQkYsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zeKuCgWe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.12
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012012.outbound.protection.outlook.com [40.107.200.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3D8606A31A;
	Fri, 30 Oct 2026 18:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F3D8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zeKuCgWe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEr8CXVICLqC4K+8xR+KhshdCdqZ+eLtYSsqtOllNqB+hn7EYt/ZGn4CYpaB5PDN5xoD16TabwsNuzB6hSgjt7jqkldW0m359MfHEJaA91EFmMHUtuY8PK9ABIk5hH/w6czUhGImF66gw5dDdXcaUMkP333HEe9+hCFhHY9mxRNd5PzIMSBgC5WtMYl2RNzLqFA1ofuZ/UaTNzzhNJqG02gRFrBU2xlbIV90SMrDphHnUbmTMJhoDkg1W/XFOZVF/GASSGsTAp81T4+GQm9b5XVg1zB+i9Og2umvGpgRI0adEyHJfdC+/3WS70uaogYQKwl8QQHu4d/DZTyuNuT5Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFJT4m+a0FrcqjUIwMzo95HoUdRKMTr7y0Qp0cmc1lA=;
 b=blVmYtRc9e0YSz644qLeCLK/zVWJVf3uysBP2jB+M0JfpiZFTl3sgPEfr4Js9nFpJgQiHsbSp/ZKgYS1auiiSdvOeUG9MibIYZq4+zdfeloOXc5Uz5XmCZNyXBMBhrAdrPLTfoKnBYIZaQstdn/wH2OKPhbgrJbkxnLnMtva4Rr3eg/PB7gS5EoQlWiU0mBJI9GEyCSNqKUa/v47K3tI/Yb5QncOuUfQBKZvIkT7HKVTxj+nVehogAIq3JlKH1hNTD9qX23Hxi8Z1dQBgm2/EPy7O1n69/ElNUznYs3VopDOVAZ1U06Wl/eSglFbiY3g4EhC59f78tcugs4P7y5TGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFJT4m+a0FrcqjUIwMzo95HoUdRKMTr7y0Qp0cmc1lA=;
 b=zeKuCgWeNd+2+AkNsJ92EkrryROGVyxxq06l4cGf4YkTdFD3L8Psi145UEXuZkH1xGPQd5SJKGKmrqQct9Aq3jtvhsDBRxIVN0dmPzDJct9vb7KRM91e9aCozaxS1o5m08ngAFHa4vOxORsd43QKIAJNCfN9HlH+GGzxX2zCrCc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by IA0PPF864563BFB.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 18:28:17 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 18:28:17 +0000
Message-ID: <83a62ebc-78b6-4442-a097-566b4a2704a9@amd.com>
Date: Fri, 30 Oct 2026 13:28:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/port: Unmask AER internal errors for VH endpoints
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, kaihengf@nvidia.com, kobak@nvidia.com,
 newtonl@nvidia.com, kristinc@nvidia.com
References: <20261030095951.46080-1-icheng@nvidia.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20261030095951.46080-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0206.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::31) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|IA0PPF864563BFB:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb28ab3-2dde-4ced-5575-08df36b3912b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|260925022911599003|260925021911599003|260925021311599003|11063799006|3023799007|6133799003|261028144727099003|261009223027099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|56012099006|261026121527099003|261026140227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hqG/ZP8EzLIjz5uqtidf7wcwqJJWEHuownbBFxmKRY6cTJIMSyh9/kCeUn1EdL2zHwH9rpH1HiiTycNTnA6lPVm+3AN5fpSetB029bEzWJpFSVSScA0y67PakAYoM6OHMLYzme1QIQBCbuuACNXVfqcX0DD2pqGBjH6bUoBwZIDrsN6kSpEn5IlQ4BdLh+jZmz/lj+grMqs8s6KNfTSWBY9/P9nQHo7e8P2+w57i7ZHXW3A5rQWh20IP5hgolKF6FhHqX5Z3DZRYo1awwdyivVLJWYDM1eWUZvlk9Xv5RH/jrQVIv66IFCVb/xTqH436AJFDb4SX50AGsK/8NaRKMdYRDhu37lShZ85TzYaMnrbyNMlYNR9JcAunR3j0Eg7eeqp0qBBaGtOG2NcpxDltIbheeZ4KWY94M/eIkM49bHI7OL6zIPxvDE+I9TBlGt9bTdfQixg9XlngY8ujzFRG3ApuxzpYJhVZQ5HYY6JQQckwuFq/MdCAzdIidzSV8Kh98Pac4xohX4/cBIuvnIfVX/6EL3hFQaijLEwWagCFUHA2ptGRgepz8TIfQPMljH/yBZbk/TD2GHBDoy8zR4oXtkP9kexjvWtUXmWsY6wTAiMqLakjPOG393jX14SOtSNVlcJ3WqPpRCfKPkkDywxk9KMlIxWSPfbI0IdjJyNt0WY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(3023799007)(6133799003)(261028144727099003)(261009223027099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(56012099006)(261026121527099003)(261026140227099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3dVbjZjVlFHN093ay9sMFVwendhODJZbUZqcjRMRDR0d2FIYUVybFFrb2hp?=
 =?utf-8?B?cUFCTWR5czJZVjM1dkJzOFNwcFErUnJCUDZWM3Yvd051RHpwS2FZTDFnTy9o?=
 =?utf-8?B?WngyVUVJYlE5MVdvR1drcjA1eDV5ZnlZUW82bjAzampUbzBoR0JYWUxaWVpU?=
 =?utf-8?B?ZE8zdld3VWJlTTY4SGIvUkl1aW9LT0NzTDNlR3pnUGtMMDl4MzJMelFTcktE?=
 =?utf-8?B?OVV2b0IzalVtN251WHlFeFlTUWxIWWJiQ2V3ZFdFb01TbTZXT1FhRlBkQ0ZN?=
 =?utf-8?B?VkJ3QTlDSkFISmJTdFUzRWlIWEdmaTVLM0xEeHJwa1BBMVQ3VW1OZkV3ZEF5?=
 =?utf-8?B?YlhhVHpFemV1cnl1MmhJTnY0VWlCb2V4cGg0MDhLaWhHM21GWTB2UHJRUk1m?=
 =?utf-8?B?ckVCL3ZjRTllbVd6QXgvOXZjT3Zwb3pyN3F6NzR6VFE2NGxTR3h1QTAxZW9V?=
 =?utf-8?B?bkxRU253NjE0eExKcHJPQTQ2bDJrbW1UdENPRklmd0hBcXd6MUhkS1hmNnVU?=
 =?utf-8?B?WWVVYVVpWVNaV2tpdlpzd3JVWkZVNUFXcnlVa0p2b3VPMkVDUmxwZ2x1THJY?=
 =?utf-8?B?dkpyWENjNDZ1RkhET3pJQTR5eVBuSVFDRGd2dzB6TkdWR0NRaWhKWDZwTG4z?=
 =?utf-8?B?cDdJbDBHZmFnQUZ4ODVVQUZJODdRekhZWGdqWDdya21YU2prNGpGRFZLK1A4?=
 =?utf-8?B?VVpNMlppd1N0NWZRcDM2cHNVOWFxbkhZZ3dweWo2UldqanV4d01LcU5yZTQv?=
 =?utf-8?B?STZYZTVGaWdTVUk1K0FBbjhzaUIyb3JwVExaU0kxMjFKSG9PaWQ2WTNpSDhG?=
 =?utf-8?B?SjdFVzFVdVlnbE4rRjFpajlEakpkRUU0L1k0TDFqTnZBdWxsYVltWVVwQnNI?=
 =?utf-8?B?REFKTGhRcXZ6VnptbThhb09Dd1V4U1ZVVmx2R2xQRXVWaTVNUEJ3UWNJN0tO?=
 =?utf-8?B?VjhTem81bWVkQ0lUNzEydGpzRzFYWnZKS0F5OWFMTE5NMXRrWGFQYjRlVDho?=
 =?utf-8?B?Zkt0WmRmZTlTNy9LcGNsa0RvZ05rVFFJK00xY3M0eUUvVnNaalJiUlRDVnpZ?=
 =?utf-8?B?UWxoNDU1YXUzbWRRZlhHYlRSNkRvalZKQVpwakF0RDk0a2MzV1ZDb0NZZVc3?=
 =?utf-8?B?ZFVOTjYvNCt3dmVXVk80aUhKalZHTDlpeDNhd3JSRm9hZENtZDh3RDErbXF4?=
 =?utf-8?B?MURsZ1J2amtzenJqeC9DVGUyM1grbjZNenVLeVZ2ZlpXanQ2RTNESmxHMzVy?=
 =?utf-8?B?TDZzY1A0YTBiLzZDbXpFNkUxSnVjQ0ZXeXdIelgxY0t1aVNJVEM2YTByQTJr?=
 =?utf-8?B?T1NRQUZRL3FCNmhvTlllRVR2VWJoSjRDMUhTYVJMZlNWWkZmMk9SZ1NqdWlY?=
 =?utf-8?B?emYwb2gyL0V0REdOdVU5T3NuM0JOdFhTQ08vWm4wTjNPNzl6eG9JS3FYWDA3?=
 =?utf-8?B?dWl2TUwvVmF0TXprWFVmZ2lVektwSnRRR2VJVWRncHBDK1Eva1RYMEpVaDVP?=
 =?utf-8?B?cUN3UzZzTWdkZ3dDUDErVVdKYmRuNURhbnpyMjg4V21jeW01Vm1zU3l1ZW8y?=
 =?utf-8?B?UkxIelpESFlEMFhTeWhqWEZSdnRPeklwQ2xhRWhXemo1VDFwNXhwcDlieG9o?=
 =?utf-8?B?TlovbTJqM0ZjdUVqY2kxVG03QjB0V1ZwT0RmYlJoZmFFVmhINUtiMWNBakZO?=
 =?utf-8?B?cnhLZ2cyUzNWVW1LOThpaHRqRGVsR0VhOEVPZzlmNG9mK04yL2hZYWFuQ29E?=
 =?utf-8?B?NHdBdDBpUEtQTzZ4Rnh0K05hNUNtMVV5eFI0Z0ZMQTJLRTVZYlZvaEUxTjhY?=
 =?utf-8?B?ejkreEpMbXMvN1QyVTdEbmNJQzZTLytuMW5qa1ZSTHRGd3F3ajcvZEdmMVpq?=
 =?utf-8?B?M0VuMUVqWXVVTm83dnFBUWlFNW1YSWZVYlMzMXdoSVgvWE1uM2JYY0wvdDdR?=
 =?utf-8?B?WmdvY1BCKzhBOXRtdHowOExhS09IMlV5M0lRN0NOY2UvTDNYT2JTdk9JdGM4?=
 =?utf-8?B?RnYzVmhjTXZvQlBZOUM4NDdpaVJvbU9iRCszRk5iRFVhWDVycGhtRnc4anVB?=
 =?utf-8?B?YTRBZ3BQQzU1RUZyVlRvNTRhSkMvak05VnlUOEJLSmpCa3hrNExTVDBOZzQ4?=
 =?utf-8?B?RFNPTS8vKzFMM0FuNXl5bHF5M3FSKy9lQUJQWWRJVXpCTkNuSU1waXpWT0tH?=
 =?utf-8?B?T0h2V1FqdEdyYkpQM0ZpdStjN3o2bDdORjNWR2x6clhSc0F2ZXQzSnVqVUc5?=
 =?utf-8?B?Y0J4SnEwVysyZnYzSHNDVU0rWTE0QWdsSFdWWFZHNVV6QTNiQWhhN1JJSi9l?=
 =?utf-8?Q?2PMudktb4iwpu2Yt7a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb28ab3-2dde-4ced-5575-08df36b3912b
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 18:28:17.4212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXOjGl5e4aPVyX5U5WxwlqH75A9gJnvfYCVRL/hsYz+2jdfvieWWmVfA0ABF/5ybCRcpl3kwzIKQHQT1uHXYQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF864563BFB

On 10/30/2026 4:59 AM, Richard Cheng wrote:
> CXL protocol errors are reported through PCIe AER internal errors.
> Unmasking the endpoint's CXL RAS register alone leaves the AER internal
> errors masked, thus the notification can't reach the Root Port.
> 
> Unmask AER internal errors during native endpoint RAS setup for VH
> devices. Allow cxl_port to use pci_aer_unmask_internal_errors() through
> its module-restricted export.
> 
> Verified with QEMU mem-data-ecc injection: the Root Port AER interrupt
> fires, the CXL correctable-error trace is emitted, and the endpoint's
> CorrIntErr counter increments.
> 
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
>  drivers/cxl/port.c     | 7 +++++++
>  drivers/pci/pcie/aer.c | 3 ++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index c48216e5078f..c94a310061b0 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -121,6 +121,13 @@ static int cxl_ras_unmask(struct cxl_port *port)
>  			orig_val, val);
>  	}
>  
> +	/*
> +	 * RCH errors are reported by the RCEC. VH endpoints report CXL
> +	 * protocol errors as PCIe AER internal errors.
> +	 */
> +	if (!is_cxl_restricted(pdev))
> +		pci_aer_unmask_internal_errors(pdev);
> +
>  	return 0;
>  }
>  

Hi Richard,

The unmasking needs to cover the RCD case as well. The RCD AER is used to mask reporting. 
The is_cxl_restricted() gate should be removed so the pci_aer_unmask_internal_errors() 
is called for both the VH and RCD cases.

I confirmed Sashiko's finding that the unmasking will never execute, thanks to this early
return:
        if (!dev_is_pci(port->uport_dev))    <<== Fails here
                return 0;
        pdev = to_pci_dev(port->uport_dev);

For an endpoint port, port->uport_dev is the cxl_memdev, not a PCI device. So dev_is_pci() 
is false and we return early. The PCI device is `port->uport_dev->parent`.

Note, I used base v7.3-rc7. I couldn't find f0c48323b040.

- Terry

> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index db4f607f889c..94eca22422b7 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1287,7 +1287,8 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>   * Internal errors are too device-specific to enable generally, however for CXL
>   * their behavior is standardized for conveying CXL protocol errors.
>   */
> -EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
> +EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors,
> +			  "cxl_core,cxl_port");
>  
>  #ifdef CONFIG_CXL_RAS
>  bool is_aer_internal_error(struct aer_err_info *info)
> 
> base-commit: f0c48323b0402349530abc60ea908b5f5f40c395

