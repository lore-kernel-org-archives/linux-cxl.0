Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120E92DEA74;
	Fri, 14 Nov 2025 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763150533; cv=fail; b=kvYCSR9OB+jvWu6/7mITbkX3m0M7JlKRbNZQZritueW1jDFSJUdLaHhUmCawAYnErqKE00r5J0LfPoAdalaYSDf3SZpWFX3CYgwu80hMft5e1SZTZsSMBBZf8OlTiSO/W4HZdLeqmriXBlYepmrr8M/SEO/ZAbPU65vg/KaF0kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763150533; c=relaxed/simple;
	bh=6/RrCvu4aIq0bW4SJhz2qctUK4pZB5vxUES6cBkCTeg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GXctd83Aup3KT5gO0bMcod046Ek3r3I2EU7IXyFQ0hk3kr8b8OsxJ4W+pmsztiUJS9TDXTpnt00O4Nnv4V2CNPA1wzdez6CdjmN8yaZ/2OPCAdplFuI0lEm8fhkLGM5kvu1NPQqnmOZ4LmxRGe08EZieEWl7NFK5dd2/Jp8Fzz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pp7DJHcE; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pp7DJHcE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763150532; x=1794686532;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6/RrCvu4aIq0bW4SJhz2qctUK4pZB5vxUES6cBkCTeg=;
  b=Pp7DJHcEmZ14Qo/lFQ8QrzL+qnq9iQnSxsfAFVFZXi2QcFv2Yw6R8T2D
   ftvrEg5yUNwUPUXsMV26KpPYRMbUts8NmjpThsjlBxm4je2cW5nJW2H1E
   8OxY4fiUO1B8Pd2E69o1zHynTxQ5WhsIHUDDGcYcjx2OM49kVE1VYoX42
   CNbdY//6HJQoJxOSkrJrTFub3B5KQkXGkhbMF2rbg1CMFr/k19CxiacgZ
   6tq8J3LH0WPrJLh1BV2OyWQayIhKCZohUdjuuyGMB2WBqZRgZ20/dvGoa
   N6K5ISTY4ChU995/Yj6BlNztzHY9vQZoSppqvgDvOAA/E5KPVYXk++4GA
   A==;
X-CSE-ConnectionGUID: DRuW36ihSruEMkpC0/mpwA==
X-CSE-MsgGUID: jnNTyiyHSgiWUKDTZkMxgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="76354296"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="76354296"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 12:01:36 -0800
X-CSE-ConnectionGUID: KNQr2/vXR+eyUSKGQhcrlg==
X-CSE-MsgGUID: uQJtM2eiQ42XEpR90frwDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="194299335"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 12:01:36 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 12:01:35 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 14 Nov 2025 12:01:35 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 12:01:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g28VA3YN4DY8RUaDGyZvZqtcmGzGQInPcPOAK+alKgXUp+GJyUGyM9bgSC/FP5xxDd7lnJK2v72oHuT4dZ3+0tCYvJ/CRaeGXKnQpOj8fxJz+B/jYQn/wiTMoJ/SwFsq2qXcnxNOPMXkrJgoAT7SZPud/5nUYpGZjdeMkf2pmAVLMWm67Psama8exg6us1i5EWzeiSJZWrrt1nSc0Q6IC6D9egikwW8Azwc8xU2lOdKmeQFo3ho9L4/2MAjPwjry9SmMcigdEZxFM99PvaGELQeRBkJUCkCATKuf9j5wWi344LgG2lBjk322EfusEPxWAo5ADflG7ROqiwYlFYBf6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/RrCvu4aIq0bW4SJhz2qctUK4pZB5vxUES6cBkCTeg=;
 b=WwtS3ZWsl+TN3H2WCv9Kh7JfFdymNBIbJKewxnEHdW62IKCdpXzjAab227r1ip0+XEAYbQxGeR4TxgctMwRSTKcv3aHvZbJ76hjbFAGjWjjoUxomkEq7/v42PxpYJgh6oIZ6ffZPCuWlwhdn69FNTu0tViVLkQdOX4k36hUEwNZ6hGlxoZ+TcMDlGhecfYHJal0aaSWas6B90f6ertIf6BAeMxuBDwyVccMKOfF1Vp0GyI0KxqRa2bM+zErX6/XnSDVoCUlEaPYRVgyNXH3TL/3UqaKzNt3F4TReUaLk9O4CVL/QPnFXlIvPQPCk7lrKir2W1v9SGoRVUM0hn2TZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by LV4PR11MB9491.namprd11.prod.outlook.com
 (2603:10b6:408:2de::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 20:01:33 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::2cfc:dfd4:ebf5:55e0]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::2cfc:dfd4:ebf5:55e0%7]) with mapi id 15.20.9320.018; Fri, 14 Nov 2025
 20:01:32 +0000
