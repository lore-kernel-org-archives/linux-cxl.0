Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7251DA3D;
	Wed,  9 Apr 2025 01:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744163717; cv=fail; b=jMf3INOU6oGLqNylEoiPZIUyfrjXFGobChLQgTTw3TeYm7j7un2Wy6gmks3v92Rl5cI7t1aCMK0aj+IK9kNy71+sSbHX7G1JLMx/IDFcRpJqVmbaOvv0icB3CIvCQIn4U1ZI5peWQk/pLpY+QYM49uRx5tSImKRoZRQkyx83z18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744163717; c=relaxed/simple;
	bh=kvWSGq1/DH6XLp8Q1/ya9Yv5hqlRT3zKyviBtX+6k6U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dBxPjgvkhzF3tBmsjk7JQyz8D7x42jO/znaKk8U+xhIt3L9bTkg6AJSNyt6Gku8p0cYuXGvyaskFw6wlfQ+AAyWaHHEEHT5HiwxNdY+EkdsxS5RNQK2PZdooHPyvl5Dx71q6yewuFO2KMTIW/xnrhSKg9Fw00Mxwn9z6qAyeD4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l54YLDoB; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l54YLDoB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744163716; x=1775699716;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kvWSGq1/DH6XLp8Q1/ya9Yv5hqlRT3zKyviBtX+6k6U=;
  b=l54YLDoBgYLywPvWznVguprBi6jg75JqW4iafCDWHrckut/mD33t/C/W
   akmIuog/ZfkiRSaF9646Fbwiikrs/T6PK/aFpxH/d/fEFE+lRI+zLsUza
   Ja51XkEFqttOKXvZOAQ0n/XcgKUA8hsuQy+IGZ2RuB4iWEegWzPP0Wl1S
   AVEflPIwQSIiuJtqgXJji+4upR8X32hK1uokAZFNUllyCzZ3LsnRDElBe
   KJcdhwXrodj4MUfDM0PnONWcuuWPVSCVAK7Kn6bIANwvYeG0PaKnwmQam
   B7fzMM7Oq1hqhu+rvn66SjqjtuyLrrsBi3fBXjuvzbAl0u4hBD60CgArn
   g==;
X-CSE-ConnectionGUID: szHVlTEdT3qKYR92NsPsMQ==
X-CSE-MsgGUID: dAU/96dkQRizAJPW9gfmJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49415836"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="49415836"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 18:55:16 -0700
X-CSE-ConnectionGUID: HVGcGD+oS2CYUgDCrz3SDg==
X-CSE-MsgGUID: Kk3QQif8SV2WUC6u95oLNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="165669735"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 18:55:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Apr 2025 18:55:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 18:55:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 18:55:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJGWsuo7Kqj1HqXlNEA9+iAasiP9zcoosZxJRSuJXVegFyZzJ6AgWzkTazdiEafmc9ekjcviAQgceWxhHJUzvPL4iBJCL+qyFkv7rtNfOmiELhYTjPBNlHEc9EDRLmQXo12Pf79YRUl4YS5uRyaFyMdHyo5q2Dlaurvot4pcQpMxlF8pOVsy+Yh+1MsObSFtiAnxEnp/TA7H8MCAyNzwd9rrDAEdxyJ7UJNL5zRE/VtRzYu94kNq7/S00zlxSpFENeGAv7Y3J3vfZQaKVv/8Og1ZsO/lPs01rLaX+rls8RSaXNniohfS3nfNuEgC8KoWLv5dwhAFbS0mVqG3+CtkPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wKIqv/1LqNGJhnYJ0zwFOk3D+9iGfpQtk/iKke5AbA=;
 b=dodfQiZA7hO0+G+IhQ4a+DrT539/9C1yxpMk1j3VFU5SHZS3EnLKV+9xPpbRT3e/32GPPFIz0VWrHEbxmaaLo8Q3HY32KR6/Ov5SIBc56U+/ioj/pHzQOxT/GA1vkSt5XVwHK0ldklWWtJmceXIBuQ2fulB/x6WE4YjDMkVWtxg11KnKa0YahZHc/I8hHYEpip6pCDkhsqjDnoByoouMsoQ8RwuTKNPwwa7dA19v7i40jzgzjpEMnY2oMDlzj7nJxpwhLvjizT/mBpU/1DuIJvfAZ/aVvVBngDEv9ivOGeW9vXv5JWkLp+WS2pwIPkIkhvGXIVfEZqL7rlNweU6a9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by SA1PR11MB8254.namprd11.prod.outlook.com (2603:10b6:806:251::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Wed, 9 Apr
 2025 01:55:11 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%4]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 01:55:11 +0000
