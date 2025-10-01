Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C9F1FCFEF;
	Wed,  1 Oct 2025 22:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759356238; cv=fail; b=MONRYCilQhVJoTzmtk538fmIgUwVqNWWErQZcwTgTnZ7Jlv/xtsS1lTDubnftfikTPXyyEOERjNKfOUSk47Mybp87QCnv5aafFmBikk0jhAiexOha6W0RA/0pLP/frH/zVoLQRO6Rg8ZpycV4us6xlPcgNYDu7OY2idsaVs2+C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759356238; c=relaxed/simple;
	bh=K9L2G5yfCQmBjD1hp52jCs34MK7e0NiwML8/heRbqb0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dRf+D+WXupQROFoKT8QbM1WiOxcrcxVISNZmcb16OP1JKjXzFGWG4b0Iy0lDU9ID3i6vrD7wqWMTLg42Hi7rN15ZFQzo1/Z2DSKf3U9tW+fwArKdE1x+HdIENrP0crrwHZKJCoM2KW3Yp0iHHqWg2muPDP2Ss+SoWpDHmg3xhN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cHJx9cZx; arc=fail smtp.client-ip=40.107.209.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cHJx9cZx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQlFxETA64dtS6OKV/55oStnzQEV35pI1eEd6zozA2r3kS9C1PlVD1t+wPD8EFdiUHGHmxvFaZwXHY4Nq41X4ylwmzd9FhLSTKX4Lzt1vnlHBu1bT18Q79koRTAl4nfYgcIU2cQtcTUKEu4f+N0seiv7Gxp7ufGWGOR6euRZQkD8/8LHq+B8TLGmHmcz/FjPk9kRvyLFOfXEqNBrd2gkvw40QbN1h7kA1VCfAtPqF4tJR/Om6sm6JzIgcumS9tOHK1BpCp6FHLcj+fBc7aK0q+bII16adfrv1Xctv+lFmSTOMsKb1GxluAHuR9DXtFr915u5jRBI0zI3Dk8n+8Cd2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bl+9JmaGL3Xx09R515Z1rwvamFqMDpxatdDtgyEAELE=;
 b=FbfpEj56TIm5UJiKktmT2XTAbd0YLlkIE3fpHmDjUkWXulgeoaeaTWQ0FhoqVV3yVFcUSPpCcLjCZQ9jLht3uPG3Savpsws5gvOVruXngAX4OfEpYOt3vN2SPNrYig9RJh85X32ycRUExSXdHFZ2VICI/xLrkKMUFjv2wg32Oy/wiB5UYh08cpSUSfdE19YhWYZ1yPoOYu+wB+M6BGSbyMm3ShSTmHmsFS1X3Us1t0qT0zgzc/oGkqO0JXJO5jZ3UbOpaY+buCej6Co3uLMCrsL4i64qJL/G2Oz9ZTVDFUuFOoqDYmhSV5adWU5s7W414zP1XhiDBqTSKgzVnuBeLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bl+9JmaGL3Xx09R515Z1rwvamFqMDpxatdDtgyEAELE=;
 b=cHJx9cZxYP2HA9NCSz1+UDjMSYEloLQ2C5QhMgBxtV54O9R+T+nQPfctONIMJ/OohJxt44AjonbF3CUQHH5VMMh3ht5siefNWDZdAdhVHs3N1kxQobZ2CghRvX97vm+XHraqEuq3eLOaL7vj/JA8eLs1LXUVRz5+2Q355Px4+6Jd+4G3d0JXqbAd+ekO9krVU05fubpHBTYZIjGoHf8DAPtllo+f6LpAFdeuDMtkpn43uTCiPEXHHApO8H5xOLKw56gxo27wfS4zGmwyEGvXOK0noY+WHYIfz0KBbd3dTn8mkiW2+bh9vcj/6FvRnXYRBXWKn+ssPOTEKTdNdxD3Aw==
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.17; Wed, 1 Oct 2025 22:03:51 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::ce21:6749:3d4e:2c61]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::ce21:6749:3d4e:2c61%6]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 22:03:51 +0000
From: Vishal Aslot <vaslot@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Li Ming
	<ming.li@zohomail.com>, Peter Zijlstra <peterz@infradead.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Zijun Hu <zijun.hu@oss.qualcomm.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders
Thread-Topic: [PATCH] cxl/hdm: allow zero sized committed decoders
Thread-Index: AQHcMxKXHWr3vqKdSEWsp5C061+MVLStzo+AgAAJi5w=
Date: Wed, 1 Oct 2025 22:03:51 +0000
Message-ID:
 <SN7PR12MB8131FBDB82D2A3A539FA09D0BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
References:
 <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <cb300580-1297-4d4b-9a3a-2cf7445b739b@intel.com>
In-Reply-To: <cb300580-1297-4d4b-9a3a-2cf7445b739b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8131:EE_|DM4PR12MB6303:EE_
x-ms-office365-filtering-correlation-id: 4ba452c6-d7e7-4b71-947b-08de01366811
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700021|921020|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bG7yBw2wi//RKTT1kriHbiK6LSpqEJxba/RxlVxTdEZtWHnxrhNSwF6ZGmhC?=
 =?us-ascii?Q?/2XowYfocYikxaxpuw0pkFV68lF2sd/FhaFSoWZq5uyJVbOUmwi3Y8vTJGnN?=
 =?us-ascii?Q?2fJCQ36LT5giYdyjtemGcd3PMETLV0xVfJlQarrB05/pyUxzcQihzrPdpIY6?=
 =?us-ascii?Q?yEUjgEAEY0v+JUP1fDf48Wf+aBHWu19+3Zk7f3hd90zll4taEoR/Yor74/pF?=
 =?us-ascii?Q?pyBkV4Tu+T5phcL2PonNH8YTMWy548WbN1rlfgtY1gHm3/aH/KTjw38okBVX?=
 =?us-ascii?Q?SO8vKRe7EWxx3iq1K8avA/vDT10MYf1vWY5puGzy3B7w3NfupJGLsETkZ464?=
 =?us-ascii?Q?dgBtcmtK1rZ8qstxjtyaDxRHOqdYFRhcGROH7rFJYJMR3SHMVMyOXBn+sj4d?=
 =?us-ascii?Q?L39O/3L5WtWWbrAfHIOtP5avOZ6fTM7GtqwKham+Gl5kfSiTwbNogVVErOqx?=
 =?us-ascii?Q?SvmRfKn8KDF3pLIKwVFopc0cihg9w3RZQUbp7fP9CVBgCVvJcajaNeGSdyAI?=
 =?us-ascii?Q?oU4KmzVeMmI70Psw1edkj7S+0g7BtAqb6GzPHiErLyw91Dg2WJOeY3flSz5X?=
 =?us-ascii?Q?1+gSh+YKs1+vuslsIE5En4BmgkUFgW1ZhHyg4zvGKzjUFlXvWXxbH031U6mz?=
 =?us-ascii?Q?ZhBsCBkygFebaXIqDuiVnI5qHVxTobi813bDD5l5YXxVqAnJnbkNXwznkwC1?=
 =?us-ascii?Q?paRSQf9x2RrBlXz0M85K4dak1262x4CmEhckRoyyHm8KntqXpMrIMTkQci9N?=
 =?us-ascii?Q?S7UmrjMtetUqRtESUXWpa2nx++mNHwJVR/GAFGBdh6KHxXIAX6CO+cRtEZbK?=
 =?us-ascii?Q?UttsqG5pCw5s2njxBUcMz60GDCsvCblos6dTHGyD4FirGDHrosQgo3QJ4e8o?=
 =?us-ascii?Q?WDGcKJ2IBd+/PJhL7Cc5Qn5lF7ZjYpNA3qHSvwtKbXN+MZA2TO3IR/X+Iuug?=
 =?us-ascii?Q?6cCmhLFd/iE4LB544b+SmKemo+sNvDBSBrLVXltc+jXxypbF48GFSbwGO4Ja?=
 =?us-ascii?Q?ahdV79Q76Uw9kfvwBXo7wBwifw8CFgtDd5VshcvVqPz8MFlDhK46oRzjhQ0k?=
 =?us-ascii?Q?49yqSZTPKRpzC5lHbYiJOvr1oN8hwOKibYWUTcjsLRpQqb2EBZfXRSHg4/Qx?=
 =?us-ascii?Q?C7uZmSLxR0MMktcMbLo5Vs/GkW1ICSdAab1WhfxG26kFy71Xb8A1c1INMqvQ?=
 =?us-ascii?Q?K60xWnogpMqVGV3nsuBBSEu+hAGrzDFh8QsJl9g5GSZuh1ayo6UO3ldcA8zy?=
 =?us-ascii?Q?YBJQbCw47sXwwjB5yJo9Jo6PqUiuOu4EmHf+A3gl7oSwhQzMa1CPG5rMJR0/?=
 =?us-ascii?Q?GJYwQ4DWTlEIwXkPrRSg/rt+LXIecCp+AnhS8MZs8A4uB0VOcHrCsaFRppyB?=
 =?us-ascii?Q?1+xVa8htRRNOEsXNQ4vpEKAo56NUs0wZwpLNKnzUwTsOfYiA9UYo8xLykb7V?=
 =?us-ascii?Q?hnocf02IoDwu+atF2fB91gAi9rSwablJUUHnLEiHbqOjgd/vwpxb2XXV+BJc?=
 =?us-ascii?Q?MrJjf9L0dMrCtfYDK291WXFQr1VpAy+/MSfR7JJpvBgHCiwX5gp28yK9DA?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021)(921020)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lzuk+opO9/F91UOmc//11jFuH+D7fm7aJfdFG9dGiotbAr7UEkvQfQgbfXTS?=
 =?us-ascii?Q?zDdVF3jhb7MAlbW5/fFbCLQLO3pcOFh9TBDAY14e9W7IY3cbPMc2fugmL6Th?=
 =?us-ascii?Q?9R1GegtlrZQphBhMGbLE44cSIkB/SXQCLTE0T3u31LEHajE4NdngWOnP/cpw?=
 =?us-ascii?Q?kWI8/pUVrVN/gnGwOFqp8Uute0jXhv+W2RphY2gGRhl77AT1MASd5sxcygpW?=
 =?us-ascii?Q?aOKFA9juVuBdHTSxTQceRHJTwjsrViUmerTFLHORFJYTTr6Cibbn2jk7uZTr?=
 =?us-ascii?Q?Wl/HkshvYDxzTSQWc5QNkyJbDUYOz9tja6e4LwdGHdZ04M1gld3nD0CJTeZY?=
 =?us-ascii?Q?XfQaBqiyoqTIhOmd9qRUfg/NAwkFiC8Dkz+AOtkY1oEhVhzASnN8jqyph4ft?=
 =?us-ascii?Q?bBGc8t3w1pI9j0uT4eevWnWUjmskK+HcQLdjHxbvG+62wW0rx045WlYIFpHt?=
 =?us-ascii?Q?6pf6vOoOVsq3qD7Na5KzZIJXOoJZImW4VLCimTfEV8h2wMq9wGG5/ZO+ORny?=
 =?us-ascii?Q?cFe0zMaPme4k4DP8dFTAF33Mg0Z0HOS1yNYzqNPMhQJU9XvL8Eos7Fy+EDVu?=
 =?us-ascii?Q?cx2Lip3RpJKlgEK3dVDIAjXhWppXyfdzhtClmgVSSM6IgFlC5+NDSIiCM4l2?=
 =?us-ascii?Q?f+DcSZ6j4WN1VPp6qWzWNWlv92i9kHRtsMn4ClZz4hwKKJtwg3wTngu7+RuG?=
 =?us-ascii?Q?S1H6WjwyI/q2AHeks8e90ianZ8+C5aTH+CJ9WTTgpe9hXSG0MiYI5zJFsx83?=
 =?us-ascii?Q?rfxeS5A7J9cFHg78ClgGJnBCdD3WzVRTD06rojVLq3QYs2v68ihqv9yZQZLm?=
 =?us-ascii?Q?6rF8xwyfHXHgHJXHGxR4y7xT/KcM4m/tGnkS2+CcIHXw/oU3sz1Is4RuWohF?=
 =?us-ascii?Q?zeL/vhf9mAB2w3HJ/PYA2RRQUPyUnVFv9DJEPAgQo8iyPM9ruAgWvVko7E9l?=
 =?us-ascii?Q?56j9LnKJj0h5pJ5FXZeTs2hzDpf8fW7Liul+y5XU9WqCE3agE2y09xiMFHwL?=
 =?us-ascii?Q?zdqgxAyzjbbRJQVryBeV9UrmmyOGsIA8dU+APWjpLtzOwC8CI0YL4+DBGbom?=
 =?us-ascii?Q?5l85co8EFyHpDe7BXMR5LW2lR1UEOk88+yzl3Vsy/1KONPmplm/K2OVT2q+x?=
 =?us-ascii?Q?ZE2ZTGspkv5Ei33KkBXEv3iCyshzJboSfCNPipVuMIZkqMXBl4HALWdcYNla?=
 =?us-ascii?Q?RmHgjNxmy8tOhTCxNwmCNQdVlkbxc0G7xWIugO1FwWq56WJzUPbXXXk723vQ?=
 =?us-ascii?Q?XmDtvrMCMikduqhy5x0sKVuNB5790IA7PYulSJE8i3kqMjjx1R8bVSYJgOdf?=
 =?us-ascii?Q?2w7plg2f14oYsjdCrD5BROg1qNPf4/fmVfhsMLNh9xHbbj5Z0NbXVaL6hzFK?=
 =?us-ascii?Q?ufyxSIkCDQycc7jeDK1DZoS+WU2XjT05caPMoHwPCy424TEwRyWGKEQPN/08?=
 =?us-ascii?Q?7NxogzjwDLuEMJxpfgF/xUCRPNUD9J9Fy/kqbDN7yOiCjQSMJhmYKR+OkDnY?=
 =?us-ascii?Q?dGeAXxPmv9ZcRdaURtVrYqvQSd+F7fcPh8+UusdDNFrUJAXHJU5gyDlXBSbj?=
 =?us-ascii?Q?hpMhLjvKh1sKQ4UjFI8=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba452c6-d7e7-4b71-947b-08de01366811
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 22:03:51.9013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/4s9FU+fItbIEvJFmMPMeGbdIPbGV6toGIzuNSGUnVHty+DpeghhKG6GBx6vhgXuKeHMG7uTpcnWvYTWD9Zqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303

