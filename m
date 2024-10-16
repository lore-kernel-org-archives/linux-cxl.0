Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE31A4A02
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 04:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729053112; cv=fail; b=OQIf1NioCIOq48fpPaE/7Vl0hxCa1yUZtEUpRToWO/4QyKbEMQO58zH/c8VYbc/5HZUhm0L26xm7D0Elpy5/jF9KaDab1cBLcnwNvRhTOvtJ4q59BlTGPMQn6TVJeWjuzhppA9BZLOa57RROBtDfH6LuOKEFVqsmBZ6KOD+hy8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729053112; c=relaxed/simple;
	bh=AtJ0ZoSIHkxv7a2/D0eEdOUjNjyZfWfRq5YLlD5Wh/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=di9p/UeJeB3uvh6PFD4aELxbVeTgbauGZoXYj01NJzvPeDOXpdKrqEvfFGGNpE4KaTo3wtxqQfezWptgl3mPdMjb/vVjV11t+y/urNOn3UBoeoNX9TLWP7HQ9pw4+jpepi3lY7FDxb73MkgSwy65R4h7RBGQlt/tGWUFAYnx5ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=mKeQ4q6Z; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="mKeQ4q6Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HX68s+PRkKB9MzIDnOkIzpnpX/jfjHCuuPtZAhHYWdMCai4RP2K+42ajz2DtZZSk5ZL+tX+KM54YwWQCamueTVskS1NnhlJ7tbX7DBpyjfJJ+PnM0hoKggUEHa2qd3NH0RQ+G+kEA5umA5Z9nkrYiX7sqQptooy+9RXOW55NotxYLn7c1JkWoWVfOAKgOdeffNKaac0czHwGld/SjKYA/F3YsJPUAJHo0mMDiHweCZoJjuX48pxhqJyy+RTzs7U3SBCW8fzPmYaOEeLVSOMIKXfo9mE19m1SwFaiBgTIWqdJM8RFEscu58WZCjKPRYcx/6GCLnxQ4N6lr61tjOc+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8vgbxmaOdhAloIuD8edrJk9w04s61DpRnG2w4J97w0=;
 b=FXQ4utbBfXGHeM21xe4O+H7AQ0QS3P+3ldNZ9+qJ+v2ZMbqR49kFyzoIyFOgsaO+aOMapqQrAFXZxg+ThO+rPDsMtPFqcvQeNFbxsOcE5g15JMiNLFIpcMsKY3pCSHlK9tC68uSGo78DmyZ20iKVk1w5nktmTsuDLUg9TpzuXhydIhEVDZdQquf2glFuVjT3Not83w5UKiJV2LnVK7gIyWk0c8yfZohMaken80aF1EvGzUvh9A4bsS9agkeZ4+qs65rGCQUQlOKlYy2DgYk42ht+douf0KXb5h7+BaKkWJhaKBVXWQdaTw9jBtcAgR60gHZ//L9MgdqxB4/pQoFtiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=jagalactic.com smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8vgbxmaOdhAloIuD8edrJk9w04s61DpRnG2w4J97w0=;
 b=mKeQ4q6Z/NuNzCbhHWCAjZfECd+rQtA4cJGlFslwx2mnAeZjqOU7KUfaSCv/zILi6QeYTINdmm9dQQuAaS+qsEIaWppljQU5q6iNpILDoAV1ugXBJsuqy3qSiLB1CsUc6wvwjAvMukoBm2NteeKYHZOAyfFNeuNFYYCqiet4w0R5Ut8UtQDaJID8tWTnYH3IngJdwA1tM7w1enJU1vnpoAGEHNWSvUoNHgUG7+YkJH0R8QFig6uKFfNjH7+czETHQCoqj+0/8etXe1orNsS8S9/JNgxLvGj1RQd+LNUdh4CsQaDQfo+PV2q4L7mRNkjuYTa1HnbHz9QbcFm06ATsxQ==
