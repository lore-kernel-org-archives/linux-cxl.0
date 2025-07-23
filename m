Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A832586CE
	for <linux-cxl@vger.kernel.org>; Wed, 23 Jul 2025 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753306568; cv=fail; b=bUAcPkwelQl0boyS46zZmdZxzIpFJ+PXPZDdZEmWDn6Tw0LB8tNpLlgo3oLXrJdskmq/wqfC5dOMfKjeDDkhZgCuXLFnx/25Vn7YwDNzlCYdaF2ZYo+pkjI/yYSvOpKsKdNJvq+1YOIpyX3QY7SdTAj0L6E8PkaPymk5g3KWxGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753306568; c=relaxed/simple;
	bh=5WhC6EOVKeJweSNGQofZnuBxhvXkgZm9JBDfWO3uzVk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GnFCeOIfTlx6RK7qme7UvrpP4FF2ZmQC6cy8wE2o1gZVeALO1Xlnwb7ot10x+VBfBAWVCGKDjx++wZjSv25RPh1s6p6pfe7PuslF+1wtYOzuWSt8JhGumCPKq/gMDGPujuQ4YyTyRnwapUOSr5Zaqf1cT6KpSqlRt2af8uv8nmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k46D8BB0; arc=fail smtp.client-ip=40.107.95.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k46D8BB0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOYVajTs15PRju4b/tkxbtZlAOLT9XYXwUr7LIwi83b/V/kDVjfAS7FOorMLszXFmP4IxQ8wRvB6mzAbOdwW2euDUEiV2NMpAPw76wtpSqUbfJpRAq3Ja83Ku/59B8NE1lkdldLdnUX+zNVzkExiVjwEsM20td9Tl6qGmtTU5WiOgaLDmqO2a0AFbdCh+/Zh20ZodCgw+ibP+1CwKUDWgKqsHPsY1H+g+MzWl5F3XKbdw6esnFS4v7xwdkFREWYeBXRrr+3f+j2janmwC0lqKst0bEXh0J60uyftPXIUl0HeMVTklv8Beq1N56usWLtcvmyTh+yXzkQrFaOIqa8EfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kD2HmiOP+ctqaK5veecS+2RHBAFE9rCe5F/XH5cXmrU=;
 b=V2TXWScCDrBEYu5MGSIoW//uwyyNPFsqXpIZmxQnU6kBLKjcmfsugGK4cSBRoIJD3SAQqH9LkNANOKNpUXsVCBGKTG6Tc1wlnYsBd+qfMwVGMu2rIYtT5j2Ovb7h9qPlHeGFjx3br8ipOtiqALX4mM9D3pJDXAfeNowxe64Mz/ok8CKI49S3zigJoJzAlPMnMeu5+jaFjGsc5MZQv3YE2K/RdJ5y7lo/2clwZwZ530w3R01E0CNztDnHl8bxfCAaFZnSJmdklGn5HNSpv3qkxZ0ccIoP0/OFVXzCmdIhFDQmhHyOP2KB8bvPn0MVBjK2IB6G/AVh5dwI3oikIVpmug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kD2HmiOP+ctqaK5veecS+2RHBAFE9rCe5F/XH5cXmrU=;
 b=k46D8BB0BHVgX3qIFI9AK6N2sh+7t5kdQwL5vqfG1j6+0ycSdE1wm2d7BpIyAEV2S7w7plTGvND5yKAToeq4rHjkcjPOTacBw3/XcTtjQFKQfcW0ipDPmtFKTVq/NSvMXaFx9fsZlNTkLytHQgckNAjgRh9PtWuISyhZHHiVN0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 21:36:02 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8964.021; Wed, 23 Jul 2025
 21:36:02 +0000
