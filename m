Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968BD208D4
	for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 20:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717189021; cv=fail; b=KPPOG1GjlE7Un2efgXn7FIsa+agJh+qUA5eNWIK5uadzdYkpC37VlMJ/13T2aDkuLYJLaEl/cQvn0sFLHLtbUO3y/THUVkfxRqd69AaZc6jPzxxcrgL0VrEQEDSZe3nSd6J00/Kt197E7sJbvy+1zlu+jQd9MiuU1yiheco4IDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717189021; c=relaxed/simple;
	bh=Na7uHto/ttjfHm6Kw60xvqRoP3rR9UErTaaf5nhjoI4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CRi9Ym2X9QtLjvJXuTzmgNprqCLKl26KwDWpeWLjsdtE59gNT9shthrU++w0HwqEsioOW1b9Bu93XhUw+o2obY4trCuhxMXxhQHF8pOO25sIUNVZNyi1bQfMLvx9u8E4FmbR3+/YCT1hm0cB9MDQoSYO0V2vT01CLed0nJgyGdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHjbtuD7; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHjbtuD7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717189019; x=1748725019;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Na7uHto/ttjfHm6Kw60xvqRoP3rR9UErTaaf5nhjoI4=;
  b=nHjbtuD7q3H+3xggA/W/9dUKJHuO9M7NIQzl0LcNYAReuqwyi+4j6jjc
   BxLtHivbGhU3uvlZjqJmMzsD97zlAOlSA9NrCVykxlWxy9glT0RivnW6D
   dK5UkcsPr/XYFGBTDLD/cA2TXZRX+YSuKbb+Yf+/aJnadPwBZWjuwRbHG
   EWv4VZNCuivRQJWgwgqrys0vowLzeZp61hMk1hi1h2QcTV5Qx3+dRJWID
   0hTKPk9EItxEpOIDymYZnamIwv7LUsVhGTxvtojCnGQSWTU9C0iPObG+K
   TbN+zX0xw8ZfUhnKJBtANlYftawucAWkdpsJCPS+lFBqw0GorIAHhNFs6
   A==;
