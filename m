Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4586200C87
	for <linux-cxl@vger.kernel.org>; Tue, 12 Nov 2024 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429756; cv=fail; b=go85YXZ1r4QMGEjL6/+DfAqwqV4uA8JVBZJiuHO3my1ux7dIpBz3YBY3oBy5Z0k1grlApBPn0nG1lJQrgmmrgIJnY3SvMugpI4JPZJH5Vn/dbrxD8dRaAgRHdkuXBiFLOoebKcohTygeyO2I5EbgO2giofnKWPS3ieoA9Fc+upQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429756; c=relaxed/simple;
	bh=jjeKY/9Zs1WDfEwRg9jc3uWzO4zCrlkfGUEM7DK+mUc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q94nbg61KAo1ZOeQqV+UHg/ztchv6Lm/0H07oyQlOc/atkk2R4F4j9TfYfZrRNsjGPDgqMvvH2x8V5kDHBzeOp/ypat9pzfdcFrsF2GCkokAfypWGdcA/R8MsWSLq4RweUPcUbI0qj3plclwFbZZip2TRMpk+xkF3CripHAo6GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rcze4Me7; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rcze4Me7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731429754; x=1762965754;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jjeKY/9Zs1WDfEwRg9jc3uWzO4zCrlkfGUEM7DK+mUc=;
  b=Rcze4Me7krY5zN9ZZa3DtNmyapsNIPQF5IXkwkrB7jcld8sRXCTbEAQJ
   cCvtyA/WWA33Z/D2s1ADI/seuyAo681AUOGA+kKwAaUhXoYWQaVRG1CQr
   +36WKD7geSvno4WyTSpFzki1hXzBI8XvTI7gXDEyJmPiwb2Il4dwqz93A
   U2lErb7KJuZQaUFNU5pCDsj/bWCaWi4toxlpvqH23B7ddRHu6CZK2YLwF
   kPUyEd8Scw4b/cYCq2+Tg1h9w0Khpt0ju3xoCMBJ11w6KnN6VPaC/6ZS3
   gtXYFaQeFPdflFZ0AuIDcuGnrygzcLE0c6w4B/rxxRlSbHjPAajrHP7jZ
   Q==;
