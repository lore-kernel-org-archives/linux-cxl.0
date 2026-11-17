Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794942090;
	b=4YGhcXFuu4zD84174NWoqc4H4y0nEbhU1wy6Og7XaL71zvCPlZKMI2j01GExhom0wqpJ
	 TESD9t7hGQmF+Ax/TZLC1XIWFXdyeRuAgHghk9cqSKfNlHNzO4vYKKRCB8Kz/22hicL3U
	 DYCzG7BNb5T5hA5dvnH7D4NUfn75jM8VZgX2XUaMFwyUc+0P+w3dV1U8EbDSsqcxL5rRu
	 iNb1jQOScIb0a9Qmbee/0jis+95TTqsDEuZmNdIWuYLTiCFaSRzMe5VfqjEmLC7UzSL2S
	 qbHRl4X09QCg7rzOHETSuWGLbuZVjk7dN9sdIlfFEh9mj3mgdM19kRtQJfL5fJJU4qw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942090;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=Iyqir3Sk8jY62JfkxKQyVpmAyrAV+5YhgJB7MTurJJY=;
	b=jnULcD5qnKEq1hhTrGfdeQbXrDiSKhgaabkp3a8iZQjEyCEqY+qDUPxWJjXei/KlGelW
	 qewhpYiNFZx827tBRdzXisKqDu79zVVomIVBIaulEMgQJW2GmqRb8W0aA66hdrmb8obb4
	 gF3w3Zzz3TdCgjBJExg95m4+SIgCogO+sV06qyBhvNBdtZGUcGURBfCQDjAhpjyXwdCTy
	 nNl7hgLRrXujMd4SGUr6i0FVcvARVAbXyBG2vTv1147UsipMEuN3atq7tU2N0s6500Wj6
	 ZY1ku8d72Ijv5oqTAnxjiH/2e6kcmWKdhhnur1CQiIn9mLEKVbvt/cppglOC2JB9uhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DhhX6v27;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=gaTWOoEk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E7C606A31C
	for <linux-cxl@vger.kernel.org>; Tue, 17 Nov 2026 19:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5E7C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DhhX6v27;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=gaTWOoEk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794942090; x=1826478090;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vVY8CK++wibX+bmVWKPoJuv3N9pQLWArRLZfYmfZmc8=;
  b=DhhX6v27WnEhxgSq6J2OieEG5mXYt8Wh9XcK4i4XpAMEoiXy1PH3SOY2
   Ja6R9JGUKR1RVtx+cHYZdFQISd5GVHGGFiiNGze4pYMjxBXZ6yULHNADg
   g4hS4dBZcOoW1X39DslWVfqatWNBaKT/LTsLSHpZylpKOW2iAYL0wMKUG
   RJWzE65Yk0rhDlTHbBOnM/835lqwTqdMz/51c+tuKblSRLsy3RaAFSo3Q
   CyO4jBUDP3aTbOiAbhekIpl7NCnaca9RXEKt3qAfUpy7sOEqDvMvLYs6y
   DujSlvo7fUSndiFYvHjsaI6rRWKVFZMXgsYTnRUX+gPnEaWR9VRO6U0XD
   Q==;
