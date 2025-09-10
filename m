Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4F32BF32
	for <linux-cxl@vger.kernel.org>; Wed, 10 Sep 2025 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519548; cv=fail; b=nPrQKywr0cf9rnaTrPJWHc3lrAqPCpGoOkUrVygZlYbVrw4diJAbKd3a2wwtfvXbSvx/8YxRTqQx+aJKUoZ7s8JjNEBGIaoF/a6qwa3EdKMTfo1nXeHCMJ5fHVdQ2VKES/XXphY9jUTS1dt0VWjZ+E+Mgp8C0aiDCsw0vJQgRDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519548; c=relaxed/simple;
	bh=Co/NHG4MflUl9ykIICxqz75XfUQW4cUR3rEi7c8mxEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=arPhmhoBvo5uIEXg98KuzuquQWTc1qQjRDWuW3F0pO24D17LTKqA6OkarcZxe4gpbuA3cG6KcQxodb1jCngALsVLnTorWgqbgF460YHxUzvQQEmm2+6W787HxOf/AFxKDyurxpVs0aJJ9AOtMUNGJHnP/QkD7IseyRwwDJAMkoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nNFM46l1; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nNFM46l1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sM5Hsxv2wR9lh+NMp4Oj9iBvClMi47FwqoBnYX7mxw+rLNMQs8l1Z0ooh0P/4QwrCRkCrejH/8Opmid7UtjjN2q++U3W/ELIo/EqKbrG6irVi/WnbqZoWppK9peNIPuzBPtisamsUmeTcIJbzFFV+h5yfyf1uw72awC9B0+EVqynO5Dgk9FJtmKsAofqkmLD8oq6NMeq9CcInIMivXBsrAIHPdUl5TJMOWpjYCIFrEAFOHyqujVBAH4sWCgnUW0LhDDgTz2p0NuxsrT63/TPrXwTC4fmj8ExYWUbPpAfqXeb83AxyA/JnaWS3m8NeaMOoMUq4iNSJL+4aJtxcgWVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQrVYNyPepL+NXqS4xrcYHLPPYSGe8AUD6ur1mQDq8M=;
 b=MAjA9hV0VGjyQLiznyxORl31X+MgSsyLlw6jKirnQSJxs1pjvIPYqM7Dd5vKOQRcZxZgVw13eqw9Dfy8kKD2+/wf1myMV7orw2SE2mIR2SFGUqrmhBsjC8b5WzTnQZvOkuQykt9gU7LZnueYWXiko+VqH7nTUT0VMPHiY3cYhH+zQOfj3pA3zFpq3NdeOGZTOJJIKAg2z9esGTUqD7ixBJaCNgRfffg0WxY36BZ1WWnFuseffDTFACmuHhCctyR/pa2ExJhwoWQufAxXgfAlr7we3qQK/M7XdZVKEfUjEorMwb7h5vvgoCrJ3MHIwsP5hHjd2D0CyGvR+X7PKk0ZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQrVYNyPepL+NXqS4xrcYHLPPYSGe8AUD6ur1mQDq8M=;
 b=nNFM46l170FaSbSf/sWNsF/kbRQZMWqkVp6+mwKpWRSGL2n6EU7BaQheYjMcSjze/CtQn0L3qcGJjxdivWaHebntfTtFUz5UKFm9vYlMPo817LYumoDhXtzBXD73w3ozG9rk8tiNaalq/oTjkwqlsFg+R2SOPlRCf7S6RuIDEZU=
