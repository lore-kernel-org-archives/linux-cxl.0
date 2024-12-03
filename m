Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52859645;
	Tue,  3 Dec 2024 06:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733205716; cv=fail; b=qTnFdVmGyXOGvnpQxl/D1QzUxyGln+EDzHQ0GtI0LjOwL0t4hY5zwBGvE+NVrAqQVpprEIZJuZS4w31y6lDCTldKUqhraPbvVLEINRnVy+ruOdfKDVZ25Luyf1tXlEwyXk5M0KoajS+1a0tsmVO5TcaUFlL4ZNE2pDhSFYhWFxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733205716; c=relaxed/simple;
	bh=vNis/zk9HC9wmGfmVXIRXTB4+nNX7JAGq2xw0r2mfWg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FduceP88eKHak7Umd9BfWQBJfLKd7WUOPbaiyXf6So+bYuX7nEdSOaNNe+MI3/RDZXxkQhITvjsfIf/euWNuDs9pXo3C5t7NDzHmv5lKEtZT24gbpfaO0tayamqPtAv4kSsdMwHN5Lnjk8RtzQJjGBkdGeOa73ho4vkVU1/tfJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o4f/H7zh; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o4f/H7zh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qS6nCPJGTUnxnAut+YI9cAFcm2t2ikE/Yhol6S20MVK36kUbpPznp1W8MBWK5vKB+Z6/Dw7SwxSkdO5fN1CjqKTyVPHG+CSM7NXXL8/K674AqlNFSqundLfRQuCG13x5jOgSLClNzeRuqWDOoW3CgMYJxIv7qm+dojKb0T3So6UuIGDgIgS8DAZqTBOgN0d9JHqJJ/rz2h5xiDqEheU5iJwqma/g+CHKjccx4UFBcI9bEJ1gOJu9MQIqy+p+xdDfxiiE76+/Sid8+se0gLPjNwCrl07wZ6cIDL8wk5k5WJ2zng6CGjAfMxp63ZI8jRQJ2Lp74t0g8wzvrv4jBIDtIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idnF7DX4ohAPyG8m7sBMKE2Ct0PuKV3+nayK7v7BnoE=;
 b=ghHncKtTyz1TCh9OL2UK9DesRNTVJ59ZotEj5P1t9UTbBMYoYNJJv5Hxt+7eW7u9j3unc9oAPT/LxdHjhXB9EofSyf5wS2mArdEpSJo3SVPDdiijFUNrodgjlyavMJQf46QJnP1VP1ScTiFH5VM7hl2Ix5FHJB/3BA0XEQWnNuHdbbsOp1vimx3warTiX7SGJlIaBA/3qZWwY9m/0THhojhUv+JrF4fBwNKgNDiLP+lcIMSn6PkJ9ZPY2iO4tM+9B9paVXG60ITz8uOd4M4c5T9zS0rYm1A9vLK0auGCt2VHKSOWxh71Pv5ssLaJNmUsSs0YvmCRfhTNwU235/1AOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idnF7DX4ohAPyG8m7sBMKE2Ct0PuKV3+nayK7v7BnoE=;
 b=o4f/H7zh2X0W7BXnKvA5erTr+nQeYdC5yZvUANPgcU+XE5FOW5W94eUH9WSIPsZ19fT7NeJKi1rNDUmM32/kfQAgqibTV9OsbWOiQgVvq9O41eN0HTTRN4KzSJxKPV3IUFZLv19B65m3us3y3k3D/Rtpy+LcJKpKrZR7eVPHQZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 06:01:50 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 06:01:50 +0000
Message-ID: <a7be4e76-bfee-4159-a7a5-880a22230029@amd.com>
Date: Tue, 3 Dec 2024 11:31:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] resource: Fix CXL node not populated issue
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, bharata@amd.com,
 Huang Ying <ying.huang@intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
 David Hildenbrand <david@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Baoquan He <bhe@redhat.com>, ilpo.jarvinen@linux.intel.com,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Fontenot Nathan <Nathan.Fontenot@amd.com>, Wei Huang <wei.huang2@amd.com>,
 ying.huang@linux.alibaba.com
