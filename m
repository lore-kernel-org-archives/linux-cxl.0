Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E589D1FF1C1
	for <linux-cxl@vger.kernel.org>; Tue,  4 Mar 2025 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098122; cv=fail; b=tNu6lDvA+XHzVlhCNUeXZq9ZwdR2i8VjkBITQPGA9x4e00uFUU3cwi1VcP2IaLnqqxyzmuF5APHQPbcwLc89gOuk6CZJYpnmjVdk/SsP//04htlHL/P0v05N5RRWupkRT5lz2d2l2q6/rVwtf2jgxk0WhPFUudCCE5jctQd8hek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098122; c=relaxed/simple;
	bh=dilqUx7BD2KO8JXG2nDiWCy0u0R51L0IAWdRpuOXYMY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FMlKkFOq/o0ZYVZf73NB2LSVoKMg4MYnK0Sc1U7vhErnF5HxlYkQBdUiRZ6h5jir1yqfORwqE0yQ1EGfGh5+qyEfK8uPF3+JfvCVS1udYNBb9CappsQkxbgYDSn5g+AHDnldaYoby7Qe0gVM6W0Xt5DXsdIp++o5GGHMSO28Re8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TZDhIsqu; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TZDhIsqu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYPBmdI0LUZoXV+kjRvDzU6+ZE2SC8Ny1OCJRueGpVDsEWqZNNWQmnHVA/o+i3lAN6QEwDRurDYMAY1y7ELZM0bq2nwVsnLByoMjvH7scPF52IJCcAPYM830FMSr4lbUFaoiY5lpHiw35XIB10Yt6FnLTdVKJr/D8QBDSsZwV7eyMBt0jeDP49xxiMe1piUAWd8GH3XFBO27KWuUaVnLO9KrgqaijFnSz0Aqbj7cOvNzhXepQikaf3r+aJeJWoPVi7Vd35Ite5LVrYP8cHHalUPGqcOmDvvE1Ake1ErEYjVKqQPr374+LFXBmPu5LYwEQVN8caSItb9ztF6WWojfHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cx2xc8ViftSVlbERp9da45g5ys6WvyTBrp2gfXO46Ss=;
 b=d6f58zuB+d+dHs8/qCFYPMGrJawIYo/YLintQWN66RcaDbdTYi1QCI/wuawDuUPBRLVA9xkGDUhpLXZBPZs3rG0m3LLbRZWf/F18c9YepxRG46pk+hLgif6u6CenRARyFk2NBaOQY5T8JtcrbU1POjkI5WoX/9u2aMXdl2MIdLpgXZhClnGMfq6tbziOclrZ9to+NWz4cYgo02Z5LA2zoSIaolzT0m746KeVvTifzQYlcmzojOGtqstl3+Ow8dx6+LplmuV/8Vr/jwR41lHoVQGKxgFd0MG8QgcWnjI5/QVFeEgEvBpMi0tav8ES7YS2vZixAvMYOduwAbO7qLiJ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cx2xc8ViftSVlbERp9da45g5ys6WvyTBrp2gfXO46Ss=;
 b=TZDhIsquOrV9d+KfouQubn9NYqV3w6K4CBwwp4G8uyqEUkVeTnXT6Rtemh999RVIxRNlNbyPKbpFfxmIWG29g7oNSJTCpd8Ll9kGT3T1JaK1GMBIPYuCFUYsuauVVUrRKPbgbQ9jvFadfSjeDIUr3o/m4yO6MVaZVcKnzcsHB1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 14:21:56 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8511.017; Tue, 4 Mar 2025
 14:21:55 +0000