X-CSE-ConnectionGUID: PlxlAIFOT+q+9ocUF8oolA==
X-CSE-MsgGUID: dWbQHFbjQQCbc/Maqs3sfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="17595708"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="17595708"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 13:56:59 -0700
X-CSE-ConnectionGUID: OWJP7CGFQ2GdX9wUj+xwRA==
X-CSE-MsgGUID: Iqn02JNHTeWRXN1Spp38CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="40714976"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 May 2024 13:56:59 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 13:56:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 31 May 2024 13:56:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 31 May 2024 13:56:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+nAdO20ulu0H3VrQU0ozWMBBlUAhaHOk/ZONfx/S3C+qYnm2JmRDiD+IqsceAApzMCB5HD0xOnH1tGd212q2UktzdxNbJ7R7qIUevqYtOPYNp5IDOoEfKS149pDwAmTu8S8TAoeyb9nXftEv8U2NU3YCqlSeUhD7kGuF3pq34wWls/NtN735pdNQftRbOyMMsxtneQoPdbJrbkr1P0PVunB9OxBcV9aMlogEKEKsysZgqvvCiNPddpFWZMkxm66AQC/XEZBXPHe12VBraCD3+OqgOPXMPyrJDzm7RM7KoLJKY3HHuPGbZpkq247MJtOdMJljz2HZh/CSzfI7FRLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8+kcFoJ/QHHHDJqHJeBpvQLoaiec2CRhnJeOQPeJg8=;
 b=TMlNum/l6yp1rMClNze80HSBpWPJMw4Ab4Uo+/St0YXrb+kcxVTcEgrW6Abm+XUes+UWbqn2TWY3batuuvF7JvXSE1UQF5iu/RVpGHLzKQZHaG9l6KB3E2QHd0Hh/sf4+ongQl6habHstXmZL7fOXx+la2yYa5mrf5uNdVGis/JoZf3mvFfK8od5RDQmouCkqRM5kpcuOj1vWXeRfLiUyyfqjRUbnGgiydGP6PIisx08acjlZmDpEFA1GWRVGEfambHpXfu3gEyhARkwTtkkfm4cec5i8WV6nQE9++xc+mTWWIcl5uMTtWlthtsj3um6yPxhvl+qZ+hg2zixXo+tZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BY1PR11MB8029.namprd11.prod.outlook.com (2603:10b6:a03:526::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Fri, 31 May
 2024 20:56:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7611.025; Fri, 31 May 2024
 20:56:56 +0000
Date: Fri, 31 May 2024 13:56:54 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>, 'Dan Williams'
	<dan.j.williams@intel.com>, "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>
Subject: RE: CXL volatile memory: How to restore the previous
 region/Interleave set
Message-ID: <665a3996301f8_14afbd294d@dwillia2-xfh.jf.intel.com.notmuch>
References: <36106fcf-1062-4961-8918-4471fd313a74@fujitsu.com>
 <6656801ef0dea_1668729484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <TYWPR01MB10082738078CF843AF514F7E790F22@TYWPR01MB10082.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB10082738078CF843AF514F7E790F22@TYWPR01MB10082.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: MW4PR04CA0233.namprd04.prod.outlook.com
 (2603:10b6:303:87::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BY1PR11MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd90d50-6c5e-4718-3e8e-08dc81b43504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gaGt4DRdpksoHP3r8AxOFUnFGxCDA5zBsXIpc+0tkXGEqkdgn5rrZnEfeiwP?=
 =?us-ascii?Q?i3p8/4vY+CnL7SaA68urDtyyblU2Jr1En9DHEKq8cwP6APT5QbPu1zZEqr0S?=
 =?us-ascii?Q?HTFjy4tXuggvw39Py2jg7gFfkQn1uwrJeJSH7JNQRSGKeMeWNqMKTRp9VMh/?=
 =?us-ascii?Q?wvzpZHAzwTahEeklTZ/s6y8haNc9tgue5LCnQInlmnmmYeY3xYveg1PYnRh/?=
 =?us-ascii?Q?Isa01f7whP+MGbIO0mXMEkK6U0Ur+UViZWZHSDvEMm8zTb6/TaVs9WkmL23s?=
 =?us-ascii?Q?LpaUHyzzks0s69bj9iV51qbS76vxJJGhF/W9mIhlsBxh/sNvMVRvO1T7tOjF?=
 =?us-ascii?Q?zSKFeS/iWmI68Ehgtj/GxIWPncybHw+/jsR5iAPQ7Pj38Wf1dYC1/Sv8oEnu?=
 =?us-ascii?Q?8J9QQbIVUkFP7VhheDSiYiQ2XzmdpFwRNoKsb4XtJjmpxSezQx9obGuhiR1/?=
 =?us-ascii?Q?3craFV7d2U5EMFU6R9ZLQZ6AWsoF404puWVG2czd1qOzAnl3Z9n9/wXmr1UW?=
 =?us-ascii?Q?jZU4eYZfllC837bV3cUZbpX3AByoDSIXaF9L8ljKbe13zNzhvPlz1xbqS8ZZ?=
 =?us-ascii?Q?oKnck9sghpGYOOsGkwNPD/Nez4u3sd8hhCXHC83O4STmOikr/j6gk4ubP0xD?=
 =?us-ascii?Q?2hQCnoxbzVfB6Uf42Su3mgYhYSTzaQLttes2msE61ylqfKDUQZ5lMvsfecHZ?=
 =?us-ascii?Q?G5oEcSiRrsIM403rvNIFXgYBbXgsMT57lngISrigo5gfYPm+ZSMSafOYh0Gn?=
 =?us-ascii?Q?KvTzAYILPc1P7ZXw/+sfdr03QBpHMMSWCrBwQ7MpebK+8SCBBB4aBHXA2LoJ?=
 =?us-ascii?Q?yzRecOnNtaT5rk8scKo8XYf9SRODujNFKJqJbnk3AumkuR+KqfzDlft6qaYz?=
 =?us-ascii?Q?G6BYebD154+bXvNEh9LE7y42nnhXSfqjtjV0xI40JXPPrT6aNlvsPEeWEoLF?=
 =?us-ascii?Q?ygCrnfMzaclrsDk4yk4KLTv/UKygX3tEaZSePc4BA0xR1IGwVzkwW8qnx+Ux?=
 =?us-ascii?Q?Yr+SDryFKR49karL9oj2ic5cAG5c1MhZQ1Kg3SvccnO0/c0DNHGGa2MPqBCW?=
 =?us-ascii?Q?7Qal5Wv+rb7jc2sCzOz2x42iUj1lx6UPDuGURvYcAUG9U0j/fMnMFkYORtfb?=
 =?us-ascii?Q?7s3Z7ZdQsftLR6KkgPV3lSOyc/+cNxniIk0NuV/+ShxioZrhlyvrsECR3Tve?=
 =?us-ascii?Q?PlDxs3vxpEGP38e0DEHOBDD6HG5AAjMRXUGnSzN2hvT28Q2mv4ji5MkxqPAP?=
 =?us-ascii?Q?KIx4uRnfunKPyZgafjlWN2WGKkuRURFSeH7pAFgAiQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u0f1uR8FsV00PA65Bj3ZG+jmdmaCGLWypZa4E7IDnn/cOUYsy6/BvGT9zF4n?=
 =?us-ascii?Q?475EgQu0nSKFAIt2zOEWNOnCwxKjV5wzepEVG/IRF6U7ltXk40euN3/6Tt6J?=
 =?us-ascii?Q?mRVNEhwKHfDeoNiTDJoPdTLuMhiXCesFMJBcVoaO5dgh+YXfWTv/gXc3d79d?=
 =?us-ascii?Q?Ev+0n5cSj4Sb5JcG0wIBJ1CEryomxHHF/eD35DvMng2ZfiqtYQF72ij4prc5?=
 =?us-ascii?Q?F7s1GDDFmkupeh7eqDy5svoWCfWKClbM05HD/Joq7nuC0JVyyudAf5SMR2Xo?=
 =?us-ascii?Q?a8hDpK6oSoFXKkGHc2D4Mw0PmhFIjAmxlYhuB8rIGBO5jSWT4J2y0K8qqh9m?=
 =?us-ascii?Q?ONHzU2jzrw044qmzvbvZvtd4YYaJ443nSxwNMjku8lcY53+17MRtcMj1Gj7S?=
 =?us-ascii?Q?jUkpBASOUtdcJMqDdE2AlHkifiuquy6mmLGyVe16FAE1UHhbgUc1jao4QNQN?=
 =?us-ascii?Q?s/wy9gFd3d1R4JUWxET8GSFWatytNZWdFJPXm7bwQGbNS6N40Y6sqLCg8X71?=
 =?us-ascii?Q?umbCGUpV5L3djcl+Nsl5cOLwkGNdjmXtdgW4xNx9LtDlCV+sa4aFz07dJ2Ym?=
 =?us-ascii?Q?bWLACoVoavzch3+C2/Rzp4ergPfcMhloeF4dpVWSFGLOmPHRVTnoHpMnl36b?=
 =?us-ascii?Q?QrFtfLU6314NVXV7gZvLvLHZ2xLtH2OL8+HbfiY+pvTmILZpvQ8QvwLDArMn?=
 =?us-ascii?Q?SVxJ6ZJkUf1pf6FHBMAyafbbJq61w9kDAUBe/BZMMKLhYTnJ97ikO+yGJK+O?=
 =?us-ascii?Q?Da7zXbAFO0v9ZYq+h4ec6fhs5jKXZhRVckovNLzcFnEvH03tVYiXS1lf1DRs?=
 =?us-ascii?Q?NhGml0N1aaK7yY0tlUFxZwMu0a0s0I/iFbgugR92dPCqICn2apSvvrUOlo3Q?=
 =?us-ascii?Q?r7lZUHP5WGnmsjxn5v8WGVhqPMM0kTdu7y7LoEeux/+nyYRXNjygPwervxML?=
 =?us-ascii?Q?GlIwy41EiVvpb66YBzj00qJbPxzs29tfpIGEyj6/N5yQ5Op703Em61wxp+P5?=
 =?us-ascii?Q?izr1LWZ+4jdRCOBY7y9hYr8daYbmJOlNg3x8didL8nCZ0KoYVc4xFlghFS+d?=
 =?us-ascii?Q?LlgLgZD+saXVPjwwNN9JwawgpQFzHjteaFrVktw9iH+FELgkemmmgjj2A0pn?=
 =?us-ascii?Q?MSbB5b0nftwRws/02SOYHQRgBOW3ifTeOT4z5/yWSqjDUnI2Etriw6oeK8ET?=
 =?us-ascii?Q?crn7qK07s3QD/fGgNpFit4QVBWdXGg80o8EmdVYEJp6daOA33FfnzIwU1riX?=
 =?us-ascii?Q?ksWe2xMiqZ1FQqv5mV2uSMzxuG0e27wzkNJvrjsc0zZPRrxJY0X/RGMqj6CM?=
 =?us-ascii?Q?mM1lpwJG232Y9xG7JxAoXrmKSS1PgtEk+z305tC/vV33KnchTO9sxFcESr6j?=
 =?us-ascii?Q?0KvmV23ZdItymp9m1mLC++J2y8ChDVuXXU+9q3QRzcQMxLaZLec2dxd2l0tL?=
 =?us-ascii?Q?GjqaPVw5XOShnaQn1hSW0xQLtyiqfnWwU3X1rTQsLNJN7xocyD2309GWkgIZ?=
 =?us-ascii?Q?ytG1bmjZJ7w7f285Ah+e+ZVeu8bDk/NNTsvLOgROxZ1Jd4CSfoztHi/WRkos?=
 =?us-ascii?Q?KVgIE3Mq54jLy9G9tqJAq9ljdWERpYPY+OeEAtWj3tnRxQS+RqlMxTi97cOJ?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd90d50-6c5e-4718-3e8e-08dc81b43504
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 20:56:56.4562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Bo/mY0mmQSVNt6grb6l12pnrOgp9GWomfjgl9z74eVzkPNfL+ECytyuuBrEmC9SPEKy4MeuodskZWGTMqseGbuaqmFDzO3V5Y5+S8GGlR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8029
X-OriginatorOrg: intel.com

Yasunori Gotou (Fujitsu) wrote:
[..]
> > What is currently missing on the Linux OS side is a default policy for unmapped
> > volatile capacity after all initial device probing has completed.
> > 
> > > One scenario I understand is that in clusters using an Orchestrator,
> > > such as K8S, when a node (worker) restarts, K8S is able to read the
> > > Interleave Set from the database and sets it for the corresponding node.
> > 
> > Yes, for sophisticated environments a configuration database could store and
> > replay region configurations each boot.
> 
> Just an idea, I suppose that cxl command should have two features.
>  - save current regions configuration to a file which is specified by its operand.
>  - reconfigure regions depends on the specified file.
>   (If hardware condition is changed, the command return error and display what is changed.)
> 
> Probably, it may be enough for the most of users.... But what do you think it?

It is not clear that the tool needs a save / restore option vs just
replaying the same create-region command from one boot to the next.

You can imagine having a startup script that issues one of the
following:

	1/ cxl create-region
	2/ cxl create-region -d decoder0.4
	3/ cxl create-region -m mem0 mem1
	4/ cxl create-region -S 0x12345 0xabcde
	4/ cxl create-region -S 0x12345 0xabcde -s 1T

1/ Find the CXL window with the largest available capacity and create a
maximally sized region.

2/ Limit the search to a specific CXL window, but create the largest
available region from any spare capacity found there.

3/ Try to create the largest possible region with mem0 and mem1. NOTE
that this could produce wildly different results from boot to boot
because CXL device scanning is asynchronous and mem0 from one boot may
not match mem0 in the current boot even if the hardware configuration
has not changed.

4/ Same as 3/ but guaranteed to get the exact same devices because they
are addressed by serial number.

5/ Same as 4/ but limit the size.

So, a lot can be done without needing to save restore the exact
configuration, which for volatile the exact configuration does not
matter as much as the the capacity and performance characteristics.

NOTE, some of the above examples are not implemented yet, patches
welcome! For example the -S option to treat the arguments as
memory-device serial numbers rather memory-device id numbers is not
there today, "cxl create-region" by itself does not know how to search
for capacity, and "cxl create-region -m" without specifying the
decoder/window throws an error even though it is relatively
straightforward to figure out the set of CXL windows that map a given
memdev.
