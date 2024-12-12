Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D53222D79
	for <linux-cxl@vger.kernel.org>; Thu, 12 Dec 2024 18:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026655; cv=fail; b=BZ6gBXonKeZFJMR/jdwDktAeD8THcal3t5tpNBOdpSUoFvVMavRWMc3WIpkbdTIV1/tg2Xg4DaSOFv7tpDy4JAlMy3/80TfJF62YZjzKvCUf96bk7z8T5Rx56+pTFpYPvQGH9169Phw6/SYpG5U2s1sZgdCdoeGS/nYvr2Zvi/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026655; c=relaxed/simple;
	bh=EifyCpDLedgKTdKXNQWBHcp5T1cTB+Phd8CsEaQlaCQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rBGNzaIHNTEscAZ96xYiTq9sw42ctbjPoiLDKCE07coh1o7077mNVlGYU5gFOfVqF5a07dqlu630VOc5QyxtMHZ6+CJzCASa+yVx0X2NOlHJ3YKChmjVg971Zx9WQENro+Hz8N0XTIdpUI+zKJN7u2kfhv4Mzs2cwgFF9nDG0eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VGs0zo9O; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VGs0zo9O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AH7ySDJpXUQUZ/RmDF42/wwwxEWmaYTSDSBtG1HBMp85vipS6jv+PjTd6LPNz/GpnXFJ1RS89cMWHcbfNWR+2uXI8gJG4temhX/2U6vIHsUtdIEzeyfu7P4FRFMFsn0P70acieDAsZRjQ9ES3ZJu5sh/teX+2Q7CwYg/nEIpzIcufn98P5n7EPBdD8vgvrtKFN2IUIa0YfXeT7zQIVDRAhJel4WRQE4HY0LpJCNG/Sdbr77co4nD0HI5n7sKUlrv42/AA3v/veu1AJhkFTk5MIE64m1yZq/QozOazTSkOybpznxMztKNgJSIJc0Mzjj7vcKx/pzBIk8B4zaAPrtgMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RHNBk11x8q9bY5ByeIyRAPbHAMu2uUxH4WplAiiDD4=;
 b=sBpd+TrCm94rSkIi4V99gKYmrqlNjjosEloCHBLAayf+Kxl4QaXrornoCFpwp4OUeAf5ol+BOn8jgsWJS7nOhOvVEbMB1bFI9NBChaHsqYZKT+dMv4jQQWIkDyv8UTnXAb6sZJA+IUi03AHFQxWxVnNQLHr2Gj/7URxzSjOm0AJzk31RMTbiwdYL7p/lXcGb9wL/pz+h8JwMQqwM/SEhLAaBk2ylmGihIwzSlA+oUccSY3A+fxipLg9Bl0Hpx6s7AY7dKYNrTBnIpPsPw2Cq1138OASXIfXp7+ZfySkgvacOUEsYIJz/pSk8dfHr6ZCEgTPg902wlr5UvngtuaGMVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RHNBk11x8q9bY5ByeIyRAPbHAMu2uUxH4WplAiiDD4=;
 b=VGs0zo9OzdwsBCepZPovub5sJNxwHsv28wJnZnFJAiO44BUUwmPRhJgDriluUoSDkXoQNnVZt57Uwa5Cji/1MO6gYDg9/QQCgsB+6yUNh3fcpWGrKM7ifdgeqavVNm1FYOvdsEc0gL0pABKwEfjki/Ftinkt1Xt58RLj3NNb19Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Thu, 12 Dec
 2024 18:04:11 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 18:04:11 +0000
Message-ID: <44788824-eab2-6aa6-1092-54bce1d2937a@amd.com>
Date: Thu, 12 Dec 2024 18:04:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] cxl: read MEMDEV_STATUS register iff the device has it
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, Li Ming <ming.li@zohomail.com>,
 Zhi Wang <zhiw@nvidia.com>, linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com, dan.j.williams@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 acurrid@nvidia.com, cjia@nvidia.com, smitra@nvidia.com, ankita@nvidia.com,
 aniketa@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
 zhiwang@kernel.org
