Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22352FFDFC
	for <linux-cxl@vger.kernel.org>; Fri, 21 Aug 2026 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343372; cv=fail; b=bmDD0QNCsmUpbuADKBNB0gbXUL1JQ0r8o6x/Y3s/GUN5I+qr6Vuo4DQ36Fh+vUiy3AKlQsXdjQR51hwCKT/2ESU4o7uPQty+5rItbgmfYoaqWYW37LyL1/UKFT8niHfosRdholjB7emX6+TDUruPnBf4m3V957clWZKwgJGCdOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343372; c=relaxed/simple;
	bh=VA4pWE36bmdcxQq2c3LWM7wHllEbk9PTx+RQ3SIC/Ig=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iEX8IyG7vzKNeH2RpyFh52DBBc9OZNKMXWHjNzz5I3aWXXRmjPJYiWeXSJlBOSVbzQq0C/OQNcouQ1VdxVG9gUf6eJ1duwnKm0FqB6+CSvxTuaPcwHDdFG29ek34DnN+B92JP2TkwGGTarBMxJy0S0kj3LoBdyg9iSL8ASly8P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZacup+O; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZacup+O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787343371; x=1818879371;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=VA4pWE36bmdcxQq2c3LWM7wHllEbk9PTx+RQ3SIC/Ig=;
  b=JZacup+OzBSEru5b6DwM/w473EMsMxg8NEQ6unUfbDMVH4bdInOExPyi
   jGDcZg4T9daalpK3MyPJ9ib6JP1cgGfKnq/1x/bf8g3ls1gmI749gtXOp
   /vAhYnqmqzrfVmLXRgkYIeV/Q4T6cQQgMIIbOpMmRJrBacJQX1JX1auIF
   D9f006qxhuULr+C53RKRlyMTlXSpooc4CPZkAF3Zqt/NEr9V11CZpaRrH
   Lyf19LYPRnZTU7bMCe2pwi4fQjr2YbTGJvx8fx7usweK6vmWbYF4nUWpJ
   AIdSkCar3YvFZNAodsKfCipkKjwU7XUfltE3uubeyDgNMwkWtXrJxnlJV
   A==;