References: <20241202111941.2636613-1-raghavendra.kt@amd.com>
 <Z03TeSrlI_8y4j89@smile.fi.intel.com>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <Z03TeSrlI_8y4j89@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0056.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::31) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 90298704-0882-4026-57f8-08dd135ffa21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWJMNitTS0orc20rakxzYzZDUlBuVnkxcllXVGhXUWsrRndnU2wvYnF4M1RQ?=
 =?utf-8?B?RXV1Zy82eFhEWnVQN3hzcXlDYkNZS0g5YlRvKzBndURlcklsRDJXNEdaa2ox?=
 =?utf-8?B?QWpGK2FWZVJCdFhGUlZIWGdYK1BhWGs1REQ1bG9jY2FTeGRHNy9vR2lPeUkr?=
 =?utf-8?B?bkRaTStSMDFJUjJnYjdlSktNUWtqNXlPTEd4YkdTK2sraWVHeUQ0V0ZOakVD?=
 =?utf-8?B?VTdPU3J3QWlYbnZqeStaS0pFeUVOTWRuY1ZmNTFieXBIcjNocEtBWWRDUW4v?=
 =?utf-8?B?ZWxIRXFMV09SbEJKOVJjeFRIUGVIRnRJSFBmMmg4cFpuSkVRMEVRUGVZaFU3?=
 =?utf-8?B?cWdmYm1NWmsyV2U4Q0ExNisvOFVjdHh4QVgrUGswTUJENStXUjVZallDODdD?=
 =?utf-8?B?blVHRE5rZk4zV1VJVHBFdjVHVzl1V1RSUXNsQXFrYWNIQmxBVllvZ25reDBv?=
 =?utf-8?B?N2VaZjM3cmZNN3JzWkVUM083cmVnNXBZSWhjSWt0TVl4bnE5SGx3OXVPWXFK?=
 =?utf-8?B?N05uTENtTHdPdkt3a1VPcXROTnZWOXBlbnNiNWR2RGdzaTVsVUt6bmpRUGxG?=
 =?utf-8?B?eHhNZ2VQdTZ4SXNvN3ptZ0F1SGdMRGhVM1FZUjRqaXBrSmw1VWNpQ3BvRjd3?=
 =?utf-8?B?NlU5SEtpUEhOVnV1TGVvWkdWdldsSWUyVXBqWWZPWlAwcTE0d2c4L0psaHZ3?=
 =?utf-8?B?bFJKU1lLT2lxdzdxcmpwZnUxRUI1MTZLZW1KelM4WDM3bHZBcGtHUkd6NWU4?=
 =?utf-8?B?QzR4N0xDSHBDRis1TW5jM3JieDErWVZGVGtXTkVhSzN4RHR1Z0lOSktJQWtO?=
 =?utf-8?B?OE9wa3gvNUdobXZxb2cwbWVvMFNDaFhpbTlMZW5TNkxDb1JCNUxWMnU5WEpM?=
 =?utf-8?B?YWpkSDlTaHNVTGJJUXBUeXZzOUhIa1RTVGhGNTRzU3RLYWlpcDBwTjFUWnNp?=
 =?utf-8?B?VzBpaEhlNDZSdnEzYkUvTURTUGptRjY0WmdWSloyZEhCSG5vbzNYT0RTT3h3?=
 =?utf-8?B?VWFnUHJxdlpVdXlsZ0REUmwrV1FENTBxVGJzOUtJV0E0ZHUyN3YyZW5Qd2dG?=
 =?utf-8?B?bGV3K2E0bk5FcW1IK1NhaEdSRnMrdThTaEtWY1dwekl5bWFqVURhaW5Ub1ZH?=
 =?utf-8?B?bnFPN0hia2ZNVy95QUFmdUJkZnoyWCs5YVlON0RyNVlOOUUyYTNPZlR5ZGtm?=
 =?utf-8?B?bGJhM2pjK0VHSnQ2OUVHODZ5YW9wcDZTVS80YTRHRkJoVTF1cUdWSFFLeFI0?=
 =?utf-8?B?SFpOY2xtOG1GSjE1ODVCLzFjTGs1M1Z3dDRqdmxXZW95OUFEREFYaG1DcFNY?=
 =?utf-8?B?Ym1YZXErNUhKck1pRThhQ0JxY1VyaVArQUIzTmlTUko1M3hyOVJ0K3duczRO?=
 =?utf-8?B?L0crZGZ5QTJLaHE0L3hJWDVxRXhVeThkdFB3NGRzd0hMdmlWUUhTRkhxS2Uz?=
 =?utf-8?B?TmpreU90RlhWZm9OUlFITWlYbXVKWU1ZM0doT0h6R3gwZmFOa0ZYMVd5Yitv?=
 =?utf-8?B?WE85NWxYN1R1RlpUSE5CZlBPSDdhb3djQlhxdmJaRFZienA2dUZRSk1aS2hK?=
 =?utf-8?B?SXdSaDVXYmZTRlhURlBZUTBHK2c3U2ZXMWlpRjBaOHVCWmJBWTdwcUlDWi94?=
 =?utf-8?B?b1JFQVZ2ZHhnVWsrVmU5dWRmS2J5dndZU1A4U3F4UjUrUDBqK3ZYM2p6UHBy?=
 =?utf-8?B?VmZqaXhQN1IyWDBXUmpTaXdqQXAweWpVYmtqTFNaaUFaT0RZeFErTGtJT1dO?=
 =?utf-8?B?bU9Da2l2NEgyQzc1c3l0Z2FWcVFrM0lneVlkVEo5ZmJYVHVGL2VJa003dUo3?=
 =?utf-8?Q?iX+uGTElYFce7VU1m9xmkZXC7Z42W1MeXYhQo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OStTaWFvNUxLRHdiZDFZMWZoOE1HMkxuZU1sQmloOGQ0MElxYzJGQ05RMDJZ?=
 =?utf-8?B?ODAzeEI1R2FrbWpWd1ZvcU1ib1FlOGVsU3Qzd0VmenU0NXVWek05YzJwcS9Q?=
 =?utf-8?B?NVlwTEFIOHJ5Y05FWE5wa0hieEpZcXozQlRNM1BvTnRUM2RVOGpYeEJNZDVa?=
 =?utf-8?B?K05TVnVSV3hWZUQvVWozSjFwd3NXbHJWMnliQXFtRGhOeStHcHVUUlowYmhF?=
 =?utf-8?B?SXFZWHFUbTFBY055RVF0RUNkcWRtK1plbjNOODloRFFlenVUVitVaS9meTZq?=
 =?utf-8?B?UTFYVDFWZG1kZjJpMHA2d2ZqZk1TbWhSbWlEdWtZTW9rNGlhdzdpQnVGZitq?=
 =?utf-8?B?STJNUGRIVmEyRnBmY3BRUW5MWnFmSUVYdEhzby9MY3A2eXlZMVY5YlFTWjlm?=
 =?utf-8?B?ZlVWRXRZeTduK0h2dHFyU1FINytZdEVndC90YzRsOThTTWlVL3VIZGpGT3pv?=
 =?utf-8?B?UENrdWk5N0w4dU9yNFdzRzFwZmlCK3F6RVRTdUcvd1k0b2xWT2ZaU2dCY3NR?=
 =?utf-8?B?ZFN4U1RCTldlQ0E4dU81OUFicis4ZURpelNDNzFNa240cVB4WDlsNSthdXRX?=
 =?utf-8?B?aGFZdjhGSVpJSXd4dlZrN3FEbUQxdmR2bEpFK052VjF5WHczeXM1R2NFbEg0?=
 =?utf-8?B?SUNqMEZ0T1pFeUkrd05rVXI1dzdYUGZra0Nlc3ZDZnFIa1dkRSswTTVhd1hY?=
 =?utf-8?B?NFlHbzlTT0h3OWx3S0svb0pvM1VqVnFKNHg2ak5sOSs3NFBncGFZdmkvSkVs?=
 =?utf-8?B?WnJJeUpTL3htNDY4VUJmaXpYZitDUVF6bGNhZHNWc2ZGWUFGZ3JMUS9HMWtJ?=
 =?utf-8?B?ZkpLbklxbEZmT1RvUHhhSGI2UlNVRnR4Nm9oaFM4NTFZS0wrb2RROTdURWRB?=
 =?utf-8?B?NWovcFo0dzdBT3l2eG1mMGZWUVN5RWxyYUYydWRWcG1wMzFxUkljRWVpdGVK?=
 =?utf-8?B?c1NYNmdCQmxoOWo3R0x1Vk11YndvdlJVTFE2Z0ZNTkdWL21ZYzZIaC9YcTEx?=
 =?utf-8?B?OFlKK3hVMWh2RmJpaVRnc2RSUkpsNEVOV0lqUFRrMyttSHIyNFY3TjFhdkhD?=
 =?utf-8?B?eEk1S0ZzL0dTcXlzV2V6cDZ1VW5MYUFCVEkxSE8yc3lEcTlGOTJVTjBXUDdt?=
 =?utf-8?B?U2ZzNUZLZ1h3NGl6VG4wSmNNRzZHSy9ablZZMHJheStoRStTUFQ5Y0hKeTl3?=
 =?utf-8?B?S0J1bmdzdE1rZkVYZWVjMlpaZXdIOWw2bWMrUGh1OFoxREdNcldnQmpkMldu?=
 =?utf-8?B?T2o0UG8rVlNzQlRVMFVqWU5TMnlkYS9xMG85WE8rMk5xR29Lc0JzcXo4T2Nn?=
 =?utf-8?B?bXBwaDA4ZGZTeUFuSmJoZzNpU3NKVG9aQnhnMHFkL3hxZFVXOERrZ2Yvd0xo?=
 =?utf-8?B?NFhOdm1zMG01MmhUQ0cyZFVEKzFCVW9DUDEwMXQzdmpDR0U0Y3ZkQVVKQkY5?=
 =?utf-8?B?TkdiQ2JsMzdCUkMycUNjcnNybFQxbVJzVzVVaWtEM2dXVmEvUDAyQ21rVlRY?=
 =?utf-8?B?SXc5WlVRNTdpUG16dnhBVDA4cjNUOS9vZC90NmRKOGNaWVgzbFRnQW5qNEpy?=
 =?utf-8?B?R0FzK21tZW5YdDYzZ1FCQnNLTjhDOS9TUFJvUGx1MFVtNGlRancyTWFOWmR4?=
 =?utf-8?B?UDQvQjI3Ui9YRUVOSFV1Z2Nnd09wdU1FejMyYUc5QXVhZTdzcDdUZDFxanky?=
 =?utf-8?B?RUJyUTM0b2hQREJsRDJ4OWhTSHkrOW8xV0JBZEtHRFVEdmVjZU1nT2NZNW84?=
 =?utf-8?B?TlpBN2FYTUpUS0JZMlRJL20yOHIxQk1xQmZtYlpSU1JaK1RUNWgvZHI4K0Z3?=
 =?utf-8?B?UThvemJuOUFoNCszWUdmMmFpMy9zcGlvaERDSGhxRkh6akhyb3R2UXZ1Sm8v?=
 =?utf-8?B?SEFadDRHYkpBNUpSV1dSV2VkcDM3WEdzQlZDN2hQVnI4K1ZoRWoyMDdKTjVk?=
 =?utf-8?B?dDVhWXVKQmxUdHpBYnNNZktaN1c1WVZOWmJYUG5GZ1cxakYzdmRVdGdaRVhV?=
 =?utf-8?B?b05BYkNhSnFldlFPclFEV29TQ3R0YXVPZk5paG1KYWE2VmFuMkNoaCtOSFBY?=
 =?utf-8?B?aVZiMjVISW4yM0ZuOEJDVkV0WkVvcDNjb0plOW53TE16ZnFTOWQyTENROXYy?=
 =?utf-8?Q?Gk+rl8XdTc24nvCP55HCs03K4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90298704-0882-4026-57f8-08dd135ffa21
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 06:01:49.9808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbxS+k60Vv+R4HaROEIgGNdNdPIbT5sROf/+FDSKhOigBlPPJWoG0ZLpo2wJxS6P5U/S/aOMmWDbDFToOUlCLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613

