Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4625191F91
	for <linux-cxl@vger.kernel.org>; Fri, 17 Apr 2026 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776458101; cv=fail; b=nADZRrePPYn72ZeiZjiu7e+q2yfrtki+w1DqsFcWs/xfg3MJwsEsG2qWFr2X0rwjimKtCRUDrWW3gNKCu7K8G/4xK7yJqUSuHczp3Y358ICRpOIWrWQzUcdYzUp5O+VsNqy2vSWj4LX6MSj3VcUqbTUP/3ba30qBHPLK8H/V0h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776458101; c=relaxed/simple;
	bh=k6dbtG41cHsjcSzspYG68HMKVZHNMAlgTaQc7MsYpB4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lhS2V21VeKU+rqGjgMYnDLyT8UAMuUvExo+JIHRJTboe2gtcudg3BrbPGVUyhVQv1WEFSFAdaQSbAzWnATgtZb9lnhkOK4Rphsj1yI76/QOyhATPJHc4SPyEXo+aSPFqBVHnqJ+kwYUVeZ0hspLSr7g7MJO+Ht7s4r7cnaJYP6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IxqmrFF6; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IxqmrFF6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776458100; x=1807994100;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=k6dbtG41cHsjcSzspYG68HMKVZHNMAlgTaQc7MsYpB4=;
  b=IxqmrFF6JASoi/SnPbXiSIbOaOUJLTw9UYEVe3LvQxwGDJk/NAlpyPPw
   5URAGq//gZA+5eLAXXflDm2x1s+mZHxsXLKDhlHPeO4JrD8B9a5/V+WGf
   su/gyh4+oX3s9nrx8KJOnHRCODp/dCtXZBbmFqwzx+ZeXIWoIMfsqDW9b
   kbg2wM7xOoeNy4QjooXneJ1AOQrI/MClBFP/xf0PoKg9a5FxWq5Snlh+2
   CLJ6FkqnafpXfKtjUkg2W6WUSBmHFsdKXGxHJkQplw/G/iUIlpVvo9gai
   T89KRGW8Xo5CkrWll49SRzPEkSyNsZj8gqpO97AvXqMc5lhIk9QpEHu68
   w==;
X-CSE-ConnectionGUID: kjh9E+2VRvyInEhNqd5Ggw==
X-CSE-MsgGUID: 7KO3efvKT2OL0bgIKN7AXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="100126831"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="100126831"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 13:34:59 -0700
X-CSE-ConnectionGUID: Cu16SfaBTsGjVlNmmMnGlQ==
X-CSE-MsgGUID: VCCZ+Nq8SPWkA94+Fz0TOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="226455623"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 13:34:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 13:34:58 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 17 Apr 2026 13:34:58 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 13:34:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXPGj+MEm8CPegGMrNJFi0LKjRSFV+BmsesAfvDdW9WBp3QdXtVUuzs/tg1MhQLAAalmoMUqdmhk43HtuKApPnT4ZnNdBz1qKBNBv50jI9U7UxWgKccWVYZoz5s0WQ1wT4jwHBWt6cOxURpcyDFMM8tmCIqd2zpAdjkRXDu9ebcO1BVVj2oSpTV/YtE2v7XcwAFXzXniIpmyP65Kq18E1lQub+UOK8/tjj8Sbo5u2VfaFTkxCn6FRmrh/Tp4TA4nNquxWVXSPJpgjXlmgnS9sUaoMrvxAIX8x6FNKa6PVCj+Urg/Iterl/zY1FhgsSWkAor7r8ZWBIiiztXTxzrliA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VioQHenHdTas7lFmDiknQpxQdPmpiNpni0hknqnId8A=;
 b=ise3UocQbMrzXXsr9jNpFZVeHg+vwZK2aYiACoW13prraWXQDZaPlKiiSpG+8E5o4cuIJ+FiCGGzO9orcNVKJP09ESUV+n30eV3ZaWhVs5CGRN1rVyNx90fBwGQCsAxqgpSpHQLBysg+aj1Lm/qiphIIR2gzZd6fHnx2nF8ZrZnroOEQROIFGb0DbogxgcvU7ygg5PB4iyiQEZoHxgwluvS4prWUns8ohCiEX41nNgUgI4soeZXHbnkmg27rf6HQNAlJOiJ3DDM39Nl78oOgEA6T4FTBgrGDRi0Pi7p5hkkDTnzanbHYtfEdaI+mLsMByXFzc10Jwd9Vu13Tc4iftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by BL1PR11MB6025.namprd11.prod.outlook.com
 (2603:10b6:208:390::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 20:34:54 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::9618:33dd:29ce:41d1]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::9618:33dd:29ce:41d1%6]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 20:34:54 +0000
Date: Fri, 17 Apr 2026 15:38:53 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Anisa Su <anisa.su887@gmail.com>, Ira Weiny <ira.weiny@intel.com>
CC: Anisa Su <anisa.su887@gmail.com>, <dave.jiang@intel.com>,
	<gourry@gourry.net>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/core/region_dax.c: fix missing assignment in
 cxl_dax_region_alloc()
