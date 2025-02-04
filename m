Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D745CDF1
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738665743; cv=fail; b=rnYPPdwtChfUE6n147/lRlynXjDQAkGxREogMiThY7s5xb89tF623lvZwJ7znbQ2KUaC2iW8xbn/LhLSXVBpHwmWbGdZWeEk+UBXkNSbVNLqUBL1Txy/u/vF/qU1bdOYt0gZMDIhV+n2i5QErLvoe1krJskMikHGsG9LwMJsNqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738665743; c=relaxed/simple;
	bh=RkYvGduWinPCa4GyKrJ1z1zGxd0mBA/fWT/E95ZkQvM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CgqOwtyG1xhhAw4Li2DnBpLvhVbkpA23RI2Z0VKn/WIdN2hQMhNfeIw3DinJXs12oKImA2CukTHa2+SV7rBoDK2kciaL5b5cEuK/B85MVUpaP2wMMaE7ZPRgsllaPwD/OB+wiXGaBwLRyCvpB/LaIvq+j+defJTOgrlcSkMEdE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l3y78Ba6; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l3y78Ba6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/iuEFGuLiPZm8ms3NwaSuEbmbxmenDfsPzkfrtAwPXzvJ4V1FbiYV/srGPd04Oo7i+48holYeRd22UZUBShiK3hyOlZ+2w7JfYkpQSMI7v/KgIAmGA6Ay8qSCwPH/yNeDM5Qh5khep10wZ5Yemr2wbsn7JFaKHc/koffYsHnqW8EExx72d4RUS8vHOWupkQbzQ4OmUSE+O3K3fhllrvILYamZA5OvK5ZpBE4PyCUbfXw/+DPEg5GddTbVsMNj6RRzYgxepzOZMx9ih1tsZSd28EOPFXbOuj1GXKaZOpYqmRHV0/BuvW8B+ENBOFxZzq3bB6lwd28huZlJL9CAjZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzOI7wFJq26nrQeN+n0nBmkgvu5HyHNMbjj2Mk96E14=;
 b=n2Kh4ynC6ZESLP4sPZRvmv0o50/9NhBD9bLe8Hl+WlCkcyihA1uyRyRt0SmkP+j3PEyuHjqBHvLyj3560q0wjkDYCSptp+K6dpyvEjVDFabJEiADf0hkdetP1Xru+rAOEoPr7tIJn9KHJu1/uRWIZ9NBkn+Ueq/d+sCv7BNiYTD0mc8cmxakEQc3mLeiygPd6F7bdM5eLeCidlifEfvDvOJhKTOBtdD2hEUbIFvnQIQG1Ubqwz1IvHytN5jBkluQYqIeNP/1ccVpyiDfLh8fp+dmGB/b9fC2I56KX4xq0TDu4ENN5c4VGT0s8ZoUBmeGYOkcwaA17/On4KVCjHAHmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzOI7wFJq26nrQeN+n0nBmkgvu5HyHNMbjj2Mk96E14=;
 b=l3y78Ba6yw7S8GGN1OxwYc0czzift21CRXY64wvOdwIo6ALDlR7hZt7rpKFRaMVPPhUGTe2tNwcVhDhBtWfVMHX8aLH4uIFVDWisZDL3lJ/7K4BqT1fFbPXYd9KCmdL89OEkFfkRMye4tzfBfrLq6yWIA5AQZFTusp1CkU449Wk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 10:42:18 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8422.009; Tue, 4 Feb 2025
 10:42:18 +0000
