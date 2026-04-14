Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011037.outbound.protection.outlook.com [40.93.194.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E5E3EBF39;
	Tue, 14 Apr 2026 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181322; cv=fail; b=VQZBhSCM2SIFo9p2AVc99wUbR8qdnVwj8EzAuT1o2VWONBamPtPI9Ts6GAcnRsgoMtbkRqu0gMw6QrHgALYzxEM8pFlMbSKQHW6+glyyumMWJQCgramuUiqRCt0Ut1J125x564pLPlNWatTXWU8YaaQoPeeD7aBwdlogfrzm6nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181322; c=relaxed/simple;
	bh=D5WB7tynRCNJQk9lY905TjoO1/gmHbeHAI8qZ7wezM8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H/dfGcuLH7AWtF88x/SkYhoSWZT4dsxhb8y5KT7mICQ+UtIO1BMpjIkZraDyAYP2K1yrmRKws0790PJFvkzAj2p2AKPzpa5HVLaQCVYkV13jVQlzeQdushgcHZ/kS9DULKCJq6TDgN4QFfgwYiHjbCYIGnUaVuUEf/lqdQgQPyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tSXKZuh4; arc=fail smtp.client-ip=40.93.194.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tSXKZuh4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSC5KFpMUV5e/UDX8Pk1BoO1e02bsD8IVYF/+4lEb+z+bMeQ59Izh2cJvHPuX0QVNprBm6JMQbPxLZiEr9hpwjYXcCVRVLyiUtaRYxJAtL2cLMsvttjkevKLNvAtGfmMh+UYwYrvsHDY5yBeANNetoizS5qB8MT2OX5iC+guJjSXwqWL4nkqO1Vw/UJFODtd8prUHjQBWm4X8VESS5XHPWTs0FpJiIcJ33/FB1lOHqnhXUzVQRtuLQHxZ/XLFvt9uQyLw2703M8aIr/GewSQCicIl1+i44tmX8Oq4vFsBcrKcIV7ahy8B2CtF1W00uNABDPeh6RrQhvi/8Y8aDMKAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovybKyk6imtRwO4O/z1HFOiuUP6J2D/FfQ9YHW3Igx8=;
 b=H0D51BEN7MLh//52Wg7iZECtoO4c1V0NmOz1Df6z2D6mBJ9WtyTM+i6y0+MSp6nDtnu8BVYpsc8RcQ7QLnqSk3dk5f3pAx9xuPZVtQMi1+TY7eTcm5yyw0uT7X+PE9IX2ETv9fB5ETU9Oxs9iXaBQsMrWifueEAkmevu8J6dse5byDdxOJVITBUUEbo2/OzwXgEPcVO65CHUi30xVxGiqPQ7i4miaZ77nC97B2WEtHgyJXhRspRzw7E0j/2H0sOtoOj6Ox7XEHbZd5D6dSHLsLik6v+1rGvG5UYMKdHAkv8xS5dK9hEx7cs7HtkVmZu4r9Iop5zYZmAZSVJT+w2EDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovybKyk6imtRwO4O/z1HFOiuUP6J2D/FfQ9YHW3Igx8=;
 b=tSXKZuh4NdK9xNtJlsJhz4ahXSk9uYU1//7YydKvYbCub3T2hZElzTPtEMN/95zMrga3fRSNYfltGZZhvQwZ+NBHCMylCGpx2i97DAL7brdoSz8UfcBjulEPWQkTVvak1XFrUvzVhs5Vhn91cv4Icx2eUUaI5UJc9dPLtlTjHBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 15:41:51 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 15:41:51 +0000
Message-ID: <b592580e-da0f-41fe-9ac5-d8dcec8fc6d8@amd.com>
Date: Tue, 14 Apr 2026 16:41:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] cxl/region: Introduce cxl_memdev_attach_region
Content-Language: en-US
To: Dan Williams <djbw@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 alejandro.lucero-palau@amd.com
References: <20260403210050.1058650-1-dan.j.williams@intel.com>
 <20260403210050.1058650-5-dan.j.williams@intel.com>
 <1bb8bdd7-1083-4b08-8d9f-21d218e383ca@amd.com>
 <69dac05fd8b20_fdcb410011@djbw-dev.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <69dac05fd8b20_fdcb410011@djbw-dev.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0192.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 783f50f3-ad36-4a15-50c9-08de9a3c58a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4GY4YtiqeAloNGFjHRzzBxmGdUzD+iVfyJ1SAf77Gzh5cpFcX9EdBt3A7rCBnIT+iObgoQBdFT/PtMcPdmt4TgEpeRxujz+kEXu879gQ/gckBR9dRtYZaUFInChIoajAHDumxZPuE3gaHL75KB5qyNLdOLweT8Cikq8xBN91Kxgy0/qqP5t3WauQCa+H0JIaenGAWyk+xs1/+m7X/sVix+lT4GbNd4ajxaX7Dwx3bciWujiXJ96VaxEX06Nh4mrd9Rp4O+OxW+4wbvdohmjedu1OKbZ1QxLrVqBIumLDahI9yLi9Wcq8PlAIELCDgvlaDx0AZrWGLwYwX6jKfSQCLhK1csASSRZms6AKRETi9ip4GLZpZSo0vNQJWfVmGfbstEsrieqPc2fRwXix97XKmZx02uur7wKnmjB88zQpy0HY0UelvuScmgWznxqA/Y1rWKxf5SRghqUYAKtjJZT28sCseedrv7DYe7HvQMe4OclPR7eKeAziuS0EDxQ2yam97WNtTaTTA4L8SfBuLV1ZJRnwVx428IxGK8rOw9I6PtJql1BHB/C2EcJ6tc7a5o3WJ7qaOmrmwmF2O/yE1u4hmWwKgzABWgxrcCCRH0YUHUa01nV6DUv1kAoIiUz1nmb59Pqlh43Qc0V1qExR8V73upw8dejFI2+FKR2C+RGtvqG/5tgJk7NcpOjhPbDKzbdz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amUrQWNuU29seDEwajVESnhFWEF4cjFVS28vbFpnbStndEFtWkxjUCtta2dp?=
 =?utf-8?B?UlRwbStWNFVsVXFGV1c4SWFLc0lOSEY0ZURCaGxDekJNNXY3NW5PK0d1a2tN?=
 =?utf-8?B?dVp5cU8yeDVYZWpqQjFubXd2NUJ0RzRrSFE3NEJ5ZUY5RnNieGV4bjR6WS9i?=
 =?utf-8?B?OXI0SXdOYXJwZHVxenQxSWZNS05rVGN0dUxRSXZOaDI3a1dvL1BqWkovRVZj?=
 =?utf-8?B?SFpJd1hkWis3ZllySDhXTEI0dzc1QnA3MnVmNmNhSW5vcUYzNkwzcmlFTUdJ?=
 =?utf-8?B?Y2tucCtLMW4zM1U4Qnh4Sk1zeGNPMGVFVkdmRm9LY1lpZFhNc2p2YzB3aEpV?=
 =?utf-8?B?U25yTmNiUnJMbE5laDI4Q1hnNjJmY2prVkwrZ3dlbUE0ZmtMbjgvb0VBV3Zr?=
 =?utf-8?B?OUNkcGFNQVJTamtVdlZLZWE2N2pNb2Y5VERMWG1kc3RJbHFIN1NpWERuS3Zx?=
 =?utf-8?B?ZGVvbnlHSm5OVWVrM0FpNjlZNEI2V21Fa1R2MHVENnErS1F6ZVg2UnlYK1Nt?=
 =?utf-8?B?aE1NV3JQZlhtMFZqVkk1eUc4K0s5cGtUbVRaT3lnOFV0SGFiaWZSMUl2dis2?=
 =?utf-8?B?YUdxTEtLa1JxTHRWKzNEaG5HR051U3FmYmhEb3drMitkbUl1dkFMdVpzL2E5?=
 =?utf-8?B?Szl2MThoODV2d2tXVXBYczR2cG0xQlNpY2pNaDdxRjUyVnhtNjNKVjhJTmsx?=
 =?utf-8?B?UTdUMm1uYUk1ZnQ5SGltRkFiMEtqR0dGWnlsNlZQS1ZFNFZKQzNrbTA3REJS?=
 =?utf-8?B?VmgxZDMvaTM4N3FGVk10VWdXN01HQVVrbmNpS3F5WG5ub3EyRVFoRDFJK1Rh?=
 =?utf-8?B?ZSszTzh3Ny9KL1MraFdrTDVDeU9wZEw1bFI3NHRLc28vQlZCU2hQcE5Ed1Rq?=
 =?utf-8?B?ckMrWDVXVXhFZ2NFQVZCeFV2U1lXWkRrM0VRYm1GeDRnRUxJZitpQlFTY1NU?=
 =?utf-8?B?cHZqSytKRm0zeHVsdEliaVBzWFNxL0YweUFRdVlqR0pxdnF0UUg4UndhUFNL?=
 =?utf-8?B?WUdGL01PakxLS0V5akxoQThrUzJLUElERkJQVTJ4ZlE2VmNoeTFRV1FNT2hC?=
 =?utf-8?B?R2ExWGxFSFpEQ0xpc2x2R3M1OHZtRHR6Mmc0Uy9SZ09OYytDVEQvYVliMVFQ?=
 =?utf-8?B?ZXRuM1pscEdKZ05PdUxSV0hqZ3NUUlJjOGY2aU4rUzYwdnpab2s1NjhROUVH?=
 =?utf-8?B?YWNTNU5hV21XbjUvY3NkS3BlZXM0YW05Yk5IZEZxSmM0ZnNBeFN4L3Q4b08r?=
 =?utf-8?B?SlAwL2svWTF0bnhYQW91MlZJOGVlTWpCejFWKzRYWWhWQU5FbFVndjlKODYx?=
 =?utf-8?B?Ly8rWHNFb3NhZnBEaG1YdWNqNHduVGVUSGR3b0pKRHlENVdPUWhSMGo2S052?=
 =?utf-8?B?aFZDcWk2T2EzVFVocXBWeDlVd2dEZW8wbkZxYTlKK2Y5b3k5NzVpTzdQUFVP?=
 =?utf-8?B?RnJWMDJBc05OY3FQWFlnQ3hENytxRUpwVklma0pJY0gyK1Jqd0VqdnRPUnlR?=
 =?utf-8?B?YkR6M0ZmYyswWUpKRGNmNGt4NzR5Q3JuZEFqZXQvdTR1QzFOL3RDcis2T01w?=
 =?utf-8?B?dnZKQmx5SzhHbndTYVhhSWFiM2hzVjdnQ1cra3ByTjU5Y1ZiYjNxc0o2RXk5?=
 =?utf-8?B?QmlXZ3NRc1FJS09SdXg2MklmbzhUVnlYeVZtSjV1WjZzYVo3UGplZXM0ZFhL?=
 =?utf-8?B?U0tYZzZ0TW5MLzRRdDJCbVdpUUpndGNoSEtqdzZxUTZWc3FBSzdCdGVRMTY2?=
 =?utf-8?B?RjI0ZjkvRmlxNkJKZXZRcFJhdVlwOS90TTNySnVnaDRnT1IyYkhUc3Z3dVFN?=
 =?utf-8?B?UHJaTkl3S3AzdCtWdHRQaVVFV2RPWXh0UktLRFQveUJ2Zk9QZW5vSE96czVE?=
 =?utf-8?B?cUZGQUZpV0krOThUWHR3eEl4UmFzTWprY2xFKzlIOWxMaklSY1RRcXhlV0xL?=
 =?utf-8?B?UVd5ZFhiYXFTYlpMajNEREpWTVBmMUhNc1V1Tm56bloxL2pyR0NCOFV2MUhE?=
 =?utf-8?B?THhrdjE3RzM1MndIQ0dKaHBXOW9TOURDSUdieHExT3ErUTErOHJPMXZ6SVZX?=
 =?utf-8?B?UVU5VWNNZUNKWmJIRmRDdXFiWm5GbDdBdmhqbjV2WVZtTVdORUVJL3NPeUkv?=
 =?utf-8?B?UHoyeG1WRi9EYmdic3dIdWdjYkJFaEZPdk81YTVDdFdORFZRYm5lcXlpMENx?=
 =?utf-8?B?SjBCejdXcGtMSmVPWFJBMzNjTS9mU3oySEJreUppeDBZNlRuclNVWmpuYkIy?=
 =?utf-8?B?M2s1c2ZZblRUZTBlcTBBZlpXYmd4TVpvdjYvK2dYZFI5cTFsVjlZTUNvZk85?=
 =?utf-8?B?RCtpb3lBWjdQOElUZmVqTUswWGg4Zzl3SEUvN2UvZWtCc2ttYTJNdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783f50f3-ad36-4a15-50c9-08de9a3c58a4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 15:41:51.1062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsNmKCRDlBJi4aBYnj73lZoE6gfbamGhR2CeXnaukH6MpJZgpfmvlkfbRTdk5gLGVRSz47XLJrkZjKhFJ4ryiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855


