Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A292F39B8
	for <linux-cxl@vger.kernel.org>; Wed, 20 May 2026 02:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779245485; cv=fail; b=VdbRAaXu2RtamMrOaFxkRkBFCCDJPjE/iY+0bVkTBhrp+Ka8Y0CvfNyC3deGVt1CwC6G0s9yq/34R0s/teZOokEuyAcMrdrowD2dikqBYid5ROTNfi0FW9EpKUG5/azqo10a1M9ZAK8cXsvFL9dPiToQYDgXxeXCEFsSGhjCyeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779245485; c=relaxed/simple;
	bh=xcaYJuQdL7Cs3vIbnujVJkO/rcZMO5P/1+MSWXz3mgQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N9R97ejRYrfnHYWgm36r+6iHzmVYSoALLOcY9I/ZLbk3HP/Q5/8ooSVu8ov2iN+ggBjxacB6L/8XWatgbKtnhQw3xd9zsUUZ0V6RY+Y8MMXiAQBkX2hcTuhwCOeGg43Y+1MLGsA4nZdIPxwncDKJzFMB+ngteGgWHRej9CDpKlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dr0Mkl7P; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dr0Mkl7P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779245484; x=1810781484;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xcaYJuQdL7Cs3vIbnujVJkO/rcZMO5P/1+MSWXz3mgQ=;
  b=dr0Mkl7PsxstOmak5d2v3qaMCBhyN94EVUMbSQeMjIzFsSYqiAsjxSE6
   rjJVJDptoyEdstCTYoBTayJB1IEja45jme5jwPYDRyOcAESS55UxFamf2
   TF2qBh0t3XxKGxwPfFfH/TOffRm944B+JmLID9dKUOmsxQ3Gn8X7JNra2
   XuYu32l8A5V5MiHpSTyCFHYUOvgVKnrvS1abm4N+Pt3rATCblCNsKTuy0
   oY9sdfS2np65PhL2/k+BaDuq9gG358EHBCVf0U0Mu1j+l0AJPmAfWf4vl
   WzHWr8QuScLqXQI2EwaK7Qv0WDvdcaLtn4TZgK95ywdZcqG7Ok4faPGf9
   A==;
X-CSE-ConnectionGUID: W271wBvOSUOjJj9qV+s7KQ==
X-CSE-MsgGUID: Ez3X6WQrSTCNhDKMqU8YSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80171022"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80171022"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 19:51:24 -0700
X-CSE-ConnectionGUID: tlOpeiNFTd+HojQVFw+rew==
X-CSE-MsgGUID: 9ZyjbMXoRqGPTRf1noVIzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="240254719"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 19:51:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 19:51:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 19:51:22 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.30)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 19:51:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lC50Pa5z+2/JquDJILb7tPzEvbSAO2XlAZKvhU+RhkP2St+90q7F0A7oKk6BXBe+aRs1y2sAh6RK6QLBK/x/4vBkvRf6zcAJQhLTrvds/SUOmZiZR05S4WXwU//UKoWO0QZpYEO5btf9surbQrK42bpyBklaLURyn9yQ1dt3VL6ogGWK0NB/P4MW7Z7ucPMErjMJZrWdjmgxt/jLuTqNQ/UQFhYobQLMmfSuu/L4KYinGbZ6vmu0IvIdlN2xidF1F5WsfeOU+GsxBavhLyY+SKzbZyeU6RmyiIDoHUla3wvGG0VLSPxdtAAea3fIIE28Qod6xrRkEIP5kJwfMO3SUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEj8YFivgKV/iMnjyi+PLUX/lRO/qZ2MKsaY61S4Xkg=;
 b=YS7Y+K88iSMXNXRAK0bmkDB3KYckRt2P+CAAzdsHRRAAJXGOsn40vfNyOvKBdSonpQbgMECfU3Ph8gPYzGZIc2Q8xz5FzUTI5V0gh+6vfmgyW/5U+YYOgW0TGhQXeJJQYUZ8VN9c0Ob0gmqcOS9EN30CQd1eFcNwstcrNHR1cMFXSWJnRZlhxm/+wx/cFFy+1VgoZE/o+QGxAxb5ojf421ElPsOKKrigoWNGd7l77RFWNp2/UtYWSIpqW7ND3/zQCw4ts8pRmra68vaDbG6voYo0vkTSFtFscLTG9Cfpzhyrj4Jb1su9/SQNcX60yTxDvMyK7ybPXp9WAaf9m8JDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY5PR11MB6341.namprd11.prod.outlook.com (2603:10b6:930:3e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 02:51:16 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%8]) with mapi id 15.20.9891.021; Wed, 20 May 2026
 02:51:16 +0000
