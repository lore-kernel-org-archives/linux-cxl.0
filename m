Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAC61D31A5
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 21:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115578; cv=fail; b=kpxhPqd+ecSiECTtp673mzlvicY5pmNNxHgiJxkG3HFwSJEMMQVUAAaN5euMJQRSk8LrfN5EgzCnl/yrEKFYWKpESp2T/SBjt3Ty8XPDiYhQ2JHKWYCrxRtwbZia8Qtg5oPO625s793KQsOfr/uSPxkQ0wa0L4p3pYgrJS8oTTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115578; c=relaxed/simple;
	bh=5laW5beZZlxOOOeZMdEsRZsoDof1VZUSJgRZmJp7C4c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mvWdhhGhDbuq/pcR+pgT5pfUvxlu0h9OnVDz8pab9BY3R14RVgP8H6qyib2NAacX2okjPQeqxpkA7BhpTzmoN88yA30dxSSjIbv+SVUv827r6SZl7172O9kvHzkF0R8Qwn5yJNeMuoCOLLxpK70GEKVivu2W5UacEOth1rcooyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYPsMwKS; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYPsMwKS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729115576; x=1760651576;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5laW5beZZlxOOOeZMdEsRZsoDof1VZUSJgRZmJp7C4c=;
  b=LYPsMwKSX5i61uwp5H9Z+y27NML+lUEMUSG6K5LzFQZa2uH/vaywtyFe
   zxqU4am4WR5ib6roqNz70dY3nCjU6ThcK6GJT+qijVM0/zexXVyCqaxaT
   8TW7RK0Kk0F4v8AXNLB1H0m6zNRmORoiljxBbIP73dMKEpgivWYFAV0jG
   8fHgluo3v7pDkIHMa9qibffQPdaYG4uJg9Stf3hWoAsrKQ4Lgkf98Phdl
   eNpvhpAYEuyKKHTpSw6HTgZBRF0Ih34l3ENl0Dx4F3deYytSrgwkv6AO3
   u7m9/0tcYASq+M9RLNMIoqjDNMybndrPkOvMI6d9rXMirfug3QAqga0td
   g==;
