Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D689837169;
	Mon, 20 May 2024 23:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716246700; cv=fail; b=ZKzQlNigoM1JXIgBoVY85beW5Zj9hBTpbOkMYFzuZA8nE9a5I+l6bNEuaKMjGr0BVy6ASAhVglhe0OMgMFw6zRfZi9+yrS4sTEfzVdeGMoY5AKBPJXqXzbgxSRywhrKBPs9zl7g7Vr1OikAUTujRi7IFDwKTwzlvxrev61mdXB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716246700; c=relaxed/simple;
	bh=rd8nzPe55En3tJA3LSWGxSDmkBA3eQqnUFaXQsFZ7AA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bBYbzHDL8WdPfpBAKbcy47eC88KMSBQDdPntaUlAxP8BYupDabsXDFRhabHOpbv5IMcalErUNLc7TxUz0j3Yo5AsS5roijgugyY9iXGtCHAn3Iw5koctkWo59ovyfAkqJx3LaBVewoXnN/fDZ+UDG+u9PkrTANZ79pD6pbWRa+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iowDkZI/; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iowDkZI/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716246699; x=1747782699;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rd8nzPe55En3tJA3LSWGxSDmkBA3eQqnUFaXQsFZ7AA=;
  b=iowDkZI/b9/tO14yfDAsjrEykNDPauYKNL1SnqPiUTj8yagva+0TusKt
   t+D+dc/n0W5zD+H7Jjl6YoS4SO8lgZgZfbDLvszA/pkSDJ3wVx83y4kXV
   skcI7aGSBYIiPdcJxu9Bt4bLPnKANErLEHranSQC5eZP2Omfzx1NwPc/r
   KssKnOIcDOHvFpdl5ZPmiFfZoHja4+hY1pUqfhfEFLAtFBRQCR/PVLtoi
   V6PQEi7a8WxVnjE1PWLNvFeACKiGVf+IkR4Xkf2xKDRpdjBy2yxlxn9ov
   Z81kO39EupukTEwbgSvwDJdpcQyZAra9Bv71ziSYUrQ6408eK1MrlMN7P
   A==;
X-CSE-ConnectionGUID: Z2/63CUSR3ySDRpXQdJwqg==
X-CSE-MsgGUID: GToyo+iwRYeFZ4/iPqMU0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12203361"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12203361"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 16:11:37 -0700
X-CSE-ConnectionGUID: p4GyqaGXTNq4SCmoO3jk0A==
X-CSE-MsgGUID: 9x4g+AGqRZ+rMMyUbhsC0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32599740"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 May 2024 16:11:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 16:11:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 16:11:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 20 May 2024 16:11:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 16:11:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9F0Iz9J1rQoHGhsndZ5TyU6EYvuXGirwXMHmcrOV8786c5VDRvPisgpTJLNW84xJG/l/x3uw4aQRPkp71DygDtvXzCB0EXwXui/fpadsVLJ1w8xFGuSBxWCIGFcghhIkJNf7ZT6mdjZ7dkuESD8Olyf3RaB8bYH7UU1CN7bdi6OhF4LC2Wh8R2Lcb+NrHBunEAh3yB+JwiQ56RQLfnB8KgN7641iOiWhIR2x1lOAgYL4w6tzS41m/R6lT7u0j7B+X9qMovzFZndbuYdh0w7K8pdKczygG7hPlI3O1Z1AP3HpeMR3PD0luv1QHpJyZ8Fz6WYMESYw66SFnz0HaCgCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcY8ocJp7CsRq7N1JlREzc7fe325LS9RT9TV6aWMvY4=;
 b=ITrqS4G8AJqSo5HDvkY45hTzdOz/PBg7T/IfHslhv30k6EFSKKKzLkyroxl7Ms99auFYdCViZl9Lc8HJEUazMjyKcWIXKx8qR/7t5m4FTBTt2+KSBooGMLs1SwZjSyga2WTrJxw8wepL8DdNQj83+2Oso2C/7Ss3vB1wmkNvkve36q1WtSI00CIplxVSedIniLgHF+fouzvh0c+bEiRuKugmy8joMBdL3jpy0oZrRakUWoQw5DRj28h20/nJvAu30Z/kOjky962Amk7SGny8OsisyvuV0WJ9gRMTfxKLDWNQ9MnOd8hAvVG6orV/Au7Ygl/P7HqCU2xLbgBU+PXROQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 20 May
 2024 23:11:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 23:11:34 +0000
Date: Mon, 20 May 2024 16:11:32 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH v3] cxl/events: Use a common struct for DRAM and General
 Media events
