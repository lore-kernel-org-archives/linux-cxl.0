Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0A635963
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737648116; cv=fail; b=AZF59HIto5GXpElba/sp0N6J652M9RgwBXU6yYxcx8OA6+5tmjbSq1B+VUCUhlK+ZNGisyKahndHyI3/NpvxaE3LnP//EQzR19tmkguXXt4iRaDORm9a2eaCC2+9jPbm852n9q2vANE3X/iaRjKtpOJjBeKvdmnQEE+Nb6xOOSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737648116; c=relaxed/simple;
	bh=QNkG0lRPddox21o6hEJp12ZW2OW3AVyP60bUy6zm/K0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OGAQPRKUSHQHUV5zx9GHnDUNNUXvBBP2PdM3h/4mj/MyTYnCwxbxMWlVgKlOP5iwykUdt/GF7CFaSsLhBMHUE4kbkBIqdtDi7rDPfb6uuCxOI7KrLJyySBFV9/xkRBHe82fjZCrqKXpHiZEwQ+kYCsb/3eV9Gy7ommcveTkp3I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D3Q6bR8r; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D3Q6bR8r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loZj9IjvTjD8YXHJ4+Fjb6bAb9Zqxj2Her0JiWmLYOlRTqN7jqys641/C5NDj73QgfKIMhmm+vwkthMpFpRhftzFjID5ugRI0Gxjqzb4YIh3X8pfktNMjWZA4WbFOjkClGBKkdpyMPEW8LSLG3Jmb98BDWsr9nHqOBovWnz4pmV7pQe/agvugm7mpgEYPQvP/7OTzg7yyaXEpYR9q2U6AUz1aX4TPqUU/J5Wsjrng7XPoRzRLzaR33fMozUhLNVxvzNeFwgQftaTLlHjGQIgaD+YtfonDUbiN0ayHbZjQWS3E/cM/KGsQpzQQ3ORDrzmvF9nTsfFH1HVfJv8UUzFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfzaPZcrqyxDLZcE3iKN9f+I+F9wpSF6JInICu66mcA=;
 b=BsWAFsrQTHymJAe76nNPLTOiMX4YLh8JpL9BI39P/xmkewsccPu+iD4wnc5Of2HkE6XZ/QstYZTG5DyXBilbeVjYEqIwtSzTfJ6m6lg1gAx6uQCBWBHBoGNDrYItRHiAf6XaZPVRrBPAAZfBHG13dBlIFIA3jpoP8Qd+I+KVOEBf9pjJS9wWw6tTQByfhj7gedlaPgpE8qUhwKbOf1PfT+6RBjch82CDzFu3TujIYGgeK4uqRbeo3Xq9OJypMBv0SM8ArUV1M5t+B5A9b8InmD9SO1lpIxolJ4wgdMOOZT7Ut/XKMrZLMNUoBxIZ6S43pVbg8dQzGIAEPchbi5QiJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfzaPZcrqyxDLZcE3iKN9f+I+F9wpSF6JInICu66mcA=;
 b=D3Q6bR8rG3EAqY4oSiSns+ffuEnR0VzWYtekPhXPRlpacOlbfxOJaPwOc4vx1FU2ZefORkVgfZr4qFCWE3CYkKHwLdIik8E2XkO1wpLZbk5nAlwjprjsuVqHyxRZNYmLQyW7stb5kTMBZbcdnoCnENIBv+bO/LXL2rt5eFqBOe0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by SJ1PR12MB6076.namprd12.prod.outlook.com (2603:10b6:a03:45d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 16:01:51 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e%7]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 16:01:51 +0000
Message-ID: <621df885-d80d-40b5-9fe2-d6235ebfe0e5@amd.com>
Date: Thu, 23 Jan 2025 10:01:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] dax: Update hmem resource/device registration
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, alison.schofield@intel.com, linux-mm@kvack.org,
 gourry@gourry.net
References: <cover.1737046620.git.nathan.fontenot@amd.com>
 <9a41f91ed487ea64e187d84fab3bd69a4a5862f9.1737046620.git.nathan.fontenot@amd.com>
 <67898815e6280_1c3f7529466@iweiny-mobl.notmuch>
 <fb3eaa1e-0c87-4859-94b0-373ba50e4d78@amd.com>
 <67902a5bc53eb_e5f72942b@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Fontenot, Nathan" <nafonten@amd.com>
