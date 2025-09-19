Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9347419D082
	for <linux-cxl@vger.kernel.org>; Fri, 19 Sep 2025 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758289368; cv=fail; b=nicEjzKRI5B/c/AGOoiPEnxu3z4J0D3+VRBZcJ/eict2Es4cSXRHNJMbjdm/ZknKbevomKF4Swhh8rlDTrz7Azz6eWkXyih+nTjy1NsEy5dEiS9Bzj0r/9UI+SN+/ukU9e4iXq+WfJZA9hIh1QrG3hrowhNDnCHbyHKNQTi10IM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758289368; c=relaxed/simple;
	bh=SiiGmNZnEI219QHgD24PUpfzKeiucC/vHIpuOl0r1iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hnYJFh+hToCkBmVNmeKUlgvXNCWii+YQO/WdxqY9Vtdz5Smbe9IYQBwGAw5Nu//40XQpPo/cejC5KoA5jYAy0/LsE9dDmEimLrxG09UPu/OiPCY3SSNBilb67pdilT2OZNWMWab5ai5q3nnAoPC0g4fAFjEHYTYW2Hf+E8ryU+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rnEtq9TA; arc=fail smtp.client-ip=52.101.52.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rnEtq9TA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJis3SAHA82HciPKqFMJtbfn8YaUEt8DY3KYiH2NcQPfesdqU52o5DgXdkt8pEEjKfRH9ro6xZHzvvRZCtYKjY3hwmsMkelpdPU4hSZvGF9gmP40qQ0EL2kZEqQsvxk8MHh+D/mP9ct1JwIce4qlzlXVnhnKn+xHENGOTvZNHux0wnco+KWulfv4fNsVATukRc6+UkMIvPIv624uGzzYIcmas85aStlHO5yg9anCl9Gl0cOzTYHtFgTKpD3v7vqwVtCy6cgD5XsIhwICSLjyL0KFV/NhZ2WbGbJ46kPjJAYro6EYLMH13OG41FOePzmSxzJnS4PoEr/SFphB91stxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPDwwgVcgFN+DsSXzVoEzTYSYqUWIEKkoGYvS8qbRhQ=;
 b=vwVJ8lurl9mjsR1htx3eOliYmwXkUsuIwFbL0bLnke2rqeTEK3gJMZaT52DX92QO6XcAZRoYxnx3S15XZI7rVxhLqaOqbtr/vRegkP7EujtAqnR3JAC0DqEJT6gKxXw4KS7RjpLufV2Q3i2W8zUO+zZNsH+cB+idD4rUTxoVpxhANWyz7D3I/nebh2KD45W1R2adE7Eey21obpnKsn92i6PXV0BN8MxGCHcyHuBivRiNecjt5wr6D6DPjjtS6YZemb1QHf2oHTiiQFdHnFF42Ab1OE9BxxqfrRO8cgsWOquamqcVJ2v7iXUpkJWD5r/YD3sFaF1VjyjmQ2FU6uiZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPDwwgVcgFN+DsSXzVoEzTYSYqUWIEKkoGYvS8qbRhQ=;
 b=rnEtq9TA9FmoEPr7/UWiI6eo/CV2MVCQlr4BoP2QwSBxtBHdQLvkdjJO5/lxGuuOHgeb6QtgYgOcMBUhTdECy51u7rZJy+fKotKHGxAzQ88H++GXcKd2e4Pop9cGmsSFofLE74SbxWQ0eiK1vwML21h4TlOA6f2P34dRsTHtPOc=