Message-ID: <2ec323cd-0c20-4ab8-93fe-58373f2c7a54@amd.com>
Date: Wed, 23 Jul 2025 16:35:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from
 core/pci.c
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, Robert Richter <rrichter@amd.com>
References: <20250721170415.285961-1-dave.jiang@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250721170415.285961-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0034.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::7) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd36957-7226-44da-25f6-08ddca30ebbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFR6ZmRlcVJCSCtGQnJBdkxEMWRiZzc2UnZoS29vYy9Ubll5T3lXbXJiWkp0?=
 =?utf-8?B?Y05iWStnTHU4cFNCN3RUTldYMWEraVkrMkxtYTc1UnVGbW0zR3Q1K2RFZ2Nj?=
 =?utf-8?B?TTFrbnBmVDc1dkxBMFJFcDhSNG5lWVN0QUlwUmZhck5TTHJtbEUrZU05U0g2?=
 =?utf-8?B?OUdaeUVVUk9ML0YwRVAzZXZTS0p5UDRON3hHcTdXWFl0NmZUZW45cm1hUnEr?=
 =?utf-8?B?dWJ4dG1DV05nWk5VK21naUYxN0s1QzdVdmVrT2l3K2VTWkM1YitGMFp3WU44?=
 =?utf-8?B?dlpaa1prdWhGSzdKSGhkQ2t0MEltS2V4bWpiL0NER2ZTKzdmOXpPejY0bUdM?=
 =?utf-8?B?Snd3YS9PbVlPTnFUeHg3MExFUGdKdEFMNWJscFkvdEFmR1pUREt5WFl0Q21F?=
 =?utf-8?B?TFZOQ0xoc0ZMek83SDhHRlR4emhUN2NPclEwcGJTcU1JUXJBZkZnL2xFTGlQ?=
 =?utf-8?B?SS83eVJDZHYyQ1gwdGhzSG01YWRaa3dSYXhtZE9EYklLQ2VrOWlXTUlMVDh4?=
 =?utf-8?B?QkhXNFlnWHlVdTNSaFF0bmRTQTFsWnF0SjVYbXJWYUFZeFdzM3daN0JGNHpI?=
 =?utf-8?B?TEE5SVhiY0NwMU45SlVVby9uWS9pa2RFTDh6bnlGRFp4clZ4cXpLV2I4a1Rx?=
 =?utf-8?B?c1RDT2t0TmNyYmRPWUZjUFhvd3JPTDBLdG15aXpkS0tjNnRMV1I4OGtxVXdN?=
 =?utf-8?B?L0JCd1RkZXVDaUpHSVg0c3o4OVE5cjBLZzk0dE94VHNIK05USnR3QzhIaDdS?=
 =?utf-8?B?bUpMYWFjOU5IaWx6ZlZkSDZ6VjBkaVc2dkxhUHR2OXJPZlU1c0F5RlRGbERE?=
 =?utf-8?B?ZlJ3bUozVmp2ZHYydVhmM25YeXZyczc2cWJuWkF0WkFhNlFlOFY1WDc3MkNH?=
 =?utf-8?B?Y0hwR2kzWFVGOUJLa2dLV0t4aHVISkNicXZJYnRVR01uNUhOTk1PL3NsREMv?=
 =?utf-8?B?UzFQNW10MlUyUU5HdTlrQXRMRmhGUWM4eDdsYURUWUZZeCtPSjdWMytLU3BG?=
 =?utf-8?B?V0JNb0hNdDR5cEJTMElHTW1OMzBwR2hSNDQ0bENNM0p6SjZQcWxRZVRJY1dI?=
 =?utf-8?B?YVlEcnFqazgzRTFXZVEzcTBkODkyRGUvclpMMmROQVdvNnUrb3I2YlFCRlJo?=
 =?utf-8?B?dUkwcUkyU0dEbEorU2hoYzR1N01pVXRhaFdLWnZ5Nllpd2Fvbk9Qb1J5TWFT?=
 =?utf-8?B?OEtFVkhtdXdvd0g1Vy8wQkNVYVNkL3laS1BJK0NEODlYWk8rV1d3VDVWQ2RT?=
 =?utf-8?B?ZzNqN2VyN0ZXOWhyVVk0ZFczVlhON0twMll6cFQ4NExqbk91anBNLzRqdUlh?=
 =?utf-8?B?MmxSMTBCN2Jncm5OU082ZzZ5QllYeERPOXh5b0NSMTI1OVVlamhQZ0doeVR1?=
 =?utf-8?B?ZGx0YXNCUXM4eWY5cjhrWXhhODVXejlzelY3UWExYmRnRnd2TGl3SXBLdHZx?=
 =?utf-8?B?cUpPVlc0bG51OW9MYXVKNzNHYnd3TE5RZ2RudWFJbEhpSzBZUDlneDNSbEJC?=
 =?utf-8?B?L1I1OFo2UFVYTWREdGFLMFJlYWs3Zlk1OFI3R1ZuRFVwQ28vMW5uQ3dqMFNq?=
 =?utf-8?B?UDVOMmtLUHNKN3JyS0pMZlN0UEhxYUlVTXFCaGZvZEZmTmgyUnQ1bGFuOEh6?=
 =?utf-8?B?S3ZyT2lKSWVhVU1KakU2am9yUEJueGlHODVxcm4yOTlEUXJhNngxZEVzRjRF?=
 =?utf-8?B?a3cwNHZZdlIrZHJFWG9BMTM0d3o4WkNUNHJhUFlsY1puSFNidlc4S3Z6Kytm?=
 =?utf-8?B?U0RCL2lyYkJnWkFscDRRVlRSSzBGRGkxZ29RWVltT09IR0NRVWdYQ3drK2o0?=
 =?utf-8?B?NGRZNmhDa1UzRkU4WXFWTzh6QXRKUUNGdTV2KzVGQXRzQ3YyUlQ3TGIvV2Z4?=
 =?utf-8?B?R3NqMExJZU1CUGF5SlkwWmlGTFhHdnRUN3hUU1lGS2JZZEhpdXdFOTRPNVgr?=
 =?utf-8?Q?DfYQdAH134M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUF4OXBnaU9yVTFmK3NBckI1YjV1NE5STXJxaTQxRm14bnRiY2J4V3ZKWnBX?=
 =?utf-8?B?Nkd5SjF1bUwrTjBEVEFXWHJHQUpacjVuelJ3aDNiMjJ4ZnVNdjd3Yk1jNmd0?=
 =?utf-8?B?NjkySkVPSHZ3UTRDSitFeUNsVWpQcUhNNHJCZlFqSFdjVHZPb2xBUTRubGJS?=
 =?utf-8?B?ZStMTnpJMHFYVHlYeXJWUVNrTm1SbHBLeWdrYno4aDdmOVFBeGN6bVVTdlFO?=
 =?utf-8?B?Nmp4TDM2OXpRa1c2N2djVzJ2YXpWeGdsbFUrcVpEbUNjSUxBU2hLRFJRdU4y?=
 =?utf-8?B?dVJKbnc5VXBYbForQUpDVUlFY0FxMmpCNDBCZ0FGWUpmR1I0dEw1TnFQaVNZ?=
 =?utf-8?B?NFhBSC9Pa2x4OUZpaG9DVTRrVTdKVGloN2RmelpjWVlPUCtMdDZsSWw5TjR0?=
 =?utf-8?B?VEU3TkdkOW0yT0daamJsWVZmck1RcUdqR1cwcGlrVC9lc1U5NHNraFFBUHhw?=
 =?utf-8?B?ZW4rYm85bHFTZWhVT3B5eE9PVzJwakJ3WVY2M2Nlb0k2ZFlWV1hXUUhNTFV0?=
 =?utf-8?B?RzlUQlZmcCtLRldITkNGR0FZRkVRdWZxV3B1VXB5OUx2ZmZ2OHE0bUlPU1hz?=
 =?utf-8?B?TW85dkZSNWdOV2VBMnBKc3Ntc2JTcFB4cGdhcmRKNjYzSWJiSEdTbEFubU1W?=
 =?utf-8?B?NmFyRldQN2ZzS2hwczJ2NlFiR0t0OWdTVjRyNEpUYlU3aEFFc0U4ekV0NXhG?=
 =?utf-8?B?dGk1Sy9NYXV3VVV2U3JvTUd2VHUyQ1FZNm8wU3cwVUVCcDdDeWkzemVHUjhj?=
 =?utf-8?B?UEFQak9DRDRLRi9jeGJlbk5xNXhjQTJCeGhicFdzYng4UEVGQ1A1cHhNQzBZ?=
 =?utf-8?B?NUhjenZReXVyVEZuUlVFTUNxMnZZWm8zT1BCY3EvMzFUTExzSFVLcVRhYTVV?=
 =?utf-8?B?MUh4L3dzdjFMUVJXNlZDNS9pU2hwN1BidzczRk1jYS9hR092YkRBcXl6MmQ0?=
 =?utf-8?B?T3MzNTVMZlpTeUd2VW04V1VGS0NPTGlBVGhoVGZNRnBZb3MyaWwxanJXd0FM?=
 =?utf-8?B?MzJvUnY1aTczdDA1SGd3UkNvdDF3cVdxTnN5cmRxb0RaQWxZeitCT210K3VW?=
 =?utf-8?B?UmhFZzYra0M0SnMwQ1NlSTBvQWNBaFZ6bFliNHU0bDdHQnFuYjc1NUM5bS9i?=
 =?utf-8?B?RTNBTy9uWVdnM1k0VDZwOVRFZmNTUlU0Zyt3WlJMcEowbngyVHZMK1RoR3BQ?=
 =?utf-8?B?RytEYjVTTGZtRnRMQnM0MlpmTnJsNlVCZXUwdUUxeTJaZEN2VTZ0ekJpdG1Q?=
 =?utf-8?B?cHpIa2s0Q2o4eFMwK2c0VDUveUFMck4rK1pybzVJUlFQT1VuTWlUZlNhQUNC?=
 =?utf-8?B?b1NqMWVTU1ltZFZoQjA1cnEza2RLNnZpZkU3aWNmN2RSWDA2SEM3bHNqbDc2?=
 =?utf-8?B?bG5EdlhwWXdLd0p0clNPYTk4NDBOaXF1Y0luNWkwS1lIMWpveDhESUVORHhY?=
 =?utf-8?B?QVc0enJBMHhtYXZPWFBZeU0ybWpKTXdKVmVRZ1pDTjBBTSt2TklCZnQ5MnZs?=
 =?utf-8?B?MWQ1SEQzN2JoMlVoV0FOYVlQallOeFBuZ0czVjRQL0Q3WlZPSjc4V1l2UWhX?=
 =?utf-8?B?ZjlzczA0bFRoRWd5TVd1eXNNZzVCaWdxbnQxSzdSNG9xbjFUUGx2S0hKelJY?=
 =?utf-8?B?VjBzbEQ0dGxaT0FTY0ZINnNXNmFxTDh1aHhYbkViRnF6RUhpd0V5MXJQUmRs?=
 =?utf-8?B?cXRXQWp5QlZiMlZHUXQrT01UN0tiOXJsMmJ1aEV0SGNHK3B4T1I5SUZMQ2Rx?=
 =?utf-8?B?NHNYc0JjY3EwWXNIQ3NMUFhVRE10bzFPQUhqY3AxaXhrRlBOSXBkRkVYU2RT?=
 =?utf-8?B?MStVS2dTZlpOeWtBeTc4RnkyWXNHdWs0MjA5NWtWR3ZwNEJjMFhvME1mYW92?=
 =?utf-8?B?clBoem5iWkxZMXNTSWVoQWx5b096M29neDlId2FxdjhOMk4zUWtUcVNDRng1?=
 =?utf-8?B?ak0yQzlyOU5uSzBvT2J3bWJCcGlvN0dXTDdPTmhrU0hTUmtFYTNtWjRsOUp0?=
 =?utf-8?B?N28vTzJwYmxtYlhDMzk5aGkxQTBacHI3bUVyRStub2pnY29DUVNDTmNtbWRU?=
 =?utf-8?B?YS9OS2IvTldxd09kUkhvdzBQK3VaMjNPbFB4RWNwaS9GMTBnL2Z2cXl6c1Fm?=
 =?utf-8?Q?ZdlWzdOTQUzDoFqhlGzuDkmIn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd36957-7226-44da-25f6-08ddca30ebbf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 21:36:02.1201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vE1VhCaV0TYFhWFQkF7LhxlkCdiSgBba10uG7sjMote1c55AD+AXy400dYUnD3lFqtEVBbnH+KzPQz9A6svDCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751

