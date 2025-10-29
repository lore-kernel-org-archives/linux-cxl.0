Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010071.outbound.protection.outlook.com [52.101.193.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66A62376FD
	for <linux-cxl@vger.kernel.org>; Wed, 29 Oct 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754669; cv=fail; b=E2M3BAlM5sixZFf/qG8Z22syVYUiC25Uv/+N8II3aGmwpEglprfqJIvz1grlZuz2yjArl38ssxGdTAKw+BNXlzhreGB05lZKH4NEpM1lH0Nc9HLJWX7tssK5bIdJdGC7dKOedME0VihAz7HGFI1VMAck+MHUB0Q62HdlB2RVI64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754669; c=relaxed/simple;
	bh=1OP2G3wbLUsBwp9F73erEepCwSOtd+iXxJLacQflt44=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HkSw9gDG5tHpcUEt7QKemIRCaEsbCGSZT/CwmmKC0g+TbQBl25+W9c1iW/GEtr02YyUY/xyX6MSaWraNhb0HHgic4TlcNy4lLBQCyLDX6uT2nHtGwyAcXD8jcmmBbtx0yJlLhDZQGjBF0jVHY5a8kHjF+bspOQQ1ip2nz9Ir90U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gz6L0uOo; arc=fail smtp.client-ip=52.101.193.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gz6L0uOo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGctaJgerhdhV1clyW15F7ovqHEjEmW8e78apORPhRI+b86MdZWN6Au6MA1wP5uFd5hQZVaPXJFZTToQd+J2dzJI5ARqAgFmnsn75EQ6VGnvY3ZPfRyc/i/LmgJa43TCjyBzb2I0Rug7TGJRElHybtv5ZFdVE7PRobCulYdA2thaqqJ5yMQadqCN7/5KZyl8M3wCsFdYxX8NOfZPkAFJg9G8V1ctgCwjAsCXn1zuDF9r+0IJzAME5TsLawjb4RN60V6Q1XxAR2GNjBQLwQkFTsYYJUlfD4mLDzugSSQmraErS3ERV2mllIMKQdiPaOAa5k4tban2XhSWVe0+Ci6amA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLT1nLbZ7h1dY8FG4Gw0vAfk+FHJ0qV3aOiAZJM/cDw=;
 b=qGiizAiJxSwtApQqtDC97qLYFexma2AHEde160mZWIkZy3KOiEZlBu4EAcNLVal48BVKrKhXl6/ajycvY1dNVLRvqU/RCKB30TdikH60MkoTwg/dcC697aq4oOsTW8LfTVwh1eSIDVCKh9isX/ewzElfsZ+GXfCvCLMQayNElGmWK0bX9HbiFQYC/69Yvw56NRfxMLh132alXZ4gtxt4grJ/64CV9KFLTwOBaKDWrAhWPaC2JX798s3brzzjTddJ4SeMIchWaE+uMe2xQVmdGGstMqM3DMbDTuMGTgM+deYymHKxNB/ZQVUUwzZoLkGpgmeuk9GhpEp/BkXnotwFEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLT1nLbZ7h1dY8FG4Gw0vAfk+FHJ0qV3aOiAZJM/cDw=;
 b=Gz6L0uOofaH5qIwztkI2d4vcgMvb9P08qLWF6lWaMvRLA+jq0W9KWTjCMsHzICRiDiqlR27xy/jHqmQzy8Brgmrkjg8nt8KLHqLeiVXI4SJzZ+EkdRiwPAWSO41KfKwjyUFZLj6zHSHi3uXP4gL2+XmClGk8katXfNpYxcI4lhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 16:17:44 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%6]) with mapi id 15.20.9253.011; Wed, 29 Oct 2025
 16:17:44 +0000
