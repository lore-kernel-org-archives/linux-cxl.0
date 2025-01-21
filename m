Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D83F1F4285
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jan 2025 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737485845; cv=fail; b=S8K0jcTYl/wPCyaz9Ur4BCR1LFQLMGuS5/iaqCJY0dqDK8sCmy9TtBk7ebILCVCP59q54llg+vYCfn/B9VAPdcl3xDgvgC2iSpf17nnvW+q6HGUAMl9qXn7Z43+SRzCKSCrJ6suPG9mDx/N7e9qMd9x2GZRDJUjbyZYBREqeNUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737485845; c=relaxed/simple;
	bh=VIhOg5xw+6ZO7gVFWPAo4z1HPF9eG5oOoeLku7jth9E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AEa6+uXSqnsjvwSPOaIPZQ08VUm1C95MmKFWdbOXr5lbACKnxx5vzy16Ti9NZqS8UioCd2M2tHtq95fIcfZDcSQdR0uwXgtDK7Ajw993a42Rdfea6z7vddD+oCRyW1AvFrZLtM9GVNQOpNKumX4gddi5MuRzgGHzV6mar75ljnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2VYmWuck; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2VYmWuck"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kscck84p/I2MYiKzsUO6IaFuKfSvaIT5Ui4KngdXKr5fhSy34xv23woSlKYb7hdn2UpaducKDfDMInjv2Yuo0IFNfjZoWl9ZARAk7g9ALOcKoWxUUAxEp4ZMWIc20MYKeI/hFR0KCaIR2/3BLoy8qmDXRx6bf0FjVmHv3k7l5aig3+s31yHASryhR0oyUQdQyYNpaZWy5sZeK5btU9GYmp2KsUBWpypVxT1AQJNclEmwu3BJvkHbNIWjPaEWxqdpcau8NAkE2S8qppRipOXvlfOJiMBkvXfAcFZ+ExS5otGGf9hOt6yzn9Dr/Yrye8OiMg5qImzYwxiR/4Mn8CwZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDek0vGjDuExh5XWQWrovJ9EyeFDtwUcp3sG/N2ej9o=;
 b=hYOqygC/H3cLln8kPLb4Qf74RWVeLvJheF1nyWIPRxJZqwggb1ZFo6CNF/3DFqxtqerTd5ZHrw9bE6FyQX1DhpuQ3SNJlWQZup3ziCNSiTsMHcsUmu9AaskY47VFXI+hcJ6Ovof4+1yW3X5GWn3+0+WDarZIHbJ7sDUKU11U/t/SqHnfbEL0feZmnvn4ewU3RdUmmveemWgqArhn5LuVfw054VndmmAhE7e/h2Evnu/WbLgCWIPIxR26ObFy+O0ePtSJ9njPj3RrOqFC5Bt0qFszTdf+noIL9KdH+iNlTrpZFxGnhYxfsTkg3xxhH3u/dZisgWiUDQEGMOJAFo1TZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDek0vGjDuExh5XWQWrovJ9EyeFDtwUcp3sG/N2ej9o=;
 b=2VYmWuckFCyFeRG79Q+M8PFXaKOIUea4urAYTA+1c7D042TMxuXip1qYo7yqxKRDKGW9vyTC+Ua+xe5PgWSSFsHMeNVSWDhvcTiafQe0LA5b1rvSijmr9hRV6tUhixZ+3H07n5PDKNH9wPkRQXbTGO9e2UKLMbJCdkE17XeEjOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Tue, 21 Jan
 2025 18:57:21 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e%7]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 18:57:21 +0000
Message-ID: <3c7c5b87-f241-482b-9b00-98e2e53d8e9c@amd.com>
Date: Tue, 21 Jan 2025 12:57:19 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] kernel/resource: Introduce managed SOFT RESERVED
 resources
To: David Hildenbrand <david@redhat.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, alison.schofield@intel.com, linux-mm@kvack.org,
 gourry@gourry.net
References: <cover.1737046620.git.nathan.fontenot@amd.com>
 <1800b17449d1c231292c85f59b226aff39a81552.1737046620.git.nathan.fontenot@amd.com>
 <4e556200-c790-4e0a-b103-2a1529c81927@redhat.com>
