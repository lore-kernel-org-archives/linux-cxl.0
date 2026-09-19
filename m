Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C33F234964
	for <linux-cxl@vger.kernel.org>; Sat, 19 Sep 2026 00:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778612; cv=fail; b=W5D13ZZsOLzoqt8NxYdRQrfGD54ScQXjFnM9eYixIE/V5qTmIzQbVzCtw4DKcyYwwnwNFZVFHD/b6+NhOc/a/P8HI2AaHi0o2hb5BQ/tHwyIWaAHXUfTmZksGhuUjp4S5P/oS7wWyFrYGbl6oqQHzk8YNSLA0muz2bY63iXFcj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778612; c=relaxed/simple;
	bh=WJpU05toOWUQNefc9rUMIjoM8wbFWQA/8Y0+TklFsRM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OZBda1gK7bLavHnpGEyyUYoxuTXkZBzfBLHh/E0B6i2BZBA3B5qjLzPWLs6kBMfj19VbjvngWRUV363PgeRugQKalSIGyxM8d8hlJpSjpi478oSa5krn45iRpLnzcObpt0NLVJJV6E++qAjjYDyEk0kgTKw5mL4DbL5Xu0ihxBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g50XoVlx; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g50XoVlx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789778608; x=1821314608;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WJpU05toOWUQNefc9rUMIjoM8wbFWQA/8Y0+TklFsRM=;
  b=g50XoVlx1QDhfCh2Y5AWIqsXbppzZcHqdYw+7CWp9OF4H7GMAJ798ROY
   2btyeq0GcHNjjOCyAZXiD1Riv0eavyRYoa1cuFI25bOyw/57KiXc4t789
   /YTnxVxx1PBzSas5R+a2iEPZxHu/ffLIbniJS8mAgM3zYu7tqeCzIOomT
   G2jO600GBn1w2UwdKCg9DUrAJJg8ggumEjixfXSp+7k3Mug6/lAfunyjN
   NOId3WzhuRWSQLsmoWdl4Wqch5q0soR1OHr7XTclpPrGFqJZhOHkvTPlT
   qhYIhA/S4wytlfBqOcNRM2UuzCyAPBWmCYm8bB2m3HQ7FfShed61VdIH/
   Q==;
X-CSE-ConnectionGUID: t+xJprqTSvS3ITlC3xGcwg==
X-CSE-MsgGUID: YgPtcPC/RKq+fGmPx4YDWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="94145506"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="94145506"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 17:43:27 -0700
X-CSE-ConnectionGUID: 7/+Bp5DCTtmmLIONpcXPDA==
X-CSE-MsgGUID: Xn0dynd0RxeKdiSi+1cegQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="270937473"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 17:43:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 17:43:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 17:43:26 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 17:43:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=as35N0K/1NyUk+wczlM59NanUvkfOhNfj+eEh4lOUe0+9e6rx7LNBqAnBFOcD+CKktD9GsECTSP2v+ldyojti174toi63eQnm62j9HItX91ToH0UmstrFKWY/Mt14z/oKdCMfejQ98eJmd9slDNgvJZ+FlMGq/IIvPvPExtYLM5Onnh+d1QgjQxuX+lYtwieS3IokA1NhsGWDgoq6L0MoBXp99d6a5jyVGk810gwfpPxY2GB2ybKb1NzEyTw5iyoFnZ0jfwyQic4irjjf/cJnsGuBmCKhLx3XQM00W29VFKHXIzOX3tkfihQe7X2u5B7u7/QEFgh+fKnmmP0An7giA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNXSDfw0B3okSZZ+yU5ttlKhZXH/r6xyCQbZJCXBLFs=;
 b=VYZp7rS38whbHIZ6vpCU7r1R85Q0nfB1jRwtC4ZIMQcMDiLIN2cjsmwteHSBDkSpJ5JH1tb7iw1ehInmko8uaU7chJbI7iV6KZw4XF67Mbz5DuFMuSEaTVhveia9sAm5C535mo+SpZXnYz+CCKwSi/+M6vSLDicEWaxV8jpkBBoGPac3rdOLhCp0qaSwsaAlDa2m8LLt9ar8DaJ+omJJJtfh0b5qFK2ej3sO3MCVfDK5SyNoi9YxKRh4+w1gw6j6SB+8TrpWaB72HEFOmyvyS4Bi0km7VhtwOrdm1R34EYas2quOdtIX9jkfb2VAHSJsix8hdtgyWDSrd/yBYIan/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS4PR11MB423842.namprd11.prod.outlook.com (2603:10b6:8:50b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sat, 19 Sep
 2026 00:43:16 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0428.011; Sat, 19 Sep 2026
 00:43:16 +0000
Date: Fri, 18 Sep 2026 17:42:59 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Li
 Ming" <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
	<linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v5 4/7] cxo_ol/region: Name the interleave locals in
 cxl_port_setup_targets()
