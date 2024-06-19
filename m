Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDB5157A67
	for <linux-cxl@vger.kernel.org>; Wed, 19 Jun 2024 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812974; cv=fail; b=gm80zVLM3E1Y9BFUE3/Kg5HXMVbr93m+ZeXoo04XXf1TNlsH9oxPVNTGDW6uvf/+gpxrxS0YtdaRKkfEKcrl2vdCMRA7ErLJ7hOsIjpkl+KUc2g1S4e2u0M2QNsIW99j8Xqab9XecqJDWNQSOJ0E8kI38N+am6wbnj63YyzZ8+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812974; c=relaxed/simple;
	bh=iwuf5gJRM1aSovfLe8y2IQiWm8D/tGehaJIfsuJLSTg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lXa0M+J3pBMHdUWhPQhRSQ0Uyc8Fj420z3JAwhGrhXhFS5uYIQwpbMvQfdI80vN/kzdqN7C6/LauEv99tIVjwRtTl167rFZruGroNhjlW2OSfJig88TRrUoWBxQsuHiGPsawl0sylFHG8aaAoynqQb/T3JDRJ8wjMxbEb1VUozM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2vh77qK1; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2vh77qK1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8ovvQHtvkEwwA6/6x07bM0318WpOtfEA+xiMmO0KfecTd0ka+QJtKDsY4biYJIPXMOx1BpJkcsNGSDMqETm9Mos22jGXO5xPjW/eUsEDPot6S330BaGmVP8vro16IxQjszTUsPFN4Yr+9x7o02W+uNruJIJPKtzDtOVdGdP6DRF8c3Bh6OyglyLfF6JoiYZy90LvlroVzZGgsNfjPb0ROie9Ph7VoLvBGBQiqYhCvq2daGl35Yc852hA4heVeW7zXG21rVGFL8Xs3L73whyGCDywjQkTfo7YupUfdMyodghnIh6flcTinKKB2x0HMjBc+z//YvN5jgmBMBBVsQowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n20jQ1/rAdIwjEXTxNFOhFfASYMCqVRFGag1gt3PliU=;
 b=Nhz6b+WOj5ojG8kVFABMFwrltYQysjZsCuIUxNoKPrsI0wBaEgkF/FS+6E0V3B4nnRN8AgVQK41hC7GMngBR3CjyIGThGV5SqmcDL+xIkpQFLpKcsywTBLEe2CYCVwmSSVokcciTBXPSsxuGuqNlHLGLaa2Wq2+f3+NmgYWi8zR0SOJjZ4bo9166fKIKjbhttawcuFcIeRQbkcGdIVEdqRudWb2EszMqriex8B0QAoq2ppyPP5w0a2AXymzY07T/CXU4XkROhEyxSGXOexaiY68lCcX/QVkVreE2Pm0zZ03ODT/b4gpqNXA91jrJz+awI55y1O7xhKrNRpd9uSrmGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n20jQ1/rAdIwjEXTxNFOhFfASYMCqVRFGag1gt3PliU=;
 b=2vh77qK1cPB96qdlwcjWxbFkuMkR9Y1FMkJZC+tzIthoOKdVx1uWGF00jJ166Q0MegNz3scMOY9RGqNcIr74FA93ZupdXBvEKqrsxQEI4WffX92aR4IA96Zzc4LJnitJ1iZCLTB4tu+BM3jNWPQMXvVMtM2KWbg8cCA50eGLc6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 16:02:45 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 16:02:45 +0000
