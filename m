Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793674472;
	b=ArlTCo1eVKZiRztjwlUjHvu9CdA/KP/lLwU4ssRualUTQ2xj8fRxiqZj895RP2EHCJ0Y
	 6cLSOj4Pqks1MLd+rOEpwoYd+5NElQ94aa2V220rxQbt2hB28X5RySwpTNZ6aqqepfKij
	 WVyzytiKLAEXPY/bG70MMyApYaBF21KJB8cJhVwA41hmeE2czO1+70Qy/yRmnfVsBHHEL
	 yjM6ZIf0d434qLqDtX3aUbjSeV1pJU7RZUPKL8qgac+8IJYCYIls/JnQ5Qk53rIdg78tp
	 ddzs3IVIsHIVoYXIy5ZlWgeBkAHJHdDG7VjE84AV/MfDzJQjQzwxsRhTFGhxa+5wzHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674472;
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
	bh=v+PLZMDRp9a+m7gii5DMUzvZvJG6JQijJzQb7x0rPNQ=;
	b=I5Ey2xZxRYj97APQsMRF5TAHB11d32lykY0FE5gCHkMAeeNVvOgZuNfN2hKmgmWxm79+
	 VuWOwm7yhW+PeLfQvUuu4YhJ0cIsangXt7PfsvW9mPSCM5Fu6uumaBL3FRIpGTZzderBN
	 dDVZbhpcHvjP4bG7QSly1NiqoDsT6Q7d9yPnn8zunoSpbO54WIoe6jfMZSm2JLOXRIECz
	 f6vsPBMM+TYKb4SuTIfbQse4kATzlp9I/LwPhtu6PS5dMPF4+U44UJ20jxDnXxiv4ylEo
	 pH6sjhR+cSNdnekDipsQN8/DLNxrI+YfSv4BmM32iISvJiSGSpXpGI0XRVXWLAzQePQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HloO56aW;
	arc=fail smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58327606A324
	for <linux-cxl@vger.kernel.org>; Tue,  3 Nov 2026 02:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58327606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HloO56aW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793674470; x=1825210470;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8G4Wg96BloXpteD9tEvJFoeflEomavQuAoTkq52+5hM=;
  b=HloO56aW52AES5Gt0gLM+78/csBJ7/CYfoizR+xOLkoKvcXvg5XFT9zd
   53RBlfzSyqKnHfwwQoI04T8TBy9gdB6Na8x/286XotAR3nDfnQFBc/Mdm
   Lu28QQMZgRPlXmsztVtYBdy20SvbR6gzA75tdOe2+i5PGgRB7pdEhAx9d
   IGHeqJIXvlPODVX9KZmtF5FDW/ymWEHtUuXtbi2DrW+bwd3pHqub4p8gB
   YMB8ixMTy6Ds95lf1WarGq1H3p9Gib/dVVcxkkLcHRJEsEd50SsZHKq2d
   clTGkgLzHbbWPN/odL/qDFCmfiyeVwx52pI1LrQrnGOmDIVPQKRIQGww4
   w==;
