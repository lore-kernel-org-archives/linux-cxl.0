Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9B2184
	for <linux-cxl@vger.kernel.org>; Tue, 23 Apr 2024 00:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713832663; cv=fail; b=Q5ETdqt7KPAHejeW8CDl+YWQQXEYXaD/WiJtcHFoyv1zjOA9jDsINmIa6h4Vj0ZFXDQqQ6f39CxdDwBOy3pyajZeEIt3wqDLvtPC3l1UEQfBttL6LN9GV2bYxZ9KSOxXYBrRsprhu+2D01pO/6970gP0bdRWNx2XdpR7RBtVL5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713832663; c=relaxed/simple;
	bh=EIDYHFqiC8I3gwJOtXz/fVpYlblcAZSBjhGBqAZu1S8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ddbr83zdHMFRSUA7DTOCSoqKFnZhwHRcRrQCkv5aJ4Plg+wU8GWlqqg/Db25SKwWQc2NM+oVX56AA+25jsqDFig0Gyqnb4VgJ0rC0RqyUqeLoc79Xanyi9NYv0Dqt8oJfV5HYPbj+YNP2Ra0U13qb1YgU22GxKpUiI/xx+cQWR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FCFXo7j0; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FCFXo7j0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713832661; x=1745368661;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EIDYHFqiC8I3gwJOtXz/fVpYlblcAZSBjhGBqAZu1S8=;
  b=FCFXo7j0nYC31NvP3NEKFcEu51TPTZlgtYhHUWxv5V0JLFueWD/T6RoI
   1gedb8cztO7/sdCtHC1LB6HNQV0/nFnxzCVtsvrGl0MCflD7kA7cdp7jZ
   omFPb9b2aNLV1Axo3T2ys2/ZC5hM5F/G6W2ndlLIqtIdNbX5LRAvM9gml
   CY1pHfUVv6ImaEtyOeJ8a1HrJCdDG16+2HCBk2qjSl8TaKSi1buHg67ns
   BXbpcxULK3EOI1rtUu6zrNNJChttHPJ+BKENChKMdux3FT6LXXXJ2ULeK
   FYsegXkAcYxm2x9kMvWtoG9DAucwN5N8+p5wtLx5Gmp5456caQ6SP/mV0
   Q==;
