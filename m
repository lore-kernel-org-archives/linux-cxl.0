Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81304167296
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718177256; cv=fail; b=W+KNLAwovxb5NkhsjUBIjLqk3Wgum4++eOiMkiNr6sjLcd9T+h8ZdBfzoYUpnFe7YUgY395DdpqtHEEnVJVfjEgxjnmMC1Eqjfy09KpD+cGQixtgo5LdO2rEOy+PnGY7JHAi4Yu+xLHFJxLtrmTEOGuL/a9XBxDmYZdNmGhPqxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718177256; c=relaxed/simple;
	bh=zTjfoRI/IddVJ9kRhyEwz8hfAOpqCCZHbMwI6/oUXkU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OKPTQAdZUqpbU4kK5mtqbUt4vU73j6DNX4nv+4wgbb+4Y3YSGf9ogWiiz9Aj4+7e31UHbLMRtOBclEaqI0D6EWbksyqdllMethxFhXUjIBtqruQ3ih3Wo43NxCJAJ1/QjqrpVwT+5LvznoHQefQWqkw7A/0D/Z9S3HFwQ2khxSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=16gGM0Ww; arc=fail smtp.client-ip=40.107.102.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="16gGM0Ww"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7A8aWYrG1CljL0PRyoqMQzICC6OhUeFmIMqL1PDFYPFgdiOQ1JmpTUoM8YAMfgHLXT/GuxeQvk21VeLSWW03oK6f+YdAe6eY4BcpIdAg5K12gJ8wTB0HSGFXdJVb/sUNl50fWwRhopFC2xQ+0hTUSbSTvPEWKIZ/HZqrTgGzofWBiil6xqZT99soGGvR9C3sPjhgHQ9CPf3YOwJsqOQ2EipaQ33ZdQduoiyEP4Oj31vhnpWktgiT7yVxXe3vhp7oo6KiE5wiPtC+MLhvUtgvZnyEe/gB6tOOlYA6VgHkQhvcAqhp+lp7+RlOcJG2gw1kYv/9wXad4SJJk7uAnLhqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a27NYscq3J69JnZdXTgEyeutk40yMoHyvaz0AvRAEuc=;
 b=QivswVY35PAWnD9X93YJr6sJ1sGXUF60SGPuDufeRZUxWy5RSFbygqoLnXwwFGN4UKB1Hc7inYKeRGQ7pS5XV7297rmWhL39kT7UXNGDPumTjbaxWIU6XjJ9gotd4IgSK7+OTyYYsC++4Ea30BNyESaShwTFfLudlw7f/dAplsrxLquzEFrZI1fbOXW+vrJx8ZCvNiDhj5UZWjrD6frLwVWTuMNXDJwlLqj8uKcsD+e6jKkn/6INWOqSxArsM2Gpwxk3N2/jXVzHE/z2KPTgUrd/DWxd/2JNwsyv+smjILBjUE8Ehp1wXJhy2jjzRSBmq+e8ffmAq3SGEx4WkmCzTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a27NYscq3J69JnZdXTgEyeutk40yMoHyvaz0AvRAEuc=;
 b=16gGM0Wwb6WDxE/AwRXtZYwkOK8xK0BoAfuoOtbtOr8EhFe5heHra0E1o96LGKVC0Qi9aHV0DQaEk3hplAVDLhYZEpZoRDeM7gIWnRNFiJuISIpnCgeuhVrN02NBzW96d7kWnwkvoQ52LpU/Cfjx9jFhkkw/rXFmOdLX1vkdHZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 07:27:30 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 07:27:24 +0000
