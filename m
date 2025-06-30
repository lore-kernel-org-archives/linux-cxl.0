Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19E21B87F0
	for <linux-cxl@vger.kernel.org>; Mon, 30 Jun 2025 20:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751314362; cv=fail; b=BxEhJLMo3gLlPof7MJUwNyG+8zIHrWv29DrdDbyYz7orTroyqnfwNOZLWvaT3KzQpr4/GhwH1vg1u9YZZ8jCw3uK1Pl0POzwW+R8P+QbAS8EWALZJXKoBSUrwS9yFmh+1QFEOTIP/xRwhX0rUf5doheXXOBihZC1//3LBL2niAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751314362; c=relaxed/simple;
	bh=7rPiWKoB0AFRg4dWaT5SlIJzKIuN3sF3SnLLN4mHueg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c0vn1KU+NNlunFv49YwySC8uBf1FO/6rOpyYtxMSBvd4J6+D4c1qqNW4iQr1b236O5n5BAvcNw3z2XZgru+hkL9rmT86UNkPDsThAaIt7iP72IPF2Z1xqUp432MGYI4yt9uwQ8NJlNBqbFLkUfjFszr1rnk693MfmoD9C0A4oCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JdkyLx3L; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JdkyLx3L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751314361; x=1782850361;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7rPiWKoB0AFRg4dWaT5SlIJzKIuN3sF3SnLLN4mHueg=;
  b=JdkyLx3L3776H1L1agcFnVZGCj8Zd79xFBLOeOMBE3jrRBzn9YPC02Rr
   4Ttui9tT4sPO8JpY6DebLUJ/zVXiEhvoyB+hdp5yk9/lnqxtNwORFsJO3
   CeAO+2j6n+QYJeH/qqBu4tUqiC1LTvoD4soQH06OCMfnmeGIn/SZNFBml
   SoaduqRJZdArqe7FyAGg2HCl8ni1hZLqcsphDQW/7yhp9UbpZZ0s5uKYy
   A12e5HUheZjazyTpmeSKKrh47tzYw+JiluIoQo/B+Mw53UVClO+raDhWE
   QkHzK6S/rNUj7d4UVnLiEDJRgpjQO4K/XXaxDBZUpN9EFcNypU6y3o+7a
   w==;
