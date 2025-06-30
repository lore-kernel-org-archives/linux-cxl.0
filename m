Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE9225D1F7
	for <linux-cxl@vger.kernel.org>; Mon, 30 Jun 2025 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751312314; cv=fail; b=kuwSxNgm8QfDFpQ1vrCPN6mkS8mTiqhOfx0o1M1R5phTiEG7gL/HxhFdtAZnWC17RiheFqafu3nK/wg/txXSWkqPW2Obx/rKEmBBln4XBdbQOqm0CvMrC6caJyXTE1LDpMQhlq0lxa66kKo6+cJyMBUM9qHjFRQEiDsNVkiU8NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751312314; c=relaxed/simple;
	bh=Tw65hE92udOTVa0545MyeuMLtHkBwcjS4RtlK47Dmi8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kJeNeaWbOWppzYtU3hql0feyoa4+6T0vCIJbov8AqeArdZ6Sjss4npFG+NCpyXunhtC1KNW1eugvq/0Bpec3DmyhFEXdgTEhDOPBUuFSMvIVVDlXdEA6etMKhlrcV0oSolEtgodooNEDGBgJolMBGsb9bFa3tHIrORWux3Jv25U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A9UmRdle; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A9UmRdle"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751312313; x=1782848313;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Tw65hE92udOTVa0545MyeuMLtHkBwcjS4RtlK47Dmi8=;
  b=A9UmRdle5pgCOmd1JziVU4yLqGtsGMGuji4UW5bCiS+s3VZSn6gMPF1H
   MSjrKwKggV0q6t3DNTplFfi7TQ4Sm9Z7N4RqQxtevPtqEv7F52Hrgn3+Y
   yaIg9yAIyTSFMR6am9K2O4m/Ix3mXsRd/ga7MtHQ7m4XfOvUPWvCAuINR
   FzM/aEXxZ+XEr6V9tXPCCICGtAP0WLbGHDKh8rPO4/vT6iKNmYq8HBUEB
   879OJF8NpM0nbsw5giE8bDlTQYwGQwZ3CuevYHWCXRpahbusU0eSEP8BM
   aKrTvTP8tAM7e5gNEUu0Eq7WmiRTwLAfek4bWiniVjBpoIt66jZER6TFg
   g==;
