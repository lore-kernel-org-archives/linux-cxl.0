Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792442674;
	b=rxn4s8gSKdtti1x+HncAD9NhFpCNhWnMKCM7jnnZbj2tPwIJ+4Dd0r1c363b4biGePtD
	 PiUXgcVKfEg94qgdHQbLhSgvCWkoFyiwu7Gupldt+ViEs3QBGzhV6dSqdzI+ZDj/UQRqH
	 M5VJNZdN6p7PE4mvJ8lDoERyj0s0VL3qJxmheRoHp/L3/PDCHF/FF4h3GpSJ0ftQtUUQX
	 lt2Mrk+Gsjm2VUAoMEybAj0MXYexGaSEP3vcyWf5vMifvFBs4KmjRJymLN+o40PPalVzT
	 GUt1EC8i+6ogHYJ3fD00jPvVonP+CiE7B6BeyJG+y7VBwe6R7BVXq5sehLr+50aKiOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442674;
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
	bh=bbqRi/BX0GcSc/QzeqxXorIxAtUeEvGv7kmzo19r8EM=;
	b=ItjhEO67i9rMdCu2m6a3k6W0t210ot8ugr1CXXdubkQLDGIcxMMzOQwRezsZre136DBf
	 zWP0Q5CpuHojEvt2lpaqak+O9jt4temrzaPG9lkiStXT4ylgpG9GdMGuHiXN3U+rUbRsY
	 DppCtc45WxwSDirk2JHnen+qUk3JZwEIvF3v0RVaQVlsIUz5J+0w/ZRmXJMy2rSsz88aD
	 vKtdb0+nP+81BOQUaXahgy4HtiEg8n4GHaU02Wp9bP6gjltWOvdPJJDU/L7ul8CiEuw70
	 qaoBoegvGNxwhlu5NOqs1CS6nhRm7Rx5m9vehHcuyrJmLQWrUk40KxbkAOv5vFvAyxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nqU4maMw;
	arc=fail smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9C8606A329
	for <linux-cxl@vger.kernel.org>; Mon, 19 Oct 2026 20:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D9C8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nqU4maMw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792442674; x=1823978674;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XzR4utifrHqdGU5cx26GDlp8trwRpXNPA3BKLRAmvKY=;
  b=nqU4maMwenfbTu0ytonz+Jk/ZGX1IV6fLgsl+TNY1oMs1B2Yy0dohDR7
   BnOVLbin+XcrOfd7N4BV83aCuSFssuLWddIxM6Dr3GYVi9rSq2V1armZi
   zoULwh5FeFQ7GxZ3ucCFmYJzIIW7piOFP4QcnEZjUknuC3Fzvo2rnbL1U
   jS18rxsrGwHxIYu1y/wY/Xaubq0eDhuoVsP8HZSV+ifm4JRxEatJ8Rb9Q
   0EUN/3qwMbf4swIGynLi+4nHhvHmWgTcB/DCXUibafjyj0kL5W92Z7M6/
   T3CYZq/MFsuKlO7vSgCSPmAGlM0gY3Ul8yQ/hagkxvezYa2TZ/aU8mmcj
   g==;
