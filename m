Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376EC8488
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jul 2024 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720407911; cv=fail; b=bvlkhnJMOVZg5APZzvByU7NrSBD4wvd7XJEc2WwKbNJJfBJ/eN8bLj3HiN0OBI3PL6HbmAOIosDyr4RGPGBx/IHPM9O3hFkGku3MDY6jOPuIuzz3IdJrt03w93gutSuc7bXauTzh1UfsrZgrNEq+BgOYpE38MC1mUdBCHqdFes4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720407911; c=relaxed/simple;
	bh=UMLEVW2ObSvtkaw1aD5IltcOQAptjwtEiLTjl658uLk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fZLiCNTAT67iWrG+W6ar0TWY55O+cymm0UPrUQrDPByOcHhreYpk0iBxPXCwzOe3HeGMKhii9DuLWuIwWh1XIgcmQXGo42Nq6D49ANO9bBaxTywUoGinFkU4NkJDo1rDm/yu13QLDfNgp77rjEGNB5O5Xoe4vxVs5JYpUarlYIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=MQV0uDxL; arc=fail smtp.client-ip=216.71.158.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="MQV0uDxL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1720407909; x=1751943909;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UMLEVW2ObSvtkaw1aD5IltcOQAptjwtEiLTjl658uLk=;
  b=MQV0uDxLDk7xGu8Fhi5m9a2XpyjhP3zgO2fAd+XPOifIdcchv7fD1xQZ
   E3Wuo1TlLwDNz3atd1jRd4ujYMXM/YZ3lHHTAg7fKuCfqRRbcIOaRkwQh
   e76FQmKxKTBuMTeYKbaNwpf9uln1R1l93HTqVSq0SfO60vg24ewnTg+lD
   2dirK4SgqTb6rRK4jiqC5DElq98gi1y0diyNQDVZ5YmQ2Ih83Y4X+pLRb
   cEhaXToUmgZ6CqOEgAPKzRHjJ4wY4ifknAxP/zodZHvgwPERqF9Zsgzxg
   jHdQ4v1AEinJqT5Ju3fW848Tl44HIzVptQ9lOuDrsuJQ6TlN1U/6fSfeK
   g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="129394462"
X-IronPort-AV: E=Sophos;i="6.09,191,1716217200"; 
   d="scan'208";a="129394462"
Received: from mail-japanwestazlp17010007.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.7])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 12:03:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGIbAAK8RAdEq0duys8odyqjXtuDdtZ/mtGTX8cQLg7k7LB1a+CIJ0HI7JIl0BzIIFo2DS7kYF3Y3Ma1cFzSRVVfiX6Af7BssVztKvCZEsGMXdZ45q3CJ6TmzUwhBOKe7KXOe/NdtLCU//ov8U2RWZyMzllvNjcfFWMIAIgH2v3ddCAL/sOPh67eBEB7MIzqI6Npsq7X6nZUNE8gYokq2QK8LhEzA9hy86y/lSleJ56upDjm75cN1Ply0eSPa+mkZ39z1SodRzCIMq24Mo6dAU0rVSYAWkSTiWI2zszXRfRysKz/jxllCrEDdb6ol2sMHc2CzSAxscAqqogL5OpGHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Kq+yQu13BUHNpAI7Ie7JJ6O/EJdo3F+4OT8M54LSf0=;
 b=C/G9IkybKI89laGg1ctGiTJlgQ64F71mpvGOQKXOX88gIUKhCo7O/3vQL1wCB+G2wrHkpdhtFXnp7HKAFR8njkyFC56vKIOebMKGD1fL2udj4GtctAWBbQ4PoQ/I2KSgNWandXzWItbU6irIpI/u6VGurkRVFMN+jkYRWwHA7OsLqhVgxEzljvl5Lim0SiIsaKgasopnsz77LNyvyHvX4ycKRnoG3pZMSVxx684peJEDFqWwa/qAVrowl6Ayzj/TYtMBj7t8QY7EaTwcgtH+qSvzoeRYSF4tWbRkLtKUpC+hpjym2any7AcCrom3c6Y/TZ3occw7Xg/gUn8Ocaukwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TYYPR01MB8133.jpnprd01.prod.outlook.com (2603:1096:400:115::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 03:03:53 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 03:03:53 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v13 0/2] Export cxl1.1 device link status register value
 to pci device sysfs.
