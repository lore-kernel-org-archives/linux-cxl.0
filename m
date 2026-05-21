Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3C9242D6A;
	Thu, 21 May 2026 05:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779341184; cv=fail; b=Q2uFHRipalirm3FfuinJFHxosF1vWkZ69Rv7FRP848SDTqYz1t31xH8U1OoXAUH8zCkENYXQR8KD5WQ0IdgOkxEpG13WZ1EAw/BA66r5RoNFxG+L/W2B9N/RiVmXFCrydpW1TBEPQU/JcuJde0b+h1n0Pfge5S12THxkFJfnQGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779341184; c=relaxed/simple;
	bh=NCPxUZbD6qEAivnixzaUdb4wiMkoeHzFgTXrUU/F7kM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KecZ54MZtB8At1yiAnd79K0522+sTpFdI87KVUMDIUKnr5I9vF04NRU/hFkP7IBYAJZ2cIKK0j57pkYWPxcvAu00g+Y32HvpiDMS58FOTsdPTHRUsIXJEFVmqvveoEEIpgWoOfd1fCXqpbvMihs8e4YHYKq9YVE4NKd+15rr6gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLW1WxGW; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLW1WxGW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779341182; x=1810877182;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NCPxUZbD6qEAivnixzaUdb4wiMkoeHzFgTXrUU/F7kM=;
  b=HLW1WxGWwbB/DrHQg9iennLZkh2DsIhbgUQbSA6re2AVFTk8BwudXMFq
   4OfxZF014nUv+Jxo2NZP/XfYZkvc+xwgmatTIB4dxAuyHlZlqpeJAaGVf
   4gDkRAalAkdwUOcmRynRxYrXqWdio42JLzu83hntTLKvEsIsb7zmAVxAE
   vFBZvdqQC1wRnVkOB7O/txVsuz8jz+wNoth28Cc63dB1Myg/vC2oAITr0
   aHIXAqDcy+NL+ZrVOCROV+3+oVApgSzScbZGvFFhT+dadtJLi3nhc97ag
   mLzzSiRfc8xKYRUaGgbAMEIm29IbbMVJsyW1gDOX141tuKwnO44Ko5apN
   w==;
