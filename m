Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794967432;
	b=XrVeIvfm8T4YkyiwaFA3e0RMs6M6/CDpUEvmPDaJVuzF9HNq1PNvNTCV8buSyZfi7z84
	 RhMo1qmD9Y3esdNThNGjwZe+jaMqd6P1KNb30Uf5IZE80gQy/lO28CEURKwcL5Ry0XmOc
	 JRTBTFi4L+0e493YIIeAL6HG6XWoZylU5oa0XeRL/mGjMBD2MqeOLamufysJz5Brvrkmk
	 FbwaKgp0yNEHg+wN6l1JRWNyoWiS4e6XitPVSJH726A2nV7mtlSIAgxTYRKa6zL20DzGl
	 CMba1kbKAl53TXKY+aS1YZSdnrkOUW+K4pSDUgtCQyK2lw0wi9kvQJCmx0tz8Mv5WBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967432;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=P1oX324XqXf3fR9FvTPIUbwlatW6Ny1Y5Pn97eMpcMc=;
	b=mxnJnGDhYTn6LG5qIUntB6dzt02yz4r4hCsM9l+/t3EZiXd38gp3ujYBWwZo0tTt8T2J
	 Tl5klHtxQ6UXPVZLxfEhMLvaQa91ra1sAu6VOqY1iwl5q7Gxu9vy9yo2EmFJLkwVmcjfm
	 TvSG7wBdrvLHgUQsDxOo5Ig7gcbVn/aAAQeT6JkwWzKWOuQxB2aKJVUw4prhB9kd+wVGs
	 8DSQKXAIVnlrCoCEOAFAkmZsic+C03ft2BzbxaB0lOb2fwNllkqgpQ5za47KKh7NmPJUI
	 tSPFVZ1Oy4HtTLVVA8zjqiTK9zmk5JmNW+jRSu6xZ9WciWYZAiyIT1pFnOgzP3UIlnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hp+azNTO;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=EQN7vOsi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C88606A31C;
	Wed, 18 Nov 2026 02:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4C88606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hp+azNTO;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=EQN7vOsi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794967431; x=1826503431;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=8Vx7zx402uicT7p3kiINtyjxTlsvKeNQPOTxSghCu88=;
  b=Hp+azNTOMcyCTUD8Zhl7NubWEZEbZgi183GyqqrHhdJYi6anZanns16Y
   BMjuAQJPF9AWRQvZgnv3hhl2CyHCGQINeFkeaK0v1MtbbOUfefPn3UTzU
   6YTaikVAFaAaiZBFUsSAD16PZryNb09man6ITltzMuuCdqTn2BcJhWGWu
   gRJDtfqRnB3/1gjVcO9T6gpxPL1cYXYcvo+BbujLIu4DXPU7SEiDq+tb1
   CsO3c1Ku2Fsr7VzSCFqaQE5386vPKB9M0kUP1QwQ6hgVYuhLPehaDHB1a
   VoSSTaXXwvI+rjfjC6z3lxIgfW04j50hMXGvzLu37Q59hMaUK1YmDP5p4
   Q==;
