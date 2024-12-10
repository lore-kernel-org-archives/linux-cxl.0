Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69158B665;
	Tue, 10 Dec 2024 00:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789295; cv=fail; b=QE2dudXzU4i3O0s909iXNLJz85rREbt5r6j52Bm+byrrW2fz7H0Y5C8XxKODNjfi+ECDlNG5AGVLwiThy9Rk/kx4IzPzPiY3HDmSy4oTyzsebxgePvaK4O+oMWrCzS3b4OjNXQk/VsgDxWUUzyiQguKwarWIx21NHdzTvQ238vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789295; c=relaxed/simple;
	bh=CmM9vEqIaJrvD/ntp5dhhdjpGbt+8SMep+QsuMixLsU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V6Trdyz6B9ZEjMRVoNhM26trfwYWZzzp8+7L/eMoeZXZi6n/i87AqrO/ddARI7nF1cyaRqJ7+jYzLzuma8fkXm0ji/LOvA/PkieIzfzCN+oZbC8Dvjg354X+wHf4ORmyex7UKJETeHXbH7T+TxIOH9JoIv6X+nKDzs/jJg7FZt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bR18Ou4K; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bR18Ou4K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733789293; x=1765325293;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CmM9vEqIaJrvD/ntp5dhhdjpGbt+8SMep+QsuMixLsU=;
  b=bR18Ou4KBr4qMCLwaUkveDi8Sb10HEQEnXAEFO5TPRHgkTeSdBMgKrbb
   4HBX+d10Ohk/ijNwUUPpjEeebKJi1SxLnT+cyOgX2rA85m0zxXS1ywtjx
   DjN1x/3fe0co6cbnyEwXUN7RZvXHxChW9SimU2dX/rxWIep2UM958uLvL
   u0pS9dUbGcno8MWWm/zT0dPpB7r2iHEUJtwJCUu00YhpOMRg/rIW2/Ptx
   us+qB2YJfTh5jKBdgs/D0m1MjZnz7gbsWLhAtxEV2bdxjDqDANUz224aw
   Kuc/dixFH38L4MrdE82XCAqdU4ckMpOfj97RI1PunozBwwvmSiEQbss5T
   Q==;
X-CSE-ConnectionGUID: hiOdwoX1QMSggSv0ogSCtg==
X-CSE-MsgGUID: 95uYv1X6S/WV7SL9AHDumA==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="44585230"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="44585230"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 16:08:12 -0800
X-CSE-ConnectionGUID: eaaP3S5fRN2NBlyAWtlHuA==
X-CSE-MsgGUID: Lz9+laaMSuKRG3FaAyt6fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="100178647"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2024 16:08:13 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 16:08:12 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 16:08:12 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 16:08:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxxCXmL/ZT5moO6X89TxuJxO8gGOb39hFbQfQeCbQuohVp2avBY0nQoVuUrpRffnnXG699KkSbaiac8s56H6/w8gyaG7lArVmE1mO4aELEtbMBhWid3RdaCZReGfmxMX4HK/56A3wgT3cyjBS6rtYLANZ6BZ5jhnjjVA4A+j6oQRBWkP5Lofo3Ya3WqX6FfIEVR0Lvpdu33dkPYEimN3lAHvetu2fPJT3TW3j2zFNDusbl62fiozxHOpBANuiQVN28s5KOO6/QNOCcTCpT9PeM/6o2BuvFnapVwLxvcEhaf8+d1vd1/8arcOneE/VKZvdCWwcYoJRw3xlVFKtbehIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6KBt9YnOCP0Yg3yMrJJ9/Wo1zF5ItVN09f6Zo/qPbA=;
 b=DV6tYAeKTASjgWwBRXj3O+WdMHvANpYNObaYkpANhB0KAYHCkXfB+YdrjebJBr4IZyYeH/GrQQjYVpIoDOutiqsemNjk68VXlbP9C/daViwznU2ZZfXv6Qcc4vJIqC31QNF7bhxYsw6FnS6mdjCe3bqFEBRgKmRYhh+i0e9cA0v/FUL56zbik/8QZJbdMozaPVMQ1jFdKOLWbPqQOs7m06JibLP/FmIi/nrmqxYQelFBo7p23Lh72PIpO2sRt+MEou7uFbgLmpdl8XG/FIUH80IAt6EiSCsUm4DvFuVEL/Bl16c+ENXYWiAXytauPlUzwTHHkj2nrSWcK1Owri5roQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7195.namprd11.prod.outlook.com (2603:10b6:930:93::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Tue, 10 Dec
 2024 00:08:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 00:08:09 +0000
Date: Mon, 9 Dec 2024 16:08:06 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Ye, Huaisheng" <huaisheng.ye@intel.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jia, Pei
 P" <pei.p.jia@intel.com>, "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH] [RFC] cxl/region: Fix region creation for greater than
 x2 switches