Received: from BL1PR13CA0341.namprd13.prod.outlook.com (2603:10b6:208:2c6::16)
 by SN4PR0801MB7742.namprd08.prod.outlook.com (2603:10b6:806:201::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 04:31:46 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::78) by BL1PR13CA0341.outlook.office365.com
 (2603:10b6:208:2c6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 04:31:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 04:31:46 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Oct
 2024 22:31:44 -0600
Received: from BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3]) by
 BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3%6]) with mapi id
 15.02.1544.011; Tue, 15 Oct 2024 22:31:44 -0600
From: Ravis OpenSrc <Ravis.OpenSrc@micron.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>
CC: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>, "john@jagalactic.com"
	<john@jagalactic.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: [RFC 0/4] cxl: Support for mailbox background abort operation
Thread-Topic: [RFC 0/4] cxl: Support for mailbox background abort operation
Thread-Index: AQHbH0T8Mc+wQe7gQEii/lVVIsbMpLKIxSt2
Date: Wed, 16 Oct 2024 04:31:44 +0000
Message-ID: <c3312b1ce2374fb28a899b0bdb01c6a4@micron.com>
References: <20241015205633.127333-1-ravis.opensrc@micron.com>
In-Reply-To: <20241015205633.127333-1-ravis.opensrc@micron.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|SN4PR0801MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: f100b21e-39b8-4705-e769-08dced9b71a9
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?qZtffEjAMqVH9CtYbiwnJSDjWY5Dg3x314zEVat6sgUwmk2fNChVArDPGs?=
 =?iso-8859-1?Q?d21sqB5aqDJZLXT484r1jD9SgSlL7S2VLDdTyVh01nWqie/DHGHkzu5Fbn?=
 =?iso-8859-1?Q?I25zWMXhcopOr3XcIkdW35BWsR1TPOt5UENtK7l9eVYdEPOtv7P4xFOAEH?=
 =?iso-8859-1?Q?0Dc6pUUonJKVuHvRG11VLoJg/uYrLBgedowNtwlkCXClUfmjVaBCEpG+e/?=
 =?iso-8859-1?Q?Yds1V9vL1kNuhhSOZ5hl9L+qc6oxZirlBFLyYUOxTssCUO8HXRTKsW5UZ/?=
 =?iso-8859-1?Q?fiFSZ/vCgyu1DLpsiujU/T7oLsZqgtKWesYVwvyhpVPvuAA9nvZklWsfzw?=
 =?iso-8859-1?Q?NxD2DrNougGrIMSejJ6D5HonkflnqnZTrHt+ybAhdK7WI37bpA174gsgi3?=
 =?iso-8859-1?Q?2BacYZ9QYnDExn3q/ULohrSqGrOlqaaxCIZgv5Ye9PITKSF+wFaQDZ80mN?=
 =?iso-8859-1?Q?rvUb0WS/1ul5shZp8SMszppCFGwmUQ9BUzVowmBnOVBC/CKNVTC2bTT5DN?=
 =?iso-8859-1?Q?0uoL/+VayjGd1eF+q+rSndhjEx927vnWwejhmBd0rNI1ElGjIshYm7K7eH?=
 =?iso-8859-1?Q?9v7utGNOCdk4trgIr6vsPUC0gbvXcZ1LyOWXf2Lnj+dDWpOT0orywyJ/hk?=
 =?iso-8859-1?Q?HJ789ZHqgd/7OGInaiQBtcqB1Jlk5+0rLhxTY8yhDz+SISWnjV6D7izSex?=
 =?iso-8859-1?Q?9mAJCD5Cmz+nTwn71I5Wbb2OJutjSsn/1SS+OTGw1GfwvuiUCJJ04XW7Gc?=
 =?iso-8859-1?Q?7Qx73V6mlKa5YX4pma5EsI3RVs8g+hyeF9GGiDmydJyx+AJpawO3T+1sWj?=
 =?iso-8859-1?Q?RSfUKyx+Zr0bhIX7ZHEBe3913iWN6dsrYjEgzTWUrSv+lpiC2jXeXSbJL9?=
 =?iso-8859-1?Q?Rs+p52+XKCjnlKP2f/DFnI/WEQOp8ZrGt6WvdJ/SU4FSGOpL2YcW8SEON7?=
 =?iso-8859-1?Q?jpfLdU/2TG4omhtpJMbmWL3nf1idgAAcKqkK//wtbHbDamBhYCET4XS79O?=
 =?iso-8859-1?Q?QcGdOAcSnCeXLFpvh4WXk+W3Da4YW/H32PrTnebMHLtbiFsF6+1M9gZJf3?=
 =?iso-8859-1?Q?swOBfg0OWjYkEh29EX0tT/lLJY6AZjjep1tGtkB62aSRbCUXB9yb7qE1AJ?=
 =?iso-8859-1?Q?oNR3jliBPUtjKQ8KzQ+nuGW/rupbtlf7d9zcgKybMQfFkNGmcoS996mbE9?=
 =?iso-8859-1?Q?+U3W/sGzsJF05mVas3ofjUsxcWfdc8mZ9bnw7sAWTRyWU9hHL42eLjdu/q?=
 =?iso-8859-1?Q?UkPwd2TIbB3jxZ8P+qWozUP9C7c16Tg1GFLN0YT6PQwLGn+3PuXF40srV2?=
 =?iso-8859-1?Q?qXPTa6OlEbGBjjERoKuhncvVZ+la3TKxiLly5RrZZRdR19oKQm498Gsf1I?=
 =?iso-8859-1?Q?1sm6kQY6scOhZxDyPWN8VdxhEEChLtG9Frf0JYYWZNCM99o5IwJs799woC?=
 =?iso-8859-1?Q?4qFC9661jYRtY84k?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 04:31:46.0879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f100b21e-39b8-4705-e769-08dced9b71a9
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0801MB7742

