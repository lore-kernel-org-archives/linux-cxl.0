Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793674378;
	b=0kwUVtXx9wpye5qJ0/Xxtl2aLAKwtMg4+6OiOYLKX4hwM0LnRRvy0WmQYedN0gQbO1gx
	 PZP8D+6OIhghAOzHjti9H650oG+VdoxOG0CniwS48grAzOMANvlKvIawliQbzefDMJLDy
	 rwG4ndBZzeTc/sOq+Dlu//7tL/xv8CZnmiYZ9Aps2jw5VPKNZ7B8lVjesoMqCJnZT/+wO
	 1bEiuw5LD011hwQP1Alk3p8iAesI1OJ5cVY8UJjBS34Ixq1QU/CSdP/mDP2HRFgmH51SW
	 J1XdiM8sIe96OgN0MXlBisxBFgS9uP4ieP7aBA1ifmFuSoLEhZMQJsNixD2XDuKZQ7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674378;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
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
	bh=eRd44CKEQtge4Na6GXz7f0ITzt//t1Vz8Os30TRjmnE=;
	b=TtUNbMTBrEfnj9oXI+760vo6Gj1wYGPAXFAgEDVsVkPYZHjYYdZRfdVAGUOIVG0LeO1c
	 XJeAm+e2Q2IGqEBcf3gtcAAY2HDQ5Z4qyqYfNQOFAJWYC36+5kz5eJcD2x9r/uz8WpMYY
	 yf12d+WGH7ZXProw4y9NNFiSzSLkPpKHdbIPDK33OraCw7s7c4FRau26xoA65mNVn0ECA
	 xFgR0N+MtrVag5YLLpUfmrUv0t1Qf8sMFcFYaLaOISwrJAxQK5nHzKgzaPKQFdxz8nmVC
	 nM5itLYZa4dz1AgroytOfodVQp470XKNnMOVqYdfncO6MbRgbmTBMEiTLhXbqeiuEjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mWHLqVoQ;
	arc=fail smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9C2606A337
	for <linux-cxl@vger.kernel.org>; Tue,  3 Nov 2026 02:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB9C2606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mWHLqVoQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793674377; x=1825210377;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uUJmbM+cn9zO0gshO+ybX0jGJAOEfuHaWYhmkRPpeY8=;
  b=mWHLqVoQkxcUpgQYNSPyDZRYayCB14dRDxaUpRnUYlf2LedIyNDtlpwc
   YP3NrMc0mXZAhH5taAXtF9TLstGK/fdFFy9XUpbLMpTTK1eu4TGf5i2jr
   Fv6hmT2+2btlUi+pdi4XehzirJRJGe9Dn55rCX7HCPUA1Zw0Psj6C/N1K
   XasvDNCPjmyopTCSXmPR8xEyF7tKZ4VRq1Jqb/zmxYPW5aXfSsXsM7FRe
   +DWT/Oj7uWOFzJ3aS7GqofHa8kRxRyGDzYL1WLElChIlQbmyNx3Za6OHh
   QhtaB4/dRTlL1jkcPXHohl5jgA4/UtQpnsxsJXmLEYaPTIsm2hzkX4p5/
   w==;
X-CSE-ConnectionGUID: v7NCBh3TRm2mmShH6FvS+Q==
X-CSE-MsgGUID: 5pQhoBHVRPWyNELPlGGMYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2414407"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2414407"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 18:52:56 -0800
X-CSE-ConnectionGUID: +/6N8CgvRWaK9owACCOpCw==
X-CSE-MsgGUID: P/qLbw1jTvqWF6hqWl5BoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6620796"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 18:52:57 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 18:52:55 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 18:52:55 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.18) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 18:52:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLZ+9B+oonawfDxkaxqaeFJ32ZE8QjWAPurxyRQFvzVCmErKNjQyOrXBBD0+wLTrLei9Ukxg48UoPZnw/XCZ/hbyGV8REqBkoXbzUk5YsjGEJAZkSxwSkdioE6rMGRvewh6n/FFxqnl5yRtOByip6NqgsjJfF0knSg7InWc02ckKB7737HK1epL0mniQFRDOx3cIpk21NBYbdh6S+36IBLdv12Qs3ODOSCdzDov+Xm0U2/5Tb5K8kpOc8kN0pp7g/1HC2P6ng8EY/BMUZIssfEHvBvAUG0F1gaSyey54ca6800BOBlXKTZK2d+1cgmRrDWkXbJRHVYfR09XxBAKHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRd44CKEQtge4Na6GXz7f0ITzt//t1Vz8Os30TRjmnE=;
 b=W2CNBoAKkWQbEcP9RtUPFoipFGMN6rYERWP4WzIBbhRGcKsrumtoouYacM2MJ+qnBAY7RFl8CKwOaOVfXCQWza8Jw1/liJwcTYMD6IDEsetkLoWEF3GNT9R7i/f3PFvvm0cO0MWvVOevsPZk5qxWreiOyI5cQV346YtG1Pgb+yFJE4TSPUqa7Sa5IDLtAeXbhC1Ufc4ULxcPHL93zKdHX/Cs2bO5/CXrIRoOUifeBWa8BXiaOhI2j7d+t5SHMPpdjdn2UPQXy9ghXT4dmzNpr0XejJL/MnUObyWTJrceWMLMvSQiC4TeTr1Oe5hdoodQANKekdATD4r8EssmoHgJFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM3PPFAB6A6CF3C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:52:53 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 02:52:53 +0000
