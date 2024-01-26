Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4651B955
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706277867; cv=fail; b=J7N0O0omHaG2jNy4G2GecPGOlsR/wSGcumlyab9LjJw75F7XvQOunLzKRHsljj0zpXN1C8Y3qYdixK9C1MvWl/psu71zS1EFnAp+LFOnV/M2k/rMkXQHCqu/O9w5c2u6GcVLTueFTfW/1eYJq177RJs0I32QpxncP+qSFNFp9hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706277867; c=relaxed/simple;
	bh=3rlatBsDK1L1xiV5epOuqHqQ9yr8BvE39emXC1vxprk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JbkeEHSO9/krJRnKnSiM8AFrC/GJKVQmPDBq2Rg23FlrutTwOIw9DJ1UAQKQjxbaXBWC+Z/BsuMny3so5+v8c1Ikhm8Z/xcjOJIdQcHKZbC4gMpDzqaLRSNSFtTSpy6qjDbBT/Ml9/i81MCkpcZyNBwhntBJizbdbMvBOAjNnGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=te4o1WZe; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="te4o1WZe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdWu5HOH+b7vAJLbSgEFvac3lT6+LGaBH+EH/9qxE2FyrKil93YJFvZZLcMWU4RzwVWHuvuFQA4iuTozCvBtK2ZZgBetPKFUVjOaaZTxayMAQFNhAiinHdCMj1jckgl5lZRUlKrImWZY+fOI3Qrgi48K8JZTCnYTWugTaR0yOmzuO3jqAtzRwhe92K5hHMwhp6YDbpdmNKRjP25LZGCdBPnb/rk17p6BNKhrrER72SMeKkfY+0fFZMC6WmFiZ1wUes5LhJM4hALXoKJzJN0s2CcrCNvjPMj0H6QAW/NxPgHQr8LFj0xZobU62RGg69wJs5OK/CqW3JNKR6ISQJ5jLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3FckRTV4YBfWfqFVdNc2YyAcu4rLqMBb3pKqYrCSaY=;
 b=eHiwqtCG0lddCOheeE4ppiwzncj227H9Tdijz2V9sXxoD1EId6+pPi/maLD8UpQ8hfV4PAGZNDD1RM+GoglESZdL3Vt+IzPeROseVogm8AunqaDlrS5eBI/ghBK5Zas3VHiqj9im+aMxGvyEwhRBP59vem9Hv1VZuSZrRY5/DSWUx7g4iraYETNmr4nQ3czL/uN5sjpQHznG7jwf+UzxXwKGWK72tICnWpLLCJjj97MFCVCFJTfiBjVvaX6Lcf9/s4PejRQ0PRDJbHREx2FwHCBzjBWaz5lmx/np2/F2+70HQMz/4+QxQ071vytV4yFGH9GeL5los6Wp6DJc87n+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3FckRTV4YBfWfqFVdNc2YyAcu4rLqMBb3pKqYrCSaY=;
 b=te4o1WZeeFUC52f/y+gj5cVelfwRnHaYe+7ngK5KYShYYzec53BAt9FfSjqzVFf6pRyrIJDXV/G/d8eOz6EKyBR2MVOvnTmy8GhnEzGKKiB0Zxq3FUKhI1AttvLqKQguT08dcPPbZwW7gqRaKH/w/hLOqUvI4yExwD10eo9N8mM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CYXPR12MB9444.namprd12.prod.outlook.com (2603:10b6:930:d6::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.27; Fri, 26 Jan 2024 14:04:23 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::662f:e554:5359:bfdb]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::662f:e554:5359:bfdb%4]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 14:04:23 +0000
Message-ID: <c8f6d74c-bdbb-4c46-a535-b109c440a7fd@amd.com>
Date: Fri, 26 Jan 2024 08:04:19 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cxl/pci: Skip to handle RAS errors if CXL.mem device
 is detached
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, Li Ming <ming4.li@intel.com>,
 linux-cxl@vger.kernel.org
Cc: terry.bowman@amd.com, rrichter@amd.com, Jonathan.Cameron@huawei.com,
 dave.jiang@intel.com
References: <20240125081414.2189572-1-ming4.li@intel.com>
 <65b3533821510_293042944c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: "Bowman, Terry" <kibowman@amd.com>
