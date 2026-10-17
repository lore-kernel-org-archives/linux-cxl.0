Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76E3218592;
	Sat, 17 Oct 2026 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792197027; cv=fail; b=rdIMEy3/bQMCf0b37vX9O20XU6Ng72Z1o+h2rP5H49QKbrkHxiz5ROuEO9KjkMhYfzZ7KLs6lt7UJM6SsSt1mBuRH2YlPwVEWztcKE94G99V/qTnpM4Zjrjvd+deiKoW1rnHlBSatLG823gUxsWFuTxyjJKYT6HiSStGuOjNjUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792197027; c=relaxed/simple;
	bh=Fmp0H48nE5UnuE/7g9J0g/3TX9X834XANJTWLaRhdA4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EC8SUuPgDd6//6w1MZf7ARR4XyWVuTQeWDzpgZOYHU1E5rEOjA4IsONZHu1aKKWzDJ0pz1Xt7nSkV8shGVVrV3uGNWoN91p2VIC81h0Eg9LjFE3vkEAdic1E6mkYxQYjSGlYvPqhEdx0qQO9uFS0evNzmYKY6c9gHiMQQ4il4eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y3MaBTjr; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y3MaBTjr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792197025; x=1823733025;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Fmp0H48nE5UnuE/7g9J0g/3TX9X834XANJTWLaRhdA4=;
  b=Y3MaBTjrYfKtAfoiR6byUAQw00V6wHGb5+RkAlg7x5NwKBrVJU57GlT8
   wxNGfzZh7786fxXTQX6B5nir76Q5F7QeW8upXHnn9xvtxMygW3xQRab6z
   yElWDkKfdSx9KtkTqbhJ8vX7EXbz6oqDjt+WY4isJyLrqh97S5ZKz0ATT
   FRNEZsyLCpnsYfx3QEKjaRltEjv54juODW7uYhYKEBzw9x53BNiJN94Z+
   lCUj8LGf4cavun4+WTj0ontLWGwLscNdz3PhtggLhbhsOSSvZlud91e/p
   Qrp1ZW2HP+OB1ydiDg71V57rogAy0uG9FQUcZ2d/L7Epp7GJ+pBdS1tiO
   Q==;
X-CSE-ConnectionGUID: s1mDqdwFTVqzTi79ixSISA==
X-CSE-MsgGUID: p1FAs1QPRKWxwpzdSbS3vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="995998"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="995998"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 17:30:24 -0700
X-CSE-ConnectionGUID: tTFplR9BS+KuJzkqhLYi4A==
X-CSE-MsgGUID: mWvfy6oqTB6Swk+6j63lHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="1949725"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 17:30:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 17:30:23 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 17:30:23 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.37) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 17:30:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4Itfaj7oMfuPaM6kMtYd01fu1vW9/FYhTIXbuMX8UG28SEJ8Fn8sXAU2hxgzdW0tZG79bqGF1us4FiUpZm/XEimvM6x9G6E1GlJc+6VKliau7MSedC8U7CllkUkgMGF771SXcvyv9q3NHmxOuSsJbX9sp10wEQiT9+2D1pwCGvsSP7Qkh1iG11jNj3xWSHV3dCIxsVKXv04ez4LvU6gq8mRWmZwJRB6Gr0M50ZbTv5RyZhoK4QpdI6xFfq0UHXAN3vrw13VosT1Vn4jiCIPjF6JSSSY7g9gZSLdRVWCPoBls8Aotcf3acXhxrvW3eiZL45zwkm2BsVfk8xuRv3LAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMb5BW4nxa4qii6bg1vH3EWdXwXA+rYKbURPvKTMwL4=;
 b=G+XfQtdZv//gpGPy2KOtRU+axRYm2D7ySl4ruUUULxIzVzgwbSG4iR3mVXRVO8l87PZHVttCpkXxnE0BqMda8q0UDqqtWMC5PZaxBloIdqimgDNTTc5ry+0be6Jt3luA+Sf9Z2PrCMLEswm6zjqoL209BSvt3Oe4bRT0jGsGRrbbqTcpWUa9SDf42raGbruxvz/WJzXGeLpihUy5nVALSkIxaLo5vJVVKWOEdSKtzLP5y4TpsT+ZGDBaXjTWcQkXjXdcTZYh4tjzop4nhZIvYjFFOzdbPPTFZssL3mOOuACDJWrIEeG31zT+h1UrT/YXbZZ2Tv5SAtJZixefH+d22Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ0PR11MB5183.namprd11.prod.outlook.com (2603:10b6:a03:2d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Sat, 17 Oct
 2026 00:30:18 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0522.013; Sat, 17 Oct 2026
 00:30:18 +0000