Message-ID: <5264583b-d9f4-e36f-4d6c-46bdd1344ce6@amd.com>
Date: Wed, 12 Jun 2024 08:27:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 08/13] cxl: add cxl_get_hpa_freespace
Content-Language: en-US
To: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 pieter.jansen-van-vuuren@amd.com, richard.hughes@amd.com,
 dinan.gunawardena@amd.com
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-9-alucerop@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240516081202.27023-9-alucerop@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0248.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::21) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: bcb0d13b-21e0-4533-5814-08dc8ab11a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDh1Q0twMEFCUm1QTERVZzBqaXFhOERFUlkxeTBGNWJyVVJxR2N1a2FEbXlh?=
 =?utf-8?B?WmxTNHN3cUxZMUNNVUE5NkQ3aDNsWm1rcWEyanNhQmNXOXoyK0hma3k5aHcv?=
 =?utf-8?B?eVlEMXpDWG50ejRQalhpUDJ1R1F3cTN1RHJMVWx4YTk0c2c5eVR6NjRUaDlE?=
 =?utf-8?B?TWJ6WWVwWjhNTDB0QmVRL3BJekxZMHNFWm5jc1p6OFR5MG9qY2Y5ZGtqc3p2?=
 =?utf-8?B?eVBWWlNGRmx3WndSNUE3NXdHdjd2c1BhOUFJTUlpQU42d25aTldzR0U0OVRv?=
 =?utf-8?B?TUFaQWR5Q08wS1FqbUd5VlBpcFVuOHd2M0l5YnYzNHhORHdDaER0Z05hNVpJ?=
 =?utf-8?B?SjBFZHQ2dENIc2xyOERiSEZGU1FTdWFBMHNBWGdNanF4eVIxNXE1NXVZcUoy?=
 =?utf-8?B?YkJ0S3JQNnBZQnhZWUpGVkxNQWVYTXdScUsvTWJZdEp1R2N1dEprUlpzdkJa?=
 =?utf-8?B?dm96MldIM1Q0TW1ERGpYcVdGZFNmeVB6WUdLNlhwcHRCY1V5VWJ2Q3ROYmF2?=
 =?utf-8?B?ZUlRTUREMjhhTXhiYXhIUGJQOFBSQUVPYzZHa01QMHlITHY0Q0hmZXFXS2hM?=
 =?utf-8?B?L3NwYUFtY0l3WFhYbDNQSFNmTld4L282TUU0VnpFQkt6WTJ0ME5HWC91Rk1X?=
 =?utf-8?B?c1RmK3RhQ3BLUXJGcS9rajNZV3cxa0VDWUtnUmdWWlByZStmMXUxb3RiU1Ni?=
 =?utf-8?B?aHRKcnJlYlFTR1V0MTJzK0xVb2UvUFJteW5MUkxLSUF3OWkrN2MvakZ1QmJt?=
 =?utf-8?B?VXdOOHoxejNoa1ZFK2dFQlhkb2pyWXo1VWVvazFmMXNjVWoyZHQ5Zy9RbUZH?=
 =?utf-8?B?aE1JVTA5V213cVIvcmlFVzRJTm9Ja2J2Nm5aVzhsdHd1T29OQW1DV01PemNW?=
 =?utf-8?B?TU4rVDR3RFlGMitZMWpVd1YwYk42VmhCYzFNVmFKV1psTjY1UXd3cWsvbkZW?=
 =?utf-8?B?bkxXckJoMHk1K2VVY3l0eGlsQlFOTzBxeE0wZ2VJWG1CMVI3bm1yUkRveGpC?=
 =?utf-8?B?ZE1oaUxmRG9IQzZvNitwTzhkMGM0KzZLanhxdzBHQjlEdm80ejlQVFA4MmZj?=
 =?utf-8?B?TzBpUlcyVU9mYkh1MHUvenRwSUtKRHNpZzZYRmFvMDFGQU8vem9OT2N5VTh5?=
 =?utf-8?B?UCt6UWlUb3VPdUYvT1hMVTMyUkVSRVdGK1dsZ2pTRVkxaUpReWN0emJGSERI?=
 =?utf-8?B?N1lLcStLNjZtdlg0b3dNeW1uNXpCcWxzNlQ3a1VpT3FUZTRIUVdmaWJtb1R2?=
 =?utf-8?B?dWV3YTMzZzFsYVMzL2NRTmhSSWs4Y2ViMmQ4b0Jud2NPSERkSWcvekg5V01q?=
 =?utf-8?B?RDVKbVgzQTlGeFU2RmpZZ0tzR25MMUxUQmtKaHVmdUpHMElqYXRRUUUrK2lR?=
 =?utf-8?B?OWo2S29GOXZ4dmZBTVNCbnVQTXVoVnhxNCtSUTVpc1ZUeXEyYzJXZjFwOW1t?=
 =?utf-8?B?eEY2VHdvdWZQVXovSytkeWVielBKVVloRFRuVHNoNXhXcE1VOXJjNUNpaHYw?=
 =?utf-8?B?NVNtYldYNTZuTG5RV2pGR1VKWTBTQXNoZWlad2lLaGVWckkva1lyMk1RcE5p?=
 =?utf-8?B?ak5BQk16NmJjWTJkNkQxdEFHMzlKRDBsQ3BFTkNxOUZkSFBPL1Ixa1F0bWlw?=
 =?utf-8?B?UXRtZ2E5dlpjc2NaYTh4ZTJzVjFiYzRlWmJNS1picXF5Q0x5UVdMdCtMSUtQ?=
 =?utf-8?Q?DV8S9QRbLqoK8IKdhG+p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEFZK1ZwYnh0aEg4L3NaRDY3NGcwTEQ4MFRlWkU5bURTSXRWQ2pxVzR6UWpR?=
 =?utf-8?B?K1BlYzlacmVKM3ZEcC95MzhLK0VYUUdKSEpidHZHUmd6ZEtUZmVueklDWC8y?=
 =?utf-8?B?OGVyaTJQZkl4UWNnYXI1TVJFaDdkTVZUOVh3aWZsMCtJVUh0SC9ZeW5xSTZK?=
 =?utf-8?B?WEY4d1VWRitheXFTRUhqOTdjdjFROU5pQ3RGWmFKQjZoejFwSjhUdnFESi9v?=
 =?utf-8?B?TmxSZDk1QmlBYWhxR1hVNkQ3V0NCd2ZFQlJPNkxUcnZXajdiTGVVUWhpWVNu?=
 =?utf-8?B?cldaVHJqKzgxY2FwRHUvYzN6MGpsQjhHOGdkaDRmK3VIanVkMTNRNXRGcElh?=
 =?utf-8?B?YkNFMXQ4RHpnaG5kcmNpYm5mclZFamp3WjVMd0VMNVlXMDBvRk1JcGoxNVNJ?=
 =?utf-8?B?YVZTbkdobjk3ZThvMnVJc2VxYU16bWJRU2xCNytUTXFJNk1IRVh4dU43L2lF?=
 =?utf-8?B?TEJRNk1OczhDTlVtWU5JeWZIR0dlRDJXM2ZhRVIyOXpIOS9GVGlwbmhDZGxv?=
 =?utf-8?B?NUp2WC95Um5nd0RLRFdUd2c5SlIrZHNLZG5rSGdKMzdpb0hPcGNQR29iZDJ2?=
 =?utf-8?B?N2dFMUN6a2lBTDVOeGE1V2wwdTE2Q2FaUnA1ZFh1ZCtXdndrc29EM0c4cjBK?=
 =?utf-8?B?RENhUUJaR3g1OXJ2T0hGN0t3c05uUEwrQkVzWGJvbGsybGcxUzcrdXp4b2Ez?=
 =?utf-8?B?VmVQUUhWU0JaWm9XOHF2djZqOVZaNE1hWjlFck5VOFU5M0RCRkR4SUM3ZzBZ?=
 =?utf-8?B?ZVNXNlNjaTBNc3dJS3d4TEZTQ2twMXp0QkZLSHJoMFUweVVEYnhyaFdQcU1H?=
 =?utf-8?B?R1ZBU1BPNW1rVThtR28vaEtvRGRBcmlVUXh4NVFxT2lhQjJMQ05XRUlZV0k0?=
 =?utf-8?B?SGQxN3pReXZrNHlXVkpSYkhjNmNOMlczTXhGdFk2NzZQRDZLWWs1VjMrS2Fq?=
 =?utf-8?B?c0xzZEVDNUNZNXY0WThxM1crMktxTFpoYm1zMjU2K0ttN3NsS1dRT2Y3R3gy?=
 =?utf-8?B?bmpWNG1NeG1yUS9mUmFIWTVuVTFrMEs5YTlETHp5UHlJMys4blR3aFIxL2hn?=
 =?utf-8?B?VmZvZWZJOFVEbTEyRlJiZitIWm9PSGNXcDNWRDNwNE1wSlRvb2ZPL3d4SjU3?=
 =?utf-8?B?NEJ1OWU5WDczMmpFSnJIRVFvbHM5SHNUcTRybWo2RDFJczA0SHQ3NGE1Szda?=
 =?utf-8?B?V2tYN3MvbWtpRHBGdDNwR1JyK25lOGkxOUpjdzdhRmE1LzN5VllnMk90cStN?=
 =?utf-8?B?SW5kTlMvbzVnZVZNNmswdklxS3dHbmxtRlpLT3RHYk1mYlJzR3Q3VEJ1b1R0?=
 =?utf-8?B?cU8xcnhGejRJVEpQbTB6ZUtmUTdzNzhoWkhYVHdXVkM2cmNtRDBRdnl1Y2pT?=
 =?utf-8?B?M3NWMXdHM2xJU0VaQjdqK25ZU3M5TW5zS29ETlgwc2pSMlE2Z0tNa2pCcDR2?=
 =?utf-8?B?ZHM3d3YrNHMwd0V0RmI3N3lkMFpINGV3ZmNjSTdDS1gya1VsbU5ZcWZyOGVT?=
 =?utf-8?B?elUwc2tXT09tVkI0UklyTUFMRUJoRnFVc1kzQk15cjFBVENEdlJ5c2w4NE1Q?=
 =?utf-8?B?WDVuUnJuTjM0RGllaEF6dGRETW9QVWt0YkVHb0lIdlUzUFJKL2ZSUzd1NnRX?=
 =?utf-8?B?bzhBcWF4ZE9HNkluRWhJa0NWWC9RemcyaC9BaHRoaGhDRUNUcllVTisyaUlQ?=
 =?utf-8?B?TG1HY2Rzb3FySEloVTgrbTR3REZ4eE1kaEZtdDdtT3hVY3g4WGRrYzUva3Zs?=
 =?utf-8?B?U2V5czZNdWVwYnVBdUF2QjRaVVNGV0pDYWk3SjRraTVrYkVXSU9wZXg0M2dW?=
 =?utf-8?B?d2YxZGlZSDFkZmxtWFNYd1RuZzV0a0dPSEtFS0FWYUFlcmxEeEdraFFrZVpB?=
 =?utf-8?B?OXpOdXFjV1FGaWVsamxBbkVDZms3bm5OSWI1d1UrU09DTEhnYUNFRUY4M1V1?=
 =?utf-8?B?NXN5UzVEb3U2MVZHQW9US0J0Vzh4d1poanNrbHdTb0RtR3pPTHYwaDZIMlVQ?=
 =?utf-8?B?ZjE4ejRsSmdQSUJjOUJOM1NvYkpBMVRzVDB2cisrSXNxbld2dStuZnVvcEdF?=
 =?utf-8?B?U1o3VkZyZU00RlZWTDBZQUd1enJaTnhTekc3ckJFYkVTK3BtNGZXVFNma2Vz?=
 =?utf-8?Q?XuIENXuW9DsF9/3zpdi7/5fHx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb0d13b-21e0-4533-5814-08dc8ab11a80
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 07:27:23.9413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bap8lBryTOfBCFqEPloaxu3jmUGw1yK9Aed6uT0uVOkt8V7c/n1mGzh5Ni2RSd5skRuMbjaFOBG72gDjA2ZSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446

