Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432B01E22ED
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139061; cv=fail; b=VkeGjP5GZcjnp2f9x/wKRJKiKP1nG5lAHLC+UPiRruWpve2ewWJLs2O4S8wHWusVIrSKRpilduQCzzTQRIIirlGQnmp4RcPWuZg7YwBeAUHQ8qQzFJlc0L48NmUx0s9gnSJqIHTEBLBOpXNvBgTJDT9wfpt8qCdxQVoSppVewTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139061; c=relaxed/simple;
	bh=6X5eVZd5zGHk6ZqmFu2pQcXOHQok1XwoZvwLDd4HiNA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P2swd37es410BvJLwVk/jDM9302lqfMDWvcTqazBlw4I1nh5lMMt9MplzCN6iPuymPnCv5oDwSl3X3kEPYkPPnf61F3oPYPkvTEoMVmXxfE8cL47lr6tpD4LjoVD+B6WiGystKa1ynqMMBuZ5ucBkRbY8g3ZZyB4dfg3sj23oDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F3cXEtmD; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3cXEtmD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737139059; x=1768675059;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6X5eVZd5zGHk6ZqmFu2pQcXOHQok1XwoZvwLDd4HiNA=;
  b=F3cXEtmDfliA4URanPUs8AAb+NK0DE4zEOGR4U0/al5ApCBjWbVM/ncN
   LEkKc7grFwVqVRcfGOAmSlnvoEVyZYVzbyMk6wfE1DQx2bZ+0Oz5ks1G7
   BCN9vX5xRLrAgQV3gWAzbAMaVw8/1f6skbjeMps8/WOO36aUNHoMMt9fQ
   eQYkRvdvy/nWqpv6k2jxci5VzrnTx5aAQ9bZ1wE5r6ZrQlelkslMBKntD
   xLDFE8pI3YM+Xw+WUK+6MkvuRiIHUJgGvS8wdS21jyqR65I20jmnfvtCa
   qR0ey9hsLGBI5gjBaS0iHxDxmi2BZxLhAnjkkczLWT1B0XWzcYcD3iPBM
   Q==;
