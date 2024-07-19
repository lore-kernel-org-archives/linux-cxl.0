Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF8514600C
	for <linux-cxl@vger.kernel.org>; Fri, 19 Jul 2024 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405250; cv=fail; b=HNIjuozYRjcmx0T7XgI2lMYWSV3Yph2kUbS3B+K1XlbhJOn1SHwSh3BC6BxhtGqPh4QWRh+3gOZJeXjuKQJcC9R0o/LqXoOdBPDXnZyJnKarSD4iOibkgqOVox66i285jeXSvoM6Gw5ES0d35/e6keIaneXzebi2J6PutxTQ4w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405250; c=relaxed/simple;
	bh=WS+jcveAHFwtK2Gv3XAK2WFYJa354IyOa4qg+kuygKk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DCyOKH7G839mNanBHOur6brTW/RP3Jz5CTZTRNJLUx8xIAO3AQy72EtCofHZea5GieQvYNEz19Eu5moaAig5H5n03WPGrxgDN91p6IFkYQVWc7ysVphel8U3tg8qlTquh4B/gb9kdPMSlQCfsqwSKpWukEy6hoR5a+15jv4xoNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S2Xf7txl; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S2Xf7txl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lkak5S09BndddxSLOnqGhGLq3sD0jhf6vXtVIbmRriMYHb47Wk7yu4IE0MCQSRJ8IvNZOHQDunD77V5uKD5ijO0aWEPGHp51WzMH59BYSNQGLLrvbgh1funIbxYed/x7L+a8Pnkkmhga08yidf/x4ypciEU/P2G+e0CvhPAVBCspyzHPD09RvF7RJBko45mDvsMjXg2C8/yFlAOKQSkWN2CDTqCZIsSUcm/4bg+lBIkGH/+RjAyjXLKxOG7C3TIeLEB+fVfJN51qZn0iijKEFOjBCGHA8dlUdpnuX3LFxbTjVV8DQ+UqecrPXmDRYC1mYvcDSs365dp8Ob1PcuTC+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juDliP8sNKjxdHFbIVO22ka9Dj4ixpAZ6f/D9+2d8c0=;
 b=W45ExwOllaeCQ+66AOM37OrojErJ3WTC0DHmoZdd9qdDgvdA5aR1v3pY2OjLPW/PUShR8QPjHa8cA66Ggc47D7pYBrpiBompn/XoS1PsD+NddHBJX/DXr5e6j+pc/FHq/H67GbogxZ8PS3GqWAOQyxJ6NDv3WTDvNjUTs8g87ZIbVMvQxPq5ioOVapecz/+nnxlBOhqT93fU5xocY8WXe74rlGkm7ybsyGFHwppc+Q22Q5OLBndLG1pKuBkvQd+aXSj3FPNeiMU+sP2jkXt6HNd7jBIoER1apyA355k8YhDMHTBbPqchARBfMixeynEnnXMqLqMtTyP0cygKdzzfxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juDliP8sNKjxdHFbIVO22ka9Dj4ixpAZ6f/D9+2d8c0=;
 b=S2Xf7txlDdWvQnvo0PKyU0r2T9qioPSknv39+Q/E1dXDVqtO7geOz3joWN77DVLJG2EAplavcW7FF7hwPrLDfZoZR75vmIVzPwoOqi7oG6sYoXJ4RiMMlTuz2s1ugBtDWsghl6L2so1VuAUs0EXJfY1+7ov20YmfDIV0b/khtxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Fri, 19 Jul
 2024 16:07:26 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7784.013; Fri, 19 Jul 2024
 16:07:26 +0000
