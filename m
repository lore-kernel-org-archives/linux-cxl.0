Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D08C1FDE3D
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 13:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737120840; cv=fail; b=f9jVO6KY/JGPseGaZLOE6Q8GQWjBmkXJX4QSlFRay4jZzk8an5JDvJJZEDkiGYM/kCZ6Kull0z88MF3ye7wXs++9VHlplAu6CbuHXdpD2zMehPg162lv3fPQPC4zBCYZynN25jUWamnTISGQ5rblf2fKxEqyUDoWQEPJO9fOImA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737120840; c=relaxed/simple;
	bh=G05VqxQwUyXU2vakkVGQHEtGuP85+GykYZWvR7Cd0o0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Un9BETlNXMkIIGxWw9nat3V2kr3bI1VnIg98c3EQQHzD3nbyekys0OzDz1VKXm2QDQ3R4DQJk+80P0mdh4455X3BkjyNaJNjvhnJ1S+RDntglPZdpLFM1b2XSVUuSxrDzFlZ2KHVEoKK5ESEdnmSgCpw/8szWedCSRMHX3jNzfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CKNVLeiT; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CKNVLeiT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qdc0VK6pzG3KA4/VJPIsoKJrTQ68Iaj+XTOVMF6FmICZdxRCD0w0cuAcYTVhJZr3Vvpos65BhX+ergCCL0KEHcDVrx5Xvrcm5w436N2FPgwYQu0KAk+CL06xv8XltRYG9g50Emjq54Cgf9Txcgsq6YCFqDRqZKKNwr1diM5y8VoHdDmMm4d+InzFFbBpaBJy2eN/2vtDMmAeuPtnP1NTtlPuMbxdQVqDpGAYjwe5ykzuz9u7dtRCFD/kTI2cu+cKajq0Me61vEl1hddWnuThdzUEonSlmsi4lzdL93/bdTrDjAsMMjVjyUCHCwBgtUwAFMq3Uj5gRNcdlOlcdoKA8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHnIDp+tUgwJ8ZrvWuSRkeJsQIuQDqRe+T5kRJheqQk=;
 b=U3E1vnBf7vjsXz7vyYGFy6OiE74AYgSbR8iI+37U2Ou66qginHNKJ0GCQ5hZmAmX+hNdqIYQ5pu93S+/H2vU/YklNmUC7WTao4iQkaXdFjBp/pNVjIh/Ey5VxuRdixLxj+bIvBpswvqHjB+J3GtBN4LtaoElfzUQn+OawKC3cyhaG3rsdjCp3GGRimWjD7U7ZzJoSd9DK4SVFvis2480mj4Sab1M0DWtOeOm2dg6gMSHQcJcHcNphqEHyyvFIEX3QEFzstrqHDcsLI+xgKiLdWOG+6x6fCmSxFwh8dMSNisEmxtEW3Mdf2rl6+ZEV0emTE2NeLmxly8Cv3+9vCZYBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHnIDp+tUgwJ8ZrvWuSRkeJsQIuQDqRe+T5kRJheqQk=;
 b=CKNVLeiTJAF3e1zy5/fPbou6LalZwb3CmWrM11l1fpDc/+th9Qneh2pLHXGwwb7Axk9zIt81gXBRsFaFnvyG6DJOHGVbyraR90AWpFXALy6aKNgpSYDlchFiUeSR8agY51ysw+OplCePF8Bc4B46Vnp7jPJDuHyZJisww2Uhr3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB9067.namprd12.prod.outlook.com (2603:10b6:510:1f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 13:33:55 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 13:33:55 +0000
Message-ID: <3462ff60-b153-36f0-2f49-f2e3fa118be3@amd.com>
Date: Fri, 17 Jan 2025 13:33:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] cxl: Introduce to_{ram,pmem}_{res,perf}() helpers
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
 <173709423850.753996.572292628436250022.stgit@dwillia2-xfh.jf.intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <173709423850.753996.572292628436250022.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::27) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB9067:EE_