X-CSE-ConnectionGUID: kABU3qPbTs+TLKFoQvxPpA==
X-CSE-MsgGUID: WOzf5egiTGC7M7P+PoftUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="40390646"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="40390646"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 10:37:38 -0800
X-CSE-ConnectionGUID: DG+Krnw+TqOyfyH4K0VDfg==
X-CSE-MsgGUID: iGZzvduyT+qm7aZKu7J8wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="105838781"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 10:37:38 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 10:37:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 10:37:37 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 10:37:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvA8HrePEOmU2rSetUxS87Omr7247oD6FNotVKm/7SmGugFWn6S4lo6AFI2cpzDqaVI1RnsN2sAKl12SFo71VR+TlfCdjyrLJfN8yqG8GG7DU+OB0N6boE8Qhclea/oi4VK0FLO+1AD6hu0YplFdxPSs24JDXjO9qICDRxVEXPjpAASqD9g94YveqUfiksZ5AtZjzjCKoSUC7b3er5mWOyI4fb8lf6qOzI9SYuQ2kWy1dT2WQUULn5Fjj8ULLG85z1GtMuBLk1M0d87NcEZtKc78KSWXd/AvsbtoFpbLWgd05diQ+4yUlAs6cUrRLdReA8kl4TsEutT6XiJpNcRbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7IF+FihJhAs7W+oIf3TGJ8KtPvASy58drM2cEiwECw=;
 b=HAwkePZiIZk19QZYyS8SbKQZY7DndnF+82SH9PZPT2wYVTK8K8CbPJE+ATXXVjEnau7+Q2lDZe7CZJUHqWSnXuOH5zDQt+EQd1Q0IxQtu50Q8+Rp/PvndllbNEtOtAHXzef3BOuPkqfXRUyOx96aKV4RL5q0Y/vU1e6wlQYcY4h/VtFGgOB1nMU3iaXgO1D+jCSIp+MMfnRwjGWJBOIPV7iNAbXzBrqafTtov+mq3wxUxrxAVR/TiP8NUhF8n7SknVDNp7E7ecwCiUHEYPrRCnEIA4YjBDxUg85Vk++zXkKCQkdz5I6K1qYIM2BD71U/FCUth6AM0RMvTQNiP6JGGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6321.namprd11.prod.outlook.com (2603:10b6:208:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 18:37:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 18:37:07 +0000
Date: Fri, 17 Jan 2025 10:37:05 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Alejandro
 Lucero" <alucerop@amd.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 4/4] cxl: Make cxl_dpa_alloc() DPA partition number
 agnostic
Message-ID: <678aa351ddd8e_20fa29490@dwillia2-xfh.jf.intel.com.notmuch>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
 <173709425022.753996.16667967718406367188.stgit@dwillia2-xfh.jf.intel.com>
 <20250117111215.000061c7@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250117111215.000061c7@huawei.com>
X-ClientProxiedBy: MW2PR16CA0032.namprd16.prod.outlook.com (2603:10b6:907::45)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: 657b8bc8-b024-4f36-f84a-08dd3725f272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F/r5JlXQuioDxJplx7blUlV02LZwg8lfANsPPeFgSVmJx7beKq1aFoGbuAVR?=
 =?us-ascii?Q?HOLkSus6ZxbkdgWaZGpVI2xmB61lxAVnfpmcqGPavLjjuegUjiUL5Vy1ACU9?=
 =?us-ascii?Q?l1VuyC11GdHBwYwd5wLqjOaWLFf7hxijHX/6M6xhQGUxwbHRuq74DhuEawr0?=
 =?us-ascii?Q?Sx4ZDE1GRX3TLebQJG68oZy0QsFS8TNvIlR2a3Cjr6AMw4N3ef64RcK6OYEc?=
 =?us-ascii?Q?AlYz4CJ3gy4MfVVgPJsvTWLkLvy7p3cibRK87BrCavSjQOApqfP9nD3khpOF?=
 =?us-ascii?Q?QX8+kdNbmUdE7ZXO4udBVbo/fa+A2pFyLwcMdo99XwM6dFIAcIZtoqUrC5zh?=
 =?us-ascii?Q?cnYKH5cR6seozCP90E5+JpwrYNbNrx+k6LVT6esD4H8a1w/LWHUXoixf/ebm?=
 =?us-ascii?Q?mhfRKbEtqWp7mFNUcdE2V/ujI5zM4bUvEAZsMJeIpU6opcpoRAuhfk7HSYmx?=
 =?us-ascii?Q?5UNxCf8FW5a4Jp4+RsXhbkd+vfr4cLArlQWI8CfOr9yuIvHFeN7wZRtv4eMV?=
 =?us-ascii?Q?WU02NoWllwz+qNgjhZQtbZCJuN6Is2N4+zFWhZjLe9VWpJ9eXzoiTlq86Gpk?=
 =?us-ascii?Q?iSq45ZVf1bnyeIqAa0z7TznlEvOgE8HKfiM4aO1inFrUoJHj+bmU7zkcTHkU?=
 =?us-ascii?Q?udNf2jor8iuSizLvNc1c+80qVE6R/cq4k6EUKBsHlzEzYR86rBAqgwXSRL/f?=
 =?us-ascii?Q?CoNXUSFv0weF6UxehLrGyq8AoJB9eO0uErnXMd8mqnflKjGOM+QB4rqw/n/x?=
 =?us-ascii?Q?66t94vCfiP9e6FcWBu3QkWzNwLEXGPR/qrHFDnPME+Fa8zcD6Lab04uXWwjV?=
 =?us-ascii?Q?qYt6KoRjDIaJESJKXel7NTJHfQRXCtmoropY1vhIBrrV0qXr23QQMKIiR+Y9?=
 =?us-ascii?Q?TmvbOg3bueKCqirrJfJl2Yeucx1gBQ7QubdmH2qAQogzTDGmtmsm6sOJjhWB?=
 =?us-ascii?Q?l8EXcnXBDhjMXbbPt+9oNHFKClz1hITUUvwiGsebSYxdse8os9PtxF6zpRYG?=
 =?us-ascii?Q?YJm/GFLpxuI7wk8/1nUMz0HopJSFg2uFUPTiq9pkiEG6ojv3FpEwPwnBVqKK?=
 =?us-ascii?Q?o3+dTogOaaOCDHgSwv4hE2XTQGrwjGzzeb7Uo3phk5NKKQwOthllCbbzMYjL?=
 =?us-ascii?Q?DdBHNH2/LU0TLQuPqE0jJUcHOjIGlOdaiDjNVi1RLJLhfq4z+hwhXqaY8vqR?=
 =?us-ascii?Q?aT1YUJy33t9LtWULFbG7Tlx4ApRHcNfK5DAVK5HS9Gshv5sOnrbRfBhBuTP/?=
 =?us-ascii?Q?YlYEYX0WALIbnunPcFtp8GoJd/A3fEi+vgtPhRWcI5FW11iJweO4bz542n8r?=
 =?us-ascii?Q?wIYII95dPb66y3DxiqX0b1fB/pUHtn8/KA38tZw7wLYwmVfmOEP3j5a80gpK?=
 =?us-ascii?Q?4afxCl08p6LVFLH9y8cg/J8QBt6m?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vu3Z5v5hg95RPrSbEAxqw7N+njJmATLEUeGVVB2ZA1kd922qJekiGadvOVe9?=
 =?us-ascii?Q?pTdArEU046hdqo9M1NR+01uN2vjaREyJYzDmj6cuPoT46TONUtHD/ensm/U4?=
 =?us-ascii?Q?BETm2RWVJDCB9DAH9Lx/oZPf5AeqXsgZ/b4WpCmEiWlVEbUbPbBJJR+9OAww?=
 =?us-ascii?Q?rHplP/ydRxbJRZgr1KBYGDpE/rbNVTzwjOR4vUrWAtFWpYleiN6GF4N0E/cH?=
 =?us-ascii?Q?soZqjy5lCGb/2Vf4zfiPC32ZKAcEOKFHJCqutFkQDEIxqsDQmvqdiqbMJDDq?=
 =?us-ascii?Q?WaslGy2EFiUCTF/x2IcHrfH3q0cvA9gZi8STJ4LN1wVzQlA0/5BjCYjX8oFg?=
 =?us-ascii?Q?5DolBtwTkrHwMN72oOMxTCL9XMguuvQ0EBRf8gVL9OUoWdV/gVUyqlQnxnTl?=
 =?us-ascii?Q?igtogeCM8EOlyQWarLggBrILSOBtfH692EW4SkscgJvCSqlZzNtdz04PUNcZ?=
 =?us-ascii?Q?CHctcuv8sAg7P5DMSsL2Un1Em6Lk+WhVywIJYaydVed2AulBUT5P+amJJTYg?=
 =?us-ascii?Q?lP/nIIh5hK960eZurDMhHE441ciaJ4yT9NE20zq09KnMAqDykhHlh/65oFBc?=
 =?us-ascii?Q?d8A7WqF/19b91fFKaD8kaNNDUh/TlL5nqC73DSDp1RdaM4wF3YG3tARIv7cp?=
 =?us-ascii?Q?7piPYFczdMu0kLjJPHJ5n3mw9fOPcmImQFgb1fA5NHoTLzWXWyvaswOJiu+E?=
 =?us-ascii?Q?PlQI/QPRSpyxjbkd50KbsxVWbAxsPAXqOIQVrrH8RxuNco6XLnWcVuqtIjUm?=
 =?us-ascii?Q?X3B98NUu5oG0ma5JJar64SoINMBGNC1BVgE/EQHewJQv2ajGUcaz10At8vtn?=
 =?us-ascii?Q?GENDKaOW/vCHmNlavmlrMFGaREUXJNK7uSVsekM9PWAD4s0i1acxWICCaF1m?=
 =?us-ascii?Q?32rtMBjbtxZtS2uWShfF3LVvl+qVLTOxGoxOZExcEwXmNA3oWauIrPOX1JVh?=
 =?us-ascii?Q?65m5jZXO3YM7O6kGivYnC/KoRMAiMEPkhMyeN0HMVzG87yBpWhE4aycJdZlF?=
 =?us-ascii?Q?siSgdDkmPIjvuUwcSHAxRwysRqsQfh7mWf60T8rQufUsPpm/9cQc2BjmmfKJ?=
 =?us-ascii?Q?dxJqQymcBSfKWj55J+Ih83hCZc60VWTs1h8I+1BBMiVPbBaslGA6ybmdShKQ?=
 =?us-ascii?Q?hRcCXi1qlBQJA/QHZqMPPSxSdfKJ9GZoSo/+A7icNE3FTRKMKNE7Q25Hp0a0?=
 =?us-ascii?Q?gyD5mcdJj5fzQIcf7effbEmoYgeMS3sbFu7/SDaJZOAlh4VxjSEcDO1JGvx7?=
 =?us-ascii?Q?1ATuvoSb16MwrlAwk3MpLz/aCox/1RgmwcUsJG3vLRxzGjVTTMw8PW4lDQpk?=
 =?us-ascii?Q?KZMUJlJ6qgf0jYvOR9FO0fR2llydaBMc7mc6ygU06uG6jo5pBYLZpVvAtrKo?=
 =?us-ascii?Q?GgStxjpPPK0wZl0WQlI3vSq0yFeWAKaluZEdrujnMDet66zXXA9ZU0yjagso?=
 =?us-ascii?Q?VrZ2sep4gvqMImvi7mCedJZaDCEgpeV3Ff2OyEPJvvtlFLocpq3yMKpxrf+4?=
 =?us-ascii?Q?trXK2VV/3s/ukvDGoc+l++jIdtQWcqvpZKqwGlNbFTCGfjhXGYDXPrTj1GKh?=
 =?us-ascii?Q?M/M/hVuCx70jeSDIWOFiUlYIL7w3BQ74vwceFTHpbrJW0vrfoVx1q6DG6ijG?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 657b8bc8-b024-4f36-f84a-08dd3725f272
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 18:37:07.8492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EA2kAm4UhKTJrK8JPT0xba4pezH+r9KwizoVXqej5RqmfDVRmcZXCX0uIV+sXnevE97BIV0z6N96Z/J1LcvVKKRf6JVGKKKCUzZF9fVJFYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6321
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 16 Jan 2025 22:10:50 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > cxl_dpa_alloc() is a hard coded nest of assumptions around PMEM
> > allocations being distinct from RAM allocations in specific ways when in
> > practice the allocation rules are only relative to DPA partition index.
> > 
> > The rules for cxl_dpa_alloc() are:
> > 
> > - allocations can only come from 1 partition
> > 
> > - if allocating at partition-index-N, all free space in partitions less
> >   than partition-index-N must be skipped over
> > 
> > Use the new 'struct cxl_dpa_partition' array to support allocation with
> > an arbitrary number of DPA partitions on the device.
> > 
> > A follow-on patch can go further to cleanup 'enum cxl_decoder_mode'
> > concept and supersede it with looking up the memory properties from
> > partition metadata.
> 
> If we'd move to meta data and these were tightly packed then I'd be fine
> with nr_partitions. Until that step, I find it confusing.
> 
> A few comments inline. This series does bring some advantages though
> at cost of code that needs a bit more documentation at the very least.
> 
> > 
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Alejandro Lucero <alucerop@amd.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/hdm.c |  167 +++++++++++++++++++++++++++++++++---------------
> >  drivers/cxl/cxlmem.h   |    9 +++
> >  2 files changed, 125 insertions(+), 51 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 7e1559b3ed88..4a2816102a1e 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -223,6 +223,30 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, "CXL");
> >  
> 
> Some documentation would be useful. I'm not sure I understand
> this algorithm correctly.
> 
> I think this complexity is all about ensuring that skip regions have
> their resources broken up on partition boundaries?
> 
> Can we potentially relax constraints a little more to make this
> easier to read by not caring on the ordering?  Find overlap
> of skip region with any partition and remove that bit unconditionally.
> 
> > +static void release_skip(struct cxl_dev_state *cxlds,
> > +			 const resource_size_t skip_base,
> > +			 const resource_size_t skip_len)
> > +{
> > +	resource_size_t skip_start = skip_base, skip_rem = skip_len;
> > +
> > +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> > +		const struct resource *part_res = &cxlds->part[i].res;
> > +		resource_size_t skip_end, skip_size;
> > +
> > +		if (skip_start < part_res->start || skip_start > part_res->end)
> > +			continue;
> > +
> > +		skip_end = min(part_res->end, skip_start + skip_rem - 1);
> > +		skip_size = skip_end - skip_start + 1;
> > +		__release_region(&cxlds->dpa_res, skip_start, skip_size);
> > +		skip_start += skip_size;
> > +		skip_rem -= skip_size;
> > +
> > +		if (!skip_rem)
> > +			break;
> > +	}
> > +}
> > +
> >  /*
> >   * Must be called in a context that synchronizes against this decoder's
> >   * port ->remove() callback (like an endpoint decoder sysfs attribute)
> > @@ -241,7 +265,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
> >  	skip_start = res->start - cxled->skip;
> >  	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> >  	if (cxled->skip)
> > -		__release_region(&cxlds->dpa_res, skip_start, cxled->skip);
> > +		release_skip(cxlds, skip_start, cxled->skip);
> >  	cxled->skip = 0;
> >  	cxled->dpa_res = NULL;
> >  	put_device(&cxled->cxld.dev);
> > @@ -268,6 +292,47 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
> >  	__cxl_dpa_release(cxled);
> >  }
> >  
> > +static int request_skip(struct cxl_dev_state *cxlds,
> > +			struct cxl_endpoint_decoder *cxled,
> > +			const resource_size_t skip_base,
> > +			const resource_size_t skip_len)
> > +{
> > +	resource_size_t skip_start = skip_base, skip_rem = skip_len;
> > +
> > +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> 
> Likewise, if we relax a constraint on ordering can we make this simpler?
> Would just need to keep track on whether we had reserved enough. I'm not
> 100% sure that is sufficient for the final error check.
> 
> > +		const struct resource *part_res = &cxlds->part[i].res;
> > +		struct cxl_port *port = cxled_to_port(cxled);
> > +		resource_size_t skip_end, skip_size;
> > +		struct resource *res;
> > +
> > +		if (skip_start < part_res->start || skip_start > part_res->end)
> > +			continue;
> > +
> > +		skip_end = min(part_res->end, skip_start + skip_rem - 1);
> > +		skip_size = skip_end - skip_start + 1;
> > +
> > +		res = __request_region(&cxlds->dpa_res, skip_start, skip_size,
> > +				       dev_name(&cxled->cxld.dev), 0);
> > +		if (!res) {
> > +			dev_dbg(cxlds->dev,
> > +				"decoder%d.%d: failed to reserve skipped space\n",
> > +				port->id, cxled->cxld.id);
> > +			break;
> > +		}
> > +		skip_start += skip_size;
> > +		skip_rem -= skip_size;
> > +		if (!skip_rem)
> > +			break;
> > +	}
> > +
> > +	if (skip_rem == 0)
> > +		return 0;
> > +
> > +	release_skip(cxlds, skip_base, skip_len - skip_rem);
> Ah, this complicates possibility of relaxations as we'd need to pass in what
> partion number we'd reached when fail occurred.
> Maybe this is the best algorithm, but I'd definitely like docs for this
> function to make it clear what it's assumptions are (paritions in order of DPA etc)

Yes, the software requirements and assumptions for tracking "DPABase"
deserve to be called out in comments for these helpers. Those "DPABase"
tracking assumptions are spelled out in the implementation note in
"8.2.4.19.13 Decoder Protection".
