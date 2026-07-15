Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2E93451B5;
	Wed, 15 Jul 2026 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126831; cv=fail; b=YhnY7QyWbkxne9gTN+bVtLq1+88cbKDWjvkGVGEp8x44CSEGe+XMGnC+pTJo576VXZZeRaPPzUJSdINA5ZxqBAzUYgfFoGl1WbHRb9xgWoEQLgRXw142y5m4vOfolcs++Eyxh7S27gQTdxFOKn23PONHVlWjQGLzf3b2fH6RiT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126831; c=relaxed/simple;
	bh=LXXKu+arqesRgP4z7xxMD0cun8txrjc1FBg33NA+9lk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AtZUazAfucjPZM2oYkPK1httbxTrIriWMfMkPHJ9Qf8OrhLJBprl0pCPt3UAtmPUMLFLUE+Wpr1FAH229kkZrDtPQz+MBn7qQwu4MWDm3PYi0xOPGUEslIRkgbBYMivi5KaDrzR3yfLrcjXntbPU/xquI3217j9AyuI9gLKMRhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sY8qasVx; arc=fail smtp.client-ip=52.101.53.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sY8qasVx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1nwzFTe3Sg/D6EzLMHIEU7KYs+3ARy+Q/8SDPZxfwcBSVIdFpT5DMwDYI+rx+ymXd/7LrSUTmCJOGjdzS5jxeh0PvJWh/kc8shAQYufke7hPAQQaN61H9SajQWKzlU9JZGELnCHPdmjn76Ya7NQ5JV2IfEE6IC06/2ClfaqEncmhnTovn+Mpjuq+w8Srs6cSFOl/dgcD3/LKUc5fzUhkOveB8jTs+DsdUhDY7cYFv1v7NWzgXEMU5h9vf+e+cbv04OC2CPW8US71va2ElMhv98p3RoOqSQvFWGJApTpIVLhjhPZ8CSZpIXOfnQp9UVy0p8EYeoOAgn4hpqT8Td9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkOW/8pwcTFBmd2seS7c9RGsHzo2iaW1OeP11nvNv0I=;
 b=azDkfy4DP0gtGKYaogvvuoKmdnMxE/Eavhn52nYVvlKaO5+6lrqpp5sEEWl49+M51Zt4BN+tpdlP+xKB1jJtoPjPMCOAK4hHYTAy+ChObNdALbFfpbXL9SW6dGwldmsJEG0k+WS7u3PliKyQiMiOmW6uej2raUpimaGqYPg1AZuDkup8dEwNKiGwi0l0Vqfx++Vl4uDUwxIikV7OvD00l/cM65fNtqY0HnWjeEEUnLGSNvWG4KRHnUL10+I4dKqTHolxMfZgtXEFPoKnw2LmBZddaNLXvSIz+KJmIwG2wK8ZDq73EDCIlCdPzylvGr5hCYkiXhBWllc+92Jq4O6Wgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkOW/8pwcTFBmd2seS7c9RGsHzo2iaW1OeP11nvNv0I=;
 b=sY8qasVxPcOedm8zwZ5PWozWZ9ARBq6ZAkp0zarZz1H9qjNlGcqNTa2XS0IMt5ETvcwKC38d/GXGU98jwo6m3ardrsfbfSjDnjrAGPg1uO7saZ7qxN7LCbJSFbpVkBGVdo8Zt2So7L1wJnWXOCeu/PxfFLFTZMYyS2De7V+eNmo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.10; Wed, 15 Jul 2026 14:47:04 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 14:47:04 +0000
Message-ID: <686006af-a9cf-41e0-b245-e81a722b13f3@amd.com>
Date: Wed, 15 Jul 2026 15:47:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] acpi/hmat: preserve hmat_adist_nb notifier
 block
