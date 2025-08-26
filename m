Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6B7233D85
	for <linux-cxl@vger.kernel.org>; Tue, 26 Aug 2025 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756204974; cv=fail; b=Nn6MCj1F09YPY7SFH6ik+Tinf6hfx5R+UFy7ggPD7HLJxkvA3jU7A+IZOMU1lKDuESKq2QBwDE6p5e8qVy0RGdLPEc6IoZzEfyo24TNZtqtGpKM3MyvBvmobZYyOmrFPueWbcjQW8E648KXFpGADfohieQPVwvhsWDzX7tVo92I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756204974; c=relaxed/simple;
	bh=Lwmj30e0/pT6IYMm/9TTBLP7j0Xg6S7LKgm2AEi8Pu0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QbUO8qEqmbqphAbwFrq4PEvOndYKsgm/qP8Cngc6KovBvijAb3xwMCpECYg6tg9dYqQgprkTvFjAL0L1oESYDdFW84UjSTvjEg2ksRmuqGfu5KEGDM6K+OoxvxU1d2e6OM/c9jC1hkgrHfyLHnix/wr66WOSC9gVSYxwL6t4BBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YwRzKP2P; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YwRzKP2P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0TDuGzdrGAlYDLMKm809we+g6+w9tCYjeUpaZydBMzIYdvxAefyK9ToyueE3YzeSpnBAcWpCq60aVnXw9iG3ndB4hbyGomZ77VsrQ/713JnQA2Sb6XUhVfAfDgk90mXB1GR+z5wQjPESvuwLT8bxU0Qc+gahnEHaaixARKDnm0XUM7Mv87taaaXEIoonoNDY6YtFR8gCbsp3oOZNwmvwvMBx1eXDLX4DGyFh1vhmOKWdh1e2wJqZS5kNCdjYnuS2txvJzHpAA3Y0FEJju2iYyvtdHTQj5oi9YneMlZlj2G+lG/azdy3s1lfxgfEqbwF6TF55MpBAJeavhAxXzqZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMJoUCtmTMCjoKhg1EzS2soc8jv547KF22+CNDHr6sk=;
 b=fnKbaRs7T++BpkkkF/zRFptz8W8cKGyaB8yS2dfaX+Zm7QPSyAkbqfnYeNobXBuO4kSFZArsAamj2EZAa+m8FUD0wJCK919C7On2lVvU9e9rsG45h+fVlbix0+BD+9L8rr/V2+hACJYcltwn/D/xXPRCGdSFshl5VyEPFU4ntV5/XDLHPCDJ727XW0XKigN0CX+PH/89h/CqKbu7+m2vGkZC6XjvlLQV+H+bpD874DrR/LBaqCcKXJJHUgePwv3m/IykojFaphXE3/5CEKmU1Jc25O32zhfZUA1c9i0fpNZCwscTpm7gzgQ1xl8ow/00PrVawRLCtz8jKFf+Cy1ZjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMJoUCtmTMCjoKhg1EzS2soc8jv547KF22+CNDHr6sk=;
 b=YwRzKP2PZatifgxU8s0kvNAXYWnkNyH2tDHKUlO6XHBbk9TgzGdqwIYZC+2FvzP/HDuJt8bS4R3jrA8uqAubCQkQY3b6i2oXVIHj6RrVgYkx+egc4zCYuRBgeYm/2GWzxgzmt+MI0rdQJEKZoetYR8Gg5g1QJksMLrT9aQWjpPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Tue, 26 Aug
 2025 10:42:49 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 10:42:48 +0000
