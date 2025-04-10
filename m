Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C7E1D6DAA;
	Thu, 10 Apr 2025 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300051; cv=fail; b=G7TXjWixPIcvqZXL5DFK1dirMrYtWhtZyYqUH7pZUQaf7zYNoVMVKdy5L7hWfLSQxLD4d9V1G0KyL4KkKnfWffYrTZIzWqN/sle1XThWpjCR7kDLKv+f870iS1E7Iwl3eOKlMzsCoBOvE5E6lRkpbd30tex5mmuO9bD2x+w3Bdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300051; c=relaxed/simple;
	bh=Xdq34th+YpMM5smhkHXOoUwLyv/DhZztdD9afF5e/j0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WN/rrrS8rVmid8eRpeJDF3IcEt1yGA/h21d5m1VCD32FNiRe6Zq6c+y7maV7XCl+1J6M7TgLvYmNH+6FjNCtU8MCRCrv2LCkNIK42SVH6wGrZoI1zMATPZfv5zjIj+q5RMqY3TucB/9LCCFXAspImgHM6uwbzQBz+g27NsuoaG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TVICWBkm; arc=fail smtp.client-ip=40.107.101.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TVICWBkm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TP3OHWS0u+nqH8SBDgbUcvLZfbH+xv/ghNv7mavWYD1PkscKW6rPAWbaVyKXcGwIQ7W03ToPuPKybNNun7T8JhdFgsu27e3cgswMdwhBzuE8m/eQ052UouiHeVVsZPhM3PYDtpDS2ma22Sv3j1ybKZXSJOY4rOKVYFjlrbj85CJR6DD33AaYTmJatctWTRAMmnAqdhJWqDxaNScqxyBVplprgP7NeTC8fFpTmXXdLIElKhX0BbwIhFyT5DX5AWJP1pERkw+t+3MX8Em2pszacvrPIwEeFCoqMz+iW0xmFhhWFGXLakbD7EepxI0mTCPLKmT6XfiMNn5FMpY81ot27g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4e2+gk18hk+vT4LE13ql48oqnPnKmF1BRIp+Fq4w4E=;
 b=D9gdwD6zfNvvjYAvap4wzNST2UgwCTrIvYp78LDGbOq96Pre7lueL3x1aPEy6y5HRMtSFtOXzqUJ/GBC4a1n1sypy/7+NaUrE99GMoD+Cjc6bwTgbV+P8NWb0GC3eUoBGPuX2UBFAcyLmcfhN1HMhApFmjwbPHKruuQS1CX/iiwe6W5cWBfbIVr42/xJH5ngypldU9TUD3TVwx6LA/tV4CAK+86MuNyKTCO/g+hv3vp1j7KLlLi7jUDHActYvM1hYJsNsMQ63tv7hOv9Q+C71dNw67x4WGC1s8URCUaurmWgH0owP7kzZTDlPr5tPYACU0DuThdHcP7EL06DyQM/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4e2+gk18hk+vT4LE13ql48oqnPnKmF1BRIp+Fq4w4E=;
 b=TVICWBkmsdUzlh9DWe0CRzKp+0Z20Mzm84cIE4z73dqiXA/BfxrR+G9/iyTFE1G3RLCCfOyxmbO5QwM0gNr8627jHbTfVU4qFzSBw4noIS3TgyBHqCtH/NODFoW42N8Wu8giG/UY5nDXdmPh6weAx5gUYmf6JeLFSk0l8CzhWrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DM4PR12MB7645.namprd12.prod.outlook.com (2603:10b6:8:107::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.21; Thu, 10 Apr 2025 15:47:28 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 15:47:27 +0000
Message-ID: <1ea05918-73aa-4469-89da-f366844864a6@amd.com>
Date: Thu, 10 Apr 2025 10:47:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/core/regs.c: Skip Memory Space Enable check for RCD
 and RCH Ports
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Robert Richter <rrichter@amd.com>
References: <20250407192734.70631-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250407192734.70631-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0008.namprd12.prod.outlook.com
 (2603:10b6:806:6f::13) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DM4PR12MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: 9194a7eb-65fd-4304-e26e-08dd7846fee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEkyNWxRbEMralJVNmdzQW1oZEVocmd1UGNLMURzdGo3cE5DNHRZa3lDVlRi?=
 =?utf-8?B?anoybDBxS2IxVlcwSHlKcm1QUmUrOFg3aDBWWDFEejVKeURnZGJaeElhcVhh?=
 =?utf-8?B?MzFrNk5rUnE3YjQycU1kZVJxVEUvSXU1ZVFQWFpjRS9obyt6RUVoN0V3SEpu?=
 =?utf-8?B?Y0dqN2RwSklnb1R3djh1Q3Q5NEo1NHFGSFhtVXNnVDVtYkZucnJMWm9DSlVU?=
 =?utf-8?B?ZEs3alVWNUpSZGtMVEdGa0I2MTVyd0M0TFdzUEJMaU9INzNHNmR1dEI5YW03?=
 =?utf-8?B?em03SGE0NHVFMTNlMzNQbGdrdW5IUUpKL1lYRkRFSlcrblByQXZvUVZmaFV5?=
 =?utf-8?B?Ni9Ob2VubUJ3Vk1wMGhnSVhQak1URXV3QnVOckViM0RYT2c5Y3JvK2JPQ2I3?=
 =?utf-8?B?UGRRQSs5cVNJNkFLVUJHc1ViZHdiVmRBeGM2bTVWVFJwbGF4cUVjbFpudUdL?=
 =?utf-8?B?WlM0M0wxKzFuRTJBQjVIZmhORFNHNS92Wmg0TlhidWM0Mng1NFNLaGFLYTE1?=
 =?utf-8?B?M3VCQUgwa0NLZFVnNFFnZ3ZyWHl3bUxMV3NOTjUrTTd3NXUxNmY2ekdoVGtO?=
 =?utf-8?B?N0s4Yzh1VzhORE9FUC9hMEN2b2dXWG9zdGNLZjFVbUxHdzNJbHVybVp5VkRO?=
 =?utf-8?B?aCtKU0N5ZDdkMmx4dFNBc3hDWk1nQ0lxT3FZU2VQRXBxTGJUVDZOSzFxdCt0?=
 =?utf-8?B?cDE0MGFZRUQ3ME5QNkhabHQwNHRwdE5RN2s5eFVUakF6MmdBOGJmOHZKeURM?=
 =?utf-8?B?N2M2MmUwZzlOdDZWTndYa2NiMVMyaEI5SWp5OUNiMlNKK1V6cm01cTJqWkpZ?=
 =?utf-8?B?Qzh1ZHRkQ2lJRXYxdWNyRU9tZC9ZUUpOZ2NIY0JlbzZUQlc3ODBRNkFZeHpC?=
 =?utf-8?B?NmR1M3hSYndzZ0lqbW0xMzg3UGsyOGh4UnYwRDlkdkhWWFZJR241WVJEbGRX?=
 =?utf-8?B?MVRLZjRoU2xHWGg3WGRkbFBsY0VhSm5hdDQ2SnBBdDJSbGdhU0FBTForV0Nz?=
 =?utf-8?B?dFRqMFFPdFl2R2lUSERpWnNzZysxQ3hJd05tNFVMYXVTdm5jVkpwelFGTlBW?=
 =?utf-8?B?TXFqd0ZqQk9RNnNqd2gvNzlYRzRIL0htOGNlQlUra05adWNDZVBrS1pkTTA5?=
 =?utf-8?B?TXhpZnBmVUk0ejhTK0VWVkhnUDlPeDhHQ0RHYUtKRFgzSndzNTJOMWlsRXZW?=
 =?utf-8?B?VkNuV3kvUDNKZlc5WmRBYnUyMUpIek1La3VqSlRQZGwvL1NST0QxOEFIS2Zo?=
 =?utf-8?B?NHZoUlBGZklZVzhpK1BLUlFUbDdCaXF5OHNIN2NmK1RabUJ6RzNoOWp5MnA3?=
 =?utf-8?B?SGVjZnFXUXJNV2JINTFqeWR1ckMvcjZiWXVFbkxxSkZpanhFTnFHOXl5RmRO?=
 =?utf-8?B?aVNnd3p1SzF4aHYwNU1jVG5aTHlaZldSeDRLc3Z6TGYxUk95TEVpdWxoZkxj?=
 =?utf-8?B?YnI4bVZiaVQrZVRtc1pubmRiYmRJcWlXSnJhdm4zVVpQRHR0Z2tDenRyK0ph?=
 =?utf-8?B?ZFZUUHR4c0VYcUhKNkJTalorTVBPMmFaaEUrUXRBZ1U3cGlyd0pQd1Nia290?=
 =?utf-8?B?eG5RYlA4OGhGRjVmbHd2REFJU2xnRTV2d1QyK1hyV2czODdDa1BqNDNoVWNX?=
 =?utf-8?B?MklwMDRscWcxRG05SXhBSHZReFo4dXM5b1o3MDNCQjRQS2VIMW1Md25Pb2hZ?=
 =?utf-8?B?Wk1obGE2eVlzelNvbmltODhhZktENEo5eUdqdkxscDlJL3czNHZ4ZzV5ZFNN?=
 =?utf-8?B?QjhZUnhLTEdZQms2OXNHbWMrMjNOTTQ0dkxXYVlwQStaak11MFJtdGRuTXpF?=
 =?utf-8?B?Mmt4Yk9oQXNFRnRSODFMYVVJbmsxV1dTdzM1Q01SMnB1UTFmYUVTTWJ1VWY5?=
 =?utf-8?Q?6LHl3jjdLN21x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjVYMnJ5ZjFCc1licE9jTlVXZUhVdmRIRUJDTmxqSWp2VVZtODlQNlA0b1kw?=
 =?utf-8?B?Zzdjc2U3VktETFlRSEhDM1lIK3MzTS85Y2E0Uk9kQVdaM1FuZkdZd08wQk1G?=
 =?utf-8?B?UGhLOEd6OFRuMkFGRFJEMGJzSEtyc0ZMWnZZYXlsUzFBV2VEdmtUNCtYM21U?=
 =?utf-8?B?TXZHd1pZRDR0RW1kNWNvQmhrSTJha3A1YVArdkkxcis1SXJHL3hGWEc4bENL?=
 =?utf-8?B?YjZjUWVkSWRlUmNRYzNHVGJ5aU5hd0RweHh6MXdtRzh5Mmo0QW1JMVN0dTVz?=
 =?utf-8?B?VWgrdHFOcFpBZVNqQUIvNkQ2MWQ1NEx5cEpyeFBwKzlab093cXlGQzNSTXlq?=
 =?utf-8?B?eUVERkJickd4R2JvaUlFSkZPaTI2cmVXVTh0M3UrQnBxMHBZeG1XVkErNFZV?=
 =?utf-8?B?K0ZtN3luTDRtQ3NDUGRkK0N6Q0ZGMURBTGZtN3BaZzhMN2VOREFIUk1iWStq?=
 =?utf-8?B?dmU4QzJ0T3dhMExHOUNpaHFXc3VWVCtCaFd1ejJ6UEw4NjZ5K01RamxLWlFi?=
 =?utf-8?B?dDJ0K0JPZCt5aDI5Yms1RnZLZFg2WGRYQ0ZxQjdlRVF6MjBIZ0ZGOW0zU3dw?=
 =?utf-8?B?bUN4M1NLd2c2dURhS29vVnVMTC9JMnFtMFlmVFlyUi83TEtpWUZGNjh4QUZS?=
 =?utf-8?B?VWZ1Ky9UQlJFWHlJcm9uamhVUTJpZ2JqU0FhYm9IV01jY1NXaEY2SkpxQ1lD?=
 =?utf-8?B?eEFKR2x3QmNhS3BxK0RWUnA1V0lveUNsNzcyZzhvYUthTkhiWCtXYitqTXVv?=
 =?utf-8?B?azVnOEFLYjRNMlg3a09xTnlHcDBrTCtvQzZ0dWVueDFHQyszSzhkcXZubzQ5?=
 =?utf-8?B?Rm9KTjlvZmdsUThJa3JvSEZVcEhxQVpmMDZ4QmNDeDdVNG1Jc0Y3OHZJdm5o?=
 =?utf-8?B?NFRTRGhEdWE4dmNqY3FTWTNlaVhJRVVwZ2lxS1hDU1NxK243WXAvNDRSMkJC?=
 =?utf-8?B?cjNVNURCK081aVhZUENCb1o3alhFUkhRbFo0U3VMVnhTNzN0ZmN0eE9zaVA5?=
 =?utf-8?B?WktyQXh4K1N4S1VLQlhzV3lGOUNTQ1pUbklDZnY5cjJJc1BpVExhVW0yYm1P?=
 =?utf-8?B?U0xWQ0IyMWgxVWUzUitRaE5NdUozSC9mV3dTK2prSkRnVjNRSDNCZisxSFFl?=
 =?utf-8?B?L0tpcGVQay9IVGtGOU1ML3J6UjcwOW5aMG92MHVadXFzTWlYUjN0L2RKek1L?=
 =?utf-8?B?dGJ2K0xSazhyRGtFU1pxalR2SytuRFc4eTdlNjh0ZTI1cDgwQXpvMnhTQnZu?=
 =?utf-8?B?Q2RCVm9tVEZ5YVNyclRRYWp6bm9JMjY1Rlk1SDBoVktoWjJOVGQyNnRJZDJJ?=
 =?utf-8?B?b0h1U2R2NXBkU3RucjJMaWFFT3phd2RDdzA0THF2K2FPd3VXc0J5THRrWU9M?=
 =?utf-8?B?SndPSlFVeVdQUGtCL3d3MmpEdjBBdmtWK1YyWmNMdEluRTh1Y25ZRmMwN3Np?=
 =?utf-8?B?OTI1emZ5WEpieVZQd29CbFhBalVvT1VXZEoxc0lLRGxnYjg0STJwM005RTZX?=
 =?utf-8?B?R1QzLyt2aGI1WVRoa1RDb0Z1QVE2dEtNem1ONGMyS2xuMWpFNlV2RFZub1ZR?=
 =?utf-8?B?S213RFU0VSs3T0RMMWFGaFNIRURKSVpXYnhZUHpYQXpUVzlWMlhPNEVYcnYz?=
 =?utf-8?B?bDRFYWpnTnkyU1lKMFpTNFdNTzkrSjdjTjUxWHhmTHZpeHF0UU9QbExscS8r?=
 =?utf-8?B?OWpDN2lwYzFramhxanZCR3dOTTJLd3I4VVFGNVJuZzBwUm5BS3FrcWhvTnRE?=
 =?utf-8?B?Q0NsOU02SWJ6dWNrQVFVV1pjTTFiblphNml1VjNvenpPY1IxMjZ2T2FQUEpK?=
 =?utf-8?B?U3BSc3Ewd3VaUFFNM250akdmOUFpd2hKbmFWaDh4Z0NsRFdJYzl0SzZWUUJo?=
 =?utf-8?B?OFRZZnF0dG5zZWFDeUFiSHdTUWtERWtMSGhmZTg2ZlJvcSt4eEEyYWdKdG1C?=
 =?utf-8?B?RjJFSzBuNFBPNWEzTi82NGtvVTY5bVJmS0c4YWFDU1R1Rnp6cHRVWHMvZ3Zy?=
 =?utf-8?B?OXVwSnZNYWFsU2RXYkI2OHpSUWtSWE11ZlFrSElUUHNqbk5HRUxBeWNzcmdn?=
 =?utf-8?B?aUtFMk9RNkdNOXh4UWgwUWxkT2lxSFJIekZlTHUybHBOVVB3OVRtc0pXS1cw?=
 =?utf-8?Q?tOxXGxi6BpkcNgXL+MuyPGeb5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9194a7eb-65fd-4304-e26e-08dd7846fee5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 15:47:27.7970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6rYm+dflA+woO12klQpR9dy2E54ukKAa3vzUYFP4zZZuCCOhHzqyY1QcSkCi0CTXuXEl+lvG2aNkycyRhIokA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7645



On 4/7/2025 2:27 PM, Smita Koralahalli wrote:
> According to CXL r3.2 section 8.2.1.2, the PCI_COMMAND register fields,
> including Memory Space Enable bit, have no effect on the behavior of an
> RCD Upstream Port. Retaining this check may incorrectly cause
> cxl_pci_probe() to fail on a valid RCD upstream Port.
>
> While the specification is explicit only for RCD Upstream Ports, this
> check is solely for accessing the RCRB, which is always mapped through
> memory space. Therefore, its safe to remove the check entirely. In
> practice, firmware reliably enables the Memory Space Enable bit for
> RCH Downstream Ports and no failures have been observed.
>
> Removing the check simplifies the code and avoids unnecessary
> special-casing, while relying on BIOS/firmware to configure devices
> correctly. Moreover, any failures due to inaccessible RCRB regions
> will still be caught either in __rcrb_to_component() or while
> parsing the component register block.
>
> The following failure was observed in dmesg when the check was present:
> 	cxl_pci 0000:7f:00.0: No component registers (-6)
>
> Fixes: d5b1a27143cb ("cxl/acpi: Extract component registers of restricted hosts from RCRB")
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---

Reviewed-by: Terry Bowman <terry.bowman@amd.com>

