Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330ED274660
	for <linux-cxl@vger.kernel.org>; Fri,  9 May 2025 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782444; cv=fail; b=r9uUg6yXdR0ZIcRxtW99WnauELeVZoJDKmT47s0D3Y0p0+DdXdYbOaf5KF7rIpgR02tCr7/WeN3BYcmVa7+DVbxCGtvI6aIWvrmFAhYcTmtmLTp/CHGd7XQfIzO9pb3JrMSIbEt7IyQ7KUy4oUKdQSuQ4u/vnfOSOVQ1X5pVdu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782444; c=relaxed/simple;
	bh=u556adxOz1oee02wLXiqUGJN6f5/VqRjb2+VoeO5z4Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aTOsPtBmGBjNf25/YEjEhQcUM18Qx0j1hStXwzTeRclnZ4a0I8g0OJlzmtX1PfI3wK0POOBJVQ3AVLHW8SfT+jYkWtW27CA5oKlSSyEvi6Xw6d6PY0QIkq/yNqF19tlwSMeJHqS4CcU8KUJlKFufrv3D7X0+Y4bNZpyhxbPblFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pDOYxMsZ; arc=fail smtp.client-ip=40.107.101.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pDOYxMsZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kc1eA7wCGAIMbMu7Nnjs+Omy446si6Rp1bJAJyj1almav6hBMi+zfFxB1bmmWThGJNIuo00PjWpDIL4bSafBibdNG7YhXn2FqZ/g/o3m20yLaQlZoUquD3NOwlnbx59UGwV9njto74PNIwu6w0JIOxEWYPf4BAbnhtyK6XW4ApB2CpBkt4tQ5Nk3pQuUxJoGWBTrFz4sinkLZ5b539qOaGs/ijoGB4jsHZXNaw1dm/69Q6Ba8xy0NHX/vypR1OkBGIk9BktVSrP0OSKTUQnRzcAh6EeftjALBpHDDqCTZoWkH+HuDy0Qk3RdWK/3L8ddjxEuV2OmaNBooPY+nMJ0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyU1QbDCTNJD0VdivNlKIFAM/iXdPHGmH5beXnmuXlc=;
 b=sYssHxfP2AwglePUcw70HdV8+7NE9QmipzXWlEzpKX4TnUJVP57rJe4lu2PtyopT1TYR45PJXexn3E35ZmEWZC2RKi7fJx94OKrMyLcelifQcAw9YPOEZ00oq9i+SiO2fL9Ix1GglqfL1oCF9+sgljZiXzSzf909FcFEijH7nLLcWLZVeKnMbP+Fd4Zn1i2W3JiXKcdkqJ9tyq8/te/99LcLiEolw5C2hqnB1qmCCPnvXZOODue8WJjB+diPcLOQFlrmTrsDmC0hNFtEJ4+bm1FDnGahefubMOPWK533vRk+gcxwMtvfHumpZlgpT6SO+LNrLBYntfZ5kFf3Ol+BYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyU1QbDCTNJD0VdivNlKIFAM/iXdPHGmH5beXnmuXlc=;
 b=pDOYxMsZyomTZG/8Ojw3aCBCnSp+Eq44/I/VFpNMRTcqwO3WXZyxJM6WhIaH4Y0n+Y9dthbkH50xY7av4WfkVbYYRWwx+FphpDgCXtpxmND3hBAXaqYzWC45f9OvgFotkkzdzk69BVIqOk9J8r4UIJ2OUe6ynwXv8GA3gh4HFXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Fri, 9 May
 2025 09:20:40 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 09:20:40 +0000