X-CSE-ConnectionGUID: urvS3twiSpujpkjltpKLpg==
X-CSE-MsgGUID: hZLibb5GQBuqhGsV4XFv7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53513313"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="53513313"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 12:38:33 -0700
X-CSE-ConnectionGUID: OlHZoSS4T9+Be21Oa5vPDg==
X-CSE-MsgGUID: 4uPfDe4kRIqefXjed0t4CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="184572612"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 12:38:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 12:38:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 12:38:32 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.77)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 12:38:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKHenDiXXvTyaUQrNabvdY4SLiq74sk4dUbpaGFIIMvETzj/l7ekzhCRpenXJmHMXrjkG9CvF0+dmvrqKkQymBWZr+TpZllIpGVaQWMrmZU6G4o+UEoWCNuedjAa8/FGkAtjIB/Gqo11Kgn3/eXmAZwaV8eh1Q8w1n9grRd+O9JyC4qnH7id8TsiYXRxUymHJ+vZMmAUWhDytdSYsnKoUTz4cVSBiwGMr2s7neHZdU3+wwzmL8y+rF25QMw5rdQYhYJa3I21A6ar0oxrcAylnfmnWO2JEwywHkIvoM7Z6wQJTOrhTS29zGAoHomtlmbivn1fE0L6/fyY92nd6EFdIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YA+YDzeROHYeNjWdZMg8gkewkUmERCk58cXDdqsmfbE=;
 b=FDAGHq79SfC9/vfBVsnWugLFMgGoZ/FryU54njABtUHIDPJB2uqg4MqOntg7oy3F2CoQ6HTOKZrwcu9HZuHE5izbmFSLd6kGm2ox/iqky+uWWE+iS2tW0fKigIynK9TLaeoABgXm48f2H8TtddJqHZCV1DNftZvjkRmxT42bwI0c3OjvLRajrnFQL4jIEqVsMlZMde0LeAxl8yIABbBcAIU4lM03TnOuhS723OeMC/I99+ROPyj27Aa1Fw4bHK9rZJpLEASxz31S3LJawFMU6h+lUJV+t1M0d0W2pfImiOG1zisQZAADRRIx6Zqb5xPtsY9cbmN1M2hEhtkc6CsOVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA0PR11MB7933.namprd11.prod.outlook.com (2603:10b6:208:407::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 30 Jun
 2025 19:38:00 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Mon, 30 Jun 2025
 19:37:59 +0000
Date: Mon, 30 Jun 2025 12:37:55 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/core: Add locked variants of the poison inject
 and clear funcs
Message-ID: <aGLnk5F4oTi38Ub1@aschofie-mobl2.lan>
References: <cover.1750725512.git.alison.schofield@intel.com>
 <71f51bcc7d335c9f558441bb68f05f546230696a.1750725512.git.alison.schofield@intel.com>
 <20250624143822.00003256@huawei.com>
 <be43f6b8-907b-4476-a84a-0c7b801a3f94@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <be43f6b8-907b-4476-a84a-0c7b801a3f94@intel.com>
X-ClientProxiedBy: BYAPR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::16) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA0PR11MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: b46b4cb8-df68-4d97-322a-08ddb80d9ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e06soQxFeIOgNXxmiedjaY+ns/enpIXCLMjsN9mjRrhVkzuzeShKLPuUQAKE?=
 =?us-ascii?Q?RTluTgfoIElfNyf4gfLFG9jk6R7rQPJVnmvAk1nO4DtdJXc+jGw/9NlUuiCA?=
 =?us-ascii?Q?s2PwU8itSgegtjGsV0WqevxvOSNlVnSbSAOTduFHklbpj8iuOv0lQzWUx9xN?=
 =?us-ascii?Q?NjdHGIBY95Xa31+dn89LJpve0i/rJY1gQD0T5a+5ZowyzAHIxcQHsbxZBQlI?=
 =?us-ascii?Q?dHwukt2hhQdu1Qxf/QZg2vG73WgMD9yiDVEu+p56yI9Yv86m0mgh6W/D9fwK?=
 =?us-ascii?Q?8iesjDk1djem7kIcih9x5Bb0MB9Ew4RTuBeaaqcd5ou3r+iNOibzC+cHOFfh?=
 =?us-ascii?Q?BisQKDSnkjbL5ZIdGdvE0TdTOi41+qHqc6lixym0Kb7AIM4hF3KfTkmGRXXO?=
 =?us-ascii?Q?3oJO+dHKRCRxEC5NRE5wYH6oxb/ha3tzb/SWZSNBZ4Yt54BW3XCE80MWM3UQ?=
 =?us-ascii?Q?t2Yg+XdNyIuqbVDB7qp+yar3gnodtjHRzLKqDATmGvn+Vrgdop2OsllkHror?=
 =?us-ascii?Q?eroBK4LGWVxdaBmR1yqOJ2xjACw7CEXgYt4oIhK3gwETR7yMcozy7/iVPO2P?=
 =?us-ascii?Q?Z2duKlfhvKTNplokfpjqHRQHLFwt7uvWi0Jg7oTI+hPNvDbGwYdI4iwPYtf8?=
 =?us-ascii?Q?ZyKg63yPULhfteyFC29IS5+I1WHv0ytqAoAVLo5XRoj59XEsilIOJlDSDuan?=
 =?us-ascii?Q?Jsb6UW40Ez2iu/Jd90MdQpp0OIiLLfK8G5Z4M7sZ+QXPjAdd8Yp5ES81QLdc?=
 =?us-ascii?Q?ypfTCzM0hNF2e2u5DJxdywgK14YOdnqHDZhJ+Fiu5afuCZ0ZKkDynCS7zeNX?=
 =?us-ascii?Q?aObY/YiB+L39pDCd2Yz9QMJ9HvnShSDtAjwFoXtKJIiqvcPyEdazz/ueNt3Z?=
 =?us-ascii?Q?Blwnfbq1z6KpzpIDgKYy0WiIBsREVh9f/Kxf3GlERud/feu1wvzO3uw82Crz?=
 =?us-ascii?Q?IMcsuacrJUxcFAWRsDxvZMkXeS4d+OnBQD7DIN2WZ5bytRDllVYIbYk35KnH?=
 =?us-ascii?Q?1TV3YKECF6QY1rovTarNTho1rOuA90WBNciDeLXa3mlWu3uIyJfr3hyHWDsX?=
 =?us-ascii?Q?xFU7gHnIAqy5v+8sOExi/gF5ANn/W3xACz3x5K4WCYu3jj6X56EkDU8UA4hF?=
 =?us-ascii?Q?fZVTzOUBFa/JAX78OPnjvB0jouPq9DnHPP7qbuDjqbLafzHaThZi1SpfhwOJ?=
 =?us-ascii?Q?E2p246sLfjiulzkK7v54agPjRqa6PecfLqxkHfdjXC2HRu6VJobHEiS3GcRH?=
 =?us-ascii?Q?JRzKlQPpzNKkV7xPyHt7HyWTMS9j4QqYjCFMYlEiEOgeKTiEN1QPc8UVdJpJ?=
 =?us-ascii?Q?HJYmMMBpTzT3sKhA6VfsUAIxXLg/NH1Rqj6RFEVJfYrUYHmXnDBIBHJ5XzZx?=
 =?us-ascii?Q?0JGwXtOaPkT+dxKIGRU8P3sCIsfXMDayN6MViH69c4fUj3E/KVsYlOS7F+cC?=
 =?us-ascii?Q?DkbEL7w9v4E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZlGdNkWDcNGfNcTeI85GZOnhJ+uSU6D5dem5CPSfOtqIFxkLHilYWOpaAcZI?=
 =?us-ascii?Q?ulUim1cho0UayWEeEG0uu5XWjTM5S/NAxrDJMr5oIvAppDAWvVvVea4ACGp1?=
 =?us-ascii?Q?ZXGWkHGIxqopOVPl6fuZ0wZ6+KHfi7Ai5iePsf8arDyIucCKTdR0i4hwxw9f?=
 =?us-ascii?Q?T8QJ6Uf6HLvUX/6ad8/JRslQp2YquCaLBVa8hhf4VlANPl4w/wXKn6CJqkjA?=
 =?us-ascii?Q?ZKmA5227pj0pOMsazLem61LNKtukedTgHVPjBscw7wCV9spSxkmwpv1IQ822?=
 =?us-ascii?Q?rltCN3v/p2gmy5VDvQwDjsZdm6UaJCkXP/F2hocvPpr17oKKvXgRhh3bQDWx?=
 =?us-ascii?Q?vuEV6Tr31mBFwHJW99Ztwm2YXp1E/w++TdlZCJNehD1wRBAjOWqf+JEi8r1Y?=
 =?us-ascii?Q?wpEmx9gvJNrKH2BpB5El0oMbmzVG6g5qNSDGjDV7P3V2LXZWqvLqDMfJ5ZqF?=
 =?us-ascii?Q?TwxuGPpYEG4ppC/p1nGXRW/OBCoV+Klauub5tqRadbutXKELpa4A2ERfa2Br?=
 =?us-ascii?Q?uLqjiaNycILlDdW2Sq/a7SA7f9tuFVD3NiYXJzn+5aYZ/USEicflGe/s1gg+?=
 =?us-ascii?Q?RUISKIot1m5L1DTg0DPsy8C4CQcL/DF6mbbkkVq56j/NNTlF6x0NkCUpvZsS?=
 =?us-ascii?Q?Ak6+64rHqk1GQGDCAparPSvBkc2evxn2lSeiWsp0aaAuyVvSHX04a5uronI6?=
 =?us-ascii?Q?kuLu2UHiOtG1fQFkuZtrJI/2JnhbVJmiowoVV6KIHmH71B/mPjeEKvH4ByUy?=
 =?us-ascii?Q?Y78uYCY6+kdnXXtF6CwtbIJupemUrW/BnPt6SI4UeAYOKIU3ZmaW69C6UMyd?=
 =?us-ascii?Q?5jqmm2Qg9tEwdVhq1l7U/TI7Z+F/NPtxWDnnAiUnXjI52EGTAG1ZEpUGWtJC?=
 =?us-ascii?Q?UDUDryGBpMsNDSlL4fXam9we3T/mdzCl3uVYtPYjuSwEb8NsuM5pID4QMDlN?=
 =?us-ascii?Q?1Haz0fBxBGIQLzetM+5NJ0JNyGNOXxdUVpRNZo6EazqIMTg+b4loRqal6sC7?=
 =?us-ascii?Q?z4G/pcdYu8tLWnrxlIctKr52lWH6oP6y870sqzj/aRVO6Yk4gz7BnQHc04ZF?=
 =?us-ascii?Q?fyRJO2OptGXPe4fmzdSTx33wvnM26GYYEzz65nj6MzR0CK1vOSQEVX7TsKcw?=
 =?us-ascii?Q?Tpl7eueeEhA3SVecIE6N4F6Y6nPNQMVdz+DIMm6qwSCSZFFpSPuNANUjL5GF?=
 =?us-ascii?Q?MI3SbOyTN7/O1vxeTJUWS0oSIMLyHek/5yrStiidBXj1s+VR4x1Avfy3T0du?=
 =?us-ascii?Q?0bpZulut1WtI8qWXzvwc14m6iv7KdmZ1Gvrb63XkDzuo2UsgJ1aQAzeVHcRP?=
 =?us-ascii?Q?pTrdawcTaRorEyvUt5rHBO9L+w/wfqeWow3i9FSF2E882Fm9FYUJLikhjMPR?=
 =?us-ascii?Q?g1pXxl6bxBwrYdgFTlKsMtBgzTUE/aGPHUQa8JbyCWUVYbtAlMzFQvkgGKLb?=
 =?us-ascii?Q?F5SQU70xwVDlxzTeButmmk/ikUM856fB1BPhIFNVWz2A79CAQZBPxYW1xgkW?=
 =?us-ascii?Q?CaTW8ek6bJPJRifbH6D/ayJGN172Q+ZTbQIoVG29u359dPlu1KNCsI+0h+Zt?=
 =?us-ascii?Q?bfh+qFtGJsNLjuViOTdADWCILL782R08SAlGx19rq39RgPjg1ZQKK3g+k0ay?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b46b4cb8-df68-4d97-322a-08ddb80d9ec5
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 19:37:59.5531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pttlPTVjDOic5m/wvBDKkCLbgLAKOT/sEnMxWuZHM54cI/opsLIZ5BJBQ9WhQ6nJlnVglWA/gnsx1JLd6v9i+yfvc6lQIg3WWYILv1E8moc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7933
X-OriginatorOrg: intel.com