X-CSE-ConnectionGUID: psgwkhxpQdOSeD8bRIVOlA==
X-CSE-MsgGUID: Y3//0Tn5StCCkSo45QUjUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="99054907"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="99054907"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 13:16:10 -0700
X-CSE-ConnectionGUID: SsPeoiZAS9GDiCNySiA62A==
X-CSE-MsgGUID: uLUmn6cVQfSYPWscUf+TtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="289972971"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 13:16:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 13:16:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 13:16:09 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.34) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 13:16:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTu/XItxfHxbg5Brajy0RDn/zPBN+AsFu7zfX8SCMJs/gT4/qr86i22DdHkri2a+rfAmV/rB6kIBw9p4bJgVWAH16NANcwgeBfZc5KNITkF9NOsu8JLDM5+WLrn1jnO8X+vfY9AomNjvJgapqLRzRXMD/4DKQIPXQsKhcdfjPx1oFSKVAwak2kbCWCydfio4fOcdYUQIusMCul+8HWW5ph5EGoTVUNXeEn28lMGDz97u+9UZ+zkzL2RJUC3QcFzTJkl1ucIzI1lEckuQNQA/HnwxvRS53qLyACaHoyJYWc2PYQdXF6Zxhxf7/MRE4lm1uEDggV66aSXVn75wHZMQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuiqpmwGkhSAqDhubRmw0h2V88kPZJnjkzV5lyjKUoQ=;
 b=IaLOUhqxkdQ9HZLBAuSqyPyrjDdlOy47cOmonXj3TqYf73iYvtcteIexvzcJBZS8YYMCv9u7Ixxkp9ZP9sXJ4RxMbJCFkmLT/QTlGEV3v/Otr2oLu2nKRzbzeeu4AQKqy7R/ulyid5RQGR3z8agHqOAT0WQNqX4Wvhi3/BZBkzEq5Iswxm+MFJlv8PdkUf+LSPk2PzbijwZmHqxNLtspfcJ7DtC5km+6Djc6n7CWMWNXX+kXeCXg5BacmitZWuCYDdhWlCmCdSPMK7nDN88Wj+Zd3mdMi9nFOBXEraXOZBOdMomyOeDrcnisxbcFEPL6TynsIJ6IFkvTs6EHL11BXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SAWPR11MB9736.namprd11.prod.outlook.com (2603:10b6:806:4cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 20:16:08 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 20:16:07 +0000
Date: Fri, 21 Aug 2026 13:16:04 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 2/6] cxl/region: Generalize endpoint position mapping
Message-ID: <aoiyBPLkSZpaip9m@aschofie-mobl2.lan>
References: <cover.1787255388.git.alison.schofield@intel.com>
 <1c9218cf46a96937964e217c9172648a322d86c7.1787255388.git.alison.schofield@intel.com>
 <20260820234309.6507D1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260820234309.6507D1F000E9@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:a03:331::23) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SAWPR11MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c1e3396-fe05-4e40-29c6-08deffc108aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lyl/cjxnD4yPoxlPOVZtDs8IlOJAfP/aAuHH95zH8JmC7VfLE0zt5X2nQZvYt6FFD0AaMDg8zs9mTAeSs+nN7BjHyxbUwLMa6kG+qymOGXaVpCvN/SSSwSXOm/V1lyVCHtYRe/Ife+UV4Ca0ACLi9IkqULT0OlHZKuPP7BFtXs6AyuzC7KGvk95kJUGaH+UwxHnngVIwEQkceazAMppLuuLNYKyYIL4KlgEgWR6nNuYoO8Uh8jxax7P5xV3Je/igNFqEQcovUJw9QXCjK6bTCEeD/3f8dLkUaQjzbVjAW1Y1UBAnXAuR99pQGMnmHwJ3xdjnX98OtCRrawFTyWgcyMvx3P+OwykJr30+XI1AbmGFMRMWzPJAbQWWP3PiBlJBmnxNHsWqWUTf4kwjRGNvCpdzp14S36M7283Uc6kSNGXTKHsSntpMl+blMDqTQzLox9MNYS7kROw7XHqL15qPZODsB8oICGELwmdV8pUVAJZr3DqHacTjX8GSsfjJO82OrHb9D1C0aGCKlgO1uC12VwEXWGCpsohed7Pq6v291bH1SQNKaa0wqVssRz30OQtbKjbjHByNCw15gpPf3k7iE9LJt9CxryflTrgyK4OdwzE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?WcPayu+gFvyemPqX1WGRps4RNVD/4KqMz77WHEQ+ZQvQMK2vmYqohIT0Os?=
 =?iso-8859-1?Q?dU0ef/Ui2vU9+3q3xYbJRWds5Hlj5xtBw5i5hnEuCooZWZ81nybKpOs9Tv?=
 =?iso-8859-1?Q?Hqqg7JOa8GaDKbi34nE58kmmVH3EPpzo/5vHk0+yc8tVe3gVAORR3l0v3i?=
 =?iso-8859-1?Q?T8MsNTYbW5iU9ex40E+6b8tNAmiNA6WhA9wFkks9xbTQL6gMCdiwYJs49/?=
 =?iso-8859-1?Q?EGzU7F7lYzSruZMil67J8MxshJdP5v8yKdYcZQdr/7HdaIm+RHTBpjU34H?=
 =?iso-8859-1?Q?kENUVCsVpdXXiPkI4SmCj0pAseCov0yZPJsVNY8u2uu6KZt4N7TBAetMMJ?=
 =?iso-8859-1?Q?apbtezcHjoE+4PoUeyqP8WzwEiGilBAde4Yz4st4HTfEO3xd7wtDiMfWmP?=
 =?iso-8859-1?Q?wv122i2sQ/+L8aROoqJRgK4sobOQ+a9mb39xcS0mlQ8Cp6mbKGFRJT2L58?=
 =?iso-8859-1?Q?ZIsIJw2DFlCpVW586CelSOsMxM+pIc4Fi3tWJe3Cahe7y5VCaRr10iYRTE?=
 =?iso-8859-1?Q?TwdhTLaqAtB6PZQd7WhqkZV0loXHoRx9A5el5H0FuhtRB4oUlB930bahS2?=
 =?iso-8859-1?Q?TDoYAYxgILCm3B9CXcyRex1I+wicG42PjTp104yf57C/SjFlHAy5HB5/o7?=
 =?iso-8859-1?Q?Kj3+Ey0dZfozz4rZqOhxCfWGgxu3jEotzhhNWmvgChvnn9fkvxX3OGo5tJ?=
 =?iso-8859-1?Q?9+rUY6J17Wcdv+Uf+Lm+o6nc52WsHrzCw3h8S7x7ug0dOlPe+//D/XC3fP?=
 =?iso-8859-1?Q?gxc/e0icd+GKNxm0e+9OAYF9xUgNsdnhIoCjtpNcFa5bmi33KzREaVn/0X?=
 =?iso-8859-1?Q?Ek+SHaEdh1jaEgNNHy69ZvNNgmizv8xN3TOI7oz5Pm+aPXp+GB5x3v3lMX?=
 =?iso-8859-1?Q?TnlMQXmyRK0+eP1ntm3vrfyt6otQpbLuW1N4bOcE5+557GP2x6EGiHXask?=
 =?iso-8859-1?Q?QHbwYXl6jRDymSQYJ9ZRI/5kTaFhwefl2X2q/FDbhqhD30b60/S/dD5CKm?=
 =?iso-8859-1?Q?EKVzZe9/Wp/bFhskK8MEgi9efe6Vdzsa2uAVhQT5UpFsfZub4bMh/iEKuO?=
 =?iso-8859-1?Q?DBihUjUEHDkhKchoLzbA5LKqZ3RZkpAK895b/5Xbja6QVWVdhZ95+jiCTl?=
 =?iso-8859-1?Q?xH3o6tinhvFtPAzX01IhUMmHS7Nf20RZiP1EL9/G4hW7IBO+u2BayI6pum?=
 =?iso-8859-1?Q?0IENj8YOkaLewSERG4XRaM1oMTZdAWlLwCbG3SDNd3PtnLPP5jZVIk+wns?=
 =?iso-8859-1?Q?VyumaHYbFvMnbo69LEuX18U4/cFvWGfVAYnXkqOQoz9QsUdvUgKuUt8lXM?=
 =?iso-8859-1?Q?sjuKNDKMCeyCqfFZRvL7dCj4Wv6dlVJqos+3nRxqNLzsFzurQFqVWB4EU0?=
 =?iso-8859-1?Q?axLpQP1Ftkj0LnD7zV2I4bXLipXqJypagU/uPkQUAZxhbS9LXsQ3unepJk?=
 =?iso-8859-1?Q?6YuVctL2HltNEjqTnD85vls75NN1G5p1QUm6XuKcpBSFgN2teRvH3e1Nnb?=
 =?iso-8859-1?Q?3eL8AhVBAQzx/kzYynlp4Ud2AzyCb2DnkidEmjBM9QryBmL/glGcoTgHNd?=
 =?iso-8859-1?Q?RBU8v27P4pCwlXcNNkbSpE+yFHC6yLlzWUAPXlOiQG/uefHp0jb1A+BG/S?=
 =?iso-8859-1?Q?bR6NCCXGKnnKFh2k/btGB8iqej1DBZhD28/c4+SCBx26ltd2QPdhV7Cxlr?=
 =?iso-8859-1?Q?9DPCUyQPA0wgD8Tmj/8k+OAcXP5AYL7FHef8v/Xx/i01hEvy7RGzwCqrMc?=
 =?iso-8859-1?Q?2Ud3SqfsTdDm4z2Sue3uQ75sk8Fr4C5e7EXEnqZ1uMHGFs3onBwd2sWhpu?=
 =?iso-8859-1?Q?SJnew5+AACcJZnxkHiZtyKEQsftwAcE=3D?=
