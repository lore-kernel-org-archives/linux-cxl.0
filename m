Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794872705;
	b=AqvDFAPyGsV4JaeV7BEH4vFHlYxeHmwHy9LF3pYQ6HmlNcPLo2EOnnncoYDgvmFXWdy8
	 0kY5CcJ4GB4Figoaog8r+Vn2sxBjaBqwMlv6VxWsgre6VE7uqSXIkxZrEitERC+LnVu2h
	 yTwoKKIWDg1YR3y+PEuv+RQGcvUVzm5vFoJc6QRRJ8ZBYnL4yTqwZ+1RfnDrXmP71mvdf
	 2V5VmG6Xz2r7VppxalkmjLgapx9PWMI7mWjb/IkHZ8V+ya+2wifaIlHYLIKy+tTicK4Dy
	 Qsa712m5U4OjVXu3kxawCIT9cVYaVJ/INt5fW/27Ik2/c2LrTB7SqXX0R/Su3d5C8nA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794872705;
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
	bh=P62q/mdhXuMyBB6PRpbZJHHyMMu2d7Q7pkrBWj+xLBE=;
	b=jlvzPpsVbkjhQY8dW2Qxda3myF4SeOj1roiHHoLPUkIDZ+6Q8+n+Tds7JBqXokmgFl+h
	 QM+zBmQbK9s6i5iaDATAr/Gn9y32dwOMAJjYun2TfeWjCCP4IY9FoNpe/Fhchi+7ALQqK
	 AX3ZXmcjutK1e1uxxsCXdo1rxk61/cYLkUhr7zUK9ueDuOSt1OtslLjKWejxLrhaOx86d
	 5eXXlDCq2vWrzJsX7cxPBY/sMfHNXkhzxYMsGtTWNkQxGJrjHdvQQ3gm6/muxZGmFWPHI
	 iyf0TxIzH3svz0GkeRah5HBEvyL/m3Qm/YxV1+c+AjCpjf2Ctuz1lO5Zg63+VYizLUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="mYJiLj/A";
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=grbQWsxL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E00A606A32A
	for <linux-cxl@vger.kernel.org>; Mon, 16 Nov 2026 23:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E00A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mYJiLj/A;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=grbQWsxL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794872704; x=1826408704;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9ZooVP8R9g3UbWQh+5KYpXi8YoCc6WUg+31Ku7SN4Lg=;
  b=mYJiLj/AGmzlRSCgPqvaHgul7HX0LJ3rcGO1SraGtdakkhRXP/KQpstJ
   PNdeEjI3g9gD8grBhb5va8GfYCDbksuWUKp5qVqrRWetZIMkM7U1PKgJi
   jGTq5ByN+y/Upyxhd5dbxW2Tur1hQhlAmljO8kNOU3ZoE0yxOsUMJdUQ+
   4ygv2BabSiYTC7A4hkh6/9iIDnntYlkusPhlVwsXJUBZIgIumHNgwYTJp
   o6fYft+ML3WD2R5GGR/u1VcxOtBdC5zngjC8plLgSsvIWiUIomTt9VDxt
   zgaJpqCrlLss8jbQY1IkzFNXJRwJVKqnhFdvne2CaTm7zXRS9y0TDnNcV
   A==;