X-CSE-ConnectionGUID: D9uD0fPNTgGe+wt97HTXqg==
X-CSE-MsgGUID: eScsCENQRe+c2P8iM7H05Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3629171"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3629171"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 11:01:30 -0800
X-CSE-ConnectionGUID: VWiD/TNjQFGqQdf/w15nxQ==
X-CSE-MsgGUID: 2sXc574DTqevZpYv7Yq2mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10282289"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 11:01:29 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 11:01:28 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 11:01:28 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 11:01:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycuVYIxTOj5l5L7CMP3//S1xDNfxvr0vyCrGvyUbggEAjeGAcMz9Oaf0ooK2tlGJzq5FTf8nVlXzafwDfgjQGgmQ8nkJndExr5E9UoTj/BQscPoS1B3ePluitz6ORaTCxK06fDsdkK76bwuCcYyrHHHoE1FKAfyOJ+IGyyzVWFg6iZlXES4LZ7JDYnG/YNmIjb3lNSJT7ehvZvRtmyN7UKajG/EexPrDSQyjg3NPb2awUk8+R5dGVzl121rMH4r0Qj/9sRNGqcNGWhaNHrwXyXVQ1Lo+8/Y9O6BdkZjn4Ax4F0d4+53F7m8MxD3gaz91Ze+x6up5L8X1/2ETEum/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iyqir3Sk8jY62JfkxKQyVpmAyrAV+5YhgJB7MTurJJY=;
 b=ZMn7MtoNPJ6NEtugYMJpbH10YC+RbpN1eYvQSgY354ZZBnukFMN22/c2vpMNLgfdxOuZfTBFTReaYxBeM+1lL60gO46xbIRtDPW7v9y8zdd/Ew52p33l+b9byrk5wMeTk96HPjUGUSHZmvFpiD/k54976QDlA/6wYQV1enf4YzhT+zl/ONRe+1HD7yBMsjxzcyOE9PKQpva+2kUOPJFQNgb6AD3Uymvw1mf5Bz9W+UyI9i04A81z7TD//gIzzMo+edQNWXFRBhaRAtyiA8HwaOtoD0qqLX5bXMNNPN4XkWWgSnCK2b7waJHHLYGECZreXSsQTK+YrUB1nPQbaY3O+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iyqir3Sk8jY62JfkxKQyVpmAyrAV+5YhgJB7MTurJJY=;
 b=gaTWOoEkxBgAhumeYOW9uQupsbmoo24yeAf8lNKN8RrYOhy74JmZbMJ401IQkoLQI23sBWrY6DDuvSQ/uhRAS3ZSiHOi9nFTZ5xm1JKsz/tz1ahriVu2PjyejonxtkHgtUgOaV/9bRlSXGH68liG1Vnt4gfYErmaSfD4fQwsa2o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH0PR11MB5236.namprd11.prod.outlook.com (2603:10b6:610:e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:01:25 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 19:01:24 +0000
Date: Tue, 17 Nov 2026 11:01:20 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Li
 Ming" <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, <linux-cxl@vger.kernel.org>, Sashiko AI Review
	<sashiko-bot@kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH 1/3] cxl/region: Carry the effective interleave state
 through target setup
Message-ID: <avykgHJ_v45nbl9E@aschofie-mobl2.lan>
References: <cover.1794010889.git.alison.schofield@intel.com>
 <e99646b0692e6e01b2f71c6a80cc664b0066db57.1794010889.git.alison.schofield@intel.com>
 <20261117015252.61d95088@jic23-hlaptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117015252.61d95088@jic23-hlaptop>