Message-ID: <664bd8a41ca0f_a028294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240518113317.3683718-1-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240518113317.3683718-1-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0064.namprd04.prod.outlook.com
 (2603:10b6:303:6b::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4771:EE_
X-MS-Office365-Filtering-Correlation-Id: b2bfe72d-ab7e-4976-a8d6-08dc79223150
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007|921011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NxWUI/6wGz6UXJK3gEAVK76JVmFIOO8fH19sa4P6NPQjKdBNy2X+vTKFVD5Q?=
 =?us-ascii?Q?euXbp1NU/PJJmFqR5klVZku7AhkMqLkPkeuD0BGHd5l5RHWW6lzccJAnxTCk?=
 =?us-ascii?Q?F91KOvlyXVGbENR8tvTJHVNIeAIJoOsLvbNWX5YDOZ8GKuWteq8hLKFhwJir?=
 =?us-ascii?Q?opvwAc6Ry6ytR7J356gLWUZkgGlfKVqTfqAUS2McJuaskPWFwHQpmhuFAXXe?=
 =?us-ascii?Q?96h6ugSwyjig5bJFwnQ42ML/5i2XQIWh4Pc9VGcnrMrBhKi4/QB8bfV/qcGG?=
 =?us-ascii?Q?QWP1r0nv3HO+gyzL3Iy3TX3XIAvBRDjohkrBz5qbUibbQgJcBcoDg/ZU6xb8?=
 =?us-ascii?Q?tMHgCDkAuu1gRzcKG2VSE0tSPB1nDaYfunRziTxqz1OCskA5JcIwGfynnDoi?=
 =?us-ascii?Q?LyXJGMR/VVdbCZqTDVSBpgUH9/4oSZYaDXpeQkHvoqMLDM6RiMzAiXPxNoJ4?=
 =?us-ascii?Q?KfMGoNvgivvFnlM2GEM+NcGLJRuN0OZAFm6RTMnnG0ULdLrw/lZTy3Fs4SDb?=
 =?us-ascii?Q?bxnf+BzCAcSTsHnMxE4S55+c/TdpQv7eIcmVD3s34z66B2N95WmvQTjFiaNQ?=
 =?us-ascii?Q?RsOFzT66Q8JAP3w2cPqPt/WH7/3QuSRQBVCynpTY9gJczvQn4iuAEx/l8Dds?=
 =?us-ascii?Q?xcvVheuJUPBzQDDOx7ry/hjdzAcIS3srLHBB2yO+NWCVT48PDXPhiL0bZBny?=
 =?us-ascii?Q?6EEHbCkl6uZJ9t4eZrBD7pkllxQgElL3u2AQP20I/mo+PMmEb/ZlU1vtjx4K?=
 =?us-ascii?Q?tadEGLv6umYLozUHHZv7fKtFYnBtoV7g23yrIdnTP7/Y7A7Wz1H7nycFWKro?=
 =?us-ascii?Q?7NBP6JYS5IDCkmqR1sKmJ6xToasRe4Wht8mplkMADZ4IuomJG0k+dhc9/Xam?=
 =?us-ascii?Q?M8OY8VRGCcaHq4Gsb8sFsdM3RSOxsKFvkICluXYaZLtjfeQ+oS5tP7dJqmwC?=
 =?us-ascii?Q?t3UMQItTcvVYLZQDUlMwpDZY2G7xGhm22QLr86Pd/ckADeXTKOf8Pp6iPZMi?=
 =?us-ascii?Q?Qh+C5KndDlfAkLI2De2azGW8NtYaX320Lz0RAqwvuGF4gExw1lpcbIeV5UDh?=
 =?us-ascii?Q?s9May52vz35Ihw8GF3Dirj35oCk+E/b/gg+8yKoGAeerHA8sNiqFK/P9b4/F?=
 =?us-ascii?Q?OcN3Xwc/AAF4yBW1hpSphCLBi+albCbQV6QQGzr5mhh+yD4Y4ERMUlfu6r83?=
 =?us-ascii?Q?Nq53jIhG14u8KrIIWbrftW1utW4H0FaVaIRUm9Ug73UpF7Otfj+9eLxhfY1Y?=
 =?us-ascii?Q?+GJ8TFCpQBOXx49u7Av/ojdeG9mpth1+vHH+KJMX8g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8LWLNK+418O6QP/1rzv+Dl5OkYEh6DAMfq9XbU2LO0gcY8nJ+D6viEYET9GJ?=
 =?us-ascii?Q?SVKTnoPkojC6pFXziDqD4yCAWZW0ES9NEdTSwDZ6kOHnyiWH+OsDaSvtzMyN?=
 =?us-ascii?Q?kSgBRBouiLs9s29M38L4dMYHxKUdvDO2fzJ5PBIWE25/EYJcqMHa5Pz66t3F?=
 =?us-ascii?Q?0ZlelRRThGBOTlWID7kNfztfGm1THuze9tXLF/dATculktvvukfYZK3U+PCo?=
 =?us-ascii?Q?Xi5LRmcwqlwipMbo/YDRiH35lq8ZURTA2ZY9ZQKh+AHhswxBkHPF9QXzmpGi?=
 =?us-ascii?Q?vOW8PXs3LwiDSOnkgn44Icy0LlYVQ00IKUiyLTDTF4QNAMV+JuuQbG0Bs2hq?=
 =?us-ascii?Q?Irak37m7Zzxkjgt8B066HYs9AVsPPauj51CW+VMiSdzQwL9uMc8mnow+uiq6?=
 =?us-ascii?Q?+cXXbSEO1OLo6kJpTH0M3b7VD/z/9+2foFh6oK9+YjGUxo3Y2PeZMjMep4hs?=
 =?us-ascii?Q?nXIvoe5OscZ34JkLzvJBIrCXzqD8j5g8UmSqQN493zJck+7Z2tzXJaafL5o7?=
 =?us-ascii?Q?D0JigiYQsWQhw9DC/mo+lVWeVtG67raMGpsgLH9ZOK1aZjC8MZJUQ/k8/L5+?=
 =?us-ascii?Q?f2zVFoccHtMVJUl5cEvyHSW9vWhG7PkYt9obuu8Fc0kJbUchVAWKtW+Rw64V?=
 =?us-ascii?Q?jXvYSEU940Mgd/kyDUvMFN+F8TYmIc50F70Rm9IGQ6dTumSEGBOCbnng9Udn?=
 =?us-ascii?Q?rGs/J7tOFt5+xjF6Vi8xf6zx8YyDBISFystNA6w9SvKf/5PUCLchjz8+DVaU?=
 =?us-ascii?Q?SxVORaIf33ZzELus2Yoe6wqtx7Qo/6BgT4baxugCPs0ugG2g3DwV93BKG6uP?=
 =?us-ascii?Q?WBQ2zftaDrZewZhKN9F5UYHdMyushTze14pBEKXrSHMJsHBYgSo8iEDmSSbD?=
 =?us-ascii?Q?sTeZjMjt9DQ/M3CDCZ9oM4NFtIS7M69FJqro/gcHjFk/j8T++72cGq49G7iw?=
 =?us-ascii?Q?n2NkFxvKil5BdNniZD1ib2BCK3KCDq74zz0tL54g7hXNDKRKoBEpodi8a2Y7?=
 =?us-ascii?Q?yTDtoxfCeUdbcV91rWioAi2uoh3c8jKHgLcnyPoK39rBLm9pmOtEYaTbPoAs?=
 =?us-ascii?Q?LB++2nx8FBYMvy29F3EaPw43Onp+5lZ2ONY23MJ+VhWYiaPHOodHfXokHb3g?=
 =?us-ascii?Q?zCzTOdm2i5zQhZ66uoN48G9wBI+4jCgWotpxHpwIaDBxt6jbiGNo98g0cwVt?=
 =?us-ascii?Q?ObxIsP1YLro1E+FQJtM1ViRrIk4pQ6eIOe5Jgt4iF5BUvsL7/svWuLoa27ei?=
 =?us-ascii?Q?AykC9kFcFZCAbsHkSDIsaBkUOD5ILyrXNlVzwdMKvSxAlhclnPtwKEdeIYND?=
 =?us-ascii?Q?JNMJVcuA6rGfX8SgOQ1PDSWGoGfXgJRr2HQp3TXGss8wk2eVCaX85jJjDPNw?=
 =?us-ascii?Q?JEn7DoLuHi6eqoQ6ILy3n7TSRi8O+682pbw+yu3zcO/BgAAk1YriTJ8GTkPb?=
 =?us-ascii?Q?nY7XY7pBCiFKLlhPi9rDLqEnCNTeT0hMqhh3N29XB3VrmihTmCVH364hsmZP?=
 =?us-ascii?Q?ZsaYVoocHJFlGFwauPYbS68RnriF19zzTBmRFAJVtVeltCCKgrJOBcQajOLu?=
 =?us-ascii?Q?9cra40nAsps3rshf0f+tTK1i/S8c558suHCheG8sO4u1mt7mMQYKLvbNWOgQ?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bfe72d-ab7e-4976-a8d6-08dc79223150
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 23:11:34.5170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeF+jvZRgwomd6PreVhX0VwBGqIY2yRfulcsRZ1L3dTfxKR6oTf4XL0Lp6802BO3tHCBKW5FdRMShDUa7Ky6lqUYKKNvGCaxOp4jmIMjRAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4771
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> cxl_event_common was an unfortunate naming choice and caused confusion with
> the existing Common Event Record. Furthermore, its fields didn't map all
> the common information between DRAM and General Media Events.
> 
> Remove cxl_event_common and introduce cxl_event_media_hdr to record common
> information between DRAM and General Media events.
> 
> cxl_event_media_hdr, which is embedded in both cxl_event_gen_media and
> cxl_event_dram, leverages the commonalities between the two events to
> simplify their respective handling.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
> 
> - Changes for v3 -
> 
> 	- Rework the layout of cxl_event_dram and cxl_event_gen_media
> 	  to make a simpler change (Dan)
> 	- Remove a "Fixes" tag (Dan)
> 	- Don't use unnecessary struct_group[_tagged] (Jonathan, Ira)
> 	- Rewrite end extend the commit message
> 
> - Link to v2 -
> 
> 	https://lore.kernel.org/linux-cxl/20240516102116.3512377-1-fabio.m.de.francesco@linux.intel.com/
> 
> 
>  drivers/cxl/core/mbox.c      |  2 +-
>  drivers/cxl/core/trace.h     | 32 ++++++++++++++---------------
>  include/linux/cxl-event.h    | 40 +++++++++++++-----------------------
>  tools/testing/cxl/test/mem.c | 30 +++++++++++++--------------
>  4 files changed, 46 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2626f3fff201..a08f050cc1ca 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -875,7 +875,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  		guard(rwsem_read)(&cxl_region_rwsem);
>  		guard(rwsem_read)(&cxl_dpa_rwsem);
>  
> -		dpa = le64_to_cpu(evt->common.phys_addr) & CXL_DPA_MASK;
> +		dpa = le64_to_cpu(evt->media_hdr.phys_addr) & CXL_DPA_MASK;
>  		cxlr = cxl_dpa_to_region(cxlmd, dpa);
>  		if (cxlr)
>  			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 07a0394b1d99..5a76f94accf4 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -340,23 +340,23 @@ TRACE_EVENT(cxl_general_media,
[..]

Changes look good.

> @@ -440,19 +440,19 @@ TRACE_EVENT(cxl_dram,
[..]

Looks good.

[..]
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 6584443144de..63b71541d399 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -384,19 +384,19 @@ struct cxl_test_gen_media {
>  struct cxl_test_gen_media gen_media = {
>  	.id = CXL_EVENT_GEN_MEDIA_UUID,
>  	.rec = {
> -		.hdr = {
> +		.media_hdr.hdr = {
>  			.length = sizeof(struct cxl_test_gen_media),
>  			.flags[0] = CXL_EVENT_RECORD_FLAG_PERMANENT,
>  			/* .handle = Set dynamically */
>  			.related_handle = cpu_to_le16(0),
>  		},
> -		.phys_addr = cpu_to_le64(0x2000),
> -		.descriptor = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
> -		.type = CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
> -		.transaction_type = CXL_GMER_TRANS_HOST_WRITE,
> +		.media_hdr.phys_addr = cpu_to_le64(0x2000),
> +		.media_hdr.descriptor = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
> +		.media_hdr.type = CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
> +		.media_hdr.transaction_type = CXL_GMER_TRANS_HOST_WRITE,
>  		/* .validity_flags = <set below> */
> -		.channel = 1,
> -		.rank = 30
> +		.media_hdr.channel = 1,
> +		.media_hdr.rank = 30

This looks awkward, I would have expected a conversion like:

@@ -384,19 +384,21 @@ struct cxl_test_gen_media {
 struct cxl_test_gen_media gen_media = {
        .id = CXL_EVENT_GEN_MEDIA_UUID,
        .rec = {
-               .hdr = {
-                       .length = sizeof(struct cxl_test_gen_media),
-                       .flags[0] = CXL_EVENT_RECORD_FLAG_PERMANENT,
-                       /* .handle = Set dynamically */
-                       .related_handle = cpu_to_le16(0),
+               .media_hdr = {
+                       .hdr = {
+                               .length = sizeof(struct cxl_test_gen_media),
+                               .flags[0] = CXL_EVENT_RECORD_FLAG_PERMANENT,
+                               /* .handle = Set dynamically */
+                               .related_handle = cpu_to_le16(0),
+                       },
+                       .phys_addr = cpu_to_le64(0x2000),
+                       .descriptor = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
+                       .type = CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
+                       .transaction_type = CXL_GMER_TRANS_HOST_WRITE,
+                       /* .validity_flags = <set below> */
+                       .channel = 1,
+                       .rank = 30
                },
-               .phys_addr = cpu_to_le64(0x2000),
-               .descriptor = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
-               .type = CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
-               .transaction_type = CXL_GMER_TRANS_HOST_WRITE,
-               /* .validity_flags = <set below> */
-               .channel = 1,
-               .rank = 30
        },
 };



>  	},
>  };
>  
> @@ -408,18 +408,18 @@ struct cxl_test_dram {
>  struct cxl_test_dram dram = {
>  	.id = CXL_EVENT_DRAM_UUID,
>  	.rec = {
> -		.hdr = {
> +		.media_hdr.hdr = {

Same comment as above, just scope the declarations with out extra
de-references.
