Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B00728A72B;
	Sat, 20 Dec 2025 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766213822; cv=fail; b=Kk8NwPA49OJ2sEKb12j7m0oWSRAyOUa2SBjLWwcuYpgzV7t52K2OyJjUrBUtjPtlU+M8NZleshPgkHTNt++N9cRXzDv7b38+I6wbs9Xcgl97o3UObAUMFfUY0bixcvME7BAIYgisy4Ll/icSv5pj2aZgAy3MFVk7C1hKzL/UO3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766213822; c=relaxed/simple;
	bh=tja8uYXxLCZFW6OtMoLvWbQ1fJDjDWPCR02YvSVwkSg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lAzpjwI9XhcyhBZMX2P4Hr02SG9Bq9xclwuonnyTge0gO97CTA8LLmpyA6BEQaBW7UkGnT2+2nhQgK++LnQ5mnSTqBNLK7O325tTiEDcJ1TCHFVzz9D+w7Z2AYcFEEVxXOwO8cfnOuGXRo/nO7cH/wTSvx3D0YfEJcyL1NtZK3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZCSPp4Ul; arc=fail smtp.client-ip=52.101.85.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZCSPp4Ul"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYlYykIhULp0r0oMrQl2AFkedOj0TBN7n6colFRJ4ullb1jHeUB2Aqm2BPuiB6aeIfg5LjBKsxTSXyCXi/0pyokDgHfwF0bWkLNIGBIEh2BAIfn+L5FTGp5yGh6z8OrfZon2WDPcfdo2q4Itii+V3vfal7yNCKHzeF7JGO870mDAFHUiUTQTOhOUd4o19BzudMk/q6s/1TwRacX+oYJ5VbKLw0OVHXF0MSQWN/UzJFsWgtMSOY7WbxB4DUBkyHor2X03OhNok2gYLZQ3F3WFBH/UuKR1ihIgvwhU6C7fpzStbFi4/uBd6Y2Cur72PWy52i/pg1yuG62nMRptmv99ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJMjplXCauZY/CNa4E1UEle038bOJSl/gaPtNOW7ss8=;
 b=sp1cCt3+AybLFzmFWM0WzSEPYyZ46BcTUHVMdjWetBIXAiVwe+V+SLHdXMHQNBkG9B5IxyxwctbA1wpjLaNPvoC1Ngs3soCt/Tpn+oz0yP61uGXzztAyq21FTN5UgdcE/16Ve5MrLugTWuk4ewm+N+jpnuYLZJ4n/AG+bR0YdyZQuh53yMIdpKuBR+KYLcatEkSEEQnuFUG+kY1AO15eykuSJlGD+kT6pJjGB1cH08hhM5hma7V9/NOf3IcrFjlPLBHqf92tYgY7MvhLZV+uiGF8rCFcesPFNHnovSsqhW8QVA0E5i0LExrz6Zn79MdzTd4Dtaf2ysm9JH43vr6QbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJMjplXCauZY/CNa4E1UEle038bOJSl/gaPtNOW7ss8=;
 b=ZCSPp4Ul3AxN4GM7CuZTi1dRm5MWqiIMWxSiM7kLELZgLSQsp0GdAJ9Z5bLXLUaeukLYhk+N236FkJjd3qwOoRkBLKGRyYIsaUGkiYoyy+riOk+x208XmyAWTab9sxgVkzJ7QJR1XongSerYB1lexzsglBsqEhzbrqzprekDI5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Sat, 20 Dec
 2025 06:56:57 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9434.009; Sat, 20 Dec 2025
 06:56:57 +0000
Message-ID: <e101b84e-965b-4370-b2c0-befb85185751@amd.com>
Date: Sat, 20 Dec 2025 06:56:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] Documentation/driver-api/cxl: device hotplug
 section
Content-Language: en-US
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, corbet@lwn.net,
 rakuram.e96@gmail.com
