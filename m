Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB89928A2B8
	for <linux-cxl@vger.kernel.org>; Thu, 13 Feb 2025 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471647; cv=fail; b=NaPM032Z9H0TFR0I1pwVbQ3qJGd8GBe+JZQqPJDW5w3FcWNvZw89TSS+rbOYKodokutzQtEbdRYsXWY0q+QVetULZF0rK3jSXopppaN3s+EwwJg7DffSd7wMpFb3aQx9BhgHOpKuDxL0KAGxQms9VFqt10dpY3V9+kSsqneowns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471647; c=relaxed/simple;
	bh=/+ntcXkgSnRMdJGN92kQQKD+NoazD3NyyhWgWTJkkhM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VLl5SmhXq676hdPxcON1+XQxwn2hT2RwMWz8iQ8WGJ61+e/47Wj5UFFe9pFgeT2UlPtpq95VZ5cQbTOymj/wVXnTO/VG3tYWllrZtz++ahjfiawLe1NZl4gzvA7s6Y3bsLHxOMEzHpf78/WlubbRlL+6KKo+iSEhUNCOTkzSAcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c0VVPrye; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c0VVPrye"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739471646; x=1771007646;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/+ntcXkgSnRMdJGN92kQQKD+NoazD3NyyhWgWTJkkhM=;
  b=c0VVPryeIu65xmaaVtp+VjPsI3D262NwsIYx5Y0x4esVxNNe9ePwVFYy
   5L4G9xi9C11BYc7+8DB53iPp0OYf6OveC3JDoekOs3G5u0PFm6IJwx0Ed
   GgAJNvntdO4kYQPWu4jFK+Xs0H4Jx+hOVw44joEd9YbepdTX1UgGvDCiU
   odnWG3wHVvB8kRqnvpsznhQYVwSj89zLUNMHgHBUCND9Q+kWEjteXPrm9
   XD9K5RvSUk/55sa9bGtE7zPZackwAgiZ/mNZW5w4Vfb3bz48nGiV3Xe4N
   fu8UU3En10vOuwqMuNF0lfijYdD+0VJZSCpWP0a72i5MwHjRKDi4u3AQD
   A==;
X-CSE-ConnectionGUID: 0oVcJUxHT0K47x/8upGmSw==
X-CSE-MsgGUID: xOdK62TvSqKuZ/3tnvolgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="43849141"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="43849141"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 10:34:05 -0800
X-CSE-ConnectionGUID: wm2vi9GDR2OqOXqvY0qSlQ==
X-CSE-MsgGUID: iIurIwy1R1OZcK0afN+KqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117857108"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 10:34:04 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 10:34:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 10:34:03 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 10:34:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4tFx3ZwgAtMgs5IAWFllzGnIOSGNvCtqxtonSXw2W8LcFHRfSiSyfE9O1meO6FtwAixoyn+R3YYBOngFLLvAR4pwqWS4mFvJ6AACJHcjhTgJi5xLjZvAraX1hNkjpFODQZjkf2WJPOuFRvwBNRYGlCCQA0TWugabyrbeqKnIK8KgOdkEeWhihoHk+w0klrZLa2k3a7er6f6dqZoVOfJtRiH9qXcQOBR4N0MfscpJ4A8O/ynZdJEVagwVVT92l7fM5AzJWFGdwppJg4ICwkednTyQVNGjU0vjJ+k1LXe3ZU3kTMeJy5alxzdf9KjRZoZPCUJFYceOzji0luJ7+klAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYGJAOSKhuiHCh9q+hHpV1hRwRNxyC4VmX6c7EdHFlU=;
 b=TaIh5OhldMVAjY6j7NL9d08SbbnQ3FsGIWt4+pYLpnm2aG1GLxhPpjLsKzyrCSZmAyYSRdAYyNhvH7uAF7ke8Jn7aqhKWaCFcFZjIeyvtMhS0Avj7dGTLrLTZ7T7nRcbRxRCG3V3fHgmsUbmoA9MINZBlUc9SbqOwcp0C+85qBusiNH0icaZ/jZNE9yaEcH5Oa6OWKtcyAqld3jHALs8u06LXiymEfd2Im5LJCVFZ+ZRu5q8pSmPWOxznnt6xWBrO8I3UTwCW7Fj8caSieO/W07hprfgxsgXW6evkEydMvpvJmegfMGB4KB0kzh26IoXWPZjZDXiOoPTOYcg2SFfYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7953.namprd11.prod.outlook.com (2603:10b6:208:40d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Thu, 13 Feb
 2025 18:33:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 18:33:57 +0000
Date: Thu, 13 Feb 2025 10:33:54 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Saeed Mahameed <saeed@kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <shiju.jose@huawei.com>,
	Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v5 08/15] cxl: Add support for FWCTL get driver
 information callback
