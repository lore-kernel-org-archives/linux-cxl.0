Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1C21D5AAE
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 23:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737676581; cv=fail; b=LaibMOvlS3w/pS5/HG6AgT0kMchnHS4lwlu5mMyQbTDdUykRYAhA1mFKqlkukxVPeWDjm3W89UxUIrzr59wNy6Bws99/Hr/PpYr/cnO8q/CDEy35f9DrI1iNidEJ8iwWhejGDYpJ3UxFOehueFmFq9s0pjq3gcbSrY4tKFNh77k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737676581; c=relaxed/simple;
	bh=MJKML6LhC4Zj/+W3jsoPehi6F40UwfxdcPq9gPRy0pw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pM32YnNMQBJ3PESXy087AcB3WzCnYAcEhgsFzMpexRJWilIR2ybc1GESAH/Gc0wMuMBO4awagKcgSd2xsSZRhFbTIXMC/LTsdHoG+HN2I1XwmhoEXw2ARxBWddB98eXbSio3KYL428uP0TlE3Su3dvebHD1MnzvTF5QTKsOlTeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NHGz8kOr; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHGz8kOr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737676580; x=1769212580;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MJKML6LhC4Zj/+W3jsoPehi6F40UwfxdcPq9gPRy0pw=;
  b=NHGz8kOrkdnICccOOHMin1X64t6yo3/WqwMBRVInLsuOmCoH1AkDDiAD
   T7T0pQbkS3Ht7ncuup1RPlBPw7QzRo6PL44w05UuiTqq+2izpRteK1ySc
   R41Jgl4XgY+UmdittCN6lGwa7HiupMOJYVZxJpNwZ7jFFi27ywTtflXKs
   ZZmtCLpYGZV/4pP6LYN1XhAN2zmL5oqcmJg7Dz0LOPFqlL5wZJU4NCtyd
   HZwWfMda0FigyScZGIBTCrLpqMWgQP57a10GBsC6KOMsSZHb2e7PH8qrB
   lTBpL3hCtD7tyFhk1k3CSdrXUbaslOgOLkCKoUJ0KZYPZpDSVCy3JMBaq
   A==;