References: <20251219170538.1675743-1-gourry@gourry.net>
 <20251219170538.1675743-3-gourry@gourry.net>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251219170538.1675743-3-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0246.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::9) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a7d393-8fb6-4d17-b254-08de3f94f721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0pXMjdFK3hvZEFBSVJUNUVxVStLQUg4Qms4eVQ0UmRTZ3dBMUN5UDhCQmRJ?=
 =?utf-8?B?cUJsQklKdFlDRyt0YjBNSm12OTNzc3k5L0pwVnpGR0xtWkNRVXJBeVpzSUtN?=
 =?utf-8?B?aEFuTGc2a3BXZFZzMGFyWFlISGJENXBHUXd5VU5MZGt6b2kvdlU0RU5hb0NE?=
 =?utf-8?B?RTdxSTVYdjJURDdHbitHcjZMSHM5YlZGN3dUbDFWRGxzaTczbjVMaDJQRjRI?=
 =?utf-8?B?OVBlc092SmNaOFpLVlFzU1dMeHFFRXBQUWhpNVpwNVBEVzg3NG1lVWJkMVVx?=
 =?utf-8?B?bXUwMkxibExyb2RDWW9DYkl6Qm14NUZWUUs1cFl5dTg2N3RGWkxkSWpLRXZO?=
 =?utf-8?B?YmdjKy9lV2ZFVzJUSllld1Vob3F0R2NHU2RHdGtyN0lyWU0wSFM1NlQyYTY4?=
 =?utf-8?B?d2JMSk00MTVwbm5FbEh4cmlrQ2llWEtYeENjSUFJMGlqZnhUeU9veVc4VW93?=
 =?utf-8?B?NWRQWkJ3b1RocnZVK25MWi9oZU9VMWc5cFlnZ2RkTXBUejZhY0pBTUJERXhC?=
 =?utf-8?B?cFBONVlIb0J0NHlEWVlpY0R4U2pMVG5NOWo5YzlYeU03a28rZTlOdFowdVkz?=
 =?utf-8?B?TmNiWTkvWm1YZGpGR0djNXcwbkRNN3JISnZDd3BYTlg0WHNrNzRpbEs4b1Nm?=
 =?utf-8?B?L2FJNEZHY25DQ2dmUTF2TjdsNzkrcU41cGg4WjNVdWl6NElGb21UMnIzL09O?=
 =?utf-8?B?aWJGbStDU2FhbEp3QWJtWGd4cGNWdkIzN1RvMEhYOXhYZktmNjJpTGxDOHhz?=
 =?utf-8?B?QnFHc2tuZmpwYkpkNWtINW9QYW9XVU5iZ242eDFjOC9pTW5ySE1hZld3Vk4v?=
 =?utf-8?B?R0xRc2JaUWJ0QkxqSmYxbHdnbEgvM3VGdVc1OFFUTHZITnFmV0x6MTBOOGNR?=
 =?utf-8?B?aitBTzNaUlZyMHJCays4cEQwejR4YjlnL01tWFNLUnBqL1RPNldCMDU0K0Jv?=
 =?utf-8?B?SXE1dzBqQ1BvaWx6L3VRU0huZFBuOWU3Z2RQYU1oUStWazR4TG56MUFFdk9t?=
 =?utf-8?B?Y3pzZDdNYzhmTXh1dW1oUmRlS1RqaDkxWWF6RTBHZTlNQUYxWlBPVmFIOTd0?=
 =?utf-8?B?MDVDbk5JZU9UYW5TdUpXMlJUL21JRDg0ci95cFcrb3hHejhDWEdLcms2MzVS?=
 =?utf-8?B?dGtBTjNVWStOcWFOWTlFY21EajgvUFErTWxsMGhFdUd4WmduaERYemcwMHVU?=
 =?utf-8?B?OUM4TEVqZ2FHa1FIRW1tU210R1Vhd0RNaGFkMXpnZlN0VjJ0VUV0M0gzL2Ft?=
 =?utf-8?B?c2E5TFA5MjhjT1hkbUxYN2NDMjdsUlNuSTlyRVdCdEYzQUVvVDdFYmZlWEdB?=
 =?utf-8?B?MTdFVTJZMkM0VjZncjg3VDRLTWxDd0dMNk9EZTdORCs3bDVqSmE4Z2NNdFhL?=
 =?utf-8?B?SmRiVEVZUFMxSUJadFBNb3NncmlWamJuOTYzQ292VlV6TVFvTUhUak8wanov?=
 =?utf-8?B?dEFvZzVZOVBsL2JkRUIvYkh1TDV5Qkt3aTdWU0ZCd2hHTDFvVFNDbVhjQ0Fs?=
 =?utf-8?B?b2owRHlscTFMWk9BN0x0b0xkbDFyYS9GQUZzdXNTUGVMb0RmY0ZWbEN3OTlY?=
 =?utf-8?B?SFkwQWxiaUlOaklpTldFL1ZLM2RFd05uNmVyOS9RN1dZRG8zWCtmT1QrUTk0?=
 =?utf-8?B?YmpkVkJKZVhiRllWdHp6VnM5S1Vid3FqR1JBRU02SEVFdE1peFFPeFFoaU9N?=
 =?utf-8?B?Y1NsbFB1M3FZVTBLejlJS1hZMGFwZldxT2lOWEtlUHozY2tGd1RyQ05QVHJk?=
 =?utf-8?B?OTkzOXV0NGRzMHBnWCtEUW5Lb2t6d1JzclhaS2FZTW1vQ0IrVDBEVVN3dUtm?=
 =?utf-8?B?czFWV2NDMStxc3RaMGpPYlg1TkNwdUM4WWhtdjI4R3oxbGlyQStZRStlb2Fh?=
 =?utf-8?B?bGNYM2pMS2JOV2IxS08zTm5rd2FmMGxJU29sOEZwSHBLcDVXUWFDdHExZHlD?=
 =?utf-8?Q?wTjm+N5P1gU4kaKKP8M5uufQmOL3ws+6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3hoYW9tSTNsc3VwWmR0WllkTTFUTjlpRkVPcVdLNmU2OEVsa1ozWUFGZlhV?=
 =?utf-8?B?cHNjdmlkVjVUMGFNTU05OEovOHlMQmhwZExnMVI1SU5memtJdHBlQ3p2RkRW?=
 =?utf-8?B?Zzl2VzYvdXFhZVJaZndEb1Y4SHNRalNrbTdJTlo0aTdNYjdnWnZEWDA3cjRC?=
 =?utf-8?B?NVplQkZzZUZMak9HbGxDVm1pQkprNkZtTHppKzVDS3VVRlZHbzdoVmhraWxi?=
 =?utf-8?B?b0RlTnYwbjJDeWtBdWR5bHRSYmFwOXRwQ0VwZnV4RDFjN3B2NnkycjdNNm1r?=
 =?utf-8?B?VlJjTFZYUXVRK21xRTVyWTdZRkZoWHR0T2pQbEh0VEp6VURIZFg3VG8rNVh0?=
 =?utf-8?B?WlNCQ0R3VVNPdTU4N3k3NW9kY294T0laUVZEYlJ6OENvaWkrbHJTRy9vZ2hP?=
 =?utf-8?B?UG9JcitTZkpJenhNYU0rTFA5OTk1Um5oanY1MDRmbE93d3ROV1cyTTRRVG5w?=
 =?utf-8?B?dVF2cTFEbXNpTG1RYVFYVkQwR0NJYkZBVndTSjdYeEI2RWJvOEx5NjNRYmV2?=
 =?utf-8?B?TTRkYkxab2dDRzhhc1NLNkx0MkczTXErdkg3SzNGblU3blJBakptYVpiMW1u?=
 =?utf-8?B?WWtvSlJueEFtVVkxdGNQZng2SXpQbVBTNkJ5NEprOG4xYVRUK2xmdkdlWnNF?=
 =?utf-8?B?ZTN3VWNXR2pQWTNmZ3hucVY4ei9INjUvc0wyZkNCYjdpRVR5L0N0aGxUb0VQ?=
 =?utf-8?B?WlNzNmNEQ3pleTRHdDJJK3pNSWhsSGwxdkNqM2V0MWxIWVliV0s5SDlydUFt?=
 =?utf-8?B?ZENzbkR0bmVnUjBmN0puMzA1N2NsMVhpZmc5aWUxa1FJUndwTVBTQzdzUmx5?=
 =?utf-8?B?TDNFZjlDZDdVbjdUQ1pDdjNoZWVkTDVxSGhLYlVycVBCSzVJY0gzaWxCWVVo?=
 =?utf-8?B?aVRTck1wQmJkcEUwYmk3UEVaRmdvTjdDdnBmaFUyallkMVlUeloyU1YwVzE4?=
 =?utf-8?B?TUdrRWRvUmpPdnhWdFV4TjJWNGYveU9vUGszOVUxYWJIRmFNUDF2TmpkR2M0?=
 =?utf-8?B?YUt6Vy9BVk81OCtPaEZOem9JL3BsUW5La2xPVW9XcWlPQm5GTXNjZDk3K2F1?=
 =?utf-8?B?b0lKL1ZEMlliRnowUWZpNi9VdDJuckl1UUYvS0JhWk1ZQWtNeFBPTHlhWmR5?=
 =?utf-8?B?MWVBMFpvcFNnZDF5dVFxWGQreHNZRzFoNGtRL29aVlBQTi9jQWh0K3VmRVE4?=
 =?utf-8?B?cGVKTUlPTVRKU3JTRmI0bTVJRnhVRWhmMlFnbXBuTEk5b1dmU0FGSy94ZWNh?=
 =?utf-8?B?Y3BsRkdKSFg0TTRnL0MxL0FaYThXRzkzd3BXTUxWVWtmcm5xZ3J5aUprejF6?=
 =?utf-8?B?NWVaV28zZUNvdFc4SWtxZU1NS3UzNTRDVzhBMXI2LzVreTB3aVRSM09PRzlm?=
 =?utf-8?B?b09iQ0l0eVpwS29zTUJvbE82eis0aEQ2bUIzUisvNXlwNXZ3ZHhvam1MZWtx?=
 =?utf-8?B?Z3hiMDNUb21tZ1lLYitSWlM5MXcyVUZlaGlOakdUeFZrdjc5Q3lzM3ZadTBo?=
 =?utf-8?B?RmwrZGZkYlhBcE9ITk9FYU1UOVlWWkt4UmdPVm4rMW9tcWhrbUxqamZOczR6?=
 =?utf-8?B?NFQxUHRVSFNyenZIWEVtSEp6WEZNVkc3ZFp0VmlaNENSazhOOG5sSkNHTkZY?=
 =?utf-8?B?K2MvUVZQMnREdEVObEtjdHhpN2hoNlhVNkdlL211Y0xLczNWUktBOGZidFdk?=
 =?utf-8?B?SkxpODFPMC9mTm1RRWdvdnBrcHFTNm1YRXNSMm4yVG1HQW9YV1RWa1N4MzBq?=
 =?utf-8?B?T3JlZ3l1VmNJaWVwVElSOSt6ZldXNlFKOFNoakp3TlFWNVE5SUhrWDJDdUJL?=
 =?utf-8?B?RmZ1RDlZSXR6K1ByWktKQ01sTjBGRUJBdGRPRWpFd2pheTRYR1o1Znd1QWFB?=
 =?utf-8?B?Rm5YM1ZTOWh0amdvWVJ6S1lWTGEyV1YwV2Nya1BrSGhnU3N5WmlHU3pGblBT?=
 =?utf-8?B?U1JtbHk2aW9GenF3Y2ZaUzIwY0QxT3BOVmJ6dkpqQTcwbndnanNueWJPT1R4?=
 =?utf-8?B?SWN1aW1wV1FuWkpwOVBVVXBJbGhQTzZFbWtHajNBTGFYdVo0VjR2ZHg1SU8v?=
 =?utf-8?B?RXF3dTg1Q0h0MXBvc1MyTzZWTEkrbzlIeWNwKytvYW5EallCdjF5bjl6OFdX?=
 =?utf-8?B?YkY0MmRDR1pPSE1iQ1pTWklQNHBvY3VPelNiU3BpT3gwckNIa2tPRUIza1gv?=
 =?utf-8?B?TWFtbXBJMGtuamlmTGhKcFV6dE85c01PSzFzWmt0ZUVPMXNINzFoVDIwQmoz?=
 =?utf-8?B?VDhuQVRCamxYNTFrdW9xVEdVQnBCemtoZTZJd0R5RERpeWVMVUdkRGUrZXdL?=
 =?utf-8?B?b05EVnhaRUcrN2NUOEVXUEhGQzU5WjZxL3E5bDB1UDZuMmtjVE55QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a7d393-8fb6-4d17-b254-08de3f94f721
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 06:56:57.1603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCsGgT+qdm+n1Ac80Y3TaljBOsX/bUeQFQI9wZmPxI/4K5Y94Z4MG0xLosI/xYs78HWgYjOlLzWTojTO+8yiHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398


