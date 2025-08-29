Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E1D7404E
	for <linux-cxl@vger.kernel.org>; Fri, 29 Aug 2025 06:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756448790; cv=fail; b=Nhhhf6xyfATntBtdl+bb9yGUhoCdKMkIvadSVbsyrKi4UnST2TqbOMjA/ZeYChtfBKDQcufIDFevLbPkogotr4pnNtQfsuk82JgdN5f150iSortm3sMA7u/r696PltLQ8XOQ3KwRx2Nq8wUNkxychBLDiawgkCmB5Z6v0/cYjWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756448790; c=relaxed/simple;
	bh=jFQ9sfzJJY9zvSVaHojfoUx/dGuWQlVZU8K/uK0S91w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GLhNO+ZXYVcnl3OVZYVZx9EmBMERt3erFGeggIsVGJdTmCbLgRslqB6h7coNyhfhgl8Z7M+k7oQXFvXktuktPJHAFSy0tJxstZfRS1lDJxpCnfq4e8gW6BxDVgh6doF3F0wpgA4GvJrvt+hgsfYpcGv8YnLcDtl0dtsqmseDh4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b9JUDnfL; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9JUDnfL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756448789; x=1787984789;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jFQ9sfzJJY9zvSVaHojfoUx/dGuWQlVZU8K/uK0S91w=;
  b=b9JUDnfLYYzoGp55SynBuwg3pYWGm1R7jrLu9tSOLcn680T9PYto6eiC
   0zC022eI26ATxc0JEWJ6xectGJP7BEPBNQnDVApaeV/HeNNN4RBGvT2LD
   3FMr5t3MShiH1qpdhT4fNjEwg8/w9F58lG123FNlxVVTez729PrPuEB1B
   HQfUXkrnrZwey/s1KvwpxMhITqGHefhkFpszO2q3HIivfliZ8+IORLivE
   5Bd65/3h/4Kd3m5kwHSup4OhYYbiKbj9ba3nn1KKx7ftnP2nOQQ8jWLYb
   b/b5QGkwSfgEVorn4R10Bu1ojfst5eWitqJWXZnzBed/xKQ7E/3G92Tqa
   A==;
X-CSE-ConnectionGUID: QTB5w9eNQ/iZ9r7Z23EPQQ==
X-CSE-MsgGUID: VDQLV7WgR2WiVEyowPbFNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="69440799"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69440799"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 23:26:28 -0700
X-CSE-ConnectionGUID: 0rCOj/alQIiG3dHne4zYQw==
X-CSE-MsgGUID: sHW6w8WiT+mYmdvfqoiN5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="169834838"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 23:26:28 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 23:26:27 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 23:26:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.52)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 23:26:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6/5413gicf+j3c6BDqHagNkaJQQN66NdITFHgC0QRgafqSkmAwohGYjmYihydqilkKLx0VJ+qHK3Stmj5IbgwAxGebvazb5eV3YbYUotpaMVTCkUvvZsn9/KJFIMSwHoVVjUf2uRGxYVL36DJmCz09WIBdqcau5YSXRjU7dw7XFxCSMysw3HaneOkvH5jKV5v2I4W0UMUPQPjbGZwh0cQoBGQ98kqCTjUyGT/isCht95ZSpscCyz4RiyHxfwaSKM48uMKz9ndN21Pie3sPsDowr6knCmX04sopzrN6NHhCioYcV2pjTX1qawu2tUpHCjSw8tPFPJlStzULXGzC4Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7StfYzrWR+UyO+L2VPpQVz+vPxJOAaPXi+DGk4Onkuc=;
 b=RVrsLWQUgvGvh/13ef8ltsuf04tFno0MOKZKO3JXTYKdn5nUt/tQU//sqzuEBWWg0dm9385OYsHQCpX9bgwZjqBd/d6Q+Y7cEzFGX35NbX2/xiskk46pKU9u59yILOe8E5/Jt16EuThO+bwIqSBWqfJYob0H0PA4IqOKcnlO7n45gFpmc9nl5VYqPM11QCuLkuUqUQdAB7fKS1ueczgpmoh0GdpG6DGb1Uo43517R2BEebMlKXsvi8PI/KdQtsCgL0IH+CK6j4hLolLWq0W0euVp1NnkC8SEYSlp9Uk2O1JrY5icVsLBfMES2pzsK0y2d6DO0UB1nHhCCLGZOu68ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM3PPFCA3BFC2BF.namprd11.prod.outlook.com (2603:10b6:f:fc00::f4c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.14; Fri, 29 Aug
 2025 06:26:20 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695%7]) with mapi id 15.20.9052.023; Fri, 29 Aug 2025
 06:26:20 +0000
