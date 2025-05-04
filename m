Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23648DF5C
	for <linux-cxl@vger.kernel.org>; Sun,  4 May 2025 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746347583; cv=fail; b=MneFIGm24bNM3QHfyOLZ2rI1gPcBB/vZtrEExHUEFBmsc/YG6LeF3mX6qOjAeF2PWkDX8DHQ2LcIO8I+x6MFk/Ly10MFWZQ3NneXfR7cAgSDwkUTiVSfdbJD7/CAZWJ9euXXDmR0JJlbmCrlEImjmt82t1FfwOp58izto08hTrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746347583; c=relaxed/simple;
	bh=55zJ3kOp+rWQZyh58sXv7G/jBExdN6pwvFla+5HoFgY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YQWWTZLR/I6apjYnsSYjL+ms1NLfO1WuqWBV6s6BPJW1Wn+dKU4TSh5ZwVfEcCKl/UHNz/FN1C+k20k41EwiSB2iy5gmdUxhI6tHTgM+LncnT1m02H40cX3d6cMYjYJx0Lir8KpX6X0PCvFzGMTDh+wzmKVLpItYgYk8hC+2l0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=DMB6CGtH; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="DMB6CGtH"
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5443kduL011465
	for <linux-cxl@vger.kernel.org>; Sun, 4 May 2025 08:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps0720; bh=btlA94brhZ/IvrBUolbNdGDp
	QWaH2QlV1TgBE/aa3Gw=; b=DMB6CGtH5YynHARkFMlwevX069KWCyF+4H/w5DO0
	fXgxWWqSa1N8nhGuub1tzo4oIa7QszMPfzMpI7qmeOKU9b+4P06EM0vr/NKdNY2O
	UX1ilezcO7RS79ERdaDuR4Q+FknA91ycmGw/H+bWoZc+DaFDNVVNqNQcUWxyeOcp
	pWN56ll33doh8jA6ObdcMk4koapoAhoG+u+nRwM9wFq/vfFSXGHxngSWU64O44V+
	h6wyRQjFrDUWutGdOHotmJOcWidoedo2tBDNtYUNAun5Mgn7cLnGhrkdKlS5MqHh
	jRaGt176JGKlLyQRGOOrUEbnjGI2DO2NmF+JMnkXQWfxuw==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 46dchpnw5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Sun, 04 May 2025 08:22:08 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 7446713195
	for <linux-cxl@vger.kernel.org>; Sun,  4 May 2025 08:22:08 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 3 May 2025 20:22:08 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Sat, 3 May 2025 20:22:08 -1200
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 4 May 2025 08:22:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSfac93B/4PoBSOeaw0tgotT6HjcKW/zSCs/04bgjdO9hO226bBC1BsEMWFGY06jvqoRV+nWZy2Eia27hZs0MdU8iQmj7rSQDY/fDKvnTMKedVL5JghKlS18PKNmRHVxdA+g9FvUzgNz71jbN+QEoJaTAaqO1JxfOW2DEZSmLgm6TMnPKw4A/eC5g2ZINjSTjZ0tqIppdBRkqK0XYD5Q2flRems6tJjjPtB/Hwg4p8BfRqp0z1lksEr0pqON8+NtfPvVnEEnKHRmFstc1nC/TE8ptFFwNy+AiBPrvk3d74eo/Yq9LeGYz9P9sjL6CUkj7OVwJ1Gdobt7JsbJgrQGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btlA94brhZ/IvrBUolbNdGDpQWaH2QlV1TgBE/aa3Gw=;
 b=sP/sI0BMg3JC7AVUD739fTqBLE7oHzjmDmS6IngPLl23fuXA9DNeK1Ey4DwQMHT+3ffxb3e44fC1sOIKq2W2wBFLvp8KYQB6K9ZxBrDwtjuK7hMmqCHhcN/kambeIn27+gKKLaQxTUXBXJE8kszVOt4fLU8nokkv2WaOKqYi/YyNI45sH8bff/i98Rec32T9Jo0+ZtNcTdSdXnUQ62DhscvqxPzYFwayQY7O+mtpOXcQieMBkrkoaxrrhG8T/iprITDVQ+ZX3vNWSU3qUSxlIUzBiq/jCaW0ZQwCof2QGJvCBJYAbD2Hq34RD4L24d9Q+bf+UfsXrvVr66Dhfx6KjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:151::12)
 by MW4PR84MB1489.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Sun, 4 May
 2025 08:22:05 +0000
