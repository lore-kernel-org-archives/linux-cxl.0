Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960581401C;
	Fri, 11 Apr 2025 23:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744415292; cv=fail; b=s1mCuVvg8AZrs1XkEWuc9gwcMDjuNV+sTzURCFzKjFo9wDgaABSGhY3Zu8A5KuZ6+Ai8X4jL+Sy9J6irlgIdf83UlJNNics5dCgipHvutmh9SOlgdDo2pUL41Gpsavl0pwt3GWXKtnIhgLuu/x0zkfDKCcryvy022LiKDjhVqKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744415292; c=relaxed/simple;
	bh=E8SmsVKdCn1hvsmHJaH8KuzHl4EQkD++NMM0+JPg4fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sZs9e/++KzaJaem0OGh4xdGefAkJttvZVkoFr5UUm+4tIhRFgu1tn2zVSRajTY5IWaTtnARoPCZeFvAaA4eJMhowBMTCej+COK9JFtl4X1zZYoab/3b1isFeFUaaWDKwwQib9/exy2N3fv1VOyHRM1rjtSTuSCBeZbe8UdNnjqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eUKz2pHr; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eUKz2pHr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJng9u4FQYj0vyjqgweHaK6YtCnBe91HB2jm9iaN1ESaHTXoMmrsXeNmDke8qNjO5MKK4thvbYsd1ilKTkx3meH/HVkJswMj9G7oIOrAbXBM/7lCJQw6Y8v6pqRVLFRZ9eCuxHqzQBRHhxZyagVexkZF+CDMZ32TFpeFl1gbH6zcfmwNSHG72EzwxGCS/eP+8rZJ03aZdBB3aZinuSfo+vN4b/ylKgKPUf8Xiv6N2GQAw9FjUDdFU97oL2FMszAoPi4Jf7nIttNZk4uV35JBSx7nMhKUMJCXCUhRz0RlobyYZqLuD+7ezL4/UsCqNVQ6maZFQdVfBOb+8u2FLdG9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsSvz3X5ab53L0s0QIYbs+NzQagEA7WMx9ScoLoJshk=;
 b=JQQKq7HI/U+7J+YLl0z2Elo1CQRdDdspgz3L5PTLvOqQnybrq2UTqAfohXEX4wvO/pzp0+IdKLavadimBTjfykSPqAcUT3ByKod1c6mWvsGraySy9BH5ZDYigdC45g/kx1N5YonUDTdTuELnbVv4YrrvZ0KSNejxwhziWVGGF7JmGzNLzCw/gftq6DGLS2bRTl8iRdf80bNk0xR5S4Y6sXrySyxsed4acAlkh5B/fztkD73bc4prOIpz9T8mpLd/h4QnvKZnT+GS37vQX6WHAiD27c4bLbowAEkTDrgqGRr3e98q6NWZhr8E+uYd9xJT+9BXyaPz9k0QfLXrjVguYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsSvz3X5ab53L0s0QIYbs+NzQagEA7WMx9ScoLoJshk=;
 b=eUKz2pHrrTSYpkXmzkkDmsGj0odOzpDi+qfYnhJuowq44Yeh8BsGh1judRACFJhd0uThZ/9eVBSgjGuI7kFMKr3JAkG+zUOOScaaxSsoAjUVWkELP8KOX9WQw6TIOzwR5PTUQUkaO2Wz03HQXm/w6hpM684FtZ/IiEKIwnRBKnTI2E9ffohlcGzCe9GSQzqFip0I75BtT8AbTuKbqT1wrh827J8EOOMh/C6rkujIje2/Z98wl7YsF6nbeWJDgq7DXTig0KSLDtsVt5DTPZm3HGQcB31o2+0OwKpU924E+3E1Oax4H3uUUvYlCJ9fZYk2jclo2cQRdJPsCOnQTTKZ3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.27; Fri, 11 Apr 2025 23:48:07 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Fri, 11 Apr 2025
 23:48:07 +0000
Date: Fri, 11 Apr 2025 20:48:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
	dave.jiang@intel.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3] fwctl/cxl: Fix uuid_t usage in uapi