X-MS-Office365-Filtering-Correlation-Id: 31749dfe-3ed7-4428-3594-08dd36fb96de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmRIVnc5Qkx1am9IcHY3STN0ZStEaUhBd2pTTmFCOXB6MXJyVFpOcUJJMHVY?=
 =?utf-8?B?aEdzV3ZHTkgzMko1MXFmVWtvY1dxUU03aGhqTlB1di92WGhhalN0T1JkZ29l?=
 =?utf-8?B?YkpVTko4YWZCNzVodGdkTHA5YXVRNFljcTNGZkRGZ292N3BOMGJLVi9HYWd2?=
 =?utf-8?B?NU9KV2N3S2l0TmNFNnFnTm9xV0dKQ21mZzRWYmVUWmovU3NNMC9YMVI1ZUFV?=
 =?utf-8?B?cmsyOWNYTi9mTUtjM0QzYjJrRFUveUtkM1dMOGFyOFlaVUxVWHFlSk1IMGJh?=
 =?utf-8?B?eUIzaEx6TXQ1ajlXZkV3OEVGRUN4dzdoMkVDdlhDMHZCWnIyV08wdzJLdkJU?=
 =?utf-8?B?NWxFUENYMU05bU81Mnl1M0pzRmFwZXVXNE5sRGtreGhCQk1Kc2xTUmQreTRy?=
 =?utf-8?B?c3VYUTlFR01zNTZmNGJ4QVRiRHFhdGo3UG1sMmcxZzN3b3JoTDNtaFNqMk5L?=
 =?utf-8?B?aXhlN1FQRGpIK2pRT01kVlhEZHVtbDdtQzJXM3VMdGoveHVPbFk4ZGhGaVly?=
 =?utf-8?B?RkE0ck85QnJ0MTE2MHU0RFNUM2hjaElpNi81emloZ1lmMlgxTmVmK3N0YUV3?=
 =?utf-8?B?NU04NFZSS24vWU9pTG4xajJzTXpLZ1YyMWYvWGlpYkNtclpuSFBsaENUc3Jz?=
 =?utf-8?B?UzM5alFMUjFPeTF5b01ram5RWm5ENytiUjJ1Wks2UnhJR2xXYlgvWkcwZzAz?=
 =?utf-8?B?eHRxNFIwOHFPSE5UdTkyMy9WTmlsSitGV3lOTzU4OVVWMnVMc3Qzc3JJVXpi?=
 =?utf-8?B?eEY1am01UU9XSHpHWUlCMk1yTXkzcW83dXJRand0bTFmeUhuN3paSU9sT2lo?=
 =?utf-8?B?Unk1T2NGTjQ0eGlqMnlkZTFQUld1d283czZQY1ZnRndRZTVoazVzR2tNSWFr?=
 =?utf-8?B?c0Zhd3NDYlBPNEtqU0RuRFY3S2VsdGRjOWlrQld3OXRJYVN2NUwvSk5obEVy?=
 =?utf-8?B?MVZtVGxQQXlZWHVLY0taZ0I2VVJyRmY2Yy9oZXFoeWVwdTF6dm5TSXFiNlNQ?=
 =?utf-8?B?ZktiQkllSVJBZXErMjg2ZElQdlk4TGUvM3poWFJiYlhvQ3Vqc0dlbFVCNk9N?=
 =?utf-8?B?dlRzMHNKK09WbXpUS0VPdzlkakUxUWdFZitaNStIQjRLSEp2MTZ6cmZzWElI?=
 =?utf-8?B?SWlONms1a2g2WDdFL2VId2RmaEdKeVBEOWxpbGZQeTZmb0x3UmZHTmVvd3pD?=
 =?utf-8?B?NU1qalQ0TFhzaVVSTTFZdVhpRWw3aUE0QzJ3cjcxMVRQUDI3bzN5b1VpWnhj?=
 =?utf-8?B?RENJM3JXaTUwcHZ4L2Z5cnRyZU9WTlZ4Q3dJd0hxU1ZKRGFObVBlU0hIcDgz?=
 =?utf-8?B?QjZLT2RZVStHNE9kV3NvVzBpcWpWM3cwYmQrb0JpOTNYdkl1VS90VklZcWpD?=
 =?utf-8?B?cUdndWoyL1pIUkVoUDNPVXVvMFFXYk1CRlZSL2ExTEVCdVc3QXJkM3ovam5E?=
 =?utf-8?B?eG1NY0Jib0tLd3UxZ0ZWb2svNEVldS9jRXpEOWovMTEwblRxb1BWUm9JQWIz?=
 =?utf-8?B?eU52M1g3OG9yZk53dFVhQzNOS1N5UVkwT29laFR5TlhwZmM5MG1ud3hyOTNa?=
 =?utf-8?B?b3VvU2U5UDdTK0ludUgwM0F6Tk45WWxUWE0vNUxZb0FYMVhEaVhnRU93Wlo4?=
 =?utf-8?B?WnNaZDdsNHRHdE5WOVd3WEk4RkNlTHRxYzBYRlc3cU1oWGY4MEI1cHc1UzNw?=
 =?utf-8?B?akhSTnVVbDg0UzUvbkFDT0hiY0QrMElYbjhOUk4vNWtMdUFmbjVCU3FJUDBS?=
 =?utf-8?B?d1pMWUpmUlpGK0hOeGRpN04vS0Q2ZEhKdm92OHpIenkrRjhEbVVUc2VZb3Bi?=
 =?utf-8?B?WDVCYU5uN2tQU1gvL3B4Q1J2eWE4T2MzbE5LemNjTUYrMGtyTFM3R1lqa3Fy?=
 =?utf-8?Q?Er+JFCRJP/HaW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGJWMzAzTTFkeUZscHpNaTRPM2NtK21XcXBUMGYwK2N0TzY4U3NSQlkwYjNt?=
 =?utf-8?B?ZmxEbCtwa2V6SGFMREpHTk0rdDVLUUMxWE5OVG1Cb0xXTkk3OFhSZk9UOFUv?=
 =?utf-8?B?R3lUajl1elN5MWZiSW8wd24rZG1KZVlFMWYwbDZINCtuR05wOVNHTUJKZ1V4?=
 =?utf-8?B?aEwwcFovcWN3SGY4VFhPT2IwQzNVTE1jSGljbkhRcnVYaDkybWJja1BCMStO?=
 =?utf-8?B?U2g5WURpQ0hSK1EySzdrdmRvbnlqbTg4Z3pKd0JZQTFhamRRb2M4eHpLSnNT?=
 =?utf-8?B?THU4MmhGK1I5YUYrcDVsb3RRbmZzbERLZEFuOFB1aE56Q1RZd3N2U2JMRnhR?=
 =?utf-8?B?cUNiakFIcFhpL1FwQkxvL0NzVlBlNUJzM2ZFRC9ZeC9YTHVyQ29xTzgwQWI4?=
 =?utf-8?B?bG1wVGxMSGs5SXVhNjBxY2tTVUNOZjdXck5oZmRDOWlCK1g2Y1VsQ3RTTmxP?=
 =?utf-8?B?Zmh5dllzNDRBUVNTVld1WHNmRkJtN1QzWTJlK1RuR3VKL25ST2dIL21sOXJU?=
 =?utf-8?B?Q1NQTmhRODg5dmtFYitTSHBqVlVTbmp1SUdWR1UzbFIvRWxvamM3a1ZMSmNK?=
 =?utf-8?B?WXJuZFlHRlRvUktQTkVSRUlvYUNwaGhqVXlpOU14ZDd4a2lJVUNCU3hMTDJm?=
 =?utf-8?B?WDY0TDBFUzVSRDlCS2lZc1dLT2thK2VSY2pHSEFodEIrNTBxYVc0SXZEQjBW?=
 =?utf-8?B?WDFoZjZXV3N3QnYvMW9NNVd1dDZ5dm5UQURhOFA2d2hjQU9kZVkzak90YWZ3?=
 =?utf-8?B?eHdYU1ZVQmxiaTVORFo4OXZyRXdpS3VGblZNVFBKbjdXR2Z2UkIrQlFFUmR2?=
 =?utf-8?B?SURYb1Y0Vzd3RG1IL1ovVWJWYmhqU3hwa0RaU00xeFVLRGFqWXI0SlZTVTdN?=
 =?utf-8?B?citpRG1NRGZwR0Nzb3YyclhkeUVJbXErQmxUUXU1Wm1DWnprVFI0bWdaYWFR?=
 =?utf-8?B?M2tzZ1FpZmlmbDRYVlhpWjViOTBvbDJaeUprWEVGV05TMkw5V0NUclpIWHRT?=
 =?utf-8?B?VlUzY1dFUmEydmtGT3AwMzhISVhGSllsWVExNmFjUlNsTWpYZzZjSHdtVzFZ?=
 =?utf-8?B?ZjQ1bW5XVG5PdUZzRVhRcU9CTXQ1Y2JCcEp6ZW1LRE80OE9yOXd4Y2lkTGU0?=
 =?utf-8?B?VUFNL2Fjekx3bUxVWDI3TXo2VHFKZmZmUEhSWldaVmZPOWU1MUQ5eTJQbTds?=
 =?utf-8?B?VVhUbDFmTFg3SFlDV1Y3MHZkV0psaFhQRVoyb2xsZUd1ZnYvaTlSN1ZJTDlE?=
 =?utf-8?B?amszTVh0ell3NVFCdzUrVzl3eEd4cU5acHUyYlVRYUlMTjhEQnN0czJsZ2ly?=
 =?utf-8?B?aXlMemZxS1diMU52RThFVit2N294WlVCZzJpMndjU0V0QjlvTkZrMlp2VTJx?=
 =?utf-8?B?cXFiTnFzUHcydGtKYzR5M0VjUEtpVVdoek5hR1BWTk9WNnBDZDRJU2Uxb1JX?=
 =?utf-8?B?enlVemkzWWRkUFV5dW43c1drYklRdGphVG5qNGpKc3E3aHpYS2xCV3RjNlB0?=
 =?utf-8?B?VWtzSDNhL3NLTFc2ak1RTXlhcmJ0SThxSGxQY2p1UWw4bW56eEhnRWREV2JN?=
 =?utf-8?B?WjBSMFVMdVdUb2lxVlZucU4rL3FURnZ5eTlnMzE0SGNyM3NpT1FqazBENUNL?=
 =?utf-8?B?NldPazdaZUFTVFB6ZENmVVdYWTYraFozQ20zVWRQT0pxY2ZJM2FVN3pEbk9y?=
 =?utf-8?B?eGJnK3ZRNXQ3eVVJNHlWd2p6cURIcGFQWjJCSmVLeVVMdVVUOUtZOGVGaFlm?=
 =?utf-8?B?bjVOVWlaN3ZtSTBMNWQ1TDVtUEVJS216QjJKenJTM3lla21MT1NvZE1Sb1FN?=
 =?utf-8?B?S1A3NWwvWUEvR0RXSi9Vb2k2aWdxZUVQTzFPdEtiQlVUb2h2dnBmNVVvWWI0?=
 =?utf-8?B?M3BuS1psaC9hMFZjaGdwb0tqbmpYcUhXNU1pSXJ0OVlHdWYwN2o4azI3ekN6?=
 =?utf-8?B?eFUwV3c0Q295ek5LWXBENDh1SXI5dlNlbUw4MnJIVjM0a0NSK2U3MWdTazhv?=
 =?utf-8?B?VFNvRFJwZUdJVjJtbVV2NzhsNDZRYlZxVzRpUlorZDlWL3ZKOUwxb0pWQ3Vz?=
 =?utf-8?B?QzRwUFRPVXhRTXFoOWVWTG1DWmpPa1FaRzlQOWRlK0VuTUxEbC8wMEFZejh3?=
 =?utf-8?Q?j+qAXz8YzJTx4hG1bL0FjXTSY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31749dfe-3ed7-4428-3594-08dd36fb96de
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 13:33:55.4740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THyc+Wf+2dWpzYwsOitnrdMMSjyyGct0wpASuOs48Z6vUxQt9Qp0JOSQCLJO3Vi0HJJhN8uHiHrYwkeZsuOcuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9067


