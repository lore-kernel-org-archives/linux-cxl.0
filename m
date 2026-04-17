Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0101C84AB
	for <linux-cxl@vger.kernel.org>; Fri, 17 Apr 2026 20:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776458153; cv=fail; b=Z1N5Ed561Bxyp3a8xtERutL1MIlPTk6Qz1kEY0amwTLjMbPWiUL3UaYNlnYXoAxlr4L6oqrlRa507FS7TGNoj8nGiPXGaoFopGNLak6mSY2M85VuPmFqHg1ZPEcPez85HE2mKikfmQZhqIj15KjkAKcYSyq9yVA+vcTSW9En2Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776458153; c=relaxed/simple;
	bh=k6dbtG41cHsjcSzspYG68HMKVZHNMAlgTaQc7MsYpB4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rw/j8txXvrvPwpwNZ1bKArRS5CLKZhTohx+RFZ+rfKh+YslFoJ3NVuPCyn+X+Ii5cHDBmBQoUZhge1CUW4FQ/cuCTG2/rzu42M6CEN4Rcy6+5F003rO58fOoY3Mf2oQtbsUVnT1D2hiIJUPsAjl/XzAeoQeednp+KK9RPbL4n+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wq8AWhmC; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wq8AWhmC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776458152; x=1807994152;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=k6dbtG41cHsjcSzspYG68HMKVZHNMAlgTaQc7MsYpB4=;
  b=Wq8AWhmC4ZblKldFiWwmhqQngA6+l7wFrz2Yt1Da7oR3gEH0NONY3D7m
   zWu1c5o2AeNeEiCHkPVgHvnnbPkNc+2QWa3M1ujx8JRjgJRz1RusFQvc2
   fTMkiYJN4H6xJGesCeEe0vZe77l+MfXoqDIcjieJGyIPPywjIXaclutbZ
   iBmhbhnWbLx7/xeMCLcsZdln3uNeNrfv+qhPgnLvpBrI67p62Pz4b3pfz
   7IBpD9mbpk76cUjaJAIqgjxNEvmPf748VVVnl1xjz2dePaZdgJTxXP/b7
   HgV+MWyDNoOZnjnRmKe6ILeC9NZ8U/6ZfrMwS7ApPhyL9KB8AcwLlbwjc
   A==;
X-CSE-ConnectionGUID: bQVZB0+dQo61egUc2SN0ag==
X-CSE-MsgGUID: DP2Su3P8T2qLVfRCmohlRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="100126851"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="100126851"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 13:35:51 -0700
X-CSE-ConnectionGUID: CssTGppjReitXmRyPEHRuw==
X-CSE-MsgGUID: C2PVXAA+Ro2CYVhW92f3IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="226455802"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 13:35:50 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 13:35:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 17 Apr 2026 13:35:50 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.13) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 13:35:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkoZu3dlBRoBDXLwFMjLguYysG//hNHnl3nZ4IKN9ygBxQHbXPEJvhI6Ms37Aq5CHcBPk1eFCQmrN4Il9Jtu46LXJMzuGAUZihqTgga9LVggILEccuiyS73i2dctgQk6vABI/xEy6MSsTTrHuUqdieHK2tdqhZv2ZxwtW9oBbDFRuuhfLzZkMDYuRcrsAfvasPUqh2eegg0sQlrAJssWX15VDhD8Sd14rgnMta+FfjEYp3VfPFYBArMAjoXQ4TDr6esD73EVisKerGwXGmUvi307wk3HAgkbQPq3e3SekJSZT2/O/BCtQfQptZC1Q50XHM3GZDGt000Mjt4OnsDY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VioQHenHdTas7lFmDiknQpxQdPmpiNpni0hknqnId8A=;
 b=JiyA9ji0760RFIeHW2exv7jyUMGUFVvdV+xjXErziZcyAeImqh8da4bxlul379pe74qCoPPuqYr7lvUgEOxwMt7yoWmSgbRRodRH4LVSUIsf/TGXlTQYMhIkhxvGvCWD3oEvYGdsQeQ4F+LPqRWdhz4FpmF1+jfaK02ETIvnns7awsnw2YOm1lIPvNGmMJ2Eoki1CGEN7Rzf1MUQZ4w9PYp223XD8FXuOEZveJRB+chHqmFWfjqL4wqUqRvEx1/yAVGMyKOUCuIoBW5C5ZK2RNT6j7hEYWCDeC4d/fpOQ9SJUM2gcytDRS/5S2OsYRztqT6QGSjcRP4VvXwnXEZzyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by BL1PR11MB6025.namprd11.prod.outlook.com
 (2603:10b6:208:390::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 20:35:39 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::9618:33dd:29ce:41d1]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::9618:33dd:29ce:41d1%6]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 20:35:39 +0000