Message-ID: <b7426295-3531-4828-b03e-56724b1b2626@amd.com>
Date: Tue, 4 Mar 2025 14:21:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC type cxl initialization 1/2] cxl: add type2 device basic
 support
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org
References: <20250220200041.3891165-1-alejandro.lucero-palau@amd.com>
 <20250220200041.3891165-2-alejandro.lucero-palau@amd.com>
 <67c60de1d2a7d_1a7f2944@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <67c60de1d2a7d_1a7f2944@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR03CA0105.eurprd03.prod.outlook.com
 (2603:10a6:10:72::46) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d7700a7-5d20-4fc7-215c-08dd5b27e9fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2F0UGxWM1ZwaWl4NXFPN082WjZIb1BrL0tDVm5QZlgvYmFoRzVOemZ1eGxD?=
 =?utf-8?B?UGNLL21LODY3QlZ3UmJPVm1JUVArSXZKVEw3VUhMNGJoYWVmbm1VVWoxbW1E?=
 =?utf-8?B?eHZmMzBVblcvUFd4bjNFeUZEK1BDRlYyM3dPajBCU1BqVXZTU0NuKy9PZnJM?=
 =?utf-8?B?YmRybm0rSVB3bTlSZ2lHKzNyOEU3YVIzWnlvZ1lRTHliS1hROVZ1QVRhRERF?=
 =?utf-8?B?dVBVQjYvMlQva09ULzJzSnZZbStybUFQUzhDbUNKR0lwdTVhc0c3QWZMVlpU?=
 =?utf-8?B?eThVaS9pZmhWeXhGUEcvSHhtdXo2YlZSTFlXYjl5YktCaWRzdUhJZ1Jhci94?=
 =?utf-8?B?QzJRMG9ianp3OGNrZTcrTDFPa2pCYjhtcmZFR1ZQeVJJbTJSbFgwNE42WUxh?=
 =?utf-8?B?Z1pOdFpJQWwvUTdGd2tlMkg3UkJEM1BRcHRmeGRkc0RCNTYwdGsyNDJIR2hQ?=
 =?utf-8?B?amtlY0tqSFNjNzFOUjVSSEFsQ1JrUlJRUGVlT2ZQRlhPa21Zem5saFlTU0pU?=
 =?utf-8?B?SmkxenVwSWNEU2hFVXRHR29meFQ5SWU2ejY4TVk1eVlUZm1YK1VDMUY0ZHkv?=
 =?utf-8?B?QjBFaEpGZ2xPMVBPNFpqRXRqTmkrZmlLQkZuNXdTMW1pZGo0TE9Ma2ZMOVFo?=
 =?utf-8?B?UlJNU3h6NVdTZ09uQXhSZU1jRFl3S0FwdHVUOUVWWEZmSUttVm1TWWJzSXpk?=
 =?utf-8?B?TlErMCtZU1E4SlRiNVpnbm95R0FxZVBwU3hWdDdyVzVtZWlES0dmTHFWdDgy?=
 =?utf-8?B?RUpSbWJCaDZPek5jdlBwTW9LMis2aStVT0VQbWZ4NGd1OVh3ZzBya1NNL1dY?=
 =?utf-8?B?eXhpTk1uaEZUQm8vOHZPWE9JZUpGRkI5bytUaE15clFRZkJGU3dVckxCL2wz?=
 =?utf-8?B?bm16R0hUNUpDbFpaaE1iQ3JxOG0wcSszVEFzRlRZVEFnaHU2U3RSU3lzUGs3?=
 =?utf-8?B?QTdJUXNnRXJLTkhrVURvZWRFYlE5Nk1xbW0zOTFjU2ZFd1FzaE9XVWxtbkVG?=
 =?utf-8?B?Uy82TkhFSlBqUWFFQndTc0lJb0hUQ2EybXBKMThTM2dzWHZNalRaTFRoR2pY?=
 =?utf-8?B?bVUybDl3Qmw4MWViQjM0NmJiNU45L3ROR243a2lnZDdqblZxL2lIMFBsUW45?=
 =?utf-8?B?OXB2UnFUOW5jb0tQZytOcWJGQjlGczJjWTBnR0pXS1JPNkh4SmxYN1MrK1ow?=
 =?utf-8?B?V292VGRUS1BMQ1EyV1JpVUdnTVFXMGpZTVFvUHpQSk1qY0sydXVJY2tFY2Vp?=
 =?utf-8?B?Z2RDTXdiUmJTSThLaTdkaTZlL1VHTnI3WXBsZFd4WXZocGlmdGlPN0FBNEd2?=
 =?utf-8?B?c0NIbUNMSTVYOXdNaHphb2UrQ3VQd2p0SnNSMWQ3bkp2Q0pYa0o3ak02QjAx?=
 =?utf-8?B?SzVGeHFYanJJbllKaWdCQzlDOExYbzV0M2piYVovajdSRnJ2Q21BaE1icW0x?=
 =?utf-8?B?Mnh0YnBlR0QvcTM0ZzdxSEtpZXU1QzVNcGloNnEyRjV1c1BFeXdsNWVrTGZl?=
 =?utf-8?B?ZTc0VTFpN0JWd1pUWlVpeG9LcXdXSFB2QVdZODE4ZkpzRlVuc3lNSko0N0g2?=
 =?utf-8?B?MHVyRno5K250elZua0FncUJMSiszL09CV1BuRnZPWDZGWHYwMitNQWttMFVz?=
 =?utf-8?B?eTdEdkpWQVdOMVJpUlhKajl4T1grWDVhRmtrSWVNTFh5RUg3ZW9nZ0hiL3oy?=
 =?utf-8?B?N3owSERTdnhLa3VMVTkyS3RQZTJOQmtuTHBDVW11SHV4MmYxSysvOU9LYkx0?=
 =?utf-8?B?SGxQaXNhcXdVUnM2WU9qemR1Rm1IQzNCWHFHR3lrUTJ1T0hEQlJ0WkZxZzIz?=
 =?utf-8?B?YkRBVmYyL2c2K3puWjA5NlhRYjJtMWJDajQ0TG1EcVBkcGRkTGM2S1ZoRUw3?=
 =?utf-8?Q?VwsmoGjpBpYNE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2Fiazk3WjRudXVmSTROeVlvbmRISkVkbEh3VTFhV09hUVllZGdXVjJmK0lR?=
 =?utf-8?B?TnJURDlHMzJsbkxRMVhVTWNsNFlST3UzNUJiUnpaNWsxeVRFdmZOUlY2N1ls?=
 =?utf-8?B?UjlTZFEwV2tmQksyeTBrTHpuWkxLcWo1ZFpncGlLemh4TkVqVmJ1elp5b1ph?=
 =?utf-8?B?eC9rZGYxMENZS0RCanVucURvcTZZakpNZWJ3QnRaODRCNUh4U3lkdHRaVHhi?=
 =?utf-8?B?a1N1MFVOZWVZOG13RUtVbVdDdis0VWdFQlpKMy9ScEUxM1FhbTRDYjRPRERx?=
 =?utf-8?B?VUpsTWE2bHcxV2NyUmNQTlBTSkhEVmxscXdhVmlnUjRaQmpNL0p5dHE4MTRD?=
 =?utf-8?B?azdoYTV1WEFIdVgrWDVtSlFzZlVsWlpPbUFLN3EzS0pMQ1FMWlB6WXc5dmdS?=
 =?utf-8?B?NU5uaXY4MHBFV0N2RERkYldUQ09MVngyclBUcnNJNXA0bE50NkovTkFyK3U3?=
 =?utf-8?B?RzdmM2d3STg1M0JmNVV0OXdta20ySDRqNkdQbitPVnRSM0NJZ0cybTI2OXJQ?=
 =?utf-8?B?WmRGdFRxOXl3Nmp1MmZudjl5SHNwb2QzR1AvWHlDMnhlTzQvSHdpTDRPdVNl?=
 =?utf-8?B?RHJwSjZuNnN5dTh2V3VSZmJsdUJSVkpNRDNMSTRwVGNTd1hUVnM4MXc5QW55?=
 =?utf-8?B?a2JoN1dFY0ZYOWdhS3c5WEVSU3NFaUFvbXo0TnJSdFRQWlZXVFJ1enFDLzlo?=
 =?utf-8?B?Y1FnMVZpOW5scjh3dEk1VHhWUFpiOEhGVTJJOGhaRW8vNDRXTCsrQ1hpWEJE?=
 =?utf-8?B?ZkEyYXdndFluVXRHb1drT2lYUFBhaXNJVnZtUjB6NXRWTEF2RnJpclNwclhP?=
 =?utf-8?B?Nzg1NElBZlcxOHF2dllBNlZDMm1jSGJFeTVCWkFZOVZkZ0p4b3VVK3EvV2xo?=
 =?utf-8?B?NS84N2F6dlgwb3VNOXRzckZLNkVvL3lZSStLTWE4YjYvMHp0OXI3MDdYRkEz?=
 =?utf-8?B?a2hsVGJNTjdLVkxhM0ZMb2pHdjZQNCsrRGk0M0N1TG5LT2FnM1BhMGFLTGhF?=
 =?utf-8?B?MFdvRGRVdTA1Ti9Sd1FzRW5iV3RJM3hFUGhhdmV6TEU4QTlQcEw2eFF6SURm?=
 =?utf-8?B?bDVuSE9qYmhVeDlYVEVScWg1c05rNDR1MmFhQUlweVF3b051S2czRE1DNENw?=
 =?utf-8?B?MEd0WEE5Zzc3dHJnOFJZSEJtUE9sUy84Q05WZnRuOE9uOXlVTkwzUWpmeTNm?=
 =?utf-8?B?MVJZWEIxbTg2N2JmVWZEZW9lTVJBenJ5RExsZ3BqVWZmOVQvMFFVR0I2Yzc0?=
 =?utf-8?B?VWo4UHExVmF6Zm9Ibjk4cFllRU9oTlE0WXQ4RnFoY2ZEWG4zVlpjQ0lLSlph?=
 =?utf-8?B?NWVyTzQ4bzF1V1RSNXZ6NlFpbFFCWWhMd3NKMWtkdDc1UFFPQ3o3ZnUvcDUv?=
 =?utf-8?B?a3RrWC9oQytnUFlhWTgvVk81N2M0blI3czFOcW8rR1drN01wR3ZQYW95ckkr?=
 =?utf-8?B?QXR4WGpBOVlkUVpEci9uTmdQczk1MnllN2J2blZDdktaUGpYN0tKUDdKTXla?=
 =?utf-8?B?K01jYUtyZ0FnMGVsMkZhb3lHVkFnMno1L2RkcEp6SXdkb3g5c0NmVG9aY213?=
 =?utf-8?B?bkcyWUpFdUpKOTJVVjNyZ0FaTzhxcXljZmY3TEdITlE4MUZuMW8xYksxaGcw?=
 =?utf-8?B?SUlMNnptaGE4UytVYWQ0TnpOL01JWUFjdjJTa3RNdW12MDlsanBVUHNnaWV4?=
 =?utf-8?B?bW1QN05QeXV2K05kK2VQQStKeldsSnBENW9xUTFQVTR4TVRDV0NWdTJMVVRu?=
 =?utf-8?B?K3RvZzNCWnpaNzNrbGc4VFp4VVdWZm9yRzhBL0FBMVdpVWkyYW1FWjJRb08v?=
 =?utf-8?B?V2pDT3VKVEd6WVQwQ0paNzN3UGZNeVpZWll5bDNjOFlVSU5kKytOOUdISkJO?=
 =?utf-8?B?dVhoMW53L2s3MzBONUt5Z2NMZlJDbnBGWWFDS0NRS3hzd3BLZ3pBU2M0UlhW?=
 =?utf-8?B?ZjczTUFvWGorZHZsSFdFVHdQNk9vcmVoSy85cEtqLzRMdGtwS2MwRUJ6Skgz?=
 =?utf-8?B?WFlDZi83R1BxSXY4bnhVdXVVRyt0eTFoelF5a3B0WVV6Z0NrMlpkc1lXVjZS?=
 =?utf-8?B?R2hnSytZMGNSOW8vaXZYc2JvTUZ5UDgyQXlpTWtNZkl1YUI2c0JBQlh5Qk9Q?=
 =?utf-8?Q?QiLYjhoupuXgFCETSVTeEzMMP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7700a7-5d20-4fc7-215c-08dd5b27e9fb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 14:21:54.9803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4DeHvD1hSzd0lzTy9IQPDpO98OVlhGnSRdAZR8PWRWUWJo7zG51Imw7lXUwI/0O10wa7Q69Vh853ZWLRUH+EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692

