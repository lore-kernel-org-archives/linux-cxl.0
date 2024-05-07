Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3B6374F9;
	Tue,  7 May 2024 02:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715049838; cv=fail; b=LlDqGy2/KtvOzTXaiC79sghzdyjvLCpEschg5fwr/2u0ZfO49tKsGeJWjICq50BWz96asRPVb4KKqEYC8K1C4rHthvCoQtcW/4OBsct5jiW086F4wA7pJY1kHzt5fdvEADUJN2tsrBIMMMUePtEpEQxbfuz1Ovsimb7mSADqoyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715049838; c=relaxed/simple;
	bh=wXed7nQqs7KVnGd/MMB/M2H/6hKCh/sPd44+9hyjj+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BKZzwsz4vgr2Q2T6hEXlVMTxWQMUbJ/ORks6yDIlLFMsRS9nd1e0ePRCha9/aRWVo629MS35a/BVYQaR94Bt2C2gAcqmDyUTsSKrq/m4a0ma64btaDHDo0pG0kf+F9foxH/qXgJVHlUJTnMuD/hHg1J5+WF2FsVdUEcdap0ddJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Kevi1cnW; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Kevi1cnW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1715049835; x=1746585835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wXed7nQqs7KVnGd/MMB/M2H/6hKCh/sPd44+9hyjj+s=;
  b=Kevi1cnWHHzv60yHj+v1/NzkTK+Mi3olv9bBeX6FIzOkI97huKDLeKjh
   RrweiX00pLwZl9Hq5wPp6YvW5zlv3Hkkj+BlUDuk5DL4K2gxxHYMauKmU
   hGMrAVNnjE8nbjOoiNRyIfgR1ly45MLFyEvU79XQZbobH4bsIzaHqu2vx
   Vc76swJRZyXAeeOaOQ+dn7GfA+A80Gu8+NNXR3SserPXvdki9aK9yTgZw
   A3oPvxXCOJT3HLlTqudiy+HLELd7RbTr9ox9/XWZqiRty8/uDGc5vD87L
   2Zq80WrkiinIPRROtt6PFZqBg8lwvTiOQt+rXdT3um8CfJfom7If1TBF4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="118212901"
X-IronPort-AV: E=Sophos;i="6.07,260,1708354800"; 
   d="scan'208";a="118212901"