Message-ID: <67578666a401b_10a083294d7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241027075717.3714821-1-huaisheng.ye@intel.com>
 <80415a29-14dd-4108-aa02-4b0b5e1f2baf@fujitsu.com>
 <672c13b19a530_10bc6294bd@dwillia2-xfh.jf.intel.com.notmuch>
 <1f05ccef-5b45-4eac-b3ca-588b1e5ec6f5@intel.com>
 <SA3PR11MB74613BB0D280113C7DD65DB69F592@SA3PR11MB7461.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SA3PR11MB74613BB0D280113C7DD65DB69F592@SA3PR11MB7461.namprd11.prod.outlook.com>
X-ClientProxiedBy: MW3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:303:2b::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f23c41d-459f-476c-8d91-08dd18aebacf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D1c1Rel+naMeFuQ+OBk4LoYO5TFE6fxSC0xbI7nlnXJoe+BtMi+A58PzG8Wn?=
 =?us-ascii?Q?VB+DFV7MYcPeXqYw4XoXVG3aigBOf9/dnP/jk9XB/a4+qvGg/jdtNmeAxtYH?=
 =?us-ascii?Q?c0VCu3xIOOa1bOR7tI2wRSW+bjW22x2yxS0lwFVe6DUNpj8TaRA7sY/1koFh?=
 =?us-ascii?Q?k7tAKrIKLRtjkL+goapHAMwY2hNJ2syUyopDOxovGQRRvtHQ/Ito8Gw04BR1?=
 =?us-ascii?Q?MBZkFaECsfx1yPLTWewmNQv/3UGcdyRdPSJNfOEydFW/yD+DYzXqkDAeJLij?=
 =?us-ascii?Q?CHesmjbt0naiJTsrcF3eBsGnO7toQ9N9liYNv03j+sZSXwKNqYjky9ZtdDKD?=
 =?us-ascii?Q?LTO6RzfaKCxuYp0b/Sk+0NgucVms1iAzINnvuGx7SFe4QrSilwrqTL2BXnfq?=
 =?us-ascii?Q?BM9OpiglPazjW8G35c8v/tGBkUIE1m5a1QVYlF3jaIBqz/vQ8QH7U6jjCos1?=
 =?us-ascii?Q?ueOTLpe7I4lZNjUMXIN8msDqgrHp3JJo2tFn06a//eZBu1ZZ0uN/eUa2RPn0?=
 =?us-ascii?Q?unL46jXv+1NTrSCP4YnHP6g6yOIWg10GifwxQfomg/W/FoTUtWIMJVoMnogT?=
 =?us-ascii?Q?LCZbNCQB0wRIgGpox1NnMhFsm4LDHRH5x09j6J5BKEyWQpTHHrUSrOgV+rSk?=
 =?us-ascii?Q?qpMllgr6+YIY+To0wblRPCxFi0isZSUdqN+uskt1+btDlIOWegb14sy54OYr?=
 =?us-ascii?Q?oUwmBJ7WWAVO7QEI755jk3LckZJipHdUJoK3Gs3u6mkML+InmET7EWosYFqP?=
 =?us-ascii?Q?iApCYmQhh8pTQbwv4Wq3g+utR4WRq2etIvfkawO/qAtxJEbm0CE5fF6u6cjA?=
 =?us-ascii?Q?bDRpm1Xqv8KCsYvT9bTuZM0ujS5g48I4V+N3U7M4QswWuadAf+J9wOieyavt?=
 =?us-ascii?Q?HXar4cHHUk88xAjWLM/yFYdDVatJnlVp5F9Mex9XUmjHarpAhY4MqJM134OC?=
 =?us-ascii?Q?xtK8uz3DZ/vWM2FJi3G2oksIddroJOvVkWrjXvcPQZtSNmCXYugO/BSc0VgX?=
 =?us-ascii?Q?v0RmCu2l1D2a9A3/z94FaluEqGJSThG74jeZJ3YTFvbX6VwTCDBcdRv7lWN3?=
 =?us-ascii?Q?cYVNRz5hj29OfsRqDncw42uYW1MqpEiVs3Ii8SISNgfgdZKBfdViXf4r0JHa?=
 =?us-ascii?Q?e0SxonZwUn5S/NvVLllX+7x6800s7icx+zPAUqZoso5n/Qs6KjkzaOXpJuxC?=
 =?us-ascii?Q?cYXqbdVKikOzunCzlLe2VoqhU7WKgXjh+GxdeyD7olKb/M/o4oW68e2l+2Cq?=
 =?us-ascii?Q?/4sfPAOxpU7LUBnARvwb0FgbBnCmWcjskGzczaBnB75jglTfAE2vFKDlBQSZ?=
 =?us-ascii?Q?3k+lcuxIzpyfqnhzGFHthvxXHAgcuWo7BniAMYRE1UZ+Ew=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I/0iazRnt9SM+tB1cYhRSo+yhNai9b6CCf2AiiREMnA9nPX5NPLCs4kW3aLF?=
 =?us-ascii?Q?hz+Y4+RMst4N69XE0qjeffl1OeW7F1hZooNDAf8dECWxSGD7adle9DldtPB2?=
 =?us-ascii?Q?KpOrS2nTEpFXqBPQcllWMHzP+Gsvj+hngvbTy3h6s5zy4rQxHVbwqUncvb6l?=
 =?us-ascii?Q?Xgez2g7CKJunRf9VKiCt3IKUx+9lhyGbYzOuus6ZBpRdgXdo17Y9Ms4p6xDQ?=
 =?us-ascii?Q?zmgKSFg66rHQ41RF1MPj1dV6HDfBXtuHW6nTdbDqPNXgWJL49GrGAVHKO4IH?=
 =?us-ascii?Q?N2uQ9Irj3RUb0FzciRelHy/SvAQP/h11KobcofnK4O+6tyEBVyulUA5AqOhC?=
 =?us-ascii?Q?rg5HDIR5n4B0pD9xebLQ7JrHK4PvFwD4JlbLGo/7hrKwW5xsxB8oJ8cuEfaE?=
 =?us-ascii?Q?RYU4yaiUgDYpcxldTZtVEtCJl1FQKdJWiAwiT6Mr5aqiJDTkIxZvjEz0NVEX?=
 =?us-ascii?Q?EJgWmIPJ0CXnIktqqCPFQmK27/DLPVNWnE4EG//4shAhOmxUX8KwKRmRi7Pu?=
 =?us-ascii?Q?KjrpC2oOfKlyHMliTz2QpWAZFru8pWooSBox9i89dGWGyrS0Cr58h98UOtqs?=
 =?us-ascii?Q?5EYnF6ypuagi/84UJWX13WFucf6jUv5eRMoTu/NWvZDJ3SC/Pchy5a2rOuRD?=
 =?us-ascii?Q?cEpWF49exJSvs+yp0MkIhcLR89NgpQyGROqjS6cKI+OSABe4yZ2hLLXhAJl1?=
 =?us-ascii?Q?4Y6S3JT6N6/3x3Cdh0hc3nN+pfPAPd61vWFVLbdC7Xrv40T2Za4Pb6bNlhDs?=
 =?us-ascii?Q?FoPgW9kBLFqfIikVlFOnfDRpeXWHU0Q8RdKYbeCHnnoISHAf/T3aNBIFDEEZ?=
 =?us-ascii?Q?WDlKo2F1irjkG9sCNH/z2qw145ive4IUWSkQLvddxJTA/VjB469OtDrOV/G/?=
 =?us-ascii?Q?zJusVMpmGDdcyS+B5HR6mMVf1Q4bwTQsUFcXNFuvGu1cHj3nVglOiCuvUOMk?=
 =?us-ascii?Q?TtwF+vg7FX3Gvfs1yQXc2TtpTT/Ca5R4WwL2VVrNn5jXG6FduuEfZpeiJqxK?=
 =?us-ascii?Q?nx83qYP5R+GgB4zVLVzYVSdI6CDQMzHcBDDT5ZnktB19g/WylNDVMZgyZ16o?=
 =?us-ascii?Q?hqZKvliS2jhS/gkkx8vxkcenFC1xGSUPUXi1t3niZWuR75Za1HDUCF8cUuFV?=
 =?us-ascii?Q?9pT7UtuCUQQnlE0N6ntBIlkMLncnfWwu+tPNWwfal9wF5WneErI5W8Ix3B/Q?=
 =?us-ascii?Q?Qpyve1ij/PwrkJRa9PrjJN0Xlm0FnCiWV/dAhw4T0Da/ZuLaM/6j7EO8ZqB5?=
 =?us-ascii?Q?UVQwFvqBsyUwvie3bqJDsdqlhKmf2WWBOlHi0CwYFMrloKOp27NzbCTu7dgp?=
 =?us-ascii?Q?RaUO1gzD6EKS67qnTC3wNdDc9pucLKfzZr0+F45AZF3FiOKbrLUtpz4bziue?=
 =?us-ascii?Q?bTd7zAo1UGxPJgb5IvLRP/ODmgmYBlus8VQ+uzVVn+bwNMFqpT0zCmr/VoB1?=
 =?us-ascii?Q?Zip2syZX9hwB7lH2g1lAdnzlTRpGTWh+k1litbS283mpYn+iQYJIvGh2AOWA?=
 =?us-ascii?Q?aOg03W8mbVt6OHqQ4Hr9Dv+2mhkTahkWeMUFzafnInpMp1qAquWfHFEjPL8k?=
 =?us-ascii?Q?U0Ziv23IhDBTN2vGxCmUZ8bnfa+EHCk96kuDsD41QHW6dIOO/n3bNEFQQs19?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f23c41d-459f-476c-8d91-08dd18aebacf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 00:08:09.5650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAUHn9ZrqlCXXzcbhO1gAXjFt/BXKlELef17u/noAjiV7lZgq3W2r13zaa3nus3sb0sgAXiPVDTStdaunqkwcKhGP+uUg0UTv4WdcGTlzKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7195
X-OriginatorOrg: intel.com

Ye, Huaisheng wrote:
[..]
> > > Now, "ancestral_ways" also does not show up in the CXL
> > > specification, but that is because the CXL specification leaves at
> > > as an exercise for software to figure out an algorithm to validate
> > > that a proposed ordering of memory-device-decoders in a region can
> > > be supported by the given CXL topology.
> 
> Regarding this patch, the distance (or offset) is obtained by
> multiplying the number of distinct targets in region's interest and
> its all ancestral nr_targets.  If we renamed "distance" to
> "ancestral_ways", I am afraid that confusion will arise in the future.
> Because this variable is not only determined by ancestral ways.
> 
> I think ep_distance or ep_interval, even ep_offset would be better.

The name of the variable is never going to be fully self-describing.
Lets just use the term "distance" and supplement with a healthy comment.

Sent a v2 with that fixup.
