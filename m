Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B03253357;
	Tue, 15 Apr 2025 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744752987; cv=fail; b=h3H+9kI6UYhl88BxMZ4sz58zVvDavF24uvjHXfLaOCU1sgbqD1uEmW85PdR0kIBmDDJFU2q0forYzPIkufir/82kxI0tV1W8dL704DVqA3HGXyXU9+/Z5Q2Tu88M7MJW5jVFRh3Fy6hbkCedXXZ6Ent/DXky2BwkqHF72+SYUNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744752987; c=relaxed/simple;
	bh=qlH4gqR41ApITT4NJkrMQSLIQ2PozrHW0UxoXwWYnMk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cUDTjNLb3wLB+iDgbqd3hCFtm9ncmGtlVXxmJJ10uV/2eGrX6+Nj/sDbVhAf66viB0aXwFegRpHQLF9ISdJUAkW6lESUPnf0sFi8SjQfeks+hnjRhipZIiyb0oAO7uINu74559ICFXtuWzkS8FGUCjwF3OJQ8LC+jLiU/06nYOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dX6qgtWJ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dX6qgtWJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744752986; x=1776288986;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qlH4gqR41ApITT4NJkrMQSLIQ2PozrHW0UxoXwWYnMk=;
  b=dX6qgtWJkSHJ8UIjOd7T+IB2h/goWneJ0PZlzR9t2ARuXEub1P+Dq7Bi
   L+hACMM3kN57lDSXb39uOk+fwh8/UddyKUSEM2zuU1YeziHk7ALPhCOdD
   r/BuSL9Oil0ExIUjW37ZrcHaCb0+cUk/eNg46EmrNv0usfsg0SK1DtCeu
   JzMFjI0iLVPLbqOpNH6LDXDFJWjw4BhYu+Xm5K8sLeoBIQVCyCWDg0uAP
   LpAhMLuERiJ51kkqdub1AF+hf4aTBfcqVlnbueMaS67aZehsJnhYdgs7W
   nnO4xAV5EPz+tX3vQQcVJYQfA4Zi0IVxrnu9LfudVYPFft9E8y7WyAtre
   w==;
X-CSE-ConnectionGUID: KwyxjBpvRpyZLYmNBja4Ww==
X-CSE-MsgGUID: Crxh5W8/Rk+cUQzcV9HIlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="50105928"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="50105928"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:36:25 -0700
X-CSE-ConnectionGUID: iCRGeUKoSyKgA5k/nhMyVQ==
X-CSE-MsgGUID: DDFFWZOzT3KChkaqu1DIeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="130197417"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:36:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 14:36:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 14:36:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 14:36:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vP2Td27vTQnBbAWdrUD5RBRuaLaKq8tK8FXfRoOOmiJLaYX4I8INFZysBpUavN+Yt8NRGbgi8inDpJzv8w/XevndMKqXr+sxT/g3n2xvDcLrpvzI3yJOWNu+0ulpyZeto+VNVClraw+jaFUfBrYtS8TgxKEy+3JYaJ2wS4u7I+jpo5wTlFiSbKWU4aOIlR7ldYWHv5MWMqalBCwGGDnjVz/Tuwwa+hT9n3Q0t+daV6GBNxNJWyMD0FXjlKqXOIplOvOJtwn91lf8PyGVc5yK5MHu5h/YtLNORvx2GtzdNHSbp3NgXHmj/z1lu4KssQkHKPqCv+W/7v8CgLHcdQ0puA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0jS4DeWtcKa8FYXqwvWM7HeLqYD1q97r4YZSqhcD98=;
 b=u2nW1QOVNdwJ1lL5kXzVd0lLCdaYHZNC/NfW4ySaapMsUkBMmaa/euMWMemODiDAS4unCGyt7GlB7lWrrATnSGxAask/GSm0Q5XhNAt6SpiW60RWs/5rNOu3rdOX/3PsJ/6yN6XTifH4eeR8XG6JzcJM8UPJlhZxUdT2BaM64bVNt98uMcAZ8jM2XluYR44vLfNKo0J2KA6AwE3b4LBzlGmHh4+/fwLRBaPGJ8aeKS5jZ6Dm4Ep8pqJ35nacDsEibDkP8LMlKDxFCPxRU1REe5OcNUoK+ue1yQ77beFWtgZWu7ZX0z3HQLROkCxJcpdCqokkX02jnqFOYgWmva/I0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by CH0PR11MB5252.namprd11.prod.outlook.com (2603:10b6:610:e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 21:36:07 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 21:36:07 +0000
Date: Tue, 15 Apr 2025 14:36:03 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v4 13/14] cxl: Add a dev_dbg() when a decoder was added
 to a port
