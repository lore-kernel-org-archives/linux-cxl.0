Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4EE4C9F
	for <linux-cxl@vger.kernel.org>; Thu, 26 Sep 2024 00:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727312047; cv=fail; b=rPD0BWdevkhaVknFD5x4u5mFK1p+y/Ef6Y82AXaVIFNycihnEv51KbKEaSIY+usnE2EH/T0qiNAyDOB5CXffKWM1IJ+2q0q+r2h8vTv06pkPFTaUCrgLwvP/ddBxjgnF2WKnVVkxXXVN9C7ViQZa+QNgppBEFwJRuLP7jwmXsn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727312047; c=relaxed/simple;
	bh=IhAImNtN09oBfiZ2dE39xrCE8G3A9yGTcOYSboeqUaQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l2pYXgvuiWOZSFk+kxqaKDoQ0vx5q/hM+7hgQDDtTn/zVqt/zvC7aUr38JMDlGmqQUWNf84upGCbWStem6IqSEJfRLrEIq8Pe28ujwpro97HFmFVsQ+uQprloFY0Ei2vL94/rOeKMNBP9qsVBKu9BRtm/QTDIJnM2fN7O7Pp2zM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=MQQkanjk; arc=fail smtp.client-ip=68.232.159.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="MQQkanjk"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1727312044; x=1758848044;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IhAImNtN09oBfiZ2dE39xrCE8G3A9yGTcOYSboeqUaQ=;
  b=MQQkanjk5fGI711JRf1RvpH9DIWIYU5R/A/jsXswImh67/cEzS2wZ90R
   PbhVb7pNFv5tuaW7YejBIByxCnLgc+7OdyF46Zh/kk84q0dgKR9FOmvKf
   CL7h0xwk4dfeR7XYsZWbKfoUWF9QI892pKwZH9fFl3qtjGKtBh8aLSvTw
   9SxWHVWl9QoAQwYZkjIUcoqOb/Jsiln6upbVTYAu7ORikos7Hs+2eF1l7
   HMz16n31Rj+WjEq7hLt3fzE81ShHod8KODLHRS2vrfTo1FNBPsBQ4GrIR
   l1DgQNASiQoOAEXLNsRxwFmr/GsxW+xxm14eYJsjgcWeaAKRPOUodwIDN
   g==;
X-CSE-ConnectionGUID: 7abuWV4QSPKjsD+OKFiKBQ==
X-CSE-MsgGUID: w1QbDFBARSym088ep5WcRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="131934383"
X-IronPort-AV: E=Sophos;i="6.10,258,1719846000"; 
   d="scan'208";a="131934383"