Content-Language: en-US
From: "Fontenot, Nathan" <nafonten@amd.com>
In-Reply-To: <4e556200-c790-4e0a-b103-2a1529c81927@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:806:d3::8) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: f9113894-f73c-4c18-ffd2-08dd3a4d6f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEJPM2NIV0xHaTR3RFZzV3NuZmsyRm9EUVB4TzZiK0t5VTFPQk1CWUZrU0x4?=
 =?utf-8?B?TENOeU9jaDUxcTlmNythNlZLMSs4RmJ3YXZlOEtrWm9yVHZBWXRmYkNVajlJ?=
 =?utf-8?B?dFY3QnBwdGdwcytCL3FOS0lHalExM25QOXNVUURBRWxUWVNXb1Avb3JaLzFW?=
 =?utf-8?B?Y2JCNFM0Wkp2THNsMUNuTGFSbis4ckFEWHdrcUtJQ3lGMUNiM2VIOUU2ZlJR?=
 =?utf-8?B?SS83YkswaFIrck90V0k5YlpwUW9uajlTaUs2elA1NXZzVzJjOXJWNnVLOHZ3?=
 =?utf-8?B?ckNvZ1AwTldocUtGMFJyZ1hwSFh3aVFIQWpyV3RobXMwZzlnLyt3RzdOcGtU?=
 =?utf-8?B?RkRDdnVvNXdJMFJ5b1dhSzgrMmZ6NmNQSTF6Nm0wWkJ4azMzbHV3ejlQa1BU?=
 =?utf-8?B?clh5RS9KRVJUVkdyWGcvRUtjVkZ1cHdLaldvZDdIVldmaTVEY0FlNlhxRnRD?=
 =?utf-8?B?SWFRalkydUJtcU0vYU9iWTdsOGt2MXh6Z1FDeUF5TDhodlNGZEhtRmJDRTR6?=
 =?utf-8?B?QXU2dE1oMmIzUS9GOEdtMGJMb29xbytndDR3ZHRFTzJMT3BNNUt4N3IxbldM?=
 =?utf-8?B?VEFiMVY2WmZSdGp6RjhUZnlLUGUweDk1NkVJcWdOVW43SDJTcmRyQkR4Qko4?=
 =?utf-8?B?OGpNS2NqellzZHhGRjJWUjlwQ1RvWmN2eU4zajh3bUtBVVBKY2FjWDNpc1Rn?=
 =?utf-8?B?WVR6VFN4YmZVOURlTEtpVlV1STRtT2lBcUVMZnVYdFBTUm43ck0xQ1hkVkRu?=
 =?utf-8?B?WEwvZjRDUndtTzh3Y0NNQjFvUFBKSEd6bDgxRmtQVk1FUXIvUStXeU1NbGpC?=
 =?utf-8?B?UU1zRDhwS2djZEtUQXhQZE5LczR4SnFYa3lPMExNaG1kWjNiZnNnVEtEUlhu?=
 =?utf-8?B?NnU4T0xVY2pSS2pXN0gxYkdwcjR3ZWpLR2pFVFhhWnlVelptdVBwRFdlemhC?=
 =?utf-8?B?RTRrOUpTRSswNTRUemUvOFluOS9GdzBncXlJQ1pUSlhBNThSbG8rSEVqL1Bs?=
 =?utf-8?B?VUNwZWt5aHpjQ0tpa29Ua3FRTWtvajlBTE5XaUxqUnNEKyttMHI1djlHUDRl?=
 =?utf-8?B?eHV4Uk0wUGx3aEtVUHpMZEhMV2ZmNlYrcnpTaU1EcmlHeHRkZGR0Z2s3czBV?=
 =?utf-8?B?Q3FUb1d5OTd1SnQwV0RFRW5KcnJ1NXY0SWJOOGxGQzlRZStvZjVyekNGRU15?=
 =?utf-8?B?RDJKT3l2U3Q0TWM2TnhRWkZ1NzhyeTJCcXVtQXhDenhlRWk3ZGg4MDJNSi9T?=
 =?utf-8?B?cDJDUVBBNWNIc3kycTVHd0s1KytjM3phNmR1VjBXZHRvMmdBQWw0azNvdEFy?=
 =?utf-8?B?NUVzSW13UjB2VnB1aU9sNzFXemhhMWlyQ05UdG9wSkZEdm9ub011bndianBt?=
 =?utf-8?B?VzZjU09rVmsvWHpCT1N4NG0zdUoyaHNnTUpvR09BZXVJM2hoVHJoeVg0VnU4?=
 =?utf-8?B?YlpjQjliS204RXBkamJ3UkRTMW03REw3R2wwQlR6UldBdUlNR21EUjJkTlFT?=
 =?utf-8?B?eWdZc2NuRnNnNSt6aUFaRmtKMENZUm9zVFhTbkVoSCtmZ3lPWnEydGJhaThy?=
 =?utf-8?B?QTBZZ3YzM0VYOFpIU3QwY3BrUEtJa0VYd3hmcEdScWtNZnJvN25NR3lVQnVi?=
 =?utf-8?B?OEFOZ21oRmxVNWluZlh3V0lIdS9DSURncnlTdzlRRmFKUzVrai9TeTZzVFJB?=
 =?utf-8?B?eHNDanAyT081NWdPV0NNSnhuakhXaHEzT29wUTJMQk1BTVR3TXcvS0NIYWFE?=
 =?utf-8?B?cDN0UCtyQWVCRG5zZFVFS1dHMmUrSmxUTGVQK0ttRTJiTFlGVXlqTXNhNzRP?=
 =?utf-8?B?NFprYUVDNUdGRmV0dDBKSjBua2M4d2V5c0t5c3dZUSs4VkZNWHR0RFVKQldX?=
 =?utf-8?Q?GGyyF1LDUxIBS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmNIeVd4elhvK294akdWOEhuYUM1QUhIbVpqbDViQTIwYTU5TDhqOHJYZ01l?=
 =?utf-8?B?R3htc0t1cUg1dmxHMHZvK014UzZsN0gySkthZElwMUhMTnVQU3BwbTdRS2RR?=
 =?utf-8?B?aG4yVFZxUmY0cXFIQVZtaThCUEtIUFIzV1lPTGdSTVQvbWRNVC9QbW9OV0hE?=
 =?utf-8?B?cnY4bTVmck5oU05vSm4ranNJb2dLUC9MVXNocFkvMXVrek8xd1cxTm5rbFVv?=
 =?utf-8?B?ZENqU1E4b1hzU2o2aWlzN1NYME5RK1lKU1Rld2NiN2dTY1FDSEFJRmVXQUZQ?=
 =?utf-8?B?RDkzZlhMdm1RWHRaMnhJdUVIcHRlRDY5OHYyNE85WGRsZXcwWnhIQmVid2FZ?=
 =?utf-8?B?dGxaK1oycVI3T21zMWRuMWYvR2ZIZTc0Q0ZHWEJXRE1JRW84TnU0R3VtVVlR?=
 =?utf-8?B?TGlldWdIU29hdndVdUljMElCcVlnK2cwVzREU0xPQmxBOGg3RUZFZ095bWVu?=
 =?utf-8?B?WjRhMWdCMHNRRUdqZHYvRFFUME5YU0tCL0xLcUhyK1RFNitlcEZneENBaEFF?=
 =?utf-8?B?am15bmNEcllMb0RaK2E4ODE1TWM4a3Ywelgza2RGOExXMTBFdkVZOGdpM2li?=
 =?utf-8?B?Z2FOVWJSSXRrU0hMOVdkZmxkR3FCTUhGNEZNNE45V1F6dEpMR3gzY1R6NkZu?=
 =?utf-8?B?YnhKWUt3K0ljdUZMVVBwYmZLUENMYVFqTllUazJSNzFtaC9BaWNHeEZvZXBF?=
 =?utf-8?B?ODNPNW95T0xPRjNVSEU5dTgzZXBFa2Vob3ZFKzVjbnBkQ3JCUngzK1Q1Z1Vl?=
 =?utf-8?B?MHpKTjFobFQ3YXVaTGo5UkVCQTBqWk4yRDhkTVFHd1hrWHVjcHEyNTh2RjY0?=
 =?utf-8?B?QzZ2alpKendVcmIrRmpZTzVmYzdyV2dXb1FvYWtiZzNCNmwwK3duaHdRQ0JL?=
 =?utf-8?B?em5ORlFnN3JHZ2x6YmZkK2dLRFpCcnBQNXRiVmR2dVFjanZIQVhrYjdjbnRL?=
 =?utf-8?B?bmh4ekNPV0RnZlRWSnRmN0lSUjdGM2NHTUxybTlvM2hpY3g0TVRKV2NwN0Rs?=
 =?utf-8?B?STJLVDF3d3kyVnowanRKZzF5UENVWEdaUlorWVVkcWlMaEdySk5RWGpuSnlj?=
 =?utf-8?B?Z25FMmpDa3M0dFhTMWsybjJ6dk1zRE1TK2g2UWJ3bDJkYjJKeWhOR0NtZTdl?=
 =?utf-8?B?SEd6U1g4a0l1aXRMS3ZqRFo0WkUxR2tOaTVpUGFzUjVaTU9WY29IWVhPQ1V3?=
 =?utf-8?B?S1RIbGRwcmhHdkZ5cDVKWmNEZUgxYjlqTWVaYVJ4dmt0QktieThaLy94a0E5?=
 =?utf-8?B?SEFZSlJuaC93bE5KU3hqQXRHTWpMTFY5VDJoeUJrNi9Rdkk0VDhWcGNCWFFp?=
 =?utf-8?B?MStEdzZHY3ZQZUx0TVY5ZXdPbm5NSVZmWjJYaldxQzhnTFBySjRWTThOWS9X?=
 =?utf-8?B?aHFoREtJU2JaMmhKN3VES3orTHlscjVwcnAwZGhkb3ZCTmVRNllzUGplNWFn?=
 =?utf-8?B?NmtKSlBET0h5QXlKT3pyQ0FxeEJ3N0wydkFHQlRqYzZlRmkwekdUc3pYTWRO?=
 =?utf-8?B?cWdtaHRJMzZnRk9tYWdSVTJPbUNGcC8vUnpmRU9qMWtXTkl4MXIzZ25aM29R?=
 =?utf-8?B?eVF5NkpFTUpaK2dLRDZ3aU1WNVYrYVhQR1VDbXI5TUFsclFWVStRdktud0xI?=
 =?utf-8?B?N2IxM0FnL1FkeXJiUHBYV1JCZGI2aGl6YnpQOWszNnJDdHN0RkVpU1RlZlpS?=
 =?utf-8?B?MFg4bVJ1dDBLVzJ3dVoyVS9yNytSb01vK2hqQnFQYTBaOU5ELzVUaE1ZRDA1?=
 =?utf-8?B?SXpUZGZkRGZMSUx3TWRPN0NpMyswaU14UWJsa2FFeWNHL00wWlErKzhTaEJ6?=
 =?utf-8?B?NlhPS2Z3dkhIZnJGSUMzTC92Zi9JaWlSeXZ0bWJxRlJLMGtaMFVuUzhjWVp1?=
 =?utf-8?B?MFFzbnk5M0xkWWdocE1XQTJaYzNsMktUTUJXWCtKbXc5UG9hSCtBVVZlUlR5?=
 =?utf-8?B?RjhqVmpZWmpDV1RBaEVCSHJUWDhRUGVqelltY3h4d3NuS1NZZkdxRGt2clR2?=
 =?utf-8?B?RllPVWJtUjZIR09jenQzKzh1RkpQU1NGL0pwRnFWUWNzdmYrZ1kyanVMOGpI?=
 =?utf-8?B?bGdxVFUzVDhSSVRmZWVDWWI1MnRka1hlcTRBUC8vc0RLZFNpRnJtdzhrb3BN?=
 =?utf-8?Q?k18+/l59eAwpqqK3wQ3AKRaLm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9113894-f73c-4c18-ffd2-08dd3a4d6f71
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 18:57:21.4321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHgxsVeB5GoW66l3VbDBFYikdoa/rlzztBvl5nLuxhwlMVU8GDP6475/nvKSkpMSi6Ow0eCfWDm6x5y+9YzvmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667



