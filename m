Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EF22E62B6;
	Fri,  4 Apr 2025 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743805172; cv=fail; b=EomK+3VPJsX7rbTqurFINIMN/WeSrpqEA3oljvmog4hhNpMXpZbRyPkc0XusEkEysVGBZHOvWG0qzivBuFRu0GR/65upMk2qb22lI6k/twSUnYWYJn8mmp2YXRaHE8gXlJrf2W6Y+c6tld7DDL2bXM4uj6uNFpVPCMdYf1djn7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743805172; c=relaxed/simple;
	bh=jINAa9IbqfXiFgSvvCk0APQQ0RH2S3bsyA5rRobw6FM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DqenAzFvBYPcGJLYLh143Ub7IhXi49i9x0ts2rL30PlZAxlny5XLSwSoy5DmoT+tPpNBgJgrzQOvvc/WLWSzgqMdJu6b0Adr9Y+ch5qqKGTRgXqAaepZcly0x5LfpkXPhRNQ6Z1CPkL684Q1+dqTqP1FnX6q+RFWXNG3EYzuTsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7wjOV/h; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7wjOV/h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743805170; x=1775341170;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jINAa9IbqfXiFgSvvCk0APQQ0RH2S3bsyA5rRobw6FM=;
  b=l7wjOV/hDYKHa6WeB2ThXVSh2XKVslxd6mzfNoUbP5peX5cuFjgK9GGK
   UYVUXlp3jF5fYBjcxoI0qtYuLp1+TUINmmDLfLvGPez/pgrP1j7a8NACm
   RjmDqqipTKamfxWRK4akEzsYDMRJGM9HUWTONtg27Hi1Zzoem5H5Vo6HP
   k+dAGAdq3gAjwwUoicHeviiQ6bm60NC0i5jWCRB7l7eKzOmASOUEyZBVo
   f323QVFQLs3QBVd1gCAbZQ2WsdtLcfj1QWJV5bUSXMQ5gXmcOcGa6Or79
   xvBdd844rN2fxF7KHLgH+hRQs7JpYZ3eUPHeAT8SRPgyetX3L5l9GfOL2
   g==;
X-CSE-ConnectionGUID: 1pdei4GaQeKay40dF2d/jw==
X-CSE-MsgGUID: hoeOIEq7R5Sq/9h27FJX+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="70627772"
X-IronPort-AV: E=Sophos;i="6.15,189,1739865600"; 
   d="scan'208";a="70627772"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 15:19:29 -0700
