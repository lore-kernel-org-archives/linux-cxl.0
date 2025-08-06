Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C41A1B983F
	for <linux-cxl@vger.kernel.org>; Wed,  6 Aug 2025 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511436; cv=fail; b=XpILqQijbb7UwiQqheqN1g8XWJxdaSFP5BKKMdy9KGMR/0XGK8yMZOsCy0yOu8+6P+n9mF6F6bFAGvAd1beO4hXvzEHVSiXmOMR7U2Y4XaW45CWaGlFqAbFrHFJzR+RyCHC/wVFh35j6odryeTb5zFd8Ezwk/Xbcq+oryftftvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511436; c=relaxed/simple;
	bh=MgoalzXxGHCEjFicCAkiMb1FRpvYxuWsB/+ZsNqso38=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XDqkLKObRZkzTdRKtiQ/YhEqruvd40NFFBZ3v/LrHiX5ihkgT71fLDIRnGjwkqSOn7f3ICKcrI4DqhSEBd/hOieG+6o5fFCcXrbjs3jiQ3dRU1zlIan3bQohupV3YU9/EUGqUDh1xotDYMERsF4C8JofXbcHPYkoWFMEKrE1PhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5LHPrk4; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5LHPrk4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754511435; x=1786047435;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MgoalzXxGHCEjFicCAkiMb1FRpvYxuWsB/+ZsNqso38=;
  b=M5LHPrk46ZaYYmgB1UNM3pySjojg/hwQQchUjH3LOKfJH+OgApIuwd+m
   MkdQGS1Pt30YlJB2IsknBxyQAcvU5Czpub3P+RuelXQqXZF4/GXy5DmGU
   BrJxDO40r6K6f0PNBlFHsAv9KPRQgmp/GaUkdTYOwFfn/e5g+nrdUjzXb
   6ZRtkQN+Gop8AG4llIunJkhNJMOALoM4HqxnHOcBvhdNRZBlEYFrB1oKv
   NkFX3euWZPnq6cXsLZo9M9hmgGQL7U5ETM7v/THNpjsNfzNOnwsW5KbE7
   OQPISz3zcW2HxW4vmmNv8q+qsU3gSipTX1FkqwrzrYb6iiHvBgR5yJgHN
   Q==;
