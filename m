Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013052.outbound.protection.outlook.com [40.107.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041F62F5485;
	Thu, 19 Feb 2026 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771491324; cv=fail; b=HArpqCtWC0tIIoFFVo1414HqRfIUillPrRg2KTvxMTl9xsJgkMrw+GrQ1UUZcnT7aDIzdNn0Yrl1FH8qM9vRFo3VPlb5Rpu3y2CJVsHrdbe9n3s3ZM0oVBHbXrJiEwOoCNNIH4r0sxU2CGIWhlKRE8IIqqdv3naCYpg2wLSkwh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771491324; c=relaxed/simple;
	bh=FUYouPFJHMDD8pdkvB7e5l/TXEcOo6OcMJL5/SdRM5E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cWUq5nWoCO/T233l4A+jMCc3iEjGH+UhIfsNer+Y2G/pgdsIgBp92e08pgIRs1R8+UN/kr9TESoqfenzWMpVi7nOx8ccov96GzQwYKFFdNd1Jzj6ZE+6B5f0HDh1Xy33Zozn5SX3k47PrR4iG1ez/HvbQF8T/Ne6AGNwhsfajn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kwflHZcu; arc=fail smtp.client-ip=40.107.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kwflHZcu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Puv7Dci0SDVcZ2YBto6uvqSVyMqmOtG8AOtQ1UijR2oEN3oB6ZP39JrD6xUTUl9SvG6otGPyplZeh0mtHW/VvRzPHEPktJDt4i7aK7DDminatvXSW0ZS1wyMtD+KVwp8d/EWt/yzz0qraF+RAHb6x+4lKTIs+xG13AO1Q9fN5qJskkV4OI8eXabj3XETqzQbbe7IUp+SzkdMqf6DW47fyvTSDUMqEfF0R7tzH+vVsLgonRL6qhoImcNF0gCnYHdx7gnhlDZqsVGLU8kGKab7amTGN7Pa5NXAz1RFX21vka4hGgkFu650+l3qPD+g5TmNq7rEshMq2X4VZDsH6TcGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJhgqlmyf3S1o6idRPB4aShsv64SNm8EY4FKgJi4YRQ=;
 b=u6A9TVRdmBF38JidGSYC+GeUxekwtYA0MkxdP7fEiY4tfIM2dTFgr4Z/8MYS8Nnm7TdIM9AvAut6x14yBraHaEr4aDabxuh5WnXZUw8rwxn4vAM91fMRgmRQ4XZ81tLB7dcpPpjE6f67axHj4DSiK6XnA73+9bjO/5eijxN5jw/xvDWfjJUBM2xtqHvm9HTm/sHMAIOdKTYD1IzTtYklCBXy5OGp7J2bQsge94qzLdbAq2Xl6eC7OY0RR3OlYrlsOTsaJBVZAqXKBipn6kPKtFsSdL/gomwpuZ/S3YxqGkf6Z+sjtygWfV8VUnv7ngZdLJcsrG8RInM+9q0ras9LOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJhgqlmyf3S1o6idRPB4aShsv64SNm8EY4FKgJi4YRQ=;
 b=kwflHZcu56yQXKK+nMDgf2KUeJ1D3pOk6YGm18bAoKmcVkHSzzMSGeTgDAbycmP2oQsBMoiuZs/bY8bgzzTYLRCpbzZG6z+QpBvh2gWjahNGuuEoklKDzKy+pZovIe9nthH75cJzlcNqrtClOCyWOvvVUKmAan5+bua11EzXaCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 08:55:20 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 08:55:20 +0000
Message-ID: <03897df1-5fad-49d1-bc37-3bc55912cc6b@amd.com>
Date: Thu, 19 Feb 2026 08:55:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 11/22] sfc: obtain decoder and region if committed by
 firmware