Message-ID: <09ea58f3-b54f-2bc2-bf6f-9a05e9db361d@amd.com>
Date: Wed, 19 Jun 2024 17:02:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Documentation: CXL Maturity Map
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: dave.jiang@intel.com, Jonathan.Cameron@huawei.com
References: <171659842954.843002.8140957498380360424.stgit@dwillia2-xfh.jf.intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <171659842954.843002.8140957498380360424.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0531.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 85402463-df56-4ca9-4af7-08dc907941d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1JpbHN2RlpwYjdQNnV0bWN6RVU5YXM1Z21TeFhPSmxQb1Fabkp3b2xHQVJw?=
 =?utf-8?B?NHhUZHBQUjAyVHBST21YNTBmVUgwUkZ0ZmU0cFdHRElJUExCQ1N4SHFIUFRD?=
 =?utf-8?B?UUZKQ0dnUXRGSVpSU0FhZzBKaHlnNG5MZ0crQ0IwK0I4U21CaE5oTEkvaWhp?=
 =?utf-8?B?MTdvOUdnQk1iSWtyMWZwQ1J3eFFiTlR2UWdpbXlIWTZoQ3dTbW44OHlWNUxM?=
 =?utf-8?B?aThTQVdBOG9Wd3RvTXZRZXNHbDQ5dVdGY1lZcm95ai9wdnF4bldCSGEzSDFz?=
 =?utf-8?B?N3c2RGQ3dFRYYVRuYnBBdk1ZSWYzMFlDd3R6cmk3WkZoRTRxTjN5RkpIT1VK?=
 =?utf-8?B?UERlc3FXWjhTZUpFZXF0b3Uwc0JEYkt6YWN2eExid3dFdU5kZWpQREczTFZs?=
 =?utf-8?B?T2xLekhZd0s1WURpK2d6bWV6a2FWamlVWU13Sk56WisvWERldllJL1RqbUor?=
 =?utf-8?B?Q0FqTUVyV0dncUIvQ1NlV3lVSGpkdWp0U0F0KzU3QUhHNFFFaWtKOW55MXJN?=
 =?utf-8?B?NktodXpUZmdMdDFpMW5HVFhCUDhFb3ZyRWs4Yk55b01GNmZ4UUhTWVRNVkZr?=
 =?utf-8?B?MjRLaVlwaGpoU3Rocnp6M1VQQTh5NEJIMHAwYzJONlF3cklCcytSa01MNmp1?=
 =?utf-8?B?S1RLM0xzalhvL2FmUDNJTW1HQ0dyYitmMDlCT3lkUkJYdURCd2NFaE9aM0xC?=
 =?utf-8?B?d2ZaM2N6OWYyeFA5VHdVbEdVcVh1Sk5TTzQ0bHdnQ0Q4cytXVHk0RTluNmJk?=
 =?utf-8?B?VTNzZDdMemdRRE03UzFMTm55U2Z6U2x4VGhqWSs5am93RExUeVVDQy85ZE1S?=
 =?utf-8?B?VXZRdGtmMHFTUVVsazlXQk5PUWhqbnNlSHBqcXloanNyMnFWV2pJRjJBcTNZ?=
 =?utf-8?B?djY0ekNMRG9sVlJyR01EQWRka0V1M1AycWRWZDhLVVBGR3NRZldyUkE2Z3Nm?=
 =?utf-8?B?Rk8vdHlSOFpVeXVoMHhnb1VndmE2WWRjOHEyZ0N1NHZhcFp1WEplWHlqNVJC?=
 =?utf-8?B?U3hzRTZWbU10V1pPcE52VnBLQWhJaDRaSkFJNEQ0WEZvejg2cXZEeis3ancx?=
 =?utf-8?B?cFJSNjRpdGZESG43SUtEdXpzeTkxak9IT0F1Zm12c1lvbzQwTU9qTjdXZW9i?=
 =?utf-8?B?cEwwYm50MmVzODRRcXhvL0FpR2RXSnZEVWZIOFNONms3WXJNNHl4WVNpZkJM?=
 =?utf-8?B?b2poVzVPNVpTVjhQTStPeDEvVWhtbWtBcVJzbXVOZnJSZ2ZkeTRoZWZYcnl4?=
 =?utf-8?B?SEI4WG1ick5Edk9PUzNUTzI0U2UyTnJZZFUxOWYyMkd4bVlLaWVCMDczV0RU?=
 =?utf-8?B?OVVaM1M0WmtlRWR3MDdLRmh0TW80TlNDd1MyRFFaWDE4Wk0wRjErcVBTNk1s?=
 =?utf-8?B?WU5xYTZFOVNtZ3I4bzJMZGxhQUhiWldselNjVUdGZEMwcEhpOU9GUGF2QVRX?=
 =?utf-8?B?NTB5b0ZWZWY4ZlF3VzlnVThXK1N3eTRiV05GSlNidCtwbndiMnNKQW5sNzA2?=
 =?utf-8?B?bFlyQ1pFSjF1d0JVeVVXczlPcFRaRUx1QUxLdSsxeVRWN2c5WlN6SHBhNG51?=
 =?utf-8?B?RndxRG5qeGU1eTFRUS9WeDNMS3RYb2s3VDZmWjdyQlkzcjg3ZmdYRWVYVDZE?=
 =?utf-8?B?dk1HVjF4TERwYkFRWkczcDJVM2RyVjdBUkdRelN2dVJ1YVNGeDhJNXBCc2lP?=
 =?utf-8?B?TjVtN1Y4bWplQTc1T2FvYWV2NTM1L2xHR2QvSVFMTzZ5Mkp0WWs2QWRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTZBN1ZpOVpHZitxVzZKclBpN0tIOFlqYXpSL0Z6TjJHdmh4UHBWSTFyMitP?=
 =?utf-8?B?VGFGNnAyT3hiR2xscU1yWWZkQlpvMlBHZzRjdWw5T2Z1b2JocWlRTi9WWmVI?=
 =?utf-8?B?Zkx3cUxoZVZkYlh0NWxiMFFma1p6TS9BamlqcTQ0U1Y3Q29PWFhxNlRSMmRu?=
 =?utf-8?B?L0FnbVRIV2FQblpBWFRLdXg3K3FUc1prVnhlZm81T1I5d1R1UTdFNjRZNUFC?=
 =?utf-8?B?VDFmbjB0ODJLZ3RCaXFiMGltcWYxazNoU2dNUGtrTnVQUXlRVkdJRGswdFJU?=
 =?utf-8?B?OGNTd0JEQTZsRzhQa2pUNzlzUW11bEZnMFNxL1diQWVTbkNzM3kzdWx5RjBk?=
 =?utf-8?B?SGhjeStXbDBjNjFlUFVsa2hiUE80T01RNCtIcllhdlExQmE4alQwbHRVUklO?=
 =?utf-8?B?UDQ2M1JYUzljVUFGcXp6R09CTGk4Tit4ZW55enRja2JpZnRBZkdzUi8yUlNj?=
 =?utf-8?B?dkU2Y29PWDNPMlNRZWZvRU5KeXhNSlJsQlRMclA0K2N4SWdtNEtacFUybVNk?=
 =?utf-8?B?ckRaV1R2WHArcXhoQnpvUmM1ZC90U0o2a0syVjg2WVd5NTBxS0RnY3FpR0po?=
 =?utf-8?B?UkdOZ3hZNVg4K1lrNVJ5VlNYdGNCaFNMRzZqZFlIQ1FReWhIZ0RxWXM3VHk3?=
 =?utf-8?B?K0pRM1ZLZE83VEtLSEliU3BRV3Q5MFo2L050WFh3RUhkYzM4czhPeEFTaXFk?=
 =?utf-8?B?ZXRHazEvcmsyTW1iTGY0UmQvWDNKRHdWYzMzSjkrQm55cU4yS1I0UzVPZitp?=
 =?utf-8?B?YTM4Q0xLUkhwOCtiZWppcVFrbnBRZHcwK1dOMmxyaEE0a3N2VzNnc0xuM09a?=
 =?utf-8?B?NlM1M2FtZlNkMEZiQS92OExiN0pMRVRQWHl1UmxOa3RaM1J2ZnJSWCtpNVli?=
 =?utf-8?B?MkhHS1RhVnBpRkNpdkM0WC90aTMvcFFHSGtDSmk0RkcrSXVxdGpKVWpaUm9G?=
 =?utf-8?B?bjdySDIxYkNsdDdDeDJmUUJHVGVncEw3Y3hrSkQ1Nnd5UFpaTUJxY2QxL2h5?=
 =?utf-8?B?YVVuWmlBTkZtMGpuYWJOOHdlZGpUcHpkZjhJYjFOZ1ZHNndNN0E2a1RienpO?=
 =?utf-8?B?MWszRUdiWVU0WjZZdHU1aXdwZDQ1ZHU1SDJMQ2grTUJGN2l2Qlp2emtURTAx?=
 =?utf-8?B?dWM3SUI5LzBtOXhDcVJtazhLS1EzRFN5MXZZL2tsUjBhNXpGeFBmaVFLY2s4?=
 =?utf-8?B?NDNraHJMRzNFbGhSWVNaZnhqL1NKUkUwM0g1MzF1ajBWZDMvajh1ZXZ6eGlh?=
 =?utf-8?B?NEtPb3Q3ajJ5U0VTWWYxRkhQV3VONEYvZHBXV1N6SGNLQkxMcDZHVURTRnJu?=
 =?utf-8?B?TmlPbkhTeGQyRnVZK3l0YmoveU1vL0c0aHNEYzhJaXNQcHhTZ2ZyMEJ6NDY2?=
 =?utf-8?B?bXVEbmtUTHphVGhoZmx3S2VHTlkvV00za1FPQjZmQllPb3ZsOGYzbmM3aGE5?=
 =?utf-8?B?N2FHNXIxT3JRUkVXVnpsM3Ayc1FKRUxwbFNGTkFiSVNuWDZycUtSOU11L25q?=
 =?utf-8?B?SDFQS0lRT2ZtTHBzUmtWcm5PVHlWdU5aU2IvRFFjaW84cVMxNUFUNW84MFRL?=
 =?utf-8?B?V0VQSjU3V1FPZHk0TDY3YmF3L3dtdVE4K3hraWg4ZjdxbWdkME1zdnowMDR1?=
 =?utf-8?B?Y0JtRmFjTnJ2LzBsRGlMWGFyZWQ2MEJKQ2dGVzZlcWYvNlJtWnBXc3N5VDQv?=
 =?utf-8?B?aE9HSlRpZjEwa0xJZTRXVEsxYjN2QXVHYTg3M1VHcFkycEJaQ0IwRU1VYktl?=
 =?utf-8?B?RXgvU1hyRGhPcjlPRlF5NlJTdVFjTkpFZW4zQ0VUWVV3SjJ4UVNVRE4rTFZY?=
 =?utf-8?B?dWkydUR0TE9BUHZoSEJhUVpLNG1PS3dIYjQ0ek9kUTRXZFFySXFCcmxocGJC?=
 =?utf-8?B?RmhHV2cyZ3NlVUlDWGp3ZHYrVlZZckFQQjF5d1g0R1EwV2JCM0tseWlTcUJY?=
 =?utf-8?B?b1J3OVVOTFYyMjg2aVJIbUlqOHRERUI2ejczOE9hNWZGWjV2a1BCTDhTdDVj?=
 =?utf-8?B?b0dhKzhSQnJPQllRZFpCcjFXYzdla1JkSzhweERCT0V3S0g5R3dvVnhEd0NH?=
 =?utf-8?B?THBYM09XYUJwZXV0NHdaYUo0REtiemRzRjl3d0VQZzgvenhGcG02RVQrM3pW?=
 =?utf-8?Q?xkRPYv/CxchSiR5P6kJ0CZKST?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85402463-df56-4ca9-4af7-08dc907941d9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 16:02:45.2042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTzqA0oK7C7vxD9xtY6PcZH0NtaUpWFKDeCpQ6msvYuZ6ohL/w/jVifeiJQWy4gxxkLLaOznidcJQFB8HVqk6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751

