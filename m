Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9841C84CB
	for <linux-cxl@vger.kernel.org>; Wed, 10 Sep 2025 00:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757465605; cv=fail; b=bwI3X8BS0a4wSbGFfsxFN93lNDxfxijn9aZH8JjFXTIlGCT+U8A5sqbYEpwu47mA7lxSyATlaHhvOkyOZBF1RkF8HQSmnMUvRz8Tsjs6FICxUNTHi/g72qoiSQhG+1YGwQsEoTZD0PJrkTjbxMb/B2VncgR9gRs7xboMowsF9LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757465605; c=relaxed/simple;
	bh=F3cp6hZ1qn0819bwEUM15L8aHNZFtUUt5urLDpkf3eQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jXhkfBSte3o2FbLo5KhQbSpq7g3ITs4i3P0ijrD3ytW1ipVEGrytH9f3jjmPJ4gaPE1ES1G5FVXcxfOlrdpFGcKB5b53PN98WA75ZCs0j8MNvVm9AnMzAyxa0jIx5UqgLamEE1PC448wcLXYOeZZMI/LZGDxXx50x5OWO/11CCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GqEmpSfe; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GqEmpSfe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757465604; x=1789001604;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F3cp6hZ1qn0819bwEUM15L8aHNZFtUUt5urLDpkf3eQ=;
  b=GqEmpSfeYRtIYZrkIH5P23pmqC6fFZ+RuJkEq7AmCOY50CYjq6IOiN/j
   Y96a71kGWXeEAgE9seE/SBAUjrL/pzki9r4Bq2+q4pqU0ujdU69kCWTMs
   YWoLf3xdw+2IIpWFPjPoeaiXg0qY1KN3D0nu0l0MPXSB+tYenGtvNEv6W
   +imb5JwxHWHbp3rYIN1ocn92d8CQ3wL9RkDBZF8hudHc4uig1dry0gnbq
   R1h2r7mw0Dsy18SJ0olTkMA/iuV2q+brNjVB+AFE+eIOBerrVInZGuS3x
   NlsqdaF8Na3lMnHlBq/gCquhH1qd/+Q9XsnB8qgFkcCBYlb3tJTg/8BSW
   Q==;
X-CSE-ConnectionGUID: 62xSyPONSdqcZcFOizOcxg==
X-CSE-MsgGUID: nlNiGyMyR8uaX0kgOObuUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="70457246"
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="70457246"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 17:53:23 -0700
X-CSE-ConnectionGUID: 22UGSLK8SNCmMw7N9zQEbw==
X-CSE-MsgGUID: Z4YVfrN4Rua5RukA4heZlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="173694037"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 17:53:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 17:53:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 17:53:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.85)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 17:53:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puUfxTScDGawM/EZVoEEj+IB8UeGiwkdRfTYJb0cHa8duE+x5NLgUWW9/T0tumznuGBV/8BE5PBBJCjMEpbqcZqmVK2MXs+W+gXnXoWgORgkj5ltBgDmG5WOaFe4/4/6dx5eK+WD+QJs48R+VG9ZbcaN8S/GPZxpSPBxvB7WtSyEH70tpqU/fLgz2CtuEQn5bxtTd41VI3iUmV6GD6ZviE75sD4gsz4JTiVbGiZGCZG2L4NJr7Zwm/uY0TLs7TfJWIr0gyUH0ySx9nydFSyLFqCH8a7OH5o942jXeFG/lRygi++dPZX8nnMgsRA4ljCGPNwqCBmnHG+FhAnlG33DwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8EAfqBn94Cw5TMPEgFJ0uYQOTxZR9sku2E6XQ8PJ7g=;
 b=c3ibWexJDybQVUL1ppF14Z9sha+q5qIQ8kVP7/VE5ndmLcvdF7xhivsjg9mAu+vXizPpoaTRE7hCZ7Sths+iLq+lRZUZtbSwmi3q8klCyBBU9Ukm1KYAaWFH3F4hf9nUe1UcM/gWobvvkaYNrmTOb0tFu4/FUuB7s0WGIorHsOVcxtmwb7CnFhp+5XbqqR6Al9yl0sGSihImHmjLL9kg7wZNl5LW5xUE8Dwbw4HS4FkvWa74s5iMRCdJasxM0SI9DCLghLwDk/W1QmYIlsGZy08EuLBk+JzKlcXXfvi+QLMCNuA6lbY8y9Z0ssYg46PwueJYv5iRJF8VK72EsIwWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH0PR11MB8214.namprd11.prod.outlook.com (2603:10b6:610:18e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 00:53:20 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695%6]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 00:53:20 +0000
