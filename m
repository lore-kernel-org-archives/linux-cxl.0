Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8239B3B1A2
	for <linux-cxl@vger.kernel.org>; Fri,  6 Sep 2024 07:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725607442; cv=fail; b=PUNQ0GZeVK4qcNcElhu7i8AAYzI/tE4HbkBPK1BoUOocWnDBmSTCdWZBbjVk0UjJ4XeLAFeXPrVIsH7t0xQTegIpmwHdVVXACweI9Edsh6WpULv0gAJBHqYo3gp8GpyxkATvCstfY9YqAjRbNyK4RAL1DGaxOS0SoD0AYJ1v8+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725607442; c=relaxed/simple;
	bh=ehlzSz43KHH3Ndj/UnWdKVsw/u/BqkpTih60qVcjpbA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lzFcbGf/OhF30y77mfrzw4b80Tu0iZy7tQFUws8JDjFjEPEY55Xvyvj1S3WLFbeCOz29gJ6AyVba3qliitPwjydFXtUbQbUppVjwEDEljROJpVSROllIn1+MxRgzZGiPHVigfF82Kn4gKQLhfGhpc1KYlc0cFBnvVeHUjJq0BAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kUeN0op6; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kUeN0op6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6b91jQOPM1KRjcNE5WRjZbYQEwJ7Y597liUTACNEIj7IXAUrHe68b7fxQVrwSDGkvzRJod125kMiP1XKMGDIMlpeL+2d2tTbueBDSzGmiV8f5psMB17fThAFcWy7mznr5Nivkr6xWPK6BU4FlJpOOu5cNtjL4hkAETFVvgPpKK9XxncDnqGpzqwBWZsbKe4rGqtFRBAKqr2KMI+xGNCC+1gCFR8Zons/8tZDmEr2Qv5cfjc13ZWzpOajapdy3CHSNDZW2CzRzhZtyDdrAatefhBV1GgEADX1NEhtCSXrhcgDPv+LgvZU9N6uDzK1UBkHafK4PJCap4YcSljyXaN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqILWHNWimDbelPRLXr5JBm1tIlZbuQ4uizK+YduLMw=;
 b=KyrAfIPianyuWFgfQOJ0j3LvXGU+EP6l7qBAgiUno311kSDMeMdKX+u7vhr5jWj1RkvmHL3niKXRKbOyOIY1ZFk0NaW6tNR59qmG5REkYd2nHg/stFj0tAhRTf7HbrkqiKuAz2gKmAXjhauCHajLSa3SsDNoMgsSs6qvl0vxe1MCCce7d6X6AF0s3EI0oj9XZQC4FtH006L+RlAsKZXy/ZFc1j9Fc+OmVN/iQ0PjSU9TAxt2BIp427ng9LlcO3LfHsaDuzVTfuEgkIofT/a5OHOXMlJ5vJd9z7o5/mFXR1XRnUliRMXKBQ2KUR2oS3yl0gZziABathCiHLKrP4g7rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqILWHNWimDbelPRLXr5JBm1tIlZbuQ4uizK+YduLMw=;
 b=kUeN0op6ihKzkzTUpNHbEps5j/DwUr5LqDWtWt1FB5ShiwFnUkjYG0yMQO5jOEnx5utYXxdU/8SE0RP1jQQmf7ugjpkxpHsrT+8rDIHLiuiFmOFeZNI13VwI+t4w67dvRLqMgR9W3jfrntOUdIlPSK0GDoI/HCu+cOsRqltz2xA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 07:23:58 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%2]) with mapi id 15.20.7918.019; Fri, 6 Sep 2024
 07:23:58 +0000