Thread-Topic: [PATCH v13 0/2] Export cxl1.1 device link status register value
 to pci device sysfs.
Thread-Index: AQHawG+aGLCoZksU+UeLAeVxavfGfbHsQubAgAACiKA=
Date: Mon, 8 Jul 2024 03:03:52 +0000
Message-ID:
 <OSAPR01MB71825672E0A840CDDF218861BADA2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240617043702.62028-1-kobayashi.da-06@fujitsu.com>
 <OSAPR01MB7182B96D1C5314D09E418284BADA2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
In-Reply-To:
 <OSAPR01MB7182B96D1C5314D09E418284BADA2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=3109b8e0-3ba5-46aa-9888-d054d09b295c;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-07-08T02:52:41Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TYYPR01MB8133:EE_
x-ms-office365-filtering-correlation-id: 6034a326-3643-4b2e-6916-08dc9efa9944
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?c3FEaGd6Z0RmaktlcVZLK2dmQTVnUkV0aVZDVHo1NmhzMEFCZG1jMng5?=
 =?iso-2022-jp?B?aDZ3TitYMXJHbHpPYlU5b251bGgvN3E4Sm12RnhTVEY2OHNpeVR4eXN2?=
 =?iso-2022-jp?B?bmZYTFowZEQ4ZnNqblJkZDBNL0Q3cUhDTy9xWHNtT2NsR21OWDNrekdS?=
 =?iso-2022-jp?B?V1REYStKQTYrRVlIUkpMWnZqbkE2NWV0V1FjUEo2cFZWbVUxS0pvU3VM?=
 =?iso-2022-jp?B?RXlyRXRpcVBicDc1aDZKSTZWOTdHaDRBZWloRlFNYkEzVTZGYTlrNTVT?=
 =?iso-2022-jp?B?bFlRQWk2a1ltUG15Vk9jNzFEL09aSlZXTkVoOXVvUUt1VW85eE1nMlJM?=
 =?iso-2022-jp?B?c1B2WWFrMFIwS2tFNnN2YTY0a1BFb1M1U2FSYjhhZlg0bmxUd0tvNFow?=
 =?iso-2022-jp?B?bXlOK1BuL2hoSUJUYUhUNVAwZnhrbTE1MUkxS2tlenBxTS9SQkVDZ1hy?=
 =?iso-2022-jp?B?TUJFY2lZUXkrZGN4NGl4OWw0WXFBREZ1ZWYrR0t3NUZKZ0o0K0xva09w?=
 =?iso-2022-jp?B?OVF2NEJFOERGMCt1Mi9GVXNCNTNPK2NYdHg5TURoRkhSdGJWbEQ5d1J1?=
 =?iso-2022-jp?B?ODluckFWanEybldFMkJUeDdGeFBqYW1aajgvMUQ2VDhJMWUwOHFyQ3NE?=
 =?iso-2022-jp?B?eFdnM3lhL3BRdUt5STlzS3M4Rk04UlVSc2IzNlYwbndYTU44V1VrNGhY?=
 =?iso-2022-jp?B?RUo5Z1hJTjR2TFIxUXZyclZHK1MrRXRBdEh2TnRoVDdvWm1ucWZVRXZ4?=
 =?iso-2022-jp?B?alVobUdQTGtrU2NHZndnU0g5TVNBMGxPOTJrVGJJcFBORlUvRWN1K1Qz?=
 =?iso-2022-jp?B?WDd2K2ZaM3FGa0xFeHd6RC90dW9TSHB3SVR0VEUydTVlRU5yT1hMN2d5?=
 =?iso-2022-jp?B?T25IaEQvV2lmdjY5bFZsNUcyTVZlMlVaekJVZURISFdJUkpiREkzNTdB?=
 =?iso-2022-jp?B?bFg4dDBFcHVEQjhjL3FxeENNWkN3T1Fuajl2aVU1TndDdWZFN2VySDVm?=
 =?iso-2022-jp?B?YWMzVlVmaVZBRk92YWdQNmh1OXZaZ2wxeFkvSC9DODE4QWc1RHBPWmRD?=
 =?iso-2022-jp?B?cTc2N3NCTWZGYzRPTU1SbXhSUXZxWUxyaGZxejRERDZUYTgyNjJjR21l?=
 =?iso-2022-jp?B?b0hsWUtmRUtaUGdCdjlubUV2U2JCRzFXbUVFMFh5VlM5VHhyOEphOFZn?=
 =?iso-2022-jp?B?YlNjZkVpM1ppUUZoeVRxcFh1SEEvd0k3eXZ2TnpmNkRaenRJcGdVMWgy?=
 =?iso-2022-jp?B?a3RQUTh5V1dTaDZLbkhHMVFMd0ZhUlNWRlV3VEZza1ZuVFgyQWsxV3A0?=
 =?iso-2022-jp?B?VTZDekxkWndDWXdTUXk2V25RNitQTjBJUUFmTTZ5dVE4UUpBWVdnakpK?=
 =?iso-2022-jp?B?NUN3dnVWVjJOVFVLOWNHRmljZzk0M29IRzNpV3doZFlMWnVMVldIZnRE?=
 =?iso-2022-jp?B?MTd6czArTTF1cXQ2NU5QT25KaWE2Ukh6ZTFJdllxTWJBYjB3Q1NnVTNQ?=
 =?iso-2022-jp?B?NGZ0Wk8wYWsrZ3ZPaERJM09EaXZjR3VpUzhpdWE2K0s3UThWOUZUWTli?=
 =?iso-2022-jp?B?U3dheTF3VDJjTHM2bi9Tc2NSc0ZWdVVDMnozQ0hVRkRFNDc1bkYvUnJu?=
 =?iso-2022-jp?B?SExSVm8vMUJVRVUyOHE5cGxZMDJWUjJldk0yRWx1QWxzZ2FOSEpsK1dp?=
 =?iso-2022-jp?B?WVdDRk5NQm5MRW8rYUhGcVBqZFkydk01Z1hBNTc1a2xwS1BQZzFGNXN5?=
 =?iso-2022-jp?B?U2t2V1NlRmE2SVF1N2xPQkgzVjNnMkxqMGJkL1BjaVZtbnQ1c0tMQ3lJ?=
 =?iso-2022-jp?B?M3Y2NlNqSEpWckl1NTFyZ1phS2lySnR2ZVJhNW80U2t4TVc1dVlhYUx0?=
 =?iso-2022-jp?B?TUVXa1UxaXEwenBiZTJXdFQwNlE2S2RCY1h0Y01Tb0ZjcXBPUjgzMHNW?=
 =?iso-2022-jp?B?Vjk1a01rbXdoc21mMm5scDV1dGlXMWJCeWpPY1RGVXV3R3FOTFRjMEpG?=
 =?iso-2022-jp?B?WFFLZVdUQnM3NURlZUpNcStybnk1Ni9vdUhOVUVHSmlHZWdoKzUxN2FC?=
 =?iso-2022-jp?B?QW9oUFZpQzNUMkU4UkI1VG5Tei9hZk09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?UVNNNjlWMmZiQXFERzJGVU55SnpRMGhqRmxVU0FLc09BYlh0VU1SVGE3?=
 =?iso-2022-jp?B?djIxeGZ2a29TL0ltZXFndVlqaXpuYnRpc202VDA5TU44eC9CaENBa1Bl?=
 =?iso-2022-jp?B?V0ZhMDR1RnZRUHJZSjhUYUVrTS9rWnpSV0lydnZEQVo5M3pZNUFGRXM4?=
 =?iso-2022-jp?B?OHE3V2Z0eGdwUFFVQWovaUduenZ3dUd1WVB0NmtEZlliK0dvdGp5L0hV?=
 =?iso-2022-jp?B?UW9wa0NqbHMzVWVqU0xVYW1yWk5tU1NPREtQUmx0UGdBa3V4amFwYzQw?=
 =?iso-2022-jp?B?dytFMlNZNWdHMlQ3c3BjWTQwTnBwd0RPcDkwRVRrRGxWZDRLTlBsN3hv?=
 =?iso-2022-jp?B?azlRYm9TRFZNRFlqa3djUWpzRVpTblZ3Ym05Z004SkN2QTRNU0tDOFZj?=
 =?iso-2022-jp?B?YVdLcWtlNElYeVB2T1dzMDFOSUlxbVNuRVJ5UElDS0xrL0VlUTZYY3Rp?=
 =?iso-2022-jp?B?MUVyRWZ4RkprcDlhODRqT2c4bnRNL0Vnd1JMNldEZVFYSTQ4U0czQzhl?=
 =?iso-2022-jp?B?WEdZb2hsdm03VVFWOUVtOS9TQnBHSi9YelVSaVBIRm5DcUFvT050Rlp3?=
 =?iso-2022-jp?B?RlV2NkVPaS9XYnB3SGNrd1ljNE9rNnh2RVFxZmNxeFlUZHBpRHBDSjZw?=
 =?iso-2022-jp?B?RG54Y3NtUVgxSGJGZTNQK21mQUxNRWpyUlFWeWgyMTl5a2VuWnpLWGVR?=
 =?iso-2022-jp?B?OVFESDhIdmNsMTN2cmFiVGNsYS9PUlZ3VHJLWk8ydVQ0NHQvbnRPNFF0?=
 =?iso-2022-jp?B?TDlLQ21XczA2aGQxeTNPa0t4VXl0VU1FZGVzQTl0cHhMM2l6akVvcWJx?=
 =?iso-2022-jp?B?aFkybytVaHh2MWRmR3JBZHQ4aGxlOUtXdWpaSm5Ic2ZyQVFaWmM2VVli?=
 =?iso-2022-jp?B?NjR0aW1ITWx0NXFnaEdjU2NISUJKK25FMFFkQmdZTFU5d2d1ZU5rTnNO?=
 =?iso-2022-jp?B?aUZBR21YZlBNZExXc042d0x3NCsrMGNtVDJwUmw4KzRQSDVGeXJYa3gy?=
 =?iso-2022-jp?B?U3lzTTUycElMQWlLc0lxWTlYSm14UzNLU2V2dEpQWElndzRqOFRjR01Y?=
 =?iso-2022-jp?B?QjR4MW94Qm14VWFBak5ZUTZsUWcrQ21kTU02Vit5Y1lDSldUWDlBd2Yv?=
 =?iso-2022-jp?B?R1kvTW5mSGRzSWcwVXZqUElJclNJYXYxQTJMd3BkVzQ5eWhkVDFKNTJR?=
 =?iso-2022-jp?B?UUkzejV6WElVZUdxaHgvTDE0azNpMm13NURtditNRFIzcFhDT2pka1Q0?=
 =?iso-2022-jp?B?WkRkb2FmMi95M2gvMTZGZm5QN2hyd2xMVGIvOXFCQStrRjNvOHMxQ3ZS?=
 =?iso-2022-jp?B?bUFEQ3RMbmMwYmc4UVFXVTRLd3ljTkJxYnNPMWQ3ajN4ZURQTG9QUUVH?=
 =?iso-2022-jp?B?RjZwazgvV1o1U21XaHBlVEhNZ1ZzVlR3MmZ4WVN4cS9ZSTFvTU1RdE5o?=
 =?iso-2022-jp?B?SS9aakFWK1hpb3ZUZk5GbWptWGRKK1UyRk90NlBCWStlanNodFltR2VI?=
 =?iso-2022-jp?B?R1k1NGFRcEk3a3ZlRERNNklUVktRaWxhU0ZsdFhSMmVmaTE3SlhFWUh2?=
 =?iso-2022-jp?B?TTQ5MW5XVGZmWmVnU3EyYUZKZXJ2Z3o2UmpXd3MxUHYrRW5MTmltKzN0?=
 =?iso-2022-jp?B?VUdvVWFodUdMeGE5anB6YXRudEdEMlhtTEFnR2JtZ0l1dGkxeHhzZnlG?=
 =?iso-2022-jp?B?N1c2SGRlc0VCeEEzbGtxeVU3V2tzN1pMUmxaQ1hCZGZnbFBGelBCVTFa?=
 =?iso-2022-jp?B?d1k3QjF5NTh5b2k3cnBqOEJBRVc0cFRLZzBIb0h3NlNQTEdmVHZBT1Vw?=
 =?iso-2022-jp?B?S1lmMDhJa3ozQlR3aW5RUWdaSnpWc2VteW9yYWhxR3dkY3FVbndMSTJC?=
 =?iso-2022-jp?B?ZVUvcVgvcXNIeUorNmgyaWZSNHpzT0NWVkhsUG9MTHM5WStibElaVkV2?=
 =?iso-2022-jp?B?LzRNa2lCYlphVUdSazg4ZTU2TjhBd09yTEtpRThHR0lOY0tZdmx0WDdV?=
 =?iso-2022-jp?B?YTlINDA5anZENHFNV3lCem4xOEpIcEl0SUxXZUxYdDkwU29RSElJVlYy?=
 =?iso-2022-jp?B?M0EwSTFRNk5mUk8xTlJOdGc3YWF1VUowcUNvS3R2d1QxOGNkWDY4Vk5E?=
 =?iso-2022-jp?B?RUNTcU1uMWpVa2tBbnZ2dHBqeWU3SFBvclBzSTZFeGpzL01oSG1OTmNy?=
 =?iso-2022-jp?B?N1dwc0M1cTQ0SElYZGNKZFVIUnJyUXNpUHBFU203NkwwVlU5UFV0dGVM?=
 =?iso-2022-jp?B?emV4OUkyRW16NWwraE9tL0NCZldOU2Q3QWpEQjJVWGlrODVFWkN1MHJK?=
 =?iso-2022-jp?B?eDBUQStaQ1plK3A5MkZ5Nm8yRGdxOEtYdnc9PQ==?=
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
	UfgTC/SaCd+e7/Ife1iQErtJF/hCvk7BJO5uIj+0CI9Q0PoFn4UT7AMPhlijExeaPo6sJYnExgGdIgf9ru3306ll/6B4Ki4GtSSXj0FrbmLop3bNLHeTrvu5XMK5a3F8DfOmGKrG8PfNKPu6yo5WFAAslTLlv8+X55FdmjfR2CDa76lDHT3Dxm/x18fNSe65aykGpjQE5usWeRJ2agk6S8ktVNXcgUupJ1LnTaB7lBX9E87mVfDjNOfwyC2/t0g7RGzeUq9mojj4zcpOqCtky1OEtgMeq9pjZba00wlP3q+i7OvHKcTXbC5AFawECA7UNmNqCU+mAvaxNwRk/P3Z8PkGpGzarACTy94qwY9L8c6hALKu1vlDpOJLOWS3jpQjKrLlf3DsVgUW0MCQndBShEOP4I4Zu9d2bVzKwRRlZmBPrCi3edOQRscn8jlJdLlTU4op0pP2VC0zM/BaofhyncM+eP8x5/M0smFLNIJ5sM0xoVtTJNyoN0+NIS+LVKH+9n3c2lXmwuh+YvPb8bPtUYdE89J/nvjMoQ7i4CjBZZLEMrjD/+ggwH0zHfOw03IHuq2EE9pXiSXHQVi9S7BE2m8RMM5FPrAKbzFK2fhzR8hI6Qlj/2QBrPhQRIXU8oq+
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6034a326-3643-4b2e-6916-08dc9efa9944
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 03:03:52.9729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5nkeLtIPXNtgOIc82rzf6vOOH+wcCTJ+rDfBGP35cG/uyM1wsjT13VERlUm4SfXQ167FJz7/02Hx7T9ibYBLlRwojio3PmI8P9M8NFv+lTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8133

