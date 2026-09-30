Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430003FBB7D
	for <linux-cxl@vger.kernel.org>; Wed, 30 Sep 2026 23:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809828; cv=fail; b=abNJbr3iT9kKEtNupfmQafU/j22zkhVCsVt5LN5ICKt5KX6uOYzOApTY/6rmKvQaNsxR1+tVZPfKv5Dqm2In+Fcje8jIuDPyJiGjJp+Bno+IV/7H1T/NwvUeQdpnkjQ87NTEP4oBqqsfiPGi0wLJso5tRXa742Rz/ATc1a6zFII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809828; c=relaxed/simple;
	bh=UGzrIXKuVCrQoF0HOACe25vXs1a8u5l5kMWRt3rMCqc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IYWtov6nXTv0jzssI04j9u35B4Kd27DIKeOs1NKYw5GJ8etkGvME4/8HIcM91wzPo/4lGDC8B4qyKjuTzN213cMyu4ee9RtMRxrTO/FrPdLjClQGPh6ofJ987mzmU/OZOFaZP4PR3pGhZ2TfFfYyUhPZsu3ju7dcz+8YEATg7wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmCfcm1L; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmCfcm1L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790809826; x=1822345826;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UGzrIXKuVCrQoF0HOACe25vXs1a8u5l5kMWRt3rMCqc=;
  b=dmCfcm1Lz5NGBDvaV2U4t/MibJUdZ6jGLj/Hj9BJ1oMo9q7SwLW4ZBvD
   KiMkW0Bi7uyRmAok7aTaBzZ4bTB/PSWk7CV6wlW53Xh/tGrksSMlKLLMO
   nagpl89ljbKPHgMRJB/TCCfSK09Si9MZxa3bFRwrfrJ0Rly3xCJl88nB7
   APC7NFbqXDRs2+ofUPTer6hLgvp7kr5WrQZoYRYPlAQvzWfeBbH2xK5pq
   FmsmyzGlRA9IJ8cALruiCzgbP5SLnAplw6FLYlxszUriPQ18VsL4k40dP
   R0nweVAXXgyKyL5up6TwxrkAuNRVrIaG9hRgo/XOyLvIiTA8jlgbjaCNx
   Q==;
X-CSE-ConnectionGUID: HsSpq1XOQfO4ZqD+zqjgDg==
X-CSE-MsgGUID: bnT8BWnlQ2SPuepIubqUwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90595538"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="90595538"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 16:10:22 -0700
X-CSE-ConnectionGUID: FvpX3L6iS2ayusSgHYviAg==
X-CSE-MsgGUID: 6iwuJJmzSTSAzNnumGsElw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="303754816"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 16:10:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 16:10:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 16:10:20 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.14) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 16:10:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFH2tWmHzV26NHFXFjZy9bowNS3qpNUGg9cXm7yB8qT5pdv0UPzo9Z3Gkch5TwK4WVTsYdVy9euRCeWLhoqqUbesK3OIOu1B3/J4jDA/XEzYHQiDQgojgeS4TusftVkFpXB5gBkZk/ybaNfXzAfy247TyvIJvwh5aDswkevr/yDM47Xxecbcrft6gfv6b/WtmQRmdHIAf5WtVOi4WoLpzLs75/jcvwJTxRoWE7O92BAK6i3lM34D2shlziPJEJrAS4t+rhGGsm8Xi26Ux4n5DOUJdnvZI8QZHcwwZ0PU3yhCUmPbbiWbaK+U+l0ZWG2QF1BEPmefgnUuTj+JbIhhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGzrIXKuVCrQoF0HOACe25vXs1a8u5l5kMWRt3rMCqc=;
 b=iixN6lnXyZcIN7W7KQrDLcCDmXTTx+A7JBUXSOIkCq/PO15H0+HxxP+WR7SnT25qYU9LANxAcAWReZq8tYM8pEQF8F30kmdXPBv2sMvQgQ+Zzy0fYrgTWDr4zNgLSIsds6rDsSVM+8SneNlW5P1/2APsrkLfEmtNl4mnmZVc06ZeUW83CyUWdEcSL5LZ/JQ4fa2vlfQMFtPxsYkijwZtTVpgAOZuv0iNRW0e5VirQwbMF/VfFGbtzzw5mp5hEEP7aeTxxYJZKFJIiiWDHvOeYrisIQEKWVumx9QDdFghQ2O/HOI5zz/vU1wNV72fC5js/dxDYMDgb8X/vjdRU0qwbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ5PPF4990C6B9D.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::826) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 30 Sep
 2026 23:10:18 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 23:10:18 +0000
