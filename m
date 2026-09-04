Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1115038DC77
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 03:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491569; cv=fail; b=ZpzUJ8KSdSzmNPEDGcGRyCsQnUzuMmbBluNH4HlsK9e/1+E4DgxDEUnxLCoEoB5Q813FHD5aKzUdrbh2YNIzSahk1YlLqTKbvgGGIVUz857cKf7lDGuNfql7JqFlo41W5U5jm+a6Y/X2Uw2ySeWKOGjAdUnOudpTvxAyLFjeDYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491569; c=relaxed/simple;
	bh=vEpDmt6gt1813aJhGlSzKrqC9Frd1/iIlGK69JwyyCo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mgjRi87GboX6fwDY4BMWdzep76BxyvXNodQSVwmHZlfh01Wdh2y/24wbx6m8us1MzIzxakj/FJ84LcGMR4/1Aom3LM+cfaOSUUrka89/6mj86o0DkZAJWpYTaINDiMiwla07MFnpZt44miLGTnzF9/tUFW+blEw1BCLtT4y9LPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=crUaWDMO; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="crUaWDMO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788491567; x=1820027567;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vEpDmt6gt1813aJhGlSzKrqC9Frd1/iIlGK69JwyyCo=;
  b=crUaWDMOaOZjS7FNUGU1bCvNVkSDHrNDUWCIqGzy9cadR6SmVPc3StWk
   lMBpGbsrXMJV/8gSze+2+pqxsX6Di+MF71gHgSYPLJxqsjgXxUFdYGDSG
   jqcajBWP6NpIxOv8qvxWQ/fw3xado+Qhw9qEVQMGQpCZVvL6hX1F8Ws0+
   nCyRtVN5bTNP1vFSfBo7esLQ+5jRKi6Br3KgMNF3iJEmil2oM+ZU8GGd2
   BqC4qTKNZfjL0bKE8k6+2hL6/edrdar+HSPWPWhgqoJ+fYuz76xWH1tHd
   pHhjmNCowIkwH2KpOYQhnGjBCIzuS24GyJjbwT6J5IGx/cdKjRhY9PQiN
   w==;
X-CSE-ConnectionGUID: irARpw6YQUusk+Ih0Z9Sww==
X-CSE-MsgGUID: w20NnkdHSwacCbZ2vNClyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="106356489"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="106356489"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 20:12:46 -0700
X-CSE-ConnectionGUID: UPTlwlP5Ryqzei686x5ZCg==
X-CSE-MsgGUID: ygMpp5sLT92i8aUzX3ZgcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="293432406"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 20:12:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 20:12:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 20:12:46 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.18) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 20:12:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4elRSlLjXrKCj3gxizhahAcovAkd1HR4qKT0FJweMTO3q5iUo3ROjhiHBVus0Qk2v/Pm4vdsBVbXpt3GE+VgpLr/xxkdu8EVpjtUpfOpjVXkwlUtFsC6165G8jIZpi/hM4TS3zE0orXVOJVIcyQAuN/awt16sioaQz5gY8Jd92Ursh3p0Sy9P0da34DG9v/tgJyYTvjWdMjVfIiEGYVynJruvKBYJ72AEtSfZsxNtcFTEff/ogUBgoweb2EbutZ15KgObo1zRPcCzRbCk4Ty7LemkMISJKFdlBQP3A+/G1eLR622lcw0NmTujASCpzeXAP+FxCw+lICnUHV/G2Jdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBqBVOYXR+4RlyIYX+iRQ6gT/a4H0Km4zsCV+6JNksE=;
 b=N1yy70UprbHLcHMF9f8cl8zfXujoPx7wrREnCcgbUzSj6Y56+XFJOeJ5pJf5vLydwbn0x2yLgeAzbQs86WtL2VrxDnqM+HreDlDdqQWNle3ck88cEukn8sl0agrOJN2IFiFKzvbn5h9gjBq6Hw1g4U0yXtwZUQrBdSs2CPGkJ9XjwpJsP6ddg8HR8/DYj47s3Ztz+EIW2A2VcnXcU+bqy28oC2vijPfvuybw0+il9Pzqdl90uPlnXJ7hapAk0fQpbyRj5BGl8fpb1i0cDMcs364/IzVGMYr3a39SI1QmgFp89Afi5g/M2zANiaonCWL/29D3EldAH/9o/KhNucP8JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH8PR11MB6659.namprd11.prod.outlook.com (2603:10b6:510:1c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Fri, 4 Sep
 2026 03:12:39 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 03:12:39 +0000
Date: Thu, 3 Sep 2026 20:12:36 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] cxl/test: Add a 2-way 16K root decoder for
 passthrough testing
