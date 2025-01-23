Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A38F4F1
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737647731; cv=fail; b=eoFi78c4cEjqiViEN2t5KyW8r826vjQ2jWQjm1n1rye8clx3I9IPAWQeNLWWd7FMdpwXky9m4gKVppQSWpc+kgCmrf0NYFNl9bEFO2RBgZn+sVPrB6qcHgECzpI9SEbn44WpU5co1cYtkPQJ3NwyXKGlxwaKwiPUgZnJqdHQiRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737647731; c=relaxed/simple;
	bh=x/7NkYK3z7GLVQ8jLRmfTUZ04Td2huIkctfmJqJZzjg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KjCS+PvyVzSnozxlwDIuweO6/xMZFgzWc/+dEXv/6OB8QbijQaVcA26XwmxmyCir2kccfJIbQIDldjkBtf2ywMPM6LmbCcoEv4mPQx6FfAtbor5/BZOPCR4LojbLVATG8xLWhVTzi0Wz4NRKsFt3N367Dz0yd5a7dC0us5/h13I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kdPPDRW5; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kdPPDRW5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpJ67p+R5hwh6lWAS0yVotuYWcfOG5Xos8XRsmfRfbwawCTUQMh724cF1CTjRfFCftVXVyqk8BocP30p31hTJSodmjh8kiay3FuMNclbPWH+TjD5qjat3vcznvvqUWE/mqk6ibPvmAbo/cRcSNXNzKbUAn+KIOIMqbuMNAsyyzSFgt5xBub4X/DySpLKqSkVhxDBDou+9lv9GJN20oxWuTd+o1PPGceUOIG4gF9q+ql1Rwr5Ot7/oUY6MsCNZAgq5kMey2ADc/3a4x2llFgJ4bvJjYoqBLBN4Wv0q4TUKWvteiFe2UMHxAlQsHz5mHRPZ81KZuKFsuBajDd2503ceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GHLgANVDtn4gNXawGez8S/bwEv5pnvKRqS/lKk1hrY=;
 b=QMQKXde091WOuiaFEwgkidmvSU3m4J2v33eE0t7vTvzlzhJtDKrQEjj5uCgJGoqi03VulMYB2CU/HursigO2S6WxhUkQqDrSFbVFH8Yotyr5EF/7F605xneZ52lYGSHJYepW3okRGGM5jwgUC/Y8rW22NalpWLNEr27bmLgPt7VBfSuiYRUoCGIMjL4vIhSYMfyUbuN7jGTBEq2lJXjjRvKBn2IY5Z+fTjEwWW7+aub4mdyKpMEzUBYgoTqei3okON8ALaj1fBxlSWevrYfFvKpahbOZcNhLzWnBCqouxdrTfSek/1cEA0ABC8ORFj6W6lBU+Ckx6aVCAWEWWMcQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GHLgANVDtn4gNXawGez8S/bwEv5pnvKRqS/lKk1hrY=;
 b=kdPPDRW5xgYjNGWKvMkD7HKtwtEW3QrcxyoQLKP5wPigqAsH0Tpamposj5BS0T7pX1wca10mqc9Jy9aBewqno75MLEWK7F2Tdg8bHmhlsYrQhwiHoiwJly9BUALQlMcYOCvih8poWNdJZ0Ajl7+hjMWRLDkq0AMrEI9LUplfgcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by IA1PR12MB8310.namprd12.prod.outlook.com (2603:10b6:208:3ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 15:55:26 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e%7]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 15:55:26 +0000
Message-ID: <86c94cac-7fd4-4e5e-8c16-6935dcd2ea1a@amd.com>
Date: Thu, 23 Jan 2025 09:55:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] kernel/resource: Introduce managed SOFT RESERVED
 resources
To: Fan Ni <nifan.cxl@gmail.com>, Nathan Fontenot <nathan.fontenot@amd.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 alison.schofield@intel.com, linux-mm@kvack.org, gourry@gourry.net
References: <cover.1737046620.git.nathan.fontenot@amd.com>
 <1800b17449d1c231292c85f59b226aff39a81552.1737046620.git.nathan.fontenot@amd.com>
 <Z5CHsFgDnrUT789g@gpd>
