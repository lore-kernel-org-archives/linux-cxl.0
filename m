Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76124C66
	for <linux-cxl@vger.kernel.org>; Mon, 20 May 2024 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220015; cv=fail; b=B6ZFsFCY4BzyyG4i1t4V5KEUbaSY/It2Ve1xcMckQLvFerclvQTov9t3ht89ycZEVkkyaThGSCBnoT2Fz1274K7OIOv1lm25N7bXGrawB6Tzl032DhDKSY/Ovy1nY/fK6zwq/OXvPE8GsAuFovuVVmzOm28i36Fcd5zMlAztMao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220015; c=relaxed/simple;
	bh=Uwv8iSc9ZwoBNyLutwkxC6lr8CZDLPL0Y8BQy7QfXII=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SH7MfxgaqXoJrVWtOkFvkVhMQCozbN3v0912ancpnvAH26aPzHKQCjCIwRXbgetq58bq1o52T3Lbo6JrRL2aYsXNZgIFHxPMMSUSnpOy/0fJtY5Oc4Z73zsNJ2T2t6xL9bKAjnyUGbUhVnnyO8BHdWFlQL+qsxRp+77LQiju9ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XWipvi82; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XWipvi82"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klPYmo67800th5zTpqEhe8h4dxVa+WjK2Ps4P+Aemg43gvR8V0GvQcJeitKTMSP4q86/lKubvAeKzDZusPdj9oGSlOUPIvKXgTnRVEXiLZex1ht729u9rPAujSE78bFQyVnTtZK40fAZRlv9vInbRlYImLUm54UEPQQF5qdtxaxgSZ+A5ToOhmtrNHksk/GmULaMJ/1xTBnQZGzIR7v8SfkCcCRlfPH0ban6N2dnsdkdKNSIkm69DtHzQk3WMLK3DCHMHzVZbxvlNRxafByWEZeb1EQFpzNSZdLzJCfd8sq4q/VkHswxs8isgbm/M7p9cNW2Hq3nK4HSI6Y92AkfKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsnTPOWT1mUnZ46PzA6HPdFsE1+64A7ebG9l/93yCxQ=;
 b=hWZBVk0LF9eXr/0N7wNmfNyE71+QRVAbySUHQ/Twn6DGhM6AgYYhg3mzjqO6Y3Y5hlT8oNkFJg2o3lyRLs/MN4kJAsKDSwEUIV1FJjK05qNj447VtqQhuXogSKBZsqXp5R894zFJrg7pLmax4kI+PI/OQEHVWGOnT+jwDcWvfRblcRN9QSKLgBXsw4B5fAMi2IiDvKZxoiHMOugGEzirNvGiXqfIpuprBT2ICT9PqCuBPNLI+LZ/jJXOQp4RQNa+6KxyE/SyXnh614MyI/ucasZtp/IoWVnvjQ0Wyk1K0lSZPNVckIglUa1eefTSQGD76OKSHHeAFiR/8Q/JtpmpGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsnTPOWT1mUnZ46PzA6HPdFsE1+64A7ebG9l/93yCxQ=;
 b=XWipvi82hUCz7fw6Nry7wTBRk/O0Ffh2VPZzZCrxnGigtljtG1i+DcA4UwmBCyqBlJSR0cUkspg1z7PMzEnCpBt1u0FTBePckpq9E4mS4MW5K6PmV0tL5abRE/kaW4vj+frLTXBmbplmE0HHi+IGAlOHnL2lfrFnYoD6URqhHko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB9455.namprd12.prod.outlook.com (2603:10b6:610:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Mon, 20 May
 2024 15:46:51 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 15:46:51 +0000
Message-ID: <ad74c6c7-749b-4fa8-f0d9-94aaf07f4754@amd.com>
Date: Mon, 20 May 2024 16:46:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 02/13] cxl: add type2 device basic support
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 pieter.jansen-van-vuuren@amd.com, richard.hughes@amd.com,
 dinan.gunawardena@amd.com
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-3-alucerop@amd.com>
 <20240517153048.0000480f@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240517153048.0000480f@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0037.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::9) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB9455:EE_
