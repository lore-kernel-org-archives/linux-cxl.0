Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D33E13A3F0
	for <linux-cxl@vger.kernel.org>; Wed,  7 Aug 2024 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723021478; cv=fail; b=jzxUcev5KcFBAblUdP/6p9bnHn4Y+hLnn2JEr0fZeSDTufdr845THXshfbSaOYIQc/zGtP5yUFoXaF9VmTZuSxQL23C2uHc8W3SPOKia33pASny2fKmxcKbl9ZjZnl1v+tqALvUpQ9LvE8F7W0EPSaacH/TqyxuqQTarL/mNfo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723021478; c=relaxed/simple;
	bh=2PIFp+hxo9IplEC3Vl2lXyGymaA9nX8+OZU/rxW0/rY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nLGrws8uaCrxBI8n3hMEdNXHpXZ0vHTry7kQC60SjfyyOyA797bqAsi+OqZ6MIu3FLNSzN1w/8YsZC4FRFFvu2dytjrCoaBoJPlOI+ln4sIHWIEGbfKJk8UowrC3Z3gC9hywOV19KFUJ1u0OdqNswq8jnblUx9yKrwKi2AnE58I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=L0Qc6sOb; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="L0Qc6sOb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzbTCD9gqA2ICW3H7Tkri4qmEVDQwQ9IVoDaL6X9QqXCizn7auuwudoizDPND65HQjIOk8e8AZaeZLoCqtDciRAfOW6ShEx8XyMTc1J0Ovc5WX1zhsYl2pTaUgNHaS1DDjKVIbuuTS8xomB0x5I+BGaFQY9V35r7N/ER789begwR/YnttKmAGGbAdoALQQ75NH5Z3G6wdSv0C0guP7YThj345ys9gYw1Eg145lJaMx+t187PVzsR48I8FFsAXYLIVJLqdFgcwkYOD6kT+PqYgGthD+3WImEaxDChk+FlV/nJoswucQ9vxPmTuupvnpm2MuooB/5Nx8XE/8XcCz5zJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PIFp+hxo9IplEC3Vl2lXyGymaA9nX8+OZU/rxW0/rY=;
 b=Su32ACDKLWBV8N8G/QfZCW1UOK9vddJiu26iqdzQUXz7Xcc/BKidAFRBw+llm3BnQZ2Cm11V66Kao+GJcbfOLUgSsMhPjLNJm4R6hsHObJUN7zbV+LjTdUuYtndgJvru2C4pCLpi+w/5kd9aA4JcUrtSqghY7YVH4pHR8zGINo93iQbFpeExFOP81zdtlaoYbsG3/Y+XV5WeQz9/AVIw6pu8DS5n4xiW4O6RZD8AYsDj37NoTqrD2N0M6Dm4f0SoDV4fX6dKV3Ao6z1kN4djAq6jSY72yPdiT/qodFuHy1MfEogUQ5TSpXnTG6n7gOgbIxMKvmu15apuj0kfQ/1J3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PIFp+hxo9IplEC3Vl2lXyGymaA9nX8+OZU/rxW0/rY=;
 b=L0Qc6sObExQfZRAnSPj1YR9+JEAJAKzfnkdZ4MpMP6PsXeb0YIMzsKR0ObqpSX9GKuFYFnganuJD1MSNQkpTvhLCbHGo+EJldiP60zedwyuC0TjbmEJctlFf3iwUmKubcGKzrtv7VpQrHJG1cX/e9bze5l95d/O/+7YpkwXsmTUFft59BOi7NcJ1spFkIn20O901H1RO/x/41mfTT38edQROrnmsdKD1JiVN1cOxsjFRIMZ8XNzJoEay7QBdEpyG7+5XkmoM4Aji+89nMr78A9xD+n7vkW+mXB0hyjGkBBIkzk4ymbNWyLfF1Q6cFlMpniVa+YAicF8KHH6F0iV5Cg==
Received: from CH5PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:1f1::18)
 by SN4PR0801MB7792.namprd08.prod.outlook.com (2603:10b6:806:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Wed, 7 Aug
 2024 09:04:30 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::65) by CH5PR03CA0018.outlook.office365.com
 (2603:10b6:610:1f1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 09:04:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 09:04:29 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW36EX19B.micron.com
 (137.201.85.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 03:04:27 -0600
Received: from BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3]) by
 BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3%6]) with mapi id
 15.02.1544.004; Wed, 7 Aug 2024 03:04:27 -0600
