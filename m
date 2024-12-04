Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918A114885E;
	Wed,  4 Dec 2024 04:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733287309; cv=fail; b=reAVxLWmyyCbZR72C+7MGRt89KoJj4wsnxypyapM2dxQVw7xNu0wHw74RELLQa0CVxZ8TR2fcEWNR+ZE5kySfBvtaKeQln+wMbqAqyB0sSGOuAUkCeHyYUuc05W2izJqjWlk9jqs+XPlC2XoyDaGBGN8/unOWtBDvIB4y8LDj5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733287309; c=relaxed/simple;
	bh=R5oz32arf6CY0yxcHIaFRldhavW9wI3uE0k0hvIwmMo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gaj598UzgMa5/LzVNidDjqM2kvmH9veE7ql2971LCgZJ8ioBRNKbTOgZVZuYnr9Q4E/g+VLpUO3cvF2wtBAfMo6gCS9zkOEbO7Iv9K+S72MqpydGMOPeYbT7/bWMTvZTqHoib3ox5sN+3yVwC60UdOBxwnnauFjglXaNqQ2twyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rS7LCVKP; arc=fail smtp.client-ip=40.107.100.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rS7LCVKP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6JPfh/KEMN25axqTf6Q+TIclnb+xyMAuGJSaVmBWAhZ2TLM777u9w6HBsaQDMIUGzCmvKxHSahA7JXMgpIo0q6cy4N6YuzTp7NGXceImufl4kTNtIuP134aKHRlJAmbVC/1Jxcwut089WNJzXU8odTXPc0Rd72d1A8q52Xd2bZn+slskpp4W5XETmdfZwrVK4De1wtQkWMmBI1CXcairl1PPuHxO8kHn/+UWvAT4HdAYiYitBOjNhlsDCX4nh6tFle8unkZBnAHMxN4CT0oDc5dGO1KYwzDzYOkjLq3+HJfsVLsyFY/7YrQOTyY8jio7v9oCftNd1pIjbf31OOMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciIWWjbmseMykdboMe6ZVhuo+O0lBYIKJ6ucZNg4LBY=;
 b=VgjDYyMgpYIhvSkkd/1zXyTU1oWqcH/t0B/SJAJLK47oPzXO/8ZWQJ7yjUu1m8qAHIAGgnG+Y9+I861vOErdMUUXcdvmqxfvuZZ+ICooYiHFEM30gbhRzIyQZkOcW77p6ZaxzZxkzRYqBzMS/Aw9XLuuvh6/93SndD0AoxkNd4rr221bLQy1/c6CgnOzirzwNsWunvq4UMgaJvB2lgt4a+RII0+w78lAg7GM9XsKub4cUnW7w/l0UJeZG/BQWXbIBBw4xLyP9PfbRVnTho+U12uX61k3IiwDt0KjkvW6sEqy3bsxALBnQ33FXWqRFoLbiIsuo0l45jhcHCGmVa/EDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciIWWjbmseMykdboMe6ZVhuo+O0lBYIKJ6ucZNg4LBY=;
 b=rS7LCVKP1UcwCCMpit//K3qVmGIcOq3PxYTML57HIMxqslMC8bPUVWTBTlDzVK/IDCxfuSy+CBfJRpNPpCAtTRSfTjwPIOHb4twBINUPbq93+l2END0yECbayaMJ64T80ejUaO88uNIg3XAkKd4s0WyMob6nM2fVZriRMfC08N0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by MN0PR12MB6224.namprd12.prod.outlook.com (2603:10b6:208:3c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 04:41:44 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%4]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 04:41:44 +0000