In-Reply-To: <67902a5bc53eb_e5f72942b@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0032.namprd08.prod.outlook.com
 (2603:10b6:805:66::45) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|SJ1PR12MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: ba106d2a-9c50-48bf-3b31-08dd3bc74017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjIwS2UwbXc5YWJVT1lWZ2hiSndKYStlbEo3RW92MFBEckVNS00xYWtId2Jh?=
 =?utf-8?B?bURLRG5Xa1VSaUxyNkFIcVRjNWc1RWJDOTlqVXQ1LzBkYmk4eVZCN2lXYklO?=
 =?utf-8?B?V2Zsbk9hZ1VQL053Um5YYUZZazkwcTh4TmdQZGF5dnRkNENsaW9SZXY5L2Zn?=
 =?utf-8?B?L2V2UGY1VTZHUThWWTNzK1Z3b0pJbVB3MTc3Sks1Q1FTK1Z6ekxBMm9SeHp6?=
 =?utf-8?B?NHFvaTljWkNOK2ZWK0JLVENPTnJYbU5CVjJyZDdLNjNycHJkVk5vTjEyOGE1?=
 =?utf-8?B?UXowc0t4ai9maG1iQUduWGsvTnNZWVozRHZlb09ocG1FRHJuODNKYXYxT2cx?=
 =?utf-8?B?TnBuby9QT1BReXF6OW95aTlhZGlVN0ozVFZyOENyVHBTRWtWckNOTXVpSXNX?=
 =?utf-8?B?aWNhcTlYMzJIM0Y1a0VJSk5rSGJrc0xDeC9TRE1YaE04TWpiVVphei9GY01p?=
 =?utf-8?B?dmpPbDhUM2wzTEVKeE00TlQrTU54UEM2S1ErYkJBUU4xMlh0dHVGQWk0eXVw?=
 =?utf-8?B?OFRVZTVOeEEvaDN3S1RTdXVwWHowVWsrTlIvVTNEdzkyNTY4aEZaVXNTVDNv?=
 =?utf-8?B?dkxYaWpSaU1BM0ttbmZxeTZRY1psMm8vV0k5ZTRCc1VkaUZEZGVzd3FMYkxX?=
 =?utf-8?B?SnhhWE5INXBMWmxPblNpV0ExL2tLeDdLTmJJdDdNN1dIbFRuLzJEQkJnK1BZ?=
 =?utf-8?B?OGk3KzhMV0tGVnpYZUlxT2RUOS9EVjRqMGZZWEYwYVZZalRVeWZrR21Hc3RE?=
 =?utf-8?B?Nm5rdUVRQ2FZSk8xTHVkbDBqT0NEWmN4KzZKSHl5MGV6MmNJR1FIMnE0Z0hT?=
 =?utf-8?B?VllzWk9ScmRKNFFpS2NhSmJSNnNBcGxtVmM5eVZUc2R5THdtL09YVDlYTG9i?=
 =?utf-8?B?VlQvUmhTV08rOUN0eFdCVHk5UFB2SkxZUzdabjdiREIyY3YvQjhUSUxpVUZu?=
 =?utf-8?B?U0dydG5CSlpXT3BMUEpaVm1aZ1dXQWpKTkFGZWJybU9vVTcwaVNFVVRtZUZz?=
 =?utf-8?B?ZkhmVzRwcW1aR3VuUDVkaHNRczhKZTU1N243MXQ1ZXZLSk82Und3Ukw4aElR?=
 =?utf-8?B?WGV2UEpFODFNbDlDMWpIaU9kZ0poVzUxYm0wQTlqVG01VFdqR1k0K3VYZHd0?=
 =?utf-8?B?M250QmFXTitmajJpb1NEaFlhbEE1SDB2cjd1Uy9ET3VJNTFuckR2Wkh5NGg3?=
 =?utf-8?B?cTE3WWtwT2F3cERyZXYyMnE3VGU2M1BNZm0zbmNHN2hwN2MrUkkrL3V0eG5H?=
 =?utf-8?B?c1ZEYUk4QTYyNHByd0xpUFFSUVJRaEdwNVpTTU5OUmU0WXh6MEUyOG5sVzRl?=
 =?utf-8?B?Q0JmZXVrRVZUN0FGU0xzSWtqVTdqWWswRUtuUHJZL0tLWWNvTVVxWkhqZWo4?=
 =?utf-8?B?b3E4cm1qSnBhMHFpcVRkZkZMQ1JoR1lFVElmVmtuWThNL2piMFhoMWhRSG96?=
 =?utf-8?B?MTB5SmNocnJONE43cG5GZ1kyYVA3NFFvaHNMVjRNcVdVRUxLa2RySUJ1S09s?=
 =?utf-8?B?a2JsdjJ5ZkhYVGJCYkJOam00QXRaOEt6Yzc1QmsvaGNtVzI4NXVONmxqQ0dB?=
 =?utf-8?B?ZGF2MzdYbHdGSENmTlhFMm0rTmFON0MyalFNa0h3ZFdDNWVLWFhJSFA1NEpN?=
 =?utf-8?B?VmRjQk1rL2RtNXcvQU9nd09LR2RtV2pmb3NnTHpyeVFQZldSU2FDWUhjeFEw?=
 =?utf-8?B?aFNCT1I3aXFTUUdlVFVFUzJSdElQaFdJYkZrbmRiMGZBM1Bxd2hMMzMvTXl4?=
 =?utf-8?B?LzV1dnc5Vys4YU9EVHR6STYraXpkOHFMZXp1a0hNVGJycitLS21PeHh4aVBX?=
 =?utf-8?B?TWt2K3dnbGdOT2o5VXNWUVNjVzNkQ1RCNzRGaEt2Tm5xQmZHSTNYK2xwdGRZ?=
 =?utf-8?Q?G3s6ObRK6+1F0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTFSUzNYc2JzU0psM0ZmWXBVWW00M2ljTG1GakZzR1FBenpjcDlEZEZSRjJn?=
 =?utf-8?B?bC9FT1VkSXJrV1NmOHgxeVJVTnJPZFBBTDg5czlQcG02T056NWlEbkVCWVlj?=
 =?utf-8?B?bEJIYmRoNzhwLzRGMHVTZDEwM2czandockdPcUZuZjUrTzdoZTc0YUw2WnhN?=
 =?utf-8?B?SC9IdGhiY1dta3htNFNkTWMrVXFHRjdOOXJ1bHZTT0RGNEgzSlk2VFRsb1Ri?=
 =?utf-8?B?YzNEdkE2KzViWEhrdW5RNzRHNG5YWkhNOWpCa2syRlBZZm5yTTJtazJxREt2?=
 =?utf-8?B?aTJGQ3l6UVZjR0sxMTBrc25nb3V6aW5xTDlhaGJMSFpMdElCb2FRTXRhU1Bu?=
 =?utf-8?B?NVNVYXFIYnJGeDdnNE9CVzNQdjRXM2FKTzNNU3Q1UEZsbGpsWVZDeGk4d2to?=
 =?utf-8?B?U0JWeTA3aDMrd25RWEllVUQySXY3akhCU0lOSDZKNEFJWGhYSng2ODJYNkpi?=
 =?utf-8?B?T1ZmdjFTUFFzNkZUenFtbFl4K1pFdHZ2N2JoRmtjZ1pqV1NSNnBCTlZjT1R0?=
 =?utf-8?B?am5MbndnMzJZWGRZWDVWQlV5QkE2Z2cyTm51UjVGQ0c2TExyN0FHeHVFeksw?=
 =?utf-8?B?SmJKemt3SmptVk1WaGJkRFlZSTdNWWQxb0ZLSk42cDJINnozaXBJVTB3UnlO?=
 =?utf-8?B?czZobUJHLytDR1ZQSlBwcCtlQTVMY2FYRG4yS1JtS3AzVms3ZU1rLzFFNTBn?=
 =?utf-8?B?NnhTSDFMRXBEa0xoYUVsMUZWbkluK0RIZzJyR0FvUXRIOVg2S3FWR05oY3Vt?=
 =?utf-8?B?emwrbEpqWmRXTUkzNW92OFhMRTBDelV5WHNrWmIzN2hGMHQ3cnduT1h0OUl3?=
 =?utf-8?B?a3dsUGcrVmZTTEEyRms4QWU3SEZselRVTFFibWlpYWJTeDBDQXUwV0tQY00z?=
 =?utf-8?B?a2hoSTZBdUZkS0xHSTZJWE53R2xyY08ranB2R3pTSXcwZlFCNHNHNXpYQnRD?=
 =?utf-8?B?NlBjRlNQVmxqUGRqWm9oZmtxNkR1ZlBTRHJKRXI2ZStNOS84MTFQekc4Q3Jr?=
 =?utf-8?B?dVhvSkhFZzJjSVZNd3JTZWtDWHNEMmZmMTRFOGFRWDNPSjEwaWY5TWRlRmor?=
 =?utf-8?B?Zk1tUllYSG0wSGdxTVZmSm5SMEJpdldacVh5bFA0MUpkOWVpbEVISWxLSTNR?=
 =?utf-8?B?bTZqMHJTVG1VUWYyUVZwZXdvc1pjalc3a1BkMTBpWWUyM1R1NW5WS0x2Qkhh?=
 =?utf-8?B?YlpJTk9JR2p6eDVDSFN1T2w0WGVVWndOVlNJUlhYK2hXalRrOWFoNVpmNTly?=
 =?utf-8?B?QXk5TWFJSmdIM2VCQmg5dXhLQ3dZV0EweXVHSmpwVWp5cUo1cXZwUlV5dDM3?=
 =?utf-8?B?MXBORmVaLzN0MmZEa1lwL21rZVk5N3dpekQ5RGxZemR5eGdaOFdDUHErV3Yw?=
 =?utf-8?B?UUNsdUMzZWwwL0ZkUTRsTzM0aUt3WmZLbDE3U1VVL01ZK0RJSS8vUzI3b3Nk?=
 =?utf-8?B?NUExRlBNVjFLZG0vd2xDV1Vtb1dva0c3ZUl6OE4yemwxUGQvVjlvU2NRWDNN?=
 =?utf-8?B?eGxsaWpaZVRGVFRtMlNaS0MwbklkakYzQTlQQnhCdkRtNUh5bXpDdmtZalZn?=
 =?utf-8?B?OHh5dmlIejkxWlp5SVFNZmkveTg3eTcxM1ZLdTlUZXdrQkFhSFhZOXdkUldk?=
 =?utf-8?B?OWUyOEdzQjVSQ2hsOHo0c0Y1eU9QUDRodWNaTHprTEtMcHhZYXQvK3ZBN0RK?=
 =?utf-8?B?SmQ4S1F0emdGZGpjMlljbFl3S280aS80bUdvUjhhVlVuQ3hUY21TdTBKRDF5?=
 =?utf-8?B?L0hTaS9WVXpsUy9wVGpPaHh3L3BOb0xrb2MxelRxOXQyRHNoWWhKUVJKbE1y?=
 =?utf-8?B?SWV5dUlNa1dVOTB6Q3NKVHBzdkVBZ0QyNnFFNFB2WUI1YzJpQVJ2NU10N1J0?=
 =?utf-8?B?c1EwSmZLWWFENEQxeUh5b3J2RFBWWWIxK3haZDY5QnN3ZjVEMkZaTlJ0Wk1r?=
 =?utf-8?B?M2pSMHdBRDY5TnZNU1RVQWJDeDY1NWh5eFl3UENyL29iekRZWTRFNW9JR21h?=
 =?utf-8?B?VFJWR0QySEpybE9qVHdCNWZ1RmNVSmFxblFaL2IvU0dhZ3lNSnNKS1I3VHI0?=
 =?utf-8?B?MFFsYWowRm1hbFhSWDlwNVZWMkhRQ2ZXV05NaXFWWDJETnpQVXFtS2ZvV3Ex?=
 =?utf-8?Q?Ko0N87hTETMMpDS7AOAD2BaeM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba106d2a-9c50-48bf-3b31-08dd3bc74017
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 16:01:51.7586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OV9zrf3U6ZmupRUm9NiD4Qc6LslyxVGZbrADY4qnMu3U3ziwtfCq+EQD3KCpwP6Q7eDQpqN06V+8FFZl/v+RLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6076

