Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFB93D69
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jul 2024 03:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720407924; cv=fail; b=KTzGPHHAjao3zVQQ1XIE2lBI9lqUOq3a4sNjJinBIR9nefuaqbHZnldkUkhYFs00c1xj1TVIr6r0VL6/YI71axl2AOlhv76KxPhE5yR/6SiJY9uvkunf/ft6DJMF2fx4/CBDRtbzddjjCmxDEfweXHawI6I33mvzHprAF9ulmjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720407924; c=relaxed/simple;
	bh=nDEeGnCVDSJGbYMizfZAlAbuKxCxCMgq1NZJSqKk8Fc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fdjrec/mYekScvUHmekqt27fTfNs4wVGz3oZAFIFy5+uBFSjCV3xXIFX65s/OLniufaT6G78kxp8kz9wF6AtR/xxqOQ90tL0LO5Uh8sQz+6pzdTxRyR0chUvpFKxrRh5LW9io8ASEagQQHNeDhwZgWLYR1e0rlVfRPLn9ionAj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=GQktRvRN; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="GQktRvRN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1720407922; x=1751943922;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nDEeGnCVDSJGbYMizfZAlAbuKxCxCMgq1NZJSqKk8Fc=;
  b=GQktRvRNiIfMfK9cBskJS5eCisDwr5WURBaVKTPCkIZhWEF3wgF8GifM
   tokPBUi0fX7iQs3//hh4kqRRBPZimihkCu6aabNeDui1ttgOwygr7WXnn
   J1lqOsjwPcsTut/AId2URSXPpihqzcDhPa/0wRJA06EYw92SEwosDgqJz
   iifpwz6AEMhZWbGKZXSfPvGi8unrd5ZdWXItCw25WFY0HBpHo0bb0ALgm
   q1mqYEoZu8fXbqFk3WnPZoBjw0pos6RXV2/iVEurdiy7xL2bcqonMud70
   cEWNyRKtzq7Ly0npJYPx+fEXO9Vzux4tTN/xzaEX+QgYN+GE2CU/XJkEA
   Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="124025980"
X-IronPort-AV: E=Sophos;i="6.09,191,1716217200"; 
   d="scan'208";a="124025980"
Received: from mail-japanwestazlp17010000.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.0])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 12:05:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGGEO57sJ/QeUo5U5G1ifXDVgip8jFymQ2wPAXn0iiDHzvG/wzyzz+seKO+0xqPEPXXulPjiGrQS0Afzs3oTOB5b51rDC/a7mdUoOR1AG44uOLxlDrGyHlee2yL+ldY/uZ7PC/aW07HI/Wrtw/PZFJFfulQECS6FUStUg03cIGwvBkgF91LrHPudRuMW4+iCa9i/qMOAMOG+CeoX1+U1JBTByhq12q3vY/xigUcWqsE9Tg7RFvwvyWt/qpCQMbp42llpOUD4zbsi/x8HM9O3nP2rmg2JGWbaGfK7txcpiEj+pAVEiyKgLnXzuW7a2xRweO9EqOObCR2RfS0zNS0CLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23i3w3HMvWOu9FBKSa5lkq+6nK0SqzjZs7N1N9xwWtI=;
 b=jVJficNmJY9/+eyAMSiJWQnr8KE0x/wAJ1Qi1task+DccBid0ohaalV/ors7frpxoMTcVEkohenhL5rF+6rQjeCA4C/s9mjLQwY0b+mFqOMbK8HJThgZ+S2ry68duZVOiXUioVdXjk1mTmHLMioJRbSYP6D3c4v4gdwviOmDy6PtmlD7iZm46ZJG2A+aPJhs4gHdGf90SPanMpbIuTmwf52BiZPVe5h8b3j7LdOQgQe/6/eH3VNpYy1Rn/oq3Arfa1RYzJQV4L8C+n+ncnA/+wQdbKLZs03d0JdkRlST9nwrd0r7kInU9JgyQUCHYrPi1OxN3ppr2qRroD4JU6aHVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TYYPR01MB8133.jpnprd01.prod.outlook.com (2603:1096:400:115::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 03:05:08 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 03:05:08 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>, "mj@ucw.cz" <mj@ucw.cz>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v14 0/2] Export cxl1.1 device link status register value
 to pci device sysfs.
