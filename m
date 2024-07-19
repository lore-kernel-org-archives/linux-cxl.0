Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF243156
	for <linux-cxl@vger.kernel.org>; Fri, 19 Jul 2024 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721370213; cv=fail; b=RKo4jtM+FKal3Ya/0VrG7OhXEBilf9VEtCAMf+OoBAk3ISlfkUgRfLiX+6lmJg4LlVTRLJH1y0gJcH46Yv1/G8f+9W6xFPLtILzC4r2x/zN4y4soeUX3vuHFvNKj/cx/Xc1D0dDcro9wpvDPX+uaRTLoA6KM3UfM6UYSN6SeIZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721370213; c=relaxed/simple;
	bh=IPXxYIa2dlmV03p66JappmbvNnnrqOqRAkUEfo/SZwI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cGD/F7UEcZQq5zjO5hv+P4lYu0JAXS9X0QTOq3jq0hUFkjVif5pkKfGEhkahIOkdXHqSwktw1SpcYJTiJQy5g/dyhFNqs/R0mgQOfPYGtR0hz4+FVTmxbTKY6DmTBCukuDv+p8bqTvb7WEIa6cZHOCacKM1ntqRNmf3syFC/E8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ynqLLQqi; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ynqLLQqi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2RQfiQgcYmLVtuopaI+VDSNCoOsbmkvq6YrpjM+CnSVOScfbjgQ+8LSR6rJUWc3iT95QRIaN5hh0XqaehetOKEbA6dpdwIXPcic/xzuN39bNSO22d4dTvq34S/oZlYb1mk4/l11ZAABv7KJu1rf+BPPxqsmONjo9yOCqeHVZnQ4iMjxB8Q3lu7JuY3kuIfCW+chw1ZiVpNDrTwUyEi9jwz6LnjKF8syTXPsI314/5Sb59lp/4njtL/QPpbtZvfGD5VSssL1Swa93mEqwDNoIP/i293VGsq613w1ByvzCU6UG4FSA+FVYOnJTDkbkzmScoUlHlmVY0ZT+JJt7xRRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmREU9wIdF+5oZqiqkAW9YhumbHsyGtZG61b55sHKBk=;
 b=H7UZDdtP9EeExAQgKxMeEOQvU/uxQkiAinhxfZhB8SIZse9NOI/D0nxJUrDgRoL2ymQyYzhGmfAWAv+otyS/Tj4Yfb4+HtAudXLQ5UluYsxgdYmieLjaWbB7RZz84ZkCrW/4Xo4IADJ+H7QBZQLib2l+M6jn6MiZrA3k4yk7pQtNL//hTYnYliSRAfdeG06WJCBB6vXrxmFzLvA76H07LhVWCal2T0KjiPCHyFXH94NBK11qZixtmc2C2cBzzkJnu6h6ELsoVaWmIYDyK709zuH7ki+syoHnIhAw23+bxUC6+5OgoTLqHb1phYSBvqZhBaphsiMHW+Q7SdaKlmfd9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmREU9wIdF+5oZqiqkAW9YhumbHsyGtZG61b55sHKBk=;
 b=ynqLLQqio9N8c9yDhkwfdbq1nn1psk3/2GsAq9APHbnpoimXxZEsf3SngD+ePxJY5/iaHwmOIPbvZPfsJJu+dwptQ9O5rUQ0/QIn7I1vXjAupi4Guhle8kCPmrTdKiJ0pIM5Owe2eGswBGDBOsNk+/PCLPnUA1bL6vPl53u84Xk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 19 Jul
 2024 06:23:29 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7784.013; Fri, 19 Jul 2024
 06:23:29 +0000
