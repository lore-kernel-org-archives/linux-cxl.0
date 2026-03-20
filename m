Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3142D0C7B
	for <linux-cxl@vger.kernel.org>; Fri, 20 Mar 2026 02:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773972310; cv=fail; b=g81ezpWKoOh943oxNosMwWEZxos0War9N88y5PXMY6f/SFUKAkmPwzHuNN+X7Aad1JmFHF04nzL6UWUEZhjvUvw25e+YibhrWgKX8igOi0ADZFqqadY8j8rNkaFhMDa1unv4hLPEGGZgjc1hH1uWZWu/qxvKbmqUOEALpnQ5RXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773972310; c=relaxed/simple;
	bh=yqmp7UJwepyhrAUkgG+6gJD83i2QQSuGMi8xR7BNYLc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xw5MfyMwjuqF0AkhNrl22p94K667i6BL+ZEMtiMn8xIP+oHposzIha68xc5mwGwO1PSHXUriW+mSbbtsUWYzYZ790BvXans1Pm1+k5g9H+2AHkzzifntj+xdrR6mkIKT1jlN6vWI6DDRGlcDQ1wi8JCDz0kPISgEEfGHuJROfFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBfyJNWQ; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBfyJNWQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773972306; x=1805508306;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yqmp7UJwepyhrAUkgG+6gJD83i2QQSuGMi8xR7BNYLc=;
  b=KBfyJNWQ4hARDPbeT6EsqMxHNgWlnddls0yt+kVOJmoNLN71DmqUKZ4f
   uRqdmWa0LqbDkh97KcMi9ipJArAtbKvoLFh9Ma3nVY52VYLuIIfYPGkop
   ZQqkGSpPgjaULlm3Bl4saPG5xXyVaM6FCSTuRkK2PzupeVp1hcFCOAXDB
   /a+stlp+sNoKUFuNhAKjKaej9V2w25rwuab53mjUydUjiVqs/7v4WYTqX
   8XMDdpqUBGWvlDeIb2Mm2zKwa7sj7Q7ZQI9iacZS8DXa1BKX4JUrG/SqB
   JkvCOxrKMKP+N8Cn+7EtEkBN3BZ6XA80J9MuVSJIhpKU1PWDHMAUSkQ2a
   w==;
X-CSE-ConnectionGUID: f5BCKNvjSXqeotelCPY89g==
X-CSE-MsgGUID: GeALOBM0QdurQna6bOKAHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="92441168"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="92441168"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 19:05:05 -0700
X-CSE-ConnectionGUID: GuThSlFNQIu2LrfVh9Ma5Q==
X-CSE-MsgGUID: 0RuWt09/RFiVtGzb3i124Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227624130"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 19:05:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 19:05:05 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 19:05:05 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.20)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 19:05:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciqU6RhG1/9DFX/eq85SaMO+QNL2hNLzCJ4k72H80zgedCfTTRAJg4+xbE3Q12EDGkIJekS9jEvtuE+H8+CDTn1jKGh9P0tspr2noRc5VK+vQ/8jtw6kiYDKekUangH5vForAcU7bjm4pjJXij5TOhRygTAsxGdTTqiLso1siOh/darK+P1Rkw07wHjmktw0UIJEzkJw5XOKfLABmwrT3aisUPcIvPZnnrc2NzGWgNliZSwK9IyexZjLgNH7vfCS4khA9WhKDAC1F2Yke/BQ4U6aschSRFYtHsYsGWQfIehxD1JWyKMaXjjtxbL7aPffyTKv7qno0ckFVVi7ptDhXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqsT6Tc1auKnUsgzsF6lOTeXH/ezFWlFGcCsawgOhck=;
 b=PsyFgLW7+NIbPCAelW4Yv6FFKyy/vR5yYeRk9xhbZ31HXmmsqv7c/wDKHr4w+/QEbcis2cB0pheEkbL10lPLlCCSo9kVebvMYj2rw1lnKvWsU/wHbTcFi4yN+StanK+vPtk67mDRfzvIQhTxvSZlx7A+0ZVcm3qquqgFnnPJVlxWXqxCz5ZUmmnHRNM1jTcwTY3zuX7T6tOsu/tEpWmT0HQ1/toKnBY9VPeFqtyFK9oRca0bjcAxHrZQPkpbCvZHSQrhJ25i4c2ag4DjxNRq/tVqckfKtWqJyIUOfob4jZW6bhRvlRqTKSPmiFF597a0ccAv5+whnrV6hSPTjae8tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA3PR11MB9512.namprd11.prod.outlook.com (2603:10b6:806:47e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 02:05:02 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::3979:c00f:fdca:b895]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::3979:c00f:fdca:b895%4]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 02:05:02 +0000