Message-ID: <b8bc25a4-412a-49e3-b951-6a00ae1bf9d5@amd.com>
Date: Tue, 4 Feb 2025 10:42:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] cxl: DPA partition metadata is a mess...
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>
References: <173864304059.668823.3914867296781664103.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <173864304059.668823.3914867296781664103.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0158.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::26) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cacad28-be6a-4240-3435-08dd4508988c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUtXNCtyeWZtakZQUytUWEtBa2xHU3lxcXl1OGdYOHlIMktpRzZtT2ZtalJy?=
 =?utf-8?B?OHNXMVY1ZHRCSFFJMno4N2pzbTdNWUxZbFhZZzFySVhaTnJXUGprTTYvKzdF?=
 =?utf-8?B?K2tUalhFQ0VXcmxKa3RXeFcwQmMvaHpLUnoxT2UraGRzUkpQR3N0aUswRWFX?=
 =?utf-8?B?L2sycGdLSm1kWVdILy9pbUJCNmlTNjV3SUswN2dtRkFkcUVhTXpVSWZTYWtj?=
 =?utf-8?B?M3FnZS9BVUo4RERiOUQrS1RIUFBoR2xxRTlndk4zaS9pdXh1OWoxeHJtWXda?=
 =?utf-8?B?eVJDNHZVZlo4V1VTaWNOb3dLOHpmWXVSYWgwQXh6d2hjMURTQUdLdjRXbzZQ?=
 =?utf-8?B?U2VHZFNkbi9BV0NsOEliQjFzanEyT2l5NGZoY2FmdEZsaUpKLy9UaGFvb0du?=
 =?utf-8?B?WU1NL1hHS2ZEOE9mY1B4UDQ5WUJkeFlEdUU5RmQwTnhHNFJIbjkydjE1SFpG?=
 =?utf-8?B?VUtNYmhpTzYvVTJEUjIxT3hHMUw1UFhjQ1RVdEY3MzR6dmx3aXR5ZU5iMVZH?=
 =?utf-8?B?V2J1cUM4NGpOWkI4eitxMDNDRUkxUWJ5ZGJyOXJ4cEtKbUluVWpxenRrMHF2?=
 =?utf-8?B?dmNKeXZaL3hDMGdSMnVqbktvMithYzhQeUV2czJYRW5BM25tUzJ5Rm45SytI?=
 =?utf-8?B?SUpHalVmei9YVVNuOTRaY1J3NzNHUGc0UlJRMzdFYjZlY1NuZGhMY21NelpB?=
 =?utf-8?B?MkhLUXNzWEVqN3lpdldyVXI1TzFMYTc3cDQrdktWMVNSMXA4eThkSDZLSlVt?=
 =?utf-8?B?VFdpTTQ0a1kzZG1MNnRxSHdsbVZFTTlXSW5TNFpSUW04dWRHTVdVNkxySWx1?=
 =?utf-8?B?UWM1SVN0NnUvNkZDYVd6cFhRN0tXL1BKbjhLMTRRY0IzbGlYdXpuUVc4Z2dh?=
 =?utf-8?B?VmovcEtwM1FXR3JQdE9kUHpLSU04OUdxNjJhTnhZbllJVHpwMUpsNkFJTkdy?=
 =?utf-8?B?ZDdxWVlEUUR6UVNmNEQ4QXlhRUNRMFJRdzFta0xrR3c2cVIrNXpMN0dOMUh6?=
 =?utf-8?B?TjYvd093YjhqNTFQRVdsOG9vSGNKOWNHbVhvZWl3ME5pNG5OcU11b2J1NmpR?=
 =?utf-8?B?WUM5TllYdkpqWXA4dnVBY21sOE5PS2hRcVNya0tJRnpmVURqODA4ZFpRd25C?=
 =?utf-8?B?Q1BuY3VMYjV5dUI5VjVOL1BTNDhMVkZ6b3lyQWM4aEhuTjBXa0ZuWlpvUmJv?=
 =?utf-8?B?Sndmc2JJbVAvRm80aTdXS0JuRnltL0xidmlKRHFvQ2hrcm1IY1A2VU5nVHl1?=
 =?utf-8?B?TDlrNk5OSjJyRUlqa2hXM0VKa1hLYlhieXRFYVd1RXlDY3dtMUdUMzg0L1hW?=
 =?utf-8?B?dTY5NUlYYjBsd2JuWHlBc01aQ2hIQTlqSDlOOXpqWGxnd3U1Vkc0OStadnZH?=
 =?utf-8?B?MW9tRUJnR09GMVlCVFIrbTVwS1NiUUpRckVzYmcwa2RMVDVlS3lncVhzYzBT?=
 =?utf-8?B?dm81bmJEVkVQUCtGVlFxNUNmQ2hKd1ovMlVTR2hHSXB0U1NzUVRWNFQ0WjVT?=
 =?utf-8?B?c1lGT2JRTG5DMmhvUURRY3ovejhWZTlPU1BnVjdQeE85N1g1N3BPV2RYd2NT?=
 =?utf-8?B?QmxncU44MExmeDFTWWFiQVJxZDhXbjNoSVRqUGhaMjlFYmNiVUd6ampicEpt?=
 =?utf-8?B?ZFZhYWdFQUNTL2JwZmFZdm1uVnljSnlDT211aWZldzUzM3RQQzNRRWhhN3lJ?=
 =?utf-8?B?aWh5c2N4QUgyMnRhbm02a3BGUFJjTlJ2VTBJWjlITmI3a25yOXM0MVFLM1Z0?=
 =?utf-8?B?b3dYa21YMXN6amRIcjJjbTRweFBnWlI3NCtYQkQzcVYzN2FnR2Z1ZzVCd2Qw?=
 =?utf-8?B?UUgvNGJ3ZzF0VkxXWlBqdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RktpQW9rbUJjZEhoUzgvSnYrbHlsU1FwalEyemRKcURQL1drSjRGNk9FelhL?=
 =?utf-8?B?S0FrcUg3SkZodVJxaGJqc3UzVTkwaWhCWFYyUUdhK2FtWGQ3TTRVSVp5UUNi?=
 =?utf-8?B?QkR3MTc3d3F0UjFBTVhUYXJKdHhSNHROSUZCenlwbDFRSVdPbTh3UjY0c0g5?=
 =?utf-8?B?SGR4QnRsamRpcVY5cnNCcUV3eitQSHpKUjlkL1IxZFFHaGFTc3RDY1E5eUdr?=
 =?utf-8?B?NEw0c0xVYXh5bjV5aFRjM0VSNXNyZExSa3hKbWl1aFhkcGpPWklobDNJeTJW?=
 =?utf-8?B?MHV6ekx2Ry9TNEpjV01LSTFvUjZ3YjhTcTllNFhCMEpub3NtemhxeWl6OStR?=
 =?utf-8?B?VnI1bmhkRUE4SGlWcDVBNkdPeFF6aDhpaHBnSzMvNVN5Y1haVVlzUU0rTlVa?=
 =?utf-8?B?S0N6R09ZVzlwQXE2WlA2Q1RPWjNXRWcxMXZmeEdvOFppQVRtZXY3azk2dVRi?=
 =?utf-8?B?NlV3V2tpN0l4d1p6MFlRODBveVpNdlRpckdiV0pLWmdRZk0vUnhUY2xzWjcr?=
 =?utf-8?B?aXFsdy95a1JXb2lTdkhzeXFSYU1mc0t4WWJKNXk3OU5RaEg2alJTdFF1cDRF?=
 =?utf-8?B?ZGVWU1pzYXRsdWhYcW5XNmdqS0ltMWVGeFd6Tzl2SjR2SzZxS09JdzNBdlZp?=
 =?utf-8?B?UVdVSUNxMEt3TmJydTFiQ245TndPclNlV1c1YU1MNDV0TUxKZkg3dHZPM3ox?=
 =?utf-8?B?Y0lsL0pPbHpudGdIMlYyWGRyY1hRSWJjSktMN21QNkZsTjJ5c1VkUWpQNmFy?=
 =?utf-8?B?c1BEVGNvTFE0ZzRIS1FnclhLelZzdGFJaTlXckVCNzVpWllqd2RBVGlVQ3ov?=
 =?utf-8?B?ZFZHRVVvWE5ITzNlSDNlMHB0Vy94N1RXZEUwanFuakZvcE5ZTis0WUxvQU9Y?=
 =?utf-8?B?ME0rQ2YwZTk1L0R2SzlqTSs1MlVaNklXTlFBcXplaWFqK0w4eldESUg5ZTNs?=
 =?utf-8?B?dzRmSjYzY2lvWkdYenFNdU9XZjc3bHQzK1Y1NmNrT3IzdEdvWmhKbzA3QWV1?=
 =?utf-8?B?M2tLc0hMQW1sTkpLZGZ3YXZpTzhld3dHTDVIWEJOc3V3M2JreSt4Y2QxMzN1?=
 =?utf-8?B?QmJIREw4R0VEUnFmSXhkVG1oM2d2VDFvWDVZMGdqeXZ5Y2xuTDhSOHlLK3c3?=
 =?utf-8?B?YVMwSXNXbmR5bDhDdkpGNy9RS1VncDU3RGtDZGM3TDZxTzdUNCszNHN5ajVU?=
 =?utf-8?B?ajFRMjVDcXZQTHVZK0d4ZVN4bFBQdldrMnpVelk5WkZKL204VGVvQitnMC9X?=
 =?utf-8?B?RXJUN3JQeXhtelEyemRkbGNWMmcvNG5iUThLcjQ3UEFCNzQ0ZjJ4UlFjUzJl?=
 =?utf-8?B?NzR5SGxKL1dCT0FWRWJGSHorMDQwaGZDbjVuY1U4NGFESzdNcEI3VkRZSDR6?=
 =?utf-8?B?VHlIdHdZNWUvWXphVFhUTGZ3cXBicGpWejlha09yRlpNRVBPQnYrU3JMUm1E?=
 =?utf-8?B?ejZGTXovZzJWL1NWUGdaM0NZUFhBaEJHY21ENmw2RWZpMzBUb2dnQzNXeUVY?=
 =?utf-8?B?RzY3UFVieDhOZUIvYzdXVXg1NVl6Q1hjVzVuMCt6cU9CQkc4eUFaYncrNWJi?=
 =?utf-8?B?ZHVpNllkRTBQSjNIaVViVFJtcFVpQ0tpaFkrb0JXTlRnS3NLeGRpNXg4MWlj?=
 =?utf-8?B?TEZSZWxJb3AxVXlyRGcvcTlZNmZ4dlMrUm1Dem9qUW9hWUtaQy9WV3lwNUZN?=
 =?utf-8?B?VlMwdlQ4V3JpZTVXTC9FdmhCdGlzWjk4eG9jTHdSWCsyclMvaFc4VmhLTmtQ?=
 =?utf-8?B?Y1ZKVXVLQUpVZXRkcGhJRzB6V2FOOWxaUnhLS3dEVTFmb2NleHY4aU12WGpX?=
 =?utf-8?B?QmlEUTJEZVRmRFRFZUVUc0pOM2p1MUZvNVdNenNrVEY1QW00d2g4Y1FSbThB?=
 =?utf-8?B?V2Y4K2lvRVlDY0UzTEErUUtCL2JucnpXZW01MVRYR0h6SGxzTENrd3VxdnBX?=
 =?utf-8?B?ejdSUWhnRG1tNGtTazQ5S2RkOTc2OGVyQ3grVXNtN1ZCMGdpN3IzZ2VpNStW?=
 =?utf-8?B?dGFNL09NbERvUjJvRmFaVEtLbUVkRmhMRFVlOGRhajF2ZGtybW8vZkRlQVVB?=
 =?utf-8?B?UkZLOW5MMHQ2azcyeHJ0RzJGN3RYd0Zxa3UwcC96blpmdklRcmdxblh1RGJz?=
 =?utf-8?Q?Kswk0SKsE87yCwY1LtoXQe/cL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cacad28-be6a-4240-3435-08dd4508988c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 10:42:18.0994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihq2ukK9pDU7v47mvsoKX8Y5ZnnSOBRUkMfdW0SBatcldOKPXE/4VebmuTDuNIcnVZ9IfZVCq+h27dnuj2GeWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714


