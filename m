Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047AF185E46;
	Wed, 26 Jun 2024 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409906; cv=fail; b=OFAddAM8PQPY+R5fy6M0oGxYsBuV121XNlkD4lSjegxaQLY9nNSoyLb+o86AYC0JZDka/ut7C285fR8QBeaEVUWfqeLGazyeNRMQlEo7eaZhynShBPWCkbTClJf8C+9CnCGg0TrncObSy8B+77jaHKu2kgZ8KLQr90sfFsVhNao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409906; c=relaxed/simple;
	bh=ZZ1K2yT8+Lf5DszfUlUjNVMe4SwcvBfkkluj3Mx8OOk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A0/AQpeEANViaUdCj5/MZo2wEZIgFw/MWXswojI96CvLtX7FsqCggpk4lzHZCdj0GZhWreof9Tz8reYShL0O7x5Z0uaThpkO97s5mte6VKC/3mgU2F4Wadokm5EUleVWzBz/8IDN/CmrUqniE054NljYgjRiDjW7Atg/BgOXYoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nfflrSi1; arc=fail smtp.client-ip=40.107.100.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nfflrSi1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQFNWZlHEMSdcym/4594S4Zq1Utnryk0KmfbJxPCZI/CoXkBXGQzEpmN9jI2VDC5UOoqrKWYNo1k1ukV4rIK9PwVvb3Vp+goJZxDuegd0oLilT/GZ6xqK0A1QygGOzkbwBHh8RDU4zIe6vVV/3B83uTXr6mXT4EpQ24NlBQwHPL5EH3voaMEfD5nWZ77XgBX9LZUQn3EWtR3t6hRaonWulBMYSPc5+MUq+b6i7VzF13pMIAW61zEUW/5whbjrbCekix+fMV0NkK84jF5OVjNbo+ezmPUE/LseccGF/dUN7Fg9Pa2Bmp/jDhpYdQinNVQhqUe3lcy9DSVDXtL8Z6w2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tARQfs62cb1Byvjj1+otsc8R/OMbdd746LjEjrOhVHM=;
 b=NJ0egM+cLRYSJs/LJR7wA7ItroApGqke9quyL4oSu8UyUGZRcKnP7zfAUvns8e5Y582tg1eA41MJj8MaFcvctj/P8rYkbYAKEBro72g+B0sW2DJL0XJSztrXCNJiYD43W7ozN7ZeyfSuwuVQbLyqB9f5prOLOuDjMC0yr9Lo1Bw+WF+t6Y7jHbd/EHbV1OaGE6C44zH1wFTGH1ku/zK19sl5VfSRUbw4GT9FqD/Mch9uwT0Po/2d1OpndEGwaLg5b46AJNOXk8KfQ5X/pDNV0ezlaZyXeOWljl4Ymq6aP5XOSBIaLX7vrb4lgvfSBw4daDS0HkD2HVwSC02/QmXCrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tARQfs62cb1Byvjj1+otsc8R/OMbdd746LjEjrOhVHM=;
 b=nfflrSi1XbSCfFpD1Z/mCPiLyuli5/UzFTniJ52N9Exp2HLTcz7sbMioCFPhVshmTp0WWz6HissuPTTMmL6v9Eo0tukgZFEI7LLkAXOd0FdKtxex0G9Iuittiyruliso5Hf+0iLu7I4wowXLFb6aAnV3iO+5RRJVnvOezjTRkTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Wed, 26 Jun 2024 13:51:38 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 13:51:38 +0000
Message-ID: <cb1972a6-2bd5-4500-bd1a-518533be8191@amd.com>
Date: Wed, 26 Jun 2024 08:51:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/9] cxl/pci: Add atomic notifier callback for CXL
 PCIe port AER internal errors