X-CSE-ConnectionGUID: W6o9h5gwRf+sOHv/fg+BxQ==
X-CSE-MsgGUID: bjWDsw5gRDm6ILh0p8W+Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="59456342"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="59456342"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:17:14 -0700
X-CSE-ConnectionGUID: jRaL/hCkTwqZdcGrLEkgxw==
X-CSE-MsgGUID: yaNrm2QzRI6J4z8LbIfgQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="164066511"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:17:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 13:17:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 13:17:13 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.50)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 6 Aug 2025 13:17:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNpotQlMoF4PMnWl8a0xzJiEr6R2UxN2QkoYo8dot8mJyeGLmk7mJZVnxXzcOXcB1PxGjV8A4xbwi6If2ngMBuqJqIAYhkbvEZUmJUxO8vTFmCwMAen9yKbvNSemQ7fhDkC5ygymPaCrz9gHdNcC6gRSK/7FqFoTtJW3PCPFr4iH2mJu6eYV8E5Sn68BtC8lQmUjkqILBT5NxTYOd9bNSrJ6ghYULRVXBup0sV0D4k/teXoCjq/6ylLSZCwonUM3c4bWH4HP+7GibJv73Hz4GkULNCwpcP5lrH9WGIOeMOQ8WpwURaSmLSHQLmXYlO06df7Ale12AhCUASiaAxWOJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8D+xnOYoGls0ABJUAjWau+9NyB09MuKVKUvq9ksFQcg=;
 b=rgjIVWMv3eI6ICsVpvtJz0Xki9qX9WANPRrRMlMWNJtcu2qs2EyofReIzM5+DqlIQQmSlJZJ92Vz88EtbjbZe+fRPNAI5S8OG8IbRr8UFx+ymbTpPCwl1QARjfW/TGo9e6ZzRoJmSLur4GYEfTvP54CvpMDsCKkiIjnt+nLgLtKrqiMGiLlxLG+PrAU6AKu0zgLVtd3MCDcGbdHXDkizoDWmPN/Ph4mt+j8jOG45QmTQR/saO2QmrK9MXOlMbcfttXP3Gvw57c2aKI9UMEXdnsNg1gfD13hyw8jNAcjNMAuuY5p7wjWln1FbF6dQpI5gFRlJt50ayp0SmyKzFzKe4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA1PR11MB6515.namprd11.prod.outlook.com (2603:10b6:208:3a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 20:17:10 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 20:17:10 +0000
Date: Wed, 6 Aug 2025 13:17:02 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Limit XOR map application based on host bridge
 ways
Message-ID: <aJO4PiyliQiJpMjO@aschofie-mobl2.lan>
References: <20250804082357.2590809-1-alison.schofield@intel.com>
 <6893a593bb584_55f09100bc@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6893a593bb584_55f09100bc@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::26) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA1PR11MB6515:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c41743-9ce3-42ff-97c6-08ddd526391c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vyzJU4ORtahvsmlOmUBzzTzvzCnD19masJs9Rdgd1TzdAKet2HpbwA+bph/H?=
 =?us-ascii?Q?lU95YQj72doWn3/TbwlmV+r2w/rdyIV+W8diYS4mN5fatBpx9GVNlYGG40aZ?=
 =?us-ascii?Q?C8nrikVoicsswY/Zd3tvATzqRh/Rt0pZJJLecZ32brguw/3geNiOJF0A0zf+?=
 =?us-ascii?Q?3dbEcJ8iJtrlgGkzHm4WxHSWgGlTjVkX+fRHTl6/UwaVGZG4bW8Ja3Xc7JUt?=
 =?us-ascii?Q?L4b2q2fAVmJU+ZbkAO6NiF71a3ee3c16fGMoblnq0EcSbBpCYw2k7V8AxavN?=
 =?us-ascii?Q?8JMpDs0K7n76xnclQoIiWUv4XPuDql6t5vbD6thcGGiN6RZe0uqfbB1L35Wm?=
 =?us-ascii?Q?drtozd+2I1rpc8dQnbuGX24hBt00sC1YDNNmqrwwk4xeIaf6FGrzBwfTVtPS?=
 =?us-ascii?Q?67Vx58joT5rk3vQ/B9KTZU2yNVi+MLMwcU4OsTGHt0bsTGqBJO1WGdOkh16k?=
 =?us-ascii?Q?z+23Boo3CPwRDkIZoesw+ztI9QhRvP7YaGH3yFDx8n2VFM9M6P5P+nJpTjU3?=
 =?us-ascii?Q?ZsDQnPO+jfOhcwOX7YnJ0DTuCS+NS0BhWbAuNzpa5poRonoTWZ3POorJ4PoV?=
 =?us-ascii?Q?KfwM7b8j6uW+b3pmCBY7vyoDkNjG0cmtvtTxT8nyY2i1E1GkrDHoOxq9J3Dx?=
 =?us-ascii?Q?TAylDxVoU1SY6Z3wu8QplJCzyEfnS16eslWhJtcF++cLKZnTgWiYj2RYWpZV?=
 =?us-ascii?Q?1+0Bske438vwfiq6/o2Pnegd3BEtHL5sZ3B7fuzg5WLA7Iw0/lanvz+fAULR?=
 =?us-ascii?Q?w9AQQ66oQsCb+GyspYuzLDQjfs7mGOHMcM2d4fFVvjacfXeLUMzldmFKfyad?=
 =?us-ascii?Q?ymTDbkPUrCFVHgeOgQrUhEZoYL5Dk+3nohxW5o87AS7eAYA0O6agEoM2ggNb?=
 =?us-ascii?Q?Hke2j6BuiXjEsAKLZwFIz6K9oGc1Bf1wcL2n8VY1VAWRtNYpQZZqoUOuqSyr?=
 =?us-ascii?Q?PD+icVhDyI28VNhaM4MDoWCvVJMgoH5gxDNWZvb3HNyMt9vuKj6vUkRoTaTM?=
 =?us-ascii?Q?v0egitQWiFzUGbkrDwtLt/qs/5Q8vQBz1X7tI5XGbJzHOI2HEmTOx0E0iR1q?=
 =?us-ascii?Q?XnuuL2Dtl1ouSOHt/WxSqwbl6PrkxS7fy8TdMeFMSLTpDXAS3IgTSrz4KHXR?=
 =?us-ascii?Q?jbNZQ7B9wMyVwx83uPAGbujlReGPfo4A7k/JoH3O0LZTu1xXjX78K1xWgvcW?=
 =?us-ascii?Q?n7xWOa4oq7I2DHqqOhN4WXfnMZKh7jMMASTuUpTp8a/ypzFHr0g52eFVlqIp?=
 =?us-ascii?Q?/LswhxyASB8cKuGM1XBiyhQbMPxqcRCBAXUVxL2gwKiJRC3W7Jfap5/ugXT/?=
 =?us-ascii?Q?Rqb9z85XYbQ7WM9ST+/ZXulDYOSfRYqGrWrdrJRjoUUAp6/a3FIoQ8gqjSfy?=
 =?us-ascii?Q?3gGcdQ5d78F5Jj0fa0Xrvj0hQ8RU1i1LGbK2dwqzCZpe82011ViYGUkKhCpQ?=
 =?us-ascii?Q?jGwvk05WcZc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RKB5FM9v5ctv81A5y+O5vbCXOCvvOuM2beVg6DdgAt98UW24anIwUC9wyn5G?=
 =?us-ascii?Q?bPHXYmjwjjcXwWogk9CewxiLVMw+uPXPrsYA5acSdGjNMG/ErZqvtSeYLQ5O?=
 =?us-ascii?Q?T9U1EJ4K1IH9jvpK4GMGthB4mmt3Z8Vj0NoE9AY54mx54gqIBUUtbq92NFK2?=
 =?us-ascii?Q?SbS9maM6r+UisLLYbiwha+5XoUDUi2vLljglz+IepIqLijrpk7IbXQNJ6L41?=
 =?us-ascii?Q?EPxUoZT8n+uOIc84sT8D3LR5n4/K6J+8smjvCgrjM92/sjC9rm1zbIhIBKQv?=
 =?us-ascii?Q?//s44tUhNmS2j0LsEOM9fgBSwnrKL/NtIQjZC8ebkOj24hgpIANmJQsn87ny?=
 =?us-ascii?Q?KIQJS71huqYHsVIqpW/i0BW0RIn0GzHHz5FiFcTxqtq1uvQ2rWyKhOi69cGv?=
 =?us-ascii?Q?tR1OgYxNvdTd464BFV4J2cBJ7m8ZEIPrEpK7ET7ignLg9gHZxt1PUFOwIdKM?=
 =?us-ascii?Q?jA5Vh6T5w6XAXVQy4YrsDqaXcjCkeCDe7doa5NY/LcChR/HKdMRRL60PwpGg?=
 =?us-ascii?Q?FiRJNVerrPr/Jd0tckzw+fJUJH+pAsfEaQAJRAKpq55XUZ2v5h7Xm/zislCG?=
 =?us-ascii?Q?LW1PyNgOQKBCRFYfuxskQNRIJs+gXJ1VOcfuj2T+sKeQ9Lh53C/5+nUgmmxE?=
 =?us-ascii?Q?9RARfvI/pOMELfL8uGshajT669J7bXxemCaa0ZN5b5+/9YbnD13/Wq1X/j/Z?=
 =?us-ascii?Q?63p9eZT+RwMueZhbdapBZ5WfnMtyZQRz6XNTZ3OP6AnzmtII6VuzGuG+VgUl?=
 =?us-ascii?Q?vfkDqLefCaMElLeUG7QruwiuWZnqCcBnAHUvOmUTOM/P14tcjVZCP5+zwlby?=
 =?us-ascii?Q?Z83hXHdcg7y9JzzWM/TS1sYFfb90pAcNabaDISnScpg2HNP8kxwpUL8mF+Hx?=
 =?us-ascii?Q?rjkivS5pFkvJkRa3l3+VkVIXjMX4xt5hzyv8MJhDjHDZBX3hdtcAjiOBtM3m?=
 =?us-ascii?Q?eKMQLXAOF4qqAHM4g7yeBHYlgBMDKS+ryMvPqHBxCmwV1B5+oQJuKjLQi9Ic?=
 =?us-ascii?Q?tkuzwyQ5KZ7PhPhL97D86m5jtaiwXuRhBP6Q2ZXbryY1CK2DY3IUpUwTfkVl?=
 =?us-ascii?Q?yCMGxgZ2RDi+iypAvH+Ydy+NfC+cgH17f5zQdnhiVY/E3QrfEosw9jevHD3F?=
 =?us-ascii?Q?9U/73R1yTT2LUYzpVdD7a9+0FS7mAOEDntz20ZRRBTAGksBTnH92kPWEVAi5?=
 =?us-ascii?Q?ynGNAacb+JW1XVbMV5mP8z7w3bm1fDPOsC9023ZgYRGwZ+iuFrxB5QWGg5ou?=
 =?us-ascii?Q?EZ2gmrsLHmigH0eHhB12eZZ9R9A6rI947XjnZtochR4w7mv/fLfQNP8mhXUe?=
 =?us-ascii?Q?dflZDLJsdX8xX1PFnD7Qfxc1egdXFmnNrcSvt5ymLSr2ZCy88zYm0/gSEBCi?=
 =?us-ascii?Q?jhYgxSBzVR1x5A6enfUIwm6mHjlfLg7R5ZmnTzfn+sYTeQeMNoOJFgHaozgy?=
 =?us-ascii?Q?u52FBfgW7d1xAibCfUnqpeSLB/0MIg96IXw0QylKi2+wkVNfgIdKuiOgX0P8?=
 =?us-ascii?Q?cBHuKd6MwiXwOFYt3fezHnEjOfstB600Cjc5Q0RxifX+bLobSgB39uFHwRc0?=
 =?us-ascii?Q?0nRDznbW+iAmPFLtiGwdVbZw16vMCc37eSIzgcYqpOYMNQ7HjlDt50/b2XG2?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c41743-9ce3-42ff-97c6-08ddd526391c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 20:17:10.2936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0Q2oDv0kcIRhI8Py7zzVddI7N1K8enm8att1T2hBCtX7d3zL3fnFfcBZc2XP5QHcPv4zrWS02bAYTYcvree4trDn5UAZfW5lRqCL2+1u4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6515