On Wed, Jun 25, 2025 at 03:15:45PM -0700, Dave Jiang wrote:
> 
> 
> On 6/24/25 6:38 AM, Jonathan Cameron wrote:
> > On Mon, 23 Jun 2025 17:53:34 -0700
> > alison.schofield@intel.com wrote:
> > 
> >> From: Alison Schofield <alison.schofield@intel.com>
> >>
> >> The core functions that validate and send inject and clear commands
> >> to the memdev devices require holding both the dpa_rwsem and the
> >> region_rwsem.
> >>
> >> In preparation for another caller of these functions that must hold
> >> the locks upon entry, split the work into a locked and unlocked pair.
> >>
> >> Consideration was given to moving the locking to both callers,
> >> however, the existing caller is not in the core (mem.c) and cannot
> >> access the locks.
> >>
> >> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > 
> > This will clash with Dan's ACQUIRE() set.  Up to Dave on how
> > to handle that but my gut feeling is that if we want to queue much
> > else this cycle and that we should ask for patches on top of the
> > ACQUIRE() series.  The risk being that gets some later push back.
> 
> I think this patch may simplify more with ACQUIRE() if Dan hasn't already refactored the function. We can wait for a rev based off of that given there's an immutable branch with the ACQUIRE() patch on cxl.git already.
> 
> DJ

rebase coming soon in v2 ;)


