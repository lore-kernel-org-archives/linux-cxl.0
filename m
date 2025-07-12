Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3DA1420DD
	for <linux-cxl@vger.kernel.org>; Sat, 12 Jul 2025 04:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752295273; cv=fail; b=k+7QJk6WaiSubO08q3fipUYZI2fvW+xuCx1ESqc0LSD0LbAou0rWiI9F5nmxOsNN03xt6UHlu7BFBK7NzDwweXAtWCd8OFjZk8+uyPAKi3dsYYwn0cYCT8elvFIdw2Sxc/Cv6KbV5t4xIKzij0417JfS3ie0s3cI289SIwaJMdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752295273; c=relaxed/simple;
	bh=l/OX3Eol0wlfGO1TO7sTSfAdixwlcdV1r9hQ7d+ZaSw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DsGOKbXxdsvSpfYH80fXyummrcUXHjdToC7OQde4SxBXM9orgb7YncEJXiiCjeVRuEapUbBRESx7g8W+u+ZVnz5rAwj/qLrhpHnptJ/F7Nrw6a+MBFddoSYtV9BZOEToAvMDVlZIJrUFsju2qS3U/rEFajCnfAJEeAFsi2j5KtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dkBBzFSj; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dkBBzFSj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752295271; x=1783831271;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=l/OX3Eol0wlfGO1TO7sTSfAdixwlcdV1r9hQ7d+ZaSw=;
  b=dkBBzFSjGWAWsUPqxhpgt7jRc5UgVqx5VOmCsBgu/IHZlLDK3bBLNANT
   /t9MYSwVu00iAENq7n5DWb2Jg0BAxTx4fbaHLzOMDOk8vsXvJYkqhpluN
   hHpxEL7r5Lcg9HzwAAybvUbNbz1APpb6NUVSZO37mpE0zemJ8KDVaGzds
   6dezjis3FljfjWByobDDHDJYjdV+fi3yCF9vBMSdIg5Ktro8vcNyQGVls
   xfT4yxsLXpTOGWxQyo7KMuZz74J+O/i0pItRe4OXIC//T/Oem4lL2483/
   yQPCbh5mIgJp/g4R6C7ACgcuvnEsTCVuZ3r6wfMsR0eHJkoN6P6lYhQMp
   g==;
X-CSE-ConnectionGUID: LMkhNbasSxWES+akdaOxfg==
X-CSE-MsgGUID: k46DESxvRTmmHsF5I6o6DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65651029"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="65651029"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 21:41:08 -0700
X-CSE-ConnectionGUID: AxWbIJu7RT63e5iQ4EHA3A==
X-CSE-MsgGUID: CLNFGBhjS3amBYDUYPaQdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="155935223"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 21:41:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 21:41:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 11 Jul 2025 21:41:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 21:41:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTxurbhpaujdF269kpzRpikMnwjH7SkUJQUMLB/tyOFsU1+HamZQwJ+OZ7f6TvIBloctFj9YAC8JMMKMkOkKqieQ0pU+skPZjTSfftT5JCPRT1j1TH//iL2kuGoPLo0S03bpi5ZU9/S0QzCXwukiI5r2skEADSy2lWQ9j2OQsaV2qGXaGSYqffn5jcZBC/py7kV8B/Lpt1bryzWq5MxJ4mNfjRXYFsuZ2jL5+4n41uwNqehESvGNxYgi0wFtXGF6Ydnuo410mj9hpe8HMivzIDnQH8fBjQDCKdFp6pxFOZ2LlKoA3otMPVc/FjN35p/1S68zCMInYjKKaR0JQ2idUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yv/ankE8jpQlUYCtqReHH25VVX+RnU4oHQBL8x6z7hI=;
 b=buAEiEZ+zfEG868+ktbTSQUDtpwLeWpP2bnjIwDketb0MPQ3Q640eXBPL8QdJUDnaYER1pOEagKGQ+zPKX+cMGnBvj8db3Ea4jpBywh1fRo+t5W/JTT6FnU1QhjN2uhkBPqI2h6kk/NZnuCYtxvXPOIZM70uKZu10X4Q4/9aglnR+AxxirtFObQdLGDBrn9XtJQKIDuboZ2bdWywU4sgwLI9Jnev4xDsEZ39GsXU1csukOkzmWM8JSZTQhSoqMsFeTymTf9dCpw5zL/aTAihjhLFASgtuK29M8dPDxFGxKK70thOSd3WJHrztLGE7TZ17WLprPfhLSiKHBXt00Mn4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS4PPFFF98E87FA.namprd11.prod.outlook.com (2603:10b6:f:fc02::63) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Sat, 12 Jul
 2025 04:41:05 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Sat, 12 Jul 2025
 04:41:05 +0000
