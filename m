Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E84EC5
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652914; cv=fail; b=osZAubObzSbEV3gZAyOnAtxop42/MZfuqBU7dpX8NwyjyMI+nVPy1aK9TANFl5pKG7ipgL1B5TJca/7+SBvjLsyiDnnOzbr6FGmHpeEAgv3hJKbIUyqqD75Hye+0DU3DJaSt7kvPaUWHy3O9UYpQMg9mp0dsR2y1oX+4ibgOt9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652914; c=relaxed/simple;
	bh=v9RIaewg+TbaW9lrjoYNWGsz4ty7EpRoZ1kDn5a9l5k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mmE9+l73uEm0zvWC/zC1RFenojV1Id+bAwQCyb0MdVtEiAFNc3gaKlxcKAO5YMm32MKVPmW9ZCbqioWbsvLhX1WF6KxzObbP3tt2gZd91mlE5I4NhvKm9ak8q8dtTp4muiZ403rWURLp9TZg0vrsmVi5sZtgZu2WBaBarBcWVpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UrYrmxjw; arc=fail smtp.client-ip=40.107.96.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UrYrmxjw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5+Nou0Yl36XmvbcbQ8gzD1HDItQeJ3Lt/6rRrSM+O51D7MvWfx93H1UDgvC0/2TK7N09EzIkzf4eQJHhrti5YBEdqHu9PC4T9tRiznM6YVTE42Kg/CioAYRswrjEeZVfPpJnZcryAWC9CulrqdwzK1sttbW9hH5LtW+ISR2/v7b/lF7EBHqS05T17xljN7HZJvge/IhUY/WDlag2FwWRu9IpWTg/QKsnnYfYEUhcwJpGonTTD5JdbiemielqAv0wNWNfRy5vY+ZbtURLcmjIDiRehma/nJjXr5eFDdgga6lOGY/WrZ5Gw5s/Whk8MtqcS/ApARg51hGy3wAwGd/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6das/NbceAhWAKqGI49fEk+WYstDX8oqbdE3wcdyLjs=;
 b=bccLkYkwU+7ZMW6oBrviAqC9aTZM7tle3XkjgLwbQOVn5AHU2Chl7Oqj1F9CPTI8TY6BebC38uX++8AfevVW8l5jLnIPrBRBEDnnMSqVnG772jJaLQKOMmMObWd8KAoAytqHJAhx3lTnwlpOHbO+wbGfoFM7FI+ZHBU4EY2AUPvejP7mU/0kzsXynUln5WmqtcPt/liH/a1MFoN2tYcXhGfiNpvdFTygya4QFiaq3asDNUwYGCpHcQ3dQ6tkLa/f+/t8aRDSLeHYfXh7isqmw29t/4Iu2reDywL2WzHXUk1b8dZYOcPRnT1FqZN/xe70OCHHf2Z181Y0Qim+u3/RzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6das/NbceAhWAKqGI49fEk+WYstDX8oqbdE3wcdyLjs=;
 b=UrYrmxjwqRx6LolhQzIm1xb36XEc8PXToW2ANWxi80DbUm4+32y8b+cyMskcsdPiGWIwaOtepVQPYnsZme2ub36mUfvOqyck2avueAxXulxFlQQpsTN1iVsNK7vorBusymG0i5+uwS4UPtYEfov0TdLIVEMRU9Ae2Fc6GvuHvmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Thu, 23 Jan
 2025 17:21:48 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 17:21:48 +0000
