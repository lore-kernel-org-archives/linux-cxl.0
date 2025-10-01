Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010009.outbound.protection.outlook.com [52.101.56.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BA32110E;
	Wed,  1 Oct 2025 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759351052; cv=fail; b=HpZSqh44LLG3KjPo8RvKyQEGtpde0uMfv/4yG3V83+CXyZkqRdvh7R+2c+mZHeF503/FUE5L60BKpY9AzYwOXiD8RmV5EQ9Q+U5ha07/OMjGVSQhfQtALNsrNvW6XV0O2cMzhZnm9/uppfeYqADG4AkJOUig2FMufwWjj1YYZEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759351052; c=relaxed/simple;
	bh=C8oVFCKKkcMqVZQLp0BC46kMQQrdClVrrpe9id08UJ8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rgJjYHMFdb2PfKoBtyjddC3IJPvYKy8VMjs6b7H07f5i42yOk6s0I/EnrjBzgK+2XuHTOqPcpzoP4Hql6CmlDIqrlkz/jgB1vqBNr1iqiepKr15IqVWBGigZZF49XpDLUp8UxMqIAxRhw8de+luu0HypxCazlc4Aj5czhfr397E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jJc0nVtJ; arc=fail smtp.client-ip=52.101.56.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jJc0nVtJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfndzHPZfj5Zr8i3WiSDBUUttTW/fBXw7dHrHaz2+JoHwk6S7F1XQkhWkch2c+B+6N9FiiLbdVXAwqSERU1UobKMTRA89qxvEVIS9xJonvpLugqfZVvTY70KJfwlcxQs6oIZqLsiUpxoHzfZiwVQaKTAkQ+hTPC8nnBcFrQWgu4H0zKx9A5/WnS7o1VKwurQ2Te9awc3omuqBRBVYSEQR26ofjdyqJv1UTHzSu3bSWmVd2fshMCpb50OkZH/JhBbkUPHryMQS+jtR2cSEJ7m9dGTIigswZz8VqxylXV3btsDtFJx0w+eLRuNC6xSJVJndoivogZmFYuXn20PtS1UXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BLJ8Cbxb117fD+SqTfjZK4g8Toor9Fc2c5TExWJvLw=;
 b=zEt4uvxmAf7G6ci1bHruJHdBWbjx7mGPWGdT4yrQVEvIdCkH1g6/PVI1GhvdeYxe5dYjEf/DW+xNVTUhrbuisk0pmU2jaxd5eMKHAJ8yJ9i+DBugisuJXBli1gqTG8b4b9rnhq9OffroKWVIBiDQrvxXww6swX+2SHiKkuwqEmZvQayNFX6MuDSJH3otyOdXrgjhiMovMgH3EVpSA6B4Xs4IWmwuuDl2Ld8c+Qt7eUKQrN+UC2HxtGRkZCou5xHmUBbxgfxmF58IJgjgnw934rrg7uPL7QbLJIuTd3kGw9ycA/DgOv6YqI5yP93nvdcnwC2eGOrmntSjOwClWXda8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BLJ8Cbxb117fD+SqTfjZK4g8Toor9Fc2c5TExWJvLw=;
 b=jJc0nVtJ296Zes4gxB3ZnjUN4SUhWvrXblrP666ISAMSpEI1v+pnH6H1alO7aA1/mUl+IMj3/nzGTqHq/J62RGrg9C+n8pcrVw8tXGtmU+/6I51TsWErISPQaVxY8XgKEofjcSPXWSEqJbOAeQX529emmPjV+dBl8BoWcR+3fa2CwFWlYmspZb4Z/rApF+BQ4rZADMzogfXCHI11Fw4k40IKIIgpanjzQmKW6M6qzQ/taDg/At5UdNS10chO2CD+dno2BspQfza3963DxRryRrqhp3Oq2pCAKLArRdh7KjI3rx5arMuRIkiiPalEiX8j3SB97yxyazjPcZHtG0CT1A==
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 20:37:26 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::ce21:6749:3d4e:2c61]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::ce21:6749:3d4e:2c61%6]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 20:37:26 +0000
From: Vishal Aslot <vaslot@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>, Peter Zijlstra
	<peterz@infradead.org>, Dan Carpenter <dan.carpenter@linaro.org>, Zijun Hu
	<zijun.hu@oss.qualcomm.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] cxl/hdm: allow zero sized committed decoders