On 4/11/26 22:42, Dan Williams wrote:
> Alejandro Lucero Palau wrote:
>> On 4/3/26 22:00, Dan Williams wrote:
>>> To date, platform firmware maps accelerator memory and accelerator drivers
>>> simply want an address range that they can map themselves. This typically
>>> results in a single region being auto-assembled upon registration of a
>>> memory device.  Use the @attach mechanism of devm_cxl_add_memdev()
>>> parameter to retrieve that region while also adhering to CXL subsystem
>>> locking and lifetime rules.
>>
>> I doubt this approach is safer than the type2 v25 case.
> I believe it is safer, see evidence below...


It is safer for the case of user space unbinding a memdev device from 
cxl_mem racing with the type2 initialization regarding the linked 
autodiscovered region to the memdev. But, if I am not misunderstanding 
something here, the problem remains ... (below explained).


BTW, I know about unbinding for the virtualization case, with a pci 
device being bound to UIO/VFIO instead of to the host vendor-specific 
pci driver, but I can not see the point of user space doing this for a 
cxl memdev. I know the unbinding is standard functionality but I wonder 
if this should be avoided under certain scenarios like this one. 
Otherwise, if there exists a reason for allowing this, I would like to know.


>
>> Apparently you are reducing the potential concurrency issue if someone
>> removes cxl_acpi, but I think it is as strong as the v25 approach.
>> With the rwsem lock, the region will exist or it will not. If the
>> removal happens after the driver gets the region, the ioremap can
>> race, with your approach and with the v25 one.
> Yes, ioremap can race and in the attach case when the ioremap is
> invalidated the sfc driver gets unloaded. In v25 it leads to
> use-after-free issues.


