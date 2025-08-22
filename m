Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DF020EB
	for <linux-cxl@vger.kernel.org>; Fri, 22 Aug 2025 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885671; cv=fail; b=eFvIRROlTbwV14z5lp9Q7PLvHZN2LjY1AinT/jRJGiWpdo3jJRPIdeuT/T8ZY5xOSN853u7UonDqcvJFph/FYEvkyOBPrLWQviprW6FoTh4L2OrgxaKVzOPUBsncTSrVpSbu+FQMXgywdt+/0vDt/eXNfXejIn117WhnMQ7y0NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885671; c=relaxed/simple;
	bh=n1X0hokgjm4aWrRADXFcD2eg2ZT2ITdf7mEVydrsb0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GITRsAMG1XMd2Z3ha1c8Vz2mrSqSgwoBHOI2OwMrK4ExR86C7zrF4BLbuWSHD6WjQUkONXheHdnulrpI5C1rh7djtLeljFnRxRSM8fQ9uUNZDPA1AGAmF7uEKsgpP21Fqx8gOKC30hvFD1AjL3GArt80pA9i0r1Bi8J/PVkhLKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ytBYBnfm; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ytBYBnfm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAjAkn9nMQbRWtLPb+lcleOT/y6I3sQbXk+CGQS7ztsNyvcQZqbRkk5TxY7Hrb+nQl52hfuQc3p/YJwcCNE8L079dL3ANpbGHw0f0aBfXh18f3DzvFeKbvCxoxargxQd42C+Ki6AX/s3XFwTCKXOBqnBZsn/+cEm5R5huW9StnzNVsgr7ygGP5CcIk0tLBqcL3HU9C7iDBmtENYq0weVetUE2oJZ55jIMJCEbCo8nW2Mq2RzL009cBlBfTudpTOrjaNss0LeTUGp7ujpBkHCvKNGS81ySi75q4x49bBQgze/s67NnCgsRvAyrDXpWi+h/seM/cKPdR+2hzYrtk7QQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yf70CPMtCjWLBqXR52JJx/I4gulx5ke63DG0BHlLQsk=;
 b=UOeALQ0tyygwy8PLxF/IB3opVpvzF1NJDnCifmKddI5iIiR51ParIVdU9MeogrxjYyybJketZkCvGUWjgp2QHybRl5dxuzEKCsHkQ9DxUyoj7h2Xc3XauY5uCRKN+mTo+q4riFlmilSXLKy6Sh+7pcrjPW4galPw5yAQNhcVEm/CnaS+TfcxzSSO3rFegG+ic+S+zglPtstNu9Jqfhn/W6wbBBD1Hm509v+Vm15asRELeZrZvkxxfKydQaTO+kRugOLJbVjuKHaoLqxXNPiLBLfTMHmltUd7oYdv++eeURKK8acqUHZ8y5T7wvxW+5hZEhYEFCjNcV9ksDZWjk2DtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yf70CPMtCjWLBqXR52JJx/I4gulx5ke63DG0BHlLQsk=;
 b=ytBYBnfm53aat8t/mdAmKiMHSoGSI2MqaNnjJ8QqpJpxBL/QYtjgZ/ynRbvyY5ruHLWg16YX+NwnSWTsJf/WvfSOG9yBZkuLvQUJgktcc7jBeXYP3Ii/bcuv27U2+sRFnXGgJiNhcnMNpFd4c0WHTca8DLmy5c00Rp92nXvoa+w=
Received: from BLAPR03CA0142.namprd03.prod.outlook.com (2603:10b6:208:32e::27)
 by DS2PR12MB9776.namprd12.prod.outlook.com (2603:10b6:8:2bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 18:01:07 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::3a) by BLAPR03CA0142.outlook.office365.com
 (2603:10b6:208:32e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 18:01:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 18:01:06 +0000
Received: from [10.236.176.149] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 13:01:05 -0500
Message-ID: <91f25cb7-f589-4889-ad55-4c6ac1da01bf@amd.com>
Date: Fri, 22 Aug 2025 13:01:05 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/18] cxl/port: Split endpoint port probe on device
 type
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-8-Benjamin.Cheatham@amd.com>
 <20250819125723.0000549f@huawei.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250819125723.0000549f@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DS2PR12MB9776:EE_