Message-ID: <59918a1c-5ebd-4255-ec5a-4d7a08b8cda2@amd.com>
Date: Fri, 6 Sep 2024 08:23:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 0/3] cxl: Pull out mailbox bits to be independent of
 cxl_dev_state
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: alejandro.lucero-palau@amd.com, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, fan.ni@samsung.com
References: <20240905223711.1990186-1-dave.jiang@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240905223711.1990186-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0035.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::11) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df664fb-1fcd-4f92-e213-08dcce44df25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2hJZXdJcWlpaWYxTmlEOE1vSld4NmNvUHM4cG05SWlvYTNySUJGN3phYW90?=
 =?utf-8?B?bklGVld3ZWozR3VDY3BzZDBUY1dxa1ptQ291b3dxS3RESFBPVXloVmt4MGd5?=
 =?utf-8?B?V2kxdVRGOWpFck1hVWFwTUNZMUJ6dnFHMlRwbjkyOWhIOWcvalRGcElIS1gv?=
 =?utf-8?B?b1VZOTY0UmtOOUhqditDRU91dm9NZWdyRmpoWXB1dkd5aXIxdnd5dmpPNHJO?=
 =?utf-8?B?OWV3V04rdFU3QVhpVDEvK1ZGdUYvT1NoK3UybXp4Z3FybUQxTUlNWThiUkht?=
 =?utf-8?B?Mk1qamNhM2I3WGVpd0dDY2U0QnlTYkdrY29PWjExZEZkNGI3NGRSSHU2Q3VB?=
 =?utf-8?B?NGtGMFlXS0dBUW03RmpVd2IyQVNBY0FFR0xodW1YcUp0amlxTWFiUlNLMHV5?=
 =?utf-8?B?TXhjb1RqMVB1OEUra1U5elJFUVRMVmUyYU1aNEU1Z1BZUExEVnNWc0RONUFi?=
 =?utf-8?B?NERHU2pQZ2Vvd05hY0tvYkFmWHk0M1RyUlZIWkhPaWN1VnpUaUZjSVJoemZm?=
 =?utf-8?B?WmlmZXNjMkJVbEZhWFBUeFZwb3VTSUZBY0JBTXNHMk5SaTJPOTRhLzI0bFVo?=
 =?utf-8?B?VDBJempBUWNqUnR6c3U2VVlXZ0t5RDhoakVpR1FteTU5WlJscUI4TmpJdlpH?=
 =?utf-8?B?bDdHUEszNEFwdzZvRVdiLzhMU3JjTWRrMk5nNmtDZmNhSTd0cHF3WFAzWGIy?=
 =?utf-8?B?TGNxU1RGdWV1UFFVQVcrbzlSVDNhZEFPOEJGak1BOXhIUytQaTh4Unl1SnNB?=
 =?utf-8?B?L1g2dUF3VXdpTXE3aWhWcmdrUmJ2aFJHelJ4WGh5QW0xTUVqZkZ0VXlmcUxw?=
 =?utf-8?B?SDdaVnhTZDdtVDVwYSs3cVdkT09FdWVzSE03dkEwTTQ3OUZ6NlN0MFRINXRt?=
 =?utf-8?B?d0QrM0UwbzFPNnBLcGVjb0JSb001Q1ZJSjVNOHFjdVdCMXVQYVp3bGZsdzB2?=
 =?utf-8?B?alA1d01ZS3RPdmc4UFUyWnNETHVKQzRaaGRZUjdqQkQvRm9kRGxSODR3MGhG?=
 =?utf-8?B?Y2hqcU9ITEdZdCt2amJrNUhyeldyNHpMaUJSNytkR3ZPVVRVdkd1QWd3TEd6?=
 =?utf-8?B?VEp3Si94NGF1eW9Qd1ZXVlNOeWgwYU85QU1YWk1hRG5MOEZuU0FMUHdUSzdX?=
 =?utf-8?B?TFVmRWFld0NPRndEcnBtWU1sVUlrMVNIcEtVRzNhNDgrOFFGc3JwVTBEaG00?=
 =?utf-8?B?bmsvUGQ0ektYaWRDcTAzSVlDUEkxTmswZkQrUStVTitBYWhvR1pLWUpVSy82?=
 =?utf-8?B?RCt4dk0yVHhQSVFUU0VoNys2TTZMZWJVdE1uMGMyOWEvbnVYcUFPeEVXL2JD?=
 =?utf-8?B?ZzFDRjNXeEc2VEw1b3RVdGRnQ1JGNVQyOGlPTWpGY1Q0cFJCVGhZMExOZUZu?=
 =?utf-8?B?eFN2M1JkRWFlUlBXYnNjeDNuUFVxMy9FdmRWbFB4eS9kSThIUXlnMnpBZnh3?=
 =?utf-8?B?OVJEVzA2N1pFTVN2dXhQamNiajB4NGhya2NHQU1sOEdBbUpqWktDeklDSnlN?=
 =?utf-8?B?aU9nT2p2Nk5Zb3BOcktBYUNlVnJRN0ZFMmRpRFd1U1BEUkJKMU5jdVdvUEsr?=
 =?utf-8?B?Z2o0ZnJ4UTRUWlBkOEVXSzhxcjV2VjZ4c3U4WlRCMk45QXR3dmQyUVIvOS9H?=
 =?utf-8?B?UmFtUVo1ZkhNU0d2UjhyMWt6TlNtV2J4Ty9LMkthUjRSOHVHY1g2Y3FUY2xD?=
 =?utf-8?B?NXFEQWN6TDNZMG9wYTBJajY4bisvMkE1ZTVmelVwQUNvWFdBR3BCOS9KN1VW?=
 =?utf-8?B?Ny9tU2hEOXhVNmptMzFSNEFxTGp3bFI0aE5naWtHNEk4SndpbjdTNUp6TnlN?=
 =?utf-8?B?L05mcDU3Q3JVd3UzQnluQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHlweFM5RWl5Njk1QXJUYmE1bFQxV3FRRFRDTjhwbCt2aHFxY0xVTC9zN1BX?=
 =?utf-8?B?VW5mRzNBcmg1YjhReUJzNXVqSjAxMlM2YUVsSnh6enY3aC82dUxyK2MrQkcy?=
 =?utf-8?B?aTRpSTd5MDZjTWNZVm9CaGFNMDBuMXhUU0hQL0NHMjdWMjBxSlZpVG1za0tu?=
 =?utf-8?B?cy9WVnR2bHB1eEdFa0RHVk0zRjI4SXpqRGVUb0QyTFRRQ20vOVVWN3JqY01i?=
 =?utf-8?B?NDNnbFBsYkxpNnNpK3hCMDkvenM1WHRKQVhNRFNpS0RLMDhoNXYzeEF2cFNK?=
 =?utf-8?B?OXlwNFExOEpxclhEbFJUQzMyTm0ydmRNYkluL2JKN05GOXljZFFyWm5PYk1v?=
 =?utf-8?B?S3BRdkdGM3BZMmt3K1k3NHRUUkRZUVdhVlVLZEdpUFZDZzZwa3hteWx6TU1k?=
 =?utf-8?B?UjJOeUNTd2NFbXhtM04wYlRIYTR2UXZtMHBrQWlaUjh4THNyRS9wbmJpOTFt?=
 =?utf-8?B?QnovKzljSGNTbHZZd3VlWk5FMkwwN282VzFjM2hiQ0tNQW5PVURETEVoaVlO?=
 =?utf-8?B?WWJKNmNsbWEyUlh3TWN1eHFTdlZYUGhiRWZ3cjVUdjk2bWFMb3RQRkZ3dlk0?=
 =?utf-8?B?bU9xbzlMUlgwTVo1ejRpUWVlV3V0SmhYM0JzZVFCOEcwdysrR0dsWGFBcE5s?=
 =?utf-8?B?RE1CcVRwZ0laYmJBQm9wWkEwSy91REVGZVZJNlpheHZVZ3F0NFoxSVpKbkRp?=
 =?utf-8?B?TXBkSmJ4ck1wcXZqNWFHencvTTAzc3RVYmpLaW1RQlVlUnhvaTI2eDNTbmNt?=
 =?utf-8?B?bVF0MEtJbUQ2T01NUmVjeXlFdXE4VmxvYUppWFVnSXhBNEhLTS9IeWQzaU1a?=
 =?utf-8?B?ZVA3WFpzYXV5ZWd3YStsc3h1R3hOY290bUVEaWEyMTNmai80cDNYZ1ZJdUMx?=
 =?utf-8?B?a1lrT1I1eDc1aGgrQWNmdVJjTms2V0tnd0JKS3J4RHBkcnBkYjhESldrSVJF?=
 =?utf-8?B?MzVKaEhuLzBsa050WDNKb2tJY0Y0ck5tbWdJdis1MVFlenpWWU5WUnExMFRp?=
 =?utf-8?B?bnQ0ZEUyRExZclJzbTJ1Vk84d05hY1E4RTgweU80NTlnR0NsUXM5WFk3eHNm?=
 =?utf-8?B?VVY4bGpvSWdnR3ZtT1JDQ0tjb0JSRzFER3M0cXRRQmF4aDVnOUhObnhJWGVP?=
 =?utf-8?B?QlRReWFkdkhOMjZwb1pzOGcxWVdmcnBHN3o3cDJXS1p6b3c1ZFNpQXA3bEdt?=
 =?utf-8?B?d01PUFNCZ3kzeFdBbjIzNG5xWVdtcGZpSmliSUcxMW5iS01lSWFpNFlEQnAx?=
 =?utf-8?B?QVR5L05PMUp0c2hySGdCRnIrd0dVMm9DNU1XTFhqRU9HcU9nTy92Uyt3TkQ0?=
 =?utf-8?B?VXlmMUlEaW91bGovbCtCNFVSYnBNNGtrNXhqQ3hpb3czbEIvVDdvVXMxdFdw?=
 =?utf-8?B?ZW4xK1JOVEw0c1d4WFhBRG55ai8vUU1xOXFOZmRKL0pSR0txMHUvYXJ4Wllq?=
 =?utf-8?B?SzBzREt1TFF1VmE0RUFKaTZXRGxtb2x3RGxsV3Z4eGxLMUlQME53VVM3OHI3?=
 =?utf-8?B?aXBscmRYeC9EeWpVRU5ndmpocysya1kza3VDOCsxbjQ3ZCtucEczTXZpT2VK?=
 =?utf-8?B?WWtNOTVzVmdDZ0c3TlFmNy9xeVgvSFIrM1loZnlzRnhlUDBDQVhtVnhsRUtV?=
 =?utf-8?B?NUZSazlFMVNpOTFxZ2owanlFM2oxTGkxTkhScTM3TTh0bjJXQWlNWDd4K1Az?=
 =?utf-8?B?cHcxUWRqQ0RYZVBhd3I5bFJsSWZxUk9HbHVOaFBURXdYbWh2Tkthc0RERml5?=
 =?utf-8?B?a2pxVEVMa1lGOHJyOGVXZDdXNXF6clhpK3RjUUFXeXh1czF0V2U5V2I1R1R1?=
 =?utf-8?B?N1o5VXArWEJZcnA0U2VQR0p4RWFvbTBxZFNoN0xnL0VOZ2EzcFlyU2R2cmhl?=
 =?utf-8?B?aGxacjhRczNIM1J1N2RxK0FIK1lsWEVBRW1CQlNoMkxOUll2d0ttUk14dGx5?=
 =?utf-8?B?b2NvcFFWZkgwZytxakdrbGU1WlFuTjlkNGxHMnFTZ3kyK3RRRzFGVS9vb1BU?=
 =?utf-8?B?KzR5K2ZITjllM0Noay9NU1FtL2hVRDQzQ2pCVkxzMVYxbEVyY1hZWG1MekRi?=
 =?utf-8?B?czJqOUd6NW0yRW5SdDJmaXZHQjNkb21TWnIzZTBEMW9jT3p1RGZVQjZBMWxQ?=
 =?utf-8?Q?YuT5qrY/EUiS/L7mqeQ4sP2nJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df664fb-1fcd-4f92-e213-08dcce44df25
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 07:23:57.9583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4NsaNPWauev6G4LcYMiz1T+qJesBo+EFof3mnhaGbMLDbc22nMLMrqB0ZU8oVq4RW5h1mvo/fhq2xLmDiOrnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698


