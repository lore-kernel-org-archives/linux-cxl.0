Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467D52F0031;
	Thu, 10 Jul 2025 20:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179961; cv=fail; b=jUAM5zwNPDX+BRe3yDJO/1uBq25VHGCcjKGKXSz35blVqNT0KbhKr3v+svfJGTxkQkcXrQ0icTT2R7isd+DLM0Irnx7LaNyHNk8pXvTewKfHo3f611UAgb9zxk8Amrx6ZxMmXB7SbX2dq5F1pqr7B3OZ7z6FcZ3PMY/g86/Lwbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179961; c=relaxed/simple;
	bh=hV3149nAL8g7haTJJfx4atfDgkSKvLTMmu6jebwcgQM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hrvPiYqyFuBcqBF4fOnE/8pbrc/SaZISgiLS+fOu63X8LWuPPW4TiFPJizN452wOOWnKnPVLGDt0v9bEuMnXd6Fe4Kdjunxv0AQ1qXTVqP1dcgwIopeC600F/pkt2p7fowi9ahMFfikYV/nJMMxZ0KxOsijlJlT3oXIJshTOUr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GFbgzUoe; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GFbgzUoe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bj8nsDvRxJmRAgWL5x53KoW44aaGcyJwqoLZlBbD8RRyYcxyHYgPLH9T9ipX5mfLkOsNFCJH5BM5Y2owmPDo3LutvFbcSgyLs4bhzlqNqkcjlDmrMTpefoxehHZS1uL0SgXu3aSNZeoSe8PYQybvX0e8vIyWEx70Mwgzy4oWbokUZbxEfCGzqLGcX15sKvknvNTNd9mHTpBApo1cnKreK8wFPTW+naq9q52a9oiW2czZQpUNA0wo6VdKafvw7KyJqL9wl4K/Uo+OsMo2G/zo7mAl2isXUfIqz2jFh8//2zDN2ju6WJ6Qe1JQqgSScs1WR9+Qel2TVVxFGQjKd+Mmxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txGg8mZjPPZsrHFoYw2Pix/scSXvtIQj5jD2/o+33Wo=;
 b=on24lHMCwsD3nPh5bKFN49ReODLp+QzOEIZWjU1383Amtq+CJfzAICqMvsBc7PtrCH12xIQT5Hrk0hCLmOf77rUS5wcM9827Bpx7/yO4eWYBUdpCP6YLywWQRtdeIksucGmA6kQaOZv5rD5fGeoov+LmJM9FpsvMKHTo2Ep58uPWkButaFT8S7tHDGy04I3LkXEILXJpakDrLOQa1HaMR5Gpp+reXlrqQ48/F8JFtuodi4MDoZgzNBLQ73w/GVkaLCahm81aEc7/hrGiPL1+5XS87Q4lag/I0Xfx57u8kIjUxlRVCk+33qDQIMP/XhmMibt1N4c5JJenDozlut1/eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txGg8mZjPPZsrHFoYw2Pix/scSXvtIQj5jD2/o+33Wo=;
 b=GFbgzUoe+y0W8kg/EBtUiCsuyevijmatT83o4ehyeo3ra0235G3Cw15xYpVjNtkI7ADWdkpc/1UYqWeOrVSJ3KrfF2X4OD/VZaWkcgdcu5JEQ4FUpdKIsV36UmY5DVDT1qhXq5sSE8V99CrdyUmNIOUe9+Bjs5VBMTLhjfc9AoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by DS7PR12MB5959.namprd12.prod.outlook.com (2603:10b6:8:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Thu, 10 Jul
 2025 20:39:14 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%3]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 20:39:14 +0000
Message-ID: <13e1900d-68d2-4837-80f4-9a4b39dd9ee0@amd.com>
Date: Thu, 10 Jul 2025 13:39:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] CXL/ACPI: Remove overlapping Soft Reserved regions before
 adding CFMW resources
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "Bowman, Terry" <terry.bowman@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 Robert Richter <rrichter@amd.com>, "Fontenot, Nathan"
 <Nathan.Fontenot@amd.com>, Gregory Price <gourry@gourry.net>,
 Fan Ni <fan.ni@samsung.com>, Davidlohr Bueso <dave@stgolabs.net>
