Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD8D27CCDB
	for <linux-cxl@vger.kernel.org>; Wed, 11 Jun 2025 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749667326; cv=fail; b=irssGx8pRdAbRUETDYcBuFLI2T3ipn2XSNRvPv9szJJ0JfNHpH/92laF/zUSB7pyKBeNuvqMei+pUjGH8OIalF67YI3qSmEfWYxD2m7J2wl+F/HuZqwT6Eq7LAaen/P6ejCQviPjV+tWG+uznexUIfFGgJRgtKH73bPlosUEnFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749667326; c=relaxed/simple;
	bh=kjblrQ+OgyhicG/ATr0UzXxQIRdjCqWN1xe4/T/rVUI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sD0VjoaaL4tC2LtfFNWwcYwGs5pt8Y8dcN9AyXbw/Spqm4cuyVDjZswBeFaO2KXN7XhHz7MdhUxxyncfZ22z3tcE1nvANLFAskwUVNo4S17mjtKl/hZPoEqZebX0qobelTGwewCeVTXOWNI60Wrm3kUhpUKqzmcMyaEAxRxSQsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rc7rFGGg; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rc7rFGGg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b53IuIjm6adLJc0i4i7ZDV/5AKKp6cW557XswRWPUrbElNJL+y3UlwBgMlvEOQjPVzZdVlayHlGqNm85r7Gp2TAeWf4Ww3BYl+vooMvTzNFAiUPqZ08q1k+KrAG9mbyBFXaSfOxxMVT13xJvFQfgDaDgxAiVdcwVjtrbSn0ynCFWeR/3CEwhBACw4FCNByoYjpUQrzHo9oOoVPkHEQ07EycFMV3eBL2Mok0XSPYZeCy8C51Hoe1dQQ2G7nm1oBSN1n4RVqedbx0PIiBYA3j2CMjHGfUEJ4iybMj+Q+wgEePK4MxEz8OnZmoGCufsM22V6iiRLHwPzn3u70G6TiAzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4xUz4K0i/ffJ09UCRkmsf97PRVOErGXGQ/nSJu/65k=;
 b=Zf9TJS5lx9fOv6F+lhYnzq6SzXYJ2oHXaBPgS4gTyjgA3GdABwhUJLRkdjU8rnkfrlcsWWEu94S1i0GHcAY04lV51FTt++a5WdzrVWvvLTSDF1Fj5p+BwnlRzk/MOng9GVP9Xwxxlms4UHmzhgqDJlU5xMQ5LwMRXANKf+ntMgCbAPhweioTx48yzejxrBImQhZflcXHL8YX1aCmYMHiQrKXNEn5IlJiWf2mkCCk361A7mHASJUYrdoDO+JTOoaf+T01x9WqaKSxFzRuq+UaHDy52OlyR8xUfvOT/7cUNa7Zaz/zkzNFLLkUa2+yMwTwAzNxEY3GhP3oWeFV+yg9og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4xUz4K0i/ffJ09UCRkmsf97PRVOErGXGQ/nSJu/65k=;
 b=rc7rFGGg2GMZ89O5IzfaB8blqspjlW1/508KSZ+Wa/yUvOF9PRW03Uc+Mry9eL1ZOeqGsTh6FQbx6YGjylEqa1xoTBAnAO2b481Zg+NBAwSwgj9MFnSaaT8EkBkBgj6/jIe1CiOnlgbnGjCFfCFv/y6RJqzhWS2InkhRBNttoKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by SA1PR12MB8164.namprd12.prod.outlook.com (2603:10b6:806:338::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 18:42:01 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%3]) with mapi id 15.20.8792.038; Wed, 11 Jun 2025
 18:42:00 +0000
Message-ID: <29a1c1fe-f8dd-43d9-bedd-3e0139a71732@amd.com>
Date: Wed, 11 Jun 2025 11:41:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/ras: Fix CPER handler device confusion
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org, Terry Bowman <terry.bowman@amd.com>,
 Li Ming <ming.li@zohomail.com>, Alison Schofield
 <alison.schofield@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Tony Luck <tony.luck@intel.com>
