Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF3933EAEC;
	Mon,  3 Aug 2026 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772182; cv=fail; b=VVb++BPTIfjziLROS9uKmyC68gTjOS1ZVm4yV2VU8M7FOygpDvwbruN4q13kEx486amzqxz2ZpNk7D7Vc/iMWy7ArDNcvuAcnj3Lk0t7bT0NaKiOduSe7KBKQgWT9d2ktDNyvEmipYtgR0VjPtosrG0x5QjlmfUp355Ny8z6QeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772182; c=relaxed/simple;
	bh=pI8G/50esSy7xShBng2KoSzar2ObK5VeMbkwbrTXOJo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fJMXmIZzNO6t16x5vSgMXodnItYX9tIlXFK8Hfyv7suEy708Ef0H+nAQXBaKPJZmt0lfojMC8rTx2pBKUqxDBUu6Hrm/Fyfiu0G61Ua0VXvcJf4LfL2OYCPEfEE1qvaBTP6T8ugTIQ7LP1OEs/0UrZnXbe0ZLxiSMjDzamjzJsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lK2gDdA8; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lK2gDdA8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785772180; x=1817308180;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pI8G/50esSy7xShBng2KoSzar2ObK5VeMbkwbrTXOJo=;
  b=lK2gDdA8miV8d1rpWshq5kTOTvBVTpkx0gEP0T+1ug4kAlB5cpakk4kV
   FwRCeGtWLig8FHQklzX8zn2f16ME1nfPhiZ0mjcODIpL9y7Ob43SItbQy
   AFEgfnaHFMwouhKakWcnrytFmdwXwEDXvyceaqECrK/q2l0VrpdRT0w8k
   +T87658UQmPHv13CHhlVnG6bq4CY0PyaQ50Bi0dxArxG21slugMYL/gm4
   5sShQmlusbIsPARb7i4VXhGuOf7G91V19xtFL237QGX0n4p0/TwbNuBqU
   nwn7mvgA5x0PJwUDekssQ/+CQ7TcdjWUIdRVVdoGr1Veb/5QB90e3HVqr
   w==;