Date: Fri, 11 Jul 2025 21:40:58 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] cxl/region: Add inject and clear poison by region
 offset
Message-ID: <aHHnWgKx3YBx__8H@aschofie-mobl2.lan>
References: <cover.1751513505.git.alison.schofield@intel.com>
 <4f33bcb42217139e0884784e60139e29c647f62b.1751513505.git.alison.schofield@intel.com>
 <20250703153138.00000a00@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250703153138.00000a00@huawei.com>
X-ClientProxiedBy: BYAPR06CA0055.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::32) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS4PPFFF98E87FA:EE_
X-MS-Office365-Filtering-Correlation-Id: f02e11e1-f263-4564-8c61-08ddc0fe4ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E/Ns8dUqeR4fHvl0XOCtDcayTW0X5XRQQVpalvsfMZUG/6E459HhNze6mY5s?=
 =?us-ascii?Q?0T5nSAXPDUktmMFaoYUy+GIXTr4Xpghsquy78H2NQMw7z4TqYtb6/hBSiPXF?=
 =?us-ascii?Q?c1Nhi4Ft0Yq9ABZzMDI38DIaw1csFGXYebanPEZChf6DAIq8a6/d/nZQgr4m?=
 =?us-ascii?Q?IyqYSzAWJhRC4cmGOhBwrZ0YZaRLClmeEfiPy4UaMc1NFl64M1LMhvFlj6dV?=
 =?us-ascii?Q?Q3t94RyZWukVsZIVj8qtsHqk2pS5X3Nv1G9Z+mI6Dba3blOOVPSllmJm7QKi?=
 =?us-ascii?Q?7LrKVIMQVr7w1cTHDmL6A0lgd9NkMkgm/iHwIfkiBL+ITeHFvhBtnJWzo9+T?=
 =?us-ascii?Q?qkZ/1v88hvUq/Vbxl8qfmC75fqwlhYkauVaL4luUdsIQknE7zeQCZhiAcSNe?=
 =?us-ascii?Q?k4XPaxtUQ80vPXc3KE6ORmW0wUG7eH5GHemn1F5USureOicHKJXlPiV8/mZD?=
 =?us-ascii?Q?uOTQ8Yfk09R7HQhETWU9UA4ZiGXw4zjAptRPyUCteMB1k3q2irZ5z1j6YNwa?=
 =?us-ascii?Q?VUl/9asEG4cywEN+nxePqGpmpAW+X14gXuwglmOxTyBVINpefERVrxWPppfq?=
 =?us-ascii?Q?B17IsSMiXrV0GnlqZGX6kg54FEMiIlmooqjjHQYbgN9Oka3Imm1RVgsop+ps?=
 =?us-ascii?Q?TsnS6ACUMrr0RvINdEb70536OaoR7+Lu8E2nClb9HSYPgo0DyWGVURIeDORR?=
 =?us-ascii?Q?xEfcD6cWsHu0XX2iJlaTiPjtSTRbtvY+co0PNHkV2rn434JGvPUOwr9jtW4T?=
 =?us-ascii?Q?UYVi5ftNlv3lBhhCAcnDCyHcnPE8XzSYNx+uDXHJZFAh8MlwkDflC5PHvZta?=
 =?us-ascii?Q?U+pkNlATfvpk/wVc6BtbLYb84bn0sxvXvGtDC7vDjKk0W1tPeykLS8ItjhBe?=
 =?us-ascii?Q?Jo3XIQ2ll87a85Xgr4neADTsgnrs26Pc2kRvPUyjVCoomcr1gXbfRAj8DG5m?=
 =?us-ascii?Q?zbRN2m9D3c70hPqEKrY62zaeMLL7MqtLASG335X2mSYYQdfb0itly1L2eccm?=
 =?us-ascii?Q?cR71pFWZR3Uj5KSpJB5CNP80AE58IMtkZpAhdQVTa6y335b62dBHPkA39AAd?=
 =?us-ascii?Q?21l1BXNNCU/JUMdiNgN4nGgPPy7TPswW4l5P4pz9/hQXOHsPU00EuQOS0i7d?=
 =?us-ascii?Q?A+BQLUe9dzeaN1rXWobcRxgPvpetneepgxhIfAyCuGTwFJv7dacLy2zDR22N?=
 =?us-ascii?Q?zsBLmwJ3jRYaeG2EvtYXdvxtbYGg1g9T8OM8jxMT1aWrloygYJtfgNYooXm1?=
 =?us-ascii?Q?SAass1tEDvwMpVa6D6jFMrQmlPS8qQj3RClHHCUorYtSkdlvRpBZbNtKArZQ?=
 =?us-ascii?Q?bwMubXJGeYUzPI1Y6XBg35zRm98ttILMEbbOgtU+OMLUGhWIWJmAgqqqCT1i?=
 =?us-ascii?Q?wiFaYR+ktJuAUVhYP9JC8I8Vg9in+UNLz7o4ceiF3Moht8NqAxSTFVXqkXSh?=
 =?us-ascii?Q?Fl4kQNLeHCM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JCAvofpPjkCyW+5IveJ/U9K+ZYw10d3Apj++AvUK2h0xmCyADnuq12Mw4SXb?=
 =?us-ascii?Q?cVvXqc3kuvrVz2ediKehTYjZ7Xo79BXxGS+lbJG/QfOjZ7cTCHwiHHsaae29?=
 =?us-ascii?Q?x7uASsPUEW6Hqb8KuGrNetFFd2jtoDVY2FADbGCIuvr1q5yjKM43J4eUpZSW?=
 =?us-ascii?Q?TpIycFMdDwn9M6Rc46UeKgU+d4DmwzSP/UOTn+oAkYhpbcm58X64u3Qzr/YE?=
 =?us-ascii?Q?rX/vipl2weZMJSZe2nh/8BGPuaHrQ7P5ziPG6RaQmDlTFKIvGVp4QleJg4hE?=
 =?us-ascii?Q?3WSAxtdCMjkyB28vp91nRAaG4PkCx2OkB+PYQuay3EpTViX3BV7mFfNWHOX7?=
 =?us-ascii?Q?98Tda2E4mXJcTNM0UA7bpuv5nEHWJ40mAsQuVNfHmnWSEuMcQiyVAX2erSX4?=
 =?us-ascii?Q?CxCNaVjJnjHKMGqHM3+5VqdevvvQPiFK5xh/QBYPOBzawTsIFQ1XAjg2WB7S?=
 =?us-ascii?Q?Bawvh1En6P/B+y6WpavSqDNi9+6kOJhtOJ4Np1EUVUNcuPTKDzj4kEvOaYOA?=
 =?us-ascii?Q?dZT7EOGsbyPcbvlNVaBh6Mo66lTexwU1LtHkli+uB55u287WRvYuMBwMoX6u?=
 =?us-ascii?Q?A2LrpDwMULnFZ8nMDzVqM130iNMz8aMqH9za8YkYNoKO33W6K1AZUmSqRB8b?=
 =?us-ascii?Q?jSKusoZpbGmtFQ9T9OedPig4qsfq9+vkiahkljqVi3n9d3GK1ja5FcDj5w4b?=
 =?us-ascii?Q?RrJO3xBAauEMnnIAdwJW6btA97bxsFYkZo/xrwnKajims6iEnCEDll+ZAp92?=
 =?us-ascii?Q?jdYRBRnvqBxjhSaovvaS8/Gvug2MF86uz9mWUV4oNF0W1Bb3Fj8s0dxZmYXh?=
 =?us-ascii?Q?8gKXsE1Id0tcb80sIjYUTY3SlF0VvKzb9sl+LSnC6wfvDKoWR6G4+qtu77Js?=
 =?us-ascii?Q?wAFWdycsJhpyuHBLfTMXhx6KGCkM+ZmjB02B/m+k89zEYbvyk2LzdfRCth1y?=
 =?us-ascii?Q?Ih3mnaBBR/Js3uMSsPcJHsKWovM/EOYkbMRQ3b+N5lR5vzWV6xiIhUwYWNo/?=
 =?us-ascii?Q?0HiEn+N/3mNLx7FYcU+6b6iqpLWgTG1+Sf0+oaBsfYJa9Nfyf/zUjFXK7l6H?=
 =?us-ascii?Q?F1zaACrFyCHkuQsd0nZuB4hrSfCrGhyYFLLpT28LJQ/A+WMIa9wvt7SZ7MKi?=
 =?us-ascii?Q?k+OAEncqdNzg3Bsf6u3Vsh0pc2MNwR1OGNcqC7hPkZVLIhYQ4NOSf1kfduvz?=
 =?us-ascii?Q?BN/9++LtHhYJv6cMTEzkD8I52FeVND0pTZ++OrnGZkdVWfzx3bGKYjlF7zoY?=
 =?us-ascii?Q?SjHbCH4Dy6IWwI7MufDqyvzausaSbpRBLG1aviB0TA+FMmdFhC17d9hcwZT0?=
 =?us-ascii?Q?N2FkTBZyHrTISIEyjTEsZCGd4NUgb9SNVHwgPEH58sQRegDdgaS0CnMkz6cV?=
 =?us-ascii?Q?8IbHV+4TweNyAezHACQPWMWi1uruoBkvSGydXDuNxycFpty7T4WyeIEYxOXH?=
 =?us-ascii?Q?NSQd9qGvGGlLEQiE/9iCFPMoUc0e5TVAWCiQ5f4m5BoD+SSZULGKL1tVxSQ3?=
 =?us-ascii?Q?kB7XHWW5Frprgha/f0YigH2o78GK3aA7D7Ljf+4TedpDGoR57PwblwKh+hmi?=
 =?us-ascii?Q?u0SrfTliFJfo8pJ5F5JMUtNNHF3GYZ888kMfExLWqFqmiCA7TEumM7SSDQAA?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f02e11e1-f263-4564-8c61-08ddc0fe4ff3
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2025 04:41:05.3599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7NHY7xVNHsX2SWC0Q4xXk4NSBFwGZbIsKAh4EB+pGd3zn7CqGhPG3IW/M5itea/z/8nf9KBivlM9ttvvm/qXq53YGExWyECk6h4vhVmDvco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFFF98E87FA
X-OriginatorOrg: intel.com