Received: from PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e9a9:8b7f:5165:3ab4]) by PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e9a9:8b7f:5165:3ab4%6]) with mapi id 15.20.8699.026; Sun, 4 May 2025
 08:22:04 +0000
From: "Parthasarathy, Mohan (Compute)" <mohan_parthasarathy@hpe.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Request for help on CXL kernel panic with recent QEMU/Linux
Thread-Topic: Request for help on CXL kernel panic with recent QEMU/Linux
Thread-Index: Adu8zZoMdzmvOoslScWDM9Votzra9w==
Date: Sun, 4 May 2025 08:22:04 +0000
Message-ID: <PH7PR84MB1582216A28E1632187113016888F2@PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR84MB1582:EE_|MW4PR84MB1489:EE_
x-ms-office365-filtering-correlation-id: 52d6b4ff-86c9-4483-1303-08dd8ae4c0d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?QhXwyd+pNHk/AZg/w1pZHejoCNsBJfwLwNycm6EwO19Ry6xFBDmK5HReMetR?=
 =?us-ascii?Q?Eufza4ITVoQDS17Moby4GaFuhPcFo7UMAskTBdHs2v0TEOdTJvMoXHGkuCgN?=
 =?us-ascii?Q?dCp4Y6JD9iMdzxWoomkbJ6MibIwq6zolz+ADX5Inso9p3JDIDDJ9dx3g/Boq?=
 =?us-ascii?Q?B3HpzgtPdcftYWvrjAI++Q09WfX/0yfB0wrKPPPaatblXxTciviTwmIg0yXH?=
 =?us-ascii?Q?HsO1LfpoRoImEfjQ6g1q/k1NhbcEZ0GmsHynYkEwnD3k6YUFbZMwWQOhcr/V?=
 =?us-ascii?Q?jGDjuFfyqkXYMqEOZ3/xFATGDP5skKYSjC7pOGGiOzjwmXTKVs7hwxqF6lD6?=
 =?us-ascii?Q?JHzMolyVZZ/fug2szhdu2+xHBvSxLV0IIb++EOcwFflwCwyt9n5teKw8kAM4?=
 =?us-ascii?Q?LGaF/RNiwBN8HLF2qLdQ3/QaO10YP0IwFtT4mMeABdwfeC4XEkeNNLHEhZah?=
 =?us-ascii?Q?PJhd1kPwWhKel/5UCk1NgmisuLTyE23YCi08M0JhyaIZndcCQmQa3wZqBg1q?=
 =?us-ascii?Q?u3lrGxznbTrgFKfoMUuRvOVt6HxvVuSmvLe65UNo7JhQbN5GhveyZS694NSa?=
 =?us-ascii?Q?i6bXlf6OTPQ48LRGKgHydflytIpVLObLHMdWEh+IYWtTH/ArcF6vinDt7z5N?=
 =?us-ascii?Q?l9+LQRNaSILKxQBhFGCfepcq1EkzbaYMstoMSvqlkcTVegn5y9eKfXudSDDL?=
 =?us-ascii?Q?M9mpAVIVZA44tUEcHvbasAG+5IPD8/CF65YDtUz5/76K/26IZdrUaHNEBS62?=
 =?us-ascii?Q?Kdp+hOD2fotJgij1bguTOmO1Em3PsSmTEblwPtiw6IV8fLwl+ymmIMDpla11?=
 =?us-ascii?Q?4j2zo7wOkdBIYNpE4nj4u33gvCOeekOwxjR6YT5m+JBhYtyByJO/ydQX7Phg?=
 =?us-ascii?Q?GvW59kHp2l60UyfODLYQL67kWErldEn/PvJheXPcJWjfvZh++CbJ6rJpveos?=
 =?us-ascii?Q?6hMBeTY6u+C9Gp3+2nb5YT1LWexwPxFyLZSSZ90wPhGJtLfFyE+8Rfy2+shw?=
 =?us-ascii?Q?Mj9WkNSOuPHcPac3X2OJQ9Xe/sE7utzV5XNhMkQsOoM5RK50HcI0EzZ7R3J2?=
 =?us-ascii?Q?6hMYdeChCP10QmeHdrln7/TNgv0a2IfQz6TGD6kLsYIAoLpYxUOMmh8PJRep?=
 =?us-ascii?Q?jYGIreOXZKR81EvBep7ngWb1l1kB0T5GqEqlgqVnsQzGecjhHiuGZu7fRjOl?=
 =?us-ascii?Q?EmXoZ45hybCidaFINTP9piBIuY7+zJ0betE1dhEs1sacuIV7N3TUuGJGv3JM?=
 =?us-ascii?Q?VfG93BdHC+L/4MHzCnvPPHONZetXDgjRPffFYSLkJWBJFxbQIq7iQ41IHo67?=
 =?us-ascii?Q?YFYV17pxAw0xZGQwUmbFNnsov+iEkpMU+a3FvERALQz+27sR/R7i5yuLyMaD?=
 =?us-ascii?Q?caATqbBGwwBzvwZGNvvk9Y0nh3vSpPbNQlqQ+tA+UqA/lnW1zX5TPUqrWETb?=
 =?us-ascii?Q?8cJCrapHzqKJmdOa7IhgG2e/lRE+z+3UFTWHMN20hIKE4moHKmEQRQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3oMM6gt+KAAb6H63Nc9JgP3ZMEaTGN1vuxo0Q4U2ZI2rVAIZcks43grUe0k+?=
 =?us-ascii?Q?i2BVJIYSYzMh2okwAcQxDe2kuc71w7Jo8CXfN+YxRM1i++NTtwOvTAExxcYo?=
 =?us-ascii?Q?e6XmRopHIa1U3V57yxvf+ivAm2ff2/+Y8Kthj2uJFoxE7Rh9wmCf9WtVL9Rf?=
 =?us-ascii?Q?ixrp1aapgj4+g7pLmhfTz+16ouxkxpnYP1EliIox95bZl1PI3qC7q43McVF2?=
 =?us-ascii?Q?gRMFvzBXfNl6PDIkBwDp93o6vpoLI0pgJrdVFKP8G4VeDiJu0g9iSZd9sFRm?=
 =?us-ascii?Q?TinGOGMZ6jla154+yfT93rOx9fFZ2QlHulaJN9rCju4df39aMqdl4yY12Fnl?=
 =?us-ascii?Q?eatuSSDUMIoOokZlvjmDj18C4ZjJPCjP6TaB/1Uw2DepGCIfwqEHSU4NmXV/?=
 =?us-ascii?Q?zy3KH/6TAa4aC6aW70pa5paIf7yOgNixophFJAh6Ihzl6DB8EVi6iTPlTwN+?=
 =?us-ascii?Q?JFfRhHSWGM6h2GNx2QWUpV8wErlht/l4+gRwZqLqgzAnSL5bSLwAFLUoZtxc?=
 =?us-ascii?Q?T0bYwJ5m5cRf2JMemQWaHzBxF3mc1HT9ZpgOB+eN0eAMruUgLwbJYgxPfjbD?=
 =?us-ascii?Q?lprJ4DXmGXsRePoaAnXh6D6G10rA/o7/PBbzJVA9pt6zVjrvk9g5Ke6z8ht6?=
 =?us-ascii?Q?HOeQj8lDWsIkt6pYmUv1rd/U/Iy3dbuGknlYxzNcHgqD2Lxwq/KmEdOXVMLb?=
 =?us-ascii?Q?uzk70OGV8XZh3R9n3mzG+6woAAA0nvJNHCSYotyhpQFS0oZBDJwYc1NNWbDk?=
 =?us-ascii?Q?YCr2BRWSNYB4wTtbd/XFs51MI/7vD830WeEQU85t5PDE5CDN/IUzN0OaPF8W?=
 =?us-ascii?Q?OHebYuIRpR9iNzCNlyeyPEa6JLkX6nVFh2BW5R3+wjytBZRQWscXX+/4GoSk?=
 =?us-ascii?Q?s/Thbh4mTm2hfqFng0KNE4BXo9XnDwefxEigjj1yqxCHxY32g5hIamU06k4p?=
 =?us-ascii?Q?w3zE4vk3IcNp1Yn4Y1slXVf4WNc5XEa6P//GEjLG3HnIQAld75ViRDn8D568?=
 =?us-ascii?Q?6gelARpvtGU6+0RPuWw2pIdo85sWd1yn/smcW25XuH6cdv9tRps6HaH5TcwT?=
 =?us-ascii?Q?Kda+HJAxx/gL4kBo/rdNNIolO7DqvbDUdkcCz+D7H0/5NqYq2Iwb09gWYwpU?=
 =?us-ascii?Q?H2MRbtRZl9Z1IC5yVITuDuS6Gs2m2JeFT4b/hto1d2pBcgCkJ6mlma20kER1?=
 =?us-ascii?Q?rkA1o48MGZibYmvnv9D0MQ+iFKDjZb7EfNtcoC0y0/XQenpylOAEPMnF6ee2?=
 =?us-ascii?Q?1nAxUSm2uVu2nf2ObgnVDv3041vzsWmlbjOL06jetmLErgGt7MZ+6+IG3Ejc?=
 =?us-ascii?Q?bcKAHKNaX05mKkWhzeFghBOGxmMXSDbCFtjNUuf4VkcNQ6kNqZ8/Ek2kjgnF?=
 =?us-ascii?Q?ede4Khd8mQ4nMV6fduvKlApQvIkrwrPU1SVE9ZL3xwxbtNQhTFiCow2r/4kC?=
 =?us-ascii?Q?2CYHxVZSh9zrElxhzG/Xe2sIEuJBRlIUnJVPZUnhtFozjzh4FvPaq3Wjy/sK?=
 =?us-ascii?Q?8YFUbM3yonjCcepGGMDEWLusP6ruU8tHEOww/aWZeE1fJoKBMeb9D8yAwkTl?=
 =?us-ascii?Q?+Y4VRN2TGwcYPYARnzTSSwf/dsLIifHSG0JnJjVGr/Lm2JQzDvtPPGEqbMaN?=
 =?us-ascii?Q?gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d6b4ff-86c9-4483-1303-08dd8ae4c0d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2025 08:22:04.8511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Tvz7aYsBgktOFncu/bhv5mCTGk+z/DG5J7AEz4WThBIr0FRysPD59Zn4N0pG0yyegXrUKQ1ou9haSt4CYwc5CDtsjZlMUn3PCkG/qPPVJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1489
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 9jTD7a-sm3AtGkPFpgYc7e2JHRYF7Jq5
X-Authority-Analysis: v=2.4 cv=ONcn3TaB c=1 sm=1 tr=0 ts=681723b1 cx=c_pps a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=ID6ng7r3AAAA:8 a=ZlRc65zt4kRdOj-ytB4A:9 a=CjuIK1q_8ugA:10 a=AkheI1RvQwOzcTXhi5f4:22
X-Proofpoint-ORIG-GUID: 9jTD7a-sm3AtGkPFpgYc7e2JHRYF7Jq5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDA3NSBTYWx0ZWRfX6dS7WT+Dlg7M w/1DZqhI00KETk+OAFmA7P/iyN8tS3OlPJ8kht6h8IdguNhgeH+pRFdeDIuYlbpsuRJhjcxYZzm GUUE+Rnjh/F0s01BAv3vfQ32BM21po9LyhLogLkDV3zSYqifxov3PX27oKS0Fv0NwhzbZvYzZE0
 ul5TI8s2eV3FFPZ5qJXtzE1zNw+bzcuIDpr0Rv6FvpYHdy24KVbj6qphyQATI5EaAbgEPFrJndc Fce11iod41EXPDexPD5ntt9zq1YtqXYE9jmSkkYAaL+YDr9/TSEw9f9AoZSN2w/S1C+o5WxUmz7 VSrTvmewNLMmjbnIqrIiDLnDzsCme/8CnjKOjloqjwtS/+yA8Fkwh3h+NZQauFLZK2YFXQkxylJ Obqyrmu+
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1015 mlxlogscore=967 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505040075