Date: Tue, 9 Sep 2025 17:53:16 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>
Subject: Re: [PATCH v9 06/10] cxl: Defer dport allocation for switch ports
Message-ID: <aMDL_LDfIi7RNjDn@aschofie-mobl2.lan>
References: <20250829180928.842707-1-dave.jiang@intel.com>
 <20250829180928.842707-7-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250829180928.842707-7-dave.jiang@intel.com>
X-ClientProxiedBy: BYAPR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:74::29) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH0PR11MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a378fb-f3cb-47b3-e7a9-08ddf0046f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k2yl2kHFduNAIdml4NzF4u/hSyfVZpweoGCEDJRo68mO8c2VbdJab873CUtL?=
 =?us-ascii?Q?DynfA9k8H+8C4tJRhd5gh2sewOgfh3cJeIE8XRso4cYqaCJi+LueQ6aQPjTf?=
 =?us-ascii?Q?zhdhfwEKZDE0KxHDeX36pNm+O0pnW8W53KL11giaOCGA09FDKcBnFCDUHzZ8?=
 =?us-ascii?Q?cglilvlGQGfan8cakNnCLULLGcbtPJJpM1/AQKiSiftLM3xQ9aKhMxgAJmpl?=
 =?us-ascii?Q?BXUTF4yOztRTPlmwh8BW6LoxCcY45O0z9LAQYjWHa2Ln7aKMfiB0RPvD4a3k?=
 =?us-ascii?Q?LcRZgffTi1NqvH3EJCHH4JJka0b3WRAmYrcym0WVELgAVnL2x0b2/wU/3Jxt?=
 =?us-ascii?Q?Aa7znZsDBKsUVu4hQ4vQqE2RZoHwYbHMiiXwDoKbCa4L2Q0WoSkutzMJ8Fr4?=
 =?us-ascii?Q?0o4kURA8UAJJwMJg0f4O5XK1rNskNAGxCN32XPsAnuVw1WuWnh0KBGxCUuYC?=
 =?us-ascii?Q?yzqy5LTYPFn7GXtEV0PoKT+h4HgMlgK49+qKbk5SjeVmNBqdJ6uEMP+q7iR4?=
 =?us-ascii?Q?dH2VMQnxTOz1aZAoYIqKvPOMp6Av6DR78p6DrNkujLSUpjciLK5V0a8AOjUJ?=
 =?us-ascii?Q?201ymk73pmrZLKVfGnvr8m6i7m6nMLLBxZ5fKVkxeE0sz2Qg1nYiSdB0j/AN?=
 =?us-ascii?Q?B5stQVvLDyS3uS80TP/MBNIdeWWpWxviaX1j7bSqZ2o21PuGH03dfbiGZn/i?=
 =?us-ascii?Q?Vy8wryYjWQ7xRPte3BAsIAsXKdUZ+hu9/gC82K7iUeg/Ez9mqcBypE+LNyvG?=
 =?us-ascii?Q?hW/n9NurPt5A5VvneVhK91P0mLOuRivip0vJLEfdASxIMaTTYG3DmnadfFJV?=
 =?us-ascii?Q?dfZUl50FZvoEIvcZRmw29MRH8DloQ9jvgF67gcz4bYDU2lov96p4SX3jeCEI?=
 =?us-ascii?Q?zS85A1MN9zQrTRKVH8Fb7HWIM76NdLJUqUb+Ttl1MSvhIPR590zgfa2Vko2u?=
 =?us-ascii?Q?8+c38kg+vEpUELvukAHjXLryZ5XKL/oNHEGzHnzBD4ZMYo8TlOmd0Sg8Lw4w?=
 =?us-ascii?Q?tsCl0ZTZew6lai2TUP3jicMv2z1MNm6q6dpyeh/kc9XuZfB8izMSVDkQ7kuV?=
 =?us-ascii?Q?289RHkbfwZ7whepyuCEnThTpAxAErDY3zvhGE5XDyOih6gnt1PEfCFLj8Mcg?=
 =?us-ascii?Q?m2kM/K/qk8i+GtWSxHfHITR7HUa4RVJiMCvz/qxA/dKmswFo9HisRFDzzAbB?=
 =?us-ascii?Q?2UYPH+7bM6lZjhBojPx2ZIhZrRkjJNYlQw4RYKrlwNRCrr30mm0+NO50sGXa?=
 =?us-ascii?Q?VI1bhjwkP8vgb6ZGcW+3Avtm29jv5swvEa7537aInZrFhzlr0bS0aL1svTGI?=
 =?us-ascii?Q?4Hrd+Ad4Lca8e8sjUuF9/qpJvGOT1U8WBWt/Y0U1ympmuZtqF5xHmq0bGlf4?=
 =?us-ascii?Q?aCSXf+LDshsHEF1KiOuFWmw8YnY8XB/mhXLKmKyC5V0CpKiqUkfltb0KnPPA?=
 =?us-ascii?Q?3J3iJJx9WAs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MXiG6F6NQv4IY1VomVgFEBX7rVSp74zNX1HKcILdQzpXhbu5+EgobmTV2W8h?=
 =?us-ascii?Q?Nb9omfVH92LE5E3twrtBJppYmX07QyoHoR680fWat7VN/EwBpHp4sibMtXnX?=
 =?us-ascii?Q?uC29t+xl6uRMpdZKAxPZjkb1zDNsdpPBXCLjVDXUBXLrdARnl3DcIAcKoBJL?=
 =?us-ascii?Q?2b2nC0xQb88AO4utd7d03xGTgXEpuDTpSE4NgqdJTHlpx/KGqUnL/Vwo8Z5Q?=
 =?us-ascii?Q?ILZeJGdHmNR+wGUM2lFRgUrmcBS5N9YdDAdQHatE0qmakWtJwaR6HQVA27vY?=
 =?us-ascii?Q?B/sG6UpdniB/ylo0IC+2H6jCmUMz8YqglPcaU3oPH45r0vXSaUVjiTmshdtS?=
 =?us-ascii?Q?Q08zZY1B6EgsxHmyTMUUXcXUwAD15W7DhS5AOJwIHhkrthXy8cbWgaKP/tmI?=
 =?us-ascii?Q?Qs3FcDKuFpGT582kMaa5ZSyXX0FASaGEpgeeFJNpO6idBn6empv9x4pkzjMr?=
 =?us-ascii?Q?F1hijfIWCreQe6tD6OQ2CDAmYuk+iZ3F4Yqm/gMnKdIDRJo2kVZGdKwwIlu6?=
 =?us-ascii?Q?GSMiBs2KxMRSDmrOPMI+uVpJYpvK/nTkkMD2eIdJ0Wrl2vWlAEhUMsMkyi5c?=
 =?us-ascii?Q?AnqVvRc4FF2WuMiNP+4qS+l1ZQ3P5ugxP94FeIG2Lwwbi1EL/83aiVUVBT5w?=
 =?us-ascii?Q?idzZncxmOwXDp5fURELyY9KbsmQajy4P4KQshtmXQg0VjmDP8uWWVtwQcf0f?=
 =?us-ascii?Q?i0XD0gqR7WOo5CXKMr9PNqhvQpu+AYkZy+KkM9c3hBrBcxzbzN796ENBBmg1?=
 =?us-ascii?Q?oZpwUataKSmz54z7UFsAebOS3iZPtVNs1bU60Lleq7YIs8uuJWwumM1gT8Am?=
 =?us-ascii?Q?7+lJnP8E8rJXuXBV3E+lXMwRtO+DdcYBtsoU4BX/o7XQGtdnsdO/yBCZB3yZ?=
 =?us-ascii?Q?8IyuhK2PN3u9SyO6a81PgepnL5eMHKT2LUthRcy9VZrvlCpicFbSD7y8SLf9?=
 =?us-ascii?Q?8a+kXLTNhcyUxuQGPUxFnojn3q6/enTmqjplLe/nyoqZFchalf6MYvLcA7T+?=
 =?us-ascii?Q?e54WmpQjEtfATjNU+zgOEWc7qGxYpFydm5kpmuiW8ChMetNvNXx/G0cxV1nJ?=
 =?us-ascii?Q?tcTHRITzh0rgjQHrVbe36xUB7LC/fhdkJXw3j4r7xsSaPonbd4fc5195V/yr?=
 =?us-ascii?Q?4B+iH3I7UFn8tLSPjy7yZSjUkdnTQQt1kjafYuZEps2IO/4Eakyb+o/Pn5Br?=
 =?us-ascii?Q?AM9fQZXfJpJdo5SUwk0TLAOlClhknLuprpsvpgEKe7pdkVUkunJENKsBmllV?=
 =?us-ascii?Q?aXTKpusaJVb3ASarqIYXaSV8dTkqWy808ZuQ+4gQJUWInnLeNtpLSbTQkBoE?=
 =?us-ascii?Q?/DteM2EjVIJWYVVqn7xXAaQDjmEyLNdsSCHVntlcLIzzjRcAyCBB6uYr7k+P?=
 =?us-ascii?Q?2iFQPJhRP6L6n7gk1KpoCzPi/XEFxQJKaGatAlZZANGeez98jfCTyqqJyCy8?=
 =?us-ascii?Q?vjLtcgBx2s5+4xBQBgYf7ZAAXwHZBd8n5zJALpKBd7dcOy5K5ImrDz5aAOaZ?=
 =?us-ascii?Q?gZe5cK/fXP2oXYnjDbHcvwib1JA9vpfoviG/G7LuXXKSo9DY7PD0N2440S01?=
 =?us-ascii?Q?tSFn/CpR97HStMveIzNbbJADklRqUt08hvf3iW+4MGXIKgzfhMzhxotje+/7?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a378fb-f3cb-47b3-e7a9-08ddf0046f81
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 00:53:20.1217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjJwBQCLbXVjWcnQ/I2lxBvD1Z9GJ0tX3OzaHGansSRbhTBij2VG2moozd8Yr15ugy/DeNRPE4lRkRi2ionsOnZqidd+C4VXvoII2mwN5z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8214
X-OriginatorOrg: intel.com

