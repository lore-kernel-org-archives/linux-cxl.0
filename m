Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607662701D4;
	Wed, 23 Apr 2025 21:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745445163; cv=fail; b=cfFD5sKYqAxLWwcxUchZXnlXKjsQEddr24NRffmV6sy27NQ//Pl6/aFy4j7YA98rZ5zumbXbKIETNvBWXYGgeqWpGtA6Zz+EOu2SIx3xDVnXd/jAlOdTc0fQ/Aw3WixBLWYbhoUfxYxbix96BqnZUeasDRVGBwdzZofVUfN1h2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745445163; c=relaxed/simple;
	bh=iPgVXcE22yt+JdTyg2WF1vqYXqd/klRqQZBYosd85Pc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BIHdb7TsJRIODXQT3PQCnQ0TkEqu7ZfSoXRBzpGevwnxkfVj9EWrqPmqzYJXe9/g4/SQOspDVU2QOL5ZFm0gZTMJVcOdcVBCAhK2mVxBePT162YIoiEL8zY7L5092CI8thtafYE95nwXS0hJpMnV+z4pWtPqki3QD9z+y12xgY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYTysjEr; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYTysjEr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745445160; x=1776981160;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iPgVXcE22yt+JdTyg2WF1vqYXqd/klRqQZBYosd85Pc=;
  b=NYTysjEr+Pyvuq92savyRcCAjtWpsDxy5D02jTnuN1D9NqFommBXo9af
   kxwJXgCwfrdTUxM53aVlsn2ag9dYEhvcMZd1S53eOAaJioG4LMZq8uQu7
   BjWwqEjKpwKY0sQsKHwGwYFDiwl/K07sI7Qo+c+0A+oyAXCF/Ggxy1dMm
   9IcKke00PI/uXryNKXgfIhcu6xJSy3D+FbDWovQbouCnS+SuDx2HasmxP
   2mlhtsj4jcBBOQgCE4Yfi9Slm1UrwRU6P15NCbt29XN+XnRZ9hibTWEcW
   OpfYOCR//ifNfBD3GpOmUCiAdDXMIceFf+2RJlYAA6ETKSotrbKyu6U2k
   A==;
