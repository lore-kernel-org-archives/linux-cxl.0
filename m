Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C7A433CB
	for <linux-cxl@vger.kernel.org>; Tue, 13 Aug 2024 06:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723532370; cv=fail; b=sHKTpTOmZ29xsdklyGYAmSBXimeH7aLngNN8cUb9uBFcOSOfxtUIAX0BvitY9Bw9gYqxQ7OacjMISkgjvgjA2yJlnxL8PYdjvvzB/LJiarp3j+4Jxsqc+5eE5sXUyE1jU3SLoNLqg6ouSvZUxoj5PJ8uned6K/Vjx3c9Joa8izU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723532370; c=relaxed/simple;
	bh=8YV/EQyF8CmkcRAiLSpNbytaNePKi7gJNmyvci8r5qE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KBfRCguAT+Wkt8uSCDLwCJLN6sSHiy1239X3IQtfZtVqmcYJmgkBRmqWuLYySLTZB9jqaPQg3EtUwk4JmVF8Z5z0OhJI8m5Qp3pI2DwjxIbkP41A6ZOmHzwEs7J7x+ABCGyn3QG+FIVkz2WMCowT/JI0ABQlS6OcyAeT+EwkgQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mmDz9sBf; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mmDz9sBf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfTiwcXpLCo7A4thB/TvxuBD+pDVbFtpRv5Dvm/39uUeDZPi2OWwA2L2pW9rzWhx+XEAD4dJBeem0w70LaZff+OpUh0qy0oTeI643oKu1NNwD0k6bZ0FyXqC0CapZQ0xTAbwYO3T2c87Yl+RKaK6b1jDLPA8mtW+p5pTb1YEjRwinN7Gsh+t8uzyI69pue9WKtNO7UcAu+xFWlHo7/WaCN34iQABMwWqv5WmIAae9vR13fCDbZFv1SY+kErx9G/YSVkWp65FYtTbjvhC31raKyv0Jiw+GKWJG1HefBR4NaEx/Lk42S0Y6KgxVSq7koBXnKw49DSDLe0ezgrYJ8gmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MHm+brlCE+y3WwTEFyNAHjOSIrx0DMjRaVKG26JMEE=;
 b=Ben2HIGIUy0pkvs7t0/e3Ur41ww/ER7ivKdBksD8/k3ZXBQjaDP1+BYuKii+8hFRuLW6nDQrFDOJY8sf4JBthxSI0TYRSWa1vYwuem4OGseFMYaLaePdCvS44ybJJ4viK+nyi46e13a+O5jQQDGjnixt3eCKFSS9YdL1w96Vq8NjHFzpe1Yu2ouMKlNXNzZItuUcQ5NWzBkVoRRuQMzpFw8VyCcbN6kHkM5Wy2MNIWVEvA69NOQuTmp/Rl7jE/LJSV1q6xLAXkWwThKvdAxT2K9vMaJX0e9tZBuznODkoYhVBN+VG2y0fncJ5clHAZoeZQJaid4gqcrvFmzxz3bRew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MHm+brlCE+y3WwTEFyNAHjOSIrx0DMjRaVKG26JMEE=;
 b=mmDz9sBf+Ftq9MxxlB1ktUaKBSkZtfr/idTOo8UPc1Bzw3bxc6TgtI2fgTUa51Yn658Nll4RNMxsDvDcGgJlFDxweqbEBCsUgkEkbk7j1oxhpq19NwVKW4wLLhPNpoWyYPi3ldC7FZEAkFMjZclo9W/OHyyvUHWIQyDGLM23ShU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 06:59:24 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 06:59:24 +0000
Message-ID: <695dca44-8df9-4075-5996-31402df1c6dc@amd.com>
Date: Tue, 13 Aug 2024 07:59:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] cxl: Move mailbox related bits to the same context
Content-Language: en-US
To: fan <nifan.cxl@gmail.com>, Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, alejandro.lucero-palau@amd.com,
 dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net
