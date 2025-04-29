Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A30E21B18A
	for <linux-cxl@vger.kernel.org>; Tue, 29 Apr 2025 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956386; cv=fail; b=TL0DVaU2t5EuwdoJvxaIZGolS5BAIaS+n+XxahFtcJWVOlZLN5k0YpDvwOIv20CSglLfRUt/XDEohuQSbb4s39Bsdl+YyTQNkey0hKQGY5gAfJq7kVWCAVNhZ8o61G2Eix8T6D3nZh6y07ytsi+zeljwRTD69YGrOPbYSedj7Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956386; c=relaxed/simple;
	bh=YdG9IDqoswR6S5ehEPuBtKLvkvA+hLSLdYfrs8C5UX0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gNgDjHHyc5nGO9vfkgZ+8l90q5kXlxPYMv/50Kh7oQZ9s9a4BWqIucKKsk3Ma1lD2uzc2tLq55jsuDgt0+rXO4KxRYncf3YWQRKXjjQVxqVzpbW4uFbgR6jUFYRtgZMMDybMZxO1Y65Ex+CD5fG1osa1a6Mvx1OUWQvkIeplu/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqsu5hFm; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqsu5hFm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745956386; x=1777492386;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YdG9IDqoswR6S5ehEPuBtKLvkvA+hLSLdYfrs8C5UX0=;
  b=hqsu5hFmx2KCEwc4y3yfaXexUICEblmovhJL7hvoTo0h/9Tx5PcDQKDC
   P1W0c4EqG1jpq26o4IwOwD1XzRB5WSYByuSEtF9rAJjRKXr3GvKNbUHmx
   266AwoW9Sv4KFaG8es7acBi7cSKefry9ce5Azu3SVnHqa4MtkM6sKvBW8
   7z6cSND1jNVTjyKFlVHa/CNiEtCebE24fC+xD49eg4+umGD48bAWY7lF9
   IjY5CAcRCOm/ATjStYlVQkaMfY5OVNK31VPA6V/6Xeq8y1/ThGP3SqnBk
   GB0aJyDY1PhW2A0mPeho6dEnMqrixxJKHdAz356B/6bSyf9wcM3oBvs0f
   A==;