Thanks for the quick review, Dave. Yes, forgot to put the commit message. :=
)
About the copyright message. Should I not be updating the year to 2025 in i=
t?











________________________________________
From: Dave Jiang <dave.jiang@intel.com>
Sent: Wednesday, October 1, 2025 4:28 PM
To: Vishal Aslot; Davidlohr Bueso; Jonathan Cameron; Alison Schofield; Vish=
al Verma; Ira Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpenter; =
Zijun Hu; linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders

External email: Use caution opening links or attachments


On 10/1/25 1:37 PM, Vishal Aslot wrote:
> Signed-off-by: Vishal Aslot <vaslot@nvidia.com>

Missing commit log?

> ---
>  drivers/cxl/core/hdm.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index e9e1d555cec6..97a5f27f5b72 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +/* Copyright(c) 2022-2025 Intel Corporation. All rights reserved. */

Stray change?

>  #include <linux/seq_file.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> @@ -1050,7 +1050,7 @@ static int init_hdm_decoder(struct cxl_port *port, =
struct cxl_decoder *cxld,
>                         dev_warn(&port->dev,
>                                  "decoder%d.%d: Committed with zero size\=
n",
>                                  port->id, cxld->id);

I wonder if we should make this dev_dbg() now that it's a valid case.

> -                       return -ENXIO;
> +                       return -ENOSPC;
>                 }
>                 port->commit_end =3D cxld->id;
>         } else {
> @@ -1210,6 +1210,11 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cx=
lhdm,
>                 rc =3D init_hdm_decoder(port, cxld, target_map, hdm, i,
>                                       &dpa_base, info);
>                 if (rc) {
> +                       if (rc =3D=3D -ENOSPC) {
> +                               put_device(&cxld->dev);

Why put_device()? Should we enumerate this decoder instead of pretend it do=
esn't exist? essentially only a dev_set_name() and device_add()?

> +                               rc =3D 0;

Don't think this is needed since the continue will put it at start of the l=
oop where rc gets written by init_hdm_decoder() return value.

> +                               continue;
> +                       }
>                         dev_warn(&port->dev,
>                                  "Failed to initialize decoder%d.%d\n",
>                                  port->id, i);
> --
> 2.34.1