Cc: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ad410c59-bf0f-47ae-aa65-c0d845e6f264@fujitsu.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <ad410c59-bf0f-47ae-aa65-c0d845e6f264@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::39) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|DS7PR12MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: 35844aaa-2a4c-4a63-b5ab-08ddbff1d501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlpwWTVMTldTYjlaNXpoN3VtakVSQmM0bW9XNFkvRHloQ3JDNHJ3UWsvTVRs?=
 =?utf-8?B?MXBOTmErZWt2cEgyY0oyaUFWTmVjckROWGZHU0dmUzhLaVh6eEEzUzNZNFdD?=
 =?utf-8?B?OVQ2dVFwQzIyK0xLV1o2dkJaczVnb3FUNllJM3d6emhxN1FqRzVYS25NYm5z?=
 =?utf-8?B?NVRnVitZYjdUL1ZsRHMybzlaRGVHdVk2b0xVVVdGVE1STXYzdWtHOWtCVXd4?=
 =?utf-8?B?YmVydDVrOTE1SGpObkZVRzhuZ2g1ZGQvcUZ1WXNKL0tzY3dDMkZKUnJSRnFo?=
 =?utf-8?B?eThrWXB1ZVhGYTFRbDlNeHRnWG5TQ0NudG81djlxVzBSNUJEdmhsckVxeUxV?=
 =?utf-8?B?NjlWSHZVQkl5VkNoM0p1UUc3NnMwMzFKd1IzeVREYlhPSHpLU05qTFZKSG8y?=
 =?utf-8?B?bUNyMVhZblVSYVdTNTlweE42N0M3QndocG5iekIxSmR5Wi95SUJRVjhwLzNi?=
 =?utf-8?B?dWFTUVpJV1orY0RIZVpjenlqZFJLcG91VkthVnhrZ0xGV1d4dy9GTzUrSzJm?=
 =?utf-8?B?NHgrck94THluTENrRCt5elVmbVdwNTVCVENjTXNmcWV4VS9GUkpSbkxQVWlM?=
 =?utf-8?B?WTJ0OGFEUzgzV0VsaXdkWDVQd0VNMktuakx5czcrY0t4K1NDTUdXbWlpUmNP?=
 =?utf-8?B?ZWpiRU9GVFd1WWNVMjVWSFEwSHozTko5d1AzbEFnOHBxNHJOY0QvR2FmOHkx?=
 =?utf-8?B?RnovZWdFMnR6YkhTQjI5Y2o4TlVmeTFQWE81d3F6aUh6d294MVFVOTJrZ0U2?=
 =?utf-8?B?eWdZUDQra0FoYlI5RUdFb1lNaGtUNlNRZjRXSFpxdXhzQUkvdk9QcktLUkd5?=
 =?utf-8?B?d08xMmdEaWtHMlRCUFBVakllNHlvSElvM0lUeHczWkMxaDA0dlZNUWJkNzVK?=
 =?utf-8?B?aHp2R0NoMkErc0hqaVV5dUNsMHdHc0tJbU1QWFNqVEJQQWkyckNLZFNURE1v?=
 =?utf-8?B?bUp1L0dNL3dBUnNqN2ZFRVR6eFdnUXYwYWpTTGtOTHlzM29ZdHRtdWgxd05B?=
 =?utf-8?B?a2RhQXNoNHlqMFdWeXJDTmVSZUU0NUtEd0p6Ym5tcmlycENKZGRtZndSb2Jq?=
 =?utf-8?B?WkR0Q2tXbndETVZpZXdkRHFWaGF4UktCYWZybFlDWXNWSURsNk5uYkdEYmRo?=
 =?utf-8?B?bUk5YlZIeEM1TG1FVWVqRWgrbDVhdGpQZTlLU1piS0FOTUw0Q2FuUzhYOTlC?=
 =?utf-8?B?ZzY5aE0zWjhoZnFsTEVDOU14ckdtMHZDMkxFK0N4V1F4VVFyaGU2NnRZSmZ4?=
 =?utf-8?B?MEd5UUJaNHZUY0ZzWnUrOXRZODRBQmczbFFKUFlYS1BWeDB6aWlSNi9SbVZu?=
 =?utf-8?B?K3gyNytoUnZ5cU01YmV1WTZMVk9pMDI1OHBRdE9kUDZsSDM4U2dmWHhJN2xk?=
 =?utf-8?B?U0hHUVJWRUhrd1ZwNzN1Yi8yZWlYSEo4aDVkVjlvbUpZSTVpYWVGR1BQUHJY?=
 =?utf-8?B?cjRQMitESlU5L21UNzZoZ2JiNnF3MGNQQytwd05WVFFuL0pDdlpwVDhtaEx0?=
 =?utf-8?B?bm5QeUY3YTg3dERLOFc4LzN2MzRnNksrdHFtVWtGR0pGTjh3dHV3STludzhD?=
 =?utf-8?B?SitKelE2NEZwTHNZL2ZnVnNqaFRnMWRXVzkxSjVXYUVPTS9oTlUxZG9JdEdE?=
 =?utf-8?B?bklsWGhEWGJZTFBadUlwbzdtOGdaT1U4SG1rY05DcFcwdFRHcjFqS240dWFM?=
 =?utf-8?B?djRQWkFoMW55SFZhaEk1OFFnZzU3c1RZMUZuMDhqeXU4NmQ5citPdkVDcFdy?=
 =?utf-8?B?RC9HRnAxazZvTHl3VDM5WkpXTGFUbUNidENzNzNMYVFPaEFrWmZFc0EwOEly?=
 =?utf-8?B?cXpwSU9tY2VBdXVTL1FaWTBHVTJFWjFjQWpMQ3Qzb0VSMFg4OWJ5SkJ3OGVK?=
 =?utf-8?B?MnVqRk9ESS9LdWpVTVV3YVRFUmtUYjlNVG1SRjlnTlR3WkxaU0htYTdITWRX?=
 =?utf-8?B?K3E3alN6KzBUSG5oN1BZTWVaeHlOSGdWSVppa1haWGVUYk1FWGY3N3VaNktt?=
 =?utf-8?B?YXY2MktHaEh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWtsMjZpOTJtQU9VRGtkU1U5NFNmNStkYWZtUWpiRmRLa1pKYmFhYnBCZllK?=
 =?utf-8?B?SjI0bjFEcmYvVVhCUVExS1M5OGRNT0ZZNUgyZitDd1VMV0JqUWdOcGh0bnBw?=
 =?utf-8?B?TDV0MG0wR3RPK0c5cjZ1K1dGU1NhMXBPelBLK2s0cldQaEE4SGY1NVIya1Ux?=
 =?utf-8?B?WUd4KytNcDZzWHZjNkFsaXVwZU12Wmp3NDFpL2pWRXBGeUIrN0lmTEw0LzdV?=
 =?utf-8?B?UjJyUjFxY2xLbWpuUU53b1Y4ZytqaUtYazM5cnFGWmZUa3IzNnY1WkRSUU0y?=
 =?utf-8?B?UThrTXJLOExCOUVTSGNIckJ0d28yV1FhU0JUdjZyTHZCcUFwMEVnYmJESmVG?=
 =?utf-8?B?dVh4OWUrTlNKdXM1NlpNdTNOLzB3Z2hFQy9PNDJFSmNlYTN6N3hFWUVzWkZV?=
 =?utf-8?B?RFl4VmRydVFBaXNpdko5NkUwdG9nUEFsWmhieGwraXB0NXV4OUJhaGxDajhV?=
 =?utf-8?B?WEpOS0hFZ0NheWVVSmttbm9meWVRd1M3ZTRzNlEyYXZQVmhMSEduQ0VDODJw?=
 =?utf-8?B?Zmp2NmdlYUhKVk1JWE5nZys4Um04dFVIVmhMbVNXMlZXS2dFeVlCdjE3TXNl?=
 =?utf-8?B?M1FTaGdRUEkzZS85cytLUEdYa3h1cVBMZkJaVGM0NDZWNTA5UFdVVE8vRmpn?=
 =?utf-8?B?R0JwU1BNUmE1bEZRdFhDWkRNTGpoSmo4NVpVam5TTDloOEhjaC9DeUNFY0xD?=
 =?utf-8?B?N251OFlnU01ZRmlhSWMyZVlNdHAvb1dGSmVSMDhEL3FMZXZnK2UrcXl6SGgv?=
 =?utf-8?B?MCtMNGJVMTh5NWl4OGk1Y1ByOUI4ZERtQVBPMm15YmpiMTJjV2tMWW1uNEtU?=
 =?utf-8?B?dnNCWWVCenRMbk1hQVhkdHQ1bEZtblk1TnNRbXNMMkh0SHVZVTBPN29EVVdZ?=
 =?utf-8?B?dEN2VDFBWDdIYmJNdkZTV3l3dnZuN0I3V1ZmczgrRkpmMkNDSS9NTXkwdHd2?=
 =?utf-8?B?YWp1VU54a2ZXbGFyQ2Z2VlRBZzZrKzFIWnRjb1RoL1Z2QzJIZzFNSHBtZnhq?=
 =?utf-8?B?VmdTT0VaV2ppVnFZdW1iRWlOZDBFNC8xWUFGdkg1bDFMK1crR1hVaW9nU3ZK?=
 =?utf-8?B?YXd1YVZzWi9oTDZOWFFhcnF4c0F0NDZrOVZZU295cEthSW9Ec0pMMXVsMjI5?=
 =?utf-8?B?U3JVRjlhSFlYOVJIR3hkYkpybnI1MjVzL241NjZ6NzZ2SmxqeHVQblRnTkZS?=
 =?utf-8?B?eWNCcGVRenNaR1lrY2dud3JjOVF5TEZxLzE0UmFpVWdOeUVzMEovd1pVbzQ1?=
 =?utf-8?B?My9sVkJ1TXloS3lzTmt2WmZwME5FNUdwNUpFNjBHMkpBekpHd0RkYThkMUhz?=
 =?utf-8?B?ZXAzMzRNeGlxRTRTalpyYjgxbnR1ZlNMckFtTm56UFAzRnAzYVYxTXk4TEpr?=
 =?utf-8?B?ZWQ3YzVIL3AxQ1JvN01WZXk1N21tTTc1KytNUWNjWWZpM2JXSEZwcmlqeUdZ?=
 =?utf-8?B?YnlpRmR2QmllQlFVVE1NV3VTb1o3cmJKcFJLakZhU3hDazl0VFdzQlpwU2RL?=
 =?utf-8?B?K2d2elRPTmt5MmhtRm54WmYzdForMXJDdTA2dmlzNDdiZG41KzNwcDZ4dTBw?=
 =?utf-8?B?aEpKOE5WV3VWSjVRaXZhWlNEdFFRTTRQcUZWVTBGSkJuMW1PalNrU0tLdkVp?=
 =?utf-8?B?VGZrb1NwOWhId0kxQ0lDanloU0gwUis0NXo5MU50dDBHMW5VQUl6WXpOcVNJ?=
 =?utf-8?B?VStDSXgvVzFYVG52c3p5cUc3bWZJWDlZdjhpT1hCUkFSUEF2QnF2c3cxdGE3?=
 =?utf-8?B?WDZiSHg0NDlNRzdYRnkxRzY1UE9CWWdaL1pQSVJEdWxHQWJaTDFaMlZZZUdk?=
 =?utf-8?B?MU96aWZ5aFlsakhVeWYzZ3V6SXhiT2hEL2pTUEVMUlI0eVRsaTNXWEtwUU9t?=
 =?utf-8?B?OUNHQWtUbkY3UDI0M3dkdGVBSGlObndaYXplUzdTTDhLNzZhZzZOM2RWNEtv?=
 =?utf-8?B?TFdYZFBPTi8rWUs5MnRDaE1xOTNoaDRYSkRaMUZKMXlDbHg4NEExOVo4b3cr?=
 =?utf-8?B?bjc2SlpoR3FuK1k5blZDZVFoOThrRG11T01qRXlhclhNUnkxSGd3d0ZjWWwx?=
 =?utf-8?B?cUtodStQQzBTMXpmOFVITUtjeXV6R3lGakZSZzd6NzQ1c3hPdG1ZcW5Yc1JH?=
 =?utf-8?Q?odwWSKsVTwTvPkiKKpymSiGbx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35844aaa-2a4c-4a63-b5ab-08ddbff1d501
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 20:39:13.9771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgCtGifMSM7120Jo6pqyj/Gf+fk7kZHXa79F8HIArwPF5gW3V+M3nInEM70Pd0QIE/KZgOb/BfQK5mjcgsBKDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5959

