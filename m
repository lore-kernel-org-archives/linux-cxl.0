Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6972B9B4
	for <linux-cxl@vger.kernel.org>; Fri, 13 Dec 2024 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734099327; cv=fail; b=Rh5S6gXUOmx/LWkziBi8K6VsiGRv2YbNq+QRqFQczcRVF8vy42lor81YLWqVZjSHadzQvq4dAPhmvcT5iPPQGZJHcgzYkJpifyWuYxby0FCl8t4dFQ2qCiJGwTDFBWvGeXjH6Hrzy4tqW+lVT4Q8nsGaMLB8fWwc3RWXGZOLmfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734099327; c=relaxed/simple;
	bh=VnIPlC/UP4VZtVkWKpRxSGkY8snsIEeZXs8/9O1y/XY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VFlS2sU2EpBh4N7EAws7MEKuvLj1PkDfzijWAeEXbwEYrdSvbXcw9Zvwgf1GfPDDl+cQbpxfTz6hFKoJVXHI2n49CgBaXCJZwN6SV3FF9MWrLq0QEv+WgZG44St7A0+wnCb3ag4TMQCE9N3oqQHzDJWz5zzIkyNutkFnd/pNDH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RUsm5QXh; arc=fail smtp.client-ip=40.107.96.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RUsm5QXh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8wjhoSAwhAEqvXLKlnO9R2545O7+YQ4yuYIFUyXClRi1JmKY9lnFE9vedBtmBv6RG6we+5Ep5i58yHSe8DxTWdvD2lRI3vO6SLnQtiLFPdVQcC+4RmLdyVkR9h2qiEVEzGmQQUnbD8zmoGxvDrOjynfoVEKfFDaAUuxUvsXc8hcq8d7AmnzcjMLdWk5hdzXc30VG0tDyrEZJ/VyFeDIYW5FtE9/KQZln6LFDXqgNt7xxNrvyGATbzmq4Cqn0WMTx/9ZQ18ueJ9HaCtyFL8cBPl9ovebN9YiKoWl7gmFLCA0pTSEhKotTxhI2Vv8b4VEyem627cy6pwQ4X9k08ujjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYnuLttV+n184ZUvTG9q/YzmPtId21KtnQf9R3djDgQ=;
 b=pspZrawTsbBwN0yVTlsR03ir15M7PAEyX30tCEhiYncaiNuGddly8T3YC7inG8DNQp0ilMFn1ClAIqA/8HRqouvRzk8tX80wfgwVOUmu8zzXwnxxS7xwSQRlAiZg+j+oK43SFW8p/DPMij/IdOflibLHLduA/KebNYVEUQTzlQlZ6891FhRc0RCR2PmqZmQCLVQrIRNzFW7KakL/b5iVPzt9+aDCXmZvc5jtAUuU9NTOw2dVXPIW41Jb0p0/dhNf/nPKNVfzJ4OFD7ZSrc1dGte5qHBkpxDWWoU2GdYSh7njvT9ex83dSOqvYfkzRtsMTehB0QvoATbYfa6Ud0OM4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYnuLttV+n184ZUvTG9q/YzmPtId21KtnQf9R3djDgQ=;
 b=RUsm5QXh8OeSsbmE/Y6qJd5bgV4a2ZAtKud5zYYtPjQysGxyw6bfaWPILQXu47gT2TnX1lJ2kuKnv8Q7TJsB3j54HDowETNslzJ0wZE6jJ1D+13uP5TYhLkK6+LLcw48v/p0q74zIHUVVDElYEcWU28DG7wBI2bF1FWz7pSk8BI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 14:15:23 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Fri, 13 Dec 2024
 14:15:23 +0000
