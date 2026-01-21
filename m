Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B050366553;
	Wed, 21 Jan 2026 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769034259; cv=fail; b=A5OP8nEkzkWbkRimfjfodeo1OC3m4KMm0SMFMQfd9ARb5IzCQtBYq8sJ+IycHTKuR+au3zTfYTE+rYgqI9vYZhlk4z9X6u2T8JHTz6JdLejpzMtG6+kfWr7xrS4xM3bALI7Ed5xBiXW4GUxQkzP72i7Fc42G1BOTMu2GCaBsFBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769034259; c=relaxed/simple;
	bh=oiKTM4xx85IvMqrhyEjgi6NHN4Z+t7tvvT2ASeHgJRc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dn76R4y6ph4FDEPBG3aVv8Q1HPaxoPccXdglPfdDu6Djky7viFZeF/SKgyziTAJY6dztHTnq7EzmcWtShde/tDZrB1AFg+hp+2UAr/LPVZP76zWIZKDN8zWlsfOlwIHG2WKDIsWjBMxI+SmGuBg1rZd2WktJV43uWhGX79GyIoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQb99ad7; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQb99ad7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769034257; x=1800570257;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oiKTM4xx85IvMqrhyEjgi6NHN4Z+t7tvvT2ASeHgJRc=;
  b=AQb99ad7HH3TWKI/cf+i1S0QM0e+4nbdF3jeiDUCKEA3pcUu/mxDAh7f
   G1n8i0gbIxM7HNXiQIdPtThCNrAY2o2fhIr72mUoyrSsJ2vDLesRwR7N4
   Vob9BeZ5OLG+jZaA2mB2zneY+/5Mj3D70WofgdPRJQg58ZrG8pcI43CLv
   n4th6K4dolnN9kRuwNXCERjNKjGRIg0f1NAB/aGD6s8WAj99toCWzbX5k
   BsxImTZCD7HegNg5yQ+GWO/bNjbo0kCTJ8KKK109cXL+Q30CaMLSfGK8M
   t4HyExf392yaSvkOc4RjZF5vkXNfctTwQ2bVRCEc7w11xKuwNKgHKxfBh
   w==;