On 7/21/2025 12:04 PM, Dave Jiang wrote:
> Remove from core/pci_aer.c and move the CONFIG_PCIEAER_CXL ifdef to
> cxlpci.h to deal with the exported symbols as needed. There is enough
> AER handling code (and more to come) to move the AER code to its own
> C file.
> 
> Cc: Robert Richter <rrichter@amd.com>
> Cc: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Address 0-day reprot of cxl_handle_rdport_errors symbol undefined
> ---
>  drivers/cxl/core/Makefile  |   1 +
>  drivers/cxl/core/core.h    |   9 ++
>  drivers/cxl/core/pci.c     | 171 +------------------------------------
>  drivers/cxl/core/pci_aer.c | 168 ++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h          |   8 --
>  drivers/cxl/cxlpci.h       |   8 ++
>  tools/testing/cxl/Kbuild   |   1 +
>  7 files changed, 189 insertions(+), 177 deletions(-)
>  create mode 100644 drivers/cxl/core/pci_aer.c
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 79e2ef81fde8..bcea856157af 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -21,3 +21,4 @@ cxl_core-$(CONFIG_CXL_REGION) += region.o
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
> +cxl_core-$(CONFIG_PCIEAER_CXL) += pci_aer.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 29b61828a847..96c319c66a48 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -136,4 +136,13 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		    u16 *return_code);
>  #endif
>  
> +#ifdef CONFIG_PCIEAER_CXL
> +void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
> +#else
> +static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) {}
> +#endif
> +
> +void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
> +bool __cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
> +
>  #endif /* __CXL_CORE_H__ */

Hi Dave,

Any reason not to pull in cxl_handle_cor_ras()/cxl_handle_ras() into pci_ras.c?
These 2 functions read the RAS from the register block and then call the trace routine.
These are only called by the handlers in pci.c. I think it might round-out your changes 
nicely if they are moved into pci_ras.c s.t. when CONFIG_PCIEAER_CXL is disabled then 
they are do nothing. Or another way to look at it is they should only be enabled if 
CONFIG_PCIEAER_CXL is enabled.

-Terry

[snip]

