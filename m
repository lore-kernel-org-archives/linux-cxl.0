Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010036.outbound.protection.outlook.com [40.93.198.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAA5471421;
	Wed, 23 Sep 2026 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157542; cv=fail; b=qCnlf3byqpUoKqHnTwWpUbdEyTdMB6lD4Vha9IFD0vxUW2PZ2euXAri3gDCQ92uZlOSoQ4zFXIKk8Gpdup3FiRjiXkG04hdnPgo5ZSxYNOigDNsLuxWKgWRc9eyx1uMONhgPL35N3ccd5qbR/rvsfrajm0huMxi1R8p6vsMJu5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157542; c=relaxed/simple;
	bh=1RrxUbUKgTgh1V9ia5/Bg2AwoLzKcGgLfNDkyAlLPIo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PsiLmzVoFj5jL+MxdNCUcPFOUkgTj8I/k+sQIww9l0u/K4YbOjCsuuLCvd69XTuJ0v6zvvDxJW5eX+wR4KStwp2FrnGZeSWdxLDIKUlIdQDoO32eMGAcsTiJoglU36fZdXkZXmaztreMOlg/0GNnkVed65jMXwIVVz6jl2MeEzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5icpnrYG; arc=fail smtp.client-ip=40.93.198.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5icpnrYG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pv2+uf3TvX5cRnhgu/T4bVN+wQGw+vv7iuFqr3ClLlXbrvJnD3mfSZFa/6mTE5q5Tv45gj7lYyOtOUhfRlm71C6lzOdjrkJhTclmYuPZt5GudTwypl3nrPBXi9cyHDaUYtwjQUSyGeTqyKPb8EmCc+EsxK+9qfbnnKRfYczUKPdeekthLdRO3ae18RxRvLYNO5yPjAnWqipPHYtdbqDZT+AzwlUk0jC18AXwOQ2KF9gqOFjFKwxjlZwNCcreTxWcrsXviGIo/nN6WW+UOkBlZ9Beut0YjjHClVsKijjylDIiZWfBHMIb8kchtNpIrpF7mG1Ud3eZpRPOrPDor59N5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbfxl9aaQFa34j9IVzSvyuwHK6Xdt53iXRP3yBYlTls=;
 b=OoSxWwFSHnVbkcU2+asd4LX2WNBdhTzFNHUSm+t4O2NXvDYYPK5h6ksWzrbt9IUtqADPey2Dgy0R17LmigAbSS3m4apDiDWN7m2KLWOG0fpkBPg147Cu9KlPlTMkVRU351/6vE11VSdKXFd7CEN9bWON8LHqrK3eerPVJDaMvbl/2KO1ztreSfDlhSvY/k4At2+gmZJA4qYYYWdCUXhMmCNE7nx7hPyjWOFCyo02NQztNglt9GKw+uZR8TO+G5HSq1HvkL546SPG3GYvR3j7FaJDTx7PfvZGtHHidOh5kw8RUNZW1mC/bf/FiZUbtigQl2f64V+QUN9ApqQVNSv4Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbfxl9aaQFa34j9IVzSvyuwHK6Xdt53iXRP3yBYlTls=;
 b=5icpnrYGNTptIm7QkxgV/R53EzzgQFUjwQpEhHzaTKiKYEhcaWXfS5xFSCYnmvIsHhy1JOvkxxyB4cU8vWLZynSS6zEKqhVzYj0Uh8osq5NNQvw4o2AkrMiZbmSnC7VuaK9oao6TohJR1uooHgzy8DuM8B2cuwNWKxKGRJXFr4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.14; Wed, 23 Sep 2026 09:58:55 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0428.014; Wed, 23 Sep 2026
 09:58:55 +0000
Message-ID: <5e60ed2c-b50f-4949-9edb-ede80436f501@amd.com>
Date: Wed, 23 Sep 2026 10:58:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] driver core: Rely on supplier driver binding at
 link creation
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, alucerop@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>
References: <20260921191239.4249-1-alucerop@amd.com>
 <20260921191239.4249-2-alucerop@amd.com>
 <2055ead9-201f-4878-aa09-07d7fc3ab3c2@bootlin.com>
 <3ab9bc66-f3b3-465b-b736-09df1da2fcac@amd.com>
