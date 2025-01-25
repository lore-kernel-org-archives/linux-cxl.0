Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7583B1EEA54
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jan 2025 01:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768925; cv=fail; b=XytbvnmIJdAvLqWfAoKFDDZxD0mw5c83ABxrXk4YQfgw+8i22hbNzdh1swel6KZa0tIDf+LbdQ3WqeJNP+N8H5wO0e4ZbabAA3tsfAjvT//p9nHH4ZHJM7ukkdcA45NEg84PQT0GyGQ2/dtukL4ibjPQqRoS0dd9JFDWZ3o4mTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768925; c=relaxed/simple;
	bh=2ROuGePyNC2jgEF23jl/NuxE8C9H85iL7dm0nJJYY/Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pCT1l2ZGZzfu2VreAQmphLK/LUoRxoZwo50bjCNmwDqbp6Jr5B2S0fi43p2xwXzRGRvCNihmX071xph0i0xqu6fKPuy6/Cw+mwkETvG1giQALedKjq+JEJ2tDWUePUnklzZp891zNGbdXCg66KMRS/iwjGzbfgX39pji3TRLPVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MWXBNa7L; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MWXBNa7L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737768923; x=1769304923;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2ROuGePyNC2jgEF23jl/NuxE8C9H85iL7dm0nJJYY/Q=;
  b=MWXBNa7L02kRQAVv7wDx2eLlTNnqV0bjgnkn07GF3VUQPN0NtrnLPYCS
   zyXe3jk76OW6Lls+Q+VhU7WEz8BzZRzuUVPpRBmuh9bLpkuYsaAS2Fyzj
   /xPmeNt1g136XUHBBYoVq5EV8ItCdSCJibF10sUOBRnG3VwEyPOf/YpoD
   fDCb1lpemqgt/lxeQ+E/+rUGBhOhF5xMKFwK/quvedFina1k9ci8Zxhfg
   6y7dN1n+kXRQROQbZz0hpYdKCYsbc3aKs8U8LkoQ/2KhXXZE7gLIJsY+d
   R5HmkSaHo8mowQKNKoFLjbNPs2lFVVpHDWWBZ/hwrHlljm3vzyf7S8vih
   A==;
X-CSE-ConnectionGUID: xjhcGWpgQFWqMxI6Oez/8w==
X-CSE-MsgGUID: srDK8rDrRtiqUegPmQX2Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="38568723"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="38568723"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 17:35:22 -0800
X-CSE-ConnectionGUID: 9T00DNwiQu+Matw0TmrnpQ==
X-CSE-MsgGUID: cOnP9NudRpiEyTGrGQjBAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="112920017"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 17:35:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 17:35:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 17:35:22 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 17:35:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGv19ZpTJkgM/nXvZd+bdMKcmIlNr1yLFZKX0FYzxP+JgNO6ZH6Rr28EGVev/jv5CrcRKU20f+Y7UJbAqEN+u3AhXJLuLh602hw08om0+njNSFXI59fKYpPxspNNz/g8yja4tdqMq0+/AzCCMoeTdjRYpeB1MoO+fF6LZ+CU9lip3M0/NaPIdpKfj3H2ghffHuNa3y3RuoEG9RnlHc8oUcZkgcgORyk36IDGskLE9jBG36G28H0cGvYZ/A+UUs+M12a4yLMYclKQKuy6b4pSMh8YncgnR7uWhCyLDiIRD6ha9JlhKTwn7QD3sLDBI5Wlp8mZoyaINiMRhvPHBxePjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djoskAObgfYsaHAmtbFYES0EHBkzwF3JdWpo+iySL8w=;
 b=iq/KBQ21+Uv09J7yr1y7jbYruI+6MKBbjkVNTwhoRWfxoDcoN83OEUWO3O9rr7olNsY3TYgf3DwMALsfUwAqHMsurbirR1N5W0QiDuwjlOUPCxeTIelOvVlPsGMLpuFvEukQmJJsq2EwZF2fXd0k68uW+fKMGUZSiaaB4c0MYDfy7YBkwL5+KRt+mx/O+IG8t7mnHVaTrCwCDMmbupUj0UvorbEHXP/MpO9XJmr5KXRrYxIasebP/g21kgTX25lt/hzT/ByqdO6H0o2OdfurRaYdEn3odz31w8/PL9y0V+BaHOw0oz3Py1ai9BmlCfi4JRP54Gc4/HRPgC6NtaqdpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB5236.namprd11.prod.outlook.com (2603:10b6:610:e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Sat, 25 Jan
 2025 01:34:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Sat, 25 Jan 2025
 01:34:52 +0000
Date: Fri, 24 Jan 2025 17:34:49 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 13/19] cxl: Move cxl feature command structs to user
 header
