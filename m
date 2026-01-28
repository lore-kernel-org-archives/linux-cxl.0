Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736EC34164B;
	Wed, 28 Jan 2026 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638424; cv=fail; b=G0hKY/JaHt+eHUQstqdDaJSS18suGMobV+We3uJaqkXNPdSGe9O24bIfasTTxogl1mIlZWbBR7DPBfxQxTj/2/OwJVA+YxCuVoE//oaE9l6lk8FQQxl2lgi73K0F4WmopECHSN8oH4cy4pJV/6zCn7jk5/dQZmsoUMtff18bmKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638424; c=relaxed/simple;
	bh=V0zBY8YlhN6Rwzl62LJkgGwGSQUoT8wX0tIyW6LpdtY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pdAP7EQlhNL6fsXyZeWt2UNLr1O4f0heE1w9IPIqpS4JqhZLzejPKI5CrmBTOsIO+A+MMHyq/5zixKLoriat9GJCKf4U4foHzjR1NTPFFfx1QZF16oo7O7ikiD+I1gZIs6m5KnMXdZM07yyPp7MqnX/YpE9j+OPoXL4O3JfmLf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8DwA4tQ; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8DwA4tQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769638424; x=1801174424;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=V0zBY8YlhN6Rwzl62LJkgGwGSQUoT8wX0tIyW6LpdtY=;
  b=N8DwA4tQqfsKzhPPwP2QxPqU2xuP1ynmW0ViP1lOi1sz9UDuHsgnFcdw
   2Mw8l0RJ2dLHcxDCyXwPjbhbMDGtj+bPzhJ128JXQzPp3J+3RrwrIpHS/
   K9gzqUf8KUCQWWZy/EhG0GTaoXSIElDPT6tOpceiBKJ9tpGD/xsryj3Bt
   pGL18uLGwQsfUZ2q+Tg5EcbQJ3h2LAh9yHuDb6FakdZWrKxgstTm5Q8/G
   AtRuhXWTUr3iXB7DKKDbFvst2hYl1PTgT8KZuGMlvmX4v430TW2ONwppv
   4ET08yTRYQLOpS6EclhRW+Kz5gZ7PmeNRQhfQsU7ELh6JKA8epndR57Mu
   g==;
X-CSE-ConnectionGUID: Q5a57m/KQvCGQk1elU05Zw==
X-CSE-MsgGUID: 5VljHMBcSPCQhLOeWn1m3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70839061"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70839061"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 14:13:43 -0800
X-CSE-ConnectionGUID: utYtBs7mSDapIP2b4ttD5g==
X-CSE-MsgGUID: oxBj8b+tTC6WqN+pfuBDeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208479046"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 14:13:43 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 14:13:42 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 14:13:42 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 14:13:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gt/2CTAuIqRojS0PQXPx4EwNgh+IrueJfzpO+kfirNscj9U13J4g6MjwoAJjUBPMrBDhNEfPzl2Eop3Yj0fx4cNyesTyso9a59rsb19V5tDiCZs3A0KrimVSlAGsV/AbhzneN1RL5N89K6ZKCxTwlPUzwkLEBbllKYu5LyjWhdWBLKzYGr2/7FRo+w9WWtiz9amrfxH7NG+lOs/pSnhqvj64ThqpttKpq+pWEMvyv8CZ9ax97i7s/AtvJzhrJlm9frdOi3qL+z+SNe5+0JIHnYjbrNmiBuU1K2gtDkm29mVJBZc+7gW/ad6BYy9RDl9c9kOhK6O/qQjKIFz6rCrpOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBMto82wsnrZim/6wkIlnKQ+O2p9O5wbyYcLP5DOsJA=;
 b=N1/kASQTbFp8g9staFdhRNmnFUOGBUyDINSV3+GogvhKBQ5w96/mbDi4/FSxkZQeL5a2090glWnky5Dmy59rK3QUK6znJcv2EfdJkd0fEvoVMs0eGVK2ARJRw3Ang3Poao3Mu6hZkVf8Bye4cmOdOyaU6lCUOELjDRBf1k8pI9Fbl6DH8KrUEYcypwGDrmB5fLarmx0DPAHAExVzUgVqNxvTvWjF1T8Wy19IPOC8ZCcmuIJtc2n+t4t6C1xXDY2QlVv3WF9IAvEqGZRMv8IeB2+BepmMEM9QeCvxn6WnviUMDawY5SFj/P2faF+KoyiUTcUKVhBYKvhKGl4f5X79/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH8PR11MB6731.namprd11.prod.outlook.com (2603:10b6:510:1c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 22:13:40 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 22:13:40 +0000
Date: Wed, 28 Jan 2026 14:13:31 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Yuxiong Wang <yuxiong.wang@linux.alibaba.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <ming.li@zohomail.com>, <rrichter@amd.com>,
	<ying.huang@linux.alibaba.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] cxl: Fix premature commit_end increment on decoder
 commit failure