Content-Language: en-GB
In-Reply-To: <3ab9bc66-f3b3-465b-b736-09df1da2fcac@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0128.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::16) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3c4e88-4d9d-436f-5c0e-08df195947a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	U4oEjbe25jVhvjXLmIHYsDBSKuNBuBXwi1x4uol5rNsHZgRXBLLQ6Sc8gpMxUYut45mAKM3eyGWK0VvXIQ7sG0Cw9LDST5w7I6dD4K3fp5FZJSxWb1n/hr5KJBhfTrVbUHtF1VlWfyhxfqKh+jcFS79+bquAl1262+UtWs62d/0oqgHQFnS50IODDOEpfG3XmxJXoB/134wm/aT7JElhwF95iUFdKeArVkqKURnnF5X0DXRUoBM0QRjYt1RkqKp6+8A2RXVtb+1zXFAZapvNGBZnG+iG569bl24Lg9snrSo6+aJeIePyrZR3JF1b0qFnIwWgNMtJBnAtI5H2IApWrgcfVI/RJqJF/i4RsNP84ZTgk4jJG73rxxGq4lSVO4F3lxzyy4z3pAwWJCOO+DgWXTbx455Ezm1caPzNCaVeu6fy/SSakG/jYw0AokK/FVMdOW09/wkcVjDhTSoGbSDFnzkJ8wzHFNf4zvOnP80gP0dzS1H9xrjU39kBoS1NeeXRtANlWo1lE2gOHeEConPkw7bbvND+nuaR56HVuSdfsR2YJjoBaAvFBsrVdLPimUBknjU8QwNirSun9Dd0a0ASxkMenLKME2Yh6580Op75K04dWEiC/BUBB2j0EHn5sEdLVXtjnOI5d2pg2LKLbcCKRBq7h/P3VZgwnHKNcFQpxjw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QStERllTRzVmK0hycktsNTZFZXk1ZkFERm1XQjlNdkdwZXk5V015c3hKQzBD?=
 =?utf-8?B?cjNSVFE5NFJXVnVhUkJTZDR0WE1GY1gwcUt4U0x4RXpFUzBkQ3NYcTIzOUsz?=
 =?utf-8?B?dlVma3hWQmRaVm51andMQWVOU05KUGlZM3JkaWhBU3JaUVpOWm9neUxEcTQ4?=
 =?utf-8?B?N0h2WHYxVHNRcitHVmZRN1htdTBtMHpmcnlVWkt5aTBRVjI3VTcyUlYxZ0NK?=
 =?utf-8?B?S0ljd1luRzh5U2NqWEZrR0NVa3FtZ0t6cjN4eDlWRjdIcS96emtSQW9OYTB2?=
 =?utf-8?B?THBLNkJEdVd1L1RMTWJYcVVmMVJ0SHNnSzRFL1hESHMxOXljYUZHUGRheGM2?=
 =?utf-8?B?dWd3a3hjQ3ZSclc0M1o1Ni9GSUsyM3czanNMN0xnUHNxdVdnT0RkRlhKRnNt?=
 =?utf-8?B?V3lJTFc2UmlRK0l4ZE9wd2IxMUJCYndNY09WalFpVDJicmUyd21pbDYzT2I2?=
 =?utf-8?B?elBIZmI3K1VocGUzOVZaNTRqWnlmaHdRT2dLODgvQXFhZGsvMy9zcHAyaDFG?=
 =?utf-8?B?cEFLeThHb3IzOFJLekRLeG00UWRQamltdHZhV0N4UEwza1ZacWRVc256ZEY1?=
 =?utf-8?B?dllwbUxpcjlmN21ITjJhb050QnlnSXZqZGZac1RMUkdaMDVyNXdDMm1KRDdV?=
 =?utf-8?B?ZmhaS0NPY1hDQllqVEpYZUxBWnRCeTArSVphTnFiNjIwTE1qOUpYLzlQK0J6?=
 =?utf-8?B?MmtXcFRUT0FmbnI5ak9KcktLMml1OG5kL1Bya2Q5UFJyMFlpMG1JdjdlSWk3?=
 =?utf-8?B?MldqUUduTzNaZUZZNjlkK1MwQlR2WWtMRGdxWWVqTStGR3hXU0RaVFBDVE1r?=
 =?utf-8?B?K0tkWnQ2OXErTHoweElLTkhpYXhXRVNjL25qZ0NGTUFCNVdwMitFQTliWWt2?=
 =?utf-8?B?bzUzSElaUUJwODhpem5VQ0ExQXpmYldUdVgrMGlIV05MUmUxb3c5ZmNPeTBT?=
 =?utf-8?B?V1NTL1hMOHBQLy81VFJPbmRFMFhnVEdZbU9nUjMzUEZCeHR5ZWRCTW9WS3Vo?=
 =?utf-8?B?ajlvcHZoWkgvckIvRWpsUmNycTEzVUR0V0h1NzNUc1RqWld6K1IwbDI2UUtT?=
 =?utf-8?B?dENwTUtta1lTeVRsWUZzUFVFTGlpS0xBeCtwbkxjNmhmZXgyRWlKdnV5R1lN?=
 =?utf-8?B?dy9qZjlHeDJyK3Q2SGpMdnFmTUU4eWhrQW1FMFBOZ2JueHFnTTR4d3kzN3Vz?=
 =?utf-8?B?aC9rSVNCWG1OZkxiOTk0a2dPMS9GZFZDNi9kdFZsbkhZVFdyUVV2dE95RGov?=
 =?utf-8?B?Q0Q1L2ZvVjE1WG5KTnNPUWFyYzJQOVdwTFIvQ21UZllJSUR1RjhXYkN4RDFp?=
 =?utf-8?B?T29OMnNCbnl3QmxaRUphdGpRdlRZeTlBTlVuNFEwZFpiUWhpTDIzeWtUMWpt?=
 =?utf-8?B?TFM0OWpOT1BLeVNsNWd3WjR5VE9GeFdCRktWNVBvR3I1Z3dyM0pGZnA4L3I4?=
 =?utf-8?B?S1BMV2ZkV0hROVJRK3RGVUc2K1FFYjFvVjJITGpaUmZIanlJTFExcHd4UlUr?=
 =?utf-8?B?R1lqL2V4Y2tGaGNkWlNVa0dBeWI3MU5UVFJqMFQ4aHFVR1owMlNDdzYzN3hk?=
 =?utf-8?B?d2F5NU5FMEppQTVMcXhzZDgyV3NXN3ZQZnNlTWMyR1dUbU5nVUhEaDV1UjVa?=
 =?utf-8?B?c1ozeDJ3MThnLzZvRDZQY0xUOVk2T2VmY0g5OFhuMjFUK1hnaWtsV3hBS1VG?=
 =?utf-8?B?OTBiaVd2U3hPejBlNjc1a09DVFRCSFAzWmVmdS9WNnZQYzRsVHhSMk83K1hl?=
 =?utf-8?B?YlFVUjJQdmQwNm03T2xSY2ZWc0JELy9Fd2R2akt2OVgrRTlhTU11elY0UTFD?=
 =?utf-8?B?OFkvN3FSdWF4ZGJKQ2FWOVQzK08xMkpIQTlOVG5wb3F6RUE0WVY2UERGMWhV?=
 =?utf-8?B?c2VaNml1WEtmczR0WUQrcEd1ZG1MdUsyU2RvVnhDNjNTTzZpMVlsTVF2RjFZ?=
 =?utf-8?B?YTI5Yk40NTdxdXhpRjkxalJaOFdPb0NValV1UTkrdHZhV3pPRlFubDg2L0RI?=
 =?utf-8?B?eVp0dDdyYlFkeExvZENCTHJEVEVBNDUyWHQ2R1duQWV3MHpsS0FxOXNZbjVu?=
 =?utf-8?B?cElSbHpwcE9mSnUxM0JVV1k0a1NIRXZjaTdaeUxmRTdoS1U5WGZIamllb2d6?=
 =?utf-8?B?c1FhbzdybHR5TU1yN2hBbzJTa05OMUc5QTdwWWtyeXlaMDlCem5iK1dFU3JW?=
 =?utf-8?B?QUYrUkkxYmd2Rit1SWduakpEdjlIM3dCUjNLVzh0K1pIT1k3NjI1aXMvd1o2?=
 =?utf-8?B?c0lZY25KMTBkQzhUYy92dU95bzA5My9SSGFrcUtDSmdiYitEeGV2U2YxeTNV?=
 =?utf-8?B?S0hQNi96K1hQdmVac2hHNTJNWlpJNnNCSDlBOEFVVDZ0YTh5K0FZUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3c4e88-4d9d-436f-5c0e-08df195947a4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 09:58:55.5785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMQhzuXV4DkBtmFVEkolnbQ9wwZt4JCjJQWszGJCRlA186AzdAwj1r7AY9ORe9oXnOff4l4WsIdBOnmaQGxkaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153