I do not follow this. I can not see in the code a link between the 
autoremove functionality and that triggering the sfc driver being unload.


And the new function added, cxl_memdev_attach_region(), supposedly being 
called by a type2 driver after getting the memdev, does only ensure the 
region will be there for updating the attach struct owned by the type2 
driver, but as soon as the endpoint device lock is release, that could 
not be the case, I mean the region not there anymore but the attach 
struct having still the region data.


Also, if the cxl_mem unbinding happens after the type2 driver has 
invoked ioremap, the driver will be using something it should not. Won't 
it? I do not think that is correct and the type2 driver should somehow 
get a notification for stopping using such a range, some sort of detach 
function the cxl core can invoke. That is something I unsuccessfully 
tried to add in the past:


https://lore.kernel.org/linux-cxl/20250624141355.269056-19-alejandro.lucero-palau@amd.com/



>
>> Also, you are keen to use your attach function for doing the same thing
>> I have, which needs to be justified.
> No, you need to justify usage and export of cxl_core objects without
> taking care of the current lifetime rules. Did you see these reports
> from sashiko about v25? These issues are the motivation to pull
> responsibility away from client drivers.
>
> https://sashiko.dev/#/patchset/20260330143827.1278677-1-alejandro.lucero-palau%40amd.com?part=6
> https://sashiko.dev/#/patchset/20260330143827.1278677-1-alejandro.lucero-palau%40amd.com?part=7
>
> Now, I do not think the "attach" appraoch is the final end state. This
> needs to get simpler still, but it can not get simpler with an
> increasing attack surface.


