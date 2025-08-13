Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132711F3BAB
	for <linux-cxl@vger.kernel.org>; Wed, 13 Aug 2025 03:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755056140; cv=fail; b=jh+oqEMzHV6VwABoGSSZjCo5gfcrf4vuWXDlHr9pl3oU7dDXK93SPhDyqlwfazBti1E+Vdoc0SMyQGSofne1C5oOZvyN3wqteeQ7YI1rSizBcNXhCEQDrzXayq941jBrkrJ0MqcIwOTvRuHllwm3LzYIf1rkhgXavOMULXlzS2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755056140; c=relaxed/simple;
	bh=vrXd9X7q5cf8Skgf3gPHh0b/bg/woN7LU/eNNODciJE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DzJkwwUKBw7tVnVRZ+zTe61SOr2MrZiAaHxKlqF0tM19azjbgvmOEy2khORwi4I2oQrMQxPNC865BbJS0d9jUWWLyeJPFDcQyMoH5XC0Zzucz5l+0CWuZmtHso3oWr+2/sHA+yKW48lJRg11jYbDdv6tVYlJB3eJhdkhTR/r1rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P717u9NX; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P717u9NX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755056139; x=1786592139;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vrXd9X7q5cf8Skgf3gPHh0b/bg/woN7LU/eNNODciJE=;
  b=P717u9NX7XneNi3GMnte6nAe/oweBnuFJLDXMauYDW+cPMapl3Rtxsik
   7y13hOVWUm1DKFwkSxpg2SebuR0OemLXijnDFAve/4FwIPtXwxB7xSL+O
   VJGBIVSyQKDt0dnpjm+X03j5MzJjdymb66gTIBco+wJn01ZFAtYI1upTB
   6Ffd7oyXJPzG9vY0JhrDBobpeiCVOZYqMowZyVSA7bBFZ9fqq7NocU+VN
   wigubcEs9X3kdzNDfrW/lk/Ghd97Z0U7bnUsb+nuyGjDXvh3ToYGb+fI/
   /WYlNs4RSsrxFKJt3wDO5cGJQAzuYMo35JdWP2xnoz9nNrtQkGoBJDOJo
   g==;
X-CSE-ConnectionGUID: drb5e6RURpGW4Jy+NKn1jQ==
X-CSE-MsgGUID: I/bftXNVT+maBQZyR6CFDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68797180"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="68797180"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 20:35:36 -0700
X-CSE-ConnectionGUID: 7t0fCzdiQE+QO4kYpxZ1xA==
X-CSE-MsgGUID: 0XDc6hENSLSReDq6P0qHtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="170805268"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 20:35:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 12 Aug 2025 20:35:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 12 Aug 2025 20:35:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.45)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 20:35:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWUYw6UMLKfYKClCJLdns/F2yKHVhQxTov62LY3/0ozgG5iXgmchzLy1hj4In1p+ipn2wkLJCUyBXPV/BQgV3QhR9NqTOWUQEo74aBMEdR7PemB5+w5izM5QlZQq0L3HR3aYicxkQYVkt1CVg2ZIEKYzJAEwnk1+Hb1xqv9lGFg1hrb7Fy77jjkRpLyN2C6gJakQcFVexXrNcdgB36/WZnTmlX7yqZqy0XXkw4m4DgGCj9tpFyBK3+eMCR6WmBbjS53u8Po8F8J/uepdt56FSgopMK5WW+K7IS+uG72pq42oV12ZUaa6uEJEscvl12QWUUru/cotOkK+UJicqXiEzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u77JryyPtm1aEbWF2DlMHQxeiWy1ChLhVTuV0O569Ac=;
 b=KrLVxbD33ZufNVPPhUOGwXsnnNSui5GJoBmDgDO9eKz519jO5wVySgotfIAEELE+QRODN5DRxsVRvN80EZN3mjxgT9l3rhQ4nHsphil0oR8MCCvOts9UszLbG6qWwfGje5uhkMhzysSjIjX13CUF4UwCpmKL5UwiUDcFlyOxO+ML3b0Kv96vVkCZURqZJWS/9K3W+07rv04ygjRpfPveK+qXGG8DqxBZMlNJFLO+SjJ/CmK4F6jm6Bd9brYXegHcIZpEwnBSvTdHzTKbuk/Xu5T63uknozEwEcQ1fnWzc2EBvBF8PL+UT5gFExYNKTwD0/3ZCF+WbQnA62nDC2DHwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH3PR11MB8750.namprd11.prod.outlook.com (2603:10b6:610:1c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 03:35:34 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808%5]) with mapi id 15.20.9009.018; Wed, 13 Aug 2025
 03:35:34 +0000