Hi Zhijian

On 7/9/2025 7:30 PM, Zhijian Li (Fujitsu) wrote:
> Hi all,
> 
> This RFC proposes a new approach to handle the resource conflict between CXL Fixed Memory Windows (CFMW) and "Soft Reserved" memory regions.
> 
> I've been thinking about the "Soft Reserved" issue lately and went through the previous proposals [0]. The existing solutions are generally centered around CXL region management. For instance, an early proposal [1] suggested removing the "Soft Reserved" resource during region teardown. The current approach [2] has evolved to remove it after the CXL driver automatically constructs a CXL region.
> 
> I haven't found prior discussions centered on removing the "Soft Reserved" region *before* the CFMW resource is even added. If this has been discussed before, please point me to the thread.
> 
> My proposal is to remove the "Soft Reserved" resource at the moment we add the root decoder resource (the CFMW) from `CXL_ACPI`.
> 
> Here’s why I believe this is feasible and more effective.
> 
> #### Background
> 
> Currently, CXL memory can be exposed to the users in several ways(1)(2)(3), depending on firmware and driver configurations. The diagram below illustrates the flow:
> 
> ```
>                              +-----------------------+
>                              |                       |
>                              |   CXL memory          |
>                              |                       |
>                              +----------+------------+         +----------------------+
>                                         |                      |                      |
>                                         |                      |                      |
>                           +firmware---------------------+      |            +---------v---------+         +--------------+
>                           |             v               |      |            |                   |   NO    |              |
>                           |  +----------+-------------+ |      |            | enable CXL_ACPI?  +--------->  HMEM        |
>                           |  |                        | |      |            |                   |         |              |
>                           |  | expose to E820?        | |      |            +-------------------+         +-------+------+
>                           |  |                        | |      |                      |YES                        |
>                           |  +----------+-------------+ |      |                      |                           |
>                           |             |               |      |            +---------v----------+                |
>                           |             | YES           |      |            |  iomem             |                |
>                           |             v               |      |            | CXL WindowN        |                |
> +-(1)-----------+       | +-----------+-------------+ |      |            |       (4)          |                |
> | iomem         |  NO   | |  set                    | |      |            +---------+----------+                |
> | System Ram    +<--------+  EFI_MEMORY_SP attr?    | |      |                      |                           |
> |               |       | |                         | |      |                      |                           |
> +---------------+       | +-------------------------+ |      |            +---------v----------+        +-------v--------+
>                           +-----------------------------+      |            |                    |        |                |
>                                         |  YES                 |            |   CXL region       +--------> (2)  dax/kmem  |
>                                         v                      |            |                    |        | (3) device_dax |
>                             +-----------+-------------+        |            +--------------------+        +----------------+
>                             |     iomem               |        |
>                             |    Soft Reserved        +--------+
>                             |                         |
>                             +-------------------------+
> ```
> 
> The problem we are facing occurs in path **(4)**, where the ACPI-defined `CXL WindowN` (CFMW) overlaps with a `Soft Reserved` region. In this scenario, if we try to destroy the driver-created CXL region to create a new one, the operation fails because the underlying memory range is still claimed by "Soft Reserved".
> 
> Here is an example from `  /proc/iomem `:
> 
> ```
> c070000000-fcffffffff : CXL Window 0
>     c070000000-fcffffffff : Soft Reserved
>       c070000000-fcffffffff : region0  ### Deleting this will not free the range for a new region
>         c070000000-fcffffffff : dax0.0
>           c070000000-fcffffffff : System RAM (kmem)
> ```
> 
> #### Proposal
> 
> The fundamental assumption of the CXL driver design appears to be (and I believe this is correct) that once the kernel successfully parses `CEDT.CFMWS` via `CXL_ACPI`, the CXL subsystem is designated to take full control of the corresponding CXL memory device.
> 
> If this holds true, it means that the "Soft Reserved" region, which serves as a firmware-level hint to prevent the OS from arbitrarily using this memory, is no longer necessary after the CFMW is identified. The CFMW itself becomes the authoritative definition for this memory range.

