Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821D234252B
	for <linux-cxl@vger.kernel.org>; Fri, 27 Feb 2026 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772223479; cv=fail; b=XF8F+WHwHyxa9hp4uZuZAGMrxp+FOFepnnJjTX4Iivy03D5WzW1bkrwjicPNSRaNowBLbZ+trObrK+VHXZpryTaaGkAHpYRloT+oc9x1naap/qvcVjZ2OFl/ayPytY8waZrNdohnu0JeXrX2jMJbACG9ChlxHL9xYI7pGO/6leE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772223479; c=relaxed/simple;
	bh=rdEYlpEnYwM8Mvw1yAmnA6XSmMXuTZiAUmW/rsr5vmg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dttk2x9wKbuww//7e1ziCxF5wi/H/GjvbeXkmHAl5XnGEzXA8kx+bAHTokBQDm/W/BZgHka1exyFXVlj5YMNSwsn8jtKzByGdm4pWxjCSaFl/JrKfbTXyeO2ZYab9vE0fKZqXwI3TCl3gpywwo4+a5WBpcLCxQNfiD7FA+R8VXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t930QpT6; arc=fail smtp.client-ip=40.93.195.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t930QpT6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPo2wEgNLh+VgDk50IFD/qvRuiLESo1Rd4XSliXO1Ns71yCnqqh1vRNUeEhgwktjJ66Frya0eLrK7qrGcYqZXvvUDlGH3kt5QWKLEfu9LfaUHszqt1HnYDECnbXaUaiU5TmgfHoHJ08mpS71KBgUIrBqyge053GBleGF+8LLRIwHbFhiZyPOeIh4Vz3mWoi5iMcrgmz18EFmVDUX4qA6VNsykDxrjsfkLzL7WN2Gzn0e1pjGF4uLGroNyzQKTEKL1/c+Le6fxvuEBJ0xXV1TiOf6OV7Rfx4vMMGywbFvpCp8svwOlUEw7eoTaXmIYl8ahmtj5AKK7rCOdRVk670MqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdEYlpEnYwM8Mvw1yAmnA6XSmMXuTZiAUmW/rsr5vmg=;
 b=x3twR9hM7gKvw9r3i7+ZwmWGm0DbpMCUuwGIuLFXZcgNoUqScjTX40eDYYA2f2L2/xd5b5/NGL5PM+cfmTm5ui+l5B95BslB2oZ9hfESK7ig5b8NAReLP7GduOHFMgdzsWq7JrQZyXzkVz9wGx47EPYgy4pEvrkUYPbF1TAjTcYCZOxIkWtmcALo4KzgwihGVMFq8QDc7Qi5ORDAbVIrvxb/pjk7rhn9hElUBmryFJse4k5HDWRjPogXZmWkgKYDf4in3JT1vt4siOILj7rRMOSLIVhlD1lQvf9ZyuDM/FB+nLDW64GQnXuhB3iRsRfrgqLttEy7r5u+NUnfke52yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdEYlpEnYwM8Mvw1yAmnA6XSmMXuTZiAUmW/rsr5vmg=;
 b=t930QpT6Gx+Wob8y01Ir/Qh9L1d9R7a/k2BoeefHK1Ec4wlarV3infKw/YV6waMSxbRq8B5MmwXkw1hzqgi0b9MRsM9e0Y2yogfuowovZkGPBbKN1wGm084EuvU7KWga2eWg8ozi5T38bQZ6UfilznCGcOJrjPVfPiSdDi65Kfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ5PPF000ACABD1.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::984) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 27 Feb
 2026 20:17:55 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 20:17:55 +0000
Message-ID: <57790ae8-6467-4155-909e-146e44968d83@amd.com>
Date: Fri, 27 Feb 2026 20:17:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cxl/region: Factor out interleave granularity
 setup
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 dave.jiang@intel.com, Gregory Price <gourry@gourry.net>
References: <20260225122223.3841889-1-alejandro.lucero-palau@amd.com>
 <20260225122223.3841889-4-alejandro.lucero-palau@amd.com>
 <20260227132139.00004f18@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260227132139.00004f18@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0130.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ce::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ5PPF000ACABD1:EE_