X-CSE-ConnectionGUID: D6biQUraT3+vaoCltUzI5g==
X-CSE-MsgGUID: KUwerD6oRXa89jZFhSTZSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="84109899"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="84109899"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 22:26:22 -0700
X-CSE-ConnectionGUID: HCilwomQSCm2va+olflv5A==
X-CSE-MsgGUID: J5reDRWUTwa2q7TAV0jgmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="245418929"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 22:26:21 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 22:26:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 22:26:21 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.45) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 22:26:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvJYl4bp0OIhgzMebIOXJXkMxbJyscIk98ZXL4g/I/6UaRBqdp8NnzrK5ihz6w/tadsCsoIebxegHEW8MuoTk1FpLHnZIwvpozPkfYFH0ewlNuCyH3JHxf6WaWu4lnBXRcnt8GFWvNurFf2rOMoleZ7pp2NJiqpUPK/+LSPaAC52Z9yR95b2reMbYlTtUnmZcLJTWC+LPd+6qihZ6EPmREn1jPEPGgvM1XM8yVYOpGCDg47zksxuyIvFmqwUqo9TBv58M4YTNK/LB+tldmzCQ8QBEyApX0A0DwFDVePvdCVH7JdUevfxkFyF/H25d3j+RNJSET+6HdTic4UdHQlvhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSDO2BNokSBNfUb0lhr5Ep4j34/srST9zGCx7zPZ4WE=;
 b=N5ZpKhRLdQrL4vwBN4om4q4x/d4VX6wGa7hIYk1GiWriaabkaufItsqO8pw/mnJXvW5Dhz8pKDEm6GIMMRfjcWa8fXKpyDfxZqw8znMEKJpGk/JHlS1OajWkH7CVU66aMFHceCaIo0OVZV4EsLkUkF6rvEy2EfmR7mJsuq2Vb3PrbeB0kPVKL7n1qUlLen00eGxoApF282RbDB34QVdU9CZG3UP+jgQBxoF5g+KNeV5qIQhnNZM/VkFKY70TP60PwLMqmesRPXOFG3i9XRRpmWv0wQYppu+qjrzR2ZP7ZxBku80+bYkeBk9lB4ISOTQvN867Zr5PwXtitoNJ3+N9KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DSWPR11MB9584.namprd11.prod.outlook.com (2603:10b6:8:36e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 05:26:14 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 05:26:13 +0000
Date: Wed, 20 May 2026 22:26:04 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: Dave Jiang <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<fabio.m.de.francesco@linux.intel.com>, <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<newtonl@nvidia.com>, <kristinc@nvidia.com>, <kaihengf@nvidia.com>,
	<kobak@nvidia.com>
Subject: Re: [PATCH] tools/testing/cxl: Align mock CFMWS to PMD_SIZE for
 ARM64 64K pages
Message-ID: <ag6XbPeXrwrymocP@aschofie-mobl2.lan>
References: <20260519233523.5991-1-icheng@nvidia.com>
 <144e80e3-1813-4c77-8c43-1f350f74230c@intel.com>
 <ag52CUdAvIRjBGBw@MWDK4CY14F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ag52CUdAvIRjBGBw@MWDK4CY14F>
X-ClientProxiedBy: SJ0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::28) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DSWPR11MB9584:EE_
X-MS-Office365-Filtering-Correlation-Id: 937bbb4e-c926-48fc-c0fe-08deb6f9797e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|22082099003|18002099003|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: QSwgB1LX4k06ymZH0kHR+LQeYHS0g8iEi70yNvJNEGekUCCBZzCpfOBGr/yaT9/g0HUp44BP3PvnihlmKYDKO7Nw9cheqMD7JryuX6/vun4qxO7xAi/ywLHKDS8xv81WoiKZqwFesOvxRhoTD41DqKFzfTun0x08aISKR24XceHosvQLbJrO808b5OHg2dB2QyWZlynPwhuPrKCPEsWeYFeJ04QVPeSPiHJmLpjQoQipYWFZRvgmKNHYWAmpTagEr4DFILvw9GiTkkBSn8rznUFG2XjdkUzCJYDraE8lkZsAnYH/EMr7swdTsD7sObnyJUHdM2ejvO5Tr1AwHRLvQ/fDcBhBJ18vGxDYOCPTV4Q28E6rZ9nQRbIu+yqqMVsc/8Smnvyoq2mDibefMyF8W2o0W1fwTRk2MnBPREj6d7MRYL5DB5YCeQHodfqoFXwtvYNI8kmR3y1s+uIrKzWSJhX3T4p7R9rMEGjWpcwpSdxuC/L6sbdlSDQ2IbDgsRTFHDw4yecRlYNKN/fv/DoRfllpPQ+IISKqxTmp1N+QnjcC7Ray1GBRSs6mx5Uy5CS1mTmUAQnY05IMJlazXJuEDOT2ePT3plUQJwLh0DFhLXY1PfcrYuIQLPCdavh6zD01/LY3zUlA7su0MWKh2n8yZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(11063799006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RXyzBr2KeT+OOeulrfhmfq8s/pot0Me2sm9evyXH2eV6OFz7hwBmw84iCycK?=
 =?us-ascii?Q?T3AKfnjaDodQ0IJnG4EN/9UFJYyu97BLHWMRGs7xQz0j5oUT7AlUMTwvsMkL?=
 =?us-ascii?Q?wqURLJ0jvCZ8sCqDvKa8Nvbkuk/JlBhIYjX47s9PwzIAp1myKQJ1fniW6PpH?=
 =?us-ascii?Q?fFrJ+km6MuP1+qPlPVTl9zOoC3pvqBWSmb9YrfqGwjKp/WNMOx11YZztjBsH?=
 =?us-ascii?Q?qFL+q8V7VMQiMsfXdtRSLzLHQgzwN306i83lZ7/Zy8PsAPCehDAL8LXdFSCM?=
 =?us-ascii?Q?mnH/hG2WqVPgdm257Uq6zjtUL56rDKvdcl3RebQUSfxJw3KOdJkgDTP8ZZye?=
 =?us-ascii?Q?aRZQB+aKUJeqRucBYmvQvg0jGlb+t7aIAVB0zMUq6gDAKz7Y4NxoDgrVTz/d?=
 =?us-ascii?Q?OC/74dxpsroOmt1gVtajnND77HRo1XGDS8v4TZa/DcixnSN33pvj/IVsx3d6?=
 =?us-ascii?Q?PHoO+HR7hH9NdQMLDh2GjcAfQ+2Es59MzxhQ02iQ/6lpZ5kaw4B6WR/d95f2?=
 =?us-ascii?Q?DJ9H64W+5sriSJ7URjfTwpsjEYy831Xaj/82g/8WLO+8BBsIyravieaNUdVw?=
 =?us-ascii?Q?9UHTZSzsEAF3e7ic/FSQ79ssNWbEDPIFcn12uZz5DwPfBmQ/biuDNFGzwVk0?=
 =?us-ascii?Q?5gADetr0Wo0a9FPGURIUs+QT4+BoosbmyMoBgkO35ApiAaVkXd9WTdTN0gMc?=
 =?us-ascii?Q?jKicWcIw3LARFmtAoCmTyLprz7XEZl1Wn4EMnPyaOvKb8k1vYPXVXxqB2l6U?=
 =?us-ascii?Q?HMiSdoKhOGtWjyLz3oFzdKSPWroyu6LifneNFnEkVesoS6wHqPIKVfO3C483?=
 =?us-ascii?Q?0HFMOU9fn/niBjnBawExxhCFhJF/l+YyMcSnLucSUzdfWQQ36x/nOdaHoxzg?=
 =?us-ascii?Q?pE9axZOZp782HD2kWSZu/DOUIrGEhlPWWjPxpzGlS/6qGtD1llhu1Qm8ntK0?=
 =?us-ascii?Q?ZSU+HIB+Du5Zuc4c5A6EsVyeRP2db2lwzbsOaoaDqt93cPyawD3TiLawxMcH?=
 =?us-ascii?Q?iZiwhKyY52/LhPX9+XOxw3s8GDo3wIH/ivgOzxRf5ZbMRAzo6Rf65upaMcb6?=
 =?us-ascii?Q?pUx1l3Z+IMs03r4lXNfRhd5Hs8GUbn6GVMbOCzR5UzhpUBUKwj3Enfu4dBRI?=
 =?us-ascii?Q?YlJ3gvaq/a5nKgiX3mNdsvjpG7NMsCG7bOpc1ZPIHOycyrnBGiuEjDgv4TxO?=
 =?us-ascii?Q?/hyRfoxVt/dSgDWtVbHT8EsKuEMCJB4Xb60ddskwtzZMumbsHDDl8kiYr3sx?=
 =?us-ascii?Q?l/tRcRvILXB1NedO+YNWsJUSQ5ueJfCrCQIUsrb18PAaGTj2/MXtHhiH1bVX?=
 =?us-ascii?Q?AIUs7i6OL3lpbq4atjlCt1CVIwkpTsqUQwPPkm3Buyd7ZwcdRkBTzla/OH2M?=
 =?us-ascii?Q?0+d9j4PWhVfJP71BOiMtxfONX6DWaM+gzqlfbb+wZkwMvWpsplwqkp8SXez3?=
 =?us-ascii?Q?7x2eXdbJc5Gk2tCq68KP/rSYcFL8/i0JDdvw3byvHBi/ZoVFSOFh5OkGVcSt?=
 =?us-ascii?Q?v6XBE7gHxOcTZgM7m/AIsH56hGwn7dKevNuHLIiF+GoBAeuVZd6lLAZxLVOv?=
 =?us-ascii?Q?EVtbRlR8UXX1FtTn+j8+RvALV9Oi3yD8xrUY3PbC/Z7FcbhM4ShF7fRkNj6M?=
 =?us-ascii?Q?ZhHg5zzGrSuR2Zz3gNdW+8CqmCmHypho1LRaLlmjnn40OH7YyA2blnHlIEMH?=
 =?us-ascii?Q?0ocxpEZ6zscVuQcZzqCYxKt5x4btzoQEeOhmD1L8kSudWEyWi07Ukg0RjS24?=
 =?us-ascii?Q?A8WCbb9XxWV81AvxDTZQ2rySbLvaroE=3D?=
X-Exchange-RoutingPolicyChecked: Ee+yA4oOHdp4ornhI/2rs211QRuwFqLjlgDp1dXR16Ve/3VGILV426kvNb+0HITiWT/MbgXq6/N9EwKbpBrsrEtWG8EZxog6WMwZaXMD/IBcdj5qcKx63C5fCa1yIPYjIvew/N5E6LjiDmxRDbDw3NEIWUE+ejD40bAgzNurzydD2Rk1/avyGfQgkk9GR+0bcrB/33qPu0ROn9kPgeV6v6r1nhtScm9t7pHs2B0GxR18k6jFrMH8QcB4gHzpia6dyhyQAoEwvhacREl1Rdm5oTYYOlUm81waYJ3yINLeuUiXR686OZW9LymEmrbqZR2LnSVP3w/Z8UQCw+hOevnW9Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 937bbb4e-c926-48fc-c0fe-08deb6f9797e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 05:26:13.6210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48pgYq1lBtmGNqBIQ+TafTqndX4tc3sJdj2iFWpszQuyrQqbQQre7EEHYWPQQ/j8jqs17XPm0SWVWg6C5QrROYewh5dxi70v+LC4lc896js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9584
X-OriginatorOrg: intel.com

On Thu, May 21, 2026 at 11:09:09AM +0800, Richard Cheng wrote:
> On Wed, May 20, 2026 at 11:18:23AM +0800, Dave Jiang wrote:
> > 
> > 
> > On 5/19/26 4:35 PM, Richard Cheng wrote:
> > > cxl_test allocate synthetic CFMWS HPA windows out of a gen_pool and asks
> > > the allocator for SZ_256M alignment. It has been sufficient on x86 with
> > > 4k pages, arm64 with 4k pages since their PMD_SIZE are 2MB.
> > > 
> > > But for 64k-page arm64 kernel with CONFIG_ARM64_64K_PAGES=y and
> > > CONFIG_PGTABLE_LEVELS=3 , the PMD_SIZE is 512 MB, which is much larger
> > > than the alignment cxl_test guarantees. That results in every CXL region
> > > carved from that window inherits a mis-aligned start.
> > > 
> > > The DAX driver's cxl_dax_region_probe() then calls "alloc_dax_region()
> > > and the probe fails with -ENOMEM, with error message
> > > 
> > > """
> > >     cxl_dax_region dax_region1: probe with driver cxl_dax_region failed
> > >                                 with error -12
> > > """
> > > 
> > > It was hit while bringing up cxl_test on an ARM64 server with
> > > ARM64_64K_PAGES config.
> > > 
> > > Raise the alignment passed to "alloc"mock_res()" to the larger of
> > > SZ_256M and PMD_SIZE so that the mock CFMWS window is always at least as
> > > well-aligned as "alloc_dax_region()" require.
> > 
> > https://sashiko.dev/#/patchset/20260519233523.5991-1-icheng%40nvidia.com
> > 
> > Do you need to adjust length as well as alloc_dax_region() also checks length alignment?
> > 
> > DJ
> >
> 
> Hi Dave,
> 
> Thanks for the review. I think there're 2 things I would like to mention
> * cfmws6's window_size is SZ_256M * 8UL, which is 2G, not 256M, only cfmws5 is 256M, so the
> population in your scenario is narrower.
> * The -ENOMEM comes from cxl_dax_region_probe() on the auto region, which carves mock_auto_region_size out of cfmws0,
> which is 1G. On ARM64K_PAGES + PGTABLE_LEVELS=3, range_len == SZ_512M == PMD_SIZE and range.start == cfmws0.base_hpa.
> Both length and start checks in alloc_dax_region() pass.
> 
> A region carved explicitly from cfmws5 with a non-PMD-aligned length would still be rejected, but that path was
> already borken on this config and isn't exercised by cxl_test bringup.
> I'll be happy to send a follow-up path that bumps cfmws5 to >=PMD_SIZE , if you think that case should be covered, too.
> Though that's separate from the bug this patch addresses.
> 

Consider not limiting the scope of this fix to only what
is needed to load cxl-test module for arm64. Think of that
issue as a motivating example to create a new rule.

Would something like this work for you?

cxl/test: Enforce PMD alignment for volatile mock regions

Problem description stays as it is now.

Plan to resolve is a new rule like...

Every volatile mock CFMWS must be PMD aligned in start and size so 
DAX on RAM works on any supported page size config. The auto region
carved from cfmws0 takes size and offset from mock_auto_region_size,
so that value must be PMD aligned too.

And to enforce that rule do 3 things:
1. cfmws5's window_size becomes max(SZ_256M, PMD_SIZE)
2. populate_cedt() aligns volatile windows to max(SZ_256M, PMD_SIZE)
3. cxl_test_init() check mock_auto_region_size alignment

To be clear, this suggestion is to limit applying the alignment
to cfmws's w ACPI_CEDT_CFMWS_RESTRICT_VOLATILE. PMEM windows stay
at SZ_256M because IIUC they don't need PMD alignment.

-- Alison

> Best regards,
> Richard Cheng.
>  
> > > 
> > > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > > Acked-by: Kai-Heng Feng <kaihengf@nvidia.com>
> > > ---
> > >  tools/testing/cxl/test/cxl.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > > index 418669927fb0..b40e4bbcc958 100644
> > > --- a/tools/testing/cxl/test/cxl.c
> > > +++ b/tools/testing/cxl/test/cxl.c
> > > @@ -497,7 +497,8 @@ static int populate_cedt(void)
> > >  		struct acpi_cedt_cfmws *window = mock_cfmws[i];
> > >  
> > >  		cfmws_elc_update(window, i);
> > > -		res = alloc_mock_res(window->window_size, SZ_256M);
> > > +		res = alloc_mock_res(window->window_size,
> > > +				     max_t(int, SZ_256M, PMD_SIZE));
> > >  		if (!res)
> > >  			return -ENOMEM;
> > >  		window->base_hpa = res->range.start;
> > 
> 
