Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31816212FA9
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555435; cv=fail; b=RYaSDNCMyBY4k0DTp4KnFcFujlY1ky3KMsABuVV3Bm86SO22vu7LA/0ZG9qPR7Oe8ZmV/kRdope7avP2kGVN/yrF2pfoHlpgXUhemGXH/NjeVvGhYT+0UIi6KjXtEDIFK7o+HytkIZI2/xAxJlV6qQpF5+WAjmmO6hNLUoqWY6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555435; c=relaxed/simple;
	bh=xU/eJJDwfVKsqyfsR+yJYpzrB55y3rXpkwlcbr9NQo4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J0/oiCU32Q3xfUjNauJY9sBkyyTtDfoPhCmfVjQic3PnAG/5lTzYNywxNDFUJAh+HXL8DbKw6wliUlVAoOSdLOGJ+b1Z5QDT0McbBt+9ngs5g9TXVSTDxSM1rwCY6sSA2+yhJ0sdAWiYv8GzP43FTTE7534EVnb1A3ZJYH/32/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UhMgZ19c; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UhMgZ19c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737555434; x=1769091434;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xU/eJJDwfVKsqyfsR+yJYpzrB55y3rXpkwlcbr9NQo4=;
  b=UhMgZ19cuoIkJj6RPIELt0cHDdbvskrg+BrEAkntAORyxL3W/JbPMr+x
   znmy8G205YMpUviESwRa1MIkh3ZiL3VMQcNZeYPDHtZVf8k40OdIQMSY6
   lUT+NdZJhLcvVnWM+v9owxx0XgY382H9oPEuP2aDnv3cOL8ppWgLQeAbn
   W+K6HZOS+Rj/TOyp8WvFNXVCP9XtfmPOIMZrvRxuBaKMS02RpBWyo0F8T
   B6HpOBrJMH1QdjDDTn8tniOHBdkKFa/34Go6tbBaxoCG2yht32+fGZBSh
   u1EPQtNdJMP+FQDyVO8/ZnJHizQJaEhrGgN8+thixUCWO8JFTBqXi78Vr
   A==;
X-CSE-ConnectionGUID: Xud+WUoGTmO3H0gtY5T3lA==
X-CSE-MsgGUID: FUArDCHqSEqr4DE82+dKRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="55431901"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="55431901"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 06:11:34 -0800
X-CSE-ConnectionGUID: iLk6U6LWRD2JRLnIKPT2cg==
X-CSE-MsgGUID: MV8n1GbSTM250OE7rlI4Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="106958027"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 06:11:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 06:11:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 06:11:33 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 06:11:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ds4ADuSDI3zMEFxom/+m1aR64JXaBaRrIABBqixSuB6iW19QDs8ZCupXYoQTEaiS5hWmrvNi471ZETK126vFY9v5+Nk4AscLmkf8LP1xWoKCYWxDrLe8xLvCE8or66wNhkFbJ+hFz2XGJ9A+7jMyTtpwkQ18vobsW/pF3RvcwwR6Ua+zTkecAvuB1eH6PPFC3D2DRYjUORTVq42QBs5dm5mdNj6Fk19ZmMjpH9Qx+wOOeXTq5mTOZk+F5mH+FkdVmFmnD+JpJMseQzyPW3fkpZd9eFdykAwZzUPkMnJj4GGy0zH37JnWfuGehnAOpoj9YilDZ4HW710pOx0nmNpqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/kGuUmPKl8tYZMBpENDx3IrImhxoRP+xjyXtCyXeZc=;
 b=F6G+NZbpUbkFaeU4rcX7JeYg4fzLvKbYn4LID6UX2ouKg0DivKyCRac9xEEMN0/5q47QrxSkV2gf2KpDlr8vjr+jbdTa2OISNojzCcbJixhlNankluwZVOCN3ugY2wAAsn973gokfyua9B/C02u00c9FNzjP9VP0aJGm/77VSF+KypW5ZBwIeMQOBnOBHXXMHN//fKE8LqrPVFff59XbhvkChfFMQvSi1WryjPF9c+yduDGTvujge1pmLu5hWKGj8behT7blLYgm5/jC4aaLeMhr/L2Pr6YNCjBg7bNRPK9BMtsUwDQlDhX15TNBssZ8ln5lo0ZlySeMuxma1D2F7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB7991.namprd11.prod.outlook.com (2603:10b6:510:25a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Wed, 22 Jan
 2025 14:11:25 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8356.017; Wed, 22 Jan 2025
 14:11:24 +0000
