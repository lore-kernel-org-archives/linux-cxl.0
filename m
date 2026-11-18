Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794966426;
	b=si5/tOxZyPhIigLLU50L/tqX37wFtBSpi4Vz91j44/mmgXMVbKTDCSYuIIqu5eTt8UHL
	 JPVw8w/4iUOib7jDZnQUI94Z2DiHIugB9E9i7jIfdAuAW5SdnwTV7B1uU1RQ+bxZIMqFe
	 qaajRTiP8IeqbLpObXNAIoYTUlCk6KOO9bKMkBAjijpEBARPHQgJPq8LSax8zuaMZ+ne9
	 flOyihndXGC5onzAm0c9PBGBfhIvvA648BiUQhb52W3YGG2DnEV1GkU5gNZhRmQjRVk0J
	 3f+rfPSFNgyraPrXEbQIER6jr4WJeiiMpYjx39zd2aNTlGXdVZ4h3+TJJFRovvnK6kw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966426;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=RZikMf5IJE1FwgIk+spcajMg7hcRO13VTBwy/HGPmvY=;
	b=062qhMCDaU1M/FKWup1OXQB1DyqnhsszrHSmnUaMejCcMuo9pfu6ONoLyPmoFSoPx+Nj
	 RudyCRcdlSwWa4EjG268t9dVNHoO6LKi2rOzxSRmAY9USTi0tBFM5ZmSrSn2SK4TA9gmD
	 duU6z+P1ke5/cOui6M7JvGIVPxDrS9eC8oJohimZoCelXfe8hSAUunZtkhG1jUU8WfZ+J
	 a6RPt5ef8BWsrfWWB8baaSryJL17He3Y317QuHRSCYFYpCmIWjFSjctl2OUijy7t7J/Po
	 oYMGyXUlrm0tpXEfmts0RZuU6TLzOLhQBZ6RN5cTagd6Aq4t2/08Iu9trBbbBdDS7lw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Zn1y8kJh;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=LOoIXTdN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CD8606A31C;
	Wed, 18 Nov 2026 01:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8CD8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Zn1y8kJh;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=LOoIXTdN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794966425; x=1826502425;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zmZ3XeZZ0E0HbFch5X8nJv3d8r4E8wrcNAGKSuaxA8A=;
  b=Zn1y8kJhhk28BgZodASKSbkLCwbvMRE3cBl1sknGP9YnQmUuRlYGul99
   nEjA/5KR4Puz+7IhrCebQN5uCXzQynUUahIkDm9Qo7LCgzKwxbXL652cO
   AnOyEwNm9sYN0Fdvat9+7zCQUI+1ZDBeXZrZvRq3I/OuONX4yR0BgjnnB
   I7M7YeN95j14Bn9JaYEf+yuVsmUAru3fZb6gTY+2CS2Qov37dprmHaqlB
   IIPOP9uVLj+p6RxmXQSYNnV1/uoSjrX5CejsNXn14iCX5cUFAnDx1rqiE
   pmG3jjDDxLghKW5r5SAU0ggjp3pNMcVNHxqUOBsQiTqRk1v37iOF79p2M
   A==;
