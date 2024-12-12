Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC7925948B
	for <linux-cxl@vger.kernel.org>; Thu, 12 Dec 2024 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734031870; cv=fail; b=mcHAqKUEnL8xJRdPh5H8hOzIe4gQ18L1X3C+bMB2pKm9ft0hGpgCS/nCrO4flE2horGDeHDelbfFZ3YIaQTtBJOex8E7iaB0xzWIoMRnZD/J1aHZEdW2pUzUJdYWfIFAi03kEmfGUmdnlJiC9O/B60E2ZpPrkh/rp5mMGCR9RHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734031870; c=relaxed/simple;
	bh=QnvwEvXz4XI+4QKv9yyPejQIdk5QOyCFwve+UHAAHiM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CnP3Hk54kfOyA15iyAVSwPjEn1Nm0IEnDPGANctREpri0WyC7dhdDS4Wfuu3qTp2hthcxwg2pJKeihBAk+f0rWweRn9/gEwJ44m+Xhsw+RD5gD6gb70NPsSKrZwMbpEQ9k2m+e8FZtjxrrX+degKxpd4E2HrJHjVpxvr3V5/z8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDabAluh; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDabAluh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734031868; x=1765567868;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QnvwEvXz4XI+4QKv9yyPejQIdk5QOyCFwve+UHAAHiM=;
  b=EDabAluhS34QNalc6TP3sR8OUHkTXf84tDQn5jx5XevkNeYfBrmZ5pN8
   Iqskq2J+40H+61Oa/dMqxkN38Lepk88oB8jQsPCVVtANq36jNs8cJWj7G
   Ej3eUZF6RInIqFABvI6w2WepG1qoxScUzg9hUT/f5VOxCGEL3RxIz1HH4
   bq0Zg8ldvPz7brQqMkUcyh+RA+IkSXiBA6e0lfdq6vX5IBzRbDXPtBzK4
   mDhnJtnRuo3+uFnrnRFc3OHA10qIIHTb09JcWrVPBd1tis5P8T/0RB/Ii
   Ib6x1qyZx105i1EnZJFg239p7bl6ZpwdhbuaHXIpM3HWTB2wDEZc6+IKY
   A==;
