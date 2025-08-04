Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA86137C2A
	for <linux-cxl@vger.kernel.org>; Mon,  4 Aug 2025 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319896; cv=fail; b=Dk6T6n0/urEBKtBz6rnzYuS2D6xUi+HkzGlSPd8IYK86BR9B9t5GHkS893OmxqECNnyv5NuaI/DhTi+QMvoUVzy741F6Ur/M7nnZbD1WcC4zttDRavIQ6sL+Mxefl/VE6EQGRHZG6K/apmoswh+1L5tBggUKxKiL2Fu6PktitYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319896; c=relaxed/simple;
	bh=Kktz5WVY7YIx3yIeJAEyhR+WZfTu9vFn97tIlBSluKQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rOK9pOFWHli47klapPuLR/ARBTEqQ1J9hYjDvdqzft8vA4lKJ1EhHyRvAiiO+GtBaNH2SKiRMxsEyStsU2gf17Fv/Pans/fE1e6m0S8KYX048tmZ6hUwaJxn4P7GzfBhKYcz8Nf0bXqUvUO7xyCao7ZDe4wB0OzULSy7PnVnaCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Qbv7wZi; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Qbv7wZi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mx9xAZJYapLstREVhhrz23jvxsZmYuv+IxqLe0hkWj+Bf+jLNMI8clj1aTHRh/dBLDmFRxnRJZnGIt0RcqIPKXCt8OOciLE9AgEscqvJvkQyGYgthmBywqSEUKkKDBSoeas+WtSj6/QsyhY6+RedaVPGkneqfjpOYbmPJU86RbXCb/Wmt+C10TESV7mcEK58AcHiESdJDkO1WNdGLOhwmTlUmp7+AvOVKmHXhh3KJx8ktl5IZxiEPBUgDT8x82EF8ThzIFIXpQ/ZQN8Uw4Mb7DyJjjLHi6Ixohy3XNeg0pI1/PmqG+T7swJO6+RmO/PwdXUfb5yyLLtJFmtCyaSzdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/K7rwWtpJdUwF3qn/Ve+c9QG+dsaQ2ADbbZEgdHKjY=;
 b=kYRezhGgTpuR3jiygBx7gVZCmz+NeWr1i5QMe8IB6u67HKCeagcloh9mN3Ph/SZvoLCuDO4x98RuwNcyyE4kSuVJ7WSV7GVBlq18/NlrkTNEAB0qY4Kl6ifv/0kUkymhl7d3ZAslKhm+BQ5h47WLb6Y10xev+N0FFlLIsmcsrZvRkd+speTPQ8I1JDZEct4bRlAnrInBl5CjKzmNtXzRVVMgbznKBL3a9c+sHvedqKZCo/QNRVDU7HbTi8zeUF4CX71ElsHR/tJDubt28Rn5uUaOvEqD60LRopOgdjnwt2GYsRslVSlfkc+fpVAw0C5ajKMkWRrESPJpokuIrskMxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/K7rwWtpJdUwF3qn/Ve+c9QG+dsaQ2ADbbZEgdHKjY=;
 b=5Qbv7wZi2ZJLqFUK2FY2EnI93IirRKU45zMAeI26dOPRMXdHqLadfl9tV9eGtXRZQfir599CWhh1Cag4TtXvWl/iwX2LS1bPEqZLRANyrfd1Es/9z3q3ny/wTUz8AO44yqmv3pafyAaU7DSpHHYQhnSfCSP9cdfu6EED8KNz1z4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.21; Mon, 4 Aug 2025 15:04:43 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 15:04:43 +0000
