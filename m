Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470F36FAD
	for <linux-cxl@vger.kernel.org>; Mon, 12 Feb 2024 05:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707717231; cv=fail; b=qKO9emKg0qCDwjKzVraak8i+0xxejp3dtDY0HLRcbKJpBjTuLWtH16ikAzkzImaTrhD21LfwnimcV2N6z3cIfIfH0CDN18lGMSAZG4Ba1tOLP4X072jOonx/vP/eSuJaOFhIAepm0qtn2Rvgd82QP/MrnoYEc3MnE0QeRERdm8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707717231; c=relaxed/simple;
	bh=0IplUzcAdZFD9rVzcece/y2IWcdlHQ0EBzIxHIsALJM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=APaWYA+cEIsEE6NTcAGZe/nClrqca36YJIcaUWkzAVUoE/JHTf5eoVGLHyreTVL8JP6tNrswr0ycXcDKiVl6Wte6hP6Hi7xaUfmUywhdlv3fALd6k8eZjws/wAdfw8/y05EGXqtUWqsvba9y71AS+yvXv+fypB3EVwS183hQbTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=n5kV7qm0; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="n5kV7qm0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkrWvFHlV9beq9hd6fmdAZiGHfjZCydW/zwMpaIj7kW9o7rD6KtJ/3NbB6ITlg70h4ToxWWUGgTJhYCMxVlBFYyS2Pc2Tig9UjXVptH8OohuN/34F87TxMr9v32KRSolxvLrdpUcDHWoN2dNAe9dWfwPc7XyLvMjNBrXGQFISan4l6v9GX2O4/9c9YREYfsDX9GhwrftneYkF2eH3/+4yCcmWj+5C8C+ZbZfuJdHpJQwT3jnI5+B7pvP1N6lGvRXGXTjweyxP+WNBctGYlwXSItfl1uEJNHM8Pmsow72KvLiRwdZm3wJuCLubnWO2AfoZIFSxcR6reCGfqk7gJLg1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XM/fft34VO0pfNVA4Rhg3uIsasC0OGoRnoSNvH0wEHU=;
 b=c4SkcJwuOyJbPRo9jxtRoJNaTdXCP6uNntc0SohoWxooH7TN8u3voJ5ColRWF+Kae9FP/5rAQKMz0a7mTNGdoB61M9qIHiROCSroK+c7qkDQ9DzgQ84X2qKwUif93Ax6WehhQCPfGFOLl+Yuo3oaJWYxee1l0XhPteted0zPyI4qhabMOevrjJ8lcQpxLWtlTyZiP7TXuH2TTIVsGWldSGqatSL/MFgy2VvQ4UFLorJoBQfQhMgltUVBrRthJexFCZdmtaM5bpL42w4y3NcKUl3KHsMQjUB89xYIMb5t3L10+/GgwBgVL3CZn/HggvadT3FIzTvx3IoRXlAes29Dqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XM/fft34VO0pfNVA4Rhg3uIsasC0OGoRnoSNvH0wEHU=;
 b=n5kV7qm0R1szqbuwHYlpVa96qBEev39nv6mrUxoqpWvKxorUDb+U7sqL3dEJSKd818YfYxK+McF5aqQvqzzteRsHZnW2C0n+NysT0lphkGIwBAxNRu/WA93kqZJ6YvJdOyw5v/9caJiv9mp6J//bOt4hJV+WLyWTAhQPwSNneuCvu/MR/YaghkhDS5ZPvcZ7yg3eYkM4B7TUpybL9JJ7QTIwzWBfZrBhjvUSFauerBVLwunDzFSrxwoPIIq2WVMa8HFNlEuyjLNTV7frHf7K1nw/5teHVJw/QJZGnqD6DBvTp+siZVwv9JG/ZtZX3k9Ied1vKe5qJpcnjAIEOC4Qyw==
