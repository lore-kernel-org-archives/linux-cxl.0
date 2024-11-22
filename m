Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F934206E
	for <linux-cxl@vger.kernel.org>; Fri, 22 Nov 2024 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732265167; cv=fail; b=DKUOtDzx5hm2lzLSjEi1rO+F805ii8NbNKUy898ewQ4q/OqbzcFGt5O6GRIwkF+Krzx7UQwmwyT9nSYCNxfLe+2oNRAnKkKv4AbHnGS/SZBTljz2AFHbLm9CTBYRQRH1ehJAvpVawrTG0vA7rhb7luu6YUqOxSv1Rjj9Wb7WJfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732265167; c=relaxed/simple;
	bh=+oxPz4fnAYE8PDygqt+MmAbogHMU5NsAavxPW0Yxw1g=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sgx95mHBUGkz2oZH4OqDnK+fpmHvBwlw32rr2I2l/Xm6Xr+pS4dLG28kBT6bKcn+1gDFsA1gwA0H0p+QwebyrDddKvXEs9y8iCbomNG+34QI7/HYir1J2OWE68p+WrsHFva3zLsh6vT0fjD2e9PH4otoB6zkwAId1CD9thzpmQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rsdLvkDS; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rsdLvkDS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z351qy9S6QR9rQTDu8mmGNWI6OhvnMlE1xdM0LPr+D/rOBSkT0VRIcMfRAXR2qzW4kmv/LUHBmUiNAeAT0gSdk9xtnsaUu1oLTBT4AV53de090xErJsg20TYqtYSu0ikXR8P72Ust5DExp8f+lp6QsAJwSmMeZzARq8a8t4wVIsU/0eRWkdchum/C1dZN50aJn/GFX7hV+Jwm8p8NTrxnJADz0ebQBeRPrXd5Trdg7kqtUShsZ2Uvn6f9O4MxuBsfC8NPZslnbLuwdIgUpt0VxMs1HMU6EHigApd/bLCoeqZ2UDxGd0dy4SHM1B+6f9lqBUxCKVbiyBmlLesvD6vUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiOQ2Z8CxHR3HXgEBPIiPtFqowqloC3SDnf5I13O0g0=;
 b=buAONUt5uUnwQnvo17/7Ecu526It8a4lBBmA7XdwehaoRUrltTQS/JmjJwtjbyXAGTpEveIxLhV9xbyKJnsG9kD/aH6dHaw7Ax396gNwmYkwObrh1/zSk4/zFqL/UQu1jIIqebvDGtwaw3XzItkgQTN5npzY45OBoWMYNHEcCNcc1u74Ey6nXHETYS/TPMypYidZBAVZfHTZkiwelP08tIgwgQlbyf77EOmvSDN8MBi40Qm11X8BaZQzhymF/gDJV7t9h3P+UKPqGhVkfxyFaLqegv3hsvDGpwB/Ubv4sCh29ZtxQ2mGK3C4/RZ/I7M+9ilKRCeDNlWnZxylrcwT4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiOQ2Z8CxHR3HXgEBPIiPtFqowqloC3SDnf5I13O0g0=;
 b=rsdLvkDSQLscYbxMCqVoSrSa/bkBBR2UCkAbq3azbwraUg/MiFOXH6zXihibfLU980HjXSHcPOHJegDMwR6nTMLRv2fyAJ0myMlt1dK2r0K8sJuReT7QqeDcdLthmNty669UrP8Kev6R44R30/ske8kjgUrIXk1S6BZMgPUaaDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH0PR12MB8485.namprd12.prod.outlook.com (2603:10b6:610:193::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 08:46:02 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8158.024; Fri, 22 Nov 2024
 08:46:02 +0000
Message-ID: <13d4bf58-8f72-8de7-ec94-079ccbcc85c5@amd.com>
Date: Fri, 22 Nov 2024 08:45:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] cxl: avoid driver data for obtaining cxl_dev_state
 reference
