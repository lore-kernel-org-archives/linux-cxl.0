Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216CB221F13;
	Wed, 14 Jan 2026 03:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768360603; cv=fail; b=YKHa94mIj33VNBbQUEezsplJ5IaDrQFbpy+NTwjJ9ShPVKr8yqnJMILz+EbJGTizmtoVRqAnA3x+ZYxFcDYvwwROwzhBQ4xBv/bUbg7p39i4YIUezzj/oI9nsSr9mZgbk258NY29FSYoVd5LJKn9jz5gsvEZ6XwKpZ7f+mP15pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768360603; c=relaxed/simple;
	bh=s5qWdIAiJTM1lBPu33D5aty4yXsKkJv3mEvp312b4Bk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EnbNLrpkUVOKlGWfY74mT2U/ThoDmYNxXRVxxxoIC5IeUU66t63ZpzBdq9ujb9aqVrohjXDkSGirHRkDQAKnapZP/bA3pbpD4Jgnj+Lj0YVoxyHSAVAkorBPKYKcZt9EMO2412pOEyqSf9FN9/OvT2I1iycOMlhPIIclRAMAarA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCnYPaRl; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCnYPaRl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768360602; x=1799896602;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s5qWdIAiJTM1lBPu33D5aty4yXsKkJv3mEvp312b4Bk=;
  b=GCnYPaRl1SbmZOUkYeWNEOtAiAZptwRJdZ2u4jSI4etzIxvPlYPdZr0M
   lR1iTYGLh+gAdLc6X2qbn0CpmaM2wrLRTFWryFcP5OxRYUImyfn6r1b/D
   Y+OiUpj0/gSZfv28dJkH3XZrXYkGEFsMbsNGu/G9Wjlp2sdAU1kKrZS3Z
   hF5jmVbFcCLchX3xDPPUhcE92NHBJTOYh3Niq3x5CFWQe4dxLPcF5cR59
   iqCPtgsoPj/bOCT7pOmUWUXN0HGYj7H0dcr4LmMDG7j9Si3j2ox1mj/41
   o4hsbA0+sPEPuUR9KBDX6TCbqm/VuT5b6y4nzbKPXqKveKJAZ6oAUDcXj
   A==;
X-CSE-ConnectionGUID: 5/Tx1MtwQE68hUE1wMN00Q==
X-CSE-MsgGUID: uJCWVDaKSpWJLkAfYHPQIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="68862857"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="68862857"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:16:42 -0800
X-CSE-ConnectionGUID: CEX8AXkPR4iKoPpq2B679g==
X-CSE-MsgGUID: GinBvHNGS9+R0LXze4Ggdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="209073502"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:16:42 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 19:16:41 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 19:16:41 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.70) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 19:16:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdM0zBe4udQki3Nk9mnfe0PLCdmYIi6J+TqRAX/ABD7tFTMXkCUgU3Ea1yHg2XRV9pFG4rp4mfq1gC/PAZnPKBd/py4jWQ6grgDRYVGRK1e6x4nRSIMdrmy6bZu7iYl8jNhJm9DF/ufYC5j7gPOTUGmCxd7cJKyhEiC6zQfCfF5MraSfO5aman0lQj/0Z75lShMV4Qh75Xks/xoLXHefumCJmC3vm/IO5ClCEIOO2hK0d/n3apEKxvyJ1eqAuKD6OQ9ObuYAGPvPjmo9pT6E7+CQ3E1FRgw08YFVhi6e/uCrQPb+SaopqiYpjES0zcoQ7GF6aKTOnj3JzNIuypAOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mIDyT4JpQ/ybhdS3uXxjNeU/kLGhHfEtOHefpjn6zQ=;
 b=v9gfEQXgKswRH/Taw/KZtFeQrZ0j4reRFH/4fJwI5f0WmV/vSHddhoqxzUiRt/8CKAArYAaxaCPBJ7AoE45t/JlOrr3QROGIrfIEP1n7Xv+KPtoR3K1nu8VsRDTvqWT963spXkIbLrY88mXyCJ3kYTTBiBd9A4Z0bupdeeApF7101q2u2fz78zM2zSrhsWLa/Vf74rBqlsM4mGTmwbYv0HGMbQ30oJgYbNlqhFB0HJC8dA6gdVk03INeO3y5C5InltXvEiVVwbDcGXIQwKvLnDYkPvCbRYJWT0K90HYMVGgvDTdNf9yD7VuHlJoRv7Oecdp8xeVd1dDDI4+p1bY1dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by PH0PR11MB7166.namprd11.prod.outlook.com
 (2603:10b6:510:1e9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 03:16:38 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::28b8:802:3fb0:4bdc]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::28b8:802:3fb0:4bdc%6]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 03:16:38 +0000