Message-ID: <33b4b93b-5ab6-4a3b-b3b2-c9b3cbc9d929@amd.com>
Date: Wed, 4 Dec 2024 10:11:33 +0530
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
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <674fd2b4942f1_3e0f629420@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0048.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::19) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|MN0PR12MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: ac461989-edd0-492d-d5ff-08dd141df420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlowUEV5QlpvYWo2c1BmYUYzRDRteXZVajdlY2lRdHlnZTJpMCs2T3QyZ1FN?=
 =?utf-8?B?S0ZYeng1T3N5U2ovaFF3OUtVSUVBYUIwQUgwbmhrcjZ6Mkl4VmxGaUlWRGdT?=
 =?utf-8?B?SnNxNG5SRHQ0cVpEV25UZmpJd1Z6Si9ib1pDVStLRmMya3dVTDFMWGRIVUtv?=
 =?utf-8?B?VHVpSWo2SGE3eUdFMDZVc2tLbHVGVFQxTlViTi9xMm1laU10OFpoeFNtc3lq?=
 =?utf-8?B?UHk1MkQzUXkrYXVUeUFrMmFWdlNqdVdiNG5LOFdSaU92d0NMd0JKTDBtNWdr?=
 =?utf-8?B?QS9BMDRFR0VWK1VYSWlQcXJreVI4c1ZMRUN2anQ1bkZNQWgxdHNpSlJtVENn?=
 =?utf-8?B?dFV2NUVWSDdsZlV4MnNuK0E4WHFSNEI2WWxyL1dZVFRNWDBISEdVLzBQb1gz?=
 =?utf-8?B?SzY5aUxmRE5kZU41MmNkV29Dbk9EK2dEd212WTB2UFE2ajUwcFVwY1pxYUNp?=
 =?utf-8?B?Wk9PTzBvRzlTTEJGeW5uSW9VM0gzZjJPTnNjVkpEMXM3M0pBYTNGRExlOHMr?=
 =?utf-8?B?OGNzZmRPZjYxUVZ6M3hzYWlLTm5MQktYVmJwMVRiUUJXWEtUdm9ZRUtrT3NO?=
 =?utf-8?B?R0tNaVIvcXN2N04wWmpwbzdYQkRuMCtBT3EwUnc2OElVNXYvWmx4MWRvSEd3?=
 =?utf-8?B?QlU0WGdPRzloVTRZaGJzVGNyRmpCSTRvbXZWeGZqZmhWMFpXM1hNT1ZPeGFw?=
 =?utf-8?B?cjRCZjk1bG5VaUF5WmdNNGV3dTRYWmdjcDd2UlJwY1VWekZ6bythN3d6eHRD?=
 =?utf-8?B?U0pKdFVzNzROZXhHK3h2SzNReUpYQjVKOFBiTVVYajZ2TlU1cDBiN2RTWUlm?=
 =?utf-8?B?ejZ4VHpOMU8rbWZqRWxZODRERVdlWUJOTkZzdkJuL2hISHoxR0V0YlhsQWVH?=
 =?utf-8?B?TDA1VzNtbFhCd2tjdkRxaXJNU29SOTVSRjcram9jOE5vbytFQ2pEbW5TeGtL?=
 =?utf-8?B?YVdPeThRUGNPY2xXSTN6NkcyUXlIOEdCM0JRVXJTWnhWVTVPSzlMMzNFQlFV?=
 =?utf-8?B?dlFVaWkrcnd3ZHE4VEZldlR6M08rZzRRNmZISlZ2REYwZlBmY29VblhtMElF?=
 =?utf-8?B?RE5HVzhaYTZseG1BRFQrU0tQVDJqRnoyV1c4NERvSWNpZFE1d3ZLSmNYVlNY?=
 =?utf-8?B?TVNrZDdpb3I3aXN6OHU1Skcwd0hwanJkaVR3STVaQXBGOVkvQmZIZkptTE95?=
 =?utf-8?B?MVh6andUQm1FamU1TVdwNmlaa3BVL1ZucHdldndjVGg5dVZYZkg4aXVjWFVk?=
 =?utf-8?B?WDYzc3lFbjArbVNrZVZhYWx4VVNXOTFmLzNQYTRFdjk4d1V4REFDQTROaUtY?=
 =?utf-8?B?dEZtTEx3aW9LeVdWVFQ1TW5IM2F5QzhMZkw4S3h5ZFl5VGxlM0owRmgyYWgy?=
 =?utf-8?B?SG1FSUJwOFhud0poTkc3Y2dqS3hZZzk3N0paY1RGYkZVcWpBdWNRYW53cVIv?=
 =?utf-8?B?TGx0TXJ3YmJyUjdMOGMzUzRPbWhmaHE0SkFYQ2NKRURRR2EySExxb1ZERHph?=
 =?utf-8?B?Ny9Xc1Q2Z2RZcHA2VHRkQy9oL2MwZFBaSnV0RUNMVFhxeVYxYXZXZ0FYZUxS?=
 =?utf-8?B?TFRPUHFKREROUGlzcHZCYll0K2lBNWdld1hERk41eFhRSXFrUUZ2clVPdk0y?=
 =?utf-8?B?WEJudE0vNnlYdzNxTSs0Zm9UaTJsWmJSZUZ1WDFjUFppUTZuTGNLSDRGZVFy?=
 =?utf-8?B?VUhHSnBFc1BDelhiYjF6MzhkU1FpV2tjYTNJZU1uTmc0alQrOVJVYnF6R0M5?=
 =?utf-8?B?UkIwTUw1cTJQMFNHOFRoYk9XUzhnK2E5VlozK2dxaXpLYkRlNmRCMHNjMlZB?=
 =?utf-8?B?Ymd0TVIybkNpREZmcU5yZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0JxZW9PS2oweHNsbjdhODRHbkxvVnI4Vlh6TUo1Y0pZbURPc3lIL016QnRH?=
 =?utf-8?B?ZUNXdFdaU1hzZ21Sam5lSy9pb1VYL1g4RXV1YU8vZ2tlemsrdmVFT1hLdDZ4?=
 =?utf-8?B?RGlyaExsNUMvUTlhTlFKL2o1bVQzQlFEbnE2bmdWOERWdU01MWFqUmpER2Zh?=
 =?utf-8?B?UEpRZGtta1hicVN3RlREdit0Yms5Skkwc0wyQit4RUZjSGpnMThjSWdLcFQv?=
 =?utf-8?B?QS90amNBOVZuOUdDWUlBVzQyK1JldUZiTHU3bjQ2ZERxQ3VDeWhUVU44RUs0?=
 =?utf-8?B?Uzg0a0ZmUFZhaXBHUnoydlR3NWpzdmk3TTNGSVRnYkdsZWV2OFBDN1M5ZUpj?=
 =?utf-8?B?aENWTUM4L2NENUYrSzBvTHNISXp2VzRHU1VLZ2pHa21lbThLSmMrTjhWM280?=
 =?utf-8?B?cFZ2VWhnMWJuakdhYkR2TzVGU040cG5xeFV1UWNhU2RTWjc2dVl0NldXM0F0?=
 =?utf-8?B?VHJRT1lBZDdGblpWZG9vNE5ZazlMb0dkdXFFdEtNVnBXZ3RnejZOanl6NHpp?=
 =?utf-8?B?dERrblpldDZYSGtwMmxMckdxOVhSaVRJN0hidHNYYXZkZEFZRG1yNnExNHly?=
 =?utf-8?B?NkVsWDA5VnJpaXRWT2xmSE1XbHBXVFVkY1Z6eVFHRjhOdFdwNklQSVdBeC90?=
 =?utf-8?B?amZoVWxZcU1zMTNxeUZCYmN2YTliY1hNWlBCL1ErRTB3ajJmT29WUGtCMTRs?=
 =?utf-8?B?SWJZZGJFOW1JaTZMeUxDRVU0UmtvSW14MVJmSm5wRHFidzZETzBRN3RFYXhk?=
 =?utf-8?B?YkV2dHlxdmJBSzNaNFp2cnFZMG05blJDMVhLTDZSYm5JcmYyaFB4ZWo4RzdF?=
 =?utf-8?B?MDhiK29PMG8xUmhNdHZXVW5LdkVhaHJBSUptTFU2MFhiY2xmUVYvcHMvYmJU?=
 =?utf-8?B?ZUFyMXgxSFpiRnNuS29BdThqWkdleDdqcGVFcllPN1NCWDJQS0o3eWl3MmZo?=
 =?utf-8?B?dDJVZlY5eFBUbzU0SC9TbUdaWGJzc1RZbkNhQVh1TzJVOUxPVDBWVUR1WjRr?=
 =?utf-8?B?L2p3WHVKM1p0VEV2V2dCamhvN2pWdkJqVGpYbUkvdDlrdnd6VEtYU0QwSUhU?=
 =?utf-8?B?SzBJck4rT3FOMUc1SXYraVM3MmZKMWJRVDArdmZuMUcvcDFKY0prNTMra203?=
 =?utf-8?B?L0RIM1JZSU9QeHczVFkxSGxwRHBKcDV3YXloN21CUy9jUUdqWU9GK3NySTRH?=
 =?utf-8?B?MGMxUUlrdWkra2RQNko5Rjh1TjZsTkl4TnFKcUhJNlVEemp1YkJFVkxkanAv?=
 =?utf-8?B?bm5vMTJ5SUFDMHA3ZVNlYkNWd0NvZS90ZTY5ZlJMM3U3YTBMc09KSDZxUHZV?=
 =?utf-8?B?OGZzcG1rSzA3M08zWDdhZDVZN2tZcVZ2SEYweEppbytXelcrcFJ3d2JiWmdz?=
 =?utf-8?B?ZzJoNUZ2ZzQ1MGVtZS84bU00SGFjbUlQMDFXK1RuTlhiR3pKQUxGUlNXaStE?=
 =?utf-8?B?WGkyVHpyRWdYNUZRMGJZTDlGZTVOMENIcFZDM2VnTXh3SGM5WXd6Y1Fuaisw?=
 =?utf-8?B?eFFVRnA4M3pXNGoxVlEzb201U1hlbG81dWcwTmQrVDJWNllpMEdmKzZJekhN?=
 =?utf-8?B?U1VGeUY4TUt4L284d1d2NFFUUDRTSDJEQlA2dEw1Z21DMHlXcXR3Qm5lMDcw?=
 =?utf-8?B?Q1RiclRlTTZGNUdVTWd2ZE9Ma3d1UXkra3R5R3FiNytIdGtsUXdhT0NuYWNO?=
 =?utf-8?B?ekRtaHUyWTlsN1N4ejJpWXNiY3JrRXB4UFVpSzhaN3lqOVBJTW54MWJlMDVP?=
 =?utf-8?B?V01BWkVvWDI0ZGdOcWJxZWN5SUxFM2hBelhnRUltZ0s5NVFOZXo0aklmWWNP?=
 =?utf-8?B?UXBCTzcwellRRHRiWWNTZlp6OTdaYnhlZi9CZ2lQUjZPQ2lUMXZjSVZ5L3o1?=
 =?utf-8?B?WlE3eWdXbThsUWVWeDZxcEZKOXdJakU2VHJYcjRsa3RCMVNMMHBrODRabTlw?=
 =?utf-8?B?bjF1U2JnQkh1Q1Yrb3NkZU5lMzlZS3ZOZUltVVBmaCt1YkFpSDNtaW0zbkZj?=
 =?utf-8?B?VUR5WWFhelBHUVl0bHFBUkZLL3JOVHNlZVA3N25tS1QwVVdlM2kvcEh2dDg4?=
 =?utf-8?B?ZS80akQrdXR2R3hLNE9SbE9WT0ZxVGM3QlV5QUF2Q0Jta0lFanJsNjg4Wnpt?=
 =?utf-8?Q?elI5g2EA1oaVFsL8UGrcpMYgI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac461989-edd0-492d-d5ff-08dd141df420
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 04:41:44.2508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCUtkYlLqfqqoT359tMFHI+LTn/ULWF0SpTEbclOlqStmytgMhuz5PJQJ0fwl9G/IJSmESjudVsxZV5TIDyv/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6224



