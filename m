Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF74F1114
	for <linux-cxl@vger.kernel.org>; Fri,  6 Dec 2024 00:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445928; cv=fail; b=kwceaGfWC+DtgPYzXvfCrgnf63I0EnwjxtlEJlfhnbn4jLy+yyNJPZeGV5aWAukhKf04NmX5QxfKQYc3+c7BKZHhIAHIF/Mti9crISGXxdhzLF3gVZKTdvhB+5SpF+GbdEY+Pg+pgyLLevpZ/B32rRldPncXcNLzSCnd1U1+rOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445928; c=relaxed/simple;
	bh=7vuvfsaDTiAJb6pwELFgnKl17z6VtCQYRN8RFpdfvkg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rgIGoyJlGFMYaYQOTyTe9x+fnJiIOSNOmvf4ImEGK07/90hmvDQT+6OiOSfD2cqvoo9hNgcy5Yy/EiHhGYxum6+NW5dN8FexYHkrI40R3IyEsTqRDrUBlMz9sj73l+e9Vzj3yngHda0loyiPcXOB3dRVWmVYOe6OdgMlZNDf3c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZPWl82ej; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZPWl82ej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733445927; x=1764981927;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7vuvfsaDTiAJb6pwELFgnKl17z6VtCQYRN8RFpdfvkg=;
  b=ZPWl82ejGZ4WkHDI8BiQaToV3V+IUfLhIWs3lwsLWUtOxuq/NIweCOmx
   mu2yB/Bv7JhgwLkEBuIBjqZFnSBdfSS84ijqYBjzrUAL/kcceMhLziW3r
   PnHZl99M6UrvWEj9IaKHkR6Qa3Q5rzIUG6jemavFYtAkCIDmgbMZZn3iO
   YwvDOfc59TndQmdkpv+PRxALATVsMUaGT9sKsQ2ouQC0nS9VijFspCvE2
   wbXAATAoY4GS9vW0WCh1FWSe16ocYUCFGWjGxjYB5b/Sxn/O5fG0CixNo
   OTOo3iDA+i/yBgkyu0bD8DRuzz7ybnsVv0swyje7pz/rbDhaZFGoc+PPc
   Q==;
X-CSE-ConnectionGUID: ifRwqTwKRKizDArG3IaFzA==
X-CSE-MsgGUID: WdTwxE1jSAm8nfMyRrhtgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33707314"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="33707314"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 16:45:26 -0800
X-CSE-ConnectionGUID: asS1MMg2Rp6ms/vUIC/J8A==
X-CSE-MsgGUID: LECpAykfQEiQwvIufX6lvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="117505396"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 16:45:25 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 16:45:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 16:45:25 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 16:45:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1fyxQTnpNmdCPfSzYWvwBfM8QQgOO82n8fNc9RU+9H66SC3U6gEJT3c5WRqjG8zyUBJX+vzrDpcBNo//HqEcj3C6fAZANEjZI0LTcm48gwCTCOqYUV/w5sTYeWuQvb9STUM6SmJrnHbW+FaxC3f7c1CoEhcbhkFbcljc4uT1uN1FmluyMpYq0tq6KGpfPmfkCI/IKpImLxJMlWUm9xeyoQbAJo9n2dWnzqhl9SmMPIhyX5zfITfPyAqi+/I5hJr8A/EXg0u4CoE3kviO5L6Daw7+3Enm8YdDYhlOivtOuaoIHXwemmKkT4M0/hkkbeGMyQKD2KgAD3t+mxp4nkoUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoM5JmPkogc2GZrN49570fN1CnqILU3tIRZB2rEYXK8=;
 b=zPRZKWM1n/nKpHeQ+fPvgvcJY3VO906yFaUMatJxflSxdXg1AWlMmN38OhZ1YDVOLhCY8esXbEHgtgSXdFJC/X5Zg2X2XrznI0RcxQfWHzqaAIS37ZiZHehMNfmGewLq6eQitvaKHTx8ZKzUujVoxTB37oLuLt51luDcLhP8mOOGKU3Vj9YQKzz9DxHBzKcdDp45oottwcZmvl0tviPVoig18a3ee5UnOmcnLkX+6gc6s1ZUFH6hTD50+3aUmhlhpOJbv+Lwr4a+V5a4Ji4GxCBtLnczWNHjG/g3oC/q0kNea52kXcdvtPRgCBRpxSwpSGlmr4Y2nBHmGrCUbEWxhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4557.namprd11.prod.outlook.com (2603:10b6:806:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 00:45:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 00:45:17 +0000
Date: Thu, 5 Dec 2024 16:45:15 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 05/20] cxl: Add Get Feature command support for
 user submission
