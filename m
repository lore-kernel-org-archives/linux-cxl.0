Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF11C1CD215
	for <linux-cxl@vger.kernel.org>; Tue,  3 Jun 2025 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748976812; cv=fail; b=GYDUqpoE6k7pT5QYD9C6UGclR+zMQPoJIsQhefuFr0gTLydFJCr73C6RxijBsWBHGjRDK3Iulo2Rm3y4ql+XnryE9qaWk8yln8mhD6uOCITgpEjSind10vr5fBSURwn+amcgi8tlRn5nau9S6utK238sGG2X4RgEH30F6qXmEmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748976812; c=relaxed/simple;
	bh=u0nq/2aGjYnYixc0JVJn9Ktka6424xdjyTYLTRBlKq8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e8kYYDbTvhDS736L2D2C5ZI2N3AaoFyX+kvayAVYN8xnfqWDIDqCGgYl01Kw1aNrBBf4bXNcRXOn949j76tscfNtPdmjXTyBZzxiAdJ0yw/SktYzGDAuNKsMUd0rlN2haZOzDe+Fqj0M48wblmSackZgNPySp++bkvKe4QDsU6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjALClps; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjALClps"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748976810; x=1780512810;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=u0nq/2aGjYnYixc0JVJn9Ktka6424xdjyTYLTRBlKq8=;
  b=LjALClpsY7i7F/l7dG7kWT7V96zgbf8HcFXVTaSh+yLbyZBk8JR+mpae
   St5zsh7jBrw8cEh5Irgh2y/O3uxQKjdBt/O5ySssX9+sibmSEz9rlXYWm
   BCBo2wghvYdqUhEjweUvkTZ+USIJpBHz2gVZPQ++cwq+ZIn3niq/LrldU
   0GrY/s+kMHD/KlrMzv+XEEiMte0LGgR65pVhQtM7/ylXnp8mMLcEHn8Vv
   R9BW1fqiKeJ5wuGeqrZExyhfXgkQZgH6hplXGK3cyVYOmRimL41ORHF5L
   Akrc8b8GnGxKc0Pfv1P8qscnmdI/Sr0u9tyOZDNJWYGJNarO2QvkeTosI
   Q==;
X-CSE-ConnectionGUID: y+fHvDk+TAC4Tzvq5hShuQ==
X-CSE-MsgGUID: 1GojJyf3TuKpchm/E6sQyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="50893035"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="50893035"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 11:53:30 -0700
X-CSE-ConnectionGUID: 8uVgs2DiQSyBQKZG/lZyPA==
X-CSE-MsgGUID: 7NwXvKRmQuynfnjMFeF0pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="175815532"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 11:53:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 11:53:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 11:53:29 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.77)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 11:53:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vigQBSpepWsH4B5FHJa4cDaRHKywXMfG4gmZivElNC+du/zak9ZGxIL6XuTzYd8qy/Xb5dUuH5xvePnud86dUuqkPwLMIiiA/i3iYLluSbbBK7N3KtYihTVacnEKMTHxFGTq0P7ePc/nnLNrUXoJ32FWnTgag1LzwTgPtLvvGzSISiEv9hfgjDt2LZzsU6aMS7KlGuj3m5WI3XbKrE7DjVmxcnzOQu3ungs7hwOCW3T0dJXbpjVvQ/1dy88Fzn0Ng5Lk0NJpvRusgp1dsBhPtDzkZkHb6E5vFVzU1FuXM28pAKaFt3zRXaZBfPvJJJZSethX1mod3Y3qMu3to0a7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0fRekXChCItriwTnhzOBjGj4yDaw8iTUMN7g92aXkY=;
 b=qtuuaKU7aF8Lp/RfTcG4nEuijDT4AxZgnPSh9K/5C4vL2tcJY6KLEVv2nrbCKS95AEzB5yQu3PdEjKj8nFM0E/VvTlYOGsOMpjkFKaM/JBt4bx1yZBZRPoCA3CzxefVjYes+0z3Ga0OlpQ16+vSJnTJxIMSkxsOWdN3tJiuMTl9ZPN2kfO2MnAw44hqlIYbW9Y8mqMSc9xgoq0tF9IazSg9xMjjFFqT+QAX7sq+DaBFtMLXEeB0MrIMpQ2eKp+gzUOkUV1IbH67E83fSlBTzlS4w2Nm1JcWEfUeFAmMk7+928VFLhyOX4k8dw2RG3/X46RzUOkqJhSMTKSsjNip6Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Tue, 3 Jun
 2025 18:52:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8769.031; Tue, 3 Jun 2025
 18:52:57 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <dave.jiang@intel.com>, <fabio.m.de.francesco@linux.intel.com>,
	<Jonathan.Cameron@huawei.com>, <rrichter@amd.com>
