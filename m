Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F271E485
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737121097; cv=fail; b=RrSsBnurMZV91hm3AQvJxtu2haPsUhJFJQLrsKePZUveJl3+lTSgfs1J1YoDMpzVlXTjRRrAQkrM2TUccji8LhiT2B0mDFNS2NhBAL/4IAIto88tRAAHnsiIn9AZknKkaoqRUjKKIgMjkOLlsH3SI+o3Eb+k8cUp7Z2wzlR435c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737121097; c=relaxed/simple;
	bh=vI5eQHhIo8bncLTS8Rz0jVGXyjI15vvNkT1yWWuN4Xk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hrtTBrRoxLKl2FzN520kx+TReP5oyvMFQJXL0rrd4g4R8/7DLR1sTmOWMzxCUcOyhzhSubQHgnAieg7SVGS0UVCJWZqxExsIAfxC79rZh9lMFXJUdPWmtOsyKDm8PSbV42SEQom2sj/hMWAhEBc1JzTZ/UD7ooA3RtPrGBsyfHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0qkhLRYv; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0qkhLRYv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNbo90c5KLwizBPHKDOiW2MPlDd+yFXHUN5DNhjkLT0Ld993VMjgwxO8EL31XARr32WlbqTh7IA5U5pB5qzgYpEaRsWCQZ8UFExT9qmlUJP+s2HpO7OVrgEw3ff9wselHJqsNBCkH1D1s/T16SAecW/ktMRrEug1/QkrmLJPNeP6WKxPkhs6GHuxG2nekijozKougX6PWyOT74r5ax9XMQAOOh4dAJTstqCrlcWorcAa/nxw80uNqs6AuDRUi+pyEbOqK4229HprWrJFFHFOj14JhV1cB66yJz6LVy+HT08UQoxYGNVpQMCFeeNJcV7r3icsGiXRVqqgT2o+FBJxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6UVnQ20iGIkLbIS2g63FZJXQ4+xVtas+hjXaCI/gp4=;
 b=GAzPNauVhUZ0T5NZElumkc3BeHaAxR64ajcWXmF2P2K6NY5uJe2u0qSwTdAm3iUQo1A+p7Pa0pFwfmQP5PB0ceZ9qLT2eZHZNsP6L0qZYGiTBH9YOHUIoHrgSA/aOUyOceC6ybRS8HDRLqCfhvScCrEUknuP+ufGb8LIvip4Vki56nUwKZLhXZonZIr6LGzLl7vXK05DsaB1ivws7LkqZqfOhVad5YfB/Xe11oL/OAGJdGYYVMuuTCWO24ltj6/p0OGevFrksowS0WuB+J/sXhMjA1Co4N5+p/M2oHs7AKc1arf518+ZkGrqv2a7NgumU0GEPZraWFAZIzMafbxP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6UVnQ20iGIkLbIS2g63FZJXQ4+xVtas+hjXaCI/gp4=;
 b=0qkhLRYvVSyXKS2o05T+YLAh1xH51uL3daDKThFfTWw8J7R++vhCw73oKVwz4JyChZ8ketIUUAtgbqQETorrqOdutu1TVJ8Y1hHkAp1y7hRzUIaurFBt6Cf6CVk8cShdYGVAFkNMdeYML5t7o7IKwf0fGQ9Jwgp39n5dv78chZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA0PR12MB7506.namprd12.prod.outlook.com (2603:10b6:208:442::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 13:38:12 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 13:38:11 +0000
Message-ID: <7f1fb3cd-15ff-66ff-f395-35de5f984d0d@amd.com>
Date: Fri, 17 Jan 2025 13:38:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] cxl: Introduce 'struct cxl_dpa_partition' and 'struct
 cxl_range_info'
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
 <173709424415.753996.10761098712604763500.stgit@dwillia2-xfh.jf.intel.com>
 <20250117105254.00001dd4@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250117105254.00001dd4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0508.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA0PR12MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: 183fced6-ad9a-4336-4358-08dd36fc2fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3lwN2xhSVp1dkdYMmJydVY1SEtiYzJjWUVLRUxZSkQzd1VqWHkxQVR2aWtk?=
 =?utf-8?B?TGlKY2RlYXU4Rk1tMjZ4cGx6cm8vdXJmSmt4dFVrSzdyQU81OXVzMzBXM1Q1?=
 =?utf-8?B?STZzRXhTRzlScWFUTk1zbzlsVmlEWlhPMENpa0F5Mkhjc2xkNXRnNkNYWER6?=
 =?utf-8?B?S0d4Y0ZuSk4xa3FHUFZ0ZVk2ekFDWFRoNDlWRHRLK0xsNHpHNDFPQ0JKYjFj?=
 =?utf-8?B?cDh2ZC91MHdFVjBjYnRVUTBKdzBxQ2gzNG02b1VPbUZ4aXZwUk5CYmdlT1Rt?=
 =?utf-8?B?UnppVHQ2eTVGNG9JMHhocVdpSHZWdXo0NUhtR0NxczlRQ3FMY2VMRkJTSlFV?=
 =?utf-8?B?aVZ4MEN3Z0RNV3RlS0pDTnJNUXNrSFpOd1ZERUo3MlJqRFNEd3l1RUJhREl5?=
 =?utf-8?B?cSsxUzNiSFhFZlpCK0VKMGdlSVpnVWdJSzVXZVYrUWdjT0w4OFNhS25kd2Jq?=
 =?utf-8?B?S0JKVzZsVC9hamlBTlA0ejdrWFhWdWZLaUY2K1lNeHZOQnNXNlJGN3EwSmR5?=
 =?utf-8?B?dXI3YmN1VmRYOWZjbTFYMnFHdFZ1emtwVE41ODdTZTc5ejBFRUdzWStoOTY4?=
 =?utf-8?B?N1JZdWdaS244NmNYempuN1VoQjExbHgzRVgwNkhzQ0RlNTY2WUMycndQbTZs?=
 =?utf-8?B?L3BZcWh6UDdUUW5CdUdPWjhndVN4ZlVYOWlQbE9hT1I1WlY4aTBDZ2JVQTRa?=
 =?utf-8?B?dFNmTkFmRW5iYlMrbXVYSW12N2ZiRlliN0NkdkVFRVdRb3VkV2pUY0VrMXlq?=
 =?utf-8?B?TVVPSGlZaXZkT1NkclRXMjR0MzZCNlpVbVNJWXREOWtnVWlucFJaOFU4eHNJ?=
 =?utf-8?B?WlBncjNBbXdwL3ZqNjA5R3FmV3B3TmxNbGVWNk1zNkk2V09idEdxQ3NXRFpt?=
 =?utf-8?B?RldaaFJYNlJ0U0k1STZ1WGJqd1hBajJNMW1lZHpHcVlWMUJLaTc5QVVibEgx?=
 =?utf-8?B?TmNjN241OCtEQ0NKV0lkaGtHNXJleHhlT1R5VEpyQ2xzM1o2cldhaTV5eitj?=
 =?utf-8?B?OTFrZVBRNDNGb1VmN1VTUGpxaHBpR09kSXEvTXVUL25pcjlPUHBZWmhHbHZj?=
 =?utf-8?B?U1JVcmNRRWQwL3lKLzJsZnRZWUIwYWx6S2wvK2tJekZHOE1BUWpBdkZZaWYw?=
 =?utf-8?B?T0R0VlVEVHREWkMxa0tSU01Uai8xMWRCQVFzQlRvZUxqSkdlZm1lWmwvenph?=
 =?utf-8?B?VkVXMzBHUlZoL29vYVVzZmdhUytNbzdNK1YyUXZhaHVtS243TXdWaldLZi9C?=
 =?utf-8?B?UE44b2I5YW9NU1NiVXFZZFdWa3ZHWlRUYU9Oa05Tb1NrU21CeHFKZTUwT3hY?=
 =?utf-8?B?b1Y1LzdPNEE5RXYwVmowN3pTUzJ6Tytxd1I1OFV2T3pPcUZycnNXbVZIaXVI?=
 =?utf-8?B?SVRIWnlkdTJYMG11WmtSWUJMZ21ZclBBZXVtdk9tZkt6TytUam1qRnl6QUhp?=
 =?utf-8?B?R1RZWG04ZFo0MHByZGN6RUxldlA5K1puckRWcndtdjFDNWpPU2Nta0ZkblZ3?=
 =?utf-8?B?L1ZaMkgwNEk5bGNpVTZPUytCYllaaWM1NmNUQllXSURKVk5rNmhNWGEwc3gx?=
 =?utf-8?B?S1c2RFA2dW9lcFhSalgyR2l5bndqN2pieFVQekF6aTNHcThRbS9NK3p0V0pw?=
 =?utf-8?B?NHdrZExDYzFVSzNVSm0yMHF1RUIzSlNkdTlLamNwRjRYdWFxRzV5NzBXaFJ1?=
 =?utf-8?B?d2JPeHBrbUtWTllnQzdSdjhYV3lGRWF1SFVaa2hSdk9qY0U1NU9IOHNINWs0?=
 =?utf-8?B?LzA2VkhJK2lvODdXeDNuNDJ5YXkxOWZyeUs5NmJKZVZqUDd5RjhDU05iVXlE?=
 =?utf-8?B?R2R6dUF6aVJOVlRXRnhnUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UW5RdmZYeExpaE91THhJbmF0TzFMNW54ZDZBZWluK2tQQUw4dFJjc01GcUxN?=
 =?utf-8?B?bGV6WHM0b1NRUmpqNnlqZm5jZHpEaTZxaEhtNTlySVM1M3VQUnUwTEVXVTZF?=
 =?utf-8?B?Z29scVlObU15OFhucnBvK3JRZjVLRE1LR3N4RkF3amRqY1pFa2NQMGJmUnFx?=
 =?utf-8?B?cVNzRnJDWlVnNjRodHNoMjN3T2lGckl6T0lPUTl1a0JuU2JpSFc3bHcrSFli?=
 =?utf-8?B?NXpjbXp1NkE0QlBXYlUyYUhIVDN1U2hhNWZIbnRaNC9WVEFwdm14STRvZmtX?=
 =?utf-8?B?Q1E5VGJiVGVlK0hTUnRCYkJqcHBDNC92MUZJOVVxNlN3eGhHRlJXUXpXNjhL?=
 =?utf-8?B?MXhSTVhuYjdQNVFIYjNxKytJcmkvcnlSUHBUZXNKVXBBbm1IK0c0MUpCWUhS?=
 =?utf-8?B?UWtidEE5OHNJR1pjZEdxQW15MmpORk94eitUbDZZZ285bnRTQzRpSndaSlJM?=
 =?utf-8?B?aEFCRUdKN3ZKM1d6Wm1uSXFMQVhiYXhSSFFZTldBek8vU09BT1IvTWMrWG5S?=
 =?utf-8?B?Y1ZzcHA0VDNIR0xnaE9TMkxhNnE4TStLQ2c3eFFwQ3U5Vk9YN3J5K0huTUc2?=
 =?utf-8?B?U2h6YUtMUTVERFZrOVZGekRTMDRwOFh1OVdpRytFbFBqNmtNYWtXbU9CMFJE?=
 =?utf-8?B?ek9CWlNjdW44M0hmVmlCVTZtbWhSdG9NUzhabkJPdjQ4MTlCVW1qQmNhM2ps?=
 =?utf-8?B?YkladlJSSUVvM2dPRmtEcm9OejhoMzB1SW1FTFlScTV2NndKSm8rcjZMODZn?=
 =?utf-8?B?NnZjenNEeVFSM2VCVUMwSDNZUkJmN3pDMFB0dUx4bjNOb0Qwa1hSamduaVdy?=
 =?utf-8?B?SjJkWnMweUg2elhQNWNBWnhSS3p6ZTlHZnBuQisyMWdyR3hOY1Bsc0V2UXFQ?=
 =?utf-8?B?dVBNQi8reE5WUXFWeU9UeVhYTk44NDNPZTB0TUUvY2grQUtqUk43TUZZanZ6?=
 =?utf-8?B?UWFGN2dIeEZGK1JRUkJOUXo4aW9lS3dqNkdFcmRRWlNCU2phMCtVMm5xRGg4?=
 =?utf-8?B?cFFreCttZi9UNjlPT0lpZmNERkM1M0RjZlNUU1Yxa0xSMHcxMTE2MXNTTEoz?=
 =?utf-8?B?bDUyeUxQQmc1U2NLbzFZTkJBeG13enM3MUJSZnNueW9WbS9Wb2ZqN1VSbjBV?=
 =?utf-8?B?Um5VcEFWR2lhS2pYYWM4V2lvVUY4VEJsUU9iYkg5ODczU3Y5SEFpalQ3dllV?=
 =?utf-8?B?c0t6QkxFMXdicEFPZGlhWHZHMVNSc0pWWEk4NklhYmNnZVArM1dVK013NmxI?=
 =?utf-8?B?NjAzek5EcmpVNmtYblhiTjBIUzRWTlAxM1FOdFFreTNSZ2FSOWNZYW9scWxB?=
 =?utf-8?B?SGw5ODJFK3FXUDYrT3FEdC8xUUR3Vmt1S3FpUUQ1bXJpNCtqWHVEMkI3dmlP?=
 =?utf-8?B?Q0ZQdFYzOXRaOEZLeEcxYXpTK3JJWVM3QmtySkZIMXllSjRUdFk0TVovclNI?=
 =?utf-8?B?bDBtM0U0R3AyYmZVRFIvMWVvZnJXdUx5MWJLMmdUMS91TDVmSktETDBXb1Fi?=
 =?utf-8?B?SDE4MFZwUHg2QlJNd1NsN3U3Z2hiL1lOYkkxWFd5QUxUMkhuQk5jbnZnTWhF?=
 =?utf-8?B?TDhzV0NvZThGOTFnNUZ4MnZKeCtBZ3ZuRWhkY0ZZeEh5UGljRklVeXllZkhj?=
 =?utf-8?B?YUlwOEd4czVFN3FSemVNQzF6bVJleVlWaWhhemw4N1ppVlBhVFcvdGw4SGhD?=
 =?utf-8?B?eUIvRnVPM2tsVTJla3gySWxKVnlOSVcrU1NSZ2FYckE5N2dBeHNMUGQ3NjJv?=
 =?utf-8?B?TzJNdlNsS2g3NU9nYnNkTUIwQ0cvQ0xVSnpjWE44MGMzcTJCc3Q1TEFualAz?=
 =?utf-8?B?ekdmdzJPWWJEMGs4SENVc3pzM0o5MmJVQTNZZzh1TXNJUzV3dVdlR0lJWmgv?=
 =?utf-8?B?QXkxUldWZjcvcGN0RGdJMXI5czR5ZC9jWlNDOERCMTFaV2lkTzZRZWFWWFlI?=
 =?utf-8?B?RVVMMWgyRG5LT2pYc0lNK292TTYwMkRlYmxPRVdwY1FjTWNLeGExTmtoY0xr?=
 =?utf-8?B?bjlDZngvd21JOWZmdmtwWVFNNVpjSDUySTloRHh2QWdza294TmxLcDRscUUx?=
 =?utf-8?B?ZXhOVFRIRkloVFZYdytxWWM1UEZIU0VwVTRaUVRPYkViOXV0NGlRNFRyaGNQ?=
 =?utf-8?Q?yfwK3xHeyrOtjRHxyV6aowrrs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183fced6-ad9a-4336-4358-08dd36fc2fc1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 13:38:11.8383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 920MwDNJJQB1iGxijmi3XkNMl4z7vang8oqAFwyM+DoalXZ/YsZZfhm7uDSV2CMh+Ixb+cnqf4gqxIQqI+Yl4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506


