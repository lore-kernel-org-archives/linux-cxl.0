Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930031D3590
	for <linux-cxl@vger.kernel.org>; Tue, 19 Nov 2024 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035143; cv=fail; b=c3ojEXay3O27ZFkVfVco9Ss48Y2G/zFvinoNJyYpJZpbpYcu4xOEA0ebDhnLl7oWhdcVjeR1ZMvJAzl2AqLj+NfK3NhGaEO02F37wLgJjPT06EoRWFc7PC7HHH/zHRalGV6XtHKj2JEUPYq17lsSaAD3ie4ir0PON+cKT4GpDys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035143; c=relaxed/simple;
	bh=I6CWxnY1RT9onukN5HQNfNvFt1WxYkuRvQEONxmOaDs=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=J4XgvFqc3KvXq3cfsNqRIUqYKDPrqmMypM1uFu86noGwx7jqkQn/kkbJ2c6w+7qYH8FOEbK9la8zFQ1/LBMzZaUK98oIIlc7JLPzzlOeFABD8FbA4HqmaYWpdvPpRTW5qHbApXG069mXAUtcF/roV7+ZTOSqjcIqiur7GxNwkdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RLc9i8nm; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RLc9i8nm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejTN3wxTs11AYFyGLjz/w1Fdjg2EWPr7qy0OJ6bAi4UF3sLAf/DrcU/nR39U+BFlzeUyaEQrY+M8NTved81XNzgkcivEzog7Aw5WlryT9lpxoBsUt3QQawNg9WMofREwqinTGN29NzpyVpxtbFIN+4iDHYjrClDjoZfO2qvT9zw6OiQgJCD5vPjOzuAnaKk2qBHhuzKeTZhaZxCSChAcsjdJg2nLIDjkjAZKaTSnwpLo/YStY7yuiR8xNT3LGlyI9hMUScH+wOnIlp6PCBgLsqCfXbkQU5GP2vQtb0SuuGq+hKm0UdChOT3XSBz71ebwDhK2H1OGeuVMC6H8FbW23A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffGd5ZpLuLKHzeZYN9EqNEzJa80bdUIvBzQDaBWwLBI=;
 b=YbeT5nmimZ2SluTYmbzu8Wkgy2lBHoaGYWdWY9LQWPMoHTEDg5x8TZkLxuMxUnVk5u2F8ndfYJrBN9VZBRyseEqwem85nmCmdpg7nbPUSwnDhO3+kPcMlLtKHfwYZ2CxlKotOSgzgmdXGer8BW5OYUORd3/dk0E2PuzM85Loj7BqieWFEA/ndlC2CKFfQkgJVR0KcJjavyJm5Evyh5fhvp6jKttL+eMWXnS0WJk9JDCOy7fIEy8XxPARfKVwEo7xzZcIwllpUlGXS2MotTplx5XBRSy1zty5oX5O0QPObcrlJk6BpDBAZ7Ya5/8zvWlE41FuSaONH6EigsaMudq5qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffGd5ZpLuLKHzeZYN9EqNEzJa80bdUIvBzQDaBWwLBI=;
 b=RLc9i8nmF9CS0mtqODIu0zA1CQBP8bWEdXb6Gmkb7gbmskA1VU+cnPLybPPO0Cj24OC+NbWoaPCgEfQAmGvkvl5Lvb1y8oXtbdGq61VwN+SkeB/EnIMHeE4PT0kwPNGUIhyJzhrEE0ATNjjV2ONrhqm9PGlRDbt0RugGHXTdh5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Tue, 19 Nov
 2024 16:52:18 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 16:52:18 +0000