Message-ID: <37deb771-f521-7131-29cf-5f425a70249e@amd.com>
Date: Fri, 13 Dec 2024 14:15:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: RFC: Kernel CXL cache support (and IOMMU implications)
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 iommu@lists.linux.dev
References: <cc2525a6-0f6a-c1c8-83e1-6396661efc8a@amd.com>
 <20241121003316.00001cd3@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241121003316.00001cd3@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::11) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY5PR12MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7007c7-1b81-4e67-d833-08dd1b8094c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1Q1VFllNnIwclc4OGpPeHVLZ3paTitodzgxVGQ5aWhXYUxQR3dIMTBpbHk0?=
 =?utf-8?B?MlFRekFSRW1vK0h1TGVrYmlYZDI4Mk1mcmVVTTRGbXA5N2xlY0lKd29ybEYy?=
 =?utf-8?B?ZVR2N0dZbHN3T2ZrWEYxYTBRLy85ZjJtNk9ZUGNWdStySzREZDg5aWNrdGdu?=
 =?utf-8?B?MG83WjY3aU0wZWZtRHc1aWk0V0hPTm1oWG4vcEtaTmJSS0xwNU5kQWVFMjJF?=
 =?utf-8?B?RmRCWWFTMGU5Q01PSEk0NVN1RWNWRnV0R0J6VDFjZlRMTlB2M0NjY3pST2M3?=
 =?utf-8?B?VkFlTWwzSzNBc1RtdkVmVzZCS2dvUTlpMzRmcWFpYTVoa243SGV4SGt0Y1Iz?=
 =?utf-8?B?c242WXJuRzg0bEJwc0pha1dDajhlRGd3OTVtZFRmQk9xKzJoTTNlQmxzQkh4?=
 =?utf-8?B?dmw3czJlQ3FJN0tTL2o2ZmtSbk1LSFJrM2xFQXRvNktSbXkzZHc4WkNNT0Jv?=
 =?utf-8?B?VTA2S2dBSFpCTU1OU0lScDhoNmRLYUtFMGthaCtNTHJ2RmlYdXFic0ROMUxo?=
 =?utf-8?B?aVptZjE2SXAzTWpFZkFGWFNkVlU2WVJUNUk1MlFRYXpacmtTSjF2K2VRaXdY?=
 =?utf-8?B?YUV0Ym1Sd2oxTE41dlB2MXdYM0FMMVdQaW9ReTAySHkxZ0xDY3FwRjNIQ0pC?=
 =?utf-8?B?MUJFUnI1bFd6V0gwSHNsMk5RTUNRMUZua1Fkaklvd3htaXdpQnluTjI3aVFL?=
 =?utf-8?B?c3E5ZWYyUVFGWUQ3Q0NRQzVzZDB3R3lMdzhkTnRsbVBHclZKMTlpSzB6Z1BU?=
 =?utf-8?B?eXlmSUFsdVFmU0Q5R0oxQ1VQbUJ2ck1pQURVZU1Wdm9PZm1PWE50V0liQ0xX?=
 =?utf-8?B?SU15WkZmOFpib1ZITGlIN2pyK3ZhRS9IMDhPMmE2L0ZVcTdLTlVwMkY4WHZM?=
 =?utf-8?B?ZWR3ZXJ1cjU0OVRKT1Q2V1dTcTlWdnNydXVQK0V5U2xDTHNDWkJwbGpGTVdY?=
 =?utf-8?B?MjZydXBIaXI5Z056czZ5OEUxMVVTQkE4TjhVaXB3b0E0T3A4aW9SVjg4MDJP?=
 =?utf-8?B?cElYcTlzZkJXVlJZajV0Yy9iYTFrS1o3cXZsMHpZQjNkQ1hpaEhGWHZDVGtD?=
 =?utf-8?B?TVV0QVM2T1BSalFFYWcrUDJxRlpGQU1icEJzMWk1UFN6dEpTdTkrVVN4VUg2?=
 =?utf-8?B?cGFWOFRvOEl1bXl3a2laV1lKNW9yRmpYSHEyRFBLMzBhMVVkZk1RVXFFQ1Nj?=
 =?utf-8?B?TkVIc0N1bHNEUmJmU1RtMlFaSU10QnA4dlF0NDRRamFFakhJUm5FWEJOdkNY?=
 =?utf-8?B?N0JEYi95SDU3cVlPZUVPZWhCWUNza3lTY3FTdUhENjV1T3dodExaaDNTcUx6?=
 =?utf-8?B?dDhacEN0bTVVOFpnRmZ5ZmQwMjlVU25YZXVtRmVwenQzeXV4bWw5d28xVUR6?=
 =?utf-8?B?d3hwdE45aTZMK2tTSUdMS1hGUS9wWUpDV3hNK204S3JLQ1grYXdlUVRSSWdE?=
 =?utf-8?B?ai96Ni9WbVdjdnltNkc4Zy8zWUpBSHpxbHUzQXVNNUhGa1ZiRXVXSjE3aDRQ?=
 =?utf-8?B?Q3lCYWlIRmd2VHVQWWo1bGJQeExVUk5XQlZ0Rlk5eDVERXFrdUpCUFRrTUpV?=
 =?utf-8?B?QXJlK2lmenZDRGxXVzF4bFhwL2U3SW9mZHhHVnlzVDRKTjl6aHc4anFqVnN3?=
 =?utf-8?B?V3BVMUFVMWtrYmtKUVNJY1l1QURMa0U4STdmY0UyNHhBQzRzRjAzS1hIam8w?=
 =?utf-8?B?bGFIK1ZETUgwcnNmVUVEMDZPaytkUUZhNlI1SkNBRWNKdlBBcjdLRG84QTJ4?=
 =?utf-8?B?d1FRUTNpbmlnL1FRaEI4WXViUEIyMU9pMFdBSytGa1lQYkVJWVpyZnFhMmdL?=
 =?utf-8?B?UUdZeTFtVmhqckltRkJUQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTBFcy9VT0tkM1ZVNzZWMmdqVkEyWHcyV29aNlFpZnNRQ0dPdTJCUXJaQzYz?=
 =?utf-8?B?RHM1MmM2dHI5elBjZEpYWlRHdzdUMmVtREpOZDJtaHV3ZXd3YVhuQTRMdHor?=
 =?utf-8?B?WjcvcVYySHNvS0FCZGJQOERNTGt6S09zN0RHVEZ6M2NMM29UWitSZ2VuUWpo?=
 =?utf-8?B?ZWtsdVZQQTNhOXQ5MWU3b2loem9yMVJPc3NrME95Uzk5dmRBSGRwbkFhWHIw?=
 =?utf-8?B?Y203RUp4T1ZnWjEzNDBaaWFCaHA2dDgzQ3BTaDA2SVZMSFJFQTRJb0RMYm12?=
 =?utf-8?B?NVhUajArdUExSzhUSmZ6UCtTdGowa2hSQWxOMTVUWkZRdFoxWmpocEVPb1BB?=
 =?utf-8?B?U09xMGNoUTlEUDExeU4rVEx1SUdlOFNjbjNxbmlzaGMvSjhNRmtZK1dtdEJp?=
 =?utf-8?B?VWp4QzRtT3IvNDRyU3NHRGlsdUVneGNUV3RlZTRtcDZHQkN1Yi95cnJxaXBX?=
 =?utf-8?B?djVTRGxiOGNpOUJONTVJYVV4ZG91VDQ5NEdBTGo2b2VvVEdrL0ZPeUJyVEFt?=
 =?utf-8?B?TGRBQ2QwZzFiK1VlUHFsVGU3UzN1SmlwajgyV2E5QjlJK1NPMHpQU3MwR243?=
 =?utf-8?B?REU5aEZBU3Q1Ti9PZEFDY0RBWE1DRVNWdTRLVng2ODFGYUZGMFNwZ0NMeXlI?=
 =?utf-8?B?eDZSRlFlTjJlM3dmbGpNQnRqMllwcVBtWlg5RUk1Q1ZCUVN2VllkOFhiQUo5?=
 =?utf-8?B?cGhFd24xZE9zMEN4WDVWWmtOZFRQK05vQWpRRDFsaTBhcGM2YitXb3dnSE16?=
 =?utf-8?B?VER0S1lUend2YTlYV2lXajVLU3pMT2RzNWlxYTljSHMwRTJDT1ZaOTBvdlBp?=
 =?utf-8?B?SHpObUI4b293bUNpU01FUzdpdEQydmZQZnRUUmJwY001c25mb2R0QzRTZjJ2?=
 =?utf-8?B?cUVTU3pIZEpUbTJCWjg3TDZGMFNmakRUU09uZDNFT2xJLzRVVnJUZFBPV09L?=
 =?utf-8?B?Zi8zdW1halgzcHpSdll4djhaSXJXRzN6c3lhcm5qeUtiNTNhWWxsYWV1QzJT?=
 =?utf-8?B?NnlaTFJJRHFBZW1RMEpHSjFkYTBiQkIremJQa29yVEhGYkVXR0ExeDl6cER3?=
 =?utf-8?B?VWlSODF3aU1rRit3WWxaU3F1THdsL05meWR1bjRiTTF6Q0crWU9wT0ROMFhm?=
 =?utf-8?B?MzVvVnFUcU9jbERZTnQ0c05xVEp2M0hPZmhSQXgrbUJzOStCb2JwTlRhUVNh?=
 =?utf-8?B?ZkxxT2xlbzl6cGVyWUZXMko3OG9XZGJYVExRSHFoR0lxQmd3c0FQY1l1WjhX?=
 =?utf-8?B?SVZoZ1JYaEttZVM2b0RiSTRoQ29KOTA2TWRNeXJldmFLNDVESmg0OXlwNFZ6?=
 =?utf-8?B?cFdwdVJMbFZWUXhySXg1Z0JnOGhOcHMrT0dobkxRZ1RDa0IyVEl4aHUyRXJm?=
 =?utf-8?B?K2x4SERWb2tTOXRGY0dZUC9xWjdkcWFQQjQ0emE2WWtPR0l4WWQwNmVBUWlP?=
 =?utf-8?B?T2ExSXlrWTFyT29VQUY2L1lCV0xKTHFJdHRlWTBqSFE3WFNKSW90WGFNT3JF?=
 =?utf-8?B?S1YrN3hkTXkvWTNQZENrZUlONkp5VXhqUVQzczVPMVJMeGhEazVpN1RoMWJs?=
 =?utf-8?B?LzRhVnFoNXpiSzd3MHZ3K2o3T2VqNHhqQmJTZ05acUNuU3RURjhVbmF6R2s0?=
 =?utf-8?B?WkxjM1kreUFsLzROU3d6T0EwTXJlWlJLZWx3ZklMOUNpSGdnWWhmUXl2dk02?=
 =?utf-8?B?c0dtcGtHeXBNN1pVZG9HQVlLSDV2a0Qwb3diU25uTWdtSUt3UzR0R0JnL0JK?=
 =?utf-8?B?Y3JaTXNnVjJvb25NMXo5MURvVmRiRTZLRk5xeFVGOFlyNVZ1aVg0dmdFTUJ6?=
 =?utf-8?B?TGVDd3lkSkFJKzcvQVZDVXZoYzMzeDFsNkJ3VGpOZjlkUnBLODYwWDh5eFdU?=
 =?utf-8?B?YkZTUHIzM1VyNWpkYThHNEEraldwVWw4V3ViWnVrdXJFbWlrMlgyN294eDdC?=
 =?utf-8?B?TWJDbFNXTTYwYmczblVydkdFeTJBNVE0dlM0WVBVRURWNWtZSk82ZERDVU9R?=
 =?utf-8?B?RkUxQWR5MFNRcUpKVllLMWRHK1I2MnBMYVNXWUw4blM3RXVhSEFHelhyRnRT?=
 =?utf-8?B?bkh3SXNFMnVIMGhmYkVxM1pMWXZEQzc5Uys5Wk5MNlV5K2w5S0Rnc04rbzlW?=
 =?utf-8?Q?XYwHI7K12sxJM5cXg+z4tR4O6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7007c7-1b81-4e67-d833-08dd1b8094c3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 14:15:22.9613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZq9qtwuKJGcMitEdRxQfd3UTdVFV/FtwRoawEevJ5ByIJ/pFhz/qxroGCYUDAvrDD7rxw6XP/Cdr1Z+ZRhacQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083