Date: Tue, 13 Jan 2026 19:16:34 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v9 04/13] cxl: Simplify cxl_root_ops allocation and
 handling
Message-ID: <aWcKkliPbj1FoSiQ@aschofie-mobl2.lan>
References: <20260110114705.681676-1-rrichter@amd.com>
 <20260110114705.681676-5-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260110114705.681676-5-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::18) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|PH0PR11MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5e4264-ee81-4b6a-a37e-08de531b547d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9uDP6QgOTKbTU4jpIxNONSjOY6Siqu3Cc6tG0XTQgTreXFHPqHrFHGfzCLkK?=
 =?us-ascii?Q?IVS3frsMhEPtme4Xw7PnRJmrb3rVm4eypnNqmproBqODAGKiV4K+rj7WnXb5?=
 =?us-ascii?Q?0q2y+QrNcHlIBlIa9CVyrdaCbjgXYm9e8M8n9yCk+gWIzwYYz8CWurUi3DVz?=
 =?us-ascii?Q?yHTo7wPOKa13gyhSRZLbL5EUEllNRxrlqX4cSDK0JJoPDh76l8DuCllwNVql?=
 =?us-ascii?Q?ARA0hnI+WFZp33L9AuH3uNMvfYfswR7RoXJayIdSicKCJe+fBccrl2mvG9a2?=
 =?us-ascii?Q?pM5wZkjjDsIG2OQc2f2Zax+Qq7gPx+oVZmGRYk6POp0LcYr/wlUqUyB56fyA?=
 =?us-ascii?Q?SB9+2BfaNDD1+l4EDnaPvPV035rKIjje6cZ1NLhFqgRoQvj0oG88usuI5baB?=
 =?us-ascii?Q?06d/85Z8S9GE9GCc4Iv2tBJd/z9cDPvUzbmLM830kX9FjUHEoNUy2Dg7Tj9x?=
 =?us-ascii?Q?y9dRf2N3/H448VVzEKUBlfsk3nMRoc4mseKG9AlLoyTfaDFZ4OoGVfYqtYZL?=
 =?us-ascii?Q?mra2fGlEl+lsxh0DJYn77p88oXhENm6jE3Vci5QGyFX13zn0OUuMVptr+Ecv?=
 =?us-ascii?Q?jUVQpVAceBq9MUvHCw+Ofd0ogQ9w6qR7bJDKhTi5rYN18HvUfSrUEk5Hb3YX?=
 =?us-ascii?Q?a+qT09bcmaWnfGwmBL7njHaI2sIfsFqao2iPUxLrribGfBHGsZUrA6Szz6rJ?=
 =?us-ascii?Q?ETLK8n1pMUuB9pbCqysEmEXAte990Z1qmAFzTWD3qP/Ki1KsiMC+c7i+AKVf?=
 =?us-ascii?Q?HROEfZqe3rCtRMTC02bwTFV+V2HdZB+TvHktVe9LOcRcW7UokxXBKWlZEv2j?=
 =?us-ascii?Q?ISsObXTtXm/i1O8tXTRyp4BhrRvOq+p7uQDv7CbeIUOJY7RKJB8Biqm60o9M?=
 =?us-ascii?Q?Y5XScggVwH5yZIo+wjpbNiTNAIvAn4uiPg046sGKa8mgp4jJu1858gRLItFi?=
 =?us-ascii?Q?gWvcpHCAQXmgSgQsAHUhQLTKgkvK6E6s2R/xALwMZHBxsHnHKHw2pCyDCrSW?=
 =?us-ascii?Q?TUobx1fhkxNNXeQvK9xapuVtV73G7MVl27+u78O8+MwFWFdA6J5OqKg0Hlsl?=
 =?us-ascii?Q?4O0YuGf/eA4UgeBAb8UvOUjvFkjs5KQnyACU4SdjgTpwYhnHpaKOPYqI/XGC?=
 =?us-ascii?Q?BPzPr5OvLsEIQH+t2NvUnwtjBEKuE8SYsGUHuFkDTh32zL+1AmCxO5p/Iugf?=
 =?us-ascii?Q?zMi/IURfPn+P8pJOG5LWLypimyQMOH9Q1QP1OU79lFMyTWVIZ+qUFpa79F6n?=
 =?us-ascii?Q?ZFagfsqOy7y0W3tWj2LkOj1qm9P0TC2YlZHcHwWUm0y3PzrShW0D7H55Ls27?=
 =?us-ascii?Q?PgPfw4vgs0K0IdnR7fMiAplnqD6C+jMNf4CYfSmCbi+VyAoMznKYg3h8xTOR?=
 =?us-ascii?Q?absoeUj79aCZvmu13juUp6NU8MYPCtJ6bW5AB1q+oLpAJI9Y7h+KPYxHukae?=
 =?us-ascii?Q?Y/QYnV/nxSAe1JaLYEVtLMLh8vWbJIWs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lx0J+uzTqdLW5MIGJKFTQnRkCW/H5ApDQpKYjlGHRpo/itw/5K49xxTFMTgN?=
 =?us-ascii?Q?y1/+h6Ppwo2xbrCWtShSvuU5ENENO3R92jkoVcUm5tYyhDMf+LRMIf//EAW7?=
 =?us-ascii?Q?q5PVFKQiwB7M8Il7v9RlvENUQG3UPBPX0791d4EwK1XKdgydATUKjZm0dICB?=
 =?us-ascii?Q?lLj7lob+1v29+ZFPRMDSA4IoyBAXMwzuiqQGH7PE2XOpIg/oUAxp9lwRHgCd?=
 =?us-ascii?Q?Wd+DjKclrWO/UPxXcxmZ3nMKg3oku+W3LpefhA1YYgpHVUnLfwoiBbaLrCId?=
 =?us-ascii?Q?iwvXoxRyAWTmHyL+r28xNnbwv60yJo2VB1F7OZt+FHa2ltlzSWgZp1AugO77?=
 =?us-ascii?Q?G0KHsn5w+hIMaA2yNj+EViceb2pdwULJ1XGbyM3ye2zTbuRbCAfjETHaOviR?=
 =?us-ascii?Q?hTwByewZwTHsuREdmv2VmZ0WdlB3sMSc9coHabRCUW+/MAlwJwEe4SjWm3rw?=
 =?us-ascii?Q?m10J1vj6nUT/HvUxnMpskoa5Whky9q0H7qQUU51w4Igx+zHmZCcPI5QVFRAJ?=
 =?us-ascii?Q?0AgHopHkz+8kpQY761YvnG3+H7BE8t1CWvpteQHTlNo+rQixsnfxst+E1rRH?=
 =?us-ascii?Q?QSTMAzZ6+ekhnupjKJTMRd8m1ybvDC9b7x33JdDxWfWHOiLTcVcY1KEL8QH9?=
 =?us-ascii?Q?JZFIukQ11OfYC+38W+Sxsui/Cn6Yr+t1YvOxaRqxIdgW7hsaxneT4A/LxR4P?=
 =?us-ascii?Q?u8x3O8sGEuePHGQYUekr4qpAQEX783ZpnqXMm+6wtsXRf1SK0xwIkZBfzEMP?=
 =?us-ascii?Q?kiBT3RTnqBZb2MKXpgCHCpaYw/J7wcGQezO0w62HX08jJsAryOmvprc6LjWo?=
 =?us-ascii?Q?fu6+40921YC0/wUtloEtMHadmBfCYwoa3qsgMJOYugft2laO2BvmUWr8JndZ?=
 =?us-ascii?Q?qa8J4npl0xuvetjwUggi7vTU8x57rXC6ZdTuWnzknWdD/dlajt2mcmkhfLOo?=
 =?us-ascii?Q?awmPKcu2zsR1hZXC2AzwvULE+34y13eOv8r95XGhcx5WBt0sb9U13H/IuBv8?=
 =?us-ascii?Q?r3de1YThN+z2RvMIvkECdaknSzTs4jSO4JIHE5x3Pif8pQKFNVOqevlQ/AmO?=
 =?us-ascii?Q?hA7OIL4MDc0crMwayZDem4KR7dYH3IgnKxhxzKjVSq7jG4kFDfpjevfhKNjz?=
 =?us-ascii?Q?XW1chZLA5dE5Z1fuQa5OXkMkLoSSwTbMEdMQhs4+DM+5GoEfCclUsEUnzGHD?=
 =?us-ascii?Q?7DvZA93KZ4Q1cMk9sV9OhEjs8cs2nlnJTtVyUctW1WvZMMjdyT9p9ChBdoKM?=
 =?us-ascii?Q?jySi0mt17voceJdLK9CrG1cZpCZ0oAeEAI9zYYDrmRYfaQi/WESSbrSVCY29?=
 =?us-ascii?Q?KrMEYBz6m5L69UTpr+xmM24atZEWKNX9wmf3I+PkBf+RrtQbMS2iaxLUMgMx?=
 =?us-ascii?Q?Rrpf9TexcZkNXoUO8QFFD+SviRRC3a3DOAspEyOw0ed35XTKb9utAS5xRvng?=
 =?us-ascii?Q?1bQv394VJJ1ELEoIbUiBxjRAicP6S9THsq3PcSG5k66N7RAg1NbH1yXOB/Ad?=
 =?us-ascii?Q?ThmiPN16cTVNOYBANhGwdlA7bONpObTf4/p6o7i2PwHwN1e0nUbkNj2X55k7?=
 =?us-ascii?Q?8uM6MXS4Nx3Vx1cDiUowTAkPC3uIIbE+G5GAFV1ZJe+2rDsClcLpT0kjkxHr?=
 =?us-ascii?Q?ZYgPqNt3UUbpjhAY1Hm3aHDG+7NThM3sugTWHuXGp51MGCqw2CSCg+r3xewq?=
 =?us-ascii?Q?E1PurzmXSp+QTlTDmTTsnVsmVWTzzLFOJj40El6Imc0mUT9SyW2D9fDL8IZp?=
 =?us-ascii?Q?e/pEKWI1y7PZIPjW74/WD/CzFLtdXhs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5e4264-ee81-4b6a-a37e-08de531b547d
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 03:16:38.0852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWcdIboOTjSLPFeV4lV6PcRR9un+wpT8mbcVyGrOOreNa9JkDqOGLglTi6qWhrfczAyYlyKVNyHBxpf68b+adeef48eyrnZgCoYkudi6rlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7166
X-OriginatorOrg: intel.com

On Sat, Jan 10, 2026 at 12:46:49PM +0100, Robert Richter wrote:
> A root port's callback handlers are collected in struct cxl_root_ops.
> The structure is dynamically allocated, though it contains only a
> single pointer in it. This also requires to check two pointers to
> check for the existance of a callback.
> 
> Simplify the allocation, release and handler check by embedding the
> ops statically in struct cxl_root.
> 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

