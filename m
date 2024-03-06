Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BC314285
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752010; cv=fail; b=W8ztiE4a8g06RvK/4ioVWM5elOK2G84M4kPyC1W4QFP2jh76WnzvpNNTNyz5bPg0pjlejWx0wBxqww/uMiGsLbtU+DMJpZmEqXrPJeRYjfXdbAOMEjO48/CRXEqYlvgCgvLLOdpoQNxWsrKYUpRug6EMnYaSzlmMadB5oRnJt7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752010; c=relaxed/simple;
	bh=WYcdVS1Z7jjrOBsUH7i8GtPtyUrDygsXt0RySyV6tW4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MVLYVTvG9NHIMSlzU5TUA10WKP6Ehh62qw0jz3JxCillKJQkXDEYeF0QAFs2eF3rT7CBlfFN3pI0V9LOkm6y5voJeJU0Jl+DS9z3ESu/aSj/Tg2N2mt7Ygjxp74pVoC/92Q5xcwCeqgw6ydfLhtJtn5IS53S/c7hrdaqCgcxxdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1Yn72LBE; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1Yn72LBE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=es/NSGM1UEIQCCOo9L28VMybKFwStRakBpuyPol+CHiLBjenWRjoQ2A6aF6uZWTmDwtNVhaEHJV6+kS8/tHmVM5u9BWH0JgFOi0zf4h1XCVCCq7J7dBnhXk0rM1/umP8/4I+C5fkWDyWEjml5Olvwp3JO1KuK5STDJ/ZPhlUSpwhng8ER7mzfcYOCnC4DDFHEW9GGxN4TgEIGjEpI01BwCKF3iroLQ5KqztRzvxvkmU4jVq1QFTiPwzv28V6WXqP35U20fCeWDgrhR9kctoPgMlBz4Lkv0YhG0GrnZE3dpeBzGsol4v2+T2o0ETmG5UvmeMx8FBZv53Ucaq3B7j9VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7bBXc9oVtg2BAVgcYD1DNul8mAsak01kcUeMFJlatE=;
 b=VJBNT4COY7MHVkdvErY69j+Le7QRt7OfKHBl7kOA0+vJv8kg5VSOT0ErIt4vF+bep1Z6ddYEziCx2RL1FimLT8AutbiHEn0IVT+rRFquXFAhgb+5nYUK5Dn4nbSciksRcaMTkCm8MBhZgtniFlWVWCY4tgNtsNztwOkBW6k45O5CymYDUl+0oEpBR5lqlgAcJN5N3FQACeA+GXekPD0bYK5sbf+UVpH03qif6SrO2dX96uyllbKy3wjoIFZQcGIY8c6tEuyIZQ4PlqhwfK+d24YrlyHT/YAawyAVruHV9I/rU1x+qZmmMikilLJmWrlvcAgzPdfsD1uKOVJNLFqAoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7bBXc9oVtg2BAVgcYD1DNul8mAsak01kcUeMFJlatE=;
 b=1Yn72LBEo+7M8eW9T0lO4pVZqf0fO1g5beitb4K5JHtI5ECxsBovNEX+SGN59lrLmP8nS2aWmZ2AcTXcFa0XeLp3O1tdl705T6d5eeXjjkJdWTvF9DJLgZ2QTVEDoT2iRQtpfKm7mi1CJwrww7Q1Of4KEPtCks8vjp0Y5jy3VLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CY8PR12MB7147.namprd12.prod.outlook.com (2603:10b6:930:5d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.39; Wed, 6 Mar 2024 19:06:44 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::662f:e554:5359:bfdb]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::662f:e554:5359:bfdb%4]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 19:06:44 +0000
Message-ID: <bd47d1b1-43a0-4c96-af91-2a3ef898a9cb@amd.com>
Date: Wed, 6 Mar 2024 13:06:42 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: Enabling internal errors for VH CXL devices: [was: Re: Questions
 about CXL RAS injection test in qemu]
Content-Language: en-US
From: Terry Bowman <Terry.Bowman@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Robert Richter <rrichter@amd.com>, dan.williams@intel.com
References: <20240306112707.3116081-1-wangyuquan1236@phytium.com.cn>
 <20240306132359.00001956@Huawei.com>
 <6447f2fd-8594-454f-b0ca-f12ad1947e10@amd.com>
