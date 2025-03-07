Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4E9198E6D
	for <linux-cxl@vger.kernel.org>; Fri,  7 Mar 2025 05:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326995; cv=fail; b=nak1qdRLtZ6BROZRE2j0aY0wiLfwdDFyWT/e0vfrgVFPIGQ0de/yiOvoIyjfOFR46CAjjiM47HommdUAW0Zb7Io7pbwm0NeaqAsPHMDzUsDf4PLZCOhAVj3eOacKLsQjSOUJelLfjmKMXa/YTh23m1NyoGllOHLk54vk7AGWKog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326995; c=relaxed/simple;
	bh=zY2b8U7Bybzg/rbSMSuSoWFuxJk7NkoZiD5Fm5QUD7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a3ZT6Pz4Fxpvm61mbCAvy2f+GmeMSby3ELYHNlJcoEFh7dkOFWMtFQTE6R6pOW5fZVlA4PsuoOaBQuzi6+zXMfa92eoj6GgYePGPSx8BAYtaweGA1uXkrO7fSdkrxQyK+OaLVB5uPpVisa1ScIQVg0p9Yds16H/43gc7Yr02PCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=vkRb8cJB; arc=fail smtp.client-ip=68.232.159.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="vkRb8cJB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1741326993; x=1772862993;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zY2b8U7Bybzg/rbSMSuSoWFuxJk7NkoZiD5Fm5QUD7E=;
  b=vkRb8cJBIPSsXWisLm9RqRxp416gyuyxCwo48uOLsUsNHlHst7uceu1Y
   GoXzE088aJoHK2CHCTUiKKWt6+TuOilUx6xG85ptWwLzYhTkr/mAjYwvr
   8cdcwPm0vFbAeu24s8PSSvugcTzP06XNKtzX/LYJUlskFqw5edXNp3CGI
   jwYO3qD8xQI0MGfZLKpiLaViHiyCS89TuxtT0vejno2cXIcP6Ljr19v3G
   4kLa5FjoyXIrOAJDTIH7D8kBufJ+O/Zj5wg+eNyGKlWMXq4aVeEHRLK6B
   HMWN76NsThujWWfmUY7F+b4g6DALIYcNUz1KluVDgCTd3Q6+lBykiSCnG
   Q==;
X-CSE-ConnectionGUID: QOCj4c7EROONy4AfrVD5+Q==
X-CSE-MsgGUID: lscbCMmsQP+4n1Yz5vTBCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="149148042"
X-IronPort-AV: E=Sophos;i="6.14,228,1736780400"; 
   d="scan'208";a="149148042"