X-CSE-ConnectionGUID: mKXFClZfSd+t6r8mtkR+wg==
X-CSE-MsgGUID: POeTK2F8SFaJ3YVtfbfF1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="58972603"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="58972603"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:53:05 -0700
X-CSE-ConnectionGUID: LGLsGEiKS0m3zqKjQyFFuQ==
X-CSE-MsgGUID: JX0moFRYT6aM/W49w9QdrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="134871210"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:53:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 12:53:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 29 Apr 2025 12:53:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 29 Apr 2025 12:52:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAXK2pKP3XDcwds1aRM9EHoPpaonJz1uCusdIGuXRYRmtzN+tVtgPYLfJkwtKUkPgzRCjd0VZoen0DpO4KKkwf2yZBrYAoMr194WZhlc98fQgJJwgvC1MdqKaEc7WJRMfRzt9fY8I6zKB1gtwsny+oKOX3ABQQbmcu0H3rLZS4IXtj8JJROKY+PI4lqhntd50wdfxowVya5pXnG4XoqrLn4esPzOKwmsZ1ERZb10+gKFnCurQ6p2y/g8XXXQA1nLc+Aqk69ykt8FK22GYX4k3yUf8t9uNY6XRpM+45TAJDSoudQQ7Bdr6PywtYkKPNt5eQTTTUlNltbT0+d+jvfMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmGFyJR1Lrd7/JNUlPV8bighnQoKDXMQhBCqktKOCNQ=;
 b=YzkUGxbZiDr5cbzESCVbS5r6Gw0ZUdOaeg9jzBG2iCJqIzb6v/2Muty2MXqw3FZnh667TzgtDKioNN6U+M9liekmZB6lOAGAzlZ4XSGEkD9jLV6mWbBZQWru1+PxvVJbWTgjYSxnBI9yL4Mu1WMFPUZ5mNrNZkgj+8tYJpyMZtITEstGT8nMLzblZ0Dcg7IwABmuzP7YGIFeVUXP4NsiG/ZqbSMkDIzGMXtHnqdVyRkL7DpZvE6jXTMZ4vnSq4FVM40x7ytq6aNvvj/ckjqb6Da4nkGYRCejX04BfL39GrpwMIRBK+5R/tbuMdvNQstP0qaZBH+WLhjsYFNYXuhwbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4661.namprd11.prod.outlook.com (2603:10b6:208:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 19:52:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 19:52:29 +0000
Date: Tue, 29 Apr 2025 12:52:25 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <rrichter@amd.com>, <ming.li@zohomail.com>
Subject: Re: [PATCH 4/4] cxl/test: Add workaround for cxl_test for cxl_core
 calling mocked functions
Message-ID: <68112df972ef6_1d6a294d5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250404230049.3578835-1-dave.jiang@intel.com>
 <20250404230049.3578835-5-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250404230049.3578835-5-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0195.namprd04.prod.outlook.com
 (2603:10b6:303:86::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4661:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e9e7d72-a702-43d5-041a-08dd87575f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xn3tM0XrvOdFiqrhjwMA8qMyxcS0jVCpyW3DqgF3+cIqLpL68epq5Yd0Uil7?=
 =?us-ascii?Q?fw9joXGoV8VQybUj4bQ+CYNgaoJF6P0ZaTvLk3o/xcr7AVBgVMDvmXQwsga5?=
 =?us-ascii?Q?fQ3rDv61Bjz8nd3qFrwqyT2uYKrq2/obLZp6a0v5aHZ/M5W4MXl0ch8Mu875?=
 =?us-ascii?Q?jwACKLIYswoZpIR9GntFhQGFTxtgauYTrCu04E4PjpUvXjzBDSKjsCnDMDyu?=
 =?us-ascii?Q?ix+vLrNV3+3twJUSs7oH2KBwGj5jDQASixWqX6g0yQB0JNUlXNlHjUNrr6Un?=
 =?us-ascii?Q?GAGD0s59aLcVjwhyD1INoad7zusMEI9M750ulMNGH+jYZLux4G2k+QkQTwIa?=
 =?us-ascii?Q?29PiUwJAQdVE5Ae5Sl7VbJ9OURQeMxZ7EZ6gGDe9idsHZtv873OmzULqeTCc?=
 =?us-ascii?Q?46ZR8vIt+6R8OGlxljaQUEu613/bxY8J5ts4wN8OhpRwzRMVgZ96iKI9D5a1?=
 =?us-ascii?Q?bDsBY6kpxrRBTVlejYbs14nCYauasNSBnZyBVncLVNHXwk5JnlqZqWpWJGwm?=
 =?us-ascii?Q?5oOt7wRW7WURjWp1UHyXl7oroODttnLrfb3V9IamerL7w0min+HfOwH5GG4L?=
 =?us-ascii?Q?+dUpqNdw+BV3ZQwbNd1oEphzI1Ks23Ee4CncyEGw0E8rg+ezFOGSzrxcY2sK?=
 =?us-ascii?Q?aH4w+7n0zsSltJ6cZAqT7uYHmW5KU5TsMyipJFmA6bjKAw7QFQ3p4fY5qgNM?=
 =?us-ascii?Q?FOk+vppX6jqjas3Up0aD111oyUV2S9u2XDNkM9LR4t+PxvrUanRV67m0DRpo?=
 =?us-ascii?Q?i/jGEzsg8LktBxqsP48lLUk1gb4J0kW9eMCHQfcHPNF/zNWW0mDI7hdo831Z?=
 =?us-ascii?Q?MzWR8G3Acgz6b6pVynYVQDCtjDIPtEkzeyYalb2EVdRpeXtcX5WT7gU0Rm0r?=
 =?us-ascii?Q?LY7jD+Fv7ZV6e0BvxrfXAN6qRKwbmFmgdCklWzGkhLMtRU0dh80q4+P/hDEo?=
 =?us-ascii?Q?AgkOtMERoadns215vG/vrNq9dfsA98IzmwYgiDBh/A6/7b2skhiikHb7pGjp?=
 =?us-ascii?Q?byVAwiLxL6Rgx9TkPq+VuwGyhfk71sMV1qriIz/cD0KjuxbArGUl5hqEnT9b?=
 =?us-ascii?Q?AcXU9SnMku2Jhnd1BzLLGv6S9cXgkeu1zpi8c+JwKnN/lcVIajDvyjzQo7wi?=
 =?us-ascii?Q?0MJGuAOe0qBFTp+i3QDupXPvcFyden26En1LsmpXEE4CrR80H3wftEnEBoDm?=
 =?us-ascii?Q?oV9pmyMDuS4oDrqPgqflLEWRyefjaAX73Rh6HvAg5X6wF5xg2yfZ3nbY8CEB?=
 =?us-ascii?Q?seFD0WrjRljlf3/6vGOfys12YbXw/URo3r0195S5ubybvT+pec++Lg8q5NeL?=
 =?us-ascii?Q?C3bOEONHqF+j2eSs+E6mCwecKpdZ7GFgLQAQZM+E6/WJOHlpXzLX1PUxbS1f?=
 =?us-ascii?Q?nFxxRlMLq4d8QvZ1Mp17R/J9yNo8xSoOV8pttkVYHKWVuynYxQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hv2HRyLGOVUzWZjlG5fdJibmKtR5M3CpTpDsQq3o/VH70RnAVBAKrYE/O4gl?=
 =?us-ascii?Q?ceamYWFqJfzknXh1RIpYSBR4rlvMig7kKYhOQTaYZaMxaUtCdurs6w8sPyK8?=
 =?us-ascii?Q?sbUuBrdyNVSAH1lgmVa7xoGSGWBgTs8vC5cLMxK/g9JG9FCBarh/sHQK3dXk?=
 =?us-ascii?Q?k5cRaiLi/4ROpWf9RyV3vKYyZWNGxJ+hx8l6pBMaAEY+ZrmZHw1pgF71KGTS?=
 =?us-ascii?Q?XE3T58B0ZXynt2v5abKpZ677QRFuvKFkzsvM96BAw+VNNvbaCOC32P0XH/1k?=
 =?us-ascii?Q?AczxHcAxz4i1ml6gBT9DjjlnyoN1yN3vWLxomcd1Uhk+Ht5aTNah/p3WxwdH?=
 =?us-ascii?Q?lxzT0yNI5UjKU0O39r/vSVhml8/Ns8MWTHXTMl9FqBigU+LQtm8lvdgP09vB?=
 =?us-ascii?Q?oVsd2gqNCzIgIwnXUPTGl/es2LkXUDWhqTNGK7N5xH+Ftgxvh8ksuRYAd7Wj?=
 =?us-ascii?Q?sXYv6EvAgAKtL/QWtnzZ/osBHq7scg09S+bhNfpNCi298CawczC8Us47UXRl?=
 =?us-ascii?Q?rHqAObLdCReWC5T+UnbGnFH3jXZ7GbF48Z3+0/1MUSGkeD/6rv+DwcpiIevz?=
 =?us-ascii?Q?ZyUpK3bo11CFgH/ZrX8yIPFv7B2MOOwKmR+VEKpRMaPub4gf9dFktxBVR94I?=
 =?us-ascii?Q?hCRSqEWq1x603TkooNHYlTeFAH96kAZq/4uO4CKtEzCgB9NH08Ax5AwlgZii?=
 =?us-ascii?Q?mDtnnGJUkoxrqYczDn6TOUUkV1YzmOOvqSzNKhreGzM6LcyuuUiWDc3FMGpd?=
 =?us-ascii?Q?kg6WSppCVASZhUIql90lt4htQczPfjtTKbIAwkHDD9qZu7CGlkDJV72GMjMm?=
 =?us-ascii?Q?0EkZZLBfzo1S+N0q6mjt/xFALygq+9bfW48XQUZWdWK7w5C5mRTD1/tItTUT?=
 =?us-ascii?Q?t1zKcBAQ4jS6wZ8oOkw0kKpuzea6KQnKRmDMIIsGNB0pFmb3Wi7CBX+c5gxF?=
 =?us-ascii?Q?ZyzDGxjaI6pQEDIOsYvNS8631OmxI0YOSmSlxXaDekvdhmziJB2Cpz2olDQb?=
 =?us-ascii?Q?mmfwu/jRKITiex3TwafMHPrW00J9BgCEiiX14dv9H+V8iWqRB3h4X2tO/aYs?=
 =?us-ascii?Q?X4Pc+mZ3A+Y9dC2hvkvfF5NIeNA5s/DtKDIk5onP45WFualBTT6sfiiE6Awp?=
 =?us-ascii?Q?IwPZHlIbmUfNQZA34mgDmfVjQEWI+QB4TImTmDN7PFezhWQ1H2I4QdJgLy51?=
 =?us-ascii?Q?N8qkBi9x03GPeOaDAYIK3JWWjoiNYNYB0VS3FotzUe5FShneJud+eZ//bcWG?=
 =?us-ascii?Q?AcGRnUdnPbSL1eZSGZ4yLxeBYC74KyYtGk2iTOu93nFAqR4f/bnYPLN4GHs1?=
 =?us-ascii?Q?8s3Ap0TuBFNqJHIir5QcwYNHV1JUaZtoSkL91+I03XKoEJemKKeHdplbVqBM?=
 =?us-ascii?Q?njImFyYSOJEfJvriJ9+IGjCp4j71vi1QseI0wgN5dylymlPsypy39Ee+cZ6T?=
 =?us-ascii?Q?8H+Nm46xlwMYNx9hrZcWMTWwTWz8L6BnUUGwEVjrRRzHGSJcuROVBZvkXbFu?=
 =?us-ascii?Q?NP1o93o5atqlmSQCX2wg0ZyA4oCaL8stSlGXYqWPdl+UFx7fe39AwRf7kqW2?=
 =?us-ascii?Q?myE2OJ5IagddcUPZp3bnLYcINLBd7GHsGCnUz8gj+53ifd6a8NfNqo06wDds?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9e7d72-a702-43d5-041a-08dd87575f7f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 19:52:29.3264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnu5EoZHZiLKRztLdfdc+n6Kt6Ja4aXeX3MTqSwpGNsjXM6E8RAJFH/DIEq3uIYeRq8UnuBbe8i0nhdxxMITZDbb6NFYPxVYrfZkiVA23qA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4661
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> When cxl_core calls a cxl_core exported function and that function is
> mocked by cxl_test, the call chain causes a circular dependency issue. Dan
> provided a workaround to avoid this issue. Apply the method to changes from
> the late host bridge uport mapping update changes in order to enable
> cxl-test.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/hdm.c        | 51 +++++++++++++++++++++++++++++------
>  drivers/cxl/cxl.h             | 16 +++++++++++
>  tools/testing/cxl/Kbuild      |  3 ---
>  tools/testing/cxl/test/mock.c | 34 +++++++++++++++--------
>  4 files changed, 82 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 70cae4ebf8a4..ed6bdbd6b452 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -39,14 +39,19 @@ static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	return 0;
>  }
>  
> -/*
> +/**
> + * __devm_cxl_add_passthrough_decoder - Add passthrough decoder
> + * @port: The cxl_port context
> + *
> + * Return 0 on success or errno on failure.
> + *
>   * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability Structure)
>   * single ported host-bridges need not publish a decoder capability when a
>   * passthrough decode can be assumed, i.e. all transactions that the uport sees
>   * are claimed and passed to the single dport. Disable the range until the first
>   * CXL region is enumerated / activated.
>   */
> -int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
> +int __devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>  {
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_dport *dport = NULL;
> @@ -73,6 +78,16 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>  
>  	return add_hdm_decoder(port, &cxlsd->cxld, single_port_map);
>  }
> +EXPORT_SYMBOL_NS_GPL(__devm_cxl_add_passthrough_decoder, "CXL");
> +
> +cxl_add_pt_decoder_fn _devm_cxl_add_passthrough_decoder =
> +	__devm_cxl_add_passthrough_decoder;
> +EXPORT_SYMBOL_NS_GPL(_devm_cxl_add_passthrough_decoder, "CXL");
> +
> +int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
> +{
> +	return _devm_cxl_add_passthrough_decoder(port);
> +}
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, "CXL");

I was hoping that this could be more polite and hide most of the the
mess in the common case. Something like this:

#ifdef CXL_TEST_ENABLE
#define DECLARE_TESTABLE(x)
#define x __##x
#else
#define x x
#endif

...i.e. append "__" to all testable functions in the core.

Then move the function pointer declarations, functions that call through
the function pointer, and extra symbol exports to a .c file that only
gets build into the cxl_core by tools/testing/cxl/Kbuild. I.e. like
tools/testing/cxl/cxl_core_exports.c.

That way the core only sees a few extra DECLARE_TESTABLE() lines, and
all the rest of the "magic" (burden) is hidden away in
tools/testing/cxl/.
