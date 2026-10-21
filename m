Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792544973;
	b=TOW3lCP21Zms78Y8J6G6nYE58CR522P9oggnFpDtRF7VgntM5uHYY0EKwEUJ4Ap1hwxg
	 whnSgezuPDlX08ajepjc8eI5g+ctE1eyzVfyvR6gSD0w5dEL5/44SyfbQMCB182cMTTwz
	 ocyuOvn4UQhACPa+eXClCtrCCNdrnoM/+InOQ65eY7gT1E9gKmjWy6zaHjtWvAr+6BdmO
	 I6r6aiH05dcKqRdDt3zz7dTO1nhz89FIgFdQyFd9GNTLcFqv+s+N0y+C7xUEPtaeJbEX4
	 +IxG1OBkbuj731bsn1NrFXUpKE1vzl/PijXhSJpwpZBi2kwp0Wtq8sfrOkw3up4mqvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792544973;
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
	bh=k17mnWvM1MCzBOKgVCI6qFOlzhDnYMqWJTXnQnZlRlI=;
	b=OxJNeaUEaTG5VCQKK9BCpSRX/T/23J1b33QcuTRK8fZnW6Y0EzUjKj5gFuvh9h08XTdB
	 cTlRsmyMe/iwJNLORC3zaD3+PqCkc1ISVb+mdVJRLO2a/0ZtErQcbeoX9HcuPh5eREtn6
	 Puflpu8Ks1Su0P7CFaOXkU28Qr4euxEj9hgAa3OFcroqvatutt06lik44s9YMYr2XcwFq
	 grSziDxrEBeGLog/qHAy1dYyOC5pgIm2kz9JoiurAqOMPJ4p46z3HlYnBdX9HrrFuUjw2
	 XzOU9a8scLf6DwkqoR5JrlPTztP1U3EEzM6TmQpX8KtvvdqP/kPBBLLd4m+/VpmqrSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ISaSUutY;
	arc=fail smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D141606A319
	for <linux-cxl@vger.kernel.org>; Wed, 21 Oct 2026 01:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D141606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ISaSUutY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792544973; x=1824080973;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eNrlFp3sreyWnFixLBdOWRiisarjZrFotRgxE0aCBIk=;
  b=ISaSUutYJ5dr2IXFf0wGkzk5D94seOEG4YwXtXjzX4EPxPfvZQeZRbIP
   /FQTDwCprjOYe94r9N6poq21uzRtddDzJAarn2ja+hvNX1jqb2lMDuhtd
   F2LZ8Lqw7qJe2Vm3GnZgSvjhlKljjiYcaZNKlDcAVrC/Gu6zklv7o/IwO
   5EFTwadLiiFA60KGV+sqq0bb08qmfHFnH9rv2AbP+cjpq9XYw+rW+L1QW
   M1rtHBoCBKBKtVIo7otbBy7LFqfFbVfISgOtQIoMhEowibYjhp+EW02U+
   Ev92EV4wK3etxCUBFNe53wFJDJuGZSK2CbNaaGCePq+CKUhXGOawMcL19
   A==;
X-CSE-ConnectionGUID: y+hC276OTHmHL6AWdGpkoA==
X-CSE-MsgGUID: Y1V4LqhrRG6UVSjlFcgb6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1274834"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1274834"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 18:09:32 -0700
X-CSE-ConnectionGUID: x4hXq0U+SXCFOzs0jzd7Sw==
X-CSE-MsgGUID: CigX9dWjQN2EU7N/bXSyVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="4704377"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 18:09:31 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 18:09:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 18:09:31 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.19) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 18:09:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIHRmhB4IhKFFydmARF4jMgJIAYluHTA23le3QvALIdutdR+i3wIlSBj518cfSmJqSjm7TjXHorj9bSiHJ0FOdhpk0/sHHu/9IreKdzxg2fJSf+FPEj+TVwDrj57q+aMAo4Up7j+pIPCS8hmM3iUZx/err07tUtyN48AHnn2anJwoYW0H1eiylUO/a6gicrM+osIgj6LSNpWvYIsavXXP6xcSkLwW9XpTu56fxtZi5r/K96uPDfBYwMMbU098gKuaiJfw7JJ+zu4N3A3Qq618jVrFZVuSE1VWMPVUAYxSVatXHi0OMyeLK6lAl0XtRllzYOaX/qiZ+9iROT7zYyeOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k17mnWvM1MCzBOKgVCI6qFOlzhDnYMqWJTXnQnZlRlI=;
 b=v1gTK7V6bAmXA5TAUmUZRSAPbXkZsDUoy0L+Skmz/407ATgQMmnWQWMpholUVUoXf55sFHMUJ2OVfCe16Ec2lev5yOCoQG6uyNX/a9jO8/HiAUqcYqElvRLnaXgviL8kkH43XnPHNEgH//3aQVyQfjUrwDP0FtjVbuHzMpbbAgUpFeyf8xj7Wm5TWQn8NekTd3JWBYk/XYNoOytderUxyP282dnPxvP+lAuBEHdK+6IGKVPZKzDBCzK8raj24czuiS7akYypYoqT45fw4IZWaTv1dkOyxJEd9q463QB4EVXycMbnyWpz4sJ+nutdkw6C76rwMh3/BQzYQ0XmK8qPLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW4PR11MB6667.namprd11.prod.outlook.com (2603:10b6:303:1ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 01:09:22 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 01:09:22 +0000