Message-ID: <0884302f-8713-4d97-9a08-56091985a5d1@amd.com>
Date: Wed, 29 Oct 2025 16:17:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Add handling of locked CXL decoder
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20251021205055.2081800-1-dave.jiang@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251021205055.2081800-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P251CA0014.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::17) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|BY5PR12MB4241:EE_
X-MS-Office365-Filtering-Correlation-Id: 141fbddf-9f52-4719-de97-08de1706b104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3huTmU3OHpTRldCdnB2aU13Q3NpQlIzaExVenlacUwzN1R6c01nRDg3TG4v?=
 =?utf-8?B?blNRWVBHbXprTjY5aEFzM2hucE42NUh0MnYrVUZmVUJaZVFnS0dMREtOallT?=
 =?utf-8?B?d01hajNVTWVyaTRJWEdlQVlaaklMQWo1bTV0QkhFY0swSW9mQ2NWWkZvVTk1?=
 =?utf-8?B?WGxSK2tLUmtUaSszVFFsR1BJSW5qbFBXS25nZFA0cnlSMVh0YW1QQ2JVODFk?=
 =?utf-8?B?TWNkQ2E1OHRWMEtzRjA1UTVJN2VuRWtITVIyNFg1TzBtQ0Zxc2pqR3RsZm5O?=
 =?utf-8?B?aXhhcHZVRVkwYzRpVCsvdm5DbzU1ZVdyZXVxdzZMYVRRNXVKOFRPOEloQ00x?=
 =?utf-8?B?T3JaK0ExSFdaeXZYQzNxL3B1OVlCVnB0blNEMzFERzdMS2hpZlYzc2RMVU1r?=
 =?utf-8?B?alNqL29sYzZrdkNqVDlSclJvVHcxK0ZlaVVBbW82Ulg5RWJhWnlYOFczUHhM?=
 =?utf-8?B?MEhSRkcrMmNvMDFKVjBHODBzQUdMZDNwcUF0bEdyVWRoZTAzNXBIWUdDVzh3?=
 =?utf-8?B?dVBYaGJCZ0grZUZ2MS83T2s4MFpkUTlzR0NnMC80V0JTdkN2Z1dueUtUNkdF?=
 =?utf-8?B?dTNDSGJmdDArWjZkTkMwdXFiWDNVSnRnaXlLRDU1NWVuYXRnZTM0MGFiUEps?=
 =?utf-8?B?bE5VYzNPeVcwQU9MZWNqVWJ6SllUenhUdmJNQnJ5SFhuMTArNzlXVkI2eEtY?=
 =?utf-8?B?cFpUcDIrVzRhWEU1N2NtVzh0MUFHMFJEVDBjOFlNeGptSWJTc0g3bXlQaUF6?=
 =?utf-8?B?TjFrRHdFTFhPTXFiSll2OWY1ZVpyRGVGVkpiZzRWd0xvZUZUcnZSdWpDT1FD?=
 =?utf-8?B?L0xaTzRseXFOSVU5eGxQVytoVjJHVjNGTnQ5K29GNDJoVkdIT2o1ei9TTzh1?=
 =?utf-8?B?NzhTUWJpa3dhNlcyK3pXeVpFeUQ0ck0vK1dhcFhseTAveFFWdnpUVTBNOURQ?=
 =?utf-8?B?bUsvbFdqY1QyUnJkUUhvV01DQ2lUYVVCQWhROXIxbUdXaVhPQXFxUGFrbDN5?=
 =?utf-8?B?VEIvemFTN0orK3NDSFVOWlZ5NUlCREdIcmljS3k4MGtjSHY3MHJuS01lRGtv?=
 =?utf-8?B?YkhrV0ttbTMwd2hmWlpkcjZReUphU2FPN3N2Y3ozRmFibm9WVDhvYTh3Z1py?=
 =?utf-8?B?MUlvc2pUcmNyKzZ4eVI2enRVcXJpampwa3pUL0lQa0Z3Ri9lZHppVDFCYjZw?=
 =?utf-8?B?OEhHTVRrWjZWUVI0VHNNcHE0UTZrQ0JKRER6SUM4WEhNWWloS2xkSCtJcms1?=
 =?utf-8?B?UUMzZUlmZnl5WXZ5ZTFiTDNTelFmVm9wWXprbm9Kc1R4Q1ZWWklJUmJTM0Vz?=
 =?utf-8?B?bW1EN3JlS2I2Tml2THNjQjg5N05pMlhFWkNuVzRTR1dIakJXL1pCUDlnaERP?=
 =?utf-8?B?Y1YyY1owRmttSjdUNS9sZjdzbnhZcTB0UGtUSURrc2dBWE84RzJ0WGlRd2ZU?=
 =?utf-8?B?NjNUUm9SK1dFYkw1U1JlUFlRVitjYkRUVVNaU2VjcTYwdXd3bGk3b1dBeGl6?=
 =?utf-8?B?QTMzUGVERHdGcmJJR1VpL3p1NzlKRnhwQ1FocWpESFpOKzlneUhEZkc3eXY3?=
 =?utf-8?B?YTZKU1FzZ2t1aDJQYVoyT0tNS1ZIdzVWaGx3RjdHT1pKUDJzQlBoWTRmZkk0?=
 =?utf-8?B?YmlFU2UvMnVFU3VzRUtyWm1JQTQ5b2RQeElwRTFtb0xQeVdxcC9vdEFVc2NC?=
 =?utf-8?B?YTk5KzdVT2dxcUYrQitFSE9MZDZLcHdTWGJNbktwMG82Vkp3REhnbVlrcFMx?=
 =?utf-8?B?NU9XVDc2cHJCbllQT2lrejUyZlpxUlhweUtyUFVXK0NzbGp5QUNmaU1lK1Jv?=
 =?utf-8?B?VWU2UFNqU3hCUitXNmJkbG1PSE9GK0l5RkNUMjVRVTZkMnlGVnRZYkhqZ1Vl?=
 =?utf-8?B?cjd4elJ5NmtCZDVKaldDQ2VBTUR5eVhWVFF4VG5HcFAzelFYZCtvc2s2d2Z1?=
 =?utf-8?Q?UgkPtukA66lS6QS/meXH3CqMWvunWxji?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUZ4VFVYWU1wM09hMHpHU3JCZTE5MlRpaEpIaVpqTk5JNnJ6OUNOaEcrVXJk?=
 =?utf-8?B?RzgwRVBkWGVXQmQ3YmpZV1k4TjVPVFpXd2tMaGI5MldiN2V5WHkrTlB3Y25t?=
 =?utf-8?B?MnJ3aWpuN3BPaFNTQUFkYTlsakRhRzZhSlF1T2NkWjZWTXVNNmNtWCtCdzZt?=
 =?utf-8?B?RGNoekZxbTdJZW9qUG1LZEtZWURpMXZEdnN2T25PUXdvTEluQ0lKWmREQkdz?=
 =?utf-8?B?VkxoL25lVVNiUmJ6ZE9yQ1hRT3Z3OU1zVk9hWjI0bHhCYWsyL1lTczVLZWtw?=
 =?utf-8?B?dExENVhjam5ERTVxR3dhNFEwZWt3RCtkeEkzN1lOYXRhRlBHRjh6QWQycGNK?=
 =?utf-8?B?bzNpV2hjb0RKa09qbFlpTGZjNmZuaHJ6aUhiaWVxcWEra2dMMDdwWVhEOUw2?=
 =?utf-8?B?RG9keUZ5VnlCY3MwQXpEMnJtU1RwSzY3WmtGeXZwbmMxN1d5djZCOFQzaGpq?=
 =?utf-8?B?R25Ha0U3NDhRTERqaDYxazRRakI0bFc2ekFjbHlBa3RMVVJMR1hnZFRZa0ZM?=
 =?utf-8?B?bFd4YmgzaXlTdmRYNTdZeXZNajYweFVLSGN4OWNLT09UNnlqd2ZQNVhrOXpM?=
 =?utf-8?B?UC82WDFwODBQVzBGUDNMSzVZc010M3BLeWxvM3BhVks4bHBuQTY3ZUZnYnc0?=
 =?utf-8?B?SVhnM3BsRldvK3FnWlplVHFKRnoyZmFJSi81aWlUaDRYek5VZkxrcmVOUXVU?=
 =?utf-8?B?WmR3U1hvM0pnNllYUE1sbmwySkdMN2tOOXdibGk3YmJ0R1QrckpKTVp6Uy9a?=
 =?utf-8?B?emNxeWRMQVVZNkZicHNxczYzMVgrZ1E4ODZ3WjE0YkR1RldsN0NmWmlVVHhU?=
 =?utf-8?B?RHo0WFFnZHBZWllDZk0zTTA0T0owaThOcG1JTlFoSi9PR093NkFHZ1Vhb21r?=
 =?utf-8?B?WXhab3dPWWdNdnZKcmtFYWxBNzNMQk51aGh6eDE3ZE1naE1ObHNaQkNqVStS?=
 =?utf-8?B?Z0Q4TlhiUUFESEF4NnR4VlloalZZbVVCK3NsUFpiT3lwalRncVJDVnlxUGNF?=
 =?utf-8?B?WXhMNGg4c3d6NElCTmZicU91M3o2bnZYM2dsa0s1VHpJUHV2dHFVeitGRDZa?=
 =?utf-8?B?V0M5QUd6eENwUHZ1ZEJRSkcrUnF1bHBiY213aW5ybGdyM2F5Y21mQi9id1hS?=
 =?utf-8?B?MnI0NmxsNVQzeXhqZVA4bUVVbzRIekNkRzVVYlJIcVA4NW5ic1c3WmtkWEhj?=
 =?utf-8?B?RElybElmN0d1MVI0NVUzdWc3TFJsRGpBc3VuNWNaN3EzbTJvSmk1ZHVYR3Yz?=
 =?utf-8?B?UmNnTEZIeUw5QVZyNDJFUmh5TWhrdmJtRWd4L1dEcjJ2SmEzMVczOW01eWxG?=
 =?utf-8?B?ZVJNQUFPdExmY2pOQW1xM2tkWUIzbU5xUW5MNXdEcndBaXZ5SGgzZ1ArTkFP?=
 =?utf-8?B?TXFtWEhaUmVTYzVrQjNpTllCS1FmNnZYd1REYUN2Rk9EY2Z1OHdnSTRLYXIy?=
 =?utf-8?B?ditZWTh1K3pKSUUwb2x2dkRXTkFGcGdlSnhnOU9ab0YwelR2M1Y1THc0YmJH?=
 =?utf-8?B?Z2pTcFNqZXpFcTVxRHBQS2cvRGJxbkhQZVpmMTdLcS95S041cmFVbHJaWVhB?=
 =?utf-8?B?WEdkZXdoSnl4Sld4MkpRRDhPdkJYUjhuT0VCL0RENHIrVElFa0ordkQzUVQ3?=
 =?utf-8?B?NzA4cVdKV3V5bmZJc1kvVjlRY0cxL2JINWF3eFVtTWo1MllkdDVlRVZvVDFp?=
 =?utf-8?B?UVJwTm9NUUIyY2FteHpvU24vQ3VHRzRNcE50T0xRRURndE1DeGM4cWpRcHhO?=
 =?utf-8?B?dzNUYnR3bm9JOTR3ZExwQ2FPWWwvVFU4NDlZYmdkVlZpS1NFcTRiU2gveWtK?=
 =?utf-8?B?cmFyNVJSM1M5dUg4MCtibTBrenFkckFqMGwrRDJPdzF6QUJhY2daTSt3MjVZ?=
 =?utf-8?B?RUNFRzhBekxydDNBQ3hlSklOR2VYczFKTU9PRzNLM3ZPcWsvYlByb0tTdFdX?=
 =?utf-8?B?WndXODZMWnBCT0lGVzBoUFZOdUIvSEp3UG5jMmZBN3M3UkVBc0NPdVhRRXFE?=
 =?utf-8?B?U3ozalpVckdGVG9IUVFWeXBIMGN5YVNGS05kWUUzekMvbEpMakRlNjlWdUR5?=
 =?utf-8?B?NVJZcGxQWFZGdGlwWlBRVWM4NHlkMVZDcXZhZHBxdlB2ZzU2akVxVjNXRlE3?=
 =?utf-8?Q?3S11Hv8w7kVeGNXiOpqvYE19t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141fbddf-9f52-4719-de97-08de1706b104
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:17:44.2907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMNfkabu0MlnsqAlfG8KvIXtPH3Xz23+LyH8wl9HTnYax27jXDpo4DlAsldxh01+Q2Vi/59wAkDNLZ3uS+IIAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4241


