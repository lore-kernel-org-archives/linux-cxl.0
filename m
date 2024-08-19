Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F95A3BBF2;
	Mon, 19 Aug 2024 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084469; cv=fail; b=b+4E1gwBALtfsIRdlxwnmMEjAzANBsu6BLaL4RZ0ZhIgQC5CNgpdVDRZuu3PawJKgRbB+WeznAWxVFVLQwLk9mvYfpoUGq3nQ6n/vJ7MMCTdeeKGH6jV4HlMtXGirMdYsTtbugF+V87QncIGdgnbyRF0RdxMgfpmRANWcua4kjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084469; c=relaxed/simple;
	bh=gwstuTVE88c4sAthhiX70K4e4FbPK3kXOBmxeu6gM3A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NxNiWk+D+bMagZy81ZN/ssINUUFd0zbJkaBMNqCfVdTWU99/9Gt+jmFQdYaq/6G/VA8LyKHVl2s0PZSd8E80s1Q+uVpeNoeqaDIbT+UpLQo+2m6CxSeqWlWY7mfldNNe+/LfPHpTmYmjIEDo5PAtyuGXEcuH9OAmaQTWhRstzZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=khgeEKYT; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="khgeEKYT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNlT/08PIPu0JcxY2LRJ3+bDNbjKy6wQdrBnyyQUpnCU4tTVzR2v3FvaklCbqwZcpcpu0Kh/r1ytcwJ3VE7a4oGTJdPseH9zmMPiJBfAGIxnVYfrl6Xu2SUNeViqhjcDWi1Ek02J+675oiQQfnrZno+lDwMWobMIQ/Z1i5ls15Hs0a+GyyxeqZjFJlSbzm179HI+u20wHzLeG+r6bz+f3VxIvE7VqtZ3q478edrrjo6lebtmRH4QvZNU+wljPkeaLL8EjEOvmBbM8Ua6bBYFcR4T1IUB0j5dQLYQ3vC54DN3bwbWz1qg55QsTgc8XmKzGUd1WBUSj7xv220/fnCT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8t8Ri28x4x/GQUXUJT9NQtO8Ldiv6skN9ZqWOGPtJs=;
 b=FFBLFWoUqMVq0K19PCwYSzGA209ScOk3FbsncpnDDDKzqQInp7T93+wBWvRTfHW3fE9g0ySg+DV2zcWiDp/azzZY8k287+PpoMNh3ANi5tMQEOFyFbSIWZGix6mlqPyJgSJayZ4fCeUOHyKU7Izxo6VYtbLF893iuwSicEQSQ0aRv6Cgyg7Ra1rWs08nVT6QhxALGyu7p+zNIQGhdVQuQ04HZn0EfmJ3Fnaj6fPCoKsKtzjqGfcXxW54NRcwQaxONsf8VBSPGSzdxH6la6UKL5SRJf8TbjQcugeqcXgFW50d+SiohM2osam6tE96i3/QF5ILEo5u7k0Pw3dr2JPW7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8t8Ri28x4x/GQUXUJT9NQtO8Ldiv6skN9ZqWOGPtJs=;
 b=khgeEKYTFOFEwmg41Bit9TW3YwbS2vCTUmuuirCzkGUvK7fNT4N3CLco6hTgM36BMA1coRKePTfFq9DTPHcWz8eVuqN4rlU1skJ+EIs2Wx9RfW9nHXs4ssPFJ3Iykdg07ekPedWf0u5Enm2E+BHVY1vPrykuCmKFj6FGaGAMszA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Mon, 19 Aug 2024 16:21:04 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%7]) with mapi id 15.20.7875.018; Mon, 19 Aug 2024
 16:21:04 +0000
Message-ID: <6db43744-1d92-482a-852f-8d43efa55b74@amd.com>
Date: Mon, 19 Aug 2024 11:21:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] Add RAS support for CXL root ports, CXL
 downstream switch ports, and CXL upstream switch ports