On 23/09/2026 09:49, Lucero Palau, Alejandro wrote:
>
> On 22/09/2026 22:39, Maxime Chevallier wrote:
>> Hi,
>>
>> On 9/21/26 21:12, alucerop@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Differentiate between driver binding from PM dependency when a device
>>> link is created. Rely on the device being bound to a driver for 
>>> validating
>>> the supplier as some device drivers could not support PM.
>>>
>>> Check for supplier's PM state only if consumer specifies PM_RUNTIME 
>>> flag.
>
>
> Hi Maxime,
>
>
>> Hmmm this patch seems to have broken pretty much all the boards I'm 
>> running that
>> boot with DT. I'm getting logs such as :
>>
>> platform 16100000.serial: Failed to create device link (0x124) with 
>> supplier
>>    16000400.clock-controller
>>
>> Some are just hanging at "Starting kernel..." from u-boot.
>>
>> Then boards go silent as the uart dies, and I'm using that uart to 
>> access the
>> device's console :(
>>
>> Found with a WIP stmmac runner for netdev CI.
>>
>> Unfortunately I don't have much logs to share, as this just prevents 
>> the boards
>> from booting :( With this patch reverted, all boards boot fine
>
>
> It is obvious I did not understand well the implications ...
>
>
> I think the supplier device lock could be the problem behind the 
> hanging and how the supplier initialization is checked now based on 
> the driver bound behind the console issue ...
>
>
> I have a couple of embedded boards to play with so I will try to 
> reproduce the problem for getting more info. FWIW, all was fine with 
> the server I tested this, no device link errors at all.
>

I have to amend my words ... the server had not exactly the same code 
:-)  I have to copy things in and out due to security measures and 
sometimes is hard to have all synced.