References: <20240724185649.2574627-1-dave.jiang@intel.com>
 <20240724185649.2574627-2-dave.jiang@intel.com> <ZqF6EppBfjnXH0yw@debian>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <ZqF6EppBfjnXH0yw@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0095.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::35) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: 691cc9e8-6584-4e92-0c6b-08dcbb6576bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0tQay9tdUk4SUFtRURKdWE4bHBHTWUyb3FDS1UxVUlOcC9BTmZMWmpPZzlZ?=
 =?utf-8?B?Z1Faa2p1ekF0WUFFeDd2U01mcE80Mmh6Y2VvVk9neEgzZ2xrM0lRQ0FvNTU0?=
 =?utf-8?B?RDl2bnRkWkFSdndLaWxwallCSTFrbkw3UlViRks0VVQrZEh5SkZyQ2l4dC9W?=
 =?utf-8?B?MndzN09GZmlSZ0lDaFFCaWg4aHpsMlliYXd5MklWei84ZmFjanhYK0oxS0Fr?=
 =?utf-8?B?cTVyMFVWQkNwa1BMUUdISjl6NmZDcEVUazRQUmpUV2JMdzBJOElNY29YNmI4?=
 =?utf-8?B?SEdoWDZNTkhNS2FvcnpQd25sQnFFNlBZMnJaUEtqbGFuTHh3K2Vaa3hyTm4w?=
 =?utf-8?B?MERnSlVZRVdBdFJZU2dHV1NNTk40Z0h6Y3lCS0lxL1lTSnNXRDdYUTZVM21J?=
 =?utf-8?B?bjZrZlRsbks3M1JaWnJlRm0zMUJsekt6RGFLK0VPQUcwWHdzOTZzR0NvSU1X?=
 =?utf-8?B?SDA2Z1U0NmgrMFFHU3VuY2NjVlVGYUlRQ1lIaHhzY0tHbWVqTGdVaHhKUisz?=
 =?utf-8?B?cnlmVVVwRnAvejhjamExWVJZbk85TWxoRnJ5dVg4MVFDWWtwSVZIWVNHc0Fq?=
 =?utf-8?B?MUtzUE9Db0M3YTBDY1RvOTV6dHpoREFpT1MrNTFmcFVCSnlpYjdTb3hIeFFD?=
 =?utf-8?B?NmFlSmZoUnJEY2VLMENuYXZ2R0xWY29iS0VDdStOTFJqUmw0M0tOODJrR05E?=
 =?utf-8?B?dmowYlBUSnNpRlRaakdVSkd0TjJ6cUdTQmI5TWlVQmFyclR1ZmoyR1U2MWxQ?=
 =?utf-8?B?YUdNZGxtZVVZQjRJMEdzaDZWWG9OcE8xTTdxMS9VSzZyd2ZOTkVadEE4RE5N?=
 =?utf-8?B?M3JjUDlUL1R1Mnk0VjBJejQ4ZStyMzNOZU8xZFd6Y2hjVkVkd1BldkEyOFBM?=
 =?utf-8?B?NERPVlZmWFhVQVVpa0JSMTRZeWdCYTlzUzk0YUR6Q3pOU05GbCtVUjhCQit4?=
 =?utf-8?B?UWlMeWFaRTE5dm85dXZmR2g5VXk0K0x0dHVieWg1QkVaZVlqZnpGd2tvaThP?=
 =?utf-8?B?Qk5namZ2WVZFMHlUdEtTMUpkRHpLWTZicHhKZTRkejloQXZCT3gvUXI4dmJP?=
 =?utf-8?B?ZVB6ME52UmJWMDQ3UkgreUdsc3gzeWNUODJOb3dIMkhsYWJtZ2cxNldNMllQ?=
 =?utf-8?B?aEsrcml3MTJjR1c5R082em1GSVQxcjlPcWhGT1BuWDdXcWp1U085ZU1pUS91?=
 =?utf-8?B?V09LU2lNcnc1UXBnQ01RNFM5SXdwVU5zZmp5OWVLWHhOTTdqZUl1UzhHaXJr?=
 =?utf-8?B?TGNGalFBQTZtSnlMQktsVGNkcWd1RzkybjhOaGQ1M2JjOHlEUDBFckdEaFp4?=
 =?utf-8?B?SExrYWI4aWFNbG1xSkY3TGN5QzdTVGdOLzZXZEJGZ0FnTTZVS1Zqekxwbjd5?=
 =?utf-8?B?bExSQmxKa2dRNUhIRmdlL0Vld2wvMTR0S21SWi9jS1d4Y3hUZ1YrNWJVaXRk?=
 =?utf-8?B?NGV5SEhhd0hkRE5yMlAybEJuaVJyenc0b1BiMlNJUXJZblR3M09pZmVmaVg5?=
 =?utf-8?B?QjdRSXVHR3lWK3JvQ29ZMzAxY1RwbGkyc3U2dGVlaUZNUFc3eEsrcFI4bnpm?=
 =?utf-8?B?bnNMc2NVQTVyQlcwVUMxL2xwcExvazdkV21HNFJQbG9pSndHTWk4M3ZxTTdO?=
 =?utf-8?B?Z3dUYmJaSG91bjR6THZxTXpnMHdsd2M1NEx2ODc0YlFmZkcxREtMNENpbGlq?=
 =?utf-8?B?RkRzWFZUMFcrbSt6VlRpUE44bjFaVXJDS3gvaHd6bmdXa0hlS0RmUStRUG9j?=
 =?utf-8?B?bVNlYndCUFN4c3FPUnUvTjkyTkdwVEMzVE5Db0Y5eE9QUi9KNUNvRFY0UVVr?=
 =?utf-8?B?cllYSVVtakNZM1k3cEVXdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0Y2UzlhTEJtcnh3Q09GRDNVQnFtREQ1RWROaVBrQnl2QkVCaFN2NTBNWG5u?=
 =?utf-8?B?NEdtSXcrV2dGTnhTRm5Ha0dNbUxTcXlGbHZIRm1MOU5Vb3VzcFc4NFM5L2Zy?=
 =?utf-8?B?Q2tiQ24vdkJ5YXRYUVNqVFY3SzFSLzMrcVVUNlhHSnZDaGVQVjJWeGtCdU83?=
 =?utf-8?B?N0JJMURSeldZak9GZWhxWTNBZmMzZm5jdlpXK1ZMcUZpdFM2dW95Vk9mZDU4?=
 =?utf-8?B?SFhWUGdNM0U5My92NXBuOG9GZTljVmxVdGVoMDF0Mmw4TExYOTdjZ0xXT1Q5?=
 =?utf-8?B?OEErN2VTeWZGbzMvOUxKeW4ySVo5TFVKY3FGN2lpMzhJODJQdUx4RVZHS2Fp?=
 =?utf-8?B?aEpKVWZGWTZ4eVFYZFFoV0tWTHZkenFVdjNmd2tpNDBxVVUyck5pZzNHbHFB?=
 =?utf-8?B?cVNlbEM4bnpucXZ2UngrclhHbzhPUGFudzQzdGJqQ3RpRVNSWS9vNW1lNG1X?=
 =?utf-8?B?bGlUdkVKb25aUkY1L2FnUGZzYmdqeDMxaTdoVlRQZnJlRGJUVWh0cTRwRDJV?=
 =?utf-8?B?L0pyKzNYeXF5WEI0M0ZWODFWTXNPSFpmeDZCUUtiaXVFMTRIRkVHeUFoRDUr?=
 =?utf-8?B?azk1OWJIS1BvMU81QS90QzRIOFNJa2VqOVFJbmhhbE5hUVg3RnE5VE9lK1BC?=
 =?utf-8?B?VnkzeXFMQkw3ckk0MDFaNUE0WUxBdnk3cjJDSWVTbVRnZi94cUkrMElJajI0?=
 =?utf-8?B?aktlalc2TlRDdFBKRkNicFducVVGaitsbk95VUVOdjk0aEJrWmRzODZJYW5C?=
 =?utf-8?B?NjFmSjUzcGlvNDlXeTdCMHgvdHc0VzRoNGpjVE9nYTExL2FPQ0VhazFBSWNG?=
 =?utf-8?B?bmt3SE1xL1hycGhtNkNwL3kvT1NWNCsvcyt6QVdna1JsYkVIWEJuRnN4eklU?=
 =?utf-8?B?SUloWGM4V3JUV0h3bW1yeGhpYWtaT2Y2dWhCR09iczdIQm5WbU0wVU5JeDlJ?=
 =?utf-8?B?VWhvODBGQVg4YThpT3dWQ2hUeWFiakVFeTA2SWQ4M25Jd3Z1b1g1RFFXVkFL?=
 =?utf-8?B?dDk4ODdjUFF0c1I0UTdLRXVqYm9QQ1RSa24yM1NJeDJpdTRUTWhOKzcvS1Bo?=
 =?utf-8?B?S1VWU1hXcklQelA4bkVsOHkrQXNkdkh5Vm5VTUNhZ1JqdmhQOG9tL2tWRlMx?=
 =?utf-8?B?Z3BtZXlDbUhKS3NqVEhjandPT3JXRUpZVDgrMUNnRU01djQzZjVPZEQ2clla?=
 =?utf-8?B?MmZWMU4wZlZSUEU2R3VFd0pIcXdQVzdBQWhzVklkeU5RWXJuNG1ZUlk5ZzBi?=
 =?utf-8?B?dTd3c2pwdzJFT3BVQlNuc1k0dWpIc2t6NGYvSngzZ2paTzlJdjl5ZGMwLzFE?=
 =?utf-8?B?TGtla28vUXFNRmF6Q2VDV1VRSitjdXdCK0tuTFlvak5JbUdscmRKcS84eUVi?=
 =?utf-8?B?eEdMZWhKdkVBcE50NFFJakgyZmV1NFJobXB4OFhhRkhxYUEwYVFIWUtDbEtV?=
 =?utf-8?B?d2tMN1E4TldMRGR4RHlUWitHTUgwR2QxalhFZlZ2bEFVb0dSZDJUMWtFNFlL?=
 =?utf-8?B?dndSR2c2ZmJLZ0tDK05PTHQvckE0OFBqWThvZDFwaWFFYUt2clIrWUZGK1Rr?=
 =?utf-8?B?TDlTMDF5U1kxNVo5MkVoOUYxMTZBWFAzVU5QWSswaVBWVUhZNHJUNGFMTmFE?=
 =?utf-8?B?bVhSTTB5VS9nRmkrNW93b3B6VEhYRUNpKzJHa0xkR01YeXdBSzQ4WVNNNUFk?=
 =?utf-8?B?MXd2cnZ3c2VXNlJFWXF6WGtIZVhtZlNwMDd2N0M2ajdYZDdLQlNybXYzVjAw?=
 =?utf-8?B?aUlKcjZxOTJ5L0lzNlVnZWpuRlB3MjMyaUVmanAwcEhWUWxIQlVPMzZQVWNU?=
 =?utf-8?B?TXhFMnRCQUhxZnlsQU5CQWUwWHNMWWZlYmwzcUlYaytlVU0yWmo4ZG85ZFVr?=
 =?utf-8?B?M3Byb2lFbHNkem95WVplOTdWM01ET0ZEVnF4UXFPdkwvM0U2Sm5rcnFYbVNP?=
 =?utf-8?B?bGhvMlFoRzYzM1NHUjlHUG4vVVpYRGpMM2VTb0NWb24xVVNaOTY2UkxlQzVB?=
 =?utf-8?B?QUFGeVNlMUhUT01aUzVkbjRFWE1KdzN1aFFMRDYrTDlXbm1udVp3VlY4bnhk?=
 =?utf-8?B?eHFQY3NRVWtyYWlLWUVQYXRpODVKMnh4L1BqaUIzMUVtQjZTT2xEd1FMVjNV?=
 =?utf-8?Q?8qRUSvU+V8TgmprAdYGfRX1x1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691cc9e8-6584-4e92-0c6b-08dcbb6576bd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 06:59:24.1939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jt+DOIFsC6ocE+u8VYUSWVyj3q8aV6KxvezL8X3SsOEzfVtsx9NWtJvue/J9DTWIvM8ciPFAKT4hxEQ6sZNOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112