X-CSE-ConnectionGUID: nilBzJkgSeCMC3USU/u8tw==
X-CSE-MsgGUID: BbUAA7r3TYOBbFVbTL2jvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,189,1739865600"; 
   d="scan'208";a="158405942"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 15:19:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Apr 2025 15:19:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 4 Apr 2025 15:19:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 4 Apr 2025 15:19:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVWjT9Ks0mlu1bkcKYuJwEBn8sm+oOG5P+ymBTdnKWmzNU5tn+6FJfZL7ymA0A45tyzfIYXY6/mfhkWqkf+aMbMvGfYJ5JUsc/YHpDe+FA7ZoOQiVtoiR5cQB5viynLQ5qQhtojVjF6CbbGlEA2R1DfE5ZHx0+OuJ1xbr3YNETU89kT0YHb/2Ty/4fWBiCQ/aSGLnDN3DiRZrlfN4RJbEFtaD9ji7kNOpW0OZy2ji55VosCqHaKtf5o857qrap3sYtRC/Ec00PCfiVNKf/YeDw9r1l7gG+etR5MvPrdi3N3mJUSSI8UonzoiPH8ihm8n5XE1CJ+rBl+vR0BnrdaxZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3jG1g2H/ere2ac11DND69Z2j6syMWIvyCRvoymk67M=;
 b=WcQW9AOL48Ykxh0RR4Dc18GFp94dJB/sMm0uQnGvPG2J+5drEjtOZYK7NQQtKcs+Y9nib61CUFOazWH+WX0cmDFwBvY9e4yuhim4InxGDvTRUdhUzzfvCA8vVmpugravV5E7FmVkhIMjDmn/REIvPjbgNPJ6NG0alv3Eo2/jahLggyd6Sg6n9FY0m5qQB+LeUmOQBSvi3x7P9innVROPUDkNqFuaBDMhcm9p0pX0a8jSi2SgaipI+XhZJB+RZ8G/Td/BdPv3Dqf/IaVHSBqzfWwBM9Aze5chPZiUTt4GhjUeCakrAf5rgsybwEu3M268tvXDKguDcayqciRYLlWIIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6268.namprd11.prod.outlook.com (2603:10b6:208:3e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Fri, 4 Apr
 2025 22:19:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8583.041; Fri, 4 Apr 2025
 22:19:26 +0000
Date: Fri, 4 Apr 2025 15:19:23 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, Dan Williams
	<dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Verify CHBS length for CXL2.0
Message-ID: <67f05aeb50ea_464f7294fb@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250326074450.937819-1-lizhijian@fujitsu.com>
 <67e4c9aaedd08_138d3294ca@iweiny-mobl.notmuch>
 <1ed912df-42c7-4319-8765-3167963df7b3@fujitsu.com>
 <67e5544237027_13cb29432@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <7bbf602d-6900-4179-9737-efeb40e1566f@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7bbf602d-6900-4179-9737-efeb40e1566f@fujitsu.com>
X-ClientProxiedBy: MW2PR16CA0060.namprd16.prod.outlook.com
 (2603:10b6:907:1::37) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c1b9df-213e-4c28-5d81-08dd73c6c279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jz3PM5cpNWHJtzcWDklFxMNCCDbsiU3LI5m8HBJgAfmCUolEE69VXmjcm+ZB?=
 =?us-ascii?Q?rPPtC8xtohRHOIzOUbZAs8ZSWicqjWUxZ5iR9SKOT5MzUQUZlDZ+l6+EWFe3?=
 =?us-ascii?Q?YV6BXPuodapf1MIpyiaDUFSBFFfNJsS9XH4Ez89po4GZGazi230KSY0LdzdD?=
 =?us-ascii?Q?XR/mTk7hP9hJy2kjPmRxGzP85WXFXjUSEjvCgW+a3aqdOWb4MQpC/wRiveV+?=
 =?us-ascii?Q?qpkeCJo8MfgDuCszBvPE5FlAtEqlO1faq9dfiVH2AHszrRKBXAJreRLtciBE?=
 =?us-ascii?Q?SwdxzGLHgyU3zSIZ5YJGGhHEeSBjG9B4zNNL6HGf1asL/2uQt6rNNSBURhF7?=
 =?us-ascii?Q?q/FPLcF6X4zT1+TPhpR/qJ/5m4wfB6lveienPkp1JaPcY2coPzLciFKJ5yxQ?=
 =?us-ascii?Q?iGA6055sw4r34kf9D4xAQis61ggsZV0PWcokyG4YvgbSDYc2+dccEtbXChRP?=
 =?us-ascii?Q?mLXp86aFDg+3amwnGSg/Zcvr2cgOFQUxYwH8JlDM6xx48hTrPtpd/iiR701o?=
 =?us-ascii?Q?/6r6XyccIGHq1nJqm4BlSwXcXbOPH8ATD8MY8rd7eUr7vrecKwYFJINZp6Nk?=
 =?us-ascii?Q?f4BqfjmpGRCGugPbVfaLJoa62kRmz6MsdBQAaPGhP3xKFW10eHk/9oKJTsmP?=
 =?us-ascii?Q?FaAPztGC4ansQaz6Nyr1Fwe8QGAsLLM9SKzBVnnGksnGYiSg6sL+ivb8DPxs?=
 =?us-ascii?Q?0AUm6eP8OYadyjPtQBzAzpeMAvVVoZbj9oWEHbAibzlRZasdgGX5zlhtG922?=
 =?us-ascii?Q?1QxJwIHc/5XDbrqMKJ+Brc/oVppnK8qfVeAuqs9J6cnq7M4DWrervYhEo3ZB?=
 =?us-ascii?Q?1or4nVzn/xmcT/PqLs0GzUfuAHQ87+BDY0cujI5/oCbYrAVtlluTeeAdUM3x?=
 =?us-ascii?Q?31PQ9w//IkNZdhk9cBIwApN+YqAz5xLNaybnLHM5sKds2XySO+CU+qpgQJc3?=
 =?us-ascii?Q?Af+CvBDzqpkXDh1rjssbfbOT8HTARp6GpfItcRq6XJfxX9Vz1g/Sux6LlKsL?=
 =?us-ascii?Q?pR2bxUYjYIMS6HjPM3dQkXoHZUTqoFkPP6gphNNauFUY6ZMLWAwI3QVFCauy?=
 =?us-ascii?Q?HuDXf/WUYNfobWXsriAJQSZqlMeatEfabROwamK8gZgYGScxlb3EfbM1ubJT?=
 =?us-ascii?Q?b8giBqKNyKqF7XxMJ+5UCscnELah5swdgEPLn19R95Q5HicCkQ2P5SZkSUU9?=
 =?us-ascii?Q?C/i9wrCehMW6Yl/Zw59sdQJS6Zju3vaBMYnm5qc7JtbmK6nwxSyCA45aKsth?=
 =?us-ascii?Q?tiCllqd/La/rr7AEYC91MZg9YaqQV9C+e4GeGcceRYxIqQf8V+53Gow4brs/?=
 =?us-ascii?Q?dFzXd30hD4z3Mbc4pKJQ5A7yFD5SZbspv/Mo1Ft9PJNqCud3aXqLzIKwqHRV?=
 =?us-ascii?Q?6HN3jtV7l1RdKFyFtoQq0YgcHu3K?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DWewXiwgRsUVPx/1IXwGm8Oqb+VqhuYPQlT1RvQah5wwc9gr+6jIZ60lJviV?=
 =?us-ascii?Q?2JMd3FCaVuTDhxvL9mikS9LvMLvohIWFnYWmd1ElRfYGayrJs2fpL+q+d08z?=
 =?us-ascii?Q?DM8e/Tcq1o9i29apysYnJC8TWtEMatAf5vtzhWeRoEeJ+Z7Ee9E4BAJHCsi/?=
 =?us-ascii?Q?FZc1swSSmyZUHY53+v9Xp6rWvtniUXzk6+oz+U06ZuTOsCMKMRI1lPOhmC50?=
 =?us-ascii?Q?AKsyV4inmTNZ26PE3mXrXeGMWWHaFXwb0YW6ghMyqQHbIxOp76XUDt8cgVy+?=
 =?us-ascii?Q?ActlsKnvxr7o4FpV3LktTOvllXWXjHsrXgYLOYInkBWS2ZLKPEaJOFDRC8OT?=
 =?us-ascii?Q?xjjI+49BVxFDQA33XwEgJ4FZ5PYA6JBRuUD1ZyXlY0mK2gOYJw5Z4AaP5Qtk?=
 =?us-ascii?Q?LL3aurjlv3Iv7r1PJ0nOQeSA4XMuFoPas7c/62xTN7TeEk4K/5vTyFQBxoUT?=
 =?us-ascii?Q?fvxGoRfty9FEqKKaOBvCuJdh74JXl1ItAwJxPK+mDCIIRi9/pKAQICQ1zgtr?=
 =?us-ascii?Q?dcNCbr2BYJaw+h6VouJmujkoGMapost/MDAStWLV3EOEo5vmCoHNelF3vVfc?=
 =?us-ascii?Q?mgiFnHnVBwxj5GaHYcHmjFX1pZotptFAPxpvDERnXmLQap9d+TMDSSKby68U?=
 =?us-ascii?Q?+wp6MoFROLCIERJq71jchINcAO4SuocKJW227s3CMlPfXofzJ/jPIQEHOua2?=
 =?us-ascii?Q?Jy6xw4IKN61lUf0C618P4XLyxTm9oYXzn1el3Ud3SgkvpneN4FfAkmcr5RQ4?=
 =?us-ascii?Q?ovI4IOe5ghI7xIha/Q1pqT2btoxy0LKSZSJjlJ8lKfWWqUyLHaQV3Sz0/rn3?=
 =?us-ascii?Q?k6Jo3XKYXGcLnKeQB5DdZxynODILdvzznt6ZDYgIiM2NaIqLRRhgyV8fnfrE?=
 =?us-ascii?Q?3veMZHeoCqLvSVSayc5Bu9vIwYBJlDJaDIFN/aZomxLX4oYojFZ9cDIxt6lI?=
 =?us-ascii?Q?gFWTL0qTr9jfBoxaI9Q0MODRmAGcnHEVx06L2nA1xTuPFYipm38uBy4bkjb3?=
 =?us-ascii?Q?bEf43HFXmA/NRjMZOTCMiP+jRfIZ8NggKxAd8vRn3gfjkfSNohXd6PtIKQ/Z?=
 =?us-ascii?Q?RHOSvsGI6iMmgl5gwaiizWW2BOSjl85axDqnUt94bppGr3dUkUYLvvlmzeEd?=
 =?us-ascii?Q?lx2NeupBK5PNRoEFHT3IiH9kSAPVpdP5XHGOp6llYF70J7B1oYIfl8PtpdH5?=
 =?us-ascii?Q?fFJYsGdXAK6DgkRzHa8477ECdqGSImNkDDlmkjEsrjawDdkK34fokKTUa11I?=
 =?us-ascii?Q?yKTXjJ2hRfQpwJw93P4W7CifGdAZpuoZNTNyXNx437B7qWq1JH8TpvNEyOX9?=
 =?us-ascii?Q?Rq1bykwNhzMurTT1wyX85/KK7dgfwjbKTSdKjX+4IBvQDg8BK1kYIRKTzIGE?=
 =?us-ascii?Q?9z80Af8RewKEeCEyR3o1P0fQXQJYa4j+ro+eqJ3CeIe7xKDFhnF+bQ76TB8c?=
 =?us-ascii?Q?n8JW79U0YO9u0Fx2JUll6jB8Kzc/GMcKbstcdXrQEnM3ziZoATYIfchOTMNN?=
 =?us-ascii?Q?7QRIYGkpM2JVV7d27XmbxBjpgWu5ObgNBDAX0i3WOM0c+vSi2hF8GEYfqw30?=
 =?us-ascii?Q?5aPKflNLUc1zrV0JxzYShsTEbOtMcmd+biMcwS1/Sq7jpS1sfgebVH7FOXpy?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c1b9df-213e-4c28-5d81-08dd73c6c279
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 22:19:26.1994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ve+lDa25nHr17EY5IU1ZIpmzHMeR+t1W/sv5vDuqb0160P/gN8bFS6SZ/zqmXz1XU5kLzbHmZQaSZp37Saj9peycRiX34fzaKb54KLALKQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6268
X-OriginatorOrg: intel.com

Zhijian Li (Fujitsu) wrote:
> 
> 
> On 27/03/2025 21:36, Dan Williams wrote:
> > Zhijian Li (Fujitsu) wrote:
> >>
> >>
> >> On 27/03/2025 11:44, Ira Weiny wrote:
> >>> Li Zhijian wrote:
> >>>> Per CXL Spec r3.1 Table 9-21, both CXL1.1 and CXL2.0 have defined their
> >>>> own length, verify it to avoid an invalid CHBS
> >>>
> >>>
> >>> I think this looks fine.  But did a platform have issues with this?
> >>
> >> Not really, actually, I discovered it while reviewing the code and
> >> CXL specification.
> >>
> >> Currently, this issue arises only when I inject an incorrect length
> >> via QEMU environment. Our hardware does not experience this problem.
> >>
> >>
> >>> Does this need to be backported?
> >> I remain neutral :)
> > 
> > What does the kernel do with this invalid CHBS from QEMU? I would be
> > happy to let whatever bad effect from injecting a corrupted CHBS just
> > happen because there are plenty of ways for QEMU to confuse the kernel
> > even if the table lengths are correct.
> > 
> > Unless it has real impact I would rather not touch the kernel for every
> > possible way that QEMU can make a mistake.
> 
> 
> 
> Thank you for the feedback.
> 
> If your earlier comments were specifically about ***backporting*** this patch,
> I agree there might not be an urgent need for that.
> 
> However, regarding the discussion on whether this patch should be accepted
> upstream, TBH, I believe it is necessary.
> 
> 1. The **CXL Specification (r3.1, Table 9-21)** explicitly defines `length`
> requirements for CHBS in both CXL 1.1 and CXL 2.0 cases. Failing to
> validate this field against the spec risks misinterpretation of invalid
> configurations.