Thread-Topic: [PATCH v14 0/2] Export cxl1.1 device link status register value
 to pci device sysfs.
Thread-Index: AQHawTfBafIA1J3zbUG5l0nqYOxKFbHsRIdg
Date: Mon, 8 Jul 2024 03:05:07 +0000
Message-ID:
 <OSAPR01MB71825385034CD33C732EB878BADA2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240618042941.96893-1-kobayashi.da-06@fujitsu.com>
In-Reply-To: <20240618042941.96893-1-kobayashi.da-06@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=31b81284-b420-4322-85f2-00eb3938977f;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-07-08T03:04:07Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TYYPR01MB8133:EE_
x-ms-office365-filtering-correlation-id: b50e872e-33c0-4d72-8d57-08dc9efac5f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?SUl2K2NIcTlVNDAvODJtWTRQYUpya3I5OTQ1TzA0WTJCajcrNFE4MFFU?=
 =?iso-2022-jp?B?MUtaSXd1VTNreUZ5NnZtUGdaQ0oyaHdQK2Vsc0psMXN0UFk2T1hGTGd0?=
 =?iso-2022-jp?B?aWxPUlBocVRCczIvSkJ4ajhEaW14MUp2Mk1VWnQrdXcveVh4MCsyQjND?=
 =?iso-2022-jp?B?K1pPQjVrS3JXZmZUZ0lLSU5ESjBweDhhRHNWM1Rkc0RVU0FUOWFDUWZy?=
 =?iso-2022-jp?B?WDJ3NHQ1QjhmQklCc1l4aWhYNzBFTG9DSlVmeVFzUGFiRm9iKy96QjVw?=
 =?iso-2022-jp?B?dDhBNlRVUHFNWlIvSE1uZDhHTVhHaUFzMTNSQWM4UDB3QVRRNldSdE1N?=
 =?iso-2022-jp?B?aVp0bnJJVkVyZS8xR3ZnYnhha2tKRzJTbG5hSUE2T2tTOE1ENi9PU1lP?=
 =?iso-2022-jp?B?RmlEa1FuMklKV0FFMGFLT0JVbGp3d1UwT3doRFRQVGJlZDBkTzdHbEhq?=
 =?iso-2022-jp?B?V1daN0hsQ011ckFOTTlGVWwveGk4dHhReC9laVB2M0pWdTQ2S1ZHR1RJ?=
 =?iso-2022-jp?B?anlyR0JtWmg5MHJJeHJOdlNPaTdzNXFrc2NwYVRPNVJzZGF0UmdnWHRr?=
 =?iso-2022-jp?B?RHFTWllXNkdxY3czdHErY1hPQzhwUDBWcktNblhvdHJ4YTBodkVHU3I3?=
 =?iso-2022-jp?B?OVd1cUFFWTAxRzMzcEsyTjRCNTNxUnZRQitMeEpraGo4ZGlyVXRRdUJk?=
 =?iso-2022-jp?B?a2I2K1BpK3NJeXBrclVpbHFmbEJoczFGbk5ZSjFkRWdaVEFNeTEvV2lk?=
 =?iso-2022-jp?B?NGNpUEkwb2VoSTZENXVRcVorY3RVakdxK0pNZUNPenJwc0VXNDVxKzE0?=
 =?iso-2022-jp?B?Y0VGMjlBdHJUcHMwV05ZeU9LQmo3Q3JQS1NOallocFJTV2F3R0NPeWEv?=
 =?iso-2022-jp?B?V3NaSzlrNyszb1IvL0xJOEpXUER1TUhjaEpUOXpqdTl0R0l3aitoNDg3?=
 =?iso-2022-jp?B?UEZ3VlFWcnBMRFp1K3pCOXRRbGJXNUFzYU1ueU9YdGEwWHFoTmtTTm5F?=
 =?iso-2022-jp?B?WWphNmsyS0swMTFGdHkza2RHN1hGSjI2dkNzakwxZUQ2TnZkUTdOWlpx?=
 =?iso-2022-jp?B?bjErQUxJQ3lnVElGZ09GeXhEOEdzZ3JtMkNKYkIzWGZmK1J1M3oydWtN?=
 =?iso-2022-jp?B?UWl1TFBGRG5OamhIT3hEOG5rb0kzRGJjU1ZVQ09jNnpHUCtLdzB6cnpE?=
 =?iso-2022-jp?B?WW1NeTJWeXgzTzNueC9FSGdvN2ZMK0hMdTFnUmFkekhjNVhqN1BOYmtE?=
 =?iso-2022-jp?B?dWNlNkQ2WUEzS3REREZsRDFOODZCbW9waDY2SkE4MTcvcFZ0dE1iS056?=
 =?iso-2022-jp?B?czAwR2RadmIwWkNLYUpaSmN3N0pvczVZTUVtY2lnTW5sVGZkQU90Sm5J?=
 =?iso-2022-jp?B?NlNSaHZCWTlZaGlrZWdFRnZ3Y0pDV0JoUjVCY2NEaXllMFRGSUpQUk9C?=
 =?iso-2022-jp?B?QmluRHZpMHJyMnZSUnlZcWswdnZqM285OW9zOTVBMnZwSEFCZDYzYU4w?=
 =?iso-2022-jp?B?MEdKTS9uV2c2YXNYZTd6cEtZYUsxaGM1TmwxbURPN211QTFvSzVRNUp2?=
 =?iso-2022-jp?B?RmVVdytGQnFJWloyTTA2LzhidWdRTEd4YWVNVGtIVnM2NzFTdjJnRVlR?=
 =?iso-2022-jp?B?d3UzUzcxWUw0Y0tvQnN6WW5WbzVXNko4SHQ3WVE2ZzM3bC9pQis1Rzkr?=
 =?iso-2022-jp?B?ZEIrZ1BmaVN2Z0RLS1hBelpqMDh2MUtDNW03bWFRbC9QMVdHbjA0aDZJ?=
 =?iso-2022-jp?B?SUFiQlZDUVl1MkFFQVN6U2VwcEVnY0Y4bW52RGNEbUxqQkYxMUxOMXhE?=
 =?iso-2022-jp?B?U1RUZmdaL29iaG5Pc21OcWFNMFRGTm9Sa1hsR1ZOVUFLU2IrOHIyYkRV?=
 =?iso-2022-jp?B?NnpUZlJpdUh2SUhDR0FWU2szMGpqZ3V1WndqbWRNV3piRjRGZ0NpdzJS?=
 =?iso-2022-jp?B?Ui80V0tDYnluTUtSZ3hYbDhuUlBwWmZEejZRTzhiR3ZmNlpCNVN2YUht?=
 =?iso-2022-jp?B?R2NWdyt0Zjk5YXpuTnl0L3hZSFBhcG56ZkovRXdpQW4xTHRGT0NQdnIz?=
 =?iso-2022-jp?B?ZGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?SGJiSzA0N0k0Zi9zVTRFN1Jxb1FaUk4rNVFsTDIvTUl2QmVUdXZEa2RG?=
 =?iso-2022-jp?B?Q3ROOWhaaG0yc0tiMnlyZE1CLytPRE1VaDR1U1Y1aEw0T2d0TncyYkJn?=
 =?iso-2022-jp?B?V09WL0pBT0IrYU56QXRhelBVVlVLd1ovNzA5KzNCaGhteUlIOXhrNzVr?=
 =?iso-2022-jp?B?ZXJ6dWdkNkE0Y0Q1UWpNTGVncUhwekVPMlNuNmQ5cTNsdGdsMERSdC8y?=
 =?iso-2022-jp?B?RXJIUFJsUzJZUjZmblhETmF4bE00cWI1R2FhTS9uUlM0Yml1OTRiamNL?=
 =?iso-2022-jp?B?WXd4azJzNzhoTzAwSkkyUjdvSXU3NWRZbEpqa0hoZklqWXo5TXN6QWZq?=
 =?iso-2022-jp?B?cDZ3cnNya1RHU0E3QlQ1ZldQN0ZMRTRmZWZqM010amppQ2NyL21VS0ho?=
 =?iso-2022-jp?B?Zjc4QitNbnIzdmJvYVluUmRXR09sNXhYdHNtTzhzZjUyZkFrWTQwK0xR?=
 =?iso-2022-jp?B?M2dSc3dpZVdIcVdTa0o1eFk1VFJza3k4UjhhZTlaSmdlV2ZOZzZzUWhr?=
 =?iso-2022-jp?B?M1FNWDdRWlJUU1REZzRMS04wOFNNSW1oQlpoS0RiS09yUTVPdkorWGJN?=
 =?iso-2022-jp?B?SjZSWmM0Rk0zVkMwbU5iWGFhS0kyN2JUYStpY1ViVTFpNTBDb1lTemdY?=
 =?iso-2022-jp?B?MitqM08rRU41cWZQS09taXFrbiswKzE5UmRTR2YyaDBPK3VZc2hsMHo5?=
 =?iso-2022-jp?B?TFZmZXMxQWcxMEVFcGdsZTZUZ21NK2UxZGI1OUtXWTFGQWxBSnUwNm9r?=
 =?iso-2022-jp?B?aTEzZ2UvaU1UaVhvZHQ4S1VLRkk2c21sQXZ5N3JnSEl1UWJZRXg2blRQ?=
 =?iso-2022-jp?B?MmJmemxwY29oeTJsTVA0WnY0QUYvS0VSOXdqQWhuVktiTlRKS29DWkt3?=
 =?iso-2022-jp?B?aTBwMHJrMmlvNk5LNFVVanhHSTNYV2dDQXRLS3pXKzVOcWlqSVhXMk4r?=
 =?iso-2022-jp?B?NVgyVDk0Q2VzOXMxTXpLb1l6VU8zbFFkK3ovYWFjR0x6TzR0NHBWaWZC?=
 =?iso-2022-jp?B?VTFWZ0lxREd2alEvZzlKUk1jdHFTenhLRFd0V09tK1E0cUgxanR5aHRk?=
 =?iso-2022-jp?B?UlUwVmk0TklVTHc5WkdxZ0NEMHZZM3hWTnQ0VmlrRTM3YXlOeVlQdTVu?=
 =?iso-2022-jp?B?NWU2Qk9jOTFESm8xaC9GeDZQMmNKOU5FaldBYzlrc0xpZE9lemtGclBB?=
 =?iso-2022-jp?B?MnU3R0RxckFSOWwxd25qK1lNSTJSOFZtRWU0TXMwS0tOY1ZhZXZySklh?=
 =?iso-2022-jp?B?dk0xbitqaG1kUzdUMUhMTXRtWllKUDdQaEFlcFdudlpxNFdKemJKMUFS?=
 =?iso-2022-jp?B?SkhlKys5YThqMXRKNHFSdDhIbmdoazQ2SEs3blpSMGNhYUNxNjRSZFFk?=
 =?iso-2022-jp?B?ZVMyZkhJRnhycVBaY3FlRlhiK01FSjBkTmFQQ1lKaVNkZTdNTHBPeWpX?=
 =?iso-2022-jp?B?NUFFcFl4dGpzV2dseFRPM2tDS1ZDa1Zzb2lNUXA2cThEam1kTzRmRzN1?=
 =?iso-2022-jp?B?Nys0RmVyNmRSaDg1WTNBdWw1L3U5VkNVRjRtdVNmbWdFZU5jWnRCR3hy?=
 =?iso-2022-jp?B?U1FKR0greHpmVDF4TitIMkRqL21WVGozWkFrQkZnTzZVdmY3cXpRbjB6?=
 =?iso-2022-jp?B?VGlVWVRKM2RlWGpQU2hWMTg0b1NpNDB3TGFHMmp5UW1SeUlvamJQeWNw?=
 =?iso-2022-jp?B?YXR5aFJCd1JnY0U4QUM2QWNWOThnY01Tb2dmNmZNRWlaKzRKdXJOeTk2?=
 =?iso-2022-jp?B?MUtLMStDYklDa1hhRENpbHZpNnpTdDlsSG5xK1VoMEVIc3VmeXVDTU9t?=
 =?iso-2022-jp?B?R2Q1dWRnZkVZbzgybTRzV2tDejNtWFhiNys2bjk5eUVmWmVuVFZ6THlo?=
 =?iso-2022-jp?B?dVNUTVFjQW5QQkppeW11c2lZcG9WeUVkcDhvSXYrS0NuMlFqMkphTGsx?=
 =?iso-2022-jp?B?MXJuL3hoaDZlUmxqTnI0NGFySDE0eWRpTzdjSzJJL0dGc2lCS0VDMjll?=
 =?iso-2022-jp?B?VUt0MmsyOUZIckhOdFRJdDQwNFozSlFiUlQxaVkyT05wRjRaMDZNOElz?=
 =?iso-2022-jp?B?R3BMWlUzUnpRdlFxNXFETnBUc3U5bDRyYm5iZG9RUzNMT1hFSGc2MkI5?=
 =?iso-2022-jp?B?a2FIUGVtV0xDZGJ3NWRTdmI1cVJpTzRKcFB0QjFabVIvbDZUWCtLTEdF?=
 =?iso-2022-jp?B?WUQvTE5DeHJqc0tZRHZFT1lpUHR6YjhEZ0l2T1JvQ01uQkZEVXdwV1hK?=
 =?iso-2022-jp?B?OXVyTlZyOVFGaXh4MWFuWWlVQnhtNlpBczFaa0JSTEFGOFFTcVVacmU5?=
 =?iso-2022-jp?B?NjVhUlRMaEszSHBZMzlveStYelF4ZWpDdXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RhjNEqehM8uZ/qwLsINdLtOJOATO5OOSBg7uH7fAlgQUR0fKpYXZI1RQ5F3pp3cfSk5UIYlqJhGiz5YMiERKjXx1mNDYlC52nblupdVQgaQ35HFc621n9lptH+ZR5j4ww1XQ91SBSWXjm/AeBiXudZE1r0HRwatu1mbHVItzFmrLXQtCz1/dmMMZz5D2QEIdfxB7CG7pIcu48TeEr2IDnWC2IoxUkqPSNlSIMAHEwLWTeCGf7TI+9PzVWEafPmdrNHHU8KxnZhdvXJ93vrtROD6+hdyEf9/Ms9cl1IXsbIE4oraEUUtQ708GkW4nCO94leLefachVH24WNgVB8SyE461ozmXaCNMoTDZ6wSEGwNFS3PAL2xxFoYXN90pNYqvyIXSr6JkgAmWrs5lUAnPm1rxlyKgode5nVQdZksW5IibPZXSKoSO7uDMLUkaiXjx7azQpsWipnz60rKrIWpZMyA+o512xY/mTZL06JeylI55A1fODlsSz47KOJJUJ+7056jXOSQvVg4PIeWex48Ii0IJgMuR3tVj7WBHarOTuLskYc6MkRmUkbrVRKFxtUfnxtdCi6QPCUiHo5GQeo6NHHQQZcCbYYpmfJDvMbd+dU8+hVtvfIFKJJPPI/hR9W24
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50e872e-33c0-4d72-8d57-08dc9efac5f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 03:05:07.9863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +3IlaLQfU00aTbubx9xoM9QdPwW92WCrt4S+4UuJFLQgsw0U52kYHii9ou4WTXX1L4Nm4Nhtgjv4hnz7Rs4n/hfWLwFmkk93jjXn2UhhfjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8133