In-Reply-To: <6447f2fd-8594-454f-b0ca-f12ad1947e10@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:5:74::43) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CY8PR12MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e834a0-94b7-473d-fd0d-08dc3e10905d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GDnwp6+++m7uvCB9mimpYnyXt8foh3Od7PrP88+Ewzn5vYCE5DM7uVQ8LxrOUebuw991z3L2iFxDjfs5kUfS/iAZ5Sl2+1UKa57m5EIeA91gTcKOAUt0I2HyIL3RdWq3yUPS1kY16diPggv9CN5sn+S+oppZEQxeUAAoCKiVRfW/wE2vk2vSdWSKLX+CaCqtRDp8JshOAq3yUn4NvyHB0+XBAM1LOlgXYHOgZB6BiCiJ5QwxTAv+IZyTEuaL46ePmmX7f2O/D2uh375fCbwPNGXuzWLCw+6mj8vThdYnOXeKiM1S0M2z63o/Iz0R8Ack3dLISm7BUQ0yXH+anFEd++NMjRHi64n75PI7zcotbSkjJYvmBn10j6NDMTR/3JYqmzQld3sAU5yELXXHAhkgrgaIMSFAjI85TwGdukgolEwkXdFpc3Ggx89EBxYl6+k7X1xHrkD5HmV6lThVrPGkr1jKDvMYTBiZ2iK4ktYE043qXIfD50kZzjCSZE0XUCF8vIEiQDTWTKmx+56iTSFWvfqnvdQ5eip5Rub5MWzPq3fVHeQ+LeWPByEdfkqeXIinwuZqYSk4SNzO192LH36qzdxT3O8NZs59DOI8qKTq2Cs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU9qUTZYM3M4bkhCYVBVS1RTQmVjSU12VFBhaENyNTZpN0haMVRpN1JLbWVh?=
 =?utf-8?B?V2FiUGE0YW1XanlMQW5lRlhNNmo3TStuNlBQWnhOWHBFVGpwM1grYURYeDlr?=
 =?utf-8?B?eXo3RjZrZ0FmbnVzRnlBV29qUUxaRjRPT2gyODFVemwzRjhLK0xXd2ZYMmsy?=
 =?utf-8?B?d3JCRkhWaERwRC9ZbDVOZXNFbUk5RnBDVWl0QWl1blp5aURsWEdNaGp4MFA1?=
 =?utf-8?B?czJBNSt1TDN1UmtrODBGQk8xQUtNa2U3VDZzZGlMWm5MUlpPazJWdWJJaFZF?=
 =?utf-8?B?ZXU4UnlPYVlLRUJrL1FkcDl2c3M1RENEaERQNDZreHdrMXV2Q0hqdkFaUUo2?=
 =?utf-8?B?NHU5WHlCSG14Nlozd0pZZkhvZkl0VVI1aDZ2cnAvUFYwZDBaZllmVVZDZ2x4?=
 =?utf-8?B?UlFGWit5WVJXM1VoSFZQaWRnRWJ1Z1dUbWxWWEwzc2FKMWJpRGtTaHJoQjI3?=
 =?utf-8?B?bWRSOTgxbkxFay9va0YweUtuYVpZb0NGM3dXK1MrczJxZkN0bzhhTVhkTnl3?=
 =?utf-8?B?OEZjdkcyM2VXWGRWc2hpZ1VUUlZ6RkNRZXhVaTM5SEhtZG9BdS9EL0habmxK?=
 =?utf-8?B?YW1welQyN0tZZzhCNnMvb2ppeWxpYVlXUzhuNDZ1aUhuTU1QY3FkVjBRQkhk?=
 =?utf-8?B?ajhpUzJ4UGVtcUdZeFg0L0xCZTc3NDZzVjRMT1RxZUZVY1Z0eUFVVTU4OHUr?=
 =?utf-8?B?QWVrUHJrZytNdFJFZEFVYmZpeUtLQ3lCeURSa1M1R0JqeUphTVpxY1YvYUtD?=
 =?utf-8?B?NkJZbnh2bjlmQThBWkpWNzQwSi9EbHh1QnprODVpVWE3Y0p6N3YvVzRoSWw5?=
 =?utf-8?B?N2lxc2hxV0V3Yyt6S295aFRRc1huV0NxcXgwc3Rsd0k2dzdEaHh5L0RKN3kx?=
 =?utf-8?B?eFdUS2NJUHFsclVsMWNuUDZ4RHdPWXhGNGthT1QrU2UyWlg1OGtEMVUveFZG?=
 =?utf-8?B?ZHhKWXQvL0hNWTZ1dGhxK2M1RURZRUVVMnMraDhDNFBjeVlCOWpYTTEyLzkz?=
 =?utf-8?B?RUNkbGJraFVCaXh0bmpXVHlYL24zLytldk41YXVOakhOaFdUTkRvVGdsY1pE?=
 =?utf-8?B?YkdhdlloZ2xESFg5dk1hckFiZGtSTDcwZVF5WkMyUGl4WFZsTFc0aUFjcVNQ?=
 =?utf-8?B?M0E5ZENaZUF6aVJBY1FibUNITVZKMHAxTmhPYW42bDZralRuUDhPRmwyMXM4?=
 =?utf-8?B?ajFaYU5qamxNZEZzdHU1b0N0SWRBQjRENWc3WmtYeWhDVWJZVVovY0ZFVVQ1?=
 =?utf-8?B?ZHBrc2RMQkpGNzU1RHZJTXAxMG1qOENNdENEQWxCK1N3cFo5RHBhelJmTlZE?=
 =?utf-8?B?alBGV0NHUVVqVk9qZHBnUzE2dVFhK2lvMkk3RVI5RmdDR1dwVE56SFpqek9w?=
 =?utf-8?B?eWI1NHBkcVEvdUlrVHVPSW9td0ZsTExMNFhmTkhyZURZbnRKSnl5cWdNbzAv?=
 =?utf-8?B?QzBRTXFESEx3UnlZSkZBYU83Z0RmMTUvVkdyWUpQNE5oaDJWWlN2ekMrc25y?=
 =?utf-8?B?Y29IZ2NtV1liYTF3YU8wUlNrQUluTUcwcFk0TWF5MmkrMlZUdFZ2MndUV1NI?=
 =?utf-8?B?VjljV2Z5T1Yzaktya0E3dVN0cG1lYTRpVDhsWGRSTHB0NFptcmsxMzdRMzQz?=
 =?utf-8?B?Z3dYSndWUS9vdXBvQWZOYndmRW5GSVppMy9VK2J1WlZ4eXFTL2ZESDRkRnJN?=
 =?utf-8?B?aHh6UHZCSW5NVytLekRpY0QwUlgvSW1EQzhqOXQ0Z0J4TmQ2bnJPRVduUzI1?=
 =?utf-8?B?RUhrTFFOd2lIa0VkSUZZd05LeTNNMUsxQVRNS0tHTUEvTWRzY1g4Z0UyVzB4?=
 =?utf-8?B?b052NDU3c2pBQ1QvVUFMMTJBa3VQRE8wWThKdDV2d2hpcXFDRCtkSlo5UTQv?=
 =?utf-8?B?SmtBQnFmMG1UMlVuN01ERkpMQTI5RUhtaXRkMDFNM0tWbm1kOVkvQVpGQWNo?=
 =?utf-8?B?d3JWQzVTWVQ2eTRTUS9VaW14dEsvN0FVREdkS3p5MWRGWW9VRzVGRTBvamU2?=
 =?utf-8?B?MHdTOEVnS1hnZFhZSVFrbkVzblNiUHUrVDY2R0h1NHZVM3Z4Q2lUV3U1a1pD?=
 =?utf-8?B?bUlrbHdvTnlDbjB3Q255bWVpVythR1VZajE3b0NXSmJmMUFBZlNRK0lYYWc3?=
 =?utf-8?Q?0TLxBWiTsg/otQbmIZAHxlurE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e834a0-94b7-473d-fd0d-08dc3e10905d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 19:06:44.3251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmoQ1e1CVA3FrleiAdjxsYq7do6AX5xJOSJ01+7Ax1LCO7Tk95IiQlxTQCG+9pqRaagju4bzGF1BcMnCBeO5CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7147