Received: from DM5PR07CA0083.namprd07.prod.outlook.com (2603:10b6:4:ad::48) by
 SN7PR12MB8170.namprd12.prod.outlook.com (2603:10b6:806:32c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 13:42:44 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:4:ad:cafe::14) by DM5PR07CA0083.outlook.office365.com
 (2603:10b6:4:ad::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.16 via Frontend Transport; Fri,
 19 Sep 2025 13:42:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 13:42:43 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Sep
 2025 06:42:39 -0700
Message-ID: <60a4fb84-13be-4fb7-86dd-25ca74cef320@amd.com>
Date: Fri, 19 Sep 2025 08:42:39 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 18/18] cxl/core: Add cache device cache management
 attributes
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-19-Benjamin.Cheatham@amd.com>
 <29b9953a-8367-4545-a783-dfabbfa488d7@intel.com>
 <9002a2f5-6319-405f-9fb4-22c841ae0191@amd.com>
 <5edd311e-4ef5-454c-bdc3-6eac654e29e4@intel.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <5edd311e-4ef5-454c-bdc3-6eac654e29e4@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 628aafd8-95cb-4d1d-5213-08ddf782691b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGhUcGcyODJCQnF2cVVrdWd1ZEwvbnVxMk8wSnR3WjNoUE4vRDhQZk1LeE1s?=
 =?utf-8?B?QzY3UzRwTFc0MjA2UkhZMmhwbkRySktBK1h4WFo5b0ZFK3NhbTA1bWRyb252?=
 =?utf-8?B?M0N3bWhmQkFPMXlyWXBTWXZISU5iVkZzZFBjUGwwTTQ4OGpFUWViT2daUXNM?=
 =?utf-8?B?eE1aSUcxSHloTkFyYXlOYzFkemhmcDFhempWSFRBN3U4aGRNWU9HTHhVMk5m?=
 =?utf-8?B?cUY0T3plV0lUMzdOalJGWlpTbWd6MWlYVllLYmFLMllvck1PN1BUckFROFph?=
 =?utf-8?B?WnZjYlJLNkVRNXlTYVA4QTNGdjJKQ3FKNnVTYmo2VjNBM0VISVV5bUpQY05J?=
 =?utf-8?B?YW5SR04wU0dWZlVWVG12czZZdzlIVUFGeDk3MCtFelRLMEU5dzJ6ejl5VUpC?=
 =?utf-8?B?K3UwN3NDZnZJdzR0d211MklKRktQU1ZkYmJsTXNaYmdnZUM4SzlyanNTbzJp?=
 =?utf-8?B?UHdOeFovYlpLVTMwYWVJOEI1WlZ1UWw1MW1NaDk2dmg2TEp2SnM4NkErTC9Y?=
 =?utf-8?B?azNvSDViYzVuejBRVDQ2aEM1RldYT0lMdUJmT2NtMmVNMU1sMG1JWHVRbzhS?=
 =?utf-8?B?cTV1eXBackhEV0o3cVNlUFhqdFdnaDkxL3NpbUcraVBTT1JEb0tvRTJ0dXk2?=
 =?utf-8?B?Z3Z0VklCRzJMblFwNldYZUVldjlzQld5eE9xZ0VnM1Z4Sjlab2tNTm9kUk1i?=
 =?utf-8?B?KzNZUFlMQTFGSmp5d2ErdDlINC9FYVFPTFY4bkdveU1sOWllM0hvQWNxeldl?=
 =?utf-8?B?c3RtMmkxOXUyWHIvV09HOG83UWZqaDI3WXF5bUJzUDdSNGFKMU4wWmNPRktX?=
 =?utf-8?B?b0tBTUdCRi9xWS9nQXMyTmV0MXZpcTJaeUVNUzhoUVdITEVzWVdmcHYrZGkz?=
 =?utf-8?B?S1dORG1jM0JvSE94MFVRU0pmY0dHZEhTdW81aHlRcFRsaDBIaG1kWE44WTd4?=
 =?utf-8?B?dTh0MkVLRmNELy9uOEZrbHhvZWNkaGl5TkhaRG5UMkN6QTc0ejBja1E2aUxv?=
 =?utf-8?B?QTltNitDSjRlT0Y1RzRTdVdlaHJ4dHhiUkEyQmJTSmpETDc3d25KcEs1UTUx?=
 =?utf-8?B?SElDL0gvZzdZZEF1dVVkOGkyQk1rU3VGY0FBVG1lTmhTWW92dG9Hb1NRM2Rv?=
 =?utf-8?B?WjN0SjFxYVc2YnFlWGZJZVdiblcyeVBZVms2bkdhQnF1SVZjWWovcHZ6bnJy?=
 =?utf-8?B?azlMMVpmeXBFVFVPOWRGUi81aHFrN3g5OXdYT2VUOVMwd3lwR0JIWk1EMTJI?=
 =?utf-8?B?SG9LNDNpcVZZMU9PdXJkOFA1SW5qRVU4aVViZHgybnlKamRkSzZTaEJWdGdQ?=
 =?utf-8?B?SG1DY0xNSlBEUVYwNUl1cG16dEE4NHZoY09MNS9OV0NTdFg2dExsamg1ZWkr?=
 =?utf-8?B?cEZjYXFnWkZjbXJvWEV6ajA2VlQ1OTJnSDhuL2hybjVlVGVtdFI5OHl0VmRn?=
 =?utf-8?B?bkIxekk4N25FTmZ0OXVQaDJwNW1XZ0Zycko0QTV3RndsYVJreFdJLy9sNjBo?=
 =?utf-8?B?ekhxY0dWODUvd1NCcVc5OXRod2NocTVQMTJzVlplaVRUQmZNVHJrWWhHV292?=
 =?utf-8?B?UUpHMVJrWTNkU2lPalRQYjVLSG9EcjVwVkpueU56N0RsQ2Rtc1lNd3YwbUtD?=
 =?utf-8?B?a3o4Mk1xTHBneEFlSXNoWHltSm9RdGVMd3Axamt0LzdsNmFZTDJSTEc3cjRR?=
 =?utf-8?B?ZXA0bFVYN3Mva2FlNTUzTnZjcGFCUVkzQmcvdTVmdGR6bCtYc2ErZmdJdkZr?=
 =?utf-8?B?ZTM2TUJmQUpzR3VzOGNNcGVlTm1rRG1TZDY0cnExRkZIbWN0RGFiUHBZODEv?=
 =?utf-8?B?c1VxK2plY2RzMjFJNGtGNnhVQXo3aExhRitTQ3AvVDhRdVJyVzNHb3luc283?=
 =?utf-8?B?WkZ3YnpxeVVmOEpkZ0FSRThacmpEZ0xVbTJ2S0s4RThzbEt4WmNmbVZ3bHRI?=
 =?utf-8?B?Tk8ySVJ2dzJtRDg1SjhtSVRSbmVUcjNDVDZyRStFUkRlNzZZWlpqa0Zia1lP?=
 =?utf-8?B?TkdhL1JLQVY3ODdrY3NkSzUreFd0aEpvaDdtWVRGK3Qvd0xjNHBoWElQTkpo?=
 =?utf-8?Q?6Q9+3I?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 13:42:43.6756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 628aafd8-95cb-4d1d-5213-08ddf782691b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170



On 9/18/2025 4:45 PM, Dave Jiang wrote:
> 
> 
> On 9/18/25 1:16 PM, Cheatham, Benjamin wrote:
>> [snip]
>>
>>>> +
>>>> +int cxl_accel_caching_disabled(struct cxl_dev_state *cxlds)
>>>
>>> why not just return bool?
>>>
>>
>> If, in the unlikely case, pci_read_config_word() fails. I can change it to bool
>> if we aren't concerned about that though.
> 
> I think if you hit error, you just end up with returning false indicating caching disabled (whether due to not enabled or due to error)?
> 

That makes sense to me, I'll change it over.

Thanks,
Ben
