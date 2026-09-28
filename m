Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6B837F00B;
	Mon, 28 Sep 2026 05:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573875; cv=fail; b=CtkYmcZDD5HaZPi8XqT6d0FBkBiguqh2Ir+jqMWTT537IUEK1w9r3dTg8K4v1cJ7XgAdj6kvtk/zgmFc9Faf4KPIqEUznSAYYOxGsdREDAGcO9v9j1CYCjVHxk7oVQL7G3h5xIAeYPtAG77DEvlM8xODPutN5F15V1N9gtTDCYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573875; c=relaxed/simple;
	bh=ArAMANK/QvbzTo3pJ8FQRRFGkXZPh4fVjR//5GjrmPM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fLO6tSJNpYq1LIJHgyNAJjuosUDru81l19hevYEgQjMuLDjT5XU1HddMHKrtDzj0m8xR8YSRmvJ3vYF7zpP2/Dc2gKCcCA5c29CWqYR7JKbZu7NeAX0gGXrWcr/CMjUQSa96V2eiNU8QMhA+nxoiyktQh1tLMy3iaqctd9LMRzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q7m4TtTp; arc=fail smtp.client-ip=40.107.208.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q7m4TtTp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BM+PLOYtwM36Fk0ccHOoztTqhGuzjZbCgz9XUcTTVOzQoxdvEiN9nwAaAwUs1UFrtnBPx1217jXeN0Nd9jGnluoXzciaEp8uLjqWU9YViDsWE+2DeMftVectbU+DPOg2kP/JcquNtxv12xxnZK7pW0vVGiNxYdng7Zqt/fYnfja08+YEye+sxyyPqnDXU5n3WKgNKF6HakFNqoFC8qryJuKU0yyByooMsX8UJWcIpCF+FugwkYxuJ/4cJ00vNs8uikO0z5JghhzaZ0u2dQ1Bj0CvvjJdTeFXMzdqepcLfld2VEEAmeYeNXOyjj3S+8aruAExnLHqGQOcwCHtQpcNTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArAMANK/QvbzTo3pJ8FQRRFGkXZPh4fVjR//5GjrmPM=;
 b=PPXS2KrnFNfTeoQl8cTwA81Idljv8ZH/erG3TbpoWwRc8mq+WRPFJmjn9WzJqtrDObJl3egBuyiofvg/cnnjbUWVNNdh72kbGsANAU3Gql0HLm/lLRLp8dBV77eeQZKjUaiwvgquPKhhHtvbQ461EjBInwbRceIUGNAlJ34ZQyhr/xYQojoD4Rf0CCXxl+UrnQ7aiQdBBcp6ajMW0p3xFZg5sgVUG26tPbXRZXQTDyCWzHGs9pXeNWQRnGLwdKkhvfJbXNB2wY8OygxyLQwg5GZXW3/pPstAcTsCyiUPaV45+NEa4oLoVqhvjeTrKs1MKVc2+6VJLpZwOctlb0X63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArAMANK/QvbzTo3pJ8FQRRFGkXZPh4fVjR//5GjrmPM=;
 b=Q7m4TtTpnbBCKTUdKECs+M+BHwFYyvvYRpVD+jPO1Tw1LFtUB4fW+dj9zth2IYu6gtRmwyk2+a6ZKavMj/PS2JZVX4qFirqsJmYbIOgAGjE8oWfjfowu28fKzKePSRxFr+wYdMyyFcW8Bfd6WED/BlBY04tfOBzTze85JarWd/gJfgqZ0w4TW20DbVmkQ7LzxKlZmVHxWshGbAubEkUEL07nvotgmX1cakSag2DakGnn3HUaYcpNgPIkVfbUlxVdnvwv4ep0tl11bf+wtNj+PiTVXsGJfETtNSkfiYeQZ9i1kwxW1Di2x4OMWeOeQh1i/OzKOEdkesaGERc3YdHNOQ==
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 (2603:10b6:806:55f::17) by DS0PR12MB8248.namprd12.prod.outlook.com
 (2603:10b6:8:f3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 05:37:45 +0000
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9]) by SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 05:37:45 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jonathan Cameron <jic23@kernel.org>, Richard Cheng <icheng@nvidia.com>
CC: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "djbw@kernel.org" <djbw@kernel.org>,
	"iweiny@kernel.org" <iweiny@kernel.org>, "ming.li@zohomail.com"
	<ming.li@zohomail.com>, "gourry@gourry.net" <gourry@gourry.net>,
	"rrichter@amd.com" <rrichter@amd.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Newton Liu <newtonl@nvidia.com>, Kristin
 Chuang <kristinc@nvidia.com>, Kai-Heng Feng <kaihengf@nvidia.com>, Koba Ko
	<kobak@nvidia.com>