X-CSE-ConnectionGUID: NcXJjpddQk2fVGV2yTRHfw==
X-CSE-MsgGUID: T1CQTtv7Q1+p7h9JFsIkkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2416016"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2416016"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 18:54:29 -0800
X-CSE-ConnectionGUID: OSE84YG+QPOnte8W0kmIpg==
X-CSE-MsgGUID: lqhk9oL1S6SmOm5ScjylKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6631625"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 18:54:30 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 18:54:29 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 18:54:29 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.64) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 18:54:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knSPZ/GJ69STkPTMTfDp4BSrTdJREjKYViyWHRsaxvz/qxqkkVIt04Lvo11o76WwRSQQrGTCh4FJtW1UNaoY7HdrKl34UUay64AV+WIaGKawdo+p68F9DIVX4BdW0r/rGvZh7cmKT3Ex49FWR8H7b8oGjCC7KSqgPuRe4Uy7XzDxEJk3eOWLe6GuZilKP6wvMzZXlOJuBm1Li0ovsCpjPvnGPf3NSfJBuz6zuueSoC9OGdq7k6tkUZe2KRES3r1ncX/ZiWO81ixQLX6CyhljIxCd8K8R8LiGDLIK1eZVbaRDDiBrqLTKTdq0v5YcE3PgctDML1hC46KChcFR2Nvf2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+PLZMDRp9a+m7gii5DMUzvZvJG6JQijJzQb7x0rPNQ=;
 b=AelU/Y8HS2c3/UvMdpUlF0cQkfVAdalgtFBEa81nZUV3vlMJBTPFeO6aZhyLTfFwvcdkegZBuUnK10ifVRp1Jgl5hkUHkGGx/jFuGIy8dHGUvH26Gwnpe5Xbf5yX1R6H3qsSlUv5+8bCHquV0qF+5nmEA60OUN7V0cLEwdWD9Jk0Uob0trrb/e/nGsb0/qjsOfiuE6BW0yY5DZso8lKOdhX8Pbr9AjTCK2//fUqY2uG48L0IPhA9OK4qWE/rdNmmhyTFugO2XmSEXPHMmoRHpW/PJw6PPJqzy4cchTFQ/tv5seyvX5nTbAhw9JfLsaxKvc/BktUv+4KOXpk1KB0v1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM3PPFAB6A6CF3C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:54:25 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 02:54:24 +0000
Date: Mon, 2 Nov 2026 18:54:21 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jic23@kernel.org>, <icheng@nvidia.com>,
	<ming.li@zohomail.com>, <benjamin.cheatham@amd.com>,
	<linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v10 09/10] cxl/test: Add mock BI topology support
Message-ID: <aulM3e2nDaN7Q1q2@aschofie-mobl2.lan>
References: <cover.1793567979.git.dave@stgolabs.net>
 <3d78865a3f681c41951e0347c266105258cf1de8.1793567979.git.dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3d78865a3f681c41951e0347c266105258cf1de8.1793567979.git.dave@stgolabs.net>
