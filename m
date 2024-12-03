Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [139.138.35.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017FF1DB52A
	for <linux-cxl@vger.kernel.org>; Tue,  3 Dec 2024 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.138.35.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733260559; cv=fail; b=t6+SujrM7RKUVwE+2I4CbxASFAq1CsnOjCdYC/LkW1KEA5lNaCbQU2t7ZP17RLzoX7iQab8532XZzR7c3ixn3w4R4hinC6Y2xaE7IV7jW4e+Rg/SBFXzeP2y/4UHG+0GFe1bulvfTgaaNgXRQJ+CSwev1/T/DWOx+VEJWMuTqRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733260559; c=relaxed/simple;
	bh=YEo757Zudf+dGBSXPof05/29qMqFtl8G7LWmpR0MPv4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hWxY9TkSsDHqXGDdjnfizFBWMzwuRf8gM8x6RMX5zSPP94Gk0QPGjGfQkr6SRze/0t2RMJb3doK+x60USTDQW4pwF79MD8UoadnDNmnoZESXlIV6wzJ/mkVxa1ZScFKX/eKKF7OwYjIqJV2I53IJqql5Ttjc8Hj59F06jYsvU2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com; spf=pass smtp.mailfrom=seagate.com; dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b=HC3gtvR+; dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b=N+NNrilQ; arc=fail smtp.client-ip=139.138.35.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seagate.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="HC3gtvR+";
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="N+NNrilQ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1733260556; x=1764796556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YEo757Zudf+dGBSXPof05/29qMqFtl8G7LWmpR0MPv4=;
  b=HC3gtvR+jf1Y1kRktfbbPcTn0sbPJ1aBL/ke6dueREcEWVhYbII0FW8y
   R9LwAC5x0g+RsNxsO5a3aPG3O0CbaQ6ufNfGzBakvXHxR29koMsp8mr3P
   C5vtw3nwmGkqTZBroZwlcTqb4tBkj3WaZnpqk548LolmUfRQzuHPda7w2
   Y=;
X-CSE-ConnectionGUID: BWy8VrT4RpCy1mSHdfHwiw==
X-CSE-MsgGUID: ZJVXrsq4QdqrkUokA7S8MA==
Received: from mail-bn7nam10lp2048.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.48])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 13:15:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBO+Ym7HMA0IREh5jX74xYthuEZ7B3dLaqXg+ObH7EVteKVsZFQvn19JKAaweNTfON0sfhr/6Y2FQSYFtAGk77EomklDvrLyWyPd4zLUpZAfGO5d0kXUkoi2oxaQ+B4RLPvM65m6cXMdrOlQ5J6Xeu8/1Ahyu+tVwnaL5UX/q0oHNhkttxdc7x40fduOyvmieB9OQ1peAqLEK1v5VWQZbNTk1VCr9WY2lyJR0y+RG/TNw4ARbZcE6pf6Wz0noeu97A90nwMgw5+AGuszo2KuStdfMkqaoEqtrc/25hgmxvNxzYSbc/pLLAsQAgD6wMl8nRwi4soCPDpLfFeZVQ5R3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvSD66/RIRmUQGs65FhSp1zBiuxvMNIoWX1ovuQ6u08=;
 b=uGu1nZmLlUSR93TR2edfosSVyhIgEBTX/Jm6QjrIcnzQN8zMt5LOxt2LT7cpcPkKArs8cq2xSD4AhU2+KnOH/UcZHQfLWBO7mMz2SeT85GjciwNx1124dDhjTVp4yC5ohvxqY3kjzRUYPT7//V+ndD8NQZ/OVwwCwf28AJV9Zlj/eWlzVPsQat5EuJRkfK7jynxXQ/4fHBR2zPqnBkmgGlOaWKvmgGAGRD1dRgAtnrHniVVQpejyk4aMD6GXQp+2yP8O+VFEAwCcTrTcLkAKQFAuYbLPmLEqhSkCsacEY9GqMwQYYZYv1LOp6JioWczY2nEC3o0dDS1LtlKo4F/E+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvSD66/RIRmUQGs65FhSp1zBiuxvMNIoWX1ovuQ6u08=;
 b=N+NNrilQLgAhYfXiil+uiI4VYG8VE3pkmx7Bcwn2lkpBAJRzEYP9mM3eQ6sNNNjNRryk6RZ9Fu76WAxfQJ2dSBQvoX6O22bNaTFUyS5ozp8xgBZdw5avoXSMCMi2xfQOLa/EGkNa0nOWf9IoPZnnVaHW07o78IATiPLb02MsLGo=
