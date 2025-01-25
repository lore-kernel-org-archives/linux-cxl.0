Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EEE1FA26C
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jan 2025 02:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737771793; cv=fail; b=IkGfZNVeSc3sSoxsnXzbFI9GnFzrRi9Ondx1gewKJry78qocq+RV+WCOK40svpThhDp+lTv9XNkEC1enaUQlDthNPD6HT8CozsAPdKuq9+FhsmgmmNRm2U2mrRcHAL4aFMiO+Qlm1idHI5JJpUg3PrQElBfJ7s+ubRxDTVIT6C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737771793; c=relaxed/simple;
	bh=ZYX3srgiTI3nu9rmQ/fgo2AmyGjLpZlYurh0gLbPa24=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gftNIxuqoaT5H4WtG3XlWLFzAFQyOO3rwIBP4af05zCYR3b/Twti1D1U8JxpsiuB92CEoWmIxP76bCQNNd7IhHxxtnopFDjGvJt2cUQab9xqiRN5zUqKkvTwWtHsxF9tUBXm2d0MsAhRJccnbPwwA5VCVSTsmvNtsKNJrCjNvwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WNtqbo05; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WNtqbo05"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737771792; x=1769307792;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZYX3srgiTI3nu9rmQ/fgo2AmyGjLpZlYurh0gLbPa24=;
  b=WNtqbo05CTIolqRP64LtJ0c5ea3xCvzVqm58/F/U56/xnPg7NrGljtXu
   WeQpsoSTy5ubcV2I2t+Q/CCjA8nyrNx3jIqdT6lm/1eGiN/hTvTFFl1Ql
   18gsHgbxo9TY5lD4O8mwiJLhWSuShqhT3JhtaisyQAQOd65k9sELYf0fy
   lGo2+78U5cudhJV6dj1TSe/HHaiIPOvenGe7mQK5PLs6kFQEkIJ/qWqZ7
   ZwsjfNa/Xt5W/KVT8Z+h1p+NvZtKGQJLQC5S8urn8WowFsE+PVtsk3tGT
   CnGH7WbncZUNY2t8uV5+OQ5SzCkecR4CVdWd5sxh3iL3UkfoPzo9zO+A+
   Q==;
X-CSE-ConnectionGUID: 3evhcipWR024HJ3LJJEbPQ==
X-CSE-MsgGUID: IyYOWI0+QLGe8LYMHALfPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="49305654"
X-IronPort-AV: E=Sophos;i="6.13,233,1732608000"; 
   d="scan'208";a="49305654"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 18:23:11 -0800
X-CSE-ConnectionGUID: Dn9JqZo/TSauncU+uW2XlA==
X-CSE-MsgGUID: vCrV1+neTcOtnJmQRodFMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,233,1732608000"; 
   d="scan'208";a="112949158"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 18:23:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 18:23:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 18:23:10 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 18:23:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIAvPFqYbo7NKbdnARVVGtLrK6dHiJ/pojolWxOFZEx4svg4bbKkhcHdHaa7kc+xLYhAFGCddbJXrd5ixqLWah4y+2AXiD4Am7vrwOTISDD9pNvewYnhEG0jByjXjaSwPJBjO4KsoFPnTrVwKzfQ2ryZCDrbyqaqXGTYmYe10Z89vMCgtRVofbL3VwdhgZtX1c/fkRMDdSGC1eE5K+kStHT/LD6P3rd6QC2yikQve9Gh4uOKLcM9+Owtry/IDKYwtOMuLWP3qCKee9fm5ClHbj0gNH5XrYACcGx42+O74OxYbMXEb/W5sKIi9J00co1jUYrxCwHDJaoAXmnaOaNUwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utjqmIIyyRp1rlpTBsMelimNEvlR8zfx7owPAy2LxX8=;
 b=d4Wu6JYsK9ahB4i9WAt9ztCKNtY46WHQvQVwCx7dF0JXE9sq8G438JBlSiOI2rUDu+fN/N1xauzTHn6qNly6k79R3qSSjzasAp15lupWDuN2muTaRMc1XzOSyGHYZ5sPJLZDuPks8LGaV0XUcH4vyS6gWM6Hk7gBKkrvJj5SRYfPlRsnliiQAu5MZhSmPtrNAAB6RFuAGRMxPBbw5aXBWm6nkdpukx9rLRw1N54X3CuVp1PWV7FcPL14FRXls4bxBz1KlOcafWO0DFJ1kLNbHIJvpKJvm5cuQ4arB7++lTw+FOofiFfmcFekzzpXF7Hn/ILHpzd0aH+p3gln2aYt6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7113.namprd11.prod.outlook.com (2603:10b6:806:298::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Sat, 25 Jan
 2025 02:23:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Sat, 25 Jan 2025
 02:23:08 +0000
Date: Fri, 24 Jan 2025 18:23:05 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 15/19] cxl: Add support to handle user feature
 commands for get feature