Date: Tue, 8 Apr 2025 18:55:07 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>
CC: <linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/acpi: Verify CHBS length for CXL2.0
Message-ID: <Z_XTe8r7Syn9Y4cf@aschofie-mobl2.lan>
References: <20250407080217.76117-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250407080217.76117-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: MW4PR04CA0156.namprd04.prod.outlook.com
 (2603:10b6:303:85::11) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|SA1PR11MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: efb87d73-8c82-4f57-1f53-08dd77098fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mVkFCPVAB0UHC3uFEWmVcx2xJVCl/PFx5OoswqsnL32/AqMHnzDh802Tw2FK?=
 =?us-ascii?Q?XfKPtJjyH0tm7O420Kb5v081m9Vh8H9+I4oIGhZMhQ56K6OsMADs2Q2H9bdk?=
 =?us-ascii?Q?wRNFHIh7R1eAXgOKBxrOoYTOQ5e1gxnJJ0bYrwtybQP9i9BDi6QHyvcoGsJ1?=
 =?us-ascii?Q?4R8m6SLscdu59Z50UkcSZVZ7FvDatu8wpnvK5PxGSD46ok1KqzJATQgHk965?=
 =?us-ascii?Q?GzbHgwSgVqLEwq2x89QUP1lfYyWOtyQUizvVhvNsj2cx5yzv3iddVSWWxYVZ?=
 =?us-ascii?Q?s+iJnFxhVgyXEWCulEqr+F2Sh2hcYQLh1j9zcjS/EY1astUwg4F40nfwwPqs?=
 =?us-ascii?Q?NXxJ0Z+myWj6Tui8gaYZMchl2PpHFq3rV0M83/Jgn6zLz8BPaW39B1AXdyfb?=
 =?us-ascii?Q?tyckUrs9aiMw3HXZEsyw8I9b20Kf+eqzk8SrxTtcPtK7W1dc0fr62iiISmc1?=
 =?us-ascii?Q?Lk/9haB/oVE3gYXOy9GRlhJIlHO7cCGKqZdNknDnl9J9rjVJELWbzep4eX3X?=
 =?us-ascii?Q?be/4e1qZbSxImz63TcrUN0b5wjSbMyxkSEsnSUB+7Do3FFao4lumGGhhdVrc?=
 =?us-ascii?Q?VnQld+G21KTuLcwh+BbF0uJz/NKCkZUE5l+hN02T4xhw+f2pBjtMRZC5peuQ?=
 =?us-ascii?Q?xVCJxVzVimpQN7JNVso76+qZO612jNQfaQ4qxtGs8lyTR/krk/tU0I+3MEt1?=
 =?us-ascii?Q?xG2LhfAl+TtsCmuaXG+5IOlM/nyTH9wL7SsbFfBVzhweTQm4VYMwZE97x2zq?=
 =?us-ascii?Q?B09K3ei0eGSee2SWZEbLuHpcvdU3g1ig3I/W8v+rmyJy/+Gj104nayrfIJZr?=
 =?us-ascii?Q?YD5wp4LOLDzsSo2LlmsHjYGwNfs4Iba0yq1AQdmdt57MrXLyNWl8FQdwAmw0?=
 =?us-ascii?Q?8Tz5dmy7fHoc/YhHbu2AvZyd5kUKLLFZXrGE3SygQ7kpOxTaa8xnHZ3lwWot?=
 =?us-ascii?Q?may4mTRhAYPoOsYgIdzbvaBZfVO4uslI0Te2fUJsWBPuMmVkv4sSAGgdpiMY?=
 =?us-ascii?Q?Clyv5mfRtRagPrhXHtN1ec34Vw4k2Mv7t0ocyFoAQHzp0ueCKdRtoQx1dTrX?=
 =?us-ascii?Q?95pyIk9MXjGTYxCCT4uUddCaqE9FGIdCb3U3ysTk3TwKIOPvYbBp58hEdTMG?=
 =?us-ascii?Q?hxZeTttsc/YgOoZ0eRAaNICYlQb/n9E65KHCZz7Cyq5GlfHKifeAabiEdzui?=
 =?us-ascii?Q?WvgsaqsZKArfrjvBGQzxomCk30BcBLSWF/O2HmW9LQMHALTeGt2V9ib07LDF?=
 =?us-ascii?Q?+WFvFzfxKwjdcIUGfgrXqaLYrR3cKLaNXviq8zYEAhvVy5Ju3xyVXBDTpIU7?=
 =?us-ascii?Q?d4A0pfUSHSBYCo9JbObegMfqiWaAxu7rj4eJ7IDxLJXp3SFDHDtgq0hl1JMh?=
 =?us-ascii?Q?xaBiuWY+c3DZ00Ms0frezc6JzUCfOyRtDOaQD7zfY90qY0HB2ZFp6pLQz7/D?=
 =?us-ascii?Q?A3YNqmfe35Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PXmfe82In4g/rzc2sChm50Bn0OpjOxyXjOPsDk+2iJnXPct6gsU8iNKwXfW7?=
 =?us-ascii?Q?o+j+z6pRKbu16heBXeIUiQeMNebE+7Zb7JCfKraM4hNeeQaye4EQbGyDuYt/?=
 =?us-ascii?Q?RioATnBgeIgArDUeFC8oP5eS7/8mUqNgWmA7tPymTUGJ6hxga8ED+LlRP+Rq?=
 =?us-ascii?Q?AdiP7tK5PmchE3eznolZSNvyXm8OjQlCEPs2mjUTlR91vMIJ5iYyYfjAJuSN?=
 =?us-ascii?Q?GnHhni7XCZih8ZwWc4OPXmjdplWiWobMRYTlPhy0f9FHXuyFK/8xVRGnh2lC?=
 =?us-ascii?Q?imSvFkPlZDeoJc/D77HKXTHjfN2mK/BijRq1yEL91OCBgKnbUOAnuawowPXA?=
 =?us-ascii?Q?sewK8VKB1u7g9MZ6kOkrKFdTYprMy1n7fAWfbf5cku4t5VPnIcHKEfXCwiqv?=
 =?us-ascii?Q?HowmJKfTlN1XK8tbMacT4rzzSwyknIBmxNJLRA5yZ/U+7u9QMWLDVaiK3Ppb?=
 =?us-ascii?Q?H1AUdbHCH4HSu2+0oCgsHOXsk6Nrh/RuWKHN4ZjXrsRowcOn1LgqyXmp5U+l?=
 =?us-ascii?Q?gkLofLCpuawUuIqqV480Bk8G63QjSOk7Nxx2bxpjVR8XxLFxIZuWCE3L1OdT?=
 =?us-ascii?Q?cX+6lNoHpXkA2t1Nf8MAfTwbtmuMKX31j3HM4MXIx8HwiigfXcamdsLA+ng7?=
 =?us-ascii?Q?zTkOTshYT4yfTmuje0oeElk6y8zlRJDUm2fjN/Ivnn9QDBZbvPBTmKPo+tFF?=
 =?us-ascii?Q?eMTzCwfKVAfcl/0H9lMiDDx4zTmGN52yfobFP6L2NApKg8X+n7+s3FsJGP+Y?=
 =?us-ascii?Q?oFcg4oHh/nBl0zN45ekK13oxE6mOvyjN8Gn3qu58lqQeecPVMHkSAqHmMSgU?=
 =?us-ascii?Q?2O9QncIwhMWoWcteK9xsdaURXQ0umK9D/EPdr2qoPaoZUOci0QWY9y6CAagI?=
 =?us-ascii?Q?NShpXfB28i9z3eOuCoQh7Yyjy27MrapT6XrSpxqiUzfg47KhRSdaynMhchRX?=
 =?us-ascii?Q?6ZvirtgxNpvHvywGrUdzXzti4lan5t6YIkYSQ8EKwdhzrUjo1XLZ880Z9IzQ?=
 =?us-ascii?Q?vQi/xpJR3dbRvV+pKRilkrWmOONwZOrXi7kaxMaF+i7O/RNZ/LCQqVSfMfQR?=
 =?us-ascii?Q?6dC1mpONhx+c1+nnD4yM1tY6TzCjDZR+aWcl8TX2KVZL0hoaAj3tPm8iBEpf?=
 =?us-ascii?Q?T4uozaRPvCh7haYlEmcW4liDNJrauCIuWcLIWGwNYH2/UGV/CX2+Sy6PTaA+?=
 =?us-ascii?Q?7fAriJtTJJubxurQ28CkMnhUojeIc+3zMlFjsTuIT/u9XugnsiI9EBZY5v0l?=
 =?us-ascii?Q?DaruNNR7+gq1NNZ7cQxWDyVe0tOfMxko1JbRef9hch2joeW254KAqDhMxpIW?=
 =?us-ascii?Q?XJkECREy75ASRTEiN2mQ3ssuInEJMpXBehjZ4d+gKH53jzxbLTU2b4Mj+oMZ?=
 =?us-ascii?Q?beoCXUz/NuS/FRlz6qXG0gE8rl+GgVNg8kw7ZpjeJsEWJt57dZXdsvxzpINe?=
 =?us-ascii?Q?72DP7DPoC3IgaG32bloU9fYbe4zg7oFAzi99ewXfjxFylo0lHwi1yDUhUOb3?=
 =?us-ascii?Q?EAcVeJc4SrEX0CM4vZFAOFgIsKp1EJB9i9P71GYesukrSRrkKxQyvlm25rX0?=
 =?us-ascii?Q?XvHN1L5W5CPKOEuTK6xgH2fAdwcJc4qoKsIjlaz2LvCNvXiWn44O+s68LuiD?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efb87d73-8c82-4f57-1f53-08dd77098fff
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 01:55:11.3415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVBZGHVvRBWUILELfcM/4wZrwYwWSsoVH25RiYf8PKuW0QVwFS5qRx6OKV+fQk4+Bp7S/IDrMBdqdQ+iVj9swTQYPBWGepAVWXrYSBN2YSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8254
X-OriginatorOrg: intel.com