On 10/21/25 21:50, Dave Jiang wrote:
> When a decoder is locked, it means that its configuration cannot be
> changed. CXL spec r3.2 8.2.4.20.13 discusses the details regarding
> locked decoders. Locking happens when bit 8 of the decoder control
> register is set and then the decoder is committed afterwards (CXL
> spec r3.2 8.2.4.20.7).
>
> Given that the driver creates a virtual decoder for each CFMWS, the
> Fixed Device Configuration (bit 4) of the Window Restriction field is
> considered as locking for the virtual decoder by the driver.
>
> The current driver code disregards the locked status and a region can
> be destroyed regardless of the locking state.
>
> Add a region flag to indicate the region is in a locked configuration.
> The driver will considered a region locked if the CFMWS or any decoder
> is configured as locked. The consideration is all or nothing regarding
> the locked state. It is reasonable to determine the region "locked"
> status while the region is being assembled based on the decoders.
>
> Add a check in region commit_store() to intercept when a 0 is written
> to the commit sysfs attribute in order to prevent the destruction of a
> region when in locked state. This should be the only entry point from user
> space to destroy a region.
>
> Add a check is added to cxl_decoder_reset() to prevent resetting a locked
> decoder within the kernel driver.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/hdm.c    |  3 +++
>   drivers/cxl/core/region.c | 16 ++++++++++++++++
>   drivers/cxl/cxl.h         |  8 ++++++++
>   3 files changed, 27 insertions(+)
>
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d3a094ca01ad..1c5d2022c87a 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -905,6 +905,9 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>   	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
>   		return;
>   
> +	if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags))
> +		return;
> +


