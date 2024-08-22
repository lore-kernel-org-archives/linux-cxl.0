Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5266312E78;
	Thu, 22 Aug 2024 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724291037; cv=fail; b=VXS9/TTGJRDu4bxFdEUaURsDsH3Wo7msLn5PPkZlIWwsBaJuQIRFAmLtFENhXi4vlIp1nlyoQtKUzLnsAZP1bOC/fS9WVei2OdYyO1zi+sfUf2ckA4dZdQskC+j6WCF75FzsoIUFP+6M3wFI9mR9rzBpp+N54IncTag7jqHKQXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724291037; c=relaxed/simple;
	bh=2/zHRFGpyfoVXE5AejMEH0Zb9DlWx/qgeXMWqXeu6TY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bJmD+lyGxWrEa9bdqYgw0jfzo/Ub4mNcca6z1NAYxJYDPkfysuaNDrHPZA8gE+EY7SsE30fs/E8Cm0Z3GtPZ4w6/+aQWv2SBHukal4xKT5WOh2PjVxvo+2vJTP2ZK16DZ14wbHHTTe/XZi+9/jM3TWl3UWWVGkiIsD7K+mMx8bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5OWBMzG; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5OWBMzG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724291036; x=1755827036;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2/zHRFGpyfoVXE5AejMEH0Zb9DlWx/qgeXMWqXeu6TY=;
  b=F5OWBMzGzrXvl+R8zhiZiVzqp82hvhhs2wPg0l0y4Z8z/Bs/RcNfBmfe
   B/g/NVARnRsA94fo7CfmFACtiN/LV29Ntu2UNTu5/5uMJpn9bXX4GSX7v
   kr9vVNugNZ+L5KEHqH0VaqUB2a+X0n5DL8InuW73DYXm+/Mlf2Zv0hg2/
   XhpYTRHRu+5+XTL5+Ju2uoE6erJst4aqDb72GPjvIrBiXP17ebJ4fXrj+
   iZNwSJn9rtCch6WTqEGRL2qe73UvSv9hgDUXB9mQBv+qji92ILVDE2il9
   +mScOWQy/mVICo3PamROSXOaYXhflEsuot2jttddT2aDImRNj43y8o3NL
   Q==;
X-CSE-ConnectionGUID: 91bWv4ZrRT6s6jJodcv4ew==
X-CSE-MsgGUID: 0xfATpKgSqm87Du8Np/gYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="34067735"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="34067735"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:43:53 -0700
X-CSE-ConnectionGUID: Fis1+pEvREq+iyNi4TAp6w==
X-CSE-MsgGUID: c0Mt4plsSweJYWH8ET2Yng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="65632336"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 18:43:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 18:43:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 18:43:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 18:43:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMz5sdrsvXQDuBSTUh6PGsRPogw2Jj7CUtZQEmiOFt7bIvRwbjv2hhldvg14VH7f777Q4JBZnnGV2+OxAsqtzDKCxd8Hkf0JZC9jYU4tDvUDLN4RTR4BVwdqnaetmCIRdQtiIrXS2RmS+8Npwrd1VR5GbGSQ1blF/FSALETqOBK43iCiWxlebGoCmDPHfDWbFrUpRlOtFVpfgui8R/otu3yJCR23YdnXBkFilvFiRCuop4Ch++jOrS7BStKxzSga3LYz//DkkLmMfNfd8cAQyGjppmjuVtxzCsjLrLqW0IlB6IkOY3BDmozufRUXMf/VRLwvegqq6VI/NHXmTQDORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1qVu2kDZh7NDhJoGQMl6Ryiug9DBZ2sEvMleZgsphM=;
 b=Yby1mXOevY+E4Sh0Ifo07922cIE8ckrLl0Ay5t/shD/MHpMrjyaTK1KXIoy6nCw+NApdJq3i+dCpblS7kbtjSVToaKIx4+alUMbmVU4IKZgckAzfy+QqNm/8Xd3B29KycKCExcWG74Le/JycoK6WJ9KXy/iyEcPnv6V7oCmxw9M407wfclZliLcBz/MOJgbM9Sik155vUSYFG04gm9rCi+Ktw0y/LomnEZU9A9i/ARI5lhYocQGS36Q1KwTgB7pRfaKG3/yRULOkHhVHe5xjRaluoBLV7rdiquhRA2HC6rbMm/xN0ciO3rCwn9WSaLZ0yHmYt90sc4JMAvBf4jyQ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8422.namprd11.prod.outlook.com (2603:10b6:a03:542::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 01:43:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 01:43:46 +0000
Date: Wed, 21 Aug 2024 18:43:43 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Huang Ying <ying.huang@intel.com>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Alistair Popple <apopple@nvidia.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH -v2] Resource: fix region_intersects() for CXL memory
Message-ID: <66c697cf7b95a_760529414@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240819023413.1109779-1-ying.huang@intel.com>
 <20240821184615.GA262749@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240821184615.GA262749@bhelgaas>