Date: Thu, 28 Aug 2025 23:26:17 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/test: Add cxl_translate module for address
 translation testing
Message-ID: <aLFICbE6YX9a3ZGI@aschofie-mobl2.lan>
References: <cover.1754291501.git.alison.schofield@intel.com>
 <227f16019ae731d75a916da1a3623b30506cbe7a.1754291501.git.alison.schofield@intel.com>
 <20250808172419.00005642@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250808172419.00005642@huawei.com>
X-ClientProxiedBy: BYAPR08CA0059.namprd08.prod.outlook.com
 (2603:10b6:a03:117::36) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM3PPFCA3BFC2BF:EE_
X-MS-Office365-Filtering-Correlation-Id: f05fe4c0-6347-4c36-b34d-08dde6c4f7bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6RurrVFC1R138Rkm3x6I2DDthA3xbg6RngTPVMJgajhEO2OBRjeLTZhFeQqn?=
 =?us-ascii?Q?TZpo8HTrezPsygKsnp8hEJwOdDfJYlDa2u4s56cc9qRUG4vBC0q0axFN6765?=
 =?us-ascii?Q?zqovZ6kZlfMOYJ5/A0TF9JvjpbgZYPzIWyL3GXKKWT77m0qyOJqSlgPdwe0H?=
 =?us-ascii?Q?g9Ip4NbpBaRJqf3y2GSL90E9ks2yxnFEmYqUPuse9dP1vNzA1Im5xdL22jdI?=
 =?us-ascii?Q?H0CNtcaakZfINriF5vGqNnV8n1tRVrG5vjQshlG1PdRWX1WcGSJMG4fAMt32?=
 =?us-ascii?Q?cOhXYpDgSL/kIG+pKfaaWMgmPvfYR+lA/hzBRMYpu4UayKiefgQ8ezq9p7KO?=
 =?us-ascii?Q?dbAq62jXjFpVwsq26KDibtIeKi7laPwzKukxaUYwostsa4IzzjnwyFDDTUwN?=
 =?us-ascii?Q?WykKF9fN0AyIZrqzRbqXPI5sW1de977em+ez8+/2rlZchxbeBefghQws2Tse?=
 =?us-ascii?Q?o5w0hZv0y4d3t6jedZ+19pcgAtLxGvjGxtr0xez9Eiil5qC1kczW70Lv+gty?=
 =?us-ascii?Q?B6s8rDPx25S9T1l4UDEPQ2xPuZ8bpLfSxYIdjETdeND1CZ5Ufoto1TwU9+86?=
 =?us-ascii?Q?fVU+0gWlLUxcnaguL7Bp/GWD1Ph0rK6RpmpBONIZwG7/vpY1STKEEPJndepQ?=
 =?us-ascii?Q?eifLHnECslVeFJKArs0YDrGKzkxXnhgiJmM54YFQ29YVE8JgGcTa3qWKxPzq?=
 =?us-ascii?Q?VNBi5Tfp2EhRhD4gW6v/G1yoSHOvLatk9Wne3X4opXr5W9YXUrgVRH9o9Epw?=
 =?us-ascii?Q?YLuJrxzwA+iycxFVKMfmm9xu4PA5JXd1kXr1Z0NMqiiEOV+eYkTlfu0P6EWa?=
 =?us-ascii?Q?utl9ChjXwYEQ6CuOSDjcrchnru8rQltdvO2ONmTQH6tMKx+f4P0QHurpIN6G?=
 =?us-ascii?Q?5TDtnlOvn0NnPbG/b6Wxpwullry+xRBA88Cur9t/3bShinradOzLtivIkN99?=
 =?us-ascii?Q?kCWzFh/jPZqwPq+zr0UDzPbkyexVFe8B9I/gUbDAwqfebT8klB4chxJC7pFZ?=
 =?us-ascii?Q?GRMEKxmz4YbFLgSNfR8C4ldInRHVNx+RunAg5jMWrLr2FgmMheAKz8eoBoYK?=
 =?us-ascii?Q?jBx9FgI9AgsG2roaXAt2cPhA8toGMnXDaEN5nCmBeVM6Q++1xbGVBdORPhG4?=
 =?us-ascii?Q?Fcv4LDcAmgcJtL8i3BCAGhyaXt++BGduwIUV37QNxw6KIH6B+30iUlkSorQB?=
 =?us-ascii?Q?McJYmfRSBMrFANlJ8LAX8iutDpmVvb6HicU+tW6+kFb7nCtzbocc+kCJMO8l?=
 =?us-ascii?Q?EG7OzO5Exz//IXmHjf4ylJu+crNbnbjGYnz4oyTKQgp07C5OE7OVBq29E5YX?=
 =?us-ascii?Q?HqzG2q4YNWEXrDEpWmBABrRxkaOphCafM4bUjhHHc2sQfF9gO9EKzkGu5xfb?=
 =?us-ascii?Q?Jbl6sk2xqXNYYHa3FcIsJ7YmAfByV710qF5tLc0MdYea7tFmobs5Y4LtcpaJ?=
 =?us-ascii?Q?DCtTjVdBg0I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M32AM+U52RtFS6eZzhpK2TCw7PRVYvrZB0n1jobwebrVWux6ELt//SVBxdKW?=
 =?us-ascii?Q?sMm/8Ozet9RnzuqVi/KpKrD0wYsULuVZLzX1wZNtSUgebNi3fIPRxLCRf5+k?=
 =?us-ascii?Q?54WkbHj2bnuwtgK2suoYy+SsWiM+gXGIbOjzqJEyOGbAkWTP1FPuP1MgyonM?=
 =?us-ascii?Q?weyyLEZsVAftONTfONME/rdcHIT51CuoSIQDM9hhy522/r0vzJeKrr3bygwo?=
 =?us-ascii?Q?Y7y1xuGN7qotNxm4Xs73/jKEg7KvFyNm2ktvZ6AoWsK5tTvTKV0GJp/NTH/m?=
 =?us-ascii?Q?wY6LjlAxZBHXYVmYgF3jn8l9jdSaCUwFZ4kquNVhzt8nm91AEK3HTDGJ+SdX?=
 =?us-ascii?Q?8sTsyEmOSTHJzLzWPtCIAGL+Ky8js3+lRWoBq/ggrPgWg3ynpJOU9Dvhsgz1?=
 =?us-ascii?Q?eiUDCTazhuin6cAS2AstXDoEF6O/YfTlnapAmZftaha1vvrdfJOuvF4HQWS4?=
 =?us-ascii?Q?EzTv8fDNpD1uZRJ/Bpypq//stGMgHSRBxxYNiyehXSClo06Twkf46nt8eUdJ?=
 =?us-ascii?Q?I5ldq4cgHCl4vxVozvvBkeCQbPI0UmFMso+2mptWF+KZjf6LmrlaBypvOD2Y?=
 =?us-ascii?Q?pbGjp5S1C/edr3iM5IsxzXHrnl+/YDP97bhtiVAVVoHVWjwIRNevT9zTDQBT?=
 =?us-ascii?Q?SRzR+YKrDzmCGCcd3lPaANmzkMe4OQSYb3NGqIBD4KKSHG+wNTbl3hcXcPqh?=
 =?us-ascii?Q?tdPaRM7WtsqOYhud9iflK+2IiVruzKvOFnHmwVXDvxNK1hXqdRfQXqNvFkCo?=
 =?us-ascii?Q?/mHFauEQcKRS4unPYippQBH0OPgAj7PNAStau1NXFbKRYsgsk6UZy2pq7GW2?=
 =?us-ascii?Q?03dX6p72nxKVcMCWIo7VJsCTFGVgEa0MX4v14S6LsvULhvcOSmpg2xjHU6Qu?=
 =?us-ascii?Q?2vl5tgiJJscCDhPS4XvYbNvMAZZKBhmBwL9mlpTGPm5/kLzUP81NY06bU0FP?=
 =?us-ascii?Q?OSnyxsFp7mXUtO0CJan8/5P6sqQ+GQI8ZeV0qNeMNCcjvrlr0QO2i/eufsqV?=
 =?us-ascii?Q?DEMLkq//f5oVhG5LYdQxdjrHhFyt4RKfRYWxeGgSe87eRjRS5ngi/97RTibX?=
 =?us-ascii?Q?I73upS7uMT08klgvPcKQ6x8Y6+kIKtqe4d31Uq+SdRYEALG+ZSWiuNFZGOrQ?=
 =?us-ascii?Q?fUaiOSQDAnyIrCrd+0WJaWze4dzENArlve92s4QCW17cALWjBrDQWeoe2+qW?=
 =?us-ascii?Q?9a0b8V2CY9bo1ITBxP8B6/lVNhV4rcoPmkggTCzWwnT+wEIWniTyd06vWNA9?=
 =?us-ascii?Q?eVADXemTNP/71unOrhFTZy3jl7f37d6zCahsgdJbrGgdRU3u9wmsBM2AU52F?=
 =?us-ascii?Q?FgH8x+9FYpBaFDBdoICbYQWvbzevRr1xC5RhEazCt8bCuWMygo8Wang84V/D?=
 =?us-ascii?Q?TgI4mFpCU887EYeA9dn6Xh1O4qoQi2o2CuxPvd5ChbgmhBerq3DZHg8Ks0ip?=
 =?us-ascii?Q?R0gnx+WAO6Is/td3JYYQ0P95pOYowxA0Dh4glYtocSs7Yp8Fn6qZXEzq5ww7?=
 =?us-ascii?Q?RRE+Yn3C57ovf01ky9wZXg3fS3brctT9BCNDjOuB6Flf2HIE/uOUiT8WY0mU?=
 =?us-ascii?Q?yf0IA/rl4N0Qsd1mHcO+he1PeL3ya7Qhzxu3Q/KUM+xnC0tN2GAznCIiKvip?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f05fe4c0-6347-4c36-b34d-08dde6c4f7bb
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 06:26:20.2931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: srt2N/D1YDs333A5FMHwQoiQyGlGUXHN6y2XxPvnvZtJ3ZlVzJtEFNY+1qz/e4jQrQOZkccdaEyKreJI0W48ErA0FqC0B8UKpMyLdsFaugs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFCA3BFC2BF
X-OriginatorOrg: intel.com

