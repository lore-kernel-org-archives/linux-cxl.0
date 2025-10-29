Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010060.outbound.protection.outlook.com [52.101.193.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E6C26B0B7;
	Wed, 29 Oct 2025 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756276; cv=fail; b=r4DKMwNrh1UdD2nXDoovXiKWBFjS/2ykAOgJs81GNsgusKMdmWRdpQo6exKH4sd4yrthNC5FXUD2ptPx3rA1L/GKL3U7hiKwK5bIxTsDBC1fzgsl2WkL/THF9hRzyjDZQQKoH+rVp3SaA3N1iY0mOxypeqgse4OILo0CN8Mnsw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756276; c=relaxed/simple;
	bh=/9MT2qYFIDitynCV3l/llgsYRFWmrMpd3e2W3baZFX4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vCP9aYhxFTXdNNrTbBLdRoAyUZO9f4SczmtqLsJxQbZCSaxYjOUZoioXqtLUB8LwM+JG19oEeK16Ex1CQNoKbR8XzKdaLSw/42mqvbLklZGbLKFLghrUFbhNHjTZOXCv7aqH66I0bIwHFCI9eD+/G2h2OQSWJEEr3xkTSf971zM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z40VlKWx; arc=fail smtp.client-ip=52.101.193.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z40VlKWx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muz/86we+YspLsdqPDIh+Zc6UuX4vWG/bw6y1ETWeYdPgwlkwuMX/sG/kW0NGjnzGAwfX4jgOS/iEhvK3W+fQlptzAiO+S7wc8atBTPjytCWgYH3qOM+rBYnmlQD4k2AIr2nayr3V6xYeRmQ5ekPkDBgPmkc5cB5ilncx8AcTAmHEtZI5+ukZ6qQ/Ux1amueR/xQwfj3kk9qU4A0emlVSbSsd15nwtsxT8psjrCDD01IJttnDwlm8SDOkuQAJAGo8t+GBret9EAonSRhie2JytQDBiskdE5VnoG7X0Q7FHh/F+lIbdYZmcycVJs++I/W4lFEexOJJZ0dpjpIHHaMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwxccqiyt2q2/DlvmEZMXK7zGPT7Alx7W5o9gH4PWVo=;
 b=UCb7i1TP0ZS0Ge9aZvfI4SsfnpKhzZmSQ5iept2m8JVa05AKbbZxCpU1y9sbsLwgFm0BAUl3VY/mFm5GWu8+jo267qzBqYlPPshwWdBKxq47v2rPeYJKvHqfwYu0PTwX2hJ8Ql6s6xBqoZykmdzytccUvf9+GX7qa9OFHjBjzpAuddxF+sJt4s6WcSlSGWW/BtpJuHSqYQRtHadr+l9Ar6Fazn2Ef1MMjERpdSw8APGPhGwEEhfdIptXOx8/N40iCpyKoxJJtEeDiNR+TDGBIa3dpL5RcD3K+vFKfV5xBkynsqizWCPeOYzAg+cdcm8JUfLNUiuVQP5NRy+ZR8n95Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwxccqiyt2q2/DlvmEZMXK7zGPT7Alx7W5o9gH4PWVo=;
 b=Z40VlKWxkYAtRopnRDTBiYxTr9njP4ku1vXubWyjZw3Uq9rQNwFa2WtRw752kpL4472VMJl9oZMIP7GD0dxUPqJaygV+rgVUuqcJkUWzZIKthrxhg2Dv3SSyrFQ+ydedo3St+D3NtMXfveHM8F8d7+IycLesoHTiq/mCl0bQ50s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 16:44:31 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%6]) with mapi id 15.20.9253.011; Wed, 29 Oct 2025
 16:44:31 +0000
Message-ID: <1428d9ae-0427-4f3d-b3fa-41ee030b805d@amd.com>
Date: Wed, 29 Oct 2025 16:44:26 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Support multi-level interleaving with smaller
 granularities for lower levels
