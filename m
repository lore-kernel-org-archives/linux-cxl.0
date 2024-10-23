Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F761E7C10;
	Wed, 23 Oct 2024 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718294; cv=fail; b=NdVLS8FmkQT4gmyaJ/Zi+8sOjwE60fWd4u1dUtDH3ZWhQ0PfdcM2hEjv8pi4LXbRPs3kzQ6LxQfAcyanOYtO3EZSuC5E3Pq5vhC29CgYIbhrdMeUAcI+SkJyxqoPeAAVDgea78o1l73IGCgtUQnixXLIDVygPRRgC6AhMxBHDMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718294; c=relaxed/simple;
	bh=39Q413v7ESH80Li8u+3U6UA80sCWUfVbNbClxZaMerE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cn66E3wRFb8HNjl7AoFG+cl/X92j761Jxc3hvOLTO5N8xuJYaUYHpJsfW0KFTa6MyBiEDTkI/FokJeSBS2AXT563Kl6B58Q/UtKMfZ2cqYJpJIjH5e5Aju60BR4kgkFGW/Ikof8l/l0GM+N904tRPOE4bZoO0rNP8Fg8pD22B20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=fTrcg8NB; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="fTrcg8NB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iV/UUYrqNZ3SEfFEVQsqn+apkcSl33mW5qNYQGy2+zcY5ifQ3XifCstEupGYRtTwquujq9i3PuSzyyb0YuIsxxfIt+hAw5s8ZyilSt4Sg5mZsPXuOsBMNMHa/pKiEYO0d2i2uED0c4unl1mTXuGv75NdYie4xQilDFez0JFTkWQ+hifywvvoOwDYcbzqIWlOcGk82DVnon5LrnGMPadPs5psq3lc1wkpyBulao2Das4yFXhUqk/oE5ytXTKrjGtGkBPsYs2Xzf+S6moGBshOgwBHolygWoICym/N4iaLycDRn2wpYYZlRLXCJTnp2xiOpRE0ARXzSuJqk1engxJnpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2Q9j+FO/YgVoNFQszaZRKfRM/AnR7n6BKRzkVzLKW4=;
 b=rJHFEqYMyqF0A5ZjEhlAObQphNVoctx3BlhiipEW631gygSGBY5N3o4YFOQU9U4tPHCS4ZH24q9w7POFXCWJIgbmRYgvCTNz7ijigfz1TsUf6EzS4QwywhNfoC6GV49RqBFQ3oSxtAb+Fqu5k557DrRwdsanpNULstcvKAZUgo1lZex1KoPyyCXwr+tSPvGiRvEJWCtQri4y7x055wtkAoa0N2EV8Xr1OFrbhARhQ+OpnmpM5IaqwN0mbLXEICGiBje5AdKCgJ2/pjbyTC9tyDdVqwnFhlGiaYLRF2FuNhkpeq3+dU/MjUVg7LH80kntN9FdsJT5uAFSmO8bn0La2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2Q9j+FO/YgVoNFQszaZRKfRM/AnR7n6BKRzkVzLKW4=;
 b=fTrcg8NBN0DEWGc3KEYRRX3SbQ6xKa3S2g7YbcpbQZvwHqZvNcD7yxlnqgqPEm/X+2tmITNk6cligUwst2VymjFGuWIqBCYoBGKgZTqlCTucwQk2NL/QZvVb97U2Lr08QYiWPVMg0eUQVlfpPa+Zy2bum0ElqBBYHkEn2W5yMn8FUs60ltfhvFvxzhAxj0JMhkRwrOWtDFpPaAgZZtGPRewHZOsQ8h8QTzLo91k0UXGaqP9B7pk7eV0XqTdc3EHt57IoGElPKngyAf1vkUlWB6cR1JdpUuAMhoDmCGetTT1WsIrjhPgqMchdWQ3f+DTpbOKsuAeLqOuYebSKaichGg==
