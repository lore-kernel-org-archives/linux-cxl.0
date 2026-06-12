Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D092334A3A5;
	Fri, 12 Jun 2026 01:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781227192; cv=fail; b=HDWcdgbSetCspygHDIHgSb6ELppVqKOnEGlGC4uW2UVMaO8sRCCQqSWdSDYQHgCEwT6VERp+DNXNR9h82jsNlRKRCtWrOxLeJ7/wGwnIwSVquwlsuXXsDk1fH/anJ1ToGkeT/eQLtCP1evwlEBO4TCznalSxqBfBjOjCrQuV8Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781227192; c=relaxed/simple;
	bh=6J+gweJ1ERuM6Ot+g6Y9My7PYAcxwSDSP+oROJqQOEU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C2XjPo8qs4XCQK+zXL5YEebGcWnDk/55h1bP6J4lz9TJo6qMcLj4II5k2IHkb9gSofomUJ1eDlO/5wfUEr+pEIbM657qMiXcu770MrH27dZLTCd3r0OKr4N6kFVhd64x5ZpBKtq92/0UrfuPokLnv7f35q6FPUJSQXwtNnh2xi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jewsZxMB; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jewsZxMB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781227189; x=1812763189;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6J+gweJ1ERuM6Ot+g6Y9My7PYAcxwSDSP+oROJqQOEU=;
  b=jewsZxMBk5JtyaFSxth03Y53LkpEa0fkDv3lSIbylz+7m8HdyV58d7K2
   XrIign5v3Uqd6MrmSV7UWTYHOn5xh/ob7iz/cVFHn6qOaEuEbgSRbEc+4
   nO8tOGwnpPVKFzODsTcggeXsVIWh89hkkUjW+z9SxX8+caJEsKUaeRAML
   yqhIWidkHB8ynmlJPS6EGSBQOE/tFqmegZT0j7H4PII6G1rr2L1JUh9ut
   VVB4t5+84wj9CdBjc+YwK6+LdAHklVCU6zzcONl5jgGroN04YQykMtF1b
   6NsXTz+l1/jF2a6zKbOIOhtU7qgJ4g+zwNCDShFZ12JMUg5YO5yAvTrEg
   w==;