I may be wrong, but shouldn't we also guarantee that cxl_region 
instances be always populated after the CXL Windows (CFMWS) are setup 
through cxl_acpi?

Dan's comments here:
https://lore.kernel.org/all/65e0fcae989d6_1138c7294c2@dwillia2-xfh.jf.intel.com.notmuch/

"After cxl_acpi is loaded Linux knows where all the CXL windows are, but
it does not know if there are cxl_region instances populated into those
windows. That process involves waiting for PCI probe to complete and the
CXL autoassembly process to run its course."

This patchset 
https://lore.kernel.org/all/20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com/ 
does wait for cxl_mem (cxl_pci) to complete but I agree it doesn't 
guarantee region readiness. I was thinking to wait on cxl_region_probe 
to complete along with cxl_mem in v5.

Thanks
Smita
> 
> Therefore, we can safely remove the "Soft Reserved" resource from the `iomem_resource` tree right before inserting the new CFMW resource.
> 
> This approach is simple and highly effective. It decouples the "Soft Reserved" problem from CXL region management entirely. By cleaning up the resource conflict at the earliest possible stage, this solution should be compatible with all CXL region patterns, including scenarios with misconfigured or unconfigured HDM Decoders.
> 
> I haven't spent much time working out all the implementation details yet, but a quick proof-of-concept (PoC) shows that this approach appears to work. A rough sketch of the code is below. If this direction is ACKed, I will prepare and send out a complete implementation for review.
> ```diff
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -780,7 +783,9 @@ static int add_cxl_resources(struct resource *cxl_res)
>    		 */
>    		cxl_set_public_resource(res, new);
>    
> -		insert_resource_expand_to_fit(&iomem_resource, new);
> +		/* Remove Soft Reserved that is fully covered by this window */
> +		claim_and_punch_out_soft_reserved(&iomem_resource, new);
>    
>    		next = res->sibling;
>    		while (next && resource_overlaps(new, next)) {
> ```
> 
> And the new helper function in `kernel/resource.c`:
> 
> ```diff
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -364,6 +355,7 @@ int release_resource(struct resource *old)
>    
>    EXPORT_SYMBOL(release_resource);
>    
> +/**
> + * claim_and_punch_out_soft_reserved - Claim a resource region, punching out
> + * any overlapping "Soft Reserved" areas.
> + * @root: The root of the resource tree (e.g., &iomem_resource).
> + * @new:  The new resource to insert.
> + *
> + * Description:
> + * This function prepares for the insertion of a new resource (@new) by
> + * resolving conflicts with existing "Soft Reserved" regions. It works as
> + * follows:
> + *
> + * 1. It iterates through the children of @root, searching for any resource
> + * that both overlaps with @new and is identified as "Soft Reserved"
> + * (by its name and the IORES_DESC_SOFT_RESERVED descriptor).
> + * 2. For each conflicting "Soft Reserved" resource found, it removes the
> + * original conflicting resource from the tree.
> + * 3. It then calculates the remaining parts of the original resource that
> + * lie outside the range of @new. This may result in one or two smaller,
> + * non-overlapping parts.
> + * 4. These remaining parts are re-inserted into the resource tree as new,
> + * smaller "Soft Reserved" resources. This action is akin to "punching a
> + * hole" in the original reserved region.
> + * 5. After all conflicts are resolved, the @new resource is inserted into
> + * the tree, claiming the now-available space.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int claim_and_punch_out_soft_reserved(struct resource *root,
> +                                      struct resource *new);
> +
> ```
> 
> Looking forward to your feedback and thoughts on this approach.
> 
> Thanks,
> Zhijian
> 
> -----
> 
> **References:**
> 
> [0]
> [PATCH 0/2] cxl/region: Improve Soft Reserved resource handling: [https://lore.kernel.org/linux-cxl/cover.1687568084.git.alison.schofield@intel.com/](https://lore.kernel.org/linux-cxl/cover.1687568084.git.alison.schofield@intel.com/)
> [PATCH v2 0/2] cxl/region: Improve Soft Reserved resource handling: [https://lore.kernel.org/linux-cxl/cover.1691176651.git.alison.schofield@intel.com/](https://lore.kernel.org/linux-cxl/cover.1691176651.git.alison.schofield@intel.com/)
> [PATCH v3 0/2] cxl/region: Improve Soft Reserved resource handling: [https://lore.kernel.org/linux-cxl/cover.1692638817.git.alison.schofield@intel.com/](https://lore.kernel.org/linux-cxl/cover.1692638817.git.alison.schofield@intel.com/)
> [RFC] cxl: Update Soft Reserved resources upon region creation: [https://lore.kernel.org/linux-cxl/20241004181754.8960-1-nathan.fontenot@amd.com/](https://lore.kernel.org/linux-cxl/20241004181754.8960-1-nathan.fontenot@amd.com/)
> [RFC v2] cxl: Update Soft Reserved resources upon region creation: [https://lore.kernel.org/linux-cxl/20241030172751.81392-1-nathan.fontenot@amd.com/](https://lore.kernel.org/linux-cxl/20241030172751.81392-1-nathan.fontenot@amd.com/)
> [PATCH] cxl: Update Soft Reserved resources upon region creation: [https://lore.kernel.org/linux-cxl/20241202155542.22111-1-nathan.fontenot@amd.com/](https://lore.kernel.org/linux-cxl/20241202155542.22111-1-nathan.fontenot@amd.com/)
> [PATCH v2 0/4] Add managed SOFT RESERVE resource handling: [https://lore.kernel.org/linux-cxl/cover.1737046620.git.nathan.fontenot@amd.com/](https://lore.kernel.org/linux-cxl/cover.1737046620.git.nathan.fontenot@amd.com/)
> [PATCH v3 0/4] Add managed SOFT RESERVE resource handling: [https://lore.kernel.org/linux-cxl/20250403183315.286710-1-terry.bowman@amd.com/](https://lore.kernel.org/linux-cxl/20250403183315.286710-1-terry.bowman@amd.com/)
> [PATCH v4 0/7] Add managed SOFT RESERVE resource handling: [https://lore.kernel.org/linux-cxl/20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com/#r](https://lore.kernel.org/linux-cxl/20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com/#r)
> 
> [1] [https://lore.kernel.org/linux-cxl/cover.1691176651.git.alison.schofield@intel.com/](https://lore.kernel.org/linux-cxl/cover.1691176651.git.alison.schofield@intel.com/)
> [2] [https://lore.kernel.org/linux-cxl/20241004181754.8960-1-nathan.fontenot@amd.com/](https://lore.kernel.org/linux-cxl/20241004181754.8960-1-nathan.fontenot@amd.com/)

