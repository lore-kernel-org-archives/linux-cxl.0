Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEB81DD880;
	Wed,  6 Nov 2024 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885666; cv=fail; b=oeMwpbV9makemVpQNPoZPlLQeYpl20msp9UFfsY5f2K6PXwAWqQHPg2zx2fpB/5q74OOW8kVEGB8pabgkp+mlo36A9ACafa9tLCiMCtlkEXNNAfXj1bGb4qPKKEvpL/UwQHzFCKBbjrpLvOSM0OsISdwlf3N1Xvt3oXG4ZgEdpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885666; c=relaxed/simple;
	bh=6qqiu4v6HIwGLqgQnNVDKDjbAHTO55I5Nxv0i8JRvC8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ica4Qc0OzHsYpV4RpOgQrMSqtNRfe+8XJGdThjc46lrD9VXNiWvKTJmajiocDgD0ZiSEZke+tcwNhNZ7mMTJnKb+gzpXfFcyVOLc9pYVQELJEcBKRh3KRb//y9ebeA3XAYbeamBDLg5+bWPwFawErEemZOlsF7ftbm+Br4+9aEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VqLWPx6x; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VqLWPx6x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730885665; x=1762421665;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6qqiu4v6HIwGLqgQnNVDKDjbAHTO55I5Nxv0i8JRvC8=;
  b=VqLWPx6xcJuUnNaMsnWkHySFWroS2RUStjB+yhcpZ1QmJbOvOQUkfRst
   LyQYbTpO+vvc/47R2n07SkSaATm0oAHt0/yo7QpgFKQmST3m9fwXTOgvL
   kN1JexLYXaLlDCiTieOYPW0sMEb5+nMfppXdbr4Pt0vid+9XLwmeyTtYT
   dXiDYWYzCC60RPa4FbD26op6KEkDT6roEjEsxTQD8RDXr2NzEdwNbmJ/e
   9EotSSnAFOUeGgUky+d9YJ5Cm6DWIwCWyCYm21MsAKQ8D3N02A7SLWb68
   qQVrYkpP32F/p1KIUAKPO9A6l8xGXgRXiFn98l0u5+CrEqoBbGLTrKXG1
   g==;
