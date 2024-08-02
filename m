Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392851E3CB5
	for <linux-cxl@vger.kernel.org>; Fri,  2 Aug 2024 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722603914; cv=fail; b=otyngYLVhTh9KcnLmUb4zgzR9nG/xszeNyMfJzsFAuCxCmbNifVqtaldd5+TWNvbFSQAAAxpD9aXCMa22UWcXzZXCrAh+gfFvKZVAxvlsuniSmq/O1mBDJYEwRIGIutuWt+nQEIEXTfGalU2mYcfcDJH0Eb+3OHsovuMRBnw930=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722603914; c=relaxed/simple;
	bh=0RVHkGSzFuP4PMSOJN1ud+JdggfQww+KagqnFbQ6MzI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PfTRm69MHiEzF6MZ1GVIUWupTx8gYL6fZHfXoE2R6bpQEYddpPYfQbYG7ram1HPtvGTCYr/trVDqy5xxB5hWCRPCCNAb1epK4LHVHIaqmack1OHOnGiUFUkof507i5Nha/23sFj8iU0jMPHCKE1rkA6nbGshI+Ry3zeO7MDd6QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=coOIV7L/; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="coOIV7L/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmnmUbvwUiz4voYFpyIryn6gcTSopi2ohlmvSacYvXgAzdf4sN9M/bmiOj1/OToG51Qu35QmNq58Kgb6uHVPsiLc0HIy6suY/VDMiH8X35mk/sFQSjZ5Q9bfZhvhv3s2Tlp3J4NGO5t2bwflOvmIs0pMtUPhqh87nVILvXfqXNsdgrXDibgQ7Gb8dGNkU9TNawEDEYCKnBdBh5Xb7+qgNzqgA+SekUeqJ7ZNepvyhPFSgnJUvkpX3K5sDd5jKyrehuhJYFsvHa86lUc4hhq/yew1jlk/D74yCNuZDES6WX0sBSn3oTQTLQeprQ67vm+ho4KA97XkpcOuu/PImrxMmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnJLsfMSu6kNwD2jB240gZW9QkePSVR/Q0z6rIQKPiM=;
 b=Ws593E1dTdO9GUm/l1qI5Dq9jkqnwH64dTUbBofRpNLdvHMRqmfv81sUFF/NZ/oTcCG4VErg8sy5BaF22FeTC8JVgJOpp94pIeCjCkvwf18OQx7QPbhHTzc0JDW3QY+a7S3GkaiBFc6oKYL+u+dkZkG3SvOfIR6jPA3KPCJRG0/AN+Dyvb+iPS1/WSru+TCXEdeDvf0Yeap62afK9T2HE0jAh3fdbRi2W0U7eyhOhaCtKq5MUf7xbgZihSiOtFeIysp7r87PQjr65G4OBcW9cnWYVHaFTPLGNCnaI3tRX8MjQZwXKjMUNOzApF2cUOWwx6lFMVSBtuVd++mcaAzW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnJLsfMSu6kNwD2jB240gZW9QkePSVR/Q0z6rIQKPiM=;
 b=coOIV7L/T0MN1dFIt4A/WTxa5x8WaZnahsVzISymtkmO7KS3T5OGGu8oEcrnw9ewq0bK4dok6j3TBHLbRfkMN+DNCcvmB3p4UmJ52AOsj7jb3g+XocLU0NvvXx9XmK39Qou/iHJ8lzlT/NuyOM+8CZuLjqhlrX040cW1jthaMTjSnXcb/PGaFRJ1JMWivYk/m9dkfSGNJV3VXNVoZbj1uIEAaiFFxohrQx5pCn7FRkF8myXiIvxj/ZOC451sfGxaDSYK/ubyEEsv2xcfGDvjn520WeZfr8538OfB2UqnTnfrIM3B6Mzt8TzehJW0rK0mLZ/mokxsylyM3VtK9Ij8hg==