X-CSE-ConnectionGUID: vlE5+mMZQGGCYs6F8mE/Cg==
X-CSE-MsgGUID: IxqOsQbNRVC42X3EXh/hnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="41179478"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="41179478"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 13:12:40 -0700
X-CSE-ConnectionGUID: V75RPeEhS2uTawenevKpzA==
X-CSE-MsgGUID: /o2cnbvTTFOiblgAgpj6gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="153182086"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 13:12:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 13:12:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 13:12:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.47)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 13:12:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drSkhD1aDrQVuRwaN+GPtWVynwqwRuTvaB1guTm84urlpfqRXLEZo5exJhehpCNoLDx8SQCLqyioZzpysLpcr7KzJfZpLHVO8DSFXz1aYMtqZMyW7jZM7O2c0IWykJiqOe4ZXy/LqO1fJci3hk3+42G5KhjLfAaNpRnzQO9+M7VDtvEAhiXfxRQDKQcGviZGYBhcyxh/vVH31hYzqbOU2cuems4FsN+XVQA3eBvytb5n4uXITdIyMF2hA04iRjmswdSFjxA9Yu4sMDsqRc6xw776NyOje6tZC3X5EPPK3TE/4h6GMDzUw/a/UdREEzVqdM8T+jOrOYj19dHKMofMiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNOQ2cW/FIm+yWVZawaKoTWOsUoPRn0OHeqXuItQbfE=;
 b=MWh5SLaGFLr6V3HgMg7B9SSuCvx2GSYPElXw2d612B2H5VQ0MNR/hTCnp+gnDPpDyqsyDyFnJvHbDnGQBzvJOmJUbOVoKDett+To26q8F/VlEGWAZJ38HJtarBtMvG50cz9io2Vna6oN+2Z7gKpyZ+bstecd7l4PClrD6YUNuFvJq1OioMpYT8CT2zOYbbucvPZDsVT30Vc00GR3kMMILb3o1B5vkCa5Zip6ZHJdqMVxTeSvAPqca3og6sMmZHj9s52WzKgJDdKmBIBmM3ByvhFhlZJXsmth9Tgje43U0kKFZfsqYDsxqc6fZbYxpaB7vsvNO3bdpHg8uQW3I5Z8hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by BL1PR11MB6002.namprd11.prod.outlook.com (2603:10b6:208:386::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 30 Jun
 2025 20:12:32 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Mon, 30 Jun 2025
 20:12:32 +0000
Date: Mon, 30 Jun 2025 13:12:28 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/region: Introduce HPA to DPA address translation
Message-ID: <aGLvrPbHdKAP2Zmn@aschofie-mobl2.lan>
References: <cover.1750725512.git.alison.schofield@intel.com>
 <4c4a1a52a4651b726ef66d9020e71e731b74cb5d.1750725512.git.alison.schofield@intel.com>
 <ef98b7b1-0fec-423e-843f-e82281eb48ef@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ef98b7b1-0fec-423e-843f-e82281eb48ef@intel.com>
X-ClientProxiedBy: BY3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:254::29) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|BL1PR11MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: 842557a4-ce4a-4f95-9571-08ddb812723b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uihFQ4yOCOncat1Czhcr1BNIlJz/G760mkEbFY7u+GfQocIUcMj1z/H0s/TW?=
 =?us-ascii?Q?ahCMH0Yi8JjyT5ctyfJr3jEmk4KtaOEOOZh3NitN4DH3mC9477C1/qodnsx3?=
 =?us-ascii?Q?MbNFeasvCsqdu8tPMjG0btskQ33v5M2qRjv+m1wvZuaPswC+viIBBJHQXhhl?=
 =?us-ascii?Q?wKQblIOKfq67gStVKMQ6UrjA8PLoFXM4moGtMCJnj8WCZHbVKqieMOiCTkkg?=
 =?us-ascii?Q?ydGdlaBB3FqnrAq86VFdkeILzhmENfAr473nfU+Xw30JAXYIO3MTP++LDUph?=
 =?us-ascii?Q?q8Gv3F2ISpj/mv/kDHeH18BMtGNoKLp3rGkufEynl8l8CUO/bmHkV0Df84Cn?=
 =?us-ascii?Q?gJwidhai/PvqRmGa448RLv+9Cqc4eo2KCStEe9Tk0YW6MQ7Z+7On0kNSZl5J?=
 =?us-ascii?Q?EN5oZXcWS3p8gjikTf+20XwU/c8h52OvcJOl597xT2JBhjLxoJnnch9MtYwu?=
 =?us-ascii?Q?s4wRQw8/IveF3Own22NeLJV5d74Y4Kur3f+hXvqIPr4u7yGId0NCsD4xZ0PN?=
 =?us-ascii?Q?dal4jRUFhtp7zSeeR4xkfaD4w267iZyKNOKqJoUuku5Yuh9KD1SDo9MGq5Pk?=
 =?us-ascii?Q?PPoq4Vv67ZvYy23HVvYsuezHEy2uPGIQf9AKMQ+n5i85PAWPioFqMKG88Yel?=
 =?us-ascii?Q?2sBFiwvGelt8ivA3iSXqm0Xq0yb9hTB8dhTcSNcpi8tAMTS1PjvuMW/wMaTn?=
 =?us-ascii?Q?+ykrRw8NNrKs14zn0d9Z4f/Rr1PoEU3kPJCAd1VKaLnj8nWg0NV1Nlk7ZmCO?=
 =?us-ascii?Q?1Bonj8oRgtej3JI84Ia+95oBQOza/lBf3b8V0KkxSrMW+6B7Hl9VZpyTc+Tm?=
 =?us-ascii?Q?CuHJ/AGiPGQ4YhiSaWw0e3PJ4z65y3rrQ2yF7yrOx8l85bHXmrfzt18k59+h?=
 =?us-ascii?Q?2TVw2hxDt92p29RWn06p/DlgNzA5XprAIg1HY8oSLDyupLWCui8ttG2hfX5w?=
 =?us-ascii?Q?OCzhQ86Qb626JHEnOZe3IGeRNNMPEnxmhppXjvVnqGn9dODy5WpbmgSjfwzc?=
 =?us-ascii?Q?EeOE6MyHENYNHJYVDilChUZ9ypHqdBvc9sfGb0oa2C1wy5nCjSzj0cmvbosJ?=
 =?us-ascii?Q?gX8tdLIqEenyvhzbuQIagiTmBf3qkE6Yoa0YyLIseb6BrDxqBHcWR4uZdgUV?=
 =?us-ascii?Q?qCgC7VaWIYblMXF7ao9/gqVLTGkedpq9plE0VTPhZZ0kBcDrzXMv5/seU6dU?=
 =?us-ascii?Q?pUMuyHwvmJM/TIjPUpFLCfcGT0t4B88DvKc4HdwXjb+JaScrgeIxRLA8fbhv?=
 =?us-ascii?Q?mU27hVtx2y0aVaAMNuEL8wnzSjmZkXCvBay8AUt3yTNBoEv+uH+PqF336r0m?=
 =?us-ascii?Q?lynV7T/bcQVqHXtp5qNmqZCgt3NxFRMPHi0HQ0uozxCM+fpdt3AaCY/r9HFj?=
 =?us-ascii?Q?aiDOJnldNjIKmgNwFadROQOtqyplUs5+zF0DbUiYu9eh3kgijgTXUpaFc0J9?=
 =?us-ascii?Q?ZCXcDvvqTH8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HnlFtXQKCcvX+oh1MMyVzF6LopNmEv71q/jSOH97AdwM8tldmOLV2wpJIZ5h?=
 =?us-ascii?Q?9Eb8LY0i+Zf9KTtxEYHDXgdrn8euWkbzuKIWRuyDVVpU3N8mmutVAYNu0l+t?=
 =?us-ascii?Q?4MLqxP2P943zEbjmsqwLzOQGTOvQeG5p3bUi1/kWa4oXWEcReigW2dnpsads?=
 =?us-ascii?Q?c4Oe7iDoboOerTl1TcMDthyDJTPj29ZarXjamGrHtXG9kQFcOF+wd2XhIyRd?=
 =?us-ascii?Q?RfSDFZhB0C1qVLmtTsC7KINP5uSrc6LHb1IlMKIkEf/GbDmCUu8SIcpPoWMv?=
 =?us-ascii?Q?BFOi1adBXc3ZF0y3kXQdfJja7C3vVmRJjLkzEnGI+6a0C0k9OuJ0lNTuEFzW?=
 =?us-ascii?Q?CsLBvJUcvm44B/w9Q79YiRAQTAOfoIJV8cl7TEvSQtzqEScDHwTI+i4Wrzp2?=
 =?us-ascii?Q?KwJZU0zw+go9R929Y9jNb2fJxRbOgh7iX5Tm81f890vaszIDW9Y+DdLIdhBL?=
 =?us-ascii?Q?2WJn0JDwrF5/KuCCKrlo799AQxaEelLwllBPSi5N/Cr8zHns78otl8fH7Cgb?=
 =?us-ascii?Q?65vP7di1k8KXKfpgaZ8UOnOvaqveDBBiMu7IzzRak+KFhyDA3ZDZoFFac01U?=
 =?us-ascii?Q?eBmiAXWR7EivR13M0P4NZ9Sb2FhDqWSOUWnl7IBMlfSOMQLWCLVBubIRGymi?=
 =?us-ascii?Q?bCZENcAcadOIDWR13NWzl5XjnEjO8T6TzuqEuG0YyJUr470zCoxV42qCgfvs?=
 =?us-ascii?Q?GWIl2l6/bdrlaz9cYCtbkxqg5+6n7SJ0zyq+BTkIEwlC8sz3+QptNL40xGqH?=
 =?us-ascii?Q?3HxWGyvmL+nVtQmjCZM4n5aSaD9r1pQLhSpSpLY9ZHTyOMDFjl5V1cBbTpAA?=
 =?us-ascii?Q?ZCxCbV8iJIWAOBZn59LEs6XUrr1RwCfmH0BBxCigtJXqdMb6s45PA0crE31C?=
 =?us-ascii?Q?g+LspjP7pf/rdQHejbA/XQ1Wob4pMBve91v12cR2OvqrJJcq7Ce16qEYZkVz?=
 =?us-ascii?Q?Qr1y7sQXyDsioGLZRuby0/NR8C0w02IfJVceXGTXRIPXzyIQ2vv+DsBwB1lU?=
 =?us-ascii?Q?OveUVFIgc2vPt8aDAadHWDAIqNMyfs6gzudWxzgA515cZzVXGnn6yYuEXdQv?=
 =?us-ascii?Q?tCS4xsomBCzXgd/k4sem/28B6TXPU16c7Jhgl4pvf7MhloJEu/sP+ba3VvK2?=
 =?us-ascii?Q?2zPVF2x1kR/IIKbjm9eJkJUPogx5mNqTD1uVibcABn1ME7uGSaP7ZHf4sfAK?=
 =?us-ascii?Q?qD/CX8HOVkVTMs825lcNAHaWmJ+SLoadVpBJObkcXuUfQUaZc8eZ6CSxS6YI?=
 =?us-ascii?Q?MB6jcZfJOclFdUJAWUxlwT/BNbe8hFY9VcuNruH4LYH67IDbNHNsDf07Fnk5?=
 =?us-ascii?Q?6LhPGTIni9iOUnC6o4zHBNHmWFFM2xEzaRwGR+TWTelc3cQj3xnp379FKLYw?=
 =?us-ascii?Q?DSdlxK8Ef6wyp5fGzPLFD47imi/p/jlpc3pOd2l56xzyCRf5VNTSryPkVfYY?=
 =?us-ascii?Q?M1Hf7Xn1CaqCVjbZoshe0V/xySKZGTFMF8HWAGea5mNEYHEFUSf2aSRYH2hq?=
 =?us-ascii?Q?w/qUr7VUm/T+4aZ18AYCgXeF+b5twOTqxE0pd64T2uAUlhKJ7h2wGp1T9egF?=
 =?us-ascii?Q?nAABQaYLl6M4mR/zJDBcRq3elFUqvWoy2sdvZknwn2yzH6xkag6yEeuQPm8W?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 842557a4-ce4a-4f95-9571-08ddb812723b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 20:12:32.4203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCNsy63KCsty2cZQ4MJGMpUMsT+1YslpFRjdziVVOT+Em2KL2eLVGMtZx+qVPGhHM1vrZm1XYW0ph/Y/ca2P7rTthxj7b1S0ok84oO+O0Ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6002
