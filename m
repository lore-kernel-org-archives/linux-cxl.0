Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0E83803D1
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954719; cv=fail; b=ax6OOZmWHTmGtU9d1Dby7Wp5/EDmhu/U2lO5ZRhS6iURakNCh6BaecPZLEGPfd8nuX7VtHrDM5edv3YnOELrOZVQTY3SydPsfLiD6Z+HWG68HqW/kEwz8HDaWyEgJfv6Nt35TDY9JJj7So1Stkt1n0vftryLLa1+r5tQUYLaTB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954719; c=relaxed/simple;
	bh=kk4D/+NKGLBkoiW96orQUPYnYwih40Ed+yh4sUfQwv4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ksE1vAXKh9bxNYICijMxm5Co3CHvbi9XU5ipgMppLQxnUdaSxpDKIokJ/PzMv+rO/Y49+gmfrkFOCnWJzU34QoTOiMyuC3rUQ2cm8z/ggh2G3UxJRdUmstSFDJs+rNNShzPQY2S64/S++Wzy/YKe4K51vxDQyQ4XUUZJXIH9uE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DnIycon5; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DnIycon5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771954718; x=1803490718;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kk4D/+NKGLBkoiW96orQUPYnYwih40Ed+yh4sUfQwv4=;
  b=DnIycon537uZ9+Sjpyxl0hyYZm5HECcmeCObd2RMLzSuS3Ndy+2k8vEq
   1sZo0YaXItNJpI9CHSqn3vZ/Zhl7HzRQ5Jyewx8wzgt6azLzUNBQ2ZoBb
   J6McDObfe4D+2UrBfZ53dPivLAXyie7mc/bIHrDPsA5wxDbyPnCsrE7Oi
   DjNuFT/HeaUZAHFnsE136ZD9DZ2Kvy5F1NSW7UiSC6/U8CrnBEIrpQnzR
   KIGN1ICN/Q5Mxukr5w+5Ix0PxjlJ4OuEnOIoEuItH5MXCHi9mBdrsX56z
   1u1kEylJdmpb1JZaHTMzMDqnDX283bPBZQpctIEp7yhA5GBkxyYccVMoZ
   g==;
X-CSE-ConnectionGUID: 1AyR5oRWT52UJlqri4eJog==
X-CSE-MsgGUID: Uzez0pvzQaWIYhSauq4BPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72680999"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="72680999"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 09:38:37 -0800
X-CSE-ConnectionGUID: XLEIv4KgTdCsAdfauHJa6A==
X-CSE-MsgGUID: p9spCL3ETS2qX+ULknvEag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="220475632"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 09:38:37 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 09:38:36 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 24 Feb 2026 09:38:36 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.70)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 09:38:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uyf7/mwBnUQKBZxX5Fd99DxCWHC+gn6KXX/hmtqtMrCdrqdMiaunzDpQTARL3HMRHcAQDRVSI+7J7BpF3TRu01QZkcZIfSGwuDoPUtxc1/sTqe9Xxf7IBDImGadSJZuo0YLC38uAEg7D6t87c+w86EslgxLsTpMnOhfSJQg7kkschC7oAR9QoSFNUmq0GS3kFYTpdWd1qMfcTLKwccle6re82oNsCWlmIcAr4RKEo6AfzqaJ0wGa5xlZgNemFDANITcXONzndIR7gqwLrml2N/ubJDM+ZfE6g+QTwzTObffgwyujD/iunvgn3Dg4yq5CICwix8zvjIY+nRMCfvS3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xP5Q4HEX+QiEyVyAXXWBM0Y+YEQyE/dhLxLuxbE6/LE=;
 b=MZHk+TIrAqiUCXDSOUuzzOAtExFqvGWMS7hcMZFDSbBGMqIBMVpI/E5QCYRIf5wog/x+FDg3UnDlHLuY1+qhA2KxiQdmmE4T2ff5L9VmrsAp4mFnfQ7r6fCKoGPcvF2p3/CRT2DUATkK8pwGHWnuON5XJujwwXuAb9FU/6Xxz4vxbX8FZYGSXrHObceMaQ7eI7K/cLn7xXuJZctANsq1aT/EPU8giWyLNQfdGnzBu4YJqhH9pNVAZRv2GtszKvvHnUvJnDxShJK4i+BysKqF4Baz+3hP/YWz49VVQj86g/3Bp3CYe6e9GGwzangfW+d9P+6dCtGOzLFF44qIEPwifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS4PPFFCBF1B4C7.namprd11.prod.outlook.com (2603:10b6:f:fc02::62) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Tue, 24 Feb
 2026 17:38:32 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 17:38:30 +0000