Date: Wed, 30 Sep 2026 16:10:14 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jic23@kernel.org>, <icheng@nvidia.com>,
	<ming.li@zohomail.com>, <benjamin.cheatham@amd.com>, <alucerop@amd.com>,
	<linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v9 06/10] cxl/region: Log the coherency model at region
 creation
Message-ID: <ar2W1ktsg2qnem4m@aschofie-mobl2.lan>
References: <cover.1790103847.git.dave@stgolabs.net>
 <6b9283af30fd1347f346f9c7a011d6b1663f2e2e.1790103847.git.dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6b9283af30fd1347f346f9c7a011d6b1663f2e2e.1790103847.git.dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR05CA0207.namprd05.prod.outlook.com
 (2603:10b6:a03:330::32) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ5PPF4990C6B9D:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f809557-65d4-4c9e-35fd-08df1f47fe51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: NM6qhD52kQZIPFVx0dA7EABTxKL4jXuuy5GwNtV2ertn3qRFZcWmF99yH3e3tBPTHMigU6fTDJqJD0JF6dD0xtZ+QT44zz8Xi341qWiPg2dJAodbHbre0wePwvi4mneqIHLG2jktUldRHNV4bG1cePxOen/BgZHXUD9jkAzsxedkWAv8sP1hBbStX5x2WGggiizYkGG/snIlH5C8XunY0mStGxvimyFj1nkZ8oZI8mNUuqVVZs2sxh+Fq3GkEJH/lpFIdR/Uw4LA5KZMTQRzY3ijYrwgtrGMLQpA5F0i15rzn50nOTvM9g1E0y+ZOcGnbFW2p3E9p4CfV7oKhQdchR02JTT9w+y2iL4yhIu9kBXj/AXPaxeAcVtOP/ethy/WcvcQq/BRomSNLYJvO+l6V5gSbdXgsjQdwUCyqw0A3RRxXSK6fOA9L0BOXj3uvoIjccxR07FPskK5i6E6qGoaWH7KkSHi4A9HhTGBeG2utOL70O4pdk1NIv8mHdGqo4aTffBN1zkMqsFiICuY0hX/jKKYe1px/icRWg2K18x92ZOiWlePqIoFBx7jWv8u+J19/Xg2/hUHeJpzPfmXebnF51Wx2xpi9wcl7SWncxOII/cBvm9Y0GkTtO3ECjDahtlevORqf6KOJmbNt5aYK7IuoNwIvJOFKbMcZxz+wkua1fI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tbz1z1elPiVDMR5PIVED3nzmLOy7AkErYBoaKtxG3GV924OXvr88CqOqZz5q?=
 =?us-ascii?Q?Bv085ehDAKRl88AwK3gaZdsPJ/4i7i7fx+SjU4uOf23DvJ5hsaljOUwpRA8c?=
 =?us-ascii?Q?WLOA/JMK8zrbGX1N33SEaXBwtmBLfMUwQU9Ijeyi3Y5bgx9b+bNA2Qmima9k?=
 =?us-ascii?Q?AVTumqQAQ/x7Iv6E/IRd15uVrq2gMK7j6qMzi7F7sUinYwYIQ+3JJ5Nv8y4W?=
 =?us-ascii?Q?SWjLzFO69jkK/U9oopu1KaY2d9x73vumsarDE1Q10fibnLqrlobiMHv10yLe?=
 =?us-ascii?Q?zRRjn8R3mRue39WgtURUc5OczuHbuNjhMVoUqT5FeUiJhTwDrVslVKcyKrCL?=
 =?us-ascii?Q?JSYysd88fTFa/ixidBAYOEopifdlRP1kgMB6I3TcAr6noyQ2xqw7fekPOO1Y?=
 =?us-ascii?Q?sUnhMUubDeIfMMJseEm9+WUGdJEMLRtzEjtRaMU7ebE1H5ZcMynhpARN8lw4?=
 =?us-ascii?Q?TFhwrMeTJQp/WklhTtGsP0Q/tsDUosPaIC6h1/xu7AJrnFDXqxJHZi5IA4pA?=
 =?us-ascii?Q?U7Vb+iJ9LoUXdV9DEz+X/vd7dnlJR/BcGVl8rS58RWLZj/Ay5X55PAjTcqzM?=
 =?us-ascii?Q?Z96qR6wEmqdz4gVsbdmkryhLxCvR4f3okcWH/lPSpOQoCdq6FSDyoz5aRxy5?=
 =?us-ascii?Q?5PJOm3Yep4JcIf4VXlPpxQbjgDfic44kWL7WsdsyW8sZY63CNH2BBOmdvr8P?=
 =?us-ascii?Q?ygBTyM+pgGw++eyDBn8dkIEDzhFOwnwxaLGlOSQXHDk+56gJKHFTPBqlotjx?=
 =?us-ascii?Q?pSrVgFmaGFhqUAcaTwhM8UP1NZJffNmz+F1hb84uTsbRkzFDKBEvr0QcEHU1?=
 =?us-ascii?Q?cUhakhdt8NFL0vhg1v++xvpUMDtfETjLOQpUHk4PkfuG3xtFTb6N8K6lVoRK?=
 =?us-ascii?Q?bIXnR2E6DwZQ2lVUd3NEcAbsoF93egZa8bpaaE0wTYSijkqKVicFtERkDrmQ?=
 =?us-ascii?Q?cbAV2vl7XUGyD8/7boVg6tE5ZoxrOWQptRvL7ne5jjpRcvqew2uOUpd49wjS?=
 =?us-ascii?Q?M8YSl2Hdo8F3seochEurRzYucDHnBrv+kA/8iV1+MDuLeW7D3gq0bgtSL/MI?=
 =?us-ascii?Q?oCkYH8N1Q+F0Hti8OBt4EBRHr1ih8NHqzAxDhZnRmmdHrwtn3Ox+EePOO0eU?=
 =?us-ascii?Q?h4SCKFldGNYstbzUUzlrY1F8f4PQ3nVbGhd8HE34dCxOebllGhNsJ8GOst9t?=
 =?us-ascii?Q?6Jdfq9yNNy/xQt9L5ctOiiEIQMemg3E8OYd42Opf02kw6x5AwCp3DIDHY4vR?=
 =?us-ascii?Q?E/8BDPAIeicIOAGXfD9pYVAjTMb/n7K/uwSk+9rIUhqelbTVasSuBo+Rlorh?=
 =?us-ascii?Q?m68dBpsH+xuC79005muXXwd9dre12BewU/EobMHZ0Mp0mMCiFpkMPZ3rKgxK?=
 =?us-ascii?Q?Q0P3kMEy9S1WVKl2CrcydlXbf0NDi4ZntA9FfMgCaEvhBR1oz0TCH5fbtvxH?=
 =?us-ascii?Q?1wad5flEf8+EVc1q4M/qmlBx+VIR6ot7huTO79Sw+vzBh5o7e5g2riC2tx6u?=
 =?us-ascii?Q?vz9QdswBhQ0iS7uHXBactLLTkTAGYibuKT9z3p25vAkQJBE9gYxoATejd0hP?=
 =?us-ascii?Q?urUPeo1orqyYpHMJgvoqOnyPVxCTSWvWR5R5HNW7IyCHMEDYpnrTSiO6MiJp?=
 =?us-ascii?Q?6LKSXVLiT3ERKO43X8PZnxTcadp/V53t4qQwlkcEf18oOYDl97hyYcuFG0Ic?=
 =?us-ascii?Q?11+C48CQW94cPaEzxxUTrEreP/7v+GQ/bAo+on0XWMs8Npnv0sQE/sAdBljm?=
 =?us-ascii?Q?4xJp52Q4iI1ziu8k9sExPCp9PRgHHxY=3D?=