Date: Tue, 20 Oct 2026 18:09:13 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Li
 Ming" <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/region: Reject a repeat write of an endpoint
 decoder to targetN
Message-ID: <atgQua-Li-wQzgrF@aschofie-mobl2.lan>
References: <94e9157aac2e99df1251d733769d539b914fdefc.1790829690.git.alison.schofield@intel.com>
 <20261020223920.6147db30@jic23-hlaptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261020223920.6147db30@jic23-hlaptop>
X-ClientProxiedBy: MW4PR04CA0180.namprd04.prod.outlook.com
 (2603:10b6:303:85::35) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW4PR11MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c534fe1-8b32-4afa-5d91-08df2f0ff09f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|10067099003|22082099003|3023799007|11063799006|5023799004|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: iQlb20Q2/znhBtODiepalH3oHYQbwn7M/243Yy/YaPo+RzjuhRDlbcsvq5U5uQ4eeXoMZFZjVk6KQJD3X74sCTeCb90lUNo1MeMNzTFkayGYKUwe5TAgYgHz4ZCwXAacKNqoLSWks0yrNwvGOHSDjgnhURO2W1A733yRnOCdLemXnNTSEADpUGdxZkSgFqDH1bB8pfTjpRFKQL6SdUILch1ePy3IA6HUpCFgivRhSZiJkHCbiCgjSXAmtFF1v9VZ6j33+Yyw0Fm+E90gZhMvOQLzUTcRxCDBfTPLnsasVbj4MgSMwOkUxvOt03DZPOWLnsRKW49ut8UhCoPPKM3ABkF0F1iYOafwWJG5puQbif64sFE0jpElmEiu67b+bPdTRg6DVmX3QP+4bW610hvES4326p1pZ/0S44+R/2FQ6dhTzyjMVl0gooNJkfyECDSitA6qw4Qj15E6AM42BQibsr2sfVM3N6w8/yuoCukNY7YhA5+fCCopN+vLGaBHameN+UTvCigNKHx8d9ijYy3g0OWc/ZIMiKGY2yD2K8vXk3wa4529yZAPKU96h6LVlUDgfu9MFr/pBVqBZPdEfkb/GazSvFWvcmKoDjugyYS0rAf8qqYGUYjkdyNxldxccTwekeEHlAJ49Bz4u25K/OejknthFVxvZzik9tFezeIBsMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(10067099003)(22082099003)(3023799007)(11063799006)(5023799004)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jnOSnmwkxOat2WBYiPfqcAKRq95gJP7fbLp2G9+Z5fHmDwVfPNIWG/DzhWCu?=
 =?us-ascii?Q?W7TKjKync6Oqh/CRJNYmuObrgf9MpHlpYKN+8qWVvM8gCykti4UQJB/6ERfx?=
 =?us-ascii?Q?eIpCaPJ/UqOCJOE8FNlmlxSPZp5tlZm/ofJRYIKKQM8hjzFVZMvlznqJqDmF?=
 =?us-ascii?Q?9WplvkUq2Dr3M+zHQTpXnVMfUJ9hkgcLKNyybowvhsYq8uWwi94QM9ETQWnr?=
 =?us-ascii?Q?WkObqpMxA4ORnN8eMU8petC2C0OZXXFPMADqaY0NBiN46rHyQ0fSvljJEIJY?=
 =?us-ascii?Q?kbxOYYtFFISEblek3+0PazwquCG7PTyTWLqu7dI3Ns/OzBnCuxULXRYgu56z?=
 =?us-ascii?Q?QY7f+Ymni68EytSeALweU00JoGkBdPjP7BAajyXZQWBdTm9mVz+y0iSDzXez?=
 =?us-ascii?Q?TiJRpZr/8Ak/mmTv4JjsHtNnFhi0lIk6/1kWmYw6Vrjx8PANjtYIIyrdf9Dj?=
 =?us-ascii?Q?z90ihM1lJqPkGRDGJ0aBSglVtLgS1CMAruMd0NQAZRm48icf9PElmsqyXXWY?=
 =?us-ascii?Q?6y10dfvJAAJTbRv2qLvXgD9aFoiVRIPKB6ribuS0pOEdppoLpZUtSAllEeER?=
 =?us-ascii?Q?97T49DjT7ORLN+/jXJTJwBT/9z+f/WtoWojIUByeC01eCSfES0V9bcNBUl4w?=
 =?us-ascii?Q?ionca1BqeYOyCkKOGUugQwn7lK9rnblHBSbWpixZRZHPLayTS9fR1AMm3C75?=
 =?us-ascii?Q?olt0kjdhq3a/SdO8Rhj8Z4JkleglsYBiqICEpTmW+2mdLP9Wz+mrTy6msJIi?=
 =?us-ascii?Q?sDTwpW18rKkOk767rwWpP3+C3+Uudi14iNLEgAQFWGQjrH3u7R6Bktnu+D4D?=
 =?us-ascii?Q?4MNoGOg9UgthuvGJHGTtVnRtp8tEXudjP8TkoB7XYi0zmR1xLadehM+xQiex?=
 =?us-ascii?Q?iTr0ueuKYvJfuzhpflieAImUlfTVOB0vlCsIGvNrPq2QJo+T4jy0Q+Bsnqrb?=
 =?us-ascii?Q?+ILO72rlojIE2IY/IzFYPJoUfNf0rkkJDdua37Z3EAc6QLJ5Gw8N27PdDOR1?=
 =?us-ascii?Q?QQQPauLNE9wT2ssuYkWrhUQaP420SZ43AVc6CmZxGC4o/i5vLRr9wc4tALyG?=
 =?us-ascii?Q?S4bu6j2BfcqDQuHzIuHPbsKy08kDJIbADqJ00a+pe5N+kN99c1+c2ivkA5H4?=
 =?us-ascii?Q?GMG++UdYvZ5CY1vVB3YKUnqE6I06ACIyAIyl6KefVAAWV2Pj3c11ccN2zzI/?=
 =?us-ascii?Q?7Mj0NztFROL9Ry0NMY9SdFgExul8Ojfrig2gcE+ju1FM5Ri98jsq8hGHZpDm?=
 =?us-ascii?Q?3DSqL+UXV+TE1DjtdZg4NfzXvgNWFB04JGGWw3+dMYTSsu86STYzEl0pbvpI?=
 =?us-ascii?Q?MA9ETHtuFKsREp8K7ez9PJAxW5NEDVGTiGhEpjjW5ILJBgkEka3sZG9F3p0u?=
 =?us-ascii?Q?y6jKz3mDU4wXqqtN+uTyFlUhGVo1NAZf6SZHYQtUYqRot08PNAjAmLAR95F8?=
 =?us-ascii?Q?fBCGtmFjpG13Gru5g/f4P2+gaFYFJeIxI2fUIA7r3qup/uWbY4ZDpRGQwZtg?=
 =?us-ascii?Q?mSgG08A27+9Ope9EG/QsDHeqEPeQQEB8VzkLeUt60yaoI3qVTMOVP2YHP7AV?=
 =?us-ascii?Q?wTppPdcHHzTK4sOkD+cCmbg+wQKYfhZ9e6cQyis5kg50Lyt/3SRuhWyKTgVi?=
 =?us-ascii?Q?Uf7Pq6ctGsKYp2454mVzEiRGX+RJZ4cU6xRM1c+fM5YmcgrIItxv8Ow+9kTY?=
 =?us-ascii?Q?KttoOib8jdbBa1B+DOnpxf2LI2w5eym6zelHkXmuiUH5Yec5XdolSmZDfGKy?=
 =?us-ascii?Q?0Gv5HWrkzd6WYnDlYFkWiZG5wHkDoHw=3D?=
