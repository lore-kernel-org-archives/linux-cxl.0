Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8841F03C8;
	Fri,  6 Dec 2024 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733473718; cv=fail; b=IBOaQa/UffxOQMzOjmvhdeBYrIv7ntUR4pcZNSJtEFsEJFsESzgtwVzZ6Qf5y+qqz16XMUXRz8FUhbcFY76gIneVZGZMvrYMUakDWi/bG1tlbnqM5Gv//Fkm7EOkqFSglS/jVTic4FWCpEdp96IPb7NXCgTmHEMxRe14h8E60I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733473718; c=relaxed/simple;
	bh=hyyAZXP3J068cYE2rbhIRTvwBbzX57TlnjV03T4aoHk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dVXcwj6Mdy2QGnjNrR6lngv0JlbvkrHxJoJgLIdAVWVd3tf+ZycXbbZXztYbuLUgSabwqp53Z3t79SSDAiQdqpbqVoPU7K1LXBXjsZmMqgeWhj464fRHXVdEHFsWmmgj/IOc+0CKsWbBlXF5wf38Um22aHZVUWrZMlg320olDeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tTt7tAo1; arc=fail smtp.client-ip=40.107.101.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tTt7tAo1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5EGOEQHS4cdMiN0upmTGwVBZOjiCj+fMuuiY+y0RKPREdabtwTcBcO1ugoqDCGZ8blRkOo/m02a2GR5o3OM6sY2/kI6Tp7vker00Hc3acXkiVT6MXggy+xsCSLopZD+Y/LQp8nOhJ+wV4w6FJhY0SYxp/DG8xJql9dC5RgvZFhVb0VUNmBaEGDpX3HvBQ6ff2E/0hgdWTr5kzCrWPJ1Dm09pA+wucKxdg/P9zmTRCJ0qQhO56/hOqHcDzABY8XuKYqy+FpIiL/Szljfa+516G661TAXKdsC1YZj448yCv9nhXFbOI3jxy5OxuIkUpy40Mas0adYbUu5KNClmSadVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmGqsIF9aEpfp8JxOCtAMjf1rYdVU836n0F+gClUSuI=;
 b=o068xikb/rqA8cb+zBIa8Me8xHA74N3tpHauTpurB6mokn28AqPmJWsWZgHhOcuDaOjudfEwiVej9Mt1/8EXXpZWdMBSZONjScPmBb+oSSOrXDtipWvP+yifLNkiEL8uuDO/bzm28pQFg3YragcZtRF45oP1t2V0AmwOkULLSytofYf8cbLY2KpqkjVfTWXrS7YxRUSvvUxo5bKDXWKHN4jlfSbHw4crTmSx3YZPG8QccRcMUxX70kIuXRcY96JMCnw0CIghyuwx8zKVhamEYDLcZ4kDR2I/DSOWX2F6v2g5cnlp91ESaAXRPFlA8D4sxym+q5UZpbzs8rbvbtHi5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmGqsIF9aEpfp8JxOCtAMjf1rYdVU836n0F+gClUSuI=;
 b=tTt7tAo14lWUpxvq7YytNsQF6YAfXP/1JCArEEU0YhRk8ntDJURAYjvwpNzshrb8uv+o+2w4yAwB86AYvqE2SLZQcTolEFEZ/J72eeKf0URziveNUUq9lvi5WnSfmaV6z8N291eRuHjvdqZ/VnLSKJjC/Vbfucli/SX1w6PWvoc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 08:28:34 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%4]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 08:28:34 +0000
Message-ID: <2b5bb8d8-6a7d-4a58-bde7-ce42d0a23f61@amd.com>
Date: Fri, 6 Dec 2024 13:58:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] resource: Fix CXL node not populated issue
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
Cc: bharata@amd.com, Huang Ying <ying.huang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>,
 ilpo.jarvinen@linux.intel.com,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Fontenot Nathan <Nathan.Fontenot@amd.com>, Wei Huang <wei.huang2@amd.com>,
 regressions@lists.linux.dev