Date: Thu, 19 Mar 2026 19:04:58 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>
Subject: Re: [PATCH v3] cxl: Add endpoint decoder flags clear when PCI reset
 happens
Message-ID: <abyrSsaJRxv5cCVn@aschofie-mobl2.lan>
References: <20260319152541.2739343-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260319152541.2739343-1-dave.jiang@intel.com>
X-ClientProxiedBy: BY5PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::22) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA3PR11MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: 03aefba2-346b-402c-7d62-08de862518a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZZIWEOFcQ2ulYWkt26KntQOz/PIQyylYJWDUZuUv1cigGHtItJokQ7SxmuPujHYlXP66w6fFLTbkb+FwrOQOJ2zrcKsbWBDyAEMbErWV4DV3iFCjLYHS3A+/tYZwd619YDNE7cl/6LgA0S8rNrfMy3p3umM6Tjm6ISz22yQSNuI7ccUpXu9pCddpFvu6RoQbZGyIO0Y0ch5ntVK9lpY6FYomY5Fh3Z9rJoBOt6vLrLD3If68BLEs5ieLQWJO950Eyg/Zfy4765/+YEE+TsGE3IUKqp2CMF6HwJgkcNm3l3VUhad+MtE7iDczjT0qc9TL8Vx35gDp0ZTsvaKzTld6ZRvJg2QdX0YRAscib1AOvykbwuUR2EGoJdnx4upJuzh41frsnHX+icYzN2pC3ozWQocrW7mbjE6fXfEFERnBMbNE4tQEdSmk9OwzGJaq1FSNpsXS4mAy4QULeghFC5PjH8EfLO+J2Ng2du3n9vqKUx6cCJDLiJ89IFiMZbmoxBCApF/uiWiyAYfM8k0qWyPBMFx+eWZNC7xluk80I0qLEhMH8JgWbs6zWLYwjpbuple480fqi1N9KByxQYffDVoK1c+EJIHLee1ti04ueLMKThfAN8Vq0ZmDMVymM1amamZ4Ttjez4BKIfolsy+KPNwYp1m9RCAZY5cddOiYVzYbi+XRchyPxsgLTfsQi1o4dl/Es6vmFDlQmEBb0i/fL3vlV3AhFCSEZa5nXTwP0xehl1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pMHibTUp0/EhTL6Fw6kZv7kdQDp/HzWVpRLjcwyVY2d+ZLLgQMOddSCg7LYZ?=
 =?us-ascii?Q?9BEjDmw2gXtZ6saVOR12rnKBABuTFzOQtXYaZZ3oEoDqTy34FtkZoO9QbJxX?=
 =?us-ascii?Q?g0tPcXTN9AU1DFcNAG4wpge7/PJDnSn2tqt640M6cJZqoyha0Igw2H/Za1fU?=
 =?us-ascii?Q?gFYLMT9xKW2ZPzZOstJ4LyMOgqy0ZeSIQPS1SXaejLSz6914MKOca43AnTha?=
 =?us-ascii?Q?J2wT06Rxg93CKgspEBtGycrIuVkjnwdkPrQhT07JnVkZYPGPLVSn7TMtD8ek?=
 =?us-ascii?Q?b62RoMd8XDq+9KQoJkgjECZn7abLupgD2a0cAIlloybdyvgqX+ER9sk7A+tW?=
 =?us-ascii?Q?QdWY6ojGlK2hz6mEQU66ZOpMZ8jWPLJR6f0AHi5FnGHel+TKRXZo9flf0w6w?=
 =?us-ascii?Q?dvwGJuwf9Cun3InZ3suPNXKblPBRV2X1mxOedqwi7Z+Pj1USLXcV+plnBDk/?=
 =?us-ascii?Q?4KjoUpDCoc8yePGb8iZzmwjMJ6nNL003JGCPGof59JOeob97YerIzCHMSsWP?=
 =?us-ascii?Q?K053mzCDlUqxbjdTQyriY6F4zQyPBOWcQ2K3Cn6XZS3tKRFVdHtaClHzD69T?=
 =?us-ascii?Q?PG+OgH5cgRyld3LmtNELH6TmB1gIVWmOzUdMYDQG4YliRy6fR5371Rz5lqaN?=
 =?us-ascii?Q?SG22zVX35U8ttXVJxHYRcaCFtzhzHH9hycFXUTqOy6xm39wXFMORIKLglHZX?=
 =?us-ascii?Q?QR87V37nJhcbOtv0QCCED6CJEPDUJFn+QkcOk787P5+ewoXbP1uuSJbs9jDg?=
 =?us-ascii?Q?JxqRrv7hho3qDrLn7jsD4vwMD8ZglqFdPOxMJHP4uZozYD5BIbDA37yfasuL?=
 =?us-ascii?Q?oZiK2WLAN4I0ItZhfAnCDSP6Bt1ZpQnHsvD+0bQ/88Ot0F/2NrzK8X2b/FZi?=
 =?us-ascii?Q?n1I07/6GlKdd/UAU4usUFgBwzCINLt8BQQAnrpXOmdUqbM5tFl9x5x4awohy?=
 =?us-ascii?Q?J1GBtGuu9joJk/B9+HBLmur/bP3PuMFH3J96g7RI/8u+XJocmI1jGtloM78s?=
 =?us-ascii?Q?LFHwYXMMcyIzPbycDXSYDlyGQmHLiXPYjz+Ry3s/u9nSWZGd2qwwxbYTG9VU?=
 =?us-ascii?Q?M7HPQieYXrviM9mrvZ3z4pKAeAqgE2UAfqQwrKMOb47RrXxq0jNoz2OXIcsb?=
 =?us-ascii?Q?whA7n+wL1yr973joDTuEQSrIw70m/68expHcBTvdHsPycVgDs41PH0NEmsg2?=
 =?us-ascii?Q?UX42BdYVJU7/3tz7XlQ4U9LJkOkr4sy0z4oJKReyU8oeZEvPWkushSvayQuc?=
 =?us-ascii?Q?PpQ/VsKcHH+o//g6U51iuJMa9pwnSwVBXiO3N28sZUj8Sf5SkLzfFSpcDA+K?=
 =?us-ascii?Q?Xds3uVDXpccljFCNGewJwqsy+hgE7wj3LtjbiYQxMBkhPPWounbbT5Qnyo87?=
 =?us-ascii?Q?SqHPK/IxbuVRXibZTeVHcwfueKy42RnDwr7CA2ddTVTrDGVjhKiormEHTr55?=
 =?us-ascii?Q?ZBJ3HKJZ7sMcWZD649438rp9k7uUL5mnh+ZzIV8YebSfoblOZnoG6lV7NQ+k?=
 =?us-ascii?Q?bvyh9jP35naoeinAPQgmvLjXxDB+dc0jpWZ/sVUuTMAovR0izqhcfm3l3jgV?=
 =?us-ascii?Q?mvpXthX9hiUaX3GK7lfdVL2Pb3EzZ8Go4kT2hDwLEguqEqSwpo4qjuhMHH81?=
 =?us-ascii?Q?tXeC9BgFPh7OX7IWz7jagu1b/DdECJXLArL3sufMaj+ITAeyuIZEIovCWQED?=
 =?us-ascii?Q?fLaobAnp+Udq+arpItKi2f2VtFWSG0Io2WAsskHM7avg5IC5Jv4lyfrz1BUn?=
 =?us-ascii?Q?POFB09uX7kvnuuNjmZ0iD6Cnc33ysmQ=3D?=
