Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E766286D45;
	Tue, 12 Aug 2025 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754957420; cv=fail; b=PVemLG1izE3d8JLsxz8V3wftx9yBXBneOe7CUYn/GsAGfOs1zn923VYx0WNFMZHawLIHHEseHBstO57qIjIHhN305KKAbtAsLQRTmal3MwdT+7swVkrKJJ7ioCLd3V+T5MooBp3ALzVMGt/DLkhA/qTlVW4jqUdEnxMvqaKQC9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754957420; c=relaxed/simple;
	bh=bWfPtoHrF/fvw96tTAvKItP7Hujo3af3VPbFGZ9bzSY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A4LpND5RVhu1n6QxI7uzm+qQHYIl96d0/ub3hLeJNrhmcvzG/Oz5v1OvA6ntojiA+gJ/ibjKvOh4qVJ3gaKWH1EnlM/B57Rw993VPZ/32QfY04KQ4Kgv2viGeV500lvTgeIGVyyuY166ewFbAaA+DAJrYG6071lZIpyNthwB2tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ih1339Hn; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ih1339Hn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754957419; x=1786493419;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bWfPtoHrF/fvw96tTAvKItP7Hujo3af3VPbFGZ9bzSY=;
  b=Ih1339HnQyAwEttvzLvjxO7Bp4MHr1oDckkPA8S56b3aZuBFXuP4m322
   yHGBOelP5klvMiHttqXSyBZJymig7gG9V/bht70ssxNxG6vH6WKq+aL7e
   4rV2iA3hQ69y1KPJ9SaEztfVF4FSqeEn5kkXoTzSNDZn+uiUhDcBwM5BZ
   qdmQSm278MvkMSPnOXkzopcYEYs5zgSxnue/w/4ybWThIa2LKE2hTdFFS
   XkT5waMBRgqRcVQf/PevdSscDe8miD6LL/BsPABc8M+mp5encZCbnt8AW
   RuSBj4/4mQnSU7JM6+XNGAMyF1jmw0MmX5uYKvtNgFH2FVx/Ttt+sg7zN
   Q==;
