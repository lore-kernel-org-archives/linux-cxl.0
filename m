Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57991DB154;
	Wed, 20 Aug 2025 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755724133; cv=fail; b=DS7vuvMyu8Pqan4DjWlUwOsZJ34yaFm20IOfAw638+xAVmbCsTHoxq/gbF65spF6ltYUUf2yVDIAWZf0ArE+16u3zlrt9AlsS2A2AxwgT8th0scuwz+riLvSVuHcSem9A7MwWcdABtz3DNRe51Jr0W1GcNg/JYCSHHJ8y7lOpBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755724133; c=relaxed/simple;
	bh=gm0bGOQffwVqfBtieD+Kv66rdB5GlJdvrbOVYX4FZyo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ubi/bxfDlCGDhecoOcAC2RLgBKC6JTmHKyGRBpKn837+0WqcoBK62oQkNHK9//XmWRoHIjHJjCKWyk+FwPLcdxZzHSIxXz82hERP2U5lMQofkLtxfLTaruSZaGOA0lXUyjlT+BRzQrZ2cGfaQH8L5PDZAECI8hg0DNgTC2XUKGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zw1QOi/k; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zw1QOi/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755724132; x=1787260132;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gm0bGOQffwVqfBtieD+Kv66rdB5GlJdvrbOVYX4FZyo=;
  b=Zw1QOi/k4kAGL8KYd4XvWvpDgaFOhRBgmjzW/ZhKdGmhg2pI/bUI5YWy
   wA1P+wuvmcf6korfXWqE8gV/6P+fWgOKAmfccayTr9cCJhMIK3smBxqVE
   c5c1dkutMFmpUNlDBK8YGlpHFY4p7JHCzZHQetJbL1IPwGUId0Qbc8Tpa
   5p/plX5ByNJYnX9Rn9u9wcIjpKHmNblSbJg/mn+wo9STzenntXFefVuLl
   SnzA24y4+srflgqPU6D5b4dTmUBR1Xb7QP0Z99BRyDQYQhZbkz6RQ5L7k
   UzQ6TiLhuajV0sDXzAdVvVmKjagAu6mfiUnV5rjOyHAsV4JJDkiz0cMlj
   A==;
X-CSE-ConnectionGUID: NVOMr59PTMOTIgHZJzjGBQ==
X-CSE-MsgGUID: m5X31us0QVytZouNMIAkhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57718194"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="57718194"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 14:08:51 -0700
X-CSE-ConnectionGUID: W6KmjD5CSUCmJV8BVcPfqw==
X-CSE-MsgGUID: 4pRLZbWMT8+H5y2ZOMQeng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="199211785"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 14:08:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 14:08:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 14:08:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.79) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 14:08:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1X0t8W3S7kkHd2n873WjcpuuYM1Tg5Pzm1eT3hhkdZKnBHeSkRIJw/wr4lvoyQIDQtgU5tH3fppjsI+XHyk+qXhJn+bHY7tgxumqQb59dWcRYi9q0TQm4v2Z4saVReoylU16Y6plJfsrLIKjr2yuhbzZ9qLUTGp8SH3Rz11Z5ekZzJMfmALXoF/L+4vvCBsBFH1UCXtLS4J/Ucm4AxTCRQe1qW8lWCkkui9AXGL0+MQ2hm4LJoH5LV9g/KCMnM8AHaaBhfBTMzmqu98xEaN7ilHSQ8HCQPDdv7ft8Za1EjFNc6DE6JQCN6PiW9pdDpQYI1Oc+/PZFeeL1O8+Xv3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFE3djL/b3NbcBGeYFReVkhHTfLMTZKG+mW+7rmMWcc=;
 b=XLQT0Uq12cVrKymWZR7/fcTxTByUoWXduMHPB40eWWWlEHnw502fceNTEEDbQfyAFp2IT+W6cRMxb2M8QE85twJWcVQFuicXS8UBgDxdCROjJCkR2GwjtzybS1ELXAe4VSafhPOSxo7SnZmO+KGCpWB+3VLSOeMXsZJ7xkkjUYsSilHJtAn+aXDKmu4tvcNxfd4gTcWtzlTrVHz+A5IMPgU6qXOofIWfevJKrar2xOH3TwXaKgbbdjXSM9HWMuLQnJKBHZTf9xjF+tluBKH/gmbkSV6Dk2jh63CY7qQ6HODDGK+JxKeXH/wuMp467osBLMIAN8TgTCOz+aejvzjLKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by BL1PR11MB6025.namprd11.prod.outlook.com (2603:10b6:208:390::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 21:08:47 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 21:08:47 +0000
Date: Wed, 20 Aug 2025 14:08:39 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, "Dan Williams" <dan.j.williams@intel.com>, Robert
 Richter <rrichter@amd.com>, <ming.li@zohomail.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4 v4] cxl/test: Simulate an x86 Low Memory Hole for
 tests
