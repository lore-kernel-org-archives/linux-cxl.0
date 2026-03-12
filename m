Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013065.outbound.protection.outlook.com [40.107.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6882DF134;
	Thu, 12 Mar 2026 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348926; cv=fail; b=TYTJ2WJvtTssJkETpW/ic1C7mevON7w2+9yoaUSvBhbPt1qR49tMXGGM+2ZecFxnB4vl7FnQVNR2VtuTUJjpGd/RyRAbojo81gIN5as1W7gf1yJLvzKMX+LnEwb97R+QE1XZAB6WwvRsIbsLVHGcWt4OiEdP2CuFby0Qx7vPzEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348926; c=relaxed/simple;
	bh=gJNqcDKIvOMTKZhgM5m8AsuI0+VKI7Wsqf5yrjRr3ys=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=obvEyYqD3+kuV648oBeugGZf1L9TGxghzpgp8RI0KrrJJPYxXBKtOBcCxoarf60umgKJYGrpYvODH3KDzTRMSGSDcS9WnI05zwPuap/nh2Wf13QwAEvMtyycU58GYmPPv4OXW0DtFXnonB1/hmm5ngg8u+rKQPzSBmRg8O10poY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PNaWhOGv; arc=fail smtp.client-ip=40.107.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PNaWhOGv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pxuwpt8xdt0V7e8TLSR/ZZscuwemXp3g4d+5wc5/3ApyPx2+JGQ0tMVVVMBCIRHv/loQ1zmMNxVkZ50M4CoZ5sPWlJveYTopKzXCLbJfxkZXkbfHZ1BLr7xdw4uMaFvALc/zZHNmbLXLSbxwo5IOr11pskHNSIfsOXgpg+x3OL/CH6eVM1Kcpj+sa4JY6Bej74B5Ajf6R8sCF2dN0vIzsKbFaPbOoqOk9/ULM51LY8cagqB9oizoUaW9J0dCseHCCfxyYprEdOahXzXIOgkfA/mJwVmaOE7NOPliyVYSoaE678FfRxrr2CP1/katoKALWD4s5itOnhCjxEnQ1WmPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnAb8oe3XTEPOSqSapk43PiNOjhSUM2Hy3owiCfyc10=;
 b=k+kjdbvNHa3/2zQF4/jVEubPhA/vv1p3rq8ap7N1xCd9LxoYhGcf2cXnw/jmFGTwwAsTyhbS4HDnjkixrXkf4UKNOOsbpVMlRB3KM1xEtcrcwzRfbeRSeZhO9JOQo/R3SKGdCKJGS+tJRet14EooDDirR4uWCKvMFn5FfqY4qyJ8sz92moNypCKWYBhduXm4WDTwCjAAN6GNd20g0YkZVU3nn7VTOl1Lqg1ythSIcR4/zDPocgGE2hps3JHW8FcOpZz/HpJTkUDp91yOT6cIS+zcFRPMJR13OaGRxcWXX7jZdWw/hKrq4+OiJPnsHohf399FynY8911RIZnyDegkgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnAb8oe3XTEPOSqSapk43PiNOjhSUM2Hy3owiCfyc10=;
 b=PNaWhOGvNvsGgXZcz+qGNttI/DuyfYkxkEIRgX0HO3OlGQ16Q/KDcjJFCU6JCYGSlCIda/x+3pfkX1dTBETn+7vKQP0eF2P98QhSxBQdX8rXf/s6ZgTWjBWsz6rnEX6hnRDYaVeI8NI7H1ZyRJmaBRpWclcLI3fAuK1fTjbrYlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 20:55:19 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9723.006; Thu, 12 Mar 2026
 20:55:19 +0000
Message-ID: <972d610d-e6b6-4c82-b5d3-85cfff9071e5@amd.com>
Date: Thu, 12 Mar 2026 13:55:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/hdm: Avoid DVSEC fallback after region teardown
To: Dan Williams <dan.j.williams@intel.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Terry Bowman <terry.bowman@amd.com>,
 Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>
References: <20260212223800.23624-1-Smita.KoralahalliChannabasappa@amd.com>
 <69b0dff5b6043_2132100cd@dwillia2-mobl4.notmuch>
 <dd8e4ae0-94db-4c2e-ae92-6e01e07c626a@amd.com>
 <69b31741a3945_21321008f@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <69b31741a3945_21321008f@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::24) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|DM4PR12MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcc32a4-b6cc-4c1a-4744-08de8079abe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/od0wHJ/gXssQTUyHy+LXECYwAOKwrZFOxcS6i1GuJ3BTN/N349pdVRGSquuflxxE+irgnIN8Wezy0o1KeVEDYhOF1gh7zY33ASpABrcVlsTtQz+LRLqfm3dWxRvyoMod9JW3WX4YdDVPzRAU2hS9K3/+3kJ+cVlDKEpb77ua7AaPn9VZRVEa/aJ/bqZnuLdVtWZSOFQtTyvIaQ2QB4FFXflqL+kDUEOrK7y5E7aeDZNqNJtce5A5PtA31tivUenxFJ5LlIZ99jVvMsaXEtqTWcXQZ67X13t27VvuOVF+NQZtNVAczpSWD518Xvwtl0xvlBgWGnTLqMkdBimVso/Xwfnb3guCcP77igZ4hyHNRBc3bYzCXuGAA7C8Z+k3/Zjo8yEZu7euNHUgTS9VVe5xN0Ql70mZCNR//UVEFXm4W2lFONJkEW7mbtq8wp6twLpjH/7Xc82lH/v3rEgTzv1u7N17tP52/WDGrgpTIC170edCaJDJaoIgSUVSIDrhAE9inl3+VWbNIrRF/Ivj4T5TUW9X4BorbPQ57f/R7bHOq6GguOz0sy27R1LG0dcPALqq2F5wufxlaplAcrtmgRAZMOPtzJetB+2mcdBHrzINmCtJaMgHbo1+1LtXvaYbZDtCiaGsAj7uXpwvm4TDgRhCSMSZ4jzN/D0adeY0XoWPgIQIcLcbBleCaLKwBOYZkUKebLHa1aeJ06AROSveREAJFBIYCKYdrM+54Zrq3k9A7Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akordE1wZ01SaTR0OGhIeW5WMEhlNm51RUVObkx2Wk5EcUdTZk9aVzVuVFp2?=
 =?utf-8?B?WkVZelNFNXozL0VBOWNqRTFpV2hMZGp2YUtOWk52OC8razNXZDRCakNTMkdO?=
 =?utf-8?B?dVlWclNiZzZhaVNGazI4cTRHTHNCUE1IVTIyMkZadXU5OGpmcnp2UWV2eTJR?=
 =?utf-8?B?dHVHZzd3UUc2SWFsZXVjendzMTYrT3VCb1Nya3VpemhXdFJoU1RxamlPQWty?=
 =?utf-8?B?YTRXWWZrbE4vMDZISXRKWjZhbHNiQm03RkxPWldZTm05OVhpZm16bmg5ZnY3?=
 =?utf-8?B?SWhYZnlVeFFQOG93ckdUMlNKUVc1b3RNV05rQWkrZHA1Z3dxenJHeGIwekpR?=
 =?utf-8?B?SncxK05zUld4eEkwS0lnYzlnb0tRL0FoVzE5R3RlNVkrUmNSSStodlJwbkdQ?=
 =?utf-8?B?ZFMvY2VBY0lKam1BZ0RkZFozdWY2elZEeG9sRjRLMnA2MmltZ0VrMXo2V0Fh?=
 =?utf-8?B?VmpXdzJQR3JZdnlKK2VoY2FxcmlvbFBOZzZVTzJMOG55RG5hVTNES2VMNVBR?=
 =?utf-8?B?TU54cUcvcm9Pb1R6NVlIOTF6VGNUZnpjYXhnWkVLU2xFZkt2QXJoYWZWbnJp?=
 =?utf-8?B?VUEwd2FtOFplQlpWVEZvMDR4czV6TVlFYXRyUURoQXdPVDlPVFRIb0duRWxD?=
 =?utf-8?B?SlVqTHROd3FJaTVoMk1iZ1ZybnhEbFBXeCt1bHh4OEtqZkxGRHhON2VpSHlh?=
 =?utf-8?B?a3lZb2FpT0t3Mi9zVjQxblhQR2xlWmR2ZUxYZFBxUWcrOCtVVEdQOHU0by90?=
 =?utf-8?B?ODVRMjAwc1Uxbk1wNUo2VDlvZ0l2OW94SnJYUG1OeGpUSTRHck8wZXhKMWY2?=
 =?utf-8?B?N2laU0V5V0hHcm9uV2paRlgvdEZ6RnZqUFhOaEZCNE9OWklpY0NsN05HVWV4?=
 =?utf-8?B?MVNMdXQ5S2xnc1E2dk1wcDNPQ0xhS2l0MTFFN2JON3FUWUdMdTVlM3Roc0pO?=
 =?utf-8?B?bVJha2tSYTFvUittdmQ5eU9WQW16QmxqTm93SVkvVVFZZVVpZWN1WGt3VHJF?=
 =?utf-8?B?SEZNcEFiRTdOMGdoVmRwd3ZGNVNpSmhoRnMxQWp0UWpGQjEwMVhkR2hlTjNy?=
 =?utf-8?B?SElwQ04rTFNaUDcxdG94bzAxYmcxc0lseGlOV2dmSXpPTkxBa2MyeThCcmR0?=
 =?utf-8?B?dzRHR21pM0E2cEhkTUhVd0VhOWw4ci9uL29FeHBGNjd2SXpVUERWZXBVbzll?=
 =?utf-8?B?QlVLUkVTaVZuZnZQaGdaYUdBcEhVZEpiUG81ck4yMW5CR3ZIbWZaYmIvK0VT?=
 =?utf-8?B?eXFZcHYzTjg3a2lOV0I0eEZnemx4WlRGZ09jMDRkWHk1bkdBSVVibXI1Z0Fh?=
 =?utf-8?B?SWczb25EYTR1VG5NRFNSazFabXRZWkRUdTF3TnpYcUpVTWNDOE5YTTd3OVQ3?=
 =?utf-8?B?SCtzOHI0L3RZME1oaGlVYThjV01lZnY0Q2hJNkIwa0c3NG1iOENGc3hnU0Nv?=
 =?utf-8?B?YUdMQzZmYUU5Q3o2bUZPcGROdFZxS05MWTlvc0pOcjUvQTFVTFdRaklzaXFO?=
 =?utf-8?B?ZmRTZ0tOemFQRlhONWc3bUNXZ0hzMG1wTVFDbk1yMjFDbDBEK2RLcThrN2pK?=
 =?utf-8?B?MzhleTVXdjlEa3Qxa3RjYldaTk1ZSW1mTmszTnJvemx0ZlJ4TnRRL0JyQkxG?=
 =?utf-8?B?bUpIVlNTVXBWNC9PN3ZmWWM2WHhjMEJ1d0pvdlV6L3pMQlc5NmJVd28vaHpi?=
 =?utf-8?B?RGJJWWszemFtWHBEUVU4UmNYWHVBVk9wZExRQzg3Ykg3SkFGS1dRN1VvODAz?=
 =?utf-8?B?MVVrT05udDhrNTlMRllmNTlxekpOOWhiMGJTRmZUUEwrMmZoaXhYYTVyN0l4?=
 =?utf-8?B?cjhDYiswUzlUaEVZbllIa3c4L3ZVSWZPNmEvQWszQUZjRlZGV1h5SUhrbkhZ?=
 =?utf-8?B?S2I0bURweGR3eHBpRFpNSzhlbm9RczJvc2ExTElkVzNWakxyNmM4T1VIekxT?=
 =?utf-8?B?N1hNc0N3R1VzRzdDamplWG41SVgxTlBWNDh5cWdwbTRBQ1lZeTlGZXU1cHRp?=
 =?utf-8?B?RkVVQXI0SDgwOGRoOVo5UVp2V1ZYUk5XVXU1alI5Z0syN2V5djc0WUlDRzdt?=
 =?utf-8?B?bFczVlJsQkNEa3hQNDI2WWZpWUpUajFQcUtDR2hXVnJBb3pGa1dFdE4vNUxC?=
 =?utf-8?B?TjVoSU91RFdPMXJKTWVMMEpWSXhRaWp4T0x0YmIwaGVyVW1NRHRaM3NxOTA0?=
 =?utf-8?B?U0xCQUp2eGdwNS9BbWlzSWFHMlNzelI1aDI0TkV1WmFIdXVLdXk0V3dZeUtL?=
 =?utf-8?B?dDZTTStZZnpibmxxUHlHUXpCcUJHUFg2K1NydFdBZnZCZEFDT3ZMUDQwL3d6?=
 =?utf-8?B?dTRqckpTK2tmMjJzRUJtbUJMSU1FSTkweFpkbTdkVUJ4VkY4RG5ndz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcc32a4-b6cc-4c1a-4744-08de8079abe6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:55:19.7887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqWxOlYeX1c1kZbD6vVhY66XmcTszYjlmcYNayJlMb7cWpNV5WbjNsi419o+TZJ9qrOFNwVF/nwEuTFoR0UsFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528

