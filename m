Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29B33ECBCF;
	Fri,  4 Sep 2026 05:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499893; cv=fail; b=EMMYHzzTZtOibMwnMzLYgGv13J85DspEWGY6F2dpckQ0udyFIz5eq4O1bOZLRubDSIESKwUWCKx7KPRsCF1iOr5gwMYzs4Qfx36oUAsZ9/cndWo9KiHS6oOsx7H5Qq+NL7DL2QMaY7t6KpaR4o8r9JMVzKxaUU9soRjxfeCPY74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499893; c=relaxed/simple;
	bh=4Ibp7RjOoyl/xE7RWUNYA05irJ4ZXwM2aYuXzAyAvBk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ORXJXEaj6fdsbtGooRx6r8j25hoDXOXFXCEmJjSBQPyokUoop+BGiTS8LvftcHUIz1Vsf/fPmqiRiwvU138OytFvEXDScYws/GiC+u7GY04bsEgAJw33O841GRk87aZUXCvIgp2mytf814qXCDYgI90u0xRJuD6YMxVCsGo0prg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TIXfnZo4; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TIXfnZo4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788499892; x=1820035892;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4Ibp7RjOoyl/xE7RWUNYA05irJ4ZXwM2aYuXzAyAvBk=;
  b=TIXfnZo43JTl7jOcP+TXbX2ak8KfpFPUeCkJaNaYZXcdYblKPfXa2ZT4
   cJKKGHbWHvYawN48PGgynj/kjh7G4zEg+hRDfPosTswfultrcDVN1nG3S
   GrRqudI5xixOWunX2DWqIUX4XlecMp/WEhepJImF5zZF84c9PwNwKEKr6
   UbMf5/s/RH/JYndn586Q5jYpXICyvrfRUuWMKJui1xH4SQLF4Yw9F98SG
   1Slqc7BJBjq2/1y8RdG/Xu6PZlAKJXVfhsydTpFmPAlEN1ETxnWw1Rxz+
   UAMkfb5LyuanGZ9AsXwPt5PimgXU9FAStEvjAORWj1VIx/uPoyKiUkATO
   g==;