X-Exchange-RoutingPolicyChecked: pFwsGu8DE2LpwTFFl1H0qrG4Qa0r/mXUHUoDkHT7ke6sogWzbnw78qaZGVL4A/psyiYCBJ2e1/++bUB96ME9q6TouHciYh3D7yRQWkPSKSbZaOX4xB1Hu3AA5JOOMkQcUWCpMMCmn/AC5WrjZlb/Wx2qi6Wq03F2uhN89ArfQTWTpPIjkXQFnyYFHPgL4X7JSkEmVZTLeVA5rBUsIoD5sLOE3YnHsx9lydXKBVaVi6+kYll0scTfFusFb6bQj4ZAo+LdK0GDgennWMpvs4J36pTUVrSAmBh2dEWYGpxCwUhFcCWjd7xoDuOCP4p6B4CtIYymeDdh5bGl58gQyMUsDA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f809557-65d4-4c9e-35fd-08df1f47fe51
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 23:10:18.1464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPCfV2TSES1Pakwa8PuSTnQHRJi9PGntvZJagmjvIt30Zmn4eAVQb2vWqK5M5v4AH8azFrUyHhEXsB3VhAzhscm0/lxlZet43bwL4rfujOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4990C6B9D
X-OriginatorOrg: intel.com

On Tue, Sep 22, 2026 at 04:38:43PM -0700, Davidlohr Bueso wrote:
> Region assembly emits plenty of debug information - resources,
> interleave geometry, target placement - but not the coherency model
> the region operates in.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