Message-ID: <cc2525a6-0f6a-c1c8-83e1-6396661efc8a@amd.com>
Date: Tue, 19 Nov 2024 16:52:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 iommu@lists.linux.dev
From: Alejandro Lucero Palau <alucerop@amd.com>
Subject: RFC: Kernel CXL cache support (and IOMMU implications)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0595.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: 54eb8cf6-c7b6-43ca-8dad-08dd08ba8766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXlFMERxa1kwRDV1Q3RNTUYxTDNpdURWaFUyR2dHdzllckQ4NGtKWFQraHVz?=
 =?utf-8?B?SkJUMzRhYytXeW9hdStpL2NVaHJHd0kwSisvcHpFQ0l1SXBqOUxXZHY1Q0p0?=
 =?utf-8?B?dU01akhXenM2Q1ZwUkFkWEhSWWw0SlRaNFhhZWRTc2JWZzUxUkIwQnpDQUJP?=
 =?utf-8?B?eE5OSzZOeE12REVWZ0pBZVNNc09GUkhTdjlxN0lhaFVUNzVCTzFudkR1dGhY?=
 =?utf-8?B?eDhiRFNXZXRMb2k5cW1zLy9nR3lZVy9QZUxLcHFYQ2JnNE5FOHprOWs2OGJ0?=
 =?utf-8?B?bFd3Qnd5Z00wWnJKaXRGemJPREdmWjRwVytYV01QKzUrMlZsU0tQZXVaMFNJ?=
 =?utf-8?B?L3FJYTl4T01DdlE2ak5LM3VuMHRwRkQvUTI0LzBwdTBPdkVYVlUyRUQwYW53?=
 =?utf-8?B?cC9TNVlrbkhUMktCVFVFZXJFRk10bG0xWTdxNWJQVTRDb1RlODRkOEJqdktX?=
 =?utf-8?B?VlNDVWtuMWdnK1RhRDZXOVk1NU5LWlZuUDZtVVFCSit3Sk04TWptOEJsMGZL?=
 =?utf-8?B?MUx4ejhrV0JkakpOdEIvQ09qRGk2STg0cXRZdlBQSHVwYU1lb05kRGpZbGQ4?=
 =?utf-8?B?SUJtdXpTeXoxVVRTMzlIZ2hNN0lpeG1TSjJSeWwwUmh1ZmR1dTE3cmxHRzFK?=
 =?utf-8?B?ZzZ3amRseE5objhwUlh2R3o1b2hWYzBiODZSR1dCOHJEYXBRZVduekZkSytz?=
 =?utf-8?B?WFlqcVo1NHYzK3BPaHhtQWJqalFwTDUzRTgwMzlya20vMjhyK3V3ZVRVN28z?=
 =?utf-8?B?bFF2VWRrdmM0QW1KY3psclBqNmxpWFFtZnlRTDN4US9KNEhrM1FvZjBEVEg5?=
 =?utf-8?B?WW1CVSsxVU14c3labWhYRE9CVE1XRlJMdkhDcUVaaGU2NEt6bjZTZ3E1ZlNv?=
 =?utf-8?B?N2l6N0lLYUY5d1BsS1hkazB1ak8zRTJYSEZHVVdXMlhmc3JLK0JwR1h6bHpM?=
 =?utf-8?B?WEMwdTB1UnMwQTRCMUdmTmZpMGpyVE5IRXQ3MVplK2V2dGVuL2g4b1ZQRnpk?=
 =?utf-8?B?aTRYNk5YNG1kZUtzSkR0N2Vma1lKTmVuZGFPUUFXaUo3M3ZKdjlKNWVISUFH?=
 =?utf-8?B?ZzV6N1g0OGgzUHV4Q1R4UUhpSE9vdFdNUU5JRGhVbzlLZzZscjJ3R21GeTV6?=
 =?utf-8?B?Q001NWlxeVZaZzRybEJjRWFxRzdUSHA5WU8wY0NaR3hEV3RzMlhGZnJqcUd3?=
 =?utf-8?B?T0xDZ1hHRjR1Y3N5cnNpb0NyRkVHaVNsQ3VHcVI3UEhOcm1Rc3dJYVN2TEFo?=
 =?utf-8?B?dk9HeVo0SDRhY01DTVl5UFdzbWR2LzF6KzJhWFc3QzNKT2x0RVBxa0txTXIr?=
 =?utf-8?B?c1FoVEJsb1ZPSkFIU2FhOGlhc0ZjaEJod0V3cDJTU254M2dwOXk0Q0VmN1N2?=
 =?utf-8?B?eThKQ3lsU2lXajRCYnZaajVEdkZCSjd5MkNud3BzL0wxQjJWeUVYMElrK0pQ?=
 =?utf-8?B?UXRPdzhWZkJHaEdacUp0bXhObnlJWDNDaGdjby81d1N4dm1XTnhZYm9pamtY?=
 =?utf-8?B?V1hPckFKdDlWb0FTNVBvcGY3RUVkM0FBYkxybG5qVlZZQlVBaUxRcjdEVzVk?=
 =?utf-8?B?TmRsTDQ4eU5QcldZbkx3WWRMTUE5clJhZGFvRGZzajJtbXFvTEFVNFBRQ2RR?=
 =?utf-8?B?ZS9SWS9GK0JVbkR1RVU4VHdqQ0VlajVscnFHZUd1bFBWT2psalFKODZHaEI5?=
 =?utf-8?B?WVAzRE56R2tCQis4Uk1YZWYvQ2ZXR2JLU1lRVXZGVmVjZXA4ajVkRUZKdHRt?=
 =?utf-8?Q?K3ZSFcO+HdhTAvxxUq99p+u8mnyZNLxp9OH32Zo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmhDQUxxdy9CeG9wTnBkSDAxZ0lvT09nUzZnUWlCWEFrR2Z5WjVPckRxUisx?=
 =?utf-8?B?aHNDQTRMSmFwQVdrYVd4YzFVOEdWUDZzZllzNytGdk0vUVdVOFlpbVBrNW9o?=
 =?utf-8?B?V1piVVROVm4wdkZtZ3hRRjVVQ3F6T09NQUJxL0JtZVRGZktSWXphRVlJTVpB?=
 =?utf-8?B?TWU2c2F5Q0k3QjFKeUg4TWtEU0o5a2VDeVljbjQzTVJMMUdwUjJUNmJ4RlA0?=
 =?utf-8?B?dHhWcGxlUFFlVkNhTXZNUHlLOFBkUFl1WmVteUhybDFFWUhERjFtbXRlMmxx?=
 =?utf-8?B?anNvdG4wbGo4amNzK1l0b1RsOExkZzBxdEE2anlvbDZWUDI4ZjA3QzNSaXhm?=
 =?utf-8?B?ZTZVREVJaFI5QzJiWFBCTGpxeVVCc0doUmRzNTRBTXBrQVVtOSt3OEp2T1cy?=
 =?utf-8?B?TUh4dld0empBVFF3elJ6QU9nZ3RDbzRQK0lyb1ZieEFCVnhyV1JObzBWM0VO?=
 =?utf-8?B?cHc1NXhOVnpOaFFNL3pzTnhwV1dqR0F0ekthY2dnK3pTc1hzZGhvbEFBS051?=
 =?utf-8?B?SVhjYUJIYjNZT2pyUzFkMjlJZ3lWYUlXZytleURxZ3d5NEdtaXkvOTJUc2o1?=
 =?utf-8?B?UGw5SXUxM3BnQkR2Zi91WUdEcnRRTFQvdUZsL2RsTHhNaVFQRWtDVDZicldM?=
 =?utf-8?B?MnYvbTlKSFgzRGxsMFJyNitlaCt5aEtuazgyVCtmMDNYcWw3YjUzemQ4dTJa?=
 =?utf-8?B?eWY5NDFTNm82UjJFU3hhMDE1MDg0dERQemthYmZrc09WZDBWOWpwM3RDTEZX?=
 =?utf-8?B?M0x5akRFb1VvVVc3REZVa0lZS3hRY0FOQ0I5OFZvUFpQS3FRSFd0U3VieEpZ?=
 =?utf-8?B?VWdpVGtEc1loOUhpMEtIU1BBR25Yd056MVVXbXcwTEppQkUyNXVwc2hET1VI?=
 =?utf-8?B?VU9qaTBXVlZFV09mV2t3OTBJVGtWM1lWODdmVlZPMC9POGpERnFoNHlDazZr?=
 =?utf-8?B?T1l6dUttd2ZsTFV4ZndkTFk0M3RWMjRYSXVYc20vSHlBS0lFbHhwTmxtQ1l1?=
 =?utf-8?B?OGFhSllNME02SjlnTzNhMlZ2TVUzM3FvODFURU9HSFRpUVZLcVQvcFB5TVFN?=
 =?utf-8?B?Y3ZlYXhVdVAzb0JaZFhRVVdGdXpxSG1HeG02SXdZYjJOWkxWOW5EODVmU1Rp?=
 =?utf-8?B?SFY0NkJ4WUJnNU9yS1RQOEdyRVQ1dlJOYVQwMVowMlFSd2dyZGRVOHBlem16?=
 =?utf-8?B?SEpXUE9lLzdWWmxKSjFldER1UlFRNnBTRDBNdW54MVJEelNLYmZNUVBPZldX?=
 =?utf-8?B?UDRJckdqekhadVRJM1dLZjIyL0pHOXdyUSt1UEd3VllNR05YRG53RlptUm9D?=
 =?utf-8?B?bTlVMmc2RS83bHZsbkdwVUx1K1BuaFJKYjlJcVFXa0JDbi9LZTNabjBqdTRV?=
 =?utf-8?B?S2tZRHJkWE8rUHh0NDZrdVE2L3Z2R0kwRVJoR0RDZGNaeWR3ZE4xVjk5T3I4?=
 =?utf-8?B?c2d2cWM1ZGw5QWVZSlB4OGZlaU1pRzUrTmlrVVl3T00vNGU0Zjk3K21jRVFB?=
 =?utf-8?B?ZFhPV3hhRmxIQzdEcFc3YTJpYXJTLzExb2FxQWRMYXFCaktvc1F5d0llL3p5?=
 =?utf-8?B?elFsbzh4OTNhR1NZdUh6N3ZiblRiQWRNY0JEZTBFdjJmUkIyTXBLcXZjWml5?=
 =?utf-8?B?QUxRZ0g0YTk5RkJJZlh4US93OTlnMWtLL1BTVi9Ba0UwcmpiRllkcTc5dE9r?=
 =?utf-8?B?cTRxN1FJRVVpcDBHMlRzYmJxY3ZPTkdUdnpLdnNPaEl0TTdnUVVDQllhcTFv?=
 =?utf-8?B?YlBnWEZOSnJMUWQvckZ1SVJhTHBIWDRobEN1dVdlK2FiOFBDR2pxUEF5VldD?=
 =?utf-8?B?dXgvMWk1eTJGUlgzV2UyUkNQZVgzMWNSdW8vN3NBTEpNbWo5TG5oaDZvVGNL?=
 =?utf-8?B?dzNwN1NIc2FWOE1RQUJoM293b3Z4V3ljQ29WMitPS3MwdFBYRHhpMGVKdVdE?=
 =?utf-8?B?dW1vdEsvZCtSSUJtVk96TGNMNmVLckhxaUpIb0w1dzRDMnlGTzYxM1NNZDFF?=
 =?utf-8?B?aEZMNGFQU2ZrUlgvV2tlWXd6aFpvUU90NDd3NG9zaWxEbUVTV2M2ckpYS0VR?=
 =?utf-8?B?a3BSUGE4Yi9vWEp4VGp4YXNmcVdqNkU5VjJZSmJ1TTFoN0NtakdVQVVYblZW?=
 =?utf-8?Q?nE7cjJb77VfkcXmciNRydsSAu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54eb8cf6-c7b6-43ca-8dad-08dd08ba8766
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 16:52:18.7682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YF0EGaJwAZsctT0beLy7QuX1V6Mzu7RBNHz5BBTbwPHGbr+Y1aSdw/I0vOH0miv7lcL8R0vIE0P735h7EWJMRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070