In-Reply-To: <65b3533821510_293042944c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::10) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CYXPR12MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dac8d08-fb09-4b02-3b2e-08dc1e77b2b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fwmY30i4bDopEQJW7kg1P6QfunPZoBGpQXdyaehKef9ts5rYjbDbtj/NymULG0yTerVyKwEanuUm+oE6uTIp3B+C4YHJ2XmG7F9KSeW9ED7QyOMLeqdybpb9FocraF5oulL+xwXGIaZITmEYm5DRL2+L+hp23B/yy8HE+hVZU0Ipzm7n4HetxbhTBf2IijLIXzqWsp7YbROtrUQmec1NomHdIIS9bXecYin7fXZ7G9piCcnRcfnHwwEDxti8MZXnz1JwbwXfFHrQDuxhhHarh/F15DRuZlVRONA7wJ22Pz5Vtj2devcLd4qgpKxqPldJJl/AXUqRY1msKPbhJ4DYZtrcT7I4dD1yOcuOnUnhXKpp1SZye9iIgQAZjzIDkIuYBpFdXSynowMEK5gY3hCW/shhOuBOiWhCaubD0KuFj0P16OWyDQroWPmD471eNee4P39uKBp90LokEVIXay75PD9omMmg/vdjGz2J2sEbzby2f/6ot/fE3A7a1JL0W+UOV6aWOhgj8QzNXAvpvDs6ZugBE2pHIm5FceSDY7tvcJ5lwX+R/WdTpBL+IWSHgmBY1lp/vEHn5zatAfR7um0aeQiN2z478dbsfOcqS29yY/CoYFwRSE9FTnrEESftgKfV2OTDdXkIIpQLe8bK7EBJKw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(5660300002)(41300700001)(36756003)(31696002)(38100700002)(316002)(6486002)(8676002)(478600001)(6666004)(8936002)(6512007)(110136005)(6506007)(66946007)(66476007)(26005)(2906002)(83380400001)(53546011)(66556008)(2616005)(4326008)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWIvU1RvV1EwYURIZkFsS2IxdlBxeUZQenhVczFzcXQzTm9BMGFTMDB5bVly?=
 =?utf-8?B?OVdjTW5QS2FQSmViSXVzbnlKODhYeTE3TU5yM0pDdEpIejlpOFJkUVNRRkJo?=
 =?utf-8?B?TnJTRmhVMTV1a3JzM1NOREVMUTdCQTR4aS9SenRrRUhuWTNBWFRhMksrcGRw?=
 =?utf-8?B?UGtjNzUzYzJoKzl6UUhpYUpxV2VFTUxyc09Cd2lvZGE1dkFxaE93VXVZSXF6?=
 =?utf-8?B?OTBmdlN1N3NMYzFxb0s1aElJd2p6SzQzQ1VlSExOSkFuZStQVFVHMDhrNXhL?=
 =?utf-8?B?T0dCWDBFQVZvM0dXVG9BVnVkcitWZisxdlJ2VjhUWm1GVWw3d2pIRlFLaHVk?=
 =?utf-8?B?M2lUWEpYMmc2UVRyLzdlL2wwTzNmdTRPSXVFa08vZTNBbC9WUjFVNWRLRnhF?=
 =?utf-8?B?cjc2QS9vcUZDNitSbzdENUhLeGRXOXhwRWJ5QnVoc28xVHFQNTBjL1VZdWJv?=
 =?utf-8?B?bVVkK2tNcTRWTXo5MEdCd2hiUkpuMjF2NUVSdkFzc0xKRE91R0VOTnExdXhz?=
 =?utf-8?B?L2kvUnhOQm0xblBGSEZZQ0UwUU1VYXVLWFJPdnAzOTFHbmZFVzd4dS9MdWE1?=
 =?utf-8?B?dTBjMXFmNG9PMkRhTmNHYlRYK3Rldk1WbDdpK0ZZNDk5SE15MFBHNE9vU3Bq?=
 =?utf-8?B?cEtTR0xDUjAzRzZha0RPWjJ1OVZtVng3WXNpc3JBa0NrQVZoTmJiWWFoNUtH?=
 =?utf-8?B?YjAwdFhCejM2NWpDaEx2VkRVQkZmaWp2ZmxuWTJxQzFaTUtkVW55T1dDN0NT?=
 =?utf-8?B?TTEwbnFoeERDd0huUGZRbTN2UTJ6V0ZoZVNnWkxZQUdnTkd5U0xzeWdIdGFo?=
 =?utf-8?B?K0grV2p0TVFwaHNwZXdvUC8xdGdqK0FMYUdTMERKMXZwTnVSRHVCdmNkTjcz?=
 =?utf-8?B?QXl4QlpTaVNSM2NLdGgweE5razMzUDRtYzVESGxOd0w0cVpLWS94a1c1V3N6?=
 =?utf-8?B?UnplMGFLSDZqaVkweUx3RHBDMWp1S2pQZjlRZmZ2Yy9aMFc0eHkyakdZNDZL?=
 =?utf-8?B?WEgwdktCUTZpQk84SGlyQ0QrZFQ0aVhKZGczSnozZHNaTXpMcjVCdU5yMFl4?=
 =?utf-8?B?azdmbGdZSGt4a1paNkQzM3piUnNQYTNjTDlUNjlIZXhHdWxrblFFSXEwV0VX?=
 =?utf-8?B?eFczQzdwTm9ibGNwWmdIa0V2dnJaNjREYzR4dW1IRjVrZjhVd1hPUlhZQUpw?=
 =?utf-8?B?ZzZGVU9vRWllV2h5TlZMV0k4ZDBGNmE1azJic0J4Vk1hWTM4Rm1Ea3RCVjJU?=
 =?utf-8?B?QVFQZ1gvMEZnQWdidlU3ZDkrdVB5Q3VaL2xQS2RCVGVuS3A5THFjOUs3K0JF?=
 =?utf-8?B?d3JIa21qV0xSWGxnOHlwMktidU5QU0xMQ0VQaUQrK0xMc21NdURYajlnWlFq?=
 =?utf-8?B?MC9GTlc4eGc3MnNmNlV1bW4zMitmT2NXNWhKdlFwYk94ZWkvbGtncHFORWxF?=
 =?utf-8?B?NUZVYnJBbzArcm1FM0FhRXY3ajkyVG81b0k5cmI5Tkl5QzZMajAzTGlaK2Fz?=
 =?utf-8?B?VVBhTld1YkM2T2JjcVlQTk5JR01kd3k1elA2cml3LzI3a0ZqOGwzYUpUaWFQ?=
 =?utf-8?B?QjdEMFlpZWE0T1I2emI4aXBtWExlWlozM3phWnMralFPVXpXeVlSTWxmVFU2?=
 =?utf-8?B?RkhYL3VPUXZvR0dwL2ZNaWhRd2hTanBzNzE0TldJaDVZTnJLL2ZDaVdxSjg2?=
 =?utf-8?B?MDhIOWR4NlI1anJYMDh3MUxiZjZGMVFGUmg4RzgyU2xzdC9mc3hoQnd1aUdF?=
 =?utf-8?B?RFdFZ00vajdwU21oNEM2Uk9jcGZPN0VLVEtLNk1NdHVOMzBqYVdid3Z6S3NI?=
 =?utf-8?B?UFRDdGY1WHliVUJpMkN6SjBaNlJ2Tk83eWNvRk95eUhvVmIvQlY5ZW5qTFV3?=
 =?utf-8?B?Um41dmFqRmlVN09GcXhrVTl5TGdDeVdxcWRyM3plYzYvUzkyOXZXQ3JhVDJk?=
 =?utf-8?B?VDJaaFBFMFk0cHBuYXppdElpNU1WZkVYMzRiejhzZmlCVzdzV0JTblJ1b1BY?=
 =?utf-8?B?VGIrN2xkK3VQTjZDQVRqZ1VDQyttbFZhYmZZcWthTC9VbzJwbldwTjZhNjNv?=
 =?utf-8?B?dDhJZWdJUUdMcmlodE05aHRLZWw5dUs1ZzE5SUtZUzV5TC9iaGcvOEhmN3ZI?=
 =?utf-8?Q?yLVjS9bwzvBv5Bt1AgB4SB7qh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dac8d08-fb09-4b02-3b2e-08dc1e77b2b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 14:04:22.9869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4wX5GtL8HQp1I9n7PBl66yCxIbUnWzjpqx/FcL3zMCrhfPuMr3cEoSzIGXWtvDh0OX05qcFl9f328UkdHBj/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9444

