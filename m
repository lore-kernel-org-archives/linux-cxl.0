Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDE1101C4
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 01:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729041842; cv=fail; b=owCxVSMhhfQoklF/rXz/mXOf4BqyBvtlzLkVnR/ssbL+8wGub2AkpZRjEUYts4c2pG9xYgyKzabLvxJ6Xz/p0kNiJvxnDL2XitiY2n7zNSOwm0zYgcpSqdoV4TFyptbLf4Ac4HDlxCVTE3TC7XWcdrIQo1K5X0Y61a7du67Kc2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729041842; c=relaxed/simple;
	bh=6BI8MQ9IKQYM9CCoe16ocwR5nohw3y/rvQcW67k7Tz0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dHBZN4fElMos9XVBu9o+Wb7BrC00UvBeAZgW9IEZSxckfZKJrsKnTB7XT8TDYUM8qnPgrI4rcRn96PLRR524KO7hxWcDuDICkxXwnpxwrtibqpP3LYVdA/takOSQPSuZtJ7wOIGqZtoVdB3TgVvxnj6E/MMp03BDNOg0veq7ovY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=TWEN4kM/; arc=fail smtp.client-ip=216.71.158.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="TWEN4kM/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1729041839; x=1760577839;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6BI8MQ9IKQYM9CCoe16ocwR5nohw3y/rvQcW67k7Tz0=;
  b=TWEN4kM//6ETQYAT3H0UCJaY80pwEE/IE3mweN9oPfRwOWoVSWorNAUQ
   BnkaHVNunirsxagU+QBb+75Bxl/e2lO3xRwA8FlJpjyvEOif0Ei9zBSE3
   rfuxwXqdlnefQ8VEMuUIqnC0V0rgTd5YZZ2K1M1Ypg/P9R0Xy4dzKb26j
   LXSQKuQgAp1nz8QKXKKAW6Lbj/tHC16ha9xq7iTpj9IHo3Lo4rD7aB7mL
   j4drjUtaadJ2CxLGHXVAroneiYBN3U81gBrT1KhL9SNADm5KHFVXs4mZM
   wfpIRwvR11vwHCseOeqjgDFq1OnfS6BMQN6BQK6xxebZT/7NQnXcwSU2U
   g==;
X-CSE-ConnectionGUID: /BrijllZSbuFKKStVyS5Yw==
X-CSE-MsgGUID: hAVuTraCTI2FLsADbJqORw==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="133544535"
X-IronPort-AV: E=Sophos;i="6.11,206,1725289200"; 
   d="scan'208";a="133544535"