X-CSE-ConnectionGUID: 9Vde4UM8TROnT7knOXkJjg==
X-CSE-MsgGUID: AKibBgk1RaqUtXvCoimnGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="74134779"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="74134779"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 14:24:17 -0800
X-CSE-ConnectionGUID: yTgkqU0zRVS4ytw6bQgrfw==
X-CSE-MsgGUID: mgk8K8fxRQukB6MjQ6dvOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="206880128"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 14:24:16 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 14:24:15 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 14:24:15 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 14:24:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJhEqvqVupU7p/JTH84FMJ8WdU2tvyodRYAAIEIYYRiLCSPEMTeL2fH9mKeExpAvwkeLcT+AH8TKdgaFGHC4CbHcisrPpf6MFHcyJJhaZsiHDgocOCDwBpjXNdmjW8dq6IKnBGLg5KMcpYYIfC4U20qD3c9boFmSJxoTqTrrh/l6pHzTPrdT+YbHZXZ+QOn1miRcuQrb6BqROYe5tPwc7eqlIs9Bg7nUOUqu7rfJe4i7sqOJk1gU5S/b673dHrol6feRvw3LA+FTMzsjvd5OlAZ/mb4ZpNXZKjCLx3I+9spNkPXow/Poc5UKSo0M38upzD8+cck/sVJypRKzylRIRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWV0AuQ/lkVO3Km9XJsECzohKjdMXt1bJiR0g112w/A=;
 b=AgElnJnn9PFqNWixBJdzzkm1IbSGK4QkXtqIGoD8ume4p36A3ig+Jl9XAhORbp0797HJ3hDN0ho+IgodnhvEm2UUpkd0WPVxZsTlxEBLhVm+lNT2oI6KR+zPVHAVu8yQ53vO9NZoUeEm7sAZtBkzw7Mtr5IBbHB8s3+A0tFY912d0W7rAYxBuMoO9zxm5jDRyYLKqvbbGvvtUhu9qsG0HDwk3+M3NrKAjW+0R7uyP5NKllNhXy6YMidXG6fyaG9hQC7jmX2Z9OZjekffnI4MLwCG/3T1I8raJawn3+J7O4sRauyrh121T4p/0uTAodmb0aRwp/GmsieQBC/1bdzJlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PPF99D0888FA.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f3d) by MW4PR11MB7102.namprd11.prod.outlook.com
 (2603:10b6:303:22b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 22:24:13 +0000
Received: from DM3PPF99D0888FA.namprd11.prod.outlook.com
 ([fe80::45b4:e171:6f5a:9f19]) by DM3PPF99D0888FA.namprd11.prod.outlook.com
 ([fe80::45b4:e171:6f5a:9f19%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 22:24:13 +0000
Date: Wed, 21 Jan 2026 16:27:23 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 1/3] drivers/cxl: introduce cxl_region_driver field
 for cxl_region
Message-ID: <697152cb75dd6_1ccf5a100da@iweiny-mobl.notmuch>
References: <20260113202138.3021093-1-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260113202138.3021093-1-gourry@gourry.net>
X-ClientProxiedBy: SJ0PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::16) To DM3PPF99D0888FA.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f3d)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF99D0888FA:EE_|MW4PR11MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 7239ebc4-180d-49c1-d4d5-08de593bce70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SbvQx+wMAVHYhwix5FXwqfKCWA7bESID2AzQsxbHu26qKio3BIl2Jp1sDT6z?=
 =?us-ascii?Q?FL2tkHuiVcYN9mVKTb3wRnlJz1tlzoVW+CoOSRS6hdl8MCc2yPaCx7W8Gi8j?=
 =?us-ascii?Q?KNga7QjBRxmG21cqpoQuDXnJIyENLBQaPcaCK+PB0vfSXzEDhVqYun1NHtG6?=
 =?us-ascii?Q?VI0mHps6Z0IHZaAhf2hkFlA/1S/Un/YBn4g70IkpKtF0GUr580saA38wzzpY?=
 =?us-ascii?Q?b+rBp8andciXuEubLNYq7mYp+J+tCbLUAH/IZJKVjaJzJVc0B2/69XCuM8Rx?=
 =?us-ascii?Q?4lhVkd6exl7Q8AkPkwohtOHXIIrfDW3aY0281a0uVn68kQUHFF6vfoMsoDmB?=
 =?us-ascii?Q?i6IF6PHRcMnbreNcd3WJEMh6EvbqzhYCqJlxIzW4kpMXTGvTFPDLLYazbH2L?=
 =?us-ascii?Q?CRdAR/lvglXCSCr76xqk9Y3x6u83319zaqHuAZxQaRbACSQdBevY8mC+4wxT?=
 =?us-ascii?Q?iNL87k/IjB0WvBtMiXxlYkNSPl3yAl6dV8IBOr3U5zz9M5ZHz0V5l88h2YV7?=
 =?us-ascii?Q?9SO9lNdiWOJnlXfiPUMzttMfRGnyl+003GgmXhX6OBOLngtFXPFJI+LMn0rs?=
 =?us-ascii?Q?iwt2OINOZwPzLt60hFrimm+2aauwcUrCX+mdA5WBgwfSI2O/EcmGpowc8uX7?=
 =?us-ascii?Q?LdQMyPmWNCfNkTLkYxgowQza/hZrkJbpynSO60uDSw2j1jAtApD14nWQmV7p?=
 =?us-ascii?Q?ITx5HKVe4JSHFYgdGSQCGDzizo54uOmIt7xeD7QVI7R1/i8qWTq/42oN9t2W?=
 =?us-ascii?Q?4s/+b5pBmfk15rxFJZ+axOKVMwIhaSUy1049mggFog1pD0929owde4SoWrgx?=
 =?us-ascii?Q?zP4KGi4h+z6pzlDGqkytlmwZ1LWqdaw1ZBS1zwc7OAyxX3IMuBBads3dzj0n?=
 =?us-ascii?Q?bwUDmKA7409b5xtI7g+fjga+LZPXH6NvjsdviucAOvALoVamh9p8Ze84DcFz?=
 =?us-ascii?Q?EF8K7igZbhRDxdyp4gchW2LTD1fc4bS2sDOaDrc7zLE0OOdhZeJNSsWQW+Ec?=
 =?us-ascii?Q?Ziz3oT8v37thomUb+trBFAxPAVZSHgMYnjFQ+as8/oXo9WCFumbwrYdJb9Gg?=
 =?us-ascii?Q?epOFzmo5hXggENXxDsd0EpQ95Im19uSUHFCCiO/8co5MhFVb4qEu9SUH7RPP?=
 =?us-ascii?Q?JQLSUhxFagJ9k4X5nSLGGQp5tQ8q80iVIzOgddMuUlkbgqvwySiMGzJZTu7I?=
 =?us-ascii?Q?tXxR7jomtgEMUo8f08AHa9QL/zp++TfC81KWEP+ZPh2K0nVGhSNYGxX6MOHC?=
 =?us-ascii?Q?aWJgcuZANnJMC7aM3ejh469AxeuXBprp49r9u5YD+ZezTNcleKRRcmVPBH5v?=
 =?us-ascii?Q?4RKOAOU2U6bvrynAwdNxKBnlmavtGKnvJXGKB9y2RNVtnufMqZmcnZ/EqU9E?=
 =?us-ascii?Q?AW3O1jYbybcb5XJP5Z2LUec/NNuJ67GdxmzKOpwvrNbjAc3Dd3WZhNktFWMK?=
 =?us-ascii?Q?db7i50wjugaKstx+XkHdjSnPBSnknVUmTJwtTTQq7Q1AnQodzkEU/0NTzU8Q?=
 =?us-ascii?Q?cyYnW77xbVKgYfiyhK3ESWYTVdp7GhXNq/aSpT0ekMbwnJmjhjcGVlq/J0EL?=
 =?us-ascii?Q?LQVB2szwG0Fuk8wtrJo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF99D0888FA.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OfZF5gD5gxa52gbpWBFKG08+sTPNHPlfjRyaSQ8aK0y9ph741LdZd3ANvsev?=
 =?us-ascii?Q?jebIWavYTW9wqyyouvT+O6765DkI47DAqfHwnJh2flcrq5qzHbMVS1TRFJvF?=
 =?us-ascii?Q?qU34FaiOqMjyOdIQVUjkquWQSdw8bCLskGisDwr1T42Jjicc1gPNwn2WJsDZ?=
 =?us-ascii?Q?KrJophdMYRPw+DVdiCI811Hj1NVeaJuggaZJMTzmHLXYb0WNb3KI6GYzG2c4?=
 =?us-ascii?Q?a5pwtOmH8n2MCQeAsuEoLciSDP1dRVbKNjXw2ESHB7XN3/GO1/HSjW1lgIE+?=
 =?us-ascii?Q?rHUGeLUdWl3z7ed6+ZGJkZd+A8LcjY/XfJ3xYQvr9aenLpaGhI2xdZJxgIPV?=
 =?us-ascii?Q?ffsGn4PuMT5RCA7VQHw6Ao7cLaWYE5XNRxNnreN35Puj51+PmdHGwoEWV9O3?=
 =?us-ascii?Q?BJja5qQFx53HeCjlJfTJeNW4vKTepyWW/eVeXvlZqcadwEFEk9QB/138Yq0z?=
 =?us-ascii?Q?HLbPBLltPYR87RwUwqE2ez3oHXgLPBQAd4ZJS2GuHpQ2jxNR7IOL0CH2UdMZ?=
 =?us-ascii?Q?/fAwvREYT7XCMiUcD5BYu0M5iYA51OS43yFXlDK39hbgVdiQCxqj0CplVsx/?=
 =?us-ascii?Q?PR+S4uTPEEWJNTrfwo+CT0p9ROfgRsQErLJmQ5qyJSMmu1t+naS/u+0ZpiA+?=
 =?us-ascii?Q?ZUukiVCKI4p9A0kYhCWBkT1U6WhmLEgB2m4qT9EDC46QiOnpERF5JFchtACk?=
 =?us-ascii?Q?MBd77yhGH/N8942OjMCVh1cp+5Gayypaiq9jC4OJn3LuEtSGw5l5xKgDGTVg?=
 =?us-ascii?Q?/b7CehS3eqyqzIY4LQub6Mw/EhXouQ0FQS5MOjqsRGnsIERcsi2lB5ZsoRQD?=
 =?us-ascii?Q?PndzUJmSyAsDat8p6+JqrwotHMjEpRZRQEtAwlJiG2bD+bmktcyF3cfds8qw?=
 =?us-ascii?Q?NlJKUGscHXg7goWLj/TUB60f199DXaKIK/+OqqH39fXQg5IX0U7TIYz0G9qx?=
 =?us-ascii?Q?VZiZNfd6JguA3EosOmWulSjcPc0ms3XxJUT5rBYdY71W1zz9sRcfE/hKL7ZE?=
 =?us-ascii?Q?5VDlDkP8+G7eQPugWNAzJB1Ijd5X+MLSwQh6KoPHjbJ0veGvVF05oMe7GbXO?=
 =?us-ascii?Q?Ruvq6nlAt/cRfVtdMtTEVObmEDqIkMAQxtUC8eENuBfLDqssSxGLA1wizv6s?=
 =?us-ascii?Q?d38787Hbt68z6JBeUBOxbb7XgohrSUc1/aOukmSIxmV/aHRzpluvCIQDxaM9?=
 =?us-ascii?Q?9Z3+QvJv6KUnct3m0EKy/CogD1l995RgtfspigHsAy2oq1VghA9WUUr4HLuR?=
 =?us-ascii?Q?K+xfwFGm7+ve/03pvx0iNO1ePpGqmDmFb0VQMjGsSliY4XB/TvIFqvWZeMjy?=
 =?us-ascii?Q?3qboAekHxaOnMk+UdffKY9pTz650TkErtExalyuAwB7W0dtKKLU0FxQ3mOJL?=
 =?us-ascii?Q?B3h/vb9P/RYyM9Fb1kej6JUHv8ovj2NFfiWYRzi3x0S+7xn5L7bDuz9Gk6oK?=
 =?us-ascii?Q?+X13zdDQ5vnJ0PJAZi2fzvdjAbLtMt3UMcBID0tyOuQXEFFXqecchM/q9nZ4?=
 =?us-ascii?Q?V8/OjU+VLTS1ocl88v1haEDVspr6GvpHIM8BzFQ6I2B+JUFSu6sUAGV42H14?=
 =?us-ascii?Q?T+NqZdd3jnrOSDj6t6AFQ6I6FcL8H9x5yR1PFGzEnowWk9lsOpZd3kdFgwbH?=
 =?us-ascii?Q?nWXsgTAUSgZQyuSW4bglVXrj4LK4MXP+VaUxjDd9eyvjOHlgIprGtQzcnW4E?=
 =?us-ascii?Q?2chAOy7oVhtVOX70dgIajB0Zpcr3tyW/wPvqzDdeUv/fv4BYK+yQ1PYjt5jX?=
 =?us-ascii?Q?BMxH9ckdXg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7239ebc4-180d-49c1-d4d5-08de593bce70
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF99D0888FA.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:24:13.7078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/FoY+u3pd2xffvXg/UZ8hMs70gFraFna8pO74dZz6qgcknnWDvv63yccxOwO7q/PozzzELsTC1lkSpebLj7zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7102
X-OriginatorOrg: intel.com

