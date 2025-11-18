Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D99C26F2A8
	for <linux-cxl@vger.kernel.org>; Tue, 18 Nov 2025 02:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431306; cv=fail; b=AN4nV5+o7Aa5r0fzpYvu1wOr350WzsNxAm1XCYlyTAXFyCey+ZtCNU5Fykhn0p1ON14DxanDz0txjpVWAmEfLTL9wsHWtzDajNaebjAEw9xlWNfhdbpFPDmD1RJnqU2IhiiJaCZV6sG+lXaHUwad8jYLFEtCXZd73LHHR7gYyOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431306; c=relaxed/simple;
	bh=FV9v21+J8Ez5k/vj49+cH71uqjZ1/14VLtfDLbMSBiQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fC7hBPuKdn1IL83UlbmoQwlFOEvTd2ycfGRwTyVf0ZcnWMTKlJvDOTi/8sbiyjdPQeThlllxi94glgghivqQsaY01BEfj7+9wg03Lef9Gf4S0ZzD5Kw9lTsSNQNXKNcnDpuQH/7nrHSykKzYkJx26otEozGspLSSyMQ23ke6GJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0lcuDZ0; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0lcuDZ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763431305; x=1794967305;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FV9v21+J8Ez5k/vj49+cH71uqjZ1/14VLtfDLbMSBiQ=;
  b=T0lcuDZ06o4n757jAz7+H+vokbn+6IoqFzYURLJyBSzg6HW52v8BgPjl
   hfwvDsxuwLzrZVt6KKaTsewYIx8IqwO+0wZWtUE5E59OtDzRYJ6FsrthS
   7AcP2Hva/F+URHJeVSezdOFiwHnZ3s8oq3qGDTY/keUWSrf8YYoSyhXvL
   tZDfZt+szJrJP3oQWV5sxt0LDIGuQ6z8UTDHyxeFoFh68s++Zj04tAI9M
   imW8KvYFaR888UbzDBCq/XyAZar+FKhNEqN7PGMLAQew62r/gqBpI+kih
   TaGEebMWBuddoN7cyRr6XY4kMnMf8hV/XOD6Zl5MscrkqqeFGJZrgWx4q
   g==;