Message-ID: <3be496e0-a651-4dfe-b3d7-01df30350893@amd.com>
Date: Mon, 4 Aug 2025 10:04:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from
 core/pci.c
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, Robert Richter <rrichter@amd.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20250730152519.125601-1-dave.jiang@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250730152519.125601-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0235.namprd04.prod.outlook.com
 (2603:10b6:806:127::30) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 993aa52d-88aa-4ad3-e43e-08ddd3683e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkJCTWo2SGYrNnBYSGlGOVZEQXRjT1RWc0RNQ3ZJWTgvTHV3aEdQOEpIUGEv?=
 =?utf-8?B?eVpKU0NjLzBhdWJJeWg4Q0hveEVEZlFOeTBrVlZaRDFqOEI1M0ZHbUlhK2Q1?=
 =?utf-8?B?ZWtxK0ZGTkVkSEp1Smc4NkZwVEg5K0dXUnNoYWRPVEtZUjY1d0FhYTFxTnZx?=
 =?utf-8?B?cVpJeVNJS2lqTHgvNXBoak80akFGNVN1eFMrSDBtbU1sQjFRN0FNYzhEZXNU?=
 =?utf-8?B?VzYrNjU3ZUgzV1BtSTB4Z2ZRMWt2U1BFNVZXblE4TFNzN3I4YXVRY1B2SHJy?=
 =?utf-8?B?cEdMNlhaTEthdUMvcnhpQUViVCtOY0xZSnZ3eU5seG1RYXp5emxhWEI3cnBu?=
 =?utf-8?B?SGJsVHJFMkQyNlZ2a0NXQVBKTnh6emtQUzlzU0lua01BYjRJMWxhNUE0enpZ?=
 =?utf-8?B?VkEraGhhZ0dULzFVUWZCTFV6ZkhvUGxyK2tvUS9STjNQZFljVFc1VmU1NHA4?=
 =?utf-8?B?bWRTUmtjRWp4dGdCVXdjVXBHNzRJUmI4TXRZSi9nSmlWaHJxVDZOVEJCL1ZD?=
 =?utf-8?B?VVFpUnUvS3ZrV1lRUDhrZnlBY1pHM0EvbG1PWnBWa2V4VnpVN1NQK3VFcTNh?=
 =?utf-8?B?b2R5QWJUeS9PVkxRVFNkWk9IbVFKOGtHSVFuLzlHZnJveXVvb241Wmh1b2lS?=
 =?utf-8?B?VUFRWjgvRFhpNjV1WUdtL1lKKzZBTjluWjgwNnR4RGVVWEVNNE1SeVRMV01B?=
 =?utf-8?B?aEx0MDQvTFNielhEbjN4bGxocU1LWjByU2RRUGlXVzN1L1JONjNyREpBVXBM?=
 =?utf-8?B?aTljeXQ3S29MTHVIak0wWkxkMCtJYjB6RHFraWN4MEVDc292d0c5M0pCWFJR?=
 =?utf-8?B?aXdIUlord1U4dkthVm9mcVJMQlZwb2RnMS90WUk1KzdQSWVvSVh6Unp6NFRx?=
 =?utf-8?B?RmpCd0dQV2crUm1CVjhTNzNGSnFieXA1TjVRMCtKcmNNSWc3M3dDTUlwTGww?=
 =?utf-8?B?bzVVRzhmRW9lb25vbXlqOTRHeWJnOTJnc0F3Q3Bna3hmSTk4TzhBRVlCMDlq?=
 =?utf-8?B?WFVsTUp6RGw2YTB6MXV0YXROUWtzTGpEVHI3ZmVVNVl1dkkxdlNrQmlvZU5h?=
 =?utf-8?B?TjJpbUk2azE3YWg2RjlIK1lmVThEY3MwcXhNT05MeVJ0dnBFZEFBTlhwU0J1?=
 =?utf-8?B?azBZY1dpajZDc1NsTmxMcXYxWDNIQ2FGOGYvdmhVNHBRTUU0QjQwc2UwOG9x?=
 =?utf-8?B?dGtWcW1rZWtjWEluRVBFcFlkaDVrc3pnSkxXbDBjVWNqZ0I4R3VXYnI2aStx?=
 =?utf-8?B?K09mN1l4V3pEbHNwNTY0NlBvUjc4VFhXaVRlNTlkaUUyZXVseXBIK3c2MnE5?=
 =?utf-8?B?S1FwNy9kc3hhbE5ySGNtTDJhVWNPclFoelYyY3BuM3hrTEVUY0pXN2N5Um9W?=
 =?utf-8?B?bW5QZE1Gd2JncFg3SmVEeDFSTWRZU1pJWGpjS3VvdlR2SnA4ZmM2bmVuM25u?=
 =?utf-8?B?ck5FdWgzNzdEb3ZnaTBIUVlPbSttdlVzZ1RWQWFYN2tycHBJTUYyQVgzM003?=
 =?utf-8?B?SldvR3MrQWc5aTg2T1pSK1IwaGpmaVczRSt1RzVwZnJsUmN4VzM4SzFCSG1G?=
 =?utf-8?B?VmdET05EOW5IN1BrSlNqeEFSODZIcUV0NVBZTHJDdFRMOG5qM2lnNHhEZko0?=
 =?utf-8?B?a3kvdHJITUtzSjczTHhWTDB4bVFGSnpXTUNwK0VzblllWklJaXJHV3JtWlV3?=
 =?utf-8?B?cjRzRFIydWRia1RsM1pmdVVRTVI3SzdnLzFHNnFPR0pvVG43enNLQ2QzUzJu?=
 =?utf-8?B?L25WNWFSWVVQT2MyTWpXTmoyMXA5dzdUNEZya3JvQXdSYU1aY3VhRy9QTjZ1?=
 =?utf-8?B?VTVJd2tBVUNmUHZONm9Vb3JVV0t2blM0K0tBOEZEd0RKSXQza2xTMzFwRTIx?=
 =?utf-8?B?V2RvUUVqZW45WEhoNHNaS3MyTzdTK2o0WGxyR0lzcHNFOXJDWGZjUFZrUXVK?=
 =?utf-8?Q?ZOcBr7pGqkQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZloyNUtQYkE2c0E3alFTcnhOdmU2cy82Wmc2WkdZeHB6bkFDSHNuMmloRk5k?=
 =?utf-8?B?M0pyVHVFaitla244RVJRRWZpQi9aUk55WkttVjFvdlVZY1NUTE1FTStwQ1ox?=
 =?utf-8?B?b0djbVJobU1VSXJJMzYvcEJxclF3VUhEN1g0eEtOSmV5L3E0Q2hTdDhaQXZN?=
 =?utf-8?B?YTgzQVhVbDdFVGJzTWhaaWI5TWhTSEJicWRNMGFIS3EyOHV4M0ErZU55WCt3?=
 =?utf-8?B?T2FSSHBCVm5oUlRucUJkWkt3Vk9rTW9NeXNLNzhLRi9KY0J0ZXYrejdHYytR?=
 =?utf-8?B?U01OVjhvR1lsL3BTZXJtWnpBTDJqdHN3ZWF1d1NzMUpWNkpyeFNsQW1vV0JG?=
 =?utf-8?B?b0J6QVFIb3p3R3NXc3hJeElNbGYwTzNSY0p5U2pwL3ZkazFqcGwydGxKSS9z?=
 =?utf-8?B?bW5jeTVETUhrMkVFZXoxTTZkTUxBRTBjeVlJdERQTnJrcUpwVllRN09ZTjJS?=
 =?utf-8?B?dEVaWE8zaHVGTG1vYm5yVE8yTnpIQkZNQ3k3SXNDYmxCc0UyK3hlVytoNExX?=
 =?utf-8?B?bVQ0bENqelpKZy9JYTVEazNZWWVVMVM2NFZKQjk5a3JzQkdhNW5IRFd5MHhS?=
 =?utf-8?B?UmJmbTRqNjgzcTNoTnRXWmYzei8yN3laTkI0V1R3ZGdrelhlMTgyYTBUQ2FQ?=
 =?utf-8?B?V3NCZlJENTZ5Uk5aaGdoMHlQYlBYbUVNRmhkL0RZOVA5QkZ4OFhMNW9XZ0h1?=
 =?utf-8?B?ZkhVOGxpV0hQbWYrdmg1M3FaeGFoOHZISUFTOGdFc3RFYzlSSithaG9lV1F4?=
 =?utf-8?B?QmRYQU4zNUxPMU42VldHRVh5Ymw4M0k1dUhYT0p2VDJnRlZqZUFqMFFLWllP?=
 =?utf-8?B?djArM1NON1U2OWJneGR0TFoxd3MxMDMzNjVRWlYvVHErb001amRlVG9tVWZX?=
 =?utf-8?B?RjhCMERkMjRMeENEN3ZodWR3V3p6NnVrNXF5Y0wwZWR5bnZBdEYxNVBuR0s0?=
 =?utf-8?B?VklOWFBWeG1TaG9WeDJVRkUwTWV4VFFkSEs4ckJhYzZ6cnAyL3ZZT0Q4NHVK?=
 =?utf-8?B?Q0J4Wk9OMkliampOOGpqUzRmZi9KTER3Q2JTMmVWZnhOTnpMc3R4YytZZC96?=
 =?utf-8?B?dlc1eHpSS05XdWRuSFQ0aTQvY1JycFJpdXk2QVlkdGhBbE5KSlI4c2pyaXJD?=
 =?utf-8?B?RDVuZ2d1NkN0RHRvU0hYcDYrNFlDMm1Ed3dTMGFJSFpQNWd3RWZzK2JQTWFk?=
 =?utf-8?B?NnZCVTF6cXdjYTUrK3FwejJMbzZEN1NOL3pkQTR4TjVIakFjU2xRc2MyWk8x?=
 =?utf-8?B?bUJaQjZwSnhzaVkwQlkzejRjUlAxK2UzQmlCMHl2bTg4RGhILytGc3AzMndW?=
 =?utf-8?B?aEthei9Kb21PaTV5V0pmeGdlZTgwSXh1aTJ2SFZTdE45aGdZdkJWajk0azhh?=
 =?utf-8?B?Rk0vdkIrRjh6MWIxMFF0TWJSRUxkRVIxTG5DbVV4TVliOWM2MWllVktTc2JZ?=
 =?utf-8?B?Rk05MHdrRlhSUVlQVXcyL0hVUUlGZ2xQYVZRN2RCbkJoMjZ4UmZ0TmxNbzg2?=
 =?utf-8?B?ZzVIeHcvTnhVdFg3cE9BOGx4Q0FBcG85bklYOUcrazNrMHR3UkNMcnRvNUlQ?=
 =?utf-8?B?eFpDenZZTStTTEJvWUJFSkllZlM1am9LWTdwcEV6bHhOb1ZaZWdWUnFLU2hi?=
 =?utf-8?B?VWxQYXlWT1NSa2Q5ZTNNUXlTTitFS21aUDdQVUlBY0M3N3JCNGluVUE4RkF4?=
 =?utf-8?B?MmRWdTdjaUtmRW1La3NndWNGNWdPVDBLTnJQaXZQL1BFQmMwVDFMODhadFhn?=
 =?utf-8?B?MDZTaklzdlh2OHNobFd3WVZJQis5bFNjRSt6VXpGVnJicWUwQ0pXK3V2OFJS?=
 =?utf-8?B?a3psYWp6cU52cXlOSTR4Unp0R0lpMkFkMFZQQzlac0hIVmFhRjNJNk1NU09H?=
 =?utf-8?B?VXo1cTJPeHV4UGxOZ2JxSmdRWGpFU2NBSHNiMFJNeEdsL2wwWmtPQjNpUGFu?=
 =?utf-8?B?RmlpRmJqeStxTjIyYVNjSDZQM040OXVwMWJTS3VMdW5tRXBnREpxMk15dXNK?=
 =?utf-8?B?MWIvSEtOS1JGci9mNkc3cGQwcE9Ed1ZGT2VXQzJ6QkhoZmVqMkpsWDVhcG94?=
 =?utf-8?B?UlhpYTR2VmlqbC9uYmRtTFVRWHEzaFpnMWRGaWpPanFOQWJUOVdMOVp3R05E?=
 =?utf-8?Q?vk3NPUZvtYwQ8MJhnuHyWqsog?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993aa52d-88aa-4ad3-e43e-08ddd3683e6f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 15:04:43.6727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+ZZXOqhoVbWiwQRWYcV8bWt3uQv5eHm/Fsq761KO9N2WfsiVNuhY0kP63Dm+bt9yNEgtYf/CBwPUZ+98B7Ryw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089

