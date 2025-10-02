Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87708F54
	for <linux-cxl@vger.kernel.org>; Thu,  2 Oct 2025 02:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759370486; cv=fail; b=Ql3JGRuan7Bq82SPKXqP/jmhCI27lScTC4iRbE8n1n7RfUGV34+068LAFL9QDJierf5eaiM7dY+qibzz52mI6HdmhXcFdSvR7ZepMeo9WdmM2mLiF/QxoGMzMsk9pYZ3F5hJ/vccV3ESQCz7AxNCetIEuRL/OVLvPDjGJVzt3wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759370486; c=relaxed/simple;
	bh=Zpy4f6Fv/RSyUGjFSkDw/+w74aqH6mZ/mXAJwSjL6jM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nVx67ayhaJOaMF2Y5iHK/BzfafWEBBJ4KZ0ekPzFtzQ57j5L+dj6ncB86ooVoNSS2X6CjBirqu33qaunXVEOoCh3VbVR7HX81I9gDqrxiHkJboJGDrjioqwbiy5c+GlZGhgrUUDHhce6h2OQaE9rIumRqm9GjtQq2CXjAKfgL/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBLIXpT9; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBLIXpT9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759370485; x=1790906485;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Zpy4f6Fv/RSyUGjFSkDw/+w74aqH6mZ/mXAJwSjL6jM=;
  b=aBLIXpT982SqWzl8dGKlcx0hgzl3ogJNOm6WuIezP0fngj7/49KN5B0Y
   /13zTIbqblm54xW2RwMSf7h5Cg2uMDGNJpIY4uKZ9uDWQ5OaVtVePGrdR
   ji9rR4LkF6l2vQ4RRONY2FeoBSJ7bx7hRbMMKbN//v8VIbLGRev22VW55
   NyKFBg/Fhh63bkpWb37ZolvBhjVsRZIDpSTRDe2DUAF4unJiJ7T0gmfdG
   XP5vpdQYr9+mJKqq+jeAExgSflcfDv+JruF5JRWmz6uhWfKTkKCCG5/nP
   m+yOjRRrS3yk+JMwgqM9i/62hGSpQVRMiYjsSR1ZjlU/r4RDURDGzsUCN
   A==;
X-CSE-ConnectionGUID: 6pVGRyHASA6U3csuOByDhA==
X-CSE-MsgGUID: Edlw0g7ZSXOzyu4VEXfscw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61758824"
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="61758824"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 19:01:24 -0700
X-CSE-ConnectionGUID: gEt5IQ0/TZKKcsi7rfYL/g==
X-CSE-MsgGUID: AAbCECPBQM+uIStW0F0M6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="209646970"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 19:01:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 19:01:23 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 1 Oct 2025 19:01:23 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.37) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 19:01:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8BtjfSE/OhGFFgVLDL+XJVg2qHSPW1EMEChi03JXSYNfA+ovk6DSVLXKnHIBrd3XEsDVZtdJQnrEgxpjsCsiBCSpwTmbh2v0oOBZ0ChU4QhHX6Hh78EE7f6s69N+0mBJtgvSIopeaWhrjBqIvIvaH9K4Sy6R1irqSkJfYxYmEG2pXktjnrM1yFRd4ZzQ2ndPzmkEyQ4frjd7hPHMZuOxBRt4DYmIlproWbsCI/cZYxc0mAyPDOXPGaQeRpikBAH6dZhnIG9BCx59hcozFi8+moVwaTgheJxinveVVLjMBv7JXL369i6fCYy5JMU8VEnaN2UmwvM1r64cPcU+ROdzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRdaC1euGq4pPj2IZR/RQIwnvuu7/U56s1IaepoxNz4=;
 b=KkBJGoKZs9mcu3H582XwL4SqxK3/s3P6YMjif47dmAFoUTZTvNbmEHiqcvY9OrCwD+R9NZ5F/4FmWq1MzxGPHent2AGHszGuAr1Dlr9PQ5cuNaRh4aNlWzt80Qm2cjakMwgfw2dmx2okBNn5g33yCCxtNCQzaBxR1J0cOLbqskZ9rbXOF0zrkGO041GTKM+BYNZBJChxEvtnghvIjh/FTNZzpGuc1l5i65vyjtVzQdQBGt0F5GeT8bMb7EQECnksc3302sk6BbyVzfaVsWWcCZ8zjlVoC/kO1dJg/nX21ZWqi6fneDwjoOu/H5VreB677hypT3YkKjRBX9gWT3xmdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by DS0PR11MB7458.namprd11.prod.outlook.com
 (2603:10b6:8:145::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Thu, 2 Oct
 2025 02:01:20 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::4df9:6ae0:ba12:2dde]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::4df9:6ae0:ba12:2dde%8]) with mapi id 15.20.9160.008; Thu, 2 Oct 2025
 02:01:20 +0000
