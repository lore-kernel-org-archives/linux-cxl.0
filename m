Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FC4134AF
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 06:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707979032; cv=fail; b=lMwaNoNGaTRphTOt0O9F9Sohz+FWtApRn23b508krydZm9FlZV1M8lbcNNRmc2NVs7nxBSm5dM2+VXkRfSQOei14Z1tAFV3c327Nq+Asb5oUyku+6ZOZPLaNJY6n/vO17HEqmII36Qpf9UMrfIPYh2KFtCElKOqSmF1LbSDXg0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707979032; c=relaxed/simple;
	bh=cZgT03Bi/DzSu89peqs6APQE4Ax1pblWxc+AgPUpBkU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BtqyGy5EOMoH7aHG5dnCHvu2smlwf3dKErL+MvoOwU2lUWDQg4Kd/itnqYG5zPXA8epZjVJm1mYmN68Cr5rCqFWHkoOzZOkEp/OTlKv4kIzIyTV+fouu9upRgJiDINnmdJ9XGuU6Pj6egDysg6DKjymJbI0Yg99n7FQ3Z3auQJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=RGAYco2c; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="RGAYco2c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6R8wJod4zUgil0498Z2iVU84ZaOQiax2M0qp2C42JcGRovl8UsjGhBmmTo33Au4heJWQ0Xg44Y6yjqQ6/9cf8okHh2FyS+kz308aG+FbmcpJWi45F/x1RfTW4bNHdJactGyrp8cI9KkT97kDAQQzijeBVROt9Gz0jGLCmgYkgxOHH+lEcVFQKWr7iMqTLFICkpDQpcwNOxq+D1Wzifv7iKnLuCy6zKzsEUV96GMrPgwWg1tpW5I6ETS/8sr03ZTBouWydh2ySC7LJRhhIKgyxhXgEwSJaBYnQUFnJPurUkfpuBS+BtBVnvrrwvrk0j8jqS1OskGm/9LmGHZMitSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHtFPD/Vl7gE7bwuwJNUXRUc8FcaMwP7NX19LxzEEfI=;
 b=Od4AUuxC7kkqzxYENDS1vpQYUfMz5KQxv8iOWG2atppe3Wf8o5hiHZCVbxeViQNoGnNacaWSrWjf52ZYLN0x8t2cyXf3h1BJ2VZgtj+qRUNi8/AxEKFN8TsnbXKuSGSmGVZsQkhatLkDvqxUpY1tlo/QXgYgAeBbCSMYJ9bepv4f72jvzd/Lon2tCrKDeC4lP4dadVTxjyxx5gG0r5Ufsm/Bal+NQU7advftlok/VoQslQzF2BsgLyq5Z1O9OqoRxY4Es1NmoxacDGCFNI5sZPLOmxjhSZkfrcrORLtMOWaO65AvS7nTcziTNkj/qzvIyJr6/HI/q96FQFePklqqeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHtFPD/Vl7gE7bwuwJNUXRUc8FcaMwP7NX19LxzEEfI=;
 b=RGAYco2cZQbzLA8G25vqRWFBGGW7zgGh6PocBuH9ixLWhD2J2aw5L0GvOG9urSn3IZsXqHTV7os0lRE5EXFf+MYhONTeUjPE9GWU48nkSc8sGAbvgriWY+qRw16K7jnCfaICbxXXmCpUrh2egB2REGZrk9deQu9a9qMfLg4b60lY12W062Pf+YMplbqg98Q36/3CaE/DTZNWvt9DDuKP5iKpa/bxxxtFrM1Y64VyiAsIN36AlgeFt+uOG5gPmKqAIYPMxslJ7nFqZb1xL4NDb7O26EnGo5TTng947JAZAWIJcW9LPYuSEdb27Tq6h38nnZJS+xbEda2+VovOpR7Oxw==
