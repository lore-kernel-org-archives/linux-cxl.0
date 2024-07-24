Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13584A39
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jul 2024 23:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864369; cv=fail; b=tuaEeN5rnY5su2c3pCVHzW0UwFfKB4AdP3NXh4+OQm81FeoAZDCh5+/VGu0rsE1qXn07mTIn9dpZ8Q4hdmRB4py3HnAOejm6SK4605Wr25GkQ8XGb98UobNGwRKxr8fdligAb1DAVEqUw4jjI/CVGLfPt/pL1n2bqz2/Pxsfvo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864369; c=relaxed/simple;
	bh=JE902e9a+ll1uwhjBki+yp+MFOIZQZx04gNOWPFDeVg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UTEOVueNHGfNQObu1PzRv/8u9lre8riCyiHZA8nZaBejnLP5H6WWyxK9UmwMD5+ehM/v0TQy7VHVDkF/AtpBD2V5GTwK8+HcKop3UyBW5DqK4VBzDRBk9c+brq38aN395UG8T8bTuBCVagf1EGV264WVUiygHHXf3OV8HtqYm7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=LVb+1vj7; arc=fail smtp.client-ip=68.232.151.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="LVb+1vj7"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1721864364; x=1753400364;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JE902e9a+ll1uwhjBki+yp+MFOIZQZx04gNOWPFDeVg=;
  b=LVb+1vj7BOCX8ep364MjcuWwzIjOakZGz8870CeDEyoRMoZDJ/l98D3v
   U0hn3wSsSc036wVbbsT2/346iRhOQJabw6eMGZPw0GcH6qshHl2aNIDfc
   ugb41eJYMAHSehJE+rVOVAdoZReLC+9g64/G4Cr/FRdT8vuCg7vVvHmUV
   saMrU9vXw2rIgZMVNxZcaz56F54EoZA5GTVSdvG3sGNeE49XDBWB1qEaG
   sxrejXSs3yPWcxiMsjKzoB4tLxg6xuibclldzciD12IrUHzBtTBsikVzH
   K/a5D5IO0EqYeGsURBoBmwVJldQONk1qZg5++TPIWcNSl5lCFo59OWYQv
   Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="39124286"
X-IronPort-AV: E=Sophos;i="6.09,234,1716217200"; 
   d="scan'208";a="39124286"
Received: from mail-japanwestazlp17010005.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.5])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 08:38:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFwb7McYveQE/NIXO1QN0uNTG851KQ5XshmJpivNz0KWzoNoEgnv55k5yPVYCH+WUMNycoE6NJZJXv9KCN6f7bg5ZGU/ggBb2AUYoJ+WeB9T0iu2fHMSN1LMzsm/dkXO8jTFdbzP4VVocbAM4Xnm58Z2AUJ4+OP2x38zZhhwdUEjHM/UOvOvgTccf2UvfyNGO8MoXNO6TNiS10qiDHtGn4dt7/lol2vFfbYPqvHYCEb4dmCmSlBtMkqqxNbO2az1DlWYjyV6Co2vDNROMIKIi054ewVxvckGGXENeeBh+5LGw0OyzZcfBEcZpgZA0lJNFrSzmEWZCFXRpZHJGWaa1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oFodyPgKI8ABl81GKbXN74OFWVg6ktEkgG4k1HJRsY=;
 b=FaqLxZLYA2XTZr/lUAuP0exfxmQavWvbQHrHNDdkDyI0Cl8E5sxWORgi8yP3ChUyJa99enM1k9afq8UGs4Lrh+Q2+Gej8alhxpLOklJhVtIbRrUyr7QwLucr3Fh0tfoGkdLl1n8Fp62lP0qZ6Q5Gx7dpFUFxFkLDsIMXqT4w8Z84IAEO6xsNvQI7n/x+g69s2mpnFpHvlq8WMWy1OLPoijV7rGO3int5Db6ZDqQiROhOND6mdaMQCMIrWoB0D5bn42CA/9xsfXHVuac2Zsvrexz2hOAy6LdSWxbnLTGA2u0/J1wCQPS7M4zJxBWxfEL4G+su9T1GYWzRXFTTqR0rfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TYCPR01MB8644.jpnprd01.prod.outlook.com (2603:1096:400:159::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 23:38:08 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%5]) with mapi id 15.20.7784.020; Wed, 24 Jul 2024
 23:38:08 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>, "mj@ucw.cz" <mj@ucw.cz>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "Daisuke Kobayashi
 (Fujitsu)" <kobayashi.da-06@fujitsu.com>