Message-ID: <69e29a5d39d34_5c598100f4@iweiny-mobl.notmuch>
References: <20260411011137.43545-1-anisa.su@samsung.com>
 <69e17d9ee2924_52a121009@iweiny-mobl.notmuch>
 <aeJrI1S5omou28MQ@4470NRD-ASU.ssi.samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aeJrI1S5omou28MQ@4470NRD-ASU.ssi.samsung.com>
X-ClientProxiedBy: MW4PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:303:b7::27) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|BL1PR11MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: 356a4b04-0c47-4537-1302-08de9cc0c842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: zwxI6wdP5sPvtbl+lPv2wkLBfeDFKCOAO+VHNewmwKegsKQ86Tljd4PWWFYT7O4s6Eigr9jvqDuw8mtxk+UcmwJWfvjSLdJ5hHxMHNO+YUvX+4VcR/wDeKfsggabqA14kUlp8e0cSExpNHJl1wz5P6ie7idNUXWHbyUqKKGw0GGQLeprdUmIGkyj/Q3lHq8kIrxJFSfPXQO/zZWd94SCk+2RhxQD9WPBpuaTqocNmlrYGrg1tqYG8HOouw1B1HJ/H+LKX0owGNLlQxmVerNKdfNEK3irZHGWmO/8Z0f3SfNTutnek7ScOvs5pGTNFJvpwzfC/OdveUlTYVQjV0qFSEn4b1VCP1z2SfeS+EOS/uli33HvxW2GUze7e+AfLeqB9uGrBiX2OpGGJpjn87h0jQHAWb9VhlO75ph3lud8xTjW9fwYFfPCvD3bBelENM9C4lJsKwMz74T6aJ0VjVtKXTYbd017Lh7+zaGJuOOkWzryTyhDZa90qEpMtSQioj2BkD+Cv+F0OzMUrb/DFuJPDvoY0DejRJoF1MMICNX5rvgbtaqSLvdzIm4jzqAHysoVOfO9u/Ndj+wf8KBlYIWPX/kuNjldjL/Os8H+kFdGUECJgmeG5ifIRpWAIFV4wSDLILjyLqPEjgK0O9jmQcXurcDjzixMmhW5qE6IiirDSdnVlxgzNtXejFOkIHq4+NUl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4utcLn3AUJERLInRRRSeBCKj8tneRCZsRxIUYsOnHhUuJtVcMopra42R/OH5?=
 =?us-ascii?Q?3Wvn5DEurTAYGWawq3H1OzXsGtjv7P5qO34Ues7ieSyR/gPmkWPnE87G+RXy?=
 =?us-ascii?Q?GtVUcFpgC+nJExOrkYNeIGzdGlitY1WtQV6bAY8DQd91ZGEbZvoLvUDZ5dke?=
 =?us-ascii?Q?ap0nu528q7uQ37r0FT3zyacBeA8wP60fZFyaD+tzFNNNV00n5wJZ4Mmsolt/?=
 =?us-ascii?Q?z/haerEWwTz0ILsNR5YOKLe2w7bdZp5Javv8VOwV0c+AlTRxbLyGKUYbvqlp?=
 =?us-ascii?Q?edBeYrrzvErBE0MRDS5xNXmWrwEqft4Flwo3USADnqlN0dW81Z3pARnHJdcJ?=
 =?us-ascii?Q?zsuAHsO1HyX8V0j1RhvR/PTcD9kc9UbtDjedOdZfSn962J6M/7RxPDAih0V4?=
 =?us-ascii?Q?OtoaY5Pgn86PMC9KB4l4JEckUl6D3FLJQkmzc8Kgtgw1f+eYj07LV7HYFqUd?=
 =?us-ascii?Q?ZCQvrCpwrGFpPuLMFogzhm3EXs6dhfxzzDSl6Zdz68DPipG9S7KhCLh1mfQL?=
 =?us-ascii?Q?7wspR6dFzU65zMO1qBwey3Nt/KEJ7HzD5GlwjpA1/lznjSQ5jUA91m5MWsJd?=
 =?us-ascii?Q?OZfv7NAKbFi/5Tip1avVCZlTTEt1ha45ZANCfbo9BR5xDiP7XjNvgXcxOsAJ?=
 =?us-ascii?Q?HyxLLe2AZp1MomIrPXDSckdLwUJxtSq/PSrDjfzOcxW3VUSnxPKvMHHPei/j?=
 =?us-ascii?Q?qlppmtOpqGbPXARg3ss00cYamQ01Mq0X8wfVR3FXIJED6gJJSTLUGHam8cBe?=
 =?us-ascii?Q?vNXdL0xFPlnGL8Yxi16PoBgqAV/P4rXa5CJR/9YWTeWdkv5gFSwoZ4MBIzv6?=
 =?us-ascii?Q?XapZl5ZXwk0RBkyg9P9NF/f0Adqj7sk6AmjmWsrzDODmT/An7JIhIh6CAHuu?=
 =?us-ascii?Q?IpY1fNQLu4xUsTSNgGqYryvi7VE83X5ItUTuF7okly1x+RNGtbkPS3QbgrKp?=
 =?us-ascii?Q?EjXlDmpY5TrUhUr+94SQsabesVpulzturDZqYVFZtIe76nrRCiM9FADkSOUC?=
 =?us-ascii?Q?Nu/4mXvMgtBKcV20CLCTal6qsoh4bNLhoyC8zMtbmJL/bPVdl9xtSlQHjkAD?=
 =?us-ascii?Q?uNAL8p4rzO8t2T6qoXbtpixMeBCmj5aRGptWYxB8a189k9qcE0ctYMhC9/uT?=
 =?us-ascii?Q?52D+vg9LWd0NgUbKH1qksE8Dyby3JNYbkk3UvZEroLEf/pE1sK3H3SwnrwYz?=
 =?us-ascii?Q?07WxtoqUZ9D9Rod6rXhvaF3nhf2+RvbDM7qbB4i1FKNoVIoG9TFB3Uti7qLt?=
 =?us-ascii?Q?9j0ogNUAqW2OPDsUztGUh2C0qn+FIAq5lX9kqVK6KPPGPmAtb2P4GpXm+V5B?=
 =?us-ascii?Q?Ocad22rjs4NVW+eH/qQcYvPzzmqk7ex/frEm142Izt4Azy3ZNox6SHY9jzAI?=
 =?us-ascii?Q?jpm3BqK7OtmOid41Slz+bIxCiajkcpv79IEiWC8lANPX3O+HO4Lf4ny6ty56?=
 =?us-ascii?Q?1MSi0tXJDJlmDR+OtHTQ6hsa/aiV0DayEDA8ZdM+1lP4keAnGWXkNlINf5sT?=
 =?us-ascii?Q?mFzxWw4rBDmM4GcsR7sLBCik0KCAUkQV8oP7DmL62BRd7JEAVqZSLO+/10ge?=
 =?us-ascii?Q?KXszJY0vaonWmxv8MAgSAfHu3/2coEYtGbyj9Bnrea55oCLOrZEm+JdVP5NY?=
 =?us-ascii?Q?avPv6SM60DHN1LMC1Ehk7aG8vk/ihHhV5unhSZKrVOXSqoKnCvNHuqr0stY2?=
 =?us-ascii?Q?QB6cHRBGImzNDpwPOYYpPo0dMwAY+uZhJRQJ52TtbUsgtVXh4sg7jhYbUio8?=
 =?us-ascii?Q?Ip+GhS4kGQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: YocwDUiN5QQQItt25bVgBmZeZS1+MNna6IQpFMeaDFq3Oc4r6zw+v/mtSFiaTZCuviR0YB4t4iAPWNh6NzzlhsF+fQ73UZxBoBV6cmMqLEy+OaQMcWW594D17BQ+c1hGqh35k/s1Ys126y4v1pbOhmkxxkvuVn49LpHQ/rHqcM/OjXFiLgskbYEr4u4EQ7/fV9LFabiINLoGa0JRjgPHUl6OsWJj3obRCHrkWEOsVjEYF+nYqchJiw4VQt5dncGTB/xqFpgMrCUPAQf/uquJkHDS5EJqqxlHI35s3ulHPWd/PPZk8M3KXUhDjZffQqXEmwu2ZW505yYMUydNQzwLMA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 356a4b04-0c47-4537-1302-08de9cc0c842
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 20:34:54.2307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7ok1nIfLBZUCFvQ+72HSRmWTCiD3FgXcZ/nZ339bCNusOrw/Bq7zYvTnjSTk42BDlQc82yiq1GmaNlOP8yobA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6025
X-OriginatorOrg: intel.com

Anisa Su wrote:
> On Thu, Apr 16, 2026 at 07:23:58PM -0500, Ira Weiny wrote:
> >> Anisa Su wrote:
> > > cxlr->cxlr_dax assignment was dropped during refactor.
> > > 
> > > Fixes: d747cf98f091 cxl/core/region: move dax region device logic into
> > > region_dax.c
> > 
> > I don't believe this is a valid fixes tag.
> > 
> > Looking only at commit d747cf98f091, this line does not appear in the
> > original function...
> > 
> yeah it's not, sorry :((( the assignment was added in the dcd patches and I
> dropped it while resolving the conflicts during the rebase cuz I was just in a
> rush to finish it
> 
> I realized the error and said "pls ignore it I was wrong" in the original thread here:
> https://lore.kernel.org/linux-cxl/ad0hJ1q5Lp5mckt1@4470NRD-ASU.ssi.samsung.com/T/#u
> 
> but I definitely should have mentioned it here too. anyway sorry, just pretend
> I never said anything

Got it, no problem.

Thanks,
Ira
