Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD5F4A3C
	for <linux-cxl@vger.kernel.org>; Tue, 15 Oct 2024 03:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728963377; cv=fail; b=EtE3MkljVjKUYLqb2nuiuprnFJwv6EOLcgXJe27x/CRm5sdMKqckf2IfPgD9jpDv+4reN0T8mffP6nFsVKkLGXpRMDXa2vD/J+CdXbHAXpFJYjIgVEEmm1tvxbNOsBAWj5QUwEZm2RKfMeqjBkORDtAULSCVd8eQ0snwzF1Grn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728963377; c=relaxed/simple;
	bh=FaEKcuUQNkf34NhPoP9zhC+E868+UhDkMIQ9fWbcDRg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X3L3O/yXJud1tEGBVc/QLGLdT/XMRUx6BiPDBMWj7UKTuqn/EzKsE9DA9+QFtN4WlHnvZKTCzVR19yJ8xlmBDMhKT8yfnGtu84k05EJYDdiZOoA0mXpt2VR9LNlZZuxcCqpJy+Wrh09rz0cA6dAoyu7sOgRnpcETpqz5tiY/0+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUZHnDvd; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUZHnDvd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728963376; x=1760499376;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FaEKcuUQNkf34NhPoP9zhC+E868+UhDkMIQ9fWbcDRg=;
  b=UUZHnDvddlvLKjLN85hxGCTjlWPnaumeGEW6v7+aNGNgb6TF3twaw44q
   75hHA6QI6BSiNNnYPMT6KxtRD03j21baLznqlmrywN1QsEZG/LjR1XHRt
   WTQ86oRbbzQ1ERk0rE5zlC5vnhpGnbDg9afwJtn5eY0EFSWFgA6rCtrNy
   cGaysOSfSE3+TG37h3I/ab4q1tke7Pj47rZwSG7GpNJkh4My6Ia9le0xo
   xuU9OJlozsT5zNAlSbey3+3nlnTLxoDMB3No9nqIEotRGe0eZC+4mLowA
   wH3hkhUR4fGwEf2M9bwUb5hIr1UJOgGOgqjEgN+hyyjEIz6tdbcvaSUjT
   A==;