Date: Tue, 19 May 2026 19:51:13 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <djbw@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>
Subject: Re: [PATCH 1/2] cxl/fwctl: Fix __fortify_panic
Message-ID: <ag0hoc8cL8W-nr3z@aschofie-mobl2.lan>
References: <20260519221204.1517773-1-djbw@kernel.org>
 <20260519221204.1517773-2-djbw@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260519221204.1517773-2-djbw@kernel.org>
X-ClientProxiedBy: BY1P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY5PR11MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 285126cc-a5fd-4523-5195-08deb61aa991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|11063799006|22082099003|56012099003|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: LNC5kWeEo1LXuZng2Q1uxdYszHeFESR3gGtyuqQ1qEkn8yUTKjZAbxN7TzOJ2lfs/pSJT7njJn3qP45EK7uOGb619UNnC+f+A6I8jF3DJ71Z2un27nJsK+MPQPi2llfZwhlYzAeqpCYk36VvAJYBQ718K9kEdlS5rOXAt2/TcJOrF7LSlS9eso5q1hx0WJ/A0ZlaCysBrTIA4E2cz1w48UQHFyidaPpITeCmi/e47Bf7PeWlHSWuYBOLFFjIfZvdYBGndyMthGqB4B/JQs1We9mmoK1/K9EtsJNdpWzIPuYfjCQaVo0k6lIvcqeVNaLghUAKd2MwyL1P7vQlxeMCcMwUs5kt8SP8lDxJTpKITEus1krrFeNZ+ent/h2B69pJVw0XBXUsjTt7/vso9MISaXhv4ia1c8yxCPzbZkVo+CO7ze2lU+BvpSUCJR+rhwiyv5Ud3rump7GGX4PgIJHj+IrYmBPsMwlqiNnoHIlhETukoLoOXpa8F4v7Sca+wxdTOK6oxG+f/3GpLGn/PAwiBrXAC3rb1SrduJMyzpd8pjfRDxBIklImeHDU8HP8o2B51af/iyURmGKzJ87vQw02NhWPhj+/Rh6lzHx5oFCdXQYW3Sv0JEk0Ia8khK22kgUZpBwZD8LxKNkHTG3WBbyc10bVHU85f16fg7peJVPM45pU1W3Zz+stsg7JDHberB47
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(22082099003)(56012099003)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vyhFYAwA47lOuFXQy+45p3SaGaxAj34Y7vABp/IiZPrbYdYD8ZtVNpbOsDlM?=
 =?us-ascii?Q?PhoHdMWnVvLBLc4YGh9n+FdPQ4IJ1NJ8BKf4VIfwxpQcBaqpqHqluQ9cL3hR?=
 =?us-ascii?Q?krAzGiGbuaF+dtJtUH0xs00kiP0SXc2hTg9iouldiY2naikcBJOJ+pqGrkE9?=
 =?us-ascii?Q?SilUS3nuduxQPqz5NqknodpMNg69IKXzdErvksCT/mZETFHT7jAKuFvB5gv3?=
 =?us-ascii?Q?rS1+YhG2mvp5/t8rNs4ylOqaDWRWFltNKhv598HEC+H6vH8kdRA9lvK8NXlh?=
 =?us-ascii?Q?Z8kpvdEB3X45CgBSo9pK62v/GXPljaLySkgAxhjauw+hSlVYkIAKvWD36MW6?=
 =?us-ascii?Q?k4qMlcH2CRd1TcKgkwtQjfe6CZHpTziTSAVvXYZ70q6+zuhpEKLRXqGTpc97?=
 =?us-ascii?Q?MSQP7orWvtd+yzm+CGc7m5Be9nLDikM+3jS9JrmkxCt5cTDBG2oNzJ+/pe4Z?=
 =?us-ascii?Q?BhYIWlUI+2yAp4LaIdZv82ugKu4X+FxtS7R6meHQ3EsEFj/kBfYL4okiaYdQ?=
 =?us-ascii?Q?lbgsbV3rDe8AFcDcu0znSkZolp8Ysdiumc+B0gBR1wyzSfTpvrcC0+kRi5q4?=
 =?us-ascii?Q?Pc4uGGOm9gjSiNnfJ/HNfcGoXBP4E/AQDZQDYMjLndDKHvY8BIdW3V1lsI/n?=
 =?us-ascii?Q?GyYM/UArwl8NE0g3qW8lj1C0vK1zVfYDzcArphpLRCGPLi8HxVqX0uQXghob?=
 =?us-ascii?Q?QFT4/bUUyjhb5gK7dM2enkNqKcGt2nZetuJ9uXuHuHQQbkvhPWo+JtwphiuP?=
 =?us-ascii?Q?nfOacbDiblsKoUkBc+lgMdE3HQpyTtd1Bp+Nnq8GUX0FCgyCUSl59Jnl3Elj?=
 =?us-ascii?Q?qoWPZPDsLj4ezD33J2XIKJALoatujwyf4ujOiAeO0xlw5+iLszVAM5zl7Tdp?=
 =?us-ascii?Q?m5euLYy3tulQ8NZUjmxDsplKf6EzncQHwK1OrdpZdPe4T//I48QOMOgK57Bc?=
 =?us-ascii?Q?obwTY1PVbRF5z6JAe7KHuwXyYcqNVoHr48VkBD0EMRUHzsvzBZGMAJp64R/o?=
 =?us-ascii?Q?hKJ56ddT5CMsMzVJo1laZnzexYV0BplKg6rLb4kOclKTBzZ7QXCTfXHOdxA5?=
 =?us-ascii?Q?mfQ8iNkXMWD8Q6sYjJtsWItNSzHvJFFw2OUlhwphgZIkTK8OdaWLwowcgHLt?=
 =?us-ascii?Q?EsRgqN5D56LM9HF1TxPDygIvappB9sDq/xGDJpmBDSeEUdPjOKQWfN3vxdcc?=
 =?us-ascii?Q?jDX1jKwO2R0buzRCqwuLHsanEBOEI79GNJ8N17PuF9SnE60OuemFOvz7NcX5?=
 =?us-ascii?Q?9aOXxhRbDAaiQD5YB1altg7VDULkNMj62o+526FBVKN3UEFNJ3ahzKdZTW7w?=
 =?us-ascii?Q?cLBScGxmleqz64WQbKtGCnyXzsCFDTq4SsRoiZcPM2BvA3AlmJZqd9jGM5vk?=
 =?us-ascii?Q?NtC18KYTcVEnQSS2bAu2Jz0G+9Z7w+vVBXIZ3iVl2BVIdOBDsTjB1rI3Q8RD?=
 =?us-ascii?Q?LsDMXrt+rI0zeEAd06hXlNEX+C3M8yEufm2Jv1BLcqNV4G7rMzHN81PyJHA4?=
 =?us-ascii?Q?KmF0Yp1sYWC/zwEnuQ9yy9IqOGuM4FxlRQE1X5GHu6Ztd9uc1B5cvjIdjmXI?=
 =?us-ascii?Q?AO8mFJe6F4e53IQBKXE/oE4Zc8iah7CxHTe+lYLFsL4C4eDLt9eYPiTh+52+?=
 =?us-ascii?Q?/YcMLDtdlxI5Ms0l4UoOztFX/TKzgzLxdb/VewO/cpz/IlKi5HgXejvzzE4b?=
 =?us-ascii?Q?YWZAodHxHi62ynjr1yiIozWIKGu0FEliXPFiZYhMX8RdZzfQk/hwK+2Wysx6?=
 =?us-ascii?Q?hWPR1eUspPlpA36sjWFzwTYOiY0BV/U=3D?=
