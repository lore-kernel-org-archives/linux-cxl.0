Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0211218F2FC
	for <linux-cxl@vger.kernel.org>; Thu, 13 Feb 2025 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470345; cv=fail; b=nb7h4eLLHWCDtGaMkKcFt0qXWi4iCncpK50e5IMLHUUn15wgI/6bpEr+BHP1yj4cCtJQ546c3FqEFbLI6bfGuNcNIBYe5ZGZOAhkdgLSuWEs4WZWvuejCuKajoVxMN/QlfWGLeHs2ls78fWzp0vgrn3QpRzSs6/QaKN9bSMrZYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470345; c=relaxed/simple;
	bh=3WPp4Ajzwow2PXBpPFxjEeS2EPDPcvTx/RMdPf5dpvk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JKMA3jSYEx5MqIS7PbM4KpOeSHK9QDWAFCAPvZ/nlPL5Z3FH7Xsz1ncg/35D4s5Rs1leCQnZ4RbUGZJdWmTHo/qaZYOEfQMDA/jqGkY8sVuOovXPv7vv119KdGOFKjPN3dYbDhxeyyF4IDNGxTpGiLKfUXiFMx/1AqlkS7gn0mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVaMkpk8; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVaMkpk8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739470344; x=1771006344;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3WPp4Ajzwow2PXBpPFxjEeS2EPDPcvTx/RMdPf5dpvk=;
  b=WVaMkpk8AQ1pxbTsVcdEfZxKpa+9ZXK0r4QJ+IU6bkBBgVKmJOF2aKDT
   YZIcYCCAM/WBS81a10uTDIF4VWzZmfobAjwl408IZx+EXvG4IPH20wqcb
   UXDyfbzuC5XxRLusIlmaMVHPrqXDcoMvt4fdLVf8rT3+tA5bJGD1KJbla
   +98GP39UCYiBH26+ozyH+FA3mF3o4MxpiaaG60GxhdMrSKWZKXDeycxOx
   8yIgThMLFrQUk96LX4Ov30sH2ln40XrER3nMPPHKdcq3uzo1KIq5xbRfP
   x4yGmteycUsWjFQJOr3reKgHaRumf6tqFuF9Z+SjCfjBLZXZMVdW7dnDl
   A==;
X-CSE-ConnectionGUID: qXA8PC1xRH6Kn2uyWIB4Qg==
X-CSE-MsgGUID: i/L9FPGxQDuVhDGBE2EiUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="57597226"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="57597226"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 10:12:24 -0800
X-CSE-ConnectionGUID: UlPb6aWaSCua4E0SgetqRg==
X-CSE-MsgGUID: KbULu1voTBaEBy2aAcN/2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150397534"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 10:12:23 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 10:12:22 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Feb 2025 10:12:22 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 10:12:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHz8LpM6zU1UMGfQlfZKttrVIc4My9sXAliLz39/MjyeGQpdtN/tcTfBGDyRcJhkXUSVthg7vI6NGVl0UBoxHd9FC1LamTKSIQiID6OHdLGJRXqto4GLqkn8L12CeR2eW8nGFvFWIWhx82pfg4hZcRowG31uU5lWKTWW24UdH2TNnNNhKCJ83zAxmAoKuNXTqymczuxuQL12hT14PuGXbnadUwXsZ0R7qfLbB04ze1quL77GnyzYWExPvrR/1j0O8h/tgXuMb9VomQKmsEceB5fTfOg8bhnUTKEOkN8xtU6pO2/HhnxZ7PtINK/2v+lXDWe2hbOpXAOmRTraNcjBiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMK1MIqgVcbubUwD2Ue9ab26a6jxSEwQchSlYGc4PPw=;
 b=myBGFz0rIbCdcCZMznArQwqG5Q6Juy5/H4kbjexYPQGcdgd2/IvEWTEpA/SgjV4IgCfIlI7Z8zbPFFlJoyZJy5ZPIjt39ubspuTkMn3VIPOQAP/s58YzqpleqbKxgAGjMra9Vj2DH6tZbZhRccG5NQGjP1uMk7+tC1QVJSPb0u6tG1oLbPxXg6luvxLu03ll5YbRXV2P1fbiVDLxnul17Ntc4JlIh+dzZBIsZE1sAb83h1Sjhohkm/rK1jXHvYPLPyPgAKqtIAtmdLYGBZcq6q6m7zv1Jtyk3FsMpwaI5XlnDJNgZeQ8decNbTLMChkqOqPEnlgWk9MSgGZpShNvXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.12; Thu, 13 Feb
 2025 18:12:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 18:12:15 +0000