On 12/19/25 17:05, Gregory Price wrote:
> Describe cxl memory device hotplug implications, in particular how the
> platform CEDT CFMWS must be described to support successful hot-add of
> memory devices.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>


Reviewed-by: Alejandro Lucero Palau <alucerop@amd.com>

> ---
> v3: Jonathan updates, change some italics to bold, add some bits about
>      Linux's expectations for BIOS/EFI behavior at runtime.
>
>   Documentation/driver-api/cxl/index.rst        |   1 +
>   .../driver-api/cxl/platform/bios-and-efi.rst  |   3 +
>   .../cxl/platform/device-hotplug.rst           | 130 ++++++++++++++++++
>   3 files changed, 134 insertions(+)
>   create mode 100644 Documentation/driver-api/cxl/platform/device-hotplug.rst
>
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index c1106a68b67c..5a734988a5af 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -30,6 +30,7 @@ that have impacts on each other.  The docs here break up configurations steps.
>      platform/acpi
>      platform/cdat
>      platform/example-configs
> +   platform/device-hotplug
>   
>   .. toctree::
>      :maxdepth: 2
> diff --git a/Documentation/driver-api/cxl/platform/bios-and-efi.rst b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> index 9034c206cf8e..a4b44c018f09 100644
> --- a/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> +++ b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> @@ -49,6 +49,9 @@ up without requiring CXL driver support.  These platform vendors should
>   test their configurations with the existing CXL driver and provide driver
>   support for their auto-configurations if features like RAS are required.
>   
> +Platforms requiring boot-time programming and/or locking of CXL fabric
> +components may prevent features, such as device hot-plug, from working.
> +
>   UEFI Settings
>   =============
>   If your platform supports it, the :code:`uefisettings` command can be used to
> diff --git a/Documentation/driver-api/cxl/platform/device-hotplug.rst b/Documentation/driver-api/cxl/platform/device-hotplug.rst
> new file mode 100644
> index 000000000000..e4a065fdd3ec
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/device-hotplug.rst
> @@ -0,0 +1,130 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================
> +CXL Device Hotplug
> +==================
> +
> +Device hotplug refers to *physical* hotplug of a device (addition or removal
> +of a physical device from the machine).
> +
> +BIOS/EFI software is expected to configure sufficient resources **at boot
> +time** to allow hotplugged devices to be configured by software (such as
> +proximity domains, HPA regions, and host-bridge configurations).
> +
> +BIOS/EFI is not expected (**nor suggested**) to configure hotplugged
> +devices at hotplug time (i.e. HDM decoders should be left unprogrammed).
> +
> +This document covers some examples of those resources, but should not
> +be considered exhaustive.
> +
> +Hot-Remove
> +==========
> +Hot removal of a device typically requires careful removal of software
> +constructs (memory regions, associated drivers) which manage these devices.
> +
> +Hard-removing a CXL.mem device without carefully tearing down driver stacks
> +is likely to cause the system to machine-check (or at least SIGBUS if memory
> +access is limited to user space).
> +
> +Memory Device Hot-Add
> +=====================
> +A device present at boot may be associated with a CXL Fixed Memory Window
> +reported in :doc:`CEDT<acpi/cedt>`.  That CFMWS may match the size of the
> +device, but the construction of the CEDT CFMWS is platform-defined.
> +
> +Hot-adding a memory device requires this pre-defined, **static** CFMWS to
> +have sufficient HPA space to describe that device.
> +
> +There are a few common scenarios to consider.
> +
> +Single-Endpoint Memory Device Present at Boot
> +---------------------------------------------
> +A device present at boot likely had its capacity reported in the
> +:doc:`CEDT<acpi/cedt>`.  If a device is removed and a new device hotplugged,
> +the capacity of the new device will be limited to the original CFMWS capacity.
> +
> +Adding capacity larger than the original device will cause memory region
> +creation to fail if the region size is greater than the CFMWS size.
> +
> +The CFMWS is **static** and cannot be adjusted.  Platforms which may expect
> +different sized devices to be hotplugged must allocate sufficient CFMWS space
> +**at boot time** to cover all future expected devices.
> +
> +Multi-Endpoint Memory Device Present at Boot
> +--------------------------------------------
> +Non-switch-based Multi-Endpoint devices are outside the scope of what the
> +CXL specification describes, but they are technically possible. We describe
> +them here for instructive reasons only - this does not imply Linux support.
> +
> +A hot-plug capable CXL memory device, such as one which presents multiple
> +expanders as a single large-capacity device, should report the **maximum
> +possible capacity** for the device at boot. ::
> +
> +                  HB0
> +                  RP0
> +                   |
> +     [Multi-Endpoint Memory Device]
> +              _____|_____
> +             |          |
> +        [Endpoint0]   [Empty]
> +
> +
> +Limiting the size to the capacity preset at boot will limit hot-add support
> +to replacing capacity that was present at boot.
> +
> +No CXL Device Present at Boot
> +-----------------------------
> +When no CXL memory device is present on boot, some platforms omit the CFMWS
> +in the :doc:`CEDT<acpi/cedt>`.  When this occurs, hot-add is not possible.
> +
> +This describes the base case for any given device not being present at boot.
> +If a future possible device is not described in the CEDT at boot, hot-add
> +of that device is either limited or not possible.
> +
> +For a platform to support hot-add of a full memory device, it must allocate
> +a CEDT CFMWS region with sufficient memory capacity to cover all future
> +potentially added capacity (along with any relevant CEDT CHBS entry).
> +
> +To support memory hotplug directly on the host bridge/root port, or on a switch
> +downstream of the host bridge, a platform must construct a CEDT CFMWS at boot
> +with sufficient resources to support the max possible (or expected) hotplug
> +memory capacity. ::
> +
> +         HB0                 HB1
> +      RP0    RP1             RP2
> +       |      |               |
> +     Empty  Empty            USP
> +                      ________|________
> +                      |    |    |     |
> +                     DSP  DSP  DSP   DSP
> +                      |    |    |    |
> +                         All  Empty
> +
> +For example, a BIOS/EFI may expose an option to configure a CEDT CFMWS with
> +a pre-configured amount of memory capacity (per host bridge, or host bridge
> +interleave set), even if no device is attached to Root Ports or Downstream
> +Ports at boot (as depicted in the figure above).
> +
> +
> +Interleave Sets
> +===============
> +
> +Host Bridge Interleave
> +----------------------
> +Host-bridge interleaved memory regions are defined **statically** in the
> +:doc:`CEDT<acpi/cedt>`.  To apply cross-host-bridge interleave, a CFMWS entry
> +describing that interleave must have been provided **at boot**.  Hotplugged
> +devices cannot add host-bridge interleave capabilities at hotplug time.
> +
> +See the :doc:`Flexible CEDT Configuration<example-configurations/flexible>`
> +example to see how a platform can provide this kind of flexibility regarding
> +hotplugged memory devices.  BIOS/EFI software should consider options to
> +present flexible CEDT configurations with hotplug support.
> +
> +HDM Interleave
> +--------------
> +Decoder-applied interleave can flexibly handle hotplugged devices, as decoders
> +can be re-programmed after hotplug.
> +
> +To add or remove a device to/from an existing HDM-applied interleaved region,
> +that region must be torn down an re-created.