On 1/21/2025 2:19 AM, David Hildenbrand wrote:
> On 16.01.25 18:42, Nathan Fontenot wrote:
> 
> Hi,
> 
>> Introduce the ability to manage SOFT RESERVED kernel resources prior to
>> these resources being  placed in the iomem resource tree. This provides
>> the ability for drivers to update SOFT RESERVED resources that intersect
>> with their memory resources.
>>
>> During boot, any resources marked as IORES_DESC_SOFT_RESERVED are placed
>> on the soft reserve resource tree. Once boot completes all resources
>> are placed on the iomem resource tree. This behavior is gated by a new
>> kernel option CONFIG_SOFT_RESERVED_MANAGED.
>>
> 
> I'm missing a bit of context here.
> 
> Why can't we flag these regions in the existing iomem tree, where they can be fixed up (even after boot?)?
> 
> Especially, what about deferred driver loading after boot? Why is that not a concern or why can we reliably handle everything "during boot" ?

That's a good question and one I should have addressed.

The goal is to prevent the dax driver from creating dax devices for soft reserve
resources prior to the soft reserve resources being updated for any intersecting
cxl regions.

During boot the dax hmem driver walks the iomem tree to save off a copy of all
soft reserve resources. The dax driver then later walks this copy to create
dax devices for the soft reserve regions. This occurs before the cxl drivers
load, create cxl regions, and update any intersecting soft reserve resources.

To prevent this the soft reserves are set aside on a separate list during boot
so that they can be updated (if needed) and later added to the iomem resource tree.
The dax driver is then notified of any soft reserves added to the iomem tree
so that it may consume them.

Hopefully that answers your question. I'll include this in the next version.

-Nathan

> 
>> As part of this update two new interfaces are added for management of
>> the SOFT RESERVED resources. The release_srmem_region_adjustable()
>> routine allows for removing pieces of SOFT RESERVED resources. The
>> the merge_srmem_resources() allows drivers to merge any remaining SOFT
>> RESERVED resources into the iomem resource tree once updatea are complete.
>>
>> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
> 