Message-ID: <6752491b772ad_25073294bc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-6-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241115212745.869552-6-dave.jiang@intel.com>
X-ClientProxiedBy: MW3PR06CA0017.namprd06.prod.outlook.com
 (2603:10b6:303:2a::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4557:EE_
X-MS-Office365-Filtering-Correlation-Id: aa036af1-ee5c-440e-20a5-08dd158f4150
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wDSnKj5lGBgvsaPOmBLDqt4e3DRnnL1+V3/qlPna1IGa21dQIqGNbKw3KFee?=
 =?us-ascii?Q?Gq97sdSF9bFgXqiRXBfGWkec0Q8zRnbB8mAzXEGdhH199waUQFiFnr5gzxFD?=
 =?us-ascii?Q?wJPM3pm9wfR5VXXlVMG4dREoBn8RnjY5bjvp5gxO7DewKejNz98pzi+4LFV9?=
 =?us-ascii?Q?KrDzDJ8guPrWkbFWTLWKA0Sk5u1I22wm8kONA6MpyOpkbM+Rnmj8xEKpS2iZ?=
 =?us-ascii?Q?NkT9nac09v4YL6GXL56/UaWdnfhn1yaCC3ymtSKVzRU5ChPDAEhXP/NKeRJH?=
 =?us-ascii?Q?jPpXSKyZEmpcl4Mk1qLeEJdf4dIwPu8HTwLAYBx8jp36vIZy9YF5qI4Vsy3H?=
 =?us-ascii?Q?UmwsxrxHj1bSZYouPD8/2vPGslMkw1vbfrDeAs0gMUjqFlk9Pbw+JCJEEQMQ?=
 =?us-ascii?Q?TmxUbSoY12xbi00O7iYaGXu1fJfmE9Vme1BdXbY9SfNnxjutmC564wtQeuzr?=
 =?us-ascii?Q?K0mjCub5g7mXCOPnXG93O0u/nqXa6psVNB87zpwPk4avwmozOrXUOBC7Yh58?=
 =?us-ascii?Q?EymF6Lq8i/PdeZLwUAhyBs0ryR9vPkYlh56BrP6+UpK2v9+038gXEKLo5tPW?=
 =?us-ascii?Q?NAGY1sI6Osx+CbopQ6Wfd7vZscjesPW22MZpO+cTSdK1dQbk7BOYTlnlcfSw?=
 =?us-ascii?Q?brpqrGWovdtxOdq3VbTUK5dHHhHAlq4ox8oNNxsBpJm3UCvmVxLoffID6yqV?=
 =?us-ascii?Q?L/GRIUC4cggCOCSM+gXHsu0q8pm2vd6Zn+2LYyfEsBtV9rgCG+nbmIQ9yINm?=
 =?us-ascii?Q?fVDvFXb+IYK8OZX8SLHBgVBGuabnhfW3FR8+h9h6IO+SDzBAu71zQdRd3vlw?=
 =?us-ascii?Q?UOUdhTeAvqPiZamgp39fKNicb2VnPYMyVU4GscSYLy3JtKCpoBUk4JwqfhDr?=
 =?us-ascii?Q?ODVP4IG9g37W0A40rWCpHbZDciTGT0C89uBcZP3qeYTqWViSKOc2lGxvjg59?=
 =?us-ascii?Q?1okjGgPswtVn+Wug3Z/y9KaMxG5JSwk5WflAj9+MF32gY5TmtWR0BT2JJ1cH?=
 =?us-ascii?Q?NmXPjUO4EBUEWzexulycvSwO+TX6RyPoIYU+S75GzbFpzrD2SzFKI8sVydc6?=
 =?us-ascii?Q?0z3Yxu1PG0cju9RqmmgH1Une273+tuqQZOT7DkKasiDZJl2FCVPZk0XODgeR?=
 =?us-ascii?Q?V19SaKrbLqS/FQxpFWt0hSsDflQHKkRzxVspw4sACum2F6nP5xGc83Eq2e9a?=
 =?us-ascii?Q?N8NCNpJmS4TxsgmtnN9WAARATd/WZTAdiiS2LfROyDM2btp5u4cah1Dptj6j?=
 =?us-ascii?Q?vy6iCPHg+BT34vI+aICkOeP05WbcblZyZR9m+9y0x8qnMg5IMogbVlyJV0Vc?=
 =?us-ascii?Q?Y9xgcB9ED8OIfTKfol5AuSVX3HwGlkxHjnwpTpmPfr/MLQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eFmLuHUBUigsqnWkBfze8xeoNdJcgDuwdpTn3+x9DJmEspyKArN9rC5CWPTO?=
 =?us-ascii?Q?r3p05ivDirskXoVk2Vqyleub49PbtR8eT952EcTDG1T0BRoKe9sesliBnUhJ?=
 =?us-ascii?Q?Bye6NP8VBAM858YEt3pk8vUxhpfr3rf2vb825eLo/r0H+7zYTu1E+xsbVWiI?=
 =?us-ascii?Q?YRZq1MRoaQMXEx+D1J2pyHLAIwd8IINe4GKtvNXEME9cNqYXjTPNQFoKcaKh?=
 =?us-ascii?Q?XqQjmyhh45Xm6K8Bot8Zu0h9zfRDmyqHUUhF7kgmIhhKYOvWpEc9oehPGrXI?=
 =?us-ascii?Q?WNmhy25gno7gqt0LyDKZtdUR5gKxiDkB3mzLOMz5YlfSsPIEbIw9PBdC8i8F?=
 =?us-ascii?Q?7E2JPyXiAWC4xe/tResOWVQtIhc24SqRugBNtNBJ95zCioe8EooZOv8LCopb?=
 =?us-ascii?Q?Y5oAI65SCv3qqEkVyGdRhfRNSMC1yWzUfZ0jOGR6sL3/fVkoMUALoEZtH8Yz?=
 =?us-ascii?Q?jfGcdGGPrb81nmes45Y/TBxDNI6/z6fX0OnHZdZeRCPvsY3YIi5n0TicXqgq?=
 =?us-ascii?Q?Rwga6YHlPWrMknU3ULpO9nFlzkcIFqwwY8Qnj2t90LzUDq/wGqn1YK0Ql7nx?=
 =?us-ascii?Q?tOaXMNyGf2vYrpcPyp3P+fNFLANXbN6cYsK+XDGvtPm7JwsnMLzJxosoClYA?=
 =?us-ascii?Q?vrRCbI//EfjrGqil+jgQgn3sqzyxbBtBpbtVgZZ0Fb2XCug69BvoU1S9XcMl?=
 =?us-ascii?Q?toHOuULwQg6/d0j+Dt6EfW9Ngp0L1CYIQAdpaL23s8xsyTdUfHvkYT3X0eVv?=
 =?us-ascii?Q?Q7lVafsYU0YjiobJn2U5N5KKN2I78Cc5BYONHuROwZUCbRbSTUpsPft0iG5A?=
 =?us-ascii?Q?ZtTs4t7EpLqJavzJ6WO619h7wswJshzco/eyehgD6hPXp2e1dH9hvZTlf5PA?=
 =?us-ascii?Q?CnWVKwd+3Rxb4k52+Ga11/UozWb+WBB0T4pd1+90WXN09yoyWhFl1iDnINng?=
 =?us-ascii?Q?15qb+ITHPxh3cZFAomVGvIL96zodM+W0pwRaelubPhGR3xT4h9oieVm88ebP?=
 =?us-ascii?Q?ci+63vk7hd6Vf/7ffgSpJSLCYv/xI2QKIf3pn9GpkLunVa4dB3isgZY2+4C6?=
 =?us-ascii?Q?D1BlRXbZ/olz+Rp9EcPj9K9PUeYASR1djFYLmE5z6sgmOqS3WSLGRkcj0ne1?=
 =?us-ascii?Q?QsNyl6lOWx7jL6MxFlAB7/BhZi5i7ubazgVg4oenjaT9VbY4tnH/XJbBUejv?=
 =?us-ascii?Q?apDEY6l+AFIdwbBKE07AWUUg05TAB7qVs8WcMnxBli+yLbxBSW/SagDKg0Bc?=
 =?us-ascii?Q?Tn9OXtGIQz0PyyUwHBeIhC5Ie/gLSql3PiSwdEVyGu0RilBlEMw7NpiNYGPj?=
 =?us-ascii?Q?2+p00GsRIHcZUXug9LzFgJmY4p93qHdG+tJx1Fj2+c5Qq7/cLoQDagnFCi8U?=
 =?us-ascii?Q?GuB2nstQrdMFSviIreVZ7zFzVlN32iP7XaSw8Vozy9PtQEFbV7kmWRzS8WGm?=
 =?us-ascii?Q?Rx3S6wbGM/HlaeFvfSl8WW2EuhqiAeXEdweN+3iOviO2+aFuLI4ngTKs4DCV?=
 =?us-ascii?Q?DD8yNDPMSHwrkjfJJL8mj2sLWLnISBohL5Jy4SwVlH3GSWUTBSGhxAyrq5FK?=
 =?us-ascii?Q?ZMV98I4OPmKaDKeXdncA1R8N0SrHTgQNAGCj5Wnz4adO/aewjopR9ViSYCYn?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa036af1-ee5c-440e-20a5-08dd158f4150
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 00:45:17.8025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIhEvwlW5omXD73adcMob3mOuXiyojaplhgTy3HXVagt+ahxCSQIcDHmGOH9U8XWSTN91kkus6fHInGDnP1zcLU+a08e32x9jXzQJ96rQ6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4557
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add enumeration of Get Feature mailbox command for the kernel to recognize
> the command being passed in from user space.
> 
> CXL spec r3.1 8.2.9.6.2 Get Feature (Opcode 0501h)
> 
> The feature requested is identified by specific UUID.

Lets identify the consumer for this ABI that can't use fwctl.
