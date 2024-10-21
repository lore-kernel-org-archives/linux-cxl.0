Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3847156C63
	for <linux-cxl@vger.kernel.org>; Mon, 21 Oct 2024 05:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.148.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729488083; cv=fail; b=lkCPC0S3+nTezd220/8FIb569xwJEyJgRg1Vg/jaSW9GMvGMW5kQVSf56LnnbDHfWjwql36XLF1lXoNj58ZZVYpuXqj+eXr9mbZkKsmsr6AWghmLOHTt6FYAcKfWIlcZtBjuLKMPiExisqJGkB+6ermdavKG40+MA7lpuEjhCyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729488083; c=relaxed/simple;
	bh=x30k1U6Lt6icLMgE1lRIWWXtCXnFbUCei5kqrnGXYEE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=quQuaoZykSrfhhPtrMcrg6dp32ctOzi5KPp65i7AXYB03sIQmtRz/aDa/6YFMcE4JZu3IXu5E5wrGHqWflNkinV/4M4jxGxoPIPo0aH7CagXiOo6GeuAb0swS6s68dT+qtuc90e3TJYcBHo5cPDtFUDTtZChlO7CzJK2HqDbjMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com; spf=pass smtp.mailfrom=lenovo.com; dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b=fJsuPO08; arc=fail smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenovo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b="fJsuPO08"
