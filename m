Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AA61D95BE
	for <linux-cxl@vger.kernel.org>; Thu, 17 Oct 2024 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185958; cv=fail; b=DSvgnVtKOkxx/eUmXvaHS64fawy/YJKLZOwLbP2riWpKzicfapdxSnxV4+GAR6yCHsnDFozjHEGP7cB0xlNA6BI7XZxhymrX2pDZebtkDfi5Ajd5MA5xgxXXyKtchX5KO85bkHmdF5BbWVEhLLi/xwrBegJSU1AEe2XendDdZzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185958; c=relaxed/simple;
	bh=AOr2wZwDBv5//0sGo7+krU32JLXq1qtsLO5xWYMjuDk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DBe2lYCmqU7igl0RquwxCY+SPMUtwhrLc1dLKFqO/gv8DncCWsTiQEusJ4xEq1vHciMk10g4+ooXVhQ3QrqJb5/RoSc50MBpdnaey2qUphtLkb2Dgk38ppk1keWw1dYmKfdIzCh7kdv2JqR91lmRjhAaKf7ePBAXS1ZzowFij/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=rkaZLEoX; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="rkaZLEoX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n76/1WtWUHXGAUn8JQOZPeK73oAfhrEyzlu/VnOfkQliM1mvmHrOWmsio+njSkdA91M5bW38H/sosRzQMQHNvG+GE2/k7BaGdLHf/JWsNgljLweYfsfJvPj90aGik7SqJ6EYPXH+RArsuyBrs0tSiVqxR5WSFkspsWcsgwDnry/ZarE1Eg+oiZmzEyFdu0i6JIDbINyp5msiBJFxOTTz5FENd9vGw7GMiBpH6RA9lalHKO34h2IxNiCncD3R6ipVgDXHgm2Q0a7eSPtVywthdP+2D2Yfs8gj4ZdVn2Z8p2FBf9CPAA2drTs/b1LO1P4L5DYV2PwB3D5CKMbQ8Lbprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eP9fTDBCnwQtMJW1Bo1iukSK6dsKy71rC4M963xkZNk=;
 b=KnQlsWyI4efL44u2ErQxQ9kBgcXNCLwdQoAgm4sj1FEHts+o1Mz4nuZfkr1zbH3BDjs9BicRYDgYo81gmZ+d9Js7i7dNISHKeNiTkufh+xaApZG3X9ky2HMOxf6R5jVatEbPv/EvL6aMNED4PEPHwLFbg1wGMlhQySHPUZ2kz9v3tqxSnIFs4u4jS5iAA4ni9pajEBgiji+Kw537keD1bKpWBi3rLdFUtWUJ8S0sJ8PT0u96/MJ+RwfqjnQLOUiH1H4T1dkjISs4e+IlweUZ8ip5ySnWltd7+SV4zfNVyFnzj7eZjHtU0YgSn59SgpM9GOJZ8NluY7yDj1VsFkV+2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eP9fTDBCnwQtMJW1Bo1iukSK6dsKy71rC4M963xkZNk=;
 b=rkaZLEoXQay5Puw8FktA2TLtf63uTKVJEHUm0bEdjmrxrhEifAgBdFh6mPc/1zM6JuswKopLolLVn3Lup9JXTNSpICYCbeluRxSdQp3hEc2xe2/OA5eEO7nDDbLdSXi0fy2FxXfVl6iwHQitFnIblFpEZ0xEa1E3dPuckBmihCHPgVccyPgcLbRGqhWKlgSl8KYiC6iPgk9mAz+9DLR8Wf1KtFp6leA6irGISYa2HOGdRcS4cdIEV3xBaytwSMB3tL7UX706Lazgsy4MmodjYWmX+fUZvn0Tw8Jq78g1aFhgtGMZSWgTZMLH0cqszNw+VGpuE9WudWcb2GWfbJ5CUA==
