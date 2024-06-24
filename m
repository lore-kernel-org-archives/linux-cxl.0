Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7A019D8A4;
	Mon, 24 Jun 2024 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245392; cv=fail; b=EkaEYzxfbyZQz8nxwHUoobhOZaHJF7UQ2DTWCGOvFHKsLl7ZUALidgsMrjESv9R+0Btc4cDL3v5LpIWzXfv+MAGBDUtGbkqBf5DkfmGSsmoRvPRGR16zo5pEX7MAH2vxOrPlClGB630PQWcVpVXyH81KpU2EMAkXejHmVK97opU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245392; c=relaxed/simple;
	bh=6Zjt1LykZU8+44WpPYqzWjBilo65Oui1pVRLjP4L+CY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nbP9HN7aPnr5F6gxCJ901PBibN49tz0uaQE7v4xS1XjbIUfp/rdbzACfwgGLP+PZFClzC3yMMpfFnqoE1lGcv/RXxBEdAec941psdVDnxi0BeMuc8Hy3blRYsXHg6b/eJ0OJHAb3fAN+mmFcKztqgDzf7pfQ+TqcGiWdTfQ7ViY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DKjfNXH+; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DKjfNXH+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afttkFlrQU6T6KvxQGnmylttQ6lplLCPQpBCowd/Rli2XeF01ueXWOfwR4AzFWzw1P0XDoZ3h++5u81ZRH9FtPywH2IUiNCGgR+ru+X2lat+tDwRNiCmEOTh4WH2355RpjJlSdvB4Re/8kqlynnbq2a3J3uOqsZRtOTGyC1f5/tRfVUuUjph3IfpYx46XouVf67uFtkbb1oS9HRs3aGvbJU6725yajo7nrqf83vz15aSWq+b1YlH/32It1RwG5hnFx3NcKCALs/vex2cQJiFzLue0jHPR/aWfx1bPz5gm3ZxoEbBF8psuO4Z/y26GUCqeGvLWspvAwyYUfqOvqoJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6Yz2NOQmoCiJteGYUD3mL7Amt1+OyOHUxMehX5laqI=;
 b=e0i7v9cPLwyUFJ4QGtCS5pomcqOQ4Wr4/lomtZIHxaFQc3FTURg68o4+Mqj3xQnlEUJq6zxKSxL+e5lrSeoI+fv349bHO+EdJQ/AW5NBgDfUFXzRrLRAuxlVEhwPm4BoAZof1oC3/cASopgE9t47OqILr6Au8k8wGDE6hCaM98HY2p3IyY8qv86uSVqVa37ef8Y4Uip5acEWuT2Yl9jMIZrRZbvAjTFeFeJVtqC2jEiq3hecEWwddDFn5XpXKhnWEx8q3sD4UIC8VNIBsSn+eJLLuKNVxarWhRhU7/sJuY8Uv6b4yI6JdCwXKpg12s2ZQh4rY80nLJn4uH84HuGlhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6Yz2NOQmoCiJteGYUD3mL7Amt1+OyOHUxMehX5laqI=;
 b=DKjfNXH+exxWNp7bSOG2R4AnVPz1uZfNKVH9QpsjTS5drhDQMISsUTLIqDfMTIysoN3jDhiUFSs62E6fFECUe9x03WRL9NvY7laU/y9ZCvTC0sZXlHyknQF0MQifFHu9WpqB4QYO7nw8r+GPOR1nqdpeS2Ag08VgdEYAlGyt44g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Mon, 24 Jun
 2024 16:09:46 +0000