From: Alejandro Lucero <alucerop@amd.com>

Based on the requirements from the endpoint and the topology such an
endpoint is attached to, this function informs about maximum host
physical address space possible to request. This is not a reservation
but only information which could change at the point the request based
on this information is made.

Based on: https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m6fbe775541da3cd477d65fa95c8acdc347345b4f

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>

On 5/16/24 09:11, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>
> Based on the requirements from the endpoint and the topology such an
> endpoint is attached to, this function informs about maximum host
> physical address space possible to request. This is not a reservation
> but only information which could change at the point the request based
> on this information is made.
>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/cxl/core/region.c           | 163 ++++++++++++++++++++++++++++
>   include/linux/cxl.h                 |   5 +
>   include/linux/cxlmem.h              |   5 +
>   tools/testing/cxl/type2/pci_type2.c |  23 +++-
>   4 files changed, 195 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 70e86a7c241d..2731fd4243a1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -702,6 +702,169 @@ static int free_hpa(struct cxl_region *cxlr)
>   	return 0;
>   }
>   
> +
> +struct cxlrd_max_context {
> +	struct device * const *host_bridges;
> +	int interleave_ways;
> +	unsigned long flags;
> +	resource_size_t max_hpa;
> +	struct cxl_root_decoder *cxlrd;
> +};
> +
> +static int find_max_hpa(struct device *dev, void *data)
> +{
> +	struct cxlrd_max_context *ctx = data;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct resource *res, *prev;
> +	struct cxl_decoder *cxld;
> +	resource_size_t max;
> +	int found;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	cxld = &cxlrd->cxlsd.cxld;
> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
> +		dev_dbg(dev, "find_max_hpa, flags not matching: %08lx vs %08lx\n",
> +			      cxld->flags, ctx->flags);
> +		return 0;
> +	}
> +
> +	/* A Host bridge could have more interleave ways than an
> +	 * endpoint, couldn´t it?
> +	 *
> +	 * What does interleave ways mean here in terms of the requestor?
> +	 * Why the FFMWS has 0 interleave ways but root port has 1?
> +	 */
> +	if (cxld->interleave_ways != ctx->interleave_ways) {
> +		dev_dbg(dev, "find_max_hpa, interleave_ways  not matching\n");
> +		return 0;
> +	}
> +
> +	cxlsd = &cxlrd->cxlsd;
> +
> +	guard(rwsem_read)(&cxl_region_rwsem);
> +	found = 0;
> +	for (int i = 0; i < ctx->interleave_ways; i++)
> +		for (int j = 0; j < ctx->interleave_ways; j++)
> +			if (ctx->host_bridges[i] ==
> +					cxlsd->target[j]->dport_dev) {
> +				found++;
> +				break;
> +			}
> +
> +	if (found != ctx->interleave_ways) {
> +		dev_dbg(dev, "find_max_hpa, no interleave_ways found\n");
> +		return 0;
> +	}
> +
> +	/*
> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
> +	 * preclude sibling arrival/departure and find the largest free space
> +	 * gap.
> +	 */
> +	lockdep_assert_held_read(&cxl_region_rwsem);
> +	max = 0;
> +	res = cxlrd->res->child;
> +	if (!res)
> +		max = resource_size(cxlrd->res);
> +	else
> +		max = 0;
> +
> +	for (prev = NULL; res; prev = res, res = res->sibling) {
> +		struct resource *next = res->sibling;
> +		resource_size_t free = 0;
> +
> +		if (!prev && res->start > cxlrd->res->start) {
> +			free = res->start - cxlrd->res->start;
> +			max = max(free, max);
> +		}
> +		if (prev && res->start > prev->end + 1) {
> +			free = res->start - prev->end + 1;
> +			max = max(free, max);
> +		}
> +		if (next && res->end + 1 < next->start) {
> +			free = next->start - res->end + 1;
> +			max = max(free, max);
> +		}
> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
> +			free = cxlrd->res->end + 1 - res->end + 1;
> +			max = max(free, max);
> +		}
> +	}
> +
> +	if (max > ctx->max_hpa) {
> +		if (ctx->cxlrd)
> +			put_device(CXLRD_DEV(ctx->cxlrd));
> +		get_device(CXLRD_DEV(cxlrd));
> +		ctx->cxlrd = cxlrd;
> +		ctx->max_hpa = max;
> +		dev_info(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", &max);
> +	}
> +	return 0;
> +}
> +
> +/**
> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
> + * @endpoint: an endpoint that is mapped by the returned decoder
> + * @host_bridges: array of host-bridges that the decoder must interleave
> + * @interleave_ways: number of entries in @host_bridges
> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
> + * @max: output parameter of bytes available in the returned decoder
> + *
> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available (@max)'
> + * is a point in time snapshot. If by the time the caller goes to use this root
> + * decoder's capacity the capacity is reduced then caller needs to loop and
> + * retry.
> + *
> + * The returned root decoder has an elevated reference count that needs to be
> + * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
> + * cxl_{acquire,release}_endpoint(), that ensures removal of the root decoder
> + * does not race.
> + */
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
> +					       struct device *const *host_bridges,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max)
> +{
> +
> +	struct cxlrd_max_context ctx = {
> +		.host_bridges = host_bridges,
> +		.interleave_ways = interleave_ways,
> +		.flags = flags,
> +	};
> +	struct cxl_port *root_port;
> +	struct cxl_root *root;
> +
> +	if (!is_cxl_endpoint(endpoint)) {
> +		dev_dbg(&endpoint->dev, "hpa requestor is not an endpointr\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	root = find_cxl_root(endpoint);
> +	if (!root) {
> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	root_port = &root->port;
> +	down_read(&cxl_region_rwsem);
> +	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
> +	up_read(&cxl_region_rwsem);
> +	put_device(&root_port->dev);
> +
> +	if (!ctx.cxlrd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*max = ctx.max_hpa;
> +	return ctx.cxlrd;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, CXL);
> +
> +
>   static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>   			  const char *buf, size_t len)
>   {
> diff --git a/include/linux/cxl.h b/include/linux/cxl.h
> index 036d17db68e0..1b2377062693 100644
> --- a/include/linux/cxl.h
> +++ b/include/linux/cxl.h
> @@ -766,6 +766,11 @@ struct cxl_decoder *to_cxl_decoder(struct device *dev);
>   struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>   struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>   struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
> +
> +#define CXLED_DEV(cxled)  &cxled->cxld.dev
> +
> +#define CXLRD_DEV(cxlrd) &cxlrd->cxlsd.cxld.dev
> +
>   bool is_root_decoder(struct device *dev);
>   bool is_switch_decoder(struct device *dev);
>   bool is_endpoint_decoder(struct device *dev);
> diff --git a/include/linux/cxlmem.h b/include/linux/cxlmem.h
> index 11fe8367b046..342ccd5486d3 100644
> --- a/include/linux/cxlmem.h
> +++ b/include/linux/cxlmem.h
> @@ -865,4 +865,9 @@ struct dentry *cxl_debugfs_create_dir(const char *dir);
>   void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
>   
>   struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
> +					   struct device *const *host_bridges,
> +					   int interleave_ways,
> +					   unsigned long flags,
> +					   resource_size_t *max);
>   #endif /* __CXL_MEM_H__ */
> diff --git a/tools/testing/cxl/type2/pci_type2.c b/tools/testing/cxl/type2/pci_type2.c
> index 948cc95c5780..deb5eeae501b 100644
> --- a/tools/testing/cxl/type2/pci_type2.c
> +++ b/tools/testing/cxl/type2/pci_type2.c
> @@ -4,6 +4,7 @@
>   #include <linux/cxlpci.h>
>   #include <linux/cxlmem.h>
>   
> +struct cxl_root_decoder *cxlrd;
>   struct cxl_dev_state *cxlds;
>   struct cxl_memdev *cxlmd;
>   struct cxl_port *endpoint;
> @@ -15,6 +16,7 @@ static int type2_pci_probe(struct pci_dev *pci_dev,
>   
>   {
>   	struct cxl_register_map map;
> +	resource_size_t max = 0;
>   	u16 dvsec;
>   	int rc;
>   
> @@ -79,9 +81,28 @@ static int type2_pci_probe(struct pci_dev *pci_dev,
>   		return PTR_ERR(endpoint);
>   	}
>   
> +	pci_info(pci_dev, "cxl hpa_freespace...");
> +	cxlrd = cxl_get_hpa_freespace(endpoint, &endpoint->host_bridge, 1,
> +				      CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
> +				      &max);
> +
> +	if (IS_ERR(cxlrd)) {
> +		dev_dbg(&pci_dev->dev, "cxl_get_hpa_freespace failed\n");
> +		rc = PTR_ERR(cxlrd);
> +		goto out;
> +	}
> +
> +	if (max < CXL_TYPE2_MEM_SIZE) {
> +		dev_dbg(&pci_dev->dev, "%s: no enough free HPA space %llu < %u\n",
> +				       __func__, max, CXL_TYPE2_MEM_SIZE);
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
> +out:
>   	cxl_release_endpoint(cxlmd, endpoint);
>   
> -	return 0;
> +	return rc;
>   }
>   
>   static void type2_pci_remove(struct pci_dev *pci_dev)