Kobayashi Daisuke wrote:
> CXL devices are extensions of PCIe. Therefore, from CXL2.0 onwards, the l=
ink
> status can be output in the same way as traditional PCIe.
> However, unlike devices from CXL2.0 onwards, CXL1.1 requires a different
> method to obtain the link status from traditional PCIe.
> This is because the link status of the CXL1.1 device is not mapped in the
> configuration space (as per cxl3.0 specification 8.1).
> Instead, the configuration space containing the link status is mapped to =
the
> memory mapped register region (as per cxl3.0 specification 8.2, Table 8-1=
8).
> Therefore, the current lspci has a problem where it does not display the =
link
> status of the CXL1.1 device.
> Solve these issues with sysfs attributes to export the status registers h=
idden in
> the RCRB.
>=20
> The procedure is as follows:
> First, obtain the RCRB address within the cxl driver, then access the
> configuration space. Next, output the link status information from the
> configuration space to sysfs. Ultimately, the expectation is that this sy=
sfs file
> will be consumed by PCI user tools to utilize link status information.
>=20
>=20
> Changes
> v1[1] -> v2:
> - Modified to perform rcrb access within the CXL driver.
> - Added new attributes to the sysfs of the PCI device.
> - Output the link status information to the sysfs of the PCI device.
> - Retrieve information from sysfs as the source when displaying informati=
on in
> lspci.
>=20
> v2[2] -> v3:
> - Fix unnecessary initialization and wrong types (Bjohn).
> - Create a helper function for getting a PCIe capability offset (Bjohn).
> - Move platform-specific implementation to the lib directory in pciutils
> (Martin).
>=20
> v3[3] -> v4:
> - RCRB register values are read once and cached.
> - Added a new attribute to the sysfs of the PCI device.
> - Separate lspci implementation from this patch.
>=20
> v4[4] -> v5:
> - Use macros for bitwise operations
> - Fix RCRB access to use cxl_memdev
>=20
> v5[5] -> v6:
> - Add and use masks for RCRB register values
>=20
> v6[6] -> v7:
> - Fix comments on white space inline
>=20
> v7[7] -> v8:
> - Change the cache value to offset
> - Access memory map area in rcd_*_show() functions
>=20
> v8[8] -> v9:
> - Map the pcie cap in for all the time the driver is bound to the device.
> - Add mapping the pcie cap in cxl_rcd_component_reg_phys().
>=20
> v9[9] -> v10:
> - Change a utility function for getting PCIe capability.
> - Fix tab alignment issue, error handling, and apply suggestions from Jon=
athan.
>=20
> v10[10] -> v11:
> - Add functions to have one function do only one thing.
> - Add a size parameter to utility function arguments and consolidated the=
m into
> one.
>=20
> v11[11] -> v12:
> - Fix the error handling in cxl_pci_setup_regs().
> - Fix and clean up some details.
>=20
> v12[12] -> v13:
> - Fix and clean up some details.
>=20
> v13[13] -> v14:
> - Fix and clean up some details.
>=20
> [1]
> https://lore.kernel.org/linux-cxl/20231220050738.178481-1-kobayashi.da-06
> @fujitsu.com/
> [2]
> https://lore.kernel.org/linux-cxl/20240227083313.87699-1-kobayashi.da-06@
> fujitsu.com/
> [3]
> https://lore.kernel.org/linux-cxl/20240312080559.14904-1-kobayashi.da-06@
> fujitsu.com/
> [4]
> https://lore.kernel.org/linux-cxl/20240409073528.13214-1-kobayashi.da-06@
> fujitsu.com/
> [5]
> https://lore.kernel.org/linux-cxl/20240412070715.16160-1-kobayashi.da-06@
> fujitsu.com/
> [6]
> https://lore.kernel.org/linux-cxl/20240424050102.26788-1-kobayashi.da-06@
> fujitsu.com/
> [7]
> https://lore.kernel.org/linux-cxl/20240510073710.98953-1-kobayashi.da-06@
> fujitsu.com/
> [8]
> https://lore.kernel.org/linux-cxl/20240606074814.5633-1-kobayashi.da-06@f
> ujitsu.com/
> [9]
> https://lore.kernel.org/linux-cxl/20240610082222.22772-1-kobayashi.da-06@
> fujitsu.com/
> [10]
> https://lore.kernel.org/linux-cxl/20240611055254.61203-1-kobayashi.da-06@
> fujitsu.com/
> [11]
> https://lore.kernel.org/linux-cxl/20240612075940.92500-1-kobayashi.da-06@
> fujitsu.com/
> [12]
> https://lore.kernel.org/linux-cxl/20240614045611.58658-1-kobayashi.da-06@
> fujitsu.com/
> [13]
> https://lore.kernel.org/linux-cxl/20240617043702.62028-1-kobayashi.da-06@
> fujitsu.com/
>=20
> Kobayashi,Daisuke (2):
>   cxl/core/regs: Add rcd_pcie_cap initialization
>   cxl/pci: Add sysfs attribute for CXL 1.1 device link status
>=20
>  drivers/cxl/core/core.h |  6 +++
>  drivers/cxl/core/regs.c | 61 ++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |  9 +++++
>  drivers/cxl/pci.c       | 89
> ++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 163 insertions(+), 2 deletions(-)
>=20
> --
> 2.44.0

Can you merge this patch into the next kernel?
It has been reviewed and I believe it is ready to be merged.
If it is already in process, please let me know as it is my fault for not c=
hecking thoroughly.