This patchset introduces the Request Background Abort operation as outlined
in CXL 3.1, section 8.2.9.1.5. It ensures that only background operations
supporting request background abort are allowed. A default timeout of
5 seconds is specified for operations where a timeout is not explicitly
defined. If this timeout expires, a Request Abort command is issued to
terminate the ongoing background operation.

This patchset is based on suggestion from Dan Williams, as referenced here:
https://lore.kernel.org/linux-cxl/66035c2e8ba17_770232948b@dwillia2-xfh.jf.=
intel.com.notmuch/

(1) Patch 1: Enables only those background mailbox commands
=A0=A0=A0 that also support request abort through their CEL.
(2) Patch 2: A default timeout of 5 secs for mailbox commands
=A0=A0=A0 that do not have an explicitly mentioned timeout.
(3) Patch 3: Adds support for sending an abort when a mailbox
=A0=A0=A0 background operation times out.
(4) Patch 4: Adds support for the Populate Log command,
=A0=A0=A0 a background operation that can potentially support abort.

Ravi Shankar (4):
=A0 cxl: Enable mailbox ops with background only if request abort
=A0=A0=A0 operation is supported.
=A0 cxl: Add default timeout for bg mailbox commands
=A0 cxl: Abort background operation in case of timeout
=A0 cxl/mbox: Add Populate Log support

=A0drivers/cxl/core/mbox.c=A0=A0=A0=A0=A0 | 13 +++++++++++--
=A0drivers/cxl/cxlmem.h=A0=A0=A0=A0=A0=A0=A0=A0 | 18 ++++++++++++++++++
=A0drivers/cxl/pci.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 24 ++++++++++++++++=
++++++++
=A0include/uapi/linux/cxl_mem.h |=A0 1 +
=A04 files changed, 54 insertions(+), 2 deletions(-)

--=20
2.43.0

    =
