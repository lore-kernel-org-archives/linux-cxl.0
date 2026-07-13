Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013045.outbound.protection.outlook.com [40.93.196.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C948031283E;
	Mon, 13 Jul 2026 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927370; cv=fail; b=KqFBAZE8I9G77/sLP+beEbmVPPCZ4XY6Hn4+n2VyDLetvym0eTTw4gl8utHfaulM5S8Z+VzF4GtfRN6UsWz+hTcqh9zKKkls3pHaBmOcYrBa0ieqTHZfLkNX6YrHrKaQV5XboQo6RsdkY6JYiBE7rabA2zc4l/DxMXXnP0iQQeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927370; c=relaxed/simple;
	bh=V8AvAktYKPJxjaLkiejRf+olXWMgiuHkVu5ogquYaho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j5ISH2NcuBDgGtqNd7HcB2fDbO+6BMs2E5IJCenIOfCI4Lt/GUP5YVlbhXtNqzASK7Suw5cUxpibjYTI/B34jy+uVJEEb9AJD6pfZUwAvy3H68MgRrol4ngMx/SvgdYMoKSnJ8s5YU5zfVNEGRHuk49vorpkM26nohzKo7D7KC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=todVY+Bs; arc=fail smtp.client-ip=40.93.196.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="todVY+Bs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNVT9Cb+SjcTubJMKUyt+PW24yonaog8vQAebL7PhC+FPCBQQb3w+lSZJo0H3QvS2YXMsD75bwbmNglexqbelV/mu4Snf62A9JbrzN4CKcD3+BaOouqNNMhY2UrjP7W54jrOUR+IVboveMoK9E5JZdETKjBspNc15NsEB+79hDZkCWhf7QpjDs6u9FKwvWR/fc2zSBbDNkZQi52M2PrY6Eodg+2rCEjWh3uymCy5Z2ZsdM6A2fHh9xOOV4DmHeo/M2NjCeYE7kNURJQIf5RftFJNdc1CcKiYbfDo2jFHDcg5jZSMgoO8IqHSguIGutnKx0h1HRrk91XBuOWGx+8kEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OhoQw+RYaBNiDe/zGw8kRCKN4aKQG2e43lG4svAjc0=;
 b=kWXvxNTETUT3iprmPEQFupqa1OEvLt1j+o0LgYBTMirtUB78ZXuntxdyxEy3p68d/PA/bt73xea+WtZ9KAe5BMxD/JfNAWnBiU2KmHkHugLbosfWPvBpM3UNuDqLeN9QWDcf1sROJ6/jpGminZ4awzGn7Tc5S8A0ma4JN+zNZaEjaW5f6vAu7MP+7shozP35GlYovcQIRNCIh6K6yMTfa/6FRuWQlQWhlQ36+owCx7lwIOCt9Ro3xutb/YChVjHTsDj4p8g0KNyw0Bus+X5ZnJACvZnMx0LE+7mT+Roy0Ej6SBqD2XO+FngJP13YzF0d4WN2GRRyxQMJG0qE9nFrRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OhoQw+RYaBNiDe/zGw8kRCKN4aKQG2e43lG4svAjc0=;
 b=todVY+BsMub8MWAiFIlXQ7LRLziin3Wr4x6Ox7hftOtNHLjFTEKRd8q1XJNAFytxAIBBaA2rmTluVsNjmAmEpBx6E1ver1IqjxWyfLoDqoL5DeNrWy4rocOBe8mUfln9yH2pgupUSd4JTnPaKUEIFm12UdtzndOinQd2xaR/Kc7srkRTYSLTLdjQya9A2qBeTNfr3lAGhD8IcgUrf+MEPMZLN7u4GWD3r6GYphoSPcUZ30gBjKnX2As0z8THS/9DGXnbGLojms6x5yBtuMs7AwrCDiNIEmuJzfovMQhIPGWsiQg6RswQ7Ex23V1yAxzfTuZHNC82l+4QNC4PaD06hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH7PR12MB6635.namprd12.prod.outlook.com (2603:10b6:510:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 07:22:39 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 07:22:39 +0000
Date: Mon, 13 Jul 2026 15:22:34 +0800
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org, 
	danwilliams@nvidia.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, kobak@nvidia.com, 
	kaihengf@nvidia.com, kees@kernel.org, newtonl@nvidia.com, kristinc@nvidia.com, 
	mochs@nvidia.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] cxl/features: Bounds-check the fwctl feature
 commands
Message-ID: <alSPej_hjBLxQwk1@MWDK4CY14F>
References: <20260626104102.53892-1-icheng@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626104102.53892-1-icheng@nvidia.com>
X-ClientProxiedBy: TPYP295CA0026.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::20) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH7PR12MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: c0350a60-f096-45f2-d40a-08dee0af8533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|3023799007|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	JaoPFYzlMAdTPwmoTp04xhIx2M6wOCcjRR2z7XpE5STaOnH036Cg/PGV9FyP5K4Ra3i+s7fHzUYoSNF85HB/vyf2fMyYTFzIm0N+ej995GQhVUe3uhD3sPEdSnDl/Vj9o2flc6chRLgtFZ+6Xh+c0vkKC5rpEthTAQ4eiFHbf87/KahKpwm7zr9qyeBH4ReCG3YwWOpnUZxIbCh9jVPJv8isA81P1mmd+vz9AZAnvKaBBG7ekPKqMLSDeVP+5rnXYC3vOZmzgVLy+jkRIVCjyumWmhVWim9wX28RXXQIWk+srfLMLuBVED/Bf+3gJAOndLjW78Fh4MNKzwRtwQiH2npxHF/PHQfocJ2RHqQ2TVaSpFMsxCCZeDJSUB3GPnicEKIbKvTk+j+wMlRb+z/xQx0QK6lF5CFMw8HJ2E8lcRypQYMP0kEOorGWoYGoIkUUo2M3NWtX1qUhyn3ifL4telHhxkiPcxk5LXvUMyP0xZVIvqs6EfF4YF0pYHHBMPZRbeH0bPI2Mdbyiw17+4rCizatHPD84EJAjV6KLsk0Zvvo/crTlZhokoLI0RqBqthNDTOplifcOqzYc2tivgS7YfhCU9HiU5yD/JdSyVNWVNnLbilJkM50AzFJYv/Q9PlxPQq0qIhF15XyN40lJA0DG4qO4lejYRYs/tyGpK7aLEY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9tA43mB6GrEii8X0aGPinHwKL/jLFqEdghIaD+KCXu1fxg0B9+MWh45wMH5B?=
 =?us-ascii?Q?rMXmjNMwKWWX1apOixVUlArkrWX62oJr09kfHsaoQqnQdO7SGgDdHWbFzLKA?=
 =?us-ascii?Q?yzjV+Ygt2zWemQjRbnPbrQ/b4RiLVidkg4BoiJKo3OMLezerFNBLMUm00iD+?=
 =?us-ascii?Q?E9leY9OMnWWkg9svI5PVzth2ZtvCr7DIU5oqN5aH9f0fHYklqqsMNg8kK9zB?=
 =?us-ascii?Q?JEJNKQddhLabEymzalJtu8KY3EetBvej01vegIGaCiohbGWnP3+43qADPgrE?=
 =?us-ascii?Q?OE0iGJAOdFkYY8FO+VCKANyJVm6fQf6eFYxDNGApIpLrSQA5wWAIvGQCUOjR?=
 =?us-ascii?Q?nCCHLpizEVIROLLT1ztOkmCI/PA4L+9s+4pK1Vfkh3JwJukWuE/luzLcTB0x?=
 =?us-ascii?Q?1EKl+vC82k5u3DQyRHHgh2XRpocHBJffsq76apyn7/aF/KxSEOmzBUcs9FmL?=
 =?us-ascii?Q?06uWUz3XfOQBTERZ2cFhtNC67ZOaTa1MjbomiwOEnl/sJHj52rKrll2ABm2h?=
 =?us-ascii?Q?eymzzDR5rofaEtEJJVuUGirWRWKz05W5Fop4HI9PDUQikCQMBNYKAC9NFsrn?=
 =?us-ascii?Q?AaT95VbUJKtruErjPKJBAenZe02E+5z7ZSnRDsf3N/WqMg4G9Tcbu0AdRLYC?=
 =?us-ascii?Q?40k5uzyKhpS3YWMx4/ELII2XI4vMh07TF2m8pMnIpJ/yvGfSGMn7KdKpnl3C?=
 =?us-ascii?Q?3y+uyPwRGp4lOkgOkD08EPlwKOGe9rYxp5Y0Kc99NSCKuajOuSDZrpJFasGX?=
 =?us-ascii?Q?P44AeTiDZCLsLkuEhFpK4BA1THgL3N3jEL7I3ewKeaZAZpiQVrnsRGrupzN4?=
 =?us-ascii?Q?u0zSsWK7oKerHkKu9VhwTGxzKLhnve3QMPckacA6OF1Zl/66viF9tpDp1DH2?=
 =?us-ascii?Q?L+ZbZGlQqqLZkIdJVsdKAC9XWmVgtMsICOTwRLcSHlFA3Xj14WTEYlRbkt/j?=
 =?us-ascii?Q?84026tYcWBsAW8QRW5VB0FNGfVj1IJBjeFFSKteWME5c+Kii6u2b5o5RbNDQ?=
 =?us-ascii?Q?zgDTsaZ0dEHj2EQAndUISMWQerDW22Xgz1NwFBjIUmA93afaLiC4faPmc4hV?=
 =?us-ascii?Q?w4mnDmXR/JEDYjxQ5KOIZSG1rir6+/vsArj/2pPFPyQtBEHWPXXOvEbGqJv2?=
 =?us-ascii?Q?Tum9HUkCB454DXOn+Gn44yP0Xm6Oap5WDrX5KnTJFIWSlzmQBiq8y2WAA82S?=
 =?us-ascii?Q?BuvFaRVh0IFq03XF+4SoZO+n7PEislECOmJ25NWs9DBFKESzmrDkuJWW4D1x?=
 =?us-ascii?Q?Sk094TgWCdFEerRA9hQEdfqJoa+By0tcbeM7ANo3zCMXbar5Du0+euEiZNSi?=
 =?us-ascii?Q?OGlgp6bFhx1U/y82HZm6cbCtGxNywCvCA7M+91L5D1MvfVxQ01v57HF+Qb0c?=
 =?us-ascii?Q?bflWRo87BtpRQGZMyhHKmRd1+FE5PvYaWJ+IC2nZ9UqoLeO64lhiXmUdp+63?=
 =?us-ascii?Q?cMYf5OM0kNTfvR9wpHFHynzLyCF7XLpBlDX0PWZi6n8HNmmfsU7x/8lQNpCc?=
 =?us-ascii?Q?NvlpRAuK4/xeCokvTwXRJihH5mwrw6rHLksq1l0i0O2pfwgh7GmlvZdFeqQh?=
 =?us-ascii?Q?DeCLnThZ8X7lNg2AQfIrQtN3wyNwx/SCA8rkxH/rE83isHeerwGoIryVLefn?=
 =?us-ascii?Q?dX+bCrlKzkSayWihnuiLbXh0TvfNZOyV2D2Wp7s7htydA7Tzjar4xo2qUlfA?=
 =?us-ascii?Q?cBvqQG7o3lim1qHCuoT7FD09TYhzTnGcQob7QI8T06gMw5E9vxdjDPw+VdiX?=
 =?us-ascii?Q?pic+7kND9Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0350a60-f096-45f2-d40a-08dee0af8533
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 07:22:39.5747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4lA71GFfLJP34LdnjokxfMQ3SQKPzeduZ6qQDSRYHlq+CAL3l/EChUNaAohGo/qOXd/J+IrYR9io6cMuuAeCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6635

