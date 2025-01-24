Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D5D1E98F0
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jan 2025 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737760037; cv=fail; b=Ry1Y0J54G5sC3gcrslpvM2irYMHJ2azQ3uaFCTR9MonE0ABXL6OXNebxBDgs6JWS/xSOqLvB83MnyUu4n1+Qu8w+HnRPsc/JRKaHMln+2vxQmyYQs+QWVOfbqoqvDvCWPdMNpfOLQRfNc8DUeivEHrzPuuZJnJP6j/TmlS2rZCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737760037; c=relaxed/simple;
	bh=p9WjvsN/FtksBZxgtT7moQ0NUE8HWgBlQiiZj1AZBwI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ad9G9/xSclzmGQe1az9mzO/Es/wsv33JEnmsnyY9wk+RD9CTV5YY+8ZZTwCu2gvhwaLvdDzM3Mi2IKICC5oFr59LWWz2ms8tGYttMkmnFh/pUQpfHaOcnbrt/OjPSIdtf1grA/rIEn89QeYuIonXXrpuzKsfFGWmp8VcEu09ohM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkQdxmxi; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkQdxmxi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737760035; x=1769296035;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p9WjvsN/FtksBZxgtT7moQ0NUE8HWgBlQiiZj1AZBwI=;
  b=nkQdxmxi3NpqJp+AvS5FxHO2JId9wUJ9xdlCr6o9D2orDgA00dZNgqlc
   5thcnWWuzmKXPY5s7qt5UYPsna4iMS8ZMOEIXaKGyRo4raDH5laQbGMLT
   z8oH7PymeevfIRhSSgQE7v5Q1rQO07Z70CW2XF8kB2xRrJC0J+7KQvUAB
   CmHXiyjIHsyEmlprrJ83GDLPPqOiKl0aP0pQtBkhOYyb1KuqOliMA3b0O
   X8PuGL1Px6xkkNJMy6E2ORgKYxdt4wEbC0wjXRe/UbZdTiqSjJcfR25AQ
   ZyJRQJCPUe2jzw7OG9PAYhG2JsLKij+rAYKv3YtJz5N5peD/XliRAxRFh
   g==;
X-CSE-ConnectionGUID: PywOlrXLR2m4BWlsauW/Cg==
X-CSE-MsgGUID: MNqUIYNzQgafxUQOPA2NQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="41971739"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="41971739"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 15:07:15 -0800
X-CSE-ConnectionGUID: hPxaREqHRcij91heZCwK3w==
X-CSE-MsgGUID: ahrnturBRVC9aedjO08TtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108334122"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 15:07:15 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 15:06:07 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 15:06:07 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 15:05:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pH3hNRHOBRh/DTWWqUZRC/1q38P23VrhMx0NBD/zVJOHkv+wFiB7mfwDgG2sBZoMy/YJTimt6uRTwj3PKC+KiGB4KpwTp4QAgSCtzM7ESMcD3poORyExoGMnYvbldljxdXAAOzmrHoP0xDjwAARLO1Ptldtzo7Rp/hVWZQ2ApJ4wj2uGxYscPjOdoNklWjmEz5pbWigKlmKBNd9XZbFYVJN9IW9hgP4xzN+BWO+icYpQp5UOqnL/gWO7P0baQ3AjWS6dxtHMShoIHivEp1NFELu3qQ1s851y3Vsh5QU8DgEaIX8UQXC5/mxDNJe1ZhObWaQSVZ4b1fKQkTcT4cepbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lt/3HryfZv9YqRi4KtLokNCoqt23rI3FA96gJNDD8RQ=;
 b=TXK2gsx38vziHQOVgPxyabaiERfU5DyH+LBXrNuzZXnC+giB7nYmWRpE8XRibaA1BlNmRWwCe1lLwVZQhr8kEP1RvVNgbi7n7rN/ZVGU4Z5OIJCzdyi396rH+IBkX1gUrtijzSwTYsfIpUMlCHoVMdWx1bxSUKEQ4UV0mMqJ0JtVQRddsaSORiNE0NkV0w++djhGnGQKWOuYu2JD1z4VOmldDyTnlMZwzDW0roNjqcLYqnUD3hhWh5GiBPMTWyYALsYxtmVGlO5/ifez4r0ftvPH7FARXITPxetXjqnrcz+1iFff/ocg+SnikkiL74uQl3N7p/p5KyXAD6FDaDspFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6751.namprd11.prod.outlook.com (2603:10b6:806:265::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 23:05:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 23:05:54 +0000
Date: Fri, 24 Jan 2025 15:05:52 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 09/19] cxl: Setup exclusive CXL features that are
 reserved for the kernel