References: <20241202111941.2636613-1-raghavendra.kt@amd.com>
 <674fd2b4942f1_3e0f629420@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <33b4b93b-5ab6-4a3b-b3b2-c9b3cbc9d929@amd.com>
 <6752acd92baf0_10a08329424@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <6752acd92baf0_10a08329424@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::35) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbf82fa-30e9-4b4d-a4b2-08dd15cff93d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVJyY3hxZmhpUitZbHhMMU5oc2xJbmloYnJUY0RVb1pteGU5U05BRXAwUTFz?=
 =?utf-8?B?cGFxaURlN3ZvZDZZZFFHeHlFcmhubVlxRWZncWFqTkhmaksyckthdllLeVo3?=
 =?utf-8?B?bTdRYmdRUE9rNDVwa3NLOHlNV3dXUHBnRTZCZkdMS05qbG1GQ2txLzk0TFJo?=
 =?utf-8?B?cS9GOG9PQTdQRFNrWTU0MWY3WEY4VHNJcll6ek8rMzNVS2ZJcG90elFxQXdu?=
 =?utf-8?B?dTFWM0JXaTVhQTV3T1hHWnFpdlhNMjY0dGdDaHc1d2s3U2FqOG4zSFo0RzBU?=
 =?utf-8?B?bE9lTzhIajhOUjF0NW9JU0RDWTk4TFFTQXpuVmZaWlBMYVdBbEVMV1p5ZWpw?=
 =?utf-8?B?V0hGS0p4c015eDhLUGRSR01peFg2ZDN0RFFOS2IvVkJML1FnRDBpbHlWTjZ2?=
 =?utf-8?B?L3FSWit0SWY4UHZGcVUxOUV0dFhyUXlPeDlxWkUyeWU5RnhKR3cranA5VnRU?=
 =?utf-8?B?L0syclpZTWRwcUNBWC9mY3JnR2lxQ29sZHl1eUJlSWErZ3laaitDd0x1RFRn?=
 =?utf-8?B?cU9tWUU1YnVRR1ZITlpyZU9TM0JCNUNvTmhGWWt2clRPdnR5T00vZlU2NkxF?=
 =?utf-8?B?ZjkvbEN0dFArZnMvcVdnSlNySExkZWprNWo0ZE5rcWo5azVDVWNZMjZKTnpZ?=
 =?utf-8?B?Z1ZKQUtMb2ZYWk92Q3d6K3ZWSkVGUFNrd01UVzR5dFVnTnMvbjdEQ0VJWDds?=
 =?utf-8?B?azVsREtiYW1VczcrcUovd011R3ZZbzQzUUNINVd0dzB6MzJ3b2dQM2grY3k0?=
 =?utf-8?B?UmlCcWgveEVSY005V0lha2FJSWYrNTRnVkhwenVTaHpuKzlFQlZ6c3RISGlE?=
 =?utf-8?B?RWhoQTgzblcwaFNlVDFycDR4MldFT2JoanRCZjZwbmxBTnRiT0RLalZKS0wy?=
 =?utf-8?B?SWdQTDB5Y004QlB6NytoeTAzNnlSYTlqNldGR3BzWnJmOUJqK3JCTEtBVW5x?=
 =?utf-8?B?UVhSWm5WcHZIVkx5S3FvRTNpSk1nVDJieCsyTE8xSVlXNHdvREdWbnNSUmZq?=
 =?utf-8?B?eDRjREZYYVBhYXhBci9Zc0IrRnV6VlBDOTVBdEF1dkg2Q2g0eS9VMmhhNHpL?=
 =?utf-8?B?Wm11VnUyV2tUOGhDdU02ZFdIZ1lVRkFmRVh6YkVOWGpVbmo2bGQ4akxiRUJy?=
 =?utf-8?B?Q3d6WU9MSDZlZ0hqOC9yRGw5bEFIUVdJTjRkbXhyWktrNmpicmd4RFdiU3JQ?=
 =?utf-8?B?bVpwcWxBOVA1N3dxNWpxM1JuRVVrV3R3NitSZ0J3bkxSZ1ZOeEZUdW9LWm1t?=
 =?utf-8?B?ckhkNGFOL0Y2ZE94Sm1zYXpCVDBiTitJQlFURTJNOWR6Yi9NZ1NFaGtpZmVw?=
 =?utf-8?B?YlJoWmpJa1ljZlYrOXB2ekxnSG9TUGJiT2xKdFo1MlU1WjFiT3B1N2Q0ZmNI?=
 =?utf-8?B?QzMzakJFOERFalZOYlRDeWJvTHJPSUs5OThyaDRwM2lwU1BQa3JCcTg1K1NB?=
 =?utf-8?B?VWNHc1NFWmUvaEZzZ1lRTWxEckwyVlBhc2VFd3B1dVdWak1aRlgzWTRsRzQ4?=
 =?utf-8?B?L3ZNeTVzQWZNQWFZOXJVRTFnUFlyM3J0VGZKcmZrMXV3NGVKUDVlVlV1MHZZ?=
 =?utf-8?B?MHR0dHFPVVp2QW5mSDJva2NxWVR1WXJYamdLSkJqaWtrTk8vY2dNdS9JRnIr?=
 =?utf-8?B?YTFJS2ZEUStmVnlnQlBYbzlZMnpOM1p1Q0dLTjlYRVJKT0lBd1RRR1JOWXFI?=
 =?utf-8?B?cDNlQnhTL0M5QTB0OTRpR0hsUXhNWWhJRS95eG05SEI2ekVLVDdVSEo3Y3dy?=
 =?utf-8?B?WVoyN2VWcGR2T21lTGZIVExRSlVnSFRsYlBSaUh6UGpLUEx1blJtL1ZwRGll?=
 =?utf-8?B?MzFUOVNGMGw2Ym9NZ2x5UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UU4vc0V1cEgyYVJiNG1qUUs0Mmk5N3Y5K2hiMHRMdEM0OEhYQVNnRFFrbHR5?=
 =?utf-8?B?Qm90K1Z0MDlwL21HQUVhY3pyNnVDOGVnSlg2eXE2b3phK2lqQnRIWWI2OENU?=
 =?utf-8?B?OUdLSVFMeWt5OUE2Y0o0WWowZ1JSNEphY2VGK3hXY0dFRTFrY3YwOUFsSEsw?=
 =?utf-8?B?cmFUVmc2ZmxwMEdscE9rN2tlNkYzeS90ck1aRHNhOGtlY3BxQnZ2Q1diK3ZU?=
 =?utf-8?B?bVJZVDJmZ3Ntd3RIVjNzaVV1L0xYM2NjTGEvMzRJd21DTkpWbGJieElOSzhC?=
 =?utf-8?B?bG5yR0QvSTZBUVJ4aEhPaDh2K1NXd1NCMnhPbWZFOXFPaTB1T09UOTAxVmg4?=
 =?utf-8?B?Tko0eXBQNkVtbkZrRktnVFViUURWOGZVSkZKSWhVV0ZlVmc4Tkdxb3dDblBE?=
 =?utf-8?B?N2dvczd2ekFFVkJ3RUlLRnNSeEYwNlBCZy9iSTRBM1F2QVlqUTJKa3UzYnk0?=
 =?utf-8?B?dm5OVy9XWGljQjJvMVBTQ3dLVFgrbExWUVRCUS8xN3Z6S216WHBlUkUyQjdW?=
 =?utf-8?B?ZjN1MnlKWTlLZzltcnNNa2x1ZUpONzFKZi9uUTdsUHhuNUErZ1dzMlZWWjZ1?=
 =?utf-8?B?Q0gyczEyUEpvUE5iZGlKcjk0b0ZQbXRDcm80TXV5M0QxQWR5QStDUVlWUGl4?=
 =?utf-8?B?VG9IVFRCNHkrcExuOTR0eWRyN1d2NVJLV2w0TzdscHl3UjNBZm1NZUlDYm5x?=
 =?utf-8?B?anp5c1M3VWNNcU91U1FmZjNjUWdUNm41aVBFSjVzaDIzS0tTcXc0bVhoNXJJ?=
 =?utf-8?B?SHIzRGZZaDJKeVlyNXU4SUx4Wit5M1RDTW1heHExWmViYmkrNmZJQTZJWXA5?=
 =?utf-8?B?eTRxOGYwRGpPaG0yQXE1elZCWGtZNjhVUkhoZ09OamhxWTkwSDRWMThlSTNs?=
 =?utf-8?B?aEVHWU1hT2RlN1g5ZnU5akY5YTV0T3pqZFNXRG5FWGpaRkJXbGpJTWhINGdv?=
 =?utf-8?B?ZUg3TlVYUkZVR2FDc3NrNGg4SzNlNFYwVkR4c2NvczZSVmFtdUZVY281NmFB?=
 =?utf-8?B?bEtQMXNNbEVqZ3Z5M0J4RWZVT2M5OW9yWUFRMVYyNU1YSjN3OHB1a05nclh6?=
 =?utf-8?B?ZmFKSUxUTGs5bnNmc1V3bzViSzJwTEkrdTd3L3lKeVZSTklZZy9ZQk1QNVpD?=
 =?utf-8?B?YXFEaDdYQS9kRHdyUGYzalVzQlVaZ2h2WXdwbGlBd2xGMWxqOFcrT3dnK2xt?=
 =?utf-8?B?UE1wMkErOGliK1NTYnh6bklkQi9xWEc5cmJKYWwvV1BjUTBuUndDSjNreGRk?=
 =?utf-8?B?M3ZyQmxIWER0STM3dW16c3Q1cGlGRkF4U3VVRFhqTkpFZm0wWVlJbm0zbkEx?=
 =?utf-8?B?UG5mUDFRYVpPaEhWM21tNXN3bEtyVnhhTEdHSzRZYnlhQjNPd3RQYUs1dXkx?=
 =?utf-8?B?UGtmN3JraDRGY2gyRmRRT2hRREx5YzhOblRiUURNZytXY2VTSGJxdTY5ZGdr?=
 =?utf-8?B?OFptdTBWcVBXaGFlcm5rbXR6eHpuT0VqamR2ZzhaZEh1anp2dU5WdDZZVjY4?=
 =?utf-8?B?TGhhYW05LzRqb0FwVHdPbldWaHk4RFBZN212cVlpVEtwL00vK2pVaEhrbmE4?=
 =?utf-8?B?WnprdUVHQVBFdDVQcXRWbmRGUGhlZUcxQ0RXMUtMTXFDZWxSOTYrTmNRWmhC?=
 =?utf-8?B?ZG9zN0IzUzFxOXQwaFI3enF2MzdpL3RYeTBoVkdvNTdsVDduQzVBVEtQTGIx?=
 =?utf-8?B?YVdEUGJidlJEdWRzd3ZkREFobmMzaVRvdXVBakI5ZnBuL0J4WjZmMjVraDEw?=
 =?utf-8?B?dWdYM2d5czZjTVRIWkhkUmJSbk9IbFRkZCtXbDZlOGlwK2l2ZzZOdUFtR2xK?=
 =?utf-8?B?RktQdmNhc0V2bm13ajhQWTY5UFd1RDRReU4yUFl2WXBxcVRqUFZPajJoM3Rh?=
 =?utf-8?B?ZzFMM3JpUUwyb3haNmxPby9kUEZDSlNUSUZBS3QwekJUd2NFbGw5amdydzJJ?=
 =?utf-8?B?ZEpPSUZVejdJSm1yKzM3cXIyTWlTQ3hxV2RmTDV0WlJ0NDV0cGRYMC9YSVFz?=
 =?utf-8?B?c3phNk1sdC9OVnErY0xBTDgrT2FvQnZkcUpaTWxMZjRWUW5HekI1THBsamh6?=
 =?utf-8?B?SExoSHE5TnVLclJxT0RhbEtGUDVlUWltNmFqbkhDS3RuUGEwUlAvbURzSUxO?=
 =?utf-8?Q?ESBqAQjTVHeMNyKwMBKxi6Abo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbf82fa-30e9-4b4d-a4b2-08dd15cff93d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 08:28:34.4105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgvxmGvv+AWq5sVDj+rT8hEJskgghneVVkfrmmYAX/7rwQfu2p58eJu2qiGyJh41x1H6PTTkz9IDgu26B70pNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023



