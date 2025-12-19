Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74362868B5;
	Fri, 19 Dec 2025 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766156791; cv=fail; b=vEfkic3tJ+zDQFwrBpcEPrZgM7yA9WRNeLmwG0g0mn+3kgQMk5H1FALxdq5MDA1fwS/eWde54XIUQJitfIm0UjyG7Sruq083FVj+ngRT7zt2towXRSa1l3C7WzCPLxJ1XagfjpOOKp1pOa5eOTZTE4IGopEW5fcsJOFPq2JswAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766156791; c=relaxed/simple;
	bh=RZ0j6zIZ4AriXk1sHjSAT8ucsgpsE2JuUuYgcZ0NNUs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k02Ra6e8eoZR7gDIgEWh/IKytcCgkhs26O5e6Rr5Ch95RKO//8vGmzBZGCmYExMI40NF3ua0TWWey/1/FOTSPVVSpHaveQ2UJ8qgNcc0jU5yWgDdPwlo+jSLmTGYuYPzBWL4c7NM6Pd8p6D4ovdxYTBo1EhiowaO5R9iB+6QMk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qrfrr5if; arc=fail smtp.client-ip=52.101.56.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qrfrr5if"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uf2lGCt4Z/sMjm8tgpib2OkRqKLn9+usbJb7k0YgXnq1nYRynttq9l8boQASTUs6ocQsI6RCB3j393nWdsuCcx22S4ND5qoVzceMPNkW6jWN2/3z8H5h9P4RIAg//BP/Pb2zVNr7L25/ZP167+v3+fLgC1NO3NPQF01WG1mkTtdzlo+tNIM7P1gNtJoiSqZkVRzG6zTi4t91fTkLonttNXKY7R2M2nqgLOEpds2OKU/ep4cG5CxsXfV8qCdnEz98rwXLXNqiX4m+nHOci/vMPhlJydPdU2yIAM+Mj6gJY22lvRPIIdDAYKZolq+zKnfsH/KEnywu8CXZ66Fe7sV0eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1tIGkQPMdaa/o1e1ykzr5J6Vg3h0RyumJ/gji2UVMk=;
 b=h9k4z7mrkzyn+8ur40RPL9xp+ua1Pcv5HzDR0+nb73xRb82kJvsJWnrwR5NqXVIzS4I74Gzec9QWCLCWbZNje8eiI+LKVlxeCcgQDUz8clTk45TA2+78MVpiRlgvz6KX2xsOrEpKxT/0w9PrJNdqsowGWgQJsGYx9TSOK21HS7SwkLUg2+8nCgm7P9rbjSz99WoQwgj1G6g9mn/+WHRC24f+ovhbRXNMP3DlhWoRnPIOrBuIztWUiYtkxyseO1Hq04XwZue8FmBiBwv6pRndryauVgZZQiBffPF74tfghaVGbGqV1U0h+omdJw11wol2tJsoCp1iBn7YZ8bphk1Ayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1tIGkQPMdaa/o1e1ykzr5J6Vg3h0RyumJ/gji2UVMk=;
 b=Qrfrr5ifDUu6N8OfTZNljLk3uTJk/el5NdwOk3PSObC1jqpxvrADe6zRVA+zACZrN34nuCQ3Ox4Jg+icPoVXe7/8hwKEglGv4iQbDmjD7FXjdUfBBuionWru8i6dJ4GTcoau3gBcjSxpgDXOx+zYlB7l/jdckHfPa+VpWFb5zis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA3PR12MB9092.namprd12.prod.outlook.com (2603:10b6:806:37f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 15:06:26 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 15:06:26 +0000
Message-ID: <f3699701-0442-4ab8-9f36-963a5b9ea4f4@amd.com>
Date: Fri, 19 Dec 2025 15:06:21 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation/driver-api/cxl: device hotplug section
Content-Language: en-US
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, corbet@lwn.net
References: <20251218170747.1278327-1-gourry@gourry.net>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251218170747.1278327-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0488.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::13) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA3PR12MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d800f44-08c1-4571-80ca-08de3f102e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qy9HUHR3WWozK1hWaHpVYUFkR0FyWGtWOFRmUWtlaG9BK1V2a0xoNXphZTdk?=
 =?utf-8?B?ZTc2MEtCN3ROV0pNV2UxdEJBak4rU2d2Q1hXRmx0T1ZtNVpoTXhwcHpIcUhu?=
 =?utf-8?B?c1daRFdKbjQrU3Z6eks1UHRjNE5hRnh6L1dEVkp6bDczdUtjdlI2VWJkUU1u?=
 =?utf-8?B?UWNuUmVGaHEwdnJNSXRhQjlhSVpremFhMFAvSHE1R1k2WXhTek9zMGtGdHZZ?=
 =?utf-8?B?dVc3b1YzVW5RVGpiL0JZMzAxNE4vSzFMRlZ0VERDU2U2ZVJSZnRuS0VjUVgr?=
 =?utf-8?B?aWdibFE2cnBkcjJtbE1HNGVMTUVZckhMaTFBMEJnN2k0M0tneXBkYzNvcFAy?=
 =?utf-8?B?emlEZmRNdmZ0ajAwTFhLRmt1ZXJOUFUrQXlDMVVEN01sZVIzYnlZTEhvRWYy?=
 =?utf-8?B?TXZNQUw2QURGSVJ6QWJBVXN2Q05CTkVjVHJGRGlpTUZ3ck1PSVc5d1B6L2xM?=
 =?utf-8?B?czZBTnZKU3ZsSHlOMkY1aVkxNmdzK3dIb2JNUHlZWlY0d09IM0R2SVBhQVlV?=
 =?utf-8?B?SnI0L0x1YVl4cmlNcG5ycXoyeUh1d05vZHRJb09jZmFKOWNXaURMUkM1NnlG?=
 =?utf-8?B?Qk5sbGlwOWR3MGlpY0N2am1iSTNNZ0FuWjVBNHNubGZ4K2s1ZTBRcmIrMTQz?=
 =?utf-8?B?cW9vWU9Dc05HaXdFWkJpc2lnVXdlL25XdGkzcmJkUU5oUzZOYWVwdzlLaGVx?=
 =?utf-8?B?NUk1UlpEcmdPamZPSFh6dXRvSEJmZTY1RVpYWTRzakx1UzcxV0N4blFSdERO?=
 =?utf-8?B?a0dlS1dCZTQ3YnlOMGlyOVVYQ25jcjhKN2pPekhvdkF3UXl5VUZubXplYTlU?=
 =?utf-8?B?cHJVbDFZd2NqMEhkQjdHd2RPMXpETCthQVl4M21BTWRXNERzWVhHKzRaV280?=
 =?utf-8?B?WU50TUJ0aDZubEVVWXM2TFFIck9rcWNPcFJaZlJiam9Jbzc2cWo3YWYwWENv?=
 =?utf-8?B?ak1UOGNWK3pjTThEVVJ3eGVXMTllUDhYRThaV21MZ083MHhFMFhxZzltMGVy?=
 =?utf-8?B?aytkK0w0bWIzamhZLzBwMzAwWmlsbFNOOWJRa3daQXJXZnBIS1VLZUlhUjRE?=
 =?utf-8?B?WkN5UWFMek1vV2JRc3M4QjF4RkJXZlRmMHFvOXdUVEVaUWVmRWZIbnNoYm8x?=
 =?utf-8?B?bkcvenVKZmF0VERKSndWZWZxOHU4dFFTQitZbUxSMlkzUENzOXhwMTJaWm9D?=
 =?utf-8?B?RFBwcmE0Q1BWVnV6MjE4L0xMWlpUQ3lOMWNuQkwzbkJUV1dRaVAvVG1xS1ZT?=
 =?utf-8?B?NzhibFJkaUlIWkhDRTQxNW5oZEZaZ21OT2xZdEdENlVwLzJZR0lIUmJMd2dW?=
 =?utf-8?B?emNCN04rWjdmM05rclYxRlY4UkUrTENnUU5mb2ZwcGMxNnAwOVR0dmdMcFRN?=
 =?utf-8?B?cGhCWDFxbm5oMDNqc0Uvc3ZXNFRDdXVRL0diaHBOdVoxZTJTRHdwZXJJVUxw?=
 =?utf-8?B?MVNuQlUvZ1pKNjVSenhyZjBpeTdsVDhNMjErVnNkbVFEQXg4bE92L2tuYzU0?=
 =?utf-8?B?OUVtcHNXaWtnOHVVSS9OTWs2NVdaVnB4N2ZDZG9vWU42QUk1elR1OWJOdEhI?=
 =?utf-8?B?UHRSYVIrcERBMkI5MzVDSGEvWWZpbUNSK08ydVJva2dtR1BxUUVra3FJYmpP?=
 =?utf-8?B?aCsvVGFiekUxUmFOck1QTkNMZmp5STdWS0k3d1lhV2FRU3psdGNUQU1ZT3Ba?=
 =?utf-8?B?TndNVzV1cGxVM0RKbS9iNlpEV0U5YU43YU52bjZialBYb3dpdUI5UWN0cXZT?=
 =?utf-8?B?QzZwS0xnRE1hbFNuQ1I5QWhaOFd2alZqc0U3NzczcDFIaE1QMi83QjBrV2V3?=
 =?utf-8?B?UUNzNE11R3ZvOUY1dnBUeDBtR08zRDBjcS9ZcmZEWXpPbWhCdnl3NHNuendX?=
 =?utf-8?B?K1BBQ3N4NzVqSW9ZQTVHWCtqT2hPaXVIdzBPWmhQSVRKekIvSlVobXF2aGll?=
 =?utf-8?Q?PeT8vDVzb8uaAE5yjR69kV++Bg8fOhMK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVNoVUc4bFlJZUtPNjdiQjBGU29pd0tlNGg4cWJlT1g5NytUZFdBMHdPZzI4?=
 =?utf-8?B?dkNYalpDZ2JGQUYwa2hiZW9QYnBrSHhlZXBUYmFCQ3JaTWVBYVA1MjIwSXYv?=
 =?utf-8?B?TXFDQ3NPWjU5eUI1Q1daQjFSb1J0WHB2a0kremh3N2xDck14ck13anVoL1Nx?=
 =?utf-8?B?V2Q1U0NONzlQR1pSdzVheGxacFB2WXI4eURqNVVDVit2MlZkRDI1SFh3Y0lN?=
 =?utf-8?B?T1ZiWVMrRGJkNVpXLzl6WWNrSFJxRVFlUEtWVjNFY1lWWWdYNnRLYVVGUFpt?=
 =?utf-8?B?Qy8wb1oxZFZVVjF3Vm1yVW1iRlpKY1BwN3JJZXQ4WUlOUmM1YnlVUFRmbWdH?=
 =?utf-8?B?TzFyWFhtS1BwRGJ2R2N4QTF2a1VMQncrZWtXa3JZbXBpMkQwbjZZRG5GbUhR?=
 =?utf-8?B?a2MvMG9ZbzhiQTlJZ2Nvd1RvTDZta3pHMG05ckVJSTYrNmFtYUpyaHZ6UEhr?=
 =?utf-8?B?OGNubU1lQTRwYzZJc1dycEZjRW1kcXJrcmdPM2pvS25KV0dkTEM4eXkwbEkw?=
 =?utf-8?B?WFlKcTJ5TUY1YTVSc3JhcVlVOHJSZzFINnBERm9WZGJWN2hjU01vL1R5TUVy?=
 =?utf-8?B?aSs5TEYrS21HSHVJZC9hVjhsVU52VlFLd0o3eFlJK3o5QS9xVnEzVDZtZGVQ?=
 =?utf-8?B?MnJkcFVvem12cE15bzF3V093NitlcGNQb3ZSSVE0MUc4ajdOOXhpQjFxMUQx?=
 =?utf-8?B?TFdsZzNhMFlPZWgrc0pjSHp5TVc1VUJpalhZVUlGYXp3Z0poUXpkeHJwRHFU?=
 =?utf-8?B?elhjOCs5ZU12VmJLSGtRRE01dnNTZ2NiQjV6eHg0UXpoUVJRNktIMER4Y1FK?=
 =?utf-8?B?alZCTklFYklEVlF1T0pYaWpsdXZKL3krWlJSTFdPSXF6Rmk3aWd6RllxTHQr?=
 =?utf-8?B?QlZrNkVKM251T1JBNUZiNHNySzdpRmlHaWMrVUR4TmdSNEI1dUtBMGtRVG9l?=
 =?utf-8?B?aVAwUC8zcFlsdWNFSnpsUnRsbnc5dWNxdzVrZHBiWERKUGFwK05YSHZvVlRk?=
 =?utf-8?B?YWlGS290KzBmdUZYUTJNU2E3TGVvZVZQcmoyN1dGdlpuWlArcG44Mlp1MlJK?=
 =?utf-8?B?MElOOUthWmk2MkQ2QnhJKzFtSEJMK2NyK0xjSENwaUsrSEt0Q2c2WXZqTzZG?=
 =?utf-8?B?MTlpbHRuUmNCTWhkVFBJN0ZtcERURFdsaXBKOTh0a3orVFFPUk1qeWJMcWM1?=
 =?utf-8?B?cnVQWmZqNEtsK1FzTVdWSjdjVXFkcG5Rb0IwMHpEK08xVU9PWEJObHduK21Z?=
 =?utf-8?B?YjdFR0R1ZENFeWlNNEUyT2FFOTR5ZFZFWXkvejFFakQ0NjBQQlc4cHJyRk5u?=
 =?utf-8?B?am81NHlvanhjNk5kN3V1RzJ6OElmS3pZOFRhQmdaQTF0cDVnT0Z4WmFuN1Np?=
 =?utf-8?B?VGVVVE44bTVOUmhwQjJsQmFnMFpPNUdOYVdJTGdzZE5ib0ROSitCL2MyYjZw?=
 =?utf-8?B?TDkydFhHZ2FqTFZEZ2xId3QvYUJRbFl0bEo3dnVuOUxyTjBVc0l4MFVpemY5?=
 =?utf-8?B?Smc5UnRJcWVvRHpIRnB1R3BLRG0waGtWSHlKc3BYOEV5Vkk5Uitac054L0VY?=
 =?utf-8?B?bG02S2JsZUFzSUdFcngvL2RwVTRxVUJZUCt5bHVNUEdoYmlIMU9Xckh1dXN1?=
 =?utf-8?B?cEpyb05HdFZBUC9zUjI5bHMxTUpQQ29HeVByZzVQU08vQlNkK1RSME1zcG4y?=
 =?utf-8?B?NHNzdUN3WWxUTDZBSmhDNXRWVUtxZFRTcGxZMjFsU1hweEs0dUs4NHlxNG1x?=
 =?utf-8?B?WUJFcDBjMGJ1NU5RVnBhelhnMzlWUjBoKzlIRS9teEdXTU5ZT01FN3QzSzRV?=
 =?utf-8?B?SFRMMUkzNE1ET1htVWZ5c0RHSStNL0oyTm00VkZLRXgwRldicU1YOE9oa2lY?=
 =?utf-8?B?c21TSTlhZXZFNU9PQWRkejNOd2sxaXkvZk41elorZE4vdjArOWwwOEhWSWQ5?=
 =?utf-8?B?U2luYU50TzJTZFd2ZmRTUURybTFIMVBxZzcvcHV3cDg5dmpLTG51a0JKWlZx?=
 =?utf-8?B?MnV3Uks3OFBBY0hmSHFaQUJ6MkpmV2ZJbW5xTUkxbzBKYVN3MCt0TytFNEhH?=
 =?utf-8?B?LzkwYTROYXhXak9PUkE5VkFnaWRrcFlpM00xQU8rUXg4WHNSMXk4OEQ0VlZD?=
 =?utf-8?B?ZXNXa0p0WWEydnFLcGMzR0NZT2gvN2RsVTVMN25CekYzRGVLUWVqRkFjVDNj?=
 =?utf-8?B?dXpVVHZqaGE4VjVhVG1yM2o2RGdnbVl1dklTUFdYRnFtMU1lSXlUSUtwNkFy?=
 =?utf-8?B?MTY5bU8xajlGV2VzbmFwRTZ0LzVscVNFYzdHbTRvbUFLTTlHcFVkSjIwc1hh?=
 =?utf-8?B?Qi9oMnhoeXkveGdMS1lzMkYwaGt1MGZWZkVlTzVVUnhyMmlRMTVQUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d800f44-08c1-4571-80ca-08de3f102e00
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 15:06:25.9629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rL9mQrEeIFujJusPwuBWH6X9/Hxw7Cldv2lnoXjte3YjcNUjAWKYBJ3c/TEe+lifZ1IKl7ivxOIZN8As42o9vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9092