Date: Tue, 12 Aug 2025 20:35:30 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Limit XOR map application based on host bridge
 ways
Message-ID: <aJwIAhGzDOPT463F@aschofie-mobl2.lan>
References: <20250804082357.2590809-1-alison.schofield@intel.com>
 <6893a593bb584_55f09100bc@dwillia2-xfh.jf.intel.com.notmuch>
 <aJO4PiyliQiJpMjO@aschofie-mobl2.lan>
 <aJv2ZYOOw3EftLGQ@aschofie-mobl2.lan>
 <689bfed7a59b7_50ce1004b@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <689bfed7a59b7_50ce1004b@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR08CA0071.namprd08.prod.outlook.com
 (2603:10b6:a03:117::48) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH3PR11MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: f8076c7e-541a-4116-0dcc-08ddda1a7614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?owgrMNO8M62rQ3i4k2Zr9roOIKpNzz+HBfObnqDGC7NoxEtcvKmM7F/DLnzb?=
 =?us-ascii?Q?y1R+aK5Vxvl2q4WJLXB1I7IXqtgJhJidQZIksK9VY/vy7vwA0zl72RfFnuCW?=
 =?us-ascii?Q?0HkYFbDyBaitJOYz2cUCCQCkmfK/f4vCusqx67lP8AhTp4/txY8kh9YOlFQN?=
 =?us-ascii?Q?Hq6xymduRB2FeMk9ey2EQ9z5Brxi5JM20ih/8ZiOhZuFnqiei5+YRB+QYh/Z?=
 =?us-ascii?Q?yJmXWsa0W2HygVQMPIQzZcHaqOmsY8wYvPbEyyK3W9jWM8eGMd247cAe+ZcL?=
 =?us-ascii?Q?ySVVisOnVL/mHNREzXPicb0fFDmmkUUHkqAAz4myVGdQkxE83csDrdlCjP1Q?=
 =?us-ascii?Q?RsZcOSb//2D/cF6jjBR71Mi8XOVfBfctdzH06HCxaPDbt9AQ7wVzK2HXhGlm?=
 =?us-ascii?Q?r2TeppD/PwE6lU+cmK6yJ4cFO8z97wnXOgy0wiRzOn5E08X3D5XjUP4WlpmV?=
 =?us-ascii?Q?VhQe+Y9pV6bnOxhj3wpatWCCW6zmWiFRP6nwUhXRvoN6V3pnoPbHf9K2ReMD?=
 =?us-ascii?Q?OCRsVFJmLlcCOvTsWRKl9WXAoD24RWfFiTM3fAWGUziXjVM14WxvA1ULPPZ4?=
 =?us-ascii?Q?HCCJLbT4+WFNB+7fcl2be9krJyPNkqlrWppQvWBF5OvQFMuajh8vlxsakxa0?=
 =?us-ascii?Q?rk3b8peqU0jYQdzf2IZ70trVuGXrfi+JpsbHGGRZI9gfaspzoaSCiCHkOCD6?=
 =?us-ascii?Q?hL11CCsdx2lHr2LHawrmmwVpw5crNQQJ+nDkf0NzDNFMD98/XTBI1DI2ehOC?=
 =?us-ascii?Q?yR12fiv8zBow6KlUPwY1PlDC/NC1PMqgu8VqUhNREpcVNaipQXmyU4jgo2CK?=
 =?us-ascii?Q?UdDTHkYsixiqW/2tnxlK18jTZZ5TSGUGCk7IfhnrcqwG86nsPiTiopMSPQ4a?=
 =?us-ascii?Q?fhM7kaBK/GXxbIV/FFaZeVBHSBGhdt0UCZsWl1ZgwBrGMZDJCxxzEMzZkdsC?=
 =?us-ascii?Q?HDgVLdRkHAF02cojnrx0l+/5ss57Hh+Fyw14Z2V7ZdUq4nGxCpp5bwQ/uNN1?=
 =?us-ascii?Q?wDG5rn83Zny0goDXzO5yKbS9WfADIZPew8l3w+HF9Wp/5+38Osg2k0JqEKzv?=
 =?us-ascii?Q?baOGhkkIsYMHoLXo9ni3Vw3xV5diGZcnIkWDlIo8H2YqV8vdmCPlDRxIQD78?=
 =?us-ascii?Q?Sic7CneVJWQOLRs4w3DBzXNJtWk/TJfXDvV1ZTNhtN40jIJWqh0GlNnwIFm2?=
 =?us-ascii?Q?08tBF8vubUcto5asD9HmH4ZnSyzNGHISGugaLY7BJOulvwcmt0xCCzwXqrKR?=
 =?us-ascii?Q?cCRO+/UY0slG1KsuLu651hIqvNm/xtokawgMle7HwfneiSljnHpoVcL5MWVA?=
 =?us-ascii?Q?WXt7lSwLLZsJNjivo52HxnvzORu4YK/3f1olppUUFJIcjx0gq+jnzgugPats?=
 =?us-ascii?Q?7V6ucocd3fxs5nupgZpSe08vc7jT8fkD9Og2Y9icgbgtUPcrnF3rlhusrx5w?=
 =?us-ascii?Q?TjLpy12OET4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ho0F/5L9PFD1xl8KFSDEYTma3lQR2YfbTMDfWJlqaWS/zk6tvzTL7iC6Ob9p?=
 =?us-ascii?Q?M5f7wreSDOPVQUVn3eYTjfOBWn6JUr2Yl8H3ATOZYIAbX6N+K/kL/iV2DX5T?=
 =?us-ascii?Q?rMoM9+GNQS859zOzSJbCVrSbmR7G2T0/FrAxRCbGthmj10oqy8ivUjkbJOPH?=
 =?us-ascii?Q?9N8jAAvUdXVe4cZtjWsFRD3LfGWEQbyoEoxYCph76dMYUNpX5fgMQgJPvSyp?=
 =?us-ascii?Q?PAoFErZfjFnB3YiGJ6gsw/PuaPsteg7JT4AEtkG8/B4RtVCukhQ+w+mCcYh4?=
 =?us-ascii?Q?E/4xOjRwVrx1mgttBdJMHIFcuzejGCHs88MAHBZe8iK8xRukqD3o0++fLjvr?=
 =?us-ascii?Q?xsnFj5rb0k5CJEgNSEXE7BuYoxpo8+CRUN16dy3E2HwNwzCfWUKXOckwxcWJ?=
 =?us-ascii?Q?8t+wMDL0UqEy3EyKEM/Eat9d4DQwkNvVqt44pPsid4SgaV/UVEEuUqRNmOAX?=
 =?us-ascii?Q?q4Y3f1uN6f1NM6ZuAkgHLjuoF0dBjh6Ddg0fQP8BCY3M3Anr2O+ZgEl35nOh?=
 =?us-ascii?Q?n8CLddSR9wAAdwXwgV1dtlhIExftXsxjIWS/YmsgQdfuk4XKu6d2nrjvKt3I?=
 =?us-ascii?Q?lXAXAMkWcIUq4AhfoeeRh2RYZcsl9M22cv+OdF9oBmQaJs3oBgqo1HI7cTAg?=
 =?us-ascii?Q?Vts2/S4oGO3KB/zyLWslO9Wvr8W3RKUHs5QmTlCLIRs8ExM/BFYOQYp3+p4L?=
 =?us-ascii?Q?j5c3Dc/cK15yHxFlWF0ZOIO/4SxZ+w46YM787UiFc8ayfmHIWLUB4aMQlUTK?=
 =?us-ascii?Q?DkuEDTklfw3jMhdTeloZtwHkZ9Ia2optR/FK86yzrQbeSbylEMma47q/9pbC?=
 =?us-ascii?Q?Zp9O7U3L5LrWqLFeNKairJpecrQ80Cw0jRHbM9HkFXpOIt5U24p6wZY1etg4?=
 =?us-ascii?Q?J94crmBuLmoR1xrAnj01Tu2M8KZmVZk0JM2gSf/F4LdEkksUSxp+Lu9YXD+M?=
 =?us-ascii?Q?BSQHx+bbRZFDAqoP8EsVPPCuwjPoVEiCgdEtmb4DFE06Od7aIwStzPLSP/if?=
 =?us-ascii?Q?leJNnpR2LRNodQC/dmGAYhqu11uf2V6jVwP8LrPpxj8T6MyPN5NID4PYPyVv?=
 =?us-ascii?Q?oEzoDYMyl6G1EjBDvnI+qbkCaeB8g+YnbefUFdLbhm7H6+dlQkB59nyRWHDJ?=
 =?us-ascii?Q?Hr8iQFRMcXkHvMfR82iXQygMedvvI8w/fWUKGExBe+lpzYu46nf8bFpOhUe7?=
 =?us-ascii?Q?Dn7ku7ASKlCYqefLwC8JbQ8+SM9GdcYXK4UmikueS+sm6UOTWNhUU/owH967?=
 =?us-ascii?Q?GIxgrECos3v+5he+rBiw8FapmFWJh9On6ZBuO4mQuRwFFBlNXDWfhtldplaf?=
 =?us-ascii?Q?yoVy+Jn0+cTbkkjFHnc1qX3Jmm3TN3Mo3ydUFQCGAVxysov0aUX3pV9DUQ1B?=
 =?us-ascii?Q?OAGeadtdHpLsiliCEPR1eEuT6XDBpwlrtOXMh9Q+SnVxykNll1NXG/VXAxxC?=
 =?us-ascii?Q?dqr7ZNo6dv/F6oPDrHOQAR1gmX6qqPsC5MpAtZKcuznWnCCKgVAfLdQsQ9yi?=
 =?us-ascii?Q?1QLsYRt06lxPJVZZfr4Dvk+wZ+TyoHkXAwtJmfJfumv+WNqO7+Qp2xsTcAsJ?=
 =?us-ascii?Q?kU5Qopp+wPh+USgdGciojt2JhcdQ+hbk7R+jBo1JUMthSP74IejiLksEDZKu?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8076c7e-541a-4116-0dcc-08ddda1a7614
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 03:35:34.3512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8P3X7ZdSueHoS/Nxd3D7bDQ8fXRJD1YTp/BNTjzspJB8WDfUv756jBQP9peUkwIXw9m5XOO8qC3l3JvM6wv3qcNdfMAAFeFmS0WMdYlT6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8750
X-OriginatorOrg: intel.com

On Tue, Aug 12, 2025 at 07:56:23PM -0700, Dan Williams wrote:
> Alison Schofield wrote:
> [..]
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 8f36ff413f5d..2784255e7811 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -1777,7 +1777,10 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
> >                                    struct cxl_switch_decoder *cxlsd,
> >                                    int nr_targets)
> >  {
> > -       if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
> > +       static unsigned long const nr_targets_valid_mask = BIT(16) | BIT(12) |
> > +               BIT(8) | BIT(6) | GENMASK(4, 1);
> > +
> > +       if (!test_bit(nr_targets, &nr_targets_valid_mask))
> >                 return -EINVAL;
> > 
> >         cxlsd->nr_targets = nr_targets;
> > 
> > So - you'll see further checking when these are refactored to support
> > the test module. The above fix to cxl_switch_decoder_init() seems needed
> > regardless of this patch or it's future refactoring.
> 
> Sounds good, and I assume this validation will be a helper shared by
> cxl_acpi and the cxl_core. Seems small enough to be a static inline in
> cxl.h.
Wasn't heading towards a common helper, but am now. Thanks!

