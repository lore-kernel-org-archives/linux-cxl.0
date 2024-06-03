Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A8B12B83
	for <linux-cxl@vger.kernel.org>; Mon,  3 Jun 2024 05:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717390947; cv=fail; b=NNiwrzU8CWwGBPBLDOpgfw3gcNds2Uqe2ZxjEkPcPciShUl4BGNaPSoQJYyWSgN31M0MgyFzwn9b9E9MFIoaqAemTnq/yDv118a3FBa0Dr6Q7iosArgyFaWJr816P6flbq1KUH8ekrujfnQvaswgIaf038fftyHn+TFzi/pX1ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717390947; c=relaxed/simple;
	bh=k+51YJGwzbPdxTll2di7aFzmTXGWpqKMaLd75fHyd5Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nubHbWrbWliMDDmWbEFxNhfHfnTet5iFy+YTD+pOcd7IqqqM2/t6VXAidCimSv10s0krz048NZml5iEr4m+OGeIbPKjdwtmjUwAfHV9SJZvdeGMDl/GyBY2L8JBQ9O0Z1arsW22/7FeqFcuzmPaWtAksiL6IUe7FW64Gn+dcx+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=J7BhqJ1E; arc=fail smtp.client-ip=216.71.158.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="J7BhqJ1E"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1717390945; x=1748926945;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k+51YJGwzbPdxTll2di7aFzmTXGWpqKMaLd75fHyd5Y=;
  b=J7BhqJ1EdOJnxII49W1IARLat91LeWcwWIcu7tPxOiZhN41HHM4ehj0M
   IMwXUfzaP/O5tTjCzYpcHcMppFJBxaYviy3bgGaDmxNaZBnmdvQGOUfS9
   vW/9L4uPLcGyFG+uTUQLL+htooCKeNa0htlSCxQi4d85yf6j/5u+1AHCK
   KZBTlrz75P2jIXJjP/1hk+Tj9tUvhMmGzGYN782WMKncrWEWUwyCpy3Yf
   X3MGX/jJ9gHAsz/LAcdmakmmNhHaCUTDT4aHFTUfGnRKlTtOgjggQSwZ/
   SBUDFCzVBvwnL87d/KYHlp2pX5d6jycyNWuJFJscBZ10gKfRO4S4dhJv/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="125828437"
X-IronPort-AV: E=Sophos;i="6.08,210,1712588400"; 
   d="scan'208";a="125828437"
Received: from mail-japaneastazlp17011004.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.4])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:01:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nz+9ppnRE7ljvjIQo/kziq2xBGdGDqEXYwYw1DMu46bdnwkBFr3YJ8AVUpffQX2JhZMl7YmpKEnKOMFvfT4VoL0TXPh66TWblXb51Ozi9TzFQ2YTCsfAHFstqBwO6l+uovrOh4f1lWvY+BM9jQJnTtv1b9528mqcT5m5I+r2Jymdk2cPrREt3c8H/Xy0VEYmkuoQUls+5oBYHD+j4GVLnvFZqt9eUVZEpG61TzEEY2f56g2cy06Wiu8mDM3+75km5YsXEzMePihytPU7x2qGsHiOUkz/sjeZjh5xhHzoFQdrmuAIXOmSbVa4nMxV7EWWFpN+UCh3UoUIPoF2BIZLCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+51YJGwzbPdxTll2di7aFzmTXGWpqKMaLd75fHyd5Y=;
 b=jSJQUFloTnFapEBjkoZaXtqoJXErawnf7g/KCAYw+FSS9VJPuFNBkbRO84e67MgYMROGf1blDaeRGzANGMQsZ8iX+VAhT+/u4B6EoOx6u+8jzG8vaxppVbD9izCknRy9OeSRLy8UWOPKmTlb1+qZ2R6/NtBJNYYxJrmm2Xgv8q630sbsH59gMAvfwxjlHHZH4aWjuwWXQLjsxDi4/0VLbmNFM88HywUFoZkfV49o01pK4xe8dTCS8UX7WKQrb5td0FERAhQ2ukycSjk7JCp4xI3KL9PazkDWaJ6dtHNABKunSa+B7MAAartbM3nkqG59FnFxkPgNmDPCemja6t+shg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com (2603:1096:400:1e3::8)
 by TYWPR01MB11079.jpnprd01.prod.outlook.com (2603:1096:400:396::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 05:01:07 +0000
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::9a0b:13f0:812b:69f5]) by TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::9a0b:13f0:812b:69f5%3]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:01:07 +0000
From: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To: 'Dan Williams' <dan.j.williams@intel.com>, "Zhijian Li (Fujitsu)"
	<lizhijian@fujitsu.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>