Content-Language: en-US
To: Richard Cheng <icheng@nvidia.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, rafael@kernel.org
References: <20260630143507.30193-1-alejandro.lucero-palau@amd.com>
 <20260630143507.30193-2-alejandro.lucero-palau@amd.com>
 <akYPrcsz2tWl7ga4@MWDK4CY14F> <c88a09b4-6478-4c68-87f0-485dc6634af2@amd.com>
 <ak74Kzuf6g9z9pOr@MWDK4CY14F>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <ak74Kzuf6g9z9pOr@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0179.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::7) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 7500ce90-9d8c-4a47-23f4-08dee27fef8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10067099003|22082099003|18002099003|6133799003|4143699003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	u7EmTkPTouD4/DCoMZt8yxaxv1ccyQ/HMDFb6vjHZK+ikL0ZEUop0sxhUruMvDZdT9TlUc/+ARU9HbVnac96rLVbWgrAM7qT2DuxmMQakRkRE7u6vsI0o1to4f5rMa+rAZc946cKsQMTfqxc9scwhCXv4UIBo337gErrOLI5ymn0fYaGZXTNf2hdU3XjH8nkqW7pmpv7YkDIpeILX7gk93tXjnYDB277PDTY7VSaYJEH5EBmKJiLBIz1aGkKmqqbNykHpxEvPEPbaNNQhPE155yf0kItykQf/7mQOFvGtR7gdhROnM0GkDn5NPZo0n3JQ+MKd96HZmgSlOtAhS3aSaXR7SUgSPN4mcUIHYV6QXhaqdM6zeiDz11Iov5ABBrKzrAHVLfMJohfi1jIwrxT5U5A+JJIfRn3u/kKIicSOScrXmPQacRJbtB96XV0ip97vEnRJ00mPHnufE/x3PpTudXMcoejwHUKP9JZocT3TYtyKZNQmD2wTIz3YL0z24FmkyzfVgI4TgRmtgKmkQUA9xFhivv8SupW1BhEayho3jUbTXTl/0+vd0bw386tymHEFRH0JWGNXZule2PeuccAbMuKGFFxPPORGrHdkO6mJWCDNl1fD9vb03QmJf8M4G1or/RovCO/U7NJybgYQf4BDJ6FPgQpRNraq2748sEha2k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(6133799003)(4143699003)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1BCVmxJQkJwa3cwbkJPZEl4cklRU3VCb1oyZ3EzbjBtOXBScHJZNWZnZmxM?=
 =?utf-8?B?Y3VUOW8vY2lFb2JTWE94Z1dDdmg4YWVBeThFTktiTU9qV1JzaGtaLzVLNWh6?=
 =?utf-8?B?V3hReERJRDdyaFpqemhFdHZvek11RVZwTzhKUnVnRlRmK2J1VXFhcGVvQXdp?=
 =?utf-8?B?N3Z2YVRYTXhFbldPOXNtRGpwZjFLazBxSmhFZ042VzZUWnROeVEyZm15MDFk?=
 =?utf-8?B?OWtCVEc3WG5EekYzVkQ4RTFUa3h6cTBQV3N2Y29MZGJyYjhuUTIrbWZmTlhH?=
 =?utf-8?B?UWFlc1ZjMnIrOFZ3Qy9JdjZoR1p2VnpTbVRzSWFDL3NaNkdENldoQnc4YlYz?=
 =?utf-8?B?RnJpeUlnMFluY2N2M2pIaVNJNGtrdjlCTTFUVk4zTHNabHVSQzU5eWwzZlVy?=
 =?utf-8?B?Q01tRFN0dkJVbWk2VTRRVlRKRGw5QjVUUDhSM3p1bThMdERTeGl3V3FDQkFZ?=
 =?utf-8?B?WWJTamowNkNqeTRVNCtrYlhubUZ3NmRCd01WL1Rzd0xubGx3aGFEbWJTSGZK?=
 =?utf-8?B?NFZSdGRLc2RaZy9XVGJUZFBORWs3VGxTaXlaWDBlZklCUTRwQml2SkEyaUV0?=
 =?utf-8?B?UXNpdFNYYmY0OEZIdUpuK2NpM3BUQVQ5Qit5aEw2MjJucE0wOU5PTXRVVWJS?=
 =?utf-8?B?cWZGQzFXL1dDUFJjeTUwbVFFWTVteDVtL3hDN2lOUlVvN1k3SmRUdDg2QkF4?=
 =?utf-8?B?RXNjTlZ0L1Nva29UbzN2WHNxeDJWb1d3bjVGS1hWYWpnN01wYlVNRHREeUY3?=
 =?utf-8?B?OEhMUERCYXBlbkx3RmhtZzR4THNuVmRoNDcxa3JNWWQ1MnR3L2d1dTJhUEkx?=
 =?utf-8?B?SnprWkduMTg4VEJ0V25IdnZkMlExY0gyWS9KSFNqbWdTYkM0TkZuRENhV25x?=
 =?utf-8?B?QytqZEhlcUxOYlExYWZMdmZ3ajNkN1RqK0hmcDJ3RnMzYzNvMGFYSFJRS3Zs?=
 =?utf-8?B?Uno4YjZRcThLNWtKTUl5Q091VmUzRlN2Wk5hV0RDMDk0KzdYOTQxaDVNSmx2?=
 =?utf-8?B?bUZYRTA1VTN6R2RUWnhOSnMyS3dIcDRVYUpkSW11VCtYS054Z2pJSGhRVVNk?=
 =?utf-8?B?Y3Z6N2pxUFM3dDZtcjNrRzdoQW5VNm5ySmtOSElBR1ltUWpES2pGcDNuWEkx?=
 =?utf-8?B?VDhoeHlwcXFCeUtmSlU4eEIrNzFOYnlmVUZrSUVBWEV5R0Flem83TUgwYVIy?=
 =?utf-8?B?MXB1aFlIc2VxQzA1WUJzaXppNG9RRHR5aGMzdkV6WHNKWDNWVHVrT3BmNndy?=
 =?utf-8?B?REVFYUh5MjlSRG1obTJ5WG53dVZHQjV6cEF0MjdoeW83bmpxdUp1dnJnbkZT?=
 =?utf-8?B?aTJUa3Q2R0dBZ002eFZmbUtVZThaL1dWSDdNMngzYnBZNWhCYVFIY2xpeDBv?=
 =?utf-8?B?MTRRZVNzMnhwUEx4OUNrK1VLaGRNdWh3OXlXRFNNVE4wMlQ2OFBTU2lVVDdu?=
 =?utf-8?B?Szc0c0VQSFEzeG81aVN1TkZ6dlAxWlp5Y1pDYWJtMG9CQTJmbmo3bmh6ZFVo?=
 =?utf-8?B?R0d4V0hHaW9aYm1lTUo4Q0FoWDhEc1FycU1HVWpPbk85RmZLMXBkVWdXYXpZ?=
 =?utf-8?B?dzV3M0I4MVZRTGlCMHE3eVErYkhHTzIrN2tCM2plNXcvazlQNjY0RWNMT0VV?=
 =?utf-8?B?ZFpKenlVWThrVjczVXV2QUJCZDRVaWUvZENNR2hZNkhwMmJyMXRxaDBBNzdJ?=
 =?utf-8?B?OVlKWUxxUWRuU2lRZG5WUEtyc2NDcCs0N2MrN2NNZjJ1Z1F1U1VqYnVtR01p?=
 =?utf-8?B?N2xkSUlIbFlYbjNjR2tZemRLTmNVb2NmQ1ZFT014QVUxcVlCSUNtTGUwMUpN?=
 =?utf-8?B?V1l3Q2VFcE5XRDV1RDhoOFg3eG5sS1lTa0FmZXoybjBvbTJQdE56MEpoNkwz?=
 =?utf-8?B?OElMaGNiZ3FWUGxITllka0hPUGJhNEJYdkxpSnR3L1I0Y2hjM0JPVVVLcVRM?=
 =?utf-8?B?dGdKQjRxeHFSenVvOS9WaFk1VHFTOHZLNmk0MEZPY2plOEhmRENLcFNoVTRS?=
 =?utf-8?B?MTNoYTJvaTN4RWtTRDJlWmo4cTJuNXh6YitGcGRDMTk3S0xTNjBPbnBubVhq?=
 =?utf-8?B?a3BGWEpoSU8xYUNjekVTZTJ4L1BKalZoSXZld0NKd1Era2gzTzIvbENZa0ZE?=
 =?utf-8?B?NTVHMThWd0xGdmhHNWpsM2MzRlVDQXFNM0wwWWV3N0p0SHpvY0oxblRWNENL?=
 =?utf-8?B?WHVGSzhUa3BKNXQwZnhpNGJuZVc4NGxXVlNIaC93YXlkdHRUaTgyRmVVbGNv?=
 =?utf-8?B?alRid3E3SktPOHRRRjdyZ2FLYkpsdGxFWm9xaTF5SHlMQlN5Q2FkdWthZTFn?=
 =?utf-8?B?UlU3T1RocS9kREExT2c1eC81MnUvNDJDQ0ZzZHh5NGlxMThocHBvUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7500ce90-9d8c-4a47-23f4-08dee27fef8e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:47:04.4159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88OVcCGhZCLRmNOn0uKGjAVh2HpfXGi9PqEtWdn8il1UEda515T4Iuuv2A26vSAr4ssxw5lhMQk1gfCR0V9Z1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194