X-ClientProxiedBy: MW4PR04CA0320.namprd04.prod.outlook.com
 (2603:10b6:303:82::25) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH0PR11MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: c036fc5c-3425-47ab-5d0d-08df44dd2cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|11063799006|56012099006|4143699003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ntoh9q7II/NV2rs6lhOrT4AmkQJe3MapCiCl8zPP+LQ9MneINsb4mtIJSIdKdrRzh2QI+wnwdD5JI8FT/VtFYMfbw+duVGxdPAfo0FRkLI3HEmsAzT56rAEhZwgFUid/QvnUfjp4gh2jjcSVk9Tkz4svzBjyV81mG9jwnU04whX5vrQBK3ldzxAEX4Odau3j+/MHmSgx6r3GStLVVj8wI6hWrHEBB3lUoUDNqSv4FrIOP9E+LhyTjwyJPPFFywskBC14yUFdwsTDrt0Z3WX9k2GvqjR1GaRguBvba7K+HgNBfw6t18A2RnTfo5tTceNYbzAxZkBM7EHqOdVlVm51rEvhjBpZQbFM77pUkBN9zXtY4gcvGcje91rBaYbiMHPmsnHBInPNwx44LLxLbgZ/zn6lEMp4pCN4BUdEzZP1B0yQ0i2GVCMCtJZRi85fL0zyCvwTaHkl+7VnusRqkGtcqiYRJBbviYeW5URL0RsGe604AWDg3sZ0TjkGKBYJDic1J/qtzW48UEkbuA8kRvMHt6toKYcPrkBTiqvpG68UdBB8RGW2Y40iAtxRH8fmTUOmiMrZ/zTlKf4rC8f3yKOb6DvRK+6S6yLkTpfaUtfXj4vbZpknmTIW3/P4Y9JIPXcvjW+lLk3b9zoC2WbmdGI0dVpaLkO747Yu6ikrHm0aU/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EVY5FaISZbEnSpMyCPOJ64SttGjYi8tKOITZymgnd4I+1Tk/hO/Y6I+kWlun?=
 =?us-ascii?Q?bW+1psJDgEn9VNx7krKhuEz0kTFP+P+CGn/JlBQPQw1N6s/4VwbdcqoyVuXy?=
 =?us-ascii?Q?ST+IulHLlyVv1pucAeQS8K55v1vlB6U/2gvFql8BJNNHK5cnDBpGsuMBGJDV?=
 =?us-ascii?Q?qya9CH94xhp/iF4NT9MSJn6NbdDor8SqXDUCwD43YtM5gIJaDVyIN+g6Jd3G?=
 =?us-ascii?Q?pzdMocqAYTxXFCreLX3rrqVpquU9XBg06Mrk/3mCPJTWP2lq6PLs+QSu1gSk?=
 =?us-ascii?Q?/Pn2COR6aC8KBcO8M42ZMSaEPDvoj1B0mOHql9vPRSb9XcANSEKmKxN2UGZF?=
 =?us-ascii?Q?pLjyRNTViojILDCOGSnfHuiYu5gQMeSfy3YIZTMtD5PX5aF3VQ2guWg1sGRI?=
 =?us-ascii?Q?Im6n5JoyRwI956vXtngsiqZzaqXexpwIquqmGIHlS3bpc/PS/AdYZ4Dc24qp?=
 =?us-ascii?Q?TdixfyrQHihKCDpPbA/UP64xY7AcN8WPy3GSTKP+C7R8Lj8Zy45Kz/YZ+Gbp?=
 =?us-ascii?Q?tlT6GVNXQkjBlo4pdgst3VEuSgwz4rZabdoV0hyNxyoRPsTzQoGUgA24zeJU?=
 =?us-ascii?Q?2RW9R6u7IPB+oluIgvdAhwFSOJ59jxseHXFX9ep1sL+fd5KAsLePxwCd+dN7?=
 =?us-ascii?Q?FsA6+Wo6oy2BHNd/4YtE8tj4CeGA2kyv1QQB+GxCNIW1fhSt2SqGDvnoanIE?=
 =?us-ascii?Q?EH8RfcHAc2dJm2CkUiO/sw92Y/CmmrnqXhagKJGLyo4Yqj0EBl5lgd8gqLL2?=
 =?us-ascii?Q?W4vBcQRcED2JaXrtVLHUOvVDB3Hq9bnKpnq2Oi4qOC1KwRZJ8pk/WyEDoGBQ?=
 =?us-ascii?Q?Q0t41TGMkdgKlPyw22Pt/tBbVoJvaK7Iqpt3ljLBiB6FU9hHHjaM/ge7kJ2u?=
 =?us-ascii?Q?SCqiIIEINU0stjU1NqHARgpk5iDglwZYTtqP9Dl83Fh5a6kTYjido7NhDXgU?=
 =?us-ascii?Q?ipJybb9bLibN/Q6/VarB9Z97vTmOkvkSxR22agWsxNck5uu7sciogD81+j4O?=
 =?us-ascii?Q?NAJJc9llQW6hp2IXAen7U+MNq+RZzfDAB9CKarN10t6bFNZ3LxKJVTShGG2l?=
 =?us-ascii?Q?x5NiQg6ZluyyiZT9uoNrRiVA/gPttZo7IZYZ+KsUD94i0eww5FlzDcVPKjMH?=
 =?us-ascii?Q?yqj7Jqab5L+O/U28k4nEC7ZlWfoskCHYlJn1qMBGVisqQjmoOWCYFQwEyMnf?=
 =?us-ascii?Q?tjRWSndvl4EBdc5p4cS2FhPA4rmWNyq+Mbt+QjN7q521I648XebCA7Z1oMNq?=
 =?us-ascii?Q?vWvOXgT1tDFmbgyDI9bTs2rfq5RoNrAKju/+vdry8C5CfWLfSH3NRSKcjcKf?=
 =?us-ascii?Q?5zh/wKSJQCFcPKfuO9TKUa1TDxQlmGwfZI3Jb2esdFhy1k04IghpMZhYzim2?=
 =?us-ascii?Q?PklpyBH+rK1LYlYAtNP3db6qavko04osMHohkgyMu7q2tt2XMyZLGU6lCp84?=
 =?us-ascii?Q?S39NaO8WzeteyAIL4SRD4EXXvGw/GayLgGf/vtI+0FJJTw/RTVXJqnyWMUNJ?=
 =?us-ascii?Q?b2TzRbmPNLexQwbn10BQBqaEEuAYChdprzR7G1AzdjEEst62xR5tCz7ZB/0J?=
 =?us-ascii?Q?na57YfvIz8tNOETsDmxKPRtG3D+sWhqzIKDvPkHU0t5QvDTPKErigXrXiH9n?=
 =?us-ascii?Q?ofuFfFiBFmjKg0iuJSKuLRsa2e2SmsQH4bpN7ZQEtNSaEdvp89B9Srw8qy8n?=
 =?us-ascii?Q?/3G+axai60TQLdl43YWrWK5sJsvPbXtTxDmsrnsKGgZTXOhH5QEVvp2Fytmf?=
 =?us-ascii?Q?Xkj3S5bCVJKGl8yDhLxLXk64H0+9n9A=3D?=
