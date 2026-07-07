Received: from refb.tmes.trendmicro.com (refb.tmes.trendmicro.com [18.208.22.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A07F313E30
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jul 2026 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.208.22.188
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431099; cv=fail; b=LNI6p1McpuypWwPbbMAT3tSjV9Y5MKYZi9xCnOCDCf6IiVO0boRBMdX64E6oQQXtskSfnShlHTMI1h4v489zBIl3Dm1fLhqXbZUMBsPPfd0+Zn0SltE0teKxKQqWwRjT5W1plAXEtHRUqMuCW3KJoqJ4T05+jA39u/dhkBH+jnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431099; c=relaxed/simple;
	bh=bD400y1893oiAcPQB8yMDzeaj6JthhGGL7bvxzOsM6A=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fMr+RaBVaRr2U7oUreHnbhamNOjbzwVPSEbR4+0OChUWXHRn80ThbZOelG6H3BmWil59YMUKF7wvNjFtqsxn3D38grvG7ZvV1r7StW180ywZKr1UMHwQabSXqG7476sDkrK9Nyx7/O0zQRHkfDSqrqgeJ0XTbPTUnP6sTyiGyB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nus.edu.sg; spf=pass smtp.mailfrom=nus.edu.sg; dkim=pass (2048-bit key) header.d=nus.edu.sg header.i=@nus.edu.sg header.b=j9eg7DUS; arc=fail smtp.client-ip=18.208.22.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nus.edu.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nus.edu.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nus.edu.sg header.i=@nus.edu.sg header.b="j9eg7DUS"
Received: from 40.93.129.55_.trendmicro.com (unknown [192.168.27.160])
	by refb.tmes.trendmicro.com (Postfix) with ESMTPS id E5CD510C79ED4
	for <linux-cxl@vger.kernel.org>; Tue, 07 Jul 2026 09:59:44 +0000 (UTC)
Received: from 40.93.129.55_.trendmicro.com (unknown [192.168.197.57])
	by repost01.tmes.trendmicro.com (Postfix) with SMTP id DC403100004CE
	for <linux-cxl@vger.kernel.org>; Tue, 07 Jul 2026 09:59:37 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1783418377.153000
X-TM-MAIL-UUID: 1dc6e640-4ddd-405c-9b65-2011a879f083
Received: from SI4PR04CU001.outbound.protection.outlook.com (unknown [40.93.129.55])
	by repre01.tmes.trendmicro.com (Trend Micro Email Security) with ESMTPS id 25A78C000437
	for <linux-cxl@vger.kernel.org>; Tue, 07 Jul 2026 09:59:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeB8GB+VurlAQX6xTb/ROtsQgyEPeouCUp4TQaJBhxBXTUMapy9pHRDZCfBVZmY/f89rZ1sPzEOnSbExRB7YKDmHoEUwU3p0LBgQsjOAXI2KWUbZU49VmfhtrO+iKS5a+Zu8haW8X5RpdSsSWGBUgF9kjFiR3YQqIrFXRB61WzC5oFn6jukIT6SDy5teLRDf5T8I4GEXfMSewfSa67KNMyZF+fmc3ORxLwbpsPcKUnSSZfE4DNFh9nA7i9O0RREFEEcKjJHpm2j6uJ2RG8qiYtYzbIZua6XJutMiv8Z2zou8oVrn12ATMnSk1y32hY8wP6gyc+mS66IfIDnWPTj/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bD400y1893oiAcPQB8yMDzeaj6JthhGGL7bvxzOsM6A=;
 b=vvGf9l3VQ14qLx1njjtcKPUEhzE6rn9ixBCxoVMRYl73oHI9Ay8FfRLBmryjB6Q1MwPas95rqQDPRFuY9NpFRoQWUYl7BF6ZOqsEYE2gX+NJzykpZmcu/jXXHcNszDhaJdysIvnX/yJz3OffvQv6OBPMzel16vy+g4UoduxYpsE+ejAozXS4w7iWKtPOeZTbjhBBA9UWCTAxqz6w2WHFmwf1oCG28uxO1d6BdRtH2gMoQVW0qk6d+csx/evxrO2nt+mOwcBtEKPcuLOX66bTfZZdbLvvf/FF7ngjzgYhH3rNs/p+ZzjV/3mVESNU6UQV3zQpGsAJBoCEI6oTz0TIdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nus.edu.sg; dmarc=pass action=none header.from=nus.edu.sg;
 dkim=pass header.d=nus.edu.sg; arc=none
Received: from KL1PR0601MB4874.apcprd06.prod.outlook.com
 (2603:1096:820:a9::10) by SE1PPFFDBC8F9D9.apcprd06.prod.outlook.com
 (2603:1096:108:1::433) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 09:59:33 +0000
Received: from KL1PR0601MB4874.apcprd06.prod.outlook.com
 ([fe80::60c7:8fa7:33e0:57b0]) by KL1PR0601MB4874.apcprd06.prod.outlook.com
 ([fe80::60c7:8fa7:33e0:57b0%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 09:59:33 +0000
From: Flavien Solt <flavien@nus.edu.sg>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Clarify extent lifetime identity across release and re-add
Thread-Topic: Clarify extent lifetime identity across release and re-add
Thread-Index: AQHdDfcuZpZTKJdd3E23GtCO6Vxz8Q==
Date: Tue, 7 Jul 2026 09:59:33 +0000
Message-ID:
 <KL1PR0601MB48740FD9588234086F657DCD8DF02@KL1PR0601MB4874.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nus.edu.sg;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4874:EE_|SE1PPFFDBC8F9D9:EE_
x-ms-office365-filtering-correlation-id: fa71042c-5dbc-491b-91a6-08dedc0e7213
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|41320700013|7093399015|376014|1800799024|23010399003|786006|6133799003|56012099006|18002099003|38070700021;
x-microsoft-antispam-message-info:
 6ozF80Ut2+hjaoMUxK92+uECwh85mYLdi6uBEtxKIg43nPNTq0tywDPnP3Vm6YflcSK1+GURFUZJ/NS+H7A3nty4qI38AB+oiJR0jOgKI4LdnQHY6dp2ZY09wNDY2445umfLntJiUXbYNCIML7MERtCLDf228OLPlPjGxEeZlhO83hwUGbAG66Co5gZyNM3ljw9RCOo6gmDj4mJUTg8YYNf2KPzFRJoiZV3Ab2HfSbQ2hgcT7aGFx+Fi5zGWgAns/p3NDoUrdeI3ZwJM77PUJm0lis8K9sDN23zC9vKMG016BLQ5/VAQMCGbaRMjAKsCqRCEsXSHF5LvUQeZuafQ+dc/QdMt7yM18mqQDMF4fRHebM1l31qAznuF5zAcXMx6ISo6a9llWseYRvFc3Ydj7bNOFBPVIDDJqc9x4sVWZ+rU6aoJPr8BWYkxIx+4HYF6w5CcLaapIH+eIO/f/jBRumsfvHOQ8+HlmSVGGlgGkKfnfReblEB5BLw3oqjUngeUtTjoyGZm1PU9HZZzIgKnqnIINvG2i141CH2Pf24ZyzNcyh5PC0V2GpPwQIRG2ghescefSfnF6tKaF/l3a5ROyxwahBHJTibkWMtAQIO1UyaCE1fA+pSNaFm+wPx/lMhU7vEGGyt+qhf2zelGZt3EdyahNxCnnV5b9tCN2T5a++U5xRP1mk01/6fcxrtjzkEAc8dYr+KzzeBH99BIsDIQzQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4874.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(7093399015)(376014)(1800799024)(23010399003)(786006)(6133799003)(56012099006)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?tW1YEnCBRyW9tBOf20E2tSHF9RY48qgSskS2ROrcYaBaTeFyNGuGB3aL?=
 =?Windows-1252?Q?91E1bQLGX3zxTV+O6u0jOS6ma+PtDVHsPM6nJB7OcmryCI1wxFeYrUBF?=
 =?Windows-1252?Q?+NmfE/wlDmi5ITXzOePcqeeDDmpyOzJ2XPCpEylCatVJv5whn7NJB3EC?=
 =?Windows-1252?Q?A8ogJcY3tarPnIm9Gul6PJ9gAorLKJeDjzwKqttsjUvzNV0j2zorUB7U?=
 =?Windows-1252?Q?mseIbg8TeJf7ZMj83L5ZQIA3Ur//d3nliHZu9/ol87HnSQVqjYZujhj0?=
 =?Windows-1252?Q?eV21kiU5iq2oTToNYGVuXnl/AbOEyfpaQR7MTDSbzEX5LYqKGTPwIFe/?=
 =?Windows-1252?Q?QOtjN2RwAreVBLr+MftWuMNj8TJ/ow2Sy68pm9Brmx/DgIvzFYgKnALu?=
 =?Windows-1252?Q?xvgkkFRs8sSHR0I9LdRfnWFi4/133N9bQ+bFQQ0ApC+E9gyeBVXy9l40?=
 =?Windows-1252?Q?H1ndEfz2RcuO/rL3vIRYg8Y5Lbc/IsMzn11SxMBxGOIwytc6s9DgM9UZ?=
 =?Windows-1252?Q?QG8LoG70JeAXcv06Qs1bSFiq9nFDifUlAnSN+jbvy9Zd4tKlX3ZoFlQO?=
 =?Windows-1252?Q?6YR0pv9G1sKlKYKIx+E955XzorCsC/0/fpQ48vgDwmNjYLLMbYbJzdgv?=
 =?Windows-1252?Q?/R4Y3s1qcw12iwlN6rouDuDmhllktPCEuSePwHQ5ORLeWBimg/iIYz3q?=
 =?Windows-1252?Q?kGCmY5yfA4Hz2WH6QIgKcrDEC3GdHJurX4PUVoxedXx6yeYPBtKZknxO?=
 =?Windows-1252?Q?Apo8IeJJ1KZWnsKGq0de1yftY0FvFLftN7HIfMjDSkD49kcfp/aF7z6q?=
 =?Windows-1252?Q?G+qpoLidHxQbrd1NRpF2RrNn6V51wCUox1DQVnQyThq0tQZi3jLJsWx/?=
 =?Windows-1252?Q?NzO92uFMEWDBGtlqne2Ncj6Z6NkkKjH+mQRwAYZ4mxkbVzkhLF7QYxvR?=
 =?Windows-1252?Q?BWRnUzY9EPgVVqJpmpWfg9qWriCQMB2mU4E/KNOSR8N7QBTOcXtJKf6K?=
 =?Windows-1252?Q?fzGO2esCgXLXz7Zr/nkrM+y2kta3Lt+KAqtP8nYISioM8CAm08sgKct4?=
 =?Windows-1252?Q?UJyW73wHII118v9kjoBxCvCYveNfVsCfMTmLhrjW2KGkpHDyKSpekQoK?=
 =?Windows-1252?Q?CZZw3I2eWWserVCh0rFCCco8+cEYDNrEr/NkFhgGk+RXdLZDuO6sGNRk?=
 =?Windows-1252?Q?w+3oLTQ2TxtbxUxGD1NpjZZrNU3lteMonRAN6W8lKOBKWH3KvaLEzqst?=
 =?Windows-1252?Q?drpvWq0E5RvxSm7jR6HyCoPnQMenFAPF8Ja68eSbvNKDu1TtNhgW5GDw?=
 =?Windows-1252?Q?Q2xXaIIm/4E8n/fA5bUuUWJsOSf8eeN7rS3KiFTic2qyod2zqU66E7E8?=
 =?Windows-1252?Q?gxpwbKZEj+r1ICBwcuYnY2E64CXHwYAnE3JXHGIp6GqiVgMn2fhGrnDm?=
 =?Windows-1252?Q?nwn98MX5w8B8KKiy+tjRIq3pytNFzaxXgYiQ/JB+9WW3yHGiXs/nPhbN?=
 =?Windows-1252?Q?XTrSIqr7yhfn0evUSap9L/vR11OO2bVeJIIPFhcmuwr8Nh7yr5JPSYsH?=
 =?Windows-1252?Q?xjdZQ+tbUgJS05Rb7JmXPT/GjSSArQMd8M2jKSUzA6z5D3DAy8CBTkTz?=
 =?Windows-1252?Q?p91kZlau5T5HQEIuueU0hd3qX93I2+VhTQ4qsyrsGja5/VDbBk8orpV6?=
 =?Windows-1252?Q?7duU1X/lVS5A5XWs51sJplQxHpTz4mJKVwktTVcuqiT6mXcNBOMidcZK?=
 =?Windows-1252?Q?iZkKmlvl4P4b+McvOZ9ghdo3rcFOyiwzcTKFl7fZK6/0+sUJ+6ES2WNR?=
 =?Windows-1252?Q?5os8od3Cqafy8SGhOsAC+onueZV63bCAkpA56PBVLB1zmjWm?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	KDb9ytHNWnYjUI2nLCWHEEmXeBBjLX7nJYeQcbIoax1fPY+almbdQ8VGHcIu5oAFaYuROPLu4JfGoiC1UAsC2Qo+Vu7NI0VtgPxRPsZd/IpoPC44mZVj8DsyZqCecpVMAcfj9X0vMZIHdJXORKGxrvIW4cC6vgzMVgOCYrUx/nPVhUoD7B0RcAAsorFGDblxt9spfRzo4QS8r28n+/OgUMeW0Dp3wxePbVPyEkRp3rwa3gYf0kSuRbrz+uJnps8pSeWIM0H36q5nhQjDUvwDit92x1fbMza4/yuCHWnCScsq0OY7jJDL68W/6h6BoOghCiOSIi/B9K/VnF8FUu75UA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vDMx7ySeNaCX4BSc+sGCdviDXB6K5nx50NTDh1msVOKbuQINNj4oYPz3h/YXczBl9/hGa26KNNe9VgkjGkdsvGkq5T+Hkfs8e1s6ltVPzNtPNB3+pljM0tmi2qTzs0m7V3+lPn2uzZgIObpu9sM4JzZwZToW6sfbcujsgbOno2hfgtsoZOan2kkmxVWTYeRgItKDUyr2ita53rMpLLBqpAEGfc4IogbaG35RqeGKp+8Vkjcs8X0yRg5MAz9vxguN2CvGsb52FLoTdm2mJYjBNeivlY9NeQphUuGBLVZu29P3awrZvcLoCUVQLlHBJUwUY4oemkIxzRtXk7DVI3eltTT+8X9oInEnvs/vwrDMbTahpIREWMRo5ZJ7aQCqj6dDC5JVIBkaGiPOXpPrTYHsKzxFjKybvVO12eSoiMFqSqWiJ/NQI/uRhXh6c7gHihNGJiokFrHqxNZ53rdmFpn2IiBpjXVygNSYYufimn/+pH0AfPOGkoqR0L7rnaHnpj836htaIzGLMk0x1H+FZjTHmQI//OV0402+dYTG/L/e0LjmduU9wH7j4/g7CWVVo9bm68krQPPgeH84OnCptyI/TjVda1Ybm3hjwsAeT5odUD2HnppN3kisSlOkrX1BqNvtjV5Z6XyBCn5QXwi8K+Dh7g==
X-OriginatorOrg: nus.edu.sg
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4874.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa71042c-5dbc-491b-91a6-08dedc0e7213
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 09:59:33.4678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ba5ef5e-3109-4e77-85bd-cfeb0d347e82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: baMqoud4B8IdEkDCTcBr7WH/74Ws/zLSJ+6ej+bcU1bbLahxV4tws9e0lTLINxsh9Vi/DRokkH7bntG70OOErA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFFDBC8F9D9
X-TM-AS-ERS: 40.93.129.55-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.2.1014-30052.005
X-TMASE-Result: 10--67.193500-10.000000
X-TMASE-MatchedRID: fBxQJOBGcyWBbasXMi9E9yRFbfQbCufdV8cENS82GJecU9LnAKOkdroU
	gzTWyObm+KyoVBuWVD9XZkvct74o37UNV7Kn72M+FmKaWvOc3WBJnvfeG6RJLES2aquVye8eM1C
	0xtyQLqijw+LKypYdWs8iiKWsBW8Tgq/lUeHrbDZOt04VVWpqKcAS7SmLvGxLhFVZHLNAxumaiX
	NQ4kfqiNiach3wSITUGKlUCXb1TrN8FNpY83FyAjmoMBkrmuf/mCYM4MaoFU8mx8kl1Wnd+q+eC
	SMeOiOkwAeo5So9OjoZNmx/p9DKJ4J4BkjbDXMnWjsaYI4lh3U7nRP0DvgcK9n6VvkE3C9/Vgde
	V2vJIbYeYmKeeANnvhTC68hMP0aAIwKJIpXd1zQPJzPoZ0tNYjwgKE2V91O/
X-TMASE-XGENCLOUD: a657dfd0-9b41-410c-85bb-d208ef4c1099-0-0-200-0
X-TM-Deliver-Signature: 8B984181150EC1CB61A60ED24610EC93
X-TM-Addin-Auth: BpWJB6UnPNtooE8NEXYgEuDpbV7mM3LS1BalfphhMhib9DrwGMl0mzFgEJn
	o/rxsafhlwNPsLJF/u9FoDzjKnK3slr8SC+wxT9kzIUohneufdLAzGdSq3ZwdPObHFU3B+ey1v3
	cOaHandVR6Kwfqq2Sxslrvx6Nujn5zP0ZVVGAbqQ4ogYlXsD5lZyVohWjC3MWKlcdlb6qMmh6kG
	XnWaVYkvi/6XFr/vOF54YOYxL4OaKzmt+E9xP/Q11P4g7JU83gc+owVWXhDD+ZGtiSBO0kpngoG
	DUyRsTrxX3nGpsqIPnDur+FtWiF1LXO/HhNL4l1rCfpBSYZwQN609FlnoXBxmD480u4p/10T5yP
	Hn0s=.SyQS2L7DBuNyuH5N79YFdVJiMAUiTRIDHYLiqvztmK4KgLYQLeVpkQV4ctQcmBpUfuooC
	biNVB2olvAS6BFeeK2xuVxiYusWSF6zHY+mHzGsnZ+IpLTSPAD0vk8fR6DnDBnTy3s45/jJgGbc
	6QaqF8gXuFW6PVInejv2N9enfXayMqKEf1vPiCrx5tyY/HHa07VT5JsmNcxFphJE7lruELWytKW
	IyjhE8en5P2fgggBp+yB4cgz0PZHoYObXHu1FCKtn7Rr1ir/ulyw2nzLuZemO/E4qdCmRkDiZzA
	jwvas6dWkvZiasoPy6SGHpI21NVtaRGss2KqcswgJszBTC1g==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nus.edu.sg;
	s=TM-DKIM-20240902111054; t=1783418377;
	bh=bD400y1893oiAcPQB8yMDzeaj6JthhGGL7bvxzOsM6A=; l=1260;
	h=From:To:Date;
	b=j9eg7DUSlBPB5gQAet3+udM+gVSLaK/XbP+Syaixb3VdVaZhAzQ3Mk0DQuvfk1HER
	 L1xTZjtcRHzTnnaHz3p2QvOfNdg1rge1O9QnlLaS9lUgKG+oaDjKqpGLuimqgkF3jD
	 +6sIkOGPTPVyKxIfUNrYYNCkAd66kuVIXXypLtp+Tf4aEWeF9mn+sfXuPdCzH52Jx5
	 SZlQm3jzMQiRo07C5XExbV0zPOZ4rXOa8Fq3EU/1R9tzxoMs0UqcweI8AnMzBDI79Y
	 LJbPkX28ENTFszwXHSnwUlbkO1dPCnNRCXZZVVsWHmDI/tmEljXIi9vaYOcJ5Qwyde
	 +I/clbxPilhQA==

Hi all,

A DCD lifetime/identity question. After a release/re-add at the same HPA/DP=
A, the range is identical but the grant isn=92t, as a re-added extent is a =
new allocation lifetime, which is a cache-invalidation/audit concern for ho=
st-trusting consumers and a trust concern for confidential guests.

For benign hosts, is there an intended DCD extent-list generation Linux sho=
uld expose, or are uevents + sysfs rescan enough to catch release/re-add di=
scontinuities?

For confidential VMs, a host-maintained counter is only advisory since the =
host/VMM sits outside the guest TCB, hence is the expectation that CXL-TSP/=
SPDM evidence binds the allocation lifetime rather than Linux carrying a ho=
st-observed one?

We have done a quick QEMU repro where capacity is released and re-added at =
the same address and the guest reads different bytes (A then B), showing ad=
dress equality isn't grant identity.

Kind regards,
Flavien

________________________________

Important: This email is confidential and may be privileged. If you are not=
 the intended recipient, please delete it and notify us immediately; you sh=
ould not copy or use it for any purpose, nor disclose its contents to any o=
ther person. Thank you.
