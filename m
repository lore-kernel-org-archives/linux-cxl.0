Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281A31E00A9
	for <linux-cxl@vger.kernel.org>; Wed,  4 Sep 2024 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467880; cv=fail; b=UnR4mofweYpPvHcQUiHozBg51vW9UDzRPK+8rzuMKdgFPgwZN43Rc0ispWR0LLgVvSaafQAzp0AGtsxHm+3pX0ByLzgq73jxWYQfUbZxSNkKdawB4MWLULdtsBYTcISOR9VMw+C03AR/XQc4yV7TeIErao1zgJOHvci2gYMpSXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467880; c=relaxed/simple;
	bh=ki9YH1MEEosga2iaO/5Kic8EgS1rLYhWmrfBq+1cQkI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NZgNn8GR6Eln2b6E9jK/cXXn1OYnQGXsqzAUhmQh/WdtJLWWct5iXc8v1EIyUut2niZ0e+eLQWbL5WvQYiNwRcKUZNiwxeqHZQjsCBvTGaSvw1ECvyQB58acQb5MCKH3A+tGVXMZNGNx+FyxCyFQgRjSewCsbS2fDXwD8lxgaYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LY4JjUDs; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LY4JjUDs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725467878; x=1757003878;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ki9YH1MEEosga2iaO/5Kic8EgS1rLYhWmrfBq+1cQkI=;
  b=LY4JjUDs7f7BQLLlb6KA0ZSuLR/jBiJiRn/z+u97132/eEM7OJOWJpke
   NjaiB1cLag+n2YzZcTXyXc1yiq2pv+UYPxjxkez2Y90LZ+kgnmZ8aizzM
   GXyzuggilNX6PfSX/BpI+YPoHlsEx3WtqcJ5Gl+4CH6dqiYNSghPVtxR/
   Hv3T+5AV+KctPBDxVbwFLpY/fIwR/FJ2cZwyr/ld32ujzpi5rnrTHilrd
   Ek1LqbKrb7Lc9iam3IfqWKxNcTZfbViu0aaDji45S5TLgLnlT5tYei7tv
   nNcxJKa6zals8L8ymBXrkZsJkfM/iiHjnmg/Ee/HLv2aifkWvRNZ/b2AO
   Q==;
X-CSE-ConnectionGUID: KonoTjn/RgWkllLIXHRgZA==
X-CSE-MsgGUID: CDM+h+SxThu7LK7p4LJRDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="35303185"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="35303185"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 09:37:42 -0700
X-CSE-ConnectionGUID: C5hhBkH6T5GyC3DN89HqzQ==
X-CSE-MsgGUID: NQcr4bXLR0e7eUnwExRxyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="65166626"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 09:37:42 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 09:37:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 09:37:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 09:37:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROWZ49/+oXTvXGm1vVgGAennOAADVT4Dhej4OIt5BGUc+p62/vP/4HBn4x4DyXIGEC1iuKhq9etLHR/4c22XPL4APr8TaEjowPH29ZervU0j2XdPmHqxpJp87rF8fHbAF+fuM/4p4oAmVqOdmC4OqsUuV3nZ7hHARED28aLkuXMFF8hVCk9Xp21CPSHb+YiLVG6e/lmJG9dC6TfkU0TqeIas4IiMlI48rrLjmYx6Q0Xg6Fa5oaEecfGRZ/n32Lzozeie3LmkFdB8ZaxWaGkCgxRVtDVl+Wtar9t4jqysOfKUE9TXvEfphHHZmTjndAyP/smwv+fDGTbCoSnn94EPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60HvzjJnJ4lMM88CqoRlioFPfF8A7ghgFFL1u9rfNVo=;
 b=zNW1/VLh5xWwqvL4X2OahfoTIKNXduyDmoYANAVzp8cwPvdhYSdgHvzT3ptds9KMB5X4V1E6arelY0uSTM4HI/8LGJG0amO2JoEZs2k26AtsTBdL/Ao1/Z1w+VWAN/Nww1otDQllmyJP9F5CY94El2BKRtuTn5OIMa72itf7hRGhUkDBCAsK3RoR5Sw8opoqG3JqSWFM0bn96nf/goBH8Nrt365KhNfSIHJykN7lxtc9HN/IlVdB0FFX6fPPHOIrYMojKpxmQqIf8fCEsLYIr00rnlmI09K+TmJylVaBB1lKhqKFdlF1xt4bHhzVQM9uODEa3xydGzKuhRYpnZcgww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB7297.namprd11.prod.outlook.com (2603:10b6:610:140::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 16:37:38 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 16:37:38 +0000
Date: Wed, 4 Sep 2024 11:37:33 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH 2/2] hw/cxl/cxl_event: Fix interrupt triggering for
 dynamic capacity events grouped via More flag
