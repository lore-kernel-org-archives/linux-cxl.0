Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870542FBDF5
	for <linux-cxl@vger.kernel.org>; Thu,  4 Dec 2025 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764869229; cv=fail; b=AABWZqjMeZjql/lPW0eVOZiVm+py6pYY1nHfWUEquKsd2hmbGZf25uwO57jpt0ghbU/dFiVtWMQbtgu/8toA5PYKqNNPTWWixoXw3aGIPoNZXXapVzEt0p96WNour7I1WEuDLzjShh3vrc8WbZ4dt8mJ63kLSel0FNpc94jlD3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764869229; c=relaxed/simple;
	bh=YCMzz6SnFp+VMwUhcs3LSCwifokKbkRyk9mXfuF6thU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZEjswKI138udnO+VpcZ+iFj2aFDsr6FX0n+2HAQNMBVXHFiqyhER8getEBqCVpLbaOjgYAUzDCqMgEnpb69boaU0pHf7tHldseYcfs5RQunuTsrH+NTeUR0ofqWssiAGSlYiVqtMZQsySakX/XggAu9t6qjEQ4WtxmnmeTQU8V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzwvOo9A; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzwvOo9A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764869227; x=1796405227;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YCMzz6SnFp+VMwUhcs3LSCwifokKbkRyk9mXfuF6thU=;
  b=dzwvOo9AuXIRkBKtoFqGKTT+XflyWT08KYGA6QMdVgzDZlTaaDIIfDiO
   cYGWcDadgBCChkVPiMmLWLKrRjDHD6gM1Qxwhy98vn7MyElcA5BIc8zaS
   THFt13awiVXgrXRYspjh2C+dyFyg0Koy8LcfJaXw8hGKLGasX7e0vgtft
   Zb/o7EJBdX7epRR4ZUp0l68oTIVcDWDAkaiOvKeXiSBS1lCnGyzKTUyn1
   t9zjZWGe8Zbbo2HTPRXFUlg8HALVBOVLsYllepLxxypQ3TDfv2BZXVNlm
   hwVS8U7NMGxfDVb/iSIKP1rnqFOwpCxAO54t7HM/kss/wxsSCtPghD5Di
   Q==;
