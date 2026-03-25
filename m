Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D81915ECCC;
	Wed, 25 Mar 2026 01:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774402324; cv=fail; b=N4HO0HveGiIerYpuvdnUyUK4XyQIeMMBcP9D8efUcqRkM3dtHv9G1fFlRZYy6NQkr9rKz1S+jj+uXb9H89xVLvQLCAOhdot9Tt4zX7zRyEBvlDNdei6atu7c9mXzVpnpWl71QOqOqX+tBqOD+3WW/doi+8Vw6oS4dkx9Ireqqgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774402324; c=relaxed/simple;
	bh=kP1AKK2IXFOorpixYJvpF4LggmlAAT4KTVf7LKRe9ws=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FiumjJLwLxmC3P1v4CM+HyGDpO/mvluPQAo2fmVu0jBG3bM6HDsEIBeqOnfuZMk+Z4021lWBGGODR3zujCCuxVYQyQ5ic0SFF4dICXBvuCmWIX+rPs/mem9YqiLHduz2VWtaDGTJXTLoZMkmpebm7yVnKkJB3Ic6+e0Q19durW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aa4oSWUT; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aa4oSWUT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774402323; x=1805938323;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kP1AKK2IXFOorpixYJvpF4LggmlAAT4KTVf7LKRe9ws=;
  b=Aa4oSWUToSavlD8Ipe0frxe8VXWb6Xq8SQXTK8PNabxDyVcLSVZ02yJw
   NZEo2yTNoSZlnIvwJq8caqCtV8042HVorZxoH3ZgED4TbUOJOHFjR7OLx
   KPgjxodYSZt+ii9gjwUMKgnSylUk2nOjw10yEVEZnGGYMMePGAwNZLH9G
   4ddjMBibQQHiIwPA2AWJ66hc1QtB6/aSjp0JdSLyjUGqvfDdDfbgdafXo
   DlvRrL62FFP5D/8GOQW3Z9MRSDnf/CumAujrvcNJUCWVnhzk7KGkOnr6+
   bJTFH/79wVognNLi+cQN5HVl0aBPk+7A6xplCv0Ak65C0SeUgCjPFMPOB
   Q==;
X-CSE-ConnectionGUID: xdwFv7sJRSG/9sE1ncWOFA==
X-CSE-MsgGUID: tR4FPQy8TFeW1H59p+uHfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="74613652"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="74613652"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 18:32:02 -0700
X-CSE-ConnectionGUID: CZAQjWWjTOa9NiZi6JTITA==
X-CSE-MsgGUID: E3pBgVOZRPWYjSrpmK0txA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="224786924"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 18:32:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 18:32:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 18:32:01 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 18:32:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkU6IvUnR1KiZUzWw4f3dJ/EWUDHr/RXuTdga0VEhMRo6OdOxNHWBqDnUO9dZaXb/v1hyq2dzlNBCgIpXotAK8Ro27FxkAGqYpSloGHvhGd20w1AAntwDIOq9Szhxds1LwEnNR/UPb7qzJqDYHlys6Y+zn2WUFt0nJ6KQ8NORbNmUNfPOzN6K/ig6JCAdyYecmUgtbDN9JiAooeyfu0wqQa+T6bzS5FSBGKOMmLnxtCYWieXrzBeP3ijPRE3TWo+gg8zDl1LkSkZ6ZBp4fKNKgEGtDtM39TZUY5kk4wgUCwykBK1BeeswikFQFoW2NdFGCW8a5nOZCUQSuacWacxKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g693VeebJmYP7ZOd8wNn6j9ZPMWczrjw8jflFOe/zh8=;
 b=GXlXGpWbohNfMTUpN0ymRyuUA7vpZLcNt6kGnfy18QJVdaabS91U/DHMIqIMg9xdAQI6xgFIatYkva5xXdq1jyLPcUAplp6SZrd4C0o0+lQpIyVPuLsLpHpQsBzbWeKhuZSJMqkSTu7eR9vWDAAeRvhIcxAjM6RL2FnBGH7/FTg0henh5xIu8Yqk/9Z6bhE/ATDIFvE9Y7TjEhmYg1tJs+h4eLfzt/eO+b7jMbMAnMcTtjsLZNK+oy3/G5q49UvdvNL27wZdU2xuDvOVpKgYjvGjBJXIgD0zGS8EpanB4pyBBQLzBpfUV7bwcDMsgqKX2lHUWcHwiniwW6UvpCjoLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA7PR11MB9541.namprd11.prod.outlook.com (2603:10b6:806:4cf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 01:31:59 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026%7]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 01:31:59 +0000
