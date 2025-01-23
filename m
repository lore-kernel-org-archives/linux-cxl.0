Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AA66CDAF
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652849; cv=fail; b=CLyNaR8qO3IgYKoX+RQdumc2+y2FvqgjOoSHaXpmrnNPiMruqKnLIaSsuFEtp9XcP236fihpsFEkP8JLFkEAkS9XIHH2+mP/uKtVcWGu65U/3aleLOwsVlNl060WMgGzsTrYnjf9aqI9XLOK18RN1RAE+w9stA2LNAMEYJ3akh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652849; c=relaxed/simple;
	bh=RpA71tyKoOrydWGwMY+hFLyIRhfSzecI+Uq7LUT9Hsc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UBSe0wvuw5quqNFKgAqI567kqTJLxdmP9tkz00ykwKDkrhajk15zpsHJ6rqRTGRJWswEd4FtqLp5gKccBw1c7senv/24TtF8g/fe3fZTFWN2VkGx9MRhBofS+83gdG4ZpRTypHInNw/dXaFU9KbQLBmsUA/G5hbLVFg0aYOS8gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PoPAM/bp; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PoPAM/bp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AISke97gjY1K5/wOswDKgtix5xLQgAMJAET5JQknMu6qmsUJmnznnDSZFItChPxCXMYUhBCzScbMnf0etf9sgsSA1CSyWpkU/ZKuQhzmEApU/kOt7E7Oht4rOziE3ck9WZgo6SEqfXAw3+xSABNel26tc1QWYKLEX6LmZjfQ5k5U8mRxwDziAiKY8ubtNbhDwDw7hcBlE2k7cSO6E0IOp94AdBD5paXFeX+4AVns7sb9qfyqLLXg8+9ZN8YaQPOeJVvlbNN5qWciZM95L74D1ZEVOpR88W9MgKaZNGdXdZ2B+nu2qrR+loqD+4rn6qxWZpt6SYKKBL9olUXpQNJ0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4l80jMRzr4LiFw5+gGAqpuBYSYnMYtTXY7jEbXpyBY=;
 b=OjtSU9CsL48pL7nILbWq0hy4n+hvim6Gce6wS0yuVzjVrHx5SZdiwu75NlTw/N5kd0cvdYDGGmtaAlzQce8psXTcRGT0JlW4PptQ56E0x8rjfY019b4D1LfQ4eoLOZKr+fgWcs3quPb/drGzqo2fBNvhdLIwMwM4c62VI+OiTHnE7Eu+8aQWkvrfsILNI2gy+qY4A9/T3ArHdiLtmOlMSqwhSLrIuwNIZlKxhMFv0VLlvGe8DqGEKk/5GJ031AGwbRS7RgGEbU0ae9coXnGlZB1L7vPvxD/u5695GfQv0r+dzIKivJS+/EtJ74aczvo0qy88I8PTcCOwMVhFWDdJRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4l80jMRzr4LiFw5+gGAqpuBYSYnMYtTXY7jEbXpyBY=;
 b=PoPAM/bphXlgJ+ogCf35hLLJOHjZBzAM7jbjwOqhTxNSzxmQeiSTWbZd9+zomeuGBpDTYryWtSurDvro723e0vS1S6efufn/OpfET2ntLr5psU8tq+OXyrasNnhN+wDQ5Y1Nw/Qa56XHUsbnI09IvRudYmioXJAfFbFBUsTH85Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Thu, 23 Jan
 2025 17:20:44 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 17:20:44 +0000
