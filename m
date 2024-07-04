Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82711E507
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jul 2024 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098532; cv=fail; b=M7cn0jIJx3l6RSUVv6UZ2ywbhIKV3H92cevEJEtwgMD1WSE4UDE8YAAvSPPIW23UZ0857W2Pst8FB0joaFBUGzVubY7/wzvN4OCJMOfVHzcaQ9YCIMtAPzwVyOKAMZzQHfJQV2qr4k0URMlV5rCfIfOBL6Tfa8s3UoW9s74hYho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098532; c=relaxed/simple;
	bh=uxuozb+DjtobGRSPUtlZ/lFznE9vZZv6fF4RnU+f/sE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FTrEaEge8ZlUHxFMvrfotjRpf4dlrFRxN6Zom1oQJg8daVBst5ePPJmuaUSRpV8AfXXRRZ9ZCAACeYHwz3LiqCK7OYMO7I8yTNZPG/Mu/Tydcney5llxNlD5yvrx8y8IhhsvWIahjitya+a4CXEfZIRmO/Kl3yWpqlU8HgVo/gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=iAUNrghS; arc=fail smtp.client-ip=68.232.159.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="iAUNrghS"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1720098529; x=1751634529;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uxuozb+DjtobGRSPUtlZ/lFznE9vZZv6fF4RnU+f/sE=;
  b=iAUNrghS1DmD6b8pfz/K3eyCEZ8rDWcbWDPPuxiYvWtsM9gVuVNgr354
   HYJUCNzm81t0a/kJjz+qKPikXC/oSKyn4tvGpqkOaBy8n7cGSiIrP1GEQ
   Zh3Ar4yMOEILbwd3yHTQfsG1WZlKsRBM4TpAxaKEeBSuUq7Tw8uJVArh5
   1h+8Wj/e3U5ctgA3wX6SbaU6chZzKFWFt2TDSop4HDEzilBtszt9xlqL/
   PjHJyTLGFPl0ZdpgMuQoYT4IY5ZyvvcMQsfzZDRlkfnwtwL0hviVYqlDd
   nQ0PdL6qwluaamC8OzLozVxy0cOb8pLJYgO1HgbGuod6xSS1gqvpEYZfm
   Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="124341494"
X-IronPort-AV: E=Sophos;i="6.09,183,1716217200"; 
   d="scan'208";a="124341494"
Received: from mail-japaneastazlp17011027.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.27])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 22:07:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDaiGJitvKczxYMqow0vhg1GB8eMWbJZq9lMIK09NFNwAFmwn8xv5KRchWOesQSMvAWFK4aSqQRvnfjJN/qpaua95dc2ubvOHmSKLua5S4N9iDLYMcTxDXzVgmR04ZOErPqJkzBygndpdiuGMBzj6yM4zclEOP3QsL0UySuKDLZl0cYTOaFPBo7sGZWK/0W3rJX0KxDWERanlerggg2D9+tsoHB+tGlfbHldhPqThe0oWG6D/sDbygYhUSZ06IfDpm8w8FuYgVZqinSDX3g79bEbI6Y4jt46/aYp2fzbwPWTNA8an2DCZYjnY63Z4iAnGAxkS1VqTwOuASVNwIIaeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxuozb+DjtobGRSPUtlZ/lFznE9vZZv6fF4RnU+f/sE=;
 b=PigwV+a+KyPuqyVNTvRE/n+60Y466PrXuV0SPJcJbXsw5M5BmMWKMTK8fzuf/QSP7KyDYwZt9IYlleQsIj08uTqkQ97BA8BzyoEuRyU6Z+QJP4OTN9Nmh3GZef4bcqmHPZqzPWqteq/r7YVOzn1E+Qj1RJjvKm85mHrzDwX6kP5rvg5Jm2qNSQ7m+Iup5WXNAE6qehfRvbdRPRHXOioHmfD7mkkDJRamKfgh1pH/BT9CCxCgYPdFjCuXKoqOu6c0HJQgWuU7epDqrBCpOozQ5suvQX38+nWmBZgCu929rTMsXkqBeTLxuLI9olyTf79PBaVoYwuF+x/uRPJkEi7VGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYBPR01MB5343.jpnprd01.prod.outlook.com (2603:1096:404:8029::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Thu, 4 Jul
 2024 13:07:31 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%3]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 13:07:31 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: David Hildenbrand <david@redhat.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "Yasunori Gotou
 (Fujitsu)" <y-goto@fujitsu.com>, Oscar Salvador <osalvador@suse.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Xingtao Yao
 (Fujitsu)" <yaoxt.fnst@fujitsu.com>, Zi Yan <ziy@nvidia.com>, Johannes Weiner
	<hannes@cmpxchg.org>
