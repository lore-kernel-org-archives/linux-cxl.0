Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8134E1DA
	for <linux-cxl@vger.kernel.org>; Tue,  9 Apr 2024 01:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712627892; cv=fail; b=cJ5RFyzh7MEOEuYdW8G0zn6Z0HYte4wsiMNGG+zBgRbbtbxl6kOwz038rLO2AU8BViiNk6W0UkR24jeg1Jr1C37kj0priIKoX41SOq5r6c2+Y7PrG0ZdOuGyeFBpc3RdmH+KMkdyB7vH/UoQmTc7DToIMtSt/vHBkxBz5BST8/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712627892; c=relaxed/simple;
	bh=nZJJ6T2BpU6UJ0CYFEUb2oGM0/lBKQZOIwZkW2/kPDo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Hwi9QrCtonA/xLDsFuG5x7axGhZ0SvXEQZQL3/iiw8jQZ8V3nf8yg2rq0QZN/I5QYuKNfgmuo9B+jIM/q/J6waaL5WOIxi+JWqlAfv/Yic7ngyTLZEYG/3n+keM4IjCmYtV0JGxwLI3qOK/sYo9avha8z1D4fE9tYzUNWOcTDWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=SIgfm2fz; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="SIgfm2fz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6OmwgAT5TgpKG2MEiPOKqWP/87osQ7uMQvt+Rr347vFQ51f3n3VNFIHVTPXz8EmAAXXcZtljOgRG06V/bCw/6opsNH2sUK1nCcwjKTCK5bxr/G47KNRyz9lNCMPBp+jECPWVQPNbZJwvh35TcEKdcilXBktlR8xUzb1cs1e5tpRA9Wzv5weYxD1wbrtpCY7YIB+l27pbcz1FlAmIn21zjNzrx8YwMW6d2p1xPJ8dQgqColZT20g5EBL73iRUb6FSPVOhNKXit7k54vvvqKqsAzXX4kz5WuJuMh2PKvJazKOhsXvOKJSq6NN6CrtFwFnxnX+PzDAYVoWZ15P/wk5Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxtDTHeJxwJFVbR7U8WmCv2LpMjM6gC2ehdvM5MAaZs=;
 b=VlUyZi19EfjAHaL4tZcSu9F8esvCkPoIJFFHmhoz0KEm/dlIEA/h8N++n/5gzrR3TDbd44S2ntBIL74BSDdrqOjleQ5QGWdY0QcOmd7q6dI7LKXUyGDiHEhGDVCOsfInRVLBLvGoH4YZFA31sQRBXloge1XCGLIB/vdGQO53cpITZFp6Kk/v7Fa7zrjRQ5zarun74JD7ma5zFSC0TI16tChF/mzPjAl4xS82amHHVPQnf1ot3VSDyUYmQvGInRMHBVGX3Y0qtA2U6Uope2Agen//RSxdssLi5PugiE/p5KSZtB4ZJ+3YNUXIchnm0IenUjz/v4DrM8Nen7/aBgKkVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxtDTHeJxwJFVbR7U8WmCv2LpMjM6gC2ehdvM5MAaZs=;
 b=SIgfm2fz1F7uOITpflpass9WacQ4BmS8mXN7p43RPUM/BEOrjafR9ooB+nZ3CWDAL5Dgogi16EI1CA9HHNLH9m2mPtvRm+zPsa4fSr/lr0j1Pp4ny0vMHDgSA9RtpsZPOCAk9rA8+3fic1qn2ITZuKy2xJM9A6ltR9H+2+AF4NCEEcNuqHm14ox+uK+pyETsPPrN7ahGJnkDXc9SsG2UiRVpod5xzjpcWfgIrP/DTxaEjMJgW6W8tnPpGHqIRUE5Zw9HbHMWjNk5iky5CFrfysThM5N2EPiFszd9HLYPklhJ/8GeKtAzJ4n6nSwdwZEpA5U5eq/VbQtvZUv59xoO6A==
Received: from DM5PR08CA0054.namprd08.prod.outlook.com (2603:10b6:4:60::43) by
 CH3PR08MB9129.namprd08.prod.outlook.com (2603:10b6:610:1c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 01:58:06 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::e1) by DM5PR08CA0054.outlook.office365.com
 (2603:10b6:4:60::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Tue, 9 Apr 2024 01:58:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 01:58:06 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 19:58:03 -0600
Received: from BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3]) by
 BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3%6]) with mapi id
 15.02.1544.004; Mon, 8 Apr 2024 19:58:03 -0600
From: ajay.opensrc <ajay.opensrc@micron.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Srinivasulu Opensrc
	<sthanneeru.opensrc@micron.com>
CC: Dan Williams <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "john@jagalactic.com" <john@jagalactic.com>,
	Eishan Mirakhur <emirakhur@micron.com>, Ravis OpenSrc
	<Ravis.OpenSrc@micron.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>,
	ajay.opensrc <ajay.opensrc@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: RE: [EXT] RE: [PATCH v3 0/2] Add log related mailbox commands