Message-ID: <Z_7RQ2Wk8ukoAegM@aschofie-mobl2.lan>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-14-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-14-rrichter@amd.com>
X-ClientProxiedBy: MW4PR04CA0235.namprd04.prod.outlook.com
 (2603:10b6:303:87::30) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|CH0PR11MB5252:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe3aabe-9684-44b0-9759-08dd7c658828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FFtA4n2BToTPi64KOsr2bxCQ3BeVfoImNNA9Y4El/GIPJ7JerBWUQaRFpXRb?=
 =?us-ascii?Q?/SqfiO7ymTNLBw9cRjC6T52787H5/RcpPMejn1mY/wAIw9Ou9e5N6SUsZ1bn?=
 =?us-ascii?Q?/6XJo3Xwo5gC0Tvu07X+2lJdfwSMEm+fEICG1Jyz/YJFZLZhQU9eEVFMKpkF?=
 =?us-ascii?Q?bD45Ag1yaaNamewbgUAtig20VKE3jnxpiCUMXtSxWX/enFdq64CEHtHGtJu/?=
 =?us-ascii?Q?gPm8bQw2iKckXIJFitNPHm+vaAKY3ecHrg6WdbF0RfDupoyBIekrb8u95Oxh?=
 =?us-ascii?Q?gquBK74OenzbvfCeEEtFa0vNnzuFgj8QfzIsfI7gyHDyXsjannf1j/w+DQ+j?=
 =?us-ascii?Q?DyACPGpJT/w9Hj44DYr+FX76daNlTkvD5DW//LFiIJe6Z98CDixrzYkVeHSI?=
 =?us-ascii?Q?YBPx2c73Xzz4ByvjK1zfAzYvYjTXrqlcPZke8EAeB7PGtZyA09SOeuqhvQmc?=
 =?us-ascii?Q?5b25uvMnGu585nLUsBAj8Vxca0SV2OZypmFjGpmUwzGfO0asN9ECAzsY69tU?=
 =?us-ascii?Q?OzngPjPInqNy+QA+uj4GE54AP1dR0NfBjQZXlXK0I7mbvYoIaRL1PMslTLRk?=
 =?us-ascii?Q?gb8aFDHrHemd2ZUTQaiDVD4eW2MbY15zIMlVSD7vp6MDSGiFxs6MljU8kYHW?=
 =?us-ascii?Q?vbLHJqgh1XVKIYby7qXyX3OM+7bOOLIZcLjINZ+yXItA0cm6AHp83sQesoJR?=
 =?us-ascii?Q?56xXUArOXqI1ZQfDSUe1o1V4vSJbAAxLSyXCgR+HDW/bHV+aIjIG8s6TM7Rx?=
 =?us-ascii?Q?KCmiJEH4QcXZu6EkJ5JC2w0TYSqUS1ddvTe7bOUIKas1nXxTWl+LHANsBo/Q?=
 =?us-ascii?Q?0uaC6lVpxEh9Casfsw9rkFZqbr05zB/PqzxLJIxap/JKCUkgRca5LUu1Abj3?=
 =?us-ascii?Q?BNeKXaDkPXQQabMKjb1UePuORw9Oe3/uUr0kNe4vztvPV7A4V8ILM8a7Vh/M?=
 =?us-ascii?Q?x41cHMZ5GZhdRVnUo+LJYCrM97OR5LBvDsalaNKTO9x6BGrvuAlW71d934L7?=
 =?us-ascii?Q?eUaDpab6fbxk3//V9qgdDS9tn4UgGe1JdohBYhM9HNQw/u7SjPKuZhi+UCOI?=
 =?us-ascii?Q?HEt6K29T83kY8/t6QD+4QT2ATQ0nBtPVutIo5K2vqC7KQ8LLOhTwfxR7keps?=
 =?us-ascii?Q?WDo5qIhagdhMnCWkoGDs1e7vF/DziNSkWuSJVkX3SHIHttU8fVXofAle5qyJ?=
 =?us-ascii?Q?dYgB4wquuH/i+fV9wJz9Isy2Qwa99p6NKdatTrwS7RLotlSMHdWtZuLIF2qP?=
 =?us-ascii?Q?Pqm7syX2OFHdLJOe7Zlh43GEaa8OWGekkLkR1rZ2juPPiX4XBrc/gW5ubqT4?=
 =?us-ascii?Q?o8Dp661PJc+HE/OSI7+qP0P2eUJYpUiaHNvK2/1ehNzXuq4BO50FtEN610cf?=
 =?us-ascii?Q?fd+/zCtoVisxsCWqzhtDDI5jg5acQfuu1YHzI9oARvu3p29AzigqegsKsdxw?=
 =?us-ascii?Q?139Wen7LTdg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s/tFUHHXcYRvraFHzbAoGPvhVFapcVKFpnbYQxYrCpXC23v0z3dIqBeu9PxF?=
 =?us-ascii?Q?hr6m8WmovBFaJGU+0Sat6TIPDiynXyu0/kwa0GgG/P1CNOJzyGaMs9nPsYr7?=
 =?us-ascii?Q?KRoDB5STgeYMsLZqrhGbLfKhyGGur3BK9s0aEQ9YGGZ06a9NgwyCCldD3lID?=
 =?us-ascii?Q?L/0o1/ZQSuSMWiTewkQnpZ9LoRneGmrrhm65iaber5IO+d1o81tOHU7Qi/QO?=
 =?us-ascii?Q?Pu2IOBfHJvpP0hSOR3Bsj7TTcCS8ngypUi/4C2YwTj0P0c7MzT3iu2zHNcLK?=
 =?us-ascii?Q?W9clFwGVpkQqNXBKQAWyJHrZHeZvLqf5iqDvqbFYJHB9WKGulP/+TL/5jxty?=
 =?us-ascii?Q?5ElLI/8UdmmYXHL1m89Cn8OxuK/5XA9IramVcMbOQku0nV819+CaQkCtEl9a?=
 =?us-ascii?Q?sLa4HTQ2/CCdyGhvZkTG/6x3meS6PB//CsvGSv8blilFTNPJObeli+xpynRX?=
 =?us-ascii?Q?s7kIA8kBdybloG43MKAWXWQH+OnYPz/hDVnX36R+3dMw+AZlPVKNXA3ZFrI7?=
 =?us-ascii?Q?wQGuaY+7Xz4Xl8RKdjaBA1QvMLigqB4M9t8+fp1B1VAdVZBPL/SC+sEvSDCG?=
 =?us-ascii?Q?Yilf+ecStWYq+qf1IUU9GX+RT9IiYezxu6v28ymNY5MgY5mhBdPLVPVM4BL/?=
 =?us-ascii?Q?DipPaOtnLGlkK+VRbMhjYTQsCyKMHJ3TDqqa8TPPaGOl4hoqUhkusZy7kf7/?=
 =?us-ascii?Q?itdAx/eMZTx6WT7I++9c2iGy9oBUx/B+fmhhLCqk3EM9k5GDmof35iVw2naV?=
 =?us-ascii?Q?7l1HVldPttlhMrzE5veUE/jkNsfvktdtApOl2XLw6ufmgZ0Mn/n57xs2UM7j?=
 =?us-ascii?Q?iajZhQ1K0gIyMOmvJ76sh7RwQCIiADQHObqzvoaMdp9OZDBLDuwhic52QdKr?=
 =?us-ascii?Q?bIujXARhmHlhjhxWEEeyf0XvD7+pb9hAn5U/Yh0XJokOU63NMJjsyh8lNf2C?=
 =?us-ascii?Q?UcmrIVnfbIUcd85apow3DEp2DWyumCRUFSnjrHlNpe6tXaKfFalUt3QxqGRd?=
 =?us-ascii?Q?RivxnmccyBt8its2yv+EGcWuKKm9Av7ZH/4xho2Rm8k1Nb22GqTdUiEBa3Iy?=
 =?us-ascii?Q?E+uEwT1y/kFw2Q4HvH872/G002MJVM08qZf1qdTSF9P0q0MnenRQTUzHi5qk?=
 =?us-ascii?Q?RqQOHUVx7iN/7JnAwQMV7N9MuOSPh+vWRkdhzEKFQPYCjTGwyQdI0YQEOiWI?=
 =?us-ascii?Q?dq9Xc/cs4av1A14N2S2h3tsEvod7yE2eVaKMz3V1iv+KZnC5a5cRyqSX9Aop?=
 =?us-ascii?Q?A7v2NERVSwE8B6m1PRyS+o8eNKJoSysPVZIvIaeruYnmOIPJPpKUtlxBnMAy?=
 =?us-ascii?Q?xgSWjqoKE0tk6aBKTYMc/cjnPok87lq4dF4gsB52DBz53Mt5Lx8KztBMqdEv?=
 =?us-ascii?Q?8dPO5LCuu2+eDEI3tiqsRkSbmkbfNzdAKTqK0fF1uY8UZ3ivaXZv2aie80MI?=
 =?us-ascii?Q?oF56NQv9fyobFqgOZermjh0xhAsaLN5Z0PX+tmmJaf4Se4Pgbj5y6gpCcLRc?=
 =?us-ascii?Q?SQ+ykziKLL+Vdp1upOhd0omxjjGssb/qzsh/HH2evKzmZEFM2RSWjsQea25H?=
 =?us-ascii?Q?Sazb2lTPwTTgbUVscBRhbTZfm8EsoPDuZGOg8iA2Pm0xq4WuRD8YCT85FYUC?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe3aabe-9684-44b0-9759-08dd7c658828
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 21:36:07.6033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccKEVevXi+NzFrqVWMUfenzqFZC9gTj8+k3K2VI0GPJGzdKAncYqF+z4bWp8dPaYiV3PlpIH+G82PlgS2bI87ROSIV9pvK2y0ilYz1k7v+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5252
X-OriginatorOrg: intel.com

On Thu, Mar 06, 2025 at 05:44:47PM +0100, Robert Richter wrote:
> Improve debugging by adding and unifying messages whenever a decoder
> was added to a port. It is especially useful to get the decoder
> mapping of the involved CXL host bridge or PCI device. This avoids a
> complex lookup of the decoder/port/device mappings in sysfs.
> 
> Example log messages:
> 
>   cxl_acpi ACPI0017:00: decoder0.0 added to root0
>   cxl_acpi ACPI0017:00: decoder0.1 added to root0
>   ...
>    pci0000:e0: decoder1.0 added to port1
>    pci0000:e0: decoder1.1 added to port1
>   ...
>   cxl_mem mem0: decoder5.0 added to endpoint5
>   cxl_mem mem0: decoder5.1 added to endpoint5
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

