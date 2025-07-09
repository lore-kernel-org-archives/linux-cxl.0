Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50FAEEB3;
	Wed,  9 Jul 2025 01:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752025081; cv=fail; b=ihkWtFdMcd3qNOj+OSXKqmrlVEn05xzIEQb5YVmWmn7Na4Wv3Pd0DjnZ2/WEJw3yHkEKs/pXWlGwlrJBxtxahWbqwVP6weSuBYagjtDSls6AJdGmz1nbwW3t9i2K+y365Yr+viNISUpsEqU4F/0FTx95GhSiqdqk9jxUeY1QKKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752025081; c=relaxed/simple;
	bh=3pUi4RKVD9wzibvbGoT7gwLRJMFwMq0I30bDk+9gGDE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ayCyNeRUtR/KB0dQU8CApD/MEYIABimesf+wzOQ7iHiQDX4oTjcY2KF1qyJZ3fPmtKGJydDkGzevxw/1Mr0Jz9pzNdgVfiRrgtvIWaM4mVXoj8WvM/sEaAfnRFaJEfxwRcgMNnW0q6yhNiAOWhH1wkKRsfepLj5hyWO8jxlVBkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AEphFnyk; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AEphFnyk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752025079; x=1783561079;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3pUi4RKVD9wzibvbGoT7gwLRJMFwMq0I30bDk+9gGDE=;
  b=AEphFnykbemM8Qpok/G+/crrJkm+GEPiL48aFFqxFUreT2T8EN+9/D73
   9irNX5NXCBKro65s5Ij7a64hxMXhr3+dq6PKA7kYFa7KBs/aX4CjiNnUB
   JROwpjegNCMsfNPFIe4cWdIBzL9uJgYKHDk85lxfLDbmoxsE+4w0VJFeA
   tUdu0hQSR31rC1owfP/XhCogIoacLqfl4A1sWlGnv/LDH6XncZLEEvk5k
   6sFmO83SuUEoq0Kw1uMe7F9CoUFtQtmRMrHHXZvt/6vIcNcY9Yn8oJk/q
   bufPTfOple+espyEHiZQRgriQvvtNKoD8Cav7GdUVNYyGO+11JNVhH6J1
   Q==;
X-CSE-ConnectionGUID: 9gv1aWT9TTWXUMvedqeTsQ==
X-CSE-MsgGUID: qb0bv1XUSyGwCXrB1r80Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="65337374"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="65337374"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 18:37:58 -0700
X-CSE-ConnectionGUID: RqVx1iHkTACWoNIWCokiYQ==
X-CSE-MsgGUID: pqngTkWgRKC5+6lmIm1qmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155055853"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 18:37:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 18:37:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 18:37:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.89) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 18:37:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4S7Li+8FePzeQP274w00ngXBF2XTUsbtuf+a86pdEU6k9P6QGmmzeAHXWiKrF25xw/SaN8Civqpjbnd/TI71dU2Pl0qqfOfO7M7lY27cuiGQFexDkXr12oc0QYZzczoS79vCB1jTqyeyXjgvtP7hOD7Q0AuIxB+9WrIDqLRJicNM3GWz56T+iyzKXc9LPpFiOIss0CsAMzacLXDsk/3VW2cTf2i33RkDslvmyORlzqQCm9CfPH/UeDaj5johlH+dZAsNuiafC8ECLQhv7LvqnpnjHyAhsGI4oR+OHvZbZFtnN47QSwJDuVfdvDsYTrAjE+xo2I8kOoyK+IVlEFVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xgdt9ns8RbwqV6YMfL6HqmIbGdeNqpxXz5C3ML/NvnE=;
 b=NUGwBiVv+XEWaDpR/AOat/0EAcfZrMOqjZ54T0wJOwvDffrfSF9LJOvr+bnUjrsDcZWdeTQ6onX1FRbXeORKdVA0zu49a+yWVn6j3TcIzj+vpz4JqlvlXjeAIuiA7iryVjhwZucnsvNJXdlpUDm0IWHdH2pksN0+il8ESPEQaZ+BwlxyIWHTOFOW4TCGj6TX9lvI94UIMkCFuGOovKj+cfqQsts1WUJAVrU4U6Ct1vker9Kzoaqoir1mexhJ7oekuY2BkquRVoSZm+EMrRU4wRi0SvTQM9ITQK0zMJk2IkBmuCRxv9+ixbCp/lWFqE6RNeDTifX/Cabdf3TgdUWUCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 01:37:41 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Wed, 9 Jul 2025
 01:37:41 +0000
