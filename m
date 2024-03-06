Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB188004B
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709745140; cv=fail; b=T0xdAiGfwBhmcFs3V52Qi7Sjb9ZLIUDR6h6Oq/MBzbfz/nRGRfJbP3vgyvggQxm/DCAJWFl4IMCMRFjtgIryFcI4f88ApbnJNTdEVofq/QixOByiHQDO3v51YpIaWvp9ox6nFojPyLspJb1TyWtBKpmO04+cp+Oo+0I19Se8iZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709745140; c=relaxed/simple;
	bh=rIa9gh0pNzqI6G9UJazypLO3tIx0UDjYjBSAt/MFgvk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zc5FK6Acj1OZ1BWnKRT7tMdbn7lJ08kPI/HV1IaAnGd5CnG34YWZRH4lrb0RvZoDbw1I0RQ7/sITFpsr4Sf0UHWXZjil8xxZO/OhRgzIymSlrzgK6QO3wJ//zPofjpbhq7Fy4Uo1ptn4LD9IeoPvtyFXK4OgvEXj9/ys2wmBR6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dj7iARR6; arc=fail smtp.client-ip=40.107.95.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dj7iARR6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUP5yi7H6PGrWCYY8Fp7MZkid50kxbutUdS0jdCjxDzjUJPSGxyMNpEAHFaoLR6cOneiR69984UmZFUrxY3PBlsUIbOSZs19PQCfah5CK7PODaj9kKcXP0QvaXKcSbuX2r2SmmLj0pI1LJXcnZqkn75AoPtOuQGHaj3sMEZbrs0UiM5RRoY62qBD7eH19F+fgl5KpHC7nXl1Uw86vm68HPCEv3ljasjI6213AmGYcqAo5mK6sfYisaAwEMnJNA9M9bu71Z0AGoT37G7VEfmJOTDgb8VS+Dcchv/gT1UDfyhXlPD2liRqUBaEIQS5eYtQ0ljBiyX+kuHfS7R04CmtwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lI5sVjIHD3bwerHPl/WiSquxWTzcdPKCjXvabQzGeHI=;
 b=AufB6f9Rpvja5fKl88i98B/3lLAmzB/cCBAl3QQdF91cg1VKwQ/e+AW4QDNt3maTGBDL0GZPiWSUqqMlDtDAR7+Fvxk8xDyAB9U4LZhArRJUfmylUeSA+PPJgqNkyVu5wPmXQxloukdhGrA3ais1BC55g2/58rT/BXTdmGaMRlZQ0/Xw5XMasGiytCZck94O0dOoHBIlExb1nSiODyzuWLxmiPjTNXHEXyPXAnqVAoOBqHWhCsJGFj6xO8v0oTiygPg5iUM2rfUfhOcybD9NlNu9aH3YsuBhxDMk16zzDXRKb39Oyo112EhvmZSNBOZQ2tQ5vVLnWgCKkzoZvM8COg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lI5sVjIHD3bwerHPl/WiSquxWTzcdPKCjXvabQzGeHI=;
 b=dj7iARR6ZpTfgBUd3XeKBfRtc3khVTpGAQHuQ+Fz4YzfsZfzyFv7kke6z0USAAKMbJbUDGyaKibcyh5kpERd8XriWT/cr/bSm6UecuYnVZxpkdRC7LknappPGB4XRRAfzagDHL2kaV2Lo+t/dmX67SJSHveG4Nv9gtEQBzwo+CQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MW6PR12MB8835.namprd12.prod.outlook.com (2603:10b6:303:240::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.38; Wed, 6 Mar 2024 17:12:12 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::662f:e554:5359:bfdb]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::662f:e554:5359:bfdb%4]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 17:12:12 +0000
Message-ID: <6447f2fd-8594-454f-b0ca-f12ad1947e10@amd.com>
Date: Wed, 6 Mar 2024 11:12:11 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: Enabling internal errors for VH CXL devices: [was: Re: Questions
 about CXL RAS injection test in qemu]
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Robert Richter <rrichter@amd.com>, dan.williams@intel.com
References: <20240306112707.3116081-1-wangyuquan1236@phytium.com.cn>
 <20240306132359.00001956@Huawei.com>