Thread-Topic: [EXT] RE: [PATCH v3 0/2] Add log related mailbox commands
Thread-Index: AQHaih1wTKyiOWcwMku/sF0hPxzyHw==
Date: Tue, 9 Apr 2024 01:58:03 +0000
Message-ID: <8b5fa16f05cb4fde87441ffd81552b38@micron.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|CH3PR08MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: b7389a48-5999-40bf-5dea-08dc58387fb3
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mv9u6oKHXRJ/rjgaxZhc4OBXF8pcq0h4An+bMkDXov9m3HqhOEOVrIwDgjXAEg2L52z2Uofx5SLGeblvnxGOlgYaYF861tVNnH4Sftdycj9uFuGJ1OnY1NGkotMfcZCk10Ji2qKVpp88M/vhl2HvQG2KtiGNw7RTRN3TmGhR1h1oJVpFteaThg78CZnr+wHdvFPxh8bs4UnHdt2ok9c9rvIFLcZ0p5dL+VuPI8Nt3i7zKbTJ/fCz73pO2LFZTV/kLzUlNcrz3qh9vdi1kzAYKnQkzakdYL5IVEOTHDTwl4fd9RzwimE+ziXbd4U9W9rCgfWwXKrSayC4vZ797Hpq5aWlVkpUpMcRgwOtdLWZCxBdxi4zHW/0FWdeWurzhhTQfWnQBRbKLvXTZo+LE7ggdJRX/lNAFBCmUq+QkmnfLv6egs8UBUXDDfKC1KRIuFXbU34x6G1DNLVq8ocv1yjXIDPaxMNGgAuyzjSy9Vt3vLey+sotk5MXWmq4y5IjlbL+RPF3NkLiqkrJq9N1UfIQrYcKQWvpQgv2/SHR/+eMlm8WK/Fd+wYlzvTVt1gtQQlrOfB0MzoxfhBb9igMhWvjD+yXKwMBkafHsWXxSPCH66Swgwfsp23JXl3SUlVaUHp3lyuZHBT+JlH0x4Yz9Gw1z9ETIeOKjW00YRxs7o1Kcx/Jsa4N44JSafUJhun1QjVm4t0KcsnK8QXlHm/NxtqO1eXa/VMujlYJcNuuT+VdJvEVgMxwFp6AwZJ2RylXVujk
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 01:58:06.2705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7389a48-5999-40bf-5dea-08dc58387fb3
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR08MB9129



Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> Srinivasulu Opensrc <sthanneeru.opensrc@micron.com> wrote:
>

> > >-----Original Message-----
> > >From: Dan Williams <dan.j.williams@intel.com>
> > >Sent: Wednesday, March 27, 2024 5:07 AM
> > >To: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>; linux-
> > >cxl@vger.kernel.org
> > >Cc: Jonathan.Cameron@huawei.com; dan.j.williams@intel.com;
> > >john@jagalactic.com; Eishan Mirakhur <emirakhur@micron.com>; Ajay
> > >Joshi <ajayjoshi@micron.com>; Ravis OpenSrc
> > ><Ravis.OpenSrc@micron.com>; Srinivasulu Thanneeru
> > ><sthanneeru@micron.com>
> > >Subject: [EXT] RE: [PATCH v3 0/2] Add log related mailbox commands
> > >
> > >CAUTION: EXTERNAL EMAIL. Do not click links or open attachments
> > >unless you recognize the sender and were expecting this message.
> > >
> > >
> > >sthanneeru.opensrc@ wrote:
> > >> From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> > >>
> > >> Add support to expose following mailbox commands to userspace for
> > >> clearing and populating the Vendor debug log in certain scenarios,
> > >> allowing for the aggregation of results over time.
> > >>
> > >> 1. CXL r3.1 8.2.9.5.3 Get Log Capabilities.
> > >> 2. CXL r3.1 8.2.9.5.4 Clear Log commands.
> > >> 3. CXL r3.1 8.2.9.5.6 Get Supported Logs Sub-List.
> > >>
> > >> ---
> > >> Changes in v3:
> > >> - 'Component State Dump log' has several caveats for ioctl()
> > >>    not being a suitable ABI as pointed in v2.(Dan Williams)
> > >> - Remove Component State Dump from Clear log filter.
> > >> - Implement a seperate patch(yet to do) to address issues as pointed=
 in
> v2.
> > >
> > >Circling back to this question... I had overlooked the fact that in
> > >v3.1 the "Request Abort Background Operation" command was added
> (8.2.9.1.5).
> > >With that the kernel can safely support background commands with
> > >indefinite residency. So as long as the device supports that command
> > >and advertises that Log populate requests can be cancelled then we
> > >can build a facility to cancel any user-submitted background commands
> > >when a kernel internal need for the background command slot arises.
> >
> > I don't have the access to test "Request Abort Background Operation."
> > Previously, we posted RFC for default time for background operations.
> >
> https://nam10.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore
> > .kernel.org%2Flinux-mm%2F20240207105349.301-1-
> sthanneeru.opensrc%40mic
> >
> ron.com%2F&data=3D05%7C02%7Cajayjoshi%40micron.com%7Cabe61f69d40
> 2460e2f2
> >
> b08dc55964860%7Cf38a5ecd28134862b11bac1d563c806f%7C0%7C0%7C
> 63847935119
> >
> 7749869%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luMzIiLC
> >
> JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DQyxjJi2iLMTSTl
> R46rv9k5
> > U%2FDZVrKruaaunew8HMR9E%3D&reserved=3D0
> >
> >  Could you please guide me on how to proceed with this current patch
> series?
>
> Whilst QEMU emulation doesn't yet support background command aborting,
> it wouldn't be that hard to add and would provide a route to test this
> functionality.
> We've done similar in a few other cases where no one had any hardware yet=
.
>
> Of course that might not help you if you have silicon that doesn't implem=
ent it
> but I agree with Dan that it is a lot less problematic to allow for unbou=
nded
> background ops if we can stop them for other urgent activity.
>

Thanks Jonathan and Dan. Agree with you on the background command handling.
The series which Srini (sthanneeru.opensrc) has submitted has 2 patches:
cxl/mbox: Add Get Log Capabilities and Get Supported Logs Sub-List
    commands
cxl/mbox: Add Clear Log mailbox command
The commands in these patches(opcodes: 0402h, 0403h, 0405h) don't seem to=20
have any background handling as of 3.1.
Do you think these patches seem ok or do you feel something
is missing here?


Ajay

> Jonathan

