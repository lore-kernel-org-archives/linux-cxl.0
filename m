Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F619192D8E;
	Mon,  7 Apr 2025 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743990781; cv=fail; b=FtIWaxnIQrbyUs667jZOdr/Pb5gvcVGp9IzA9hBG3v7Jc4i0d0VXRqIap6mONVVVZ+EWQmxrYyostpEOJ7/30nSYMfq0mWBNNdCzdjbg5HQbAIbE3Xn0EpcYT6h4TqpKU+vCdx0bwwHow0O5zuhqBz2zYxlENeje6JEy695U56U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743990781; c=relaxed/simple;
	bh=QAougaxMCj8F3ImM9CWxJQL/TtBknahoxJa0WUvTi2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=miUi0F7ABL7G5q3xXu8V+XN/b2p3RdaHucYMqojq5z+Y2pOzoVgSaJZ87sM6IHzH+eh/TXcQk9jJ95BCuUEjBTqnVf04jLwQZa0MP4OMsdRXpq8n6HI3AHIRX3dJ0uE4Rgpc5XCqVTZ4og8rysiaowI5/xexwubaiKyFRFYQyVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=i1v48Eek; arc=fail smtp.client-ip=68.232.159.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="i1v48Eek"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1743990778; x=1775526778;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QAougaxMCj8F3ImM9CWxJQL/TtBknahoxJa0WUvTi2I=;
  b=i1v48EekUG1f9tphYg+4WNmVTYO5UPL3hsqEpx9EPM1Iiqh2B1FMyXKT
   +cQpwHMynJQwTa6xllGgZrSiKXyWnvBPoQh2WJoKJXQlmppkywcrlL8tc
   LacPOG1cpMxv5pxnV7APedCygu6h8y1vbZwN1nFQvHDw28wz3OASlHfz0
   63fKQaI+pZT4gt/N+G2FicFje/KdewTU9GoXhP8yjbPKrLoXWreuD1ISK
   8GrOLUNLgSV/3P9/3CJO/KEQSIuGGSjZpl0PvxxNVAPk+kgUoA6vJh02T
   w9kdSN0SfEpROCzmfpE2csBHsuAGGUw/5VoGxkWtZ+ByxhfuV7FftwyEp
   w==;
X-CSE-ConnectionGUID: Ka3jj0U3RDuCEaluDYQsTA==
X-CSE-MsgGUID: b6DAE3gpR/6j28j9d/wDFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="151969973"
X-IronPort-AV: E=Sophos;i="6.15,193,1739804400"; 
   d="scan'208";a="151969973"