X-Exchange-RoutingPolicyChecked: cuxGKJKIitgZamQDjv6y8H4iiPcPNNXXnz4BVbpuBlPgAdlKHvb8XO0cckhMD8EJNc1iZdhGrkXwu6Sgqnk0ohknK1zm1YpRkef9k824Ki7DttcfHx9PE8iKdYhve0ENW2Rby+CAAaLRlgcWPDNBum+kicNe93hPZhoUT1L7a9K+0yHghj4yZU7zD7ey5BdcmIztlhanPGixpU/Zt0hcugMR4RPdhsD+/y11CffruwxJjz7OAhyVk4PAoBwSYmklQdQwbix5lgl/r67RLiAfX0BsZ1HAqT3H5hnRkCkxRyP5plyI7S3y+snj0Nvz5mghUXXMmbc9nT7VddWqbnvlFA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1e3396-fe05-4e40-29c6-08deffc108aa
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 20:16:07.5717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gf0mTRscBU5CplUR+mRo2BUpBd01pm3h1AsadewcKUrCFvV1HrRa61Oix+rItwsxJqIOOSv7ilwmT2oD6lO9g/aVw6/q4l9MzEJdAzkZVJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9736
X-OriginatorOrg: intel.com

On Thu, Aug 20, 2026 at 11:43:08PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Use-After-Free read of device structure in find_pos_and_gran error path.
> --

