Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291E23905E0
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 01:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521739; cv=fail; b=mhUM11PTL6jXB+o/Crcv8l1O374SaQQiUkRfL9lNehX5HiHgei1sgt4a/zdMjN9MjZcOYefpMHfY3b5IEb9wzESYtHgOG6f0CBdEbVlWpZMsiw7+U/n7PJZ0R7rA5jBeAcHU1iJUsdqA0GZEjfbRZO+NVQ9jErNmwIX5biPFu04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521739; c=relaxed/simple;
	bh=UJSaOhUMMEXkH3JMpbBoiX0A8ublPT3scw9v5Ek3ocI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SzkYSVmAMjg0vN1iMm6MAOdhVBEtlrs223KlwUkyaEbtXr18kN2qLargjnmaIPXkiaaT64W+IzayBUhQSfvZOUTNXLMgwJ8fkDe4+j1UD1XZfnyjcViWQo3BoffEeZuqXsj7RYqGtwoNN6DZilzxpIY08eqRCpgO9QXi1yDtwIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l6MARD+G; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l6MARD+G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789521737; x=1821057737;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UJSaOhUMMEXkH3JMpbBoiX0A8ublPT3scw9v5Ek3ocI=;
  b=l6MARD+Gyl2p2C4+4EZHCFz+86tFJj1e37KtRMZ4QuyNM4OFjfC96iMZ
   xevUn3xD0ecqYyPK7JDwcliaeCgwFsNxMXMmYCx1ZU8bqmo0TnWekXJm6
   P3VPep3hy+V3BGHppGvxLsYiymBwFivkdxFMTk/Ki96LuCVVfR1qRipUA
   SyHrQdDMIkUd++mFPwbcP5U74ewVkBugirX1hQTn+ARtkTnD48MWV84Bn
   YoHc2ZMBatONvgiyEG9r6psKClRuHXpLngePxI3U+wul35KrktABRMPnj
   SSLiByIyo0PgryEfAUGKdMjXb5YvltCZg+H+RnqR7b973+leYb3sc+/N3
   w==;