Content-Language: en-US
To: "Li, Ming4" <ming4.li@intel.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 "Weiny, Ira" <ira.weiny@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
 "Jiang, Dave" <dave.jiang@intel.com>,
 "Schofield, Alison" <Alison.Schofield@intel.com>,
 "Verma, Vishal L" <vishal.l.verma@intel.com>,
 "jim.harris@samsung.com" <jim.harris@samsung.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "ardb@kernel.org" <ardb@kernel.org>,
 "sathyanarayanan.kuppuswamy@linux.intel.com"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
 "Robert.Richter@amd.com" <Robert.Richter@amd.com>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-8-terry.bowman@amd.com>
 <45270079-6aa2-4530-8649-87bd5765d74b@intel.com>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <45270079-6aa2-4530-8649-87bd5765d74b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:806:125::20) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: 104d7227-a7e2-4852-6eb4-08dc95e71983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|376012|1800799022|7416012|366014|921018;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2Y5RHdEZFUzWEVwQzY5OG51aWl0aW13azdwYnEzZml2VGo3TzBQZVZlVzQ0?=
 =?utf-8?B?QVJRcmsvaFczcnA3cUE3cldEQm1MZEJLSFRLOGlWcFBGbkk1YTM3eklsVVFm?=
 =?utf-8?B?aVVOVEYyL2FyRUp5UzJNYXIvTFZvYW9hMEx0QkNHT0YrWU9vSkMvNm11ZWEy?=
 =?utf-8?B?UXlxcE1rYVNXaFc2dVd5NVdRMUU1VW9MdXUzWU44ZkdqejMxYXozbkNocGxz?=
 =?utf-8?B?KzhwNjBSUW1JdU5WcDNwWVgvc3dGNVpoQXdvWEh2WTV2WGpRN1hDelhUM3py?=
 =?utf-8?B?WTgwZzU2SnIvd3ZOUXBqRGtWbkJHUUtLQVRPVUE3NHhpcHRacmpQS2V5TE45?=
 =?utf-8?B?YXQrRlR3QWpHZTlrcXBLRW1FT0NWdGVvMzI2ZytUbmRKL0xJVXpHVXBFZGFU?=
 =?utf-8?B?T0RFYW1EcDAzVDhQdkdDQ01TVzJGN2Z3WklxczB2V1o1THhPQ25vRU9FcUxm?=
 =?utf-8?B?RC95NHpjN3R6dmVvQkJOQVY4cEUrbzlNNktYYVdqNlB0OC96Zk1lb2p2WVpZ?=
 =?utf-8?B?RnpCeUNETjJrZXZlY2lGaFJlZEhieGpwRXh0MkpDOS92ZWZqdnF1cUc3aVJp?=
 =?utf-8?B?c0FYUUZyMEhXVnRJcGNHeDJrSW1SVk1xb2x0UVMzTHMyR21kRU1yVEhGWVpq?=
 =?utf-8?B?aWYxcU9nbkUxbUpQTXptYzJmWkpxNzhqSjZzdW42VGNWemVQdllUaDFMbk9x?=
 =?utf-8?B?WkRSMDlrS3ozY3pNV1h4a1hqa3lSTVF6Q1VjYS9GdXRYNDJEc0FZSWpsd09I?=
 =?utf-8?B?czBUQlEvN1ZJcnlPRUZsWnlHL3BibUUrLzN3ckdpaUpvc28zWHd6TWZzYSt1?=
 =?utf-8?B?ZUNrZWZaSVpaL1lVcXRIUHNDeThSTEZBVnpoNWI3NUxXR2xuQ2E2aXkwbSt2?=
 =?utf-8?B?SWZQYjd1NHB0KzZvM0RVVEdhKzZ0ZDYvbkNQOHpVZnhBcFFBM05lbGlhZjFj?=
 =?utf-8?B?d003aWFQQlJUeDVnZ2pHaHo3Vm9uZ2l6U0NIRjIzZXRXNTNhR2dqQjBQRlN4?=
 =?utf-8?B?QTV0ZEo2RjV6c3YvcE1oNTlvbHRRYkdGTHhLSno5OFRpMkZhTlVlVFFCMWxk?=
 =?utf-8?B?R3ZBMGlRd2Z1NEJBUHM1djVrc3F0UE5sM3FKN3IzOXErWFg4d3luWk55cU9y?=
 =?utf-8?B?cGRUWmxJY1RNSmUvbFdXeHVNRGhnT1h0OG1jU0pZYXNGN01UdlRTMWFyTzYy?=
 =?utf-8?B?NUUxWHBsTnZWU281Z2MrUUhDUlYya1l6YnptWkM4K1p0LzE1UVl4VjUwcUwy?=
 =?utf-8?B?bWhaRjFSbWdmZXJiNVYyZWx1dUY3NnRaaldKRDNGbkNoL2xOTnR3dHNUbWo2?=
 =?utf-8?B?RnEzbnVGYWJnSE9jM0hubzhiNEJNTkVMdGU2Y0RtYmNwcTMvUVBzZDdzL2RR?=
 =?utf-8?B?YnNYNitCeU9ZUGkwWEFVYjN6L1RXeWJtVlQyang1WnNaMmg5RDZtNGdwLyts?=
 =?utf-8?B?SXdodlNYNHFIMFRVZ3JNUDhLRjlsMkVyR0lBS3FLUGFRREpnNzA5SmZRVmtK?=
 =?utf-8?B?a1NzclYzYVoxOFB5cWhteW5NUExZRTVNVjRhSkdPMTgyTGZZdHp3dEN2aHkz?=
 =?utf-8?B?Slh3cXpvZW8wSnhIcXNRVXBSUkNIRHRHV0hPbVlzeTNVNnRiOGNybCt0OUY1?=
 =?utf-8?B?ZFFzczhpZzRhZXg1d0d6R01SY3c1S1RjYkpPbUsrM1d2eThCZXNVQVRFNTdD?=
 =?utf-8?B?elJDNSt4Z040NU5wWUhZcCtqTDh6andTakhiWTE2RlRtb1RyRjVYK2VIMXRP?=
 =?utf-8?B?YXNGN091dTR1WTM4ZHhPRzZPR0NENk9GS1R2cmhySXdoUHQ5RFhmYmxFUjVq?=
 =?utf-8?B?YW1Ra3Z2eGdNVDhjUG1YTFBZSnFPWjQzNnJBelpwSDdjVXNqQ0tFYmN0d1B3?=
 =?utf-8?Q?o1sUWeeVaa7gO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(376012)(1800799022)(7416012)(366014)(921018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dG5OTkhyanNuY1RTTldDK2FCWHlHZnJwcHEwYmZOSFFneHB0WkIwZVVXMzE1?=
 =?utf-8?B?NUcvbU9lcDU4RlFxckVmVlQ0MmQyb2twM0VtMUYxUWRZR25uMHJIbWhKUEJP?=
 =?utf-8?B?Z2pYUTVFNmhSVUJkWE1XWkgvRTlKYTlIOUxVaUlPOStpSmo3YkNQZlY5U2pZ?=
 =?utf-8?B?ZkNzcEpTOVNTc3U5dmZhcWsyRTlKMit3UzFWRUdEbnhrUG5HRFdXWXdOMHRm?=
 =?utf-8?B?RUlaUldGVXBxV05oblZDVThmZUVWeGFwYm5WWHk3QUZuK0RlNnVlREU2Q2JE?=
 =?utf-8?B?MWQreWJzTzgvT2dFdW5rWjVDVDJwaU42YkpkRWFBRWZuRTVkSjdackdSV0F3?=
 =?utf-8?B?VWNkVWJ1K2VCczRhOGtSZnRta3B5Rlg4anhZcnhNalVTdjk1UzlQTWNqMm5u?=
 =?utf-8?B?aGw3aGlZZSt5Nk9lWmdQd1pZNXgvNFJqcEMxRmVPYW1CZjJvRUZkYlI5ZVhS?=
 =?utf-8?B?amROYThFOFRDNkJFYlp3ZlE3ekk4QXhjU3g4UGlDdU5lMDdBOGpKMFZjdG1J?=
 =?utf-8?B?bEVJSVhrdE9yVGQ3M0o2ejJ5MTMrQThaeW54VlVaWk8wYnpUeElwYXcrOVZ6?=
 =?utf-8?B?WXZtWmtLTEhZOUZOaGdlREEwUTRUbHJGQnd2WFlXdXM5MGlKaDZBc0JMN1RZ?=
 =?utf-8?B?NXNLV0E1OURjajNJQjk2dkc1a3ZGTTU2S29MWUQzZHFtNE1LMzJJd2Z6MnZI?=
 =?utf-8?B?dmVqZUxJc1RhTW5mdm9GVDE5UTQwSCsxdnR4bUhhOE1UMWhyZzYwZWE1bEgz?=
 =?utf-8?B?WnJSWThCdnYvSzBpa25FTHh2ZEtUZ0FMdkpZeCs5VTNBbUg0bk1DVmRiM01j?=
 =?utf-8?B?c0VxQUUvN25iNCtVMm10Q0pwRUpOVnhzWXh4TTd2VjZIY2tWMVpxUkFwV2w4?=
 =?utf-8?B?dHQwQ2RJM05Pcm9KSGxyMEYrVVJ2eW9HSUx6T1NWT2FlQWlYNDlIYzltOGto?=
 =?utf-8?B?VlJPeHc3eVRadms5KzJJSmFaZkxzVUw0dThXUFYwM3NhVDlSZ1NPb2dRQjBN?=
 =?utf-8?B?MnhaQkc3L0YxamxQZG84bnZMVURKUTJjR2NvNzE3ZVJYZXBlRFRhSFI4RU9H?=
 =?utf-8?B?SFRDZFpNZ29YVkFQVmJDNXpIa1RyTzFVSThLRC9STnZKbEg1aXFsbFdVZ0th?=
 =?utf-8?B?V2dudlUvMEZGdGNKeGRUYWJaSGNjR0hnWHRoMlNKWlNrWmd0TElqcThJbnp3?=
 =?utf-8?B?ZmwrNDV5TFZCTFg3Y3UxWmJEbGV1UEp3VlJKYlVxNk9XV0pSSTRtVERtdkxM?=
 =?utf-8?B?RWlVTW4xRWZKNHZDdFQyeVgxQTlnUVNEcE9rNzNKQUl4cVFBbE92SXgzL0Iy?=
 =?utf-8?B?eml0dER1a08zRjI0akRJK3hSWmRFdSt2bnYrZFdEcTJ1WDYvOVRqc1pFNVhF?=
 =?utf-8?B?aFBIUzlHeWZlOXVaWjQxaDQvN0JPQUttcUxid3V0M0xyVWwrWkt1a0VlVGRv?=
 =?utf-8?B?dStGYU54R2RUYTAxTmJBcGRSWTJiS2MvcmxnR3diaisrOVhKN1NpR3lDWG96?=
 =?utf-8?B?TWwwZFJaVXM5OGhNek5NbnFBc3l1dzNPU2NGNHVIemU4QmNOSzlkYVhiUmgr?=
 =?utf-8?B?TTVON1dKaXQ3aEZodUFhdnVqalBzSnlkMXp5SzVwRld0M3JLV0FYcUNGQ2RL?=
 =?utf-8?B?OFpSbmNnYy9hcmEwalI1ekVaNDkwNEl0L2N1U3pHMlE1WUE2bUdKZHVDYU5I?=
 =?utf-8?B?aTNWTzUxTGpXTWhBbXoza2JwUjYzc0RKN0VUcHBoVlFWZGFRS3k5allTc3R3?=
 =?utf-8?B?L3d0VTRzSEF0Mmh4cllRSnVvRHFMTXpwNHlja1hsRnhjNktVK1NZTmtpS3g2?=
 =?utf-8?B?MjJLY2NTd2p2VUFJMUxrSTZPazYxZ0FIT2ZNaVB0M0dvN0Z3bVFQdXJyeVcx?=
 =?utf-8?B?dWxhaC9YdlJ0RnBQV3dFS2M2dm11dHJ6UXNiNWhXbmFQOTk5NGs0eXFDanUy?=
 =?utf-8?B?M0pjbi9UZmRtZENDQ2U4cHVHU2dxNHRPelJuR2JqSUZUcExZWGdSUngzUFEv?=
 =?utf-8?B?Z08raTlBNmU4cHFMSEVCZ0xCUXhVUitpeDhwS3ZubTRJM1hLUkwwWjR2QjVn?=
 =?utf-8?B?USthM3M3K3NvTnlLRjZlbGFZdGN1WFpzUDYyWDN1TlRIRlpHN3UyZHUvei9E?=
 =?utf-8?Q?DiXXqYdE8gIPTQUA5B+0LoESL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104d7227-a7e2-4852-6eb4-08dc95e71983
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 13:51:37.9087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bo8uZSv0bkqIOYpVhB+smIXSeanI9THVXJvKmIEv+fj8Ftv7AIC6kF4QfD6Inl1MzcEQSQItyI15zsjz8xruFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425



On 6/26/24 01:22, Li, Ming4 wrote:
> On 6/18/2024 4:04 AM, Terry Bowman wrote:
>> CXL root ports, CXL downstream switch ports, and CXL upstream switch
>> ports are bound to the PCIe port bus driver, portdrv. portdrv provides
>> an atomic notifier chain for reporting PCIe port device AER
>> correctable internal errors (CIE) and AER uncorrectable internal
>> errors (UIE).
>>
>> CXL PCIe port devices use AER CIE/UIE to report CXL RAS.[1]
>>
>> Add a cxl_pci atomic notification callback for handling the portdrv's
>> AER UIE/CIE notifications.
>>
>> Register the atomic notification callback in the cxl_pci module's
>> load. Unregister the callback in the cxl_pci driver's unload.
>>
>> Implement the callback to check if the device parameter is a valid
>> CXL PCIe port. If it is valid then make the notification callback call
>> __cxl_handle_cor_ras() or __cxl_handle_ras() depending on the AER
>> type.
>>
>> [1] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>>              Upstream Switch Ports
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/core.h |  4 ++
>>  drivers/cxl/core/pci.c  | 97 ++++++++++++++++++++++++++++++++++++++---
>>  drivers/cxl/core/port.c |  6 +--
>>  drivers/cxl/cxl.h       |  5 +++
>>  drivers/cxl/cxlpci.h    |  2 +
>>  drivers/cxl/pci.c       | 19 +++++++-
>>  6 files changed, 123 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index bc5a95665aa0..69bef1db6ee0 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -94,4 +94,8 @@ int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
>>  				       enum access_coordinate_class access);
>>  bool cxl_need_node_perf_attrs_update(int nid);
>>  
>> +struct cxl_dport *find_dport(struct cxl_port *port, int id);
>> +struct cxl_port *find_cxl_port(struct device *dport_dev,
>> +			       struct cxl_dport **dport);
>> +
>>  #endif /* __CXL_CORE_H__ */
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 59a317ab84bb..e630eccb733d 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -689,7 +689,6 @@ EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>>  static void __cxl_handle_cor_ras(struct device *dev,
>>  				 void __iomem *ras_base)
>>  {
>> -	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>  	void __iomem *addr;
>>  	u32 status;
>>  
>> @@ -698,10 +697,17 @@ static void __cxl_handle_cor_ras(struct device *dev,
>>  
>>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>>  	status = readl(addr);
>> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> +
>> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
>> +		return;
>> +
>> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> +	if (is_cxl_memdev(dev)) {
>> +		struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>> +
>>  		trace_cxl_aer_correctable_error(cxlmd, status);
>> -	}
>> +	} else if (dev_is_pci(dev))
>> +		trace_cxl_port_aer_correctable_error(dev, status);
>>  }
>>  
>>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
>> @@ -733,7 +739,6 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>>  static bool __cxl_handle_ras(struct device *dev,
>>  			     void __iomem *ras_base)
>>  {
>> -	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>>  	void __iomem *addr;
>>  	u32 status;
>> @@ -759,7 +764,13 @@ static bool __cxl_handle_ras(struct device *dev,
>>  	}
>>  
>>  	header_log_copy(ras_base, hl);
>> -	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
>> +	if (is_cxl_memdev(dev)) {
>> +		struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>> +
>> +		trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
>> +	} else if (dev_is_pci(dev))
>> +		trace_cxl_port_aer_uncorrectable_error(dev, status);
>> +
>>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>>  
>>  	return true;
>> @@ -882,6 +893,80 @@ static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>>  	return __cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
>>  }
>>  
>> +static int match_uport(struct device *dev, void *data)
>> +{
>> +	struct device *uport_dev = (struct device *)data;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_cxl_port(dev))
>> +		return 0;
>> +
>> +	port = to_cxl_port(dev);
>> +
>> +	return (port->uport_dev == uport_dev);
>> +}
>> +
>> +static struct cxl_port *pci_to_cxl_uport(struct pci_dev *pdev)
>> +{
>> +	struct cxl_dport *dport;
>> +	struct device *port_dev;
>> +	struct cxl_port *port;
>> +
>> +	port = find_cxl_port(pdev->dev.parent, &dport);
>> +	if (!port)
>> +		return NULL;
>> +	put_device(&port->dev);
>> +
>> +	port_dev = device_find_child(&port->dev, &pdev->dev, match_uport);
>> +	if (!port_dev)
>> +		return NULL;
> 
>  seems like just a bus_find_device(&cxl_bus_type, NULL, &pdev->dev, match_uport) can replace these find_cxl_port() and device_find_child().
> 
> 

That would be a good improvement/optimization. I'll look into making that change.

>> +	put_device(port_dev);
>> +
>> +	port = to_cxl_port(port_dev);
>> +
>> +	return port;
>> +}
>> +
>> +static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev)
>> +{
>> +	void __iomem *ras_base = NULL;
>> +
>> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
>> +		struct cxl_dport *dport;
>> +
>> +		find_cxl_port(&pdev->dev, &dport);
>> +		ras_base = dport ? dport->regs.ras : NULL;
> 
> Need put_device(&port->dev) after find_cxl_port(), use scope-based resource management __free() here should be better.
> 
> 

Thanks.

Regards,
Terry