Received: from mail-japanwestazlp17011006.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.6])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 11:42:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNyy3a07onXzdPr9FsAUMguwXo0a4vS8Zm4cga9J4dA/RIjcAEY+KyI8mPrYFJQzvHBZiuwo93QWZ5VYBRAV0C+dcdeRWz/xqwMSYj62gBp2fhCoQPb/sihOoQicgh5r3JZMkGFnu7iJrqhSUsWmmIjQl8LuAf4RZbO4poIU6sjvB2w2P5HBhgqleniBd8/169E7pYbH6sc5ZeMFUoGdRDBNR3q1goiQWgy8jl06fT1N8gYPNX7ZiLrXe/7hJlM41CFCf19VKEtrC1xfQFlNGT7ZX8+p4rL6e9Fqns9c9mgLyux9tDWeq56kAxF9kazPteuB11Cs4t59GGHZ3atjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXed7nQqs7KVnGd/MMB/M2H/6hKCh/sPd44+9hyjj+s=;
 b=JRVPN6tWGuhga5cdb86uqB2U2KkX2RJ+Sj/UJtdSXhW1q5Cy5N9cOtmKfVygWncUPeSp087GSjIxGu4q2XiHXbAE/fwFOiTsBoLzkEn4XNQM4pgO4OL+CLZCCzOgVc7KbsWzVc6uOJGAGGNuU2OckFbe8hr09fjHC7c56saOZ06XtoM69Vip7olEGtt/mgIegWAKu/XgOyOah97VeQ2quWFS82/iy5nco5rx96cfSfRMrC2fZzkHwb8vDKKdjRXgAFLJc4+7o6ypWt2UXFQBKq3tiWrmNtKL/+LumlpIF2PyZRW1DgOyBoy89qIOb7R8EMsDHAUaZ68daWZ/U3SYEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS3PR01MB6343.jpnprd01.prod.outlook.com (2603:1096:604:e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 02:42:37 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 02:42:37 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Ira Weiny <ira.weiny@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Fix memregion leaks in devm_cxl_add_region()
Thread-Topic: [PATCH] cxl/region: Fix memregion leaks in devm_cxl_add_region()
Thread-Index: AQHamS4n5BtE91wtKEWLB7nzvazXtbF/cKWAgAutGwA=
Date: Tue, 7 May 2024 02:42:37 +0000
Message-ID: <0782e741-5478-4b62-866e-f966ab5cad91@fujitsu.com>
References: <20240428053715.327444-1-lizhijian@fujitsu.com>
 <662fc9659f6ab_19ca3929435@iweiny-mobl.notmuch>
In-Reply-To: <662fc9659f6ab_19ca3929435@iweiny-mobl.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS3PR01MB6343:EE_
x-ms-office365-filtering-correlation-id: 3270cd85-5a1f-4226-624f-08dc6e3f5b5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|1800799015|376005|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?eWpLV09Ic1MzaGZpR0plTldUNHBYN016MWcvSGNLNmV5L1FINTlnNkYxNE5y?=
 =?utf-8?B?WVI3bEJqNS9HWGQ4Mnh0WkdKZFpwa09xNFYxVjFCdU5CNmxKRGFMdDRUU0xR?=
 =?utf-8?B?bmtrZEFFOUx2aWFqbENNUVJXdTlxaVVjSmViYUJyb2p2TnAvbjV6dDRFeDly?=
 =?utf-8?B?VkowU0E4VVVwSHdjc0NuZU4vUlBLMXBjL0hvSWtLUW5LbCtCQUxPRG1MbFJm?=
 =?utf-8?B?MnlGQzA3S3N4VlVwWkRSd3ZldktMNE5ic29KMnBocGlON3VsSyt2Z2tNMXJV?=
 =?utf-8?B?c0UwZTNpcTZNa1dsMHNSN296VGFMejFTS2oyNUhpci9qbUdxTWlOZ3FTRWY1?=
 =?utf-8?B?Mzl6QXhDY01WL1lEcGNHT3N1dFNJQUVBcjRSeUpMKzFUN3JHZ1pyZjVsVjlY?=
 =?utf-8?B?T0xmdExQbXdEM0tUemgvekRDRXd4eTdqbHREUmYvTEZST3U0U3hCVldmZEdK?=
 =?utf-8?B?TDZOM3BGdFRzeU9leFZmdlhGckg5SWo4VnUrMHpqL20wbWs0Zi9meGxaOVJI?=
 =?utf-8?B?em9KdUw2M3VCZ042cWZ5N0d5SExuU0NUeHp0Z0dLbDI2eWdpdWdHZWxabUJa?=
 =?utf-8?B?QytHWkwwa1JTN1JKZXpqSy9QSVIrT0xxTVgwRzRaeDdBUzdORGpPRlA1cWkv?=
 =?utf-8?B?eU9HcW5OSVZueFFQRXZsMEJtZzAwRklpNWxVVmRkUTVGRHJZVVpBKzJ2UWZ2?=
 =?utf-8?B?U3BmN0pXZlZIVFlRbVdPNTU3YjRYeUhhM0o1MWEzRlVSNXp2d21aNnRuRGJE?=
 =?utf-8?B?bTdQYVVYVnJyNEdUZUVacGRKbWUweTdKZGNCbUNmSjRRTHFsY0Z4R1lsY05m?=
 =?utf-8?B?UGZ0Z21kR2FRd29ORHp6cDg2VlJ1cjcrNDRwbWxOQmMvSnFzdEwrTS9BYTlF?=
 =?utf-8?B?UFE5WS9tUzJYLzhnL2pTWDZiTVhHMFZ2eTZMZU9ETjFEMDVjVTJOOEZkRzhN?=
 =?utf-8?B?SGR4WWYyN3pvUW44TGxwUHdEeVhxYTRQblVMTG1XT3V3RThQaklVQ3JLT3pG?=
 =?utf-8?B?ZUQvUHl0NThhTGsyYUI5RDBPU2ZCWmVwUWIzbVZwWmlRZEVDTlJlWW5vZjRS?=
 =?utf-8?B?MGw0STd5M2hCbkdQTzBIZDV4UC9NM0ZkWjZHbGVMRW1DRXgydERiWXQ5aTNF?=
 =?utf-8?B?QXJITktOQ0g5c1YxdExJUXFYN3lmRk1YTnlGaVhZUUlya2dwTW1ZYllXaU11?=
 =?utf-8?B?S1dBWWphMHcvMmpUT0JnWTZKTXpnVjk3bk5FcG14UExFLzIwUkxDbE9HdzZM?=
 =?utf-8?B?ZFhjQWdZZE11VWZvUjNCVWxwcTBxUmdzcDJXOEoyazJ2SUZFREU4VkgxblJR?=
 =?utf-8?B?Y1krc3c5aFRubXZBckRuWWZkLzRuSGVXYk9ZS0NHZmtvTHJXU1VFTlFEeWRo?=
 =?utf-8?B?dUJZSHljMG5FQ3lrdWRDaXhscWJwRy8ra2wydlAzUjdwWFU4YXBBTmx6dHU3?=
 =?utf-8?B?cXRCdXBWbnpjMi9OUHFvOUVEaWJmdHZTTkRxMytsSHJkQWJ6RlpKUlNjS3Fx?=
 =?utf-8?B?M0xUeVFkSDdnVElRd3lpL0FoQXVrL0NITXJYdkdJMFpuMzdDQkVkWm5UYW9J?=
 =?utf-8?B?WW9uc3hkOXRKRm94NXJ2aGd5Z1BOdGVYRmc3Rjk5QVpCWXpnRmJJRmhVK1d5?=
 =?utf-8?B?cHJoR2pRMTQzZ3VSYkVKcHBxR1o0Q0ZxSGJyRjEveVkwdklNZHpHc2VxZnla?=
 =?utf-8?B?dW5jSkplTW5wZzcwSTB4enYrcXlTUlN0bkRNWVdLcnBYdkllMHJ6WnppdVRy?=
 =?utf-8?B?LzRuRU5JU21lNmtoTi9TYndtMkV2Sjhvcm91WmhmREFxSkZKVHhOK0Y5VFBi?=
 =?utf-8?Q?KEvd/bFPjXiFlyr9x3JSecdgQOg3r6/g9E73M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a2k0eDNqUVFjeDJnQ2pBSjBoOGIvWWpQaU81eW9ucWxrSU5IZG8wZUdGQTJq?=
 =?utf-8?B?UEsxQjg1QTdvbVQxQTF2ZUdmSmt3ZWdjWGFNaUtacnBjT2hBc0xPSXhRdDFD?=
 =?utf-8?B?R1J0Um9rNEp1bkNlYlE0eXFlOEsvU0dOL1E0cU9jZVN4NWJtN3lqbVl0MTlL?=
 =?utf-8?B?amtaSVNpNTl4aVlFcGtpNTF0U3ZmSGMyN0ZydGpLVzVRL1ZvdmNhWTZBd0kr?=
 =?utf-8?B?b3hQYUZnSm0zYjRyZG81NlZtZE9pSmZwMERrMEdzL0F6Um8wM3kzanJ0MURE?=
 =?utf-8?B?RjRFOWZ6VUpxUmo4Q0RUMytaRlp5cmdhWDdBMy8wRWUzWDdhdlNUMmtoYVkr?=
 =?utf-8?B?L01YSnVOclY4bkhBN1NBa2piUEgxVDZiUXVxaXhOR3cxMXVJb0dCTkIrbUx2?=
 =?utf-8?B?RlR3dGRzRnFXR0hVV2ZpMWxzc0o3U3dqMkE5T1p3RkN3TlBWMkVrN1dlRCtq?=
 =?utf-8?B?S0RaNDZVVlk4UzNLZzVIK2ltTmJrM3RRRzNTd1BUQWN3WjdnanUyRzhUZFZy?=
 =?utf-8?B?U2VlN05SMFhYQzl2OFNzeTMrbGh4TUQ3cE15dE41OWw3ajloOEJvTEx3MDhP?=
 =?utf-8?B?RDI2c2FCUUdMQTl2QUdyanFBOTNHV0VGbE5kTTFFcnlnYjRqNEgvWE1ueGlZ?=
 =?utf-8?B?V0UvanQrejhWUlV5ZEhlS0ZzMElzbTA0Qm1OdXF4VEpzOW94aGtHNzNENkNn?=
 =?utf-8?B?dTVSZ1luN1BFYlRBUXZVc3BIYS9yVFhFTnBieElKYm81WTRxQ3dQdUFZMWIw?=
 =?utf-8?B?cCtmR2JyZTdhMUdRa0IyN0FoN2dGVkxnQW94ZlhybXJWaEF0YTRyM29pek5K?=
 =?utf-8?B?SWRFSnM5QzI3N0hORFIvVjM4ZmxMUnRYb21janZIT1ZGTXJyTHdlWWZKbE1U?=
 =?utf-8?B?QWgzQW5MTW9aK0Mxc1Y5MEdyRUlBZVdXTStYSXdQMkFHTUFVdjI3b085K2I2?=
 =?utf-8?B?NWIxeWp1bjJaT2hVRUc4eDRjMVM3V3J5WXFkNnVmdjMySUlLRGZFSWIwa1Z2?=
 =?utf-8?B?azZBdm1PcjBqMlNiblJGMWRpRjZUczV1aENaSDFEWG05NGc0ODlxNzQwTUk3?=
 =?utf-8?B?dTFVMFpnbzFvd0docUx2cWJ3RVhLMEpDNW15bWxZdDZEaFpiQjQ5SFVtRzBv?=
 =?utf-8?B?NHVQY3VVTmkxVUgrQ1pOY0wzSktNdkhrbkxkeVhPeDZsZ2h4cFBKZm50bThk?=
 =?utf-8?B?eW13eVhxQi9JT2pFU1hEUWZ2ZHgxS3k2M1VRcnp2TENzM1B0YXB6S2JUeWpw?=
 =?utf-8?B?c2F6VFMrMTNJMmYvOXRUcUVhKzd5QU9SRUdDZERqNFgrNnZXWCtUalhSQ0xG?=
 =?utf-8?B?T3VUSTRaemt3ZCtOS0d1OWhRdm5ZeVcrYlJnbmVPT3ozUHlTQ21GTFdPNVhD?=
 =?utf-8?B?MVh6Vy83bThpNnVwT2pZcFpnMGtBaG81a1AxMjFic2NNK1FFU0lzU2FOdGR4?=
 =?utf-8?B?YUxJWU96YUM3ZXNUOU5DSzhZekZTRFk2ZnFDRnNMYTlxWjBzQlNobWVHT1Nw?=
 =?utf-8?B?Z2NKTkxFV0hNSERDeVBWVUZOeGVmVzJaVzZYTkxXU3JWb3RHaU5vTDlTSU9N?=
 =?utf-8?B?WFp5QXZPZGFTbWw0OHY3Z2N0aFZnMjMzalcyQkpqTmJLVTBVbTlLeU9HNlk5?=
 =?utf-8?B?SzdNMmthRG5LaEVqT09yd28xUkVBMUJOVWYrSFlKc0pkbm5lYUhXMm5ZZnJl?=
 =?utf-8?B?SmJiMXV4cW92eGRpWXR3SE1YTllDdFhDOUgzeUtpVlB0VGV5SnFHdkY1MXpi?=
 =?utf-8?B?YVUwcldaOW81S0k1ajJIQW5WS05kQzJiSm4wODFGdHMvNkQvbnZnRGNqM3k0?=
 =?utf-8?B?Tk5PN3FXZXpPL0NpNFRWa2E5bEIxOS9UMDZIb3VVODIxMG52UkR5Y3FCQ2lh?=
 =?utf-8?B?K0VsOFJFeHBremNtQTl4QzFFbWd0TGsxYW1QNU5aNWF1RlVlY3kwRU8wUzdu?=
 =?utf-8?B?b1FRNVlCZXU3dVJNWGQ1QzVDYVhjZHdTRmFpTDdJYTIxdUE2WlZCK3IwUVpH?=
 =?utf-8?B?OVdCT2tDVitWUS9uQlE3QUhjVkxRdUJNZGh1VHBlQ1dwQzdBTUloVkRUMm5o?=
 =?utf-8?B?WHdqWElnb3FrYzdRKy9HQlZpbVp0VVFpQTNTKzhER2dHN244NlByUFVUdFVj?=
 =?utf-8?B?OUdVVkM2TlZjaTFDL2MraGNJa0RMUS9LSXN0R1A2d21FSUhHNWExaE8yM2pl?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <202AEC6F2A0D244FBE201E669C140DB7@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w/XCRuuhFqR6g6ggPGE/cI8shiag7n9WxB3USUduSD2KcXentVERnyQh0i/U+nQpwtfT4NNJy+HR8kOFVFUMiUEcwsowAuslIa9BfCQvTb2+8AcmEL338LBx5BQtKbV9wOrSTGbArmkf4UHb/AV25yKO9/qKQuiR3YRVF6/LqRYgOY/R321cOwPhOqoZsJhtJgYPOu+ISaZuUwtaEidEkxS+7pvCr/BvVy7pGtlygML8U/pR7M2vycfyIsaSXtAlxtxBIWNvejaolLbuZ/Wei6yIA1K978///8+UQalOSgbfFUQ0WBN1giWSFWhgZKP2ps9bG82hhnXgRLeotD3yC70K45ln3V5K+GlRsUWFH2CaapHV9JhXTpdaS4YWl9c5XVmSBDEO9cuMLSiW9B2zos4bBqjObmhNZSkOHjMdOSnMmKF127aS7ti10O9vOkipc8doM039zC9tAocKFGFnGNIoM89xNkuv//8o7/lBmb01QP3DUy25DbBeEMNtALmkFrfcflu6z6cPKWsylCv0CQSauInNc2g0EYe6nKN+2KvonqkhbjJC8m/MLiEBUU69NbdX8XzmXQQBaFNzlleQLuM1FI8eYYittCR2k6xkIXdFFq54i6XRz7XPhuDOD7pp
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3270cd85-5a1f-4226-624f-08dc6e3f5b5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 02:42:37.3895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJduJh3z7pAdzyK85cXUQzv/AySrluF0qb9i/jN68VTBvRgC9qS2/CxL083Wc2GUqD3ubaEQRa4WCrDb+PgEMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6343

DQoNCk9uIDMwLzA0LzIwMjQgMDA6MjMsIElyYSBXZWlueSB3cm90ZToNCj4gTGkgWmhpamlhbiB3
cm90ZToNCj4+IE1vdmUgbWVtcmVnaW9uX2ZyZWUoaWQpIG91dCBvZiBjeGxfcmVnaW9uX2FsbG9j
KCkgYW5kDQo+PiBleHBsaWNhdGVseSBmcmVlIG1lbXJlZ2lvbiBpbiBkZXZtX2N4bF9hZGRfcmVn
aW9uKCkgZXJyb3IgcGF0aC4NCj4gICAgXl5eXg0KPiAgICBleHBsaWNpdGx5DQo+IA0KPiBCVFcg
eW91IHNob3VsZCBydW4gY2hlY2twYXRjaC5wbCB3aGljaCB3aWxsIGNoZWNrIHNwZWxsaW5nLg0K
DQoNCkkgcmVtZW1iZXIgSSd2ZSBkb25lIHRoaXMgY2hlY2ssIGJ1dCBpdCBzZWVtcyB0aGUgaXQg
ZG9lc24ndCB3b3JrIGZvciBtZS4NCkRpZCBJIG1pc3Mgc29tZXRoaW5nPw0KDQokIC4vc2NyaXB0
cy9jaGVja3BhdGNoLnBsIDAwMDEtY3hsLXJlZ2lvbi1GaXgtbWVtcmVnaW9uLWxlYWtzLWluLWRl
dm1fY3hsX2FkZF9yZWdpby5wYXRjaA0KdG90YWw6IDAgZXJyb3JzLCAwIHdhcm5pbmdzLCAyMyBs
aW5lcyBjaGVja2VkDQoNCjAwMDEtY3hsLXJlZ2lvbi1GaXgtbWVtcmVnaW9uLWxlYWtzLWluLWRl
dm1fY3hsX2FkZF9yZWdpby5wYXRjaCBoYXMgbm8gb2J2aW91cyBzdHlsZSBwcm9ibGVtcyBhbmQg
aXMgcmVhZHkgZm9yIHN1Ym1pc3Npb24uDQoNCg0KDQo+IA0KPiBJJ20gbm90IGZvbGxvd2luZyB3
aGF0IHRoZSBwcm9ibGVtIGlzIHlvdSBhcmUgdHJ5aW5nIHRvIGZpeC4gIFRoaXMgc2VlbXMNCj4g
bGlrZSBpdCBqdXN0IG1vdmVzIHRoZSBtZW1yZWdpb25fZnJlZSgpIGFyb3VuZCBhIGJpdCBidXQg
dGhlIGxvZ2ljIGlzIHRoZQ0KPiBzYW1lLg0KPiANCg0KU29ycnksIEkgdGhpbmsgbXkgY29tbWl0
IGxvZyBtYXkgYmUgbWlzbGVhZGluZy4gSW4gZmFjdCwgdGhpcyBwYXRjaCBtYWlubHkgZml4ZXMN
CnRoZSBtZW1yZWdpb24gbGVhayBpbiBkZXZtX2N4bF9hZGRfcmVnaW9uKCkgd2hlbiBpdCBnZXRz
IGFuIGludmFsaWQgbW9kZS4NCg0KPj4gICAJZGVmYXVsdDoNCj4+ICAgCQlkZXZfZXJyKCZjeGxy
ZC0+Y3hsc2QuY3hsZC5kZXYsICJ1bnN1cHBvcnRlZCBtb2RlICVkXG4iLCBtb2RlKTsNCj4+ICsJ
CW1lbXJlZ2lvbl9mcmVlKGlkKTsNCj4+ICAgCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCj4+
ICAgCX0NCg0KQWRkaXRpb25hbGx5LCB0byBtYWludGFpbiBjb25zaXN0ZW50IGVycm9yIGhhbmRs
aW5nLCBJIGFsc28gbW92ZWQgbWVtcmVnaW9uX2ZyZWUoaWQpIGZyb20NCmN4bF9yZWdpb25fYWxs
b2MoKSB0byBkZXZtX2N4bF9hZGRfcmVnaW9uKCkgc28gdGhhdCBkZXZtX2N4bF9hZGRfcmVnaW9u
KCkgY2FuDQpmcmVlIG1lbXJlZ2lvbiBleHBsaWNpdGx5IGluIGVycm9yIHBhdGguDQoNCg0KVGhh
bmtzDQpaaGlqaWFuDQoNCg0KPiBJcmENCj4gDQo+Pg0KPj4gQWZ0ZXIgY3hsX3JlZ2lvbl9hbGxv
YygpIHN1Y2NlZWQsIG1lbXJlZ2lvbiB3aWxsIGJlIGZyZWVkIGJ5DQo+PiBjeGxfcmVnaW9uX3R5
cGUucmVsZWFzZSgpDQo+Pg0KPj4gRml4ZXM6IDZlMDk5MjY0MTg1ZCAoImN4bC9yZWdpb246IEFk
ZCB2b2xhdGlsZSByZWdpb24gY3JlYXRpb24gc3VwcG9ydCIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBM
aSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9j
eGwvY29yZS9yZWdpb24uYyB8IDkgKysrKystLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Y3hsL2NvcmUvcmVnaW9uLmMgYi9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jDQo+PiBpbmRleCA4
MTJiMjk0OGI2YzYuLjg1MzU3MThhMjBmMCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvY3hsL2Nv
cmUvcmVnaW9uLmMNCj4+ICsrKyBiL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMNCj4+IEBAIC0y
MjUwLDEwICsyMjUwLDggQEAgc3RhdGljIHN0cnVjdCBjeGxfcmVnaW9uICpjeGxfcmVnaW9uX2Fs
bG9jKHN0cnVjdCBjeGxfcm9vdF9kZWNvZGVyICpjeGxyZCwgaW50IGkNCj4+ICAgCXN0cnVjdCBk
ZXZpY2UgKmRldjsNCj4+ICAgDQo+PiAgIAljeGxyID0ga3phbGxvYyhzaXplb2YoKmN4bHIpLCBH
RlBfS0VSTkVMKTsNCj4+IC0JaWYgKCFjeGxyKSB7DQo+PiAtCQltZW1yZWdpb25fZnJlZShpZCk7
DQo+PiArCWlmICghY3hscikNCj4+ICAgCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4+IC0J
fQ0KPj4gICANCj4+ICAgCWRldiA9ICZjeGxyLT5kZXY7DQo+PiAgIAlkZXZpY2VfaW5pdGlhbGl6
ZShkZXYpOw0KPj4gQEAgLTIzNTgsMTIgKzIzNTYsMTUgQEAgc3RhdGljIHN0cnVjdCBjeGxfcmVn
aW9uICpkZXZtX2N4bF9hZGRfcmVnaW9uKHN0cnVjdCBjeGxfcm9vdF9kZWNvZGVyICpjeGxyZCwN
Cj4+ICAgCQlicmVhazsNCj4+ICAgCWRlZmF1bHQ6DQo+PiAgIAkJZGV2X2VycigmY3hscmQtPmN4
bHNkLmN4bGQuZGV2LCAidW5zdXBwb3J0ZWQgbW9kZSAlZFxuIiwgbW9kZSk7DQo+PiArCQltZW1y
ZWdpb25fZnJlZShpZCk7DQo+PiAgIAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+PiAgIAl9
DQo+PiAgIA0KPj4gICAJY3hsciA9IGN4bF9yZWdpb25fYWxsb2MoY3hscmQsIGlkKTsNCj4+IC0J
aWYgKElTX0VSUihjeGxyKSkNCj4+ICsJaWYgKElTX0VSUihjeGxyKSkgew0KPj4gKwkJbWVtcmVn
aW9uX2ZyZWUoaWQpOw0KPj4gICAJCXJldHVybiBjeGxyOw0KPj4gKwl9DQo+PiAgIAljeGxyLT5t
b2RlID0gbW9kZTsNCj4+ICAgCWN4bHItPnR5cGUgPSB0eXBlOw0KPj4gICANCj4+IC0tIA0KPj4g
Mi4yOS4yDQo+Pg0KPiANCj4gDQo+IA==