Subject: [PATCH] Documentation/driver-api/cxl: Introduce conventions.rst
Date: Tue, 3 Jun 2025 11:52:54 -0700
Message-ID: <20250603185254.3730099-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:180::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4820:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df16419-29b8-4d1e-e0bd-08dda2cfdad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hGfHyNqjRHvQPM8ofpvSQmUJAKQoVVy63Ojifpow0dddIgFUsqHj3T4Qs14D?=
 =?us-ascii?Q?+Vp+zYfD9AQJlPB9umufQMFFIczf5zzPzlGPo6KOfw1aWnabflNd8hYX9u5X?=
 =?us-ascii?Q?3Xkq0XUClgyaqmUJ+LY1JkjnfoNM+kEUINUmdtvOYtbNSfs93c5a4/dMGRhV?=
 =?us-ascii?Q?Wi2GWrLXhyAfWoBGTF1AjiNzyV42u6cGQkTvhhCApj+k1n4DIGGcWRLzujPh?=
 =?us-ascii?Q?LlblH0fKmUa4RncZAgiUUtW9aqGCYawUx7/Vfi9cm6GEWLuAlcKK1QrMstwj?=
 =?us-ascii?Q?qrkfTwnRzEdcDzvNfwXAId/+tMmMFgOMqpW5TOW4fF1Uotf+A/Kfs+pDx8OC?=
 =?us-ascii?Q?3i12+/dG0SgH8qjy2o2R08oNJ7qPnNQdnZcPuZM8hRjzYNQ3N6wVjimzOYI+?=
 =?us-ascii?Q?y4EyKneBqYNMYmDdCqKiZngZyXQo8dTB0lbdPIhOAAABibAjx026+KjM9ltC?=
 =?us-ascii?Q?tArzawLsRK0aysf6ZJrFev2rvJNwwU1713rCr/n0CQftZCK/upSk3g4e3xt9?=
 =?us-ascii?Q?/UEMDIlU/XK8TbB+zVX6cpjNWMHzpCO9l1rNOek+44jSsZ73Ri6t427qvrvG?=
 =?us-ascii?Q?J/np7dy3gkc17W/7ymQfsPgTdop1/fNe8Bq1j1LFIi7ldFPLYlyL0nZdotZw?=
 =?us-ascii?Q?Tv83svMM6uffOhFcZhEkFkI3T8Lx1SsbSVJbHDa0+uSO0dClZQFPy5FsIdaq?=
 =?us-ascii?Q?Kjn7cFnP71vDb+axGKtclygMsHW7eT2z1+7otfuYBGlgBws/iF7kTX3nhKFM?=
 =?us-ascii?Q?UjAkeGXMK6zgFNvTOTawt7YsdR0ZZb6XeWAByd4ypkvDlJaA45qzfhsGwyJD?=
 =?us-ascii?Q?E90zfV7cmMnkkCmcnyQDlkEjvLoVIruW8kUVziJYmeY3q5z3N9o1XUiW1p28?=
 =?us-ascii?Q?AiJvkl/pFmQ02LJhQ0rPopZieK64qnBe+xpFbPLxeOPbONQCffzBtNcbO2Jr?=
 =?us-ascii?Q?JAeNwPyQm+DEHNalu/XoTbiDgD5Wrn6eMgXcR+EJvu7VUURv5KyIT9n3IL/7?=
 =?us-ascii?Q?ohPEJ6zcp8mamky3s6k+3zz+ITmuC56U+wJqQjisKYpFO2+uWQ5kKO0Xx4O8?=
 =?us-ascii?Q?UUW9JaYe/UuE+9+Pypnx+bG+jzQLpKnQrKFebVSD5fNN4S7sRL/xDrm2SbW8?=
 =?us-ascii?Q?3VvYAzCjURsA/E2m7roiyC4vQXuBh2modg94iWQJeqnlEgCqM+9XJL6QV3HU?=
 =?us-ascii?Q?28I9lIO8aNmhSeYo6jdiS5U7U31gBETWcmSj+QPOXW8w9xy1noQQE0auj8BV?=
 =?us-ascii?Q?95JQgr9TRtJlrgmKQmKtHyv04Fl5319UUgEWv+h+cL/AAeRONObZ3oQ13c3N?=
 =?us-ascii?Q?XtH2FdabbJv0PeJqwqPAUaQLhzvo7Sha0nXk9oguRmz9E6LAdK2xd9vbBYok?=
 =?us-ascii?Q?32ycQNObq2BEEkLaY5QrpYn+b4O9MD7xac6tppHxDsGhnYDjuk776VNoi/S7?=
 =?us-ascii?Q?Kr40NLOOGVk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ub7RrrUC1j2Qic9zX4LIxpyvAdULfPlD2UyrV50rKGH/OLeuv7CqdetsjsOj?=
 =?us-ascii?Q?fKamr9DWAG3/CH8ed/bsgiz8++2pxUvbebSc/YXt/llfjt1aXDwdgTEhMXC0?=
 =?us-ascii?Q?2n+Pl9ge1OLFjnigFW0etiZubn3u0ZR2hQb0kBS3E2JUE843ojubXJF0V7RJ?=
 =?us-ascii?Q?xRplFcLcvDluXNfbV6U3rIq1H2Q+xEgIb7lKtbwzi2kZfq43mgzh3ZrTd1xG?=
 =?us-ascii?Q?9RNq7I14cNjW1y8qH5RyWD9wuKiv1u+3quaJE/Uvs3lXtksLPi8kOzSDZy+l?=
 =?us-ascii?Q?Tr0W/N2wEXEHa4HUk9ACnNLJimhwcs/yD0G6bWOwnRe521CNIXniKix1OKfV?=
 =?us-ascii?Q?LgENt8HGJniy98v6bpTRSzU6EiP5QB4FI5adCYklZwhFMZUzKdIougxuB5uD?=
 =?us-ascii?Q?8+sNn7Df9vo+7ca4YoOUx/VKJlJeNHHeAGJttuqw1s7Avj6mXmBjAPTPymMh?=
 =?us-ascii?Q?zrQvtTpBvP0D+MfDgnJGrAWXkfY+Qu1EJ3tgxmSFfYOsH5TFQ9a2LveZpWiy?=
 =?us-ascii?Q?L0sAPABHAI5qo5Ynq9XOIGstbDgXy06MImV7mAVwAGWq7PrA6zDU19zN8uO/?=
 =?us-ascii?Q?KcUJmDnvL2OXt3CYrDiHE3hU4bb1VYcFq6HHyzQ1mN5dKZqYr1gmyyS6CheI?=
 =?us-ascii?Q?H1/NIzn9pvjER2NidltiWcauN3YbqyocjsSyaB/jwl65XTDsML7jYjCrdDO1?=
 =?us-ascii?Q?WCJdePrr5DsM55xlUe80fBrzGlajeGNUOjGFMF4IRA0XmaKHqIU2g8Ags8wi?=
 =?us-ascii?Q?g9nLXaEX2Uu+jTVkZM2fiTYJVuCZ6VHtbsl1JyBY2iy0G50rlser8RpanJNB?=
 =?us-ascii?Q?laSsPT4a6xqBkd7VVb8KHJVCKPRE56+6XYGsww1qAwOQOY56Po79lj5eWBg0?=
 =?us-ascii?Q?lhrrsMZ1gZIM+3ArbgIyYxVLM7zGuKe4QOTwGT7GMUMhPKhXihRCXOU8ig/f?=
 =?us-ascii?Q?Krm1hk4AxEGiLGizqtFZFbL7x8Gule0LOcmff6L7ep1eyDF0ROmWs7mO6mX1?=
 =?us-ascii?Q?nhwv4lidMosrjNBIbTrUNXB82vbock9Omzx+mlPCkuuOuY8GDod8Hq89upVP?=
 =?us-ascii?Q?rnJFnVc3T8bb7sgIuT8sdD9D41NLIyuLW8kn0NkgxBkwKVkTQjqWI6dcLrOv?=
 =?us-ascii?Q?vV3chdCCvl9pqg88zvC3aWLIQ1yzWXEZ9LcNpfRSJY8l1g3ZksdSOdtGaVdJ?=
 =?us-ascii?Q?tsTFPQSl2VKppjmAgjwq7+z+TUQwDA1K2tkFT+R9hyk0ZgD0moBgt1vN7phe?=
 =?us-ascii?Q?eJfHWfoYs5AgAyynMCVIFWM3eKK26kSb7pqcIpKYJ3UmqpTZeHXtibICHw4I?=
 =?us-ascii?Q?3a0nIRQLEuEdBS1zOT4bqT4BrB9TJghq/1h7HN/XzT19JKGV+0/5aA7Nxj/+?=
 =?us-ascii?Q?dMjN94F/2HxN9x102+qng+6cYaFje7BCpqvj2m+eboxI78vT85V36BSb9xLi?=
 =?us-ascii?Q?OG+U1m8Cj8squFjkjMXiG6n5aj8X+w0F0U1DI/58Xf9oI/pTvC/Q7RqUzZSi?=
 =?us-ascii?Q?KUjLx/1MzfBvMNanTYtL+iZguQCEdDOD+qwO6ujpD94x0e00h3jm1HK1087i?=
 =?us-ascii?Q?9CcYaqs+WJCppC4n5WuBYQoCZu7opSoUGuIJOys+BiMqTUb/65uplpOO+oj3?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df16419-29b8-4d1e-e0bd-08dda2cfdad6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 18:52:57.1857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZL1KXZZ+iyr3OISH+Bd2DS6j1HYLp5JpRD1Igc0JK8oAMRBiiOpxrjWvCCQi96of2s+NYhK9U8QIScj3XH84IFxdmN+++81mEEPdprnWqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4820