Date: Fri, 14 Nov 2025 12:01:29 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v6 00/11] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
Message-ID: <aReKmdOeHBBDWMuC@aschofie-mobl2.lan>
References: <20251114004021.1310661-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251114004021.1310661-1-rrichter@amd.com>
X-ClientProxiedBy: BYAPR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:74::35) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|LV4PR11MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: ae60fd16-8d87-4e8e-a633-08de23b89b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q+gA6fz95WcLbR91YLgwg8NQQ6n+asjA7mBd9uSStJT/V9bApuJ+7nNEBCa0?=
 =?us-ascii?Q?AuQv/+/2HX7CFy9zYw4nz4KLryJfEBq+fOJvGdbnoc2rWRJFDuA4mrPODAw1?=
 =?us-ascii?Q?cPIR3zblvUnfAbrRhurEPSFo2IPCLK1byR00c8Liyw/OOGrMQ0Eq9TenCJ9N?=
 =?us-ascii?Q?uZFUVI0CrDLlB/apVFQnQ6XXwpNUefHFSoCqAZ/w5CMxjJm674b4FzC5WCY4?=
 =?us-ascii?Q?c6Ymv5fx2kzSXRM50es2MF1auTs3iyQJsZvaURi73oWU4t+w1a88aj4tfRcz?=
 =?us-ascii?Q?teHTfZB0oz6pNv+nHGxN5giFwnRRR70hGPmqOCvIgXdBazZM1XsHyI7zA1Yw?=
 =?us-ascii?Q?+O8sIQHe9hK96w1MIMe5cPSm0hqlTfGzf3f9ZHzAj54Hai1j3teHrlGZLnUb?=
 =?us-ascii?Q?RkuKPr5HnNN1OfKTa6R89ceRAPDJYXkfqMfXFjb/1iV6mm3nVvOo68XD8EHI?=
 =?us-ascii?Q?ZWezxxi/xjpE+KKruWTFk7QSD2xUt/QF1jB7ZZQCbDsK7+qvvaXDzEnVh4v8?=
 =?us-ascii?Q?OwGF20gjuRlc9yGhyY+qtgRt+VEZgZBpP4XgOuX8S0jAza4peb+qSkmMV9IR?=
 =?us-ascii?Q?j44uYH8EjbZt7VDABmIRNBG6XW6oDKanlzhttAGuPz77ENwcqiIlQ4MRKNV6?=
 =?us-ascii?Q?YYdlt8NiDDVwnTuBDoAVUEh6tPt2msWNz2MjGUK2DTvLoHI6Hc2dDQ227fYk?=
 =?us-ascii?Q?VCDjPZd3PRzEQJ9O8K6QhjGjwjhgPYdIcwg5EJiJJbEx1odL9MqTeXd4V+kf?=
 =?us-ascii?Q?BZzIU4wAYgmu5fHW+y1+nfXo3AXFP4tkdM8Iae+CY0wwu3hQaOgBVc01a2OX?=
 =?us-ascii?Q?kLX9/xgq97F+TQffzRtyi6yEMjcMrgCfxxQosCIE8ADODaGBNRySOyqNSLqA?=
 =?us-ascii?Q?9UKjUxbYm0OCN2YNPgxAZ1Ns4wYVmgRSOv6cGm//hon3nupPCLiMf4ADLXX3?=
 =?us-ascii?Q?eCW4ujJ9ZKaGj2O/SWLaOcLtR3LfCQAOg7HeCWVdKHI8Q/Ge4Z/OwMGR+Y9K?=
 =?us-ascii?Q?keusiklEuFO732by+Hy6KYK7Dpjwa3U4vYTltEXyFCV/64QKaOlRRxnZfhoo?=
 =?us-ascii?Q?WV6P1qE3GXnHOJYuwsBbIEWi55zY/R8ZRDNiaGnxZlLlGIye1NYNZ/lKrII4?=
 =?us-ascii?Q?jYSeQdRSdeQ8iLosfG0uvGvYrYoQPUJ4SzA9HSIx6LlohMSludgagJAmF8Ie?=
 =?us-ascii?Q?kKdUt0Hce+sVy5Hlqbxodnt0OITDM6eaVeXMTYc/Fpkd2UMqHiFTn0u7r78F?=
 =?us-ascii?Q?/RBl0YoQ5duJ6s3t9X6+HteIg/9vAKAd74JbhyKhtSn0M9gNfxELeX4wtuwk?=
 =?us-ascii?Q?kDuzAbUTeEd45/wBuEA3COG10AGN4tJDTJrh4YmjgGg/wI4/0ROIHQE6B//9?=
 =?us-ascii?Q?tGckrNe7Gb30APvcZwzRha7cFvZKvwLcLclDXh07vOwKTBnzLmhRQbxydkFe?=
 =?us-ascii?Q?e4vO7FCjN5hg70A2kfLSrhxYhgzsl67V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O5KQAzHZdoXYGlo1+f73VaVZHzPENLzSOnwDLFUHi/yIb0YQWcOH0FZTv+Vw?=
 =?us-ascii?Q?bJnirzz1TgOPwoiJt48UI84XuSvNw/PjHaW+bzjvrGgf+4/wyv7UJPyxIj4w?=
 =?us-ascii?Q?PENMUzagMrDl1NTPW2kweExSlYtdOErW9Vs/NR8S5Wgo5CSlopduCyI0i5LD?=
 =?us-ascii?Q?1dC1U+zFS5QU1DIIpb/qQa1BL3RI473+6h1EeRvuVBjTbWnu7SLDq+MBoYCy?=
 =?us-ascii?Q?j/eHURGw9IRUOEeksZymv8+xbSDxuHQnpR3mGw2OYGo9edvpy1XNi5ArASFk?=
 =?us-ascii?Q?5+qeH5mqdG5D3f8lZyl9Vafg783ABMfUdAQF4KYR7uN7/iIC1CXcQ4vd5/s4?=
 =?us-ascii?Q?FqJKMrTGtQwN/bIww84xMIS/TtIu5SLm7LV2H+pBvgKIdaNPjuYd4JXvJzK6?=
 =?us-ascii?Q?3lcvCKQTY7m/U6RdaM7b0QpGkfkj2FOgPMdNffBOTdjxUY82Rvv2kDWV+4Ed?=
 =?us-ascii?Q?fMBTguGhLlxK5kUGNsPuBnI1G0QuUVGJyBlF27OWfeA8fXy3TcthYRQfHF4Y?=
 =?us-ascii?Q?CI/GGJTR0ft853G9osEZi0Vkjgjg0x8GwPNNB4sh+1sTu7Ud0MA+WahbA/B4?=
 =?us-ascii?Q?OOhfgeaLI2OuWHjvhmulArovXMe/EWmCB3GYjpzND/Wud+nGGpHsjyIBXxER?=
 =?us-ascii?Q?KM29ZhaeoOaX1gJdCNPvo1B/VdWxG3/xDkZfoi/lb1cV1P3/xvV18It9bLd4?=
 =?us-ascii?Q?taMhJqD1BiCwJ2RkR9yzwaK4+09gQ3pxCjKw3/tLBB7pyOE3yhUy+JhXeoKK?=
 =?us-ascii?Q?aHjAE/CGuBkV3h9Fsl+0KJ///pUFdeb4n4HT0Euoliv3zoUwsPx/H6DHyUsB?=
 =?us-ascii?Q?Y/bpryGgmKTE9n4OfVTjqKf4lheCKAooarPDM2otnRMvyNG5pM89KDZmimQC?=
 =?us-ascii?Q?8w8DxP6AkXzsbc7+MOR4Icl3np0e+8PEE7mXBY5N0vpUVhc64WduxL3DgDoJ?=
 =?us-ascii?Q?4tzWp/M0BkI3gmdNNXl2FKccXwVaYggf8G5r3gdbWcD432roCaEj+baoDd44?=
 =?us-ascii?Q?+rCPaH4fyF0dYTOwHMoEc8g9BtCdfXYmzt+AWNz+BO/Kf8PX/BWcvi5yWjGd?=
 =?us-ascii?Q?vrW82hkmxsMemnkucJdr9yH8hoHZ53kNvIysaTU3M0AF2hK8uO75fQr8e5hU?=
 =?us-ascii?Q?kdeFS1pfGGjgNmUJXYmqt5eqpaGW3UaEFCZIX0QXj4mSCPsPvKUBh+g9K7Ka?=
 =?us-ascii?Q?r4Fnj0I44rSDY94QHKvHbETfpLTiG2qNuWLKdXumjUo1rlnuZko2nJkXr0D3?=
 =?us-ascii?Q?z48Mt0E+dfrHyF1LJW+5Vnn7h/GG62y8eM946w8DD0HploGSNYTsR4SFAjVQ?=
 =?us-ascii?Q?A5sDpTZVn1kThPy7pi/tJByTdHQSrz4Dl2J4cqF2HG1OarPFuP83CkhS8h24?=
 =?us-ascii?Q?WC+1bMYCaZ29P+RY2FB0iOk8pWvsj4STFPgH4dcwSYbj5rb7aZTxrhm8Hy1O?=
 =?us-ascii?Q?iAmyMgMsIzreaaKMCpgbT4MrlG9WN4rk2uubDWLquQQFYkOspfqDixmcGGkD?=
 =?us-ascii?Q?RalkYLgOg2hYHHkgA0AXinoWahmyHU5c1E3gusT/N8oYv5GOpcUsxxM5A8rI?=
 =?us-ascii?Q?c2sQJVEkEDIUHxfNcMseASaE0E4jD0GaB/N19tWbzQ65RN6KTpqvFA/R95Ax?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae60fd16-8d87-4e8e-a633-08de23b89b95
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 20:01:32.7148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuLqpmSf2U0DPBMxWAvyjonnF1d+4ajeD95aWwGFrDhhZHAwb91d5tNoWtW3e3331EHQjGFEp7KxrnfRniZxZ7IMppuMoRPQ4igWHdQaI6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9491
X-OriginatorOrg: intel.com


Does this work 'as is', no changes required, to support DPA->SPA
(used in CXL Events) or SPA->DPA (used in poison by region offset)?