Message-ID: <66d88ccd15efb_1e915829439@iweiny-mobl.notmuch>
References: <20240827164304.88876-1-nifan.cxl@gmail.com>
 <20240827164304.88876-3-nifan.cxl@gmail.com>
 <20240828123919.00005b5f@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240828123919.00005b5f@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:303:b7::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 868225f8-e2c8-40bb-b5bf-08dcccffe353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?92tbwlbmlZwVc1MiVkojiZs7ZDmeNLBpT0h/RQHQlbZZM0vgooHKTLB6Y1B/?=
 =?us-ascii?Q?NyzUkzmSVHMXnGL4RvUqsm5WDuyV11uAv5RqQyEBpNNhKkVX/mJbtNUW0AiO?=
 =?us-ascii?Q?Pdq9xq+iGBE8o7Wyv418L3Dy5bQo4Weu1Gyh9aqOmFGu5ML5k1iDv1tO5U+7?=
 =?us-ascii?Q?TRmjarkUTCPr1juopog6j+jTA/sHywEt8TeXZKzSJ5UV2PyvK6w26xhGKnLK?=
 =?us-ascii?Q?lZjNgwo8SwcBjr/UGIogK+YdbMxmkIgFbM7Mgms0fzYgVxgdtd9lRS6Hky3+?=
 =?us-ascii?Q?yipZlq9GuheCpQmp8Mf4QRi5F8t1lebW3lZu2PUPl72Ml3m8OBNb8HHzQ2lw?=
 =?us-ascii?Q?4PGmji173TCoBXkB2KdZk6Zj1ItwbNBcMcohYJtaRgkVrnDC5RGJYQpykG/3?=
 =?us-ascii?Q?mgeHB1xjPtQOyB6CB7X2/X1hBCIp/gMjQNhabrg4YX5Yz06bBIl8UogAPJPn?=
 =?us-ascii?Q?/8bjoLnSV2H7HUDTVeBIgnZkr5z1NcGP9LJtfW6IbgEx74sx1QOEfLDColgm?=
 =?us-ascii?Q?I5S/jPMJiEHjpHdKmiWC727GJWnNP884zp7CbDdletcTXF6nD2Sw8b2wXhzd?=
 =?us-ascii?Q?5yuP0klq+BLTRgHdgZZHxZsTwjZ0LPDVC+Z7mWaumVKgDM95Toxu338nfO5w?=
 =?us-ascii?Q?fAEN9nfZj63N2pp8IQzuCjy19034GWiXEfHaHyWgEIcONGA/QHfs5WZZvxm1?=
 =?us-ascii?Q?aQEJxhTsEh8UnzEFrst8itwe7AyCNBj18ZxJEwgtoJwNE/XUnEHcyjKHxetf?=
 =?us-ascii?Q?hrVdTNYcBXUVrLZH1rnUPAgVsyd81+3BSDFcdy5/08B6Aqn5EUp5mW0utQDV?=
 =?us-ascii?Q?CCQ0Xp5aphY+swczkzkO8DfXOG8O558tO/I/KZ+/c5JdB68VX00AXlAiOQRA?=
 =?us-ascii?Q?u1jLsyrlGqei0/WUtFhiaZqPGVLUayxiPuu/+BE1UtGlNyGOuuFap9HCtvj+?=
 =?us-ascii?Q?qIQc4CSc2LkcJwM0X3mWRHg2ROb0YhSqDQeBkpT51rdMv1qEU6AJwTPHFCNF?=
 =?us-ascii?Q?K7IQXj4VGhenBLNfn/yF5CcV/UlgQffeXZKCXvURw6THfy2ngRzgYx6Ls2FV?=
 =?us-ascii?Q?0xyzuEHNqBxqbtJjvrinyDiKJon5U9xK4KAGSO/PLiaUFS9ovbK3f4W2kSYU?=
 =?us-ascii?Q?nIA78CJcvuczVbjv9Gc0tjLcpwDB500T84G3uY3vQZSX4p6tIpAn4iZDxJKi?=
 =?us-ascii?Q?YXa/Irc6MPpV7g9Jg7+ebwCBaum07UNeCykjVEe2USOXqFhbSD+Dqy4+7dXX?=
 =?us-ascii?Q?aLV7ZkC+PVqvvA7/IBSsI+VuNMrstnxehv/I6gT1kSBuQORmPgfIxDm07s/E?=
 =?us-ascii?Q?NagkPfaoLV0p4KeQ2kjauRPSLCX5zC6qxC/0Z7BK03LU2w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UHdM7A+bdfIrLevQihwEBrCrPTvzlGTGMy92TG2A/lUHPHJVFoC9+VcKSW/P?=
 =?us-ascii?Q?Pl8y38cvRK5M7Jms8wyuXrC6xjq5wELGxG2n0+/5Q4ovS8OcBW0mCiXomj3R?=
 =?us-ascii?Q?gb+WjtXhvHXHLuy496c3EvwzKnFHH6ecvm33E466kTqZkoHVbjTZYV/+UJYG?=
 =?us-ascii?Q?Ma6DV8Mg9gyYj5H/2+IPp5RmgxYi6NpB+1Zdt80ppwpUu/wILd7t4PQTHFUX?=
 =?us-ascii?Q?+5LGpThFgwOY9IphSb0TAsdgwtbBkHRWKpVXGk/iZ7M3pJMf9g46i8bl+wCL?=
 =?us-ascii?Q?MmVK+f0YtxltWRWuQ47t9z09FVwWDCOw+WPX5I/wDxr+V+SQaD2KVzCdRYZb?=
 =?us-ascii?Q?++cHzS6KTAk86CnkRJQGtxJIVhdv8WbRo3woBc+CPs4TXoHly4A0UjFtt+gz?=
 =?us-ascii?Q?2y3Y1XkgcQ/KBN/Kec1zfSpO6m2XTS0/SekSrqgz1ZZXAVG1h/C/6aCe1JWj?=
 =?us-ascii?Q?aX5dPEf+PVBBnaoG1iKX3u5uNepDNFR7pLrT88oIrtD+lnFmIt79ois7BLRX?=
 =?us-ascii?Q?jRkxqWY/hMHNHJR9IMWqghZOanrDnXBgp/yKD4hWetafcFAMG5FqEsiof2Bi?=
 =?us-ascii?Q?F+QvQmGKGaKDSFMRuHNpmXUQKTqobOqc6Dli6laD0INHhJspz21kKYC60w+8?=
 =?us-ascii?Q?V4xqPGPMayRMUM1UXq0GZV7nuugJhMNq3pqSjSaK0FmTIo196ddllX+4cmyH?=
 =?us-ascii?Q?+AGEir6VBmR2D0oW0wstvLG09e20bDORDFw+nSvSXV2icrOKpt2GTLZQjbv8?=
 =?us-ascii?Q?zs5enOL9auqBw+weeuHqRpsXuACXIqi9F45RzdUmo+iXEIxI1CZR40TAIhyx?=
 =?us-ascii?Q?Lp4OkegTtu5xX25nopmCXIe6z/i+ZbRLk4sOLdn4s1/JDBj0Zy+4MFbPHi8m?=
 =?us-ascii?Q?U1my4h2YW45gC9MTCKuK2Z5vC5RJq3RuY1SkIBxRN9rms/aAhgsbIUuNK8uD?=
 =?us-ascii?Q?zK5Yp3KCYG4SAMdWxJ4QO9LbgXFlS5movtn0I/Pl5cCQmUbpBHOOhpPRZEw4?=
 =?us-ascii?Q?Kl3KTIJ1yaxVQEP0/20Nl6EMoKIYZQCd553t5rLu7J66Qc5Fv+eHH2hCckrJ?=
 =?us-ascii?Q?UnDkOzwBe41RHEhaNaUtEeAFJil80IgW3ZExWmhEe/+K3yAPJJGrlghBpDbs?=
 =?us-ascii?Q?5w8NAnQO8ImCG+2z0o93d4Jsa+yRQ1venkwfW0WsrAGEt3LL679pawpXgJfM?=
 =?us-ascii?Q?i3pTMUt3g7LspJGhUSqF9SYP4Uqf4NuMRPZuVLzkdZpBpxiRaspLm/jPCKzO?=
 =?us-ascii?Q?k5EpJ2h+q5FwaM4RZkQ5jNp+013HO2+F8msEPND3zmGbIvSZg7gIpFAA49SX?=
 =?us-ascii?Q?6l1Xgg57eZ+6hA1veANTJAuedZH8T2+1wM7qgEXCEdXWKaZFb0yLS3nT/erb?=
 =?us-ascii?Q?r/JiodnCVnSxFHaLnG0VyzeyoWDZ/sE52095Z9/Fy5zs9WOU36Q+J4nsQsLK?=
 =?us-ascii?Q?edqKUZMIDNyEq5hvKuqPUwfTiMA/9ePVtctZDlgrL1Q2fipLWW/j8Bt09dCx?=
 =?us-ascii?Q?NydKDhgn80HHVodtRXfJRYV0UbeBtHukQsb+klShl60PRSOJ5Hh74tDnG+n5?=
 =?us-ascii?Q?w+51ZhD+kF/MO7u6CiGV+J7g4tVRfv6vyBnEc7DL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 868225f8-e2c8-40bb-b5bf-08dcccffe353
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 16:37:38.7182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eez2/ms5LO36V5Kcqt/qT+IKOZWMhPCv6JyEpR8yj0Ni2kc9WOaGcxb5cpSvqLq4GVxoyF79d0JGO+Vt/APNQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7297
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Tue, 27 Aug 2024 09:40:05 -0700
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > When inserting multiple dynamic capacity event records grouped via More flag,
> > we should only trigger interrupt after the last record is inserted into the
> > event log. Achieving the goal by letting cxl_event_insert return true only
> > for the insertion of the last dynamic capacity event record in the sequence.
> 
> I'm not sure this one is accurate.  We might well have a slow
> system provisioning capacity one extent at time (and interrupting).
> 
> The event buffer might also not be large enough to hold all records so
> the device might 'wait' before figuring out the next extent for there
> to be somewhere to put the record.
> 
> Overall I think we can interrupt on each one and it should 'work'
> as should interrupt only once there are lots of them or
> every (n).

