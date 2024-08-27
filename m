Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385D717C69
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774527; cv=fail; b=L9X9xO+kk1QbsnuldNjHh9UkZHG9/oqfG6TZeLfBBAmLopMPdUkzO+S4W0JfSrEPZNskGIdchsLp2qfb5CiWum6FvzWxPL7eRqzWH4F6HbTnKuUqSWUBIOhili1Woy04j/XvCrW20v4UAX8c6oXyh7LIFD+bUzerhhDC2Jnc3KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774527; c=relaxed/simple;
	bh=kNLCUEs6lEcMRR0NNR/Xv3Abq59Iq09w/rxiqrm19nE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MxvJfFoMVcmyU6oTdNepSx21Emu1l3UzASyyizTIKYQDWMbkmbsdAFQdIytBF+v0/ImnU0Yxx30cscpTrpKTLTnGmhx8QrcKtmVBRGKAs/FvXiSbSll127E8HRYkBmxXmdYcb22CTpEOiBpFd4geXTQNYqQG+A/7xYhNr4dlfVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=Zt/q89tu; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="Zt/q89tu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEXaHb2jPTB0KvL6Ty/NfwxRLgaYXutldKLlNJtBy2dHoLrOqP44Vx+U9vJKJLj1X1zDwaJ00KPpsK64JQ7BRMmRSGY8UVFguolsk3y2TP6q7V6rooipX3MKRmDctriYxRRYNujP61JSRDSDMV14iLlarnr8Cs2ErCRthi8B5FNSdBd5n01xSg+etyfNZku+CX6ydPzeKXxMItUssJP7hyj6v95Ix7CIoYZiMJ8742pBhm+QpF9fPqMofJBYq44iW/uZYfb3Uevf1plSRus6I6NoRUNSfRm/27x4C0UXHuSmYOsYkxFh98BANJ60dkmc8N7l4Hrp/7clGGr+yJrlpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNLCUEs6lEcMRR0NNR/Xv3Abq59Iq09w/rxiqrm19nE=;
 b=EXlaKLl5+SBORAcDM7WZEDoA6933uSIhtEtuIlAj+6Ls5oM7+D61/whSc87+Yr38iYquazEQ6QwQeKF4pWu9jfviiihCQ28jMxLhsRYRDkmubLzHoI/sIDavnn7/NwKSZ6zLvo6AcWWjKL/T6uP9cMYFJNpnRXqk8pbfF3vBGMHzFY03pxiNuq2CSRQxzdvat8AD96SKzFkZfjyw3aoBE5U5EJ65g1I+COXM++3XDiSo+uar2paxMspmiynOJo4wiaEsp66GnKcWe5SOmCRXgg0rP5SgKaIM8qXzJ34RWrH/vN/sL0IjaCmh/v1ZvlY1+S4WK8Osw505z2kTtjnJng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNLCUEs6lEcMRR0NNR/Xv3Abq59Iq09w/rxiqrm19nE=;
 b=Zt/q89tuWCgNOHXlZzCCPGEKL5DrHoBkukUQvDENhhO4N02sLPuxAEH0gNP07g14Rs2EGv9YBGI8YaIHxou8tNAypWQctsljZZ7JsTtHOmxO1tq8nXli618m8gCivneh8R/ssyjxReqNVbwG87Pcr7PuCKiWduVaeglNzkBOnFcJf5xkRpe8Ms8CUdVYgKkp7S5rZg07+HF06LcbwF6wPm2IBB7ZtEA6hM18P1nx58q5dxdYGwXMQLz7RDaRfSpswXfe8eq+VvvdexEqjE/MWTSEoAkC3y0EKcn5Tf2Re+Fk5b8DXH8Hf0cJAgafBQ64dRF2iuvJ3HDw4gVWqTgzpQ==
Received: from MW4PR03CA0285.namprd03.prod.outlook.com (2603:10b6:303:b5::20)
 by CYXPR08MB9635.namprd08.prod.outlook.com (2603:10b6:930:e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 16:01:58 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::91) by MW4PR03CA0285.outlook.office365.com
 (2603:10b6:303:b5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 16:01:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 16:01:58 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW36EX19A.micron.com
 (137.201.85.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 10:01:54 -0600
Received: from BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3]) by
 BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3%6]) with mapi id
 15.02.1544.011; Tue, 27 Aug 2024 10:01:54 -0600
From: ajay.opensrc <ajay.opensrc@micron.com>
To: "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"john@jagalactic.com" <john@jagalactic.com>, Eishan Mirakhur
	<emirakhur@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, "Srinivasulu
 Thanneeru" <sthanneeru@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
	Aravind Ramesh <arramesh@micron.com>, Davidlohr Bueso <dave@stgolabs.net>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [EXT] Re: [PATCH] hw/cxl: Fix background completion percentage
 calculation
Thread-Topic: [EXT] Re: [PATCH] hw/cxl: Fix background completion percentage
 calculation