Received: from CH0PR08CA0020.namprd08.prod.outlook.com (2603:10b6:610:33::25)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 15:52:24 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::1d) by CH0PR08CA0020.outlook.office365.com
 (2603:10b6:610:33::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 15:52:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 15:52:23 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 08:52:17 -0700
Message-ID: <73db9453-e451-4c12-a851-8d9792a2bffd@amd.com>
Date: Wed, 10 Sep 2025 10:52:17 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/18] cxl/cache: Add cxl_cache driver
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-11-Benjamin.Cheatham@amd.com>
 <d0bb728f-f993-4b5b-ad02-336c8b1bff6d@intel.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <d0bb728f-f993-4b5b-ad02-336c8b1bff6d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 741e8fef-d3ae-4fc8-bd24-08ddf08208ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWhWVHJVMkJUcDNOT3B0N0tMSC96Z1lWUUxVR1MvdkFjUktwVWFKZkJVTXNv?=
 =?utf-8?B?YTcybVJtdnQzWStRK29YeGJoVGZQSjV3T3ZVSUpGdGpTZTVsTkllSzVaQ3hi?=
 =?utf-8?B?T2U3b0hWbEMzYXBZRi9DOUNsZXN4TktXVHgyU1BEb2h6Q3BZbUpWS3ZjUWgz?=
 =?utf-8?B?WVVFVFBOWTNFWVlNSGdGMEVnK2FsUit0UXVFazQ4QjlNSDJzeTgrMG5JdnJI?=
 =?utf-8?B?RzhKdDcwV0YrU2VFak8zbDdjWFkvVHZXU1ZxbWVxY0VkdDFxVjZqeHFlTE4r?=
 =?utf-8?B?cEIzd3dHaitYblY4c3RDRzRTMHJIcGxwNm9Kd0N0UitqRWdVcGozcERXQ1Iy?=
 =?utf-8?B?bUt2VWRZMGJXcHBCYkVENFBtcSttOVUyUTI4RTFzdlorTXVCckYyNkpCMlZM?=
 =?utf-8?B?NDFzVWRkeXlUYXRYUlIvNGdVRXpDcEtmT2ZsSklGaHlnbXFFMmorcFdVR0h0?=
 =?utf-8?B?aDFqWTJrQUMyS3ZicndvSkRac3E4a21nRDV4SVNLaVVzV1JpMDlUOHhtMFRp?=
 =?utf-8?B?NTNWUUVyNkdPUUExVDB1ZDRoUWtvMTJuRDYxYW16WVpGekZCcVgrQXJUbW02?=
 =?utf-8?B?YVIvWHQ1enNaMTA2ZlQzSjZMenVENFFCYjFvdFoxUnNrc3Zrc1ZqNk9FOEVX?=
 =?utf-8?B?Y21IakE4MFNiSVRmSk5ITmJJUTRKQSt4S3JoaVFIeklqeERJVHFmL3k1U3pL?=
 =?utf-8?B?SkpOVUJRUVF2MnZPKzBJdkxtbnIxUmVHMVNsZmR5amFHRnBnVEFWdk5EbXpR?=
 =?utf-8?B?alpRRnBnOHVUaG8wWEFYRkVicU55MUJjYXhwK1VHdzhMZTBWYmNOK2pacnVm?=
 =?utf-8?B?NTdxOTZXekUvM1E1cUJEL01zZzFycnFkUzBJaFlBdWI4UWlCWWRUWDBUTzFE?=
 =?utf-8?B?ZklQNlh3NzlQbFVQckl6aW9zK0QzK0RMdDBOMCtiTEdVT2t5aTJpRy9ScHJU?=
 =?utf-8?B?YWFNYjgvZUZjY2dzOGc4MCtWZVl6R1pNb3RxL2VVeFBEU1NLRUt4U2p4ak5M?=
 =?utf-8?B?RmpDUkVyeHRqMlZxSkVSaHNlR3dLUU4rYUxWR1dhMFp2bDJORzByQTRXV3FE?=
 =?utf-8?B?dklLdFBLb1VRY3hiWU5MRkdFcmVkcSs1cW5BeEtpZlA2cU43b3Z1blZ5cnB1?=
 =?utf-8?B?Rms0dkhBZXRkc0E0ckFZa25rQUxPWS9ZL3g2NGNSNUx0ZFZuR1cyWkZoOGIz?=
 =?utf-8?B?SmJhQUN4cWJITHl6ejJBVWFkb1N3Z3F4NWw1bVFzLzlSV3U5eXJCSld5dUNx?=
 =?utf-8?B?RWg5WmxSQkJwSldxMndXckNueGtlOFVJazhHWGxSckZMK2R5OVBxU1ZUUVZM?=
 =?utf-8?B?UTFuNFBEY1pMc3h2ai9BQS9SamhnelIwakNqNzltdGNFMkY4TUk2blVOcWIz?=
 =?utf-8?B?WmlwYlJuOStHek44eTh3VklNVW1UL0d6TlNBV0ZPOUNDaUtnK2tRaXRXVmdx?=
 =?utf-8?B?bVIyS1ZmOEJuUWdDOXlxbnNuWElSc3NybHM2V0pKdkhFVHcyRVZ5cTVMdGRO?=
 =?utf-8?B?WVN2MVNIV3h0S05UMTJEaHRUT0x2UndYS2hIZGQ4Q1hDYUplbUlkZjR1Rnh4?=
 =?utf-8?B?K3VlRzV1ZkxQdTRVek5uM1lsRHlaRkx0YnIrTm56M1VqNzNrckowOHBuQ2Vl?=
 =?utf-8?B?N0dUKzgvRU5lR1J1cGhBQXJ6OUVLQmUyanVlSUNtNXBEVVp3YVRVS2NJWGxU?=
 =?utf-8?B?NjQ1Snl5a0FocTZjYkl5MExoTUVGMzRxNDE4dVNpMmdocVdENHRjVTFDVWpY?=
 =?utf-8?B?V1llSVltckZhTTdFSVNYZ3JtRUk3SUNiSm56dE9MM0pjOWlVWEZ1OTdqbWlV?=
 =?utf-8?B?bnA2aEsvTEd5bmpzS0RnVTFwV0RsRmFIZmxuSytlUmFSamROL3JLZE15NFYv?=
 =?utf-8?B?TkdZQVR5TXNLcEtKNTVvd0ZFR2lCS0ljNU5GaVdOTXdaWWpKTkhDSTBiTUMv?=
 =?utf-8?B?R0lOYnhUR2pDVkQrMkVKb2gvdnpRMDV4SkEwUVdOMEpUQ1NsaVYybWxjT0Va?=
 =?utf-8?B?ZnlmeUVNT1J1a0VtL0lYTlZZT245b3FnTDErNmV1ZXhXTGRtVExJdmdxalVz?=
 =?utf-8?Q?3ppTDz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:52:23.7982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 741e8fef-d3ae-4fc8-bd24-08ddf08208ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165

On 9/9/2025 4:29 PM, Dave Jiang wrote:
> 
> 
> On 8/12/25 2:29 PM, Ben Cheatham wrote:
>> Add the cxl_cache driver which will manage struct cxl_cachdev devices.
>> This driver will provide common management functions for some of a cache
>> capable endpoint. This driver will also be responsible for validating
>> the system's CXL.cache configuration.
> 
> Is it the expectation that a vendor specific driver will add a cachedev when it probes?

Yes. My expectation is that adding a cachedev will work the same way as adding a memdev in Alejandro's type 2 set but without
the HDM portions. I'm assuming there will also be some memory provisioning done for setting up the cache region, but that's not in
this set since it doesn't seem we have a consensus on the way to do that.

Thanks,
Ben

> 
> DJ
