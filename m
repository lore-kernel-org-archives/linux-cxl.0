Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A8554774
	for <linux-cxl@vger.kernel.org>; Wed,  6 May 2026 05:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778044078; cv=fail; b=qSZEv0LW+KqwgTYGcI/NHz0p3DTrOUIXN+8ci1wpCvmeaCbzKbfF5CkIyHRh3EWOoRfcKBi8vwM6rsm39HsK+Kb0MKSYXIpQuwxvFHhZBfLomW+itKBj14ouIl/8RS/9hxCYZKTHhODcMR5PJVYVvg2r7Cqw7hH9moEhDnXJXE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778044078; c=relaxed/simple;
	bh=ITCDI1fFMMq4K2rUOMqYmlgCt9kvRc5AUBledzqn9xQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M686VmbxFimueZo6y9R6x+SKZw9OAthT6bgUSDN6d3sLnORJrP/BQGo3y74NGrZfUAVHn8DAq4Iw6HoUKmJJO1v044TMLP+9NmykE7NoppizJKqrMvnvEdwXdIp+VOfjRpMZq7vC7Ov8aG6h/WjkCmDKrxovWhNvmkgjLiaIlX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBn59bXr; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBn59bXr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778044077; x=1809580077;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ITCDI1fFMMq4K2rUOMqYmlgCt9kvRc5AUBledzqn9xQ=;
  b=aBn59bXrrcJlGSxylCsfHFiMM7hmeCDjvgSWnWxGjh3qO5h7X1lTm6RK
   Geaa8w26mShgeQPT3npUGFY2Jt3zbgTLEjwJvoREn/o3URgnrqk2sTrTi
   8DXeYOB8Yms6pQeoJbvl8xkV0UxXHbZYLocROfEOeidAlRBERFGAK6Iyh
   YcwjcBjYcYh0SaOab8xnRAZ89gS/g4NITU8i67NmB0tzThKvAn7Gx4+Hw
   s19UZU8ZgLsZJ79gA6TM9gcpAlRcEXWCJ3JLzLcJHHVHjIWkj5d2Hxyld
   mS0qJsDtLNQmOtNnv0r44iHqMucuTleaEr7irlcXszxfvn1iE0nENMpwb
   w==;
X-CSE-ConnectionGUID: QSe7e94ASr2CDDFecunrcg==
X-CSE-MsgGUID: 9IqYRMNRTU+jsmLPZVq+nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="96359415"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="96359415"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 22:07:56 -0700
X-CSE-ConnectionGUID: W0WJNPPBTYe+iTPF//cbIQ==
X-CSE-MsgGUID: m3qYH1PBTTOnpCrlh3W95Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="229539045"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 22:07:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 22:07:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 22:07:56 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.52) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 22:07:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caOacdnZE60Qs8eIAOPKuc3rPlicKBJvo5yxF6qGTmWjkeYVROd5jKnNXZQhcwNgTuEXZJflZRQIU8pr8yLUvOIuyn1r02ujWzsmH0vdDOyawXV0DK5pjxAKqq7sQ68zl1kcDsJUgPAt0KCNNf7gjNTllZ2251qJuLGM29bi2G8ELdzvE3lOY2FJ34mv3BiNtbdh7qOY17Ogs1osCY/v+c8fOMJGqPE+gzdIkjpitbTIpQlZkAhJBIAMQGyoxhpNtV2rqeGr1YjRnK4rDoTUQih6ez3fjmjCLu5F5Z+71B0Kcv0lctov+i7HVexT89Hy9Y0Pr1o6+CoeSMGpouSoGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlSEHv0qexrqQiSqScn/IEXDtVWKufWl3m8wPvZ0ym0=;
 b=TU8Qd0EIR6gwXUpSTAQ/Ya+TN5t50hawmdNDWHgUjhHALdG3sR3nEvmdKHT0vhuCdDel+7NtZJH/Sw3TB3eUsp9zeb9hKcphs7g2oc9hgjQcRsBdh1/lVHz13klKbfonIXZ7CUwZZIsjCIbeKvkIGaKTKVaHJVfMJSPcEax7Hnr2BwpSeFsFQFAXgZ9PvrA20BQ/gL6U1rEUOo7UKHdFr2LjrJCBh/pFXu98OGSuXiHZiSu5UBFortCnWj1DBxniLCeaUe8DDeQ4NvAdxKymgMtBsuz2qEojnHwKFIFERwwYoU49+mwNDNPhhHlkSkOFhrBqysZFAWH0OnHsy56c0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 05:07:41 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%8]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 05:07:41 +0000
