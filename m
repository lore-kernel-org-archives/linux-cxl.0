Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4790C136E21
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 03:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737603592; cv=fail; b=qfkp9tLnmVd9uHWVPNyspr2on3lQmcWRcWVxrqJ90Wisb3cGfJth/n+2OQtpg//bJXZGfoV1GmOFQuvago7j0vuFvXSgj6IRQCm0JN966MWV3GFr5S3spmBkwvIR9Z2prhiva2wFhCSvJTOpctk4PFN6SO/Q0/fFg0usQNbtcyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737603592; c=relaxed/simple;
	bh=mHIZn+4emhqw1sOruMlcH4BgjyJUuy69ZuR/Md4OygM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p3YH9fmnltM859smfTtD6QyMhryhUDDx7jPOf6z0EnjjGm9Dpg/82tgGnVEPodHL6AkccI+VSnPowlnUXrkds4tLUBBAwEak+5n8yAtwg/BHgG8WmllOACqTbLiO5T+k9/W0ksvFxuvTRW+pTkk2lD/3ZheR7Z6lc7zxfsoeGlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTDwPgoS; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTDwPgoS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737603591; x=1769139591;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mHIZn+4emhqw1sOruMlcH4BgjyJUuy69ZuR/Md4OygM=;
  b=NTDwPgoSnj6KyX3jE1rakgSeaD1BnSL2naKcxv6i2+KlWe/C1fjfGo39
   4LKmF9ZYmkFbr2sv213JBkqbTg8GvC9+yxTDZp0Bz50uNuxwJICEcecrB
   yRf36enDd0mulxAMN5TAbHaxo/0vE1QZrLmtrh2pf3idV9f1m8kCZabRT
   5HG19mdXgZ8j1wnhNFZHFHrZf99X8RTRx2jQN5DHaDtvZYDPL3HCATD3Z
   CnqMiwTrfBS4/s2LwlhTfBAKOZ26spCFwkUvsciyC4DbDOyhKRKHa6GeV
   Su9XWbxKiz2mjPOnM+rlcKvtd4lypwby/5Q8HK4q9sUj8aLhdfp42ctOG
   g==;
X-CSE-ConnectionGUID: +bOuMzqhRc6jCF8NAwrHTQ==
X-CSE-MsgGUID: VYX/7vWeT6OSIffWlM7+1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="42019977"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="42019977"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 19:39:50 -0800
X-CSE-ConnectionGUID: 3Nn0M/NDSS6+AOC+gDGcZA==
X-CSE-MsgGUID: jYay/zuyRUG7Uump4xfvTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="107880826"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 19:39:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 19:39:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 19:39:49 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 19:39:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckJDvZReVTjF3PWN9BIk2PuV9bvetcD/uA5H+WqnGtZ2hHCHRtnuv6mme/aizbg2dCcWH7CQMm9VRGyNkadvhdKki+OQ1U+tE89Z6ihGp0F3FpEjhkOxzwOD6afS9Jq4o/MzdrAvrRkZ0/aS9bgym5dKDwoYf03+5VPMmIxM8kdnweh6PBiM4SO2XAy3EmjMW4NwwCLE/vRVHmqSWjLoomG91qIrQGYBaT5TMrOplKLZwFegYXxxVPnvL77bpORDflh+MTWIstfu2jqep00oOJnZvH2UELWKtqhyO3qPA3mbSUfedsev8/hMXaYImp25N4BT3tthgrPDQ73on+UI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oV9lhapK0ziWXd6ZWczGGzKk6V3Jfj2w7BgNLsS8k3U=;
 b=lrQrpE371Lyp+KLnJR5QFFH+ftVOAIBc9AdA7I/voo6BxxAhWh45x54axo9T6j1wA4+oKINbIQ+iDV+ukdAqp9tI54UfOJG7cw3pYw95W81rqk4/r/fZ1CNRJpAq8AP38vl170UgARw1NIYqR09I8ZDHkW/ZZixkMCTxt4NJIaVMWSUJ4hkpeSnuqRpbLUyZYTg15LS89091uzdRodRqiE4qJmO+1ZMhIJ1MnMyg2jiIFVY6frOK7Zb4qVyoKwGLfeJ1tIRGepVt7TpUoBzqir8rhDX/bmMjlOKGdPIW9yW3hAF1T1Qp8aKlknSUE3FwqDu04aODqfOfjr58M2XQKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB8063.namprd11.prod.outlook.com (2603:10b6:510:252::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 03:39:07 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 03:39:06 +0000
Date: Wed, 22 Jan 2025 21:39:03 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
	Ira Weiny <ira.weiny@intel.com>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 5/5] cxl: Kill enum cxl_decoder_mode