Date: Thu, 13 Feb 2025 10:12:13 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Saeed Mahameed <saeed@kernel.org>, Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>, <jgg@nvidia.com>, <shiju.jose@huawei.com>, Li Ming
	<ming.li@zohomail.com>
Subject: Re: [PATCH v5 08/15] cxl: Add support for FWCTL get driver
 information callback
Message-ID: <67ae35fcecf69_2d1e294f7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211182909.1650096-1-dave.jiang@intel.com>
 <20250211182909.1650096-9-dave.jiang@intel.com>
 <Z60QCS6o-3VInenG@x130>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z60QCS6o-3VInenG@x130>
X-ClientProxiedBy: MW4PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:303:8f::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d47072-4c3a-40f0-56cc-08dd4c59f21c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HpQ58uh8xFPD4rhqffWYw0zZc0v9bNXMQ4PbevmZGsM8nqeVg/cRe1T7eJNu?=
 =?us-ascii?Q?JYUDr3/efWjG8/Ca9pAi/1hJtG+V7RBy1go8ckqSe3RjmussI1N6iV7p7TM8?=
 =?us-ascii?Q?hdKuYvgtW0Pu2+PejntpwaDfOI4koizcUnH2+t+sJk5A/AG+SavfEvBzpjFH?=
 =?us-ascii?Q?UTNVuLeEjxlMIOxdDXpvATRADSDkcRedRB4/CfMg0lvt522rBAvIXxDXd+OE?=
 =?us-ascii?Q?ZpJgwVthizwLu4fO56BMFxO2+QH3+b/qnpUN0+RNYcwF5Rf77i3ZSUsYyaYh?=
 =?us-ascii?Q?3oEgifhKB63YlMzBDzLSgU3HY2uW7dTI80LH6hi1Vy4v4wi3zI1XWjCyJRJq?=
 =?us-ascii?Q?bhEm9FzgA6QJJfuM3xIgVEI8pPNmSxCV3p7rRz1PTU0t7jiyHRw2ZBJg+ROV?=
 =?us-ascii?Q?AM+A7iqRXPCQmqo6ahf5dHpDKdSjmZRv7/0l3Tq/PriZJjzcO2IaLZwYzuLP?=
 =?us-ascii?Q?XrxzWeMd4JYvzZB1ckY/2f2C7npw+svAN/iSdEsEGofEzNbJthukEYH4FXTm?=
 =?us-ascii?Q?nByQbGhQDy719QLH53BH3PovgITvjBZMS/sK7+gs0fetdDmCWusH9nVLsi/4?=
 =?us-ascii?Q?A2TRjYCXXYH4EoE9FvWuvF7zMtkZIlW36yNoScEgHqjmYGZqMKr1pkTnklqY?=
 =?us-ascii?Q?Q0H6+pQ14HeDM4ijt4vH+DJgjpV7uU9IzpLluMZoaQw2qNeTLUpAecLJ9bPS?=
 =?us-ascii?Q?fo2o9J6G7yQQr1iK3Ohc3NCc1cRABGLR5Eqzu8ypoou8lIv8eYk0HnlUnNT/?=
 =?us-ascii?Q?2N4N2Q5HHJIz3o9Q+/z2+J0kdbrtIScY3Fg1tHRv3eXULvTZC5gQk9NEuefu?=
 =?us-ascii?Q?1clHS2pMmRVHeoaGMxckVramCds5IHHnAg1XdyYYNPhIOICqvrOmq4Ejz3C3?=
 =?us-ascii?Q?/+31Mu7fSK5ilY+pgd5oYCp/ALf7YIHKYPQOL8Ut6INx638V8c3sQe1OAUgC?=
 =?us-ascii?Q?8/q4ZlA9t0AZWwAXIMJvTwbdjtXq0hOj1I+lQbcwp5H7od3Rrs+dIwSYXJF6?=
 =?us-ascii?Q?X8538a9tKMJTK41roiFoiHTVpntn9kqKijCiS9fYoSMcOZsFPm9/XkPMxNur?=
 =?us-ascii?Q?azR2S1ElFQqmW+pB6amqvDN6BfhABjtc+HQzOMFSInvEOBnrxHRNeXcz0ycr?=
 =?us-ascii?Q?RhJXFbE4Yl+M83xZ0lMestV13byfVnBIS9JzNIDp4wKb8PwMwEOMBWmcLhR3?=
 =?us-ascii?Q?2QcI+k0lPd+3fHtfNe+A480DZf+5d6Rxu/Yml2FYWIhA+cyJPjFfgUp1UHET?=
 =?us-ascii?Q?uk53aACIlqxYPTDTDyfZ7uf8VY3d0gydYjPt4mLcCkxEGg8/5NL6rHvVINnT?=
 =?us-ascii?Q?/jixUHvczsT7pC+xyueMdkqsebCm3+AHeIgdFgCzOgvsjbj73iuYho2MayJg?=
 =?us-ascii?Q?kv3QNN0XCt99U411uQTAQf3FGeO3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cSwQ6sge36nIzLkD8weGVyliGHErcKDc7JjpGNfmgOyqT/P7+AyQ+z9V6C5f?=
 =?us-ascii?Q?Q+weeKx4xVvIjc5fkBnKjiCf6/6R7Twckek/k0SzjWcewM8fzoFagWdSq9WK?=
 =?us-ascii?Q?gXSWHbijWaKhQz3lv/JNXsQDaCOmYRJL7EwAkhBekyKxwjqjho/nSd3L9ZQG?=
 =?us-ascii?Q?XiYkEySesuyeJKSZ3PYkQVmJIk3FTWjlusyP9mwlzJFIcsG/+NWZisp46/9s?=
 =?us-ascii?Q?XvpB+XZbXnnsYzwrWdvRTnEVlKCbKGBL2kLOQHUKJDudc+KIKVj5S4GdXlve?=
 =?us-ascii?Q?r8dUdg5Cedu8+EqVVlob7YYmyjZldR/aY+Z4g73xOSAp6yJ3r5kG9t9TCp+5?=
 =?us-ascii?Q?jWnpF76szgizP3x18qZaEskxdjpjeyJnDZdywRkHVD3JKWtCMlZVI/IMfrAC?=
 =?us-ascii?Q?HC4ckhYJEIn+Dl2Y3c7epn8OKPdYZU6XVQaQMFD6WtAJwUbSx+B6G9M/FTxU?=
 =?us-ascii?Q?PGqyTBqA4tcqRZ6RnCtPKuKTgas60p0tSLz/uhPnU1i7RLVMa/AN+pz15jhd?=
 =?us-ascii?Q?zVbLo9z6TNN41+SZBSBpK4zZS6/NcQ+F21miW8/cF3fm1LGlGHBSrhFYvJlg?=
 =?us-ascii?Q?i1DwWd1MkF1LYL7S6TSRKD8lqK+j6d9bsT59E1xRDQwZ0ZccILKupvH4DvSh?=
 =?us-ascii?Q?3ROZjpRgdgmhyn+S2v8vqnrNe0RNNXovKKajWdDyo6sKM3mkyPsiBnrEvC9Y?=
 =?us-ascii?Q?cXGZvCi0iPEVdEeblmN8RTTnTC7j390yy/MKVw1IR63PYi4RIF0RKd1qCuKK?=
 =?us-ascii?Q?3IXkiclqwnKYEkoMESHPkXnSTm/WYQiejcJXDxddhY5zI0Ggl0PQ8q1SBoYQ?=
 =?us-ascii?Q?Jf7ufaINOaSXo97huDll5ESZELnnPNbIMsV1O8AL+smpkLiWWh41SDI0uXIQ?=
 =?us-ascii?Q?n5/u3iogoa36hYhR606RpgNd/B7XQCtyl59yrA9NmqVJsGtPvda2WIUnG3Jf?=
 =?us-ascii?Q?SKTLwPezGPkk0RKrkQKrK2kmgXRhW9fKzO3hsQqhd5sPojTQWtz6xXeTKmWt?=
 =?us-ascii?Q?bf5NHCleeikH0RhyU0jIeIObz/l2SA58qHYqXYPlhD52uqqOGGr8bR4238HF?=
 =?us-ascii?Q?fTa51iEJZjCWq11VxZkMHnm82NWos4qxda1axEAO03KGvLNanx1kvGIEYkKb?=
 =?us-ascii?Q?kdXBNTqykI6OfpgsuSXMJyU2nJQXjaKXIgl3wMpUFOwRbOhxKnSlBhpJKIxG?=
 =?us-ascii?Q?ehaVi05yMmymvDc0+orF56yqOj4LeNSrdCSsrIuMKRul5JEyFGRe29KHb4Lb?=
 =?us-ascii?Q?vpAadYa2NPh3llEGTyl1RXIlbxxfnZp6biydn+7jbNDLbfNydsJfrOLmzlCT?=
 =?us-ascii?Q?bAQzJ4cBJt/5aiilyVKsC8DKBR67GBpLumFm7aTFrFzI2owWr/+6BMcAgN8+?=
 =?us-ascii?Q?hHIQYK5rNOKDnsNcXUEIacfVzNluIR4fyt5/idipR0ClECxtjHUQ/PITFa/R?=
 =?us-ascii?Q?kBCt/LrGNYNFXRALANhvGmqwKfBCXOjYLXSqukBEgNImQGxw+pL3OYm/1Fxi?=
 =?us-ascii?Q?dXANBymYLGUK5guH0UUBYu5zneu9VGBL7pdm6eGi1gbWrESnzA5+Ifo9iK0u?=
 =?us-ascii?Q?os8FeGqKlUxCUbBSsi+0q6czln7lRRJY93c/x/UluBN57dvRHF8z0RIQHOe4?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d47072-4c3a-40f0-56cc-08dd4c59f21c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:12:15.6353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fuO+l/WDmfHyuLYqafk65TVuBgrh6YgfzU3eWzyt44SkM3Sr8iUohKyXlbOJ53GHx23/L4f6zCb0oBZevhwk4JD8sgLw2H4nQhKHck5B1qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7493