X-OriginatorOrg: intel.com

On Wed, Aug 06, 2025 at 11:57:23AM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > The CXL specification defines one set of XOR maps per Host Bridge
> > Interleave Granularity (HBIG), but the number of maps to apply
> > depends on the Host Bridge Interleave Ways (HBIW) for each region.
> > 
> > Currently, cxl_xor_hpa_to_spa() incorrectly applies all available
> > XOR maps regardless of the region's host bridge interleave ways.
> > This causes incorrect address translations when multiple CXL regions
> > with the same HBIG but different HBIW's coexist.
> > 
> > Example scenario with 3 XOR maps defined for 256-byte granularity:
> > - 4-way interleave region:  should apply 2 maps (was applying 3)
> > - 8-way interleave region:  should apply 3 maps (correct)
> > - 12-way interleave region: should apply 2 maps (was applying 3)
> 
> Ah, makes sense, thanks for including this detail.
> 
> Do you have cxl_test bits to backstop this fix, even if only in local
> not-yet-upstream-ready form?

Yes. It is testable with the cxl/test patchset and CXL unit test script
posted on the list. [1][2]

It is that test that uncovered this bug. My previous, out of tree
test, applied the xormaps based on hbiw, the kernel did not.

[1] [PATCH 0/3] CXL: Add a loadable module for address translation
https://lore.kernel.org/linux-cxl/cover.1754291501.git.alison.schofield@intel.com/