X-Exchange-RoutingPolicyChecked: ZDaBI5Gj2PPqs1aE/5Bqy5huDFNSaNMtblsiqUeKAeFiZOX25r5icwIKNb84YVq1kin2BYsuyHx2g/96aqmSfTVF+ULniXa7mSxnQbP+A1iunXZEGjB3LMdqw6KmSGY5I4dv+bVjm8YCAi2GUuDoGGs0mCSrJibj6/XgCoExK1VMzhyLv3l7JHwEbScCG7+yNbxgh3Q1O5Wv03cRuPdJMUsJqxR1z9f6B6AG/dJtp8W3KkRynOR4rvTb0+HHmYEnKY0CMdlVD/+kVr1NUscKqdSOSN77mGh31WsaQ9c7XgS+xoEsDwGXbIb6cQ3QVuytKaAdgDWS4knZiWNQPrGLDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c036fc5c-3425-47ab-5d0d-08df44dd2cc8
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:01:24.6161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhRRh9+uakYEfO3BSBxPSmbjXEWjepz5XIyMtiI/bHa10CwxQMaL5al27uLYfvd4zobxoXfMgWS81IWcRQSCVvi06hFMWn/E3Gz3tkzUS+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5236
X-OriginatorOrg: intel.com

On Tue, Nov 17, 2026 at 01:52:52AM +0000, Jonathan Cameron wrote:
> On Fri,  6 Nov 2026 16:35:00 -0800
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > Switch decoder setup derives interleave settings from the parent decoder.
> > A passthrough decoder's granularity is a hardware don't-care, so using it
> > can cause auto region assembly to reject a downstream decoder whose
> > programmed granularity differs from the calculated value.
> > 
> > User-created regions instead store the calculated granularity in the
> > passthrough decoder. Below a 2-way 16K root, that calculation produces
> > 32K, exceeding the hardware limit even though the decoder does not
> > interleave.
> > 
> > Carry the effective interleave state in each port's region reference.
> > Interleaving decoders establish that state and passthrough decoders
> > preserve it for descendants. Store the state because a later endpoint
> > may be the first to reach a descendant of an already configured port.
> > 
> > In both paths, passthrough decoders report the effective granularity
> > inherited from above. Their interleave_granularity ABI permits this
> > because a single-target decoder never rotates.
> > 
> > Fixes: 18f35dc9314d ("cxl/region: Refactor granularity select in cxl_port_setup_targets()")
> > Fixes: ce32b0c9c522 ("cxl: core/region - ignore interleave granularity when ways=1")
> > Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
> > Suggested-by: Richard Cheng <icheng@nvidia.com>
> > Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Just one trivial thing though I'm relying on your tests (in the patches
> that follow - always rely on you testing well ;) to a degree rather
> than chasing through the logic in detail.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> >  
> > @@ -1589,6 +1602,9 @@ static int cxl_port_setup_decoder(struct cxl_port *port, struct cxl_region *cxlr
> >  				cxld->hpa_range.start, cxld->hpa_range.end);
> >  			return -ENXIO;
> >  		}
> > +		/* Report the effective granularity, not the firmware value */
> 
> That needs a rewrite as not coming from firmware, coming from a register
> (that the firmware programmed but still!)

Thanks for the reviews Jonathan!

Replacing w this in v2:
/* Report the effective granularity, not the register value */

Keeping your tag, so don't need you to come back around on this one.

snip