On Mon, Apr 07, 2025 at 04:02:17PM +0800, Li Zhijian wrote:
> Per CXL Spec r3.1 Table 9-21, both CXL1.1 and CXL2.0 have defined their
> own length, verify it to avoid an invalid CHBS.

Can you comment on removing the comparison to CXL_RCRB_SIZE. At some
point someone thought that was useful. As you remove it, please
explain.


> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V2: don't factor out, just validate # Dan
> ---
>  drivers/cxl/acpi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index cb14829bb9be..2e63e50b2c40 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -11,8 +11,6 @@
>  #include "cxlpci.h"
>  #include "cxl.h"
>  
> -#define CXL_RCRB_SIZE	SZ_8K
> -
>  struct cxl_cxims_data {
>  	int nr_maps;
>  	u64 xormaps[] __counted_by(nr_maps);
> @@ -478,8 +476,10 @@ static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
>  
>  	chbs = (struct acpi_cedt_chbs *) header;
>  
> -	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
> -	    chbs->length != CXL_RCRB_SIZE)
> +	if ((chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
> +	    chbs->length != ACPI_CEDT_CHBS_LENGTH_CXL11) ||
> +	   (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL20 &&
> +	    chbs->length != ACPI_CEDT_CHBS_LENGTH_CXL20))
>  		return 0;
>  
>  	if (!chbs->base)
> -- 
> 2.47.0
> 
