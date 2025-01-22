Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7090B149E17
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 22:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737584718; cv=fail; b=Iuvxjs+oS57fx+V1Knc8It2ld7l/GXHlfe14Cz0KSS4O0nGZNFwBF8QhD1NfJBDWFjFwKpzIL/wOAstgSe+hFqk+mS3wEHP7KqsfcUR1+DTiorO0Uw21Wt0F6PbIQXi/Qm+tqIPqxmL4OX9m3e3p8RcGeBRPZvGVPWqyjfmu+P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737584718; c=relaxed/simple;
	bh=WMc3PHVBAqPvyD41D9UcQXNydvP9gvB3sjAvQ35Hl98=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tP52b/zfHnckp6q3CRCo8FYJ6KlmURFovYJ/brPtg5i1EeeiqWKKeao6p31WxZLpc9A7cVRTHxo93VOeYWIcKiRwmEMFe64M+M5hrCVsPhvCV6knXGLw1ZSR4OploJx12YYERwfG6l04R7J7f8CTdqVJKChEQGd0tk1qNxdjmJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b0X6JMpP; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b0X6JMpP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737584717; x=1769120717;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WMc3PHVBAqPvyD41D9UcQXNydvP9gvB3sjAvQ35Hl98=;
  b=b0X6JMpPnCvQUFWGsbQXrKI5/JZyDQurN2zMzBBLuWN/hy3E+CFqJzle
   VECOW9/OST6hsM9HOCtGFeKu3i2JyygXydR4nYyC0UoxnM8eNlbAxD7/0
   pDXLve86/HOp27qAE7el3us80d1+c/ho/5+FwEz1sl2Tl0u1m5R0/mAnn
   zo3Lmdgx+3VSP+BQJrw6kbanWZJvd9xN8applad6LLp5eUfrduRFgFXm7
   hco9MtwX+EEKUDeikYfEawTfly728J9CImjVfeYzS8C8lI3p9U9susdQE
   imYjrwGE/OQeOSdPQ1BB7StMnf8Dj15HGbLSQIh8Mw5gPvC34WUz0ZH1+
   A==;
X-CSE-ConnectionGUID: amDdLx2cR86LkMd6wh1mmQ==
X-CSE-MsgGUID: 8fhvH3cBQDGdVnl8tAlCPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="49054301"
X-IronPort-AV: E=Sophos;i="6.13,226,1732608000"; 
   d="scan'208";a="49054301"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 14:25:15 -0800
X-CSE-ConnectionGUID: 7uS6FgBgQsCa3Uuy43ZQhA==
X-CSE-MsgGUID: eVlv3RabQlmpnZiwSIkyWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,226,1732608000"; 
   d="scan'208";a="112277909"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 14:25:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 14:25:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 14:25:13 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 14:25:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W92lFhq5WCD2vWhxzs8hRwGeRer+/rEevAJM4XpVTik9qJfLHIDBtjvIfAcl35NEfLrjuqfVCgnMqwYB/6iO0UGe583E9B0bOOZ0gZLaEWq3Ajoi7/5GBjLObp3q9NBDTZcur4PydWrsJQkZ2SljNk6VFskQpRSmLGhNM2mWvFs1Edl27poVjgq+s0SY4+C4bmPJt1KKIobVm6zXoWn+THGwl91eeFVr0siX2IJ3lkrZJgWeeXOXslgn+dSyYe1YdlAMdr5fa9OYnugXLds3QJYQ0NDMfvFCII7x6gbYUO2sn/CJp5TveOodHxv3iCr4WMVk0DhVSXQVqf3t83NpAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kDH6b1UxcodHbHvrfZQNLCJyL4JQeHF7X8pfXi5AmY=;
 b=d8hXPg0gMeqccGCkjuWi5PIeOY0Wnu4i3u8NtXAij4ujkXKdNx7E1ZpUcG35bGedcYgxEv2qjM11NETZeSLo/UCsQ6dBk26jbAiNUCpZOOXEQl7gPdLPQCr7crmlxXE8F7RJpOW+QVV63H1l6btz+amE6MyCmBdqR1aksnY0GXxE3jI7J3nHXMxGgo0dOJIjg+sgjo0Na8nS7aQRo3hfqpej4dO3abCgOtWpsJB+ex1AhgwAvgJs5FHcWfmgT32V6+QpMekmGsbw4pzitYK02270i69tINAWKriUdNx95tjUKsdK7trc/DI62G2VsYVf/wZb25T1TDjSHP70Ey0MYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW6PR11MB8309.namprd11.prod.outlook.com (2603:10b6:303:24c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 22:24:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 22:24:44 +0000
Date: Wed, 22 Jan 2025 14:24:41 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
	Ira Weiny <ira.weiny@intel.com>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 3/5] cxl: Introduce 'struct cxl_dpa_partition' and
 'struct cxl_range_info'