On 11/20/24 22:33, Zhi Wang wrote:
> On Tue, 19 Nov 2024 16:52:15 +0000
> Alejandro Lucero Palau <alucerop@amd.com> wrote:
>
> Thanks so much for the doc. I just quickly went through the doc and here
> are my comments.


Hi Zhi,


Thanks for your comments. I did not reply earlier waiting for more 
feedback from, mainly, the IOMMU kernel guys. Maybe CXL support is 
something most of them neither have contemplated nor aware of (maybe) 
requiring special handling. I really think IOMMU/DMA API will need some 
change, but this document is for discussing it and maybe proving me wrong.


Let's hope replying to your comments keep things moving somehow ...


>> November, 2024
>>
>> Tittle: CXL Cache support by the kernel
>> Author: Alejandro Lucero (alucerop@amd.com)
>>
>> Version 0.1
>>
>> Introduction
>> ========
>>
>> After the LPC where I presented the current status of the Type2 CXL.mem
>> support
>> patchset, and some ideas about supporting CXL.cache, it is time to dig
>> deeper in
>> this second goal, and discussing the security/reliability aspect as well.
>>
>> It is also important to try to describe how this is going to work and
>> what the
>> kernel needs to know and enforce. Reading the CXL specs when having in
>> mind some
>> specific use case can easily lead to assuming certains aspects with a
>> different
>> perspective from other readers/use cases. To start with, it is necessary to
>> differentiate two "CXL cache" functionalities when a Type2 device is in
>> place:
>>
>> 1) A Type2 device caching Host memory.
>>
>> 2) The Host caching HDM memory, that is the memory inside the Type2 CXL
>> device.
>>
>> The first option is also what a Type1 device can do, and the kernel support
>> needs to manage all those Type1/2 per CXL Root Complex knowing the resources
>> limitation, that is the snooping cache size.
>>
>> A snoop cache allows the host to track which memory is being used/cached by
>> those devices, enforcing the cache coherency. The specs are not clear
>> about some
>> important aspects regarding how the host can enforce the proper use of
>> this by
>> devices or even if the snoop cache needs to do so. At pages 786 and 787
>> of CXL
>> specs 3.1, how the system software should deal with CXL cache devices is
>> given,
>> but this is inside a Hot-plug section. I think we can assume the Host
>> firmware/BIOS will follow same approach for enabling CXL cache, and the
>> kernel
>> needs to look at those devices with CXL cache enabled by the BIOS for
>> properly
>> handling the available space in the snoop cache.
>>
>> It is also worth to mention the CXL.cache protocol can be used in the two
>> "CXL cache" functionalities listed above. However, the last CXL spec implies
>> CXL.cache only used for the first case. Some comments about what the
>> specs say
>>
>> regarding number of devices with a cache for host memory:
>>
>>           - up to 16 Type1 and/or Type2 devices allowed per VH.
>>
>> can be easily confused with the limitations of just one CXL Type2 device
>> using
>> CXL.cache for enforcing coherency of its HDM. This limitation is
>> overcome with
>> forcing Type2 device using HDM-DB, which relies on CXL.mem instead of
>> CXL.cache
>> for HDM cache coherency.
>>
>> While the Host is assumed to be able to access HDM in a Type2 device, and
>> keeping data in the host cpu caches, it is the Type2 device
>> responsibility to
>> properly manage cache coherency of its HDM. There is nothing the kernel can
>> control here.
>>
>> Therefore the interesting part and what this documents tries to cover is the
>> Host memory being cached by Type2 or Type1 devices. While the main goal is
>> discussing how the kernel needs to handle this, and to describe how it
>> should
>> work when CXL devices are used by the system/Host, some comments are made to
>> cover the virtualization case where those CXL devices can potenetially
>> be used
>> (device passthrough) by guests/VMs. I try to expose the current security
>> problems where IOMMU is used for restricting what a guest controlled
>> CXL.cache
>> device can read/write in Host memory what I think needs to be clarified by
>> hardware vendors.
>>
>>
>> Understanding the memory accesses from CXL devices
>> ==================================
>>
>> For the sake of presenting the case about kernel CXL.cache support, I'll
>> try to
>> explain how it works (I should say "how I think it works") and the main
>> points
>> to discuss regarding how to implement this support. So, do not take the next
>> explanation as the definitive answer or guide, and if you think there
>> are errors
>> or maybe too much generalization at some points, please help fixing or
>> adding
>> further details. Also, consider some parts as just me thinking out loud,
>> what
>> maybe help other people (or confuse them!).
>>
>> The CXL.cache protocol allows devices to be part of the coherency ring
>> of the
>> system.
>>
>> Let's start with a Type2 device reading from a specific host memory
>> address. The
>> final situation is 64bytes (cache line) from host memory copied to the
>> device
>> cache, supposedly for being used by the device/accelerator. If the data
>> changes,
>> because some host cpu modifies it, the device will be signalled by the
>> coherency
>> ring, so the device will know. The important point here is the device can be
>> told because the Host knows the device has a copy or the only copy of that
>> data/memory. And that is thanks to the snoop cache implemented by the
>> CXL Root
>> Complex.
>>
>> A device caching host memory can be used as well for writes to host memory
>> through the cache coherency ring. A device can not just read host memory and
>> keep it, but it can modified it. The implications of writes versus reads
>> are not
>> important for the goal of this document. It requires the device to
>> support more
>> protocol exchange cases, but regarding the snoop cache, it is irrelevant.
>>
>> There arise obvious questions about how this snoop cache is going to work.
>>
>> First, with the simple case of just one device caching Host memory. From the
>> specs, the device CXL.cache should not be enabled by the Host if the device
>> cache is bigger than the snoop cache. However, what does preclude a
>> device to do
>> more memory accesses than what the snoop cache can cover? This can be partly
>> explained with some allocation control for CXL.cache what is discussed
>> in the
>> next section. But a "rogue" device could try things like this, what for
>> the case
>> of a single device using the snoop cache and without any other concern about
>> security, is probably fine:
>>
>>           - With a Type2, the snoop cache will tell the device to release
>> another
>>             line, meaning any modified line to be sent back to the Host.
>>           - Any performance problem will only have an impact on the
>> device itself.
>>
>> Then the case of multiple CXL devices caching Host memory in the same
>> CXL Root
>> Complex and therefore same CXL Snoop Cache:
>>
>> * How can the snoop cache track reads from different devices without one
>> device
>>     monopolizing the full space?
>>
>>           - enforcing snoop cache slices by software?
>>           - allowing specific/limited host ranges by the kernel?
>>
> I would like to compare it with the approaches that solves the similar
> problem of the CPU cache since they might have similar essence.
>
> CPU cache suffered from the similar problems that noisy and
> restless neighborhood keep poking the cache that might cause performance
> drop. Nowadays, it is solved by the HW mechanism, cache allocation. For
> Intel, it is called cache allocation technology(CAT) which is a subset of
> Resource Director Technology(RDT). They can be also used in the
> virtualization world.
>
> Before SW gets the support from the HW, many research papers were talking
> about solving it via page color. E.g. allocate the VM memory with page
> color awareness for different VMs. But I don't think those ideas eventually
> land in the mainline.
>
> Back to this prob, I think probably SW is going to rely on a HW mechanism
> to solve this problem nicely and decently, the same as CPU side.