November, 2024

Tittle: CXL Cache support by the kernel
Author: Alejandro Lucero (alucerop@amd.com)

Version 0.1

Introduction
========

After the LPC where I presented the current status of the Type2 CXL.mem 
support
patchset, and some ideas about supporting CXL.cache, it is time to dig 
deeper in
this second goal, and discussing the security/reliability aspect as well.

It is also important to try to describe how this is going to work and 
what the
kernel needs to know and enforce. Reading the CXL specs when having in 
mind some
specific use case can easily lead to assuming certains aspects with a 
different
perspective from other readers/use cases. To start with, it is necessary to
differentiate two "CXL cache" functionalities when a Type2 device is in 
place:

1) A Type2 device caching Host memory.

2) The Host caching HDM memory, that is the memory inside the Type2 CXL 
device.

The first option is also what a Type1 device can do, and the kernel support
needs to manage all those Type1/2 per CXL Root Complex knowing the resources
limitation, that is the snooping cache size.

A snoop cache allows the host to track which memory is being used/cached by
those devices, enforcing the cache coherency. The specs are not clear 
about some
important aspects regarding how the host can enforce the proper use of 
this by
devices or even if the snoop cache needs to do so. At pages 786 and 787 
of CXL
specs 3.1, how the system software should deal with CXL cache devices is 
given,
but this is inside a Hot-plug section. I think we can assume the Host
firmware/BIOS will follow same approach for enabling CXL cache, and the 
kernel
needs to look at those devices with CXL cache enabled by the BIOS for 
properly
handling the available space in the snoop cache.