X-CSE-ConnectionGUID: U1GcO7pBRZKrh3Q9h+ixLw==
X-CSE-MsgGUID: Xn4iINsSQDe32U4rXWh8tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="38885554"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="38885554"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 20:36:15 -0700
X-CSE-ConnectionGUID: F7KH/xKmRua9/WwTq7vrLw==
X-CSE-MsgGUID: qxF+Y0jzRAy4ukgEGseEjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82536182"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 20:36:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 20:36:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 20:36:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 20:36:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 20:36:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTTaSEV3hreTaHQ8iYyYkq0fM3T/8xxI3hD2X/5WDPFGKc7hAp+G0WLTu/dxs58n2BgFBpvISbHQJc96R4W41FgUVaeiwi5RPBkq/xU0BLStpPj1J4Zp9nQtqXCPdOsh2GoxtVJUGIV8Lhisn922YlAe41ObGU0n0ChxsvlIuPIlEfejHxgqKecC35y0LilTbEQonXVjWhundz5FIxyOkqUrKC7ORMJHXiLAXG2aRQU4mG7B8+R/G5eaJaJhN/xzR5EguRtLgYxGcX3QT7BVkbqwGBjoR827AHuQtQQntSBP6VXZ0fIJw6EaR/qlka9C/RicQE2e5W/lzht7bm3xUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cMfxyaxG10CjNg0vjDbvtgV7t4wxdjW9HbXnLxByYk=;
 b=pvzSvYKFChLsTiGFXjIPOV0ebLBTH8yYVmQpNF8pLijLD6UKY8c9EoAWgeewnUNIDrFtiuiVb4YROqkUY63nQeHyXrGK4ip0fPTjPYBH06VqgxZWc8UcOTB0gV6Fcwo/YhJOOOeUcPQKBElbkP+sl30Q6ggSgJfeWfwCuOTb4LuNUNAKWxyw7E0c/JFSrtd9gy5r5Ta09kq2ndU2Bm3UukAcAR6I+fTJbKmKlhzJOdJKYmGgfditNOsOI6hjWRxNcGhAQiz2HjbDeIKPHYAa/NjYg0mlssE51dsjIGzKVnYbbrU6v5b7Dl6hRzPDLkYUZ6k1LuWZSLZL7Z56LlUeXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6833.namprd11.prod.outlook.com (2603:10b6:510:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 03:36:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 03:36:10 +0000
Date: Mon, 14 Oct 2024 20:36:08 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>, Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: KASAN error when insmod cxl_test
Message-ID: <670de32847e6d_3f1429473@dwillia2-xfh.jf.intel.com.notmuch>
References: <87y12w9vp5.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87y12w9vp5.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: MW4PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:303:b6::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 0606cffa-8863-477c-a716-08dcecca82de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gnyZSzS2hUKGFTWkSw+zohI/Fc90PEt6+Q0T0NWJ0QR3EiDtOWqj6x6ufCsj?=
 =?us-ascii?Q?Y1swZTtPHTnM/a3+/bblZpdEuQOr+inKlNvrR/GJ+h8zbvtIaysl9knhc0r1?=
 =?us-ascii?Q?LYzwEOq7i9EWyw34yXucYUPLYKEJfFKs66Xoq3IdQmgRxQyHGJeEk+3SweRg?=
 =?us-ascii?Q?xzcLgQVOnaMDBM5J3tBZkaiwcGEhXQDGe171fMrx4XTVW9G+QQJoAdzamGY1?=
 =?us-ascii?Q?K8z28CrLTTCDMVPAgW0VxlMvpMliWvrNT+b7c32NCTr2o+M3KAJ8vSLfLoUy?=
 =?us-ascii?Q?adTtzvjJZKEzxSPQjappVRhdVpcLIs4DEtVXM6sSB+nvYkBM/TjrMi9+gOL8?=
 =?us-ascii?Q?HoEmZV2roH7N30HsoTSBXEmWHt/IAbzzHk8Kszl9lVKfduhb/Px5yH1n61Ei?=
 =?us-ascii?Q?5mMiwpc0QZcVggRTl+DH1JQlCo8X12BLiSivnr/oyZ82umz/V8joE2wU7+pd?=
 =?us-ascii?Q?OLDtdmv+gycTj80tm/o9wiuldgdx0GIPd7wJpz/T/5NE3Pk2GVGSW5hOAv3C?=
 =?us-ascii?Q?IXrabz27njb1N7hY1fSmN7Fg3T3DjOwpICsQ84hoAP5ce6dCDhJkvhh8MahT?=
 =?us-ascii?Q?0QACiCeYOIXORqDIiup2T3tQrhceS/Zw0eu8ALHKJoc7mkpTv4xKpE0ee/E2?=
 =?us-ascii?Q?xfjRN7LnmIADO4RoeM9W76mZumZ8xehlbRnWb90lTrkEgEYSgLDn9W9Y2fr0?=
 =?us-ascii?Q?DC5bSX9LRvXuez/cOwgQBwuIiZRdUwtRGq7PgvPj4M6Mq80145d/+efzEBcJ?=
 =?us-ascii?Q?36Z7eRO9c93r1CeRENfr0y7zTtKUXfOtxpFc6mKx7XTdEqkVElKv6YjNWeE+?=
 =?us-ascii?Q?OR6YlWl/Is8uPLWjg/mS3t2Z3Qu/sIOC86We5MX1c283LekprOFyRmvI6j0L?=
 =?us-ascii?Q?1v+iCzm5OLdRlpBeIDwrLM7MC351FZIKe0PPvauSdyk0qJ4h4w7MAuTsmkUF?=
 =?us-ascii?Q?nug+GrtjpQSr3zixPy9jwuO9XGwZsuOB8W0/xTe3x+7ByAVXb2AgJQUa+srf?=
 =?us-ascii?Q?eZxowWFMuwPu4+eOfsuGbLIrb02mEV4Ayv+8Hgn+/3KDuGvk8Pe/6qX8+D1w?=
 =?us-ascii?Q?LsRNOXtA2JjYOvN3So0wDVcvzc01PeNLP7YiixPJBbupbIzmZjGj0UtRVh+1?=
 =?us-ascii?Q?H04sw5zNqTlz7aVNdAoeXu+dQbZzrxfzcPPefvMxeHYR64dw+jq0NJSwqX8M?=
 =?us-ascii?Q?z7IXVEJ237IDClyErnMUIVb/I0chhHWkRk3x9LYbCL05YReYckZpvho2X9bG?=
 =?us-ascii?Q?K0iV6Un+ttyTdQvK/WvPO6A9jCeUm+PZYM0qGMqq9g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ksnxm7B4Q+lxMU/gdbdgDP8ijlTPdaF5JN0wBJUKuNrH6n/vUYki6gI4ufis?=
 =?us-ascii?Q?LX/9FTaHa2Kt1qUz/aK/osqOp2VXiy1MaGegT5DSuCdVhPoXXXD8Z78JrHgy?=
 =?us-ascii?Q?8CXhcBKdd5+a9Ql5JOJtywONHGZ0LaTW0cg1SrsYU3HYDscLxwjCXhjnA1bq?=
 =?us-ascii?Q?C1han8SQ+ONKPbfG90hI1J1EOKBBBHOaDq2u3Orki8p9RU3v2wgrAYhhuFH7?=
 =?us-ascii?Q?sIjFxZvElk3tjb0/qO/VGTI194tkCnikVD32TyOXfzj8NIcPj5jbbqls5Kbq?=
 =?us-ascii?Q?nXfXrpjfI80lxbwMDOIsn7nNWUZEcQf0ohez2PxUcJRxP6PS0b5KO6ju3fy1?=
 =?us-ascii?Q?+bOLCFOpyJboM+/qEukF5N3aNw3rP4MIyW6/OiTV0dei0cRWKasXlbLYrYGw?=
 =?us-ascii?Q?WgRKGNWaQtBEY30NN71mAfKL9UwCBeZaAnheWR7nvkk2S3B+u4WnEz81+F0s?=
 =?us-ascii?Q?yXR+bghm5hm+w0qFoX+pcR+e2aBWdsvBjc8LpxCuzjqukLSfzHjaqiNc1ExB?=
 =?us-ascii?Q?KKIS0e80kVPFtuXr8V6o5hM1+qsqotOzQzU4+gRr8xMi5E9xA4ZzxY+eFKVj?=
 =?us-ascii?Q?eYf74/GVKpXU6u95YjAL3UXjWfakOdOIoVw7uPzHib0BdFSoUjf374GYpjui?=
 =?us-ascii?Q?zCGTBskFiTWYUxsogpQYRpf4ZG3FGu2QkmDeH87NOm2jsLws5eBnRmLKRsSI?=
 =?us-ascii?Q?ylumkt6b5tZRUmb4dJcrX2BRWlQuZiKG9CYfC6luj9EvQkquikyuDHSCtETM?=
 =?us-ascii?Q?Ezc+/v0EBcrfG56ew+6kkblMjNOkEayPRCe2ExrNqUCfE/nCt8qjppg7fr1+?=
 =?us-ascii?Q?DCFrtocErgFX2W+Rp8rZIgRLjUaYH1DVTc1WCHqyc4mlN0qv7OxmZ1YV4JWS?=
 =?us-ascii?Q?5BaDE+VJ+Mx6qW8SzHItA3OEvWa3NVfvtLHqAkrCeTHb+ba6mz6KAs6bvtLt?=
 =?us-ascii?Q?SAR40Nj9svW3C2o0+xHNUWLbRhvAfjiiqu0+rx6PDVy1C5seJH1i5vaN4oj+?=
 =?us-ascii?Q?KKInM3Uz854zQhFlwc4ppXvgHViy5Tnfptvcx974fMoUuymPGntCfETfgJGF?=
 =?us-ascii?Q?QwvZXKFkWsSRcdplxv/EanIvHSRkwTT4+9PgoRr5UHsF/86yytMW9+N2l10P?=
 =?us-ascii?Q?GUMtjLN6cFOqv3FkMST7w09j1LOHYkrWhfN3rMkgziVKrWmiRNIypEQMWKh6?=
 =?us-ascii?Q?o+hz3RvXGPqU/64HcgUfvFViVB02ySCFv8RBcxVl5h2jGrHjGKmMArv3oXxf?=
 =?us-ascii?Q?I/tNX8q4xPYEzFj6oYFd7SULa1B6qfDYPom2X76UHKsTSxCzDa2R+Hk1YesZ?=
 =?us-ascii?Q?G+Z4C4g8vnaYil04a3DNJW+8tqKutzRY4Ou4sGTe7+/KSMsLrW9OoAZJjE9e?=
 =?us-ascii?Q?uRrCT6efx300Zz/O8mbAzUibvMA+kcTySynZIcY/FosFlfyxgCyirTZ/iQLG?=
 =?us-ascii?Q?7t5QZdElxVPK4TU2H5wV6i0RADT3cbYIsu/hzT8+kqUVcPkYMOSnQAf5/NrC?=
 =?us-ascii?Q?5iKplU6JlyRWyza46B7UscIJrDAZ+zkYemlmZHLMsay8Nzi9LuUIyb3XfvmA?=
 =?us-ascii?Q?8DXc7JVyBiFuKPsNYEeAm0zCRUUrcxK/70s7+Dktbtdq1yCFGVl/0FBiPD/8?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0606cffa-8863-477c-a716-08dcecca82de
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 03:36:10.4132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoNz+2sfhx1kOKbvcUFT0upYKK8fjbLJBcrWvLd13Ha3Bshrz0BA5ZqCfY0bwhdY1N0FR6c/jYYGtZMVQBIqgZTe+7ewTxjN9IZeuumhXvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6833
X-OriginatorOrg: intel.com

Huang, Ying wrote:
> Hi, Dave,
> 
> When I tried to test v6.12-rc2 with cxl_test in qemu, the below error is
> reported.  Revert commit a5ab0de0ebaa ("cxl: Calculate region bandwidth
> of targets with shared upstream link") can eliminate the error.
> 
> Can you take a look at it?

Does the same reproduce with "modprobe cxl_test"? I worry that direct
'insmod' usage results in cases where it proceeds with the wrong
dependencies. I.e. I never test with insmod, only modprobe, and my
v6.12-rc2 testing so far has not hit this.