Message-ID: <20250411234806.GD252886@nvidia.com>
References: <174430820360.604341.2116516906072729788.stgit@dwillia2-xfh.jf.intel.com>
 <174430961702.617339.13963021112051029933.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <174430961702.617339.13963021112051029933.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BLAP220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e5222d-1870-4860-f432-08dd79534f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDhzd1Uyd3hEVWpzRXAvN3hPdVg3b0pMdFZrT1Iwb2VhV1o2bXh1d1VjY2xR?=
 =?utf-8?B?YlBvVTB2UXZGUHVkelhZY3c4WWlncWRqQlgrMG5oVmdrVHJ6T25YenZEckFw?=
 =?utf-8?B?UWtORzZFNW93WHB4QW1YMTZvMUo2Q1VPYmdJeEVmN1hiY1RCbEM2d24xSEpT?=
 =?utf-8?B?QVpLN212bm1pTitIbFNJcmhKQ3ViL05SYVpleG5tcVBBSElEdUdGOFhEVy90?=
 =?utf-8?B?OFNmTXRGTEk1U283c0VnRG0yOUlEWmJMd2RxQ2NhL1BVb1NkK2MrZzdHN09j?=
 =?utf-8?B?dDJEZmxuRFNBcFlSWTd0QTZKTHdwL1ZhSVFHeG5nb1RVNzhHK1ArSlFmUTJM?=
 =?utf-8?B?SUJiclVrSGdFZWpvbGlaV2JQWXVZN0I3S3RCYVBPMUhpVVdCOFJ1UWkyZ3Za?=
 =?utf-8?B?K3RsNXA2dmZENG1ZSkFmTHNLdmxyUkxKKzZCai9EWERkUDRTTmdDejBCdkFR?=
 =?utf-8?B?TDcwVWVIZHV5Q3BoMTRXMk5vZmhMOHM2Z0UvUk14MUlzZ1h5Z2JRbU93dW1n?=
 =?utf-8?B?bjQ3a1NiVlBaOUpmTGl0dktMby9LK2N6SmFGaksyclF0amdrZTVWK3A0NzBY?=
 =?utf-8?B?RzZkK2RNM1JhSFdQcU5xRDFad3RlZFBBdlEraGRXUHdYZXEzdFR2MzVrcm5N?=
 =?utf-8?B?YW9JUTg3R1ZFd2dQajd4NElKR3ZpTmJJQmcyOHlPbGFZcUdjdEM5TlltRGRD?=
 =?utf-8?B?b251Z204MDdBMDRIQnZYd0tWdDE4M0VhWXhicFZHbTV1M3RmV2h3aDFwY1Fs?=
 =?utf-8?B?Ym04TEkvRFl3cDdjZXJLM1NxQllBanRzdHZzZ1k1MW0xYXhhUGtWVm90WlVE?=
 =?utf-8?B?ZkNQNnFXelg3d1NWM2gxam5DdVBlTnVMUjdOTHR3QlRnWGRsT1F2TFBrTWxC?=
 =?utf-8?B?NmhmM1BtbElHQlVPOTAvb3E1ZmpiS2NmSlF1RHg5ZUcrWFZWdEo5RWJsNUVa?=
 =?utf-8?B?RGxWSFRZSUFISy9hVm0xaG53aDgycFpEVHV5cE56S09NaDdFR0RaZUxMRG5y?=
 =?utf-8?B?Z0hoMElYdThzZC9BYzRPSWpidXJYVW92T0RlYVoxQTRrN1RaMzAyNjMycE9h?=
 =?utf-8?B?enQrY3B6YU1pSmJVdFExaEJsYjNWS05Vc0ROKzFJMThpVkZkSStmUmlNUlRF?=
 =?utf-8?B?VXRvMTJlOEgyQW5QQ2p4Ukd6RjF3TStxaW9zNmYrU3h0WjV2alVmbWxvK1I2?=
 =?utf-8?B?dWNwUVdPaW1OM2FDQ21udXNJcUFqS3FuZzVjVVpWM2xrT2xxc1p0UWxGZzlp?=
 =?utf-8?B?L2xTeUoyNFNabVN3cVNnNHNYRXFhck1TL1V6Y1RROEN2Ni9TZXY3bVhhZHdD?=
 =?utf-8?B?aEtRZDljbVM0TUF4d0hodytMd2RwVmFPSjhpMVpqdmh6MldBcVJwZmdSK0xQ?=
 =?utf-8?B?M0dTUDZscXQwMHQ4d05Sb1NyODFnQXJUR1dJS1RwcmNueXdZcTFKOStvU2w1?=
 =?utf-8?B?OUNsaXlVc0NWZWpwcjYvL1dVYlNtOHdqUW9SYlRhM1U0Q2ZSVWNIYmZjWUpm?=
 =?utf-8?B?UFI1aTF2RDF2MmxSdFBwVFVnanBJa3psVVZualVtQWRQY05qbnR6QVJGZTdk?=
 =?utf-8?B?L0V0dVVSL1VGZ1lYSW02RFdoQTZhZk1aTlBncHN4b3laVGwvaVZibUhLYXNq?=
 =?utf-8?B?T3BNVmN2Z1BLaUhLMy93WExGNktJSm1ocm8rRkQ4K3FLaEU4TWdNSG5BY1Fu?=
 =?utf-8?B?K3g5VGQzNEpEaFJpcng4aFFOZnNqU1hyY0MvL2JzdnovNlV0RWVTa0liNE5o?=
 =?utf-8?B?Z1VSOWNuQU5xUEJVZjlrbXNFeVRCb0tmZ2ZJT1dINksrZFhtMllQSXMvWEwy?=
 =?utf-8?B?TTBJcERsRkwvSzVjeWsxNTNXRnpyQlR3Qk9Lb3ZsYy9jZmxzdEQ3YlUxZlVz?=
 =?utf-8?B?TGYrTTREL0pLMy9OYnBkdEV0ak9JNk1vY0pmVmZZQVMvTGJkNkh6MUZqS2VY?=
 =?utf-8?Q?OiPtic7Ukvw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGx1ZzMvcmdPcHdieGtTd2lzVU1xT01MUndnTXFLNFhVMzVlQ0pZbk95TmFJ?=
 =?utf-8?B?R2hmSnF5Tzk5TnFmUFdpdDhZb3l6SXU3NWI5TnFLcmc1SnRIL0NlNm9nMG5W?=
 =?utf-8?B?eFpRbmVybFY0QUFJLzdhVnYvd2lMa2RXaXBRNURyeUJvQllBVmYrUGhxQUIr?=
 =?utf-8?B?dWpRK3VQWFVoSkZZMDUwUzhRbUlZb3NacnpNTHh6M3ZuMGIyZkRMRTlNMms3?=
 =?utf-8?B?ZWRvaE9Fek55cGplMTRNMDdmTjQ1VnlEN2JWT2JzZjJtZFpvNEhOb1pSOWNz?=
 =?utf-8?B?MU1OUXU5N1hqMDBqdlNLUmNKNmtjcVdTUGdpdzlNT3NCem1EZHNsRDFjbXcy?=
 =?utf-8?B?MTRUM0pNemt2OEl5L3FvTTZjdDdKb09IYjZZSjdXTHk3L3RIR0wvWVRSRzlw?=
 =?utf-8?B?YlFSKzlrcTUwQm1yLzVlaXVidkFxaG1KMlY1Z01IMjZsMDZqRFA4MFFaZk03?=
 =?utf-8?B?K0E3MTFTU21IaEFYSmJnZkI2MjNkU0MyWVEwNlVEUFlveWZaYkJDWTBpd0xr?=
 =?utf-8?B?MFVxdEdXRFlrbVp1aVZWak1Ic0U1Z3lQbEt5MnhRcU9RVmNkYmkxL3E0dEhw?=
 =?utf-8?B?VG5SK3RBcGRhQlZVMFpZNTk3R0Q4UDlXanRQUVhvUGJtcmJQTDRybkRDV0JO?=
 =?utf-8?B?dVJtM1d3WnJMcFg0U1RYSVZBam1CT0Q5WXZPSnk1d1hEQVM2NGxUV3VPSHAw?=
 =?utf-8?B?ZXNWQzdoaUVENnA4QXlxYTZtemN4VENlSDMzcG5JZ2NKalVkQktZTGM0bzAx?=
 =?utf-8?B?V1JVR2liQm1qaThLeHFkcFhTbFpMYkFlZ3hQS0p5dVBRN0JMd1JxQVU0UUxy?=
 =?utf-8?B?d2VOeGQ0ci9JTzR4dXM0VGlMTWtjSW1Cdi9BT2dyZTVJS0FORURDejJPTHBG?=
 =?utf-8?B?blExQUxKdG5yQURnV1IrT1pYM1hreE8wa244dUdGbkNhMnZyVnczdXdHcVVB?=
 =?utf-8?B?WGRhaEV3UXJRYmNFQjBBWEs5ZCswOUI2WEhuOWpBM3lIa0s3bHVNakNkbk81?=
 =?utf-8?B?ZTE0cHdTYW1xWHpwa3Q5ZnpoUFRVeXdJWGlsM29rNmVkb3Jlejd0b0gwY0ZT?=
 =?utf-8?B?Q1VrVWRxbFFKMTE1cVFhMWkrZWduZ1JwS0lBYWNBTTZVNm5KQzJXRlJNTDBz?=
 =?utf-8?B?aytOZDZURjhhUnRrK3ZhSndnR2o0UEN5SEpCTk1nUDRsdkNMY21ReVFaM2s4?=
 =?utf-8?B?cW9VOW9nMldVeWJibUN4Qkc1WmhubFJpNHlzcDRDZGRnZ3VHLzVMbVpzMXRy?=
 =?utf-8?B?MGkrYnlEQlVMYjkvOCtEM1FyQ3hPd3lOTlRFVStQQXZFZTAyRDJoeHBGREpz?=
 =?utf-8?B?V1ZMSE5yd05BMXBaVHI1Tk9JQ2M5czVzTDJkQTFJYlpkYXpjNGNCVTFtSzRV?=
 =?utf-8?B?czNKWDNhRHVQRnNnbzE4c080Y0NWdVp0Z0VIUnkyUVEvUXo2M2Z1UEY0Qkh5?=
 =?utf-8?B?NlNFbzZZYUJiazRiSkFGY0xzK2dxMUgvV3ZmM0I3R3hqUlAvRkRpUUVLcW9T?=
 =?utf-8?B?dkJQalNGV2Fjb0JhNExMeTQzRHF3ajBnTDBNT2Q4UHRlcldhbml3ZWkvRGs2?=
 =?utf-8?B?Y0FtaTBuNGgyVDQ1aFd5cjYxZ2hyZHd6UHkxQTlmUGJUMFFqbHBPN1BWd2xP?=
 =?utf-8?B?TDViNk15M0RxSmVPMllSTkJSOFc3RUJMVDNKS01zTDQxVlJGdXA0WVlUSEUx?=
 =?utf-8?B?d3FTZkpMY2Z4TlZMS2hYSFNIU0wrMWZRaFJIanBkbk10VVVDUlFqdHF2RTU0?=
 =?utf-8?B?TVh3Qk9FTERiMnZ5d0VCR1EwWjFkazdPR2FyeVpFdDlOTXo2eVcvTkE4a05z?=
 =?utf-8?B?dld0Ump2M0lOQ0pja3UzNm02YkFFL3F3RjZ2cTJIU2UvOC9KS2Q0WVdhVFlu?=
 =?utf-8?B?aGp4OXpkcVhWd2RvRlYvajJPeGsxaTNaQU9yNXplU0VQeTZhVllDYUVXcnV3?=
 =?utf-8?B?dUxhWk9hWE9WR1BzcUhLN1FzU1hTYnVGSXlmNW1TeW9DU0dBSE5nQXZkMG1s?=
 =?utf-8?B?K0ZPSUVBYStPM1FhL0dnYnpHM1NydUUzc3NIOUtNRmk5M3hGU0tvdDUzNi9G?=
 =?utf-8?B?RGZQWHd2Ujl1aFhMZU1rRTg5cjJwYmtRYUZKTkRkcmZOSnplMm8xT3BlTU1x?=
 =?utf-8?Q?lLkm5yM0toY9j15fc5oAfjoo7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e5222d-1870-4860-f432-08dd79534f38
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 23:48:07.7084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyKe/Sk7iWD4ggq5Y7kHoXQOQ965Mq87VPqVxOHM1fQWwCfWpxm1mhl8c4ts5CaR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389

On Thu, Apr 10, 2025 at 11:27:40AM -0700, Dan Williams wrote:
> The uuid_t type is kernel internal, and Paul reports the following build
> error when it is used in a uapi header:
> 
>     usr/include/cxl/features.h:59:9: error: unknown type name ‘uuid_t’
> 
> Create a uuid type (__uapi_uuid_t) compatible with the longstanding
> definition uuid/uuid.h for userspace builds, and use uuid_t directly for
> kernel builds.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
> Closes: http://lore.kernel.org/f6489337-67c7-48c8-b48a-58603ec15328@paulmck-laptop
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202504050434.Eb4vugh5-lkp@intel.com/
> Fixes: 9b8e73cdb141 ("cxl: Move cxl feature command structs to user header")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes since v2:
> * Drop the tinkering with __align_of__ and just document the safety
>   rules (Jason)
> 
>  include/uapi/cxl/features.h |   21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)

Applied thanks

Jason