[2] [ndctl PATCH] cxl: Add cxl-translate.sh unit test
https://lore.kernel.org/linux-cxl/20250804090137.2593137-1-alison.schofield@intel.com/
> 
> > 
> > Per CXL 3.2 Section 9.18.1.4 and Table 9-22, fix this by using
> > a lookup table to determine the correct number of XOR maps based
> > on host bridge interleave ways.
> > 
> > Fixes: 3b2fedcd75e3 ("cxl: Restore XOR'd position bits during address translation")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/acpi.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 712624cba2b6..5154effb0cb2 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -16,6 +16,16 @@ struct cxl_cxims_data {
> >  	u64 xormaps[] __counted_by(nr_maps);
> >  };
> >  
> > +/*
> > + * There is one CXIMS, therefore one set of XOR maps, that all CXL Windows with
> > + * the same host bridge granularity share. The number of maps to apply at address
> > + * translation is based on the Host Bridge interleave ways of the CXL Window.
> > + * CXL Specification 3.2 Section 9.18.1.4 and Table 9-22.
> > + */
> > +static const int hbiw_to_nr_maps[] = {
> 
> I would feel better if this was defined:
> 
> static const int hbiw_to_nr_maps[CXL_DECODER_MAX_INTERLEAVE] = {
> 
> ...just to have this pop up in a grep if someone wondered about the
> implications of bumping up CXL_DECODER_MAX_INTERLEAVE.
> 
> > +	[1] = 0, [2] = 1, [3] = 0, [4] = 2, [6] = 1, [8] = 3, [12] = 2, [16] = 4
> > +};
> > +

Got it.


> >  static const guid_t acpi_cxl_qtg_id_guid =
> >  	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
> >  		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
> > @@ -23,13 +33,13 @@ static const guid_t acpi_cxl_qtg_id_guid =
> >  
> >  static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
> >  {
> > +	int nr_maps_to_apply = hbiw_to_nr_maps[cxlrd->cxlsd.nr_targets];
> >  	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
> > -	int hbiw = cxlrd->cxlsd.nr_targets;
> >  	u64 val;
> >  	int pos;
> >  
> >  	/* No xormaps for host bridge interleave ways of 1 or 3 */
> > -	if (hbiw == 1 || hbiw == 3)
> > +	if (!nr_maps_to_apply)
> 
> I wonder if this also should have a...
> 
>     static unsigned long const nr_targets_valid_mask = BIT(16) | BIT(12) |
>     BIT(8) | BIT(6) | GENMASK(4, 1);
>     ...
>     WARN_ON_ONCE(!test_bit(cxlrd->cxlsd.nr_targets, &nr_targets_valid_mask)));
> 
> ...because I could not immediately convince myself that all callers will
> have been careful to not pass invalid nr_targets?
> 

Here I assumed the only caller is the validated caller in the CXL Driver.
However, in the patches that add testability of this function [3] I did
add guards against bad hbiw's. Let me compare what you suggest here to what
I did in the later patch. I did think it would made sense to add the
checks in tha patch that exposes it further.

[3] cxl/acpi: Make the XOR calculations available for testing
https://lore.kernel.org/linux-cxl/e2ffaa6a29117fd9832542e4ac314b46ab2d1fd8.1754291501.git.alison.schofield@intel.com/


> >  		return hpa;
> >  
> >  	/*
> > @@ -47,7 +57,7 @@ static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
> >  	 * bits results in val==0, if odd the XOR result is val==1.
> >  	 */
> >  
> > -	for (int i = 0; i < cximsd->nr_maps; i++) {
> > +	for (int i = 0; i < nr_maps_to_apply; i++) {
> >  		if (!cximsd->xormaps[i])
> >  			continue;
> >  		pos = __ffs(cximsd->xormaps[i]);
> > 
> > base-commit: f11a5f89910a7ae970fbce4fdc02d86a8ba8570f
> 
> Feel free to add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Thanks for the review!

> 
> ...with or without the @nr_targets_valid_mask if you determine it is not
> needed.