Gregory Price wrote:
> The CXL driver presently has 3 modes of managing a cxl_region:
>   - no specific driver (bios-onlined SystemRAM)
>   - dax_region (all other RAM regions, for now)
>   - pmem_region (all PMEM regions)
> 
> Formalize these into specific "region drivers".
> 
> enum cxl_region_driver {
> 	CXL_REGION_DRIVER_NONE,
> 	CXL_REGION_DRIVER_DAX,
> 	CXL_REGION_DRIVER_PMEM
> };

The problem I see with this series is that this is not actually telling
the user which driver is being used.  Only which device is being created.
Then it is assumed the proper driver attaches.

> 
> $cat regionN/region_driver
> [none,dax,pmem]

I feel like this will be more useful when CXL RAM regions can be driven by
different drivers.  I forget right now the rest of your other series.  But
I wonder if the actual driver in drivers/dax/cxl.c (the dax driver) should
be setting this field?

Also escaping my memory ATM, is why one can't relate the dax_region to the
cxl_region in user space already?

> 
> The intent is to clarify how to to add additional drivers (sysram,
> dynamic_capacity, etc) in the future, and to allow switching the
> driver selection via a sysfs entry `regionN/region_driver`.
> 
> All RAM regions will be defaulted to CXL_CONTROL_DAX.
> 
> Auto-regions will either be static sysram (BIOS-onlined) and has no
> region controller associated with it - or if the SP bit was set a
> DAX device will be created.  This will be discovered at probe time.