Date: Wed, 1 Oct 2025 19:01:13 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>, Qing
 Huang <qing.huang@intel.com>
Subject: Re: [PATCH] cxl/region: Translate DPA->HPA in unaligned MOD3 regions
Message-ID: <aN3c6TXfD2xs0ETG@aschofie-mobl2.lan>
References: <20250930040838.353229-1-alison.schofield@intel.com>
 <20251001154402.00006f3e@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251001154402.00006f3e@huawei.com>
X-ClientProxiedBy: SJ0PR05CA0161.namprd05.prod.outlook.com
 (2603:10b6:a03:339::16) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|DS0PR11MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 976fa055-b8ac-427e-888c-08de0157945d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tlmN6JD2WZ0K5XGE3Oo6oB255w2yDZJlyvx9kmqI0KxqVMPMnWdFxV95+/Q6?=
 =?us-ascii?Q?7WJQgfd8Dy0bTcg4fZAAOCccxnuK5BwB5I9NNGQSCq3uFT01rCQs5BaMxkzF?=
 =?us-ascii?Q?TbktXV2vAORitq9sACemVnfdx8ASL+TTZ9ktbrbDsXAKpLlTgq8RoRVaZJS9?=
 =?us-ascii?Q?LaTfZkOHjkdxrtmhh7tWFtrN3z3qNZ/A0/oo24ZvvlyvibPUrtmxxROi73zB?=
 =?us-ascii?Q?xVzfyxgompXmmDShOCg20qDKin42CADPyoPPD2bhQ0NNhEcGPLOKTXQpZkPE?=
 =?us-ascii?Q?gX558g+q1bL5FYcAwSwpVB5qPmcT6mM0ydof0C0yN5HwCf/5RIdw1wOKoEbS?=
 =?us-ascii?Q?xJdjhyJZiq/qEGS7thDWFplmH3I7MK5e3fLdZqTqBkME06wyIQ3131r+Ha3C?=
 =?us-ascii?Q?+HskokFAr5ZoUbsssmyXT0YTJAwl/Rzn7iVCkbY42dAh8DK0G9il1Eex0N9K?=
 =?us-ascii?Q?1tHwo0V/g5cQkbRKpfdr1GIpUAM+HRzITMv2zcco0CbAJ9I7lV+OTLmZLfq1?=
 =?us-ascii?Q?LyocYql8fKlCfvs+xwpNSXu3dCeLoYeUl2eUqiqbeoiCOaZOCifza4U1laNJ?=
 =?us-ascii?Q?yE6p2Tzb6OpDvBCfU4+nw+woTeU87sgsxlfNV9Yx3jNwgN1b4CWROYhPIMhM?=
 =?us-ascii?Q?EoHf60kRsJ4hdzYf/4y/JhjQZIlO6HGHL5xkvu6wSAtMEupeiuaXSgy7190P?=
 =?us-ascii?Q?SQ9mB1uFFHuBNxHimbE1XKLw5PU/LhoXFJjIL4NTt2ajektaTkZCnWp3KiW6?=
 =?us-ascii?Q?XSz9IPbIDHIkG8fkHoKtBxUz/AzgAix5kq9gO6S1xyqQocTAe6LPlI7lhP+3?=
 =?us-ascii?Q?LSod5WDK+8gqF5EkkymJiLx+Hhxhab6duI/fEsFE+uebE2MEJ7ulcjC6sojb?=
 =?us-ascii?Q?MyVYl3tlbP6He0iqaQ2+HzQ2vOairsQjgCRHmuVsWxqjdbp8Q4SoE29Ff3PS?=
 =?us-ascii?Q?edP0FAkwbOKJ6QejetDw/C4r0lzkd4xaiDWfupiPVrhm9iiYKnx2YAFM92nd?=
 =?us-ascii?Q?dI6YO+cs7O3jWMKps+6sIq/pFJ/scr+jdiy5SSIMmUTj+XFwCKvfpOPdIn8h?=
 =?us-ascii?Q?OygfMrr+SuV9xe/rN8C+5X/fhraeOSNHTygCBthKcNb1IP+y+xKA8PiTvC+e?=
 =?us-ascii?Q?2Niga6L1I0ZgeJr8I5sR6PiElaAh94PlyHfxNn56jC3nJGAVP0j3/FG8BJaP?=
 =?us-ascii?Q?Y5PGN1G7boGg5/XK0tIUi4W6q+lyDVx+9D/xUuUqAudi2N2o4ZwjiGYPJMBI?=
 =?us-ascii?Q?S1KbnlGA3Zo19jypXwd/EXEsItqBYZ9yGAhLNiwJfECkbkz1NOpoGdRLUYKV?=
 =?us-ascii?Q?Y5Dx94yH0b8GJVepoOo8DorbRzYFIRfUoFmBp2hp7YkL5+UCsW3S7IL7QjF9?=
 =?us-ascii?Q?xL9jD1uz/E+9767cfyOI3d7wlKApMh1PMs+dK8zrMgUu3ZWBsUT1XQ3Ofv1V?=
 =?us-ascii?Q?oMVvtHHBUxFZYzrA8qmWDLWPmcdkovnN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jbGI2eefU6haO4v7Okb2v79cIizB6vewGvzYKSxhB40PDyiLVXoUNxcwZTHS?=
 =?us-ascii?Q?vYRm7evo2w71Dilk0x3XzrG2q9EzFm45k5w6SWdQktu2GcRnIOGrnM+iw6Jr?=
 =?us-ascii?Q?jkSg8mMzd6KFwthULc1WTxptOQLu3/P7FlJGAPSng6FhVo/AXhLVu7yQBngx?=
 =?us-ascii?Q?m+uyORJp2WncfrdCTIMMijahy0dS9VTEcIVP/sZNAn0uRobMSwhySKVJpyC6?=
 =?us-ascii?Q?wXTH3ZaHYDJWGROE1aCxQjQRfe4C+/2r1IO+9/hjUnIwF4b9YRCVWNleUFO0?=
 =?us-ascii?Q?kvwh1YxVI+D11m1HDtvB0niONkZmqPi0va3km2d/YOXEsnhxbNJ42mEb0ey8?=
 =?us-ascii?Q?BRFcn1KNoZuG2SBl8CxYHJfDYn5vPxgdH/OVmJmKrRv+F9/GVQNgbkhseZSS?=
 =?us-ascii?Q?Hu/RObKtn49SaJTfL/q0O+RcpUbeW4uLgQ/SOuS0Tl0r1VhjN9bavciGFURk?=
 =?us-ascii?Q?3GAUQrCmU17ahVEUF+3Zz93nsGvPyfeshaOvDOtb+jgSnGGDEqtSD6PHL3pe?=
 =?us-ascii?Q?iGr1dgWlZdV2RmH8cUKKoi9Uqnj6brxksYXAFmH/f98La4eHOgmOPBk5n9QU?=
 =?us-ascii?Q?hHHWEX7kfcdmGIYVClkatTSe8bswZ62Aq+uZjFX6ifX4HgbQvDElp3d5PQ9s?=
 =?us-ascii?Q?5Bn3QN7Wx9aXDjB4HQ2D6d+2/25PRTQfr79tCMpw2JG79KUdcWDkNjhq3WM9?=
 =?us-ascii?Q?x8qQTvxTKNViGV46jASw5gKu9T9eLXyEsZTFznfjMBF150SlSYVEOQrdBBxs?=
 =?us-ascii?Q?wVKtr+XHBbvcdMH9Fx39OKWGyPkPlKOSOH+wqc3nI6bSVXt0goOrSmD7FIiI?=
 =?us-ascii?Q?2S4UKZrWSmSwuevUFXVTGPsoRpCbjdlDtsafGoBDJDROl4Zy/b+NJ8mwMVTS?=
 =?us-ascii?Q?k7nsS7xTzT4Y5/2x62cQw97z+Vgf32MCqM9wKyXzV4Elv+vsPFMtOBFda5Rn?=
 =?us-ascii?Q?WXDD3netQEThVu7xBzLKpECKP5uS2nJGi5rATGWHrIhn0WgrRMU5x2vVaIvJ?=
 =?us-ascii?Q?kH3KhJ2dA/l1QWJwT2uGbHJAGPUan+izx5cJqgMJHa8U0Eq5pgN+rWEfbgO2?=
 =?us-ascii?Q?MAOS8yTtRuwh/lu9MzAc+x1CKM3eF40meA3X3VNqF6R7tbqHUiiCvC3AOXWV?=
 =?us-ascii?Q?AGdnG28Puy5kGfhlfP3b9qUK7DlD2Du9L2FkEUYzonr9U3Qvr8+YNSn8MkoU?=
 =?us-ascii?Q?AsH2VtXRVooWLkaSwyXPVTYpj8yIVeiHT6/TtMP1ofPPTU8A5En32d/4pTeh?=
 =?us-ascii?Q?itGa1CnV2rMnTOMuSugyoqRvFxEuCXMr/9JQIxXZVzQzxU9KC9KxbzBsk5vy?=
 =?us-ascii?Q?PmlcKnji6/lKPW3lK42ABL3FmvbjdDDGYLgYpVANlY7zdJwj0SA9HpjhNO7o?=
 =?us-ascii?Q?4uDOF/oaO16aQ/fxpQEuT1ynnmcLJv2TU6hXy1XkC4CmIhBFey1eHahXf+87?=
 =?us-ascii?Q?KXDrRmuK2OdW6Oopl6J+Lshq/v9qJlpeZ70pc7oJyCh22fUPlea9mSdZZM6e?=
 =?us-ascii?Q?CFRso3qGTqAiXtproSmTmzijuCbxi4V9BeIQySPy/QRWfPatpFj7wc0Wt4i4?=
 =?us-ascii?Q?qkpPjaDLd7P7VFlqpWC9MSCBvDMUPyNf2ybLYPqH6MAWCgVT2iLbjd5/1XMD?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 976fa055-b8ac-427e-888c-08de0157945d
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 02:01:19.9121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8LrzO4dlPlwkRj6SyJ28yuTr4r3pTMTOOLxx8n3/S8g85TG4M+LbKsu6qt1bgqi2PwIEhlY6+QdKCqIAqRZbJChvUUKydOJWNzCtO8aN0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7458
X-OriginatorOrg: intel.com