X-OriginatorOrg: intel.com

Saeed Mahameed wrote:
> On 11 Feb 11:28, Dave Jiang wrote:
> >Add definition for fwctl_ops->info() to return driver information. The
> >function will return a data structure with a reserved u32. This is setup
> >for future usages.
> >
> >Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> >Reviewed-by: Li Ming <ming.li@zohomail.com>
> >Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >---
> > drivers/cxl/core/features.c | 11 +++++++++--
> > include/cxl/mailbox.h       |  1 +
> > include/uapi/fwctl/cxl.h    | 19 +++++++++++++++++++
> > 3 files changed, 29 insertions(+), 2 deletions(-)
> > create mode 100644 include/uapi/fwctl/cxl.h
> >
> >diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> >index db48a8fbde81..923c054599ad 100644
> >--- a/drivers/cxl/core/features.c
> >+++ b/drivers/cxl/core/features.c
> >@@ -354,8 +354,15 @@ static void cxlctl_close_uctx(struct fwctl_uctx *uctx)
> >
> > static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
> > {
> >-	/* Place holder */
> >-	return ERR_PTR(-EOPNOTSUPP);
> >+	struct fwctl_info_cxl *info;
> >+
> >+	info = kzalloc(sizeof(*info), GFP_KERNEL);
> >+	if (!info)
> >+		return ERR_PTR(-ENOMEM);
> >+
> >+	*length = sizeof(*info);
> >+
> >+	return info;
> > }
> >
> > static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
> >diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
> >index c4e99e2e3a9d..60a26a0d8f1f 100644
> >--- a/include/cxl/mailbox.h
> >+++ b/include/cxl/mailbox.h
> >@@ -4,6 +4,7 @@
> > #define __CXL_MBOX_H__
> > #include <linux/rcuwait.h>
> > #include <cxl/features.h>
> >+#include <uapi/fwctl/cxl.h>
> > #include <uapi/linux/cxl_mem.h>
> >
> > /**
> >diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
> >new file mode 100644
> >index 000000000000..d21fd6b80c20
> >--- /dev/null
> >+++ b/include/uapi/fwctl/cxl.h
> >@@ -0,0 +1,19 @@
> >+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> >+/*
> >+ * Copyright (c) 2024, Intel Corporation
> >+ *
> >+ * These are definitions for the mailbox command interface of CXL subsystem.
> >+ */
> >+#ifndef _UAPI_FWCTL_CXL_H_
> >+#define _UAPI_FWCTL_CXL_H_
> >+
> >+#include <linux/types.h>
> >+
> >+/**
> >+ * struct fwctl_info_cxl - ioctl(FWCTL_INFO) out_device_data
> >+ * @reserved: zero
> >+ */
> >+struct fwctl_info_cxl {
> >+	__u32 reserved;
> >+};
> 
> I would add some useful info such as: num_user_features, mbox->feature_cap,
> etc ...

I much prefer Jason's suggestion of just allowing the subsystem to
opt-out of the 'info' command.

The Features that are private / exclusive to the kernel are a small
fixed list that is unlikely to grow.

There is no need for an info command when documentation can communicate
what CXL Features are available through the fwctl interface.