References: <20241212123959.68514-1-zhiw@nvidia.com>
 <027059b4-fd8e-4477-8537-7865a977eefb@intel.com>
 <d8772cf9-cdc6-448b-b6b9-be5370b0770b@zohomail.com>
 <02f5b9ba-82b5-4a7b-852f-f693e53c738b@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <02f5b9ba-82b5-4a7b-852f-f693e53c738b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0530.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::13) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 481b31a9-e8e8-4823-1cbb-08dd1ad76157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWs0dEpMOW1ScFV5SElsUFRpOStObXVDcjhCK0pMbUhRa1VaK3V5QXlqZGwy?=
 =?utf-8?B?TENUZ3liUXI1MFZuOEhnWjREOEs0RHpDYVFrN3BMYnBIZXlVT3lockhUN1A5?=
 =?utf-8?B?LzkyOHdYNGlWR01BY0JReWEybjZkQlBJUjhrQmNmeGNib0JjYkpSNXBtMVQz?=
 =?utf-8?B?WnZsVHlObmZ4ZDBtUE1oYVZ0TitKZ2c5T3lLRmYrRTB1ZnVPVFlRSVJseFlT?=
 =?utf-8?B?MTFScHBTQzZzS1F5eHpXaVpzQy95MFhpTEhmOVYxMUNtM0F2SzJHZ0hranZa?=
 =?utf-8?B?UU1UbmRCOGpJVW1UREY1WWp0UWtmMVh4QmhoandjczlBbVFjOVF6alRxTTJm?=
 =?utf-8?B?RXN0bTByY0JzU0w0WmhsYk9tM1NOQStNaXZpcTlnODAxbFJjQS9HalBTR0lO?=
 =?utf-8?B?YmFiTk5Ea3VIRHA0TXp3WmJweE1PV2FOcXdLczFIRjVNYXMvd1dlNUVTTVR5?=
 =?utf-8?B?SVhkQVVxeXEvc0U3clpVejBXRlM0V05wV3NoaXg5bXovZzExWE42Zkd2TzlE?=
 =?utf-8?B?dGVSYWRremYrOUY3MjBMS0xkVDcrSkdZNENrTDdRVjF5YjBBRnk0OWNrQ1Rm?=
 =?utf-8?B?QzV1Wm9uMTVGRkpQV0RzdXl6NldSWmdOc2hpV2dQYmR3MU90MHpma2EwSGN0?=
 =?utf-8?B?d29vSFR6aEU1cUtUUVNXUkU0VGhzU1VIREFsNDdyT2cvMjFaN1gyR0RZWjZZ?=
 =?utf-8?B?T3BoVkR4cmRFVEVPV1UzdGxkbGZsUU1KRTB2SmsrZ0wvNmdENXpZaU5CdnJ6?=
 =?utf-8?B?U3hoSmJPQVRVV1Y0MDVOM1ZzYVB2WFo4UnpWSGlGL3RRTzR3THEweEVjck96?=
 =?utf-8?B?c3FrMTNBR0VrNzBRdkNqaUJpd1g1Ykp1QkxYL0huSllhYXlhWi9Ca2VwbXUz?=
 =?utf-8?B?VTRvb1hqcSszazc3dW1TRlM0azhXSVprVnl6Z2R2a29lU2REQnpFa1I4Snoz?=
 =?utf-8?B?ZjA3Nm41Y2lzeTY0YzZrU3BpN2hmZnVZRjBmS2V3aFBOcjRlbm1reWF3R3Vi?=
 =?utf-8?B?REVzNFhsSktPbm9NNDZoeGhkdWFybzJOV2Vhc2hNWkxDRjZLQlVkTjE2akVQ?=
 =?utf-8?B?V25CQUNuOGlDV3NSUTZmY3M4ZGU2V1pZd0RtaDY0d2FrUURrcXI2MlFaOU9Y?=
 =?utf-8?B?cEtMNytiRkNBU0daL200TmxZbFdrL0JsRENSeHNaTmx1K1BmSUlzZS90aEpN?=
 =?utf-8?B?NnQyUi9qKzNlRkFIQ20zT3Z6K3RlY1ZzTkoxRVQ5ckZ6cHNPcmNpQU1DUkdR?=
 =?utf-8?B?cGcvQWJKeGZVTTA3MXU2WFhkT0xYKzk0elRkOWlTVVVyRDZ0ckVDNEY3QVFX?=
 =?utf-8?B?WGdDZTJTQ095Y2c5WU5kQ2VDeUtTZndyVjFBd1BDdExMeDYwdXVINnFhVHQy?=
 =?utf-8?B?UXdMeThJQ0l2YnNDTWlMMlozNXNzS1VLQ1Qzc2NCdFdWd2hxcTR4RW9kOWxP?=
 =?utf-8?B?aG9ZWEtsS09xL3NDZnkrT1RtVUQ1RUU3NWdrM2NUUTZSNVMwNUYzQytsSndm?=
 =?utf-8?B?VWxEOWFyeldqbHVLbWJlUUdmUy9KYjFlRlFBYmFFYnRia0VldFFjdXJUenF4?=
 =?utf-8?B?TGR0YTFVMjduMjBuWkR4elhQSjNPaHMvaVZoaXRBQVlJazlLNW5qTHV3RThR?=
 =?utf-8?B?dHQ3Lzk3K2NkV2V6MEY3T2xkQ2ZqdTQ4bjVWTksxcXJXY0h3R0hFOFhyNzlC?=
 =?utf-8?B?dnhxaHA4cUVRbm5SYUNpa1EvdTlEbC95cFBoMGpqb1NYckV6Qloza3J3YVJ4?=
 =?utf-8?B?NUZ6cTFzTXgraFp0bkg4NWNpODlydUF4V2QyMWRWUHJTVE50SWRyM2lXVCsv?=
 =?utf-8?B?cTRYd1BONE14Z0xEY2JWUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0tjUXdKY0sxdWVQQ0hBZzF4cFVJV3AxeS9oU3FjZzcxdTJPNHZmUHE5c3U1?=
 =?utf-8?B?QzJEU1owcUVkVUlXUURXcndVOTE1OXNSWW5Dc2prU0llN2NGYUVrakxIU2xB?=
 =?utf-8?B?NG1hMUdKQjVWVFdmY0dnMWZ0MXVrak9XdWlKWnl4VUZ3ajFvQjd0TWsxOHhL?=
 =?utf-8?B?VC9GWTBUOHhZYy9aZkM0dThaTUZueFRIWHAxVFl0TzFmck5iWUpkdytVWDZU?=
 =?utf-8?B?cVI1MU4venB2NFRNbnBrcDRWN294Z2wzRFVZZUFKeFpXbmlrWGltQStwV3dk?=
 =?utf-8?B?NURyQUJQZ2duK0k0WHpsOVZFK3hvWDhja3puQkVYOXdmN2FITy82OGZQaitZ?=
 =?utf-8?B?TWc2Vkx1djVRODNTeFZmMkJxM1RvTVZEK0ZnTCtIeWxGSDh5UWxtTFhyN1dD?=
 =?utf-8?B?TGw0UGJFR2pyT05lSkwxa0hJdUltYkdaeXRQTnFmaFl0NUNxSU55WmUyM1VF?=
 =?utf-8?B?WnRlMG5Dd1hTaURkdG1DNHhpNHBSK2lyU0I1UW9tdWRVVnRVcU5YN3dOSzFZ?=
 =?utf-8?B?cDNvVk5QaEpCUkpBd3dzdnJvaUNiV1RKc0NlL3lmNUxveG1PbngwTmxjMmxh?=
 =?utf-8?B?NGJXMlhwL0tiRHFUank0THdmd1EyK09UR001emtlTnJMSSt2NGt4WTdyZkJv?=
 =?utf-8?B?c0ZwYzhVYkZXUVludlZuTWZ0S01ROU0zYllkYllvSlJMY3Uyb3NRL0szaUZr?=
 =?utf-8?B?cmxrMlB3RituRDVNdWd3eVg4ckVsUnZvYXM0UG5CR0RVd1ZCbVltSGJpZDFM?=
 =?utf-8?B?QXFYbnNtb3BaRU85eXZja0FxWFpWdVgyMkMyVjhlMU9iQ2pEVWJ1SzF0OWw1?=
 =?utf-8?B?QnJzMFdCcDkwNUl3bXhvdHZ0SGtZa2hBanB5cHZuK0hsRW5pdE8vKyswZU9E?=
 =?utf-8?B?MTJkeFIxd2ZicVNiZHgwZmFjMGpZVlA0enBjRE5qU3NSNithd09tdWRaYmVY?=
 =?utf-8?B?V2ZFVmcvMDRVSWhJd2E5dExBY1duSWNTQndENGRVbzFDOGkrd3JCbXlwSHZI?=
 =?utf-8?B?Q3JtdHA3ZnhLa3RkbCtSa3JWL3dDcDh3KzRBalplU0VMZTdQMWZyNnZ6aGF1?=
 =?utf-8?B?LzV0ampGNndIOVVmNU53V0dYNGFMQzNzcEVwRlByQVdsbzh2dXQyWnpOWGk5?=
 =?utf-8?B?R2R2YWZWRmQxcGF3dEZWS2NvenBqaHhzZmVyVEppa3ovYkZHbUx0Vml1bE5I?=
 =?utf-8?B?bnlNQTVxOVlLb2UxSGxHVUtYNEgxZElEWGRNK3BudkVYY1plaFZCdUxtcSsw?=
 =?utf-8?B?NHI1dWJwTnllUEthSjJCcVNVQ1lDNTc0alZTZkxZa1NjSVVZZmE4U2QvZCsy?=
 =?utf-8?B?dzdpRkFGSmVxVURReTN2bW93OWNLL0hmdEI0dTN2Qy9EUVdIWHB4TFpZVm9V?=
 =?utf-8?B?TWxUWUIraTRuTTdJdy9tVkNwa2lkUzFOQkJ3MU1taGRVUUduOHludytWcEVJ?=
 =?utf-8?B?a0FKb1RnSUZtcVQ2bkNjL2dibmlnMTJScit6dnR0Mi9XdEtrMm1ReFVaTENK?=
 =?utf-8?B?ZjM1MWJTUzhCS2FKZHJCMUczQ3EwemFRTlJBb0NoVWNVc082RXluQWNiSUFG?=
 =?utf-8?B?MmVtZk55UmFEcE9zMXJKOWpVY0JrMWl0RVJXaEFrVW50ODhHN3ZQVHNueE00?=
 =?utf-8?B?YTlqR2Q3aGVHVWRUME12ckhpQk4zZFNCVmsvSW1KNFpKcHBIdGNKaTI0MU5N?=
 =?utf-8?B?Y3NpWGxGYk9HZlVielZWSkQzc1FHcUk2ZjVnR1VLb25VTi95ZityM0xyV2JP?=
 =?utf-8?B?RHZvZzYvZzdzeVVlelJJd2RONEdGSHNWQkd5Tlp4cUp4a01manFkbGtpL0kz?=
 =?utf-8?B?UXJHaTd2N2F1YmZEcVFRaW5jQ0tmWFV3ZXNGY00zTzU4K0s4OUttWjVwT0pa?=
 =?utf-8?B?VVNTdEdqeHNZaHVvazJnR3FkSi9EY25tc2lhQytPNVlvN3Rubk5VeDRwWnlY?=
 =?utf-8?B?UG1QMjVPaitKWXVyZ3VsWUlBZm1EVFovRC9IM1BVQk1CQXBLYVhZcTR1R1BD?=
 =?utf-8?B?R2tLaSsyVmxaRUFuS3djNW5PWGxEVkRSZ2c4aXJ2RTVBRWxkNXFyOUhmUlFF?=
 =?utf-8?B?MGU0eU9ZN1FzeE55bW5aMU1KcnBaNmhLZkpxVk85aDdQTk91VjJTT0N1bW1U?=
 =?utf-8?Q?00QfPuBMqakmz8MZMmLA0WtPc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 481b31a9-e8e8-4823-1cbb-08dd1ad76157
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 18:04:11.2425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/5HFhDWI8j+6IKYikwucuwaub5yjX3yIKiu3FROTtGdtLeQFgO+MA0RyCDHU2XTB7Fmjigq9zLeCECKEKVKgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456


