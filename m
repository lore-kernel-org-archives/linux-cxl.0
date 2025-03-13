Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1375422612;
	Thu, 13 Mar 2025 22:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741905073; cv=fail; b=XIra3XZBOqPD0XMJc0AEzyE6qxThnIuejKEwvQyLPtiRoWk0/21rzd4ksksEGMZMaWCGsxpJbxoxBzG4v/YzvhrigDmsWtT8hBb1PpWOQlA9S58o7TV7tv3jYGKQW+Ku+V701bGTM8QuhVV9DBnHU8J6BkBzLWGDNiZWx7gy1po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741905073; c=relaxed/simple;
	bh=PlBsswtbgwTomG+yNdBDrvw+glbQi2qOLi8ghKpaeSs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ercKJEyLJUuzBioxC9Qjx8M3GvMMTaG7mbvvbEfRSHuIfY+IRhUF+vSbr3EPbbar4KD0zi78vcjy5SEaClZesQLu4RaXas1euAO4VBeUqjJFC0zse2UZlLdUNfVDNP5J7vbqZUf4wKt3vo5YzavHAisxpBlbzX5UCYldlBXVmfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X7OjzGP0; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X7OjzGP0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741905072; x=1773441072;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PlBsswtbgwTomG+yNdBDrvw+glbQi2qOLi8ghKpaeSs=;
  b=X7OjzGP0jhbw3754GBCF16f2Ce7e1HUemCoOCzvenj0y+SRDXMZ1FHWZ
   HbB28Z9Y7K7uk2vnDUzOSNJmxf1xIwgWrgHu6+seQBjK4HbZ699gZHQkN
   XrVwmmGmlyUANe6N93D3wl/TelVmgi490RC1K/DNGCZU5SOMIcdCbu+od
   KfhsHXjDOKdLAWN7DpQZUHnoO4uirPX579HPuZ9y5zMlFP3fvPNjcZorP
   xwhn63gO0pkGAuedLHCABY44jCVdPy3LkIu4x4ACL1WQVlK7g8zN6WpZS
   JEDtA5voXsPxEap3CQI9hhAWGN1WfBs9mWWWuqVjK/tM22i/IYSAj4Yjg
   A==;