X-CSE-ConnectionGUID: QZdaeuFnQqGznOOFhUFbiA==
X-CSE-MsgGUID: Jv3VvKs1S7ya2eZSD0h0tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="38093848"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="38093848"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 15:55:56 -0800
X-CSE-ConnectionGUID: kLaCt4o9QMy7/mLe1Rh5tA==
X-CSE-MsgGUID: D6iSVfm9RauZpDycSg6CrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="107419932"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 15:55:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 15:55:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 15:55:53 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 15:55:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atekiOUsHcngcwsjlnyX6Cmz2hk2bz5Z2a9rDBYB8d1pWg0Qi78jwqgZgTszznX//t77KSQE4qj8Cv4Ukd/sBYkzssONLCyL4jEMoAIQFWRDedxTPMZDGM4P9aEhmtPD69/kkrjlUCBhU04zsT/YlI68vvnOReWKhPj+tI4Q8MycaDwv7SJEdIF0RV+JuFlwCmg6WWriR9cCjBB8Sp6tEBZD/Yk7yGtNPmmosd+ryooFggpkDtl86rWPooD91JRj0SZudiNF1o/kuxiO527DXL2QaJoZ/z+JZXDcZ5h0hVYMBbM1wwKgvMZsJ8ykO9TRy6B7ZrSv1AiKPpCtFC/Tyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SKRAtlFoxShxpn48UTTDZ85HsndkBy5q1PQKhZxFck=;
 b=aw4QPgg6Jl1oko1k5TaLWAwU3L0DlfEF9QHfqBho37Y+Yt7mDWNbNONBeWomDmKlPRNlTZ8ayad/leqhBWddcyHL8PZh2nOv4Gib1/j5jQqO7T4m3JcEhEJN9Y3HbOFDmVAGsalodzJouw1zA+LEHFWTCAgYsKeyzwnOGvt25YLkDW5P8swiXDeo+50g+p6vrM+7HhVAStJrnAw5d51A6HLyp2NEG/dn0y+H9QqQMQdX6yWdxATXuIdGUWaqchRkdXkSna4Y5mrgO+h9Na/YrKwD2QutmUV0YsVrldWEHASu/v2V970QSvOjpRG+4Eqx7iHo4hJ50FxKUouTTFeOFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7580.namprd11.prod.outlook.com (2603:10b6:8:148::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Thu, 23 Jan
 2025 23:55:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 23:55:38 +0000
Date: Thu, 23 Jan 2025 15:55:32 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 03/19] cxl: Enumerate feature commands
Message-ID: <6792d6f4599eb_20fa294e0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-4-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250122235159.2716036-4-dave.jiang@intel.com>
X-ClientProxiedBy: MW2PR16CA0048.namprd16.prod.outlook.com
 (2603:10b6:907:1::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7580:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ca80d8-3d73-44be-be6b-08dd3c096fa1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fSv7ecPFR4mIAGDbai8GEKVHO1+p7KUZ/2vGMhfjaEtEiXEQU8259rSuFxTC?=
 =?us-ascii?Q?eH21rMgx0ihv6Plu4MCFn63m1s6FwZF9Q5Y6G96QQ4GQvbFp6ptWOTwHhvNa?=
 =?us-ascii?Q?q6iVAh1JnqkizWV3h0PdROFz1M1JQBuaO8etsgga5BYSHdws84fZoOPf7wCD?=
 =?us-ascii?Q?+lmbRsytsauRvA3GA51EDej329YScZQ97GqEXoUxcImWFVs+qh6aHhlqVwS3?=
 =?us-ascii?Q?JbU9zNpKrgPjbYVHpAx/bp7d5gJZRj+cHHjloCnx9Ocxwl3LUk38llI98U9y?=
 =?us-ascii?Q?EPNWR4bAYwEUnZEXPF3Kb9zOIE13PtgITfYvs68dRkqzOGo/AHTL8xBhx7V0?=
 =?us-ascii?Q?BM7tmrYZuJ6wNWnfEyUYuAsCp/EmQZWYQ80FPSMeDxozI8krtqRjPjRNyKiV?=
 =?us-ascii?Q?mUqF0s6im0xGyOeJHfCux6X3MdPdKplIuPnVfiZjV7DLmZVzNjhBrvWiXh6E?=
 =?us-ascii?Q?Pgpx6LiX2iDeEak87BcKFu/8M5u11CZ3c38TlUTl8gH9ePJOoVQHKEY9Bf4n?=
 =?us-ascii?Q?oZuGvHQF0ECilGykNckkX3eXwdeoRlrvnxtCbRGxIBewnB8GsF4HGvPQGn/l?=
 =?us-ascii?Q?gZwLJoP5FwxzConduaMcXrCy3XIxmayhYOJRZfgvGBhW9rP7c10T7GcvrO/U?=
 =?us-ascii?Q?/OUVnSFgBkWf7nKWeeCRJG8koDMjc/CkhjHsuIkhz31rcJ+h2IbRbzlqfdfE?=
 =?us-ascii?Q?3Wn1TnkyQQANRT8oAg2N8WoIr4pNG6rT8kv7j7kMZuiCOS7TSoHhe2TUXGzM?=
 =?us-ascii?Q?HdEB45B+NzGgedM2npdm5ZgvlQGaSZXR5jK3V0SxTB0HZOkszVd/LMD5Hmwf?=
 =?us-ascii?Q?MbxqNVVnLIDnJ8jlmz2ZUuMaFTY6+rSQueW6BoJa3NNHSz0RDJWNJcHrvM6y?=
 =?us-ascii?Q?aZPNm1gmFk7MfIndd+bt/gjaCnLDYelaG3KtbiQSXtrlYUiB2ooK9eLVfaGE?=
 =?us-ascii?Q?E9Zn1y18N52zScJe2sMImLXzdlbVo5ZqWMen9gVr61sk8iemNoKxmEjYKhag?=
 =?us-ascii?Q?JGwoe6CDLIJ8kqp8Vqc4egUbA9mMz0NE1Ee7B2f8GN66bSx+Pt9+wqZ89wrt?=
 =?us-ascii?Q?+8LJbcd/J+RX3Xpvp4MgpvTzUzfIN0x1AW+P4tRlnKth2uMjy17uc1tlWyR1?=
 =?us-ascii?Q?xuc76qbQzcHWuMWeoqdJsITxWs5EASW+ZAfnZ6gxI+7UYW4COmRqJ/C7vKTU?=
 =?us-ascii?Q?cCoJ2wUOGHhtFNO9hhIO/bJraFfur2N2Q2dw6Gb5q/RM1clVRd7rJoeVdoZQ?=
 =?us-ascii?Q?H9CDehXg3Ll4M+JrbI4WlcncdAk4NCoRO3m/lV3pg21WsxO3oLREfzlFV/tx?=
 =?us-ascii?Q?iTGbtmWPZ3h31+A+3JyvKveV788S8PEiOnsi4J71HiD13A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DPCxhsyBitX0yW9+jpl3cX6MCIxA/juqrnrWmgVuN0YfP/inWCyEBF6IHLWL?=
 =?us-ascii?Q?rpb03LGs+17dPMl/ysVXSRkGFPK3knhPPK3E3v3yRCJDZ6Q8AlOAzDwk3lme?=
 =?us-ascii?Q?7LrnSbIyW64hRcqesruu49CeCs5DwzrXDHbs0WJ+iNalzPr6CyS5BX8IrOkU?=
 =?us-ascii?Q?KZn2XgQFYU5nKmw3ydXyz7bwUduXhQg9f1D0moimlcmO89H1tL8lsYchHf4b?=
 =?us-ascii?Q?cuQCSjWFOO0It/QDq3IN/7IyUQYC4Z7Hq+PRQ2AcxSU3/2XxMB0p3rmU4Ase?=
 =?us-ascii?Q?XngFSnZ2L7p0hPoAk33IrcetHWfr6lhncOpLDvNMejU2/5Of4BHGxNZtMsEz?=
 =?us-ascii?Q?gElgmOJVAfmgN95qrxzyT/yy6JAdjT0+ZQhjilapx3OMkzkC3EECCKNIcz6I?=
 =?us-ascii?Q?/X8IEPkmjbDT9k4rFKZfIrc4Y7iVPz4CXuOg9nkFUpqA32kqKAxa34O0DQOk?=
 =?us-ascii?Q?RjBH+sananfHK9fzN0CUWDlpR/Yk+ku85/ewHWQ59qeEtNnLIfMjcwNUao3w?=
 =?us-ascii?Q?lptToX6YjwWldzlVgW9VPhgP4KhFrGCLQE8qVAOA6O2ps9xlSnTf+V9eYW5k?=
 =?us-ascii?Q?zJN0m5O8Ck2smOSiumHUceuNniQ4v4felx/xpl2ffEGAagr/XO2RaL2jjsRQ?=
 =?us-ascii?Q?nMa7GgvTNPj1n3Kh8x+Aw/IDx6VCOv8BX43hB1MjjVKF00sv10CESEyV2mR9?=
 =?us-ascii?Q?CMi+1DGyDt/+q34ymrxrdh2++vJ4lCIHURmkXrS13QolRxe4j3TEcWSR1VhV?=
 =?us-ascii?Q?kvryBg0OQ6t8H59CikRb4lMRGxmzTEgcgO9tNe7tKjfBLqiW8cJLXxKhQpM/?=
 =?us-ascii?Q?7LHmF1ncBn/1LR46wYsJV2SaOIDOY+NzsLe1QbuTGDgltTmPPtGPQTHWGMgM?=
 =?us-ascii?Q?DX9Cl7cgUb2dgm8RKknILgUrgepCcAbTqGgUlS51s/NA2t9bDoyeCqQyCQkq?=
 =?us-ascii?Q?r9cuaedvKV/kMoxWVmO/h8Lg1ZN/JqdeScuzp5VpPONqtBFENRenxlPy2Rfv?=
 =?us-ascii?Q?+EkebIkbPOw39f+ffk8GG1w23Pkpy0mGpG36FagQ+l9TUaHSMse2VasSPxb8?=
 =?us-ascii?Q?IZ01c/riwT2YOW5KB4llj3baB7KW6Lf7iVVduuog6MnNLnPKI7hJ18okc58h?=
 =?us-ascii?Q?+ePhq9+MCIUN/Aifv5iQQwi8vSLCzd/gGOAxVav3gRTqZH5EoCeW8IUvpVs4?=
 =?us-ascii?Q?S59ZfdssfufjtAY4aoKu/NQtsWJOi4vxUZFjS7RHe40rj3hbC/tyYJD9gCPe?=
 =?us-ascii?Q?DcQZuK0PixHKB1skEyn8UQxHdMv3Ryi2DGhaswViLeP0LloA6p8ui14RXZt0?=
 =?us-ascii?Q?pkEX30RjbAasseTl7OjVDBglaY2PG7NRXMwKLFN5J/pC+363spC4Gc33tCN0?=
 =?us-ascii?Q?z9WBTT+IsyyzFZENWwA1B1wxpJrkTxmM1A89aAYK7IiPnhsb8x6m3ejtbb0i?=
 =?us-ascii?Q?72K85/jrPLnUtofbCrkH7j/bOWOHs6811ameqsBi8e2qH1G/fTa2OKEpHCQQ?=
 =?us-ascii?Q?9g/shQZ8IJCHozPjh5bxdHR8cXRpecDvTvbqR/phRvWg8FAkN/BLgcw1dG0M?=
 =?us-ascii?Q?qN1i4mcvyaoHktcr47QZvkW7m4owtewRvMURmvcRhZ/wulAbpNLt1eydkWJ3?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ca80d8-3d73-44be-be6b-08dd3c096fa1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 23:55:38.3324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqP2+MCzcnn/QFzS0EKnuI/U7x0F+PC8Cj/IN11N9KxAoY0f5lvOoCurnTytrsPidigUBdQgeBIphcryIMthImQqXbmMhA/OHoGNirbYm3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7580
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add feature commands enumeration code in order to detect and enumerate
> the 3 feature related commands "get supported features", "get feature",
> and "set feature". The enumeration will help determine whether the driver
> can issue any of the 3 commands to the device.

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    |  3 +++
>  include/cxl/features.h  |  7 +++++++
>  include/cxl/mailbox.h   |  1 +
>  4 files changed, 52 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index bdb8f060f2c1..5e21ff99d70f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -38,6 +38,21 @@ static bool cxl_raw_allow_all;
>  	.flags = _flags,                                                       \
>  	}
>  
> +#define cxl_for_each_feature_cmd(cmd)                                          \
> +	for ((cmd) = &cxl_feature_commands[0];                                 \
> +	     ((cmd) - cxl_feature_commands) < ARRAY_SIZE(cxl_feature_commands); (cmd)++)
> +
> +#define CXL_FEATURE_CMD(_id, sin, sout, _flags)                                \
> +	[CXL_FEATURE_ID_##_id] = {                                             \
> +	.info =	{                                                              \
> +			.id = CXL_FEATURE_ID_##_id,                            \
> +			.size_in = sin,                                        \
> +			.size_out = sout,                                      \
> +		},                                                             \
> +	.opcode = CXL_MBOX_OP_##_id,                                           \
> +	.flags = _flags,                                                       \
> +	}
> +
>  #define CXL_VARIABLE_PAYLOAD	~0U
>  /*
>   * This table defines the supported mailbox commands for the driver. This table
> @@ -69,6 +84,13 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
>  };
>  
> +#define CXL_FEATURE_COMMAND_ID_MAX 3
> +static struct cxl_mem_command cxl_feature_commands[CXL_FEATURE_COMMAND_ID_MAX] = {
> +	CXL_FEATURE_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),
> +	CXL_FEATURE_CMD(GET_FEATURE, 0xf, CXL_VARIABLE_PAYLOAD, 0),
> +	CXL_FEATURE_CMD(SET_FEATURE, CXL_VARIABLE_PAYLOAD, 0, 0),
> +};

It's not immediately clear to me what this is far. The
cxl_mem_commands[] array is to put all the common work of defining new
commands for the CXL ioctl path into a table. Given these are all
fronted by FWCTL, does the driver need to do anything more than the
opcodes are supported.

In other words, I worry this approach is simply copying the organization
of cxl_walk_cel() for consistency sake. I had similar feedback on the
DCD series:

http://lore.kernel.org/67786b76a0c5_f58f294b1@dwillia2-xfh.jf.intel.com.notmuch

Just check for the opcodes you need and set a flag.