Thread-Index: AQHa4aFnXFAhiNhGOUK/S8twyYFQ27IPIt0AgCxNQto=
Date: Tue, 27 Aug 2024 16:01:54 +0000
Message-ID: <ad56f019ee6e43f4b209a814f5494af0@micron.com>
References: <20240729102338.22337-1-ajay.opensrc@micron.com>,<svy4snogtc2k5423b4vtmzaoaryetmxzatjfiqfeiywepkr7us@dcslpmazfuw5>
In-Reply-To: <svy4snogtc2k5423b4vtmzaoaryetmxzatjfiqfeiywepkr7us@dcslpmazfuw5>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|CYXPR08MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c927a10-c621-4998-8075-08dcc6b194b6
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?iCjpZmz80m19u45IwsuKOv7C6WthP9eCxSYpGTcmiZMfMKXzdOgaPZLBBt?=
 =?iso-8859-1?Q?mM2JusC1RfedxYhDrPAKVj0kGhPc/duwCtsmsyxxn9AGpK6t2dirRLjZK3?=
 =?iso-8859-1?Q?P3au5DKNHZsBfHvhBuRCb5F1eLn4GxPgpg75oJ1WfqHAhUbkyzRpmE/S0F?=
 =?iso-8859-1?Q?h7CIMOCc0Bfjbeo5n6uE6LApNZKxYFvc+BThnu0OTt3gG55ZP+Xxd+TVAl?=
 =?iso-8859-1?Q?nImsukOb0XGszIW8xlzCPL36aMOet3yoxqU7/QUvBMFhIGc6eWCLNdYO2y?=
 =?iso-8859-1?Q?gbx0s7aiwI/n1vE5q10aE2HcGmCHmW0FYlrhjMvTA/qgTR03nnbBfRrVI1?=
 =?iso-8859-1?Q?yy3gCtQYwuL3dCbwcPEIwvL/ILbAZHalttni8cUTXt7Y04T6AC6ZLGNA5r?=
 =?iso-8859-1?Q?ATKdjmpLjSx2a2Lr4Hk8+7hPAyszpNCNBBwzWTmwVDySJ8fEidKaENf0p0?=
 =?iso-8859-1?Q?VaPgUX3UN1HtQ8amQHQ5EQrpTt1E2Q2KBd6trabF6Yah+RtEhnPMFq13o3?=
 =?iso-8859-1?Q?fEJLj2+pJYyBPT/CeGa+L4rc9BHF5Vog4nVCKKQGaB3QAVZx/yf2OP/d9j?=
 =?iso-8859-1?Q?zOgWqg7aQLVZIo8BQ86ssVEw5akV1ol+goQZLhs3mwa9sff3vk3YxXYeFH?=
 =?iso-8859-1?Q?jqpCAQzPMYkXIB3678ptfsjwnWcx8F1om3RBW650uwSrcPvljFEeiXUFOG?=
 =?iso-8859-1?Q?QURg2W5ATm7ysihTKs6ZjMB1BCVyUJOOh5cEh/81d9oRACXzMu9kxI7iOL?=
 =?iso-8859-1?Q?v2h7T1vySfD7tXhx85Jo+VGrQS9UFggT1qMBBzRKFl8/ZwbbxoltxbuxbN?=
 =?iso-8859-1?Q?uO8aehruseRvs+/vcueBdqu7bnXATRngLy6BmF7GRdzQwbxukEUtpwozww?=
 =?iso-8859-1?Q?5MeYPvtBk7g8gwWqwgNtXud30VbmARIgWTxvCUfhSNJFXwxiKg1D7kY/z6?=
 =?iso-8859-1?Q?wz97VTcbL5qWha3Z1V3xibWzPVrJzNBHdCPfrNXScG+V8fncKU3kjE5Fgk?=
 =?iso-8859-1?Q?nYByVb4OJ5l09SGW+BpuxTWKCfFPbvCDeyPGUidbS0Lw0d9OCBnjKJKg6/?=
 =?iso-8859-1?Q?v8Mv4slo1Ag8SltIYy12CF573nEy/eNfHSUu7IxtK2oV/p+gBA4Wcgm6tp?=
 =?iso-8859-1?Q?HKU+bcg/Qzt3Wmqk3UnEXdI4iBj6gnNtIV9PUaJ/cvMvlCj+ZJeL0aW55v?=
 =?iso-8859-1?Q?+WW8Db7e3sl+Rzz4DFodED+MwmqWwe+8G16msSn6v9lVcK1/hVFm9xjp48?=
 =?iso-8859-1?Q?ceWyl2lkgzAyTveXxggvV2IKEAlHDsbSSD6/QLGQVi8VblaE4SJ0tQbtZ3?=
 =?iso-8859-1?Q?LvCQh3EhzcR6vfE8/wP4yrAaNfFRF0BHaME0jLhcCHf/ve85TMBn2Z8S1B?=
 =?iso-8859-1?Q?hjD16qjn8mXnOzzY2Kbha0XEThwzqneEfnOn8q1TOJKLx1SPb/EtKW6Nax?=
 =?iso-8859-1?Q?SE3IdYgtZ57A6acGIKlARkOnup2QMiG4NlnUkADtfa45P6611pZ4Sqgu2l?=
 =?iso-8859-1?Q?XQiOEOQ6ThOUr4rElE12Oh?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:01:58.5173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c927a10-c621-4998-8075-08dcc6b194b6
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR08MB9635

> From: Davidlohr Bueso <dave@stgolabs.net>
>=20
> On Mon, 29 Jul 2024, ajay.opensrc@micron.com wrote:\n
> >From: Ajay Joshi <ajayjoshi@micron.com>
> >
> >The current completion percentage calculation does not account for the
> >relative time since the start of the background activity, this leads to
> >showing incorrect start percentage vs what has actually been completed.
> >
> >This patch calculates the percentage based on the actual elapsed time
> >since the start of the operation.
> >
> >Fixes: 221d2cfbdb ("hw/cxl/mbox: Add support for background
> >operations")
> >
> >Signed-off-by: Ajay Joshi <ajay.opensrc@micron.com>
>=20
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Ping.
Jonathan, this patch was reviewed by Dave already.
Do you have any comments on this patch?

Ajay=