Received: from BY5PR20CA0032.namprd20.prod.outlook.com (2603:10b6:a03:1f4::45)
 by LV3PR08MB9366.namprd08.prod.outlook.com (2603:10b6:408:214::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Wed, 23 Oct
 2024 21:18:02 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::e0) by BY5PR20CA0032.outlook.office365.com
 (2603:10b6:a03:1f4::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19 via Frontend
 Transport; Wed, 23 Oct 2024 21:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 21:18:01 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW17EX19B.micron.com
 (137.201.21.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 23 Oct
 2024 15:18:00 -0600
Received: from BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3]) by
 BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3%6]) with mapi id
 15.02.1544.011; Wed, 23 Oct 2024 15:18:00 -0600
From: Ravis OpenSrc <Ravis.OpenSrc@micron.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"fan.ni@samsung.com" <fan.ni@samsung.com>, "a.manzanares@samsung.com"
	<a.manzanares@samsung.com>, Srinivasulu Opensrc
	<sthanneeru.opensrc@micron.com>, Eishan Mirakhur <emirakhur@micron.com>,
	"Ajay Joshi" <ajayjoshi@micron.com>, Srinivasulu Thanneeru
	<sthanneeru@micron.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] cxl/mbox: support background operation abort requests
Thread-Topic: [PATCH 0/3] cxl/mbox: support background operation abort
 requests
Thread-Index: AQHbJZEJ/79B9oxMfUKseUdawpTMeQ==
Date: Wed, 23 Oct 2024 21:17:59 +0000
Message-ID: <d4fb5d07a2994f6b9b36b1ee4c7e6563@micron.com>
References: <20241022031809.242591-1-dave@stgolabs.net>
 <feef15c9fcfd462e9b3cf614a1b4621c@micron.com>,<zrmn3j2wzzlnzzwunk64xfy4jussoiek5ro73qs3yrjqflemtz@zbn53a27tt6y>