X-ClientProxiedBy: MW4PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:303:b9::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 5389bc2e-f51c-4ea8-27f9-08dcc24bdce5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pXgvvEW0YrPdRmhup979zcArqmpHm94IxM2b18v1kVxMlbFcdKqJPldnZe+d?=
 =?us-ascii?Q?XZLvtj6QAH+dH0ORqvYJhjkEEMWe5FjgMsIEk4usZVr5KHFnTyIVIOo9jcAJ?=
 =?us-ascii?Q?H8js06Tz7mrpyEfMomsIkkc5akBtquOoMT+VojvqB78MPriJccnF9kPh3dRv?=
 =?us-ascii?Q?6vgC7IgttXZnqCCB0i5DAi0CyZXVxNHbKQPCPRQtpmElq3N6cjLw9mPmvBlt?=
 =?us-ascii?Q?uIcsmOpZaefX2ZhkeV/45oASAGtdSaQCrq6xLf2HQUrru4j71g2ndrUdShHi?=
 =?us-ascii?Q?lyzIHAnMhyxxAZ9XLFf/vNQamfV6+i6ni6lzk7yOXjYvCUnlfuBSJeIvdySP?=
 =?us-ascii?Q?h14sOcnscbSBRr9m13wcpdYi0mREb2ygj3fNYpzStrQ6rZOJBYyTC+4EOiv0?=
 =?us-ascii?Q?xGOZeK5nLh5r59Ph1H+u970vtlORhYIA5soSONBrr3f46Qgk8x5S8H2PqheW?=
 =?us-ascii?Q?eeKPs6SMYczXz29ZtGPSvBpI5eAItOe1fHZ1b8JyiVXniRSXaU1yz4KWHzyO?=
 =?us-ascii?Q?Fj/ygFDSycwYq0Q/BLrxpk7eK0VOkTEOmMsAulxcGrQ5sq+FyV4gyhPSgIPV?=
 =?us-ascii?Q?NYvT/I4AJaWwhmnzAh4JSabJ9dDKQDrh3kDhFnAIMxkgfuIzP2ysqgTlp24q?=
 =?us-ascii?Q?Yf4oOccqQHQGZGuS00uRVs7wisqaKGpoKzTIjQtqR2DiY8qavtRH03G4stbx?=
 =?us-ascii?Q?SXEpzzFEi8saxLXa5VkHzzz/kjSjZO6mmv7cT+S8bOjsYOxQ+llyqRxvbIMa?=
 =?us-ascii?Q?imQ6SACeqkoo+QoYCBTKTPfFwou/jhfiF/bvDtaXwTFgZFCKdfNv6/aDok/L?=
 =?us-ascii?Q?T4ETxqHB9DztWzCJSmd/uHtAFw/gefHO093Wg9QXIYoacfBmnn0bMlVuIygm?=
 =?us-ascii?Q?h/huuJej0HlrzPIw+00Q2kW4o182W9My3OMAeJahC66kVlG5CW7GkBhtEZlJ?=
 =?us-ascii?Q?tLaH1JDupAZz4qWEm6Kf2/HXY+Bh1kbyUb9X/Gr7B81nhB45/xc35dS6ZcIy?=
 =?us-ascii?Q?ER10R6b5jNjjPLyBHVfUnQbvxNDlfbDK7BSsvrtuBuO4iYSNITK03436DXKL?=
 =?us-ascii?Q?tVfO48Sysn/HjVxs00eQU3xsBJB1tiNggVRJO3g2aJ2lqDA0qU2fKeGdANLl?=
 =?us-ascii?Q?TNic93QLM8jW1IsIUXUnsS7szBTmfE/BZi6lf6OErgH9lZpDuUJBh/GtcZsP?=
 =?us-ascii?Q?mrnIe6gR+uP4mZdC5a7zJgA2pjS+lC9iX83B8MXMJ0mFbMwDmkJdSAzXpwV1?=
 =?us-ascii?Q?3lIukPOqgxPa9q3IDGfAn2U0wcq44X0pmo0C7rcNyX62GwEqBeanAMoqeg2y?=
 =?us-ascii?Q?5apF5fJJ1JUgYoP+fM2b8UwSuwTsY/Ag3ikogWPhuyl5pQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kmxw3Vvnn1ZgpdgSaCZ38IcWyKFoTH5av/eH0Cbbe2XeMuzDaMs/sPWOLXcz?=
 =?us-ascii?Q?QduBComT8ujtHeP0dRZdfl0X98ntqAlAtlHrOMQLi+9gKzzdxXo+EmE5cyrO?=
 =?us-ascii?Q?IIGTxxS7BU5JeGGoSYQTAntq/7uCEdJxB+kukgZb4AkFhd8RUZ2R72ceAlfG?=
 =?us-ascii?Q?pedaIT1nUvNr5yrEjKGUGjcTHWIZzHvp8XRoeGn4HaEzr4OTh5Dx7wkLfjhK?=
 =?us-ascii?Q?5RMy9hIW14TWpIP1HW+8HxeNjrX3buDbMj05eGXyhn5X9xJoQLqThLEMsHpU?=
 =?us-ascii?Q?S60cWjblSzHTV4SqnNaU/U5WklQ9ymEPfZh1T4PrtUlyeX19zlqHI5leDbZl?=
 =?us-ascii?Q?4IGIRvtCa5qLYRMMWeK9VrReZ/Hy22IdjH9QvfubbzpX7OeOrRnRjZA4DnPn?=
 =?us-ascii?Q?ZpBdEdc/Dkjd+hk2SU2lGzct/ZlQenT/MpyBzEkNvttd5hYIFUMZaztwi9gd?=
 =?us-ascii?Q?r/WjPPdBQ46FJokVh+9ZLKE4MAYJ8LnkDRg9cIv4UKY3Pjml0z7A8Joju53b?=
 =?us-ascii?Q?UpgE3+wKA//N0OP2nVWqK3hD/Ww7nGmfgYOf0WGqgtwzBbOOEVm6xRNFYmHn?=
 =?us-ascii?Q?W/globO5rKidix8VXRWghKuaiwH5lsAEd0Lzr0YOyqkGndXNv1W4pUq4yMqz?=
 =?us-ascii?Q?dpEvZjruXfGS8jUjbkD/0Roz+boKe/aVu2z5wEnYlrPJnfsU5ooznj3rzKom?=
 =?us-ascii?Q?kFDexUfT4LCqRGWPEQy9uHuj0s6fL+5/z4/L89jarxcy1pErE1/1puAu9OnO?=
 =?us-ascii?Q?8yAHrLNJ8/T6gS1SUU3g4ChB98E3z87TV3ZsZ04GHPKVgq5LIN7n5wL0HrJF?=
 =?us-ascii?Q?AizQxPeBO0vn6WKk6+5QZxaO3yna1LER176F6CwvAZ+1VjaSeKW99XMVX+FB?=
 =?us-ascii?Q?4HirtDxQtgKvprE+kjorqBFpMYymn1IaumEkBZ/nCdIX2Kg0uvoFvnASgJgY?=
 =?us-ascii?Q?Qq1DskJCNCfH0yZsV9aHBRPa+QJLGMMLXx316BkTGcWzsdJMkNjL4qj8u+Jr?=
 =?us-ascii?Q?r/tKHmTS/SJUgy08TUxTvH4gViDRI7xXzN+knOGDpAfjNTIKw6iUysjbrjvB?=
 =?us-ascii?Q?Buc2lqQL5y8hrewK/M4y1SpT4QmhigUzfFr6+Y/McXTRaoxfpC/Xgbb5p8hj?=
 =?us-ascii?Q?v2IbD/ZFZ0wMoEDKkbXzJ4iNL20AfFPLb7wkqKLdeuAQs53Ai73GfWMSFt7a?=
 =?us-ascii?Q?qjshxPoVjvXpQb3yIW5MgYHXvr7CwfusKqrcZSKjqXiSvDMG5xrOi0HpeS+A?=
 =?us-ascii?Q?RxrFHyHknPa049NVhAd4azGPm1ITqKJ9zkge6Hu3iEz3xML66od3tBOD77PF?=
 =?us-ascii?Q?EobX3ggtFPmy+TniDdtN4dXgzvPdHkLkwKj8BogE8tQO5HYlvQdWSK3n7D0h?=
 =?us-ascii?Q?Xoyny+lrAQ5ZzkNwQi4gmfEmc5D984K+748KFAGchbbluDmkXwg+FK480uIa?=
 =?us-ascii?Q?zA5HEkVEKm5/SoWV52GENii2KmKIzGwoIU1sKYC81II5TR8cQjtLJEl40vsi?=
 =?us-ascii?Q?g5LRceutkb3QVztSCYU9FcJHbP2YSKwhgzUeEI9LUVuR5J2KhKkj5dPAUk/U?=
 =?us-ascii?Q?gorTK4Y9QLTUejXsYwKwXDf27K6w02SnTMxNC8ChZBLfqBEAg9kIghIPnit8?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5389bc2e-f51c-4ea8-27f9-08dcc24bdce5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 01:43:46.5546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ep0Y5HVAczDja+5j2gs6blz+e8uC7uDYLkR+zNr2czXxXMSCAaydjRyp1sYucMgw7nVZqtG4a/Lt1QLShtLtSuhOi7BgiXy76oMpyCrLQlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8422