From: ajay.opensrc <ajay.opensrc@micron.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "john@jagalactic.com" <john@jagalactic.com>,
	Eishan Mirakhur <emirakhur@micron.com>, Ajay Joshi <ajayjoshi@micron.com>,
	Srinivasulu Thanneeru <sthanneeru@micron.com>, Ravis OpenSrc
	<Ravis.OpenSrc@micron.com>, Aravind Ramesh <arramesh@micron.com>, "Tushar M
 Mulgund ." <tmmulgund@micron.com>
Subject: Re: [EXT] Re: [PATCH] hw/cxl: Add support for abort of background
 operation
Thread-Topic: [EXT] Re: [PATCH] hw/cxl: Add support for abort of background
 operation
Thread-Index: AQHa4aD86ycczZCLvEOQMSi+AkrzQrIPLvaAgATGA3KAA7+4AIAD1PY5
Date: Wed, 7 Aug 2024 09:04:27 +0000
Message-ID: <739db69829ed4afead329649fda1d47b@micron.com>
References: <20240729102010.20996-1-ajay.opensrc@micron.com>
	<jvbuxqaqjclc5cy5veltygpo4dg3naej456gvphndpdc3ttyoa@p64fmecqr67r>
	<027f6872f7ae42c4ba97ed1209e50253@micron.com>,<20240804171638.0000291c@Huawei.com>
In-Reply-To: <20240804171638.0000291c@Huawei.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|SN4PR0801MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: f5456b8e-159f-4555-9c95-08dcb6bff232
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?MiEYIEzYeJ1rJwUpJG5/oUqJCbu88+q01FFiSfVacenAAJuc5RX6ndbh8Q?=
 =?iso-8859-1?Q?pdMpBY+H65omf0H3aGis7M8u1hrOMZQH8tvKoUw39RcBrSsQAfIJa3njbz?=
 =?iso-8859-1?Q?LjPX91RlLjGyU9EMtA/zZbgNm1fWimb4PojH0XbyvSemta7oH/bGt30i0S?=
 =?iso-8859-1?Q?x68kvG4ePYIQnY/WmZfgw55whzoB5pd2KG/hBkLqGGuIwn5BhkHb1GPeg/?=
 =?iso-8859-1?Q?/mLSiN0KoP4o7HY6gBcik9EK4AJj4LnymcdRL7+kd8dHk+qYflvbfADD3o?=
 =?iso-8859-1?Q?iEsPX98seueguUO4LGmhd/0n2122pwpthNj4AwDBPhCeHwMfOfb31JAowJ?=
 =?iso-8859-1?Q?yGE1hKS01ZrQoVgUKgu4rJPE8ld242kqEToMELisTCGwCNbv8iOz4f7wlW?=
 =?iso-8859-1?Q?xEDdUKUDLHogFAk4dFRZXggFrrFRsAWPvnqCVrsrGgCGAaB1cOr9OOfJ43?=
 =?iso-8859-1?Q?DArOiYKXL0G3fBxFLTZZSnLS/fuxJ3tDr37eg3PqXlSWHcj3Jb9B02aSKj?=
 =?iso-8859-1?Q?RzaWNHkNF/IDgO2Ms5Qj1/5R9D458QIrNMDlDBQzVM8fRWiD+PV4N5k8ch?=
 =?iso-8859-1?Q?VpQi5Ni+3DAIoB9DYYcxr1AtFcumpg7dyB2kTNQNFFrcPcRfny8tnG+vVh?=
 =?iso-8859-1?Q?j/sIIDRLWJRN50QyCuPpuwv+f2Ld2OfXIWWd8d4vh8ws4LY+E8Jcmmuss/?=
 =?iso-8859-1?Q?UwF/RO2ghTgm9m/PQJBmjbclYY0osL5vfjalHWQb1XS3R1gQqyCQK/lB3/?=
 =?iso-8859-1?Q?cx+YiFFB6+RA5arz+zHYqE5v/HtSP+yZnNjygwog/KDq20TAI7X1NhDHuf?=
 =?iso-8859-1?Q?YlazYgELqTm0SORR4bZ+0ksxreWY1vqE1YvCeehHvhTCVVV2UZdleemo0U?=
 =?iso-8859-1?Q?vp0O7ull/Jj9Cu7heDW7B9Wc+hq00jsRXuCLLsChVhgzfkhxVtOvVhzM9q?=
 =?iso-8859-1?Q?j9L0BeMYl0Ts07rbJFH2YUkRscZDctM5yPXoGIeaLunxD3VURDcODuaHSb?=
 =?iso-8859-1?Q?ImI+zLHA4ZxyLD0gSjseaLimhm4XQdCSmuSTStDSTWah7GGniSQhGDmXzV?=
 =?iso-8859-1?Q?iUc7Z9Qar0Ar/iWG11y4pf8PzibdaNWvfhj1ytmGY//tjxgm4CcTfxhvik?=
 =?iso-8859-1?Q?PbSLv/QwgZI+/ATAe2xK86brJ5sMJOQkTwLCUWbZgvjS0vEAMrkxog4to+?=
 =?iso-8859-1?Q?DKydWTeFSkVtHLC4E1XnfitDUBuGj9EI6PQKWdLwft0E/jmS/olyrF+zcv?=
 =?iso-8859-1?Q?lFTbbBIYBGtlELNvxTW3tIG4KaUuH5Pke5CGHgIBHaWDrL8btFM1N6z/qV?=
 =?iso-8859-1?Q?+yE2WST3et9A+AXgLWjnkkkihX0xaLp+Xmmw4sJO8EA0Kikdo1cifx55MY?=
 =?iso-8859-1?Q?O8BSthZ9f+sadbJ+LDiVXliAy4dd4fVvzjr5fNalc3cYRLm5CYSpmOf/ih?=
 =?iso-8859-1?Q?M7yFFCD0VTBYAFVmkXnV6Zl3Fo+iWuUTLSspH0cDCz1HsKdtGyeREyzReL?=
 =?iso-8859-1?Q?wVZXckr4ANZI/FJ71/lhp+?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 09:04:29.6460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5456b8e-159f-4555-9c95-08dcb6bff232
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0801MB7792

