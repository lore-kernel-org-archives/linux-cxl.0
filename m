Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ED03C463
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 22:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737672249; cv=fail; b=ipU0gsN6nWfIF+P5HQD6BiDYnohuRYEcJWwTGgqbxEUevlPyF9+EIZaTevCrR0PmRIg2kqkBqjQG8s3BSLD7NdU2eE7X7uZGzzr9GZrmgQbMnyrw3Cd54NETMR/FOAUKDWmFWTR2EroO01vCbPFjLWCUUtyzXUDunVXqi/u1NxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737672249; c=relaxed/simple;
	bh=D6XX3xAD6CQofRqIXwkfNocIhuBjo6E7u60X/sxZUXw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MveieB5/qUjCsfDio7KnfZ5OPejdug+kbskJJNURhVbC0O5WH2Vj/TaIVmuQ/Le7ZS0Ox7edJdBGLehtd/ruNhHY8OyC+4HFolqMzcIhR06EtXVB4ZSW26BlNtAYZk7iiBhzh4BwhRQA202YRrNo0Z3Qkg2fxVAaaiFfpI/FnQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KlC7bCNL; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KlC7bCNL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737672247; x=1769208247;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=D6XX3xAD6CQofRqIXwkfNocIhuBjo6E7u60X/sxZUXw=;
  b=KlC7bCNLRorZyLAirnEdX/NiNrL9pTMQhimIdu9UlWrpl1xl0hn9foV2
   CERJ4jlRmH99ulmvmSgHzULXdKDZ34VZYK8R9WUlqQ5jQ7WSXJnA95wSc
   aJSAPLMKtlYweNzbSpTzx1c+xzEixhQVOBZlKsqDXOMGEM03sgu2kFz4w
   10pPLu+sOIrWPUiwk2YjWYH1sMiKaJc5Tw9yI/9QCHAWeAf5UTy1/5mKV
   ra1q/vW4wE5fxiMBcR1P19xkRj+f0ViocmwW1D249OWvcdnzTEUx7/AtR
   3tTH/jy3N/E0/+BLoWeYu6bgDiu7hSzY+qjhaHYVY8EeJuCYdVMI17ii4
   Q==;
X-CSE-ConnectionGUID: dV6gF0EzQ0mR5gPfxZLAOw==
X-CSE-MsgGUID: X799VkjrSZOxjdxGY8hZ7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="38080693"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="38080693"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 14:44:07 -0800
X-CSE-ConnectionGUID: GXg/ujAGQmSm4cU5iECFmA==
X-CSE-MsgGUID: gxZ/VoSkRMm4e0jChB4kmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111633080"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 14:44:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 14:44:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 14:44:05 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 14:44:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXRJw5MrZ3NC8yTOnqyTo/diVK0fCT3CqVtZQqnMayb35D292/T7xSm68N6vNEVK2iVTG4T2qwKGtyg/X0g+fjy3vFdUpkP2FpFXCWiIMWe1ln9PC7Ke6/YfmSw+zC+yQKN5q5azrg9+oVK7WoGIHik8VC6FTwrFojF1E6gmXeEudtScz08U22ClSmtoteZCIvspwz48ZAjtTb8l+csj/Wm4aWAa3eyhkiTrriXyln6OA7G/vz3p0iZxJGTzpHkyc/FSQ2D24d3FJLqw3SHrbyHqBK2HB3fko4JnhulgPpg2eIxqipCY5lzUG94D/ZEqJNu6jixmapnmLl5NQEZqdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6q2b12mThrxdHRwh9EHJZURn1FLuwZKejiaoWNEhTlI=;
 b=XkaW413yf20dyFlSYmVvxZodMUMq2+KHi4iV/2IP1h/tZnU9Q3mLnvFF7Co2DuafdHB5cAdtlErri1DcvE9Pfeu7OCxbfVMTpsXSZmpw/biYKvzO8y4iHOVycXCu4f7ZTal/GkTgTVgT0GJpOpMc6b2d7L9ukkIEtRdKMZEE+rzVmgZEFiARbUuVcbwhuj5oaIzUVJz/qet8SUmveQT4JokUYGA3sg2QykAI3CnRhIGjXuSYNwQsw32b1oxv8FOv9Tw/DSIkl2pYthSJAQpnkzOySz4JQdS11jjaKUwWeqOsXg9sZmmCzrZAcPrSa+LYeFKAhhrwMj3aeQwOmZAp6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6955.namprd11.prod.outlook.com (2603:10b6:510:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.24; Thu, 23 Jan
 2025 22:44:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 22:44:00 +0000
Date: Thu, 23 Jan 2025 14:43:58 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 3/5] cxl: Introduce 'struct cxl_dpa_partition' and
 'struct cxl_range_info'
