Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3150C282ED
	for <linux-cxl@vger.kernel.org>; Sun, 29 Dec 2024 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735457168; cv=fail; b=KvWCFq+7SgUh1ddxx+SFllMAKiHqDKS+n6VF0T99rdk8g57PLbrctFX0nuHXh9iwPx6i7iYadjDo4CxQIbURIeNJMCBnQWa3WGXoVnuMoShJpIim9xfqheRo18bf5/GTbS+koSOrGyTaI7MhiRgxakb9nqXnHD/5DQTnOnqZNjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735457168; c=relaxed/simple;
	bh=jJeXTjOtfSF7SEGyBmWr4HPsLACZOCngjBV4PRH62V4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NDnE5zsuAk5P2xeJ1pZdW4EFvqiLyKEeKR/Z0lnXXw8lKVxQBYrqDU5RbsWbJ/VhHt5IlDoiN5GtyOR+20XteVsQQ0Qo5+y5qrFXD7sTyeTEYrYLsHLZUKimIOTip5FCaVSlHjoFtjMbziz/wY+elLz7YcysH7QybnMNurXjDgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BrPj7G0c; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BrPj7G0c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735457167; x=1766993167;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jJeXTjOtfSF7SEGyBmWr4HPsLACZOCngjBV4PRH62V4=;
  b=BrPj7G0cdUaNOhIrH8yffxC7gZwKJIfxu5Bi0Sr9yCvX6M5hrIvgUzNk
   i3cO6vRfznTdkWO5jIX+NLQcAJZEOfXcp7LUOqC630LcqRcP6KIb0LyC1
   wTES3uiUWm4sHl2aDegUZ0SeZHYGn5ccbD9D7JQsFzu0jOgpSUs4jItqw
   NDp+bTv998/0LrUraKysX2J2zRisgNceDH8pAKHq8YK95isSZMM6aGkna
   nyJJ7rJQ2C3VLunUOyrd+UMGbLeXA7fh55vvRcp97VZXnlpSnTmdtnsMj
   C09JjajWhaOAQyOdqOA/JEbKL82LK1iyyiYlxoKwmJ54+emLuwkosumxH
   g==;
