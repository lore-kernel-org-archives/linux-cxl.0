Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CB225EF82;
	Thu, 19 Jun 2025 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750367884; cv=fail; b=MFJp3wDm7YB0pBSN/LrHE0h8Amz4mSrFWKhm1vD9JnkaDzcuSS/k3KbCIjGGtlDkFyKOMW3aOjb2J6Nve5Sovnh1TkFsymzq0pSbFjtF+sbzEkqlacOJWkBrXWRDWhDhyr6LlVqh0CBZh78F6zQcvoRHiy4gR8OgsXR6RWYI43U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750367884; c=relaxed/simple;
	bh=Tum8l6AiByR9sCEuI7NR0/G4MxOh5ewGHSCBDsb47hA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bPMXCUsieqHQBAW1L6+lFtP/D3rnGpIy7hdM8w0Ff/9ZY+IorfAgZAVIcomAfQcD6CN7j3DIwDc3fxvDtzwveUJhnG0dTGFqtiaecmTIYwIoLal/tfLyiEyfMosxC9DTBqwP+cQd/yIv2b4ZYppZLYGLPIsOuPLfZOf8memE2Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cq4Pbznz; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cq4Pbznz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750367883; x=1781903883;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Tum8l6AiByR9sCEuI7NR0/G4MxOh5ewGHSCBDsb47hA=;
  b=cq4PbznzJmPFNqKkwAB5Vs/kFYmN0nMtH7uIRazucqbigHFowgkYg/Wf
   mwZNtQAnjLTxUQODYZYlUqlmv/Y1chF56DqniPbRmQN29USfLDemSyis8
   MGe89Jmt4PixR2NIwe73oZu0w92IzM7G5Vv6g53U1YxGNxSldN9T8hAzD
   ctskdde673wwV4gKJg5jtVQ6v0P0Aqk7mQewMiMr8y8G8ok3NUPF5ycC2
   Wcag66Qe0R52uTcodmWI+QsRl7dJxzB456XKzcT3Vx/L9pRvlHNGvye7x
   yCExhOK/ZBvu3CynF3SNWt4U/B7AsbUXv2mmfVSLcZbVV3lpDRsz3nTdX
   w==;
X-CSE-ConnectionGUID: yFAp+SgtQFG+9pJKJVFMSA==
X-CSE-MsgGUID: HtPx4CgwQlGIPFhGMHCAkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="56450302"
X-IronPort-AV: E=Sophos;i="6.16,249,1744095600"; 
   d="scan'208";a="56450302"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 14:18:02 -0700
X-CSE-ConnectionGUID: dF/ePoU5SlWM3AI2XrI81A==
X-CSE-MsgGUID: oeToiUMdTFqwa6G7Fyu76Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,249,1744095600"; 
   d="scan'208";a="155013399"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 14:18:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 14:18:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 19 Jun 2025 14:18:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.87)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 14:18:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myk/R3T08yPOVomKlpytM/i0I1N5jTr0NL6JjkYy/4Y7YUZ2mdNSucoH2R0COiuHbs6/gU3iKw0MiEtMoQ9oOQMsGOqscJ/Ur4Yg0jMwsSyzgWKgCAQzjMVr3mf0kbz+P6z6pI54SGD93oplFDGWbjQtJtsXyeIo+Cl1uqhOwjbGIXTLqcKyGTBmqeLmfD3y9odlhheKPjyHs44TZMn7xrTdTz7jvoA3KIj7prdp2nL92+PPBn/6g6mKJvJ4CIodz7QjQC9nydULAK6v6xn3ZjK07ri82IZvljPEWcUMne55+yi0RzGA97jo6Nvwlf7aENt2nISgsy0pM/L5s/jvAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFrRIofJyGkULHTIdnJzVEmPukyx+m4wU+uWYN2ae0U=;
 b=Nc6yaIDez4TDexx2uATM4GL4225KZ6BZGmcXjkWTa3TuxIWN02vYse/efia4/d8T3+nnDpKVL05kco1Q7J9I+WE4lW6KiRejOPU13fGoyObFUwNfTZK8QD0i9BsYL8899mqlr85TpubhIJ1N+pMJ3Sy7ZQAxJmfHzxhpSEBuirUK3xY48+yDGrp48RygRsUPcIf63K9lZ9FbK0vrjoUgz1JH9mf8/66GDJhG7BSt3qL0w6yGOATRVzMJ0ptpLc4f8yC+prOvDFhlC12B29+jcLm44MyXu6D5yB2xCTMcInuEIq+ByKHIQcABI3+hxjn1EO9dg4NlWBGVUR6U0leF1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CYYPR11MB8405.namprd11.prod.outlook.com (2603:10b6:930:c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 21:17:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 21:17:45 +0000
Date: Thu, 19 Jun 2025 14:17:42 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, David Lechner <dlechner@baylibre.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH v2 1/8] cleanup: Introduce ACQUIRE() and ACQUIRE_ERR()
 for conditional locks