It is also worth to mention the CXL.cache protocol can be used in the two
"CXL cache" functionalities listed above. However, the last CXL spec implies
CXL.cache only used for the first case. Some comments about what the 
specs say

regarding number of devices with a cache for host memory:

         - up to 16 Type1 and/or Type2 devices allowed per VH.

can be easily confused with the limitations of just one CXL Type2 device 
using
CXL.cache for enforcing coherency of its HDM. This limitation is 
overcome with
forcing Type2 device using HDM-DB, which relies on CXL.mem instead of 
CXL.cache
for HDM cache coherency.

While the Host is assumed to be able to access HDM in a Type2 device, and
keeping data in the host cpu caches, it is the Type2 device 
responsibility to
properly manage cache coherency of its HDM. There is nothing the kernel can
control here.

Therefore the interesting part and what this documents tries to cover is the
Host memory being cached by Type2 or Type1 devices. While the main goal is
discussing how the kernel needs to handle this, and to describe how it 
should
work when CXL devices are used by the system/Host, some comments are made to
cover the virtualization case where those CXL devices can potenetially 
be used
(device passthrough) by guests/VMs. I try to expose the current security
problems where IOMMU is used for restricting what a guest controlled 
CXL.cache
device can read/write in Host memory what I think needs to be clarified by
hardware vendors.


