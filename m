Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B15C184E;
	Thu, 17 Apr 2025 22:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930606; cv=fail; b=bBhMBZMJIMtiGzgt/BXoR0cOofGzGZ8wk69lkF0cLl8zK1F/YwKj2W69l59oe923+vgKXMpe48nAUiWYA594qiEGcK3L26mLX6ddhAcECCKvudMVWBjaeni/cKYt3hSNfHRG6Lmmof3ye0tolLL6VaOZNYNMrjiIAofh8lBWhTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930606; c=relaxed/simple;
	bh=m8pOuz3I2FndgRznrpgHQ1TlDg1xswSm6cH8ZTN509E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hYxrj9tNRxSnEUXB7OisyExEmR0fSflRc2flDgx7GlITu/hPOpcCpvi3wMzQyGkwK+lBRmpv/d/NpiVf/FNURFx7X1KgWRHUuJ3TzWfbpQN7/WjIKHzh4TShf3/Pdtc2J6DF8lA1aB8ttcLSTeUbkgrffPXEkbQ7oss0SJNpjjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yft/oaNM; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yft/oaNM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744930604; x=1776466604;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=m8pOuz3I2FndgRznrpgHQ1TlDg1xswSm6cH8ZTN509E=;
  b=Yft/oaNM3bJHb3k4JQ9SioLKwdTBLLwTRwXlq6zohR/qABkrbt4GwRfl
   zRjbgB4PzPPPwdrcIsZcQXEW4iAwLwhmP9Gw2KvcPndpby9TNFmH5nGNZ
   WhGjiv+MPmJ1RI3JPwDzF/fJF6gMFyMa7XOReZ3ubuxxYSEG7t/UunC6B
   vMR+9fxt80Jo0gdnGex9JpxrBBTWewVOiZ2sIUxkMXs5qTxKIkPBc02mX
   /WKY0IC9hhQ1oQgyYzhB7YclY5BiNLOaUAZAEjzp4wKgemd2mMAOysEcM
   MPHG5sTJUQa+pgfU42FhsZuUKisH6ApO1SV1HD8tHh3ZaJXDf17B1NZU0
   w==;
X-CSE-ConnectionGUID: 9Xde+IraQ8ylR9//5Yw7qA==
X-CSE-MsgGUID: ww3wO8cVT6S5+TBr/gd6KQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="46439645"
X-IronPort-AV: E=Sophos;i="6.15,220,1739865600"; 
   d="scan'208";a="46439645"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 15:56:38 -0700