X-CSE-ConnectionGUID: 9rUf9WMdQUS/EFDRbfn1jA==
X-CSE-MsgGUID: f+SqKRzCQamOVq7GEVLVAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="111865579"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="111865579"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 08:49:14 -0700
X-CSE-ConnectionGUID: qGP1i7GqRKyZLxZDoRVr3w==
X-CSE-MsgGUID: oYyB8D83TPmnpg6/ywJt3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="260004698"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 08:49:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 08:49:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 08:49:13 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.44)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 08:49:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmqrMXSGN89X8h470dbLsYbW0SiQfNCrBT307gicg5NSV1tH5pKk6A9CjPrfNNXD2xF7sNy/WBLyT72ld1y88Xqyny0QcHHwS3iKT/f2qIZ9p5Eqkr+pil4qHqXqJIKAxwbAfTmruoScImMk8w47c3h2lqQthygtDONOjXMnZSibQuXb9KMif7KaFbJcYChfZ76QSyxdgpDLnRUnxckaSwJB9vAF03RalHXKhq8cbf50eymUDwFM5Bwv0+nJ1QuktHhQeghU/ncoboWHJZ/+8JeqT8avGIoTQNVMUezmZXiwDxLUXZXYCVi9Sb/D0v53Wl39vJxwcnV+74FAZlxbXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOZrBusnqaGpmT205tGNN7bkHpdraMoHX4ekWvtcnIU=;
 b=BTxPRXx68PjdXsCLlYQPXlEra6RcK5lNYmdEKni+r7fXQo2TztwTYm/SLf7Nryr19upfMICiRaQlyrOdeb9JZl24Xgiq0pUPW/ygeL3JeH12yc7n1S/zx015vUuoge2lhBcKm1QHX4lCIxocTKXR9l+ytZ5GgqZDQF+c0uJ09M1WfSmdgAx+DpJhlquD4UBFTa/upjwgfS/bxM0gFYNfCha4zOUBldiC+6Kh/sqYvWVwydLci/CEZRqSmu0uIKCFohX77luZcW/e+U4iE4ymuYi5HrrmpdfsZRSlFBBvrjzmB1NvTfAQMVOz03U+BBbUt18okmEPVq6ogcd9M0SxWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ0PR11MB5894.namprd11.prod.outlook.com (2603:10b6:a03:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 15:49:08 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 15:49:07 +0000
Date: Mon, 3 Aug 2026 08:49:04 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>, Gregory Price
	<gourry@gourry.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl: Use %pe to print error pointers
Message-ID: <anC4cC7JGcqHH6hG@aschofie-mobl2.lan>
References: <20260802112029.28767-1-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260802112029.28767-1-shaikhkamal2012@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ0PR11MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: aa79375f-cac0-4f42-7ead-08def176c0c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|56012099006|5023799004|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4dQSN4LA4OiVYMLBShyncDdEDq4gnBZtmDR0UOpujOescw9ZFkXMC0tR/+DwEcfEQow8O5EG4QyK3o52mKQTXF46Z1K+jNw/YZIn2i6vAElzgbq1yKu2oLEziCtY7wrP7RE2Pl6mezyCoLEHOh6xLf+jFHXx3euoXRZKHyI3eHhSXTIO6m9NAT/6eVoJ5AVvfM3OrEucjiPXF+DgEZy6ufd23o71uu0EU3oVbpsL/oEDjIOtpsQ6Re3/teF0z1cnlgrvpsPkYYmSf2WXkBOHDGHjTxFJTUfetzXxG79RLCyJOWW05dpQgHxWyKMBJaOHPaeAjwn/oyuYLgUqOOAjWEZAGbgvjvDpXMfwEPyD4DZ00BsT4PJdVwTetV3rPFOj0fbKW8nR3C9aCkKxwixnRB21UnjJOneIRPlS2Hq4TdsSJ47VOPEEb2Cg1TXQczn0vDvFZ1xEioq1p75P65QVNt7p++U6S5LQeswlvn7xesUUKpqgXbM3JjArQF1jh7ul8tJ5gZkroKZVsFb8m2t9WDXeuU8nYsVVleCXlreTHzIqYbMbfRlsGGvLR5bBGkEdQ1DBWOx0/7GG/zmpo9aJT+6uZImB3M1kLkJuHzbTvgbEN4LjZzo0Hq4wkdrldMk03+HiZQkv/ercpXulAiZpQ/93834YWFj28H4Q2F4Lho8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X/TR9FIiNnbgcaqGk2HlWtZOleEtOja5vPbQGBQRrU7IUP3634q/Gkd0VjHh?=
 =?us-ascii?Q?S1DrfHSrUQMbdTYHwRp5HTbz7uVzSbrTlkYOiffdWEg3b9hzqCrDEuj+E0yS?=
 =?us-ascii?Q?yVwIyja+hvEwhPDb7H+x1tQM1TO+Nbcvvs5Ay50PLqc+3Xrd3nEMUuPD9iW8?=
 =?us-ascii?Q?cyUSbRYy0+/vGJDSKBnYOwORHx2uELAmiCYoclbX88/OBQyeZz0AFqfsqynu?=
 =?us-ascii?Q?E590TKH2f1GWmfRaGMP7mVRHT/k6S6/s2CHSwP7AfWpgqSveQP9/5w4ynK1g?=
 =?us-ascii?Q?V42jTRn9bOHUb8zhmhIcgL7Snju1XCtHMAObKyW2mQo7NGQ1CB89gY8TT0vQ?=
 =?us-ascii?Q?HEm+Sje9G/V60aDT1pggbFyeZdza/AXAFbIcxuTh90NSuTQBhw6vWinOOxvl?=
 =?us-ascii?Q?eTzq+17chxF2HeupAy8YLzmRtPABoMujSL6QJGpK+c73MU7MtvTVaSJCuaEb?=
 =?us-ascii?Q?pHs23wW5y2sOSP0Cn13zKA3ymZRXAsTAEvNF2fXS2ahabL308TyD6tU+eDpV?=
 =?us-ascii?Q?6ADYwkwpzratSmbUDmBntOoKzW0nHDu97HP/2pXpAKAWAWGDhhzvLsidokt/?=
 =?us-ascii?Q?akLi7qu4gicffjvbNi7u8fnEEzZr3yKkt6obeX4IbVxUjIMqgnrOdo1eQoyM?=
 =?us-ascii?Q?78HEfTF7o66Bmh9/7SSSO4gfcvqWs61/D2g8czRYSAl/TIcYiipL3T5c+7ol?=
 =?us-ascii?Q?hNUTrbeec9AZVRuQlJAMqKxLGyHZiup6vnFgXxBd73rPZLXZzMZ1IG2krF5B?=
 =?us-ascii?Q?QeA/FhWlezXbQ5/pm3BN68s1kexoECLU4dVj82auyymP0PZFFBHMFT/REylF?=
 =?us-ascii?Q?UK+B0OjF9OfXXkMtAngTlSVyjcvYK+HGxzDrShVMgUOt+OpSD2buKQw8SCef?=
 =?us-ascii?Q?2s4pCrf1Xi1SX0xnto8IF41KVGh/rRawqSrKJUMfTcmK1mSRo1a/RiwViXyv?=
 =?us-ascii?Q?PC4sJ87+g+QHZT/2kTyos3F0Gv9dcAVcGjRiAx0HexIx4zN87Bbl3c9CXhGc?=
 =?us-ascii?Q?Qb7GWUSQ1NE7a1oFOgwKCyGm+WK/nBa3OgplxVD3EJwzT8rP1FPlZTFptvcL?=
 =?us-ascii?Q?70rstCg6F43A7xi39LyCt2xYXOPPaCNnFVkqRrvzcznvlAi3sBLfTP3E3yIL?=
 =?us-ascii?Q?T0h8L0d+PPdlKIYS3zFt2kgrOSmLVFqmPc2UIvhvFwZYkT7DdARwe9e33CEL?=
 =?us-ascii?Q?mOvJ8jGanPcMPRx6NQ1D+fcRMsfjkdeJ0FinLEeyWhZCEQ+UWwYq5Ewy6JUw?=
 =?us-ascii?Q?0ABk3BtLezi3HZ9CCUMnc7G8q2AC8PVr+iG44CHbkqR8wlY7yrO3MEoVixKJ?=
 =?us-ascii?Q?LXqRercBfy5sveZDJWMJ7ccTwx4K9FCWwMPNPFUswFxa9I8jtHXcg4vxCgbr?=
 =?us-ascii?Q?1JGhrO46H+A/Bq24l4rEDAS/jdA5+9pSdaTpQhBJOJZZwq+cMrpft+hxK4+B?=
 =?us-ascii?Q?RwdwhFKa6uIE3fuO07D2R9kE7LS+V1IrEI5FUWeOvmts6XmERLb375UiGjNM?=
 =?us-ascii?Q?2KwGLAj11jLi3oRkMhWQOnJACTGd2j18s0Xo7dcRNHFYtDsrFGz3Pal6KBbW?=
 =?us-ascii?Q?kl2eS/SvGy9a1wrgCDss8cc81yfHmOXFIEoRjstcYvADex42IYInPtS1xHKU?=
 =?us-ascii?Q?Xe7DlAmVFPsGC4yPMZv2vfHP/vIMkATHO8dIm/vhRJxF5peEfepsW9Mx32i7?=
 =?us-ascii?Q?Pbvem40Dh4zUBq62NFoHLSOxXu6sC7ln3S1ZhXHOhuavZmM6zi2ngVW/rAxi?=
 =?us-ascii?Q?g160RgXAmCrLy6D14UNZVdgeyjJrJ4U=3D?=
X-Exchange-RoutingPolicyChecked: cY9B2mPiTOJI3ESOsUfOIMELefCp0MBpriMX94V2cRO/1HLRTFocq3yzqg1zp79bcGUdgZ7uO2V12tw0Hf5XifLCEd1rSWV4vE7GBPk8BZi9fjtZ2VooPGKKq3lwRFXhLing+5PyXx3/hSQVBy3VbAB/tlftxRdh6RN6RnGNKnZPmxhfhuXI1i71xAOPfMRryD3xiLcCS4XE6m1xf4W2AkdF6PAKnzCiOT2jsXY9v+DbV0QhSv0HocVwJmXMquX1Za7fNdhyQEC655Eo0fw5getTsowzXvMnojGXEF1WRskEwK9SFX2Wvd8kKSDPxk4BGpo+ecrdPgxaYf63RYzODQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: aa79375f-cac0-4f42-7ead-08def176c0c5
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 15:49:07.7528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yzJOGqJ29oaBCRLD3KHfTCyTq3kMHewTjOw0XbOPzmYcVMXBpa/hFOi0npY49hFd079CqaeGWMqdqBE8jwlF6WfV/jeXGM9T5LnISoy8+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5894
X-OriginatorOrg: intel.com

On Sun, Aug 02, 2026 at 04:50:29PM +0530, Shaikh Kamaluddin wrote:
> Use the %pe printk format specifier to report error pointers directly
> instead of printing PTR_ERR() as a long value.  A failed dport addition
> then reports -EBUSY rather than -16, which is easier to follow when
> tracing port and region setup with dynamic debug enabled.
> 
> Convert the five affected sites in drivers/cxl/core/port.c and
> drivers/cxl/core/region.c.  PTR_ERR() uses in return statements are
> unaffected and left unchanged.
> 
> drivers/cxl was scanned in full; these are the only conversion
> candidates.
> 
> Found by: make coccicheck MODE=report M=drivers/cxl/
> No functional change intended.
> 
> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