Message-ID: <8550f618-3934-c671-c1bc-30bbdb56ac3b@amd.com>
Date: Thu, 23 Jan 2025 17:20:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 5/5] cxl: Kill enum cxl_decoder_mode
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan.Cameron@huawei.com
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753637863.3849855.16067432468334597297.stgit@dwillia2-xfh.jf.intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <173753637863.3849855.16067432468334597297.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0346.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::29) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH8PR12MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 22bd704d-08de-474f-7a9e-08dd3bd24504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzIvYUw3SVJTcm1OZWlobk5SY3ZXWnJoOEt2OXVWczZaV284QkdnQWtMazBL?=
 =?utf-8?B?dmlZWlV5QlcrVzVQODRLSnN5RVdoc0Qrczhkd2E1ME1xZDg1WUZXS2orNWZl?=
 =?utf-8?B?OUgvdTFmdlY1YmJsallCMXo0cDZLem42SmtEbWNXODhIQzBiREc5SXVtb0JX?=
 =?utf-8?B?UlRydXc0Mi9MY28xdlRGVVhLTVVmR0JzdEMwNHFDSFZPLzJZYTNOcWtMUy9w?=
 =?utf-8?B?VFMxcFYzNTBNQk10WTY0OEhqUHBiUGZDNEFGNUJCQVozajIvVTVMdytTaFhI?=
 =?utf-8?B?Nlp6MnA4czZtU1pPMU1saEpWSnhHRU1Dcy9vOWdVMlk2RjRzK0h4OE1URy9O?=
 =?utf-8?B?MFQvRFRBY0Q4cGNYYVVXWGJ1eXBaUnJFZU1jb0lkWjUrY29ia1QzQzZQcUZ3?=
 =?utf-8?B?YjZYTXIrbEhLV0xmL1BCSUpZVHIrK0ppMDNCeFBsdjdYK29PK0xNQzYrOTUx?=
 =?utf-8?B?a0RObFRSMy81dEt6c3JJdFdQNDg0MXNIRWltTFlCVlBaREdvSnFBbVhPcTdl?=
 =?utf-8?B?UjdEMmZsajl2emZhK2Q4b1JzTVM4TkxoaXUrcWorMDZEelJtNjdnelB2V21B?=
 =?utf-8?B?NzdLdmZtMGYzV3dOcDh5dDFXQWoycnM0NFFxOTdXK2RoY2cwcHZjS0Z3UXdQ?=
 =?utf-8?B?dHlCeHZjejJKSzh0UDVVelRJL3VXYkhlNzhMa2s4Mllnb0ljUjhvbjNRMStQ?=
 =?utf-8?B?aG9DQWdFUmx3ZzZIbkZZSWdYWEJTTEIxc1pnb1JwTXZ0T0x6bGhpN05YT0RV?=
 =?utf-8?B?OVBEaHA0MUM3b2dZRkZWNTh4MWJnTGdjYnNDYmNDV2VHUE80c3oxMmpYMXFC?=
 =?utf-8?B?UVhqWnA0WkdaTnpLTHkzYWkzRVRab0s3N2ZBbmw5MXR3clE0NlpQTFhnaE4w?=
 =?utf-8?B?THdiSDgxSTFwZkd2Rk5YTFFJcGxhME0wNWswcGhCbGdnaGpHT2hMdTBiNllj?=
 =?utf-8?B?bGdVRE1qeXhlMVZPYWJoa0dNSDhSR2IyR0p2dHROS2k1YURhV1J4SHRScEw5?=
 =?utf-8?B?U09HaSt4RDlzSWtPUEZrdWNlVytXL1NKMW03S1hYOWM2SjU5cUlobzNhajRE?=
 =?utf-8?B?ekkraktuMnhobEdCNlVnVXJsVzJMOUdnZVRCbEthZERxaUNoMDRTYk1QeHhD?=
 =?utf-8?B?TDMwcVF4UlZ1ci9yNlk5bzRYUk5qUUZPT05wenZ5WnFnZGhCYnN6dFgvajdW?=
 =?utf-8?B?RkgxaFU3L3VIa1FtRjVKZmh3OWhTNE56bUQ3QjgvT0JZUXdEaEl0a2J5MEMw?=
 =?utf-8?B?a2gvWVFoaXJ6TFdGNlBoUHFkV2tZT1ZiTUdod3pNb0pnRTFKekwyUGliajBC?=
 =?utf-8?B?RjZwdEVKZUszUlJ0eDZZODIvUzVLVHdkcS9WQjVGN3MyOTFoU0RiSC9pMjlW?=
 =?utf-8?B?MGJhY3p0blh3TU9jT2NsTFI0YlpYWmt2bXJyOWNTS1FaU2lGR3RQS04xZjlJ?=
 =?utf-8?B?NjVDelJxZW5wMXEzRlV3c3JXUHpjRllGc0o5ZVpNQ3U5K1Z4RFNvOTN1WUd3?=
 =?utf-8?B?R2Y5RVhzcGpSc1lCUkJ6ZUZnc1lsL3RTTFRWdXh2d24vUjAwTmdDODZTK2RG?=
 =?utf-8?B?N0JNMHg3aUtTT1EzV2dVMHlZU01ieHQza1h3NXV3OWU4aW4zeG9VTGJLbk1m?=
 =?utf-8?B?NE9aMlFTV0YyakpLL0ovWXVNcjdrZnRUTS85Q292bENvS0I1OGN5WXVpVkxu?=
 =?utf-8?B?M0ExZm04a1JXclhscDNaaGdiL1ZVTHJDTURGM0hvV2NwQTVTVzhPMXdyYTRp?=
 =?utf-8?B?Rjh3U1EzU043Q3EzWHltOUpoMGh5ckhLS2JGZHNuak4zN0QzejJKY2I2VG9D?=
 =?utf-8?B?WktPN1dLejBCbXpqbTZwUjdMei9nTHRBMWlTZW5RZFVTdzlaTW1FUXFzc3Zu?=
 =?utf-8?Q?R4TYAUHQhfhQr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2o2bXZFOVplcWxycXVGNWl4c25zTjlXb3JBQ3RoNlNMaFVpYlo2NnZub2Vh?=
 =?utf-8?B?R1ZIR1YxSGlGYitVeFhac0Rac0dCME9KUzJwV3VlNlBFdDBHVjlqaEdycUtj?=
 =?utf-8?B?N0NiT3laL1JoNk54QVh6UndoNnlIai9TTDdZd1E3UHFOU081b090VTV6RjNL?=
 =?utf-8?B?U01vZUdOSkpmQlJ3TDdTR1dUbkFMYWR6VjVETzZvNGZSbjNMS25WeEZERVVB?=
 =?utf-8?B?MXRZMHlOWE1XUVFjWHRjc1RNajZWaXFrd0RzMStscEU3OTY3QkZYUXh6TWdt?=
 =?utf-8?B?VmFyWHNpMHVSaGc3TEdHVFFtSDJVUWkxdlVobC9sbk1BMVlYUGFkbHpPQnAr?=
 =?utf-8?B?QVZsak1iWHFVTGR0OExrcEtKOVlPNHhoUm9IVkJBZnZRSkZOdUZ4dU5Ba0p1?=
 =?utf-8?B?dnpNdlRkUVc0MUxRTzFkZjJWNkFjMmhZVVh5cnVlWEZaMzhsS3JoSXJiVjF4?=
 =?utf-8?B?VmxqVGZWOElTN3ZGWGxBUmVoczlTQU9walR3TWxFZVVQaklJSm1oUlN0K2ha?=
 =?utf-8?B?NU5iVmRPc01WN3p5MlQ5b21tZ0J3bjg1MHpCYVU3K0Y1TlVTZXA5NFVWY2oz?=
 =?utf-8?B?d1RvVWl3M0c4N3ZPMm1BOGw0Q2lrZ1J2R2Y4YkR0YVNDUXN3NEFxQmRORlQ3?=
 =?utf-8?B?OFZ2WkdLdWFjRkpNamNLVTNMbTROZG1jZjBMbE96cXBMaFpHVGcyWEpGR0Yw?=
 =?utf-8?B?SkRmdzJnS21lblRGYXNvTE9ZNkxkYjltU3dtVUk5SGU3TCtGRXNNWGhMUlhC?=
 =?utf-8?B?RWFpclBQNVU5Y25ob1VtQXBrL21peW1QVndvTUtrYWJlTEtmeHczS3JmOW51?=
 =?utf-8?B?eVJ3TmNVUkpod0xkamlIcXRrK0lHZXBhZVBVWWh6b2dKTDZMV3JHdHhvVHRR?=
 =?utf-8?B?WjZXSmxIWnF4VHhHNHpiaHI1N3gxWW84MWZ5ak5YcjZTMmdYQWJxUUV2YkpB?=
 =?utf-8?B?aVh1TjZteXZRK3Q5U1FkV01IOWUvWm1ZcDl1cHZHdHBKemFva05LaUdEU0d5?=
 =?utf-8?B?MEZOUkFQZHJxeElKVEliWjMybUZwb2xTTmZQQWhaTkJQUzJPZEpCc211TjJG?=
 =?utf-8?B?UnRLclFnQnBFUGVDZzEyWEo5a2R5MUdjMlNBRUtxQUZTMGFpWGNQcDBHUzlY?=
 =?utf-8?B?YWxiVTU1azBNSHgvaEFDTURpcGpsVFFEWmxrWElSS1VLb0RFVFgydnF5NFNX?=
 =?utf-8?B?YlFsWUJocjB3eURoNFM3cmhvTWp0ZHdCQVBlbWJrdlgzZ0QzYUVHSThXOUli?=
 =?utf-8?B?aGtWV3I3L3JzS0hMVGdxQ2tRdUs5bVhUcEh1YWJ3aStJaFJPMndwdzN3YVhN?=
 =?utf-8?B?QVNobTRmL0dOdm1kR0VicXVYcVBLeHAxa1RYUFRzekdyNHBsekZaRHVHbW1i?=
 =?utf-8?B?cXdkQVRQTS9EZmZWN0pOZm9MblFmYVlhaDIvME91MlJNa3ZTVFFNMHIvNWlq?=
 =?utf-8?B?eUM0WGtYTzBiN2JzRk9IUWI5d3RpM1o5VGNFdXppNnVKU0wwazlYaVdaNHNI?=
 =?utf-8?B?MzVqRkgvVkUyczhEV2syN0VFQ0NxcXhIY25MeVR3ZmptL2hKYU5lQWNPZy81?=
 =?utf-8?B?UEZOYWd0K29HNGRoaVBhcm0wbDhVSUUvd2orQ1hPMTRlSFhpeis3YUs2Y1Bh?=
 =?utf-8?B?TnZqUmNqVGNCak1FcFJNQXBvWHVGaDcrWm1QYUV1RXNHamxrTGJjRzc1dGJF?=
 =?utf-8?B?eWcyNDB5Y3J4TnAwRzVsdVlETGlPL2xYR0o0ZmRMRTZlQTBTTlVRTEFDQmQ1?=
 =?utf-8?B?ajZPZkppSVZ5TVEyeEZCQnd1cEhUblo1eHhCbTNOSnhsaHFWWU9yK3JUOGw2?=
 =?utf-8?B?SmRza2JRazhaQ3JsOW9odjhqbkY5cFh4RDM5dW5wWGJ5T2JrN2ZsUzMwbXg0?=
 =?utf-8?B?NzNWV2ViNHRCOS9HWWpUaXQzK1JCNkRwNUhlWlFaZnl3L0F4dkxBN0d0WlVG?=
 =?utf-8?B?SEQxVHQrTWRnd09QTi92bG9Tc0ZHNlFlQldubStYbFc0VVVVZk5ORGU5Zml2?=
 =?utf-8?B?bHIrRXNjM2ltUHA2K0daQXRRSEpndDE2ay9PNFd4VmxxSUplK1c2UXNyR3NE?=
 =?utf-8?B?aGpHbGsyNW8xRFFEUGpFM1cyMTRMYkJSVjRwVkgxVlNvQVVLOUdqTjkvMzdu?=
 =?utf-8?Q?MT0h3T4OfkljLkcsZKD4Y+0VQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22bd704d-08de-474f-7a9e-08dd3bd24504
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 17:20:44.5978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /j6F9dAS0zpDAkSKFDwDSjsrxBWWCIKgQSBLNpd4I17DDfgQ2ja7MRFr2AEln2xOD+mxqS0BcObBgorZ9pTnyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890


