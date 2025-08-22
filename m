Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797FA20EB
	for <linux-cxl@vger.kernel.org>; Fri, 22 Aug 2025 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885694; cv=fail; b=cz8ZKLUBq1LKqpZPaD5ADHMexrk0PvnAwzjXc7XZOH3nU19nP2L+2AN3ervrPuKkmSK5MRDtuGyCF1jRNv1GQiDp1yENb4ULc2YRdUf3cjjTWjZaFC/zW6HvvbiJ6XHrFZm+/iI7fDN0Q1afRaCQKfXFI05LSgZONInCBxvJFFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885694; c=relaxed/simple;
	bh=qoJOSjml1FqLPnkFAu5fRslsnAZgfcko2CGi0mykssA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Zhu/AnLjN3Y8RUDNj/dOFItd3z3fZ7Gq87CH5MMXIDloHIpE4kybLKHkrAZ6qX5JbOcnLWN08qRYzilKn/FBumQ7BCr93zPPCT/eYdAf5U8SHcs06AaHc+fOq3DRl/Nw6TOjJqhjiXjCwdcIUuqMcAWms27tEqRPf3qKhkJiVQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I48JpnC/; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I48JpnC/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQ8wz9Uj2lT8R9GSDA1YOG4XkedDTpNASsh7qYoNqqu5smk2dQDuiGYFGszBrPHVU8MijKKwWYnFDksdG5X+KMRuM3/76cnrrmKfZGv+yNK09KCzc8px+tZcBsvJuvnKLSEq3I8lEvjRgNvl4+5ZBW44kHKy76XbEhHJWy8A5ovrsxAIIu2WLrbtEbW7vsIeP05oYNg6LzwC/PaRKbF8lw7Zh+9/he+Kn5I2xAA9SjPI14F5n0wqVVgMfRyUuQBkcyu/ajeWXobseW+xyPh5HQy3HshylE4ocVZkl/NfkEvuzrfrDcqsWgKwozgZm0RYxe3ZMA0V7HzdJE+Z8k7ASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIj9Qw06KBJ2/7wiRQ/6qVG4ozXhx7OOIDJo6GtBx0E=;
 b=TcSo1IA654VwfQZSWV4GLOB1dGEK6hCpNycFqRs5u8k2YdluCIPOQ6rcCxWOV0wjrLkJ0aAUySkWWjRioNolKKNVmXqfzoFNO2aADMobqBsTsMqxH2UG01x2lPTSdPstg7K7dK5Pyeqxn1ReKzIJB3vEpnygyIlyKa58FTRSuPfDSPs6bJd54n0cTfOUej23VO8I8aRTVlC3o0QSfMcrVlToQHPFvM9G4Laa6wLdOuXD62+FIhm/TWnPlTo7aPglDqOW+ssP8Ft0IANml7PEik4E9baRDZKBTpZCDF0HkxsMafPfnaC0qvzZ+ZdwAUC6C1XrGByw9MvbLp66829tSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIj9Qw06KBJ2/7wiRQ/6qVG4ozXhx7OOIDJo6GtBx0E=;
 b=I48JpnC/KiFp97KhzmKGP6TbjFZ5p+ljaRk+J6z7VqNUlsh1X01lFqqNfgHURQFqxy/D1B4fmR/qc0eO1Ai/19TlrxV10hFobx14V4Wv+YEe/RX5Lky9X/YV3V6Zh+7KDcu89+wtSSoj/voQL9yPNjoanUTbclaA+hGdNqauCbQ=
