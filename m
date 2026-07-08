Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B541F03DE
	for <linux-cxl@vger.kernel.org>; Wed,  8 Jul 2026 02:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783476329; cv=fail; b=M4sSdikhC4nLNPSPodJPVkODCe9ZPOpse8uIa1KkThOv3YDxUkgqVXAVn8nNb7CRDAOsfxVO+/buYdiVyWwnbytg2XfW8xVVG2px5wAGv1iHKDfrAwbieXeqsjIweIlI19dp4zVsmX+fuxyyEVWX1nkpU2tI88G/2l7hoVv1m90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783476329; c=relaxed/simple;
	bh=ijlH1JVsd0sWXXD/27DUEIa+unrfmoXwIybpDtJ1utE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I6djnQ34qJvCwOv729kOtkLjfIZpQPV3nGUJPHUXDdT++h+G6/tKNjAf2yrtfhir6rA3Cw3z4qfzGLGSaEfmmY23rPUItkWamMDhzHsoPuwIOKwElIz2wPCdTRmcgxT3IfEds3r9Ef8xW8DMv2I6PeU/5NVhdzAI1NWN46WhcK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6Mozqf+; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6Mozqf+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783476328; x=1815012328;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ijlH1JVsd0sWXXD/27DUEIa+unrfmoXwIybpDtJ1utE=;
  b=a6Mozqf+0inPx0oPMdfomtQG3+nE0ssXdntxxuqk2W/U+F5DpEFO0fPw
   BINq1gDf6ZFSAaK+qC9p4DpcB1PBNnlq3vm6APfCeQk3McVRz37/IM5JN
   ktMTbYMEhiqFNHhHTwlhOp90oPPQ2c8HC2QB0g4uDaF7w0sdIVEdVlR27
   QWYq20fHNXMRgWbAyg+TTn4IQvhTWA+GKinjBZHEffaF/PAxjosdzVh0K
   5xXp7JUrt+Ywl0hoS5MGMtqJkwv3i2zD8lECYI2HFPx3xef0oDvxKQY+h
   Soj4xSzbqMZxamkr1C5SchGYr/Es6o5aAnBoMsco3HZ1Z+UujHLfU1kvM
   A==;
X-CSE-ConnectionGUID: cy01O1HdQVqXmms62L/nLQ==
X-CSE-MsgGUID: MQQY/hDaQOiix2p99WvzHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84228655"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84228655"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:05:28 -0700
X-CSE-ConnectionGUID: 1dNqYmNtTiqgy6iMmvGgjA==
X-CSE-MsgGUID: +o8YuZAWR8aIZoSEYorLug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="247773958"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:05:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 19:05:26 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 19:05:26 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.37) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 19:05:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4lC8SufVI/megATC/9ThnjjdSFa1+VI/KJI8g9VZZzqr+4YjAvDI065imqyceRREeJq4BCCTJDnTgi3heWlWFtPP2I1EP60rkSP3RKJ/J2nAWmfIJwI1oMjqQBM+/2TtCiyme+wlyWNnUOFhWUiSGafS0JlyR899eX00X3OJmMWjpGT2LwAbSOIJtF0n4MHQ8V/bLpyFh2j14j1j0UsZJMajQNdHkVS6LFp/BrpgcGltzZCHafttJ8cL8NYZhwjs1YwVc+bwGiM60NzmDxLk8Jl3YxS+jj6a/dLtXTwOy2bffMhCQMq+YWOWMVo7c5yQmwCiMS0jiLzrdO6JeoUYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pTzr+f62Ul/cghdXUxxHcb7E99g+z2Cy0e7kBRe+lg=;
 b=HFZU27kpsLpOvcsYYZqRoGfyiezwq67QcBjjsBKj9lfU3TwAO02lQBaJss8HM9/2nUqKcWFNOfFeMUEulD4g7c0yviE6DLwMIEINXU0jfxAmLMXWEBCSWI7T1oTZ9UzZHpS/VJ1LbzhZv60sVmBI8OdinMF3nm2mwTzBzKe7thQrac1axHAEAk/BYqQhKdV/lc9DidR0PuN7Q9bvE9h0sjfeErc/eMvk5uN7qf5jfCbkVTSaoi9Ib9Ds3esE7Kys8+n6v/1siSY/KeekkbU8C8okxuATgo5nuHtP2KsSUBIZ4Lam0CrIoML4jwQ49VxZhwrSDtlteY9U2QU980L+3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH3PPF6E8D29981.namprd11.prod.outlook.com (2603:10b6:518:1::d2d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 02:05:23 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 02:05:23 +0000
Date: Tue, 7 Jul 2026 19:05:20 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] cxl/region: Validate interleave selector bits
Message-ID: <ak2wYJqHjTg6Ol3U@aschofie-mobl2.lan>
References: <cover.1781199122.git.alison.schofield@intel.com>
 <5ac370e484caeb49c334d5a586a7ec8fc1b3dc38.1781199122.git.alison.schofield@intel.com>
 <aj5kbdsqLPge-rkT@rric.localdomain>
 <aj6Y4VLUdPjF-pAP@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aj6Y4VLUdPjF-pAP@rric.localdomain>
