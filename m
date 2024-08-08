Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FDA18E023
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723125599; cv=fail; b=VT12AlOpJnSO+fjNfOnALWp0QiGEG21fd4Fkm55dK0JfEBY+J3RJx12m54wrhXleKtm8FrOiQVCHmOa5N8W8xk0uvjpcK1lr/p3Phsq88GVUjPN7ZkPzZsikT9U881nSCVGxlV2ukhjTO10utNOvMjEe2YpvOWYFBZSjIB8LAbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723125599; c=relaxed/simple;
	bh=bqozJ8l6YXtHmF4SnoBxA/zzw8jU0F95DE5Y4x1KYB0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VLrgWK4myvG08BUCNxQBEPs7WHDSTtjHOdeS4nzcl8UrPoBpVI3O5ATps6lqK6MgowJDdvnSmAHwuC1sXRf6yGUkesdizbYbPBZ1FjNDnn7qh377JqJm+It9HLgzIwh4kILDJWQlTD+0crxR4RrkjF/mqzSRp1QaKdQmE0lKRwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+1KV36p; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+1KV36p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723125598; x=1754661598;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bqozJ8l6YXtHmF4SnoBxA/zzw8jU0F95DE5Y4x1KYB0=;
  b=j+1KV36pVGdoEYA7jBdkOhsKANv/m2p1WX53/DMbsKSDVzn+C0C9r86G
   OgjBk21H4pkVUlS+W9uyTCtOzU3ruzrxo4mHVW0bz1JQBOj248U7r7hrm
   JfWvQ/UIFXQriBovKy/aGjbBfT/5k9KHa8RM0MqG75MLfY5meVY2mh99p
   i12t/pM8gJn5EtjVLHt6yrq7LsemNyqWMJjfMqk+fhNnSB4x7r+B2xh/E
   cZjWZjm1oeI86w6VOFn68DV97LOCrM+3DOBNa0dOCN3tV+k+24fdEQy9Q
   0jT3PrMPpkDyNQ1hn97o1gWAbyBGSHQPryaFWwr+gYR/QgR55Wq6FDGf/
   w==;