Received: from BN7PR06CA0054.namprd06.prod.outlook.com (2603:10b6:408:34::31)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 18:01:31 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:34:cafe::8) by BN7PR06CA0054.outlook.office365.com
 (2603:10b6:408:34::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 18:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 18:01:31 +0000
Received: from [10.236.176.149] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 13:01:30 -0500
Message-ID: <c01e3f6d-bc0a-4372-8808-535698a28411@amd.com>
Date: Fri, 22 Aug 2025 13:01:30 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/18] cxl/cache: Add cxl_cache driver
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-11-Benjamin.Cheatham@amd.com>
 <20250819131117.00001e84@huawei.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250819131117.00001e84@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 7098c07b-d85f-4df8-d903-08dde1a5ecd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0xQSzFoYWZ3dVRQUHZPdkw3aWVscHRtUnBjTkl0dHFydldrTUVhM1hhUDlL?=
 =?utf-8?B?d0hJU1BIVWZXWVZxdExTM0JIQ0hSOFh1a2hNWWE3U1JQaVd0MktJVVE0UHR4?=
 =?utf-8?B?TzFhaEp5U09McHVvemFBb0FFV3l3cFhuYTB2L1VZZnZMWDErRlNIci8zbXFy?=
 =?utf-8?B?ZzlXei92MDA4Z2FVYi9pTkhZK0Z6dGZLN1EyWE03Wmprd2o0S05kRzN6ajVX?=
 =?utf-8?B?OTRSaFRiRmEwTnpReHV3YndnQlI0RlhBdTZaa2ZURDQ4KytqQmg4VHN3N3ZX?=
 =?utf-8?B?WnV1QTFRZURhQW9kK2lsYURJalJta2lINHAxWlkyUTRUWXZqMlZUYVExd1RQ?=
 =?utf-8?B?TFJGRDIvU0hteHdRSGwxK0FYdncyZXE2TFNIdzVFNFhoeldlbnpJcmpLaDB0?=
 =?utf-8?B?ZGRjL1FoOTJDR1M4MzcyOXVXb1lDZ2d1SjNQb0ZjQUtuVitVQm4ydGpBMlE2?=
 =?utf-8?B?aFhMQTFEaHlBWHJSamJUYS9uSm1ybFpVSDhLL1kvM2ViZ1d5Q0w3S0QwUnFn?=
 =?utf-8?B?eWJCakFDU3kvQ0d1d1dQWkRQNms5Umh3Rm51UUpZTHpGdzRZSDAxMkIrQzI3?=
 =?utf-8?B?cGJsaWVsRlhzU1QzNlhUSFhoQlQyak9YRnd1UE1pOFFrZXNhQmMwRFhrb2dw?=
 =?utf-8?B?eUs1UUkvMWlEaFJ1RVRpbXE1UnFJeXIxQ01LQjBod1NsRXM3TlAxSUF1Q2wr?=
 =?utf-8?B?NGYxRWh4Y3lsZ0Q4Y3piUlVHbGliNTgwZmt0U09IaExYU2lwTjZmdWhnUGtp?=
 =?utf-8?B?c0RYV1BXaFNSWmpieXRSSTdoMDl0eTN3L1M0aWlqM2lzSHE4TDloVDJqbDNw?=
 =?utf-8?B?aVdra3JPQkVHYzRNVzMwWDl4N21zQ0VjcHE2Qi9FUmhqNEQ5V1lFWGxMR2lG?=
 =?utf-8?B?aHkyQ2xHdzNDb0NjK015dHdSUks2NURCK0k4aHlDcS9EMTdBZDQrbUVwcDBu?=
 =?utf-8?B?UEdlNXNiUmlGQ3h2NUlUZzREd0RxZjFxR1NMWi9oTk92a0pERmxHbFNBRUs0?=
 =?utf-8?B?bHUzVm85ZmRKMnVFNlFDeXRaaERDQ2ZOSjJiQ2J3dmtubHZFZDVLM2lNVzlP?=
 =?utf-8?B?eGtxSVpndUdOQ2NaZjY3ZU5hSVA2U2wwYTVZWDF4WmdZenVzczhXeS83anRJ?=
 =?utf-8?B?d09LMmViZ2YxeEo2RnZzYitIUGFsTUp1emphOVk5cUloYTNnMFBzUjRnTXk1?=
 =?utf-8?B?QS9hREI4VURyZFhCK0NDOWFuQVdFbFFIaXFCaHpCYSsvNEsxWnRpMjZab2Qr?=
 =?utf-8?B?T0V3d25hdlZER1YwWWtMRHdxeUtTZDJpYkJPUUJZMllDYVZFS2lDekxzQUNk?=
 =?utf-8?B?Ti9UdDQzMWt3WU5LMmhjMTFiLzF3RWVSbXhjN1ZrTkpneFkxaEc5eVZxU01Z?=
 =?utf-8?B?OTZxZC9JSUVURmR1Yk8rb0NLL01tOU5hOVY1WGYxa2dmSE1QVUFoZ1JIdThU?=
 =?utf-8?B?K1A1dFZNekE4NnJoUlF3b3E0Z3lXd1Fud0J1YlJDanJISDVjVENyZDlvcmp5?=
 =?utf-8?B?N2VpMHNLdmJiOWxuMzVuQU0xRDQrZnA1UHE3dUlXTVJ0N2NzZUllZjJJbHZM?=
 =?utf-8?B?a01ZRjI5cDJNRmFEUW5rZUVXVVhURGVhSUtibWN5RmMxVVFlK3hHUkZzbGlk?=
 =?utf-8?B?T1pvY3J6aGxiWFdPbGJHcGlrRW1CcU1lRjVtenk3WUZjL3AydGtub1c4MVgv?=
 =?utf-8?B?L1VDUjhMU0s4d2YvVy9kM1JsUzNrcEFHUGNzNzFocDRLVzhqV0dCTHpFVC9a?=
 =?utf-8?B?R0xrSUhwcEhKK25RY25XSFQvam9jRWQwbzN1bmxpZXFmbWlZaC9xdkFjU25J?=
 =?utf-8?B?cVhsVmw4dTI4T1RtWXZDUmJkOTJUMGoxUVhTMGx0YUxWWitqdEpzRnkxVDE1?=
 =?utf-8?B?eWJYVjkzWlVKeFpEVFBtazdVVkxsQXR5LzRKbWtMdU42QXdTZnZ2bHFJZjc0?=
 =?utf-8?B?TEZtSVgvRmFxR0lva0Q2VFQvUThCSCtpVmJzbUJyM0NTMmVSSDJueGhGT0xu?=
 =?utf-8?B?RXdublZXbG9wTW9tdW9tOHEydTEvZHY5YmM1NEF3dDJJN21LUEJqTUFONHVn?=
 =?utf-8?Q?PUk3ME?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:01:31.5420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7098c07b-d85f-4df8-d903-08dde1a5ecd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896