Message-ID: <36ee7c17-4a06-4288-89d0-547c23afb8e6@amd.com>
Date: Fri, 9 May 2025 10:20:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] cxl: Rename find_dport() to provide better
 function intent
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, rrichter@amd.com, ming.li@zohomail.com
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-4-dave.jiang@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250507004310.3536991-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0039.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ2PR12MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 0450f389-4424-41ca-c4a4-08dd8edac470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVVkWHRLM0ZOVWNpaU9LZGhFbHF2UmRhaE56ZFU5a3ZmdHZqelpIVWkvV1FP?=
 =?utf-8?B?Z0VKWjNaV1RnVXRqTkxQM0ZEZHozVmkwRUhBazdIM2l4dnk5Y2ZEenNzS0tW?=
 =?utf-8?B?RmdvVmo0MjdiUDJybytFUjR5UjdjUXpMVTM2TVhiZFUwMkFNdjhRZEwwYkFw?=
 =?utf-8?B?VU0xNXhDZ1N3c21RR2NqYmVBTE9hZ0k1UjN6QjR3M1ZmMUkrVThrQTJOWGhv?=
 =?utf-8?B?YlU0QVA5TWNZN1VhWmZ5TDg5QlQ0RzJTaS9xK1ZadFdCQkVsdWhYbVNMaXFm?=
 =?utf-8?B?WDZRbjhxd2ErVGxQcitMMlIwVldHbkgySjNkQk9XNlEvL2N0bzJvbkttZHBv?=
 =?utf-8?B?b3FvVUJsWWRNNFFoeGVQRnE1QVFOVWRYZmFTbmZsdVV0UGxpcHk5YW4zSzFY?=
 =?utf-8?B?bURMZ3JqQTk0UDJoUHhHRU9yemE2VDV3N3FndUtuNHJiZ2R3KzU4VVFjWjRQ?=
 =?utf-8?B?QUx5em1PQTU2VmoyUm01QnQ1UEtqN2RPbkVEa0dWWUgrbGc2U1ZzVURMVWZM?=
 =?utf-8?B?UDZPaGVLWkNTRGN6SXlieUR1bGRRQVhTRkk3Z1dYd013bDNUWElDREFnWEx2?=
 =?utf-8?B?UFdYYkxxVWg2MFFvKzJ6NXNPQy9GcGhHY1BlQkZyZENCUFJKLzNDOWJCR1cy?=
 =?utf-8?B?a1Z3VkFIdFAxbUdZUXF2NG43SC85V0s4OHp4VUVjVkJlZEl0MUV0TktrK3Vo?=
 =?utf-8?B?TUhqQVpGemFUaVFHdFdjK2RDcVVJYS9iK2FZMk1yWlAwTWpRWWNSKzN4c2FN?=
 =?utf-8?B?c0xhaXBXWVh5Z0RQQVZZakRSN3dwbGRncWg1UmNoV1kyaXpqaHRNUnEweXgy?=
 =?utf-8?B?M1Q4TStZTTgrb3lOMzE2Z2Z4N3p3bDZGUXZ6VWVNcU1Hb2JTZlRuMEwvT3Rn?=
 =?utf-8?B?cncwdU94QXNPRFNLVDIxbCtlYkFWd2NnMER0cE1ITDlkUnU4UEVlLzJPS3Ru?=
 =?utf-8?B?dllER1BiRGc0V0wxZFZlV2M3OFhzb1JZUjFOVVBVZW1oSTdjVTQ3T2Vob0Vn?=
 =?utf-8?B?dW9UWnJJUjdvdGZUdVNTOUN4QWdlZ0g3NSt0aVExZSt5aUpTMFdBQmZpZVNy?=
 =?utf-8?B?MHpCVHpEVnN1RTlFZEFZOHdCTlBHRUFQVllFNlYrcm1GTnZhbmNUYUNHa0Zy?=
 =?utf-8?B?amJUNmRkaFVMSXhna1lzbmwwWnB0ZU1qVFB1aXYyc3c1STAvNlBqWHF4eG15?=
 =?utf-8?B?SmdmV2QwZ3hHWXo5MEwvL0hVOWFSbHllYnBzSEZoZXJ4VDNYZWx3b3lUUTVv?=
 =?utf-8?B?N0pjVWZaOWcwZFp5MHpoNjN0azA4aEVWM3grSkFpNlhUR2JGZGNpaXZTZkpU?=
 =?utf-8?B?dkt6WUR6N0dkUktiN1RIdFZXUldXVEVjdFJvSGY1ZzY1TUxkKzFhRVNPbnJs?=
 =?utf-8?B?VmRNc2R2d0oxcXROWTd2bWVYZkNDanlnVWQwbFdUWGdxNXhsendNdHYrdnF6?=
 =?utf-8?B?L0RhLzFwWURYTVVmQm5McGI2V0wrRTN2WXphOUoxTlpkVzdacXpFY0hLT0wy?=
 =?utf-8?B?UHJudEdJR2gyQ1JrQ0Y0NDh6NC9maVEzVUVYNGpZS1liWnQ5V3JPa1JwOEYr?=
 =?utf-8?B?S05UTXVPemp5RWZlbVVkVUJuK2lGeGZWRlNPOUV4Vkp2dGt1VSs3VlNQNVdr?=
 =?utf-8?B?Yml4K3ltcEUwdEJiVmFFU2E4TjBBSEFONGFTUG1nMnkxbE85cjRNekZ6Ukt1?=
 =?utf-8?B?bFV2UENjcUQ3MTVlaXIzSkNRK1lBQ3ArYXpvVllzWXVDcDhjUXRRb0ZIT0JV?=
 =?utf-8?B?QUpmS3RKOFBzWVVBYkhscjdWS2JYTUJWR1FvQmJwM1NNeUYrQklaT05uMVpm?=
 =?utf-8?B?TERzeW9NSHROMWFHT0NJZGl2UFBTVGVUVllLOHlSb3UwSExIcEVHKzkrZ1N3?=
 =?utf-8?B?NVhFdVVzRi9mKzJMUGJQaXNLckh1RG13ZmRDaENrUW93dGEwbXkyRjlGRERh?=
 =?utf-8?Q?1nR2L+v/4bs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXlaL2lhYVBwTEtHenZlSDgwVm1IWW83cGE0YzhNQTNLbnBzL1E3K3FtMit5?=
 =?utf-8?B?bWRPQ1pQcHp2QWd5bmlOM3NtQVNFeEx5ZkNXNE5KVm96eG9TSitiY2hBNitp?=
 =?utf-8?B?Zkw5Rk5aTmRPRDJEZVFwbDM0YkhTNEVjM2pkLzFMMGpoYkhvUHU3TWpkYXky?=
 =?utf-8?B?bFo2clI5TDBqb3lnY2JxOGZQc09vZWNqRVhZM2dHV0NtbERiUkxVZTErVklM?=
 =?utf-8?B?UVA1SWVqV2hZQzF4S3ZCa1orelVMRkhrTzVHL2RJSzgwbTdQeEk1Wm4wb0g5?=
 =?utf-8?B?R2I1U3pUc25kOUd3aEhTMDk3Y0J6SEsxbWdIRjhSZGZXdTdQaHpnaEZDWVBj?=
 =?utf-8?B?Rk52dEw4SVJNQjBBVTJYOG5zQitXQWtxeUVUWUhEUEZzOEV3RHJpM2dYandQ?=
 =?utf-8?B?RFJTYjRlYVFlTlNHVGE4b09JaWgybWxhUUtQUDNWblg3QzVGQTg5RFNPeWN3?=
 =?utf-8?B?UHJyK0dJbk1ORUQ5SXpZc3RNdVZPLzUzbkh4VzEvbTFCcGhLUU9TYjErdkpJ?=
 =?utf-8?B?YmVWRGlKYmxmMXAyU1FZT3ZVNFF6UWltSEhDNEhXVUh5QXNSdjJzUGdaeEp0?=
 =?utf-8?B?amdLVk12TVg1ZG5zd3ZXYU1acSsrY0lIZ1c5OEs5Z0VmUkFIRE1vei9lZjZh?=
 =?utf-8?B?bkVjRVBBaGsrM0lpOUljMU5hbkR3a2c3cWlXZHh4NVptbTdmdFhsZlUySXZi?=
 =?utf-8?B?akNsSUZNMmRHR0NwODJjdlVPVWh2MkQxWUsrcXJJNGZzMy95cVBTdTh2dGdD?=
 =?utf-8?B?eG5HL2xXU3dCRlhQVjVUV2JOSXJvekE0Z3hvTUtDQ1BZRzE4R2dWSWtKNlZy?=
 =?utf-8?B?TjNTOHJtVVZPQVBGZklURG50NG5SK1BrSmVGb01RcnByM3BkK1k5dDRXVkJR?=
 =?utf-8?B?VjNTU3NPenlUQmc3UDMrV0tMSW1YTld3T3RGOUZHa1Uydlk1elgyUE1TYlBN?=
 =?utf-8?B?QkpHQUttcXJ2bGxiclhoZ2R5NndRL3N0UHVpaXRGMHFPNVRhUXJreTJ6N3Q1?=
 =?utf-8?B?WDlEWVpaZWNkV2dCbVFuNVhSdUlJWVJiTW9HOGp5YTFSNTVXeXRwN2ZJdWVh?=
 =?utf-8?B?MjQrb1lMVlE1RTV1RnEwVUFYb3ExelJpS1pYSVhONngzNGpxMzFXSStSMGFm?=
 =?utf-8?B?Ly9MeTFoTVlvT1VkWkNBcWNZUi94enpvM2o5eW1UOHVTdlNNbS9FNkczVyt1?=
 =?utf-8?B?RVdNL2xsekFnWU9aWnFodjNnQUpqK1ZWenpKa09lMzNpNzVWaXVvQVBpZUh0?=
 =?utf-8?B?cFRBR2xOdmdSNXVIMFpqK2xGdCs3UjdCaHlOVWEreW9NUGc1MFd4Tk45blpQ?=
 =?utf-8?B?TzhZZlNBY2R2OUROTDMybUVXTm40SlJwUmxoU3BxL3pDeHZhb3dPL2p3a0Vh?=
 =?utf-8?B?Z3dIaThHN3JEMlRKUnp2R3ppUm5ObjY1b1VjRk1HTG8raExJTTdpNStnZnV2?=
 =?utf-8?B?TDRmN3RDc0tLRUF1MFZzREJoQklUVnE4MlpUUHRyQ3ViZmd1KzhWUWJhL2dX?=
 =?utf-8?B?SWZkODlTbytkeG1IRGZmU3hFamw1U3hTc2xld3g0ME52TzlXV0Z6RFpJZVl3?=
 =?utf-8?B?UTRmcVhsalI1L0JLYVRtRmZISE9kSlVhUWZyKzBTc2FLaS9HeFBVWFloSUxD?=
 =?utf-8?B?OVFxQUk4NEd4SFREcHE5MnhXNDZyNHVMZUVaSmN4WnJGOFY4VzZ2OHRtSmJI?=
 =?utf-8?B?a3UreFM4eWw3S3R6MzlOU2RJYUtubUE3RC9vazJVbERpeHpWd1RqUmwzSlJJ?=
 =?utf-8?B?M3JEdHpDd3phNUNON0JWUnJuallCdk1WMXhsYXhNQlFXQVY3c1FGRjNIVlQv?=
 =?utf-8?B?T1Z6eWw4Z0pNbnRld2lXUk5ORloyMTZuSXVzeWhMWmpUQnhCUko3aStZVEZ1?=
 =?utf-8?B?Tm1qUSs2a3FjeU81MVVHK253YzdSWGhvanFjcnJVU2k3VzVaTE1qbjE0ZS9h?=
 =?utf-8?B?MTFZck9uWnF2UVkvQkZycTVNeG1nNy9wY0lBdTl6SUFJVHZLNDlSYkRZRmRT?=
 =?utf-8?B?OExaUkJMdHJ4aFpzczE0cWFtMU1OZW9CSGlmN0VkdXRrRGtlSEcvanIyYUdr?=
 =?utf-8?B?RnpFL3U1cFBQLzFGVlpORFpxQWNLMnI5QzZsRlhDa0o4VXZEVkFEQVZmcDNK?=
 =?utf-8?Q?ikd8Teht5/UdoO/Dpb08RmvxU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0450f389-4424-41ca-c4a4-08dd8edac470
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 09:20:40.8377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EjI94BpjkDblXP6kfO/4cLxY0FmDRluxvzP8Xnqd+LWbJ7+yE14AbAxO8xn4Xpp1mtxhUQmFev8NYpeN6Cem8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896