X-CSE-ConnectionGUID: ZuXWDZ7YT2esZxqSlHadrw==
X-CSE-MsgGUID: eZGZ/s2HRyugHy2Hc1XIxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="61019860"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="61019860"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 17:10:19 -0700
X-CSE-ConnectionGUID: Pw7cGXjoQjKwyNBt8vOR6w==
X-CSE-MsgGUID: xBe5kjLGTm+v/96OZOwM3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165936831"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 17:10:18 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 17:10:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 17:10:18 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.61)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 17:10:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtnclpjpjHbe/PlEd+U+wtlNz2l0FxNfEtS/ThNnQXzE9CzrEj8HgYx51WhPw3OofHaLspvfiGVj8VRo3KqLIwPrZQhwo1zXv6wPpe4EkPisl340mIikv8z6oB/U/EQ//4SNasJC1jJbDgyDeKPZK6e6Pu9ysUaqvgvz39HkTsWSQKOWHyGehsXZI3LaIRDiYjE7FHysvSbN94HM+dmR944FoOoinI7DPw16cADZQKQ32CPwcYZKMAf+3pcJaXGFV+cV85PCNQiId03wBU90ja7bFoTtjOf1S0gOqUrc42ogYSn3kHGiokkEC64H4kQpOsxh/mpP9ADd17SJq/pIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gk85lbc/P5xyYfIIRp+Z57duQi83oFu1ZnyVDGXQWA8=;
 b=VvalNbipKWn75gS0a6Z1lf9ccG1zhWiMREkeMZNz5iOqBiogouH7bBG0na4DzegGH0T9JBQMn5Z1nlbjZhZ9tT2uYvB7vwG6sJq7vWzlnag3TouXQvINhbeXyAk2dcVg6rS7tz1VibOkHCbvNFMl0LUl49GClESdgN0iU8MPxsx4Ouryf2kDXsrHQ5Rfm1J6G9gw13YxkuGZxXhKLuq9fKhYvY/0zKooEaHFCyoggQGs8jN2t5zRkaxTu1Tz+tgaICRsYBg8hiepePnVEggl88L+0AMOCTZs5m0DE6MWVl4lTS+N06U5wCBs5E+QSpTSUV/mDYZuv5QefBGQPZocgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ0PR11MB7156.namprd11.prod.outlook.com (2603:10b6:a03:48d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 00:10:15 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 00:10:15 +0000
Date: Mon, 11 Aug 2025 17:10:11 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Nai-Chen Cheng <bleach1827@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kernel-mentees@lists.linux.dev>
Subject: Re: [PATCH] cxl/region: use str_enabled_disabled() instead of tenary
 operator
Message-ID: <aJqGY7WnLYoRlMQH@aschofie-mobl2.lan>
References: <20250812-cxl-region-string-choices-v1-1-50200b0bc782@gmail.com>
 <aJqF7cEue2rGg_ka@aschofie-mobl2.lan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aJqF7cEue2rGg_ka@aschofie-mobl2.lan>
X-ClientProxiedBy: SJ0PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::21) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ0PR11MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: 1009bce2-a8d9-4bf1-0f23-08ddd9349cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1yOPLInRhn7XSI2hWMuWEDnCAYEyRXDINREyFODBoIJ4hZniZhoD9qLL0Ihk?=
 =?us-ascii?Q?FVXmivKVTPwr12dtenQa5ul4Arw2hiB/UA/awy3/zDBnoo3XTQ5pUKTlYQUg?=
 =?us-ascii?Q?GB+f/haAmhvvyk/HqcjzsLksneuA7c0unye+iDm+LL2XRdSZZ5isOyzXqP88?=
 =?us-ascii?Q?3aUwPGhIB1/e1JDs7cQPuj5OI0j364DgjyrrLIjQG8SWGx/1vD2nZAKghiVo?=
 =?us-ascii?Q?o6GDiubs4UCFvwJ7zoVQ8AcDmC0DHtIE6WH2NktLHhkGl11hcTl+TBBHb8u/?=
 =?us-ascii?Q?V1UGcQo96uuNlXXyVKpizNQwBIrEcy0aS13K4EffZslRpEs9izuZEC+iHizt?=
 =?us-ascii?Q?bP8qN6AV2mYX8sv89wlHUqSc3aOqZbf6wif+RqKb1PtRPLur0aRppK9HcIDi?=
 =?us-ascii?Q?iI1FsA/68GXiI8YuRF0s1g0QKaYggDf84ZuY2wzuf1loy/PzWjLrWoHqzcVW?=
 =?us-ascii?Q?Vvxl3pCoczAqluKUVa9Sz85TnDZHi5BLpFH/coSWQlXP92CVe6z9p6D31/BP?=
 =?us-ascii?Q?4ueoAwKKuLzjs1aAe4llu9lFfLXS9rU+/kOqenuFfThYvOpkJzQiTyeq6vnv?=
 =?us-ascii?Q?Zlp+9//bfxWz05H2vH+cnczM5qemLkQD1ena0umpmCe0WguiCctbkjXobHiG?=
 =?us-ascii?Q?HWfimjeFlhX2CTAj+tLtehw6879mMWVpelbXhQUaX1tGI5+f5gUzOjmXouOz?=
 =?us-ascii?Q?Ju39O94M/UBNNxbqhyiaP5YLzQshR7Ukc+jhHQq7CvCubjx+Y2QsXnViZNYo?=
 =?us-ascii?Q?NeWM6j6E7YmhBZmFQpunAe6kHQzpAVVoiSix8PhD+1DWOi+sKSigWmiIsPsf?=
 =?us-ascii?Q?veaC8F5n16czRHJkdEeWCVPaZZmhs2GyWT2VURE5xVzhmSyKyD19CStDD8Qo?=
 =?us-ascii?Q?foRcYHCAm74IOLDteMNYgG/R1VG+Wvgst69PXFc/j3hKwtF0YRA737ldnAlE?=
 =?us-ascii?Q?4/zJUj99/n2xD5wG/B/1ssveFhmFvGB5vw/t7c4wx3+FjTgeHYcQ8BaCeMWK?=
 =?us-ascii?Q?j+3GIKb/ujzF6awCokrTo2FFGmWtwXkyFKl5E8TlAXEYAN4NFD+MhLu3I7cm?=
 =?us-ascii?Q?LEWvxGuEQx7r33C7kauSDcNwNOm84u+n5yUPoD7aCJgmvRWJ61KkCtFXC8Ep?=
 =?us-ascii?Q?aSJR9Nio5g7B2QDKvAzc1MI5F4Ug4vv6qBGx2jZQyFgWw9V6NWt2GNpWO/9i?=
 =?us-ascii?Q?LhiHwqEx5QleOgSJ3WlPvuncV/WRxzrpLwgpY0WobBPv7SGiMo/tDTSWsauC?=
 =?us-ascii?Q?LQ5vi+8PXEpMPls9vdYZN33uxcyw65S7kQ/YHLVSp6ZIB69v0ETEo1HMl9tn?=
 =?us-ascii?Q?emWi4miQnIxoQnBQUbYNSxSwuFVo/9OeyD83nukI8wrZRx+0HcRLFWV7hZNW?=
 =?us-ascii?Q?up0xbOBBmse8SxLACaRNRVtHOETINO46rNktIzlwUiW0Fn0pzQkhzcpwM6GA?=
 =?us-ascii?Q?oJSsS02QJOY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?17DiYMxufpDsCkwNiEjPDand96yM1ZnycdMf2YDr6X0zjeRQKLYhUhJZZ5l2?=
 =?us-ascii?Q?gMZrY/biVCpXjO9FXhodDn1gjjY1wi6nWoovTFf5+LVrrLq8HIXgZ1v7tMix?=
 =?us-ascii?Q?B9AvQmf4MQq+h/tvszY37xqHRumXsVYl6SMHowKvQfURJm65bxiSH15/XiB2?=
 =?us-ascii?Q?VF6NrdDSfTmJR86BKoFMZJoiVM8Avmr3/zIjE3imrHRYzg+LoQoARPgDCq7c?=
 =?us-ascii?Q?hiZwuGq3cqF8hhGERHGksW1njjkxCqHU8BGgP6CIxFp7+4ScfRxVDeWXmudb?=
 =?us-ascii?Q?S8Uv1Bp59VM5i/gU0XBXdMnBd1CScHMQZLC3UUMwEWt3c6gMByWduWNir87Z?=
 =?us-ascii?Q?0zLASY7ixPyFd9JngA19VErLqYXOKQynjlndox15fV43pm2tfyRMlXfGSDgC?=
 =?us-ascii?Q?LUR6Bhh/vG0m0LKmyX57esWtf172Lzy8XMhM8gaUm1auKb4TY6zgvnEZSCOc?=
 =?us-ascii?Q?NPSdQqOr+ebW7KXEUYS4VF24TSPb9a55Qu5rZad+QyNKwUm8/zbzsdfK8RM3?=
 =?us-ascii?Q?D4gbygqYuWNf8BoYbVVZQDGZqu2pFtfAVoG3iAJl79+sMwOTfvRGfunlQoMQ?=
 =?us-ascii?Q?/uh/jhfHiGYH3sdhGTqqBFgKhZX3IS1g9E9TMjRVbltdAo/BTJu0FubnjAXC?=
 =?us-ascii?Q?gQayERhoNnwLT5prciKGvvrxVQ5kNkya5KNkvwvlvX1GbUyDIWNuVaSkCDgh?=
 =?us-ascii?Q?cN9haiP7juOredPXxMKE13q0SPVKKMjFR3M0FMzoRpRDdKeLLCzJYeqwbFVL?=
 =?us-ascii?Q?FB2lA2gcsSaXTFNO+9ICo7moQ/e8UQfAniKZ1Ar+YcBFI2XqVrJfxNHL/Zw1?=
 =?us-ascii?Q?gbJPhREV0i887vyb/68bUgORnXZK2Ap5ClkAv03Cg6cgk2GfOeyPalEOT5/s?=
 =?us-ascii?Q?6NX/uwwEZCA2y//QITESDKmwmLbTF4WiPL+kWUEDL0wVo3TZobGeOhH/liwN?=
 =?us-ascii?Q?ptLeFuttRcrVocWv2QRzbkpvKK7IsXFNXXZY8Ym2IJoaJlIulvxvoDleOYft?=
 =?us-ascii?Q?ppaolnUhCyscDXUcQbcfc+JLlVLiWhWdCJZMIbYsTXVZSQnSRp8ih1NmEgtU?=
 =?us-ascii?Q?ADtuzzKECj/Qaryd8Zy54IFIDkR9FZyTPisLonWFe5W1KGhNPtXes+ssDmnc?=
 =?us-ascii?Q?PNH3sUFlXDe76r/rlRKgoKIqiJs6zwA0ZhOHd1UazQf9nHwQk2tylj5AXVnZ?=
 =?us-ascii?Q?XtkLoJcOMhyH3EobZAJqrGSuAokIpo3nfWEDGmiw/1K4mI/qOoxK7ObicaR6?=
 =?us-ascii?Q?Gfn5wrgICasnHYckL4Zn2zIh3KKnsy4GlVWXUn18R6UAv431H+BzVjrfDvFs?=
 =?us-ascii?Q?zarRAvyaz0flnxrXw8/onsvviHFlYwMvNwljQ7NtX4+48k1cAebpqgl4aGdU?=
 =?us-ascii?Q?nZQ4O0+UwGJPD6pip911hqPgNlEzHWMIXXSzB4sDC7xcFnnAbEJfzYK6Arb5?=
 =?us-ascii?Q?B43P0QQ8Qva3SNXtmPQwz0Gf4G53I0/ldL6rOa2uhHe6Vd08TYJLPi/cD8ye?=
 =?us-ascii?Q?ttkQ4VZUiwPcX6mHfjBwc3n4sYmXKr970PEUxcC0MJLEUPi+PkKfZbqDLSoq?=
 =?us-ascii?Q?qWURpO2KpAPN/tL5o8nulL4j/FPHiCwoTcEhVKjPRWU9fmzMpE1N7tmRDv+b?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1009bce2-a8d9-4bf1-0f23-08ddd9349cdd
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 00:10:15.1894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJe4H/9KIbs83wb1jl60SOlSedckro9ETfCIJbACQyqXysCTi12oRZqiBOtHrmY053zJvoETmVX51YIJ1wNV4x38ahoyTBq07j2VJLoZ2Vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7156
X-OriginatorOrg: intel.com

