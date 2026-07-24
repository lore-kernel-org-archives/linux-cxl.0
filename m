Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD983B6371
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jul 2026 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929263; cv=fail; b=cxIKn5NqmS8d572HdgaoUaNIyDSYmm0FI4w7ZedCj8994d+M0baLH84jgktaQcetq5Toy2eMe15Nzq5OPaiRNil1i2fKp5fiSd8yPIEjfsnno074rwq7NylSnEAmjqSA3iDl/lZAVpKHLyc0FRDZp9tMXzRcsBIuaiz3Np230VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929263; c=relaxed/simple;
	bh=uA/gvPNAwEZDQBIFHMVPy3f1Yah0ne9+YpNWNv36p7c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cYKj6L7e5DAPuuGOoY0FiIqnPlOEgJEGbvyieDCyHUqWsPYiJErzNRCgaTqaz2AvQIUgWHQs6DyFaMTQcZIjxBcCKwX38ugvbx00hQzJHd6pkrdZn+ZvIzDqKHt4GqgPYDXLqK/YuWGLMEIKmcow+/rw9eO8kuWytN3GX/3cnrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b8ibO0IC; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b8ibO0IC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784929262; x=1816465262;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uA/gvPNAwEZDQBIFHMVPy3f1Yah0ne9+YpNWNv36p7c=;
  b=b8ibO0ICDRa7Ij3jq/exy1VegG7r3EBREo98oRsTnG8BRd0m3Vm9fOrW
   KldFa/lPECxbrtQsrBYekopnSC7vuEdoOGtOyd/hzAjBhDhrNjvXSa+dv
   QnZls67nqTINcAl/NO4dXfSWJfMO/9YMecdj/VnLZg1r/6185UBoCkk0S
   R1tLA4PBqYMPjpO4Ksn8VOnfRnc+RamJFMvGTJaiUJdvC0ulaPRTMyJOm
   ZQNr5RVlcnkeRRe3+phHYnSKoxSlq9KLg2fqz7zs778K9ZFIh71uK7oG2
   9nsAXJzy8lOdh14u8k7CdfDUnJVDXb13je4P7T438cE6xhsLO+rgIZ+au
   w==;
X-CSE-ConnectionGUID: AhCFkWNeR92ObuWzV+WKYg==
X-CSE-MsgGUID: ZeEwIElUTwC7e+tIdEdroQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="96752236"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="96752236"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 14:41:02 -0700
X-CSE-ConnectionGUID: rNiOFHB/RGCeKrw1qj3d4w==
X-CSE-MsgGUID: L5xQtVDQSO6lNPoE0rDq1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="257049086"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 14:41:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 14:40:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 24 Jul 2026 14:40:55 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.40)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 14:40:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCPs28bWPFPYpUjPLK8UEW27nJdKPLTH8sIDFCRUeEk/tA9jqtDOAROViG6jeaHtpdThRvACbPHL/3/je3P7ggco0s/Xg04Gjwon4qE9GM0g/0IMbEL7CsHUxS74SnFhkl1AobqMRn904k0/TKWmxhuEtObDQl2sJwgcS147smVmMYF0agHuAgFGPGiC6S1yhJ9vrjlTDd8f9Vp3Ta+M5mwO5gaaGqyUSyUdkXD9RCVF5/UOVDRMRRcQMv2rPuSYdThYaP7lvzr05EJaS9s22J8rRiCKDjeeQYm5WcdXwqa6WNxeKJw/vv1TsiL2eU0vBA6yiFgGBooV14dTdelihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpVgdUBjKgIYWFbRUOWxpBbnOQ97fuDe9eB47yQhs5k=;
 b=fVJRxL2zPAfZHn1gzQ+c4pXHDeu9uVkQ4LvQHDBnGCo3c/CfNQfYEZMvN5KSZYA2pF5UpRHS/s+0WPxL2J3LR5yhwCEr8qhTGd1W+LkVjLyLKUgInaZW6DChFtyzCDqIecQOmz6phtbysT2lRDXwdOlP4Q5zHrY/oSR0aMUBvnZuscpnzLfd0gJ3cNPAEnq4+dqZ6f1EK6+En/FgWl58MIGtBk88NPKiq0li7N2CyWQ0L9VmUV/XCD6fsTJbkut9QxkjpYJ4UWu/43QBgopo6ss5oqUv57RbsC971u+r78lEH2vx874b5JQxESGqZ2q/PoxJHg/K1zMQccMWg0yzpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM4PR11MB8090.namprd11.prod.outlook.com (2603:10b6:8:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 21:40:53 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 21:40:53 +0000
Date: Fri, 24 Jul 2026 14:40:50 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] cxl/region: Fix use-after-free in
 find_pos_and_ways() error path