On 1/17/25 10:52, Jonathan Cameron wrote:
> On Thu, 16 Jan 2025 22:10:44 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
>> The pending efforts to add CXL Accelerator (type-2) device [1], and
>> Dynamic Capacity (DCD) support [2], tripped on the
>> no-longer-fit-for-purpose design in the CXL subsystem for tracking
>> device-physical-address (DPA) metadata. Trip hazards include:
>>
>> - CXL Memory Devices need to consider a PMEM partition, but Accelerator
>>    devices with CXL.mem likely do not in the common case.
>>
>> - CXL Memory Devices enumerate DPA through Memory Device mailbox
>>    commands like Partition Info, Accelerators devices do not.
>>
>> - CXL Memory Devices that support DCD support more than 2 partitions.
>>    Some of the driver algorithms are awkward to expand to > 2 partition
>>    cases.
>>
>> - DPA performance data is a general capability that can be shared with
>>    accelerators, so tracking it in 'struct cxl_memdev_state' is no longer
>>    suitable.
>>
>> - 'enum cxl_decoder_mode' is sometimes a partition id and sometimes a
>>    memory property, it should be phased in favor of a partition id and
>>    the memory property comes from the partition info.
>>
>> Towards cleaning up those issues and allowing a smoother landing for the
>> aforementioned pending efforts, introduce a 'struct cxl_dpa_partition'
>> array to 'struct cxl_dev_state', and 'struct cxl_range_info' as a shared
>> way for Memory Devices and Accelerators to initialize the DPA information
>> in 'struct cxl_dev_state'.
>>
>> For now, split a new cxl_dpa_setup() from cxl_mem_create_range_info() to
>> get the new data structure initialized, and cleanup some qos_class init.
>> Follow on patches will go further to use the new data structure to
>> cleanup algorithms that are better suited to loop over all possible
>> partitions.
>>
>> cxl_dpa_setup() follows the locking expectations of mutating the device
>> DPA map, and is suitable for Accelerator drivers to use. Accelerators
>> likely only have one hardcoded 'ram' partition to convey to the
>> cxl_core.
>>
>> Link: http://lore.kernel.org/20241230214445.27602-1-alejandro.lucero-palau@amd.com [1]
>> Link: http://lore.kernel.org/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com [2]
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Alejandro Lucero <alucerop@amd.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Hi Dan,
>
> In basic form this seems fine, but I find the nr_paritions variable usage very
> counter intuitive.  It's just how many we configured not how many there
> are, potentially with 0 size (so not a partition).  I'd be happier if we
> can avoid that by just prefilling the lot with zero size and filling in
> the ones we want.  So zero size means doesn't exist and use an iterator where
> appropriate to skip the zero size ones.
>
> Without that tidied up, to me this is more confusing than the previous code.
>
> Jonathan
>
>> ---
>>   drivers/cxl/core/cdat.c      |   15 ++-----
>>   drivers/cxl/core/hdm.c       |   69 ++++++++++++++++++++++++++++++++++
>>   drivers/cxl/core/mbox.c      |   86 ++++++++++++++++++------------------------
>>   drivers/cxl/cxlmem.h         |   79 +++++++++++++++++++++++++--------------
>>   drivers/cxl/pci.c            |    7 +++
>>   tools/testing/cxl/test/cxl.c |   15 ++-----
>>   tools/testing/cxl/test/mem.c |    7 +++
>>   7 files changed, 176 insertions(+), 102 deletions(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index b177a488e29b..5400a421ad30 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -261,25 +261,18 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>>   	struct device *dev = cxlds->dev;
>>   	struct dsmas_entry *dent;
>>   	unsigned long index;
>> -	const struct resource *partition[] = {
>> -		to_ram_res(cxlds),
>> -		to_pmem_res(cxlds),
>> -	};
>> -	struct cxl_dpa_perf *perf[] = {
>> -		to_ram_perf(cxlds),
>> -		to_pmem_perf(cxlds),
>> -	};
> Ok. This removes some of the concerns from previous patch.
>
>>   
>>   	xa_for_each(dsmas_xa, index, dent) {
>> -		for (int i = 0; i < ARRAY_SIZE(partition); i++) {
>> -			const struct resource *res = partition[i];
>> +		for (int i = 0; i < cxlds->nr_partitions; i++) {
>> +			struct resource *res = &cxlds->part[i].res;
>>   			struct range range = {
>>   				.start = res->start,
>>   				.end = res->end,
>>   			};
>>   
>>   			if (range_contains(&range, &dent->dpa_range))
>> -				update_perf_entry(dev, dent, perf[i]);
>> +				update_perf_entry(dev, dent,
>> +						  &cxlds->part[i].perf);
>>   			else
>>   				dev_dbg(dev,
>>   					"no partition for dsmas dpa: %pra\n",
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 7a85522294ad..7e1559b3ed88 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -342,6 +342,75 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>>   	return 0;
>>   }
>>   
>> +static int add_dpa_res(struct device *dev, struct resource *parent,
>> +		       struct resource *res, resource_size_t start,
>> +		       resource_size_t size, const char *type)
>> +{
>> +	int rc;
>> +
>> +	*res = (struct resource) {
>> +		.name = type,
>> +		.start = start,
>> +		.end =  start + size - 1,
>> +		.flags = IORESOURCE_MEM,
>> +	};
>> +	if (resource_size(res) == 0) {
>> +		dev_dbg(dev, "DPA(%s): no capacity\n", res->name);
>> +		return 0;
>> +	}
>> +	rc = request_resource(parent, res);
>> +	if (rc) {
>> +		dev_err(dev, "DPA(%s): failed to track %pr (%d)\n", res->name,
>> +			res, rc);
>> +		return rc;
>> +	}
>> +
>> +	dev_dbg(dev, "DPA(%s): %pr\n", res->name, res);
>> +
>> +	return 0;
>> +}
>> +
>> +/* if this fails the caller must destroy @cxlds, there is no recovery */
>> +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
>> +{
>> +	struct device *dev = cxlds->dev;
>> +
>> +	guard(rwsem_write)(&cxl_dpa_rwsem);
>> +
>> +	if (cxlds->nr_partitions)
>> +		return -EBUSY;
>> +
>> +	if (!info->size || !info->nr_partitions) {
>> +		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
>> +		cxlds->nr_partitions = 0;
>> +		return 0;
>> +	}
>> +
>> +	cxlds->dpa_res = DEFINE_RES_MEM(0, info->size);
>> +
>> +	for (int i = 0; i < info->nr_partitions; i++) {
>> +		const char *desc;
>> +		int rc;
>> +
>> +		if (i == CXL_PARTITION_RAM)
>> +			desc = "ram";
>> +		else if (i == CXL_PARTITION_PMEM)
>> +			desc = "pmem";
>> +		else
>> +			desc = "";
>> +		cxlds->part[i].perf.qos_class = CXL_QOS_CLASS_INVALID;
>> +		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->part[i].res,
>> +				 info->range[i].start,
>> +				 range_len(&info->range[i]), desc);
>> +		if (rc)
>> +			return rc;
>> +		cxlds->nr_partitions++;
> I'd just initialize the rest to 0 length similar to what is happening
> if we have pmem only anyway.  Then this nr_patitions goes away and
> stops being a possible source of confusion.
>
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(cxl_dpa_setup);
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 3502f1633ad2..7dca5c8c3494 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1241,57 +1241,36 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>> -int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>> +int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>>   {
>>   	struct cxl_dev_state *cxlds = &mds->cxlds;
>> -	struct resource *ram_res = to_ram_res(cxlds);
>> -	struct resource *pmem_res = to_pmem_res(cxlds);
>>   	struct device *dev = cxlds->dev;
>>   	int rc;
>>   
>>   	if (!cxlds->media_ready) {
>> -		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
>> -		*ram_res = DEFINE_RES_MEM(0, 0);
>> -		*pmem_res = DEFINE_RES_MEM(0, 0);
>> +		info->size = 0;
>>   		return 0;
>>   	}
>>   
>> -	cxlds->dpa_res = DEFINE_RES_MEM(0, mds->total_bytes);
>> +	info->size = mds->total_bytes;
>>   
>>   	if (mds->partition_align_bytes == 0) {
> Obviously nothing to do with your patch as such, but maybe tidy this up
> by making active values == fixed values when we don't have partition control.
> That seems logical anyway to me and means we only end up with one lot of
> range setup in here.  I can't immediately see any side effects of doing this.
>
>
>
> 	if (mds->partition_align_bytes != 0) {
> 		rc = cxl_mem_get_partition_info(mds);
> 		if (rc)
> 			return rc;
> 	} else {
> 		mds->active_volatile_bytes = mds->volatile_only_bytes;
> 		mds->active_persistent_bytes = mds->persistent_only_bytes;
> 	}
>   	info->range[CXL_PARTITION_RAM] = (struct range) {
> 		.start = 0,
> 		.end = mds->active_volatile_bytes - 1,
> 	};
> 	info->nr_partitions++;
>
> 	if (!mds->active_persistent_bytes)
> 		return 0;
>
> 	info->range[CXL_PARTITION_PMEM] = (struct range) {
> 		.start = mds->active_volatile_bytes,
> 		.end = mds->active_volatile_bytes + mds->active_persistent_bytes - 1,
> 	};
> 	info->nr_partitions++;
>
> 	return 0;
> }
>
>> -		rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
>> -				 mds->volatile_only_bytes, "ram");
>> -		if (rc)
>> -			return rc;
>> -		return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
>> -				   mds->volatile_only_bytes,
>> -				   mds->persistent_only_bytes, "pmem");
>> +		info->range[CXL_PARTITION_RAM] = (struct range) {
>> +			.start = 0,
>> +			.end = mds->volatile_only_bytes - 1,
>> +		};
>> +		info->nr_partitions++;
>> +
>> +		if (!mds->persistent_only_bytes)
>> +			return 0;
>> +
>> +		info->range[CXL_PARTITION_PMEM] = (struct range) {
>> +			.start = mds->volatile_only_bytes,
>> +			.end = mds->volatile_only_bytes +
>> +			       mds->persistent_only_bytes - 1,
>> +		};
>> +		info->nr_partitions++;
> This nr partitions makes some sense though I'd be tempted to add a type
> array to info so that we can just not pass empty ones if we don't want to.
> Makes this code a little more complex, but not a lot and means
> nr->partitions becomes the ones that actually exist.
>
>> +		return 0;
>>   	}
>>   
>>   	rc = cxl_mem_get_partition_info(mds);
>> @@ -1300,15 +1279,24 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>>   		return rc;
>>   	}
>>   
>> -	rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
>> -			 mds->active_volatile_bytes, "ram");
>> -	if (rc)
>> -		return rc;
>> -	return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
>> -			   mds->active_volatile_bytes,
>> -			   mds->active_persistent_bytes, "pmem");
>> +	info->range[CXL_PARTITION_RAM] = (struct range) {
>> +		.start = 0,
>> +		.end = mds->active_volatile_bytes - 1,
>> +	};
>> +	info->nr_partitions++;
>> +
>> +	if (!mds->active_persistent_bytes)
>> +		return 0;
>> +
>> +	info->range[CXL_PARTITION_PMEM] = (struct range) {
>> +		.start = mds->active_volatile_bytes,
>> +		.end = mds->active_volatile_bytes + mds->active_persistent_bytes - 1,
>> +	};
>> +	info->nr_partitions++;
>> +
>> +	return 0;
>>   }
>> -EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, "CXL");
>> +EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 78e92e24d7b5..2e728d4b7327 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -97,6 +97,20 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>>   			 resource_size_t base, resource_size_t len,
>>   			 resource_size_t skipped);
>>   
>> +/* Well known, spec defined partition indices */
>> +enum cxl_partition {
>> +	CXL_PARTITION_RAM,
>> +	CXL_PARTITION_PMEM,
>> +	CXL_PARTITION_MAX,
>> +};
>> +
>> +struct cxl_dpa_info {
>> +	u64 size;
>> +	struct range range[CXL_PARTITION_MAX];
>> +	int nr_partitions;
>> +};
> blank line seems appropriate here.
>
>> +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
>> +
>>   static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>>   					 struct cxl_memdev *cxlmd)
>>   {
>> @@ -408,6 +422,16 @@ struct cxl_dpa_perf {
>>   	int qos_class;
>>   };
>>   
>>   /**
>>    * struct cxl_dev_state - The driver device state
>>    *
>> @@ -423,8 +447,8 @@ struct cxl_dpa_perf {
>>    * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
>>    * @media_ready: Indicate whether the device media is usable
>>    * @dpa_res: Overall DPA resource tree for the device
>> - * @_pmem_res: Active Persistent memory capacity configuration
>> - * @_ram_res: Active Volatile memory capacity configuration
>> + * @part: DPA partition array
>> + * @nr_partitions: Number of DPA partitions
> This needs more. It is not the number of partitions present I think, it
> is the number that a particular driver is potentially interested in.
>
>>    * @serial: PCIe Device Serial Number
>>    * @type: Generic Memory Class device or Vendor Specific Memory device
>>    * @cxl_mbox: CXL mailbox context
>> @@ -438,21 +462,39 @@ struct cxl_dev_state {
>>   	bool rcd;
>>   	bool media_ready;
>>   	struct resource dpa_res;
>> -	struct resource _pmem_res;
>> -	struct resource _ram_res;
>> +	struct cxl_dpa_partition part[CXL_PARTITION_MAX];
>> +	unsigned int nr_partitions;
>>   	u64 serial;
>>   	enum cxl_devtype type;
>>   	struct cxl_mailbox cxl_mbox;
>>   };
>>   
>> -static inline struct resource *to_ram_res(struct cxl_dev_state *cxlds)
>> +static inline const struct resource *to_ram_res(struct cxl_dev_state *cxlds)
>>   {
>> -	return &cxlds->_ram_res;
>> +	if (cxlds->nr_partitions > 0)
>> +		return &cxlds->part[CXL_PARTITION_RAM].res;
>> +	return NULL;
>>   }
>>   
>> -static inline struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
>> +static inline const struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
>>   {
>> -	return &cxlds->_pmem_res;
>> +	if (cxlds->nr_partitions > 1)
> This is very confusing as nr_partitions is being used not to indicate
> number of partitions but whether a driver has filled in the data for them
> (which may well be empty).


I would say this is more than confusing: it is broken. What if a device 
only has pmem?

Number of partitions would be 1 ...

>
> I'd rather see that as a bitmap, or a 'not set' value initialized by
> the core that is then replaced when they are set.


Repeating my doubt I expressed in the previous patch but with other words:

Is it not enough to give the reference to the ram/pmem resource and then 
work based on the size?


>> +		return &cxlds->part[CXL_PARTITION_PMEM].res;
>> +	return NULL;
>> +}
>> +
>> +static inline struct cxl_dpa_perf *to_ram_perf(struct cxl_dev_state *cxlds)
>> +{
>> +	if (cxlds->nr_partitions > 0)
>> +		return &cxlds->part[CXL_PARTITION_RAM].perf;
>> +	return NULL;
>> +}
>> +
>> +static inline struct cxl_dpa_perf *to_pmem_perf(struct cxl_dev_state *cxlds)
>> +{
>> +	if (cxlds->nr_partitions > 1)
>> +		return &cxlds->part[CXL_PARTITION_PMEM].perf;
>> +	return NULL;
>>   }
>
>> @@ -860,7 +883,7 @@ int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>>   int cxl_dev_state_identify(struct cxl_memdev_state *mds);
>>   int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>>   int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>> -int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
>> +int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
>>   struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
>>   void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>>   				unsigned long *cmds);
>> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
>> index 7f1c5061307b..ba3d48b37de3 100644
>> --- a/tools/testing/cxl/test/cxl.c
>> +++ b/tools/testing/cxl/test/cxl.c
>> @@ -1001,26 +1001,19 @@ static void mock_cxl_endpoint_parse_cdat(struct cxl_port *port)
>>   	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>   	struct access_coordinate ep_c[ACCESS_COORDINATE_MAX];
>> -	const struct resource *partition[] = {
>> -		to_ram_res(cxlds),
>> -		to_pmem_res(cxlds),
>> -	};
>> -	struct cxl_dpa_perf *perf[] = {
>> -		to_ram_perf(cxlds),
>> -		to_pmem_perf(cxlds),
>> -	};
> Ok. This gets rid of some of the earlier concerns.
>
>>   
>>   	if (!cxl_root)
>>   		return;
>>   
>> -	for (int i = 0; i < ARRAY_SIZE(partition); i++) {
>> -		const struct resource *res = partition[i];
>> +	for (int i = 0; i < cxlds->nr_partitions; i++) {
>> +		struct resource *res = &cxlds->part[i].res;
>> +		struct cxl_dpa_perf *perf = &cxlds->part[i].perf;
>>   		struct range range = {
>>   			.start = res->start,
>>   			.end = res->end,
>>   		};
>>   
>> -		dpa_perf_setup(port, &range, perf[i]);
>> +		dpa_perf_setup(port, &range, perf);
>>   	}
>>   
>>   	cxl_memdev_update_perf(cxlmd);
>
