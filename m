Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133441487C1
	for <linux-cxl@vger.kernel.org>; Fri, 31 Jan 2025 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738366811; cv=fail; b=gSX9s3k5zwIG93C2PH1U/Y2qXWbY+RtOLs2O9Qzqmh20L88C6ZoPMHoBWCtikiqS2iAfCUe1x9P0Rm0kUHS4XHjcV0qGkDA3Lcy0uigPzErYqJXk36Tw/8goei5Xn9A0KXJwGwJ8KcWUW4M7/F9jhdcbN1z39dWSmKD2snM8DdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738366811; c=relaxed/simple;
	bh=9i6aUjOjCx7voNmJGKC587r6hu/szeY6cntTLJQ4tmI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YioHTZJLxHTvXF7/9JNlaYhWOeT9bjckEmKk5ukRTJMc+2Oa3Ae8uGEoviustsE1IP9ziNkwDFY/JPbCsxg3NSLIAN/Ao86VxseqdquOeIiaMP2jAS8IdCYMCjgB0QpEw2L9C9nuidJ6vPlW0wZ9n4kOEQre0qxb27QFBHv3q4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mjJAr497; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjJAr497"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738366809; x=1769902809;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9i6aUjOjCx7voNmJGKC587r6hu/szeY6cntTLJQ4tmI=;
  b=mjJAr497gzZHPIixRKqKLsinT55gTZ67fG8lpAov5iLfmC6PeHpVTOmc
   l0TT9UQxqyriB+fY5F8ReLioN17eT4/WOvFWooe9RgZuc4nPgQNSoXVzA
   9ODM0ZxweH+wCKIwh1PWmwc3gusuT4Y85ClaenBROY5Pw6F+hItRVTSm0
   Efg+qeK3G5JXqXaAkZQWqCpqN9brSW3iU6P3rH/iMq1FJVbAKJz0f/zEe
   J+MYsish18sKBCDk8DYkTrafNJG8mFx/LfTnFjQxoyaqqqYJjUhmSeu73
   0OOQiFRhXqcWnww+kRY8LMVNwUoTCpovQqN3hBkQO59C4LGIEoCrjIHpn
   Q==;
X-CSE-ConnectionGUID: SYz9ws1BQgaV58CdBDPf1Q==
X-CSE-MsgGUID: aHZq9gryTTSU053VQIo28w==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="38971444"
X-IronPort-AV: E=Sophos;i="6.13,249,1732608000"; 
   d="scan'208";a="38971444"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 15:40:09 -0800
X-CSE-ConnectionGUID: PKNMC5/AQ1uLsxESpKR7ng==
X-CSE-MsgGUID: dyyG8pGWSJeyewgyQX4VYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,249,1732608000"; 
   d="scan'208";a="140636732"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2025 15:40:09 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 31 Jan 2025 15:40:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 31 Jan 2025 15:40:08 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 31 Jan 2025 15:40:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTw4lcPdITgBz9duUAOA3UFXirhhTO3SFv31szEw3Kr6DjD9FjYQ152kVjg6eBL9gcU4BcorOyjtAAhmcVMSUWWfdcGgCypIaI7fUNremXNr6skHGCXfoR0MqzDBs6S8G+rkjt2zPlUWA9qhfiSJQ6872szkBePZutGw24edfmhiq2c8fyVNrN9gA0m01vRM4c9N7s6KTBXe4Io9xODO8xn1goiXkXi7rCBUlLK+yw1KuMMLE8brZK350g7HN6UVMh33fdNgcw0jCyWZRbsyDxJALMCRn0/e14f6nGlZ5N0qLYk/vB9DpbBShOcjVbBH/tc9/h2qPRTGTSKdDkWm9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkQ779TYHYcAgqtKcRfyI1y2MqJAAWAjDqhdJsVnleo=;
 b=LYnU0+qXDRr+Y+Ey5WlAusLMPLvgyhZPqSN3AuEtaadoBoDYuZxxM1DC1clBD2BqIYARq1o1VLYSdEd8f3eVLiafoaqnlnL6aHM5jcOaH9P0NmzzUomVIimEflHy5higb3JkiIql4agCXj+V6pXeJ4i0kja5CUzB00a75hJ6Rnz853saHi6fBky7XFmvalyHvoF69zvyH75RxbPFqbmmAYHIsQTxvOXpOKfIEULyx2WcbsUS847lqqnJ0nb1TKIUKRxldoFZP6jFmvCXBjGIs9eMBlEWFWnUt1+FlEjJUaq8qWkCd4w1q76Z2yKK6a4yfhDssVbK79gqlLGeieXnSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7627.namprd11.prod.outlook.com (2603:10b6:806:320::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Fri, 31 Jan
 2025 23:39:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.017; Fri, 31 Jan 2025
 23:39:51 +0000
Date: Fri, 31 Jan 2025 15:39:48 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 3/4] cxl: Introduce 'struct cxl_dpa_partition' and
 'struct cxl_range_info'