X-CSE-ConnectionGUID: /eifurgORFGFsEAlbGE4qA==
X-CSE-MsgGUID: dhYjCMjiRmuJe32WmIT/9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25013890"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="25013890"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 06:59:57 -0700
X-CSE-ConnectionGUID: HXcvl0OGQn+fRP3e3n7LJw==
X-CSE-MsgGUID: hiIsWfIwQbyd0mj++XXYuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="57196497"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 06:59:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 06:59:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 06:59:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 06:59:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 06:59:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxhohaijXM3OxemWWZHrzF+DdHqSVj4CN5mcr6YJZZBO+oTTXydKhGSUlMojkcGKTZfkeZLbXxxVILHuO1/FyMq5COeTBcNUw1FF/w5O03a0GCKOH+EjK+enen2/qJxXrc2GOIDBaPYAw0DFTkbK4P2Rt/isVUDErrYz1S53uJsMx0HO5tWWTK0yHkJ+ov1F3/IqoYOl9BwZFODqRuRnUiY5AyqB+3q5CUKDUSKQSkYwGEgIFv9pYbVd631H9Ll59oBC6zUtuAmXxDbOwshcg8fTlkMxy2QbeyPi/mrFGW0suPeVS3wdXDZauQajyrSnL5nSH3Om424LpF9itTzPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eoSNxfUKjmhoF43CwjITpXrNjF9kPc1R4WDRrQ916w=;
 b=C6ixOaylWeg/ji6qjPEW5YHEZWSKfqFssxEftbzjb/KjwGsxyYqeil5NH4l62xvfm5GtVyC2Wr16iYPKkwrfD4VW6dFKAwtORiEFjSbbGOzcs/iciJEZPSLakKX3LyEfwEA2AKVZKUlOI/EH3l5XCYw7+RgnBbx5WtqsdjgJcdFAlqHNTpOglb/pnoWNVXTrGLZHjo7j9RzZvGWBpTDS21Edl6aDVqdfqUSzQlLcjL7Bl14ioKaXrPmmuRT+5wFRf4U44p0uV6wEKh4w6kVITmuHRJ6wM65jC4wT5KOpBBnuwfe/Ie1p6DhN1hUCW+OGrQqHrz+3l8oN5ffU0+qgYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB5768.namprd11.prod.outlook.com (2603:10b6:510:131::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Thu, 8 Aug
 2024 13:59:51 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7828.021; Thu, 8 Aug 2024
 13:59:51 +0000
Date: Thu, 8 Aug 2024 08:59:47 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>, Ira Weiny <ira.weiny@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Lukas Wunner <lukas.wunner@intel.com>,
	"Zanussi, Tom" <tom.zanussi@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-mm@vger.kernel.org>
Subject: Re: Odd lockdep splat involving mt_adistance_algorithm
Message-ID: <66b4cf539a79b_a36e829416@iweiny-mobl.notmuch>
References: <66b44389e7b5f_71e8129499@iweiny-mobl.notmuch>
 <87wmkrzgsu.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87wmkrzgsu.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: MW4P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c6f980-f2a3-40b4-2bdd-08dcb7b25f89
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cAm9LJfHTyGu2wrbP7FCGNn9wAY1wDopzxB8skGOgHiSZ+7iXGuU44LiDowY?=
 =?us-ascii?Q?0m9RKcxzC3aK3fNNsT0fp2DHEUAh1zaRta/YOjya0ZWQrBFDNk0bkuM0CIL8?=
 =?us-ascii?Q?rk7naujAVZw9hVO8rxFNYsC+WOSsXsy82kLX4asAoKNPvpt1hZoHY+l6FxPv?=
 =?us-ascii?Q?lWx1KKy3URUbNpROQMxqjLd/KIBzdQ7+n1DZQ2OxsOX13vONWJTD+JnQt5DK?=
 =?us-ascii?Q?dwLwCv3b2SnDclVv0rjLdgyHganFVtsKBVMHylV2+mUXZJelJOplx1T/Tm1A?=
 =?us-ascii?Q?P33FnLnmeI5zMX3RqoZXhMS9KdA2xOrg6j+mN5aEHWfaRUZtSbAJjpzgbc5u?=
 =?us-ascii?Q?mGQb2ISvPqtmDPjhkXlmHFKkAl9jfUQTSD4ByCkRWgJe59T3f4AxPKmu3VUh?=
 =?us-ascii?Q?AsMvL0s+Rviprm7ligtm/tdoAXKbvBrxg7Z6uT1IoT8scC0QHJQ3atSNHjan?=
 =?us-ascii?Q?uA9nuJleawiARlT8DmfvIaK4oUCzjhMmkTvWauCRzMlToIuH9c0MbA984kZd?=
 =?us-ascii?Q?bBmazpUXsMhZkPVS6F9hCwjYA86LSaFJpqO7Nrb2G+dtDYopJ26qTK8xQSZb?=
 =?us-ascii?Q?IqSFi6b1TVg33chvOuNU9vGDwDL4XWEx/RwJWVviTC2t2fIhSTZOXQDrtK3S?=
 =?us-ascii?Q?KjlPHlRn8rpdTH1foAxhc1fuNZM7l/qm1d/po2JtSOJiX4sCcWv1XC0qsWIF?=
 =?us-ascii?Q?nU6kA9nfLcrssIdFtR98GTLvYmoob1d2NjaUC4LK13cNI6CEyqDCjpkHGKyU?=
 =?us-ascii?Q?ptb20Zm2ZAPo+g9IaBB6T9MGtN6FS8+7xALb3OnvaSBwWISKB4c2eDf/ClSy?=
 =?us-ascii?Q?1aMzvzy6k/X0smzGWpJEp17anxlOkFf1HKf0qcXT1GELbk1MfiP6MalvVWeA?=
 =?us-ascii?Q?JpkQsLuYp9Fg2MmzXb4btrXe0OWv5/6/cnYMnjvbuvewA1PwPzzRRBxvW6WY?=
 =?us-ascii?Q?4DnL5tEHrXmHu5OWqx1GzeDF5XuL0WOJLDQjHf0TA3aizG3fruTdQRsViA/6?=
 =?us-ascii?Q?MjUvrEU8dXHIhUvlQYU4BZdAsVBRUzDjZFF9gGE/5swQ4ghBIzdeKGvNLXSl?=
 =?us-ascii?Q?WVmR8J/f8MoCkViOzTPaoQmFk4yqkZTmuJ0LdS4wiMuBK5vXDo3WqNpD9XbN?=
 =?us-ascii?Q?+0C+4dfVPw2V63xakBzgrxouGmoV2W1KMOV7JX75q052C45sx5y0FS1j0sHo?=
 =?us-ascii?Q?sLHesXjiFD+EJcf2LN+hGimGFlfdf66R1u6EiGd0o7KK0FbFh8iE0PsDbJ3j?=
 =?us-ascii?Q?2fMx8SA8gnH/ecalacphBeVroewZYipRKMlC4DxrlCPBg7Ok0TS7jX2Hy6n4?=
 =?us-ascii?Q?5mc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bui/cLTEI2o7/XDrKBVA4bVK10PuGWbhSLWHD54p92JPr5r5v3iVRtKfmuuM?=
 =?us-ascii?Q?Re9xrY7WTnP2eNRQD2dIVE5CkteIKtip2yC5KKPp1RrtCNp+DuuuBLg72hoz?=
 =?us-ascii?Q?OMvud81LqoFLb6yuNoPRlHWibqpLqmx5x85pMefH/lGDxl6N/HjiWqSsQwAY?=
 =?us-ascii?Q?DBe8bmG8fzSrguAe9+k2dDXhA3W7WjckREdWJllSeaMKXuhpW79q7/fIx6mp?=
 =?us-ascii?Q?Q7fUkEb+6IT8tk9s5GR+t4d4I8uGqcthe0HlxMVPoA4y9ZG+RRYk2e2MB/u+?=
 =?us-ascii?Q?/hodjG1LYPtXP3jJTB3Wwv+88RxGcZIBNlwe6W1C8yLgI/2WfPOmE2Fk7Trt?=
 =?us-ascii?Q?3bPnYsUlaJAe89i+YW+424LIThlomoZn2oymHp3tYgG37IucI0Ze3jfWQMyu?=
 =?us-ascii?Q?BnzxqrkxDHvz2ETjp+dUMMuRRvAqf5arJbn4JdVcMjpPtZxpDRzNASKDcuZQ?=
 =?us-ascii?Q?thAnX0GnBzXKVuvEJbSkiXBU4ZvdY401WvMYJ5Zt7RaPRgRv/s5umq/U7A6W?=
 =?us-ascii?Q?rMtRNfC0q7+8+58B1IZJ77nzseXCKQNt/p2oQODDzzqvAUUk1A2SkH4X4jXN?=
 =?us-ascii?Q?7HlMFrNXHYsczchr4jIC2a7CksuGdR+RA0T0E4bIulk3TX4CVzI2jbBeeVnH?=
 =?us-ascii?Q?/+8uvu5+L3/WEel5/82tuA4zf9FNagpCmq56CFXbNoKBtKFFiaCRsDeoR8DE?=
 =?us-ascii?Q?ct61/DaqTGMXfQxo6G+gfNzXvYf5jOvt6c2AhyXEuEG+tgpDJ9S6fAfECkL7?=
 =?us-ascii?Q?UlOzosB7EWov0tE/YqSt4u/xj8twFiWD8rFQSrGl4VLVp/kYgW8rKepWFWt4?=
 =?us-ascii?Q?M9KcW99BkvnjOS3Q7OcDqG+/6Wpqr/q2vjQYTu9o8UP1Vymy9sTe6rQUfNcf?=
 =?us-ascii?Q?YQk2RyJjPfCQ5E42X4EUfrakWYnHO+g8M22iHbxdgvTRjxZus11jBavvj0Yn?=
 =?us-ascii?Q?2l5Xn8sT8UO4Yx71pnnFWjDr5QWo3Fkt3wQwoZkMimF/jlBlKiK3EcRpqXsV?=
 =?us-ascii?Q?VjcN8+xw7e0DymPW/rNk+KwEKosaXDcCcDrZytpN4d2Hof8DBUlXypuDeHrX?=
 =?us-ascii?Q?IDRZhXLc/GVyIadYsZOm48FptKS9glXydoekn5OZ0ZA8Si1m5kmz3wbZlYK4?=
 =?us-ascii?Q?Sbj7MW4LL0B1N+X6LT1usxAfB58qGF364InwMsAUMqqn4Q4C/6P8Nw+PHJTp?=
 =?us-ascii?Q?EoDcWOoQb3En4SpGFwTtIUVd4nfyq/l7p6q9cLHw4WHqHtfZ+PJi9OtMAsQP?=
 =?us-ascii?Q?Y8tCXXRabGH7GFJ6GQ0jqrKOU9jUu345JZoI4oHcRshg4TTwZA5+rMHLRF4C?=
 =?us-ascii?Q?p01CsD/25VF9cwR9rKVj5efxapTND+0TvDgGsIdF1Xfs+JNB4TS9/do5rqAA?=
 =?us-ascii?Q?dYZ/Rj3+WrmhhUAU8wuCj3JXPHHvH16uL5e9He3013XBb3iPmHK6cjuVE9HR?=
 =?us-ascii?Q?1bpm3CBYRfrS+ikb7h7/E3nXszXPiHdKLieI57UaKMQYwcqF5VCgzd1phvRp?=
 =?us-ascii?Q?CS/ogGRwabcmOZu1dDYrDZRfJ0BpoJN6aWlSbP1NHchMsIEQMIDEzzDayr8j?=
 =?us-ascii?Q?vegA6axsBfHRr55olHikB+oOHGWTw6Kz35dza+ML?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c6f980-f2a3-40b4-2bdd-08dcb7b25f89
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 13:59:51.7210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RItvB2DTSc+BB3QoqeO09uJwrKi6FINZn2PW8eaU1kjYKk+D+pJFh0c4cMiZ4EPgRVb8ZmslRrwhkvFEV1BsFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5768
X-OriginatorOrg: intel.com

Huang, Ying wrote:
> Hi, Ira,
> 
> Ira Weiny <ira.weiny@intel.com> writes:
> 
> > Ying,
> >
> > I'm working on the CXL DCD support[0].  After rebasing to v6.11-rc1+ I'm
> > starting to see the following lockdep splat[1] in my testing.
> >
> > I don't understand how lockdep thinks there is a dependency between
> > (mt_adistance_algorithms).rwsem and cxl_dax_region_key (the
> > cxl_region->dev mutex).
> 
> IIUC cxl_dax_region_key is for cxl_dax_region->dev mutex.

Opps yea that is what I meant.

> 
> > Do you have any insight into how the notifier rwsem gets associated with
> > other locks?  I just don't see how the association in this splat is
> > made.
> 
> In v6.11-rc1, a new dependency is added between cxl_dax_region_key and
> (mt_adistance_algorithms).rwsem via commit 643e8e3e6529 ("cxl/region:
> Support to calculate memory tier abstract distance").

I still don't see how that commit makes a relationship with
cxl_dax_region_key.  I admit my lockdep knowledge is limited.

> 
> When probe cxl_dax_region device, cxl_dax_region->dev mutex will be
> acquired, then dev_dax_kmem_probe() will call
> mt_calc_adistance() -> acquire (mt_adistance_algorithms).rwsem ->
> cxl_region_calculate_adistance() -> cxl_region_nid() -> acquire
> cxl_region_rwsem.

Regardless, I see the issue now.  And unfortunately a couple of other
issues with the code.

Thanks,
Ira

> 
> In your new code, cxl_dax_region->dev mutex may be acquired when
> cxl_region_rwsem is held in the following call stack,
> 
>   cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core] <- cxl_dax_region_key
>   cxled_add_extent+0x376/0x400 [cxl_core]
>   cxl_mem_get_records_log+0x586/0x760 [cxl_core] <- cxl_region_rwsem cxl_handle_dcd_event_records()
>   cxl_mem_get_event_records+0x99/0xa0 [cxl_core]
>   log_dc_event+0xc5/0x180 [cxl_mock_mem]
>   __dc_inject_extent_store.isra.0+0x30d/0x3e0 [cxl_mock_mem]
>   kernfs_fop_write_iter+0x141/0x1f0
>   vfs_write+0x262/0x500
>   ksys_write+0x59/0xd0
>   do_syscall_64+0x75/0x190
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> --
> Best Regards,
> Huang, Ying
> 
> > Thanks,
> > Ira
> >
> > [0] https://github.com/weiny2/linux-kernel/tree/dcd-v4-2024-08-07
> > [1] <splat>
> >
> > [   25.691773] ======================================================
> > [   25.692509] WARNING: possible circular locking dependency detected
> > [   25.693222] 6.11.0-rc1ira+ #20 Tainted: G           O     N
> > [   25.693888] ------------------------------------------------------
> > [   25.694599] bash/1161 is trying to acquire lock:
> > [   25.695194] ffff888022ece0e8 (&cxl_dax_region_key){+.+.}-{4:4}, at: cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core]
> > [   25.696122] 
> >                but task is already holding lock:
> > [   25.697145] ffffffffa101fd70 (cxl_region_rwsem){++++}-{4:4}, at: cxl_mem_get_records_log+0x27f/0x760 [cxl_core]
> > [   25.698069] 
> >                which lock already depends on the new lock.
> >
> > [   25.699536] 
> >                the existing dependency chain (in reverse order) is:
> > [   25.700618] 
> >                -> #3 (cxl_region_rwsem){++++}-{4:4}:
> > [   25.701643]        down_read+0x2d/0x170
> > [   25.702204]        cxl_region_calculate_adistance+0x20/0x90 [cxl_core]
> > [   25.702922]        notifier_call_chain+0x40/0x100
> > [   25.703526]        blocking_notifier_call_chain+0x41/0x60
> > [   25.704158]        dev_dax_kmem_probe+0x40/0x380 [kmem]
> > [   25.704778]        dax_bus_probe+0x6b/0xa0
> > [   25.705351]        really_probe+0xd6/0x390
> > [   25.705872]        __driver_probe_device+0x78/0x150
> > [   25.706463]        driver_probe_device+0x1f/0x90
> > [   25.707003]        __driver_attach+0xd2/0x1c0
> > [   25.707547]        bus_for_each_dev+0x66/0xa0
> > [   25.708067]        bus_add_driver+0x111/0x240
> > [   25.708574]        driver_register+0x55/0x100
> > [   25.709069]        0xffffffffa1172050
> > [   25.709557]        do_one_initcall+0x60/0x2c0
> > [   25.710060]        do_init_module+0x60/0x230
> > [   25.710555]        init_module_from_file+0x75/0xa0
> > [   25.711095]        idempotent_init_module+0xf9/0x270
> > [   25.711643]        __x64_sys_finit_module+0x5a/0xb0
> > [   25.712164]        do_syscall_64+0x75/0x190
> > [   25.712651]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [   25.713225] 
> >                -> #2 ((mt_adistance_algorithms).rwsem){++++}-{4:4}:
> > [   25.714117]        down_read+0x2d/0x170
> > [   25.714567]        blocking_notifier_call_chain+0x27/0x60
> > [   25.715095]        dev_dax_kmem_probe+0x40/0x380 [kmem]
> > [   25.715610]        dax_bus_probe+0x6b/0xa0
> > [   25.716043]        really_probe+0xd6/0x390
> > [   25.716481]        __driver_probe_device+0x78/0x150
> > [   25.716956]        driver_probe_device+0x1f/0x90
> > [   25.717397]        __device_attach_driver+0x85/0x110
> > [   25.717864]        bus_for_each_drv+0x6f/0xb0
> > [   25.718296]        __device_attach+0xb0/0x1b0
> > [   25.718703]        bus_probe_device+0x94/0xb0
> > [   25.719119]        device_add+0x646/0x860
> > [   25.719518]        __devm_create_dev_dax+0x19f/0x470
> > [   25.719954]        devm_create_dev_dax+0x1d/0x40
> > [   25.720393]        cxl_dax_region_probe+0xc8/0x110 [dax_cxl]
> > [   25.720867]        cxl_bus_probe+0x17/0x50 [cxl_core]
> > [   25.721329]        really_probe+0xd6/0x390
> > [   25.721720]        __driver_probe_device+0x78/0x150
> > [   25.722145]        driver_probe_device+0x1f/0x90
> > [   25.722569]        __device_attach_driver+0x85/0x110
> > [   25.723009]        bus_for_each_drv+0x6f/0xb0
> > [   25.723414]        __device_attach+0xb0/0x1b0
> > [   25.723809]        bus_probe_device+0x94/0xb0
> > [   25.724206]        device_add+0x646/0x860
> > [   25.724573]        cxl_region_probe+0x5ae/0x7c0 [cxl_core]
> > [   25.725025]        cxl_bus_probe+0x17/0x50 [cxl_core]
> > [   25.725465]        really_probe+0xd6/0x390
> > [   25.725840]        __driver_probe_device+0x78/0x150
> > [   25.726247]        driver_probe_device+0x1f/0x90
> > [   25.726655]        __device_attach_driver+0x85/0x110
> > [   25.727073]        bus_for_each_drv+0x6f/0xb0
> > [   25.727463]        __device_attach+0xb0/0x1b0
> > [   25.727838]        cxl_add_to_region+0x2ef/0x5b0 [cxl_core]
> > [   25.728302]        discover_region+0x4b/0x80 [cxl_port]
> > [   25.728726]        device_for_each_child+0x48/0x70
> > [   25.729137]        cxl_port_probe+0x160/0x220 [cxl_port]
> > [   25.729565]        cxl_bus_probe+0x17/0x50 [cxl_core]
> > [   25.729984]        really_probe+0xd6/0x390
> > [   25.730361]        __driver_probe_device+0x78/0x150
> > [   25.730776]        driver_probe_device+0x1f/0x90
> > [   25.731177]        __device_attach_driver+0x85/0x110
> > [   25.731600]        bus_for_each_drv+0x6f/0xb0
> > [   25.731982]        __device_attach+0xb0/0x1b0
> > [   25.732378]        bus_probe_device+0x94/0xb0
> > [   25.732770]        device_add+0x646/0x860
> > [   25.733141]        devm_cxl_add_port+0x43d/0x760 [cxl_core]
> > [   25.733595]        cxl_mem_probe+0x23f/0x350 [cxl_mem]
> > [   25.734025]        cxl_bus_probe+0x17/0x50 [cxl_core]
> > [   25.734453]        really_probe+0xd6/0x390
> > [   25.734821]        __driver_probe_device+0x78/0x150
> > [   25.735220]        driver_probe_device+0x1f/0x90
> > [   25.735611]        __device_attach_driver+0x85/0x110
> > [   25.736025]        bus_for_each_drv+0x6f/0xb0
> > [   25.736412]        __device_attach+0xb0/0x1b0
> > [   25.736788]        bus_rescan_devices_helper+0x39/0x80
> > [   25.737207]        bus_rescan_devices+0x46/0x80
> > [   25.737611]        cxl_bus_rescan_queue+0x11/0x30 [cxl_core]
> > [   25.738080]        process_one_work+0x1f8/0x660
> > [   25.738478]        worker_thread+0x1ca/0x3a0
> > [   25.738861]        kthread+0xe0/0x110
> > [   25.739209]        ret_from_fork+0x30/0x50
> > [   25.739575]        ret_from_fork_asm+0x1a/0x30
> > [   25.739958] 
> >                -> #1 (dax_region_rwsem){+.+.}-{4:4}:
> > [   25.740573]        down_write+0x2a/0xc0
> > [   25.740930]        devm_create_dev_dax+0x15/0x40
> > [   25.741322]        cxl_dax_region_probe+0xc8/0x110 [dax_cxl]
> > [   25.741776]        cxl_bus_probe+0x17/0x50 [cxl_core]
> > [   25.742201]        really_probe+0xd6/0x390
> > [   25.742580]        __driver_probe_device+0x78/0x150
> > [   25.743003]        driver_probe_device+0x1f/0x90
> > [   25.743403]        __driver_attach+0xd2/0x1c0
> > [   25.743780]        bus_for_each_dev+0x66/0xa0
> > [   25.744167]        bus_add_driver+0x111/0x240
> > [   25.744545]        driver_register+0x55/0x100
> > [   25.744930]        do_one_initcall+0x60/0x2c0
> > [   25.745308]        do_init_module+0x60/0x230
> > [   25.745679]        init_module_from_file+0x75/0xa0
> > [   25.746093]        idempotent_init_module+0xf9/0x270
> > [   25.746499]        __x64_sys_finit_module+0x5a/0xb0
> > [   25.746907]        do_syscall_64+0x75/0x190
> > [   25.747277]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [   25.747716] 
> >                -> #0 (&cxl_dax_region_key){+.+.}-{4:4}:
> > [   25.748351]        __lock_acquire+0x15a0/0x2320
> > [   25.748750]        lock_acquire+0xd0/0x2e0
> > [   25.749108]        __mutex_lock+0x7b/0xb60
> > [   25.749479]        cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core]
> > [   25.749949]        cxled_add_extent+0x376/0x400 [cxl_core]
> > [   25.750400]        cxl_mem_get_records_log+0x586/0x760 [cxl_core]
> > [   25.750877]        cxl_mem_get_event_records+0x99/0xa0 [cxl_core]
> > [   25.751360]        log_dc_event+0xc5/0x180 [cxl_mock_mem]
> > [   25.751788]        __dc_inject_extent_store.isra.0+0x30d/0x3e0 [cxl_mock_mem]
> > [   25.752333]        kernfs_fop_write_iter+0x141/0x1f0
> > [   25.752742]        vfs_write+0x262/0x500
> > [   25.753108]        ksys_write+0x59/0xd0
> > [   25.753484]        do_syscall_64+0x75/0x190
> > [   25.753851]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [   25.754297] 
> >                other info that might help us debug this:
> >
> > [   25.755143] Chain exists of:
> >                  &cxl_dax_region_key --> (mt_adistance_algorithms).rwsem --> cxl_region_rwsem
> >
> > [   25.756258]  Possible unsafe locking scenario:
> >
> > [   25.756878]        CPU0                    CPU1
> > [   25.757314]        ----                    ----
> > [   25.757706]   rlock(cxl_region_rwsem);
> > [   25.758067]                                lock((mt_adistance_algorithms).rwsem);
> > [   25.758631]                                lock(cxl_region_rwsem);
> > [   25.759126]   lock(&cxl_dax_region_key);
> > [   25.759502] 
> >                 *** DEADLOCK ***
> >
> > [   25.760242] 5 locks held by bash/1161:
> > [   25.760619]  #0: ffff888008d7f3f8 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x59/0xd0
> > [   25.761197]  #1: ffff888009589088 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0xf7/0x1f0
> > [   25.761858]  #2: ffff88820881c9a8 (kn->active#154){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x100/0x1f0
> > [   25.762533]  #3: ffff8880170dd788 (&mds->event.log_lock){+.+.}-{4:4}, at: cxl_mem_get_records_log+0x5b/0x760 [cxl_core]
> > [   25.763297]  #4: ffffffffa101fd70 (cxl_region_rwsem){++++}-{4:4}, at: cxl_mem_get_records_log+0x27f/0x760 [cxl_core]
> > [   25.764050] 
> >                stack backtrace:
> > [   25.764621] CPU: 2 UID: 0 PID: 1161 Comm: bash Tainted: G           O     N 6.11.0-rc1ira+ #20
> > [   25.765274] Tainted: [O]=OOT_MODULE, [N]=TEST
> > [   25.765709] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240214-7.fc39 02/14/2024
> > [   25.766389] Call Trace:
> > [   25.766717]  <TASK>
> > [   25.767013]  dump_stack_lvl+0x8f/0xe0
> > [   25.767400]  check_noncircular+0x130/0x140
> > [   25.767807]  __lock_acquire+0x15a0/0x2320
> > [   25.768204]  lock_acquire+0xd0/0x2e0
> > [   25.768588]  ? cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core]
> > [   25.769101]  ? __dynamic_dev_dbg+0x166/0x1d0
> > [   25.769530]  __mutex_lock+0x7b/0xb60
> > [   25.769913]  ? cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core]
> > [   25.770433]  ? cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core]
> > [   25.770939]  ? mark_held_locks+0x40/0x70
> > [   25.771341]  ? cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core]
> > [   25.771867]  cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core]
> > [   25.772362]  ? __devm_add_action+0xbd/0xe0
> > [   25.772796]  cxled_add_extent+0x376/0x400 [cxl_core]
> > [   25.773269]  cxl_mem_get_records_log+0x586/0x760 [cxl_core]
> > [   25.773780]  cxl_mem_get_event_records+0x99/0xa0 [cxl_core]
> > [   25.774273]  log_dc_event+0xc5/0x180 [cxl_mock_mem]
> > [   25.774742]  __dc_inject_extent_store.isra.0+0x30d/0x3e0 [cxl_mock_mem]
> > [   25.775284]  kernfs_fop_write_iter+0x141/0x1f0
> > [   25.775731]  vfs_write+0x262/0x500
> > [   25.776124]  ksys_write+0x59/0xd0
> > [   25.776511]  do_syscall_64+0x75/0x190
> > [   25.776904]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [   25.777385] RIP: 0033:0x7f5c0fb3bee4
> > [   25.777771] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d 85 74 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
> > [   25.779190] RSP: 002b:00007ffec4c72e48 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> > [   25.779815] RAX: ffffffffffffffda RBX: 0000000000000023 RCX: 00007f5c0fb3bee4
> > [   25.780415] RDX: 0000000000000023 RSI: 000055ceeac88cd0 RDI: 0000000000000001
> > [   25.781005] RBP: 00007ffec4c72e70 R08: 0000000000001428 R09: 0000000100000000
> > [   25.781604] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000023
> > [   25.782196] R13: 000055ceeac88cd0 R14: 00007f5c0fc0c5c0 R15: 00007f5c0fc09f20
> > [   25.782813]  </TASK>
> 