Received: from mail-japaneastazlp17011027.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.27])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:56:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rlm4wF/hWZVfcs85LnsJLES+5vdNcKn+cRsMpBS1CuLr2P2fLwoQ0kDvNA6u1HLhFdHUGGhDCOf+RrhFJf+1JwrypBYyaOV3qxQpECtS4KKs7MNUx/smITaM81lX4yqzvNIivwNa+T6bF5YiwGurUX88PlmOV38qCxoSQIoqaYF6vAQ3QWu3nuKuPsE8Xql0m/KzfhZwngdwPfo9PAZkdvzhVZWMuxy+Ip6iYYUkOrVln1IbGEqAv/qwmPiFe0Qcc5lwuWonVTJELFRurBxvpKj4TOTyYSFCWt2l86kdbOmFjHiDKqInYa7XFsP06tzK4WFrSFQFo3PJMKaMAYAOOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zY2b8U7Bybzg/rbSMSuSoWFuxJk7NkoZiD5Fm5QUD7E=;
 b=Xyyif2jgRZ/2RJixEI3CbemHOHDA3WBeCiVAygBN9A2+G8iOjYKBkN4xRwhOhy+Umrzl454RAignShcf2Ioj3wGTn9L0ek477YOIMuIjj7Swy7yQGvDkQk7fFwXXdMqQd7nro2sasahWWiKmy6qe3ZYHLO+65skBIo3t0T0k1Yl6P6STpWYcwq6HyHO94rthSrXIQ6RlxZ6au9JQICxMOzqRFE84OByFAeeYAelQgtkV8aZMYK/J/8c1lVSBZtxQw+OsgdAFJNnLwoFRe0uObDn2Tn89Jns4aN8+yILGHv0CDUNTJ/25s/Navck1crQwFnuds4fFo+/pYOFewGImAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYCPR01MB6836.jpnprd01.prod.outlook.com (2603:1096:400:b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 05:56:26 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 05:56:25 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "Fontenot, Nathan" <nafonten@amd.com>, David Hildenbrand
	<david@redhat.com>, Fan Ni <nifan.cxl@gmail.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "gourry@gourry.net"
	<gourry@gourry.net>
Subject: Re: [PATCH v2 1/4] kernel/resource: Introduce managed SOFT RESERVED
 resources
Thread-Topic: [PATCH v2 1/4] kernel/resource: Introduce managed SOFT RESERVED
 resources
Thread-Index:
 AQHbaD4SNAeoR9FhZ0CNhDBQza/56LMg6dmAgACyQoCAALongIACNhcAgAY17oCAAETcAIA8c7EA
Date: Fri, 7 Mar 2025 05:56:25 +0000
Message-ID: <b5f46e35-c3a8-42f1-ba30-b7c43d2bdd89@fujitsu.com>
References: <cover.1737046620.git.nathan.fontenot@amd.com>
 <1800b17449d1c231292c85f59b226aff39a81552.1737046620.git.nathan.fontenot@amd.com>
 <4e556200-c790-4e0a-b103-2a1529c81927@redhat.com>
 <3c7c5b87-f241-482b-9b00-98e2e53d8e9c@amd.com> <Z5CKN57paDmGJH9A@gpd>
 <5067fda1-c2de-4a20-9025-ebdf90ebba8e@amd.com>
 <9b0fa1f7-4133-4111-9142-143c36c42f8d@redhat.com>
 <69701a1b-8cec-42e5-90dd-1b1c67c91823@amd.com>
In-Reply-To: <69701a1b-8cec-42e5-90dd-1b1c67c91823@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYCPR01MB6836:EE_
x-ms-office365-filtering-correlation-id: dab21539-7e48-4fc1-4913-08dd5d3ccbd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R0pKQmJQWHBLR1duT2NkVkU3Y3hmeE41N01UMzdBU200SjFFSVNOTkRPUG5w?=
 =?utf-8?B?TWNoSFlTUE1iVUI0RHZKWTFBOGJabmxaUG1nVzJ6eUhGbWZKYkE2NHloS0gx?=
 =?utf-8?B?MWFHQnYvam9POWNtaEFZYkdvRUl3VmRRaUlPRlNxNnNMQ2FTaURnTEV3Mlpk?=
 =?utf-8?B?OHY3TGxqZzF1K1J4TjNxUzJ6cERVdit1cU5kSjJTWW9Yd2FxWG9RdTM5MTEw?=
 =?utf-8?B?K0xwNUZtOVkyeEdpMTlVbmxJaDhqanIrOWdrOGxGTUpkUEhORzFvSEpnM2E1?=
 =?utf-8?B?VEdMbEVaL05PYkFjdmFqRmtZaURiZWlndTd3aHV6czZ4a0hKVk9DRVVYRHUw?=
 =?utf-8?B?WTBQc3FQT0ZUem53YWZzWTFXSjM3MHNJSEMwNzVzS0wzU3pNajd0MU9mbG93?=
 =?utf-8?B?VjU3OUVsbXdHcnM5R0x5eGJtOWhvNUhmU2xUYk9RUzlSekMya2VVd1BOdDlG?=
 =?utf-8?B?Y3VpMzVRdkptSE84RW9SNEZ3QjkxSTJlSGVYMjU4QklzZTBFSkZ2dS80S3VI?=
 =?utf-8?B?UTNrRjNEdDQwMGdCdG5RVGpoaWE2YURhVS84U1ZDWW9YQ01uTjU5ZU9zNUNC?=
 =?utf-8?B?dUJnSFJtdkJGNkNVeEloT1Vlb1l2Tk4zR0dWeDhLOXJ4UGNFN2VlandORHBY?=
 =?utf-8?B?Y0EreXR0dEM4S0ZxMFExbm5mVHBIVk5xMFFSZjBtTFVmTWZ5SkNJS0dBbzJU?=
 =?utf-8?B?eTE1N0JOUXBDMGVzL3VHN0V5WlRtekQrUldFRDJtZTRkMjFaMC9LQnZNRWFs?=
 =?utf-8?B?b0RVZ1ZIMTVnYmtBcHB3L25pQTlxeFJnN2lkNlVQK1FyK1ZndUR1M0lJQ2hw?=
 =?utf-8?B?QUVCR3lISGlWNE5MUEVPOTVDOFU0aGxYT29iT2NnWGpXRWNsQnVJNXhaWHNr?=
 =?utf-8?B?eDZ6VUd0N3duNnpEMkN6cTQwcFU0d1VrZ0hEc3cwWkpsY3J3MWRSY2NxYVhU?=
 =?utf-8?B?YjVDVGRwYlVCcGM3SW0reFlNNC9UdXZpUTRscW5oYlNMMG5sWkJxWVVRRG9S?=
 =?utf-8?B?SENzaGVEKzB4eStsQ2M4RUpOMEdqU1VYRnFQd21ySXQzYm56UHhiK3NqazFt?=
 =?utf-8?B?Wk5kejJPT3l6azZnSlE4Zy95YWwwbXFSUHpKcUhpMzZEYmZwWE1NaFlaVURo?=
 =?utf-8?B?VUFJaU1DS2RCZ2tYeFB0emhkdGcvTlVZd1BxenlGSTNzbndvdy83MFQ4K1Bl?=
 =?utf-8?B?UTJleTRic3k0YmIvaUtWRzQ4MmhtOXRxeU85bkZjZVYyWm1ZZGk3VjVYWDZJ?=
 =?utf-8?B?ejZPS2cvbnNueGFTSjhHMm1aUHRwaDBjQ083djQ5SjNLQVZBQVZxWDV4aHdp?=
 =?utf-8?B?NVcrdEM0NVhrMyt5YnI0dDhBclBRd1M0b082QVREdGhDd1dhZDlCMHh1cGNM?=
 =?utf-8?B?RUFNSFd1N2k4T2ZHdzVua09HSStSY1VNRmlIRWx5Rlo0c00vNDJWR05yakdI?=
 =?utf-8?B?VXZESkVMU1N0d2Z4OExOL1laUFI3eGZ5ck1JRkFxTmZEcE1SRlRjcHJ2d3hO?=
 =?utf-8?B?UkRwck9EcEdGSG9iSFZZOEFicURKajR2bXhUVGg0cS96NzRaL2MxTW9zYWto?=
 =?utf-8?B?R1E5UFhUckZqYU9CMis1Z3IvUVlEZThzTFlnVUIyd1dqNmtkZDBYRkNxdmJN?=
 =?utf-8?B?NWdPUWtJbE91ZUVZS3FNYVgrZTI2cXVYY09jQWhwQlFUWE1zaHp2akpmZzBv?=
 =?utf-8?B?bWx0VDFhWGpnSGhOSUZwbTh6NTRBVk44Q0huL3Z4S1VzZlVJN1IxbWN0dDlo?=
 =?utf-8?B?YXVQaHlxTmFldDVyT3UxSmdXdjJmVTZoUGh2cDJRTUpzaVd6WjF2NXAvOC9O?=
 =?utf-8?B?NjBaVUtMSUxDK3JIZk1rVGt2dVNWOWYvQXYwM3RndWJXL29INDl0NmI1TjN3?=
 =?utf-8?B?VFczTUhvSFFrb1RaclN0S2p6VUdBdmQvLytmdC9PSWlVUkVEeWJETDVEVW94?=
 =?utf-8?B?djdYSkJpSklrd3VQM0ROUmNwVkhGeFhoMzFjT2FuaUQxTjdUdHlLRWxHc09T?=
 =?utf-8?B?ZGJvazRWUkdnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cm1DbzRpK2drdkswc1dIU3Q3a3hGdDlDdE95YmJ1YndCMmVqTTJjcEV5RDlx?=
 =?utf-8?B?TDR0Zi9tcFFhWFZSckRvT0hTZ05VKzJFRHVBRlN2NGdKSUozQy9YbVRnYmxk?=
 =?utf-8?B?RmJONjFtd2haWDdVMjJiQUVqRjFuZy9xS1JYcmxQNE9JZnRvNjcvclRpWmVC?=
 =?utf-8?B?SGh2MW1KT2tVcFpMeGZMUUg2UzVPYlMvREs1TWhuenVmalFqY0lySXNvV01Z?=
 =?utf-8?B?QWxpTzRhVXliVmZnU0V5ZXpacUZGZTdpOHZGWVZZbFowb0NZdVdCdGZaT2VV?=
 =?utf-8?B?R0dobE1xVVR2dEcyMUp0T0svR1laTkNnQ2lPV1VlVk4zekc5akVYR1IrV09D?=
 =?utf-8?B?YU1EY1FmSG5keEZjckExN1JRMnY2YmtiaFoxdktaVnVIL2REalQzWVdRaWhV?=
 =?utf-8?B?Y0ZEK1hLTE50bG5JQzNRS0xWVU1iN0Z5QW1qenNVWWRvSW40azNUNTFsa0hu?=
 =?utf-8?B?THozeXJxYVljRnN3YkYrUUxvZFFRN25odWJLdWZGUVIzNy9ZeCs0VG50WFJE?=
 =?utf-8?B?L2duZExYY0pnZVlGd3dRRlc1NFc5VzhwZEEyK0RkYUZPaThEN2dscHcyQTB1?=
 =?utf-8?B?blFOZUZvaCtZY0RGNmU3Q0h0eEdCSFZlL3FtL0x2N3ZyS09rUGRvQjRIM00z?=
 =?utf-8?B?SzY5Y05rRjBGRWZqRzkvdytDRlJBVm1DbW5Wck01eGFEVVpJbmQxUjBVYmdw?=
 =?utf-8?B?R3UveFAyc1Y0L1pUb2xwOWVpRWxLQjhBOUxURmphRGVtYkUxUTFBREZCNGxX?=
 =?utf-8?B?MmZ5THB0ZFpEckZ6bjlDdUgyMHJocGYrY21pVDhIM1FCYUpmSXdlYnlkR2tp?=
 =?utf-8?B?RTJmOUJCMEw2WE0wejQ2L1N2SjJBcFJMc0V4U0czTnBNbDJwMHFiZ0JwbHNt?=
 =?utf-8?B?RFhqU3VWMSttNDA3UFI2eGUvbUs0eUpDcTh6QjBZdEFLMVJaWW1kazRWRGJS?=
 =?utf-8?B?UW1PSUM5aDBXNVdDczBRWDYwNU0wV0lWaHI0WEhqQTlSdFhwNFp0UUp0ZCtq?=
 =?utf-8?B?anB0U3dSSitUMGZrbXlOWUQ0bXBoalZlNGZ0WWMySHNHeEtod0FDZ0hlSWZV?=
 =?utf-8?B?dHpKcUt0cENUVzlRYnA5NTVOazVBWTVPY0xlemcvRjVoVFR4TER2b1FCdTdv?=
 =?utf-8?B?dEgwVk9yNU5pOTV2UHF0RFBOeGVyS21jTWZ3VTBWTjF3WmVWSS9pTWdUaEpP?=
 =?utf-8?B?aUlOMnlBaExnZm1XWll6dDJzSW5vN3BxZ2hSUld3dW1hSXBvdnZyd1VtS0pC?=
 =?utf-8?B?V1hacDAxMlpCNXBlbXVDa3lOMWVmem41N01ObmZ2ejhkUGV6OTg2dGZYM2t1?=
 =?utf-8?B?cUIwM1RLVFZDYi9GK2tvM08rV2xXNGxjNmNPNTdJQks3MVgzRmszb0Zxak1m?=
 =?utf-8?B?STFVeXpkM1FqVWpYSXZEVGx1cm9KcDZ0Tkc0QU9jNC9hVXExUmo5Y2RhMmtF?=
 =?utf-8?B?Zis4OHFTUEhoQmFUQld0K3pwVU14dUsvSFJCamZQa01nUjMwMW9oNGJlRU1x?=
 =?utf-8?B?c2IzdFRYRExKcFZnVEFNOHlYZHZFUHJad0x6QjBNdjN1QmFSZmZqNWJBTTFV?=
 =?utf-8?B?a3JrRE9HakFrKzI0cTJtLzhuUGNxT0ExRW43NnlNNGlTL2xJNjBwUlBjRFJS?=
 =?utf-8?B?VWNrOFJkVG1kRWtpL3VEcUh1dmJ3enZuSWVWaFJQUnlnS2FSaTdxbEIvQ2xt?=
 =?utf-8?B?L1dhSXZFWmVKZ05lZlBkUmFZQlowU01tWmFjYkVhRlhuTFVVd0dWTktqeU9m?=
 =?utf-8?B?K2ZzdTN3ejRyVktLQTJQT1V4VFViYStpZ1I1TDQ0bnFDaVVCWGZJWG1jc0p2?=
 =?utf-8?B?eGdjRHc2RDRLSGpFalgraGN4Uk5MNnhTZnJ2bThvdWhnZU1ZNXNhUDg1Rnhr?=
 =?utf-8?B?RTFkUXhDMG44RXhsci8xQSsyTDdkU01od1Q5Z0kzOWpHR0wwWjVqeGsyYUtF?=
 =?utf-8?B?VE9YeEhIM3kyTkxDNEpQVGdYOHc1TFJUa0V2eW44OE96MVpVK3VJL1loSkdE?=
 =?utf-8?B?QytSaG9IQ0drRkJCUVowWlBYT2dacmFiTmJ2TzVrbXQ1bGxKTHMzeFZhYm9u?=
 =?utf-8?B?WFQwQ1NLdkNMZy9raDNyckVDOVVyZHRXdnE0TFYvU01tajY4T1RybVNYandi?=
 =?utf-8?B?M0Q5QzJsQkQzcEszd1dzdm8rdUhObWdMRHdzNHdQMUdNVTEyU3NWRHVkb1dY?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C76C794E6CC7314E8D2D7E3D2D86F22F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	clQDQVfS5MRKTEAiA8P0E09grjA0SU36NCRFEZr7PAFSl9TocuYehtGDMbw0ZzwjzPgfPv9eo8JhNVjQ8ohuah1TlwYyBIyBJVwZtbU9mJcfisIOP0ALY8s2VVoqiw61RAKadCsaTUD7rDu3ChDTeySEfi1HUJnSLK9SX/TfiQJDUZPuejd7HYU4jFQHmXd3WC5a1LCeTlsh7cWb7tVH4s/9XOYR/mVlrTC/4Ybom6yEYSolK9xxfubd7mnSw0FhI0cQPuZZ7lxm490wN/cmxAq8YMLWO0gGNdjB9TweihhxH5pdmQVQt9BEC/hqfap4RfI1/gbBxVFKuRU4bNa4eC0xvRQjGG0oeUMMMLgH1oXp5oeRi3Oc3QcOgM7/UCWmEOGxMU7IN5I2aoppGpec/DVoxzZJICpZVUjaov4csxR4sa8n5gtWMa1JQ7NSJ4cE7w5WDIj9qkFJUUitv4ZB8sEAm6i9JhZplkGq1PGlCFq7SIAC4Hij3aRmKoNJ4vBSbuEoikDu+S6Sj3z08s5eUb1KV0CAxRmAd3mavJPqkEIYnJgEEMqG8MCJmtH26hq/IEuYbC6v9PTUwh1L+JY8i6H9WNMcAnCJDQwtQK1wLfv/ivkDxXBV7fY8D9svokhc
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab21539-7e48-4fc1-4913-08dd5d3ccbd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 05:56:25.5121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6U6F/lxpjwkoChOWDxtWrCDphg83ee8hvQSpSTZ6DoXq7/NbhoaIP5wGfjJ9CMv8cwkBCtrhs/iU2I9E3jUiEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6836

SGVsbG8gRm9udGVub3QsDQoNCkkgaG9wZSB0aGlzIGVtYWlsIGZpbmRzIHlvdSB3ZWxsLg0KDQpU
aGFuayB5b3UgdmVyeSBtdWNoIGZvciB0aGlzIHBhdGNoLiBXZSd2ZSBlbmNvdW50ZXJlZCB0aGUg
c2FtZSBpc3N1ZSBpbiBvdXIgcHJvZHVjdCwNCmFuZCB5b3VyIHBhdGNoIHdvcmtzLg0KDQpXZSBk
byBob3BlIHRoaXMgaXNzdWUgd2lsbCBiZSByZXNvbHZlZCBpbiB0aGUgdXBzdHJlYW0ga2VybmVs
IHNvb24uDQoNCg0KT24gMjgvMDEvMjAyNSAwMjo0NiwgRm9udGVub3QsIE5hdGhhbiB3cm90ZToN
Cj4+Pj4+PiBJJ20gbWlzc2luZyBhIGJpdCBvZiBjb250ZXh0IGhlcmUuDQo+Pj4+Pj4NCj4+Pj4+
PiBXaHkgY2FuJ3Qgd2UgZmxhZyB0aGVzZSByZWdpb25zIGluIHRoZSBleGlzdGluZyBpb21lbSB0
cmVlLCB3aGVyZSB0aGV5IGNhbiBiZSBmaXhlZCB1cCAoZXZlbiBhZnRlciBib290Pyk/DQo+Pj4+
Pj4NCj4+Pj4+PiBFc3BlY2lhbGx5LCB3aGF0IGFib3V0IGRlZmVycmVkIGRyaXZlciBsb2FkaW5n
IGFmdGVyIGJvb3Q/IFdoeSBpcyB0aGF0IG5vdCBhIGNvbmNlcm4gb3Igd2h5IGNhbiB3ZSByZWxp
YWJseSBoYW5kbGUgZXZlcnl0aGluZyAiZHVyaW5nIGJvb3QiID8NCj4+Pj4+IFRoYXQncyBhIGdv
b2QgcXVlc3Rpb24gYW5kIG9uZSBJIHNob3VsZCBoYXZlIGFkZHJlc3NlZC4NCj4+Pj4+DQo+PiBT
b3JyeSBmb3IgdGhlIGxhdGUgcmVwbHkuDQo+Pg0KPj4+Pj4gVGhlIGdvYWwgaXMgdG8gcHJldmVu
dCB0aGUgZGF4IGRyaXZlciBmcm9tIGNyZWF0aW5nIGRheCBkZXZpY2VzIGZvciBzb2Z0IHJlc2Vy
dmUNCj4+Pj4+IHJlc291cmNlcyBwcmlvciB0byB0aGUgc29mdCByZXNlcnZlIHJlc291cmNlcyBi
ZWluZyB1cGRhdGVkIGZvciBhbnkgaW50ZXJzZWN0aW5nDQo+Pj4+PiBjeGwgcmVnaW9ucy4NCj4+
Pj4gTm90IGFuIGV4cG9ydC4gQ2FuIHlvdSBleHBsYWluIGEgbGl0dGxlIG1vcmUgaGVyZT8NCj4+
Pj4gV2hhdCBpcyB0aGUgcHJvYmxlbSBpZiB3ZSBvbmx5IGZsYWcgdGhlIHJlc291cmNlcyBhcyAi
c29mdA0KPj4+PiByZXNlcnZlZCIgaW4gdGhlIGlvbWVtIHRyZWUgd2l0aG91dCBjcmVhdGluZyBh
IHNlcGFyYXRlIHRyZWUsIGFuZA0KPj4+PiBwcm9jZXNzIHRoZSAic29mdCByZXNlcnZlZCIgcmVz
b3VyY2VzIG9ubHkgd2hlbiBuZWVkZWQ/DQo+Pj4gVGhlIGlzc3VlIHdlIGN1cnJlbnRseSBlbmNv
dW50ZXIgaXMgdGhhdCB0aGUgZGF4IGRyaXZlciBjb25zdW1lcyB0aGVzZSBzb2Z0IHJlc2VydmUN
Cj4+PiByZXNvdXJjZXMgYW5kIGNyZWF0ZXMgZGF4IGRldmljZXMgZm9yIHRoZSBzb2Z0IHJlc2Vy
dmUgcmVzb3VyY2VzIGJlZm9yZSB0aGUgY3hsIGRyaXZlcg0KPj4+IGNvbW5wbGV0ZXMgZGV2aWNl
IHByb2JlIGFuZCBjYW4gdXBkYXRlIHRoZSBzb2Z0IHJlc2VydmUgcmVzb3VyY2VzIHRvIHJlbW92
ZSBhbnkNCj4+PiBpbnRlcnNlY3Rpb25zIHdpdGggY3hsIHJlZ2lvbnMuIFdlIGRvIG5vdCB3YW50
IHRoZXNlIHNvZnQgcmVzZXJ2ZXMgY29uc3VtZWQgcHJpb3INCj4+PiB0byB0aGVtIGJlaW5nIHVw
ZGF0ZWQuDQo+Pj4NCj4+PiBJZiB3ZSB3ZXJlIHRvIHB1dCB0aGUgc29mdCByZXNlcnZlcyBvbiB0
aGUgaW9tZW0gdHJlZSB3ZSB3b3VsZCBuZWVkIHRvIGhhdmUgdGhlDQo+Pj4gY3hsIGRyaXZlciBw
cm92aWRlIGEgbm90aWZpY2F0aW9uIHRoYXQgaXQgaGFzIGNvbXBsZXRlZCB1cGRhdGVzIGFuZCBv
dGhlcnMgKGkuZS4gZGF4KQ0KPj4+IGNhbiB0aGVtIGdvIHByb2Nlc3MgdGhlIHNvZnQgcmVzZXJ2
ZSByZXNvdXJjZXMuDQo+PiBXb3VsZCB0aGVyZSBiZSBhbnkgYmxvY2tlciB0byB0aGF0IGFwcHJv
YWNoPw0KPj4NCj4+IEFkZGluZyB0aGVtIGFsbCB0byB0aGUgcmVzb3VyY2UgdHJlZSBhbmQgZmxh
Z2dpbmcgdGhlbSBhcyBzb2Z0LXJlc2VydmVkLCB0byB0aGVuIGhhdmUgYSBzaWduYWwgdGhhdCBh
bGxvd3MgREFYIHRvIHdvcmsgb24gdGhlc2UsIHNvdW5kcyBjbGVhbmVyIHRvIG1lLg0KPj4NCj4g
WW91J3JlIGNvcnJlY3QgdGhhdCB0aGlzIGRvZXMgc291bmQgY2xlYW5lci4gSSd2ZSBiZWVuIHRo
aW5raW5nIGFib3V0IGhvdyB0aGlzIGNvdWxkIGJlIGRvbmUNCj4gYW5kIGhhdmUgc3RhcnRlZCB3
b3JraW5nIG9uIGEgdmVyc2lvbiBvZiB0aGUgcGF0Y2ggdGhhdCB0YWtlcyB0aGlzIGFwcHJvYWNo
LiBJZiB0aGlzIHdvcmtzDQo+IEknbGwgbWFrZSBpdCBwYXJ0IG9mIHRoZSBuZXh0IHZlcnNpb24g
b2YgdGhlIHBhdGNoIHNldC4NCg0KDQpJIG5vdGljZWQgeW91ciBlYXJsaWVyIGRpc2N1c3Npb25z
IGFib3V0IGRlc2lnbmluZyBhIG5ldyBhcHByb2FjaCB0byBzb2x2ZSB0aGlzIHByb2JsZW0sDQp3
aGljaCBJJ20gcHJldHR5IGV4Y2l0ZWQgYWJvdXQuIERvIHlvdSBoYXZlIGFueSBpZGVhIHdoZW4g
eW91IG1pZ2h0IHBvc3QgdGhlIHVwZGF0ZWQNCnZlcnNpb24/IFdlJ2QgbG92ZSB0byBoZWxwIG91
dCB3aXRoIHJldmlld2luZyBhbmQgdGVzdGluZy4uDQoNCklmIHlvdSBydW4gaW50byBhbnkgcm9h
ZGJsb2NrcyBhbmQgbmVlZCBhIGhhbmQsIGp1c3QgbGV0IHVzIGtub3cuIHdlJ2QgYmUgZGVsaWdo
dGVkIHRvIGhlbHAuDQoNCkFzIGZhciBhcyBJIGtub3csIHRoaXMgaXNzdWUgdXN1YWxseSBhcmlz
ZXMgb24gUmVhbCBDWEwgbWFjaGluZXMsIGJ1dCBmb3IgZWFzZSBvZiB0ZXN0aW5nDQphbmQgdmFs
aWRhdGlvbiwgd2UgbW9kaWZpZWQgUUVNVSB0byBzaW11bGF0ZSB0aGUgaW50ZXJzZWN0aW9uIG9m
ICdTb2Z0IFJlc2VydmVkJyBhbmQNCnRoZSBDWEwgcmVnaW9uLCB3aGljaCB3b3VsZCBhaWQgaW4g
dmVyaWZpY2F0aW9uLg0KDQoNClRoYW5rcw0KWmhpamlhbg==