X-Exchange-RoutingPolicyChecked: rugtsR/4QbTtvFc/xV9Z3VHFG5Aam+sTWlY2pjDNAoGR9sgL4ox0NJUAJfgs/BHiERMR/xel+iZjKm3vftJlHJ+YPfpAf8wzo06aDAiWP312iJ7367TZky20HBg+Qqnyln9JAFczID7Ot21LK9G2Cgr8WvywMaEgjENI07TO/VyWjWYSEFbz+nPFuZhREc1IFk5jvGILz8dKQsDN6LKXjNZsXX6NNuYf9xVW+EsDrXxhuDjCRBqicGKfx4lOTKS3XUzx0WJL2QqazLX5y5vIRxX7CM8gpIeQggFb07bf3xv9S+tQRxv1s1jrag4KXd/36xGm2yqjcXe1rkINRoOJNg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 03aefba2-346b-402c-7d62-08de862518a3
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 02:05:02.0030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvbxIAJZacOuNoEYamuCRO/qaH8R+f2fF25es/2FGCiTeurTaBAzi19zJStoMlO1hodTktQ84cE7VNY/B0Vq+PtqfnjV1yhCV3qiJDCmoSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9512
X-OriginatorOrg: intel.com

On Thu, Mar 19, 2026 at 08:25:41AM -0700, Dave Jiang wrote:
> When a PCI reset happens, the lock and enable flags of the CXL device
> should be cleared to avoid stale state flags after reset. Add flag
> clearing during cxl_reset_done() to clear the relevant endpoint
> decoder flags for all decoders of the endpoint device.

LGTM still

> 
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