X-CSE-ConnectionGUID: eriqkMdMQ5qsd++A1KuQzw==
X-CSE-MsgGUID: 8au93a2OSu2PuHJfjUuSdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99475979"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="99475979"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 18:19:48 -0700
X-CSE-ConnectionGUID: KsdSu4rxRhiylN5Qg5Lb6w==
X-CSE-MsgGUID: mSm6QsHpSvOVI9Wtc4+49w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="242544742"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 18:19:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 18:19:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 18:19:47 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 18:19:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJrvQN7ifP43XUmHHeFA6TQG4gcaCEDipo6f3i5FCrVH8LlnYg5lcniYC3SWMUeEb9emqglg0QyhEbS8NZiWlcQ0pplMsfeOnTP07BSQqtfaaoFZtbv+x7S8VRVmslRxm2oz3x62fnNdyvC/VQZrvrbgQXoYlWCfiKUsxosXrtomPEiNq9nuirWYLO6gc7aNJfC2XNBIywtfNr8A9CCEPHrEl6Xo9HURw+s400geQFrZjA5bc0rfFaxSmCMWeGuT5BuNb6MUZueKQxiq7mb1mCEB+4bInmtJ+kwTgIPxjVWzb5D2oZMfdgAl+P0l0+DennULIOhT+IM5SZoKlgNADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGSycJZJ2COzgwBhHlWoBlpr0XKSRIOhlYp3niCuRMw=;
 b=fB5aoMSOtkUjrsvbzD+zx6Hy+ILbc/Cj0HEVe9VijbU4TOZe0drw8A3iXju6pRTfm4AbUmsun7NiPubYg3DgphCFW9N0YuRHZm6/2flBQWH4Ibt3n+Wk8LelbnppSYtAib6JWNqlvy0zHryvcXKN+Jn2IJdfM7dFsi9DOU9udtm5+0XsaHc5ffFK7ynT/XG8I9QJJutViuF5Kq7g6HkmptiBlZ0b8ax8Lwcyhfe1prdkT23c49wc7CkoftOHgkyjVz4d+eG9F/xZ4gSjgqgOchvi9TKy2LqsYoShYRvjkaD0uU47DZrOQZjWnUa6BRAUnztdXFSfOihFMWO0Otgiug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW3PR11MB4586.namprd11.prod.outlook.com (2603:10b6:303:5e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 01:19:44 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.016; Fri, 12 Jun 2026
 01:19:44 +0000
Date: Thu, 11 Jun 2026 18:19:40 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <djbw@kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/region: Fix out-of-bounds access in
 cxl_cancel_auto_attach()
Message-ID: <aiterPodI9WKUW61@aschofie-mobl2.lan>
References: <20260606-fix_two_issues_introduced_by_cxl_cancel_auto_attach-v1-0-5d94ca06c4e4@zohomail.com>
 <20260606-fix_two_issues_introduced_by_cxl_cancel_auto_attach-v1-1-5d94ca06c4e4@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260606-fix_two_issues_introduced_by_cxl_cancel_auto_attach-v1-1-5d94ca06c4e4@zohomail.com>
X-ClientProxiedBy: BY3PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::29) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW3PR11MB4586:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c340e1-492f-476c-f70b-08dec820afb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: IOs+g8oTpn7r/rrXTi66XUg9KOVMHQmF4qzvCIgY8zx/21RQj3/emnD+KyXLZNInIYLAWtTX9gKiYdJJkp6OdMJJn77xCNzlu7Ug3uK5+On8jESGSTIovZR0qFTwVUmid7cOWwqYFyd+wPpkrU2xf47u2YdGWltGIRjRkBzY99RUkmquDMM3+DQtubZbxRpH/oUYDSK0lInoiEIqpxduWrfIHmIY+d3UgerDDxCf9OgFDisjoaHwQi34lfN/I1S0I8v9dCMJEhTf1HfSE4bU8SvaNIZD8z7OhOcMM9K2inRqRzKltHXLIgzHV9+WuUA8jtP9bZF0QvrvfNuvBYKzjlQTUGcg/MWSnQG68LdiyRSGGdAauxMHcswaQI+cMjeLghYeZVvjuMnbwzNJot1aJB7JI9fd5ijnCa+TwDawOzmzkAkQIazhkOW7q3cOjfOF4O/LF4VPM9k2kEOM+hZ6Aq2ClqMtiP8BeiY4NrZABL6RqOwzoF08KIBr0lvkey9/WfK+RX4gaseAQ6hcfWSFPTouGzte7+mpGdGfqQk5KdmFLMEq42SPBC8/VOfTi4Oj72ZikiEk0pkK0EyqIcrX5z8g0tIWQMt2R1cSCRKr7jKS1Qgulgi+2jBxQ1qALVjMXXN7gvHTBmWIM9j3rSWCnf05nxn43rv8790D7+mcgyDrjUPBHOlTMUsETnhDxPrO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J7i4YsCiLDMQmJ94Lf3+B8mXdhjmO6eopcuiqCikBYXQLvxQYPOdmvvmX7e0?=
 =?us-ascii?Q?o5B0tu5K5+3MUWY/Jk3V2TmOJjyA7hW5Jonxmvu1Qu5gYz6o8U6u5kyPwrjx?=
 =?us-ascii?Q?9+ibhu4YeEZGcl8RgsG3LtWI/ylbA0+kSG4iv9LXd6OqtZHwnhvM4o38yCbu?=
 =?us-ascii?Q?ayC6PQ144TJnziw6xAUnTRmz9Dvt679KAwrrza/2W9Qn4AVE0BmvjASCWVgV?=
 =?us-ascii?Q?GnQ/kf/Vtclp4vTbl/57AVJOLDGdCuHx90z7Rz37ckY4QTqWH/gRYp7vEmAy?=
 =?us-ascii?Q?BhnNaa4G3tcOjd8MSgGktjjZVd7Y45aUqM8fEHaVM+L++t8WDP3PMK8VMCj7?=
 =?us-ascii?Q?JD1rbc5NJpfQiYLo8ixiGMVgFhBngQuAA9RO+B5d9qJkc6H8yDSAuFOa25HH?=
 =?us-ascii?Q?cujTYTfe5uEtRq88DH6zTSl0CO70+qz7B0vDLAOlbQI6MsYOZip79mJbivWB?=
 =?us-ascii?Q?T9nKb9hKP/2Ji52rWU5WK+ozLs1ij3c7GQFstkSau2MkI7BKZVv3imDztdgT?=
 =?us-ascii?Q?0kdZfjfIWlfs4SqAStamHMUkwk9Eoro94BJeFw7JQ3J+qTGQd+Qe1IPHcyCh?=
 =?us-ascii?Q?TdxDB/zqYWDsuQ5Av6FJRGzxMiefSbW2tX1jq9LXen7+k8LL1yDv3sZkT2+f?=
 =?us-ascii?Q?yDxV+XzNHpqWfaoNpzB/CwPMq2PkQVIMud0l0Ad4wNCFJTMvQrZMmfayjuQo?=
 =?us-ascii?Q?pwky/k90tjRZKeDgmCJXYd8rEF+NWLdSCze+Zl65FOm1oZ+qCBcTkShHLiry?=
 =?us-ascii?Q?uU8YNSLZ/aGed9HXvxIWna4jAdMLh3HFfcc3HmYHskhR+0ILqdBhptqGQrdk?=
 =?us-ascii?Q?rG7MvMLMKVz0wcC/GNeeORIomDUImv9eZsQfwq8Qb+/iAnfVoa7gidCsiFhv?=
 =?us-ascii?Q?kStjli28xQUuxAe1Kc9uzFWeIk0IDW649uZAm/2szfw/KL56UIbxBxbN/sL6?=
 =?us-ascii?Q?rsq0nknpRb+aqyQr/1BB1qpvx9AYl0uU8aTIjq1Ukdl1Py8d7mbd6XakWA0k?=
 =?us-ascii?Q?vOUryY6Zc/AbgGUXGIeT2c4drrvReejUbWm+M6DIXtsR1+n2KjJF4LkQKYVe?=
 =?us-ascii?Q?QtfIvVEOk5EnbN/Wm944Y2SLZvuW9sWViBuM0mZ0lO/DCDb/qcBduDcOuzMh?=
 =?us-ascii?Q?jvdSyXvZdRfQBCXruxbO0Lb1Gj2+yU7PQIL0YVCS9lyw4gfpeD/7OqYS8dNA?=
 =?us-ascii?Q?9MglcB5bRLgMQ+pdQuDj+MgxNAqyuibujIMew0ijFW1CZYudbnL+ZmWV6lTw?=
 =?us-ascii?Q?o2oTnVP0tzIDsfDK7b7Jk+qEqG8RtPF3U24LQBjSY3OM2gMq8gGvvbjIDu0S?=
 =?us-ascii?Q?zl0TUpjcZ11fdRcYWdptC2yA3W/hmboEW7IXPKZiydV/tYuF0rj7XEFoe/8R?=
 =?us-ascii?Q?tDhmyBLYRSS24P7WNwGxJIEOwnc5wolnNILCag7TaMCdiVXgNnEu5L+37ymC?=
 =?us-ascii?Q?N4G/SlpAVmd1eZv3PLcAaUBewuq8orYL3/xl7r5dGe8QZGX4z0PhWWxJ9uUX?=
 =?us-ascii?Q?q59dcXzw6H/zlqK1dkcyY8AIqzaNZ0SQes/8/wFXQRD5unmLImyKxw9xctxl?=
 =?us-ascii?Q?cxqhtQ6qsmxmyVr/PQcZxyelnbfiHy772Ohk5SETdBY+yjahxUXEO87o9E90?=
 =?us-ascii?Q?LZNtZcmuHWiZ0XY5WRs5jFOx/4HbA8/mJBEAuZa0nfJlWxNU8s9qjNsT7YfC?=
 =?us-ascii?Q?VUH5/t4+uJl5bQP1meDR0CC6E3dG5Ak0aTk//bGtrZlWrRYOF9ZDcs2t3IH2?=
 =?us-ascii?Q?1g6HHgGR75iKH5XwWi2tV2xMlCw5VM0=3D?=