++ Huang new address
Thank you for looking into patch Andy.
On 12/2/2024 9:04 PM, Andy Shevchenko wrote:
> On Mon, Dec 02, 2024 at 11:19:41AM +0000, Raghavendra K T wrote:
>> Before:
>> ~]$ numastat -m
>> ...
>>                            Node 0          Node 1           Total
>>                   --------------- --------------- ---------------
>> MemTotal               128096.18       128838.48       256934.65
>>
>> After:
>> $ numastat -m
>> .....
>>                            Node 0          Node 1          Node 2           Total
>>                   --------------- --------------- --------------- ---------------
>> MemTotal               128054.16       128880.51       129024.00       385958.67
>>
>> Current patch reverts the effect of first commit where the issue is seen.
>>
>> git bisect had led to below commit
> 
> Missed blank line here.
> 

Will add.

>> Fixes: b4afe4183ec7 ("resource: fix region_intersects() vs add_memory_driver_managed()")
> 
>> Cc: Huang Ying <ying.huang@intel.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Alison Schofield <alison.schofield@intel.com>
>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: <ilpo.jarvinen@linux.intel.com>
>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Cc: Fontenot Nathan <Nathan.Fontenot@amd.com>
>> Cc: Wei Huang <wei.huang2@amd.com>
> 
> Isn't it too many to be included in the commit message? Note you may use the
> same list with --cc in the command line with almost the same effect (almost --
> no noise in the commit message).

Agree. Do not want to add in the final commit message. I took
the names from the bisected message. will Cc directly next time.

> 
>> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
>> ---
> 
> ...
> 
>> +		bool is_type = (((p->flags & flags) == flags) &&
>> +				((desc == IORES_DESC_NONE) ||
>> +				 (desc == p->desc)));
>> +
>> +		if (resource_overlaps(p, &res))
>> +			is_type ? type++ : other++;
> 
> Instead (if you will end up with this approach) please still use is_type_match().
> 

Sure will do in next iteration unless someone comes with expected fix.

I bumped into this because I was not able to evaluate my patches
on 6.13 with CXL card. Thought of reporting what worked for me...

Link: : 
https://lore.kernel.org/all/20241201153818.2633616-1-raghavendra.kt@amd.com/ 


I may need some time to go back and understand some history and code.

Thanks and Regards
- Raghu