Message-ID: <aXqKC-bscufh1ggq@aschofie-mobl2.lan>
References: <20260127084855.66916-1-yuxiong.wang@linux.alibaba.com>
 <aXkq2DvEOeYQSVuN@aschofie-mobl2.lan>
 <aXmz_pH92dL1TqJ-@U-Q2G32XWJ-0138.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aXmz_pH92dL1TqJ-@U-Q2G32XWJ-0138.local>
X-ClientProxiedBy: BYAPR08CA0064.namprd08.prod.outlook.com
 (2603:10b6:a03:117::41) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH8PR11MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 41031411-b63a-4b57-66fd-08de5eba7dde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4ldrm58Tn4xbutEP7HLXD3HMgcnbcERnS5kqenmvIgrbr5MtDD5aVMmHU2V4?=
 =?us-ascii?Q?F5cDRNINBQJaOvuo4twSJ+OSiqGbuJBR4svVhVGvlyrbJ2fjccgOxvOm9b4z?=
 =?us-ascii?Q?kw+7KtA/u8bPf/UwsH4Yq2TBU7ffl++TWcgJs/6ghm0r6K7zhYnBIXrwSRUm?=
 =?us-ascii?Q?QrE6nxMhBnbWqGt0q387n6x/7g3e1BpawyrPwOo5fhTMB+zse8wRTgX43N6H?=
 =?us-ascii?Q?fI3/SSnpx8B4w/RESGovYAMuYstvr/4B7GGI/LAD7I26IMxiLltZs1+b2VaV?=
 =?us-ascii?Q?adGH+mm1OmiYO9CxEboa2wWj4TtLPD4v5Oo1o4UkTo9wNsskZa6P9Othgg2/?=
 =?us-ascii?Q?Xaq1iHIutmy1uwhgi62o42Sa+Pc3PNBXG6zudg3n1aIkXaDXOyPMiK7Eyc2J?=
 =?us-ascii?Q?C6E3QLHNWlWs320T7cr66Siec+PlcJnRxXG7FMRCKVL+Z9/+RgUiytUvc2eY?=
 =?us-ascii?Q?nDeVxY2ON0Bh4WMKXmZeK6yrftZ/PIrKisghp/V7iH2IvvQD0Jex/2yk2KHo?=
 =?us-ascii?Q?SylrQwNVbabPHybzK8SCn/QaoqTLUeW0PeJ2igi4NEuGiEf2kixK4EEFSwwN?=
 =?us-ascii?Q?q0N7YYLYCm1neg6hWBSFcWaxCvoH+ROJ43VLBFaU/byw39/S+jZfjpbS+6dn?=
 =?us-ascii?Q?/5kSu6xnaenGS9Ld1anqqHqBxsidUB8v9y+ZiY9R1hKSOX4EM6klHgciygoj?=
 =?us-ascii?Q?3NyAV9n1YwhiQUxiNDb0YTFvjVDEEVp6HqWB0I736xe5H6emX1omsqp98paO?=
 =?us-ascii?Q?zvqJDxV9DEwTymk2GU6F13GwzysPaVso/H1GxqQ8tC0sutw25Rx75HMulwAA?=
 =?us-ascii?Q?8DZbYhPIJgE1sZc3DE22fR4PerI+bSCit/wDh5GSyVWAK/w0vjRnAo2igNjD?=
 =?us-ascii?Q?fv8psJsyXWqzPa6wy0I49dadW/i8tPrxIlpNiblrgI08d5O49u5UEbo0AgOR?=
 =?us-ascii?Q?OBGFP7gQcT5sH4sBGOaZsW6gSacBMBSvjwr/0Ep2LdbvXVAdAzymWyZLAWV2?=
 =?us-ascii?Q?I+bP0xoDBSWl3X1z7y3UH++3uF+pqnzXasH3iM/lqirxXMDuIJwqYYQLBENh?=
 =?us-ascii?Q?0ZUOdSG6p8QUID06D1Bih7KihxLf4/taZz4sVau6gXSyorwtKwBK+u5GkKni?=
 =?us-ascii?Q?z4wpoS4pK3Soh121LdDan/yg0uc7TgvLASi2DAIn7Pzp/EhqRxjbbeK3IzjL?=
 =?us-ascii?Q?IXzYXHb+/dSRbhmVcByZMYhIPQeqUNDJySKfmEPRBsWfNAH3nBUN/yW+JEm1?=
 =?us-ascii?Q?NMQ66rGWif45Vr2ST51ActGw9Hmc6G9P0DOYDrWc+DC/Sy5OBo/v3QEKuHq6?=
 =?us-ascii?Q?KWOnHKJVXAf9/TSzdTuYQNJj7wM64q2dS5ZqT0jT6r1pL6dgfmK+t6DZoK1l?=
 =?us-ascii?Q?STQWv2rL4PCnedI9xLF0xrmg5pZB8W3zxpjKrcXc11YRhqgrZZZ7od7Zy2iy?=
 =?us-ascii?Q?UGosMCu2YV2/lKlq7628axiRd8rOpraOr6y5TaJt1wspK+0UcVPkoj7Ejumn?=
 =?us-ascii?Q?eHX1Ti517V8xb8mJr8ZzPVFRyn7yB4B3OxLyrra9kPicVe7//Jj9eMNgqz9p?=
 =?us-ascii?Q?/06vGisDq63x3i/wkzU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OzXJpz1j+u7x25BrCzvESlElnTcOBXTmhmwwIkVNf2WZr0u18Y2NZRM8HQNz?=
 =?us-ascii?Q?jl1QuQD4dIboGxGJx7uLxc21mWah1mULRBEEznVpqo7CA7I+1Cr192T1n6Yf?=
 =?us-ascii?Q?2DKSpNBAGP7vXqZBRwxw6tuEGart+kRoe8BEhXIvQZCyVCBJZIbhMR6BXGKq?=
 =?us-ascii?Q?XFZE9rJncKpr3ZgOlJCh8ZZDnGu2Sr9p9Nhte9T8aMI/S3qiu/rZq/g6mq5L?=
 =?us-ascii?Q?eU9rcaMCkTmzbPadfBQADrEMBnCYD8WEFsTyxx00ulebN/7TQJFbm29SbYnP?=
 =?us-ascii?Q?jZPRSu2qwNUZDNajmYsABoNhhrbNGuI5U2vZkTFnMLZuRB5Wpgly4RL1THqY?=
 =?us-ascii?Q?EtzpWZTLR/D/Qr1dku0+1FiZt0pjkSQszrQ6YcM+/IwNiVgGwemEYXyhOa8Q?=
 =?us-ascii?Q?7QsGCrI7LWp2Ibt/j8JIf51/oDvw8YoiqpUC9dVr9mRXtlj9UG7jhdQPohdd?=
 =?us-ascii?Q?q+Yve6LLhKVV9yUt6QhSihHLImCGIFSQI73UqkBFVIxrPsMZ26GtHwJPyDi+?=
 =?us-ascii?Q?UBUx24EliKDEY3E1OAX6oBerq57EDkJoKgM+A089FzI1Q1vDWiZmgMtK5mEL?=
 =?us-ascii?Q?XEbpH+/FZnBZSgNZsmXijJaAS28ccsSpN7QSsJU/uv9mxrMw3Ff9XjOHFKbk?=
 =?us-ascii?Q?EMaiLJ+fW2HMXMrVbK8GCwXPFJIgvieodWFLpNkh6sOjA4dJT+Nzg13/l1Zr?=
 =?us-ascii?Q?ED3xpWqIyV/jkkGjoHeytGdva+38S4kUJ5ASGhaGwVhRvMsBHoWZDUZmUojm?=
 =?us-ascii?Q?JOEYdF48k6+uBuCB9UTotfth4Tz2VBxANTnqvz7Y1NSZ88R4a/c1ZlJM9lSX?=
 =?us-ascii?Q?r+9mW6PSY0e89SlBLOCQGSfIKAD6tfbho24G/uYbV2j9iKTvF8trtqd7BnYb?=
 =?us-ascii?Q?OBEOrQY8ZUnipUWkKyWNj889DRQjOywdK6cXxSVTx83FzFsRrvmAklU00W9K?=
 =?us-ascii?Q?y/vLvamX7x0SM5Ago7wLh9LAz+Wy1XCjDzQGLD+9TVqloz2mQ9LBwtGss6LW?=
 =?us-ascii?Q?jR39hDhQoSvRL91bEU4IiyOaBrogh7a6X+e9MEb47JkbRJFD2IJoRyQttYhC?=
 =?us-ascii?Q?Js4o4IfN6BJR7KRl89aBqjc93ObRnnIH2+a9kJk2OcIPBjeYvu0Rdv7aBWEe?=
 =?us-ascii?Q?5qvWlsO4unSWHUirdK0ip6TMMuR2GZ252zVnuMVy1ifoAxx8i1yrlqDjXNfx?=
 =?us-ascii?Q?wxk0x8FsHHb76Q3gICjWZlOhjEoWiZmTc5Z3Ja7GmWn3GOCbjxVSsm9TzIP0?=
 =?us-ascii?Q?Ka+hZwjaRBGTclpTYk7RhJF2rSsLBt14g8LWWObYlL55KYHXdUBhKQkLRXmM?=
 =?us-ascii?Q?7RQjUuZ4aqaBPbntiWRiuR9H/6x7SUMEw9cMwbuc5DvkFKQLujGOzi7ayXwK?=
 =?us-ascii?Q?+pmvlcCqkUiatWT6tLmVx/8TPHueOKEYe7dITwwGhFIfdqzzwjVAstfd7QIc?=
 =?us-ascii?Q?Xlxwyn6STBkzN2LmqZuBFweEsIwk14L3FAPbKtEk7T3JZs7hpkoUtoBBbdKs?=
 =?us-ascii?Q?OongDmGq66d7JTl7GoMYlnwwaTU3k/ehAnCHYKTc4/k6pQUepD+FvhIER5td?=
 =?us-ascii?Q?4mYyadXRaxYThCV9dLCenB5AQZw8+k5FaHpR1sfSJI4rUzVe6HAr8eqgG9xm?=
 =?us-ascii?Q?dLx3U7RtKsUwvGRcPs5H8uEgRCi4ATibWkW+1/dD+eaFzGvuZZRmeW8NlHhy?=
 =?us-ascii?Q?CNCg0sL0AWkyA5hwa2i729LF/S++5CceFNmim3pjPiPFQPnMhacqtkeiA75H?=
 =?us-ascii?Q?SWmOrE8cRuntlIwQ/RYE485J9fyLo9s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41031411-b63a-4b57-66fd-08de5eba7dde
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 22:13:40.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsBJOgRtpphcTS3IpaAO0tS2APC8g30vQOr0t7eq6zfJIi9GAhcol/Pv70Av8LCw/D2mfDTglfYfE4Eh4oPifBxUQ2qfAq3iramhSJBaOf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6731
X-OriginatorOrg: intel.com