X-OriginatorOrg: intel.com

On Wed, Jun 25, 2025 at 03:49:37PM -0700, Dave Jiang wrote:
> 
> 
> On 6/23/25 5:53 PM, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Add infrastructure to translate Host Physical Addresses (HPA) to Device
> > Physical Addresses (DPA) within CXL regions. This capability is being
> > introduced for use by follow-on patches that will add poison inject
> > and clear operations at the region level.
> > 
> > The HPA-to-DPA translation process involves several steps:
> > 1. Apply root decoder transformations (HPA to SPA) if configured
> > 2. Calculate the relative offset within the region's address space
> > 3. Decode the interleave position using the region's interleave ways
> >    and granularity settings
> > 4. Identify the target memdev based on the decoded position
> > 5. Compute the final DPA by adding the decoded offset to the memdev's
> >    DPA base address
> > 
> > It is Step 1 above that makes this a driver level operation and not
> > work we can push to user space. Rather than exporting the XOR maps for
> > root decoders configured with XOR interleave, the driver performs this
> > complex calculation for the user.
> > 
> > While not immediately apparent in this diff, broader examination of
> > the region.c code shows that this work is basically the reverse of
> > previous work where a DPA is translated to an HPA. This is notable
> > because it demonstrates that these calculations reuse existing logic
> > rather than introducing new algorithms.
> 
> Are there any public documentations (or spec section) on explaining the translation you can point to for each of the function segments?

Yes. Will include in the v2 update.  Also, as I mentioned in reply to
Jonathan, I've backed away from the just reverse the dpa->hpa
messaging. The reason is that the spec defines exactly what to do
for hpa->dpa - which is what we are doing here. It's simpler to just
look at that, rather than to reverse what we reversed for dpa->hpa.
Clear as mud ?!

> 
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/region.c | 85 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 85 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 6e5e1460068d..d2d904c4b427 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2972,6 +2972,91 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
> >  	return hpa;
> >  }
> >  
> > +struct hpa_decode_result {
> > +	u64 dpa_offset;
> > +	int pos;
> > +};
> > +
> > +struct cxl_dpa_result {
> > +	u64 dpa;
> > +	struct cxl_memdev *cxlmd;
> > +};
> > +
> > +static struct hpa_decode_result decode_hpa_to_dpa(u64 hpa_offset, u8 eiw,
> 
> While this is totally valid in C, I'm not big fan on returning a struct. The compiler copies the result from the function's stack to the variable of the caller function. Can we just pass in the addr of the caller's struct to write back and avoid that copy? We are not writing Rust code in CXL yet. :) 
> 

Done with the func that remains in v2. (One got folded into the other)