X-MS-Office365-Filtering-Correlation-Id: b8e5a3f7-1e3f-44a5-5b17-08de763d4aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	L2XLloO0hUejeU9gCv3fJociQdIrEXZCAkI6DUgfjEsY1n7LpoJHbNnVHDPejJhsBgSJuXeDF8J8txdlnmRKaHabvCgT2MKh6YwIWHw5g4w3KksqiXhQmcfPwEPjjXinZY9KJd8mFm3GmRLDCcj0rkzqpz3c6e5RjAJpg4XoitjlfALHE0Cgy5gCEFMUe6KQvc+H4/DxuS+8k4tgzbrQ9N1RxVRSdToIUFVNKHCmpfmCZ5i61/pQ1eEczDr6DRp78xwjDIGr+xWwMLZ3gB071f2ENbquZuGKY63qhweTA7fUwybPNobQPd2jOH3338C4OEpSOx1kArmZ4vVxsBJF5CrvMN52ZZ2H1BK0FdMPAmLkn+fjphhMF5VycWd41rJLprB5q4Cb5eVmvE/Paj24jNi5FsgYAz71XetC8xojUwbiFZNcMEV9iDAUiM1rsWg6gl9MHlNcv5/57faxLdDoazc93oT8MxeDslz5MRhtGszIzdgd/VxZU7YuEpjOCwYimJvIri3mFsZKCv6Gtjc1RG8Im5zqK4QjZQSJ3QW9dFNAy4ld0qa7DKpyo9LPGlCT6s+2Ytq6yIdMD8LLhWe183uCaQEJZ8VvBeuPRThLnKwFpqf3/r6BNoinSQuTGBDIfe2fN1c6nmftZBdch0jC+E6uxsX44cV3VqymAru2sXKss1yi0RFtc9Nz1dxfbXrJVEhGQqVrbLI/JfaPkeKdWJg2Ja7td9Awx8ggTE/a6TY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VS9KeG9vZTRPYXhFemtKRytzb2czRFVLVW5uZ2UxcEJiQ0lESGkrVFhKZmd1?=
 =?utf-8?B?OUZRZU5UMmJjSFcrbmZvQXI3WDRrb2Z0QW1qTEg4Q1N3dzBESFp1V3htK0xi?=
 =?utf-8?B?YmlubnFsaVphdkJmQ2RhREVoSEhoaTJQQUlkZ2V3VjVGcU1zOXFTTVd4dk80?=
 =?utf-8?B?Y3BwcW9zdENtUEdNakMvU2x1V3B1aTRCTTAvMDJjUUNMOVNXcjRYVHdQS3ZO?=
 =?utf-8?B?WG4ycG42cVd1VC9JRTRKRGZwK21oY2NabU0rRURDZ0QzZXpHWE9ibWZvbUsw?=
 =?utf-8?B?eGFrY2hjclhWZTNTeVFHdHpUQTlHbnpvemE5ZUtvbEx6cWZDV3RYUEllS1pm?=
 =?utf-8?B?dG80SHRMYjZjY1VRclNhV0J0ckVCT2FVK3Fya2FzdTEzRDlKdW5ydTg1M3JG?=
 =?utf-8?B?ZkRRZVV2aThoRzcvRXpUWjdjMTc0dnRzK1l2aVhjdURNVUgzWnlRQkY4RkZU?=
 =?utf-8?B?S1kwZ3lDSUNONXlyVmlia2ZUWEpKb3A2OVNmR0RoZmRDUFloK0xETWROazdk?=
 =?utf-8?B?anhwV3lrcVdBMlpHeHNzTFk0UG5HeDM2S1N5NzZCWmNwYS9iekRRWjNnNlVG?=
 =?utf-8?B?Y3Qvak03SnluZzJ1ZUZ0aml0d3BvTVlNbzdaL3JLeEN4VCtuOXVWZ2trSlRZ?=
 =?utf-8?B?bll6UjYzMCtBR21KTmRqdVZVWFN0Y0FORDVjQjFjaHptelVNbkttTFN2clgw?=
 =?utf-8?B?S21Cb0k0Tjk5YjY3SEYvU0RJWmhFTDBZS0J4enZ4aHRkYWUwN0RvdTQwRUNj?=
 =?utf-8?B?eGo0NGhISENvbyttK1E2djQ5UldMYkEzdHdlSnF4Zmt1YlMybEhuaVQwTWhT?=
 =?utf-8?B?WGxzR0hmSTZDQkFuV3JuNjFqZERqbUx0Rmh0TXlhL091QS9nQXRSU0t5Z1RE?=
 =?utf-8?B?RlZXUlhYdGE5ZzVadTdQcXJGV2F6WU5RSFZ0dmVrZWpYSzFiZFZtOURzNlpr?=
 =?utf-8?B?UUdqSFMwREdGYkRwMFhQcDZhanUybE1GUGYwZ1VndzZXODdNMWRXSGRJOWhk?=
 =?utf-8?B?eENhNG5ESXZmN2hBWVIrbjM3R2Y5TUY5WVVvK3FIL0NvVitRNENsbzIzeVFk?=
 =?utf-8?B?ZEMybGZlSEVkYnBPRzhNUjZiMmVtTHNEUkN5S0QraXJoWjA5bkZLc3dZVTJz?=
 =?utf-8?B?Q1NRVVFkdjg1V2VhL1FXeVVuSHBLeGFVYVNpZEcyZlhJR1ExQlRmQ3ZWSjMw?=
 =?utf-8?B?cWdTWkNPMVdMbDl6QU1Objc2R0tnR1JkUnJxWE91Q2J4T2Nkc3l3VzhKSVln?=
 =?utf-8?B?NHJtNDh6aHU1K0FFTmJPOVVnTWlCMThaZ0VxUnRoVzNseFN6R3VSd2NHL2lJ?=
 =?utf-8?B?Wmg1cUppM1dTeXp6Y28zbnZIOXJ4NCtacUxKeEVldW1WajZLVmV6dzZnQzZC?=
 =?utf-8?B?d2M3NzNVOVI1eS9GRVFXdDA5Yzl6amNqdEJMbFA5dVBmTThOWDQxY1plem5B?=
 =?utf-8?B?djRZWEZSaDdHWWlzdWZERFpiTlVoUWZqZDNzNUJ5OWVYWG5ZQlEvNUEzY0xT?=
 =?utf-8?B?eFFJdldndjBrTW5NdlRHallESGFZYXowemFWWldCRG1mZnl6YlMzRGU1YWRC?=
 =?utf-8?B?N3dRenY0OGVmUUMxdWV5YWhtL1hkakE4ZTEza0tKaWRyS3h3NkJRL3pmUmRm?=
 =?utf-8?B?c0VnUjhDTmdpRjR6M21wMkxhdktSTkgvdnNuekVuZGw0dXRkOEhmdjgwaVpw?=
 =?utf-8?B?ZUFWQzgyamZMSXVFbytlRjl4YVQ4S05LaTBIZTlNVDA3R0xVOWFTTm5KMGsw?=
 =?utf-8?B?YVBvR2JIQ3ljR1FSRWlSeTgvOWQ3NldKYUZBL1BCTFY3aFl5bVlPaDdhZHBX?=
 =?utf-8?B?cnNIT1d1NlJKUDQ5WURZcDRtUW05OVpjWWc5VUowZjBKYTNIL3ZURTRORml4?=
 =?utf-8?B?b3ZEZThpTjdmaTJvYXVsaEtRSE40bm56M056Y0ZRMU8wVlBpbWg0NDI4eDZ0?=
 =?utf-8?B?MnJ1YWg0MXN6cURjTFlrTU5NczFyY3FWd0ZrOWtwdnpFVjhPZkIwRElwS08x?=
 =?utf-8?B?U3pDZlJKVDY5S3RRS0hnL0RtNXdVRTd1NGQ3Skp1NXdJTE1tQ2VMaStFbC9n?=
 =?utf-8?B?c2N0VXJzOVhDNGR6Skk2cGtQdVcrbm1RMnQrZXhSc3Vxc0ZjbFZ6cTF1L2JR?=
 =?utf-8?B?OHdMOVNWazRVbDQrOWJ0Y05heVovb0NYMXlRVndYVzl3YmtSM05iQlY2S3Zr?=
 =?utf-8?B?Sm1WS3AzYUs0a2VoQkp6NjNCMUhnNVRjaSt3SVJaNmpuUllldHpRY1JIVENH?=
 =?utf-8?B?dHVac3FxUlRJZDkxbjZ5WjEzdmpQVUxiZHpMRDJUa1RKV3dpcU5nM1UzM2VK?=
 =?utf-8?B?Zis2cU1nYkVnZFJvS05Tc0xQVTZGai9VekRKUzJRc041NHlQMExMUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e5a3f7-1e3f-44a5-5b17-08de763d4aba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 20:17:55.4657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Yz2h9lnZkBEV+GYYyKOf36TnjXqe1A33qDlNf6FJslYqrrHV2smmvQOFjoN/GvknMX5A/D+CNSvWB3J3wWPsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF000ACABD1


On 2/27/26 13:21, Jonathan Cameron wrote:
> On Wed, 25 Feb 2026 12:22:23 +0000
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation based on Type3 devices can be triggered from user space
>> allowing memory combination through interleaving.
>>
>> In preparation for kernel driven region creation, that is Type2 drivers
>> triggering region creation backed with its advertised CXL memory, factor
>> out a common helper from the user-sysfs region setup forinterleave
> for interleave


I'll fix it.


Thanks!


>
>> granularity.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Gregory Price <gourry@gourry.net>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Tested-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