HI Yuquan,

For your test, the first logging will come from the AER driver if 
everything is working correctly.

You may want to check if the upstream pci bridge's AER UIE/CIE 
masks are set. This could prevent the error from handled by the OS's
aer driver.

Regards,
Terry

On 3/6/24 11:12, Terry Bowman wrote:
> Hi Yuquan an Jon,
> 
> I added responses inline below.
> 
> On 3/6/24 07:23, Jonathan Cameron wrote:
>> On Wed, 6 Mar 2024 19:27:07 +0800
>> Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
>>
>>> Hello, Jonathan
>>>
>>> Recently I met some problems on CXL RAS tests. 
>>>
>>> I tried to use "cxl-inject-uncorrectable-errors" and "cxl-inject-correctable-error"
>>> qmp to inject CXL errors, however, there was no any kernel printing information in 
>>> my qemu machine. And the qmp connection was unstable that made the machine 
>>> always "terminating on signal 2".
>>
>> The qmp connection being unstable is odd - might be related to the CXL code, but
>> I'm not sure how..
>>
>>>
>>> In addition, I successfully used the hmp "pcie_aer_inject_error" in the same conditions.
>>> The kernel showed relevant print information.
>>
>> IIRC the AER paths print under all circumstances whereas CXL errors do not, they simply
>> trigger tracepoints - but you should have seen device resets.
>>
>> However I span up a test and I think the issue is more straight forward.
>> The uncorrectable internal error and correctable internal errors are masked on the device.
>> I thought we changed the default on this in linux but maybe not :(
>>
> 
> Device AER UIE/CIE mask can be set and still expect to handle device AER errors. The device reports 
> AER UIE/CIE to the root port/RCEC on behalf of device AER CRC, TLP, etc errors. 
> 
> In earlier changes we added logic to clear the RCEC UIE/CIE mask inorder to properly receive 
> AER UIE/CI notifications from devices and RCH dports.
> 
> "CXL Protocol and Link errors detected by components that are part of a CXL VH are
> escalated and reported using standard PCIe error reporting mechanisms over CXL.io as
> UIEs and/or CIEs. See PCIe Base Specification for details."[1]
> 
> [1] CXL3.1 12.2.1 - Protocol and Link Layer Error Reporting
> 
>> Hack is fine the relevant device with lspci -tv and then use
>> setpci -s 0d:00.0 0x208.l=0
>> to clear all the mask bits for uncorrectable errors.
>>
>> Note I tested this on a convenient arm64 setup so always possible there is yet
>> another problem on x86.
>>
>> Robert / Terry, I tracked down the patch where you enabled this for RCHs and there was
>> some discussion on walking out on VH as well to enable this, but seems it
>> never happened. Can you remember why?  Just kicked back for a future occasion?
>>
>> Jonathan
>>
>>
> 
> I tested (qemu x86) using the aer-inject tool and found it to work. Below shows the 
> endpoint CIE is masked (0xe000 @ AER+0x14) and the injected error is properly handled
> with root port logging and cxl_pci handler trace logs.
> 
>  # lspci | grep -i cxl                                                                                                                                     
>     0d:00.0 CXL: Intel Corporation Device 0d93 (rev 01)                                                                                                       
>                                                                                                                                                               
>     # lspci -s 0d:00.0 -vvv | grep Advanced                                                                                                                   
>     Capabilities: [200 v2] Advanced Error Reporting                                                                                                           
>                                                                                                                                                               
>     # setpci -s 0d:00.0 0x208.l                                                                                                                               
>     02400000                                                                                                                                                  
>                                                                                                                                                               
>     # setpci -s 0d:00.0 0x214.l                                                                                                                               
>     0000e000                                                                                                                                                  
>                                                                                                                                                               
>     # cat aer-input.txt                                                                                                                                       
>     # Inject a correctable bad TLP error into the device with header log                                                                                      
>     # words 0 1 2 3.                                                                                                                                          
>     #                                                                                                                                                         
>     # Either specify the PCI id on the command-line option or uncomment and edit                                                                              
>     # the PCI_ID line below using the correct PCI ID.                                                                                                         
>     #                                                                                                                                                         
>     # Note that system firmware/BIOS may mask certain errors and/or not report                                                                                
>     # header log words.                                                                                                                                       
>     #                                                                                                                                                         
>     AER                                                                                                                                                       
>     #PCI_ID 0000:0C.00.0                                                                                                                                      
>     COR_STATUS BAD_TLP                                                                                                                                        
>     HEADER_LOG 0 1 2 3                                                                                                                                        
>                                                                                                                                                               
>     # ./aer-inject -s 0000:0d:00.0 aer-input.txt                                                                                                              
>     [   72.850686] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000040/00000000 into device 0000:0d:00.0                                             
>     [   72.851784] pcieport 0000:0c:00.0: AER: Corrected error received: 0000:0d:00.0                                                                         
>     [   72.852594] cxl_pci 0000:0d:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID)                                              
>     [   72.853591] cxl_pci 0000:0d:00.0:   device [8086:0d93] error status/mask=00000040/0000e000                                             
>     # [   72.854277] cxl_pci 0000:0d:00.0:    [ 6] BadTLP      
> 
> I have not tried to use cxl-inject-uncorrectable-errors or cxl-inject-correctable-error.
> 
> Regards,
> Terry
> 
>>>
>>> Question:
>>> 1) Is my CXL RAS test operations standard?
>>> 2) The error injected by "pcie_aer_inject_error" is "protocol & link errors" of cxl.io?
>>>    The error injected by "cxl-inject-uncorrectable-errors" or "cxl-inject-correctable-error" is "protocol & link errors" of cxl.cachemem?
>>>
>>> Hope I can get some helps here, any help will be greatly appreciated.
>>>
>>>
>>> My qemu command line:
>>> qemu-system-x86_64 \
>>> -M q35,nvdimm=on,cxl=on \
>>> -m 4G \
>>> -smp 4 \
>>> -object memory-backend-ram,size=2G,id=mem0 \
>>> -numa node,nodeid=0,cpus=0-1,memdev=mem0 \
>>> -object memory-backend-ram,size=2G,id=mem1 \
>>> -numa node,nodeid=1,cpus=2-3,memdev=mem1 \
>>> -object memory-backend-ram,size=256M,id=cxl-mem0 \
>>> -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>>> -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
>>> -device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem0 \
>>> -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k \
>>> -hda ../disk/ubuntu_x86_test_new.qcow2 \
>>> -nographic \
>>> -qmp tcp:127.0.0.1:4444,server,nowait \
>>>
>>> Qemu version: 8.2.50, the lastest commit of branch cxl-2024-03-05 in "https://gitlab.com/jic23/qemu" 
>>> Kernel version: 6.8.0-rc6
>>>
>>> My steps in the Qemu qmp:
>>> 1) telnet 127.0.0.1 4444
>>>
>>> result:
>>> Trying 127.0.0.1...
>>> Connected to 127.0.0.1.
>>> Escape character is '^]'.
>>> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 8}, "package": "v6.2.0-19482-gccfb4fe221"}, "capabilities": ["oob"]}}
>>>
>>> 2) { "execute": "qmp_capabilities" }
>>>
>>> result:
>>> {"return": {}}
>>>
>>> 3) If inject correctable error:
>>> { "execute": "cxl-inject-correctable-error",
>>>     "arguments": {
>>>         "path": "/machine/peripheral/cxl-mem0",
>>>         "type": "physical"
>>>     } }
>>>
>>> result:
>>> {"return": {}}
>>>
>>> 3) If inject uncorrectable error:
>>> { "execute": "cxl-inject-uncorrectable-errors",
>>>   "arguments": {
>>>     "path": "/machine/peripheral/cxl-mem0",
>>>     "errors": [
>>>         {
>>>             "type": "cache-address-parity",
>>>             "header": [ 3, 4]
>>>         },
>>>         {
>>>             "type": "cache-data-parity",
>>>             "header": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
>>>         },
>>>         {
>>>             "type": "internal",
>>>             "header": [ 1, 2, 4]
>>>         }
>>>         ]
>>>   }}
>>>
>>> result:
>>> {"return": {}}
>>> {"timestamp": {"seconds": 1709721640, "microseconds": 275345}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-signal"}}
>>>
>>> Many thanks
>>> Yuquan
>>>
>>
