Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2102.outbound.protection.outlook.com [40.107.244.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBDA13CAB5
	for <linux-cxl@vger.kernel.org>; Wed, 24 Apr 2024 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989780; cv=fail; b=Ss+U/L1KfcxpBBj64AtNLdevipOX0v5AMRkKuqopsdbiNlQaguzNb6r7polievd0h1moH3PFJpDIqWDF+JPyCcwvq2Agroz4cWFrnW3toH7JKRTdzxhHtBvLUf5ArQZjhwcyH2DP1QqzxQa/gVNzxulzYg3m7ONPYsIDFHGuLKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989780; c=relaxed/simple;
	bh=4bugJWq0qESiG9xS7BPeb9+crVsDV2CnW1CwmKF2IXo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PuIlmOxuFddNda9tNxeVuK3V5ALdcBrgkUTebJanEkpb8ldHW3E/ADImbbuRuzO+3FQ3FafRdhrg5M453fx+fyZyS1zdGy/uEsX83tZJ8sI2VLmXvNK4Z4iAPC86vUXwMcRRjKYMOwC0A18WRAheA+Y7DdcdpB63hiW0aUjqHPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=fJL8AKLN; arc=fail smtp.client-ip=40.107.244.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="fJL8AKLN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NH/gBVMM6D4iaa+6AOuuVqgWxH2xaJkNnJ1rqqAVIP2ULJfp6jeuERG3QFC4lUzA0souLrgF0Lnfw1qLY9lZVLf/32UADWBNQEWxf6R/ALXATbZmQQCAiO9MpvJngE3En6YSBvzX+ocL3jLEd+sz3qkZDG+I708i0CUJIxwdVBA53oEEiESl8h6/DvF5ZmY6JbPis2Ie101/Q5wyyP1jth1ME3K7QaC1lFJZID4k0hnOsDmLrpRkQkL66sASwYMAaON2v1ttM+mjmc5EsEJc4dSJKEXZXES+9YRiBWvA/7n0Ligkznh6etrO97rVJyqw0xyrocz2u67lGJMtAStuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bugJWq0qESiG9xS7BPeb9+crVsDV2CnW1CwmKF2IXo=;
 b=RrYK+eOZc3V4Vta5tEBEMILj1/PNWSnXR6zvWDe7IJcZT9bBDrAuBAlIZJ7ITKCmN1QLTmj8Z1YBRrBW4YMnDKeWKW4Gu+nmpu9t4dKLH4WFcxiCmAHQRtscqUhLWzi32B+qa7Rz4OEiETS8IpOXWTUwr7O7wZUyzvm8WzvBusDuyySgYh12oHgiCYx4+fekh7uZFOaelD6EFxwOxXeyoKDgrj0oDJ7t7axFLC4w8bE4YXE8LLk5t1xfOod/JaiG4mV6KSp4lPgBqNOvK+KXNDfFhLk4Fw0qxcThw60H+6bCZGQKbnwHynk7YuT6HgF4HQX4dCdmG+On1BvbfLqqLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bugJWq0qESiG9xS7BPeb9+crVsDV2CnW1CwmKF2IXo=;
 b=fJL8AKLNPnUWtza40Skjg2mZkmP1hwoAludQb+4BFNPb6YGtRvdqXDNdxgL8yj5Js61aQoIEt8g+lfYpangopZnJGFfze/Dyjb5oDF25RCNxcnXNrz6tVY0T8Ke/kR17SO2kSWBoKiR3aJ9Cn/tPFiD2z5ckJq8jxWJ93ByX4eU=
Received: from IA0PR17MB6347.namprd17.prod.outlook.com (2603:10b6:208:435::22)
 by SJ0PR17MB4525.namprd17.prod.outlook.com (2603:10b6:a03:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 20:16:15 +0000
Received: from IA0PR17MB6347.namprd17.prod.outlook.com
 ([fe80::200e:df84:29a9:8c9a]) by IA0PR17MB6347.namprd17.prod.outlook.com
 ([fe80::200e:df84:29a9:8c9a%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 20:16:15 +0000
From: Svetly Todorov <svetly.todorov@memverge.com>
To: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>
CC: "Jorgen.Hansen@wdc.com" <Jorgen.Hansen@wdc.com>,
	"a.manzanares@samsung.com" <a.manzanares@samsung.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "fan.ni@samsung.com" <fan.ni@samsung.com>, Gregory Price
	<gregory.price@memverge.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wj28.lee@gmail.com"
	<wj28.lee@gmail.com>
Subject: Re: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Thread-Topic: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Thread-Index: AQHaloRCv+Y2b5YHh0S+QGF8zUpElA==
Date: Wed, 24 Apr 2024 20:16:15 +0000
Message-ID: <7489170B-E7CC-49BB-91D9-DD6497F99E23@memverge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR17MB6347:EE_|SJ0PR17MB4525:EE_
x-ms-office365-filtering-correlation-id: d23007ae-4488-4311-24d9-08dc649b6508
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|7416005|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?k+oxjnZIzvGUi92Vb2Pwx1lwOkLw+PULXHReCAgu5UPfU+M4qnm9xyGiOdmT?=
 =?us-ascii?Q?pZYWynw1EocKZAj6Gd7QHrgzD2pi1D3jxHhTssNAnwDxZMDb8gTMgddfMNA/?=
 =?us-ascii?Q?D2eog6g8bUfQ6ll7tNtOZZo54SjIYARQNoV0DGj7gRlezmWN11BHrdcpIbJt?=
 =?us-ascii?Q?Lz36duCvpTxocRtkZkQw+gjJAo+9hXDsDZskOETwS5Curtp0AC5+7aKOLcTz?=
 =?us-ascii?Q?UMBFm6oL8yOUqBuuPRQi5mNZGBVIVz5wOBidYM5yW+jqQkiSUO3O6X7BfXZk?=
 =?us-ascii?Q?pZWXPMFSbI9P9nMUICkGCgB8NpVQkVT43APj8ywjoX3cb4bOBnvqhUTDflDs?=
 =?us-ascii?Q?Kgq8XOPsMEKqoLlMJp6K/KHIovD/h0Nc64VcGXMjprjb964Vu7Ho9O641j4C?=
 =?us-ascii?Q?UCjAesUXUc2pLALYNVZI+c99NJYblVxW07SWOGmKW35sY5sroISRKkHv18ey?=
 =?us-ascii?Q?1PyCWNZgPPQK7Iiv4wPlkU9WLgwQ7VF9nCcvNmUs6eO0sP/3lNZt239b3P3M?=
 =?us-ascii?Q?DLPOCrNAPybH5tNCHPSP9OBv4DCGHbs7R9vAhyunYJtARri2/ldNIJH14kTc?=
 =?us-ascii?Q?wEPzuiGURftbO9ue0+cEFG9NjP97AX029auWeplNJrhqXoQZrhu7mUyqnR4Q?=
 =?us-ascii?Q?nTEzwYcE2n2DYEOeWWCMSWxYA6wxWaP6gzh0KxYRFfeuc42qXO945kBq8zSq?=
 =?us-ascii?Q?9TzKeM6pG+iDatfpKBehBUYo3U+O8sluoN3EsDix2HU7UOmSLE2Bg1ytmzJg?=
 =?us-ascii?Q?kvGI2CnD9bcTCVFRhAQLvQvZsSiLx/WfOPtMbjTCcFEFNbujmelDHLtVwZGk?=
 =?us-ascii?Q?983hvQa2HZgbDxmjDbHeyrhKAphcMUyF7aBRQnIj0KrmEB4vqp7izpbx35nX?=
 =?us-ascii?Q?Cgdd4XiAyhEWcGl6UoxQseNhBcxJQIKNazibz0cRDA0O0lqwni5gxhG0weJ7?=
 =?us-ascii?Q?ublVj6PPHE6hijpr+GLwrv2E8F+aFKycZTyVhl3NcY2fPlhwQ2chie0AN9Fs?=
 =?us-ascii?Q?NFxCwcZwYIikokT4NdQSGUhhUg977haO8isfgwF9dZsAKvnhIOBBvVs9FOwY?=
 =?us-ascii?Q?7XhxKkKzTtCEa//1KikywHv5qujiDRCjREQWRxw32NzjKJNMvmSixqBELzQX?=
 =?us-ascii?Q?8tr2xUVzsENGAU6/RfNkAYkOdMK4IC2orA0J/WvKpXWCq1aEDHJGE3sycL2N?=
 =?us-ascii?Q?7nKqpyQHokU5UFe6B+OAWXnQvQGnQsDxgAjFXF5VrLlg/ZCWRThJQri8f+oj?=
 =?us-ascii?Q?ZqsrqrK60B9Iu9JrW+K2o7ziBOuBiGWAfOOT2BU+0pwH+MMUKmHRVhyklXvt?=
 =?us-ascii?Q?7ArmcwXR5t9pslKHcyjtmwUvGMYJtKLrMiCkHQIgXpkOXQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR17MB6347.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sC9bSlT5+hczC/0hlPxmxSzpxmmgtOALbpzDh7nFcpz2zo/CIu3hAEkMosk/?=
 =?us-ascii?Q?/tPW0g2Ocsk5aiP1rqxCxt3wP1C5ZAfa9iZv3IBd5RMxHRoV3d9aYe7Qw0S2?=
 =?us-ascii?Q?z24nRn6TaIu78Etn2GZZdZ++6Tnf/QcHiAvCsAJ8zjEPMXL0tEMCiORHVCDY?=
 =?us-ascii?Q?3RM+8J7VZHUMa1YRbsq0AqutO1oMoA86sbsql/BuQGoKkSVA6shT0R8CHqYU?=
 =?us-ascii?Q?84xNOx3s3nNtKS6muElyvdTW4+W27Eo6vxok5hrmui1c9Uf++l22hfkXOvdF?=
 =?us-ascii?Q?IIjZHeZ4CFPX6n6cy4QBbAZ+C4AmoTukO/h5C0ESWbaYUn6ZJSxA++HJwMVc?=
 =?us-ascii?Q?weoR7XtBaS3sVnjHdcqWhmbdQP48d1LpHD+h7lBsqGIM0oqVk/0xPSuul99P?=
 =?us-ascii?Q?kc8feZ18+OSY8u/iYamWzp0Z62iibqE03Jpln6+JihJ2Di525Pezwm6OBP3i?=
 =?us-ascii?Q?KBVjOVdr57NzFvR7bFqnv4bPL3O98CFf0d5oaCigI6heDHE3ewPan3lrsjGn?=
 =?us-ascii?Q?1xxBwJGgZoDDAuyD1oEHAY5/4c8rqqMbNR/ntSfUNmw688+ACzcG7wsxnnXp?=
 =?us-ascii?Q?uN78V3O+LoeS9d3tgzpu9rf75CQQAannXdschqL1Edq2XQBqHRZOfAXoPq0J?=
 =?us-ascii?Q?0MDXDQJozO74rdOqzgOhEuV5qW+hd85Ss22KISQO2eboOtrtAySpF+UPRINn?=
 =?us-ascii?Q?4cQMhjfi6Ww/VOEAcSBomsZXcZpQzHFD7Upy02u5yN+vxmYiLaQDeOHNEGWX?=
 =?us-ascii?Q?Psq/HnHQ+7Xtk+M0gBDUCoJnIcno4Nxj3XpZj/QIMhmLUVyxuRcC042chGi5?=
 =?us-ascii?Q?pwnHlHP/Q5tD2/+DaaRpeXtIAmIRF92WGbB7kyIKaLG/N90JGgVDdd+fRxoh?=
 =?us-ascii?Q?AMcxOKQ7CcmxdmvQOmNBJ2jLN2I/jCaKu4OWdrKUtR+mX2gq3v3tIltAZP2L?=
 =?us-ascii?Q?FJOcaT03bcZv3YduxYD+IMeBT1u4qzWR/K31nVgNguZfR+aQvGqdmRC8TWvH?=
 =?us-ascii?Q?Eqbjf7F32LGHzY02dS8P6WyLz5ibUUx6WHrIi0H7thPCCTVJOke1DRiyRTGS?=
 =?us-ascii?Q?mkmYLyNcycrAjOPxZ1j8QzTE+o9Vms76H18MW4RNUVLv1uSnhHjEG3UMruGC?=
 =?us-ascii?Q?J/7ftruqml7mwIN0VUC3awiXkQnPAHSxIs+gBc7rbOlBIYq6kPnHFHu4wRNt?=
 =?us-ascii?Q?0jXrR1G/CZohyYK1TfXmkQLpbvXFwFq6YkE8mjR2dvrOSQKT3XV5MKKccd/u?=
 =?us-ascii?Q?Dyr6hB87qO83BV4fAQ4CTOMdRLOmHU4cuwW28URL6batwmLASOSym8Bkkiu1?=
 =?us-ascii?Q?UTBmmkTE4KxtUyucQoALw++IE9U6Iqcz83pCl9NFPUhiSXo/I/McT0afrT0N?=
 =?us-ascii?Q?j9+cksBLK19bgTy2Kb7SxKQvSDspW93FSLFEjrXMB30QoLKXuKC0f5prJDrV?=
 =?us-ascii?Q?SwPS59WHjSD8I6aBwt0+TGfVrjEhc6LdlxAlWZp0TnpygFVgjxeG4AIo03Jv?=
 =?us-ascii?Q?J/ot3NlaBYvrgBIdplXjfFENDMlVP/owFW87X4a123oG0dgPmvOcLJ0eOzgC?=
 =?us-ascii?Q?1grDyN4Alz3oLp7cXdfg33YG3LTTwlzpZC/l51ApQH/fmLwNLt7EY/T1RNKR?=
 =?us-ascii?Q?lww2Z1l/n4uteULvxnG89PLstH/U28EF6oKAEySkXVqx6qihlMYsqIBGaG03?=
 =?us-ascii?Q?2SPAxPsHp6pOgjyX0yAYuWKOHg8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D2594CC892594443816CE0E027F6ACD6@namprd17.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR17MB6347.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23007ae-4488-4311-24d9-08dc649b6508
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 20:16:15.7286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lQ4ZAm4Ety7nqRv/t8QacfaHNc5r1+ettVXIZLyuXiEoY+A6bs6qS/lf1OJpzrTL4+CRBH772NuiC7jWI84NDKr9S1Rt3Y286EGwN2b00Ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4525

I tested the v7 DC add/release as part of the MHSLD RFC work I did
with Gregory. Those commands worked as expected. Feel free to tack on:

Tested-by: Svetly Todorov <svetly.todorov@memverge.com <mailto:svetly.todor=
ov@memverge.com>>=