Date: Fri, 17 Apr 2026 15:39:38 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Anisa Su <anisa.su887@gmail.com>, Ira Weiny <ira.weiny@intel.com>
CC: Anisa Su <anisa.su887@gmail.com>, <dave.jiang@intel.com>,
	<gourry@gourry.net>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <linux-cxl@vger.kernel.org>, <djbw@kernel.org>
Subject: Re: [PATCH] cxl/core/region_dax.c: fix missing assignment in
 cxl_dax_region_alloc()
Message-ID: <69e29a8a9264b_5c5981005@iweiny-mobl.notmuch>
References: <20260411011137.43545-1-anisa.su@samsung.com>
 <69e17d9ee2924_52a121009@iweiny-mobl.notmuch>
 <aeJrI1S5omou28MQ@4470NRD-ASU.ssi.samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aeJrI1S5omou28MQ@4470NRD-ASU.ssi.samsung.com>
X-ClientProxiedBy: MW4PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:303:dc::10) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|BL1PR11MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a72efc4-4eba-454e-2d33-08de9cc0e335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 36h4+APupV+qm+6vz3oRrlTaL6G2DN3F3RCrLTBJeZpDie9d3GJsqrCl+Qi8i6riOfzc4xrOrVuoi8fIJoFeFRga/9Z3a1WTD1NZ/ZEnYkgs7KBi34vi/+FePB+hPRnkHuWW0alTd5bxqTxEyRQa3B0UKQBVWbF4TvQla/NshwblNir1sMfp6giLCmtuq+VBc+6CecXQI7wL1yh3+wvbsNKQ4vB8x7/pxDTE/AqHEaah/E9xhsaJAD/HOUknTXUp75NWu/iC5Y6hgozL6dupA5EAskaf3e9LxeEHSMI3YZT5mkHVSqSLG9wUTHx/vYCYIYWCqELgUXwK2luUjm/4tiSQWkIPBeE4fPwlhHTD1OCVme+YSRlyhVsDvx5BomY9f4DNnXjcPjZSpcMtXvgvPEGjE64kKZrB6H6FRMxvCSMxXyRlKRzyLJ5drdhGV7jmQXblJWbMin9kvW2klNyo7/begLZpwG17tFpXAMQG2GFmrbvjKB0zAilIPrBHVAd/bVTYdX6U1jbIsnHe7P619InkNCUBC7vwyywiNF5VhL6cWE1fp3On1QwytvgnSEWxCSMhsi9ovyRU+RI6Jhu3OzkhIRi7JN3ssxKKyuFaY8A6F0xdVUKntAGxvdbaMrdBgzo6au60qHUNmGAIs2raIqaIGAfspNaONCJZk4XFxw2X65oB0PA1lP+VJqqboqFF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1jEA8RvQWFGWFt2SI0pb7NYrLiSFqaIWbQx4JIeuu+EMKEPVJq7J6LWW9HbS?=
 =?us-ascii?Q?Sp2voqSecSaD6/PJIrOaty+Ls6BY2lqVQDpVpkJasDqVj62/PYImZfLyh+l0?=
 =?us-ascii?Q?1oaMJ6S6SCfXDU3nhh8XJNRpmX/7v/auMGwu7lYGZO57BCf42iXqjMdCkNnb?=
 =?us-ascii?Q?Og2ow9YRiiktWgNjmn0bzFGO58FK70KqQqujqhayB2NeZDImX+SHKXpgpAEU?=
 =?us-ascii?Q?+ueWtg8WQSqzk4TiRWI3H73n32MMz3vo4r+MD5HKTt8HWW3ENnWdgWzqKLYW?=
 =?us-ascii?Q?/O5OgGE3j/VoEZrzjfSftHfnSGsa5fgwBWjwHa6idGChOLUB7XlX0R90lQL2?=
 =?us-ascii?Q?kYDEKtzsBhbxmP2dHuVrXtm/ZoqedyBCiKwn9VCemU3oip4/r3FgrJJfx12d?=
 =?us-ascii?Q?/f7uI3LhtOb7D3b5Rp3/O/eNSpNxwAAk4/1Sbu5MwQvdKJd3Vsw0ypR2djSw?=
 =?us-ascii?Q?oV2CvEsl0IBFi44oIwPtDvaJPUirGMkF9nzqtF7IhPbVAps/YJsSTXKKssHW?=
 =?us-ascii?Q?pV0s+Rx9H9WmWM74AtOFhXH0btaKtueb5S31OPFoE5rqQtWKFUTWqwU1rFoz?=
 =?us-ascii?Q?AMgkgp6CTdj8kd7swATKHGvD1vCiJvruli2HPg5k/ryK9YH6Z5gE06bEStTQ?=
 =?us-ascii?Q?K61+hCwLRE217ibBBK6cQEAcM7dlDzI3Pl8M+BK6OPFpsDDyhMvJrI9bcH9I?=
 =?us-ascii?Q?7kq51mD7NRgrryvK+4sp7a55ie3SXfInjr4LaItg88Jfis5WMOBkqlzjuBog?=
 =?us-ascii?Q?U+dLLLGX3Mw/sZ6ar2I1Ov7qZqXbMNRqPbjXKWomHqcaBhFt6PBHOGKts0LL?=
 =?us-ascii?Q?DVikPgGx5QJ6GCTQ+cqvp71Uaa1ByYUH4RnieUXk1so1LbnQC32iwHbDdr56?=
 =?us-ascii?Q?ExAJ07jBW2dalnNWNMnx5kN09PFAjxT+otQfPQTyJ/105mHlEKCab2IbOTXr?=
 =?us-ascii?Q?1ro95ybuz5N0IKkBzSZtsxScn6s+V2oYDdNm7U47MqUmMvjj5PmpX7cd9Unc?=
 =?us-ascii?Q?a9lBTJMPXZBxLPSimseFIUP0VWEZG92L/ZZXohMMvym2NTIaJTEFvYuzr58u?=
 =?us-ascii?Q?ty4IIq2bwnp8FIzcw8YHXlOdBtQ2JsO9tp13q3JU2RAMyPMQkZBXCPqc1Kuv?=
 =?us-ascii?Q?MLVS6TG80WX9c/4xSelPgwUk7rdc74HGbLwNhRrvBKWWuUo04hQ7+hEQatXh?=
 =?us-ascii?Q?re+IrN/QX5GkNnSiXsHfwNkx3Olz6nGfFyv56bOGL9zZvw8wYt0I6YXTupf4?=
 =?us-ascii?Q?Kf91v8LSU8VCzJ0NmEiDrp7mM12+x1Hp3/GD0foanVYhL04GktO04JQqYJZZ?=
 =?us-ascii?Q?eYIKOvISFvU3POZRqUsOH9WJwcTibgfvH58yM1Ear8CR6OY9fHAOhZg52rxS?=
 =?us-ascii?Q?hV1UP2s4Zh4ZAzqYOV/n+R3VB1t78ar5GR5qanBuR9gVLHba3XtuNO9ec0gD?=
 =?us-ascii?Q?Dv1gFLzajY9M6iXaS8CWa5Q7jMKbz/KUJAdbYn6sbTUotixBdnI2dsdoP4en?=
 =?us-ascii?Q?EwmH+OnnchR5Q0X2lIHaYbBKcS4Mh2Czz7SjQ7WLYC1WaKkDWJy2XG3uZ5O2?=
 =?us-ascii?Q?JguSwkkCE2V1fNKmstDXHLKTcyiCnYiXMXqAAr6j4/0ebr6Q9OtMnJvNoj70?=
 =?us-ascii?Q?QboeHQxZX5ZVlbzzD4/o5n/fudi3PHdI+WJ84OQqvCLQoV5RtxNgmAJcI8nk?=
 =?us-ascii?Q?PKA2fvg2nSbxlZeQ6lDccFV5L2txPzQdcuvQFwCpzZv+1G5DS7Gl0DTs5iOs?=
 =?us-ascii?Q?iYXwJ2wVAg=3D=3D?=
X-Exchange-RoutingPolicyChecked: gu2a9+g8UO11htzgCdSpS5xjDgLYTVI36UJWhd8oPejbhngKBf0eu3OoTcdz2prhSATr1UIInb1UeeFxBfaAmnnrbCwLOASspb1p5cwch7LHr7pulm9s4sPw22v2n9W36gKqBkXSJlzh8G8HKi8gs9gllTJbaxXUvDFNViQSmvPYZHFLvS3K3fNnrTql4PYC3kOMhj/HH7SocDdauMpvMyzjhDk19+6HL8n4QDE5GX6BZ5tApJ96G5/cpaYZc+/hDuGD4FSttvvjOKq/36WTedtoPlv+iNatAl/9dy9F9/78y8ebxBDda9Lx2dQsG58LgelfmllLaDUtKLuPLo3unw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a72efc4-4eba-454e-2d33-08de9cc0e335
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 20:35:39.4746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bn2vno9+5/w0HNntUB6bwp9Esy04XXDfUNOiMg3+bQ8Gh8CMly0AY5d/a2K1bxmWduCI3NK8cEAQyN2zqj+kWA==
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