Message-ID: <apo3JK06B3AVHcoG@aschofie-mobl2.lan>
References: <cover.1784940306.git.alison.schofield@intel.com>
 <e89552a2c51b63657da50c9286d48ab858016721.1784940306.git.alison.schofield@intel.com>
 <amxRzTxrPiwhlsx1@MWDK4CY14F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <amxRzTxrPiwhlsx1@MWDK4CY14F>
X-ClientProxiedBy: SJ0PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::29) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH8PR11MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a654e2-b0ff-4055-6aaf-08df0a326083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|6133799003|22082099003|11063799006|56012099006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: NilNaXT1+/6c0JJD+kLs4tTyAErN4QhzGL/W9VQcMnLHANsTQ0PsFvrCj4ItFrmIdUlDS/RDKPbjeyv0ApheGp3SQZqDvtbV/SjCQDcFGLfVx1vjp36dE65a3UkfN02rp48o+D8lHcpB65ayndywmwqkK3/UE0xFvRXK8e04Er/JyBmgM2ivTmqPsgEouNJ7mycYw7Fs5em7xrRdKisCDAbEudOjwV2cE12G4T1k9t5DGoS93odbQ3RCrbQw6BIEYHGDXvZpRGWwJR2qKYHHyGDxc5GWTzUcxxe+WwJ7B4Y8KdijBTXBIflvRwzDIyMNGg7cX/NthyxdjKCY8e5jFXK+F5zupf9mBIqS8jBtVh0NaR3N90bz0MK6LK3zMM0vrOqNb0ofJVolQXZSC8hPzi0DzbKA0+uVvDFk6yB7ab9sRTVqL7s++L4osPAeI1N0KRAHZ2WQzPy8VfKqguc/bMccnehCNSwVduFD4MNFnptvqmyStmFPDxXRJASYuWHD0IlEcWQTJ8p41lt7tWtfHv4FzESSpuXj3K8ibUX0n3WpcOm3w+Lt+3dCOuDH9CWoIFIr8JwZFpTbsliHvH35rBjIW9tOKyszvFkS3rTIstZwwd6Gs8pUvdqB+ptweIe5gjd5isPLqtOOOh74Nt1k9Kdy5cznNRTePpLfvQ7u2d4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(11063799006)(56012099006)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QtcrTBF+3ze5pGZoWyOFLlW4KeGv4vZaw1jJUHb3IaMumwiyDEyXj2hm5ctH?=
 =?us-ascii?Q?gcGFbfVfY6T6t5aHwKnCcn6mNcMc0By9CG3znsrCXY03o+XzuYO4YdfaB01Q?=
 =?us-ascii?Q?jH1dDfG5sPLNLrtSboERI5yVLSWWjkwhFLJh4cAKFCgvBBo6mdVO7oRfEmUJ?=
 =?us-ascii?Q?tJ3YAHR+sM4syIJnG+8uuR+cGqYqRnzq75tOedJoooVVVryjg1iKGJOfFyFy?=
 =?us-ascii?Q?7SV5HONGExpKl40YsUn5wHuVxeqj4L8EUHj2/zQq6BLY/ZGY7pXx0BaD/ad9?=
 =?us-ascii?Q?eQS+Gpz+1fiXuMeAuhJ0JGpukac4j/8u4pJzgW5V8lCEHfCMg/HX+biY+GNj?=
 =?us-ascii?Q?a7pKJkTJnd8oKvp8HCgzSwGE+FmsBCXCyfnT9OjOfdAQr81V4BzoRITh4cAU?=
 =?us-ascii?Q?HNPinzAsMg+Y+1CvUWVJlnlK7kkiN+QwmJioV8WY5q44vIDV8eShqNDRmv/j?=
 =?us-ascii?Q?fN4fLQk53jY4U/d8FXTNVXZJboQsrkhX3tDsDLp8oUybuyUadMJEC5GMVbrr?=
 =?us-ascii?Q?JQDA1v/f9BNrU/Pomk297WUjJerVHLjxGru0NwUxqjkh4Y9fYcPKNQdN7P5m?=
 =?us-ascii?Q?VaO+d+68G9zHd470fRd7DWh1ursJhNd6Me0lYRdjNd+UZZEwS+k/owqQezf4?=
 =?us-ascii?Q?2VP67lSrpzAkSVj6icpesIRA7RHkPGYQkmqZwzekSgd9ngbTCzwElRkfqL2s?=
 =?us-ascii?Q?ie8Gr1ZyOyDw23Xa+EMXnpKOYU6cNw+1f+H1MsURCsxR+sJdLd0NJZl2Tjk4?=
 =?us-ascii?Q?6hzNHUScuYXKHmuPSydyLA+HxVnJuNHofEIaFzYDfkIUvXD+14FXuHZACsry?=
 =?us-ascii?Q?RO/ICTgI3sD3tEItq1e49SnJM6NH6DHDjWr5bRDZyKlT/qBEeFbsHgCp/c9X?=
 =?us-ascii?Q?KPSUXyQPrP9eCPnMDG5JEXX3C8UVdxmag0A1zcmZnOESvr2u/17YrFB2tZZU?=
 =?us-ascii?Q?eHRdpBlSd+PMH/sUQNeZ0ob/qlE0UBMI5II4ONLZpPubkb2EGMIdAfUYp1aY?=
 =?us-ascii?Q?f+EQyMj/PqvdXG+Kou2IlJJ2h4YYNRiNSDf50fIywHx2vYntZT1cHjPPgEEW?=
 =?us-ascii?Q?Z2z984dgeq7wiVuoFTzwyKc8PAO5k3Q/Vzm3kzLUKeXbQtabbypx06Hn76AA?=
 =?us-ascii?Q?1kjTi6kbBms0m5FwXxdFOIQiYnMjYE28aMc08+E522MZ5aFpy6f9o0dflpwg?=
 =?us-ascii?Q?hn8pA3frVxEpWn84z2CXFGGw10vJ2TF29XhH1Zel6anCD1vzVDIfGpPM0sL5?=
 =?us-ascii?Q?KwwlIgDlY1MtIg31qYpnevqrx7BPVt4kDS+usu/p/Yyshu5HfTBVDknGumts?=
 =?us-ascii?Q?icZZUxH4ccThuX7BtLNVGmMcHCoF4zZ0u/DMdKXBKifKHzqFbAt322aMcYYQ?=
 =?us-ascii?Q?USHL/yKfTAXBuIu1gz437hsCPDLXCuXy+edBgOLwuswXgawIxDB3rpAQhX5W?=
 =?us-ascii?Q?OySbG9ndJyB1kaYpK6EnkhRR1GgNFvFqsJcDkSjxewlktPCe6j3Hr3FxOFYl?=
 =?us-ascii?Q?H6jo8wauB0Lr9Wlr9YOzSTwh63qmrIqVs68h0YM3Kjj/uRdKApYBljjymPyX?=
 =?us-ascii?Q?BCD8OJuMvz42OUJL3R7M/KvRAgcXPeQwPPlFRL5sVemiQo1b16UdbFXZlMfI?=
 =?us-ascii?Q?0Y5CbsjFq66juIMw2sUgp8JXut0XbuSxubZhzek9lJrekPkYn6+L7wILrt95?=
 =?us-ascii?Q?bC7UDntzgkKCzs6UvuYL0ipjdEJ4X1l+tNt6uOpaCe0c+sX3uNRN2NgCPXSc?=
 =?us-ascii?Q?GGY3jlCLKyr+tIi7bDV+c6pY/plj95M=3D?=