Indeed I think it should work.  But you won't see any extents as they will
be pending in the memdev.

Did this fail in some way?  I'm sorry I did not try and use qemu to test
the more bit.  Rather I used cxl_test for that.

Ira

> 
> Interrupt only fires on a 0 to >= 1 transition anyway, not
> on repeats after that unless the log has been cleared.
> It's up to OS to keep clearing records until it at least
> momentarily hits 0 if it wants to get any more interrupts.
> 
> Jonathan
> 
> 
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >  hw/cxl/cxl-events.c         | 8 ++++++++
> >  include/hw/cxl/cxl_events.h | 1 +
> >  2 files changed, 9 insertions(+)
> > 
> > diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> > index 12dee2e467..90536c0e68 100644
> > --- a/hw/cxl/cxl-events.c
> > +++ b/hw/cxl/cxl-events.c
> > @@ -135,6 +135,14 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
> >      QSIMPLEQ_INSERT_TAIL(&log->events, entry, node);
> >      cxl_event_set_status(cxlds, log_type, true);
> >  
> > +    /*
> > +     * For dynamic capacity event records grouped via More flag,
> > +     * Only raise interrupt after inserting the last record in the log.
> > +     */
> > +    if (log_type == CXL_EVENT_TYPE_DYNAMIC_CAP) {
> > +        CXLEventDynamicCapacity *dCap = (CXLEventDynamicCapacity *)event;
> > +        return (dCap->flags & MORE_FLAG) ? false : true;
> > +    }
> >      /* Count went from 0 to 1 */
> >      return cxl_event_count(log) == 1;
> 
> If there are multiple this will fail I think as cxl_event_count(log) will go from 0
> to X not 1.
> 
> >  }
> > diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> > index 38cadaa0f3..b0e5cc89c0 100644
> > --- a/include/hw/cxl/cxl_events.h
> > +++ b/include/hw/cxl/cxl_events.h
> > @@ -170,6 +170,7 @@ typedef struct CXLEventMemoryModule {
> >   * CXL r3.1 section Table 8-50: Dynamic Capacity Event Record
> >   * All fields little endian.
> >   */
> > +#define MORE_FLAG BIT_MASK(0)
> >  typedef struct CXLEventDynamicCapacity {
> >      CXLEventRecordHdr hdr;
> >      uint8_t type;
> 