X-ClientProxiedBy: MW4PR03CA0353.namprd03.prod.outlook.com
 (2603:10b6:303:dc::28) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 3d746b5c-5178-47f8-26b0-08df3955c4b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|18002099003|261102123227099003|22082099003|56012099006|11063799006|5023799004|4143699003|261022105027099003|261026121527099003|261026140227099003|261022075727099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: GDKZm4VuU6DOqodW0vY0PNPZHUlB0impTw4E+1+GxlK0OJ9Z+Yse28D2dniZ3BI31V36/kpA+RfwRELUf3YbKEWV8Q1UPDcef1zoMA9Io1/VxBdPnkfYGPFCbIDFRNtDp22Zn+2/LoqHYI+dgzE+AaHFeOJ9pfDSSzTP1MEl9sHBOB351zsoEjPH9nPMZIYyoJF+S8fm4CKsV8Y8hvCRyxo4MnGxC2obaitxBLQ4nF/SR8y7PoEWoA1/kJvvPEBD9BA/U9kCus6rwAo4iDQAPiBwo//dyLxZztaO1CQlWm5gMm5emX5vurbvh1VVXi+xdoIcMoqF+QoOpQMpU9I402ZpbEQUIF8cUNu5Cb9hgtuzvtaK9g7c5+DY1/s/ThauRRjrydnF13tYCd4K0Gb4A8k026JAiC4Cn113pd63UaptHdDL3Zi7BybKARmiPeStvpIeQY3N6leiv4x2oEhQyRZBbZQzkz+kZapE6ivhW8lgAcJHcsOyIUyXWJ2ZcecpdXObG/LakJYEOyfthm3A4bLcmvVfmUoNJiym0NY5A3QH0krNDmLOaEKOqIdQai4Aew/lSv4v1y4o/7hyk+8SBOr5lopa7FZWbmW1UHoPuy8Bviil8i8BI0ap5uIMmfUAr+o18z3jBm83TlHQOoH/dz92QvY9jbNYCuqNQNyZPLE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(18002099003)(261102123227099003)(22082099003)(56012099006)(11063799006)(5023799004)(4143699003)(261022105027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xX7lhSJ5EOP0RJYvQUJf17/3ODBiKuKoC9NqaJCErWOHDObvUICJmrSa+M4n?=
 =?us-ascii?Q?Id0+A9KlICnX78t31h98Cb9QP8gvVmfhUoyMdTmfL54X+4215OZ9VFPgpkmq?=
 =?us-ascii?Q?nCxm+jqLPEJ3VjEkBL5I4gsjMkBmymStsRpTMrJmFm+mhIEx9vxbh8S8m4p9?=
 =?us-ascii?Q?sZZoyeaSpHPwwbcKmPmX07qZEHsWKC0bpHPs+W7p7SOnESChTbpNYLED990p?=
 =?us-ascii?Q?NS/plD0HrUeTxo3Eq17uY5VNirL5RC9xXxH4hnx6n7A0EJBUICeFmKKMl+cz?=
 =?us-ascii?Q?QMVU42zBkBjZLLI1Bl5NlixFzNFL1Ho+drw2QCa57BubvkS75xjW2VgBdsEY?=
 =?us-ascii?Q?QkJH1UIZirmnb4SHGgjlqLgKnUghWQyrcyazw9EwrKrSZlbsnwfsbFHLFsug?=
 =?us-ascii?Q?E/gWwUy12S5T0GmkunPhX5D5JBJndYHtPLckGFynk5N58Psm6YB6RqDkvVlQ?=
 =?us-ascii?Q?mz2gszUiMvqM4d7hsL/RAKzCdu3g2ND3eedjAimqW5Sb0mSKlRTAq/pIrBDa?=
 =?us-ascii?Q?JJ4JZa4ykke+YECTEDJXmTf3cZdqzyHavcwKGwsZpgQBYuSKC7jFSdrx7X8L?=
 =?us-ascii?Q?0qMzJpj6wN+jMncqzMnvTwNoOACmvcF7NcFSs9qXTacl1I6NI5M/TAVApMcU?=
 =?us-ascii?Q?IoCp+9l7EW6/X2jeQfPtivE0QkZ9YLTAioq4RmJ2pjuDU/89EVJwLcBByubY?=
 =?us-ascii?Q?onYVGOCE1FXBy4zBtT11O7cJGcN/L0D46opAa2+ULIlWN1yeeF33k8SG57uB?=
 =?us-ascii?Q?BgmGYpFQd44LpLB3FuuwidRf2gy5x1ex5SzEkEtS3AEeOvA9rUcoaf2nlGzu?=
 =?us-ascii?Q?ZoSFsMEMts7F9qLy7ojZdj+KYk6+z2T5lz8NX064/tXSawcY0JA6RWoiNvKe?=
 =?us-ascii?Q?UB6hjjeRV1fU3cQDHarc5lwsEqN/Xg4DXHcdGq0ME1rF9PEUlMOkotNmBgvz?=
 =?us-ascii?Q?u7tvHaoh8WXHcAY1xqxxy3fzVoxA05ib8v+DqN0o2AvE2XH9Pty4JsQP3pXx?=
 =?us-ascii?Q?z/O7lZcf++QezMFcFcDI75lSsjm+qxdHWDsIWmU8p8pH6rONsjg76yGPykib?=
 =?us-ascii?Q?I3LqEp4a0wHHUmdGmms4Gp3MciidgV0tY4jay8AOrm0O49W6dZF0rih5TyEf?=
 =?us-ascii?Q?ntBVnl6WCJYWQ9uu9pzGtuZCSZqwuTR57EoiYS/UehhBNvTj1zuKPqZa8LYr?=
 =?us-ascii?Q?CnmD/8fAUsfqS4lR2FjV9oCaQRqBOPp/DZTeOhBZeRE/XOy66Ecy4tCEF3gv?=
 =?us-ascii?Q?JTnbNGUTsVy0bufhZyIgYC0PUa5hJwsT5xZxfucrf/ORuaQqhKQ5F9oObeP4?=
 =?us-ascii?Q?0DhFdY/SpmA3yoa8Bi+bjbMFqHPdDosDIm6tATtQrP06g1AyUwaW+fnuWYw1?=
 =?us-ascii?Q?bmYYjchX4SVcc6av8yS/BpQDHNI6Y6sVjwgr8eFW/ZIkwqy+j+GYsUuQVl9R?=
 =?us-ascii?Q?dah4UDn6idoAB5gS/R7NyaJio0JiFOC7Q3VEd9qoVvz71zZbGC0OmWfzqUV7?=
 =?us-ascii?Q?/wnCrE6GVnuKlqJhdQDqMWvH1xL8aHtXcLTUlCfMRCpKcer9xVssByLfpe8H?=
 =?us-ascii?Q?a/XoMtgQA3tAIai2F75AkItBcu5hM+MvzyM06KSGqhjD1uYjy3/QpddJMFDQ?=
 =?us-ascii?Q?YcZvmDAJBoRNsDsDjSQ9XYX3WusoIP70qf6v8dmzmi30NNUhmAgqelVQ5UMZ?=
 =?us-ascii?Q?p+QpJI0mtI4g+cAKgmBfz6RcdCPhlIFb4s9g7eMcbVUJYT+hFRLK9i1CvVGf?=
 =?us-ascii?Q?E+7VrpCH0P00sV/83SnyUuRjM1RRvyg=3D?=