Message-ID: <amPb4js0Vf9-gK_E@aschofie-mobl2.lan>
References: <3a36953b5c665cb9544ba61dafbea0b0fa508c77.1784654628.git.alison.schofield@intel.com>
 <20260721175033.0B0D41F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260721175033.0B0D41F000E9@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:a03:331::22) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM4PR11MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a77db5d-d809-44f8-227d-08dee9cc3c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 89xt2ph8X2FikUdZyS5Rw8/U2B/mEiyVig+SBWPqyDxobcRh41TdLBJcfF9P00UeBu1+sZ9KEb+mlTZS8hU0AgXQPclVDa3ATPcDnn8aiujcj+I8OU+UCXRKZLUWXr97rv/bOuoFQHPcz00XPMWC7HqFAoAxkB5GLfwU6BsThOwqS1HVT6uqJknW+YK9Wcq/t3BHsorJlPeXVREm+vD/XUz786hDEW/Gn7P72QuzvbFAHGg61Ghv/vQXXmTcmujDRky1ioCEf5OB3eL8qIxW/LwCcr2Q24qBIemgPoqdJQHJqylWg0EnHBtgtL/533u7cicI+fRP5PWJXo6trxDatnPrQFs0we7NvsKnQPKEJV/f6DaxN5fMn0GLCnTGFDf7fg5lFvzJxHKVGrDP+b9gvRFsJV0nZULyHSEjTazqqHsRNjisw+4ggJ3cme/0n+vX8li+F+mKdDuaRHVhaMfPYYLEeUhjFMFPYaYiljt9qhqhJoMXMv01nZ6wUTlEvhiAwpDd2tXPjrvK5mU5abjeXSSlWvm5mpuR/hBfxOXaRPw1/Gf4klAFTqf58gp+al5d+bKvhZi2Y2DRVFRToVFjjGkvC2FZ/oXNe4JtuVNnQHhjjesavZpanRQaRK1B9xsJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x4N+dsHbHRUxNqWd3c8n8rLfmG5dQRWa6zXpPb5SGForsCIMpJV557hsg7+/?=
 =?us-ascii?Q?8RxWoVmyVbrhptVlMqvPKbwTUxzI/67d+IAqYXPqOX8uPdJ+5ZIkTU+gONLD?=
 =?us-ascii?Q?o/XJewgyK+rs4yr5aLES9Zc+KZ8NrqmdRrzrJcJINXmhGcY0SBa17vsqrj7Y?=
 =?us-ascii?Q?QB+rGMXl15OOg9Fu+w4XGBCx54uouNH7iKYY47s1eSQptbX1SMBSyqHUW/c3?=
 =?us-ascii?Q?1Ua4DAGA1E4FWV7T6BFKDWnZqt2+fdO4darxnimEbr2kU27OffX/eeyyswXd?=
 =?us-ascii?Q?w9Z7iDqW63Zf398GE0ZiQgvp8W0uNPXyNzv5iw+lpKmb+L3zQ6AFhq0UoINy?=
 =?us-ascii?Q?hVGMPdufDb1ONle0Cr/4e9zENA+CmoBj3a9K8srwyXvdIP9EpW06T/wjLzuA?=
 =?us-ascii?Q?0Avc0CtS6RwqOePIRZ8aCleDlIyZNmqwrXIIRNfXufe2uUScnCwMJnKKZNfY?=
 =?us-ascii?Q?lIfJrbxllSQihqqN9Uj7b5elhVyPyyf818yYmXWuA3Nw6t8EgWyhbRqkrVX3?=
 =?us-ascii?Q?lRDhPnzN3z2NAPWS+y+orNcLObtHi8GVeMleq0NrSveMsnG5NSEN2KsIIubF?=
 =?us-ascii?Q?i2LZHkMvUaO41JCS52uV5F9XRIOoLR0E6DTsIYUOmIK/6Uh+ekaPV+nYNru1?=
 =?us-ascii?Q?bGHZsUFHmv4uZ6eZ5aDqKo6GEDtuWjeLc+8DAHmxQGpoFVTVH5ufJmYVxpiT?=
 =?us-ascii?Q?Y1lFNBSnrUYmCjqViS6PkQ+YbswPlB5YQvuNCIJBRnFAkDo5AIxNwsR9PDfX?=
 =?us-ascii?Q?LC84Ff12z0n+Hi5J/LREaYJrd2D4DyIXsQm7vP79k5diLTU2gjsikpKCJXZq?=
 =?us-ascii?Q?68JYeORl1rKKR/L3xGtCLahiI66CTigrOe3pwAUQpKID4RV9O6UiI9+m3wUc?=
 =?us-ascii?Q?C3rO2D9Mgfkg3R/osF7vEvRPiUR67Bg5RUri+B2i5X8AXtUc3q6j+x6DE2fY?=
 =?us-ascii?Q?IMd98K6j1gjBVjj2JNRXlhxP5yEiDrhBBMSvDEa/bntMnfuK62CS9qM5XN+7?=
 =?us-ascii?Q?AYu+GVcxiUU59C4tfzcSe519lVjM2U0A6FDrDDtw/gAHjMm7u1VgZZ52S/dI?=
 =?us-ascii?Q?BBpJFJtN9A7n3gBzCZk1LdiFNgY6f7eo60LyepGMX7Z9eG4Lh9hecauBFbz0?=
 =?us-ascii?Q?FUEWXmso2zewEutNQVfbGwAo453ssG38cIWO0uxxPbeJuxb5yRdugETvUsuu?=
 =?us-ascii?Q?qGyllfTz6ELO547VEFdxBzbrhGQ94WU3tCGZ2ZBMT43d1l8R1JJvdbARLMSK?=
 =?us-ascii?Q?QCO67D98788Qj52fESJzHSREpoyHhsN8LYqUwFCsydc8zd/t7HcqsDr72iI9?=
 =?us-ascii?Q?fkxnxydymHAL45LPlfHwMF31/yD8+ciPOzONMzZxGaKx8ORUyetLXyht3vSS?=
 =?us-ascii?Q?HaDnPnE59rqufTp6WBdsG124Vokx01qS/jo+vJse/AQgDokrDxTIGQS6Txzd?=
 =?us-ascii?Q?UdXOpr6OCc5sdJU5r42/d5HvjJz5e1x5brly+Axf9SXWHiwikZ0gNK2mc2AF?=
 =?us-ascii?Q?FQJswxxugZzaRlxftYaWrxQBn3oKzVjBLEg8XW17qX/VVgjCGieep0dwnafT?=
 =?us-ascii?Q?BNBZMwFXFRnCKzWuVQX72vO5Uu7qQH9b3aJqvxhE9QDqOS5BELG8+OfPXWAP?=
 =?us-ascii?Q?jXAph+0ESDdK7Us2M8SF138T2DrqLbVDXYK9ehMbl1EX3pZzAYgyNubnE5Yq?=
 =?us-ascii?Q?zptoSz4XxryOersyi2FOxfcVMe2PFTqXEkWS7HyCe1kXfVq8DkMnzMLHwdX/?=
 =?us-ascii?Q?c52dcQDTP4DsUc/Q9aWjf2I3NpblLd4=3D?=
