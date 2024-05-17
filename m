Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B5F7FD;
	Fri, 17 May 2024 00:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715906626; cv=fail; b=s+s8bFsLY/j9s/YLKPVxXW72nFXtiM1+5RFggYckGyPAyeT+0FfBFRLoFgXWmXBrsuNXxMJcEzs0TIwo8J9c+rl97UVAVlH8z8kuuCQLU5NB5vqKktC0m3setyfPg9flwffkIUX8NW05cVWakyKlfb8ZW9U0p/wl2jGxN09Zt+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715906626; c=relaxed/simple;
	bh=6VpDeEoAiFBAnJ2sRb2hIWpj6IVrKB0hcIaR5wrIeb4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KbF71CqHAWEq+IA6ghq2c9y2VqBumB+6T+1fYBkOAojUw30kY95gI48n/qNYZlglfGmGAHBIum3kkzCd3YVNW8gVuarYKdrNpRiE4w36dF33CloF9jBr6hHDRfxMsI/H2PNi8Q8gLko0Xg+0rIDLOkxkwASR4//hA5lOWZuX+jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X0kDPl62; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X0kDPl62"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715906624; x=1747442624;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6VpDeEoAiFBAnJ2sRb2hIWpj6IVrKB0hcIaR5wrIeb4=;
  b=X0kDPl62P9xf8CfFl7WpdId1+pyxt/TI6SPbB1zrDwRgd7t6KoiILOr3
   zlzAPXFx4Z8hxOFA5loX447H528oiIYrzVt8mkoh9XdZ5Z/jRqu/wpLSJ
   NNdtNQzTT/olI7ZsM6u3vgkKrHeuSiiYGrPcT8td1em+xDNIQKh5t6/xs
   NvlOn+EYe47JC1YOz2xWtt5M+XHM4V3dQNp3Ehhuv/UfNQvvIWJxxtyPn
   93UF1E+ew+MS01UkNdmqcHEFdxQeoOPPRqyKOg1MT7SvYu8nEBl54HQeA
   KhSBiCc/hrt6sWQGUP+Y8Z1j6Gvqn2LGAP+GzqkeFSyuY+mAkd80GJyfF
   A==;