X-OriginatorOrg: intel.com

There exists shipping platforms that bend, break, or otherwise lean on
ambiguities in the CXL specification. Without driver changes to accommodate
these deviations, end users are left without CXL subsystem RAS features.
Specifically, provisioning, error translation, and other flows require the
CXL subsystem to understand the platforms CXL topology beyond undecorated
memory address ranges.

Those isolated compatibility problems risk growing into deeper upstream
maintenance burden if different platform vendors arrive at diverging
solutions. For example, there are multiple options for resolving
low-memory-mmio intersecting large-interleave-ways CXL windows. Linux
should only entertain one solution to that problem.

Now, with the ACPI Specification Working Group, situations like this would
be resolved with the "Code First ECN" process to codify Linux expectations
in a specification. In the absence of such a process for the CXL
specification, create a file in Linux documentation to detail the
motivations, assumptions, tradeoffs, and proposals for amending
specification language.

The goal is to capture the issues such that platform vendors arrive at
compatible solutions for these problems and serve as a repository for
potential specification updates. The expectation is to update
conventions.rst along with CXL subsystem code changes to accommodate the
platform topology.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/driver-api/cxl/conventions.rst | 48 ++++++++++++++++++++
 Documentation/driver-api/cxl/index.rst       |  2 +
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/conventions.rst

diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
new file mode 100644
index 000000000000..662dbaf1f045
--- /dev/null
+++ b/Documentation/driver-api/cxl/conventions.rst
@@ -0,0 +1,48 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+=======================================
+Compute Express Link: Linux Conventions
+=======================================
+
+There exists shipping platforms that bend or break CXL specification
+expectations. Record the details and the rationale for those deviations.
+Borrow the ACPI Code First template format to capture the assumptions
+and tradeoffs such that multiple platform implementations can follow the
+same convention.
+
+<(template) Title>
+==================
+
+Document
+--------
+CXL Revision <rev>, Version <ver>
+
+License
+-------
+SPDX-License Identifier: CC-BY-4.0
+
+Creator/Contributors
+--------------------
+
+Summary of the Change
+---------------------
+
+<Detail the conflict with the specification and where available the
+assumptions and tradeoffs taken by the hardware platform.>
+
+
+Benefits of the Change
+----------------------
+
+<Detail what happens if platforms and Linux do not adopt this
+convention.>
+
+References
+----------
+
+Detailed Description of the Change
+----------------------------------
+
+<Propose spec language that corrects the conflict.>
+
diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 965ba90e8fb7..721a2dacf8fc 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -12,4 +12,6 @@ Compute Express Link
 
    maturity-map
 
+   conventions
+
 .. only::  subproject and html

base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21
-- 
2.49.0