On 8/19/2025 7:11 AM, Jonathan Cameron wrote:
> On Tue, 12 Aug 2025 16:29:13 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Add the cxl_cache driver which will manage struct cxl_cachdev devices.
>> This driver will provide common management functions for some of a cache
>> capable endpoint. This driver will also be responsible for validating
>> the system's CXL.cache configuration.
>>
>> The driver expects the device's cache capabilities to be prefetched by
>> the endpoint-specific driver. The required capabilities can be gotten by
>> calling cxl_accel_get_cache_info().
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> 
> 
>> +static struct cxl_driver cxl_cache_driver = {
>> +	.name = "cxl_cache",
>> +	.probe = cxl_cache_probe,
>> +	.drv = {
>> +		.probe_type = PROBE_FORCE_SYNCHRONOUS,
> 
> Why?  I'd add a comment.
> 

To match cxl_mem probe. This series is based on the probe changes Dan did
on the for-6.18/cxl-probe-order branch. I could add a comment, but it looks
like I should probably just do a better job highlighting the base for this
series in the cover letter.

>> +	},
>> +	.id = CXL_DEVICE_ACCELERATOR,
>> +};
>> +
>> +module_cxl_driver(cxl_cache_driver);
>> +
>> +MODULE_DESCRIPTION("CXL: Cache Management");
>> +MODULE_LICENSE("GPL");
>> +MODULE_IMPORT_NS("CXL");
>> +MODULE_ALIAS_CXL(CXL_DEVICE_ACCELERATOR);
> 