X-CSE-ConnectionGUID: crilCT2TQZevpHbkD44hQw==
X-CSE-MsgGUID: 8G0UXLgfTwWV8QFfN0w3uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1041224"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1041224"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 13:44:33 -0700
X-CSE-ConnectionGUID: uA/QZF8eSQSLFUcD4qZBmA==
X-CSE-MsgGUID: VrOfkoBlQdae9MgSyU8KqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2683570"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 13:44:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 13:44:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 13:44:32 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 13:44:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3XncYoXs9derJDrRwFuwcBUewx0hcZ7Cnd4Urs4p3D2ckN5xoiumTeLogJOXOx2RpNlT9ChjigjPTHqFqWMtUb7Wq8rXgRopN0U97nCcwvb0Z1oFbhXeFvJPYj2eXElj9Kc8HACAQdscHoC3rVzfO0nit46YwhW0ML1JCpqkttCCC6Oy3vpDI++LvjzzNZFVlOi+V42L5+zcIXrwLr7zyRXDWMnKb9bEu0URPkdu0DM6PtE9eWDBgEkXrLUuCM2+GBgCbEkiDt20DB2O/3eQIwx5TGuwwv8QnlrMF4kl0Dl8R8RPZcy13b37v5jo/7XmOqiJ/d8YXW11jK02mqbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbqRi/BX0GcSc/QzeqxXorIxAtUeEvGv7kmzo19r8EM=;
 b=x3Tbn2eHkoDa+vMtas5mrvDQq+aYI+j4+S1AWuOGhjp1wKaFlQC3lKBNQzi3w9Kxn11eeYDxhaKI6N40Z5T9oi4fb9pHebK1FvEcZNzNNOHKKT9ayVORPUgi+QLW0MPNRTfL2yPg4FMxYnaBRpPpQc+fFYppC/Z+nyRodHzmOTG9wZ+clzfGN26PaEnqGGzWNIaCrt6e6WYmrO6zr0PnZHEToII7DMpdfGw8gBAEDs3h2q6wLwnrzY3D+y6GFRNLDUK1xNYBtxUxYwEv0z0GkLPmBuDCLiEUlgKC6Ha6epvW29d+seXr4o2kdo4uNV3ba7mSt/Jhf6/Zoh0QnhtC2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Mon, 19 Oct
 2026 20:44:29 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 20:44:29 +0000
Date: Mon, 19 Oct 2026 13:44:26 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Li
 Ming" <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/4] Documentation/driver-api/cxl: Add a testing page
Message-ID: <ataBKpJ23GEKPaw1@aschofie-mobl2.lan>
References: <cover.1791949910.git.alison.schofield@intel.com>
 <7af9e1341a24928799d88adaa6144c1ca82091f7.1791949910.git.alison.schofield@intel.com>
 <20261016200132.421bc751@jic23-hlaptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261016200132.421bc751@jic23-hlaptop>