To: fan <nifan.cxl@gmail.com>
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, ming4.li@intel.com,
 vishal.l.verma@intel.com, jim.harris@samsung.com,
 ilpo.jarvinen@linux.intel.com, ardb@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yazen.Ghannam@amd.com, Robert.Richter@amd.com,
 a.manzanares@samsung.com
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <ZqKeHWsZtDb1RKfh@debian>
Content-Language: en-US
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <ZqKeHWsZtDb1RKfh@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0075.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::16) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS7PR12MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: cf007f3d-b6af-465f-62d3-08dcc06aec77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmwrdnpGOGdzcmJINXZIWkVDOVRlbytyRHg4anlieHBIdkFJS25zSFlxbnpN?=
 =?utf-8?B?RHZxZXAzZG1kSHd1V3JHallaZXVDNk1BeHhLc01vMUJ6U0w1SUlmYzhsM0Fs?=
 =?utf-8?B?NXh3TE5lTEdmYzB5YkNWZGI2eVhPYkg5YUZ3QTducGM3VE9EMThTYmxHQkVy?=
 =?utf-8?B?b0ZQbUdRTU1adWkzZkJOV2tMQStMeWFLVFlEVzVDcTkrVE5QSWcwUUwwTTRh?=
 =?utf-8?B?UW9LZjBTdENPUHdSbVQvU1ZBMHcvNTdrSzNMY3RoYkpHbHZKVk9tY203Y0VB?=
 =?utf-8?B?bENtUWkwVElDWnJzakRvanBxTXd2eEJCWlg5MDZoU0tDU3VIbkJzdGxocmVx?=
 =?utf-8?B?NDVGQ21aYmpMVlpFdnZRWnArUzRtSEVlSU5Rc1NFVy8wVDRSRmlkazZ2eXdv?=
 =?utf-8?B?UmFOT3N4SkVDQ0ZvUlUyZnBtZ3NaQnRoVmJWMWtSMElqcE8xOExzaldqNjEx?=
 =?utf-8?B?M0ZTSE5iTFlzdFVBUWh1cXBKM3dXcVN5bjZhZFFqRjJFVzVmaDNVYkprL1Z1?=
 =?utf-8?B?cmpsTEIvb2g4ZDRLd3JwUzJuNGFRU2w1VFRxLzZBeXk0K3JoZUFPSUJOanEx?=
 =?utf-8?B?VXhIL0NYcGNRRnFiMlZuL1dwTVB5T2g0cXFOQzZmYWFiODduc0wzL2ZXd0Zi?=
 =?utf-8?B?UEUrU3ZUTGZ0SjdZaGhEZ2lYZXpUL0ZDcDc5VU1vQW14N0JQS1graTMrUjlo?=
 =?utf-8?B?SVZFOFpGS0RzaGw1UGhvTWdSM1E5THdpVFNkbHNtVWxJa3VVVm1KTjZPYUJB?=
 =?utf-8?B?bXpodEkzYlN4U2pWQytaQkxCM3dGM280cjZTT0kwNllXY0JtRGkrVndPUzl4?=
 =?utf-8?B?ZlgzUTZWbE9jQSs1RHVlSDJkcEUvWG9nRHpTVXVUZVN3UmZoZU16eDR3enRT?=
 =?utf-8?B?eFBYTDd2VEpVQ1MyVDZESFVoZ3lwc0loajhtdnlteFkxYmVvbXJPS2NMcVVD?=
 =?utf-8?B?ZEpML2RoQnFkaEk0YS9HZFdCM05QR0R2OUIweHhPWWx4OXZEN0VLbnArRlFM?=
 =?utf-8?B?NnhIU3hvam9NeGYwazdDeEdzazl2d3VLSkM1YkpKWDY3U0NkK1lhanhWeTdx?=
 =?utf-8?B?ZEtpTTF2RUpWNEV1WXJDU1M2SGxvNGk1ODVTdmRkazFUUm5qL3l0TlE3VHlP?=
 =?utf-8?B?SmFxQ3VBdU91QVUyUDFaOFRycm50Ylo4WGZJdURWSWNQUUNxeEkyMHE3em9P?=
 =?utf-8?B?a0JJUzR0Q2swelVMSDZtNUJIb3FmTElGT0N0ajVzMmlxVmdNMTlwYi9PTlYr?=
 =?utf-8?B?YlA1TXBLWU0yNWFrMC9XcGpIRnhtOUp4Wm9KUUhYci9ZeXU2eUEyUi8xMm9F?=
 =?utf-8?B?Rzh0QWpvMklRdXlHQXVBcGJPNE1GdEY3RDJXWEVPSTVtUFR6bU94c21SbVNR?=
 =?utf-8?B?YnZsQmxDUHoxV1g5T0puTVpXMGJOdDFHaGs0RDNKZ3lseXdndTlrZzEyN3Qw?=
 =?utf-8?B?NDk5ZjYwNks0WjRwSHp1WXl2OEZ0RzY1Q1JPM1ducUhJUjhIM24vVWNNU0dO?=
 =?utf-8?B?RG5UY1JxbDYvZEdYaUZXWUhwV0t1OEs0OU4rMko4anU1R2N0OTgvVEV3MThP?=
 =?utf-8?B?T2xFVHRnSnVKZ1RDb3dIL0JtRXpwdnVqMGtSeDB0dmdXUW5HQURBRjhiaHRN?=
 =?utf-8?B?R0JlTE9WUGJFNWlJRy9iOEFrUHIyWE9rN2NnOFUzeUdGdFUrU25tNUp3WklE?=
 =?utf-8?B?Y3B4U0MyM2pXVk1RMHpTYzdycW80eFRUcHljanRBdnh5Z1pJd2dpaVBkK1lT?=
 =?utf-8?Q?w2m8gUVHV/lMvkWUok=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzJsaHR2SXFuSlFZZ3V2eVJjSzJveTYzZk1hbjkvUE40c1BzNXgwbGZ3ZFB5?=
 =?utf-8?B?QUFoM0FSK1o4Z0NSSzIvbTlITmIyNUxnVHhvUVZZYm54SjNzRVQ0Nml3S1BE?=
 =?utf-8?B?NnhVdGMrVnQyNG1CWjNFQ0RkVHVMVWcrc0FJZ05PZlV0VmhJYlZodHk3TldZ?=
 =?utf-8?B?a0hoRVNLY0g3VStscjdkZjNualFDY29ZZ3owK0lLSDU1WU5vQjdvUkxNVEFa?=
 =?utf-8?B?Yk5mN1RScGQ5YzhXelhkeHhWR1ZPcWJGdkV1MHpvTnNwVWppMEtGdUx6Q1JT?=
 =?utf-8?B?MTVkM0hrQW1nS1lkelB0Wi9zWkhlQ0hOM3VkL1hUZ3lGZGdIYkpMVmk1bUY3?=
 =?utf-8?B?Uk1pMy85OVNWbllhTkFMVmRRSU55TTIzYVBBdFNseGRrY0dYOTJHWHJwdGdS?=
 =?utf-8?B?TWNPUkt5QjFkakQwc2lBanJRaDA1c2c3YURHeWhpUHQzKzB0YXJjVDRhZjAy?=
 =?utf-8?B?V1dRbHRVWStqeDZxWGNOYzFRMkVLZnB5R2F0M0ozODJYSSt5cEZzalQ0Y21G?=
 =?utf-8?B?SW1nSW1qeVFleTF1STNRUVhNL09YOGRSb2srM05uUHZGYmlZak83WE50TzM0?=
 =?utf-8?B?ZmFsVkhPS29PdkNyYnRpRG9FWEdIMFFlNjRoZkFVaEUvZWpLb1h3dG5pdE5B?=
 =?utf-8?B?YURGN0hoSnQ5TTNxcjdDK3V6bXFmV0NVNzZLRDJLdHNJL1ZLYmlicGl5Sjk3?=
 =?utf-8?B?Y1haakdpUWVMT1VaVEl4Um96NnN0YTN0Y0pUWG5CWjJHTUh2QnJIVGpoVWsw?=
 =?utf-8?B?bEw2cTExUkdkZG5SdTR4SUcwN2VpNlo0VDRleGR5b2wzcFpsSFdWYjNjT0V0?=
 =?utf-8?B?SGhJdG1TSFZGcTRnd29yS2t2cGJyQVFwSG56UXZYTG5jVTBXZG9zRk1GNzhw?=
 =?utf-8?B?WCt0VTIzT0FtVnM3ckdJeGNJN2syUHRBZlJqbVJpREM3Zmd4ZWtFTGpYSFd3?=
 =?utf-8?B?RjhrdUxWRWNYWnpkMmdUZm5vVS94cGpMMWpqaEhpVWp3N0hCWi9xZU5MY2N0?=
 =?utf-8?B?OHFleFp5QzVQMEJITW1VdlhuM2FMclF2NWJyVGRISU9iR0pPNXp4MnB0aENh?=
 =?utf-8?B?RTFpQ3h5enBmNlExU0dQQTJSc3V4R1NoSDBQc1VyZFI1S29oa3RUWFBoVGll?=
 =?utf-8?B?QWtnZ1lPSzN5UC95bjF6V0F3Y1dLWVNWaWxEbGZJNFNpSjd6ekFiMk9iM1Q2?=
 =?utf-8?B?QXhXMTN1TXY0R0Nma3RUNy9SY2RrNGFrSVQxM0lZb0lZd0UxNnNsU21aRHRs?=
 =?utf-8?B?WjFEcy9uOGY0ejBNVGorWFRwWmJrS3d5ajVrWkZEZDZ1bHdDZ3ROamFVT0I0?=
 =?utf-8?B?Yk9DTjdGczlRU0NSdTlDU09qRUMrR0dsN3MwTWl5TEU2bFlXTVpFYVlMRFFr?=
 =?utf-8?B?OVFQQ0ZlMGhMeWs0YVpxTENpR0orcHdMd1JmeGdqekV6S05rSFdHemV0RUg3?=
 =?utf-8?B?WlpCWVF5L3crczVwa0JXUnd5QXhlTXA1d2NRVzBJcUF1d1h2TTVxd003WDhy?=
 =?utf-8?B?ZU94OVhiWjY4SitadzZLMjBnOE1DeEQ0dTllcDZOT3dmbE5NSjVHRC9LOWJq?=
 =?utf-8?B?eEFhR3U4YTBlOUVsY1lieUlhRDJiY3dNeTlRSUs4VzFzUUhjUWZMUjJ4R0VJ?=
 =?utf-8?B?VU14WThYbFVhWkJaREpjYkUwc1d3SGZGZ1VmL2NMQ3AzTm5JL3ZVeE8vQVFK?=
 =?utf-8?B?UjVUL0MvdXFyZXBQbkFtWTNyc2JjcjN4VTZ6L04rakM0RWdCb2NzbDY2ZHkr?=
 =?utf-8?B?Ukhkb3BGSmkzeEdGSGR4R0g4Nmpxdzl1T2xOOU5ENVhQZDUzRFU0enUwNnY1?=
 =?utf-8?B?SnpnQ3RGaUl6MDRUdFpVeHVHdWRhVkhjVkI5RlFVRWwvRkI4TmlZMHBvUzJk?=
 =?utf-8?B?WTlOZEF1OGQ5T1c0TkhHTERxdkE1aExGRkczeVp1U0tkM1NTbnRUY2VvK2xJ?=
 =?utf-8?B?UVVQVGxZZCs2dVhiMnFYZHlFdVNlenAzd2g0TWNOVkQ3b21jejVKZEhhN3dN?=
 =?utf-8?B?ZE1aNHFrNzJFYkFOQy9EWHdBYXhydkNCR00zM2lzM2N0Z3E0VDZPTE55UExz?=
 =?utf-8?B?djJjdHNnY3hkM0JDUmtlNW94OFFLN1VMcUxnKzNCSzMwS3RnM2pIaTJWNW5H?=
 =?utf-8?Q?PuIyXOpML+gsAGh1LzMzMcxIw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf007f3d-b6af-465f-62d3-08dcc06aec77
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 16:21:04.7651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3w4p/QhmXr2QORZkpjtLUWiHLicDoUH2Wraw0McTqKiXWYS2GqAwzEQRHZoCHD1hpBvzljb1M+ZTsfZpAHtFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982