X-MS-Office365-Filtering-Correlation-Id: f58561cf-d8f9-48cf-4436-08dde1a5ddc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1d4NUh4ODVyQTNBZFRYV05WKzJGbDRCc0IvUS9XZzBPZkE4Q1plUXozSFFN?=
 =?utf-8?B?bGM0T1VSYmZISmRtK2J1U3Y3Q20wL1E2eVZlZ3Rza0FKU1M3QmNTbjBFOGR0?=
 =?utf-8?B?YTRpVG1sSzlQSnJVckNxUktiMm9oQklrMWdLR05zVXZBYjJGRlR6dDZOZGdy?=
 =?utf-8?B?UnlxcmdBd0x0K2FFSjdRK0tEeDhpNXZPZW9haldMOVVXaTZ5K054UFZsMHZQ?=
 =?utf-8?B?aWczTGhHVW8yckUwdmc2QjNoSjR3WXZzblg5UTNnTmwyaS9KWEFhNDZMaGhP?=
 =?utf-8?B?cjlYRVY3NkdueDIwMUJ3Q3VHT29UREdsQ0FHVDhwVEdjRGJiTFU5cVNiV3Fq?=
 =?utf-8?B?WllRWW1pUXZ3Y0FacGN1WGNTZ01PSkc2M2NmSGtzKys2OVFwOUlZenBybTNV?=
 =?utf-8?B?anV0TVJHdG1uMjU4RlQrV3l0SHN4Vlk4RzF1U0kvclhGR0tFamVsbEtRbFBl?=
 =?utf-8?B?U2g1dmltZG9rS3h2Y21veUZIZDlJcVNZblBoUzROU3RGRDUwYzh6NmlrdDdK?=
 =?utf-8?B?WUNvVzZYL2ZvdW5PNHltbkFSSzhDT3FNbFZJaVBSN0wrYnVaR2t5MVJNUEFC?=
 =?utf-8?B?WEZJTkFoZ0RhcC9sWHZ0OEx0VFNTTmJBY3dsSGxhZkEyMUc3WHY5eWZUK1lk?=
 =?utf-8?B?VmpzcmNnRG5CNnQ1elJROGp3dUpKRWNIanB1SlU3UGUyNWE1R2tudEtZNU5a?=
 =?utf-8?B?aTJpT2h1NnNuaUpOeWMxdjhheklrTDk2V0tWZ0Jwb1B0VHFna1VlQ0d6UUtO?=
 =?utf-8?B?U01vRkhYbVBHNkFnNmlLTFJ1SzFuazZBSG1lL2xDTDJ5a1BrMU56QmdhT2JD?=
 =?utf-8?B?VDlRdUtFUFpqdWd5MkFvMTRPbUczei9FZXB1eWY3V3JPMG9nbDhvSWlTRENJ?=
 =?utf-8?B?cEhjWmdoZHJmOXc0cG9ROGJFYkV2bDkyTW4zV29hck14eU5wKzdDQlhiL2VW?=
 =?utf-8?B?eHlQNmVmbjM3TWZtWUFqcnY4d3hMZ0xacmZnZjNqMnZ0YVZFOHZMVHIyNkFP?=
 =?utf-8?B?VmdtdkoyNzhmQVh5eVhiSzRWM1hWZDRHcUN4aWUwUE9GT2NzaEE3TE91b3pI?=
 =?utf-8?B?bGhKTUVkYmpxVjNia1RjcU1EQS9XcGw4MlRWcmpzWnp4RnZGS0NicXV1WHhR?=
 =?utf-8?B?N1ordXlGbDNHTitnY2E2N3U2YnlGOWF2cUpHcVhwVUZmTEJhcWtqNXRXcjR5?=
 =?utf-8?B?MEtweEpoWHdGTFlyRjI1ZXpacVFkREV1TFUzYm10MWhsL3BoTGdZMzBQSktS?=
 =?utf-8?B?b25nVEx3Q2tZOHNCOEcrMWdXNklQRzZMdG1OQmtBeFFsRzBGT0RXbmxzaEw1?=
 =?utf-8?B?VkR6ZE9IellyY0xJeEtKY1lLS2JLUm51WTROV1pzZnh4WFprcE9WSHQ5Wkh5?=
 =?utf-8?B?RGNqbXhhSmxvRkFKeGIvaE9JeElXZ2ZCRE5uV2FBM01lOVVHWHJZcEFpdXh3?=
 =?utf-8?B?Mmo0Qm9hRE5wRnhpSXRueWFWeHFxTTJBWkhoSi9XcXY4K1ZwQ3l4MUVRdHl6?=
 =?utf-8?B?ZW5YK2RIcENucGEySFY3Wk91LzlwbFowZHQ4NWlOTDBWd1JpYkdiRDN1NDZi?=
 =?utf-8?B?dlREVnZkWThBNDM5ZFdMTXJrSlFsM2tJbXFibEdVNW9idXpKdlp0Zm80amZu?=
 =?utf-8?B?emI5YjN6SU51ZmxSdnR6ejFJc0tpbTZjM292TjJDOXdGT2RQcm5Da2ZDQmw3?=
 =?utf-8?B?QmJaZTlnKzBQQkJRVlk5c2hSVjdSNlplZkx2dTB4eC8vdU1iSDlweUFoM1pX?=
 =?utf-8?B?b3dpRE1CUVdZTURqYlU0ODFTMTJpa0xiSEdiQS93N2Z2d2dsMVg3S2dRYUpY?=
 =?utf-8?B?UGN3aGFXbmVTanNGS0NMcERLU0dsL2Z3T2ZQZGlwU1p5cHpBZ1I2M2JDVk1R?=
 =?utf-8?B?TENuaXRRMFhzUFErMFRJamRqTzhqck1UbVR6K2xLMXoxTzc3Q2VISHpVQzZ4?=
 =?utf-8?B?d3docVMvSGJ0UWFqQ1RYenpQWjIydDl6Umhnd1lrRWFUT0h6Z3F5cE9oU3M4?=
 =?utf-8?B?MnlRZjd3TmZ2bVgyZGlYOHZSbUt0MnlLK0kvcUtVRTVaRkNXVEdsSWJINGdh?=
 =?utf-8?Q?8Y/U5/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:01:06.2662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f58561cf-d8f9-48cf-4436-08dde1a5ddc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9776



On 8/19/2025 6:57 AM, Jonathan Cameron wrote:
> On Tue, 12 Aug 2025 16:29:10 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> The current endpoint port probe assumes the device has CXL.mem
>> capabilities. With the addition of cache devices, this is no longer
>> gauranteed. With this in mind, split endpoint port probe into separate
> 
> guaranteed

I can never spell this word right, will fix it.

> 
>> functions for CXL.cache and CXL.mem endpoints. 
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> 
> 

