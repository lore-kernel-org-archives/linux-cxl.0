Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A0415ECCC;
	Wed, 25 Mar 2026 01:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774402429; cv=fail; b=gD4L1v1PFdTb/YfHPeHuqbnRkgPoTJf826hWDxfliRSFuxbcWHkBxi4MC9yBA5Tj8WFgemSTefvsld/SzJubkTxFdPmDIgRliqfwa528al3T6vsHW9sW2QnR8DEdPn4+gFrpvU8hfYwhrfQ2yv9orBOa6mvwMFGbDeN6qLhxpvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774402429; c=relaxed/simple;
	bh=pW6wLxISo4D1EmthZnEG6jxetrsrTPAoLfaGZP2vRAg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C/u5mkfAsQCnXoMWI8W+NW3tYMSvSUPQB0LbbvwQjelqEUxOZaIiwhijaX2K5hRsYW9C7xYK8SXwKpNSC/wAN5UQJQlIG5idKx9NskOJFoUwaMAgNavpYiop7NUg8HMTVDirrAdxvywbQcWH3K0Ia5ccrK6JX2RKEFBhOQQ3Ih4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4JHotGF; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4JHotGF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774402428; x=1805938428;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pW6wLxISo4D1EmthZnEG6jxetrsrTPAoLfaGZP2vRAg=;
  b=U4JHotGFeHlk9AtJtGF3XX9fQhI8r364lJryS6Zgi/p9Hx4AOFOEg9CA
   tiBVHbXQ8LllWdtq11E9tXiWl7ah3yTXd8+uSg5UETD/ppCSZqEFrAM4W
   g3tkvqgNnXWYjaDGdqZbxm1LZChSQ8Yyp//3TjGJR/NrB+RHg3VVXtvbj
   Rm7Igh5WJCj3O+ivyZEGgYqjTAenmGXcpiwLYfQTQBeZP0NEkV1Dpaa2v
   zhF6U3FWAz4DJ3zmWxAwhdbrTr+rnHYyO8954y+DrksnAFuMh7jkRaXpi
   C7bT99H513sn3pPSnX+7qTtSUWS2nrJ7K3gnSP4GwnAqsdaZ5u0IriWHc
   Q==;
X-CSE-ConnectionGUID: tCt+QZSaToCmJvaRY6bDKw==
X-CSE-MsgGUID: 8kj3m+ipRcmaqXTl3QAnwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75149759"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="75149759"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 18:33:47 -0700
X-CSE-ConnectionGUID: pmByZHkyRmKcfa39EErGTw==
X-CSE-MsgGUID: 0qFk84oTQg66FITJO4apog==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 18:33:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 18:33:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 18:33:45 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 18:33:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8aCevkE45HDNg61fBWUyziMp/Qv2qwf7bBqzsXSdpslwHEmZueyB6IKgs0oHbDiQpUPa+fNJlYJm3eQGhrwZD1oYeMVKssW4raT13sPhv1VQaNGCcED8Ti25Cl6HVlNMXzQzG/r+/TNVvSxnZiX2GcOZp+s9hWwp+nt3OpJFWwA58e9eb1rNdFcUyGQKbNPXavAtsFWLMn+O9fntKi1SVWQev0g/n4jLj34oXIeJ1NZxF8rXdrgwttKiu1AljoE64QUHU7mQ6H1RD+wzUpIQZ86T8azP3u++vpr7hGTJw7OY274ySP+KybKV53Sxf+ctU0pJC+XdEDzc50gTS7DdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elzi+ntyqJr/7AqmUHxlJPU0rxjTDRLkTjO4pF+2vY4=;
 b=AEM/KCigFbdVBh/dVlR/Xw3p+gO3TVcqgoaoDTVXqGVLA2vzN+o1sCHJhSVeGejAlgixhfmjZ7iqOz1wIz3j61NRJxRW6AQaZfqN4ZrRPnMywzVVcxQfOlKeZjWFv0+hv3h428iFzCvgvZe7uRHNHMEhSVkz3VQa32LXzEtAkyVMr2iqNDnIu49OxJjJkbTe9r6F0cELXcVpWOBuLZ0DPgzbUeKbGm+7BAiAzM+YuSqvn9biBWAkGFO7vYScGRllHNyzda41kj5Nkrm1G9IKlqvKOJGuPWkLca9+W0miiqWjHs43CQ/dgpY29uhjAbEmRzN5s3xADHpFvFDC582MIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA7PR11MB9541.namprd11.prod.outlook.com (2603:10b6:806:4cf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 01:33:39 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026%7]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 01:33:38 +0000