I agree with the need of relying on HW, what the following sentence (in 
the original doc) tried to summarize.

But we need how this is done by HW for avoiding some undesirable 
situations if we just blindly configure CXL.cache to those devices 
advertising it and apparently without no problems regarding the snoop 
cache size.


>> AFAIK, there is not any kind of hardware control for avoiding this
>> contention.
>> Note that with the proper checking by the BIOS and by the kernel (for
>> hotplug or
>> those not enabled devices yet during boot time), the size of total
>> device caches
>> allowed per CXL Root Complex should not be bigger than the snoop cache
>> size, and
>> therefore theoretically no contention at all ... if the devices do the right
>> thing. From software the only thing we can do is to ensure the CXL.cache
>> accesses from a device are within a range with same size than the enabled
>> CXL.cache.
>>
> What would be the consequence if we violate this rule?


Contention or just one device getting less snoop cache coverage implying 
requests from the snoop cache for flushing cached data before trying to 
access more data in the host.

With a full snoop cache, a new access to uncached addresses will trigger 
some action by the snoop cache. I'm assuming it will be the device where 
that new access comes from the one receiving orders for first flushing 
cached data for making space, but I may be wrong.

But a rogue device, and the first using CXL.cache, could get most of the 
snoop cache if no other control existing. Has the snoop cache have this 
control per device about amount of tracked cachelines allowed? If so, 
who is configuring it properly? I would expect the kernel CXL core being 
the one after doing other checks for validation. If the CXL specs do not 
specify how, we can expect different implementations, and the kernel 
will need to implement a generic frontend layer with per vendor backends.