On 1/21/2025 5:14 PM, Ira Weiny wrote:
> Fontenot, Nathan wrote:
>> On 1/16/2025 4:28 PM, Ira Weiny wrote:
>>> Nathan Fontenot wrote:
>>>> In order to handle registering hmem devices for SOFT RESERVE reources
>>>                                                               ^^^^^^^^^
>>>                                                               resources
>>>
>>>> that are added late in boot update the hmem_register_resource(),
>>>> hmem_register_device(), and walk_hmem_resources() interfaces.
>>>>
>>>> Remove the target_nid arg to hmem_register_resource(). The target nid
>>>> value is calculated from the resource start address and not used until
>>>> registering a device for the resource. Move the target nid calculation
>>>> to hmem_register_device().
>>>>
>>>> To allow for registering hmem devices outside of the hmem dax driver
>>>> probe routine save the dax hmem platform driver during probe. The
>>>> hmem_register_device() interface can then drop the host and target
>>>> nid parameters.
>>>>
>>>> There should be no functional changes.
>>>>
>>>> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
>>>> ---
>>>>  drivers/acpi/numa/hmat.c  |  7 ++-----
>>>>  drivers/dax/hmem/device.c | 14 ++++++--------
>>>>  drivers/dax/hmem/hmem.c   | 12 ++++++++----
>>>>  include/linux/dax.h       |  9 ++++-----
>>>>  4 files changed, 20 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>>>> index 1a902a02390f..23d4b3ad6d88 100644
>>>> --- a/drivers/acpi/numa/hmat.c
>>>> +++ b/drivers/acpi/numa/hmat.c
>>>> @@ -857,11 +857,8 @@ static void hmat_register_target_devices(struct memory_target *target)
>>>>  	if (!IS_ENABLED(CONFIG_DEV_DAX_HMEM))
>>>>  		return;
>>>>  
>>>> -	for (res = target->memregions.child; res; res = res->sibling) {
>>>> -		int target_nid = pxm_to_node(target->memory_pxm);
>>>> -
>>>> -		hmem_register_resource(target_nid, res);
>>>> -	}
>>>> +	for (res = target->memregions.child; res; res = res->sibling)
>>>> +		hmem_register_resource(res);
>>>>  }
>>>>  
>>>>  static void hmat_register_target(struct memory_target *target)
>>>> diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
>>>> index f9e1a76a04a9..ae25e08a636f 100644
>>>> --- a/drivers/dax/hmem/device.c
>>>> +++ b/drivers/dax/hmem/device.c
>>>> @@ -17,14 +17,14 @@ static struct resource hmem_active = {
>>>>  	.flags = IORESOURCE_MEM,
>>>>  };
>>>>  
>>>> -int walk_hmem_resources(struct device *host, walk_hmem_fn fn)
>>>> +int walk_hmem_resources(walk_hmem_fn fn)
>>>>  {
>>>>  	struct resource *res;
>>>>  	int rc = 0;
>>>>  
>>>>  	mutex_lock(&hmem_resource_lock);
>>>>  	for (res = hmem_active.child; res; res = res->sibling) {
>>>> -		rc = fn(host, (int) res->desc, res);
>>>> +		rc = fn(res);
>>>>  		if (rc)
>>>>  			break;
>>>>  	}
>>>> @@ -33,7 +33,7 @@ int walk_hmem_resources(struct device *host, walk_hmem_fn fn)
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(walk_hmem_resources);
>>>>  
>>>> -static void __hmem_register_resource(int target_nid, struct resource *res)
>>>> +static void __hmem_register_resource(struct resource *res)
>>>>  {
>>>>  	struct platform_device *pdev;
>>>>  	struct resource *new;
>>>> @@ -46,8 +46,6 @@ static void __hmem_register_resource(int target_nid, struct resource *res)
>>>>  		return;
>>>>  	}
>>>>  
>>>> -	new->desc = target_nid;
>>>> -
>>>>  	if (platform_initialized)
>>>>  		return;
>>>>  
>>>> @@ -64,19 +62,19 @@ static void __hmem_register_resource(int target_nid, struct resource *res)
>>>>  		platform_initialized = true;
>>>>  }
>>>>  
>>>> -void hmem_register_resource(int target_nid, struct resource *res)
>>>> +void hmem_register_resource(struct resource *res)
>>>>  {
>>>>  	if (nohmem)
>>>>  		return;
>>>>  
>>>>  	mutex_lock(&hmem_resource_lock);
>>>> -	__hmem_register_resource(target_nid, res);
>>>> +	__hmem_register_resource(res);
>>>>  	mutex_unlock(&hmem_resource_lock);
>>>>  }
>>>>  
>>>>  static __init int hmem_register_one(struct resource *res, void *data)
>>>>  {
>>>> -	hmem_register_resource(phys_to_target_node(res->start), res);
>>>> +	hmem_register_resource(res);
>>>>  
>>>>  	return 0;
>>>>  }
>>>> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
>>>> index 5e7c53f18491..088f4060d4d5 100644
>>>> --- a/drivers/dax/hmem/hmem.c
>>>> +++ b/drivers/dax/hmem/hmem.c
>>>> @@ -9,6 +9,8 @@
>>>>  static bool region_idle;
>>>>  module_param_named(region_idle, region_idle, bool, 0644);
>>>>  
>>>> +static struct platform_device *dax_hmem_pdev;
>>>
>>> I don't think you can assume there is only ever 1 hmem platform device.
>>>
>>> hmat_register_target_devices() in particular iterates multiple memory
>>> regions and will create more than one.
>>>
>>> What am I missing?
>>
>> You may be correct that there can be more than one hmem platform device.
>> I was making this change based on a comment from Dan that it may not matter
>> which platform device these are created against.
> 
> If that is true I think there should be a big comment around this code
> explaining why it is ok to have the platform device being allocated in
> this call unregistered when a different platform device (host) is
> released.
> 
> IOW hmem_register_device() calls two devm_*() functions using host as the
> device used to trigger an action.  It is not entirely clear to me why that
> change is safe here.
> 
>>
>> I could be wrong in that assumption. If so we'll need to figure lout how to
>> determine which platform device a soft reserve resource would be created
>> against when they are added later in boot from a notification by the
>> srmem notification chain.
> 
> I see that it would be more difficult to track.  And I'm ok if it really
> does work.  But just looking at the commit message and code I don't see
> how this does not at least introduce a functional change.