X-MS-Office365-Filtering-Correlation-Id: 817a9696-ca74-4bb4-077a-08dc78e410f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3JLeGpiZEdJM05MVWFUVVlTL1VBODNmYzJyY3ZCb3lvc1pXeVBCQVFSSmxP?=
 =?utf-8?B?K2RJaldDOWREUEQ5aHM2eUdvUXdGMW5jeVNEbFV2RTZxMGlBcUl3VzRJNWpP?=
 =?utf-8?B?b2FYcFFQV05odUt4TEVPd1F2NmQraStMYSs2ZWtQVkh4cGJ2OEJINWtZZzlv?=
 =?utf-8?B?YTNrU2ZlaTZDalBLWWQzWWg5Ky9Yb0RjUnFtZXZkMCtKN1A3ZXQxd0FsTFNQ?=
 =?utf-8?B?OUR4TzJRYXk3VktKTHJHZXRndXl4L2ZmaGIrN2E3UkU2UDJSL3Y1THpzSm1t?=
 =?utf-8?B?UU9kRnI5NlpRZ1Z5MlNaaXpPNXVxUUQwcVVvSWJ2SzVxMU5FdW9yZk1Cb2ov?=
 =?utf-8?B?QVlpZTVmSDFRcXQ5cVZENThmdnhzZmliMVVVMmM0ZnY1Ykt4VTB4bm8rUnFR?=
 =?utf-8?B?RVlpc2hpV2Fna0EwVCttR3lvcXBHWWd0b0RFWTVkaGMxUGJwdGpUeGJFb0ds?=
 =?utf-8?B?ajBRVkdQb05kQ0x1SFJDMVBnTGUwWnpsUFM4aHNTeXE0d01yZHVLeGcwbXY4?=
 =?utf-8?B?NlFTS3RrY0dkYnAyZlZSQlJBVHFXTEhxdWZza3pYaVd5VEkrUWZLNlhDa3R4?=
 =?utf-8?B?aE5WWXFPWHNySk0xQ1ZqaWRWMnhGS0ovTEJta0JXSE92dS9FVkZDQ3g3Zm45?=
 =?utf-8?B?aUlxU2t0K2w1bU1HOE5oc3RqL0tzNmphaVFtWHpJbkN2NHpiaHBKQWxRL1Br?=
 =?utf-8?B?YnFTWUtRUWMxR0ozUDJNU0J2OEo1VU94N0NKcEhWeFVCcjlUc05QcStMRUdk?=
 =?utf-8?B?MmZHWUJhekJPVStBWmc1ZmFkOGo3RkJXQUY2L3llT0J3SlZzWUJBb0F1aE5p?=
 =?utf-8?B?dFZtTDRzMUtqQThGQzN4V0Y3OTRna0ZFQUhWZ1ovZFkxZXEyUCtXUHJURXEz?=
 =?utf-8?B?Mmw0bVJwZnJzREhkRmFrdDYxR1dWSjVFOXdHTTBkbU5aWTFjdm4vMVNleWhB?=
 =?utf-8?B?NnJQaWhQSE5pTXdqZzJVeE13UG5ncUNUNU5UM1FnWUJoMEhKbUljMWxGUzdS?=
 =?utf-8?B?ZUNoK01DaVljeEhob1RIRXFEWjdKZHpySzJkSngzb1A4UGovZmtwODNQMkFX?=
 =?utf-8?B?S043RFlOTVhCdEZlSisvNi9uVWNvV0tPYUJsc0R3Wmp1QjF3ejIrS25jUUU3?=
 =?utf-8?B?SDM3K2RoYlN4Qmk5SjJZVUhKMnhyeWNTdlBrL0Jka25Ydzg3ejNReHNnY1E2?=
 =?utf-8?B?M1R2d0pEOXlGbzRoTUlRT0FmNEdVRFJhR2k5bXZpSW5Da0ErbThYY2NsYWZP?=
 =?utf-8?B?MGk3aDJ2V1Y0ZURFV0c1L3M1T3ltczZiSVJhMGh6RzRvbnNGOGI3OG56Mi9z?=
 =?utf-8?B?S1VKcTR3Yk5zZ1UzUUNKVWxuZTNIU0lJWk1xNnIvOUk3YVp6dHF3T0pHdlRt?=
 =?utf-8?B?TnA3NWJjZmNmdzBTNUg0Zjdka2E1a3ZMWHU3NXJEL01Db3J6dGQ2TUlwMEtw?=
 =?utf-8?B?YnVtb2ZRbDBGRkdJWXI4Q2l6MkpvSGk0SEI2M0FvaDdVb0czMXZaWk5NN1hw?=
 =?utf-8?B?MjEzM2E4U0w4cW9jTXRKWS95eWFERlF2S21kUEphbUY4eFVhK2g2RW1sSTg5?=
 =?utf-8?B?VG9Kdk1TdGIxU2tOaTN0TkU5M0RDa0x0aGZ4cnZsZm5tODhRT0lLM3FISWtk?=
 =?utf-8?B?TFpUaU9ud01WR0ErdDdHbTVDUG5YNWh0dm1hMG41QjBzS1lNNC9wQndUb2dO?=
 =?utf-8?B?MlNCeXFneDlYQ2l3YURVWVlTY2dlMURqZTlMTWJ3U3hMTUpXTHB6d3VRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZCtRczlxRmFvREh1QkVWdUtWNVozN2ZKT1NyanFsUE41bTJEVkYzWFNwNWlm?=
 =?utf-8?B?SkFBNitxOTJEWWdMMUVsSFlwTmRlUnZjRXJ6cFcwL1Nab3o2Sk0zNUVkcVYw?=
 =?utf-8?B?dVpYUzhmYlNDZ2dGcmw1V0JpS3pnalo0bDJ3OGVsOGs3MUEramJCdVRvMmVS?=
 =?utf-8?B?Wk5QTlEwcmJCRDd0d1ZPamdCS3ZldGlZbnpuWjlCV0E2aFFackd6bDREbGw1?=
 =?utf-8?B?SHBRdEliTFpsZ1UvSEZDV3BiQW51Q2VNeGFIVEtETVNseHpHQ0VFMEVKTmVy?=
 =?utf-8?B?eVlCSE55T081aVpxMXBkQmovZ2pZUWM2OG5LYzhFOU96Lzl3dlh3UkdvY09Z?=
 =?utf-8?B?b3RJS1I4VVFDOE5sMW1nWk95M0tDMC8yMkJHWnFLVlBmbmVLZ0xNVUM5VTgv?=
 =?utf-8?B?ZkNIakhwdjlkZlR1SmlQUlBENWhWRyt3V3dWNGxtQXFZYzMyL2NMZjdodFBH?=
 =?utf-8?B?cnFHcU1TSkNjY0loMGU4Mm9nQ09ndzlMS2VGYVE5K21jdUN5bmo1NWxka2wx?=
 =?utf-8?B?YkJnZzJDWHNUSkJJcU9uTmlJZzM5OEt2RUJFNjIxQ2liWHhncVFEUVRKYml6?=
 =?utf-8?B?d1ZpTjZLbXFVaUlUU25TamFybVUzQVlTam9YZGl0djVLN01MOEhsZXlsY3VK?=
 =?utf-8?B?NHBQMlh5Z1F2VWFuYm5ZSUE1WmlzcHZGaUIxeXgrMnhjNjIrMTdmU0ZvV0xy?=
 =?utf-8?B?U09sdWhuYUI1RW1SWDdvRjFyRXI3ZVIvbFZlT1BqMW5Dcm02UFdmRkFGY09D?=
 =?utf-8?B?cGFsNnEzSEt2L21pTVhQVWdmNnozbENjSlhwZmVLZjdpMHF5TG1jb09rVXND?=
 =?utf-8?B?aGdOU1hjS3UwTUdmV3V0QXdqRFpja29SWVR5ZHVOS3JRZUpxaDMwd0krT3pJ?=
 =?utf-8?B?Mk1ORmFrUlNURHlVdndMeU1nblpEblFTQ2dkWFdDUW9XblNCUy9USlRQUjZk?=
 =?utf-8?B?K3VsczBlUm5tTDNoRUNXWWFNTlRTaFVyeEFCVzVxSG9yQXA1MDV2VXo1M0sz?=
 =?utf-8?B?SkxsNDZmNFY3NXlTN3JnS0JrZC9DT0ZGMFdQZVNlZ01EZ1p0dGZLN0V3UG1I?=
 =?utf-8?B?YUFOOS8yRzhybm84N2JBK05uRmFockRReW5UcHFhL1VQKzN4RDNjZXlUYndD?=
 =?utf-8?B?ZFV4VVlTTitOU2pZamswZjVRSXZ1S3M0YXNTWGtPK1hHcnU0aEhjQXRZSWpL?=
 =?utf-8?B?OWhhNFhXemg0WHFnSjMxVW5xU1JoVVR0MW1pT2RvOUhPdFdlNTdTZ1VrR0Fp?=
 =?utf-8?B?VG1VNGg0Mnp1bEdIYWc3YzdVRklIL3NpaGQ2VElWSFNJU2d2dDhmMmZKcitY?=
 =?utf-8?B?bnI1cFpDZVRWdjAzcWpqam8yY056OGRVSk1NaTdhK1dSempES0VhdnJvOTRl?=
 =?utf-8?B?N2NXaXhpeEwyMllVdm1pdVNwYVJQRk9FTnZGemFHdFNTYlk4eVdQL0xiaDFQ?=
 =?utf-8?B?MHByVnVVZ2dvSjEwSkR2U1pZb3RpMmpwVjU4bDQrYzcyY2NIRDlMYml0SUtr?=
 =?utf-8?B?bmQrTURxbnp3UmhZZ0ZmTmNWWmRIVGFaSnhrZ053U2czWjdLU0w1MUlKc0FB?=
 =?utf-8?B?aXdHckpHeGk5YkljaVZTajh6YStEbElhQWk5MGwvWDVUb2R4a3pDV2tVM3Fu?=
 =?utf-8?B?RXBhOVllQnNTdTc5cHhFcnpVcnFjbFd5UmQzNVlPQkZJZHFjOHZ6dkdzK0JB?=
 =?utf-8?B?ODc4dFR6akU1OWNKYU5WNk5TTEJZZXFHY3o0ZTJpR1Q4MDhCeld0SmU5MEJr?=
 =?utf-8?B?NlBFWkVhbjkrKzhuUytxN01RMnlNcWZXdDBFSVg2QktmMkIyYjFleVBIUDRB?=
 =?utf-8?B?dExNSDVVS1M2ZkkrZHFxeXZXMEdEUnZDcC94a1hjZzY5eUcwZ25vVWJSZFlZ?=
 =?utf-8?B?N0lRRDFqd0lCVmROM0cycGU5UXdhYUQzdFhUeUxsVkhEblBYSVIzTTBPRmRB?=
 =?utf-8?B?bGxEZ1pRbGYzSGp5ZDJURkYrb0gxdjhGa3dpaTZyR0dybUIxTFJSRVhWcGZq?=
 =?utf-8?B?V2RyOVpObTRHM3VueVo4dzJrY0dlcFUwOWR2K1VoZC9ueUhYd1hhZEVSbW00?=
 =?utf-8?B?NDBLNURwSTNBU0x6M1dhbVZUQ1k1NnVWdE1OenRJTzZ3V2NNcmlQVFFXVStl?=
 =?utf-8?Q?p33WuXfTMTn+tAnXJ8SfdUkxH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817a9696-ca74-4bb4-077a-08dc78e410f7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 15:46:51.4357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onq2mOQWju0+B3QNqKAocH7tlGnV53xdPXy7tu06oJCEJW9v4z421trgwMkqDwwwEg4UbhF/qB7K2j4cPKkHdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9455


