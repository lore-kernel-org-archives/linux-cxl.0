Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2135.outbound.protection.outlook.com [40.107.94.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BB31A2C0B
	for <linux-cxl@vger.kernel.org>; Fri, 22 Aug 2025 02:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755830324; cv=fail; b=OjAj2hwoyNKQMFOc+IGXb1Qe/oq7NP+xMjgcTzBBdY4ETI392wds6SslAS2feQNWlauVrMfTNLyjYSKwDQbNxZgEr9hPb/UsoqoUS8vHQQDMKP3JfuAfN16pv117tSR6oxTrXxADIqC4ra16jlwvfBaJNM53Ox99vdhdsrX9qI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755830324; c=relaxed/simple;
	bh=5BC2eplNJ38+yxkkFuxPEabeVo8SLtMF9IzdmSrvqRk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gRdy7op276zahK+onmOBtKv0+znquiOVGrn2Why2t6vMtAYlrgN7NAa3VldMOwSYRAG5E3Fghk1pIm7iPZCJRZSxtQvaf46Z2uIEDt5qItzWH4eDF5lA/cowP0Tcy1L0/kzqkjPUzdzZim6rS6DRzLn+Rz1THaTVF97K3OEMDok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gatech.edu; spf=pass smtp.mailfrom=gatech.edu; dkim=pass (2048-bit key) header.d=gatech.edu header.i=@gatech.edu header.b=DcCsY5bp; arc=fail smtp.client-ip=40.107.94.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gatech.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gatech.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gatech.edu header.i=@gatech.edu header.b="DcCsY5bp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHhB/6gMG5cMBLNdm46JYT7uinn7ItMgVDqmvyUAiZrifC68jK20MJ8BIcuvv2yYNJo/TRIl6iRWO+WbT+JA8ymeakxASquZUpXq58Ua+2+AMOq0cQVhMGBlsFWM/g7OdSqkVat3Z3Y7C5BMNGkL+FmZHtmY+kUVjcI2PYVUXv1l+VOKK+nJhG9u2TSusi24WlcUpQxSnKjC13s+xTTngsHogf8IWnsZDGkpqPPDLGVlMCK40ESERlm/SCcXDBU8WLjwEZC0OzeVOoMCvJvUK8jas3RQf5riEbLlxd2AQ2q1xnVxXfFDG2UZ3RCa8WmanMF5eHVElARyH1gRMC6YLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BC2eplNJ38+yxkkFuxPEabeVo8SLtMF9IzdmSrvqRk=;
 b=lzwL+c/wUYXfoFNSkJ1IvfOlA5wGwo1I267Hg9VeC3Ge65q2HKKbDQ0NA03Wfj6ckluRwhbhaUY2sHRL9vixPHE+avl3Uf6s0jLEge+ZPTkiFEJjhQYbEggSxm1/bYAUWvkWk2rAluaLtUyCMGPCXTvbJ+IK47TanmBuIwuVxrvj4iOtm7mkYA7rFtXMjC15NiBhRNGNlmYBZFzC7cUzbhi8xli6UOohY3oQ+218E3wuacTtOs1ISggv0xbIQOQNFKlYjmQZ8qGWiYjGzk52M0dLOOqfEN2+Hf3GDbpJaMxkQgCs0mr+gMZAZEnX1LnNsPY12v25cUg3KBF6RpF14Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gatech.edu; dmarc=pass action=none header.from=gatech.edu;
 dkim=pass header.d=gatech.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gatech.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BC2eplNJ38+yxkkFuxPEabeVo8SLtMF9IzdmSrvqRk=;
 b=DcCsY5bpgQnR1muSt8Ev14Xaua3iOrizbnJ1L6OkIj6iof00ujkLrGBGjuAdwYoEOfqnAa0JSODJzxcCffqsV6vjyvNJsaP9Mgdo/BhMhAagbU4OnIEigJCBagWu/QDsCALFOYPPPlmjHQxRus+J4YVM3u2GoYGJapQiYPQP7+8f7XFMrSB1yVmuMwEd7NJV6lYc5MXtNNfBKxQckRBLwfyNNchu0ZsMOk36EX5ZYKNdkFuCzAvTcDVHWFVTlsO1Kjr4zop6mHL0PcYUh106lcMws8vR7JAIcOqVU+QFH8m8YkCaSgtGmZKc38byBiWPLY4tZjgvez85mnBnX77DWw==
Received: from DM5PR07MB3548.namprd07.prod.outlook.com (2603:10b6:4:64::13) by
 CO1PR07MB11186.namprd07.prod.outlook.com (2603:10b6:303:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 02:38:40 +0000
Received: from DM5PR07MB3548.namprd07.prod.outlook.com
 ([fe80::c71d:8a93:a3ab:4ceb]) by DM5PR07MB3548.namprd07.prod.outlook.com
 ([fe80::c71d:8a93:a3ab:4ceb%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 02:38:34 +0000
From: "Olivi, Matteo" <molivi3@gatech.edu>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: How to programmatically discover online and offline memory and
 its latency and bandwidth from user space?
Thread-Topic: How to programmatically discover online and offline memory and
 its latency and bandwidth from user space?
Thread-Index: AQHbYd+dAQZEXdWNNUWZ/UfWlxzzgbMQPu4AgV8XorE=
Date: Fri, 22 Aug 2025 02:38:34 +0000
Message-ID:
 <DM5PR07MB3548AFCDDA3DC39F50EECBE0973DA@DM5PR07MB3548.namprd07.prod.outlook.com>
References:
 <DM5PR07MB354837188B085472F4EE3B5397122@DM5PR07MB3548.namprd07.prod.outlook.com>
 <20250110170150.00005446@huawei.com>
In-Reply-To: <20250110170150.00005446@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gatech.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR07MB3548:EE_|CO1PR07MB11186:EE_
x-ms-office365-filtering-correlation-id: 887dab83-3958-46c8-a03d-08dde124fdab
x-gt-tenant: 042d12d7-75fe-4547-b5b6-0573f80f829d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?IxTOTcVkeK7KeoCPzDEib/F6uGgEznUdObwDcQtXy8L1n3SVoM8MaLMRwp?=
 =?iso-8859-1?Q?7d0NO4ZysQAJQR5HaXV1NgInxZz4x5nTFy1weV7ON1MRVbw2DcaR7/hjyf?=
 =?iso-8859-1?Q?NFTxJVWd2Zp5pBaO+0Ltjrrxm8oAgBWNZa0oIpSpja94BaWwMeTtIjClYC?=
 =?iso-8859-1?Q?te0Q8uFmmh+X1eB0Na5Fkhql/ADBAVAuP/lsPDXme4GorPeOMq7S667vuV?=
 =?iso-8859-1?Q?5RNHEd6UVvhB6AluEfMUUxwzKCWf1rq9mwAmn5khJ8/AulAVlVuzDoY7+I?=
 =?iso-8859-1?Q?RkV5NG4TP+PBIerq0Kz3MkxB9drJ9D7Fkc8az54XUvouZ0KqYf2WoXYndb?=
 =?iso-8859-1?Q?udWsUUY0ns5mYlGdbpahgPpmDLdFeFmW7wtltdYNlzLjmUW88+A0pAWepg?=
 =?iso-8859-1?Q?mo0PLLVCp/OHU2l2np6+ApCaoESyoa7UoH3szMgp8F+hnC+lBrPDMo+kGK?=
 =?iso-8859-1?Q?NdW8CqUBe2nLPPOJ67yYerdNGP/Ahyrv9uxDHhn0ijvb1p1v1XUmDSu0PV?=
 =?iso-8859-1?Q?SmHhqg958MvOzbCDEcha+90P9cxJ/MNndcs7COq1K3gKmle8nYvpnqLCa3?=
 =?iso-8859-1?Q?S2XMWb9TnGs+XJpeahlUuR7v7Wc9ZKmbOt4Hc/DjLTJv3DlTdMl0YzJbKu?=
 =?iso-8859-1?Q?guw6PR6szdl9RfXtEd30lH4d1NwR+MdxkANUSbDP74QEgJZ2kjF1zquhkl?=
 =?iso-8859-1?Q?VN0ixMZ1QBMUQ8zDRC0Wf2QlQmpE3K3iEHwGQYxWCxkCxfDav7+qZ7eOBI?=
 =?iso-8859-1?Q?aXAX95F6XnFLr/zu+SGu5qSAiX7svUtEFyMRZnHCBWbxI9sTM/gmaR+D7L?=
 =?iso-8859-1?Q?zGF2csaNohYTEBXYrbP98khF8aAR0e/9W4W6I1W/Ss8gViDazWt1M7TSgD?=
 =?iso-8859-1?Q?RV2KR4Fpj+GzqbHe+YMaWqChqaJ+qiY6JTVAkVBan0JB0uAaH7z40PcYkW?=
 =?iso-8859-1?Q?lNiNrCze7F9T22g6o0wwwlnBfVp3WsZJIBwtOJulmwcMCW13Wuer2A4byw?=
 =?iso-8859-1?Q?3nxBRpPIVY/HrX2lht0KxI6t9VU+GJQ+CDiJUhzyYHB/6VaYuNC2BOb6Yp?=
 =?iso-8859-1?Q?H5F6c2YLPGPbyPo3WoF174jqpieQfHfRW4mYirqHzRQmpWqu7k0x/PsrMu?=
 =?iso-8859-1?Q?+BxBP4XhxJHErXgL4j11bTHBEoXq6gevedqPBi9HddpLSRJkV9rhWZVGZH?=
 =?iso-8859-1?Q?HCYchdNmCUuChJtCKtoT3f80lvFjcQyxMDkE7DjxhWh/k+2MX/Lr9NGRMp?=
 =?iso-8859-1?Q?Uo4bVtqxogq2HoPUBukFF/6zSA1B8zJ5JjGRmGKy6Oz7SNg/yKlkKmj3iG?=
 =?iso-8859-1?Q?/2vzQxLAgNuDxlN9oKlzr8G+vxZa80pOBuP9fKxigOZjNjbtMLCV8uOdQN?=
 =?iso-8859-1?Q?iVoUmFNvdcFDInsoX1ho5pmRWWfQeyFBz58civyMtV/Fvlz1Fi3ydHZ+pr?=
 =?iso-8859-1?Q?u3dNopGvk9DycEL3Yo4uKYyO/oZ4aJwBcUN/FWYhChK29FP2EgyAyHmqk4?=
 =?iso-8859-1?Q?g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR07MB3548.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?LBiBZQHbpoMYjppsPF8Dm/jf5gYptZWirMD0RfOwsFhWK8AMp7dfaAKqXl?=
 =?iso-8859-1?Q?95Ce2gVD1tF3+pzCX11rBhsLercCanPWjHQdQ2X+9qTaIXaHYI1N20+7x6?=
 =?iso-8859-1?Q?t1Ivp/uCUavFfujrFrygTAIZJbSuxsnnnIGLyUB0WqybIZZqlMpL6elsFX?=
 =?iso-8859-1?Q?F0NqtgUVI/i6yMSC0ENitAduk/3a6bFjlfrr7JVnfQ5cQl585p7/sbxR41?=
 =?iso-8859-1?Q?gTe1ve0TYTW5mzuMLVjEhDGkfHr9aTQ0v7nhVMfKHmsSpxTW+acX0EtWJS?=
 =?iso-8859-1?Q?J/vYvWxIQh6b9zpTbr0I0QgZZ/Up9HO3t+L8Kx7PhNFLTiiEl2FMncmqHi?=
 =?iso-8859-1?Q?lSaxaw3izOQSh/D2YDkRWJpcaCyTYlv1R6BbdWkMYA6XijA3k+RpC/Ou0F?=
 =?iso-8859-1?Q?pE4qXgfNAPPDRS2Fnx+HEWp/2HZNWliQu4cVSw0jHInfWsaXdSy6eyV/0Y?=
 =?iso-8859-1?Q?BNSa9zKATPyh5G/vDxGBZJotUEIegrxFqhKas/QPzK6z+bwye3GlcDBiyt?=
 =?iso-8859-1?Q?NKWYDbnXRHR537BWQtXaFJPrsO4n4lwBTaHcOwQx+FhKG7keXpn3CrHqct?=
 =?iso-8859-1?Q?s5QssG1pwpuFLQmJKisWvxJLkYO4IdihSKACfbmDM3jshLuCVgqa8iyoej?=
 =?iso-8859-1?Q?YqEx2KtlQ0WaJEs8Xu8YSGST0OtcbbnB1VTTVX+sLQsy/MJ2pf6r2iUD3U?=
 =?iso-8859-1?Q?1Od0Sm9lPJ7BJ0IqcLXTNv1KYuLIbrEyepGrI1fIVfFcbAXNZsgH81zPPP?=
 =?iso-8859-1?Q?ZgsaZhnk30a4W4x7eKSdwbbh3uMjVhSw5tctvwzzftChz2fBEYO+IV20Vk?=
 =?iso-8859-1?Q?g5j7sUxHzVa86MpUBtAfHgOk89Yf1elLosAI3mKCmQOUvP1YdFOx0f/V9p?=
 =?iso-8859-1?Q?9lkwO8hEtiqrMke9kvsrZZuw//dFD6jjLx+DGdOEMpJVRe8Vqt1eds38lC?=
 =?iso-8859-1?Q?SXXnz4klrEcZftf9d+pFFcEmv9Psn9xzcoMBKuV6sDSajxAo77l/ZENbya?=
 =?iso-8859-1?Q?PQTYGHLfBhf9r+0/pCsGkfXxjsGp77k5GcvRPadY0vH3SxdIoVVJVA289F?=
 =?iso-8859-1?Q?nrveyYko286MKftxpjK+IXN0TmINlGv/S4KkowQGjf01w6CqjAhS/CS68j?=
 =?iso-8859-1?Q?JnFKoNvfd9/EN3zzbRWY+41fMzpqI7CD71Er80BmJqLjyproXm/a0f5R9c?=
 =?iso-8859-1?Q?3VeB9kYvBlyNIkk8f0nU8x3l1A5MKh872G5ocIt82tME83psVcy1AocQ3A?=
 =?iso-8859-1?Q?+/MYV3d7hWibLa/AdXmR6KI+67sbx57kYTuxELEx0ar9/s+rsdo6MV4DSH?=
 =?iso-8859-1?Q?K28oWXdSN903gHpyGCd1iX0OgO5jwpXmp13x3g94tNncGNKXtZfeBrieBK?=
 =?iso-8859-1?Q?S9CQYqLRvvL8d/NsOZ9sSMa03Ge6QuSmCJEygo5qGArcrsmyv5HPCCz7ms?=
 =?iso-8859-1?Q?bJsE1wELucdJ+FC2DqslBFIPgZbcOAySHE8KF2VMtm4o/KW7h2RQWnnuST?=
 =?iso-8859-1?Q?ygtQweu+9kn2v+jscpolgUkuvZGBd7KhRwq8s0LQH5KAoy3cEd5yttnxQ0?=
 =?iso-8859-1?Q?N0J0N+vbXZLVZ9gcBU/X9pdZTUReMSDtDtgqDCBZInM13MhxcPJ1DIiZ1u?=
 =?iso-8859-1?Q?wYCOZW1vApkQfojV/P3dhvaBzRlEUmwCT/IFTwNsqMrmUa87HVrC6PQa8k?=
 =?iso-8859-1?Q?jK3gqRfAKYL4wPTm4NM0RYRciZM07kF26mknbHiR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: gatech.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR07MB3548.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887dab83-3958-46c8-a03d-08dde124fdab
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 02:38:34.6864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 482198bb-ae7b-4b25-8b7a-6d7f32faa083
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lFWsZ6Ij9LsiPx1kJkLtPxmu3nDk8ksOVXizt9/UdhSExjtXiMRT/ZTAPcWXC36U6jhhFdR++RSyWmdlZoH+nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR07MB11186

Thanks for the thorough answer.=0A=
=0A=
Given this part of the answer:=0A=
=0A=
> The BIOS may have configured the CXL memory and done the work for SRAT an=
d HMAT=0A=
> to include that memory. =A0Or it may present HMAT to a generic port entry=
 in SRAT and=0A=
> leave the discovery of performance to the OS when it is setting up the me=
mory=0A=
> mappings etc. For now we present the data for the nearest initiator (cpu =
/ cpu or other)=0A=
> to the CXL memory.=0A=
=0A=
I have three follow-up questions:=0A=
=0A=
1. Assume the OS, and not the BIOS, does the discovery. Then, the HMAT woul=
d not list the latency and bandwidth to the memory (only to the generic por=
ts). But the sysfs=0A=
files with the latency for local target-initiators pairs would still have t=
he "complete" latency to the memory (as discovered by the OS), right?=0A=
=0A=
2. If it's the OS which does the discovery, what information does it use? D=
oes it rely on some firmware hardcoded values like the BIOS, or does it run=
 some measurements=0A=
(e.g. perform some memory requests and time them)? In case it does measurem=
ents, how does that work for pooled memory that is physically, but not logi=
cally,=0A=
plugged to the host (there's no way to issue memory requests to it)?=0A=
=0A=
3. Regardless of whether the OS or the BIOS does the discovery, assume the =
memory is from a CXL pool that is external to the host. A portion of the la=
tency will depend on the PCIe link that will have variable length (and thus=
 latency). There's no way the motherboard firmware can know that latency at=
 boot time. Is the latency for the link accounted for in the HMAT (and the =
derived sysfs files)?=0A=
=0A=
Thanks,=0A=
Matteo Olivi.=0A=
________________________________________=0A=
From:=A0Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
Sent:=A0Friday, January 10, 2025 12:01 PM=0A=
To:=A0Olivi, Matteo <molivi3@gatech.edu>=0A=
Cc:=A0linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>=0A=
Subject:=A0Re: How to programmatically discover online and offline memory a=
nd its latency and bandwidth from user space?=0A=
=A0=0A=
On Wed, 8 Jan 2025 17:55:41 +0000=0A=
"Olivi, Matteo" <molivi3@gatech.edu> wrote:=0A=
=0A=
> Hello,=0A=
> I'm a PhD student working on orchestrator support for memory disaggregati=
on.=0A=
>=0A=
> I have some questions about how Linux presents CXL memory and its perform=
ance=0A=
> characteristics to user space.=0A=
>=0A=
> 1. What is the simplest way for a user space program (with root privilege=
s) to learn the=0A=
> latency and bandwidth between each pair of NUMA nodes (even non-CXL ones)=
? Are=0A=
> reading the HMAT and shelling out to the cxl cli the only two options? I'=
ve read=0A=
> https://docs.kernel.org/admin-guide/mm/numaperf.html=A0but AFAIU given a =
memory target=0A=
> those sysfs files only report the performance from the local initiators. =
I care about each pair,=0A=
> not just local ones.=0A=
=0A=
Unfortunately the interface indeed only presents a tiny part of the data in=
 a full HMAT table.=0A=
The original discussion on this a few years back concluded that was all tha=
t made sense=0A=
until there was a clear use case for more complete data.=0A=
=0A=
HMAT doesn't have to be complete but I'd assume it normally is.=0A=
=0A=
>=0A=
> 2. Is there a way to get the information question 1 asks for for memory t=
hat is physically=0A=
> connected to the host, but logically isn't? The ACPI spec https://uefi.or=
g/htmlspecs/ACPI_Spec_6_4_html/17_NUMA_Architecture_Platforms/NUMA_Architec=
ture_Platforms.html#system-resource-affinity-table-definition=0A=
> states that "The SRAT describes the system locality that all processors a=
nd memory=0A=
> present in a system belong to at system boot. This includes memory that c=
an be hot-added (that=0A=
> is memory that can be added to the system while it is running, without re=
quiring a reboot)."=0A=
> I interpret that to mean that if (CXL) memory is physically, but not logi=
cally, connected to the host,=0A=
> the SRAT will still describe the corresponding NUMA node.=0A=
> But what about the HMAT? The ACPI spec=0A=
> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/17_NUMA_Architecture_Platfo=
rms/NUMA_Architecture_Platforms.html#heterogeneous-memory-attributes-inform=
ation=0A=
> states that=A0 "The static HMAT table provides the boot time description =
of the memory latency and bandwidth=0A=
> among all memory access Initiator and memory Target System Localities. Fo=
r hot-added devices and=0A=
> dynamic reconfiguration of the system localities, the _HMA object must be=
 used for runtime update."=0A=
> but it's unclear to me if that applies only to physically hot-plugged mem=
ory or to logically hot-plugged=0A=
> memory as well.=0A=
=0A=
The BIOS may have configured the CXL memory and done the work for SRAT and =
HMAT to include=0A=
that memory.=A0 Or it may present HMAT to a generic port entry in SRAT and =
leave the discovery of=0A=
performance to the OS when it is setting up the memory mappings etc.=0A=
For now we present the data for the nearest initiator (cpu / cpu or other) =
to the CXL memory.=0A=
=0A=
>=0A=
> 3. Is there a recommended way for a user space program to tell CXL NUMA n=
odes from local NUMA nodes=0A=
> (both online and offline ones)? One hack would be to check whether the NU=
MA node has CPUs or not.=0A=
> Another option would be shelling out to the cxl-cli.=0A=
=0A=
In general not really. It's just memory, you should never care that it is C=
XL beyond that=0A=
it's performance characteristics are different and maybe for error handling=
 reasons.=0A=
You can indeed use cxl-cli or reads of the sysfs entries that tool is using=
 to figure it out.=0A=
=0A=
>=0A=
> 4. Is there a way for a user space program (with root privileges) to lear=
n IDs of CXL NUMA=0A=
> nodes (both online and offline ones) that are globally unique? What I wan=
t is:=0A=
> a. if two hosts are both connected to the same CXL memory, they should se=
e that memory=0A=
> with the same ID.=0A=
=0A=
Look at serial numbers of the devices.=A0 That's not connected to NUMA node=
 IDs that are local=0A=
to a given host.=A0 Those can be obtained with lspci and are unique (assumi=
ng manufacturer=0A=
set them - which sometimes doesn't happen in prototype parts).=0A=
=0A=
> b. two different CXL memory pools will never be seen with the same ID by =
different hosts.=0A=
ID here can't be NUMA node as those are used to index non sparse structures=
 so it wouldn't=0A=
scale.=0A=
=0A=
Once we get upstream support for DCD (only sensible way to do pools and rem=
ain compliant for=0A=
the spec) and tagging of what that provides, then the globally unique ID wi=
ll be associated=0A=
with particular bit of shared memory on the device rather than the whole de=
vice.=0A=
My guess is that will take a few kernel cycles though.=0A=
=0A=
>=0A=
> All my questions talk about NUMA nodes. I understand that Linux has multi=
ple=0A=
> layers of abstractions to represent memory, and NUMA nodes are one of the=
 highest ones.=0A=
> If any of the questions above can be answered but at a lower level of abs=
traction than NUMA=0A=
> nodes, that's fine as long as there's a way to map the entity in the lowe=
r level of abstraction=0A=
> to the corresponding NUMA node.=0A=
=0A=
Hope that helps a little!=0A=
=0A=
Jonathan=0A=
=0A=
>=0A=
> Thanks,=0A=
> Matteo Olivi.=0A=
>=0A=