X-Exchange-RoutingPolicyChecked: SBMVMl8EFfZHCCI292H3TKR5G6yzqp08UYWlMmSGqAjH1Ax/9xdknxpZ/Buo5J2lFBw19jqxT1NayVJDMnHvB2jWyL+gk+6k7OJJAz2gkOVz4l6DLkVPZib+AAbg4UxLtyzqGS4eoIwY4Z3OWr7O/F9rZ/gOU+PX71CPAAAVRqzIbZe2+cBBHDJKicqmm1Gl292ez8gjJ2xC+ksobZFINBDv+999qjzq3jfr491Bl1k2hbAB4sT2DcUEPgj9tlKJCi557XnrbKcaZ/oYKhZfwGWLGXmIsMi4EFm7nuHF/mO4B7zdhZEbOe1i8gMut+x4K9H0yznVGGF/W9C9jag4+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a77db5d-d809-44f8-227d-08dee9cc3c7e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 21:40:53.5093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzYUvRs0ykWkJZT14dHovP8xzHVOn/q7RTa7Ncd3KocdgGMDK72ADR81WWwQ2j/uA1EciPzStKhvg0azuQz5H8FNmXxE9EJid/pexaXPs9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8090
X-OriginatorOrg: intel.com

On Tue, Jul 21, 2026 at 05:50:32PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Hardware-provided interleave ways can exceed switch decoder target count, causing out-of-bounds heap writes.
> --

This is being worked in a series w other Sashiko issues called
'Harden HDM decoder enumeration'

https://lore.kernel.org/linux-cxl/cover.1784595445.git.alison.schofield@intel.com/