On 5/17/24 15:30, Jonathan Cameron wrote:
> On Thu, 16 May 2024 09:11:51 +0100
> <alucerop@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differientiating Type3, aka memory expanders, from Type2, aka device
>> accelerators, with a new function for initializing cxl_dev_state.
>>
>> Adding a type2 driver for a CXL emulated device inside CXL kernel
>> testing infrastructure as a client for the functionality added.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> If you are going to keep Dan's sign-off it needs to be clear why.
> Either put the author to Dan and swap these two, or use a
> Co-developed tag.


Yes, Dan commented on this an he prefers the co-developed flag, so I'll 
change to that.


> A few drive my trivial comments.
>
>> diff --git a/tools/testing/cxl/type2/pci_type2.c b/tools/testing/cxl/type2/pci_type2.c
>> new file mode 100644
>> index 000000000000..863ce7dc28ef
>> --- /dev/null
>> +++ b/tools/testing/cxl/type2/pci_type2.c
>> @@ -0,0 +1,80 @@
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/cxl.h>
>> +#include <linux/cxlpci.h>
>> +#include <linux/cxlmem.h>
>> +
>> +struct cxl_dev_state *cxlds;
>> +
>> +#define CXL_TYPE2_MEM_SIZE   (1024*1024*256)
>> +
>> +static int type2_pci_probe(struct pci_dev *pci_dev,
>> +			   const struct pci_device_id *entry)
>> +
>> +{
>> +	u16 dvsec;
>> +
>> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
> Add a line break somewhere in there as no real reason it needs to be all in eonline.


Sure.


>> +
> Trivial: Drop this blank line to keep error check associated with the call.


OK


>> +	if (!dvsec) {
>> +		pci_info(pci_dev, "No CXL capability (vendor: %x\n", pci_dev->vendor);
>> +		return 0;
> Returned, so no point in the else.


Right.


>> +	} else {
>> +		pci_info(pci_dev, "CXL CXL_DVSEC_PCIE_DEVICE capability found");
>> +	}
>> +
>> +	cxlds = cxl_accel_state_create(&pci_dev->dev);
>> +	if (IS_ERR(cxlds))
>> +		return PTR_ERR(cxlds);
>> +
>> +	pci_info(pci_dev, "Initializing cxlds...");
>> +	cxlds->cxl_dvsec = dvsec;
>> +	cxlds->serial = pci_dev->dev.id;
>> +
>> +	/* Should not this be based on DVSEC range size registers */
>> +	cxlds->dpa_res = DEFINE_RES_MEM(0, CXL_TYPE2_MEM_SIZE);
>> +	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, CXL_TYPE2_MEM_SIZE, "ram");
>> +
>> +	return 0;
>> +}
>> +
>> +static void type2_pci_remove(struct pci_dev *pci_dev)
>> +{
>> +
>> +}
>> +
>> +/* PCI device ID table */
>> +static const struct pci_device_id type2_pci_table[] = {
>> +	{PCI_DEVICE(PCI_VENDOR_ID_AMD, 0xbabe)},
>> +	{0}                     /* end of list */
> {} is more common.


OK


>> +};
>> +
>> +static struct pci_driver type2_pci_driver = {
>> +	.name           = KBUILD_MODNAME,
>> +	.id_table       = type2_pci_table,
>> +	.probe          = type2_pci_probe,
>> +	.remove         = type2_pci_remove,
> Add remove only when it does something.


OK


>> +};
>> +
>> +static int __init type2_cxl_init(void)
>> +{
>> +	int rc;
>> +
>> +	rc = pci_register_driver(&type2_pci_driver);
>> +
>> +	return rc;
>> +}
>> +
>> +static void __exit type2_cxl_exit(void)
>> +{
>> +	pci_unregister_driver(&type2_pci_driver);
> Unless you are adding more in here later in the series there is a macro
> to cover all this. module_pci_driver()
>

I did not know about it. I'll use it.


Thanks


>> +}
>> +
>> +module_init(type2_cxl_init);
>> +module_exit(type2_cxl_exit);
>> +
>> +MODULE_AUTHOR("Alejadro Lucero <alucerop@amd.com>");
>> +MODULE_DESCRIPTION("CXL Type2 device support, driver test");
>> +MODULE_LICENSE("GPL");
>> +MODULE_IMPORT_NS(CXL);
>> +MODULE_DEVICE_TABLE(pci, type2_pci_table);