Message-ID: <d69f1df9-a879-cec2-192b-5fec7d507e68@amd.com>
Date: Fri, 19 Jul 2024 17:07:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 01/13] cxl: Move mailbox related bits to the same
 context
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20240718213446.1750135-1-dave.jiang@intel.com>
 <20240718213446.1750135-2-dave.jiang@intel.com>
 <6f0a4aaa-c555-ae7e-2614-f15871e5725a@amd.com>
 <0d9e88e2-e79a-4ce6-87ec-3cd33b4afeed@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <0d9e88e2-e79a-4ce6-87ec-3cd33b4afeed@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0095.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::35) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e3ad543-6732-4712-2d41-08dca80ce1be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aG15dkFrTkF1bzVjTWEwWmhLUlYvaUFmd1JROTdrR1YrR0JoZXdSNEFOZTV4?=
 =?utf-8?B?YnFBd1B2VnhMZ3RacnZNWktwK09RK1lHY2Nmd3pBaXNQTEhobzNuWlNhZ1BB?=
 =?utf-8?B?TDRnSldqWkdKNHNOVEIwYllMT09EL256NXdCTDg4Mm5UcjJvdnZkNzlwUE1v?=
 =?utf-8?B?em9BMFlWMGFDRWsrM3h0TVVaVkVwRHJqQi9SemlSNHp2NEVySHl1aCtTeTVY?=
 =?utf-8?B?ZjJlNE5CVWpCaEViK1pJcXVtOW05SllTY2kvK25LU1VpNmZnSDNCblNXYjN0?=
 =?utf-8?B?VUVpYlFUZHNXVEE2Y1FVUHJGZnNGb2VnOFozM2pPK1hGVnFuenltVVFBd2g2?=
 =?utf-8?B?OFlUTHMzUUdPUmgzNlRJWlA3TmRxeVdYc1ZxaVpFNjJhT2lRSGxIRThFTXJm?=
 =?utf-8?B?dG4xTXg3MTNacnQ3YW8vUTRKalZ1d1BMZ1NaMkdwUGg1RG5GUDdlS2xuTUIx?=
 =?utf-8?B?dDM4ZnNVWWNkVTh2KzlQWXpkL0Ftdjloc1BzSmp1SnZCQ2M4SzR6M2tYcWhJ?=
 =?utf-8?B?MUZBcmo4Wlk5cXZrY0pMWllkRUVWMTNRbHI3dWswMERMRi9ZaG4rbklORGhj?=
 =?utf-8?B?WnA0aXIxVXlHY0s3N2x4MGlxWTNaS1IwQk5MYTgxdEhYNUc1OUVUTXQxT1Vm?=
 =?utf-8?B?U3BRdGVvRGs1U0NscjdTbmNhdm5YUEtJd1NFNlpVRTM3dmFwOFd5VjFNTXJY?=
 =?utf-8?B?NW5JQ3BiQ0tnci9oNnk2cGNGVFhtam9uNkFpVXVLS2YyUjlNSVBUMDk2T1oz?=
 =?utf-8?B?blYzbDVZLytMVlJYWHdSaHlOQkpEN216V3NhUXRMWCtNYzc1a2N6NS8zWHRF?=
 =?utf-8?B?cjBCT3dDcWpXMzlreEg3b0hCQjNMcmgvRDdoZFBaenZ0ZW5SUS93dFE4Ym0w?=
 =?utf-8?B?TnhyVlN2dll5QW5mMkdWeWcrdzZDL0VTOGx6amV5WkdNeGNsUnJFMkR2dXNY?=
 =?utf-8?B?bXJVYjk3SDZ6UGZMUWc3dXVFS1ZkR3hPc1VpaW5Jd3YveU5yRWFmYUNpM2R6?=
 =?utf-8?B?d0ROT1dvRDZMZHpEUFc5Z1ZCcnFhNFFYY2d0VnNhNGV3RzVob0hQYjcwRTFR?=
 =?utf-8?B?NjlGUGFTUkpGcXNiYVFuNkQ0SnowNTRnV2loWkJhUlJNQTJzc2VOMlRRNldL?=
 =?utf-8?B?UHdGdFdKbHl5RkFJN0xmVFQ0YzBwZXZJQUh2ZlgrOUZCc2JHWnVGT0gxSVNI?=
 =?utf-8?B?SExaQytXMkdLOUpQOUdVMjVhZU4zTFhid0FUWHBHWmNQc2FQZWdXWE1mTFdi?=
 =?utf-8?B?YUJ5dGN1VCsvQWEyblIyWlR2ZExWN2ZNT1cyaWVjSWVXdVNmemtlRzRLdnM5?=
 =?utf-8?B?R3JHT0RyV0RyeHpXNmRVYTdFUHNmUjNyajZBR2lPUG5KbFY1SU9vM3B1N2lx?=
 =?utf-8?B?Tk85SVA1VmxpMW9rVlpBSEFwaXZaRGNnenMyWjFvWmVVVFgreHh5dWtobE9J?=
 =?utf-8?B?WVJJT2pWTklYcGFGdER3WnVzSWp1N2N2SDFMQzVQQTcrTjIyS0V3YTVSNklp?=
 =?utf-8?B?Y2UzanRzYWVTZ0dSR3lETTdYQU55d3JGNmxvRFFQTEdKUVBZK2Nrdm1CZmpv?=
 =?utf-8?B?NVFNSUV5b3lic3orMisrVU5jWWh6UDFxWTVIMUZzazNpTndoTXZCY1pwZDJZ?=
 =?utf-8?B?d0YxUGlIWDlRYnlBUkRLWmNxY1J3a2Q5Ukt1ZnpZNGV4d000Z0xDNTZqZ2JR?=
 =?utf-8?B?TGVkMlFHektKME1hc2dVY2pPL0Q2b0QyY1U5UDNNbkYycUFKOGJubHdBU1lu?=
 =?utf-8?B?SFNpSTBOT1NISEFya3hDTFQrMDc2S2lGT3hObUpUZUZRZ0xLOXhZSy9PK3dq?=
 =?utf-8?B?VlRyRWd4SXpLdStNcjBpdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXlZZ1YxMDhXcWtiQjl6L0FJeVh2RGVqNG1SdkhsUTRTTzExenJZT2JDM1dZ?=
 =?utf-8?B?RTQ3VG12VmFRbzVkVXdzbVhsNE9zRDAyNmozUHI3SHlndi9Fb3VZQ1Z1UnNp?=
 =?utf-8?B?bUhqN2M0V093d2tSQlJ1ZGVVRkRaUXdtc0RGVWs3UEliWnFnbERpMXFieXBt?=
 =?utf-8?B?VDU2eVZpZDVUZDNnSkFuUlo3VDh3UjdLalNrd1JFb1RYM2lRbWxnMks1N1B5?=
 =?utf-8?B?UWtjYXVxWTYvMUhNZEd5KzJOQUJNd3RJTGlFS1g4MHUwMHpycFo3OTZrUjNh?=
 =?utf-8?B?dnZJOTNmTFJxWW5udWpYcVhzbURQSGNsa1czUU5saEdIOUQ4d3B5cERUb0RM?=
 =?utf-8?B?NS8yTDJVSWkrTXcvdjBnN0kzMjdVb2grSDA2WTViQWE1VWszYXBPVWNibEt2?=
 =?utf-8?B?UXgxL0RtY3k1ZVhyWUdSMWNzZktNN0ZxSHpwNU1RZktuUHNxek43MkpjR3Vu?=
 =?utf-8?B?ZU9BbW1pdGorbzNRU1A3bWtyaWUzeU5sYUtxOVhKekZZc1M3YVdLNmFhcFcz?=
 =?utf-8?B?aUhsVWxTaWp0dUdac0Z0Q3RUb3JGcnVUeVhkNjlsMVdhdnRjSStUVkRiK3NF?=
 =?utf-8?B?V2pMYjlKREtBeUhiRGw1cDdpM0phZ2s5dVcwY05NRGxqWGdDSGJrUjY0cVFm?=
 =?utf-8?B?WFNUQ1VsekF2empxYWVhbGRUQ3BEL2JIVVF5SnRpL3VvOUhTcnJJOHBlNnJC?=
 =?utf-8?B?YWxaUWRRNDBSU2o1WmhjUDBtNnVVY0FraU1ITFFNQzBpRWJFOTJ4ZldmSGJl?=
 =?utf-8?B?QytzcVhhTzFXQWNzWnJQUFdKV3h0SlFsS3dIWWRhVDRxanM4V2t1U2VKK081?=
 =?utf-8?B?bkpDdzRMK2NQYmxpS3FOOVY2bTFWbnJRbTFrNEpSRVRlaDJ5dVpNMjhqNUx3?=
 =?utf-8?B?aFE2dG8xcW5yOWEyS0dwdFYycVlobWJ1TFNreTdRcmlUUHRMRkl2OWtjcTFK?=
 =?utf-8?B?SEtKb3ZsQkJMdWlVZUgzK2ZFWGpFRExpSStBUUlLWElmK3Vqay9xeG4yUkRt?=
 =?utf-8?B?RUl2UnJTYklUSk53M3EyZWlOQnNaemMrZGlMOVdDSU5xMThZVmxkUEIybnIv?=
 =?utf-8?B?eXZpbGRGcGkzTG1jYVZ4MlAxeWExUUh3MUNsMXJKSG9DT29jUHd2dVZjWm5R?=
 =?utf-8?B?ekRhY212TnB6M1FEVTNIaFQ5OGtvZ2RURkRRVCsrK3AzZmNPWUF5ZDBQM0xa?=
 =?utf-8?B?V1F1b2RvSkFyQWhmZFYwMUhremlPYzFxeWpZSHZjZ0JmMnFhSlBXcEYra2pW?=
 =?utf-8?B?QmVmM2dDbHFkYTNseUR6T2RhSjVCOTBveFc0bi81NGsxblRXbGtDNDE5YnVE?=
 =?utf-8?B?M2s4R3hFK0tFeURlNzdHcTRIaWMveW1uanp2NldtVDN6U1FORWl2TEszNndx?=
 =?utf-8?B?UWNhVGVBb1JRMEdvLys4MWxNSUIvdU1TbjF1Sk9qcEtGMlJ2b1VabFRvVkl5?=
 =?utf-8?B?Z3lYazBFYWNWVHBmUThHWG9UMmpDWDZaTHA0ZWlWTlZmcmJxTm5sUS9KeGpx?=
 =?utf-8?B?MERjb284NHpnZmEyZ0RiSFBOVDJ5MnlLT1hVbHBRY2RSNHkySDBqYkkrNDFP?=
 =?utf-8?B?cGV3b2tDSFZCVWc3OG5IL2FJZlBmVHpNVVhkbjdIa0JIUklReFJhQk9lNTNF?=
 =?utf-8?B?VmtOTmdaSC84S2wvNXg4STJDMis4Z3RuSWhxclFlK3VFVEY3aTVOT3ErUksx?=
 =?utf-8?B?dHZsZmtuTkxkWVRVRi9aSU1ZTDUxRHlCc3djUnZuNXduU1ozLzdiVUNtZVMw?=
 =?utf-8?B?Vk44SFhqV0RROVRLY0htOWtCeUNOMjZwYnVqUXhrVlhMMnN1L1ltU0pxUzM3?=
 =?utf-8?B?RFVDY3dRVDVtWEFkZU5pUTFiRlh1c1pMMUx3TG1iSitiU1BmM1l2UVZnUXVv?=
 =?utf-8?B?ZUlQZk1xdzhMMTZ6VW5KR0l5V3hwOTc2WGtCakRrMFdvYjdMUFozUmF1aGdE?=
 =?utf-8?B?ZStGaDFqYXBSTlRhMXBEdGZ1L0RIcjAydFI1bUFOdWlNcjNwNmJ2MDd5VUh1?=
 =?utf-8?B?R0hYY1BIRDEyb2Y1MmtjbXovbEovOWxQbmVsSHV4N0ExRWFoZGduVGErdDVW?=
 =?utf-8?B?STFrdlFGaFNxSDk1NTVSUllrU1ZXOHFLeW0yYjJDSjVOT0g5bTZ5V0FOV2pl?=
 =?utf-8?Q?rPq/KpovpnFkuEcwC9f1Tsx0c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3ad543-6732-4712-2d41-08dca80ce1be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 16:07:26.2464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWN29oJhpQ+2RFWi3oS1Yx3CwdJ+J3+V1PbtCPdHAdw7MuBPsbokL3roAPAOg1kcMupPJvRqvb1umTqIFaAjHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690


