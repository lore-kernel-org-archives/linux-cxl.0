Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9C679D8
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 05:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718170945; cv=fail; b=dx6txlJE3nw2T9NspspZlImcnMskYgg87lSgTS4tr2fqFrGhWv2KvPeJzFxfm7ux4N2PnLqiGGeW2SCcwDl7kK0DbPyNuG32f5Z0zmFBt4qLAV6Eh5WbCEQLMEI3iQelY9F0CrSZHpBcJMNz77fr3S3apDXAE6Z3Wob23BO3sZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718170945; c=relaxed/simple;
	bh=NxcdgadjjQW1gcAZWV43AQFqjKpfMEqcviBfv4jUcII=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n2wz2O1/ZlFBAxgCqorE08+qyTInX8gPxCYT9i4XkXJYNDTuisCPap0xm9d9AEt0nyoi+to84CuHaNmF4L4Sndd95XcIWmSiRdzhO4fiWGcALmb7+sEvbfdHJqO+k0+2TL0DKHCLltotqDSYB84gYDCRPJpLQmDF52OaM87quss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vsAfGAuQ; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vsAfGAuQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFRygk7KH0P1qmCclvdTS5BQqkkL9SUsiwa5RyNpF2gPddjS22LLQ65Tvuvh0nCJXAnhGhNGcg2KICa5vS0CsjuApC7RZawPTZNI5dSRGIkQkKlNq4Uri2WfYCkOXIQpJWoUDOKlneTTH1zawETzZVulK/LgnGgA0Ap8hm7IT+QD7BKjZi8ZEdh4hIbRfODyuanTm3bSYc/dAz0R+FRgxGAJuhYK6t1L7DcSZbCnP73duTOOzup/Wd8KYbTgijS7gvC2jMXsbL9157ZNrLvk6nCzzrj7VwYH4mIDN6RGwJZxBmlTn1/s5gtl/56PBJ6C+wXpBnnOvNjFJnqKWTxw7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8nqmFN9KbjV36gwQ5izIBLrjdo2UOsanZWmbHiJ1vM=;
 b=Ydoqx37jizdd36BS0M4fUl5owsxhhmpMaQspZrsC80vRM2dJcSzKCU8EuIsdyUEzaE1DBpCIqtJbwsxQSptOykcFgl3IEVqCOOyyAy04JC/+I7euXPmnLTZLlAqeFACREZ+ew9EuzaJyDUXebwr3A+JnZyEXJTpVnIlXiQ4k7g+5bsQ9GK4ZD2sGItyXJ6bCitoRZvPe+cvD0f1P+TzyNA9x48VVjEf4+AYWkHtI5E4plt2mtfZvV5iSHESptqiG9iLf6N/lfuMTIZEWuU44po81ff0jIbJ58BIgmr5q39ogtIWZycvyGMnRB4EXrKnL2yATk7PZvy16IsC0vM6GpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8nqmFN9KbjV36gwQ5izIBLrjdo2UOsanZWmbHiJ1vM=;
 b=vsAfGAuQzz3kWYth0f07eHBkKm249N4qAe4LoVXAtNgAfM5nAwMLevwYWUFlMWLAEueZCrwzY8UQK3q/M71dur1EvwWNFLwCopJitBi54/zGXyc3qLvJW6WTBfLEkIsAwHYV9O0hlFZ1c9ZJk7YWafj8zyjPwyl5YD9/HpAoWzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM3PR12MB9415.namprd12.prod.outlook.com (2603:10b6:8:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 05:42:21 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 05:42:21 +0000
Message-ID: <06320d18-5df2-5ae1-015c-f7aef13eb419@amd.com>
Date: Wed, 12 Jun 2024 06:42:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 01/13] cxl: move header files for absolute references
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 pieter.jansen-van-vuuren@amd.com, richard.hughes@amd.com,
 dinan.gunawardena@amd.com
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-2-alucerop@amd.com>
 <666923ba32ac7_3101294dc@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <666923ba32ac7_3101294dc@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0499.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM3PR12MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c3ea0e2-7936-4753-204b-08dc8aa26df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDNPeE45bjM4S2hNUCtUdDhrWTdmbk5LOENpOEIzUHNjSHNFcWRNZXJtSVZL?=
 =?utf-8?B?SElwVzRFaFFyUVhyU2FkSisxd2tjWi9GUk5JaWI0N0pYWGNwMXVUSHpqTk1Q?=
 =?utf-8?B?K3hGcllFa0EzVjQ2ZDlGY2JZVTA2YVNqNTBGbGRzUW9ZT1h2bEFGZTBJdVZk?=
 =?utf-8?B?TmdvZmNpVmF1bG5DV2lkMFFwSU44d1A1RnZTWUVrRWNuVGhXZlVWMlRZdGhy?=
 =?utf-8?B?ZW1xL0d0aEJvUkIyY0IxcmhLbjhuTTFzbStuVGpXTndUaStGbDhXamtDNmJE?=
 =?utf-8?B?cmtyV1IrdVJrOXowLy85OHpOTnRVckxGWFlUTEhqbUZOMDV6L0Y5VmIvVVh0?=
 =?utf-8?B?WkkvWXhBTzNXdDJxR05DL2NFMk5tRXBmQ0wvNU51TDRCKzZBOVQwYkt4WnYv?=
 =?utf-8?B?Mm9tV2VlM1VzRTZzMHl2MHoyaWtKWWY3TnpYTENGUllabGNKYW9wem9wbC9n?=
 =?utf-8?B?NTk5RWdqNVZwSWtFUWJTVWtrMGRsTnhFZGwraUVod2YvVEY5TitTem9lUVg0?=
 =?utf-8?B?RG11dzJPdmpQOXUrSmJyLzQ1K2gwa3pKTkF0L1dRV0xDWldKcTV5NnZVY1RD?=
 =?utf-8?B?d0dxcmtWbldOTkF3NW1zd29jamRKZStWeVNZanBCb2RZY3MvZktmb1FyUDVQ?=
 =?utf-8?B?QXh1RGhwc1VVSU9oallnVG15Qjl2TnFCRFc1Vk9ScFpRZFNlYnJFSk9NSWRO?=
 =?utf-8?B?clk3aEIxRFBSb0g1a2ZyM2IzODViYTByOXhTVXpwYTNPWG8zNWtJa1JzYTRD?=
 =?utf-8?B?dlFqMGt0ODh0WWlrZVR1TmpNS08zdXBvNlVSZ09zZ0F6RlEydDZUUWJmSmtn?=
 =?utf-8?B?bEhiS1lWZDZicmVpY1M2S3JQclVzblEwbjB1bUI3ZUtxYi9XUTlWSUx1ZkMx?=
 =?utf-8?B?V25odS9TaGJ3ZDNvSFNIL1hRSnZBTytrMGVEZ3B1bkptOC9EM0ZqR01JSGxx?=
 =?utf-8?B?a09uNU5HSm5peHBVb21YTDVpUG5CcVFiRjlPM3MrbFBLdU4zdVRRRXlkVU4z?=
 =?utf-8?B?VUoxMXd1cnVBUjRPV05oZVNFZ0lhSzJFVGlKenFGYnI4ZCtkS0hXUGZnOGVB?=
 =?utf-8?B?enZya0JFSWxKZitsd3NBd0ZLY3V3NjlpRnR3THNBSjJBSHFBRHRrYXBNa1RZ?=
 =?utf-8?B?VUgyd2pQcmRzV2tacTNDUHBDMGNSSTl6bmorSnpzWWJhbHlQQTZWWjNpNjZk?=
 =?utf-8?B?a1FNMkMxMy83TmJTd2tlUzZ2TzFJTWJpV0dGa2VjK3pSbGZubXpWNU9PVTVF?=
 =?utf-8?B?aHlzdEVIMVV3T3l4c2hRS3ZSRFhjRjh1MndwaGlnaFptRWc1ZFdJMXJvdTIw?=
 =?utf-8?B?eFRiUTRna0V6WDJwQ2NUOTFFQXhtbE1WT0V2UWNSY2UvSEFKbG1XYnRqWXBW?=
 =?utf-8?B?dVJnWEV3RDNuaFpoNTZ6Wmg2WWRuL2JkRXJZRU5JMm5xbnVLQWFlRFBWSTBK?=
 =?utf-8?B?eFF2MTRqL1VSNy9hMEVzMnVoQWFIeUd6dFRwNmloL0dZejAzekpKK0l5ZGNW?=
 =?utf-8?B?UUFrbHdtUmZOTGppVUJSdXB4blBxTVdKc2llOVhPRXhMOUFDeHBmcnBsRTlY?=
 =?utf-8?B?QUFheHlmNTltZW5YblhJSUJOR25GUjA2Zk1QMEQyU0JVQ3hHRjlBM1EyeWo3?=
 =?utf-8?B?TTdrOGJZUDdtZTYvZFFscWhSSVdQOXhxNjRUeGhEM0JJb3FVMk1RMTB6dlBT?=
 =?utf-8?B?Q3BIWTFzYlllVnVFakpyV2dleXdjSWx2RmZ3YmYrOC9sRXZJRmFkUFRJOU4r?=
 =?utf-8?Q?RldRpYuk3krIhVw2ln/PDHjCdP2xowoF8ASbLbW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VG5kd3U2ekxwOVkvSENsYkJiTXBKMzZoZDlvU0plTnlMbEdJZVVDS2tZMUhW?=
 =?utf-8?B?V254ejVlaDh0L21ObDFZSGdndm9ZS0MrMVQ1akp1MjczTFpnblVnR2wvbXZK?=
 =?utf-8?B?N0hjR3JtTHV3VXNXK2ZtZG92elUzb2hFWHFpSFlodnR4RlNzNlZ0Qzg3K2k4?=
 =?utf-8?B?MDU0WEJXbkZ6VWJrbE41clIxcUg3aG9yQXQwWU5IcGxEYlYxUG1DTlIyMlRQ?=
 =?utf-8?B?S3dMUEljZVRSWFNvQUxCQ2NOVnhJZis1aW53Y0Q4cHlZdG1teEJNcHQxZ3JT?=
 =?utf-8?B?NFBrVHVQcHRFZ0ZuVEVram5aa0RYSUUxMlUwalg4dkQwaFFyWWtUSGoyOVFh?=
 =?utf-8?B?eXFTcVhYQTROcVNpV01LQjUrNC9yL3phMnI1bHQyNUl6SGlZcUwxQ1p5WC9W?=
 =?utf-8?B?YjBiL0RBWlZpT0RXR2dnZ0pSN2xpVDUwSFR0MHV3cFg1WmI2MHZ2RWdUSjRp?=
 =?utf-8?B?bXM1Qnl4VkpRNjdkTzFIWUY1NEI3d0EwVFA3Wk1yU2MwcWh5VjVPcysrMzl1?=
 =?utf-8?B?UXJTQWNKWFFYNGl1OFF1aUNhYlNRNG9GN1hCQXdteVNRUTR0T25XbjNpUGNi?=
 =?utf-8?B?UFhFR2F3eHJHOGRqT013a3p6bStWRk5CaWpMNktkZnZFUHMxcWM2L0RwNnBz?=
 =?utf-8?B?YW1KajV1V2NvVEZYYWp1dmhHQkF3YkFaSXM3UEdQSHU0NzZzaHluM3krSnlM?=
 =?utf-8?B?cGJlZTdFV29VdFVWazE1RG9oWEU5TG51dERLc1FSYTZoL2ZCRzN5Nnh3STlW?=
 =?utf-8?B?bXdkU3puaFlMcERQOUgybUI2ZVRGZmlzYW0zKzJCUEZpcjVRTjlLRUVHVDdy?=
 =?utf-8?B?MFZVZFJxK01lLy9mTEcvcjd1MVcwUzNLUytReGtrM2pibHdhL2VwT2o1bzAv?=
 =?utf-8?B?enVSYnFrN0dEbmU3T2Q1V3Jrb1NpUExjcWxWSTdjM0VjUEpKcE9sa3VGZmZT?=
 =?utf-8?B?ZmJURnhSb1JXUGRVTENiUnpZTG12SHJJcGtSUFUrcU1KQ3FER1o2aVYvclVG?=
 =?utf-8?B?eXlRN28wRVJwNFZmak1pSlhXMDE3c21BRSsxZEkvV2QrL0RmUG1yOC9ZeDRr?=
 =?utf-8?B?V0x0R3E0N3QyZHFDMGlaWk5TaThUQkNmY1JwdFNvWUh3eXhYaXlRb1FVM08w?=
 =?utf-8?B?ZXYwdUlvZFNIaUF2UjZLWUprZWlTOG00cEpTcjhZZWd3ZkNaVUU2T2x6TXRp?=
 =?utf-8?B?NnZRNm5FdE8rbElrckNOaDhSL01pQ041cTEwMnFNNlNZRWQvcGdLNDIrUElN?=
 =?utf-8?B?ZU5qNlI1UFBmQ3l5bWJxbTdET3pJbURldHJoN3JDaHIvR1A1aVUzZkl3Z2J1?=
 =?utf-8?B?RlFZcmpxNmhOK3Q5TnhQSmFEM3RDOXl5OEZzZnJpa1pkd1h0WUdKUDJ3bXEr?=
 =?utf-8?B?ZUJycHZ0WXU0aGxvZ2xOalpsM3UxY1d5OFJQVlE4RXJ4S09FT0UweWFmMGF3?=
 =?utf-8?B?dThRa2ovK3hsbWxQYUlpRlgzTjJSZGcyakg2YjlqVnlxRXBrcWhpVFpQSGVs?=
 =?utf-8?B?cVQrMk0yMUZkb210cGlQRDB1czVGK3JCUW1DMnJsVlJndFBRQVU3bTNMeU9W?=
 =?utf-8?B?MGhwSjZEQW4xK2pwVkxvZU8ySXNsRFZOeEgyY2c4bUlkeVVoNGxRZ1ppai9t?=
 =?utf-8?B?WUVlWGRpMVhDbTBvQm1hamg2MWkrRzdvM2FpRnUvdklEZGdTbDRVSTk4VlN3?=
 =?utf-8?B?RW1INjZ3QWFLYlRLWkx5YUsxcWFRdnZZc1kxVnZua21yRjVMODErSEFDYVZm?=
 =?utf-8?B?aCtKNjBHOGh1VXBadEh5MEVtdy9jTHBHS2cxQlBRRHJaQkliRzZyMFJ4eVQv?=
 =?utf-8?B?R3pZSm5oR0NBK0dIQU0wRGdNdUM5SCtmUFNodndBY05XOXQvTkZKTnFROUlZ?=
 =?utf-8?B?cXdtQ216djFpY1pqZy95NHNTd2p1OUlSQUFkOEIxY1RKRVlFbzJ3bndiVm8r?=
 =?utf-8?B?TTJUQVRQb21YZ2dzN0FacEFiVkJGNTVucGpPZ3QySVdsZVlWYnVrUlJ1TnZq?=
 =?utf-8?B?eUdCY0grVWRBdTFMTURld0xMMi9CYXcyY2I3bExwakExZUc3TVlxNWNoY2J5?=
 =?utf-8?B?NVBldjZmSFJrSkFrOTB0aXJ2VFBPQ2U2MDdBOVFva0dVWHR0eldPSnlJN1dK?=
 =?utf-8?Q?vAywG3HeWDnC61pgCUd0P7wyK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3ea0e2-7936-4753-204b-08dc8aa26df9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 05:42:21.6007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YlMAFsqk8AtLwNu9/8ychg4AeyX7xQJ2AZDHaJZu1fvyaVX/l7BNlYU3goqmw9hqiLbhpATg+P+rzJ1akBi5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9415