Content-Language: en-US
From: "Fontenot, Nathan" <nafonten@amd.com>
In-Reply-To: <Z5CHsFgDnrUT789g@gpd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::7) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|IA1PR12MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: a019e0b9-4551-4967-cf1d-08dd3bc65a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2xqMnVuMWdSaHE2ZDdHN00xQ28yS1VCUFhYa2ZjZDdPS2FKdW1PSFVoeWtN?=
 =?utf-8?B?Y3FQZ3RrR2NnZE5Xa0pXdU1GZVY5K2J5Tkg2cFdGZFdMMGxsQjJ1YW5rMkF5?=
 =?utf-8?B?L2JhNGdYQ014SXRoVTk2WHJoaGZwNGdGVHVrM2luRFhSRStRZitaU25Sc1lB?=
 =?utf-8?B?QUFPVUNDRS92YVZLMDVpLytCREpZQnV1d3pGY0E4YWxyUjBCcWJ6YmVBVm0x?=
 =?utf-8?B?MWU1UUcrdHVVeFNlUGQ2dzZQUUlXUXc4amJyT2J6bnRDVXQra1N1MzQ3cXNI?=
 =?utf-8?B?Qkx6QzR2Q3QwSHJyWktXajQvN0JrTjhxNGt0RXRNQ2dUNkRYM2t0c1AraHNT?=
 =?utf-8?B?aWNUalh5VjUrTE1VaFhkWUttaEVqTjZ3b2JjV2NHL2toeStrVnlBQVNCbEZ3?=
 =?utf-8?B?K1pMSFBRdXVZUW9zMjRmRkQ0Ylpvclh3Mjlab0UvdlBMQ2tPdjdKc3NTd0dX?=
 =?utf-8?B?eUNJOVFLcFpvbHFFQzhHY28vTVlQMDA0MFRJenc5UVlEQzRvYmhKOFFXVUFa?=
 =?utf-8?B?Y25yK3pZUmtHbVR2bEN4VDhsQmV2UG9zWjhBSmlNMGdHd1VLRjh2TUV2dWV4?=
 =?utf-8?B?WGhsc1pCMENJNzAzanpyNmxWblBDczJLUi8zK040M1NmWTBJWmhvcGJQSjRs?=
 =?utf-8?B?eFV4UEowQmpIK2p0a21jQUFoaVNyLzhNbHV0ekVRK2xMVHovM1dlU3VPSy96?=
 =?utf-8?B?Mk5adGQ5eG0xeXp3dC9PdTJ0MVdhN0VMbXNxRzV2TVNmQ3JaeGl0SXpNUUl4?=
 =?utf-8?B?VEdoK3hyMVVOa0FSMEJhSXJydElNVCtNd2NZNzNBUkVIRWdaNXIzYWx0WnNo?=
 =?utf-8?B?TS9SRktIVUladGEwQzhONk9UVE41VXM5aHU4SkhiaVpUa1VrT0YrMnh5RXBT?=
 =?utf-8?B?QzFvNXFmUncyQ1NpdlJDS2dyK0pIMDNTMG84ZUovRnlJbDNJektWK0hXalds?=
 =?utf-8?B?elA5SFZwWTUwVFVCcW9oRXNURDlCWklKQkVVV29odkVKYXp2eERHZno4RDBP?=
 =?utf-8?B?U0NoTEFkdlRzOGk4TzZsbEgxNmFvT2JqZzJxTllLQTZxNmUwRCtvZWg1ZHRG?=
 =?utf-8?B?ZmxyYldOTHhRK3FVck12cGpiRmJmT2kzVUNqN1Z6eWYzL0J4QlMzNlB5MXpr?=
 =?utf-8?B?STZwTkVINGlMczdSTXNXelQyNkFpVVVnT21NWGkxTHhQeHNYT09TcElMRXpv?=
 =?utf-8?B?eE4vbzJXOXEvN1BiQzIyY2NTa2tTdTl2VUJpZk4zYlpqVW94YUdWVTVncmRL?=
 =?utf-8?B?dXR3c202a0ZQZW85MU0zM2doOHdFVWM2dWc1WjVEM3hKZk4xVW5vSzN0K0RY?=
 =?utf-8?B?OEFReWxkQjdQelhuOEJkRHF6VzVTM2hpWG5GYjY4RVMzMFNDMnZ3OUVFTkVB?=
 =?utf-8?B?Q2Fzdnh4MlBlK0lHVkpMbWJmeGt2UjF5Wm95aXRWWWxoaGpEN1p3blhZcy91?=
 =?utf-8?B?dXNzc3YvaWJDcTdwb1VYSjZUNlVwRlZXK2lBQVZKZ3pqdHVFenNieG1lbjNa?=
 =?utf-8?B?OFMrYnlHQUN1ZzdrLzdrcEFDa2liSzFxeWRuMjFic25PQWY0OFJTWlpGODVQ?=
 =?utf-8?B?NkxOQ1luNkh0K1FLSSt2b2ZyQjQydDJ4UXRwRVZVeEthSXY0WmVIeVp0M1RL?=
 =?utf-8?B?cFBvNDZpU05nUkVaYWp5Z0ZHUHJnS252MVh5eFJLN0RocmJyQ0pxaUdVU3Fn?=
 =?utf-8?B?QmdmK2U1SkhCWFFBK1grM0Y3clBaUTJZaHpQbTlVVVNUL1ZrdnNMbW1JUFk1?=
 =?utf-8?B?M25oUlhNazl0SXZaR2NWQlYyRGp3MXBta3JoTno3ZnJReGJ2MThMdVNyalFL?=
 =?utf-8?B?S29ZdEwyTGNUU0cwYWdldGtpVVNla01OYW4zb2tUbkJIdHAyeXJLZmttZGM3?=
 =?utf-8?Q?+pKVXWTaFCf1E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REVjSHdhWUluK0h2NVZHUy9GaXZWL0k3WXZvdFBYdVY1cTA5dGxLWFdjRUp3?=
 =?utf-8?B?VTJsRGo1YUZPYUZLR2JQL0lNZSs5WE1IcU00UnI1SkJOcU54UEViNXozdzlj?=
 =?utf-8?B?V2VOT0Z6ZGZRWFRkREVMT3B3cWYrSCs5MjBMeExyZXZzOW8xaFlIdytnVUxm?=
 =?utf-8?B?ZzZXaWZ1UzZ5MXFLUVJEVEdJK3c0cml3MVdNckp0b1FoMTBnQ21oQjdWWUcw?=
 =?utf-8?B?Y0NrWUcvUVZQOWdTWEtXYlBRdzFRbEhyR1UrUnRldjYxaW44Z01ka3VlZkpZ?=
 =?utf-8?B?cVJoRmV0TytyMTMzMFBXVHorSHp2clVYTzhmbWczcitlVW1PWWhTOS9raTkz?=
 =?utf-8?B?bGhKRE13U2Jud3FRQWdhS1p1c05WTk1halNaWjVPN1Q5OG5xOHVTVHkyZ0hv?=
 =?utf-8?B?L0NaZTFZWGtaVDJOR0pBQXd4akR4dWtXWGJFVnh1VE11N0RidmExK044MWt3?=
 =?utf-8?B?YVVFWlhBSjNYczRmTjlqNGtpZDBteFZ0SERUZGtvNGN5N1VwUmkyWmNibkt0?=
 =?utf-8?B?Nm5tVVRmOUdXOUhjZ3kwSjZCbDE2eHhFTXhFZ2huSENKdjFpWFBDSjJOMXQz?=
 =?utf-8?B?UE45cSt6MzlOeHlwUHZtR21nV0xtVUhMQ1lZUlhzYWg3TXorZEQwUDU2Um1u?=
 =?utf-8?B?Ym81VWFXZU1HaU9TOWxLWURESFlMdjNScDNLU3puY1lKWVpVcHNodnpGeS9h?=
 =?utf-8?B?UGtVV0dOUkpvdVZ1bkJMamw3ekpnbWQ4Z0VrOUEzUzVpSzc0MDlISWFnekF1?=
 =?utf-8?B?L2V3RThnUHBuWTZPSWcwb2FIWGhFUUFhN2ZsZDJ3WkxBWmkvOXhvTFYwNXo3?=
 =?utf-8?B?Ry9FenU3eExUS2JIWVNmS0p1VFdIK2EwNGkraVhjTzUzTzlsZkQ5QW4yYUNz?=
 =?utf-8?B?aFc1bjhQTEFuc0w2Um1KY0hTcjBhZ0tnVWVjL0QzdlFlem9FMTZsdXozSUV1?=
 =?utf-8?B?MkdTa1l6NXVmM0M1K2twRHY5Y3ArMDhUcE5CeG84elNOZG0vM0VSWUoxRE82?=
 =?utf-8?B?dmNZNEwvbVFqVllCWFd4d2doZGpRTUZJRzYzZVRrZEV4S2JNOUFOaGpCNWJP?=
 =?utf-8?B?emxkem5yU2k1ZjlrTEFjR29PamE5V0pHV0wvckFoZFZ5QThuQVYzY0YwOTRQ?=
 =?utf-8?B?OFpIZlpLUU1OcFhKTHBDVHdMa0VxUzduWTNWLzRJODJjTW40V0toN0EyaEIx?=
 =?utf-8?B?cysyUHFjRHk5K0tJNTFSOHFCWVRPMUEvV0RHcEd5cDJxbjZaV0tmTm5GVjRS?=
 =?utf-8?B?RC9lVXV6Zlo1ZkRrMVk3UldtZHNpUWp5MGF6dWo5a1g3aWxBaHdER3FmdnRj?=
 =?utf-8?B?Z21UZXZONWFHU2l4bDFjY1dtT29INldJbXhKWEFFeVNQRWtIbWxzVkNlcVIv?=
 =?utf-8?B?UEtMc3VXenQ5OCtMRnBYajFCUFFHVUhwQXNkS1B6SjdpS2U1b0h6WGlMeGk3?=
 =?utf-8?B?RTlOZUY2RW5XYkhqeVlYZE1mV21VNTIyWEFJN2F1MGNkcGNMendPSnFlMTdT?=
 =?utf-8?B?bjdzc0ZXYU1FVCtNekRBRVA4cmMvclVsTUJ0cW9jOGQ3SGlmQlNnczNsS3BG?=
 =?utf-8?B?N3hsQnBuc1pGVzNUY2tBd3JKNnlCTnNKRzZVcFBuRWJxUHRzRGt4YnpYOFI2?=
 =?utf-8?B?cnNpU0hvODF1d1oxNXVZVmZEVkV3WWFMRWo3VzBKU004V0h2ZWtnbXVvSkNH?=
 =?utf-8?B?Uy9OWTkxSnQ1VWl2Z29GaEwrUDJGVXZScW9JT1Nnam92OXlrbXNKZFp3SnZz?=
 =?utf-8?B?ZkFzSStNUzlCV05ZcHZDRXh4aXVPWWROS05mQ2Z4QnRFNFNKeUNUMVZXVW9F?=
 =?utf-8?B?QUp2M1JMSkdOUTYvTDVHK295OWRCRFg1VXJ0VXF1ZG1naWg3dnJudkdDbXpZ?=
 =?utf-8?B?TW02YytoNUk1eE5lb0hBdTBWZDluVHpXbUJGQVoxMklnM3FWUHpkcG05MHU1?=
 =?utf-8?B?ZSt2aE96c3hKd1l6SFQydldaWGYzWSt6Zk5JeEk5TzRBZXY4UU55RUNmcWVm?=
 =?utf-8?B?ZVNSQm1ybjZjSjFKOWJPMFF4ZFFDa01ibTBmS1ZJbHNTdnNZUjh0dERlcnJo?=
 =?utf-8?B?MkRka3U4V0I4SlMzelR1MGFaV2cxMWs5SDlyRTQvY1B2Y3J4SllaeDZFSEoz?=
 =?utf-8?Q?Hb0QiIr58hg5icmiV8KJi7oNw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a019e0b9-4551-4967-cf1d-08dd3bc65a90
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 15:55:26.6567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44IThXhDGXD1R7p/1Xz5XQ8kKI/y4iPce9EdDUuFXg/kYgedkntspLPCsqjtcaDv7OSn3aas7OjxZQo4h8oGJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8310