Subject: RE: CXL volatile memory: How to restore the previous
 region/Interleave set
Thread-Topic: CXL volatile memory: How to restore the previous
 region/Interleave set
Thread-Index: AQHarax7vZq9IL+jF06rZcpjK4vT97GtbiqAgABxLGCAA/9zAIADqMnA
Date: Mon, 3 Jun 2024 05:01:07 +0000
Message-ID:
 <TYWPR01MB100820191922456B1486BF7FA90FF2@TYWPR01MB10082.jpnprd01.prod.outlook.com>
References: <36106fcf-1062-4961-8918-4471fd313a74@fujitsu.com>
 <6656801ef0dea_1668729484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <TYWPR01MB10082738078CF843AF514F7E790F22@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <665a3996301f8_14afbd294d@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <665a3996301f8_14afbd294d@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9YTA3MmRkMDQtMGNkOC00NDQ4LTgxZDYtNTJhNzgwOTQx?=
 =?utf-8?B?YmVkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA2LTAzVDA1OjAwOjU0WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: eac3d53143e24141a92efd61a540af90
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10082:EE_|TYWPR01MB11079:EE_
x-ms-office365-filtering-correlation-id: d422c3de-7a8f-495d-5003-08dc838a2de4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|1800799015|366007|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y3p6cjFzQWpmWnZjWU9oR2ZPVG5uU3hlTktqb0ExeWNoZlpKd3lHOVBkaCsr?=
 =?utf-8?B?enRTWXRvSkNsd1lFR0RDWEk3R0h0dldzMERGS2JuR1NtY2UwMTJoaDdJOFdB?=
 =?utf-8?B?ZVJ6cFZMaUM5R3ZpVFZKR1VmZU5nZWp3cDRkanFibkhibXBuV3h0Ny91Zysv?=
 =?utf-8?B?ZjZwWkVnWS91bmFXZlBEanptZUl3SDJtVmJkUW1rQXZBc1dMaUQ3TDI1R1JK?=
 =?utf-8?B?REErVUN3cHlKTXozRVJnVC93RmNraHBpV3VlbkxncjNWakFkeTREQTBuYVpx?=
 =?utf-8?B?RmdQVkhTZ1hjZytpV2Qzcm1pZStDUDExODVCeWR4U3NtWE1qNncvZk9qS3U5?=
 =?utf-8?B?RUFKRlFJbkJIR3BGMUcrTU44UzBFTU1jVm9VS25pSGVPbjBhS3dQQ2h5MnI4?=
 =?utf-8?B?T3o3ZHpHcGZGU1d6bGtDUmEyWmhPaFF4RXZWMkhBZDVrd2NhZkVjS0YwY0M2?=
 =?utf-8?B?ZGMvZGt2UWpFemNFZ2xTc0RCcUlwcVgvQmVRaVE5aS9KRCtmWlNRZzNWQkdh?=
 =?utf-8?B?NmFwTHZqblNFZ0QvdktRTktKT1JBTzJrN1cxWXk4VzIwRUNhRjU5aE9FT1ll?=
 =?utf-8?B?bXRkbXFTcXNCUjBaSUx1Z2lvdjZGU0dDUHFVY1M4S0VpTVlTSWszWmdiL3U5?=
 =?utf-8?B?U1dsWnZoZWtGcnBTelVGQWRjYWJPSlBaWnIzTCsyME0rRTEyWk5vaUdGNThN?=
 =?utf-8?B?em4xc1RHMWpNOXJ5blFNVFV4Ujl2YzY1aTZLeFpyakdZS2U4dGF2MEtPT2k0?=
 =?utf-8?B?VXJVajJidWVaS3lWSFBjdFZwM1FUVmF4YytiOFZDeTN5dUpDVXJxK2ZuWUlv?=
 =?utf-8?B?M0VIRFM3RjFyWWd1bTAxMDVSNWVGaDlNL3U1N0FYUnBLWXVGeHhxYVZrc0NY?=
 =?utf-8?B?anBveXY5N203SlVFZ3dyY1dxMmVKcnE5WWllZFdIelFzMHJsNVdjUDdsNkZP?=
 =?utf-8?B?L1hrTmFmS0JMUHo1cEMwRis0Q2xQdXRWMjNUOE1IYTRsUk13Z3QrSFJnMzZu?=
 =?utf-8?B?bjd6NTh3TDVKMG94eHo3cDFrM082bGV0aSt1TnVyME1XK0pueFloT0hkMGo5?=
 =?utf-8?B?cS9VTUtDMXdwb2Flb3lZeXlBK2JwK0tJdEtLUDBZbEhST296dHFXMWZkYlVV?=
 =?utf-8?B?S3Y2aFZEWC9HeVJIc0o5elA0Umx0WHRldU1wMGtZZERRcHdHNkRsdGNCelBX?=
 =?utf-8?B?Q3IxRWR2bmJRbUhYYzlqU3F0REU0TkdmdU1kZFVaT2JiWGdzdzJEYWViWm43?=
 =?utf-8?B?ZTZVSkdNcXFQSXprY2owZCtFMVI3VHl3ZTNUV3l6dWdicVc0RHNEN291SnhN?=
 =?utf-8?B?S3ZxNkZlUzdwYXZ2eDdISFptZU9RZ3NwYjVwdHBzb0hiVCt1Nms4VGUxMHd4?=
 =?utf-8?B?VzRvdklKSk5ENzZPVm53VXlqZFNFdEFJS2pJZTRIeC9OZm1WV3VKL1drbkxF?=
 =?utf-8?B?aVNDSHlzSmlucEZQc2tXcVA2OGk5Z2pYVFVTT0plaGVBbFdod0J4VHIrOUJl?=
 =?utf-8?B?R0gyK0JZZG4xbFhTbGJwVkx4SHZvYzcyU0JabE5YemtlZ3Z6dFFDRUxGUTB1?=
 =?utf-8?B?OHNSZ0dUeVpvM051VURjbzkrc0ttUU1Ta2VrV0lIeTZvRXcrbHBGS3B5TC9S?=
 =?utf-8?B?ZlpJblhSWTRHN09SRE9OM2RxdnROVFBrbC9DQ1V4QnYxS0xaRFFGUWZEV2tC?=
 =?utf-8?B?TkZBTHJPUlBUUjB3OGhUYVpqYzZiZmQySU15M0V6blZuOXFVdHo5a0JTSnRh?=
 =?utf-8?B?d1kxSWliSXYxWVZSbjVIVzNweDlJSldnaTFCRENpc2RvMEFzaFBKOXdoUVc1?=
 =?utf-8?Q?OnO399fiK8f6SaWJ2DVCws3estNYo1KCkQvSs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB10082.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZTJsUm9pL0wwL0I1NU1aRlA4aWxxNDc5UElmS3RNOHVCRU5VRlZaRTAvNDhZ?=
 =?utf-8?B?WERJU3hsR2JQYy9McVQ5c3pneEJsYVloc0NZb1RLcS9yNWJuVmVMQlJhSXBm?=
 =?utf-8?B?L0QzZmVxcUtkSDMrVzRvU1lkMldDVklRbjhFY1hwd0REUjBTSVNWTTdoRTk4?=
 =?utf-8?B?QzZaRzVzUTNHajFBdzl5SmhUVWZjM2lQbElWUERvYTdHbFlLOGZrdS9mSWJO?=
 =?utf-8?B?T2hEb3BmUDlUUURHbHlvRk8yRTI4d3ZKaWFKWkhmQkpuZmN0eFpndFEzV01u?=
 =?utf-8?B?WlhOSHJYTDZhQ1hjVkFqOHZjc3ZlNG41RisxVnh5NmtZOThkc0w5NHV5SVgv?=
 =?utf-8?B?cm5MZnphbHdLeWlkdG5vL1VsVUg3bitzVnJ1d3dYQndMMThhV25iK0xpRXE3?=
 =?utf-8?B?VjNRV3ljcWZKNFFkUEVpOTQ1bi9XdTBlNkkxS3E0Q2dGS01BeGZqbFRNamRw?=
 =?utf-8?B?aTFqYzBDc2tOdWN5QllVRkNpbjMwZnVzeWttN0lnbDhxUDR3RVM3N2xZdSsy?=
 =?utf-8?B?bUtJRlo2aGx1VEExVXdwVWdtakUwbkE2NjdYb1AxWW41ZVZZK2JkbjN3L1lF?=
 =?utf-8?B?Q200cmRHZjkvZWJPOTJuK0lzYXdmVEhQNnkyQSt6Y05CMnFwY3d3czZkQm1N?=
 =?utf-8?B?bHl5WDhpWS9sbXJIc28yUEV5c1E0V3FGUWxOMnZiOGpWaW9TbTgzMURpLy8r?=
 =?utf-8?B?WisrNldVSDZRWFRiTXdlSXNiRFJBb3NBeUxOcTRaSURId0lGMnZJVnZqcElG?=
 =?utf-8?B?Qi9SdEN4ZDBYZWlsQURuWlV3YWdmbXZBOHlvendqcWtaM0F3NGtLbFEyVklw?=
 =?utf-8?B?Zlg3Z25VRW9DakFkRWwyRjQrbkVNM3Mwd0hXQzdPUFlZYW5lTVVDN09SSnRo?=
 =?utf-8?B?VFdXUi9XM1FiV3BvTUNpQ1B2S1U0OVdHNUZObTJQcDZQYVova2gxLzJHd1FF?=
 =?utf-8?B?VnpOZnZkTkhJbEhLMmNHWktxcVhOQ2pKS0JuckptTDkvTHVBcWg0YVNFZG5n?=
 =?utf-8?B?ZnJXN01FYVNMbE5aSVhzdEh5d1JUTEg5OWRDUldlQ2puS1VzZ2F1RUM3bitx?=
 =?utf-8?B?ZzBJU2c1am9QZHN5U0pNYVF4YUMwSFFuYjVXVW5rUm91bW95QWtoWjk1QkdI?=
 =?utf-8?B?ODBXZG1OQVVPOHFzcE5hZ3JCSlBCRjlZL3NzNlZud0pBZ2lLaFAzRnJSQU9m?=
 =?utf-8?B?YWxyQVNUM0IrY1hoMktIajF0ekRYUjdnVVA3R0s0YkxwSHN0N0hKaDB1V2J6?=
 =?utf-8?B?dWJyZEJrS0s4alUrcGkvc2RURUI5NHpiZFNSZUNMVEhzV1MvWWY2enY2blZj?=
 =?utf-8?B?VUR3emJ3d2JLZCtEbEtzY0hPY01oeXpDUitSbGJnV012Y3FseG52SWx1ZXF3?=
 =?utf-8?B?TFg2cUtiUDBuRGhsRDZJTkJJUk5WTG0wU21ld25xRVJjYnVUblZ4bklDU21C?=
 =?utf-8?B?NUlERDN2aVpoTnpBUDc5TWlSajYwcFU4WXBkTFdQRVlQd3k3TnJEaFAyY1RC?=
 =?utf-8?B?dW9kcGJyWWo4OFAySG9LalhseGxtcXFSOTJNbzhFUlJOZ0dlREpIRjJyOXA0?=
 =?utf-8?B?aXhDUFhIdThZR09MQm9LdldEdHdWTENMMDRlYUZ6ZUhYYTJ2Y3BlWEFPNXha?=
 =?utf-8?B?ajA3Y2ZTR0ZWaDRzNmNxaDJreVJxa2I3Smo2VW9xVTR4UzZETzJHK1lXY2hk?=
 =?utf-8?B?SWZvUlB2WW0yYlR3bWZVeStRaW9PWWhoSkxDMDI5RDQ4RkJuNEpWOE5vcUIx?=
 =?utf-8?B?M0pYOURkYlMrdTRCQjdCUDg3dVN2U1BnaVVuanoyNnJZTllQUGZMcnRVN3d3?=
 =?utf-8?B?eDE4emlDSnF2amhXcm9meVJoUC80WlRQSURxdlpoVEdRSW8zdzlyY3l4ZGwz?=
 =?utf-8?B?ektPdDhRRHQzOTdwdncrdXZDR2QzZzZTUUlBRCs5RjN1QVRWWU1uUWpQM2Nj?=
 =?utf-8?B?NUx6ZE1VY2ZYbVlyeXBUOUVwUEo5eFNyTWw0U3FVWFd5L0RxZVhPbGVhRWUv?=
 =?utf-8?B?YjZzTjRIQXRSVGdUcjhZbGZkMHdkd3JMVnZoU3krRVVKN1RUaFF6VlpiaW9C?=
 =?utf-8?B?dzNkWk1BTWNyY3luU0laYnlOZ0RqSWlFRWs2Nk1KazVMdE4xRjc4OGJ3VDcw?=
 =?utf-8?Q?ZPA+tl6wc81tyJhQgR6neszYB?=
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
	9WcsKbn7aX7FUVPajxQtC5+kWPUcDsXz7JWpwpFss/1YCBhAJy6KYmopXkGU5yOFwUs3BOUebx02jA2d3rVwbwwSAsqFf2pSBOdcE5q8bfYRwnuthKCOSeDp56mwE6E0adzbq+C/rcCM+heUIEQcgFgf9+rtqPDkhaBtC82zh/dNseCNLoYj5pjQ2EeiTJQ1hAqLmZexZkzSRD8/5Kr2sevJ/GYOAsR57petiIFeOpIycq/f13T/DZmoBkvW0ZPP1OOZuQLHmRnNawHDdN/lIgBi4K/DChxXU5nfHBxp70RSvQ1IvAV+/SZdnmohKLvRUtGGGVCiIV/VGS1n5rnv4ZPKiyj1bIISUAAYuyBfWRxFKKgjELR/W/Ay5gk91EHcUAxdFxcqhzlCLzuowoIXD66mPv3rxXPx3gyHCuLLXA9Nc/BtMTVHY7Ky2eqCokMPQrBvkj/c6blkqG8RQCa3R8LafXIoeVPVf+czCS32DfLjx9ryK95ELj6K1bjOuYzfPv4VQqPIfU2Vo6qnjOe140iYLpj87h2Y5pqCKB/qT6Xo+YTnjOu1YcW/TfYoMYtSPEKttcP4Ad8fkCAqTdsCwu0YXaxzPlHMruBn1ym/f2OkG3jd4L1JHLNCPfISf16x
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10082.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d422c3de-7a8f-495d-5003-08dc838a2de4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:01:07.8398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FO7jnmugdrmS+T1e4M/dLmox1Cs2fSNWg1cqLo3S4iHFx2SKPpgsu4tFZvwiTXPJCq/D1A+yxeizQmGqjeu1wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11079