Hi Li and Dan,

I added comment below.

On 1/26/2024 12:37 AM, Dan Williams wrote:
> Li Ming wrote:
>> CXL.mem protocol errors are logged in CXL RAS capability, if CXL.mem
>> device is unbound from CXL.mem driver, will not expect any CXL.mem
>> protocol errors happen on the endpoint or the dport connected to the
>> endpoint. Giving up these unexpected errors to avoid error handler to
>> access unmapped RCH dport's RAS capability. The error handler of CXL PCI
>> device helps to handle RAS errors happened on RCH dport. The host of the
>> RCH dport's RAS capability mapping is CXL.mem device, so the error
>> handler will access unmapped RCH dport's RAS capability after CXL.mem
>> device is unbound from the CXL.mem driver.
> Thanks for this Li Ming!
>
> I am going to reword this to add more context:
>
> ---
> The PCI AER model is an awkward fit for CXL error handling. While the
> expectation is that a PCI device can escalate to link reset to recover
> from an AER event, the same reset on CXL amounts to a suprise memory
> hotplug of massive amounts of memory.
>
> At present, the CXL error handler attempts some optimisitic error
> handling to unbind the device from the cxl_mem driver after reaping some
> RAS register values. This results in a "hopeful" attempt to unplug the
> memory, but there is no guarantee that will succeed.
>
> A subsequent AER notification after the memdev unbind event can no
> longer assume the registers are mapped. Check for memdev bind before
> reaping status register values to avoid crashes of the form:
>
>   RIP: 0010:__cxl_handle_ras+0x30/0x110 [cxl_core]
>   Call Trace:
>    <TASK>
>    cxl_handle_rp_ras+0xbc/0xd0 [cxl_core]
>    cxl_error_detected+0x6c/0xf0 [cxl_core]
>    report_error_detected+0xc7/0x1c0
>    ? __pfx_report_frozen_detected+0x10/0x10
>    pci_walk_bus+0x73/0x90
>    pcie_do_recovery+0x23f/0x330

report_error_detected() includes the same "if (dev->driver)" check before calling the device's err_handler(). The same check again in the CXL device error handler increases the chances of catching the surprise unbind case but not by much.

Regards, Terry


> Longer term, the unbind and PCI_ERS_RESULT_DISCONNECT behavior might
> need to be replaced with a new PCI_ERS_RESULT_PANIC.
> ---
>
>> Fixes: 6ac07883dbb5 ("cxl/pci: Add RCH downstream port error logging")
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Li Ming <ming4.li@intel.com>