Subject: Re: [RFC PATCH 0/3] cxl: Auto-create a region for Type-2 memdev
 attach
Thread-Topic: [RFC PATCH 0/3] cxl: Auto-create a region for Type-2 memdev
 attach
Thread-Index: AQHdSjHM5RR06V+od06k+E11YeFTFLbjbYnJ
Date: Mon, 28 Sep 2026 05:37:45 +0000
Message-ID:
 <SAWPR12MB9992678E92777730BE483F6511B08D2@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <20260805074042.30173-1-icheng@nvidia.com>
	<a3978557-59d5-49bc-bdb3-9ef2dfa025d3@amd.com>	<aobIoBYBACGlJ-OD@MWDK4CY14F>
	<53689d31-3707-4c15-9eb9-eb6c77ab3ca0@amd.com>	<apU6tyyxSIGvzSs6@MWDK4CY14F>
 <20260922022518.1002b083@jic23-hlaptop>
In-Reply-To: <20260922022518.1002b083@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR12MB999267:EE_|DS0PR12MB8248:EE_
x-ms-office365-filtering-correlation-id: 5a68ccdf-d902-4153-4af3-08df1d229fe6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|3023799007|11063799006|4143699003|18002099003|22082099003|5023799004|38070700021;
x-microsoft-antispam-message-info:
 1Bj+JFqXRHgEDGl+vaDWXyrzXHr3CDy4/CDRTZsTqfo+IpPZzU9ktVxOgkuCSf5gDAVJQF7ZkaQ/7VzdVJFboYpudbuPy7cDrWPRxewPVpIBERob/q8AaGncs53z6IAU5A6dBrFhQmXAJNGTfQPgBFZ071MXCzIVFhljqWPma36JuHHpNDYWjejMvcuAWbZoapjXpclpiuLmtoGBXVMvECX4ZPDJwBThCtQo4VLeDxV9ZdNWa+nEEjXQvygGFndoyJKnpYbSswtfbV/O/TxpS4DWhgWCXyLFwi8SNZ48NMvfktL4a4HlbjWwwt095IyEwH7eSu7m9DsfPZNPuhlBerahzox/AaMC2f8hxtW+69s2DIeJnlJdUPRsko/Ab7vyT+I8bwEXaUyLviY0ubdYwZZMxGlXQEynbdYHmcv9OmNPowoDd1cngGgt6gEBRvyzfEoYjE/mw2MUYLfF0LcV38Bgq1V5CY6RnHSAWoaRgJV9qQCcuJGnDVHHl5yictBqs21PwWbJHitgWtdPs0xJUCLv0hjShPXQLVZX++NKrug1nxG3OT4XBTRbwrLkH9hQmRp9v4Sy2hwHfnlKtjc3+ZFu8zksgXyqHdNSoT9PdmOwU6wX35Q0VZPetXIZ3CShDslw9rTB3nBUBQr/bWI7wftjXLxnMGxaLdbyTLcwoacCxPgSFgiwGCVhOh+OHyqbwt2pBAzjHez/C3xDClxIFRbqbu6d6jNf4KV+Bgq/5dQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAWPR12MB999267.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(3023799007)(11063799006)(4143699003)(18002099003)(22082099003)(5023799004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?lVUujSQPSYaTsF19T/MxjdH0NFKBPCKu974gyGAazaVdmRitWAQVt6BFVk?=
 =?iso-8859-1?Q?DXKcbbWQtV3n7yFYJVg0xb+MQcsT4VnmJNGpce4vW8YqRseadDKDmIkmht?=
 =?iso-8859-1?Q?Im9LGvV+tsEOk07oSzyUvqeH9L5u8y8w8Thi+hYaCQm6MvgbUER+MzgVlz?=
 =?iso-8859-1?Q?AisvNbG/m9PBqxYabumLi6UExDd2ccDVs0aS7pcGDsILWOiRMWJt2+NpNi?=
 =?iso-8859-1?Q?/PcHRXpG2PKCJavmPCQAkMrkNT+MJgQgQYfUWsILZAcP1gt7KB5DKRUfAc?=
 =?iso-8859-1?Q?WAwLG4UGt7YnDn+/SGfz02ba4XH8u7JdYn7GNqh9vYWZHTwgNAtn683KUe?=
 =?iso-8859-1?Q?xYXPbc1hmp4HcrBhA17+R0uTLs/XARQ1IYHpaiRtL34yUNHvTx5iKoUxdo?=
 =?iso-8859-1?Q?1qswPE9XEjGK3NZvOCVI0rU34dwGhITsEp/38RvTr0vxGj7FGkVKNh7+QY?=
 =?iso-8859-1?Q?YhYhZuIHN+ARbkJkhNjkgHxMo+wLntHi5buE0q+it3NvpCryLhSRT3wXgu?=
 =?iso-8859-1?Q?z/RQf/uQqhoqsDZ9+2Ar03V8tPKBoS9cxju+Z7o88q4vhXSv4nyCnjyo8o?=
 =?iso-8859-1?Q?APOLV7AmYmRvnsZOLddRhUc/5jz4qjcHyytFCjtknelXWZhmw2EqjNCqpy?=
 =?iso-8859-1?Q?4J02Ds31gV4fxaXYxaqNsRL2gvgwvDzAsfekFaufBTghAfH04WYUl8q4pJ?=
 =?iso-8859-1?Q?A0unUnoRaEmfcKeLkz/56tRATEcTDbQi8g2nSsXTHZeId6YmXHMtSDxPx+?=
 =?iso-8859-1?Q?gWtK/NZyWgyCNgDFg22SMIdRaP27jMhJc8He0lKMlR/ZMKJ8gftEooSkVw?=
 =?iso-8859-1?Q?g7vtOdOqQvc2gGvt22T0ZyYGVLJDbA27LYs0Uqr8k7rxDq5Vj4qKy95B2m?=
 =?iso-8859-1?Q?Qll6/hbPqSp3InM77YJRGP9EfVbdQiGh/I1++nfo3MlzT3nApCdCMFcjZc?=
 =?iso-8859-1?Q?HGu/D3UN8QGAGxe03MSPht0KHX0Kj72VNKdJ2MstnIjtPnH0zHz/7zChXr?=
 =?iso-8859-1?Q?UfXiXUSS3b9Cz2gQrdpSjGCMTtd51CNg/PQYB9re5jGLPk0IJivdMXE1N9?=
 =?iso-8859-1?Q?YzLx3B6YlVu1xOLFLUuC7ltzxVEagqv52VIC4xZtSOgXwDz4q1SIFYkm9L?=
 =?iso-8859-1?Q?twRD//f6XteYvdBhLc+LaTzlWBzGz9jxIvOnzngqBhZgAXHTZEhyMwa+9k?=
 =?iso-8859-1?Q?VVBAt36An3OHmwla+NMYOvBUBGv+hDHZ6Eq+AdScXWWsIaUXRrJVEuLG82?=
 =?iso-8859-1?Q?WzKkXkgl60VnIOttU57erSd+Miz+LCP/kP18W940+2KEX8ztlAxvzPSGDg?=
 =?iso-8859-1?Q?VAzfHqUUFNSKOapmILErKHKG5FQ6GD21m3/Ufr3TBJcp1GeblHB8mtfSmM?=
 =?iso-8859-1?Q?SCqUXU9cisiYAZ2bEbtMe4GPGLDribIauoOYJQRSpjxDh9LU4k/KX/BIu6?=
 =?iso-8859-1?Q?uBkw1OW3xOsAIu0hs3E3aUBXK+C4XHw6zdjwaV+TKvdPAiy8Lk2t0ZU8XF?=
 =?iso-8859-1?Q?OlKWjAEKJK0RptMV6ekj7BtKN/QxzFDEZC1LKyinHeV41hq9FtzIXflCml?=
 =?iso-8859-1?Q?wsPGP7Oo4aXyWY74F00e36tK/LqA1mcNfOGtx3AtAuKtQuaIPoMEg/jySd?=
 =?iso-8859-1?Q?BkaTVyeMpbhvdZe/ztrk4sdnK7Yyqbu+fmBRc+RKAqLfjLx82p1Hys/kde?=
 =?iso-8859-1?Q?J99+4Zf82ZliTf+a2UfKvei3+M0eLEEiZWmI9hyt8jVEBGX2EazxQ3f2bP?=
 =?iso-8859-1?Q?6pLj6NQMQh6XjnUrVV/MhMmspQRFCkbcAoXVFVeo9JMe6a?=
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
X-MS-Exchange-CrossTenant-AuthSource: SAWPR12MB999267.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a68ccdf-d902-4153-4af3-08df1d229fe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 05:37:45.8479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nKpz2yPLL1NPYeTK1oC2MMCYV5a9j0WtHqVE6G7dKy0TM7LFRVLmUWWeuQPZkBc+K2HWAMu7SChlfSktquhwKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248

>> > =0A=
>> > =0A=
>> > <snip>=0A=
>> > > I think you are right that this RFC doesn't currently have a product=
ion platform=0A=
>> > > where the system FW publishes a Type-2 CFMWS but leaves the EP decod=
er=0A=
>> > > uncommitted.=0A=
>> > > =0A=
>> > > However, the config appears to be permitted by the CXL model. A CFMW=
S describes=0A=
>> > > a FW-established root HPA window and the restrictions governing its =
use,=0A=
>> > > including Type-2 v.s. Type-3 and volatile v.s. PMEM. The CFMWS def a=
lso=0A=
>> > > describes OSPM assigning HPA ranges from those windows to discovered=
 CXL.mem=0A=
>> > > devices [1].=A0 =0A=
>> > =0A=
>> > =0A=
>> > Right. I'm not saying this should not be supported, just pointing out =
the=0A=
>> > use case does not make sense with current BIOS functionality. I think =
BIOS=0A=
>> > will/could support a config option for just leaving a Type2 HDM uncomm=
itted,=0A=
>> > but then why the kernel should do the same a default BIOS config would=
 do?=0A=
>> >=A0 =0A=
>> =0A=
>> Agreed. The kernel shouldn't recreate the config that BIOS would normall=
y provide.=0A=
>=0A=
> I'm a bit lost. Both BIOS doing nothing beyond cfmws as a design decision=
 and=0A=
> hotplug (where bios isn't in the loop) require this sort of flow.=0A=
>=0A=
> Sure both might not be what you happen to have today but they are both=0A=
> very much real usecases!=0A=
>=0A=
> Jonathan=0A=
=0A=
So, can we consider doing both in 2 phases..=0A=
1. Autocreate a default region that is sized to the device's DVSEC reported=
=0A=
DPA capacity when the platform signals it (applicable only to CFMWS present=
=0A=
Type-2 CXL.mem-capable, decoder uncommitted case?). I suppose this could=0A=
cover the use cases suggested by Jonathan?=0A=
2. Let the driver explicitly replace/override it with a different sized reg=
ion=0A=
once bound per its own policy.=0A=
=0A=
>> And that's why I think we should move region createion out of devm_cxl_p=
robe_mem().=0A=
>> That helper should discover and attach to an already committed region.=
=0A=
>> =0A=
>> If FW leaves the decoders unconfigured intentionally , a driver may expl=
icitly request a region=0A=
>> and provide the size it needs.=0A=
>> =0A=
>> In my mind the new model should be=0A=
>> - FW-committed config is only discovered and attached=0A=
>> - an uncommitted config remains untouched unless a driver explicitly req=
uests it=0A=
>> - CXL core supplieds the allocation, validation, programming, accounting=
 and teardown mechnism=0A=
>> - the requesting driver owns the policy and the use of the region=0A=
=0A=
Is there going to be a custom non-default size to commit be communicated=0A=
to the vendor driver? AIU currently the size is only driver-internal consta=
nt.=0A=
=0A=
Thanks=0A=
Ankit Agrawal=0A=