On Fri, Jun 26, 2026 at 06:40:59PM +0800, Richard Cheng wrote:
> The CXL fwctl feature handlers take buffer sizes from userspace, which is
> out_len, and from the device without fully checking them. This series
> adds the missing bounds checks.
> 
> Patch 1: reject a Get Feature whose count is larger than the output
>          buffer.
> Patch 2: reject a Set Feature whose output buffer is too small for the
>          reply header. A zero out_len makes kvzalloc() return
>          ZERO_SIZE_PTR, and the header write then corrupts memory.
> Patch 3: clamp the Get Feature read loop to the room left in the output
>          buffer, so a device that returns more than requested cannot
>          write past it.
> 
> A related gap is fixed separately by Zhenhao Wan's patch [1].
> 
> Changes since v2:
>     - Expand the single Get Feature fix into a series that also covers
>       the Set Feature output buffer and the Get Feature read loop.
> 
> [1]:
> https://lore.kernel.org/all/20260620-cxl-fwctl-oob-v1-1-5758e34d784a@gmail.com/
>

Hello,

Just a gentle ping on this serie.

As https://lore.kernel.org/linux-cxl/20260620-cxl-fwctl-oob-v1-1-5758e34d784a@gmail.com/

landed , I think these are worth to be taken a look as well?

Best regards,
Richard Cheng.
 
> Richard Cheng (3):
>   cxl/features: Reject Get Feature count larger than the output buffer
>   cxl/features: Reject Set Features output buffer smaller than the
>     header
>   cxl/features: Clamp Get Feature output size to the remaining buffer
> 
>  drivers/cxl/core/features.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> 
> base-commit: ef0c9f75a19532d7675384708fc8621e10850104
> -- 
> 2.43.0
> 