Received: from BL1PR13CA0228.namprd13.prod.outlook.com (2603:10b6:208:2bf::23)
 by DM3PR08MB8949.namprd08.prod.outlook.com (2603:10b6:0:46::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Mon, 12 Feb
 2024 05:53:44 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::bb) by BL1PR13CA0228.outlook.office365.com
 (2603:10b6:208:2bf::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24 via Frontend
 Transport; Mon, 12 Feb 2024 05:53:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Mon, 12 Feb 2024 05:53:43 +0000
Received: from BOW36EX19A.micron.com (137.201.85.33) by BOW17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Sun, 11 Feb
 2024 22:53:40 -0700
Received: from BOW36EX19A.micron.com ([fe80::bbd8:8149:f98d:966f]) by
 BOW36EX19A.micron.com ([fe80::bbd8:8149:f98d:966f%8]) with mapi id
 15.02.1258.028; Sun, 11 Feb 2024 22:53:40 -0700
From: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "john@jagalactic.com" <john@jagalactic.com>,
	Eishan Mirakhur <emirakhur@micron.com>, Ajay Joshi <ajayjoshi@micron.com>,
	Ravis OpenSrc <Ravis.OpenSrc@micron.com>, Srinivasulu Thanneeru
	<sthanneeru@micron.com>, "shiju.jose@huawei.com" <shiju.jose@huawei.com>
Subject: RE: [EXT] Re: [PATCH] cxl/mbox: Add Get Log Capabilities, Clear Log
 and Get Supported Logs Sub-List commands
Thread-Topic: [EXT] Re: [PATCH] cxl/mbox: Add Get Log Capabilities, Clear Log
 and Get Supported Logs Sub-List commands
Thread-Index: AQHaWbGZfDcNDExI9UaAVBN+W7Th47EA3qCAgAVbFaA=
Date: Mon, 12 Feb 2024 05:53:40 +0000
Message-ID: <bc03f3ea88b844689981d89d9e2bc89e@micron.com>
References: <20240207103634.199-1-sthanneeru.opensrc@micron.com>
 <20240208125713.00004776@Huawei.com>
In-Reply-To: <20240208125713.00004776@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mt-whitelisted: matched
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|DM3PR08MB8949:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc8ae67-3d05-44ff-2c78-08dc2b8ef8e1
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uVasC6ET3USwMIHAGA7nmVmCSN11M+Gs6Hrbza50t6dBdBThGFKq8kpeenqh96BZuxQuJjwHzQ0bRV2FkoA0NPefNvis+zcmTbA7IgwLtK6/O+RbjWm0nYGFqzu/Hx+ZDdpsMvZf4yVNKm5Hsnc84IvDaT7A7w85bMaFFCeV1koVQwUJvqh4CDkeO2fXOScjtWcMIrVX9dUkhzdxVm2LTuZymRxW7IVUb4bFUxj5MSbWjBEnJxCKc5xspqel0SbfWuuVyrvj5tLfOndcKiataiWbEqy8Mfg7sI7LVdNAhocW2naxxFwVnGZJhrA6A/I/nfrW6yvmDnEXu27+aoR+mxYPijNXpyLSVJfNCRanPN+rdMk8lSxhPMTTvY11eEJ+Z5+isXG5umXajO5BCmDTzEAyR1jP9Y8PFR9o1MRBs4V5CG9BzuHgkNzCR3OQoNY9+ceJ83tlgHISrmRA8+8h4fprLJcydGipSgv8XCUgVm/3Na77MlGipuKlW6zXEDV+wdC2yV7m8IVouYwRKfhK4daq8/v/oSqloQNzBwM/LHOiCiajIYgZjGlD8+fe0NLQ5M1oQsNFuDccLEb+GZ2isoqJycv3V3Hee6Z29z9AJks=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39850400004)(376002)(136003)(346002)(230922051799003)(230273577357003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(7636003)(356005)(82740400003)(86362001)(5660300002)(2906002)(426003)(336012)(26005)(7696005)(53546011)(24736004)(108616005)(107886003)(41300700001)(2616005)(83380400001)(478600001)(36756003)(70206006)(4326008)(6862004)(54906003)(316002)(8676002)(70586007)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 05:53:43.9374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc8ae67-3d05-44ff-2c78-08dc2b8ef8e1
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR08MB8949

Hi Jonathan,

Thank you, for the inputs, please find comments inline.

Regards,
Srini
> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Thursday, February 8, 2024 6:27 PM
> To: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>
> Cc: linux-cxl@vger.kernel.org; linux-mm@kvack.org;
> dan.j.williams@intel.com; john@jagalactic.com; Eishan Mirakhur
> <emirakhur@micron.com>; Ajay Joshi <ajayjoshi@micron.com>; Ravis
> OpenSrc <Ravis.OpenSrc@micron.com>; Srinivasulu Thanneeru
> <sthanneeru@micron.com>; shiju.jose@huawei.com
> Subject: [EXT] Re: [PATCH] cxl/mbox: Add Get Log Capabilities, Clear Log =
and
> Get Supported Logs Sub-List commands
>=20
> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless
> you recognize the sender and were expecting this message.
>=20
>=20
> On Wed, 7 Feb 2024 16:06:34 +0530
> <sthanneeru.opensrc@micron.com> wrote:
>=20
> > From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> >
> > Adding UAPI support for
> > 1. CXL r3.1 8.2.9.5.3 Get Log Capabilities.
> > 2. CXL r3.1 8.2.9.5.4 Clear Log commands.
> > 3. CXL r3.1 8.2.9.5.6 Get Supported Logs Sub-List.
> >
> > Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
>=20
> Hi Srinivasulu,
>=20
> Whilst I can conjecture some valid reasons to expose these to
> userspace, can you add some examples to this patch description?
>=20

Sure, I will add description and send V2.

> We might want to filter the clear in particular to avoid a clash
> with the driver log handling. That is only allow it for vendor
> logs.
>=20
Allowing for both of the following.
* 5e1819d9-11a9-400c-811f-d60719403d86 - Vendor Debug Log
* b3fab4cf-01b6-4332-943e-5e9962f23567 - Component State Dump Log

> Perhaps split the patch into 2 parts. The less controversial
> GET_LOG_CAPS and GET_LOG_SUBLIST, followed by a patch for the
> destructive clear log.

Sure, I will split the patches as suggested.

>=20
> The memory scrub handling might well
> access the ECS log for example (I don't think the current proposal
> yet does this).
>=20
> Jonathan
>=20
>=20
> > ---
> >  drivers/cxl/core/mbox.c      | 3 +++
> >  drivers/cxl/cxlmem.h         | 3 +++
> >  include/uapi/linux/cxl_mem.h | 3 +++
> >  3 files changed, 9 insertions(+)
> >
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 27166a411705..64a44e286488 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -64,6 +64,9 @@ static struct cxl_mem_command
> cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] =3D {
> >       CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
> >       CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
> >       CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
> > +     CXL_CMD(GET_LOG_CAPS, 0x10, 0x4, 0),
> > +     CXL_CMD(CLEAR_LOG, 0x10, 0, 0),
> > +     CXL_CMD(GET_LOG_SUBLIST, 0x2, CXL_VARIABLE_PAYLOAD, 0),
> >  };
> >
> >  /*
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 5303d6942b88..4128c810051c 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -529,6 +529,9 @@ enum cxl_opcode {
> >       CXL_MBOX_OP_SET_TIMESTAMP       =3D 0x0301,
> >       CXL_MBOX_OP_GET_SUPPORTED_LOGS  =3D 0x0400,
> >       CXL_MBOX_OP_GET_LOG             =3D 0x0401,
> > +     CXL_MBOX_OP_GET_LOG_CAPS        =3D 0x0402,
> > +     CXL_MBOX_OP_CLEAR_LOG           =3D 0x0403,
> > +     CXL_MBOX_OP_GET_LOG_SUBLIST     =3D 0x0405,
>=20
> Name should include something to make it clear this is getting
> sublist of 'supported' logs.  Not the log.
>=20
> >       CXL_MBOX_OP_IDENTIFY            =3D 0x4000,
> >       CXL_MBOX_OP_GET_PARTITION_INFO  =3D 0x4100,
> >       CXL_MBOX_OP_SET_PARTITION_INFO  =3D 0x4101,
> > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.=
h
> > index 42066f4eb890..d2df9782a5ef 100644
> > --- a/include/uapi/linux/cxl_mem.h
> > +++ b/include/uapi/linux/cxl_mem.h
> > @@ -47,6 +47,9 @@
> >       ___DEPRECATED(SCAN_MEDIA, "Scan Media"),                         =
 \
> >       ___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),         =
 \
> >       ___C(GET_TIMESTAMP, "Get Timestamp"),                            =
 \
> > +     ___C(GET_LOG_CAPS, "Get Log Capabilities"),                      =
 \
> > +     ___C(CLEAR_LOG, "Clear Log"),                                    =
 \
> > +     ___C(GET_LOG_SUBLIST, "Get Log Sublist"),                        =
 \
>=20
> Likewise, mention it's list of supported logs.

Sure, will update "supported log" in all places in the next version V2.

--
Srini

>=20
> >       ___C(MAX, "invalid / last command")
> >
> >  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a