Date: Tue, 8 Jul 2025 18:37:34 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] cxl/core: Using resource_contains_addr() to check
 address availability
Message-ID: <aG3H3tLvBzEtxM6J@aschofie-mobl2.lan>
References: <20250708051536.92119-1-ming.li@zohomail.com>
 <20250708051536.92119-4-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250708051536.92119-4-ming.li@zohomail.com>
X-ClientProxiedBy: SJ0PR13CA0092.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::7) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SN7PR11MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: b55facdb-bfab-4036-041c-08ddbe893203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ExcZrLM3/YfPDvYyUeBa2AcDGKSOMZCIMJ82pUHh844XRiJjycPUOz7DffRo?=
 =?us-ascii?Q?yUvH7SiEcY0quxhYY/L5F9cq4HStWvpj/NSneQ77OgCeoHaeimEZc+fWyYS9?=
 =?us-ascii?Q?1Sfpr40nMwnUJZec6oBmHYIt/spjFYzxqyEtWL23LZj7RdtMcVgstO4b1Sxn?=
 =?us-ascii?Q?u+UAuMTI6G56Uy1P2J6HW3C7rA8gRMnaZUClUk4KKUADHdWGh2CyNYIUf+JA?=
 =?us-ascii?Q?YaROGeefHQbRgXJrJkans2Toj//9gZdwnZOunLF7KQpZOunF05TyJxKP2udw?=
 =?us-ascii?Q?k+kV8Er9x5TpL1nEft4x/3zCqxkaNjsQlZ7igMcgx/MUb5QQqeBAb9stmX9v?=
 =?us-ascii?Q?ukLzxB5zPqz2CRtyBvtS2MF187oEt9FssppDhmWl+sYpVDsiAb0IZw1kdAW8?=
 =?us-ascii?Q?MYqIn6wRje7m8Vu+EjZVg2an28h0fyq+16e5P++RWRtG8WH13BVIPaNLf+MK?=
 =?us-ascii?Q?B9KEg9EpuAlf0it4FSzqCHVB7o3mc9r+Si7Molvh0RcaN4de9tT+3+AuW6Lk?=
 =?us-ascii?Q?y5rZwc0JOKE51BFi51ca5qb106sXDuZFaUIwGtGfzHo+i1hYWfAvliigtCRx?=
 =?us-ascii?Q?s4mTRZu/ENC1e3SxUvqp2UmyelkoP7K5e11YZVb7UwZPMgzfftmIcmeGgYxY?=
 =?us-ascii?Q?c/tM7Pyzq5f/+5Kbt5wMqTKwUcz2wUiCArOug+CFXsZlaCKuQBCgLJ1zwiZT?=
 =?us-ascii?Q?31xcFXkD8x6nNTPYUoAo3vBGBJjsjPGvps3SVEBkEkSY0N7SIlkYXk8IP8xB?=
 =?us-ascii?Q?pD/F9NCuJOKH+yc4zbZGcwhnXMPrDM8vJAkGFPdu6+Epfyq71eO07soRaqnL?=
 =?us-ascii?Q?qbZF4cyYWGLCI4b0NU/wDgJ1p2ep/HPunTLxHAgRhC9kmUJvv5XvJcqbqVTQ?=
 =?us-ascii?Q?3N4soktORKGMyaOM/GMF4GXGnaKW18TkBR8iBo60XIc8qo7JKUR0IPwki/YT?=
 =?us-ascii?Q?XD+BbhXz9HOQIyRzUk1aQ14mdT0lXjfIbRHLAVwzyX2m9C4Hxb7YB50j4/cL?=
 =?us-ascii?Q?mBQcrUBIgEQFQVT1TSUyO6NQ0U4wK8GW6VWOfCGOWlJodycjZPES7kOsd7Pa?=
 =?us-ascii?Q?ag9/XFnc0K/7JCbN696G3RhKtGB+3YOsgFszpFRECQ3Vw+cYmmU9ACFEicGh?=
 =?us-ascii?Q?dHnfj3G6YKxhkaglKyBmU4PiaCmd0/TPhkDZTUt7fHCDKkc3/oXvoDvIQ6RI?=
 =?us-ascii?Q?QDdw7m2A0tGNujv6MPQyoJNjSkudj01XxWS2aZtBwb2QdLriIoZG8Dnk5cVt?=
 =?us-ascii?Q?UShDn1cAjSse5xXvEemcOPHysQv8F4JqKss1I3szoI69O01YfB96oql611ao?=
 =?us-ascii?Q?WRYleYWAkmIk9GDo3hy+vGUHswK9tnwWHehHk7GpKO5wMYC902sJqCmjVqin?=
 =?us-ascii?Q?HCEtNLvY/LOIw3/y1bot9UHkca1Mq2ItpjknxYuxjJZFYdbCVPRJ25qrVzYr?=
 =?us-ascii?Q?2kn/D6hcBu0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7/35DeqhrEsBTbict0U9TUrhPW/S+xmHg4/o9XbZl0G4J9ZUEoPhHaPqO93W?=
 =?us-ascii?Q?bqqMXUNredLMA5ldNdyCwMbTwaky8bTY6A+0SeXxrWA3NMb/roNAG9BRX1cI?=
 =?us-ascii?Q?+CG0EDibb/IRG6NC+lZ94WGRY2FaiIL/mis+aCgay0ZpyIZuEPd5gEA74jn6?=
 =?us-ascii?Q?6eWAFBJlXFRj+yjJffGP2XWUcwDWq5fdpC5LqXbNnlIh6dK0oviHNY3QkAZk?=
 =?us-ascii?Q?azssllEUk8tm2++MQ7TUvPLm5+0RnxrUPFd9CTY6cGL3/1bFneEwC9tZkESh?=
 =?us-ascii?Q?8jxQTrX9mr0/NSa/aLctqzdihXIS+Do2waw98tZd6TNmuGUkOFM6p6UPw1Y2?=
 =?us-ascii?Q?PKYQvZDkv/sDp1Z1y2e3TFgKY/KWmb7jZ4kW755dxgPHJCHUJCFeYFx22HZ6?=
 =?us-ascii?Q?9QvmxBGECGKLe1kmv4E/kFu+nmCnYh72ij3l+S0c1Sp7P2nk+q5RKy77XYBX?=
 =?us-ascii?Q?TzkyFtWBUFxHd00+YscQ/YZuIsvUPMGB44/EaV5Z+DNXO+S9sLH554mpWQfb?=
 =?us-ascii?Q?md+5jNyx5CX8OKPR4h3MNw6EUPiTX9xG9EsGodornDVtUgVHSsGLLT0dJLPa?=
 =?us-ascii?Q?r67OkdC3XniKbyo9pL4XIHggvQEalgNlZYA0Zy8hTa7qW5hNuC5bXxtkK0+N?=
 =?us-ascii?Q?jYxzDusQub9xOb173X1mV5TJM9fKSfPG5qIu5BqnC4LQb3RzBPwtMxA1vWLw?=
 =?us-ascii?Q?JVLdEl74QlTD7zWKjzmDW8yGVr5/yHMjtFHNx5LEFVKwgCQZ7n32HOHP9bDF?=
 =?us-ascii?Q?MKrucAuLmXFNg+3/BuSzYOuGqNNySeNpJ2HYbFYTVgn+oPt6nVwdDchJkzEu?=
 =?us-ascii?Q?nzsvB/dYwPNCDux1m5K+w2JmwyyoyeT4UataOpzCmyD514kkd9hcWpGbbxiF?=
 =?us-ascii?Q?jF7sk0EIsxzZ4zdS2tmAcvliSkdGhVLGkofI7hrapAKy1nOxJqIXpwFi69+W?=
 =?us-ascii?Q?ony8yKNh2F5pcSCLOklW9nspvH6CrBA2wc2Kns/zz6wenoCZzmNu1oIdDY/Q?=
 =?us-ascii?Q?hsZ+LiAFAp+2NBArX8Wp41E5ho6+jUp+ktyqx/wkjPxQZ1jAzqxlseS76rRL?=
 =?us-ascii?Q?2DDgnloqozF9SGE+y4RZqcFZB0vWBtaHU8DBCDBC3YSD378oosxCF2h6WyZ+?=
 =?us-ascii?Q?0VwDwJu5lnSk0Zb4dFkyfH/NXNyIRgwt53RlOOzBR4C8vUP66VH/zgacCopx?=
 =?us-ascii?Q?SpiDa2+0dCGHDLWqowHwU46WqnX3whLjUiYPX7hjkVkHerYA/ePUHQ97AmlS?=
 =?us-ascii?Q?YVfftEdriWX6R6q4W6bb8n3HUhdzV2EAZn468J2+k4G0tx0BBbfc36aYHYdO?=
 =?us-ascii?Q?+8x+6ElkogatvxFt62iAe5QVCA/GhYGOAK1ObVIfCaKXmSJxGZV4bpauwT/n?=
 =?us-ascii?Q?fMDV5aJWGkcU2qU6SMf4U4j+xa7gMnHim/VcZpPKZbkrzRwg6rrj1u4hMAyN?=
 =?us-ascii?Q?tsfo0SJUKFLbxzac1Ah5b93tHKgVqm8xwRRPgwZ5dO0Ntet3We9DHqmbe5eo?=
 =?us-ascii?Q?Z6jj9jg9mADeW+uekbfX5ggGUWRp7T8+r6taDDC/Tyl+Kzj/QgT6Uv57Fdh7?=
 =?us-ascii?Q?UbFLjqwitvepW8H5ZQrkeoHZ24DWBgIY278ML2oJVYbPfOzh8Xrdf49A0KWM?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b55facdb-bfab-4036-041c-08ddbe893203
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 01:37:41.7414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gD486pnapwpee+jrqdtjDCP9piXIIAjzav/V/Htf4AZ54yrvpuJNhaRF83+qMsTbVgxZ7GDpKGsD7sfYR89qyniJwv6xoYr5Asa95JssC+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8066
X-OriginatorOrg: intel.com

