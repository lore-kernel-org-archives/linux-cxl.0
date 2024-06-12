Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D1484D0F
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 06:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718172437; cv=fail; b=rana8jkNxUhbred5BJR2ti4+V8SHc/VVJBnx68JCgN8vR9nSTgr/IFwFJ3CH3OWXoA0O8e1AOWBXvI2E1QL0g0PURPrSEteMhWHmFyrYugl7WcGwlJ2U2mZnlrm1yyrR5spVeW0ZO0ztX6RQekEYP9bZ7ekodATG4J2cnJUkOz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718172437; c=relaxed/simple;
	bh=qKgodqiP6hZCNBLIv2dsNH+rxqcmiVEmMeVRunKiIfM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ioxjqAkjqJZAC427rhvphO88Kn68oL6Fpgotm8zwm12ZeUkdgvk4ihDI40NObeHhGVUZvwPKALta6RAsWltSIMTFUD7Phow49NfQDIKsr8DZsJ+e+E/1PvoRyGm0xLgmsA7MdDvxbHPQu9eOda9aU1klRzxpWx8j40zC8CchDyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dfIwOMbW; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dfIwOMbW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GH3lRnWAG9pBJmG3xDgjKnk3Q48NZL6sdOXIjrGpeU06CDTAWZ+JeeAnd4PT4aNu1IjFqLQ4Fpijif6xJv2fSLFyWs9FcsuIPJOwxHzt6nGOoM0IRhrN1JWWH3d/IUowO01kTgQt2+H+CXPUL5pBcX0391o/6J95IYg7qd4Gmk+V2v34Fh4dsbvbyJkeDYOfDxd7aYZf/51aI9men8MhrMQrrN3IU2OzZrALPWqEN8iudpl8K80FsT4o7LJzniNPPb34+rYYQ/rs9v+lrFUduXK0kIY2ESFBf2HN/Ng78VKs2EObIZS4ncvxjwmKG55z+hy7fu3k1k8kqzQNoXEoqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Q2NBjJmJzY1W+T73cFv6kpnMlu4vsWDX7XPU+cBeSs=;
 b=AYqTkloaOis3SH6JqyASkqhHgeaLAcYXHk16SzhAA3ukyOiuJqWLz4WtMIjqqCYS10rQlfggb0KmOCIK0G7UAQWeaKkOT41Lg3jg32P8sNjCqKhNQQ/1spylT0WLL1huMQHYOoGlO6PhpAUE7OfKXOWUrazOItnjRA+HCkcvQF1P2CCqdE4ZgN6fZBRSI5Zx0iNxTfyRaCXCLuPU8KiRrHAP10F9rK8C/CT3MXspnffh/x7uQ7LCK7xTgR2ZiPTAH/zBz6/jUAb4k2QNI2UUDWCYwoKS6knCo431hX4SfSYlfscrAo+u7OpCEVSsUZ4z9e41t4N6qVijYTNRxY26IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Q2NBjJmJzY1W+T73cFv6kpnMlu4vsWDX7XPU+cBeSs=;
 b=dfIwOMbW8iweaThwXNWhDmRDTf5qWPIxHgYijr0uyKbxJ64m/WjAfmy5LiujN3hZyD8H4MFEfLhORa5sTmnkl1gYaXLuf60qRgskqhTAfzPApYJNOegDMvOstTAFa+eyLWYa4yyPgm1uvoi0sfKa9lk7N9dlbeD1jVQb5ucBn9g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 06:07:12 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 06:07:12 +0000