Content-Language: en-US
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>, Terry Bowman <terry.bowman@amd.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20251028094754.72816-1-rrichter@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251028094754.72816-1-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0063.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::27) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|MN2PR12MB4158:EE_
X-MS-Office365-Filtering-Correlation-Id: ce87126f-f6ef-419c-a67b-08de170a6ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlpTV1V6L2gvTTVOVHpEVjJncXdZY1ZXbExXa251cXB2eXhFQkZ6cTREckJu?=
 =?utf-8?B?MHA0Y0JMZ3Rpd3FFQVpuQjBIbWk3cE1ZQXFkWUo4WHR0VHVlbW1QMCtmWDdV?=
 =?utf-8?B?MG5FTWU4TS9hb3FncXM0aU90YVVOTFMyeTZwcVQwVmNiWmhBVURWb0RLZVdh?=
 =?utf-8?B?NFpTendMcWcrQkJQWmxEUlFmclhPZERQYlZuVWpIWDU4ZC9KT1RUT2owbEM3?=
 =?utf-8?B?L0EyWXcyNU5SOFc2NElCdUtRbmRWUWtqSzdVVXVZdkNPZVo3NVpxQlNLanpN?=
 =?utf-8?B?Y0J1TjZ6TVJJME9md21vUDUxUTlEeHlnK0ZvaXhPdVFJR1l4ZFJYL2Y2b0c3?=
 =?utf-8?B?R1FXWFNPUjV1cXpYS00zWWU2c2NaUXpTRmx6aERYZ2paazZldERrcUpwczdt?=
 =?utf-8?B?ZXVTVDJjaDZmTzJKVjBtajc0RXZFbERjU05wQUZLckY2aVJKRG5xUU1EY1Zq?=
 =?utf-8?B?NG03dmJycHNjRGNOUGVlblM2UTlEWm5jbVVraDd0dnZ1Mzd6L3FuRVhzR0tX?=
 =?utf-8?B?YkRXS2Jvd3p3M1luUlE0bUNxckoxQmhuNk1YSmluREI1TDNwSUFrNW5lRnJN?=
 =?utf-8?B?Q3FPOWRPWU5LQWxWL3JDekVQN3ZEeW41VjIyVjNRN0F1RGhWSS9qdGRCVlRm?=
 =?utf-8?B?bXlwZ0JybmlmQ1k5dTNjbldSUUh6MHBRbS91bkdmMWIzUncyOCtVMS8wV3g3?=
 =?utf-8?B?TnpVMkoxU3NVWjFmQ2piOXowOEROb1JNTnhGb2dQT1hBWDBic0xlcU1IS3cv?=
 =?utf-8?B?Y1lRTWcwb1Q4cWozKzdMY1cxMnhxTDhMdzJxZ1FaY3EvRDhWcGZuZFZmQ2J5?=
 =?utf-8?B?Q29CNEVBL0xlUEYwSlMvbG5HRkJUcUZXenkyWEVkaHVQbjg2Z0hlelZDYTNq?=
 =?utf-8?B?SUdxMm5CelNuTmdrV2Yxd1VMdFRJeURIY2Z6RUJ2REE1d0R4ZWlMaTVtR2lT?=
 =?utf-8?B?TWpWMGdsZk1XNVEwV0FLck1aRUpuMkZXZnZrVnkxcVFQQVhUNHQvVytTeWRJ?=
 =?utf-8?B?eXFwVTV5V3VXcTVUSzBXa2U3aWVCQmFHSVZ3Z1cwT0VIQW1UTXhIZWM1b0t4?=
 =?utf-8?B?SXZydm83MlJIS0wvcFVBZE9kMlJBY0x2SlBoekg3Q0lHYmNYSVkySCs3eGQ1?=
 =?utf-8?B?ay9zZEc0SXVnUm9NQy9tNUZqRERFL0pPT256ai9lVmxrb0Ftc25ZUGFZd1Fh?=
 =?utf-8?B?N0g0RDRSSTNHbUNIdmhDT3Z6aVNpSENBYldiRzhmZFF6Wm1VdGZEVlZmWUdh?=
 =?utf-8?B?K2llTkd6R1FnWERVVWsxVkVKbUdISXZLN0JMaUpBa081TWpNd0hIZDFqVnc5?=
 =?utf-8?B?TThGTSs2UkFLdjFJNVdkbjd0TlhIT1c1cWxHeGkreG5xQ0dRWldFNDE0T0dD?=
 =?utf-8?B?OWlSdnhMSkYxNk9aOVpQY0J1N3Y2ZEhKVTlzRnk1WDdQM0VucktFdW9xM0lq?=
 =?utf-8?B?TjVJNVdsTFF3UUg2cndnempsM2JzZ2p3YlE5VlRPSFdTcm1iSnlJeVJiZ0dX?=
 =?utf-8?B?YmRvek9VTk9NT0ZKMGUySHNPRmZ1d3grcWtmOE5rUkJJN0FXdVRFaVljZnYx?=
 =?utf-8?B?VzVUM2piTHRhdm5TbUlwR1RxUEFLUlVFVW1xeFNqSm5Fd0tkVll4N1FKZ0tq?=
 =?utf-8?B?UG1DSU1kSDlNVXROL1dtMXZkN2Q1VlZ3SDJNQkNYNkZXUWVSVVE4T2VuUllL?=
 =?utf-8?B?R1d0eDBhRk9UOEZ3OVl1Yy9qTWJGTVlxNTdjVTZ1SlhTR2VPY21kUmF3TjVK?=
 =?utf-8?B?VlEvOERTNElFdDkyQjRtREtadUFnYWFDdXZjZ3RENWpXeE1nR3RaVVVhek9k?=
 =?utf-8?B?cVQvejhBMG5WZGRyQmFkQm5aRkRIQkl5WktEWjZHZWNKWXhqbjNheitCVVZD?=
 =?utf-8?B?WklvMHZYcmt6NVB5dkoxZUEwRUN1VWVscVZRSmNoY1V4a3hTUGFVVGJjd01s?=
 =?utf-8?Q?fFseVz3xufYqsrUUTVr/aI3RU3qTt7qU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDU1MXEzTENnZHBJdlllM1c1OHhXd0NQcU5mQ1h1NU5lQWMvS2VxZG5VOWt0?=
 =?utf-8?B?TE5naGJJNXRGRmVqeFhiZHdLWTh6TjZDWlBScmEzcFNNMnpVUkFxNlVOYkZh?=
 =?utf-8?B?cUFjTTQzek50K1B4MWdRelVHUVg5dFhLQ2E3cStqNG1XcnptMC9TVWJrcUxG?=
 =?utf-8?B?amxhR0RyU3VuL29lMUIydWFmYjRNOWtlTTF1MVQxcW4xZnA1d25BTkgzeUk2?=
 =?utf-8?B?bzJ6eXBoWHBUbnlBWGtESFpjcHFQdUhjcUg1UGU0SnFpSENIUVp2U01USmdQ?=
 =?utf-8?B?Rlk5blRTWDkrSXdkSVFyckV2MnJIUTFyUlB4VjYvMjB1VTFCMU1SbTNKcVo4?=
 =?utf-8?B?VkxmK0R6UE85NUtpWkNGTFBncUo2M0txYVJwc3JIT0xxbWRueWhENW5udlIx?=
 =?utf-8?B?bHVibFJvWDdHWUl5eVhaZW9pYStNbG1IUmk1ZVU2bzcxbVpxZVRHc3owNVFV?=
 =?utf-8?B?ZCtjNkYyVlVpRllKVjdOU3lscmx6UnB6ZkFVY21iMnpFakFJOFZCZ21BL1NL?=
 =?utf-8?B?bUYrajdsWmxxTm1KQThvQzRmelpVaXp5ZjBqRy9HTjZ6UWJDVjl5TDhiNnFZ?=
 =?utf-8?B?Z0xpZ2VpS2VOSWZ4ektvYTdsd3NCb0N5QWpwcG52TE5xZkRvTzdBbitMU2M0?=
 =?utf-8?B?bFhwU2NpRUw2QW53SlU2U3FHdVhRb0NSZ0dSeHlNM3UrRmZUMC9CUEJ2bm5k?=
 =?utf-8?B?VFRTRmlpZHI2NENCazlaaTM4MFc0K0VCdGhpbnFNUGExSHRxMUVwV25UOHVs?=
 =?utf-8?B?SjdONGN1K0FFOHo1MW00WldMelhGZzBER3BMbk5aNGFGQW1uKzNqdEZvc1pO?=
 =?utf-8?B?T1Y5UVRnN1BZdzExNkdoR3NBUjlwV0JWVi9zRVNpeUZ6MXhrd0lrdmZENVRT?=
 =?utf-8?B?TmlEVDZYeDlCaTVnQUprTXJoS1lxM3R1RWdiZVdTMVRUVlI0YXNBMU9aTDhQ?=
 =?utf-8?B?RHpjNnF0RVdVMGZTbUx1TmVXNGRGbGk5WlNmZjZtbWU0OGxyWmx3T1VNU3dO?=
 =?utf-8?B?aHdtZmtGVDY0aFVsM3JMaGhwNmpHSllGSGp2TlEwZmhBSEp6Wkx3cU5kUmRV?=
 =?utf-8?B?M3pOdk5Lb01ONG90TVdpTjg3bWtVZTEvc00yRWhCeHVnZk40blhFQkFUR3FW?=
 =?utf-8?B?QVNKVlgxR3NCQXFSWDgrOG9ERzEvVS9MdHNLdWszeldNaTRlZ2xQZVQ0MFRT?=
 =?utf-8?B?QzVTaFlaZmxpN3BoSkUvRzlCRHVNMlJyWHZVbWlTdkd0TnVlTkY0U0pPTXQ3?=
 =?utf-8?B?dUVSQVRRWUw0cHNGT1hObzdLNG1qeWdyNm96REJUL3dxNHVDR2VNU1NIaXlj?=
 =?utf-8?B?SFh6WGtrbVBIVkMwWkJsUzlIL2NtdHoxbVJxRlZoamRzMXoxSEk4WVlUZERB?=
 =?utf-8?B?TkVxMUFlUFM0MW1CTmFNUEVOaGtWTGtOQmYvRzRnYTJMb0FkZC9ZNGkrTWVj?=
 =?utf-8?B?NEQzNFVUaWp2WG9jWnVKMExtRHdNOW10SGd3OVB6aGtyVERVMGQwTHlUY0oy?=
 =?utf-8?B?NXNzK0VucDdNd0lnak1EdnNKd2xPdXY1L05qcjNxWEl1Vm4xdnYyT1RiTTFN?=
 =?utf-8?B?MEQ4U0h4OTVYMkQ3dDV1WHUrUUdvRFZQNHpYeW1qZ0tsbS9BaEhLTGJ2ZFhH?=
 =?utf-8?B?bnBmTTFKdm1rb1JvdWZyV0E5dE1HbXpabzIxcnlEUUNQMkJlMnQ4N3N5UTZv?=
 =?utf-8?B?c0V0OXZXZThjanlJbEhVdlJoK0RkbHhPSW9YMC8vbHhsdHV3b2trWE1PQTZS?=
 =?utf-8?B?eUhqa2pHMDhYY1BiKy83cGtrWDdWdlRqRk1yRU4ySFI4ODZKbHFnMEQxQXVx?=
 =?utf-8?B?azlRa2JGR2ppVU52SUtrSU5DbkZwNjRtWVZxZmgvZ01HbjNVSXR2UkdaVDJG?=
 =?utf-8?B?MnRzWTZidDAyd1FXdHZ3Tml4K2s5d0tkOXZ3MVlNVUNpQlhqNC9BMnQwdXox?=
 =?utf-8?B?OGZHNmtETnNFZ095NUloWWlqZ3Y1Rkh3TWRWS09teEdIVFM1eFMrY1ZTaTJh?=
 =?utf-8?B?c08waDZWM21YaTFDME9mV0hxbzdqZXhpZENkSDdjaGhvbjFJT3QvK1NtZ1Nz?=
 =?utf-8?B?UzUvaXBhRWovSmM5RUs5VXRvc3ZFQ3JqNW50ZHdwT3M4S3Y0TTVGdkZvMjR3?=
 =?utf-8?Q?PqvExbJ0yhBB8f4Glp+7k1/D/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce87126f-f6ef-419c-a67b-08de170a6ecf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:44:31.2705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljkX9QINNWvcdJC38Q/bOMtYZuKvbpB4hQBFVcNeuO1RSBkzeMm4fBAUY01Xq6/qZmi670ZIiYcRJqQiF83uGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158