X-CSE-ConnectionGUID: UslT5YmVQ4ivi42V7otxPA==
X-CSE-MsgGUID: YgTMH7M+QouAfx2cvUDceg==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3519302"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3519302"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 15:45:03 -0800
X-CSE-ConnectionGUID: MME+bf6ETTCmEd0QMtHZvA==
X-CSE-MsgGUID: KZsTC02nSbudVf1QrUW7TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9571125"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 15:45:03 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 15:45:03 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 16 Nov 2026 15:45:03 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.39)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 15:44:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PW7aYalK8Cuml4eqhrJVM+g9kzKshZoJvRux9nyDTJALMTSjM2zpBVli5ATeTyhfBr+Z+8Dm8tB27G0L3BTMxw5UMkNKFUv8sFSNkGHCENPMFkXNUDQhHW1gyYF9WXoGKOZ9xepO9k/zqvpfMv29rEKu0myz5CD33sGpSSFz2BcVuVi1nIcVPOHp12K2ta1Uf0QyWN9MmQq7SxRUMFKXWHxh19P2v8B6CQx+9mKlZBdUOiHUnB2zJXPJoCfv1uChoFwb2Yno2zKirH67BWLboVAVL7T8xKmktwURA/noyNrzjQsTqQ5YcPRhFKxlniBmLoijFJ4PLL30Zposrf4pqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P62q/mdhXuMyBB6PRpbZJHHyMMu2d7Q7pkrBWj+xLBE=;
 b=D/h/PLKnJ9v5KqWajPOPezzck0XlH2C+kdF5b3v9x9Ama8igH8DEci12b3mz3YfsKUWac5zc67/QvNBb7mzzN3Kz0ini/rKLEoG6i8707AZlvt6m2Xnf7zPQAYIhN//GAP3O8pbSkcBRJZKTQ1ys11k5z1U3GplotDlr7C3IpUnqQofxxGNPOif6Ta6L19iMoPXXSCQaAcr1pJRWJ9KH98TBRFOt2Xn4n42pbRTgZhgn2ZIeMv8czMKktKsuNYgSS3sGYbwqpko+tgQoyKEg9WoBWMlONbwE9cGwepkVwOXXQ+xhoLbsns89Ta7ukIkYIKMPRFLxrRyuQLfffONZag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P62q/mdhXuMyBB6PRpbZJHHyMMu2d7Q7pkrBWj+xLBE=;
 b=grbQWsxLSMBryPd/Ylk8GLC2idi+rPG0SLc1FuYdXWfAp/uu2mRrHPrhhCjUpGVffndrhroYhOfXlLM5c9VanzkqNi3cillaB5XsggW8H7iFdmYRi9warEloc3OElPFgZ/PU93xwIDWLu7cnkEQ2xoHqzmKUY7jVN2TxENXloZM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 23:44:51 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 23:44:50 +0000
Date: Mon, 16 Nov 2026 15:44:47 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: Dave Jiang <dave.jiang@intel.com>, <jic23@kernel.org>,
	<ming.li@zohomail.com>, <icheng@nvidia.com>, <benjamin.cheatham@amd.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v11 00/10] cxl: Support Back-Invalidate
Message-ID: <avuVb8__dz9sgNVN@aschofie-mobl2.lan>
References: <cover.1794172701.git.dave@stgolabs.net>
 <f6993ac2-8e1b-41b7-91dd-7bb8c4d29311@intel.com>
 <20261111015651.pn4tsbwhd6qb2uq4@offworld>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111015651.pn4tsbwhd6qb2uq4@offworld>