X-CSE-ConnectionGUID: bUVQHcDUSpmR13uj2SEntQ==
X-CSE-MsgGUID: G0ZjjgDpSRiA596SDW0s5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="99326794"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="99326794"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 22:31:31 -0700
X-CSE-ConnectionGUID: 7LXXrwy0QAeiqnxjC6FkTA==
X-CSE-MsgGUID: K1kBnoPsTYilMFCTkSlUOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="271887774"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 22:31:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 22:31:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 22:31:31 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.63)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 22:31:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPPcA9yWSWzKPtH/HgzNqCwDZPvGNYk86VCHj3HShe1IOfgI/+sqQJMZcjd41dJ3o3wr84xD0/qj/yY+Tpgri6L6r+RWi7lRKV97BrC7gHm7a2Z/3N9eqf8Py4JKbJZnu/hTXkBrgUNZKlBCM9a6dXBo1vcoJ73G3KwVeAA5YSgWRpOWulQw6v3Iw2+5mcCw3lEYXTkGnPbkVQvu7+obIvMIoJhKJxE5DG8f/GlY7KrUy8hniiLtkX09/EeFP7T+lwM+2BJJx3rEyjIc3F5X5R7oey6HVex1UFFy17wexBba07SY2dBkH+uBKG//VbH6mFwxgthLKOXvPhCMEoaPdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8nC965A1xGaGBSjkDkvYCFXYc4Kdli15z3b2K0Ww/A=;
 b=ie0HAgilij/mZhH+LxdJgKzejSQphKkrOTU9N9pNDWhlxfMA/NYJmc2P4u0NipxOHNfJbParATWfiyYyrEjJdDhcA/cNwM6P27C8LEj542wnSfZtbYT+vAsJkdNpUIP+WfSHH2wo1/wU3IDzffooO+ZPonuGIKIuLqfVn4YGtLC8luFK+S2XdttumhVOzpXalQV25y/50hd2m5E48LaaTJRkVZPHl1a1rjWlE/OBTIFO0Pug+ijZBE4cJ0hNKptSSakoJfZXoYxyqcGDeL1DNmHyalBizMG7YYbzItf7OI/3a6BaO1WkT3uEXouBsfQJhsy+XTWh07MVrFndnilTYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by LV3PR11MB8553.namprd11.prod.outlook.com (2603:10b6:408:1b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 05:31:18 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 05:31:17 +0000
Date: Thu, 3 Sep 2026 22:31:13 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<gourry@gourry.net>, <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kees@kernel.org>, <newtonl@nvidia.com>,
	<kristinc@nvidia.com>, <kaihengf@nvidia.com>, <kobak@nvidia.com>
Subject: Re: [PATCH v7 5/7] cxl/memdev: Don't overwrite the error from an
 earlier partition poison query
Message-ID: <appXoR5rCn91KF34@aschofie-mobl2.lan>
References: <20260902053839.25595-1-icheng@nvidia.com>
 <20260902053839.25595-6-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260902053839.25595-6-icheng@nvidia.com>
X-ClientProxiedBy: BY3PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:a03:254::30) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|LV3PR11MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f6e9b1-37a5-4309-7fef-08df0a45be8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|1800799024|376014|366016|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mF6ECmPjNuamntwAojea+c5vjkbk4NCqf5rvi8hEwfDEPpXXyRImHSCSUspwdrr3bH2BJXbC2Kr1qjjdK5xCfrhOXjlw6xZ0/09WaBZEDu3ZsXUBxXRA7/P35E7o42GzOoOpH91CP4+3hxaZBPbWRubrsa0JfZb7ejzj6cELN48KhlV/XMDcD3QLGUhHf8Hp20XI6XcYxOnX1sbvcGH/UU1wopEWTRaXkWkJfqn4n9WKgGFRBKZlMy/JoTPH4Bl0/Qcs42eMY06PemBXJxRvsdY13Rzx3R80SSQjqGstbj4HA57mdddNgGbudkM3I/ZrOxpDqsFXpXTevIDk7xDka6W9x1GAoK0nZre9+emo7WNYoa7wcjVDeJhSCNIaCqIZf1kO2U7fI4WVEik8lRas/kPs6wQf0o9y6O24CKetmITzs8awLtGAgfIlAdOuJu8ttv8qu/sFPs6TlESptKmUPuNYREHCGSpVmXngPG8M20KMUDiGPDH6TBQEBA32Iy8NxL/nbBAl1D2samQPNZV2yqD9wpME5i5jiLiDcQbun400Nwt9uAafAVChDeT6bz1jYdVNH/FTlI/tOIiV1P9ds+0mUTqCKSID3w3QyPKGEto=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(366016)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nSCO7Mihz7nCdHupvcWLPfIGFxbbl3Re2wN2SOifyogtqPdwIx4r383KQGsa?=
 =?us-ascii?Q?8lDW680cgVZZWdPLneINj787baPA+veEpgYxQw/nHoWNqyOr9HIkD5kZ4PAi?=
 =?us-ascii?Q?l1nUMLK9cAi+fcuc08UO9KeRCJVss9ModUDYrlKAt5juOo+VBn917YoaBURy?=
 =?us-ascii?Q?UxG6w/l/7xbz5HtExHe8UBOldfWFY0NWXejVZo0SJgAvax2Sl8XpSrM/LICV?=
 =?us-ascii?Q?THoJSEzQmW45y/GSYFyQjG1RlTYJ/gdSE7V93UdxdZPqmHoDXKXZa1YHnMgf?=
 =?us-ascii?Q?zI6t96+2SBhEtHRrmwQt1RqwiAae+iiIVXXGF/7IBummEby91N12EqpfeUOe?=
 =?us-ascii?Q?DJ8AGitbvIhE85hhvtSt5CzG5+DJK/aQjZbB3J/qeNI2Am8LE/yS7jYL3SP7?=
 =?us-ascii?Q?e5XvLLi/Rgu8lhELE+9w/Y2GlvR8hMqSC+qfXdv1r6y3da3Kip227PNtA/nE?=
 =?us-ascii?Q?HsYqVKGyfzQrBaZPo2qYTxQ/MuxNQnStcsqTCdt4uceAK5OUxpLBqA5V0tbH?=
 =?us-ascii?Q?yWtFch62fKcwFrU/+vooZKwCqTasj//tdck1oGANUesHrgWPr8I8igD/dWkc?=
 =?us-ascii?Q?5KfG4O1W4S3JC8nsNjNHUHlD+85/pp/IVpPgLnUeTPwhPkhgO+5Fq2OFnxd/?=
 =?us-ascii?Q?6yXt+btaAZ5pBuvwWL7gniHC+hs/Cf/Z7dy+pwFGFglGo7+h+wPB9dLkr7WZ?=
 =?us-ascii?Q?4mx2jLuoYnE6JDIKD0bUmKKFxbotII3X5UcnoWU1j957xo1ATF8ImnuTzWgi?=
 =?us-ascii?Q?CvRDs+W4KcmwlpFRmKUijEqefKv+vTnVKLAR0UogfIvlaOyqXc5tN5kcFIKn?=
 =?us-ascii?Q?vndX/TgR3LQp6FO7SqT+aH9cP3fVic94aqEdwgLAxL8XdcJ72wmngDg37uM1?=
 =?us-ascii?Q?mZmy+FWLjZgVKZn505/WYXW5HTJ+en3aaHQPFmmRGvex//6meTHwCdwGYsgD?=
 =?us-ascii?Q?JzwDQwvrTymf4PqH0DJCjtqAIgl61TAr1AjC+y6bmHtiu5TuYl156IXpmvKE?=
 =?us-ascii?Q?LNoFY+kUeS/NpkrfJwMkJasJQLoNlzQxVyVN8MwyHB1hrhKqGA3aFFoJ8rxp?=
 =?us-ascii?Q?bKzrfOWjKPbSRCF7219g5mkG4ijIg/JRPV36hzc2scNIf6214kPWKkWe2YKi?=
 =?us-ascii?Q?SB6RHe3GY/UrhqVswmKE6rLQUwtR+/g/iU7203XKFEQ5Ljl6nLsgZB602Zy9?=
 =?us-ascii?Q?2lgiOrgXx7lId0KUIzArwH6uhK2Nor/D4XSKhvCKIuyaoczzE2Gc67cjPDSJ?=
 =?us-ascii?Q?fM4rfE36fspSGaiDdHhrPyeYd+QljMDSwJTogqpG769xUDYpPVFxZg1rClC2?=
 =?us-ascii?Q?tveGX3WJQsvN2FHV7mG1XuUZb39/TwXdt4clOyIgKcYuCcHp5T10+ZCcNVTy?=
 =?us-ascii?Q?8jcA80+bBbLpz0LqF2gYjCdi3V37aEOV8gM2qRXefLj9UkMZ0kVY4RW2we6j?=
 =?us-ascii?Q?KKKuWXyXTrjwMM2sa/F8d9vKDfzA/eWjVK5mv3Xmkk/F3cx+KLcP4JV1H6Cb?=
 =?us-ascii?Q?g+K4KdP8kNHuwbR6GxNI9VzU9UmSuP717bCwgh8c29+1hflp1n3QH9jgj3wW?=
 =?us-ascii?Q?vukEKpGeRAOiwNZQiF316LIZT7stj8OuUHYlVyax0U0pIc7+92xIe92S26ww?=
 =?us-ascii?Q?jb1hfpQHVqAL7WQUZ3JF5TsVC2KWxQdtTz7gZUz2sZ9mX/VWfPkWbNlrFQyx?=
 =?us-ascii?Q?QVAAY3bbKxLp17Qr3RiFdNPtCrR/ttSz9+uGYLUWrNXo1l01oJEkY0jMAiNL?=
 =?us-ascii?Q?wGcZ+r4+lodBk6rj+Ze9gWRNd1mdfGs=3D?=
