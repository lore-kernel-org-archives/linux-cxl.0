Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF631CA84
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651650; cv=fail; b=s/P8aXXx99+bCu6Sz8Gmv4MhP5SC3TI8UILPwc140DO8Ltrz0l35Vj2v3Ijvdkbdl9qnmZTYOaGlSGlaE6HmVvXntqprPA58nemANlhnYs6ej0uCYM0qVx2PivnPRElqUAvtt+RMVRUvPmSLUeebsqYZJqHzqwxZWTzA+9y0Cqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651650; c=relaxed/simple;
	bh=PfTyjXZullNs7E47ojzZf/0r8LrX4ohDlAsrQj4CgsU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PPaZPz4fas4D003gNhLRtrAFVpY1CgUMMgQ1uToVx9U7V28aAL8lkJCxCC8J/rHIQAGyeVFbQMeUcA9wnfnbqgUL2QPb2TdpG+mCVplWcqiX063rE8xYDNZBBmuAPUQEVkX8XSWTLZy+k1f/CeK+v92aUWqC8FI/v029wM27x7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wmY3Bg9j; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wmY3Bg9j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkClOazNsgImAbQRV84b3JWAtSfuxc/5MfSspqKy+kUwSWmqjksvoHw4av0VAC9s3RnAF83A67u2+xdocbjXHf9N/E4Qoa/AYj0AdYBkrMAOJnPsWe3qNuCHGBgqSXronTfEvdqqxqNqjzRXR/PtstiSjd64RkwCHM3RyHwKgueG4yfduiR4gtcvfzkODo6la+QEm+8Jo3Un8yB/0HR5GL7uaKl4KptzN4R+IMudPcR7Lm2a3n1nsuphNGxQXoSmbGRoqjKyBHbX8Wf0ysEtjILBKBecfusNQUTm5BGTYPkHkLa++Fh1Iq+GW6ngYNwGmTtz7stZdY8cmGY/F2PhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X18R5uMkF6fVwpx2i+EqwyZpk5dXrJ/y3eAJLp7jzu0=;
 b=uG55pX6USyT7LlCT0Y3qf0xs1Lpr9lWOKVP9p+s921Igb0E53u3stARp7yyzTN9NLp292EZjZdA9p1PJdb7Uiv3cumhiBf/CBFKcGm/zmLStJMHVFqN/D+LSCO8LkHmyAmVrhtE9ws0rSoD45y6MMamzhbX2+LiyXvUAa+OGVuOcyXLmvPjz14NzQytQ0c7xhsOsxALFymq0rATDT3C4Twu6iPw3WAUjfcUIEjcoQI7h7/HORwKBRKjm9snPALtcgrf3S/kc+ix/IfI6Fg5wsEQcOI2/Loq3ed/v9hJ2TjDXRblrPpERF+N9LMVW20e83t9hqIvnuyrH05C6yQNY4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X18R5uMkF6fVwpx2i+EqwyZpk5dXrJ/y3eAJLp7jzu0=;
 b=wmY3Bg9j1IpB8JKPsTTXI+y17YpfGyAUiviSV/RNSz1Q4uCP+m39JYQTngxL57xh5HoVV6/jA6Ecm2tHq96fgsWO9mqBSAi64FA0sgqVI9YQH9/Bx21bH9QzD5i4oyDsY/VKSYrlgCJvW4NS+xzPznY9RGDeO/2IduUdpaSzCy0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW4PR12MB6899.namprd12.prod.outlook.com (2603:10b6:303:208::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Thu, 23 Jan
 2025 17:00:45 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 17:00:43 +0000
Message-ID: <52174ecc-40f9-82e5-1925-dfa1b7c968da@amd.com>
Date: Thu, 23 Jan 2025 17:00:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/5] cxl: Introduce 'struct cxl_dpa_partition' and
 'struct cxl_range_info'
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan.Cameron@huawei.com
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753636727.3849855.464861650807086965.stgit@dwillia2-xfh.jf.intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <173753636727.3849855.464861650807086965.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR03CA0031.eurprd03.prod.outlook.com
 (2603:10a6:10:be::44) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW4PR12MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ed56ee-c62b-4ed5-5cde-08dd3bcf7936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnhrNnZYd1hMeTNUNFZSYTRJQWd5Q3hsa1l4Zk1saXlPZ0NGQ0IwT3BOWllt?=
 =?utf-8?B?VHNnQ3dwZGRBem0wbEFKR1dnT3ZLL1gwZjJNWmczMmIvOGZKMTBGS1J2T3F3?=
 =?utf-8?B?KzZ6UzJpNVZOZXRMc0Q2YnZWQXV3NkZNMnVrZmtVV25zdk1hSy95TWMxbU4y?=
 =?utf-8?B?QytMc3kvRmp4bHFuTDFLUGhrTDVRd0ZmWDkwcjZLeGkwMjdyTGxkRVpxTmh1?=
 =?utf-8?B?SkpDNlVxQkhzUTZlTjFFbkJrVXh4TDkzSllWZDg5aXBDOFdsT1I1M2NIWlVT?=
 =?utf-8?B?M2hSN0VseC9ZUjZyVTlwV0FZQU9LZGU5cC9STzQ2cGprVG9pY1BJU0dGOVA4?=
 =?utf-8?B?cktqS3UwZnNUYnRxdksyK2t1WFpvcUFlTGNJQ0ZSN1RqQnV5Zi9SRVgwY1VH?=
 =?utf-8?B?VzNaeEg4cUloTXFLelBRK1JraEdGTS9KRzlKRmhBaTg3V0M0ajU0L1U2V1Iy?=
 =?utf-8?B?ZXFOSUVjdy91U0F5Z3dzSHZKdkFNZkFleUEzQm5wT2xtZDV2RnFyVmlUV1hW?=
 =?utf-8?B?WEdDYTd0VGpoaFI5VEZraXI3MDlwRWxTQjFrU21lYWpJYVJqWmU0R0VCbk4w?=
 =?utf-8?B?TU1DNVBXYTdZWW9rQWoxS29RNElDVy8yelBSTG1jV0lqSm11WndET2k4NDJi?=
 =?utf-8?B?aTQzSnlqT0RLTXZOUnYzY1M5QVdNbFBLVFVSSmpqK3lXSmFWVmtJb3FKbTh0?=
 =?utf-8?B?N0UyMHU3dWxZemFQSFliYlBWS1R0VjZsQVYwQm4vajh0OTFaV3lkZjVaNnZ3?=
 =?utf-8?B?VWdNa2pNSVNDT2Jrcm13azN3ZzJaUFNmZ0ZKY29qdTdNYTdWQVdkclZTSS90?=
 =?utf-8?B?Q29RQmR3TmVUOWJUSlczY3crOG4rdUwxcUNUUkRrU3FuN25ubHRpRWdNVWlp?=
 =?utf-8?B?ekNoV0Naa1U2RCsyanBWS0lHdU92WWpRUTlzVFlxL3VGQXVWSktPVHVtaGRt?=
 =?utf-8?B?bU1pNHZzZXhteGxvd3Y2WHlPQjBUSk5temxxc1NUaXJVQ0k5MWpSQTJKbzQ1?=
 =?utf-8?B?REF6dFl3VlVJS3Zva1dEUnNNM0lOejNwR2NEZjVaOXhPUkMwNnEyWlhYN2JY?=
 =?utf-8?B?S1pxK1ozdWxPTVZJVitvVS9RRHBoaElIYkw1blhQL3laYk1ZaGZUSGFyWExF?=
 =?utf-8?B?YlZUWWFHUlp5Q0RFdDRuRDdOc0NEbUtKd01pVGxoSHllbldqcER6dkVlaENS?=
 =?utf-8?B?UDF0d1pjTTc1a3ViajQzNG03eGFYcWhBNEhEYkZIQ3NLcFNhRXBUYWhydGNv?=
 =?utf-8?B?VHNwNi9pZ2lpMVJhMzNwcXptaFJVYm9ubTZxOVZ0eG5pZVltbjZjTkxybmxw?=
 =?utf-8?B?MnQxMjNnenpqNGtEK3ZRWVorSi9neGxVSjVnMUZOdjk0ZkFJVkFVTUFYR3Iy?=
 =?utf-8?B?THI4b1hVY1phWlo0cW5pZXRmbkNjN2ZjanJBajhnUVVlNE5vdkhkamxVakNo?=
 =?utf-8?B?YlJEbVU3ei9wWnA3QU5PR3RvRVBLWThKNDFZTWkxeXU3T3ErWG5OK2RkeStj?=
 =?utf-8?B?cm1KQmluQTNKUWgzblRxdGl6czhORUg0bUZ1ck9QL0RJczN6b0V2OURNMStM?=
 =?utf-8?B?OStuaUNnTnp3aTFxZEttbEZoRndGMlhSK1h3aytWdXVMbml2K2VCTTVIK2I0?=
 =?utf-8?B?Uy9IN3NLOWJxOTBuMkFqMW5rZGE5NWNvN3luQ0RTbjEzVGdFeSs4UVF3aEly?=
 =?utf-8?B?TytoL2JwaHBqaDFNeFA5UVNjL2M3aFdOT2pZU0dQY0tBRFFIVjdOQ2tYa3hw?=
 =?utf-8?B?dVlOdktZcmkvTEdPUzZQYXdZU081UUc3d1dmZ0pFeHdwcW5YT3NSR29SVkdx?=
 =?utf-8?B?YWFGSVBYMm1sa1BTSUxKZStZK0FhR2dNdHRKNEVSL0J1VGdRV3ZmbkdsbG14?=
 =?utf-8?Q?Oyn+YBn2d+0dr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHhNbWZEamUxVHRjb3h1V0tqOWJqR1VrdjJDUjVOcnJXQU52RkdxQVRWS0Zr?=
 =?utf-8?B?alVydTAvcGlROGFvQzRHRnF0QlpWdTIwemdERzA4RldyL1NMVC9PS3B2QTM5?=
 =?utf-8?B?Ym5EWGlCczdrZGZob2s4dFNGMTJVSCtQcGp2TDlzdzlEeUpxcUExZkUzQXNY?=
 =?utf-8?B?aURhT2NjVGR1UW9CSnY1bW5PV1RqbytzcGc0cFd6SHFtSFJLdUZuN0hZUlJ0?=
 =?utf-8?B?SGgrZlN4M1pId2Zxa2lyNFpodkFOSGQ3L1lGdlJrU3J0RndCSDFQaXJKcE9P?=
 =?utf-8?B?SkxBZTRwVHBOcmpWcUhUcDhDTWVSUVFUYlREZDFDeXY0SklLZUsrbitnU24r?=
 =?utf-8?B?MDhsTE12V3paV0NJMDhIcFNXellYUWZ5YUtyU1drdWRWa3U3U3RlYjZhUlhM?=
 =?utf-8?B?V1J6dDlXdjNqMWIwRGVaV3dCc1FhWGdmeVNibkp1enNlbG5zRTQ2VXQvci8z?=
 =?utf-8?B?R2d2ZFBPRkVqVm1RaEIzNHNJOHp2djZMYUpYY0lKdjZLSHdkMnhTR0ZWa1NK?=
 =?utf-8?B?V1dsaWMxRmxEMVVhU1lkRHlIMjFqOFBKNFNkUEJvamE4TnNnQXFCalZtT0tD?=
 =?utf-8?B?ZXRDOVl1WEJ6R0xkTWJTaSs4VjNVMVJNYmo1Z1d3cXl5QlpUb1FObGtuZ3p2?=
 =?utf-8?B?ZDlWanZCYU1Nc3R6RjlIcHZSSmhUMGo4Z3I3V1hMaUpIVzRMczNyVTJsV01R?=
 =?utf-8?B?bS9XOVZpSS9ZRk1QVm5wOGV0OVdqRjRJYnRNcW43WVVTTlRiV3NmOXVGczZW?=
 =?utf-8?B?aEw0Q1RxVFBKdjFXcVFMc3V0dUdSU2JYVTh3SWxWbWQxT0hTeHZjYWE2UDFh?=
 =?utf-8?B?UDVmU0JNdlNyRWFJd3FkS25tdGdTZHh0S25mdjdnWVNvSU1RVW5OZ09IS08z?=
 =?utf-8?B?d1VyUjNSbllEdnlDVFlGR1QvNkhteTRxc3Bjc2RkY2dORGpZUHh0NEhLaVlF?=
 =?utf-8?B?dy9SYjAvWnRyUzlpL1EzdFZTTGE2MG5CNmJVTUJpOWFJckR6Y1AxdXNubFc1?=
 =?utf-8?B?U2NiQThwNk0rN0F5MlhQRUdMejg1dE5wTGQrY1F1ZWtJZlcwbzE2cnFPSTQ3?=
 =?utf-8?B?QlJoaDZSbTJaT3JaRFRDUHlJeW5VbEtVUk1hTUpod0RLQVZ3SjB2d2JhaXZZ?=
 =?utf-8?B?OFBrR0N1RkErS1pSSlFGWm5iKzkwNWg1T0kzcU5HYy8vTzZZL1NtbVJIMC9R?=
 =?utf-8?B?TE9namdiMXA4V1R3UWwvUGRCOFZPbG1HMVNKVXlPdW1hN1lxdk50K0tieXdU?=
 =?utf-8?B?UHdyblQ4WEllWXhEcnBONGhjclFSbXVXQXNVQjVFbHAvRUFPdDJQMm5KNmFs?=
 =?utf-8?B?OE5NdEVIN1NhNFFCL1o3bC9EZ1c4bkpIWWxrV2lGYWEza213Wm5aMzlFN1pT?=
 =?utf-8?B?SFhza2l3UkNGbzdtZXRxMjN4UnU4M1FZY2dqdE9qVXFQTWlaQk00bDMvVXdv?=
 =?utf-8?B?OVV0ckk2T2N5WkhkdndTRGVuaDNzcXZnTURWdXh6VW5GSlU3QmtUNUh5ZGQ4?=
 =?utf-8?B?UmxYamNKTUxSS1pyK1hmRzZzOVdMdHMwMmVHMU1oOHcrMXNObjBYQkwrUUxl?=
 =?utf-8?B?eFUyM1I4ZHR4M2pzZE83TmZoN0ZHU3huNThXRDNoSGdGaDNXNDBuM1dPeFFP?=
 =?utf-8?B?bnR4U1RiNXF0ZTNpL21QbVIvbUZSTTlKUGtCSmxJeE5SSDZMRzVBS3FIcmtL?=
 =?utf-8?B?YWlMaWM4a0cxVFRvUVV5MWNOQXRHSVd3L3VnZmN2bWN1WDdJNlBENUhvOVpj?=
 =?utf-8?B?d01CSGc2TWpVcG10QWJhN3ZGdkI3aC8rMi90S3ZPWnVuSStGcXdacVVXTjJl?=
 =?utf-8?B?WkNrdlRJUUhBTDNzN3FBVWZ0Z0Y0UDRLMUNYdU5BY2lHYUEyNXJzU2NmVXlo?=
 =?utf-8?B?NGl6T2xUaG9RQTdyNy81aWw4ay9tKzR0MTAwRFdnRmZjM3RYRE1XZ3hraUZK?=
 =?utf-8?B?ZVJOYlZmTkh1MFdHVjRzRFF2eDFMS2RhWW90dG5qK2ZVL2xwdStlaloxZnBS?=
 =?utf-8?B?bFFqclNCSmJMVEl2b1J5NXB0U0pJeldIeUtrZGxwdmRzbkgvRTdHeFFZK0c5?=
 =?utf-8?B?OUxIemJlSGZRM0I1cnp2K0tYTFY5RzRtbWkwck1qQlM5THRuemljRWUxQVZi?=
 =?utf-8?Q?JM0bXO3+kte5Rw1WVM9TZlBp0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ed56ee-c62b-4ed5-5cde-08dd3bcf7936
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 17:00:43.6326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8g+MZySbJfjU+IuiWIG65LFvDPi87lKxG1roqtHisq7Sn/Vu3kaLoq9TCxbMmB52TDR3OOYQ/3O7l3QqcEBDXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6899

<snip>
>   
> -static inline struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> +
> +/* Static RAM is only expected at partition 0. */


This may be seen silly but Static Ram as SRAM has connotations which 
could confuse people.

Maybe better to use Static partition for RAM.


It is far more concerning to me though Ira's comment about how can we be 
sure there is going to be only one RAM or one PMEM partition.


Apart from that, LGTM:

Reviewed-by: Alejandro Lucero <alucerop@amd.com>

<snip>