X-CSE-ConnectionGUID: VKbM4gGkRDmbhbOj76isNA==
X-CSE-MsgGUID: nfeIgDRdRBOdWiJc/cqLUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="35663478"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="35663478"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 23:26:05 -0800
X-CSE-ConnectionGUID: Skfy/2tTR++ldSYkYiyKKA==
X-CSE-MsgGUID: QxY5eMIfTfmGCsft045Fkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="100881925"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Dec 2024 23:26:05 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sat, 28 Dec 2024 23:26:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sat, 28 Dec 2024 23:26:04 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 28 Dec 2024 23:26:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BItc3PCnBVv67ZRav39oJVXw4pqSfniYcaupdFtuYbmddcGx5lccabLFYpV63lCxLRIc3KH8yCoW9gUmpgmH1S5+xi/MTc/+7H31/T/hZzSzNQKnJhFa72Ek/wyDeTYKkqZFIW1/b/VWozXVI5FqwN82n+3X72k9CPRk8lEiW1WSzdcD+iaWY9p/laa11M8D7/Upq1F1uDGL7aHlhORoFBkVTFTlI8EAubKk7Etmnw7T8w+h7lHlO/Go/P7Vbk2U72scIhSbbzdy4Sq4mQgzOdh9JLsUTVUci3TwJZD1Sm2eUhGky1JscBZZ7FCrzBUz8gKvZagsaGosv5/y/sNFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJeXTjOtfSF7SEGyBmWr4HPsLACZOCngjBV4PRH62V4=;
 b=sw2qFu8Fsw7WYH36PfUkc2MxF3mQVshPXE7+vgKSAZ6dEipyfviJN1MZt7S+uzUQW2ZxNYLiDrx8E+qUQ2PNeUO1JgBemYZg9dw4jAjKUJlWAL5irX2Z6poHxrTRyozs6kU1Tg7/Sg8hEfcj2HEmg8JkmD6rNZqCQHiT1h+lLLDoyDXc0+4XRcrJmidI/5d2/HXyiMNW/C9XBcNSvmTwL2Z7rHWVDAiqVpAt8/aw3+u3iubpGtWll/NpAMJclcdXrHYZudSlRUic04OWtuxDotyLQbJcN5qWU7Qt2kkLU0mpzXZHROFVjHmXwth97yd5PuXQheXK02EGYm5hJUxNuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA3PR11MB7461.namprd11.prod.outlook.com (2603:10b6:806:319::17)
 by SA2PR11MB4969.namprd11.prod.outlook.com (2603:10b6:806:111::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Sun, 29 Dec
 2024 07:25:17 +0000
Received: from SA3PR11MB7461.namprd11.prod.outlook.com
 ([fe80::4ec0:56bc:1ceb:7c06]) by SA3PR11MB7461.namprd11.prod.outlook.com
 ([fe80::4ec0:56bc:1ceb:7c06%5]) with mapi id 15.20.8293.000; Sun, 29 Dec 2024
 07:25:17 +0000
From: "Ye, Huaisheng" <huaisheng.ye@intel.com>
To: Li Ming <ming.li@zohomail.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>
CC: "Jia, Pei P" <pei.p.jia@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "Du, Fan" <fan.du@intel.com>
Subject: RE: [PATCH] [RFC] cxl/core/regs: Refactor out functions to count
 regblocks of given type
Thread-Topic: [PATCH] [RFC] cxl/core/regs: Refactor out functions to count
 regblocks of given type
Thread-Index: AQHbVqgo/KqwOCW9mkSRJksmhnE9U7L3yYcAgAAyv6CABL8iAIAAG9jA
Date: Sun, 29 Dec 2024 07:25:17 +0000
Message-ID: <SA3PR11MB7461323637D676973A4BC8749F082@SA3PR11MB7461.namprd11.prod.outlook.com>
References: <20241225083539.2230150-1-huaisheng.ye@intel.com>
 <2d7a78c5-8544-4dfc-822c-bae8677c1703@zohomail.com>
 <SA3PR11MB7461C9DEDF29160B40D5F21F9F0D2@SA3PR11MB7461.namprd11.prod.outlook.com>
 <24cb5a57-ec6d-4171-9f85-b1165b5c20db@zohomail.com>
In-Reply-To: <24cb5a57-ec6d-4171-9f85-b1165b5c20db@zohomail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB7461:EE_|SA2PR11MB4969:EE_
x-ms-office365-filtering-correlation-id: d7867e2c-81db-4608-7b3a-08dd27d9f1b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Sm1rQ2xnY29NTmdTZ1BkRE5vMGI3eHRxUU5wSjNuakxpRTE3QXRHdjBHUUtj?=
 =?utf-8?B?OEtqK0FneWxwWW5FUWxxc2dBU2xuSkRUS29MUks4dXZ6MVJsSk9abUZwU0h2?=
 =?utf-8?B?UEJ2VGx1cXZqVDRNVHNwcno3Q1NUVThhY0dSQkJVLzhQbE5nTTZXWmlVL3FV?=
 =?utf-8?B?ZGdhN0pabUxtZktPeWE1VDYrdERVUnZhQUhZSjFSYjlTUnViN2lsbEgvOHIy?=
 =?utf-8?B?RVdNYysrWFA4aENQMVFHMGdDbklyOVV4NzhScERJeDFnaDE2Vnp0ZnlVWHRh?=
 =?utf-8?B?bHlWS1hDUmNZb3NLYXppU05EbDYrNG1YY0V2dnlMbG16NkxxaXk3bFFTQ3Fa?=
 =?utf-8?B?a1ZsdlQyRm9SOXdibEhYOHhXRzQwbHk2Q3hJUDJMZXlWcWpSTWtIazZwaFpR?=
 =?utf-8?B?UDdVT1BJNGp5d2tpajBZeEtwSmMrR2VxY0hIWVZWbzZHMk1XaE5YMnpBL2VG?=
 =?utf-8?B?YS9KU3JpYUx3SWZjTGJHazJwcDFZamtMZFRoaXBXdlUxOVBxYUlwWGt6UmEv?=
 =?utf-8?B?Z3JaM0JHUHB5VXBjRitITFZmS2NPNy9uK0ZxUFZoL1k5cnV1N2YvQUVXSWxn?=
 =?utf-8?B?SEZqa1FaNExPcnM1Q0t4N2diOHlOMi9ReUVZa1FtQW1lYnhwOTd4VjUwd0Jo?=
 =?utf-8?B?N0xOTkR5WVo5eldOU1BYQ0JLdkE4b3VPSThMcjFFWTFGdTJ6UWFjUlBvbFZa?=
 =?utf-8?B?NVJaZlJ2TDArUXlsWnY3RXlUZjRXK3hZWjUrd3oxMXY5V1hKTUFlelZHWFRW?=
 =?utf-8?B?T2hPR0J0bllsSk9aYzNRbDdZa3FGVG0zc2lIaWRPV2R1N3hTZCtkL1Z5Q1FX?=
 =?utf-8?B?ekVUMURrYjJ0R3Q1ZmxVM2pJdzMrOEJSRFJJaHBoSnhYcE9rbHlESkVJb1dE?=
 =?utf-8?B?TWg1S1Q4NnRrZGZCOCtOUnkwM2YrNHVaR1JtVko5WGxJc2FuaTVvK2ZBZXBv?=
 =?utf-8?B?WGllY1UzNmd5Qms3RmtyZWFYZ2NWMGJvV1dvVSsrR0tJNy8vank1Zlh2UXpM?=
 =?utf-8?B?bnh6cjdJNzlIR00wM2NLQkZudEI4cGxnVjN0MS94OVg2NExDTGhsTllRVVYv?=
 =?utf-8?B?WkRGVFBUMDZRWlY5ME1NWmVCaVRudkJZUkx2NFZrUW55NUU4OVlROHhLYUk1?=
 =?utf-8?B?RWVUZnZ3Q045ak13Tm1EVFlYRmFpR2RDaWR6K0xsMDFqR291VmVBM3RydzAy?=
 =?utf-8?B?SkNvaWYyR1VCeWdDYnV5enZmbWJCaFcxY1BYMHlPN0lCUlE2VTlkMCsyMFAy?=
 =?utf-8?B?TXFSU3orb1hCR0VCcldZNnFnRmFLZmNkQVp4TTRpeDlBK0lKdzBvL3NwRjh0?=
 =?utf-8?B?dkZUUnhsYlVpUy85dmJseTNsR3lLNUZxZmF3MVJuSzZwZ1lnNFRmRTA3SllU?=
 =?utf-8?B?Um5oMkhqc3JObzR2d3g4bWNUZzBIa1pieXdCQlZhTjB2amZmZzVCNU1zV2h2?=
 =?utf-8?B?VVNDSXdwNmU2WVZLUmJuRFk0TnR4UHhMaXRITllQMzFWaUhXM3F0RWduL3Bq?=
 =?utf-8?B?VW9SRVNIcU9GbS9lRDQ0RklmWXZsSnpjUFdZd3U2eVExTXZWL29iOXFuV29r?=
 =?utf-8?B?WmxZYkZ3bmMxc0t1WHZPKzg1Z1o1TzdpbGs2TFNrUDJIOHlDYTAyMHcwRDJ4?=
 =?utf-8?B?TXpNakVSNkVDZkJRSkQ4NEQrWVp2UTB6NExlVHpiNFo0U3RpelZjcUV6RW5K?=
 =?utf-8?B?UlZ2L1g5UXhuaHdaN2ZnWHFYSEJaVy9UdHdwbUtuNm1NNmhoWTZ6U1dpU2lo?=
 =?utf-8?B?UGd6dDJ4N0FYdkNqckM4MmpaRDhQNVA4eWRxVHBJT3V0MFlaMkdBdmZzQU5W?=
 =?utf-8?B?ZTN3K3hKZkQrL0RFSEpBWkV5MHFiZS9QMWxia0tMSkRVVWxOUHdCNnpUYTNE?=
 =?utf-8?B?ZmE5QUpKZzN5RVlQKzRJVm41L0c5RjUvWXgrOTRuMnBVaUtBd20zT09xcVZt?=
 =?utf-8?Q?3FZhaWSvNBOZ52Fv2X/VwqJcMYjkAs/U?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7461.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2M1bzMyb0dZRTBKVzBSSHJLWDFUM08xY2hiNHJUUnA2aDNFUXh6Y3Fnbkg4?=
 =?utf-8?B?WEJEK3VJQVVOcUJmM2xkQTFtcE43WjFLam40REJ4aGMzeXVBTnl6YVg4TXFQ?=
 =?utf-8?B?NVg5ai9QeHBKRk1CTjBKbjE5TTR5V1ZmdkFSVkxya2FXeWpiNThNVDhiRlRF?=
 =?utf-8?B?ZTdQRkprL0FZMVREdGN3aGtBcmxORG9sSUJPUEJyNUtHVkozY1RLSVIyTGJm?=
 =?utf-8?B?bWpQbDBlN0FhQVdiaTV0VUdWMXpERlAranQrTVRKbkZBSUdodit6eGhIMFhS?=
 =?utf-8?B?TWFkV1ZveU1wOHRNUTA0cndPbEFQUXhxOVB0ZWFOUVNkUE5jNmpQMng1aGRp?=
 =?utf-8?B?M2pTSkU4czE4UG9YNENwU2xPQ2YrWlNrWnhKb3RrNngxOUgwOE9udk9oNmNB?=
 =?utf-8?B?MGFESXNmSDJackZnWE43QXRqYWNSSVJZWHRDcDlOZFJZcVRjNHFMNnM3R3Vl?=
 =?utf-8?B?UHVIMkZTenVLUlJsMjZZSXphNGhGcjdMRVphdjdkMEtPeDkzRzVMT3pXMmR1?=
 =?utf-8?B?Y25ubVlabmRqZWhDTlN3NGIyUVgrZGpIUmg5WmFKLzN3ZUV5Z1JsaU9aNGlF?=
 =?utf-8?B?TE9IS0dyMm4xZHUzdG5tem5EOUhMTjZUUUlDTDVyODEwcHRBZm9iazBjTTZO?=
 =?utf-8?B?UzRqQkNaa2kyand4dEpEM1lnZ2pWelZuNkQ4VEdSOW8vL2RmTDBFMkdmVHdK?=
 =?utf-8?B?dlVQcjdTSDQ3dVcvRmx3VFFvMGFUR2dmNm5iSFRBTEtQQ2E1NDVTTGFIZlZH?=
 =?utf-8?B?ZXRwTkE1Y1hDR0NvaUtZak5VdkJqM01RWjdlcUdhMVZFNDgxcTh6d3N5LzRW?=
 =?utf-8?B?VG5uMGluay9lVU0yeGQ1dFBlWk80K0xNMnNWRFJWS2ZSc0dsdlhUZ0ZIUlBB?=
 =?utf-8?B?NUZrSkR2SlEvQ0JmM3NaNC9BcU0xOFZLTUpTNVVSVDFzd2h3YnRYN0Zqa2RU?=
 =?utf-8?B?ZkQzN3VqVFg3MHlCdUlQSEFFOXZ6VWozQVlPMmlhWDl6RVpicjdFUHNLVlJv?=
 =?utf-8?B?U3FFQlRqb2FyRUVxWDRaSlhtcVBxdllmZkhjRWdMbnlyOVQreCsxZkdqV3JE?=
 =?utf-8?B?dGh3cGRNMW81WVZnYm0xZmNaSndWV2FWVHZNNUxpdjA1MGgzQlpab0MrR0F1?=
 =?utf-8?B?aTdFMFZXUDZpRHlhWmJtN2FKcUtINENKMWN6Z05WMXpQTmRnQkYxSlkxSFNU?=
 =?utf-8?B?aUs1TjMzUy9UK3lHdGJhb2FqdWVhT1I1aWxpYmhwQ1FjZUhQSTJJMEI0dWZD?=
 =?utf-8?B?WU1CYlVGNXlFR3RDZWhId2ZwTm5vTkVxYVZXMEtuWGZReWlWc1AvNDU3djRK?=
 =?utf-8?B?NVFLQ3FIbWxtVXFBVWQ1K0pXV0RaNlhaRURUZ3d3Y3ZtdGpkNWF4d0N6R05L?=
 =?utf-8?B?VVN6bEhvN2UrK2R2QjIzZlhQVHlVUUN0YlI5QkJROEVIa2U0Vm15SGRsU1BO?=
 =?utf-8?B?ekdOcjFUTHMwUHJFOEFhNVUzUWRWeDA4aXJsZlF1eXhJSlhXZjJJNVpscVQv?=
 =?utf-8?B?VDhCb0pnbFp5aHBUckVLK3FwclVZNUh0YXpLb1EvbUM5YVY5OEFpWWFPZnA3?=
 =?utf-8?B?OERwSUJrYUw1K0VTREsrdTRLeDB2RjZWajRJdVhTSHRXN0FMOENYREM3R2Rv?=
 =?utf-8?B?OGxjUGEzOXRJbW53MG9UeGx5YUxiYVNpb0ttTzRZM2Vzem1OOHNScFNwb1FJ?=
 =?utf-8?B?WCtxbWx5anc2SDV2S1JQOGR2SUJkVHhqRnBLWEgvazQxTHd1OENJbGRCV3Vm?=
 =?utf-8?B?WCtORWtCclFUQ2NxOS9TYkU0SWNzancrZFViWkhOeGtwWHN4ZTNSOFFsQVl6?=
 =?utf-8?B?QjhZWVFOYjdIVzgrR3MxLys1cklrMUhLS0cwOWlmS1F3aVllQTd0SnJZemZF?=
 =?utf-8?B?UnpkVXNWNW1qS3hhakJDeUs2aEprVlRjbnlPcTVmS0xxMFBVRmdESm1wVFh2?=
 =?utf-8?B?Y1hFdnFFSGNiVmdXb1lObEhtdGpjdXVRZEhWSkJkaGlTRm9IVTBYOXIrR2Iy?=
 =?utf-8?B?Ny8vVDlpbEUvM2NId1R1a2ZsaFJBa3REaDQvRzI5bDlxV3ZFeE11b1lVd3dv?=
 =?utf-8?B?MXRGemlmd2d5aFo5cDNOc29zRGl2dFU2ZzNWVldxY1I5MWxrTmFDdy8yaG81?=
 =?utf-8?Q?n6bPhnRHHVUBNTWmUc4QJ7S8f?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d7867e2c-81db-4608-7b3a-08dd27d9f1b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2024 07:25:17.2672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ncNoIsa8HMxMkxvKvTuQuwxlJqK+e1Y6SowFv4zsQ/UosUS/O1d31M86tvTvqgdTqem/vshODREhyxKpIKZ9KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4969
X-OriginatorOrg: intel.com

RnJvbTogTGkgTWluZyA8bWluZy5saUB6b2hvbWFpbC5jb20+DQpTZW50OiBTdW5kYXksIERlY2Vt
YmVyIDI5LCAyMDI0IDE6NDIgUE0NCg0KW3NuaXBdDQoNCj4gPj4+ICsNCj4gPj4gQWJvdmUgcmV0
dXJuIHdpbGwgc2tpcCBiZWxvdyAnbWFwLT5yZXNvdXJjZSA9IENYTF9SRVNPVVJDRV9OT05FJy4g
aXMNCj4gPj4gaXQgZXhwZWN0ZWQ/DQo+ID4+DQo+ID4gWWVzLCB3aGVuIGNvdW50aW5nIHJlZ2Js
b2NrcyB3ZSBkb24ndCBuZWVkIHRvIHJldHVybiByZWdpc3Rlcl9tYXAsIHdlDQo+IG9ubHkgd2Fu
dCB0byBrbm93IHRoZSBudW1iZXIgb2YgdGhlIGdpdmVuIFJCSS4NCj4gPiBTbywgc2tpcHBpbmcg
J21hcC0+cmVzb3VyY2UgPSBDWExfUkVTT1VSQ0VfTk9ORScgYW5kICdyZXR1cm4gLUVOT0RFVicg
aXMNCj4gb2theS4NCj4gDQo+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB5b3Ugc2hvdWxkIHJl
c2V0ICdtYXAtPnJlc291cmNlJyB0bw0KPiAnQ1hMX1JFU09VUkNFX05PTkUnIGluIHRoZSBjYXNl
IG9mIG5vIGF2YWlsYWJsZSByZWdpc3Rlcl9tYXAgcmV0dXJuZWQuDQo+IEJlY2F1c2UgdGhlIHJl
Z2lzdGVyX21hcCBoYXMgYmVlbiB1c2VkIGluIGN4bF9kZWNvZGVyX3JlZ2Jsb2NrKCksIHJlc2V0
DQo+ICdtYXAtPnJlc291cmNlJyB0byBhdm9pZCBzb21lIHBvdGVudGlhbCBpc3N1ZXMgb24gY2Fs
bGVyIHNpZGUuDQo+IA0KPiBbc25pcF0NCj4gDQoNCkdvdCBpdCwgSSB3aWxsIHJlc2V0IGl0IGlu
IG5leHQgdmVyc2lvbi4gVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMsDQpIdWFpc2hlbmcgWWUNCg0K
DQoNCg==