X-CSE-ConnectionGUID: kAlLqdI+TZ6x3eevATDsgg==
X-CSE-MsgGUID: rp2+Dz3gTgCbkbAthGgTxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3805714"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3805714"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 17:47:05 -0800
X-CSE-ConnectionGUID: nEZNLyI8TH+nCUQVlyJTZA==
X-CSE-MsgGUID: N9ca/+z6QK2zp//IZZNU8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9862175"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 17:47:04 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 17:47:03 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 17:47:03 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.16) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 17:47:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wz+meSMOpP1e52GcEqCHWKaksturD1RLnT2TcvQS8E7Dk1aoc1rsk4kuVDBI94kFrWeYf/kbCVpfQtXDbepSbcEcUsQ5BIwcoCFsMM8fQGCpiUhTuajJ4UigBDB0K22i0TarUEnBl2n0f+S0ek0EXxXZO1FzWm//0IzUZnhsI/WPtqlPlFCkOknBTz9dkf/rDDcK8TLp8dLtrhnSclxES+ggpXhlaKqdqzvc4LUsHTN0wCAh7IxoMJkdo/IEnEtCr5+iCwgVk956RRZVzKvLpA9e2OskKPOQhd8ESYQQF7aHDdTRpiRQ65P3nIc74XCoYZQIR5S0+bGovgNXaFnrog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZikMf5IJE1FwgIk+spcajMg7hcRO13VTBwy/HGPmvY=;
 b=RISOw7uxoeXM+1vd5ye86WOTtQunT4k8C0pFTzpi4mMGmVGCdYjqA4yT47HPbWrSYJ0mko42ZYqv1zocE3q2YvAi2a2di/qsyFMoZjAAw9xRL4DO6vSdIPm03Hs36JfAoGiyH3bgxrErQ8/ZPDBzxJ6kY02x4kdMautUkpChwAMA1HlkdWScMuzFqHoBe/PGLwfhdY6zbtKWafr+iBdfo91aiHFlsALX3PqhTLmlYHloR3rWCdIS95hmRgqxBqs++enuG86fGT5f9/XSEmNsX5DBfXfa5m4+OWy/oWrp2MxxhM9t0HDvEkvQRfUZsmUBchhVc+wQwA2L2rtUo0okAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZikMf5IJE1FwgIk+spcajMg7hcRO13VTBwy/HGPmvY=;
 b=LOoIXTdNSxFx6b2INVF6mfzQznk3bPmrh1LLc4/iOoPn88M1iPmuA+EOE2IOa+PRpZWLTC+5jo1USGECxQ53Hua4au4W/e+CbuYcs07hl0kQ8ksLqye1rQjXxe6fJNK6PWpbHrySKh2ikO76aDqUsLyTAQzbIAzeH6AWfrFwBbU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB9773.namprd11.prod.outlook.com (2603:10b6:510:398::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 01:46:55 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 01:46:55 +0000
Date: Tue, 17 Nov 2026 17:46:50 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Jongwon Lee <ai@linux.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] cxl/edac: Read cached DRAM event records under
 the xarray lock
Message-ID: <av0Dii8Ikx_7FEMX@aschofie-mobl2.lan>
References: <20261108022022.3352-1-ai@linux.com>
 <20261108022022.3352-2-ai@linux.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108022022.3352-2-ai@linux.com>
