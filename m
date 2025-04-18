Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F58C86250
	for <linux-cxl@vger.kernel.org>; Fri, 18 Apr 2025 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992292; cv=fail; b=L6jeTM3Tr0xDxbyIyZiyPyLekjbibcLwI8Z1PLUP+fEnzMugYkpMdC8pBpn4/JbwanWoDzevo2yMFvC00IojqSPEmYT4jlxIGN2iCE2rCRfaoQjCt2MVIY+9z3gfe9PT+OzCfmRtquu6mT2bqNxUeB2Aqac9eXXFg5KPzULBye8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992292; c=relaxed/simple;
	bh=MoFPc/ToPxj+nfZvQKGn1sH/q+vCuRsut3Dq0DwcsFE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ToIB0OOIzzw9gyf/mnS3JG1ighaIsDQrNNPK4NS3oE96Xi8Pk7na8bRGPXsbGoU0+5mHPvntvVZfPAVfaM5LJevO08TMKIbKQGkO5nkBVajW4MVmQkBTnEHhjRVen/QoGo4z/GsCsnN4QDDS7loM9X6DJeSyaqINjPG1/lq0rvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kFNI0vDv; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kFNI0vDv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744992288; x=1776528288;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MoFPc/ToPxj+nfZvQKGn1sH/q+vCuRsut3Dq0DwcsFE=;
  b=kFNI0vDvd18emTKK319hxJuEHKiJ31Sac9kD3WlQtq/ZMPQHrRGTfU0V
   c/0zYuDdPf+ECGPoVNJYEKpI7hQZZVWBdiXjyvjVvWso44l/CqeHtwdVq
   3pTZg7VrU84XldZrIOSPZY8VKSjksR4uwP+xGIZNyJFkAFkXraKx8l8xK
   /l6pqAUU98z//ZdW3ZLXQgHyUs+2kPyZtstS5pElIw+Yke0zT3sDcsbqM
   h3bG89j4mjZqLrh8M8UU9ar8KFGJ+9POIXq5Xd9SqexNMqdGji/IU4jUr
   XjzpcxGpGUC7Q+TZxH48cIM33O4P64ZZWEKt/erK7diuQdWkpIUN7kk0i
   w==;
X-CSE-ConnectionGUID: DlkxN19+TUGxu0JK+vrUVw==
X-CSE-MsgGUID: 5aewAi7ZRQGluP/JmRRvyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="46743057"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="46743057"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:04:47 -0700
X-CSE-ConnectionGUID: YIk8xgoqRz68r0fme8Qp9w==
X-CSE-MsgGUID: n8zeaNdgRGuSQigeHhIkLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="136318809"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:04:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 18 Apr 2025 09:04:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 18 Apr 2025 09:04:46 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 18 Apr 2025 09:04:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wj4lY+Zcipi8FDeuCu/U1WV4tFR1MwVgKGvmC3eCxSyL6iVvJTqANoKIT3F3kIs145MMncriTjdygXoEUnyEcz/YRH+TGNwJv9YxsHMGUI8vmBlTKfx3JX/qgM6nywZkJUq5AvTwXf82emArvgTsQyNcG+XPEtzO+sEV5HG8HWGPxwuWy9Sa+4g2TVtqHklXm61f250flY6gYSmPmuYMLyPF7vvAx+sRKb+NZq2G4i8EZXhJJl5vKN856e+88U5es1E0Ur7NP4FaL2oFwE+JyddDj02ydx3mk03S2HplkUHKYF/yqyksi4CVc4A5HLAqGWBWni/liSsHRfgPXr+AAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZoaDOvC2DmmX3yzf2fTj96fVyvzfC5lQvWw0UQpIgI=;
 b=VbC+C2dFo/udn7Av33iliPhWzA5AIH0v+KIcUX+xRekgIQs9pG57+yJ49ptG8eySGg0bP+28AUwc15uyQdKnwG0U6YdsSqI+2NSQl+Ns/GiXE3hss1AxJQF/NebZFrO5bzqIMNGjbGPAt/BgdYQr2AkFBIAOKT/l7PaMpoSe9KXzW/G90GP7itFw/tPAWl6BOu1k7fs+QEJ3aBoaFBTcc6VvladvkhcPPzgFvZm2sJ8rY3HzVQlR//ewqymVfDIEkoHs9kaSZ+35S4cR9yF7He7TsJM9v+Du/EzNj4fg3x8+Ksr1lfiAHmBknXMIPxbSFTMOY5xv0y6V7VvTJzsV/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by CH3PR11MB7276.namprd11.prod.outlook.com (2603:10b6:610:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 16:04:44 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8632.030; Fri, 18 Apr 2025
 16:04:43 +0000
