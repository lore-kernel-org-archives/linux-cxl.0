Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCF01F6686
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 07:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737097244; cv=fail; b=MG34UxocOsgUPRutp2XsSSQNesauhSHHWOLiVJJ4rWwan9QwlXJj7BaDz4G+WfaAmi7i/y7jgAN1SLUHKUEcc70W4uAa2VZHdCIuB92EY0Wz9uuXXnNfMHyDFKMCFuiSE69VHRMPlcJTVu7V6+UHfjjnPu/pmk3VB1t2sCH0Wd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737097244; c=relaxed/simple;
	bh=j5EkiJV0SYKGM4jKG8xc6v2y1ceb8joZqnsVFkaEWPg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ba7Houvstmxm7rzYHVhu0LXeO3fnx7AtSWlLMm4f6ZES2MMZKTZ2hwkrCwWgi/prdR56EyQsCIsA3RpC6WzRN8sJh1OxAjU4eYjW+Qcm/SkzWP9D+DseH6Pu6FpMlEsPHSKtlIukJzuJgMEpwZcyXuX0F1sDA7klctJWMxekLUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=nVzzNIfo; arc=fail smtp.client-ip=68.232.159.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="nVzzNIfo"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1737097242; x=1768633242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j5EkiJV0SYKGM4jKG8xc6v2y1ceb8joZqnsVFkaEWPg=;
  b=nVzzNIfoFIQy0torZ4n+k78Z5AqxLai7LCz0VkI6XauM9D0yrXJ4y7sb
   NeiXMM+acX3lxaS9xUdPKX1z/HiIKnJN4EQmuHXllJIaeoJni9nM4FeTs
   Vyi8Kh3MledFIOo5xjrowL2nAmgsM47oCqziqMAD0gULBaLaaeHSJWIJm
   /HcPotm6KhZlMV6EhLLjKaqt9+8anpte0PByevl9mIkMW1CbUmmdNSLUT
   RcR++GDvl/D6tynmOAGFjlGKX0KgPnCLGmoI4tAHF3jPcqvQz0XOQQXTi
   JgWIOA8IYWXb7yRdfnc5JtLvUSr8NGrT4QkAxTDBMw8xmzoUF+882mUUn
   Q==;
X-CSE-ConnectionGUID: cxhNgomLT6CdNE7bgrA/tQ==
X-CSE-MsgGUID: k2QmsPXKRBqNILgsdTElEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="143143744"
X-IronPort-AV: E=Sophos;i="6.13,211,1732546800"; 
   d="scan'208";a="143143744"