Message-ID: <6182d104-808f-1edb-9ea2-387c7844dfc5@amd.com>
Date: Fri, 19 Jul 2024 07:23:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 0/13] fwctl/cxl: Add CXL feature commands support via
 fwctl
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20240718213446.1750135-1-dave.jiang@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240718213446.1750135-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::32) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: f6bed2f1-9c1d-4959-0099-08dca7bb4e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q25iTWtianFDeW0rMGZ6MXdPRGZoSVpKU2FBc0hUUHJyRFgyM2F4aE02dVky?=
 =?utf-8?B?M3RlL1N1MXQ1NUFNN1B2cUVZR2QwbDhQQndpQ3pSRWpVTGw5dy9yVGcxOWNo?=
 =?utf-8?B?L1dUTjVaTlIraVd3Ym9YU3ZWODZScytvWDUvdnpJSXh4d3ZtdFNEU3E0eHl5?=
 =?utf-8?B?TXdISDFGQ2t3WjZzMzZ0WkRzNEJrUEM4MmpFdFo3MVkvRi9HdmZuY1YyaEY1?=
 =?utf-8?B?eElRNzh2REtFcGx2RHJ6aXUvYjBtSFBiNTlEQ28xWTAwZXRmYVN3cStuc3pJ?=
 =?utf-8?B?SjgzVG5QU09VMlJ2R2pUYTl3RGpxODk0WDFiRnF6SzJmc0x2bmJwVkxDRDhL?=
 =?utf-8?B?NUp3UFJIdFFFaktiNGkyZGhxTHFWNjk5dUQ1alliNkM5TVNTWFhjZEhUQ29q?=
 =?utf-8?B?L3A0clI1VUtXS0wweXNQUjM3NEs5Uk9LekhSb0tSRkhYYllvL0FQYXRPbWh5?=
 =?utf-8?B?eExUMnUxd05JNGVSdnQzSkhsdFJvOEZIWW5UYlR2anBRZWtOcW5vbnpSTUdW?=
 =?utf-8?B?RlA2cWJ2TkNmTnhqUTllVzlHcHRlMEp6L1BQWEJUdForMFMraUVaSGcxR0lP?=
 =?utf-8?B?WmlFTFZ3QmY1WFozN3lHWXhka0xpcHV5R29YbTFBTis1ZThDS2RRdnc2N1dS?=
 =?utf-8?B?ZjZkc1VrZHRVdTV3dHVQRlpmVFBPZEp6b3BYTlVwbmprRFVydVlSSkRLV1B5?=
 =?utf-8?B?VHZyZldieUxoQlZRZGMrM2IvdE96TVJtcDhJUS9CVXRPSVpxakRyTnJ4aGl6?=
 =?utf-8?B?c3Jhd3pMSkQyVGJxa0d1ZncvWkw1MGxaODBzNVVoaHpidXI2ZDVpRHdjM01s?=
 =?utf-8?B?VHVnNEpjZ2Juc1hnZUlNejcxd3ZnNFlwSEdZVmMvOG9SM2kvVDlSSXJYc3hy?=
 =?utf-8?B?UFdHTzJXdWhVUFBRem9zMWdMaHJoZ3VCaWFDY1lWK2trQjJOOVdJUmNSRk1J?=
 =?utf-8?B?UUxydTk2Rm9IYUxGelZuaW5QOGEzOWRJOHpQczlmbm5rakozbjZKbFFHNGZM?=
 =?utf-8?B?K3VPZGNLVm1rRzF2VThJZTFJSlJHcnhhY20vZTQ3MVJVMVpMTzZ1S3JUR25Q?=
 =?utf-8?B?SVVpR1NnUVluM0NRNXB2OUtNaG1xa2UzZ1VFQmN3RFVaSk8yN3lOL3hjT2E1?=
 =?utf-8?B?cVE0alhtQ1NHSGxUbyszTVFGb09TOForbW9VNlpybURwMXMrRGs4NlZwT2VT?=
 =?utf-8?B?WWRhSWRQUnBYMkdYSjlVUHhRT3ZMd1JwUW1JNnI4SlNrVUNXSW12ZmZvb05j?=
 =?utf-8?B?NWJHWXNSaC9DajhJdHBmMDQ0MGZhYTN4aHBVbW9wZVFCakRua0hQN21ibW13?=
 =?utf-8?B?ODdOYk1aZnZGZW1WTHo0aEFXTXRkemZVRExiZEc5TWhZMy9LT3FtQjBWSkY4?=
 =?utf-8?B?UkFYZXJjMWJPcmo2TUJrQ0dRMk1mS0tBK21wUUUyQ0NZZStRRGRpN3pkUm1U?=
 =?utf-8?B?Ty9tUjU4R2ZzZWpxTEdZVlBheWFEa2RmZnNIQUk1aTRQaGpia0RGK0FLeWNE?=
 =?utf-8?B?Zk9uajJvblc0UDNhR0MvOElJOXh5M2dpcFNxUnZ1SVRqWDczazJpRzMzSEtw?=
 =?utf-8?B?cytWd3FoMUg0ZXBuUHU2WEVNdmxlbHZtWEUzbUhSc3hTZUZNVllGczRJbGZS?=
 =?utf-8?B?UUhTQnRBcGdRV1RkU3p4a0tZLzl5Q1BiUU02MkkrdjFyWmxhMWc2QTA0Yjh1?=
 =?utf-8?B?OFBqSjM4WVhNMnlpSTd1MGQ0cjhiUU42dmRuaW9YZ00vK0xxOEJsTDJ4b29D?=
 =?utf-8?Q?bT3MCPVjdansP+8xYY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M21uT213ZE5JcHJNMHF5ZTloL2NvZzRsVWFWdzRCQ3psbXdXQTNOVWpPQUlW?=
 =?utf-8?B?VUcwNVRLL2o5b2RudEJjWEk5YVR1emJzQWdJU2lpYXFYY1ZkVk10TCtocENw?=
 =?utf-8?B?VjMzS3p5QS81c09rN3RkQ1FtMzkraytiRmtFbmtOdERVcnc2SExuNk0zZ1Ay?=
 =?utf-8?B?RFVyTlNzSHE4dGg5c3FCRy91SkdaT3lIWCtKcEJNWWhIS0Q1dTlGc1ltbnYr?=
 =?utf-8?B?OWZwK1U2VERuWWlQMWFsbnUyT044OEpKOXI5cFB2NnB4bVB3WmNYUW1SRjRC?=
 =?utf-8?B?V2lGTFdGNkJYdnlCcWh2ek9uNWQ4ektSYzRkUE9ORW5pTGlEMi8zYmtlRCtZ?=
 =?utf-8?B?bFJFczFGaVVBejkzN0p5aS9wUTdpU3N4YVhmZENLWURDVVFKRGdJankvN2xo?=
 =?utf-8?B?MkI5azh4OWxWY3J4dmFwRGd2VXoxNDdBSXpFUFR6WGVtZzZ6eFlsMmlvU0Ez?=
 =?utf-8?B?OWUyQkQ5UmV4dFJBUGRDYmZNbTlNU1VrZDUxWDlKT3dWS2J2bWFSK2ZtdFJk?=
 =?utf-8?B?NlZTTFVYU0xWbW5hT09xL21hQXNKOXo4Qyszc3ZudlRBQUFXZ1VPQmRHWTdI?=
 =?utf-8?B?ME5QTld6SDdWaEhuQzd4OElVWVk2eU5Pa2kxYVZJVW4zRHRGQWR1NDF4UFN3?=
 =?utf-8?B?RjhnbDE3U0xsS1ZUK21yMFNWQzN1NDNtRk5CSXhXTmt5WWNDRTZieTFpNWRC?=
 =?utf-8?B?TjF4MUtZaFlCellrRXpZTmdYQ2MvNzVFK2JyZ3V0WHJUanNrNm9sdm9GOXBw?=
 =?utf-8?B?WkdQMWE2MGtGUkhBdnNiN0VwcjBKOWlhWEpLOCtVYlI1enozSTM0Q0VBK0t6?=
 =?utf-8?B?Wnh0WXkva3BUQjhNaTBneDlkcElseVZZZ3p2U0JESmd1MUZOWWZTWnJyVTQy?=
 =?utf-8?B?dzVla3A4eGlBd1ErOWxianlkNStnT3hIVklWRmNuUTVsVjJtZ2lMOS8rZ1VK?=
 =?utf-8?B?TjJqRVZhMHUyMm9lSnlnSjhaT04wSU4xd2pxVDhOb0xwT1FLNXJOSFhrVVg3?=
 =?utf-8?B?RFNZZzF5L29mZU9VKys3THJVV21lTTdyaTVVVVl5MWQra1pEQjlUZitKNWVq?=
 =?utf-8?B?K1J5S1o0VmFhS1E0NFBLSXY3dFZ6cVM4QmRjUUwrYXJOQTJESHNrMjZrWVhB?=
 =?utf-8?B?Ri83aW1rMlFmQ0xnTGl0ZExTMGtDem9XOHgydTJrSlNFNFgyb1NoQ1Z4WVJD?=
 =?utf-8?B?T2pCS3ZiY3FlbGlzc2I2UEhlZUdFeUI5RkRKZ0xZYTVJUTlYcnJJVEgxRDlt?=
 =?utf-8?B?S0NmZVBMcTEvVjdPU0tQNVh4WXlaY0E3V3JCK2ZIN3lRWE85bFYyY1ovZlVG?=
 =?utf-8?B?QVcyc01lUms4NTF4am5EakN1K0NWakVPak9YQUFSbHQwNWQrN09rTGFmWGsv?=
 =?utf-8?B?Q2I0N0M2R0FFUzFtSXFVVEdSdE9SL1pQUmhMTTNDK0NIZzk2ZnNLbTRFemRN?=
 =?utf-8?B?eDY2QXVlOW1zMFRia2hod1pBYTRPeFY4RDg2TjNnWHFaZlQwS1BPbEFhazVh?=
 =?utf-8?B?NUtCYVR6ZW5qT0tuQTZzbWZmUEZ4VzdRa2ltYjljRHNNampPTk5VK2JObGhD?=
 =?utf-8?B?ajhaMVdCRTdkbzhIMi90SXNXQWQ2YkNoOE4zZVhMMVllZ1hpZDZOTGREcXVo?=
 =?utf-8?B?Wld6SW42R3NNNCtzZk9ENEl3UE1LNzc4bDBqMnVmUWtWc2lWZ1cxTjFXWmZh?=
 =?utf-8?B?Nno2MlVqeDdobkVXZm5SQVVvWnpUUVNtNXRYUXM4QUwyODR1V0JqVFJjNHZY?=
 =?utf-8?B?c05naVliWkVlaWkwYzFOSUxzMHZiZGZCUlhFSGZ3WGJ2RTV5THUweU80MW5v?=
 =?utf-8?B?bWRyQnp2TnY2d0dwcXhZVWVCemJWLy8vMk1wcjBhMjZHQzZPQ1NBYWFtRlZC?=
 =?utf-8?B?b282cGE1QkFYTUdiekNWa1dKVmVSaHNheGl6eXJSdVU2UkxWelJvMUl1dTRo?=
 =?utf-8?B?VHdheG5PeU5TZ0hVMkJPeTZ0M0NlZzRwRDk2cFJ4Nlo5VG43OWhEL05nK1Ra?=
 =?utf-8?B?RHk1N2VQbmtlclI1STF0K3A5L3l0NHhwbGZSYldKUmNvWVg2UVcyclNwSXpo?=
 =?utf-8?B?V2lDeGZGQURIeWFWUXNFSmM5d1IxdzlYR3Vjdk9uYUxsQjNCanZqbjVyV0wx?=
 =?utf-8?Q?IgsfqR17fkqbyM1c4rNdfhRpn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6bed2f1-9c1d-4959-0099-08dca7bb4e04
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 06:23:29.2617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwQSxne4JK/J9IrAHGENU4w+PdnMuMbTbmQe6H7Qi4aUHijqwNlqT3gbleeCvlsXEOx2Ob7o4V0E01Vysyv2DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207


