Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795227393;
	b=A6hFtL4ftloITcoyfhg9FnK4cayFni/PVC3I94Wguuuc4u0fWeNIUkp8LxgrxWIGPQ56
	 1J2E6zpQcyaal4gxcS6HcyAd8m7q2+F0fxHelSnEhRlsSQeeEDpowz+BgTPNDw5tsTxKB
	 baH3nxe4DIB/on+1x15HfcQav+w83JL4ZrV/FJAmxgsnQswTQZFqQrip9I+LyW4QbFTX/
	 5jOx9mKh/b667JYTzPN94XijMcJ787YAxLI59cmSBUyQX20eb9pk1vd3KhUqK0qb0Kjoj
	 VBRVEpDIK7Gohoz+2g0FTPh6tM/2KyzzlytiNerPue1PKigQRwxxC/15qj2jS7THzXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795227393;
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
	bh=u6mQc8VntlwQ9s8Kr2Qpk4SnvKm7/vIzNcAsDi3kSCE=;
	b=qv+oxhvQQHAjiCDi1T3IzxxGvpceoir8ryej3cWYcPb86E+mzxim/U//bPRl+lCL3t5H
	 GEAQ7m0miOd51pAxH2gAK8a8BS9PVFe10OC1UrKH8IA3p1fz6JdGsWJLg6X7JlVX63Alr
	 aYtSRqCfK2eRvR087F08+HUrZrbR7YGPuKb0qEbN0kjS2PkeEupF4MOfeybg6uFabyHUB
	 jRrPa79jJ6GX7e9T9yzsAbLoSA5F6mRoQPsbKXfiTpBfSaSz3OZ8puCg7xshJ2LKtXGWV
	 4zgKdxJluAH6fwv9r3gaTMDQe78J3A7z8tcTWCPqhHKRcocddyROQOWng3HCVvrMyEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VZo3BbNi;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="j/2slrkV";
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332A7606A686
	for <linux-cxl@vger.kernel.org>; Sat, 21 Nov 2026 02:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 332A7606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VZo3BbNi;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=j/2slrkV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795227385; x=1826763385;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AfuhPcWN7VnaKbZ+DtvwaseGvXsu40OVl2m1yOw9bTM=;
  b=VZo3BbNiaYssbl7mbjCWjva7LeOlQOFMElhfjXifPyA8sOY+z8q9qrU6
   mwMHVJ5PCYE+4cw2jeuPEPSaWrLt+/FGiiXrbNOlz8A7omaSyj6TB6FZ4
   xVqw9jiJoTeiA6PSrozGpS1JurwJ8FC4LOx3ipDV9U/s1/kYILGdlWVmL
   jr0c9NExfOjA6/T5+uxo7c6Dq/KMVZTIpDHs85OBXss8OSSMEEg5C/07r
   iclXYAg/CXSo9MBfw/kidyOjXPnEDx5DUxeJ68UueyMc6lvtFRWo4DsTF
   1Q8jQ/9IUeE8pyDR2IzFzpln5iwnvcyDZAPKZhAdaU+QaxpVBN6kDrm8O
   g==;