Message-ID: <aKY5Vx-HXnFgyRFF@aschofie-mobl2.lan>
References: <20250724142144.776992-1-fabio.m.de.francesco@linux.intel.com>
 <20250724142144.776992-5-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250724142144.776992-5-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: BYAPR02CA0031.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::44) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|BL1PR11MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2ccd0a-e1ac-4900-7b13-08dde02dc118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eNI+5eX3u9EALlTZwfvTnXV2kuFPb9O0/Fucuo3nEvWGdhjrR0oT7B+gDktQ?=
 =?us-ascii?Q?GheGtOKoBkf28QzZZ6T0saFNFTMrku1Rikbwvvluq7Brtd42OL4ClsN1/6Tw?=
 =?us-ascii?Q?93xA5N4eNqhWt2cmZVujDwuQhH5PzRqTGh6uxTtiYvMTZnKOJgKOdzCG5xVA?=
 =?us-ascii?Q?PeJN6DmD9XOIdAsLC768S+/UdjhSBEfaRHF6h6B/WFG27Xn2ZV0z1UES6dMC?=
 =?us-ascii?Q?qpieTjTA6U6SreqYx4rHr97b/BqACyzzJa1b9zY0Nyseyuh2DUTCzvTG03AR?=
 =?us-ascii?Q?rTPTvgxeVVrrWAH4X/oSW73O0tpJxu7FaDetfofUXBbpGfk9+cHFpuqdR9oS?=
 =?us-ascii?Q?X6kXH/LhfcIhhZlz21aqjk8TgoUyo3rAVqYWffiGtsiNpGlxXw31wbQloIcf?=
 =?us-ascii?Q?83Ev09AjWgspzDdX4Dr2LMEWl/YbEAVyU5GX1UyswpqG2C/RdpB3S9m5qX1d?=
 =?us-ascii?Q?3JBHW4GnmE+0WaOaaZvjaRu2JOSPwtMSQ0lw9rCjtu+p2l7D/QnkkHAoGW46?=
 =?us-ascii?Q?u8gl6u05IwhdGr1s/0gwbiWWG7BKy3f3Y0s492BBcCMoLytkKgZnCojPXiVB?=
 =?us-ascii?Q?YOp99uKxgcfs2OCvHxRZJRizAyzqEkNpE3toxHT/ubslPfXjZm79IYnTfoFT?=
 =?us-ascii?Q?yPuZ6NyKX4Pjhpfng4N9XAvoqSM+DFVd7vn79qWvGFN7LF9fZuO4XYj/A3gz?=
 =?us-ascii?Q?CU7A2tgqFn0clEjR5/j3NioMTra3tJLE/LjB0pb7C0igS2XQe+jMIcDoJDiX?=
 =?us-ascii?Q?WaIy/8T0/5s2PKzT9SxJVDRxVDSOwSr4EmCnsZPJlchxvZrR8PgxqmYK2OeY?=
 =?us-ascii?Q?hz7M8ws03ibY1+Tc7tWx9Gr2TfvxhwheAaeEyXDTEJhmdqbJ4UEBX72FiKhd?=
 =?us-ascii?Q?vlZe8Rf2YHDgW2znDu5Dm24cihRy9m1mm87zdZChXndkpzEdpcxHKh4chu9p?=
 =?us-ascii?Q?gGUpD/7sCnFwKjeE5dB8POGM7hfz02pymprpkvOKFc92+JKliH5kkSvF7Uur?=
 =?us-ascii?Q?xIVQi+FCVrEtu2xSU4F+eUjYx1EeDe4hw+VzaS6hCyUNoP0LZ8TOv0FUoI4X?=
 =?us-ascii?Q?QKydzzQHWOF18gmarM+umlZVICp7a3fnMw0ompgoVJa+HeJqPfPa9zlD5YMq?=
 =?us-ascii?Q?YZ2kSvFe51+LTvB2oYZ0rcj1MNRcwcfgZDB21DuFuD1ileec4RzyEjgf97iG?=
 =?us-ascii?Q?CJcjFpmFUyiiVHv1TBqIq4hqq+Q6ILyYSdNfUfEZIsHB9pYOxuZc+GCEMaVm?=
 =?us-ascii?Q?83v+MNK1mzmJaNY4URSakYH+Hg+OmQwNFdHJmKmLHeL5ZOyf+ZvqfyrL3qIA?=
 =?us-ascii?Q?COHJZCBIYNHhRc+YZ27xmkVeVIYwek5227Ni3LlrP79+qLHGLUY1xdqI6S/N?=
 =?us-ascii?Q?EGbtVGJuDNWUb+t+vJosgudBijCiHCl1YcOLF9b8EorsbHNhAlaVpRF4gyDS?=
 =?us-ascii?Q?C+KBT+xP6b8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ttmb5v6apgwmD6nTI49vLkwvIlM9ymPe+dxY6nEnoimCycOpJ3cyzfp+fC+p?=
 =?us-ascii?Q?31cQvtnCCOlyJ2xdCSYgs8VUTtsWvU05MCNM7LpvPfqaoQSbSMiJl0aWiItJ?=
 =?us-ascii?Q?M3wFnfGZA0Vv2PaMIYwiteEcFkhRuM0zThS96G0Y02s7eP2ojwSI7RI6Z4eC?=
 =?us-ascii?Q?UpJU/7ixgQj43lPBpbNSKrdoLGXQy5wAUxWQAqxdmf9a12Kk5+bhh84j9Eie?=
 =?us-ascii?Q?o3hbFqfxKEAg4znFlSPI6hDWN0wzuNWbGOV2fnfvlveQZQKTSlmH4e4vIad1?=
 =?us-ascii?Q?ufbvVlLCzHSGzTqkCrsB3JqHBJtDDmyzR8WiJHL3KUYha7/aQC8JGXmtBaPt?=
 =?us-ascii?Q?SteojjxpzUcTPZ2tn++3SYCNX1WNnJ6+HfqAAHeFpeT6/84YzIG0F/O5sdw2?=
 =?us-ascii?Q?MGSFSQLTGvu2pXqGJNagPOzY32RI8ux6E9HU30oDlsF9ctEAdOGXzlGkdePm?=
 =?us-ascii?Q?ILLhA/Iy1ES/qEK0EshwnaY0Z/eayF0ZbfT6DeXeAV+HddH1efo6rlm8saA3?=
 =?us-ascii?Q?eIAW5+qML0cPXGymSbFFkQW4Xw0xa07HPlUumm1C35WxdzzW+3DBybWgtipq?=
 =?us-ascii?Q?1eYDr294Hj9KBbdaMVy9cL7Ad8T43pCUYHgtdCynDJJr5FCcFDYhEGmzDOfo?=
 =?us-ascii?Q?0AnK3RK799f7fzMYqdr36i+/kR57c6JdnVZA02a/dX7bCM1/NLSUuPLR8pyb?=
 =?us-ascii?Q?D1iPDfUbpX1wlf/jtHIePcNoYDEOnuf14XVndqsZl2z0R7c88ukqEYJNMLRl?=
 =?us-ascii?Q?xbY7ZMGgvDgNkNtvp2NTAekAoqfNd5pznh7NO41sGLXzNav9w8ZNTQL9BJtp?=
 =?us-ascii?Q?1TZ597nDbnFmMUehAqMxH/ROoJOvJ3xvq65sNExRftbZNodJ/0KEUiPzxO4n?=
 =?us-ascii?Q?t5HYrgkr3WSspHVelnA7imoqLnKbssjp6LNAITkfdAe8itLlcJ70/w+zL0Hk?=
 =?us-ascii?Q?Qwh3i8r9tQogQKBkl3HQa2gjis8aErr6QB1vBllSpVk9KklJdR2KZXoqNnUu?=
 =?us-ascii?Q?LpBnrzvSAptdamJXFpsTAmgForYrF+DVoyv3IDtI+u/fHyfwWZOGD6JNnLC0?=
 =?us-ascii?Q?GRx0uBB/1Akwn+OAuw1b6eJymmyJ40+0jUjKUkoNwPrUUJoHTP5cSxogIoAm?=
 =?us-ascii?Q?gaqCOsIuLw6Jqkf+49e8Zmwog5Z/Lync2ZGbJl2v82JrLuYRlE4SBicbvPeI?=
 =?us-ascii?Q?qZVlQgUbjMawy4koNBuz8QY9VHQ8iGiiVjykWtRE6ofvPk6RD5BinuB/bmeE?=
 =?us-ascii?Q?KwAXl6dHn/ZVXfgkcDL1Rg8E+liu+2//MgwE16uh6x60WEQSylbIXy+2sqwt?=
 =?us-ascii?Q?3dT8Rwq22ChX4h0yvBoCRdKzAVbqRXb70lMp8bqKVeyrWEBExFgPb7jvDg2D?=
 =?us-ascii?Q?YQNS60USuK0GgDzv33OZEoFRketJlX74VQ5R956F31f9h9YUd6t7ycO2KgzG?=
 =?us-ascii?Q?YV4OnBg8x4czcOi1jqrbpMADzXPrPK7SNR/vhZ2odYNb+m8E1OWG46k4r4d1?=
 =?us-ascii?Q?GAHs45UvSZ4Kib0OZHmULz7ai0RbX5H6v9scTxezuA4FFfUqknXceV6eHDDA?=
 =?us-ascii?Q?4QM98SIP50ikdwgpen903jyWf1haYiwa0Cd5Ucx4vOLmP8BCph9ZPQFTcUhi?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2ccd0a-e1ac-4900-7b13-08dde02dc118
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 21:08:47.6777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcZJdpRMyZeqhtZE7YLWQkmxwP7i4op9M7/bp16tdqBukFH4evTEKjY0rIyMkUvbX8VCVcVjtMyFUmW3fE3TCFd/3lZefI12IerUWn480Xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6025
X-OriginatorOrg: intel.com