On Mon, Aug 11, 2025 at 05:08:13PM -0700, Alison Schofield wrote:
> On Tue, Aug 12, 2025 at 12:49:46AM +0800, Nai-Chen Cheng wrote:
> > Replace tenary operator with str_enabled_disabled() helper to enhance
> > code readability and consistency.
> > 
> > Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>
> > ---
> 
> Thanks for the patch!
> 
> DaveJ - Please fix-up the spelling when you apply s/tenary/ternary in
> both commit message and log. With that, add:
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
> Nai-Chen Cheng - If you're able to pick up a related cleanup, I believe
> drivers/cxl/core/hdm.c has a place where str_plural() could be used.
Oops...I guess I should read these in FIFO order. I see str_plural()
already on the list :)

> 
> -- Alison
> 
> 
> >  drivers/cxl/core/region.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 71cc42d05248..83d58787b5af 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/sort.h>
> >  #include <linux/idr.h>
> >  #include <linux/memory-tiers.h>
> > +#include <linux/string_choices.h>
> >  #include <cxlmem.h>
> >  #include <cxl.h>
> >  #include "core.h"
> > @@ -1468,9 +1469,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  				dev_name(port->uport_dev), dev_name(&port->dev),
> >  				__func__, cxld->interleave_ways,
> >  				cxld->interleave_granularity,
> > -				(cxld->flags & CXL_DECODER_F_ENABLE) ?
> > -					"enabled" :
> > -					"disabled",
> > +				str_enabled_disabled(cxld->flags & CXL_DECODER_F_ENABLE),
> >  				cxld->hpa_range.start, cxld->hpa_range.end);
> >  			return -ENXIO;
> >  		}
> > 
> > ---
> > base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> > change-id: 20250812-cxl-region-string-choices-f5aa9832346e
> > 
> > Best regards,
> > -- 
> > Nai-Chen Cheng <bleach1827@gmail.com>
> > 
> 