Message-ID: <ab0d53b8-55ad-4626-81e9-490de9d274ac@amd.com>
Date: Tue, 26 Aug 2025 11:42:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/18] Initial CXL.cache device support
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ben Cheatham <Benjamin.Cheatham@amd.com>, linux-cxl@vger.kernel.org
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <f3ac894b-7c8d-4f9d-9bfb-d05c7d7c5650@amd.com>
 <20250819165754.0000015f@huawei.com> <20250819170547.000008da@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250819170547.000008da@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0431.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37d::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec25019-3476-44e6-5e34-08dde48d4c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHB2Q0hHeWxXSlRXdG1LcHhZNTd4VzlIbnpLVmMvTndLNjZSZEFqMWttUnN3?=
 =?utf-8?B?cmJqSEFsTTlzelU5RlNCaFFBZmMzdXFsL1FpYUt2NjVBVG11VC9TWGh2by8y?=
 =?utf-8?B?NE5QZGxGYUhFR2VCY095TXF1ei9laDFRWkJwQ0NEbDUvNWRsL0ZOY0pUNUFE?=
 =?utf-8?B?dEJqTFN3K3FTZUdLdXBJMnJiWTU2M3BBdG9tL2EyWEhUaHVHa2R1TkNpUkVi?=
 =?utf-8?B?LzRUZHZJbjNNZ2U3YXBlTjByUHkxaTYwb3Y0R3UrK3VPVmpWRTVBZGtITU5m?=
 =?utf-8?B?THRScEFvNGZaelUrSjdsSmFtMU9oRXpUM2p1U1lhT0hwZjBPb2pIYWRLQjF1?=
 =?utf-8?B?dDg1dEJpb0lYY1dKN0RiTVNsZkQyOGlGbG9GT2dYMFppN0VyaktYK0pxVXhU?=
 =?utf-8?B?VjYxSVovWWMwcXFYTVMrZ3VoZ2t0dmdZdS9DRWszSkdidzgrMGZiVllObUVs?=
 =?utf-8?B?dGF6bElaNUY3bmo0Y0hsYmpLQkxkWkdnNEk4THBnRDcxWVgwTVNqUisyVk9l?=
 =?utf-8?B?b2tHYWQxakxabFB6M1l0MVpLV3RaMFF2Skx1Q1c4ek5zNmtQQ2xERWNxYUJF?=
 =?utf-8?B?YUJYcmcrL2VPN2dySG1Mcy8renE0RnNmVkFYN1drVGF1aENqc2x3TGpVNW8w?=
 =?utf-8?B?ZUlSelUzOXJLVW9ZSFBqSVhVU2RIUFV1ckhUZmpVSGVHUWRnRHQvQ2IvaE5u?=
 =?utf-8?B?KzhmUUpvb2FNSnZPcnE3K0h5eW9DYVRncWhoYTIxMzVKcG9ua05KZ3pRdUo3?=
 =?utf-8?B?TitXbEhHbUxRSHpyT3RaUzBvcXp3UE5kOC9ZN01FcHdheElBK3FGMStSdFlo?=
 =?utf-8?B?cmVVWTdrT0NSSnNyd1JaU1BWeVJhTjFLeDRhbVdHWTdtUUxWZDFyZzNIZmkr?=
 =?utf-8?B?ZmZBdytOQ2VaNDBpTUpGNy82MC91ZEhYUlhOQ2ZBVWxwZFBNWGJPVEpwa3lE?=
 =?utf-8?B?K2I4QUxWU3ltd3U0NVY3Yno3eElueVUrRk0rLzM0bXRYZzN5YkVxS3VVSnF4?=
 =?utf-8?B?NzF4ZWZPQ0t0b2pTWEdNbDE5SStFVk1LN2NKSUs2bnZkaTlNTTZHUm1GZTBR?=
 =?utf-8?B?Z0ovSkZMcmhwQkxvMTJxUlhhQlFLOVNkTTRraS9hZUpVQkNYT3lhcHg2WWFM?=
 =?utf-8?B?SFJVZU5zZGpyc3NlWWRjM2dJYkExeklyajNlcy9qK1dOVU9HVVd1NEU5Qzd1?=
 =?utf-8?B?ZnU4a1RjMnc1T3NDMkw4ZTZGMXNpeWlreCtVdGpuRXptRFMwMVZvMG9mY3M4?=
 =?utf-8?B?UTJZd1ZlVU12bnZubzI5eFFCaHB4V0hzM1NIQWNVeWQ5UHYzZnZuSGxPZlZr?=
 =?utf-8?B?M1pzbjgzTWdRcVQ0V3l0SEJ6UHFRSnRBMDdtME5ZK0w0enExNjdCbFVQcTFG?=
 =?utf-8?B?bXNDaDlLOUhRVlRNWlQxRi9XR2o2VWdBSFNnakZEYXhQK0JxcTNSQ2w3R1Vi?=
 =?utf-8?B?N2s0bVkrOXZUaEo4QVlsVHVqaTlnRHlZTkhSb3gwZWN0ZHdRaFBlaU5jZEZI?=
 =?utf-8?B?L3gzcmtlWGVTSHIreUxoRTJPRU10LzcyYWV4cGZYNVhUSm1WeFFaYTNjYkpQ?=
 =?utf-8?B?YnZrUnV6enlxanhtZ1puakdvbGVoVmVXTnYwZHNzT2txUWg5Z2lZQldjd2Qw?=
 =?utf-8?B?SEpOWkI0KzJiY0I1WnlrVmNkRk9xcE1PZ0w4NmNlcjNpY2ZCREgyQ2RzUDFM?=
 =?utf-8?B?dXlmQzhQbkJQYnk3SURqa01scU43U1dBVnZoRnRTdEQvakZyT0FXTHVHZDFw?=
 =?utf-8?B?em10cFA1NEg2eFpUaXJPVXJONUVONUpyY3VHZDNmaG0xQkVRNjVZSWVndlBN?=
 =?utf-8?B?dW8wdXpkU0dzUk1TRjlyRjAyTU40akV6U2QzTFprS3hXazhtSUpYSE02WjB3?=
 =?utf-8?B?eHY0Tno3djZLVlJBVUpLcTg2R2l6VzdoUFpPNU83TTJHOHlyb0lwRFFvQ0cr?=
 =?utf-8?Q?MX2a6s8aDCo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFllNDQ2ZmYvVzMwZEI1SlZvdjJvRU5rYk5pb2c0bzgwMUF3Q2NSeWZqMkNl?=
 =?utf-8?B?TnpHRGNhS1BHUldRaWdONnFQTzF4ZStSL0NHMExmUlZWVEJBUjNmdGtNbVFU?=
 =?utf-8?B?ZFFIZFFnOU9wWHdrQS8ydEhWQWZRY1NDaWZvZ3d0T290c0l0ZWt1bWZ3SDdS?=
 =?utf-8?B?UHNuZzlKSzQxK2h1alFVdElhQjB5OS8yZEFnczlmSWtaMEtGWEFyYjdRVHZ2?=
 =?utf-8?B?RXZoeHBHaXJjVEozd0VlQkdZYytBczUwbTFKNk1KOW5kWXVuMXcvNDNKRncw?=
 =?utf-8?B?QzAxbFRWb3k5Tnk0aDJvWkRxdnREdFpPZ3VuTUlKcjRYWUFxYlhkOGRnYTAw?=
 =?utf-8?B?dk9wM2Q2ZjNvbFczSWhScjAvQmxUMEhpNy81dUQrb1V0UkoreXFKa1JJL2t3?=
 =?utf-8?B?MHV5UUgyeER4Y3ZXMG9iRnd2Rmw5aEdNcEJtNGZlTWk4c2JWeDVibTdwQVJu?=
 =?utf-8?B?TFNJVjd1NzlrUWRsc3dLZWhuRVlGeE1OYWZGWkVxOVZQQzhuVndNUWtveWdh?=
 =?utf-8?B?R05aK2VqajJTY2JmMDA0cVJkcklYSDIvUFFRSnZ1TzdTTFV2bVBCYXlJS1dm?=
 =?utf-8?B?NXVHNytlcGg4YjJDdWZZVkswT0xndFEvNGR4VjY1TXZiRElweUNKbHZPOE5k?=
 =?utf-8?B?MzM0eFJubmdhMEFDd0dWT0JKd1VaZUJoZVUwNVZRR1phYW43KzlWTk5sZGtk?=
 =?utf-8?B?R053cm1NNkJTbFk3eHNrQU1tNHV0cm1LNmJGU2dqbkNVL0o5REtyVHNxOVNq?=
 =?utf-8?B?cy9vd1dQSUFJNmRUUXVTcTlLMjhiekIwKzdJNUlDdkh0NmpPaDlnS2laaW50?=
 =?utf-8?B?Tk41SUdOZEJVS2hETEVVWHdrT0RocW5vaG5uNEFVSUVuWDZydFZ6aWZITWo2?=
 =?utf-8?B?UTBsN2xPNmZnZDFJd0dOL3MwbGNrMTNrdXF2Y3M4Z0xpMHNyN2lqTzVJVWhP?=
 =?utf-8?B?azdyamJZS0V6MFcxczZMNmlxZCtzaGNQSG8wTUMzamFwVTN3VTArVDFvTzBn?=
 =?utf-8?B?RGx5aVRJZ2x3NEJxMUZFSk5zd1I2RFhqdW5YSzF6b0J6N3VNZlFsbzFvdllV?=
 =?utf-8?B?bWZZTS9ranZxY2FYa3JiY1JXSGp4NlM4eTYwRXpTLzFQeHNYQTFXdnlaOXdZ?=
 =?utf-8?B?bGNFbVdLVmI3ZzhRaHVVelk5c3FPRFpVdmpSQm4rUDR0M2svaVBQUUxTRmRp?=
 =?utf-8?B?RFNudDl3YTZSUjdkRTdMN0o3OWIvamppa2tzcURPNGVFQlFrUndjMnd0cjdK?=
 =?utf-8?B?N1g5M0IvZkNJZ0FSN1JlblBMbTlHVy9QV1VneXVsd0lZUFo3OWM0RFBhdUti?=
 =?utf-8?B?UkU3MEdnZTdTeUNWT3p2aXN4bGR6N0ZsUmNuTlBSZDVJR1paemwxUE5PelZW?=
 =?utf-8?B?aWdQMkk4K2pIdDV6ZWdiT2dYcFBUMEpWZ3hhWURRV1dMK2FkMDR3a2F4Vy8r?=
 =?utf-8?B?NXFCZHpjakFQUEZkbE5PVWJUZFk0cGY3bnpnSngzU21zSEp1ZUd1aTBFNmV2?=
 =?utf-8?B?Sm8xVUs2YUFQZUlZTFR3ak1ydE8wUFI4am56bENjVHVNc0hFcEhSdm5PYjRh?=
 =?utf-8?B?WVBGWm81alJLaTFhdnNwQzdtODZmVm9QU2RHUjFHSXlTOE1zY0hTOWlMaFM3?=
 =?utf-8?B?ZzdWN3EwaXRZYlFkNEFTbWs4dDlJdDBZUFMvcmZmaUpLTHhRTWtSb1lHTDg2?=
 =?utf-8?B?RXBVekFWQVc3THdSaG9TcHdOZVJWdHI0Z3JNSmZackN0YjhiOXRMQndGd2RC?=
 =?utf-8?B?Z1V5dUJlYU9ma0YvQXFZSDZISVF6M1l5d2NNUXBod3ZTdnI4c3pSSVlyNUFt?=
 =?utf-8?B?VjhKK3pMZVhYOTY5UWdaSGpoL3QrcmtMVGlxWklpTnREQUV6TzQ3WDB6bnNJ?=
 =?utf-8?B?VDdIOWVnRS80OFUzY2FJb21NU1o4MFlWN0FaUEZiWnc5cGwyWWVNeExnbExt?=
 =?utf-8?B?WlViV2RrWnp5SUhUREtxUmdORjN0WjdSaDVDaUMzL05WTFA0NDJ2SG04cFVw?=
 =?utf-8?B?WjRZeXNrSlNQSFZvTVZCT0ZTbTI3TzhYQ0xQa1J1MzRiSlpuRW9zaHBIL2dk?=
 =?utf-8?B?WnR3UTJTSjJwVDM1SGZVRVZ0Z3hGcEN5VjhiVW53ano0MGdDWEsvdUhoSEpQ?=
 =?utf-8?Q?TLcMgTRuAyb8ua5yezrpfynIo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec25019-3476-44e6-5e34-08dde48d4c5a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 10:42:48.3461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSwbWMiXKCUDGhwvtmK7NpQ1VMDg5W9pn983SMlYI4SQlWEC4CCnRepAi7WBPEFazqrswHqYfj4Cjpak1FJo2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258