> Kobayashi Daisuke wrote:
> >
> > CXL devices are extensions of PCIe. Therefore, from CXL2.0 onwards,
> > the link status can be output in the same way as traditional PCIe.
> > However, unlike devices from CXL2.0 onwards, CXL1.1 requires a
> > different method to obtain the link status from traditional PCIe.
> > This is because the link status of the CXL1.1 device is not mapped in
> > the configuration space (as per cxl3.0 specification 8.1).
> > Instead, the configuration space containing the link status is mapped
> > to the memory mapped register region (as per cxl3.0 specification 8.2,
> > Table 8-18). Therefore, the current lspci has a problem where it does
> > not display the link status of the CXL1.1 device.
> > Solve these issues with sysfs attributes to export the status
> > registers hidden in the RCRB.
> >
> > The procedure is as follows:
> > First, obtain the RCRB address within the cxl driver, then access the
> > configuration space. Next, output the link status information from the
> > configuration space to sysfs. Ultimately, the expectation is that this
> > sysfs file will be consumed by PCI user tools to utilize link status
> > information.
> >
> >
> > Changes
> > v1[1] -> v2:
> > - Modified to perform rcrb access within the CXL driver.
> > - Added new attributes to the sysfs of the PCI device.
> > - Output the link status information to the sysfs of the PCI device.
> > - Retrieve information from sysfs as the source when displaying
> > information in lspci.
> >
> > v2[2] -> v3:
> > - Fix unnecessary initialization and wrong types (Bjohn).
> > - Create a helper function for getting a PCIe capability offset (Bjohn)=
.
> > - Move platform-specific implementation to the lib directory in
> > pciutils (Martin).
> >
> > v3[3] -> v4:
> > - RCRB register values are read once and cached.
> > - Added a new attribute to the sysfs of the PCI device.
> > - Separate lspci implementation from this patch.
> >
> > v4[4] -> v5:
> > - Use macros for bitwise operations
> > - Fix RCRB access to use cxl_memdev
> >
> > v5[5] -> v6:
> > - Add and use masks for RCRB register values
> >
> > v6[6] -> v7:
> > - Fix comments on white space inline
> >
> > v7[7] -> v8:
> > - Change the cache value to offset
> > - Access memory map area in rcd_*_show() functions
> >
> > v8[8] -> v9:
> > - Map the pcie cap in for all the time the driver is bound to the devic=
e.
> > - Add mapping the pcie cap in cxl_rcd_component_reg_phys().
> >
> > v9[9] -> v10:
> > - Change a utility function for getting PCIe capability.
> > - Fix tab alignment issue, error handling, and apply suggestions from
> Jonathan.
> >
> > v10[10] -> v11:
> > - Add functions to have one function do only one thing.
> > - Add a size parameter to utility function arguments and consolidated
> > them into one.
> >
> > v11[11] -> v12:
> > - Fix the error handling in cxl_pci_setup_regs().
> > - Fix and clean up some details.
> >
> > v12[12] -> v13:
> > - Fix and clean up some details.
> >
> >
> > Kobayashi,Daisuke (2):
> >   cxl/core/regs: Add rcd_pcie_cap initialization
> >   cxl/pci: Add sysfs attribute for CXL 1.1 device link status
> >
> >  drivers/cxl/core/core.h |  6 +++
> >  drivers/cxl/core/regs.c | 61 ++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h       |  9 +++++
> >  drivers/cxl/pci.c       | 89
> > ++++++++++++++++++++++++++++++++++++++++-
> >  4 files changed, 163 insertions(+), 2 deletions(-)
> >
> > --
> > 2.44.0
>=20
> Can you merge this patch into the next kernel?
> It has been reviewed and I believe it is ready to be merged.
> If it is already in process, please let me know as it is my fault for not=
 checking
> thoroughly.

I accidentally pinned an older version, I'm very sorry.