On 12/6/2024 1:20 PM, Dan Williams wrote:
> Raghavendra K T wrote:
>>
[...]
>> B. /proc/iomem
>>
>> $ vimdiff success fail
>>
>>    4050000000-604fffffff : Soft Reserved
>>     |  164 4050000000-604fffffff : Soft Reserved
>>     165   4050000000-604fffffff : CXL Window 0
>>          |  165   4050000000-604fffffff : CXL Window 0
>>     166     4080000000-5fffffffff : dax1.0
>>          |
>> ------------------------------------------------------------------------
>>     167       4080000000-5fffffffff : System RAM (kmem)
>>          |
>> --------------------------------------------------------------------
> 
> My eyes only know how to read unified diff (diff -u) format. Is this
> saying that in the failure case the System RAM range for dax1.0 is
> missing?


Sorry for that formatting. I realized later.
Yes. dax1.0 missing in the failure case.

Looks like problem is that,

4050000000-604fffffff : Soft Reserved
   4050000000-604fffffff : CXL Window 0
      4080000000-5fffffffff : dax1.0
         4080000000-5fffffffff : System RAM (kmem)

this use case where,

|A<------------->D|  CXL window
|..|B<-->C|.......|    kmem

B->C range that falls within A->D as in above somehow
not covered after the patch.

Thanks and Regards
- Raghu
