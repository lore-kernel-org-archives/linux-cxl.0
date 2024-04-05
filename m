Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C9D1552F9
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313555; cv=fail; b=GZDMwQgsBZ2ZbLJJIGco942SCiJvl95O7aCZ2k1u4qm0/7pLflr3wJTWmUfePP8ujn6ZC9v88Ve5zSNcaoxIYLZRU958c5EsyS50nkwCyxqB0c0JhIE4nUT1GIkDwUJW+Urb7zdTsEULP0vl5bOLgUdlolNAeVgfbsHgUXq7ihk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313555; c=relaxed/simple;
	bh=1dJJS2NuO8P3E6pjYpW45b974sD1tCUjpJEG/4gu/5U=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GJzhR+0eIByXMQielsVBzBNQc2ZG5I1yQPXBfTXTmkRn2bPbgk41BApsQPyhI04k1k9aW7j0wLSMoQnAubASF5rICO8ERjFk9mbkdtHAA8DdxZH/dXOezpsxgjZOEsMjw3XU0+R3YTpeFWHK167wQ6Bv7hsF4pfYSOnafFhTT70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=PesDlD0B; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="PesDlD0B"
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4356Q5Hg017519
	for <linux-cxl@vger.kernel.org>; Fri, 5 Apr 2024 10:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pps0720; bh=XiOLCKNJ7zZ2LL7ZOWjcCLyxlW07KIagJ6dOGlx01P4=;
 b=PesDlD0BXLaRChjJLknykFJL3xMvUfzeaeAcq6uNrP1DeHF6O/+GhGY6bwpYH8B4KnsL
 LVWv7oXp6wjU1MjPyZNg8yibW8vG8mgA1bMe+NgOEsbYMGngrXmR9klK1gzwjBf73Ldv
 +gLtnM9uv66Cj9R+fx6SJ9VX5pVuEgfbgBn/1E83cYK67GxReEoCpbkEiGYvAvCVdNcG
 cejDJ92BfXFMpORUjnyC4Bc2lm9Vo+FlxwRIQgrK8OQUbXs/RNHuviHi1uzMHmroaXHw
 nxcKtkTMMbZ7qsHTCgo1FZTCKBrm1dgsGtGnAlXX/8FNEastOgTNC8ZjV6kEmjrYIalw UA== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3x9xw37kk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Fri, 05 Apr 2024 10:39:10 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 73E5E2BADA
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 10:39:09 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 4 Apr 2024 22:36:40 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Thu, 4 Apr 2024 22:36:40 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 4 Apr 2024 22:36:39 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFtmlJzIb6XZwtdUCghcAHnoVwjBHVbUfYAadURyjleOKqzO9KQMzrO6pDd4tCIpLlY4mEuWtsoKNnO8eXu1KD7WZo3jvWjIoc7e563TwMEg4Qz1VHppvwAFPcEtGkXFHBKcNTx79bLzNeISqakhFVK/8UNeGEcLmYUoRodfZDMGmz+6iexrODmUBRr8lyQ84bPr3CbaUrtr4tdDzZu7UuMjCATWc+SanKQOJnyELazfZj7ZE8Goq7nufNPsNFFKMLkZFQ7cjswQDd0F/mBWuZ+iGxPl9t+Q+I24slPrmwuM9BepA2pW/j86MSSyp7XDduZsE8dyJgESIa4DqWJS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiOLCKNJ7zZ2LL7ZOWjcCLyxlW07KIagJ6dOGlx01P4=;
 b=Hu/qrztlVrHmBeKCtBaCsU/ywntlYiEHVfkvH0cG/FNyGEinvfPSkZ/lBDXlzpkctk79RSUu7T4tB1sMXRY/el6KKb0a6uvNIhCVvPnVBuXVpBfDSkpL4i7gja0jJlaSezEnJOnQjRuiBN4Y8kAedegVPdTzBm0mIQTYmffcNy3K8VcRaUFJwoMX/PWms233oHf4WvS+PkEGw/QYA2LASzdz4rFfxWAi1HO3MG82qrakILIzEA3vx1seOt6qJkNrQ6+mX/jc4VLHsOWd46a9B3JHrlVKvYO+yUsuLxdW2ejiWA7aJ3Y/SKIO61FcewG/mPqVcPAtqHlVKh58+IFTSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:151::12)
 by MW5PR84MB1570.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Fri, 5 Apr
 2024 10:36:38 +0000