X-ClientProxiedBy: SJ0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::27) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH3PPF6E8D29981:EE_
X-MS-Office365-Filtering-Correlation-Id: a3eb116b-46ed-4731-4076-08dedc955ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: osDbGg+w7vnGqdbW33HJPx8KDKfcy0IaNy0dzelh6fOKQ91KdOUnS+RWEoxOM+zHam7fljmQ5zlRaa6r4mtoaAFhDe2O8+wHJsIeufab9ImaPU4vGHC0C3Y++bMhPahABdIUsGrAcl5aUFycRMDwO3l1ZMv0mhNGW9BwOaVU6MiQW65Js8HBuC2R2YQ9H9hUokIF46kWLRvg8uuf4tC7C6ABeIrn0cDS9g0xVz4jz8VDrYj/YavguWf5rVFGqiEsT2QgVdJQiytJKric3/DvbgSPGfoWz21n5s4hJcP9pNWyuY1AtPdCAYcJu8q2hEUpms03aXmeAhoeA7dLmlIAIpOSRDkXIkWTexL4jhJiIH7zbk6Z1+qdC0VjBN94Ovz3EJBCeqbcPGSoJhyNN5KPACZCUPpqRYqOVQeWLfn0hYnqRk4GxGGM8kye1Mb4lCA4JzzHPsDyKOoZNQYD28usrwHGfFaS8NB0Zb7OXqGTgT2dryqz5cZ4xkk0mYQSKox1G4D3/dq2LCgA2lNhLKKZ2HF7onEDafUEr9gaCSaSR2xvIjBK1MtHyail5aEFjOHRiPCX9iEY9xVYNr8cV9w67ESJdRGM9PVedHhZn745Alk22gH+Wn9Da+66tVnUXmmWz+i9B0nODsDb5eJKGmc6WTGii8j2ces58FuEtFyy1s0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XUlh2iUwpJtsy9GRT4oylNSGbuycBzT1Z0juGPltwbd2TFL/N0/P0xi7Yq8s?=
 =?us-ascii?Q?tFY5YLccuGOP6+9b/VhOOgFMM6FAOViJvoOSxxMlybf+/buO7WtsNFKZgSx0?=
 =?us-ascii?Q?MYRNI5z9dNDtIgcwdM/dT8wIALSiqeLjwRQ9xSC5daXabjlgFh0ud39vP9hm?=
 =?us-ascii?Q?mL4a+qgkxHdslz251o7nEE+KUZyao+wM/PLPpP7KeweQU1VjsLl6uck0HKOh?=
 =?us-ascii?Q?/xmA4umyC52gXNn7Sbg+4lwQCvOXsZLq2f5Wis1NH4jys1Fft8Wo0yY2oMBX?=
 =?us-ascii?Q?p/lO6S3EerNQkKTWKI2DzowVnEsAxbFYG4Tpg8NLjUaM2N7etogHEY7DYcyF?=
 =?us-ascii?Q?km02TaRJWdQKnbeRG8pI2zHuccjX8YHAKaVlZbctJE6clzkElm7Ik2TqUfKM?=
 =?us-ascii?Q?ZvIV9pyI9JDRZqrQWBdNmg/zddBQpciSkyhTOBrRSqj4OLms7JZAsOEQfXhZ?=
 =?us-ascii?Q?BD8wz/y3xm7iNdszOvC/d39XofWt8DVOHLiUtmLmG/rSkP3bkHskYcIUHtvf?=
 =?us-ascii?Q?Stn1rA6DZzFArhquTY0GkScFLk+Hc5THbTmGsWP0L6tmOz+yc+XJaygT2lvB?=
 =?us-ascii?Q?/ve7xLQvF2wMKlC9q/lgRXa44lNEJoloL/6Gg9MahAB4+w28q/2nVilMiouz?=
 =?us-ascii?Q?quEX40uyis15y3Sf+YAlgvveaoAPoXiOXuoEvRM6LPlSu5uwE5mfhclBK4Vt?=
 =?us-ascii?Q?3rg3gwgpM8xPz5gXCYzFF792r6ywKrDhXt5i2wwj8BB4ZNKMVQfP9mqNi5iE?=
 =?us-ascii?Q?NYP+YjIEw1NgJ7/fevF6OCs89yWyvC+NaWBRJ31pkMRQxtsKxxtd7Lq7vXZc?=
 =?us-ascii?Q?GRBoIGY+AD17pHFKDQPJY4lUZvJ26qpB0jAOF4vEIfUIMGPXivaTr33OKPCw?=
 =?us-ascii?Q?aUefucYRl7dbKNYpJXEffglfKoWMvs2gRLyLbXvBxLboPsgEqhhwTcDoTmWc?=
 =?us-ascii?Q?3rS8zZb+bSmnKa6RvBfNLp0Q3ZnshXbnGXrPONrNdXuXFHPe+C7m/EMfdKRM?=
 =?us-ascii?Q?Iu9mn2CCQn5gGWfaOZwx89JneMGx6I5ChDUT3PiktQ4ptCbduBmxhjocD+eQ?=
 =?us-ascii?Q?gOwX+Wr46fB4K23O2xiuBTe0K7PpSQaRI8m9lmAZGl0uT9NJL4Cbjl5V6bCL?=
 =?us-ascii?Q?CWNUw9engr9zE4kh4++s23OcysQ3YHJtJLgUUUW0S6RUqSlFjfmujZYH2HqE?=
 =?us-ascii?Q?BVTFSdALgFEn0SenhmDPEdBkU88oAjq7446+DgPAulwZ6JNjSxa6GhwkbJHp?=
 =?us-ascii?Q?3gocDWWyvxFHsoJSIH6zhSGsmpq10a+aOd/wlgFk5hCLMN+qe7VRUUjq5W2k?=
 =?us-ascii?Q?M1Uab/UBqE+JGdkWCptxys06njzR9/psTfgSGC+BDN1ycJr3zDTaDSE7FWjN?=
 =?us-ascii?Q?IzMTg5ZGU1ZTFIfgKEqE0Q0/bmkl1SPIh1imUxXpI5Gi6wqNjb5BQawYiseP?=
 =?us-ascii?Q?cLfofn5MKrZSvCj3jM8UtPajhohAa2KSz3whQicqK0dFkENWkXv0cDBR53rR?=
 =?us-ascii?Q?td4Df+HN5Oqu3cvi1WgUkGfVeih4CY4NZ0uTJ+T3UgbcHiUkNlmG9lnD26q+?=
 =?us-ascii?Q?UOoyQ19MREK1Ku4p/V7OOb0Hf+9KgQHwHF4A+SVg9S5trgr3iaaG1+SUo8pn?=
 =?us-ascii?Q?jeInYboG7N490zWH6ymNeMzCKlzoO9X2tPB0KqLKbMqyifOG2jwBcqnFxrpd?=
 =?us-ascii?Q?Kl4NAm8mlEdlKcrumO/RU6AEuPf2cIvhTLI31hkaurfGm8vGjSy1DXzYSsDB?=
 =?us-ascii?Q?UFMvXKgbbeU2wxcsGvoaDRLXj5oCRvI=3D?=
