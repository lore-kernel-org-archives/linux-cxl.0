Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8619653804
	for <linux-cxl@vger.kernel.org>; Sat, 11 Jan 2025 03:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736564949; cv=fail; b=hkMQDxxwExu+KaoFGhAziCrWwJQKvxhhf1QJjqodI5X87CKb/QNb068SUkMow29IPPOiTU5T1ybQbBod7qMfywCOu8V+ERXnd2kMgEspH5cCRSNq+jiUOWG584L/+UMHEd6dnzJsGKW42yR3t8W2M0rT4qVMpRT1w+ez7ryLR9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736564949; c=relaxed/simple;
	bh=YyDYwCuKxtWZ8H2jafvx140mlTTexesiLGP0h7/krg8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TOQDM6f4NLDUyJmDc0cdOVHfPcVkbWGtNQiwo96DBXoscz852MLMYYSoB+qnRl+JHME7Ou2cEVTvsYn4dysZ3HPTsTpBeyyCpqRyPx1QzGmucBCTFXxyWDDmOZsYyL2NIxkf7o80W1Agp27dzKJqCx8NpQO7XdaZ7aVtcFDxX+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fXz9zecv; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fXz9zecv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736564947; x=1768100947;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YyDYwCuKxtWZ8H2jafvx140mlTTexesiLGP0h7/krg8=;
  b=fXz9zecvokyBVoZWW6IqqZLNaUiBv8MU1TAHt3yVrR9JXppfa5HMgCzI
   tJtY273eGxKQAkpkllekcwm6X3tERL1JPlOKoOqd5N7lPfVRO0Mxoubar
   8bWzESSSaGCj2BoHZ3HvPUa7qAyMe69MSX7+8jrKTWlxNSwDHB8k/WmQO
   D5ldamqVqKKjiUNurblwTBJQX88eV2jES+mbUBbmIlW8eXa9UTGdGwPHS
   Y51O5Dnf8VUV44WeXovrPFQibhnec0HnVoSchl3/RLcPeRQmxcH5iRV2U
   YFngWzJCF9NSs7xiu++gXd5JYONQrQYIVYo9SPvGqXKC+dbvN3NDJ/4gR
   g==;
X-CSE-ConnectionGUID: lQxh7Ga/Q9uZBqVs8E7ssg==
X-CSE-MsgGUID: Di4pmagTStqZP9Ta1dThtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="36152499"
X-IronPort-AV: E=Sophos;i="6.12,306,1728975600"; 
   d="scan'208";a="36152499"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 19:09:07 -0800