Apologies for the late answer.


RAS is covered but what about how CXL/PCI devices are handled after a 
slot reset?

I did expose my concern in that area when discussing the Type2 support 
patchset, and if I'm not wrong this is not properly supported: nothing 
for device detachment which should occur before the slot reset, nothing 
for resume function after the slot reset. This is obviously more 
important for Type2 devices and maybe not required for Type3.


On 5/25/24 01:53, Dan Williams wrote:
> Provide a survey of the work-in-progress maturity (implementation
> status) of various aspects of the CXL subsystem.
>
> Clarify that in addition to ongoing upkeep relative to specification
> updates, there are some long running themes in the driver that respond
> to the discovery of new corner cases (bugs) and new use cases (feature
> extensions).
>
> The primary audience is distribution maintainers, but it also serves as
> a guide for kernel developers to understand what aspects of the CXL
> subsystem need more help. It is a landing page to document ongoing
> progress, and a guide to discern exposure to work-in-progress features.
>
> Help wanted / welcome to expand on the "Details" section.
>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   Documentation/driver-api/cxl/index.rst        |    2
>   Documentation/driver-api/cxl/maturity-map.rst |  173 +++++++++++++++++++++++++
>   MAINTAINERS                                   |    1
>   3 files changed, 176 insertions(+)
>   create mode 100644 Documentation/driver-api/cxl/maturity-map.rst
>
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index 036e49553542..12b82725d322 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -9,4 +9,6 @@ Compute Express Link
>   
>      memory-devices
>   
> +   maturity-map
> +
>   .. only::  subproject and html
> diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
> new file mode 100644
> index 000000000000..9c5bff6484dd
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/maturity-map.rst
> @@ -0,0 +1,173 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +===========================================
> +Compute Express Link Subsystem Maturity Map
> +===========================================
> +
> +The Linux CXL subsystem tracks the dynamic `CXL specification
> +<https://computeexpresslink.org/cxl-specification-landing-page>`_ that
> +continues to respond to new use cases with new features, capability
> +updates and fixes. At any given point some aspects of the subsystem are
> +more mature than others. While the periodic pull requests summarize the
> +`work being incorporated each merge window
> +<https://lore.kernel.org/linux-cxl/?q=s%3APULL+s%3ACXL+tc%3Atorvalds+NOT+s%3ARe>`_,
> +those do not always convey progress relative to a starting point and a
> +future end goal.
> +
> +What follows is a coarse breakdown of the subsystem's major
> +responsibilities along with a maturity score. The expectation is that
> +the change-history of this document provides an overview summary of the
> +subsystem maturation over time.
> +
> +The maturity scores are:
> +
> +- [3] Mature: Work in this area is complete and no changes on the horizon.
> +  Note that this score can regress from one kernel release to the next
> +  based on new test results or end user reports.
> +
> +- [2] Stabilizing: Major functionality operational, common cases are
> +  mature, but known corner cases are still a work in progress.
> +
> +- [1] Initial: Capability that has exited the Proof of Concept phase, but
> +  may still have significant gaps to close and fixes to apply as real
> +  world testing occurs.
> +
> +- [0] Known gap: Feature is on a medium to long term horizon to
> +  implement.  If the specification has a feature that does even have a '0'
> +  score in this document, there is a good chance that no one in the
> +  linux-cxl@vger.kernel.org community has started to look at it.
> +
> +- X: Out of scope for kernel enabling, or kernel enabling not required
> +
> +Feature and Capabilities
> +========================
> +
> +Enumeration / Provisioning
> +--------------------------
> +All of the fundamental enumeration an object model of the subsystem is
> +in place, but there are several corner cases that are pending closure.
> +
> +
> +* [2] CXL Window Enumeration
> +
> +  * [0] :ref:`Extended-linear memory-side cache <extended-linear>`
> +  * [0] Low Memory-hole
> +  * [0] Hetero-interleave
> +
> +* [2] Switch Enumeration
> +
> +  * [0] CXL register enumeration link-up dependency
> +
> +* [2] HDM Decoder Configuration
> +
> +  * [0] Decoder target and granularity constraints
> +
> +2 Performance enumeration
> +
> +  * [3] Endpoint CDAT
> +  * [3] Switch CDAT
> +  * [1] CDAT to Core-mm integration
> +  * [1] Shared link
> +
> +* [2] Hotplug
> +  (see CXL Window Enumeration)
> +
> +  * [0] Handle Soft Reserved conflicts
> +
> +* [0] :ref:`RCH link status <rch-link-status>`
> +
> +RAS
> +---
> +In many ways CXL can be seen as a standardization of what would normally
> +be handled by custom EDAC drivers. The open development here is
> +mainly caused by the enumeration corner cases above.
> +
> +* [3] Component events (OS)
> +* [2] Component events (FFM)
> +* [1] Endpoint protocol errors (OS)
> +* [1] Endpoint protocol errors (FFM)
> +* [0] Switch protocol errors (OS)
> +* [1] Switch protocol errors (FFM)
> +* [2] DPA->HPA Address translation
> +
> +    * [1] XOR Interleave translation
> +      (see CXL Window Enumeration)
> +
> +* [1] Memory Failure coordination
> +* [0] Scrub control
> +* [2] ACPI error injection EINJ
> +
> +  * [0] EINJ v2
> +  * [X] Compliance DOE
> +
> +* [2] Native error injection
> +* [3] RCH error handling
> +* [1] VH error handling
> +
> +Mailbox commands
> +----------------
> +
> +* [3] Firmware update
> +* [3] Health / Alerts
> +* [1] :ref:`Background commands <background-commands>`
> +* [3] Santization
> +* [3] Security commands
> +* [3] RAW Command Debug Passthrough
> +* [0] CEL-only-validtion Passthrough
> +* [0] Switch CCI
> +* [3] Timestamp
> +* [1] PMU
> +* [1] PMEM labels
> +* [0] PMEM GPF / Dirty Shutdown
> +
> +Security
> +--------
> +
> +* [X] CXL Trusted Execution Environment Security Protocol (TSP)
> +* [X] CXL IDE (subsumed by TSP)
> +
> +Multi-host memory
> +-----------------
> +
> +* [0] Dynamic Capacity Device Support
> +* [0] Sharing
> +
> +Accelerator
> +-----------
> +
> +* [0] Accelerator memory enumeration HDM-D (CXL 1.1/2.0 Type-2)
> +* [0] Accelerator memory enumeration HDM-DB (CXL 3.0 Type-2)
> +* [0] CXL.cache 68b (CXL 2.0)
> +* [0] CXL.cache 256b Cache IDs (CXL 3.0)
> +
> +User Flow Support
> +-----------------
> +
> +* [0] HPA->DPA Address translation (need xormaps export solution)
> +
> +Details
> +=======
> +
> +.. _extended-linear:
> +
> +* **Extended-linear memory-side cache**: An HMAT proposal to enumerate the presence of a
> +  memory-side cache where the cache capacity extends the SRAT address
> +  range capacity. `See the ECN
> +  <https://lore.kernel.org/linux-cxl/6650e4f835a0e_195e294a8@dwillia2-mobl3.amr.corp.intel.com.notmuch/>`_
> +  for more details:
> +
> +.. _rch-link-status:
> +
> +* **RCH Link Status**: RCH (Restricted CXL Host) topologies, end up
> +  hiding some standard registers like PCIe Link Status / Capabilities in
> +  the CXL RCRB (Root Complex Register Block).
> +
> +.. _background-commands:
> +
> +* **Background commands**: The CXL background command mechanism is
> +  awkward as the single slot is monopolized potentially indefinitely by
> +  various commands. A `cancel on conflict
> +  <http://lore.kernel.org/r/66035c2e8ba17_770232948b@dwillia2-xfh.jf.intel.com.notmuch>`_
> +  facility is needed to make sure the kernel can ensure forward progress
> +  of priority commands.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e533476081ba..d092b2ae5f25 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5331,6 +5331,7 @@ M:	Ira Weiny <ira.weiny@intel.com>
>   M:	Dan Williams <dan.j.williams@intel.com>
>   L:	linux-cxl@vger.kernel.org
>   S:	Maintained
> +F:	Documentation/driver-api/cxl
>   F:	drivers/cxl/
>   F:	include/linux/einj-cxl.h
>   F:	include/linux/cxl-event.h
>
>