On 7/18/24 22:32, Dave Jiang wrote:
> This series add support for CXL feature commands using the FWCTL framework [1].
> The code is untested and I'm looking for architectural and implementation feedback.
> While CXL currently has a chardev for user ioctls to send some mailbox
> commands to a memory device, the fwctl framework provides more security policies
> that can be a potential vehicle to move CXL ioctl path to that.
>
> For this RFC, the mailbox commands "Get Supported Features", "Get Feature", and
> "Set Feature" commands are implemented. The "get" commands under the
> FWCTL_RPC_DEBUG_READ_ONLY policy, the "set" command checks the policy depending
> on the effect of the feature. All mailbox commands for CXL provides an effects
> table that describes the effects of a command when performed on the device.
> For CXL features, there is also an effects field that describes the effects
> a feature write operation has on the device per feature. The security policy
> is checked against this feature specific effects field. Looking for discussion
> on matching the CXL spec defined effects with the FWCTL security policy.
>
> The code is based off of the latest FWCTL series [1] posted by Jason on top of v6.10.
>
> [1]: https://lore.kernel.org/linux-cxl/20240624161802.1b7c962d@kernel.org/T/#t
>
> ---
>
> Dave Jiang (13):
>        cxl: Move mailbox related bits to the same context
>        cxl: Fix comment regarding cxl_query_cmd() return data
>        cxl: Refactor user ioctl command path from mds to mailbox
>        cxl: Add Get Supported Features command for kernel usage
>        cxl/test: Add Get Supported Features mailbox command support
>        cxl: Add Get Feature command support
>        cxl: Add Set Feature command support
>        fwctl/cxl: Add driver for CXL mailbox for handling CXL features commands
>        fwctl/cxl: Add support for get driver information
>        fwctl/cxl: Add support for fwctl RPC command to enable CXL feature commands
>        fwctl/cxl: Add query commands software command for ->fw_rpc()
>        cxl/test: Add Get Feature support to cxl_test
>        cxl/test: Add Set Feature support to cxl_test
>
>   MAINTAINERS                  |   8 +
>   drivers/cxl/core/core.h      |   9 +-
>   drivers/cxl/core/mbox.c      | 607 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
>   drivers/cxl/core/memdev.c    |  78 +++++---
>   drivers/cxl/cxlmem.h         | 141 +++------------
>   drivers/cxl/pci.c            |  68 ++++---
>   drivers/cxl/pmem.c           |  10 +-
>   drivers/cxl/security.c       |  18 +-
>   drivers/fwctl/Kconfig        |   9 +
>   drivers/fwctl/Makefile       |   1 +
>   drivers/fwctl/cxl/Makefile   |   4 +
>   drivers/fwctl/cxl/cxl.c      | 274 ++++++++++++++++++++++++++++
>   include/linux/cxl/mailbox.h  | 175 ++++++++++++++++++
>   include/uapi/fwctl/cxl.h     |  92 ++++++++++
>   include/uapi/fwctl/fwctl.h   |   1 +
>   include/uapi/linux/cxl_mem.h |   3 +
>   tools/testing/cxl/test/mem.c | 292 +++++++++++++++++++++++++++++-
>   17 files changed, 1515 insertions(+), 275 deletions(-)
>

I can not see any documentation change in that file list.

I would say for something like what this patchset does, it is mandatory. 
Isn't it?