Received: from pps.filterd (m0355087.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L3GY0c032496;
	Mon, 21 Oct 2024 05:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM202306;
	 bh=tlc2l1R8ETSKvyRA0YJNQxEVSGIRPAFysFPjKwDBu5A=; b=fJsuPO081S++
	3+MfmD9ze6OPhzXimMTH9f+ObhSm/i8PmKJdb+FoLZyfAfapbIpyw2aDbeyRPefr
	flLU1TU/VFmkWLnNRksVtpg3aKRjGaUiXIq+jVedDq2g4oMsLteW4MMJHHSXbYNS
	ryNSKSQ/lgYCEkn7fI8moQnUQQxFbgD0FgeuQvRregk1Nxf7pnEWz9UD/tx6VTbR
	Cn5G2yCkhLH07PuQvhmwp8EUrYUFWwpqFm1h9cgNelI5VpR8wfWmkL2WtiOEvkIX
	63/iz34TgX1NOXhctJWmCP99VHdQRHWxWl8wro+/TzQjFjBUaw97fDGHwl7VyrNH
	7oXNUXDZ8A==
Received: from hk2pr02cu002.outbound.protection.outlook.com (mail-eastasiaazlp17010007.outbound.protection.outlook.com [40.93.128.7])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 42csmh9j49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 05:21:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+i4nQ92oQ3hHfQwO8kY2ug+JWQiA+VW096LA0s0EfkM0bGq3Uh1BOFVqSpBNsgoAs61ESM9e2IfzxiypwT4/NVhcv2Cz3M3RzjSlND5NBDogFwdVCQ1Z2Zt86caFesCiqO0yBVon7WdhaJv18DfDjJrpeb7w88F8IJHG2j4es0Cm4h9bjra0/yV7RwUsYTZO5oMUDCTn9dJ6AzlYN7UdAn11Upls2pkvIpqZtO2RWQHCWomocw2jbP23758GWuaKTHiLJrXp7E6UqXeUD3uirZB3N0chE20BUJZ28B+OQLDU/Hz/gZHmwpQyV4vT3KWwfflXhQplPnwlSbzOQ/Dxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlc2l1R8ETSKvyRA0YJNQxEVSGIRPAFysFPjKwDBu5A=;
 b=DHjnZzG7RPbpaA14cozkslDvjcow+hbhsBszfAwOhlUh3e7FxTfLP/8lmWTtHGxXY+xUCucq0ERcd3YDrv7BvqOj1Na75BFGmbvsppybCqUXqXulXJVWUbMTD7ZhrwKp5i155iUEmkiICXeKJUTDl201ymc9zTuuo5M2TZocFdBzmNERwKzQnv6EE/b6iUNKpBqxgbC5edMkcP0vRDEVkk+J3eGwgb4XX/ImGjE3g7cLGLJmUgTan6x+3LilxTesk4VpgPjnQC8Nf6/VsvWj9anAfKi2XiW4UkbTFdnot7NOfwslgpVbBn4vGKV/HnNZc4JBv3cqz6PObGGGnp+X5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from TYSPR03MB7689.apcprd03.prod.outlook.com (2603:1096:400:414::6)
 by TYSPR03MB8788.apcprd03.prod.outlook.com (2603:1096:405:5d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 05:20:58 +0000
Received: from TYSPR03MB7689.apcprd03.prod.outlook.com
 ([fe80::c056:e512:42f6:ed8]) by TYSPR03MB7689.apcprd03.prod.outlook.com
 ([fe80::c056:e512:42f6:ed8%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 05:20:58 +0000
From: Kelvin Shieh <kshieh@lenovo.com>
To: Coly Li <colyli@suse.de>,
        "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Jonathan Cameron
	<Jonathan.Cameron@Huawei.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: RE: [External] [PATCH] cxl: downgrade a warning message to debug
 level in cxl_probe_component_regs()
Thread-Topic: [External] [PATCH] cxl: downgrade a warning message to debug
 level in cxl_probe_component_regs()
Thread-Index: AQHbI3bKK6M6SipAd0CY4tv+WdbVn7KQqpMQ
Date: Mon, 21 Oct 2024 05:20:58 +0000
Message-ID:
 <TYSPR03MB7689E74FF79FA2E0675086F9B0432@TYSPR03MB7689.apcprd03.prod.outlook.com>
References: <20241021050443.318712-1-colyli@suse.de>
In-Reply-To: <20241021050443.318712-1-colyli@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYSPR03MB7689:EE_|TYSPR03MB8788:EE_
x-ms-office365-filtering-correlation-id: dfb66367-a999-4db9-b301-08dcf1902586
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1g5QKmwG3TvGYWRcWsM1iUJ78N+ICWK2YuKTjuWJUUNPmU9/6LuOz3Itg7c6?=
 =?us-ascii?Q?w//njPiAePdjSNPpQYYt+8de0qgJq4BMEjdpwlA4eXqrGmJwi2n0Zmp9q4W7?=
 =?us-ascii?Q?ohkxpy66nkJpN46jIx3EbbqGPSA8T5umW3gv+NG8LYdc1bFkyUNksZKpbdGa?=
 =?us-ascii?Q?8ld+HAKGw5AXrA0dyjS0y3v05ShnJu0dHWxYwagNonLgbtyUVIUk/uNzpTPC?=
 =?us-ascii?Q?b3/L+cnV16BDu+C0xxaANM2iWB7Onp6x9pWNIG0qzvLadJbLv8L/QYVAffLF?=
 =?us-ascii?Q?vADF7Utd/c+TTgjDqZnp58tog2RLNbRAL72Wmbbe8UkJ1kA26i5JsdMbV69l?=
 =?us-ascii?Q?YVDVWXhUVhxeqp9oDlFDG080YFMy4DsvK4W8TobP3igRmPzDzmQ21DOXHc81?=
 =?us-ascii?Q?ZARBGvnY+t1K6KmYqwZ9ZLb/j7KspW4LDXfa/e7HJaTjsbgNv8ZGyrkzcapN?=
 =?us-ascii?Q?ojgo8XmxGkOy1AjpmaqS7DIuKFc0zXsDazCKeid5CTJHdKv7PHsUssXIPJUO?=
 =?us-ascii?Q?wKetpnf4BGPhMis8kq6IuFZLkuY2AQe3L5zxj/0WLupio4nbfTZyCcyRpRLx?=
 =?us-ascii?Q?b5BR+dmUKeeBSr8VSkQUYjwD8Zfe/SBfPZ/RXHBaxTvY/TGV+8TD0pYtk2+Z?=
 =?us-ascii?Q?2s+/qvLc76k/D4r/QR3NgDghDLpYb2V93xgxRCjuuzSzP6JQHRAVXz5zPBao?=
 =?us-ascii?Q?AniipSehuw16sh2bwoI4UhhKzqqcAl+FSiXZPOcmEUlFZG9Qdd+R6+GLb+bW?=
 =?us-ascii?Q?ZyqzhF+7gvaRn4Xg/0oDXJRoRb5GRAo4s4dHwkxVjXbt9/2yD0s+WgeqfBhZ?=
 =?us-ascii?Q?up9EC8FwpD3sa/AVMZll+JggTX+vasDr0ofzNL/a59rMDrbtXAEon4IhSVau?=
 =?us-ascii?Q?jfCxqfhHF2oP4CV7TJexnUsSqWnwsLC7BW9G5d+uVmQv8wv+owsD2BUSFZfH?=
 =?us-ascii?Q?21zjVTUwk0I1CTAgskwybf2XUVisY1A+YUVq/QuU5p71O1U1c7RM8eGM0k+z?=
 =?us-ascii?Q?K9k/qWSbgaGqPGE1ZohhnOzXuV1yBh0Nzhp6qEJOv8vWCVAbZh8IwNGhJOJb?=
 =?us-ascii?Q?e+3ET+eZj7aMd73mLeFAEeAxBSAbwb1lkUOvrHGQWNVudl9+ee9m/E6DYnbL?=
 =?us-ascii?Q?H573koXtGFRp498yn4dzBEuD7+f4OxRNs6V9GF+MH6fltvw0BvR9JPV+BlXo?=
 =?us-ascii?Q?RF65pGCQqrd4QQHr0k5nAmuWcl6TPiH821QxCQcc7IE4mG9NKKGQlBBgBw5d?=
 =?us-ascii?Q?8+HJqXap1ZI/5PRCyySKKy9ww5t6VRoFixCOga1QANOxSkMDo4pvlovXjyjo?=
 =?us-ascii?Q?MLG+q1lQMYziHbEv3pcc0TOw0R0TnTEiOWL3QBpYtKvSkqAf2D/tq83u0Co+?=
 =?us-ascii?Q?LCBd4zs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR03MB7689.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?693vPnMZmuCqwEvVO8sOCswvbFQLX7AMM3UeCAp4SYJtLlpNYVFM+ZOPFzgG?=
 =?us-ascii?Q?8uzZvJnmwxNHBXjorfknEFA4gwj/he5IgUwtsqcyqlT8oLsgOQ7V1GnbaTSQ?=
 =?us-ascii?Q?AAK5l+hfOatpWGgp5Eb9yRVu2K8aOsjkDt8Ymz7DYTKGEp6uMdaktyMqEoFy?=
 =?us-ascii?Q?GFuoVIfIn+4lnEfFcDSA8Z/XSTHCWUi3AdS4a/KaK01QKENXlPthEGYWASA9?=
 =?us-ascii?Q?xy+XCs3jzit1nY1fk2MNDqRio3Uove3EQ9t3dkk24IIiJi0qONwSmdVkoo+R?=
 =?us-ascii?Q?xSQQvf4j6f7P9RxFEvd41zempW6bDWOoOFdSHCXPdH4yIxjoJRoud9S2kJA3?=
 =?us-ascii?Q?OBnc9/hjo58p87xdeh+hCpi0haxiFlS2Pym6h+tu4PJSslfIjDtMFnAejahi?=
 =?us-ascii?Q?BCWHRdvRyIkrkraGKgbw1WwCKmzL4UJoB6ZoabMxJOPwESiD52JyGM/tGz06?=
 =?us-ascii?Q?HHw1vqrbBDDmhCjHVoIoX15a+0tzQprERguTxhB6j7bidxUoQgxj5KVlFfjJ?=
 =?us-ascii?Q?95RtPkSoUT2mUdR5wF68TaoVQgptwfqWJ2fqoCGCS6IiU+9GmC5svvZV0gFW?=
 =?us-ascii?Q?CAP8Ic1cBHt4f8MhdcpGcmWWq/fNEOCsedc47OBD3UmupuYY/FvHm60V2N/x?=
 =?us-ascii?Q?9X2gq+XvaOMBvoIRZWQZpnVbDA1Jr7SpF3H5sLj8M+A/yWrzqrxQ0+5VE+7L?=
 =?us-ascii?Q?yQGYp7rgh/EEwSYDHoo1NIK20284DLq+AuQYJU/6Nt9TbPmy4715kUQvSV2+?=
 =?us-ascii?Q?dkQBI6GejezJNTst7hxEEwRAJY+wgmWB/PVmrkWzWxdWsFEM6CLx8puBulKm?=
 =?us-ascii?Q?ZtMuFCtQ4fN58X51qwwblQ4YOGsRLba9KG33yTz8x1PeF8gaDbMIZKnAlQY2?=
 =?us-ascii?Q?B/wYdzAXl7wwC0nQHm6/9+J10S4cb9xm6NaXY3iGyBFMs8qHtZ1s10NZ1TH3?=
 =?us-ascii?Q?F6oijuV9pK3DiQI8BRdZyT+woBRrlGBwFI5QEFBLXvcgV3X08e49b3bqvaUN?=
 =?us-ascii?Q?SnMPW+x0V0ADWnSuC1xyHMyjKc/32nZTSvrJ0ba9Zjhk7j5VvdFS/Fi/5oAO?=
 =?us-ascii?Q?RrixPr6tRmsJoAx+5kdVaX7jKjdmaFgu1aoFJOKDjnRSHvHPEHISSa4eFIbP?=
 =?us-ascii?Q?7GxOuHmcL1HTId0uPPDbVwMbbVyYmf2YJOY6x6HBHCYRt+vR6kz+/fqU2GoT?=
 =?us-ascii?Q?9wcslyU6S1K8zABEGqf5UF98Uv/fOSr27b1QuGTPj4Tl1V30fG5pU8JfIh7R?=
 =?us-ascii?Q?NLoyYUZslsKPFSe6wv9JuGwfboq1/hOYsUCBO3v3jVIhn32Jt22BnZ5gOIkG?=
 =?us-ascii?Q?HOQnGig9WPpSv9gfm3HKomcOD8DcveYDGhl/+Ep9iDKugDfjqU0aEs02UKxx?=
 =?us-ascii?Q?+GisoDBL3X9mzGUcoWAyMk4jopUHE/pX3Nx+5wcNTX86ZyKIB281ss0fD9e6?=
 =?us-ascii?Q?7zNnOC1+qwFartocNsqjoMC6Cb0wTgiDr6xh+x67sY9XOEInpbLo6KzMzLq6?=
 =?us-ascii?Q?qTpTMX0APLByihfBWiWuouvHbbzklui95C+7CaNwl+wbrHTy/qLYNYiWS5NJ?=
 =?us-ascii?Q?eK1QRtmSB3YCR7ICKu0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYSPR03MB7689.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb66367-a999-4db9-b301-08dcf1902586
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 05:20:58.6486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LF5DYxXvCQbapWo5o62n6IaqkykCXgRQaNXoRpZL4YS9Zzz39IRZGgOGC2kDooAf7DEOeQYJKKsGkiGi8zZ3YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8788
X-Proofpoint-GUID: aYpO3P9o1ZEpu8pt7usxzhZeovLEtYnD
X-Proofpoint-ORIG-GUID: aYpO3P9o1ZEpu8pt7usxzhZeovLEtYnD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=-20 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210035

Thanks Coly and Dan for the efforts!

Best regards,
Kelvin

-----Original Message-----
From: Coly Li <colyli@suse.de>=20
Sent: Monday, October 21, 2024 1:05 PM
To: dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org; Coly Li <colyli@suse.de>; Kelvin Shieh <kshi=
eh@lenovo.com>; Jonathan Cameron <Jonathan.Cameron@Huawei.com>; Alison Scho=
field <alison.schofield@intel.com>
Subject: [External] [PATCH] cxl: downgrade a warning message to debug level=
 in cxl_probe_component_regs()

In cxl_probe_component_regs() the error message "Couldn't locate the CXL.ca=
che and CXL.mem capability array header." is not a critical error message i=
ndeed. Downgrade the message from error level to debug level by using dev_d=
bg() to print the message, and the end users won't worry about the message =
anymore.

Reported-by: Kelvin Shieh <kshieh@lenovo.com>
Signed-off-by: Coly Li <colyli@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/regs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c index e1082e=
749c69..026690137bc3 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -52,7 +52,7 @@ void cxl_probe_component_regs(struct device *dev, void __=
iomem *base,
 	cap_array =3D readl(base + CXL_CM_CAP_HDR_OFFSET);
=20
 	if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, cap_array) !=3D CM_CAP_HDR_CAP_ID) =
{
-		dev_err(dev,
+		dev_dbg(dev,
 			"Couldn't locate the CXL.cache and CXL.mem capability array header.\n")=
;
 		return;
 	}
--
2.46.0