Subject: RE: [BUG ?] Offline Memory gets stuck in offline_pages()
Thread-Topic: [BUG ?] Offline Memory gets stuck in offline_pages()
Thread-Index: AQHay1WPxUzjMyg7CkuuR0PTwAGqKbHmNSqAgAAIj4CAAEzUAA==
Date: Thu, 4 Jul 2024 13:07:31 +0000
Message-ID:
 <TY1PR01MB15629DC0310EB36C655E4465A5DE2@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <6a07125f-e720-404c-b2f9-e55f3f166e85@fujitsu.com>
 <5a4ef056-73c7-42e9-a839-43d42f8b7eab@fujitsu.com>
 <95b2bba5-7652-48d8-b6ec-bae7faeed501@redhat.com>
In-Reply-To: <95b2bba5-7652-48d8-b6ec-bae7faeed501@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9OTU0YjQ4ZjMtNjY3YS00NjY5LWJlMzQtMzlkZTM0OWEx?=
 =?utf-8?B?NDI5O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjQtMDctMDRUMTI6NDk6MzBaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYBPR01MB5343:EE_
x-ms-office365-filtering-correlation-id: ec6ddcb0-818b-4c5b-d35e-08dc9c2a43a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dFh5aXV3TWo1alkrRE5uNXJSRnlhMUk2MDZEdERnRUhSbTJyUnAzQUljQmhY?=
 =?utf-8?B?dVA3bDJZTVo0RHgzY3RNNjRma3FRWEJ3eEZUSGZXWDBRTUJIUytydzNuNitM?=
 =?utf-8?B?MElmb3BONnIwTDRuNGF4YVBLUkNvTU05ZkNVQVlhVWJqbk8vVmduQVV1TDZV?=
 =?utf-8?B?Zks3ZU90endVYlRJaVo5N0tqSE0xUE1iblZuVHRjQTcvRlFIRElqamFBajFL?=
 =?utf-8?B?MndRcG8wdnIrK2tnSEx1M2VhSS9hLytJU25DK1hVUFVvVThFWVV6SE1xOFJL?=
 =?utf-8?B?SmRwVVVnT3N0RjdDVGg4Mkp0SzU2QWtvUHZKWFhJdWc3MXNWcXpva0xXV1Fa?=
 =?utf-8?B?cko0dXNPWEN1VGp4Zk1tMHJzL0tIZUVKaGRIMlk3eTNURmFPMCtCbGhKMitO?=
 =?utf-8?B?Tm5tZFpTT0JCeFR6RGQyK2VWcE1sWkdnalptbU9kNU9GSXBKUHpCeTNuc1dy?=
 =?utf-8?B?ZnJhU1ZOdDZMYzlMbVh5Z3FoWnVSTjVsRldnYVpRNEZnd0RGYm1yT3YzTVk3?=
 =?utf-8?B?M1kxOEx1Q2psTzZZSmdJUlhnUm90TXNDWTBwS0s5UVpwT3J3Y01RUXJmcUtj?=
 =?utf-8?B?cVFDVG1oNTRidmYybllqQnh6OFRzRGRMMGdoVFF4UmVTbTZuUUhXRlN3c1V0?=
 =?utf-8?B?WjQrN2dMWWtjcUNtNUMrUVArWDhqQnM1NlU5WHN4N3R0ZjlBR2k2MS9BM2hK?=
 =?utf-8?B?MklUbUJFTWQrbmhMSXltbmpkRmxDdkVTTXRZZ0JZRWkvZ09RTXZNcENSdm16?=
 =?utf-8?B?bGpWNGpOSzJpWWEvRzZaZkNNVXZSNkpKUXFYYXNlMjNNV3lOR2lyTExyQVlX?=
 =?utf-8?B?R29CaUttOFAxc2lRNGwwL2xTcDY2dFpsbVhPZmFSRGtkTFBVblBtQkc2dHZo?=
 =?utf-8?B?K2RZSSsvL0E2UjA1a1B5YkNybHJVNjkzbVJlTGVMem9DbG16a09sR0xzNzFW?=
 =?utf-8?B?WnpXTDYxYWJVNFRPaFlzNzJlbURiOU1RMUZvZnJ0VTZkWlVNL21KTTg1cVlU?=
 =?utf-8?B?bGs4QWpPQXhFNGVra3RTZlRjN2tuVyt5MDhpYkJxK1hQS1lrNXpkOTB6OFNr?=
 =?utf-8?B?Y2dLVHFVSmNJbU1CSnNBblVNODU4R2pIVy8vdUJtVWlCOGlEdXFZZjdObWhJ?=
 =?utf-8?B?N2VwOGJ3SEZBL1hoTVZaMUNuNzA1NFhDMWRmUnV2VXVoQlNhY29WUU5wa29s?=
 =?utf-8?B?ZkwxSmJBOUFXYkZyNVd4U1U1OWJOWS9SamM1T1VmVGJSMHo1bE8yWTY2eTZV?=
 =?utf-8?B?amFPOERiakttWUM2SGk4S1pxOUlkSFZDYTVNUWg2TkNUSFhNdUtmbHNQOFhw?=
 =?utf-8?B?YldWeWtHa3k0dmIwOUhxWGkzdE1FWDk2UzFRdENiVTdHM1IzTy9kRmFjaGdV?=
 =?utf-8?B?Nm1uWDJLYitXWXg2TlVYYUdGQ3NLMWpVWWVqcm15OHFUQk1sTXNlNldTdkhz?=
 =?utf-8?B?MDFKRTlFbDE3ejc2eHEvNXZBcjB0RHV3UDZXOUdxQi9WQ1VoZGpWRDR1RlZa?=
 =?utf-8?B?K29lYnJqSE1XYVhsRnpxN005T0xnV1FpRWJRbjV4RTd5alR3ajZ4OUFsMzFq?=
 =?utf-8?B?NVVqUERxb1Jtcjk3b0x0ZmZRaTZLL0lwYXIvZHkwWFI4WDdqRG8yd3k3TE5r?=
 =?utf-8?B?ZzhDOXBHYzMrNzBpZVMzekN4WTFjNlNTQW56OU1RTFFWVDNIZXdHQWdHZzFy?=
 =?utf-8?B?T2drbkd2M2h6UndtWnBKZTM4NklldTdiT3c3MXdCTExpaXpuRytjeng5ZUZT?=
 =?utf-8?B?dVFOeGcvRkxteGEwK3RtVzB0RXZCMCs4ZHRYZDRJZUl1SFMxUGdZSWJ6ckVW?=
 =?utf-8?B?UW5CdlZlZmZDalpFUS9HcFVYYjFKNUN5QXlralNnK2xZa1R2TnB0ZUdtUGw1?=
 =?utf-8?B?VndSWU1YODFhU2UyR1Z0VWdsSlIwUmNzZ2FZWUxlMzVkMndoeTdkZ05EZkFP?=
 =?utf-8?Q?MB1I2EuoNsA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SkM5WC9GdkJDSTJoS1NnYkNYejhIVVNkWFJiSjQ4MFBrRy9GWm1NZ0o0WFhF?=
 =?utf-8?B?Z0VWcHhrMUpGUktKTTdtOTN6TzBKRkFDVFdFV2dhVXlVVnAzaGs1dTJzclVw?=
 =?utf-8?B?WmpkdkxNVTk5QVlwMTRnbXd0cDBaRXA2cVVaZGkxUW5aN1VzV25yWEdRK3Mx?=
 =?utf-8?B?U0Y3VE52dDZPc3RWdlNnSmp1WDlCbitmZ0FKSG5vQjFwQXhIZXk3SkRYcEp6?=
 =?utf-8?B?cGxKQlhzU3Y3QmtqNGtwZHVhSkhpSUVsVFVod2tXQndYT3AvY0NDdjBaTzVy?=
 =?utf-8?B?VVNEMjhTZVpPSkFpc1FQSTZZN0toVmdCZ2EzVjdkbkM1a2MwQ0FqdXhUeEJh?=
 =?utf-8?B?MkdnQTB4NHZISGwvTjhodFJaSWxsYkxVWkN0RVRtb0dtK2dRSkJFRFkzWWFF?=
 =?utf-8?B?N3BzN1o1SC9hZ20wQnZ1YytXR0hqd0ZYd0NseXZsckFvSjgvay9vYmNKcjM5?=
 =?utf-8?B?QmNRS2FGSU1JazR4YXFsa01NSytGREJaVnhMZVZOenNobnh1TUlsN1V2d2NX?=
 =?utf-8?B?dTc1Qm5kcG1tU0ZSZkRWZmg5TlZuaHk2QmNReWpWWXdJYTJSNUJ5Wk0wKzhT?=
 =?utf-8?B?WXk4cnNLS0hZSWM4dFBGbUVaNTR5Y2E1dkg0TFFsNjltYWxGcGk2VjRpS1J2?=
 =?utf-8?B?M0liaEJLWnpWSldnMjBHakFvSWVaY2tON3RIN25mcHlLdC9kZlhDUUYzb21B?=
 =?utf-8?B?WjVnbitLUEVWYVYwemZLaUxBZEZXUG1vQkU3RVZmS1NEOEF5cktCWkVLMW44?=
 =?utf-8?B?YS84V0VGS20zMXBNRmJsdThIYU55akdlYzZaS2JwbG1ET0dpcHVRRjhKWEIr?=
 =?utf-8?B?aFFkcVpSTGV2SFVOT3lKQnc3ODIvYTloSDF0ajlxRWxBQlI3OGZrUmlNc3Yz?=
 =?utf-8?B?czRlMnZtQVRpbWNJRjNqbEhLVFh1eTAva3dNS2pES2dJT3RlS01EeVE0aUhy?=
 =?utf-8?B?TWdvTytwVG8vYktGNldPR29XdzhkaUdrUXE0djEwbFlJeE1PSis4T1hCRXdY?=
 =?utf-8?B?YXhtbjdPeExTdmNsWWJjSUFpc0N1NG8rc0x1L2VsbUc4L3RPYlZDSUhQdzVK?=
 =?utf-8?B?SDRlK2pQV0NJUVVVMFZ0cWtJcFlZS2p3U0p6Mk9uVy80Vno3RVVQMUorQUww?=
 =?utf-8?B?UkdGdm9UeFBxRldsQ3RlM1liMEZYc1hxT0N1MjFqWnZIUW5oWTk1WGdLS0Rl?=
 =?utf-8?B?MTZYOGgxNk1DZ0tWNGJraE1LVlozWTl4eVRmUjlNTDZZTmVtbFE1OUdxS3Rl?=
 =?utf-8?B?cm40VjU3MFdFOWR1bmhQMGlVUmx1SWRhWUxxRkNQWTZwNWo1eEFXSTIvUFFv?=
 =?utf-8?B?ZGE5Q0ZvNHE4R0dFS1FOWlc3bjZKTW9aSFpleUIyZHlYUU9GNThOdlIxS0U1?=
 =?utf-8?B?WkxuakQ1bkJpeGZWY1kzbGgwOERFVnhGT0c0SHBUQWhMeWc2NHVoVEFCRklJ?=
 =?utf-8?B?M0VNY3cxZjZSalY5aTRTaUFTR3poQm5rdnp3SjBCZWhoaU0yNGNjSERQbXA2?=
 =?utf-8?B?K3FOeDdUUE85eGZsS25GUnJSMHVlN1JIVXFSTWtwNW5meVl6Skc4TTlzUGNO?=
 =?utf-8?B?L2RURXk4bnpPNnVRS285RVRnTTRvMlNqQytwWXZmZ3g5d0VWcFFJTVJOeGhX?=
 =?utf-8?B?c0hnTENBTTZGRzdFU1JLTmtyeFdveWZzbzF1d25mUVYvblltTkJEZmcxYWky?=
 =?utf-8?B?bTZZMVVicHh5WDAzNndhaFBFZE9qbERkUERDYVVCbWVsV0l5S1VSeXcxNkht?=
 =?utf-8?B?Z1JvVlNzdWltTHVnLy90RUlHS2IrY21zQ0tBYmZKTTduY1F5SWlrRk5qR0hO?=
 =?utf-8?B?UW5FYnNJR3FFaEhLT3VmMmx5djlsaUk0TERmUnlsWmQzcndBcEhBbEtKL1g0?=
 =?utf-8?B?dUZEZzVDSEVQWGVxUG9DQUxzVEZGdXZtbzNjRUl5dktHQkJrOXdhM3FWSTI2?=
 =?utf-8?B?c0R3WUdzT3pBVFladjVpYTBqYXdOczE4STEyTzBibEgzaTc1ODh4ZEpzV3Fa?=
 =?utf-8?B?YW9ieisvT3VSMVM5R3BmQ2JJTzhTQkh0cHRGVVB2dTQ0K3Y2WTFMbDVnRGFH?=
 =?utf-8?B?MXpHMys3UTYwcExaRTFUdjcxZmhVMEtyU2VHSlJjL1ZOZnFEVmNNNlhSVjV1?=
 =?utf-8?Q?dnHsN9t7eHRBBzUVtZjsoyPh7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	glrkuknwJxGL8E4srB2ydsQVus5LgrWkGJot5Ozo/VAHNw47W1+bsPTAN8XiyDPoLNi6Kpa3xCADHCT4bwAWWe/tu4IC/SqKmlvu+e3xZ+p34cQCVDyUxfFFUyjYFp6NcVIyI6h7r0cKIpbuZKf0WzlGTEa+A4/lhVa8IQ+b/lrCPNQpsBl+1Xmxd3y9I0laj4oQLUBwGZId2VziarKTL5YjNYM2LSQwrsBgdm7ydP96HNKvee3fYpgPcqCowRbHhuX+ljbB1qgZeKOo/HirD6qenDmIN+xzjyDJisNI4+YQVgnhfE6yleJ+uL5Y6rccX8r9HKDZZP0v6PafFGDd7SqsNzQBEtOP9n+zTBEsNSSqgnxvReh/yHoCjpomC+Nb4OYqI6W0nPu3sHrWPB6K4+eb3woDoIzRqt+qsTX0LZYd55yFRDsscHE3qjlx2Hl2l6Ftfr+SN9zPrgAw/MkKMaTvaPe3NxIkvRiGezYr1Z++IJTDmTsdR+M3kffrXv2qYxPXDro2dXIRjsCZkOpiU2mZDGOevpOfRa1Ufm07V9xd/emgWiq6fQMtXjB1bHRvu65clx78hMp5S5pfOBmEOrqKgSJIuulRgFzeqDThVbbUDwoUeJWjjuydb0ku0/B4
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6ddcb0-818b-4c5b-d35e-08dc9c2a43a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 13:07:31.6399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dNtMdHtFKGZYMF9yVK7ZKo9rrBJP6+SNVO1nUrNhCuh7Mh//xWR5qXPuDSu84/W1k1LgmqV8SQNRukEvV/dGKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5343

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgSGlsZGVuYnJh
bmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDQsIDIwMjQgNDox
NSBQTQ0KDQoNCj4gDQo+IE9uIDA0LjA3LjI0IDA5OjQzLCBaaGlqaWFuIExpIChGdWppdHN1KSB3
cm90ZToNCj4gPiBBbGwsDQo+ID4NCj4gPiBTb21lIHByb2dyZXNzIHVwZGF0ZXMNCj4gPg0KPiA+
IFdoZW4gaXNzdWUgb2NjdXJzLCBjYWxsaW5nIF9fZHJhaW5fYWxsX3BhZ2VzKCkgY2FuIG1ha2Ug
b2ZmbGluZV9wYWdlcygpIGVzY2FwZQ0KPiBmcm9tIHRoZSBsb29wLg0KPiA+DQo+ID4+DQo+ID4+
IEp1biAyOCAxNToyOToyNiBsaW51eCBrZXJuZWw6IHBhZ2U6IHJlZmNvdW50OjAgbWFwY291bnQ6
MA0KPiA+PiBtYXBwaW5nOjAwMDAwMDAwMDAwMDAwMDAgaW5kZXg6MHgwIHBmbjoweDc5ODBkZCBK
dW4gMjggMTU6Mjk6MjYgbGludXgNCj4gPj4ga2VybmVsOiBmbGFnczogMHg5ZmZmZmZjMDAwMDAw
MChub2RlPTJ8em9uZT0zfGxhc3RjcHVwaWQ9MHgxZmZmZmYpDQo+ID4+IEp1biAyOCAxNToyOToy
NiBsaW51eCBrZXJuZWw6IHJhdzogMDA5ZmZmZmZjMDAwMDAwMCBmZmZmZGZiZDllNjAzNzg4DQo+
ID4+IGZmZmZkNGYwZmZkOTdlZjAgMDAwMDAwMDAwMDAwMDAwMCBKdW4gMjggMTU6Mjk6MjYgbGlu
dXgga2VybmVsOiByYXc6DQo+ID4+IDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAwMDAwMDAwMCAw
MDAwMDAwMGZmZmZmZmZmIDAwMDAwMDAwMDAwMDAwMDANCj4gSnVuIDI4IDE1OjI5OjI2IGxpbnV4
IGtlcm5lbDogcGFnZSBkdW1wZWQgYmVjYXVzZTogdHJvdWJsZSBwYWdlLi4uDQo+ID4+DQo+ID4N
Cj4gPiBXaXRoIHRoaXMgcHJvYmxlbWF0aWMgcGFnZSBzdHJ1Y3R1cmUgY29udGVudHMsIGl0IHNl
ZW1zIHRoYXQgdGhlDQo+ID4gbGlzdF9oZWFkID0ge2ZmZmZkZmJkOWU2MDM3ODgsIGZmZmZkNGYw
ZmZkOTdlZjB9IGlzIHZhbGlkLg0KPiA+DQo+ID4gSSBndWVzcyBpdCB3YXMgbGlua2luZyB0byB0
aGUgcGNwX2xpc3QsIHNvIEkgZHVtcGVkIHRoZQ0KPiA+IHBlcl9jcHVfcGFnZXNbY3B1XS5jb3Vu
dCBpbiBldmVyeSBpbiBjcml0aWNhbCB0aW1pbmdzLg0KPiANCj4gU28sIGlzIHlvdXIgcmVwcm9k
dWNlciBnZXR0aW5nIGZpeGVkIHdoZW4geW91IGNhbGwgX19kcmFpbl9hbGxfcGFnZXMoKSBpbiB0
aGUgbG9vcD8NCj4gKG5vdCB0aGF0IGl0J3MgdGhlIHJpZ2h0IGZpeCwgYnV0IGEgY291bGQgZGF0
YXBvaW50IDopICkNCg0KWWVhaCwgIGl0IHdvcmtzIGZvciBteSByZXByb2R1Y2VyLg0KDQoNCg0K
PiANCj4gPg0KPiA+IEFuIGV4YW1wbGUgaXMgYXMgYmVsb3csDQo+ID4gb2ZmbGluZV9wYWdlcygp
DQo+ID4gew0KPiA+IAkvLyBwZXJfY3B1X3BhZ2VzWzFdLmNvdW50ID0gMA0KPiA+IAl6b25lX3Bj
cF9kaXNhYmxlKCkgLy8gd2lsbCBjYWxsIF9fZHJhaW5fYWxsX3BhZ2VzKCkNCj4gPiAJLy8gcGVy
X2NwdV9wYWdlc1sxXS5jb3VudCA9IDE4OA0KPiA+IAlkbyB7DQo+ID4gCQlkbyB7DQo+ID4gCQkJ
c2Nhbl9tb3ZhYmxlX3BhZ2VzKCkNCj4gPiAJCQlyZXQgPSBkb19taWdyYXRlX3JhbmdlKCkNCj4g
PiAJCX0gd2hpbGUgKCFyZXQpDQo+ID4NCj4gPiAJCXJldCA9IHRlc3RfcGFnZXNfaXNvbGF0ZWQo
KQ0KPiA+DQo+ID4gCQlpZihpcyB0aGUgMXN0IGl0ZXJhdGlvbikNCj4gPiAJCQkvLyBwZXJfY3B1
X3BhZ2VzWzFdLmNvdW50ID0gMTgyDQo+ID4NCj4gPiAJCWlmIChpc3N1ZSBvY2N1cnMpIHsgLyog
aWYgdGhlIGxvb3AgdGFrZSBiZXlvbmQgMTAgc2Vjb25kcyAqLw0KPiA+IAkJCS8vIHBlcl9jcHVf
cGFnZXNbMV0uY291bnQgPSA2MQ0KPiA+IAkJCV9fZHJhaW5fYWxsX3BhZ2VzKCkNCj4gPiAJCQkv
LyBwZXJfY3B1X3BhZ2VzWzFdLmNvdW50ID0gMA0KPiA+IAkJCS8qIHdpbGwgZXNjYXBlIGZyb20g
dGhlIG91dGVyIGxvb3AgaW4gbGF0ZXIgaXRlcmF0aW9ucyAqLw0KPiA+IAkJfQ0KPiA+IAl9IHdo
aWxlIChyZXQpDQo+ID4gfQ0KPiA+DQo+ID4gU29tZSBpbnRlcmVzdGluZyBwb2ludHM6DQo+ID4g
ICAgLSBBZnRlciB0aGUgMXN0IF9fZHJhaW5fYWxsX3BhZ2VzKCksIHBlcl9jcHVfcGFnZXNbMV0u
Y291bnQgaW5jcmVhc2VkIHRvIDE4OA0KPiBmcm9tIDAsDQo+ID4gICAgICBkb2VzIGl0IG1lYW4g
aXQncyByYWNpbmcgd2l0aCBzb21ldGhpbmcuLi4/DQo+ID4gICAgLSBwZXJfY3B1X3BhZ2VzWzFd
LmNvdW50IHdpbGwgZGVjcmVhc2UgYnV0IG5vdCBkZWNyZWFzZSB0byAwIGR1cmluZw0KPiBpdGVy
YXRpb25zDQo+ID4gICAgLSB3aGVuIGlzc3VlIG9jY3VycywgY2FsbGluZyBfX2RyYWluX2FsbF9w
YWdlcygpIHdpbGwgZGVjcmVhc2UNCj4gcGVyX2NwdV9wYWdlc1sxXS5jb3VudCB0byAwLg0KPiAN
Cj4gVGhhdCdzIGluZGVlZCB3ZWlyZC4gTWF5YmUgdGhlcmUgaXMgYSByYWNlLCBvciB6b25lX3Bj
cF9kaXNhYmxlKCkgaXMgbm90IGZ1bGx5DQo+IGVmZmVjdGl2ZSBmb3IgYSB6b25lPw0KDQpJIG9m
dGVuIHNlZSB0aGVyZSBzdGlsbCBhcmUgcGFnZXMgaW4gUENQIGFmdGVyIHRoZSB6b25lX3BjcF9k
aXNhYmxlKCkuDQoNCj4gDQo+ID4NCj4gPiBTbyBJIHdvbmRlciBpZiBpdCdzIGZpbmUgdG8gY2Fs
bCBfX2RyYWluX2FsbF9wYWdlcygpIGluIHRoZSBsb29wPw0KPiA+DQo+ID4gTG9va2luZyBmb3J3
YXJkIHRvIHlvdXIgaW5zaWdodHMuDQo+IA0KPiBTbywgaW4gZnJlZV91bnJlZl9wYWdlKCksIHdl
IG1ha2Ugc3VyZSB0byBuZXZlciBwbGFjZSBNSUdSQVRFX0lTT0xBVEUgb250bw0KPiB0aGUgUENQ
LiBBbGwgcGFnZWJsb2NrcyB3ZSBhcmUgZ29pbmcgdG8gb2ZmbGluZSBzaG91bGQgYmUgaXNvbGF0
ZWQgYXQgdGhpcyBwb2ludCwgc28NCj4gbm8gcGFnZSB0aGF0IGlzIGdldHRpbmcgZnJlZWQgYW5k
IHBhcnQgb2YgdGhlIHRvLWJlLW9mZmxpbmVkIHJhbmdlIHNob3VsZCBlbmQgdXAgb24NCj4gdGhl
IFBDUC4gU28gZmFyIHRoZSB0aGVvcnkuDQo+IA0KPiANCj4gSW4gb2ZmbGluaW5nIGNvZGUgd2Ug
ZG8NCj4gDQo+IDEpIFNldCBNSUdSQVRFX0lTT0xBVEUNCj4gMikgem9uZV9wY3BfZGlzYWJsZSgp
IC0+IHNldCBoaWdoLWFuZC1iYXRjaCB0byAwICBhbmQgZHJhaW4NCj4gDQo+IENvdWxkIHRoZXJl
IGJlIGEgcmFjZSBpbiBmcmVlX3VucmVmX3BhZ2UoKSwgc3VjaCB0aGF0IGFsdGhvdWdoDQo+IHpv
bmVfcGNwX2Rpc2FibGUoKSBzdWNjZWVkcywgd2Ugd291bGQgc3RpbGwgZW5kIHVwIHdpdGggYSBw
YWdlIGluIHRoZSBwY3A/DQo+IChlc3BlY2lhbGx5LCBvbmUgdGhhdCBoYXMgTUlHUkFURV9JU09M
QVRFIHNldCBmb3IgaXRzIHBhZ2VibG9jaz8pDQoNClRoYW5rcyBmb3IgeW91ciBpZGVhLCBJIHdp
bGwgZnVydGhlciBpbnZlc3RpZ2F0ZSBpbiB0aGlzIGRpcmVjdGlvbi4NCg0KDQpUaGFua3MNClpo
aWppYW4NCg0KPiANCj4gDQo+IC0tDQo+IENoZWVycywNCj4gDQo+IERhdmlkIC8gZGhpbGRlbmIN
Cg0K