Date: Tue, 24 Mar 2026 18:31:55 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>
Subject: Re: [PATCH v4 2/3] cxl/core/region: move dax region device logic
 into region_dax.c
Message-ID: <acM7C0aZOPmwXYLx@aschofie-mobl2.lan>
References: <20260322131638.3636725-1-gourry@gourry.net>
 <20260322131638.3636725-3-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260322131638.3636725-3-gourry@gourry.net>
X-ClientProxiedBy: SJ0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::31) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA7PR11MB9541:EE_
X-MS-Office365-Filtering-Correlation-Id: ed47f4ae-4b79-43ec-acaa-08de8a0e4f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|7053199007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yhA43nRRGAsQZYn21UZY6xBbPYgWa/EtqwOtSLcsZpa0h68a4zA6feuE4GcuuvLMLH3DdUx+C0WVEkSDD8ZEH8HxcPjd7T1dm5fpsPFkhZT6KPfEDhcFyTIhUhoST5m+4vtePJVlXz8BJ31L9oMQdSQ7INRd3KqjH8uQ3//ViDFY1oO8CNi91haF6J858OA/oQMQUeSrdKJrJHSAe9pb7b0q1O0J0jvi+Hs35X75m/IpeO8roymdRKyYqvsLQZQufcp59u5VHklrkkGJvzbkaReH+ojFBJWP6PM5B1sgkwcfrXaCLDBfbv1EqKreb84Btt6fY6glrdUUdvotoq6TOYzw8IqzyVUTulSjlBVCV6YiAvagz6jqPSiMhqmHlOEsdZDl9KF3a07R5E8vjMsv0oHE6x+Ij1w/Xksem4fyQQkAETHsw9pzzROmLhQlQ+brfJI1VIWFC44NtcQjex1OlJvomIk+Lvns+9JccApOqNdmnghmMDxyhv5BDtIhXLt6bc0+zV5Dn/GbHq6jSj5oWhgg2sVTcER+Dvor/HjI7rBLPsKscskx0/4SEof5xYdJHhL5KNIYqxkiGUD+xYkDXbPHTlDg5RLym51RfXPHNzJoLXNA62yWF4UFwtlgl1mGxtPpdqWWS1kQl95cH8iLIWljgib3MOrJFCbDlH4COefWscu9XuyHmfDw08D74pwoaRC/M6y2JaTnS+gaK3atKYCobbVTpiPIPMleZEJp1p0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(7053199007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lNhgq19yRgnHUFb2g3lZohtDUE08ICXeEcDUmtUhcu5wTSZiqSuxdbzCcyrP?=
 =?us-ascii?Q?9mMFBh2Z3jdAYXZfj8F8HlJC/wm2Wl9PS7Aw54//T5R7GTbqBj0ydvdWXFXw?=
 =?us-ascii?Q?z/DpXRaxNwnKvOFwh9TcoUkIi3Sm9OjoD4C71DP936vgGfJnwWxYFv/J5018?=
 =?us-ascii?Q?V10Gxs/1865guedkQVFBUNe8xWrc6zswPAkRZxDuopKqYU0r8PzeRHhYjfr0?=
 =?us-ascii?Q?Zzw3GZool8fuapvL/QDebANos0yCWA2DqjRf3KPcJJGcPbgctawQTTydI2x1?=
 =?us-ascii?Q?3FyTDnDFziYchMp35q998ICreS+QhKE7b+kCZKNc/hqCQ5siVxhdRqFu7LFr?=
 =?us-ascii?Q?APamYAybdLsQhaTG46pqaptiAWf4KNVys7ytK3tv8xsaWKaOHRdAkSKKl7nN?=
 =?us-ascii?Q?iA3GW04bxu/S8LXTsPPNHnZiW4z4a04o0nF9Zu4CV5SvqsIJOAGuIljRMKoc?=
 =?us-ascii?Q?KUl1/VXiFSqeHlWHeBOy96vBZhQYixZI5XyC69jFq67FM+HQj1wFxAfI3xq1?=
 =?us-ascii?Q?msUQZ3hZBBypv5qdZserCd7cK7cJKyqZS6RZIV3qW0YOMcZdLqF1nj8/l8TZ?=
 =?us-ascii?Q?s0WWpW3cSEDiurJMEMISlmsT7hzzdekbkULigNmb/Do91pkVbObzxTtdLaiZ?=
 =?us-ascii?Q?CmbdqLjEylY06QUq2jfrVazHsjvlNHqX63YHTw+KNFpKUIB+sVgTZYR8mLWS?=
 =?us-ascii?Q?r60cL3g7yhW2T9w5xnHcNiUHmzQspgE33mMdL24QVj8DmT53rnS1QbdPwEXp?=
 =?us-ascii?Q?OsVL25wldVIS1VwTFjolIDsjGQj3SHehfGc+0gQf1AarLmGUmUuZtGVPc37w?=
 =?us-ascii?Q?Yk8efpZuogI3izMG2AgxcjvgsrYVsMfMLWTvC2GfBHcXi5u+feGmi0OeCYA3?=
 =?us-ascii?Q?oqeORWpOVzLSGjLR3h4+D2hZQ7vfGX4oUBLWYJKIP++h5rKT4OgkgnprUhDx?=
 =?us-ascii?Q?P5IZ4YAdTmluVy8gYCcbyeU1RcKPJrWo+dy4PSz+eikWXprL9FFIScMWrHdg?=
 =?us-ascii?Q?ZA3NiFcMn4BmXtGxqff4YnNb8HhUtpnIdxkzS15ghr7otsMdvl/rTAj3KngH?=
 =?us-ascii?Q?RlIKOZCXEOyRQzCCVf9dG1RuWAT5bSKRUHYRgU0k3Kiv4Ei1TU3IUh4Fbjrp?=
 =?us-ascii?Q?zpO3lUJCcZ9tc32jdJH1aK6gjhy+8LdApm2QIzjK6iieOBLT7Yepmnx/sfzk?=
 =?us-ascii?Q?RL1JbgCjwMw3M0xgBWtcBJ8RFm9EMU1b2nG6NqaxxTYyebCXlqHxXh8/HyiI?=
 =?us-ascii?Q?0MK3rwTPXfywpjKYIie9YXwnnj0uLSbl5OSAw7N+VSD3I+xam7jyFNDgbhWO?=
 =?us-ascii?Q?yddx4xIOldjlVg/FWV2ZBcRbG92s/vzq15XvoP+Cbs41iveUPo380YdLhBhm?=
 =?us-ascii?Q?1nT/BWB+OoWj3pBqMJliHwVxUu3v4J1N+ubiPKQTdFNMDdfCGZ6c3rviu97M?=
 =?us-ascii?Q?45IJM7uZYczEPrYyOXkRLV98dmERuiAbHZtkN11JwGvDOqZRXPQsS1XLzROu?=
 =?us-ascii?Q?No+0NcdUVF1obFlBViwf5Jl1O38tTORa8JfCvaT6UY1Nml06YVWAJULMx2Oi?=
 =?us-ascii?Q?qNvjhCLa1hojK6dcy/tT46j8LbXkcKCN3CBBWXnquANXgtmLLFMPRYMzm35t?=
 =?us-ascii?Q?H3XXskjksbFZazArRjQZf5yrJmbu1rwbXZRMsBeXwT/ixPztOLM3+Ha2dKP8?=
 =?us-ascii?Q?5CeCCjIXQZz7ibYwqah1nF//dPOnGVrGRy6uR9XvZVVHvZ+1kLkVayHpj3gf?=
 =?us-ascii?Q?CqfiwIelHNrXnkv06fnO5/ZctxwFXoQ=3D?=