On Wed, Oct 01, 2025 at 03:44:02PM +0100, Jonathan Cameron wrote:
> On Mon, 29 Sep 2025 21:08:36 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > The CXL driver implementation of DPA->HPA address translation depends
> > on a region's starting address always being aligned to Host Bridge
> > Interleave Ways * 256MB. The driver follows the decode methods
> > defined in the CXL Spec[1] and expanded upon in the CXL Driver Writers
> > Guide[2], which describe bit manipulations based on power-of-2
> > alignment to translate a DPA to an HPA.
> > 
> > With the introduction of MOD3 interleave way support, platforms may
> > create regions at starting addresses that are not power-of-2 aligned.
> > This allows platforms to avoid gaps in the memory map, but addresses
> > within those regions cannot be translated using the existing bit
> > manipulation method.
> > 
> > Introduce an unaligned translation method for DPA->HPA that
> > reconstructs an HPA by restoring the address first at the port level
> > and then at the host bridge level.
> > 
> > [1] CXL Spec 3.2 8.2.4.20.13 Implementation Note Device Decoder Logic
> > [2] CXL Type 3 Memory Software Guide 1.1 2.13.25 DPA to HPA Translation
> > 
> > Suggested-by: Qing Huang <qing.huang@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Hi Alison,
> 
> My 'favourite' headache inducer in the spec. Anyhow, questions on the comments
> inline.