Message-ID: <30515d14-2cd6-1967-c656-e8b17ecfd8d7@amd.com>
Date: Wed, 12 Jun 2024 07:07:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 03/13] cxl: export core function for type2 devices
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 pieter.jansen-van-vuuren@amd.com, richard.hughes@amd.com,
 dinan.gunawardena@amd.com
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-4-alucerop@amd.com>
 <666928a27eefc_3101294c6@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <666928a27eefc_3101294c6@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0344.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: b8280188-3fe4-4dee-8c6c-08dc8aa5e69e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|1800799016|366008;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWpOMWFrK0dubjhVOWZYYnNoRW1sR0lYaUYyNEZLelZLSEE1UldkODI4ZjZt?=
 =?utf-8?B?bU1ZT1pDeGNDQUxnZjVyMGRSbUpXNFcwb2tOMTVHVUxCb3NBWUZiREdBQzJ6?=
 =?utf-8?B?OHJaVXM5SE5VOWVIVHpKMTJybCthQm1MUzJ4SWRZV0w5b0RjdnZ0RUlLZjFV?=
 =?utf-8?B?UVBTcTZDVDA1MDRxK1hJVlZzUTFHdXIyZ2U5dGpVTi9vbThYcmRGd0FlYlNV?=
 =?utf-8?B?YWdkYytKVmtCNDRnN09oQWZ6WDdwenU1VWtYUkNrakRLdFc4cmoreldFZEwy?=
 =?utf-8?B?bDJ5cmRibHQrRzR6Vjd5cnZrdzNNTjdvMWl0SGxDRUpIZG5KVmxQM1grQklU?=
 =?utf-8?B?bS83Sk5kdUloTEFpbkJFSXVkdDRGYkdicWd1Z0hLaFZSRW92MnduTmttWDgr?=
 =?utf-8?B?WDZraHV6Z2EzTlhFNHI3YUlTVXVaeTJ4V0ZOV2JqRlYwU3Zia1pVZGF1SElH?=
 =?utf-8?B?YnU3NVpOQ1RNTjl3bHg0ZmI0N2YzNjFyS0wvRTZvczdLZFV3cGZPbkxSakx1?=
 =?utf-8?B?c2hCOWd1UEZDc29zbFNDTERvdTNTOFR1MjZyVlZOdldEZ20xcU5hTlBhZUN4?=
 =?utf-8?B?WlVjWCtqTVBVZnVyOW9FZE9zNVVsS2hkMUNHRitPcmhYTURPQzJvNUE3OEox?=
 =?utf-8?B?QWNwWkNqK2ZrRmJGMmdRTGNOSnRkVTZhK1Z0WDNnNUFORGh6bXhIeVdITDMy?=
 =?utf-8?B?cjZ3RlFGalpBRVFiZnpza0F2bjJuV3YwNW5GRUM5SXJBVERWRU9BcjViQ0pZ?=
 =?utf-8?B?TG04dHNEMDRuc3NGQWJHc2c1RXM3Z2paWFlyV0VNbmxDazVWcGZ2ZmRycy9N?=
 =?utf-8?B?NHZ1WXZhWjR2THROZGJjQ1cyR09lcjk3S2R2ZkJjQ3lFSEhlR0hSNlZhQVBq?=
 =?utf-8?B?RUFaYWxwWE0yZHJBOW5QTEpWSXo5TVVpTzJydGxPVEZBTkVMajFKc2drczB3?=
 =?utf-8?B?Vms0czg0Q011azl2Nkd1a0l1bkcxcVlLdFNRVmtyVklka0puNWRTZUZ4M29h?=
 =?utf-8?B?enpJNjJCOGhreHM4MnZkcnUzUHJCVEZNQWl5K3RRNVhIbVVjMkJCYXcydnhl?=
 =?utf-8?B?UXRCaGZodkZCZUp3bUJ0OXdDbG5CQ3Q5OERFOURkT2xBOSs0K3R3ZURXSEFL?=
 =?utf-8?B?QXlzSmdLdWN3Rk5oV0NEVWFNU2JTeEhSQjNjQmw4M1ZDeC9WWGlVb296V2Zl?=
 =?utf-8?B?Y3hXS0tsbVlWWEVCUkpJNWhORG5ieFFHdWFad1Z1ZmxHQkUxc2RzYXN0NVJi?=
 =?utf-8?B?S2pvSVdrVjhLRklEK2hOVk1VNXBqRDgrdVhsZGEyUXRaeW9pbFQ0QVZ2NWl6?=
 =?utf-8?B?dm1iNXV5ejY3Z2hXQU1tUlBtVXVFSE4zV2dESlc5aVc1WTQvTWR3dVFZbUxK?=
 =?utf-8?B?Y3p0Q0JreTVCNytNQUtxNnBCaGVJQVV6bk5LM2JPRjV3SktRbnJJTlI1V081?=
 =?utf-8?B?SGJMK0FIYlkrZXY2SFg5YW5qZmJXVUtxWVpEUHcvNzhYQlE2NEJpTXltUXpU?=
 =?utf-8?B?dHV5dkpIaDN3cUszbnRaaUlNRHlsSHlaSW5iTGxkMnEwK3ZkZnlNOWdtSnFr?=
 =?utf-8?B?dHBaTi9HaXhvS3pGM3JOU09WWUVxZlpUMUNLUExSeFkzd0U4a1gwYjI5U0FR?=
 =?utf-8?B?aThlYmNmb3VhYWFYdjQvTTlMZlMxVVNxajFkVTQ1MjVvWlNMZG51bU9aTEUy?=
 =?utf-8?B?QUo5K3B2MFFLQzcrOXVkcU1uVzRvcWhnbFNCai83aDlTQnpMcTRBTGVnR1Zj?=
 =?utf-8?Q?o0Ga6HEnOKJOzNrw4KyCBXfqansSnyfAy941Ce5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(1800799016)(366008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1VFelZSZjJHaTI3dHNvcEhVR25wbEtKMll2SUhuZE9kMGw1VGN1Mkhud1hE?=
 =?utf-8?B?clE2OHZNMnhCY1QrbE4xcHNBWlZDSkxoTFVuMFoyQmI3YkdtZmpMY1N1Ulk2?=
 =?utf-8?B?UzFIUnE3Q21pUE5wV1VCVG1nc1NiNjM5Tm5JT3hMdXZHTFgwS0t5dmkvd1FW?=
 =?utf-8?B?cjZDWU9TRmV3UldCTzVnUkxKd1EvdVBCWGJVbnFVTHJISVFGSUcwendYanA4?=
 =?utf-8?B?ZVdYOERhOTA5VzlpYTZ2Z2lwLytSOUk3K2VQcUJlYkVuYzR5YWRiU1V4RzZr?=
 =?utf-8?B?Q2JkMElGUTdiZENqSG5XZHJacWkxTG5HamM4Y2RtZU5EdEIvTkVqOVk2TjZQ?=
 =?utf-8?B?OE50c1FXRVRZbCsrVkM0NUNNWThaSy9PRFNhZSthb2VuaElTUU1waURKalRi?=
 =?utf-8?B?N2dxTWtuaGphd2ZGNDFzOEtEcXdPdjRUa0RXV0U0Q24xS3YzeisrNFVSWWdD?=
 =?utf-8?B?Sno3OURVM0wwQXZ1YUVuOUpQcWNrUUVWS1dXUW5KeWYwT3FFZlp3dHFHMXg5?=
 =?utf-8?B?ZE9maG9BR0lTeWVWR2xHQVlSYUVIQ2pXRWpuUTNSeXZGMnNlUFJKaHA1ZmNV?=
 =?utf-8?B?R2ZqcGtCUGdzUlJmZDQ3NGNhZFUxRXUvb2YwZ1cxd2NyN3B0S3ZXU3BDaWpO?=
 =?utf-8?B?QzhSRHVTZzBXTkJmMmxlbHdrUTMydXRzaHYvUWwycnlSenprNURHa2djSGtz?=
 =?utf-8?B?Q25ublppa1U1MjNyRExVWkNxQzFPOEJNd0l1S2NhK0p0WmlNKzhmNTU1aEc2?=
 =?utf-8?B?YWVQQUhDbjU4eW1TMlZwVEVkNVh1Uk9qMFNIY2YxN0NwaXZrYi9qcGw2c2th?=
 =?utf-8?B?aXRBZ2UwOWNmR0tHM1AzMTB3TDYvUm9xNDRBRzVJT1BLZWhOVGozYjJYRzBh?=
 =?utf-8?B?V0tlUkJwU0Z3WDRnZVFlbUhobExrYmFoNlV0TWRrQzVNVkFiWCtiYUxSbG93?=
 =?utf-8?B?QUlFakFMc05JMnBoN3BCTXU1YnJSeHZpdWpYSHNCV1phcUtOYS9Tcm1wSHJG?=
 =?utf-8?B?T0hQMWErUUtVVDMrZWNYVWs4T3JSYVNnYmtDbVNYZzVaNGw3ZGVKMjZiOEZp?=
 =?utf-8?B?bmN4MUVUUzNCLzZJOUZSaml1SG4wUkc2S3FSM0hWeEJHNFVkS01ZamVQcDFR?=
 =?utf-8?B?WXM2cG13WmNBcllRTlVubUxmRGoxSEluTHFLQ0d6VWtBUlBEWkVOYmFYaE5O?=
 =?utf-8?B?OStCMm5yc0NHbDVvOE9jWTR4QmwxMHc4cUVrQ2x0bE5mRGNEQjJsR21ZV1JT?=
 =?utf-8?B?N29ZeHNobTU1cFdTcDlHVWN3ZW5YWU1BVThpMEhMcUc5VWVYYU8rWlV0TWN5?=
 =?utf-8?B?RVZ6QlJVTThpenlyemlVTmZ3bjhzeWNDOVZBUlZ1WksvWktUMWlBWXQyK09Y?=
 =?utf-8?B?eHEyMDY4dGZZQXFpd0ZMRnBUWmRkQUh6MnJvcTFFTDJ5Mkx5U1IvelBQUUIz?=
 =?utf-8?B?b1pQNlVXaXpsYUV0OXM1QVMyRUNIblpYL3NNZW91cFVvaFlrRFQzZnc5TC9Z?=
 =?utf-8?B?U1lJM3l3ZHJ5NmYvNEtyUlF6R1ZIdHNIQzRaUnZkRUdLVFBoZjdrV2QxVnFu?=
 =?utf-8?B?cFEwWUkzS3UzTjZadnVjdTBLREpMaFU0UWVLT2kzdk1lVkcrSkRkRVgwNnE1?=
 =?utf-8?B?aGt3V1I4QnZUU0trbk9sYmRWTlhPTnYzTlNCTzRQYzNWSGk5MVV4T21yWjI5?=
 =?utf-8?B?dzhQWEk5aUlkRWRpNW5zU2JXYkFQVVF4a3VMV3g3SWwwZENEczBuaEhGMVZp?=
 =?utf-8?B?Z3JIT0t1NVZ2bzM0TWpiWVd5dUUxR2VZcExhbXBxV2xtZVFBTXQvZ2tmaGVq?=
 =?utf-8?B?cE9kU1p4ZW1wMUZkNmdoR0tmZ1pDQ21pdjVsK2UrVDNvZVRheVNZSUMwSmhG?=
 =?utf-8?B?ZzE2MHBnalc1ME1LUUpmdk12dE5NRUVNaUFJRnJUOVg1bEpYWlBCSzFXQjFm?=
 =?utf-8?B?ZWJZNDFlM0VCemxjZWsxN09xYlpRc2FYUVV5dHJJZno4dzd0NzFjQ2dObFNR?=
 =?utf-8?B?MGlXSjVnVEZYbjBpVWFwQVUrV1BQbUFrMktGc3RlSUpkNmhZeWxMTXZPS2dL?=
 =?utf-8?B?dTZhOXlpRC84RWV4a001Q2lGcEFIbm1sdk1ZT0hrdUlIMjBQcEw1aWE2YVhO?=
 =?utf-8?Q?5/B6y2C9KS0xNL8hNCcpMUX8L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8280188-3fe4-4dee-8c6c-08dc8aa5e69e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 06:07:12.4852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtYeuVG6P0WVHuD9d8/IIzICeILyEhmjV4KGF28hZ6CnoUHGRqTmsl9yfM9+oxc2kATdhwWfdoL0EAY4fyQd/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655


On 6/12/24 05:50, Dan Williams wrote:
> alucerop@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL initialization by type2 devices requires to use current CXL kernel
>> infrastructure only available to such core code. Type2 devices are by
>> definition owned by specific vendor drivers which need to use part of
>> that infrastructure for initialization.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/pci.c                   |  3 ++-
>>   include/linux/cxlpci.h              |  2 ++
>>   tools/testing/cxl/type2/pci_type2.c | 31 +++++++++++++++++++++++++++++
>>   3 files changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index ccde33ac9c1c..497276302017 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -500,7 +500,7 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>>   	return 0;
>>   }
>>   
>> -static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   			      struct cxl_register_map *map)
>>   {
>>   	int rc;
>> @@ -520,6 +520,7 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   
>>   	return cxl_setup_regs(map);
>>   }
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, CXL);
> Any functionality in cxl_pci that you want to export to a 3rd party CXL
> driver needs to move to drivers/cxl/core/pci.c