Date: Mon, 2 Nov 2026 18:52:50 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jic23@kernel.org>, <icheng@nvidia.com>,
	<ming.li@zohomail.com>, <benjamin.cheatham@amd.com>,
	<linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v10 04/10] cxl: Add HDM-DB region creation
Message-ID: <aulMglfChjfQGGOz@aschofie-mobl2.lan>
References: <cover.1793567979.git.dave@stgolabs.net>
 <187374442f21d6cc52ec6b9e390550db198f05c2.1793567979.git.dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <187374442f21d6cc52ec6b9e390550db198f05c2.1793567979.git.dave@stgolabs.net>
X-ClientProxiedBy: MW4PR03CA0301.namprd03.prod.outlook.com
 (2603:10b6:303:dd::6) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM3PPFAB6A6CF3C:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8c55dd-fcb1-405d-3107-08df39558e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|18002099003|261102123227099003|22082099003|56012099006|11063799006|5023799004|4143699003|261022105027099003|261026121527099003|261026140227099003|261022075727099003|261028144727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: jD2ieriwnz2G/2t95wcOptxmpkxp9xUdg7s5wvn7KATq9yCcIsafPgdiB9J3/Daj6Xt6qpwpsFPOOAE0Z+3qC1RgR74B/uvZTcF/BOinbrjK0g1RUtfXANnqkuAKEYX83olpbOQCUbzU5QcK/ShOHESp+nECtnarIGnt8yCxUshPU1x86OhxsEWKlhO2E3eRG6XE11O6wGfNO2ZWM4bnf+dvpMtxYjRa8CRterFlZgWjUHwhHG75yB2+Zj/RXRBVaG46HzC7yh4aqzC3mPzgMLeNp+KhKpgrwhkIFDOTSxgPu7Or4RFCyzfHjKFlWlTGgWhvxJQvDfW7okX9t4NEogM3OibsnsD9wCHgVxaSe/dfCJMsNogImUzkHdH2MDohhp+fHkWsITHK1Bx+u3aulRaHA4/ZD3j0d4XDOO0p7P9IcEC1+Yfz30zG/x/ajrIg59H86YqzJq01EKxHm3s8F4OrPXN3+iwB7jPtyrasjWjm9HaYcuWPzO8mEBrLgNzHHFOXr9K+/duIq0y7ozIPEimHC/vdDEQhpS+yMUIheIS2fxPrbFalrGilg9PRtt7i7ifv2OcUjon4KP5nujhgRQONqkQQE/9Y16xzo1gx7tjQB2adPOapygkY2rjrJn9LzT6GyP0lSuIZvOshY3iG8GA0N+ONKyunP07UcS1ESzs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(18002099003)(261102123227099003)(22082099003)(56012099006)(11063799006)(5023799004)(4143699003)(261022105027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261028144727099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3AVxn7Gkem81hK+ZtpEsD25foSAp3XL8KiWbb082oHJ5Synbt20k3bT1CfiQ?=
 =?us-ascii?Q?s1ISAgeho/Z8s4bSvKHXEbVlAFQqRvG8qOl5D6fwzGKrZ1UjZoUejhQqtra3?=
 =?us-ascii?Q?jkbblFHEn1w7Ijy0aalStqaFzKLNFOK+uqxoOFV6bsu8wHWdJBSafpwghBQH?=
 =?us-ascii?Q?NYjB3GDK0nu9IyY6NH4HBFqRpgvCzLHLcJtY23bUTYTZp5nj55xWMfaIT62p?=
 =?us-ascii?Q?uqKApjMW5AMBOu0tmfWivdPtKa3k5xYUjn5izYs3qfYtRbZmddVngYyIY5DG?=
 =?us-ascii?Q?WUAjNeh1wMcCy63cu0voOw9ZEVauHPQNwMFd+gmeutrzX8tyVuW7Ml2rdRFP?=
 =?us-ascii?Q?seNw2eU2LlMDs+rHV5MfzYa2VvinHceUNlzhmn5hHHGiGU/Ntwvhr2eaXF9v?=
 =?us-ascii?Q?FUtNLo/vOLzpcio3cq1TPrikm6QTLj+tQQvmdRGI8zUrjdLK/Y4G0z4AmxDX?=
 =?us-ascii?Q?RZDGHkWpFWoLVcy9cgFOdEEie0/dcHgc6l31EmWxwyjO5tsDuF4BQVN567Y8?=
 =?us-ascii?Q?mA9UpKTz4Cv/P/pgHe4fPOTMfFuA0hm1YKhEtl34mhpxRjBeRfQvr+tMmGdW?=
 =?us-ascii?Q?rr29o+8FpU2Nz/uaqORnmVc7CrY/8R5wINc9+1Qm7mG3KETgKo7qQlrbvWHx?=
 =?us-ascii?Q?lsAnamU8rdBgGobyakYaN0UKiUXOb6+46lyKErV/A0j+Pct4U25tXSDcSvb4?=
 =?us-ascii?Q?aB8yPAO5G4Lit3Dh26nphHxiQh/cK7lnuY/HQ73zHmBzhyuzv7YVrgi6yGi/?=
 =?us-ascii?Q?w/b1dRoK65/3ShQIIZjsq2rZ2Mip8UJYxuVMYIwd8ZlXHcPb3VKKk8x9Teu8?=
 =?us-ascii?Q?GMWE1WNnrhlED2NNM7iYuSXkbheskqYJD5st6cB7REdr3Wij5mvI9Xw9wKSy?=
 =?us-ascii?Q?zPiS70+MPY/igixSS2/w7TuKED6rl1rPYx1t9Sf1+GMB5+mjh4n6+xe/584K?=
 =?us-ascii?Q?IYqdvytxqnW0otIqJdK+JJswWkQq9Cs3BTDGf+YlWQ/yHpZgPT3ZcY03rv96?=
 =?us-ascii?Q?pzRAhe3t9UTGVKDAL2apRBvWy+VB5KR435BcDMF8FV7zXh9hoz0a6UDw49cD?=
 =?us-ascii?Q?rQQToAlGD1gHHmyqFDd/L5I16gcms8XUFeNZHYHH+SkXCR9oMyrnA6ppAWcM?=
 =?us-ascii?Q?ljFY4nF/65aWWQrHjGnt5L4xjjXcOQVshGRWQbMaAaBAiJKYEhqcvRaOOt8U?=
 =?us-ascii?Q?zAz5ncJbilwkEjo8uTGOOGYCZys9f2JVkcjUbhZzqjfjjwKXRDQlD1U5bdfl?=
 =?us-ascii?Q?H8eTx1TAs+WRB8SOOMMy0KHBmWXlOdxsbai81qRS5o4LmoCKUEiO82x4ReIO?=
 =?us-ascii?Q?gNvo9IqV/iW8tNpd4WENMGVXK4E143s7m+Wng+PQiZ3os9wNLpHqlZRDKp0c?=
 =?us-ascii?Q?+7zwC6AIb/FbS50YlxUvxbzTTunYPkztIN8VQwz1kiuZ/4ru4rBAqi5WAHOl?=
 =?us-ascii?Q?o0e1Ja2gRcS2X1FoQWzfo8FqLp+8f+CC1JU8opu3sKmmPfl03698Yp77vusc?=
 =?us-ascii?Q?658U2iy9g/dRyRbqQxoRUl1U3fgmdb1ykKNVPIn8IG4L64n1ptNfKMttILUw?=
 =?us-ascii?Q?4L9CCJZ8HkJmPacTMHYMut+s99rLRsJKW7wOEDPQSxbSoGlQ+SKWZBoXqO09?=
 =?us-ascii?Q?f5t0EYIbsOWz61xWJryL45Gy0olc481P3ZX/BW3k8+v7ygCfIinqNUbIku92?=
 =?us-ascii?Q?qpIfCywKZn0pCT+iZnEYzWrzTQHIrpEMfP4+lBcndkeZcqNFmz8CvjUQpc4F?=
 =?us-ascii?Q?HwoLgYZYs6beojDiyahifvk8IvpI+hY=3D?=
X-Exchange-RoutingPolicyChecked: KyJx8m21WQpUxl9eDaMTNZfRBWa1NljUil7pox2ni6fOYrqohcSH2OBGcWS0du6ue4gfg79yLso488/yVoR/w1F2HH+eCS+baldDYbgNNoMnQzpXNE7OFMu79yp1o2QQMBACGxsCv5SH60Z4jPq0YtKpGgzcbMk6OaZFAq2tgsVy6mnfVdjhUb967upJWo7ZDfZ5oU9xSIYqbhueRSJtu8BtDepUa0LnQFsj1RZ/nLLGRItLwovG/uTw+DRWtKmaVS9WQaGirpoYKddfAWIqNhoGZdLpq7AUn61xbPWt4mJPUOPpC1e9Pk0j4R+l9sZfTFAmD5dX78rvNBDRsZwzFg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8c55dd-fcb1-405d-3107-08df39558e6d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:52:53.5960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LF4T+DsX4vBoEr/dkz4UIXFcXWkF9LLAtNqFASVZqbnW3OlZ4w+iQpbzxD0w18H87vwZQoe6pL+I2sAANkzCz4JBJCSeIJjjOOyE/3j33V4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFAB6A6CF3C
X-OriginatorOrg: intel.com

On Sun, Nov 01, 2026 at 01:51:01PM -0800, Davidlohr Bueso wrote:
> A region created through sysfs inherits its coherency from the chosen
> root decoder - HDM-DB if the root has CXL_DECODER_F_BI, otherwise
> HDM-H. An auto-assembled region takes its type from the committed
> decoder it is built from instead.
> 
> cxl_acpi_cfmws_verify() rejects a Window that declares no coherency
> model at all (neither Device Coherent nor Host-only Coherent), one that
> sets BI together with Host-only Coherent, which the CFMWS definition
> calls undefined behavior, and one that sets BI without Device Coherent,
> since HDM-DB is defined only as bit[0] and bit[5] together. A BI Window
> therefore always exposes device-coherent memory and nothing else.
> 
> Introduce the following read-only sysfs ABI.
> 
>   - decoderX.Y/cap_back_invalidate (root) reports the CFMWS BI
>     restriction.
>   - decoderX.Y/back_invalidate (endpoint) reads '1' when configured
>     for HDM-DB.
> 
> cxl_region_attach() rejects endpoints whose device or HDM cannot
> serve the region's type; target_type is inherited from cxlr->type
> in cxl_rr_assign_decoder(), restored to the endpoint default on
> detach unless the decoder is still committed, and to whatever it was
> on a failed attach - a refusal may come before any inheritance, for a
> decoder another region owns or one firmware committed, and must not
> relabel it.
> 
> An HDM that reports Unknown coherency support is not rejected.
> Supported Coherency Models is how a device declares whether Target
> Range Type is writable - Host-only+Device Coherent means RW, a single
> model means the bit may be hardwired to it, Unknown declares neither
> - so refusing Unknown would also exclude devices that support both
> models without saying so.
> 
> A Type 3 decoder defaults to host-only, unless its HDM supports only
> device-coherent, and inherits device-coherent when it joins an HDM-DB
> region, which requires cxlds->bi. A Type 2 decoder defaults to
> device-coherent and an HDM-H region refuses it outright, since the
> spec reserves HDM-H for Type 3 devices. An HDM-D region is only
> assembled from a committed decoder, taking that decoder's type, so no
> inheritance is involved.
> 
> The HDM Decoder Control BI bit is set at commit time for a
> device-coherent decoder in a region under a BI root, endpoint and
> switch decoders alike. Whether the device has BI enabled (cxlds->bi)
> is checked when an endpoint attaches and again for every target
> before a commit programs anything, since a reset in between
> invalidates it; the refusal is the same in both places.
> 
> A committed decoder cannot inherit a region's type, so its range type
> is checked instead: against the window before the region is built,
> as the manual path already does through can_create_ram(), and
> against the region at attach, where upstream's type mismatch refusal
> stays for committed decoders. Committed means CXL_DECODER_F_ENABLE,
> not an auto-assembly state: a decoder left committed by a region that
> never assembled, or by a locked one, is as committed as one in an
> assembled region.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

v10 changes LGTM, Thanks!

Looking at Sashiko's comments:
1. the qemu 11+ regression I believe we agreed not to worry about
2. the stale BI state after reset, needs looking into
3. the unreachable CFMWS validation is a minor cleanup 

With 2 & 3 above addressed, you can add:

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

