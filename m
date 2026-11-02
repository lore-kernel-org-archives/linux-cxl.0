Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793661558;
	b=u2Hv01CgFnCO4f/n7kN6ZAnE+ujnOB9tMhf4ozk1pUmT4deBvkXneQDIaWMWEXwLmZJT
	 ttUpNn3l5wXhL5MBy/084X7amHCV4nRpYlucxYFcN4vYWCbHkG0jIptjMnXxiCqBA6Vbl
	 bpq1HslCdX4kmy8LtSmrdE3KT9sRoBIauIRUva+o5O3ETphvv+SZaDEaiTy/x5pz+UEmB
	 rSf9gmNLB2UKJzakgKUKDZvedOVD1VB5CDH3PwRQEE7C3pezPKQkmi3J/M3V6OcnNtE16
	 4CfeElDtAJgBXzRWv5sbop2ZGzyfGWG2d5NEoOc5r7ZKndV8Oe8MdzwZrsJFovNo83g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661558;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=smkV+0Vl5D6ra8aSkNnh3PmZWk2TvCOwgCTYezGFZVE=;
	b=jBrGiQiX+vtcddNJAXBFOVgVFBE1r/PX4oU+KMaaj9AMmW083D8STxayP532oczhE62l
	 MIAiWWbS7W5QCLJ46bXSs1rYXpjEDTXc26k7vApO6zQ2OOVbQFtukpopeJoR7NiJaxwPN
	 O/l2Lw0yizbRMlZn0HwJN60qMac8ZRdAVOndLQnxUIRxOj0pii6nL6AavWKd2pAuZwuGh
	 2ZUcN+MrTnF2qrrcru3hAI0I2bLFzlXGL+Kr/g8762Kb3KNtFxIKWKLp9ZNf7EFLBA7Hy
	 OYE1OXZPRikLwJglslxpF/EDLvh24tdpLsihek9rFUjDpjGHAYuaWTKZgUcm1Ekh/Ow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kE0wqQNr;
	arc=fail smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0FC606A324
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 23:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A0FC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kE0wqQNr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793661558; x=1825197558;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=fyOYnTjqln4Hf0MclQsDTnHibhI981LU63dQOf+8+5I=;
  b=kE0wqQNrppvELOeKx3qkjtaokhqZeNYJu5mDJcMItBaZ0m/yVXK/iLXl
   sTMJ9jC9uOx6JYClGx6uD8qCILxALVV/7eTo6fO7mk/S8IbOYj7TfL4mX
   u7H7bIILp4Stg0Xl/P94DrfEeHl5ZNbiFZtqZcFA12AKMwYqXC60UNdZn
   LYTXXrt8NvR/zcjRnZf0PhBpdlZvY8uxsNSvXwe0BVA4U4L/Qz/JCJnPo
   tLM1eKom+FsZ7BK6znYQX8KSSogWtcIrqvX+E/vg30hR8kFB4pmvfLA+g
   z6OtUcsH1J6YD1cTRBnu4E9XkJe1/hVuNOx5eZXW38uAtwgUbrV6c/R9e
   Q==;
X-CSE-ConnectionGUID: Zjlcx2ZVSxe343Wj/9XfMw==
X-CSE-MsgGUID: d4jCDhQJQiaBQ2qfyEalhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2384362"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2384362"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 15:19:17 -0800
X-CSE-ConnectionGUID: xY1IZdC0R3u/oaIPf1UxhQ==
X-CSE-MsgGUID: aGYSYXp3SKymEbD2uF7Z3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6108772"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 15:19:16 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 15:19:13 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 15:19:13 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 15:19:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCIBlyURRi4m/dMS4BvUU62mDta1DslDPi6ja/yQYo6GfQ8DIUd2+6RAoigqNRkOMua2Xsop7ThtMPWnMzAVwu2Agl8qdowGtuDT1YfRu2iGuqxbVE3TNuQP+rfdwXRJgLuk+0Xezn5nU1faD1/TB7qrbs6qFfrAJ9sTI355VW2VeHjER94p4+tGJ/ox5RF5zgoQkgXOBWIq/eCYxSgDY9PyRFfz9QWwPVqCUrJigeEUpdmGzIIlj4nCDH2KSl/vZ2cwtp3VGUQ9sfYA2+X4UNDqwbwdV842dgB8ZazH97HPMvhgWWO4dYNAMSkNPaSOYR8xzE82gViP3ZItYZF1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mR+XroSUQ1iszhLdXY70HU05C0v4uScLaGSDMzB2mXA=;
 b=lbYdlEASylaBttoID/WzbZYsTFbP/MNV3nCgmoqd1x74GEl767zSeMOR2FK6tmHuKm5Lmoj/J780tVDNpVCKhEIfAMxuJPJLLWlD8lNJFWAsPgbeVwgoDs5mo7HwMlDCoKcjn6hB/KN/mtu2Ao2MDaThGnpWNKO+WuKUaTGozU/4kCS/C++a7RBCM2/kYgaxuXUXd1ahs8xDWDIP+ALIehHkKGzwXX90WjVRTnfGkE6UHMam5xzSv6iSOR6CEyLKH6inwvzRnWP6qGo1w+1Eo7uCy4PJDk1zR9EsNokCWDT+TtRqvRX2FNlPD70nQokeF4YS4AXBpp6yivz/IbVisg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB6805.namprd11.prod.outlook.com (2603:10b6:806:24c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 23:18:08 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 23:18:08 +0000
Date: Mon, 2 Nov 2026 15:18:04 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] cxl/region: Reject a repeat write of an endpoint
 decoder to targetN