OK.


>>   
>>   static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>   {
>> diff --git a/include/linux/cxlpci.h b/include/linux/cxlpci.h
>> index 93992a1c8eec..28fa4861a4f9 100644
>> --- a/include/linux/cxlpci.h
>> +++ b/include/linux/cxlpci.h
>> @@ -130,4 +130,6 @@ void read_cdat_data(struct cxl_port *port);
>>   void cxl_cor_error_detected(struct pci_dev *pdev);
>>   pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>   				    pci_channel_state_t state);
>> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>> +		       struct cxl_register_map *map);
>>   #endif /* __CXL_PCI_H__ */
>> diff --git a/tools/testing/cxl/type2/pci_type2.c b/tools/testing/cxl/type2/pci_type2.c
>> index 863ce7dc28ef..b12f13e676fb 100644
>> --- a/tools/testing/cxl/type2/pci_type2.c
>> +++ b/tools/testing/cxl/type2/pci_type2.c
>> @@ -12,7 +12,9 @@ static int type2_pci_probe(struct pci_dev *pci_dev,
>>   			   const struct pci_device_id *entry)
>>   
>>   {
>> +	struct cxl_register_map map;
>>   	u16 dvsec;
>> +	int rc;
>>   
>>   	dvsec = pci_find_dvsec_capability(pci_dev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
>>   
>> @@ -35,6 +37,35 @@ static int type2_pci_probe(struct pci_dev *pci_dev,
>>   	cxlds->dpa_res = DEFINE_RES_MEM(0, CXL_TYPE2_MEM_SIZE);
>>   	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, CXL_TYPE2_MEM_SIZE, "ram");
>>   
>> +	rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_MEMDEV, &map);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
>> +				&cxlds->reg_map);
>> +	if (rc)
>> +		dev_warn(&pci_dev->dev, "No component registers (%d)\n", rc);
>> +
>> +	rc = cxl_map_component_regs(&cxlds->reg_map, &cxlds->regs.component,
>> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
>> +	if (rc)
>> +		dev_dbg(&pci_dev->dev, "Failed to map RAS capability.\n");
>> +
>> +	pci_info(pci_dev, "requesting resource...");
> Setting aside whether this driver moves forward vs a cxl_test mock, if
> you want the driver to be chatty use pci_dbg() or dev_dbg() not pci_info().
>

It seems this driver will be removed in future versions or probably in a 
new patchset.

Thanks