Message-ID: <67941cd038a2_20f3294d6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-10-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250122235159.2716036-10-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:303:b9::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a32846-f2a2-4f2d-737a-08dd3ccba7af
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?InSpkaHS78ZsP9bg2GtSPxqj3CZEpYSGh9IHhg0C6sVBeXQN/lATm+bZfqpH?=
 =?us-ascii?Q?u6DzIJaqfbOxsbzN0EXqy8E1ApoJHzMS/oq5CLsQQsnvk8h1WzL3IjFa+FKH?=
 =?us-ascii?Q?Zx93jS3r2cB0om+lrnf2ie1oMDBODg+O1J1+MXfO3nb96qjDRSM59q052qgS?=
 =?us-ascii?Q?CoXxHyzkS8C7HVL5Al7y2ELIeeAy4C9bu2vsJ+FfDrMaO4bS3sz407Zu//IK?=
 =?us-ascii?Q?Qbry+bGT5Ts6TBhMT9uRnFxi/pqj3WH7Wu2vrHyFv54vAiU2XKh1CeiArt8N?=
 =?us-ascii?Q?dGcZ/ceHdGWasalfoQJ4I5YFqVHSm7VU2XmEhS4H3+5sMKvafP3hxTPG+z6M?=
 =?us-ascii?Q?PA3bPkWdKrLfMoOahSCqn/FFEOh0s/3Is67Ukhzrr6TlgucKxhTho0UqTIUW?=
 =?us-ascii?Q?KtLaHBW9k1eg9uwJJcO1EWbpdHpzWc0axlA3OQ1ioIZAuQNCsPenWgv71AVp?=
 =?us-ascii?Q?mFkUmR9zMBdT5XSyVn735Gf0kshFfJ52t3Bwuzvg7afdkJOXmF79qCyY5Z2I?=
 =?us-ascii?Q?Y8pKyxkGVUPHsN2gouqVB0nMHvZrFGvK/mHg27ZfPrE/YTECuEklPtHsje7Q?=
 =?us-ascii?Q?HYYNhehzEaFhnyogzgPDPBPwZtAwfUx/aCLOepGNvVhoWHfkGNqsBtuxGShe?=
 =?us-ascii?Q?/RlkycQNT7aLTERogE5FGnTjvV8ie3L9Cu7Qn6dcp6IH/9cX4Wv7mRXSRehA?=
 =?us-ascii?Q?B/OURy5Vp984Znf/XQ6yiWusjUvrYeFyAk0r/Pwr9Xj9EvfIJmP0Z1x+OR1y?=
 =?us-ascii?Q?FpEhBz6MQZTRuu3tsZNGETrWDoF/hdQHoH5qJUfflvayCtJdg5E0ZBBfhvfs?=
 =?us-ascii?Q?FUIWuvjoX8b6t8EA96PMbMr+FVU99JYQza/C85Hsuc3kqFj+8470eDg9PT4o?=
 =?us-ascii?Q?uXt0kpwrWmAvbMCRxiwu19UNaKgHeF0rrGLffzD1h92+/HTqho2rwbPNSKTb?=
 =?us-ascii?Q?13YWbfSUwAtTP48mPEj7nTAWIUptFlQdixYp2AJCJxCRafnRj4PG8I6/7uc/?=
 =?us-ascii?Q?VZU/2VGVlwM09mLfrVjYsip0EMdKzQllLTD9WDhAX0OuRqQkuJoxsXtlp6h8?=
 =?us-ascii?Q?+ng9izZT2UCX2wUyVmmM1vjS+Xy76mrnxDELGSeDTpCFTKA85o6syWH5Ttfg?=
 =?us-ascii?Q?WetAf8yPPrshtUhPmvLpNxs0wKFn/6wYnVgOLWL2HPo803KKr5kWHwLsyBdh?=
 =?us-ascii?Q?4b03sMcmB59XaEjF2hAH8V6zAL0lp7E6xy/QdCElDKjE3hm5BhvmV/IlLhjJ?=
 =?us-ascii?Q?B8vM9M+q+JEodNEbPA2wIRjRv0fylRMEX10B6JH3pfjA9PM2gJIzOF48aXwF?=
 =?us-ascii?Q?A71uAZXD2g27TlUx5AaD/6WUq65dpBJqvG6jE4nSmuR0hXMdVMB4XeUswgV/?=
 =?us-ascii?Q?86UldMEHCTCfu0Dg+wP1kujjxeqe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u26jPODqdedM1gTczjv2R3QYRANK3/QleQs9lwnUlOk1yhS/9amEoPAFM4Uf?=
 =?us-ascii?Q?4vlrVh6WsjQ/Snoqmj5bTjh3dOxlI01OfaM5O74OGGIukZRy00XVmzZye0bN?=
 =?us-ascii?Q?jx2HSg6wzslOB333Q4oyKK7DdPVd5mdgWUtBN2slRMLQ9JfOizEwSauzWgS2?=
 =?us-ascii?Q?wiJ1VtYrm6e9ASAorwMVIxeAzt17fFjBOwT/SXltulQbiKihHWftkHMgd5fJ?=
 =?us-ascii?Q?KAtF3GuY9UaLepuEe6Vjo6WKrLPJduSCAKeWu0KM4OOW9U4QGdzUaq/dze5S?=
 =?us-ascii?Q?qp3phCWEJXB+7b9HFr6zBkXWn+lZY195t16HxXsFeEGG4Brv3pWbl/rurHzM?=
 =?us-ascii?Q?8LNxCMvmYhl72V6KQM78StAEWJue8rtUj4SbhEkxm5xH7Ja2g5ctLY2QTSL+?=
 =?us-ascii?Q?1L8kMLpU+Tny2T9/CDkwqusWbpv5IbykriT4RNkY0Euv8/grgoGvf8/hUgRD?=
 =?us-ascii?Q?KgxmeBbcL4ssYCf6HJRKcMCZfrNuo6PQprEiWq+J43qlI7hbAZAzxT02boAf?=
 =?us-ascii?Q?ToDEIwq3FEmJdvV1kJ1w7OehNBa6DgTiH7ArtsLZNuWdJLyc736yiywt4WDS?=
 =?us-ascii?Q?lClUdzyGESArSxjOh6C53nd8NL5HXu31bb6boNmMk3TLSpE/9TNuuriniTKD?=
 =?us-ascii?Q?+Pt8U0FeQuulBmfL3mt/Zq1APttU/mdB/kENLVjsV/D1UqKVzUDaY8jiSZV2?=
 =?us-ascii?Q?Uvfp0otRVZKnXwxsLQ4agM0NzYaOoNdbSwddWthZkK5duqn7g+A/tGPVvX9S?=
 =?us-ascii?Q?LFvqlUPyX5sf3ByNh4362hbwQuhI/iEnlvasb83ZQ8KyJhracljwTE4QG6cE?=
 =?us-ascii?Q?5unWktiPxreU/mH8ni9zR+Atv9SxrY1btPErIpq136gStqWCwbb+UCOAcPaQ?=
 =?us-ascii?Q?98oNxL/wkvdeVTVMI6Ukv5KXMIKeJSpUx97UFN7v3MvkC9p3EVOLVOd7W3GO?=
 =?us-ascii?Q?A9p+0UB03LfORxFfu9Ifks9DZDFo9yTXxDwfZCifjS7tvqzxGRxlvPHyzksA?=
 =?us-ascii?Q?NF0W3+9VXmHHYyKnDEBWhhmAyhKs6Wv3ecUpwmecL1L3RLVNfvQ4lUXWMC+M?=
 =?us-ascii?Q?xg7CsaOCZKRtfwBfRemVzHRc3IS1A1vV09PWS+EdOosd5JP0wDqOpdY/jRLu?=
 =?us-ascii?Q?ahVCiBPUEYfMiVEHSM5KGxISqkiGTRGMSo7P/R+fgejgCyikOa2JwnaodaFJ?=
 =?us-ascii?Q?7xOMGuxlZfOQfLLmqeyDpq+cLiJ9ZvWjd/9JY7BkpB0cbXbLVeKiH/n+VDaR?=
 =?us-ascii?Q?oeeyebHlSLEv4XP+UKosX7VpKBrbCLJUyIl9/I6KimNj5Y7Vzab/5CTsTbSU?=
 =?us-ascii?Q?aKlgKP165CCBKn5ik6UsNkrncTp4PrGW4JzcnCBV8E+368uw/LXa/V8HoaMp?=
 =?us-ascii?Q?FsNHQ9+bmE/P0q7cdfoH+o5xal3MOacSqtRfAnneXzn/OXzlw8wwnP+zYZg4?=
 =?us-ascii?Q?S749cBRj3gmNf7q5iusBYOqNVY9j6PCgVZCHsW/ShyNZlGkAueTcUAKHwgHd?=
 =?us-ascii?Q?p44K6mLCyZ/URMPJ1/Z2mvAw7HWScFGD08LM1EWQFEvyZmaJKQQ9Hoapl8Ke?=
 =?us-ascii?Q?lFt31fNv455BSL0ivW4hnSuRJ0ty+tWKUX3pP7ItRhJgXDVF3+RV7CQlY/mI?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a32846-f2a2-4f2d-737a-08dd3ccba7af
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 23:05:54.7022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjBVyN/KURx+zTOEdmWqzQjdCHq1zLgWgiW2CJECFySYS0qGy6heozQkEyEAWc82fFThhC3QUNX+HaHcLY9DVJSd+zvKFohO0hK94MfS7GM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6751
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Certain features will be exclusively used by components such as in
> kernel RAS driver. Setup an exclusion list that can be later filtered
> out before exposing to user space.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/features.c | 22 ++++++++++++++++++++++
>  drivers/cxl/features.c      |  6 +++++-
>  include/cxl/features.h      | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 61 insertions(+), 1 deletion(-)

LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