X-CSE-ConnectionGUID: UCiMAcpyRPiv+oJYTvUIeA==
X-CSE-MsgGUID: SrES1nEBQ9uO/4NwwmX28A==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3752827"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3752827"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 18:03:51 -0800
X-CSE-ConnectionGUID: rEfl8yGhT8KEldXARxLQag==
X-CSE-MsgGUID: vUc4rvHjRF2ZCrVVRlTrsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10341406"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 18:03:51 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 18:03:50 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 18:03:50 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 18:03:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEhAJBGRWPYyHTIYgIWfiX0uph1hZv5RWlYnGBwoS/xVhPQ49B11FYpDd/Wau91EuHwfPOkjXRWs2sT2VhjmkW5hm8pHzBJgVFUuPVFPxFsIejJUPnSMYbR5sMeIYKc9lPDnGaQfn5r2RsYRRemh14U0iZQ5tlmgaW2I+EwMT/nrXdGCY9i9QdgWutceYHTjg+wg2jlBt9T9OvwYde4q1Rzzr+6iFTUUDxboi4n3+Np3Zq3Mom2Y9vNKMPUVwY5CpRqpb21oc1fdKfhjzRXm1v8o7clCwmYjXT0aoq4yVzRanXF76B8dLAEygsY0YGtpHEsEsV6f1/Im/jFEQ6kqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1oX324XqXf3fR9FvTPIUbwlatW6Ny1Y5Pn97eMpcMc=;
 b=mOmnhnpNjzPA94txcAzvbV1H+csqhF05HxQICSQNCdtoTf8WEZsKY96UyTmRUktyNzCJBGbTVeLpHgYsTrBgArKbRY7wPRxQKSbbpFFP1VAmvCyEzV3OUHg0ktM4ZUiXKsdyD8DhAYAhu6h4k+CeEik13T7MIIIMM6yju0O9XonkOekqluIscz9DsQltHkNhBYCO53kpJSPmV6DfOt0kU5ydn5IvoGwZNCFvR0YkhtnKWxYn4pAYVeXDYmagOnbKtcN6dp0DOzuwMfVcAd6WHYUsDE6AFLgN7aRBH6P00p+lYKFkJk4mTGJt4Wm4aVCLMfL8XY2GDrpOmLLCAUH1ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1oX324XqXf3fR9FvTPIUbwlatW6Ny1Y5Pn97eMpcMc=;
 b=EQN7vOsiZfsv35yC/2rPMXDVlUC968jBPdfScE9XGiUp8DbUFFsgXBMGHYuh08cIFX+RT9GWhNJXdUgPGslMhNczn+ZTLqFp3tcNtGCNbpeVKT3tS9F848Y+rTGUTm/Mp9gvxEb7mOBbwF3MPGfnniN9EMq03u4P/t80phLAi+w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 02:03:48 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 02:03:48 +0000
Date: Tue, 17 Nov 2026 18:03:44 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Yili Zhang <zhangyili01@baidu.com>
CC: <jic23@kernel.org>, <benjamin.cheatham@amd.com>, <dave.jiang@intel.com>,
	<dave@stgolabs.net>, <djbw@kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shijujose2008@gmail.com>,
	<vishal.l.verma@intel.com>
Subject: Re: [PATCH v4] cxl/edac: Fail ECS threshold read for reserved
 encodings