Content-Language: en-US
To: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <20241118163238.6723-1-alejandro.lucero-palau@amd.com>
 <202411220917.CiqYJijn-lkp@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <202411220917.CiqYJijn-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0117.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH0PR12MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b61e3a-3206-407d-8a0c-08dd0ad217cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T044NzRkYWIvVXNYc2YrRTRQWjFqVDk4ZWl3NmFzZlBBKzRMbjEva0RBb1l0?=
 =?utf-8?B?SEVaZ3NzUHduU20wRkpNZGlNU3llTmljS1F6Y3pvYmIvNDhpZE5hRHVUNmx5?=
 =?utf-8?B?ejMzK3dmV05xeVN0UmdRTDB4Qlh0WHNDbFpONE1vZFRnQmVNQTZ3dzFEUXZk?=
 =?utf-8?B?NUQ2RVY5SGxIVlRzQlZJMnJIT1hWU0QvckVhY2lQSTNFZGhLQWY0ekE4a3ZI?=
 =?utf-8?B?RExDMHBJcm1IRGoxTVdEZDVOVWZvc1VNTFFSY0pRbkJVU3JsR1BNa1JCVmtp?=
 =?utf-8?B?MmJaVDJ0MzdacUtMdEE5R1A4WEtDSDRvZTR4Si92YUswVnRFOVlCZnNWdXpo?=
 =?utf-8?B?ZjFKWllIeGFEVmRWT3JwM3B3YjdHbHNVeFA5TTNtbWtXWllIR3ZLMHVteEk0?=
 =?utf-8?B?eVVaamhBbVdDaWU5bGNWTDVDZm1BRDF3cnZXZGgvdEZlUU4wdXFxZVg5WkxX?=
 =?utf-8?B?YWoySmgvcS8xNitObDFiN3drYWw5dVNNdnFTNWw2alZTb1hUM2VTSExvMjhC?=
 =?utf-8?B?QnI0VkZveDBHNlVOcmViU0ZFRjQxMkllaVNldkM0ZFBVSk1zeG1HN1FkYm0w?=
 =?utf-8?B?YnpNR0t3d3pWdjV0K0FaUnB4U2tMVDFoSVN3bG0wVFkzU0ZoSE5jRTZQc1ZT?=
 =?utf-8?B?ZStNQ1ZWUlpNNXhkR09Gd215Z0dGd2pVUm5Xdno2dDhncnUxWXhPeTdDWW93?=
 =?utf-8?B?MFNkd1lreWgwSDdEL0Yva3FaL1ljZ1ozak1CR2QzY2ErbVZZajhFbllFS1Yx?=
 =?utf-8?B?ZE8wSVR2d0VSVGpiSkRwMUNYcWdrWURJL3BjOTY3ZlNxNkw1N0U2R0ttTTF0?=
 =?utf-8?B?bGZLaUp5TkZMeGp2R2lQTTZqcTBCNm40QU9kY0RUaTF5bGNLZnVjNjh4YjF6?=
 =?utf-8?B?WUUwWmxTT0ZWWkhHcTFCUEVYQWlYWG1CaVg1KzMwUTJDTGkrT2g1d1g0a3JX?=
 =?utf-8?B?WEgzOVVUNFk3dTZaQWFKdVhyZDRKNzBJM3doRmJPZHNXTGVxdUFiRlp4bG5V?=
 =?utf-8?B?anpRaWwyYkozUkJxSTg4d0ZzbDB0RlhwdEhhSDlvVTlPeC8vcE9Fc1hlMmlF?=
 =?utf-8?B?REF1cUdGNEc4MEx2WXRjMGhUL3dPREloek80WHhwdnVJUmdQVDFWbFdpcWFv?=
 =?utf-8?B?TXlmWWdrY3JueGVicnUyaEd4OGN5SUlnZS8zL2FET3JoSXdYTzVTUG4xbzdI?=
 =?utf-8?B?dXRMWVUvZ0o3bmFkYWJ1cHQwa0N6SU1CUjVoNGRHcjdGNnA5Y1FhOTVzNXM0?=
 =?utf-8?B?QXVVRUVqYStNZEtSMWJkWUFKVWZRck4rdm9rVGtHVTlyNGMwS05rU2tHK3pv?=
 =?utf-8?B?Zi9GZWJUQXdHNW1lM2tTL2F3bGYvbE1NYXhRSVRRZ1pFKzVOZ2hjVnlLdDlZ?=
 =?utf-8?B?SlJsWmRmVktwTVczVnpzOWxMSU1BckNTSlg4K09WR2ZJNWZiRFJMc2tlT21h?=
 =?utf-8?B?bTF2N1RPVTFsZ3F3c2ZuNzJOQnRobGtjT1pZeVcwSkZQZWJsSWFXL0pleVFC?=
 =?utf-8?B?eHIxaTdvVVRCcmozNE8wVFlMMlZFNXk3YzhEV2ZvTVZ2Z3Q5L3BhWlprYWpC?=
 =?utf-8?B?eE5kMm1rRjF3d3hTZVhmcGlSTUYwVGZoZ09JdEY1K1pNeHZCVmVmS25HejFU?=
 =?utf-8?B?bjM0OXBrMS9qYWlCc1c3akJjaXZ3VXkzaFpFNFp4WkRGQlRqeGdZODdac2JJ?=
 =?utf-8?B?TWY0bTVkT2hjQlZxRW1leE9nSWNGN1BRSEpYQ2o3eUMzTGF3TE1DQ0Z3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0MraStjd1U5VVJ4RFBwUHdEL20vN1dJczdLNGQwOVZEOHNXSHNVbG1OQUl1?=
 =?utf-8?B?S0JGMWx3SSthWnRMaXhGM2xKLzN1MmJpNHM5M2JEY2dKYzJpcmVqYjZBUHNn?=
 =?utf-8?B?RTlWMlBFV3owQXdYNnlRcFJTOWp6Tjh2VGRCVENLK3dtWVFVMzlFSHY2akJ3?=
 =?utf-8?B?VlpNTUx6ODZzWFYyaXF0b1VMeWU4Zms5QWhwcXZHK3o4dmVEQXBSY0F0OXJL?=
 =?utf-8?B?UkZvKzgvclF5dEN4TTEybkNVRjlORWxsSzhCakgrM3lKVGNUNGlwd2t4WVJZ?=
 =?utf-8?B?cy8zQ1NoWWR3Tys0NXQvZ0JWcHM2NU1XZVBNNHcwRGJCcjgwVEJ5alhKRk9l?=
 =?utf-8?B?RWQ0VEptK1VQV0ZMVDNMMW9PamJSWWlsaUhxVDhtRzk4ajFUMDJTNzZaQ2pP?=
 =?utf-8?B?LzAxNDRGdXp5SW5NNVcrYkhjWGR2UW1pK3pibTM4QjdzL0tJSFI3MUZKYzZ5?=
 =?utf-8?B?Zkc5TGhBV3lQZ3ZscysvSCtTZXpaS1BuZ0NrSHF2Sk1vKy8xVjhzQ3lEVEp0?=
 =?utf-8?B?QXVtV1NuNXNhaWtqVVdOTWdVWkh0d1NlUDZhTExiTGFjOW5DNi9uRm5BQ0pK?=
 =?utf-8?B?V2JOaUIwRkNEeUpZQjZoc0JiZE5pR2lvcHRaTkZsQktlRUVlaUlQazNkM1lq?=
 =?utf-8?B?N2c2cXBLZ1JkSlIwNU1xZzhIaFpUWEw5b3hURStETGd2ZFIvUE5pdUdYNm5q?=
 =?utf-8?B?SU1ST2thc3dIc05KWXBYOWc1dXJ6OXBNMmc1VXFxNk1pTDNhUVdKS2duem5Q?=
 =?utf-8?B?ZlViZkV5UjFJUklTeHYwYUdHR2prUkVvUWYvc3J0blNXcEFXd2JwN1RTUUwx?=
 =?utf-8?B?cndRY3AxbnY2UjVibG5mVzc2OGpGNlJoZWN5UDlIaHY4Yjk2NHZNZXQrdlVB?=
 =?utf-8?B?YUZzM0xhUlhkNTBBVjJ3TTUzS3Y3TWMvcDV6S3hFcXg4ekZtcytzZjBjd0FY?=
 =?utf-8?B?VzgwSUNiS0JrSmRVV2RONURvbDFRS3Q2L2pybkZ3NjJGSG84WnNEcnBRSzM1?=
 =?utf-8?B?L3dSa0pwVGJFazlFUG0vRThjY3VwbnVJQWZqaHVTZUZlWGJTK09leFpyOWJ6?=
 =?utf-8?B?dlM0WWc3UGE0elQyQXUwNW10aFJZVG8vMTRyaWdMUzFPRnNFZTlpUmpIcW5n?=
 =?utf-8?B?RVBaWm9JUmpnMkg3Z3cxcWlHeHE4Z014ekFtZVJTUm1DS1hDWXlUeUVhYUsw?=
 =?utf-8?B?UGlWdStYb04xcVQzRlVVajdNWnR5TXdLa0twZmRVZHFNZkppVkN4Wmp2UkJr?=
 =?utf-8?B?MlJTMURYM0VmdW9KdnlQdjl4M0JGTVRGT3ladVJXbU9MVG5xM0tOZUNoMWxU?=
 =?utf-8?B?Tjd1cEQ5Wm1sZ1FUMzJRek41cStZSFlPNzA2STVBTnZ3bjN1a0JCM05aM2do?=
 =?utf-8?B?aDNtYzI2a2x3NExHdHNCVVdoMmp1R0doWVVKUXd3bWd6UVdzY3Q1ajRBNEpF?=
 =?utf-8?B?WjI5LzNHWldRSTRGaDhEMnQzYWpZWUFDcitPaDZOUkFFSGhSRGlHUkFlSEU1?=
 =?utf-8?B?dldMQk15V2NoK3lCNEZueDYzSlk0NktYMlVvZG44akpXTEQ2TWE3OUNmU0ZL?=
 =?utf-8?B?c2pjaGVlS3VYQmJ1RzBVek1WVTJ2U1Q1ZjNJcUNCMnZEeTIxRU9LRVA0clJa?=
 =?utf-8?B?dmowYlVMV2VvOXNza3oycEUvY0VFL3RSYVdOellVNnF2ZHpadmUzN1ZQR3dI?=
 =?utf-8?B?OWd5OFVqMHl2SWl2NUZOamRmS1BPRDVlOXJjcW1sbndBdmIwV2dyNWNqT2l4?=
 =?utf-8?B?eU9TTEU3SnpoLzJiTkdCeitsSXZ0aThmUW9TVlpFQW4vV0RBaXNGeitia2Zh?=
 =?utf-8?B?TWYwQTZxT29ZNzluYUNyeS9NS0xpWktmRVNqZnFVWDdYbG42aWF1MXlpNnEx?=
 =?utf-8?B?a2tpS2dHVVh4dnZUdXprMDFiTDJDVDExbGVLSkZEZ015a2V4SFJpWk9hN3VK?=
 =?utf-8?B?L0VGZHMwQ3pmN3pjdmM0RGg1ZFVRWEFXRTM1eXdnM1d6YVN4blp5YmZjVG92?=
 =?utf-8?B?UW9iRGIzclJ0ZXRHcHoyM3lRa2E2NTAwSWZPNjhob0FMMGk0MkMvSjRHS05O?=
 =?utf-8?B?eEowQlFrT3poUmM5bi9SU3FsaTRlaFg0amV2TlN5Sm1NYnVZdTVPeVBwWVpk?=
 =?utf-8?Q?AZxR4pwtiXYqUD5mZrOgszLya?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b61e3a-3206-407d-8a0c-08dd0ad217cb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 08:46:02.4902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eJxgOkGAMCE7kikUCZmkZQVOhrNRgoBzse+RccqjIu3d0nte5WfpRfPSMydt0Ff9cMU46VAa2K0dAUMRw2qrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485

