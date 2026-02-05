Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1F13D544
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 00:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770251566; cv=fail; b=YDxt0kHP5ETS/MPtH3MhW+SVBUruXdejZ2BgeWrOOiEMBctywrJrszqdMaNQYjek9v6qnhXslPjsJ71Qu+iBpBb9uvpmm22rM9yiQfyCFf5G7STNW/j9nFEdyiiRk2iQgFSNwc1bfr3Us93g0lIncpLTtT2KISPWrE/ttOkDeSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770251566; c=relaxed/simple;
	bh=0evjHyCmc7NdmYMKzjQ6rNzVGuXc2fyASwCNQm5CaSg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dUZdrIOKaePJbFjg6sPoe622xCVajyRfnDYc2dbGSZkeWXAm60FpBAO9w3NYqnRHv432UdszQWM1jDB+e5Il8QgIY9Hcy9ulRhRkttksXKWiyFhNoItGPUqrtLJakHzMgR9v1/lh+KpJ7MC8F8gBfPa76BrT0c12lxrNqDI13Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cgi7/goE; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cgi7/goE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770251567; x=1801787567;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0evjHyCmc7NdmYMKzjQ6rNzVGuXc2fyASwCNQm5CaSg=;
  b=Cgi7/goE4suV0eRLPW9L+tYWxCXifqar1gNc5SUw8j2AKVYtGul69uM9
   aqjqJ/EYdMhlXfeSQqa6S9nYv2C4jrFCxNwySF39chRUM4kojrN7ciNFa
   Ft36HcTUjv5dDKz1ExfNLiBulIYmwzSW1OKxUt1/nBPpPsBqTLYJrp4k/
   htjVJ5P+ll2tLJ5cZVv7utk1LxPakVy2kuRr2EsasCcjrXnQR91Qirw0K
   1Yclx5K0dlh79EQ4LKMIs6zrNLb7VAvz7pseQglCJD8Ui2KpQu04ERmTK
   EP8jjlT4UlQCZKdDc6kv1X09xj3oHgHFN4s7NSziblBrbnnZ9+0JyJ46R
   w==;