On 8/19/25 17:05, Jonathan Cameron wrote:
> On Tue, 19 Aug 2025 16:57:54 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>
>> On Wed, 13 Aug 2025 12:25:12 +0100
>> Alejandro Lucero Palau <alucerop@amd.com> wrote:
>>
>>> On 8/12/25 22:29, Ben Cheatham wrote:
>>>> This patch series adds initial CXL.cache support. What I have here only
>>>> allows for adding a cache device to the system, programming/validating
>>>> the system configuration with respect to cache devices, and some basic
>>>> cache reporting/management.
>>>>
>>>> The general philosophy is to have an endpoint/vendor-specific driver
>>>> that runs through the same steps of adding a cxl_memdev, but for the
>>>> cache portion of the device (both type 1 & 2). Getting cache support for
>>>> a CXL device should be as simple as: get cache information, set up the
>>>> memory region (see below), and then calling devm_cxl_add_cachedev().
>>>>
>>>> There's a couple of things missing from this set:
>>>>
>>>> 1) Missing an endpoint driver
>>>>
>>>> 	I plan on submitting a reference driver (type 1 or 2) with v1, I
>>>> 	figured I'd send out what I have before going much further.
>>>>
>>>> 2) Mapping/Reserving host memory used for CXL cache(s)
>>>>
>>>> 	I'm thinking this will be handled by the endpoint driver, but I'm
>>>> 	not sure what mechanism would be used and whether to integrate it
>>>> 	with the cxl_cache/core. Any thoughts/ideas here are appreciated!
>>>
>>> Hi Ben,
>>>
>>>
>>> Good to see you working on this. I'll go through the series these next days.
>>>
>>>
>>> FWIW, I did send a RFC last November about my concerns for
>>> properly/safely supporting CXL.cache.
>>>
>>>
>>> I had no time to keep thinking about it. Also, I sent a copy to the
>>> kernel iommu mailing list, but it did not get traction then. Anyways, as
>>> a summary, I think mapping for CXL.cache requires not just the endpoint
>>> driver doing it freely but through the cxl core for ensuring it is done
>>> properly and safely. But I have to admit this could be a
>>> misunderstanding about how the hardware is going to allow CXL.cache.
>> Perhaps it's time to restart that discussion.
>>
>> https://lore.kernel.org/linux-cxl/cc2525a6-0f6a-c1c8-83e1-6396661efc8a@amd.com/
>>
> I hit send too fast.  For that thread I'd suggest we break it down into
> the various issues you raise. Make it a bit more bite sized!
>
> Some such as trust should be relatively easy to tick off with the work
> Lukas is doing on attestation (or the version that uses confidential
> compute infrastructure)


I think that is a good approach. I will try to do so asap for maybe 
presenting the discussion in Plumbers.

Thanks


>
> Jonathan
>
>
