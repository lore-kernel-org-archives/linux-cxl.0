Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1367155335
	for <linux-cxl@vger.kernel.org>; Thu, 30 May 2024 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717063087; cv=fail; b=IckG7LVxufi89HbR2f0/t0Yw+puzh/xVuRkBfl6y1WpUM+a5AHxnYUEF31Uau3Fz7eQ3O6IjifijsfqEqaM0HA6AcQi4PRURMIKP1C+8FmUgkOcNdOpthDjF4ScVzpPsu/O6mjI4vTUY5chIzH30I80W8y+bk7UQIU0ZuOdmVbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717063087; c=relaxed/simple;
	bh=YkENOCXEGqNrSWj3FzpbIBPcOgPsmsfmo4m6zljv8BM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DxGQjoCzgaDBZNbs7eMdfyZg+ROflKM02jPH8eE/TQ3q6usvMDO0mFjqXNrA4TLi2pruA3JxSIYn+J5i4Vte5xwA7JYpa01vIa5NS3npBGmDJGZK1ANPeS/ZGJMQb/XCRiD4CpEgqOyNyB+65mfk9BFnpiOsbACJ/y8qtyVSzPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=OOXhR2zd; arc=fail smtp.client-ip=68.232.152.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="OOXhR2zd"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1717063085; x=1748599085;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YkENOCXEGqNrSWj3FzpbIBPcOgPsmsfmo4m6zljv8BM=;
  b=OOXhR2zdMlN5Rt01mBgZS7TEJ6D/mFQ65PHrkcsEUSZW/tiBVdE/DBi8
   q/coHIXc2RjYeXcc5t9f++fQeA6pImnp90WxgZkvGboydHZ2fZhH2U611
   t+UNylteZOjvbpVEJz1ehHvjZllyfxqKY88E9ZnYuA7ySoI/9rt8jWGXH
   y337pVt1GrwRm5Gu2keQOTPNilazTNIG7thGeM3tUD9UAfjoWJpVsYuAU
   LPJgBJ62pl+EhepaAGTlvaPsDOmLa8YL6RAZoTOsVupF/SsghkS9tpcB8
   jw3P1ufTcuKklj7veZyLbp3AWeZgtngezQgb82VTauavVLiROfzo0SDke
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="32013789"
X-IronPort-AV: E=Sophos;i="6.08,201,1712588400"; 
   d="scan'208";a="32013789"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 18:56:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSE+6R1G6DRPz2/JjJlvoGuHzKc2CwHpmQdzUk/B9d3nKS3tIK90Jhg/CWfjT2ukiWhb9HuOzoywJ/8sejVu0QDUGGrZVftTCOhwYn9I4KzMvfpqq53y/81/MsExQHYusJFnbugMVDisaYvl6+Q0Atsv/iRL9NcKpiTA0l2Tvn0ZtPOP4Lt0CoTPBn6lTNvZzx5lD/OVRXUwxKHMtWF1Q2GdDeTIjQFUTkviShUoIasZ3nfScfrcqIUcMoxd3wpbtzItYEAXyGoLuO/ifVPspncj+YjMk+s+4hsZGUp+UAjUADKh8qXnA+FrhYDvDvrqG1Idv5pEc0wG6JeqYKpuIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkENOCXEGqNrSWj3FzpbIBPcOgPsmsfmo4m6zljv8BM=;
 b=g+YtP+B7NJFxwlvdlUKMDRun42w3BOTjh5N+Rr1UBP3gDXjdEjxkBll6N0uDbmeb6u1mCuRVpgLhS1Y042GudqHbTT0paFz0a8P4n1mRkrlMIuMVYcwJzTmL6+y8KplRZL2HRUiUg8YtrC7TucggSmfF3QGh16QPb1jq3eH+/udu4xArY8f9S7mRh0YwuIV4Id88thfly4lYwOipZ7cVKSE4Cmh4+wBDh2dCggFDiEyLVS3Tt6ewAdPdKuMCmbwxpEtVAwWuBnu9cEj3a1gI2cRT7ZxfZ6pdAE03sX+E66Gv3Xki/Bj7R3xElU//F2nvc9dLGsTrIt8tWgBTdfxalA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS0PR01MB6354.jpnprd01.prod.outlook.com (2603:1096:604:104::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 09:56:50 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%3]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 09:56:50 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Gregory Price <gregory.price@memverge.com>
CC: Dan Williams <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: CXL volatile memory: How to restore the previous
 region/Interleave set
Thread-Topic: CXL volatile memory: How to restore the previous
 region/Interleave set