X-Exchange-RoutingPolicyChecked: 0x4wYx+n19xC48kkp3A7cGfM2ZCNTXDr1I3nV90lGJv3tRXUCaL7YgdCDVrSdJAIF9DLfWw6mdFfwU0mIIUja9hrjJVQGFR0hdaIMh3btCfOHN0LMaiIbN1QvcNTkQeqT5W3e4ERpnXyDfcFcK6GfsAznThr2k4oDm+fC0FIPiFoJQNgrE05O5U1/I08QeY6mZvv7xpdpdC3oazWjfp0KCPgj2DTMMVeA77n6HoImTZawpIbuqTEUvjuELk39d6P5JRrV8W4Sba7JHGnvjfa7FoxEwc6F+jKxP1kt26p3Q6svXjTBJq+Mo6NPvmv7YEZwLm9+ZQmQ5AeE7c+Bcsmmg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d746b5c-5178-47f8-26b0-08df3955c4b3
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:54:24.8364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDkw92KfhF4e5jWYVnHAixAnA8iHJNpAGqgZko7X/b4gxakD9kcGcihRy1FJ6Y9FhTuKFQu2Oo87V0XVkyZKzw3KVcUFO8ROgAUspQy+gKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFAB6A6CF3C
X-OriginatorOrg: intel.com

On Sun, Nov 01, 2026 at 01:51:06PM -0800, Davidlohr Bueso wrote:
> Extend the mock topology with a Back-Invalidate path
> covering both the type3 memdevs and the type2 accelerator.
> 
> Following the framework's convention of substituting software state
> for register programming, cxl_bi_probe_capable() gains a --wrap shim
> dispatching through cxl_mock_ops, and the mock decoder setup enables
> BI in software in place of cxl_bi_setup(). The mock setup mirrors
> cxl_bi_enable_path()'s walk - dport nr_bi accounting up to the root,
> unwound by a devm action - and the capability check keeps the
> VH-only rule.
> 
> A single HDM-DB window (BI | DEVMEM | VOLATILE, targeting host
> bridge 0) is emitted in every topology mode and parses into a
> CXL_DECODER_F_BI root decoder; DEVMEM satisfies can_create_ram().
> In type2 mode it coexists with the accelerator's HDM-D window.
> 
> Committed BI state is a decoder flag, so the mock sets
> CXL_DECODER_F_BI on decoder commit and clears it on reset, and
> restores it on saved-decoder replay - letting a committed HDM-DB
> region survive a cxl_acpi rebind with no register to emulate.
> Endpoints get a page of plain memory standing in for BI Decoder
> Control, with BI Enable set, since committing an HDM-DB region reads
> it back. The accelerator grows to 1G of capacity so the boot-time
> auto region leaves DPA for a BI region.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