Content-Language: en-US
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20240306132359.00001956@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:805:f2::49) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MW6PR12MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ae278f-ad07-46d9-920f-08dc3e00908c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iGMMtvJs7o6orL60d9GLyEfyoUyapXon6Dg7uA1kICGN6JPbXnsLFWu4EGOYwqeeHjXIOxZ9lV7beKp1GutFSrmVAPcVK7Rq15G80O7EXzs2E6ZbkGeoNMW3FGXjimNe5drnwK1eLARD+FEGzp3UP7kR/tQ1KtweTiycwVBzf+BGp3p4W0VNe4Amm0Q6hp4WaksJH2yaJx5z++1bsvQcYINdE9nCfLU2h2e4tsBbPz/HO8yQMFmq6qI1djAjUgogg/n1pkBcchIdj/O8T6gVKkIiqA61163osLgoZUWxfwUx8xPniUWJhuusMzofmBIm7ivWSjssb6jG6docOViNiO7dpqW5WcJpJ5jtEgkjbYnRzD7bU/StvaP20HncZtU5flCfH3rZCf4TXAtzqs/WGcUdLQ1oYs0mrT0CrxWxHbEoNCvvwtD7vRW7gs8ku+piQ0oB50fXHqZw7EYBWmrDWm3RsLte3NYAILV50rfSuw+50Rc3OyoQZ16UX35rTXvhSe4QQ3MpMv7oau/Zu/hcIydpKrh8hfBamm/125MNlGici7hvDgmpjmeFLFdEOdovkUps8GQlotLGOfRoz+C9JMETOHja1u+k/kvDDX+vbVE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWNxSjdrM3BySklRUUx6N1B1aEN1a1dnR0pYc0tKeHphRC9MZHlNTXU0TWlr?=
 =?utf-8?B?czlQMXBaOEpYdjBxdk5SRlhDcStDZDh2TmhYakxFZk5UQzErZkVoS1JFOWhL?=
 =?utf-8?B?ekM1VG9lSWpqVmlWcTQ4ZmMyZGlkN3hmTllhMS9pNk5vdmFjWGNDZ0JhZTJL?=
 =?utf-8?B?NENiNnphc3Z0SVZCWW9hTkZGbkhSOWIxTy9LU1pIU0NaSVVvL0Zod2g3dXV3?=
 =?utf-8?B?amdoeXJXaThCQ3NtL0FmUU1LZDNzZjRwZHlwTC9aNXkwMU1hRko2VUpyODhC?=
 =?utf-8?B?L0VMS3ZVMHg1bGl6MUhHdHpQdEIzelh0SkxrdzUvSHA1QU1VYTU0NktMeE43?=
 =?utf-8?B?MzBMTWR5Tm1zNXJQWWU0NDgrU09NMURsNTVETGJNWWhjQWR6dlhScFRnSmVN?=
 =?utf-8?B?K3BYTmRNaEx6WDBsUC82eE8rRTZnVXRmWlFXMk9VaWRrVkVPSHo2UXRjL2o3?=
 =?utf-8?B?TE1EamtEdnlYTHFFZXJzMzJYQUpDNU5EME00QjNEY1J3alcwSTY4Rk5Fa0FS?=
 =?utf-8?B?cWlZa0FHSE1wTHg5YWtWdDBTSXNiVjYzcTRrdjN5T3hSZEJCRWZYNEVuOGtX?=
 =?utf-8?B?Vkd3Y0UrcEwwcE0reVQzYUxESVpiRldjNXVQWmQ5WCtRKzBicU1vYTlZUWh6?=
 =?utf-8?B?RnVQQXZCMDhPZm1OeWZGU3AvVkwxb2VpVkg0QVdpNTJjR2NyNGpzRzNFTEcv?=
 =?utf-8?B?aWl6VXkyZXF1d0ZvelBCajNETXFLdDQ0eFlnN00rUGx6bGFEMlhvOElFVm53?=
 =?utf-8?B?cUQ4Q0FHZlpUTjlhak93Z0pNUmNOMGNLZGJZL2R0ekZOWXd0eFV5TGkzN0xv?=
 =?utf-8?B?QWwzUkI5b24wNUxUNmpWSHZWeSt0TTJmWGZZVFBxQUZtTXdFZXNpWUdFdnBw?=
 =?utf-8?B?c09nYjYxWTYvNzlqb1AySUY0R09ER2Y0Y2JLTEdKUlpEOGJsa0pKL2NZay9H?=
 =?utf-8?B?NEJseTd6TDdDdFNzZ2xvKzBUREZwLzNBUmpxOG8xVUhud3BJTjFPN1o2QUNE?=
 =?utf-8?B?aU1jS005K1NHWTNROTFwWTZveWRlNk93bmpmOVkyVUFpcW1RR1E4Q1duRHVR?=
 =?utf-8?B?L1U3azg4WFJuWG1RS25WOEd2MUZpWkoyT0c2OWl6eHVXakJmNlYzcVpTa3hO?=
 =?utf-8?B?SDRIUDVSbkh3MkEzZ2svQzFNNkhpbW5ncGg3dVFGWGxydTRvZE1kMXI5WE5j?=
 =?utf-8?B?UUdFZFk4b0tiUE4zb1FvSDE3b05zM1B1RmV6U2hsSXU3di9EZlBHTVYxVEdV?=
 =?utf-8?B?VjBGejg0aGxFdnVTL2NIMnNRem81N1k1K1YrZmNEcGRIejMzVE44RTdiaXpR?=
 =?utf-8?B?Nm5PR1JjLzl0ejFFbmk0VWYvSHRtQjgwOVpadktkYXZsTnNRMDB6SVlLTDEy?=
 =?utf-8?B?NUZ3cHRtL2F0VjFjRCtjQ3Zaak1MaHl6RFY3cUlRRDRoU1F0bEpROWVBeFU1?=
 =?utf-8?B?K25KL0xZLzJBaXZDemI5TEE1QU1rRWR2Rlgwemt3UG5IU2JUSWtPaUxNYUVj?=
 =?utf-8?B?UjZoNzdJcFI5MXdxOXR0YXhidStyTTExRmlYRTdEemdkanY4aER5Y3lybnUz?=
 =?utf-8?B?cmdZYU5NYk1HVjFydGIyU1BXZDk2SDVxUmw0bTNkeklVaUtSRzZRMEg2V0Fn?=
 =?utf-8?B?Y2d3RE1MSVd4UURBKy8xOHJMQ2hCa2JRTThYV1B4YlRBRjNPQlR5WHN3eU1E?=
 =?utf-8?B?N3ltSGZuY2RQakRzZ1dsK0xVSnJvZW1oNHBWM05ha1BHa04wNzcrcWNVMW5G?=
 =?utf-8?B?aDFhTlhQUkcwbkZlMElKd1FHTUppTEZvNHRHSVpmTXB0N2hFcmRteDIyeUUy?=
 =?utf-8?B?Y1luUXprRE04UlZDdm5reUxkQi9vWlNOMld2VS9MOWFRd1ZBcjB5TW9BK2ZO?=
 =?utf-8?B?eHRtZjhQY1EvL09aeEhrVHdMMC9SYXVwTXF2R05KUlQ3dDdIN01DSzdkVU5j?=
 =?utf-8?B?SVZHS0lMVndPMW9YVjBDSlpIWGpxM3dOUFNiUklma3dEUGthLzQ4SXg3Ulk3?=
 =?utf-8?B?U29VQkRMODI4RE5DM21SdnNydXNrN0ZHYlRsbzNDNFRtaTdjdUNRMFc0ajMr?=
 =?utf-8?B?cE9BUWhXUjBBdVBXendwYWIvZFgwQlIraHc1blVCYVl6MnJZVDBkVnE5ZWYw?=
 =?utf-8?Q?axOu0g3QryeG/uGrbfzTdeXOt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ae278f-ad07-46d9-920f-08dc3e00908c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 17:12:12.7184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uO4vgl/ckSINybf9UvsBY8QASt1ZyzQwUkkiKrP4DG6UQ79vcOqm4wEosFwsNCdIvmlpUFfTn6P+FsoflYNfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8835

