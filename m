Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCF55D732
	for <linux-cxl@vger.kernel.org>; Wed, 14 Feb 2024 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926950; cv=fail; b=NiztZbKnRd65g6+d2zi45NwAxgicsAND9fPqglTsQSnXIKMptDit/Dn3Wk7Nisu9SYWgcALOTGbHANvnLyIDnXzQ+igokTIHWZhL5RHKc4HKUS6t9nxdRibMq3Bp22MhcQR0dANsWL/6/h9UzI4K6mBXtVXDUF/pQF55SODKCfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926950; c=relaxed/simple;
	bh=NFmPG+euTblDrpa7f2MX+hkGo81rnvakCUgeNjgodkM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o29bLaAWL1uCcZObdEsMbbWH5ULguuI/B+HYGoYrzBTjXrsd1iD1fnMohTx7NCHj8C3v2bXCuEAx5/TW8sKmumVUfYbbk6JaH37oBPu9NAUnVwIH6ETGcj5X8c63Xj8dakxauAvXpdLqPiu6SphEmtdLAawx9c2AGAN+3Uft2Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=C4jBTkbj; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="C4jBTkbj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThDZIIGL6CTGqA69WPwD1Yk9H9/DT27SCCAaFP8QTvdBvgdT0SDc/qtnh+SJC+o1J5tJ2R+/4wp1tZaJZgGK/2FhV14/At6imKhjeCtz9rwUOBhPgQ2mTU02/wrHSsbZvgvZ6GxtkTZJnofbQk+Wv4WSHX+0M1JPUhMhflROsCStn2D2uvZIBtAYAbnXDSGYLhl2grCRpy2QSFhEHerYZ/l+wk/wPL8+GWHJI2oj8JV0C7oRRbazaj4xXt9Mfa7069wTxWtMseE+fkX1Gf3C3uUmh5HD0jh14dWjc2qadSVHG6zdGpwYB6xr0PdxN80/zEc7aT5v+1o9V1UdTrV1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijUKxVOp5ql4tuIc+hvYN/CrHAW844y5t9PYG5EzC7k=;
 b=VdbZLbLMY16R8Ff5heOtFAxI0Fov23vNRM669xbJYVC4Uzw0OHKIq9Ei6LjwNaqp+RTthtu4TkrJ/g3oUtBy1I0xL8oT3Fe0IlAYA+mtSfvzZWWXs+db8/Cwv/XAI1p4tuKxBYH2X1RoCVg/3hMUA0i+bgs7i7hytXFYVIPyqvsKetiuH7BDYqRJf9cQ+Kkjat2rA6CW0RY8TEZqbj+DKuz3tS1zCjBjiMSQ+FsvKqTZTNIQKcBtMmOWpoFW7zNPuXSfUx4QuqQVHtIiMUafTn8vyjk5BMNztopuo71j4HFHCWVjGLhzwoUjATcbP0164VeB+TG3RDrHuQluUrkZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijUKxVOp5ql4tuIc+hvYN/CrHAW844y5t9PYG5EzC7k=;
 b=C4jBTkbjO1IsHfdSzoQfWEuUBmLrBxbloahFQSr0fUw+BUzUZsRjiBVLGKp2PfZpEB22IHT62tKahnUYcWuR8IUM82e/uviyVgVKHngSgBDOr1TfgkJqpF86prs93pEgrK3PbqHJf8O4sUwi9IEkGgi6ApjTQ9VJJ99PEESWQ5U1iuPcSLkhqLkZ1w70heqA9q9TpRMdMDgWLsCBVALhjGhOmpDygqJHAhR2jJHEBuJ1blq07S/0c69J//J3EW4WM/FLHbgQsRHa7vPIwH1A7ie/qxW1hMzdFKQN4u4t3MFh0LOQBW26QD7leymeU/sXrZsTRfX/PqSAIS/IJQQCxQ==