Received: from mail-japanwestazlp17011027.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.27])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 16:00:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfvCUvGK/Op40I2vat9qgq0hzSrQ82rnQn1gbX0qdg+7XtYlGn7sZkHYpzmZoaVjDmitBlRwzkMyzDlR/gM9jZy34mu7T0/+oRU1AIogXcXDv6rFdlQ0bS494SuHW/r1FdgGT/Ridx05utrhkw2VOuZXGbQlXWwixfQXL0S8YKEYo1rC2++OghBjctXwwHoL/3x8D+OuFXbUSpJKXX3MC1c0B2YyROBBxl2Vj6/mYU0fP7XXsItQ96tHtxsHScMIctBnQAAxF9wWmXj83HqEmAW9Ch+q7aCzdvbOHhlw9bcvzm5mxcdprkvE6Djv7rHICbzigQEwZxTuy08lY1nJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwLDfBBjlPzyhdKsvuJpqa8iiFj1hFw5gEa1D/Fy3dY=;
 b=oz0O//5hmpx/UtPv+Y0lPSgC4AYVYkuOY46Dmthy/QRLuKNAFqlayzWmw7eziPZuY+1VA7c2Mkzx1Bl5H3eCfySlf3jPhNnqSccmYvjGV7PYwkmOZERQ5oWBx6rZQW6hEv32OnLw7Pb4L9kUrnmsknwCnTuAvnob0s47by4wLuqhJekN6faxCpkbu4MijSJpe1NJn3qCtuxZusTBmDdNsUtFwnQCnLPsg4rLcq8zCUxf+KpjkonyJ1XDz1IhPMkPLnJV3zl7TVNNKx2H6qkxfys6rjFeQeg2XaR2+vvjtS83YtP/2fYY5ZT8HRMDP/l2cp+JufZk0ZWsjR51f0ETZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSYPR01MB5352.jpnprd01.prod.outlook.com (2603:1096:604:84::14)
 by TY7PR01MB13645.jpnprd01.prod.outlook.com (2603:1096:405:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 07:00:36 +0000
Received: from OSYPR01MB5352.jpnprd01.prod.outlook.com
 ([fe80::21c:a9f7:3c3f:c7e]) by OSYPR01MB5352.jpnprd01.prod.outlook.com
 ([fe80::21c:a9f7:3c3f:c7e%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 07:00:36 +0000
From: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To: 'Dan Williams' <dan.j.williams@intel.com>, "'linux-cxl@vger.kernel.org'"
	<linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: RE: Assistance Needed with CXL Memory Region Creation
Thread-Topic: Assistance Needed with CXL Memory Region Creation
Thread-Index: AdtgqoH4aWCS14GjQ5iB7Jig2VQUVwHV4icwABCGhgAAGLHOwA==
Date: Fri, 17 Jan 2025 07:00:35 +0000
Message-ID:
 <OSYPR01MB5352A1D6015146B092A7D591901B2@OSYPR01MB5352.jpnprd01.prod.outlook.com>
References:
 <OSYPR01MB53525FD64A9AFBAEEC1E19A390112@OSYPR01MB5352.jpnprd01.prod.outlook.com>
 <OSYPR01MB535212BCA854FDCC57DFFC1C901A2@OSYPR01MB5352.jpnprd01.prod.outlook.com>
 <67894f4e5ed6_20fa2946@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <67894f4e5ed6_20fa2946@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=41774bc6-deb0-4c53-94de-4dd0a6fefb0b;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-01-17T06:13:26Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: afc971c7816347109b43205b9cd5ab5d
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5352:EE_|TY7PR01MB13645:EE_
x-ms-office365-filtering-correlation-id: 2f923071-cbe7-4e1b-2719-08dd36c4a49d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?YkdkOThVczVSQXgySmZ5UmVWMFVsZWZYUDd3TlVOQ0NjcVc1di8wYkdw?=
 =?iso-2022-jp?B?M29ZS1BvaFg3NFFkTTIrUndGMkxZVi9haTRZZmVOeFVZcjJ5REN1M0Rx?=
 =?iso-2022-jp?B?QW1lZmd4Nk1uQXNoOTdnS1pVd0VEdDRxY1Y4YmE2TGpyMExMNklod2x4?=
 =?iso-2022-jp?B?K2NBS1FUbkhWR0Q4S1NiM25oZmJEaXhhM25kYW5paVNrVFh1VWVCd204?=
 =?iso-2022-jp?B?NENRMnlTYVN6ajM2a3I5blVGcjZFR0svQXZMQ1Z4NlQvWHM1Rkw1QnNy?=
 =?iso-2022-jp?B?WDR1M2RlcXQwM3FJcTd6ZVZ1MlQ5VGpURUpJZ0duVzYzSWM4cHNCLzdk?=
 =?iso-2022-jp?B?ZlFsemZ4a2tUVTIrWVlQbHlLd0RmNUIvNGlFYkwwMDBjRGlKLytVYjd3?=
 =?iso-2022-jp?B?NDl6NVN2Y1pqU0tDREJYaC9BVVVkZFZURmM5eFRUSmNFdi9OUGFsZVVU?=
 =?iso-2022-jp?B?Q0hwRk1oNFF4UVpPTUhMNGx4cmlWcEtIUHhybi8yMWtvQkwyTXpHRCts?=
 =?iso-2022-jp?B?Tmo0YjBUTU50cXFQN0YzUUlrZEFiRUIydnE2KzBYNmFCUHFrWUZ6L1hP?=
 =?iso-2022-jp?B?QVpFVWlLOFVwaUtWVlZDVExoZFF2WTkrWWd4UnFzSEIzUi9aNHcxTktQ?=
 =?iso-2022-jp?B?eTlxWDgyUFdXSXVKSFVHODZ0NUx0bmV0MXBGZTR0QkVRK1RScGdHT1Rw?=
 =?iso-2022-jp?B?YXUrcmVsZjQ0M3FyMnZxLy8rNWlIMGV0TEZKV1pyZGRFK1N1aVF6Wmh1?=
 =?iso-2022-jp?B?RVpVbDJhVnBLcEE5ODRzeFhjS3cxTFRIa25KUVgwU29xdGdRZlNUenhq?=
 =?iso-2022-jp?B?NlpPb2xWOFV6aDhlRzNuSm5WOHNIM21PSWU1YzI3WTRCVFR0UWVzMzMr?=
 =?iso-2022-jp?B?cmN2a0FoZWxUSW1XajJTUzBINVZMcXhGVzVIYTBzbGZ1L05UTnFrN21I?=
 =?iso-2022-jp?B?TjBBWlRzWmZrNk1oMGdTaGxmTEtYTmJyalFpL21MekpuV2hrckNENDJq?=
 =?iso-2022-jp?B?Umlab3JNSHhUQmQrNGZYU1dqM2VhWUh6V1pUSEtQMWZETjNlNkJ2UFl3?=
 =?iso-2022-jp?B?TFVQMXpiSzdCK01jQzRaLytYN0RjWWxUemFtMVZXRFZyKzBOSEk0R2xW?=
 =?iso-2022-jp?B?MUdRSlpINlJ1Vm9BMWx2U0t2YVlHTTdyM2d5TFVkbUtVczFVY2gwYmNj?=
 =?iso-2022-jp?B?aTB5RXZJWHpheUZISDR5eVdhdXlINTUvczJwQ0ovZWV6c2Z3c3ZjMkpL?=
 =?iso-2022-jp?B?Qkh5SFlOZ2djU3ozZVRFTUFnUHlCT0NuMzFBK1hsb0doaHdQaWhFWkdh?=
 =?iso-2022-jp?B?VW92Z2dxZzRnVlFyZW45VjdYcXU1eG1Rb2J0YVAyeXhzTjRmcUo3bVBn?=
 =?iso-2022-jp?B?NnlEWkhzaE5sbTZ1aHNaNDBCTTQ3OGpTK29GWUdXcTN6U0VxZld3QkE3?=
 =?iso-2022-jp?B?YWpScHRreE9obTZiZ2JHNmgxR01zTGRrc0pPUTJUTVJOZzdJOGN6R2dv?=
 =?iso-2022-jp?B?SlptRm1pWm5odVhWOHJkOFhZdk1TL00wbzhtZXZYc012N0tDZWhSc0N3?=
 =?iso-2022-jp?B?bmRYNTNXNEhKMDBDR0FMZUthdVc3dWIyZ2MyTVVTN2xqOUdIVThlUTJo?=
 =?iso-2022-jp?B?blhYOUI5K1RMbkp5eTVLM3pnQVdWWHVvTjIxakRhZ0ZqVTQ3MmhsNjB6?=
 =?iso-2022-jp?B?ZW9vK0VzT1RSOXd5QW84cGZwcVZtMUlVZnFCTVpwSWt0Q0x1a1JITDMy?=
 =?iso-2022-jp?B?WmhaeEZvYTBEM0szc2EwZWF2b254Zm9sZHR6VXdScU1kQmtvRXlsbE8w?=
 =?iso-2022-jp?B?b1B1TDJzUzJxN0NuL2pWdjhHZEdIRTAxdnBESmIyK3VMeUVMNitqS1Yz?=
 =?iso-2022-jp?B?Zi9scGhXRHVMenlUR01jSGtKZ2xmZ2pYajNhMTF3KzZ0dDcyUUNHUFk5?=
 =?iso-2022-jp?B?emZWVDJ1MlgyYVhFcmZMMmhldWxPK0RCR1ZrTXgrUDhUZGU5WXZvUnRR?=
 =?iso-2022-jp?B?cUlQZXBpR2tPWXJHemwveHF1eFZsQzhkNVhxamJweHNTNDI1aUdzbWxi?=
 =?iso-2022-jp?B?ejRPMk9GeFdoQ016YlNFdm42UGV0bU09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5352.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?ak45N0FiSE14czhPWnVUcGlHdmwwanpVNVZldjV0VlUva2VXeEF5U29n?=
 =?iso-2022-jp?B?RE5tS1ptalM0UlRrdGVvS0xGRXZCWDZCK0s4UVlPZEVqSC9HUmhnbUlX?=
 =?iso-2022-jp?B?SVlQOGk5dVBGdzJrVDB3UXVBUTNVNURzMWEreVAwY0hKaVRsWm5GMXgw?=
 =?iso-2022-jp?B?SWF3UHUyRmQ4NjdVNlRVaGJRTmRja3dzZFRXTVdSNnlLTmY5bW9zaUk2?=
 =?iso-2022-jp?B?NDBYbnlIMFlFYmRhZnFzNXc0TjVObXhIT0g3dGE1Z2g2S0M3QzdmOS9N?=
 =?iso-2022-jp?B?dVlRZWRYZXVFWHRlWGtEMWRpd3dlYk56S2tseDFncG5wRWdwdCtnblFX?=
 =?iso-2022-jp?B?NFIrSHpCNzd4Q1R5ajNlUkRzZ0h3VFgrWndhYmtTYmwzQzlqM0E4MEFW?=
 =?iso-2022-jp?B?Z3hwTkhzZ0tCaEF3OENNaDlpMGNvcGFpY0s3dDlRZHF6OExTaC9ySmY0?=
 =?iso-2022-jp?B?WUd1dDVkVGp2cVIrQ1ZqSXVlTTY4aE81dUJlRVRsdm5paDdqNUthREIy?=
 =?iso-2022-jp?B?Z1pqTDBjczNBK3o0NzZFZjg3c2dlWnlhNXdhWVgrWHRzSDhHL1dIcUtx?=
 =?iso-2022-jp?B?c0YvMTRaSDEzNXVUWHhPU1lLcXM2Y3VrZTFoRHdTVmRvbGdWYUVOM3Jq?=
 =?iso-2022-jp?B?d0Q4UlJxeDUyL3pNakUzSUV2bWxCU2xrWCs3N0hwTzRKcGhwL1dGMWFx?=
 =?iso-2022-jp?B?RTIwNThvTWQ0Y2NocGRaWDZockR6ajdhY2VjMS80ODJtY1RZTDA0ZXIr?=
 =?iso-2022-jp?B?NnArdFJzVWp4NVR1SkJyeUY3NitMcjlSbTA1K1FLMGkrVGtGc3BFZUNz?=
 =?iso-2022-jp?B?blZjWUlKZ1JuRXlUN3V4eDhNQTRFRTBrZVg0eVJGUytCYzI1b2E0M3F1?=
 =?iso-2022-jp?B?TzZmb0dORHlXQ212MmFZRzFxVFhSbVJvMFhBM2ZER3ZxdFE2TTIzckFD?=
 =?iso-2022-jp?B?Q2EzNW50ZGdHVFB2UXNHam51aXo4RDJBSlJxU0dHWFB6NEhPZ1IrNUxR?=
 =?iso-2022-jp?B?eHJFWnFaL3pTQldabVdDVmVPMS81UytZTTh5d0FVdHdGYjRmM2wrNTc0?=
 =?iso-2022-jp?B?ZTR2eVBLcVNpdXlNcGpZdVZJaFpBRk83dkl3eVB4RlcxOUhXZmFEN0VX?=
 =?iso-2022-jp?B?VUEzTUVRWGNFS21Ya1BqNENEenYwenlJcTFmM0NHUnlUR3RwMFV2OG5z?=
 =?iso-2022-jp?B?T1FhaElWc3pzYWlyNHdTV3V5UVd6d2gyYmNFOG02RUJ0OS9PY2dnbVQ0?=
 =?iso-2022-jp?B?WExUaGtheTBHOGZHSWNtTm50NlYxWm9YSnp1WTRwc2lTN2p0b1ZYM0Jo?=
 =?iso-2022-jp?B?Tkh4ZnlEbjRNZkkydStCWUZhOUJHRDF2TnJuOENtcmRDeWVvcC9OQnE2?=
 =?iso-2022-jp?B?azlvQUUxczl6ckV3ZjRDY3JnVG5jU3pxYzdUWllqU01LNVJuNitLUkwx?=
 =?iso-2022-jp?B?Zjh3NXlhbVpvNHZELzNUeTByWFhXZ1BwZVEzbmZvM2hrQjd4QlVNK1VX?=
 =?iso-2022-jp?B?SUt1dXVHd2sxYmw1SzJZc2ZKRTRHSXlDVDZTWjBkVmxYM2IwL0RTVGlu?=
 =?iso-2022-jp?B?SmtJVmtTWUUzbSt5aGdkTHVGS08wL1hnaDQ5dHRUT0NHVStWbmthQ2FI?=
 =?iso-2022-jp?B?bjF4OFU4dDdwTmVZUDBBbU1YaTIzZm5yd20wRm9EM1MweXJnalNSUnlF?=
 =?iso-2022-jp?B?eTArMExrd3RwMGxuY1IyaFk5RWdwWmF5TUlqV3FSamlLVS91N1oxRWZN?=
 =?iso-2022-jp?B?dTVkajZNWDh5TUR3N0RmdFgyZjIxejRhOVJ1YVBqRWVqYlRjVWVCRmY0?=
 =?iso-2022-jp?B?OVQ5RWVxMUk1bnRVRkZveUEyWEFjN1pMZEovWkV4TzU5bWp4SnZRK1Zh?=
 =?iso-2022-jp?B?VnZZZlNMN2o0R2hCakxRdkgvdHZhVVU1b04rbDFjSFJEUHYxTWJNbGZ4?=
 =?iso-2022-jp?B?dU9YY0RhWkNQa2JmeWNwb2dLcDZBdTdJeEF5MTZaVHdrYWpsZmdKRkIw?=
 =?iso-2022-jp?B?M1hmRWt1V0ZPWStPVFRQVjkrQ2drM0JDY2xSRzlvY2tld2xlaEQ5bE4y?=
 =?iso-2022-jp?B?cVZWbFhTT3I4dTFIRVRzZlRpalVuY3I5Y2luQm04YnhwRWlJcFZEeWcz?=
 =?iso-2022-jp?B?QnMzNm84MTY0cHJIQkZjWnhLS25rMHVVYUp3TGpWemN4WWd2dkcrYXBr?=
 =?iso-2022-jp?B?RDM2MTAreDJBWDZKNUVaUGpwOVc3YS84eG9KTUgwaXBXZmxXdWs1Um1T?=
 =?iso-2022-jp?B?R05VVFF4bkhuUGxWaDNlZEFCY3IvNWxTZUtlUzVaTW9hUG9ZaGEwQnJw?=
 =?iso-2022-jp?B?bXlqQg==?=
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
	rdhovcbCxUW+3uhNr9zkxMS3NpJCLOUE3kCmKjrL/A5YwqUYJX0KPsH2/HiyYZesvRyTdw7zVY82D2QQo+tLft5U7+ASIHBE9I8Y2GJJXXfQvazO8FKKUZrHCXV7jOHc7zqFzQGafjSFgDEWmAltJ1QWMCNGvvfix5PBxaZvp+0C4571F07NQXXSGOnEXcv4udq+rqGt/kWA9onR0MJ0lYQMI+TVoi3Zez9oxTjehLUumXWXZEo6Lejf0Ct1ob6PFEmG7A1hy2FxpW2IXwX3oR5i9yzy1YHrl7f7L8dHTxkgarTfmpb+uRA1ffFqkM0ACf34/tMnNM2F/JxJ8UFynQSyNhu9aTRuLigAHVqYyIMcbHQrUEDkdzJJP4wtL22rsDQLyyCn6I7IcOa3fj3IWufJ3LmSPG4bHcFl4JVqAWZfjN7/ChSQWvrpC6LiDUwFRfiJRTCyCbp9xKdmxs4HqzK119dGE/V6uniAtOnSbNxmhEcobyOZglOXoWnpBky5Sxetd0X4otcdoc/fY8E61cz1YxhBDilwgUB5kuwQjlzUYf420edTVc3H6xzkyV1t4apdfhdpRQeYNVz+5TdGngf1RNIFpQPSYCzr8teYAYsidhIZCuKIiWlhyMIc3lpc
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5352.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f923071-cbe7-4e1b-2719-08dd36c4a49d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 07:00:35.9183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O6TJmPvUh10tNw+d1Thxu72tyQ6E7VJf7TPqt1xWGpVvvmTLF1A1B+3R/kaZX8E66Z9uoXVsrVy7K5xHHPkX2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13645



> Yasunori Gotou (Fujitsu) wrote:
> > Ping....
> > Is there anyone who can provide information to help resolve this issue?
>=20
> I missed this earlier... holidays + merge window opening =3D=3D inbox ove=
rflow.

Thank you for your help!

> > I met this issue at kernel 6.13-rc4. Are there any fix for this issue?
> > Otherwise, are there any kernel version which can create region under t=
he
> special purpose memory?
> >
> > I'll add some more information below...
>=20
> Thanks for that!
>=20
> > I think cxl create-region should succeed in the special purpose memory
> > area, but I cannot understand why the above code results in an ERANGE
> error...
> [..]
> > > Below is the relevant section from /proc/iomem:
> > > =3D=3D=3D=3D
> > > 89d500000-89fffffff : Reserved
> > > 8a0000000-189fffffff : CXL Window 0
> > >   8a0000000-189fffffff : Soft Reserved  ------!!!!
> > > fd00000000-fd03ffffff : Reserved
> > > =3D=3D=3D=3D=3D
>=20
> This memory map is saying that BIOS created a CXL Window "CXL Window 0"
> AND it populated that window with a CXL region marked "Soft Reserved".
> The window is fully consumed by that existing BIOS created region. The
> expectation is that the CXL subsystem parses the BIOS configuration and
> creates a "cxl_region" object as a child of that Soft Reserved range.
>=20
> However, for whatever reason it looks like the driver failed to parse the=
 CXL
> configuration. If that had worked the flow to create a new region in that=
 space
> would require first deleting the BIOS created region.

Hmm, when I executed "cxl list -R" command, there is no region.=20
Certainly, the cxl driver might fail something to create regions at boot ti=
me....
----
# cxl list -R
  Warning: no matching devices found

[]
----

> So, the behavior you are seeing is expected. You can not create a cxl_reg=
ion in a
> space that already has a BIOS created cxl_region.
>=20
> The work in this patchset [1] is aimed at making sure that even if the ke=
rnel
> does not understand the BIOS CXL configuration it will still at least tra=
nsfer
> control of that address range to the device-dax subsystem.
>=20
> [1]: http://lore.kernel.org/cover.1737046620.git.nathan.fontenot@amd.com

Thank you introducing this patch set.
I tried daxctl create-device and cxl create-region for each.

- "daxctl create-device -u command" : The command seems not able to find th=
e device.
----
# daxctl create-device -u
error creating devices: No such device or address
created 0 devices
----

- "cxl create-region command." get_free_mem_region() certainly succeed.
  But ENOSPC occurs at another place
-------
# cxl create-region -d decoder0.0  -t ram -m mem0
cxl region: create_region: decoder9.1: set_dpa_size failed: No space left o=
n device
--------
Strace is here
--------
  :
  :
openat(AT_FDCWD, "/sys/bus/cxl/devices/root0/decoder0.0/region0/size", O_WR=
ONLY|O_CLOEXEC) =3D 3
write(3, "0x1000000000\n\0", 14)        =3D 14  <---succeeded by this patch=
!!!
close(3)                                =3D 0
  :
(snip)
  :
openat(AT_FDCWD, "/sys/bus/cxl/devices/root0/port2/endpoint9/decoder9.1/dpa=
_size", O_WRONLY|O_CLOEXEC) =3D 3
write(3, "0x1000000000\n\0", 14)        =3D -1 ENOSPC (No space left on dev=
ice)  <--- new error!!!
close(3)                                =3D 0
write(2, "cxl region: create_region: ", 27cxl region: create_region: ) =3D =
27
write(2, "decoder9.1: set_dpa_size failed:"..., 57decoder9.1: set_dpa_size =
failed: No space left on device
) =3D 57
------

>=20
> ...but that's just a fallback crutch. I would be interested to see more d=
etails on
> why the kernel failed to assemble the region that the BIOS created in thi=
s case.
>=20
> The overall flow is:
>=20
> - BIOS creates ACPI CFMWS
> - BIOS optionally creates regions within one more CFMWS ranges
> - BIOS builds EFI memory map with the CXL regions marked EFI_MEMORY_SP
> - Linux boots and sees EFI_MEMORY_SP + CXL overlap and waits for the CXL
>   subsystem to assemble the region
> - Region creation is only allowed with free capacity
>=20
> The known bugs are:
> - Corner case CXL configurations that trip up the driver (memory side
>   caching and CXL interleaved with DDR are current examples being
>   worked)
>   - Reliable fallback to "CXL unaware" behavior when region assembly
>     fails, should be address by [1]. A temporary workaround is to
>     disable the cxl_acpi driver so that hmem_register_device() skips CXL
>     range deferral.
> - Inability to delete regions that were created by the BIOS. Should also
>   be addressed by [1].

Thank you for your information.
I'll check BIOS implementation and investigate behaviors of the cxl devices=
.

Thanks,
----
Yasunori Goto