PiBZYXN1bm9yaSBHb3RvdSAoRnVqaXRzdSkgd3JvdGU6DQo+IFsuLl0NCj4gPiA+IFdoYXQgaXMg
Y3VycmVudGx5IG1pc3Npbmcgb24gdGhlIExpbnV4IE9TIHNpZGUgaXMgYSBkZWZhdWx0IHBvbGlj
eQ0KPiA+ID4gZm9yIHVubWFwcGVkIHZvbGF0aWxlIGNhcGFjaXR5IGFmdGVyIGFsbCBpbml0aWFs
IGRldmljZSBwcm9iaW5nIGhhcw0KPiBjb21wbGV0ZWQuDQo+ID4gPg0KPiA+ID4gPiBPbmUgc2Nl
bmFyaW8gSSB1bmRlcnN0YW5kIGlzIHRoYXQgaW4gY2x1c3RlcnMgdXNpbmcgYW4NCj4gPiA+ID4g
T3JjaGVzdHJhdG9yLCBzdWNoIGFzIEs4Uywgd2hlbiBhIG5vZGUgKHdvcmtlcikgcmVzdGFydHMs
IEs4UyBpcw0KPiA+ID4gPiBhYmxlIHRvIHJlYWQgdGhlIEludGVybGVhdmUgU2V0IGZyb20gdGhl
IGRhdGFiYXNlIGFuZCBzZXRzIGl0IGZvciB0aGUNCj4gY29ycmVzcG9uZGluZyBub2RlLg0KPiA+
ID4NCj4gPiA+IFllcywgZm9yIHNvcGhpc3RpY2F0ZWQgZW52aXJvbm1lbnRzIGEgY29uZmlndXJh
dGlvbiBkYXRhYmFzZSBjb3VsZA0KPiA+ID4gc3RvcmUgYW5kIHJlcGxheSByZWdpb24gY29uZmln
dXJhdGlvbnMgZWFjaCBib290Lg0KPiA+DQo+ID4gSnVzdCBhbiBpZGVhLCBJIHN1cHBvc2UgdGhh
dCBjeGwgY29tbWFuZCBzaG91bGQgaGF2ZSB0d28gZmVhdHVyZXMuDQo+ID4gIC0gc2F2ZSBjdXJy
ZW50IHJlZ2lvbnMgY29uZmlndXJhdGlvbiB0byBhIGZpbGUgd2hpY2ggaXMgc3BlY2lmaWVkIGJ5
IGl0cw0KPiBvcGVyYW5kLg0KPiA+ICAtIHJlY29uZmlndXJlIHJlZ2lvbnMgZGVwZW5kcyBvbiB0
aGUgc3BlY2lmaWVkIGZpbGUuDQo+ID4gICAoSWYgaGFyZHdhcmUgY29uZGl0aW9uIGlzIGNoYW5n
ZWQsIHRoZSBjb21tYW5kIHJldHVybiBlcnJvciBhbmQNCj4gPiBkaXNwbGF5IHdoYXQgaXMgY2hh
bmdlZC4pDQo+ID4NCj4gPiBQcm9iYWJseSwgaXQgbWF5IGJlIGVub3VnaCBmb3IgdGhlIG1vc3Qg
b2YgdXNlcnMuLi4uIEJ1dCB3aGF0IGRvIHlvdSB0aGluayBpdD8NCj4gDQo+IEl0IGlzIG5vdCBj
bGVhciB0aGF0IHRoZSB0b29sIG5lZWRzIGEgc2F2ZSAvIHJlc3RvcmUgb3B0aW9uIHZzIGp1c3Qg
cmVwbGF5aW5nIHRoZQ0KPiBzYW1lIGNyZWF0ZS1yZWdpb24gY29tbWFuZCBmcm9tIG9uZSBib290
IHRvIHRoZSBuZXh0Lg0KPiANCj4gWW91IGNhbiBpbWFnaW5lIGhhdmluZyBhIHN0YXJ0dXAgc2Ny
aXB0IHRoYXQgaXNzdWVzIG9uZSBvZiB0aGUNCj4gZm9sbG93aW5nOg0KPiANCj4gCTEvIGN4bCBj
cmVhdGUtcmVnaW9uDQo+IAkyLyBjeGwgY3JlYXRlLXJlZ2lvbiAtZCBkZWNvZGVyMC40DQo+IAkz
LyBjeGwgY3JlYXRlLXJlZ2lvbiAtbSBtZW0wIG1lbTENCj4gCTQvIGN4bCBjcmVhdGUtcmVnaW9u
IC1TIDB4MTIzNDUgMHhhYmNkZQ0KPiAJNC8gY3hsIGNyZWF0ZS1yZWdpb24gLVMgMHgxMjM0NSAw
eGFiY2RlIC1zIDFUDQo+IA0KPiAxLyBGaW5kIHRoZSBDWEwgd2luZG93IHdpdGggdGhlIGxhcmdl
c3QgYXZhaWxhYmxlIGNhcGFjaXR5IGFuZCBjcmVhdGUgYQ0KPiBtYXhpbWFsbHkgc2l6ZWQgcmVn
aW9uLg0KPiANCj4gMi8gTGltaXQgdGhlIHNlYXJjaCB0byBhIHNwZWNpZmljIENYTCB3aW5kb3cs
IGJ1dCBjcmVhdGUgdGhlIGxhcmdlc3QgYXZhaWxhYmxlDQo+IHJlZ2lvbiBmcm9tIGFueSBzcGFy
ZSBjYXBhY2l0eSBmb3VuZCB0aGVyZS4NCj4gDQo+IDMvIFRyeSB0byBjcmVhdGUgdGhlIGxhcmdl
c3QgcG9zc2libGUgcmVnaW9uIHdpdGggbWVtMCBhbmQgbWVtMS4gTk9URSB0aGF0DQo+IHRoaXMg
Y291bGQgcHJvZHVjZSB3aWxkbHkgZGlmZmVyZW50IHJlc3VsdHMgZnJvbSBib290IHRvIGJvb3Qg
YmVjYXVzZSBDWEwNCj4gZGV2aWNlIHNjYW5uaW5nIGlzIGFzeW5jaHJvbm91cyBhbmQgbWVtMCBm
cm9tIG9uZSBib290IG1heSBub3QgbWF0Y2gNCj4gbWVtMCBpbiB0aGUgY3VycmVudCBib290IGV2
ZW4gaWYgdGhlIGhhcmR3YXJlIGNvbmZpZ3VyYXRpb24gaGFzIG5vdCBjaGFuZ2VkLg0KPiANCj4g
NC8gU2FtZSBhcyAzLyBidXQgZ3VhcmFudGVlZCB0byBnZXQgdGhlIGV4YWN0IHNhbWUgZGV2aWNl
cyBiZWNhdXNlIHRoZXkgYXJlDQo+IGFkZHJlc3NlZCBieSBzZXJpYWwgbnVtYmVyLg0KDQpJIGZl
ZWwgdGhhdCAtUyBvcHRpb24gbWF5IGJlIGludGVyZXN0aW5nLi4uLg0KDQo+IA0KPiA1LyBTYW1l
IGFzIDQvIGJ1dCBsaW1pdCB0aGUgc2l6ZS4NCj4gDQo+IFNvLCBhIGxvdCBjYW4gYmUgZG9uZSB3
aXRob3V0IG5lZWRpbmcgdG8gc2F2ZSByZXN0b3JlIHRoZSBleGFjdCBjb25maWd1cmF0aW9uLA0K
PiB3aGljaCBmb3Igdm9sYXRpbGUgdGhlIGV4YWN0IGNvbmZpZ3VyYXRpb24gZG9lcyBub3QgbWF0
dGVyIGFzIG11Y2ggYXMgdGhlIHRoZQ0KPiBjYXBhY2l0eSBhbmQgcGVyZm9ybWFuY2UgY2hhcmFj
dGVyaXN0aWNzLg0KDQpUaGFuayB5b3UgZm9yIHNoYXJpbmcgeW91ciBpZGVhLg0KDQo+IA0KPiBO
T1RFLCBzb21lIG9mIHRoZSBhYm92ZSBleGFtcGxlcyBhcmUgbm90IGltcGxlbWVudGVkIHlldCwg
cGF0Y2hlcw0KPiB3ZWxjb21lISBGb3IgZXhhbXBsZSB0aGUgLVMgb3B0aW9uIHRvIHRyZWF0IHRo
ZSBhcmd1bWVudHMgYXMgbWVtb3J5LWRldmljZQ0KPiBzZXJpYWwgbnVtYmVycyByYXRoZXIgbWVt
b3J5LWRldmljZSBpZCBudW1iZXJzIGlzIG5vdCB0aGVyZSB0b2RheSwgImN4bA0KPiBjcmVhdGUt
cmVnaW9uIiBieSBpdHNlbGYgZG9lcyBub3Qga25vdyBob3cgdG8gc2VhcmNoIGZvciBjYXBhY2l0
eSwgYW5kICJjeGwNCj4gY3JlYXRlLXJlZ2lvbiAtbSIgd2l0aG91dCBzcGVjaWZ5aW5nIHRoZSBk
ZWNvZGVyL3dpbmRvdyB0aHJvd3MgYW4gZXJyb3IgZXZlbg0KPiB0aG91Z2ggaXQgaXMgcmVsYXRp
dmVseSBzdHJhaWdodGZvcndhcmQgdG8gZmlndXJlIG91dCB0aGUgc2V0IG9mIENYTCB3aW5kb3dz
IHRoYXQNCj4gbWFwIGEgZ2l2ZW4gbWVtZGV2Lg0KDQpPaywgSSBzZWUuIEknbGwgdGhpbmsgYWJv
dXQgaXQgYSBiaXQgbW9yZS4NCg0KVGhhbmtzLA0KLS0tLQ0KWWFzdW5vcmkgR290bw0KDQo=
