Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF2E18BC26;
	Thu,  6 Mar 2025 20:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293485; cv=fail; b=BsMGr27PKZWrr7RD47FVXAZ5yfF4O9QNcJTRs1EOVTj1tOehF/99NBcClo3c1fbaQAq5VjXSK/pc78A1xqpVIPF/5OvHs7EIHpFwMCHk9c1++Q3IkUHcBlE3oQ86YFpz8rMxzZncQdtiVkC3FMIROmP2K575/zrgq3MZhVj7ZsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293485; c=relaxed/simple;
	bh=dYVrSVKtRcVh6VUH7pTxyoZHHUBJlR/f43G5tUJgMeU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A6lLqmEmD+j3Xw7z78Hzh73UlkStTmXpi/ruyPYGZi5kpxaqsN4SYisn09PeTfXxxmvWl6OMHzFKPel5/8Me4V5Q4KYOPJOOJsExmp070b9TkhR2qfKLqyfcQL9rmFxYYbUuMa51acCEF99/aGWLlDlhUxSok4mcHsT95jwFMXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A9Ox+rTy; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A9Ox+rTy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741293483; x=1772829483;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dYVrSVKtRcVh6VUH7pTxyoZHHUBJlR/f43G5tUJgMeU=;
  b=A9Ox+rTy2osO4beWnMG2aC8kdfiJ7Xv9qvtP0D6QdVYULm1uh9tLxVcN
   mwgrjgWWkjCcnxrhOrZub4on4XBLH2AVD9tEcFuxqPiw2feULewdprEtA
   hEygfdm5g7P1fZ6TH6tvZBlFkRKAIDRym8YN+wudPf6/EjpHCeQkkK5gP
   qsKZi4ZAwlaFWfwhdrke4aBGTAPfh7Bnox8l4HCpQ7nGbcWLlCcO4/PoS
   baJ9soVt3k5NEQPyzX0XyMn8z3tCX7M8Xcb/WM1VAN/aFuepslvtGb1kJ
   /uPcCZDqi2TAcBfG/vtfmuGx8vwL5/QtArJtEtEwH7np+QRK4V66I5Nz+
   A==;
X-CSE-ConnectionGUID: j6dpcBxwQVe7xjV9o+DABw==
X-CSE-MsgGUID: BO0gpnJOSBOtL5cF2QtCNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="64773569"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="64773569"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 12:38:03 -0800
X-CSE-ConnectionGUID: Ew0tticxRpKVEByC3QxZjw==
X-CSE-MsgGUID: Gyf27XbESH2Fx4AGsd0rOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="124335159"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 12:38:02 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Mar 2025 12:38:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 12:38:02 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 12:38:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwKS25Ljw0QwPl+6mp/twN3biJRDLgAV9H5RKhvvnnIgYEtxvp32DZ1H6AC5hzLzthTW2a1jtW+oxP7IBthSz2jPj+h4l1+OD2UOoU4+rFVEBeu3+fpu4ro7TuN4GRGmPbU2twBJIHbJ68n9kDLzTk5DAwPA437HNX7MzSDZRtFi4n/Jo4U2iZ6lEW4lb22s1zRT3mwHx5/8xCKXiHYzQr8tHfn6bHQzAY1jnRgCcyzj89WbIuQw0CTcwbiPw9RBXnIjFMvUgx/kJBGDfohaCXkP2MaOTHgRDTiL+aRQov/O/0j2JkZ1g1mDqVJ+ZZods4RVvZoDmHWFaBvc/j2BfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FU3rHrveZu7LvT31LBXOfig3RuQ6Ke6lvfJPBvvdLzI=;
 b=Gbev3+UOBmcKGLL7aIyC82Eefa9EKN8l7B9YVZSznMdV5aKmpN5slOp3E2xLqmBuNxcoAJvtuJTRqMweyc+ak37SsDrLTqyCNbUKpBINHzEWWCiPK/zrMsB9mNDFjRHj7KUL4z3YvhgNpZ66Gsa2syfoc5dSTXfswfcnUxzH7J93GV6v1IWpgukJWWToZ3PGJi3n5kh9FpxGwIG1G4ChEV6oorzkN+wMlPh8J536UX+X090lldVfKu1CBF1OEfflJJksYgFmx/cfy/Qf+ZPBOqhKArFEXXNjljxT/pYGXnsXkOlawkupPv/sMDmv2sZeYgs4ogBHLZFmHyQLcg6oKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8528.namprd11.prod.outlook.com (2603:10b6:510:2fd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 20:37:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 20:37:40 +0000
Date: Thu, 6 Mar 2025 12:37:38 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH v4 09/14] cxl/region: Factor out code to find a root
 decoder's region