Subject: RE: [PATCH v15 0/2] Export cxl1.1 device link status register value
 to pci device sysfs.
Thread-Topic: [PATCH v15 0/2] Export cxl1.1 device link status register value
 to pci device sysfs.
Thread-Index: AQHa1zfXlIHI+eTXY0SvmFtj6emi9rIFZTvw
Date: Wed, 24 Jul 2024 23:38:08 +0000
Message-ID:
 <OSAPR01MB718256D5D21504C488ED267CBAAA2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240716042540.89639-1-kobayashi.da-06@fujitsu.com>
In-Reply-To: <20240716042540.89639-1-kobayashi.da-06@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=True;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-07-24T23:38:08.043Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TYCPR01MB8644:EE_
x-ms-office365-filtering-correlation-id: 1dfb90af-e0e0-41c1-7546-08dcac39ac3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?elRXZkw3YTE4c3NVeWE3SmVWclg1SCtXVTYzQ1haWURic3VBc2gxeDdi?=
 =?iso-2022-jp?B?Y29ITm9QT3FlUTF2d2twam0yd2NSQkZOUERhdnljYW9tcU54aGpocndj?=
 =?iso-2022-jp?B?MmN0RElZSUFOK1RYc2ltVFFwemdwT0hiRmIzTE0xSGt6V3AvOUZneDVT?=
 =?iso-2022-jp?B?WlloR1FPb3hkMG9RL0VzdVNPRk01b1ZVN1F3T0JPenpJcTI4bkVJckZE?=
 =?iso-2022-jp?B?VWhLTWVBZjNkdVkwZVBwWDZ5UDNKL2RSRkhiWkhXcExCbko0MDFCenh5?=
 =?iso-2022-jp?B?eFVCVHpTZXlESDU3clNjZkx0TC8vd1l6b2tFM0Nnb2VKSHhQQWVFOG1R?=
 =?iso-2022-jp?B?MDZmcncrYk4xUGpqekRqelRkejUrT0xwRVcyejBvWmIzVTRsNGp6THoz?=
 =?iso-2022-jp?B?b0R2U2hHWERReTluYkRlUjd3d2ltR2RUOTZEU0JEeHBpVDdnTEpKM25I?=
 =?iso-2022-jp?B?Y3pZZDJaWlV3OEN4Nm4xN0VLeERHNHBjZjcwMEpZSlM5WTVrcFNIVHdZ?=
 =?iso-2022-jp?B?VDI5TjJvd0V0RjlQRFNySVZsdHdDMm13bGkybEI3NkdWTlZIUUw5ZzIz?=
 =?iso-2022-jp?B?UlE4L3J1ZkJ1YXgxMm5lTlhGNi8vSm9GMUtMMytzZmdTV1RkRWRVbllE?=
 =?iso-2022-jp?B?ajV5YmtjQXg1Q2wrTmkrWlcwclJ2T09xd0t0ZmlXT293UlJxM1FoTC8x?=
 =?iso-2022-jp?B?c0hMdm9ocEdFV21Lak1IMlBUblg2Y3hFRU1ac2M0d2ZhaGUwRlQxUDVl?=
 =?iso-2022-jp?B?NE12RXFaWHFrcjVQTVJiejMxcWhjT0RReWtpV21ZalhlZUZaaEs2ZXdn?=
 =?iso-2022-jp?B?WFpwbjFpK2pVNjRNMzdGUHJHZU9DWTdmUExMcDFaam1pcW04TU5hL0Vw?=
 =?iso-2022-jp?B?ajVJZ2swNzJQc3lMRDZYbk52N1VvdUtaRS8yNWZzeGhMdkNxamQwVGwr?=
 =?iso-2022-jp?B?cC9VWkVTQ240Z0NnZVZKZTBHSjZWUDMvVzhkQVhMUDZZbEdwMkFxU1Vq?=
 =?iso-2022-jp?B?cktqdkxHUFdmbVZWTThGSXF3SmhnVE55aXpjL1I5bGdmNTdpYWRoRjIr?=
 =?iso-2022-jp?B?N2ZtYW95U3J4UjY2QnZtNGxEMkNaM2JuWmRZS1R3LzQxTldqTDNZRjNj?=
 =?iso-2022-jp?B?K01CUGhRa1J3NHF0R1htNGljQ0ZCQnJVME5MaEZHVGtJSTk2YVVLK3VW?=
 =?iso-2022-jp?B?QWVVSm1JbWEwbVBPQXRIejhUWnZseGUxWm1Gc25qSTlyOVFydEV4b1Jp?=
 =?iso-2022-jp?B?SG5mejVIamcvSTZyemVhajlrNHRwSzI3Q1J2aUdmMEQ0QWJzVUVFYmZI?=
 =?iso-2022-jp?B?R0M5dkFvR3laUzZDVE5aS2V3Yi84cFVwM2MxNEJZZ0pGMmcxTEFhWWxx?=
 =?iso-2022-jp?B?ZjArbVYxeFhiRjZGUlhkaGJJdXJITlFnREtCSEtHek9IKzJrNEZ6cmwr?=
 =?iso-2022-jp?B?Z08wK1d3OFhDM3RDcEZWcmFKZU5RR1NHc3YzZGc3ZHNlZ0dIZXZtSFEz?=
 =?iso-2022-jp?B?NGtlQlZNcmVaS2xIYmxrNnJYMWc3MDcyYVBmeGYyTkZvYWVmSUZkUndy?=
 =?iso-2022-jp?B?NCtpYUE5aGt4bExibkFIdnAwb011U0xwU29XUlVuUnVzNUszcDl3OUlu?=
 =?iso-2022-jp?B?cjJXUUE0Q29wcFI4Z3NkM0ExcUhOVTlxZUFWWkplOFNnamFacWtiS3Zj?=
 =?iso-2022-jp?B?Tk9uZkFxTjhnR3ZacUdWV2ZUM3gwVnVCM3FoVTR3Qk95RnNuR3E2OWpp?=
 =?iso-2022-jp?B?ZzdpUFVCdDdjQ2gxOUpNZ1QyaUI3bDQyZUlTUXBuUlZVWHIxeWM3b05k?=
 =?iso-2022-jp?B?NWFsWnJpZWpyZ1J2L3ExZzNsR3FZRjArdklBL2FEcDVqcGVkaWErSXgy?=
 =?iso-2022-jp?B?eTFwOFlQSU9NUEFmVjJMaXQ5cytwWHpRV2pHcW9ybS9pOFh1bGNPOFZw?=
 =?iso-2022-jp?B?RkpDeUU3NG5Ha00rQkFSMGxzQlFKc3dpU2h1L2FPWVNFY0cyTHNuY09D?=
 =?iso-2022-jp?B?b0JjdXY1cCtnWkthSGFsNTU5Z1FEcGxQVG45V0hOZWpzZm9aVUdIV05Z?=
 =?iso-2022-jp?B?ZUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?b0prN3FUaG5uL3BHRFVldFArVDVROW9FcWswSzlMaUFuVnVvakkvS054?=
 =?iso-2022-jp?B?SjRvdGF1Sk44QVlLV25RVWwrbnJDdEpzSmkyZGZMSlNwTWFXZGRzWHFK?=
 =?iso-2022-jp?B?UmZqTW9iS2czSFhMSzdvTXN0UHpZamVuS1BuWXJGV3lBa1ZFNmovTE5w?=
 =?iso-2022-jp?B?dzNWN0pXNHFIdlc4STNpWHRxZlB5MGRlZ3k0ZE16Q21FMjNkeFNSSFM1?=
 =?iso-2022-jp?B?OWJBRCtWelVFN05pM2grcDVwb200KzBEUnYzMUZNdGduTEZvZ2l1UHVH?=
 =?iso-2022-jp?B?SVNjU1FMVTNPTVZNM0ZucFhvTFhDc29UWHlGQnhXR21PT1VQRWZadk42?=
 =?iso-2022-jp?B?R2JNOU9GVlVCQm9mZG5SRzI4RS85M0p2d2VWdm84RSsxNUJxdXpwS1Zh?=
 =?iso-2022-jp?B?ZFV5UW94N25SV1BFUDh2TkRKUTVmRlFxSjhENFZ4cG1QVVY0ejN1T1hM?=
 =?iso-2022-jp?B?c1pHMGxZY3oyRktzUk1qOENSYVhYWU91aUJkNkFhVHh5L2dIbU1IWkJV?=
 =?iso-2022-jp?B?ZjRYWTg5QWtlY0l3QXpYYTlkNHptNEw4QkFHbFFpL01PUmphMFZOSmJP?=
 =?iso-2022-jp?B?bTZnQlZGVC9uRUJWZ29KTm4xVFRhbTVjTzNGTGN1cjJEV3BCbXFBL1pn?=
 =?iso-2022-jp?B?RW13c0tqSFBpR3hWdkh0YmZTejh5VVp3NGNSMGwwUHRaQlBKQ0lDeFpK?=
 =?iso-2022-jp?B?M1ZuUHZHVFpoU0JVOXFuazZpcFBYcHg1QjJ4V3pDb09jZlA3d1FHWWJn?=
 =?iso-2022-jp?B?TnA3bmk2dUozQ0NKS2p5L05qd2VkVi9FZWdoMmx1N3lUVnRxZ1dSb2Z3?=
 =?iso-2022-jp?B?RnZSU01DczZmMnRuaFVnOFFvT3dPVFV6T3NOV0I0dzFxSHdRZXlyZ2ht?=
 =?iso-2022-jp?B?TVZKTlBQZXlxdjNNa2E5M0EyWEpwYTRvYklUMC80Qk9VT081UTN4cWRy?=
 =?iso-2022-jp?B?UjJzWVMveC80d2NJMXNOUllLamRVczhQZzVpdjZhcDNPL3JCRGdQSnI3?=
 =?iso-2022-jp?B?bDZ2SkxNSnFrTk1mR1lUUXBNUTI3cWNpc28wYjY2Q2I5T1NGeXpMbHpX?=
 =?iso-2022-jp?B?ZjhTWVBYNnY4Syt3K3dGMFF2WHdpR1p0ZTdHYUlLYnhKNzN0cTdTdXNz?=
 =?iso-2022-jp?B?eVNUdXEwNG9xbGFmZGJOOUwvUlQzK1BGbnJpQlFZSXJpZkNaNUp5aUlU?=
 =?iso-2022-jp?B?M2pxN2JvOTluS1lSTGd1WVBSdFZPaklxUHBnL1JWZEtLeWswa3ViSDRo?=
 =?iso-2022-jp?B?a1g2UkxhQ3BqREFVUVlkTkpMWkhUSml3dWV3Zjg2bCtISHdFL1A4NFcz?=
 =?iso-2022-jp?B?TUl5ekRFVWZuejJkR2QrUmtzTEVmOVVJNWdYZytkU2R3VTM4cWtSMjhx?=
 =?iso-2022-jp?B?N3N6SVBGY0VVUzV1cUZJcUtqd3lRdWIxN1AvaVpZR1AyZXRkZkRBb3FQ?=
 =?iso-2022-jp?B?bGNiUm54OGFTSm1QVmtIcHNJUkJlS2J6cjREWTR6cTdlK0J1M1dnd3VS?=
 =?iso-2022-jp?B?WE1qUXQ2N3RWU0pYOG5jZ3VUd1VQS1Fnc21WemM5OUg5NWw3SGdlUmlm?=
 =?iso-2022-jp?B?NVJDMkNIcU1TejJjOTgyeEMwWVRKcHhMZmV3TWJIQm9IRWtMbzMxUDg0?=
 =?iso-2022-jp?B?SkYzdklhNjZ2Lzcyb1pqaTFrM3VNQTdMR0lsMkdrSmtKbEUxM3F1VTV1?=
 =?iso-2022-jp?B?N3dBMUVmbmV0R3g0QnJ1Y0Y0OGc5SmJobHhNVS9FeHlIK1lVeWo0L3lC?=
 =?iso-2022-jp?B?S2lWWFRJVDcvU0krQzJ4NWtpeU9rRnpIbFQ4Z0NqdFpWdEN2MTcwZHBR?=
 =?iso-2022-jp?B?a2xYZmZ5MHhFZnRnK20yRkxwRnBwdkpSRXZhTDdYSjdDc1N1WFNYbWt4?=
 =?iso-2022-jp?B?WkNvL293WUJTZWIwRzZ5Vkg3SndoS0Q2eXlBdjh0Q2JHN3gvVFk3VTkr?=
 =?iso-2022-jp?B?eHZ1TzQ2Y2lZRW5tcUhuckZoTjNiTEpTSnliOXlHLy9GZFFucXZrQ0Zo?=
 =?iso-2022-jp?B?My9IR05OLzhQYWdMWFkrVThuZ2p4RTNVQ0licEdwL2YzUHRaQXl2ZU43?=
 =?iso-2022-jp?B?RnhTSGtoWXlNZFhIN0pSd2ZNUXEwSW5RRXIybUJ4bElrWTF3SXFnZnBN?=
 =?iso-2022-jp?B?d1NocUs0WDJmdngrWmV2cVlVckdPVWF2RFhmSkJxWVhERTdKVGJsRGl5?=
 =?iso-2022-jp?B?WVBRZ0hUTmxpS3F3dmVHQ2JaVTMzQS9TREtkcU5aQm9Sd1p1SnVBQW15?=
 =?iso-2022-jp?B?WmNZSHd5OGVReGpFS1FwRi9xc1V4QndMY3VHQUV2d3Z3UzZsRUJPenN6?=
 =?iso-2022-jp?B?NEsyR29GQ2xiK3JLWStmT0x3SnF4SFM2WlE9PQ==?=
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
	AmFay+bemlbOkZUrhkg3c9aXCgSJO5uX+6t50inTBXPChH5ZBlgguINvcgZgMQolxFegF0Pt7WiWebopNZEyEL5UBil8LP/UxkFqQY4VnLUrGE1cDgO66wTYNPSepHSmDYDTOo3FgAM3VCIMd/+JIWX+7vhHsij4W7oushUlUxpECBsl17+15YEPM5B6q0fAuu+42rfIRxLHC/3ZtOEEuPyCojLJ8b05fVnyJL5XJnc0qnivuDCk/uLa+nqnImrBADOGl459nZprShXFku2m7pS898Ru9DjLoXfttfvtD18cKaj+wmjexA/up4USmDTWXofwNwZDknywoS0Tsut7iIE9WZ5qp1icGP6Oq0X3qZVhx33Uwq+PWrk8c+dcyZA0hswcfHd8kxDPKnawPLQF2Zoswkk3lqoKR/3CHM+brFCs1kioaJ5fJ5001N7HtJ/X0k8ZX7BGXnNdbcZ4uLLotm4Cxwzo/A5Z7MQfmpczNhdXed9yJhns3d24IJO4hcJZ1CQ/DqjsYlUAkGYviULv6iFhGz2U/Qn0+fbXwHUVlJRI1PnGQZr1vlTxgNtvXWlx5B8MlkPy2400Et0shUFZ5ng2LJHTq2nv+wfORoN9RI7hKL9rAnNhjfGn6kr+661A
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dfb90af-e0e0-41c1-7546-08dcac39ac3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 23:38:08.2441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H4dJ8K1CGcwETYODHxzG9KfYUGLs8hxYU9KOYC9y2MJzoGOmWXmK3KO2EO2qHiXywhA6+4X6UEXSlkLkegv9QjisHtxXm1GbmyBif7hodew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8644