Thread-Topic: [PATCH] cxl/hdm: allow zero sized committed decoders
Thread-Index: AQHcMxKXHWr3vqKdSEWsp5C061+MVA==
Date: Wed, 1 Oct 2025 20:37:26 +0000
Message-ID:
 <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8131:EE_|IA0PR12MB7722:EE_
x-ms-office365-filtering-correlation-id: 09b467bc-6578-4608-6d02-08de012a557e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?VAYl83XRhHbJXass4CvdUZh0ncIyEn13rNbzAdeUjXn4EXSfZcZfW+H/sK?=
 =?iso-8859-1?Q?XwbE0eKy9MEYraYV+23+jTLMBpoAhb2hJYjt4QePkxef6qZOHEV9jGsGEJ?=
 =?iso-8859-1?Q?W7WxU73y6WrE82fGASuZ/t69spBTEJO5fIUVxD39MRLL8MGKcwwt+1YmCM?=
 =?iso-8859-1?Q?afWoveVGjyuIxVVpLEtz5WWI7PaorqNN9/tcjuuj/Y2zagcdDXzh4HKG/k?=
 =?iso-8859-1?Q?PO265TptE3FcAlCzT9CUahiZt7SrVasmPJheODNLryd5oLrJB3aOKEBpj6?=
 =?iso-8859-1?Q?+lxaRrAfSyL2tJRxCsmxHmbhsWh0OitUOKEklgAVtkDg2UzgIFoQDbpET3?=
 =?iso-8859-1?Q?ts31kZal1yfxlE0Jcbcp20kc2ScekdamKqeEq8x5k0OBGDQARxaJyW0ucE?=
 =?iso-8859-1?Q?Efg0V7a1MH6uZkBDGuoUXaQd/bqjKZK4Guf4wcdSaAaeKeMJpb9fk8Z3bl?=
 =?iso-8859-1?Q?3JhXPQYZlRZGWLj9UWdoIWgzkiMLYdo8VMX8BntBpCO49joRJFsZwbg4cz?=
 =?iso-8859-1?Q?OnUK+PllWejI0xOGXwZiH/bQ/EVIvXezDy0SWK4yG0M68VtyAP6TdcgA3h?=
 =?iso-8859-1?Q?nbs5OZzCKspLRCSUcd9rkNUz/1X4qb3jQrDF0TERYMNuvNOKMKU3d1bUKa?=
 =?iso-8859-1?Q?fpRepAmXJVIMjdCwPa1qtzcoUzdZUaISF4dAu5mCOIaCW4rIM4JD2bTEVi?=
 =?iso-8859-1?Q?nTscqB5sbFq/wYBfZnwf5myfQ6Kb4xFHd5rX4JT+5f1s/Q8HXaH/ekHcj2?=
 =?iso-8859-1?Q?5yJypVgP0p+Sj0csvhkkA8xVCREpUU4aURmcrH9HK7qGR0ndRPBPlyCcMr?=
 =?iso-8859-1?Q?lP3lUDHbh9xYoaeSSo1lOEMt5sAIuka8fYznZY9MZM9LxGOCPA6OS0RJGz?=
 =?iso-8859-1?Q?MCKrEyB49yDUsFc8mCCBAzvly/X4n21z9Sq7hFFs2tJzPKjLyqLDMHY5T3?=
 =?iso-8859-1?Q?gpGtyMFotSbP+ZJ5G9/Ognk7uOmggNH4Z9TrZHHS0rpgWq1bgI8uYHmMqw?=
 =?iso-8859-1?Q?UhyPwAaqi8/SY66xQrpEbQEn0YUL6aTt2/GntOxUNFvfAmXVbKQYRPtGZo?=
 =?iso-8859-1?Q?bT5SYZ+1a2eGdFu21eZr0NiYPqm47vQqb+urJcVyU3wYQqMGKUdJwuS5Ia?=
 =?iso-8859-1?Q?61Yo3fqspQbji/hulGBu3FWAP7dyhFzLuTrdjUtLN8KyA6VtwBYwCZ/Oeo?=
 =?iso-8859-1?Q?9pG4SyFLH1tyeopoCZqqblU3jdUwl5SLm2ZBbsFOIh03O6Q37GfewdrQ6b?=
 =?iso-8859-1?Q?CQQlKNlUEqDMVXbE+iZKe2Q/w0WR5G8B6ND+ReZ7buO6/DqMsqsv8R7aNr?=
 =?iso-8859-1?Q?7KMzoqGJ+KnnTy7CPOVtpJeKhd3ujg/Fhv9GoNi4IQSrhPP9cbLy4cdVMO?=
 =?iso-8859-1?Q?a52JD7A4mnA1g6B1QzAUWk+RPN+4ZOcVSv19bzQNw5ZxeOnY3JFBcVFws7?=
 =?iso-8859-1?Q?YF9Yk14bgYKJbsiDotdAMdbeDX5gC36dsTGoGSmVbrggUlGyZD4RUz/O3L?=
 =?iso-8859-1?Q?0DPgUrDRGXHiaywd4SHLSXDXBaA0gcLsNOzQ7+2KL3dYpgcwWYW7ZlSLCK?=
 =?iso-8859-1?Q?lc8shnz/SmHu8G/l18wE8qICwYQzkszgeh3uVE4xZeVBu8gNcg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?nc+SdNpWFXYL8OH+lGlHDnuV4SjBBmasHt+f9KHj1Fe9puC1ndT4/Ayz3r?=
 =?iso-8859-1?Q?4MXzX1kAjICy0Vii5FKzZXy7fwyDIHfUEDQOHwaN8BckCjLlxwyO6Ltg9D?=
 =?iso-8859-1?Q?Yp8Zt7NNmojAHWQJTGjyzuLyOjXRIbFYeiWe+OtK92qro6GUtzBwgGNvsD?=
 =?iso-8859-1?Q?BBvxF5o11dV8OTBt56Aoc7v3wzrT886W9wgAfhS8SJytbwoXjQ0cL/YdL/?=
 =?iso-8859-1?Q?dOB+RFkiEAuy1/p2jZpEABVlrgiWlWMVvJpyQGJ/XgbvwgGUNFjaVh6JCw?=
 =?iso-8859-1?Q?ZMd/l2UgytatozMZQjf3sntGC0vYdM/ogYX41ik17DHPtorEABW4N1KXWp?=
 =?iso-8859-1?Q?AwnPDwyjU5CGlmr2xc9l68CLXwkXm9fHsjWmh41AWni88X6+Ca9uHsN+wc?=
 =?iso-8859-1?Q?LwVEeBLf//fRfuTgKHiSuaIGKjYEC0KCliojiTeFLC+yo8b1yDldO3x6PV?=
 =?iso-8859-1?Q?0YB/LhZ9nLxhfEnemtOUb2CeCw0gwVVd2ORS43XjfcGJFejBcDoG3cbP6z?=
 =?iso-8859-1?Q?sDyUekT5YXrD2mGDkTZlYCb23NvwEni1auekSZJ4kAqruiTmU7lFPDH8GF?=
 =?iso-8859-1?Q?1QQ8A3f9YTAdC738Eh24vo8FGTTyDpBGpyqJG7mkrntSIqX30cAUS7a/4d?=
 =?iso-8859-1?Q?pW10QFMg6qdxR2ri75lmGXkYunp7P5bMDjMSaSD1/XCAuhINixJTaePUxC?=
 =?iso-8859-1?Q?ZqI+nOe5i3CZFd089Mz5+5jh5+zusiG9601cgaC9Hy401Kr5joKPRURNec?=
 =?iso-8859-1?Q?+pmmw4YGRrlr+qbjjAwbgtUqmdl0z5EoqwvNC3c9WABUYntBxwTVOcEpkL?=
 =?iso-8859-1?Q?8vmKwR7FUoULHuLXd9X1U3DY/VNag/9dUpw7nswld/fk5wptcLr8UDKq/s?=
 =?iso-8859-1?Q?xKJLAzHDjep+/jRLxzi5djD10a0pM3prvpIuscPkluwAgLm8GMyb+grNDW?=
 =?iso-8859-1?Q?BIHqOeDyjmCszSmjA4Q7XfsxW+Cn7DMfqQo2fD/GsuEHr5FtVtglClWZAZ?=
 =?iso-8859-1?Q?uVDF33dogWv5l7GIwIkOKVaRTGjgKvioGrZSTStgVYTp2uyVL5zXvMhI/B?=
 =?iso-8859-1?Q?r5IJZ0kOR9eDIzyvZyYY0+t8MQ/PmNdzyQQ8JKGe9PSZmlm42xgT7uj7dm?=
 =?iso-8859-1?Q?7cd6GXMZ8H4YPP3OIQknsf+L9im0L0507Oa0n+AEVGMbe27YBWgABYT06d?=
 =?iso-8859-1?Q?nDGsio4A1PRNrsMtAj5W5pth2vgt7wvHs3YNLt5CLq2V/bc8YCVtStNYEN?=
 =?iso-8859-1?Q?hoFsa4FNOcqE4ZA8P8KgKH0/b5obx0aNLGNRlwM54Fj1ZQCrGz/X0aMzNi?=
 =?iso-8859-1?Q?3bfwlfqWAQG7HQeE1hpyCFbdOXMzv3heFjpVVXnMSNqy7c/NC5XKOi1WhL?=
 =?iso-8859-1?Q?iNcJCFf7EyNWh6pE7vG+YpmMjruXpSnmSncU8pt3oKwO/FeY/S0dvTmV0p?=
 =?iso-8859-1?Q?RkqEqhCxxGXx4biXwRvqeP+8F5WssTBn+NiB2puu3OHuEZ74YRRbSQ43n1?=
 =?iso-8859-1?Q?LI+MDVn/hTy/KEgVZm/HiRqyDgdldBGN6CiS04cFEYNdTSYPP65wDg15MI?=
 =?iso-8859-1?Q?upy3pUt8m2LFmp24dkvp4nm+RvTh58O+WDtP2ZB5HtuMPiK6+29Ty0+wtL?=
 =?iso-8859-1?Q?tazFWut46D6Q8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b467bc-6578-4608-6d02-08de012a557e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 20:37:26.7505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +FlUiZMI3RSkKUteK3HbFy21RwIHVxDmcJVLmrPW6h6slL37d9STvbZ2n2SKoUCuMlfwJ6rg/XYe4fUzE7VyAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7722