Message-ID: <aukaLAMiCHn0xX4S@aschofie-mobl2.lan>
References: <3e5af9d6d59f8df52b9d21bcf1c7e78f06918f80.1793653629.git.alison.schofield@intel.com>
 <sashiko-outbox-194200@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-194200@kernel.org>
X-ClientProxiedBy: MW4PR04CA0366.namprd04.prod.outlook.com
 (2603:10b6:303:81::11) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ef70a5-af52-4c59-c382-08df39378dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|18002099003|22082099003|56012099006|4143699003|11063799006|261022105027099003|261026121527099003|261022075727099003|261026140227099003|261009223027099003|261028144727099003|260925021311599003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: oiiKJsPg1VCvMK8J6TvEHi6Qcl87lp+bUQ6Q/jlIqNOX4IuxP59boZnadr1jfTQ2d2z+hj05y6aUzhqSSJBrOWHfB9o2TsRLb89LQMZxYFiMmcmmkWiF8OaMvQAG67SBPhmrxXbeuFuaSAnmPY8AbCENL6hikbU4eXmjFEzhbLh+dYHJt+QOxHX6BTUmNcaNIj0uS8hsH5QfLiLPptBqNQ2pAv0qMKHCXFnoUIrw5hZqIa9EWwkWUgGl9dzl53+DpjNQnRcXqPC8pea0bSd6vb/7MlW3yGb1FNIL3b/WL669J7UA/xSpZ+k3moiAGBO4K6HD+vyUBo3lQ+DXSw8Eu+QK0wejV9yGa6sCLZ4bGunGtT1nchHSBbnzom3vaVrrLBIcfmjkebC0bqsTD4CigOhW/Mf/IAy0i8Rp34O4WA4MnqXqgZX04Gr/2U9CEzukUgp5KZr5cv7brlMvYXKSF50a8g6FoA7/mwrYEtS8Yjs4cwb2pOjY/QL6EHTLyIho3oaTvckWtLHtBHUM0bPQQ2uubeCVuK3fMVEPZjP+Y3VGm51mzc11V5bz1IS6vOt8EDWNCoeVEG47cvnPu1oBppSvMu7AV4bnUp8Xeg3aYlw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(261022105027099003)(261026121527099003)(261022075727099003)(261026140227099003)(261009223027099003)(261028144727099003)(260925021311599003)(260925022911599003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zr0lxgxNQ9ivYt5dy7GYzlonxDiR7c41RtZbgXbNQmMttyHFz+ImuO3e6K?=
 =?iso-8859-1?Q?BnLDC3Sh3N1dmnEAUik1/B7VKLCrEwV695Y+hBn+OT+OLnMZyTj6KNbFrY?=
 =?iso-8859-1?Q?WxooFquv6ulhxn6v4ktXLy58PgZY7MifHTz7SNojyOCdr4If10MSy12KJh?=
 =?iso-8859-1?Q?p7bdHJRW8Y0p5en1frWg7uzprqzKW3/pPT3vBFr83CKR+TGgFbs8usZlOB?=
 =?iso-8859-1?Q?zN27rb8xk9nNsj4GLQIfDBYjyoweljUG1VCF/w8GFIhdfYhZ29nrZuTaMz?=
 =?iso-8859-1?Q?nX/zbU3yj00g1QFZjlqsszi76mVbPb4bsq9Avx/NY/votNDveHlSMHYu2P?=
 =?iso-8859-1?Q?pPdQikvPA8t5AMNM9fXIDc3A6Uk+8THjggHFFq0m36X6YPQLbtBHlJ9S/G?=
 =?iso-8859-1?Q?0brjBrHFJlONjD1WnW2DBzZ+y1oxX6RDee/smUrLiC3RedgDfQ8sLDyEAQ?=
 =?iso-8859-1?Q?06qzebRRu8Gd84/kJFOr0Dft9mIqrRWurrAngxBBnVRo92A7CsmT/ssIPA?=
 =?iso-8859-1?Q?LCl+A0fnl7F9sTZ6dI07CXuv69CgSUTsytELx2yxh5sJ22JCxb8XC1AXQG?=
 =?iso-8859-1?Q?gMlzAv+m2J5ItfRdU2A+/Ss93JYciUWoWI8lru4GUFTP14N2lcY1v29fxy?=
 =?iso-8859-1?Q?d44b5NNJdvtdf63O2GQc7BWkDICXNiqVta43/PhAuBhyyCr3d8H0MA8G1Y?=
 =?iso-8859-1?Q?GAJ30Eeeo1kdWGPRY7HQrLGkLl7fh5pjDrsJYbX/oYP5U1MsxibxvFpxlv?=
 =?iso-8859-1?Q?BMjueFSOvIIuVuGjTDLEJYMQeQ16+gkH9lO3TJ3vVzwnO+YUtN1Y+EJLYk?=
 =?iso-8859-1?Q?PhJ7VT60HOsdMyMIScAYalBZ5dJWzwoqUm7tVDQnzdMSRud5dztvsoX5AK?=
 =?iso-8859-1?Q?QwpbUP0Lqj0L5PTg0cDtGXm04HkEgcyvzUUWGYvRMwQMIwVmUla7gZ1xFm?=
 =?iso-8859-1?Q?oNAGgwHmbaeI+VEYq8SfQJOP8tOstcV1rmbEWW+p37oCvjUDRdPQkIpBaH?=
 =?iso-8859-1?Q?wUt4cSbFLzJWKcZUTMX+/Kzem+hlDrd6Yml2b1pSSeZldv6FioMnwzl8IR?=
 =?iso-8859-1?Q?lRb1selZsZ2TxHjP6mJ/nJi6KpkytS7NTnAaufATGkuiyRLiO9Jt9+CxOq?=
 =?iso-8859-1?Q?pZBlNkTyRMgBENxEPbH7KkB5n57iuUaBlzRDO7QLBA4a2mVUHdM9YSVrM0?=
 =?iso-8859-1?Q?ffVoIVjv/ph6l3pRyzGOtX/9lpHpRFU1GpI0o8/QhoK3mN/8bATBhwACaB?=
 =?iso-8859-1?Q?wks7dTJyTSfuN5hqTj/f2Racd6Rgtpd9J6pd4riU8yZ0zw/UGQjVT/4E3K?=
 =?iso-8859-1?Q?SRioCWNtUNWhmAXATBwTAvW+3GygVMZSDjFKyzALMyqmxQDApYALIhOIii?=
 =?iso-8859-1?Q?3eS3lTQjrWgQV8LEUS2fE8cBlZz2fJSUcvDTEl/RnawAkjPc+CBOUXnLY4?=
 =?iso-8859-1?Q?ZGITBaUgQOKyqL43Jmp2GgHU3gbu0py4hL4B0mFGuiU7BvpzS7JcRB/jJb?=
 =?iso-8859-1?Q?Q8LfHgLhIe9Q9cUBwr6DRpJWWz8K+36eXMYq4rF8zh0QJIWtihN8XIrBi0?=
 =?iso-8859-1?Q?EYsODtxyOfrwNP5elGdI1eEMvCPuucDEjo/X3owjodyz2+6p2F9LLbNxG6?=
 =?iso-8859-1?Q?iegQbeDLC7Eg0R6FtshsdVNa0e+e0UyGzHatQfGqQH6fy+scgZMG+oh8ab?=
 =?iso-8859-1?Q?PG4ipC+j1cdbm/qKo/HMVlJh4ei2BxzWWmz9fQsNXXiRhvMPnJZqIJu3rf?=
 =?iso-8859-1?Q?qwb+pkJfA64Bm6igEHJO0r8o/DSS4UszdH+CSYw/ZpFKlciUucQljpk5VZ?=
 =?iso-8859-1?Q?dpW31pjgAcRH2lKVMU4v01+IzZBiUx4=3D?=
X-Exchange-RoutingPolicyChecked: s/81JjEYTPdNKxqmqRPk1cAWR2an6JwpKaKlMXugy27mGpwVM7HATccR9IVlfM0S3MPmZt7oM0JiNz3ZAJJr1EiLLzF29ohexGY10X808Ghpl5BieLxLVuB/If0ewIOq/S9pL5ZF/BF6GoAaQIqbOh5XnH6sWqtvwfC7XCbYiHwXSU0b8broxVPPWOttZbNXuXrA9iqYUVwQDPRWZ+kA99ixnZwEnKSAPfZGBrAvtem1/46IbqmSBWgbQYt4UDAWczFESAEvpvugIuAY1Xlq/kBsYSuDY0mi2IOc1sVpKRmXeTC2bJlB0tdsLyOhzRDkOzkouBiKuaxx6KvbriKEqw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ef70a5-af52-4c59-c382-08df39378dba
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 23:18:07.9105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/AKPBfUKxbim6h+w67sKgiaSbl/TKXECbGVSwXCS0l20AyG+ULmBd0DeyR/eFfy+8SzG2/f4qPDe7RsYCA/Z7x2I98k5RaWpB6eReYu9EE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6805
X-OriginatorOrg: intel.com

On Mon, Nov 02, 2026 at 09:30:31PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] cxl/region: duplicate occupied-position check in cxl_region_attach()
> --
> 
> commit 8e6a6e0273b1dca525bf14e3930192ed09907f10
> Author: Alison Schofield <alison.schofield@intel.com>
> 
> cxl/region: Reject a repeat write of an endpoint decoder to targetN
> 
> This commit rejects repeat writes of an already-assigned endpoint decoder to
> a CXL region targetN sysfs attribute with -EBUSY before modifying region
> state.
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index a048bd5c06cb6..90226327e03c8 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1764,9 +1764,6 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
> >  		return -ENXIO;
> >  	}
> >  
> > -	if (p->targets[pos] == cxled)
> > -		return 0;
> > -
> >  	if (p->targets[pos]) {
> >  		struct cxl_endpoint_decoder *cxled_target = p->targets[pos];
> >  		struct cxl_memdev *cxlmd_target = cxled_to_memdev(cxled_target);
> > @@ -2130,6 +2127,14 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >  		return -EINVAL;
> >  	}
> >  
> > +	/* Already at @pos: fail before changing any region state */
> > +	if (pos >= 0 && pos < p->interleave_ways && p->targets[pos] == cxled) {
> > +		dev_dbg(&cxlr->dev, "position %d already assigned to %s:%s\n",
> > +			pos, dev_name(&cxlmd->dev),
> > +			dev_name(&cxled->cxld.dev));
> > +		return -EBUSY;
> > +	}
> 
> [Severity: Low]
> This isn't a bug, but once the early return for p->targets[pos] == cxled is
> removed from cxl_region_validate_position() in drivers/cxl/core/region.c,
> doesn't the immediately following block in cxl_region_validate_position()
> already handle this case with the same dev_dbg() message and -EBUSY return?