X-Exchange-RoutingPolicyChecked: bc+z2NxNhKjmiqFeJLbIj0+zONfqmM6MY7Z8gcg9MwG28Xiv4rasRB3njzZygRy54f9hcO6dJ8TomOcauBftTVW9kaTI67FcuA9xLe+QgdZd7qjOX8Gk46pSQVhy80Ac2WoRd2+zHi2ZdC4O3ZH1AWg13zQKbPaKnYY+4e3ziQ40WjLkyvcik0cEM0kbinoM8Rm3uUssAj+pYK1BF1wfVByQQPvX8IneZ/XQB7AScepGklv+IVWO/T638LCEKSxD43IM54lYF5suLUOwGgouB2UutVA2kdr3bk+bVWHJNUWq7deCL0u6oswiiOr2FWpCJpin3pkXLg2LZdur8wFlfA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a654e2-b0ff-4055-6aaf-08df0a326083
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 03:12:39.5830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Y+JCRm5PN/rpjCFBqmlM2cWOQJ77TIqfR28zVut3t0BcYVpmoAEUhB/5SLyWgVxwOAnTeR8CZSO6XV8Yzn38tc45wpM15XV8Psd2iPhlkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6659
X-OriginatorOrg: intel.com

On Fri, Jul 31, 2026 at 03:44:18PM +0800, Richard Cheng wrote:
> On Fri, Jul 24, 2026 at 06:08:55PM +0800, Alison Schofield wrote:
> > The cxl-test topologies do not provide a configuration where pass-
> > through decoders compute a granularity above the 16K max encodable
> > in hardware. The widest power-of-2 root decoder currently available
> > is 2-way at 4K granularity, so a passthrough decoder below it
> > computes at most 16K.
> >
> 
> I think 2-way with 4K granularity computes 8K, not 16K.
> The conclusion does hold, just the number.

Yes and thanks for the review. Fixed up in v4.

-- Alison