On 10/28/25 09:47, Robert Richter wrote:
> The CXL specification supports multi-level interleaving "as long as
> all the levels use different, but consecutive, HPA bits to select the
> target and no Interleave Set has more than 8 devices" (from 3.2).
>
> Currently the kernel expects that a decoder's "interleave granularity
> is a multiple of @parent_port granularity". That is, the granularity
> of a lower level is bigger than those of the parent and uses the outer
> HPA bits as selector. It works e.g. for the following 8-way config:
>
>   * cross-link (cross-hostbridge config in CFMWS):
>     * 4-way
>     * 256 granularity
>     * Selector: HPA[8:9]
>   * sub-link (CXL Host bridge config of the HDM):
>     * 2-way
>     * 1024 granularity
>     * Selector: HPA[10]
>
> Now, if the outer HPA bits are used for the cross-hostbridge, an 8-way
> config could look like this:
>
>   * cross-link (cross-hostbridge config in CFMWS):
>     * 4-way
>     * 512 granularity
>     * Selector: HPA[9:10]
>   * sub-link (CXL Host bridge config of the HDM):
>     * 2-way
>     * 256 granularity
>     * Selector: HPA[8]
>
> The enumeration of decoders for this configuration fails then with
> following error:
>
>   cxl region0: pci0000:00:port1 cxl_port_setup_targets expected iw: 2 ig: 1024 [mem 0x10000000000-0x1ffffffffff flags 0x200]
>   cxl region0: pci0000:00:port1 cxl_port_setup_targets got iw: 2 ig: 256 state: enabled 0x10000000000:0x1ffffffffff
>   cxl_port endpoint12: failed to attach decoder12.0 to region0: -6
>
> Note that this happens only if firmware is setting up the decoders
> (CXL_REGION_F_AUTO). For userspace region assembly the granularities
> are chosen to increase from root down to the lower levels. That is,
> outer HPA bits are always used for lower interleaving levels.
>
> Rework the implementation to also support multi-level interleaving
> with smaller granularities for lower levels. Determine the interleave
> set of autodetected decoders. Check that it is a subset of the root
> interleave.
>
> The HPA selector bits are extracted for all decoders of the set and
> checked that there is no overlap and bits are consecutive. All
> decoders can be programmed now to use any bit range within the
> region's target selector.
>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>   drivers/cxl/core/region.c | 201 ++++++++++++++++++++------------------
>   1 file changed, 108 insertions(+), 93 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b06fee1978ba..79d35def7c79 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1323,57 +1323,119 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
>   	return 0;
>   }
>   
> +static inline u64 get_selector(u64 ways, u64 gran)
> +{
> +	if (!is_power_of_2(ways))
> +		ways /= 3;
> +
> +	if (!is_power_of_2(ways) || !is_power_of_2(gran))
> +		return 0;
> +
> +	return (ways - 1) * gran;
> +}
> +
>   static int cxl_port_setup_targets(struct cxl_port *port,
>   				  struct cxl_region *cxlr,
>   				  struct cxl_endpoint_decoder *cxled)
>   {
>   	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> -	int parent_iw, parent_ig, ig, iw, rc, inc = 0, pos = cxled->pos;
>   	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
>   	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>   	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
>   	struct cxl_region_params *p = &cxlr->params;
>   	struct cxl_decoder *cxld = cxl_rr->decoder;
> -	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(&cxld->dev);
>   	struct cxl_port *iter = port;
> -	u16 eig, peig;
> -	u8 eiw, peiw;
> +	int ig, iw = cxl_rr->nr_targets, rc, inc = 0, pos = cxled->pos;
> +	int distance, parent_distance;
> +	u64 selector, cxlr_sel;
> +	u16 eig;
> +	u8 eiw;
>   


Hi Robert,


The number of local variables suggest to me maybe it is worth to 
refactor this code for simplicity, factoring out the selector and 
distance calculation. You added a new helper above which should include 
most of this, IMO.


Alejandro


>   	/*
>   	 * While root level decoders support x3, x6, x12, switch level
>   	 * decoders only support powers of 2 up to x16.
>   	 */
> -	if (!is_power_of_2(cxl_rr->nr_targets)) {
> +	if (!is_power_of_2(iw)) {
>   		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			cxl_rr->nr_targets);
> +			dev_name(port->uport_dev), dev_name(&port->dev), iw);
>   		return -EINVAL;
>   	}
>   
> -	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> -	if (cxl_rr->nr_targets_set) {
> -		int i, distance = 1;
> -		struct cxl_region_ref *cxl_rr_iter;
> +	if (iw > 8 || iw > cxlsd->nr_targets) {
> +		dev_dbg(&cxlr->dev,
> +			"%s:%s:%s: ways: %d overflows targets: %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
> +		return -ENXIO;
> +	}
>   
> -		/*
> -		 * The "distance" between peer downstream ports represents which
> -		 * endpoint positions in the region interleave a given port can
> -		 * host.
> -		 *
> -		 * For example, at the root of a hierarchy the distance is
> -		 * always 1 as every index targets a different host-bridge. At
> -		 * each subsequent switch level those ports map every Nth region
> -		 * position where N is the width of the switch == distance.
> -		 */
> -		do {
> -			cxl_rr_iter = cxl_rr_load(iter, cxlr);
> -			distance *= cxl_rr_iter->nr_targets;
> -			iter = to_cxl_port(iter->dev.parent);
> -		} while (!is_cxl_root(iter));
> -		distance *= cxlrd->cxlsd.cxld.interleave_ways;
> +	/*
> +	 * Calculate the effective granularity and ways to determine
> +	 * HPA bits used as target selectors of the interleave set.
> +	 * Use this to check if the root decoder and all subsequent
> +	 * HDM decoders only use bits from that range as selectors.
> +	 *
> +	 * The "distance" between peer downstream ports represents which
> +	 * endpoint positions in the region interleave a given port can
> +	 * host.
> +	 *
> +	 * For example, at the root of a hierarchy the distance is
> +	 * always 1 as every index targets a different host-bridge. At
> +	 * each subsequent switch level those ports map every Nth region
> +	 * position where N is the width of the switch == distance.
> +	 */
> +
> +	/* Start with the root decoders selector and distance. */
> +	selector = get_selector(cxlrd->cxlsd.cxld.interleave_ways,
> +				cxlrd->cxlsd.cxld.interleave_granularity);
> +	distance = cxlrd->cxlsd.cxld.interleave_ways;
> +	if (!is_power_of_2(distance))
> +		distance /= 3;
> +
> +	for (iter = parent_port; !is_cxl_root(iter);
> +	     iter = to_cxl_port(iter->dev.parent)) {
> +		struct cxl_region_ref *cxl_rr_iter = cxl_rr_load(iter, cxlr);
> +		struct cxl_decoder *cxld_iter = cxl_rr_iter->decoder;
> +		u64 cxld_sel;
> +
> +		if (cxld_iter->interleave_ways == 1)
> +			continue;
> +
> +		cxld_sel = get_selector(cxld_iter->interleave_ways,
> +					cxld_iter->interleave_granularity);
> +
> +		if (cxld_sel & selector) {
> +			dev_dbg(&cxlr->dev, "%s:%s: overlapping selectors: %#llx:%#llx\n",
> +				dev_name(iter->uport_dev),
> +				dev_name(&iter->dev), cxld_sel, selector);
> +			return -ENXIO;
> +		}
>   
> -		for (i = 0; i < cxl_rr->nr_targets_set; i++)
> +		selector |= cxld_sel;
> +		distance *= cxl_rr_iter->nr_targets;
> +	}
> +
> +	parent_distance = distance;
> +	distance *= iw;
> +
> +	/* The combined selector bits must fit the region selector. */
> +	cxlr_sel = get_selector(p->interleave_ways,
> +				p->interleave_granularity);
> +
> +	if ((cxlr_sel & selector) != selector) {
> +		dev_dbg(&cxlr->dev, "%s:%s: invalid selectors: %#llx:%#llx\n",
> +			dev_name(iter->uport_dev),
> +			dev_name(&iter->dev), cxlr_sel, selector);
> +		return -ENXIO;
> +	}
> +
> +	/* Calculate remaining selector bits available for use. */
> +	selector = cxlr_sel & ~selector;
> +
> +	if (cxl_rr->nr_targets_set) {
> +		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
>   			if (ep->dport == cxlsd->target[i]) {
>   				rc = check_last_peer(cxled, ep, cxl_rr,
>   						     distance);
> @@ -1384,87 +1446,40 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>   		goto add_target;
>   	}
>   
> -	if (is_cxl_root(parent_port)) {
> +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
> +		ig = cxld->interleave_granularity;
> +	else
>   		/*
> +		 * Set the interleave granularity with each interleave
> +		 * level to a multiple of it's parent port interleave
> +		 * ways. Beginning with the granularity of the root
> +		 * decoder set to the region granularity (starting
> +		 * with the inner selector bits of the HPA), the
> +		 * granularity is increased with each level. Calculate
> +		 * this using the parent distance and region
> +		 * granularity.
> +		 *
>   		 * Root decoder IG is always set to value in CFMWS which
>   		 * may be different than this region's IG.  We can use the
>   		 * region's IG here since interleave_granularity_store()
>   		 * does not allow interleaved host-bridges with
>   		 * root IG != region IG.
>   		 */
> -		parent_ig = p->interleave_granularity;
> -		parent_iw = cxlrd->cxlsd.cxld.interleave_ways;
> -		/*
> -		 * For purposes of address bit routing, use power-of-2 math for
> -		 * switch ports.
> -		 */
> -		if (!is_power_of_2(parent_iw))
> -			parent_iw /= 3;
> -	} else {
> -		struct cxl_region_ref *parent_rr;
> -		struct cxl_decoder *parent_cxld;
> -
> -		parent_rr = cxl_rr_load(parent_port, cxlr);
> -		parent_cxld = parent_rr->decoder;
> -		parent_ig = parent_cxld->interleave_granularity;
> -		parent_iw = parent_cxld->interleave_ways;
> -	}
> -
> -	rc = granularity_to_eig(parent_ig, &peig);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
> -			dev_name(parent_port->uport_dev),
> -			dev_name(&parent_port->dev), parent_ig);
> -		return rc;
> -	}
> -
> -	rc = ways_to_eiw(parent_iw, &peiw);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
> -			dev_name(parent_port->uport_dev),
> -			dev_name(&parent_port->dev), parent_iw);
> -		return rc;
> -	}
> +		ig = p->interleave_granularity * parent_distance;
>   
> -	iw = cxl_rr->nr_targets;
>   	rc = ways_to_eiw(iw, &eiw);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev), iw);
> -		return rc;
> -	}
> -
> -	/*
> -	 * Interleave granularity is a multiple of @parent_port granularity.
> -	 * Multiplier is the parent port interleave ways.
> -	 */
> -	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev,
> -			"%s: invalid granularity calculation (%d * %d)\n",
> -			dev_name(&parent_port->dev), parent_ig, parent_iw);
> -		return rc;
> -	}
> -
> -	rc = eig_to_granularity(eig, &ig);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			256 << eig);
> -		return rc;
> -	}
> +	if (!rc)
> +		rc = granularity_to_eig(ig, &eig);
>   
> -	if (iw > 8 || iw > cxlsd->nr_targets) {
> -		dev_dbg(&cxlr->dev,
> -			"%s:%s:%s: ways: %d overflows targets: %d\n",
> +	if (rc || (iw > 1 && ~selector & get_selector(iw, ig))) {
> +		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d:%d:%#llx\n",
>   			dev_name(port->uport_dev), dev_name(&port->dev),
> -			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
> +			iw, ig, selector);
>   		return -ENXIO;
>   	}
>   
>   	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>   		if (cxld->interleave_ways != iw ||
> -		    (iw > 1 && cxld->interleave_granularity != ig) ||
>   		    !region_res_match_cxl_range(p, &cxld->hpa_range) ||
>   		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
>   			dev_err(&cxlr->dev,