On Fri, Aug 29, 2025 at 11:09:24AM -0700, Dave Jiang wrote:
> The current implementation enumerates the dports during the cxl_port
> driver probe. Without an endpoint connected, the dport may not be
> active during port probe. This scheme may prevent a valid hardware
> dport id to be retrieved and MMIO registers to be read when an endpoint
> is hot-plugged. Move the dport allocation and setup to behind memdev
> probe so the endpoint is guaranteed to be connected.
> 
> In the original enumeration behavior, there are 3 phases (or 2 if no CXL
> switches) for port creation. cxl_acpi() creates a Root Port (RP) from the
> ACPI0017.N device. Through that it enumerates downstream ports composed
> of ACPI0016.N devices through add_host_bridge_dport(). Once done, it
> uses add_host_bridge_uport() to create the ports that enumerate the PCI
> RPs as the dports of these ports. Every time a port is created, the port
> driver is attached, cxl_switch_porbe_probe() is called and
> devm_cxl_port_enumerate_dports() is invoked to enumerate and probe
> the dports.
> 
> The second phase is if there are any CXL switches. When the pci endpoint
> device driver (cxl_pci) calls probe, it will add a mem device and triggers
> the cxl_mem_probe(). cxl_mem_probe() calls devm_cxl_enumerate_ports()
> and attempts to discovery and create all the ports represent CXL switches.
> During this phase, a port is created per switch and the attached dports
> are also enumerated and probed.
> 
> The last phase is creating endpoint port which happens for all endpoint
> devices.
> 
> The new sequence is instead of creating all possible dports at initial
> port creation, defer port instantiation until a memdev beneath that
> dport arrives. Introduce devm_cxl_create_or_extend_port() to centralize
> the creation and extension of ports with new dports as memory devices
> arrive. As part of this rework, switch decoder target list is amended
> at runtime as dports show up.
> 
> While the decoders are allocated during the port driver probe,
> The decoders must also be updated since previously it's all done when all
> the dports are setup and now every time a dport is setup per endpoint, the
> switch target listing need to be updated with new dport. A
> guard(rwsem_write) is used to update decoder targets. This is similar to
> when decoder_populate_target() is called and the decoder programming
> must be protected.
> 
> Also the port registers are probed the first time when the first dport
> shows up. This ensures that the CXL link is established when the port
> registers are probed.
> 
> Link: https://lore.kernel.org/linux-cxl/20250305100123.3077031-1-rrichter@amd.com/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