In-Reply-To: <zrmn3j2wzzlnzzwunk64xfy4jussoiek5ro73qs3yrjqflemtz@zbn53a27tt6y>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mt-whitelisted: matched
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|LV3PR08MB9366:EE_
X-MS-Office365-Filtering-Correlation-Id: d1560e6a-86fb-4844-d835-08dcf3a82d3d
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?Nv2RrV0Zcy+XRa8Amr7evrG5RJc4eZ4q/FEHYVeGKjG2GkRqyBkGeQMWuB?=
 =?iso-8859-1?Q?h1pU4ZjKTNCY0MDcI9LOhqA+90uh94FvjTMNlfZTO8ta3Bh2rGMRdmUhl2?=
 =?iso-8859-1?Q?BgEuOhM/pnltp0PrgcmTyqPEO1iNriXSu/6/b528hsQ2hpDsUvCNyaV29s?=
 =?iso-8859-1?Q?8pYv0k/cg+EajYT8A5g53kGaYr0L4BAfhArqFkETg3NB6ctWHsFaDCSHNw?=
 =?iso-8859-1?Q?U1Oa+vGpoev8/QMrAMYWwDaXunh8aHV/JH494QW/81UzQMhS0cAax3vTtc?=
 =?iso-8859-1?Q?hlwuTbikaUIR6dA3zaPFGwFKrOYxnCTgFMYsDM4XyoKAB90iuwak+1aej2?=
 =?iso-8859-1?Q?rydUC94gt4RM3+mhxTxkIaxTEus6AG/HP4wQ6vwsu+vDW//TbvAUFOmG7R?=
 =?iso-8859-1?Q?CC1ZfE0bVqC6HZsVYMKv1Kik1FYHJ/8M2ABnNL7iW1i/dao71aCgQEIePl?=
 =?iso-8859-1?Q?vw9cgFxfK6Ftv+K8SD1O6U1FG0oWvEJ7yKUy4zeZK3Cbj5ESfzmG+M26aC?=
 =?iso-8859-1?Q?abYJ6RRH05qHqnrZbBOxmXF0jIiTSso3gDitqwE6CB9slUPHZnboxBY/yC?=
 =?iso-8859-1?Q?+ILTd016nL745Is+oKVqimrtjjG6g2HYIkFepuuqWmIq7EqfJlqUA0x7jg?=
 =?iso-8859-1?Q?duAdYaEUTV2iNLGNv1HBU+P3YmpM4Snnso6H0dzXymIupbvzeTYLHdxGVT?=
 =?iso-8859-1?Q?cgyr6CKJQgZHb06pO6J4LUWDHLOECBs/kQU91A5zZVM5kVLEJqVx4kHaQZ?=
 =?iso-8859-1?Q?aQT8Kx9rkfSUCkLBg4Jn4WQ1UulOlzQqTme+TjyvSzy2YGTTAp0XTC709x?=
 =?iso-8859-1?Q?sh5XnboWwQ1Dw9yK0FB0sSTlCRuDKyIhqiG7p+TGhtW4FaulXNUEvmv4Wd?=
 =?iso-8859-1?Q?yiUhbkmetl3wMO/c7QJJz7enL8SPHTdsMbciJWX9lUMppxycT1dPmbB5bv?=
 =?iso-8859-1?Q?+IAV1KdaZHZi5KzvuUxJeW3jEneKIYpfUOVercw/sf7kBSYu2D48er1x34?=
 =?iso-8859-1?Q?HENmhKNInh5d6+RSha/uMFDm4sa8KwYYgUA71GWw3ynfEdG3kUOdkIMBH/?=
 =?iso-8859-1?Q?qARdwb/JztmLGchA+0s8ZfuMnhSaHuYqWAtRVHqKXLZGYjxGTrnBvp5VlJ?=
 =?iso-8859-1?Q?D0Y8FaYBAbJ5F/eeHe2dB6dC5OHXCa8CkEjXN7Xe1AGEMwWYp+Afq923gx?=
 =?iso-8859-1?Q?g57MzUQPg4KfLHrUcgqEUccwNrqF3EGJX1MsTkoutmLfH1Fi8Yu6HSwVID?=
 =?iso-8859-1?Q?K8DQQ3o9bnyEGCrpyXtYNF7EjDR/kpcCRCumm6D+OwST2cArqaJzIR1n0H?=
 =?iso-8859-1?Q?VPH2j2yzvXNCoUYPyeYTGMoaedF+LmDTLEGz5EHu5CS8OSm1CFLeaxwfPz?=
 =?iso-8859-1?Q?MQv3M0M/FLxrYSBglm/UYQNGq4jEWmu7pPHIwwZbLvtyjYR/7L1a6A0frD?=
 =?iso-8859-1?Q?h/EhWyawkqnhbLXvZzRPwkXu/SAZaoXURmdLfA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 21:18:01.8069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1560e6a-86fb-4844-d835-08dcf3a82d3d
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR08MB9366

>>On Wed, 23 Oct 2024, Ravis OpenSrc wrote:\n
>>Hi Davidlohr,
>>
>>   We have recently submitted an RFC to implement Request Background Abor=
t
>>in case a timeout is encountered while executing a background command.
>>The patch series disables those background commands which do not support =
abort
>>based on their individual CEL properties.
>>
>>https://lore.kernel.org/linux-cxl/20241017163215.00000547@Huawei.com/T/#m=
a6710971908b85a5f8c5da2e23b8102b5a6e277c
>
>*sigh* it would have been nice to be Cc'ed.

Noted. Will take care of this in future.

>
>>
>>This implementation is based on Dan's suggestion in a previous thread.
>>https://lore.kernel.org/linux-cxl/66035c2e8ba17_770232948b@dwillia2-xfh.j=
f.intel.com.notmuch/
>>
>>We can discuss more on how we can potentially merge and arrive at a commo=
n ground.
>
>I think that my approach is way more robust then defining a timeout as in =
that series.
>It also aligns more with Jonathan's comments about the abort being on dema=
nd.

The one major functionality in our original proposal apart from implementin=
g abort is

Allowing background commands to be invoked from user space through the prim=
ary mailbox
by ensuring only those background commands are enabled which also support r=
equest abort operation
by checking their individual CEL details.

Few questions on abort implementation are:
1. Would abort be required only when a new bg command is issued?
2. What is the path for supporting background commands from primary mailbox=
 if not done through
CEL check?
3. Should all future background commands follow sysfs path?

--Ravi.