Date: Tue, 24 Mar 2026 18:33:35 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>
Subject: Re: [PATCH v4 3/3] cxl/core: use cleanup.h for
 devm_cxl_add_dax_region
Message-ID: <acM7b8dTP58TS3oj@aschofie-mobl2.lan>
References: <20260322131638.3636725-1-gourry@gourry.net>
 <20260322131638.3636725-4-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260322131638.3636725-4-gourry@gourry.net>
X-ClientProxiedBy: SJ0PR13CA0128.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::13) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA7PR11MB9541:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e603c5-197c-456b-9cdf-08de8a0e8a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|7053199007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XYEGqhpLjpKN0QZXykX4MfF9hdGZnZ/3h5jM3B0JGHJuKRmc6o7Q+i1lCdcQxdh5kA8M81noiJGgXoP6A3mW05pUn+MBJ721ZPcBm4zSrxwTLDxHRiEoNtyEdt0UJiftk/v4PJYQ73ao/0DyWpsuzm+zht6k6EvwTV/cpGsWlzUuUZ8AVFA7DFTJZfz8gp7eYiZQH7/3Q892ev/yDNs9Nh+h7avYQ6WxIHjJie/vCSAEbX3ObOEGdbfIIOTV/4zjdZ40s8RuEb8lOvGwIVWg+dHvd/jZakqAqTn/8YwPjVGHARUVfme1Kblz4Fsc/cfACzULdoqHEVXT/7eTyuhV0Pyq+wfQn+dUp66XBXBSiS1xDgYjvFyaj5RpBZSF+UMNXvOKlByC2XziQieLnKlR4uO6fAZJu5w3Dy25Kct0xdJppyUoP0g/xIsPfV9zUnoiI0Kb0t+7/fwjZLnFHkpxqL8Gy/8cs7Ikt/BXpDYx556pzCGlfH6blt1MoMj4pN+SQLnd/aXmr84mxjuMDoVeyesJXqk8xzcGcp9svFdhks4v+dhTWYuAEwcKATUzaP/eC2IxwxhhtvO9vboRZ3TGxBkPAi/K1iExdu8If1fEQ5P6EFzLeGuBInfBaHyE6m9PvfSXmaOrAziQN+hPLUFGFWA33vakgmc/VyTquYoD/H1ox/0Abgzq2fxTiT8oJXMgeudtDKNeWikw2ZCG3/dMvYeesZG76aGd5tR5Lw3EO1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(7053199007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l2q4yaIPK9g1HzFS4Q2F4EWUDrfJ+JYzp0hND7sXU9xiHR7UbbZuwZGMVp78?=
 =?us-ascii?Q?ulwXSdOioLA5zbr29zdUVwC9V8RDjSPGiyfDR78tlaimgtCTz0+Y8WEP3566?=
 =?us-ascii?Q?2hfLgMQ4B1Msb1VGtys3z3jyN0w7H3z4GHR44hDUvI0PsMfcKPr96m4Llfjr?=
 =?us-ascii?Q?FrVfPUs/DwZElUeAj8E/TYq2qw8OGacAq2gx0Z5W5w4Vac2iKZwcrBivygcz?=
 =?us-ascii?Q?lzndqVm2CZ85b3QuzJZS6q7BDmhc0XykkQQ6XAFUEoaXodKaN/Fekll5k+Cd?=
 =?us-ascii?Q?R9O7HuwiPRGa6s0jFr9CZKFc2hog9heUlA5d+a/yA51Rvs7NAEYScJyo9Xhv?=
 =?us-ascii?Q?p/vyRV88VFKEROFCdTbhLSbWLAo7Tbxpy1jqHiLQZ68p0btkrQIBDDhtLeSr?=
 =?us-ascii?Q?owu4Ffqgz2GmaCNP5RxSRVslLrGhQiZdscRrpBlEaQWuVpQgRXvn8drMfiaH?=
 =?us-ascii?Q?O16DRTwgNHkgONbNq/CeTw5uto9UHpYAENYieK5Y06t9UWb3G0bssbDiyNDH?=
 =?us-ascii?Q?DMjscU1NGaFXBTVymgUsVQW9V9z4MWvWtuUq1BOm55PUmyiaOF+1FhKNGWlX?=
 =?us-ascii?Q?AiHssrZy2ServtJufZ6zuai+D8oeDjO2vntSWzT3ZwTNHwfsETnyeTn5WB3O?=
 =?us-ascii?Q?1PTuPa9xmNNlFngSmoZUf/8mRURjqCjL4J/wXS8DLkvEAgvGAqsoAwlowqSO?=
 =?us-ascii?Q?9V10wMYyYAlifH8Jy6TcO5tyWyI2sEVDguYDPXTFoKzDJns7vSQphnRQC1sW?=
 =?us-ascii?Q?ndTQei6DASkcSwnWGHU2gcSx7LFXAWPBIId2HNyzjg41+u0dfhcKoGRtOcdQ?=
 =?us-ascii?Q?XCsOkvjIipI5EzcJ6CA7IL6bVhvr5uLX63mnG6uLIwnDREYfM3bwUGFPD68B?=
 =?us-ascii?Q?v2tZaN5a43Nc0I88Gq8fu1WWFql6w1yIXiuA9Gzz4u3gQs2sCt/LRaOjClYa?=
 =?us-ascii?Q?lqJnXflCMCsxmsIm2m8O2gMka8gO6oe2t4uiHlfY7CxNFD6sqCxYHutCVgOm?=
 =?us-ascii?Q?KE0rjyIos6ellRK1PU9R1Eb2+04O+eS7Yjs1Ak/anpQc1Ovuj1sCyQOIo8ck?=
 =?us-ascii?Q?bk3nBRJePAFCxAGKEGa7SLdGeTAtpfYm0UZApFPW/fu4iSjaMq1oaBxOHB4v?=
 =?us-ascii?Q?P9rPDRYASoGCekofCsJPq1Hvh56xpStDeXPjgZSJd5pbO/iKv7qR2gTXMRyo?=
 =?us-ascii?Q?XoR6lmyBG7OYFkssHiTlCoDXFfJBcOk8ljDYNaUd5BCnW0wLdUBnZ5fUJ0up?=
 =?us-ascii?Q?dwN2kHdT8vUehlH+JjQsXYk9i3YNb2BDtWTKw8V+StyrsBv63tesv21GLTxM?=
 =?us-ascii?Q?YpnIDMB39LEcr32v0cv5msMvuI1TA90a3OB2ZVbJs5zazek0aF0oCuxXE6nF?=
 =?us-ascii?Q?YireULtFXphPlDDFCOegq7QHnUnLzKlrIVGJF4uSsSGwaUHxqxxFehCkTRF0?=
 =?us-ascii?Q?Dm7eBq2L9wzx5bF2/hkau4fZxAPq6WIAkfAuwh69ts/A2ad5HeRao3v5Yew+?=
 =?us-ascii?Q?vHsECv/joc5w/7KToYcLpyixbpaIuEc4tXztEc0FwsuzMmmMJ6cOcfgezxgo?=
 =?us-ascii?Q?WurxTH0NxVD67aK9zYoX9nYATtKbX3CXQAm9agucsFh5+vZTcA+GOFLLtQo0?=
 =?us-ascii?Q?rKFa463A3ARyfgXYQXguQ6SFtnpAj8YiAkdH5fm2kKrwhc0FoYdhZaD4IJXQ?=
 =?us-ascii?Q?Xw7YtHvS8/OGwPxkCgUupP9dXwJGrlBgJzK5nCTTyYw3TU5GIjcUH0aXQJxF?=
 =?us-ascii?Q?bazRfrBvthyBNePmQdXD120KXswF3EQ=3D?=
X-Exchange-RoutingPolicyChecked: aWBD3jZ7MB0jZTsdvClMt9I6AxsMAdK1SxQWqvrojT2dYtLmy+wwTa5XvUnSSH3fImBZQ7uWTkg9/xPzZY2crw/qaYCr6rCMXp2xty/FurSLGB7mf7K2RW91OsAQJqa7k4QFPJVJPQFc7A897psIMHHf+nTc0sJ4eo/uujD/seMAVkXay1zO7bc41omG2xIW8BlH32TnqqbxcWFJtu34ohnP/SZswuRfh0u4jFlviTYio8mF0tEWBlbg6rWL2VtLb4OmMDuaZ8Qrsn+o3Gx+mDuk6K+STkKpDYgNiZdX/l695w75RA/C/rB2HYrQ/sOKurZ+2dwaOpi2CHM1FlB9Zw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e603c5-197c-456b-9cdf-08de8a0e8a3b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 01:33:38.7595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YOeqmC/jwksuvsw8KiZAvO0aHe6yAd3SxwpiIV7+sIBSecbZRRxGAsmLMmdGCi72PRlMvsoZE3bjm4oSpoVDUlAOt6+UGJW47hngXtfzps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9541
X-OriginatorOrg: intel.com

On Sun, Mar 22, 2026 at 09:16:38AM -0400, Gregory Price wrote:
> Cleanup the gotos in the function.  No functional change.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