On 7/24/24 23:02, fan wrote:
> On Wed, Jul 24, 2024 at 11:55:16AM -0700, Dave Jiang wrote:
>> Create a new 'struct cxl_mailbox' and move all mailbox related bits to
>> it. This allows isolation of all CXL mailbox data in order to export
>> some of the calls to external callers and avoid exporting of CXL driver
>> specific bits such has device states. The allocation of
>> 'struct cxl_mailbox' is also split out with cxl_mailbox_create() so the
>> mailbox can be created independently.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   MAINTAINERS                  |   1 +
>>   drivers/cxl/core/mbox.c      | 105 +++++++++++++++++++++++++++++------
>>   drivers/cxl/core/memdev.c    |  32 ++++++++---
>>   drivers/cxl/cxlmem.h         |  20 +++----
>>   drivers/cxl/pci.c            |  82 ++++++++++++++++++---------
>>   drivers/cxl/pmem.c           |   7 ++-
>>   include/linux/cxl/mailbox.h  |  28 ++++++++++
>>   tools/testing/cxl/test/mem.c |  46 +++++++++++----
>>   8 files changed, 249 insertions(+), 72 deletions(-)
>>   create mode 100644 include/linux/cxl/mailbox.h
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 958e935449e5..c809fa1eb452 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -5466,6 +5466,7 @@ S:	Maintained
>>   F:	drivers/cxl/
>>   F:	include/linux/einj-cxl.h
>>   F:	include/linux/cxl-event.h
>> +F:	include/linux/cxl/
>>   F:	include/uapi/linux/cxl_mem.h
>>   F:	tools/testing/cxl/
>>   
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 2626f3fff201..9501d2576ccd 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -244,16 +244,20 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>>   int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
>>   			  struct cxl_mbox_cmd *mbox_cmd)
>>   {
>> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>>   	size_t out_size, min_out;
>>   	int rc;
>>   
>> -	if (mbox_cmd->size_in > mds->payload_size ||
>> -	    mbox_cmd->size_out > mds->payload_size)
>> +	if (!cxl_mbox)
>> +		return -ENODEV;
>> +
>> +	if (mbox_cmd->size_in > cxl_mbox->payload_size ||
>> +	    mbox_cmd->size_out > cxl_mbox->payload_size)
>>   		return -E2BIG;
>>   
>>   	out_size = mbox_cmd->size_out;
>>   	min_out = mbox_cmd->min_out;
>> -	rc = mds->mbox_send(mds, mbox_cmd);
>> +	rc = cxl_mbox->mbox_send(cxl_mbox, mbox_cmd);
>>   	/*
>>   	 * EIO is reserved for a payload size mismatch and mbox_send()
>>   	 * may not return this error.
>> @@ -353,11 +357,15 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
>>   			     struct cxl_memdev_state *mds, u16 opcode,
>>   			     size_t in_size, size_t out_size, u64 in_payload)
>>   {
>> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>>   	*mbox = (struct cxl_mbox_cmd) {
>>   		.opcode = opcode,
>>   		.size_in = in_size,
>>   	};
>>   
>> +	if (!cxl_mbox)
>> +		return -ENODEV;
>> +
>>   	if (in_size) {
>>   		mbox->payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
>>   						in_size);
>> @@ -374,7 +382,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
>>   
>>   	/* Prepare to handle a full payload for variable sized output */
>>   	if (out_size == CXL_VARIABLE_PAYLOAD)
>> -		mbox->size_out = mds->payload_size;
>> +		mbox->size_out = cxl_mbox->payload_size;
>>   	else
>>   		mbox->size_out = out_size;
>>   
>> @@ -398,6 +406,11 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
>>   			      const struct cxl_send_command *send_cmd,
>>   			      struct cxl_memdev_state *mds)
>>   {
>> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>> +
>> +	if (!cxl_mbox)
>> +		return -ENODEV;
>> +
>>   	if (send_cmd->raw.rsvd)
>>   		return -EINVAL;
>>   
>> @@ -406,7 +419,7 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
>>   	 * gets passed along without further checking, so it must be
>>   	 * validated here.
>>   	 */
>> -	if (send_cmd->out.size > mds->payload_size)
>> +	if (send_cmd->out.size > cxl_mbox->payload_size)
>>   		return -EINVAL;
>>   
>>   	if (!cxl_mem_raw_command_allowed(send_cmd->raw.opcode))
>> @@ -494,9 +507,13 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
>>   				      struct cxl_memdev_state *mds,
>>   				      const struct cxl_send_command *send_cmd)
>>   {
>> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>>   	struct cxl_mem_command mem_cmd;
>>   	int rc;
>>   
>> +	if (!cxl_mbox)
>> +		return -ENODEV;
>> +
>>   	if (send_cmd->id == 0 || send_cmd->id >= CXL_MEM_COMMAND_ID_MAX)
>>   		return -ENOTTY;
>>   
>> @@ -505,7 +522,7 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
>>   	 * supports, but output can be arbitrarily large (simply write out as
>>   	 * much data as the hardware provides).
>>   	 */
>> -	if (send_cmd->in.size > mds->payload_size)
>> +	if (send_cmd->in.size > cxl_mbox->payload_size)
>>   		return -EINVAL;
>>   
>>   	/* Sanitize and construct a cxl_mem_command */
>> @@ -591,9 +608,13 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev_state *mds,
>>   					u64 out_payload, s32 *size_out,
>>   					u32 *retval)
>>   {
>> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>>   	struct device *dev = mds->cxlds.dev;
>>   	int rc;
>>   
>> +	if (!cxl_mbox)
>> +		return -ENODEV;
>> +
>>   	dev_dbg(dev,
>>   		"Submitting %s command for user\n"
>>   		"\topcode: %x\n"
>> @@ -601,7 +622,7 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev_state *mds,
>>   		cxl_mem_opcode_to_name(mbox_cmd->opcode),
>>   		mbox_cmd->opcode, mbox_cmd->size_in);
>>   
>> -	rc = mds->mbox_send(mds, mbox_cmd);
>> +	rc = cxl_mbox->mbox_send(cxl_mbox, mbox_cmd);
>>   	if (rc)
>>   		goto out;
>>   
>> @@ -659,11 +680,15 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
>>   static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
>>   			u32 *size, u8 *out)
>>   {
>> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>>   	u32 remaining = *size;
>>   	u32 offset = 0;
>>   
>> +	if (!cxl_mbox)
>> +		return -ENODEV;
>> +
>>   	while (remaining) {
>> -		u32 xfer_size = min_t(u32, remaining, mds->payload_size);
>> +		u32 xfer_size = min_t(u32, remaining, cxl_mbox->payload_size);
>>   		struct cxl_mbox_cmd mbox_cmd;
>>   		struct cxl_mbox_get_log log;
>>   		int rc;
>> @@ -752,17 +777,21 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>>   
>>   static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds)
>>   {
>> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>>   	struct cxl_mbox_get_supported_logs *ret;
>>   	struct cxl_mbox_cmd mbox_cmd;
>>   	int rc;
>>   
>> -	ret = kvmalloc(mds->payload_size, GFP_KERNEL);
>> +	if (!cxl_mbox)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	ret = kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
>>   	if (!ret)
>>   		return ERR_PTR(-ENOMEM);
>>   
>>   	mbox_cmd = (struct cxl_mbox_cmd) {
>>   		.opcode = CXL_MBOX_OP_GET_SUPPORTED_LOGS,
>> -		.size_out = mds->payload_size,
>> +		.size_out = cxl_mbox->payload_size,
>>   		.payload_out = ret,
>>   		/* At least the record number field must be valid */
>>   		.min_out = 2,
>> @@ -910,6 +939,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>>   				  enum cxl_event_log_type log,
>>   				  struct cxl_get_event_payload *get_pl)
>>   {
>> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>>   	struct cxl_mbox_clear_event_payload *payload;
>>   	u16 total = le16_to_cpu(get_pl->record_count);
>>   	u8 max_handles = CXL_CLEAR_EVENT_MAX_HANDLES;
>> @@ -919,9 +949,12 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>>   	int rc = 0;
>>   	int i;
>>   
>> +	if (!cxl_mbox)
>> +		return -ENODEV;
>> +
>>   	/* Payload size may limit the max handles */
>> -	if (pl_size > mds->payload_size) {
>> -		max_handles = (mds->payload_size - sizeof(*payload)) /
>> +	if (pl_size > cxl_mbox->payload_size) {
>> +		max_handles = (cxl_mbox->payload_size - sizeof(*payload)) /
>>   			      sizeof(__le16);
>>   		pl_size = struct_size(payload, handles, max_handles);
>>   	}
>> @@ -979,12 +1012,16 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>>   static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>>   				    enum cxl_event_log_type type)
>>   {
>> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>>   	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
>>   	struct device *dev = mds->cxlds.dev;
>>   	struct cxl_get_event_payload *payload;
>>   	u8 log_type = type;
>>   	u16 nr_rec;
>>   
>> +	if (!cxl_mbox)
>> +		return;
>> +
>>   	mutex_lock(&mds->event.log_lock);
>>   	payload = mds->event.buf;
>>   
>> @@ -995,7 +1032,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>>   			.payload_in = &log_type,
>>   			.size_in = sizeof(log_type),
>>   			.payload_out = payload,
>> -			.size_out = mds->payload_size,
>> +			.size_out = cxl_mbox->payload_size,
>>   			.min_out = struct_size(payload, records, 0),
>>   		};
>>   
>> @@ -1328,11 +1365,15 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>>   		       struct cxl_region *cxlr)
>>   {
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>>   	struct cxl_mbox_poison_out *po;
>>   	struct cxl_mbox_poison_in pi;
>>   	int nr_records = 0;
>>   	int rc;
>>   
>> +	if (!cxl_mbox)
>> +		return -ENODEV;
>> +
>>   	rc = mutex_lock_interruptible(&mds->poison.lock);
>>   	if (rc)
>>   		return rc;
>> @@ -1346,7 +1387,7 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>>   			.opcode = CXL_MBOX_OP_GET_POISON,
>>   			.size_in = sizeof(pi),
>>   			.payload_in = &pi,
>> -			.size_out = mds->payload_size,
>> +			.size_out = cxl_mbox->payload_size,
>>   			.payload_out = po,
>>   			.min_out = struct_size(po, record, 0),
>>   		};
>> @@ -1382,7 +1423,12 @@ static void free_poison_buf(void *buf)
>>   /* Get Poison List output buffer is protected by mds->poison.lock */
>>   static int cxl_poison_alloc_buf(struct cxl_memdev_state *mds)
>>   {
>> -	mds->poison.list_out = kvmalloc(mds->payload_size, GFP_KERNEL);
>> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>> +
>> +	if (!cxl_mbox)
>> +		return -ENODEV;
>> +
>> +	mds->poison.list_out = kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
>>   	if (!mds->poison.list_out)
>>   		return -ENOMEM;
>>   
>> @@ -1408,6 +1454,34 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
>>   
>> +static void free_cxl_mailbox(void *cxl_mbox)
>> +{
>> +	kfree(cxl_mbox);
>> +}
>> +
>> +struct cxl_mailbox *cxl_mailbox_create(struct device *dev)
>> +{
>> +	struct cxl_mailbox *cxl_mbox __free(kfree) =
>> +		kzalloc(sizeof(*cxl_mbox), GFP_KERNEL);
>> +	int rc;
>> +
>> +	if (!cxl_mbox)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	cxl_mbox->host = dev;
>> +	mutex_init(&cxl_mbox->mbox_mutex);
>> +	rcuwait_init(&cxl_mbox->mbox_wait);
>> +
>> +	rc = devm_add_action_or_reset(dev, free_cxl_mailbox, cxl_mbox);
>> +	if (rc) {
>> +		cxl_mbox = NULL;
>> +		return ERR_PTR(rc);
>> +	}
>> +
>> +	return no_free_ptr(cxl_mbox);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_mailbox_create, CXL);
>> +
>>   struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>>   {
>>   	struct cxl_memdev_state *mds;
>> @@ -1418,7 +1492,6 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>>   		return ERR_PTR(-ENOMEM);
>>   	}
>>   
>> -	mutex_init(&mds->mbox_mutex);
>>   	mutex_init(&mds->event.log_lock);
>>   	mds->cxlds.dev = dev;
>>   	mds->cxlds.reg_map.host = dev;
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 0277726afd04..7c99f89740a9 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -56,9 +56,9 @@ static ssize_t payload_max_show(struct device *dev,
>>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>>   
>> -	if (!mds)
>> +	if (!mds || !cxlds->cxl_mbox)
>>   		return sysfs_emit(buf, "\n");
>> -	return sysfs_emit(buf, "%zu\n", mds->payload_size);
>> +	return sysfs_emit(buf, "%zu\n", cxlds->cxl_mbox->payload_size);
>>   }
>>   static DEVICE_ATTR_RO(payload_max);
>>   
>> @@ -124,15 +124,19 @@ static ssize_t security_state_show(struct device *dev,
>>   {
>>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +	struct cxl_mailbox *cxl_mbox = cxlds->cxl_mbox;
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>>   	unsigned long state = mds->security.state;
>>   	int rc = 0;
>>   
>> +	if (!cxl_mbox)
>> +		return -ENODEV;
>> +
>>   	/* sync with latest submission state */
>> -	mutex_lock(&mds->mbox_mutex);
>> +	mutex_lock(&cxl_mbox->mbox_mutex);
>>   	if (mds->security.sanitize_active)
>>   		rc = sysfs_emit(buf, "sanitize\n");
>> -	mutex_unlock(&mds->mbox_mutex);
>> +	mutex_unlock(&cxl_mbox->mbox_mutex);
>>   	if (rc)
>>   		return rc;
>>   
>> @@ -829,12 +833,16 @@ static enum fw_upload_err cxl_fw_prepare(struct fw_upload *fwl, const u8 *data,
>>   {
>>   	struct cxl_memdev_state *mds = fwl->dd_handle;
>>   	struct cxl_mbox_transfer_fw *transfer;
>> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>> +
>> +	if (!cxl_mbox)
>> +		return FW_UPLOAD_ERR_NONE;
>>   
>>   	if (!size)
>>   		return FW_UPLOAD_ERR_INVALID_SIZE;
>>   
>>   	mds->fw.oneshot = struct_size(transfer, data, size) <
>> -			    mds->payload_size;
>> +			    cxl_mbox->payload_size;
>>   
>>   	if (cxl_mem_get_fw_info(mds))
>>   		return FW_UPLOAD_ERR_HW_ERROR;
>> @@ -854,6 +862,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
>>   {
>>   	struct cxl_memdev_state *mds = fwl->dd_handle;
>>   	struct cxl_dev_state *cxlds = &mds->cxlds;
>> +	struct cxl_mailbox *cxl_mbox = cxlds->cxl_mbox;
>>   	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>>   	struct cxl_mbox_transfer_fw *transfer;
>>   	struct cxl_mbox_cmd mbox_cmd;
>> @@ -861,6 +870,9 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
>>   	size_t size_in;
>>   	int rc;
>>   
>> +	if (!cxl_mbox)
>> +		return FW_UPLOAD_ERR_NONE;
>> +
>>   	*written = 0;
>>   
>>   	/* Offset has to be aligned to 128B (CXL-3.0 8.2.9.3.2 Table 8-57) */
>> @@ -877,7 +889,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
>>   	 * sizeof(*transfer) is 128.  These constraints imply that @cur_size
>>   	 * will always be 128b aligned.
>>   	 */
>> -	cur_size = min_t(size_t, size, mds->payload_size - sizeof(*transfer));
>> +	cur_size = min_t(size_t, size, cxl_mbox->payload_size - sizeof(*transfer));
>>   
>>   	remaining = size - cur_size;
>>   	size_in = struct_size(transfer, data, cur_size);
>> @@ -1059,16 +1071,20 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
>>   static void sanitize_teardown_notifier(void *data)
>>   {
>>   	struct cxl_memdev_state *mds = data;
>> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>>   	struct kernfs_node *state;
>>   
>> +	if (!cxl_mbox)
>> +		return;
>> +
>>   	/*
>>   	 * Prevent new irq triggered invocations of the workqueue and
>>   	 * flush inflight invocations.
>>   	 */
>> -	mutex_lock(&mds->mbox_mutex);
>> +	mutex_lock(&cxl_mbox->mbox_mutex);
>>   	state = mds->security.sanitize_node;
>>   	mds->security.sanitize_node = NULL;
>> -	mutex_unlock(&mds->mbox_mutex);
>> +	mutex_unlock(&cxl_mbox->mbox_mutex);
>>   
>>   	cancel_delayed_work_sync(&mds->security.poll_dwork);
>>   	sysfs_put(state);
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index af8169ccdbc0..17e83a2cf1be 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -3,11 +3,13 @@
>>   #ifndef __CXL_MEM_H__
>>   #define __CXL_MEM_H__
>>   #include <uapi/linux/cxl_mem.h>
>> +#include <linux/pci.h>
>>   #include <linux/cdev.h>
>>   #include <linux/uuid.h>
>>   #include <linux/rcuwait.h>
>>   #include <linux/cxl-event.h>
>>   #include <linux/node.h>
>> +#include <linux/cxl/mailbox.h>
>>   #include "cxl.h"
>>   
>>   /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
>> @@ -424,6 +426,7 @@ struct cxl_dpa_perf {
>>    * @ram_res: Active Volatile memory capacity configuration
>>    * @serial: PCIe Device Serial Number
>>    * @type: Generic Memory Class device or Vendor Specific Memory device
>> + * @cxl_mbox: CXL mailbox context
>>    */
>>   struct cxl_dev_state {
>>   	struct device *dev;
>> @@ -438,8 +441,14 @@ struct cxl_dev_state {
>>   	struct resource ram_res;
>>   	u64 serial;
>>   	enum cxl_devtype type;
>> +	struct cxl_mailbox *cxl_mbox;
>>   };
>>   
>> +static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>> +{
>> +	return dev_get_drvdata(cxl_mbox->host);
>> +}
>> +
>>   /**
>>    * struct cxl_memdev_state - Generic Type-3 Memory Device Class driver data
>>    *
>> @@ -448,11 +457,8 @@ struct cxl_dev_state {
>>    * the functionality related to that like Identify Memory Device and Get
>>    * Partition Info
>>    * @cxlds: Core driver state common across Type-2 and Type-3 devices
>> - * @payload_size: Size of space for payload
>> - *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
>>    * @lsa_size: Size of Label Storage Area
>>    *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
>> - * @mbox_mutex: Mutex to synchronize mailbox access.
>>    * @firmware_version: Firmware version for the memory device.
>>    * @enabled_cmds: Hardware commands found enabled in CEL.
>>    * @exclusive_cmds: Commands that are kernel-internal only
>> @@ -470,17 +476,13 @@ struct cxl_dev_state {
>>    * @poison: poison driver state info
>>    * @security: security driver state info
>>    * @fw: firmware upload / activation state
>> - * @mbox_wait: RCU wait for mbox send completely
>> - * @mbox_send: @dev specific transport for transmitting mailbox commands
>>    *
>>    * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
>>    * details on capacity parameters.
>>    */
>>   struct cxl_memdev_state {
>>   	struct cxl_dev_state cxlds;
>> -	size_t payload_size;
>>   	size_t lsa_size;
>> -	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
>>   	char firmware_version[0x10];
>>   	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>>   	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
>> @@ -500,10 +502,6 @@ struct cxl_memdev_state {
>>   	struct cxl_poison_state poison;
>>   	struct cxl_security_state security;
>>   	struct cxl_fw_state fw;
>> -
>> -	struct rcuwait mbox_wait;
>> -	int (*mbox_send)(struct cxl_memdev_state *mds,
>> -			 struct cxl_mbox_cmd *cmd);
>>   };
>>   
>>   static inline struct cxl_memdev_state *
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index e53646e9f2fb..bd8ee14a7926 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/pci.h>
>>   #include <linux/aer.h>
>>   #include <linux/io.h>
>> +#include <linux/cxl/mailbox.h>
>>   #include "cxlmem.h"
>>   #include "cxlpci.h"
>>   #include "cxl.h"
>> @@ -124,6 +125,7 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>>   	u16 opcode;
>>   	struct cxl_dev_id *dev_id = id;
>>   	struct cxl_dev_state *cxlds = dev_id->cxlds;
>> +	struct cxl_mailbox *cxl_mbox = cxlds->cxl_mbox;
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>>   
>>   	if (!cxl_mbox_background_complete(cxlds))
>> @@ -132,13 +134,13 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>>   	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
>>   	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
>>   	if (opcode == CXL_MBOX_OP_SANITIZE) {
>> -		mutex_lock(&mds->mbox_mutex);
>> +		mutex_lock(&cxl_mbox->mbox_mutex);
>>   		if (mds->security.sanitize_node)
>>   			mod_delayed_work(system_wq, &mds->security.poll_dwork, 0);
>> -		mutex_unlock(&mds->mbox_mutex);
>> +		mutex_unlock(&cxl_mbox->mbox_mutex);
>>   	} else {
>>   		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
>> -		rcuwait_wake_up(&mds->mbox_wait);
>> +		rcuwait_wake_up(&cxl_mbox->mbox_wait);
>>   	}
>>   
>>   	return IRQ_HANDLED;
>> @@ -152,8 +154,9 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
>>   	struct cxl_memdev_state *mds =
>>   		container_of(work, typeof(*mds), security.poll_dwork.work);
>>   	struct cxl_dev_state *cxlds = &mds->cxlds;
>> +	struct cxl_mailbox *cxl_mbox = cxlds->cxl_mbox;
>>   
>> -	mutex_lock(&mds->mbox_mutex);
>> +	mutex_lock(&cxl_mbox->mbox_mutex);
>>   	if (cxl_mbox_background_complete(cxlds)) {
>>   		mds->security.poll_tmo_secs = 0;
>>   		if (mds->security.sanitize_node)
>> @@ -167,7 +170,7 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
>>   		mds->security.poll_tmo_secs = min(15 * 60, timeout);
>>   		schedule_delayed_work(&mds->security.poll_dwork, timeout * HZ);
>>   	}
>> -	mutex_unlock(&mds->mbox_mutex);
>> +	mutex_unlock(&cxl_mbox->mbox_mutex);
>>   }
>>   
>>   /**
>> @@ -192,17 +195,18 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
>>    * not need to coordinate with each other. The driver only uses the primary
>>    * mailbox.
>>    */
>> -static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>> +static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
>>   				   struct cxl_mbox_cmd *mbox_cmd)
>>   {
>> -	struct cxl_dev_state *cxlds = &mds->cxlds;
>> +	struct cxl_dev_state *cxlds = mbox_to_cxlds(cxl_mbox);
>> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>>   	void __iomem *payload = cxlds->regs.mbox + CXLDEV_MBOX_PAYLOAD_OFFSET;
>>   	struct device *dev = cxlds->dev;
>>   	u64 cmd_reg, status_reg;
>>   	size_t out_len;
>>   	int rc;
>>   
>> -	lockdep_assert_held(&mds->mbox_mutex);
>> +	lockdep_assert_held(&cxl_mbox->mbox_mutex);
>>   
>>   	/*
>>   	 * Here are the steps from 8.2.8.4 of the CXL 2.0 spec.
>> @@ -315,10 +319,10 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>>   
>>   		timeout = mbox_cmd->poll_interval_ms;
>>   		for (i = 0; i < mbox_cmd->poll_count; i++) {
>> -			if (rcuwait_wait_event_timeout(&mds->mbox_wait,
>> -				       cxl_mbox_background_complete(cxlds),
>> -				       TASK_UNINTERRUPTIBLE,
>> -				       msecs_to_jiffies(timeout)) > 0)
>> +			if (rcuwait_wait_event_timeout(&cxl_mbox->mbox_wait,
>> +						       cxl_mbox_background_complete(cxlds),
>> +						       TASK_UNINTERRUPTIBLE,
>> +						       msecs_to_jiffies(timeout)) > 0)
>>   				break;
>>   		}
>>   
>> @@ -360,7 +364,7 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>>   		 */
>>   		size_t n;
>>   
>> -		n = min3(mbox_cmd->size_out, mds->payload_size, out_len);
>> +		n = min3(mbox_cmd->size_out, cxl_mbox->payload_size, out_len);
>>   		memcpy_fromio(mbox_cmd->payload_out, payload, n);
>>   		mbox_cmd->size_out = n;
>>   	} else {
>> @@ -370,14 +374,14 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>>   	return 0;
>>   }
>>   
>> -static int cxl_pci_mbox_send(struct cxl_memdev_state *mds,
>> +static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
>>   			     struct cxl_mbox_cmd *cmd)
>>   {
>>   	int rc;
>>   
>> -	mutex_lock_io(&mds->mbox_mutex);
>> -	rc = __cxl_pci_mbox_send_cmd(mds, cmd);
>> -	mutex_unlock(&mds->mbox_mutex);
>> +	mutex_lock_io(&cxl_mbox->mbox_mutex);
>> +	rc = __cxl_pci_mbox_send_cmd(cxl_mbox, cmd);
>> +	mutex_unlock(&cxl_mbox->mbox_mutex);
>>   
>>   	return rc;
>>   }
>> @@ -385,6 +389,7 @@ static int cxl_pci_mbox_send(struct cxl_memdev_state *mds,
>>   static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>>   {
>>   	struct cxl_dev_state *cxlds = &mds->cxlds;
>> +	struct cxl_mailbox *cxl_mbox = cxlds->cxl_mbox;
>>   	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
>>   	struct device *dev = cxlds->dev;
>>   	unsigned long timeout;
>> @@ -417,8 +422,8 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>>   		return -ETIMEDOUT;
>>   	}
>>   
>> -	mds->mbox_send = cxl_pci_mbox_send;
>> -	mds->payload_size =
>> +	cxl_mbox->mbox_send = cxl_pci_mbox_send;
>> +	cxl_mbox->payload_size =
>>   		1 << FIELD_GET(CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK, cap);
>>   
>>   	/*
>> @@ -428,16 +433,15 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>>   	 * there's no point in going forward. If the size is too large, there's
>>   	 * no harm is soft limiting it.
>>   	 */
>> -	mds->payload_size = min_t(size_t, mds->payload_size, SZ_1M);
>> -	if (mds->payload_size < 256) {
>> +	cxl_mbox->payload_size = min_t(size_t, cxl_mbox->payload_size, SZ_1M);
>> +	if (cxl_mbox->payload_size < 256) {
>>   		dev_err(dev, "Mailbox is too small (%zub)",
>> -			mds->payload_size);
>> +			cxl_mbox->payload_size);
>>   		return -ENXIO;
>>   	}
>>   
>> -	dev_dbg(dev, "Mailbox payload sized %zu", mds->payload_size);
>> +	dev_dbg(dev, "Mailbox payload sized %zu", cxl_mbox->payload_size);
>>   
>> -	rcuwait_init(&mds->mbox_wait);
>>   	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mbox_sanitize_work);
>>   
>>   	/* background command interrupts are optional */
>> @@ -578,9 +582,13 @@ static void free_event_buf(void *buf)
>>    */
>>   static int cxl_mem_alloc_event_buf(struct cxl_memdev_state *mds)
>>   {
>> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>>   	struct cxl_get_event_payload *buf;
>>   
>> -	buf = kvmalloc(mds->payload_size, GFP_KERNEL);
>> +	if (!cxl_mbox)
>> +		return -ENODEV;
>> +
>> +	buf = kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
>>   	if (!buf)
>>   		return -ENOMEM;
>>   	mds->event.buf = buf;
>> @@ -786,6 +794,26 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>>   	return 0;
>>   }
>>   
>> +static int cxl_pci_create_mailbox(struct cxl_dev_state *cxlds)
>> +{
>> +	struct cxl_mailbox *cxl_mbox;
>> +
>> +	/*
>> +	 * Don't bother to allocate the mailbox if the mailbox register isn't
>> +	 * there.
>> +	 */
>> +	if (!cxlds->reg_map.device_map.mbox.valid)
>> +		return -ENODEV;
>> +
>> +	cxl_mbox = cxl_mailbox_create(cxlds->dev);
>> +	if (IS_ERR(cxl_mbox))
>> +		return PTR_ERR(cxl_mbox);
>> +
>> +	cxlds->cxl_mbox = cxl_mbox;
>> +
>> +	return 0;
>> +}
>> +
>>   static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   {
>>   	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>> @@ -846,6 +874,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	if (rc)
>>   		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>>   
>> +	rc = cxl_pci_create_mailbox(cxlds);
>> +	if (rc)
>> +		return rc;
>> +
>>   	rc = cxl_await_media_ready(cxlds);
>>   	if (rc == 0)
>>   		cxlds->media_ready = true;
>> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
>> index 2ecdaee63021..12e68b194820 100644
>> --- a/drivers/cxl/pmem.c
>> +++ b/drivers/cxl/pmem.c
>> @@ -102,13 +102,18 @@ static int cxl_pmem_get_config_size(struct cxl_memdev_state *mds,
>>   				    struct nd_cmd_get_config_size *cmd,
>>   				    unsigned int buf_len)
>>   {
>> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>> +
>> +	if (!cxl_mbox)
>> +		return -ENODEV;
>> +
>>   	if (sizeof(*cmd) > buf_len)
>>   		return -EINVAL;
>>   
>>   	*cmd = (struct nd_cmd_get_config_size){
>>   		.config_size = mds->lsa_size,
>>   		.max_xfer =
>> -			mds->payload_size - sizeof(struct cxl_mbox_set_lsa),
>> +			cxl_mbox->payload_size - sizeof(struct cxl_mbox_set_lsa),
>>   	};
>>   
>>   	return 0;
>> diff --git a/include/linux/cxl/mailbox.h b/include/linux/cxl/mailbox.h
>> new file mode 100644
>> index 000000000000..2b9e4bc1690c
>> --- /dev/null
>> +++ b/include/linux/cxl/mailbox.h
>> @@ -0,0 +1,28 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* Copyright(c) 2024 Intel Corporation. */
>> +#ifndef __CXL_MBOX_H__
>> +#define __CXL_MBOX_H__
>> +
>> +struct cxl_mbox_cmd;
>> +
>> +/**
>> + * struct cxl_mailbox - context for CXL mailbox operations
>> + * @host: device that hosts the mailbox
>> + * @adev: auxiliary device for fw-ctl


This field does not exist in the defined struct.

This aside:

Reviewed-by: Alejandro Lucero <alucerop@amd.com>


>> + * @payload_size: Size of space for payload
>> + *                (CXL 3.1 8.2.8.4.3 Mailbox Capabilities Register)
>> + * @mbox_mutex: mutex protects device mailbox and firmware
>> + * @mbox_wait: rcuwait for mailbox
>> + * @mbox_send: @dev specific transport for transmitting mailbox commands
>> + */
>> +struct cxl_mailbox {
>> +	struct device *host;
>> +	size_t payload_size;
>> +	struct mutex mbox_mutex; /* lock to protect mailbox context */
>> +	struct rcuwait mbox_wait;
>> +	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
>> +};
>> +
>> +struct cxl_mailbox *cxl_mailbox_create(struct device *dev);
>> +
>> +#endif
>> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
>> index eaf091a3d331..29f1a2df9122 100644
>> --- a/tools/testing/cxl/test/mem.c
>> +++ b/tools/testing/cxl/test/mem.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/delay.h>
>>   #include <linux/sizes.h>
>>   #include <linux/bits.h>
>> +#include <linux/cxl/mailbox.h>
>>   #include <asm/unaligned.h>
>>   #include <crypto/sha2.h>
>>   #include <cxlmem.h>
>> @@ -530,6 +531,7 @@ static int mock_gsl(struct cxl_mbox_cmd *cmd)
>>   
>>   static int mock_get_log(struct cxl_memdev_state *mds, struct cxl_mbox_cmd *cmd)
>>   {
>> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>>   	struct cxl_mbox_get_log *gl = cmd->payload_in;
>>   	u32 offset = le32_to_cpu(gl->offset);
>>   	u32 length = le32_to_cpu(gl->length);
>> @@ -538,7 +540,7 @@ static int mock_get_log(struct cxl_memdev_state *mds, struct cxl_mbox_cmd *cmd)
>>   
>>   	if (cmd->size_in < sizeof(*gl))
>>   		return -EINVAL;
>> -	if (length > mds->payload_size)
>> +	if (length > cxl_mbox->payload_size)
>>   		return -EINVAL;
>>   	if (offset + length > sizeof(mock_cel))
>>   		return -EINVAL;
>> @@ -613,12 +615,13 @@ void cxl_mockmem_sanitize_work(struct work_struct *work)
>>   {
>>   	struct cxl_memdev_state *mds =
>>   		container_of(work, typeof(*mds), security.poll_dwork.work);
>> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>>   
>> -	mutex_lock(&mds->mbox_mutex);
>> +	mutex_lock(&cxl_mbox->mbox_mutex);
>>   	if (mds->security.sanitize_node)
>>   		sysfs_notify_dirent(mds->security.sanitize_node);
>>   	mds->security.sanitize_active = false;
>> -	mutex_unlock(&mds->mbox_mutex);
>> +	mutex_unlock(&cxl_mbox->mbox_mutex);
>>   
>>   	dev_dbg(mds->cxlds.dev, "sanitize complete\n");
>>   }
>> @@ -627,6 +630,7 @@ static int mock_sanitize(struct cxl_mockmem_data *mdata,
>>   			 struct cxl_mbox_cmd *cmd)
>>   {
>>   	struct cxl_memdev_state *mds = mdata->mds;
>> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>>   	int rc = 0;
>>   
>>   	if (cmd->size_in != 0)
>> @@ -644,14 +648,14 @@ static int mock_sanitize(struct cxl_mockmem_data *mdata,
>>   		return -ENXIO;
>>   	}
>>   
>> -	mutex_lock(&mds->mbox_mutex);
>> +	mutex_lock(&cxl_mbox->mbox_mutex);
>>   	if (schedule_delayed_work(&mds->security.poll_dwork,
>>   				  msecs_to_jiffies(mdata->sanitize_timeout))) {
>>   		mds->security.sanitize_active = true;
>>   		dev_dbg(mds->cxlds.dev, "sanitize issued\n");
>>   	} else
>>   		rc = -EBUSY;
>> -	mutex_unlock(&mds->mbox_mutex);
>> +	mutex_unlock(&cxl_mbox->mbox_mutex);
>>   
>>   	return rc;
>>   }
>> @@ -1330,12 +1334,13 @@ static int mock_activate_fw(struct cxl_mockmem_data *mdata,
>>   	return -EINVAL;
>>   }
>>   
>> -static int cxl_mock_mbox_send(struct cxl_memdev_state *mds,
>> +static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
>>   			      struct cxl_mbox_cmd *cmd)
>>   {
>> +	struct device *dev = cxl_mbox->host;
>> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
>> +	struct cxl_memdev_state *mds = mdata->mds;
>>   	struct cxl_dev_state *cxlds = &mds->cxlds;
>> -	struct device *dev = cxlds->dev;
>> -	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
>>   	int rc = -EIO;
>>   
>>   	switch (cmd->opcode) {
>> @@ -1450,6 +1455,19 @@ static ssize_t event_trigger_store(struct device *dev,
>>   }
>>   static DEVICE_ATTR_WO(event_trigger);
>>   
>> +static int cxl_mock_mailbox_create(struct cxl_dev_state *cxlds)
>> +{
>> +	struct cxl_mailbox *cxl_mbox;
>> +
>> +	cxl_mbox = cxl_mailbox_create(cxlds->dev);
>> +	if (IS_ERR(cxl_mbox))
>> +		return PTR_ERR(cxl_mbox);
>> +
>> +	cxlds->cxl_mbox = cxl_mbox;
>> +
>> +	return 0;
>> +}
>> +
>>   static int cxl_mock_mem_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>> @@ -1457,6 +1475,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>>   	struct cxl_memdev_state *mds;
>>   	struct cxl_dev_state *cxlds;
>>   	struct cxl_mockmem_data *mdata;
>> +	struct cxl_mailbox *cxl_mbox;
>>   	int rc;
>>   
>>   	mdata = devm_kzalloc(dev, sizeof(*mdata), GFP_KERNEL);
>> @@ -1484,13 +1503,18 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>>   	if (IS_ERR(mds))
>>   		return PTR_ERR(mds);
>>   
>> +	cxlds = &mds->cxlds;
>> +	rc = cxl_mock_mailbox_create(cxlds);
>> +	if (rc)
>> +		return rc;
>> +
>> +	cxl_mbox = mds->cxlds.cxl_mbox;
>>   	mdata->mds = mds;
>> -	mds->mbox_send = cxl_mock_mbox_send;
>> -	mds->payload_size = SZ_4K;
>> +	cxl_mbox->mbox_send = cxl_mock_mbox_send;
>> +	cxl_mbox->payload_size = SZ_4K;
>>   	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
>>   	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
>>   
>> -	cxlds = &mds->cxlds;
>>   	cxlds->serial = pdev->id;
>>   	if (is_rcd(pdev))
>>   		cxlds->rcd = true;
>> -- 
>> 2.45.2
>>