Message-ID: <67ca07922b54a_1a7729458@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-10-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-10-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:303:b7::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8528:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c9978c-a0dd-4d39-0b99-08dd5ceebd63
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vcN8X1m/wEIIE1xpFzrPl3fnEpZUIuRnqen08KKBwnNrNqzUHAHxeTQp0riH?=
 =?us-ascii?Q?glysPnTEht7Ut0LWPrZWd9Hp/mDMabj8C8tbxFr295zpjsl8ds49HpiJWrgV?=
 =?us-ascii?Q?F9YVR8wv21VBNllKiP7Bwg9ZOH+AeBwMIs/XcRT9eVwjagGh7BMAui228Vt4?=
 =?us-ascii?Q?/KG8ZoEBIW7yINb3jOqF8NJw7wV1v3Ntkrvus2GxfI+pv6KtGgLhQazsnEPA?=
 =?us-ascii?Q?LAcJt1IbvsNuOq2Os6P4eh+YsLTmemr4F9w7zwJYFcd2XKx08efrEFSVftV3?=
 =?us-ascii?Q?c94rEwb3jHX0pkhi2iEZytPoFen6xKfvKslm3F4u0xRvE6OWv98Wuda4zOCG?=
 =?us-ascii?Q?BFtJpzqRZlDJ0NFp/0BuXN2q/HD4JKkA9CQG4pNdy6wSYkPrUPgjV3QH75fX?=
 =?us-ascii?Q?fZ5ihtjle536qZzgiur/1A7henNLnN+SNE9LdJjRzacRvRRSWw4Op35GYU68?=
 =?us-ascii?Q?DnN9JM2D0F2qy2Kaw1XGLEB3YZzxniMPgrQloIO4dfpurXACdQhNoqUEHP4h?=
 =?us-ascii?Q?126X/7vRg5V8go6Zn0uVsdJT7pxZRA5vxmoZK0ouX7bzORlQ0vxYibNNli7H?=
 =?us-ascii?Q?mc9uFIHdS6jngyRGYxRQkO2ibek9lnZKREnemCJDNjM6nWKFQfBzGMn8BKC7?=
 =?us-ascii?Q?DUUezvOK01H9M6clS/uCtKAmpXSZq/i/ldLcBxSfnyZHBqeqMO5szUSFqleM?=
 =?us-ascii?Q?FHLM8ScuCEKgLAqY/Bo8QN+UX/rxuc24dNJrkZwPuyU/Auh0IYyZViQc0wpP?=
 =?us-ascii?Q?MCitwPvxL6NTwzX7K3FkeBrvniFLGfL4ca31mAsB1k2N1s86HaZ13SvNm1eb?=
 =?us-ascii?Q?z/4qY0lNKx+fZsRqQ03e9tVOzPVgezZSK2M/mFj9vMSHHmfJcjyCoQ2Z2Rtf?=
 =?us-ascii?Q?JShbltOJY47ga9GgOUzyuBwyJpfBNu3J0IodtxEagEu9qtrdM0JA3lo99J2l?=
 =?us-ascii?Q?/RsViyRhzamVUwhawsxnn3kQRhbifJnHNbsYuweHAfxLYKrlOIOWYpONw/TM?=
 =?us-ascii?Q?n3h6tOiiDbZzK3dZU2fiA9OOQSXGj0vGMxv+lCSs20FiON9+20gEBMtwcHYT?=
 =?us-ascii?Q?gGlqgVZz6AZWedt16a7m4nJsp2oWZpd+CcUbr3gxjsijCb87ruMBCvxEhqCY?=
 =?us-ascii?Q?6hOZGeH+xmXHzyh2xkxEPGaqhcsN5EkTRs/CEbIOtZk/fz9S9HrVwhzvK+ax?=
 =?us-ascii?Q?5PETRK6H/XzwNrJUeETV6sncLBNInd435QBEoOIihVD3IGXos/su7IGg/ncG?=
 =?us-ascii?Q?b+0rSmDqMszlI4eQKKsltjU1P9wWdSD/aqs3BdHkIXiSxc3P3M36Iz6DZH24?=
 =?us-ascii?Q?ynpvCKCLirngSFAypxoP2zi/p+6nzBRo4eHgbQ9Wm4+G+hD0nnlCJavs8eq9?=
 =?us-ascii?Q?iUwOhLYjn8fdGT1aWogt/GIvlnZx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CXGqDH6GVSClzzkbrQcCgB2AYWI505fyIx3BUEnvOU4HSZBlwmP4jlM/V4qu?=
 =?us-ascii?Q?kKCdFajVNXcVOpAxaPf0UzI61BHqN/TCROChz4uxOP+y7wiQVpI5XCsi1YIv?=
 =?us-ascii?Q?ftxCSniCnlKlIZz+PweqDjDMd6cWPXcbeos712iT0AsJAE9yUTZFctF5GKEl?=
 =?us-ascii?Q?8sZm5JXzgzjY96Wh70R51zWyFQNyMMykVqYvf4Zvm2OtoUNwyxPLrl509RRC?=
 =?us-ascii?Q?VQvzbyJLL4X2KRqGqd9jOO1KEkjmgackf8ZDLRGEFZKIDe0JxBjJGvlwC4Wp?=
 =?us-ascii?Q?Y475/Szk1KIUMsD4urEEB/GWKVof315RVj9GGNxfLG6XLZsh8jHodJXDIr3i?=
 =?us-ascii?Q?yQDBo1sGvqXuF8N1WofLQi5rDhf0EUEdDlfU4WMzfS86kw7gdbAMVFAmptUJ?=
 =?us-ascii?Q?Xrj56FqR+kfu3wB8+ICM0gifQhBLKnVfR+FowTQjf6xSkuVuBdM6xoSVPiB2?=
 =?us-ascii?Q?0MBPyWBuv+kUrOaN43YfKW1jZV28mUd1WfOpgKYy7MCBXDjDS8QtTwHd9Tem?=
 =?us-ascii?Q?81/ZwhQxSWK1A5W8UQEYZiheRTrr3urLnEA05GRCtw7qU+5lUhjlZ8jk5hoH?=
 =?us-ascii?Q?saLLwQVz7DT9umW6pCGX6iMGvpw84c6DxMJsudDT5ciEiVbl55wMhy2M9Hj6?=
 =?us-ascii?Q?ow955/Xc8Mn8AhBTotuR3VJQvczft/itFIS1FwmX0UJUtlVQnMw6NfrKOBXG?=
 =?us-ascii?Q?uqneH/KUiOG0wfM4v6o1tCcIG/gckDkmbMZxchG9CjV8wVQwSO4vgu8l6L1G?=
 =?us-ascii?Q?vdwX9yxAwvOOedrih8Z2btbNzmpXPhLmFIRE3zeZW8B6kRhYRH3i2eLZlq5h?=
 =?us-ascii?Q?USqzoj8wejeYpfUizrvSZ5U3nJBSHhFVqCR2PLHgudulUPzIodlQCYxiYshZ?=
 =?us-ascii?Q?8xXVyjxNVkp8a6z9Nv6Hf3wZ56jI5mtY5bG7+PW5RUm7b3Puvu/nwPSMk/fg?=
 =?us-ascii?Q?pNxNOiYJaWF6jVN2rco94eOi1RGb4ryFFwyFbD4UaSI2wQZo6hhXCgbRH2Fu?=
 =?us-ascii?Q?X3HnpZ5JvbgBvgJ0eJ400GEn435N4Qq8VzSvtL1bQ/CzptiEGmOQq3QiRxpz?=
 =?us-ascii?Q?GUjAJe6Wk2eXED+E6eJxnaLnBR9GEe6Kr7GywC8AmOTmXJNIOLJg3bMDqYpL?=
 =?us-ascii?Q?rCKVK2Y+/VznxeeAeL+EtU555cQdt0mjtw5+wvttG4WW1sP9OdRHeYYdIme7?=
 =?us-ascii?Q?gml0/KI2J/YeoO/fEgw1gEr4Qhaji1E46zyh0d3q2B+iRIv++ASw6juLrSH1?=
 =?us-ascii?Q?d9kuAF/zJQ7zYoEE8IYwT/gp4jndaNQdgjMVzQez6oKbADjKGgabrARcXXvU?=
 =?us-ascii?Q?m9K8daAp5XcQuXGKF7Bq/l6EgIRlcB21Pp3Z3XkOZdvWUWWxiFTkHrQIJ4bZ?=
 =?us-ascii?Q?WDtQNDO1Kvv0+8lcQC9DfM5F3PliwGuE5RJKFINMyo5bgkC/eZPNHJAZ/06b?=
 =?us-ascii?Q?eExaPFz8etmMX0g+bO4k3ZNS5q8kC3+m+n0cxNIyS9ds/aq1XrMi/vVi4ZoF?=
 =?us-ascii?Q?jv9qlh3P1AKBk1534jmsgUpCNQiJhzKGqlc2P0N8gRw0hX5BqGgTBxu4aTe7?=
 =?us-ascii?Q?E+JvjDEmUykyjYvSukNMTUFuh1/oUHx8VeWFQQS9rSNOy0m18UFT77JfyTbr?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c9978c-a0dd-4d39-0b99-08dd5ceebd63
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 20:37:40.7069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIm7gyDmgJmsjWZjtjc330uHxZKeP4O1QOat5sBJG2hWfsIe6e1qbifBlBDqQ6bVY+9t1TK+V/ea5hzOUnd/Mxw2vgb6vEXxTdPNP9lN/Zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8528
X-OriginatorOrg: intel.com