X-CSE-ConnectionGUID: bzXGadr9Tt6gdvkrNWP88A==
X-CSE-MsgGUID: 95D52f5nRcOaX8SH+Fq1qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4005193"
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="4005193"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 18:16:24 -0800
X-CSE-ConnectionGUID: VTk+XiBDQpO8MIKskmzYLQ==
X-CSE-MsgGUID: Vi8eQMmQQ/yHfHbnUmCZpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="10779239"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 18:16:24 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 18:16:24 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 18:16:24 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.23) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 18:16:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErpqxLw9ygTBbfxNIkZo0w+oRVL2vq53/MKn6iivxq+86/J/qNxIzMMILwsWN4cMw/+WTLDOWH3UMYTndklqHV4divajlzvi5CeQDHIFacV1CXBTCbk1FUBvU03TjjM0Z8m3i+qT7vID6xVMuSr7kEWE3z+fpuDkEqBwwgdOPUGBPIJ6fGhBmsPK2upjH0gayvWwzbsAvqrJdEq6GMQR2IVQFocO3QwLnHTKcnfwmEBlWWgX+mLPcaDKzRQqZ9xH4/LCQn0/9ZgrGza5dmN/lsz8N1rwLnwDivvM0Syn/Blmn0lf08vk9JooQyHrTQZO8QUyqciONz2Bz+1HP3IqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6mQc8VntlwQ9s8Kr2Qpk4SnvKm7/vIzNcAsDi3kSCE=;
 b=VV5tmu46MuG0h/cVqbV1LW1cqIvK8jBz7WtRfC5kny4fe8kB/uUZKL8K6wqIV8EzpIwtpRyXFBtkqxNGkKV6lRHq3fbUIUNFd2vxj7m1+Y3KbAp2mF5TS1HXxyrsLzmmns06fag3FKulJ3pwDu8rIFtyIgV/nsnPrhESeIvFYfuucWc/NGBHBl/Nsbso+AbAIaIcQyO3d0NjzsF0w3IBprzAg++aUYFAWRdB5GQmV5ZrocZqkLxDD9Qg+uyockMXDeQd4fOMJoSwFiNa6yKWTcZY48RlrGp6nYJxALdjdjrXvGHi/AFnLMhUp8qVb3kj4XCvy8gljg6mnV1la6SCZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6mQc8VntlwQ9s8Kr2Qpk4SnvKm7/vIzNcAsDi3kSCE=;
 b=j/2slrkVlX4moF5sryTDK+l9G0LQS5/6X4OGxKbpWzZSnu/KYxHtSBvxsb50WxV+7qZh4pnBKi2AxULYGsBvyfh/kmCd05YOX0gTg+W4yYnZaHec5BM4Q5c+oQIMTzAvmD+4empa02fIJ4pailcdClUJhy/AtaKcB/a+ww7z+Uc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA3PR11MB9349.namprd11.prod.outlook.com (2603:10b6:208:571::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Sat, 21 Nov
 2026 02:16:22 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 02:16:21 +0000
Date: Fri, 20 Nov 2026 18:16:18 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [ndctl PATCH 2/2] test/cxl-translate.sh: Wait for test
 completion before checking result
Message-ID: <awD-8ghA6C3bQ6PU@aschofie-mobl2.lan>
References: <20261120071415.29279-1-ming.li@zohomail.com>
 <20261120071415.29279-3-ming.li@zohomail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120071415.29279-3-ming.li@zohomail.com>
X-ClientProxiedBy: MW4PR03CA0328.namprd03.prod.outlook.com
 (2603:10b6:303:dd::33) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA3PR11MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f2699a-d21e-4349-8e4b-08df47756f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|22082099003|18002099003|261021121427099003|261021123027099003|261022105027099003|261028144727099003|261026140227099003|56012099006|10067099003|261102123227099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: Is8hjBWsrc747FWb9sxzRcwei34IxQzh7rdv2pNNz5qFyxgHNieAkitGxOy7RZWYMk2GIkFA7+KAMdfc3gV8HJPY2mya1xqD+qKV6jbcKXTgPVt9rJcaVHbPdo0LCi/WHdLTTOM3VxjjgpajRP2eKZBBeGktRMaVDBx+eKtINyvUW4Jl2tLiftGmQhk1O5w+I3LEvN++UEf2S5/aN7YyVoIVbmMKwNfmRxTb49FGspZDMyqVl2g6fffj+uuuGj3gG2B9ZCCp1Hoqs/7DwX5EgdNxEWdGjOriFwbV5X79qC7AUQstWLrf31UIOqFO7aolqtx2ink8huppkWN+qy1PRCmnBoi/7rzWtGbiaz+dpoUgoant0pMCQ8se0K5nTif+NvSSLv/i4A2h7Xj1i2RaG8Cq8ifzPVp58hwiyMXGLqMFolHVSDS9zyhc5nHPWgWBhoovftrBzUEquy1mSbGbi8pkt2TN6brSxRTGBYnXnUdT74XQMpccmQTZfsxCTTJ8B9mWBg4qtdtDEpNF24HqVcq207uNVJVEon8hhya5UHMAdJ7wMUZ1V/H2jrwaMS8RmfiObboGag7ZDc6f5+hXFdRbSa1wfZyt25bkMGorZSTgwuKYrG8G+KSCPLF2+2a24nXfzxt2a2c7UE4mgOvugKRCzkAF3Bo86f3q0Q8/PQM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(261021121427099003)(261021123027099003)(261022105027099003)(261028144727099003)(261026140227099003)(56012099006)(10067099003)(261102123227099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BOSL+1/sj7KTirFNRgTIscU/RwrSwtsL1/T3/KTPzlwqwrB/kogVcG3bOLvm?=
 =?us-ascii?Q?nMNDNlZs/zNX7GA85EfhVbpYKZ1A8sCKkvcxrwtq9GUtwvqzub8LJVMkwLVl?=
 =?us-ascii?Q?JWSccsEAlqHsFhz58CuvTCnf299vtTBuD1msvdHLcNMBtxlN1cZ4ZUKVMZZk?=
 =?us-ascii?Q?iMSE+TEZ7b1hgpCgjxGrmW+G/zbrm6LDrKXVFiRhzxtY13LOclMcgS6gsix6?=
 =?us-ascii?Q?hmH05fZDa0J94qJq9gC44RU7kZsrcy7C7piZZq3wgksLZFAPIeh20DluaIzD?=
 =?us-ascii?Q?TMwCiATSeVFTYA4eSREv5f8+cxZcd2nwOIQJ66B04BOzBNoIwHMPjfmHVFf+?=
 =?us-ascii?Q?z1uRPF/i7N0be4Ridt4oji4sFHMtz7jWGySBmH3mxnnC3SQwk/9TRLFFMB+O?=
 =?us-ascii?Q?fiAskdi6Dk0L0IRK293vP+zQ9FZT2orrJ85T6lw15rIN7R84Iz4+fI8Dp3Sk?=
 =?us-ascii?Q?AfjUMJWPeJJ2a+avXBk2KANxrjcC0DSRAGra2b29oiChjUJFpqIQ9WqnQig5?=
 =?us-ascii?Q?UIeOSD+FuurENlLs0XKUm/AyHMOoWRoyaygQYRFnO8aGgIyEmAvYZ9n8xq+j?=
 =?us-ascii?Q?jsKPhS3jgdiQjvIOz4iwA/1ngOhnvCvgoac84SZuSfd4oB1BES4R4tblE30F?=
 =?us-ascii?Q?YDWAEuGFnFDnyl8qgaYzgRNL32pbRlXzCJ7kmBydgV/m85KJiVU3TztwDK/z?=
 =?us-ascii?Q?jP9vssP8/ofma8pIIF9A5J/uWPAgFKaPpdvGwUAJoxJuQHZJP+c54irp04zJ?=
 =?us-ascii?Q?Y4mA44qOy0nTBntXtWujhls34uVd/944819LYg90nWLKUbG8BU6eswhB2vSF?=
 =?us-ascii?Q?jzBsHJbprNtWfowHmXWN45En7mfMikzyscWAqI9gI3TP5RG0r+oLQHWim1Bo?=
 =?us-ascii?Q?+EJ8FeB8XDGIODZioDPFZGCN7dvTrixE2N2JKpKExI62ZD+cT4n+alDzjKA7?=
 =?us-ascii?Q?AqpYpa1AiaobIcWIyBV6q+2NytxcZov+LLM7Fy0AaeFwm9kAY126rTUgH+bU?=
 =?us-ascii?Q?OzSZtTXMCkIik0H5eRaXqpEJ8tw1MAB+yQFwXetXKvUpHHlMMFEAVgepfByQ?=
 =?us-ascii?Q?ePKEUhg2+KQVncc1VuGxYj6qbPrwgh0tZeTAOaN5ycQearDjkb65Ua+HGWkv?=
 =?us-ascii?Q?54ofQ6DL855joAWeEsjFVV138g/cJBo/BrCh3MXTjVxNArZwpktM5+skC7/h?=
 =?us-ascii?Q?td2BJvlsyGpcHtvUylYilgCA1IICjaGhCf+lPEf7PjmPdY1sF7EuHRSL8nZp?=
 =?us-ascii?Q?ynhGnx+OqKoN3bhun4w9Csl1myqrZbSYsH9NWLlKPgVgSJeIKvPBM26upD/s?=
 =?us-ascii?Q?mUaV8IjZH/OM/VDfVOaYXl3+ITbxup+qhUbnlLoxuWLqseOS/o6eVO2v4b+Q?=
 =?us-ascii?Q?uSSbheieJqM0bsvsKPF6CUYGeG4LAW/GhhMHfEIc1wKoUE8iDDvvnoGcXXJ0?=
 =?us-ascii?Q?mD1nWucyToqTGUB1NM7Dn5L01aynPw8yDd0V3gcJ1MKXUdBXYWgkOTuDB3FM?=
 =?us-ascii?Q?6mWW6wmHKoQ9zWfwTdYOSjBKtQldlG3F+1ml4YAbP7TdyJ+HyRYhPPZRKA3A?=
 =?us-ascii?Q?zwRottTA4skvAAhwZZuphutr3m/voYo63ozFNkJO0if/3Pn0TsDBCm3BjSpe?=
 =?us-ascii?Q?oWKy2TDUdmRPZaF0bF5jfXfI6ypUXh922zamqL+mmHEKv8iwbdoCo3r+z/Ws?=
 =?us-ascii?Q?AtPXx0VzVkTXmNZMg+3coPoHf0Y8eGmXGJy5rys+Z3xtT/C6BhBBy6gjxwWT?=
 =?us-ascii?Q?E356wakh/QdbIcHZU0st1rF7dWHpdtc=3D?=
X-Exchange-RoutingPolicyChecked: ZuzI8oqhquoTmvzIv5kM3Ld7O83wIEHfzH9NYA5NwdsULGkA3a7SZgaCSmlY/oV+3tlsshNfLMKf2sR4vtYtl4HliNulMKeKSG25JmRPWgbt24dtEQLjkW3dcCVsD0GBtwlv83LtYaMlypJc4CWxUUBPaXuZZZwdpT+lL8fCydU0gHLMLC90bNE25kRAyMoaiPf7LicBY1OpNJPVSngacxzhy0MiQi9BFNhydlaYarLihVZtUDFBsCXxDudLHZe0+2fXoldvQs/Eh+Ml4pW/UcpV7EaLMgKnncDCLpAzVvJcI8JWWwoFxnwC216ehBnPL+4u6Z524eXksN7yAw840A==
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f2699a-d21e-4349-8e4b-08df47756f35
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 02:16:21.4311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPtA5woaLm1G2jxcx0hc70SfM818pGSB98kQzVR2wbeenXIE62uzlMoKCuwbi9pcyWBilPqgXNZgTw9eaQzeUcNsczzQPygkeNpzO4HLsws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9349
X-OriginatorOrg: intel.com

On Fri, Nov 20, 2026 at 03:14:15PM +0800, Li Ming wrote:
> The cxl-translate test emits multiple PASS/FAIL messages while the test
> is still running. Checking the results immediately after seeing a
> PASS/FAIL message may race with the remaining test execution and lead to
> incorrect result accounting.

Clarify that the test has finished when modprobe returns, but journalctl
can read the journal before journald has recorded all the results?

> 
> Use the "CXL translate test completed" message as the completion marker
> before collecting PASS/FAIL statistics, since it is printed only after
> all test cases have finished.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  test/cxl-translate.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/test/cxl-translate.sh b/test/cxl-translate.sh
> index 2fbc310..51d0676 100755
> --- a/test/cxl-translate.sh
> +++ b/test/cxl-translate.sh
> @@ -65,7 +65,7 @@ check_dmesg_results() {
>  	local expect_failures=${2:-false} # Optional param, builtin true|false
>  	local log nr_pass nr_fail
>  
> -	log=$(wait_for_expected_log "CXL Translate Test.*(PASS|FAIL)")
> +	log=$(wait_for_expected_log "CXL translate test completed")

Please fold this into patch 1 so the table tests wait for the completion
marker from the first commit that adds polling. Waiting for the first
PASS/FAIL line still leaves the count check racy.

-- Alison

>  
>  	nr_pass=$(echo "$log" | grep -c "CXL Translate Test.*PASS") || nr_pass=0
>  	nr_fail=$(echo "$log" | grep -c "CXL Translate Test.*FAIL") || nr_fail=0
> -- 
> 2.43.0
> 