Received: from BY5PR20CA0014.namprd20.prod.outlook.com (2603:10b6:a03:1f4::27)
 by CO1PR08MB7546.namprd08.prod.outlook.com (2603:10b6:303:161::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 13:05:02 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::76) by BY5PR20CA0014.outlook.office365.com
 (2603:10b6:a03:1f4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21 via Frontend
 Transport; Fri, 2 Aug 2024 13:05:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 13:05:01 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW36EX19B.micron.com
 (137.201.85.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 07:04:57 -0600
Received: from BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3]) by
 BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3%6]) with mapi id
 15.02.1544.004; Fri, 2 Aug 2024 07:04:57 -0600
From: ajay.opensrc <ajay.opensrc@micron.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"john@jagalactic.com" <john@jagalactic.com>, Eishan Mirakhur
	<emirakhur@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, "Srinivasulu
 Thanneeru" <sthanneeru@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
	Aravind Ramesh <arramesh@micron.com>, "Tushar M Mulgund ."
	<tmmulgund@micron.com>
Subject: Re: [EXT] Re: [PATCH] hw/cxl: Add support for abort of background
 operation
Thread-Topic: [EXT] Re: [PATCH] hw/cxl: Add support for abort of background
 operation
Thread-Index: AQHa4aD86ycczZCLvEOQMSi+AkrzQrIPLvaAgATGA3I=
Date: Fri, 2 Aug 2024 13:04:57 +0000
Message-ID: <027f6872f7ae42c4ba97ed1209e50253@micron.com>
References: <20240729102010.20996-1-ajay.opensrc@micron.com>,<jvbuxqaqjclc5cy5veltygpo4dg3naej456gvphndpdc3ttyoa@p64fmecqr67r>
In-Reply-To: <jvbuxqaqjclc5cy5veltygpo4dg3naej456gvphndpdc3ttyoa@p64fmecqr67r>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|CO1PR08MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 0708781a-f863-41b1-7243-08dcb2f3b84b
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?pxrdJZf5vtfRYV0oBlhaLoruZbdWRC9Avcy+EO0S9TbVMm8jV9zuM3TB5A?=
 =?iso-8859-1?Q?hVA9SzI05kjCcW3usEUlKMUePoRrQIO7nb11vPFIlkn/JVfBfkd568vTp2?=
 =?iso-8859-1?Q?RVVscz+FFcyFjl/GdIBoNZpcHL2Ni71a/JCFg5KRPagj+8g0dQGO+2+jUS?=
 =?iso-8859-1?Q?PS9YQQiE0VYJO/hKh7OhkQUAJJVCUTCCztTslEhtoGy4Oi25Wkn3WXK3Z3?=
 =?iso-8859-1?Q?OaDgZv81MPzaJPUaiZz5dAYl8j6QXigYMsohoR2p7cmY45Uma3Z/6HtdPa?=
 =?iso-8859-1?Q?xMNXmYCMnP+EYJoa/OkfqW/JVt8pjWo2WkZs/daa8VRSUrEpXYr7zxwMaf?=
 =?iso-8859-1?Q?dthf/k3rWAMsyEkXQxdqO69ByN3kkE2rf8JeMGyVRaaWLzqe0pHAP5kQV7?=
 =?iso-8859-1?Q?mxL4w2MTmBaHqt0KVKBm/Am2ZHZeALKQKKlj+31atWWRlvbd+4Sw6/MCum?=
 =?iso-8859-1?Q?U+o3Tifd4MRFPgqLCLGk1ObjSmBlfVrtRhB9zyuDNOnxSoQj21PGWHrOQv?=
 =?iso-8859-1?Q?giOHqFZMQZwqeVVx1k4/e4ggVMV8cbFTOqHldYApwDg3x+pWIsiLFo9BI3?=
 =?iso-8859-1?Q?28mTg7QjP9rTt4W1hcHyYj700lpei5nPPNgi99qGk/2/Rj4X2W+SmQygJh?=
 =?iso-8859-1?Q?PZBZt+Ze42jlHPu9TYdfVpfTe9tz1YNIlkFlrXHEosH0tLo8wQWa+B0cky?=
 =?iso-8859-1?Q?pqFHe+QLZBurvboeuy6IqvXCP3R91I68d33myPHEMH6VcFR5CCOhqR6eSs?=
 =?iso-8859-1?Q?T1KotaXefAm4gKlDL4y+HTSB73AurNhURe/V7gOEu5kk/xK6aFw4uhIZEX?=
 =?iso-8859-1?Q?aWhhsuzcu3Hr/pRqoaw26Lf3ioOlLb2bTHVGtfTQcwkgoipTEsYbMktyXP?=
 =?iso-8859-1?Q?zSACxgjVLU8i+KUYyVsc6lFpf2JabZDFWPod3gDcA+1d8XCwSOUtg0suZm?=
 =?iso-8859-1?Q?NQ+j028L5YwrfvaAJ2CjKmc9RoOLI9nLnteuYGk0MLexEaXaIAPwSrWegY?=
 =?iso-8859-1?Q?RGc9YtqGlBSy8TpkXtfrF50VyE4HzR7uzz4LliSiLlTwKMgkeFTv6w5CEG?=
 =?iso-8859-1?Q?PZKoDIsFAbe59gi3nPj2m6QoxF3HyrB+X3R5FumQLqufI5KOrrNmuvXoHJ?=
 =?iso-8859-1?Q?M0I/+OUsX6LHiZEcEl1C8t01lXZAGMPozblcGeidoEq/hzH9jV38UkKlnj?=
 =?iso-8859-1?Q?g/tH6fVE8CAbe1pnfPvjUSUlA+UqmLgGYEDxuFqnSVGCe7aOXko9O3fw5+?=
 =?iso-8859-1?Q?QgPyRpDkXNHqERtMWMjABwXutrw55Id3ohjc3fMJ2D5zoVFUmsICxPXM/F?=
 =?iso-8859-1?Q?w4DpSxM4EH5+Xk0ZzM/si111H+61/h4pcipjbw0+b+nbjpywQ2K4NeU8Ue?=
 =?iso-8859-1?Q?/bI2594NBfGS5nHxYy38EJNEr2ZtUICbC/jga9u0kJ6eaoSwPaN+SxxuNF?=
 =?iso-8859-1?Q?5XyTlwGLVBVUHAhJx8myQtKK9cFmocA/YMtMA8MS4zz8Z7lGSXUA7Wn9ta?=
 =?iso-8859-1?Q?JAR8WE2smHaqnJRfl6mFTB?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 13:05:01.7735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0708781a-f863-41b1-7243-08dcb2f3b84b
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR08MB7546