Understanding the memory accesses from CXL devices
==================================

For the sake of presenting the case about kernel CXL.cache support, I'll 
try to
explain how it works (I should say "how I think it works") and the main 
points
to discuss regarding how to implement this support. So, do not take the next
explanation as the definitive answer or guide, and if you think there 
are errors
or maybe too much generalization at some points, please help fixing or 
adding
further details. Also, consider some parts as just me thinking out loud, 
what
maybe help other people (or confuse them!).

The CXL.cache protocol allows devices to be part of the coherency ring 
of the
system.

Let's start with a Type2 device reading from a specific host memory 
address. The
final situation is 64bytes (cache line) from host memory copied to the 
device
cache, supposedly for being used by the device/accelerator. If the data 
changes,
because some host cpu modifies it, the device will be signalled by the 
coherency
ring, so the device will know. The important point here is the device can be
told because the Host knows the device has a copy or the only copy of that
data/memory. And that is thanks to the snoop cache implemented by the 
CXL Root
Complex.

A device caching host memory can be used as well for writes to host memory
through the cache coherency ring. A device can not just read host memory and
keep it, but it can modified it. The implications of writes versus reads 
are not
important for the goal of this document. It requires the device to 
support more
protocol exchange cases, but regarding the snoop cache, it is irrelevant.

There arise obvious questions about how this snoop cache is going to work.

First, with the simple case of just one device caching Host memory. From the
specs, the device CXL.cache should not be enabled by the Host if the device
cache is bigger than the snoop cache. However, what does preclude a 
device to do
more memory accesses than what the snoop cache can cover? This can be partly
explained with some allocation control for CXL.cache what is discussed 
in the
next section. But a "rogue" device could try things like this, what for 
the case
of a single device using the snoop cache and without any other concern about
security, is probably fine:

         - With a Type2, the snoop cache will tell the device to release 
another
           line, meaning any modified line to be sent back to the Host.
         - Any performance problem will only have an impact on the 
device itself.

Then the case of multiple CXL devices caching Host memory in the same 
CXL Root
Complex and therefore same CXL Snoop Cache:

* How can the snoop cache track reads from different devices without one 
device
   monopolizing the full space?

         - enforcing snoop cache slices by software?
         - allowing specific/limited host ranges by the kernel?

AFAIK, there is not any kind of hardware control for avoiding this 
contention.
Note that with the proper checking by the BIOS and by the kernel (for 
hotplug or
those not enabled devices yet during boot time), the size of total 
device caches
allowed per CXL Root Complex should not be bigger than the snoop cache 
size, and
therefore theoretically no contention at all ... if the devices do the right
thing. From software the only thing we can do is to ensure the CXL.cache
accesses from a device are within a range with same size than the enabled
CXL.cache.

Therefore, some memory allocation API is required for dealing with the 
amount of
memory the snoop cache can track, and the host memory a device can 
access to.
The device needs the physical address to work with, and it is in this 
required
translation from virtual to physical addresses where we can enforce the
restriction. Of course, such an API does already exist, although not 
with the
checking we need: the kernel DMA API.


