Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75813C9D4;
	Fri, 13 Jun 2025 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749825135; cv=fail; b=MLR7PYtzsKjUhRhCO71GDa4YE364NYCS/2HWldgSmzw95aGUwhKIqO8FNu4dtexvc31hT1HtUyg0QwvwgEWn3XDLLJTpqkhPf5hSlzH1wrwCvQUwGvsF5ey4r1L+jG5Bb76UETXMEgCHt8i6RAdz5mxxGPvJYckM366UYYvEjyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749825135; c=relaxed/simple;
	bh=fw8m+7TdTp24J2v0w5wZmXW61zFUktn2P8Us6JIyHMI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dD2zHR1o/7IquV6ilq/KPmSvqAshPi3LTLEUV34teVx7Y7oDvtY6YPF+ih1NCmiYOuTYQPc8tbCBdIelfbXaYnX/EoqSCuQ4H0x4ckUBJSM2FjBRdfEB2jy6mlQjvEVVx1ZQ57Vi7xEu0YBqUr/fywiEWfQyMElC98prgu9kkyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZP26Kdk; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZP26Kdk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749825134; x=1781361134;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fw8m+7TdTp24J2v0w5wZmXW61zFUktn2P8Us6JIyHMI=;
  b=EZP26KdkFLVfSHz7R51dVoUsQaoBowuF+9/7yR0UaRmx8fohYortsI4V
   W+Cas/Gc6zY8hPVmDBvFfk84SDz2pW9Xy2WX+9EIaBML6hgXzfkodCSQP
   k1JRsgYZtiLD2CT9ApIpk9ho6QbsPd5E55vY5E13lTc4HaWV3IdLa0093
   lxXs8t9NYHqLeRm8LeRzP7rWKVu8k2zm+LqwSHe3MMjH0YthY3m+REfbZ
   ZyJuxqECOA1hRm1Uc3RVtucKcQKHwpvulfVPTligb0+e6EPOMRPT/9THd
   DfL5HAti6qadgXYK3PyyV+1g2W5ffc/1aP6LuquVxz5Y//IwJ4Vxo06lF
   w==;
X-CSE-ConnectionGUID: LFCZZgmcSrydjr35ecjolg==
X-CSE-MsgGUID: Ml8ZZY1fR++NAJFsixMpFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="63394502"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="63394502"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 07:29:15 -0700
X-CSE-ConnectionGUID: W27RZm5FTJGi04Oxc/zxwQ==
X-CSE-MsgGUID: Kiz4P30iTJCmc2JaSsggWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="147687584"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 07:29:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 07:29:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 13 Jun 2025 07:29:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.71)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 07:29:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcXr4ZjdI8eHqCivjArvbOIySNU75BSKApy48K7U/8ynwtQfXIwwjMy2LDrod217RLtviUFxUDikJDWx6qvufFqeBOekdGFuywb4fix6OSCaxHNqPz4YzjN7Dz3vR3W5JHx7HULw7fuUYD1lpippsgKjPG4VNrGF3rL47AkC6urXQMMi8E0heh4ojeQZ1QcRep8Av+5J2lsjiJZYj5NVq6ut7mqo4gP8pjNMROJPMe0nHyxU8YQFBjZyFXW3b8a4roCb2GWDKmNHTqqp/k8gz3YhGQnaaRaztVzmn6e+kvr+LknRH2GJ1XvAbXbQ4XvalZkf230f4JSAZ59YUWBRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ep7Yeludjg8ij5LPYg5QcDUFMIRnZNqy5ZlVIKgbgk=;
 b=CbLDuxKsF8mFHQPh5opXz3/hk3kmvPR0XdZjhxnRYOlREy128/bZdS6vJFJFUNqWcamq2c1pLpVxk5RNw7GVa0TzTqgWqdFivJLOBzvblI73kp3fQ9h4CC7/qKCOOwFFmZ/+/WUA/P8QBiAz0YM9yP3/l3R0evRh2fWeUzRk/WjRL2MS0j5iKnx/YDBrD3ECdsjGOspZTaFmz6DGXjRmrPNif30oLdwkGh3X3Jjic6xZYkYYOw1Ifu9xkYOIuBbH1G1bFDmK+cwgVd2VACXhsmO2gmYj4sX4CBrGtvquFopUnQ4l2C16o+ihd6PyCeRI0tzXfyosKRuQY/ZGdeUyxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by PH3PPF7708D4D9D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 13 Jun
 2025 14:29:12 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f%4]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 14:29:12 +0000
Date: Fri, 13 Jun 2025 09:30:23 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Li Ming <ming.li@zohomail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Li Ming
	<ming.li@zohomail.com>
Subject: Re: [PATCH v2 1/1] cxl/edac: Fix potential memory leak issues
Message-ID: <684c35ffc5c24_2230d9294de@iweiny-mobl.notmuch>
References: <20250613011648.102840-1-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250613011648.102840-1-ming.li@zohomail.com>
X-ClientProxiedBy: MW4PR04CA0225.namprd04.prod.outlook.com
 (2603:10b6:303:87::20) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|PH3PPF7708D4D9D:EE_