Received: from BL1PR13CA0338.namprd13.prod.outlook.com (2603:10b6:208:2c6::13)
 by CH3PR08MB8821.namprd08.prod.outlook.com (2603:10b6:610:1a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 16:09:04 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::a4) by BL1PR13CA0338.outlook.office365.com
 (2603:10b6:208:2c6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25 via Frontend
 Transport; Wed, 14 Feb 2024 16:09:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 16:09:03 +0000
Received: from BOW36EX19A.micron.com (137.201.85.33) by BOW17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 14 Feb
 2024 09:09:01 -0700
Received: from BOW36EX19A.micron.com ([fe80::bbd8:8149:f98d:966f]) by
 BOW36EX19A.micron.com ([fe80::bbd8:8149:f98d:966f%8]) with mapi id
 15.02.1258.028; Wed, 14 Feb 2024 09:09:01 -0700
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
Thread-Index: AQHaWbGZfDcNDExI9UaAVBN+W7Th47EA3qCAgAkrVGA=
Date: Wed, 14 Feb 2024 16:09:01 +0000
Message-ID: <834c6fec2ed74f9da7643ee61843373d@micron.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|CH3PR08MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 30489830-b8c5-4878-dabf-08dc2d7743bb
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XnjcW627Kubt6nYiRL+qeEDaT27sp8Llei7Gp3BgaYm3WnrRzpjOllqi+zcd5L+YFPn/eLBVbJEiDxoiMADinnGlVe56pw2OHqXvhAmfscOMkHB7vqf8ZSGzIrBdvrsm6S4wZPyt+iHItb46EIPQJq5easa8EcrtJe1So1n/zFtwmrX/eqJCH+z1rjx03yY0yNnOCIXF7ZHqBuX6ydc7OGGlvjR0od8GGFAM9bNeXAmnwaGxo2gY9NMwIeQ1PwYvisuUVAtX1B7YewNHPI6cyumafFxsQNhjK8eELKCpCkBL6LBweEn1s9SbavifD5oxIFtVh/3sj+MGDi+XyHo1ADmNCeuq6FUCvjtHTvef0ZtSk5Q6Z1uNgNNe6aENah2SwFhd67WKhxAOvT6+L9cn6oYA0b92u7cjNucfSrbC/q6myWWeEuGA/1RoDoC6fdz6SkXj+LwetNDF1o/Tc0Kjwzwi+NSKj3NtoQFEAgrK60WpTJNuE6dZfxhKliJ3QHW+9fVLOf9UXuZQS0R5aIU1T7O6k50gSZ0J336jMmjDRWR+pMfczBIQxwJri0n8plY2xyo46QVebz4wwG2Z9TRjk+GZkifYi6TS5elWNcmBIOw=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(230273577357003)(1800799012)(64100799003)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(36756003)(86362001)(7636003)(356005)(70206006)(70586007)(5660300002)(4326008)(2906002)(6862004)(8676002)(8936002)(82740400003)(83380400001)(478600001)(108616005)(53546011)(24736004)(7696005)(316002)(54906003)(26005)(107886003)(41300700001)(2616005)(336012)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 16:09:03.9104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30489830-b8c5-4878-dabf-08dc2d7743bb
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR08MB8821



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
> We might want to filter the clear in particular to avoid a clash
> with the driver log handling. That is only allow it for vendor
> logs.

Are you suggesting that I should restrict the "Vendor Debug Log" functional=
ity to
only apply to Vendor logs.? Why not include Component State Dumps logs that=
=20
support the clear log feature?

I might be overlooking something; please enlighten me.

For example, following both supports Clear log in our setups.
* 5e1819d9-11a9-400c-811f-d60719403d86 - Vendor Debug Log
* b3fab4cf-01b6-4332-943e-5e9962f23567 - Component State Dump Log

>=20
> Perhaps split the patch into 2 parts. The less controversial
> GET_LOG_CAPS and GET_LOG_SUBLIST, followed by a patch for the
> destructive clear log.
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
>=20
> >       ___C(MAX, "invalid / last command")
> >
> >  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a

