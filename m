Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28DF32AAD1
	for <linux-cxl@vger.kernel.org>; Thu, 30 Oct 2025 03:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761793663; cv=fail; b=CLYqCJb0wv5pGuebQHH8c4gHsc9VzYcdRHeBf5dc91e+Ua5zIJRQAOaDAGLfHpt+j5+Qg+ljMzcVdFIdqdnzjYYLdCMjcJBp1tS+A/Rloh8hRbltHZTwuFzitbcPpNIHbD1+Gspuq2b/6CRZkvnK3u3Kq0aPSBVBGES+8MwglBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761793663; c=relaxed/simple;
	bh=wTzmPepg3Y/JcZ+j1mEgOtaXf1auZN4Z/gm7m2xD9OU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PQU/m6wCkf98tpm+NLdJCQ+IsPvjtAr5yXXIJOZUtg22ppnbK/Xd9nPiQWRdH4y1zLmgYH068zb7R4zsW91SSd7nhc5utuHRDGcABRCXsyHqhd5c6/RtiBlyRdgfT3rDRQoBBVuCriq+Nt3v5yhU2Wh3Mu++GPjjKczN9eAzpYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9lldeU7; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9lldeU7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761793661; x=1793329661;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wTzmPepg3Y/JcZ+j1mEgOtaXf1auZN4Z/gm7m2xD9OU=;
  b=L9lldeU7/JilcQ5fezrWijKCsH8QJZTDwGO9ad+zxyoA4mpzfgzc6x8s
   rUsIyqfhMQKSENdOq/oxfkfx2wLYcL61XsHH7yqfmIbcCM4zWRQi6vEN4
   Ih/thqUjZwnUlwwS+WJF8Lc84uQdGTNDZnq057hna2sdyIIVaXrNqpfcw
   r56OGIoHCI7ojfdA4xpDIemfOlNfOcPH7j4dJSASwQ5fdZVdjNr6oRPQL
   aaqDbIGs6FA0J8I5Tg3RHwdd4muNpcrYR2jd9zhTLVdePKVQ1RMpLpenC
   I6JYidfTgzoWdv2zXiA6AlTapK7wVPj049f8uX8tzgGRMPpKKq6SzvQX3
   Q==;