Message-ID: <68547e76d1dc_1f8d1008f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
 <20250619050416.782871-2-dan.j.williams@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250619050416.782871-2-dan.j.williams@intel.com>
X-ClientProxiedBy: SJ0PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CYYPR11MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ecf8ae-5255-4363-f0e2-08ddaf76bc2b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XEey/romohd3U665LGFg3xiBtAE8cr5r6rxBsSAoJWgyLToCDRo4daRllbAV?=
 =?us-ascii?Q?yzRkKwvwC6I/0FIP9o8FOBtXWjjUoQkHE0ICNj6bvf2aYP7fJZgpPe3RgexS?=
 =?us-ascii?Q?a9MWQdAwwvwG0NuWbHMYbFBBpXfMtwrFt7aNp6cPXH/GEGf45jfInilHkFSP?=
 =?us-ascii?Q?bSm63DC/05HJ/GU/WRGHRukSyFS5SzjQ0kuOWlaTrBMVlTEGRnb0HMtDgnX0?=
 =?us-ascii?Q?4a2yEfRLuqAMPEZ1PzZetLZR3YAbUffjV1iv8lyqVAOob2K4aEYuV1FH3NiW?=
 =?us-ascii?Q?e3g/7f/iWT0fwGfX8uJMCESEn/bYi3VSapeBIXIIY+ROhbITigGMkOay8toc?=
 =?us-ascii?Q?QAnDyW2GmDEOGdTLJJ7peGXuRbuGgXPzId9lSPGjm8sjd8hcbBOwHzRLTpNd?=
 =?us-ascii?Q?2l/VBJBkiBHZJKy1ZorBbX1+RvhD5JEjWUaT3+MfJvvxc7eI+qiypUXrdoFH?=
 =?us-ascii?Q?6vKYdhWJCBCyh8+d9k2UWtbRJqgl/3yGUQ11Qyhq+QAuGzPtBYBhHLC8fkLm?=
 =?us-ascii?Q?PzGQqN1rhjzfxiRKbV1bz+RktZYsKkO+iYKs2E3gyRejz3lRxG+H2Y3PyuvY?=
 =?us-ascii?Q?idSa8CNYrqiwsPqCpymdY2DdgjWYwxVuTqGfOHfw9MegJwmyMtMb3I6zqF7l?=
 =?us-ascii?Q?f0GlQpoUMem3E1oULaopGL/+LVSq0abPQyZgHvaL4wOUlLjTxp/r8REGYGFl?=
 =?us-ascii?Q?cIjkPPhIrullRzOMJmzm6b3wwtuxuSOFkAB/04wjTuMTyRkFhpRG5DNVRsOT?=
 =?us-ascii?Q?Fw2JmhKxw1sbgbjtloK4SVrTDZNURmv6txVeAMM8lVLSiXIBet/0P5M1dEzB?=
 =?us-ascii?Q?KiLwFI0vDrcZ9+H1/ky2iuWFQKxfGdfSvQxSQ7wkll8dOPsTq8nylyKKKB+v?=
 =?us-ascii?Q?ObCGwTIRA8FdWcud/3zsLOG4w5SNsZO0Ggqp6REXkczao1ifo2g3sGA8Vy1d?=
 =?us-ascii?Q?EUr4cmuB0r4SpPrWhhIPvAhGgM85NDTKUl3M8pmEQDOfZaKWxtfSC0jEZP3n?=
 =?us-ascii?Q?A3+2YPUtau5u0abdxj7XVaukpjJjYUE51DmHhS5+fsogJI+rdOW5QZB1cf53?=
 =?us-ascii?Q?iit4o6aq0dY4VyLnvGHFI5SQCuWegUV4KltUgp0M2uVZUAPi/gPjXKreY+Uu?=
 =?us-ascii?Q?PoTfKG2rMoLk4N/ixBfMm3CUUgAmpG+CgdSUSYkt4CnvdPtlo9Y68pxBV1Zc?=
 =?us-ascii?Q?43QCM25B+Rolz6XKyM5+/YxwxQfd8xW3GobkDRRZFQLlLMM8OXyBQsADsruV?=
 =?us-ascii?Q?XzC5yc/FLrObvIETZpJG8OnKI/jyNofB2aZPemfNRmu2u56R8+1cEL9kcL1G?=
 =?us-ascii?Q?gfsGnGq2IJ0oJDYPqy8TUphdQ7WeS10Zfsw58vRwpLoTvRvt0XREHgficklD?=
 =?us-ascii?Q?X9r7EKnU0VkvJb76WjJ/fSNg2S5z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9UeKNLe3xygq+xza/N83WJpFpgeWzM2mcS75tS5ZcoOdwzounCcNGPkNzoV0?=
 =?us-ascii?Q?CJsejsuFNdKrNXfUUIq/JeU5WbktKhQv8UQm+t/XllzQgq8jxQcAZtmZimIu?=
 =?us-ascii?Q?GQeVznH8UKO+q01C1Ea/EXMxmwlFL346F5aJvkd1d4pu2eLegtSuaXirIbpo?=
 =?us-ascii?Q?J+rfdrpHGLskT0e5cHFydo5f+qZOjkM3m+xOupP7M/a4jGgXXEUizWqSFr9Y?=
 =?us-ascii?Q?Y65I+yYu7ahe6265iNSO7BrXSq1JhWfzuSW/gl50YtC4ZNYmDiRphPqfB/iS?=
 =?us-ascii?Q?EO3BH1oOyDvXyAxlgcJs3lU2pAmM0ug1QlN6Xcc1lZQkU5p5QCLkGLHadNY4?=
 =?us-ascii?Q?DHDu3WYLhqVYZhNod5QgC8xI5ardB8gZzSTygg038hCPN9Q9Y/zipLBO1B0q?=
 =?us-ascii?Q?Oh55tE/4qjSSk+hXiNV7bMrxSUkbpsHu5QBoy522tdD4H5twlnRmcyzCMOtw?=
 =?us-ascii?Q?u+OgrGkmTHyDTOyo8gqkRIt+/3bRUQVLKkoFduAVrxeBx2DPoLa6+P21UFm8?=
 =?us-ascii?Q?bbXBXFTHcChisa6zUcqct2jK4dxNBpKL+JPO1uswoJGP7Ys3Sdacwsxdg88G?=
 =?us-ascii?Q?cWvAmWcGXljazKkrkJKZ/atEjIgcw1O+ETQedj37VEQujp6QuBEPIpmJOo3g?=
 =?us-ascii?Q?csG6dqlghFWyyYB1gB/o5DwhC+J6PNjM+aPJQxMSK/91hcsvbSKMbL2CiBT2?=
 =?us-ascii?Q?lmeyZztBYCX/pDb5Q2k3JSg2t/Xcdl310k9N7HJAZNLKbIGk5JBp6ubdan3N?=
 =?us-ascii?Q?ToQTciajmnScvlvA91REktrhYTl3Zg80NE8wX15cJ7B3C3G+uPT+fSHYgJM5?=
 =?us-ascii?Q?WH6TBmbNyM2wro3lK0EAk1xMFFiG//HgMnANkH5btsOkbuCHrGiscuI3eem6?=
 =?us-ascii?Q?PMH7jb+HordopQQazWA85iMdcdCo562xZNAyYZzkmdooZSQK0YM0PqP0QRz4?=
 =?us-ascii?Q?pmMCrDwr3DRU0bthBcvdHeJ6q3ytIzO5F0HNkhAfmmwq9oGfhxLXC0C8Jm0N?=
 =?us-ascii?Q?fuSgd1TfdIgzTgG52Aqjbf/5rukWZ4a4MO9t8oZIYrDuFUpYQoMtdujUqHHb?=
 =?us-ascii?Q?nUjjSS7UdAgj6W6gAEC27HHqcNKmAj1BMFXrZuDU953pk4RPpD1ULIM6WaFo?=
 =?us-ascii?Q?1sTI0T1SeaMCfwBz2ZO9YiIUN0W6p0hpiW0nvQ8pjw9hpnlWZAzM8hSuNykt?=
 =?us-ascii?Q?tsKW2uFYs2PJ0cnp3a0TMo4e22bonAUKg3aI+0kCFi4GRTYFWCI5wuwLkEs6?=
 =?us-ascii?Q?Ofjnyg6yussqjzYUdZe6vP8OLqwp/Px1ETpt9oG/1SQFjcSKPEeelGtC5uSG?=
 =?us-ascii?Q?NRQe1NBQRcn01/kld1U4bMzVskGMJpzbs2X4Y85gGBbr/cEwsZduAOO0Krso?=
 =?us-ascii?Q?bW9fR1nL5k/DvEEG6tEJROnR9NoKxCZhMKN22WglrQGc/PTQ/CEr5sFUmpAC?=
 =?us-ascii?Q?KaB8AQcbhxtdiPVU60lTxtZi0dypi7DqtSEdfxkQgo1oqfDcQAKJMo6epYft?=
 =?us-ascii?Q?S+tPpcMzaWPg8rk1u7fVKZanf5LerQf+/oaoHLmp7vk32hPpTOMaSd2SY/P9?=
 =?us-ascii?Q?39Cla8LUvQTVO2fFzFjuUEXI+HzL33uKKXJBqYviH/ItRiwJHWaMTaSB82un?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ecf8ae-5255-4363-f0e2-08ddaf76bc2b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 21:17:45.7000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKb4KJhrA7VhlSRaeT/tg1dyG/Q3a+90dvhwzxelEsisG5WRtPkt2jMA61S4bRqb/bZNt1ME5Fc9GQ41JhoehnAm2+uJ02vUQhQFh/ZQN6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8405