I'm going to go back and take a look at this again. I went this direction
using the approach of having the srmem notification chain. The dax driver
then adds soft reserves outside of a probe routine and don't have a
platform device associated with them.

-Nathan

> 
> Ira
> 
>>
>> -Nathan
>>
>>> Ira
>>>
>>>> +
>>>>  static int dax_hmem_probe(struct platform_device *pdev)
>>>>  {
>>>>  	unsigned long flags = IORESOURCE_DAX_KMEM;
>>>> @@ -59,13 +61,13 @@ static void release_hmem(void *pdev)
>>>>  	platform_device_unregister(pdev);
>>>>  }
>>>>  
>>>> -static int hmem_register_device(struct device *host, int target_nid,
>>>> -				const struct resource *res)
>>>> +static int hmem_register_device(const struct resource *res)
>>>>  {
>>>> +	struct device *host = &dax_hmem_pdev->dev;
>>>>  	struct platform_device *pdev;
>>>>  	struct memregion_info info;
>>>> +	int target_nid, rc;
>>>>  	long id;
>>>> -	int rc;
>>>>  
>>>>  	if (IS_ENABLED(CONFIG_CXL_REGION) &&
>>>>  	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>>>> @@ -94,6 +96,7 @@ static int hmem_register_device(struct device *host, int target_nid,
>>>>  		return -ENOMEM;
>>>>  	}
>>>>  
>>>> +	target_nid = phys_to_target_node(res->start);
>>>>  	pdev->dev.numa_node = numa_map_to_online_node(target_nid);
>>>>  	info = (struct memregion_info) {
>>>>  		.target_node = target_nid,
>>>> @@ -125,7 +128,8 @@ static int hmem_register_device(struct device *host, int target_nid,
>>>>  
>>>>  static int dax_hmem_platform_probe(struct platform_device *pdev)
>>>>  {
>>>> -	return walk_hmem_resources(&pdev->dev, hmem_register_device);
>>>> +	dax_hmem_pdev = pdev;
>>>> +	return walk_hmem_resources(hmem_register_device);
>>>>  }
>>>>  
>>>>  static struct platform_driver dax_hmem_platform_driver = {
>>>> diff --git a/include/linux/dax.h b/include/linux/dax.h
>>>> index 9d3e3327af4c..beaa4bcb515c 100644
>>>> --- a/include/linux/dax.h
>>>> +++ b/include/linux/dax.h
>>>> @@ -276,14 +276,13 @@ static inline int dax_mem2blk_err(int err)
>>>>  }
>>>>  
>>>>  #ifdef CONFIG_DEV_DAX_HMEM_DEVICES
>>>> -void hmem_register_resource(int target_nid, struct resource *r);
>>>> +void hmem_register_resource(struct resource *r);
>>>>  #else
>>>> -static inline void hmem_register_resource(int target_nid, struct resource *r)
>>>> +static inline void hmem_register_resource(struct resource *r)
>>>>  {
>>>>  }
>>>>  #endif
>>>>  
>>>> -typedef int (*walk_hmem_fn)(struct device *dev, int target_nid,
>>>> -			    const struct resource *res);
>>>> -int walk_hmem_resources(struct device *dev, walk_hmem_fn fn);
>>>> +typedef int (*walk_hmem_fn)(const struct resource *res);
>>>> +int walk_hmem_resources(walk_hmem_fn fn);
>>>>  #endif
>>>> -- 
>>>> 2.43.0
>>>>
>>>>
>>>
>>>
>>
> 
> 