On Thu, Jul 24, 2025 at 04:20:34PM +0200, Fabio M. De Francesco wrote:
> Simulate an x86 Low Memory Hole for the CXL tests by changing the first
> mock CFMWS range size to 768MB and the CXL Endpoint Decoder HPA range sizes
> to 1GB.
> 
> The auto-created region of cxl-test uses mock_cfmws[0], therefore the LMH
> path in the CXL Driver will be exercised every time the cxl-test module is
> loaded. Executing unit test: cxl-topology.sh, confirms the region created
> successfully with a LMH.
> 
> Since mock_cfmws[0] range base address is typically different from the one
> published by the BIOS on real hardware, the driver would fail to create and
> attach CXL Regions when it's run on the mock environment created by
> cxl-tests.

Can you add a unit test that in addition to confirming that the auto region
appears, (like cxl-topology.sh does) also verifies region and decoder
settings and address translations.

That is work I did in a prior review and I was remiss in not asking for
a unit test back then. I suspect it entails turning what you examine
during your testing into a unit test script. cxl-poison.sh shows how to send
clear-poison commands to validate address translations.

Related topic - if/when you get on real hardware with an LMH it would be
useful to collect address translation samples to add to the cxl-translate.sh
collection. (cxl-translate.sh is in review, not yet merged, see on the
mailing list)

snip