Kobayashi Daisuke wrote:=0A=
> CXL devices are extensions of PCIe. Therefore, from CXL2.0 onwards, the l=
ink=0A=
> status can be output in the same way as traditional PCIe.=0A=
> However, unlike devices from CXL2.0 onwards, CXL1.1 requires a different=
=0A=
> method to obtain the link status from traditional PCIe.=0A=
> This is because the link status of the CXL1.1 device is not mapped in the=
=0A=
> configuration space (as per cxl3.0 specification 8.1).=0A=
> Instead, the configuration space containing the link status is mapped to =
the=0A=
> memory mapped register region (as per cxl3.0 specification 8.2, Table 8-1=
8).=0A=
> Therefore, the current lspci has a problem where it does not display the =
link=0A=
> status of the CXL1.1 device.=0A=
> Solve these issues with sysfs attributes to export the status registers h=
idden in=0A=
> the RCRB.=0A=
> =0A=
> The procedure is as follows:=0A=
> First, obtain the RCRB address within the cxl driver, then access the=0A=
> configuration space. Next, output the link status information from the=0A=
> configuration space to sysfs. Ultimately, the expectation is that this sy=
sfs file=0A=
> will be consumed by PCI user tools to utilize link status information.=0A=
> =0A=
> =0A=
> Changes=0A=
> v1[1] -> v2:=0A=
> - Modified to perform rcrb access within the CXL driver.=0A=
> - Added new attributes to the sysfs of the PCI device.=0A=
> - Output the link status information to the sysfs of the PCI device.=0A=
> - Retrieve information from sysfs as the source when displaying informati=
on in=0A=
> lspci.=0A=
> =0A=
> v2[2] -> v3:=0A=
> - Fix unnecessary initialization and wrong types (Bjohn).=0A=
> - Create a helper function for getting a PCIe capability offset (Bjohn).=
=0A=
> - Move platform-specific implementation to the lib directory in pciutils=
=0A=
> (Martin).=0A=
> =0A=
> v3[3] -> v4:=0A=
> - RCRB register values are read once and cached.=0A=
> - Added a new attribute to the sysfs of the PCI device.=0A=
> - Separate lspci implementation from this patch.=0A=
> =0A=
> v4[4] -> v5:=0A=
> - Use macros for bitwise operations=0A=
> - Fix RCRB access to use cxl_memdev=0A=
> =0A=
> v5[5] -> v6:=0A=
> - Add and use masks for RCRB register values=0A=
> =0A=
> v6[6] -> v7:=0A=
> - Fix comments on white space inline=0A=
> =0A=
> v7[7] -> v8:=0A=
> - Change the cache value to offset=0A=
> - Access memory map area in rcd_*_show() functions=0A=
> =0A=
> v8[8] -> v9:=0A=
> - Map the pcie cap in for all the time the driver is bound to the device.=
=0A=
> - Add mapping the pcie cap in cxl_rcd_component_reg_phys().=0A=
> =0A=
> v9[9] -> v10:=0A=
> - Change a utility function for getting PCIe capability.=0A=
> - Fix tab alignment issue, error handling, and apply suggestions from Jon=
athan.=0A=
> =0A=
> v10[10] -> v11:=0A=
> - Add functions to have one function do only one thing.=0A=
> - Add a size parameter to utility function arguments and consolidated the=
m into=0A=
> one.=0A=
> =0A=
> v11[11] -> v12:=0A=
> - Fix the error handling in cxl_pci_setup_regs().=0A=
> - Fix and clean up some details.=0A=
> =0A=
> v12[12] -> v13:=0A=
> - Fix and clean up some details.=0A=
> =0A=
> v13[13] -> v14:=0A=
> - Fix and clean up some details.=0A=
> =0A=
> v14[14] -> v15:=0A=
> - Change dport lookup to be done only once.=0A=
> - Fix the visibility of cxl_rcrb_to_linkcap().=0A=
> =0A=
> [1]=0A=
> https://lore.kernel.org/linux-cxl/20231220050738.178481-1-kobayashi.da-06=
=0A=
> @fujitsu.com/=0A=
> [2]=0A=
> https://lore.kernel.org/linux-cxl/20240227083313.87699-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [3]=0A=
> https://lore.kernel.org/linux-cxl/20240312080559.14904-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [4]=0A=
> https://lore.kernel.org/linux-cxl/20240409073528.13214-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [5]=0A=
> https://lore.kernel.org/linux-cxl/20240412070715.16160-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [6]=0A=
> https://lore.kernel.org/linux-cxl/20240424050102.26788-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [7]=0A=
> https://lore.kernel.org/linux-cxl/20240510073710.98953-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [8]=0A=
> https://lore.kernel.org/linux-cxl/20240606074814.5633-1-kobayashi.da-06@f=
=0A=
> ujitsu.com/=0A=
> [9]=0A=
> https://lore.kernel.org/linux-cxl/20240610082222.22772-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [10]=0A=
> https://lore.kernel.org/linux-cxl/20240611055254.61203-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [11]=0A=
> https://lore.kernel.org/linux-cxl/20240612075940.92500-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [12]=0A=
> https://lore.kernel.org/linux-cxl/20240614045611.58658-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [13]=0A=
> https://lore.kernel.org/linux-cxl/20240617043702.62028-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> [14]=0A=
> https://lore.kernel.org/linux-cxl/20240618042941.96893-1-kobayashi.da-06@=
=0A=
> fujitsu.com/=0A=
> =0A=
> =0A=
> Kobayashi,Daisuke (2):=0A=
>   cxl/core/regs: Add rcd_pcie_cap initialization=0A=
>   cxl/pci: Add sysfs attribute for CXL 1.1 device link status=0A=
> =0A=
>  drivers/cxl/core/core.h |   5 ++=0A=
>  drivers/cxl/core/regs.c |  56 ++++++++++++++++++++=0A=
>  drivers/cxl/cxl.h       |   9 ++++=0A=
>  drivers/cxl/pci.c       | 114=0A=
> +++++++++++++++++++++++++++++++++++-----=0A=
>  4 files changed, 172 insertions(+), 12 deletions(-)=0A=
> =0A=
> --=0A=
> 2.45.0=0A=
=0A=
Hi, Dan. Could you please review this patch?=0A=
I think I've fixed the issues you mentioned.=0A=
=0A=
Thank you.=0A=