References: <20250611171721.2048408-1-dan.j.williams@intel.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20250611171721.2048408-1-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:510:5::9) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|SA1PR12MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: dc35a524-8db6-41fa-62fb-08dda917a6ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGpxdU53Vm94dGllMFo0N0F3MWRVSDlNeE0xd29xVGxtQjdKY1lSdXNNL1dU?=
 =?utf-8?B?OW5YbEEwUStjOENlL1cwMHhHZ29pcGlxa0hVQng2bmgzUzlBUWYvTFZJdkhG?=
 =?utf-8?B?eXlTNk4yNm52UEl4WkxlN0JtNU5PejRZa1h0UTYwbkdOSm81V0lUbHhWZGVJ?=
 =?utf-8?B?aVFGZ0ZjVlJpc0J0RHRRMFA4TDBOTEZya29YTVoza2JFVmhVbktYQUxsS0Uv?=
 =?utf-8?B?S2tUTnpuMUEzcDg1T1BTQ1BkcWFPNWJ1K2FMTkEydUVmT09jQXIrQm9HSC9m?=
 =?utf-8?B?bU1JVmVzcmkzNm5hbHRuVUtyZW9QbFVEZEszaFl5KzAzMDNnRVVGRE13UlZH?=
 =?utf-8?B?K3oyRHZiZVFRQXVQUy9OYytmN2dPcko1Sng1ZEVYbDNyNkhNQ2hIR0UzVkFl?=
 =?utf-8?B?M200ZEhxTVpqblJqZlVaa09NZjFYVEQ4TWVGdjVCUXFJM3c0c1ZJU2xRRStq?=
 =?utf-8?B?V2ZyQS9HZzdSVWg1NGdqbTYwK0hkdFNXY29BS25RSlk0UzFyamdMUllNSU1K?=
 =?utf-8?B?TmVmUWhtOXl6UTNXSUlZZjVSMld5N0VVQmQ3ZnVEZ0dsUEtuUHA2SjlsVFc3?=
 =?utf-8?B?ejdTYk9kQjJqMkF4MnNpMzVVUEZEcitBbUl6MFFOcy9SRDRNK2lIa2pwVFM5?=
 =?utf-8?B?akZOUDc0RUdUSUZIb1FYNTR4ZG42dVpZQzltTEIrWnhJS3dpR3lpTi9RUGZl?=
 =?utf-8?B?cmVoaVlNM1NXaHNLQ05FMm1oVS9BZ3lybXlibnRBbkhHUGRGdTBYbFlZSm11?=
 =?utf-8?B?Yyt1UzFWckEyeVE2OGN6M3B4S0FFdHp3SGRueXhGTmIwUUxiRkZtby9nRDRX?=
 =?utf-8?B?MzV4VThtdkk5aEdzMFlZeDh4dkFmdnlIWi9CcG1NUlVBYVk2bUZBYkFOemxm?=
 =?utf-8?B?TThwaytJNld2M3lZdlRCK0N2NVY1WWlsTkJSMk9rYi81eFVYaEZLb0w3MkNs?=
 =?utf-8?B?RnBCdXhQSkRiYVJxQkpqY3ZmSkRwY1ZmVmMwRUxWSWdRWGRvTjZlYVdMa0Jr?=
 =?utf-8?B?OXhkVklrdlFnNFlHVnRVQmdLY0xDa0hiL3VxTzRQZnpQeVlvLzlMRzJwUmNC?=
 =?utf-8?B?aWVhM0tGWnlwUHBkNzE3Y0xxNlhjQjFhbDZ2UHVHNVlPSzQwTm5iSUFDZjkw?=
 =?utf-8?B?SGU2eXRMNnUxUjhzRnZ2VTVwcnJDbVZVdmxjcENUVlZWYWdFeExGcUJCc2ll?=
 =?utf-8?B?UDZaVXBueGNQYjRYQXNZYS9yUFp4bUV1YzlOS2J4UCtFU2lvRmxETSswREQr?=
 =?utf-8?B?UExhWllhVms5ZlVpVE9lMEJ2SWVoRDNhNVVWV2Y2UWY2TnhXc2ZaNTRnYS9k?=
 =?utf-8?B?L3BYUHROM3NYQm9wb21MNG5LaVdOYThSTVRidWxEY050L1ZMK1J1WldEVUEy?=
 =?utf-8?B?MzRxVjkzWCtDZkNCc2VYZStlNkF4UHRweEk4ajNucUhOdDJXeXBFanlpS3dI?=
 =?utf-8?B?cVo2cVRIc0QybG5CaCsvVmFnMExrV2JjM1VGVWRTQmdZWmR5cno2NVQwVW5Z?=
 =?utf-8?B?eXh1SXIxaFZqWXFnZzBJR3lHNGxpaTN3UXNDM3phQjA4Y2x6ZjZZSWlBVURw?=
 =?utf-8?B?VXlnQy8zU2t3WEV1WnBYeUJRR084ZWR4R3ovRTlndzNaNDlTQmd5bXIvQ1FS?=
 =?utf-8?B?WUU1TWZjd3V5TlhmdHVtUnpGZEg1ZVlwT2dxTFc2U1FteDI2MkFaNVAxVTJT?=
 =?utf-8?B?U0J2NlFDTmx5THFuTU42dkV6Znh1Qjk2bzExditXWmtESWVMODBnQ1RyNXJX?=
 =?utf-8?B?UmEvWUQvODFyQ2lXRW9LV2did1RlUjQ1eVpXQjBtSVR4Yjh6NUVoTktuSWNG?=
 =?utf-8?B?OS9KOEsxOVRHSXM0VE1rMkMwUXZlckp0UVJmZlM3R24zcVJlYnNxNnorRHU1?=
 =?utf-8?B?aDF4R2o0Zmdsd2hLNGF4dXZiRmpIMHhCNlBpQ3A5MDlSUUVKdVlYZ0FMMmR1?=
 =?utf-8?Q?UU/S80JtX3k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzlxNnlDTmQxa2M3cGNaZkNCRjlNVlFWTFg0czlNL2g5aWNGM1g5N0JRTmNS?=
 =?utf-8?B?VEw5TkJCTUtZS2FKOWZ3QXBmSXp1TU4xcm82eVo2ZlBoY0ZHZm1IazFQTmk0?=
 =?utf-8?B?bU5yQ2xvUEdkaWo0RGtxSTVtbXpBVkMxSHorRDVnbWJTclZnQUF3bzZFaHF4?=
 =?utf-8?B?VFJ5NUt5UE9IdlcvOEpHUndDR2ZWOFpCUEZzMUJ5TWVYK2VRd2drV3BuTndK?=
 =?utf-8?B?YzZldFJWWTJKT3c5ZXNhQzd5Ump2anROWlg3QWJrYUR2enhHWHZsWS9JMWZQ?=
 =?utf-8?B?M0VsMmFZRWpVSEVyaCt5TzQzdUN0MExzM3hLWERjakRzSkNvdExITHdubVhZ?=
 =?utf-8?B?UVBqOHRWUHpRQlhFdnhoT0hEeUlUVjdYdkRnS0hZaStYOGhkTElDbTVSRjNh?=
 =?utf-8?B?OS95dlBJVDdjN05LT3hYNVpSV1dGZmphZnVURDhacnRNSmF0N2hzNFJpcnJa?=
 =?utf-8?B?RnBkbWFTZjMvT0JNQk55Mmp3c2FFY0wxOUdZYWo0Rlc0TFhEdkFRenFMbHhE?=
 =?utf-8?B?RVRURUpkNzUxaU1hdCtFdWhKU0llbzJORUIrY09teHhFMStBV0JGWitaa2Ro?=
 =?utf-8?B?SlBRWnhUQXd6S0Z3Y0JmQ1k2Z0hFZzkydDdlM3Z4dXNPK2pVRFZMRWlxTitx?=
 =?utf-8?B?blFxa1lJQmNpUXlWWkpUaFUrN2FWZ2dodnF2bGdPMndTRUYvYUM2eUN1WlBC?=
 =?utf-8?B?VTh4UlhDVzVGdk9RTDZlcGlqVTZTMW95TTVkTjMzZEV0RzJsblZseHZGTWpW?=
 =?utf-8?B?dkkrZ0MzOTZML0tmN2x1SjR6dzk5TWM3ZG9Pa3FlbnJEUXhOdzN1ZURUalBV?=
 =?utf-8?B?cGNTRkN4Wjk2aW96eDRIT3R2Z0NiUjgxd3RlNWcvNFdqTVNoSVlidUhVMW41?=
 =?utf-8?B?R29KM2VCNEplRXBJS28rUE5MTUpyZGk4S0hoZTAzS2pOakNOK05Pc1hwZ0pZ?=
 =?utf-8?B?a0tKYnIzcERQN1BzNXdtY3phYm1lZEFIcTlGQm9GM01sTmUxakdzNnBEeVBr?=
 =?utf-8?B?TC9TdXIwbUh4eU1pSm9pNXhVT0NEbm42WWZ6TElrL1pOOGROQnV2WHVyZG5o?=
 =?utf-8?B?b3Nhbkp1RndxQXpIdXZlbEZwUEwvbmVyVlk5bUJtUHQ2T2JMOHh5RlpkVnZk?=
 =?utf-8?B?Z0VXUkkvemszdjNjV0xVWTJRUlh4UWpYMlRySGZBVnJud2J6K28yT1lnYk5T?=
 =?utf-8?B?bmNYd1AzSEtuSlY1MnFhWW5zRHhpYnhPZDU3QkhYVjBtRDU3aURXaHhCZDFD?=
 =?utf-8?B?WEdBWi9Hbk5vdG5meVVaQUEwdllvUFI4bVNDUmNxa0l1enVBTmgzTW0xS0M4?=
 =?utf-8?B?ZWRXSWRQeVMxencyUmxDZ3BuUjZiU2toTlBicmEzWms2bWYwMStBZGg2bjRX?=
 =?utf-8?B?RzJiTW5PWklCZEhEMG1TWktFTHhPajFEMkZUZXo5N2xFOEVjQmtvQkkvSklC?=
 =?utf-8?B?Y2NWWUw4eGQxb29KMmYvbzY2bXIzeWhEZVE4aEJzK0NkQmdsc3pRRFlOeUJS?=
 =?utf-8?B?dko5ZnpVOWl1Q0Y5RWRJMmx2cWcwVFR1T3dzYVVsZTJJeXFzbmR0cW05ZnZO?=
 =?utf-8?B?RW9QbStGSlVZYmJkbVZPQjQyRlBLU2pzN0Q5Vlo4R0l3RGlOUnUvaGF2cUMv?=
 =?utf-8?B?S1U2NVFXTFBkMDM4dTRCc0p0Q2s3K3lmeWVKK29aS1B4djcwcVpuWHBVeWRk?=
 =?utf-8?B?SnpIQUgvbUZRSUg4VTZGRnJ5QnBYMUwvWGYzU0Qyd3VxQmw3bUdoT1dQM216?=
 =?utf-8?B?Y3MwaGZ4ZTM1bFdsMU1ZRXRQeXlTMFpocjJobk1VUi9xYnZXTlZhWEFDbXpo?=
 =?utf-8?B?bmZxSmNCbUg1d0xseCtsdVB2Zmd1RG5XckhNQlRjcHc5VHFERjFmUHlQd1VC?=
 =?utf-8?B?aVd1VlRTVEc1ZUdDVDByZUdmTVpJSVNFZWordWVOamtiNzVvc2dYMmkrRzN6?=
 =?utf-8?B?YUtlRmt6bzR5UDIvdWlpeXFMQjFhZlpjWkM0dXJtQlYwdWRLOVEzdC9hM2JH?=
 =?utf-8?B?cEcvcHZQT1M5VVZ2K09BZUhJVWhOTFNwZnRBNWFobExRUFVJVDVxbWtvVGJ6?=
 =?utf-8?B?T1FJaDZxTGlIWmZ4MDVoVkpoSmJPQUNZbmtzdlVKeUhCUXRBRmMxUmdZQjls?=
 =?utf-8?Q?uyN1Dmv67Jvl755WAvusQJg7A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc35a524-8db6-41fa-62fb-08dda917a6ec
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 18:42:00.8386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlyJRh+JuplTTYDHeJuMPXia/tIPajC5WecqfN+cwbc49fqsICCO7onLetWOEH3W/lTFIyyLGl/Ceq8FCts9RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8164