X-OriginatorOrg: intel.com

Dan Williams wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> scoped_cond_guard(), automatic cleanup for conditional locks, has a couple
> pain points:
> 
> * It causes existing straight-line code to be re-indented into a new
>   bracketed scope. While this can be mitigated by a new helper function
>   to contain the scope, that is not always a comfortable conversion.
> 
> * The return code from the conditional lock is tossed in favor of a scheme
>   to pass a 'return err;' statement to the macro.
> 
> Other attempts to clean this up, to behave more like guard() [1], got hung
> up trying to both establish and evaluate the conditional lock in one
> statement.
> 
> ACQUIRE() solves this by reflecting the result of the condition in the
> automatic variable established by the lock CLASS(). The result is
> separately retrieved with the ACQUIRE_ERR() helper, effectively a PTR_ERR()
> operation.
> 
> Link: http://lore.kernel.org/all/Z1LBnX9TpZLR5Dkf@gmail.com [1]
> Link: http://patch.msgid.link/20250512105026.GP4439@noisy.programming.kicks-ass.net
> Link: http://patch.msgid.link/20250512185817.GA1808@noisy.programming.kicks-ass.net
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
> [djbw: wrap Peter's proposal with changelog and comments]
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

With Peter's sign-off, pushed to for-6.17/cleanup-acquire as a stable
commit that others can reference:

https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.17/cleanup-acquire