X-CSE-ConnectionGUID: OlMAUXJHSFG90Nqj0AaNPA==
X-CSE-MsgGUID: JJfmqQfaR/mYTnrL6+EGRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="39978255"
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="39978255"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 14:52:56 -0700
X-CSE-ConnectionGUID: J1SFRAIqTjO3ueE+4/Yy2Q==
X-CSE-MsgGUID: 47vfhBUvRmSl69T7EqD5Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="79175225"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 14:52:56 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 14:52:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 14:52:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 14:52:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDErGdDuXhFsRzw29kTOXs1h/GtaWK0hEKA642evVp7EYeqjW8wmpiwfPkx6a+hVvvLay94PusnJbflIowChH/F52P/n9VYewb5q6/vzbTgKROKiyR4CZihhgFAh3p/nZtenPDiNfLDbLxtc0V6VsUFrfal3O+mYm7na0cLqNWnQUC27VhM1zS7Uqxog8foNjMCrZrA84ZA47WKyX2FjsrftBcdqGOYzo0jb3h9L4mogNJKfEA13SgKOsgmiwwiKV1FGDxINE91N0lEtysx/6OQLzdetfOD1QDHOSolQ1/pLv10QoIM9e/id4BuHoJIn4wf6z4V+40jlruyCwRV9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyE0KNmmDIs0GvOoIaG+H/ccczhr26sFvuFexqIkIDU=;
 b=lTCr1s9pKajldx/jrClixcXL4gbONXEljAeNG2wAdtAx3xHM5f4IRUoRpriX1efimYMQrO7XzWjQIyWpLMm6wNcXyOmBHCmFYMrRehLDPEYWdtJhvmTXFrZV6Q9Wyy8HNqUViC+4DK6spasa8tnw7yEcKzRieGwkJLGYi/pWEVUnrKO6KMwVm++dptQeEdrhFRGikjpjoeSoDXFkdWq6qTBV3GuWOv1JhvCiif8rO/UsPTunRzXvRfN/TtZ73zSObd/tvCGICyuzjueAEB+EL/wipPtw9q1jXc9tfMY8aBox83lJbMceLbexjp915xwxQIBdXUy2ix2q8C0l12VzIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB8061.namprd11.prod.outlook.com (2603:10b6:510:250::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 21:52:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 21:52:52 +0000
Date: Wed, 16 Oct 2024 14:52:48 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Li Ming <ming4.li@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [bug report] cxl/port: Use scoped_guard()/guard() to drop
 device_lock() for cxl_port
Message-ID: <671035b0d98e6_3f14294c8@dwillia2-xfh.jf.intel.com.notmuch>
References: <2a19289b-0bcf-42c4-82a9-268a922535f2@stanley.mountain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2a19289b-0bcf-42c4-82a9-268a922535f2@stanley.mountain>
X-ClientProxiedBy: MW4PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:303:8d::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: c1413b9b-590a-4a5b-da00-08dcee2ce217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vC5OrPd9uos1F4d+HLvzHPbq59uYd1gkhT9DnhyCPVVkmvyOHbxUar+HfqGo?=
 =?us-ascii?Q?0LigpSGhd67LzSdddYXZ3biIBLRlI11+ppxAKE92VVn8cnTpRoE73/CR39iS?=
 =?us-ascii?Q?ZXqhmEzJPmW/Jv3cTuvPa/r+w5aS8plfX4EGv3S7/s/YfmQFALTkWSaD0RNh?=
 =?us-ascii?Q?SgSYb3XRO9ybYAFDKYYQufNFc7N58/Un/XruKh533YDq/mBKwFdN/8/w2awT?=
 =?us-ascii?Q?kdteG1Hqhytoz8vABGlnjtqyUyPZGLLwqrylvodfWiNG6rbl/RhxI+skru9B?=
 =?us-ascii?Q?YsQO2IsunVnJhf7YY8KGeEL17leK9KWmUnTYZWtBLgI0xSoCZxSwXwcdoWrF?=
 =?us-ascii?Q?FKlkWtZQj1CRK9Ps/ieBDVO+4Xn5fQhYeUwuFwv29WDfIci6cOZ72zcmJWlO?=
 =?us-ascii?Q?lD/OeG8hE9alPvo9YZ+kZXImkUO+z6Hk25zBKNVflGxNOT72s3/++zoogRgN?=
 =?us-ascii?Q?e0uA7b865dFQvLpiP0jkC2zeI8QcIjnz4iin5kKfDc7gjOmHgkSH0i75RBcM?=
 =?us-ascii?Q?SUnzGLpnG414Rdvjsu8NPocmC6MRHbkU9fouMxGnW/uDVoGK+CK19PWAlMNq?=
 =?us-ascii?Q?AoD3XrsZ9PjmYek4EnHlsSsGTxcEiTDUn3YgvmSPB+1k8AF0mloRkUBgh0G5?=
 =?us-ascii?Q?IGeOpzSCa3LCo3rW6NuLBqwuRljVG6qP3r+dwblu9L7modWAeSOU8cwr8gUT?=
 =?us-ascii?Q?517ytBQV5vVW+9hEwYQJhexfYesC0NbKA+7ORgGjiufPLkRGTn6j1YKLwTCN?=
 =?us-ascii?Q?+JQqC7VesJ41jzmqM+yewGAUSJ+wgtc/++RCVT6xpklYk37I4Lyfe4G2dzBo?=
 =?us-ascii?Q?qmelCAdaDgpAz8KoOYekel+cSnozDYIBAkQ+MBUeHgWmAdvr3Gf8qeIC+dMj?=
 =?us-ascii?Q?JTFZ3vjwqE96jtmBjJVr4sITxTcJVXGtnBlWPA/E9gBF8QOzPKhOb7r26R1x?=
 =?us-ascii?Q?lxX9DfYGVp0ahjyUGND3FtXmUsKa7+aXTd4ZE2iRDw4HgU0J2TG/I8Qr9Dg0?=
 =?us-ascii?Q?POAiAX/VWm7yN+0Q86xX3qXP0Z+jK1Ozd3+wRlmX1jdIL4a7cTA1CuvaoWOU?=
 =?us-ascii?Q?38xA59C+NbwIdrmE/S5OBUkcggJrpRxj6g5WujMIuiqqP3X9QXZeL1GrWUyM?=
 =?us-ascii?Q?4+aBktViJWG6silg+bEOZuM6ED9COLQocdGz1MMRRuvMXvRWhvQJ1SREOXuy?=
 =?us-ascii?Q?tphs1niYJTGk6VIYKHvnp8FHQD+k3yHGutfUFuMq0lb57pHpKITgjP7HiefJ?=
 =?us-ascii?Q?2kveWFefnTisx93wIpiR6VD0hgIiTZinKBoQgWshIgoEsiKy1tiTyS1LzrKk?=
 =?us-ascii?Q?xkzprmqhamdkJbZj/CEvgS/6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zzFVe7L/WN6mTN/1Q/J4mndAVp2HNMMaLnYvUu+IZUSVFf3n0PHZoLbMSFRh?=
 =?us-ascii?Q?BFhFiBdq0pembtrzJyDtgtTDoMysQmbpklTYt6zBOm6grj+cLUFIIwlCy62b?=
 =?us-ascii?Q?b1HbrsMX1fyBgOzheW4buL1NwTZnzeTdABTD7cTskmxG+WVA3SYY1EIlKiA4?=
 =?us-ascii?Q?BmXtOdjUBor+eSg6QeDC2/nQ/wGeBU2ATsLg96tnnTgi7yEuZTSx+YyGx0td?=
 =?us-ascii?Q?xAdo20XqA1vIEgNSEvgo4QZMKqGNwXfR5CCgEJ3IQd+Gtqn1hCNxKi12sTTE?=
 =?us-ascii?Q?qgFinS3T5EUGqmjKJKJzEIXM0AG2l7b2b9BEJg31jxSBW1pBh3eVRKDiyXL+?=
 =?us-ascii?Q?2X7wi12f0TWxP8WaETJGCRiuZp66OuHRaocSyHJj01CisEmvatfoeDt7IO/m?=
 =?us-ascii?Q?Z0eZapALzElCQTWnrKfoiiW5XDI28VVndUocWmmf8q7vUgPteJP6C52lgS5N?=
 =?us-ascii?Q?DDu0tPgeVcHg4q1DKl0dlX6DTvGoei3YRbmOrukG9I4ZzNXC+ACvWxnZvyXX?=
 =?us-ascii?Q?nj9z4H8UR6j06U2zCMP8v0ftVkEoqFq3l0pfg9VPMixEJof3XG9GYx2EAkP1?=
 =?us-ascii?Q?4WvarBcNdr/jVgvZSZRRZplxPQkoOMmI2q2Omka0Iqoxy/6EYwsNHzscQ3Xn?=
 =?us-ascii?Q?fNLslkG5tla1vK0UBJoCaUs60Powf79aJL/hYMdZ5PC/HqvW3mIX6tCdBL4r?=
 =?us-ascii?Q?eBym7M1ECqj+MIWQhAu8kqbH5WQTmZKV7xACNfLu+0mg7CUTCTevbWDA2YzT?=
 =?us-ascii?Q?QgMI2GplYxxW6BZh7B4+uHDheeJ+/9Zc8TaXAQAwfbCFyFe/ebZXJ7ytie1V?=
 =?us-ascii?Q?LmspxCVp2sUyQxSlVdPHDSTy04G/AFaQ7oFCnkKqZ/fTA2RpW0v43t9jT6lb?=
 =?us-ascii?Q?v00BnRrDjLQbe4i0wEmcwrPMzDoIRggIK2jLV3mVfsn0Ra7kdttZ5RTnJuUN?=
 =?us-ascii?Q?oebE+u4E/NCwOduEnKIqp5x+0KoP9f27QEcgX+RfNkRlAkJtX0o445FYRs0E?=
 =?us-ascii?Q?aM78VljpsAYgh10sSDpN0gZDAEbJtkydUocdW09MAhRweVW+1P0n6QQh4KOj?=
 =?us-ascii?Q?njjb2sqXgXkujqfr/esQ3E5MloNwKMBIlM7GqunfuiWpqCV+7YxATlHzBAUA?=
 =?us-ascii?Q?mO+54WXKV0d59lSzJ2LQ0iDxMIYlMGpslLq+UmEiHlvNkGU0XpnRDveIUJ3j?=
 =?us-ascii?Q?89iwxNQUnkCKQA4KVqsqO9wYi/uL2E51pLn2ZBMZ6Mqxr75mWlK4YxMPpVud?=
 =?us-ascii?Q?stR/kQIjFoU4uXxF9qqZ2JYr/o1O8ZDMEX02o9V9hJ6rlnSgZ/qEJmcZt2A/?=
 =?us-ascii?Q?XWcs4s0vsrRgLcdDp/p73sJnm7oXKQk3mcePBR6cH/kSfNI0f9ozklak87Qo?=
 =?us-ascii?Q?ggeLzV2zKqbt5ld5JlQUXCn+dfZOm8KquAXBG060gTg1WrMVYh0nGQyyE1ka?=
 =?us-ascii?Q?LQYmgxR+fsFeczO8Rq4sBs/4NBqn4Yl2uJCA8kUSE+F/iHlPDNU8SALXvdXE?=
 =?us-ascii?Q?0fuf2spx19guTIJmI8pjr2fNJwCNYNDKgZ506yGD+nrZeJEKRMNzZhX5V3xN?=
 =?us-ascii?Q?qHg2LMzH12DaYasmwa34uXEL68ciRhGTwN3Ytg3RQVEprhBlHUnSO7TVRXXm?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1413b9b-590a-4a5b-da00-08dcee2ce217
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 21:52:52.0267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eb0coVGWlIBf8mMt6RcxSFYvmnw1JNdYw01VM3x2P54A1g+A4HuXK5XcNDf368pxqtXDFslMJhX4gC6U6NlVIWY+Y7xtgoHy7As+auZUN7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8061
X-OriginatorOrg: intel.com

Dan Carpenter wrote:
> Hello Li Ming,
> 
> Commit 7f569e917b78 ("cxl/port: Use scoped_guard()/guard() to drop
> device_lock() for cxl_port") from Aug 30, 2024 (linux-next), leads to
> the following (unpublished) Smatch static checker warning:
> 
> 	drivers/cxl/core/port.c:1591 add_port_attach_ep()
> 	warn: re-assigning __cleanup__ ptr 'port'
> 
> drivers/cxl/core/port.c
>     1542 static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>     1543                               struct device *uport_dev,
>     1544                               struct device *dport_dev)
>     1545 {
>     1546         struct device *dparent = grandparent(dport_dev);
>     1547         struct cxl_dport *dport, *parent_dport;
>     1548         resource_size_t component_reg_phys;
>     1549         int rc;
>     1550 
>     1551         if (!dparent) {
>     1552                 /*
>     1553                  * The iteration reached the topology root without finding the
>     1554                  * CXL-root 'cxl_port' on a previous iteration, fail for now to
>     1555                  * be re-probed after platform driver attaches.
>     1556                  */
>     1557                 dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>     1558                         dev_name(dport_dev));
>     1559                 return -ENXIO;
>     1560         }
>     1561 
>     1562         struct cxl_port *parent_port __free(put_cxl_port) =
>     1563                 find_cxl_port(dparent, &parent_dport);
>     1564         if (!parent_port) {
>     1565                 /* iterate to create this parent_port */
>     1566                 return -EAGAIN;
>     1567         }
>     1568 
>     1569         /*
>     1570          * Definition with __free() here to keep the sequence of
>     1571          * dereferencing the device of the port before the parent_port releasing.
>     1572          */
>     1573         struct cxl_port *port __free(put_cxl_port) = NULL;
>                                   ^^^^^^^^^^^^^^^^^^^^^^^^
> We free port when we exit the function, fine.
> 
>     1574         scoped_guard(device, &parent_port->dev) {
>     1575                 if (!parent_port->dev.driver) {
>     1576                         dev_warn(&cxlmd->dev,
>     1577                                  "port %s:%s disabled, failed to enumerate CXL.mem\n",
>     1578                                  dev_name(&parent_port->dev), dev_name(uport_dev));
>     1579                         return -ENXIO;
>     1580                 }
>     1581 
>     1582                 port = find_cxl_port_at(parent_port, dport_dev, &dport);
>     1583                 if (!port) {
>     1584                         component_reg_phys = find_component_registers(uport_dev);
>     1585                         port = devm_cxl_add_port(&parent_port->dev, uport_dev,
>     1586                                                  component_reg_phys, parent_dport);
> 
> This port from devm_cxl_add_port() needs to be undone.
> 
>     1587                         if (IS_ERR(port))
>     1588                                 return PTR_ERR(port);
>     1589 
>     1590                         /* retry find to pick up the new dport information */
> --> 1591                         port = find_cxl_port_at(parent_port, dport_dev, &dport);
> 
> But we re-assign port here so it will only free this port and not the one from
> devm_cxl_add_port().

Yup. I must say I really do not like what scoped_guard() does to code
flow. If conversion to cleanup helpers causes this much code indentation
then the value is low, especially when it hides tricky bugs.

Lets revert the scoped_guard() conversions for now.

I would much prefer factoring out code sections that need a lock to
their own helper that uses guard() rather than convert inline code to
scoped_guard().