X-Exchange-RoutingPolicyChecked: kCXkNGlcFoTdR6RL/cDWSpse7VBriGdvb799wJgIH/mOxbzuxyFzFB55hiokY9NojruOJTFkix0MX7PkiM6lfgzWARuC1apK7ias/HtdS2Ecrs1w2oPK2WYHIt4iUgQWLi41iJUQlMtTdRwpkLqfG9UuIgOzNcW7eEGZl43IT/9tmP6J8r/mQFHog0jA73decun4peDcjKlv5TiYaLN6Ke+IWsKOdO1g6u5nwunpH1XjVbpsFeC+qy71Uerk3/rZ6ryqNTO8wAVVLMCZN0loEWfKriTWkjon4bO0lP1LlLYOaY1ymDmJpEjYRY3YYWxTmc4Vggn/+jXyvjzhZCP2ig==
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c340e1-492f-476c-f70b-08dec820afb1
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 01:19:44.7725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04Ux3UMn+JtxcRqqRstOiJSyudmt1gQiB+f+JSMRqoBp863hcDEu0jSoFwKCwtJ61Ow8rujhB93Lb0josWi02/zOAVy9V+rcnQQKQRIpKTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4586
X-OriginatorOrg: intel.com

On Sat, Jun 06, 2026 at 03:51:00PM +0800, Li Ming wrote:
> In cxl_cancel_auto_attach(), it assumes cxled->pos is a valid index for
> accessing p->targets[]. However, cxled->pos can be set to negative errno
> in cxl_region_sort_targets() if cxl_calc_interleave_pos() fails. This
> causes the driver to use a negative index to access p->targets[],
> resulting in out-of-bounds access.
> 
> Fix it by walking p->targets[] instead of using cxled->pos directly.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