X-CSE-ConnectionGUID: UIiTzzVPTi6G+q0LUGECiQ==
X-CSE-MsgGUID: qZk52ZzVR+O2P/0BIWiAig==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31150903"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="31150903"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 08:42:32 -0800
X-CSE-ConnectionGUID: xCm3sbUmQNSdBUQf967Olg==
X-CSE-MsgGUID: l9hbEMRbTKeXPk5mdz6b2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="87977807"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 08:42:26 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 08:42:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 08:42:23 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 08:42:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/ozhc1or5gUN0O9TjXKAUehlTvzvAY60Q4LMXk0+b9HhFjcCBfIo5iKKTLuWjFkB9WwZKtcMvA7iZpAcfiD1J/uYTvEu1oSeUuQYrA3O58x9mjnACm2bzshrXxMx16oVovKeaRu4i3i7A1RnpKXBkjkOClqBhY7Q5YPcaaVIrBgqE0L4cbUsNjjBF2x4g7/wOJVptU0IFmuNFnHr04J8NlXoy1k4AIFgKsGCl7qAK9W9uE38C8N2Lpc4LoOVRoVPD+HzQeBP34hneZ/ICTwuL8jkNp0S28/gyVgE7txT9gnH2YaetsjHZO8Y9uFWUDK53ePx7pCz4SXPcB+mekH+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+sEeXwifqYUWex+lYVQBKi80lEMDUqxV4Fxm1EYjAM=;
 b=rt8fETR4c72EKURVFZfK5cf8Zt0khg79smsGMeqtC9JEMF1szpgoj66wk7VLSN0A1V0OcIlgKvP5QwgCbicJ+3GYUr7IJQaQWziRiFSNJMG2BHCZjU7o3aq2R/iXM/dQdBh5otu0GcdEZ93jlw08ECELXk7O+H8rwI96lbtIpQXdacpxuRcssQAglTbL0muAwfKD1teaOSBO5TUBoENFWARg7yiNYFFpLavnhg+50YpxBSTYWBbzWRmIlCR4ry/v2r17exwDQSSPfLa94M2wu6QLu1Eh3hBZnmKnYW6bi8plVfY2JSPuxsGJUuulTDtrms1zLU2vla/LBozjH1rmow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB5143.namprd11.prod.outlook.com (2603:10b6:510:3f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 16:42:21 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 16:42:21 +0000
Date: Tue, 12 Nov 2024 10:42:17 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<dave.jiang@intel.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Li Ming <ming4.li@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] cxl/port: Revert usage of scoped_guard()
Message-ID: <673385696cf89_1cc30229473@iweiny-mobl.notmuch>
References: <172921380683.2133624.1708770961640157143.stgit@dwillia2-xfh.jf.intel.com>
 <172921381577.2133624.10091366656126564045.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <172921381577.2133624.10091366656126564045.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW4PR04CA0140.namprd04.prod.outlook.com
 (2603:10b6:303:84::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB5143:EE_
X-MS-Office365-Filtering-Correlation-Id: fa805ec5-cf1c-4cbc-e024-08dd0338fa4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8KvQ/Qv7G793WJyRoWzCD1rFFhpx+bQLsnRDnLZi/c2mjMucQAIfojBglg6s?=
 =?us-ascii?Q?as/ICf2LoqO8bE7sgYlBGPgQJkeUkQS8Ep7KbRDcK4xzo3aKIcoKF4Ati42j?=
 =?us-ascii?Q?L4p64smv/cpB7HhstnYa0+3SKii3zZ5p4dd0An77Xu7WqAMgK0oJEgnNoL4l?=
 =?us-ascii?Q?xgB2rd3eBzRhxFT8DWQe37XqzzNRaFL9326iOhV02iGFVuA4BUeD9Q5a2kmY?=
 =?us-ascii?Q?8Zt2EuoOoYT+cu/B6fzdFwH+Pr5y8SXh1wo5meyf+wuMVPJd23kxvXy49NrH?=
 =?us-ascii?Q?0bbn+gxbudMqJCe2OhC6TrxJzckpx3BD7+xfuWi70juik4dKRWr60Wy2sTVi?=
 =?us-ascii?Q?QdlMj6cqBjmpGx50eTsWmyJeg29Ug0cHnRHqWGS6HZfjMnRKrR5DcOpCOgx6?=
 =?us-ascii?Q?9dHwAbmMyJQeOsMHbqkIk9NCzb+5vGDrFptPyW1PZwR+fKYNSHq4GgF52vUz?=
 =?us-ascii?Q?X6ow8SRhXwC7wdAv6ZPHxPKhIh5P1cBP2vKtVE9oelHs8E5eehjOxD2FDWZc?=
 =?us-ascii?Q?xvNt+Kgtf9ynh0z4hMRGhae0GrsaeiZT1T7V5ufyvFj+nhaZnoU0Gb8V7kAT?=
 =?us-ascii?Q?QdG4XH01GOvMW1CXctqemrjBqaOsTVEkCB0CLTN4hVGgEpnYJRMsyiO8NTvl?=
 =?us-ascii?Q?3dT7cNft/6FX5Qc7FRI/T/9x2PEvgiN48Tuyl+ZQm3SusZP3PBw58wq2Vne9?=
 =?us-ascii?Q?FLG5qE+obn2N8XNwt0zqqJ6AufhnwXToLZ4bACaSOAgVwd3sTkkI3QzT8x/l?=
 =?us-ascii?Q?d1LX7NFbPoVTCJ1QwxJzlvX9eiilOExd+MuZ7VrN13XE60q2BSK7IGRFZBrt?=
 =?us-ascii?Q?mbYx3VZWjPZjx1Z8uGh7cvFGkKJszkdyE3PTtzYTNmNwdbvm9tNxq1akIMkI?=
 =?us-ascii?Q?o7/3VnMbQ9iUoY7h0cQH/2/RfjiuwoTkUluCQ72jkIyyGjsnnAqX02g/eg8V?=
 =?us-ascii?Q?3BEWtBG2ot/ugBXhTzG+sdPVW9EqKkNWA3iNi3sYzsh8VgmpSDpCZGK9Bls8?=
 =?us-ascii?Q?dvJR1/CKo1QgF++LlGCc3PmUGGkhUyOyDj2LYE6SPUttKftR0O5NSxi8oM6Z?=
 =?us-ascii?Q?P+7r90c6+/V0vaTY3Uxjhhf8lqyTkn88QUFY/GYpl2kAIoi1y/RXMxrLxyyW?=
 =?us-ascii?Q?q8P/qXwK36Qd2RD4Lie+3qM3gdSe2RD4D1V5Qbda+n+RxWjc3qI1CwLSLV4h?=
 =?us-ascii?Q?hNCzw5z/lIYE42pob8tP5UBXb9KxOZ9jnN4iARIOFk8ogicKxIRAKBbBhY6l?=
 =?us-ascii?Q?o5CMNipatq69HE6qei5iCSKBrUQ+SCZtsqWzztafbEozpAC1oR/25iz0yldF?=
 =?us-ascii?Q?j38oDgZKJ1UWxvKHdNb80e2Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p29CvIrdpnpW/W20ejy8vo/eW9rVJOFXzMlSuxq5zPNQW+oylQhR7RORULBl?=
 =?us-ascii?Q?pXcGseuRSk42NEA+Tpk+XTgSUz6ATlRMNi+4qCw/GVYc/OQlFnIruhscWTst?=
 =?us-ascii?Q?fweHLQte61hSZjTlmzOSCW+DCfTmoGtuQIaDTX2I3MzAVX24U9+hg2yzgmd5?=
 =?us-ascii?Q?gY9ab5/THej8OiNbdRoTCcqbCWafpJ7ck5d9l+0ET0jiJTraSrWm9/6aTbyk?=
 =?us-ascii?Q?GjPPArBQJGxf1GcPXVISCsL9HGBMpHPqO3BWwaIKvjK/hgxDO+vrqLrvqBQI?=
 =?us-ascii?Q?odFUrZRkpcRN6q7dEtVh4MGF3Qni9U2EIRAJSXwG2ocsV98fOhpL4YsbuxDJ?=
 =?us-ascii?Q?LtPhmb6/lvBpDjnOCu/YIYjKGhvOsET6nkVxT6isFxi6aFpPcAWg3STD2xTb?=
 =?us-ascii?Q?P2GGjs3AfHv/8Wpj5VxzxwOgx9G6pWwSlIKaOOfTfZqwUfZTOaz1ur9htIkC?=
 =?us-ascii?Q?UJqdFYgSLYwk+E0b2G2Pq7nFkEyX9zM3f/bS31VCxkJKEOIMZFS2p5NfGmwI?=
 =?us-ascii?Q?YqxgvGInJEq/2FOIYakUs8aYSxyOH3ZKi8cNrEqLer4B6aFtgW1HNnWeYtJ3?=
 =?us-ascii?Q?bQT34MjiM3Qh+FrXbfXHnWJKh7hzeDzTz+bzCgYtGeA+fb3PK9/ymkiwPlrm?=
 =?us-ascii?Q?Q8RXC1wqSad6GYGF/HBxbs1ccQdKzULvwda6Fv9yofJrz3Nxe4sGXOoPU8Ie?=
 =?us-ascii?Q?Ey6W96BDAVhqBH5cGj6WacJPuLFJrfKJOT0n5Kwyq4wd/FvAWzWTa22AmBrm?=
 =?us-ascii?Q?HYBJBYEaESAxfiq9OKJ18QX47SB9zF2sLuf+hSj95g4/Mci0h9iR01jvJKhw?=
 =?us-ascii?Q?3BN37w+xY7sfGuExIuqcpho87T43FiNWq5I5CNUN+Ok4CcopswkPLjS/D8N8?=
 =?us-ascii?Q?8g4oZ7xCXoCU8bnZeq6LvEV9xhUw+WjcoGv962Lfr+PxVa0a/wVN+u7x1LLI?=
 =?us-ascii?Q?9wtOLeRL12MR97HH8ZPyv7q8xGJQxGWdcs5dFFbJLKkzgj/7Rs6yGfdo2U94?=
 =?us-ascii?Q?oLs+CmZxnjUWPi4je4d16RkFfqN3pfZqM5FnAVPWIJZLrtIbK7mdUEdf4beP?=
 =?us-ascii?Q?LJgYkqm3hpknUmI42ffK3h79J/+YEQPUkt/6pY/cb+NhGUoiVu+tH+wijYEu?=
 =?us-ascii?Q?hEevZRyN6KIiHyd1J7QA0O0vnktn1UIv6x3OR7F48aMDDv/NZWwvyax+6tNJ?=
 =?us-ascii?Q?MWUT5awDnfqTRWGAC1iD5ELRSJZUaaqwIhqs8Xnh9LEAu+1YiY0CQzQ2BAAh?=
 =?us-ascii?Q?13L1W4sCMNqREpE1c9iw9AplapnKvMZ/UzLflKPl/3XDU/6eRxh/WNyP3PZ0?=
 =?us-ascii?Q?hntoNSsgBYc4Qa2eblT9tPB/MUhPCkbumUN6hKjGJIv3vCoYi/m9uWzzoWWm?=
 =?us-ascii?Q?Xr+LkyRanqob6rDOLPJbIQw57Ti6NxHsiNS+Kck+S9FHjEr7KSG+ivQk91eQ?=
 =?us-ascii?Q?1WizO8FgZIMWyjPCGuzLRp6ZrqkLj8r65+DKHBfovVoVXHZcP+syiE2ZdK4Q?=
 =?us-ascii?Q?uVu/GkMVVMZHiuET2euFCbGi16o+OfOmMpcsnmJe4+y9AAtkZpfyZgFirrqX?=
 =?us-ascii?Q?dHcomDNuIJhj3yT2nfN7mnEal9eV4+8Pig5qd4Is?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa805ec5-cf1c-4cbc-e024-08dd0338fa4a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 16:42:21.0053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IEI47K1Ng7ONNvVRUTgJra+K+84Wcopj/OLmZjLmX0ft772GtJ3aUY3Pwwec2zUZ3FaIsbjYt/EsTitYaTd3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5143
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Dan points out via smatch [1] that the conversion of
> add_port_attach_ep() to use cleanup helpers gives the appearance of not
> correctly handling a pointer reassignment case.
> 
>         drivers/cxl/core/port.c:1591 add_port_attach_ep()
>         warn: re-assigning __cleanup__ ptr 'port'
> 
> The conversion to scoped_guard() complicates rather than simplifies code
> readability. It turns out that there is no bug in practice because the
> reassignment still results in correct reference accounting, but that
> deserves a separate fix.
> 
> For now, just revert the scoped_guard() conversions in preparation for
> refactoring the subtlety out of this routine.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: http://lore.kernel.org/2a19289b-0bcf-42c4-82a9-268a922535f2@stanley.mountain [1]
> Cc: Li Ming <ming4.li@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