On Tue, Jul 08, 2025 at 01:15:36PM +0800, Li Ming wrote:
> Helper function resource_contains_addr() can be used to check if a
> resource range contains an input address. Use it to replace all
> code that checks whether a resource range contains the input
> DPA/HPA/SPA.
> 

with the cxl_ prefix update, you can add:

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/edac.c   | 4 ++--
>  drivers/cxl/core/memdev.c | 2 +-
>  drivers/cxl/core/region.c | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 1cf65b1538b9..a3c19ec8033f 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -1523,7 +1523,7 @@ static int cxl_mem_sparing_set_dpa(struct device *dev, void *drv_data, u64 dpa)
>  	struct cxl_memdev *cxlmd = ctx->cxlmd;
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  
> -	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end)
> +	if (!resource_contains_addr(&cxlds->dpa_res, dpa))
>  		return -EINVAL;
>  
>  	ctx->dpa = dpa;
> @@ -1892,7 +1892,7 @@ static int cxl_ppr_set_dpa(struct device *dev, void *drv_data, u64 dpa)
>  	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  
> -	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end)
> +	if (!resource_contains_addr(&cxlds->dpa_res, dpa))
>  		return -EINVAL;
>  
>  	cxl_ppr_ctx->dpa = dpa;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f88a13adf7fa..4a5dc1d93af1 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -267,7 +267,7 @@ static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
>  		dev_dbg(cxlds->dev, "device has no dpa resource\n");
>  		return -EINVAL;
>  	}
> -	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end) {
> +	if (!resource_contains_addr(&cxlds->dpa_res, dpa)) {
>  		dev_dbg(cxlds->dev, "dpa:0x%llx not in resource:%pR\n",
>  			dpa, &cxlds->dpa_res);
>  		return -EINVAL;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6e5e1460068d..79d8211f8ed0 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2847,7 +2847,7 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
>  	if (!cxled || !cxled->dpa_res || !resource_size(cxled->dpa_res))
>  		return 0;
>  
> -	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
> +	if (!resource_contains_addr(cxled->dpa_res, dpa))
>  		return 0;
>  
>  	/*
> @@ -2959,7 +2959,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	if (cxlrd->hpa_to_spa)
>  		hpa = cxlrd->hpa_to_spa(cxlrd, hpa);
>  
> -	if (hpa < p->res->start || hpa > p->res->end) {
> +	if (!resource_contains_addr(p->res, hpa)) {
>  		dev_dbg(&cxlr->dev,
>  			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
>  		return ULLONG_MAX;
> @@ -3499,7 +3499,7 @@ u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
>  	xa_for_each(&endpoint->regions, index, iter) {
>  		struct cxl_region_params *p = &iter->region->params;
>  
> -		if (p->res->start <= spa && spa <= p->res->end) {
> +		if (resource_contains_addr(p->res, spa)) {
>  			if (!p->cache_size)
>  				return ~0ULL;
>  
> -- 
> 2.34.1
> 
