Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ED728A2CE
	for <linux-cxl@vger.kernel.org>; Thu, 13 Feb 2025 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739475419; cv=fail; b=K9bOh1p5l0v73aKw+6nEeKi3vQtPQgwLsPaTeBu6jhnkbIqkgV4VbHinDZBZGUkghUxNngJSYTAKC3xq3f692+Ky557fRqeMyGWbjLZhHNCpspWYwFQl04dzRcdIvHD86BKARpUiznQbcMJGa2XBDizI4EIJHIwTNGL3uyPjZd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739475419; c=relaxed/simple;
	bh=gInhHSm4Z4viYDQ0tB3MgcO9HX2nus2HqqWU3gJzx2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qs7JReBAneCouR08efWXiCLwMbyNQMimWb7FxCb6B0F2hT0Hjb+xGJYwN8Q2LAnkSXJT0tlXJmbWOa3XsgQ4gPXbRg0mSij+wScrA1fQi4rdCOg/7wVTqkAH2NPJpV0POz7U9JsN59ztRu2NoTFfuagy9sYU9a8bcKeE3XUlY5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JJlpktvj; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JJlpktvj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjKx2F/sdDQTS71bQYEza48xQWW74Tn8jvCOMD5b1i0hXuVM8LLSl7jvcRMBv5HRAj/h33YQzkhfuJ5UjfaS0NUYmgZIpdbNatVYsJDHPtpqvltZEjozIyyHYIZeK8tlkF9KZDnzW3KHVBjqM7u6dneUZPe9Is1obqn+kIYp4S0iRcLLHDNciRqeqEMYH6PW5lSv1lypmy4qYi6lNBF8fPZ6pNKLmbggC2LFRzhYCV8UfYBw1JszoGVAAQDpKd6hT/4fIt5eriezw/B2r8YgCPX3/ZAfIzgnACqHI44joCBnYjMqHs4W1F8JKxQkOy5O/IV1j+FxOO6yzLBKAzLY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gInhHSm4Z4viYDQ0tB3MgcO9HX2nus2HqqWU3gJzx2U=;
 b=xN9nfEUFnQlAxeTPB3naAIMI8AVvHpm0LlOJvZrtqKhij7XEff4i14OMpw+xORvVn0a1XzpiNnJcSeDZfyl9F5D9gim4048X6wY2xr4ePjtkH2kyGPwtNucIsxCnbe3mx5YPqDdmEk+UyRBpvCBGsvxjt614iXoEVGQk4BasWJauIzmiRPgzrnLmr2A1JIzM4rPNThbi1fDN2Rvzjmsx0knMEZmJx5uh9lLuqTkuDMtkwJcGdzjsHPh+dojK6sDtfq+47v/fix9kQWrAc7Cg50fcR87LnraYhWOyFpSPULleWcbF1O5SrkHbyuZgfUZSiVOHLa8cLq9g6Fcdn4qV/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gInhHSm4Z4viYDQ0tB3MgcO9HX2nus2HqqWU3gJzx2U=;
 b=JJlpktvjjpNxjHGZYcO5IKLFxvvZ4VogpA+VlXSQSVqvt7fZPhzLQK8vYG5W9akoTxAx8Nbeqht+2EiaZUfNmCMSyOeBtmQrDWYlPvEQUMhIh60KTifxb/EiZfKy+wHyHG1L0p10udnLTOxI2iChcebT2FNxARdWUCbiGxMw5H5xeQZwC2CBFEz92ZMl+hJgMhYmrFBMnzsR4JymJrWqQDMIFKT5kwYRoFVmAb68N51EvohWMUUc3FCERA67J3b0pb3f/PsYwnAfWBuyy2kC8J7ct1P9KkCCiPLqCk9CDBPFV/cKskhlteSps3mGoWH/upcp+21j+vYVaCL71Piptg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 19:36:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 19:36:52 +0000
Date: Thu, 13 Feb 2025 15:36:51 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, shiju.jose@huawei.com,
	Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v5 08/15] cxl: Add support for FWCTL get driver
 information callback
Message-ID: <20250213193651.GD3886819@nvidia.com>
References: <20250211182909.1650096-1-dave.jiang@intel.com>
 <20250211182909.1650096-9-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211182909.1650096-9-dave.jiang@intel.com>