v4 will drop the needless check in cxl_region_attach().


> 
> drivers/cxl/core/region.c:cxl_region_validate_position() {
> 	if (pos < 0 || pos >= p->interleave_ways) {
> 		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
> 			p->interleave_ways);
> 		return -ENXIO;
> 	}
> 
> 	if (p->targets[pos]) {
> 		struct cxl_endpoint_decoder *cxled_target = p->targets[pos];
> 		struct cxl_memdev *cxlmd_target = cxled_to_memdev(cxled_target);
> 
> 		dev_dbg(&cxlr->dev, "position %d already assigned to %s:%s\n",
> 			pos, dev_name(&cxlmd_target->dev),
> 			dev_name(&cxled_target->cxld.dev));
> 		return -EBUSY;
> 	}
> }
> 
> In cxl_region_attach(), cxl_region_validate_position() is called before
> cxl_region_attach_position(), so attachment only proceeded previously
> because cxl_region_validate_position() returned 0 instead of falling through
> to the p->targets[pos] check.
> 
> Also, placing this check in cxl_region_attach() ahead of the
> CXL_REGION_F_AUTO branch means that if an auto-discovered region is partially
> assembled (with cxled staged in p->targets[pos] by cxl_region_attach_auto())
> and userspace writes cxled to targetN via store_targetN() -> attach_target()
> -> __attach_target() -> cxl_region_attach(), it will now return -EBUSY
> instead of reaching cxl_region_attach_auto() and returning -EINVAL for
> pos >= 0.
> 
> Could cxl_region_validate_position() simply be called before
> cxl_region_perf_data_calculate() (or inside the manual attachment branch)
> instead of duplicating the bounds and p->targets[pos] check in
> cxl_region_attach()?

I don't want to move cxl_region_validate_position() call in this
patchset. That is a separate issue that I mention below the scissors
line and it will be fixed up in a separate patch. The reason we don't
just toss it in here is that it is a partial fix for a problem different
than what we are doing in this set.

-- Alison




> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/3e5af9d6d59f8df52b9d21bcf1c7e78f06918f80.1793653629.git.alison.schofield@intel.com?part=1