X-ClientProxiedBy: MW4P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::14) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|BL3PR11MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: c15eed6a-d85f-4754-747e-08df443b9aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|6133799003|4143699003|260925021911599003|56012099006|260925022911599003|260925021311599003|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: akrL4Eid3vxGW/NYpQp1TWokcUBT5/ZmJxt0+sPVnHhqY3HztCYA09RGdDLAA+une0IKuaY/ZC9r3MwcfpYDHPsrEf1ntMD4cNT8urbYbCouxeqAoHlCTtpdyeWKFPnKkWbjkg2lxJtLNKOO91GJY1za1RMzv59YNaoDOFCzDu7+qBhaEoS/nXQErnqGvwmr3Vk3dSizxk8UMc0TtYydw1BOQGTbcbxN71HPkAf8nFgxtc84H5poFgO+wB9k/fC0X5u+bS/YrefOrHdnXs097vrbQl31D2U56YyDNz1twFvJ1ln1toipGxowMRE68RHOCYzr4fhVIHj8qT8dtXviC6wT1sLWdAds5JtM3YZgITqPmi3VMwNIGtcJ7S6yppSsFWrPh1mF+/1iRaJjslsdLXcAoLWuJlQIy1LJE89eyk2NDZQsiL6a6hP2U+R4NPP0YdsTleXFDd8i/tmxz3RILUsOWdyKv+6orB3UUYv61McLUTcnyJAW0z9pXFEtYPFf1J4//7KnqznW6vVLDYHezxTyLn0l5eLKkuWZEDnHhlHXyCuZ2wqcgfMJDWkFobhzG4CBuS9eHjt+Nwxl9A4Q2kDlgzdpHEaxVSRPKZPg6EUp/6qwBf/G9W8OFsh3JEiJeE3Rj6PYiK+Botad8fDwTmlYw7DAyhQ9P4dqItxsvEU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(4143699003)(260925021911599003)(56012099006)(260925022911599003)(260925021311599003)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vViGHE3DsBRG1EYI2nfLDkwWagw+yBBtClXvRWZbwVnLfcax/jXkc/K2GuM+?=
 =?us-ascii?Q?Hpp0U/vkaSS2e6qw1lsg3Db9UQzkixveXd8sMjkMURhZhh69bzL2YBD4yaIO?=
 =?us-ascii?Q?6BxMMeVijJWzJB68IpC1j50pHawCUAfD4ChkP3rhqiEUCMmxkohAaY9ceRUH?=
 =?us-ascii?Q?DN4mJQ9W+mDVj+1hyOBuCHVHNTXhSuqjBC9k4DjpcTdJ+TcYDQgikltwf+3n?=
 =?us-ascii?Q?C6bMsCF+kVJDISnHX/F2th4FquzHnOZl6GwtG6P2C/c61MkdzUXBAC3ZQhJ7?=
 =?us-ascii?Q?umDLWN2SN3NJg2StntEu6/TCKCvUgTbLqmUKZsKmMeriddY3w86P56KwptQy?=
 =?us-ascii?Q?8jNDZ1Nv5olp72H2C4xtUvBZYgbegoR/BY8Jbsq28otFe+p3AXmJU9nUcOsk?=
 =?us-ascii?Q?qhVeTcOu5+pOOp6LRrpiee8CLawEILJONrg3chOZKfvqI3uNkRVuRUL1kh11?=
 =?us-ascii?Q?XW3BF6sX3pgYJkXD2bYWlhgtsoTpwRIun5DpcNYdYnXy/Tsi4IkG3GPOICXc?=
 =?us-ascii?Q?S1Ol8DF95NdW05MChTLIe8vwz4eQNDKieoJcpZi4PcnohIeu6aJPGK4MUTDb?=
 =?us-ascii?Q?Dnrw0Ins1t3LSGSW+RXXyNjfyCoEAQH+/tmVTqP8TysUcnNYJLWCwIX/frbR?=
 =?us-ascii?Q?ycu8qYHcTZEZRw97jCAHudoa7NO4N72ePczwVGwhcE8P8ZbO+PD3FFfxJQve?=
 =?us-ascii?Q?zffwc0oth61iq7I45EpY+qQgf7rvIMoCVJ2NQSeMVyTMR3i0usP0DUDI/ry/?=
 =?us-ascii?Q?uMcEPruz6Rzq6fWGWDORWUj+Lk2sn5xK7hcbv3pvqcbBYcDumIH7CSDR3aiy?=
 =?us-ascii?Q?+BhDxDB0H6gcY9cIBkCt2nOjLDZr6Nuax/vYjAoOknmof3Atz0/lfqbzMWE2?=
 =?us-ascii?Q?r5Lsu0rwBZHSFZZEy4MlCJtwTSubMLm1dFktMjtRgnd0zypUkeIwT31qyi3d?=
 =?us-ascii?Q?DztF3WCbqO6QrztthdpT+oaNOCENP+94ikBauTbxR8cFkXcbnI2dzesr1y0w?=
 =?us-ascii?Q?WEytA7PzW5THefeN9twXJdXgRyDgLtCFpCZpypPB+25kagSJ1zpjgGFxXwLP?=
 =?us-ascii?Q?lb5HRyCgz7Y/oS/P7c+UKa9VH1jGPEx0RyI9vch8xB99skp7dd9iUfjxDEet?=
 =?us-ascii?Q?7KWe9zvV3eMQNRfgbMexNTXwB0kn2WstWhS5k6j9KtEksQDGoeDAjyxtXG/3?=
 =?us-ascii?Q?Iy+7mu6puNebrjkbIOkZrdVicukFUjFpr+nCJcDw4N2omr0W35vjLpYGVuJR?=
 =?us-ascii?Q?/snQbeRnHP8sCeAvnfBi71jPPwVPawprbwVUifo2M+6rJTwiuvEet8LxYArk?=
 =?us-ascii?Q?fl2pZnq5gVcl1Pbwgk8gJmfC3Ak81MSO0KZG/3KfHLaxSgpzoIQSBctHzD/J?=
 =?us-ascii?Q?P2fmPo55Lw3C6o5hGCzoa4xCSSY5Nw1p7J4VCcQbvBpnVnBMRvDWkYWzmT3P?=
 =?us-ascii?Q?sBGvx8jqi4wWxj2qVRAFohTLL658DPCMDwF0G/fNZ5GFtXaRbaFE2emcGOzs?=
 =?us-ascii?Q?Q+M/br16uwIv+dZuks2BPRyMFKeu8cQiRhOga3LEcQ3zN/Vathz21wPhqoMs?=
 =?us-ascii?Q?JgqQKgMtge+W1vOIrn1BGJWzuZfzNL3EhM66jO03UiTJN4NQgw+CnAcS2gI9?=
 =?us-ascii?Q?fRuk58Fa96KKYq8mBF5nYFJkbvn+GuMGqo36Gl+Qw1oeGgEyT5hyBZMJUtB7?=
 =?us-ascii?Q?4u3iSSlLqsRbAgurRcRTc0vSoDeOyUetuA2RABwd8fSGMeua7x1EvT0uvNH0?=
 =?us-ascii?Q?MuQqoD/C3N2G3hAscnzXvQLM6+mqLSM=3D?=