On 12/12/24 17:55, Dave Jiang wrote:
>
> On 12/12/24 10:14 AM, Li Ming wrote:
>> On 12/12/2024 11:45 PM, Dave Jiang wrote:
>>> On 12/12/24 5:39 AM, Zhi Wang wrote:
>>>> Before accessing the CXL device memory after reset/power-on, the driver
>>>> needs to ensure the device memory media is ready.
>>>>
>>>> However, not every CXL device implements the CXL memory device register
>>>> groups. E.g. a CXL type-2 device. Thus calling cxl_await_media_ready()
>>>> on these devcie will lead to a kernel panic. This problem was found when
>>>> testing the emulated CXL type-2 device without a CXL memory device
>>>> register.
>>>>
>>>> [   97.662720] BUG: kernel NULL pointer dereference, address: 0000000000000000
>>>> [   97.663963] #PF: supervisor read access in kernel mode
>>>> [   97.664860] #PF: error_code(0x0000) - not-present page
>>>> [   97.665753] PGD 0 P4D 0
>>>> [   97.666198] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>>>> [   97.667053] CPU: 8 UID: 0 PID: 7340 Comm: qemu-system-x86 Tainted: G            E      6.11.0-rc2+ #52
>>>> [   97.668656] Tainted: [E]=UNSIGNED_MODULE
>>>> [   97.669340] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>>>> [   97.671243] RIP: 0010:cxl_await_media_ready+0x1ac/0x1d0
>>>> [   97.672157] Code: e9 03 ff ff ff 0f b7 1d d6 80 31 01 48 8b 7d b8 89 da 48 c7 c6 60 52 c6 b0 e8 00 46 f6 ff e9 27 ff ff ff 49 8b 86 a0 00 00 00 <48> 8b 00 83 e0 0c 48 83 f8 04 0f 94 c0 0f b6 c0 8d 44 80 fb e9 0c
>>>> [   97.675391] RSP: 0018:ffffb5bac7627c20 EFLAGS: 00010246
>>>> [   97.676298] RAX: 0000000000000000 RBX: 000000000000003c RCX: 0000000000000000
>>>> [   97.677527] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>>>> [   97.678733] RBP: ffffb5bac7627c70 R08: 0000000000000000 R09: 0000000000000000
>>>> [   97.679951] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>>>> [   97.681144] R13: ffff9ef9028a8000 R14: ffff9ef90c1d1a28 R15: 0000000000000000
>>>> [   97.682370] FS:  00007386aa4f3d40(0000) GS:ffff9efa77200000(0000) knlGS:0000000000000000
>>>> [   97.683721] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [   97.684703] CR2: 0000000000000000 CR3: 0000000169a14003 CR4: 0000000000770ef0
>>>> [   97.685909] PKRU: 55555554
>>>> [   97.686397] Call Trace:
>>>> [   97.686819]  <TASK>
>>>> [   97.687243]  ? show_regs+0x6c/0x80
>>>> [   97.687840]  ? __die+0x24/0x80
>>>> [   97.688391]  ? page_fault_oops+0x155/0x570
>>>> [   97.689090]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [   97.689973]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [   97.690848]  ? __vunmap_range_noflush+0x420/0x4e0
>>>> [   97.691700]  ? do_user_addr_fault+0x4b2/0x870
>>>> [   97.692606]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [   97.693502]  ? exc_page_fault+0x82/0x1b0
>>>> [   97.694200]  ? asm_exc_page_fault+0x27/0x30
>>>> [   97.694975]  ? cxl_await_media_ready+0x1ac/0x1d0
>>>> [   97.695816]  vfio_cxl_core_enable+0x386/0x800 [vfio_cxl_core]
>>>> [   97.696829]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [   97.697685]  cxl_open_device+0xa6/0xd0 [cxl_accel_vfio_pci]
>>>> [   97.698673]  vfio_df_open+0xcb/0xf0
>>>> [   97.699313]  vfio_group_fops_unl_ioctl+0x294/0x720
>>>> [   97.700149]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [   97.701011]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [   97.701858]  __x64_sys_ioctl+0xa3/0xf0
>>>> [   97.702536]  x64_sys_call+0x11ad/0x25f0
>>>> [   97.703214]  do_syscall_64+0x7e/0x170
>>>> [   97.703878]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [   97.704726]  ? do_syscall_64+0x8a/0x170
>>>> [   97.705425]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [   97.706282]  ? kvm_device_ioctl+0xae/0x130 [kvm]
>>>> [   97.707135]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [   97.708001]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [   97.708853]  ? syscall_exit_to_user_mode+0x4e/0x250
>>>> [   97.709724]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [   97.710609]  ? do_syscall_64+0x8a/0x170
>>>> [   97.711300]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [   97.712132]  ? exc_page_fault+0x93/0x1b0
>>>> [   97.712839]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>> [   97.713735] RIP: 0033:0x7386ab124ded
>>>> [   97.714382] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
>>>> [   97.717664] RSP: 002b:00007ffcda2a6480 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>>>> [   97.718965] RAX: ffffffffffffffda RBX: 00006293226d9f20 RCX: 00007386ab124ded
>>>> [   97.720222] RDX: 00006293226db730 RSI: 0000000000003b6a RDI: 0000000000000009
>>>> [   97.721522] RBP: 00007ffcda2a64d0 R08: 00006293214e9010 R09: 0000000000000007
>>>> [   97.722858] R10: 00006293226db730 R11: 0000000000000246 R12: 00006293226e0880
>>>> [   97.724193] R13: 00006293226db730 R14: 00007ffcda2a7740 R15: 00006293226d94f0
>>>> [   97.725491]  </TASK>
>>>> [   97.725883] Modules linked in: cxl_accel_vfio_pci(E) vfio_cxl_core(E) vfio_pci_core(E) snd_seq_dummy(E) snd_hrtimer(E) snd_seq(E) snd_seq_device(E) snd_timer(E) snd(E) soundcore(E) qrtr(E) intel_rapl_msr(E) intel_rapl_common(E) kvm_amd(E) ccp(E) binfmt_misc(E) kvm(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E) sha1_ssse3(E) aesni_intel(E) i2c_i801(E) crypto_simd(E) cryptd(E) i2c_smbus(E) lpc_ich(E) joydev(E) input_leds(E) mac_hid(E) serio_raw(E) msr(E) parport_pc(E) ppdev(E) lp(E) parport(E) efi_pstore(E) dmi_sysfs(E) qemu_fw_cfg(E) autofs4(E) bochs(E) e1000e(E) drm_vram_helper(E) psmouse(E) drm_ttm_helper(E) ahci(E) ttm(E) libahci(E)
>>>> [   97.736690] CR2: 0000000000000000
>>>> [   97.737285] ---[ end trace 0000000000000000 ]---
>>>>
>>>> Only read MEMDEV_STATUS register for ensuring media ready when the device
>>>> has it.
>>>>
>>>> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>
>>> I guess since this is unlikely to happen unless type2 support is added, no need to backport as fixes.
>> Hi Zhi and Dave,
>>
>>
>> Do you know if memory device status registers are necessary for CXL type2 device?
> Type-2 can be a memory device since it can implement optional host-managed device memory. But I believe it's optional vs type-3 it's mandatory. So failing on failure of regs.memdev discovery may not be suitable for type 2. At least that is my understanding.