Hi Yuquan an Jon,

I added responses inline below.

On 3/6/24 07:23, Jonathan Cameron wrote:
> On Wed, 6 Mar 2024 19:27:07 +0800
> Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> 
>> Hello, Jonathan
>>
>> Recently I met some problems on CXL RAS tests. 
>>
>> I tried to use "cxl-inject-uncorrectable-errors" and "cxl-inject-correctable-error"
>> qmp to inject CXL errors, however, there was no any kernel printing information in 
>> my qemu machine. And the qmp connection was unstable that made the machine 
>> always "terminating on signal 2".
> 
> The qmp connection being unstable is odd - might be related to the CXL code, but
> I'm not sure how..
> 
>>
>> In addition, I successfully used the hmp "pcie_aer_inject_error" in the same conditions.
>> The kernel showed relevant print information.
> 
> IIRC the AER paths print under all circumstances whereas CXL errors do not, they simply
> trigger tracepoints - but you should have seen device resets.
> 
> However I span up a test and I think the issue is more straight forward.
> The uncorrectable internal error and correctable internal errors are masked on the device.
> I thought we changed the default on this in linux but maybe not :(
> 

Device AER UIE/CIE mask can be set and still expect to handle device AER errors. The device reports 
AER UIE/CIE to the root port/RCEC on behalf of device AER CRC, TLP, etc errors. 

In earlier changes we added logic to clear the RCEC UIE/CIE mask inorder to properly receive 
AER UIE/CI notifications from devices and RCH dports.

"CXL Protocol and Link errors detected by components that are part of a CXL VH are
escalated and reported using standard PCIe error reporting mechanisms over CXL.io as
UIEs and/or CIEs. See PCIe Base Specification for details."[1]

[1] CXL3.1 12.2.1 - Protocol and Link Layer Error Reporting

> Hack is fine the relevant device with lspci -tv and then use
> setpci -s 0d:00.0 0x208.l=0
> to clear all the mask bits for uncorrectable errors.
> 
> Note I tested this on a convenient arm64 setup so always possible there is yet
> another problem on x86.
> 
> Robert / Terry, I tracked down the patch where you enabled this for RCHs and there was
> some discussion on walking out on VH as well to enable this, but seems it
> never happened. Can you remember why?  Just kicked back for a future occasion?
> 
> Jonathan
> 
> 

I tested (qemu x86) using the aer-inject tool and found it to work. Below shows the 
endpoint CIE is masked (0xe000 @ AER+0x14) and the injected error is properly handled
with root port logging and cxl_pci handler trace logs.

 # lspci | grep -i cxl                                                                                                                                     
    0d:00.0 CXL: Intel Corporation Device 0d93 (rev 01)                                                                                                       
                                                                                                                                                              
    # lspci -s 0d:00.0 -vvv | grep Advanced                                                                                                                   
    Capabilities: [200 v2] Advanced Error Reporting                                                                                                           
                                                                                                                                                              
    # setpci -s 0d:00.0 0x208.l                                                                                                                               
    02400000                                                                                                                                                  
                                                                                                                                                              
    # setpci -s 0d:00.0 0x214.l                                                                                                                               
    0000e000                                                                                                                                                  
                                                                                                                                                              
    # cat aer-input.txt                                                                                                                                       
    # Inject a correctable bad TLP error into the device with header log                                                                                      
    # words 0 1 2 3.                                                                                                                                          
    #                                                                                                                                                         
    # Either specify the PCI id on the command-line option or uncomment and edit                                                                              
    # the PCI_ID line below using the correct PCI ID.                                                                                                         
    #                                                                                                                                                         
    # Note that system firmware/BIOS may mask certain errors and/or not report                                                                                
    # header log words.                                                                                                                                       
    #                                                                                                                                                         
    AER                                                                                                                                                       
    #PCI_ID 0000:0C.00.0                                                                                                                                      
    COR_STATUS BAD_TLP                                                                                                                                        
    HEADER_LOG 0 1 2 3                                                                                                                                        
                                                                                                                                                              
    # ./aer-inject -s 0000:0d:00.0 aer-input.txt                                                                                                              
    [   72.850686] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000040/00000000 into device 0000:0d:00.0                                             
    [   72.851784] pcieport 0000:0c:00.0: AER: Corrected error received: 0000:0d:00.0                                                                         
    [   72.852594] cxl_pci 0000:0d:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID)                                              
    [   72.853591] cxl_pci 0000:0d:00.0:   device [8086:0d93] error status/mask=00000040/0000e000                                             
    # [   72.854277] cxl_pci 0000:0d:00.0:    [ 6] BadTLP      