Message-ID: <aq3ak2bSyo95N72s@aschofie-mobl2.lan>
References: <cover.1788475206.git.alison.schofield@intel.com>
 <b3ceb52dfb0da2f164b941adff60d2db6aaac9f1.1788475206.git.alison.schofield@intel.com>
 <20260908005049.32763a31@jic23-huawei>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908005049.32763a31@jic23-huawei>
X-ClientProxiedBy: SJ0PR05CA0155.namprd05.prod.outlook.com
 (2603:10b6:a03:339::10) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS4PR11MB423842:EE_
X-MS-Office365-Filtering-Correlation-Id: 28208d17-fc45-40e6-7bc9-08df15e6fe5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|3023799007|11063799006|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: sgtHZYx/2PbNnU7Q5LcrxZAAu1nVGppMjm1SAMRAesgAkYyBUE1UVFSMXhieE9RzCiSiuE1yXnrGhCx1b2IPVfZTCJ+oiuzjHrE03FbCbhaNv5vcdFMRu6RY40ed0sAsGvfvQoNLZ7gO57Sqqefrr2spQ3gt0Iqesl5vswn2z1UagIn7/BHwI9KLUleCmNeEzYkbkKAuhBA7wvg/mzeGjZ1QDNLRwLVGi1YQwkcCMWJHfxU9I21o7ZZYOXOi75/in5EPLLqg1vZdh9tLlS/HULab5WDpJss+JZb9mKaQ8tgyXDFrFhsYa5uet0LCnVWRdatzli9Jh3c4Fog0e6JDr77BbV2fAJoZV7IoviT+KgAX2khjHQhnHzPBw2+k7TsHgQAe2RYDkz5o2Y1Qa3pFI7478kEfD+CTybtJ4sG6NDEhp+rwsAgxujZ0G7WGtkUuuahbNWtiTjDXNSWwrCyn7PvOcoZH/36y7cgXMAOqrvr/MipzyCefSy17EUePW6loGNJuNiEcqlsojVmOuWXSkFafue6Jedzsanu+ozdopCObiBnDG/sPWuwK6tdQn9e4Lhz2GdWwusud4bPe8XWPmp93OdqcT03xnvgBMYzPjGo+aSr9JSGyeffL+0rtSKRTGGKz3dn1fEsd4YGlWcGWTCaq/Aog/MHArATwpLhXoK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(3023799007)(11063799006)(10067099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GKj2VwqcoFjJk4hO2qjyV1lSpQ3+qMOUHJ1ZsyB8ZIBcuNvzwZLXltWH9B77?=
 =?us-ascii?Q?iQ48B5q3pkRkMCn9j8vmH0Ls+HG8p07HRV9FpH5m/4HkYsHQmWbbkfXQW78m?=
 =?us-ascii?Q?4/DoE0uDiDsDLeqsZJ/7z7Gcpwi3fErPV1amZrw3RHS9pz7EEPsYcZ9DkA2D?=
 =?us-ascii?Q?bBZT7aWX9jlc6eFJsvZK0RIxDYvYDkhU1NtIP+xluWTOo1EINGFmsMT+llOt?=
 =?us-ascii?Q?3AnLNkiLmC5WSgYrc4Qsb7JmnvEEa5oNtsibZB7A1xeNZadL+OI+GvRFcz4e?=
 =?us-ascii?Q?4dZ5RiEd2Mz5snG54UUcBbK9LwW6BzufhxHljLcyin/pflW2Wvqr8A+jCa1G?=
 =?us-ascii?Q?fH1i2zUMKgJS2fti12blUDnVWFihuHMe5TH5hMLeRSpK6lLtBkG+cTA4NDYP?=
 =?us-ascii?Q?ys1QhIbGxO5bChBj45154pRbQMQcUJspD0hvEZyzcpzmth5vMG+jeuxcNMYI?=
 =?us-ascii?Q?HpFhYlp7MP0TvaZZiNP7L3ux1Cc/BIFO9LUYOUBKekEH7VhDaHWh1t2OG9kB?=
 =?us-ascii?Q?AtCroJX1fHLNGnZE0jmyRmCAb/v3El4XJgmnhJYqnYmMLqscmkqWQzjbUi6o?=
 =?us-ascii?Q?g+REddgT1duNboqLbuicqxbjaTx7/WewkBqiqLM5suLywFfEKRaVazuqjg3t?=
 =?us-ascii?Q?pxvLjDslBsO4FxJRcUTSPmdhyVpD0xzzpMbqWp8x5e6uTGWQe4OSUjfo9hUQ?=
 =?us-ascii?Q?mYKVWmKs6cRvnKRsKjYGstNpee+rdodI6rJiaWugClnInXyAfVVlyEIy75jW?=
 =?us-ascii?Q?tz3bKVWyv9eAkyZWJeNgfLSbY8wk8CCh2rlOCU2+PAzsdgE7/BPxa+xn5K5Z?=
 =?us-ascii?Q?K1sEM3CRdx7R052TPzShb3jk3mwPwXK0sfItTNTDvaB/IV+10Klanvv8nQWz?=
 =?us-ascii?Q?MtPB6wR2M0VEc6OAQKdOuPOSNFxkPPr1LEvi2eWI3UZYOLkphPiJElzsXjwM?=
 =?us-ascii?Q?JwzVPljNZvLwPK7nyu8r77+Ps62I8rCgjS3rPPU+HK2JzdFMNrgtsFk8Rvbf?=
 =?us-ascii?Q?EEFxmwuZJb5K0vSk1knYmmfSrjQejfTglfYmhr6TpVduAGhu3F41DpPXVtCe?=
 =?us-ascii?Q?y8Rw41IfjukX/DrYIalyRwi7mnD3QFzqvkwCqZfukkm4bQO0a84suBST8Ek9?=
 =?us-ascii?Q?cJuLvxPhqvB3R6HnCocdDCba2MnlGGlNfP0zRyIg3rpoZukiRA1RsJpZeX7C?=
 =?us-ascii?Q?MgzRbmYPUAzi2xQ7QAHEcFhkRiZwwzhGSNxQbsVqVikEUjlGgDWKCoWGmOyK?=
 =?us-ascii?Q?mI17BFKire8seO5ruH2jTmLeidvoqITx7LPTHiaL7KJUfBno/bIMSSAW8jAa?=
 =?us-ascii?Q?OYjRjpRh8iNpC7sBnMVbL12CRnPYpfxuA3gAW8d5jJo71PXU3FurMJBJDMaM?=
 =?us-ascii?Q?ZiJGlCsBA5L+LhcUqrAelpUR6DaUIKaFSfxtodV1meTIU9Jwtsh5XLpl45Sa?=
 =?us-ascii?Q?rJX4drRCZlkeDXylzijW2Vn+dhC2v5juM1C5r3u2c2iHbdy/0OFd16iFNKi4?=
 =?us-ascii?Q?Dl1WFi9fxurF7qM7HpmEwiRYK08XuJx/ug7YpaNpAxhGvgocSTlnCLI3XrpS?=
 =?us-ascii?Q?fffNLd+YoQRDct282dB2Raa7tmKr2gUWAhUrGu3uHcMLcPsiN6LvAAY4KF7p?=
 =?us-ascii?Q?hKHphxWr8SG8JtFd6tEmOwyKU0t4GJ6odUEVTUZCOFnpG5EvjED4sHYVjaDd?=
 =?us-ascii?Q?dw8L+zay8mQsamKTzZuoZMh6mFm8iSHoMkLxvUKmpqxBVlY/mbk1zz6h8CGO?=
 =?us-ascii?Q?M/uozSZjfMu1+8tAZRYOL6MF+NMsYhE=3D?=
X-Exchange-RoutingPolicyChecked: C21GO+12DAqT21CrKc0sHVcDIfjd4xJJ/nxg3BmmBL0RAlaXyu0EtLFUpMCQ2nyJyVo/nv0LGfZFQLVRrbopmUjpTUGrmdjIECh2P0b2U2DtQVX8mDoiJzYNVYywZqnSmse7/9uMLsysH+yJn6q44rK4kd6Fud3T1vBL/SoESpB7Dpb5Sdpk43ja/K+JyfsinwHy3VvF+oIAuGyepq/u5/Yndg/Q140lr1h2rEFC+xXiPfMGn4XSq+DFyT8rHbNU4kmye6+QJIfyt3Fl60O5iNgdPA3bOgUteNJWYNimjpZ9jnSVEVvOfdaeZegEZW6k0xVf+mmxfuHDhHOZ5h/DpQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 28208d17-fc45-40e6-7bc9-08df15e6fe5c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 00:43:16.6200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0N3LALcrEcAPAZl3nJuZM5JHah0/MG90cy7z6cSHhCqkvytVB0Iaf3V6+VfdPm+K2+R6P4PAw5siJMDVE/EXzX5PlD8negYay5ZcYEjU5TA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB423842
X-OriginatorOrg: intel.com

On Tue, Sep 08, 2026 at 12:50:49AM +0100, Jonathan Cameron wrote:
> On Thu,  3 Sep 2026 16:23:46 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > cxl_port_setup_targets() derives the interleave granularity of one decoder
> > from the granularity and ways of the decoder above it, and takes that
> > decoder's own ways from the topology below it. The values from the level
> > above are named parent_iw and parent_ig, but the values being derived are
> > the bare iw and ig, so the reader has to work out which level each one
> > describes.
> > 
> > Rename iw and ig to child_iw and child_ig to match the parent_ prefix used
> > for the level above.
> > 
> > No functional change.
> > 
> > Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> I was wondering a bit about having ceig and ceiw but those would be
> very local so I guess not worth it.
> 
> Given how often we use ways_to_eiw() not to make the conversion
> but just to check if it is possible, I wonder if a ways_valid()
> helper is useful?
> 
> static inline int ways_valid(unsigned int ways)
> {
> 	u8 eiw;
> 
> 	return ways_to_eiw(ways, &eiw);
> }
> 
> Maybe similar for granularity.  Would remove some confusion over whether
> we actually want the encoded values or not, making this function more
> readable. I didn't look for whether it was helpful elsewhere.

I like your suggestion!

Since it makes this patchsets code more beautiful, I'm going to add it
as a pre-patch in this series. However, I will watch it, along with
the other prepatch, and will ask DaveJ to merge it ahead of the series
if it gathers tags.

There are 7 check-only call sites, 3 want ways_valid(), 3 want
granularity-valid() and one needs a eig_valid().

The impact is where you were reading. cxl_port_setup_targets() has
4 check only sites, and we can clean out 4 locals by using the new
helpers!


> Anyhow this change is good
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