Hi Gregory,


Thank you for this addition to documentation.

Just a comment below about something we talked about at LPC.


On 12/18/25 17:07, Gregory Price wrote:
> Describe cxl memory device hotplug implications, in particular how the
> platform CEDT CFMWS must be described to support successful hot-add of
> memory devices.
>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
> v2: Jonathan's clarifications and diagrams.
>
>   Documentation/driver-api/cxl/index.rst        |   1 +
>   .../cxl/platform/device-hotplug.rst           | 112 ++++++++++++++++++
>   2 files changed, 113 insertions(+)
>   create mode 100644 Documentation/driver-api/cxl/platform/device-hotplug.rst
>
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index c1106a68b67c..5a734988a5af 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -30,6 +30,7 @@ that have impacts on each other.  The docs here break up configurations steps.
>      platform/acpi
>      platform/cdat
>      platform/example-configs
> +   platform/device-hotplug
>   
>   .. toctree::
>      :maxdepth: 2
> diff --git a/Documentation/driver-api/cxl/platform/device-hotplug.rst b/Documentation/driver-api/cxl/platform/device-hotplug.rst
> new file mode 100644
> index 000000000000..617e340bd556
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/device-hotplug.rst
> @@ -0,0 +1,112 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================
> +CXL Device Hotplug
> +==================
> +
> +Device hotplug refers to *physical* hotplug of a device (addition or removal
> +of a physical device from the machine).
> +
> +Hot-Remove
> +==========
> +Hot removal of a device typically requires careful removal of software
> +constructs (memory regions, associated drivers) which manage these devices.
> +
> +Hard-removing a CXL.mem device without carefully tearing down driver stacks
> +is likely to cause the system to machine-check (or at least SIGBUS if memory
> +access is limited to user space).
> +
> +Memory Device Hot-Add
> +=====================
> +A device present at boot will be associated with a CXL Fixed Memory Window
> +reported in :doc:`CEDT<acpi/cedt>`.  That CFMWS may match the size of the
> +device, but the construction of the CEDT CFMWS is platform-defined.
> +
> +Hot-adding a memory device requires this pre-defined (*static*) CFMWS has
> +sufficient space to describe that device.
> +
> +There are a few common scenarios to consider.
> +
> +Single-Endpoint Memory Device Present at Boot
> +---------------------------------------------
> +A device present at boot likely had its capacity reported in the
> +:doc:`CEDT<acpi/cedt>`.  If a device is removed and a new device hotplugged,
> +the capacity of the new device will be limited to the original CFMWS capacity.
> +
> +Adding capacity larger than the original device will cause memory region
> +creation to fail if the region size is greater than the CFMWS size.
> +
> +The CFMWS is *static* and cannot be adjusted.  Platforms which may expect
> +different sized devices to be hotplugged must allocate sufficient CFMWS space
> +*at boot time* to cover all future expected devices.
> +
> +Multi-Endpoint Memory Device Present at Boot
> +--------------------------------------------
> +A hot-plug capable CXL memory device, such as one which presents multiple
> +expanders as a single large-capacity device, should report the maximum
> +*possible* capacity for the device at boot. ::
> +
> +                  HB0
> +                  RP0
> +                   |
> +     [Multi-Endpoint Memory Device]
> +              _____|_____
> +             |          |
> +        [Endpoint0]   [Empty]
> +
> +
> +Limiting the size to the capacity preset at boot will limit hot-add support
> +to replacing capacity that was present at boot.
> +
> +No CXL Device Present at Boot
> +-----------------------------
> +When no CXL memory device is present on boot, some platforms omit the CFMWS
> +in the :doc:`CEDT<acpi/cedt>`.  When this occurs, hot-add is not possible.
> +
> +For a platform to support hot-add of a full memory device, it must allocate
> +a CEDT CFMWS region with sufficient memory capacity to cover all future
> +potentially added capacity.
> +
> +To support memory hotplug directly on the host bridge, or on a switch
> +downstream of the host bridge (but not contained within a CXL memory device),
> +a platform must construct a CEDT CFMWS at boot with sufficient resources to
> +support the max possible (or expected) hotplug memory capacity. ::
> +
> +         HB0                 HB1
> +      RP0    RP1             RP2
> +       |      |               |
> +     Empty  Empty            USP
> +                      ________|________
> +                      |    |    |     |
> +                     DSP  DSP  DSP   DSP
> +                      |    |    |    |
> +                         All  Empty
> +
> +For example, a BIOS/EFI may expose an option to configure a CEDT CFMWS with
> +a pre-configured amount of memory capacity (per host bridge, or host bridge
> +interleave set), even if no device is attached to Root Ports or Downstream
> +Ports at boot (as depicted in the figure above).