The fix for this issue is in the 7.3 CXL Pull Request.
I expect the next version of this patchset will be based on 7.3-rc1 so
this complaint will go away.

https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?h=next&id=15da704b732332cc1e8f121f624e5e6c05124c5d


> 
> --- Patch [2]: [PATCH v4 2/6] cxl/region: Generalize endpoint position mapping ---
> commit 74f53df9f58a0339cb5f29038f2e514904e34cf5
> Author: Alison Schofield <alison.schofield@intel.com>
> 
> cxl/region: Generalize endpoint position mapping
> 
> This commit alters the endpoint position calculation to support
> mixed-granularity regions. It weights each decoder's contribution by its
> relative granularity instead of assuming a uniform granularity across the
> interleave hierarchy.
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 3b640c9ba5a08..4f367feaf6c84 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> [ ... ]
> > @@ -1929,9 +1934,10 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> >  		return rc;
> >  	}
> >  	cxlsd = to_cxl_switch_decoder(dev);
> > -	*ways = cxlsd->cxld.interleave_ways;
> > +	ways = cxlsd->cxld.interleave_ways;
> > +	*gran = cxlsd->cxld.interleave_granularity;
> >  
> > -	for (int i = 0; i < *ways; i++) {
> > +	for (int i = 0; i < ways; i++) {
> >  		if (cxlsd->target[i] == port->parent_dport) {
> >  			*pos = i;
> >  			rc = 0;
> 
> [Severity: High]
> This is a pre-existing issue, but could the error handling path just after
> this loop trigger a use-after-free?
> 
> Looking at find_pos_and_gran(), if the loop completes without finding a
> match, rc remains -ENXIO. Immediately after the loop, put_device(dev) is
> called, and then dev_err() formats an error message using cxlsd:
> 
> 	put_device(dev);
> 
> 	if (rc)
> 		dev_err(port->uport_dev,
> 			"failed to find %s:%s in target list of %s\n",
> 			dev_name(&port->dev),
> 			dev_name(port->parent_dport->dport_dev),
> 			dev_name(&cxlsd->cxld.dev));
> 
> Since cxlsd is derived from dev, does calling put_device() before dev_err()
> release the structure prematurely and cause a read of freed memory?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1787255388.git.alison.schofield@intel.com?part=2