(Secure) memory allocation  and CXL.cache
===========================

DMAs allow devices to perform read/write operations to system memory 
without any
cpu intervention after the (meta)data about how to perform the DMA is 
given to
the device. CXL.cache is more than DMA because the system memory caches are
implicitly involved but for the sake of handling this by the operating 
system,
not too much different. The important point here is there is no restriction
about the DMAble memory to be used by a device, but due to the snoop cache
limitations, this needs to change for CXL: code aware of the snoop cache 
state
and what a device requires needs to be consulted for properly handling the
available space.

Should we use the kernel DMA API for CXL.cache allocations? This API 
deals with
memory coherency what is not needed for the CXL.cache case. However, it is
connected with the IOMMU functionality what is required for CXL.cache if 
it is
enabled.

I think the solution should be to implement a CXL.cache allocation API 
inside
the CXL core dealing with the snoop cache available space, and to 
connect with
IOMMU kernel code when it is enabled.

A security aspect behind DMAs is a device has (usually) no restrictions for
memory access. This is true in a system with no IOMMU hardware, and 
CXL.cache
is not different in this case. With IOMMU is a different game though.

First of all, IOMMU will be in place for CXL.io, what implies legacy TLP 
PCIe
packets. A CXL.cache operation can not be handled by the IOMMU hardware 
and the
spec states ATS to be used beforehand, that is, the CXL device asking 
the IOMMU
hardware about the physical address to work with, and keeping that 
translation
internally. The CXL spec specifies ATS service extensions for CXL, and 
some ATS
requests can tell the device some addresses only to be used through 
CXL.io. This
implies some sort of knowledge about CXL is required by the IOMMU/ATS 
hardware
which depends on how the per device tables are programmed by the Host. 
However,
AFAIK, this is not supported yet by any Linux kernel IOMMU vendor 
support. Note
the usual IOMMU device/domain tables will/can be used for normal DMA 
transfers,
so IOMMU configuration, both in the Host and by the HW, needs to know 
which parts
of the domain are for DMAs and which are for CXL.cache.

Assuming this support will be implemented at some point in the future, the
questions are, when?, and, how safe is it?

Can a device issue CXL.cache operations using arbitrary physical 
addresses? It
seems there are some cases where the hardware can take control of PCIe TLP
packets with the ATS bit on. For example, if there is a PCIe bridge in 
the path,
and with that bridge using a specific redirection table based on 
configured ATS
per device ranges, any TLP with the ATS bit on will be redirected based 
on such
a table, and implying no redirection if no table entry. However, that 
does not
seem to be in place for PCIe Root Complex implementations. For example, AMD
IOMMU documentation states ATS TLP packets are not handled at all, implying
trusting the device, and if more security is required, the IOMMU 
hardware can
check those TLP ATS packets as well, spoiling the ATS advantage. Note 
this is
PCIe, so CXL.io will likely keep the functionality, but CXL.cache operations
follow another path with apparently no further control to enforce the right
addresses within the allowed memory ranges per device are used.

Because this apparently lack of security for IOMMU and CXL.cache, this 
implies a
CXL device should not be used by VMs or any other user space controlled 
driver
with CXL.cache being enabled. This seems a really serious limitation, so 
maybe
I'm missing something here.

Regarding virtualization, assuming the security problems do not exist or 
will be
solved, while CXL.mem can be supported with an ahead mapping by the 
Host, with
CXL.cache this needs to be handled when the related driver asks for specific
memory to access, and then to configure the IOMMU/ATS tables by the 
Host. This
implies the emulation needs a backend, what an ahead mapping, as currently
proposed for CXL.mem can avoid.

Finally, if my concerns about the security of CXL.cache with IOMMU are
unfounded, at least this document should describe how is this solved and the
security enforced by the hardware, and if the kernel requires to handle it
specifically (what I really think is the case, at least with IOMMU changes
managed by the CXL core).


Summary
======


Next the proposed tasks to perform for supporting CXL.cache:

         - CXL core handling per device CXL.cache enabling based on CXL Root
           Complex snoop cache state.

         - CXL core implementing a CXL.cache host memory allocation 
restricting
           the physical memory a a device can access to through CXL.cache.

         - IOMMU being CXL aware and dealing with CXL.cache vs CXL.io 
requests.

         - Clarify CXL.cache and security with IOMMU.


