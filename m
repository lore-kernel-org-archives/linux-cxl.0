Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795125383;
	b=MJ7Z9vvwd2bHxohkav9zXXqgqo/JLWPlNhjsCkojFYLYzzlVQCQTKubn1UCsTEwQTx3h
	 3qwdyTNoAz33QykapBWQJiKkadnY9ih8BPt6ZSuQO/E5/pFaO9l3BHa1KkqtSZiEE7yxu
	 Gbc/C3sAiYJsxwKbeUzFsZ+ahXDEIiQ4GqDuh9OH4rHd8MvS+r5jdOCZ23RrgHbfFQgos
	 Eyx4yUqrdLklXpA5D+WHs+jD7XTqtCGfFAU2KwqqWzvIwAy3Pv4CGhSRc2wu+8FfYXDbb
	 9fi0/evTJ/R8M8Ledd6/qI+3bunBSMpShmQues0RJ0Z4DjwWyws5hUPjFUhE32YIyaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125383;
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
	bh=+vvv+OzA3d4zgevrtARmfLQJoMStSb+rhz9BxZbRulI=;
	b=ax9Dlp9YRivQFX9njnKUH9iXzOOYSRS1FXNZQo+fcOdp/BOzIE64JnZbg/YTDR8CNuiq
	 c508OYL6rT1/6bTIS6LJWfLzesSNfB4/In99qn3cv5Jhx2WbPsVh9b2unbs8pX9o+L9hs
	 hfBCqLPX1o4v+PmwcFTGEKSKQSnpi09kEdw8WFnDVKfILP5IayZM0eXvcCO6u+3KOQI5d
	 q2a+m6KTGIv3LjOM6NEHj9ADuwRkXQ0d1L0ZIFlfW5BxrFif2X5fAdhe4fsDorijoWqX0
	 niUuyNePZW+nZ4yGCFBpvK3Q6mEunwih59+/EQLBMroQ1mL4UwShs7I7D5P6/V0nZFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RGWvmiFv;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=GHA1H7e0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D4D606A325
	for <linux-cxl@vger.kernel.org>; Thu, 19 Nov 2026 21:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34D4D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RGWvmiFv;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=GHA1H7e0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795125382; x=1826661382;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Y0NdCa0KN5fqjZFhxNg0islGDadslhyXAdUvxyzyu7w=;
  b=RGWvmiFv/yRCk8tpaQBQ1GCeOl91F88A4/WpOyt7QgvQqLNSPltMqLcE
   8Zbl/uef05sH/bCwSIadp0tATIedzXhmMR+HskjoEHFJC9mml0aCrHTed
   ruUPwKWQ/fKm2J3FQodHW228rzBIkco3Mx01qiW339zlPRYnYDq56OaIk
   ngbhsTAWIRLh6ooZGBRTG1jYEO7R26hdn6gq9s0+OVYZv/HiFBSnCgXZj
   WxXblB3bj2R9sr0E7meGlaq+NhDqcS8hV/Kj3qO26oe8ElIDn61ShH71+
   q4wUBbB4OQMSM77SIflHQKhK93OJar5xAniO1bQP5BefVEuEyMwkoj3wD
   Q==;