Received: from MW4PR04CA0129.namprd04.prod.outlook.com (2603:10b6:303:84::14)
 by CYXPR08MB9531.namprd08.prod.outlook.com (2603:10b6:930:d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 06:37:05 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::28) by MW4PR04CA0129.outlook.office365.com
 (2603:10b6:303:84::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Thu, 15 Feb 2024 06:37:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 06:37:05 +0000
Received: from BOW36EX19A.micron.com (137.201.85.33) by BOW17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 14 Feb
 2024 23:37:00 -0700
Received: from BOW36EX19A.micron.com ([fe80::bbd8:8149:f98d:966f]) by
 BOW36EX19A.micron.com ([fe80::bbd8:8149:f98d:966f%8]) with mapi id
 15.02.1258.028; Wed, 14 Feb 2024 23:37:00 -0700
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
Thread-Index: AQHaWbGZfDcNDExI9UaAVBN+W7Th47EA3qCAgAkrVGCAAPRVgA==
Date: Thu, 15 Feb 2024 06:37:00 +0000
Message-ID: <41ea5267236c4bd391c53379e1ac08fe@micron.com>
References: <20240207103634.199-1-sthanneeru.opensrc@micron.com>
 <20240208125713.00004776@Huawei.com>
 <834c6fec2ed74f9da7643ee61843373d@micron.com>
In-Reply-To: <834c6fec2ed74f9da7643ee61843373d@micron.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|CYXPR08MB9531:EE_
X-MS-Office365-Filtering-Correlation-Id: 6edb261d-68e2-42c3-8b71-08dc2df0868f
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cuL61b+6puFkyOZ4ZbTCcyb7LhGy0YWXU1WJp8aqvoI0g/dKTwK9vDmBcKsPS+u0A2YCYO1EEiHRH2rCcIFEcvJ0mrphPFcFfqGa6KnbIobF+xeglwvzU+5su9g7Nqt+YHtOKzRo326fLcLFuoJrCEWzKdYLZIHb/wdNzDz5l4PX/8f5+UKg2K+UNZxhCABWxfeFqKvutQyV5mVqikmqykfokZPshmhhtkY9TWWyDVfcxLlRdZlyMP5LxUjWFaKEqnabscweRhyBWBLBK/Telmrt5U5zO3sE1HoMYpkEFRv+nx7OCUiZGOMvJKv3rasW/Msy+ZIvoPpxltyVxwoyhUsAes1Yrb6UnTXVS2CvPY1fxhveB0g9P8G5v3mx79RVTeyJNQBAwq37sZPdhOQ50b0n2WLRYbaFmMY195AQm1BQ6y1JFmToceRwULbtBk0GK7PD3yv9b2xnbdMiAFD7752hPzH0qa+QRgv7oJ+I2jHny+wCa+iHHAkJhheypmdnr2imh3pcIaE4oZ3YghjEZ5Uxh3TnhCO9rNyl33/FT9ym12DcDClrtn4aCJ9YZvPKEnJu/9H/aTVMns8tSixZzOzbCo3F1v6FEiwdtzYf1YjBoc8ZY6yLpgauZg6M118VSO14z6bv4ktVUQTBbtshKWRaTGIDTNC57GMQo3iXzqI=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230273577357003)(230922051799003)(82310400011)(64100799003)(36860700004)(451199024)(1800799012)(186009)(40470700004)(46966006)(41300700001)(2616005)(26005)(336012)(426003)(2906002)(8676002)(4326008)(6862004)(70206006)(70586007)(5660300002)(108616005)(478600001)(7696005)(316002)(54906003)(53546011)(24736004)(107886003)(8936002)(86362001)(356005)(7636003)(36756003)(83380400001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 06:37:05.1629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6edb261d-68e2-42c3-8b71-08dc2df0868f
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR08MB9531



> -----Original Message-----
> From: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>
> Sent: Wednesday, February 14, 2024 9:39 PM
> To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Cc: linux-cxl@vger.kernel.org; linux-mm@kvack.org;
> dan.j.williams@intel.com; john@jagalactic.com; Eishan Mirakhur
> <emirakhur@micron.com>; Ajay Joshi <ajayjoshi@micron.com>; Ravis
> OpenSrc <Ravis.OpenSrc@micron.com>; Srinivasulu Thanneeru
> <sthanneeru@micron.com>; shiju.jose@huawei.com
> Subject: RE: [EXT] Re: [PATCH] cxl/mbox: Add Get Log Capabilities, Clear =
Log
> and Get Supported Logs Sub-List commands
>=20
>=20
>=20
> > -----Original Message-----
> > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Sent: Thursday, February 8, 2024 6:27 PM
> > To: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>
> > Cc: linux-cxl@vger.kernel.org; linux-mm@kvack.org;
> > dan.j.williams@intel.com; john@jagalactic.com; Eishan Mirakhur
> > <emirakhur@micron.com>; Ajay Joshi <ajayjoshi@micron.com>; Ravis
> > OpenSrc <Ravis.OpenSrc@micron.com>; Srinivasulu Thanneeru
> > <sthanneeru@micron.com>; shiju.jose@huawei.com
> > Subject: [EXT] Re: [PATCH] cxl/mbox: Add Get Log Capabilities, Clear Lo=
g and
> > Get Supported Logs Sub-List commands
> >
> > CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless
> > you recognize the sender and were expecting this message.
> >
> >
> > On Wed, 7 Feb 2024 16:06:34 +0530
> > <sthanneeru.opensrc@micron.com> wrote:
> >
> > > From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> > >
> > > Adding UAPI support for
> > > 1. CXL r3.1 8.2.9.5.3 Get Log Capabilities.
> > > 2. CXL r3.1 8.2.9.5.4 Clear Log commands.
> > > 3. CXL r3.1 8.2.9.5.6 Get Supported Logs Sub-List.
> > >
> > > Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> >
> > Hi Srinivasulu,
> >
> > Whilst I can conjecture some valid reasons to expose these to
> > userspace, can you add some examples to this patch description?
> >
> > We might want to filter the clear in particular to avoid a clash
> > with the driver log handling. That is only allow it for vendor
> > logs.
>=20
> Are you suggesting that I should restrict the "Vendor Debug Log" function=
ality
> to
> only apply to Vendor logs.? Why not include Component State Dumps logs
> that
> support the clear log feature?

Sorry for the typo.

Are you suggesting that I should restrict the "Clear log command" functiona=
lity from user space
to only apply to "Vendor Debug Log".?=20
Why not include Component State Dumps logs that support the clear log featu=
re?

>=20
> I might be overlooking something; please enlighten me.
>=20
> For example, following both supports Clear log in our setups.
> * 5e1819d9-11a9-400c-811f-d60719403d86 - Vendor Debug Log
> * b3fab4cf-01b6-4332-943e-5e9962f23567 - Component State Dump Log
>=20
> >
> > Perhaps split the patch into 2 parts. The less controversial
> > GET_LOG_CAPS and GET_LOG_SUBLIST, followed by a patch for the
> > destructive clear log.
> >
> > The memory scrub handling might well
> > access the ECS log for example (I don't think the current proposal
> > yet does this).
> >
> > Jonathan
> >
> >
> > > ---
> > >  drivers/cxl/core/mbox.c      | 3 +++
> > >  drivers/cxl/cxlmem.h         | 3 +++
> > >  include/uapi/linux/cxl_mem.h | 3 +++
> > >  3 files changed, 9 insertions(+)
> > >
> > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > > index 27166a411705..64a44e286488 100644
> > > --- a/drivers/cxl/core/mbox.c
> > > +++ b/drivers/cxl/core/mbox.c
> > > @@ -64,6 +64,9 @@ static struct cxl_mem_command
> > cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] =3D {
> > >       CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
> > >       CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
> > >       CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
> > > +     CXL_CMD(GET_LOG_CAPS, 0x10, 0x4, 0),
> > > +     CXL_CMD(CLEAR_LOG, 0x10, 0, 0),
> > > +     CXL_CMD(GET_LOG_SUBLIST, 0x2, CXL_VARIABLE_PAYLOAD, 0),
> > >  };
> > >
> > >  /*
> > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > index 5303d6942b88..4128c810051c 100644
> > > --- a/drivers/cxl/cxlmem.h
> > > +++ b/drivers/cxl/cxlmem.h
> > > @@ -529,6 +529,9 @@ enum cxl_opcode {
> > >       CXL_MBOX_OP_SET_TIMESTAMP       =3D 0x0301,
> > >       CXL_MBOX_OP_GET_SUPPORTED_LOGS  =3D 0x0400,
> > >       CXL_MBOX_OP_GET_LOG             =3D 0x0401,
> > > +     CXL_MBOX_OP_GET_LOG_CAPS        =3D 0x0402,
> > > +     CXL_MBOX_OP_CLEAR_LOG           =3D 0x0403,
> > > +     CXL_MBOX_OP_GET_LOG_SUBLIST     =3D 0x0405,
> >
> > Name should include something to make it clear this is getting
> > sublist of 'supported' logs.  Not the log.
> >
> > >       CXL_MBOX_OP_IDENTIFY            =3D 0x4000,
> > >       CXL_MBOX_OP_GET_PARTITION_INFO  =3D 0x4100,
> > >       CXL_MBOX_OP_SET_PARTITION_INFO  =3D 0x4101,
> > > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_me=
m.h
> > > index 42066f4eb890..d2df9782a5ef 100644
> > > --- a/include/uapi/linux/cxl_mem.h
> > > +++ b/include/uapi/linux/cxl_mem.h
> > > @@ -47,6 +47,9 @@
> > >       ___DEPRECATED(SCAN_MEDIA, "Scan Media"),                       =
   \
> > >       ___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),       =
   \
> > >       ___C(GET_TIMESTAMP, "Get Timestamp"),                          =
   \
> > > +     ___C(GET_LOG_CAPS, "Get Log Capabilities"),                    =
   \
> > > +     ___C(CLEAR_LOG, "Clear Log"),                                  =
   \
> > > +     ___C(GET_LOG_SUBLIST, "Get Log Sublist"),                      =
   \
> >
> > Likewise, mention it's list of supported logs.
> >
> > >       ___C(MAX, "invalid / last command")
> > >
> > >  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
>=20