Hi Dan,


Thanks for the review. My comments below.


On 3/3/25 20:15, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differentiate CXL memory expanders (type 3) from CXL device accelerators
>> (type 2) with a new function for initializing cxl_dev_state and a macro
>> for helping accel drivers to embed cxl_dev_state inside a private
>> struct.
>>
>> Move structs to include/cxl as the size of the accel driver private
>> struct embedding cxl_dev_state needs to know the size of this struct.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/mbox.c   |   3 +-
>>   drivers/cxl/core/memdev.c |  25 +++++
>>   drivers/cxl/core/pci.c    |   1 +
>>   drivers/cxl/core/regs.c   |   1 +
>>   drivers/cxl/cxl.h         |  98 +----------------
>>   drivers/cxl/cxlmem.h      | 108 +-----------------
>>   drivers/cxl/cxlpci.h      |  21 ----
>>   drivers/cxl/pci.c         |  17 +--
>>   include/cxl/cxl.h         | 225 ++++++++++++++++++++++++++++++++++++++
>>   include/cxl/pci.h         |  23 ++++
>>   10 files changed, 293 insertions(+), 229 deletions(-)
>>   create mode 100644 include/cxl/cxl.h
>>   create mode 100644 include/cxl/pci.h
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index c5eedcae3b02..ae92db38a921 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1426,7 +1426,8 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>>   
>> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>> +						 u16 dvsec)
>>   {
>>   	struct cxl_memdev_state *mds;
> I would ultimately expect that this starts to use the
> cxl_dev_state_create() internally as well to keep those internals
> common.
>

OK. I think I can do this for the impending v11.


>>   
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 2914e3ff104b..14bd74823467 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -636,6 +636,31 @@ static void detach_memdev(struct work_struct *work)
>>   
>>   static struct lock_class_key cxl_memdev_key;
>>   
>> +void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device *dev,
>> +			enum cxl_devtype type, u64 serial, u16 dvsec)
>> +{
>> +	cxlds->dev = dev;
>> +	cxlds->type = type;
>> +	cxlds->serial = serial;
>> +	cxlds->cxl_dvsec = dvsec;
>> +	cxlds->reg_map.host = dev;
>> +	cxlds->reg_map.resource = CXL_RESOURCE_NONE;
> Let's take the opportunity to now use compound literal syntax which
> immediately answers the question of whether any new or not included
> fields are initialized. I.e.
>
>      *cxlds = (struct cxl_dev_state) {
> 	.dev = dev,
> 	...
>      };
>

OK.


>> +}
>> +
>> +struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
>> +					   u64 serial, u16 dvsec,
>> +					   size_t size)
>> +{
>> +	struct cxl_dev_state *cxlds __free(kfree) = kzalloc(size, GFP_KERNEL);
>> +
>> +	if (!cxlds)
>> +		return NULL;
>> +
>> +	cxl_dev_state_init(cxlds, dev, CXL_DEVTYPE_DEVMEM, serial, dvsec);
> I expect the devtype will need to be passed in as _cxl_dev_state_create
> can not assume memory expander vs an accelerator.


Yes, this is needed for the work to do related to the first comment. 
I'll do that.


<snip>


> Ok, all of the above make sense to move because they are needed to be
> able to export the size. It would be nice for the follow on patches to
> delineate which fields of 'struct cxl_dev_state' are expected to be
> private to the CXL core.
>

I'll do so.


<snip>

>>   
>> -/**
>> - * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
>> - * @dev: driver core device object
>> - * @cdev: char dev core object for ioctl operations
>> - * @cxlds: The device state backing this device
>> - * @detach_work: active memdev lost a port in its ancestry
>> - * @cxl_nvb: coordinate removal of @cxl_nvd if present
>> - * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
>> - * @endpoint: connection to the CXL port topology for this memory device
>> - * @id: id number of this memdev instance.
>> - * @depth: endpoint port depth
>> - */
>> -struct cxl_memdev {
>> -	struct device dev;
>> -	struct cdev cdev;
>> -	struct cxl_dev_state *cxlds;
>> -	struct work_struct detach_work;
>> -	struct cxl_nvdimm_bridge *cxl_nvb;
>> -	struct cxl_nvdimm *cxl_nvd;
>> -	struct cxl_port *endpoint;
>> -	int id;
>> -	int depth;
>> -};
> Why does this need to be public?


Good catch. This comes from the previous try for using this in v10. It 
is not needed for what the RFC tries to do.

<snip>

> Looks good.


I think I got what I need now for v11.

Thanks!