X-CSE-ConnectionGUID: hWTM9QGKRySsbFBj2QjYIg==
X-CSE-MsgGUID: J49UCaCoQA6A+084wLDmAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101241696"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101241696"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 18:22:16 -0700
X-CSE-ConnectionGUID: UkPRijpaQRW9LDk9JsndhA==
X-CSE-MsgGUID: Ox9iYoTBTKyvxb/2xn7kHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1402446"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 18:22:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 18:22:15 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 18:22:15 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.14) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 18:22:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osGZdOzxUX0WPWkKI4N+X3TiLp2WsLzOEpb5ON+Hw6RZ6mmP5EoD1V7PmcWyq3/DLvwE0vZtgPjcLKcT/NVfeXE04K4Y89y6nxaHorbch7+PjqLQKLDgh+YLDvNMvk6bP5uME3QWZzPwdXYb8PJsMBp9kk3wv64p7OdarGGwHZytgGwueRiGeY9QCaFrV9cGmuGV/Vi+vgPCsH7P0Xd+aYo8DsaP9BFLSdo0wSjtScpLtc+ixINKPlxV4fwYHa5+ndiHrvKggLFTQx2mqHDWyLXl1kkfE4arLF300KwvjGYo0BOBC1c8f6K3diXSMvKRaOy5aelrF0rk7Jii7Qpbeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9T4g5HnkEuEOw4LJnvzM/n2kyTQEkvb6fbIFMlhBbKE=;
 b=h/j/pusYFMS4JVQOTw2xrLu0QcjXSXk0nwsZODUgh6KNdUEDN+hpYYkFkjdWIFjbMboBaxo5d6SUtiTjUxI9VCO9IeoLcwyiUZ7Y/r/9w/Ka+PynpKywLAn+Kl066CGVLPaYH7q+eIuEedO8qkuSGGrw66A3q9ver10w9IqV2ii7JSXdSFkENuU0J7Z/6ondur5biz5yOidJsZ81xaxxg5qc5ZXW+32xS+k4xFc2IBCVymzDTejgUZw1PMH3t211s17U5EAJXV23MWkifhRNFtY6f6G1PtSMwR/fFSUGiLwhcUS+G1Gn7hrBsA9GBeqZf6HYzw3MDkVZFV6iCXgRJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by LV0PR11MB9864.namprd11.prod.outlook.com (2603:10b6:408:384::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 01:22:13 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 01:22:13 +0000
Date: Tue, 15 Sep 2026 18:22:08 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Anisa Su <anisa.su887@gmail.com>
CC: <linux-cxl@vger.kernel.org>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<gourry@gourry.net>, <icheng@nvidia.com>, <ming.li@zohomail.com>,
	<vishal.l.verma@intel.com>, <dave@stgolabs.net>, <benjamin.cheatham@amd.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [RESEND PATCH v13 0/8] DCD Prep Series
Message-ID: <aqnvQE5nGQ-i5iCs@aschofie-mobl2.lan>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908102124.2231730-2-anisa.su@samsung.com>
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|LV0PR11MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ea8e46-aa10-446f-bb00-08df1390efa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|3023799007|10067099003|11063799006|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: qzj7QgBb2yQkdNEgscwM8hCEV/qw7OTtAyqYLguhHnin43hXRj04/VBcrsghGaIi611BbsIV85zmA1LxF98Q5pMxvYexbM3sL5jSVxMADZyJO71LJCSD7+Tg9BDwPOKKqr44wdweY7R0XLP5SRxIMwIs4UKAcVl4T27khEUKFaZbEWkHIeR46n3C+HIWKkvIGnx5Vpt1dDvsWsTLZAgIJQzOehafl7rJztPc/k8OQS79YosQ1wqylrI1sM3s7COS5CBxF5iR3ldGh1b2vvrmqQx/Kr2i+t+FfnuXWtjlK8SA/FEj/VzhVGW/jsK9OeRI2A7WvKCw8FJ/rQ4EayKUtUIwzmxBi4HkGldjkQyepCO4GQejoNx7JB+JtVWsjVA8tAXR1+9lPLDc/rLYsgU9bQLu7kcq2UAAH8hKReicsiSXnJbxBx631QvxkSbOmm0zUUKZ+kCEg+KQLqT5f4gZco5/1g0e7Iyyp+bjNITS/FhWIPDo+M0T/Fo+TfegljArKuNaIKlmFT6E12Owd/V7RATZ+uqB0KK4GvBDCwJCO55Ll7wmqd1VYcn1pnNcW2jOSmqzDNsP5j6JhsoiGNg7nmw9Mgqepw9FF3Y3gtfUDz1681wxRPwpX6k6muQSCr1ouACE5b8y0AghM9nTPYHRfRkYv8OYwhT0gLNLFcwDCtU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(3023799007)(10067099003)(11063799006)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+HsPbcaG8smDz64it7m8wZXX8pl7T0EKuzpc+oasdaf+nF43V/tA5CFf4brW?=
 =?us-ascii?Q?u2eHDBi8irTmSOslcL4cearfifo3oD08qHLYv4XjadiXIt81Tc10IUyomZnj?=
 =?us-ascii?Q?RfDtg+GITk5m199SuSF+FmfA8qMN+vGlYcNGnmNoPpBJ8qofE/ms/lxwvYOH?=
 =?us-ascii?Q?EMGgji+3N2tS4R4vLGheBxXZtIA3+AOL4NoobVnlR1nledfIjix1N/2ESRg0?=
 =?us-ascii?Q?+KOpMYXGHbLy/o8uNLY0BzQ20Py3AfjQmToVKYWkhVGykloDmKwrg4cj+JtA?=
 =?us-ascii?Q?iJRla1kG68ysyFIj4cDLbHIXUuGFBoc1Lm6QKT1d/1YwQOuIwYGqi01v/xP/?=
 =?us-ascii?Q?6GmigCcJ1845vTZYlVG31wvV3m6RxHogLGOXBOyyyWzcXOFYeONL2kG3glH5?=
 =?us-ascii?Q?wfn36iZPz0xCogQHkN8FAIikGy/A7wwk+NRctC6Md4AK1sco6EfhUjBhreda?=
 =?us-ascii?Q?TyO2d5SwgtErdwYbekZbVrr3lXiHMRz34q3q9cZ6S7tf/i0va93pdrErrmn8?=
 =?us-ascii?Q?6b/pHYv1C/XD3Bwwk3HIMHYD1YxIhfb8R4/ceH56bKQ+GWzZKF44uMfnHPCL?=
 =?us-ascii?Q?oATpUkrAwi40RUN/nXo3hAbM8uK3uemTJ21/kB2dOCl8BbXj0bGnEkqH9OLS?=
 =?us-ascii?Q?TmSEL0kwd7Kwgey0ofL6giU7fqY/bULs1E0fURVkAEZcVUsqudeGByS36HGK?=
 =?us-ascii?Q?pVMJRDHqKjpQ071lki484SByr56wCMv8qpJ1AkIC+qgmTXQkAnUDti2PZGkf?=
 =?us-ascii?Q?ZUG+lIt8ir3rQXSzZml9+prLWL0noYEEsuIgZrhPl0FgwL8CSL0B2jlNlct1?=
 =?us-ascii?Q?MRM7Eo1LRDIgYwF0IRM98ElXoK3GBC3SDqWKcfgY5hwk54o393/Ypz46eI99?=
 =?us-ascii?Q?Pnh95fm/Q6BqgVawYr6/d33NYdqtUlS7LID10agPABeTDbZDeCqCTXS167SP?=
 =?us-ascii?Q?NaYqyhNjxFIEM/IBs7tqUBCbyNbhWTA2YHkb0lM9Epm24Q8FJhAMrute8ojc?=
 =?us-ascii?Q?cYEmhGl/+LmHrhPAfB1jRO5Ytvop/40/7svkvkHS6osCM0EUJcILFrfJVrWW?=
 =?us-ascii?Q?JM4fAeZ879It2RFTgqHuqJCyCrTMM09cExRjUdXfNR4PTpXQwDyZ1W2R/Fpt?=
 =?us-ascii?Q?xhpsy1Aeu5fLQmL3ivdJa4i5DtQVb9RNz/qVUpqJRA/125bn2PJLUn16zfQ3?=
 =?us-ascii?Q?HGKJPr+GPJC/5Ta6W86vb6ZkTJjTtmtp1yB7AbqYhkf3U/sR/j5ijITCB+kJ?=
 =?us-ascii?Q?SVAKVs5oDbDSjh7gsAFzN7cick3JumWZHyca09LCh6Ddk+2GRf3d/sLP9hvz?=
 =?us-ascii?Q?7gk7iUPD8T8TOzUBSEworMLx1LNK3dLTmdxvYRSDe92ZOBPGaF7zJ7I3unLi?=
 =?us-ascii?Q?oqx5iBuLv8QYI8z7X+BUCgNNqiHQQ7Q5HtObnafRX0kQHkouGSaRCTlHS5U2?=
 =?us-ascii?Q?aD7N/7DcwFFV3u1OInY4MxiY8+EM9dEFrQPtBIXlMZQBJb3iVIikRYqKQGB1?=
 =?us-ascii?Q?EdVu9yWnBfBWe+mxlwV9wUWfkCiJX3p2T957/okPoG5k822BlZ2WZ5m2jsvu?=
 =?us-ascii?Q?cYNgcD+3GRsDjyee0Go/+YYUmOU+Y3bFGlNIUEDxrl8XB1BEMXyYk/wrXela?=
 =?us-ascii?Q?ETvR2MSKJdIcUqGwOzIejAX/w/bEjb5D9jGAfkgrSXBO24Fn/pVDO4z7nWdS?=
 =?us-ascii?Q?/qUNxy28oB/LYHxR5m+qSPoDA8y4Xq+tZ+ecdDjlyhvuGoF9WQolXg/3H88E?=
 =?us-ascii?Q?cbX20y7AWFxjSfWYJO9TZ8QjPeBdpS0=3D?=
X-Exchange-RoutingPolicyChecked: aMAMmP54DLW4QuqGLOk5I89N8B+mrwDwM7vY0n7h1fU81MKp0RMFPRhjR8mKPyqyR7bmNqspSDWkjiEsVu4PRxl+Jdd+2oOjFReCQheyCC/qX0+8aduJVdgAPs4tNgwvsqwqMTQGmaVyQl8lRC5n8TK0ey4jD9d38jkDTFiRYWe6Rq2bAdRAIftyetQej/ZEJoYc9eW+qXOeQI657ONjjvzdlwLzpRRjs08bef1hZt1/lU/tkI3M9n2nL2TcDsN2vgiVoAF9o1bLceg/00aCMTWOJhOm5blZNlriP4iviofPI13BNiSGfFXJfhampQ+tQZyfsF6fGEdlhqTk1HEYNw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ea8e46-aa10-446f-bb00-08df1390efa2
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 01:22:12.8805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1D6g1uWZhdfoOJ+d84927fI3xjoXUpaNj5lIuyJ6pSR2KfEaBJgPvT++cz9fIjrCJFoTCkbFlK4OnPolbIWp2uxQImJdh1eZMkk7SZe6ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB9864
X-OriginatorOrg: intel.com

On Tue, Sep 08, 2026 at 03:15:04AM -0700, Anisa Su wrote:
> First send only sent cover letter :( Resend with patches.
> 
> These are the first eight patches of the Dynamic Capacity Device (DCD)
> series. They set up: DCD enumeration, CDAT handling for DC partitions,
> the event interrupt plumbing, a preparatory refactor, and
> documentation of the DPA partition layout. They stand alone and keep DCD
> disabled. They are not dependent on the rest of the series.
> 
> Patch 1 detects the 48h command set and then leaves mds->dcd_supported
> false. The flag is only turned on by the series that adds DCD event
> handling, so every DCD specific path added here is shut off at runtime:
> cxl_configure_dcd() never runs, no DC partition is created, no DCD
> interrupt is armed, and the CXL_PARTMODE_DYNAMIC_RAM_1 paths are
> unreachable. The intent is to land the enumeration and plumbing while
> the extent to DAX pipeline is still under review.

This series passes regression testing w https://github.com/pmem/ndctl/tree/pending

Tested-by: Alison Schofield <alison.schofield@intel.com>


> 
> Based on v7.3-rc2
> 
> GitHub Branch:
> https://github.com/anisa-su993/anisa-linux-kernel/tree/dcd-prep-v13
> 
> v12: https://lore.kernel.org/linux-cxl/20260731084901.1512819-1-anisa.su@samsung.com/
> 
> v12 -> v13 Changes:
> ===================
>  - Dropped: cxl/core: Return endpoint decoder information from region
>         search (v12 patch 7). The new interface is not paired with its
>         first caller in this series -- all three call sites pass NULL --
>         so its contract cannot be reviewed here. It will be posted with
>         its first user instead (Alison). v12 patch 8 is now patch 7.
> 
>  - Added: Documentation/cxl: Document DPA partition layout and ordering
>         rules (patch 8) in-tree in addition to the commit messages in order
>         to be explicit about places Linux is stricter than the specification.
>         Add a section to cxl-driver.rst separating what the spec mandates
>         for ram and pmem from what Linux chooses for dynamic capacity.
>         It is documentation only.
> 
>    The series is eight patches, one dropped and one added.
> 
>  - Patch 1: cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
>         - Commit message explains why mds->dcd_supported is left false
>           and what turns it back on (Dave).
>         - Drop the single use cxl_verify_dcd_cmds() helper and test
>           bitmap_full(dcd_cmds, CXL_DCD_ENABLED_MAX) directly (Alison).
> 
>  - Patch 2: cxl/mem: Read dynamic capacity configuration from the device
>         - Validate only DC partition 0. Every partition the device
>           reports is still read, so the framework stays the same if we
>           decide to add support for additional partitions.
>           But no validation is done for the other partitions,
>           so a defect in other partitions that we don't use no
>           longer prevents the driver from configuring dynamic capacity
>           (Richard / Alison).
>         - Rework the cxl_dc_check() validation: checks now run in
>           dependency order, block size first, and each failure names the
>           field that is wrong instead of four conditions sharing one
>           "invalid length" message (Alison).
>         - Drop the block size alignment requirement on the region base.
>           Table 8-347 requires 256M for the base and states the block
>           size alignment for extent start DPAs, not for the base, so
>           Linux was enforcing a constraint the spec does not state
>           (Alison).
>         - Range check the device's available partition count against the
>           1 to 8 of Table 8-346, before it is used as the read loop
>           bound (Alison).
>         - Split cxl_configure_dcd()'s base check: an error for a DC
>           partition overlapping static capacity, a warning for a gap
>           above it, both printing the addresses. The old message said
>           "pmem" when the comparison is against total static capacity
>           (Alison).
>         - cxl_configure_dcd() returns an error instead of void;
>           cxl_pci_probe() disables DCD and carries on rather than failing
>           the memdev (Jonathan).
>         - Check the block size is a power of 2 in 64 bits.
>           is_power_of_2() takes an unsigned long, so a 32 bit build
>           truncated blk_size and accepted values such as 0x100000040
>           (Sashiko).
> 
>  - Patch 3: cxl/cdat: Gather DSMAS data for DCD partitions
>         - Only assign shareable for the dynamic ram 1 partition. It was
>           set for every partition the DSMAS range fell into, while the
>           handle check beside it is DC only (Alison).
>         - Reduce nesting in cxl_memdev_set_qos_class(): invert
>           range_contains() to continue early, and use a 'part' local
>           instead of repeating cxlds->part[i] (Alison). Doing this first
>           is what made the reworded warning fit in 100 columns.
> 
>  - Patch 4: cxl/events: Split event msgnum configuration from irq setup
>         - No change from v12.
> 
>  - Patch 5: cxl/pci: Factor out interrupt policy check
>         - Rename cxl_event_validate_mem_policy() to
>           cxl_event_fw_owns_mem_logs() and invert it. It never validated
>           the policy, it reported whether firmware still owns the
>           standard memory event logs despite _OSC granting the OS
>           control, so the name now states that condition and true means
>           firmware owns them (Alison).
>         - Commit message: "validation" was the wrong word for what the
>           helper does; it checks for firmware ownership of the memory
>           event logs (Alison).
> 
>  - Patch 6: cxl/mem: Configure dynamic capacity interrupts
>         - Disable DCD when the device supports the DCD commands but its
>           interrupt policy is too short to carry dcd_settings. The Set is
>           sized by the device's own policy length, so on a short policy
>           dcd_settings is never sent, and the re-read afterwards leaves
>           the driver's own value in the struct because the device does
>           not return that byte. cxl_irqsetup() would then arm the DCD
>           interrupt from a setting the device never accepted. A
>           conforming device cannot be in that state -- DCD is CXL 3.x and
>           a 3.x policy carries the field -- but nothing tied the two
>           facts together (Alison).
>         - Move the DCD bit out of cxl_event_drain_mask(), dropping the
>           mds argument it no longer needs, so the bit lands in the patch
>           that adds the code draining that log. This patch still defines
>           CXLDEV_EVENT_STATUS_DCD, adds it to CXLDEV_EVENT_STATUS_ALL and
>           arms the DCD interrupt; only the drain bit moved (Alison).
> 
>  - Patch 7: cxl/core: Enforce partition order/simplify partition calls
>         - Document the DPA partition layout above enum
>           cxl_partition_mode in cxl.h with ascii art, and cite where the
>           order comes from: ram before pmem is mandated by CXL r4.0
>           Table 8-310, while Table 8-347 only requires the DC Region Base
>           to be 256MB aligned, so a dynamic partition following pmem is a
>           Linux choice that cxl_configure_dcd() enforces (Alison).
>         - Commit message: say what the partition order is, where it comes
>           from, and that this patch starts enforcing it. The previous
>           text named an "implied partition order" without ever saying
>           what it implied (Alison).
>         - Name the partitions in the failure: "Partition order mismatch:
>           %d (%s) follows %d (%s)" via cxl_mode_name(), rather than the
>           bare "Partition order mismatch" (Alison).
> 
> Review status
> =============
> Patch 1
> + Reviewed-by from Dave Jiang and Gregory Price from v12.
> Patch 1 did change in v13: dropped the single use
> cxl_verify_dcd_cmds() helper so cxl_walk_cel() now tests
> bitmap_full() directly. That is a no-op cleanup -- the helper was a
> one-line wrapper around the same bitmap_full() call and had no other
> caller -- so carried both tags over rather than dropping them.
> Dave, Gregory, please lmk if you would rather re-review.
> 
> Patch 2 had the most changes from v12, is the patch that most needs eyes.
> 
> Patch 3:
> Minor changes. Dropped Dave's tag.
> 
> Patch 4 is unchanged from v12 and carries its existing tag.
> 
> Patches 5 and 7 did change, but quite trivially, so kept
> the tags. Patch 5 renames cxl_event_validate_mem_policy() to
> cxl_event_fw_owns_mem_logs(). Patch 7 picks up a
> loop-local index, a reworded error message and a comment on enum
> cxl_partition_mode.
> 
> Patch 8 (partition layout Documentation) is new in v13: no tags.
> 
> Patch organization
> ==================
>  1-3: enumerate DCD command support, read the DC configuration, and pick
>       up DSMAS data for DC partitions.
>  4-6: split event msgnum configuration from irq setup, factor out the
>       interrupt policy check, then configure the DCD event interrupt.
>    7: preparatory refactor -- enforce partition order while collapsing
>       the ram/pmem specific partition helpers into one.
>    8: document the DPA partition layout the previous patches enforce,
>       and where Linux is stricter than the specification.
> 
> Testing
> =======
> This series leaves mds->dcd_supported false on purpose, so cxl_configure_dcd(),
> cxl_dev_dc_identify() and cxl_dc_check() are unreachable at
> runtime as posted. The tests below are done with the rest of the series on top,
> otherwise testing would not yield any meaningful results.
> 
> HW:
> Tested add/release of a single extent to ensure interrupts are configured
> and working and DSMAS attributes are read correctly.
> 
> Additional testing is done on QEMU to catch cases that would not occur
> on the hardware because of configuration differences. Four topologies
> are used, one guest boot each, with a DCD partition after static capacity.
> 
> 1. Eight DC partitions, only the first validated
> ------------------------------------------------
> 2G ram + 512M pmem static, so static capacity ends at 0xa0000000, and
> eight 512M DC partitions above it.  Five partition records fit in one
> reply on the 256 byte mailbox, so the read continues from partition 5
> in a second command.
> 
>   cxl_pci 0000:0d:00.0: Read 5/8 DC partitions
>   cxl_pci 0000:0d:00.0: DC partition 0 start 0xa0000000 size 0x20000000 blk_size: 0x200000
>   cxl_pci 0000:0d:00.0: Read 3/8 DC partitions
>   cxl_pci 0000:0d:00.0: Adding dynamic ram partition 1; 0xa0000000 size 0x20000000
>   cxl_pci 0000:0d:00.0: DPA(ram): [mem 0x00000000-0x7fffffff flags 0x200]
>   cxl_pci 0000:0d:00.0: DPA(pmem): [mem 0x80000000-0x9fffffff flags 0x200]
>   cxl_pci 0000:0d:00.0: DPA(dynamic_ram_1): [mem 0xa0000000-0xbfffffff flags 0x200]
> 
> All eight partitions are read, but only one "DC partition" line appears:
> partition 0 is the only one validated.
> 
> 2. Volatile-only static capacity
> ---------------------------------
> 2G ram, no pmem, one 512M DC partition. cxl_configure_dcd() compares
> the DC base against the end of total static capacity, not the end of
> pmem; a device with no persistent capacity is what tells those two
> apart.
> 
>   cxl_pci 0000:0d:00.0: Read 1/1 DC partitions
>   cxl_pci 0000:0d:00.0: DC partition 0 start 0x80000000 size 0x20000000 blk_size: 0x200000
>   cxl_pci 0000:0d:00.0: Adding dynamic ram partition 1; 0x80000000 size 0x20000000
>   cxl_pci 0000:0d:00.0: DPA(ram): [mem 0x00000000-0x7fffffff flags 0x200]
>   cxl_pci 0000:0d:00.0: DPA(dynamic_ram_1): [mem 0x80000000-0x9fffffff flags 0x200]
> 
> The DC partition lands at 0x80000000, directly after ram, and no
> static-capacity complaint is logged.
> 
> 3. No static capacity at all
> -----------------------------
> No ram, no pmem, one 512M DC partition based at DPA 0.  This is the
> boundary of the contiguity rule: with no static capacity the end of
> static capacity is DPA 0, so a DC base of 0 meets it exactly and
> neither the overlap error nor the gap warning may fire.
> 
>   cxl_pci 0000:0d:00.0: Read 1/1 DC partitions
>   cxl_pci 0000:0d:00.0: DC partition 0 start 0x0 size 0x20000000 blk_size: 0x200000
>   cxl_pci 0000:0d:00.0: Adding dynamic ram partition 1; 0x0 size 0x20000000
>   cxl_pci 0000:0d:00.0: DPA(dynamic_ram_1): [mem 0x00000000-0x1fffffff flags 0x200]
> 
> 4. Per-field validation
> -----------------------
> Each row is one malformed field on partition 0, everything else left
> valid.  The message names the field that is wrong.
> 
>   block size 0x100000040   DC partition 0 invalid block size 0x100000040
>   block size 0x30          DC partition 0 invalid block size 0x30
>   decode length 0          DC partition 0 zero decode length
>   base 0xa0001000          DC partition 0 base 0xa0001000 not aligned to 256M
>   DSMAD handle 0x100       DSMAD handle 0x100 exceeds the 8 bit CDAT DSMAD handle
>   0 partitions available   Device reported 0 available DC partitions, expected 1 to 8
>   9 partitions available   Device reported 9 available DC partitions, expected 1 to 8
> 
> The first row is the 32 bit truncation Sashiko reported: 0x100000040 is
> not a power of 2, but its low 32 bits are, so is_power_of_2() accepted
> it on a 32 bit build.  All seven cases disable DCD and leave the memdev
> attached with its static capacity.
> 
> DC partition 0 placed against static capacity, which cxl_configure_dcd()
> checks separately, gives one message for the overlap and one for the
> gap:
> 
>   cxl_pci 0000:0d:00.0: DC partition 0 base 0x90000000 overlaps static capacity ending at 0xa0000000
>   cxl_pci 0000:0d:00.0: DC partition 0 base 0xb0000000 leaves a gap from static capacity ending at 0xa0000000
> 
> Also used ndctl-test-runner to run cxl_test for regressions.
> 
> Anisa Su (1):
>   Documentation/cxl: Document DPA partition layout and ordering rules
> 
> Ira Weiny (7):
>   cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
>   cxl/mem: Read dynamic capacity configuration from the device
>   cxl/cdat: Gather DSMAS data for DCD partitions
>   cxl/events: Split event msgnum configuration from irq setup
>   cxl/pci: Factor out interrupt policy check
>   cxl/mem: Configure dynamic capacity interrupts
>   cxl/core: Enforce partition order/simplify partition calls
> 
>  .../driver-api/cxl/linux/cxl-driver.rst       |  38 +++
>  drivers/cxl/core/cdat.c                       |  32 +-
>  drivers/cxl/core/hdm.c                        |  13 +
>  drivers/cxl/core/mbox.c                       | 283 ++++++++++++++++++
>  drivers/cxl/core/memdev.c                     |  84 ++++--
>  drivers/cxl/cxl.h                             |   4 +-
>  drivers/cxl/cxlmem.h                          |  88 +++++-
>  drivers/cxl/mem.c                             |   2 +-
>  drivers/cxl/pci.c                             | 159 ++++++++--
>  include/cxl/cxl.h                             |  27 +-
>  10 files changed, 653 insertions(+), 77 deletions(-)
> 
> -- 
> 2.43.0
> 