>From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
>>ajay.opensrc <ajay.opensrc@micron.com> wrote:
>
>> >From: Davidlohr Bueso <dave@stgolabs.net>
>> >>From: Ajay Joshi <ajay.opensrc@micron.com>
>> >>
>> >>This patch adds the support for aborting the background
>> >>operation if one is progress(r3.1 8.2.9.1.5)
>> >>
>> >>"Request Abort Background Operation" command is requested
>> >>by the host to cancel an ongoing background operation. When
>> >>the command is sent, the device will abort the ongoing
>> >>background operation.=A0 When the operation is aborted,
>> >>background command status register will maintain a completion
>> >>percentage value of less then 100. The "Request Abort
>> >>Background Operation" command support has to be advertised in
>> >>the Command Effects Log to be honoured.
>> >
>> >So I had a patch for this which I had not sent out, and compared
>> >to this one I think the below is more robust, would you mind
>> >testing this out?
>>
>> Didn't realize you were working on one already.
>> This looks good to me as well. I tested this and it seems to be
>> working as expected. Feel free to use:
>>
>> Tested-by: Ajay Joshi <ajay.opensrc@micron.com>
>> Reviewed-by: Ajay Joshi <ajay.opensrc@micron.com>
>From a quick look Davidlohr's patch looks good to me as well.
>I 'could' pick it out of the middle of this thread, but
>probably cleaner if Davlidlohr sends a formal patch
>(picking up Ajay's tags) - maybe with a link tag to this
>thread so we can see where those came from.
>
>One comment inline - feels like a spec hole to me but I'd like some
>more eyes on it before I query it more formally.
>
>Thanks,
>
>Jonathan
>
>>
>> >Thanks,
>> >Davidlohr
>> >
>> >--8<--------
>> >[PATCH] hw/cxl: Support aborting background commands
>> >
>> >As of 3.1 spec, background commands can be canceled with a new
>> >abort command. Implement the support, which is advertised in
>> >the CEL. No ad-hoc context undoing is necessary as all the
>> >command logic of the running bg command is done upon completion.
>> >
>> >Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>> >---
>> >=A0 hw/cxl/cxl-device-utils.c=A0=A0=A0 |=A0 2 +-
>> >=A0 hw/cxl/cxl-mailbox-utils.c=A0=A0 | 39 +++++++++++++++++++++++++++++=
+++++--
>> >=A0 include/hw/cxl/cxl_device.h=A0 |=A0 1 +
>> >=A0 include/hw/cxl/cxl_mailbox.h |=A0 1 +
>> >=A0 4 files changed, 40 insertions(+), 3 deletions(-)
>> >
>> >diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
>> >index 035d034f6dd8..4f4ccfa92d82 100644
>> >--- a/hw/cxl/cxl-device-utils.c
>> >+++ b/hw/cxl/cxl-device-utils.c
>> >@@ -95,7 +95,7 @@ static uint64_t mailbox_reg_read(void *opaque, hwaddr=
 >offset, >unsigned size)
>> >=A0=A0=A0=A0=A0=A0=A0=A0 }
>> >=A0=A0=A0=A0=A0=A0=A0=A0 if (offset =3D=3D A_CXL_DEV_MAILBOX_STS) {
>> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint64_t status_reg =3D cxl_dstate=
->mbox_reg_state64[offset / >size];
>> >-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (cci->bg.complete_pct) {
>> >+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (cci->bg.complete_pct || cci->bg.=
aborted) {
>> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 status_reg =3D FIELD_D=
P64(status_reg, CXL_DEV_MAILBOX_STS, >BG_OP,
>> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0);
>> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cxl_dstate->mbox_reg_s=
tate64[offset / size] =3D status_reg;
>> >diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> >index 80a80f1ec29b..ae4b3cabbb86 100644
>> >--- a/hw/cxl/cxl-mailbox-utils.c
>> >+++ b/hw/cxl/cxl-mailbox-utils.c
>> >@@ -53,6 +53,7 @@ enum {
>> >=A0=A0=A0=A0=A0 INFOSTAT=A0=A0=A0 =3D 0x00,
>> >=A0=A0=A0=A0=A0=A0=A0=A0 #define IS_IDENTIFY=A0=A0 0x1
>> >=A0=A0=A0=A0=A0=A0=A0=A0 #define BACKGROUND_OPERATION_STATUS=A0=A0=A0 0=
x2
>> >+=A0=A0=A0=A0=A0=A0=A0 #define BACKGROUND_OPERATION_ABORT=A0=A0=A0=A0 0=
x5
>> >=A0=A0=A0=A0=A0 EVENTS=A0=A0=A0=A0=A0 =3D 0x01,
>> >=A0=A0=A0=A0=A0=A0=A0=A0 #define GET_RECORDS=A0=A0 0x0
>> >=A0=A0=A0=A0=A0=A0=A0=A0 #define CLEAR_RECORDS=A0=A0 0x1
>> >@@ -815,6 +816,33 @@ static CXLRetCode cmd_infostat_bg_op_sts(const str=
uct >>cxl_cmd *cmd,
>> >=A0=A0=A0=A0=A0 return CXL_MBOX_SUCCESS;
>> >=A0 }
>> >
>> >+/* CXL r3.1 Section 8.2.9.1.5: Request Abort Background Operation (Opc=
ode >>0005h) */
>> >+static CXLRetCode cmd_infostat_bg_op_abort(const struct cxl_cmd *cmd,
>> >+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint8_t *payload_=
in,
>> >+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t len_in,
>> >+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint8_t *payload_=
out,
>> >+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t *len_out,
>> >+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CXLCCI *cci)
>> >+{
>> >+=A0=A0=A0 int bg_set =3D cci->bg.opcode >> 8;
>> >+=A0=A0=A0 int bg_cmd =3D cci->bg.opcode & 0xff;
>> >+=A0=A0=A0 const struct cxl_cmd *bg_c =3D &cci->cxl_cmd_set[bg_set][bg_=
cmd];
>> >+
>> >+=A0=A0=A0 if (!(bg_c->effect & CXL_MBOX_BACKGROUND_OPERATION_ABORT)) {
>> >+=A0=A0=A0=A0=A0=A0=A0 return CXL_MBOX_REQUEST_ABORT_NOTSUP;
>> >+=A0=A0=A0 }
>> >+
>> >+=A0=A0=A0 if (cci->bg.runtime) {
>> >+=A0=A0=A0=A0=A0=A0=A0 assert(cci->bg.complete_pct < 100);
>
>This seems fragile.=A0 I'm not sure what guarantees no races.
>I'd be tempted to follow the allowed path of just letting
>the thing complete if that's the case.=A0 Interesting 8.2.9.1.5
>Request Abort Background operation states
>"In resposne, the device may choose to interrupt he ongoing
>background operation or may choose to continue it's
>execution until completion. If the background operation is
>interrupted, a Command Return of Success shall be returned..
>If the ongoing background operation does not support abort
>capability.. return code shall be set to Request Abort Not supported"
>
>So to my reading if you elect not to stop because it's very
>nearly done, or indeed it raced and the command is done,
>the specification doesn't tell us what to return.
>That operation supports abort, we just didn't.
>
>What do you think should happen here?

IMHO, device should ignore the abort command and=20
most likely return "Unsupported" code (since, the spec is not=20
clear on what should be the return code in case the command=20
is ignored). Does it make sense?

Agree that it's a spec hole and may need to be clarified.

>
>> >+=A0=A0=A0=A0=A0=A0=A0 timer_del(cci->bg.timer);
>> >+=A0=A0=A0=A0=A0=A0=A0 cci->bg.ret_code =3D CXL_MBOX_ABORTED;
>> >+=A0=A0=A0=A0=A0=A0=A0 cci->bg.starttime =3D 0;
>> >+=A0=A0=A0=A0=A0=A0=A0 cci->bg.runtime =3D 0;
>> >+=A0=A0=A0=A0=A0=A0=A0 cci->bg.aborted =3D true;
>> >+=A0=A0=A0 }
>> >+=A0=A0=A0 return CXL_MBOX_SUCCESS;
>> >+}
>> >+
>> >=A0 /* CXL r3.1 Section 8.2.9.3.1: Get FW Info (Opcode 0200h) */
>> >=A0 static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd=
 *cmd,
>> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ui=
nt8_t *payload_in,
>> >@@ -2149,6 +2177,8 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const s=
truct >>cxl_cmd *cmd,
>> >=A0 }
>> >
>> >=A0 static const struct cxl_cmd cxl_cmd_set[256][256] =3D {
>> >+=A0=A0=A0 [INFOSTAT][BACKGROUND_OPERATION_ABORT] =3D { "BACKGROUND_OPE=
RATION_ABORT",
>> >+=A0=A0=A0=A0=A0=A0=A0 cmd_infostat_bg_op_abort, 0, 0 },
>> >=A0=A0=A0=A0=A0 [EVENTS][GET_RECORDS] =3D { "EVENTS_GET_RECORDS",
>> >=A0=A0=A0=A0=A0=A0=A0=A0 cmd_events_get_records, 1, 0 },
>> >=A0=A0=A0=A0=A0 [EVENTS][CLEAR_RECORDS] =3D { "EVENTS_CLEAR_RECORDS",
>> >@@ -2176,7 +2206,7 @@ static const struct cxl_cmd cxl_cmd_set[256][256]=
 =3D {
>> >=A0=A0=A0=A0=A0 [SANITIZE][OVERWRITE] =3D { "SANITIZE_OVERWRITE", >cmd_=
sanitize_overwrite, 0,
>> >=A0=A0=A0=A0=A0=A0=A0=A0 (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
>> >=A0=A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_SECURITY_STATE_CHANGE |
>> >-=A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_BACKGROUND_OPERATION)},
>> >+=A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_BACKGROUND_OPERATION=A0 | >>CXL_MBOX=
_BACKGROUND_OPERATION_ABORT)},
>> >=A0=A0=A0=A0=A0 [PERSISTENT_MEM][GET_SECURITY_STATE] =3D { "GET_SECURIT=
Y_STATE",
>> >=A0=A0=A0=A0=A0=A0=A0=A0 cmd_get_security_state, 0, 0 },
>> >=A0=A0=A0=A0=A0 [MEDIA_AND_POISON][GET_POISON_LIST] =3D { >>"MEDIA_AND_=
POISON_GET_POISON_LIST",
>> >@@ -2189,7 +2219,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256]=
 =3D {
>> >=A0=A0=A0=A0=A0=A0=A0=A0 "MEDIA_AND_POISON_GET_SCAN_MEDIA_CAPABILITIES"=
,
>> >=A0=A0=A0=A0=A0=A0=A0=A0 cmd_media_get_scan_media_capabilities, 16, 0 }=
,
>> >=A0=A0=A0=A0=A0 [MEDIA_AND_POISON][SCAN_MEDIA] =3D { "MEDIA_AND_POISON_=
SCAN_MEDIA",
>> >-=A0=A0=A0=A0=A0=A0=A0 cmd_media_scan_media, 17, CXL_MBOX_BACKGROUND_OP=
ERATION },
>> >+=A0=A0=A0=A0=A0=A0=A0 cmd_media_scan_media, 17,
>> >+=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_BACKGROUND_OPERATION | >CXL_MBOX_BACKGR=
OUND_OPERATION_ABORT},
>> >=A0=A0=A0=A0=A0 [MEDIA_AND_POISON][GET_SCAN_MEDIA_RESULTS] =3D {
>> >=A0=A0=A0=A0=A0=A0=A0=A0 "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
>> >=A0=A0=A0=A0=A0=A0=A0=A0 cmd_media_get_scan_media_results, 0, 0 },
>> >@@ -2214,6 +2245,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][2=
56] =3D >{
>> >=A0=A0=A0=A0=A0 [INFOSTAT][IS_IDENTIFY] =3D { "IDENTIFY", cmd_infostat_=
identify, 0, 0 },
>> >=A0=A0=A0=A0=A0 [INFOSTAT][BACKGROUND_OPERATION_STATUS] =3D { >"BACKGRO=
UND_OPERATION_STATUS",
>> >=A0=A0=A0=A0=A0=A0=A0=A0 cmd_infostat_bg_op_sts, 0, 0 },
>> >+=A0=A0=A0 [INFOSTAT][BACKGROUND_OPERATION_ABORT] =3D { "BACKGROUND_OPE=
RATION_ABORT",
>> >+=A0=A0=A0=A0=A0=A0=A0 cmd_infostat_bg_op_abort, 0, 0 },
>> >=A0=A0=A0=A0=A0 [TIMESTAMP][GET] =3D { "TIMESTAMP_GET", cmd_timestamp_g=
et, 0, 0 },
>> >=A0=A0=A0=A0=A0 [TIMESTAMP][SET] =3D { "TIMESTAMP_SET", cmd_timestamp_s=
et, 8,
>> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
>> >@@ -2295,6 +2328,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t =
set, >>uint8_t cmd,
>> >=A0=A0=A0=A0=A0=A0=A0=A0 cci->bg.opcode =3D (set << 8) | cmd;
>> >
>> >=A0=A0=A0=A0=A0=A0=A0=A0 cci->bg.complete_pct =3D 0;
>> >+=A0=A0=A0=A0=A0=A0=A0 cci->bg.aborted =3D false;
>> >=A0=A0=A0=A0=A0=A0=A0=A0 cci->bg.ret_code =3D 0;
>> >
>> >=A0=A0=A0=A0=A0=A0=A0=A0 now =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
>> >@@ -2386,6 +2420,7 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max=
)
>> >=A0=A0=A0=A0=A0 cxl_rebuild_cel(cci);
>> >
>> >=A0=A0=A0=A0=A0 cci->bg.complete_pct =3D 0;
>> >+=A0=A0=A0 cci->bg.aborted =3D false;
>> >=A0=A0=A0=A0=A0 cci->bg.starttime =3D 0;
>> >=A0=A0=A0=A0=A0 cci->bg.runtime =3D 0;
>> >=A0=A0=A0=A0=A0 cci->bg.timer =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
>> >diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>> >index d38391b26f0e..d83b359e9994 100644
>> >--- a/include/hw/cxl/cxl_device.h
>> >+++ b/include/hw/cxl/cxl_device.h
>> >@@ -197,6 +197,7 @@ typedef struct CXLCCI {
>> >=A0=A0=A0=A0=A0 struct {
>> >=A0=A0=A0=A0=A0=A0=A0=A0 uint16_t opcode;
>> >=A0=A0=A0=A0=A0=A0=A0=A0 uint16_t complete_pct;
>> >+=A0=A0=A0=A0=A0=A0=A0 bool aborted;
>> >=A0=A0=A0=A0=A0=A0=A0=A0 uint16_t ret_code; /* Current value of retcode=
 */
>> >=A0=A0=A0=A0=A0=A0=A0=A0 uint64_t starttime;
>> >=A0=A0=A0=A0=A0=A0=A0=A0 /* set by each bg cmd, cleared by the bg_timer=
 when complete */
>> >diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.=
h
>> >index beb048052e1b..9008402d1c46 100644
>> >--- a/include/hw/cxl/cxl_mailbox.h
>> >+++ b/include/hw/cxl/cxl_mailbox.h
>> >@@ -14,5 +14,6 @@
>> >=A0 #define CXL_MBOX_IMMEDIATE_LOG_CHANGE (1 << 4)
>> >=A0 #define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
>> >=A0 #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
>> >+#define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
>> >
>> >=A0 #endif
>> >--
>> >2.44.0
>>