X-ClientProxiedBy: BL1PR13CA0257.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b7171d5-b9a9-4b91-2322-08dd4c65c40e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cRIc9P6FgQn2UGXizeFNw64P6JAXb0L8my0ZrnVdI1/Oe5E0ldzkXt0cHE//?=
 =?us-ascii?Q?SRaLqqHjoG/ivRCvd38Wt053GtnMxgYlGLjUibcD+hO9b7DBesotcnal+Ii0?=
 =?us-ascii?Q?vJtAnm7KofwasoMs47yLX1mJnZuaP9C07CudWZ9N4fKspgA+D0abUnue75gt?=
 =?us-ascii?Q?kcXuKRZvIZuJjmFAUzdZeoYrakTCFs2UWBG21UyBjXBpgtB0yaIkTU8jiaUw?=
 =?us-ascii?Q?z+TdQxysBXHyuRtLOr+Rqo5DzwRJnmPau/1SE9pVS+a4ZBOItxn9EbiuA2ev?=
 =?us-ascii?Q?RbfRPh42PW0mFpDmWcI6f8fUeljd/AuFb/w8LMLXL6I0mOSCNzpvEPx2Q9Xs?=
 =?us-ascii?Q?i7WjfUbPqm7XToSmtPH9zeYcJ1CEUpNfvyWqPKhUEy72Th5+3vB6t4kQyyPZ?=
 =?us-ascii?Q?BL+ZfR3k+skOuYHT8z06c+qrP/mK15cIYp1HooYlA2HmVqkbwqns4aiF5maL?=
 =?us-ascii?Q?P7jOkFUwJBFd1tqumm+mu0xjg8hH3ReBHw0ya7k/ha2nWFcQtaYnso9k/tas?=
 =?us-ascii?Q?Dvrra060RvWWyxbSauJ7x3ob8BO3tJMYo8+ad0MRbpL30ZGgzw6sIziLTUQM?=
 =?us-ascii?Q?ApYhpc63W2TDTuIyuGxDGVSkH8aC2LLtP9gjjEUJt2c3nJH11KOEWR3mW0bS?=
 =?us-ascii?Q?uyA82kbTRZMnc9ObhAePa2/7k6J2EJ1h1ZmFCJ2bCtnz3USvqJYMobX/C02Q?=
 =?us-ascii?Q?g3q0+fxd5vUCces3ocuklm0NQWefLiQtU1o0h/YPrRDgtIQPlifxAp5GvcuY?=
 =?us-ascii?Q?3qnCiJAzTzJ1MEZL4Udtzl3N2lsEAeD1LsFo1/CNVR0uIWMhR6fAXegAN0pl?=
 =?us-ascii?Q?AqbVWiOKbUaFTRYeoiKLRfaQXmHG7XFyj04NeP2S90Efuxaz948981L2f/8B?=
 =?us-ascii?Q?VHcjeBtSX6ksKO+irmtUavMLaZGExJhGUH2Iec9FmU8XKz3kank3z8n/a24d?=
 =?us-ascii?Q?0VP4iZ8yXme5N7utyI5sbm4epW2QuMc8yx9eLX7DNEceALWHVD18F/RKSvAU?=
 =?us-ascii?Q?yBQqfHDtjzUO6Vqqb8TGv6sFYMLMl7ur8mAqxPHleUheDRr46fOXx0rs7c9a?=
 =?us-ascii?Q?vq31JMTaQkul/X647C8xV08jRsVitaE+T9Lzfi+V/aRNURhbTxIF1KeDcmaf?=
 =?us-ascii?Q?Q+f6o6b7u/9aTzfbFfDG9vX/trcWJbyZ6Aw3XgvSGoGxF680kGFHvKSdPsiv?=
 =?us-ascii?Q?WKv4EGEwKbvf4W0Gi6johv72MMxRnVEUO84ChzUsBayEN/ZgjNHjDRDVcHym?=
 =?us-ascii?Q?TfFz32BJGtWdPfm3DDZlo794yVe3IVkCEMAEpWgRJDOwkNID1/GZMDS0fdDf?=
 =?us-ascii?Q?CShg+xlSRgLjRJqHwH3b5q8C/K0qGdfcGoIySK4sGnm8yZ5eHD7n/DiM21K9?=
 =?us-ascii?Q?0LgMAt+19RGS2X0qAR+/AIco+STt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YvsAtFWg5rVzrYoh+tV9ABT8Leen0by/+qa62acfDc9gcJuvikqUj/HQ4lBX?=
 =?us-ascii?Q?fYoP20ezyd1tMXPnwDaD3uAmRX3VQ+HAZ4isL3c5wxtGOAu4y3GsF/gYJ1oQ?=
 =?us-ascii?Q?QCoDJOBlSH/FHt5b14c58EWBUMmlo7lNhpt0iFqw3fn4CQTuewVKkq0kHuD6?=
 =?us-ascii?Q?OIfnjEw9VNLd99wv7eCZSnzzu+6Gg5ol+7UGb/xapvcQYZfUQ7D7sRCK3iOv?=
 =?us-ascii?Q?6wmFXP0jGZO91r7yG5TRlLdD5aBaLG0KHdtFIz4/sulcVqVYprdjNRcmN4EO?=
 =?us-ascii?Q?+3Kv9ydclaSUYBVAFacDHbDpohmVLRl+8iS2MfgQcSCqmVjg6bqZr1Bs9hwD?=
 =?us-ascii?Q?3zvhsrepoDgj3jmgHAdY+D60LTLR/4C2BCi5iHU1MR20J9iyQmyAn9JbeYsS?=
 =?us-ascii?Q?7QSrCL6ZCPPob/ZHlkRtZe5J4OABiEFaQYjR2HzYhNvT/4wtHY7o52dohaNv?=
 =?us-ascii?Q?8h5Zf4IqaD4pR+kwu9iJzeo9vxXvYd+JdCc1AEK5/I3SI/lzxkQ0wuwlqklG?=
 =?us-ascii?Q?tB0XRAcOiTnWVlO5qoKNwKe6upbXAsO76wxuA6LvBgRC5FM1DV03t0IhWKnx?=
 =?us-ascii?Q?aOS29L6t2MO3GPH3XbS2gdtyo+WqiiCBW/eSrC/9PlLdY/WM+AYRhRohstFK?=
 =?us-ascii?Q?wwxNlG6btxoZShzeF2+eIeC2YxfbOy0HtQwF5KywBdAfm9k1BHi7OccYSXVm?=
 =?us-ascii?Q?CsIP8ze67REiU+SFxuKMv26TBoGP5JvMmRxBUroFUdHKeWxl2Bcor7XePy+U?=
 =?us-ascii?Q?1tDQShhCMURrDlvO8bWM9jYQYXLDplhM+OKlB/g7huJmU/angPgwNJZHEAyI?=
 =?us-ascii?Q?MY+H4ukbxqTuQMFpu0g6AN8fL43+YX8OdDi0cDgO7ud39D6alTdQzE7o7FR1?=
 =?us-ascii?Q?4SeMTx6YYPHCVsICcNvuRSOyvaVRwD55Fq8elJkjzB7siQ8cN7cN0igSu0Do?=
 =?us-ascii?Q?hprxzdARQ6JthXvuB8UujsxN9PPuaKxvURlHdw/i35aHDhYTXBroYDsMJwSZ?=
 =?us-ascii?Q?revepQqrVk7NeULN1zXGOsZpZ44iWJl+F4w+mhY2HKaVL3DHWMtQsKqRKt29?=
 =?us-ascii?Q?Yi0NzsMvg0sYw30Lip6Wn5ZMbuGWFiIjllprqg0Z0tMWuStn7Z6sCPSqdol8?=
 =?us-ascii?Q?rQqp+tDAoFEofiP8dBonnfd8TlhuNNCwYc6Wv75eI8ICO3YfLbZiC/rLFJXy?=
 =?us-ascii?Q?oCTMBaDTDAxvFnFmqTnosi3VrIiJoRoJ/xDat4miyum3FyDKB/TE4wdZwYAe?=
 =?us-ascii?Q?4CbTTsHaX5Dz4Z0ZVXHxySBAE/jpBAd/mRdhXg3GJNIaN1aA4BqVMqbZ/ZEH?=
 =?us-ascii?Q?nVsKGsd3+HDuKiQiTdnJG52wrl2SDFmi3S0/vHsYQm/2pPbz5uMKFRaaG95R?=
 =?us-ascii?Q?lZKylJxtUd6hQvMwqRxsNvTiPT0X6n3j0ofTYH8583V2RJE8RILtkyWH/WBz?=
 =?us-ascii?Q?0rSarcE/rZXn9nEzz40RPTv2yRry0qV3kItp1gJQbexqE0rZFoFPFv3TMDFg?=
 =?us-ascii?Q?V044GdXR16kJzl+G3HVbcpnPbwrbqk2gvQRerlE0lQZTK0uv+NnpqUEL0g7d?=
 =?us-ascii?Q?tkwZFNbNB+Vrxz70Ouzed5t5UASwGUQdg8eVLgnr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7171d5-b9a9-4b91-2322-08dd4c65c40e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 19:36:52.3153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbQxmOCA3VYAYj0RnriE6ua+2tXB7ea6B9zpbVEbMElzkozv5ENdMw2iDgfbFp+K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146

On Tue, Feb 11, 2025 at 11:28:02AM -0700, Dave Jiang wrote:
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (c) 2024, Intel Corporation

Please also go through and update the dates, 2024-2025

Jason