On Wed, Jan 28, 2026 at 03:00:14PM +0800, Yuxiong Wang wrote:
> Resending with corrected CC list - apologies to those who received the
> message twice.
> 
> Thanks for comments!
> 
> On Tue, Jan 27, 2026 at 01:15:04PM -0800, Alison Schofield wrote:
> > On Tue, Jan 27, 2026 at 04:48:55PM +0800, Yuxiong Wang wrote:
> > > In cxl_decoder_commit(), commit_end is incremented before verifying whether the
> > > commit succeeded, and the CXL_DECODER_F_ENABLE bit in cxld->flags is only set
> > > after a successful commit. As a result, if the commit fails, commit_end has been
> > > incremented and cxld->reset() has no effect since the flag is not set, so commit_end
> > > remains incorrectly incremented. The inconsistency between commit_end and
> > > CXL_DECODER_F_ENABLE causes failure during subsequent either commit or reset
> > > operations.
> > > 
> > > Fix this by incrementing commit_end only after confirming the commit succeeded.
> > > Since cxld_await_commit() clears the decoder commit bit on failure, no additional
> > > reset is required. Remove the ineffective cxld->reset() call in this case.
> > 
> > 
> > Why are the writel()'s that cxld->reset() intended to do not really
> > needed? Is only the twiddle of the COMMIT bit needed for a reset or
> > do we need to 0 the size and base offsets we previously wrote?
> 
> In this case, cxld->reset() does not work because CXL_DECODER_F_ENABLE bit
> in cxld->flag is not set. 
> 
> The size and base registers shall have no effects if the commit bit is cleared.
> And except the reset and commit functions, there are no other functions that
> touch these registers after initialization. So I think the key step is to clear
> the commit bit, which has been done in cxld_await_commit(), and the size and
> base will be overwritten in the next commit.
> 
> Considering the potential hardware problems, perhaps it's more a secure
> solution to clear all these offsets. I can add a function like
> 'clear_hw_decoder()' to do this.