Message-ID: <67917029386b5_20fa2942a@dwillia2-xfh.jf.intel.com.notmuch>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753636727.3849855.464861650807086965.stgit@dwillia2-xfh.jf.intel.com>
 <67910657b96a5_1eafc2947c@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <67910657b96a5_1eafc2947c@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:303:b8::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW6PR11MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a939c7-d81a-4ace-747d-08dd3b3391ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FwlNfGsI9LIzkgNpx2i/lxBp+cy62MgwicqvEvKMEAFet+9mybkAylQhUK2S?=
 =?us-ascii?Q?seCaZRwvHf5rmsZRRdgF5+mS2nWc1An2/hat/Tq9UIGwmijIBJHUIVsXRAFs?=
 =?us-ascii?Q?jdP8OZdIeGzlfwWVs64g/OeQAlewA/VNelg3pPbQ+OLe2mk1nQbw1MGJiyBF?=
 =?us-ascii?Q?t7MOicKBJD6bbPNDW9mTJBv+ZCwPlYGIgVoTXpvjCYuHrHsmFk9Ia+mUA9y9?=
 =?us-ascii?Q?2AuJDqSSYjb/cHuq2U79DLigOZvaNuTxzRZ/6LhSBLhpdDv1c1DR7ZQP5/F9?=
 =?us-ascii?Q?cHjQrMKh7t9mugiX/Llln15W+fNq2w60q5328x3248Nif8o/tWeFBxkAhWZu?=
 =?us-ascii?Q?7SBhjB5bA0z2VCLPc1GjDRKZW5ZGjJx4hcaGuMx5ji3kM6p7b+e+dAfL5kNU?=
 =?us-ascii?Q?CSAweh/apGCVBDHmuDWltRwhQc9zO5JmzRpFdGL3f0LjiqWTIVpSkMnFY6NU?=
 =?us-ascii?Q?IE0gOP5JxZHcNTbVZr+a8kwLZQKx9QUkWVG50mQf3EaGl8RBaURbdYY+yA8U?=
 =?us-ascii?Q?FYMGWBQenjkmQ+JvXdU2HLNqGNI8/A360GbuWbJJ918ac18HaAf9DWD9eok5?=
 =?us-ascii?Q?GyFcoBDP3EMj5OaM4AJpG5K4C/GqQ2yPrSn0Nil2aAB2CQE2zcv1UfBS2hmZ?=
 =?us-ascii?Q?TIkFRwXGgLtN80Azc/yf3IVU+kbh/XROPUIix6V1R+u/9jsCJtGtk8iJ0uGr?=
 =?us-ascii?Q?8ucT2zAskNWbzYCmgo61PTPIUIyOuQ21DofHJwm1n1kw6zYJqOI8PFoJhvog?=
 =?us-ascii?Q?VCIUW9IqUTFuN/nbxqqKcKNdJaS8Vti2+iATkGQ0fy7trR+FtB/zge+awuLv?=
 =?us-ascii?Q?htwYZsB13ed/KEY+dBhsUWbmVh4TIVsPtv2uAG4WFxa//t4q7Ougf7en9gJF?=
 =?us-ascii?Q?3xXliLfJJPCuy5aU9X27EO1BAHXLqJJXqP93VOXRn35jhAn0Hx1ibQb2uDWD?=
 =?us-ascii?Q?ixYAEFKDYYL4+tpOpN1v3w3luB0XjOnx1ooCMzeEBiLIBDzpzIuhTZYiaojM?=
 =?us-ascii?Q?cKq7fbPDVNUaONzg6BPEScg2Pr1G1CWHAjsgypEIYx9TctmmKnfnYL+qFhjA?=
 =?us-ascii?Q?J6GLkQqlZcFh95f1NcDt+zhp27o3w9yKwBKJzlYIZXHH8K8rQx6uRI4zwwH5?=
 =?us-ascii?Q?r/IzdPMalwhBt1hTKZgjJVNPA4Yi+Um7akQYX2fnZnMpN+iYSt4ImGhUuFj9?=
 =?us-ascii?Q?hiqYPvyFFxQ5Y+HO3RGWWk2DPUInsXlt35B4rJ7VBp+CyvOqoJM38sA/lgD1?=
 =?us-ascii?Q?yHgjVmDGKgrqP8Fc86GIq6VZW21aEMQe4q6lvFIwjEpOXsshmyYn4jKAh2nj?=
 =?us-ascii?Q?0QKEamsLnOAn+8pun5PgBc2oOka9YIs5t4pjzhM33iCx75eJjtCOajsyzfWn?=
 =?us-ascii?Q?34SVuGDano08cJJ+hkVf3Xop2g+K?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MyRTZOw+I89N1B8fEXFV+MYiRutiKzK87EIpSh1HOjZnp8diXDH71J5X7szi?=
 =?us-ascii?Q?p+KNaMJS3X62NjvuOvMp+MwoXIe75LSREBPQUPcN0mx3fzJnh0xcPrSknwYl?=
 =?us-ascii?Q?KeENIYMIHnld9wGAO8l60cjR4b4kKSkrd3erk69P7kauGxN7argzdVk0fScW?=
 =?us-ascii?Q?9BkKERDJiHreJnwhcmd65fJKV65U2V0wLpPNHzwR3nKjqVOwijipQft8JW4f?=
 =?us-ascii?Q?N/JVe177pOn7WDmUOtK0ByPzJR7U6W68a8/Eey70QAm7HmXAk8FSPfCAUbvd?=
 =?us-ascii?Q?4sFl1PhbKpMfrzWTiyqzhY+OwxcvopT12Yc3voyM8DN/IzHNsO8oQk6SHX/b?=
 =?us-ascii?Q?nQfTKi17uJbk4jn8fW3dbV3iNI5ccFy5OWKu5cI6KOnWRmBqPacJM2h2TBBc?=
 =?us-ascii?Q?YTATRndlh8phrGPsA3kCrfc/fI/OzK2eNNdd1wTctrpfZlnMkwhMZ713XU0n?=
 =?us-ascii?Q?Lt48e0KVEgzkKmRYztgor3xIMYBRC8kNnLvDgDrxVlPc7BBt6y2njASwXeD1?=
 =?us-ascii?Q?EN8tLrB/DL8XAt0p8xdP9qL7jzWqtC8gwiWrNKe3M3K3iE8al3+Uu0zGWjzM?=
 =?us-ascii?Q?4tJupHPVfUe1EEnmM0fk1P8D7cUL6D1cxDDrAQBMtrUo/IMFsYIcG08iIcth?=
 =?us-ascii?Q?exGQU/xpAX/Q7wFkN+aLEDJI5SfIlSrfMZCxHosHjITckmGuwKs/23iKXVJK?=
 =?us-ascii?Q?DqTMtp7N7nhPK/HGr7utjaEvtoaAcVgHk8tRVbghbZDH4tQONbOufVbCe29Z?=
 =?us-ascii?Q?5hjX4C0cawNdSmBAjtV7plSPJ35lXJ/T1P2rgQCF5QFYMGZSVl+fSTJ5DBF/?=
 =?us-ascii?Q?PsRURJWGyrtrdFssTXGYSmQdfvra21bO6TFQKPl9gthNttZheoVV37cLCk8R?=
 =?us-ascii?Q?5aPkX3OVVvmIUgMSp8NJvcdIdH9PrSEYIhNKOrQHIVW9CeQvWNwlQhAr6Cnr?=
 =?us-ascii?Q?8oWd1eqs3hrtSyyuNmOhHDBTrg7hyvWujxVo4jnImxBQFpwvwvFDC9qj5e3y?=
 =?us-ascii?Q?7M8W8+87u9iF+sALA7vC3zKJ6lDIkJ4WlO2jMsISa9k8Xb9IDuyY+SzLVOKw?=
 =?us-ascii?Q?Fg8MRxBbbK4rwiWyIqpRVWaMTWcz/120e3gORB2k0tsR1FVDUpU4UPpJoO+1?=
 =?us-ascii?Q?2FXc34oDcu7bcDzbD59BFucc/TX0ak0xMrGoZbT+Sp2qo7wXWHvVaBUH9WCC?=
 =?us-ascii?Q?2ERHs+ZM37H1BjRpic0Jr8mgKr8bbndvIWpxsNnxj9mI2eDDEi7ZSeY6Y/aq?=
 =?us-ascii?Q?gTFhYE1iEbUYzWsFPtIapNQlDwzgbnb7BwsXUX6bfzgYUBJ0x2sGkvANKffL?=
 =?us-ascii?Q?XIpPbJDNKb239Yq0xIDzRGsvzNqQFTbRzKtTr668K3UlitPgiodyt36DSPoN?=
 =?us-ascii?Q?pbY1/VEhJqPLSsrOqyH88ldpcpGIez0CFkvaJBRq7/FAWCzxXHrZpl5Fbie/?=
 =?us-ascii?Q?FxdDxTuvIiHUpgqce4EU9u1cNj2+9A7O7dwG5sG7Q5PMluqPG0btqwJa/ooW?=
 =?us-ascii?Q?gtQQuwsWOsKhFaHzv+gaqgSYJyPoUPA8ybHaNKmPV/RUcppuigsOtLzUbZFx?=
 =?us-ascii?Q?6zzUtq+SfyvtYBSVGU1kPSPO8ZFgNUS7yt/5FcBxDU4VKMxH5cRAI2/Vojvl?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a939c7-d81a-4ace-747d-08dd3b3391ee
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 22:24:44.2234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eer1ZgjT44dTYdfsUlwyV5zDlZMj5HjaIfiiGGmg6qfWGxNEOYBxJdxzgOhlUxCzzVouGL30oAPYGooNf8VZRptg4UQJfa+TMVUIiceSWNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8309
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Dan Williams wrote:
> 
> [snip]
> 
> > +/* if this fails the caller must destroy @cxlds, there is no recovery */
> > +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +
> > +	guard(rwsem_write)(&cxl_dpa_rwsem);
> > +
> > +	if (cxlds->nr_partitions)
> > +		return -EBUSY;
> > +
> > +	if (!info->size || !info->nr_partitions) {
> > +		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> > +		cxlds->nr_partitions = 0;
> > +		return 0;
> > +	}
> > +
> > +	cxlds->dpa_res = DEFINE_RES_MEM(0, info->size);
> > +
> > +	for (int i = 0; i < info->nr_partitions; i++) {
> > +		const struct cxl_dpa_part_info *part = &info->part[i];
> > +		const char *desc;
> > +		int rc;
> > +
> > +		if (part->mode == CXL_PARTMODE_RAM)
> > +			desc = "ram";
> > +		else if (part->mode == CXL_PARTMODE_PMEM)
> > +			desc = "pmem";
> > +		else
> > +			desc = "";
> 
> This can be a follow on patch but why not allow devices to name their
> partitions?

The proposal in patch5 is that the partition resource name is the
operation mode. See the changes to mode_show().

So the name is there for the kernel/user ABI to tie the decoder's
assigned partition to an operation mode.

Now, what may need to happen is that the partitions and their modes get
exported in case userspace needs to know that allocating a decoder to
"dynamic ram" before it allocates a decoder to "ram" implies that future
attempts to allocate "ram" will fail. That may not need to include the
actual partition indices, just an ordering of operation modes.

So far we have been saved from needing such a thing as "ram+pmem"
devices are only an emulation test case, not something where end users
can get themselves into trouble by doing out-of-order allocations.

Usually RAM is pre-allocated by BIOS which also limits the possibility
of the 'skip' code ever being used.

> > +		cxlds->part[i].perf.qos_class = CXL_QOS_CLASS_INVALID;
> > +		cxlds->part[i].mode = part->mode;
> > +		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->part[i].res,
> > +				 part->range.start, range_len(&part->range),
> > +				 desc);
> > +		if (rc)
> > +			return rc;
> > +		cxlds->nr_partitions++;
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_dpa_setup);
> > +
> >  int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >  				resource_size_t base, resource_size_t len,
> >  				resource_size_t skipped)
> 
> [snip]
> 
> >  
> > -static inline struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> > +
> > +/* Static RAM is only expected at partition 0. */
> 
> Is this because the spec requires RAM first and the partition array must
> remain in DPA order?

Yes.

> This could be in a follow on patch, but unless I'm missing something the
> partition information must be specified in increasing DPA order.  Perhaps
> that is accounted for in this series later.

The partition information is specified in increasing DPA order in these
patches, so I am missing the concern?