>> Therefore, some memory allocation API is required for dealing with the
>> amount of
>> memory the snoop cache can track, and the host memory a device can
>> access to.
>> The device needs the physical address to work with, and it is in this
>> required
>> translation from virtual to physical addresses where we can enforce the
>> restriction. Of course, such an API does already exist, although not
>> with the
>> checking we need: the kernel DMA API.
>>
>>
>> (Secure) memory allocation  and CXL.cache
>> ===========================
>>
>> DMAs allow devices to perform read/write operations to system memory
>> without any
>> cpu intervention after the (meta)data about how to perform the DMA is
>> given to
>> the device. CXL.cache is more than DMA because the system memory caches are
>> implicitly involved but for the sake of handling this by the operating
>> system,
>> not too much different. The important point here is there is no restriction
>> about the DMAble memory to be used by a device, but due to the snoop cache
>> limitations, this needs to change for CXL: code aware of the snoop cache
>> state
>> and what a device requires needs to be consulted for properly handling the
>> available space.
>>
> As what I replied above, I think we probably need a HW mechanism to solve
> this problem nicely and decently. (Thinking sharing cache is
> also a pre-condition of side-channel attack, even here is a snoop state
> cahce.) With the HW mechanism, allocating the space of snoop state
> cache might imply a glue layer of snoop cache management for different
> CXL HB vendors to plug into the CXL core.