X-CSE-ConnectionGUID: a1HCTiuPRcWFVXGpG/ecag==
X-CSE-MsgGUID: u8e0n9BpQVOqMnm686NPBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="13183165"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="13183165"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 17:37:38 -0700
X-CSE-ConnectionGUID: I/Oy1egPQTG9F9DBMrZlww==
X-CSE-MsgGUID: vueyMjaMQk6WHNBmVinj5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="55128856"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 17:37:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 17:37:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 17:37:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 17:37:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 17:37:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9puhOgyh4yoxY0qqCKYr8tsOLSUiNV1ON1kg6jWRqSy6ksZNju6zBk7BB5eyVJeOkbm9Nv/f8EIdxRBuqwf6zzsc7bpC+PA7q+SxUU1FkF8WsRt2YKJ1BoYmtKNKDsGly1YBAWD1zhPA5hFGCnnrCdIU4uejRr8XJcgg++WJZlC0YFUgMs2Ye0x9HT1+uNCn0MfApErnaaQ1BTDQM+DvheyY8kkA2JqjSo3YM9gZVogJXed7rOqKYZPhPUpPpXQYAjEtlnqNz5K9hj4obUCZ62FqXOjJmKiWVVSGjYo+3xNRLh1Y9G0oqdg/tVzSsTi6k/WzemisTkNVCndcy5T9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXpPi7oe4hVNKsgFk3ogYBRw0th4IMZ4rT/sTaDyr18=;
 b=RjoTzXs/ytYgfKoFAgqUuq1jwhxxjLmkwvxN2xCSqe3PZG1rb/udDIiF0XFLCusAByG5pmakaMj7NRU+8SZgT3fADzDNFnIs7KdPyY7m+DoVAKtW/UkFRYcqTCbLxGYFGCRll++9W3zqC/Gx8sB6GIZg1pn76tIGaex8Tu2sKI6ELqLn4c+GAz2g1AJnTHO/FQQ4Rll0JFxy01MSX3TqlX75+knr0WoV/s2ScW9Ll1a5nDMFLV94ayUvSu4yC1qNjpdL8VxTFoTaQdZZxX1Z9jj0F28KIe2ckUL62xtSyg7zMoiTC8HXHqM5nY6sL83p9kRh4crgGYltJ6RRW8sHsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6188.namprd11.prod.outlook.com (2603:10b6:930:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 00:37:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 23 Apr 2024
 00:37:31 +0000
Date: Mon, 22 Apr 2024 17:37:29 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <jim.harris@samsung.com>
CC: <linux-cxl@vger.kernel.org>, Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: RE: [PATCH v4 1/2] cxl/core: add passthrough flag to struct
 cxl_switch_decoder
Message-ID: <662702c9d9389_690a2946@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240422091350.4701-1-yaoxt.fnst@fujitsu.com>
 <20240422091350.4701-2-yaoxt.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240422091350.4701-2-yaoxt.fnst@fujitsu.com>
X-ClientProxiedBy: BYAPR07CA0048.namprd07.prod.outlook.com
 (2603:10b6:a03:60::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d23d7ba-bb46-4a9b-c701-08dc632d8fc4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j+V4BojneghGYZSa6O5cOMiVRub93LfSSn7VTNO1JmRy1BsnAj57o8ZSGOgC?=
 =?us-ascii?Q?5aKAawOEPWQ4VQJoAiol1NQdT5XSom6buVk8Ch/vg3jp1vSymDVfJclKYmGW?=
 =?us-ascii?Q?quEjlLHJ+nycI1wuV4J15IVdFBVm/504MIjRKDK8wQMrk+amdqA66QyaOlFN?=
 =?us-ascii?Q?v1mf2zB+NdT/dsnEbqasvsJvKZAEBoTbfQJB1n/f7R4T3rzbvNxwPFQdZQEM?=
 =?us-ascii?Q?BPg8MGEaltNyJXVyo696L6iYl1sn1SIM/B+1Q9/149hTu8lnU50Vu4Y8Jftm?=
 =?us-ascii?Q?blWP15jy+xBlbvLqIdrR6eaI3uPGHNfKejDWQHEHUJTz0NdqwGY91frnmZXv?=
 =?us-ascii?Q?kOCNMeHoW7MohFefnsx0rVIJONYJff7l8iM8oSGDX1TKjCncOR6AqdKETLyP?=
 =?us-ascii?Q?0NtSZDP4MoLGWWEasyYMB90SY7RjNe9jpWRRy8NnRF8maUyNSiIlmDpJMCqp?=
 =?us-ascii?Q?Oyx2tpSzORrHhaw8SbqZis6mSS5trbJsyA8MR2xFAye/zU0OTfzLMaF+wpz0?=
 =?us-ascii?Q?QLjMxWhdSHAnIwyYZpVtvL4gD2F+M2zUmSD7/+LLIN03B0shGMhfZ6RjlVdK?=
 =?us-ascii?Q?ygOXa8QkiAov1hsDq+EzDVGiWwM85A3Inm3GD/Z5FcujqEPLPRRacSQOFgiu?=
 =?us-ascii?Q?uqlnkqmLy0zEOmfS+xf1b088NLO1jIu3PVJyafC91YWNeJdKpxs5NKOGxr5a?=
 =?us-ascii?Q?nBsZoNJwvnmzLJMhyRloQMquP6ubnZQ7xytmi1RwZJR4h0gA4GkReRGUto5D?=
 =?us-ascii?Q?iZEvHU0tzmAJZgpCU3tZ57Va6D5vsVthjO/UejzMN6fG96ptmYggcpuJZMcN?=
 =?us-ascii?Q?mZYrscGFnVauZEaErmwhxZAUx6IBq6hVaJvG7F7jyzj9tk2KaJ2+9+Bn16lM?=
 =?us-ascii?Q?CPoFdTEoKzqHqTo866kLG++CX/V/AqB+VmyUCS8kPBbwF87ZV7J5paOA16q8?=
 =?us-ascii?Q?evkanKLEfPI//wt17Ct9ZA2txQUd3hqOrKCfWMjVI/IWtaSHUPY6Mcv2EIsy?=
 =?us-ascii?Q?Dx2K+s0whySnpjzPcEBP0yE5oMvcGEzZczkRDdGG6gMaQb9gvS/lBr+mnULM?=
 =?us-ascii?Q?cLcDO9hxwUAqvtwL6gFBCBUbGbHWw6Bsa69H9twZSb+WpypP1WmfsJOZkEAB?=
 =?us-ascii?Q?zhH7B/tkX+VCdFaAD9NN78Yi6ZtF/JZj3GQ+epDD970TLfCmxCLsz1d3rwc9?=
 =?us-ascii?Q?bgAlPnGUmIGKQ47Z9Ibk7w+yHdhkhGAh3/ypNtYAxQ4slGG6DbPjNK9z4GGW?=
 =?us-ascii?Q?MxaQljPTaasA7n1vxtSY9Ptsu6WBJU20Khrvlu9G0A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2dUmn9f8tsdAkEXPUHTz2chEDTvju/yL/3pmOlFynWDcxHd/Kix22dY4T7St?=
 =?us-ascii?Q?I6rz5W9+4hFypZjdHBSTBZLvLNfKxllL6jJBaZJ7izojFzmJWAGMo/ipQ6c9?=
 =?us-ascii?Q?3uPVuUn+RPo/2zstk6pr8VO5Xow2N6LxRGXo4UPD4t9wUMSnzS7obYw3jZsY?=
 =?us-ascii?Q?ixzKM6zVd0tF09QyV+iptIeROZilUj3VjMPYjzV9kZ8HkfZKkWPP8lGH2Rwl?=
 =?us-ascii?Q?i+MkaFg1ukEZwpwr+WrWJjb6X+AxYy6IVkRC48gtF0XFdA7gRPNies2aGYk7?=
 =?us-ascii?Q?YpJk28ukrqOePZrSTXk90a2CKFfnZuWjVXjojTwxKvHLvlV5ZxgQZz0SZxSC?=
 =?us-ascii?Q?xVg7EzVj6BUN4eDSOBtNYYKjYj8NYNoZ4GdltpjlmPq8Y0OBtg37aFV7I3aF?=
 =?us-ascii?Q?jGuJX7QuRDDmF/en//RMIlkqWfr6Jy4fqdbxbzgC0wAwqkaJfY2qUrk/Su9q?=
 =?us-ascii?Q?l8tVNMZ5Jaj3vzrqI22ADUX/enVIwpLMd89jvKX/+m0U35wXr2qQLSL8ndHE?=
 =?us-ascii?Q?vFKvyPh387lVNLLqYuRkYKYBg11cJx9xoqZotefnQFpQqlMKO/bgKH8QHMqU?=
 =?us-ascii?Q?IEow7lDCH78l7ruME4McTtOSepz/3VVMN6aeKmFUbBJEkWMaS54jCVGDGDt6?=
 =?us-ascii?Q?3tywttZqqzHndsZh6qf2PNKeCZGGF5vm+BFA4zD+1UdWDhIPX5UK5r6djMYC?=
 =?us-ascii?Q?mklhUeYD00ToE3fmSgAW7Ip7pmq8qwOK+9Hq6dc/G9clpWCQQCq6rcDB8Bt2?=
 =?us-ascii?Q?/4V4Z5OiY5LAc9mcIskJUa/fJEQWFG/9t1aShXNW9oc8n0EY8zYJ44h1mkJL?=
 =?us-ascii?Q?OphICVYCtoePvSfQukkGEU3EclYUI/fZhxbugFHd62NnQw64cn0+OZR1nms/?=
 =?us-ascii?Q?ACDz1lnmGKW0/VBrKmYCTrtD7pelRsemRn7sKNi4Y6beylnojzSFmOP4V3Q8?=
 =?us-ascii?Q?ieV/u4CK/WYdKhgNThDp20+eoY8/mJVtjYHI6hRewm1FkCXfd3nc7u9CtSXi?=
 =?us-ascii?Q?5easQ44ipBQH4eADo1djcKie6kqYqjH0+/3gOkoLXuCvNxmkI0FPgePSTB4Q?=
 =?us-ascii?Q?/bwEPYQc548sLDZeXz6OVLHXSgH3p8XPw1DjukOyNddKGK5Amldx0aQe4pm3?=
 =?us-ascii?Q?fvouHfcxzv5fyfqdKimUf3McrSeEVjkDOBIXcEt94BGuP2J9RnmjwlWcm3Oy?=
 =?us-ascii?Q?1jSyueqfoLzgFegSG6XYi/8rn3630lQQCjfnFX/oKIMTzViYo4hBwx9w0Zon?=
 =?us-ascii?Q?jXszZjrMp3KreBr50+TsaaoomElsIvl3BHcUstRczQ5N+uec94P8fgh15H0p?=
 =?us-ascii?Q?n0LGdfGXDFwOxbVsQFVRGgyvcl9JtXnulb7MpfY5EnFGz2U9kpzLrkHRDqIQ?=
 =?us-ascii?Q?iQuW/Sl3PtI77wZ+4Hpb6pnMoeUBRo5tpILCp2eCPKM3azfOSMVGu9s1ySCb?=
 =?us-ascii?Q?N2OMUEAGfu7PYjK0kxcwqwBwk9nvZkE/OoHdN8tBIN+WJsSYvgMxYTBlCNPD?=
 =?us-ascii?Q?WGHN8fZasvl8szXOLb6yg3aKq/JL0OSSYxVhEuNEj4Pn3PqDQs3X4WEHWJCG?=
 =?us-ascii?Q?/j7ChcN0upPLs9/yayKnCK1JXNjK5i4mjWbGIbvwkUXyWEuHP05RQhKuUvBy?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d23d7ba-bb46-4a9b-c701-08dc632d8fc4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 00:37:31.7430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdEr1HrPPRh/dNFzQdGD/c7xUp5mmTOW0nlWHd8Y1+q3wbMz6UqD5rRoXQJTTTnTcYngWykPHimo+pEujsA6aAQOMlY4RddoWKkCyHNMpYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6188
X-OriginatorOrg: intel.com

Yao Xingtao wrote:
> Per CXL specification (8.2.4.20 CXL HDM Decoder Capability Structure in
> r3.1), the host-bridges with single port and switches with single dport are
> not affiliated with any instance of the HDM capability structure.
> 
> Driver will add a passthrough decoder for each of them during init, so the
> constraints imposed by the HDM capability structure do not apply to the
> passthrough decoders.
> 
> By utilizing this flag, we can swiftly ascertain whether a switch decoder
> qualifies as a passthrough decoder, thereby avoiding the need to conduct a
> string of capability constraint checks.
> 
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/hdm.c | 1 +
>  drivers/cxl/cxl.h      | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7d97790b893d..27fb4f9d489e 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -57,6 +57,7 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>  	if (IS_ERR(cxlsd))
>  		return PTR_ERR(cxlsd);
>  
> +	cxlsd->passthrough = true;
>  	device_lock_assert(&port->dev);
>  
>  	xa_for_each(&port->dports, index, dport)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 036d17db68e0..6f562baa164f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -415,6 +415,7 @@ struct cxl_endpoint_decoder {
>   * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
>   * @cxld: base cxl_decoder object
>   * @nr_targets: number of elements in @target
> + * @passthrough: indicate whether the decoder is passthrough
>   * @target: active ordered target list in current decoder configuration
>   *
>   * The 'switch' decoder type represents the decoder instances of cxl_port's that
> @@ -426,6 +427,7 @@ struct cxl_endpoint_decoder {
>  struct cxl_switch_decoder {
>  	struct cxl_decoder cxld;
>  	int nr_targets;
> +	bool passthrough;

This flag does not make sense to me. The definition of a passthrough
decoder is one that can mirror the interleave settings of its
upstream to its downstream, so just reflect that that in the interleave
capabilities of the decoder and skip the special case.

I.e. set interleave_mask and iw_cap_mask so that there is no limitation.