X-CSE-ConnectionGUID: T7jFdG0MT+eezB8NED7seQ==
X-CSE-MsgGUID: bWoaXOe8Qniw4Q3dcpsG/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="58419797"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="58419797"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 14:52:39 -0700
X-CSE-ConnectionGUID: uNgGf18ySPa6mRQZv5Lx3g==
X-CSE-MsgGUID: BpUZyOVvQnemd9C5tXHSqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132317077"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 14:52:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 14:52:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 14:52:34 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 14:52:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlKAKdEmuRRbRhsZPeW1PUvFwytmGPxRC5X2Vqf7syjlyME7MXZznVUoietLRPM+o5NwPTJbSb7MOEe6r3C+yV1KeVOUSMLO8l81DyC3Igpp242YM2OZe4Zw6yku+KoNf9MfHr+xA47PXkeeReYw5gt/fG95//YTKh3owJ44RTcpJvkgaVzIA29nozSTPGOPemLywHCyKWZq6K/SpDRnsSdnS4e+zp4xwC3UuWj3kFAVYqas/ygTyxBaHpManham/vG/JUUsxb4oe+OeSp29tIF98KSWGeBj06j8Jhg/gAVzDIpJ9Ur0Q4wq55ULjREIdYeP0l9ImpLYc1fGITIILw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rI4TTqex2mnndLzTOj6JAHDba++etP8ibpsPcxCEVBs=;
 b=UOp9Mr8INQMUd9iDpjG72lUBofpVbEcgEmH9Xcg7a6HPirTWT6LKaoqvCZSqbJtUnFDqzk1wKzsbTSjzs3VRIt3B1rV4qFxXik9vcqdJs4837Sf1MIOABXXbk/NekKn92ogZl4JLSI2fMP7CjsgGn5pEpA9LULnQPtC7M1bu0NiNbPsUwliIEGjdYIn3tg1OhrQlpuYnOwMEi5Bw3dXG/dXgxlSw0H9Zab28q/X2Xs1jtOKp5j6obUcwKniidCH/c4EQH83dAXItyS9pgbCrnY+xCJS7heK9LoGaqHbJuVN/VRI/5rFsyX57wcciE+pakyGOEMTWoJeaUInvp1f4yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB7545.namprd11.prod.outlook.com (2603:10b6:a03:4cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 21:51:51 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 21:51:50 +0000
Date: Wed, 23 Apr 2025 16:52:25 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: shaikh.kamal <shaikhkamal2012@gmail.com>, <dan.j.williams@intel.com>
CC: shaikh.kamal <shaikhkamal2012@gmail.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Shiju Jose <shiju.jose@huawei.com>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, "Steven Rostedt (Google)"
	<rostedt@goodmis.org>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [PATCH] cxl: trace: Fix macro safety in
 CXL_EVT_TP_fast_assign
Message-ID: <68096119523f6_1bed7d294ad@iweiny-mobl.notmuch>
References: <20250421184520.154714-1-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250421184520.154714-1-shaikhkamal2012@gmail.com>
X-ClientProxiedBy: MW3PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:303:2b::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: ca010ade-b638-47d8-fe3a-08dd82b10d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MaLVcZRI1not2y+HtfKhxRpEMOVBhEwjQbH4V8PLJNbrhecSA0oFgzN2GWg7?=
 =?us-ascii?Q?wo6C+bcmHRrZAcH9UmIJAeKyUKAKUWHQyrKJf3pKVETjPBngfvNdVKEMUfTl?=
 =?us-ascii?Q?1V5aHb1z7tHZeECZ00W73lwJVgxfABP4CTOxS5QyvQvGsnLYOr3p7lu9OPvX?=
 =?us-ascii?Q?NWY82BvpD1J5wg16LcSnBgPmctoMg6roobTFZvnqxvLul+6Hm0TPE/AvkyCe?=
 =?us-ascii?Q?HKX9YXXpReCKBy7DMnJ8BoCFR0ZbtT2hVmzroih3Qv4U7tbCfnLVPNKKXMAT?=
 =?us-ascii?Q?PEncq7ewKW8NZexLoSlh0xMF+RMUF5Nd/oBatBxlvodEoV2U3bktQVeQP24L?=
 =?us-ascii?Q?QMJXXOuVLQFVFhXPfzDuEQttIzfZH4kkiCZ8YcDbynGlMuAfRNzo9kKtJDwD?=
 =?us-ascii?Q?MoMjBtizl+qm9iFmfmEnPLSaOQXa57zsg9cugKQan2/Mra22uNv2ivSI+yOr?=
 =?us-ascii?Q?McPUPS0ojgJuxzDvAODGTTnetfuV8DByjd+Nk1aOQQgdrkpqay68z1yE9jgp?=
 =?us-ascii?Q?srULcAz3h67cc2ABcZ14lRMC4E7ULChMLHAPovyYTwJW629STJViHwrd4+vT?=
 =?us-ascii?Q?/1tuFrm04tDKZ96BC8a9Q4RHtPP5kDvpNJYv+M7ayPZF8o3N84iC7gYs8xoI?=
 =?us-ascii?Q?Ea5bbKbxd6mQBVecPnirwkwm+4IsXFzbd2fb1486wpRtggQNCSKBF7mtsQJd?=
 =?us-ascii?Q?oISIvtfWknHktIoQZT000fUQmiXvonMmCGQ5yNvUsHZErib3Z9CpUWleyzAi?=
 =?us-ascii?Q?75yZ57P17xNhi2bD5+RpQEAbi2JfYM5l4r2VLcCYBzL8JgnGxVBKIl8/v1eV?=
 =?us-ascii?Q?byflsSj/Bc0hle5QuOI+/juvW1DBxoHWtDNuQJ0JRWokpjNxYmDJ7K9FNdrd?=
 =?us-ascii?Q?EsD1Liz28bJNbRH0oS8Uqk8tONVYhA6g+J4NonTbgjn961XHwaUQGO/KbBbn?=
 =?us-ascii?Q?UcHO1hN3c+CfJBbeNkcy2U/GtQvxUBjrnPEGajS2iX77SrcZf4BtPirz9TrJ?=
 =?us-ascii?Q?5p7/mkiYBsFQ6phakSVlJhArafi4RETikh/HPxBMT28KZ8bxqM314QzjX3up?=
 =?us-ascii?Q?jtvIu5kLFqGtfT0rJ/SLcpXRfs0KGbvi4dwHuIFkaNpB3Id8HDl5+VvqTrTk?=
 =?us-ascii?Q?U9D9VBWW8nKLt1GJTebQNnixCm4W/eqLHV1tF0TPDwaMM6dpmIMgj7HkCuEP?=
 =?us-ascii?Q?OeXQa5p5G2MsFz/Gj2wDh6MqCHawRZIjRHLH/JP9v+GvH3I1OTCxWE+Utxad?=
 =?us-ascii?Q?P0C/j+0g8dmVb47ONAsLnpRDSNCUQ43LtkHa8PTauDGkryyc/b6jZ4AG2Um+?=
 =?us-ascii?Q?GP/39kCpgBOQYjExgzXWYyNqg0S7mItmBY1uz0yB3QaGKyoy4ClgCe5qpROC?=
 =?us-ascii?Q?K0gw0MHQfBSfmF08Aye7OGLhs1GxFJRUEG1JGS/17LjxWEGGuiacwh1GhoWi?=
 =?us-ascii?Q?APQI0ZF0h7w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NRmEjlJRtwHpHS1zWb5X8CI0BiEKpe0TQKoYO1TN4uQqYdUaFSyHKGGxj/jz?=
 =?us-ascii?Q?cmbV/WCHHa/gIk/coDrl2Itu9H5lraPvv6qNvhjwMoxfgv05cUMLLd1fId3o?=
 =?us-ascii?Q?naqGXp73uykstuSZHbcSU8Y81sQSzOi3e11U+IU5YDw6lbbyZqZrk4FtzogJ?=
 =?us-ascii?Q?HAJavxy4yBzVbRw8zT/LMaiYnaa4UAldeJ3KinLV+7mDWcj0PtzDe7TRJiav?=
 =?us-ascii?Q?DzOqVkwK8ne92rFDlaKpZEht1CVy1Ii8Y6IqP1OlSuCEy5JxqqmHRtsbj5nK?=
 =?us-ascii?Q?R1nRx0qxL7PGxGKJ2PWiDnvK9761pcrFyclyuTdCXwe2BNydUKTZmKBccEef?=
 =?us-ascii?Q?qMkXN9ewdLKtf5P6qCJlHRdcC7Bnbws5hR9reRaVvGbkv8X2a3+QlZboB34Y?=
 =?us-ascii?Q?PHmDnM2PFDqKJyyUd4IIAYLRcldF0SmxltdLwnHzAkBaXH7oK0CGSj3QCi+U?=
 =?us-ascii?Q?DRjwKDGBUma102ISkaGyVg63JEZCzZd73vJcEC7BDGes23I/wOPGhkDNDkQq?=
 =?us-ascii?Q?pAhpPvLjRAR7RU0SYHpOwV288ZAf0RVSrB7hrt9pW+Tqsq01VYls6wctL84u?=
 =?us-ascii?Q?tIevaqoTP6RZ1OgnIHsaKAg/nAzftbzti0177kJIcVj2lZgkl/6iQIZD7aTe?=
 =?us-ascii?Q?bRDpzOCT2ao9i2Fw/az+EODRTo8SjNJ0EYVGvc+//qYnEUwC+6hqi3zN+P6D?=
 =?us-ascii?Q?8PVF3b38kJrBGQjbUuC76SivcyuyEClFAzWv7Eq5jZRuRaaINKQfPUOyfwlw?=
 =?us-ascii?Q?46GR1imt7vtPxs1QDydMA6bYhvsNwLXIjljbthV1F44a7853BpXsBKCvlGRR?=
 =?us-ascii?Q?TgA2joiVn07lDOw2F0VE+7EC2RVnX+tCfGCkeX2FOI9aLjrGXgcENblGUXFk?=
 =?us-ascii?Q?6Bbzg62abc5ukbpoTdHQabi3eePCnJ0LIC+bya54lLtAGaqiu6icG7IcnM1l?=
 =?us-ascii?Q?6nC+7LR/4MLTTLTOxftlGcU30nvaIi8ZPb/ySnwVdZAQ8v5cpWWKaU5UvndI?=
 =?us-ascii?Q?ZDIXkdBPcmv7HlI72AjwEZ4O4Jhbw2j6s0+6cOQkqOY4L7qAzsueYRGlRG9Q?=
 =?us-ascii?Q?z6UMBM5FGl423mEKcbTEtwHz8rYLpl2I5YulIe2gsmxKjiWgF2zEeI2E3FG+?=
 =?us-ascii?Q?EmA5wF9naORRaOy4bUctjtt1f34JrL0H2oARUMfk9Q+vPf2xjAhI6UUKqs/P?=
 =?us-ascii?Q?Jc1qtQTGtNfsABR/CiDuzBJyw5NGfqD5iuVv5QyGD3TTmagZfkYeWL4NExEX?=
 =?us-ascii?Q?u6xmFfAZmboEDo0g+nurdrhM3Lw5CjirpgN8GOvBWsuL3letfhI4MQkSmlIZ?=
 =?us-ascii?Q?BXPGD2tRnqOjNUfztYZLTFc5Kut1v1QZmcNH2Qokt7WDXm+U+glOCPOd9G5r?=
 =?us-ascii?Q?WD0tXWOlMqoxTYIH54YHRoAdEJdgX+jUuH1XJNZ9Wf//cACVU0tP+czsqinB?=
 =?us-ascii?Q?Kr6hmHZir15L4rMfzQL0X7DL6Kg2BQI18BmMH4QnXHpEV7TgglYitS0lPvpI?=
 =?us-ascii?Q?j7kcK3WCvIHtvnc4p2pg+xuDv/QBWQ788R2X5eAv+niODecd+uYMTeBnxp++?=
 =?us-ascii?Q?XmDdU3iJjw6JWE1bKr21vcT8KZO4iObzgqgt6l+h?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca010ade-b638-47d8-fe3a-08dd82b10d54
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 21:51:50.6522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7FKk1moHkxvu5uv89g0gwhqbPLDe4zagNdr1qOsLjtRK42XMGmqmFlFVNzaY9Kc1sJ4MqQ9ynIgIlIhH8amNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7545
X-OriginatorOrg: intel.com

shaikh.kamal wrote:
> Fix checkpatch.pl detected error
> The CXL_EVT_TP_fast_assign macro assigns multiple fields, but does not
> wrap the body in a `do { ... } while (0)` block. This can lead to
> unexpected behavior when used in conditional branches.
> 
> Add checks to ensure cxlmd is valid before accessing its fields.
> 
> Signed-off-by: shaikh.kamal <shaikhkamal2012@gmail.com>

Nak

This is not a normal macro.  checkpatch.pl does not apply in this case.
Also checking cxlmd here is not necessary.  The callers of the tracepoint
know very well that it needs to be valid.

Ira

> ---
>  drivers/cxl/core/trace.h | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 25ebfbc1616c..a1a1014ee1fe 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -249,18 +249,24 @@ TRACE_EVENT(cxl_overflow,
>  	__field(u8, hdr_maint_op_class)				\
>  	__field(u8, hdr_maint_op_sub_class)
>  
> -#define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)					\
> -	__assign_str(memdev);				\
> -	__assign_str(host);			\
> -	__entry->log = (l);							\
> -	__entry->serial = (cxlmd)->cxlds->serial;				\
> -	__entry->hdr_length = (hdr).length;					\
> -	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
> -	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
> -	__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
> -	__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);			\
> -	__entry->hdr_maint_op_class = (hdr).maint_op_class;			\
> -	__entry->hdr_maint_op_sub_class = (hdr).maint_op_sub_class
> +#define CXL_EVT_TP_fast_assign(cxlmd, l, hdr) \
> +	do { \
> +		if (!(cxlmd)) { \
> +			pr_err("Invalid arguments to CXL_EVT_TP_fast_assign\n"); \
> +			break; \
> +		} \
> +		__assign_str(memdev); \
> +		__assign_str(host); \
> +		__entry->log = (l); \
> +		__entry->serial = (cxlmd)->cxlds->serial; \
> +		__entry->hdr_length = (hdr).length; \
> +		__entry->hdr_flags = get_unaligned_le24((hdr).flags); \
> +		__entry->hdr_handle = le16_to_cpu((hdr).handle); \
> +		__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle); \
> +		__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp); \
> +		__entry->hdr_maint_op_class = (hdr).maint_op_class; \
> +		__entry->hdr_maint_op_sub_class = (hdr).maint_op_sub_class; \
> +	} while (0)
>  
>  #define CXL_EVT_TP_printk(fmt, ...) \
>  	TP_printk("memdev=%s host=%s serial=%lld log=%s : time=%llu uuid=%pUb "	\
> -- 
> 2.43.0
> 