Message-ID: <6791b9d6ef917_5584029488@iweiny-mobl.notmuch>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753637863.3849855.16067432468334597297.stgit@dwillia2-xfh.jf.intel.com>
 <67912e07cc2f3_1eafc2948c@iweiny-mobl.notmuch>
 <6791781c4f082_20fa29415@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6791781c4f082_20fa29415@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0291.namprd03.prod.outlook.com
 (2603:10b6:303:b5::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a6b558-f828-43c3-ed36-08dd3b5f7d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tc6+WrSm1a5c/cJlRtvh1LedtV4QP/pg9w4nRNoqLYXDwIcY7/+KKjfuyY8E?=
 =?us-ascii?Q?CoQC1Sl9Rr3DxSN4YhGCyW1vAMTMV5q93Sd2bReCulOaAb2oZln2GnEUGdil?=
 =?us-ascii?Q?XDnctpBgpVHgyQC1M2u/PQAJyxEap6xx0JFQFMchGdUIVCZy2dralkTlVnB3?=
 =?us-ascii?Q?WjNdqvty3HL7x3kJ1NSUiw90xFuaT6lXJar/E6S55CK3pOllJU2jvYGoyw+i?=
 =?us-ascii?Q?jHUIUAaZYmEv55Du7irEybiRAUG0Pg05MGoj+reofvIiTfxzbGL/aNb6iFe5?=
 =?us-ascii?Q?LjVhGbTNko5rN+Iwu0VskHuzstwka4pzC4k5cfkeN5w71cuUDSkUJCqyF7pd?=
 =?us-ascii?Q?knkWg3tZz3EVIN5rEce2UEh5gpaAmiRroj6HYl9abETGTRYYe5/cvIwYQ6sJ?=
 =?us-ascii?Q?wyMtASnpe/eyFJl2l0YgT0Ci6qkLdn2dUJdZymWX0dXLiClBnTJBp6jjkezc?=
 =?us-ascii?Q?pedTeJa8jqJcW95ox0ForJAp2s3KsJfV+Zuy8ws45rX/a7ohiE4CWHlhUCH0?=
 =?us-ascii?Q?1vPSbnIN+fT6PbNZ9Ny1EOjPL0onjzA8WXtRmgo8jDLlv0EEWv2Ccl3HbID+?=
 =?us-ascii?Q?6snXRLkS/JrWFZcAeKWCapDiiqTLI/AlFHv3TSzQKpv1VYCc5qJXw5sfhYi4?=
 =?us-ascii?Q?hz6z/xA7ZXKAXu272F8j9c5ygUBKoppAZflVs7x03l+t8wFlc4zjiDUXvLQu?=
 =?us-ascii?Q?D25QPUt4awkYF/SF13/JJFU38pJY/e/KLKLpf5YYiDlBD9xX2AgOIdoH0Sr+?=
 =?us-ascii?Q?lO+hECpukPLPaVR/utLEBc/nxtAq9BGP51ydWbZKmUQ4MTT82hghWWv4mNU5?=
 =?us-ascii?Q?tIWvFOssH9HJ6wBdeliyaLN+8B3BXCChCwJStgCIB1XrvIoK8Uh2ezMfzxOu?=
 =?us-ascii?Q?tLZCk0FNS2Xxio40mhtDINLWCAy9a5PNadeQwhsKhBiu9ANjfG+MP6hwDReg?=
 =?us-ascii?Q?3kbxo5N1WkmF/e8QVq8QyVZQAWppNgFBP+7HCWSj0mxV4tBym6Ory3Unl6UD?=
 =?us-ascii?Q?QXzNpZL/8gp3fPK4FCuJiB8ShWZ/67Z1Tvr/14M2s+d4fsh0zrrTFJSmb23k?=
 =?us-ascii?Q?tPHfQeuyvcZ+haK6nLYc5pvv7fjCcwFJIWGjP6WEHEOdNRSVu4lWJ9AwSjC2?=
 =?us-ascii?Q?dfVN4yZ5/hqC+YAQNlrsHYbO3Ql7lhOy9Uq0az1RiQgB0S5vANqI12eqfdAU?=
 =?us-ascii?Q?NpVVLIWCQyq76np0qVpOKbax7m6TC4N3QaSbZ1qPIbptLBbmF9Lo/LkcqVeO?=
 =?us-ascii?Q?EQx+R6P0I6eoco5xhlGqCwfEBfkhw+Rl5NaXqjEQZPOnbPFu3eGB96nqjSJY?=
 =?us-ascii?Q?vC3CkJEQDRi5yWJI0zgMmVbkggYBqQRsi6dbSyOv2viMzw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GgmZlKZtbT04E60lGTyFb1Uq9pksj/M2eDKFsi80JLUVx1oWJbUYlWnKZY5H?=
 =?us-ascii?Q?M5BiAkelG6lrPQ5zyznd6E51Zj+TPKlGw0ZMCXcYnSXonJA8SnVVtOIG/vud?=
 =?us-ascii?Q?k0eZSoa6xs9qZc7EfmWfF0jJvIAeQdMAQoq9NkHTc3g6++MAnC0I84pxxFxz?=
 =?us-ascii?Q?03PRrsV12KVG0hqgXe/BfDBJBkKlHUWOZj9MLpczEko/lBe12J7ZL8LhwPx2?=
 =?us-ascii?Q?2yadtaAY8+nbaZa4q+iq9m9ayr9PhgqF5x0m+ra5fpVKruDgSvco4uRL/jsO?=
 =?us-ascii?Q?BgbGUw6FEJkq2hmP81TTFr07/zyz8gRFVQrf565gR7p3dSpryaydRYom+MQ8?=
 =?us-ascii?Q?eKUy7VGRofvAgZ1bCLPkOwwQpg576+FnmD0YpEYWkksG0hKbV08OkuZfdDKS?=
 =?us-ascii?Q?lkfO2O461dej9F6J6+sZGeLGjRD4EAmDoAsHWo+Eq76ikXGaeGbrohXURI++?=
 =?us-ascii?Q?mhSpZ+ID6YlMUvawbiPz3v30NDClgLOx8HTe8p6OMX6CRlrNiVJXoLNU/A0e?=
 =?us-ascii?Q?IxAQAoUQZanD7YD1cU53CJhjo/oys5NfzFK2i/G7UOHfDvB4j6PcTsTNB2n6?=
 =?us-ascii?Q?JzA3Csgp/tO6xSh8R9Xp24jpa3snv1g8mrIztpY5gbIfNNa105+paqiGpSG1?=
 =?us-ascii?Q?b3RAb0olOPF00+3yqOZkxAAZQgG2DdPcZInAuehXE9rVH3O/JIU8mV67O00N?=
 =?us-ascii?Q?ghMSdoIe6RirhlUYrJhuwGf01dhP0Ex67eP6FUWxuglxpXKwZI1n5HzdjZdD?=
 =?us-ascii?Q?gFK1w4vle8NRWOy6sxoGrToIwie8M6QV5ucYM7zxAt9FiRCRt9uoRNpnDmHd?=
 =?us-ascii?Q?0wNZVXbbsfcdyx9t9x/XMB5swFQh2309XN6Aiw5WjU1/OsClF0CqIc2oKac+?=
 =?us-ascii?Q?0zsNxmiErXQCAvtljH/VBm8KewsVxRtNQBgFhJitWrW2QMl9OE0MJ50dCGNn?=
 =?us-ascii?Q?ysKB/ZnvTvhcqc5Bi2sr/1bZv1eHyjbYEBU/iWFzj6yKIyPJuCrlyCQNa3vI?=
 =?us-ascii?Q?7BLJN5XmU4Iwwzb/5vV8prJF6Pv7dKOTCpUB4y8TPTw+dXBJyWESvXTzXlJ2?=
 =?us-ascii?Q?qwihDbve4Q5gtkPSui53YgF3OEqpAgIQ6MZE97b54US8xsh/A9AukYX8L8V/?=
 =?us-ascii?Q?wJXRtRQcNDkwugCglShV4Q0vN3nBULErliPjXFbJvUE/dF7v5+aE18KOdQYN?=
 =?us-ascii?Q?xBo6unb585TfdZPHgL34ShrfauInbfzKtkEh0KAiFtnMaBaKj/PvfTuwRtuO?=
 =?us-ascii?Q?el9BvVRsBauKRtiuRdHoOj8dP49J7SQh0o6xbwnj+znx4MH6anni4T5r9//i?=
 =?us-ascii?Q?yIi1RkxS1kCthMdMkAjVHrwS8CHnf9vGILUdr6KpyqOVe+blMnmClvWHx0ZY?=
 =?us-ascii?Q?d2ilbcGvKIZCli0o9Q33bWFJmjznSLjA2j2BTHg8sK/suZ0A35EoUUR7h5mN?=
 =?us-ascii?Q?3TuNDFB3HRErNDiV72Ws0sGeJTkw/AZ2zWTPkm1iO5ZcNPpCwC6oo8PwvgRL?=
 =?us-ascii?Q?k3mCABU5m5ZIt9IomhU/HsuC0eRaU1pVVLoxD92LARF7GHr54x4lNTR2QVwI?=
 =?us-ascii?Q?gCDBUWUbGwaQnUPjazpOmIqT3vqkZgBYZX1uD2Ft?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a6b558-f828-43c3-ed36-08dd3b5f7d50
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 03:39:06.8623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQkqACCApMpTYJHvfYj3dLH7iHkJWMa4ORtrnzSXOVdutn3LHEY8vRvP/1OkzusbV4jhwRUdgIb4JNgusLp9Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8063
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:
> > Dan Williams wrote:
> > > Now that the operational mode of DPA capacity (ram vs pmem... etc) is
> > > tracked in the partition, and no code paths have dependencies on the
> > > mode implying the partition index, the ambiguous 'enum cxl_decoder_mode'
> > > can be cleaned up, specifically this ambiguity on whether the operation
> > > mode implied anything about the partition order.
> > > 
> > > Endpoint decoders simply reference their assigned partition where the
> > > operational mode can be retrieved as partition mode.
> > 
> > You really seem to be defining a region mode not a partition mode.
> 
> To me it comes down to the hierarchy of building up a region.
> 
> The DPA is in a fixed operational mode regardless of whether a region is
> mapped to it. "pmem is always pmem", "ram is always ram" (modulo online
> re-partition which no device has ever built). So calling it a "partition
> mode" reflects that the partition comes first, then the endpoint decoder
> is mapped to a partition, then the region is mapped to an endpoint
> decoder. Region mode is subordinate to partition mode.

Exactly but 

@@ -535,7 +517,7 @@ struct cxl_region_params {
 struct cxl_region {
        struct device dev;
        int id;
-       enum cxl_decoder_mode mode;
+       enum cxl_partition_mode mode;
        enum cxl_decoder_type type;
        struct cxl_nvdimm_bridge *cxl_nvb;
        struct cxl_pmem_region *cxlr_pmem;

... is assigning that partition mode to the region.

> 
> > I did a lot of work to resolve this for DCD interleave in the future.
> > This included the introduction of the DC region mode.  I __think__ that
> > what you have here will work fine.
> > 
> > However, from a user ABI standpoint I'm going to have to play games with
> > having the DCD partitions in a well defined sub-array such that the user
> > can specify which DCD partition they want to use.  So the user concept of
> > decoder mode does not really go away.
> 
> This is the question, do we need to rip that "give userspace explicit
> partition control" ABI band-aid?
> 
> As I mentioned over here [1], I admit that someone might build a "ram,
> dynamic ram, shared ram" device, I remain skeptical that someone will
> build a, for example, "ram, dynamic ram, dynamic ram, shared ram"
> device. We can always make the ABI more complicated in the future, but
> the common case of "userspace need only care about mode and let the
> kernel find the partition", probably carries the implementation for the
> foreseeable future.

I've thought about this all afternoon.  I feel like this is baking in policy in
the kernel.  Wouldn't it be better to export the attributes of the partitions
to the user and have them sort it out?

> 
> [1]: http://lore.kernel.org/67915ce296030_20fa29457@dwillia2-xfh.jf.intel.com.notmuch
> 
> > In the interest of urgency I'm going to give my tag on this.  But I would
> > have preferred this called region mode.  But I can see why partition mode
> > makes sense too.
> 
> It is a fair comment that deserves to be captured in the Glossary of
> Terms entry for "partition".

eh... sure.
Ira