X-Exchange-RoutingPolicyChecked: r82jxMlJfkmQMrHyQvNE3aVZwFdjREJbjifFBiYScLCHkcq8LlBBAB4JKCigW6LPxB1puoUXmA+vFuX+jTQAFO9Bc7Xbvix5Gg8kWZHj198uZV1VFY4ucI47AZxQjLAd6eJDbPspuCPcCc1L4iVec5ousOfN15+aqhCt85VKG1qhs0kvaLuauSgxEsl+tP6CowXr2ISWxiTGeVhV1B04QLQvYk168u1ZPiyeoDzFFwpU4Owj/kdxR5r0YVrAbNG4uyKJ1k5ZxskoDl1c4YlM0GgKKCRJ3FsdFzfQgFnJQWsD3wxEHN3t7c+4vpEjpo1lVbvCpXciFGtZZ8SSxmYfAg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c534fe1-8b32-4afa-5d91-08df2f0ff09f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 01:09:22.0863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WDMHioruAoIJaYR/KNGP5Qxlajp6cAS7X0gVP7/3e5CtaGfBAcSiroVfaj/zbSxnGvNCh52ir4WU//xs+UHfjb3JT5dPQuzcBW6caRkLho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6667
X-OriginatorOrg: intel.com

On Tue, Oct 20, 2026 at 10:39:20PM +0100, Jonathan Cameron wrote:
> On Wed, 30 Sep 2026 21:56:38 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > Writing an endpoint decoder to a region targetN attribute that already
> > holds it returns -EBUSY, but leaves the partially populated region in an
> > inconsistent state. The targetN attribute still names the decoder, so the
> > failed write gives no indication that the region was damaged.
> > 
> > Filling the remaining target positions can then trigger a NULL pointer
> > dereference in cxl_region_setup_targets(). Root can reproduce this
> > through sysfs:
> > 
> >   echo $decoder > /sys/bus/cxl/devices/region0/target0
> >   echo $decoder > /sys/bus/cxl/devices/region0/target0
> >   echo $other_decoder > /sys/bus/cxl/devices/region0/target1
> > 
> > Reject a write to an already assigned position before modifying the region.