X-Exchange-RoutingPolicyChecked: rCXmOm6OWQowj/X5If7KHXlWsBpAau42Df8V+cUX7m8URHxmf9mfubpIasfYFtdgh8mrZGj6Ps/Tby8dLJCzcD3AIResWCKa+SnIm/CTg+pOkbv6kjBw5mjlq3TrXdcRTWGuKeQmBJSBpZVr0zvRvNFxgCQFwoOeRn0UGbutYPrsrIU1qqV99GVKN7vc5z+1FfZg9tRxDed7sEVIsHQYyz8pihOqzwRz1cCH2t2aSldVCywcZVti9KU/HuDw2zPGryM+Oz7peQv2HVslMRbG6ghXF0hu5iedS8Xp0NtW6J3OqfHdN5PbusCw1TX4hqAbXg41SFswDa5RD817UflRAw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a3eb116b-46ed-4731-4076-08dedc955ee8
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 02:05:23.5311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pcg2Pzt17UDpNqfPkGDlSfQxwPZgJFo1d5x8e9I87ovdqdjplgSUgcug5dDpW1/7It+a7QAYGHkEh4ZwhVrNyydHW6VbIifRo8eGKgzQzts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF6E8D29981
X-OriginatorOrg: intel.com

On Fri, Jun 26, 2026 at 05:21:05PM +0200, Robert Richter wrote:
> On 26.06.26 13:37:22, Robert Richter wrote:
> > On 11.06.26 10:47:25, Alison Schofield wrote:
> 
> > > @@ -2067,6 +2062,11 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> > >  		return -ENXIO;
> > >  	}
> > >  
> > > +	/* Keep this patch bisectable until position arithmetic is updated */
> > > +	if (cxlrd->cxlsd.cxld.interleave_granularity >
> > > +	    p->interleave_granularity)
> > > +		return -ENXIO;
> > > +
> > 
> > Hmm, that looks odd, even if it's only temporary. Could you explain
> > why that is needed here.
> 
> Ok, I missed the point that the iterator stops at !is_cxl_root(iter)
> and thus does not consider the cfmws interleaving configs of the root
> decoders here, which are not part of the parent selector bit mask
> then.
> 
> That creates a 4th selector bit mask for the root decoders to keep
> track of. With that added I think all the stride handling in patch #3
> to calculate the endpoint positions can be simplified.

You're right that the root decoder's configuration has to be part of the
model, and v3 adds the root decoder's selectors to the validation
accumulation as you describe.

On the second sentence, whether that simplifies the stride handling in 3/6,
I did the comparison, and the stride turns out to carry the same
information as the root decoder's selectors. See reply on 3/6

-- Alison

> 
> -Robert
