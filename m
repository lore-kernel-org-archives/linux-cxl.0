Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013047.outbound.protection.outlook.com [40.107.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3105D2F2918
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060533; cv=fail; b=hpX3yh+b6/XSlpUQBIpbwHjGzBGsFqo72N/4LXDdGyX7JKJlLcP2gNmQUZYamoUCeSlu9cXD+B419sVGaKFp2SX6jl7o8JCpVdh4WrrUhLv87wzf4MOrafUposLQgaXlhmzMLp3wxKCaGzby6wViOeEjrGr/CFEMTFZMTLASx1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060533; c=relaxed/simple;
	bh=YoVwDx+A8xNhnxXsktGeK+5ia+8uF4jGNbnNlrTqUj0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sFEGUJMGObHjMq6J4xm64/R4IZGhpCy9VNQ4W30bL3qrQub7B0iiAbWE5coorrUqS3qfllS813pwP+SQ5Ek053n1mZD7LTAzeVq65O31Loin4X5dcGBGwWm7Fa+XiUNMeyk6bwwYzFPJdL5ZRPFGxvt8irfdr6rCWoaenQKY+PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z0tUaeS4; arc=fail smtp.client-ip=40.107.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z0tUaeS4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKYmgI75HbzbvW2jYTA8/DQiMDKljB/X3GEu0dC6S6kLjsFlwviZ6kEE7RuVVggxrJQCriwL6eoTi5xh+cTUeDXMX736Bfrmd6XdLKWN8wQUyWNugCQS2pgZcs7Mfuf8DymqtHJ5zNPVxqnZAdouVFFRGTAdctDwkazPNmXvZYsBYZPURUm2ifsjqIzrqXag1Nd7+53QXHB8H3pxoAZKTSIF3VAPn/xJRxDzJWQI9hZALiBRDXEOQtEkedcA1H9vVj+N0eV0rWO57Q+D74pLWbBGxQoI7MXUbot0s+sWnvUjwWzlBIT+Wz26OQtTGpLJuCRfDuxC/X7pOZzmloaZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoVwDx+A8xNhnxXsktGeK+5ia+8uF4jGNbnNlrTqUj0=;
 b=gMkUmXvIoUFiJaiwg/6YDTKULAHbXjTmjRlXskVWtZy/jFgsTYWxLzFiKs0VsAaNHm7oHjr/KWgYvHUU0A7DAXYUFJduYpCY27HoPCVd/rV8weBuToBBj8fPj6X4qkxbl7I8BQEz6ghy3jJMjaOUc5O6rqVOGNV9uDe5WIBVyg9hOl09uMvcXwc0dpX8KPtRj9hFTgZCcbpigl5jHSKDTK0li0VlnRchUMpoZXPbX4Ip87URK/7CS4nWF3hifDGb2UfK9J7tqrFkpzDjRT1GekxWZ609B9dwf3gcpbWCn28Md3OR9mSQJF2XF0tfUhV7a3yf9lZg3tsp+SPPtw1t7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoVwDx+A8xNhnxXsktGeK+5ia+8uF4jGNbnNlrTqUj0=;
 b=Z0tUaeS4KMesSzTNEq76vy+yBiX8hi35p5aOyAFHEZoTyYgGRXlK+zuCNwKs7byA6jRJN6hVJOT9IVJLDjfrqNiTcxOk6ZJwXFGbQjko0iAHTguiGdbLReRXb33J22Yw9t6/JdsMSTYwpTdrOafrmYqDWYskICYi8jW1BPYTcPXJFo8FIbbUw91fkU41u/El+RjCOEkmshT7Py1D2I37vIor9flO/hBhUChD48bkYWX+S9zoKCHF+2Y5HQw8sVADOrJx7KKkn+ybOhCznJSXYX20+l0X3ldpFxqPkgk5lJ0UnzGF8SHcsSqpr56L+DezPAfv6k6rwlHp3eGHAPP9pw==
Received: from PH8PR12MB7302.namprd12.prod.outlook.com (2603:10b6:510:221::12)
 by DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 19:28:46 +0000
Received: from PH8PR12MB7302.namprd12.prod.outlook.com
 ([fe80::4053:6879:df3d:d4e9]) by PH8PR12MB7302.namprd12.prod.outlook.com
 ([fe80::4053:6879:df3d:d4e9%7]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 19:28:45 +0000
From: Vikram Sethi <vsethi@nvidia.com>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "Natu, Mahesh"
	<mahesh.natu@intel.com>, Srirangan Madhavan <smadhavan@nvidia.com>
Subject: Re: RFC: CXL Isolation Support
Thread-Topic: RFC: CXL Isolation Support
Thread-Index: AQHckiFBWYeVaAss8U2Zs8n1XhXOVrVvx/cj
Date: Mon, 2 Feb 2026 19:28:45 +0000
Message-ID:
 <PH8PR12MB73021E109090464B4DF9BA0EBD9AA@PH8PR12MB7302.namprd12.prod.outlook.com>
References: <b4f7a760-5cf4-4343-8f7e-9698ba435fa4@amd.com>
In-Reply-To: <b4f7a760-5cf4-4343-8f7e-9698ba435fa4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7302:EE_|DM3PR12MB9349:EE_
x-ms-office365-filtering-correlation-id: 342c5cb3-3648-4f0d-e7bc-08de6291487c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?OgEEvImXX3r7BzEYKda45gX1ENVNwUiQQqEoIdlJCNe4YdZHVPNjVWmerk?=
 =?iso-8859-1?Q?s7uNA1ysqLXFaqkMMQjZJA66PVEjC0dRNgTnONYEAGcginTiGamKe9HYT1?=
 =?iso-8859-1?Q?I16rs0wxd8A/Lmg8MB9M9EgtlGse1DNOW8in/xcXjc6nS9T1CNrfBx9Gk0?=
 =?iso-8859-1?Q?2Cu6CzVb2L7uIfFC0bX0XqZRQhoq8szyRw06lwoy3W+G4LcVotOXq0dpI9?=
 =?iso-8859-1?Q?7aLE0hkZUNsCQeysp1SlTMenWLnjPVnMb/fs3jXspfq87lFhvKcafHSGmh?=
 =?iso-8859-1?Q?h9vEhIyobAV9NF/2IH0xb/FXhY1GoXmMjOHkUx5YNiRPVtviBaeFEkmu/k?=
 =?iso-8859-1?Q?VGksDa+ir9hdPa5N0lTtTKH6k6Sj5kbxSfWZ7L9g6E2eNsquvko58bOZam?=
 =?iso-8859-1?Q?iFvEVAxodoVTjQfJo/WvTee29WS3g2di7vA5//bDWxZ6KOJM235Rv7BL6/?=
 =?iso-8859-1?Q?ngycZW15ukXYgrxV/S6k3XCYMuy0/2k3B1OSRodX0MKfJQoLZRohq5wTJD?=
 =?iso-8859-1?Q?GF8X2L/Z5Gk6pYRwkJJIi7KfOvO/4wAHqfOu22Wp137ioN5TppGZrwh8/G?=
 =?iso-8859-1?Q?WhEY/Q4udhwFJoJs03LglIeDIm4F+mCBuzxHzvBs3IhH0mJKpdDREpVF1u?=
 =?iso-8859-1?Q?POR2MY6WcVuDC5N/vjuz0VCdGRUKYHsyFlITJ4QqWXPEjGHMzwWNjc5Jad?=
 =?iso-8859-1?Q?LIfACdxFGduMA9VIZW1eUXeAR4lkUp8dgs9rlF5Prx4wL8WuqnCk3/oMNy?=
 =?iso-8859-1?Q?7TiSdFI7SxMDAiCLrZuCnHCJ8+iDBJ0wdvRAtHfXraFt56kwTBKO38fUJz?=
 =?iso-8859-1?Q?jo6CwlOJTWSX6gw31OCpXyI5rlmc2A2gFStOxYLt3XNBzD+D6W99vB6nxI?=
 =?iso-8859-1?Q?hzEZTBn0YcX1VkH9FIxD4dN099seR/ekbaiccUgbL8l+zknOStZ1a/isrZ?=
 =?iso-8859-1?Q?km97poxiIG83fOPyDV18WfGbG9J4LRJA8uq0WrxPB9gttAEbOBPazST2Ki?=
 =?iso-8859-1?Q?ywIEBLIzAxzDlfVK7bV8Y5mz7TzGSQSv0zogfBak4IQh9sCf6GMKiL4Q5j?=
 =?iso-8859-1?Q?YdnB1kv+nO8oJ3nrIRQ8Deno2AfrQu8o5EX3eu8unUBesddCoLwl2Ykopr?=
 =?iso-8859-1?Q?O6sZzsEGxOtvJzZIXmpTdnNK8I4gt1hhj9tn+3m9BnNctzL99AF9Br8vtF?=
 =?iso-8859-1?Q?/ISfH2amqK9LDn2CX/WcpTpVJ3TITaFUlYioAFBKzT+YEzCIQlHMsbVbS8?=
 =?iso-8859-1?Q?3qMx/jS8ox2eIv8ICfen/B/FqlZfKNVdXkh1N7/KkYT7F1Zb5ekVFPVmKx?=
 =?iso-8859-1?Q?xrHQ/Pb4fyvLJiNgFOdHFdNpUG2/+rxf8v3FfBxEpduEzhPNCACsI1ldgk?=
 =?iso-8859-1?Q?XK84mrFpcdZfa59EgEL7RDesbfQ5vfcRpO1EJaBYqCjJ3Bl7AXzIjVx5af?=
 =?iso-8859-1?Q?rn9GejOtHXtkcB8sQ4IFIDjFLD4DrPS/db5oLoSusqbnk1C2SXZ6P8ZGiq?=
 =?iso-8859-1?Q?qCTpbXJx1ukhFSh6Rn3atd6314uU7EDkWDK+mYDEP102zTa2TS99MHuKgv?=
 =?iso-8859-1?Q?ksyyDx8n69rHEAF5EHbMe3gRt6KMLBs1KnbMZty/8r9mqxf6bgv+7LWG2P?=
 =?iso-8859-1?Q?cQUB5bFqb2noUivYA69M2z7snKPAZyE7ZKuGvqdruUkEaC1kuEEQN/gA6k?=
 =?iso-8859-1?Q?RYrroRQkrZVsWAsqdSQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7302.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?RJrJbzes0oimFcSaG9Y8Z0mKx+bfnCFWj5PeqU1XPUX9o1zgn/bzFwSw8K?=
 =?iso-8859-1?Q?QmI8wb8vGVh2P9BNiX6ozdZVZFFIlE0IZzj1Lbl1OmExWayCbnrGlel3Wp?=
 =?iso-8859-1?Q?cRAH/x/1g3p6UOT7u/Si/euwzvjUTvsG15K815PncMZ/pLAz0wDovZZ2Ao?=
 =?iso-8859-1?Q?uR9FNw2GksVAPPrleOLBXE8P16tIgJv/gNBWsyNjd9U4BZ8QOi41ESF3Qw?=
 =?iso-8859-1?Q?M74EviF7caB0+DqaOYUJJpbr6aRYNAYkffG9EZn10iVfaCLzdHeX7m/ejD?=
 =?iso-8859-1?Q?S1S29Gel8NDolnIfKd/y1L/MUB6HIV5tgiB9oox0iYYsdAlMS5clJODIjK?=
 =?iso-8859-1?Q?RebsD1DEKHnlgiQ4guGzrq6bsBJV9UB/F3U1WwYV13D3rbul6ITUOSxbzO?=
 =?iso-8859-1?Q?3eThS+Evg3YCy4dLAPXvsJo+rQxHVRlbRmMcU34uv9N0gcyk85r4Xq4VbT?=
 =?iso-8859-1?Q?eviJAE6SdcYH+QsJRM3YTMJ2386nGFilQ/vbSegmTh9VdJb8ae+/y/QrYq?=
 =?iso-8859-1?Q?7dwL2migY03nFGhrFEWC00tcUY4hwDj38AVdCbEtn+LNUQEW/pDwYCxIAt?=
 =?iso-8859-1?Q?g9S09dYVt6K7C9aeQd9IeDGuKLLSklPSNEsIHh3jGEnCc4K9L0dj7nHnvC?=
 =?iso-8859-1?Q?vfITjTQVpbnyK3KGpEqD34n1Fkh2xGD7BIHD47xZ8MKtKMSA9LdKhdy0eD?=
 =?iso-8859-1?Q?urd5LLEREcCjz8vIdtX2bQOKZOgk9wYylw2viWNtm9p5ZkgfsJtl589kJN?=
 =?iso-8859-1?Q?fnzCUzPzGNDhMeSR5teY9c9MyVNgElfuIn+89VMT7L+ghp0qJsDDoS6pwv?=
 =?iso-8859-1?Q?BNMpANi/HACKMhHms7QMZuYqAkiwg09lwP6iVaPzXLaeXpiZZyjW2NFm33?=
 =?iso-8859-1?Q?opdrnBIOhQIwJ8DF63oIVlAt03ax+e3tLJuJc5YdAPdRUsR6lAsPKsDjrG?=
 =?iso-8859-1?Q?iiom5r7Rym9HDixykHz+aAFvW1+XiMSn0hFEsen0iBOSGBExlM3Px5DGyC?=
 =?iso-8859-1?Q?UPQbfEuNpwoqPiH36fWnP5B4wrJfhTI4caHjkKYeqOsLb73vefb1Mxr3CY?=
 =?iso-8859-1?Q?Ie8CDaF4I5A9RzA+Y7rhMZ5ABowHhAfI0Og3RE3kduu3ADqc1nZ/8WsL+S?=
 =?iso-8859-1?Q?Yx8HIyg1Nmf1ujSWIgZ6f97Asvc3ezM5blbYFwO0qQupEkWM+xj4ZjsGRF?=
 =?iso-8859-1?Q?bQuAfYwWZf/H66ux3tJJO1sE5ey4uFh1b6tUocp6yq2ARqWV6FvFTcCBUQ?=
 =?iso-8859-1?Q?rsoRDSf0GWUjaPLLIifmS6pJwjE9iPiymgOqzpOsZDREm20Kq3n5dIe35b?=
 =?iso-8859-1?Q?nzhUNLYNpDvD1J0afBQ9XyE0IS8cCfdqQYwhI608b+jrxWxROrsfyCmCpp?=
 =?iso-8859-1?Q?jLMoHV/sO64UVufljnm+iDCvguNPRW+YJ8IHBORDGzx0ofcb6SWXlEtAOY?=
 =?iso-8859-1?Q?MNsLxxAqHRiEABSgSzWCscbpsJAd71a3OjTE/ciD8JBSYgfH4FuFsSm0yl?=
 =?iso-8859-1?Q?MbeGxa6RV95z0UKZ6L16+/EdVJMckLgyU0Vl3mgcp47/vRXeiYDllBNfTT?=
 =?iso-8859-1?Q?y+zAD/AjoAvbZb0wjU4lqpJiLTqvFUifsXVFQr4yw38FaGAv1x/lGhH+0o?=
 =?iso-8859-1?Q?BhMiLmgkflvz1u61VL0N1827WU/b88cqFVtyJek5Qt8SUMYPgT7sByP7qu?=
 =?iso-8859-1?Q?8hSwqamaV2sGnDdDUmIESkdlbsVC10wv/VauMlovV6zLEF7418ayXFq7MV?=
 =?iso-8859-1?Q?Y2jum49nkZUzpRjoLut7+HVA9WAkA9zcO1WatuXy27GUUh?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7302.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342c5cb3-3648-4f0d-e7bc-08de6291487c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 19:28:45.8718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oh3pC2CyGaNme3qnjv9F9bOJDJM3CyZg/wOwCCuz8h3yaELGeCpSCcAh+1H+QQrblCCWioFeK168EqSzSmLCJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9349

Hi Benjamin, =0A=
=0A=
=0A=
________________________________________=0A=
From: Cheatham, Benjamin <benjamin.cheatham@amd.com>=0A=
Sent: Friday, January 30, 2026 1:47 PM=0A=
To: linux-cxl@vger.kernel.org=0A=
Cc: benjamin.cheatham@amd.com=0A=
Subject: RFC: CXL Isolation Support=0A=
=0A=
=0A=
>Kernel allocations in CXL aren't a problem at the moment because if the CX=
L.mem=0A=
>link goes down the hardware resets. When isolation is enabled, this isn't =
the case.=0A=
>The kernel can keep chugging along until it eventually errors out trying t=
o access=0A=
>the now inaccessible memory (possibly causing data corruption until then).=
=0A=
=0A=
>In my v1 submission, I opted to just panic the system when isolation occur=
s when=0A=
>any CXL driver couldn't handle the event. The handler for type 3 devices=
=0A=
>(cxl_pci driver) did some RAS stuff and then panic'ed the system. I think =
an isolation=0A=
>handler for CXL device drivers will probably be part of a final solution, =
but the=0A=
>handler in that series was hamstrung by allowing CXL memory into the syste=
m ram pool.=0A=
=0A=
The framework introduced here should also consider just .cache (type1) devi=
ces, and type2 devices. =0A=
For the latter, the usage of the coherent device memory can be controlled b=
y the endpoint driver, and =0A=
can be limited to specific applications. Kernel panic is not the right scop=
e for such devices for CXL Isolation at a RP which has just type 1 or type =
2 device under it. Error_detected callbacks to endpoint driver followed by =
CXL reset of the device is=0A=
appropriate there (that can come in a follow up series once Srirangan's CXL=
 reset of type2 devices series is merged [1]).=0A=
=0A=
[1] https://lore.kernel.org/all/20260120222610.2227109-1-smadhavan@nvidia.c=
om/ =