X-CSE-ConnectionGUID: Md+nQL9bQNSJfvZvehkF2A==
X-CSE-MsgGUID: kjHGMwQuTIew9wzXjtp3+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="75067107"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="75067107"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 16:32:46 -0800
X-CSE-ConnectionGUID: nkHKqjsySm20VNoMYZHPew==
X-CSE-MsgGUID: BHKAN7EyTkS9BAah96+FMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="209429539"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 16:32:46 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 16:32:45 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 4 Feb 2026 16:32:45 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.65) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 16:32:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAoqJ/UhJ8T4X0ZpFFJE9CnaKG9n0jq5XS+vEe4Vc93fyog4R/oaTaoKyDKaxW1XuWxHGk97vmn954NeOmiNrUMuIMaKA85+zgEeejovZEDUe/8kXeW4X3z9Gpez9bc04yy8iW/InvDcfCz73tutmeMRWZzVhESGJQU/Af2GH3vrSzqn953dCN4jLCueuVPOrZH2KIUgjRSRFAXS1693SOkRLPd+GNyZxvv7R1yDW457D3CIdUL0FXGxZ4Lm2gxsZMubbvcKcJZNyKnlM7G8eUGnjii9zSwhbFw72ULLvYhDyzJXqoAKnxvc2WPhvE+RlTD5F9p1kJajdZYESL7Sww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrieM9JXk9ZVrDaI7c5W/yy6ZHgACi4fARJK5g7deck=;
 b=Gi7NWpxiDL5LpkE79zN7hQAz0I8MFJXDywySJfFNl7TA3raB93BO2mX9FcRlqyridGgqRaaM+wnJl2jm09vcHV5H/JfgLYGMcLyjCHzlrGzmVlZ7tFqW5xrzcGPH3Zd5svc/n+1/1Vc7AjzzPimxUUZP/FvibVqVvimnlOoq9XWwyZcSkmLVIMzsunifDfdEylD94KZf7tWPRe1uqXCvwaXk3dsANu+hiYtpLtMsWHyC2qQgSpjyIVOj49UCUszJcw0j6WsgHnUuuEG3Kg0Ym7qAWU14xG2ew7FA8L/Muj5uAjSY6wg6s3gfslSR49igcOWka0AaKEs4GC0UeoKOag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY5PR11MB6533.namprd11.prod.outlook.com (2603:10b6:930:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 00:32:43 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9564.016; Thu, 5 Feb 2026
 00:32:42 +0000
Date: Wed, 4 Feb 2026 16:32:39 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Gregory Price <gourry@gourry.net>
CC: <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/region: Unregister auto-created region when
 assembly fails
Message-ID: <aYPlJ2PRv-FaFKFT@aschofie-mobl2.lan>
References: <3bcc5143777acc6d45675d78dd8c57079406bc53.1769746294.git.alison.schofield@intel.com>
 <2a613604c0cdda6d9f838ae9b47ea6d936c5e4ce.1769746294.git.alison.schofield@intel.com>
 <697cee39ed313_1d6f100bd@dwillia2-mobl4.notmuch>
 <aX1VMDh9IY4eg1h_@aschofie-mobl2.lan>
 <aX4kd-S3PQTTWfol@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aX4kd-S3PQTTWfol@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: BY5PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::37) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY5PR11MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 682476c7-cc35-49cd-5c01-08de644e134d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gIVsjotYMaegGW96MexDj3Ce6XjMlATWVKuQS8A1RTNpl28RcFFL3H8mSvzt?=
 =?us-ascii?Q?MIfjoX3Hp0mrig45u1Aj2mkWd74yG4DFaFx+1PA/0nusQ9aA0GeLXiJSSlWY?=
 =?us-ascii?Q?x06HsFB5UobIkyMZpM1j+KyXzw09S5pm+ei/+8wMpuQC0CwHt+kT5ZxMm6ZK?=
 =?us-ascii?Q?bzOICTriVwMrh0smlkS79MF8BbKIiEKDWtFLLPGyTCn11vkFR++o+V5/oyES?=
 =?us-ascii?Q?SpkLVAUy4yh6csjjToQzbt7m5KRAuUrsqqTYZWgW6wQXG3VNt7ryDkQrCff/?=
 =?us-ascii?Q?0v/xEcp/VcPT9Yq5S6uNgwWYE4gdt4/XCgG90uo2Z1o6eR/QwBa0FvRJipde?=
 =?us-ascii?Q?X34skA2OUCNJ0iW1NEpytlocaV8/RGVsGeSFNA4Ce+ZZADTTPfymMu4TioQ4?=
 =?us-ascii?Q?HgPk+/1wxNHAKiFNJHPRx2kPFtZSQypdoTt8PHOkeoHwRepf3dZZP7U+78Ko?=
 =?us-ascii?Q?pjFvwJ07LJTCu6o0Y1hp+YqYXSYqhRvBmPXO7U+A/f/mrBGBkFCMgNCjlLy3?=
 =?us-ascii?Q?aGZQPobivXpog2s08WMZCGp9Ev0Yopw/wCmqdHvfojXfRBAQ86msEgaTNZRv?=
 =?us-ascii?Q?Qz1p7dHSYaWEpfJpM8voEaU4EEGaSJj6IfEDGK29+FO2oXCWZmXEcLYXFeau?=
 =?us-ascii?Q?eQ1VUg9z2Rn3eBgtFgIPQHV11K+sKvBQMulzMzoubfRbR8RB34EDu4BsiSEo?=
 =?us-ascii?Q?qcHXST4KTl6YmjQW5KCj/y2VBLdaAcN9GKUlOe00yh4/pbwyi+jgVyJZAzMj?=
 =?us-ascii?Q?gDaVvjsMy4diGMLxYI4wXlkCSurNLeMpJrD8VB8ANJByItorIlbdxmJ82uIC?=
 =?us-ascii?Q?kjvJ5xaqfiynY1x22dNET1y4gyqwTDSKMEuOlNs+p1/f4hfLFPrHSPaqH/xK?=
 =?us-ascii?Q?ri19zX8RU6foH51n32YpcXPvmdKKDWXZCqOsexAZ7Ihp0O+CWUnrCU4DfmKY?=
 =?us-ascii?Q?KXnrulFIJ78bo+nJFwHb2gucMxhuXI9s0k63+2p4Ti769FlxQqy4yVTttt/Q?=
 =?us-ascii?Q?2x5UXLrIYj3fdcjhAtk+yXSntRUYhOMPpAibL1jrgBSyCk0v1L8CLb8zXo6/?=
 =?us-ascii?Q?dq9CH2QguYt+VuMNk2P/tdHUteG1YYSGkYyMzZYUf0YhWuFsFNiBIhL3MaaZ?=
 =?us-ascii?Q?J4aksPbX3n1G1CIlhT2ioxJoObXpez9NAwaM/quo0Uyaznm3xcWTLtBOMPS8?=
 =?us-ascii?Q?OUrBabng9cpb1fy8mySyCMdz8dnzvEWyPv11peLsYltEoAY0YFEIHv5inKmU?=
 =?us-ascii?Q?Nfv4UICKfpzJdsIRaf2I2FOi3eeUG14A/gpFfiaZ7We97FXSO1NlN9eG2XbL?=
 =?us-ascii?Q?N2lWsiEcOswVHqkPDcyHb0Z+2LuZV2DEjQwJ2ivhekVL8WJPqdV86Q/JS2Jm?=
 =?us-ascii?Q?SmoGbnu/sfKnEf9/rfHYANrPi8LUl3EWlZdrP10b76HgoLTqLL8sTiGGlfPI?=
 =?us-ascii?Q?fm1JwAk3QS5Vgwde4UjowuKfV7c7cLn4ZpEH15NwlmKYu2Ypbirm3A81bFu7?=
 =?us-ascii?Q?/1LpJ3hmO3Z2mGOph6/aeHZqrvbWMB32ivvirYGEOmDJmBr9VbBU21IQHl8W?=
 =?us-ascii?Q?LtRQqG7kEtd7ABy+WfQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AMqEzMCHQ4uMO4BVaEwI5/JaEdUSQSQEg/d++PNVQUko3PUuO18c4JxzQSkr?=
 =?us-ascii?Q?D+5YDo+hRxPgC5vFpOwgc4Fic+4xv7VRIxZAgxDV8+avSsuODeGZQJuXI8r9?=
 =?us-ascii?Q?iYvC4Yuk2sl8rxyZPYwMEDP/3kVU3ew6IA1J2+ZuRmf04BN1bP9OODapOEbp?=
 =?us-ascii?Q?tnoJhz6OcZfWu7XcYwHnvXdyi5l654ZiN+c4lfTpNgCJoqiRiWezCx7dZk/4?=
 =?us-ascii?Q?1sdUP4gLBPqO7zRWRTRf5s/3TOd51Vumb+tP0R94o0HtBE3PRQwAN8Mvm6i8?=
 =?us-ascii?Q?u6/5p3W5TYy2WyZpQmaazNPPKHVrxgTK369SV2iFirP0IPYVnr6t0cj4cTMX?=
 =?us-ascii?Q?s7aTUvbNpwsTBxhG9w40mJV8cZhNSu69vDgi0F5hv00q9uS7OjqzDN37KjAk?=
 =?us-ascii?Q?QUdxC5Ws7ogEFsx9AyHDo3YBFkJigHiBDqzJwnzOvQYeXE5/hfXQwp9bJshC?=
 =?us-ascii?Q?VxoB6D3ieEwLabqorrXM8GavGq5rBOmw0Pb2Xu3c6/dhfOElhx4BJjYBLZy5?=
 =?us-ascii?Q?D3yLHuYdU4c8ducmfUxTsbvbpzoIrti0tf0eF6RejbuDhg7BFhX0LI0U91PU?=
 =?us-ascii?Q?GAXj3eQeM8AwA9DbOryj5/QnqTEe5cnr241If+VycS2dX+PFPRI6nX1yfc60?=
 =?us-ascii?Q?wlEnbxyDLhUpAPavWL3pRvmHrPCTaWhOYrOD4spmvP1gZFwu8+BsWDYwrmG2?=
 =?us-ascii?Q?PgGP6CxKGA1CA2CMt5jg8nfW45Vh7eTKKhnezZ0rIHxd5XnHTwPTK/RcKfze?=
 =?us-ascii?Q?9tQlvd9Lb05yFDMJGSeu6oTpnfOoxALbAFOXZC3rZEjpPWrsmc/CakCKrvmn?=
 =?us-ascii?Q?Bz21PdwYwirfY51soBrYFF2Rvz8ApzlZ1u6WxaDWl5qzYesP0F1D32DC3GYS?=
 =?us-ascii?Q?5mlF9qo4KQ/94B7lZYjnv/w94N1Aiv7OrtJBCcjyZHnhZaep8Fkb/Nr9BjqG?=
 =?us-ascii?Q?HMrF5Xzgq/K2bcY+CSLed2B9/Z0jzYMfxfXhwp3LDBluSE5/Ig50wRzbZ349?=
 =?us-ascii?Q?WWEBQ03Ph66QElx7Cohv0SgfV+j0MUQ/C2iuSToeQ5iTWTJ53ck0lRocIUNc?=
 =?us-ascii?Q?bOfro54KPT3KuNWbu6JZEmxRP0o0Tx6uV39/m8oljxRnakHNiN10AL5fFodP?=
 =?us-ascii?Q?wcHzjAdDw5ocAOALVaiQko3Qc/ZQmyk3ocrxHBnC0x25nhTBFOENFvwhWEzn?=
 =?us-ascii?Q?5v1U4QGzUFIDCSwDEbQfxsuUoyh46ors27CeWpfB4syOqI7inkAJ820ikC7A?=
 =?us-ascii?Q?YeBUVZhT+wdhWrZoPuSoADyamsTbC3s13M5FS4xNn/E+WYGo+jXIpEISwmT0?=
 =?us-ascii?Q?9YtJO4jLVZQPvGC+fZA8kTJYGXpN/etOU9SVxfol96kG879KWxJijB3JqFOT?=
 =?us-ascii?Q?RCuS2MfwtkSRuwnQ9WOd/DswN3+PPEZh0uEfEBSI9Mj2DEsEafsXFT2Ot+W/?=
 =?us-ascii?Q?gGg4vAl4FrS3VnSkmt4w6rMtodrmulXiMIbYW+Kk5BPUzcPCcl9wNKcBIHin?=
 =?us-ascii?Q?vbSQLlIbNVUDR/owcBsA1R3eqoXY32ZBM98A8Saxb718wS95gBZj9cygRKGV?=
 =?us-ascii?Q?mCv1Vs89QnKPWCUbXVitIsrbG8qjRH7jHU06gGgIEcTWW+Z1yaJMb9ACw87J?=
 =?us-ascii?Q?NlvhOLQ8w8wHo2IJgH4J0yazopYKX96kamgkIpm2RTuB0rLhuARMNd08cbTv?=
 =?us-ascii?Q?nkH2kHCJcx4eG97w1Qi0+B5VSYGHgV/zuZXV3nL8PWzTjq15m22RQkc/pmDW?=
 =?us-ascii?Q?V+434sBsbOV2izAejo4TPa+FUYALFZo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 682476c7-cc35-49cd-5c01-08de644e134d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 00:32:42.9108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BnefXuivnUa1LxcdN3hH4NI/Kf3iw1PPxUr9MIxhPZMG3wsU1u1rHeOEGILEuWzdazrgWpNtLFq14E9EfbosapGbFGaI47vNR4NoBmJX40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6533
X-OriginatorOrg: intel.com

On Sat, Jan 31, 2026 at 10:49:11AM -0500, Gregory Price wrote:
> On Fri, Jan 30, 2026 at 05:04:48PM -0800, Alison Schofield wrote:
> > 
> ... snip ...
> Logging in on a saturday, will respond fully on monday just wanted to
> inject a question for the masses here
> 
> > When auto-created region assembly fails, 
> 
> I wonder how many work we want to do to try to make the auto-region
> path more reliable for complex setups (interleaving being one example).
> 
> In other paths, in particular when there is some implied use-case for
> the device, we already take the opinion the BIOS should do nothing.
> Should we draw a hard line on when that should be the official opinion?
> 
> i.e. auto-decoders should be intended for trivial SysRAM regions only

It has not been my impression that we have that much control over what
BIOS may present. ie. If it is CXL Spec legal they may build it. I
recall you wrote a doc of Linux Expectations of BIOS. Did you actually
try to limit what BIOS does?


> 
> (especially given that a user can't even select zone-isolation except
>  via a global kernel build option that affects all hotplug memory)
> 
> ~Gregory
