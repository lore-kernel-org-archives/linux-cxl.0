Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F821CF9A
	for <linux-cxl@vger.kernel.org>; Wed, 24 Apr 2024 02:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713924849; cv=fail; b=GWPVEa8eGz1bFCzRocYOJuUoRTj0rQUPRrAoxeV9MvtgNUKTh8p7XKtKsbFBir6jfcryDb8JcdA7wI3rVi/ZAmipkWNrM6ePQFr72AZrAqDIkVDnqOubyvM4paSHGqcTzDJfS0NR/L5+ZuGmNM3PScbNzAc+xg09SCdpDESYHuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713924849; c=relaxed/simple;
	bh=tjAG3VlBaSDlFb8hhXhCxiOgZv0OuSy590eO8NUIqBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gDJjimBYp2KFEGbg3bY1nXU5MznjTyc0t3KEHKHsNH9es7ppOsjO0cJQUx3P8pHFUH2R7R11OO/YUZ/QDixqqBe7q/K2KQ0HYfpnm1HwdMh6mOOSaUOqOh1NQ6acqz5Dmuz0t87G7N03s+NseN1hHBu/o2yGTjsE3n7b0iOBkyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=qJGk3sxn; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="qJGk3sxn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftem7EObQAJp11rnk4NpoW7mk1/IGx4DFIHJ/+yjJlr6FDbu+n767LwurkzzWednF0gEgcT5hmVod9J7u33yF88e9ggL5uCXYs+bJ2KGjRb6E6ItM7Exptw99v0E3HtZJ+tYflB1QdHBwGOraBd+5809dOUhf2sUS4wkTGUwCSXo/pTL32lQeCOkyY7mRvrvZe93pOLi269a8mL7JxdY1m4un2mPPUaOlQ6TFiRbqGuwTAsCJT8SZ+S73TVO7Xdcpg4Kzqo0UnijIB9mc90EGXQ90qeQCV+03R/0SykOqARjHt6WSwOtAPE1xYjNLs+12Nh+ITV7C5KggXXCBICjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EL7EE3oXyYYXEjwKphAklhZaeysJbtlsbBfpR6kLjWU=;
 b=lX9+l6PLpkt59+sqcxLxnHJS1mCYL7g94syE9x10VSXwYEbdlBlwAa7IqXRjneLSeyXriOD3QiRRrgLTHKqnKb4aK+0YPbV/0+zPzPMDNqvPy4oC3xu9w0hv+q0VMRL0ovb91dkJA9B4xbw4CUW7QpBfEshK/un0iFpjQg9+8Du9IIzs9NAaEnvt9ZPNtmSz0XQvyGVtSjNWkuRT7+YgeJMN4t2T2bzqpWAGKLxdAgj5sD+4XVk6QcTwNKBRK/I1nXqjG3h4D2xt8BpvsR8NxJgcZNd68qNLyJKTGTUbcxeBoj7B0gUMJJeR0L1N24fLTkHSPAMildYBXXUF7rbjjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EL7EE3oXyYYXEjwKphAklhZaeysJbtlsbBfpR6kLjWU=;
 b=qJGk3sxnWIOYoAa+yJ6Kesz6pKjfc/kHHoBHPstN3XuFsc+hR4gjxbEnkywCvZbJrMWd7tSTE/iskr4CN10YF25NnREsLL3aTgEwylj9yhaVrfoCaxKWgW3WA2zNa6TFJJ1klKRmTYm4X1ff2lKgQpK1x0LAzu83a4mxr9bhMfNH/ZkRXzUfs+2lp4lZog5GbOvMpR6RZ+kSl/5G8iMKtOXRjfIVAUHbo1zfmuliWGwmlo5Ux+6Tow/7geadOGWt6lEL5DTAg2Yg0dHslKgyyzsXj5VnYkSWkaKtDe3RsIawvzPJlkBDTNmvBpcczqDprOVdGpgyERqE8cBOXP9z/A==
Received: from BY3PR05CA0019.namprd05.prod.outlook.com (2603:10b6:a03:254::24)
 by BY5PR08MB6181.namprd08.prod.outlook.com (2603:10b6:a03:1e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 02:14:02 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::15) by BY3PR05CA0019.outlook.office365.com
 (2603:10b6:a03:254::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 02:14:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 02:14:02 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 23 Apr
 2024 20:14:00 -0600
Received: from BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3]) by
 BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3%6]) with mapi id
 15.02.1544.004; Tue, 23 Apr 2024 20:14:00 -0600
From: ajay.opensrc <ajay.opensrc@micron.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Srinivasulu Opensrc
	<sthanneeru.opensrc@micron.com>
CC: Dan Williams <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "john@jagalactic.com" <john@jagalactic.com>,
	Eishan Mirakhur <emirakhur@micron.com>, Ravis OpenSrc
	<Ravis.OpenSrc@micron.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [EXT] RE: [PATCH v3 0/2] Add log related mailbox commands