I have not tried to use cxl-inject-uncorrectable-errors or cxl-inject-correctable-error.

Regards,
Terry

>>
>> Question:
>> 1) Is my CXL RAS test operations standard?
>> 2) The error injected by "pcie_aer_inject_error" is "protocol & link errors" of cxl.io?
>>    The error injected by "cxl-inject-uncorrectable-errors" or "cxl-inject-correctable-error" is "protocol & link errors" of cxl.cachemem?
>>
>> Hope I can get some helps here, any help will be greatly appreciated.
>>
>>
>> My qemu command line:
>> qemu-system-x86_64 \
>> -M q35,nvdimm=on,cxl=on \
>> -m 4G \
>> -smp 4 \
>> -object memory-backend-ram,size=2G,id=mem0 \
>> -numa node,nodeid=0,cpus=0-1,memdev=mem0 \
>> -object memory-backend-ram,size=2G,id=mem1 \
>> -numa node,nodeid=1,cpus=2-3,memdev=mem1 \
>> -object memory-backend-ram,size=256M,id=cxl-mem0 \
>> -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>> -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
>> -device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem0 \
>> -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k \
>> -hda ../disk/ubuntu_x86_test_new.qcow2 \
>> -nographic \
>> -qmp tcp:127.0.0.1:4444,server,nowait \
>>
>> Qemu version: 8.2.50, the lastest commit of branch cxl-2024-03-05 in "https://gitlab.com/jic23/qemu" 
>> Kernel version: 6.8.0-rc6
>>
>> My steps in the Qemu qmp:
>> 1) telnet 127.0.0.1 4444
>>
>> result:
>> Trying 127.0.0.1...
>> Connected to 127.0.0.1.
>> Escape character is '^]'.
>> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 8}, "package": "v6.2.0-19482-gccfb4fe221"}, "capabilities": ["oob"]}}
>>
>> 2) { "execute": "qmp_capabilities" }
>>
>> result:
>> {"return": {}}
>>
>> 3) If inject correctable error:
>> { "execute": "cxl-inject-correctable-error",
>>     "arguments": {
>>         "path": "/machine/peripheral/cxl-mem0",
>>         "type": "physical"
>>     } }
>>
>> result:
>> {"return": {}}
>>
>> 3) If inject uncorrectable error:
>> { "execute": "cxl-inject-uncorrectable-errors",
>>   "arguments": {
>>     "path": "/machine/peripheral/cxl-mem0",
>>     "errors": [
>>         {
>>             "type": "cache-address-parity",
>>             "header": [ 3, 4]
>>         },
>>         {
>>             "type": "cache-data-parity",
>>             "header": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
>>         },
>>         {
>>             "type": "internal",
>>             "header": [ 1, 2, 4]
>>         }
>>         ]
>>   }}
>>
>> result:
>> {"return": {}}
>> {"timestamp": {"seconds": 1709721640, "microseconds": 275345}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-signal"}}
>>
>> Many thanks
>> Yuquan
>>
> 