X-ClientProxiedBy: MW4PR04CA0094.namprd04.prod.outlook.com
 (2603:10b6:303:83::9) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY8PR11MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c8da367-3f91-4aa1-dee4-08df2e21c599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|6133799003|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: MDts0+lgfgvR3n37CmrvXmPuoIMq1qPud7+KfvCOrW1m1UV2DNxZHKApC0hVSwWZW33xceprbKAQbeSQGkh3H+nLy543cFhdd7HT3i8gAFg6g/lLenAewlx7mjEUltTeDzgX1qFQ98DfX8uL/pgr5TRxOu8bLiK8rECImhyduJ8ryzf/JX8Tn8ybb9Hr8mB6o9cpZVY/MZX42rOu3HI6j2vjKm/jPjyxylO62/fUrPXKDIBEK3alZPBaIr5BkYtBjJxNqrkNWFWJ7drs+XIMBnLhTtQIb0w+TaT9iLKooGNPL0h1gmVJM7DU1I23r++ghvfjdapIauPuhAHDzNg7t9fsUwobWSjBY7dIkyTfpJxRIoV9jKZBPJgYF8lmh+Ac87uzIbDzYnyZL9l4xjWBMqBOa2BtujpFuJImZBbBoCCnSt8/mDMAGw5iMqTGcMxL57ndonXeahrOxE76Rop85BR0bve4ikGXC06YSTgdVQE91L87fqK/nuW2TqzxuKUboJT2ghZ/mbH4FC1EgS8yMcWLhYpCgDXvfnrb/ZZgnJrkh/Ze9HIh/Pa74vOJsiIhaSPzFvA3FMqxYzKow4FIFJTWQl2okMy7XYK/RBmlHl6KIdncRSML8Z1sI+lTXMc/PDqqxqQ4dAocE+kukl3m/bl4sxl7/ow5jZHY0wv82ZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dtgyGd1wbZHPhJONMxRiD6JzPH1VH/kQlAvKntlttrhj9dK/17OvUjbpb1Xj?=
 =?us-ascii?Q?IG/ljPQoOvYzOvTcm3vAt/45JCHMlOD65yN00iqaBi2jc8TNWUxLxlyByVK+?=
 =?us-ascii?Q?MDAo81n+0yG9DNt6Q4adm0qmV8lhDqGLJ/Al/ti9F3Myj62shtTfjFvdZ8S6?=
 =?us-ascii?Q?rRCNBsSusDJOATjjyBlHkDLd/YQclD4uOQRstDmOCmdradOuephByE8VX5Gw?=
 =?us-ascii?Q?1Nj1Va112iT4ABksodL7qk+jR5+urxFUw+Dbld819IqfsBcyR2l0zhpOQHHe?=
 =?us-ascii?Q?bZlAa3PuaycxaVdfrnzFLfiavYj83qQ7a/Y/t7uBkH8YDMMsZARF05q1aZOq?=
 =?us-ascii?Q?NsIXhj+yqlranjMlHB4TzXrwhhyYrzyoUAegg4TxIZPPA7yGNKUBgNNorOux?=
 =?us-ascii?Q?mAwVszQKK6Bt9QCy6Q/vAmNMLEqH+oX8iNRYvmFaaBIFdFhi22H2aef7ctgF?=
 =?us-ascii?Q?esdbWCq9EPye2Hinuk/VFKKDp9oayWMvszNUN7ZqgBoHtRYbtEkTDLTUrDTL?=
 =?us-ascii?Q?QyU7OQSfD54GUWm1Q1Cn/pQsTNsbFVtNIYH8bdmQgQBE2LZfp9hgsKdMDaSW?=
 =?us-ascii?Q?dyjTeRLECLs+IgXFizFpppDS7rt0GDS0H0gFMY/wGfL8FsYUg7M0roX4wKfR?=
 =?us-ascii?Q?OxpANpIP07QcSMT0uRq4tjQxgEdty9nH18g0wr7P8jSs7sSEl1VDgHIGZoqv?=
 =?us-ascii?Q?9stgwsBqCczMHR6xfBKHFCdS0+tnX/khW5KQRKaYftKiUpqHUuec13BQ0VLP?=
 =?us-ascii?Q?pH8pyOpJUpluP0p60Ri4tHbnWQrteyKKd2JJo9d1+P6nTarFYrxB6l4/fHbI?=
 =?us-ascii?Q?SAtxlY9DyQCNylc5uLXS99oXi0NDiFqNZHzyVukKckhpb3/u9Ez1Dk0mOcby?=
 =?us-ascii?Q?hNCKHXo5ApegWH5VXmepJUrYYTHB3q4DHI5/wE1TXEUuVvuHEDKMViXzjiyN?=
 =?us-ascii?Q?BeEVJtCeYl4aJrR4mCW1Cx8CHrwuHf6mPw9N6FzOwlOMo8gG+agrWu2NpQUv?=
 =?us-ascii?Q?g5qd3zEZtUVcgelF3aZAqj9ya2ee/pBPRpEKw0mu85Hm+5/qHz/aV3l+G9Dm?=
 =?us-ascii?Q?aYQySqNfzsKSWkq2dsfolYmC5AktSHQWlVc9t7f1MR5/4lcuaoKop0UDdsf7?=
 =?us-ascii?Q?CN+2lNiDwqZFCeUCRstPGiU9pbB/MAMrSVNsh3e8e8yOPjf9TuuwVYMZl+De?=
 =?us-ascii?Q?znM4phS7nNvcUcgh+AUEoIJUCRqmMqBbE+XPghDUzjPAjGXVjs1LX2WqzjUx?=
 =?us-ascii?Q?gSi1aERmJ1J2E6/V7w4PcF4Y4BkpvGx7Rqh9B1JPsjp74uk9zzH0fkYFAEkV?=
 =?us-ascii?Q?m28HSNr/DZ1Pb+anCgXXQ+orDrt4aEyTuJ5K6UrP+JXhjK2o6cbzTfSNXn36?=
 =?us-ascii?Q?s8Ly8JE1lyRFzDJgD9fv8D2K2c1WbStDJy4WuHeWPTHsDvnqMqPv140P7Elo?=
 =?us-ascii?Q?cD+zCoi91HN18iQnq1ntrlCxFSZlU1OVwxhBjuBk7JkikheEXVk5ZUq9v67i?=
 =?us-ascii?Q?YxleMShi02Icr50Mwty5qpcGkXu3THJP5iS3S08dAWxE2InFD2fFm6MAM/ou?=
 =?us-ascii?Q?1EPzu5IvlR1jtKCQq2JM8WaFkySKT9gTb6gkEZ2LeATJbWKMa7L5vU4K8u7Z?=
 =?us-ascii?Q?5nYOnnnIPLWxidsCTaNT4ioJBNwYgax9H4krKde9G7QMujpVClNEpcMKtMI/?=
 =?us-ascii?Q?NeL3sqNS8Fum5VheGV4bLbG1xwV0ehsdqpnMz8sqjUwdtsB4KCLwsjxYjMlB?=
 =?us-ascii?Q?Tdz/w6tUcKJY9quWZgi1/oUH9y/pPAY=3D?=