Date: Tue, 5 May 2026 22:07:37 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <djbw@kernel.org>
Subject: Re: [PATCH 5/7] cxl/test: Fixup hdm init for auto region to support
 type2
Message-ID: <afrMmbNJV9K1kn1W@aschofie-mobl2.lan>
References: <20260422230237.2599333-1-dave.jiang@intel.com>
 <20260422230237.2599333-6-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260422230237.2599333-6-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::35) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW5PR11MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: c20745cb-27d6-446c-07eb-08deab2d6636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: glEynDOaHfvcDFHL/kh+/U3amqTUs9MjgLoeS+eaa6LkatqHEqzpN/JlgTb57RZPPslbYJ3pyYT5tY6k2Wv0BNeIjgeBPbV1HrOOcm+9uT8s/u2xf9oTdT78lk6bsUu056pgjIQhtCKrss27lL7zo7dfZKNBRiz92LNxSQIYgavBkjjBk+dwWEbCywH2mg+TbVWKC5NKy9W+n4JRi6us2KSiaA81zDsPEcsxFzs3iAmEoefE0pV8PQvEdqI7KUEliknMEkdSlWOCwvXUCNbeMGOFPHT4rGQBqTmCNoZf+YVmWrE3Z8VFPlwLN9yP25cORqK4ICSLb69yII4JsQxouJgyvvogBUazhrSl8qX7IJjlUaUyLj22EVYnlPcLGw3ujxxyCJnngCYhxLy5J/Dp8J3iPSjPXUCWlQ5+kD7HQq8Ul6gH3EbJ5SYTdf2WC5FGnD5D3xIBpy45P6FIN8/A0qk1K7KRtYhFQhAvwQSsF37MaxGoPa6cPETRKV2u+oOAiAuUgnVwyEmWvtn7uBjMM+8r5LR1aW40/x9EyWUQu12CMYVW48TVSWqN47ZZj/onV9jdJFUG5j9/2RYeDDgYc/1XIOfESSikurVBv7a+u50e/BIoNDtCPzR0/Y71HW5f9ztZVgyzz9VwSBguodaAVA3oyzPvvgeeXtZNYv0cdz/dcXcs14SLXtST7mdiyutp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qXOKif27mkMSzVRXAVmHc92M5Yrtcq8QZFxF4KVXUDXgS2qvQrHfcfLW0UMA?=
 =?us-ascii?Q?eyzNSpXuIkALeAUZmaJUDKjLKlJy3X8j61ShY1WFa/Vi2Wa+Upektn/sYIx4?=
 =?us-ascii?Q?N7NkcH+MS8LEzecP09xyp5byFHscEjvO9Ampi/zycz3ETJJpG3UUUhqIL/HQ?=
 =?us-ascii?Q?OqYPHTsnKYsGtbxtOwMfwnCepcLSazj6kB8mgqimh4OqiBY5ZyagEIkoEbpE?=
 =?us-ascii?Q?aQzLLqhElX/9c/xvcY1meM2TbBr8ri3nxb01HNz7I/RKA9AHU8+vMv8Y1ZcU?=
 =?us-ascii?Q?GIg9BaPf5fR5vOu2Kz3ETved0edxtKIwWeeb+CIFbpapGmsyX76C15fOiLZq?=
 =?us-ascii?Q?ZMqQdWALCYuW/e70I7BUE2L/8PCZRIzgi5TbiMx8hO6nmzRC2IFdKUpX4U8l?=
 =?us-ascii?Q?wlSvou+gFr5quFq/0hC4lzRB05/9eM3vRLdIfWKDey6skmUfCE+xKcpUp/G8?=
 =?us-ascii?Q?82/5H6urhqewEdMfgR3W+u+7NBTDx+IAlVSx+xanIUFlhFZAInyJPqpnWEt2?=
 =?us-ascii?Q?1mtcHk0MKxZ725lgL2oa/+PGcOMG4+Gfy23J0FkAdmYSzbC9eZvDnRxeNFCb?=
 =?us-ascii?Q?wmUfyBrM4jmxAghNSj7nSLuAgYuHNtgVGpV0T4TLsCAaPdsKkG10W0iZyazW?=
 =?us-ascii?Q?FCpbaD0LTCnz3PTXMx+V58sHGiuHD/Fv5JvCd1Kk3vAQHJbUhds6/2sazPtU?=
 =?us-ascii?Q?QwWLpEywE57gJq7NIfTlzeTsduodi/KzZsFh54tp/rXa78vLew3MKyRLPPin?=
 =?us-ascii?Q?OGvZq9cF2VkNIxk/XEi+AYCrKj7lXSuZShBy259BD4agY4un5FqPMtrlagD2?=
 =?us-ascii?Q?YTyDyl1xKQ3KI3hbpcEKL+7d/CSrguY1bmVldaGjU7r86OxSEQyoKP4LbLlf?=
 =?us-ascii?Q?0o3bX/1CBQQMUwt7cwIuuDopHBg4bSYApxqss3jbcztST94xEX7gxw4EMue7?=
 =?us-ascii?Q?InamLRMIIdGfQ1ThShY3/86Is6kqEy1dBiANUM40Hov3399AlTxB33+E8UuP?=
 =?us-ascii?Q?0FsuznUohDIJLsPgSuCLi/Sx487eTxAwYxG2B91QeuK9AtiW5kSfVJN9rwou?=
 =?us-ascii?Q?XlMoEO/rIX4U8NqxOZKyFd5mwIXRc4RxKb/lZPMD4ASfUuqeum4+rWxydi/S?=
 =?us-ascii?Q?iBC9tZr5WvXc24qjsXiNM0+SMWv3f8IANQXyR/INc7luGQTBFc4WAZZF7XGM?=
 =?us-ascii?Q?MSIQR2hSx9OJJvso4tOlf1ydWch8pDCmdmYO8mvKO4o35ltbPgtde8sRVjrI?=
 =?us-ascii?Q?EYqRbbLGrnY61nFzhxQtuOk0S3gjslIgnfVYf9hkVPnjKoR9TJvA5WuZM5r4?=
 =?us-ascii?Q?sGYjkymeQ/jt1FmUbAFYh3lXW+i2OBnRcAxLRl4xCCAZ9niwnfmCBGNwPYJE?=
 =?us-ascii?Q?hJdD0zjNAj4hhnJZOdYRKkzS9DDs5g6HXRoGsgLW35dD3oYie/tn/FaOVxUC?=
 =?us-ascii?Q?J7dTUf3bNt9KOGBr/yhIhvqYEWhgaScArKR6Z0lyUy3wEkOttutWSkTnKCa+?=
 =?us-ascii?Q?YWJlu9K0zN6WkpmXfdGDgZ5AZc7+WYZRN1ese/uSy53ija9jnjOjZklROZUa?=
 =?us-ascii?Q?M1EbfA1x5d89EoSlx3sBoJCn+vowquHhwJNpRjpyH4Ey6NAtowBGelm+V5uT?=
 =?us-ascii?Q?ohIALNp1e7Cl2pHnsD1CKu4ZvN77H/KwnN4WXWe37RsJkNxQ/ba2xALu+PD6?=
 =?us-ascii?Q?71bK7tvDg+hdx1Q5YM0DLMeL7F+lsVQjqhMnokeP8KszwPVTq8uLLWCtQcSM?=
 =?us-ascii?Q?2TCU0NSOqAuFdyRPF28ZsyboS3RWoRA=3D?=
