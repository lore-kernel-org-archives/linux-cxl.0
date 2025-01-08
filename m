Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020091.outbound.protection.outlook.com [52.101.193.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D071200BA2
	for <linux-cxl@vger.kernel.org>; Wed,  8 Jan 2025 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736358951; cv=fail; b=Q3dz+niytYmrP6dO5k/cBa6Y6Yx/xp9J41gRWFVit8GUXW1N3kTKvK9PQ3yvpELqrNqIm3OuM5+Ceo7aoZDA/o+2GPKribM2QK+/N0vczLVzIoAwwmwQYpMD+usRJTUW0VAe1m11hE/3opNdqSci4cYzS2vWFrffGOTGKs5+FpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736358951; c=relaxed/simple;
	bh=t0Hfk4c+BUCSKuTeALRojCaWZzzYI27SgtxvJcWGXec=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Nxgh6UUabv7ebTbxI/gDzcgwTg1l5QOkEuzzO9Sn5FcSdn3+opbuXpwn+tyv1f7KyavQaVRRP1YavGtG0a5QRTxSUxzSPOecN7OFzGwU/CRdh4lFNPMWWdF/WFrsKtMRotdGkDodNIGeQmj2ENE2sHU0X0FsgQArWXceOw2Ccj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gatech.edu; spf=pass smtp.mailfrom=gatech.edu; dkim=pass (2048-bit key) header.d=gatech.edu header.i=@gatech.edu header.b=qrreUMcZ; arc=fail smtp.client-ip=52.101.193.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gatech.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gatech.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gatech.edu header.i=@gatech.edu header.b="qrreUMcZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjDQXjr56s06uW70k7ZCoSb+Lq9ebJhehg3pAz8SF9XE/6bXFgX/OAiuSdL1AXqSkIAEL7f/ezy4MskMgnqhmHp0MZ9AXL0gXt4C0hd6F8KJ0F/yLnwY/ZXhxk5LsdmTWvo3S6a2M32oceoZPzQ2WxaSltPu8kj+3NK2NrRjdtItgQZ6fwijRVdZyWXWssPaNBMbZbAuoicYLupB6AC3mGWWg8UqMDznjyWBwW9eGrk+8Jz36OWpGmE6yUB1YUdDfU76v4T1Wi/ybZnBIjukScwc14Ir1sXICKRTG+woxPaJ/kJoXH/qx10LENLJbRapWMxO/ttL2YkPPaYfh36MRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5hVF32LFHjF82Ao27iznTkKdKOFslNFT+DCrIpP5yI=;
 b=d9qd5ZN5XRk2NLEllApRkCX6wTQzTkeUxVadKh+RkOgBo0JkCzYz7u+EruJWpNZPh8ohma8G5y277xwLTOqC1dB3/wbMSCy6k5V3oCvby+XKl1poAw71qxLs8L4QpDO1Bji4boN6jpvIQkX6K8CgrpCxRxO//Ge2GjvnTFRv8zVrTvqurLj7KztR5s9ObbEjzrJkljkpio6EreWgB+WJ2WbTl+QWnpQvwG8T34YvdDOHi+7TfhlU//g6nTyyY8mRLoPCKmsQohTf8O1SNOr+4PlY+9BOZLWFbTiX13rudbNeYSoeJJoleHzIZmJD+Z17qzDvpUenKh04nUBA29h4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gatech.edu; dmarc=pass action=none header.from=gatech.edu;
 dkim=pass header.d=gatech.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gatech.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5hVF32LFHjF82Ao27iznTkKdKOFslNFT+DCrIpP5yI=;
 b=qrreUMcZKNRtW44vG/1WqfZmjE9dW+qs+7gv21R61fSvtQWIGKX7f6qf0AwHL9CcOhXIJ+/AMV5Apm3Gva+AIZKYG3BID27CQl39g3gCN2fbxTGEQ/GtdfqYgnaEv+dfij5OMMSPwMqW7ZAJOuxGYVzewAFMcF7kWTLej4iXFKQDMpu1dRqQ8z3rzQLdd7Z0qsas2ZtwaNKymfTBXj1UC9hbfnisEDSkuT/RqZS59Vql5wEdJP/ik6sgDRsYTTnSoZXO3XYvx6Xzev7KMbcOs3HV0Q76IL/uYbLS3HX61K4/y6RUWUZzzcT8OJMRthmFpm4TYxSschwTPRkYsQ3Ixg==
Received: from DM5PR07MB3548.namprd07.prod.outlook.com (2603:10b6:4:64::13) by
 SJ0PR07MB8645.namprd07.prod.outlook.com (2603:10b6:a03:372::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 17:55:41 +0000
Received: from DM5PR07MB3548.namprd07.prod.outlook.com
 ([fe80::c71d:8a93:a3ab:4ceb]) by DM5PR07MB3548.namprd07.prod.outlook.com
 ([fe80::c71d:8a93:a3ab:4ceb%5]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 17:55:41 +0000
From: "Olivi, Matteo" <molivi3@gatech.edu>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: How to programmatically discover online and offline memory and its
 latency and bandwidth from user space?
Thread-Topic: How to programmatically discover online and offline memory and
 its latency and bandwidth from user space?
Thread-Index: AQHbYd+dAQZEXdWNNUWZ/UfWlxzzgQ==
Date: Wed, 8 Jan 2025 17:55:41 +0000
Message-ID:
 <DM5PR07MB354837188B085472F4EE3B5397122@DM5PR07MB3548.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gatech.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR07MB3548:EE_|SJ0PR07MB8645:EE_
x-ms-office365-filtering-correlation-id: f02dc5e7-5c34-4571-040c-08dd300daab9
x-gt-tenant: 042d12d7-75fe-4547-b5b6-0573f80f829d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?0bd3POa2Sl98fTZ8IXjCfaFybK9X0bkwJwyRmqa1VlLZAU3whpekbbxeeK?=
 =?iso-8859-1?Q?wHN61VutwVIfJF3sRp9wmlF5t+2tdFAbXnYIZAxIUXAZzxphR3UxoOJP31?=
 =?iso-8859-1?Q?HQPujEfUNDALU0IMyazW92E2VfondZdgsaswnT6UhWiRWqYyzmVzi2PANl?=
 =?iso-8859-1?Q?aAn2LLxWeioeD8i7vNr0LPQh/BhUaldvOmnjsXQLdIakyhAecpfQlMQjwM?=
 =?iso-8859-1?Q?naCZnje4ZYYFdME+FD+ki1wBifhGk1kBbrtDVtK7kRC2Eh27TqwcWwpyiN?=
 =?iso-8859-1?Q?Eai8IXqSgoEwhce7JyWLBwE4xeMs0ppY+pHIJLLlB+axSLyv4IpsQkE9H3?=
 =?iso-8859-1?Q?cZ6enTX9A037TgLziZNQVrNjJJlRF5SsB0+EVfeihUUt+g9dGr7k/dNoiz?=
 =?iso-8859-1?Q?bPK2MsrDS2ciQ6saHFvudctvOOxu0hIrMq9tLdevZDqsAbrDiX1shsWJJT?=
 =?iso-8859-1?Q?8QQNXqGLzccPY++ffLTeqGw/NDjPlngnC7NP8fhqIQzTIqpF/huTKJudPL?=
 =?iso-8859-1?Q?Xqb2bMOkMmrJ21VXkV68bdSBMtOGuHZmFJt01jc/rSSq5elXgvIzGuz0Ge?=
 =?iso-8859-1?Q?CsUdH27s9bSgCqrx4tWnJspHBS1OAieIcJ71YpLuDR8TNev+hHBEv3rVSF?=
 =?iso-8859-1?Q?QcADXbQ9tlBg1HvKI7fk2rvwo7Q3wQCIYu3JZVgFaweYChC95OxAH2Navy?=
 =?iso-8859-1?Q?lWdnEmdUrpFHu6QHzcZ0KidghBHtBUuhqQXs01oYZ4Dlw5mdcMPD1vxZpX?=
 =?iso-8859-1?Q?HUdQ7gIw68wHYLbMiq3Xx+DPvJ3Z4fcsZ1JFV6dphk+mQhojlKz8u3ZqWB?=
 =?iso-8859-1?Q?6wOj8FwLj57DylH4LxKBuU5ye7A+NQ/Y2fymacG51DXGppnTZLOybICkqX?=
 =?iso-8859-1?Q?gOnzf/oEfyLKriyVhpgTJw+u+sLtMdpC3MvlasaaO+jxYZElyZ2R4PrwBM?=
 =?iso-8859-1?Q?BFtMBp5FjJPv1J/4+coLXUsiVdfOlDaW1drk5rq4MydMUcGe0cHI3hMshq?=
 =?iso-8859-1?Q?H/dnwfJnvDrbxGrNJ8IROzT2kiCHRTjzhaSUGVoqPdBDxSeNzqkN5KTett?=
 =?iso-8859-1?Q?2sbYDCPP10KDrSGeTChoZjfOQG00HVHWFpPrLatReBPkNNUvHyuyYxHNux?=
 =?iso-8859-1?Q?SOqHmE77ISBl+wF0gNKh7mINp5sRFH6lfKQJWrfcATroJGfDqccZv+7Vpv?=
 =?iso-8859-1?Q?SMJTy0FkbxMamIRsKq3X8wnflLh3AGYLm1nLIGrzAQRpoXfLOuFWyhGag7?=
 =?iso-8859-1?Q?Jgr/L5qXxSY+Ghhtp+e69Ur57TBhLgMMFasXoI79m7oUC213X7e3ZyeCAe?=
 =?iso-8859-1?Q?WT/wjw4iISBKekAeK9q7+vLb9KF+O1dArC2RdNZ7qTHlxBSMB+EP2HEjeq?=
 =?iso-8859-1?Q?avAH8xyDJ6AeNTpC6qL6rk/TsR1phYdwZRKJRSJZDCLTbUVpwTTiVfRq8d?=
 =?iso-8859-1?Q?MBCl3j6HZMlAzbqGg+/izLXFT8AAdzw1c2v/od9HpEyA+uRN8QH4Sb5YGy?=
 =?iso-8859-1?Q?k6e8i1Vk5ydimzHm52C7fO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR07MB3548.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?78xGWLT8BAyrgfkYYU99IMt+VRmQAnyflUhsknjzL0rtqs8c3jW+n/rTrX?=
 =?iso-8859-1?Q?44umTRDzlYkupBBt2vZVInZtHUmzlKemkGIhTGc8Xe2Vb0CJ5cjwaoURaL?=
 =?iso-8859-1?Q?EoxbIG2SAt1MVorZHfNsIpPGMt/DwSBjboAD1JkY503hyioJzQ/Gbw2i8k?=
 =?iso-8859-1?Q?XgsUlLDA2x61n9BesHUBP1E1ZCGVAYyJEuTBHCwp4R2Mzb+Y46nmDoj8Qh?=
 =?iso-8859-1?Q?gVfAclZcXrhtYFDNqagvkJ28akXlETI9jyiPVVgORbzPEteIFQGEtgudNy?=
 =?iso-8859-1?Q?lVJ0XAx/u3sWgHojHFEqZuv7fuTB2zqr0hRyEU/lff+AhOnsL0xqnZT2UE?=
 =?iso-8859-1?Q?UdJReu1Fl1r+ZxSexEVELrno8eftQ9Q4maePawZXNzUk2yTSPUM0Y0574H?=
 =?iso-8859-1?Q?l06iSjpi9FEWdw5p4Bc4Mrs4Jlj9xgeFF2EfXi/4sDe5WatM8259DLANAH?=
 =?iso-8859-1?Q?IEZq/kKwyJoI2Rzv/eVX8q6OMGwXoZsnrVjtaZ2u5iLYK0NPeTeQjC3tg9?=
 =?iso-8859-1?Q?aicmxwhCCP9drLwP9qhIMIpcXEkN1AphcD47hLC7u0J1BDal5XhHMj4a2q?=
 =?iso-8859-1?Q?4gDN49v8tTm1FTZEuRjPY+/uXEWxjY5NN6ngQbGcUGjPvhE9x5M04Y9buh?=
 =?iso-8859-1?Q?oW2MZAacvJPV7y/z8l052lV1f3ZNw56UBY4s8KXKc7iXu1lSSa/G83CsfC?=
 =?iso-8859-1?Q?6Hwsxy8iYmiweB7M+b0GSs/SYVfrHiYK4Jl9X5sYYa8JEQGCv7KJ5cUTiH?=
 =?iso-8859-1?Q?1aYfNoI4ediYNUwZkdXq1OuUF3hk+lOuujp0QPuRNSigu8jLTwQQB/PVqz?=
 =?iso-8859-1?Q?qEmucfgE/irHa8gHpaq1ugnQDkllhi/e81VBR/GXzkfIqXshg1oCiK/rVJ?=
 =?iso-8859-1?Q?Ub/PmPnVqG6lAfeZPajqO7/F12GDGjy65/kY1HdooWn+g2o3CY10XUmQM/?=
 =?iso-8859-1?Q?EHIuv82JBPTd9iNkK7N7sP5ACjqMW+dRlw4oj/7CBIxcBugAxYhHFlrngZ?=
 =?iso-8859-1?Q?bDplcmGDRCjCHyN22oJzWcU/5kboYa4LSsb8E9L/kJiRk/pccnccy2E822?=
 =?iso-8859-1?Q?riOEW08D3exg8s4gI9qdENNTIHpL/DMgw1bTw1QurQm3k7/+W93y3yLYBI?=
 =?iso-8859-1?Q?RcTLndMepT4pV20GSc57VwcmtQUethLh/k3Oshp1PJuAzX60Lq9t1lq0cG?=
 =?iso-8859-1?Q?m65EMjH/e9fxaomuAb1WOqbbeHINIu9y55oNHv0PPThTCHNYDtpkNnvsSr?=
 =?iso-8859-1?Q?FkTsNgXgQ2OiIuZJ5lpGG3lZ2DdF9TmnucoFbmtAT/hjwhSxm1LYtpAmVK?=
 =?iso-8859-1?Q?8HUkEVbEd3sQomq+c33goyvGig8SyZH0eu2pC4DcGPO8Vebf5c44FrTWKv?=
 =?iso-8859-1?Q?SGCV/Ep7pbBxsSJPCgmp4CC23fNUsQDj0nBz6ifkEwFw9i33dxMwWzlodm?=
 =?iso-8859-1?Q?K+u0LAbPHRuYNmRM0qHkST1Arn3kLr7BrZe4h2npP8eusxHC1xe8mRsgnM?=
 =?iso-8859-1?Q?BeT69ZDpajetKgeiqyfxcSA1G2kwt1b6238YL8Bq2WSg+pOWM5CJH2tUg9?=
 =?iso-8859-1?Q?SSjyIdubdumigPVvoVF6fhhuh4mbMFuEjeVeLO0iLEkZ96MAIomKk4kcwU?=
 =?iso-8859-1?Q?7whWsZccCBbR0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f02dc5e7-5c34-4571-040c-08dd300daab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 17:55:41.3238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 482198bb-ae7b-4b25-8b7a-6d7f32faa083
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDvCpfo+DwzYriKPSLsHj46gHze4bzCj7gRWV7/jsW04xz1xjdBMVqpTUDNZlsaAoWd7YQIV8WhyPFyOGTlKXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB8645

Hello,=0A=
I'm a PhD student working on orchestrator support for memory disaggregation=
.=0A=
=0A=
I have some questions about how Linux presents CXL memory and its performan=
ce=0A=
characteristics to user space.=0A=
=0A=
1. What is the simplest way for a user space program (with root privileges)=
 to learn the=0A=
latency and bandwidth between each pair of NUMA nodes (even non-CXL ones)? =
Are=0A=
reading the HMAT and shelling out to the cxl cli the only two options? I've=
 read=0A=
https://docs.kernel.org/admin-guide/mm/numaperf.html but AFAIU given a memo=
ry target=0A=
those sysfs files only report the performance from the local initiators. I =
care about each pair,=0A=
not just local ones.=0A=
=0A=
2. Is there a way to get the information question 1 asks for for memory tha=
t is physically=0A=
connected to the host, but logically isn't? The ACPI spec https://uefi.org/=
htmlspecs/ACPI_Spec_6_4_html/17_NUMA_Architecture_Platforms/NUMA_Architectu=
re_Platforms.html#system-resource-affinity-table-definition =0A=
states that "The SRAT describes the system locality that all processors and=
 memory=0A=
present in a system belong to at system boot. This includes memory that can=
 be hot-added (that=0A=
is memory that can be added to the system while it is running, without requ=
iring a reboot)."=0A=
I interpret that to mean that if (CXL) memory is physically, but not logica=
lly, connected to the host,=0A=
the SRAT will still describe the corresponding NUMA node. But what about th=
e HMAT? The ACPI spec=0A=
https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/17_NUMA_Architecture_Platform=
s/NUMA_Architecture_Platforms.html#heterogeneous-memory-attributes-informat=
ion=0A=
states that  "The static HMAT table provides the boot time description of t=
he memory latency and bandwidth=0A=
among all memory access Initiator and memory Target System Localities. For =
hot-added devices and=0A=
dynamic reconfiguration of the system localities, the _HMA object must be u=
sed for runtime update."=0A=
but it's unclear to me if that applies only to physically hot-plugged memor=
y or to logically hot-plugged=0A=
memory as well.=0A=
=0A=
3. Is there a recommended way for a user space program to tell CXL NUMA nod=
es from local NUMA nodes=0A=
(both online and offline ones)? One hack would be to check whether the NUMA=
 node has CPUs or not.=0A=
Another option would be shelling out to the cxl-cli. =0A=
=0A=
4. Is there a way for a user space program (with root privileges) to learn =
IDs of CXL NUMA=0A=
nodes (both online and offline ones) that are globally unique? What I want =
is:=0A=
a. if two hosts are both connected to the same CXL memory, they should see =
that memory=0A=
with the same ID.=0A=
b. two different CXL memory pools will never be seen with the same ID by di=
fferent hosts.=0A=
=0A=
All my questions talk about NUMA nodes. I understand that Linux has multipl=
e=0A=
layers of abstractions to represent memory, and NUMA nodes are one of the h=
ighest ones.=0A=
If any of the questions above can be answered but at a lower level of abstr=
action than NUMA=0A=
nodes, that's fine as long as there's a way to map the entity in the lower =
level of abstraction=0A=
to the corresponding NUMA node.=0A=
=0A=
Thanks,=0A=
Matteo Olivi.=