X-Exchange-RoutingPolicyChecked: iQyJZKqm7KvtgfVPeaeerlY4aLM0FW8fOZi7NYgaiOlyIkBDFCN0LMkjNwJExAK5Mqp2Fwe1N21B+nWyk5dUDudBcN8WAyYNoOd0RaBNrdZhbUISUZqfB29+fc+6ZdJch+xDH5sB9PFqS1lefqXsK5oB2RRlvPEB4S9smICWcVWE6OBG4gMaiC0UjrOSzB9XY8MQPP2VeekNlWT2AfeiM0qUUgObiV2zV+rUTVfP65TQ9rh8RLP6FlPtGGwwFgdeDxPG90mdUE7x1yizArlYEPxeCOfhpC7m/9ran+peG6qX5Ps8wOOGqmyTI6H/9vM9363FJKHjAwoXS8Lffey0gQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 285126cc-a5fd-4523-5195-08deb61aa991
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 02:51:16.4356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgYcNmT5lW+0oaZdWGVJhPy82WT1i2hwy4APAJp46dZ3EwFsJf3JEGi7UJXaJnk26Kh3BH62uUs0L+4QM2LyyQsTL3zbtfthE+UbU6CUjFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6341
X-OriginatorOrg: intel.com

On Tue, May 19, 2026 at 03:12:03PM -0700, Dan Williams wrote:
> Fix a runtime assertion in cxlctl_get_supported_features(). Fortify
> complains that it is potentially overflowing the entries array per
> __counted_by_le(num_entries). Quiet the false positive by initializing
> @num_entries earlier.
> 
>  memcpy: detected buffer overflow: 48 byte write of buffer size 0
>  WARNING: lib/string_helpers.c:1036 at __fortify_report+0x4d/0xa0, CPU#7: fwctl/1398
>  RIP: 0010:__fortify_report+0x50/0xa0
>  Call Trace:
>   __fortify_panic+0xd/0xf
>   cxlctl_get_supported_features.cold+0x23/0x35 [cxl_core]
> 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