X-CSE-ConnectionGUID: Ylh3V7CvTpOqUp9BWFaNtA==
X-CSE-MsgGUID: uaZu3BmFQymlk/BnqsyZIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="23472013"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="23472013"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 17:43:43 -0700
X-CSE-ConnectionGUID: tVPz2a8ySPGvaeD2NGii2Q==
X-CSE-MsgGUID: FoFeP9FVRV+OnQ+d9/ozDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="31636667"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 17:43:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 17:43:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 16 May 2024 17:43:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 17:43:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Saxj2aEE4o8qslX3NWSs+JWwAxT2bZ8Po+D8qulP7kYV1YqDIp6Y7vecQLvU3XuzVdgZ1WjF7r5VFdTIv1LlUEasaFHb+xido8NShFBRrMbgBxMvHgGNhfDLYL9mPopJ1jOZql5T7SOEDXcX3y5RIiXNz/WxNeLJjQh1+bSRptlQsCpakum/n9lGUCDnhTrAxxIUCtZTJ+d1ehFngZYqdBaiOoYMn0I6Jy29dbH0vQkAtOGNX4K4wl7ItFxlO7yf1IY/uq7Z2oIdjz1nLFGPK3rRZXwzKsHnLlTRuQ3eJEtuoRGaUwUnhoJo0MOHrr9FQz7eMrG3TdXXXPdj1gSCPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdvBcSSqtz/bYbH7U7TiVlRMLO68p5DeR5ezV/fkSIo=;
 b=jjHJ4UOiYKjnCqN2tPzRN0BRJbVTHiPwMedEQTCsp4Ncq5Wwo2XrLoIkuhmp6j5+acds4dP0R23az24tRNoY4zYwsSl4kO5ZU6j0yXhGNW2q55/Ue0MIQFbi3ayb1sM4Xm95JvFxEf/1TQKHDzXxd1zC2UUjGTbDVfBhcV9NRPZ9dK5qX5mxK6JmIonkcx73T8l9tEg1vI9rcPBkCytB6ZSJ5t66RxpMWI7AxC9lhPFSZmajCqV/nGz5uCdFb0NNE875g7Xy958EakEUzufuuFO35sSRuZupa9T7RDCdbBcixcKR5ENusQ8iDKiK9V3oqZp99LwE4tmaj30SM8f+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB6694.namprd11.prod.outlook.com (2603:10b6:a03:44d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Fri, 17 May
 2024 00:43:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 00:43:36 +0000
Date: Thu, 16 May 2024 17:43:33 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: RE: [PATCH v2] cxl/events: Use a common struct for DRAM and General
 Media events
Message-ID: <6646a835ac144_2c26294da@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240516102116.3512377-1-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240516102116.3512377-1-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: MW3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:303:2b::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f1142b-ecd5-4500-f93b-08dc760a62f6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|921011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pNf6+PdjKz1hq4Tyf4SAbsZHqxIFkhbELjnIB/eWfdAwJjmV2SbNfvVF8nuy?=
 =?us-ascii?Q?vAvbA9qns9WptSy/PDL/eDrmzCBVCcoSug3HJOZBMJBzUj0qaFekDxX7bgJQ?=
 =?us-ascii?Q?fV7SGrdZ6OoKr1SrV1omrdAGMXwmLP/mFgTiy5cYJURZmMSYK+vLp1f/MWIC?=
 =?us-ascii?Q?bYj+cNUXoqiK1etgUzqHZM1PQ23ZNq3sOCKn5b/H+41XoiW9Zru09dxEE3VW?=
 =?us-ascii?Q?gD0DSWrRVSMWOT8m/ujuyf/D0c87wkjmmvaKJTB/3h3ELJPmGRuQz7F4o2iX?=
 =?us-ascii?Q?WGb1qn9O21abLBz91VqYAa8Ns9NKog1+2X0omGgRniyAD4QELqYGO+ES+QQ3?=
 =?us-ascii?Q?/dtu+iM9d3bx1r6XKEEMIw2pDjcyrEtQ4AZMwwL7WZW8pLPC/3iQWSUH7wn6?=
 =?us-ascii?Q?jdLQWEFhDJSgzbiNBDH84w0uUz8xsItB5FTQnSenKetRTE4OWu8wvanvmBWJ?=
 =?us-ascii?Q?sIi8SaKPgvt6QPrI5ddDqUsWJdom168TZhrvYB3M40sGLrYpKMnZAeMS9Cua?=
 =?us-ascii?Q?HzSChHcJQjSwgKghRTVXviouUNCgmmI1PfmcyJdDCYz1FEqSICViutIZG4pp?=
 =?us-ascii?Q?k0L3qiqJ9vriouxm+wHvHRw4sa6hIPVd7EHxI4GpNydi/8iiu31r6IW7c1bX?=
 =?us-ascii?Q?zHF7XsxFXGRwUxtlNUvS9Gkj5gz0fp2eFIq3f6KqSsC7zxUmh7MHT3k6Iy0K?=
 =?us-ascii?Q?usrWAyRxpUeoidwuo91V/Mz0ZuY0+rVdQviSmWfVpXAIB4lz+HHot8MRRmpk?=
 =?us-ascii?Q?+IpGeM73dI9x24t13gUOuSuwIBt1RiTmifhH8fnPy91HlBmQm7/MEK7trQUU?=
 =?us-ascii?Q?LRRxar/UpS5msjlwrHAEESAKMFKakuGdJDZUPH3HiMjIEAtGWgMjKm7VJR9N?=
 =?us-ascii?Q?0pf++Dhpxa4vrPkm8C57GSxrATE2M4krpnFZBK33zFvbqpbLkPyyUMjDZ2aG?=
 =?us-ascii?Q?8JK3+4XZ9+elKUV9HfgOY44RqPL1ZUeHu0aZfb6dZtCuv1d0PQYrfrCWup3j?=
 =?us-ascii?Q?e9qkuEkR5sYnA5nnidyodZhLolAIaIQTmaY0wTwyBci2EKBBc+G+kxU0HqUC?=
 =?us-ascii?Q?SJfYdM6iI0aLU+wlalxNT+ZmyzBirGoQTB6mPFYV9TFPn0mrqbiuy0XPYHFC?=
 =?us-ascii?Q?/6gHTlWlT1IJpVapTqJpl1VmbQE5PjjUTQ7rh95YfX/7BUUb66oIfsntegwF?=
 =?us-ascii?Q?xghneo+guGt5Z6uzgKVPD0ZTu114v/2mesQh8PDP19IbVUMdOgLYNPQMSJpf?=
 =?us-ascii?Q?1Lv0ra0q7IRMV+HzAMbthGk3S/nlNrcJgcuT7yHHOPkcWue4nw/sKtYArovO?=
 =?us-ascii?Q?L16viFlYOwIOPYQLmepE34LN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ivMPDXyPqlr4MiPyzK9ZT2BBh5lqR+elnPEXgfOPIMtZtreWexx4oYGMg/sm?=
 =?us-ascii?Q?zbv0MYakSZJWmZX24y7u5RBDR225nO2GgQzwu0o2sMi9+K5M3ixyHnUFoZVb?=
 =?us-ascii?Q?ITT+MDqLhVh8sgiaPMRbf1F12tENWopMtTBZmvTIslBIH0sEp66bOB9KcfiN?=
 =?us-ascii?Q?2fqIXMEjfphI01xJ3UAU0vVz37sPhf1WMXqBF/K2Hzc0O0gKvBYvYLoybWTo?=
 =?us-ascii?Q?al/eNOx6BlIP2ydLiJyVIGS3sA1Aoo6wdXv5VzY9xhQ/YTRFP70CCS8whVIm?=
 =?us-ascii?Q?FWuwrp0xdpx9tcLASeqAZeFsQMk+3KJLmP50hXPidn77LY6YCOs/kE+z7ppn?=
 =?us-ascii?Q?SQwzMArJqfdP4bg8nb/6d3Zth4Pl38I9AWRWdu21GXwIDmnt+m4sFLXI0YsS?=
 =?us-ascii?Q?dugTyqUDkSfhAB+wH5ihfvI8ZOB86Kyu7Y32l3EM5ETSbUbgatxR+oKgJOGx?=
 =?us-ascii?Q?8HTBq5h6kTUGGpFwvO9uuESspc2I3nSQfDGBqGXSrzSRwnT9DoD76O6ytYL7?=
 =?us-ascii?Q?7PvhxZOlcO+8K9jqTBvoilchR2FO7y9SOf/akn3GrF3HHoCWmXf4i842Rc19?=
 =?us-ascii?Q?dNcZzIAagka4Vgp+V6TsDMq2tkbqX+2jXOm8hItai7CHgvOfhmYNQQGkNGv3?=
 =?us-ascii?Q?iY1TXFTG+qBy4+fw44zAamU9HARNKKhea5qxrTLX4EnkvhjKFPNRFQgHb6hC?=
 =?us-ascii?Q?6gZYydBbjW85ndtES4j2Y9V5Jn1JAdFs7Sm0soxDaUTkqcFy6Ag6k2rNOolO?=
 =?us-ascii?Q?DsNrWctguLC7LKiTi1wVnocng2e8uidVLDexGuMkJMqwiOab7FRnRPOvn30j?=
 =?us-ascii?Q?rQAS+C2tVQynQL4NBfnWzPB3odPmv70eFgZdHRGC55Pzeb5RQMNPIgZOyOlR?=
 =?us-ascii?Q?Hdc5lfl1wkOi8UZT5riya9tR0J11Of+gxuWMwG6NxNpDtjppqhO1i/0aTkC0?=
 =?us-ascii?Q?9RHEslX0GMOaI/mdmfXXgjFd8bqwF1IdjGDlGqxqJGGV7x4E/C+xFVVFX9y7?=
 =?us-ascii?Q?oSMCpwJH7kPSfvc3RVwQsH76/+bv7zgU21uYL5F77pAx9SO6DWUl7zoRN5V0?=
 =?us-ascii?Q?rvQB7Qnr0bVRVCCO7hydJq416WDh9KU0uLX8kJeNvG5sg1jBhPOvpT2bpG0v?=
 =?us-ascii?Q?sVBtRY9DWAf0B6LRBMXKvzWOX13E9JtEmD5YM+9Y6W1hN+Z75XdXsFA1epDi?=
 =?us-ascii?Q?fCGh2sq7xZiyJSiRM/uH10sTndOmQf4K3iKI9TGD0kWizyuGie8V9OBTxz88?=
 =?us-ascii?Q?c6UeR0tMNoo48nk6Fpzu2wJZ56YM2lHA0YuFArAX5wKMvbS6e5wBSfp3zkwB?=
 =?us-ascii?Q?aokxh6omvNwkfZi9dzFxa7hpx1v+sMQ06p3xqlNdwZ6YSIC1hW5u49tIIhUS?=
 =?us-ascii?Q?hjaHG9/hog2hxDTdXhkn4+paidnP1AoF6vhx+sSt9rI5aSo2jZjGUatcEXWC?=
 =?us-ascii?Q?aygbiXuj0zQLYIfdIXQ2pCpqWOTrZvIrLTf7DWIOV9wKx/BJVkZ1kCve5kr8?=
 =?us-ascii?Q?GxvMeutli707WqegBaKdr/yM3Hm7QW3NFhN3jouxEq6CzRjcTXIyWQKdhrvC?=
 =?us-ascii?Q?KwpdynO4oMtKaP1gIZCk3Jvfz+1kpdl+qPcSd777p50+NqFqizpiuT4pYqbw?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f1142b-ecd5-4500-f93b-08dc760a62f6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 00:43:36.2942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Olmm1ZDSJpRSy0n2Joob/psRBCB0BFxweHT7/RiuK0DKniqvCnuGXwg09I136NJ9hXy51EJxHDfSsCrbyUz83Vvpmuh2Mp2mmCVOSkcucKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6694
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> cxl_event_common was a poor naming choice and caused confusion with the
> existing Common Event Record.

I would say "unfortunate" rather than "poor".

> Use cxl_event_media as a common structure to record information about DRAM
> and General Media events because it simplifies handling the two events.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Fixes: 6aec00139d3a ("cxl/core: Add region info to cxl_general_media and cxl_dram events")

What is the fix? There is no user visible behavior changes that results from
this cleanup, right?

> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
> 
> Changes for v2:
> 	- Extend the commit message (Alison);
> 	- Add a "Fixes" tag (Alison, thanks).
> 
>  drivers/cxl/core/mbox.c      |  6 ++--
>  drivers/cxl/core/trace.h     |  4 +--
>  include/linux/cxl-event.h    | 70 +++++++++++++++---------------------
>  tools/testing/cxl/test/mem.c |  4 +--
>  4 files changed, 36 insertions(+), 48 deletions(-)

Oh, nice, net reduction in code I was not expecting.

> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2626f3fff201..ad4d7b0f7f4d 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -875,16 +875,16 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  		guard(rwsem_read)(&cxl_region_rwsem);
>  		guard(rwsem_read)(&cxl_dpa_rwsem);
>  
> -		dpa = le64_to_cpu(evt->common.phys_addr) & CXL_DPA_MASK;
> +		dpa = le64_to_cpu(evt->media_common.phys_addr) & CXL_DPA_MASK;

I was hoping at the end of this to get rid of the word "common" to avoid any
more "common event record confusion".

>  		cxlr = cxl_dpa_to_region(cxlmd, dpa);
>  		if (cxlr)
>  			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
>  
>  		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
>  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
> -						&evt->gen_media);
> +						&evt->media_general);
>  		else if (event_type == CXL_CPER_EVENT_DRAM)
> -			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->dram);
> +			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->media_dram);
>  	}
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 07a0394b1d99..2c7293761bb2 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -316,7 +316,7 @@ TRACE_EVENT(cxl_generic_event,
>  TRACE_EVENT(cxl_general_media,
>  
>  	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
> -		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_gen_media *rec),
> +		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_media *rec),
>  
>  	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
>  
> @@ -413,7 +413,7 @@ TRACE_EVENT(cxl_general_media,
>  TRACE_EVENT(cxl_dram,
>  
>  	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
> -		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_dram *rec),
> +		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_media *rec),
>  
>  	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
>  
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 60b25020281f..e417556cc120 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -32,41 +32,38 @@ struct cxl_event_generic {
>   * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
>   */
>  #define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
> -struct cxl_event_gen_media {
> -	struct cxl_event_record_hdr hdr;
> -	__le64 phys_addr;
> -	u8 descriptor;
> -	u8 type;
> -	u8 transaction_type;
> -	u8 validity_flags[2];
> -	u8 channel;
> -	u8 rank;
> -	u8 device[3];
> -	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> -	u8 reserved[46];
> -} __packed;
> -
>  /*
>   * DRAM Event Record - DER
>   * CXL rev 3.0 section 8.2.9.2.1.2; Table 3-44
>   */
>  #define CXL_EVENT_DER_CORRECTION_MASK_SIZE	0x20
> -struct cxl_event_dram {
> +struct cxl_event_media {
>  	struct cxl_event_record_hdr hdr;
> -	__le64 phys_addr;
> -	u8 descriptor;
> -	u8 type;
> -	u8 transaction_type;
> -	u8 validity_flags[2];
> -	u8 channel;
> -	u8 rank;
> -	u8 nibble_mask[3];
> -	u8 bank_group;
> -	u8 bank;
> -	u8 row[3];
> -	u8 column[2];
> -	u8 correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
> -	u8 reserved[0x17];
> +	struct_group_tagged(cxl_event_media_hdr, media_hdr,
> +		__le64 phys_addr;
> +		u8 descriptor;
> +		u8 type;
> +		u8 transaction_type;
> +		u8 validity_flags[2];
> +		u8 channel;
> +		u8 rank;
> +	);

Oh nice you went for the full 'struct_group_tagged' proposal. However, given
that Jonathan is already asking questions about "__packed", lets do the simpler
change, something like this, what do you think? This also preserves type-safety.

diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 60b25020281f..f48b59943977 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -33,14 +33,16 @@ struct cxl_event_generic {
  */
 #define CXL_EVENT_GEN_MED_COMP_ID_SIZE 0x10
 struct cxl_event_gen_media {
-       struct cxl_event_record_hdr hdr;
-       __le64 phys_addr;
-       u8 descriptor;
-       u8 type;
-       u8 transaction_type;
-       u8 validity_flags[2];
-       u8 channel;
-       u8 rank;
+       struct cxl_event_media_hdr {
+               struct cxl_event_record_hdr hdr;
+               __le64 phys_addr;
+               u8 descriptor;
+               u8 type;
+               u8 transaction_type;
+               u8 validity_flags[2];
+               u8 channel;
+               u8 rank;
+       } hdr;
        u8 device[3];
        u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
        u8 reserved[46];
@@ -52,14 +54,7 @@ struct cxl_event_gen_media {
  */
 #define CXL_EVENT_DER_CORRECTION_MASK_SIZE     0x20
 struct cxl_event_dram {
-       struct cxl_event_record_hdr hdr;
-       __le64 phys_addr;
-       u8 descriptor;
-       u8 type;
-       u8 transaction_type;
-       u8 validity_flags[2];
-       u8 channel;
-       u8 rank;
+       struct cxl_event_media_hdr hdr;
        u8 nibble_mask[3];
        u8 bank_group;
        u8 bank;
@@ -109,7 +104,7 @@ union cxl_event {
        struct cxl_event_gen_media gen_media;
        struct cxl_event_dram dram;
        struct cxl_event_mem_module mem_module;
-       struct cxl_event_common common;
+       struct cxl_event_media_hdr media_hdr;
 } __packed;
 
 /*