On 2/4/25 04:24, Dan Williams wrote:
> Changes since v2 [0]:
> - Fix "no partition found" debug messages in update_perf_entry() and
>    cxl_memdev_set_qos_class() (Jonathan)
> - Avoid touching dpa_perf_contains() twice in the series to add / remove
>    NULL check (Alejandro)
> - Add a cxl_mode_name() helper (Jonathan)
> - Use @part as the iterator in cxl_dpa_set_part() to simplify mode
>    lookups (Jonathan)
> - Require ordered + contiguous partitions (Ira and Alejandro)
> - Fix partition detection for BIOS established reservations, and kill
>    CXL_PARTMODE_NONE (Jonathan)
> - Simplify release_skip() reuse its internals for request_skip()
>    (Jonathan)
> - Add patch6 to finish cleanup of explicit partition lookups
>
> [0]: http://lore.kernel.org/173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com
>
> ---
>
> As noted in patch3, the pending efforts to add CXL Accelerator (type-2)
> device [1], and Dynamic Capacity (DCD) support [2], tripped on the
> no-longer-fit-for-purpose design in the CXL subsystem for tracking
> device-physical-address (DPA) metadata.
>
> In fact there was no design at all, just a couple of open-coded 'struct
> resource' instances for 'ram' and 'pmem' and a pile of explicit code
> referencing those resources directly.
>
> See patch3 for more details on the specific problems that caused, and
> patch4 for the eyesore reduction of making the DPA allocation algorithm
> partition number agnostic.
>
> The motivation with this effort is to make it easier to land the Type-2
> and DCD series.
>
> [1]: http://lore.kernel.org/20241230214445.27602-1-alejandro.lucero-palau@amd.com
> [2]: http://lore.kernel.org/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com
>
> ---
>
> Dan Williams (6):
>        cxl: Remove the CXL_DECODER_MIXED mistake
>        cxl: Introduce to_{ram,pmem}_{res,perf}() helpers
>        cxl: Introduce 'struct cxl_dpa_partition' and 'struct cxl_range_info'
>        cxl: Make cxl_dpa_alloc() DPA partition number agnostic
>        cxl: Kill enum cxl_decoder_mode
>        cxl: Cleanup partition size and perf helpers
>
>
>   drivers/cxl/core/cdat.c      |  101 +++++++------
>   drivers/cxl/core/core.h      |    4 -
>   drivers/cxl/core/hdm.c       |  319 ++++++++++++++++++++++++++++++++----------
>   drivers/cxl/core/mbox.c      |   66 +++------
>   drivers/cxl/core/memdev.c    |   66 +++++----
>   drivers/cxl/core/port.c      |   21 ++-
>   drivers/cxl/core/region.c    |  137 +++++++++---------
>   drivers/cxl/cxl.h            |   39 +----
>   drivers/cxl/cxlmem.h         |   52 ++++++-
>   drivers/cxl/mem.c            |    2
>   drivers/cxl/pci.c            |    7 +
>   tools/testing/cxl/test/cxl.c |   22 +--
>   tools/testing/cxl/test/mem.c |    7 +
>   13 files changed, 519 insertions(+), 324 deletions(-)
>
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b


I have used this last version with the impending Type2 v10 patchset 
using these changes and it works as expected.

Using two different type2 devices/drivers, so for all the patches here:


Tested-by: Alejandro Lucero <alucerop@amd.com>