On 1/17/25 06:10, Dan Williams wrote:
> In preparation for consolidating all DPA partition information into an
> array of DPA metadata, introduce helpers that hide the layout of the
> current data. I.e. make the eventual replacement of ->ram_res,
> ->pmem_res, ->ram_perf, and ->pmem_perf with a new DPA metadata array a
> no-op for code paths that consume that information, and reduce the noise
> of follow-on patches.
>
> The end goal is to consolidate all DPA information in 'struct
> cxl_dev_state', but for now the helpers just make it appear that all DPA
> metadata is relative to @cxlds.
>
> Note that a follow-on patch also cleans up the temporary placeholders of
> @ram_res, and @pmem_res in the qos_class manipulation code,
> cxl_dpa_alloc(), and cxl_mem_create_range_info().
>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/cxl/core/cdat.c      |   70 +++++++++++++++++++++++++-----------------
>   drivers/cxl/core/hdm.c       |   26 ++++++++--------
>   drivers/cxl/core/mbox.c      |   18 ++++++-----
>   drivers/cxl/core/memdev.c    |   42 +++++++++++++------------
>   drivers/cxl/core/region.c    |   10 ++++--
>   drivers/cxl/cxlmem.h         |   58 ++++++++++++++++++++++++++++++-----
>   drivers/cxl/mem.c            |    2 +
>   tools/testing/cxl/test/cxl.c |   25 ++++++++-------
>   8 files changed, 159 insertions(+), 92 deletions(-)
>
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 8153f8d83a16..b177a488e29b 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -258,29 +258,33 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
>   static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>   				     struct xarray *dsmas_xa)
>   {
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>   	struct device *dev = cxlds->dev;
> -	struct range pmem_range = {
> -		.start = cxlds->pmem_res.start,
> -		.end = cxlds->pmem_res.end,
> -	};
> -	struct range ram_range = {
> -		.start = cxlds->ram_res.start,
> -		.end = cxlds->ram_res.end,
> -	};
>   	struct dsmas_entry *dent;
>   	unsigned long index;
> +	const struct resource *partition[] = {
> +		to_ram_res(cxlds),
> +		to_pmem_res(cxlds),
> +	};
> +	struct cxl_dpa_perf *perf[] = {
> +		to_ram_perf(cxlds),
> +		to_pmem_perf(cxlds),
> +	};
>   
>   	xa_for_each(dsmas_xa, index, dent) {
> -		if (resource_size(&cxlds->ram_res) &&
> -		    range_contains(&ram_range, &dent->dpa_range))
> -			update_perf_entry(dev, dent, &mds->ram_perf);
> -		else if (resource_size(&cxlds->pmem_res) &&
> -			 range_contains(&pmem_range, &dent->dpa_range))
> -			update_perf_entry(dev, dent, &mds->pmem_perf);
> -		else
> -			dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
> -				&dent->dpa_range);
> +		for (int i = 0; i < ARRAY_SIZE(partition); i++) {
> +			const struct resource *res = partition[i];
> +			struct range range = {
> +				.start = res->start,
> +				.end = res->end,
> +			};
> +
> +			if (range_contains(&range, &dent->dpa_range))
> +				update_perf_entry(dev, dent, perf[i]);
> +			else
> +				dev_dbg(dev,
> +					"no partition for dsmas dpa: %pra\n",
> +					&dent->dpa_range);
> +		}
>   	}
>   }
>   
> @@ -304,6 +308,9 @@ static int match_cxlrd_qos_class(struct device *dev, void *data)
>   
>   static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
>   {
> +	if (!dpa_perf)
> +		return;
> +
>   	*dpa_perf = (struct cxl_dpa_perf) {
>   		.qos_class = CXL_QOS_CLASS_INVALID,
>   	};
> @@ -312,6 +319,9 @@ static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
>   static bool cxl_qos_match(struct cxl_port *root_port,
>   			  struct cxl_dpa_perf *dpa_perf)
>   {
> +	if (!dpa_perf)
> +		return false;
> +
>   	if (dpa_perf->qos_class == CXL_QOS_CLASS_INVALID)
>   		return false;
>   
> @@ -346,7 +356,8 @@ static int match_cxlrd_hb(struct device *dev, void *data)
>   static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>   {
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_dpa_perf *ram_perf = to_ram_perf(cxlds),
> +			    *pmem_perf = to_pmem_perf(cxlds);
>   	struct cxl_port *root_port;
>   	int rc;
>   
> @@ -359,17 +370,17 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>   	root_port = &cxl_root->port;
>   
>   	/* Check that the QTG IDs are all sane between end device and root decoders */
> -	if (!cxl_qos_match(root_port, &mds->ram_perf))
> -		reset_dpa_perf(&mds->ram_perf);
> -	if (!cxl_qos_match(root_port, &mds->pmem_perf))
> -		reset_dpa_perf(&mds->pmem_perf);
> +	if (!cxl_qos_match(root_port, ram_perf))
> +		reset_dpa_perf(ram_perf);
> +	if (!cxl_qos_match(root_port, pmem_perf))
> +		reset_dpa_perf(pmem_perf);
>   
>   	/* Check to make sure that the device's host bridge is under a root decoder */
>   	rc = device_for_each_child(&root_port->dev,
>   				   cxlmd->endpoint->host_bridge, match_cxlrd_hb);
>   	if (!rc) {
> -		reset_dpa_perf(&mds->ram_perf);
> -		reset_dpa_perf(&mds->pmem_perf);
> +		reset_dpa_perf(ram_perf);
> +		reset_dpa_perf(pmem_perf);
>   	}
>   
>   	return rc;
> @@ -567,6 +578,9 @@ static bool dpa_perf_contains(struct cxl_dpa_perf *perf,
>   		.end = dpa_res->end,
>   	};
>   
> +	if (!perf)
> +		return false;
> +
>   	return range_contains(&perf->dpa_range, &dpa);
>   }
>   
> @@ -574,15 +588,15 @@ static struct cxl_dpa_perf *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxle
>   					       enum cxl_decoder_mode mode)
>   {
>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct cxl_dpa_perf *perf;
>   
>   	switch (mode) {
>   	case CXL_DECODER_RAM:
> -		perf = &mds->ram_perf;
> +		perf = to_ram_perf(cxlds);
>   		break;
>   	case CXL_DECODER_PMEM:
> -		perf = &mds->pmem_perf;
> +		perf = to_pmem_perf(cxlds);
>   		break;
>   	default:
>   		return ERR_PTR(-EINVAL);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index be8556119d94..7a85522294ad 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -327,9 +327,9 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>   	cxled->dpa_res = res;
>   	cxled->skip = skipped;
>   
> -	if (resource_contains(&cxlds->pmem_res, res))
> +	if (resource_contains(to_pmem_res(cxlds), res))
>   		cxled->mode = CXL_DECODER_PMEM;
> -	if (resource_contains(&cxlds->ram_res, res))
> +	else if (resource_contains(to_ram_res(cxlds), res))
>   		cxled->mode = CXL_DECODER_RAM;
>   	else {
>   		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
> @@ -442,11 +442,11 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>   	 * Only allow modes that are supported by the current partition
>   	 * configuration
>   	 */
> -	if (mode == CXL_DECODER_PMEM && !resource_size(&cxlds->pmem_res)) {
> +	if (mode == CXL_DECODER_PMEM && !cxl_pmem_size(cxlds)) {
>   		dev_dbg(dev, "no available pmem capacity\n");
>   		return -ENXIO;
>   	}
> -	if (mode == CXL_DECODER_RAM && !resource_size(&cxlds->ram_res)) {
> +	if (mode == CXL_DECODER_RAM && !cxl_ram_size(cxlds)) {
>   		dev_dbg(dev, "no available ram capacity\n");
>   		return -ENXIO;
>   	}
> @@ -464,6 +464,8 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>   	struct device *dev = &cxled->cxld.dev;
>   	resource_size_t start, avail, skip;
>   	struct resource *p, *last;
> +	const struct resource *ram_res = to_ram_res(cxlds);
> +	const struct resource *pmem_res = to_pmem_res(cxlds);
>   	int rc;
>   
>   	down_write(&cxl_dpa_rwsem);
> @@ -480,37 +482,37 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>   		goto out;
>   	}
>   
> -	for (p = cxlds->ram_res.child, last = NULL; p; p = p->sibling)
> +	for (p = ram_res->child, last = NULL; p; p = p->sibling)
>   		last = p;
>   	if (last)
>   		free_ram_start = last->end + 1;
>   	else
> -		free_ram_start = cxlds->ram_res.start;
> +		free_ram_start = ram_res->start;
>   
> -	for (p = cxlds->pmem_res.child, last = NULL; p; p = p->sibling)
> +	for (p = pmem_res->child, last = NULL; p; p = p->sibling)
>   		last = p;
>   	if (last)
>   		free_pmem_start = last->end + 1;
>   	else
> -		free_pmem_start = cxlds->pmem_res.start;
> +		free_pmem_start = pmem_res->start;
>   
>   	if (cxled->mode == CXL_DECODER_RAM) {
>   		start = free_ram_start;
> -		avail = cxlds->ram_res.end - start + 1;
> +		avail = ram_res->end - start + 1;
>   		skip = 0;
>   	} else if (cxled->mode == CXL_DECODER_PMEM) {
>   		resource_size_t skip_start, skip_end;
>   
>   		start = free_pmem_start;
> -		avail = cxlds->pmem_res.end - start + 1;
> +		avail = pmem_res->end - start + 1;
>   		skip_start = free_ram_start;
>   
>   		/*
>   		 * If some pmem is already allocated, then that allocation
>   		 * already handled the skip.
>   		 */
> -		if (cxlds->pmem_res.child &&
> -		    skip_start == cxlds->pmem_res.child->start)
> +		if (pmem_res->child &&
> +		    skip_start == pmem_res->child->start)
>   			skip_end = skip_start - 1;
>   		else
>   			skip_end = start - 1;
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 548564c770c0..3502f1633ad2 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1270,24 +1270,26 @@ static int add_dpa_res(struct device *dev, struct resource *parent,
>   int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>   {
>   	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct resource *ram_res = to_ram_res(cxlds);
> +	struct resource *pmem_res = to_pmem_res(cxlds);
>   	struct device *dev = cxlds->dev;
>   	int rc;
>   
>   	if (!cxlds->media_ready) {
>   		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> -		cxlds->ram_res = DEFINE_RES_MEM(0, 0);
> -		cxlds->pmem_res = DEFINE_RES_MEM(0, 0);
> +		*ram_res = DEFINE_RES_MEM(0, 0);
> +		*pmem_res = DEFINE_RES_MEM(0, 0);
>   		return 0;
>   	}
>   
>   	cxlds->dpa_res = DEFINE_RES_MEM(0, mds->total_bytes);
>   
>   	if (mds->partition_align_bytes == 0) {
> -		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
> +		rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
>   				 mds->volatile_only_bytes, "ram");
>   		if (rc)
>   			return rc;
> -		return add_dpa_res(dev, &cxlds->dpa_res, &cxlds->pmem_res,
> +		return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
>   				   mds->volatile_only_bytes,
>   				   mds->persistent_only_bytes, "pmem");
>   	}
> @@ -1298,11 +1300,11 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>   		return rc;
>   	}
>   
> -	rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
> +	rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
>   			 mds->active_volatile_bytes, "ram");
>   	if (rc)
>   		return rc;
> -	return add_dpa_res(dev, &cxlds->dpa_res, &cxlds->pmem_res,
> +	return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
>   			   mds->active_volatile_bytes,
>   			   mds->active_persistent_bytes, "pmem");
>   }
> @@ -1450,8 +1452,8 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>   	mds->cxlds.reg_map.host = dev;
>   	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>   	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
> -	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
> -	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
> +	to_ram_perf(&mds->cxlds)->qos_class = CXL_QOS_CLASS_INVALID;
> +	to_pmem_perf(&mds->cxlds)->qos_class = CXL_QOS_CLASS_INVALID;
>   
>   	return mds;
>   }
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index ae3dfcbe8938..c5f8320ed330 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -80,7 +80,7 @@ static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
>   {
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	unsigned long long len = resource_size(&cxlds->ram_res);
> +	unsigned long long len = resource_size(to_ram_res(cxlds));
>   
>   	return sysfs_emit(buf, "%#llx\n", len);
>   }
> @@ -93,7 +93,7 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
>   {
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	unsigned long long len = resource_size(&cxlds->pmem_res);
> +	unsigned long long len = cxl_pmem_size(cxlds);
>   
>   	return sysfs_emit(buf, "%#llx\n", len);
>   }
> @@ -198,16 +198,20 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>   	int rc = 0;
>   
>   	/* CXL 3.0 Spec 8.2.9.8.4.1 Separate pmem and ram poison requests */
> -	if (resource_size(&cxlds->pmem_res)) {
> -		offset = cxlds->pmem_res.start;
> -		length = resource_size(&cxlds->pmem_res);
> +	if (cxl_pmem_size(cxlds)) {
> +		const struct resource *res = to_pmem_res(cxlds);
> +
> +		offset = res->start;
> +		length = resource_size(res);
>   		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
>   		if (rc)
>   			return rc;
>   	}
> -	if (resource_size(&cxlds->ram_res)) {
> -		offset = cxlds->ram_res.start;
> -		length = resource_size(&cxlds->ram_res);
> +	if (cxl_ram_size(cxlds)) {
> +		const struct resource *res = to_ram_res(cxlds);
> +
> +		offset = res->start;
> +		length = resource_size(res);
>   		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
>   		/*
>   		 * Invalid Physical Address is not an error for
> @@ -409,9 +413,8 @@ static ssize_t pmem_qos_class_show(struct device *dev,
>   {
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>   
> -	return sysfs_emit(buf, "%d\n", mds->pmem_perf.qos_class);
> +	return sysfs_emit(buf, "%d\n", to_pmem_perf(cxlds)->qos_class);
>   }
>   
>   static struct device_attribute dev_attr_pmem_qos_class =
> @@ -428,9 +431,8 @@ static ssize_t ram_qos_class_show(struct device *dev,
>   {
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>   
> -	return sysfs_emit(buf, "%d\n", mds->ram_perf.qos_class);
> +	return sysfs_emit(buf, "%d\n", to_ram_perf(cxlds)->qos_class);
>   }
>   
>   static struct device_attribute dev_attr_ram_qos_class =
> @@ -466,11 +468,11 @@ static umode_t cxl_ram_visible(struct kobject *kobj, struct attribute *a, int n)
>   {
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_dpa_perf *perf = to_ram_perf(cxlmd->cxlds);
>   
> -	if (a == &dev_attr_ram_qos_class.attr)
> -		if (mds->ram_perf.qos_class == CXL_QOS_CLASS_INVALID)
> -			return 0;
> +	if (a == &dev_attr_ram_qos_class.attr &&
> +	    (!perf || perf->qos_class == CXL_QOS_CLASS_INVALID))
> +		return 0;
>   
>   	return a->mode;
>   }
> @@ -485,11 +487,11 @@ static umode_t cxl_pmem_visible(struct kobject *kobj, struct attribute *a, int n
>   {
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_dpa_perf *perf = to_pmem_perf(cxlmd->cxlds);
>   
> -	if (a == &dev_attr_pmem_qos_class.attr)
> -		if (mds->pmem_perf.qos_class == CXL_QOS_CLASS_INVALID)
> -			return 0;
> +	if (a == &dev_attr_pmem_qos_class.attr &&
> +	    (!perf || perf->qos_class == CXL_QOS_CLASS_INVALID))
> +		return 0;
>   
>   	return a->mode;
>   }
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e4885acac853..9f0f6fdbc841 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2688,7 +2688,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
>   
>   	if (ctx->mode == CXL_DECODER_RAM) {
>   		offset = ctx->offset;
> -		length = resource_size(&cxlds->ram_res) - offset;
> +		length = cxl_ram_size(cxlds) - offset;
>   		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
>   		if (rc == -EFAULT)
>   			rc = 0;
> @@ -2700,9 +2700,11 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
>   		length = resource_size(&cxlds->dpa_res) - offset;
>   		if (!length)
>   			return 0;
> -	} else if (resource_size(&cxlds->pmem_res)) {
> -		offset = cxlds->pmem_res.start;
> -		length = resource_size(&cxlds->pmem_res);
> +	} else if (cxl_pmem_size(cxlds)) {
> +		const struct resource *res = to_pmem_res(cxlds);
> +
> +		offset = res->start;
> +		length = resource_size(res);
>   	} else {
>   		return 0;
>   	}
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 2a25d1957ddb..78e92e24d7b5 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -423,8 +423,8 @@ struct cxl_dpa_perf {
>    * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
>    * @media_ready: Indicate whether the device media is usable
>    * @dpa_res: Overall DPA resource tree for the device
> - * @pmem_res: Active Persistent memory capacity configuration
> - * @ram_res: Active Volatile memory capacity configuration
> + * @_pmem_res: Active Persistent memory capacity configuration
> + * @_ram_res: Active Volatile memory capacity configuration
>    * @serial: PCIe Device Serial Number
>    * @type: Generic Memory Class device or Vendor Specific Memory device
>    * @cxl_mbox: CXL mailbox context
> @@ -438,13 +438,41 @@ struct cxl_dev_state {
>   	bool rcd;
>   	bool media_ready;
>   	struct resource dpa_res;
> -	struct resource pmem_res;
> -	struct resource ram_res;
> +	struct resource _pmem_res;
> +	struct resource _ram_res;


I think this is unnecessary since it is clear those fields are going 
away later on, and this change only adds confusion. Moreover, they are 
not referenced in the code now because the helpers.


>   	u64 serial;
>   	enum cxl_devtype type;
>   	struct cxl_mailbox cxl_mbox;
>   };
>   
> +static inline struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> +{
> +	return &cxlds->_ram_res;
> +}
> +
> +static inline struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
> +{
> +	return &cxlds->_pmem_res;
> +}
> +
> +static inline resource_size_t cxl_ram_size(struct cxl_dev_state *cxlds)
> +{
> +	const struct resource *res = to_ram_res(cxlds);
> +
> +	if (!res)
> +		return 0;


This check is not needed now, and with the change in next patch, I think 
it should not be needed either.

Do we need the distinction between, no ram or no pmem, and ram/pmem with 
size 0?


> +	return resource_size(res);
> +}
> +
> +static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
> +{
> +	const struct resource *res = to_pmem_res(cxlds);
> +
> +	if (!res)
> +		return 0;
> +	return resource_size(res);
> +}
> +
>   static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>   {
>   	return dev_get_drvdata(cxl_mbox->host);
> @@ -471,8 +499,8 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>    * @active_persistent_bytes: sum of hard + soft persistent
>    * @next_volatile_bytes: volatile capacity change pending device reset
>    * @next_persistent_bytes: persistent capacity change pending device reset
> - * @ram_perf: performance data entry matched to RAM partition
> - * @pmem_perf: performance data entry matched to PMEM partition
> + * @_ram_perf: performance data entry matched to RAM partition
> + * @_pmem_perf: performance data entry matched to PMEM partition
>    * @event: event log driver state
>    * @poison: poison driver state info
>    * @security: security driver state info
> @@ -496,8 +524,8 @@ struct cxl_memdev_state {
>   	u64 next_volatile_bytes;
>   	u64 next_persistent_bytes;
>   
> -	struct cxl_dpa_perf ram_perf;
> -	struct cxl_dpa_perf pmem_perf;
> +	struct cxl_dpa_perf _ram_perf;
> +	struct cxl_dpa_perf _pmem_perf;
>   
>   	struct cxl_event_state event;
>   	struct cxl_poison_state poison;
> @@ -505,6 +533,20 @@ struct cxl_memdev_state {
>   	struct cxl_fw_state fw;
>   };
>   
> +static inline struct cxl_dpa_perf *to_ram_perf(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_memdev_state *mds = container_of(cxlds, typeof(*mds), cxlds);
> +
> +	return &mds->_ram_perf;
> +}
> +
> +static inline struct cxl_dpa_perf *to_pmem_perf(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_memdev_state *mds = container_of(cxlds, typeof(*mds), cxlds);
> +
> +	return &mds->_pmem_perf;
> +}
> +
>   static inline struct cxl_memdev_state *
>   to_cxl_memdev_state(struct cxl_dev_state *cxlds)
>   {
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 2f03a4d5606e..9675243bd05b 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -152,7 +152,7 @@ static int cxl_mem_probe(struct device *dev)
>   		return -ENXIO;
>   	}
>   
> -	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
> +	if (cxl_pmem_size(cxlds) && IS_ENABLED(CONFIG_CXL_PMEM)) {
>   		rc = devm_cxl_add_nvdimm(parent_port, cxlmd);
>   		if (rc) {
>   			if (rc == -ENODEV)
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index d0337c11f9ee..7f1c5061307b 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1000,25 +1000,28 @@ static void mock_cxl_endpoint_parse_cdat(struct cxl_port *port)
>   		find_cxl_root(port);
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>   	struct access_coordinate ep_c[ACCESS_COORDINATE_MAX];
> -	struct range pmem_range = {
> -		.start = cxlds->pmem_res.start,
> -		.end = cxlds->pmem_res.end,
> +	const struct resource *partition[] = {
> +		to_ram_res(cxlds),
> +		to_pmem_res(cxlds),
>   	};
> -	struct range ram_range = {
> -		.start = cxlds->ram_res.start,
> -		.end = cxlds->ram_res.end,
> +	struct cxl_dpa_perf *perf[] = {
> +		to_ram_perf(cxlds),
> +		to_pmem_perf(cxlds),
>   	};
>   
>   	if (!cxl_root)
>   		return;
>   
> -	if (range_len(&ram_range))
> -		dpa_perf_setup(port, &ram_range, &mds->ram_perf);
> +	for (int i = 0; i < ARRAY_SIZE(partition); i++) {
> +		const struct resource *res = partition[i];
> +		struct range range = {
> +			.start = res->start,
> +			.end = res->end,
> +		};
>   
> -	if (range_len(&pmem_range))
> -		dpa_perf_setup(port, &pmem_range, &mds->pmem_perf);
> +		dpa_perf_setup(port, &range, perf[i]);
> +	}
>   
>   	cxl_memdev_update_perf(cxlmd);
>   
>