On 5/7/25 01:43, Dave Jiang wrote:
> Rename find_dport() to find_dport_by_num() to indicate that the function
> is trying to match a dport by its hardware number index.
>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/port.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e9c02e4d0d4c..1d7a4a2ef6ad 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1045,7 +1045,7 @@ void put_cxl_root(struct cxl_root *cxl_root)
>   }
>   EXPORT_SYMBOL_NS_GPL(put_cxl_root, "CXL");
>   
> -static struct cxl_dport *find_dport(struct cxl_port *port, int port_num)
> +static struct cxl_dport *find_dport_by_num(struct cxl_port *port, int port_num)
>   {
>   	struct cxl_dport *dport;
>   	unsigned long index;
> @@ -1063,7 +1063,7 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
>   	int rc;
>   
>   	device_lock_assert(&port->dev);
> -	dup = find_dport(port, dport->port_num);
> +	dup = find_dport_by_num(port, dport->port_num);
>   	if (dup) {
>   		dev_err(&port->dev,
>   			"unable to add dport%d-%s non-unique port num (%s)\n",
> @@ -1275,13 +1275,13 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, "CXL");
>    * devm_cxl_add_rch_dport - append RCH downstream port data to a cxl_port
>    * @port: the cxl_port that references this dport
>    * @dport_dev: firmware or PCI device representing the dport
> - * @port_id: identifier for this dport in a decoder's target list
> + * @port_num: identifier for this dport in a decoder's target list


Not sure this change should be in this patch. It makes more sense to me 
in the previous one.


Also, maybe adding some reference for easily seeing where the identifier 
comes from:

+ * @port_num: hardware identifier for this dport in a decoder's target list


>    * @rcrb: mandatory location of a Root Complex Register Block
>    *
>    * See CXL 3.0 9.11.8 CXL Devices Attached to an RCH
>    */
>   struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
> -					 struct device *dport_dev, int port_id,
> +					 struct device *dport_dev, int port_num,
>   					 resource_size_t rcrb)
>   {
>   	struct cxl_dport *dport;
> @@ -1291,7 +1291,7 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>   		return ERR_PTR(-EINVAL);
>   	}
>   
> -	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
> +	dport = __devm_cxl_add_dport(port, dport_dev, port_num,
>   				     CXL_RESOURCE_NONE, rcrb);
>   	if (IS_ERR(dport)) {
>   		dev_dbg(dport_dev, "failed to add RCH dport to %s: %ld\n",
> @@ -1764,7 +1764,7 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
>   
>   	guard(rwsem_write)(&cxl_region_rwsem);
>   	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
> -		struct cxl_dport *dport = find_dport(port, target_map[i]);
> +		struct cxl_dport *dport = find_dport_by_num(port, target_map[i]);
>   
>   		if (!dport)
>   			return -ENXIO;
