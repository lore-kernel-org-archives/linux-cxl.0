Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B2E14A4E9;
	Wed,  4 Dec 2024 03:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733284543; cv=fail; b=si8TDg0VyBFg/3zgJ4spPOq/fWqsduR4wmP/stnvHFHZUqsFFcyyMHhx1A/ilS3vVh2K5/rR8UZv5jSxCgzAf1xnKH1gPQfpBFOPLyqEnQk9pulQ2K8tGKr8O6C+AErTEu8cS3A/NcHAllKkXUxPkJ664H5SphdltYxnV2KvICI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733284543; c=relaxed/simple;
	bh=5IjA5Uw7fIsX7Db7fn3tJvQ5Nou9fYnk0DjQD1EdxX0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mC4SKKf/b7rWqkzpL3ZoYHpXwh58we+DDxUETggFuMJD9mix8Vp+FxR1qbpg3CnPUHaRH87+GEE25oTKBxQVCtXR6QomOGvQnJmr9XrnfwoFwsF3BJo5oIYERKk7PBiVPRXudcOLWKN0g321bXLqtRultHUfJo6D5q1F32MbZaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGYhx6+H; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGYhx6+H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733284542; x=1764820542;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5IjA5Uw7fIsX7Db7fn3tJvQ5Nou9fYnk0DjQD1EdxX0=;
  b=mGYhx6+H+DQGY2vAKc+aRj6y24I1hcYduUvQrSf4xTrsHD7zhl1x37Z8
   txbk9AG5XiUVpj/5JSPVbnA08JpnCV7kG9RkgpWQeXWpKtk7od2QnBnV9
   HYSEbMfbpPpTeBEdOBvLFnODRXpVqIVZvn9yonK404mExE6ISW3+ULPgD
   VMM4rzuF2+zCDZtoFc4j51PVY79Wd7Mox6R8bIS0Pa0TAzbrWe1eUCuyO
   eBNjxFL9L3hHt7pQle8V6HxsscKk4XhuQjfcIY26miDpPpm+34XzswfJF
   vxtR3/+/tkjOwk04Gl+SKArznlutLSveY6mPjkCy2UbnSaxoJav0vxlWi
   w==;