Thanks for the review Jonathan,

> 
> Rejecting a write that does nothing with an error isn't the nicest of
> ABI choices - not to mention it's an ABI change (even if doesn't matter
> much here given previously it probably crashed :).

Agree. Rather than change the repeat write to return -EBUSY, in v2
I'll preserve ABI and return success...without modifying the region.
That is the key - don't modify the region!

> 
> Can we instead just reject much earlier before doing anything that
> needs tearing down?  Would moving the check to the top of
> cxl_region_attach() work?  There are some queries before that but
> I don't think any of them update state and I think we
> already have the stuff needed for a sanity check and early bail
> out at that point.

Almost. cxl_region_perf_data_calculate() updates the bandwidth before
the position checks, so the no-op check is going just before it.
Keeping it below the region state checks preserves existing behavior
for full or committed regions.

This revealed another issue that'll I'll come back around to in another
patch. That perf data is updated before attachment has succeeded, so
that is a problem on other failure paths. I don't think that fix
collides w this one, but I'll work both out before posting this v2.

BTW although the ABI won't change in v2, I do think it's useful to document
how to clear a targetN position. I'm leaving that in, you can comment
when you see it next.

> I'm too lazy to actually test that theory so may well have missed something!

My test is w cxl-test. Repeat writes return 0 without changing the
region and conflicting writes still return -EBUSY, and the region 
does complete and commit.

-- Alison

> 
> Thanks,
> 
> Jonathan
> 
> 
> 
> > 
> > Fixes: b9686e8c8e39 ("cxl/region: Enable the assignment of endpoint decoders to regions")
> > Assisted-by: LLM
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> > 
> > 
> > An ndctl patch backstopping this fix in the cxl unit tests will follow.
> > 
> > 
> > 
> >  drivers/cxl/core/region.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 27e63e6dab7c..f9aafe89e5bb 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1762,9 +1762,6 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
> >  		return -ENXIO;
> >  	}
> >  
> > -	if (p->targets[pos] == cxled)
> > -		return 0;
> > -
> >  	if (p->targets[pos]) {
> >  		struct cxl_endpoint_decoder *cxled_target = p->targets[pos];
> >  		struct cxl_memdev *cxlmd_target = cxled_to_memdev(cxled_target);
> > 
> > base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> 