X-CSE-ConnectionGUID: Akk5RPxYRe+2koCi/5HpNQ==
X-CSE-MsgGUID: hC1XY4W+Q9e1qwsgRZ2YUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63964491"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="63964491"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 20:07:41 -0700
X-CSE-ConnectionGUID: uy0NmU0eS3mG6nAgIBrLhQ==
X-CSE-MsgGUID: GhSuWSqzRQWHbJ4SdwYO1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185530492"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 20:07:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 20:07:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 20:07:40 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 20:07:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUa7yegGL/DWoR10mH0rFoz/bzkF6+VDtEKfsJVpbbsnD39K49r2B0eWSgz3ZB58plkmvMQuhpFHiUQpBmt5YcngtGCJ43fQADxvG9n01b10yCRL8oFZ4PrS5LeuRAURkppy5QSEDlzBkmIflYn3ZSq+pEMW+wvHPVLWz+G3ejoNTZ6XEJoWH5+WSM8/RT2nD7CxxfaFGo8SA04Hecg7a5kxSizD9mB+B17p/PON580GAhdtuADGhfMhH4fPNb/tmmNm0d1Y9qTm7RXbHT9AaKPHnuyCNyolGO467xG24xVsHZ/6BnLquTu6ZfngudD+hiyLqa4YgJG6vCYNC/iJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ORPp+tD/eXDKy2PHARSDd6Wf2xTo19ZPzlb4fDi1Zs=;
 b=Ji0+y+mvFGEHbKYciMTBNYkfOhIhi6uQ4QOfYCAVTCStQ32Jcgvo58FEk4kLwU6xjLLMoIQhSBy3bnqMi8i6CWsMLi969E+8/40DKHUdFJ46UwmnDnhnlgR82WIHLYyzblICVUzZthPAi7ctkV7RVzWzAWXTxiZrBsQY9tXiISNCDBZBPNyXYTZo3KIlWrC2AU6CZmQxD06r0MtvekifAo+vgzTERdpd8qR0p88qVXSliSAYpodRsxucWlb3pvGtKsUAD+AzX2HQxNkTb5sYKj3W4VflpiUGgkFdP+InctU49RjQ0GZ7TRZaESl+Ql7f1DEE7uI1ecBjV7cjHRQdRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW3PR11MB4666.namprd11.prod.outlook.com (2603:10b6:303:56::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 03:07:32 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 03:07:31 +0000
Date: Wed, 29 Oct 2025 20:07:22 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>, Qing
 Huang <qing.huang@intel.com>
Subject: Re: [PATCH v2] cxl/region: Translate DPA->HPA in unaligned MOD3
 regions
Message-ID: <aQLWagZsUnLVU6C7@aschofie-mobl2.lan>
References: <20251014062850.727428-1-alison.schofield@intel.com>
 <20251029120357.000029f1@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251029120357.000029f1@huawei.com>
X-ClientProxiedBy: BYAPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::31) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW3PR11MB4666:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c636d77-e365-4ab5-729e-08de17617720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CDMFUu/kYxEFPpofrKlCLjzgTxNddMsfJ/oSagYOtry/yj8I3+t79uWoJeMi?=
 =?us-ascii?Q?Rim7a0ZELoh6E1C9Ljr60OEOWWC4YHtft1hHrnJtf6oHFXzhIg4Zz1lrbWjd?=
 =?us-ascii?Q?GxjItrLgNS6n7RflJBFFCyL7zU09eNVRDOCEO9pYWcgFiL2nnwMPgzxLfwkh?=
 =?us-ascii?Q?vwRiCeNPI/Xru+4OZjf4l7p/titx00qdKdyRXMkmD+xW66Hy2tH3s1/JoNpA?=
 =?us-ascii?Q?m2Z+coBjY7EKzsLDp3d8dQyP4v++Nfd4bM5M2ceYaL/ustoU2G5RapOoDoH1?=
 =?us-ascii?Q?tyWxCQDEXGb3D2T8nRfinmlhyN8WPytod8QCcb30NjzQFb5Z4MHf2TR64DJr?=
 =?us-ascii?Q?DWhO/JAOKdH73Co+urLHufmgw8N5FMiaYxGuS8AXzgC6ZW94vZQJqRczPoGc?=
 =?us-ascii?Q?CCrr8sYGvI+YKN/MiYIJumj1GO6ooojzE1D7duqqYpssz65ztpMy98dULCXi?=
 =?us-ascii?Q?kLVcFTOtQs5TWiy+3I4dfabZFvsjMQySd6i500gKrQd60ozUGH9JgFOsqeRk?=
 =?us-ascii?Q?57USwB3qtEo9RRVZUMk8zJCrfJLhn/vhWDnrvEf0HRcQ0V2FbrLhC/p4wsp9?=
 =?us-ascii?Q?lcmTCj0PaLG0uAnYHQb8LAd3i6wMX0GA0lf23tLLDluFmfVptMf8PeOg2qT6?=
 =?us-ascii?Q?FKTVWOOCB89eN4Kpcg0JKri8Xo8CbU4u+SjP/BinmCOhy1F9hUZLGVEUKX4h?=
 =?us-ascii?Q?ZgVaKSNMFjUJGQ1KvZu7KkfIYR7EBuXKVpE2rq0F5sfseb3epbLiL53WvKc5?=
 =?us-ascii?Q?urU5tYNWuIeCQiV8uBPAO9Kttihvxh9VERGPt6xkkhSFEef5JwPZSbjz3Dw1?=
 =?us-ascii?Q?Hf9iJX45KJ4MQjANASnVxyyfCNiwDB3IiPfjDBRT5UJ6S8ZuOmHIbgd73ijL?=
 =?us-ascii?Q?kzgFB1CjMuSZU54WdkVrSjIUq2IDRBLDvfMxBzdxUEz3yH1tIfIppkmli9CT?=
 =?us-ascii?Q?OnbDiS/B5I03Dz52a4k9gLNNBXYUr8DBXsKItRWrurzYwRhLbw5K07eBLnWm?=
 =?us-ascii?Q?iIA8ICXNzCkDnsu2WitHC7h56zD35sDCPy0vN0MoO1pRB/bCmjva1V6onx02?=
 =?us-ascii?Q?slxb8OUcl3AqFDYrHbDhHoD07NNupUzGH6Yh7lZggBfMzDAR0Iiwwink/tT6?=
 =?us-ascii?Q?gojUqGbeIL9oAi3AOBcpPYjFHMTig+vD98mq2o5puVft6lc9V9Ihxk6W9MDs?=
 =?us-ascii?Q?IOrHWmR3XVkP8RdfTkW9e1fcQN34WPbAxlEF/qdFaSU030HJDPCTIOAhuz+h?=
 =?us-ascii?Q?q0erV+ehu7ZJ+TJUNkDFLTfi0DOBliABCVlVZB9LJpgyrG0zOlgkn0lUnr0M?=
 =?us-ascii?Q?QF5kwpqct40jMUvbcsK5bk90ZSZMddI9C01lejFNFRKJr/9gEcRKeGnvGH1t?=
 =?us-ascii?Q?BWa+H/NTd/AhiHguZXApC2zHNaBEg4yEE+yjlO3z/HDiTtDGXRzvWghqaPb3?=
 =?us-ascii?Q?+FsXkRNaejEqgFNRo1v1rwn0haj5O3ei?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yfk0g0AHC7siTQb+VNhxTlf5XTbnDBXhjjrInrfb09n7mztATJ9P0WhdueJs?=
 =?us-ascii?Q?9DSgJRXkLVf3fpf42DzxiDCqXofRY5uVHl4llJLE3t37oijW7vbYz8VOLmPy?=
 =?us-ascii?Q?udsRXRLc9ZW8ItCVRHl1t/3SlAy1k3HWcqhLgVqVa0FkK/FT4CTL1/wwWlkE?=
 =?us-ascii?Q?9kAY1TclNlZOBEZTQnvciRTrpJvkA19/NgWxz1Wd8PuLbIaWbvF7r5LwJBzU?=
 =?us-ascii?Q?Qtf/3ZMjp2MmkauDTKnKjx3yIchlHL2l6atZcnwCFnaStnRbWJ9w0eELIPUZ?=
 =?us-ascii?Q?B/WOQcz5tcpKH3lfMVmJbmmPqTZyEizuniJ2frz96U8upYvuJnnwLXFn3+8Q?=
 =?us-ascii?Q?7AkmbCEg7W16+24tzsTWGI3F097dUlYzSWy+cfn+oGu/taXrIdkftMpDW9nj?=
 =?us-ascii?Q?u8cNgI4938elgyFOAfxW4OA+AMYa9R9uPqWZC+r2ju5QTyCPkX0Korim3wyc?=
 =?us-ascii?Q?GjHrFjJFjMqbk55AzkP3cwCgcWZrQHpG4eEHz/5PD9sLSJ/Pncs/1CR121zm?=
 =?us-ascii?Q?v36Vmzrq4MmEGP6WOyCsppNxtI7TDkeAAyTjhUws9v6RqVWklZmaYKxQLa53?=
 =?us-ascii?Q?/6a3Lo6n5cvbEUCWtNarmO74fGM8dcSJ8sGo+1H7IT8qKIwCNOGhzk12RqB5?=
 =?us-ascii?Q?mBUHbaJc5U0LSwcCkOUUX01CzkxKRE+fAsUbGkTIYAg5p77cGeWl8jhUtHaf?=
 =?us-ascii?Q?fyBk91gzFbhBDxxTRtWHFR209RyrNmEZX8Bn6v7RVNFm7KjTF74fu7zeFrC9?=
 =?us-ascii?Q?gRj7qZaTcy9fNb635Cm//Ukx2qRL8vWmHuBWEcYqT9NY9zQQsEQeqzdaITww?=
 =?us-ascii?Q?UK68tWJCGeFcUJzNu9frIVys31T/Ov8L8mMgsyega8HnEtneMkBcw6Jptojv?=
 =?us-ascii?Q?DqZHDqUsmrGWBzylm3x65boBDPET1MYdgCkjk8QDUz0bVH5yVKX2w0HyWhW8?=
 =?us-ascii?Q?8dqTuZ30xBFvSr6eoPbx6ZSNvRRymTrzlhZCjuBdZNqQ5+I9m9rgGGV0AABH?=
 =?us-ascii?Q?qogqmr9S11YIQEgL9f4Gq193i7I+TUUADsA4M3E6mcazpSjFwxbqtBUd3x7k?=
 =?us-ascii?Q?NyzMsoyXvZIyC28HIhg32Cp5AnJ7CCzsoCiNzxwnnwcbxHedR4dJpOJwW3th?=
 =?us-ascii?Q?WKNXugvgf+hjhyFY51u/gp0r0iHGC3PSXIuOPOtHtfe3/Ygw9dQbYXN78J9f?=
 =?us-ascii?Q?/DJiZB326QQ8sD+dvp6T6jMdMVNYleOCFux+OAwmWzOUKt+RW4syVBo7kH+y?=
 =?us-ascii?Q?hcTLUW5KKmvlXwZ6LnoCuGas4E+moDEKAEy74XUV/PeORUoEruBJk0OlLrg5?=
 =?us-ascii?Q?aQ1Gnmzp6dn1Bzl51OK2246C0Rtm3I2JmVGYg1csocmizA+e0eX4VohUEc/W?=
 =?us-ascii?Q?YeUDrdT6mTEyccZa5jvnE3pynRNo+V7+rd3erSdXdIF1oMw8330p4PhksMDJ?=
 =?us-ascii?Q?YVm8pamaZCR0Z0VcmjpXnWMoqf2HKSgSQb8lv98BndEhxdeLUns4RBsSUxAV?=
 =?us-ascii?Q?oiEyq5QSoGNjkOM8C+FeIeBNUn4UNPfFBGLMDvX4aLX70XrxwHWgI5D6ryQv?=
 =?us-ascii?Q?XBHYuKsxm8iZyBSSHQW/X1pYKDM/jS7d7oV2t2wHceNL8GqfxhB2kCIrejf0?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c636d77-e365-4ab5-729e-08de17617720
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 03:07:31.4678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBaUMtfjDcBzZVIwlRBvDNOKNjtpgLGiE+TlBJfvBjSVMYawfWga0kIorkixBN2DXzhneizAkB+I2Lt3caBjps3sHQUSYEN9sxgsI9YFlIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4666
X-OriginatorOrg: intel.com