X-CSE-ConnectionGUID: 7WeqWbCsRKySBa9Uptlp3Q==
X-CSE-MsgGUID: dod1R3zDQ+S7NgMEIdTUnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33408186"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="33408186"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 19:55:42 -0800
X-CSE-ConnectionGUID: jPQkhlQGQte9vl/WrO99EA==
X-CSE-MsgGUID: pUHmwadnQdSHaMMfWEziSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="93302469"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 19:55:41 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 19:55:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 19:55:40 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 19:55:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmM/xnQzcfTzhyt2F/QG59tri5jiJ8IOAAXaHukoyr3PfwLjRjtwhjluSyuWxRnd3ie4SziVkglzLbiQZlGVEKZ/WMW3r81moca39E1yeibwMleRbkVG/qQfQkKpIff8cj3ikl5mJjWvopDiXFZid5aVnt4Kz5hwVU8qohH1MwPSVLOwviLLVOcF4GMicJVO+veGJ4cmVF0JIExOl5v/6XEe2wXKqoKUYsN47yyXpSX6iOgfsRi6mfPHm7PYKh7LLyI/fGtspshIliwboGjoD8maQIHi+KsiiIXqJVqxBAK5PZAn4dJT6wz8PXZP9W9gCcwe6sKrz0KMzJ3KATylzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPijDGu9/s8N+q6moVs8V/+ES68sacbJmqRmtsZAbdo=;
 b=TfBwyurSYIaOULs6aryhovoSMsgtd0el0ibkXCotpwIAlFfbIZP/CVhVg0QyWb+5bIGuWrts7YvthuuQNouegv7uTqhf0oICrUTda3gFfqAZTou/rapEuZtHFLi+XU87RgoBc+FdxLbp6cSokxZ8+eNr19xKuTIgB+Ifz1QbJKkqNNdyMf6O6Xa/g976MrH2pUSxHjCmDI+bhuzg63NNb8BNXTNmknOFRO5yu/MeViWpa4Tj/Qa4GaVe8WYHLBqrKOXh/QIHS0dgy8yePbJ+UZ2lP4VumeaJECW3RcngZzm9ZbJEWqnpVDCHV04EqxGrKmkSGsxty98EHvCmZTLtJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4818.namprd11.prod.outlook.com (2603:10b6:303:93::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Wed, 4 Dec
 2024 03:55:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 03:55:36 +0000
Date: Tue, 3 Dec 2024 19:55:32 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Raghavendra K T <raghavendra.kt@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: <bharata@amd.com>, Raghavendra K T <raghavendra.kt@amd.com>, Huang Ying
	<ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "Dan
 Williams" <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Alistair Popple
	<apopple@nvidia.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Fontenot Nathan <Nathan.Fontenot@amd.com>,
	Wei Huang <wei.huang2@amd.com>, <regressions@lists.linux.dev>
Subject: Re: [RFC PATCH] resource: Fix CXL node not populated issue
Message-ID: <674fd2b4942f1_3e0f629420@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20241202111941.2636613-1-raghavendra.kt@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241202111941.2636613-1-raghavendra.kt@amd.com>
X-ClientProxiedBy: MW4PR04CA0208.namprd04.prod.outlook.com
 (2603:10b6:303:86::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4818:EE_
X-MS-Office365-Filtering-Correlation-Id: ab386336-6beb-49b4-8444-08dd14178274
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ITnAief9lBc38eiyp+xYUZyrkef3uTfHPhe192Ai2hiIf4uAQ6S98PVgFTfJ?=
 =?us-ascii?Q?CtDCSfBmmxWGyFSMrwm2sTHi81Lqj0pOvYatilKNV5ehkcZioDTxxc6DtaSz?=
 =?us-ascii?Q?fUhMp9ufCW6MFF5i+NHHj+O5eFfc8eGtHYhb+LqL6+0PsaQozFqZZ80Am+52?=
 =?us-ascii?Q?xA7z8I8SvseQiNZbd7UO/kk8tNSWG+IYyC+JTg1dOhbCMfzaGM/hvAJefhCi?=
 =?us-ascii?Q?cr04Hid8hLkNTulxabj9OYhILmiDZVEOdcmkl8AsmagssrmyFbGo1CaGjhmc?=
 =?us-ascii?Q?9PzRfPmUUveksFPxA5Fliq00WrAtAe2NJOj8+59leZU9CScqUtkNEe4vMB1q?=
 =?us-ascii?Q?a31v1ieIv+hpEr6nEa+3O59IbRk0LEHdU0ON0L5kNsa9gFxtFjgCVTr5Ve7/?=
 =?us-ascii?Q?AXVf5hbSeiSjNovS20KeprCWhQBN6IWKK6oBz0YZeHRNiMiQnU3Nyb6AeDEf?=
 =?us-ascii?Q?rDQWC6EDWk1mzrz5jmyLPuAuuI67EtZSw3m9dHocqe4xiU0GvZAyDYcsi600?=
 =?us-ascii?Q?9CC5Z+yKKMkiUqa0HB6HLgni7G5JezUJBsg8kL27Lu5oN3FLIMSIL0+ieTes?=
 =?us-ascii?Q?mbtbf8sGwilHBYMmaVjEhCmRbaXFmcJAVLmxrGqyWucZ0kC5yIXPb+sm/JDY?=
 =?us-ascii?Q?+T8L2uB6YLYjs9hDH+LH9UvMEaIOzb5arErEdPqHoykEHM9aej1CVHwYM6pU?=
 =?us-ascii?Q?mTb5Yw4cNuX1wwki2rZ6k1ru4o5helU+sZC22QOLCPc8NYW3KRfTca6YWLi/?=
 =?us-ascii?Q?359Wza92eOwsg3+HflI8jboo9CkjBWQla9un6dCVVpF2OzPhVu8bGyl2B9vY?=
 =?us-ascii?Q?OLlpLI8HTjTD5w8A2d0Eb2/HNCNAEs5+VHov7YsLGIHOYTkXIymAhL20yayM?=
 =?us-ascii?Q?UH4gOqHwvsSNiIouYaootn6Guq+bY1hEKaqBTgaJYO2+jnlB6NJ9Q9U0L84u?=
 =?us-ascii?Q?tPPAnSWebwgbY7/XHmP1WpSpNGlH4dcNmACsr4cdf5GzLQmXYWFKcpi7iUVz?=
 =?us-ascii?Q?8ZcoCOQ6PVIHoP3e1MUCmHF8tnAOMqwnK4Ta+FfTzjyGX6zXtElb6rM3TetA?=
 =?us-ascii?Q?UYK8N5jw1la/nzEeCGu8Z9eDIdu4I/IVGvPJJDZXKiZfXVfcM3X/b14yz90M?=
 =?us-ascii?Q?LAZn+F/aDz06YVBywW97jvq262P8qM0NvEv6zpoNO1cV85rr2JCCrrShDUlr?=
 =?us-ascii?Q?OlKH5z6Y3NpItJ30fZaA3GsLWYn2fW3hfLn0Dbk+svxwZlejgz1GjSHETt8o?=
 =?us-ascii?Q?iStGruXaanZPuKEVGuJB+6clOpvQwSBUUmYuPKoex/u/t62AZhbFq17QSuRc?=
 =?us-ascii?Q?jr3UyTZin+owJqAmCCLtJPc0G2KR6MrlmxGE7eQAEtVqfQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ctl7zN/DbGEd7mHuabYJRvsuik+JcyCNRkpFmkA0BfItEInTvpYa9TUzaV+S?=
 =?us-ascii?Q?vd5aaY6swb5sX2C0A3qfzz/6QAWGQaSUDHPWSDwTA8f9NIs9zbjOtJ5uRg7N?=
 =?us-ascii?Q?lWap5PhvQWdLvoqkx6xmd7SHUCQNtp+cSTms3btxkjd4z9R9l6et/USfHqO4?=
 =?us-ascii?Q?+mZL8zAZV4dRrpqiqy8rHbxA/rXyAQylkmWdFEwAJ/W/jsh/7WN21ugP356Y?=
 =?us-ascii?Q?OBffVPKNE0XYJrEkBBdzKsUGbB55T/CrYSzAwxNWqFc++soOi9WXp8CjB+Gl?=
 =?us-ascii?Q?DztbMfpPOn0t4pfG5O5Y8LhhpdUqmuX3Dt49Z9yYePcodUYYxj2XCDMj2kAz?=
 =?us-ascii?Q?kBoBGVseLijMFPSkSKCwIZTLOWAhFSDpgCPBsq2zzDbI65ajfLe22HncBuP0?=
 =?us-ascii?Q?c69/h+cNrAA9l9T8fijxO339GzudXOe/8dFEWb0gGhmRMySeiNxe+b57VDP0?=
 =?us-ascii?Q?ulPSIMrMtx3R/5/ZCKRnlrBXe0QAbzPVOQ7ZMAfUG3BC6Wh/c+WezE0YOnec?=
 =?us-ascii?Q?vSvPNntyQo7rT5LSv3XIBtx3xVyBB/y4Lc7wsUO2+g5SXYFXs+Aby/rDqRYr?=
 =?us-ascii?Q?nU82jczaSU6uWF2cdAGB2nvcMO/2wVPbac+APznSj+OtiwP4ZYw1MAnpyL/h?=
 =?us-ascii?Q?EOiy9K0b19UtPysxJBYNF+/WJ2XcAWV+wwyy2nuNu4XnnJfFzZxy02FWNNEu?=
 =?us-ascii?Q?p53i03vbajcqxE4Pr/o2Rw1xoG/b/dXjzyUoYPKa4cVCVlcCflR+MZ7UNfw2?=
 =?us-ascii?Q?7B+BjgPS6EFG0WrCBxATVYwnoAf2jRZwL+aZApMTBbl9YwZvkTxviBcfFVpi?=
 =?us-ascii?Q?YIP5kOQacfALVm0Zes/v+oVFXuZAE2mdVQ7fuiX0Swu1dhyq8M54yr5WZnjq?=
 =?us-ascii?Q?TlRK4n9Fsce1TMbJE36a+ue+/CwStb5cCXPXC48gfiHE/4zR4ok8R/mZvoEh?=
 =?us-ascii?Q?yEPOlGWbLzRd9py8FcGYHzFcx2ob7TGfqoW4eEBEgFLFSLTgG+PuWeZSOx4G?=
 =?us-ascii?Q?AGx0UAnb1sjr2kCjdMVBRhfSOXZLRHJSOoGhrEHLrzhFCETXRHRtrltkaDC1?=
 =?us-ascii?Q?Rozb3SYI7gpxHTjK05eBkilfxzrU6UgETYN1C8T2XK67rrOAhw2S7Rg4PEyV?=
 =?us-ascii?Q?rbX0aHNN2TOMvUeay1mL/nKMJtgZoI7G41J4Upq8Dhssz3Ag4mKsxT5ja5Oq?=
 =?us-ascii?Q?K3QTiAM6lIRYAhbjPnyicjR2rL/LYC6772LmIse00NqPozI0UdcUI9xws2nZ?=
 =?us-ascii?Q?no7c5Nt8zacPjOPRQgnte8ys2eNvdGjm558UAYEnX4FlBtqDqHEqgETO0Q7U?=
 =?us-ascii?Q?/c9IK9yN++kGsrgwfYpBzIljTHNKkBgU3RJ+HxUf08HaU+9N6ZRKYsoC0YCP?=
 =?us-ascii?Q?5FdWo9SOZ4Ah3Qf2Ji126R/Lks0MsU7Tls1eA0bQIaOuUpCMajg5ySkB54r0?=
 =?us-ascii?Q?juH15JSmrz4K71CfyCfXRShhA3NMEy6W0hc/7W/yzB3pWJJQNNYgAEX4LBj6?=
 =?us-ascii?Q?ABfBdKXogS6bwLy0LNzJiTwCe+9YXP+TwFQuv0fxjWrQ2KyPAl0ntGXLNvPu?=
 =?us-ascii?Q?rBjBkO82MRsKUAwwSPNVa4i4AVOuq6dBYn/aEgnNsNLzPu+h6XzK6ABo2uyh?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab386336-6beb-49b4-8444-08dd14178274
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 03:55:36.5215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFRcPVk4QSMldirEOSxV2gqMb96o+losRvYox00ftvlwcYcrzejh3yL2DIsU7b6ryY98KE3JDWNjha8k1lb3XP3s1L69S3EmIf+N7Ido1QA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4818
X-OriginatorOrg: intel.com

[ add regressions@lists.linux.dev ]

Next time make the subject of the patch:

   Revert "resource: fix region_intersects() vs add_memory_driver_managed()"

...to make it clear that this is a revert, not a fix.

The revert should be applied if a fix does not materialize in the next few weeks.

Raghavendra K T wrote:
> Before:
> ~]$ numastat -m
> ...
>                           Node 0          Node 1           Total
>                  --------------- --------------- ---------------
> MemTotal               128096.18       128838.48       256934.65
> 
> After:
> $ numastat -m
> .....
>                           Node 0          Node 1          Node 2           Total
>                  --------------- --------------- --------------- ---------------
> MemTotal               128054.16       128880.51       129024.00       385958.67
> 
> Current patch reverts the effect of first commit where the issue is seen.

Might you be able to dig a bit further into the details like memory map
for this platform and ACPI SRAT tables? A dmesg comparison of the good
and bad cases would be useful (those can be shared via a github gist).
Even better would be some debug instrumentation to identify which call
to __region_intersects() started behaving differently resulting in a
whole node disappearing.

In terms of the urgency of fixing this it would also help to know how
prevalent the system this was found on is in the wild.