Received: from BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b]) by BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 16:09:44 +0000
Message-ID: <6b4b451c-935b-4ce6-ab64-c2e66311099a@amd.com>
Date: Mon, 24 Jun 2024 11:09:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/9] cxl/pci: Add atomic notifier callback for CXL
 PCIe port AER internal errors
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, ming4.li@intel.com,
 vishal.l.verma@intel.com, jim.harris@samsung.com,
 ilpo.jarvinen@linux.intel.com, ardb@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yazen.Ghannam@amd.com, Robert.Richter@amd.com
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-8-terry.bowman@amd.com>
 <20240620140926.000029d2@Huawei.com>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20240620140926.000029d2@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:806:21::12) To BL3PR12MB6380.namprd12.prod.outlook.com
 (2603:10b6:208:38d::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 109c1aa4-03ce-46d0-2582-08dc94680f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjN4dkpMTVRjVFU1M3FmdVRwVldwZGxGUG9TME9CaDUvZzY2MnFrdG5SYU54?=
 =?utf-8?B?MEVZa2o5dnBZdlErUTN6MGVacnNmTUpRa2pwUnRNK2tnL0x0SW5ZTTc3bzRP?=
 =?utf-8?B?Yk1LRTIxa2FpajFtV21yeCtKeDdpTkc1ZDhhRGV0MHgvVUgwMm1OVFpzZE4x?=
 =?utf-8?B?Q1U1dStVMmFOUHFCMHdoTzQvUEdJUGRuc0JLekVoMGhrREd5dGhiWGhOUlZs?=
 =?utf-8?B?QnZXd0wvYnYxWDUrYnVDa2txL1p6MWZ3Y0lvS0FEZ0s1Z2FEUHZ2Z1NOTUo1?=
 =?utf-8?B?ZUE0aDdDWkxlUHF1U2hJTG90cTlMWUU0S2JrbHV4RnJ3ZEFJV0NpVVVlSGNM?=
 =?utf-8?B?THl0dldwU1ByalJDWi9naUlWNW9ZcjZ5Ym9lRUxiY2NxK2hWNHExaEJjY3Rn?=
 =?utf-8?B?eWZHdUswdy93aUQxemdPSTQ0TnVvR2hEVFF0TkF1MnhaL3gxRFFITU9yUDBt?=
 =?utf-8?B?d0doNzFQQjZyNmFkWkRlaGY1Ly85dG5ETno4YUFNWUNzTHBjVlc4ZTVGVXIr?=
 =?utf-8?B?SGlMQXIwQXhTWGV3MC92S3NCZ1JPTVBzTE53RWtxckdtL3ptcE9pZHNMelA2?=
 =?utf-8?B?UmNRR2VibjhvMGNTS1I2UGRUS0JSamc0am1lUEVkNkpLdSszOFpBZG5CdUlH?=
 =?utf-8?B?NmJYUnN5b2RTREV2eWxHUU5kTGhwVlB5TkIrejZaZ2sraWdzVWUrK3N2Z21C?=
 =?utf-8?B?cEdsblA2K0RmSnBudEFnS2hYbWNwWk44MU9VUnUrSUp4OXB1RHN1TzAzYWEz?=
 =?utf-8?B?cUpMcCtNWTNZYXBUYXhrWFAzeWRLNGR0KzllWkVSR2Y4L1hrZDBJSXh2clJX?=
 =?utf-8?B?ckxVTHpoQjFtYVR3a255OWxjQ3NvVytGbTc0SWk3a0luWXM0eVNpUm5rTXpN?=
 =?utf-8?B?RFYxVnZvL3JmdlY3VTRNaUtuYkVVTEJwMjU1czR1aGdWMHNXbFBlQStXRGQ1?=
 =?utf-8?B?ZGIra0VlSSt3MWgvOGQwS1hsUFRDTDQxZkZyU1BkVFhpdlBiTVdqQXRTYVFO?=
 =?utf-8?B?SzBMbmVzcVNqbEk0c0FzSjV3a3l4WEZsTU5yeWorTXR5WGY0T2w5MjZrVWJv?=
 =?utf-8?B?N291d1IyNkZKSGVxcWRBSzE5UlF4UCtDbDllR3dwZjJoTXRGR243d0dvQXcr?=
 =?utf-8?B?TnlEbnZuYTVOcmlyVU9BeEUrbGpYVE5PNzhtWEZQRHVxNlNwa2hObGp1V2lj?=
 =?utf-8?B?azNaUlBkRG0rd2FsU1l2N25WeHlsMjZaaFMrRTBkOGliUS9pejR5Y0RZSS9T?=
 =?utf-8?B?Y2NqRTZJb0hLK3ZCWTlmR2oydDgySHpHVTlPdDZaTGxkdkRCV3N3ZmU1R3B6?=
 =?utf-8?B?dkp1cEJ2cG5hTlQ3a0Uvd0hkRXZzVE9BZ0V5NThiNzNoRTN1VVFaYXVJVDJV?=
 =?utf-8?B?L2o4aW80ZUhzT1ZvTWpoalNVZFN4bkdTMDlOMEl0ZjlsdDRYWkw1VmswKzc1?=
 =?utf-8?B?VCtNeUtlTGdyd0w0d1FES3QrcG81ekFCaXFxY3p5cnkrdjNiRm5FaGhDRm9U?=
 =?utf-8?B?NVMxdXhXVWl0V2NmQTk2WlZQcUxpQ0s0dW03UndiY2tFclJmVWlOeWxHZmoy?=
 =?utf-8?B?VlJ0UVRaZE9HdlZhWnRuWGhnR2RSejh6K0FRUStUVndieFBoNlFnL09lWFda?=
 =?utf-8?B?RzVDVU0rczR0ckJLSUNzMjBaUUdlb1ArclF4bHliMUIrRHBXTzI4QUthUnUx?=
 =?utf-8?B?T1VZazgwT0krazdqL0RvczVXOW9wK0dFOTI2cWszR1NyU2lPV2k4QnlHaXVl?=
 =?utf-8?Q?mSQrr/FIefOzniknDet4wBodyb2hRjst7QAMTpz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2t3MmU5WC9iVW45QzA3RXdOemdjWUdEQTVqQ2JGRjNsL09yNjlidGJJRXJa?=
 =?utf-8?B?eUdNVWYvSmpudjV4dDlQdTNQU0QvbUZ5bDU0TXlGcWNmd080QXZxbFJZUlY0?=
 =?utf-8?B?NzR1RDh0N1FpQS9aVlNpZmR5R3ptZjdsaDFyUmh4eVlVam5wKzJ3N2JWb1Vx?=
 =?utf-8?B?ZXBMODJ2dy9ybC9jZmdaL3NFTlpEY1pUS1F5OU9rTlpnbnZsZzFkZWdmV2pW?=
 =?utf-8?B?SHBHblk1M3hMUVdhUGVoZFdUUVZMRGhXVEZsdTcrT3lGQXNSYWJhdzlQRVlO?=
 =?utf-8?B?WHlVaExLb3g2bXBEU0Vsc0ZLakZLb0lrdjlEcFBST3R4R2hlaU00bHFWSk5a?=
 =?utf-8?B?ZFZFVGhMRkRxZTUvMG9zUkdpYzkxRFo1UVpiUHhIeVNRRDU0dFNSRXB0K1Yr?=
 =?utf-8?B?VTRubXViODBuN09yVVhkSDhIOEpVTGtqQmFBSFVpYUFjMnBDcnA0ZENDTzdV?=
 =?utf-8?B?MEs4YTJRZDZVOW51TEZuWFBEZE0zeXRJL3VCY3RrOHI3UVk4VFNzSGcxbERR?=
 =?utf-8?B?TmhBL3Z1YlRlTzVycjd2K0FTY3dJTFlqRWdLazgzd3kxQlpIK2MxQkpLWVpn?=
 =?utf-8?B?RDFRRjhIbjNFQ0JMV0M4dzMzSmtXT2x5WExvWWlzZGRKOXZGQlFRL0tUVXJK?=
 =?utf-8?B?V3IzWS9NVktpbGpTY1pKNmx2TVd1RHQ5RityMTZIbVJyY3hEc2wzUkozNmx3?=
 =?utf-8?B?SjZvd3JhNTJwb1gzRXpkRFdwaUoyeXMvUXZ3V0tKeHhFU2N4ZzM3UEZxSmlC?=
 =?utf-8?B?NDFESFZHazUyNGhKSE0wS2krcVpYdHpiZHBoM28yV1oxU1gydnlVQ1hmR2Iz?=
 =?utf-8?B?VlZINWNhMXJxZU9SWXd6VWZUb2xLcXV4dDNlVHl2cjZBcitoU0tHcEhhc09N?=
 =?utf-8?B?ckFFM1kzWUN2OThZTWk3WlQyT1crU1NTSkN1SzB6b0NyVnFxc0lBS0lnOGpQ?=
 =?utf-8?B?cllsZXREWnpVaDc2MnRZVGVPQlh5RXllQ1orQWorL1l5dVYyRWozMDc1RlVF?=
 =?utf-8?B?cjZEVHZ5VTRYdXhPaUhRMDYrMFZSeGpPek1jSTRCOVFHZ2ZMdkxWbmpqQlZx?=
 =?utf-8?B?OEFkU3o5UGhySkg1dVVsa05ZckdxaWtOQXlDQVIxS2J1NHVCM21ScVhTOEVj?=
 =?utf-8?B?SEV5WjlqUGpDWWNKRVZ5NmRBWnlscktYTTRId0xyY2IrMERkSHhJZ2NmbVBY?=
 =?utf-8?B?UWlienRRa01tdUVGK0thOEU4elBQSmJQZDM4Q1BpQzhzbS9Zazl5dzNOM1Q5?=
 =?utf-8?B?bkJ1dGZwc291NDkzMk5GdlBScGJZVjF0Q3Eyek5CbnZiT0lkd2xvQ3NndmJm?=
 =?utf-8?B?SXFNY3V3SDBsSTRXenhMWkNSbTQzWlBJTmFtb0tOaUk4cGNjY2RQT2l2QWVV?=
 =?utf-8?B?bDJqdUN2N1VQMWVRVmg2RElIT1hOc2dSdDF5bWFiQ3k2ZGZKMnRjTzhSZHBz?=
 =?utf-8?B?YVpXZEFRY0ZSdWpyUWttTU9NY25GYjZzTU5tQXJKVlJSeVNvSFczM2FFbENM?=
 =?utf-8?B?ZVdHY2w0WDVkQ1V1OVlHYTRnemhUa0JFdHB1SWpKZXRUQmh1ZWt6SDczMjNS?=
 =?utf-8?B?ZVliWU5hNUY0SHVsS0hLMnFLUEkvQ25ud2lMYzJxZUtSN3NXdVJpK3pkSVZC?=
 =?utf-8?B?Q1AybXBZUnpUcFBzOHVzNjV4c3p3K2V6QnF0dHpDZS9nSlJYWU9wejVGWk9F?=
 =?utf-8?B?NmZaUDBVbTNNZlRmemlybi9tS05UMXJuTHZEUVhHY1F2WWQ0MVNoTTE4UTNk?=
 =?utf-8?B?ZnNCSmhnRnhRT05VcmpMZzRldmI4SVpLemQxSW9UQ2p3RDZhZmw0RWJWV2JH?=
 =?utf-8?B?eFo1Y0hweTZhR1U3RzVoelQ2OUZhQkJDYURxTE1NQ293S25xVGNCWDBEYm8r?=
 =?utf-8?B?cjFjbWhWWWlqMFRKdEdPSTloRXFjMDZGUEV4ajFEYTJ1NVB3N2tuRXhNOUhI?=
 =?utf-8?B?NUw3U3oxZ2xNR1g2aTdQMW1peWlZa21mcE8wTGlrK0Z5WnUvb0EzWktDc25F?=
 =?utf-8?B?VEwxWUJjRG5MalN1c1B4MWxrYUk3bmxhWjVSVSt4MGYyQUpycXNVNkVOdXox?=
 =?utf-8?B?b1lpTW80M3JLdWZvTnZSSGFvdnN3VGIvaFViYXhnUWN2MVUvMUlvbitGWTJT?=
 =?utf-8?Q?40LXaavcCYOOdiaq8YO5GwKvT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 109c1aa4-03ce-46d0-2582-08dc94680f93
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 16:09:44.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKex2p3QnwlQo3aGiPtBQfj4Beet6X+e1E75iKva4JXwbc48534TsvS74MEz8GohQQRFY0vdkm+lJKWaeZxsrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309

Hi Jonathan,

I added repsonses inline below.

On 6/20/24 08:09, Jonathan Cameron wrote:
> On Mon, 17 Jun 2024 15:04:09 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> CXL root ports, CXL downstream switch ports, and CXL upstream switch
>> ports are bound to the PCIe port bus driver, portdrv. portdrv provides
>> an atomic notifier chain for reporting PCIe port device AER
>> correctable internal errors (CIE) and AER uncorrectable internal
>> errors (UIE).
>>
>> CXL PCIe port devices use AER CIE/UIE to report CXL RAS.[1]
>>
>> Add a cxl_pci atomic notification callback for handling the portdrv's
>> AER UIE/CIE notifications.
>>
>> Register the atomic notification callback in the cxl_pci module's
>> load. Unregister the callback in the cxl_pci driver's unload.
>>
>> Implement the callback to check if the device parameter is a valid
>> CXL PCIe port. If it is valid then make the notification callback call
>> __cxl_handle_cor_ras() or __cxl_handle_ras() depending on the AER
>> type.
>>
>> [1] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>>              Upstream Switch Ports
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Hi Terry,
> 
> Some comments inline.  Mostly this comes down to earlier question of whether
> this notifier should be registered per device or globally. 
> I think I still prefer per device, but attaching the handler will be trickier
> and I'm guessing there may be some locking/lifetime issues doing that which
> are avoided by a global notifier.
> 
> Jonathan
> 

I agree on the per-device notifier.

>> ---
>>  drivers/cxl/core/core.h |  4 ++
>>  drivers/cxl/core/pci.c  | 97 ++++++++++++++++++++++++++++++++++++++---
>>  drivers/cxl/core/port.c |  6 +--
>>  drivers/cxl/cxl.h       |  5 +++
>>  drivers/cxl/cxlpci.h    |  2 +
>>  drivers/cxl/pci.c       | 19 +++++++-
>>  6 files changed, 123 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index bc5a95665aa0..69bef1db6ee0 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -94,4 +94,8 @@ int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
>>  				       enum access_coordinate_class access);
>>  bool cxl_need_node_perf_attrs_update(int nid);
>>  
>> +struct cxl_dport *find_dport(struct cxl_port *port, int id);
>> +struct cxl_port *find_cxl_port(struct device *dport_dev,
>> +			       struct cxl_dport **dport);
>> +
>>  #endif /* __CXL_CORE_H__ */
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 59a317ab84bb..e630eccb733d 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -689,7 +689,6 @@ EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>>  static void __cxl_handle_cor_ras(struct device *dev,
>>  				 void __iomem *ras_base)
>>  {
>> -	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>  	void __iomem *addr;
>>  	u32 status;
>>  
>> @@ -698,10 +697,17 @@ static void __cxl_handle_cor_ras(struct device *dev,
>>  
>>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>>  	status = readl(addr);
>> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> +
> 
> Blank line probably not wanted as we want to group the status
> check with the read (it's kind of an error check).
> 

Ok.

>> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
>> +		return;
>> +
>> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> +	if (is_cxl_memdev(dev)) {
>> +		struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>> +
>>  		trace_cxl_aer_correctable_error(cxlmd, status);
> As below - don't bother with local cxlmd variable.
> 

Ok.

>> -	}
>> +	} else if (dev_is_pci(dev))
>> +		trace_cxl_port_aer_correctable_error(dev, status);
>>  }
>>  
>>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
>> @@ -733,7 +739,6 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>>  static bool __cxl_handle_ras(struct device *dev,
>>  			     void __iomem *ras_base)
>>  {
>> -	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>>  	void __iomem *addr;
>>  	u32 status;
>> @@ -759,7 +764,13 @@ static bool __cxl_handle_ras(struct device *dev,
>>  	}
>>  
>>  	header_log_copy(ras_base, hl);
>> -	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
>> +	if (is_cxl_memdev(dev)) {
>> +		struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> Just use this inline.
> 		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev),
> 						  status, fe, hl);
> 
>> +
>> +		trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
>> +	} else if (dev_is_pci(dev))
>> +		trace_cxl_port_aer_uncorrectable_error(dev, status);
> 
> As before, why no fe or hl?  I'm sure I'm missing some spec subtlty
> but a comment would help me and others avoid that.
> 