On 6/11/2025 10:17 AM, Dan Williams wrote:
> By inspection, cxl_cper_handle_prot_err() is making a series of fragile
> assumptions that can lead to crashes:
> 
> 1/ It assumes that endpoints identified in the record are a CXL-type-3
>     device, nothing guarantees that.
> 
> 2/ It assumes that the device is bound to the cxl_pci driver, nothing
>     guarantees that.
> 
> 3/ Minor, it holds the device lock over the switch-port tracing for no
>     reason as the trace is 100% generated from data in the record.
> 
> Correct those by checking that the PCIe endpoint parents a cxl_memdev
> before assuming the format of the driver data, and move the lock to where
> it is required. Consequently this also makes the implementation ready for
> CXL accelerators that are not bound to cxl_pci.
> 
> Fixes: 36f257e3b0ba ("acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors")
> Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Cc: Terry Bowman <terry.bowman@amd.com>
> Cc: Li Ming <ming.li@zohomail.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/cxl/core/ras.c | 48 ++++++++++++++++++++++++------------------
>   1 file changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 485a831695c7..1173eaff7e2b 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -31,40 +31,38 @@ static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
>   					       ras_cap.header_log);
>   }
>   
> -static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
> -				  struct cxl_ras_capability_regs ras_cap)
> +static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
> +					 struct cxl_ras_capability_regs ras_cap)
>   {
>   	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
> -	struct cxl_dev_state *cxlds;
>   
> -	cxlds = pci_get_drvdata(pdev);
> -	if (!cxlds)
> -		return;
> -
> -	trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> +	trace_cxl_aer_correctable_error(cxlmd, status);
>   }
>   
> -static void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
> -				    struct cxl_ras_capability_regs ras_cap)
> +static void
> +cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
> +			       struct cxl_ras_capability_regs ras_cap)
>   {
>   	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
> -	struct cxl_dev_state *cxlds;
>   	u32 fe;
>   
> -	cxlds = pci_get_drvdata(pdev);
> -	if (!cxlds)
> -		return;
> -
>   	if (hweight32(status) > 1)
>   		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
>   				   ras_cap.cap_control));
>   	else
>   		fe = status;
>   
> -	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe,
> +	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe,
>   					  ras_cap.header_log);
>   }
>   
> +static int match_memdev_by_parent(struct device *dev, const void *uport)
> +{
> +	if (is_cxl_memdev(dev) && dev->parent == uport)
> +		return 1;
> +	return 0;
> +}
> +
>   static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>   {
>   	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
> @@ -73,13 +71,13 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>   		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
>   					    data->prot_err.agent_addr.bus,
>   					    devfn);
> +	struct cxl_memdev *cxlmd;
> +	struct device *mem_dev;
>   	int port_type;
>   
>   	if (!pdev)
>   		return;
>   
> -	guard(device)(&pdev->dev);
> -
>   	port_type = pci_pcie_type(pdev);
>   	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
>   	    port_type == PCI_EXP_TYPE_DOWNSTREAM ||
> @@ -92,10 +90,20 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>   		return;
>   	}
>   
> +	guard(device)(&pdev->dev);
> +	if (!pdev->dev.driver)
> +		return;
> +
> +	mem_dev = bus_find_device(&cxl_bus_type, NULL, pdev,
> +				  match_memdev_by_parent);
> +	if (!mem_dev)
> +		return;
> +
> +	cxlmd = to_cxl_memdev(mem_dev);
>   	if (data->severity == AER_CORRECTABLE)
> -		cxl_cper_trace_corr_prot_err(pdev, data->ras_cap);
> +		cxl_cper_trace_corr_prot_err(cxlmd, data->ras_cap);
>   	else
> -		cxl_cper_trace_uncorr_prot_err(pdev, data->ras_cap);
> +		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
>   }
>   
>   static void cxl_cper_prot_err_work_fn(struct work_struct *work)
> 
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494

Thank you for this. Looks good to me.

Reviewed-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

