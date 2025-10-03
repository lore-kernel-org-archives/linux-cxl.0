Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010058.outbound.protection.outlook.com [52.101.193.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9CE1DA55;
	Fri,  3 Oct 2025 00:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759453160; cv=fail; b=fDR0nQLC+BPbOD1DJk2WCK4+7v/bZXAXlGSFv998pQZRxr9OwcIGfA5ocgsdlneCfypmZFH2BZX7CKJvBoyNJYEkdv73iCk/8X1vlk93NAWzhOnclFyXNQS/EiHSej5ZUq5brnbGcVqqNl8Z1Nc04MPxcraO4Ar68F1pawD9xBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759453160; c=relaxed/simple;
	bh=bWGShARyovg0bAUU7yURSnq/mbz/c4M4qBOnqyyo1FU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mPx5/LIHkJ2ZcSxjI+LOSBMRsWZvDiPYiNTxwmx2BUdQLyMOfy8MyVSSEWHsAt4ZxcHvrJdysXBeMeli2RyVw8RKnw2nAGq45qPW9CMFJhlHjgUIgNMWw82uLl9wYCzw1clX/nhs/Ctnb1V3EsrDc94TgRCFwZIhUQqIFhHVbGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XCOvoC4j; arc=fail smtp.client-ip=52.101.193.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XCOvoC4j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p300Iyf7G8cnYaC0ElvghWQjBNYtjrC5nIsEp3pH278bMBU+aplH5WaZNWZSCI1RQ0O9ouzQFGl2M92p8jbWr/0B3jxWP8eYqOsOLk3r0WfAwhhLNmKIJgM8FzF/Oady6mo9C6vd9XgKnWXIMdl4qAuJ+DmhHWhilLSqxbB4Brd9RyUOnZ8d11FzbOdgE4LcreA5W2zspq6t3mGydZs6iuh2A3vpBEpIxXJYjafY74GFegUVuB7kpVH77q0uXo7p7rSFyne5IvFyEyJI+S2VdzZXPhGIFbhXUJ35OvRtHS/DIfTkZWWpmmXBiC38LpoNeZLGU30tz+xqeAjYrISaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTHVJDVkoVHlPrry2AxlKBhln4AbMOsklvqCd27vNos=;
 b=dStgdP4O83x+N/kpiyG3zF2jUXnggikWNwDrmUjyefM7PPV7p8ON8uKQ1v7sDRlgWWXe6zLACkRYnmiN4IfKoKLvZjqOQEg+1yvsvVcck8304svxAvhgMckSRqXDRkOY5iicdqpD0jiPmYYhsxuxHnZHSIyo35KO2u4eqng0zGv2duO0G3WH33YCIrIh90TjulbIU0wgcoJ8PFcGAXj6bECMpB1bzdsTzaRC3ivsKaEMWZfcEXv6+PJJ1kg1zA8fCPp1SdeGhkb41318rruKkwQdntxhiNmZ3KoGooMwKbiAhoMhT2sHdimXpTSIlC+awulnZ/5I8pUklFxcOBdvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTHVJDVkoVHlPrry2AxlKBhln4AbMOsklvqCd27vNos=;
 b=XCOvoC4jb5axxrTSs8aUyIjCK6xaaLsqc8i4SwZY6XVjBleInYcwCE10Txfb60JMGnHaJNDsSTWeZO0hNLm0esqdl41+O0WI6xRe3kcywYZ9umhyL8jDyjExialprSF8y55QxansmLoYfdfPdLqB8bvFSLdgPp+4f2P5bSb05eo47EaZwcmwrDcqfTAmNeffrVgslooY1m/AUN0V7osadlnpsIXGqiNThNLUU4P0RyPHcJQEYu3rCn4kmHkf6TOYHw4wsDjvDhAxpUOGtELv7O7Lj8DMJPnvIsY1YaVHCiSqqvK8Xt/j9rojixB6I6YV5G/q0HkyRz30G4Brfb9Tig==
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by SA1PR12MB9546.namprd12.prod.outlook.com (2603:10b6:806:459::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 00:59:07 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::ce21:6749:3d4e:2c61]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::ce21:6749:3d4e:2c61%6]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 00:59:07 +0000
From: Vishal Aslot <vaslot@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Li Ming
	<ming.li@zohomail.com>, Peter Zijlstra <peterz@infradead.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Zijun Hu <zijun.hu@oss.qualcomm.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] cxl/hdm: allow zero sized committed decoders