X-OriginatorOrg: intel.com

Hi Bjorn,

Ying is out for the next week or so, so I will address your comments and
resubmit as I think this is a potentially urgent fix.

Bjorn Helgaas wrote:
> On Mon, Aug 19, 2024 at 10:34:13AM +0800, Huang Ying wrote:
> > On a system with CXL memory installed, the resource tree (/proc/iomem)
> > related to CXL memory looks like something as follows.
> > 
> > 490000000-50fffffff : CXL Window 0
> >   490000000-50fffffff : region0
> >     490000000-50fffffff : dax0.0
> >       490000000-50fffffff : System RAM (kmem)
> 
> I think the subject is too specific (the problem is something to do
> with the tree topology, not the fact that it's "CXL memory") and at
> the same time not specific enough ("fix" doesn't say anything about
> what was wrong or how it is fixed).

Agree, I will update this to be:

kernel/resource: Fix region_intersects() vs add_memory_driver_managed()

> IMO it could be improved by saying something about what is different
> about CXL, e.g., maybe it could mention checking children in addition
> to top-level resources.

CXL is but one source of a resource tree topology where "System RAM" is
a descendant of some other resource. I will fix up this changelog to
make it clear that dax/kmem and add_memory_driver_managed() potentiall
confuses region_intersects() in all cases since "System RAM" is never
one of the resources passed in to add_memory_driver_managed().

> > When the following command line is run to try writing some memory in
> > CXL memory range,
> > 
> >  $ dd if=data of=/dev/mem bs=1k seek=19136512 count=1
> >  dd: error writing '/dev/mem': Bad address
> >  1+0 records in
> >  0+0 records out
> >  0 bytes copied, 0.0283507 s, 0.0 kB/s
> 
> Took me a minute, but I guess the connection is that
> 19136512 * 1k = 0x490000000, which is the beginning of the CXL Window.

Yeah, so might as well write this in a way that makes that association
clearer:

$ dd if=data of=/dev/mem bs=$((1 << 10)) seek=$((0x490000000 >> 10)) count=1

> > the command fails as expected.  However, the error code is wrong.  It
> > should be "Operation not permitted" instead of "Bad address".  And,
> > the following warning is reported in kernel log.
> 
> This intro makes it sound like the problem being solved is the error
> code being wrong.  But it seems like a more serious problem than that.

The concern was that this bug allowed System RAM protection bypass. That
does not seem to be the case on x86, but the worry is that other archs
are not saved in the same way and /dev/mem protections are impacted.

> >  ioremap on RAM at 0x0000000490000000 - 0x0000000490000fff
> 
> Incidental: it seems a little weird that this warning only exists on
> x86 and mips (and powerpc32 has a similar warning with different
> wording), but I assume we don't want to ioremap RAM on *any*
> architecture?

Put another way, we want "System RAM" presence to always fail
devmem_is_allowed() anywhere that "System RAM" appears in the ancestry.

> >  WARNING: CPU: 2 PID: 416 at arch/x86/mm/ioremap.c:216 __ioremap_caller.constprop.0+0x131/0x35d
> >  Modules linked in: cxl_pmem libnvdimm cbc encrypted_keys cxl_pmu
> >  CPU: 2 UID: 0 PID: 416 Comm: dd Not tainted 6.11.0-rc3-kvm #40
> >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> >  RIP: 0010:__ioremap_caller.constprop.0+0x131/0x35d
> > ...
> 
> > In the above resource tree, "System RAM" is a descendant of "CXL
> > Window 0" instead of a top level resource.  So, region_intersects()
> > will report no System RAM resources in the CXL memory region
> > incorrectly, because it only checks the top level resources.
> > Consequently, devmem_is_allowed() will return 1 (allow access via
> > /dev/mem) for CXL memory region incorrectly.  Fortunately, ioremap()
> > doesn't allow to map System RAM and reject the access.
> > 
> > However, region_intersects() needs to be fixed to work correctly with
> > the resources tree with CXL Window as above.  To fix it, if we found a
> > unmatched resource in the top level, we will continue to search
> > matched resources in its descendant resources.  So, we will not miss
> > any matched resources in resource tree anymore.  In the new
> > implementation,
> > 
> > |------------- "CXL Window 0" ------------|
> > |-- "System RAM" --|
> > 
> > will look as if
> > 
> > |-- "System RAM" --||-- "CXL Window 0a" --|
> 
> Where did "0a" come from?  The /proc/iomem above mentioned
> "CXL Window 0"; is the "a" spurious?  Same question applies to the
> code comment below.

Not sure where that came from, will clean up and provide a test that can
upstreammed as well.