X-CSE-ConnectionGUID: O08az/u8Q+Ob92+dpBuybw==
X-CSE-MsgGUID: qH0kCHyeS9KQUm0NZqhwTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="77219387"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="77219387"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 09:27:06 -0800
X-CSE-ConnectionGUID: rfZD4sSvRVWkYe2xdM6/0g==
X-CSE-MsgGUID: rRjV1BpCR5y1EX+58hu5Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="226017966"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 09:27:05 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 09:27:04 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 09:27:04 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 09:27:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WonxyelJe8nznU0RKsI0UsK5AmV/mJwwX87B6Ah31Tr+72Ag3kKLNQ5TXs7bTLKiChzmFFW/+niKFqw11pzz6X3WhEVWCgQkXk27an2mGUyvMLO9QTZ2wG7XfT+U36OJMvqHmvEWuVsVxP9AEwy53sGKwLAywXvnijoZSvMkSBqJKRJ99+Z2u359Ua38O1aX9P2GjAelGMWdJInIrE50PHjoV2bcdaosa5999kL7E32uyMEhLGm6srD2bMYXUaUgoaW0PseEP7JH6wNFSrzrvJxaHeOaJ0bupmDe4eJ0+eHwasi9canZGJSWMLdAHvUpZBo4+YGo1oJcng0iiE6LiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IW044bN7eteOlPh0toAQS9TsNyxITCVzya5KwWWPoQQ=;
 b=Ng85V6TgCYrq9oK0QfZDDZ+ItrAwzOo6RZOkt/K/2fMvYxbJ+gGHeOsffXCB3VokXBzR2XVwCfK3/lxlz3UKD6xqAxoI7oLivm8OmsHdm2DAwYf50XtJBpoqxZ2tiOm2UogJpL7LrDjdbGjtQiyaBuD9vDGQf27yDouFjGNJhQLVuJkPQv8kFBpOB4wuurIwryU8mad4GMjp6UB3WHqMRMI9VwXXZVL+3UhQvgBDtG4fC5ILSIwiIqvd0AYvpDopNHLAo4BqDzDTxajCMFufEkDdg6vrRH1ZKxovpu9XvHJVDZbUmsitL6ze1yrt6gGOHyGe9e19AZUb1H+U589uyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by MW4PR11MB6885.namprd11.prod.outlook.com
 (2603:10b6:303:21b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 4 Dec
 2025 17:27:01 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 17:27:01 +0000
Date: Thu, 4 Dec 2025 11:29:39 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: <anisa.su887@gmail.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
CC: <nifan.cxl@gmail.com>, <dongjoo.seo1@samsung.com>, Fan Ni
	<fan.ni@samsung.com>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [RFC PATCH 2/3] dax/cxl: add existing dc extents when probing
 dax region
Message-ID: <6931c5033feea_4301010039@iweiny-mobl.notmuch>
References: <20251203203540.1091827-1-anisa.su887@gmail.com>
 <20251203203540.1091827-3-anisa.su887@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251203203540.1091827-3-anisa.su887@gmail.com>
X-ClientProxiedBy: BYAPR01CA0047.prod.exchangelabs.com (2603:10b6:a03:94::24)
 To PH3PPF9E162731D.namprd11.prod.outlook.com (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|MW4PR11MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: a40fcc66-4b3e-4075-156a-08de335a55ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C79TNMWptjoUVYEqic6xIBt0pwQOAfcJSSLMMoc/i640AnvlpKQg3/gRRAZa?=
 =?us-ascii?Q?+xju7PylaHcUA1Q6lrb+6MUtJ2aYgkERwu9uIR6CLUjUogxddQTHeK7fleKo?=
 =?us-ascii?Q?8qm48ecTFCkjsBfWllco+uvfR5K6snXZHy1tS/cZX0112azvqKNZLeIsraaP?=
 =?us-ascii?Q?DOy+Sixw/CVtFDcbBK0EbHgzpXWmHdI40DpIe7qPvEZ0KxoNiLMuEafXUx/w?=
 =?us-ascii?Q?l9zasEtk+QTIe7fbTvHRVTl+uP/Kpji7aRT6l7tLBGvEUNYmPAq3/m74OKU8?=
 =?us-ascii?Q?l5AA1EpX8SLRNshypNvF6wUgxN4W1qK98Qvj/eUlGtdawLfNwd4Oc1TJzTcT?=
 =?us-ascii?Q?CWe/DToxArQKs5Mm8pK7ensz/ps0mjab/Ed2DRlMPRYR6F/BwVozVJCDi/g3?=
 =?us-ascii?Q?MTTbHVJnphZkTtdcQJGoXN0CgDseQ26vAdJjaYl8kHZGRTfMRWu0BoXXEDSR?=
 =?us-ascii?Q?VX1FFssxutiwyfpp0fb2AbxebnEhdr42qLWEcgJYqQGrcVErSXgcYRC7lNp/?=
 =?us-ascii?Q?/B9YYyU8hs2lzsbXeL75cihfbo7s7kl3hUp2hgDhTZiYHB0D5sySXu/DRMGy?=
 =?us-ascii?Q?d5R32F/dQbW6xVe/ASx4gDksf6KZayUDPqB9Qm849hTPRQBZjayMHqPmGxIc?=
 =?us-ascii?Q?9iH2W5f6GgpW4LMYg6XAvETTuRsxc3eJBtTJRWpPTQB+FBIuJi/ycHdBAVu7?=
 =?us-ascii?Q?Ssp8O0WYnv6qBo8QMuyh6YoEQgzvmhJ3eJbF881bl5+/NgryU5abHMQzfLyI?=
 =?us-ascii?Q?2AtodC1WpzDSnstRcUDTIVPPx4NyUN/RxZMyN2AeEen47f3+YaAMhJZ5H+5l?=
 =?us-ascii?Q?ik099sixanSjoJu7fyUrZsOe1RBMDzPlsxDQvAZYCxUvNXUEqSxX3MDNAoeP?=
 =?us-ascii?Q?vmn+9jvHPYtbRQOdYkDsMI7+jzz0h6K7jQtnEGTkYrB5f5/kJzpJBu0YAYVR?=
 =?us-ascii?Q?K38l6BYjaNAaihLlPBIMOuV25lLQlcLPcwHv7IX3cWoAP3zIjr1CQehSXmdp?=
 =?us-ascii?Q?PTy4+OmJoSyF340SR2H6NyavW8PzPY6N/u/ZaTGbp2dpfKLe2Ya0kC8yKKla?=
 =?us-ascii?Q?xrwVstoU9DncMaJXvv0MX4NysFxXMwYeLOpK89ZYVp7IBZzotyQ3zVhMJx13?=
 =?us-ascii?Q?mKbxZovDZrkBhiOf/gTueD8WCdtJBxpDBQzarD13wscsHOkA2A66bFb5/8ND?=
 =?us-ascii?Q?VD6unRUyn7Ai/gS19LdVkc4BcS+68z7ONzIMhQUDCgW6Do/MRr9pGAsTznB6?=
 =?us-ascii?Q?SyVUS661BdJgpl7/+ek995XZrVFU4GYssSXxXOa8T4A0IbsoCCJq14BELt3G?=
 =?us-ascii?Q?GgwS5+WvO4AtudZwjxpaPpoBkqvNeNbUH63OTgFJeprApfasT59RjA04fGIB?=
 =?us-ascii?Q?3L25YN8MAApFU8oex0VcJRoSlH3tBVy/vuuZXh+ALe12drR4+GpKqkyhBVXy?=
 =?us-ascii?Q?EybzGkiASsNnelurtrQlUhYjhVZEz7UG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WxiDEToeCRB0//1Qezx+BAfBozf/9giyhSw9HkCb7OGJMBvBKiSwuj4w+YQT?=
 =?us-ascii?Q?EErcjNgabKs35teVEWXG2Yg6clOcpY+BcaH42xztms7IIC6X3ItK8t12N+3q?=
 =?us-ascii?Q?oNqib/kd0vfVkALixBUNUU7Dt3hN9ejxjtycCJ6IJAYzt+D0C25mpcMkwW/1?=
 =?us-ascii?Q?GUbMx9KWGeBvGIoCCj1RmTe2LVeUjEH3de9MnzOmyea3VyLOx/AkZwcnG3xF?=
 =?us-ascii?Q?M8E3Ehx5G0Wn8Oe82ZzhXXzCrX5/2+ySG6qhG0aLaHC/tjcYXeom7oC0Xwut?=
 =?us-ascii?Q?TIyzkO0TamlD98/w4zpL362wtZl9ON9vI1UcbbMA8mXTttTNS5t+ZiVPV+NJ?=
 =?us-ascii?Q?vhMBcX/riQuSWX+X1Uc7TmRbGsGS9PHAaxWpMHYbHXdK7dn1uR1IfSq2nujg?=
 =?us-ascii?Q?Bni3HSabKELOrHyyvqb/C/J6Sc951jUBSqlsBa0aVyj+bSkq34CHR2KmIHZ+?=
 =?us-ascii?Q?jtHPJq5+ZyTK7qUg+wL5ZgueLgJKf/TaI2XbI4dckmg+MoNXvHVljXBqvGkV?=
 =?us-ascii?Q?i3DSlzKyZ8QVP4Mm7x3g4vmoz2PuG2xfT7aiS2GotO+yRkcwF2caTgHZ7MAE?=
 =?us-ascii?Q?wpORpjuWG0PiztZbmPW+K8mHZXKpJspSF5QPLy/P/LYyHDfaYDEkugFC77Zh?=
 =?us-ascii?Q?v3LWElxzwol2AKBneo5vJ/pklbwQNFDNsC+hSt61oO72l+sYpCEnfO9DJzYo?=
 =?us-ascii?Q?uV8oQOPGJX4vOAoI4fJuBrnCY4bAaiQhgkeuc3182fLHLUM23TiDbbq3SJ5H?=
 =?us-ascii?Q?yX9b8S3QJe6VA/ZJQhRnRg6CcnH4zY9LhWf9EaLpOoIzM+kEPQ5bOFCUeJQh?=
 =?us-ascii?Q?iW4FdnwtMSaCncvwP8qE+3Fk+xf6VnMnTUSSiXGrhsYIKW3hFNFoyrasJxXQ?=
 =?us-ascii?Q?EvsaWgWkcviCmh9UV/s7wTTW16Fg01mbhab1LEJGSK/MJXubr5LqTJZvdAY/?=
 =?us-ascii?Q?LjmRjYz3/JnjFGxPnmeY+VFnV9AmwtyE1IrZtxKRAd0wac/vMC370OsYdM96?=
 =?us-ascii?Q?mJ72uoXkAs3XMGp46mMkHl2iUtIsVCAK09R2xRLV4bs9IE29vjhakhuRAoxo?=
 =?us-ascii?Q?CfcsGbkBIBrsJK7QX5c4xQn5lVXf9NqlP+sSOYaIstZj3KAKqoz8E0+5ZUuR?=
 =?us-ascii?Q?wtGSvMl1DaWbwEewZSwAb6alrR6690u30e/Jc0ERd7kx0QPNvZLgzOeqVkCv?=
 =?us-ascii?Q?LgzSLDVhX5VfD+01BNxFRe7yPnoUUNSzv/34PW6QB1lJM8oPyJYgObVYTpOr?=
 =?us-ascii?Q?a2B2U3BoHbQvogaylIDZ5WZSQi0d1mltfTAdfNgdongeuJdl+JDpHSPUv+pt?=
 =?us-ascii?Q?sqiVRzyx+PWlFWnfjA0LlhPjxkDeQJuuyxFF0D0R9Dho5ooul7FUA1Y8Gea1?=
 =?us-ascii?Q?TetmGj2MoZH3mpmQIQsE1RZc+eiV1+d2fNXa2l73rD44n3AexsGh30dsyR2F?=
 =?us-ascii?Q?/BHsASwNOPuTp9xioqk+1zJhNMYyZBNdNW76lojEF8CbXQNcUvGRK0AEGKQa?=
 =?us-ascii?Q?72xg2xlUiXSqYkTvWiBkn2v3KRv073peZLpEhKCBsLe3TBUljYyj77aLKfW9?=
 =?us-ascii?Q?QJeJFRT+9zNhNlF2MJSJj6q1yYr/3IwzzB4YMbEB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a40fcc66-4b3e-4075-156a-08de335a55ef
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 17:27:01.6341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtLSLURFUFyrbiNwYSxQ0h+v2T+fuBSRXQq1zsmbAJYtl7eShYKJCqkKrzHXx/VyhMOMA52Vo/sDNm8OFfFL4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6885
X-OriginatorOrg: intel.com

anisa.su887@ wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> Add existing dc extents on the device before probing dax region will
> cause the creation of the dax device fail as resource cannot present
> when driver is bound to the device as shown in really_probe().

It's been a while since I've looked at this but the above explanation is
not clear to me.

There can't be dax devices on a region before region devices.  So how is a
dax device driver preventing the creation of a resource while the region
is being probed?

> 
> We delay the processing of existing dc extents to cxl region driver

NIT: Don't use 'we'.  Just say:

"Delay the processing..."

> probe.
> 
> Question: the guard() in cxlr_notify_extent() will cause lock issue,
> removed it. Not sure whether it will cause issue or not although no
> issue is observed during test.
> 
> Signed-off-by: Fan Ni <nifan.cxl@gmail.com>
> Tested-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
> ---
>  drivers/cxl/core/extent.c |  2 +-
>  drivers/cxl/core/region.c |  8 ++------
>  drivers/cxl/cxl.h         |  5 +++++
>  drivers/dax/cxl.c         | 24 +++++++-----------------
>  4 files changed, 15 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> index 3e7295d3e5e2..3b0e4d72d4ac 100644
> --- a/drivers/cxl/core/extent.c
> +++ b/drivers/cxl/core/extent.c
> @@ -285,7 +285,7 @@ static int cxlr_notify_extent(struct cxl_region *cxlr, enum dc_event event,
>  	dev_dbg(dev, "Trying notify: type %d HPA %pra\n", event,
>  		&region_extent->hpa_range);
>  
> -	guard(device)(dev);
> +	// guard(device)(dev);

This must remain to check for the driver notify callback.

I'm totally willing to admit there might be issues with this code but I'm
not clear what problem this patch is fixing.  Perhaps some more details?

Ira

[snip]