Received: from mail-japanwestazlp17011027.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.27])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 10:52:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Unk7J+2nlRwiYohjy/AiIBDB7t2Dt5/hsD+AW4ET2jlhW1uD5sKnCrdAxN7lNCyIZ3EV0ux2ET5bAqKRedpLMVX5l9diBIsnb/NZGaLJQ5lQNPG8Fwn9M6u/5sFrJhr93mrVU/TB6/S+dsXUfXDR8ryiy5Kg+WDYgIZe9pbzxd83bgmgTqYsXD4HIMbg7tC2Dso6exj6ftJp4YtLb5BlOqUUtjG8h8CxTBCN4jGqpHJbnTHmlk8prJ/iwyH6YbOpOn7oqeHCp+JFgHqm3Lr+BeUzu1i+V8UVkCs0Dgj7iJxkBPzPzPKZWibzyO/9uU+ikX++OwTwahj5hnGTnfLkhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAougaxMCj8F3ImM9CWxJQL/TtBknahoxJa0WUvTi2I=;
 b=xHzxhkUga3b2ih5auk6L4SaW5LYfH7A1IOMtFFjO1UrQ0A/1MTQqLcwP0hC12xjHyPb4jOUPRoUFcaETHL4+lUI8A9mk1G2h97QOl06uhs8B4dJyryQaKU3XZtqLUjyTQH4q5ZU6BQHYTgT3aWq7TB1+Mw164JXknbZyIQ882/v4IzaKOmViq/HcP7+UdTid4lJezkpH1lNpEcfeo951RD3on0jqpT7fBCf2YD0tDFtPoqJha87I3vOgec7zmFI2IbbwBJsDAt7DeU6fAPcwVmXoq6EvGLsZv13edPwEMKb3gwp8VYdjYwVqj5V/ktAl9nxuygd1dD1o7o694dM9+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS7PR01MB14335.jpnprd01.prod.outlook.com (2603:1096:604:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Mon, 7 Apr
 2025 01:52:41 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 01:52:41 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Verify CHBS length for CXL2.0
Thread-Topic: [PATCH] cxl/acpi: Verify CHBS length for CXL2.0
Thread-Index:
 AQHbniL/JoX3x8SxXU+HvSvJEGqce7OGWN8AgABC9gCAAGJBAIAA9aMAgAuh54CAA+2UAA==
Date: Mon, 7 Apr 2025 01:52:40 +0000
Message-ID: <cfd77ff7-8dae-4994-affb-d2cdaaace33a@fujitsu.com>
References: <20250326074450.937819-1-lizhijian@fujitsu.com>
 <67e4c9aaedd08_138d3294ca@iweiny-mobl.notmuch>
 <1ed912df-42c7-4319-8765-3167963df7b3@fujitsu.com>
 <67e5544237027_13cb29432@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <7bbf602d-6900-4179-9737-efeb40e1566f@fujitsu.com>
 <20250404145331.00001559@huawei.com>
In-Reply-To: <20250404145331.00001559@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS7PR01MB14335:EE_
x-ms-office365-filtering-correlation-id: ab542391-50f8-4957-5bcd-08dd7576e1a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZDF6TEFUenQzd1cvRmZXY3grdzRhR0J6V1FLRUZsZktXY0VaaEkzTkhrNmV5?=
 =?utf-8?B?bTFnZUlUK1lkZS9ld0dwekdRZ3pIQTJZRDBNc3FnWnBRK0t2M2hMc0VTRHd6?=
 =?utf-8?B?c0dRUDVvdXRRMEI0QWVDbXFoS3ZRNk5BS3JrdjNtUXNIbXRpanBVM0N2aStQ?=
 =?utf-8?B?RXg3K0tHYUpwMUduck8yZjErS1pReUZVL1p1eGNZbnJiZG1tQjczTjlLQjQ1?=
 =?utf-8?B?VFlORkk5K1dHd01SdjlUa0E4cHBjci9QWGFtNW1iSVIwOUQycThWLzR6WHQ5?=
 =?utf-8?B?eGUyd2tlVGxDV3RWSEw3V3hNKzVrUlNIWUZmNUViSDJxN1JlVWhIVDk3RndN?=
 =?utf-8?B?amdYMEZROWMrY2JrRXJ4MkNhRFRESEhrRXowZU81Nm5RREN2NkU2Q1hpLzdk?=
 =?utf-8?B?RHV0eksrRWYzZHEwZFNRNlFMK0pwUEVyNDU0dXBBZHZOU0x4aEN1TG5WVVky?=
 =?utf-8?B?SC85blBGMzV3VFJMSDIrTXR0MytQRTRNaWNZczZCZytMUGlrZjQzaG8yYUpC?=
 =?utf-8?B?a0RmWnIvUnJXQUhaMzZWMEEzQ1VrUXg2ZXJ6YjhnV245cHRIOHh5anZWaGVW?=
 =?utf-8?B?bG5maWJRNmJ5NU9mL2FJaUQ2YmNFQkMyRmlJZEdkYllUVFQ2bXJIc0R5aXRV?=
 =?utf-8?B?NkhYSzRrdGFNclBWTCtDVDU0REFzSDVxVGJ4YWhyZWt0RjdmQUxWaE5iM1ZB?=
 =?utf-8?B?Z3JWbG9rbHRqa0NUZXJHVXUyZWVPR2FqTUp3VU9GV01FSDFobGQvY2FpTGo1?=
 =?utf-8?B?bGRFRTlMMncwVnBTOHovbjZnbTg5NDZzZnk5cGxJY3BwMHRpVlN6T25ybmxZ?=
 =?utf-8?B?SG5URjZzK2kyYkkyOUFRdFdDMFNUUmQ0bzhzVzlncW9aNmN1VUpaQXdLRFhQ?=
 =?utf-8?B?TXpSWGtrMkIwaytGbVMwYXowVEo2SW15aStUQmY3UW00UUZYbE1ldEcyZ1pp?=
 =?utf-8?B?TG1ZYWpEN21JeXE3V09tenlzZ0F3am56eFgvZkJldnhPdmIvSjhQam9HNFcx?=
 =?utf-8?B?V3VyajFDa1M0alo3REtHd0lETkNJQk9xRml1Y1NFNDZOWW11MHZ0dFNNWCtX?=
 =?utf-8?B?WWxTZEpYZG50K3I3NUpmTk1mKzkweXNwdXFYeUV3Skl0SEpPQnl2OXNQRUdl?=
 =?utf-8?B?Ukt0eDU0TGNIN0JKOUVrTWxheGJUTkp5UThnSVdScnphV2lTZDAzTitNL0hQ?=
 =?utf-8?B?NDVtckxiQjVicmZUcDlyMUVTV2NjYWJFM3JSUVJNY3BVTzRZc2tDMm1OMFpT?=
 =?utf-8?B?MWkyc3RQeEQ4YUF2eWNPSURha3BBaVdxSmhqVVhWRnVhejJmdFF3Y1BlSlUy?=
 =?utf-8?B?VFdRT1doSVA1MWU5ZEpEU3IvVXNHN2ZSNHpCenlraE10aEdyYkVHakR0TFpn?=
 =?utf-8?B?TnJBUjBzQXc1QUFlc3N0SWkvaTlDZVhEWDFhSGcxMVFEYmpFbzhaNy9qb2VO?=
 =?utf-8?B?QURqZ2Q5cktNTmozVjd4dy9SNnZJSlVIQW45Ni90cGQ3d01Gc1VlWUtOMFZr?=
 =?utf-8?B?bThFdEd5VlMvRFZsS0pHa1dRN0JWYWE2Qll5RDd4NEVlYU9kWGRmWit6UVVh?=
 =?utf-8?B?aGxjNDZlSks4Wmx6bjM0aGNzMkZweUE4azdKUS9lOGdRNFVrYXdFUVg2N1M4?=
 =?utf-8?B?UlhWMThBeTZjU0ladXUwZnVvNEpDSzRiSUt5VnBHMVpNcmwyZiszTFduaGxP?=
 =?utf-8?B?UFU2a0o2MU43NXpmeEZRc0RWRXhSdHl0cStRMnlYUTI0RHhXaC9Ia09lQmtm?=
 =?utf-8?B?SkpTOE93OFZRR0RndE50TTZoRGovd2V4Q2h3R0xWbDJDVkVnUjNzUUJHbWoz?=
 =?utf-8?B?Unk5VVFqRk1zN09zdmxiU2F2UzE4ZENaZkxpRHZZcnA2aGtMamFxNGU1ajQr?=
 =?utf-8?B?cTlINTViVWNUbmw3LzZPdVVRTFQ3aUxuc1NXQTdscEZKY0dzbHFtcmI1ZWNX?=
 =?utf-8?B?UlBSMWU1NlRjSWkwMkc0SVVQTXl4V0xsc1dSRG41Z1hsMU9YWlJpK1NLR0E1?=
 =?utf-8?B?MTNReWZEamVBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cWFSMlE0MzhTMzhwQlVYdlZoRzJhdEVrZWtCQlI0ZFdJS3Z5aGZYRXJkdFRW?=
 =?utf-8?B?NzlFVjRCWUN6T2NQWnJkdGhNOUdOQlQxeGYybmdBVjg0ZUxZZVdhb01nWWpI?=
 =?utf-8?B?QTNqUkNrVllQT01tRTFlekdoclBNMUdBdG5QeGhXNEEwWDYxK1RoNVpJNEZ0?=
 =?utf-8?B?RVI4dkZuRVdPTnJWUHBFdVFacGk0VGtFQU8yVTNhU0FpQ09XcVkwZERIbXA5?=
 =?utf-8?B?R3BCVUZvOVNUVVJDaVZDdUt3dFpOUVhHUlRpMG0wcHRSV0xFaThxQjhpVzd6?=
 =?utf-8?B?c2sraWR6eG9QQzlRUnlqYm9OT1FkUzRBc2ZpMXNwWGdRLzJKRTdvMzlTc1ZY?=
 =?utf-8?B?RWJXMDZFZlhTQjAwZkpsVUhXNDdnZ2pJalcrUTlrWXZqUnN5VnJ1eVgray9k?=
 =?utf-8?B?bkNYZEx2NFdRcHoyTzhmcUhidnFaandLZm9ldWJDVjQ1Wkdkd2ZxeW9LV3or?=
 =?utf-8?B?SlFOaFJmcTdoT1B1ZzJZNkJSaDBmK0NybnJaZ2pqYXptdlcxNjArR2xhZ1hN?=
 =?utf-8?B?Z0Q0QXhMRlkxMTViZjU4aTZWcDFLWXd5SXcyTlhIdnI5OHJLMms3cUxrNWdX?=
 =?utf-8?B?ZDdFRktPZzFQQ2JCRkprbHovSzd0cVpVeC9CLzc5eHB2c2pUVURyd0M3d254?=
 =?utf-8?B?UGU1MzNCbXlaZFR2Y0lEMTFkb202RjN0WDd5aU5rNkJSdWRML2dSNEVqOVRH?=
 =?utf-8?B?VDZzaEVmNFdLcGJjMmIvRzBqODFBb2VxVWR5dzJCbUpVaE9NWUIrN2s1bm5p?=
 =?utf-8?B?SC9EMmovWnI4Vm40RnJyaVArWlErVjdNeVRPWkZNUFFGMWc4NUdXNm5vOERF?=
 =?utf-8?B?MW5YekJRNGhUSEl1MzlxazQ0RnYvUWMzNXZzcmRnbklNVkE5UnQzeEd6U2hz?=
 =?utf-8?B?bWZnc3FSajBVbW5FSXBjeU9SY0IyWmR0V1ZVQlBaOFpwTVR2bVlBaGY3UUhy?=
 =?utf-8?B?ejlXdnNOejRSbmV1ZHNNa2s0MEZOTjd5WnNoeXMwZGlaaEszZXJEdjFrQmhY?=
 =?utf-8?B?S1lycVg0Y0ZYcnAydk41M0o5Nm14ZTFwVXNHOUFYSFpOa0dzSHZQb0djZUZi?=
 =?utf-8?B?VnFIOVNreUR3L2hiRHpWQ3JrQXNZekZKOHdvdmk4b0NkNVdvSGNWeDdmc1Iw?=
 =?utf-8?B?Q1VsM3V5UW5BZ1RXRjR4UzA3Vjc5RTBSTEg1NUhuWStvSEp2NHcyMFh4S1ha?=
 =?utf-8?B?STRXdzhPaG5vSUdxTUtGYnVBMkRhY1g2VEgxRU0wMURsMlN1TGltT0NEWVFY?=
 =?utf-8?B?RXF2L0xLTW9iaE40MEU0Y0FvbThTM1NSRGhsaUJ0RDhsVkhqbngyQUZpT1JI?=
 =?utf-8?B?Tk14WVFoY1ZobzlaYXBzRVhDRU0zMGN4Zm5aSEJOSS8zd3N4djAwNlJickY3?=
 =?utf-8?B?cTBaYnUvOUtRSzhhaWJEZURlWDN2NU9jMk43SStxVVJtOXM4bEtMSytTY0ta?=
 =?utf-8?B?OXBGWWdua2s3Mmt4d1JqWXRrZVNTTHBmL2RoR0I0bUNadHRSSzg1R2srZXdJ?=
 =?utf-8?B?czlqcW1BTFdsU21rVW03MGI3M09xR3NQM0RBMk9yZ3dhK09TbDdlVGdmV1gy?=
 =?utf-8?B?QUlyZFY3RklIT3pQVmtJMEFXZytnTWkwSGsrcDdXV3F3T0c3UG9Bby9KbUY2?=
 =?utf-8?B?Z1lpRC9JUzlFYUpjZHBBNzN2aGFCNDRXVEZ2T0JvVHlSY29EY3dsM1cwR29K?=
 =?utf-8?B?Q1RsN29OK01ZZkIwYjNYcHdxUysvOFlzMk1VZlZ1bDRsRHhERUNXdEZYdjY2?=
 =?utf-8?B?Y2dwcERaTlhsb1RzODlpSVRha1FSMzJMTktGUm1LaitYVHlkY0k2V0VtU2N2?=
 =?utf-8?B?aTR5NHpUTzlDNE9lY0NyYmRxeEpEa2J4dTVLN2dLYm1XVTF3Q1ROSWpaVjQx?=
 =?utf-8?B?dHhadFFTNzRleCtJdVVZUEFVOG5MbkFtN0pmdk1HZTA5U2RvbytYZkZ5UTNR?=
 =?utf-8?B?OEdEUUtOVmhJMXFpMit2aVRId3Z4TElVZ0VkN09temRQeko5OFp1NHVQVDg0?=
 =?utf-8?B?MmZrUXd6R2lKeGh0Y2dVejhhRWkvYTNRK2Rra3JFYmNaYlY2Zkg2UUZhNjg1?=
 =?utf-8?B?L2tPN1NBeWNkcmVzS24xT2pwTldhZE96dU1WamUwVjBORE50aW91Wm1VOG50?=
 =?utf-8?B?K0syYVdtT243QXpPY29vYUUvMGxkek5WVXhzVXJIbGlCY0NybjU2cTh5K3Nh?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <831E3D9C894372418715D258C86C8213@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+tgHYvLQlTA1WdVRktOLd1CzEj9g4spEBHl5/qurZfN4Vt+tuOkB1qRS/TpWmU3yjNCZxpw2uY/EzvO4JsCL5PzR4UUeWAWP4GlzwQ1MxeZrqksQPQXyliY5Zt9wCl++lzFsKnXOtkHCMlaEskXthWk+30QoeWFKm8pcmsqc/wB628yS+C72tG99tq9nO/M2xALsp281vgWMBQkcfxsUv940hUAtUna+BZAPOD3m8KD7MbxTjMg37ePRrGF6s6fUGylMFkqK6kM/adoTK+ikDW6GlUZT44jKBQGbemyBpr8ysAnMz6nH3TO8ihyynePebfmuhkcVSqa3f7XI+SN4VcxGlsNBqUtF3OCTAZrehJiTumNeNgdCBsbGSv5NIZ2X3p/l1Tw8iv8RBtWXi4gARcSlUk/CP24e09d9kpnDMu6Hi4HoMLJwq/1Vl3Z4WthehSXGNxg3Mz4BD86Qbusbn/uDKJfp1ZzfKC1+FC0GroOoTRscYMvoL1RT7Xweb1TZP5gavn7cDuRnxCWoP4BhIztDW/8bCelnqvGPY6gkrDNdxTKqAC+mheu9nBecVg46+eCo/eEOy1eOfX0jWlphpTClnUO1Atqio9PY2pRh5rhqZHYIdrdE2AXYO0aoMwbm
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab542391-50f8-4957-5bcd-08dd7576e1a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 01:52:40.8238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +7ZnM2B6Y562AHJRW9CrjA9IxPmPxqimurFZdNCvqx5A+WAoa6rDl/v23fUX8JvmrRfGq7ecFka19A4ucSzsXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14335

DQoNCk9uIDA0LzA0LzIwMjUgMjE6NTMsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+PiBXaGls
ZSB0aGUgaW1tZWRpYXRlIGltcGFjdCBtaWdodCBiZSBsaW1pdGVkIHRvIGVkZ2UgY2FzZXMgKGUu
Zy4sIGluY29ycmVjdCBRRU1VIGNvbmZpZ3VyYXRpb25zKSwNCj4+IHVwc3RyZWFtaW5nIHRoaXMg
YWxpZ25zIHRoZSBrZXJuZWwgd2l0aCBzcGVjLW1hbmRhdGVkIGNoZWNrcyBhbmQgaW1wcm92ZXMN
Cj4+IHJvYnVzdG5lc3MgZm9yIGZ1dHVyZSB1c2UgY2FzZXMuDQo+Pg0KPj4gWzFdaHR0cHM6Ly9j
ZHJkdjItcHVibGljLmludGVsLmNvbS82NDM4MDUvNjQzODA1X0NYTF9NZW1vcnlfRGV2aWNlX1NX
X0d1aWRlX1JldjFfMS5wZGYNCj4gSnVzdCB0byBjaGVjayAtIGFyZSB3ZSB0YWxraW5nIGhhY2tl
ZCBRRU1VIG9yIHNvbWUgY29uZmlndXJhdGlvbiBvZiBRRU1VIHRoYXQNCj4gY2FuIGdlbmVyYXRl
IHRoZSB3cm9uZyBsZW5ndGg/DQoNCg0KQSBoYWNrZWQgUUVNVS4NCg0KDQoNCj4gDQo+IEpvbmF0
aGFu