Just what I did mention above :-)


Glad to have someone else seeing the problem.


>
> So when the CXL driver is initialized, the space of the snoop state cache
> is allocated. With that is solved, for restricting the device to access the
> memory (creating/mapping an IOVA for the DMA memory), SW can still leverage
> the current Linux IOMMU/DMA APIs.
>

This is my main concern. Note the DMA/IOMMU is likely needed for normal 
device operations, and that will be through CXL.io. Same mapping should 
then not be shared for CXL.cache, or it can, but with additional per 
mapping flags and obviously API changes. The implications here are 
obviously more important if IOMMU is enabled, at least if we take what 
the specs  say about some ATS/IOMMU mapping only to be allowed by 
CXL.io. Without IOMMU, it turns into the problem of rogue devices 
monopolizing the snoop cache.


>> Should we use the kernel DMA API for CXL.cache allocations? This API
>> deals with
>> memory coherency what is not needed for the CXL.cache case. However, it is
>> connected with the IOMMU functionality what is required for CXL.cache if
>> it is
>> enabled.
>>
>> I think the solution should be to implement a CXL.cache allocation API
>> inside
>> the CXL core dealing with the snoop cache available space, and to
>> connect with
>> IOMMU kernel code when it is enabled.
>>
>> A security aspect behind DMAs is a device has (usually) no restrictions for
>> memory access. This is true in a system with no IOMMU hardware, and
>> CXL.cache
>> is not different in this case. With IOMMU is a different game though.
>>
>> First of all, IOMMU will be in place for CXL.io, what implies legacy TLP
>> PCIe
>> packets. A CXL.cache operation can not be handled by the IOMMU hardware
>> and the
>> spec states ATS to be used beforehand, that is, the CXL device asking
>> the IOMMU
>> hardware about the physical address to work with, and keeping that
>> translation
>> internally. The CXL spec specifies ATS service extensions for CXL, and
>> some ATS
>> requests can tell the device some addresses only to be used through
>> CXL.io. This
>> implies some sort of knowledge about CXL is required by the IOMMU/ATS
>> hardware
>> which depends on how the per device tables are programmed by the Host.
>> However,
>> AFAIK, this is not supported yet by any Linux kernel IOMMU vendor
>> support. Note
>> the usual IOMMU device/domain tables will/can be used for normal DMA
>> transfers,
>> so IOMMU configuration, both in the Host and by the HW, needs to know
>> which parts
>> of the domain are for DMAs and which are for CXL.cache.
>>
>> Assuming this support will be implemented at some point in the future, the
>> questions are, when?, and, how safe is it?
>>
>> Can a device issue CXL.cache operations using arbitrary physical
>> addresses? It
>> seems there are some cases where the hardware can take control of PCIe TLP
>> packets with the ATS bit on. For example, if there is a PCIe bridge in
>> the path,
>> and with that bridge using a specific redirection table based on
>> configured ATS
>> per device ranges, any TLP with the ATS bit on will be redirected based
>> on such
>> a table, and implying no redirection if no table entry. However, that
>> does not
>> seem to be in place for PCIe Root Complex implementations. For example, AMD
>> IOMMU documentation states ATS TLP packets are not handled at all, implying
>> trusting the device, and if more security is required, the IOMMU
>> hardware can
> Are you referring to the ATS translated request here? I think ATS itself
> doesn't consider the security in its mind.