X-Exchange-RoutingPolicyChecked: sdpGU5pz4taB1/NFPtXUB7KjHLGOamqGlHFQ9dWMVRHCPEq1/vXep4+etVixxl//ITk947hC0kgA6CNdlu7Iay3Qb98xeCWSN6AFJkp9aDaJ9f1ntf16F+6KwHyELTgVXgtHu2+u/rqpLEjV+MR9T8kDIyVQNVsEwprVsEbZyLO18hgr9JbqsItRoyy31nb0cP7/wkf7IIN9mj5/ZylHy9gzGiS8rwjqOi3C5xfXnG8Y6RVVs6d+pN8EWvDI7hAC3alaWakzU13+WZW0M0824YHBaQbcY7EAWlqjIYIaJuCPyJRIm3mADKuD3EMqUSXzkk0PTB1q2JpKMjYeGpSMlg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f6e9b1-37a5-4309-7fef-08df0a45be8d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 05:31:17.7816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8INlEAx6ey3CxeXAvZ3DwYL0gaGjcqufOGfxo0LY9KRTejvtceyz/pvjT3FtuQmHWjsTCEExWliOGnsmdH9xeSdWxv8R97WqNHIc+jN2H6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8553
X-OriginatorOrg: intel.com

On Wed, Sep 02, 2026 at 01:38:37PM +0800, Richard Cheng wrote:
> cxl_get_poison_by_memdev() queries Get Poison List per partition but
> never checks the result inside the loop, so a later partition's success
> overwrites an earlier partition's failure and the whole scan reports
> success while that partition's poison went unlisted. Before the loop
> conversion the PMEM query returned early on error. Stop the loop on any
> error not already tolerated as a RAM -EFAULT.

Before be5cbd084027 pmem was queried first, then ram, so a ram failure
was reported after the pmem records had been collected. Now w the order
reversed, breaking on a ram error means pmem is never queried. I'm not
sure that is what we want.

What matters more to poison list user - a truthful return code or every
record the device is able to give us?

-- Alison


> 
> Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Closes: https://sashiko.dev/#/patchset/20260708074228.43654-1-icheng@nvidia.com?part=5
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
>  drivers/cxl/core/memdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b3419df586b9..e39b3d13fd56 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -231,6 +231,8 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>  		 */
>  		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
>  			rc = 0;
> +		if (rc)
> +			break;
>  	}
>  	return rc;
>  }
> -- 
> 2.53.0
> 