Message-ID: <0e4838b9-f4c5-3ace-a45b-9c02a7795a49@amd.com>
Date: Thu, 23 Jan 2025 17:21:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/5] cxl: Make cxl_dpa_alloc() DPA partition number
 agnostic
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan.Cameron@huawei.com
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753637297.3849855.5217976225600372473.stgit@dwillia2-xfh.jf.intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <173753637297.3849855.5217976225600372473.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0351.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de01418-dab6-4ebc-c2f4-08dd3bd26afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUJaRlhXdlRRVmdOZks3Q1VYRzE4LzBGL3JCOFpHWks4M25PYU5aODR2RXZt?=
 =?utf-8?B?RHQzNVE5UkM4NUxmOUdUSWkwME1hQkpEN29SRnFsS0FFSWFmMGhQbzJlUzho?=
 =?utf-8?B?Y0FKcW9GanZITllMWmhJZVBXUWc2YTdaYmhna1BDdTZhNzBaUnJqSXVPOTBE?=
 =?utf-8?B?WFdhdzZVRW5SOCs0R3J4Mm96dUxLMkpoSnpSbWZVazd4MzBJVk82TGNvZmcx?=
 =?utf-8?B?UUhMcmNCLzhOOG9hZjZHK3VzaWNmN0xpVmtUZDY0eVU1bTZDakpKMS9oUEtS?=
 =?utf-8?B?N0x3aFB6VmV1amhibTF6cGtyelFmZisyY0hpM2pXbXhXTEFsMmZJS3R6SUJK?=
 =?utf-8?B?Ly95T0FRUVBMd2d4WU9WZjdqbEFlRmFVdDJwMkxOWmR4eVFTeG5rOGIxS1BP?=
 =?utf-8?B?Z1JNckg5NXVuMEhkV3VNWWdCSC9zYW5pVXg4b3J2QW5mdEVOUkswRDZWTDlk?=
 =?utf-8?B?YVF3MU1FZ3lYYncwbjhld29RQmhTMjVDd2lMcER1dUpnZC9qR2pSRW5BbE9n?=
 =?utf-8?B?bHExeStTbVFJVVlBQ3k2UTBNU0R4UHFrbTNBQVZ3aHZKVElxdWhjRHFKcEFv?=
 =?utf-8?B?ZElaN1E2bnVTTHlNMjN1Q3NPL1YzUGl0alFaaGxmb3cyUFk0OFFPTUpmbWph?=
 =?utf-8?B?VWRKc2VRcEJKR2QycjJsaVo2dTdBVC95MWFrbXgxbStiM0hwamlJWlg0eEtR?=
 =?utf-8?B?ODJxRUlmQU1SNGpVQTZGZkNzMkFrZUhuWTkrekF6a3BId08vdHF4UDdVNTFo?=
 =?utf-8?B?VHYyRkk1NS8xVXpZdlpkSWc0ZlBSTzc3R2FIL3pObVE2bXhiVHVRUXV3NVFU?=
 =?utf-8?B?Um1SWWNaMXFXcDZuUTlreTBkanZPTHpiRklsaGZvTFFSa1FGME1jTEdTbWdB?=
 =?utf-8?B?OTF3VXgvTmcwWSsydGRlNlJlZ0lDSXpuVEJFNWl6Q1BGTXFTOVFWT0o1WTdr?=
 =?utf-8?B?c1h2MTFMNVZUZnJ4blI1cUhPRVVDSXhTZjd6WUwwV0l1RkxReHpNUlMyVTht?=
 =?utf-8?B?SXlaNytzc0IrTGd4N2tZVC82eXlXb2JUdnI3dHAvcG5MSEs1TjgraHZoQWdr?=
 =?utf-8?B?M0MrNEVheVh2YzV2L1N4SzZ2VWxFOTRKWnRmczlhR1dOT0J5eEM3c1ZzSitW?=
 =?utf-8?B?cERYMnBwbTY0aXZrMUkyMmkrNHBSbTM5bU1URzNRODJhWXFpRWtkUENzK0Rl?=
 =?utf-8?B?cVZTTjNGR1doeEo2ZGNLTjBRT21NMW9VaENJUTBldkdKZWdxeHF2Y2o4b3ha?=
 =?utf-8?B?THc2UGViV0ExM0c5N2w0a3A5aUVvY1ZmZHR3YzB2VDA3encwUm1sMFFXdjVv?=
 =?utf-8?B?dm83YklTYU41UXltRHRWL243azR6RzdLR3JqUVc3WnJQem1sQlhKS3dSd2E2?=
 =?utf-8?B?emhQVVZwclYrUU1Ga3VzRllUeStSUEVmdHUyN2t5R09HSTVINkRiZkp2K1Mv?=
 =?utf-8?B?S0JLdlV5UVBWMm9iR0JycUNSUE84bDNWUEF5SjhYSWJxdDk4OTVRYkYyTWlW?=
 =?utf-8?B?cmc3R0c5cHU5bStDZHJSd1FDNXFseXFvWEpNOVZ4SWRxS0srSDhTamM5MVlq?=
 =?utf-8?B?WTJER3krSVZtOVpmb2hDM3M2dlFETi9XSXpOLy9zS2RONXRqRm5KOHc5eXpK?=
 =?utf-8?B?TkYwb0x1NU0zVDFQbmNKSDdza25zeDBNYWlTc3IwTFU5RXRka01BcXNzN1FZ?=
 =?utf-8?B?c2xkelZmRm8wZWl2K1NRQ3lDcHBEcjF1ODRzd2JYemVWbnlobktmQzY1b241?=
 =?utf-8?B?bVJQKzZPeTh6QWsyYXBGaG8rb1hWMnNubXlrMVdvQkdrOEQzNWQvaldJdUZD?=
 =?utf-8?B?Q01jelJtekFtSmpYcFNyN2FXeWhvM0RaTExURFA1MTdrMEp0aGJMR3p5empS?=
 =?utf-8?Q?CzEUsy/UOJXfv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHNCVWpCTTYyZ3RVN2dMMHZqdEhmTHlNRk5rVk1pUWNMSnUrTXkrVTJqQjcy?=
 =?utf-8?B?T2RpR0ROeGcyUFlUc3NRZUlFWkF1aWNGRDlrSjA2TjZScDNBNVNpVUtBQ21i?=
 =?utf-8?B?SDhlbVNQSlZ3SXExMTFjUnNsZGMwbGlOVU1vaWJaNHY4RzZxWTRkbFhhUXBD?=
 =?utf-8?B?RUp1di9Eb1RZcEk5dzdmTUVrT2VhV2VRcU5Oa1dVYm94Rko1a0JUNU9yS2Zn?=
 =?utf-8?B?Y1JHZUdoNnBEL0NxL1lRQlFvMFVZcm1tTW9sT3docWZOek42MDNJcnhxMGdj?=
 =?utf-8?B?cTkxdnNZY1NCb1llVlR1WnJoRUE1ZTFCOFdYdkQ1UElORkt2T3M1am5IRXQ0?=
 =?utf-8?B?YUFnNndVcmVPcHpmZDQwZEgzaHJBZ3ZBRDBVWmUvYnROaitWQVFLNDZqU3Vl?=
 =?utf-8?B?dXJHZlJRaFRIODVEQ3l3VTdEQ1laMHUwUUpScjd5bFFjcFR4Ui85MjA4cWdN?=
 =?utf-8?B?cFFxSGVORlRFT0d2bUNsSXhDK0RJNjEyM0NCeEZvRDN4V3lZakFrWjFJV1FK?=
 =?utf-8?B?UjhSZyt4VkpGQTVRbUVTeTN4d2xacVlweDJHYkhlR2NvTjVUekxpQ0EyTGdN?=
 =?utf-8?B?SG9MYmtwcm1iTmF5Vm9wbzI5SHpRUC9hazNWQXlhcHhkK0RhOVVJM3hydkpN?=
 =?utf-8?B?eHhaYkJhcHY2ZHdHN3hVQ285SUsrVzR5UDNleEJIc0g3Sk9PS3VzcTRlWGtE?=
 =?utf-8?B?M0JQUTZubHF5NVNtb2dhRWpDQWVRUEZqeE9oK3FLQnB1dzg1dEg1UGp1RVVj?=
 =?utf-8?B?M1AxaURROW5MSU41MEtJZ0MrTXZ5TmE1eGJDaEpVcUN6R2tab2hJckZOS3BU?=
 =?utf-8?B?ZWd2ZmlnTUFCTGNsb01YSFJObjJoU3B6VGpwMWdzVE02Snl6VERnK0kxaGJy?=
 =?utf-8?B?TS9WWTZkL2tBUDVsRDJRUkR5U3FUYzQ3ODVxNTc0WHNReTRQa0RIVWgzSW92?=
 =?utf-8?B?ekZHZlBQWVprcVJzUGM4YkNwaEZzS04vamgwMGNzRXVJU2R5d1NGNjYzeWIr?=
 =?utf-8?B?aWtURlpRd3BBbWtZQ08rTnZ6ZVRRQ0VvRUhJbmtDN0dMWWc0dWwwWldpdWli?=
 =?utf-8?B?RmZDY0RQOW5Id3N0Y3ZGeGNQazdCcHFGakM0UDZoaGI3Mi9ZMkVCUzNEV2lN?=
 =?utf-8?B?d2hKYTdibWpWODQveFE0ZWlaV2U0NlBXckd0U2JHaEJqcWZwTXlRQ09qU0lm?=
 =?utf-8?B?Ym16ck5GNEMzeHZDaG9RNUp5S1g2bUtveERSMklBTkYrdUlXYVJKc2U0VDVp?=
 =?utf-8?B?WnErOEFFVHJsMDh4eWNXUkRlYkJCcnB6YXJEaDZnUi9qKzdjOUNPeXJmbkFh?=
 =?utf-8?B?T2g2QkZudTE0U0tiYTYrRFJLU2dQa3FvaUhiaWpUNUdSc211cDZvUmxuQlJl?=
 =?utf-8?B?aXU0Q2N1enEyQThYSXlIUTR2SzdEc3ZqYnl1RzhQeFVVVHJZWVZLRlErTDF2?=
 =?utf-8?B?Y2lGalFHcklLQUh4RVpKUThOWklqNS9WbmNDc0t5ZFZrYzcweE5WdFNUaG1J?=
 =?utf-8?B?YzZDNHI2bDhhWnk2SW1wRFJ5UXpUTkw1VlZBSklRckhqV1hUdWZGeGI3V3Y2?=
 =?utf-8?B?MFI4YnJxLzBTcVFTa2lUa1RUb2pmNGRyWWZtSXdpSitQWmMzTnNVdnRZNUFS?=
 =?utf-8?B?ZElhNkVldUs3N2dVMHBraWdzTGhQZ1ZTZkdiaG1BdGYya3c2NTZkV0VVR1cx?=
 =?utf-8?B?SEw3cWp4RHllQWFvUXR1aE01LzdDQzJvN1o1dVVKQnJPbVhFNUFmM2RNQ3F0?=
 =?utf-8?B?a0VaQUNJL2QzYktIeDcrM2FPUWFtWU9kdWdESm5RNFpSTk8xbm5UcXFZL2I2?=
 =?utf-8?B?ZzFlQW0rWkxKQTJwK1J1VjlDSVpIVUNVQ2o4eGltUkF5OElnV0hFZ1BHWCt1?=
 =?utf-8?B?Q1NTd0I1RHZMSWtKRmhyZ2RQcDZNQ2tDVHNvSHRJM3FpdWxHM05Bdy9XL2g5?=
 =?utf-8?B?Qy9PSGJFRmRvL3BrYnRTRHllM0ZpYnREMmd5RkFFUXFoR0pxbEFrRXJRdHov?=
 =?utf-8?B?ZmRrc3dxSTNSdmUyRlg0TklEOEVhNFRRUDZ3QVkwTWVGMVJzTk9teDlCL1VB?=
 =?utf-8?B?eWlzVm1DNC9uWjU4QnRYNlloUGpMMWVLcnpoSkh0bUFwWXFrWmpqWlhZM24z?=
 =?utf-8?Q?AwsgT/SpY5ZLbj0B46P6dIhRp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de01418-dab6-4ebc-c2f4-08dd3bd26afa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 17:21:48.1654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7KAOevgT7FCi+g447RAuQviHmlhmXWlqud4S3zZ6n8nu1UIjAKnlL4wZ4ZGE3p4LPnwt1Ip9b2spu8EtcjoPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939