On 1/22/25 08:59, Dan Williams wrote:
> Now that the operational mode of DPA capacity (ram vs pmem... etc) is
> tracked in the partition, and no code paths have dependencies on the
> mode implying the partition index, the ambiguous 'enum cxl_decoder_mode'
> can be cleaned up, specifically this ambiguity on whether the operation
> mode implied anything about the partition order.
>
> Endpoint decoders simply reference their assigned partition where the
> operational mode can be retrieved as partition mode.
>
> With this in place PMEM can now be partition0 which happens today when
> the RAM capacity size is zero. Dynamic RAM can appear above PMEM when
> DCD arrives, etc. Code sequences that hard coded the "PMEM after RAM"
> assumption can now just iterate partitions and consult the partition
> mode after the fact.
>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>


Reviewed-by: Alejandro Lucero <alucerop@amd.com>


> ---
>   drivers/cxl/core/cdat.c   |   21 ++-----
>   drivers/cxl/core/core.h   |    4 +
>   drivers/cxl/core/hdm.c    |   64 +++++++----------------
>   drivers/cxl/core/memdev.c |   15 +----
>   drivers/cxl/core/port.c   |   20 +++++--
>   drivers/cxl/core/region.c |  128 +++++++++++++++++++++++++--------------------
>   drivers/cxl/cxl.h         |   38 ++++---------
>   drivers/cxl/cxlmem.h      |   20 -------
>   8 files changed, 127 insertions(+), 183 deletions(-)
>
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 5400a421ad30..ca7fb2b182ed 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -571,29 +571,18 @@ static bool dpa_perf_contains(struct cxl_dpa_perf *perf,
>   		.end = dpa_res->end,
>   	};
>   
> -	if (!perf)
> -		return false;
> -
>   	return range_contains(&perf->dpa_range, &dpa);
>   }
>   
> -static struct cxl_dpa_perf *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxled,
> -					       enum cxl_decoder_mode mode)
> +static struct cxl_dpa_perf *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxled)
>   {
>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct cxl_dpa_perf *perf;
>   
> -	switch (mode) {
> -	case CXL_DECODER_RAM:
> -		perf = to_ram_perf(cxlds);
> -		break;
> -	case CXL_DECODER_PMEM:
> -		perf = to_pmem_perf(cxlds);
> -		break;
> -	default:
> +	if (cxled->part < 0)
>   		return ERR_PTR(-EINVAL);
> -	}
> +	perf = &cxlds->part[cxled->part].perf;
>   
>   	if (!dpa_perf_contains(perf, cxled->dpa_res))
>   		return ERR_PTR(-EINVAL);
> @@ -654,7 +643,7 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
>   	if (cxlds->rcd)
>   		return -ENODEV;
>   
> -	perf = cxled_get_dpa_perf(cxled, cxlr->mode);
> +	perf = cxled_get_dpa_perf(cxled);
>   	if (IS_ERR(perf))
>   		return PTR_ERR(perf);
>   
> @@ -1060,7 +1049,7 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>   
>   	lockdep_assert_held(&cxl_dpa_rwsem);
>   
> -	perf = cxled_get_dpa_perf(cxled, cxlr->mode);
> +	perf = cxled_get_dpa_perf(cxled);
>   	if (IS_ERR(perf))
>   		return;
>   
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 800466f96a68..22dac79c5192 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -72,8 +72,8 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>   				   resource_size_t length);
>   
>   struct dentry *cxl_debugfs_create_dir(const char *dir);
> -int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> -		     enum cxl_decoder_mode mode);
> +int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
> +		     enum cxl_partition_mode mode);
>   int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size);
>   int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>   resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 591aeb26c9e1..bb478e7b12f6 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -374,7 +374,6 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>   	struct cxl_port *port = cxled_to_port(cxled);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct device *dev = &port->dev;
> -	enum cxl_decoder_mode mode;
>   	struct resource *res;
>   	int rc;
>   
> @@ -421,18 +420,6 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>   	cxled->dpa_res = res;
>   	cxled->skip = skipped;
>   
> -	mode = CXL_DECODER_NONE;
> -	for (int i = 0; cxlds->nr_partitions; i++)
> -		if (resource_contains(&cxlds->part[i].res, res)) {
> -			mode = cxl_part_mode(cxlds->part[i].mode);
> -			break;
> -		}
> -
> -	if (mode == CXL_DECODER_NONE)
> -		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
> -			 port->id, cxled->cxld.id, res);
> -	cxled->mode = mode;
> -
>   	port->hdm_end++;
>   	get_device(&cxled->cxld.dev);
>   	return 0;
> @@ -585,40 +572,36 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>   	return rc;
>   }
>   
> -int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> -		     enum cxl_decoder_mode mode)
> +int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
> +		     enum cxl_partition_mode mode)
>   {
>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct device *dev = &cxled->cxld.dev;
> -
> -	switch (mode) {
> -	case CXL_DECODER_RAM:
> -	case CXL_DECODER_PMEM:
> -		break;
> -	default:
> -		dev_dbg(dev, "unsupported mode: %d\n", mode);
> -		return -EINVAL;
> -	}
> +	int part;
>   
>   	guard(rwsem_write)(&cxl_dpa_rwsem);
>   	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
>   		return -EBUSY;
>   
> -	/*
> -	 * Only allow modes that are supported by the current partition
> -	 * configuration
> -	 */
> -	if (mode == CXL_DECODER_PMEM && !cxl_pmem_size(cxlds)) {
> -		dev_dbg(dev, "no available pmem capacity\n");
> -		return -ENXIO;
> +	part = -1;
> +	for (int i = 0; i < cxlds->nr_partitions; i++)
> +		if (cxlds->part[i].mode == mode) {
> +			part = i;
> +			break;
> +		}
> +
> +	if (part < 0) {
> +		dev_dbg(dev, "unsupported mode: %d\n", mode);
> +		return -EINVAL;
>   	}
> -	if (mode == CXL_DECODER_RAM && !cxl_ram_size(cxlds)) {
> -		dev_dbg(dev, "no available ram capacity\n");
> +
> +	if (!resource_size(&cxlds->part[part].res)) {
> +		dev_dbg(dev, "no available capacity for mode: %d\n", mode);
>   		return -ENXIO;
>   	}
>   
> -	cxled->mode = mode;
> +	cxled->part = part;
>   	return 0;
>   }
>   
> @@ -647,16 +630,9 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>   		goto out;
>   	}
>   
> -	part = -1;
> -	for (int i = 0; i < cxlds->nr_partitions; i++) {
> -		if (cxled->mode == cxl_part_mode(cxlds->part[i].mode)) {
> -			part = i;
> -			break;
> -		}
> -	}
> -
> +	part = cxled->part;
>   	if (part < 0) {
> -		dev_dbg(dev, "partition %d not found\n", part);
> +		dev_dbg(dev, "partition not set\n");
>   		rc = -EBUSY;
>   		goto out;
>   	}
> @@ -697,7 +673,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>   
>   	if (size > avail) {
>   		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
> -			cxl_decoder_mode_name(cxled->mode), &avail);
> +			res->name, &avail);
>   		rc = -ENOSPC;
>   		goto out;
>   	}
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index be0eb57086e1..615cbd861f66 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -198,17 +198,8 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>   	int rc = 0;
>   
>   	/* CXL 3.0 Spec 8.2.9.8.4.1 Separate pmem and ram poison requests */
> -	if (cxl_pmem_size(cxlds)) {
> -		const struct resource *res = to_pmem_res(cxlds);
> -
> -		offset = res->start;
> -		length = resource_size(res);
> -		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> -		if (rc)
> -			return rc;
> -	}
> -	if (cxl_ram_size(cxlds)) {
> -		const struct resource *res = to_ram_res(cxlds);
> +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> +		const struct resource *res = &cxlds->part[i].res;
>   
>   		offset = res->start;
>   		length = resource_size(res);
> @@ -217,7 +208,7 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>   		 * Invalid Physical Address is not an error for
>   		 * volatile addresses. Device support is optional.
>   		 */
> -		if (rc == -EFAULT)
> +		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
>   			rc = 0;
>   	}
>   	return rc;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 78a5c2c25982..f5f2701c8771 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -194,25 +194,35 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
>   			 char *buf)
>   {
>   	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	/* without @cxl_dpa_rwsem, make sure @part is not reloaded */
> +	int part = READ_ONCE(cxled->part);
> +	const char *desc;
> +
> +	if (part < 0)
> +		desc = "none";
> +	else
> +		desc = cxlds->part[part].res.name;
>   
> -	return sysfs_emit(buf, "%s\n", cxl_decoder_mode_name(cxled->mode));
> +	return sysfs_emit(buf, "%s\n", desc);
>   }
>   
>   static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
>   			  const char *buf, size_t len)
>   {
>   	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
> -	enum cxl_decoder_mode mode;
> +	enum cxl_partition_mode mode;
>   	ssize_t rc;
>   
>   	if (sysfs_streq(buf, "pmem"))
> -		mode = CXL_DECODER_PMEM;
> +		mode = CXL_PARTMODE_PMEM;
>   	else if (sysfs_streq(buf, "ram"))
> -		mode = CXL_DECODER_RAM;
> +		mode = CXL_PARTMODE_RAM;
>   	else
>   		return -EINVAL;
>   
> -	rc = cxl_dpa_set_mode(cxled, mode);
> +	rc = cxl_dpa_set_part(cxled, mode);
>   	if (rc)
>   		return rc;
>   
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 9f0f6fdbc841..83b985d2ba76 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -144,7 +144,7 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
>   	rc = down_read_interruptible(&cxl_region_rwsem);
>   	if (rc)
>   		return rc;
> -	if (cxlr->mode != CXL_DECODER_PMEM)
> +	if (cxlr->mode != CXL_PARTMODE_PMEM)
>   		rc = sysfs_emit(buf, "\n");
>   	else
>   		rc = sysfs_emit(buf, "%pUb\n", &p->uuid);
> @@ -441,7 +441,7 @@ static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
>   	 * Support tooling that expects to find a 'uuid' attribute for all
>   	 * regions regardless of mode.
>   	 */
> -	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_DECODER_PMEM)
> +	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_PARTMODE_PMEM)
>   		return 0444;
>   	return a->mode;
>   }
> @@ -603,8 +603,16 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
>   			 char *buf)
>   {
>   	struct cxl_region *cxlr = to_cxl_region(dev);
> +	const char *desc;
>   
> -	return sysfs_emit(buf, "%s\n", cxl_decoder_mode_name(cxlr->mode));
> +	if (cxlr->mode == CXL_PARTMODE_RAM)
> +		desc = "ram";
> +	else if (cxlr->mode == CXL_PARTMODE_PMEM)
> +		desc = "pmem";
> +	else
> +		desc = "";
> +
> +	return sysfs_emit(buf, "%s\n", desc);
>   }
>   static DEVICE_ATTR_RO(mode);
>   
> @@ -630,7 +638,7 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>   
>   	/* ways, granularity and uuid (if PMEM) need to be set before HPA */
>   	if (!p->interleave_ways || !p->interleave_granularity ||
> -	    (cxlr->mode == CXL_DECODER_PMEM && uuid_is_null(&p->uuid)))
> +	    (cxlr->mode == CXL_PARTMODE_PMEM && uuid_is_null(&p->uuid)))
>   		return -ENXIO;
>   
>   	div64_u64_rem(size, (u64)SZ_256M * p->interleave_ways, &remainder);
> @@ -1875,6 +1883,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>   {
>   	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct cxl_region_params *p = &cxlr->params;
>   	struct cxl_port *ep_port, *root_port;
>   	struct cxl_dport *dport;
> @@ -1889,17 +1898,17 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>   		return rc;
>   	}
>   
> -	if (cxled->mode != cxlr->mode) {
> -		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
> -			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
> -		return -EINVAL;
> -	}
> -
> -	if (cxled->mode == CXL_DECODER_DEAD) {
> +	if (cxled->part < 0) {
>   		dev_dbg(&cxlr->dev, "%s dead\n", dev_name(&cxled->cxld.dev));
>   		return -ENODEV;
>   	}
>   
> +	if (cxlds->part[cxled->part].mode != cxlr->mode) {
> +		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch\n",
> +			dev_name(&cxled->cxld.dev), cxlr->mode);
> +		return -EINVAL;
> +	}
> +
>   	/* all full of members, or interleave config not established? */
>   	if (p->state > CXL_CONFIG_INTERLEAVE_ACTIVE) {
>   		dev_dbg(&cxlr->dev, "region already active\n");
> @@ -2102,7 +2111,7 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>   void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>   {
>   	down_write(&cxl_region_rwsem);
> -	cxled->mode = CXL_DECODER_DEAD;
> +	cxled->part = -1;
>   	cxl_region_detach(cxled);
>   	up_write(&cxl_region_rwsem);
>   }
> @@ -2458,7 +2467,7 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
>    */
>   static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>   					      int id,
> -					      enum cxl_decoder_mode mode,
> +					      enum cxl_partition_mode mode,
>   					      enum cxl_decoder_type type)
>   {
>   	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
> @@ -2512,13 +2521,13 @@ static ssize_t create_ram_region_show(struct device *dev,
>   }
>   
>   static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
> -					  enum cxl_decoder_mode mode, int id)
> +					  enum cxl_partition_mode mode, int id)
>   {
>   	int rc;
>   
>   	switch (mode) {
> -	case CXL_DECODER_RAM:
> -	case CXL_DECODER_PMEM:
> +	case CXL_PARTMODE_RAM:
> +	case CXL_PARTMODE_PMEM:
>   		break;
>   	default:
>   		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
> @@ -2538,7 +2547,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>   }
>   
>   static ssize_t create_region_store(struct device *dev, const char *buf,
> -				   size_t len, enum cxl_decoder_mode mode)
> +				   size_t len, enum cxl_partition_mode mode)
>   {
>   	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
>   	struct cxl_region *cxlr;
> @@ -2559,7 +2568,7 @@ static ssize_t create_pmem_region_store(struct device *dev,
>   					struct device_attribute *attr,
>   					const char *buf, size_t len)
>   {
> -	return create_region_store(dev, buf, len, CXL_DECODER_PMEM);
> +	return create_region_store(dev, buf, len, CXL_PARTMODE_PMEM);
>   }
>   DEVICE_ATTR_RW(create_pmem_region);
>   
> @@ -2567,7 +2576,7 @@ static ssize_t create_ram_region_store(struct device *dev,
>   				       struct device_attribute *attr,
>   				       const char *buf, size_t len)
>   {
> -	return create_region_store(dev, buf, len, CXL_DECODER_RAM);
> +	return create_region_store(dev, buf, len, CXL_PARTMODE_RAM);
>   }
>   DEVICE_ATTR_RW(create_ram_region);
>   
> @@ -2665,7 +2674,7 @@ EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, "CXL");
>   
>   struct cxl_poison_context {
>   	struct cxl_port *port;
> -	enum cxl_decoder_mode mode;
> +	int part;
>   	u64 offset;
>   };
>   
> @@ -2673,49 +2682,45 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
>   				   struct cxl_poison_context *ctx)
>   {
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	const struct resource *res;
> +	struct resource *p, *last;
>   	u64 offset, length;
>   	int rc = 0;
>   
> +	if (ctx->part < 0)
> +		return 0;
> +
>   	/*
> -	 * Collect poison for the remaining unmapped resources
> -	 * after poison is collected by committed endpoints.
> -	 *
> -	 * Knowing that PMEM must always follow RAM, get poison
> -	 * for unmapped resources based on the last decoder's mode:
> -	 *	ram: scan remains of ram range, then any pmem range
> -	 *	pmem: scan remains of pmem range
> +	 * Collect poison for the remaining unmapped resources after
> +	 * poison is collected by committed endpoints decoders.
>   	 */
> -
> -	if (ctx->mode == CXL_DECODER_RAM) {
> -		offset = ctx->offset;
> -		length = cxl_ram_size(cxlds) - offset;
> +	for (int i = ctx->part; i < cxlds->nr_partitions; i++) {
> +		res = &cxlds->part[i].res;
> +		for (p = res->child, last = NULL; p; p = p->sibling)
> +			last = p;
> +		if (last)
> +			offset = last->end + 1;
> +		else
> +			offset = res->start;
> +		length = res->end - offset + 1;
> +		if (!length)
> +			break;
>   		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> -		if (rc == -EFAULT)
> -			rc = 0;
> +		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
> +			continue;
>   		if (rc)
> -			return rc;
> -	}
> -	if (ctx->mode == CXL_DECODER_PMEM) {
> -		offset = ctx->offset;
> -		length = resource_size(&cxlds->dpa_res) - offset;
> -		if (!length)
> -			return 0;
> -	} else if (cxl_pmem_size(cxlds)) {
> -		const struct resource *res = to_pmem_res(cxlds);
> -
> -		offset = res->start;
> -		length = resource_size(res);
> -	} else {
> -		return 0;
> +			break;
>   	}
>   
> -	return cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +	return rc;
>   }
>   
>   static int poison_by_decoder(struct device *dev, void *arg)
>   {
>   	struct cxl_poison_context *ctx = arg;
>   	struct cxl_endpoint_decoder *cxled;
> +	enum cxl_partition_mode mode;
> +	struct cxl_dev_state *cxlds;
>   	struct cxl_memdev *cxlmd;
>   	u64 offset, length;
>   	int rc = 0;
> @@ -2728,11 +2733,17 @@ static int poison_by_decoder(struct device *dev, void *arg)
>   		return rc;
>   
>   	cxlmd = cxled_to_memdev(cxled);
> +	cxlds = cxlmd->cxlds;
> +	if (cxled->part < 0)
> +		mode = CXL_PARTMODE_NONE;
> +	else
> +		mode = cxlds->part[cxled->part].mode;
> +
>   	if (cxled->skip) {
>   		offset = cxled->dpa_res->start - cxled->skip;
>   		length = cxled->skip;
>   		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> -		if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
> +		if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
>   			rc = 0;
>   		if (rc)
>   			return rc;
> @@ -2741,7 +2752,7 @@ static int poison_by_decoder(struct device *dev, void *arg)
>   	offset = cxled->dpa_res->start;
>   	length = cxled->dpa_res->end - offset + 1;
>   	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
> -	if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
> +	if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
>   		rc = 0;
>   	if (rc)
>   		return rc;
> @@ -2749,7 +2760,7 @@ static int poison_by_decoder(struct device *dev, void *arg)
>   	/* Iterate until commit_end is reached */
>   	if (cxled->cxld.id == ctx->port->commit_end) {
>   		ctx->offset = cxled->dpa_res->end + 1;
> -		ctx->mode = cxled->mode;
> +		ctx->part = cxled->part;
>   		return 1;
>   	}
>   
> @@ -2762,7 +2773,8 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
>   	int rc = 0;
>   
>   	ctx = (struct cxl_poison_context) {
> -		.port = port
> +		.port = port,
> +		.part = -1,
>   	};
>   
>   	rc = device_for_each_child(&port->dev, &ctx, poison_by_decoder);
> @@ -3206,14 +3218,18 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>   {
>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>   	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct range *hpa = &cxled->cxld.hpa_range;
> +	int rc, part = READ_ONCE(cxled->part);
>   	struct cxl_region_params *p;
>   	struct cxl_region *cxlr;
>   	struct resource *res;
> -	int rc;
> +
> +	if (part < 0)
> +		return ERR_PTR(-EBUSY);
>   
>   	do {
> -		cxlr = __create_region(cxlrd, cxled->mode,
> +		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
>   				       atomic_read(&cxlrd->region_id));
>   	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>   
> @@ -3416,9 +3432,9 @@ static int cxl_region_probe(struct device *dev)
>   		return rc;
>   
>   	switch (cxlr->mode) {
> -	case CXL_DECODER_PMEM:
> +	case CXL_PARTMODE_PMEM:
>   		return devm_cxl_add_pmem_region(cxlr);
> -	case CXL_DECODER_RAM:
> +	case CXL_PARTMODE_RAM:
>   		/*
>   		 * The region can not be manged by CXL if any portion of
>   		 * it is already online as 'System RAM'
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 4d0550367042..cb6f0b761b24 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -371,30 +371,6 @@ struct cxl_decoder {
>   	void (*reset)(struct cxl_decoder *cxld);
>   };
>   
> -/*
> - * CXL_DECODER_DEAD prevents endpoints from being reattached to regions
> - * while cxld_unregister() is running
> - */
> -enum cxl_decoder_mode {
> -	CXL_DECODER_NONE,
> -	CXL_DECODER_RAM,
> -	CXL_DECODER_PMEM,
> -	CXL_DECODER_DEAD,
> -};
> -
> -static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
> -{
> -	static const char * const names[] = {
> -		[CXL_DECODER_NONE] = "none",
> -		[CXL_DECODER_RAM] = "ram",
> -		[CXL_DECODER_PMEM] = "pmem",
> -	};
> -
> -	if (mode >= CXL_DECODER_NONE && mode < CXL_DECODER_DEAD)
> -		return names[mode];
> -	return "mixed";
> -}
> -
>   /*
>    * Track whether this decoder is reserved for region autodiscovery, or
>    * free for userspace provisioning.
> @@ -409,16 +385,16 @@ enum cxl_decoder_state {
>    * @cxld: base cxl_decoder_object
>    * @dpa_res: actively claimed DPA span of this decoder
>    * @skip: offset into @dpa_res where @cxld.hpa_range maps
> - * @mode: which memory type / access-mode-partition this decoder targets
>    * @state: autodiscovery state
> + * @part: partition index this decoder maps
>    * @pos: interleave position in @cxld.region
>    */
>   struct cxl_endpoint_decoder {
>   	struct cxl_decoder cxld;
>   	struct resource *dpa_res;
>   	resource_size_t skip;
> -	enum cxl_decoder_mode mode;
>   	enum cxl_decoder_state state;
> +	int part;
>   	int pos;
>   };
>   
> @@ -503,6 +479,12 @@ struct cxl_region_params {
>   	int nr_targets;
>   };
>   
> +enum cxl_partition_mode {
> +	CXL_PARTMODE_NONE,
> +	CXL_PARTMODE_RAM,
> +	CXL_PARTMODE_PMEM,
> +};
> +
>   /*
>    * Indicate whether this region has been assembled by autodetection or
>    * userspace assembly. Prevent endpoint decoders outside of automatic
> @@ -522,7 +504,7 @@ struct cxl_region_params {
>    * struct cxl_region - CXL region
>    * @dev: This region's device
>    * @id: This region's id. Id is globally unique across all regions
> - * @mode: Endpoint decoder allocation / access mode
> + * @mode: Operational mode of the mapped capacity
>    * @type: Endpoint decoder target type
>    * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
>    * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
> @@ -535,7 +517,7 @@ struct cxl_region_params {
>   struct cxl_region {
>   	struct device dev;
>   	int id;
> -	enum cxl_decoder_mode mode;
> +	enum cxl_partition_mode mode;
>   	enum cxl_decoder_type type;
>   	struct cxl_nvdimm_bridge *cxl_nvb;
>   	struct cxl_pmem_region *cxlr_pmem;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index bad99456e901..f218d43dec9f 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -97,12 +97,6 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>   			 resource_size_t base, resource_size_t len,
>   			 resource_size_t skipped);
>   
> -enum cxl_partition_mode {
> -	CXL_PARTMODE_NONE,
> -	CXL_PARTMODE_RAM,
> -	CXL_PARTMODE_PMEM,
> -};
> -
>   #define CXL_NR_PARTITIONS_MAX 2
>   
>   struct cxl_dpa_info {
> @@ -530,20 +524,6 @@ static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
>   	return resource_size(res);
>   }
>   
> -/*
> - * Translate the operational mode of memory capacity with the
> - * operational mode of a decoder
> - * TODO: kill 'enum cxl_decoder_mode' to obviate this helper
> - */
> -static inline enum cxl_decoder_mode cxl_part_mode(enum cxl_partition_mode mode)
> -{
> -	if (mode == CXL_PARTMODE_RAM)
> -		return CXL_DECODER_RAM;
> -	if (mode == CXL_PARTMODE_PMEM)
> -		return CXL_DECODER_PMEM;
> -	return CXL_DECODER_NONE;
> -}
> -
>   static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>   {
>   	return dev_get_drvdata(cxl_mbox->host);
>