Message-ID: <67943fb9a0f44_20f3294f3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-14-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250122235159.2716036-14-dave.jiang@intel.com>
X-ClientProxiedBy: MW4P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f9ddd4f-7fc9-494a-cae3-08dd3ce076e4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O4nUAmSXofd0MDhVukCAJBd3QXUdRlBwDgk4pZws/fqq1ZXCNQh9e2Lov16C?=
 =?us-ascii?Q?vK26ztuN87bMpceNyetNaQH2lueJn4svJZaXn8UHO2DUE5EZm4/qgpIsJ6Qg?=
 =?us-ascii?Q?in+olpsVI7yhYIINR+E8g2QHolgMuaA675pHt9kX6SrFN+75nlxCZ2crfiPG?=
 =?us-ascii?Q?TNMfH2V+KO6oE6sEab4YFJVkWbTvxa/ivP0jIFlqniMxQcKDlD3w/O8QNSLf?=
 =?us-ascii?Q?RI0UmW7phPkFte9NBh2ncLZoxxKwt8kiOWfwGYWM6+RfeJk5Ys3w846jopvv?=
 =?us-ascii?Q?USJ7zO0NYstJpyYeosUZA9XEPuHl9S9Aa2rb/jy/YzeoBH8yiB/IqfEjhO3q?=
 =?us-ascii?Q?6y706kM4sl6R22rXAMqs2RqBmB5FFMZyr73q73yO75AOU63MulX2+rkVrZm+?=
 =?us-ascii?Q?EJg3FwT+IRtFunrJkQVcWdtqYiW08iIBJMQ3oj7Zrah9wirCrc/2fsYD/rug?=
 =?us-ascii?Q?P6LiEP4pVRvJBa6Q7CVWKROS2Svo4WTrHNS0MwshqmsRNKTN78s8iK632E7E?=
 =?us-ascii?Q?3HO0nlvbqD/b9+K+H7N4AO7NiqJWXpm1e8p+zB+MdW8k6K8cBtAPzwAWJbou?=
 =?us-ascii?Q?kEGZKh7VT5PbLw6DGxetFL9pczn220H2mwWOaKIJTw129jA0f7qIZwgtS2sw?=
 =?us-ascii?Q?RLkoQeyjq7giDvUc2oLdjtBeG/BoVNNR+SnxVGkFVKoJslEdiuBfE1lxiWxZ?=
 =?us-ascii?Q?CuUlCDzEOK4f1gPScp6/ZeeEDP1t/fgPE670hHOOcKoX4ysFcLgr4ggeZiu7?=
 =?us-ascii?Q?It6+acxxQM6XG0VkN2yAC75znNJp/2m9qdbKJ+cCZ8QajQz89GGr4kh+AR9/?=
 =?us-ascii?Q?bw9ijdEn+RhJbFRYaKnW9qhTqayxl4zkd5knoDVylbtnoNrn+gDLeW49oeZr?=
 =?us-ascii?Q?/OB0f4dt3w0VJ2sFn3YN7+ZJv7oVbAW6J71n0GsnXnxUaNBr1J11pErBAGI+?=
 =?us-ascii?Q?qbqO9nh0xaJIQAyWAybbc8BaVbJA54mZ/iPHZ//HmTl6SdKzacH+CONJqt7i?=
 =?us-ascii?Q?J1WlKbIkoPKsaXKjbaMu+Nly39pmlGHnmZ4NQkPyM2PwJifgARClNRW9LWPT?=
 =?us-ascii?Q?yWtXeG6EIbl3sCf5erryy9eMdLGbKlelCkpqbaKjOeH5N8PDQsU07Yr8irYY?=
 =?us-ascii?Q?AftuWX3o3DYdluomLqXrTtXVhDnyLUeJIYFsxuDhU98fQE98M/WVM2I4Mwyh?=
 =?us-ascii?Q?/JjIO7LcSkjaW5GsyF4c5IoPD0tixct7L/5GJWylrPozaFuS6I6UP01cBWc7?=
 =?us-ascii?Q?ESFcAv9ncFB6IPlLl2YlpKV8QrM+NLZmr6/ODcYeBO93jjNqx9AaFkMuAiAY?=
 =?us-ascii?Q?13C8BxNq8g9b2Db5GaP9JkyWFG1+yFxlblc7NSl+7PPAAlYTkK7Bywz0UAuO?=
 =?us-ascii?Q?4NpnCmae9Tu/hN0RZczGkbnRTKJ4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tHU91bNkyRc2j8abwqBVLsuo7fJ2Vo5+3LqOHfKdrsx/fEyv/wU1Kv6ZK+4R?=
 =?us-ascii?Q?/i5Ikm2tEbfBRjhq6xLy8NEJGn/kScnbBKOpvbpuOoP2IBmf4SczhVh+xEim?=
 =?us-ascii?Q?WIMzzB7qyPHG/0LTpFQ8P5N+S5aCOXvXtgAm2ZnqqpcFwimUbJTYbqeI2Kjn?=
 =?us-ascii?Q?rBLuP4JV6fmjCGrInaxGmeugu0E3zkEwnBn57v1EqrMVVuSEVp/WGv6Y9Ws0?=
 =?us-ascii?Q?9DI51pi9iDDGRoUB4UwqV/zcIX+JNHYHeeNImNRmGeH0XZChYluceJDrWQsk?=
 =?us-ascii?Q?tqrEHLg4LOrdU+iiJL+GrqulWZdw+ZXTJXp82x+Dljyq/247Smw92oOKQRn2?=
 =?us-ascii?Q?6bn3Xj2+PeSkNUYJYaaVD0mQwqwi9PIJ45tFvjBnvtPo8l8dEUNxd5x6g+H/?=
 =?us-ascii?Q?FSd5mpgFfgb4pwPhMsDXf0mNpZJEMPVprqbDSeQqzCPTQb30b68pN78+8kU8?=
 =?us-ascii?Q?IJERAgL2xnb1zErmvAPkRw9wDrmQq0jjNhvZMvwnDAUmCEOB7Q4fpgcFK2Pt?=
 =?us-ascii?Q?u+meNBUQ4ZDDYjKjSqkkHho9OHnmUdOIyFeBIG9afmN5BkZXCcDknaJnnOMZ?=
 =?us-ascii?Q?dGJjdJXbutrBmUYmV8TmmBoqAH/Cz8VhOPvyJpsGkyPF7VeI1Vy2K1KDvnvO?=
 =?us-ascii?Q?HgDmDVF7zZPIMvU2D4GNjxM9X0VhSDZah/OczDvzrTGR1iDeY3pnh4b0MuG7?=
 =?us-ascii?Q?nXNb6UfcP2/7Xp9NvRPfrJd1FRol0TcuBwxpeA4Px1AiCFHQjeHRcMw2DHbC?=
 =?us-ascii?Q?+s4Z8P2y/eQa/QoQx09RHgnPOwLlTna9OU7i9RaW9YNeb1cTP7TCyxnCkR/D?=
 =?us-ascii?Q?E0ECF+3Z+IasCRp3QOdzPWvSUJuAALrD6VsOknS/Ua22X42tQ9/+W4XpozgP?=
 =?us-ascii?Q?7ggLV1N9EQBa+4bWiVyJXJv6wt+rdhDCIcVqvediv1CiOD4YB3CtopkSH3R5?=
 =?us-ascii?Q?E/ndG8AMFuxj6OY2FL6gNH7JIBnHvU/1/HHnut16k7IRE7ITBjoDKwQsmHo2?=
 =?us-ascii?Q?sEhNfjvQueL+vvQjSCZz014lw0jVY6lFSv439JwpU63TWCYasBDfDChHKhea?=
 =?us-ascii?Q?hPhrRJxIDI1QXqU+5KIV3NtpoqD62la8wTpXDiQdNGZv5MkSKIqG1KUkORSK?=
 =?us-ascii?Q?OJO9+Cwe1ENy4HacWR0PqBg+asAfnuPHYiJWNyih4mZZltZ/pLLmja/iVN5X?=
 =?us-ascii?Q?phMrU42a5WVk3ECpsyh+JpYqDRi23ZOhSEoW3Ib62UBZhQAxqbEeO8gH4879?=
 =?us-ascii?Q?ry1y0x7rKUWFh7tcOaLfue/yHTt01Ldat/y42jaoCgNRewuREY3kGdjemawR?=
 =?us-ascii?Q?4H1l05JUCbi7HXTiM5vwhOCxQkOku9SBi95KOwJ2WF1IGOkgxC2eWdrX26WT?=
 =?us-ascii?Q?6p5symGPKqBI6QJKAa3RPm1FCoWjaTC46spbxwux17H4QLlkYQD1PHnipASW?=
 =?us-ascii?Q?mWQB+1gkGcfOJkX/+QfFWiTidALTne5Cjtb/YsPYDx2wglv7a8r8EOL7CIou?=
 =?us-ascii?Q?J79CQsr63DhsoyNOg/CspHBoPBNQcBwv7SK/p2e/V8lMRdXmnFacphjchpME?=
 =?us-ascii?Q?hxnCFJnt/pyJC1QhRNGhEinGagiwNpYUYtPqk3iK1GDkXxmBtdmpa1UAvXBD?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9ddd4f-7fc9-494a-cae3-08dd3ce076e4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 01:34:52.3534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Av82m1j+6WOwL0QFKvEcTdP4+34jQ+1SB2TwqPkDBWZa6OKl3v6KeAiiExJEaCopjF/O/EVpc3l2VgTC4m423U5JYE//CABToOeNjSbYmOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5236
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> In perparation for cxl fwctl enabling, move data structures related to

s/perparation/preparation/

> cxl feature commands to a user header file.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v1:
> - Fixup user headers from 0day report
> ---
>  include/cxl/features.h      | 101 +------------------------------
>  include/uapi/cxl/features.h | 117 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 118 insertions(+), 100 deletions(-)
>  create mode 100644 include/uapi/cxl/features.h

I think it's ok to just extend the cxl_mem ABI. This is interface is
going to hang off a cxl_mem device.

Otherwise looks ok to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
