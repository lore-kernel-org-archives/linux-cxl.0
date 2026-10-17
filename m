Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B2828E0F
	for <linux-cxl@vger.kernel.org>; Sat, 17 Oct 2026 00:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195730; cv=fail; b=AOYyImbuysTItWvFXuA/oSkQl8YFd5gIjaifOF3zEnqTDGZVXV9vq8R7AeVJ9/TCSTmDsETAv5f6KThV6pdXLYyN58e4txZIRdubpAuWd/s5ofy2VXZiYOlg4xMjoSG7AKX8AIvn4H1OGFzlUmzglWM7Zv13/3ooQCr+qB3bORs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195730; c=relaxed/simple;
	bh=oVZ674f2UXrHwrVdY34KBMdLJKQmxY004O2o4+6kb0I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ObokpKD7IKDQ8obFSBRWZ2ZC8WD4xFWCY3/L7/I19NT7vM5qfQxKvqXOr0OkOOI0s5smVKz7ORBwAD/BF1kf3xE+aw0xtyuVn7f+f9CFFNekbMYUTZx2PuLeCPf30AQ+ckGz8XF4HDTKFL5wGgOVsNmkvUPG7U+NKn3vtDmiE/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ius6GOhG; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ius6GOhG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792195728; x=1823731728;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oVZ674f2UXrHwrVdY34KBMdLJKQmxY004O2o4+6kb0I=;
  b=ius6GOhG2CXXhXrZxJNwpqkZKV23Qjqqm5SBsUTjk3tB5y8A2RV3UB2H
   2IJqbJp28jRbovvvJCWhGAG+d84fyb9Pyax81a7/795F//W5vkNXxiH5F
   Z6gg1SqeRiQb9K62jpMF5AdZQCC2gisq3QfszhFXZvpJ3XYAGOp07GU7O
   FEvCRPYzYHNIWy33Nt8xMZXnpMuzvqR3vv1pyh/mSklpeeBSQLi42hMYv
   C3K8NKba2ztAaPtb7Y+kEYoyda1uw3O5fx5CXbFEoMcfC8plxzvexxTER
   PJ45EvzSiSw42v+TLqY4lslaG7PKwgkSiSjUjIg/0q59A+yWLxJsUIE4u
   g==;