On Thu, Jul 03, 2025 at 03:31:38PM +0100, Jonathan Cameron wrote:
> On Wed,  2 Jul 2025 21:03:23 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Add CXL region debugfs attributes to inject and clear poison based
> > on an offset into the region. These new interfaces allow users to
> > operate on poison at the region level without needing to resolve
> > Device Physical Addresses (DPA) or target individual memdevs.
> > 
> > The implementation uses a new helper, region_offset_to_dpa_result()
> > that applies decoder interleave logic, including XOR-based address
> > decoding when applicable. Note that XOR decodes rely on driver
> > internal xormaps which are not exposed to userspace. So, this support
> > is not only a simplification of poison operations that could be done
> > using existing per memdev operations, but also it enables this
> > functionality for XOR interleaved regions for the first time.
> > 
> > New debugfs attributes are added in /sys/kernel/debug/cxl/regionX/:
> > inject_poison and clear_poison. These are only exposed if all memdevs
> > participating in the region support both inject and clear commands,
> > ensuring consistent and reliable behavior across multi-device regions.
> > 
> > If tracing is enabled, these operations are logged as cxl_poison
> > events in /sys/kernel/tracing/trace.
> > 
> > The ABI documentation warns users of the significant risks that
> > come with using these capabilities.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> > 
> > Changes in v2:
> > Simplify return using test_bit() in cxl_memdev_has_poison() (Jonathan)
> > Use ACQUIRE() in the debugfs inject and clear funcs (DaveJ, Jonathan)
> > Fail if offset is in the extended linear cache (Jonathan)
> > Added 'cxl' to an existing ABI for memdev clear_poison
> > Redefine ABI to take a region offset, not SPA (Dan)
> > Remove KernelVersion field in ABI doc (Dan)
> > Warn against misuse in ABI doc (Dan)
> > Add validate_region_offset() helper
> > 
> > 
> >  Documentation/ABI/testing/debugfs-cxl |  89 ++++++++++++++++-
> >  drivers/cxl/core/core.h               |   4 +
> >  drivers/cxl/core/memdev.c             |   8 ++
> >  drivers/cxl/core/region.c             | 131 +++++++++++++++++++++++++-
> >  4 files changed, 228 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
> > index 12488c14be64..2989d4da96c1 100644
> > --- a/Documentation/ABI/testing/debugfs-cxl
> > +++ b/Documentation/ABI/testing/debugfs-cxl
> > @@ -19,8 +19,22 @@ Description:
> >  		is returned to the user. The inject_poison attribute is only
> >  		visible for devices supporting the capability.
> >  
> > +		TEST-ONLY INTERFACE: This interface is intended for testing
> > +		and validation purposes only. It is not a data repair mechanism
> > +		and should never be used on production systems or live data.
> >  
> > -What:		/sys/kernel/debug/memX/clear_poison
> > +		DATA LOSS RISK: For CXL persistent memory (PMEM) devices,
> > +		poison injection can result in permanent data loss. Injected
> > +		poison may render data permanently inaccessible even after
> > +		clearing, as the clear operation writes zeros and does not
> > +		recover original data.
> > +
> > +		SYSTEM STABILITY RISK: For volatile memory, poison injection
> > +		can cause kernel crashes, system instability, or unpredictable
> > +		behavior if the poisoned addresses are accessed by running code
> > +		or critical kernel structures.
> > +
> > +What:		/sys/kernel/debug/cxl/memX/clear_poison
> 
> Moved or previously a bug?  Looks like a bug, so separate patch.
> Not sure we will bother asking for a backport, but having it in here made
> me stare at that line for an unhealthy game of spot the difference.

Previous bug. Will fixup separately.

snip

> > +
> > +	rc = region_offset_to_dpa_result(cxlr, offset, &result);
> > +	if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
> > +		dev_dbg(&cxlr->dev,
> > +			"Failed to resolve DPA for region offset %#llx\n",
> > +			offset);
> > +
> > +		return -EINVAL;
> 
> If rc was set, preferable to return that. I'd split the condition
> into two parts to avoid this.

I want to dev_dbg() regardless, so how about adding the rc to dev_dbg()
and returning like this:

        rc = region_offset_to_dpa_result(cxlr, offset, &result);
        if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
                dev_dbg(&cxlr->dev,
-                       "Failed to resolve DPA for region offset %#llx\n",
-                       offset);
+                       "Failed to resolve DPA for region offset %#llx rc %d\n",
+                       offset, rc);
 
-               return -EINVAL;
+               return rc ? rc : -EINVAL;
        }



> 
> > +	}
> > +
> 