Hi all,


In v2 I fixed other problems reported by the robot which were directly 
related to the patch changes.

However, I can not see a link between this one reported now and the 
patch. It is a mips build ...

What should I do here?


On 11/22/24 01:46, kernel test robot wrote:
> Hi,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on cxl/next]
> [also build test ERROR on linus/master v6.12 next-20241121]
> [cannot apply to cxl/pending]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/alejandro-lucero-palau-amd-com/cxl-avoid-driver-data-for-obtaining-cxl_dev_state-reference/20241121-141608
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
> patch link:    https://lore.kernel.org/r/20241118163238.6723-1-alejandro.lucero-palau%40amd.com
> patch subject: [PATCH v2] cxl: avoid driver data for obtaining cxl_dev_state reference
> config: mips-randconfig-r061-20241122 (https://download.01.org/0day-ci/archive/20241122/202411220917.CiqYJijn-lkp@intel.com/config)
> compiler: mips-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411220917.CiqYJijn-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411220917.CiqYJijn-lkp@intel.com/
>
> All error/warnings (new ones prefixed by >>):
>
>     In file included from drivers/cxl/cxlmem.h:12,
>                      from drivers/cxl/pci.c:15:
>     drivers/cxl/cxl.h:830:24: error: storage class specified for parameter 'cxl_bus_type'
>       830 | extern struct bus_type cxl_bus_type;
>           |                        ^~~~~~~~~~~~
>>> drivers/cxl/cxl.h:879:20: error: storage class specified for parameter 'is_cxl_pmem_region'
>       879 | static inline bool is_cxl_pmem_region(struct device *dev)
>           |                    ^~~~~~~~~~~~~~~~~~
>>> drivers/cxl/cxl.h:879:20: warning: parameter 'is_cxl_pmem_region' declared 'inline'
>>> drivers/cxl/cxl.h:880:1: warning: 'gnu_inline' attribute ignored [-Wattributes]
>       880 | {
>           | ^
>>> drivers/cxl/cxl.h:879:20: error: 'no_instrument_function' attribute applies only to functions
>       879 | static inline bool is_cxl_pmem_region(struct device *dev)
>           | ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/cxl/cxl.h:880:1: error: expected ';', ',' or ')' before '{' token
>       880 | {
>           | ^
> --
>     In file included from drivers/perf/../cxl/cxlpci.h:6,
>                      from drivers/perf/cxl_pmu.c:23:
>     drivers/perf/../cxl/cxl.h:830:24: error: storage class specified for parameter 'cxl_bus_type'
>       830 | extern struct bus_type cxl_bus_type;
>           |                        ^~~~~~~~~~~~
>>> drivers/perf/../cxl/cxl.h:879:20: error: storage class specified for parameter 'is_cxl_pmem_region'
>       879 | static inline bool is_cxl_pmem_region(struct device *dev)
>           |                    ^~~~~~~~~~~~~~~~~~
>>> drivers/perf/../cxl/cxl.h:879:20: warning: parameter 'is_cxl_pmem_region' declared 'inline'
>>> drivers/perf/../cxl/cxl.h:880:1: warning: 'gnu_inline' attribute ignored [-Wattributes]
>       880 | {
>           | ^
>>> drivers/perf/../cxl/cxl.h:879:20: error: 'no_instrument_function' attribute applies only to functions
>       879 | static inline bool is_cxl_pmem_region(struct device *dev)
>           | ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/perf/../cxl/cxl.h:880:1: error: expected ';', ',' or ')' before '{' token
>       880 | {
>           | ^
>
>
> vim +/is_cxl_pmem_region +879 drivers/cxl/cxl.h
>
> 779dd20cfb56c5 Ben Widawsky       2021-06-08  829
> b39cb1052a5cf4 Dan Williams       2021-02-16 @830  extern struct bus_type cxl_bus_type;
> 6af7139c979474 Dan Williams       2021-06-15  831
> 6af7139c979474 Dan Williams       2021-06-15  832  struct cxl_driver {
> 6af7139c979474 Dan Williams       2021-06-15  833  	const char *name;
> 6af7139c979474 Dan Williams       2021-06-15  834  	int (*probe)(struct device *dev);
> 6af7139c979474 Dan Williams       2021-06-15  835  	void (*remove)(struct device *dev);
> 6af7139c979474 Dan Williams       2021-06-15  836  	struct device_driver drv;
> 6af7139c979474 Dan Williams       2021-06-15  837  	int id;
> 6af7139c979474 Dan Williams       2021-06-15  838  };
> 6af7139c979474 Dan Williams       2021-06-15  839
> d69d804845985c Greg Kroah-Hartman 2024-07-01  840  #define to_cxl_drv(__drv)	container_of_const(__drv, struct cxl_driver, drv)
> 6af7139c979474 Dan Williams       2021-06-15  841
> 6af7139c979474 Dan Williams       2021-06-15  842  int __cxl_driver_register(struct cxl_driver *cxl_drv, struct module *owner,
> 6af7139c979474 Dan Williams       2021-06-15  843  			  const char *modname);
> 6af7139c979474 Dan Williams       2021-06-15  844  #define cxl_driver_register(x) __cxl_driver_register(x, THIS_MODULE, KBUILD_MODNAME)
> 6af7139c979474 Dan Williams       2021-06-15  845  void cxl_driver_unregister(struct cxl_driver *cxl_drv);
> 6af7139c979474 Dan Williams       2021-06-15  846
> c57cae78bfa6a8 Ben Widawsky       2022-01-23  847  #define module_cxl_driver(__cxl_driver) \
> c57cae78bfa6a8 Ben Widawsky       2022-01-23  848  	module_driver(__cxl_driver, cxl_driver_register, cxl_driver_unregister)
> c57cae78bfa6a8 Ben Widawsky       2022-01-23  849
> 8fdcb1704f61a8 Dan Williams       2021-06-15  850  #define CXL_DEVICE_NVDIMM_BRIDGE	1
> 21083f51521fb0 Dan Williams       2021-06-15  851  #define CXL_DEVICE_NVDIMM		2
> 54cdbf845cf719 Ben Widawsky       2022-02-01  852  #define CXL_DEVICE_PORT			3
> 54cdbf845cf719 Ben Widawsky       2022-02-01  853  #define CXL_DEVICE_ROOT			4
> 8dd2bc0f8e02d3 Ben Widawsky       2022-02-04  854  #define CXL_DEVICE_MEMORY_EXPANDER	5
> 8d48817df6ac20 Dan Williams       2021-06-15  855  #define CXL_DEVICE_REGION		6
> 04ad63f086d1a9 Dan Williams       2022-01-11  856  #define CXL_DEVICE_PMEM_REGION		7
> 09d09e04d2fcf8 Dan Williams       2023-02-10  857  #define CXL_DEVICE_DAX_REGION		8
> 1ad3f701c39999 Jonathan Cameron   2023-05-26  858  #define CXL_DEVICE_PMU			9
> 8fdcb1704f61a8 Dan Williams       2021-06-15  859
> 6af7139c979474 Dan Williams       2021-06-15  860  #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
> 6af7139c979474 Dan Williams       2021-06-15  861  #define CXL_MODALIAS_FMT "cxl:t%d"
> 6af7139c979474 Dan Williams       2021-06-15  862
> 8fdcb1704f61a8 Dan Williams       2021-06-15  863  struct cxl_nvdimm_bridge *to_cxl_nvdimm_bridge(struct device *dev);
> 8fdcb1704f61a8 Dan Williams       2021-06-15  864  struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
> 8fdcb1704f61a8 Dan Williams       2021-06-15  865  						     struct cxl_port *port);
> 21083f51521fb0 Dan Williams       2021-06-15  866  struct cxl_nvdimm *to_cxl_nvdimm(struct device *dev);
> 21083f51521fb0 Dan Williams       2021-06-15  867  bool is_cxl_nvdimm(struct device *dev);
> 53989fad1286e6 Dan Williams       2021-11-11  868  bool is_cxl_nvdimm_bridge(struct device *dev);
> 84ec985944ef34 Li Ming            2024-06-12  869  int devm_cxl_add_nvdimm(struct cxl_port *parent_port, struct cxl_memdev *cxlmd);
> 84ec985944ef34 Li Ming            2024-06-12  870  struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port);
> 04ad63f086d1a9 Dan Williams       2022-01-11  871
> 04ad63f086d1a9 Dan Williams       2022-01-11  872  #ifdef CONFIG_CXL_REGION
> 04ad63f086d1a9 Dan Williams       2022-01-11  873  bool is_cxl_pmem_region(struct device *dev);
> 04ad63f086d1a9 Dan Williams       2022-01-11  874  struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
> a32320b71f085f Dan Williams       2023-02-10  875  int cxl_add_to_region(struct cxl_port *root,
> a32320b71f085f Dan Williams       2023-02-10  876  		      struct cxl_endpoint_decoder *cxled);
> 09d09e04d2fcf8 Dan Williams       2023-02-10  877  struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
> 04ad63f086d1a9 Dan Williams       2022-01-11  878  #else
> 04ad63f086d1a9 Dan Williams       2022-01-11 @879  static inline bool is_cxl_pmem_region(struct device *dev)
> 04ad63f086d1a9 Dan Williams       2022-01-11 @880  {
> 04ad63f086d1a9 Dan Williams       2022-01-11  881  	return false;
> 04ad63f086d1a9 Dan Williams       2022-01-11  882  }
> 04ad63f086d1a9 Dan Williams       2022-01-11  883  static inline struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
> 04ad63f086d1a9 Dan Williams       2022-01-11  884  {
> 04ad63f086d1a9 Dan Williams       2022-01-11  885  	return NULL;
> 04ad63f086d1a9 Dan Williams       2022-01-11  886  }
> a32320b71f085f Dan Williams       2023-02-10  887  static inline int cxl_add_to_region(struct cxl_port *root,
> a32320b71f085f Dan Williams       2023-02-10  888  				    struct cxl_endpoint_decoder *cxled)
> a32320b71f085f Dan Williams       2023-02-10  889  {
> a32320b71f085f Dan Williams       2023-02-10  890  	return 0;
> a32320b71f085f Dan Williams       2023-02-10  891  }
> 09d09e04d2fcf8 Dan Williams       2023-02-10  892  static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
> 09d09e04d2fcf8 Dan Williams       2023-02-10  893  {
> 09d09e04d2fcf8 Dan Williams       2023-02-10  894  	return NULL;
> 09d09e04d2fcf8 Dan Williams       2023-02-10  895  }
> 04ad63f086d1a9 Dan Williams       2022-01-11  896  #endif
> 67dcdd4d3b832a Dan Williams       2021-09-14  897
>