X-CSE-ConnectionGUID: Sw9Y+Ra4RC+yIOYG47iazA==
X-CSE-MsgGUID: JtnbbTstQ9OVhbe74BTAZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,306,1728975600"; 
   d="scan'208";a="104420508"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2025 19:09:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 10 Jan 2025 19:09:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 10 Jan 2025 19:09:05 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 10 Jan 2025 19:09:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tA2Mq91HTLKbIK+sOkrxoDmWo7OmAUcKWc6o/GOPmhgFd1dhsBa+ewhIwzeQzUgBvcF6R7JAifrdw7IuwqGaD50eBYPUpM+/Tku/dzCF/+H1G+sJ8O/l4pzuZmAzbojTjZHqczAj1m+xR5ox2YJKJJ/03zDAL+uPkfElEOaRAQmRoucjVJkf0PY14dbcno+lE7ctlQnrAMaTJ4zYFsKCHJ/+TyjiPhYT8HPEGX0WOFIHoX/yoqdeFn1ypgvFA3wz1nMqFe28qUUG9HOaEBjqEZdlQ1uXbl2PIsKghPM+utXJbiMXgD6GrBklSbVR9KHf3HXk7zLNL9Qp4FSEI639Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyDYwCuKxtWZ8H2jafvx140mlTTexesiLGP0h7/krg8=;
 b=eMqpyyFdqed8c94YMWAz+BsD7GD2mpWwqEwGmCo9iHCu1/+z+mL8y/Kw1A0v7ZlmBcn8a599Hrkb0ZyIJE+NLqAK70XC4JBw0hfU4FXqlba3Qf86pR2m5WwEJTaXs8xMRX4y1bQ+b4nFIK+R0IaZAodcaH8p/vP+PXqi68CCxTnF7MK5yr1gFExMLfCZdxiA51sfPM25iI8J5oJrcW7KmabFkI/PX8VZc1VvDPjE6fi82Yu05yti/Q9PPJTcuTqjezEIxSqEKgg0h38vqXyQuUrduCoXC+CbLKL7rFXjBFzQbFjKJeFT1vRtDuh3HuxhvPfp8nSIjC8UluXoTbb3lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA3PR11MB7461.namprd11.prod.outlook.com (2603:10b6:806:319::17)
 by IA1PR11MB8176.namprd11.prod.outlook.com (2603:10b6:208:452::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Sat, 11 Jan
 2025 03:09:03 +0000
Received: from SA3PR11MB7461.namprd11.prod.outlook.com
 ([fe80::4ec0:56bc:1ceb:7c06]) by SA3PR11MB7461.namprd11.prod.outlook.com
 ([fe80::4ec0:56bc:1ceb:7c06%5]) with mapi id 15.20.8314.015; Sat, 11 Jan 2025
 03:09:03 +0000
From: "Ye, Huaisheng" <huaisheng.ye@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: "Williams, Dan J" <dan.j.williams@intel.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, "ming.li@zohomail.com" <ming.li@zohomail.com>, "Jia,
 Pei P" <pei.p.jia@intel.com>, "Du, Fan" <fan.du@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v2] cxl/core/regs: Refactor out functions to count
 regblocks of given type
Thread-Topic: [PATCH v2] cxl/core/regs: Refactor out functions to count
 regblocks of given type
Thread-Index: AQHbWrW8SUD6fQ85FEu3ct2B4KhRQLMQOgGAgAC50kA=
Date: Sat, 11 Jan 2025 03:09:03 +0000
Message-ID: <SA3PR11MB746123DB727FD51609CD436A9F1D2@SA3PR11MB7461.namprd11.prod.outlook.com>
References: <20241230122239.3445117-1-huaisheng.ye@intel.com>
 <20250110155255.00003a1e@huawei.com>
In-Reply-To: <20250110155255.00003a1e@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB7461:EE_|IA1PR11MB8176:EE_
x-ms-office365-filtering-correlation-id: 0f611dd2-567f-4edc-a9ba-08dd31ed4d9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R2FLSkhlNFBtbTFSc0k2c1dveEpJSE5KaWNxR0U5cCtCbWloZnNCa1VYTnFT?=
 =?utf-8?B?OWZwczRobVQ1c0hpS3R3ZTZqWDV1bDZqRlh2dXFWd2wxWUNQSW5sWm5MQUxP?=
 =?utf-8?B?ai9zajdnZWdJakJ2TGVkTnZpVUZ1cmoydnhJdzZ4bTlCcXc4OUI5U282Slp2?=
 =?utf-8?B?RjRzVzBneFN2QSsxdWt3bHpZaGpEMm05U2lITnRJUDJMZ09NdTRPNzNHSVZH?=
 =?utf-8?B?WVF1d2RwVS8vOWpPQ2tQWVRhajltTGtOc25ZR1lVS0c3eHBvWTNNekJsd2JP?=
 =?utf-8?B?RC93dnlYOXVpWXoxL3ltLzhmR2tRT1NYSHZjdStiWE12ei9GUTFsVGp6dzFX?=
 =?utf-8?B?bHpPMTlOdDNJWlJQT2h1VnJsUDlHa0hDYXJxNGkybFJDR2IzV0xzbyt4eGww?=
 =?utf-8?B?VW1ZbmdKODUzemlEem42cGRjYkFuOUZvMUs5YVp1c2VJVTRHY3hmU0FrMytR?=
 =?utf-8?B?Nk1Uakc0ZWdMeG93dlhFS2s1ZmIvQ0dXUGljUTlqcnlKNlE3c2ZiMkxmS0g3?=
 =?utf-8?B?WjQwZ2FIanF4dno1Wk5WM3F4cXpaeW55Zkd2TWRmYzJsTFNieEFNQ21zSTZE?=
 =?utf-8?B?ZThRMnB0T3JEc1RyUE9vajBiYlV4cGMvZ2V4N1ZNV3A5aGcwY0k2d0lPT0JM?=
 =?utf-8?B?d0xFaWgyL3dOWDlETko1UHNLVnhtMk40cDJDYWFhOEpsSUFvLzQ3bzYwTkJJ?=
 =?utf-8?B?QTB1bTRCYXcwWGlpNHpvOTR1UFZLQmM5d1NWUGNZcmwrTTFZS21RUERVTW5v?=
 =?utf-8?B?RVVsSXJoUVlFclpjMkVJS1AwYW1aa09KMU5GS1RrZVE4VFozRE92czhXbXVE?=
 =?utf-8?B?bTFnOTI4OVFacy9WTWxjdjBuUU94RHdpc2NCckE5S2ZGVzBYaEJ3MXo2K0hq?=
 =?utf-8?B?U0hsMnNLUWk1Y1V1Q2c5R3k2OTlpcVhDRDl0N0FxdVc3K0ZSSllCQjA4RUJN?=
 =?utf-8?B?a1pqWXQzWUYyT21uN2hMekY4UDQ5cU53YTZiVXl4MDNURWZsV0F2YXNNaS9K?=
 =?utf-8?B?NGorWFZzZFAwekpneUlxNTlDT2lvSk1md1phMno1Wm5Pc2syNkdVYnExTTZQ?=
 =?utf-8?B?ZG1lVEtZSk9nd3g4NWJYWi9JSXJwN2l3a3pFaEhvSnhBSk5PLzZ5Qm1aSSt2?=
 =?utf-8?B?VTVQcXd6SGFMUWlpb21qR1pqaUxjSlN1alpNbDloRDVuVlNPSm5Cb29BWFVY?=
 =?utf-8?B?NzRpUmxvZGFQUmZnZGdiZTdHL1h5R0dQcjRMUXBTa0hXRndCbnBsR08xTFZr?=
 =?utf-8?B?ODJvUTBWOWFlWFVOdWQ5bndLRk54S29mTWlnWHlCNnFMbHZwSHRKSVc5NlZl?=
 =?utf-8?B?WXlzWlhoZS9ITzluTUNlZ1VreGVGazRqZUsybzhIbTUwNUltNVNRUWE5anl5?=
 =?utf-8?B?Yk5BU2RCbU9iVVlLZm5yeVluc2o1VG8xYWlhd0xTZEt5NDNNWUFOOG5MQlBa?=
 =?utf-8?B?L2ZoMjlPWlQ3YUlXdkoyRnlZczNQVlRvYWV3MVhielZqRU5xZnorRkRNMmls?=
 =?utf-8?B?US9TZENDY0p3SEVoOEJEdS94UVg0Qm5uOTVWa0tRbU94bThCN3d4TklzM3N4?=
 =?utf-8?B?a1BGRDJJcWM0cTlpcEU0MFYzNjJYUnZ3T3B0RGhiSFNEWmJuNmREbWZyZHNh?=
 =?utf-8?B?UHZmeXJRM2lDVVkvS0paREN0MFpYQUlPT1J6ZHAxRUVNcW42aHNUOXBjSDRL?=
 =?utf-8?B?Q2FwUCtSeUM1dG5BU2F1QklFU0dWemtJenJtNEVLMjRvNTNEV1A5bmY4UGdl?=
 =?utf-8?B?UmpPN2N1YTcyZEhmMnVJOFdTU3NpamJXNlp4aW56NmN1MG1haDRONU40UzBz?=
 =?utf-8?B?Z3prSUtOY05uL3Vsam14SnpmU0d4WHZ1b0Q1UklPWmNuaVBMS1VnQVZjN2Vn?=
 =?utf-8?B?UUpaMTQyY29UQmxJUUQxd0JuVkNPR2pQR2dSSFZ1K21HeWlqN2g2Vy9qVk8r?=
 =?utf-8?Q?mvOFOWgzSoeMPHFSBQ1m/Z2Joqyb99z+?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7461.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFhDU3JzMUl3ajFHRzlYclR0NThTU1UxQVcwOHMxOTZheWNCeHZvVlpDK2Vy?=
 =?utf-8?B?ZXRheGJXT0lWTzBzMTIxZUp6OUZ5N3J0UzFDMlRHOThoMG5obS8wZno3Vyto?=
 =?utf-8?B?a0ZoUnUyOUpCSS9hb1hYMGdxeXVOWUhZZHp3Z1lNNU10aWVlWXp2aVk5Y2Zm?=
 =?utf-8?B?L2ZOc1lmYisyQisyeGswaVhJZDNJdmtBWjhYUVdwR0N0WTA4elV1dUZhTHMy?=
 =?utf-8?B?d2tXb0NkMzBEMVRyMFhVUUdRelo2TUJjQ2xGUHptWkkyaEQvWU1JMWc4WmlK?=
 =?utf-8?B?cnNLd3JnbkpaS3FYelJDSXY0Q3d1NGFaYTJVRlRjOFltRm0vdUs4R0xJYXpl?=
 =?utf-8?B?cEpacnZYYUNhL0o1R3FsWEFTS3h0cWVEY0FPSUdYT09rZE5lSDBKOWlkWVdk?=
 =?utf-8?B?MFA1YXBjVGVKeFhndGpJQ3Q4dkkzLzYvYU92MCtUd3RTMVdJMGNLdnRnNU9J?=
 =?utf-8?B?eG8weHlCSU5KQVRuY0VtNDFpdUhJbmtWOURUWCtIbmpwd2RBTnlPcnZubTBW?=
 =?utf-8?B?Y3RvVjNwVDFCOHlhTmVJUkNmWUIxSTFyWXN5VllHMVlGbUdOd3ZpZE5nUEx3?=
 =?utf-8?B?eUQzcUZDMWxKenVWTGxaLyt6NEhzY0k4QUZORDZmVlV5OXA5QXdGQW40N3NP?=
 =?utf-8?B?eUo5RFM3VkV6Y1MvQnZZTVRBZlVHYUttSi9QRkYvcTFzNXdibjBXTHk2OGVh?=
 =?utf-8?B?MjcwSC9iWWpydnROVmhPZFY0L3NHVHBxaHNSeU15N1RQSDJPY1BsdVBTN2lr?=
 =?utf-8?B?Ky9RZ1MwcitYRThvMjJkelN3WlhNRjhDMlo4eVJHS3ZSSzFHeG0ydWxoSVc2?=
 =?utf-8?B?YWpWVmdaOUp5V0J6T0JIK0RESkpITEJMcHdybUMzd2diNzJjT1pOUTVmODlq?=
 =?utf-8?B?aUpjVDByeERnbEtFdjhDVmJKeWo5d3oxd2N1YkdvaEZ0WlhkbU1MVXlxWCs2?=
 =?utf-8?B?WmZGY3QvOVRvTTRQaXI4UUpBRFo3dG5pUjNZNm01UnZic2JlVnVmUzVKNDd5?=
 =?utf-8?B?enNKTmIwOUcwdHovK1BpUUMvKytmK0pSa2ZHTndTSWlpOXJwU2lFL0p5cWg0?=
 =?utf-8?B?VisxN1FtcWNEYmFHbUhxRUlmZjFJR3V2LzNDanAwNzBYR3FDenExMUlzQkJQ?=
 =?utf-8?B?Snhia0xMaWpSRlZCRzBEem1sVVFFQ0hCbzVBeHEwTWUzWFBvYk1PWnR3TGMr?=
 =?utf-8?B?bUdzOUFWUmFJN0drczFzWlc3TnpFS09vY2FkOVRoN0FFazJJUW9KdkhoMEVq?=
 =?utf-8?B?Rk9oMG15Y2lhR1JmdDFmckVLRnRGRmM2dk51eTRqalBLckFJVFpmZzhTMGlF?=
 =?utf-8?B?bFJVYTBiSzRveDN1Q3M0MDA2Y3FaSGx5OEVYTmJrTTRwb0E4TkZ6bWt6NXdt?=
 =?utf-8?B?VUxXZkFpYUtDZmxmSXhMTWJyc1I0WW1TQTk0S2xYcm5ydnZneTBzdTg1blpC?=
 =?utf-8?B?bXlTM1NlNUhxS1NzUGE5ejZoSDUyb1NQRTEwZ014UmdFQitjak42UkhOUXQ1?=
 =?utf-8?B?Y1FvMGxlU2QrdGxDd1VFVFlYcS9tOERBblNmcmVtNmkyQzJOZ3lldldsR25P?=
 =?utf-8?B?SVVFOXB2ZVBIcW9LdlZlV0MzTTZPS2xJMVJaUFBiNGNFU29TeHJDYU5CelJU?=
 =?utf-8?B?amhMdnppNjFsOUl2a0l2S05ZdEVpQk01OHd4MytvSTc1eUxLOHZ6QUUvWTRY?=
 =?utf-8?B?OFZsdGFuVXpNWURta3IvQlN4OGJtTTI4NDJBamJjdDNrczV3aW14SU5WTlFJ?=
 =?utf-8?B?YjcxRlRNWXMxSFFpYk0yWHQ1MnZGekZ2MEZoSGJWcGRkSWZ1c0QyL3NXVUV2?=
 =?utf-8?B?SDlrSTcrNU9oQWxPTTVwMWNWZmRtdWxKUEpIVG0xQXZGZFMra1A3cXdLNm1O?=
 =?utf-8?B?WlhkNUIra3h6T2ZyZk5oWE5JYkpYTHlRY1hEYVRjQnZQR2xQMlBTYVdUemo4?=
 =?utf-8?B?TW55ZDBkUjFSMVIzTFpINUJTOFhKUE5YNWJWTExoQTJmc25KbFFnTnpDNXNC?=
 =?utf-8?B?dWxpUjFCV09nOWdiM0NPT0NpUVhuTkVrQVV5eXVBcFpRS0l2OHY2QzNlcm5u?=
 =?utf-8?B?K01nZGdaSXIwUWdBbzgxVGN3c1RXeTQzMWhBL01lekRORVRmTlRPaEtqdGNM?=
 =?utf-8?Q?v7VtX4rc7U8bo8mQKXqhrfVTT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f611dd2-567f-4edc-a9ba-08dd31ed4d9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2025 03:09:03.4844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jkrzsvyNcWWGH5yLLhIig/15qvoMA9JPcNFN2SpVBgecVmiEmTG8fcOne3Ex99tUbcAq/4aDewOZ4Kq+ycy/Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8176
X-OriginatorOrg: intel.com

PiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+
IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAxMCwgMjAyNSAxMTo1MyBQTQ0KDQpbc25pcF0NCg0KPiA+
DQo+ID4gQ2hhbmdlcw0KPiA+ID09PT09PT0NCj4gPiB2MSAtPiB2MjoNCj4gPg0KPiA+IDEuIFJl
c2VydmVkIGN4bF9jb3VudF9yZWdibG9jaygpIGZvciBvcmlnaW5hbCBmdW5jdGlvbiBpbnRlcmZh
Y2UNCj4gPiAyLiBSZXNldCAnbWFwLT5yZXNvdXJjZScgdG8gJ0NYTF9SRVNPVVJDRV9OT05FJyBi
ZWZvcmUgcmV0dXJuaW5nIHRoZSBjb3VudCBvZiBpbnN0YW5jZXMgaW4gY3hsX2ZpbmRfcmVnYmxv
Y2tfaW5zdGFuY2UoKQ0KPiA+IDMuIEFwcGVuZCByZXN1bHRzIG9mIG5kY3RsIHRlc3Qgc3VpdGUg
YW5kIFFlbXUgdGVzdGluZyBQTVUgZGV2aWNlcyB0byBjb21taXQgbG9nDQo+ID4gNC4gUmViYXNl
IHBhdGNoIHRvIHY2LjEzLXJjNQ0KPiA+DQo+ID4gIFt2MV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvYWxsLzIwMjQxMjI1MDgzNTM5LjIyMzAxNTAtMS0NCj4gaHVhaXNoZW5nLnllQGludGVsLmNv
bS8NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEh1YWlzaGVuZyBZZSA8aHVhaXNoZW5nLnllQGlu
dGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9jeGwvY29yZS9yZWdzLmMgfCAxOSArKysr
KysrKystLS0tLS0tLS0tDQo+ID4gIGRyaXZlcnMvY3hsL2N4bC5oICAgICAgIHwgIDEgKw0KPiA+
ICBkcml2ZXJzL2N4bC9wY2kuYyAgICAgICB8ICAzICsrKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQs
IDEzIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvY3hsL2NvcmUvcmVncy5jIGIvZHJpdmVycy9jeGwvY29yZS9yZWdzLmMNCj4gPiBp
bmRleCA1OWNiMzViNDBjN2UuLmQwZGI5NTRkYTBmZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2N4bC9jb3JlL3JlZ3MuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY3hsL2NvcmUvcmVncy5jDQo+ID4g
QEAgLTI5MCwxNyArMjkwLDE5IEBAIHN0YXRpYyBib29sIGN4bF9kZWNvZGVfcmVnYmxvY2soc3Ry
dWN0IHBjaV9kZXYNCj4gKnBkZXYsIHUzMiByZWdfbG8sIHUzMiByZWdfaGksDQo+ID4gIH0NCj4g
Pg0KPiA+ICAvKioNCj4gDQo+IFRoZSBpZGVhIHNlZW1zIGdvb2QuDQo+IA0KPiBJJ20gbm90IGtl
ZW4gb24gdGhpcyBmdW5jdGlvbiBnYWluaW5nIHN1cGVyIHBvd2VycyBpZiB3ZSBjYW4gYXZvaWQg
aXQuDQo+IEluc3RlYWQgeW91IGNvdWxkIHJlbmFtZSB0aGUgaW1wbGVtZW50YXRpb24gdG8NCj4g
X19jeGxfZmluZF9yZWdibG9ja19pbnN0YW5jZSgpDQo+IHdoaWNoIGRvZXMgd2hhdCB5b3UgaGF2
ZSBoZXJlIChidXQgc3RhdGljKSBhbmQgaGF2ZSBhDQo+IGN4bF9maW5kX3JlZ2Jsb2NrX2luc3Rh
bmNlKCkNCj4gdGhhdCB0YWtlcyBhbiB1bnNpZ25lZCBpbmRleCBwYXJhbWV0ZXIgYW5kIGlzIGRv
Y3VtZW50ZWQgYXMgdGhpcyB3YXMNCj4gcHJldmlvdXNseS4NCj4gDQo+IElmIHNvbWVvbmUgd2Fu
dHMgdGhlIGNvdW50IHRoZXkgc2hvdWxkIHVzZSBjeGxfY291bnRfcmVnYmxvY2soKS4NCj4gDQo+
IElmIHRoZXkgd2FudCBhbiBlbnRyeSB0aGV5IHNob3VsZCBjYWxsIGN4bF9maW5kX3JlZ2Jsb2Nr
X2luc3RhbmNlKCkNCj4gDQo+IEJvdGggY2FsbCB0aGUgc2FtZSBpbXBsZW1lbnRhdGlvbiB1bmRl
cm5lYXRoLg0KDQpIaSBKb25hdGhhbiwNCg0KVGhhbmsgeW91IGZvciB0aGUgZ3VpZGFuY2UuIFRo
YXQgYmVuZWZpdHMgbWUgYSBsb3QuDQpJIHdpbGwgc2VuZCB2MyBsYXRlci4NCg0KQmVzdCBSZWdh
cmRzLA0KSHVhaXNoZW5nIFllDQo=