Hi all,

Can anyone take a look and see if this a known issue ? Also, any tips on wh=
ether the issue is likely with my Linux version or QEMU ? I can share more =
details if required but just wanted to know if this looks obvious to expert=
 eyes.

Regards,
Mohan



[   57.988032] ------------[ cut here ]------------
[   57.990637] memcpy: detected buffer overflow: 96 byte write of buffer si=
ze 0
[   57.994123] WARNING: CPU: 0 PID: 46 at lib/string_helpers.c:1032 __forti=
fy_report+0x55/0xa0
[   58.001055] Modules linked in: cxl_pci i2c_i801(+) irqbypass vfat pcspkr=
 fat i2c_smbus mctp_i2c(+) parport_pc(+) cxl_acpi i2c_mux parport cxl_port =
cxl_core e1000e einj lpc_ich bochs loop nfnetlink vsock_loopback vmw_vsock_=
virtio_transport_common vmw_vsock_vmci_transport vsock zram vmw_vmci qemu_f=
w_cfg serio_raw scsi_dh_rdac scsi_dh_emc scsi_dh_alua i2c_dev fuse
[   58.016135] CPU: 0 UID: 0 PID: 46 Comm: kworker/u16:2 Not tainted 6.15.0=
-rc4-mohan+ #4 PREEMPT(voluntary)
[   58.021711] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   58.025755] Workqueue: async async_run_entry_fn
[   58.029028] RIP: 0010:__fortify_report+0x55/0xa0
[   58.032915] Code: 01 48 8b 34 c5 20 1f 73 b9 48 c7 c1 06 58 f2 b9 48 c7 =
c0 fc 57 f2 b9 48 0f 44 c8 4c 89 ca 48 c7 c7 d8 ef e3 b9 e8 bb 2e 80 ff <0f=
> 0b 48 83 c4 20 c3 cc cc cc cc 48 89 74 24 10 48 89 c6 89 7c 24
[   58.039451] RSP: 0018:ffffd248801a3a38 EFLAGS: 00010246
[   58.047157] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 00000000000=
00027
[   58.053599] RDX: ffff88abbbc1ca88 RSI: 0000000000000001 RDI: ffff88abbbc=
1ca80
[   58.059967] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffd248801=
a38d8
[   58.064773] R10: ffffffffba939ac8 R11: 00000000ffffdfff R12: 00000000000=
00000
[   58.075635] R13: 0000000000000000 R14: ffff88ab4007c800 R15: 00000000000=
00002
[   58.084667] FS:  0000000000000000(0000) GS:ffff88ac0052b000(0000) knlGS:=
0000000000000000
[   58.096028] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.106050] CR2: 00007fbd45b4b058 CR3: 0000000115109000 CR4: 00000000000=
006f0
[   58.117482] Call Trace:
[   58.121907]  <TASK>
[   58.129551]  ? cxl_internal_send_cmd+0x3c/0xf0 [cxl_core]
[   58.139570]  __fortify_panic+0xd/0xf
[   58.146273]  devm_cxl_setup_features.cold+0x43/0x43 [cxl_core]
[   58.153161]  cxl_pci_probe+0x431/0xa90 [cxl_pci]
[   58.158287]  ? kernfs_xattr_get+0x3b/0x70
[   58.161167]  ? selinux_kernfs_init_security+0x74/0x250
[   58.167922]  ? try_to_wake_up+0x7f/0x760
[   58.170137]  local_pci_probe+0x42/0x90
[   58.172399]  pci_device_probe+0xda/0x2b0
[   58.177444]  ? sysfs_do_create_link_sd+0x6d/0xd0
[   58.182205]  really_probe+0xde/0x340
[   58.190234]  ? pm_runtime_barrier+0x55/0x90
[   58.192903]  __driver_probe_device+0x78/0x140
[   58.197956]  driver_probe_device+0x1f/0xa0
[   58.203673]  __driver_attach_async_helper+0x5e/0xe0
[   58.208474]  async_run_entry_fn+0x34/0x130
[   58.217941]  process_one_work+0x18e/0x350
[   58.221932]  worker_thread+0x25a/0x3a0
[   58.223804]  ? __pfx_worker_thread+0x10/0x10
[   58.229040]  kthread+0xfc/0x240
[   58.237142]  ? __pfx_kthread+0x10/0x10
[   58.246321]  ret_from_fork+0x34/0x50
[   58.253927]  ? __pfx_kthread+0x10/0x10
[   58.261905]  ret_from_fork_asm+0x1a/0x30
[   58.267821]  </TASK>
[   58.269775] ---[ end trace 0000000000000000 ]---
[   58.274065] ------------[ cut here ]------------
[   58.282586] kernel BUG at lib/string_helpers.c:1040!
[   58.293976] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[   58.299430] audit: type=3D1130 audit(1746252020.305:32): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 msg=
=3D'unit=3Dsystemd-random-seed comm=3D"systemd" exe=3D"/usr/lib/systemd/sys=
temd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[   58.299474] CPU: 0 UID: 0 PID: 46 Comm: kworker/u16:2 Tainted: G        =
W           6.15.0-rc4-mohan+ #4 PREEMPT(voluntary)
[   58.313086] Tainted: [W]=3DWARN
[   58.317049] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   58.322714] Workqueue: async async_run_entry_fn
[   58.329051] RIP: 0010:__fortify_panic+0xd/0xf
[   58.332500] Code: e9 dc d9 95 00 e9 02 da 95 00 0f 1f 00 90 90 90 90 90 =
90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 40 0f b6 ff e8 d3 f2 95 00 <0f=
> 0b 48 8b 54 24 10 48 8b 74 24 08 4c 89 e1 48 c7 c7 90 2e ef b9
[   58.339956] RSP: 0018:ffffd248801a3a60 EFLAGS: 00010282
[   58.348114] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 00000000000=
00027
[   58.356607] RDX: ffff88abbbc1ca88 RSI: 0000000000000001 RDI: ffff88abbbc=
1ca80
[   58.360981] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffd248801=
a38d8
[   58.366267] R10: ffffffffba939ac8 R11: 00000000ffffdfff R12: 00000000000=
00000
[   58.369804] R13: 0000000000000000 R14: ffff88ab4007c800 R15: 00000000000=
00002
[   58.376177] FS:  0000000000000000(0000) GS:ffff88ac0052b000(0000) knlGS:=
0000000000000000
[   58.380150] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.384364] CR2: 00007fbd45b4b058 CR3: 0000000115109000 CR4: 00000000000=
006f0
[   58.387660] Call Trace:
[   58.390086]  <TASK>
[   58.392804]  devm_cxl_setup_features.cold+0x43/0x43 [cxl_core]
[   58.395791]  cxl_pci_probe+0x431/0xa90 [cxl_pci]
[   58.409127]  ? kernfs_xattr_get+0x3b/0x70
[   58.415392]  ? selinux_kernfs_init_security+0x74/0x250
[   58.420775]  ? try_to_wake_up+0x7f/0x760
[   58.423879]  local_pci_probe+0x42/0x90
[   58.429026]  pci_device_probe+0xda/0x2b0
[   58.433175]  ? sysfs_do_create_link_sd+0x6d/0xd0
[   58.438630]  really_probe+0xde/0x340
[   58.440769]  ? pm_runtime_barrier+0x55/0x90
[   58.442846]  __driver_probe_device+0x78/0x140
[   58.445598]  driver_probe_device+0x1f/0xa0
[   58.448532]  __driver_attach_async_helper+0x5e/0xe0
[   58.451848]  async_run_entry_fn+0x34/0x130
[   58.456739]  process_one_work+0x18e/0x350
[   58.462118]  worker_thread+0x25a/0x3a0
[   58.467050]  ? __pfx_worker_thread+0x10/0x10
[   58.470596]  kthread+0xfc/0x240
[   58.474475]  ? __pfx_kthread+0x10/0x10
[   58.477836]  ret_from_fork+0x34/0x50
[   58.480791]  ? __pfx_kthread+0x10/0x10
[   58.484168]  ret_from_fork_asm+0x1a/0x30
[   58.487363]  </TASK>
[   58.490697] Modules linked in: cxl_pci i2c_i801 irqbypass vfat pcspkr fa=
t i2c_smbus mctp_i2c parport_pc(+) cxl_acpi i2c_mux parport cxl_port cxl_co=
re e1000e einj lpc_ich bochs loop nfnetlink vsock_loopback vmw_vsock_virtio=
_transport_common vmw_vsock_vmci_transport vsock zram vmw_vmci qemu_fw_cfg =
serio_raw scsi_dh_rdac scsi_dh_emc scsi_dh_alua i2c_dev fuse
[   58.505259] ---[ end trace 0000000000000000 ]---
[   58.509396] RIP: 0010:__fortify_panic+0xd/0xf
[   58.512731] Code: e9 dc d9 95 00 e9 02 da 95 00 0f 1f 00 90 90 90 90 90 =
90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 40 0f b6 ff e8 d3 f2 95 00 <0f=
> 0b 48 8b 54 24 10 48 8b 74 24 08 4c 89 e1 48 c7 c7 90 2e ef b9
[   58.520925] RSP: 0018:ffffd248801a3a60 EFLAGS: 00010282
[   58.524495] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 00000000000=
00027
[   58.528365] RDX: ffff88abbbc1ca88 RSI: 0000000000000001 RDI: ffff88abbbc=
1ca80
[   58.532956] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffd248801=
a38d8
[   58.536365] R10: ffffffffba939ac8 R11: 00000000ffffdfff R12: 00000000000=
00000
[   58.540179] R13: 0000000000000000 R14: ffff88ab4007c800 R15: 00000000000=
00002
[   58.546765] FS:  0000000000000000(0000) GS:ffff88ac0052b000(0000) knlGS:=
0000000000000000
[   58.550843] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.554470] CR2: 00007fbd45b4b058 CR3: 0000000115109000 CR4: 00000000000=
006f0
[   59.773090] iTCO_vendor_support: vendor-support=3D0