Received: from mail-japanwestazlp17011031.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.31])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 09:53:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGbli7nj8FvnfcGVwjMOGahLiFrlMRrCjrU4gGslIy7h6rtRShjOX/GKZ28fG8F9qPXCkaZxpCkVw36ZP+GNCiwc4oCELxnbfu1ZAthog+NbSoXejB27E8KIex33YPaUDOpLetVK379pAqEIEMj28FeAH49qDMMa2aX5HO/+i593c1hEoiBkX71xQ/+elblJkVltb/uSmxzM7TT2ykbaXiMgUDwvo1Dh83IwI5GjyOVz1a3Y1iPCdcbw8WWdhANex4dLbCxNSJMf4Wz5Voq73AukQXNsoKW7p0IV7H5ElBJLViUF+cV51tnxnxs+8Qdq023i1+X6JAR1qb/+XgIN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhAImNtN09oBfiZ2dE39xrCE8G3A9yGTcOYSboeqUaQ=;
 b=nAXdE0LeeI87+vOThKruVSSUSZr17jalpV9x4sTztBAPWkkJdDVoRDMm/0jasM5nMC+uhG6HQwEJv+f71FvyhsmbDlzzh9g1h0IeVbdvWSBOnVnsD4I+BE8j1Bjup2wl1ETsGsWAg29aBXQstD05IIzuevsAuQpt3+XjhlvKKJGcLMmyQn7MNQBI2tI+a/HRU7p55w/Hk6U09810W69IaLDi0E0JGUlDckA7BQ6YAlPpODeNMBUdO0+OX44Xi2/oUgkDpfTeo2MtBcywo4p3vq3aMzrPJPCwTF/YPIJYGWyLFKaUQPnlPSiRJ/C6Qb6WTpMk29uQF+Fhji+cuhO41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYRPR01MB12335.jpnprd01.prod.outlook.com
 (2603:1096:405:105::12) by TY3PR01MB10030.jpnprd01.prod.outlook.com
 (2603:1096:400:1dd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 00:53:51 +0000
Received: from TYRPR01MB12335.jpnprd01.prod.outlook.com
 ([fe80::18b4:fae4:bd97:f2b7]) by TYRPR01MB12335.jpnprd01.prod.outlook.com
 ([fe80::18b4:fae4:bd97:f2b7%6]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 00:53:51 +0000
From: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To: 'Davidlohr Bueso' <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: RE: How to start sanitize?
Thread-Topic: How to start sanitize?
Thread-Index: AdsPNO/G7a8YwYDJTi6wGIAzVUR10AAO0OWAAAzTn4AAAnF9AA==
Date: Thu, 26 Sep 2024 00:53:50 +0000
Message-ID:
 <TYRPR01MB123356B6677CC11C606D0AE64906A2@TYRPR01MB12335.jpnprd01.prod.outlook.com>
References:
 <TYRPR01MB12335599B869ED3E7716A758790692@TYRPR01MB12335.jpnprd01.prod.outlook.com>
 <ZvRIA27BPRQNtzaR@aschofie-mobl2.lan>
 <smroptdwwqext5epffyfapmvmnsrs6u4h4shxjdsysuyzldqxb@3z23ueivsesl>
In-Reply-To: <smroptdwwqext5epffyfapmvmnsrs6u4h4shxjdsysuyzldqxb@3z23ueivsesl>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=79a82d1d-bbb5-43d0-aca7-6a2de8753ebe;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2024-09-26T00:44:44Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 654c1102014e4598b4a833777bee23fe
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB12335:EE_|TY3PR01MB10030:EE_
x-ms-office365-filtering-correlation-id: e872e664-1d39-4959-681d-08dcddc5afc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?djJ3dlFmSlBRZXoxbkIxK05iMjl2Zmw5UjlNYStFUnRJYnd5WjR0bU5v?=
 =?iso-2022-jp?B?MVV6elNrYTBTaGxiYm9HL1UwQXdKKzdxTGNDR2tXMTlLVXZvWXpNQ1BM?=
 =?iso-2022-jp?B?djVZY1dRZ1hVL0JiVHY1cWFCTHdxbXFqbHU1UVRTbmx5YmhINktDME1F?=
 =?iso-2022-jp?B?eXM1L1FCZkZYdDZEQUR3eHJmd1EybEpvdTArSGVwcXFLZjIyd25NeDBq?=
 =?iso-2022-jp?B?OXRSTk5Qai9mSHArT3FFZ1hLY3BjVFk3K2Y5Wk14ajZZMVBxcG9hc05V?=
 =?iso-2022-jp?B?TkRkeTg2VU9kVCs1ekpSVnllNDFuTkd4L2JYeG02M1JxSGZuQjNXbVFx?=
 =?iso-2022-jp?B?L0xZeGRUUHFGRDErbDRkazVpTGRWdkE3SHZxL0NiRXFaQ3RQQmFCT3Mz?=
 =?iso-2022-jp?B?SzE0SHAyOXUzTTZaZWRtYWxTcmpqNHlJamdkYmkyaHVEWStvZ0c1S1Bh?=
 =?iso-2022-jp?B?VENuU0lNaVl1MnRvOGdMRlRZQTdRQ2QrV09Ic1NjWnF0Mk9xdW1wdlU1?=
 =?iso-2022-jp?B?bmlYSlZYVFF5MXY5SjB5ZTFXRkowTU1sU1A4YmdLV3g3RlRlNWU3Tkg0?=
 =?iso-2022-jp?B?V0UveWRneFhub3BpWVhnMEZDanc4MWFXT0FyQm1Ia3JJcVVPWHFVR3lM?=
 =?iso-2022-jp?B?ckplend3NGVpNkUvMFYvdDBSSXhKcGl3aWJJNmRsUWhXd28vYjNMZjdv?=
 =?iso-2022-jp?B?b0lVMC9Sd01HRFppMDNrUU5WcE9JaSsra21EMHF6eGFzMFh2MSs1WCt6?=
 =?iso-2022-jp?B?aFp0M0lyTTlUWG55OEs2RDlmK1JRc3Jwbk95QkdyR2xIUVc0OXlMSm0y?=
 =?iso-2022-jp?B?bXpvWC8ycDFhRVZ1TXBGZ2ZUVFpjeG11Y2gxRGhEVk1teHV4ZkVDRVVa?=
 =?iso-2022-jp?B?d2tTU0dMZjlENkFmc2NPbGpzRFo2V2dzNUo2cFZLc3dRRE9Kc2pvMGND?=
 =?iso-2022-jp?B?bG9JcTQ2T3VnZkJtZTFIY2wzaTJnSE9sT1JCTWNEQ0VLdkl1WkFWSGt2?=
 =?iso-2022-jp?B?NUppUnBNbElxd3BzSW9iV2NaREVwTWFiZHFWb0k1WkxiS2x4eFFxVzF1?=
 =?iso-2022-jp?B?SUpUcjVodElxNTlIZjN6OElkblpabHM2S3lLeHFqanBxRXlNOUQyM3hF?=
 =?iso-2022-jp?B?MkFFdVRYTnRYYkF4cjBZUUVKeXdlRFdjeHN4a2R1UlFSaUJrQkhIZXVI?=
 =?iso-2022-jp?B?WDdOQmVkTytVOEZid3N6cFcvK3VURHpFSDdGMXRCQzdTRDV0U0JuVmI1?=
 =?iso-2022-jp?B?aXNabEI5UHF2S1hIMkJSNzBWbG1vak55SlpzN0t0ZUt4VFdobDVmYzFU?=
 =?iso-2022-jp?B?M0JYMGIxVjRrOWxUWHRqTlJEbzNCS0dNNllSN1h4UjhVZk5ZQUhDSmhi?=
 =?iso-2022-jp?B?M0NqUHFIUWs2a1d3TjJDUEZMUE5hRmt4SlNLWDFNdzd0eXcvMlAzK29Y?=
 =?iso-2022-jp?B?cVFMSFdRdm5RTk5PeTJDWFVIYUZ4SENWYVo3bWphZVFtcDNvTXNnSndz?=
 =?iso-2022-jp?B?WFA0dTRZUDRMOEVuZER3eW44a2JnRjlRUUs0U2FCUmZyVEw3cDRLQ3dj?=
 =?iso-2022-jp?B?Yk9rdDdTSGZEOXBvUnUyVHhKMUZrckpqcURhK051R081dERFVkwyNmdL?=
 =?iso-2022-jp?B?dDZ0U2RuSmFOakRDZXdxdlVYMTFQWURCUmhZeFh4emlTWUhWVUN1ME56?=
 =?iso-2022-jp?B?dnBNRm5zQzI0NFVXVnNXcUFac29HMXBPaFBzVVU5aDNTUy83dkw1Q2N1?=
 =?iso-2022-jp?B?SzNEMVFuYVNRWUR2Z2pRYUdpVnAyeXVMWXVjQUtGaVlFL0J1UlNkSG5O?=
 =?iso-2022-jp?B?a09hTWZBcDM3R3l0SE5peFNwRld3Z0x3djFHR096ZlFUN3dzWmxiU1pD?=
 =?iso-2022-jp?B?MlVtbWRhUXg0d2M4SkVhcm9HZDBHZkxUME91MzdlNHZUbU1WMHNGVGJq?=
 =?iso-2022-jp?B?N1ZGYzhVVmRLY2ttQU5NbW1ZSWxzZ2xpbnZQdW83eCtRQnFzYndQam1x?=
 =?iso-2022-jp?B?S29aM3NmYktPc2JUdVNjNzJycmhSRGR2QW5RUlgxaUNudnNCa3ZpbC9a?=
 =?iso-2022-jp?B?am9Bc25KV1Y5WkFlN1h3SmxMb3hDZHpSNHIybFZ6anBiMnpWQ2s4YVdV?=
 =?iso-2022-jp?B?LzM=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB12335.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?Yk9CNDJzVXVvZjIxaWRUM1lqSEZjbnIwc29yODFKc2YrL2wveGxMS2Ro?=
 =?iso-2022-jp?B?MjloY1JuaVBxcXRqS1VLVU9EbmxidHV2amxhZ2p5ZVNiYzZ2b25tKzR4?=
 =?iso-2022-jp?B?MlV4ZEVJbnZlS2lldkNrbi9ZSWJQZGdrck5JZXRUb2VsMEViMk9RcjRv?=
 =?iso-2022-jp?B?SW5WaHplU1UzR0drZEc1UURUejlJQTNtY1Z3dE1nUk9oOHJETTFKeENs?=
 =?iso-2022-jp?B?VTR2ZXBsdWZrcVFVTEp2MUU2cm1WME51dC9GOEQwWWxTcHdpQjdyeDA4?=
 =?iso-2022-jp?B?amdmY095aFlaV2tCbzRqS2ZTKyt5aC8rSjgxZ0RrekZTQlBFcmt3Z3ly?=
 =?iso-2022-jp?B?LzU2RjVHR04zRERGNEhESHQyUkw2T1JLMTUvRWtXdEhmTFVSd0hBQ09p?=
 =?iso-2022-jp?B?eElDR1lmb29raWppRVh4djhJOHlwVkZvRWJKUTloZnFKSkk4d1UzRzdp?=
 =?iso-2022-jp?B?UEx3S3JKd2JxZGRtU2YyWDk3WEpNWHd3RmxISkRhbnZLL2MrdW5iQzEz?=
 =?iso-2022-jp?B?RVlpcGhSZXFOaXRjUUprMmg2RTVqYTNwMmZnWWZXdVdtR2RlZXhYTWJ3?=
 =?iso-2022-jp?B?MVlVSm13ZnJuMHA1TVF3Q3VWSHZWTWNDMVNvdU1TZ1Z0bE14NmdZMjhP?=
 =?iso-2022-jp?B?TWJmUzRpOXp3Z0dGMlVFNTE3WkdRRWdYbkIrY2lQbkJMaHU5aVd0K3pj?=
 =?iso-2022-jp?B?S21ZbTZIbFBjaFZ5SnRybTdzbFA5WDZOQTNMYyt2aVFsMzBoK1QwTXhn?=
 =?iso-2022-jp?B?N1BQL1hXanVtbSttejhQUE51RVFpS3dOWkJYd2Q3eEFPdStBSWdBdXZV?=
 =?iso-2022-jp?B?UDNtTjY4UnJUelFXdWU1N3FsRVJ5b1EybmRydlBHOGZMT0xHV2t5WnND?=
 =?iso-2022-jp?B?Zy9nUHNSbFZRZjVkemZRYkRrZjl2QkovN2duZkdsZHMyRkFHanFta201?=
 =?iso-2022-jp?B?bDZkeVJzR1RQaytzaE9mSUhTdXZnZXFUNW1PT1cwTmw0OUJQTytZTlJM?=
 =?iso-2022-jp?B?cmVMbnFIVFh1QktyZE9VTVNCRTZBTkxzdHFucjdPanJXYjMzZnA0WGpQ?=
 =?iso-2022-jp?B?a3NmMjFVcTA0L0R1TVpRMjY0bW5EVi9JdmQ3SnJVbjJ0MGU1WHVleDFR?=
 =?iso-2022-jp?B?MnpYb2NuaElHVEd6SEhwNU45VmFWTWV0ZXlqY2lnOUMrdExMYnBwS3NL?=
 =?iso-2022-jp?B?VmdsTmdjV2hEcU52ak5pWFFpdG9YUDM4RTh4WnYvV1BTaytHQ0cwNTJ2?=
 =?iso-2022-jp?B?ZG1CNEpIOEJKcmtPL3NOS2JWNnNjMitDcEVRU3ZMUk5NMmtmYjZhV1dI?=
 =?iso-2022-jp?B?YTAwMEZpeDlvTXF0ZVM5QjBkd3JwVnBKSTNlVmsxRDVrZmdRTTMyektU?=
 =?iso-2022-jp?B?NTY0RWtaSyttM0NyQjNGUzE2cGZKU3pXT1JjNUNwWFFlRiswRHN5alpX?=
 =?iso-2022-jp?B?S0ZZanM4WHlnQllPdkpqV3kzZVZjMU8xTlJ3bUd6aUNTQy9SQnFuMkVu?=
 =?iso-2022-jp?B?NCtGYkRCNUpRb0Z5bmZzZU11V21tdUM4WXdld1gzZ21SVm5UOVNWVU5a?=
 =?iso-2022-jp?B?Nno1dmpFV3J4a3pJUDZKYVQ1RnFNWEFYOVRVSTJoSkJpdUJBZVEzbFM4?=
 =?iso-2022-jp?B?SE91OGR1TGJaN1QxQUhrNDV4WElwV0N0TXlYOXpxQ0ZKRVBpdWJUNk4x?=
 =?iso-2022-jp?B?MjNHYjNzL3Y1a01FeVZnaS9EQWV1SEdtY21ZNk54TUNJcjM4MmpaVm9r?=
 =?iso-2022-jp?B?SW1xZnU0NDlvUTlHZ1czdXJBbENQMWMvdmNOSWZiWGxRSWsza2cydDJa?=
 =?iso-2022-jp?B?WEdIcy90QnA0bXJrQm9idDdrNnJqK1BrcHQ2SHo2UUJqMGI5N2kzUG84?=
 =?iso-2022-jp?B?V0Z6dDg2WE9mRkNUWVE1eVIxUjFHV2dOOTdJU3Q1eC9hY01jOXloempa?=
 =?iso-2022-jp?B?blE4SVpLaUNVcjU1eUczZFNHb0JQVlhOZ0djVk03aUVWRHRvb21ZbG5H?=
 =?iso-2022-jp?B?aStEdStxYW9DRk1LSkVyaEhYZ1JqaXFTWTBHOU9aR2ZMMUhQV3VRQkJK?=
 =?iso-2022-jp?B?aS9lZHo5anFqRXpRR2FyWUUrdjNDUTZ6bGxtVWJicm1VODNvVzBtVDFH?=
 =?iso-2022-jp?B?cFhMUlkxd0lpQ2Q0NGZqS04yTnJBc2pxSHBmc3lMN1RDVUVzSmhzSHM5?=
 =?iso-2022-jp?B?OXpDTGI0dUJWOTkyM1RsQU5Hc2Vud3BiNXRCRXpwVUIzS2R1WHp6K1cv?=
 =?iso-2022-jp?B?RE9XaE1wdjh0M0VraWorb1duMzRnRG40R2lBUWtHK2ZQYWFuUXp5RVhL?=
 =?iso-2022-jp?B?SmVMdA==?=
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
	mEq/+6SxcyR8bNjKeD/Q1RhudMU/Xm3ekUDbmcvUTdi0KaQ5jV7iaUoFyPw0hDl2GZJ1gloTVY29a3IZCO3G0UK1h56zqGg7lCpTvc4UYf9AMtNjkyIQk9PG2m5sVVvnoQv/cQgiCVQXQOCqi1osZplDNO/ZMHA8dFGYWKJX9elTJ67Oq/mHsrBQcHr6TIJjssCasRT4I0A7/Es22CzyeBy5uus1kQqRs7hTJs+62UenKXYycTUb0XF0ABn0V/a86YdjAmDTCQBjeCFv2pKGxzILyjc0UySeHHLhwnPGPTCzuYD9EC7uR9eAqun/KU/wQoInyD3X+TaNvwG/jUJR8KaqQ+Gc3JcT+Q4uFg8MfCokEHI0rve8QFdl6n53juEwqyy/MTatZQ7QH1fjBgw/jy9gDtq+r0S+gxVDnqUrC6AL3t0/Pwp1JlLNVhkvg3C24P3J7bRCuRrYf8oaXtVUd7UYStvEy5J3FlapLYPMteQEXL7Dew9Czj7PcDqF6h4xEpT/172cAymNKSFAcE7Tuqt+RfgjMrHAzHW35au8sYaY+xU/4P6GL4vdgY7/rM1xfu4X80iMgxGmhH8fg2XtkCCuZzHXagqUqZIq+XToqxhDI4ccSHlQ2U9MTOuxQVmW
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB12335.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e872e664-1d39-4959-681d-08dcddc5afc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 00:53:50.6596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +6PxomUTTqL1QczGg3QZYft8ssjrv1rNCAfgIpOAqU3E8hOxlVdO//Xro9VxQ+7LDLZCMZUpN1csBrnvg0yQTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10030

> On Wed, 25 Sep 2024, Alison Schofield wrote:\n
> >On Wed, Sep 25, 2024 at 10:41:46AM +0000, Yasunori Gotou (Fujitsu) wrote=
:
> >> Hello,
> >>
> >> I have a question about sanitize feature for cxl memory.
> >>
> >> How to start the sanitize feature for a cxl memory device?
> >> Is it just writing "1" to /sys/bus/cxl/devices/memX/security/sanitize =
?
> >
> >The CXL unit test, cxl-sanitize.sh, demonstrates the ABI.
> >5db52b115620 ("cxl/test: Validate sanitize notifications") Hope that's
> >helpful, Alison
> >
> >>
> >> I found cxl command has "cxl wait-sanitize" feature, but it seems to
> >> just wait the completion of sanitize, and not to start it. In my under=
standing,
> there is no feature to start sanitize in cxl command.
> >>
> >> Are there any plan to make "cxl start-sanitize" command?
>=20
> I sent it out at one point, but never got merged, just the wait-sanitize:
>=20
> https://lore.kernel.org/linux-cxl/20230713195455.19769-1-dave@stgolabs.ne=
t
> /

Thank you everyone.
I understand the current status.
I'm looking forward to the start-sanitize command will be merged.

Bye.

>=20
> Will rebase and send out again.
>=20
> Thanks,
> Davidlohr