On 3/12/2026 12:42 PM, Dan Williams wrote:
> Koralahalli Channabasappa, Smita wrote:
> [..]
>>> "do not teardown auto regions" should squash this crop of setup bugs.
>>
>> Looking at this more closely for patch 2, if I'm not wrong, I think the
>> problem is that cxl_setup_hdm_decoder_from_dvsec() is not setting up the
>> interleave_granularity on the decoder. It inherits the default PAGE_SIZE
>> (4096) from cxl_decoder_init(), and construct_region() then copies that
>> stale value into the region params.
>>
>> So even in a DVSEC emulation case, the IG would be whatever
>> cxl_decoder_init() defaulted to, not what the actual configuration is right?
> 
> Remember that CXL 1.1 DVSEC range registers do not support interleave.
> Interleaving was a CXL 2.0 feature.
> 
> So in the case where HDM decoders are actually disabled and DVSEC Range
> registers are sufficient, the bug is in cxl_port_setup_targets().
> Specifically, when interleave_ways == 1 then interleave_granularity does
> not matter. It is ok for CFMWS and the region granularity numbers to
> mismatch in that case.
> 
> So I would not expect that ig mismatch matters after:
> 
> ce32b0c9c522 cxl: core/region - ignore interleave granularity when ways=1
> 
> ...did that miss an additional location where we are doing granularity
> checks?

What's actually triggering my error is likely the disabled decoder flag. 
The log shows:

[] cxl region0: pci0000:e0:port1 cxl_port_setup_targets expected iw: 1 
ig: 4096 [mem 0x850000000-0x284fffffff flags 0x200]
[] cxl region0: pci0000:e0:port1 cxl_port_setup_targets got iw: 1 ig: 
256 state: disabled 0x850000000:0x284fffffff

The decoder is in disabled state because cxl_decoder_reset() clears 
CXL_DECODER_F_ENABLE during region teardown.

So ce32b0c9c522 is handling the IG issue correctly and Im probably 
hitting failing condition with the disabled flag. I will spend some more 
time confirming this.

> 
>> Is the second patch about fixing cxl_setup_hdm_decoder_from_dvsec() to
>> properly set the interleave granularity?
> 
> I would say just clean up the changelog per the feedback and we can
> start a separate thread to fixup DVSEC support.
> 
> With the suggested changelog updates you can also add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Sure thanks on this. I will send out v2 just with these changes and 
rewriting the commit message.

Thanks
Smita

