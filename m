Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6888717B408
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199421; cv=fail; b=tcVg69f848wY1ZUtU1tL7/kL8tslv2Qo1S4uCzJ2ukDIKhdIpwmSiKDAEy1Bi1Lt+HruRXHW5LPOyPoJRFZut8PXqvxrtHZ+ChA2ss5j6RG9jDKhuJscNfueRJkiuPOkNZYpxUgANOq+E7T7V1vWsAVupSAyuFLDlB0hFKtDZ00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199421; c=relaxed/simple;
	bh=7c0VWmCyMpblp7Gmor04bUTwyYDfIHhgwnL/j0Pi1E8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GWiU51M5t3SM29501rLyNEy6mngyY60+AgVBdVEwSTgrxM3ceK4ru7KLR58gJONaKxQqbKbrRaFdMQRBMDM1bfda/MeTJxrd7D4qN7K/GOgNJAgIw/rzq7DvbMBXjKTiSrSHtyYpFXxS3AnwgUieByUuqI/5v5I797jbYBc3K50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p2hnXrWP; arc=fail smtp.client-ip=40.107.101.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p2hnXrWP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RT++XtCZA9tCCa3wjW6DzftubjSspsSbwOsF4BqQC6+lQz2ZInF05iAjhy+qAj0EpnsH2BCHZIfdA100DYiH4ApaBBjxr2g2Jl4rFZ+bqn8Pajt+kH1LnVC0bzwkCTOoYLpA6FLOd8tlrMR5cAOIbeSLBmB7sv/ED3m45xlNusfhr28C8KyVB17aCYv5habDC3HaTkUK8lATHE7qTYAirzieG1JpRGf4enQKpzTml8Fp8JDRtM9sO8w/YSwcyc+1s/5OxQ8zgybANXvMcwY8yj8YKkLTOBWLjC1LxFz/EtOsDCosKQroyNHTlC7d7qApybd73n17q+i266TR41vGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDUq/0puwZSfDvEkI4P4LxDmAjs9Irw/sfdcDvpgUTY=;
 b=JiPHwgZf2ZSaLubER9LrAc2xyYTGegtkqNnJXPvpxZT216l1pW4vexQPa8Oxt8LliFyWzJXF66B4Rwo5yolTAY5BHk4j1NXe+OUrH0HdP34/ARS0BUFBjiGk+oA0oDrm6C6OXneQilaADDeNeAT20IXsRu3fpl4Dww/OHQqbgUw8I3sxfuVDAWoD131eQj8BSuO3BzqiQcT1rK0nqjVv5vc/6fv5eHPfJGX1Kv00GKpfy1SXJ6Nqmc1E/fl3IgCp+QXM3KnARt2ZZBU7XTBtYdPCVntMI90QG0LRL4FiyfxYZDDOIvvEEg65E/kdYwsPPFb3utp/AfktZj6yN/r0YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDUq/0puwZSfDvEkI4P4LxDmAjs9Irw/sfdcDvpgUTY=;
 b=p2hnXrWPnKnWlhbs8NwMSIuS2qSVV7fB9yVXmGAkSlOgoLMGXPlvWMJF1uvfSQZKm5TrD4Q5jTZ/1v147zkAceJch1F+WnnV3YGzPW1AyyzTbM52bEl6E8elhkjMVu8booPmiCL/vqM/e5IGEyOrevWNB3iscUN4eh341mZOUSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ2PR12MB9238.namprd12.prod.outlook.com (2603:10b6:a03:55d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 13:36:57 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 13:36:56 +0000
Message-ID: <d2cb84c9-384b-9afb-db8f-8b9db18fd291@amd.com>
Date: Wed, 12 Jun 2024 14:36:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 01/13] cxl: move header files for absolute references
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 pieter.jansen-van-vuuren@amd.com, richard.hughes@amd.com,
 dinan.gunawardena@amd.com
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-2-alucerop@amd.com>
 <666923ba32ac7_3101294dc@dwillia2-xfh.jf.intel.com.notmuch>
 <ZmkkaOTUFuzIr2cG@infradead.org>
 <4dadbadf-529d-6f50-b30e-8a428d8c6a19@amd.com>
 <20240612110752.00007442@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240612110752.00007442@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::32) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ2PR12MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f998d9-1a38-4d8e-6fd9-08dc8ae4ba5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDlFQzM4MGJIM1VjeTVRQUZLdlVYbG1TR3h2RVdpRHRVWkZhZEJaTlJwMDR1?=
 =?utf-8?B?RGtIMTg0YmYxWHM2d0tLazY1eGhYdmhETlA0TWJ5TGFXeTBjUFVoQk9PNjlM?=
 =?utf-8?B?ZTJNQUdrZlZ0WVlVU3FGazRyVSsvM1MzT0hOOFhxMU5YckY0UmJqbE9OdUo4?=
 =?utf-8?B?a2FJWllydGxscm5pcGtOZEhUYkVXTEFqN0ZZcEUwd00xUFQxMFZSV1ZwR01W?=
 =?utf-8?B?WFNRUEprbCtaTlV1MDVyRE01a1ZWZVgzYytuRWVwL09id0VxRVRMelFIN205?=
 =?utf-8?B?TFlVYksvaFRtcHVqV3MxczlVa0xETFRPelZCdURTQndFbTVNcmluWkRBenl6?=
 =?utf-8?B?d3cyRjdtRHBmMTd4dGlUK0NrRXFseStOUE9pZ1UrS0RiZmh2USs0b01CdmVq?=
 =?utf-8?B?UTQrdjJoN085RHR5SCsrOUluRElIb2JPbldoMlBmN0xMekJxb0pjK3NHN3VQ?=
 =?utf-8?B?Zkp6aXg2S0ZzZmN5bWp4TG9qOEtwbVJNMmp3a3ZXWUsvYXJ2V2d2VjJjWlJs?=
 =?utf-8?B?YmxTVXVwdFZuc040RW9xc2Z0YXF4cjRBcndxQzM1QTFNVzJQcWxjQ0tnbWFI?=
 =?utf-8?B?QnM0TnpGM2hRSG1jZFNScE9QaGl6V0cwZTFnV1J2VzJ4cERCb3B2S2VvUDFR?=
 =?utf-8?B?bFJvWllqbVBWV2g0aHR2Y2R0WHRuSTlTdnpCdzhodTBkRzBzTTBrcWhpYk1n?=
 =?utf-8?B?aUNFcnFEbG40bkdCSkFCTmVqM1B3clBxU0M1aUVYZC92MFJaazh3cVVDRC9H?=
 =?utf-8?B?S1lKamJJeEx0ODQ0eDNDSk9XRkI4UlI2ZmJFMFRWUk9qVkFvdkgzOGFzVCtD?=
 =?utf-8?B?SElNOGdTQ0lyN2pnNDE5cU5XWWVwUUFDais5OGF6dC9sZzNZZTlXRmphVUZL?=
 =?utf-8?B?VU9GL2NHZjM4SDdDNmp6MnZEb0MralNyMTIxWlJnTllLVW9tWkExL2RpMmcz?=
 =?utf-8?B?RzRkMXJTdGxOS3U1UC9Hc0t4ekpBcmsxMUMxWUEydEtzYmlyK1pteWZzMGJZ?=
 =?utf-8?B?Wms0M3VQK3Q2MjlzbVJPRTl6cmx3MDYwc3FrOGJMYi9VSDJCSlQ0YWQ5bVFT?=
 =?utf-8?B?dzFkOHI2Nk9TT3JnRC9MRDFpc0FtcElXWnZFTERsNnlvVHZUQ0dVODloN3hP?=
 =?utf-8?B?cCtWT2hiTmhDa2xWdjBpSVFpTGpPa3V5MERDZFFVMG5WUGIrL3l0SFZuTitG?=
 =?utf-8?B?ZzR4ZmZpMmwrVktDd3A5TVpvNnlxRk9pM2tCelhjTTM0d1I3dGNBOU9IVG5H?=
 =?utf-8?B?a0swRXVSZkd5UWNtMFdOY3F1TG9ZWHJrR05Xd2RvWDhsMEMxTUJPRy9EUGN0?=
 =?utf-8?B?SC84ZkpaSm8xZ2ZmVkVOTGdXYStUL1RGbHo3eVQzb2ZIY2NpNnQ0Tm1Nc0VK?=
 =?utf-8?B?cXkyYmRUMUZvWFhCRlRLRnZQMitnU0wzRHF1T0xJUzFoRTZQNXVzbGY0TmU0?=
 =?utf-8?B?Yi9Gdy9JZXpZVFJyL201WFJGZW43aU1ib2lab3VOUk96dnpuYWYwaXFCbi9h?=
 =?utf-8?B?V3YwRWlxbHpJaVlnOEZvVjVWUUVHMFZlMGxZQTBzYlh4dDVDdmM1cU5CUWR1?=
 =?utf-8?B?bkJBMmhOdmFpeXZoenpzb1hEaGlEcWROaHJORjA4Z1o0U042WTZIVHc5Rmlk?=
 =?utf-8?B?em0rTzF5ZWdvZGhNSk1VVTAyNmxMa2ZqT0xqczV4blpIVkxBUEtwVy9iMTF6?=
 =?utf-8?B?d3lyVFhtbndlQnRvV0JrYTB2ZXpUNGVjeFJZZk9RZUFHMGxHZksyMnh5U0wy?=
 =?utf-8?Q?CZtLTpJ+eSsEX09mMo7j4QSQ15/PdLf93GmoK5H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZW0yalhxSjErRDB6dG5LRHU3Zm1WZ2d4bnNRNTFMbzM1WjBJc3g1aVFuTjZV?=
 =?utf-8?B?ZXREV2JaekU2eTZlU3RuWEJuZElJZ1p3TENxOEd2ZW1aWTRVcFZqWEJ6c2Iy?=
 =?utf-8?B?eCtoYzd2Vk1zYmJOcjhXb0prQWtMUlFZWHdWaWlZbDNrK05mWlJTbWNVb04v?=
 =?utf-8?B?VUtqMUhUdkYyL01aWVNycSs4TUxvL1RVN1FLdmcrSzRhNmF2SWZIRGp5V1I1?=
 =?utf-8?B?TnpYdmpBTTBxY053cDVHS1JBYUZPQ2FoRU05SDEvOHJYU1dqL2FDaytwYUJw?=
 =?utf-8?B?R0RhbHZZTUR6UnFtcXFlSFVBbFl1d1haQmJuQzdWM2o1RFJBVE9rTVpVNUVE?=
 =?utf-8?B?SzVFVnlMRVN2WFZ1TEY0eW9yTFNIdTMyWE5VY0RrWW41NjMvb1RtMFNMby9h?=
 =?utf-8?B?SllJR0ltdndNa0pOc2s1UEtQOEszL2dwV29hK3RUNG1oa2RoaFlCb0QzWjBp?=
 =?utf-8?B?L3RjTnMxL1ZNdnNsY3E0MUdRWDU4QW9nek5oRmNkV1VTMmNYa2xteVlma3N2?=
 =?utf-8?B?cHN0TW9pbVVxVEpNazVBMDdBRm01eHpJM1NxZncrTit6N1MzckQ1Z3NsZzkx?=
 =?utf-8?B?T1lPZmYzNW1uV1ZrM1UxNXEvcDBBemNzRDh3NW40RG9idlc0RE9Pd2NrVEtJ?=
 =?utf-8?B?WUN2RUt5RlhMRkdLT2tWbVgvcldoSkdIZ2RtR0x0TFo1clN1eFp0a0FYdE1w?=
 =?utf-8?B?MnlXK1E4cVVxcmkvbkI5a3Z2ZTV0VEFiYVdzN0hvbnlQaDhPbjJiejBIa3RC?=
 =?utf-8?B?U2Y4OWVBWEgvVGdMNjhMK2tRUnpDNmNoYkZxa2VFcFhDbk5ueUtpbXJTMkJk?=
 =?utf-8?B?MHRocDFxekJUeTRIbGdGQk90TDNqL1piMnlZYUVmVjllVmx5MFFSL2hqTnFC?=
 =?utf-8?B?WkJPL3dGeVRnRVBrVFAyc3JVSFNYOVNxVVFFcnRnbFNQaXh3RHVKTnEwL3lP?=
 =?utf-8?B?UitYb0t2Kzdaai9uWFNaeXBwTmVxUGxGeDBPemRBaUFsN2wrc1g4SGE1MEVu?=
 =?utf-8?B?SEZTV0JxUEMxbE85V2tXRDVJR1hTTkVnQXFlZWhwYU9uN1dwOFZDMFovUTVk?=
 =?utf-8?B?YXJoUy9CN002WnpaUmNSUVZUYkI0RkViS09Ya0wvZlppZ3VnRll4UEg1aWlk?=
 =?utf-8?B?YzlXeTJud3Y3MjhEUkFqSFJVUmVXc3BXeGJ1ZXowejNwdkN0QUh6OFFlTnpJ?=
 =?utf-8?B?Y2NGZzFRZTUyZkJQWVZtZU5taEhRbGhzbUlTa2JSTzZtQUxLUThXb1NRMlEv?=
 =?utf-8?B?L3V2dVc1OGlHd2cyWUZHRG1UelZ3TGtzNi9GV3c5OTlqclVKdmlnOHIxVmR0?=
 =?utf-8?B?VzNLZWQ2RXlwOUY0Zm1ianFTYnh1ZGx0SjNBbVI3L1ZPdmwwZVVOd2R3cGlz?=
 =?utf-8?B?V1RINE5SOGw0Rnk0Q3JyU3BlUHVWTmpNOWtnQUxtbmNUYW4zVnhBbmFDeG9Z?=
 =?utf-8?B?TUJLcUl0K0FWVVlNa3RvUjNVV1V4SnMwUkVraVFQUitXZ3NYb0VWcGNpNEJr?=
 =?utf-8?B?bUlsaG5TUHoyNkJPMVVNbURldmE4L3RKMkIxYXJGcU1JT3lUY3cyckxJRitx?=
 =?utf-8?B?NjE1OHRPbVZxV3Z2cTBuMXRBdytvL292Yk1sUUhCd29CaksvakVtZkwxUU96?=
 =?utf-8?B?Z25hRktZcGlleHJXaDdWaldGWXkxSE1pNTlTclZEaE1wQ2krLzc4WnhoZW5M?=
 =?utf-8?B?ZElzZFNIZEtZWUs2WUJMdm5ncTNsQXc4QVQ5U2FXaEFnYmhKSmJxZFhyY3Bo?=
 =?utf-8?B?RWRKZGdGako2N3NoTGZmSHNRZnFnSkVicm5OcW1lMHVxaytuQzBMOWJaTXUw?=
 =?utf-8?B?UkMxTWN3SXJVbTdIQXgwWmZSTFFYd1NpY3I4Y05WcVFQZGZMWHRidDlDajUy?=
 =?utf-8?B?SEdFMW01cmxBZVVhYXAzREN1ZThyT04rdnNacVpQQ3lxMkpYeXhvWGFCNGRI?=
 =?utf-8?B?RTkrbTc2bnBCMFMxQzRXQWxHdndrKzVKdE9Nb05WaHpvK2x1K0ZjSkMvSjIr?=
 =?utf-8?B?WjZVZi9tU1NiZ1ZCcW1xMEdhRU1Bd2kwVXpSUXFxanNvemQybXV4Z0kzQURL?=
 =?utf-8?B?dDZVQWhHSHBESnZRdEI2MkFEdnVDVzNmT1NFeGhRY0I3R09ObGZNbXo3MjNX?=
 =?utf-8?Q?IkJX6rudPqSYAJdZublVFnJ0R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f998d9-1a38-4d8e-6fd9-08dc8ae4ba5a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 13:36:56.6543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkqwIBj+dq6lZeqfeig3ne+YoJmHQQ6WrKr4mhoNFzNQzU+EyE7+ehCaeP0lscw4S2tktQczHIztNcwJmw7lfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9238