X-CSE-ConnectionGUID: MJiwqwDcQPag7D3uUOVx/A==
X-CSE-MsgGUID: WKFBSaMHTZOc7m+1jLFROQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,220,1739865600"; 
   d="scan'208";a="135782591"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 15:56:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 15:56:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 15:56:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 15:56:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0vxTe6Y79htGNukf8hSh8TjweZQvDCUkEHEJG6w8UpgOs6TVcQBtYGavlhGLIPji77X+e2azwPJ0QILnxi5XiRc/k0qdF31xQc/4C3IvutWbmEjVAGQATJs/1/UbQzAyElVX2yeBY0geJ+qdhAd7dvKtFVdhsYS/SvJRciUPgPlaPcx99/c9qwl5cCSpPO0poonQ6fSsu3heRmOgY5rNhFkClFtx4lExAZBo9JGnSIvu5ZrklIyt22c1kxL5WE9HEWGTB2OgC/U1QmVR9dPfwIxYAC+YTJxI8TFuzPqH/Kysg6h3upk7GYuIF+K4GCCdshJDFOLKXXOzTOJEiWBUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwznnCdcpGMcrtx4Bqa+7l28yatcuEGiM0sRdIH811k=;
 b=YDzHOSyl9+ChLTneBK7Z+5EgZOZiyoSp08UPq3V193CD3nIFT2Tib2RrzcPZvZtMHHmcCoCh2UTrTGx4WOjoaD2um+PO9QKTW3aT4OzdaR7FWp0kJfCG9UWmK0a4nPPL6y+IIzmmksgOsI9wkGJFFZAYIbcpDz5lKu2P24XF5QlK9JPf8L2CQm5LdiVpkfouBeAbX1F3ov4lq2dRNclaHDfkf0E/MYM8vkLfqk5AxR6oA7roXNv2Lu0EWxo04AnNZRTPqyIIe8oPo+duysbbohU5l8G9LS0g6DcUvK0+LkUkrsypbehxUGY4FXB4iILznoWaaxxGhBI6KV1HGxDxfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6651.namprd11.prod.outlook.com (2603:10b6:510:1a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 22:56:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 22:56:18 +0000
Date: Thu, 17 Apr 2025 15:56:16 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, Rakie Kim <rakie.kim@sk.com>
CC: <gourry@gourry.net>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <joshua.hahnjy@gmail.com>,
	<dan.j.williams@intel.com>, <ying.huang@linux.alibaba.com>,
	<david@redhat.com>, <Jonathan.Cameron@huawei.com>, <osalvador@suse.de>,
	<kernel_team@skhynix.com>, <honggyu.kim@sk.com>, <yunjeong.mun@sk.com>
Subject: Re: [PATCH v9 0/3] Enhance sysfs handling for memory hotplug in
 weighted interleave
Message-ID: <6801871010a6d_71fe29486@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250417072839.711-1-rakie.kim@sk.com>
 <20250417081106.732-1-rakie.kim@sk.com>
 <20250417153505.c921f75a035089906bb38fe6@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250417153505.c921f75a035089906bb38fe6@linux-foundation.org>
X-ClientProxiedBy: MW4PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:303:b9::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 98bd4d3d-8f0e-4b3c-5c4e-08dd7e0310a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GFQ9KfiCo4jPU5KWVsgY70NahVIChMkgyXCxow6WoQVj+Cf7i0+HuKJoyMEz?=
 =?us-ascii?Q?F0neriDznxg2rytz1eEEhXEOeqpTLWCwK4+lvCJf+kCH9MQWaqqph6QyL52Z?=
 =?us-ascii?Q?Vhgu0z1oblskvG6DVCZJ6FTpiGXrsrACvoK6sQ1jIwu4VfuRrQab/2VqDa58?=
 =?us-ascii?Q?69pyBHUdGmKWgWxJhWRFPJyP3meX3L5fdY4zIfCY6bF+NDQPuj8MXOdVp4Q1?=
 =?us-ascii?Q?AEQClqMcJ8xc4XnVbCD+xgDfMeMnileQrI1v2zPrOHksl0esTs0ffpbu86uY?=
 =?us-ascii?Q?aWSbf2DkqFLsABTrnIQWD6LmnGt/8zDmzUEUp5wYsysE9aa4FWWJ63jDXEoy?=
 =?us-ascii?Q?K9G+3gOGzimsdFiAF5TFmVVgOunaXu2miAk8rCI8qWyNJdG7E4hWfUHBqzxs?=
 =?us-ascii?Q?A2zpFo3pNZ7TFMQq6iPoYOaYPtKqv0y6qDQdFAowUAd0cSUqk5g9Q6CRR4h/?=
 =?us-ascii?Q?SUedy+17FnqhhBF3Z/NgD83TU7VsEQxe98JYGL5YmSEPDwyC6Wl0wia4x5vM?=
 =?us-ascii?Q?k8Voslovvf/cMRiv61XIVQmu62jXOhDbiHmFoTBSEKc3Qs8dvUqVwpXQktsU?=
 =?us-ascii?Q?PC3svNTfVd5OR3ekjKvNNXH9fSvJFpC4PMvLdUcaWAu5/gUIT5AvBycjspg9?=
 =?us-ascii?Q?2USOOhfw6q3KQXkCW5ZafbWsvoAGDA3nWbbZsVSgI0d+lHVcdUTff3AhAwhA?=
 =?us-ascii?Q?SUcJf4yASNgkJMD3G9EuigeUVIB8EHmypEgPVzuCO3cCcgUskykQ3v/tVwIn?=
 =?us-ascii?Q?oBtLcvaYwcxuAlRI92G6EPvsQEc1/Zyhu7Ib3G26Wn7a1grukmin1Itl6Mud?=
 =?us-ascii?Q?WUDNEO1hAU+YDVoVZTw86jeLqZeJKC9Y45EcQfCteeyESH/KLv1Bzv2NUb9e?=
 =?us-ascii?Q?aNZE3HYRmFWMK5yAhBN2pmL3LkZsl8Rf3XZHYExNBnpJmK3wuYTd+xfDTw3K?=
 =?us-ascii?Q?PCGcME7t9PwFAIYTwxbjTglGhEKlqiNOo/aPmofyG0TcbH0NDfTIC63Df4NX?=
 =?us-ascii?Q?QWymn/p/LwlgNU1AY+bUays67/6NWblfxshfnf0bfQX0qubBvSAdkghOLdoq?=
 =?us-ascii?Q?ZFfl9aON7tEEBOiXKiMmQB+0M98ZAYL03x5vzXwhY7xp2rrjU+5G2i2flbYe?=
 =?us-ascii?Q?d68Vw8pOv9hTirMP1CcjdqQT4c5rasMawSwMuQqwucDNQFKYREgxsgskgYab?=
 =?us-ascii?Q?cMYgT8qJ3tAspVp2xNHeYu+WeTmZg8yj/IhEutv8nWi3FaSbqLCBdR7RHVdQ?=
 =?us-ascii?Q?rA+uaxO7wco97Lbm9Y4M0NBe0WgmDUhhCa8Tp+zv431Abf1dgvS1mlyndd8e?=
 =?us-ascii?Q?Q6FCimaFgFn++104FO5BT7273MLfzKwr51YgErur1o0aUfmy0EUXRbD3bCjI?=
 =?us-ascii?Q?I2iOuMBogs8eeq6y4LIW6+ziwEAmSFTUHZqJzBzJIMLoOEPmHQQvxteB8L0h?=
 =?us-ascii?Q?cGGI420YKdM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O1Nho3elJcYCGEntAtMZ0WiayKYxyfw2XgaJxxMLyehJPJzuSZw7eza0xzzU?=
 =?us-ascii?Q?kKQuTtYat57Gv74VFZLF1RaSwb6VEuofgwKlLUft1Pn7o35v4IXe44nw4Wgg?=
 =?us-ascii?Q?sCZUXvEWRy5MusQeYN1LqJhDZo4UMLeYwjdv6fl6Bvvu0jYGPvnB+g10d7iK?=
 =?us-ascii?Q?Yx8rJl1cKUUKMGO3O642zoXx0U2kEGjDg2N6vT5epB1z4K8lgglGNZa8oPYx?=
 =?us-ascii?Q?5BNOcmNyh+2W8HMI0f/jUcg5bXjDdWNYrTrrngCW1yJGvt7u2GY/ZL/UfRK5?=
 =?us-ascii?Q?mlAd7fDtJMOs41tbLmwOOiVTVCD6yqKwYqh8k7gF3CwXfcetWLYwj0U4ODGp?=
 =?us-ascii?Q?udV6WHPctnjCzaS3OfQOBmwrNnaJw1lDuU8dsBrff+E/QGnvCzzK3XqcK/Pb?=
 =?us-ascii?Q?TxMAnKXVNhpwHOO5qRPNjF/e3Z76UZdt7JJ1jvz81hex3Hg0zsTGMVC7eRb+?=
 =?us-ascii?Q?QDvtGqerWXv9cc8jOVnuvxrd7ljskONJW+QL11PYK7jTMsEG83QQT7ORzhur?=
 =?us-ascii?Q?jJG62fXgUOvj8JO0qD2Rd9Wnk749/TcEGdLynRn+A5u434PFQE6TVWbvo55i?=
 =?us-ascii?Q?OX5WqwbYLpuFa6BAe31ZcFLcYVA9tyqyWIz6HcDXVSC/luYWAQdaQM37zU7K?=
 =?us-ascii?Q?ZHXEtsxIdPc63G8tY5fuSddwa0WatOH8RIJ4Z6Ip6tM9KkV130ld8nXOG84L?=
 =?us-ascii?Q?brKMuZLh4X8AFN6UyGoI2Qpom/m5UOC9HGNmNfpPjZFQr8eQVsDXeeTH2mCg?=
 =?us-ascii?Q?4+RGO0d8hFuWDexaCuJxOsYSLoUR08PebLLIZ6w1qXDsfVnNrHjgd3RzK9kX?=
 =?us-ascii?Q?MDltKaLCSNvZR9P0Xt9Inlwcw4x/QcLd47IMk1aFOo5WFntBwX/RhX/jdp0I?=
 =?us-ascii?Q?FlNn2peG95z1ZKd8RO5oAzmZ7szRKh+gG32gflNFAj3xzD9OAbg9KTvsEXiN?=
 =?us-ascii?Q?hTZjyRKABzf/oqYC9t12yxbbYPOT2RLJyOa8g8DnOjC8ZqHhhW0Cnt+RLC5C?=
 =?us-ascii?Q?JMANfbkTndYv9wQUg7p7/qjhXWTzZwmJhcQWWqO13x7y+yj8SkHBkSVZyLih?=
 =?us-ascii?Q?4C1VCrydBeqeNdEVG95npxaap5K10wePOG+LhQnSTSHDuGr9HK8NyOvq4r7+?=
 =?us-ascii?Q?rkDHgQr+7y0RvpTBD4z7ZVEUjJA9NKOcf74DKhYsHzhggL+YkxnOdgFx3RLY?=
 =?us-ascii?Q?x7AgIr6HDiA0i+Ddwf8O+f/beqbYpINFon7gpCuILjcrEE9hNJTe0God/Juh?=
 =?us-ascii?Q?dzG8MJaaNA/+yf1hhgwQ2/ggDUFsWEm0r9ibHXupmDrvgO52Ob/fk3/DGjxj?=
 =?us-ascii?Q?ktoVBKlN+GrNLiWrjzXwgPcWO3xXaR1D+ClOcPl/JkefFDe6Juq9X4HPIfsd?=
 =?us-ascii?Q?ZlB0R7pzjef0EcFnp2t7j3guPb8T5uQQubc+rBqdADFjkRXk2xqM44O3GvDW?=
 =?us-ascii?Q?TvCWPyz3XGMHPDSr6BjkW3vFfuqqPh0vSo66fvIohdNdCF+1iw0GhX7L8HOj?=
 =?us-ascii?Q?InuQ2Vsm2Jekj/k+/pNF29U+Dwf9zOD/pHE3E/+un+WdxaQrX1i0zlfkpHDp?=
 =?us-ascii?Q?xraep69ru7yN27q0jmNIBtY2VIIM03HmX68sFMMGEbfPDe3Ke1ee+SVTx7z1?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bd4d3d-8f0e-4b3c-5c4e-08dd7e0310a7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 22:56:18.7108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxmlrKAI9ffUUh5F7gC61Hl80G8p/yUCFs3y9Yim2qmJkoaoF7AXTIWtPHyoeuoW+M/4/aK46KS1hraJ4J9yYwyLzKJpL8wicDKLTURTxgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6651
X-OriginatorOrg: intel.com

Andrew Morton wrote:
> On Thu, 17 Apr 2025 17:10:08 +0900 Rakie Kim <rakie.kim@sk.com> wrote:
> 
> > I sincerely apologize for causing repeated inconvenience. The series of
> > patches version v8 that was merged into -mm, mm-new today needs
> > additional corrections.
> > Link: https://lore.kernel.org/all/6800742de6315_130fd2949c@dwillia2-mobl3.amr.corp.intel.com.notmuch/
> > Therefore, I have updated a new version v9, in which the problems have
> > been addressed.
> 
> No probs, this is why mm.git workflow (mm-new -> mm-unstable ->
> mm-stable -> mainline) operates as it does - to easily permit revisions
> and replacements as patches move towards their final state.

Perhaps something like the update below to the mm-commits@ notification
template, because I think folks misread early acceptance into mm-new as
"Hooray, I'm done!" instead of "Ok, now more review might be inbound
because Andrew has put this patch on his radar, but I am not done until
this hits mm-stable".

---
--- template.orig	2025-04-17 15:48:49.913337459 -0700
+++ template	2025-04-17 15:51:57.294617179 -0700
@@ -1,10 +1,16 @@
 The patch titled
      Subject: $subject
 has been added to the -mm mm-new branch.  Its filename is
      $patch_name
 
 This patch will shortly appear at
      https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/$patch_name
 
 This patch will later appear in the mm-new branch at
     git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+
+Note, mm-new is a provisional staging ground for work-in-progress
+patches, and acceptance into mm-new is a notification for others take
+notice and finish up reviews. Please do not hesitate to respond to
+review feedback and post updated versions to replace or incrementally
+fixup patches in mm-new.
---

...otherwise, documentation like that would be good fodder for a mm
"maintainer profile" [1].

[1]: https://docs.kernel.org/process/maintainer-handbooks.html
