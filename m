Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C252810E4;
	Fri, 16 Aug 2024 05:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723784830; cv=fail; b=BdbeEVZz5qBSwDgGIHJ4IXc+kbrcBhzIDX2RIEsS3ZDLIYhxY0WdYfBMRe5AgcVNKPSoIPKI3lXSypUafhPSP54+DXLwG8ijqPveOePVHTLbhvDfUlLveBsPMO/wbmUSSAnAcodtGKMNEhafkkBy1l680cKXqWp4wR7vCCseTQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723784830; c=relaxed/simple;
	bh=5t0eTMhvdyZPiCFg5+BxE9xkZ9R19ZL3bs32n766DXE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lB0uu15At8QPgX88GkOnEOCpuoyzPHpBZmdT9AZf7trg/pBEk9Y13u43a9sSgiIQv1bsM8Z8H1izbXtnPDTZKZZzhVTkj1oChY9nrfeTE+Pcnv4FJTlK7P4CpxNTQSS2L/fqQEG6dFMGunDH6OR8Yxebip1B/zpdgo/aXoHY+gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPdixScl; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPdixScl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723784828; x=1755320828;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5t0eTMhvdyZPiCFg5+BxE9xkZ9R19ZL3bs32n766DXE=;
  b=RPdixScl9Y8DEwcj4qJzwXvTKy/VJO95qXLdtY/kmEvW5Le4Z+MFrHT1
   ItqoW2hdCaM9iEK2ETZ9eM+i2iraZnT7v4eK+azr3Nk14Gwk7OkMJtoLj
   ahKXurWcOHWPSS45SG9DFZT6fKEryfjmIxH3CThvx0j9b12rGZeUu+IK0
   pJAz8nX8DridZDQZjObiT3fG3vH/vCoJqAn67yMHg6eF7J8CDovHh6Map
   b/ltzZgicDBmhjAxbbEGw/kDQUIzEUUozKWLIsRkH630Uy//hs0zj6ozY
   utzyUVoreeeXN3dbaEnmS+70IuMXrTF530CK/59bR9hGy+wI6GMX/IHYa
   w==;