Message-ID: <67ae3b12d24a3_2d1e2949a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211182909.1650096-1-dave.jiang@intel.com>
 <20250211182909.1650096-9-dave.jiang@intel.com>
 <Z60QCS6o-3VInenG@x130>
 <20250213153200.GE3754072@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250213153200.GE3754072@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:303:b7::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: f789e5a1-9758-4be8-1a9e-08dd4c5cfa21
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4MvDcTluyvX7Ar5aklYgNjs83+QkuMNhGwipHZ5YxEyfNGtU3qSh+hObfoZ9?=
 =?us-ascii?Q?6RkgnK94QAeGwigNX4x7DJLhb5EJlYnZU0eCfk/+wUbdLCypZypDZM5JHd5S?=
 =?us-ascii?Q?lwIdS1ay33qFsyIkzOjMuUFRURvCNYpaXoHx3avz8chU/1X5GSjzGPpOWfTQ?=
 =?us-ascii?Q?Mwt3g9IYpQVTUOgWNGK4vane2aX3H7DhmyvnBXCRhAzixCXXQCH6auEWb6Hs?=
 =?us-ascii?Q?DlJMK3+lQfNmOl1V01h3ISHc8vWZ6sLMX5Biv/6/jdyf5TZaFzznxrb3x3cw?=
 =?us-ascii?Q?PRs0DR7gWmoyfbReQqrtsFl02umfGqq39WBUL4RDMLvpE6pkl+Vvg90zQ0bN?=
 =?us-ascii?Q?iZnl7BVS+40GzEfZ89TVhDHv/XbAn7kDksj360WQAmww31YFkTyirBYjq1Ah?=
 =?us-ascii?Q?r2aeTV6uZeg3lNYCiWozsJhIX8ebNaA42F9W4b5qRLX2iM5UmlH4wms9qFvj?=
 =?us-ascii?Q?LQYuZKmpNy0eif0KccO8Qd6UHQCGgrxtNNAaGG78EnSwQ/VLH2p2dGipqw+Z?=
 =?us-ascii?Q?02Db3dlQiwZ5yy63klnckXXjA8KVVsGBjdWfRM4D2H2yzeyV34X3GkVfiBeM?=
 =?us-ascii?Q?NZKMR8w7NVHzO/UKdjX5R42qJ/NZI+TDE6Yt6susVlNI9mZMQpeejU1R25jn?=
 =?us-ascii?Q?y5/tZSv3IGRIWgU0O0ptKzzkIjve6P8LX0VRT5gZG8QOzkHyTKLZXdFcC08D?=
 =?us-ascii?Q?T66Mt26ovsmyYJu2xPFjbzFZ+lOLxIaJzEJxe4eRVQ1+x7YiPDihGoGWF+J6?=
 =?us-ascii?Q?wQkRe5bNEPdzZMZ2Eic3KqdLZ3Mk+zo7gAO349NiFrVX+jRe8YUwd289KanZ?=
 =?us-ascii?Q?QTui9dxYeMNywiqWaNofXy7ldWwDt094EZuBxlC/Snu1RkosxUntqWlCH3HI?=
 =?us-ascii?Q?KABfg3dHa6O7EvGqfVJgcWw63zEs2HcU//799JJjD4HOJzr58VHWFLRJKP7q?=
 =?us-ascii?Q?jQ8G0yr2SeXR8dFlze+ptxE7/a97JoP7KqHy5Xa9npS5xM4tTKTEM+ojApDp?=
 =?us-ascii?Q?h8Ly1c8QQcyG6tDDCsz7jFmpA9UqLN0KbQ6Kx0r4aIfvpm6YW4AQeCoI+oQa?=
 =?us-ascii?Q?+iwIJi+6e/aGUUNsgMFq76l1REBz5RDgWCfCIZqPxYiDsaRDrG/tKavOm8IP?=
 =?us-ascii?Q?7miWLfjQVul+jw1QLMKMTitRmJfZ131OJ2BpfrkGr2GB3gbFXUavoYaUeSAX?=
 =?us-ascii?Q?mh/9AHPGG4YyCNkjYc+kUHXE6J4ic1LDmij2URD9T30sYp9T+YV0AY6sHxjP?=
 =?us-ascii?Q?8ZRgg4oYFvRpprPr8oYetMGGpVnPM+EVS4ontfm6JHa8KGXZeVSlYAcP7dgB?=
 =?us-ascii?Q?cEN9FTWDFFBqJhG1Tt60oJWtzcg/YfzNdBdb4YB3RGXp1jeASQ32NbjJ5mzd?=
 =?us-ascii?Q?S/ZIiC4i1Mp7ydvkUgWBhvS0pFIq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7FhasskFnhwGupFuSrAgL9FUabP4FWkMYSZAyCiMWqBTsnq3EMW0FRKKDW8g?=
 =?us-ascii?Q?n/ZLKjxuFHkXDL9kkhHLp0nIGqjPY7GgFbvaiT7dd6lInAj28sBnnNTYzsM4?=
 =?us-ascii?Q?neBeSioAK9bxbBIh3cEF8XAnUkXxtLMmuSwxHygsiZ596vSvxKwvTixBF+TO?=
 =?us-ascii?Q?OPrisVqoPrNH2FgmHG+xf1Dwu+dRu84+NicHOMZ8zHMMEkIQDWnukkHm7kpd?=
 =?us-ascii?Q?+uFX5/g6c5CKk4r4Wxi5NO4iPeJI0rG6iW6mkS5sBLD8vun0kOR0DeoljXTC?=
 =?us-ascii?Q?lzw4fRnFrDirsZhrSvTLT6iAEVXHHiUuK4wEdzWhkps+lNKizhoHQR7mKIyn?=
 =?us-ascii?Q?kwGXjakk4REebUnLT22oY6nIFJ5vXTzx4PajQ3NH8aOAJjS0fehvCsXDUUEj?=
 =?us-ascii?Q?uAqFJG7zBuWuPQexPnZz8vvu/aD3jQW2mqmPdAZySuQviKh3rL3b0qVP8VWt?=
 =?us-ascii?Q?o7dgf9L8vBagClXKJB/572ibtfqf7Kz5YaCdJPdeRiPhWR/ZVPyoQhOnK0VD?=
 =?us-ascii?Q?zaT3KKUYR5h/GTVM+5XGaLrzRYu/BUSVto418u+ZL5ZhF5nwC2JhNhpK7Gha?=
 =?us-ascii?Q?ollNI7vrW0mrot1ekUPV7v2QwDZhgWUdx7TPg2K6I+UCtRzMzmM9vDema6gi?=
 =?us-ascii?Q?3jQG0VxdUgZOHy4SgEbNzrN+aRecwWZLBO/JfB1EFnOwXPlfLjav8gWUY63V?=
 =?us-ascii?Q?+CANfph7/jBsbFufuv3uWSREs+BQKRWLXPTb4pyczhWGoBRY9g73U6YJ3Gv+?=
 =?us-ascii?Q?KTEF4A0QQj5NWakJT26MLEvRCAsn1drMIn7n099FtqxfK8f93ERE7ktCu/Ng?=
 =?us-ascii?Q?XQ2ncf1Pg8HfaktT2rj1qu4gVuodwFiJJmwnJFyUZ76kN9RqsDqbkn6A50Sq?=
 =?us-ascii?Q?zZ9RqzNcD0upLpyYi6XXeOdLXRzIRpRI411cbHVq7moPr9wXcEPIRP1ymN2k?=
 =?us-ascii?Q?j3kh6SbEQzR38dcud+ugp+gIHIwSJoOcl0bvLQoY9eGvjDqVwDW2sQO/Z/cV?=
 =?us-ascii?Q?X0P/VA4BdcGz64ji8u/DAu9cv5uvyNRHHMb61edSjoNUKlf6jtw00d5IQQtp?=
 =?us-ascii?Q?89fbDcywEgSPAfgTPxWJH3X7qpQFnajVOmpLZKH+N9nYivvE0NNz5KCk/Cys?=
 =?us-ascii?Q?6O/JIm/Sz8eWFcEAD30lc4O7KXvwi0NmpspYXXuu7Ggso7PklzHMjBNhSZpZ?=
 =?us-ascii?Q?S3b2xDQBhIkfyzsVUGow/y2yHbbGzSI6ZqPvjMTnbe7JvqD6+bL+YzLPr0Ah?=
 =?us-ascii?Q?5yL6dz/W3A+uTAtqfhOR7NlihpItplUrwHBHUqoC2gAYYttx4i8Zwd95oyst?=
 =?us-ascii?Q?eaihtYr7Tl7+189jNaiMKIeGy6X4/5wvFeRfFyCV1eI861VpW2Bvr057CDG3?=
 =?us-ascii?Q?L3POW+qV/NU/cQIM/WgjnNjKpu3oFdZ3Ickg2RmLRMgZG3WJOUJ6oPzt7/6H?=
 =?us-ascii?Q?jWdah0U3Xjw1QeN6BnbsqmE1ue+ZzKBPK0tbBahFNed+pOkAoZMxFgvpcHdB?=
 =?us-ascii?Q?bGBNU06g8grtOYEXZvPDonUB2qaKtL76jKDe8gsjjEGSuIPBLdsVpT0QYsrO?=
 =?us-ascii?Q?F/YuRvLUsv7k8P7Qtzf2cOH9rDe/0sazIl6+WYhp7ybNicJXoGBCIE3Mnq6l?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f789e5a1-9758-4be8-1a9e-08dd4c5cfa21
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:33:57.5177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwKYHTH5LtrmBU5+R9jR8O6TD7py6BsXFpHCXVWNJhuTD2G5mjI0eygdtRN1VXF+M8FddObgpfNPVXb8ha39Q13Tx6lw5lvsXEP4YDmG5wU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7953
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Wed, Feb 12, 2025 at 01:18:01PM -0800, Saeed Mahameed wrote:
> > > +/**
> > > + * struct fwctl_info_cxl - ioctl(FWCTL_INFO) out_device_data
> > > + * @reserved: zero
> > > + */
> > > +struct fwctl_info_cxl {
> > > +	__u32 reserved;
> > > +};
> > 
> > I would add some useful info such as: num_user_features, mbox->feature_cap,
> > etc ...
> > 
> > Maybe if the callback is not implemented by the fwctl driver, then fwctl
> > subsystem should make sure to return a default info struct or some zero
> > response buffer.
> 
> Yes, lets not implement an empty struct. The core should permit a
> driver to nop this
> 
> Should I add this?
> 
> @@ -62,7 +62,11 @@ static int fwctl_cmd_info(struct fwctl_ucmd *ucmd)
>         if (cmd->flags)
>                 return -EOPNOTSUPP;
>  
> -       if (cmd->device_data_len) {
> +       if (!fwctl->ops->info && cmd->device_data_len) {
> +               if (clear_user(u64_to_user_ptr(cmd->out_device_data),
> +                              cmd->device_data_len))
> +                       return -EFAULT;
> +       } else if (cmd->device_data_len) {
>                 void *driver_info __free(kfree) =
>                         fwctl->ops->info(ucmd->uctx, &driver_info_len);
>                 if (IS_ERR(driver_info))

Yes, please. Let's not force the ABI to be chatty if documentation can
alleviate the need for an 'info' command.