This is correct, but is it enough?


Would not the region teardown imply also the reset of those decoders in 
the path from the root port? Can we assume those will also be locked or 
should we add some sanity checking here?


>   	if (port->commit_end == id)
>   		cxl_port_commit_reap(cxld);
>   	else
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b06fee1978ba..8647eff4fb78 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -419,6 +419,9 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
>   		return len;
>   	}
>   
> +	if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
> +		return -EPERM;
> +
>   	rc = queue_reset(cxlr);
>   	if (rc)
>   		return rc;
> @@ -1059,6 +1062,16 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>   	return 0;
>   }
>   
> +static void cxl_region_set_lock(struct cxl_region *cxlr,
> +				struct cxl_decoder *cxld)
> +{
> +	if (!test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
> +		return;
> +
> +	set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
> +	clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
> +}
> +
>   /**
>    * cxl_port_attach_region() - track a region's interest in a port by endpoint
>    * @port: port to add a new region reference 'struct cxl_region_ref'
> @@ -1170,6 +1183,8 @@ static int cxl_port_attach_region(struct cxl_port *port,
>   		}
>   	}
>   
> +	cxl_region_set_lock(cxlr, cxld);
> +
>   	rc = cxl_rr_ep_add(cxl_rr, cxled);
>   	if (rc) {
>   		dev_dbg(&cxlr->dev,
> @@ -2439,6 +2454,7 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
>   	dev->bus = &cxl_bus_type;
>   	dev->type = &cxl_region_type;
>   	cxlr->id = id;
> +	cxl_region_set_lock(cxlr, &cxlrd->cxlsd.cxld);
>   
>   	return cxlr;
>   }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 231ddccf8977..6382f1983865 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -517,6 +517,14 @@ enum cxl_partition_mode {
>    */
>   #define CXL_REGION_F_NEEDS_RESET 1
>   
> +/*
> + * Indicate whether this region is locked due to 1 or more decoders that have
> + * been locked. The approach of all or nothing is taken with regard to the
> + * locked attribute. CXL_REGION_F_NEEDS_RESET should not be set if this flag is
> + * set.
> + */
> +#define CXL_REGION_F_LOCK 2
> +
>   /**
>    * struct cxl_region - CXL region
>    * @dev: This region's device
>
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