On 7/30/2025 10:25 AM, Dave Jiang wrote:
> Create new config CONFIG_CXL_RAS and put all CXL RAS items behind
> the config. The config will depend on CPER or PCIE AER to build.
> Move the related RAS code from core/pci.c to core/ras.c.
> 
> Cc: Robert Richter <rrichter@amd.com>
> Cc: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v5:
> - Make cxl_handle_rdport_errors() static. (Dan)
> ---
>  drivers/cxl/Kconfig       |   4 +
>  drivers/cxl/core/Makefile |   2 +-
>  drivers/cxl/core/pci.c    | 319 --------------------------------------
>  drivers/cxl/core/ras.c    | 312 +++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   8 -
>  drivers/cxl/cxlpci.h      |  16 ++
>  tools/testing/cxl/Kbuild  |   1 +
>  7 files changed, 334 insertions(+), 328 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 48b7314afdb8..b36bb0cabe58 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -233,4 +233,8 @@ config CXL_MCE
>  	def_bool y
>  	depends on X86_MCE && MEMORY_FAILURE
>  
> +config CXL_RAS
> +	def_bool y
> +	depends on ACPI_APEI_GHES || PCIEAER_CXL
> +
>  endif

Hi Dave,

Can PCIEAER_CXL and CXL_RAS be combined or must they remain separate?
They both enable CXL specific AER and RAS handling.

-Terry