X-Exchange-RoutingPolicyChecked: Cz0KfdnvW65mr4sdqD0xjb5TPn0tLcdNFphix+TdOMETGeCMW+Sq6C3kfYcXOtS9fDYdmO8pdBqYBHK2/gl9vFp4ERKRzyTpkQfdBWo78pVukwgqWUDs+ubLabipAIO8upSuhtIjV9uSwfJgrNcyex//3uNAqvy2hkYLOGWvFoIjKXOrQiqEnc2NzhJ1GBp2GW7rYA4ombzdtFunqfjmNgxbhzkZpgDJHvsfuhuR4K+TsqgKV8nnzoz4qtLYo4o4dGjBVTl1CYmyiX2eHW+bT8enbUIzH39s2/VJX9eExfyWsdnnrSBZHFPx5wT12gdr29PcuZ/d4jKonuMVg5UPHA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c20745cb-27d6-446c-07eb-08deab2d6636
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 05:07:41.1003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/3ZhKDkkjy/QTJXJ3Hmcjo2v3U4phC/pSece28UenOAObttdFu30HnCKOTitb3MCbkARD/StkSaqn7N+EgHzDRlSO2dfKxepMgdamDsGWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5787
X-OriginatorOrg: intel.com

On Wed, Apr 22, 2026 at 04:02:35PM -0700, Dave Jiang wrote:
> Add support to setup initialization of decoders in order to support
> type2 auto region.

LGTM
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  tools/testing/cxl/test/cxl.c | 71 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)