That's correct and what Type2 patchset addresses. Only Type2 mandatory 
capabilities not found are implying a discovery error, although it 
depends on the device driver specifying the expected capabilities adding 
some optional to the mandatory set.


>> I only found Table 8-35 in CXL r3.1 section 8.2.8.5 which mentions that memory device status registers are mandatory for all CXL memory devices.  But I am not sure if this rule applies to CXL type-2 device.
>>
>> If CXL type-2 device should have memory device status registers, maybe cxl_await_media_ready() returnning an error if 'cxlds->regs.memdev' is invalid makes more sense?
>>
>>
>> Thanks
>>
>> Ming
>>
>>>> ---
>>>>   drivers/cxl/core/pci.c | 8 +++++---
>>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>>> index 51132a575b27..7a8ec4928da6 100644
>>>> --- a/drivers/cxl/core/pci.c
>>>> +++ b/drivers/cxl/core/pci.c
>>>> @@ -203,9 +203,11 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>>>>   			return rc;
>>>>   	}
>>>>   
>>>> -	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
>>>> -	if (!CXLMDEV_READY(md_status))
>>>> -		return -EIO;
>>>> +	if (cxlds->regs.memdev) {
>>>> +		md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
>>>> +		if (!CXLMDEV_READY(md_status))
>>>> +			return -EIO;
>>>> +	}
>>>>   
>>>>   	return 0;
>>>>   }
>