X-CSE-ConnectionGUID: RFPSyzj5RKmo5tAUuOWecw==
X-CSE-MsgGUID: 2NeutG7hT9maHB51XROJEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="38405097"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="38405097"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 11:31:05 -0800
X-CSE-ConnectionGUID: H/WUzwQRR6CbPnVkBT+PTQ==
X-CSE-MsgGUID: 2nzI90pTQlKe3l2bb09MYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="96733511"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 11:31:05 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 11:31:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 11:31:04 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 11:31:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+Jgb3odxBlOiHD1Ov6r3h5zD8PsmTSU2+Wd7DFSYF/+C2WlCeZCNvLWf/HhaNmsOZRRZmmiaevnciWP+NM6zx6DmUZ1F5l/zuXhZZKaL2WIn2Vs31GSMfC6Y4QkYXcvxASXw3WaGWPp+XbcK8gu8n07h6hxgthF1b+bIn/5uGrFQTZpV/jN3qYfZsoqw9o2/RC6X3ECtdjk2idM+bw7bbwdQe0nhsYXBX3z33oqCMlLq6e4xGz7PcmnEdgR1baEQRzDO+4bO6ib3Aj5HfQkikusueiDydrRCwtJiGv042xDWj/ONFuqFzst+qwuOibKkos0mOtAnlsWWdL0EXzGcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K29MvOe5keYZd9cMcW0RJXqhM+t/SRnCUU88W3pbNtE=;
 b=zFK0PbOBSX21Pm000frMvZAYvWkoDyyTrV6g1xCGvuc8f7ejKJsGUqzi9ZJ8cbU5G1oBXoGm143PlqTrJ96rF51cA9sX/c6UM0Y4/lFv1+N4InAg+olLczcIMkqjgBBZ8C37OR9d6g8ugxrKmDswot3L8yGF6TogMlRuFLrfOy8OLpjlwqhx3kG/Tosswff6+HGvjfFuGkhHeFpfQaNkPk1Hys1fos1Le6qchtmb+tEoXMDU5mfs47DGoDmo1xryw9k/r3FwVtApelVDZgDGBUjeN76Mf9slPoyXs99SkWeg/34ySzxeyXkq6Q/lk0R9OfUjQFjfs1qEAZbmG+AERg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5136.namprd11.prod.outlook.com (2603:10b6:a03:2d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 19:31:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 19:31:00 +0000
Date: Thu, 12 Dec 2024 11:30:57 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Zhi Wang <zhiw@nvidia.com>, <linux-cxl@vger.kernel.org>
CC: <alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>, <acurrid@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH] cxl: read MEMDEV_STATUS register iff the device has it
Message-ID: <675b39f177675_3e0fe29471@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20241212123959.68514-1-zhiw@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241212123959.68514-1-zhiw@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0115.namprd04.prod.outlook.com
 (2603:10b6:303:83::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5136:EE_
X-MS-Office365-Filtering-Correlation-Id: 25bdf3b0-86c0-4b43-a97f-08dd1ae3824d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HocMfdLSrqErZRX0ZanelesXRfvwLmKNAAkV5qcsRbOR0/4sfnpmRVACMJdH?=
 =?us-ascii?Q?di/sz+5VTOUlyRdKihk8ni+o+rOg/eM+/jO9zf8KnKRhC+nol7Up18os4fh9?=
 =?us-ascii?Q?j5zzyysz3beYEIe/sXSKW2aeE6du/N3C+uH0nXCr4rYpuQsOWneKSV5fcY3b?=
 =?us-ascii?Q?ajLYRlMe1WiYCMiiyo8eWriMtcoDb+vo8Za6IwMPsqw7mmpWn6wCfLp/Sj0h?=
 =?us-ascii?Q?cakOCzgWHfYVMKQzeKgh6vH2+Y7AY0nG2VhxA9ARw/a9r/tIik8rL4Mk+kTO?=
 =?us-ascii?Q?pP9RjD41R3EElypulu8MeUI5JSs6kcpVlmXNOU1RB+hlTOCZxzzrCKz72mvZ?=
 =?us-ascii?Q?PcKBYdFTdw/3YPFLpfHTkdi6PNiLQMC2DONPguvD143GwwUDKXddw5HZEoS5?=
 =?us-ascii?Q?HjlYWe2NBunQnKt6VQRgkG7L3Oc0H1QS827nFZFn1P/RSE6wobTWb002P2Vo?=
 =?us-ascii?Q?cwe5F+UO9dNGtC/E7W/QPM8TASjSqMwDUCFv1zpTR4rXedSVFDclKEaq8yLn?=
 =?us-ascii?Q?oKwtEPbkycoPFYhSlDaoATrBn360wlGmTrLclEKK9dkc17WYDzSwqEKeraAO?=
 =?us-ascii?Q?X+uL4yaCA9XapUgOOi4iN6U0esGbZzM2e7OoaP0XuBigsizXSqdejZokLZ9i?=
 =?us-ascii?Q?Bx4h3sl0bYRqrs57cetbJkrUcP4YsEOSIO/B/cDRTynvjXMKd6+fbhezyzoQ?=
 =?us-ascii?Q?8neJnmkTMbvTc+ogHa3O7KJoucFWTtQ5gtjZn+820CwGb4KX7RZJdzf0nBeP?=
 =?us-ascii?Q?J9KjfZdRsQT901mLgHql+aYZ0Y41PY31A8BpKSVFSoQv5JB61FD3j2Mk1kh1?=
 =?us-ascii?Q?Qp7FOvLhNByxJJgDcnQfm4y+Lu72KTYDoKXFMVZyqfnMDJpZgisK7VAcFOJ0?=
 =?us-ascii?Q?xaP/IHBfFBd5K0ywiXX9cXNp1e1VybAtP+d33tXBSu3+r35kFZEBHQXs5r4b?=
 =?us-ascii?Q?J5hk76Upcb0GWVCsDSEWF4AJT2nHRpBuOWkaXpuZnjlWTYO9CfDDHiDcVbPS?=
 =?us-ascii?Q?5r+MLC5QefPihY8/q9tgYaH2+7OTYfqEjB3luyIpFxTes06AkwidBNBlEu9G?=
 =?us-ascii?Q?SqoPMgGdrthJ7vDY3ZNIiyn52jLsxxchCJG2hioGglJbDvLGfODM9FUDr++o?=
 =?us-ascii?Q?naRTtcILeFT7lNQoxVBhUIzijjgI0CdqYqLZ2cAJ8dZjD22gTx/dk3yJYsyo?=
 =?us-ascii?Q?3lbRe4isceqamydXfRwZcW3MDLY+hdixG+l4r/1/j6FD3ES1GrjAoNRCwXfM?=
 =?us-ascii?Q?QGykzzagY5mwzvayiZVcfbfc/nGoX3cI+DfwoEVD+tRrLAzNdQo9H9CWQqu0?=
 =?us-ascii?Q?Y7PEvE0NeqmACQhORWvzK5k8iNyF1biu7cfYA2nBaf6j2A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?njvWHK8qZ7hd7Asd5MavpFVdZoY0w312sJIwEHSuuWP/y8vtI1L8nyWK3S84?=
 =?us-ascii?Q?/2kdrmXs+0oGy6GQfPKmaG6U7m8C1L0KGbgmEAva7NReqXSB+49g4ZDLnJrs?=
 =?us-ascii?Q?iLcjci1N5JVHOx+lrlO/VP4CBJ27lJHd1wPLibE6In04fs8PQPRKlhGMm6GP?=
 =?us-ascii?Q?yqFCE8iPE5oVXzrAk1VL5lK3fyVOveTJiFCInLVIBhNVfJwlFW6jEv9ai3P+?=
 =?us-ascii?Q?xF4HSQur7pNmJLWIPim/dxKsH9muIpcmQOtx2ZrXf4F2onpnoL5u3ms3a6IQ?=
 =?us-ascii?Q?rffLvPXJYUcknPaYZ0k9SInzuECaXwGZYRFUOZ7m0BrWUFEjIaEd56Paysxe?=
 =?us-ascii?Q?x3mvkdKpIaLsFVm4ZH/eYWNg+FU1uWehrZp949Ngb0uL/TGAPuCt4Wdou+xV?=
 =?us-ascii?Q?bIMYJDgc4fFjJdrXCmkeAg2FK3b3dclvUTQhYSQB2NjUhrc+M6Xnl4xUNFrV?=
 =?us-ascii?Q?FO2AaGkGwfh0PWmfp1fX2YiiGxiBhAoNntK1R2VdfJGX1I26apLjQzJ4xb7n?=
 =?us-ascii?Q?pgW1uXrbryn5rxyjegz6bhHYLPSi6Juq9DgWy2o+ttmXTMKGVWzbPmcMtkIr?=
 =?us-ascii?Q?UkEL/nv2gioyESs54SsdvlRNGD6OCLgWWtn0tOl1wfvgmVPDw+aOLrVnew01?=
 =?us-ascii?Q?MM/R3p7LmFUax6H+qGDt6FWtsUpCM15o80vqe31iq7V01qWWvxxzqt7iayb6?=
 =?us-ascii?Q?wBnRARl4XUREKlprq8VEQsiucNxTA7lblbsWf565VPiJDJ9jb5sVucMzyJma?=
 =?us-ascii?Q?GVfK5j27Vk6RsS8csGj8pxLPZi5KOR8wlR/HMu/YnVy1Mwr2MLDz56nOl0wr?=
 =?us-ascii?Q?i6SXXMPY7YM6yujCnuMC/3/2COkyMFkcI7IuMRBmlH90SAvuYPf/aHZ8KP9l?=
 =?us-ascii?Q?YC5VoqCnDBQc0zOHj0t0Qqwnn9ydLPA3olrljCIjKgOusFcDfvVE0zcoQS90?=
 =?us-ascii?Q?s6estGgiH5OwiP9WTyGg3BpOLaUzp1Me31SKMdkU+RREsp1gwd71Ccjm+JO1?=
 =?us-ascii?Q?7MYlkBS3J8BDOGs+WAmMxpmXY33293oQj1NzbQYcKQAQ5Ir86xjJp0wp106T?=
 =?us-ascii?Q?M3uTxjZeFLnrj0ATTdwqQMyyPHIVsyUTPBIhi2+ORWq2QmbnqDpsv+2I1A9M?=
 =?us-ascii?Q?DNnCR3dgnNV1gykbDhYuTDbqZRnsZ5FoYHhlbSB0oOp9QnaUuzLJJcS+dA/4?=
 =?us-ascii?Q?ibQj8ueorkZjAzyEhr3PPvth2AK2veZPCIWOj1nnD28gEw8qyHX9yezhJJMI?=
 =?us-ascii?Q?YFu10bBEFoH9eWzWvjzm/bJQyEXS22g4epx57yVk4ElOJnQ3w88bYbx2+vlV?=
 =?us-ascii?Q?uZ57tZ4Hs0XoeyJvldSI1AN/W/NRUBtB7jXFeMeWvQ4SNANa2srjeYAJGQlq?=
 =?us-ascii?Q?OrApODk2Pykd+roWEa0OKR/UEaPVy18F16WpxvH3lMadgm3Nq4b+4ThFiq+v?=
 =?us-ascii?Q?KC9D+7FosridaySFo3I1n7OcpM1BZM2fCn/BufA1hJNwBrMsT614Yq+INc47?=
 =?us-ascii?Q?twDJYyhjg38FDN7wYzrwJG6i71PsIUSlVqsGRDWZDrk+dl3eDX12bESf4vCH?=
 =?us-ascii?Q?sHW/sGJwA3ZOYMf4XWs+f4BfrgiZZY9JQA5X50KyqMOAZDfzwsHA7coAx+NQ?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bdf3b0-86c0-4b43-a97f-08dd1ae3824d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 19:31:00.4132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgatLZGAoO+IdyiQGHwkhG5wKZcRYaBFSNxo7KbZtEEhDrijxYieb2w2flseZQyCxgtkx8Km6z6ZXZcz9lo1b9b6PM9QBHSc0gW1/tc9gWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5136
X-OriginatorOrg: intel.com

Zhi Wang wrote:
> Before accessing the CXL device memory after reset/power-on, the driver
> needs to ensure the device memory media is ready.
> 
> However, not every CXL device implements the CXL memory device register
> groups. E.g. a CXL type-2 device. Thus calling cxl_await_media_ready()
> on these devcie will lead to a kernel panic. This problem was found when
> testing the emulated CXL type-2 device without a CXL memory device
> register.

Why is a type-2 driver, that should know the device's capabilities like
missing typical type-3 registers calling cxl_await_media_ready() that
has type-3 assumptions?

These feels like a band-aid for a higher level issue, no?