X-MS-Office365-Filtering-Correlation-Id: 29632b9c-0d43-4107-e3d6-08ddaa86aa62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A2OxVxpGr5TxI2CHs9iP2J7cx525UsSULTAAiZG4n19biimLjYs8Jy5b3kiZ?=
 =?us-ascii?Q?q4/6CszqiiDUOdhUqRf3X88vaXbmhncfPEWQ8OgzRuhMDCPtDQm8DCP/dV+O?=
 =?us-ascii?Q?nP/MpcHJJivtkZj0uQmWVPRdGILF0VZ+0myz5xTDQDLlTrFhGWjvuJesOIKr?=
 =?us-ascii?Q?y5afKCiNjzZpMldzGtlFBYiUFuj1nS4nhKdF4G2dlg4d7im2sr/nud412WWC?=
 =?us-ascii?Q?4P9nQ9OhFf00fELCVcIISUe9Wb1cEw70uciWU/bFLc9q3kDyLG59/ekqof++?=
 =?us-ascii?Q?xxBXOb4K9SsC5eJaBMffeGo5fcxLJnFpkVd4eG9U2AThLPHJvKKO72B07Zrp?=
 =?us-ascii?Q?OPrcJIFZNMtlSw4zeB/Gajd/3aQr9EC5v2G5BV1qiggDp0gOzfYpCKxxUrXS?=
 =?us-ascii?Q?J0RLYsyhsjsB7A26VU/qiPr/U5gY97fp+eiY/hboxJWIrbk7euX5eLvzT0QC?=
 =?us-ascii?Q?53slFLXKh1vQJqfOy/TTEwAphsq649BdoUxR8+0dZy7GIHAIi24EFw6xKtMW?=
 =?us-ascii?Q?gczzTCG4ocGpR0+Lg+iNR3shdl92Th1MY7UE2SPTFc1a/qFOCnTB+Yx+g4w4?=
 =?us-ascii?Q?c8XkuI3DSr7uuGthRa3qozNVpVn4OyxBA4hO/S7MfuAAv4omeG7sSnmCh/xa?=
 =?us-ascii?Q?VDp2a5UXfJj5ysQtimlq9Bjw1ZU7ijhIPVBqzveBh60xaFeUmW3rXYQz62g9?=
 =?us-ascii?Q?f66z+/zU5nB8KdvsBT3bT/V3RVm0rQy9hg+O8nOIw74ynRBSERoR0LGWbU6g?=
 =?us-ascii?Q?yUQbss9O+EfGbr4XgAt/hZzO3MNfvsnByRmDwIob4D9DUqhmpGprQ10S66vO?=
 =?us-ascii?Q?qR+HDi1XlTTJsGC2Ls2hYPQYY5JFPxO4KAy7W+WHldY6BstWy1aGT5Zz+EDS?=
 =?us-ascii?Q?yU4Xj/NSRwMocbMsIkQ86HdpHa2vegkPY8uySX7UK9aPcyl4xuyvka4q+GiP?=
 =?us-ascii?Q?2u4gQy6ONtjy/MauJ47UL+uHHeYfvfy1yRND//2hZ4qhY4somlJXNotRYeHD?=
 =?us-ascii?Q?CDBcRHNlJ2U0Hg80fatBu3/9rA4jJ2+xfbpPlg2+M06K5u7O49QxF8qHkeUV?=
 =?us-ascii?Q?P2/VxNFYVr2OObrACPMZHuE4F0NXpkhtgGo8xVqKLWLekzTFBHpy9IkbIOHv?=
 =?us-ascii?Q?1qXc6eJuwdcXYQudXptdjpzDXxyEZ1JF1S1kCqFlaTxZRYMC+Vp0l+6GDOQN?=
 =?us-ascii?Q?P6KaEkJTo+y3KOfGq8DGF4SgU8WNzlBZtriKbqLdNpNnEpdoawGAuDX2JkvW?=
 =?us-ascii?Q?XW3hRcP8XLXewganNis9+uwHlH1ZSJ7xoAJZlQ64NCNSB5rljVvFfzMXwExI?=
 =?us-ascii?Q?DPCpha650+oJyrKCpGgjHiQud8BPdjqKDAojKdjeagleBteSbJkym63xMPRT?=
 =?us-ascii?Q?Ewa42aFVa2VA8IBKdtWRT1F/dKC5beyVNqxY2Q9u6Fvcd0wb/07cRyqL/XfY?=
 =?us-ascii?Q?iJaIOLANGOE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?io4zxq1dVysTiKu3PnzWGVpayb240o8MtpA+8HKnemLZbb+3o1fb6JlcygI4?=
 =?us-ascii?Q?8l1ceE5uTMV4Ob+fvenEj7X4VPLpipe/t50gWBQNVWuL869k8JwjCFpfo0kH?=
 =?us-ascii?Q?jcUsLdPKsGAJw4ZEWVYHep6jPfmgChe/SXnxjgkiGHs7IKJH0PZmD002qkUx?=
 =?us-ascii?Q?ZTxIGDnE7O0cm5uIEdqbzJ6pDujWnaeqzZE8hEFifd8Z8IyWdWj12crVLQxt?=
 =?us-ascii?Q?MLKGMiqnsdbWRaYB2yvtri3B7GZ8u7pa9uEcuvqWPlvMSazJQnQ1ziKgUJ42?=
 =?us-ascii?Q?sezJ2QXgIid0cWkbnNx50/ZY1iBCKgIdijySkpjmwdnUvXKorwicmje2//G5?=
 =?us-ascii?Q?fnj0OVAvgUaEOpwknePPu0fmkG+8vMVB9j6gKYvXNwVM5vATEaOfANbU4Gck?=
 =?us-ascii?Q?6hv4mghb87U2293J0eSmfrcANu/UENe/qmoxxRtiKaxBnS+ye7r2gzFiQ38N?=
 =?us-ascii?Q?WMO3pj+QVH0B1K8naCBbzIprXJH9KXPEmYKTgm/iRdhsbRdgv1K3G4ijk5rA?=
 =?us-ascii?Q?DJiH2VEAyWPvNVQJIXP7cHfNeFyyqcakFbiYl4oHYqncuPxiWJlQpzpi3y8J?=
 =?us-ascii?Q?UNQpzVyfDM/FPy3OwLZwvNwFmELVQRxafP7HeXDNLg3RZCX2KgN2SJUniBAt?=
 =?us-ascii?Q?3Ib/w4VADhZn/JBoUHI6Bl41Km2xXjY3k3rKF8kKMtzIaOKig0aLB07hlHuC?=
 =?us-ascii?Q?yC0qIfcxqWtMV7Qb8IgcgTDmgRbp6YW00T079DXxcz9FLnNGlW4YA5heAqqi?=
 =?us-ascii?Q?gUmZ9uQT0i55ci8+NyfY310261jB0v//wJJsyKtI/k6D0HNYZu/MugL26vGL?=
 =?us-ascii?Q?TYKfH6M24j2VVUDMDM3hRnzQFjHpklPCRMqTjzyhAzAYMYRXdo61UasxXvMI?=
 =?us-ascii?Q?/GqNOK4P6TR6RulPqOcOeXbA+MZt/JFtx4obsnmElm0myEM7l4IQhRorB4jO?=
 =?us-ascii?Q?OOhMj901BIEvNShB5lRHebKazWiL5f+IifEInY747bRniuJTKVIi6Lx5RujR?=
 =?us-ascii?Q?m1XEahlilPGk9adt0NgwTcSVMa+hJpV2Q8kkF2giy9jc25I93G5hwtwfpmdT?=
 =?us-ascii?Q?GEqYVW9p2LMhH0idmoq+N+m/XGESs16bW+hR+O2LryYAtlI6TdRbClLP7PiJ?=
 =?us-ascii?Q?4tOc+oFmS1jMGeZ/RbsQtLzZrXhqdkjg+BnVYtieqMfXO3il6gB03tbUXTTh?=
 =?us-ascii?Q?W96fjwFRoYh5JgB9O57EvvOv5aKq30q4EIUbHHzAozOF67hL3Qyh4onvM08w?=
 =?us-ascii?Q?Bovgfyfnts1BHqwvbiqNHvaeFborOhk18rfX5jlMBa1VbvTx/WXG3+7DqpR8?=
 =?us-ascii?Q?1w9hei6dhzDeoxqmDd2Ht9A4/O4Tlz/vjmK7GWl0TNpnte72e26sU2BBFjxf?=
 =?us-ascii?Q?1WGS5JH5sHsTOVkqj9O5w8ZSdk66MGocQSuemQ3qf0YqSEEHkL6hqjeRVTmw?=
 =?us-ascii?Q?zGLLYgLGR33vqsepeueJIdfsqvQkpFmih49oGdaMQjPYos6SVf5J7ifFNHIe?=
 =?us-ascii?Q?OATYyerow2BQAG8aT8ccq0p4szyo5eN3Ow8Y4Nk7hGorRk61WPu+Vr2dYKKv?=
 =?us-ascii?Q?6OrXD7MrZjm59edwLUI4jo1kOLGGCXJ92aTHGD12?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29632b9c-0d43-4107-e3d6-08ddaa86aa62
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 14:29:11.9087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Km/vPizbOK7v7WZVomsUTShbz+hKtHlJUFjT8f84ea7iryupGULMWVKubg8p6DT/rErRYXzE+NEGPNju3Oiq1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF7708D4D9D
X-OriginatorOrg: intel.com

Li Ming wrote:
> In cxl_store_rec_gen_media() and cxl_store_rec_dram(), use kmemdup() to
> duplicate a cxl gen_media/dram event to store the event in a xarray by
> xa_store(). The cxl gen_media/dram event allocated by kmemdup() should
> be freed in the case that the xa_store() fails.
> 
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Tested-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