Thread-Index: AQHarax7vZq9IL+jF06rZcpjK4vT97GtbiqAgACZ0oCAAFq+AIABMUwA
Date: Thu, 30 May 2024 09:56:50 +0000
Message-ID: <0d336fee-b544-4c81-93bc-fb2d06bf0d34@fujitsu.com>
References: <36106fcf-1062-4961-8918-4471fd313a74@fujitsu.com>
 <6656801ef0dea_1668729484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <a815a715-c0a7-4f7a-9c5a-982f697ddb07@fujitsu.com>
 <ZldNRtWRXOhvfIdl@memverge.com>
In-Reply-To: <ZldNRtWRXOhvfIdl@memverge.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS0PR01MB6354:EE_
x-ms-office365-filtering-correlation-id: 6420cc23-f426-48e5-5def-08dc808ed36c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|1800799015|376005|38070700009|1580799018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UGI4NmE2UGtJN0NxZ3p6ZmNlSG16Z1MvVGJzMWxtUlNMQVlqRTJuSFRxYWp5?=
 =?utf-8?B?TDFjOTM5SXM0elJFWVVLK1o3eFNOajJ0ZGJQM1VLOW8xaFo4T3hjd1RQSFpR?=
 =?utf-8?B?WWxsYkdoNnNicm1aZ25GWHBTZUJXMG1Xb3E1akdTQ01sWTZaVENYeWNpS05p?=
 =?utf-8?B?Q2VUbWFCajMvcGFFazMzWUJmNEZTMVRmMjlxVG9zNXJEU2prZ0xUZ0hsWlFs?=
 =?utf-8?B?K0ZvMGRjS004WGhzRU1CazhJVTdMdTVjUy9MYUJnaUFtcmd3eWNtZE1zRTZl?=
 =?utf-8?B?dGtqVVJFbVlJaDVPLzg2NFVEN0FMVWVZQTY2VzFaeTJIeFE1bkNNdjVRVjhG?=
 =?utf-8?B?OG5GRnFzR0xjeDEzaGpvK0E0dWpYTUZsYlVCRlpSdnpON0JyejNDNVFjREhB?=
 =?utf-8?B?OEhTOVNiR3JwNFFOMGJMK0xBK01jRUdNYTc0ZWUwRHJiaVpvbGsrV3BvMVd0?=
 =?utf-8?B?T3lpaDZ4WW85bWpObmQwNE5wbGNZWmtoWkJmTHV3YytnNWJHRkw5dVJHNVJk?=
 =?utf-8?B?elBoc2xRMVlNajZ0RFVScmZjRDRGbVRRYWhJM3lzeFg5RXMrK2syUXR1cE4x?=
 =?utf-8?B?SENIN2JYWEsvU0F0YWpoT2hXVDRnRG9RNmZwekFrRGNFc0o3V3JXdlc4MDdM?=
 =?utf-8?B?VEZWM2FHZzRpNHUxbGlGbzRPOHBQayttdkV6WDdPWFRqclluTTlhV08xTmho?=
 =?utf-8?B?emtaanNyaWtad3N2T0dTSjNuUkRpVmRQWlpyaVBKTTBFZjltSTZieHJHUkZC?=
 =?utf-8?B?U05rQUlScE1Wb2ovSXRZVXNNVlBOaWh3VXU1bHkzTlI1UXc0Q3ZpVEVUMVha?=
 =?utf-8?B?bXBpZG04SmpMdlROZjEwSExwNzhSQTF2c3lRMDQxQ01FdTlxWDlWYm9wbkd2?=
 =?utf-8?B?dG1qV0Yza3hLeVIxT0s0WS93V250bmo3VWVDSXYxREsyd1FwRm8rbGJZQXYx?=
 =?utf-8?B?ZlhxVERwM0dQK2xFN1h4c2FVVjk3WkRTMmw0eG51NVU1YjlPWnZRVFgyWHBr?=
 =?utf-8?B?UnlmY0dhUHZvL1JKVWJocXQ5a3BRaXkwaHY2eEI3bnV2NTA5bE5MMlZlK3A5?=
 =?utf-8?B?L0hYMlAvc3dtZXJaS0s2d2tKbEkybVFBNFZ3ZHFGRFN4UEJOaEkvdGQ4akpr?=
 =?utf-8?B?bDRVNFNsdlFtaXNodmk5ODhTZGROQVkwVER1YUIzcWI2WjVZRURrVXJZc1d2?=
 =?utf-8?B?a0FNZmp4ZmYyNWxDaDJOV0g2MkdVN2VnS0c1WklQR3ZXLzlWYjkwNmZMUFVM?=
 =?utf-8?B?dVF1eERmMFFIVHdLZ291enJwajhqY1dRWUNxVWltaTBZejUrWU5TQlNNOWsw?=
 =?utf-8?B?S1ZCcHQ3bEdLcks4aCtuWHpTN1dFakpzcjFFNXRIQk1XdldhbWdnY2kyaE4w?=
 =?utf-8?B?WmVta3owZE9HNGcxN0IrR2NEc1FBVi9WNG96cGIzL245YTg2cVVXOEVPVnlD?=
 =?utf-8?B?eXRiTUxaQlp5SWp3UW93YlA2N0thQlhLUXlWSTZYYnZsaHNyTnNqMUQ0UVZT?=
 =?utf-8?B?RzFyUW92TVRhMmlVcFVCNlFaOCtDZDE4MkNsdGN2UGdnK1M3TkpkaVg2N0NV?=
 =?utf-8?B?T1g3dXYybXJZeEM4NTI2R0hiRTVkVnJEU2tJYk5hMzYyZnNnYi9ORXM1MWlo?=
 =?utf-8?B?YzVKUWRXdENrbStyNGJqTWRKN09CNmFIdUNLMlJzSmVUSVVhNmNtYVl2ekFt?=
 =?utf-8?B?bVhyN3RPYXdqQzVaUGtVQVQ1bXpQdUN0OG5MVVFCRm9IVVd5QThyeHRGMmpO?=
 =?utf-8?Q?ONq29pYzAdk8QXnyNHhwX9ngEZE/yX1ooQcCuGi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFdLZlViK2pHRUs5T25nUVJocmFJZXVyVnl2ZnlwVnNvbFRhT21kMGxLbysx?=
 =?utf-8?B?YXdXMUxkVGUvdDB5NThuVDZ5TkphaUQ0emhqMEg2SE5LUElhMDNoODJ3ME9v?=
 =?utf-8?B?M3l5N1h5bXZBdXpYUXFTd01vTVBlTU1rU1dXT3NtcGdDQmt0NEU2M0puMG1F?=
 =?utf-8?B?Slk2am9JUitqL3kvWXUwM2d2bEpiTHBvekEvRVVxdzNTZkV6RXpXdm4xN1hP?=
 =?utf-8?B?TzQ1UTRrcFpRdW5ZRU80L3dsWWJPNlN0ZVpScGVVaVRuRFlBVE04RkZoNVFL?=
 =?utf-8?B?cVRxTlBhS1lPbjhkVVpBOElMNTIyMUJRUUFzUzJ3aWI4d0w1ZnBFTG85SktI?=
 =?utf-8?B?d2ViNy9ZdmhqVXRDUmxCSHpXVVpwZUFiTTE0Njk0a2tPeDludER2MlRXRCtP?=
 =?utf-8?B?bGJRbFZIMjRmbjBBYjNZa2JuWDhyRDRWQW0xZEZWcFN0UEFFRnduWnp4Z3o3?=
 =?utf-8?B?c1ZEenVjNDEzd1h3MmJ4c0tFRmYva01aQ1puUWd2NEFmbG0rUi9hZEt3R0hx?=
 =?utf-8?B?V2xvVzNlQW1KM3FjdU80dzBiMURoMW54V2ppN0ZKdjRyQklvdFczZHRjUFZY?=
 =?utf-8?B?S0FXZUZDRTZ3Y0d1QnJPL3h0NFRrVENPTCtTeUNOV1hPSHcxdHY0OVJSOE5v?=
 =?utf-8?B?cUo3K0ZyeWNrMGZZUzdweDNBdmVLTi9aRW5rSnd6L0hGRS9xcHBqOHcraXVO?=
 =?utf-8?B?TmRnZnhhWGZ6SmVxbHhZbkZueExYTlZYMXZpb1pJTUJaTmlOQUY3YzZRZjIz?=
 =?utf-8?B?TWVQN1ZPSm5jR2IzUmlpdDU5OHI3L3UvL2p4WUxFMU02VnJ0MWhMaEZ0ek0r?=
 =?utf-8?B?eEVWZ3BSdmg3OFYxY0s1OUpLcTZra0ZVMUpmTDMvMUNObUNnaVBHd3p6dmE5?=
 =?utf-8?B?SG9tbDJMM0tJdzVHMDA0dUZZSk0ybmsyKzcxOXZJWEp1U25ldVdCR1M4Z3d2?=
 =?utf-8?B?MS9jQVhnSHdFWGFHM0xoTWwxbEp0WCtIT0d5eFlTMUEzbW1HcThsTjBsV25w?=
 =?utf-8?B?ZGg2ZXdrcU5oYW5pdU0wV1Iva0dYeUU3WUtoRDc2Y2RZa3pKeWs3dEo4alZS?=
 =?utf-8?B?MSt2ZTJnNnkwRU5ZTmtURzJ2ZGlmSGdkcDhNZUY3NnV6a0NnK281VWdGMU1p?=
 =?utf-8?B?Y01DWHUvMUZHbm9EY2wwK2xUZ3NLYWtkVG1tcTJSY1UzVkkrVlQ2ZGJCWGtp?=
 =?utf-8?B?Z1JNVngzSSt1Y1NKenhscWh1RW82cFhwd3g2TVR0M2Vpb043V0haUW5EUnlq?=
 =?utf-8?B?QkI0Y3lpbkFSdUljRTFpekxCU1NrZ2RnbVdsSWpEeHdZWEtzYlBoaklOcFcy?=
 =?utf-8?B?cEN1MzFnZXVzbFlCRVJpSms5Z2RCY21DTlpKTGZod2dLQTV5OEVsNDZKa0hF?=
 =?utf-8?B?V3RORklsMDZ4Ky9SNmpGWXAxNlk2THRCWU00LzgybUZXeWM3QkllQWRoVVZs?=
 =?utf-8?B?Y1d6c1VGWTZsMzJnN0VmcWJXTGx5N1d3NUdDV1A3dEZYTC9UWFFza1VvVW9O?=
 =?utf-8?B?Mk1tUWZUWFhvOEVMbnZ0Z0E3V2I4NmoyQ0lYa3diWkc3UTRxUFpnVEZ2ZWFh?=
 =?utf-8?B?c2QxL3NjaDNKZGQxdnFQcXIrUmpYdVpidjZKR0FFaTFMeXN0OUFaNlRodUZl?=
 =?utf-8?B?cGMyODhzRWJrOGIwTWtndDB1S2tpY1VFMzN4TTFkdGVjZDhyeUU5Ym1SZmZW?=
 =?utf-8?B?d3ZtaVJPeTA2NE11RzBPWk8wNTRNY1NKOW80bFkrNnNwVUlmMGtuRVFPUUY2?=
 =?utf-8?B?RXZjOU1oK0tVVW9tclA4NnNQSDZ3UkJCSzZXc2hCcHhuY0NwVmk1VDZZUlRk?=
 =?utf-8?B?Y1NDbUdGT0ZIWWlJK2F2U2h5RWI0UGdLZlFrYUdjbkJjOHRWMVN4SUpOcGxj?=
 =?utf-8?B?bnVQZklYcURacngzbjZKcW5xZFpMcmZVNVU3WlRnRmlkWjI0UXpYQ1B0NDh2?=
 =?utf-8?B?RW9qUTR3QmoreU01a2tNQU0wQm1wVStPeHUyTnluNzJWb1Y4Q0M3S1o2dUhC?=
 =?utf-8?B?QnF0R1IySzM2elI4UW5KTDcrYW81SnBuaHQ0cVNpbDhCZERFbjQrMzVpK0ha?=
 =?utf-8?B?R1d2Mzg4L0N4UTRHUytGWEJjemZ1ajRpSGRYZURhMG51MUtEaytNRU4rdUlw?=
 =?utf-8?B?VEVGSFptb2xabEtrKzlMazhPWk5OTDJKT1Q1YWZ0RVpJMlBoUnNPUEZSeFJy?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97FF0DCE2A697B4DAD96AD5BC143DB1A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pscmn4MGdtU2KhbmnoKEbt71ySW9UWOeMxtPtzPLxl2UFpb8mj1c76ZDwvJZ9ob6rNfWFWvq8gYWu2e9FWPG/e8rwxsGw7JkEpSoRX03a9505DHVRwEhyQNsarMkLNKEkaUNafxC17DAK1ngiFbR8PfXq41f0NtB7Rzl8mdxLdwleww5btdAga8VVMehWkvPYtiv3LzriT53FrB6tMFwqyr7NOaboCJW6upitMwW9T4hykHEiupL7NLbe9osSZT9x/Y9gZ8gnbYexGrhG4DsDfr09qwMgQDwiPjmhlVRDFSIeH2XLN21c4C22a5xns6QMkCS4ySy6cqhT1AP7LIebyQlQ7V4kHRjabBW1jyCwjx9rNjUnaoGt2AChFn87kjaOkaRkdQA2ayqgd1mv6ITbDM7es1GChNdxgwg406rUIcioACGoBzaqXl12HezBpmdO6ll8h3/beRHijNk+/Wyu654I6RzlLJnKhXyQWt9u5uR+0/aBWubcTUznJKIRPoDB/JzNl2TYpqxiDQstSmNgxbNIF05xdBMCHBb1kDySbDvzwU/YuTgZy+NkZ0w41WbPsG1AoZkCdzkHdmDkN6r2o3VD/7NjcFHS8koQ2XJU6E8xZR/eLYo8lbxvgY9DklT
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6420cc23-f426-48e5-5def-08dc808ed36c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 09:56:50.0503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: teJuxmCClvLB4dRY6Ozb6LogtwhVtXbaLZovMiUanOkoqgAKhg7u0jGKo2fpBji/gMs0IE+D4NSTYGBtDdWqPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6354