Date: Fri, 16 Oct 2026 17:30:14 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<gourry@gourry.net>, <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] cxl/region: Calculate peer distance only for reused
 targets
Message-ID: <atLBlibv3kbT7xv5@aschofie-mobl2.lan>
References: <20261015094059.46818-1-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261015094059.46818-1-icheng@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0280.namprd04.prod.outlook.com
 (2603:10b6:303:89::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ0PR11MB5183:EE_
X-MS-Office365-Filtering-Correlation-Id: 670af6bf-d8f6-4804-b5d3-08df2be5d21c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|18002099003|10067099003|260925022911599003|260925021311599003|260925021911599003|56012099006|11063799006|261009223027099003;
X-Microsoft-Antispam-Message-Info: 4A1EZC1fIkWfQI/qDyt7xroKVUDUUXVrN8hJDRIap47495md6KZ3aP7UnvvpaAixi3mRaMy3QM4z7XXGzIWxOZ7yUf7dji9GFjNsRjZTJdb9piPQHdohBeCFHSeNAMgC0aMpdD3Hru31aWOfDth1wJJKmS9bgX2xJldyo1Crti4UHeSGvj9JLyJ2gNP8F1faRHFq+rTiV+54nKTExJ+vNOgbbNY4baLfT82u2Se5tqfE7y9Ijgndw8Idjp2sqQrzeydyZeIL2r+nm1wQkjA4Ni0jsH0MccNJhzMNrM1evjbLnnXQYSpy7wnsy2VzKyXDTciUQtOVZ/1Ta2LtRe7R9ASzvMPZZNVJ1PcVjE1ow9hY3L79cOjEfUjSAEeaAGBdTL1roMCgfv8WEzlUfxXzYB+UU2OMYijkAOjSKRvvsZxWKCVQBh+oVJqNRGVOHiPTbUUsAIwUdnrtW2YRvvawu0PeKZuZljtWolfMTDkFx9Z6KGBKlfO9SIxbTDX8ULScPb02zaB92HhZ3xdcLKMl41U0kB3O5h8bFQhSVpxPxJFnWQ0o5L6ctDfbB9Zx42GG/wr1iPRKyBntOnVaFOnpb5U0EfCVFqmKhrQvdmo2oYMBBz3U99Inh1NTcGvfuKNO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(11063799006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y5WcuS9mRbZ9VxxgFHWZBbQoETogVU4nH/Ux1M3OYJTzMzrw71DDb0CgfGdp?=
 =?us-ascii?Q?1blaEmSoUUmc/LdCC00PnlsApHOrvvoC/zthPYoko7+9yZTMNA3cOcbAItqS?=
 =?us-ascii?Q?1UTx8C7VjBOMUiZ6mmgKZfREK6xXjbk3H9bpy419FAIkaoJFYayVSbu5S4rw?=
 =?us-ascii?Q?HYxjmU1556s0pHJIwPy/IMbWwxfsgCj0YA5Tilyx7wmIBwYcrkoMvmTzrQAA?=
 =?us-ascii?Q?WT9vKb5KzBGNBFBjUeRJwp4bK7Ti3f/48aqN+SDIT6mwTogvKQS2Q1gWFed5?=
 =?us-ascii?Q?ZIP/e3aHGTqNhKiLLKUJLNuGbKKZTc7NHfx1we7lHf3DLVgXS0Pn7V7/zXxD?=
 =?us-ascii?Q?EZabTqEfgdkvkrqV+QOzwZvBwAH+nKee3sWfhnxoFVCgRpNlvSw84d9v7gqK?=
 =?us-ascii?Q?OVbcjSLvsRLb4+BWMiJYFttiGMA0/Q3npaE1eE9VVhYxYnQilwKWNGrKJMeJ?=
 =?us-ascii?Q?j/0qjf8KmWoxVuCJa7LZ+VEnh90sN8Yqo/01z33Lp3Ai8UQ67ioIVIAzYN99?=
 =?us-ascii?Q?qUpZu64lA/YAzs5cbUSW9nLjBBS2OIiSKiNq2jzTzVPCxr7C0i/zOmhBA/MY?=
 =?us-ascii?Q?CoR3CxBFA+oBwp1nYiYosuPkKjPVWCbrFbSZsLDi6NzpempN7tar9n0rUUAD?=
 =?us-ascii?Q?cHiZwhqln7r3xisafC756DUjT6jQ7u/KPSjJwuwZENNilZAThZ6lE1/AC6hl?=
 =?us-ascii?Q?Z8UTx5ddV6VEVSTcePTCWHppl63JcRn0prhp7kdfpPE1IiPhIGZU3pZDVg3f?=
 =?us-ascii?Q?DlHHRJK9la9u387ps5a8wlWtN8mz6YOxGOEgIzNfV6eMP82AaoQUQEGXm2+J?=
 =?us-ascii?Q?+FSA5h9oao47EZ4xkkdVP/KwB/C4WlZUO3ti/ZDPjOs/wJmsWJF9mYDGx8dx?=
 =?us-ascii?Q?NRNb3+Wwrv/qXv4ewqTKQeFCw1qBbEqiR83jy2IhD0HkriuTUJ+6OryBWGOA?=
 =?us-ascii?Q?9BOqXD633h26SqK4EZ6JqpRvIDhYWa0F0v8fsk2va4N8qS1XYlTEyDLJK+pJ?=
 =?us-ascii?Q?Wckcyt3QZQEqyXBoOy1e76jTqXpslwW1Llnm6leKmMJghxE08gxqrso+XlEc?=
 =?us-ascii?Q?JMTDLZuLv7mNy0LzL3CYduq0GIKQdAViL4KM7bIdDtEwlBOdm/qtwckSRf+S?=
 =?us-ascii?Q?XQnD9Y4P2eI94BrfM8ee/Rkje+Rjciywjn7hcsUt5yxiZnvUJN0m2Qr9T9JW?=
 =?us-ascii?Q?GxZ1/1fKCPIYK10jT82bGdIwA34EX7pZx355jQbAU+o2XmoYV/L61utv/yuE?=
 =?us-ascii?Q?kl70gS/DIlcHF2MOt8sFbIyBuggaNwzhpyI62HbvH+qkLzASzY1o+j/+5ush?=
 =?us-ascii?Q?hEJQXtc1EvvtJZr/umE8KyzdMpoKM7QDimvCmh3vBveYUWD5XkKYMzjz0uj8?=
 =?us-ascii?Q?0OffzDhXSWPQ6os1DMFHBusDT7WN1vl0K19F9F8gZEpCyhs+VIEegqD+j7pr?=
 =?us-ascii?Q?CDYLI1fLIUbGG8pOgLc3tIoXMSBPeDdmTcBaGPHNl8cSlJkI/IG0VDte0GfK?=
 =?us-ascii?Q?dqtfg9ojSK3S8r6qyZ/BogR3LUs4ndUPtTB6J2BJyln/scmasa00icJD0rad?=
 =?us-ascii?Q?C0cbYSp+FY/sMGYFft+Ciyy6ZWuQrWAaSUpMM0IJOf9vyVXH1p41z46OU+sn?=
 =?us-ascii?Q?FKfz/HpAjesbyFChbbdbTw7Ek6X1Oh+5MjXjzOcA7qchuJEMoACd3XXk31mS?=
 =?us-ascii?Q?8N/GYBhlsrF3yPYtu3e9XhwWKaopwV84D204d+kf60TuJxR8dRpbLMGX+nuB?=
 =?us-ascii?Q?VwhcG6Ax0Tqgt0CYMJuhdww3GaY7f48=3D?=
X-Exchange-RoutingPolicyChecked: jgUz+fZse07Z+BmT1AuB/2SSZ3Eu+Dx2MVGyGRET1KAL6hMqNWWrRINtUrGPGle4i3Cfv19B6MjcQGt7Z2/F99hlSzTA7NeM7/aWJS8Zq+fq4/7LTNbY/JXHbluEA5MK/cevD5HHA3jZRRs2kGsTDYvSsBKuvj9F0J8W3vQ6p2/0v4XF9+R2q2Mg0kB6UP6kJau4cLJtqK6c1B16XdKAhvrP0Qcx/Zbbckliy/XJkTh2VA02sNmD5bjT3GDpmq/QhcJ6AHWDUzhBAM9Av/iZnykMPUmZFwcO6RYizeoYcVnRhlrXu8Ip5vourn50eF2giYYRUST8rDz5ngrDBAiTAQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 670af6bf-d8f6-4804-b5d3-08df2be5d21c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 00:30:18.5170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGe2gahnNZQvnHrwaMRyB8AYGmcfy3s/TSoeyeyOa0beP1L3Ssq5y0cUayz+zrfs3q9bR/S54zPvgPGpm6CeYKP9nBzuVGFPK/GLjBXyfU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5183
X-OriginatorOrg: intel.com

On Thu, Oct 15, 2026 at 05:40:59PM +0800, Richard Cheng wrote:
> This patch depends on Alison Schofield's v3 "cxl/region: Refactor
> cxl_port_setup_targets()" series [1], this is inspired from that serie
> as well, since her serie contains no functional change, I pull this one
> out as a standalone patch.
> 
> cxl_switch_port_setup_targets() calculates peer distance before
> searching the existing targets. When the endpoint needs a new target,
> the calculated distance is never used.
> 
> Move cxl_port_peer_distance() into the matching-target branch,
> immediately before check_last_peer(). This avoids unnecessary ancestor
> walks and per-port region lookups when adding distinct targets.
> 
> [1]:
> https://lore.kernel.org/linux-cxl/cover.1791860305.git.alison.schofield@intel.com/
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
> I don't have available HW for multi-way interleaving setup, so I can't
> exercise the case optimized here. I would appreciate if someone is
> williing to validate the actual benefit of this.

Nice patch! I've picked it up into v4 of the refactor set.

I tested it with using the cxl unit test cxl-region-sysfs.sh and this
at the end of cxl_port_peer_distance():

dev_dbg(&cxlr->dev, "%s:%s: peer distance %d\n",
        dev_name(port->uport_dev), dev_name(&port->dev), distance);

The x8 region went from 10 calls to 4. The eliminated calls were for
new downstream targets and the remaining calls were for reused
targets where check_last_peer() needs the distance.

The x2 auto region also went from 2 calls to 1.

I tested the peer validation path by swapping endpoints at positions
0 and 2 in cxl-region-sysfs.sh. The mismatched peer was detected and
the region rejected.

-- Alison

> 
> Best regards,
> Richard Cheng.
> ---
>  drivers/cxl/core/region.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 50f4830c225d..efd173c57dad 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1666,10 +1666,10 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_regio
>  
>  	cxlsd = to_cxl_switch_decoder(&cxld->dev);
>  	if (cxl_rr->nr_targets_set) {
> -		int distance = cxl_port_peer_distance(port, cxlr);
> -
>  		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
>  			if (ep->dport == cxlsd->target[i]) {
> +				int distance = cxl_port_peer_distance(port, cxlr);
> +
>  				rc = check_last_peer(cxled, ep, cxl_rr,
>  						     distance);
>  				if (rc)
> -- 
> 2.43.0
> 