On 7/19/24 16:47, Dave Jiang wrote:
> On 7/18/24 11:31 PM, Alejandro Lucero Palau wrote:
>> On 7/18/24 22:32, Dave Jiang wrote:
> <snip>
>
>>>    /*
>>>     * Per CXL 3.0 Section 8.2.8.4.5.1
>>>     */
>>> @@ -438,6 +403,7 @@ struct cxl_dev_state {
>>>        struct resource ram_res;
>>>        u64 serial;
>>>        enum cxl_devtype type;
>>> +    struct cxl_mailbox cxl_mbox;
>>>    };
>>>    
>>
>> Being a mailbox an optional capability for Type2, not sure it should be here. Maybe it should but as a pointer for dynamically creating the struct if needed.
>>
>>
> Yes.... Which actually also ties in with your Type2 work. I talked to Dan last night while looking at your patch where the a software cap mask gets passed in for mailbox and HDM enumeration. The conclusion was that we need to refactor the code to deal with the optional component enumeration. For mailbox, it needs to be independent of memdev device state and the enumeration needs to be split out. I'm going to try to take a crack at it, unless you want to do it. :)
>

That sounds good. I think your work with current mailbox needs gives you 
a better position than mine, but happy to help/discuss/review. An happy 
to know my concerns about current core struct not unfounded.