Date: Tue, 24 Feb 2026 09:38:24 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v1 2/3] cxl: export internal structs for external Type2
 drivers
Message-ID: <aZ3iEEqQfp8sAkCY@aschofie-mobl2.lan>
References: <20260223142633.2994082-1-alejandro.lucero-palau@amd.com>
 <20260223142633.2994082-3-alejandro.lucero-palau@amd.com>
 <aZ0R79N952TTsRcl@aschofie-mobl2.lan>
 <20d72717-23a2-4996-8abb-4d886147e3f4@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20d72717-23a2-4996-8abb-4d886147e3f4@amd.com>
X-ClientProxiedBy: BY5PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::24) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS4PPFFCBF1B4C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 087c0df1-4832-41c8-4010-08de73cb8678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rEGr6sbTAUNXQUnxJJhfRNEafJKwc8N0RU6jk1ajLmhRIB1SrwIH3GvQHy1E?=
 =?us-ascii?Q?XMxpR3/cCSDGf42kHo/GQyPWY/Yarj8zAU8JcmzEcarwdPPsCQrAVE29ZKeo?=
 =?us-ascii?Q?Bwj1DcGWPMLWWVgO6WNHHtd5WtTWiev0/eHDENaMAKdCUok9smSEMFxQOLoP?=
 =?us-ascii?Q?8Sl2pvDb39s6C1llh8B+w5pEPz5mjifZwYm2moZ28jnEf4agNa7aIXK0H+kv?=
 =?us-ascii?Q?R0KNj9AOLclhg+bGP7Tw/dxopjb1z/dbwPMoTQw3dxqIN8GSvcCZ9Cq6R8yT?=
 =?us-ascii?Q?YuFjv0B0Wc1HV79TnyamJdGUgfsOrwm57StyboOmkeDdcopiXGrgpYi6urt8?=
 =?us-ascii?Q?mn7LIvgtMcYjYOFqRntOmgw0Dy+4PLTjX6voJGnH+yZl23EK4T8MX81GtGVj?=
 =?us-ascii?Q?OgzMnzZMWURwYROEVw23CQEUGWmeYtcB7EKkwclwPWlFaius7NCFGD3Ax8+V?=
 =?us-ascii?Q?scen8z5nFgoU+ufc/yGMtvzGJZpJbBsWVmtXElHb4B4s4w+CowpOuWNKFNYf?=
 =?us-ascii?Q?cO6UNx4sIGJMy3wY/IPwe85CGMilvyUEZqZ9mxKxyfJ+OKXmYgXM/qK1kRG7?=
 =?us-ascii?Q?z0obJ9FAH/mTFLJ+U/4L0Mtat7SVxCLtVrTdsB5P7iy80JjClGg6fJa0gEPn?=
 =?us-ascii?Q?wDxTQsGz3mIwLCuSvFLD1W+cWnLB2yHk4R3S5wx2KpsFc4ABkIVCegXeOrUd?=
 =?us-ascii?Q?xJQrWNljhEMEeLwnk43eQyGt0PNFOVKPINLhNIXzkwIoyuLQf4V4pD4ntjQJ?=
 =?us-ascii?Q?vZOU88W9ifk4aWb9ejzlaVoSKoA/UY/ckP+MqJkP92y7tEuPyKsE55i8WTY+?=
 =?us-ascii?Q?PE/b+Rm2gtD+pmWQOgO/mDO5bS0bpijY2YE762HTiaUk1PJVIlVC3cVhBj00?=
 =?us-ascii?Q?7AcAp8IrWCeIfkoqXZaX0zELyAGj7Dpx8YUYXIbEOYrgtPFDwu32H0LrC5wQ?=
 =?us-ascii?Q?tHA1TsGzlKh/5RFh40MHzxetY7vOZLqiNxstpSWL4ET5eOI9IeQEHkYo61Kw?=
 =?us-ascii?Q?aJMQD3Z9ISd6/r0OkOf77ZZuHGYVXJsptEH6zzsDP6hv1bGIf9DGiQjIWEZR?=
 =?us-ascii?Q?B28H2rsoTRA4XxEI7rHZEymiucQdTbkl70lHbxxiAEBYzQRGg+JulHJOf569?=
 =?us-ascii?Q?S/42grpHbX6j4z7pjn5dugqT4gcUBZvrMR6055O1wdGce5qlCqS3nwuCPO5H?=
 =?us-ascii?Q?qzLd2xxq+oFBIsrzizgLMUV06z+dCc2tiIxB7SpmQ6dH9BukDpcXl8rp4+O1?=
 =?us-ascii?Q?PV0u8SBnT4Iv2QBpjyKK5qoQX19QA5gDLw/wE8kDhyhLKgwjiZm2JjgUHxi4?=
 =?us-ascii?Q?QU65x6vN9QNDHoUmFgKodJ/nWYBhKh6ZRt+f20CeH3kM/LinZzxTOW4+mTnN?=
 =?us-ascii?Q?BNAioUZX3In9o4u4DHA0e1V59Btz3QZbD/gacS1A6L1rILaee2SGSB6GkCCA?=
 =?us-ascii?Q?VwQUf4ubQnTJOHTEoLLougtWFs7djGyJPapUfPfzLNcz/6HYgSDLk7FSzxPu?=
 =?us-ascii?Q?Vu1lv1KFjve5O0QkE9/447+b4Koc0Y0JHgFlZPQVR9Dc2fxTT0Mjq7EvIibl?=
 =?us-ascii?Q?2mBJ6HK+pvBhzHn9TfQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dgj4+Bcdk4nCyFk0lttbrUDE8xSryXT5/6+l4T76/0DEMaMfHCF6gS54hrvW?=
 =?us-ascii?Q?UDxorkxEHwACTV+OaXd6m6qazmmMLP7oPvgKrBuatkkdluSP+Tc9xya30UAs?=
 =?us-ascii?Q?FuC1UkTJ9Vw/J4Aqq+Washbh/fe4plkGErMV4+F4BtoiNKmWQt//r3JM+QjV?=
 =?us-ascii?Q?BKW548ukRSh+cj+XqvvlDo/l+yC4ZUnfZf3YE6yhzGt3O5rGWj5Jh4UCxHEU?=
 =?us-ascii?Q?3zXfDt03BspMp0ymUY+hgP2g1GmAVKykIUuhizNrw57PBM+mJb72LlVFZmXA?=
 =?us-ascii?Q?tIAFqn5F7er5ABL2Kt++ZR1X5PBGlgbe+edXfHxVkhIVxr6N/73uIPEXpnaB?=
 =?us-ascii?Q?WRm5yEcJnOFyVrY4j35ksazFLyHvjoauDSB6N0BpLM1fnTz9GiRP85V34Gmw?=
 =?us-ascii?Q?iywPZylaQ6ro+Wdip26zpMevFZqmtJeT4roPZwxmbSyDwrFayMdiQ25kfbAa?=
 =?us-ascii?Q?ANrGK0vSI0s+Ram6/t7NwZp18ts3F1SfMYFupR2MSSiC/zEacBMdB7UwAggr?=
 =?us-ascii?Q?UhCbNDCLFZl15/AerIJtWXppdjN1AQulNqNuMolH71jFTbdT2xTA48KVniLL?=
 =?us-ascii?Q?F+4rHXfC7XBeb+wn2BCFofcy1jeXqttYF2Xbi8VjKhEUHg7O9iQoYvRQgsM9?=
 =?us-ascii?Q?ksxiPb18IlIQDVG9mG5dhKRfIYebTZLNkQeqCu9bVbKekdV4hctwBLkwG9f1?=
 =?us-ascii?Q?iDLpqBqJHpMBfDynmjRCW1DUFxOuOv9yLN3JkYOF9DLENrA2wAgWpM/sGUwf?=
 =?us-ascii?Q?9EgDKoMRRG2kLf3uudZQ05kkG7uwF0FgnOMa2SS4JZGirC7XnAWFNSpNBIzp?=
 =?us-ascii?Q?G0FIBAwghOBjZ4UquyjoIxaO+bPmGgi2TPW/KYOrGn0qtpmKVF3xLUy3e/QU?=
 =?us-ascii?Q?39DV/HoJdA2v6OrhW+ioQ0m3OdKNhkyM/AvTEkbKQTPy3XOd1dNe0a87Ilpj?=
 =?us-ascii?Q?+ffDW/rOtcpnM/1g0ZY9gwmeHe5GSXwr90TYYyGDNgL7AeE3ulkYwBCRJN5m?=
 =?us-ascii?Q?h6tToor/pMxDrRopAXcBloff8HwS+GUhAccNGCEa91otC1YaxjqrDo2kGOvI?=
 =?us-ascii?Q?iMKLy4qBt9F/rZiQ18LLoh7HTquEMmrRySQ0Rs7TEnjmJMApmq0Zpn6ZuSa7?=
 =?us-ascii?Q?w5yGbIVPufRLGNk7nxWYJs8blTXm0hIZppsYhhFkLloJ2iXu1Ha6wEyi3BBQ?=
 =?us-ascii?Q?KUJyl4gEfsBHJsFR67EEpdAmSwy8QIjV0Gu6r0RzC1AGF3NqXiZ+1FNvH8Tb?=
 =?us-ascii?Q?6YUnM1Ov3X6r7ua7DT6JBx73BsMlPjznbjv8SN/IuY8oEzGxluIOqvMMOpxW?=
 =?us-ascii?Q?gRUUcXNPemgcKWcrInqJbFr+RiP0OQKqD1rJZYcfrmp7APfgn3ti1i1YsVX4?=
 =?us-ascii?Q?14/IUmL6Ln4YmreOZsKmFt81ly7O/ztCW6QjlJjgdPKjkWI2o6vEaYzfEpt9?=
 =?us-ascii?Q?Z2qW30cPZBl//xmtW+KHKlO6psxX7sn9O9KThtuIi+EIOy+THi4VxLDS+GL7?=
 =?us-ascii?Q?iI77YzyDKdLJQF2ShEojxhavo8EbvpJdUP0YYdwYv3jAaaDHQxIuW2Re58nQ?=
 =?us-ascii?Q?W5aT+YH6DejnMuXKifniVSv3rsJ/IMpwa4bszweB5a3+02tDeih/B48H711C?=
 =?us-ascii?Q?7Siegu8CMtHZP1rY61jJ9rO83LWDX37R8xzru6zrDFvjzgp01KCZdBh7CkDi?=
 =?us-ascii?Q?387dcgAoF0mKKVcJSTeKabvhUlug5bLWTfABem5kGLT5jJU4nT7IA9SRxEUf?=
 =?us-ascii?Q?CI5i3mVQKsDV/uOvA8dVl3ppVSihHBY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 087c0df1-4832-41c8-4010-08de73cb8678
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 17:38:30.5871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Q+SDpBGHkMN4JsVlzlVipdZ4BubBmUU629/NM27py1avddBq2Ym3aBawY99ZrChgtVXS886IGN2cArMm5xWZqqBYJ3BjAtQe+UY3nBeJL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFFCBF1B4C7
X-OriginatorOrg: intel.com