Hi Fan

On 7/25/24 13:49, fan wrote:
> On Mon, Jun 17, 2024 at 03:04:02PM -0500, Terry Bowman wrote:
>> This patchset provides RAS logging for CXL root ports, CXL downstream
>> switch ports, and CXL upstream switch ports. This includes changes to
>> use a portdrv notifier chain to communicate CXL AER/RAS errors to a
>> cxl_pci callback.
>>
>> The first 3 patches prepare for and add an atomic notifier chain to the
>> portdrv driver. The portdrv's notifier chain reports the port device's
>> AER internal errors to the registered callback(s). The preparation changes
>> include a portdrv update to call the uncorrectable handler for PCIe root
>> ports and PCIe downstream switch ports. Also, the AER correctable error
>> (CE) status is made available to the AER CE handler.
>>
>> The next 4 patches are in preparation for adding an atomic notification
>> callback in the cxl_pci driver. This is for receiving AER internal error
>> events from the portdrv notifier chain. Preparation includes adding RAS
>> register block mapping, adding trace functions for logging, and
>> refactoring cxl_pci RAS functions for reuse.
>>
>> The final 2 patches enable the AER internal error interrupts.
>>
>> Testing RAS CE/UCE:
>>   QEMU was used for testing CXL root port, CXL downstream switch port, and
>>   CXL upstream switch port. The aer-inject tool was used to inject AER and
>>   a test patch was used to set the AER CIE/UIE and RAS CE/UCE status during
>>   testing. Testing passed with no issues.
> 
> Hi Terry,
> 
> Could you share a little more about the qemu test setup?
> From what I see, it seems currently qemu can only inject error to
> type3 devices, is that true? Or how to do that for port devices?
> Do we need a hack there?
> 
> Also, is the aer-inject tool you mentioned the one currently in the kernel
> or something else?
> https://elixir.bootlin.com/linux/v6.10-rc6/source/drivers/pci/pcie/aer_inject.c
> 
> Thanks,
> Fan
> 
Sorry for the late response.