Received: from CH0PR20MB4250.namprd20.prod.outlook.com (2603:10b6:610:c4::15)
 by PH7PR20MB6333.namprd20.prod.outlook.com (2603:10b6:510:2bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.9; Tue, 3 Dec
 2024 21:15:52 +0000
Received: from CH0PR20MB4250.namprd20.prod.outlook.com
 ([fe80::41bb:2770:1eb:f50f]) by CH0PR20MB4250.namprd20.prod.outlook.com
 ([fe80::41bb:2770:1eb:f50f%6]) with mapi id 15.20.8230.008; Tue, 3 Dec 2024
 21:15:51 +0000
From: Hongjian Fan <hongjian.fan@seagate.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "fan.ni@samsung.com"
	<fan.ni@samsung.com>
Subject: Re: [PATCH] hw/mem: support zero memory size CXL device
Thread-Topic: [PATCH] hw/mem: support zero memory size CXL device
Thread-Index: AQHbRQx3ZX6TlDCjj0+XnSOVfzNjpLLUxgkAgAA6cIs=
Date: Tue, 3 Dec 2024 21:15:51 +0000
Message-ID:
 <CH0PR20MB42505D4F82D534A85EEA4C2A90362@CH0PR20MB4250.namprd20.prod.outlook.com>
References: <20241202230310.1531219-1-hongjian.fan@seagate.com>
 <20241203172328.00001a00@huawei.com>
In-Reply-To: <20241203172328.00001a00@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Enabled=True;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SetDate=2024-12-03T21:15:50.746Z;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Name=Seagate
 Internal;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_ContentBits=0;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR20MB4250:EE_|PH7PR20MB6333:EE_
x-ms-office365-filtering-correlation-id: 10ec2cb0-51c1-43e5-a11c-08dd13dfaa4b
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-7?B?ZmNteFFkbmhZKy1Qck4yNW0rLXVxUG51a3FhM1pOUDA5TjY5MUc0U1JBRGpV?=
 =?utf-7?B?ckJXS0xWeU9XWVVYdXZiT3Z2MjVuS1hSZHVhV1poWUZCdi81UTFxejNEL1ZQ?=
 =?utf-7?B?M1RoWERGQU1qdnl0RW1KVVQ2MktHNEhNeEUySENPKy1ZWE1TVlhaa0ZTZ1di?=
 =?utf-7?B?M1NhTmdyUFhid0JJdUJMaDNaRTNCaElzRGpYSzJIamluc0JCVSstNmZXdUtV?=
 =?utf-7?B?V0t1Ky0xcklFeE41VENVaXZ6NTZGNnd2aURVWTYxSWYwNDlsMHlKMkZudkE4?=
 =?utf-7?B?UkhRWTdzbW5qaHNLTU41VUJuRjh5R1RXcXBxVVlZTnZjcm5YQVZoL1A4UnVE?=
 =?utf-7?B?dEpLVERla3RYbktaKy1KRHczalgxa2FnSmxLVDk0NFdXVTZJQkcvYm0waWJG?=
 =?utf-7?B?UUt2MTdDRjI3QmxySzhTOFZvdWxiVWtnR2NiaHowSHVFUGovTlFwc0t0bGNr?=
 =?utf-7?B?SGkzTTcrLWNLNU5sYTRFQVcxdGJPZWc2TXRUQ2RTS2s3d2lPZFQyam1Zb0hL?=
 =?utf-7?B?eDN0UEJnN0pwcWRKcGZLREdqeDdKdXN5VXpCY29yWDF1TGVmbUhOKy1La2FS?=
 =?utf-7?B?R3NVdVVvODhNUy9PSWJBZ3lRbUNGWTNtcFZvbEtQNkYwalpoSGQ0bVJpSm9v?=
 =?utf-7?B?L1RWTy9VbGdVeFBQZE0yN2grLURNdk0rLUdHZEpUZ3NhTEdxdlVNT04zSG5q?=
 =?utf-7?B?WEtzTHg2S3hmM3VHSHFGTUV1Q2FEaGh1c3pTakt2SGp2ZTNHcHNPbkNsYzZ6?=
 =?utf-7?B?ZVdSdFJzU1hIN0JiSUNQdFY2aE5lWlRZREJwZlJKemwyU2MrLUx3SWFHYVZo?=
 =?utf-7?B?bE1KQjljVkZzMDBEelNqb3ZoRzZ1bDR0MnlRMk12SjFpYzdKUElFb284Z1hU?=
 =?utf-7?B?RER6YkU2OURsazBqakRWcjF3UGxLdjgxUDU0b2ZLS3VwMldZbG5saG5rOWRZ?=
 =?utf-7?B?R0dJOU1QaVNrcXpnRFB0NlFkUUlBTGQrLW1GWHlQajh0eVJZak1KYWpyd2p0?=
 =?utf-7?B?QU5WMXFrTU9pbHJreFpzMWZ4QVY4a2xWRFo2ZVZ5WUo2WFI5U3ozRmFYSFc4?=
 =?utf-7?B?cEg3OWJGaXgyOEVXNHBQalRCd0ZZcmt1NVU3eWxHTVJzNmhtdXJJVSstWHY4?=
 =?utf-7?B?WVc2eHR5dG8zU011SWQwbDRxczl0b2NuMGJBRHJ4N3NhNk54eWlOZ1Y2RlYv?=
 =?utf-7?B?RXpsQWpMOGd0Zk5RWUFwcmhqbGJZaUdSc0dQRUlhcFRJVnNQa1lTSXpNTzRT?=
 =?utf-7?B?aVJKMWNYL2ZJREFEOHZ4YXVxUkZRdmhXZko5ZnJpNGIvMS8vc21PRFJORVZO?=
 =?utf-7?B?Zy91YlpGaystaTN0YVRGU0VicnpyT3E5bklzeDBsWXlVeWRiQ0prOTNmclg4?=
 =?utf-7?B?WDZOcmdSWCstRHg5ZVJwVnY1ZjNkUUxTWnAwT3h5bVBvWDZNQ0VLckZZald1?=
 =?utf-7?B?cEVWOTJmNDlCQkZPYjE2QmU3RjNpSjJ0eUM0U2xENVZnem9GZjFUOUJnMElR?=
 =?utf-7?B?ZUtiRW1kWnk3SEszMHBtNlBOVkplVDRjcENsMHppa01hOUJQYzlOQVlJMklN?=
 =?utf-7?B?WTNRZlhoR3RBWE1RTDhHVnZpWVYwZzhZY2dQVTdzaXJFY0FvLzEzckVHTXN4?=
 =?utf-7?B?OU82RHpVS2RWa3QwV1Jvd2JtazlFMWRsNjV1NGZpYUhGWjZKSnhuZFQwbzV3?=
 =?utf-7?B?U1pES3RuenNlUG9IbW9sOHJDMWhvcnBnczdnV2E1akszOXk1c1NmUk1STnVP?=
 =?utf-7?B?bzg3bE1pRjhlcm1POFZ6Y2RZbFNxYWd3UVFoaHp2Z21NQmRxVkpNTjZyL2Jl?=
 =?utf-7?B?QlI0WVQzQnlyby9CKy1xUWRvSzdpQUFiRGdHZk85Z1YvdGxxbEZVZmVtb2I2?=
 =?utf-7?B?RlNHdGhiS1ErQUQwLQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR20MB4250.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?MUUxTmlYLzBJZHh5Ky1FOU9TS1V3aUU0TGtQSTBVeTNDSFZuZjVQamhYUjFB?=
 =?utf-7?B?QnFBQU5tdTNGb25yclhpTXJud2dpSzdyUkxobGZLc2hXa00wV1E5NGloR2NR?=
 =?utf-7?B?NFg4cmhEVG00MkUrLSstTystSXU5Z2gzM3l4bTlNOWpOYUhiV2pEQ0tWRFFq?=
 =?utf-7?B?RzZVMnF1R0VrdjFhN1I1enRlOUkza01HbUNBUGFtQnlxSjRBeWRTREF2cm54?=
 =?utf-7?B?dmxINC96eTJXcERtcHFUZGJHcEdGVjhveGI4N052YkM4WWFpbkxQcXJITjBH?=
 =?utf-7?B?Ky04QzJnRkJ3R2dYcTZSS2pEKy0vUlN3cklybGROUCstakFZWXUrLW1WV0k5?=
 =?utf-7?B?OEc4MlhPSHdDTUJsejVGUHcxOVdOaE5QNzh6eXVBeGI4aEp2Zzhhd0pCYk5l?=
 =?utf-7?B?S3JUd2cxQTFKSFhObVJ5dFpxWEMzeEw2Ni85VEFKYmxtUG1QYWZlbTVad2Ji?=
 =?utf-7?B?UmRjMFZYNm51cHN1cXQyZGJyZkgxT05MbzdVOTNoUjZoN0kwbEZjM2tBek5I?=
 =?utf-7?B?UjRWVistZm1ZRy84WTY0N0hCKy1HUXBaKy0rLXJzVFdDQ29JQjhxeTVjUE1S?=
 =?utf-7?B?RXRkczYrLVNqSFY0MXNtcWs2cTc2OVRJQllid1FZV3g4WlR0cnl2eG9lYzYv?=
 =?utf-7?B?cUJla2FjY2d3dUtyY0FuSGZ6THJQQXBDL1UxTWlodFZKQW1lOFpGZzlMd1hN?=
 =?utf-7?B?SVRMdkRuY2xNcUVkcFJiYjFxa1JDSUZweEFCbktZaUtaUWI2RFlUY1VtdTYv?=
 =?utf-7?B?a0tmejNCem8zUGV5Z1pmd2J6WTZzUzR2ai80azQ0RHE5TFpla1hIRFVKcWFv?=
 =?utf-7?B?b25uT3VwaUJaTktwY2ZWbistMjN2SCstNFA5L3R4WDJpdFREeDlJeGg2SHR0?=
 =?utf-7?B?dVBNMG9Lc2paQUY4MW5IdEtUNistMEhXMWljaGtlOGdDZVV3Ky1qTERia3d6?=
 =?utf-7?B?OVlQZjNwdFlQS2dQRnRidS9wTCstZVFFYVlzOTMwV2VXZWdycVVrNzZEOWhH?=
 =?utf-7?B?TFJFMVB6YW5rTXNRSjB5d1Q5RXZFZFJKZi9va2kyZ2ZnWHcybmMzUUVMZEJy?=
 =?utf-7?B?TUM5c1IvclpYTXc1NEJqaUNNWGhjajRlb21MN1VPbUgveW4xR1lLaWEvTUNY?=
 =?utf-7?B?QlI3bnJyZTY0NlFoQUNXV01nejJSUTJBSmUrLUxvTWRqcEExWEJyRWNoeFFM?=
 =?utf-7?B?M2t1aXFaVmk4UkdPRkkyNE12ZW52RHUwMkhlcDN0OG41S1RsM0NxanVVeGxP?=
 =?utf-7?B?WVQwQjhTVVhhYmk2TFNrMk00OHNQRzE2ZXV2Q0VzVnRISkxleXUzYmNZL1l1?=
 =?utf-7?B?ekpOVy82RklhaFoyTTVSczNqZWVSUkZJWXNQVGRkZU8wWXJLYnpPckJXeXcy?=
 =?utf-7?B?TTQxSEt6am9RaTRPYWNFcmh5c2U3ME5ma1hrZ3MxQ3AyZEUxUFNKMDk4ODNF?=
 =?utf-7?B?RWNEZWMwOHo2b0xGM0lqTWNMclY3QXVaZSstd2RQcXh4MmtsWVR3cks0Ky1M?=
 =?utf-7?B?dFVGb211d1FGY0ErLTFCSzZQVHQzZWxXbndvUE84amwwZ2M2TDlwZkJlZlpr?=
 =?utf-7?B?dWFDaDgwY0J0S0hwWk9ic2NtdkR1TEoxMXFwUFRKRjRlQWRsMEk1dGIyc25E?=
 =?utf-7?B?MnRyTVU0SE9JNXVpQWVveHZmSmo4aTZYMkI1VXRLeWFGUThvRnBMSGIrLU1L?=
 =?utf-7?B?SGJ5S0UyVUd0MzVwcno1aFBod0FCeE1kSEFmT0RPRFlaMXBCeGZYQystUmFu?=
 =?utf-7?B?T2d2UEJXWEtZd0M5cjFFZWNHb0cwd0hnZ05oQysteUhCTXlQRWZrQjRGV0tC?=
 =?utf-7?B?b0JBQnc3bVVZaUVsRTROa2dLRVZTQ3hURlJSSEJuL3BNdGJzY2w5dm5iUVhU?=
 =?utf-7?B?Rk0rLTVGMFk3czVHeFZRS2hsaEdraXk3Um85MllEamwvbmdrYmFuNm9iMGlF?=
 =?utf-7?B?MXpjU3J2b29xVW5oVWRCTExjbDVWVCsta0xVQzVZcVovTU01QThQQXpYRTA=?=
 =?utf-7?B?eCstMHVuR3JSZEdJYjZjTWdPVDZWYmRYMGlQOE9QV3VmbXlWVUJ4Q3F6YUlY?=
 =?utf-7?B?c1FKYVVPNmxxYk54Q3FXMGhRQ3F6NDVLclhNd3pEZ25mRFh5MWpHdXVDWTlC?=
 =?utf-7?B?M0NhcystRkRTQXVNWXRhZnQ4d1JIYlVHSHpacVUvKy1tczVZNi8vQnFPdnlY?=
 =?utf-7?B?eEUrLXBhbFRsTHZj?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IJPQKre87sayos6TokIUu1jclk075Ulbxb7xEGt/IZc62KkdhRw3zRraMS/Ccvet1rOrE7xVxYFH6Njtik4hvb3BMWwWCbF0pbqfMZKedCLaCJPyJT4G5qsGfsbYPPfPvM52NxHEm0RxyVQsUI4BuOcWjA7nL07WhYdn2frGwhfKrn7Atg8+gDMpeoumXGGIhoVWJoqFQuWTY8OllJ3ZgZtYkTK7zrDrpqEiLiQZ/2m25zVvrU3hZUmJVLileoDJv1GP9vWrhirlOfTlV2p2i2RYAaCeX4R31hvsuGoHc1Ia9BOl1uAfhQxCss5RdAXLE2bagXNZhUPVOWSw4dQQ+SmfPxrUFERw9XTxJe1RXDTXK/hNTwQJdaNAs57nXP2Q1frBi9OwgCoScd6I+PzL7gI3+Yw9YS3FoQYBgJj52wi4jkTpCvtaeqAViJPHNcnbmXD1Kkaqn0wb8apl33DNswCngQGHiuxPxKgjjbkQBKxSQpdP7KBw7z3R9Qk1AFP4cMJNo1f+CukBNVH3qtHeo1lxJHTKnmY3DaBXwg1Yqwc66bv5kb0lnqxUIEGzuDSvBNpKUVmDVaUdpzB7YNoA3Y9UaIV6uyjawxP2qJohcBgLj5R8+nSRgIN4OyB9VtBC
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR20MB4250.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ec2cb0-51c1-43e5-a11c-08dd13dfaa4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 21:15:51.1660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r7kQNMf9+Pr2K78sD62S4BEYjVj9NMimcjGzpkWZSwD7dCCa++FOuDimkJHziRoLXmevgDxth0G9L/yqPCL8FITamOYTIHr/8dnS4Pk+vOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB6333

Hi Jonathan,

I'm trying to emulate our memory appliance which is similar to a MH-SLD. Th=
e memory device is connected to the host server while the size of the memor=
y could be changed by the out-of-band fabric manager. If there is no memory=
 assigned to the host, the CXL device will be booted as zero memory size.
Recently we got some interest on trying our fabric manager software without=
 having the real hardware. Supporting zero memory size in QEMU will be need=
ed in this scenario.
Some detail about our memory appliance could be found from our OCP presenta=
tion: https://drive.google.com/file/d/1i8kBsBfRGjNqnTQqJ9upC-Xm9o56Y2Y5/vie=
w?usp+AD0-drive+AF8-link

Thanks,
Hongjian Fan


Seagate Internal
+AF8AXwBfAF8AXwBfAF8AXwBfAF8AXwBfAF8AXwBfAF8AXwBfAF8AXwBfAF8AXwBfAF8AXwBfAF=
8AXwBfAF8AXwBfAF8AXwBfAF8AXwBfAF8-
From: Jonathan Cameron +ADw-Jonathan.Cameron+AEA-huawei.com+AD4-
Sent: Tuesday, December 3, 2024 11:23 AM
To: Hongjian Fan +ADw-hongjian.fan+AEA-seagate.com+AD4-
Cc: qemu-devel+AEA-nongnu.org +ADw-qemu-devel+AEA-nongnu.org+AD4AOw- linux-=
cxl+AEA-vger.kernel.org +ADw-linux-cxl+AEA-vger.kernel.org+AD4AOw- fan.ni+A=
EA-samsung.com +ADw-fan.ni+AEA-samsung.com+AD4-
Subject: Re: +AFs-PATCH+AF0- hw/mem: support zero memory size CXL device


This message has originated from an External Source. Please use proper judg=
ment and caution when opening attachments, clicking links, or responding to=
 this email.


On Mon,  2 Dec 2024 17:03:11 -0600
Hongjian Fan +ADw-hongjian.fan+AEA-seagate.com+AD4- wrote:

+AD4- According to CXL 3.1 specification, 8.1.3.8 DVSEC CXL Range Registers=
 +ACI-A CXL.mem-capable device is permitted to report zero memory size.+ACI=
-
+AD4- This patch will allow a CXL type3 device to be initialized with zero =
memory size, when there is no memory device property provided ( neither vol=
atile, persistent, nor dynamic region).
Wrap at less than 75 chars.

I'm curious.  Why do you want to emulate such a device?

There are many things the CXL spec allows that we don't emulate.
I'd normally count this as just another one of those.

Jonathan


+AD4-
+AD4- Signed-off-by: Hongjian Fan +ADw-hongjian.fan+AEA-seagate.com+AD4-
+AD4- ---
+AD4-  hw/mem/cxl+AF8-type3.c +AHw- 14 +-+-+-+-+-+-+-+-+-+-+----
+AD4-  1 file changed, 11 insertions(+-), 3 deletions(-)
+AD4-
+AD4- diff --git a/hw/mem/cxl+AF8-type3.c b/hw/mem/cxl+AF8-type3.c
+AD4- index 5cf754b38f..35caa186ca 100644
+AD4- --- a/hw/mem/cxl+AF8-type3.c
+AD4- +-+-+- b/hw/mem/cxl+AF8-type3.c
+AD4- +AEAAQA- -159,7 +-159,12 +AEAAQA- static int ct3+AF8-build+AF8-cdat+A=
F8-table(CDATSubHeader +ACoAKgAq-cdat+AF8-table, void +ACo-priv)
+AD4-      int len +AD0- 0+ADs-
+AD4-
+AD4-      if (+ACE-ct3d-+AD4-hostpmem +ACYAJg- +ACE-ct3d-+AD4-hostvmem +AC=
YAJg- +ACE-ct3d-+AD4-dc.num+AF8-regions) +AHs-
+AD4- -        return 0+ADs-
+AD4- +-        // zero memory size device. Build one entry with size 0

Comment syntax /+ACo- +ACo-/

+AD4- +-        table +AD0- g+AF8-malloc0(CT3+AF8-CDAT+AF8-NUM+AF8-ENTRIES =
+ACo- sizeof(+ACo-table))+ADs-
+AD4- +-        ct3+AF8-build+AF8-cdat+AF8-entries+AF8-for+AF8-mr(+ACY-(tab=
le+AFs-0+AF0-), dsmad+AF8-handle+-+-,
+AD4- +-                                0, false, false, 0)+ADs-
+AD4- +-        +ACo-cdat+AF8-table +AD0- g+AF8-steal+AF8-pointer(+ACY-tabl=
e)+ADs-
+AD4- +-        return CT3+AF8-CDAT+AF8-NUM+AF8-ENTRIES+ADs-
+AD4-      +AH0-
+AD4-
+AD4-      if (ct3d-+AD4-hostvmem) +AHs-
+AD4- +AEAAQA- -712,8 +-717,11 +AEAAQA- static bool cxl+AF8-setup+AF8-memor=
y(CXLType3Dev +ACo-ct3d, Error +ACoAKg-errp)
+AD4-
+AD4-      if (+ACE-ct3d-+AD4-hostmem +ACYAJg- +ACE-ct3d-+AD4-hostvmem +ACY=
AJg- +ACE-ct3d-+AD4-hostpmem
+AD4-          +ACYAJg- +ACE-ct3d-+AD4-dc.num+AF8-regions) +AHs-
+AD4- -        error+AF8-setg(errp, +ACI-at least one memdev property must =
be set+ACI-)+ADs-
+AD4- -        return false+ADs-
+AD4- +-        // no memdev property provided. Default to zero memory size=
 device
+AD4- +-        ct3d-+AD4-cxl+AF8-dstate.pmem+AF8-size +AD0- 0+ADs-
+AD4- +-        ct3d-+AD4-cxl+AF8-dstate.vmem+AF8-size +AD0- 0+ADs-
+AD4- +-        ct3d-+AD4-cxl+AF8-dstate.static+AF8-mem+AF8-size +AD0- 0+AD=
s-
+AD4- +-        return true+ADs-
+AD4-      +AH0- else if (ct3d-+AD4-hostmem +ACYAJg- ct3d-+AD4-hostpmem) +A=
Hs-
+AD4-          error+AF8-setg(errp, +ACIAWw-memdev+AF0- cannot be used with=
 new +ACI-
+AD4-                           +ACIAWw-persistent-memdev+AF0- property+ACI=
-)+ADs-