Message-ID: <67944b09cd1b9_20fa294b3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-16-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250122235159.2716036-16-dave.jiang@intel.com>
X-ClientProxiedBy: MW2PR16CA0018.namprd16.prod.outlook.com (2603:10b6:907::31)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec54002-da53-4268-4900-08dd3ce734f3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UNEaxgnHo83BYgrub3L6mPRu35bftDUH3zgQwMxtCewpxz3qGBU/8NM9UXso?=
 =?us-ascii?Q?q58DxP5PsJ5L2W+ZQL6jDuPw/PsmFA9IX17Z3K26lJ7dkC7ErOslKADGtT8C?=
 =?us-ascii?Q?MKzIJ+Krfbx/2L6et5gfetZnr3z7Lc4py32Zi1Fb5Bx3xD/XAz16dD70nwaB?=
 =?us-ascii?Q?xo/s/U3VQUCbYjngQZEGtaKt8pA1NXqoR1TSf1Q99XXquBwPdmukWLw3JTbW?=
 =?us-ascii?Q?YobZU9NqIoPEu3vIGlPsEF8zcUxniyu83ecPS2cGXqRatqjAmYwu7HeT/UC/?=
 =?us-ascii?Q?dUlJqTxplvfhWAMQRpLQwJo7dHEHK7nTNrR6tQXBIltaqLSXjYoNtdB5syZt?=
 =?us-ascii?Q?ew2dy3KZH69GNS901Wg9CIQifNbAOfAoPsQ5h7AvqO8M2ae48epeIYSCAYQg?=
 =?us-ascii?Q?PqHlbiAw74/4teKszJ9sgYfBwW4iFQp0Z5Xy96AqKKeJ86kDn4h8kvCRGdw2?=
 =?us-ascii?Q?ET9jXzqiqYXwcp0HmKtDUe7dr3gubjfx8w77eSorNYse63f8QpF2xihpTI7N?=
 =?us-ascii?Q?AfPtS9gpQ2f3n/d0ey6NfRZXOYV1G6QpOsBptJt7wJZnblQNfRyc3lKrhBU4?=
 =?us-ascii?Q?/VXzdWYtGWNstACPS/KiMJH2cs7/V5yH/rnXoSJ5Tz8mSFpkkKQL7+Axs1Xw?=
 =?us-ascii?Q?TZlr9s9uDtZUZZ/V6jT9gt9q9JBXjGuX6tsCja3wS/FE0e/uDlFZjYTpqdm3?=
 =?us-ascii?Q?uJMiClb3yM/LRAB31bP1xc93bQTmuJ6m9aFDx35S0/jL54viJSgfDLi8SUk8?=
 =?us-ascii?Q?fJV5ow+mo+4iMdo0ZkPuggDmmUk90b/mC56XR+ZPntpywXlV4NqWovhTqIpL?=
 =?us-ascii?Q?6txX0R4WAvxym88ek+4Wh1KS26OKicIDROZ6E/bATS9IW3+ATW5O8O2Dr8VD?=
 =?us-ascii?Q?Bqf07urJQfsC30z3tkoK4sp2XcwrUU/NXozlyxnOZq1CF7dmiLgKVJkkPu0/?=
 =?us-ascii?Q?iP9Mzqa78roKX/TW/Qyw//uXLlq/0dBFaqY2TwCdmyp9AhdyDPH3YN4QBXHZ?=
 =?us-ascii?Q?olhpXzfs+7Zmg7TlbnnfLUCfUAA3iqUSB0A9K9end/oXubgnx52dKLlorTUN?=
 =?us-ascii?Q?JbgEQKHzzky30QdD6QN8SK+JSqxnXIDTzUysdB2e1k1MGvzK8ADL7X2bTEIx?=
 =?us-ascii?Q?kEdlbjV+/v38SgYNeiW0QtBYg67JZKYPxXKMg59X7eERR/DFeRIT/iOWBQA5?=
 =?us-ascii?Q?n0NjnD+dqpPAVrC5sZQ6/LQ64hZX3uZ2Kvf7i/rLbs7WeLkx+5N0vWXyTa6O?=
 =?us-ascii?Q?H5V3O5uF5GgAKPeQs2lFfSoBdz0ckmktDCaghzAWfXvBLbCINn4XBJ8J2vI/?=
 =?us-ascii?Q?ccsxRo/r0TtVlHyGQM2QTtOYuTsNHTIFo8hosTfk9rdfSQTKatRpPfCHfWYi?=
 =?us-ascii?Q?bvWvQegrYuLmSJzxlY6/37MdTwWG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tRkvuloNgcMWxOyl3nsETECzgHB21Tus38GR/I/eVMEUzy7OsDs6mbHFyevk?=
 =?us-ascii?Q?/5iLXhl7sN9QDqD/j+IOOH6OZ7gefmSDeEZ1PaP2NBDS2GAIrtbfDve0cyRp?=
 =?us-ascii?Q?hjqNfcibed8Lv1mUCLCHAiU9LQjLNp7W1bIjat0s6ArfQy95hH1dN3ggdtHh?=
 =?us-ascii?Q?6qZU3YqanY3BXSfK0/F7oHVBiutiZv9uiRK0UinpsTPrFl5pDr6nPQmnGdbE?=
 =?us-ascii?Q?HwhqAkmN7v+8kKcpGCcWX6NtniiNKG1VhFdbaXuXK9P+Gndwd1GXriw0dh9s?=
 =?us-ascii?Q?ARkKOb/ZtteDlxZ9cV1DoEoJVZxYX/vNhbeJMgGf252iNfMUA0Pyc0VVNVmq?=
 =?us-ascii?Q?VO0t5WUKgzCqeSGnmeZM1oIvgP3fhTiQyNAh6Wx4WzPc74+cwBmPmHfWnmxf?=
 =?us-ascii?Q?HTeEh6GjHPLStQ7tnG8Yy7/OjySq1a4LtPlpRMZa2xSCA6wj3YN7e9stLftd?=
 =?us-ascii?Q?ASRU+NwmGgX5DQIeRCYGPNlhREI3pgDbX1rLC3ut/hKnvM1hJpZe1XsJ1GW6?=
 =?us-ascii?Q?pzziG+sCGsr6+/zjxYMtBJE+2Spzn51O9rNN1L/YNZjUCkubQhOLEYSpC+Pr?=
 =?us-ascii?Q?dW88wHAOitvZyhO70wgUyh6U/MIyqBEfFZ6R4Khm/GjkLGZ/IQAd7ZPiZNV4?=
 =?us-ascii?Q?rmWc4M1vdpKQdE04CswJ9g2eijfWcJRw+r+sUBAudDat6IeWS/A55vmPsPAc?=
 =?us-ascii?Q?HHxp4t+NMPWSba8i55XaPmqr7UgnSrywt6MXYV3Qy/RLcd1jGn40+kYGoOy6?=
 =?us-ascii?Q?p4+7XNrUPzajaIK+OYa2Q33MXmtrOnNshmW8V0kz49HuyZrIWOeMtF2f5mJ/?=
 =?us-ascii?Q?6nMw89MnSbL8Mrxo//SszgzgGNPbRXUA4ivhjQJ6E50SDHV2po36X4JhFbon?=
 =?us-ascii?Q?taAKmtk/kSKLTtSpK+SV63YWcek+7xfQ27HYL3C4R6Kcq9uPsXmutp5mqMIn?=
 =?us-ascii?Q?wswylUEoTmlswjEbLPSIUdhELw7R0sLRhCYr5uLYlz+MAMMzlX95swtWIZv2?=
 =?us-ascii?Q?9o94DGWto1lULqLAwEM8BMn+cv92yC8xUGAjKy29WFxzvgXNAVZyQGru2nS6?=
 =?us-ascii?Q?1BfcOlSxLnHRMNmRk26ogvVBaKwqFbUyObfSKm+OMIVz7zBgsX+9J1TmZsPF?=
 =?us-ascii?Q?/N8j3qEjruaKCRTfRlzT3EtEPv/T+lzeSKc+vlo0nCfjTcFIpm+1yUy+AQnu?=
 =?us-ascii?Q?Ulz1nKGHbpuGItrEqwu0OolSScyEpBOJc+oXoMDXIvTzcuQOKGe+b3CkY3SO?=
 =?us-ascii?Q?kOVYsfSUR3m35ORortW4/XV/fwXggIitjLFQyp2e7qT4MfjauICuRpaRKNju?=
 =?us-ascii?Q?Pr+wEkFjVahKn+1pTkxLczSv21CnFFNGuc1WQjAZcCULARrMAq1e4FnabEmU?=
 =?us-ascii?Q?yvru8fbxJlY2RNdjehWQgvKfZl/vMM5wlmqMMvYO7AsZAfqw3Jzqi9jUfEn5?=
 =?us-ascii?Q?biujfL+jhGcyLeLq/qtxxenVAHn/YrH+iCuDonQn7SWGV6F1N+LSjg9XOgNZ?=
 =?us-ascii?Q?Ggw6RVTFszycLDH3hns7C69rU+bzdMbycwMNHiMfZs//Zsp1uuFfDNM72kXg?=
 =?us-ascii?Q?7JmE5TpQw2pvtWjf75Z0Q2N47y7vZGvislSwj+/FcBkOzLqf4Kshh8ZIIQRj?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec54002-da53-4268-4900-08dd3ce734f3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 02:23:08.1326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxAY4pkrnP6sX8oZDutCydR8lMs1D6vZUktpxRFBWB2rgfhOh3aZAAcw3qGrtDRSPeWs7CfzBSqXiSteQ16QcCWzml/VXObUeRCI7HfciSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7113
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add helper function to parse the user data from fwctl RPC ioctl and
> send the parsed input parameters to cxl_get_feature() call.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...modulo reworking @cfs related entanglements.