Thread-Topic: [PATCH v2] cxl/hdm: allow zero sized committed decoders
Thread-Index: AQHcNADr7CR1e/ei5UC/raGgi2gvQA==
Date: Fri, 3 Oct 2025 00:59:07 +0000
Message-ID:
 <SN7PR12MB8131F796BAE8B6243E088879BBE7A@SN7PR12MB8131.namprd12.prod.outlook.com>
References:
 <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <cb300580-1297-4d4b-9a3a-2cf7445b739b@intel.com>
 <SN7PR12MB8131FBDB82D2A3A539FA09D0BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <70a2ea96-0a4b-4185-8f37-ea77ed757b64@intel.com>
 <SN7PR12MB81319CD146CC8B4CFD45E62FBBE7A@SN7PR12MB8131.namprd12.prod.outlook.com>
In-Reply-To:
 <SN7PR12MB81319CD146CC8B4CFD45E62FBBE7A@SN7PR12MB8131.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8131:EE_|SA1PR12MB9546:EE_
x-ms-office365-filtering-correlation-id: 0d47d840-925d-42d1-b613-08de02180e82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?qoHjIvi6Yhu+oRQeSXrg1PX1qvxuC/r/2wmauVjJ0RVEBeShAsfLYDPiBo?=
 =?iso-8859-1?Q?dZzyD347KXk9q2RxtJ7gazJR/3ZaA7FaO+v43yLVbKJw1XWIB76oT+LF8o?=
 =?iso-8859-1?Q?DdKOFVSLASzyYeRKNCZZcTSZFeNVei+AUirF3q6ZnYeNgk+Rq5+bJwC8od?=
 =?iso-8859-1?Q?W8ZQuZDu8IbtciSjjQdM8rqnlXmg57HShnzuXyzvgUOCJiIrYpUHRnJUiL?=
 =?iso-8859-1?Q?j7iLjTblGYqLsHhNqJ9jYrspnyZVmVYSIzJ2ea1T1mZEMnfqGFi3ORrdQ8?=
 =?iso-8859-1?Q?qXpoS75Kf+eD84wImtTTdNf78w4DFe5TNQc0JTWcfbM60aFRh4V3nwtuHi?=
 =?iso-8859-1?Q?Y4qARWy9PN2XUceHNL6ECS5mPnpAgDclDtdUt9pfskL+WVRRgfqc30c7N4?=
 =?iso-8859-1?Q?MJ7mhLTpxxTM5M4ILkJwp0RlO0Afqgus1xXG3M9lTPKoK4pdJodEMGSxgh?=
 =?iso-8859-1?Q?9R458qoxNhfEIdDyINnxpksYE2u54sKssJ3SRsuV0uGOsOsMO1/idDAVbF?=
 =?iso-8859-1?Q?sBQyv9MgHRKbX3t4MhRJRR7cN9xMMqSbAm9tFwmNfJ/LaQBIBl7MOFSkFU?=
 =?iso-8859-1?Q?34sqXZfIz6POskn3jIuaMeszebSbQpnrOLfbYEgk7kG63VhktCY+epLyHK?=
 =?iso-8859-1?Q?XoVaWRy9oGvIC0564M38nFhqm0KNRKe/FKkiea3MW4CKWcmwEBS/qeXPyr?=
 =?iso-8859-1?Q?5/SfktIJ1bf2jZshfeJuaZl2bzha+VxmI2UOT4PBgSIPJJaNR3f8+voxVG?=
 =?iso-8859-1?Q?wi95sgqtQGpkXa3xn4imaI+fvMYdv11wacE4UQnuq7KWcH+cJ6sfpMktoL?=
 =?iso-8859-1?Q?TWhtx9aXQWTcMpJTX1aweHa+/sh/u7YRm7i9/QDqbSsg8WBf2rK6nHt33w?=
 =?iso-8859-1?Q?RiGQrdku1XgSJBD0u2+nigk8yfb+tf24Js3ziiEVPtI0RB9qjCLETRZ5yz?=
 =?iso-8859-1?Q?YreTslWwDqkOwJFEA+dLUczGXqQmZU9HT61Ia8SG3A64xLIKbkbocjPqhL?=
 =?iso-8859-1?Q?b1CTT8ORAEnCMvVf/24piupUUD/2BTLI2nabz4N1hZvh7gabVo7zGzwCmV?=
 =?iso-8859-1?Q?wJO3cx3YR4NUp7B/wohFcKi8ZK/KPk1YDvZzBeq2YIw3y47PyazI+2uHmw?=
 =?iso-8859-1?Q?9jssY1bO5YXFD9RCMfCLiZssvnejtdIz01llv5rHrr4ov87NWMyl8eao3e?=
 =?iso-8859-1?Q?4vwxTDHLo1u937pSrdAjA7DTLshRwDU6udd6Z9duCagCPXiAFZGCd6i685?=
 =?iso-8859-1?Q?6OZW7aPasayVf0zvQT6gWwIkmRwG44AFqpQiFrtgqFjLDUlWDt/ZQjkz+/?=
 =?iso-8859-1?Q?WVTDrogijlm0IAla8K5lFkmAHIH6WuATXJvb5T8lTWgI2+yugT8XMXJYmk?=
 =?iso-8859-1?Q?3oP9FWP3zsLhX4PfUq77L8BIWsdjeHMwniCDNxCZJDXxbyGooL4UFs9smM?=
 =?iso-8859-1?Q?R7Xgap++ljrN9ukTvt+1bimqvAnO90nSjR55kjlhzyK/vnQN9xyfad+ZzI?=
 =?iso-8859-1?Q?bz4KwZ6FQYiCM0gORPY1ZHQ5kus3q64YxwXDhtnh6c6nOz7VMRdPl8+QB2?=
 =?iso-8859-1?Q?foRyXEb6fXOLu8i1zcEi3SIPLKJ/tp9L4DoOjW1QiDG7OCLK6w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qIk3ZIADEU1CVC8VQVipkX8hO+HCYjzNb8erLhqlCFCmlU7M5cqFwZzNes?=
 =?iso-8859-1?Q?bhnpVPM/3wyIjx9S037oWPUnywdJgxg7oVnHlxEhXC/eZ7+1zCnRt6nBFq?=
 =?iso-8859-1?Q?1zOC1cvKWbuYmLY6ZLGMRJlz3W6GMEYNWtUxsNhQI64GL8UIqN33NT2D1D?=
 =?iso-8859-1?Q?fQ0ddibHJfurtdBJZwmI9rYMsSIIvMoUtPF23UVj6fmtx1Ez7ur954xGGC?=
 =?iso-8859-1?Q?RllkSfqiaYAdlJtQ+dZeT08xdXwpZjyqxj4wHgbOKkujnC2pN6emf7nJVj?=
 =?iso-8859-1?Q?/lvxLSkY2gQpbUenYRCUKgEXGC0SuQ8trAFPTB9aIgUv+fhiGP9a4epcl4?=
 =?iso-8859-1?Q?QboFZR8fDMiGsEuWSDoZ9rpEg1IJzhTKu6BlN9uZrVtxy+B+Ogu+at6ugw?=
 =?iso-8859-1?Q?Ixa/2sYLrAFBvVAFRrfQKJC5t3RKP8KxkpVPcr4XPRKHaeei0Ltqr52fPL?=
 =?iso-8859-1?Q?p8itnVg5lupGM+aODF2Fy5oTZxbr8yjSJIBLsfOOH1f1STHkwQddsrdKwo?=
 =?iso-8859-1?Q?WrKO3ImFUjkhsEzdvgEl2po4M2kV2gpyGoEsJwGxzgJRvjPAEVuPmhpUNn?=
 =?iso-8859-1?Q?5mI2lKOvy2p0RZFf9oR1mEbQct9Pqh5QPj4dFAqtTzmXTa0/VylVVC7yg5?=
 =?iso-8859-1?Q?oDHjuCtqKxOYmo1C+xowXK9TuGjOLpVNGMT23gIb7UmbEPWtYiNpxha47Z?=
 =?iso-8859-1?Q?nAdDd9SQGPfKdlU67SKrHX571QskIiZK77e1MHXKYQ2XaMIbHK6mi/uWbE?=
 =?iso-8859-1?Q?vktU9rtAMQ1Gk8+NlRH+Fi9r1zQHfiyrtwwHfp8QRH8/N8SjeiAu5QZTVS?=
 =?iso-8859-1?Q?uTffMGz54HTpzPoYR1E1BedNNgKjR20n/Ly0mILhV3E4y0D21LmWm3zNo9?=
 =?iso-8859-1?Q?uBYA1zWrLzAN+MN2QVpMETIqwMNU48lDF4uHL3+b0WCDOkNRzgmlwaFGpk?=
 =?iso-8859-1?Q?gT89fMMbp+kinEXqdO4a8mhBNH2EvJwRD9mMaeVPIkHGJ7drfG6ldl2Jsx?=
 =?iso-8859-1?Q?W29W54mBz8jo9BZrrC0Lo4cKKn/mc22uOEHNGWksC3m0SrRL9zCRv+FNmq?=
 =?iso-8859-1?Q?T4/7kZdw5BX2059sB0wUaAJXy7e8Z/zWGM2jVE7DTj/om6OZNScBWdFBmp?=
 =?iso-8859-1?Q?tLHmEPKbCCmApjlC9ZcbUV0WSyh1/12ymvwAiRqL+67eP5PwQdGgQqm+zl?=
 =?iso-8859-1?Q?8FNLhSlzTJdv3WqYZTd6bHu+oNAHNREQsQ4y53dwrY2I1gMp/YNe7Yjf5F?=
 =?iso-8859-1?Q?rV3nTHRA6B3EGbecLYNVreGRFefMG6Rs24+Zko/RUVwN+ThV2JxDIn58JG?=
 =?iso-8859-1?Q?R6PbsmLjtfDdugyXp1GSAMKl+sV8gu6Jve9bsDi7pjZRHKmpqAWPi/Q8QK?=
 =?iso-8859-1?Q?7dWAMDEK0iydqyM49WaZLCVXtNH7fehekTguL1TX3i8HnfbsIGwNXC+6Kg?=
 =?iso-8859-1?Q?/w0n1gBLf1heSQ2VRkTjrJp9OxDdNXLoQVEYGtqgZCt6cOvUZh1mFt4i0A?=
 =?iso-8859-1?Q?KNj/U+KBv56bXUifcubpDci1D1WVLSyuo/I7qKo9reR3NqBmvf/nC6Pnga?=
 =?iso-8859-1?Q?BNJQHSNb/4uRO2CvvgbHSz+hfgW+PYc97qANxbyTaRMA+py4FbgOS1vnbb?=
 =?iso-8859-1?Q?c/WzBoMa9jENc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d47d840-925d-42d1-b613-08de02180e82
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 00:59:07.8518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YPrtV6azpvWdmSc8gzfgO3S1ENccCSrGhLlF/4NycIRofg27JtNzYrBdMS9nLMwrPY+o1wrWQgcD7F+27Oz5zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9546