Content-Language: en-US
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-12-alejandro.lucero-palau@amd.com>
 <e98da3a2-bb86-4dc2-81e1-7120c4268a07@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <e98da3a2-bb86-4dc2-81e1-7120c4268a07@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: 282e1ed9-892f-4451-a18a-08de6f949c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekhheURZc1JoN2pvMytqUURwR2pGSXUzZHN2aUNxTWswQ2ZUU2pyUzVrZkdj?=
 =?utf-8?B?bTUxVWNxaFU0bTIyWGt4WFBSdHM1UWNMWjhySDZCVCtvaFkwYUVPcWtJQkl4?=
 =?utf-8?B?cFlwamVpaloraDdYaEdneFRnZDhvV1dmOFluZlhOMW1CclZVUzlFbTg3TlZV?=
 =?utf-8?B?RHpJUEh6eEQzcWE5SjlXMmVqR0cwZThBa2p6MnE3ZkFIRW9Lb2Qwb1ptZW8x?=
 =?utf-8?B?bEQwbzRNdVF3R2JmOG1pNzZyUDBBazJiTTJBWkNMb2QwV2FrOHZhNEMrUTlm?=
 =?utf-8?B?WHlha1RFdXl3bjhVSFFEZjYvdUxUSDEwVlE4SG1VbDdMV1N3ZkVBZ1ovMHhT?=
 =?utf-8?B?SktGaDEzajc2bnJ5MTQ1anNJdVJkbmM1YXVoVGRSTFVsb2x3bHJsN0FNbWxi?=
 =?utf-8?B?QUsyRmkrSEFnSElnZXF6eS9vNHRjTmdFTy9RZGZrbTY1SGlWRndudzYyV3Ey?=
 =?utf-8?B?V0xBNzN4bUJTWElsVWJUcDlObk1ncG4vUmQ3aUtsY1dwSEppQzR0WmdGdW14?=
 =?utf-8?B?ZDRQa0V3cXdYQ1hPTTF1c0dJSW1aTkNvUFI1QW1oaHNvWTRLbzNtRVUzRi8y?=
 =?utf-8?B?T1dWNy80ZUVxb0orQjljSXQxOTh6WXZoQXZua2dFa0JOeHJJck0rSEpXRWJh?=
 =?utf-8?B?MG1DVHRuQUNZNzFITUk2S290TjllK0lacmhwdUp6V0ZTeXFBM2R1bFBqeGIw?=
 =?utf-8?B?Tnd6REt0L0Y1enR4SjZmQU1SbzZtOERlZ1ZtRUUvdkdCT0tZMHBUbmY2c0FU?=
 =?utf-8?B?bTNtT1hVQTJ6c2JXWmZBd2ljZ0swNE1XSzJjNE96VHF2MzRKdjYyVFVnQ09H?=
 =?utf-8?B?TjY2VkRRc2IreVl2amhTd1d6YjUwc2hBMGJESnZkVDFpR2IzMXRzTDhtNGpY?=
 =?utf-8?B?T2JzdGZ6SDFEdGdyWXMvQWh6cXhic2lZOEtLRUd3b25FMUF6R0JwT0p0R3BR?=
 =?utf-8?B?eE9oaGgyTGplTzEya2o4UzNMd2F2ekpyL1h5ODhVRzU3cFlTNWJHY2syK3ZC?=
 =?utf-8?B?SDNrbEg1M0VWVEtCZjZXdVdoZjhseDI2TWQ2bWI2c3dJMElhbGI2Q2NlZ3Rz?=
 =?utf-8?B?cmFEc2lQZUxRZUlONjlOcHlGVDlQaXNsVG5GWW05TjB5NmovbXZXZHRhVGhB?=
 =?utf-8?B?YjhlLzBKK1M0QUZrU0dxTkxhU2E3ZXFKL3hWWEtwaWljS1pSQjNWY2ltSmRw?=
 =?utf-8?B?aGhEekl3aWJIb0hReUtzQWVmOHg3dFhsZTFLNU9xZXFKVHpweWJPdDhaVlJF?=
 =?utf-8?B?UWZGdFVJOFkrUWxPVytuTG1wM0ZJTDZQTUQ4NGU2ZDJSeElnQlo2cTlhY1pq?=
 =?utf-8?B?cjJJc1NHR1hTU1NQVkI0MXVHeUJWcUJkMlZRc3VJQUdRN0lLZk1RM20xamw2?=
 =?utf-8?B?MU9mWEJoOE5MR1N3ZWFaT1BobnZ6cVRYaDN3Z2ZkNDQ0Q0lDS3R3SUU2Zmxr?=
 =?utf-8?B?Wk1MSHZmMUQ0RGI5WkNtSEZZK3NkbU1HWWM1ZElTSU9SUjZLM2hsWUpUb0Y4?=
 =?utf-8?B?M0tIWGYyYVAwZno1TUZLWEM4WDFMODhJUzh5R3kyblFhUmJ5bTZ2VUlsK3Qy?=
 =?utf-8?B?TnFGNVpEZEcvOXdYZTVRZUFhaTBsNHo5UFg2YXh1U1ZRaWJ1c1FSOHZML2Q5?=
 =?utf-8?B?K3R3b2k1NmFJT21QdTAyaHhLN2M0Z2c0VHcwWFNUaDYvb3BhSG52bFpEaUdU?=
 =?utf-8?B?YUJtNEUrcUFreEFxeGJqaitoMUlvMUNqRGtlSDhBTlR1eXl2SXhCMDRCN0xX?=
 =?utf-8?B?QUYxNUUwdDZsbHkyb0lZTVFld3M0NXV2a0Q2RXA0RFJ3dnNidGQ4L1UrS0ZS?=
 =?utf-8?B?K1NVd1gvamhvaGxacWJkZGkzMVFIMC9EdXdmbW9SS2lIeldaTFlXbXRwcCt1?=
 =?utf-8?B?ek1yLzhQZjhoY2pvUld4WHh3U1JtU2dtRlNwZlpRYkdXLzZjTHE1Uk9CNDg0?=
 =?utf-8?B?MFkyUERvWkVQYW5YazJscGd0aWZINXIyOGVXcld2bE45OTRtYXZVV1l1V3Uy?=
 =?utf-8?B?TENDQVloQmxiYVFmendkOUFWelZCL0JDcjNRdU5YVjlLWk5QTlBDNHdTUHFa?=
 =?utf-8?B?UmlTUTc3d2N6SjJxZ3ZCYlo5bEN4TW8rQk9vd2NoMzhHbUJKd0ZIYmlQZ3lw?=
 =?utf-8?Q?g56A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmdsemVaWmN5RTh0d3R1TS9EMERpR1JIUTg2eElER3Vvckp3WDJURzE3ODBm?=
 =?utf-8?B?L3FJODRDMFE4ZXV1a2sxVlU2aWlRYzVWY1kzenFqZ0taT2drSEVzK1dtQ0J5?=
 =?utf-8?B?emJibHUyckpBdUtxYlBDSE9vWFdwR1J6OHg3NkllRWdhQjF6K0dPajE2elRS?=
 =?utf-8?B?NzJVRittR01WWFFFTkNOWDNOUmVxZURCRzBGbHNFWktjUEFTa2h5MjVtYVhN?=
 =?utf-8?B?TEJGa3dZcVEzZFplTkJ3eHg0WnhSVEliWFlOZTEweXMrRjdITUVueG4wVHNR?=
 =?utf-8?B?UGxIbmxLZzJZWkhBV1ZzWlhML3U4bW1BUU9lZDNGZC95VkdvYlRFdUMzSHY2?=
 =?utf-8?B?U1kwOXMwSW1GY3h0QXB3czhvSE5kK1VBaVhiejRRTkIzS3ljZ1NKd2lZVkVy?=
 =?utf-8?B?U2t3UHFaKzA3YXY3OG5abWZhUklhMmxPeW50RitvVTc0SnlPUkwrR2pHandv?=
 =?utf-8?B?M1ZESHJ1NXpKbS9USEtEUWdJZEIwMUJOQzRTSmRJeVI5cDQzVGhia1YyYlo1?=
 =?utf-8?B?bXE0eE1SV00wTEtCZi9mcEdjM2FKaU94cmVqOHFUTkJTYm1jalc4cEdsZnI3?=
 =?utf-8?B?aFU4MHc3UGtuVjhUNHYxYXAyVGMxOHhnamFtem9LNlNpK3dBc3MyQWN3bXpC?=
 =?utf-8?B?WmxKNWJiamMvMlo3bWRxTkZ4V3ZYOXQvYkFZaHQrZFpHVjdsVXNiQWJGNzFj?=
 =?utf-8?B?YS9yYllLNVMwR1puOVUyQ2FQeUkvZmtzQWpZQzZnMm1PaCsxQXltRFFxUE1V?=
 =?utf-8?B?cHpqRDZ3aVMwSVNrbG9YTXhrRDZqcTVuRWpOY3d3bXZnWVJBK3FLZDdrdnJa?=
 =?utf-8?B?ZEN3d3l4eG9UcGtKRG5MT1g1VkpQMEwrVzEvbFJkcFlKY2dObEdGWDNaVGdO?=
 =?utf-8?B?ei9FK0NQYjlJMjc0eDhSS2NVSEwxQVdQd1oxL1RLNnAyKzdnSTlnZ3EycEpE?=
 =?utf-8?B?QXVENVhFdGsycnQ5dEREdU5kT2lWVCtUbzRwQnlmVHhpckVwbjZTMjNScFNX?=
 =?utf-8?B?VFJjSWVEdG9XaDhNUld2YU40clQrd3UrMG92UzdzZExIVlc2K3ZqSXhNM3cz?=
 =?utf-8?B?TnBkeUJiNDhRN2k1Ykp0MkNvN0ZNMDdHdDNleW1oYmp0VFcwT1pGOG10bkZu?=
 =?utf-8?B?K1VwTjVCL1VNa2RoRTErejFYTUxQYk41L3M2cDF6SmxCR3Bqd2x5OXlBem5F?=
 =?utf-8?B?U3VlcjZPdkMxeDhhWlJrQjZ5c1hmVkk5TElwd2VkKzFQN1dhSlV3ZU5jeDh3?=
 =?utf-8?B?QnZlYjlpM0hxd2kxTWpyZ1NEekNvTm93OTZNMjVWMkx3d0xvaFhjZXdWUjJ4?=
 =?utf-8?B?TjR0RmhLc245ekl0NXQ4WEhEWEZOWWtiQTAxS0NHZEVXU250ZTFYNVBXTkE0?=
 =?utf-8?B?Z0JJREU2UjlNK01FMFZwMStuN2FuUGVZaHczY0tEcTBiSEFKQm5xNWZSbHJy?=
 =?utf-8?B?Y0hLVm9Vd2dTZEdjTFJtNlFacjVaREw3Wm8xN3EwTzJmaUtmQkdITGMyd2JF?=
 =?utf-8?B?SEt0N3EvbnR1WWcyZWV2U2R0QkJHaUFuc0VtVERaU1FTeU5SWWNsLytYVmYz?=
 =?utf-8?B?Y2FidGxaRms5amczZG9IZkZNZWpRclBHekxIaVN6ZGUvTG9JK0o5TWJUbXhM?=
 =?utf-8?B?UGxrVm4wSkEzamhHM0VUVkdHWG1XY3Q3NGE2WWRjQWRDR3RWM1l4Ri9nSThN?=
 =?utf-8?B?elcySnBMYlNmMHptWmZXNm1jTXU3MVhHSkhENWd2dWZLRXZLZEc4NGdRSG5t?=
 =?utf-8?B?Y0FCdkFQbk1XbnltQTcxcjJ1NmlCVHBmaW5XL0ZQVmtyaVBIUmZkVnYrb1FG?=
 =?utf-8?B?cHgxbW1jMlRBYjI3cGI5NlN0cEUxQm1nL2hhRXhndnZEQjhLQnBkR2V5dEgz?=
 =?utf-8?B?VG92VmxGaUZqS1RRdk9NM2hOS2p0cWxnWUdMUzBxSjFpVlY4cjdJZUwzSjls?=
 =?utf-8?B?c0xrVkJGUjVvcUVTOXdpcXpBdm5tVTRyVUxiTU1SbVUzT3ZNVTg5Y25naE1v?=
 =?utf-8?B?azVZZ2xaK1RtMXIzUmxxb2dpMjhLNTExUmxYaWZvY3UveW5RZDRsN3h3TUw2?=
 =?utf-8?B?R1Uvb0h2U0V2ZHZVM3o3U29uaWswMkxmUTZtRHQxeFJxZlZBZnUzSFNnZWIx?=
 =?utf-8?B?K3l6SHQzeXNlZ3hzcXhBZ3lLVHRzZm94QlVYaW02OVhndGRSZkFSZ0NxQlZr?=
 =?utf-8?B?QkpSbDVEUWRpTjFxYVRlQ0xkNVZmQ3U0RlFmY0VuUnBSMy9uRU9OVnY1Y0Rn?=
 =?utf-8?B?Y2tTMlcrd2FHWFVLQzl3SEovSDg2WEhzY1lwUjVtcHN4UkRZbkhqMXRBU2dT?=
 =?utf-8?B?Rnh0WHlzQ2NSQno2S3NVOTVqc0s4ZjBFalpuOVpCTEJLY0xDQXg5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282e1ed9-892f-4451-a18a-08de6f949c59
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 08:55:20.3375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUb1KmQ/GydWWtY4R6CUkP5tWNzB9ukEv4B/cOAI2NwOPQZM6/0CjEwgA+Si/mIv0VU7igChMMOKg4jCJH/5fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877