Signed-off-by: Vishal Aslot <vaslot@nvidia.com>=0A=
---=0A=
 drivers/cxl/core/hdm.c | 9 +++++++--=0A=
 1 file changed, 7 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c=0A=
index e9e1d555cec6..97a5f27f5b72 100644=0A=
--- a/drivers/cxl/core/hdm.c=0A=
+++ b/drivers/cxl/core/hdm.c=0A=
@@ -1,5 +1,5 @@=0A=
 // SPDX-License-Identifier: GPL-2.0-only=0A=
-/* Copyright(c) 2022 Intel Corporation. All rights reserved. */=0A=
+/* Copyright(c) 2022-2025 Intel Corporation. All rights reserved. */=0A=
 #include <linux/seq_file.h>=0A=
 #include <linux/device.h>=0A=
 #include <linux/delay.h>=0A=
@@ -1050,7 +1050,7 @@ static int init_hdm_decoder(struct cxl_port *port, st=
ruct cxl_decoder *cxld,=0A=
                        dev_warn(&port->dev,=0A=
                                 "decoder%d.%d: Committed with zero size\n"=
,=0A=
                                 port->id, cxld->id);=0A=
-                       return -ENXIO;=0A=
+                       return -ENOSPC;=0A=
                }=0A=
                port->commit_end =3D cxld->id;=0A=
        } else {=0A=
@@ -1210,6 +1210,11 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlh=
dm,=0A=
                rc =3D init_hdm_decoder(port, cxld, target_map, hdm, i,=0A=
                                      &dpa_base, info);=0A=
                if (rc) {=0A=
+                       if (rc =3D=3D -ENOSPC) {=0A=
+                               put_device(&cxld->dev);=0A=
+                               rc =3D 0;=0A=
+                               continue;=0A=
+                       }=0A=
                        dev_warn(&port->dev,=0A=
                                 "Failed to initialize decoder%d.%d\n",=0A=
                                 port->id, i);=0A=
--=0A=
2.34.1=