On 9/5/24 23:35, Dave Jiang wrote:
> Hi Alejandro,
> Please feel free to pull in the patches in this series into your type2 series.
> Although I may just pull these into the 6.12 merge window to make things easier
> for you.
>
> The patches pulls out the related mailbox bits and form a 'struct cxl_mailbox'. In
> v2 Jonathan suggested that we keep cxl_mbox embedded. So I moved it back to be
> embedded. For the type2 devices that does not use mailbox, it can just not have
> the mailbox struct at all.


I've been using your v2 for my v3, so I'll adjust it to this v4. 
However, I do not think it has an impact on my work since the Type2 
support I'm adding is for our accel case which has not mailbox and 
therefore no accessor for initialising a mailbox from an accel driver is 
added. I guess that will need to wait until another accel driver 
requires it.


> v3
> - moved the other cxl headers into the linux/cxl directory.
> - Moved rcuwait.h header into mailbox.h (Alison)
>
> v4
> - Move headers to include/cxl (Dan)
> - Move header moving patch to 1/3 (Dan)
> - Fix cxl_mailbox_init input param check. (Alison)
>
> ---
>
> Dave Jiang (3):
>        cxl: move cxl headers to new linux/cxl/ directory
>        cxl: Move mailbox related bits to the same context
>        cxl: Convert cxl_internal_send_cmd() to use 'struct cxl_mailbox' as input
>
>   MAINTAINERS                                |  3 +-
>   drivers/acpi/apei/einj-cxl.c               |  2 +-
>   drivers/acpi/apei/ghes.c                   |  2 +-
>   drivers/cxl/core/mbox.c                    | 91 ++++++++++++++++++++++++++++++++------------------
>   drivers/cxl/core/memdev.c                  | 41 +++++++++++++----------
>   drivers/cxl/core/port.c                    |  2 +-
>   drivers/cxl/cxlmem.h                       | 25 ++++++--------
>   drivers/cxl/pci.c                          | 82 ++++++++++++++++++++++++++++++---------------
>   drivers/cxl/pmem.c                         | 10 ++++--
>   drivers/cxl/security.c                     | 23 +++++++------
>   include/{linux/einj-cxl.h => cxl/einj.h}   |  0
>   include/{linux/cxl-event.h => cxl/event.h} |  0
>   include/cxl/mailbox.h                      | 28 ++++++++++++++++
>   tools/testing/cxl/test/mem.c               | 44 ++++++++++++++++++------
>   14 files changed, 233 insertions(+), 120 deletions(-)
>