On 2/11/26 22:10, Cheatham, Benjamin wrote:
> On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Check if device HDM is already committed during firmware/BIOS
>> initialization.
>>
>> A CXL region should exist if so after memdev allocation/initialization.
>> Get HPA from region and map it.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 28 +++++++++++++++++++++++++++-
>>   1 file changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index a77ef4783fcb..3536eccf1b2a 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -19,6 +19,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	struct efx_nic *efx = &probe_data->efx;
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>>   	struct efx_cxl *cxl;
>> +	struct range range;
>>   	u16 dvsec;
>>   	int rc;
>>   
>> @@ -90,13 +91,38 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		return PTR_ERR(cxl->cxlmd);
>>   	}
>>   
>> -	probe_data->cxl = cxl;
>> +	cxl->cxled = cxl_get_committed_decoder(cxl->cxlmd, &cxl->efx_region);
>> +	if (cxl->cxled) {
>> +		if (!cxl->efx_region) {
>> +			pci_err(pci_dev, "CXL found committed decoder without a region");
>> +			return -ENODEV;
>> +		}
>> +		rc = cxl_get_region_range(cxl->efx_region, &range);
> Missing an empty line above.


Right.


>
>> +		if (rc) {
>> +			pci_err(pci_dev,
>> +				"CXL getting regions params from a committed decoder failed");
>> +			return rc;
>> +		}
>> +
>> +		cxl->ctpio_cxl = ioremap(range.start, range.end - range.start + 1);
> Maybe use range_len() instead for the second parameter?


Sure.

Thanks!


>
>> +		if (!cxl->ctpio_cxl) {
>> +			pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
>> +			return -ENOMEM;
>> +		}
>> +
>> +		probe_data->cxl = cxl;
>> +	}
>>   
>>   	return 0;
>>   }
>>   
>>   void efx_cxl_exit(struct efx_probe_data *probe_data)
>>   {
>> +	if (!probe_data->cxl)
>> +		return;
>> +
>> +	iounmap(probe_data->cxl->ctpio_cxl);
>> +	cxl_unregister_region(probe_data->cxl->efx_region);
>>   }
>>   
>>   MODULE_IMPORT_NS("CXL");