I always count on you for the bits and bytes ;)

> 
> J
> 
> > ---
> > 
> > Changes in v1 (was RFC):
> > - Replace "/" with do_div() to quiet i386 build warning (lkp)
> > - Replace 'cxld->interleave_ways' with 'hbiw' for clarity
> > - Use div64_u64_rem() for alignment alignment
> > - Fix up a printk format specifier (lkp)
> > - Update code comments and commit log
> > - Rebase on v717-rc7
> > 
> >  drivers/cxl/core/region.c | 125 ++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 119 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 71cc42d05248..4fc0d1450c2c 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2918,13 +2918,115 @@ static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
> >  	return false;
> >  }
> >  
> > +static int decode_pos(int region_ways, int pos, int *pos_port, int *pos_hb)
> > +{
> > +	switch (region_ways) {
> > +	/*
> > +	 * Extract the port and hb positions from an endpoint position.
> > +	 * Knowing there is only one possible decode** for each of these
> > +	 * regions, decode logic is:
> > +	 *	 3-way: port always 0, hb is pos
> > +	 *	 6-way: port cycles thru 0,1, hb increments every 2
> 
> Why is 6 host bridge option not relevant?
> 
> > +	 *	12-way: port cycles thru 0,1,2,3, hb increments every 4
> 
> Why is 6 host bridge option, cycle every 2 or indeed 12 host bridge option
> not relevant?

It is relevant. I'll add 6 & 12 way HBIW.

HBIW	Region_Ways	Dev-per-HB	pos_port_calc	pos_hb_calc
12	12      	1		pos % 1		pos / 1 = pos
06	06		1		pos % 1		pos / 1 = pos
06	12		2		pos % 2		pos / 2

I'll add that in v3 by adding HBIW to decode_pos() params and calcs, rather
than assuming only 3.

--Alison


> 
> > +	 *
> > +	 *	**CXL Spec 3.2 9.13.1.1 Legal Interleaving Configurations
> > +	 */
> > +	case 3:
> > +		*pos_port = 0;
> > +		*pos_hb = pos;
> > +		break;
> > +	case 6:
> > +		*pos_port = pos % 2;
> > +		*pos_hb = pos / 2;
> > +		break;
> > +	case 12:
> > +		*pos_port = pos % 4;
> > +		*pos_hb = pos / 4;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +	return 0;
> > +}
> 
> ...
> 
> 