On Fri, Aug 08, 2025 at 05:24:19PM +0100, Jonathan Cameron wrote:
> On Mon,  4 Aug 2025 01:52:41 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Add a loadable test module that validates CXL address translation
> > calculations using parameterized test vectors. The module tests both
> > host to device and device to host address translations for Modulo and
> > XOR interleave arithmetic.
> > 
> > Test vectors are provided as module parameters in the format:
> > "dpa pos r_eiw r_eig hb_ways math expected_spa"
> > 
> > The module performs round-trip validation:
> > 1. Translate a DPA and position to a SPA
> > 2. Verify the result matches expected SPA
> > 3. Translate that SPA back to a DPA and position
> > 4. Verify round-trip consistency
> > 
> > The module accesses the refactored translation functions through the
> > exports made available only to CXL test modules.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Nice little test.  Trivial comments inline.
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
:)

snip

> 
> Might as well make this kernel-doc even if nothing is going to
> build these docs currently.  You can probably still point
> the scripts at the file and to check docs are complete etc.

Will do for all of these and tidy'd up the format too.

> 
> > + * to_hpa - translate a DPA offset and position to HPA offset
> > + *
> > + * @dpa_offset: device physical address offset
> > + * @pos: devices position in interleave
> > + * @r_eiw: region encoded interleave ways
> > + * @r_eig: region encoded interleave granularity
> > + * @hb_ways: host bridge interleave ways
> > + * @math: interleave arithmetic (MODULO_MATH or XOR_MATH)
> > + *
> > + * Returns: host physical address offset
> > + */
> > +static u64 to_hpa(u64 dpa_offset, int pos, u8 r_eiw, u16 r_eig, u8 hb_ways,
> > +		  u8 math)

snip