On 7/9/26 02:37, Richard Cheng wrote:
> On Mon, Jul 06, 2026 at 07:57:09AM +0800, Alejandro Lucero Palau wrote:
>> On 7/2/26 08:20, Richard Cheng wrote:
>>> On Tue, Jun 30, 2026 at 03:35:07PM +0800, alejandro.lucero-palau@amd.com wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Remove __meminitdata from hmat_adist_nb declaration preserving it even
>>>> when CONFIG_MEMORY_HOTPLUG is not set. Otherwise further notifier
>>>> registrations using register_mt_adistance_algorithm() will find a
>>>> notifier chain likely corrupted. This is the case when a CXL Type2
>>>> driver will load after kernel initialization and a CXL region created from
>>>> its committed HDM decoders registers an mt_adistance_algorithm notifier.
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>


<snip>


>>>>
>>>> Not sure what you mean here. The way I understand your comment leads to
>>>> contradictions ...
>>>>
>>>>
>>>> "keep unconditional removal" suggest to me unregistering hmat_adist_nb but
>>>> "keep" confuses me as it is not unregister now only memory released based on
>>>> __meminitdata ... but maybe you mean exactly what I did and avoid any change
>>>> to __meminitdata declaration based on a config attribute, what is what Dave
>>>> is suggesting to explore.
>>>>
>>>>
>>>> Please, could you clarify this?
>>>>
> Sorry for the ambiguity, and yes, the last reading is what I meant.
> I mean your patch's removal of the "__meminitdata", not unregistering
> the notifier.
> I think it would be better not to replace it with a conditional macro.
>
> To be more clear about what I understand,
> 1. with MEMORY_HOTPLUG=n, "__meminitdata == __initdata", so hmat_adist_nb
>     lives in ".init.data"
> 2. hmat_init() registers it, the mt_adistance_algorithms chain will hold a pointer to it, nothing ever unregister it.
> 3. When boot finishes, free_initmem() discards all ".init.data". The chain still points at that freed memory.
> 4. Any later register_mt_adistance_algorithm() call walks the chain and deref that stale pointer , causing use-after-free
>
> Note that, register_mt_adistance_algorithm() is an exported API, so any module
> loaded at runtime can trigger it, not only CXL. Dropping __meminitdata
> unconditionally closes the use-after-free for all caller, and the cost is just
> one notifier_block staying resident.
>
> Hope this clarify my point.


Hi Richard,


Yes, this is clear now.


I will send a v2 adding the Fixes tag and your point about the problem 
not limited to MEMORY_HOTPLUG config.


Thanks!