This seems like it adds information.  Since these BIOS controlled regions
kind of get 'lost'.

:-/

I'm not opposed to this idea but I'm worried that this adds to the already
very implicit nature of the CXL subsystem.

> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/region.c | 113 ++++++++++++++++++++++++++++++--------
>  drivers/cxl/cxl.h         |   8 +++
>  2 files changed, 98 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ae899f68551f..f8262d2169ea 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -626,6 +626,57 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(mode);
>  
> +static ssize_t region_driver_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	const char *desc;
> +
> +	switch (cxlr->driver) {
> +	case CXL_REGION_DRIVER_NONE:
> +		desc = "none";
> +		break;
> +	case CXL_REGION_DRIVER_DAX:
> +		desc = "dax";
> +		break;
> +	case CXL_REGION_DRIVER_PMEM:
> +		desc = "pmem";
> +		break;
> +	}
> +
> +	return sysfs_emit(buf, "%s\n", desc);
> +}
> +
> +static ssize_t region_driver_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_region_params *p = &cxlr->params;
> +	int rc;
> +
> +	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
> +		return rc;
> +
> +	if (p->state >= CXL_CONFIG_COMMIT)
> +		return -EBUSY;
> +
> +	/* PMEM drivers cannot be changed */
> +	if (cxlr->mode == CXL_PARTMODE_PMEM)
> +		return -EBUSY;
> +
> +	/* NONE type is not a valid selection for manually probed regions */
> +	if (sysfs_streq(buf, "dax"))
> +		cxlr->driver = CXL_REGION_DRIVER_DAX;