It seems so, but I guess we agree that is not an option for VMs ... 
Without IOMMU you can not have DMAs from passthrough devices, and if 
CXL.cache dodges the IOMMU checks (and none other security mechanism in 
place), CXL.cache should not be allowed in virtualization.


>> check those TLP ATS packets as well, spoiling the ATS advantage. Note
> Yes, AMD IOMMU has the secure ATS support, but as you said, it is pretty
> straight-forward, basically just check every translated request when
> enabled.
>
>> this is
>> PCIe, so CXL.io will likely keep the functionality, but CXL.cache operations
>> follow another path with apparently no further control to enforce the right
>> addresses within the allowed memory ranges per device are used.
>>
>> Because this apparently lack of security for IOMMU and CXL.cache, this
>> implies a
>> CXL device should not be used by VMs or any other user space controlled
>> driver
>> with CXL.cache being enabled. This seems a really serious limitation, so
>> maybe
>> I'm missing something here.
>>
> I think at least for CXL path, IOMMU should have the similar mechanism like
> secure ATS, and let the user to choose if they want it to be enabled or
> not.
>
> In reality, many CSP design the HW by themselves and trust their HW won't
> do messy things, they may want to enable it only on the 3rd party HW.
>
> For confidential computing world, secure ATS is mandatory, and performance
> drop is the price of security.