Thread-Topic: [EXT] RE: [PATCH v3 0/2] Add log related mailbox commands
Thread-Index: AQHaih1wTKyiOWcwMku/sF0hPxzyH7F2EmiL
Date: Wed, 24 Apr 2024 02:13:59 +0000
Message-ID: <d3314d138a494a08b65bdf5fd4b034d0@micron.com>
References: <8b5fa16f05cb4fde87441ffd81552b38@micron.com>
In-Reply-To: <8b5fa16f05cb4fde87441ffd81552b38@micron.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|BY5PR08MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a5b273-c7a0-4542-ca78-08dc640435e3
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?ZxzDa/Ro8yekegr4GAein7EKiXTnWv5Lsax3mm0wmmZXmLgIRTmMaYtdoF?=
 =?iso-8859-1?Q?PvkiKpxLG9fJeiILQTzWCtoS45MsAEnY6hu8j6U+nN8U4FDSWuyeAwFhsk?=
 =?iso-8859-1?Q?WmVRAom23hsMjFZGhY04cBsoQ4fyvAVtVu8PdDIDV7KG51eLXk5GlRuBJA?=
 =?iso-8859-1?Q?15jODbRWpphaO8NnYigMWPMWZf98UJ33ZkKRJnvq0Dw1tzJmWWe0ciInYp?=
 =?iso-8859-1?Q?74RupE5mLcjaAFiPvzmqzbWwlUUpwiY/oR0o5EKiqwnelJbMgCLElwDbZP?=
 =?iso-8859-1?Q?2Q2WWeXGmhY5khcQPj9sq4+4Mcb8Kpof8zj9Y0AhItzKYT63YhFpuv+vFX?=
 =?iso-8859-1?Q?hIoTVoWIWuCGD1lnzY6jE7ZeiZby2ct6eXXD3Wrt8UdJyDi3i7yBeMeqk0?=
 =?iso-8859-1?Q?Jzhnds075me/ExBeCcHnQzMeJVked2b94rrfJC/JKPoqsS88vmljbHJPp3?=
 =?iso-8859-1?Q?1QRwju4e2AIB//qhk/D0Yik+hcOQZoLNYNLweXOpeGk3Y9Jc02JxtiH/RO?=
 =?iso-8859-1?Q?xj1KISpwIZbnYgVpyzezKaejvli4616NcxYwRgmvjx94QTWKrHJYTwg/cx?=
 =?iso-8859-1?Q?Gg0dsH2eZSXBVumm0VEtkBPwbgat5e5gcxSrj5SuBPv3gAzmj3eOFVQoLB?=
 =?iso-8859-1?Q?FPXe/v2hftCyS7OD+JuzOqtI2G5xI9rldKB3shb8vUOMeMigLX+Xt+nVVW?=
 =?iso-8859-1?Q?4mwa1vf6vE1WsCv+Je3Dzg9v8CPsDzp5JDrQor0ZKbKigHuzXOzrg268SO?=
 =?iso-8859-1?Q?ZB5S0pW4MOQCj4Z34yWFxnUhfNgiGzw8B2ozqXQYW1B5rDDgE5jk5NkX3J?=
 =?iso-8859-1?Q?09NLPYAtboa7J7dX4mrTRHDZemYClzXvSeLesgsB24CayLKkxosza0tjKS?=
 =?iso-8859-1?Q?OKtAtugo2/A2AQtx4FbKXyaAHrb/bQo6B7Ir1GZJcXcDZOuy4Xh3DdP0Wp?=
 =?iso-8859-1?Q?/TqDqzDjqTtKrd9PM96G2okKua5H3kwCUUNIdA8DUifLiUhngHNcL1ByRX?=
 =?iso-8859-1?Q?5qp5w9jGdcw7/Drq0zW9VW2P/1Di01E/k/xPXsx0WhtX7llgN+1Q2k4k9k?=
 =?iso-8859-1?Q?KQxi7MKdZHbsTlWLXHuetc35EXHBSdHxQzk78hPgZtD6exmB0tgveVRTca?=
 =?iso-8859-1?Q?07JG6yQDsd8BykHZnMgDOPwio2cyG91UfsHbtYMNj2595jG98ubGpc2w7H?=
 =?iso-8859-1?Q?+SbsA02GI1V2461HdLeaT/gXcMzU7NYbrCx/tbKRnogqxZI7LS32Z7r9cb?=
 =?iso-8859-1?Q?yOGj1/Jy1iiHwCDdFsx1BUmbvTwYFICEjg/1ZwXriNucZGp4AXSjdOnIiX?=
 =?iso-8859-1?Q?jHJy++I6x7q11h/AIwqbvt4KWUTRl3T+jMa0JfxLmuBpA2DkZvI+nOAkyq?=
 =?iso-8859-1?Q?b0C0KQipzznb+ghVExzg8BAttgfAoLUW/K7zFegR2G1uDd8RQWGt1nmh7C?=
 =?iso-8859-1?Q?0ieo0GYdbxnOgOUF?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 02:14:02.5441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a5b273-c7a0-4542-ca78-08dc640435e3
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR08MB6181