DQoNCk9uIDI5LzA1LzIwMjQgMjM6NDQsIEdyZWdvcnkgUHJpY2Ugd3JvdGU6DQo+IE9uIFdlZCwg
TWF5IDI5LCAyMDI0IGF0IDEwOjE5OjIxQU0gKzAwMDAsIFpoaWppYW4gTGkgKEZ1aml0c3UpIHdy
b3RlOg0KPj4gVGhhbmtzIERhbiwNCj4+DQo+Pg0KPj4gT24gMjkvMDUvMjAyNCAwOTowOCwgRGFu
IFdpbGxpYW1zIHdyb3RlOg0KPj4+IEhpIFpoaWppYW4sDQo+Pj4NCj4+PiBJIGRyb3BwZWQgbWVt
YmVyc0Bjb21wdXRlZXhwcmVzc2xpbmsub3JnIGZyb20gdGhpcyB0aHJlYWQuIElmIHRob3NlDQo+
Pj4gZm9sa3MgYXJlIGludGVyZXN0ZWQgdGhleSBjYW4gZm9sbG93IHRoaXMgZGlzY3Vzc2lvbiBo
ZXJlOg0KPj4+DQo+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8zNjEwNmZjZi0xMDYyLTQ5
NjEtODkxOC00NDcxZmQzMTNhNzRAZnVqaXRzdS5jb20NCj4+Pg0KPj4+IE90aGVyd2lzZSwgdGhl
IHdheSB0aGUgd2lkZXIgTGludXggY29tbXVuaXR5IGxlYXJucyBhYm91dCBjb25zb3J0aXVtDQo+
Pj4gZGVsaWJlcmF0aW9ucyBpcyB0aHJvdWdoIG5ldyBwdWJsaXNoZWQgc3BlYyByZXZpc2lvbnMu
DQo+Pg0KPj4gQWdyZWVkLiB0aGFuayB5b3UuDQo+Pg0KPj4NCj4+Pg0KPj4+IFpoaWppYW4gTGkg
KEZ1aml0c3UpIHdyb3RlOg0KPj4+PiBIZXkgQ1hMIGFuZCBMaW51eC1DWEwgY29tbXVuaXRpZXMs
DQo+Pj4+DQo+Pj4+IEkgYW0gdHJ5aW5nIHRvIHVuZGVyc3RhbmQgaG93IHRoZSBjdXJyZW50IGhh
cmR3YXJlIGFuZCBzb2Z0d2FyZSBjYW4gd29yaw0KPj4+PiB0b2dldGhlciB0byByZXN0b3JlIHRo
ZSBwcmV2aW91cyByZWdpb24vSW50ZXJsZWF2ZSBTZXQgY29uZmlndXJhdGlvbiBmb3IgQ1hMDQo+
Pj4+IHZvbGF0aWxlIG1lbW9yeSB1cG9uIHRoZSBuZXh0IGJvb3QsIGJ1dCBJIGRvbid0IGhhdmUg
dGhlIGFuc3dlciB5ZXQuDQo+Pj4+IFRoZXJlZm9yZSwgSSBoYXZlIHNldmVyYWwgcXVlc3Rpb25z
IGFuZCBob3BlIHlvdSBjYW4gcHJvdmlkZSBzb21lIHN1Z2dlc3Rpb25zDQo+Pj4+IGFuZCB0aG91
Z2h0cy4gVGhhbmsgeW91Lg0KPj4+Pg0KPj4+PiBRMSwgRmlyc3QsIEkgd291bGQgbGlrZSB0byBh
c2sgYWJvdXQgdGhlIHNjb3BlIG9mIExTQS4gQWNjb3JkaW5nIHRvIENYTCByMy4wDQo+Pj4+IHNl
Y3Rpb24gOS4xMy4yLCBpdCBzZWVtcyB0aGF0IExTQSBhcHBsaWVzIHRvIENYTCBtZW1vcnkgKGlu
Y2x1ZGluZyB2b2xhdGlsZQ0KPj4+PiBtZW1vcnkgYW5kIHBlcnNpc3RlbnQgbWVtb3J5KSwgYnV0
IGl0IGRvZXMgbm90IGV4cGxpY2l0bHkgc3RhdGUgd2hldGhlciBMU0ENCj4+Pj4gaXMgbWFuZGF0
b3J5LiBNeSB1bmRlcnN0YW5kaW5nIGlzOg0KPj4+PiAtIExTQSBpcyBtYW5kYXRvcnkgZm9yIHBl
cnNpc3RlbnQgbWVtb3J5DQo+Pj4+IC0gTFNBIGlzIG9wdGlvbmFsIGZvciB2b2xhdGlsZSBtZW1v
cnkNCj4+Pj4gSXMgdGhpcyB1bmRlcnN0YW5kaW5nIGNvcnJlY3Q/DQo+Pj4NCj4+PiBJIHdvdWxk
IHNheSBpdCBkaWZmZXJlbnRseS4gTFNBIGlzIG1hbmRhdG9yeSBmb3IgcGVyc2lzdGVudCBtZW1v
cnksIGFuZA0KPj4+IGlycmVsZXZhbnQgZm9yIHZvbGF0aWxlIG1lbW9yeS4NCj4+DQo+Pg0KPj4g
QW5vdGhlciByZWFzb24gZm9yIG15IGFib3ZlIHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0aGUgY3Vy
cmVudCBRRU1VDQo+PiBkb2N1bWVudGF0aW9uWzFdIGFsc28gc3RhdGVzIHRoaXMsIGFuZCB0aGUg
YWN0dWFsIGNvZGUgYmVoYXZlcyBhY2NvcmRpbmdseQ0KPj4gKG1hbmRhdG9yeSBmb3IgcGVyc2lz
dGVudCBtZW1vcnkgYW5kIG9wdGlvbmFsIGZvciB2b2xhdGlsZSBtZW1vcnkpLg0KPj4NCj4+IFsx
XSBodHRwczovL2dpdGh1Yi5jb20vcWVtdS9xZW11L2Jsb2IvNzlkNzQ3NWYzOWYxYjBmMDVmY2Ix
NTlmNWNkY2JmMTYyMzQwZGM3ZS9kb2NzL3N5c3RlbS9kZXZpY2VzL2N4bC5yc3Q/cGxhaW49MSNM
MzI0DQo+Pg0KPj4gQW55b25lIGhhdmUgb3RoZXIgb3BpbmlvbiBvbiB0aGlzPw0KPj4NCj4+IEhv
cGUgdGhlIENYTCBjb25zb3J0aXVtIGNhbiBoZWxwIG9uIGNvbmZpcm1pbmcgb24gdGhpcyBwb2lu
dCB0bw0KPj4gbWVtYmVyc0Bjb21wdXRlZXhwcmVzc2xpbmsub3JnIHByaXZhdGVseS4NCj4+IChD
dXJyZW50bHkgdGhlIG9yaWdpbmFsIG1haWwgY2Fubm90IHJlYWNoIG1lbWJlcnNAY29tcHV0ZWV4
cHJlc3NsaW5rLm9yZw0KPj4gdW50aWwgZ2V0dGluZyBpdHMgYXBwcm92YWwpDQo+Pg0KPiANCj4g
SnVzdCB0byBiZSBjb25jcmV0ZToNCj4gDQo+IENYTCBTcGVjIDMuMTogOC4yLjkuOS4yLjMNCj4g
DQo+ICJUaGUgTGFiZWwgU3RvcmFnZSBBcmVhIChMU0EpICpzaGFsbCBiZSogc3VwcG9ydGVkIGJ5
IGEgbWVtb3J5IGRldmljZQ0KPiB0aGF0IHByb3ZpZGVzIHBlcnNpc3RlbnQgbWVtb3J5IGNhcGFj
aXR5IGFuZCAqbWF5IGJlKiBzdXBwb3J0ZWQgYnkgYQ0KPiBkZXZpY2UgdGhhdCBwcm92aWRlcyBv
bmx5IHZvbGF0aWxlIG1lbW9yeSBjYXBhY2l0eSINCg0KVGhhbmtzIGZvciB0aGUgcmVmZXJlbmNl
LCBJIG1pc3NlZCBpdCBiZWZvcmUuDQoNCg0KPiANCj4gRm9yIHBlcnNpc3RlbnQ6IFJlcXVpcmVk
DQo+IEZvciB2b2xhdGlsZTogT3B0aW9uYWwNCj4gDQo+IFdoYXQgRGFuIGlzIHNheWluZyBpcyB0
aGF0IGFuIHZvbHRpbGUtb25seSBkZXZpY2Ugd2l0aCBhbiBMU0EgaXMNCj4gcG9zc2libGUsIGJ1
dCB0aGUgTFNBIGlzbid0IHBhcnRpY3VsYXJseSBub3ZlbCBvciB1c2VmdWwgc2luY2UgdGhlDQo+
IGRhdGEgaW4gdGhlIHZvbHRpbGUgcmVnaW9uIGlzIGRlc3Ryb3llZCB3aGVuIHRoZSBkZXZpY2Ug
aXMgcmVzZXQuDQo+IA0KDQpXZWxsLCBJIG1pc3VuZGVyc3Rvb2QgdGhpcyBpbiB0aGUgcHJldmlv
dXMgcmVwbHkuDQpNYW55IHRoYW5rcyBmb3IgeW91ciBleHBsYW5hdGlvbiBvbiB0aGlzIHBvaW50
Lg0KDQoNCj4gUmVjb3JkaW5nIHRoaW5ncyBsaWtlIGludGVybGVhdmUgc2V0IGNvbmZpZ3VyYXRp
b25zIGluIExTQSBkb2Vzbid0DQo+IHJlYWxseSBtYWtlIHNlbnNlLCBnaXZlbiB0aGF0IGRldmlj
ZXMgcHJvYmFibHkgc2hvdWxkbid0IGtub3cgYWJvdXQgZWFjaA0KPiBvdGhlciwgYW5kIGFuIGlu
dGVybGVhdmUgc2V0IGtpbmQgb2YgaW1wbGllcyBrbm93bGVkZ2Ugb2Ygb3RoZXIgZGV2aWNlcy4N
Cj4gPiBTbyBhcyBEYW4gc2FpZDogQW4gTFNBIGlzIGlycmVsZXZhbnQgZm9yIGEgdm9sdGlsZSBk
ZXZpY2UuICBBbnl0aGluZw0KPiB5b3UnZCB1c2UgaXQgZm9yIGlzIHByb2JhYmx5IGJldHRlciBh
Y2NvbXBsaXNoZWQgc29tZSBvdGhlciB3YXkuPiANCj4+Pg0KPj4+IFRoZSBleHBlY3RhdGlvbiBp
cyB0aGF0IEJJT1MsIG9yIHRoZSBPUyBmb3IgaG90cGx1ZyBkZXZpY2VzLCBkZXBsb3lzIGENCj4+
PiBkZWZhdWx0IHJlZ2lvbiBjb25maWd1cmF0aW9uIHBvbGljeS4gVGhhdCBwb2xpY3kgaW4gdGhl
IGNvbW1vbiBpcyBsaWtlbHkNCj4+PiBvbmUgb2YgZWl0aGVyIG1heGltaXppbmcgcGVyZm9ybWFu
Y2UgKG1heGltaXplIGludGVybGVhdmUgYWNyb3NzDQo+Pj4gaG9zdC1icmlkZ2VzKSwgb3IgbWF4
aW1pemluZyBlcnJvciBpc29sYXRpb24gKGNyZWF0ZSBhbiB4MS1pbnRlcmxlYXZlDQo+Pj4gcmVn
aW9uIHBlciBlbmRwb2ludCkuDQo+Pj4+IFdoYXQgaXMgY3VycmVudGx5IG1pc3Npbmcgb24gdGhl
IExpbnV4IE9TIHNpZGUgaXMgYSBkZWZhdWx0IHBvbGljeSBmb3INCj4+PiB1bm1hcHBlZCB2b2xh
dGlsZSBjYXBhY2l0eSBhZnRlciBhbGwgaW5pdGlhbCBkZXZpY2UgcHJvYmluZyBoYXMNCj4+PiBj
b21wbGV0ZWQuDQo+Pg0KPj4gSSB3b3VsZCBzYXkgSSBjYW4gaW1hZ2luZSB0aGUgcG9saWN5IHlv
dSBtZW50aW9uZWQuICpwb2xpY3kqIHdvdWxkIHdvcmsNCj4+IG9uIHNvbWUgY2FzZXMsIGJ1dA0K
Pj4gRm9yIGEgY3VzdG9taXplZCByZWdpb24sIGEgZGVmYXVsdC9wcmVkZWZpbmVkICpwb2xpY3kq
IGlzIG5vdCBzdWZmaWNpZW50Lg0KPj4gSW4gbXkgbWluZCwgYSBjdXN0b21pemVkIHJlZ2lvbiBj
b3VsZCBiZSBjb25zdHJ1Y3RlZCB3aXRoIHBhcnQgb2YgYWxsDQo+PiB0aGUgYXZhaWxhYmxlIG1l
bWRldnMoU0xEL01MRC9EQ0QpLCBhbmQgY3VzdG9taXplZCBpbnRlcmxlYXZlIHNldC4NCj4+DQo+
PiBTbyB0aGUgdGhlIHByZXZpb3VzIHVzZWQgY29uZmlndXJhdGlvbnMgaW5jbHVkaW5nIG1lbWRl
dnMgYW5kIGludGVybGVhdmUgc2V0DQo+PiBzaG91bGQgYmUgc3RvcmVkIGluIGEgcGVyc2lzdGVu
dCBzdG9yYWdlIHRoYXQgdGhlIHJlZ2lvbiBjYW4gYmUgcmVzdG9yZWQNCj4+IGNvcnJlY3RseS4N
Cj4+DQo+IA0KPiBUaGVyZSdzIGFueSBudW1iZXIgb2YgcmVhc29ucyB0aGlzIGlzIGEgYmFkIGlk
ZWEsIHRoZSBtb3N0IG9idmlvdXMgb2YNCj4gd2hpY2ggaXMgdGhhdCB5b3VyIHJlY29yZGluZyBp
bmZvcm1hdGlvbiBhYm91dCBhIHNldCBvZiBkZXZpY2VzIG9uIGVhY2gNCj4gZGV2aWNlLiAgV2hh
dCBpZiBzb21lIG9mIHRob3NlIGRldmljZXMgZ28gYXdheSAob3IgYXJlIHVwZ3JhZGVkLCBjaGFu
Z2UsDQo+IHdoYXRldmVyKSBhbmQgeW91IG5lZWQgdG8gZG8gc29tZXRoaW5nIGRpZmZlcmVudD8g
V2hhdCBpZiB5b3UgbW92ZSB0aGF0DQo+IGRldmljZSB0byBhbm90aGVyIG1hY2hpbmU/ICBUaGUg
c3RhdGUgbWFjaGluZSB5b3UgY3JlYXRlIHdpdGggdGhpcyBzZXR1cA0KPiBpcyBwcmV0dHkgYXdm
dWwuICANCg0KSSBzdXNwZWN0IGluIGFuc3dlcmluZyB0aGVzZSBxdWVzdGlvbnMsIHlvdSBlbmQg
dXANCj4ganVzdCByZXNvbHZpbmcgdG8gc2F2ZSB0aGUgY29uZmlndXJhdGlvbiB0byBkaXNrIGlu
c3RlYWQgb2YgdGhlIExTQXMgLQ0KPiB3aGljaCAoYXMgRGFuIHNhaWQpIG1ha2VzIHRoZSBMU0Eg
aXJyZWxldmFudC4NCj4gDQoNCkluIG15IHVuZGVyc3RhbmRpbmcsIExTQSBSZWdpb24gTGFiZWwg
c2hvdWxkIGluY2x1ZGUgdGhlIG5lZWRlZCBpbmZvcm1hdGlvbg0KdG8gcmVzdG9yZSB0aGUgcHJl
dmlvdXMgaW50ZXJsZWF2ZSBzZXQoYWNyb3NzIG1lbWRldnMpLiBPZiBjb3Vyc2UsIHRoZXNlDQpp
bmZvcm1hdGlvbiBvbiBMU0EgYXJlIGRpZmZlcmVudCBmcm9tIHRoZSBvbmUgc2F2ZWQgaW4gdGhl
IGRpc2suDQoNCg0KPiBSZWFsbHkgd2hhdCB5b3Ugd2FudCBpcyBhIHNtYXJ0ZXIgZGFlbW9uIHRo
YXQgZGV0ZWN0cyB0aGUgdG9wb2xvZ3kgYW5kDQo+IGltcGxlbWVudHMgdGhlIGJlc3QgcG9saWN5
IGdpdmVuIHRoZSBjdXJyZW50IGVudmlyb25tZW50Lg0KDQoNCkFueXdheSwgSSB0aGluayBJIGhh
dmUgZ290dGVuIHRoZSBhbnN3ZXIgZnJvbSB5b3VyIGFuZCBEYW4ncyByZXBseS4NCg0KVGhhbmtz
IGFnYWluLA0KDQpaaGlqaWFuDQoNCg0KPiANCj4gfkdyZWdvcnk=
