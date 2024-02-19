Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A23644C93
	for <linux-cxl@vger.kernel.org>; Mon, 19 Feb 2024 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363954; cv=fail; b=m/n0+3kyPybR/K98JAe60YZOwiI1LfSdAXk5jr+9Ys6gTwX/HQedoyiPxc3vBArs3FE5XJ9fFCIIuoC1Oto3NaN6BrE0mJU5vcM0Lc/R57gFqI9ieu1ofLNKwqUfYypihk38WcXgsCawSS3+AFt2qPIpw9oNLwPtILp1hqpWLEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363954; c=relaxed/simple;
	bh=ftHRBoL+EvZkW9telUYd7YaSEJWZ3h0VVsDhhpTKsJg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rQKd/EpcxMqisUhvyusUGgndOjQIIemstiZj7+940JNry/m8ORV/SsKZCmBEh/BkFPbPcQYC+F2bva9rVhlpkArDtP/bh/0UEjtGwZ3Pcn1VmNqWt2ojZzt4wGdB0jGhH4570GFvDhjIIPsytk1yoKSV5MOx32yuBRHIYla+lSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=agtosYW1; arc=fail smtp.client-ip=40.107.102.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="agtosYW1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRcmnjyZOA0Tbc1Qu/HbAAtet51yoMeKkMiPzEOIJBscGv1MxsBsP+TnvdGpj3DZUFGPPYNMqzCnfDtyCzEk8NENGwjD5RWimJKAgj3mQbN5rLUn9mA2BH8r6jWMRinQghJKJ3vCLgeje5fGXl7MINDXeZKWvuzVhtp2OlWK6ZIe/El7eBc9dOPGq/XmGg/OCaUOO6QjdJ8xCuysvdz5IgbqkoeRqoJoAzc3u7NFVNgLdNPgaygPdAZbH3agaAczQXDUVdtckvRQ1uFk7kDeonRDX0S5gGpDELXY+eSOFZr3FiGJ4ykgfuzUw23C3ENjw+vVsTuQmMJ8k0ijH5380A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0r+kosTE6rvhL+JhbWvyo8e1f2DByooqFRLotgFEr0=;
 b=JruB9Z/gM9jaNlnq/F8cTy7Vqei+CIpdT8fClc+ZCrLQA5ssjIinkzebiChKPzoPvqkGkpBUzF5+VY35TD8CSVHtYe0OsgcWrVFOcSnI7YUdBhGXe5lFFi34nvhKdoru2bEUMtXrvuAC0Ayko4ssfZyswiPwkkOQvLmbSV7dAYqUCc8FFVXAkYDi78kLj1LC7XIO80j30tjgHUGnCEDq82DZgf/Q93O4Eiw8dISxUHDO325LMr0OORfJ/6/gp8iXr/KJx2ccVD2pnMug9UXp101o7Wq9DuPUYOxdulT0W1ZJWYhhsprHinwRLFA9p8GOC+HJ7bY5sVCBnPDm0wZYSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0r+kosTE6rvhL+JhbWvyo8e1f2DByooqFRLotgFEr0=;
 b=agtosYW1hu8dp8gtDzilHlEdkKhjy68kNMEfrkkW/PGKbPK1+JvKWnKpiM/1MHdhhjAjeDlwuXpgxOM7q+iw/pHrVmYiC+lHbt6CkoNwPfZ4+Fyl9tApnER8CeqHCNmowo+KpjOYXSpvOSJJKoNSnA/jDZ5L/BpFz0d2mQ6uTPE/qIqg8SbxmeHEGdnS4TM3bmmLco3jcPo+j2hKy6Ik2FpxNDlnDH/a79eDUgCkA72gxtRbT1OLvIxOz1FcxDT6uUeqk+A+AjxzWrHz4Uz/JUR7qz+Ydol3RHMf0EGYOg2Zx1J3/nU7fuBkq9GyYjkWTiIucpPHst/22MD8XuSHeQ==