init_hdm_decoder() fails with -ENXIO if a=0A=
committed HDM decoder has zero size.=0A=
=0A=
The CXL spec permits committing zero sized decoders.=0A=
See "8.2.4.20.12 Committing Decoder Programming".=0A=
It says,"It is legal for software to program Decoder=0A=
Size to 0 and commit it. Such a decoder will not=0A=
participate in HDM decode."=0A=
=0A=
This patch updates init_hdm_decoder() to return=0A=
-ENOSPC if the decoder is commited with zero-size.=0A=
The caller leaves the decoder allocated but does not=0A=
add it. It simply continues to the next decoder.=0A=
=0A=
Signed-off-by: Vishal Aslot <vaslot@nvidia.com>=0A=
---=0A=
 drivers/cxl/core/hdm.c | 7 +++++--=0A=
 1 file changed, 5 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c=0A=
index e9e1d555cec6..50164fd1b434 100644=0A=
--- a/drivers/cxl/core/hdm.c=0A=
+++ b/drivers/cxl/core/hdm.c=0A=
@@ -1047,10 +1047,10 @@ static int init_hdm_decoder(struct cxl_port *port, =
struct cxl_decoder *cxld,=0A=
                }=0A=
=0A=
+               port->commit_end =3D cxld->id;=0A=
+=0A=
                if (size =3D=3D 0) {=0A=
-                       dev_warn(&port->dev,=0A=
+                       dev_dbg(&port->dev,=0A=
                                 "decoder%d.%d: Committed with zero size\n"=
,=0A=
                                 port->id, cxld->id);=0A=
-                       return -ENXIO;=0A=
+                       return -ENOSPC;=0A=
                }=0A=
-               port->commit_end =3D cxld->id;=0A=
        } else {=0A=
@@ -1210,6 +1210,9 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhd=
m,=0A=
                rc =3D init_hdm_decoder(port, cxld, target_map, hdm, i,=0A=
                                      &dpa_base, info);=0A=
                if (rc) {=0A=
+                       if (rc =3D=3D -ENOSPC) {=0A=
+                               continue;=0A=
+                       }=0A=
                        dev_warn(&port->dev,=0A=
                                 "Failed to initialize decoder%d.%d\n",=0A=
                                 port->id, i);=0A=
--=0A=
2.34.1=0A=
=0A=
> ________________________________________=0A=
> From: Vishal Aslot <vaslot@nvidia.com>=0A=
> Sent: Wednesday, October 1, 2025 8:57 PM=0A=
> To: Dave Jiang; Davidlohr Bueso; Jonathan Cameron; Alison Schofield; Vish=
al Verma; Ira Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpenter; =
Zijun Hu; linux-cxl@vger.kernel.org=0A=
> Cc: linux-kernel@vger.kernel.org=0A=
> Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders=0A=
>=0A=
> External email: Use caution opening links or attachments=0A=
>=0A=
>=0A=
>> ________________________________________=0A=
>> From: Dave Jiang <dave.jiang@intel.com>=0A=
>> Sent: Wednesday, October 1, 2025 5:46 PM=0A=
>> To: Vishal Aslot; Davidlohr Bueso; Jonathan Cameron; Alison Schofield; V=
ishal Verma; Ira Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpente=
r; Zijun Hu; linux-cxl@vger.kernel.org=0A=
>> Cc: linux-kernel@vger.kernel.org=0A=
>> Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders=0A=
>>=0A=
>> External email: Use caution opening links or attachments=0A=
>>=0A=
>>=0A=
>> On 10/1/25 3:03 PM, Vishal Aslot wrote:=0A=
>>> Thanks for the quick review, Dave. Yes, forgot to put the commit messag=
e. :)=0A=
>>> About the copyright message. Should I not be updating the year to 2025 =
in it?=0A=
>>=0A=
>> I wouldn't bother unless you are doing massive changes and in that case =
it would be adding NVidia copyright anyhow for you. Also, typically linux m=
ailing lists prefer responding inline and >> not top posting.=0A=
>=0A=
> Ah, understood. Thanks for the mentoring.=0A=
>=0A=
>>>=0A=
>>>=0A=
>>>=0A=
>>>=0A=
>>>=0A=
>>>=0A=
>>>=0A=
>>>=0A=
>>>=0A=
>>>=0A=
>>> ________________________________________=0A=
>>> From: Dave Jiang <dave.jiang@intel.com>=0A=
>>> Sent: Wednesday, October 1, 2025 4:28 PM=0A=
>>> To: Vishal Aslot; Davidlohr Bueso; Jonathan Cameron; Alison Schofield; =
Vishal Verma; Ira Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpent=
er; Zijun Hu; linux-cxl@vger.kernel.org=0A=
>>> Cc: linux-kernel@vger.kernel.org=0A=
>>> Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders=0A=
>>>=0A=
>>> External email: Use caution opening links or attachments=0A=
>>>=0A=
>>>=0A=
>>> On 10/1/25 1:37 PM, Vishal Aslot wrote:=0A=
>>>> Signed-off-by: Vishal Aslot <vaslot@nvidia.com>=0A=
>>>=0A=
>>> Missing commit log?=0A=
>=0A=
> Yes, will add one in v2.=0A=
>=0A=
>>>>=0A=
>>>> ---=0A=
>>>>  drivers/cxl/core/hdm.c | 9 +++++++--=0A=
>>>>  1 file changed, 7 insertions(+), 2 deletions(-)=0A=
>>>>=0A=
>>>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c=0A=
>>>> index e9e1d555cec6..97a5f27f5b72 100644=0A=
>>>> --- a/drivers/cxl/core/hdm.c=0A=
>>>> +++ b/drivers/cxl/core/hdm.c=0A=
>>>> @@ -1,5 +1,5 @@=0A=
>>>>  // SPDX-License-Identifier: GPL-2.0-only=0A=
>>>> -/* Copyright(c) 2022 Intel Corporation. All rights reserved. */=0A=
>>>> +/* Copyright(c) 2022-2025 Intel Corporation. All rights reserved. */=
=0A=
>>>=0A=
>>> Stray change?=0A=
>=0A=
> No, it was intentional but I understand that for this small update, I don=
't need to update copyright info. I'll undo this change in v2.=0A=
>=0A=
>>>=0A=
>>>>  #include <linux/seq_file.h>=0A=
>>>>  #include <linux/device.h>=0A=
>>>>  #include <linux/delay.h>=0A=
>>>> @@ -1050,7 +1050,7 @@ static int init_hdm_decoder(struct cxl_port *por=
t, struct cxl_decoder *cxld,=0A=
>>>>                         dev_warn(&port->dev,=0A=
>>>>                                  "decoder%d.%d: Committed with zero si=
ze\n",=0A=
>>>>                                  port->id, cxld->id);=0A=
>>>=0A=
>>> I wonder if we should make this dev_dbg() now that it's a valid case.=
=0A=
>=0A=
> Yes, makes sense. I'll change it to dev_dbg() in v2.=0A=
>=0A=
>>>=0A=
>>>> -                       return -ENXIO;=0A=
>>>> +                       return -ENOSPC;=0A=
>>>>                 }=0A=
>>>>                 port->commit_end =3D cxld->id;=0A=
>>>>         } else {=0A=
>>>> @@ -1210,6 +1210,11 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm =
*cxlhdm,=0A=
>>>>                 rc =3D init_hdm_decoder(port, cxld, target_map, hdm, i=
,=0A=
>>>>                                       &dpa_base, info);=0A=
>>>>                 if (rc) {=0A=
>>>> +                       if (rc =3D=3D -ENOSPC) {=0A=
>>>> +                               put_device(&cxld->dev);=0A=
>>>=0A=
>>> Why put_device()? Should we enumerate this decoder instead of pretend i=
t doesn't exist? essentially only a dev_set_name() and device_add()?=0A=
>=0A=
> That is a good point. The decoder has been committed so it should be acco=
unted for in the OS.=0A=
> I'll remove put_device() in v2.=0A=
>=0A=
>>>=0A=
>>>> +                               rc =3D 0;=0A=
>>>=0A=
>>> Don't think this is needed since the continue will put it at start of t=
he loop where rc gets written by init_hdm_decoder() return value.=0A=
>=0A=
> Agreed. I was being paranoid. Will remove it in v2.=0A=
>=0A=
>>>=0A=
>>>> +                               continue;=0A=
>>>> +                       }=0A=
>>>>                         dev_warn(&port->dev,=0A=
>>>>                                  "Failed to initialize decoder%d.%d\n"=
,=0A=
>>>>                                  port->id, i);=0A=
>>>> --=0A=
>>>> 2.34.1=0A=
>>>=