On Wed, Oct 29, 2025 at 12:03:57PM +0000, Jonathan Cameron wrote:
> On Mon, 13 Oct 2025 23:28:48 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > Suggested-by: Qing Huang <qing.huang@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Hi Alison,
> 
> A few minor inline you might want to tweak a little. 
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks for the review...
> 
> >  drivers/cxl/core/region.c | 147 ++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 140 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index e14c1d305b22..3dc6f0ae9f19 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2934,13 +2934,124 @@ static bool has_spa_to_hpa(struct cxl_root_decoder *cxlrd)
> >  	return cxlrd->ops && cxlrd->ops->spa_to_hpa;
> >  }
> >  
> > +static int decode_pos(int reg_ways, int hb_ways, int pos, int *pos_port,
> > +		      int *pos_hb)
> > +{
> > +	int devices_per_hb;
> > +
> > +	/*
> > +	 * Decode for 3-6-12 way interleaves as defined in the CXL
> > +	 * Spec 3.2 9.13.1.1 Legal Interleaving Configurations.
> > +	 */
> > +	switch (hb_ways) {
> > +	case 3: /* Supports 3-way, 6-way, or 12-way regions */
> 
> Does no harm I guess, but the comment seems a little unnecessary given
> the line that immediately follows!

I've removed my excessive narration. Thanks.

> 
> > +		if (reg_ways != 3 && reg_ways != 6 && reg_ways != 12)
> > +			return -EINVAL;
> > +
> > +		devices_per_hb = reg_ways / 3;
> You could drop this out of the switch as
> 
> 	devices_per_hb = reg_ways / hb_ways;
> 
> Then the switch is simply checking for a valid config.

Nice, done!

> 
> > +		break;
> > +
> > +	case 6: /* Supports 6-way or 12-way regions */
> > +		if (reg_ways != 6 && reg_ways != 12)
> > +			return -EINVAL;
> > +
> > +		devices_per_hb = reg_ways / 6;
> > +		break;
> > +
> > +	case 12: /* Supports 12-way regions */
> > +		if (reg_ways != 12)
> > +			return -EINVAL;
> > +
> > +		devices_per_hb = 1;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +	/* Calculate port and host bridge positions */
> > +	*pos_port = pos % devices_per_hb;
> > +	*pos_hb = pos / devices_per_hb;
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +/*
> > + * unaligned_dpa_to_hpa() translates a DPA to HPA when the region resource
> > + * start address is not aligned at Host Bridge Interleave Ways * 256MB.
> > + *
> > + * Unaligned start addresses only occur with MOD3 interleaves. All power-
> > + * of-two interleaves are guaranteed aligned.
> > + */
> > +static u64 unaligned_dpa_to_hpa(struct cxl_decoder *cxld,
> > +				struct cxl_region_params *p, int pos, u64 dpa)
> > +{
> > +	int ways_port = p->interleave_ways / cxld->interleave_ways;
> > +	int gran_port = p->interleave_granularity;
> > +	int gran_hb = cxld->interleave_granularity;
> > +	int ways_hb = cxld->interleave_ways;
> > +	int pos_port, pos_hb, gran_shift;
> > +	u64 shifted, hpa, hpa_port = 0;
> 
> Trivial but I really don't like mixing assignment and non assignments
> in these.  Also can reduce scope of hpa and shifted which is probably a good
> idea for readability.

Done.
Moved shifted and hpa to their smaller scope.
Un-mixed assigns and non-assign declarations.

> 
> > +
> > +	/* Decode an endpoint 'pos' into port and host-bridge components */
> > +	if (decode_pos(p->interleave_ways, ways_hb, pos, &pos_port, &pos_hb)) {
> > +		dev_dbg(&cxld->dev, "not supported for region ways:%d\n",
> > +			p->interleave_ways);
> > +		return ULLONG_MAX;
> > +	}
> 
> Trivial but I'd put a blank line here if you end up respinning.

Done

> 
> > +	/* Restore the port parent address if needed */
> > +	if (gran_hb != gran_port)
> > +		hpa_port = restore_parent(dpa, pos_port, gran_port, ways_port);
> > +	else
> > +		hpa_port = dpa;
> > +
> > +	/*
> > +	 * Complete the HPA reconstruction by restoring the address as if
> > +	 * each HB position is a candidate. Test against expected pos_hb
> > +	 * to confirm match.
> > +	 */
> > +	gran_shift = ilog2(gran_hb);
> > +	for (int index = 0; index < ways_hb; index++) {
> Why not just i for the index?

hmm...I was ready to just switch to i for brevity, but since you
asked 'why', I stared longer and realized it should be renamed 'pos'.
That is what it is and that matches the restore_parent() definition.

> 
> 		u64 hpa = restore_parent(hpa_port, index, gran_hb, ways_hb);
> 

Thanks for reviewing!
--Alison

> 