Received: from CH0PR03CA0301.namprd03.prod.outlook.com (2603:10b6:610:118::11)
 by SA3PR08MB8849.namprd08.prod.outlook.com (2603:10b6:806:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 17:32:27 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::78) by CH0PR03CA0301.outlook.office365.com
 (2603:10b6:610:118::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38 via Frontend
 Transport; Mon, 19 Feb 2024 17:32:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 17:32:27 +0000
Received: from BOW36EX19A.micron.com (137.201.85.33) by BOW36EX19A.micron.com
 (137.201.85.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Mon, 19 Feb
 2024 10:32:25 -0700
Received: from BOW36EX19A.micron.com ([fe80::bbd8:8149:f98d:966f]) by
 BOW36EX19A.micron.com ([fe80::bbd8:8149:f98d:966f%8]) with mapi id
 15.02.1258.028; Mon, 19 Feb 2024 10:32:25 -0700
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
Thread-Index: AQHaWbGZfDcNDExI9UaAVBN+W7Th47EA3qCAgAkrVGCAAcyFgIAGJnOw
Date: Mon, 19 Feb 2024 17:32:25 +0000
Message-ID: <9a9e96a742e8417bb84945563d80163f@micron.com>
References: <20240207103634.199-1-sthanneeru.opensrc@micron.com>
	<20240208125713.00004776@Huawei.com>
	<834c6fec2ed74f9da7643ee61843373d@micron.com>
 <20240215122653.00005ce2@Huawei.com>
In-Reply-To: <20240215122653.00005ce2@Huawei.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|SA3PR08MB8849:EE_
X-MS-Office365-Filtering-Correlation-Id: eb524be0-8a7e-40da-ac35-08dc3170bdd9
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J73bFJAIasalJwy8WDtIRCVN9I3vg817CRE0OvDFTJ5f+GehbXzUbbViMdSV0wLF7zIGY3kKXdKUi7opPvD/k2Wt4HgtIB5H6dI7U8wP96Ff+ZcUrZWjY+dxZL/qTv903Ajdc62IL03IZhPKutTWhLA0YD8zAMgQZEEMpWjhR8wzMfqvXUbtGfDoO26apJ5BNR+CTRkKfZy2BayuECKRYMKqIkUGfmxBeWQ8t5DUPBHKkZa9ahU7DrRg86Y+nRKvvVc4QHIAl1gHynEcMVa7NUIs2KijZV9BAaApuCouGQnLEt3RZeC8dpvDpzugnOK4DABBPSYlsFOsAvw0OdnfmCIdqxSnXc85iFAw9joumpQJUgf/QzMoOo9OS1gdLLgL09jf9n5u32qbEnzorHOt0+AcIThtrgIPFDqe+AmQIA9ZkICSd4SP/xwGlN0ZVKG2v2JTl6dDjJK3Uf0Ptw5tSB6l0F62wQcy0K+zYhoxIYjyV/jVMTQ24DqDIXQHLILuuDMGG9sld0vmNx7DD0qBq+LtuNhJ81TNgjb7qPIHkglub97Vg+un73mczrBivdgsInbpZSNNWn+oUdj5MpR3HJP5z/qu1f1OyBOoz5rbtlOh++YVpg5p7TVjafzmKPFS5a541fhe0bMcdxCMdsLX8+fvGauYi1T/he2eznia3+4=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(230273577357003)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 17:32:27.0087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb524be0-8a7e-40da-ac35-08dc3170bdd9
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR08MB8849



> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Thursday, February 15, 2024 5:57 PM
> To: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>
> Cc: linux-cxl@vger.kernel.org; linux-mm@kvack.org;
> dan.j.williams@intel.com; john@jagalactic.com; Eishan Mirakhur
> <emirakhur@micron.com>; Ajay Joshi <ajayjoshi@micron.com>; Ravis
> OpenSrc <Ravis.OpenSrc@micron.com>; Srinivasulu Thanneeru
> <sthanneeru@micron.com>; shiju.jose@huawei.com
> Subject: Re: [EXT] Re: [PATCH] cxl/mbox: Add Get Log Capabilities, Clear =
Log
> and Get Supported Logs Sub-List commands
>=20
> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless
> you recognize the sender and were expecting this message.
>=20
>=20
> On Wed, 14 Feb 2024 16:09:01 +0000
> Srinivasulu Opensrc <sthanneeru.opensrc@micron.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > > Sent: Thursday, February 8, 2024 6:27 PM
> > > To: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>
> > > Cc: linux-cxl@vger.kernel.org; linux-mm@kvack.org;
> > > dan.j.williams@intel.com; john@jagalactic.com; Eishan Mirakhur
> > > <emirakhur@micron.com>; Ajay Joshi <ajayjoshi@micron.com>; Ravis
> > > OpenSrc <Ravis.OpenSrc@micron.com>; Srinivasulu Thanneeru
> > > <sthanneeru@micron.com>; shiju.jose@huawei.com
> > > Subject: [EXT] Re: [PATCH] cxl/mbox: Add Get Log Capabilities, Clear =
Log
> and
> > > Get Supported Logs Sub-List commands
> > >
> > > CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unles=
s
> > > you recognize the sender and were expecting this message.
> > >
> > >
> > > On Wed, 7 Feb 2024 16:06:34 +0530
> > > <sthanneeru.opensrc@micron.com> wrote:
> > >
> > > > From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> > > >
> > > > Adding UAPI support for
> > > > 1. CXL r3.1 8.2.9.5.3 Get Log Capabilities.
> > > > 2. CXL r3.1 8.2.9.5.4 Clear Log commands.
> > > > 3. CXL r3.1 8.2.9.5.6 Get Supported Logs Sub-List.
> > > >
> > > > Signed-off-by: Srinivasulu Thanneeru
> <sthanneeru.opensrc@micron.com>
> > >
> > > Hi Srinivasulu,
> > >
> > > Whilst I can conjecture some valid reasons to expose these to
> > > userspace, can you add some examples to this patch description?
> > >
> > > We might want to filter the clear in particular to avoid a clash
> > > with the driver log handling. That is only allow it for vendor
> > > logs.
> >
> > Are you suggesting that I should restrict the "Vendor Debug Log"
> functionality to
> > only apply to Vendor logs.? Why not include Component State Dumps logs
> that
> > support the clear log feature?
> >
> > I might be overlooking something; please enlighten me.
>=20
> I had an old copy of the spec open. Indeed component state dumps
> should be safe to expose as well.

Thank you, Jonathan.
I'm considering adding the following snippet to the V2 patch for "clear log=
" filtering.=20
Any initial feedback would be appreciated.

--------------
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
enum {
        CEL_UUID,
        VENDOR_DEBUG_UUID,
+       COMPONENT_STATE_DUMP_UUID,
};

/* See CXL 2.0 Table 170. Get Log Input Payload */
static const uuid_t log_uuid[] =3D {
        [CEL_UUID] =3D DEFINE_CXL_CEL_UUID,
        [VENDOR_DEBUG_UUID] =3D DEFINE_CXL_VENDOR_DEBUG_UUID,
+       [COMPONENT_STATE_DUMP_UUID] =3D DEFINE_CXL_COMPONENT_STATE_DUMP_UUI=
D,
 };

 /*
@@ -333,6 +346,12 @@ static bool cxl_payload_from_user_allowed(u16 opcode, =
void *payload_in)
                        return false;
                break;
        }
+
+       case CXL_MBOX_OP_CLEAR_LOG: {
+               const uuid_t *uuid =3D (uuid_t *)payload_in;
+               return (uuid_equal(uuid, &log_uuid[VENDOR_DEBUG_UUID])) ||
+                      (uuid_equal(uuid, &log_uuid[COMPONENT_STATE_DUMP_UUI=
D]))
+               }
}

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -565,6 +565,9 @@ enum cxl_opcode {
 #define DEFINE_CXL_VENDOR_DEBUG_UUID                                      =
     \
        UUID_INIT(0xe1819d9, 0x11a9, 0x400c, 0x81, 0x1f, 0xd6, 0x07, 0x19, =
    \
                  0x40, 0x3d, 0x86)
+#define DEFINE_CXL_COMPONENT_STATE_DUMP_UUID
+       UUID_INIT(0x3fab4cf, 0x01b6, 0x4332, 0x94, 0x3e, 0x5e, 0x99, 0x62, =
      \
+                 0xf2, 0x35, 0x67)
--------------
> >
> > For example, following both supports Clear log in our setups.
> > * 5e1819d9-11a9-400c-811f-d60719403d86 - Vendor Debug Log
> > * b3fab4cf-01b6-4332-943e-5e9962f23567 - Component State Dump Log
> >
> > >
> > > Perhaps split the patch into 2 parts. The less controversial
> > > GET_LOG_CAPS and GET_LOG_SUBLIST, followed by a patch for the
> > > destructive clear log.
> > >
> > > The memory scrub handling might well
> > > access the ECS log for example (I don't think the current proposal
> > > yet does this).
> > >
> > > Jonathan
> > >
> > >
> > > > ---
> > > >  drivers/cxl/core/mbox.c      | 3 +++
> > > >  drivers/cxl/cxlmem.h         | 3 +++
> > > >  include/uapi/linux/cxl_mem.h | 3 +++
> > > >  3 files changed, 9 insertions(+)
> > > >
> > > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > > > index 27166a411705..64a44e286488 100644
> > > > --- a/drivers/cxl/core/mbox.c
> > > > +++ b/drivers/cxl/core/mbox.c
> > > > @@ -64,6 +64,9 @@ static struct cxl_mem_command
> > > cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] =3D {
> > > >       CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
> > > >       CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
> > > >       CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
> > > > +     CXL_CMD(GET_LOG_CAPS, 0x10, 0x4, 0),
> > > > +     CXL_CMD(CLEAR_LOG, 0x10, 0, 0),
> > > > +     CXL_CMD(GET_LOG_SUBLIST, 0x2, CXL_VARIABLE_PAYLOAD, 0),
> > > >  };
> > > >
> > > >  /*
> > > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > > index 5303d6942b88..4128c810051c 100644
> > > > --- a/drivers/cxl/cxlmem.h
> > > > +++ b/drivers/cxl/cxlmem.h
> > > > @@ -529,6 +529,9 @@ enum cxl_opcode {
> > > >       CXL_MBOX_OP_SET_TIMESTAMP       =3D 0x0301,
> > > >       CXL_MBOX_OP_GET_SUPPORTED_LOGS  =3D 0x0400,
> > > >       CXL_MBOX_OP_GET_LOG             =3D 0x0401,
> > > > +     CXL_MBOX_OP_GET_LOG_CAPS        =3D 0x0402,
> > > > +     CXL_MBOX_OP_CLEAR_LOG           =3D 0x0403,
> > > > +     CXL_MBOX_OP_GET_LOG_SUBLIST     =3D 0x0405,
> > >
> > > Name should include something to make it clear this is getting
> > > sublist of 'supported' logs.  Not the log.
> > >
> > > >       CXL_MBOX_OP_IDENTIFY            =3D 0x4000,
> > > >       CXL_MBOX_OP_GET_PARTITION_INFO  =3D 0x4100,
> > > >       CXL_MBOX_OP_SET_PARTITION_INFO  =3D 0x4101,
> > > > diff --git a/include/uapi/linux/cxl_mem.h
> b/include/uapi/linux/cxl_mem.h
> > > > index 42066f4eb890..d2df9782a5ef 100644
> > > > --- a/include/uapi/linux/cxl_mem.h
> > > > +++ b/include/uapi/linux/cxl_mem.h
> > > > @@ -47,6 +47,9 @@
> > > >       ___DEPRECATED(SCAN_MEDIA, "Scan Media"),                     =
     \
> > > >       ___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),
> \
> > > >       ___C(GET_TIMESTAMP, "Get Timestamp"),                        =
     \
> > > > +     ___C(GET_LOG_CAPS, "Get Log Capabilities"),                  =
     \
> > > > +     ___C(CLEAR_LOG, "Clear Log"),                                =
     \
> > > > +     ___C(GET_LOG_SUBLIST, "Get Log Sublist"),                    =
     \
> > >
> > > Likewise, mention it's list of supported logs.
> > >
> > > >       ___C(MAX, "invalid / last command")
> > > >
> > > >  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> >