Message-ID: <6792c62e340ad_20fa29438@dwillia2-xfh.jf.intel.com.notmuch>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753636727.3849855.464861650807086965.stgit@dwillia2-xfh.jf.intel.com>
 <52174ecc-40f9-82e5-1925-dfa1b7c968da@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <52174ecc-40f9-82e5-1925-dfa1b7c968da@amd.com>
X-ClientProxiedBy: MW4PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:303:16d::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a9da599-704d-4007-f3c3-08dd3bff6de3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G+GqN2HWvzYX3HLfHDy7+zUkza6WwiAEqLgO+nTXP+JJkaUz6Q8aQQFu8xi5?=
 =?us-ascii?Q?nrXIMM8Pi5JXot+mgauc9jof0Yud8R4SRObV8PsDl5VkrETLu5sdKgLeV5rf?=
 =?us-ascii?Q?UkTSduj7EILYh8ThbhKfBAl36UEz7In+Oju4t6rGCCVPcH0uXiHOfEvvBpw1?=
 =?us-ascii?Q?VqAGhHDxKSmE+527owDoCypEGRSvlA09rdyddsSmUJMpfe1TvYbaupSx2CI+?=
 =?us-ascii?Q?MfhF85u8Nw9xqq70sj2EBqfSjmPCj4dfODLWOCHO3f7aIWXr97HbooZp48Tx?=
 =?us-ascii?Q?Uc9IRfBqgOEh0rTBB+1QiR7a1IseHetI3z6SoU/zGJhFfLCyAxB8GezxLvWW?=
 =?us-ascii?Q?GEuRQh6mJ2xEsd5+3EjTsht0IBZPqJ37/a0mZrQfP+ctUvlF7EwflJ2mH+Q5?=
 =?us-ascii?Q?jtc71I4BcZVv1sLo2ry5revOpxJws7LfqT0P5/z0N4RP+9d6BkiZ1ox7CH8m?=
 =?us-ascii?Q?aXMpvmqjABml1h7TqAdtdkJWplMuONi3yMEZ6TD9dbsFwNu9fz5jK3LrCpAY?=
 =?us-ascii?Q?Mqsa9IuMa/30KSumVeFFqWtVr83E3Kq8k5dF3feV/x0y74vcz7JpnyhII/J7?=
 =?us-ascii?Q?LSe/awBuSusjyxSsNJuoEdek54KKSDFH85ADlG+swi0W66kH+qTkTk/fPP1r?=
 =?us-ascii?Q?pXlOHrjEAB9OAfPv1YrC91r4H3oBub4N/YK6yrKgqa+2HtfOwKnlPXnZeIFl?=
 =?us-ascii?Q?ZIbuJbMEm7N82kZ5j0ifuibYb4crIHBSfFTnHB43ZkcEHBTVkIa0n0x+Ppyq?=
 =?us-ascii?Q?fYJK4YCNLUPJfVBQqCaCHXE7uCINLPmzzygUr1/O+fNaFlzZVVcmKOVWIifZ?=
 =?us-ascii?Q?kiqWyPBdXEpsoSxEJIV1EGKZwBJKn4fLOSKj68RdSJ+JvdOJTvJFXfoZ3A4t?=
 =?us-ascii?Q?zZ15GFx+JAMRGfwMjn2rusu01A21m/Gnzl0fMBRy4PUEajLNBiSAT7d45hwH?=
 =?us-ascii?Q?Q6ze2FfcW+V+sFq+d/9ql/2JhlHO5z4o6nPPFeZmhjaoG0L7c7d9NbOP4ahC?=
 =?us-ascii?Q?82Sp7i+0GozExpt1HJrEL11feDEDT99/3ZH9suuqHaKGYvyfC1gTJlzMqTUx?=
 =?us-ascii?Q?9OCpZbq8B2YQrFPZXZht/2h6T+d0GjCJ3mUe1KjyLXAaF9Xysjk5/ydLOlhy?=
 =?us-ascii?Q?/VsTweiJ3MMGmOMb9X9iXsXPuA6NQLdViXDNYnrH8DwS8trkPDHSpW6qMd4w?=
 =?us-ascii?Q?PsVn3/VoyNCu68MlC//mhrb25FKBY4E0Xa5QH1fj5zP3IWW391vfWiIHlcGF?=
 =?us-ascii?Q?7UmxUjMR9RKfNuKKBoK2X2I1oG4t2FUtkuFf34Vx0/O/JtjtWwgX+k6aa0Qf?=
 =?us-ascii?Q?rtyUvj4HbHy9pdCvySi+DIXc1WJFgYVqcqMiCIyaC/GnsKfDBBxMdw2MoRiW?=
 =?us-ascii?Q?ElSqWd0NF6JpUrWPNGq7XrAjgqIM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MZ7mQJn+b0ajUl+VXpOjqvbUsjseAAxgbyS7ZNAN61aksBLMZdqfbcr0Ilww?=
 =?us-ascii?Q?lr1jTqMUzd1OL216OEkCXMHcfnXA8z1TzxV6l7JLZ51DREz0i3I339FWDaLg?=
 =?us-ascii?Q?CxcPYagqzexEnRxZzx9p89IR90W0QjKJBSOjNT+mFl2jMYb8fTQk1KFOPkyz?=
 =?us-ascii?Q?pr177K38nBa6UdKr5fRraOq6jWECRxkolR5uzs2JZXTZmdNmfQ5ux+j/z0bB?=
 =?us-ascii?Q?TskQy/d3MsASC3YUCeOdQ1jDmW0vKpWw48yvWFqLJEpq7THecfblqPzQLnfn?=
 =?us-ascii?Q?wOMwxmsk2AhHCPa4dZ9GdudiTe2l98JpYDluYmwnXBhiinVuWwW89z4od0FH?=
 =?us-ascii?Q?qExah77EpOVw6bTDkNSM18rPQ6qye/+OHozDyM9vTORngky9u88bkl3ynbhJ?=
 =?us-ascii?Q?nwKM6fopZX1A61509y4hlvV24FBu2UhRuefl3w+wfP1ec/8BBRmj8eZQH8nQ?=
 =?us-ascii?Q?zKaTo1P5oFm2ZpSel4aq8yeIIj7pIa6gJnQWOJrLN213kraLVKJBnnem6EXa?=
 =?us-ascii?Q?q8+NjTU6gWZ5v/I0PDVtyqGal8Tn6XagNLrBlHzeQ8ZW/86qNC8npUcRpTHh?=
 =?us-ascii?Q?/TeZT5hJulSHv71XZi+aR1LNLEE5imODnmfnRiPWGgslLQr8GFv6SooD70xx?=
 =?us-ascii?Q?SIvhdRBJd3q+K6Rs2FqfWYJW9rmpDROoIG5E0qKq1HamUpQA33cB5RdqiTbv?=
 =?us-ascii?Q?hL+m6aNJqviUmUWcUW2H/qfxmd4MDiC8g1VBqIGiED+uyvUOOMqPsPmmCFCz?=
 =?us-ascii?Q?Q08OKHkp99LSRAuJ4VvJ8pu2JFVqBF8J/FTSIk63pjaKb1Wj5klyEd9ZpkUL?=
 =?us-ascii?Q?9R+Tfqwo5n433wPcTVvAzSIFPzvQPjBsfXsFxZz30FM+jWB0lRYsFyC9YXEb?=
 =?us-ascii?Q?GMuBr6mmaBGj5lhi3ocef9pHlWcQbYql5rJBIWTGiwTRdwCBMwVCOFQv6TFw?=
 =?us-ascii?Q?5BIFl4a56d/6N2zGt8mFnHJFenPEcnbUkKmZ41TvpelpTlA+i6/IrsGpjjHR?=
 =?us-ascii?Q?U/Ylt3cKuKK10sbUFFStEsQzsYOXI3bMfQyGGGcftgDr/viwosCstS9VLNB5?=
 =?us-ascii?Q?Dl7Q2SU8HqGuWim4pcIY3QF9JKCYQFUH3YYw06BU01vCxOC97H6PNmnC3g3I?=
 =?us-ascii?Q?f2HBbX+PiKAgFDo0KiEU0L4hyMKBt26Dh/8482Lk/9c2cQ5t34+JdznsE6H/?=
 =?us-ascii?Q?Jymgmubhb4ShkqUXcsMX3exwRmFJPF6XGrM2tvvHBz6tu6Hw9CQyIX40KGDy?=
 =?us-ascii?Q?VY1RzBHnjTQVvbEs5h17xbBVLxImtstk/RNNKET/UMu0FS3PYw4AeHetN+L/?=
 =?us-ascii?Q?wh85lfZnG4kcyLRI+3LTdrVonaVYn1/1AXH4pkfq97NJdDNqc4zKqNZG3Mh6?=
 =?us-ascii?Q?96T34jgnghVYfwVg9RhqgQZ/zScoLqFEpAbjZ8mFdYLNp+lpMybHEv1wVqrk?=
 =?us-ascii?Q?7xVyx2NKmqJKhN2W3R7XUVWjs6etQHD1X5wNQpkhZd0u3bG1yp4+4NwNvPYy?=
 =?us-ascii?Q?cVp3KBYZU/7CPeNT1ZGCBdSKkXfOOXOPDVtDsI7GdLRfmC94ZEDRb9nPCC9y?=
 =?us-ascii?Q?kHqWaqKxPlNG6LbNSyK4NxP3QTSQPocTtxPjN+SF7YG9TxDO8hGgq9NBAM7J?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9da599-704d-4007-f3c3-08dd3bff6de3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 22:44:00.4325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGwgiAKRF78gCV5LtKArcUqZwXOgkrMTAQcLh8XJJnjEcbTRdQ6mKvG/qryVkL5VGVGqnjwEvIGRUBgcqC78FIn6H9qIXovuBIrldrO7528=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6955
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> <snip>
> >   
> > -static inline struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> > +
> > +/* Static RAM is only expected at partition 0. */
> 
> 
> This may be seen silly but Static Ram as SRAM has connotations which 
> could confuse people.
> 
> Maybe better to use Static partition for RAM.

Without the DCD code upstream even "Static partition" is "confusing",
"what's a non-static partition?". At some point people need to be
trusted to have context and share in the responsibility to resolve their
own confusion.

> It is far more concerning to me though Ira's comment about how can we be 
> sure there is going to be only one RAM or one PMEM partition.

Simply put, we can't.

Use cases evolve in unpredictable ways and folks will show up to address
those new use case when they arrive. I do not lose sleep over it due to
the open ecosystem, and in this case, economics:

- open ecosystem means someone can see us chatting about theoretical
  devices that complicate the implementation and either chime in and say
  "we have such a use case, here are the patches", or "it looks like
   mainline does not care about that particular degree of spec freedom, do
   we really want to go there with our device?".

- on economics: It is hard enough to get developers to care about NUMA
  effects let alone heterogenous memory performance within a single
  device. It would mean building a complicated device with heterogeneous
  media, or mixed memory controllers. The Type-2 series confirmed that
  single range RAM accelerator support is all that is needed for now.

My bar is "as simple as possible, but no simpler" especially when it
comes to user ABI extensions, because ABIs are forever.