Date: Wed, 22 Jan 2025 08:11:20 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 1/5] cxl: Remove the CXL_DECODER_MIXED mistake
Message-ID: <6790fc88b4b09_1eafc29451@iweiny-mobl.notmuch>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753635601.3849855.5582594127330525596.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <173753635601.3849855.5582594127330525596.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW4PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:303:dc::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: ac550647-6bea-401b-faee-08dd3aeea73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tSwmqCy2CtpB36kky6vI8R6vFsds71EiSt+ORdxu648Z8eZmyqot66nqUppO?=
 =?us-ascii?Q?YZobO6ZJrZTqA3OTsP7QRrfXyCTHdC+uGGedBFHEYw8R82dkPgimT2oAt3qa?=
 =?us-ascii?Q?n4NqKY4EoWHJ4Lx5Y2MwtK3nKGnLzwgpNGikcpcsV5ucrzsnYGBRmqUl9yOo?=
 =?us-ascii?Q?RT4djgBBLSFf5fqvbij37sA8WaJ10IS7NDyEi5Wj3WZrCVZQxNGGW5zlGivC?=
 =?us-ascii?Q?Fx8Pbd0o77fjARWNRDKIZXgLstaE+b4uVebLNf4zVXa74VaFM59/FBQ1k7tj?=
 =?us-ascii?Q?mOjF2el+BVvbnKk1n8CkxT2HnH/h5c9fvN2WuFfk/kXTGSyX73CXPCdRGONF?=
 =?us-ascii?Q?dsBzPAJ55ZJAtkOp/UdAEgHgR8+y2XisJ0oYI2Q7UX/ACtQJ0B3Soof4qtId?=
 =?us-ascii?Q?TvpcB/Rj9HB/CXJosax2+Rpqq7l963IgRWqykRRPr9djVSCfUll+7N0RdPAw?=
 =?us-ascii?Q?qHooPzJUenu+6ZD587jBwumgqXph68tw7h+XY3Jo2CR5oaTLDcdeMU1ypBmR?=
 =?us-ascii?Q?VhALDZyN+Tugli1cP/TZBR+jEjE3hwXBsHkBrRImp+kO1UNihvy8+Hhg0S8H?=
 =?us-ascii?Q?5WzdrFs/cVWaPZlrRUlcY704vL7eXiI6fw4V99NZKj8UUnttPIUwUS1go6P/?=
 =?us-ascii?Q?5mhtRHMfW/Uez+7E/gQ/PLslmF6aws2jssFy33A/y4EN/yv/W5kQB66h3uxZ?=
 =?us-ascii?Q?GQ2UvPoTql+3LFadKDt2K7jflSEBeynVsnSAgOwPVOWOUg7rxhT+Ric0YtF9?=
 =?us-ascii?Q?6ymaYgu+UQ9DIDW3zqQXBvMVOJfSv3uDjz+3mrij8WbMQhvHkAHoZ0EQcx3U?=
 =?us-ascii?Q?BPj8M6VBrLEA3aCDw9RmZBKe07YJpDWXxHLpae6AqpCnrhjymKjHtqxKTCyF?=
 =?us-ascii?Q?HzGxKzHIBipbJtNFhqm5KcCSYyHPyAD6WFyjUIa69xxYABa2hq5yT2G3p2lk?=
 =?us-ascii?Q?g6PB3Igumz/hbsUA92R15AUidUFTwoZ5uvXZMUFJxjbNT2YGPRRJN3ysmKpm?=
 =?us-ascii?Q?7xBm5tO1AxWq4NEHKCyqvw3NzjaQDZSQz81X/nceNwxDI3D1XKYU9kjUu/1E?=
 =?us-ascii?Q?qEafQXqNrY+SKuT5sokoQOVVU1JTa/THfeC2atLoMeqwtDa3m+6ER+Q4YBeS?=
 =?us-ascii?Q?BEyzGqznzBLdwpDUbc7nmBI2826KQLSmfAUcoMS/SvAQ4RpYL0+af11kgb2G?=
 =?us-ascii?Q?xhsFgOnbpQ84ejMoWoQtC5LAKQXFnYDlZ9EvfYnEV0Jb2sZ3vnDzt/ncWLCn?=
 =?us-ascii?Q?ukb3KOaRUY96J+EU3C68jOR8WSP2iwRzJdYzwdKCBhapxtw3gn+IvZXneey9?=
 =?us-ascii?Q?aV5vJCQTvCb1lXhqdNIvMEgCsHggFvvOtBnY8KoJw8FOrpIKKS6PiRAaBmJr?=
 =?us-ascii?Q?v4hNReTkMyV7o+Fdk/6/voXj7zRu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NbpfUcjjiXtGaBz2PiQX8W6We7/sOGEMTjBXgA+AGRkzstcD9sc53yIMkFAK?=
 =?us-ascii?Q?9FH0a8tR80I979XBOGjIQo3ns4wkOZAaHJkPUsOSJBoTh/+ngU9788ni1cFb?=
 =?us-ascii?Q?enfMss0gXvP5xqTMhn/tZAWSdyob9nE+hRvFiincyMc0lOHGTTjzq2pSyvaB?=
 =?us-ascii?Q?fHip0ltzWgtOTxrhoUaTQdlu90GITpIOTAE5Ebs68qUwwoQ5QNO1Vu+2YDlE?=
 =?us-ascii?Q?hAY6WIEs7CDpPwywkKzH5Ciex4aYxVYYMpv9LSF9flSGcJr/KrnFq54Q02vK?=
 =?us-ascii?Q?AT4OG7tY5aqifzg/Rl67uzG/5ffgJBcermeJHcUmW26tCJhYycYv79F3mK7G?=
 =?us-ascii?Q?mcKn/K2IozH6QxRbSfG96l55sDeQBDgwzKo0X7pqGXlk5arnrPz59/mUcwFB?=
 =?us-ascii?Q?4MBnX3PQvUJ3bIsjfSvv8JzH2r8p6YoplrLZiaMHbKLboZwDQjdF3Xib3u1c?=
 =?us-ascii?Q?mRFj2ne0jUpoyLxsKQOzhgPFAsYlMKM6Df+Eeq/IPurfh7dNSJdKVNMcK1iS?=
 =?us-ascii?Q?d6y/TxntXQPmlw+aPvhq+n0wMV/vAPB4d5ItRfk6PekRjdjKJ9PNkbD1plyx?=
 =?us-ascii?Q?BASA31iLv6qzew/jYx3TwiifBPUyuUUOMM4Rpa+0Re5rh2eCSpp4j1PupLi/?=
 =?us-ascii?Q?hvGyady8P6anpRVhx+TAGkcfLkeSUSywFJOxFofOateC9QkZ0p6cIud4uSZ7?=
 =?us-ascii?Q?7XLfwxWcmMjhORf15rruJeEJA18gDPlQsWBC/4FpFqtGeqe5XVlciBDe6N/F?=
 =?us-ascii?Q?rYsLr5L9zMb8dyZUqbd3k2ALJ4k3VyagjjndKWi1v/53IXsSFilWNHfrvfGS?=
 =?us-ascii?Q?KY3hGmifVMn6UYh140vvmi8RKeV31p+rnj/tSCPcxULrWbC4ksoisp+7ExlO?=
 =?us-ascii?Q?+phDWQ0y2astBsvaYpk5dWHE9gZhnwIkV76GZuFLrEAtWax8QJK+1roWoQLS?=
 =?us-ascii?Q?P4bVcT/v7IOM7yyRdWeTFoLB7BVHssLJxHKLrWPaloJ8aADtcaSZQgjgCoJ2?=
 =?us-ascii?Q?74mhG0+gQz/ut/pmN1ZZBurYyKDmScJOs91kqFjt9fuRHUZoas9lA+XoiVMY?=
 =?us-ascii?Q?MPXmtBq7JXzKBkAmbsQTKS1OH2vmW2X91NRbBLyyowXGXkumBjOvA48tOxvv?=
 =?us-ascii?Q?mCLlueetUiGwjIxatCPT9mLbwxoR52OR0v0vS0uSMw8+0gDQN4GDKK9Vw820?=
 =?us-ascii?Q?pAuK3CkbA2EMyKGbiUNRCCujV8TWf1QqFNaA6ajOwqx0m6B2tfUNblYBJvR0?=
 =?us-ascii?Q?7Jonkef0qg0IBjTgdFZizqMDeHstEOGWORVauOVFMk1MZhQ7vV2W+WXflnh9?=
 =?us-ascii?Q?NPMhcaIs2Pd9RbAdENNzsLDSkmuh6xh0PsN+1l33xBzOW3dnA1V0ZUqMlZcb?=
 =?us-ascii?Q?e0fGa8FbkUoqb9EnVk3u+WrNXK7JifGH5Ly6ZvVX6q2+1eHUY37ca0l7FUqH?=
 =?us-ascii?Q?fiqthU0oGyujrPivmlP7SaRJ+Br0sZd9Ig47IjNwQg2+etrtomRT6kJbbOzS?=
 =?us-ascii?Q?AnKEhaPr6XeP4S8bTefs9YSK/6vff9nz+rtSI04KWguZ7Nj4xzFHFzw3EL/l?=
 =?us-ascii?Q?9mQcdF9/pDxLIKwjfBdGigBYOngZaO8bKx51yGbj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac550647-6bea-401b-faee-08dd3aeea73c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 14:11:24.0809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYKNTGU/nxk1v4tajHUKKqMcVFd2zsF3etlJaH1/Rcz3FUXzTwl7diDQXye6kpKqPqc3UBeu4tR32pYPEA9bTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7991
X-OriginatorOrg: intel.com

Dan Williams wrote:
> CXL_DECODER_MIXED is a safety mechanism introduced for the case where
> platform firmware has programmed an endpoint decoder that straddles a
> DPA partition boundary. While the kernel is careful to only allocate DPA
> capacity within a single partition there is no guarantee that platform
> firmware, or anything that touched the device before the current kernel,
> gets that right.
> 
> However, __cxl_dpa_reserve() will never get to the CXL_DECODER_MIXED
> designation because of the way it tracks partition boundaries. A
> request_resource() that spans ->ram_res and ->pmem_res fails with the
> following signature:
> 
>     __cxl_dpa_reserve: cxl_port endpoint15: decoder15.0: failed to reserve allocation
> 
> CXL_DECODER_MIXED is dead defensive programming after the driver has
> already given up on the device. It has never offered any protection in
> practice, just delete it.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