Date: Fri, 18 Apr 2025 09:04:40 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl: Fix devm device for cxl_fwctl initialization
Message-ID: <aAJ4GEgVv3OI4bE5@aschofie-mobl2.lan>
References: <20250418002933.406439-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250418002933.406439-1-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:303:8f::27) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|CH3PR11MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f89d3e9-78aa-415a-8b10-08dd7e92bbc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gVFeM1O0eQMtbeJ/MUVkMo1TrQ2Q2ityO73RNimg1oXMinlx2IIKGA7y/XLn?=
 =?us-ascii?Q?PgotbkZzm4xnV/HCmlNn9vOu0z4AfHGJMka3chkt2b02PbiHOwMpHP1RBp5n?=
 =?us-ascii?Q?zIy51sebqRa/oKS9aoM0U0RABeiJEC655pn+IuAyBOiwWPwmOPKaijAs3lK3?=
 =?us-ascii?Q?OM5slYzkgNZjewfgc27/XqK3TqWVTr7yRKToRW+Q/7k+tLJHJkUzkUc0RQB4?=
 =?us-ascii?Q?TgL45AEYva9FhtzO+d8yMUBnn8iKx6FL0JdYwf+hyapfL1ivBKTQC/YN/JD0?=
 =?us-ascii?Q?W1l4pXTzjeYpXtPRI91G6b0t1XBh7pBBwV4H3ykxXne8Mqmq094ZHz+QBvMW?=
 =?us-ascii?Q?LZ+PGe0pXlOErnjGaasUUhIctjxFPloXr7s9XLfx999BWQ3MsJvw5WZbzg6E?=
 =?us-ascii?Q?hoxhl47rDuxnJvZm4MOg2bhFHiTyqs+2tk6diOg34JyQ8IDIkn2q7UwB3EUH?=
 =?us-ascii?Q?DlH+RHnQqRdzgTPJ7D6SCBXZ6T7QTJOaosJlpibWCI6JPT6YdAXWpZGoUVLB?=
 =?us-ascii?Q?/yNTm/sAS+CR/MMNJtvnTzuHuh//GkOZUcV0Om2RdNdNzvXmxVhLBBjkKAwF?=
 =?us-ascii?Q?/E5cwQS0JoMlbECd7W6xr1jpcFbDfA9wNE2XLkkhzZ1Ub9RlbsTg9KIOPQ14?=
 =?us-ascii?Q?0RmRDasFTqI6ifu1qgSCuieDuUSodSiO7eHWNSVRv3RPQ12gQXJGOKDOzhdo?=
 =?us-ascii?Q?X1izFe95tXV0ocCYEu4bnn+sKrxy9RYS8zTZt2SjlfFlyd/L9DWGH4mCTwcy?=
 =?us-ascii?Q?wzeie27wAsMVrLwIH7w9Dbq80zvQ2rr0EKqtjht6CUMo3Cw7nrwkRvUMikRW?=
 =?us-ascii?Q?7RvBUZFJHAQXqxwtfxQzTsMYHajmYUlae1tQAmJWKvwjlTPGUwSKSFtoLKn6?=
 =?us-ascii?Q?FIp1jA+bk+B0kM2wzQDs/IJ6JL37bNaChb/D2chDhf2me5U7XGNFqkhkY/dh?=
 =?us-ascii?Q?tcomedI9jd2X/CHK9Tcld+F7hRyH8TUB3X7AyA0z34K2YTHtPq4XOatIaqhy?=
 =?us-ascii?Q?sa+JMpK0+Z3taRitvfC8gTC6y0rxS9eUa1r0h42I3+Qbj/f7zYu0WOvUXwB1?=
 =?us-ascii?Q?5LawmtQwVHeO0Mq75jngF16AydP/fyu6Syc4iLfjki1Gn8iLYB7POFXf9xdX?=
 =?us-ascii?Q?6mfskHhcEpK/YreiJNduAN5EigFi9b9qA53OrpyVLHiI83gXnOLFdldqBLK1?=
 =?us-ascii?Q?5dU9nNI1kOf7rjTy393CX2ry4ZpZqyLjPLAlkbdQmI21+lz+Sg3X2FvCK0kx?=
 =?us-ascii?Q?Ry4PJMLi8BVaQjhq9lCYPgYgodo/RBoxcSATv/8xUYng8J/ZDElZ6DV2fJmo?=
 =?us-ascii?Q?fYTu5Ru9oQQyto4ku0GexibhhGLk0UAV7fBmRnzeRxKcXtT3+vCX0EEO3YbA?=
 =?us-ascii?Q?vbRSHwMEmQgh/QsAsnlY9RVtkD175Ea4vg/S/wgCTx6ZCjef7yncZ4bRelNw?=
 =?us-ascii?Q?mj6KFeKEel0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ELcnPmyWjuJDqzb4j5M1I7UDvCClxvG+OWB9eC1ZYd9u0G5LfRbNwQqEaKLE?=
 =?us-ascii?Q?P4mk5v6w2W4o6MwbkFDpm2jS+yCO87yafBa/H/TO8zoOZgK/jUNdvT1pGWJl?=
 =?us-ascii?Q?PK+Egu/DgC5HyzS5f6W1ZYnRWhEKAS23n5ygADk4oRzEBr6ESCUvcrdGlc1n?=
 =?us-ascii?Q?XJW2imYPrrj7NaZdIOOvtaUTdhA/pK6qGvcdF+Op5o5Ga1CTQaehpCpFa3lG?=
 =?us-ascii?Q?w1uxTwJ8Qm/T0VbJscu7eJfU5vvNRRNWKHJ9orRHUGiN4lcvRgR5eftBQ+yd?=
 =?us-ascii?Q?Hulp614Ujefb81k1xR0H3A+jlYmSD3TrgL+/ba1pWy46K4KwnYQ+/q2qGURN?=
 =?us-ascii?Q?E0LIgAqqD3wJrOhlCQkJ/edLDwBrPg6kKJ0F+ReAggJ2u03FOMlGzTi16RXI?=
 =?us-ascii?Q?o+8oaeuJd2KLevwK0V3xn1N8RJV0ZZbjDG8BKvVSb8NAoy/TZUwZrMctWT/B?=
 =?us-ascii?Q?eZ/NCGUepnO+L+KyOI1wYRYbyHGjLmwfJzKKDUuCzhqnUKay+Qj8XKLxT8fW?=
 =?us-ascii?Q?M5SHA324LRTw+U6HM+c9YXSOVw2cCoRLAqbVjBcxbutjlomSC9D5TxVpcwww?=
 =?us-ascii?Q?EE7dW14a32ZzYzIbs9qjcX7uHF4HnKngGgJYj98MOpJ6wQPtWkqPksiA2UXh?=
 =?us-ascii?Q?K5VBtejLE4thSJT7tmel+G3cWOmTpF+bJEbDojvK7xlHT0CfxXC7pv5QEXvL?=
 =?us-ascii?Q?IQDMMaYzBWRUqraQrPEwDsYJolkLWWze4x3wvfmMEepL8pnlpD5+4WNfkLkV?=
 =?us-ascii?Q?zsit8ekiDbse1XC0XLT7O36bfKPU0P6G8w98oIN3VMvvS42tdOxWUSxheZob?=
 =?us-ascii?Q?dN+KkqqDmbMrAdr+rZYb0uJwmoZQHE2Xrf34VDnuPl7ZboJcTsgkcstGzDJl?=
 =?us-ascii?Q?XrNFmoF2fiLjA9m+WxrJskL4Y17k4XJZsc9b4ReTEsi/hfomUhDHN/yqwJaV?=
 =?us-ascii?Q?avfZNUrjLeoqalrcDj23bzkPruV1xzDnRr4hQ9L6e6mHbUE/OJecdMHFJ7Vu?=
 =?us-ascii?Q?FrCBLz8e9gL6t52+eJmxAK/rPmJBXi814aiacw3yaeEFXGYLxw0UkkLcLeeZ?=
 =?us-ascii?Q?rPhbhEO+CbuiU/QgUH0Pxw+vskBK+u9VIBW+M7NeiibTGLySioz+qgWwomBK?=
 =?us-ascii?Q?9vqnqD5kG4ZWzRoVJ9h/Gfal+Lp1xDuAkWdwi8lTPiXhVZEHCrkvZtc+a3CA?=
 =?us-ascii?Q?sGwkAuGXe/Y2WQIEImtD0Osu4YRbr2zf26MZVuTY518E95sau5MvieaQGiTY?=
 =?us-ascii?Q?/em8TnHVaz9QeJlYgJHXqd4pTvtBy7VGZoLbDBaFD+HBRjUJmB1Bm8ZvBOLr?=
 =?us-ascii?Q?WcRbdVuVv1b0hp+ba1oYsyH54u+DZo3+h+7zanFGjQqhemje2Q/5EPM8roqh?=
 =?us-ascii?Q?sZa8I8kgRMCMrnw2EmCCntFU67jK5o7P/kaTRUN0uhOQRQnIbXiU4cz+0CF6?=
 =?us-ascii?Q?iColfpgwaPouGGphlkEWi3GvA6gThvs7zPRDbarUIYLRVHcH5hns09EVtsNW?=
 =?us-ascii?Q?VxPgB+8+Cavj638SnNYNC/S5Fqrjl4Qd477nznimmoq7yCAA5IyYfCenfxGO?=
 =?us-ascii?Q?NGVu3g2qiRnkWujtqm0lz8DO6ZAgqHkeyA/O3sYq5H3lyx4TyI9XHeVIt2fd?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f89d3e9-78aa-415a-8b10-08dd7e92bbc1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:04:43.8856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U49yvbymXoBRY6pYxWZk0QohQJS/lpV2ivIQT2qlsPpAj0E6xQKjg1uJs7PMZezzCAjdBFhZaN+gdNOfqs54Ya5h8wSQLKS5ezM308dk99E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7276
X-OriginatorOrg: intel.com

On Thu, Apr 17, 2025 at 05:29:33PM -0700, Dave Jiang wrote:
> Testing revealed error message of for a CXL memdev that has Feature support:
> [   56.690430] cxl mem0: Resources present before probing
> 
> Attach the allocation of cxl_fwctl to the parent device of cxl_memdev.
> devm_add_* calls for cxl_memdev should not happen before the memdev
> probe function or outside the scope of the memdev driver.
> 
> Fixes: 858ce2f56b52 ("cxl: Add FWCTL support to CXL")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