X-CSE-ConnectionGUID: pwdqM3gCSJyykRYofKp62Q==
X-CSE-MsgGUID: iwwcYxIsQ7aEQoHvHr0PJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41221307"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41221307"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 01:34:24 -0800
X-CSE-ConnectionGUID: 3IoJ593NQ32aRN5ZJ6/ivQ==
X-CSE-MsgGUID: J9RTMb8/Siu+PvkpruXILg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="115258582"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2024 01:34:24 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 6 Nov 2024 01:34:23 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 6 Nov 2024 01:34:23 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 01:34:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gx8zXzsvQJlcOGcjG0Zt+EkE2iAVMdu5zGVihXxPz+nKjg88j+X5Rv756ZaQPr7fFhzZ22qszf7J21j88xARyJRXBmWbNtkoncKi0UXxeG2JZcaKOSctuu9T1hwsafZb6mNIDLBSii5odpO5CfGbxInLCgv6g41CJCTtlmp2D9NQQVEWNFoqRRx2MAFs7JlJRQolKoccoQwG4ixaAWaVHX640PPYs614ermzRYzuIkfBczaqvJCg8CpnCkMpV4zby08NHoZ0RkyANOFEfDDM3w+bsnNbNLdPOxVA2i7Vkcfgb/XVtwDRUT3E3JrKztfr6kQbPoOXyeh4OvC6MJholQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qqiu4v6HIwGLqgQnNVDKDjbAHTO55I5Nxv0i8JRvC8=;
 b=oDwj1DplahZZyd4sRg7IIhnWaYiUFE2zf4zmW3oJNH+goSQI1JWlrTIHjWeS0bLnsg6icrP0v8Wpgzde8GqpqPPvVo6IlDVyCxGE96E3+XfvjiGVIDzAdVPRivckn+CC2QXuuhvs36wD1VddX/gBmY0Dwip1/rthHRVFmprfgxyaa7GwOlwoqghrtAchjbD/mjan8xQLFOKLQWxGMb3BIPX3LDH+Sky4SruoAKckRL8B27x8QXWZM7GXybCqo9xhpscep1WwyCQ5tTo+drNE+bAaeHP1xItDb9lDpGsBCXofIWNno7r+ElgM5xTljLmIARWgL8tyDOOrK41QVAwGVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA3PR11MB7461.namprd11.prod.outlook.com (2603:10b6:806:319::17)
 by CH2PR11MB8814.namprd11.prod.outlook.com (2603:10b6:610:281::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 09:34:15 +0000
Received: from SA3PR11MB7461.namprd11.prod.outlook.com
 ([fe80::4ec0:56bc:1ceb:7c06]) by SA3PR11MB7461.namprd11.prod.outlook.com
 ([fe80::4ec0:56bc:1ceb:7c06%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 09:34:15 +0000
From: "Ye, Huaisheng" <huaisheng.ye@intel.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Weiny,
 Ira" <ira.weiny@intel.com>
CC: "Jia, Pei P" <pei.p.jia@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [RFC] cxl/region: Fix region creation for greater than x2
 switches
Thread-Topic: [PATCH] [RFC] cxl/region: Fix region creation for greater than
 x2 switches
Thread-Index: AQHbKEX7nijo60YHI0Ci14OCMHEba7Kgn1wAgAlkL9A=
Date: Wed, 6 Nov 2024 09:34:14 +0000
Message-ID: <SA3PR11MB74619B051B903CA65784FAA49F532@SA3PR11MB7461.namprd11.prod.outlook.com>
References: <20241027075717.3714821-1-huaisheng.ye@intel.com>
 <80415a29-14dd-4108-aa02-4b0b5e1f2baf@fujitsu.com>
In-Reply-To: <80415a29-14dd-4108-aa02-4b0b5e1f2baf@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB7461:EE_|CH2PR11MB8814:EE_
x-ms-office365-filtering-correlation-id: 94260702-aefa-4fa5-ee12-08dcfe462dd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OXdFUDVRa1o2L1dKZFNYUER1TnE4L2p4ZDFZY2dGWmwxcXJ1VHRJWElySFZa?=
 =?utf-8?B?V2w3b3MyeHJ3M0FZY2VIM1h4VHUxZzRKT0hwWGtrTzNWMVdZVGtscXRvdHBL?=
 =?utf-8?B?ZEhkb0dvTEJld2xXVzQ4TzhWcis4Qjc2b012SjRQUmFaYjJvaEVxZ0tTSkFm?=
 =?utf-8?B?aE5KWE9lTUU5OEFJdWZZMzBDSFF0elFKZkFBdndpTDd0V3F6Y0cwQ2ErbU1K?=
 =?utf-8?B?RmpFdzNhQU9MVnZwbERieFRGOU9uS2N4RkRTUU9rYW41RTFBVldkdzBaNExr?=
 =?utf-8?B?bm5SWmxEUXZkMUE5RVZJQzhkN1h2bENJd2Jyb1hUSE9sRmZNK0l1Z0J5cG1p?=
 =?utf-8?B?Qm1icFNxdkc2U2swSzRMOUJBMC9QL0ZUMHlmNU9pYy9aSTdyeThFb05UclZ3?=
 =?utf-8?B?K1VGNVJ0K3NucFl4OU8yNGt5VnYyUWgrUFFCOHRPejBCVndaUHJ5UmNjS3Yz?=
 =?utf-8?B?cUt3czB4VHZRUUd2aFBnT29MZ1ZvaThpSUdRTUhpQ1hxVklheWtEMVBYa28w?=
 =?utf-8?B?QURXR3UzNDFHN3BTQVNvaDRiT2k1eDRmRzNoRHZRQ0VpR1RDcEo0WEJTQ1pT?=
 =?utf-8?B?STdpMTlVdmp4d0RBMERKTEdqZ0ZnTENaT2pQM1BCb3ZtNzFaRXdIcllGMVR6?=
 =?utf-8?B?VzdXTm5RL3dFRmF5bHA0cW9GUVdLdE9ZZ0VEL0phUExtcjZGUHd6UTRQTlVi?=
 =?utf-8?B?ZW9BMjZLVTU4MFNaRW9OcEN2MFUrdlFaSExnY2RXYlNkeWFtWFdIN1RvZjBK?=
 =?utf-8?B?Zk0vT1c5ajNCVGdNRWN5SGJoK3pDRzg0aEQ4OE42ay9naEJISS9EeFFWR0hV?=
 =?utf-8?B?eEM3MXM2SHU2SEJMVHBpVFNwcHoxNHNVdnJnUFNzcG4zY1pZU3RNVFd2Q3Bw?=
 =?utf-8?B?Wkk4SkVYVHpLOXRuTzJTdUg2KzU1QXMvRjkzUmgxbENxZGR3MUpkQitpWkRq?=
 =?utf-8?B?NCtOSG9EUVl1UUFmN0xRUUFseHRobnA1REZLMzFaUlcxRjNTU2VadW5CeFZi?=
 =?utf-8?B?WitqeGJhQmZLdUVaazkvZlBENjMxWlZjMEZsa2hINyt3NmlZampTWmpobjht?=
 =?utf-8?B?VFJnalFZeWRPcDdpUk45b3FtQkUxY2pGQTR6R1pGTUkvZENPZjA5VWJrNisr?=
 =?utf-8?B?NS9HZ25Db2J1M0pGQjZoNTVKNWJvTmhSa3NmTGtndk52SURXQ1NHZ1dQUEJC?=
 =?utf-8?B?b0dzeFR3cXdMeWlydDZaZTNLdGlTMGJCMTd0UVRQOTRzTXk2T1o0aWxQNVRm?=
 =?utf-8?B?MXByb1kyc3FSL3JubWIvTkpBOElxOU1mSFBHb0VqbjZ5VmNqbUc1MFlaT2dk?=
 =?utf-8?B?ODNyZWk2NlpYYzlkMU5hUEg5cFVJWitkYzA1d1puYVdNRnRFUUgrTGVkN1Bt?=
 =?utf-8?B?WEMzYnU1WVFmbWhjWGx6MUFzaHR3eWh3ZGpQZzZxR1I2SVJDeTQ5RGo0Zjlh?=
 =?utf-8?B?RExOMUJ4b2xrTm5KN1lIVEZkaWdUWldOalprT2JLeTgxUXlqZmF0NG9uWnZF?=
 =?utf-8?B?WEhwQTFvcG1jUTVoSU5UTW14L1ZPU1F1b29rdndOOVExWjlKbVJKaTJsRWJN?=
 =?utf-8?B?U1RLVHJrSllwcjFYN3ZXbDlSZzFFQ2xzeWw0QWVxM1JqaGp1RThsYTZKeGcr?=
 =?utf-8?B?TXNpZEdVenpadG9ZanFFUWduSlgxSWdlbng1MTl1Tk10TWRIeFFONVVGeURW?=
 =?utf-8?B?ZE5XSm0vMWIwQ2JZT1ZpblBQNFM0THlXcFh1dm9tejFya3ViMjl0YnlUc1o1?=
 =?utf-8?Q?PegEuosRG3+cyPGpfrGCc4e4jpWsvyglRV0s36D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7461.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0k5RW1mMjMyMUFXN2JSVGNadkNHMm1qMlA4NlFqdFd6a3ZYTWNuSGtqbGZz?=
 =?utf-8?B?K1RONG1YaTJuN3l1V0g2dWI5ZG13VWE1OUx1UEMva1gvVUVicVBEWDlZTFMr?=
 =?utf-8?B?L2t3Mlk4a1gxdyt5UTZYZ2VUQUFVUGpQMVkrQ0huR3hqdnl2ak1LcHNjNG9t?=
 =?utf-8?B?M3REZVdySHVPWnEwR3JGaU1STDZjSGd4Mit6QmZSSzA2RzdwWnV3NGRSNHV3?=
 =?utf-8?B?UHAwVVN6ZmNvQ2dhVzhzbld3ekJldGlnRVRrZmtaMTk1NVVxNFBZOHp0MHg2?=
 =?utf-8?B?R3FCS2UwLytEckxidDRCeXYrNis3eFNVNDhHRVh1OTQ4aUtZenRlQ3oxcGFy?=
 =?utf-8?B?OGh0TjZtVHV4N2JOY1Z6emtvcVZrRGlqaFpLc2NRem1XUEg2RUs3TDZna09C?=
 =?utf-8?B?OTlFb2FGNGZmNGtNcFNhL2JCZGFUY1JOS3ZkSVJhaWNvbXpUZmFGQ3dNZnEv?=
 =?utf-8?B?Z21SdlpMcGQ1YjNrT0F2NXNzbjQwcDBaL3o4Q3lQMFA3OW5DSjlYeFNKSitH?=
 =?utf-8?B?V3M4UVRkTjd3aEZ2bGI0c1N0bWxtMmdSTExnd2ZGb1FSRTMvRXAzNWR0WTNr?=
 =?utf-8?B?a3ZNSHVRUUdyYXJSNGpKczI5eHdiVmltNm1hVmdBeWFyY2p2NW5TckRwU1cx?=
 =?utf-8?B?MFhISzQ2anBhbUw3ZjZWL253V1BxZWxuTW1yMGpTei9zTFV4U0QwdFJTZmlo?=
 =?utf-8?B?WkZYTVN3R3hPV2wvOHZtYVdEZmg4b3F2aFFFcURRS01jYXZ4TjUxS1ZEQ2Ur?=
 =?utf-8?B?MDF0UTFick4rM29Hczd5K1AwNGVsRVlDZlRKWlVDS0diSGpGNk5VdDBNS2dn?=
 =?utf-8?B?OEp6dkoya2g1UjdRRzMvUGMwVVhwb2p2VTF2b3ZrQlNCaVZRWG93VjZUN1Ev?=
 =?utf-8?B?V2pyVHV4THVqeVJJTFFwQ3ZvVmEraWZRTk5QWkZPVVBFdVd0eTQwTjVXYzhU?=
 =?utf-8?B?anlpSGJkMGM4OVMxU1lqZklYNHRPZTd6aUs4NXZXWkx4NFlsNitLQkc2QVRU?=
 =?utf-8?B?a0pXU1NjZzJ0RitEL2NNK2NqeEdTMk9lQmFvNHIralg1V1BsRXNqVjE2eUVZ?=
 =?utf-8?B?M1d2QS94ekh1R1k4VTRuN1YvS2ZFVEVhemRpa3hoV1htbEEvMGN0eFVveVhV?=
 =?utf-8?B?Y3d2ZndSYlB1bHI2SC8vL2VSNnV3U1JRMlVxcm9ERTdKM2xoa0dkQTFnejM0?=
 =?utf-8?B?V1hodjNsU1ZXaHR6U0xqbFpzcERMcWtoK05zN1N3T2FzYWNDaEU1ZHNjMG5x?=
 =?utf-8?B?UGpReUdYTHowSkc1cGdyS3Q5dVhrb0RoZmtJRHhBWEsyZUtwcXRnR21zdFcx?=
 =?utf-8?B?RGQ2dm1nSEdaVzluNjZyYTdSaFdGTWJVTUIzQ2pzTm9zVW1UUE5qYTY5c0lH?=
 =?utf-8?B?S3dOSGdqOVJKb3JzRVBCcklNUDVrK0NUMUJYeW9rQ0VwQy9VdG84Y05JbjZs?=
 =?utf-8?B?WG95TEd3Q3YwcUhWZ3NqMkk2RjNrOEhWUjhEcE5CUFdSTCs0Q0RVcEI4MW1E?=
 =?utf-8?B?MkxGUXB6NDZOR2xJSTlINCtkUUx2dUJZZDhiUXFmT00wbjJhRGloTXFWL0tX?=
 =?utf-8?B?S2Exbk1SM3M1bTJ5ek9XTzZydGp1SlJ5M3N3dzlNVWUyUWJFdzRZVzRFaEx6?=
 =?utf-8?B?aTBVbHhoTDE4RVhkOFdtNnNXUHY4dUJqZzJmN0VzSEZucFpLZmtsKzNIendN?=
 =?utf-8?B?MGcvZTAweldMTlh0Z0Y5Q1FpQ0RyN0o0TTQvZ0J4NERwY1FkN1BuT1ZnUGxO?=
 =?utf-8?B?RnVGRmw3ZmhCSC9vVDBhbzRPbE03dnNYSG9UWWtwaWt3eHlhZ0NTN2dOVW4z?=
 =?utf-8?B?L3E1eVlQdis2bmkwZzkvblg4dUlqNW8wSGdOK1hDNnM4QlBKTWhDUktnclQy?=
 =?utf-8?B?SFFTT0NNWU5DMjFaQTc0UzBCUncvdk83VGRPWFgrSHZ6dnFDM2NqTGFGSmF2?=
 =?utf-8?B?NFlaVW9Zcjg2QU9zSFlqUGp5SUZ0TzA2QkpBdXRHeTNIN0paMkxUcFIxWFFi?=
 =?utf-8?B?aEpsMkxVRDI5YmtFNE13dGVoMnNJSTJQd3RSclBQS2pGOHdBQ2xqT2JOZmhE?=
 =?utf-8?B?YnNyQmhzbWdIU0cvSHA1OEhJNCsvMUpaWVZUcUh0SVJFQmJFVnBJWkJLUytk?=
 =?utf-8?Q?gx+3enwmbaR96NrPdTxh9PNzj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7461.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94260702-aefa-4fa5-ee12-08dcfe462dd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 09:34:14.9808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8HGr4jADnmmFwiUh4bDMC69yu7uMxW5K9RDhiEmgDJJs03vLFfbdQVLu2SuPD1v+BRaUOGTIqQzdJaNUFKw71w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8814
X-OriginatorOrg: intel.com

RnJvbTogWmhpamlhbiBMaSAoRnVqaXRzdSkgPGxpemhpamlhbkBmdWppdHN1LmNvbT4NClNlbnQ6
IFRodXJzZGF5LCBPY3RvYmVyIDMxLCAyMDI0IDU6MzQgUE0NCj4gDQo+IFllYWgsIEkgdHJpZWQg
dGhpcyB0b3BvbG9neSBsb25nIGxvbmcgYWdvLCBpdCBkaWRuJ3Qgd29yay4gQXQgdGhhdCB0aW1l
LCBJDQo+IHRob3VnaHQgaXQgbWlnaHQgYmUganVzdCBsaWtlIHRoYXQuIFVudGlsIHJlY2VudGx5
IHRoYXQgSSBzYXcgdGhpcyBbMV0gaW4NCj4gc2VjdGlvbg0KPiAyLjEzLjE1LjEgUmVnaW9uIFNw
YW5uaW5nIDIgSEIgUm9vdCBQb3J0cyBFeGFtcGxlIENvbmZpZ3VyYXRpb24gQ2hlY2tzDQo+IA0K
PiBJIG9uY2UgdHJpZWQgdG8gdW5kZXJzdGFuZCB3aHkgdGhlIGNvZGUgdXNlZCAiZGlzdGFuY2Ui
IHRvIGRldGVybWluZSB0aGUNCj4gb3JkZXIgb2YgdGhlIHRhcmdldCwgYnV0IGluIHRoZSBlbmQs
IEkgc3RpbGwgY291bGRuJ3QgZmlndXJlIGl0IG91dCAoYW5kIEkNCj4gc3RpbGwgZG9uJ3QgdW5k
ZXJzdGFuZCBpdCBub3cpLg0KPiBJSVJDLCBuZWl0aGVyIHRoZSBDWEwgc3BlYyBub3IgdGhpcyBk
b2N1bWVudCBtZW50aW9uZWQgdGhlIGtleXdvcmQNCj4gImRpc3RhbmNlIiBhdCBhbGwuDQoNCkJh
c2VkIG9uIG15IHVuZGVyc3RhbmRpbmcsIGRpc3RhbmNlIGlzIGRlc2lnbmVkIHRvIGVuc3VyZSBm
aW5kaW5nIHRoZSBjb3JyZWN0IGVuZHBvaW50IHBlZXIuDQpJbiBvdGhlciB3b3JkcywgZGlzdGFu
Y2UgYW5kIGVuZHBvaW50IHBlZXIgY291bGQgZW5zdXJlIHRoYXQgdGhlIHRhcmdldHMgYXJlIHBs
YWNlZCBpbiB0aGUgb3B0aW1hbCBwb3NpdGlvbnMgZm9yIGJlc3QgcGVyZm9ybWFuY2UuDQoNCkZl
ZWwgZnJlZSB0byBjb3JyZWN0IG1lIGlmIEkgd2FzIHdyb25nLg0KDQo+IFsxXSBodHRwczovL2Nk
cmR2Mi0NCj4gcHVibGljLmludGVsLmNvbS82NDM4MDUvNjQzODA1X0NYTF9NZW1vcnlfRGV2aWNl
X1NXX0d1aWRlX1JldjFfMS5wZGYNCj4gDQo+IEFueXdheSwgbWFueSB0aGFua3MuDQo+IEkgdHJp
ZWQgdGhpcyBwYXRjaCwgaXQgd29ya3MgZm9yIG1lLg0KPiANCj4gVGVzdGVkLWJ5OiBMaSBaaGlq
aWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQoNClRoYW5rcyBmb3IgdGhlIHRlc3RpbmcuDQoN
CkJlc3QgUmVnYXJkcywNCkh1YWlzaGVuZyBZZQ0KDQo=