Adding the fe and hl on the list to be added. No, you're spot on. 

>> +
>>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>>  
>>  	return true;
>> @@ -882,6 +893,80 @@ static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>>  	return __cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
>>  }
>>  
>> +static int match_uport(struct device *dev, void *data)
>> +{
>> +	struct device *uport_dev = (struct device *)data;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_cxl_port(dev))
>> +		return 0;
>> +
>> +	port = to_cxl_port(dev);
>> +
>> +	return (port->uport_dev == uport_dev);
> () doesn't add much so I'd drop them.
> 
>> +}
>> +
>> +static struct cxl_port *pci_to_cxl_uport(struct pci_dev *pdev)
>> +{
>> +	struct cxl_dport *dport;
>> +	struct device *port_dev;
>> +	struct cxl_port *port;
>> +
>> +	port = find_cxl_port(pdev->dev.parent, &dport);
>> +	if (!port)
>> +		return NULL;
>> +	put_device(&port->dev);
> I'm confused on the lifetimes. Doesn't it make more sense
> to hold this until after you've stopped using it? So move the
> put after device_find_child(...)
> 

Ok.

>> +
>> +	port_dev = device_find_child(&port->dev, &pdev->dev, match_uport);
>> +	if (!port_dev)
>> +		return NULL;
>> +	put_device(port_dev);
>> +
>> +	port = to_cxl_port(port_dev);
>> +
>> +	return port;
> 
> 	return to_cxl_port(port_dev);
> 
>> +}
>> +
>> +static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev)
>> +{
>> +	void __iomem *ras_base = NULL;
> Don't initialize and...

There is possibility the incorrect PCI type is passed and this is intended to
return NULL for these cases. Should ras_base not be preinitialized in 
that for the scenario?

>> +
>> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
>> +		struct cxl_dport *dport;
>> +
>> +		find_cxl_port(&pdev->dev, &dport);
>> +		ras_base = dport ? dport->regs.ras : NULL;
> 		if (dport)
> 			return dport->regs.ras;
>> +	} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
>> +		struct cxl_port *port = pci_to_cxl_uport(pdev);
>> +
>> +		ras_base = port ? port->regs.ras : NULL;
> 		if (port)
> 			return port->regs.ras;
>> +	}
> return NULL;
>> +
>> +	return ras_base;
>> +}
>> +
>> +int port_internal_err_cb(struct notifier_block *unused,
>> +			 unsigned long event, void *ptr)
>> +{
>> +	struct pci_dev *pdev = (struct pci_dev *)ptr;
> 
> I think you can use this notifier for other types of device in future?
> If it's going to be global definitely want to check here that we
> actually have a CXL port of some type.
> 
> It may be that via the various calls any non CXL device
> will result in a safe error. However that's not obvious, so an
> upfront check makes sense (or a per device notifier registration!)
> 

cxl_pci_port_ras() performs PCIe type check and sets RAS base to NULL if 
the type is not a port.

>> +	void __iomem *ras_base;
>> +
>> +	if (!pdev)
>> +		return 0;
>> +
>> +	if (event == AER_CORRECTABLE) {
>> +		ras_base = cxl_pci_port_ras(pdev);
>> +		__cxl_handle_cor_ras(&pdev->dev, ras_base);
> 
> as below - one line should be fine for this.
> 
>> +	} else if ((event == AER_FATAL) || (event == AER_NONFATAL)) {
>> +		ras_base = cxl_pci_port_ras(pdev);
>> +		__cxl_handle_ras(&pdev->dev, ras_base);
> 
> 		__cxl_handle_ras(&pdev->dev, cxl_pci_port_ras(pdev));
> 
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(port_internal_err_cb, CXL);
>> +
>>  /*
>>   * Copy the AER capability registers using 32 bit read accesses.
>>   * This is necessary because RCRB AER capability is MMIO mapped. Clear the
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 887ed6e358fb..d0f95c965ab4 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1027,7 +1027,7 @@ void put_cxl_root(struct cxl_root *cxl_root)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(put_cxl_root, CXL);
>>  
>> -static struct cxl_dport *find_dport(struct cxl_port *port, int id)
>> +struct cxl_dport *find_dport(struct cxl_port *port, int id)
>>  {
>>  	struct cxl_dport *dport;
>>  	unsigned long index;
>> @@ -1336,8 +1336,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
>>  	return NULL;
>>  }
>>  
>> -static struct cxl_port *find_cxl_port(struct device *dport_dev,
>> -				      struct cxl_dport **dport)
>> +struct cxl_port *find_cxl_port(struct device *dport_dev,
>> +			       struct cxl_dport **dport)
>>  {
>>  	struct cxl_find_port_ctx ctx = {
>>  		.dport_dev = dport_dev,
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 7cee678fdb75..04725344393b 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -11,6 +11,7 @@
>>  #include <linux/log2.h>
>>  #include <linux/node.h>
>>  #include <linux/io.h>
>> +#include "../pci/pcie/portdrv.h"
> 
> Why add the include?  Maybe only needed in c files/
> 

Ok

>>  
>>  /**
>>   * DOC: cxl objects
>> @@ -760,11 +761,15 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>>  #ifdef CONFIG_PCIEAER_CXL
>>  void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
>>  void cxl_setup_parent_uport(struct device *host, struct cxl_port *port);
>> +int port_internal_err_cb(struct notifier_block *unused,
>> +			 unsigned long event, void *ptr);
>>  #else
>>  static inline void cxl_setup_parent_dport(struct device *host,
>>  					  struct cxl_dport *dport) { }
>>  static inline void cxl_setup_parent_uport(struct device *host,
>>  					  struct cxl_port *port) { }
>> +static inline int port_internal_err_cb(struct notifier_block *unused,
>> +				unsigned long event, void *ptr) { return 0; }
>>  #endif
>>  
>>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 93992a1c8eec..6044955e1c48 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -130,4 +130,6 @@ void read_cdat_data(struct cxl_port *port);
>>  void cxl_cor_error_detected(struct pci_dev *pdev);
>>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>  				    pci_channel_state_t state);
>> +int port_err_nb_cb(struct notifier_block *unused,
>> +		   unsigned long event, void *ptr);
>>  #endif /* __CXL_PCI_H__ */
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 2ff361e756d6..f4183c5aea38 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -926,6 +926,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>  	return rc;
>>  }
>>  
>> +struct notifier_block port_internal_err_nb = {
>> +	.notifier_call = port_internal_err_cb,
>> +};
>> +
>>  static const struct pci_device_id cxl_mem_pci_tbl[] = {
>>  	/* PCI class code for CXL.mem Type-3 Devices */
>>  	{ PCI_DEVICE_CLASS((PCI_CLASS_MEMORY_CXL << 8 | CXL_MEMORY_PROGIF), ~0)},
>> @@ -974,6 +978,19 @@ static struct pci_driver cxl_pci_driver = {
>>  	},
>>  };
>>  
>> -module_pci_driver(cxl_pci_driver);
>> +static int __init cxl_pci_init(void)
>> +{
>> +	atomic_notifier_chain_register(&portdrv_aer_internal_err_chain, &port_internal_err_nb);
> 
> Long line that you can easily break.
> 
>> +	return pci_register_driver(&cxl_pci_driver);
>> +}
>> +module_init(cxl_pci_init);
>> +
>> +static void __exit cxl_pci_exit(void)
>> +{
>> +	atomic_notifier_chain_unregister(&portdrv_aer_internal_err_chain, &port_internal_err_nb);
> 
> Long line that you can easily break.
> 
>> +	pci_unregister_driver(&cxl_pci_driver);
>> +}
>> +module_exit(cxl_pci_exit);
>> +
>>  MODULE_LICENSE("GPL v2");
>>  MODULE_IMPORT_NS(CXL);
> 