How does this work?  Doesn't this have to create a dax_region device for
the driver to attach to?  That is the equal to CXL_REGION_DRIVER_DAX being
set at region probe time.

Hindsight: It seems like this driver should have been called the CXL
partition driver.  As it is triggered by the partitions being found...  I
think.  I'm probably really confused right now.

Ira

> +	else
> +		return -EINVAL;
> +
> +	return len;
> +}
> +static DEVICE_ATTR_RW(region_driver);
> +
>  static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> @@ -772,6 +823,7 @@ static struct attribute *cxl_region_attrs[] = {
>  	&dev_attr_size.attr,
>  	&dev_attr_mode.attr,
>  	&dev_attr_extended_linear_cache_size.attr,
> +	&dev_attr_region_driver.attr,
>  	NULL,
>  };
>  
> @@ -2599,6 +2651,16 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	cxlr->mode = mode;
>  	cxlr->type = type;
>  
> +	/*
> +	 * PMEM regions only have 1 driver: pmem_region
> +	 * RAM regions default to DAX, but if the memory is already onlined by
> +	 * BIOS as 'System-RAM', the DAX driver will be dropped during probe.
> +	 */
> +	if (mode == CXL_PARTMODE_PMEM)
> +		cxlr->driver = CXL_REGION_DRIVER_PMEM;
> +	else
> +		cxlr->driver = CXL_REGION_DRIVER_DAX;
> +
>  	dev = &cxlr->dev;
>  	rc = dev_set_name(dev, "region%d", id);
>  	if (rc)
> @@ -3951,33 +4013,38 @@ static int cxl_region_probe(struct device *dev)
>  			return rc;
>  	}
>  
> -	switch (cxlr->mode) {
> -	case CXL_PARTMODE_PMEM:
> -		rc = devm_cxl_region_edac_register(cxlr);
> -		if (rc)
> -			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
> -				cxlr->id);
> +	if (cxlr->mode > CXL_PARTMODE_PMEM) {
> +		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
> +			cxlr->mode);
> +		return -ENXIO;
> +	}
>  
> -		return devm_cxl_add_pmem_region(cxlr);
> -	case CXL_PARTMODE_RAM:
> -		rc = devm_cxl_region_edac_register(cxlr);
> -		if (rc)
> -			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
> -				cxlr->id);
> +	/*
> +	 * The region can not be managed by CXL if any portion of
> +	 * it is already online as 'System RAM'.
> +	 */
> +	if (walk_iomem_res_desc(IORES_DESC_NONE,
> +				IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> +				p->res->start, p->res->end, cxlr,
> +					is_system_ram) > 0) {
> +		cxlr->driver = CXL_REGION_DRIVER_NONE;
> +		return 0;
> +	}
>  
> -		/*
> -		 * The region can not be manged by CXL if any portion of
> -		 * it is already online as 'System RAM'
> -		 */
> -		if (walk_iomem_res_desc(IORES_DESC_NONE,
> -					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> -					p->res->start, p->res->end, cxlr,
> -					is_system_ram) > 0)
> -			return 0;
> +	rc = devm_cxl_region_edac_register(cxlr);
> +	dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d %s\n",
> +			cxlr->id, rc ? "failed" : "succeeded");
> +
> +	switch (cxlr->driver) {
> +	case CXL_REGION_DRIVER_NONE:
> +		return 0;
> +	case CXL_REGION_DRIVER_DAX:
>  		return devm_cxl_add_dax_region(cxlr);
> +	case CXL_REGION_DRIVER_PMEM:
> +		return devm_cxl_add_pmem_region(cxlr);
>  	default:
> -		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
> -			cxlr->mode);
> +		dev_dbg(&cxlr->dev, "unsupported region driver: %d\n",
> +			cxlr->driver);
>  		return -ENXIO;
>  	}
>  }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ba17fa86d249..e8256099de29 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -502,6 +502,13 @@ enum cxl_partition_mode {
>  	CXL_PARTMODE_PMEM,
>  };
>  
> +
> +enum cxl_region_driver {
> +	CXL_REGION_DRIVER_NONE,
> +	CXL_REGION_DRIVER_DAX,
> +	CXL_REGION_DRIVER_PMEM,
> +};
> +
>  /*
>   * Indicate whether this region has been assembled by autodetection or
>   * userspace assembly. Prevent endpoint decoders outside of automatic
> @@ -543,6 +550,7 @@ struct cxl_region {
>  	struct device dev;
>  	int id;
>  	enum cxl_partition_mode mode;
> +	enum cxl_region_driver driver;
>  	enum cxl_decoder_type type;
>  	struct cxl_nvdimm_bridge *cxl_nvb;
>  	struct cxl_pmem_region *cxlr_pmem;
> -- 
> 2.52.0
> 