On Tue, Feb 24, 2026 at 04:38:03PM +0000, Alejandro Lucero Palau wrote:
> 
> On 2/24/26 02:50, Alison Schofield wrote:
> > On Mon, Feb 23, 2026 at 02:26:32PM +0000, alejandro.lucero-palau@amd.com wrote:
> > > From: Alejandro Lucero <alucerop@amd.com>
> > > 
> > > In preparation for type2 support, move structs and functions needed by
> > > external type2 drivers. Differentiate between public and private data to
> > > be preserved by type2 drivers.
> > I would have enjoyed a mention in the commit log of what was needed.
> > When I saw struct cxl_dpa_perf, struct cxl_dpa_partition,
> > CXL_NR_PARTITIONS_MAX, enum cxl_partition_mode, it wasn't so clear
> > why those were needed (as opposed to the cxl_dev_state defines)
> 
> 
> Well, this is what Type2 drivers support will end up needing once all the
> functionality is added. So we know it because the type2 full patchset and
> the idea here is to put all that in the new file visible to external
> drivers. I know the standard is to see how the changes are used by a client,
> but if I do so I will be adding all the type2 patchset ... So in this case,
> the cxl core code will use another header which will be visible to non cxl
> core, and the commit says it ... although maybe some rephrasing could help
> like:
> 
> 
> "In preparation for type2 support, move structs and functions needed by
> 
> external type2 drivers. Differentiate between public and private data to
> 
> be preserved by type2 drivers. Refer the new file by those cxl core files
> 
> needing the moved definitions."
> 
> Would this be better or too much twisted?

Well, still doesn't describe what Type2 needs access to.

How about "Type2 external drivers will need to access to "___________",
so move those to a shared header file.

Where the blank may be as broad as "all cxl_dev_state related structures
and definition", or maybe it's something more specific.

Thanks,
Alison
> 
> > 
> > I was a bit concerned that new cxl/cxl.h had dependencies, so tested
> > that it compiled all be itself in a completely separate module.
> > 
> > Tested-by: Alison Schofield <alison.schofield@intel.com>
> 
> 
> Thank you!
> 