X-CSE-ConnectionGUID: x/cO5r4VQlm3ReEq8Oh6kA==
X-CSE-MsgGUID: UXOB/lrEQSmroRFhBurpaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22230986"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="22230986"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 22:07:07 -0700
X-CSE-ConnectionGUID: uEe1k5jtRiqW6c5LiMVrCQ==
X-CSE-MsgGUID: Lyj8ZPsLSAaeCFhpU7aB7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="64512562"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 22:07:07 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 22:07:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 22:07:06 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 22:07:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rc9rBa8pPITbuEloBiGb6FuMZZlMrTFj4loTT2T9Alpa2feuc0oYIGg8cFftjbFEa89FtUxopSQtkofz/C2BU8cSDr6GIvvJJHw881a+JPsKk/OPOfW055qIn4+Lv/0R3k3RnqeenMWlrpGQtfvptApQMijPBAjzvkAne7XdNYCkSm3nch1k+sFS0bWlPD5Co3eQH3r9XCHk28QyvZOrX8hiC9cxJssmMinBj7ovpNnjFf4riizBlnvw8tXIdfFD76XNiyTbJ9wX8kg9ovQIQubAg6EKnj80HSNMeifbgMIKyA/tMn82A7E81UsNFLgY4cHTYdSDszaPfP/N9meLYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abA7QyYR1YNkfBYfedZaaXdacV67XOOntum6nAl7YVQ=;
 b=PYADX5ZS4Nr7IY4+bCzSs3WdOqyibVtjtZxpe0ivgd2C8QodJ6TQytLCMbJktVIHY0UsjIcNL/K2NHEZ/SwwW26aOEfcZNI1KKqOya5W/YsUfPPLYd7kdl2aPxjZfw1UkjB5ntlAWRSvqy1MtxE61xnAR/4PwiIuur7BBuag2ETo+/Al95G7hFjamlDP40CMaNZ3PG1MLXR0GNvxlktrDOjHEt20d8W1fh6zSpOhVMHO8qhYSSgyHOhSABlp7oFu0DSSRLnABt01Dfe+CP96epqlkNFqHqzEanOMcDaPPz62IH/O1nYALt1SCoEfqcffsHZkffr/awsUpFnnzGKmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5863.namprd11.prod.outlook.com (2603:10b6:510:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 05:07:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 05:07:04 +0000
Date: Thu, 15 Aug 2024 22:07:00 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, Huang Ying
	<ying.huang@intel.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Alistair Popple
	<apopple@nvidia.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>,
	<david@redhat.com>
Subject: Re: [PATCH] Resource: fix region_intersects() for CXL memory
Message-ID: <66bede74cb96f_1c18294ce@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240816020723.771196-1-ying.huang@intel.com>
 <20240815215302.5ed29b99e94a48aea49269ce@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240815215302.5ed29b99e94a48aea49269ce@linux-foundation.org>
X-ClientProxiedBy: MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 7856b0a5-c083-491c-c940-08dcbdb144b0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xx+yJPNJM3WGsyjby3j+txp9LT00MckcIJkzHdxXvdFT6+ebFz99NRvUUGo1?=
 =?us-ascii?Q?r92saF8qG+zi2T2S2iLmUDbzz1gsYmoi6rr1YGmDH/NZ264j9yTh9ysJKr1V?=
 =?us-ascii?Q?SV7G+BcpvjhPxv8yacFaP91C54+IHQc+7E7UlRjSxh8p02Yto7bOc+MSh21Z?=
 =?us-ascii?Q?JJvQEGH/Xspk+0nQz9QJYUD3r212ZNfJbRygOvG8miyOn6eXSiyYg3Gp+8Ba?=
 =?us-ascii?Q?GpBo1tQaqH/moBUg5ubxuy8O5lKw1YSnwtK71MCm7nlUmSnY+MvJz92shAiR?=
 =?us-ascii?Q?1ciIRBQARiJYpWWmm6WfVuwBrgXw8s5qR7qK2dPfSLIjUIImo5ux6mLwkfAl?=
 =?us-ascii?Q?Xxy/ZH6WSD+tgo0zHNAKLnLUUzwLTnOeICYFD8cBK+G9KUNm0Avw8eHba657?=
 =?us-ascii?Q?7932q6MK/xUrmAdHF4CHBfMUWhkKICBP52+P8UE95SxPWaOG5CxWOV64MJfR?=
 =?us-ascii?Q?Y+qDrN2/a36n7nGutp8OZKQ5J0nPCReT/T+pBY5QBaMAiQ0XggI567VJknaE?=
 =?us-ascii?Q?mEPkYpIT3kbd6cs3qRLbfc3AmPFLXV+kdT+m5J5Id9ySoSFcodjaVPVmgc+d?=
 =?us-ascii?Q?fj/Joipx3if692X8tk+8QlJ/S/qbpt7xhRwuaodxoaBxJKF2BFsF9bKzbUny?=
 =?us-ascii?Q?MJ+OO5DzvJCYxeHby07xBZm5yIBemWjpPkdO5nXcZ2IsNBZcoE8u4cFSb5rq?=
 =?us-ascii?Q?QEvPVO+K5XM6fWHgFlpnGXmd0M7qx3N24niaWxX4XpL492lEunLrzBwY22CO?=
 =?us-ascii?Q?s2Fq6KuSBouzSakoM7s7dXuxHky3EBnedKED09KwFZSLK64deNbQogxLLgQv?=
 =?us-ascii?Q?vVXQIU8BT1YUOTjpk298WIrJUVqFAcPSMKpHtOdBwtIkyH7XPA6C6ItqjQoQ?=
 =?us-ascii?Q?H2swlwPXB+Uvp+K4sWZBMc3SMagYaAro8H03eR2Ms4Yd/VzLYFy4oVj71U7S?=
 =?us-ascii?Q?hJhUKGjYnsYQ0oT2eQzE6ltmOaU/vkg3nntp/L07LPNuExkugjfIh04YZDJS?=
 =?us-ascii?Q?UjoYUBlQYRw2ssqxAPLIir/V5XhUqsusj+xpze3MQW8I7shHi2LCk0YStqzn?=
 =?us-ascii?Q?U4tfjrhuZq3zKeh4qJHmR8+O6/VgLL110p5W0M3jurd7Pkzw78SfUpbp/i7E?=
 =?us-ascii?Q?NZ/39dXjqcL5UrKp3rd/1F8fpcncG3wRI1+TxsRcp9Z/o+n1Ycod2LLNNQOr?=
 =?us-ascii?Q?qEmBJyYZ8eSzRyS+8oFrps7zWvUEnbq9hX+ST+kQRXNg4IFZHogTAffdYimt?=
 =?us-ascii?Q?d7jdp2YNwZ7l4hLpvnj8HIoGAJwlkMogDZp2HOplPVlsXNOuS51oEpH9zEWU?=
 =?us-ascii?Q?6xcCrqULHXvR1rbJj3+8MqlqcSfol/11/9uBiVPvXyOkOw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dncZpJTcpbVXhHNZaMnAuGM2fDrUAYJNW6kOLu4LoRUWFyILdvl+Drc38yQB?=
 =?us-ascii?Q?s8H9z4uZdFCyouZwdnstJ9NioDDdWBB6xAOJ0fwvJOyveoh78gGf7BMDzgJv?=
 =?us-ascii?Q?s2qVLJmwOHuufZRqZtnTkLNJyu/CHafLynK4k8PCuh7KAf/5/6KkgpJCkUG2?=
 =?us-ascii?Q?XCBUpeyzNuleCr2GW5ikz20h0BgZKXyWOP/JS5j26JShEX/uIzJQK2W2bZnt?=
 =?us-ascii?Q?KUUoL0DrAvrNafhL9tBqksAV5+mG24pvjj3J+xbwaSxktOA2WX0YTlJSgFr0?=
 =?us-ascii?Q?9xe2WeqLiLpBv+/MbdWo4cllb78D3fHrdDbQcd4mSV7Rx4ZP2KRBJyqMyeXg?=
 =?us-ascii?Q?UEgP/LR/NwitD/Qe/T4/yp0z6H3MDiLmyhRnQN0hOY7iii0HyxiH4Q7MUJVq?=
 =?us-ascii?Q?VieBsflVJFro7JkM2bJmxTAlbjJ81xkmNAdwnzZPqGrKlpbhxLXRAHlxkJo9?=
 =?us-ascii?Q?lLAyb6uvSf2/GlFcCJv3O7XouQvk1liMiZG83AEDwbmuOzwMzl4NQeZsihFl?=
 =?us-ascii?Q?CejkilrYRZvEmzcA/ko38w/wfSdGWfdKrBScqDc30WTD6w9IPnVXp+Y9maSX?=
 =?us-ascii?Q?7Ggq/wtIf+5hMPzpXGCNSCmFRefTHi7i0rCZQE3rDUMVDdIa8WOVeMUG+5Xv?=
 =?us-ascii?Q?GeCDbUSDUaBMQ7cEz/DGJfOHzfTumTvSpddCDH20aAFSJy8WFtEFJmZBccgQ?=
 =?us-ascii?Q?+FrfB4cAMKqWKPZ9yIGIow3ctcwAaN+63fAaR+TWzl7pgxwdg7SeJT04JNfi?=
 =?us-ascii?Q?gJfNI5aFR6QExoiKufKYdgqozPh6/K8n8zVsbAb1q7MCLLQ7YFZaE1UHjlv/?=
 =?us-ascii?Q?01+3WF+6P6wKELbn+tyNr3uf21C5ze72IPM4cbVkvj0iZxL8YtVxSxMdQ3XK?=
 =?us-ascii?Q?ybg+zTK/8woxSSU8TVyplMWiRoWbsuxiiklNQ+qHJS6pHgc+Og8tMHItC7i5?=
 =?us-ascii?Q?UgE+zE73zEy+1AgChDT/nf2QqhtMsj/NDEXH5JzIOpnHTjmYlAZW8AlzTujp?=
 =?us-ascii?Q?2h1K8z2K3iq61udpt7cvMAPz87IFaHl7jOT8jubFAO8wAxdJZTx+HJmLsax9?=
 =?us-ascii?Q?NT92ImXBzKAaPMGxtGQmACEnsnoGuLAyqTQdf1OUf/0BHgaBAXdb/+LDuUlA?=
 =?us-ascii?Q?3epVTS+OM8UiL/iaRTtmYYPQ+K+2piiBeyfPTrJnITEORnVh5tCD0j4RjDKS?=
 =?us-ascii?Q?HKI/0D6JF1odrAPH1nBEHG4Q0tyupbzWe+CCYgg8cKAPF5YIJtk6r728LD9v?=
 =?us-ascii?Q?bciWDmM5ka7pR58RNNVy2zo7W3U5RoZtYZFfy9bT2f+q8R9WIaXUyTh4uXPf?=
 =?us-ascii?Q?iKuKOQULMyok6jCekPuCSlF2F9LC0W02QU65fEMtoZU/IJvJfxeQPRHebN42?=
 =?us-ascii?Q?GdPqygEiuFaIlzKxNWYvwwcmaqpE+T3uMDKV1za415spyWCg17OYdv0cK3Ge?=
 =?us-ascii?Q?NsP81oUlGtnC8aSl1WhHmx0q8A5JutX7jJ2OD3zZXsFZmMXGvhNmni7K71kE?=
 =?us-ascii?Q?AlB5pAqJfKIwOY+txHzIuz4/l4pDaVk7M+fqOTzqtTvJPu3S+Q9ieqKIPwgX?=
 =?us-ascii?Q?p6Dw1V0JiXpH4wW9Vy8Bn5WUjoUXYi65OG45gMKdIZTIHvX3CBT5U0Z2u0f5?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7856b0a5-c083-491c-c940-08dcbdb144b0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 05:07:03.9951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkYtb0jS0hJubKnxP78L6oQDKdWOIFoQAJDTd4nFSUp+Y1/EzQ0cyBblN2rOC6AP5F2/KUxdMa5aY99rv/YCf1gwEKzpVwocH8bsnDXrZzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5863
X-OriginatorOrg: intel.com

[ add David ]

Andrew Morton wrote:
> On Fri, 16 Aug 2024 10:07:23 +0800 Huang Ying <ying.huang@intel.com> wrote:
> 
> > On a system with CXL memory installed, the resource tree (/proc/iomem)
> > related to CXL memory looks like something as follows.
> > 
> > 490000000-50fffffff : CXL Window 0
> >   490000000-50fffffff : region0
> >     490000000-50fffffff : dax0.0
> >       490000000-50fffffff : System RAM (kmem)
> > 
> > When the following command line is run to try writing some memory in
> > CXL memory range,
> > 
> >  $ dd if=data of=/dev/mem bs=1k seek=19136512 count=1
> >  dd: error writing '/dev/mem': Bad address
> >  1+0 records in
> >  0+0 records out
> >  0 bytes copied, 0.0283507 s, 0.0 kB/s
> > 
> > the command fails as expected.  However, the error code is wrong.  It
> > should be "Operation not permitted" instead of "Bad address".  And,
> > the following warning is reported in kernel log.
> > 
> >  ioremap on RAM at 0x0000000490000000 - 0x0000000490000fff
> >  WARNING: CPU: 2 PID: 416 at arch/x86/mm/ioremap.c:216 __ioremap_caller.constprop.0+0x131/0x35d
> > ...
> >
> 
> Presumably we want to fix earlier kernels?  If so, are you able to
> identify a suitable Fixes: target?  Possibly 974854ab0728 ("cxl/acpi:
> Track CXL resources in iomem_resource")?

At least that commit, but I think this problem potentially goes back
farther to:

c221c0b0308f device-dax: "Hotplug" persistent memory for use like normal RAM

...because that started the era of "System RAM" as a non-top-level
resource.

David did a bunch of work to fix this back in:

97f61c8f44ec kernel/resource: make walk_system_ram_res() find all busy IORESOURCE_SYSTEM_RAM resources

..but the fallout in region_intersects() was missed.