On 12/4/2024 9:25 AM, Dan Williams wrote:
> [ add regressions@lists.linux.dev ]
> 
> Next time make the subject of the patch:
> 
>     Revert "resource: fix region_intersects() vs add_memory_driver_managed()"
> 
> ...to make it clear that this is a revert, not a fix.
> 
> The revert should be applied if a fix does not materialize in the next few weeks.
> 

Agreed regarding fix.
one thing to note is it is not exact revert.

> Raghavendra K T wrote:
>> Before:
>> ~]$ numastat -m
>> ...
>>                            Node 0          Node 1           Total
>>                   --------------- --------------- ---------------
>> MemTotal               128096.18       128838.48       256934.65
>>
>> After:
>> $ numastat -m
>> .....
>>                            Node 0          Node 1          Node 2           Total
>>                   --------------- --------------- --------------- ---------------
>> MemTotal               128054.16       128880.51       129024.00       385958.67
>>
>> Current patch reverts the effect of first commit where the issue is seen.
> 
> Might you be able to dig a bit further into the details like memory map
> for this platform and ACPI SRAT tables? A dmesg comparison of the good
> and bad cases would be useful (those can be shared via a github gist).
> Even better would be some debug instrumentation to identify which call
> to __region_intersects() started behaving differently resulting in a
> whole node disappearing.
> 
> In terms of the urgency of fixing this it would also help to know how
> prevalent the system this was found on is in the wild.

I have compared dmesg, proc/iomem of both success and fail case.

A. dmesg:

1. Address ranges is different
2. extra message about printing Demotion target

Fallback order for Node 0: 0 1 2
Fallback order for Node 1: 1 0 2
Fallback order for Node 2: 2 0 1
Built 3 zonelists, mobility grouping on.  Total pages: 66145521
Policy zone: Normal
....
Demotion targets for Node 0: preferred: 2, fallback: 2
Demotion targets for Node 1: preferred: 2, fallback: 2
Demotion targets for Node 2: null

B. /proc/iomem

$ vimdiff success fail

  4050000000-604fffffff : Soft Reserved 
   |  164 4050000000-604fffffff : Soft Reserved
   165   4050000000-604fffffff : CXL Window 0 
        |  165   4050000000-604fffffff : CXL Window 0
   166     4080000000-5fffffffff : dax1.0 
        | 
------------------------------------------------------------------------
   167       4080000000-5fffffffff : System RAM (kmem) 
        | 
--------------------------------------------------------------------


I will get more detail from ACPI SRAT table etc..

Thanks and Regards
  Raghu