On 1/21/2025 11:52 PM, Fan Ni wrote:
> On Thu, Jan 16, 2025 at 11:42:05AM -0600, Nathan Fontenot wrote:
>> Introduce the ability to manage SOFT RESERVED kernel resources prior to
>> these resources being  placed in the iomem resource tree. This provides
>> the ability for drivers to update SOFT RESERVED resources that intersect
>> with their memory resources.
>>
>> During boot, any resources marked as IORES_DESC_SOFT_RESERVED are placed
>> on the soft reserve resource tree. Once boot completes all resources
>> are placed on the iomem resource tree. This behavior is gated by a new
>> kernel option CONFIG_SOFT_RESERVED_MANAGED.
>>
>> As part of this update two new interfaces are added for management of
>> the SOFT RESERVED resources. The release_srmem_region_adjustable()
>> routine allows for removing pieces of SOFT RESERVED resources. The
>> the merge_srmem_resources() allows drivers to merge any remaining SOFT
>> RESERVED resources into the iomem resource tree once updatea are complete.
>>
>> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
>> ---
>>  include/linux/ioport.h |  9 +++++
>>  kernel/resource.c      | 79 +++++++++++++++++++++++++++++++++++++++---
>>  lib/Kconfig            |  4 +++
>>  3 files changed, 87 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>> index 6e9fb667a1c5..2c95cf0be45e 100644
>> --- a/include/linux/ioport.h
>> +++ b/include/linux/ioport.h
>> @@ -249,6 +249,15 @@ struct resource *lookup_resource(struct resource *root, resource_size_t start);
>>  int adjust_resource(struct resource *res, resource_size_t start,
>>  		    resource_size_t size);
>>  resource_size_t resource_alignment(struct resource *res);
>> +
>> +#ifdef CONFIG_SOFT_RESERVED_MANAGED
>> +void merge_srmem_resources(void);
>> +extern void release_srmem_region_adjustable(resource_size_t start,
>> +					    resource_size_t size);
>> +#else
>> +static inline void merge_srmem_resources(void) { }
>> +#endif
>> +
>>  static inline resource_size_t resource_size(const struct resource *res)
>>  {
>>  	return res->end - res->start + 1;
>> diff --git a/kernel/resource.c b/kernel/resource.c
>> index a83040fde236..9db420078a3f 100644
>> --- a/kernel/resource.c
>> +++ b/kernel/resource.c
>> @@ -48,6 +48,14 @@ struct resource iomem_resource = {
>>  };
>>  EXPORT_SYMBOL(iomem_resource);
>>  
>> +static struct resource srmem_resource = {
>> +	.name	= "Soft Reserved mem",
>> +	.start	= 0,
>> +	.end	= -1,
>> +	.flags	= IORESOURCE_MEM,
>> +	.desc	= IORES_DESC_SOFT_RESERVED,
>> +};
>> +
>>  static DEFINE_RWLOCK(resource_lock);
>>  
>>  static struct resource *next_resource(struct resource *p, bool skip_children)
>> @@ -818,6 +826,19 @@ static struct resource * __insert_resource(struct resource *parent, struct resou
>>  {
>>  	struct resource *first, *next;
>>  
>> +	if (IS_ENABLED(CONFIG_SOFT_RESERVED_MANAGED)) {
>> +		/*
>> +		 * During boot SOFT RESERVED resources are placed on the srmem
>> +		 * resource tree. These resources may be updated later in boot,
>> +		 * for example see the CXL driver, prior to being merged into
>> +		 * the iomem resource tree.
>> +		 */
>> +		if (system_state < SYSTEM_RUNNING &&
>> +		    parent == &iomem_resource &&
>> +		    new->desc == IORES_DESC_SOFT_RESERVED)
>> +			parent = &srmem_resource;
>> +	}
>> +
>>  	for (;; parent = first) {
>>  		first = __request_resource(parent, new);
>>  		if (!first)
>> @@ -1336,11 +1357,12 @@ void __release_region(struct resource *parent, resource_size_t start,
>>  }
>>  EXPORT_SYMBOL(__release_region);
>>  
>> -#ifdef CONFIG_MEMORY_HOTREMOVE
> 
> If CONFIG_MEMORY_HOTREMOVE not defined, it seems we do not have a
> user for release_region_adjustable as
> release_mem_region_adjustable() will not exist.

The release_region_adjustable() routine is used by by release_mem_region_adjustable()
and release_srmem_region_adjustable(). We could put the following around
release_region_adjustable() to prevent it being present when not used.

#if defined(CONFIG_MEMORY_HOTREMOVE) || defined(CONFIG_SOFT_RESERVED_MANAGED)

-Nathan

> 
> Fan
>>  /**
>> - * release_mem_region_adjustable - release a previously reserved memory region
>> + * release_region_adjustable - release a previously reserved memory region
>> + * @parent: resource tree to release resource from
>>   * @start: resource start address
>>   * @size: resource region size
>> + * @busy_check: check for IORESOURCE_BUSY
>>   *
>>   * This interface is intended for memory hot-delete.  The requested region
>>   * is released from a currently busy memory resource.  The requested region
>> @@ -1356,9 +1378,11 @@ EXPORT_SYMBOL(__release_region);
>>   *   assumes that all children remain in the lower address entry for
>>   *   simplicity.  Enhance this logic when necessary.
>>   */
>> -void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
>> +static void release_region_adjustable(struct resource *parent,
>> +				      resource_size_t start,
>> +				      resource_size_t size,
>> +				      bool busy_check)
>>  {
>> -	struct resource *parent = &iomem_resource;
>>  	struct resource *new_res = NULL;
>>  	bool alloc_nofail = false;
>>  	struct resource **p;
>> @@ -1395,7 +1419,7 @@ void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
>>  		if (!(res->flags & IORESOURCE_MEM))
>>  			break;
>>  
>> -		if (!(res->flags & IORESOURCE_BUSY)) {
>> +		if (busy_check && !(res->flags & IORESOURCE_BUSY)) {
>>  			p = &res->child;
>>  			continue;
>>  		}
>> @@ -1445,6 +1469,51 @@ void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
>>  	write_unlock(&resource_lock);
>>  	free_resource(new_res);
>>  }
>> +
>> +#ifdef CONFIG_SOFT_RESERVED_MANAGED
>> +/**
>> + * merge_srmem_resources - merge srmem resources into the iomem resource tree
>> + *
>> + * This is intended to allow kernel drivers that manage the SOFT RESERVED
>> + * resources to merge any remaining resources into the iomem resource tree
>> + * once any updates have been made.
>> + */
>> +void merge_srmem_resources(void)
>> +{
>> +	struct resource *res, *next;
>> +	int rc;
>> +
>> +	for (res = srmem_resource.child; res; res = next) {
>> +		next = next_resource(res, true);
>> +
>> +		write_lock(&resource_lock);
>> +
>> +		if (WARN_ON(__release_resource(res, true))) {
>> +			write_unlock(&resource_lock);
>> +			continue;
>> +		}
>> +
>> +		if (WARN_ON(__insert_resource(&iomem_resource, res)))
>> +			__insert_resource(&srmem_resource, res);
>> +
>> +		write_unlock(&resource_lock);
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(merge_srmem_resources);
>> +
>> +void release_srmem_region_adjustable(resource_size_t start,
>> +				     resource_size_t size)
>> +{
>> +	release_region_adjustable(&srmem_resource, start, size, false);
>> +}
>> +EXPORT_SYMBOL(release_srmem_region_adjustable);
>> +#endif
>> +
>> +#ifdef CONFIG_MEMORY_HOTREMOVE
>> +void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
>> +{
>> +	release_region_adjustable(&iomem_resource, start, size, true);
>> +}
>>  #endif	/* CONFIG_MEMORY_HOTREMOVE */
>>  
>>  #ifdef CONFIG_MEMORY_HOTPLUG
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index b38849af6f13..4f4011334051 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -777,3 +777,7 @@ config POLYNOMIAL
>>  
>>  config FIRMWARE_TABLE
>>  	bool
>> +
>> +config SOFT_RESERVED_MANAGED
>> +	bool
>> +	default n
>> -- 
>> 2.43.0
>>