I used AMD RAS injection for testing HW root ports.

I used QEMU and the legacy aer-inject userspace tool to test switch ports (USP/DSP).[1] 
I added a couple test patches to set the AER UIE/CIE because the tool doesn't support 
injecting UIE or CIE bits. I used a test patch for assigning the RAS status as well.

Regards,
Terry

[1] - https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git/about/

> 
>>  
>>   An AMD platform with the AMD RAS error injection tool was used for
>>   testing CXL root port injection. Testing passed with no issues.
>>
>>   TODO - regression test CXL1.1 RCH handling.
>>
>> Solutions Considered (1-4):
>>   Below are solutions that were considered. Solution #4 is
>>   implemented in this patchset. 
>>
>>   1.) Reassigning portdrv error handler for CXL port devices
>>   
>>   This solution was based on reassigning the portdrv's CE/UCE err_handler
>>   to be CXL cxl_pci driver functions.
>>   
>>   I started with this solution and once the flow was working I realized
>>   the endpoint removal would have to be addressed as well. While this
>>   could be resolved it does highlight the odd coupling and dependency
>>   between the CXL port devices error handling with cxl_pci endpoint's
>>   handlers. Also, the err_handler re-assignment at runtime required
>>   ignoring the 'const' definition. I don't believe this should be
>>   considered as a possible solution.
>>   
>>   2.) Update the AER driver to call cxl_pci driver's error handler before
>>   calling pci_aer_handle_error()
>>
>>   This is similar to the existing RCH port error approach in aer.c.
>>   In this solution the AER driver searches for a downstream CXL endpoint
>>   to 'handle' detected CXL port protocol errors.
>>
>>   This is a good solution to consider if the one presented in this patchset
>>   is not acceptable. I was initially reluctant to this approach because it
>>   adds more CXL coupling to the AER driver. But, I think this solution
>>   would technically work. I believe Ming was working towards this
>>   solution.
>>
>>   3.) Refactor portdrv
>>   The portdrv refactoring solution is to change the portdrv service drivers
>>   into PCIe auxiliary drivers. With this change the facility drivers can be
>>   associated with a PCIe driver instead fixed bound to the portdrv driver.
>>
>>   In this case the CXL port functionality would be added either as a CXL
>>   auxiliary driver or as a CXL specific port driver
>>   (PCI_CLASS_BRIDGE_PCI_NORMAL).
>>
>>   This solution has challenges in the interrupt allocation by separate
>>   auxiliary drivers and in binding of a specific driver. Binding is
>>   currently based on PCIe class and would require extending the binding
>>   logic to support multiple drivers for the same class.
>>
>>   Jonathan Cameron is working towards this solution by initially solving
>>   for the PMU service driver.[1] It is using the auxiliary bus to associate
>>   what were service drivers with the portdrv driver. Using a CXL auxiliary
>>   for handling CXL port RAS errors would result in RAS logic called from
>>   the cxl_pci and CXL auxiliary drivers. This may need a library driver.
>>
>>   4.) Using a portdrv notifier chain/callback for CIE/UIE
>>   (Implemented in this patchset)
>>
>>   This solution uses a portdrv atomic chain notifier and a cxl_pci
>>   callback to handle and log CXL port RAS errors.
>>   
>>   I chose this after trying solution#1 above. I see a couple advantages to
>>   this solution are:
>>   - Is general port implementation for CIE/UIE specific handling mentioned
>>   in the PCIe spec.[2]
>>   - Notifier is used in RAS MCE driver as an existing example.
>>   - Does not introduce further CXL dependencies into the AER driver.
>>   - The notifier chain provides registration/unregistration and
>>   synchronization.
>>
>>   A disadvantage of this approach is coupling still exists between the CXL
>>   port's driver (portdrv) and the cxl_pci driver. The CXL port device's RAS
>>   is handled by a notifier callback in the cxl_pci endpoint driver.
>>
>>   Most of the patches in this patchset could be reused to work with
>>   solution#3 or solution#2. The atomic notifier could be dropped and
>>   instead use an auxiliary device or AER driver awareness. The other
>>   changes in this patchset could possibly be reused.
>>
>>   [1] Kernel.org -
>>   https://lore.kernel.org/all/f4b23710-059a-51b7-9d27-b62e8b358b54@linux.intel.com
>>   [2] PCI6.0 - 6.2.10 Internal errors
>>
>>  drivers/cxl/core/core.h    |   4 +
>>  drivers/cxl/core/pci.c     | 153 ++++++++++++++++++++++++++++++++-----
>>  drivers/cxl/core/port.c    |   6 +-
>>  drivers/cxl/core/trace.h   |  34 +++++++++
>>  drivers/cxl/cxl.h          |  10 +++
>>  drivers/cxl/cxlpci.h       |   2 +
>>  drivers/cxl/mem.c          |  32 +++++++-
>>  drivers/cxl/pci.c          |  19 ++++-
>>  drivers/pci/pcie/aer.c     |  10 ++-
>>  drivers/pci/pcie/err.c     |  20 +++++
>>  drivers/pci/pcie/portdrv.c |  32 ++++++++
>>  drivers/pci/pcie/portdrv.h |   2 +
>>  include/linux/aer.h        |   6 ++
>>  13 files changed, 303 insertions(+), 27 deletions(-)
>>
>>
>> base-commit: ca3d4767c8054447ac2a58356080e299a59e05b8
>> -- 
>> 2.34.1
>>