X-Exchange-RoutingPolicyChecked: K9EJoyxBCopZohiMrVZeqORdQUVtUteWqqrZtfvsCGCSkQnBc9Dh6CjRYetGHcrbQlbqeE8/3NYq09rGjDR/4gyDN9TQyInwH4kH+/+C5hFsRJ15q2eTY1UVOqct9RYsmDrddtOYg12NGcmxmJNgeERySOYfLdhf0/Y8OOgCLE0LnaIlroUq744zCmsGRfSPRvl3ZfCcuy8snChS/swtKmbbZ3ea54qelInRazLhTQtJJrrT3Tgnc+qdGeQ700MKO2ksvYXs5fuMBNs1sqmwi1A8s1AJm93TKjzvp56orrkPNW94KiOFhXX0GbKoE5OBkXKGde/bicGhNkAHzqxR1g==
X-MS-Exchange-CrossTenant-Network-Message-Id: ed47f4ae-4b79-43ec-acaa-08de8a0e4f1e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 01:31:59.5754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0eOTb/MhOgVY0mR21xsNwaxNqLeQD/Swv3tJma4CruFiP3PgVHI3OVTlmo+4ifD/laR27X41ugf7F1LJghQ8NfueRThgMp7n1qtfMTKcIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9541
X-OriginatorOrg: intel.com

On Sun, Mar 22, 2026 at 09:16:37AM -0400, Gregory Price wrote:
> core/region.c is overloaded with per-region control logic (pmem, dax,
> sysram, etc). Move the CXL DAX region device infrastructure from
> region.c into a new region_dax.c file.
> 
> This will also allow us to add additional dax-driver integration paths
> that don't further dirty the core region.c logic.
> 
> No functional changes.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