On 6/12/24 11:07, Jonathan Cameron wrote:
> On Wed, 12 Jun 2024 06:54:13 +0100
> Alejandro Lucero Palau <alucerop@amd.com> wrote:
>
>> On 6/12/24 05:30, Christoph Hellwig wrote:
>>> On Tue, Jun 11, 2024 at 09:27:38PM -0700, Dan Williams wrote:
>>>> alucerop@ wrote:
>>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>>
>>>>> CXL Type 2 devices imply specific vendor drivers binding to those
>>>>> devices instead of generic ones offered by CXL core like the PCI driver.
>>> No, it absolutelt does not.  There is no such thing as a vendor driver
>>> in Linux.
>>
>> Well, yes, I see your point, and it is absolutely correct.
>>
>> It was a bad way of explaining the need of a driver supporting a
>> specific hardware.
>>
>>
>>>> So I don't like this approach, there are details that are private to the
>>>> CXL generic memory-expander use case, and some that are suitable for
>>>> CXL.mem and CXL.cache capabilities in other drivers. That distinct
>>>> subset should move to include/linux/. I.e. I want to see the incremental
>>>> conversion of what 3rd party drivers need compared to the generic
>>>> expander case, and consider when and where new shared infrastructure
>>>> needs to be refactored.
>>> And I'd much rather keep all these drivers in drivers/cxl/ anyway so
>>> that we can keep a tight control over them.
>>>   
>> My initial thought was drivers for ethernet, gpus, or any other kind of
>> standard device binding to the CXL/PCIe.io and doing the CXL
>> initialization. Your comment seems to suggest other approach, which I
>> can only relate to using auxbus for the device CXL.mem and CXL.cache,
>> and  then being handled by a generic driver inside the CXL core. Is this
>> what you are suggesting?
>>
>> If so, I'm not against it, although it would require to study the
>> implications.
> I'd be very careful with that level of complexity.
> So far I'm not seeing it as useful for this case (but I could be wrong)


I agree the complexity could not be justified.

Indeed I think the privacy of a CXL.mem, something I pointed out, will 
make things more complicated.


> Maybe just a case of well defined library code with only
> opaque state etc being exposed by the CXL driver framework.


+1


> The bulk of any type2 driver needs to be in the appropriate subsystem
> not drivers/cxl/  The non CXL parts will be more important to keep
> aligned with appropriate subsystem than the CXL part.


+1


> Jonathan
>
>>