Thanks for the explanation. Looking in the spec now ;) I don't see
clearing the offsets as required. 8.2.4.20.12.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> > 
> > How did you find this?  Maybe we can add test case to cxl unit tests.
> 
> I think this is a very rare situation, since the software has done very
> strict checks before commits. We found this when testing the cxl module
> of kernel and firmware. We committed the region in OS, and faked a host
> bridge hdm decoder commit failure in firmware. During the second commit,
> we triggered this problem with 'out of order commit'.

Thanks for sharing that.


> 
> > 
> > Thanks,
> > Alison
> 
> Best Regards,
> Yuxiong
> 
> > 
> > 
> > > 
> > > Fixes: 176baef ("cxl/hdm: Commit decoder state to hardware")
> > > Signed-off-by: Yuxiong Wang <yuxiong.wang@linux.alibaba.com>
> > > Acked-by: Huang Ying <ying.huang@linux.alibaba.com>
> > > ---
> > >  drivers/cxl/core/hdm.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > index eb5a3a7640c6..912f648a6b7a 100644
> > > --- a/drivers/cxl/core/hdm.c
> > > +++ b/drivers/cxl/core/hdm.c
> > > @@ -844,14 +844,13 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
> > >  	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> > >  		setup_hw_decoder(cxld, hdm);
> > >  
> > > -	port->commit_end++;
> > >  	rc = cxld_await_commit(hdm, cxld->id);
> > >  	if (rc) {
> > >  		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
> > >  			dev_name(&cxld->dev), rc);
> > > -		cxld->reset(cxld);
> > >  		return rc;
> > >  	}
> > > +	port->commit_end++;
> > >  	cxld->flags |= CXL_DECODER_F_ENABLE;
> > >  
> > >  	return 0;
> > > -- 
> > > 2.50.1 (Apple Git-155)
> > > 