X-CSE-ConnectionGUID: FBpF/ZF4S8WhYN+C6QthFg==
X-CSE-MsgGUID: AsoXzWrOTUmV9Bw2KD5fHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="46834993"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="46834993"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:31:11 -0700
X-CSE-ConnectionGUID: 6L0fr1C/RpKrYQvMHh9gAw==
X-CSE-MsgGUID: DvBUfEJwTwu7Cn4VUmlfqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121297516"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:31:10 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 13 Mar 2025 15:31:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Mar 2025 15:31:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 15:31:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTua8CWK/sRMx0Rbb7DRJdoX8d0XAl+xwby8DDO2Vaxx/En5RpdeaGZkJKEOF8YT7AThZo2W8SpOp3Mceprp9/vivnNjVh23U/PalyoCkTBBraeK6IVCXfDVbyAD7kC18a06zFe7GBzoxAX6fx+lq/QMi6gCh9j2yhmGbqyDQQWUpgC/5ZMkEEX0YBuC/8arK1Ws/L/60BDwYfSG5l/8nk/CQ2kv3u9OeUL8jhlwNTkJSoleECDVWk78SOpg1NTlPlS+oIOBR5w3SbHD6q7N1/7IFTsIecOVJhBs8X1PIkYewWGWnba+ed7o06tHfxbKVyFAPFl3CqgcO88IrDmqSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2creFav/4iDTPhG5+77VKKCV7F3e8Wctpo08ws3JlbQ=;
 b=LL0254fpX9wXJlhZEXojr8z8CDZN12rsCyprNv6cS456b5pKysTMhFjRrM2fcWaR5U57s2PdGDXKIzg/2k968BiggiuT3E1dAzcaex7tsOPoQZU5C+4aXAKRrqTZaKodrHLpb0MfpB44dpZQ5lGGt+YdVyTxTEyVTeysAz43FCYT0YtVkvqMTQbHAE1Y2C6xZV3BDaH4si3VBEtNunl7OcWEWEFTnHKDrr47SBsgGibju4yYV9fJdNaL1L4WI8eVPobykEtk6qJo/qe/JeMDRzSLxMNR1MsTjs1gT6J4IhPOPZrHn1/LeoGDs/4L/UTHSgyMtJwUyzlZLdZ6Vht4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6190.namprd11.prod.outlook.com (2603:10b6:8:ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 22:31:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 22:31:06 +0000
Date: Thu, 13 Mar 2025 15:31:04 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Chenyuan Yang <chenyuan0y@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chenyuan Yang
	<chenyuan0y@gmail.com>
Subject: Re: [PATCH] cxl/acpi: Add Null check for adev
Message-ID: <67d35ca81debc_11987294cf@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250313190753.450546-1-chenyuan0y@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250313190753.450546-1-chenyuan0y@gmail.com>
X-ClientProxiedBy: MW4PR04CA0191.namprd04.prod.outlook.com
 (2603:10b6:303:86::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: d13dc0c9-f0a1-4735-73ab-08dd627ebef0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r4qvRrr5+VXwJ7RNShPp+OvTmW9vVlCE0FqMWUmF+QPl4sphXnxEyH3N4Jez?=
 =?us-ascii?Q?+cScUuEGTJRIOrT+TgxdjIax8GpsEAVwFw9pzADtnAp31sfq7aSjkHLvHoNQ?=
 =?us-ascii?Q?1Dh9SH/84izOEAIh3zwrWY6h1uaa7Y1Sm344DRXCvZLvCAksFfUrTz2dCsK9?=
 =?us-ascii?Q?SBCLch24b2583djL4TphUyyks4l1g62y3DYn28OF3NYJlZWJpCrXGsd8mC+W?=
 =?us-ascii?Q?Gom7/2caCSmTQgAe/a29/It8PnoFAyP3iofO0pCh+HuLOaAQaZbLruujTze8?=
 =?us-ascii?Q?zKVxNWth+cqlgm4NINY9mNCEbUA38H/qF1LY9FY6ul2sgxw65cra3DFE4V3m?=
 =?us-ascii?Q?QHlCmb6+rTul9Dmu+OXMXADzlXK5NbFHvDPPdT0Zi5tKNDbBlccUdAGNSaE9?=
 =?us-ascii?Q?59nDHCuqxD+u4bcHHkG4HMaIxTA9TTMN+M9CgTQ5kL5ehvt92ZE/fzDnICXa?=
 =?us-ascii?Q?hVbdp72FVnbHGfuFFhiBafErHIpErArJ7qglXrkTGVMtUk6xfOjIYhRZEnOa?=
 =?us-ascii?Q?wBCHyoi1hUUtL4PogwLhSfAUGvarObdvSYxTEFkz3wfbn6PVQOnYu6dsdH4i?=
 =?us-ascii?Q?55Yn99SmuT8yFLNtIVHUEB36lE+w2iL1a6Iv4/iRlQWJZQg3YKZzYGqBIksw?=
 =?us-ascii?Q?qQdwGqbmH16zAjBcFbopDC0CknvrhBXJmdFUuIhb12eZhroKtg1EeSr4hh8O?=
 =?us-ascii?Q?bQmDCemdvz7m+P8qZatPciiX/YbcZ5mNRZsKx2pbPxHzaSNK623uX/EEJz3s?=
 =?us-ascii?Q?i27+2OMSd3I+t4hGWiv8yePbHVXEVMoKQ3cpxMr9HuhnOXaSjCxCc4igPQxI?=
 =?us-ascii?Q?anJSjzhq6b+u6ANjKJYAUMxwTmYFD4/43sYPnIzQOvnW5DqULMrdI6Xr+lWv?=
 =?us-ascii?Q?2IE5K17oPjzJTbLARCQ/ol6rnkyx/7QOPhcRve3oYLbszSio6v9KKuq3O5GN?=
 =?us-ascii?Q?NnconUWaM71myJdCpRJOuTWX6aqAyNHg+9qHf5xjY/oqZQKwnr2PiZCqKHLY?=
 =?us-ascii?Q?doQKB/vAgNa5GeTZlz0HvMm1cocOSuwG8LOkmHsP093hmrLmWtOUO2ygt53i?=
 =?us-ascii?Q?xTNYLRthtc1ECAYmAo0f56o5UqdZ/Av264RDX3cEMA1S72Oqd9/szn+fSRFT?=
 =?us-ascii?Q?VhtWREj08FmuNz/9PM9GY+xhXkurHiybljEn7V7WVvY42ntKlasvCF0rYPvi?=
 =?us-ascii?Q?/J+UwtdQHabVy1/kjcweGwE/yvQVfCfQ762pv9tITlDsLTsuzypFEqlRZom6?=
 =?us-ascii?Q?NZQamWIZdkGDtqKwbC+jizmVm+jC00O3qlfjcIVeRDmEIcl0WMFcEIPApUb8?=
 =?us-ascii?Q?+1cYVHDl/WxPhnSIyadnunM9BwTuqBBaja0nXkZCKuGRiG8LrRryiboPCOto?=
 =?us-ascii?Q?RVAxV+o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fwmxwOI8EHqHqzbchS+0Uvl/k5Yn/TwQa3yCmpIAcZ2xYqy3GABe5s/1xtwc?=
 =?us-ascii?Q?rIS5TinZ2IRXRmLswvQIm8avSRGUzkLoEqBKoDXVTz1rbwQ3eDmpSaFLZWy8?=
 =?us-ascii?Q?3XFA2VF9xkFbsfid840LW1EZzKb/hdPyPANAG7Bb9TethMp6mSQQY6JWYcIa?=
 =?us-ascii?Q?CzWzTld/HIokOMeyWFT70IT20Grxi903bOSpONAX7T5Vssz0pvykJ3vN5bhW?=
 =?us-ascii?Q?Vw4PuXIZ5nb5jbhhSXiR4kcq8E3n3agN0U8RU27WQf6m0fet46qDwthlcOs0?=
 =?us-ascii?Q?LwC+pGl4UEL9aNy/Fni2LvCVUDtQUeClV0jtWL7umMs3ZTSFISi90xXK3+Hc?=
 =?us-ascii?Q?hWZwBUYvOH+EHe4AcswJsi3TBP7fILWN/5pLPwWn/sttnKtx9b6tVNVcGrFv?=
 =?us-ascii?Q?srfkQNlvkcpCqm4HCFPPbWN2+zTAAspVmeGosWKjliVKuc93GXZ/lnGobeM2?=
 =?us-ascii?Q?EJij+3ZrKE+faPKQMj06lu+SJfGpSpST+iZQB15LVG6whpJBhvpz2p1WBbmc?=
 =?us-ascii?Q?nc4G7loWDXR93bHEXwF3LsTXPM2CpatQvKKw4L8N7xYNP3zoxsCY1b6qMnmJ?=
 =?us-ascii?Q?c+lGrROFoBHM3kaFRa0j2mtrQG+8vWrRBKeO9rR3/oqpquOQ51BBfhd7++no?=
 =?us-ascii?Q?oAo4ybrYCf3yd+oPxBUo9GNIF1h8ZIuAwQKzievlLCjfB2rS2J+5v2eWwUe1?=
 =?us-ascii?Q?6sK0mJbAUIa7oQSWVR1OsEVcPuK0sug3AiSqHh6tvVlcH27nXFat3ibLkZw1?=
 =?us-ascii?Q?laBCORvsDcYGdg9U4yZwFx8fEihXYlYKqm26oyUBu/yj/Ex+GMSlR2ounI6z?=
 =?us-ascii?Q?nL5fsQavguP6LC3J2PaCQn3PLtglczLugnUxZ2Oq+s0IBiEzGD/Toe4jtk21?=
 =?us-ascii?Q?xpvVunBEfgAG52tRjo6LEK66o+unHGKVyLATMWU4/U2V3VaPJsBWZ4fM7t96?=
 =?us-ascii?Q?h4PDRvUKNR3WV+mM6Tmhc8vfIZ8+XfSA3IKNZzcK7kMV5yRn4+MeaF6ficbv?=
 =?us-ascii?Q?MhKGMUewgGNPyDXn18ayvhCKbus//2G55YBwjECXEtwoRkmSa89cRhcJ5Q9w?=
 =?us-ascii?Q?2g+pjhQwoisw/MPx+cqmZ1eC5HHo/Be9L44ee+oXlj4HYi1ALf6IrAiMsZpT?=
 =?us-ascii?Q?kE74jwMP1lqyvZ8iHlW0OMN79zVgm7xIwEFXDK2RURJ+xAB1k1hDopUn1Rl2?=
 =?us-ascii?Q?Ve1u/Zz4Q3GkMglryfXimP/9hpok5c1hyJjOrnueNBHMR3VmBbXfYhRgjpbC?=
 =?us-ascii?Q?Z5H9uneZyH1Tf68z6M3SU1fFOOqnzm+MOemM3FmRgbqJM9VkiRNeZnxFg1gM?=
 =?us-ascii?Q?i1cRrPrP/7e4IowMFSbKB6nSa9RyIYD0U5kmDpRkwhpf5yg/HlrLLELXqfQc?=
 =?us-ascii?Q?IUIVEc/xFq+fDm5AOpGR/jI2plRklxr4ooO/KAqWU4dGIaeRvW4fwunmjyVP?=
 =?us-ascii?Q?EvQd8MquDKt69nScxauD5sXMBS0k4RnE1S9k4m0BygnF/mdVW5vy584NiOOs?=
 =?us-ascii?Q?jrRdYKp5wZLyzUsrg0m+cbdyRBzcJcR9K47grSaTEKCQJ9Jk2onUMstMhfZS?=
 =?us-ascii?Q?/zi7pn/JMiz0M7jZpwLXQwKpfzjsPSiu/oUANIrDUagWgBtmQ1RC2AhXubcV?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d13dc0c9-f0a1-4735-73ab-08dd627ebef0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 22:31:06.7142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTihT1FYvM9mgNhhCQ6S7xUd8LMbktqJTD4G163+CfoZ3jd0wmEWiSrGtvj/58p+UycqYIKyHeKOuSLI7Zx08KgdqF5Va3dbt5VxHc21Csk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6190
X-OriginatorOrg: intel.com

Chenyuan Yang wrote:
> Not all devices have an ACPI companion fwnode, so adev might be NULL.
> This is similar to the commit cd2fd6eab480 ("platform/x86: int3472:
> Check for adev == NULL"). 

No, please do not consume review bandwidth with patches like this.

Read the full commit you referenced it explicitly states the failing
condition:

"This can e.g. (theoretically) happen when a user manually binds one of
the int3472 drivers to another i2c/platform device through sysfs."

Then think through whether that theoretical condition applies to the
cxl_acpi driver and the ACPI0017 device.