X-CSE-ConnectionGUID: IysL5Rf4RD2ti3KNvhiz9A==
X-CSE-MsgGUID: LzTf/z6dSHKEquhOPUHDNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="83069828"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="83069828"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 18:01:44 -0800
X-CSE-ConnectionGUID: wc+bITlSSrOT4OJlJRQIWg==
X-CSE-MsgGUID: c9l0Vgp4RjOz3mrKmpvroQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="190776457"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 18:01:43 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 18:01:43 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 18:01:43 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.5) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 18:01:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftIdna8MYF947eWXUruJsLoU1oOisiQ8NQWrfvIkr+DzJyTjznCveLfK0ARzD1bUIimH4BJJoUHKX/bPCB7K6okhyeLnktzrPP41dKfzKUN2uJxjlGhYWLXLtWMjPPKvmp19fXZp0VbbCWF0PgWa5ZSl9vlCn7SnS46iaFBwC1hFin/gvzU92+DATCUAFLHXkhqsnbas0anbS8vdk580D/JW+aMdZxX4vPcmmNopQ8iVRytWnkQIfd81tfOKPcZaxxwbh7WvwQY0R9X2gm+2TB+RFSFSgoswriFGmBppgC8fVfNXtFzoExvPsV5N+ntDBcRFG2osJL2GGNAMi13uMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEZTE1UbmvwK9zXphIgfOPssPnHWfoRjX6qM4wi0PDQ=;
 b=hzqoTJSDEXFK/hZuQBovcYnK8oG73pRnirHdFF7pEHxe6EXuOXfmQ9YtwtX8ofYMSSN1hcmJbqm4m5PZdS6MNb0f/gonRjjAccuG0rma3q3ptZAi/QNDp9Oq5/n6O+EItrrjaPNIdgg3NF27YnbAPfrG3rNQQK89tonKjdiaCjpRdW06MSw7pIac+se522ZKlBwx/2ba2zR4ZoV797IF8qpByC/9f7Ccih+EQaLfOudW3+AcBhx9MggUfQrD6FoCJUNnRkeeaIZmtI4VVPS3OrY1QWBUbbiDCCYXZlMD5eW4sNzT4UzlC9vkgc43ir1u4AnQR6kJmyHLMkXO+Zu8Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by CH3PR11MB7324.namprd11.prod.outlook.com
 (2603:10b6:610:14f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 02:01:41 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 02:01:41 +0000
Date: Mon, 17 Nov 2025 20:04:06 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/test: Assign overflow_err_count from log->nr_overflow
Message-ID: <691bd4163c257_5df310096@iweiny-mobl.notmuch>
References: <20251116013036.1713313-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251116013036.1713313-1-alison.schofield@intel.com>
X-ClientProxiedBy: BYAPR06CA0070.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::47) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|CH3PR11MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bfb492b-e66a-47cb-d6c5-08de26466a7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eULkwPbydt8WDoun31MeGGzVn+YljoUX2ObG6/4ZLvwNL/4gBCzaxb5xeys8?=
 =?us-ascii?Q?+4NhTXpQF0QiT+aG1KzsdguAS+i1NJ8J5Fu9Wz54WJEznvSpyTHffNrPlek+?=
 =?us-ascii?Q?BquUml0cR2HjxpGdMf3AquLxlbG4YYSnnSPzrqBsVT3zckTyKIuql//u0mJa?=
 =?us-ascii?Q?TJM5ImCC+ao9EIO9Z4QNULzmagLgxsL3lOIQmU4byjOBG9u5LpCSltcFEawi?=
 =?us-ascii?Q?GYFu5UWddfcbQFKMOUBGbvsII1r5++OmGkCd3wQ5qIeXb4neNmOyfvc814eN?=
 =?us-ascii?Q?qkNzwMiYP9is5ogE9YBQsG/Zdgkzmo81uIWdlpK5wYwPrIWUKfL8oQfGFzlg?=
 =?us-ascii?Q?mg9SIvUUz0tfu/ILdgkwAD6gQ/gqpiE6jpKBXVDn6bPjPDLjEzzbeW4RRhD+?=
 =?us-ascii?Q?kXjNCeiE5PQMCNj6Sm+0LYAsZCuhIIDRh5/OIXuR9vkIhwpzWaXUnF7f4Jl5?=
 =?us-ascii?Q?AUPuNt5Rucz5ikBB1HW65XyVW0HAI9fb4aLgR/gOkxHRCirswL6W+pGQmj/T?=
 =?us-ascii?Q?mnPAE9iJFRenwWNp/ea2Xj4ozSvZvh/CDFHFRawiATdEK0OSnDp1SzDiWPSg?=
 =?us-ascii?Q?JgpJdpd6ri82UN2lOzck2DYeHBBoZxy7vHtWQk3k0B/f9fvhLfOZmul/VBZ0?=
 =?us-ascii?Q?Cg5L+JXzMjTDJfXXHA2X/z/LY0Frn9ZNL96s+B81Ew2jz8Pb4c0C25Dp2u0l?=
 =?us-ascii?Q?dNWmDKHmqbUsDHL2ou6mG7PuvImqg9Xlv3G9zyXcbABsL04iERVYrxO4GO4E?=
 =?us-ascii?Q?esCOs8GP4Rhave4P+7rGZ06g5srVJubpwgt9kF/2u7o8CQY7zx4IucRU+KbA?=
 =?us-ascii?Q?LaUreDy9rq04QlA00uyM0CYaIE6o9369lb4h35f6IualMicl/Kp5luaurOz/?=
 =?us-ascii?Q?+iVeWLapL1ZvfK5qVG6W3xF2hyZ/9y2VsxVT3t34OhDocFnrpZQDz6TiFmHT?=
 =?us-ascii?Q?G74R/k3HR1hBKJLO3AM+9n5+nwUV6r5tQelkhTRrBgjevPTUZPOW4YE/Nltc?=
 =?us-ascii?Q?n77DgUYQc4YnKb9dZW2mEWl5eCFey/YMDFpsn8ZFnJ67TUHPBVv4jACrbebN?=
 =?us-ascii?Q?05lWFcQ1XGMUTPIGeTJubJmWH977StvO6zhfCsW8zYN+nU3qt0QPov0Wk32m?=
 =?us-ascii?Q?g9cq5H6Ps9ChsV4uUltIIJxcsfZkC4DsYD4DHsIPfzuAf30LQgaFaVPU5EtN?=
 =?us-ascii?Q?fCD7v/2xTC+TCgC0fe8p7MbtUTPgvW3Raohjm/G1+HkdvmWdIYJPBl/8XVw+?=
 =?us-ascii?Q?zV231ZkEtsHkJ/mHkZgWTWkkHfdzCOQKj+2siTG7lae523uhxRmTU+T7EzbS?=
 =?us-ascii?Q?iQogMx7gj8KW9ZViOZ+wtFsZ7FMxGqUnfwpwZc5BuKi9XCM0+fsaQ+09wZFH?=
 =?us-ascii?Q?znzkenMvRiUYmeAvNUiceAvzuxOxvnGfUvfJk6ONTmJtxxGSjaQwg0bEwJdz?=
 =?us-ascii?Q?umNKaKJrbCEqo1j+D8nF8ACB/5fH0ZvX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a/nHd5inPOkgD6i5aGpyzES1BDdWXTbqccJgNegIK/pgMAKdNuIRLjIPeSI0?=
 =?us-ascii?Q?yDf6vFMkdtitRJ289xsC9mgS0BRy8ZRvFKEoMowSv7XDpXmEtkvtqaeYm9YJ?=
 =?us-ascii?Q?5Sw+5FBCneh2/kaccrtYUMiJKJYuH5cbyboeHlRH2FU2TshZ2uPdaP74xL2T?=
 =?us-ascii?Q?0C4KgI3AYjWV9GJsDCWKeHDQGJkIPkuLnK5brA78+vlIIZyN6jRhCzQidjon?=
 =?us-ascii?Q?ecK1aOn3kCoOVLtILTrv2Pijpbn0IHVjKVTtJEsKFEBjsZTUvAnPqeqBSQZh?=
 =?us-ascii?Q?uKSp97RrMBbQRn3TRNr/3hPnZPcYvzuwl72G84r9JOQH7rDxuWRNj+IVpPHd?=
 =?us-ascii?Q?nKdE+6nITUww3KGewEPjdFrOWWWIStE5P7Uv50PGs9rOfQfwFGZBUsJgFJ52?=
 =?us-ascii?Q?LXWXIVPD2qFE1MwvS+Tc6QwaCnkwi+W4Ywq3zViHI/gLywwbEjX9Kr8v3v8H?=
 =?us-ascii?Q?rwcVUHXnpTyi6OyRoAgoc4ieK8gg9UE4e45u5eFwJYIPt2Lj966iureY8KUB?=
 =?us-ascii?Q?XcpzrXFZUngYJ6LvkkWLTuoXzXfvO2+IvknugzeFdGdh4N9s31178s2KJRg9?=
 =?us-ascii?Q?PuXw/wgZFCTBbsHZYeu6ZJwxL6PDmlyneEL5TfacMx/tQdfTQvdwtPENjPB9?=
 =?us-ascii?Q?oHp6u7Xf6NjXD5sjMzpo52ZYfSoslaM0JlMa1ZhR1Bgo3I7kAN/C2hdSYGjy?=
 =?us-ascii?Q?/vF0tt0nfySUsboLjRHNYv7CeRvnhASFjwCvrtVE86N6LFWRmW6+r6aGeF3a?=
 =?us-ascii?Q?hlRQH6HENeVykjvnYKjAXZ5fGlq4VnGoBJZw11p0yDBzOmcRewzFvPUqvgRi?=
 =?us-ascii?Q?zI7GM98TEKaGFO1lp/nZb5pxaoAuk//EcgauLGczy3RqRpTMzGppzJ7bgR3Y?=
 =?us-ascii?Q?g9WeeI+3MyClJ6zHlfdr0leMgnepnpkdjWlUNLZNUCuHLydzfc3xyLFWlrDZ?=
 =?us-ascii?Q?3vwEDbALNBLgvwTCXUm46/HKCZaiCsVgKNKqllJ6mYuHg21SiNANwfZsNhOC?=
 =?us-ascii?Q?ha3sJSGbAXf0Pg++7qMsZw2hwgeGN962RMr/fpbQqvbOMjoVW7MgKBxq509c?=
 =?us-ascii?Q?LTURV9KKW/rpUALfqY01IgUUySbmp5p1PKjBwdgYfRk+OFjUOxPIkpP7Cpg8?=
 =?us-ascii?Q?o7bxnAjO/pjhq01NOmcjJa57bWbA9m9QQnxL8QUrdsej5xpfapuXwbyJVhy/?=
 =?us-ascii?Q?5iQ4jVB2cmk8Bik3vZ2CN7U0H3F6EhxKb+u3wCzGgYwUkx3xe6WiudbF+70i?=
 =?us-ascii?Q?yfyDVvMkVgskc5a2GnvAsZPuWyfJerPHmHFX7ixTiQeg1lsupy9QH/kAyDXe?=
 =?us-ascii?Q?+2lTmzBMN+W2Pv1ajUAVSKrrvGoPe8mFHY5iRZuRU6SDqz/V6SSYqLEartI+?=
 =?us-ascii?Q?sdS88KyMbu5TWLv1o9ZSgeP4NkCaG5sxdEZt9RlQgY26wk1MBAAN8PRbckyd?=
 =?us-ascii?Q?geKsSyDPBj2cGwwmuWI6HbOc7yDCPxTP49UNmOP7R5Aa0izW9cq/0HNGznux?=
 =?us-ascii?Q?lqfvxMdNyjDpxtErxIVHzLHokgRAbLfYG1s/rVi983Go53PTWyWJED+S2mV6?=
 =?us-ascii?Q?eeNVYR3KIRwVx78iojqKCKmHva8S0/VwYW/CURej?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfb492b-e66a-47cb-d6c5-08de26466a7d
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 02:01:41.1708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAzFI6EclONFn58WwdCj/4Ru76zx/Zjf0PKveZW/1Kzp4Q7Pcng53fKCksG7gjVOXd+L3nqAijNZy2v2Zljnbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7324
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> mock_get_event() uses an uninitialized local variable, nr_overflow, to
> populate the overflow_err_count field. That results in incorrect
> overflow_err_count values in mocked cxl_overflow trace events, such as
> this case where the records are reported as 0 and should be non-zero:
> 
> [] cxl_overflow: memdev=mem7 host=cxl_mem.6 serial=7: log=Failure : 0 records from 1763228189130895685 to 1763228193130896180
> 
> Fix by using log->nr_overflow and remove the unused local variable.
> 
> A follow-up change was considered in cxl_mem_get_records_log() to
> confirm that the overflow_err_count is non-zero when the overflow flag
> is set [1]. Since the driver has no functional dependency on this
> constraint, and a device that violates this specific requirement does
> not cause incorrect driver behavior, no validation check is added.
> 
> [1] CXL 3.2, Table 8-65 Get Event Records Output Payload
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Clearly a bug on my part.  But in ndctl/test/cxl-events.sh we count the
overflow traces.  Does this still work with that?  I guess the '0' is
simply reported correctly right?

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