Received: from mail-japanwestazlp17010003.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.3])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 10:23:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cn7kAR14TyyDIO894h6+rM7obi1jXNSWRjzp79THkppShNJeoPkQMA9gZTH5nv77qOEa0muzuh18Sk8KeP//BAB6XI6nEfThi1MNAXyCsXG7y26Xw54olnoTHHmqdtEwUQiTJk1CzVjAeqVLPDF/K9OscAjWcj9zleMco2Iw3Fw4HFaIFx+k6MJQWobWMtwhaGTTcOhTKrIK1Gu7dDwOyAzuzwKGhkQUkuP1Ffino4wyNiYSRpJRl+DfuXE7yYbPWAvt5jzUhGB9DThcJK1HXtDqXuFpd7BQxB71ov5VyMfxk+VUfxLs5MTsJZDdaeIqf2I0O+L/6+H5EaDLPnLlDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BI8MQ9IKQYM9CCoe16ocwR5nohw3y/rvQcW67k7Tz0=;
 b=DjMwyuvSvt2cuoJZfQSu3xz3KRCu7qYp2NZKeFlrUNWDUXF/tA76vCH637TZ2JXc9wA1Wo2G/lLN72Te7U9P2p44T83+Tb472zGs1KWa/a3hX/qOYcI63u7RqhvsY+2Mt3Jc2sb3HEWEXznAyju88DQPrWpOlGuV7Frhyopu3Xu75WsOApDefcYRqxSrbTB+Lv1lNRkwSpb1MjKviIsVewmIQ0kYBUgw+vVT0ufE7y+R0FR1fhgDlcE2v55YlzHY8m1s8jqL6SF7Es+2/Ogu8XGjOzfKMEL23eKnRlt1JQ677Yc/SgDd/kRRQeUQPfU37YwTC+G/hcXzr+Q9JftIRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS9PR01MB12372.jpnprd01.prod.outlook.com (2603:1096:604:2e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 01:23:46 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 01:23:46 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>, "Huang, Ying"
	<ying.huang@intel.com>, Dave Jiang <dave.jiang@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: KASAN error when insmod cxl_test
Thread-Topic: KASAN error when insmod cxl_test
Thread-Index: AQHbGvRKtMfvUkYwxU6jpT5dPG0bKLKHhXeAgAARagCAAI08AIAAehCA
Date: Wed, 16 Oct 2024 01:23:46 +0000
Message-ID: <8e68efc0-c5fb-457b-bf9d-d59b173afd4a@fujitsu.com>
References: <87y12w9vp5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <04fb47fd-0114-48c7-ab8d-e779924f489b@fujitsu.com>
 <3f7e276b-bd2d-4986-8953-cc80a851304a@fujitsu.com>
 <670eaf3c9f1d8_3ee22944@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <670eaf3c9f1d8_3ee22944@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS9PR01MB12372:EE_
x-ms-office365-filtering-correlation-id: 2f9df34f-48c1-4a50-d8f6-08dced812e8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?b1NrcVZMYVg0WmRITDVPZHZtd2IxbmIzaytXdGJjSVV5dXFmNXZjZUZxWTNE?=
 =?utf-8?B?bzBMMHdrcVZLUzFGR1RTS2FManVVNy8rTndsV3FBSHZRMUpZZXd3UGkvSjQ3?=
 =?utf-8?B?V21nZTZFME0yR0FGaC9yWFJRUEErR3ViUjkwVDAxV3p4b0JHRHB2RHg3L0pL?=
 =?utf-8?B?bmhMRVVBZjcwZ2FCQ3JnNVZhNk9SaUJReXJTTlhjeC9YZGp4NXV0Wll4SitZ?=
 =?utf-8?B?b002M2I0Q2tWeHh2b2tsbGg2NTJGMXhBK0hlMXFhcm92STdqQ3ZJcnE0aU9O?=
 =?utf-8?B?ekMrdzIzUlByMyt4YjFVVDQySzlvQXdyaWI1THFJYWkzUGRwRDlHaW9SbVE5?=
 =?utf-8?B?aHozV01USFJJdDJyd3FadzhVV0I1Vi9kdjNOZWF1K05EVE5ldm5TanJaSjNH?=
 =?utf-8?B?WFluamRSZFJlV1VxaFpFelpsbXZFV1Fhc25NU0YwSVJxK1RYT29QRWFCc1dQ?=
 =?utf-8?B?b2hmaGJDS0tQYkQwb1VwdGpTbUIvd2RWUHVVUS9LZFFjSTQzWkVFbUMwMXlp?=
 =?utf-8?B?YndaaHk2dzdEeitCeDdXQU9RZGVzb3QvdDlCR09JclNHS2JrWU5CTSs5MjRF?=
 =?utf-8?B?KzB4NDE0L2NhWmJGaWx0NjhPbC96SVFVcUFaVTNLOVVpbGIrSHgvU0pLMzN1?=
 =?utf-8?B?YjZKcnBtWm9DRkNYekJDN3ZoSFFYTy9vLzJpQ3I0aSs3c0l1RXdPeFRmV2xs?=
 =?utf-8?B?d2tPbDJuc2VPVWMva2lpTk1ZMHk2UHMzSHE1Tk1mOWg4OGlKMEcxc2U5VVRZ?=
 =?utf-8?B?cVZwTk9UaEtiY0lWd2lKZmJkL01UQkZkS1VzMldFeVZRR3YvVmlCK2FDSFM3?=
 =?utf-8?B?RmVPNGtLNmYzZXhyK05NK0ZBTGV0RVlJaEFVZFFnTktmTFNOTEx2UU84U2Ur?=
 =?utf-8?B?aWp3bEFZVUh2S2Q3TS9zVmhoVEdkNjVTVnc4R3Zja2pKaEc5WEwycHNnUDNz?=
 =?utf-8?B?cjBreU8zbWFPQXJlejBtQktGei90MkZHTXprMnJvck0zb2o4d1BtOHVlMjhL?=
 =?utf-8?B?N3ZBNlRvNU9aa1RoUVdhTjhqbHJvQjNpWmRaWmNSMUc1TW1Cakd5YjR0SlZT?=
 =?utf-8?B?VGROb1dHRGg1bDNjZzVxa0dZNjBUaStKd3ZEMnBXVVNxQ1paR3V3RVZVWmZU?=
 =?utf-8?B?S0dBRUdySUFaYnB3L3FGODJyaU5kRFlXSktVaXNuUWRmQktLM2U4dGlQQ1c5?=
 =?utf-8?B?SkkzUFl0RXNjRkxHM211aHdVcmNqOEJkN0hJMnU5a256VlFhZW1WWjdKNlpH?=
 =?utf-8?B?WjROaGk4TExHOFhaUGlaUWxQa3R0M2dpMlAyQ1R6b3BuaEpCSitlNGRhd21Y?=
 =?utf-8?B?RitlZEQ1TGJraWI4Qml6Snhpb2M4T2pvZ1BBNUZWVFFMNk0wUFV4WDFBTGtI?=
 =?utf-8?B?R3ZWcTNlQm9xUlcrd3ZIMU83U3BVbVN5Tjl0U3VBT3Y5UWpaMXovWVA1dTRF?=
 =?utf-8?B?RFpGbGp1RkQxWm9CUE40RmNwY2NsRzdXNkdNbFhMTjRNZklkR1JiWXVpNWhh?=
 =?utf-8?B?YWpSM1ZwRWxlaDJROXRqdW1Yc1dBSFZ5QlhOVURGS0lZVCtMY2FjVFJWQkIx?=
 =?utf-8?B?cHlXUGFzZmhJTTJRZ3BDNFMzRGJjOTl1WEl4KzFGSmNGREVLMlFvNDBTaTJG?=
 =?utf-8?B?NkRqVEJsZW5NeGdyK1VMMkNZdEVkODAvcnRtSjA4YVBlWjRyYjhyRTVEcmhv?=
 =?utf-8?B?ZWtERnB0SjZDek9RaUN6K05BaDVaQzVmWVBIeVRkQTkvVzdJVkpVd2dIWWo1?=
 =?utf-8?B?SEcyNVlYcXdpMGZ4UWlSK1ZkdHBrb1ZrdnZtRU5odCt1NDNacGw5amJGdEZN?=
 =?utf-8?Q?TSaSOtJFmT5CPHLNu1dB6umYD3jRw1sUTvVio=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXlmcWE4QVpjc3VlWVFNQml6TkZ4Njh3Q25JeVRqY2lyVXBoT04vK2lOK1dU?=
 =?utf-8?B?WVo0cFNSakpqM080YmcvengwcklVYmpVcXhWbUtJaTVHL0FtRUhFWmJxOHlM?=
 =?utf-8?B?dTQ5ZDhvUCtEZExmNTB2cXU1R2VzZ3Y0OTJjL1NsVmU2YjNWZ05xNXRhT3V5?=
 =?utf-8?B?TFBjN2VBcnF4c2Qxb05BN1hCOUJMTHQyN3R3dkRuTDl0TDlrcm5UKzY3aVJu?=
 =?utf-8?B?OWF5K0RBOWFRN0NCMEZnZmV5ZEI0QkQwem5WRUVUcTFjemUvWGhMVkZ1ZG1M?=
 =?utf-8?B?NUZVamN4V25Fd0dHZTJqRUFMb0hlZHNjbjk4OTZsTno5V0N2OCt6VTNESlBH?=
 =?utf-8?B?TE4xUmdONVRWN1d3eHFWc0Via3ZkUkxqWlFPSXlmWVdTQSsxZDRqSDJsZW9B?=
 =?utf-8?B?cDJjR2EyTjlLWWdVMjB3OXRMNSsrSFdtMnBwUkZtcUcyclFpS1d4Zy83N1BC?=
 =?utf-8?B?Z2dQb1FYWlJNcUIxcGJJdGJYQW96ODB1MXdvWGZnbWVDWjBxTmN5L3RVWXRa?=
 =?utf-8?B?bnZwZVBlTU9kTnRaZXQ1TjYrR1BQdlRPaklNaFMzN3I2b3YrbHp3NGNJOUdt?=
 =?utf-8?B?L1dnQVFqTWNWQWZteUpMN2RLU2llSzU5clVYRVFXUG5lam43dWlwTHNZOGFw?=
 =?utf-8?B?RDJneXcyeTZuQzRDajU1b2g2eXlWTiswbWlLWGloYllpcVE2NURCbzB4R3dh?=
 =?utf-8?B?WnlZVTRQUVN4MlFOVHA0bm1UTVBONnErTk1sL2VaQmF3RnZVWkt6SHRrNFZ3?=
 =?utf-8?B?THJoMHdRc1prKzZLejV5TnMxMkw5dmR5WEIvVXhvQ2k3bUNBN1lLWW9zSk9s?=
 =?utf-8?B?UHB0blc1NEVuQ1UrVjgrTElzb2F6WEpxRkM2ejZybWVuT3V1NE9qWXphRVpZ?=
 =?utf-8?B?UGIzNDhIc1FVV1l5Z003d1FqQXFRYnFSRHRCZ0k2cWJYMmNkSDNzS3VnamZB?=
 =?utf-8?B?ZlF5cisxMUZVcDYrRXhIT01JK2tNSnJqbnJ3NGhKSk9lY3R3WlY1MVBFWUh3?=
 =?utf-8?B?cDBhT21XOFdBQ0ZKN0dScFMwSERhWXc2dUFSRDFIcTRLYStOOFNwa3ZQL2hw?=
 =?utf-8?B?ZGZLZ3h0N2VOcUgrSlpLTDd2UU94bGVoQWllSnlDVkRTTHJ3UjhEZ2I1NmJR?=
 =?utf-8?B?UHluS2x3KzdlbWhEUFdNaTlhcnYraTlSU3BYZ2Q5UUJKbEJGUmFzUVZOK0R3?=
 =?utf-8?B?cUJJemVkK1lLMTUrMW1SSFlSTDBkUkFTTW50Z21MdmxISi8yM3ByaXN4SGRK?=
 =?utf-8?B?N1BFMFpJTk1tcEpHay95SVNuckhadHZqY3VYTURDU1JoWnk4RnJYeHBXbmhD?=
 =?utf-8?B?bExmUGFxTnhoR0MyZUJDNzFzaXJqR1lKd2haa3owb2lJekZFSk9ZczFVTW1i?=
 =?utf-8?B?ekRsYmlMeEY5QlhsU3c0Zk9SejVibDV2ZmM3TlN0SmtsUUNnVTdYbmJXU1dD?=
 =?utf-8?B?UkZ6UDE5V0JLRlVSemlhUU1FZm1NUWdTZkZYZHQ3MkxTeGh0Vno2Smh3Qk1E?=
 =?utf-8?B?T0JDdVVadE0xNDB2c0R1d3VJZVVrejVCcHpKN1hKWVlSMkltN0U4WEg1Qld2?=
 =?utf-8?B?aWlsOWFFZEpwS1VDTnNCWVBRUzJGb05sZjlmRGM2R2ZyaHVqWGRpTVI0WGNt?=
 =?utf-8?B?SE0zUlJjZkN0SFV0THV0N1l0aHpiMXJXUktnRmZRbVFzVDZrM2tZNGJiR01n?=
 =?utf-8?B?WDJ4M25lUityTUwxd2dSV0Z2cjlZam1tMVVCWU9SSE1CN2RoeHlaOTJudjZa?=
 =?utf-8?B?azhYQXVRa1JmSFcyS3FjcDJlL3FZYm9lL091WUlIRWhjMHJINGd3QTd2czdJ?=
 =?utf-8?B?VHVLKzF3aExHbGk3aVp5VjBFTGQ0MVppMENsbzJGR2E2bEdsd2FwRnR6WXUx?=
 =?utf-8?B?VW90NDdlWW1XUEdUdEtvTTBwS0pML3RUL0FGNGovSUcxVjdKaWptbUlMQmZp?=
 =?utf-8?B?UDBXd3NFanp0dXZ6U2xqRHZSdXowbDdkbHZFL25tY3V4eEtDWlpFandZN29G?=
 =?utf-8?B?T2hHNFVNY1VTNCtSWDFNajRNbVZQZGhRSC9OeFo5ZGM1bWFQRkpEQk9SNWVX?=
 =?utf-8?B?SFg0THRvTFBMMnFLWWN1M2l2Z1BENndQSzFzTE5qSnBMd1ZOZXFjeUFXK0JN?=
 =?utf-8?B?K1dNd04yeE84WGFGdHg1RXM3VUc3VW42V1o3Ti9HQXNIUVdmZmhUWFh5WWY1?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A85B8D995455E543A727336235E453E7@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WuLEu9iYjBzF7Q9n+/ir7pj02GZeVkqDCCr6SxwuIBvTLAyoIcP8D/fA4MRN6QNqxYgOipNXvR8T0Bsu6w249u3TxvFgRERW8onVz3Cj3YZVz7UDHc+qFYiM1ZpV18r2JG8/qa90bAfPl7kwUgH7bA3R6NNVjKiuxAiSYOYmH4T6l0doXIa7GY0XFI3U/BIt4Zel4kKemFzjWPPpkCeuYUT0QAWZa2lWebODoV7ayqDnZCP9Mqnr/Rqx4QAH2nydmnyyxD7+TrCwigIqCzu/ioI3QS8LmkeFPDOVvYHFGj9owOOI3wdXnqJA0ede4shQv0WNRU/zT1H188p++N8IbygR9CkLjc1zW5f6Gv6nINq9C7VE1NKPKAirHOVPWrdHwH8gT2iF1Ckmc1U5ekWRLWBsnUUBd5Uv+e7ALWBGTI8MsSvjKZ2bOTV66pA9z5KMoxOs43kYM+EvRNLiX0SBr3YeC3QpKnuE9naSV1hKzsSWRf/3RlgQEfE7AxtaFICgU7fAWUYvF0i7dp+XnLDYq4b0GT1nwWKk/duBDKNm0umw5RznpTxGi1V6Ej0cu1K3ZHVJL11miXtg+dVGdkJKhKBAWM7TVMjS88o3aM+YwRrBlSnO+8SWFklLpC0azACy
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9df34f-48c1-4a50-d8f6-08dced812e8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 01:23:46.6886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3EERYnxejinwkWwFV76ultQW5pfTcMv7tEPElu+D8VTeCtI1xceeZzoyfocxiAJkWbjN0dNHxCQbkIcecZgpCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12372

DQoNCk9uIDE2LzEwLzIwMjQgMDI6MDYsIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gWmhpamlhbiBM
aSAoRnVqaXRzdSkgd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDE1LzEwLzIwMjQgMTY6MzksIFpoaWpp
YW4gTGkgKEZ1aml0c3UpIHdyb3RlOg0KPj4+DQo+Pj4gQWxsLA0KPj4+DQo+Pj4gSSBlbmNvdW50
ZXJlZCBhIHBhbmljIHdpdGggc2ltaWxhciBjYWxsdHJhY2UNCj4+Pg0KPj4+IEkgZ3Vlc3NlZCBJ
IGhhdmUgcm9vdCBjYXVzZSB0aGlzLCBpdCB3YXMgaW50cm9kdWNlZCBzaW5jZSBjb21taXQNCj4+
Pg0KPj4+IGNvbW1pdCBhNWFiMGRlMGViYWE2NWUwYTc1ZWMwNzYxYTI3NDVjNjZhOWQxN2RjDQo+
Pj4gQXV0aG9yOiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT4NCj4+PiBEYXRlOiAg
IFR1ZSBTZXAgMyAxNzoxMTo1MSAyMDI0IC0wNzAwDQo+Pj4NCj4+PiAgICAgICAgY3hsOiBDYWxj
dWxhdGUgcmVnaW9uIGJhbmR3aWR0aCBvZiB0YXJnZXRzIHdpdGggc2hhcmVkIHVwc3RyZWFtIGxp
bmsNCj4+Pg0KPj4+DQo+Pj4gV2hpY2ggY2FsbHMgY3hsX3JlZ2lvbl9zaGFyZWRfdXBzdHJlYW1f
YmFuZHdpZHRoX3VwZGF0ZShjeGxyKS4NCj4+PiBIb3dldmVyLCB0aGUgY3hsX3JlZ2lvbl9zaGFy
ZWRfdXBzdHJlYW1fYmFuZHdpZHRoX3VwZGF0ZShjeGxyKSB3b3JrcyBvbiBQQ0kvUENJRSBkZXZp
Y2Ugb25seQ0KPj4+IHdoaWxlIHRoZSBjeGxfdGVzdCB3YXMgaW1wbGVtZW50ZWQgYnkgcGxhdGZv
cm0gZGV2aWNlLg0KPj4+DQo+Pj4gSSdtIGNvb2tpbmcgYW5kIHRlc3RpbmcgYmVsb3cgcGF0Y2gN
Cj4+DQo+Pg0KPj4gQW4gYWx0ZXJuYXRpdmUgcGF0Y2ggd2l0aCBhIG1vY2ssDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL3Rvb2xzL3Rlc3RpbmcvY3hsL0tidWlsZCBiL3Rvb2xzL3Rlc3RpbmcvY3hsL0ti
dWlsZA0KPj4gaW5kZXggYjEyNTZmZWUzNTY3Li5lZDlmNTBkZWUzZjUgMTAwNjQ0DQo+PiAtLS0g
YS90b29scy90ZXN0aW5nL2N4bC9LYnVpbGQNCj4+ICsrKyBiL3Rvb2xzL3Rlc3RpbmcvY3hsL0ti
dWlsZA0KPj4gQEAgLTE1LDYgKzE1LDcgQEAgbGRmbGFncy15ICs9IC0td3JhcD1kZXZtX2N4bF9h
ZGRfcmNoX2Rwb3J0DQo+PiAgICBsZGZsYWdzLXkgKz0gLS13cmFwPWN4bF9yY2RfY29tcG9uZW50
X3JlZ19waHlzDQo+PiAgICBsZGZsYWdzLXkgKz0gLS13cmFwPWN4bF9lbmRwb2ludF9wYXJzZV9j
ZGF0DQo+PiAgICBsZGZsYWdzLXkgKz0gLS13cmFwPWN4bF9kcG9ydF9pbml0X3Jhc19yZXBvcnRp
bmcNCj4+ICtsZGZsYWdzLXkgKz0gLS13cmFwPWN4bF9yZWdpb25fc2hhcmVkX3Vwc3RyZWFtX2Jh
bmR3aWR0aF91cGRhdGUNCj4gDQo+IEkgcHJlZmVyIHRoaXMgbW9jayBhcHByb2FjaCwgdGhhbmtz
IGZvciB0cmFja2luZyB0aGF0IGRvd24hIEZlZWwgZnJlZSB0bw0KPiANCj4+ICAgIA0KPj4gICAg
RFJJVkVSUyA6PSAuLi8uLi8uLi9kcml2ZXJzDQo+PiAgICBDWExfU1JDIDo9ICQoRFJJVkVSUykv
Y3hsDQo+PiBAQCAtNjEsNiArNjIsNyBAQCBjeGxfY29yZS15ICs9ICQoQ1hMX0NPUkVfU1JDKS9w
Y2kubw0KPj4gICAgY3hsX2NvcmUteSArPSAkKENYTF9DT1JFX1NSQykvaGRtLm8NCj4+ICAgIGN4
bF9jb3JlLXkgKz0gJChDWExfQ09SRV9TUkMpL3BtdS5vDQo+PiAgICBjeGxfY29yZS15ICs9ICQo
Q1hMX0NPUkVfU1JDKS9jZGF0Lm8NCj4+ICtjeGxfY29yZS15ICs9IG1vY2tfY2RhdC5vDQo+IA0K
PiBNeSBleHBlY3RhdGlvbiBpcyB0aGF0IGFsbCBDWEwgY29yZSBtb2NrcyBsYW5kIGluDQo+IHRv
b2xzL3Rlc3RpbmcvY3hsL3Rlc3QvbW9jay5jLCBvdGhlciB0aGFuIHRoYXQgdGhpcyBsb29rcyBn
b29kIHRvIG1lLg0KDQpJIHRyaWVkIHRoaXMgb3B0aW9uLCBidXQgaXQgZmFpbGVkIHdpdGggZGVw
ZW5kZW5jeSBjaGVjay4NCg0KJGRlcG1vZCAtYQ0KZGVwbW9kOiBFUlJPUjogQ3ljbGUgZGV0ZWN0
ZWQ6IGN4bF9tb2NrIC0+IGN4bF9jb3JlIC0+IGN4bF9tb2NrDQpkZXBtb2Q6IEVSUk9SOiBGb3Vu
ZCAyIG1vZHVsZXMgaW4gZGVwZW5kZW5jeSBjeWNsZXMhDQo9PT09PT09PT09PT09PT09PT09PT09
PT09PT0NCg0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3RpbmcvY3hsL0tidWlsZCBiL3Rvb2xzL3Rl
c3RpbmcvY3hsL0tidWlsZA0KaW5kZXggZWQ5ZjUwZGVlM2Y1Li44MTM3OTBkNDAxMDAgMTAwNjQ0
DQotLS0gYS90b29scy90ZXN0aW5nL2N4bC9LYnVpbGQNCisrKyBiL3Rvb2xzL3Rlc3RpbmcvY3hs
L0tidWlsZA0KQEAgLTYyLDcgKzYyLDcgQEAgY3hsX2NvcmUteSArPSAkKENYTF9DT1JFX1NSQykv
cGNpLm8NCiAgY3hsX2NvcmUteSArPSAkKENYTF9DT1JFX1NSQykvaGRtLm8NCiAgY3hsX2NvcmUt
eSArPSAkKENYTF9DT1JFX1NSQykvcG11Lm8NCiAgY3hsX2NvcmUteSArPSAkKENYTF9DT1JFX1NS
QykvY2RhdC5vDQogIGN4bF9jb3JlLSQoQ09ORklHX1RSQUNJTkcpICs9ICQoQ1hMX0NPUkVfU1JD
KS90cmFjZS5vDQogIGN4bF9jb3JlLSQoQ09ORklHX0NYTF9SRUdJT04pICs9ICQoQ1hMX0NPUkVf
U1JDKS9yZWdpb24ubw0KICBjeGxfY29yZS15ICs9IGNvbmZpZ19jaGVjay5vDQpkaWZmIC0tZ2l0
IGEvdG9vbHMvdGVzdGluZy9jeGwvbW9ja19jZGF0LmMgYi90b29scy90ZXN0aW5nL2N4bC9tb2Nr
X2NkYXQuYw0KaW5kZXggYTQ4ZDljNTQ5NjUxLi45N2JlYjlmMTA3YmIgMTAwNjQ0DQotLS0gYS90
b29scy90ZXN0aW5nL2N4bC9tb2NrX2NkYXQuYw0KKysrIGIvdG9vbHMvdGVzdGluZy9jeGwvbW9j
a19jZGF0LmMNCkBAIC02LDQgKzYsMyBAQA0KICB2b2lkIF9fd3JhcF9jeGxfcmVnaW9uX3NoYXJl
ZF91cHN0cmVhbV9iYW5kd2lkdGhfdXBkYXRlKHN0cnVjdCBjeGxfcmVnaW9uICpjeGxyKQ0KICB7
DQogIH0NCi0NCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL2N4bC90ZXN0L21vY2suYyBiL3Rv
b2xzL3Rlc3RpbmcvY3hsL3Rlc3QvbW9jay5jDQppbmRleCBmNGNlOTZjYzExZDQuLjRjNDM0NjJj
MTA4MSAxMDA2NDQNCi0tLSBhL3Rvb2xzL3Rlc3RpbmcvY3hsL3Rlc3QvbW9jay5jDQorKysgYi90
b29scy90ZXN0aW5nL2N4bC90ZXN0L21vY2suYw0KQEAgLTMxMSw2ICszMTEsMTEgQEAgdm9pZCBf
X3dyYXBfY3hsX2Rwb3J0X2luaXRfcmFzX3JlcG9ydGluZyhzdHJ1Y3QgY3hsX2Rwb3J0ICpkcG9y
dCwgc3RydWN0IGRldmljZQ0KICB9DQogIEVYUE9SVF9TWU1CT0xfTlNfR1BMKF9fd3JhcF9jeGxf
ZHBvcnRfaW5pdF9yYXNfcmVwb3J0aW5nLCBDWEwpOw0KICANCit2b2lkIF9fd3JhcF9jeGxfcmVn
aW9uX3NoYXJlZF91cHN0cmVhbV9iYW5kd2lkdGhfdXBkYXRlKHN0cnVjdCBjeGxfcmVnaW9uICpj
eGxyKQ0KK3sNCit9DQorRVhQT1JUX1NZTUJPTF9OU19HUEwoX193cmFwX2N4bF9yZWdpb25fc2hh
cmVkX3Vwc3RyZWFtX2JhbmR3aWR0aF91cGRhdGUsIENYTCk7DQorDQogIE1PRFVMRV9MSUNFTlNF
KCJHUEwgdjIiKTsNCiAgTU9EVUxFX0lNUE9SVF9OUyhBQ1BJKTsNCiAgTU9EVUxFX0lNUE9SVF9O
UyhDWEwpOw0KDQo=