The point is that the kernel has gotten by without this check and does
not need to be aggressive. Anything more than this hunk below is
overkill:

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index cb14829bb9be..fbcb93e5beb5 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -482,6 +482,10 @@ static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
            chbs->length != CXL_RCRB_SIZE)
                return 0;
 
+       if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL20 &&
+           chbs->length != ACPI_CEDT_CHBS_LENGTH_CXL20)
+               return 0;
+
        if (!chbs->base)
                return 0;
 
> 2. As mentioned in section **2.13.8** of the *CXL Memory Device Software Guide (Rev 1.0)*,
> It's recommended to verify the CHBS length.
> 
> While the immediate impact might be limited to edge cases (e.g., incorrect QEMU configurations),
> upstreaming this aligns the kernel with spec-mandated checks and improves
> robustness for future use cases.

What set me off was that this patch was:

 1 file changed, 29 insertions(+), 16 deletions(-)

...motivated by a buggy QEMU configuration, and that the kernel has been
fine to not carry self-defense against for years. So the check has
literally not mattered in practice for a long time.

I think it is ok to do that minimal validation I suggest above to pair
with the v1.1 length check, but in general there are more ways than the
length to produce a broken CHBS and I do not want to encourage a
cxl_chbs_verify() approach to gather more and more theoretical checks
unless and until we start seeing these quirks impacting the kernel in
production use cases. Buggy QEMU is not a suitable justification for
code refactoring.