Message-ID: <679d5f448f667_2d2c29420@dwillia2-xfh.jf.intel.com.notmuch>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
 <173709424415.753996.10761098712604763500.stgit@dwillia2-xfh.jf.intel.com>
 <678ad4f8855f9_1f5289294cf@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <678ad4f8855f9_1f5289294cf@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:303:83::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 39929ca2-e2da-4a6f-f1a6-08dd42508e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IXuJzchmZjNMLpZVkYxO8ool/gOzXEihNapagVWNHPr90Xi+634/NQRj+kY6?=
 =?us-ascii?Q?sFHO+mv/zAjDNDJ8445P7ZVH87aOdDwBQsZnNjzyJWAMy00Tc6aoeBPkKPLe?=
 =?us-ascii?Q?gKraRpcGkxCXl97pnJ0VH0Q7CX2zzjkuu6bIjgyWQ/a6/iTg7N3TgkAw882P?=
 =?us-ascii?Q?ivN+9V2j+HskiAo778NZzoeMBW3KZuEOhD3Hp77a6o3p3Ht9yl4cTR77iEeU?=
 =?us-ascii?Q?ourJgc281gC1Utd1RLSrI82uJ8EwnQyQPinEPQfPDtVN9Bn6EeiA9bCGV8UH?=
 =?us-ascii?Q?D80UONdOnaAodPmEXkbvpWHilVmqC9nAGZ604fI7v8kIUwafdZttzVb5itcp?=
 =?us-ascii?Q?TyNmnOOrhNoZEAhXD1hv3tJRYpCSffmHrUzwSiXY/wEwlqkYaICmKoN0fXt4?=
 =?us-ascii?Q?h8Qo7LZlyhxWPEMnGJc9oZHOEEBfW0+VhMhicCglciPqnRB2nMHmZbGHWDOa?=
 =?us-ascii?Q?r8z3cJS6YofPUy6HW1au2KnHCXYFSyQefPYySNmxaRdjL7sAptxIPRIA+iMY?=
 =?us-ascii?Q?lGVk21H/CZ1tNbWoaprqWrqc8zjHAKPzPJxTHnrbqpdE19pL899m7KVsMU8f?=
 =?us-ascii?Q?YW0nORY4bOX5CDFLTfJdWPyslOfhiuf5m866oR+pEOM4WNYC+0w5v5OSBbOu?=
 =?us-ascii?Q?dnxTVNZcnTUh73MJjE/v1uUMOVtzDKSFVCGrWS/579vYPf89rYdcivpa3oaF?=
 =?us-ascii?Q?b8VeVcKmqop3YGRZwCIFoOHqK+Nkz0tjQ0DYzV0/Glg8xpZabzMw9/8dqKja?=
 =?us-ascii?Q?KdH+SzyzOPcDnNGOr18PYu4dekh2Wgd2EmM2gtI8e79+QKaM2yXXaZ/iJyry?=
 =?us-ascii?Q?hDG2rSjocaHkc0YnfEnl7hwk20tfuwQ3Bo+JeD6Ws3EaJ7kBMr61PEq1eyR6?=
 =?us-ascii?Q?sAZp5/NSPswo21CmxHBsFRfk6K6E7A7dn4tvSeQW4MuZEFowy3cuy7yGszDN?=
 =?us-ascii?Q?RsWKBnD8g0HQn94XF13s+gJOurC0pWbRZKwBjKDg2mGuRt6jZuUdYfuj3wqJ?=
 =?us-ascii?Q?MefQqUEBRK15bZKIxMqkspD+Z8DoX18FpJdA+Lep4wSqc+LAfMMQZMPVvXfX?=
 =?us-ascii?Q?0d6uprTAcMzlgJGfDequ6d1BkMCIJujJgFZPzny4Pqyu33cloMRZASbK2J/Y?=
 =?us-ascii?Q?S5hXVIWrUjkAQXCjoXu/X/+r8HmhizQf2mvLQTchoPxmyBwuXptVc5havr2R?=
 =?us-ascii?Q?UU7Gm4nJUE8ML6InXruMrnyiRBIRnanwESkkKEk6Ro1qnJrOnmHM5NuxmV4Q?=
 =?us-ascii?Q?48T+ia7UOxrliswMNEKqkET8Hre2A/zaVt8DiNWhU/Ey+TUJU0ZR1JL527A5?=
 =?us-ascii?Q?GrVG7MTkHv3HiwroCiO4iK0CiuycKfgVU6US5XcRHLMctA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vzVdLcNxfciuObn43zm42BazQXk3t5N9a+4xiymuIICtmOs0afgmZzEQq/Jj?=
 =?us-ascii?Q?Cxdfi+bTPJZRDBbjPyvQPYDJeCpMaxxOyCtPQef1RCdt0S/MAo1d4lalBn34?=
 =?us-ascii?Q?WW4M69ift7O8mBHVdWZ2q2eZxwqtTZRxEr0ZRtIQrXiZBiac5W/HnW9y+SB2?=
 =?us-ascii?Q?t2fFAy//sR6MbeNmZdTSib5qjohtiyofdE1pQIotpO/VfZSdW+Neg979JXRU?=
 =?us-ascii?Q?ZeTkOCr4CJt06rlCjcIsQRvN6M9+NV9L1h2IDfrCxA9o3xu3NN8a2uuGZWyF?=
 =?us-ascii?Q?gKXJwd7h3n8zyq8Z5BQK62T3HGOSlrgp7pMB6Bj8KX7CbzDYzgfaXRsXYQnU?=
 =?us-ascii?Q?c3Rk6jvzxjpSmSwsE5OuVKfeHk6pfZWKqygF8J26+eHi9QFu7xiacATH6N3O?=
 =?us-ascii?Q?kI/HzPzbxJ0VQhA2TPb+oagrUItypkh0VnSZNt2EBXea5aaTX6ehGFZzWy0s?=
 =?us-ascii?Q?wVLSl1BZL6wR82Cemy6RMH7QtkbNrJp1lEqpl8xMmvV65ElNYuQh+YNK7r2J?=
 =?us-ascii?Q?ucXIn0t0Jul4i5CRqNaqgpJCA/TxFtPljG36SCAOr0eddir/L7qrdj2qfq5C?=
 =?us-ascii?Q?5jS7QX+HxsIS4G3niEYvCX4WFHyQ0l9uO6ZDs2qhYO5I/VG85/B96iPN98Fx?=
 =?us-ascii?Q?j45cDsD/uYxlW0NAYeTiPj/wPvJMB1Bj8bcOri1Ux+kYu+uI26Xx3regnDyF?=
 =?us-ascii?Q?MmMvgZRUdQjBHwLj+B+HzfpGxlSilIaS1PReW+DXJXHyChVs57t3YBOKlFAu?=
 =?us-ascii?Q?UBrX491Cwow+LofievG+F+6SXUPNJ0PCtG0+/ZoICJWwwD5dyGJllDXQeT9I?=
 =?us-ascii?Q?RWpW3mVCKKJzh/xZ7lPgV8/js7jCO3cgImdH2T3j5Nm3eIbybekT/QPpxQCE?=
 =?us-ascii?Q?yzWoMDyFth/hXqw4HT5jJTPGIUm6gUsBNuD2QYfx9jz3oALfL6pxjnSdyxNI?=
 =?us-ascii?Q?SwIMisauxYj66yrkPEcPBB/+2Dzt0UNLKcxy7O29nNMXl1SVlRFmfFLvJKP8?=
 =?us-ascii?Q?uFKNgE1xE+q48NBjCDEPoTABMEnhG/uhmvj8lJXFw+JJD5mEg5vzvl5T5t9E?=
 =?us-ascii?Q?kNhARU/HSUomiC5hmR14fHM+Qyc9NZxaffdtOTGfL+/HNW9YKRYuh7JpFqnq?=
 =?us-ascii?Q?YcXalVc1UG2CItq1dpkue3ctcbgvmXFeHilwStdvmrYPELAQtkM1UrQouHX1?=
 =?us-ascii?Q?f46toNdOlM1Otd43C61ClOqvxJNjJk4eHNWCmI55zsDraFWB+ZBSMQ4qA9Vb?=
 =?us-ascii?Q?cTsLBS2p6CMXqD1mtdbDaQcYCE/iDkCuEjTGYSoLDqXCcg9U+UDLh+bM3jlo?=
 =?us-ascii?Q?e79gTUmJ6qeXhYpJ4843xtaThC1CSc9o/5MJCOAyT8AQkPafp4EoooPQ1VRs?=
 =?us-ascii?Q?pt25GdxYWeW6fHKJH9Q2ZfDnXoyfxvlRlXSypEft7x00IQULoJHcFqeRU+m0?=
 =?us-ascii?Q?0kXqdPmEwUmFpyFBls7dxhXuzzTc/kk/dCeniQGDgBhpvvsl75OGjZmNbKjP?=
 =?us-ascii?Q?Vtotw4UWxtZey0WibjaBoYJOVMyX+dgpHsak7cSfLiOW5EYRjsKLuuaFvI3b?=
 =?us-ascii?Q?PZNQWPN1IfFsZngECMJgja+0XX/UEvUVm8ce+7o6eIS2kTpVgYdawet/1jPC?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39929ca2-e2da-4a6f-f1a6-08dd42508e6a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 23:39:51.2907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSZb8qvrhqvaF5v9ONg3gB66/2lk7/vRsQmHZqz+ioxBIvk+innUlgNFMMQOOlR/RgObK0H+Ls5abnNjfNiOXSrrOr/zszPm6DeP900gno8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7627
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Dan Williams wrote:
> > The pending efforts to add CXL Accelerator (type-2) device [1], and
> > Dynamic Capacity (DCD) support [2], tripped on the
> > no-longer-fit-for-purpose design in the CXL subsystem for tracking
> > device-physical-address (DPA) metadata. Trip hazards include:
> > 
> > - CXL Memory Devices need to consider a PMEM partition, but Accelerator
> >   devices with CXL.mem likely do not in the common case.
> > 
> > - CXL Memory Devices enumerate DPA through Memory Device mailbox
> >   commands like Partition Info, Accelerators devices do not.
> > 
> > - CXL Memory Devices that support DCD support more than 2 partitions.
> >   Some of the driver algorithms are awkward to expand to > 2 partition
> >   cases.
> > 
> > - DPA performance data is a general capability that can be shared with
> >   accelerators, so tracking it in 'struct cxl_memdev_state' is no longer
> >   suitable.
> > 
> > - 'enum cxl_decoder_mode' is sometimes a partition id and sometimes a
> >   memory property, it should be phased in favor of a partition id and
> >   the memory property comes from the partition info.
> > 
> > Towards cleaning up those issues and allowing a smoother landing for the
> > aforementioned pending efforts, introduce a 'struct cxl_dpa_partition'
> > array to 'struct cxl_dev_state', and 'struct cxl_range_info' as a shared
> > way for Memory Devices and Accelerators to initialize the DPA information
> > in 'struct cxl_dev_state'.
> > 
> > For now, split a new cxl_dpa_setup() from cxl_mem_create_range_info() to
> > get the new data structure initialized, and cleanup some qos_class init.
> > Follow on patches will go further to use the new data structure to
> > cleanup algorithms that are better suited to loop over all possible
> > partitions.
> > 
> > cxl_dpa_setup() follows the locking expectations of mutating the device
> > DPA map, and is suitable for Accelerator drivers to use. Accelerators
> > likely only have one hardcoded 'ram' partition to convey to the
> > cxl_core.
> > 
> > Link: http://lore.kernel.org/20241230214445.27602-1-alejandro.lucero-palau@amd.com [1]
> > Link: http://lore.kernel.org/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com [2]
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Alejandro Lucero <alucerop@amd.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
[..]
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 7a85522294ad..7e1559b3ed88 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
[..]
> > +/* if this fails the caller must destroy @cxlds, there is no recovery */
> > +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +
> > +	guard(rwsem_write)(&cxl_dpa_rwsem);
> 
> Why is this semaphore required now?

Previously DPA setup activities were known to be carried out in a
hard-coded order by the cxl_pci driver. With accelerator support and
this being a publicly exported function, that calling context can no
longer be assumed. So, take the lock as is typically expected when
mutating the DPA space.