On 6/12/24 05:27, Dan Williams wrote:
> alucerop@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL Type 2 devices imply specific vendor drivers binding to those
>> devices instead of generic ones offered by CXL core like the PCI driver.
>> Those drivers need to use CXL core functions and structs for
>> initialization, create memdevs and create CXL regions.
>>
>> This patch avoids referencing those files based on relative paths from
>> inside the kernel sources tree.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/acpi.c                      | 4 ++--
>>   drivers/cxl/core/cdat.c                 | 6 +++---
>>   drivers/cxl/core/hdm.c                  | 2 +-
>>   drivers/cxl/core/mbox.c                 | 6 +++---
>>   drivers/cxl/core/memdev.c               | 2 +-
>>   drivers/cxl/core/pci.c                  | 6 +++---
>>   drivers/cxl/core/pmem.c                 | 4 ++--
>>   drivers/cxl/core/pmu.c                  | 4 ++--
>>   drivers/cxl/core/port.c                 | 6 +++---
>>   drivers/cxl/core/region.c               | 4 ++--
>>   drivers/cxl/core/regs.c                 | 4 ++--
>>   drivers/cxl/core/suspend.c              | 2 +-
>>   drivers/cxl/core/trace.c                | 2 +-
>>   drivers/cxl/core/trace.h                | 4 ++--
>>   drivers/cxl/mem.c                       | 4 ++--
>>   drivers/cxl/pci.c                       | 6 +++---
>>   drivers/cxl/pmem.c                      | 4 ++--
>>   drivers/cxl/port.c                      | 4 ++--
>>   drivers/cxl/security.c                  | 4 ++--
>>   drivers/dax/cxl.c                       | 2 +-
>>   drivers/perf/cxl_pmu.c                  | 4 ++--
>>   {drivers/cxl => include/linux}/cxl.h    | 0
>>   {drivers/cxl => include/linux}/cxlmem.h | 2 +-
>>   {drivers/cxl => include/linux}/cxlpci.h | 0
> So I don't like this approach, there are details that are private to the
> CXL generic memory-expander use case, and some that are suitable for
> CXL.mem and CXL.cache capabilities in other drivers. That distinct
> subset should move to include/linux/. I.e. I want to see the incremental
> conversion of what 3rd party drivers need compared to the generic
> expander case, and consider when and where new shared infrastructure
> needs to be refactored.
>

OK. It makes sense.

I'll work on that if there is a v2.

Thanks