>From: Davidlohr Bueso <dave@stgolabs.net>
>>From: Ajay Joshi <ajay.opensrc@micron.com>
>>
>>This patch adds the support for aborting the background
>>operation if one is progress(r3.1 8.2.9.1.5)
>>
>>"Request Abort Background Operation" command is requested
>>by the host to cancel an ongoing background operation. When
>>the command is sent, the device will abort the ongoing
>>background operation.  When the operation is aborted,
>>background command status register will maintain a completion
>>percentage value of less then 100. The "Request Abort
>>Background Operation" command support has to be advertised in
>>the Command Effects Log to be honoured.
>
>So I had a patch for this which I had not sent out, and compared
>to this one I think the below is more robust, would you mind
>testing this out?

Didn't realize you were working on one already.
This looks good to me as well. I tested this and it seems to be
working as expected. Feel free to use:

Tested-by: Ajay Joshi <ajay.opensrc@micron.com>
Reviewed-by: Ajay Joshi <ajay.opensrc@micron.com>

>Thanks,
>Davidlohr
>
>--8<--------
>[PATCH] hw/cxl: Support aborting background commands
>
>As of 3.1 spec, background commands can be canceled with a new
>abort command. Implement the support, which is advertised in
>the CEL. No ad-hoc context undoing is necessary as all the
>command logic of the running bg command is done upon completion.
>
>Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>---
>  hw/cxl/cxl-device-utils.c    |  2 +-
>  hw/cxl/cxl-mailbox-utils.c   | 39 ++++++++++++++++++++++++++++++++++--
>  include/hw/cxl/cxl_device.h  |  1 +
>  include/hw/cxl/cxl_mailbox.h |  1 +
>  4 files changed, 40 insertions(+), 3 deletions(-)
>
>diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
>index 035d034f6dd8..4f4ccfa92d82 100644
>--- a/hw/cxl/cxl-device-utils.c
>+++ b/hw/cxl/cxl-device-utils.c
>@@ -95,7 +95,7 @@ static uint64_t mailbox_reg_read(void *opaque, hwaddr of=
fset, >unsigned size)
>         }
>         if (offset =3D=3D A_CXL_DEV_MAILBOX_STS) {
>             uint64_t status_reg =3D cxl_dstate->mbox_reg_state64[offset /=
 size];
>-            if (cci->bg.complete_pct) {
>+            if (cci->bg.complete_pct || cci->bg.aborted) {
>                 status_reg =3D FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS=
, BG_OP,
>                                         0);
>                 cxl_dstate->mbox_reg_state64[offset / size] =3D status_re=
g;
>diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>index 80a80f1ec29b..ae4b3cabbb86 100644
>--- a/hw/cxl/cxl-mailbox-utils.c
>+++ b/hw/cxl/cxl-mailbox-utils.c
>@@ -53,6 +53,7 @@ enum {
>      INFOSTAT    =3D 0x00,
>         #define IS_IDENTIFY   0x1
>         #define BACKGROUND_OPERATION_STATUS    0x2
>+        #define BACKGROUND_OPERATION_ABORT     0x5
>      EVENTS      =3D 0x01,
>         #define GET_RECORDS   0x0
>         #define CLEAR_RECORDS   0x1
>@@ -815,6 +816,33 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct=
 >cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>
>+/* CXL r3.1 Section 8.2.9.1.5: Request Abort Background Operation (Opcode=
 >0005h) */
>+static CXLRetCode cmd_infostat_bg_op_abort(const struct cxl_cmd *cmd,
>+                                           uint8_t *payload_in,
>+                                           size_t len_in,
>+                                           uint8_t *payload_out,
>+                                           size_t *len_out,
>+                                           CXLCCI *cci)
>+{
>+    int bg_set =3D cci->bg.opcode >> 8;
>+    int bg_cmd =3D cci->bg.opcode & 0xff;
>+    const struct cxl_cmd *bg_c =3D &cci->cxl_cmd_set[bg_set][bg_cmd];
>+
>+    if (!(bg_c->effect & CXL_MBOX_BACKGROUND_OPERATION_ABORT)) {
>+        return CXL_MBOX_REQUEST_ABORT_NOTSUP;
>+    }
>+
>+    if (cci->bg.runtime) {
>+        assert(cci->bg.complete_pct < 100);
>+        timer_del(cci->bg.timer);
>+        cci->bg.ret_code =3D CXL_MBOX_ABORTED;
>+        cci->bg.starttime =3D 0;
>+        cci->bg.runtime =3D 0;
>+        cci->bg.aborted =3D true;
>+    }
>+    return CXL_MBOX_SUCCESS;
>+}
>+
>  /* CXL r3.1 Section 8.2.9.3.1: Get FW Info (Opcode 0200h) */
>  static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd=
,
>                                                uint8_t *payload_in,
>@@ -2149,6 +2177,8 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const stru=
ct >cxl_cmd *cmd,
>  }
>
>  static const struct cxl_cmd cxl_cmd_set[256][256] =3D {
>+    [INFOSTAT][BACKGROUND_OPERATION_ABORT] =3D { "BACKGROUND_OPERATION_AB=
ORT",
>+        cmd_infostat_bg_op_abort, 0, 0 },
>      [EVENTS][GET_RECORDS] =3D { "EVENTS_GET_RECORDS",
>         cmd_events_get_records, 1, 0 },
>      [EVENTS][CLEAR_RECORDS] =3D { "EVENTS_CLEAR_RECORDS",
>@@ -2176,7 +2206,7 @@ static const struct cxl_cmd cxl_cmd_set[256][256] =
=3D {
>      [SANITIZE][OVERWRITE] =3D { "SANITIZE_OVERWRITE", cmd_sanitize_overw=
rite, 0,
>         (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
>          CXL_MBOX_SECURITY_STATE_CHANGE |
>-         CXL_MBOX_BACKGROUND_OPERATION)},
>+         CXL_MBOX_BACKGROUND_OPERATION  | >CXL_MBOX_BACKGROUND_OPERATION_=
ABORT)},
>      [PERSISTENT_MEM][GET_SECURITY_STATE] =3D { "GET_SECURITY_STATE",
>         cmd_get_security_state, 0, 0 },
>      [MEDIA_AND_POISON][GET_POISON_LIST] =3D { >"MEDIA_AND_POISON_GET_POI=
SON_LIST",
>@@ -2189,7 +2219,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] =
=3D {
>         "MEDIA_AND_POISON_GET_SCAN_MEDIA_CAPABILITIES",
>         cmd_media_get_scan_media_capabilities, 16, 0 },
>      [MEDIA_AND_POISON][SCAN_MEDIA] =3D { "MEDIA_AND_POISON_SCAN_MEDIA",
>-        cmd_media_scan_media, 17, CXL_MBOX_BACKGROUND_OPERATION },
>+        cmd_media_scan_media, 17,
>+        CXL_MBOX_BACKGROUND_OPERATION | CXL_MBOX_BACKGROUND_OPERATION_ABO=
RT},
>      [MEDIA_AND_POISON][GET_SCAN_MEDIA_RESULTS] =3D {
>         "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
>         cmd_media_get_scan_media_results, 0, 0 },
>@@ -2214,6 +2245,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256]=
 =3D {
>      [INFOSTAT][IS_IDENTIFY] =3D { "IDENTIFY", cmd_infostat_identify, 0, =
0 },
>      [INFOSTAT][BACKGROUND_OPERATION_STATUS] =3D { "BACKGROUND_OPERATION_=
STATUS",
>         cmd_infostat_bg_op_sts, 0, 0 },
>+    [INFOSTAT][BACKGROUND_OPERATION_ABORT] =3D { "BACKGROUND_OPERATION_AB=
ORT",
>+        cmd_infostat_bg_op_abort, 0, 0 },
>      [TIMESTAMP][GET] =3D { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
>      [TIMESTAMP][SET] =3D { "TIMESTAMP_SET", cmd_timestamp_set, 8,
>                          CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
>@@ -2295,6 +2328,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set=
, >uint8_t cmd,
>         cci->bg.opcode =3D (set << 8) | cmd;
>
>         cci->bg.complete_pct =3D 0;
>+        cci->bg.aborted =3D false;
>         cci->bg.ret_code =3D 0;
>
>         now =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
>@@ -2386,6 +2420,7 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
>      cxl_rebuild_cel(cci);
>
>      cci->bg.complete_pct =3D 0;
>+    cci->bg.aborted =3D false;
>      cci->bg.starttime =3D 0;
>      cci->bg.runtime =3D 0;
>      cci->bg.timer =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
>diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>index d38391b26f0e..d83b359e9994 100644
>--- a/include/hw/cxl/cxl_device.h
>+++ b/include/hw/cxl/cxl_device.h
>@@ -197,6 +197,7 @@ typedef struct CXLCCI {
>      struct {
>         uint16_t opcode;
>         uint16_t complete_pct;
>+        bool aborted;
>         uint16_t ret_code; /* Current value of retcode */
>         uint64_t starttime;
>         /* set by each bg cmd, cleared by the bg_timer when complete */
>diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
>index beb048052e1b..9008402d1c46 100644
>--- a/include/hw/cxl/cxl_mailbox.h
>+++ b/include/hw/cxl/cxl_mailbox.h
>@@ -14,5 +14,6 @@
>  #define CXL_MBOX_IMMEDIATE_LOG_CHANGE (1 << 4)
>  #define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
>  #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
>+#define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
>
>  #endif
>--
>2.44.0
    =