X-CSE-ConnectionGUID: y6/yhfWZTwiYaJ1YiKYaGQ==
X-CSE-MsgGUID: 30KForoTSZmlEXTZL5teIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3879781"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3879781"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 13:56:21 -0800
X-CSE-ConnectionGUID: bSr7rCpRSf+S2wvFEGQIRQ==
X-CSE-MsgGUID: 7ewCnnd8RTmY6+Lexn6DZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10626884"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 13:56:22 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 13:56:21 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 13:56:21 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.52) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 13:56:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHGhESFB6LPQ58BYNjKine9LgU2Cp0GUJXjvdhnb5zFKcf1vt65woiPW+QZ+b4fPZDuvIk3U3ME8Y5VP2rEl2xkqGJvW1YVil85cX8BM0wzlWRj4oihGzo09HIlWu6kpHBx6H0N8aRZfFaP25NDuNRHDZsBd2bRLkMs/NCxQhBkKSFRtrF99VzPmPaUrgqNI3zOJjBXNSeZfltJf6XkQz15Ay4/TByuR+C32BLDx09SnHQ1DirpLxfHw736Ft3s5mWNlV7Ek1VMpUOb+ajmBt04D/z9v5ptN8Hu0jVQWqKnTMakkAhZhUcROadIetdvF81EmuPNp3aG3IukAz1JixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vvv+OzA3d4zgevrtARmfLQJoMStSb+rhz9BxZbRulI=;
 b=QzqxozdnjzB1mKEM5f/2np+/grHNz3vWnRpD4IVc9rxPf5M8eCasDTbXaJZUrct4JfMW+CcC1yLlTf8A6E4vRS0zeyeSzFXrXibfxfBUYqwnj1U0Ef8ykL/VfStGUAb/COK0JNnSMbmTM2WCU467WX4edHbb26c+h3rDL6sSuYjGj2oOTCYApKoWo1KzWjVsLRR4QOENDvq0nAsabnup2axC0HBWCnp1moEalG9EcYN3sPGUwEfP27Uber58o3jT2qF0A4KSh3WHJ+u+tcNziObKUwRNMuxF7enIWVyqEuZ0m6x3uNusx03dVMbA7DHtDUwsxdTnrlEvzVVMTyRqpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vvv+OzA3d4zgevrtARmfLQJoMStSb+rhz9BxZbRulI=;
 b=GHA1H7e0D5CZssRs18hh98di8yX/2H0jKv5T9ivisqkYvmDHbetIRD7/bBQQPZ/lzo9kW8HlhELy4b3p1Uktx37Eu9Tp5SV0x2/zHDIOOAzRXB/Bluc5JlQdM4ohFwqbjZyF82tElNzjc1HatGGgN1TIdDPYjSMNJBO+lCzuz+0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by LV8PR11MB8584.namprd11.prod.outlook.com (2603:10b6:408:1f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 21:56:18 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 21:56:18 +0000
Date: Thu, 19 Nov 2026 13:56:15 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH -ndctl 0/2] ndctl: Back-Invalidate support
Message-ID: <av9wf8DApoJuDKxg@aschofie-mobl2.lan>
References: <cover.1795050773.git.dave@stgolabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1795050773.git.dave@stgolabs.net>
X-ClientProxiedBy: MW4PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:303:8e::28) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|LV8PR11MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: ca2665c5-5161-4bb4-7443-08df4687f056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|6133799003|11063799006|5023799004|260925022911599003|260925021311599003|56012099006|260925021911599003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261021121427099003|261022075727099003|261021123027099003|261022105027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: mOykvWxARG7DKsSegz9aSwJ+lD/x4FRF6hMNzp541j+8Okv6rywAXhbw/5OXNDpmguzlt4mZMZd96sXpfHdHiVeFJOGqTx2NYeOJCjrUy9Xe+u1UxgLT9JY0hfvhHTEH9VH7F0JAYu8diR4bUWM4XUWGL4gv/fzSeLblTF1m85W0RHbI2fhEsT6UKEGn/7drMe02wdjSDJH8qnjzzsCCbLbkwaii43xedZX7lOSV1/QrUI+VWSc2Yyoe0bhglKUhKGpAKAX16m2eveDAJhWAkP6tdpF6yw0MjQSdwCbmNdY+RHyeV347N4v9zvZMwq5nxS9crgcydjjQBmSiO1Enz4M/hRwDgcy5N2RqkI5vmnjP3U2kWomICpgGdlJJ70Zz41C21p6PuKfTg1dVBD70ltPE7tdNa97zrJaJkT+3MzW8ukVoqEJCGxq6vUJngzk21vlzCryS25u2oI9p/XZ1j/EBXTx7H/Fdmgz0wF30vYn6T9Qt/JdxboJ3+cVJ+utZbZq02pjCzbeXi+Nz3gTYqqeU1qQN7sb7fwboBnK0h2ELm/C3P61MfDROwkcQDPImyIzcKbwujzfxNDU2SYuSkHGTcrr/U97P9gTUZrfZXOTpp22YP6e32j4LC3BE5Gt3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(11063799006)(5023799004)(260925022911599003)(260925021311599003)(56012099006)(260925021911599003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0RMjAJ354ZzTEXsmaJTR/kB+0nzlCr+R+GSZpdA5+Aflu3HqbUNnJfQ2z7oN?=
 =?us-ascii?Q?65AnlOIRoXanWVfqet8rGEQGHEfDBnIi6RjlE0kQsEcsfwk64nt+d5ZpSfr+?=
 =?us-ascii?Q?HRhic9w68Z1mUoUGrNjOSJD8GjpayXes7z1X94srF8pg67XR0ksDLypVPqaT?=
 =?us-ascii?Q?QbmKMuG2kSFjOPJ5ksmtNYmrRo2m2vmyM4Ce5VhQoRkGbuA9MEFpRAj3y36G?=
 =?us-ascii?Q?eSVsy7C/N3vIE9p1vvHkyKPa9JS9lqvCjnOiTX1T4RrbLFF5meXa9JaeBvQZ?=
 =?us-ascii?Q?N0eJ1t9Tpv9tIcNkyFgoP2qxfsdQSUfOwBWU3DY77Lc0K1JZo45+Wy3PFX5h?=
 =?us-ascii?Q?uiER3cfBbIHs0+95pevUOl4wwD4SD9LqKa2z/xPd+7SvA5XTPz4S/PH7Ybr0?=
 =?us-ascii?Q?vqYIhTJyBNJ92+Vt8z/18sI1rZHnOB1PTOIuDuO1v0uJ0T+oD4X2eJqx+IS3?=
 =?us-ascii?Q?MSJ4GX6OdhoGIzRioL4onXVgh8K7ZVProCkyCuze772Nlds/D5oxIFhzVICe?=
 =?us-ascii?Q?qod0pxTG1pjLEIoL0zs8dqIJx70wmqIbDsE3DHViwPc4A7Dx/SIIcrqujEdY?=
 =?us-ascii?Q?bTU2U5pZer+Ix8Qd6kNfkf08GMRmYFA1qpipuNLug1+jO5kYh/1luujuuxyc?=
 =?us-ascii?Q?NlYNwLwIDPyI2JGOzgX78K0CPfSYcJ1B3d2IIkyR/wcsJAOfpraK0XsWmLFL?=
 =?us-ascii?Q?Tw5LNaPwahwvO88yN2yTR4hsRSYy09U7pUg1CVrq07gSeXEP7BSuk/EOSBnd?=
 =?us-ascii?Q?/Wo7RnmM2aXxDfb5O9Fai/dgoBIBXDDgMfWZV89SdQbeKdkMFRrV6Ukk51a4?=
 =?us-ascii?Q?90GVLLd9L6FJ/9c5rDYvbYGGWQJqGP92R2zHKKv/M1s86Yv3YfQ+kqPtusa5?=
 =?us-ascii?Q?GsapE1GjbhhAkx+ZrWBpAu7reKhfGub1NhtnAJWDasp2SKvkr35oPY4Hu4xN?=
 =?us-ascii?Q?bckoWlokeyD7aaoSTUJasIBDAZX5mflTuekeB5s9yMtjgTyPzBiQGbUcmr+f?=
 =?us-ascii?Q?Oz1iN/JanBTL5kwwo3AZ6mn6Y4IFpWhm0kUxiq1uK1GgzeAbm6nnmCMNixrb?=
 =?us-ascii?Q?4E8cStUW1N5MNTjRr9r+cS1I+O+Ern5TZ4lWz1Vp1nLbVJQIOOzzig4iNZjW?=
 =?us-ascii?Q?Dt894/riBC7Kka2gPRbXqXDJOIj2Qy9YLN6q/KRy+8mMq/L2WSQhthvJcsRY?=
 =?us-ascii?Q?vmJyB1XQ+q5qlC/rP1o74GSNSOwUci03OdoTUwS/Z3XgKSzDiTNCxx1lUQW3?=
 =?us-ascii?Q?LVX61R4/bE1ZmyDL8RcDoS+aq/M7lQ4EGY63oU7F/ET7rnYKEqb2AIzpHUTl?=
 =?us-ascii?Q?gClb0O5Tt9A7PaxV0B1IjCiITEQB9B5hOp+BWE0g6zxqmRk8r2N8avqxQIOH?=
 =?us-ascii?Q?9ofNWuCGEn0TU1gj8/YKlUGv9Nj0WrB1/nzLQXmcenXA5cb4Asu2tpEoqgAW?=
 =?us-ascii?Q?jgqsntorDA9O2yydnYWiRzgjODarvQXI0pLOhuHzBQlN5Q67m7wEzQiYVLW6?=
 =?us-ascii?Q?qC7aFCBXG9+4PcI1g2NLOeTDdWhRAUVlnLTq3Wa1yQZ15Td5Pb5Hk1WJ9Dsj?=
 =?us-ascii?Q?6vii8vmVZsEla2aVd7IAHYV/BUGArvm7nfuFNZEDIw863X0ri1u3AB1TSKi6?=
 =?us-ascii?Q?kt+LbwnhYZuxu+DU/XT1enO3PVTv56ex73f2Y6JSRnzLGoyHmZj1y328C3bM?=
 =?us-ascii?Q?3KTCK+Afb2cpEAilbs04N/j6K7vHCAGcJJ66ljw818oClsUjRg1Kt2BJH872?=
 =?us-ascii?Q?MWGbUIkBSELllWs58m5PQtVSA2SxzLw=3D?=
X-Exchange-RoutingPolicyChecked: u9BeVT4KoF1/1Rw09QIXuQeLvFaCtdHIF3Oai4YqpmBdgTg3MlWNFnNbzt+Qaadvr1JJdE3ipTAJV6nhlRw3+/f80NE/mRrRCCf7qCp6Tjg3/80MHVHaa7AtKo0QnGD/GGox06WNsV1lPhTTN+P1bez7Z8J0BuvaaJtrn7mIsbhIgmd+HffBUSfjb5VYqPnajSlxq3oHmGs2gitR8GRVXV96jG6v9zbBNnY6c53fnkMLbI7OV4dOuBggd93qRT326AEdOIHtmb0zzQ2MVzJJYYXy2gepSfmVApHCBzwiEXrgey5XaFaKkLcjMfX1j3hfq6FsyXJgcG2qLmUbQbt4zQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2665c5-5161-4bb4-7443-08df4687f056
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 21:56:17.9818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gwYKgK6kQf0p0Y00nXvPfWDY+4Pn0EH6zuBraVE59CbXczet6wbGWx9gpYHhV/p8RUZ8FNvXnXqHMYDEyQOr7fprz2tpZJlidNttqv1c5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8584
X-OriginatorOrg: intel.com

On Wed, Nov 18, 2026 at 06:30:26PM -0800, Davidlohr Bueso wrote:
> Hello,
> 
> The kernel's Back-Invalidate series, now in cxl/next [1], adds two sysfs
> attributes: cap_back_invalidate on a root decoder, set for a CFMWS
> window carrying the BI restriction, and back_invalidate on an endpoint
> decoder, set while it decodes an HDM-DB region. It also gives cxl_test
> a BI window with BI-capable endpoints below it.
> 
> Patch 1 adds a cxl_test unit test: a region created on the BI root
> decoder comes up device-coherent with back_invalidate set, and a
> cxl_acpi rebind replays it with the model intact. It skips on kernels
> without a BI window.
> 
> Patch 2 has libcxl read both attributes, reported by cxl list as
> back_invalidate_capable on a root decoder and back_invalidate on an
> endpoint decoder.
> 
> Tested with meson test --suite cxl against cxl/next d337784de533, 17/17
> with this test included.
> 
> [1] https://lore.kernel.org/all/cover.1794172701.git.dave@stgolabs.net/
> 
> Thanks!
> 
> Davidlohr Bueso (2):
>   test/cxl-back-invalidate.sh: add a Back-Invalidate region test
>   libcxl: report Back-Invalidate decoder state

Hi Dave,

Thanks for the patches!

Applied to pending for NDCTL v86
https://github.com/pmem/ndctl/commits/pending/

I did minor touchups:

libcxl patch:
	[ as: document BI decoder state in libcxl.txt ]
test patch:
	[ as: check BI fields in cxl list, fail on missing BI window from 7.5 ]

I also reordered the patches so the libcxl patch comes first. That lets
the test check the new cxl list fields without breaking bisect.

If you want other/different changes, let me know.

-- Alison