What I mean is the protection you are adding is doable inside the type2 
series without the attach option for cxl memdev.

There is a justification for the protection avoiding racing with 
unbinding from user space, but there is no justification for the attach 
itself, at least for the sfc case.


>
>> I can not see a reason for that attach functionality with the sfc
>> case. You did not reply to that comment:
>>
>>
>> https://lore.kernel.org/linux-cxl/20260330143827.1278677-1-alejandro.lucero-palau@amd.com/T/#m21968fd0ddf02df3641194d1450cb2bd392def26
> Yes, did not have bandwidth to reply to that beyond sending out the
> attach approach to better contain CXL core complexity.
>
>> And although I have not tested it, I think this is buggy. Removal of
>> cxl_acpi will trigger unregister_region and a subsequent driver exit
>> will invoke, inside the autoremove call linked to the endpoint device,
>> devm_release_action on something not existing anymore.
> If there is a bug here I would like to see that test case because as far
> as I can see it would be shared with the generic expander case.


You are introducing the cxl_endpoint_region_autoremove() linked to the 
endpoint device. If cxl_acpi is removed, that will lead to the region 
unregistered first, then the delete_endpoint() trying to unregister the 
region with devm_release_action() again. That will make a kernel warn at 
least.


>> It is the same problem with v25 type2 and potential cxl_acpi removal.
>> Maybe we should avoid linking a type2-related region to the cxl root
>> port ...
>>
>>
>> And IMO, hiding what we are doing to the user/driver is not convenient.
>> Although current type2 is going to rely on a committed decoder, that
>> will not be the case if we look beyond impending needs.
> Yes, start with the simple committed decoder case. Later, follow-on with
> auto-create support. That would have no need to go back and teach
> accelerator drivers how to create regions in the simple case the same
> helper would "just work".
>
>> A function with a name describing this situation can add clarity to
>> the different possibilities to support as a follow up of this initial
>> work. About naming, attaching a region to a memdev is confusing ... as
>> it is already "attached" or linked, and the reason you give for having
>> that explicit attachment not being clear from a safety point of view.
> I would be happy if the only detail left to discuss was naming.
>
> In this case "attach" means "attach to CXL the topology". A PCI driver
> can create a cxl_memdev, but if that cxl_memdev finds no active CXL
> topology then that "attachment" fails.