X-ClientProxiedBy: MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::11) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: 2246dec5-bca3-414a-a138-08df4515d2ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|261009223027099003|11063799006|4143699003|56012099006|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: qTp3VbwDO/MHRz+qYRpkh+CwKpiMfRE89lJaJMQ6XZ6lTIfN9G2+zP8TCg1NA4cp54SPS8qoK40Y+flgry34iC5S949SVCH5w0ogMTpE2WuCQPILXTXxN6fkiWkdOKQXifKWWpyDZGq5VDb2+oy4kbmOiy3UMnKCYIyrR3hc8EnwHiVY2OJ/SAf6Novnt63vsmMpY2ivGK2GJasPE9mh173pEGJ0yOd+D/dFCMNjI3H+/kp8i+ffXhTQsWY6FCVeIEnsm3NvVmvCrZvCZspFDzG/tnttYDWrez3HWwyjhgFqSQva3JHDjPDcP2Yun6PaZhAN5j9UF5LpgI+BS+yvNqlZzFo3D2oXKU6hZcyRWX/kZ03YrKqAzxlD90QG5TRbu1y7f2uYakUG8woJwCxEN3QLwXB0cH+QYqZMih035/CgGZBsY2vfzTGXmEIR3rSGoQo89Vjxp89It5z/23ZUeR2CZ9x3JymYjkUxZu0L6erjkeC7f0Db9qMrCo8bm7EI5OlK7rvDUhc0uOQeSBIncEvq4ltdxmz1tH7/Zcex3dReQg3RoJOrIwuRELxOWU7ZT1HS5OvhGol4N4TApAAVwik5+kCzmTvxMiPq5mGKaTz8qcM7Beciom4GtUZb07nE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(261009223027099003)(11063799006)(4143699003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DRZ73GhE0dbnnCI82RtpW4/01prJNErMpdEopUZxDpNxISvbmsdGl/AafB6O?=
 =?us-ascii?Q?OtH+HP3EiRJttpgh58M29efu5HORspTWnyfMd78Dk/qfSSzc/ddq0u4oOwFh?=
 =?us-ascii?Q?tqgLP0FmI8X6RLxqnwo1gwIJ5iBaXbYTcrgYRzL98AflicZqF9e1bIFjB0Rf?=
 =?us-ascii?Q?hTLnQeFBeAmLPbdjRWqIWU3sQrc2NIi5bscdyRK5CtDxWlQ4Ox000alnYucN?=
 =?us-ascii?Q?nBMRaP0NRKYOWUG2tyQqA7bJloRAVroGYDOoSkAN+tjvPEC7e1ZJ+wQ4iiIy?=
 =?us-ascii?Q?Xbnz/UBVBv1MHGF+R3Uyup8C40xM2gIrq5klo2K+Z978BzzHDp3uMrbHHkwY?=
 =?us-ascii?Q?Jlxs39dzkVe7iSdDfeBmPkgmnOebKD1e5CfxUCqfv+5okSd4s9jI9BS0yN3s?=
 =?us-ascii?Q?+T3TkQyme0eoJzlNCEt6sSk9RjP9LE636WyEQfeqYXDtFOAy9tR/JATz+V/1?=
 =?us-ascii?Q?bxmfB2htcTcuJQ7g+SR8RCOgoFK7yizar/K41nFuZr464RpP1HpTlXiwnm5n?=
 =?us-ascii?Q?9t+QVudW8pYMk0X7cJK8/fQvKJWblTpJYFiflYP/9LL0lpAgUJQqAMcFmYK9?=
 =?us-ascii?Q?A1V69Xz9MdQA8LaFYcgzHZ/Bm7zEUq3TFRecturInHGZyFyWM2bdT+kZNJrn?=
 =?us-ascii?Q?WtukysAB6/hd5lEsJzn+nhBbZ1yo72051U/zgjih0FzuxZoxQ+CC82mGaVeV?=
 =?us-ascii?Q?GKbVrUKemTXVqDKRnKDoAKzIE1zkXNc2ylELJ0SedYlg+WcXvTmWcc/1lKgL?=
 =?us-ascii?Q?JT6E+f1k5p0RyW5MylV8aJ/by+d0Rji6RVxiggK3R/KlhNDHIS4KXArUPAnF?=
 =?us-ascii?Q?nA4pATzgSrEMYsaDqIMpVnFY0CupqTExv4wDnB01J61zg6aeSyllxf0hUs31?=
 =?us-ascii?Q?LFOkq1v1hAkLM0z+9VOY3z4+KxtZA50TVJiQXCBkv0n6+ERA7WHlmlJcUXLD?=
 =?us-ascii?Q?78Us0ec4As2yhzMeP9D3h08N3IekjllRYQfNRgCMwtvmiOJK0MbXWfYrhl8Y?=
 =?us-ascii?Q?jctVDrD5GlA9sS6jwI40ppUJLl0B9smynIrk+r+oRb7xwnhQmLEY9N0+VRHW?=
 =?us-ascii?Q?YoC0K6gXQ73lS5nqXQUd5xnfuHF0NOXoN26QNJBAOklOwgSmWj6ujbwQRmPO?=
 =?us-ascii?Q?8fBv2/wUzymNWEHamcu35gX+G7xmoKy96gLT25FdPsN5zi5KU4TYnat9jVTA?=
 =?us-ascii?Q?vkk9bsALdNifgHLfVr6kJbBHLs3qPvljTzN9Lm6Jv7zZhooPg8sSFCFD0wqu?=
 =?us-ascii?Q?HRLIXktlijZNCZ4dXQi7h23q5ovaVwXWzAjD4/C8AY+4IexeTJ55iJEY74C0?=
 =?us-ascii?Q?o8hmm9mu8EllzVDcglCBNwNsAFTFhMRvJigyDsmkek+b0P9W4GwKRDSfY+m/?=
 =?us-ascii?Q?25cfsLgjcQxWOnjKadoDUv2iFBxJYohxclelgepXyZQcueV7pX3Aug0ceayI?=
 =?us-ascii?Q?aVElsAJPj2GNS/fE2d+dYPyL+UldfqXK1/Dd9X9qS7fYBcxsztJO6QLXC7Nz?=
 =?us-ascii?Q?lCW2a6QFMgPxs+B4iEDBzMp6n9NkIKTQwf/eMfdpy2UT80zUmWk/MR065dc5?=
 =?us-ascii?Q?NRHBvEoJObEkMN2Z5qLbdLIn9DKjanFEzI3BAN16mZefwzEmTxTQ2IRouTlp?=
 =?us-ascii?Q?1n7eArNGu1pUWA+13/esbL7P9k7okR46L1hCGbPmD5PLzUHiOh63Gq7RuN9O?=
 =?us-ascii?Q?yQZvVoQroPKOH1yYuiTIB/kxXUorgOtkk+i3KXJ2pmnufq76INdsKAzMSJf+?=
 =?us-ascii?Q?9GKPiqLtx0hnzNjslaY8aEInrlHUEqk=3D?=
X-Exchange-RoutingPolicyChecked: VB6sADXhH2nsrwV11WTzPnhqV3zkjPvAK3uSeGHYJaFrNNlEqAZ/uoSrsF9B5WKjBIbKQ0Tz8oc3B6+PR/wZjgQyC92e9ABD3oQsLDxTYm+6xGBbozYSfoA3GHwr+duThqljmnaehfp1yriariKnRTBZGe9MDF7krm7A3S/ddQz3XaamldiyJ1hefNoT8pXTf/lpHyXdOsqG0Cj4lhh/y4pu9tz1og086S4WUdUbmdn7Tnw3Q+R3o6SChEVHEdikoJQsegZTCcerPQLcoWkKDmtTjlG1cxHEwGq5DEUdlqRZMmFcwlPUfwzkxJP8G4EInl4VWtIo6wI5ZY2DnkVUGw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2246dec5-bca3-414a-a138-08df4515d2ea
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 01:46:54.8827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdfD1qE4kD63zlPfOEhqwhcBGdrvtb3bM5wyQ3FePru4W2cKniYqxWIer28Sd2vYTQgNuWLsdZ+UON88MM4qIaXZoNk02us0+A5YSS2hjm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9773
X-OriginatorOrg: intel.com

On Sun, Nov 08, 2026 at 11:20:23AM +0900, Jongwon Lee wrote:
> The event path caches DRAM event records in an xarray. It frees a record
> when xa_store() replaces it, when the record expires, and when the cache
> overflows. The event path runs with device_lock() and cxl_rwsem held for
> read.
> 
> The repair path looks up records with cxl_find_rec_dram() while holding
> only cxl_rwsem for read, so both paths can run at the same time.
> cxl_find_rec_dram() reads the record after xa_load() returns, and
> cxl_mem_perform_sparing() reads validity_flags from the returned record
> again later. Both reads can hit a record that the event path has just
> freed.
> 
> Move the lookup into __cxl_find_rec_dram(), which is called with the
> xarray lock held. cxl_find_rec_dram() now returns whether a record
> matched, and copies the matching record into a buffer passed in by the
> caller. The PPR path only needs to know whether there is a match, so it
> passes NULL. No caller keeps a pointer to the record after the lock is
> dropped. The event path frees a record only after xa_store() or
> xa_erase() has removed it from the xarray, and both of them take the
> same lock.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Fixes: 588ca944c277 ("cxl/edac: Add CXL memory device memory sparing control feature")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-192042@kernel.org
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Jongwon Lee <ai@linux.com>
> ---
>  drivers/cxl/core/edac.c | 70 +++++++++++++++++++++++++++--------------
>  1 file changed, 47 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 34b81e8dfb..4624ab4644 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -938,18 +938,17 @@ cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
>  	return NULL;
>  }
>  
> +/* Caller holds the xarray lock. The record may be freed once it is dropped. */
>  static struct cxl_event_dram *
> -cxl_find_rec_dram(struct cxl_memdev *cxlmd,
> -		  struct cxl_mem_repair_attrbs *attrbs)
> +__cxl_find_rec_dram(struct xarray *rec_xarray,
> +		    struct cxl_mem_repair_attrbs *attrbs)
>  {
> -	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
>  	struct cxl_event_dram *rec;
>  	u16 validity_flags;
>  
> -	if (!array_rec)
> -		return NULL;
> +	lockdep_assert_held(&rec_xarray->xa_lock);
>  
> -	rec = xa_load(&array_rec->rec_dram, attrbs->dpa);
> +	rec = xa_load(rec_xarray, attrbs->dpa);
>  	if (!rec)
>  		return NULL;
>  
> @@ -1029,6 +1028,30 @@ cxl_find_rec_dram(struct cxl_memdev *cxlmd,
>  	return NULL;
>  }
>  
> +/*
> + * cxl_store_rec_dram() replaces and frees records while the repair path only
> + * holds cxl_rwsem for read, so look the record up and read it under the
> + * xarray lock, and hand back a copy of the record.
> + */
> +static bool cxl_find_rec_dram(struct cxl_memdev *cxlmd,
> +			      struct cxl_mem_repair_attrbs *attrbs,
> +			      struct cxl_event_dram *out)
> +{
> +	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
> +	struct cxl_event_dram *rec;
> +
> +	if (!array_rec)
> +		return false;
> +
> +	xa_lock(&array_rec->rec_dram);
> +	rec = __cxl_find_rec_dram(&array_rec->rec_dram, attrbs);
> +	if (rec && out)
> +		*out = *rec;
> +	xa_unlock(&array_rec->rec_dram);
> +
> +	return rec;
> +}
> +
>  #define CXL_MAX_STORAGE_DAYS 10
>  #define CXL_MAX_STORAGE_TIME_SECS (CXL_MAX_STORAGE_DAYS * 24 * 60 * 60)
>  
> @@ -1298,9 +1321,9 @@ cxl_mem_sparing_get_attrbs(struct cxl_mem_sparing_context *cxl_sparing_ctx)
>  	return 0;
>  }
>  
> -static struct cxl_event_dram *
> -cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
> -		     struct cxl_mem_sparing_context *ctx)
> +static bool cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
> +				 struct cxl_mem_sparing_context *ctx,
> +				 struct cxl_event_dram *rec)
>  {
>  	struct cxl_mem_repair_attrbs attrbs = { 0 };
>  
> @@ -1332,10 +1355,10 @@ cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
>  		attrbs.repair_type = CXL_RANK_SPARING;
>  		break;
>  	default:
> -		return NULL;
> +		return false;
>  	}
>  
> -	return cxl_find_rec_dram(cxlmd, &attrbs);
> +	return cxl_find_rec_dram(cxlmd, &attrbs, rec);
>  }
>  
>  static int
> @@ -1344,7 +1367,8 @@ cxl_mem_perform_sparing(struct device *dev,
>  {
>  	struct cxl_memdev *cxlmd = cxl_sparing_ctx->cxlmd;
>  	struct cxl_memdev_sparing_in_payload sparing_pi;
> -	struct cxl_event_dram *rec = NULL;
> +	struct cxl_event_dram rec;
> +	bool rec_found = false;
>  	u16 validity_flags = 0;
>  	int ret;
>  
> @@ -1362,11 +1386,14 @@ cxl_mem_perform_sparing(struct device *dev,
>  			return -EBUSY;
>  	} else {
>  		if (cxl_is_memdev_memory_online(cxlmd)) {
> -			rec = cxl_mem_get_rec_dram(cxlmd, cxl_sparing_ctx);
> -			if (!rec)
> +			rec_found = cxl_mem_get_rec_dram(cxlmd, cxl_sparing_ctx,
> +							 &rec);
> +			if (!rec_found)
>  				return -EINVAL;
>  
> -			if (!get_unaligned_le16(rec->media_hdr.validity_flags))
> +			validity_flags =
> +				get_unaligned_le16(rec.media_hdr.validity_flags);
> +			if (!validity_flags)
>  				return -EINVAL;
>  		}
>  	}
> @@ -1376,13 +1403,10 @@ cxl_mem_perform_sparing(struct device *dev,
>  	if (cxl_sparing_ctx->persist_mode)
>  		sparing_pi.flags |= CXL_SET_HARD_SPARING(1);
>  
> -	if (rec)
> -		validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
> -
>  	switch (cxl_sparing_ctx->repair_type) {
>  	case EDAC_REPAIR_CACHELINE_SPARING:
>  		sparing_pi.column = cpu_to_le16(cxl_sparing_ctx->column);
> -		if (!rec || (validity_flags & CXL_DER_VALID_SUB_CHANNEL)) {
> +		if (!rec_found || (validity_flags & CXL_DER_VALID_SUB_CHANNEL)) {
>  			sparing_pi.flags |= CXL_SET_SPARING_SUB_CHNL_VALID(1);
>  			sparing_pi.sub_channel = cxl_sparing_ctx->sub_channel;
>  		}
> @@ -1399,9 +1423,9 @@ cxl_mem_perform_sparing(struct device *dev,
>  		fallthrough;
>  	default:
>  		sparing_pi.channel = cxl_sparing_ctx->channel;
> -		if ((rec && (validity_flags & CXL_DER_VALID_NIBBLE)) ||
> -		    (!rec && (!cxl_sparing_ctx->nibble_mask ||
> -			     (cxl_sparing_ctx->nibble_mask & 0xFFFFFF)))) {
> +		if ((rec_found && (validity_flags & CXL_DER_VALID_NIBBLE)) ||
> +		    (!rec_found && (!cxl_sparing_ctx->nibble_mask ||
> +				    (cxl_sparing_ctx->nibble_mask & 0xFFFFFF)))) {
>  			sparing_pi.flags |= CXL_SET_SPARING_NIB_MASK_VALID(1);
>  			put_unaligned_le24(cxl_sparing_ctx->nibble_mask,
>  					   sparing_pi.nibble_mask);
> @@ -1814,7 +1838,7 @@ static int cxl_mem_perform_ppr(struct cxl_ppr_context *cxl_ppr_ctx)
>  			attrbs.repair_type = CXL_PPR;
>  			attrbs.dpa = cxl_ppr_ctx->dpa;
>  			attrbs.nibble_mask = cxl_ppr_ctx->nibble_mask;
> -			if (!cxl_find_rec_dram(cxlmd, &attrbs) &&
> +			if (!cxl_find_rec_dram(cxlmd, &attrbs, NULL) &&
>  			    !cxl_find_rec_gen_media(cxlmd, &attrbs))
>  				return -EINVAL;
>  		}
> -- 
> 2.55.0
> 