X-CSE-ConnectionGUID: xQk+1U1gRjiRf5YfEpSSUQ==
X-CSE-MsgGUID: 2Suf3jsqTRqpAOcHcSNzNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="884491"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="884491"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 17:08:48 -0700
X-CSE-ConnectionGUID: 7fuKCo/lSnm6nq21Dndjtw==
X-CSE-MsgGUID: nNFfXgcGS6Sjexs5vvtrKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2058326"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 17:08:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 17:08:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 17:08:45 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 17:08:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KC+4Vof7XthiiKxc2hhx2aE7b6eh/cbd5RGGFI3egu0SCOxjQyUyQ2C03EM+dtuv01oFOkEvaMByQm5+P1OcWhFEeZVYvbzar5lgZFPccjTrjzv/tJiozzsew97RQbUcoI7joexRDBl56Bb3A2Ag0tsYhcDDVtwbplR5/aHP+qIs0RznEJa1+cBpowaV63pIt7l7JR85YwLIXp0+7A5aMh8wiFFiMxiP50btnkx0H/2VOxBhmY7pga+5eqBsQ0IWE8QsTWJy0Ot100/f5GP64SHac/MstVHPsmNPlaVciHEY01Hq32DMkYu29K0QFH5pc13G4DxD5vhcgFERC/EaYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lz1thGARV7WHN6jwjv/1Op9aaZMr5n3Q/aHBkJFyJaw=;
 b=bvQLqF67DHdycrl3sYyGxGKpr4df8qHS3LzrGXTCJ0PAQsUy7GSqu3fEOgDRohEvWDqCjeARP9XzQ2pl8zfuqDjhvnzEcnldsSBpj+cbnYMiVp65Lp2p34clkMSdorG9qDXGIxBXyqNN1/VU9F+zO6olyo7bGEttKM3nR+uTk4pdVYpQQfCwVSI3PYcgvh7ujm1/9rMp50jCvSyit9n8nJUpP8ermX1fPzje2GNEVNCULhKbOZk/rea5v2ffxQ6e0wHkRzfgBaLWWZXOkMsYXJClDztNXzZ4KAHQx4oLl3iphsjaMpv207dYMI+4HjpPzV1IYyu6d+ckf58MdF7fzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW4PR11MB6571.namprd11.prod.outlook.com (2603:10b6:303:1e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Sat, 17 Oct
 2026 00:08:42 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0522.013; Sat, 17 Oct 2026
 00:08:41 +0000
Date: Fri, 16 Oct 2026 17:08:38 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Li
 Ming" <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>, "Robert
 Richter" <rrichter@amd.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 3/8] cxl/region: Rename cxl_port_setup_targets() to
 cxl_switch_port_setup_targets()
Message-ID: <atK8hp1DT_glZHT7@aschofie-mobl2.lan>
References: <cover.1791676454.git.alison.schofield@intel.com>
 <6bef106f136e813b760fa7ab65d419fa4a1b6922.1791676454.git.alison.schofield@intel.com>
 <9a583963-6274-4539-a546-e05e3965d3cf@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9a583963-6274-4539-a546-e05e3965d3cf@intel.com>
X-ClientProxiedBy: MW3PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:303:2a::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW4PR11MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d4a3a7-9fd3-429c-24be-08df2be2cd26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|11063799006|4143699003|261009223027099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: ImMyJHXiI6cVkfC7UR/QxxmoBKyTMA+Wi506zum4T999Bfn1OD8JENDqVdh7lh42lVzD987Y1slMsBGJ0jCgLpV6k1cFd1kgiHkBm5E7DRHdGMYaZE+7zAeQcmm3WJbEAiPfq8SR+iEztgDmJfQ8L6sF90sZEvxW3cXc5bcg9MUYP5UtYP92kCRPFk00UVVLtX9quJx/NZMWN6mUH6UwTYJrLo9CzHU3ob5WrjU3nys6pHIf5BSYXO0E8YKWLQgJ0F8jtgCib8Oll4Ma3D+OE7dqsSJGI1aNVCjifInnSaIJdozpmrMS6yI4yfQWCB8JeKe0wQIWjnRA7CegkWl2mATbkqbNTg0DXDl+q1kHrZKpb5LwkEvd2aHMMyf1Tf9Wj37HMg91/cJh+21zWgHis0qewvEaO0iiaCDJsEsXiI1I6XBHXAMe4JtQFvUoru5Z89u0+LTTpi2Fpyh5UzH5iSDOixdtOhG3abdFUhbJuy33LlD+WUcgEh4Be6UMsDxltliTz0ZJZxGjlHS4qT7sNFYQw0ew2P7EyMeOHsufqwWtDB/Sy++f8FUk4OXSyalamHZGuPbA7jly+4V87Xl/1+uwWHqD534Cb/IurpAIdFfR5iy0tWsOy5BWtpzjvTLX7goeagbC3yq5VZWsmm9wNvXmyEFthYeiM+ekwkgNV8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(11063799006)(4143699003)(261009223027099003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2AmyE/NLkHoIGb8n8wFG5nbL1HTMIygI19AP1zXQwtJTyoftqv/N/kbP06sZ?=
 =?us-ascii?Q?WsMFGwHSasAtlZoNSwvoVlPypC7tyV9Pn9XEnG+8L4+LwzPjSXKS+7gn2HLP?=
 =?us-ascii?Q?MKe9wmgQERGzJK7BmED4FwFjLyAOai/Gfu6LZ9S7gldEMto7szuEIIhkg5lE?=
 =?us-ascii?Q?qjCO3mK70oF4hBmiAHAR9A1HNHel0qFxw8PyjH+kRzD1XdX7bMXu87Bpgiw8?=
 =?us-ascii?Q?5ldKNrsPZNCJFxlASuVawv4XMqGNZ+gfSBRBOTyU39NNF4caMEqlzCmIpXXw?=
 =?us-ascii?Q?r+gcWupiJ6E8pOfC8QLjNZLyAttO8Pf9zAyYttglrXD3TLS5paW1hTQAGNUt?=
 =?us-ascii?Q?pS0KL3L2oAm1rlyVm3r9Navt65LE62R+Q8t03nSlrTMOZII4mW6GYl2tPt/Q?=
 =?us-ascii?Q?kdb8ISF1TpdutUiE1+KKDmTTrOqGzMh2BUkRfZD8jCFGjk7c4sDnt2jt/lrd?=
 =?us-ascii?Q?8yddfjM99YXqBAeR2bVMAVfV878z1oUwRoonorOhVD9x9/XCbBPVB2A4zFjJ?=
 =?us-ascii?Q?M9JVbJkqat3Uy/hwcQX35jvtni2+Aj0+5ZEb/AUpNxaYzafE7Prn4Xxh/1iy?=
 =?us-ascii?Q?GiuGIJvNz4lRRCieIKrIrGbR0LrpuKo96JnnMTFwebjvsUIwwle6G1MABtUV?=
 =?us-ascii?Q?Lb4d+IspsLKTEmd2HwyNyioFgVJHS+Lv7u5OXvXYJdRqNUJFP8qagSyeq7/O?=
 =?us-ascii?Q?B5tPDocAVGQG4zk3/UucEooR5/NXk1dW4viNBRD5wWUFyUTVrz/uYXKFsWpG?=
 =?us-ascii?Q?Su7VkHYlvHrkgHyWrS3sxX0PZwQ7mKipwqJXwJZqNNTtVwMsE5ST7oT8G7XC?=
 =?us-ascii?Q?KjsfBUrN+HcIqeajjDePbCP+lxdNH16doY/YPkgFYczDktIwtt9tFsVfjkbl?=
 =?us-ascii?Q?97eAJZrbuXn/qOzOs/QwLGYlaKKU1c0h/1L4S0MOISMYMMOu+kpVpFMz6IlN?=
 =?us-ascii?Q?Yze0Q7g4fxas0fxgDITz6i7mBM7Ii+o/0asmbxJXxqL29NIo9t2xbp5zM+a9?=
 =?us-ascii?Q?fJQxLiKLAbg2+aQU8Q8acSH0OQH7rxYWWA6URuzegMSaHU2InrmGuF4R4VxS?=
 =?us-ascii?Q?bXxoQvHK5oRV+sYsBO3qxUtoHyMxc8+NkEqmSL3VMtP/i5OXPEIxTr0XeNn/?=
 =?us-ascii?Q?kafJ8yEjI8z1YqO7EsLqD4PR+yn91yCWgTXYONTrKjbHOBsehZ/PJTsgJas7?=
 =?us-ascii?Q?Y6bmpgaESTiwsqb1UP950H/DC1t8yzmo3c573JRgAkzN/NjRs9GLtiUBKkVr?=
 =?us-ascii?Q?DHyGaP/OiWIw7hDIbmY1rTnetK/r63Cd+XMfeZFCoU6dYBgUWKlTxXEWuoT+?=
 =?us-ascii?Q?wTHuk2PQJD7FcUqdvnN876Y016e70MVV2JEU9/8ZZ5ZFDOvXwVRlum2tac68?=
 =?us-ascii?Q?qr+p0z2Uf6axjhkeLO/+5sCbYsb6ld9TNoHLL/5Cj6YVhpxxrQtRoGwXrSnJ?=
 =?us-ascii?Q?gMNCXhtdjeFsjHjQD3RBGfTjjwhtPDdRezo3o7Cg2b0ZaxVc1ENWREDrpUy/?=
 =?us-ascii?Q?0BBcSmRDjfVQYXOZzEmMzY99/nibo6Ane8Y2QiU6vW9D70TqtZu27vRwc2HR?=
 =?us-ascii?Q?OC6zN8C2hEvLuWsIZALDFbAm0suZ2Z7EH9Ieo78GEL8DqqlMtKXGi8FNwhFZ?=
 =?us-ascii?Q?VyRch+5xO8Sh3KERp4K7YsuyCKEDFmhbIF4zQUZ3aWWI1QK2GWe818lVHUar?=
 =?us-ascii?Q?FDk0JDDRyDnAdKE5vcCtrQJ9QT4cwCeZ/EYmDygLwKw/yej6lhHT+rW+bj1r?=
 =?us-ascii?Q?gqb2ziEKvg4GaBiIARQYeba0roliqAM=3D?=
X-Exchange-RoutingPolicyChecked: fTgtDVVZZWwZMTyN93e+aWgaGHcEUX2HRx0gbhgYfIK955x0ILq68SzYmJ+L/SmnZ08DPMo6zZmvobrkjIA7TYUJfKJyPTR1C+m55tzp/vC+Vsv/qMezy+LOgP0ggJfPcXhUKZKbvKufkMfelesBSNvpu0UytLZv+JYtPGHlRILxnEuhsSmAIypzMYxvEr7XxchEfDLA/VDDX1RYCNaI6Wxxvt8B8DI35gte3Dfj4hdhZX+x49uZ2daGPPHjaLla3yXp7qD/3hNZihpUpXJDsK+hT+MERUNpvGSMAIRvSlxlxXAdVAM2ELbubQxy5l57M8JhJkytKUPhZXj+4rOJtQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d4a3a7-9fd3-429c-24be-08df2be2cd26
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 00:08:41.7110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DuWScBdi0z+11W6y/CEawjMGdKICiV3VFTfjcC8VyGz0HDXFOnRCye8Vf9/N8jCAr7To8uB9nZLe/QzK7oLSOeFx+AQ3PpbHduTOvg0Owhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6571
X-OriginatorOrg: intel.com

On Tue, Oct 13, 2026 at 09:45:58AM -0700, Dave Jiang wrote:
> 
> 
> On 10/10/26 5:20 PM, Alison Schofield wrote:
> > cxl_port_setup_targets() configures the switch decoder targets for a
> > region. It runs for each switch port, including host bridges, between the
> > root and an endpoint.
> > 
> > Rename the function to cxl_switch_port_setup_targets() to make its scope
> > explicit.
> > 
> > No functional change.
> > 
> > Suggested-by: Dave Jiang <dave.jiang@intel.com>
> > Assisted-by: LLM
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/region.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 1a42753fda48..d564443a1d39 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1432,9 +1432,9 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
> >  	return 0;
> >  }
> >  
> > -static int cxl_port_setup_targets(struct cxl_port *port,
> > -				  struct cxl_region *cxlr,
> > -				  struct cxl_endpoint_decoder *cxled)
> > +static int cxl_switch_port_setup_targets(struct cxl_port *port,
> 
> Pass in cxlsd since it's a switch port function? That would enforce the type.
> 
> DJ

oops...overlooked in v3 but picked up for v4.

Thanks!

