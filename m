Received: from refb.tmes.trendmicro.com (refb.tmes.trendmicro.com [18.208.22.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DD93E6DFF
	for <linux-cxl@vger.kernel.org>; Wed,  1 Jul 2026 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.208.22.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897107; cv=fail; b=iI941lktmYEsApzg0U/1fX5QYPq8J2sbctPvGaFrcYd08cdPzn50XIX32RBI+7qh7Udt1UZLOVCis+3V85ahsZD2o8UlGlHR9Ps7uA7l0pZU8pOzjXiBcRgX6gH2rN4u+xkIfsbNkZdSybUSjTpv1Wlh7lHDWpYGaa6sf6y44LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897107; c=relaxed/simple;
	bh=GHKBAvW4SpSEJYIiJxTuWQ6iTPWQMu3nb60w5kAldrc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BVBaUUXDRw35Dgu0cSHu54esJS+GN5ywG1NInbGkOJMyU16Flmw+g5LSGr+unR30LsxQLD/u6U84PimeKoCsOH+MmoWqLtOF2dq36rg1T5yDdADCxWs8Ou34GNl1phCnN/Tha8fhha8MnEql+aP/8KlWPH1mYHklLU0aEWRPp48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nus.edu.sg; spf=pass smtp.mailfrom=nus.edu.sg; dkim=pass (2048-bit key) header.d=nus.edu.sg header.i=@nus.edu.sg header.b=VWf1zJrs; arc=fail smtp.client-ip=18.208.22.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nus.edu.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nus.edu.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nus.edu.sg header.i=@nus.edu.sg header.b="VWf1zJrs"
Received: from 40.93.129.97_.trendmicro.com (unknown [192.168.10.215])
	by refb.tmes.trendmicro.com (Postfix) with ESMTPS id C4AF91038CC32
	for <linux-cxl@vger.kernel.org>; Wed, 01 Jul 2026 08:49:03 +0000 (UTC)
Received: from 40.93.129.97_.trendmicro.com (unknown [192.168.195.221])
	by repost01.tmes.trendmicro.com (Postfix) with SMTP id 2E06C1000072E;
	Wed, 01 Jul 2026 08:48:57 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1782895735.835000
X-TM-MAIL-UUID: 34fac358-d8ea-4afa-aad9-053219f577b3
Received: from SG2PR04CU009.outbound.protection.outlook.com (unknown [40.93.129.97])
	by repre01.tmes.trendmicro.com (Trend Micro Email Security) with ESMTPS id CBFA5C000434;
	Wed, 01 Jul 2026 08:48:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gK+5TdA8XZfgYUkdFERKtKAZWjDA8I0x/41i/uE824u/AIzMokjL3pSXTupkQiMfrNxg65kArlu9HtnnbMPiAlVez7v7Bcqdn5huT/AKekUnSc0RrxKvBvhCSs8AWOg+6NivhFx27VpaAK+O29FuqwDOxar7R/4OGt+Amn23gQq22l61lQhP35unugsr5V//Ebrf6n8rhM/9ZE3RQcLo1o1Jvr3yQEUelg+kGiBfDuSz0pnV9/1cY4J2PnWfzbRDGol0LLXOS4qx9LDKCfqQlm1vgPdyuiWpYErrpPksgg0lfebRGJtZvFu7ZHHB5eJ8o27fUCK6ZEHgNF4LRqDnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jYOeNtoAC/Urn6wHiJnX2whErqbBvir8ZQPu2fDOJw=;
 b=O5yQ6ZrnouFBxjsBhF984fPkr7F+j5eAEL/2Pf+LWC3MxyJxf1Ay2s1cEi3gSlxfaiC10n2EAUHt/OsZqIc+iQjA8GxZRQaba46oNtxXSWidEFdXvBw+3QhcZUax5uHGf0KpXOIG3sEJBTA5N5UcxJF0zGzRHSGFUcAXytPFAubz/m3bppPSWzW4sO+9YPnaPre3Tl8mddjMVTG2rKNW5m+tfMO4iAevSGHjocmCwjsHZ2q8UBSYnBOpQEe+ng0WKR9ybltmjsan4XWju277/Ysckv1p9TqAJR5luTw3M5sLQgUC/5M8mNVGFrI8GAtEIrQVzi+fehB3AHLqPSZ70A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nus.edu.sg; dmarc=pass action=none header.from=nus.edu.sg;
 dkim=pass header.d=nus.edu.sg; arc=none
Received: from KL1PR0601MB4874.apcprd06.prod.outlook.com
 (2603:1096:820:a9::10) by OSNPR06MB8372.apcprd06.prod.outlook.com
 (2603:1096:604:487::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Wed, 1 Jul
 2026 08:48:53 +0000
Received: from KL1PR0601MB4874.apcprd06.prod.outlook.com
 ([fe80::60c7:8fa7:33e0:57b0]) by KL1PR0601MB4874.apcprd06.prod.outlook.com
 ([fe80::60c7:8fa7:33e0:57b0%4]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 08:48:52 +0000
From: Flavien Solt <flavien@nus.edu.sg>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "fan.ni@samsung.com"
	<fan.ni@samsung.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>
Subject: [RFC] cxl/dcd: clarify extent lifetime identity across release and
 re-add
Thread-Topic: [RFC] cxl/dcd: clarify extent lifetime identity across release
 and re-add
Thread-Index: AQHdCTYlLjrK/zlyEUmiS46TNSzerA==
Date: Wed, 1 Jul 2026 08:48:52 +0000
Message-ID:
 <KL1PR0601MB48740A722FB74B7EE10ECA988DF62@KL1PR0601MB4874.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nus.edu.sg;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4874:EE_|OSNPR06MB8372:EE_
x-ms-office365-filtering-correlation-id: 37e39d92-dcda-48ee-c976-08ded74d9403
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|7093399015|786006|41320700013|366016|6133799003|56012099006|38070700021|18002099003;
x-microsoft-antispam-message-info:
 kHUAEyD64H03TCDbOmhsYUpaHRIZw/0uaMwlda/ISrno5b5kKQpChO9uFbZeprwNLo7gG5vQyNWUF8+TkcY+7oTU0BX+3y0ELwmxDK5Qruqq6eeOxNA2V5REnH8WuA9oBib5O3/vQh7DNJDU13DKJ33KuqYBj6NbfFfl1/lOpnqQ2aJEZwQxocTXB/SkC2XLL+2Tlha2RUyx1zrk7OyJLNLb3/u9O9E+nMXj85HXQnl+9X7UJdhW2DLmA67eBzGDpsppIFwQvOBxCtUOCme31g/e4tlTKzxfcNZ4znwBoTAHD6ekWbZCxYmDE/c37iwl4yQgw+IXqec5JLZLynRdckkU7OL3wHosAhgqIe0018ZEaN/nfPDlczxCpZPzMJFmYR/G/ld8WxFLSXf4ujyt2ZG9vktqEEFJHn4uFUiVmq2cnmh5SQVRzDME14KAekhkoCIZ71i+3L4HYcuSLahL0dX79S5vy/vOC2l0zUsc+2TPZr7+g44QvXr2+7/MtXq9KtuIZbMWXaq0s0QxEmLQPok9B9tO9fnApWnV8cndbF9NJekF4Y0GK2Qq5Dg8D8HfNLB9OOKV8vmPTAhtTuDlHSjq0kzZXgOw5iTBWBfF7aWaShWQB1sYQsemZJp/XXRmIo8TjzwRAyrd672mxhLEnxikI3QW3cYxoIF0gGYAMNJKgITujeu74GJyKy5p5JOUpEfr5nXtI9Aj7/zAu6aTpvyjLwQlZk5zyFuz0DbX8ms=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4874.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7093399015)(786006)(41320700013)(366016)(6133799003)(56012099006)(38070700021)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5JTXjMXhY00p7MRk8CDtkABM5I1tPCc3LnfJYD1K/qAHDLhnRD1Czia205?=
 =?iso-8859-1?Q?IPSh8B4xdS7oi+gxHj3hQDeDJraFLNWWCoLcd+nEBppUFXOA8TuMbQ3yFv?=
 =?iso-8859-1?Q?08802VnfA9b3mH+z0PCZuhSd0e5JCCHzQDB6gs0Uv/nbg4lkAFBxdNbL6e?=
 =?iso-8859-1?Q?FwCTNJRQVAsrTWjcev8LcX0Y147h2jcLQtr79Tslgq+TpGnjeJw549Yjk2?=
 =?iso-8859-1?Q?k0dLzKjC+Sufjubds05Gzl0lhpwhOa7kXKSXZ1zsRvGPXHETXSbxJ/pBf3?=
 =?iso-8859-1?Q?TEW2SBIl364/qb52O9BQ9CeiosW6oudUfjA5yLCR56v4AU2P6yNdCwPmT6?=
 =?iso-8859-1?Q?6RJqyeGne9cdiSeoIEqfNFwyNrcBLyxs9WughlFMfPFzBXSkdQALcmJFbi?=
 =?iso-8859-1?Q?4+TUIy4QH+VDzEgpVZTK5o2706GpaJth++QoaISD6hcaF9lQpPYoXwTiuC?=
 =?iso-8859-1?Q?Mon4BuYw4TF1CZ2P2xGNcM5YW4aga6wIUEw/duzIdcSiwSUWx1YpcyaIRy?=
 =?iso-8859-1?Q?r5eLG+ZEanSos1kFUevFV/5ZK8wN9oQT5amde91rBCYTUemh8YT6XxfefG?=
 =?iso-8859-1?Q?sXZlqgAd36KE0gxHG86F/vK1d2qr8PHS72WVi7CJQyuyYOmrHX1gZSf095?=
 =?iso-8859-1?Q?SA5VfO/FeoNYbPbe8hPdd/JoIsdIEt0c0bBiY8hvLM9xwQjKPSwTNXRbUR?=
 =?iso-8859-1?Q?t/jDwde4yAdDL939xezY8jeT+aTaVVOiYqqWv+bHTfCNirmhklHFZJ6NWM?=
 =?iso-8859-1?Q?liyTE/yKTiq6pFwwgASkvlumtRW9gyA4Izs8ml9V5z7ADsDiwi8PxtUEyo?=
 =?iso-8859-1?Q?TuvECp9JN0nUmY35GBzY8Mmdz/N+015TBJ8lv/OUtpk0V4grnPYKYXzRJl?=
 =?iso-8859-1?Q?ApP/B9301mypnyagmZ+rChIBR9YInu2HxC8dJywg6nW8SQSs5+CEfToZzr?=
 =?iso-8859-1?Q?DOreMXQ9KPsuaiDHj0z/hgCzXu18di8UkWhTfYHOjAICW5nTjgorktSLNs?=
 =?iso-8859-1?Q?69QlplQ0KVmo/Y7GLsHU/Ql0JSvh267GdOW9Hv7ARd8cgdJA8Gpj2rljXp?=
 =?iso-8859-1?Q?+srYwqfntIJhc5iCm34Ad9YI3HCoPBhciXjySRb+TahR+clj/eyI/3e6LR?=
 =?iso-8859-1?Q?bzNvXxfeqRZfecVJyLXcBBV12XfrWiv9G+c4uC2FQI4sUbwHae5y/8S7rY?=
 =?iso-8859-1?Q?3EBietqJv3kuuhXH32wh2Zk837GYQqAjLymb+iaPbO8XVFYkBsNAigdXR/?=
 =?iso-8859-1?Q?+HNhzId+1HK5jl0IcCjdMzg2uUTvFH/XBMit85DbTMKzFWRILVEWZ5PzDu?=
 =?iso-8859-1?Q?Lf9NXeHQWWOjfd0B5aF03w+mdqYh59mJnEItyL8WAYYjNn0MMSQQOg4gnt?=
 =?iso-8859-1?Q?aG4H8m3pOkPm9BybtENawECX9I9nwwXoc+kk8zHOr2eZT8SDi/xrhV6QTS?=
 =?iso-8859-1?Q?nkxAWnQT40kR9Tb8LOmjh7sYM4uW0nn50rzc4X7/+1D2A8Q6nq55ix2/YY?=
 =?iso-8859-1?Q?xEZaBXigUOAbSxqTk4n0W3yCu4Bcz2B2AkC1G/i/zhYMkvk+SSM8Yc+8Qd?=
 =?iso-8859-1?Q?YEphP5zrAIf8cjijSGUnMb760vXKKdVLbQHaZ5IzjJVVvAdcV2imeh8mVO?=
 =?iso-8859-1?Q?pOJBHrf7E7KK88JNhE01vU7VYSBkNl9rb+tdWz4C24CP0cH3O0EXtH2sq+?=
 =?iso-8859-1?Q?ICwE9LZgRkL6nk8vI1lCm6l5rcgA+y8g1tDaSjYpQ0VZL5tkRo2NNdBIbK?=
 =?iso-8859-1?Q?h1zugjQmrlLbf5bwfnirm9ltTNbg12uVcni8yFysJ3wr7R?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	tCpCwTbzEqo/oKR3SHRVCL1vwMMb5K5T2U87EDZvoHNNuc6GqdQdYO14cObCIaN3vz+vNYZ0JNV6dsQeYyLFOHIuzwARKvzc9G6ks82ESgB07r/Uf4aPz44Ur5XGDHFMOn41z5X5CbvLJD1NIwzKX2mgkHRwtYg7AxAH+yp7Ug/gX77lxrZGPETj4mT6m8Ek01PbJSRtk6LZsrwc28621U/w0csjaitYp1g1VfcxZ/90467w2R9pxjzrWvRv6Y8Op4YGYWdgS6u7fs2gxAwmXGoGZMtUZD4biwh0WkX/gdiOdeLm+sql+rZo3r4olMf4nFJYfLQMXP3ypnTBnwiHUw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lvDH3+JfyvapPj9FL2R4GFOWkksj6G+zRiPlT7AomG10/6whLOiip/nBVTiRpdJCyN1ijPbekoZVK+7ZzQV85iMgB7Yn4EnZjA1JDQnye5KT5wgJ8xXOMzrNCwUaqjcYwKGvd7ExUgqGZesSvNvmaijQ7Uz3WTT8KAq35kMLCPwqrGBy8bnBn0B+K4II2dHIn2GwPQ5OTaNMK8JiJqrLtIiH6sR2FiND+OYW1ZzViXQPyMbGkS52BoDOPrpksCPdaUcwvgBwUxMr3V3tOK8DNgEsO9lhMYl9XLwZhTlS2j+cqNSmtXe9ag0kjQ1WFTE+ri49y18v1vOY8SxsnwjMQMmC1i26dXc4hSmVhcP6ztwLy4gvglPfwCA/BbRA485QlPVdUp/LeW/eVHsMNrkrQKDTgffxTtaDGd1zPO/8sVaiWvOu0GVsPd1iL/4RgSxqZGB4OBDHXPRPGlQJRf/P5Y4xgZ6sk4rvY58PRfEt7NyqznZcyrRethKgxEjk8oUzxnQZDu4lYM44C+GI9A7f+vGvq3obwc2tSOGhIhJx3PW+paaCKuixD94/za3ToqZ4rFSj6RhB5Zwu2bSj491KVTl/ySe5Ivt7Y2MUYwoEBzeXCL026WNI9Bzic95+wR+sp13LhhQhyUqfucqpP3Qffw==
X-OriginatorOrg: nus.edu.sg
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4874.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e39d92-dcda-48ee-c976-08ded74d9403
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 08:48:52.8849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ba5ef5e-3109-4e77-85bd-cfeb0d347e82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pk9T/WWVwiO6k+PlO86au0bVs54fSS1q5Wmk2dp96TLOgcv0uWl2298cf3GOaBuAL/YPXamg0CVU9UD6Im3oRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8372
X-TM-AS-ERS: 40.93.129.97-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.2.1014-30040.005
X-TMASE-Result: 10--73.372000-10.000000
X-TMASE-MatchedRID: h9iwz/ktjIGBbasXMi9E9yRFbfQbCufdKmRbkGL1Yo8krdbueqTnwO7A
	mVtWDTd4gilZC5SKVdxnGbZEw0yiN5P3QOj90+RbSRdVBo/Xo3l2Tr80kEaYUJGeN+9dVIq3AwX
	v/RQ5MsXQ+unnZXoAgCpXJJ7HkiULhWxAFcFoDTJbLHSUK6sTGl4hokZSGr/JeaJoYLvrYJysy/
	AWJZ2mymNrySvLHaU3R1ssKMDNxzTQ8vrpf8pE2BZimlrznN1g6lNc79b8EeO7MwD7Ay9wIuZdN
	I5cmL7Eo8PiysqWHVrPIoilrAVvE4Kv5VHh62w2TrdOFVVqainAEu0pi7xsS4RVWRyzQMbpmolz
	UOJH6ojYmnId8EiE1BipVAl29U6zfBTaWPNxcgI5qDAZK5rn/5gmDODGqBVPJsfJJdVp3fqvngk
	jHjojpEBeuUHajieYjeD+F5LMZVc58Sarp97J8xfqd/DJ3ZyaoykLzn+pa6Q+KY8fb+Xc/gaF9F
	vVOPwgKaQwhf4gG6T8jp5SwcAEe0Euk1VT7Z1v+M+ruG1PNjM=
X-TMASE-XGENCLOUD: b55ba62d-b71f-4a0d-b45a-91e9849b44e1-0-0-200-0
X-TM-Deliver-Signature: E059D5DF6606F8D1CDC005F5B888E44C
X-TM-Addin-Auth: kSeikZbcKRvOPx43qL+XMCmoh6ZlOALw1QGEl9uA3qXtGu7T5r1hxjGLHjU
	MyQhqzdNS+P/jwAbk0BlAgP/5f3yiDhumud9o4DIlbv/szShg+Dyy6JRBO/rQd7oMBBi/4HyI4Z
	GR19d90+Ic7RZdpFiHWl1xQOQkCQx5t1GBuGN8jI2nHPiPRDrjfu47nqEGSbj5GdR3ySu/O0pPW
	JvIUfx6H9G7ZijVUbw8IXgED/Z+x8niI9a1DBBPXSpo8KurLckDntzoo8oUkNZWlnYKFTQR54iy
	SQA+kiH88fazr2iZU+R9RhweSBp9gBl04K+P6VOEAHBiyXB9soV6f0nbEA79t1fwIFaSAEWZ9NO
	zQSs=.vbusMeHyt73q65uH2qlptePULEW20dYdMLEIE9ZZ08BrA+747PWdN3452oWzkrQMhbIo4
	xRHCVMUZ6jA4w6Q4Skjlh8sTEgG9xlYhDrSeVAzDKTQaWisbRnmu04DPcklBm5fGxoWujblj3cB
	gEklqIvT510tTwG39twknCA2v0wdBzine6IT9ZFKGzfEG/lSPg25XEp1TWDUkmtJCnq+1/Vbik6
	MVveZw/XFiBzPS9GlWMjGxSxAGOe/Mz1PrtxJ+3TFnuG47PXy1DeWaNWNFdBIjm/h0ap0hdbYAR
	KD1Em8eEewmYa9egiipl0P3lssuwKzKQWlQRT5jqQkXrcG+Q==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nus.edu.sg;
	s=TM-DKIM-20240902111054; t=1782895737;
	bh=GHKBAvW4SpSEJYIiJxTuWQ6iTPWQMu3nb60w5kAldrc=; l=2723;
	h=From:To:Date;
	b=VWf1zJrsFEcfcsFETDGkNGAJVhv+jsvvHkUxFGhdLG1l6rRD0F1IfnfrerIyM9Isv
	 Gau9OvDWaMg4PZSs+GYh08NqfhR2tEp/SmqkhPmKOjH72BiORrHSbKY9HkG/+kJYSz
	 QdV4r0dYULdVzT6s9XSWywlLJRl05CXgYRomR8piv0ottxlZx7YrBBf04qHynEYwRK
	 jYP6MB/VGdPRvCebll3XwR9ZOJmtTm6g7PwA0aXt6T7NZ0/PqFVEuEH36wcHW1F7lb
	 iOMWObe6yMn5Zz+6BlmwBQ+AiQAOtEebx37FcoBi98mm7ev3gtANXzHvSHcHBvUy4U
	 Hk1QKaZnNvH6Q==

Hi all,

I have a DCD lifetime / identity question, mostly to check whether this bel=
ongs in Linux at all or should be left to device-rooted attestation.

For active Linux consumers, I think the current model is clear: if a DAX re=
source is still in use, release is refused, so a release/re-add at the same=
 DPA/HPA should not be able to silently swap backing under a live dev_dax m=
apping.

The remaining question is about consumers that have dropped their live refe=
rence and later rediscover capacity at the same host-visible range. At that=
 point "same HPA/DPA" is not the same thing as "same grant". A released ext=
ent that is later added again at the same range is a new
allocation lifetime.

For host-trusting consumers this is mostly a cache-invalidation / audit pro=
blem. A region-level extent topology sequence, or exposing the device's DCD=
 extent-list generation if that is the intended primitive, may be enough. U=
events plus rescan may also be enough; I am trying to understand whether an=
ything stronger is wanted as ABI.

For confidential guests, a host-maintained generation is not a security pri=
mitive. The host/VMM is outside the guest TCB, so a host-side counter can o=
nly be an advisory trigger for re-validation. If this needs to be a securit=
y property, then it seems like the DCD allocation lifetime has to be bound =
into device-rooted TSP/SPDM evidence, or otherwise covered by device/FM sem=
antics such as revocation and sanitization. IDE only protects the link; it =
does not by itself say "this grant is the same allocation as the one previo=
usly attested."

So the questions are:

1. Is there already an intended DCD allocation/extent-list generation
   that consumers should use for this, and should Linux expose it?

2. For benign host-side consumers, are uevents + sysfs rescan sufficient,
   or is a region topology sequence useful to detect release/re-add
   discontinuities and missed events?

3. For confidential VMs, is the expectation that CXL-TSP evidence binds
   the dynamic-capacity allocation lifetime, rather than Linux carrying
   any host-observed lifetime?

As a small example, I have a QEMU reproduction where capacity is released a=
nd re-added at the same address and the guest observes different bytes (AAA=
A then BBBB), to illustrate that address equality alone is not grant identi=
ty.

Thanks.
Flavien

________________________________

Important: This email is confidential and may be privileged. If you are not=
 the intended recipient, please delete it and notify us immediately; you sh=
ould not copy or use it for any purpose, nor disclose its contents to any o=
ther person. Thank you.