Received: from PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2656:cd5c:cf0c:fd4e]) by PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2656:cd5c:cf0c:fd4e%4]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 10:36:37 +0000
From: "Parthasarathy, Mohan (In-Memory Compute Platforms)"
	<mohan_parthasarathy@hpe.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: How to connect a CXL memory device to a NUMA node ?
Thread-Topic: How to connect a CXL memory device to a NUMA node ?
Thread-Index: AdqHRNf8XnDH7avoS3Cut97v/auefg==
Date: Fri, 5 Apr 2024 10:36:37 +0000
Message-ID: <PH7PR84MB158244A35FB3A633E6E0DFE888032@PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR84MB1582:EE_|MW5PR84MB1570:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gaECZTaKVGRo6P6+5M1AwjORJmhULXLd8XapozKpmbNpzs+3CxF3zezakeyMZSUWM8Gci4/J068jzm02RldnnQ0/nRPIxPZitieAYHpwRVcJhD7oQe8HUBLGgDWfcii8QWmu11BwGZk71ekmi+xJ3ivMdH9pm5FuGVL8Vvj9Wn5D2LwV8QBrAB7I7zSJfoJW50Z9KFDZ8iQvyjm3fXa8zh1t923HFAGkiF+BTI0EYkpzqSoB1axBY0ej8vXBgr6gIzwnDC9MuD+kKVOLV1ZGgMB2BVs1jWwSJVrj16N+9s6BXTU75DHp2MknbIVFbBguFuXx/tJ+foos1dr82eg+R5+QB2P0CAA2AQGKPpDOtFBToV6kqxwZmcUYMLMyYhwZnazA6lsHTeICuYQjUD/LIiah7xFwiYXmG655n7kKH1Z3o15gb+MFZ2La8Pc7P8n1ZaXOJjdXkkoLwabhvYzcbxq3Dv3A5YFv83cTg5t2MqLOGf6agHwoqmvPNkxqLOHkApM78xI+fSN7nP3bifb7OOIAvx8OrBBlF0UUMhheDKyZNJZdBfzBSuNdpX/W9pCz6luA7M5+GnqfOvrIOPd7QltwQSLMkVuXQvEee+NPVISUzhjhNvmifOOL8Tj0FVOgU/lwdNEmhQsm/r8gHg+KvnwqkI+xOy7f+OBv4C4xjvw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xHtBmhrDrVqxg0t2iY3UOjWFAGCOOHy1HCtJvNnt5lzbUF+y1rCgBmyeFWst?=
 =?us-ascii?Q?v/tDdarjJLin1Z17GoQk9Al0VMv/2JYCV/OHLpb9ykjiI6aTLWunHB2CsmSz?=
 =?us-ascii?Q?JBG1WtJ4YoYtG6XFVBzWKHlJ/UFcJm7DCOQUGmiZl1y2ceCLV1G+0xR85N4F?=
 =?us-ascii?Q?YIohJRmJQ1Qas+yPxx4h9EH7kePO6vN2Ucvf0OqI2mIbEi7+LJ34f1Bd/PYb?=
 =?us-ascii?Q?65rgiXQ6l9OD70nHqYl9fJWa0yYu4EViAJvznv0IjDu0MZj8+K/mDGUImRT8?=
 =?us-ascii?Q?mSCAKJxedAcLcj0qfw/l8JeMaPj5Q+WsELHQd9lbVFbYERhcRW9XpxrqFSIW?=
 =?us-ascii?Q?i47QJ48aUNu0u7dfXvnYFgEZJkBaafF5HNTX48wy/pE43h7pN3UH1+F+pDkh?=
 =?us-ascii?Q?zEhCcItEzfSPkmVqQuQ3lmznFXQIWNfOWpfpKaHS93OfmeVwsF4at7NnEBCv?=
 =?us-ascii?Q?J2ePOVvtrSEysneSuOpS/iiQF38qWXAGe7RsNtBaXCR0OR37AA71FHOcUHAP?=
 =?us-ascii?Q?WjZ5dEil1gZNWj/XZ968XP40cFN4l8vrenJJWfj/8RnpV4SwU4LfPgR+4NW3?=
 =?us-ascii?Q?lH2S6O4ZS5wOyJv8i9VKluE1dnyxgdWHu6it1GMRFNeYXXdc831K/d0WlEE+?=
 =?us-ascii?Q?v7pyY20sOATNLyIhHRoRxUW2MpU9sS+u4SH7i+Ynjnq+bcHfK+0OocSiK5b9?=
 =?us-ascii?Q?IuTKXLLZKSn+B2RpGMg8RtqyLcwLZskvMNhrkDJz6PLyjpgS63y0lU2O3q2R?=
 =?us-ascii?Q?ozQzbHtovX1c1A5tbFOuZKuoDOyFx13gzbjVBvLA6m2C8PugeTliFkZ66UDC?=
 =?us-ascii?Q?hB/344tbserMk6axwI4P/omErSB0RjQIg3y2cshBeLAd80ga/pPIMcGa5/Yn?=
 =?us-ascii?Q?kioVNj79ZyeGmNNlPOZV/OHiMPF4YXZ6RQjg2fz1sJcJc1yQik0kmyfWfx45?=
 =?us-ascii?Q?WBF/G2t7unMvnV0XmuBHKek+hLWzv9GKTWRPOP1MTgtB7AOrhuG7ZRN5VAL1?=
 =?us-ascii?Q?9Zdg2lMs5jTYPAubDG5hTn9F+GacOJ904VtxJIKlDutMQjBkX8CZiFY2tcG8?=
 =?us-ascii?Q?wQ3SiV5jrx7teefHeBA066DPbxH8D+/+6yJBkAfVFebPOI9TLkWW4hVNwIhY?=
 =?us-ascii?Q?ox9Hm5NCkdsvs9lSLZ6YJaYGyxIJc9VOHue3XwjplJ/2NPfRwnbngu6aLhv7?=
 =?us-ascii?Q?XoDE18OpS6s462yTHqG2147imLtSFlxxliDPJy5SKaMAqRq+sUXMVG9itqbY?=
 =?us-ascii?Q?8VLbgkRIf8rbOFQRZ7ssgypkQmTofzaVEf2E0uINUYv5AmQhh6yYsfWb42Oe?=
 =?us-ascii?Q?XwzqyGIfOYBhN14wNnVsjcn+nS7jUUqmexVGPSIRuvD6mmIBahu6BfuJssYO?=
 =?us-ascii?Q?84C8aT0F557ta/i4w0hVQPOh/ZHhj9oIqjQX2FutnpKmSUtn6lCR5fKEZqlp?=
 =?us-ascii?Q?qOeUPBgTp+MXbwAyti639qGq+Vlnm0vWPaQoZrUaw/G95LMbDxdmnPXC9iJS?=
 =?us-ascii?Q?9S1dAa3X7SC+6nfam5lH6ovcw/5699sp6t3ieJQPIIcAkDV2r4gdAoqf/dmQ?=
 =?us-ascii?Q?m0eoW4PauRxAbURLc5Hq4FeWc0klefMxnJFYbpGuVF1OFNnnDBpE2CrUuPMm?=
 =?us-ascii?Q?2g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ec484fa4-cc58-4ad1-067a-08dc555c4588
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 10:36:37.1116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ob5xaq7FbsghKJ9QoEQzPA9Nq64sYs+pYoFhEdaYCZ7uwMVwql5ooI/9MoRj5WKpNQD41vJHqFlXO0N/nQQl7mfKV1t2ipxEd1CpAV4Xa7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1570
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 8YTsy-N56KLmXU5jPtvvoh6eDUwW8rj_
X-Proofpoint-ORIG-GUID: 8YTsy-N56KLmXU5jPtvvoh6eDUwW8rj_
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=645
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404050078

Hi all,

I want to create a VM with 2 CXL memory devices - one attached to NUMA node=
 0 and one attached to NUMA node 1. Is this possible in QEMU ? Currently wh=
en I create a CXL memory device in QEMU, it shows equal distances from each=
 numa node in numactl output. I want it such that it should show closer dis=
tance to the NUMA node (or socket) it is attached to. Something like this :

[fedora@localhost ~]$ numactl -H
available: 3 nodes (0-2)
node 0 cpus: 0 1
node 0 size: 1894 MB
node 0 free: 1627 MB
node 1 cpus: 2 3
node 1 size: 2012 MB
node 1 free: 1696 MB
node 2 cpus:
node 2 size: 4096 MB
node 2 free: 4096 MB
node distances:
node   0   1   2
  0:  10  20  20
  1:  20  10  30
  2:  20  20  10

As you can see the distance for numa node 1 to the cxl device should be 30,=
 not 20, assuming the CXL device is attached to node 0. Any thoughts on how=
 to make this work ?

Regards,
Mohan