All this is fine, but my concern is what the BIOS will do when a device 
ends up being hotplugged. Assuming that programmability from the 
Host/user space for creating regions on demand based on requirements 
like bandwidth, and therefore relying on interleaving and granularity (I 
know this is not trivial but I think this is possible in the near 
future, or at least possible to be demanded) then the BIOS should not do 
any HDM programming at all ...


I think it is worth to document this somehow and maybe to discuss this 
with BIOSes vendors if we consider this convenient.


Thank you,

Alejandro


> +
> +
> +Interleave Sets
> +===============
> +
> +Host Bridge Interleave
> +----------------------
> +Host-bridge interleaved memory regions are defined *statically* in the
> +:doc:`CEDT<acpi/cedt>`.  To apply cross-host-bridge interleave, a CFMWS entry
> +describing that interleave must have been provided *at boot*.  Hotplugged
> +devices cannot add host-bridge interleave capabilities at hotplug time.
> +
> +See the :doc:`Flexible CEDT Configuration<example-configurations/flexible>`
> +example to see how a platform can provide this kind of flexibility regarding
> +hotplugged memory devices.  BIOS/EFI software should consider options to
> +present flexible CEDT configurations with hotplug support.
> +
> +HDM Interleave
> +--------------
> +Decoder-applied interleave can flexibly handle hotplugged devices, as decoders
> +can be re-programmed after hotplug.
> +
> +To add or remove a device to/from an existing HDM-applied interleaved region,
> +that region must be torn down an re-created.