X-Exchange-RoutingPolicyChecked: hGX+S7uMeza5/Ta8Yp2FNRv2sTN5DQCbvV72XR8wa1PVp04rjL0EafjM8Pg4xO5UH6UpWfISwen78QowfW6754A4NNgBwf8FcG7t22cGF5Gjsmn46UtvCc0H2wkyTPsbb0zsUXDNEB83JdcsgSDZCOEqmJFIZ0U1IiQ9ga/gkw1PLrlTN7nsrL+/9m8xH1u856u58WuO6sbrDnecBwVC+h9JhDAGeyohuqhgEx1d1hND1TldIiZkCWWtzNZaL300QGewo1eq0i48Ea9GHknGZmi11QlSOYibE5II0KAFDgzRxjwmmR8BdVbg+NIgAUD1rb7X0Zjrr9+vqv7bl5JYbQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c15eed6a-d85f-4754-747e-08df443b9aef
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 23:44:50.6178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwOMzhFbVV2UE6ZJnpcgntDlpnGs5QC4xe++gR8f36GAGlZ3cVuT4HfyVKW/bGyIGk8w66CRORiVoGb2JcGdHZt89rRdJWLRBu53PURiZcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6435
X-OriginatorOrg: intel.com

On Tue, Nov 10, 2026 at 05:56:51PM -0800, Davidlohr Bueso wrote:
> On Mon, 09 Nov 2026, Dave Jiang wrote:
> 
> > 
> > Applied to cxl/next:
> > d7e0ff278782 cxl/doc: Update maturity map with BI support
> > 7d9e54add1ac cxl/test: Add mock BI topology support
> > e8116033242d cxl: Handle auto-committed BI hdm decoders
> > 77d2d170a9bb cxl/pci: Split BI capability probe from setup
> > 6b47c508bd53 cxl/region: Log the coherency model at region creation
> > 77b165a5fce0 cxl/hdm: Rename decoder coherency flags
> > e4c3f0d96667 cxl: Add HDM-DB region creation
> > 617f6082758f cxl/hdm: Add BI coherency support for endpoint decoders
> > ad9c5385f8e1 cxl/pci: Add BI topology enable/disable
> > d81c479843a2 cxl: Add BI register probing and port initialization
> 
> Thanks!
> 
> > 
> > I fixed up a minor merge conflict with Alison's cxl_test changes. Please check everything looks ok. Thanks!
> 
> So 6b47c508bd53 has a spurious
>    Not-Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> 
> ... but otherwise looks good, and cxl/next passed all my tests.

Conflict looks resolved.

Hi Davidlohr,
Please post your unit tests to the mailing list so we can get them into the nightly
runs on cxl/next and linux-next branches.
Thanks,
Alison