Message-ID: <av0HgItCA71Oe46H@aschofie-mobl2.lan>
References: <20261029131013.85983-1-zhangyili01@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261029131013.85983-1-zhangyili01@baidu.com>
X-ClientProxiedBy: MW4PR04CA0295.namprd04.prod.outlook.com
 (2603:10b6:303:89::30) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA0PR11MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a8d6b44-6291-4df8-4d0f-08df45182edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|261009223027099003|3023799007|11063799006|56012099006|10067099003|261026121527099003|261021123027099003|261028144727099003|261026140227099003|261022105027099003|261021121427099003|261102123227099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: 2vWn6HW6AEGfPgfvFE/F5KMh/Ey26nAfwwWGYKdeDwOW77P82Blq68PXVL8ryMt4uRFIY47E35Nuuw6PBkgqdSgz4h561FrPAuOMefohJEjJHFloSkhNVe9zFat4lR/PQU57R+nyTP+BK9C4BZdlamyXYaGx/uf/C6Qjee85XeN8sMfuDuBdHAjzFRWG8iEhTswUegl2KlfDxneKggFb3+OSf5ezJN2thAlkMpYDev0PYG7tupFCJLuGkDq3oSacXDkWcXS2F1SklCTvuL6BwEs+o3oH29rQVukoEnzZK49UiF10TZdGCsss4U+aOfUw5g7gLFso8N6Uj4rnlBpwAlCUrb/84KY6o26kDUKfxNTDnb91YTcNx08ph4gPlnllYftqEolWpkx824m4w22Pf5yEkZ3Csza8RkFB3qE72zQsD5h9a0xdP4PT9PMRafC0RrJl1xngSrXvZVQrKo4d6NqYNsAVlYKIH1xq7SVSUq/ECb4Bn2x3v/uT4wpVbFpI2Ay3tEVh3eC+BX8C+akTlIb6Z7bAeXbPo5PeBk/GEHMl4AEIknmDI1lt7KTpoi/r8oPZ4YnFpZ8w+/dngxGDFRYKlw4ZN36104iWBjiCX/sUS9T4gLRAID2WlrY5JYBf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(10067099003)(261026121527099003)(261021123027099003)(261028144727099003)(261026140227099003)(261022105027099003)(261021121427099003)(261102123227099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1FCd3FRRDhKQldYblZHNjZiVk5RT2luU3dqOWlFWnN2dkFYbXRCV09ndkdV?=
 =?utf-8?B?V1lTSnY3czZablg4SFVhY015VWl6di9UNEs2eTZRL3RvTUxVNDM4Wmxzay9q?=
 =?utf-8?B?YjV2VCtWVUdSTHVtblFQVUwzSWZQWUgySzVPMmk1bmxVMWhmcTNVUHhibW4w?=
 =?utf-8?B?OFIyTnhnUGwyaGJwTEg5QXZ0YW1kMG9tQ09VN21yMUJRbkduNnExcFhFT0Fj?=
 =?utf-8?B?NUZUVnlxVFJrc0xGa2pPTG56VStIejdGc0pTR1dpdlM5WVNIa0RFZ3JZNGJJ?=
 =?utf-8?B?cU5YaHovY1dmRlZ3czdwOEExRlpuQWVrdGNkbWFETVFGRzV2eGZXYW9zWEtO?=
 =?utf-8?B?cThBWkt6UlNiMy9jVzBMcE5SaWQzWTVDdVdvSXVyVUJsMHdXNnFxSGRzNUlO?=
 =?utf-8?B?ZCsxWEVSNmtqM1FZc3d2RmU4dGdnbHd3K2VSNmhDM3dYTjRSSUpsc3g2bHE5?=
 =?utf-8?B?TFNzeDZSNTEwSnIxTlRiVzU1M2k2TCtlV1RaYnNlQW5IK2djbHN6STYvVDN4?=
 =?utf-8?B?ZldTdTFFWEpvZDhQajlkTHlpYlVMNEZIOWRoZ2lDTDdaUC9yZ2lOZzc2Z3hp?=
 =?utf-8?B?eDZsSjNNeDNXeXZRdkpiVi8rTjNFdWh3d2w5UXIrd1B6MXA1NnlTdnEwVXpV?=
 =?utf-8?B?eFRKanJ2c00vekFhYjdzU0tPVFFObktjWUJFZG1vZ3JWUld0T2VId3lYS1k3?=
 =?utf-8?B?OHpTRmh2a1RuY3F5TnhNL3RyRWYxaUFkTG4xL1dXT2ljMEx2Qk1RSGdDNEcw?=
 =?utf-8?B?QlJyS1kxOVZGYk1iZTNxanBpOUIxWEZmRVpZOFZSWCs0Sm5EQjdka0liWXc5?=
 =?utf-8?B?aFZ1c0dMajJLU0g0cXJ1cGc4am1XRkc5dHJBdWtzbW5xaTJmWTNWdmx5MjVE?=
 =?utf-8?B?M2hpd0JnNGZueWY0VGVreEZ4b2xlUmpsbTlLMkF2eHMyYTZ5bnQwQnZDaHpQ?=
 =?utf-8?B?R1JkcDlrV0lMNE96d0Y2UDkxTVdJc2FhM3BVaFpZbWp2SEo1bFA5TE1HTWF6?=
 =?utf-8?B?VUEvZEZZWlVPV29YS05qaVEzRk03UDYwMnAyTFl0N1hnM0xHM3JJekFwZmZJ?=
 =?utf-8?B?YjhRMHdTSms1NEcwVkorMk8zci9Ba2ZScEREcUJ0MVpJSGxZWkpyWEpURXdt?=
 =?utf-8?B?N2Z5eXpsaC8xTHVBQnlQZzBWMUpiOTBxRmQ1aU85TCtpV21kMmM5MEt1ZlBX?=
 =?utf-8?B?VUdmRHR3S2d0N2RRUGRPanlnUlZSMmg0NXh6a2Y0QXgwUXpJU2x0cGxRQlB4?=
 =?utf-8?B?NTduVzgvYVMrWjNKVVFBMTRzWm1hUXdPcHhBOUVTTGV6QzU0MzYvMm54S2hm?=
 =?utf-8?B?MFcvQ1Nld2Jsa2l6SkVTcUFONWM4SmlLelZobzUyb3NOblBmZ0M0bFVXVU5h?=
 =?utf-8?B?NkFKaU9DdC81bU42U21BbkhMUzMwa3psbTNuYmN1dTdCSmlRZytoNHhUKzhm?=
 =?utf-8?B?WHVYN3J4TUI3MEJFVDl4R3ZSNmUxK2N6d0l3OENwV0tIK2FlR0drczVGNVF5?=
 =?utf-8?B?TFBRNU1hbUZDWXNXdzJ6eWxaSFVoY3dOREN0U3U2VVpFMmJpVUs4TG1URHRY?=
 =?utf-8?B?ZnRELzJsV2FxajlTSDV2M2hiK01aaFJDVHU2SnlyNzBteUF6MHJDdVdCem0r?=
 =?utf-8?B?WXJTSU4zanVja0FJcWlLeFp1RmJxVGpJbmxoSFhKVnlTZEpwM2hpc3UxRFVt?=
 =?utf-8?B?Yk5KZzFiMXE1ZzltUGJLZHdrdE1EckNqcElFL3FueXlxTDc4aGJtOVU3eHdt?=
 =?utf-8?B?allyeTRNTmNQQk1ocjBGRTZ0WG41VzZBOWZ0aFUveUZDcFVwWDBFRU5MUytB?=
 =?utf-8?B?b1Q2MU03NllLaFJ6b2NnU1ZGenFmT0tXcHFOZTJmWmNnUjlFdEllR3NqYjkw?=
 =?utf-8?B?U3c5aGVPSktTTnl1YkM4NDhCd0FMNXYxOUdXZE9CQzd5RHY2Vjd0eW5OWDBk?=
 =?utf-8?B?TG9RUm96Ukhtc1l0bG5wYWtXVmFmRzV3OWw0ZVRldTRaWWpTRjNUaDB0WVkx?=
 =?utf-8?B?ZHZneUVtQTIxYVhDK1FzUnkxUkt3dUVQVEE3NFZ1SmRQdFZUeDdZMnB3Z0V2?=
 =?utf-8?B?WS8wcjRUcTN6U2hwVVhwRW42NHFGZm1qcVMvTkVKRFRyMmZKNFVnNWJPenND?=
 =?utf-8?B?dk84a2FPSU56UTFXaVNybTZ4S1JxSGRyQzRFRVA3Y3RVNFRvbE01VWNucWZu?=
 =?utf-8?B?YmhVcTlubS9OS3ZGc0FTU2VBak1yK0lwTzMzelpjSlhrOFBjMk8wM0Rselpv?=
 =?utf-8?B?SGYvNXI3YnE2c1pseTA4dDRUM1ZYOUZvb0lOaTVUQjRVVWJRUndxU2lJSFRO?=
 =?utf-8?B?ODZsV09uZk5HamYzT0thYW8vazFGUFVwSUlicnF6bFl1bFJ2V2xWclFmZElh?=
 =?utf-8?Q?ilba0cHuSx0E/Olk=3D?=
X-Exchange-RoutingPolicyChecked: ragm85oUIRbjLL6eCxxLEm+NX3rHHFoPnCKZTUuWGPq6wXaeSYLKpixgWwTnV85+EpcN8k02ypAp7vaD/lX0xf3cnenAX/dWfkfl4A4hKJzNET37TjQSbhcjfH/0RGcevRXloyayF+CbKlHFuN5HxMYWTL/mFMQioUpfBSAH7wZy6Jp+TGXBvhD8dQQGvcXjr+bw68f8y2S5ZbB84UlQl5Iq0ZctEyCLxHiMIugDipuVTeHa0LYU81RoZJV7fgfCt8gOk5EtjVFk1qWalYtb7KzhMEBhGsntvBdkHvrsgrRAJBXoybsHA0FqwyVZLgFC88uHCiHetcP2g5Uymrl3qA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8d6b44-6291-4df8-4d0f-08df45182edf
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 02:03:47.9704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIU+zR1BKOIxZ4mMGEnMmoaFqqsp9P2asjBvF2+PzzC5OAZaYCa+ayv433ayJU+oY3ztxq328SMbczjgT+6h8fKNM5DrMJ93WVdJnzPoma4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7187
X-OriginatorOrg: intel.com

On Thu, Oct 29, 2026 at 09:10:13PM +0800, Yili Zhang wrote:
> cxl_get_ecs_threshold() extracts a 3-bit index (0-7) from the
> device-supplied Error Check Scrub (ECS) config word and uses it to
> index ecs_supp_threshold[], which only has 6 elements. A device
> reporting index 6 or 7 causes an out-of-bounds read of adjacent
> .rodata, whose value is then returned to userspace via the EDAC
> 'threshold' sysfs attribute (small info leak and wrong reported
> threshold).

Thanks Yili. The code changes look good to me.

Please drop “adjacent .rodata” and “small info leak” from the first
paragraph. IIUC what sits beyond the array depends on how the compiler
and linker lay out the kernel. It’s enough to say that encodings 6 and 7
cause a read beyond the end of ecs_supp_threshold[] and that the driver
reports the resulting value through sysfs.

With that tidy'd up, you can add:

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> The threshold count field also has reserved encodings 0-2, which
> currently read as 0 from the sparse lookup table. That behavior is
> not intentional; it is just an artifact of the array's implicit
> zero-fill. The ABI documentation only lists 256, 1024 and 4096 as
> supported values, and the write side (cxl_set_ecs_threshold())
> rejects everything else, so a reserved encoding can only come from
> the device reporting it. Rather than documenting 0 as well, make the
> read fail for all reserved encodings and only ever report the
> documented values.
> 
> None of these encodings can be written through the sysfs write path,
> and no device is known to report them, so this is hardening against
> a device returning values not covered by the spec rather than a fix
> for known hardware.
> 
> Convert the cxl_get_ecs_*() helpers to return an int and write the
> attribute value through an output parameter (u32 * to match the
> macro), so that errors propagate through the shared
> CXL_ECS_GET_ATTR() macro to the sysfs read.
> 
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Signed-off-by: Yili Zhang <zhangyili01@baidu.com>
> ---
> v4: Spell out Error Check Scrub (ECS) on first use (Ben Cheatham)
> and drop the Suggested-by tag (Alison Schofield). The diff is
> unchanged, so the Reviewed-by is carried over from v3.
> 
> v3: Per review feedback, drop the Fixes tag and reword the
> description to make clear this is hardening against a device
> reporting values not covered by the spec rather than a fix
> (Jonathan Cameron).
> 
> v2: Per review feedback, fail the read with -EINVAL for all reserved
> encodings instead of returning 0, converting the cxl_get_ecs_*()
> getters to an int return with an output parameter so the error
> reaches the sysfs read (Alison Schofield).
> 
> v1: https://lore.kernel.org/all/20260928073553.85669-1-zhangyili01@baidu.com/
> v2: https://lore.kernel.org/all/20260930095627.32616-1-zhangyili01@baidu.com/
> v3: https://lore.kernel.org/all/20261021152053.85322-1-zhangyili01@baidu.com/
> 
>  drivers/cxl/core/edac.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index b321971fef58..fd6612dde7f1 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -624,21 +624,31 @@ static int cxl_mem_ecs_set_attrbs(struct device *dev,
>  			       0, NULL);
>  }
>  
> -static u8 cxl_get_ecs_log_entry_type(u8 log_cap, u16 config)
> +static int cxl_get_ecs_log_entry_type(u8 log_cap, u16 config, u32 *val)
>  {
> -	return FIELD_GET(CXL_ECS_LOG_ENTRY_TYPE_MASK, log_cap);
> +	*val = FIELD_GET(CXL_ECS_LOG_ENTRY_TYPE_MASK, log_cap);
> +
> +	return 0;
>  }
>  
> -static u16 cxl_get_ecs_threshold(u8 log_cap, u16 config)
> +static int cxl_get_ecs_threshold(u8 log_cap, u16 config, u32 *val)
>  {
>  	u8 index = FIELD_GET(CXL_ECS_THRESHOLD_COUNT_MASK, config);
>  
> -	return ecs_supp_threshold[index];
> +	if (index >= ARRAY_SIZE(ecs_supp_threshold) ||
> +	    !ecs_supp_threshold[index])
> +		return -EINVAL;
> +
> +	*val = ecs_supp_threshold[index];
> +
> +	return 0;
>  }
>  
> -static u8 cxl_get_ecs_count_mode(u8 log_cap, u16 config)
> +static int cxl_get_ecs_count_mode(u8 log_cap, u16 config, u32 *val)
>  {
> -	return FIELD_GET(CXL_ECS_COUNT_MODE_MASK, config);
> +	*val = FIELD_GET(CXL_ECS_COUNT_MODE_MASK, config);
> +
> +	return 0;
>  }
>  
>  #define CXL_ECS_GET_ATTR(attrb)						    \
> @@ -655,9 +665,7 @@ static u8 cxl_get_ecs_count_mode(u8 log_cap, u16 config)
>  		if (ret)						    \
>  			return ret;					    \
>  									    \
> -		*val = cxl_get_ecs_##attrb(log_cap, config);		    \
> -									    \
> -		return 0;						    \
> +		return cxl_get_ecs_##attrb(log_cap, config, val);	    \
>  	}
>  
>  CXL_ECS_GET_ATTR(log_entry_type)
> -- 
> 2.27.0
> 