X-Exchange-RoutingPolicyChecked: ENrScK9TUfBQx/c/I20xxTAL7JnXkE5Vv7hWfP8pNgegG22LfkDufswgBfojSDXtX51HOy68RYN+qwaOkrE6+YV0pwGJeFHf9E7wKzaHaT6HF0+E7VHkiCsRl9YsMbBQf6BtCerBX7b7AUMGl8SlU5pTzjlN5EAlIIVb9LVGoZxw6zUMJ1VB21nojVU5F5J84lJhi6fXQaopye13oEEBgK2X96YUxBLVHm7QSXYRnBVvmOHu5kDWo7NqGOv9K/1/+13Y6YPNRfwGrhfxygMGWhWrthPib08Fjk0+2pFBgqkmsJaPNKs8GK7dM2dNiJdrDplgeZN82WsCT9x7zLj67Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8da367-3f91-4aa1-dee4-08df2e21c599
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 20:44:29.5762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAHDjsYPH//NDnEdXT0n/p27om00jj78yJG08+58EqPCqRPyiMpehFQyafVSbWwDPDWMm23B23udyUjlQxn92MZuWkvUoPO8WTx9nyuy7js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7012
X-OriginatorOrg: intel.com

On Fri, Oct 16, 2026 at 08:01:32PM +0100, Jonathan Cameron wrote:
> On Tue, 13 Oct 2026 21:17:52 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > The CXL documentation does not describe the subsystem's testing
> > infrastructure or provide guidance on choosing between cxl_test
> > and KUnit.
> > 
> > Add a testing page that describes when to use each framework, how
> > to run the tests, and how to add a CXL KUnit test.
> > 
> > Suggested-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> > +- If the code under test depends on another configuration option, such as
> > +  CONFIG_CXL_REGION, make the test build conditional on that option in tests/Makefile
> 
> Because we all love the trivial.  Line is a tiny bit long and I don't think it would
> hurt readability much to keep to 80 chars in here.

Thanks for the review Jonathan and I've wrapped this and the following
long 'needed' in v2.

-- Alison

> 
> > +  and enable it in drivers/cxl/.kunitconfig.
> > +
> > +- Use exported interfaces where possible, importing the CXL symbol namespace as needed.
> 
> As above. Few chars long.  Check the rest.
> 
> > +
> > +When to add a test
> > +==================
> > +
> > +New or modified self-contained logic should be accompanied by KUnit coverage where
> > +practical. Extend an existing suite when possible, or introduce a new one for
> > +functionality that is not yet covered.
> > +
> > +Bug fixes should include regression coverage that reproduces the problem without
> > +the fix.
> > +
> > +Changes to topology-dependent behavior should be covered by cxl_test tests in ndctl.
> > +KUnit coverage complements, but does not replace, cxl_test.
> 