=20
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > Srinivasulu Opensrc <sthanneeru.opensrc@micron.com> wrote:
> >
>=20
> > > >-----Original Message-----
> > > >From: Dan Williams <dan.j.williams@intel.com>
> > > >Sent: Wednesday, March 27, 2024 5:07 AM
> > > >To: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>; linux-
> > > >cxl@vger.kernel.org
> > > >Cc: Jonathan.Cameron@huawei.com; dan.j.williams@intel.com;
> > > >john@jagalactic.com; Eishan Mirakhur <emirakhur@micron.com>; Ajay
> > > >Joshi <ajayjoshi@micron.com>; Ravis OpenSrc
> > > ><Ravis.OpenSrc@micron.com>; Srinivasulu Thanneeru
> > > ><sthanneeru@micron.com>
> > > >Subject: [EXT] RE: [PATCH v3 0/2] Add log related mailbox commands
> > > >
> > > >CAUTION: EXTERNAL EMAIL. Do not click links or open attachments
> > > >unless you recognize the sender and were expecting this message.
> > > >
> > > >
> > > >sthanneeru.opensrc@ wrote:
> > > >> From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> > > >>
> > > >> Add support to expose following mailbox commands to userspace for
> > > >> clearing and populating the Vendor debug log in certain
> > > >> scenarios, allowing for the aggregation of results over time.
> > > >>
> > > >> 1. CXL r3.1 8.2.9.5.3 Get Log Capabilities.
> > > >> 2. CXL r3.1 8.2.9.5.4 Clear Log commands.
> > > >> 3. CXL r3.1 8.2.9.5.6 Get Supported Logs Sub-List.
> > > >>
> > > >> ---
> > > >> Changes in v3:
> > > >> - 'Component State Dump log' has several caveats for ioctl()
> > > >>    not being a suitable ABI as pointed in v2.(Dan Williams)
> > > >> - Remove Component State Dump from Clear log filter.
> > > >> - Implement a seperate patch(yet to do) to address issues as
> > > >> pointed in
> > v2.
> > > >
> > > >Circling back to this question... I had overlooked the fact that in
> > > >v3.1 the "Request Abort Background Operation" command was added
> > (8.2.9.1.5).
> > > >With that the kernel can safely support background commands with
> > > >indefinite residency. So as long as the device supports that
> > > >command and advertises that Log populate requests can be cancelled
> > > >then we can build a facility to cancel any user-submitted
> > > >background commands when a kernel internal need for the background
> command slot arises.
> > >
> > > I don't have the access to test "Request Abort Background Operation."
> > > Previously, we posted RFC for default time for background operations.
> > >
> > https://nam10.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> >
> %2F&data=3D05%7C02%7Cajayjoshi%40micron.com%7Cf8029f5d498b4f0e64fb
> 08dc58
> >
> 387ed0%7Cf38a5ecd28134862b11bac1d563c806f%7C0%7C0%7C6384822468
> 83954825
> >
> %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL
> CJBTiI6I
> >
> k1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DLv366Ff7nRD9zI6F0AQC
> e%2F9f%2F
> > QwNiL%2FCpND2cpfX6E0%3D&reserved=3D0
> > > .kernel.org%2Flinux-mm%2F20240207105349.301-1-
> > sthanneeru.opensrc%40mic
> > >
> > ron.com%2F&data=3D05%7C02%7Cajayjoshi%40micron.com%7Cabe61f69d40
> > 2460e2f2
> > >
> > b08dc55964860%7Cf38a5ecd28134862b11bac1d563c806f%7C0%7C0%7C
> > 63847935119
> > >
> > 7749869%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> > V2luMzIiLC
> > >
> > JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DQyxjJi2iLMTSTl
> > R46rv9k5
> > > U%2FDZVrKruaaunew8HMR9E%3D&reserved=3D0
> > >
> > >  Could you please guide me on how to proceed with this current patch
> > series?
> >
> > Whilst QEMU emulation doesn't yet support background command
> aborting,
> > it wouldn't be that hard to add and would provide a route to test this
> > functionality.
> > We've done similar in a few other cases where no one had any hardware
> yet.
> >
> > Of course that might not help you if you have silicon that doesn't
> > implement it but I agree with Dan that it is a lot less problematic to
> > allow for unbounded background ops if we can stop them for other urgent
> activity.
> >
>=20
> Thanks Jonathan and Dan. Agree with you on the background command
> handling.
> The series which Srini (sthanneeru.opensrc) has submitted has 2 patches:
> cxl/mbox: Add Get Log Capabilities and Get Supported Logs Sub-List
>     commands
> cxl/mbox: Add Clear Log mailbox command
> The commands in these patches(opcodes: 0402h, 0403h, 0405h) don't seem
> to have any background handling as of 3.1.
> Do you think these patches seem ok or do you feel something is missing
> here?
>
=20
Any input or review comment here would be highly appreciated.
 =20
>=20
> Ajay
>=20
> > Jonathan



    =