Robert Richter wrote:
> In function cxl_add_to_region() there is code to determine a root
> decoder's region. Factor that code out. This is in preparation to
> further rework and simplify function cxl_add_to_region().
> 
> No functional changes.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/region.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 7d9d9b8f9eea..70ff4c94fb7a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3416,10 +3416,22 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	return cxlr;
>  }
>  
> +static struct cxl_region *
> +cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
> +{
> +	struct device *region_dev;
> +
> +	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> +				       match_region_by_range);
> +	if (!region_dev)
> +		return NULL;
> +
> +	return to_cxl_region(region_dev);
> +}
> +
>  int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct range *hpa = &cxled->cxld.hpa_range;
> -	struct device *region_dev;
>  	struct cxl_root_decoder *cxlrd;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
> @@ -3435,13 +3447,9 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  	 * one does the construction and the others add to that.
>  	 */
>  	mutex_lock(&cxlrd->range_lock);
> -	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> -				       match_region_by_range);
> -	if (!region_dev) {
> +	cxlr = cxl_find_region_by_range(cxlrd, hpa);
> +	if (!cxlr)
>  		cxlr = construct_region(cxlrd, cxled);
> -		region_dev = &cxlr->dev;
> -	} else
> -		cxlr = to_cxl_region(region_dev);
>  	mutex_unlock(&cxlrd->range_lock);
>  
>  	rc = PTR_ERR_OR_ZERO(cxlr);
> @@ -3466,7 +3474,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  				p->res);
>  	}
>  
> -	put_device(region_dev);
> +	put_device(&cxlr->dev);			/* cxl_find_region_by_range() */

I would not mind a DEFINE_FREE(put_cxl_region, ...) to automate this cleanup,
but other than that:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