We can let the user to choose ... but in the virtualization world the 
provider does not want the user to choose ... and if CXL.cache is like 
DMAs without IOMMU, I would say this is a really good reason.


>> Regarding virtualization, assuming the security problems do not exist or
>> will be
>> solved, while CXL.mem can be supported with an ahead mapping by the
>> Host, with
>> CXL.cache this needs to be handled when the related driver asks for specific
>> memory to access, and then to configure the IOMMU/ATS tables by the
>> Host. This
>> implies the emulation needs a backend, what an ahead mapping, as currently
>> proposed for CXL.mem can avoid.
>>
>> Finally, if my concerns about the security of CXL.cache with IOMMU are
>> unfounded, at least this document should describe how is this solved and the
>> security enforced by the hardware, and if the kernel requires to handle it
>> specifically (what I really think is the case, at least with IOMMU changes
>> managed by the CXL core).
>>
>>
>> Summary
>> ======
>>
>>
>> Next the proposed tasks to perform for supporting CXL.cache:
>>
>>           - CXL core handling per device CXL.cache enabling based on CXL Root
>>             Complex snoop cache state.
>>
>>           - CXL core implementing a CXL.cache host memory allocation
>> restricting
>>             the physical memory a a device can access to through CXL.cache.
>>
>>           - IOMMU being CXL aware and dealing with CXL.cache vs CXL.io
>> requests.
>>
>>           - Clarify CXL.cache and security with IOMMU.
>>
>>
>>