On 1/22/25 08:59, Dan Williams wrote:
> cxl_dpa_alloc() is a hard coded nest of assumptions around PMEM
> allocations being distinct from RAM allocations in specific ways when in
> practice the allocation rules are only relative to DPA partition index.
>
> The rules for cxl_dpa_alloc() are:
>
> - allocations can only come from 1 partition
>
> - if allocating at partition-index-N, all free space in partitions less
>    than partition-index-N must be skipped over
>
> Use the new 'struct cxl_dpa_partition' array to support allocation with
> an arbitrary number of DPA partitions on the device.
>
> A follow-on patch can go further to cleanup 'enum cxl_decoder_mode'
> concept and supersede it with looking up the memory properties from
> partition metadata. Until then cxl_part_mode() temporarily bridges code
> that looks up partitions by @cxled->mode.
>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>


Reviewed-by: Alejandro Lucero <alucerop@amd.com>


> ---
>   drivers/cxl/core/hdm.c |  215 +++++++++++++++++++++++++++++++++++-------------
>   drivers/cxl/cxlmem.h   |   14 +++
>   2 files changed, 172 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 3f8a54ca4624..591aeb26c9e1 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -223,6 +223,31 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, "CXL");
>   
> +/* See request_skip() kernel-doc */
> +static void release_skip(struct cxl_dev_state *cxlds,
> +			 const resource_size_t skip_base,
> +			 const resource_size_t skip_len)
> +{
> +	resource_size_t skip_start = skip_base, skip_rem = skip_len;
> +
> +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> +		const struct resource *part_res = &cxlds->part[i].res;
> +		resource_size_t skip_end, skip_size;
> +
> +		if (skip_start < part_res->start || skip_start > part_res->end)
> +			continue;
> +
> +		skip_end = min(part_res->end, skip_start + skip_rem - 1);
> +		skip_size = skip_end - skip_start + 1;
> +		__release_region(&cxlds->dpa_res, skip_start, skip_size);
> +		skip_start += skip_size;
> +		skip_rem -= skip_size;
> +
> +		if (!skip_rem)
> +			break;
> +	}
> +}
> +
>   /*
>    * Must be called in a context that synchronizes against this decoder's
>    * port ->remove() callback (like an endpoint decoder sysfs attribute)
> @@ -241,7 +266,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>   	skip_start = res->start - cxled->skip;
>   	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
>   	if (cxled->skip)
> -		__release_region(&cxlds->dpa_res, skip_start, cxled->skip);
> +		release_skip(cxlds, skip_start, cxled->skip);
>   	cxled->skip = 0;
>   	cxled->dpa_res = NULL;
>   	put_device(&cxled->cxld.dev);
> @@ -268,6 +293,79 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>   	__cxl_dpa_release(cxled);
>   }
>   
> +/**
> + * request_skip() - Track DPA 'skip' in @cxlds->dpa_res resource tree
> + * @cxlds: CXL.mem device context that parents @cxled
> + * @cxled: Endpoint decoder establishing new allocation that skips lower DPA
> + * @skip_base: DPA < start of new DPA allocation (DPAnew)
> + * @skip_len: @skip_base + @skip_len == DPAnew
> + *
> + * DPA 'skip' arises from out-of-sequence DPA allocation events relative
> + * to free capacity across multiple partitions. It is a wasteful event
> + * as usable DPA gets thrown away, but if a deployment has, for example,
> + * a dual RAM+PMEM device, wants to use PMEM, and has unallocated RAM
> + * DPA, the free RAM DPA must be sacrificed to start allocating PMEM.
> + * See third "Implementation Note" in CXL 3.1 8.2.4.19.13 "Decoder
> + * Protection" for more details.
> + *
> + * A 'skip' always covers the last allocated DPA in a previous partition
> + * to the start of the current partition to allocate.  Allocations never
> + * start in the middle of a partition, and allocations are always
> + * de-allocated in reverse order (see cxl_dpa_free(), or natural devm
> + * unwind order from forced in-order allocation).
> + *
> + * If @cxlds->nr_partitions was guaranteed to be <= 2 then the 'skip'
> + * would always be contained to a single partition. Given
> + * @cxlds->nr_partitions may be > 2 it results in cases where the 'skip'
> + * might span "tail capacity of partition[0], all of partition[1], ...,
> + * all of partition[N-1]" to support allocating from partition[N]. That
> + * in turn interacts with the partition 'struct resource' boundaries
> + * within @cxlds->dpa_res whereby 'skip' requests need to be divided by
> + * partition. I.e. this is a quirk of using a 'struct resource' tree to
> + * detect range conflicts while also tracking partition boundaries in
> + * @cxlds->dpa_res.
> + */
> +static int request_skip(struct cxl_dev_state *cxlds,
> +			struct cxl_endpoint_decoder *cxled,
> +			const resource_size_t skip_base,
> +			const resource_size_t skip_len)
> +{
> +	resource_size_t skip_start = skip_base, skip_rem = skip_len;
> +
> +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> +		const struct resource *part_res = &cxlds->part[i].res;
> +		struct cxl_port *port = cxled_to_port(cxled);
> +		resource_size_t skip_end, skip_size;
> +		struct resource *res;
> +
> +		if (skip_start < part_res->start || skip_start > part_res->end)
> +			continue;
> +
> +		skip_end = min(part_res->end, skip_start + skip_rem - 1);
> +		skip_size = skip_end - skip_start + 1;
> +
> +		res = __request_region(&cxlds->dpa_res, skip_start, skip_size,
> +				       dev_name(&cxled->cxld.dev), 0);
> +		if (!res) {
> +			dev_dbg(cxlds->dev,
> +				"decoder%d.%d: failed to reserve skipped space\n",
> +				port->id, cxled->cxld.id);
> +			break;
> +		}
> +		skip_start += skip_size;
> +		skip_rem -= skip_size;
> +		if (!skip_rem)
> +			break;
> +	}
> +
> +	if (skip_rem == 0)
> +		return 0;
> +
> +	release_skip(cxlds, skip_base, skip_len - skip_rem);
> +
> +	return -EBUSY;
> +}
> +
>   static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>   			     resource_size_t base, resource_size_t len,
>   			     resource_size_t skipped)
> @@ -276,7 +374,9 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>   	struct cxl_port *port = cxled_to_port(cxled);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct device *dev = &port->dev;
> +	enum cxl_decoder_mode mode;
>   	struct resource *res;
> +	int rc;
>   
>   	lockdep_assert_held_write(&cxl_dpa_rwsem);
>   
> @@ -305,14 +405,9 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>   	}
>   
>   	if (skipped) {
> -		res = __request_region(&cxlds->dpa_res, base - skipped, skipped,
> -				       dev_name(&cxled->cxld.dev), 0);
> -		if (!res) {
> -			dev_dbg(dev,
> -				"decoder%d.%d: failed to reserve skipped space\n",
> -				port->id, cxled->cxld.id);
> -			return -EBUSY;
> -		}
> +		rc = request_skip(cxlds, cxled, base - skipped, skipped);
> +		if (rc)
> +			return rc;
>   	}
>   	res = __request_region(&cxlds->dpa_res, base, len,
>   			       dev_name(&cxled->cxld.dev), 0);
> @@ -320,22 +415,23 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>   		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
>   			port->id, cxled->cxld.id);
>   		if (skipped)
> -			__release_region(&cxlds->dpa_res, base - skipped,
> -					 skipped);
> +			release_skip(cxlds, base - skipped, skipped);
>   		return -EBUSY;
>   	}
>   	cxled->dpa_res = res;
>   	cxled->skip = skipped;
>   
> -	if (to_pmem_res(cxlds) && resource_contains(to_pmem_res(cxlds), res))
> -		cxled->mode = CXL_DECODER_PMEM;
> -	else if (to_ram_res(cxlds) && resource_contains(to_ram_res(cxlds), res))
> -		cxled->mode = CXL_DECODER_RAM;
> -	else {
> +	mode = CXL_DECODER_NONE;
> +	for (int i = 0; cxlds->nr_partitions; i++)
> +		if (resource_contains(&cxlds->part[i].res, res)) {
> +			mode = cxl_part_mode(cxlds->part[i].mode);
> +			break;
> +		}
> +
> +	if (mode == CXL_DECODER_NONE)
>   		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
>   			 port->id, cxled->cxld.id, res);
> -		cxled->mode = CXL_DECODER_NONE;
> -	}
> +	cxled->mode = mode;
>   
>   	port->hdm_end++;
>   	get_device(&cxled->cxld.dev);
> @@ -529,15 +625,13 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>   int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>   {
>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	resource_size_t free_ram_start, free_pmem_start;
>   	struct cxl_port *port = cxled_to_port(cxled);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct device *dev = &cxled->cxld.dev;
> -	resource_size_t start, avail, skip;
> +	struct resource *res, *prev = NULL;
> +	resource_size_t start, avail, skip, skip_start;
>   	struct resource *p, *last;
> -	const struct resource *ram_res = to_ram_res(cxlds);
> -	const struct resource *pmem_res = to_pmem_res(cxlds);
> -	int rc;
> +	int part, rc;
>   
>   	down_write(&cxl_dpa_rwsem);
>   	if (cxled->cxld.region) {
> @@ -553,47 +647,54 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>   		goto out;
>   	}
>   
> -	for (p = ram_res->child, last = NULL; p; p = p->sibling)
> -		last = p;
> -	if (last)
> -		free_ram_start = last->end + 1;
> -	else
> -		free_ram_start = ram_res->start;
> +	part = -1;
> +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> +		if (cxled->mode == cxl_part_mode(cxlds->part[i].mode)) {
> +			part = i;
> +			break;
> +		}
> +	}
>   
> -	for (p = pmem_res->child, last = NULL; p; p = p->sibling)
> +	if (part < 0) {
> +		dev_dbg(dev, "partition %d not found\n", part);
> +		rc = -EBUSY;
> +		goto out;
> +	}
> +
> +	res = &cxlds->part[part].res;
> +	for (p = res->child, last = NULL; p; p = p->sibling)
>   		last = p;
>   	if (last)
> -		free_pmem_start = last->end + 1;
> +		start = last->end + 1;
>   	else
> -		free_pmem_start = pmem_res->start;
> -
> -	if (cxled->mode == CXL_DECODER_RAM) {
> -		start = free_ram_start;
> -		avail = ram_res->end - start + 1;
> -		skip = 0;
> -	} else if (cxled->mode == CXL_DECODER_PMEM) {
> -		resource_size_t skip_start, skip_end;
> +		start = res->start;
>   
> -		start = free_pmem_start;
> -		avail = pmem_res->end - start + 1;
> -		skip_start = free_ram_start;
> -
> -		/*
> -		 * If some pmem is already allocated, then that allocation
> -		 * already handled the skip.
> -		 */
> -		if (pmem_res->child &&
> -		    skip_start == pmem_res->child->start)
> -			skip_end = skip_start - 1;
> -		else
> -			skip_end = start - 1;
> -		skip = skip_end - skip_start + 1;
> -	} else {
> -		dev_dbg(dev, "mode not set\n");
> -		rc = -EINVAL;
> -		goto out;
> +	/*
> +	 * To allocate at partition N, a skip needs to be calculated for all
> +	 * unallocated space at lower partitions indices.
> +	 *
> +	 * If a partition has any allocations, the search can end because a
> +	 * previous cxl_dpa_alloc() invocation is assumed to have accounted for
> +	 * all previous partitions.
> +	 */
> +	skip_start = CXL_RESOURCE_NONE;
> +	for (int i = part; i; i--) {
> +		prev = &cxlds->part[i - 1].res;
> +		for (p = prev->child, last = NULL; p; p = p->sibling)
> +			last = p;
> +		if (last) {
> +			skip_start = last->end + 1;
> +			break;
> +		}
> +		skip_start = prev->start;
>   	}
>   
> +	avail = res->end - start + 1;
> +	if (skip_start == CXL_RESOURCE_NONE)
> +		skip = 0;
> +	else
> +		skip = res->start - skip_start;
> +
>   	if (size > avail) {
>   		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
>   			cxl_decoder_mode_name(cxled->mode), &avail);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 15f549afab7c..bad99456e901 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -530,6 +530,20 @@ static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
>   	return resource_size(res);
>   }
>   
> +/*
> + * Translate the operational mode of memory capacity with the
> + * operational mode of a decoder
> + * TODO: kill 'enum cxl_decoder_mode' to obviate this helper
> + */
> +static inline enum cxl_decoder_mode cxl_part_mode(enum cxl_partition_mode mode)
> +{
> +	if (mode == CXL_PARTMODE_RAM)
> +		return CXL_DECODER_RAM;
> +	if (mode == CXL_PARTMODE_PMEM)
> +		return CXL_DECODER_PMEM;
> +	return CXL_DECODER_NONE;
> +}
> +
>   static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>   {
>   	return dev_get_drvdata(cxl_mbox->host);
>