Received: from PH7P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::35)
 by CYXPR08MB9293.namprd08.prod.outlook.com (2603:10b6:930:e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 17:25:42 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:510:338:cafe::8b) by PH7P223CA0018.outlook.office365.com
 (2603:10b6:510:338::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 17:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 17:25:42 +0000
Received: from BOW36EX19A.micron.com (137.201.85.33) by BOW17EX19B.micron.com
 (137.201.21.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 17 Oct
 2024 11:25:39 -0600
Received: from BOW36EX19A.micron.com ([fe80::82f9:2375:13a4:3273]) by
 BOW36EX19A.micron.com ([fe80::82f9:2375:13a4:3273%8]) with mapi id
 15.02.1544.011; Thu, 17 Oct 2024 11:25:39 -0600
From: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Ravis OpenSrc
	<Ravis.OpenSrc@micron.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "john@jagalactic.com" <john@jagalactic.com>, "Ajay
 Joshi" <ajayjoshi@micron.com>
Subject: RE: [EXT] Re: [RFC PATCH v2 2/4] cxl: Add default timeout for bg
 mailbox commands
Thread-Topic: [EXT] Re: [RFC PATCH v2 2/4] cxl: Add default timeout for bg
 mailbox commands
Thread-Index: AQHbH4g/djwl0+QCQUi1njK/EXQOVLKLeQGA//+582A=
Date: Thu, 17 Oct 2024 17:25:39 +0000
Message-ID: <6d8b824040254403b64babced1097ac3@micron.com>
References: <20241015205633.127333-1-ravis.opensrc@micron.com>
	<20241015205633.127333-3-ravis.opensrc@micron.com>
	<913b851a25344bb1832ddc902eb0aa5f@micron.com>
 <20241017163215.00000547@Huawei.com>
In-Reply-To: <20241017163215.00000547@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ActionId=2f1b9c03-ceb3-499c-a817-9bed645393c9;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=0;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=true;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2024-10-17T17:21:31Z;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|CYXPR08MB9293:EE_
X-MS-Office365-Filtering-Correlation-Id: 821f23fe-f1cc-4505-0491-08dceed0ba53
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z5v8Jq7JDw46VAWIajaFh2OnFTviUzWFDNPaBIzpQHo/FCTS05uG+iA578Bv?=
 =?us-ascii?Q?fgKVXkRAi1E48OnPajLe8mrA7m6svAXP/6HV+5lJEpdNEO7Lh5SdTF3wLXlN?=
 =?us-ascii?Q?VjJv5E6WE4PTppVZLvSTzmd5KrwPG6/jk6qPgkCPAqQEbZfHZgy8xt1nE8rj?=
 =?us-ascii?Q?MZZAHL0Y619ocvOWodCIQbNBxPNBfaeGKYygdNHxveE+tap2IwFl7hoWLmIs?=
 =?us-ascii?Q?AaBZsNWVg/BXAdz+scDVUtzUYP9RED+TYJCESQyRmd3TBeF6kHkDyTIHwqjQ?=
 =?us-ascii?Q?gAlUef0Bv+j1ng2wXDwPX1YkVixtyPCjkEKpp9KfzTfP34cL2KHEV2oejBtO?=
 =?us-ascii?Q?Bp3+scH/Qx2AHgt2/txpySUthbMCMIH4UxxTrT9kn8mgg54DHj6yMEh9t1oW?=
 =?us-ascii?Q?frR+yvcRLsnenhNb2VmFAFvkvE+9IuMNf77grReo8IsZHChkNpNHy2YQhxcL?=
 =?us-ascii?Q?E59aJzzxU9ThX20JuLrfwjLY6DODHcShKcB+2UFLPRYS1QWwjSvokX+s9PsI?=
 =?us-ascii?Q?yDN+Nm3M9L9rW4K1Ql5tVtAHiLdCWY9v81I5kllannmQpsuxvjAJECz4Bw28?=
 =?us-ascii?Q?TPAEiBNszBaYzWCQjAomq1IblU0VB/2z4Rd10hvvbOJS9iRupbe58DGcOTwq?=
 =?us-ascii?Q?apKUU4a0ZwQLtt3brwnJomlpgp3Gkz40PsDxhmKM2iH0dmDMvNDyG4sUGo9e?=
 =?us-ascii?Q?GqTtfP4nBCPZqwKulT1Q09jiCb+OI46nwcona2RYu0Jbqdni4qB+eUO0PZag?=
 =?us-ascii?Q?qGb4CB3Z+nRaOvPslxGXhdOztCEmgPnpJApvSGHHye5alDZevHzIDpRwD8f2?=
 =?us-ascii?Q?t6lw/CpArNidNfLOzSyKhVm4x20YJGWW9eY44WW53CTxClh1D2u2nzz8Zp5D?=
 =?us-ascii?Q?6zyeAhgrkjGOTuXhkllJdQdSf+lgGeRKI56Yt1srP9HNYLXYJTYPz+eb0DRq?=
 =?us-ascii?Q?u2iR496bCvpr8AMTdDPxPa9HiW8erMyGUJFi10gDUCr4+NUhzwYHcaFTss1/?=
 =?us-ascii?Q?7AD8IhEAG7/CBQBgqFOyRzC8mi+WI+zKw5eyoHLz5q6ii0gbuzx4fbmIIBPh?=
 =?us-ascii?Q?TTyz89xWvJ5zZqgN1Lu1NBsOJsbsZLqKZXMCQsDDd91gifRwW3PjMF1nZlMC?=
 =?us-ascii?Q?X31UaIu7BHJibQbOyDuQzJNoPGVW2Shj/oXas6BfiDeygpVKDGynDW/r/FlD?=
 =?us-ascii?Q?n0NDA89HSixUF5Y3NpDcVK+stKoN0Ji2xnPTWXU+v2vsnHUi3g2Q1KMTPg40?=
 =?us-ascii?Q?LR+GPsqqu+HqXHcn73OfaQpY3vy4sK3fOyxLWTzfHxCt6lpNGFSrkBgMh9Ml?=
 =?us-ascii?Q?5roP5wEM6Qtyv2aUfr6dQX00CHj2T4REdD8u8Me9v8iB7IiikqO+qvPkTwRh?=
 =?us-ascii?Q?ewbInWY=3D?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:25:42.5597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 821f23fe-f1cc-4505-0491-08dceed0ba53
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR08MB9293


Micron Confidential



Micron Confidential
>-----Original Message-----
>From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
>Sent: Thursday, October 17, 2024 9:02 PM
>To: Ravis OpenSrc <Ravis.OpenSrc@micron.com>
>Cc: linux-cxl@vger.kernel.org; dan.j.williams@intel.com; dave.jiang@intel.=
com;
>Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>; john@jagalactic.com;
>Ajay Joshi <ajayjoshi@micron.com>
>Subject: [EXT] Re: [RFC PATCH v2 2/4] cxl: Add default timeout for bg mail=
box
>commands
>
>CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you
>recognize the sender and were expecting this message.
>
>
>On Wed, 16 Oct 2024 04:59:58 +0000
>Ravis OpenSrc <Ravis.OpenSrc@micron.com> wrote:
>
>> Allows 5s wait when no timeout parameter is explicitly mentioned.
>>
>> It is useful for mailbox commands to be executed in background
>> when initiated from userspace.
>>
>> Link:
>>
>https://lore.kernel/
>.org%2Flinux-
>mm%2F20240215123410.00003b8c%40Huawei.com%2FT%2F&data=3D05%7C02%7
>Csthanneeru.opensrc%40micron.com%7Cb92d2c58a0e14335108508dceec0e378
>%7Cf38a5ecd28134862b11bac1d563c806f%7C0%7C0%7C638647759553538421
>%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi
>I6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D3mRf9MkO9GO2L%2F%
>2B7Vz9h92vVpVmX2AX%2Ba2unp5mBzKU%3D&reserved=3D0
>>
>> Signed-off-by: Ajay Joshi <ajay.opensrc@micron.com>
>> Signed-off-by: Ravi Shankar <ravis.opensrc@micron.com>

This patch mostly of resend of previous version from https://lore.kernel.or=
g/linux-mm/20240215123410.00003b8c@Huawei.com/T/
Hence, need to add original author's s/o.

Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>


>Other than patch formatting, this seems reasonable to me.
>
>Jonathan
>
>> ---
>>  drivers/cxl/pci.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 188412d45e0d..d5d6142f6aa3 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -41,6 +41,10 @@
>>  /* CXL 2.0 - 8.2.8.4 */
>>  #define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
>>
>> +/* Default timeout for background operations */
>> +#define CXL_BG_POLL_CNT                        5
>> +#define CXL_BG_POLL_INTERVAL_MS                1000
>> +
>>  /*
>>   * CXL 2.0 ECN "Add Mailbox Ready Time" defines a capability field to
>>   * dictate how long to wait for the mailbox to become ready. The new
>> @@ -317,6 +321,15 @@ static int __cxl_pci_mbox_send_cmd(struct
>cxl_mailbox *cxl_mbox,
>>                  dev_dbg(dev, "Mailbox background operation (0x%04x) sta=
rted\n",
>>                          mbox_cmd->opcode);
>>
>> +               /*
>> +                * Add a default timeout of 5 seconds when background op=
eration
>> +                * starts but no timeout is specified.
>> +                */
>> +               if (!mbox_cmd->poll_interval_ms) {
>> +                       mbox_cmd->poll_interval_ms =3D CXL_BG_POLL_INTER=
VAL_MS;
>> +                       mbox_cmd->poll_count =3D CXL_BG_POLL_CNT;
>> +               }
>> +
>>                  timeout =3D mbox_cmd->poll_interval_ms;
>>                  for (i =3D 0; i < mbox_cmd->poll_count; i++) {
>>                          if (rcuwait_wait_event_timeout(&cxl_mbox->mbox_=
wait,