I think the sashiko reports could be a good start to fixing this.


Apologies for the any inconvenient.

Thanks,

Alejandro.


>
> Thank you for testing it!
>
>
>
>>
>> Maxime
>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> ---
>>>   drivers/base/core.c | 27 +++++++++++++++++++--------
>>>   1 file changed, 19 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>> index 4c0c373998a1..eb6d87e35d76 100644
>>> --- a/drivers/base/core.c
>>> +++ b/drivers/base/core.c
>>> @@ -834,15 +834,26 @@ struct device_link *device_link_add(struct 
>>> device *consumer,
>>>       device_pm_lock();
>>>         /*
>>> -     * If the supplier has not been fully registered yet or there is a
>>> -     * reverse (non-SYNC_STATE_ONLY) dependency between the 
>>> consumer and
>>> -     * the supplier already in the graph, return NULL. If the link 
>>> is a
>>> -     * SYNC_STATE_ONLY link, we don't check for reverse dependencies
>>> -     * because it only affects sync_state() callbacks.
>>> +     * If the supplier has not been fully registered yet with a driver
>>> +     * return NULL.
>>>        */
>>> -    if (!device_pm_initialized(supplier)
>>> -        || (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
>>> -          device_is_dependent(consumer, supplier))) {
>>> +    scoped_guard(device, supplier) {
>>> +        if (!device_is_bound(supplier)) {
>>> +            link = NULL;
>>> +            goto out;
>>> +        }
>>> +    }
>>> +    /*
>>> +     * If consumer asks for PM to use the link and the supplier has 
>>> not
>>> +     * PM initialized, or if there is a reverse (non-SYNC_STATE_ONLY)
>>> +     * dependency between the consumer and the supplier already in the
>>> +     * graph, return NULL. If the link is a SYNC_STATE_ONLY link, we
>>> +     * don't check for reverse dependencies because it only affects
>>> +     * sync_state() callbacks.
>>> +     */
>>> +    if (((flags & DL_FLAG_PM_RUNTIME) && 
>>> !device_pm_initialized(supplier)) ||
>>> +        (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
>>> +         device_is_dependent(consumer, supplier))) {
>>>           link = NULL;
>>>           goto out;
>>>       }
