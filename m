Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0654E17BC9
	for <linux-cxl@vger.kernel.org>; Wed,  7 Feb 2024 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707303246; cv=fail; b=KEooyl5K7J72HJ6MgUSsbFNwU+vcSnlEBzOrfKqet7jqXsVzFhfzZUjbQdxGaP94EG3StlFdNKyLoX2NrWLeFtfCWCDICUoTg2RWHbO4CDaRwGuWl5eMbfOyCn0D+3E5OkVJPKOf1SAV7cvihpTHUwVSr3rTLNCGb3jGR8i0iYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707303246; c=relaxed/simple;
	bh=T9h/zIF22iL3bmCc815S6QdPQ5pg18tqKAonMaND7jg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bNyTjoBTnMZQagRn8HFCShLuNhnPwpAkigsjirem0ihggOl+rQ9LzcjpGZnihDBSgx7oTqNo7ujE1Jfn6Ulw75STS1hMVHZA9DhtHBiCQYcI7bpgTSdp/KvCsa0NsFc/fiQUJbPmuQ/rzKizsrMpUvL/VEmi68Wl/2EqTuLd75s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=EDT76XZx; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="EDT76XZx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3Zlrwov92l7z1yweLjWaMi7gErS6C4Gsel1seKWBaEiB8tJWDKWj4Anwlc5Fpgj6eIz2fmzkDdn+HN4XZ+h2iAAAOOrSCxuKk7JP288BFQdhziMVEppQB6MxXoTtVACeF8ie5xtCb/yKWQvtkqt4wcgzxazOhBH7Dm4Ty2kVP9FHJZQcgJmEiu88d8HPDpqfFSYl1bmz9JsGRkF2p+ZImpZBLXwAS+o5w67BrMfHHPviWs2t1xBlxhzTbj2Uoh2mqAfKlKyBpXyB8bKf/7sVGB5kL72oby8Wd9D59GETc1hSpy7p8NFpdk04YVtdTcn7dx3pPJSav55+ykWe4pRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIDM6c3NeEfmu7eT/oMHPdB6lGHAE+xoB6fx7gxCD3U=;
 b=CQ8diFVx0W9ml1HGrK3UC2BDQkSVSLsn8rMHBa53yKNdFMVf+kHqz0U3xjgy+N3FXRm2p5I7TjHwYaPb9WujUjyhvqIOwgkWXbKhAha7djoLHLMbW+AX9r+3N/yGNetoGU2YNuLcpiVThFO2inscD0m6EAXxu140u7Us1NscFr9hSOQIAFjKnfjtn55X1V1hFNIuz6ZGHcuGQUy4JKYi7X6ATkRzivDKFvLh0y3gNYbt8Rip/7x4KKquWVYsx5DlRZSqJMUYIU2afZ7EZy8tp+deqvI9qA7wRU+1oVJBiScPApd833Cfydggwbr0ssxsDy8EivLbF67ubyCCsbcMXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIDM6c3NeEfmu7eT/oMHPdB6lGHAE+xoB6fx7gxCD3U=;
 b=EDT76XZx/HFgvPCRET5zWd3aso93EpP0wChRkb2kB/eOMLmJFiXnt1GJPZRnKjy/0fOlo5v9aC9FMI7PfccXgXAEVB1T4QPh3GNXm6j8+5bH9No5DhQu3p/IrkMJACWGVZsycjvcoipXpnmdENiNq8JDhtsV2ZZw4snX2/rifNWb49r8bZk/qAq/pj+bYjOfu+lhV81A+K6O21CfphVfZOHOhWMpkC4aCdD51kCxIBYpEB1wibwWu8vqoOIAjBJ6jPOXfcBqFo8VcSVdeaXqLSexJzDLlyru3Pit4B5ejvY0xjVe3GBGrVAv3GIyhBRQPkvmRcUFrmVb3USCBEswPw==
Received: from CY8P220CA0045.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::18)
 by DS0PR08MB9465.namprd08.prod.outlook.com (2603:10b6:8:1bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 10:53:59 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:47:cafe::9c) by CY8P220CA0045.outlook.office365.com
 (2603:10b6:930:47::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37 via Frontend
 Transport; Wed, 7 Feb 2024 10:53:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.13 via Frontend Transport; Wed, 7 Feb 2024 10:53:59 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 7 Feb
 2024 03:53:57 -0700
Received: from micron.com (10.68.133.96) by RestrictedRelay17EX19B.micron.com
 (137.201.21.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28 via Frontend
 Transport; Wed, 7 Feb 2024 03:53:53 -0700
From: <sthanneeru.opensrc@micron.com>
To: <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>,
	<sthanneeru.opensrc@micron.com>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<john@jagalactic.com>, <emirakhur@micron.com>, <ajayjoshi@micron.com>,
	<Ravis.OpenSrc@micron.com>, <sthanneeru@micron.com>
Subject: [RFC PATCH] cxl/pci: Set default timeout for background operations
Date: Wed, 7 Feb 2024 16:23:49 +0530
Message-ID: <20240207105349.301-1-sthanneeru.opensrc@micron.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DS0PR08MB9465:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ca0fcb-1b2b-4c80-2a27-08dc27cb16ff
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Of5mQAwvUMjN/iQxe5Plx+ALpZxyX6JSRa3m2EGU1BkNviG5j4p5wShYGgW1RJVbVuuorKSQlKtwbmJoz23ri/pAGrgOYCOykv9YXdMyqAKIpQBuYIhB/16FmLPAC/Tb6Ka4tx7RjDndDTy0iMlZFuMfaa0eqQOydszYL7Qp3HlaY2laHvbVBSoA0ATimoZRuVHT2U4PfD+34bTHbueA0AekpDimdb7F+MhO+Q2++9JEqtes7f7MF5EpE5SR6xkGx30iv8PQQKEJVy6Ho77tUKhmFU8JpGPlIld8Ec5O120OsGv9Vwb/D0MSXhPzYOR9PPIY9dHFaxFFTiTfp11YzLyZppIG7CM21rC9uoMJvlNd2rdmFpLuMOggEiR0JTr3+P+pzNxOGMvwcQlCp6oocGJgCU4WAcMDdQkwpldABPBa2xPeoMnQmGRGCRZaXLiq0KlBxpvEFR0AeooUlfuOq4ZplQvavfjvtRjSyqDgN3mYBF7VQNGWDq2muorGZ48EquWMTW/FeppQ4V4phVvWDaMP3Sbkd/AGwv4wT8HLgEA1wYuDaWoD/H7Pp71YLpa0Qq8BgcxbjE/3ai099Jd6rgas3lWiLNkLgpp7+vbGapKwmfrC6KwA1QiyETx/armTtaNnr8bOj5RPIGbqG8yynCG/uzEOUozp6GsOTfbNQPJ1cVWJCS2DQ7Drgzmy/S6ZQ7b5loUkIHnw+icC+TjSKt3kpYHlqmFHWoz5ISd2a+5HQE2E3wHJZ41YaXY3Yvy7
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(40470700004)(46966006)(36840700001)(86362001)(2906002)(2876002)(336012)(83380400001)(426003)(1076003)(107886003)(6286002)(8936002)(8676002)(2616005)(966005)(54906003)(70206006)(110136005)(6666004)(478600001)(7696005)(316002)(5660300002)(7636003)(82740400003)(47076005)(4326008)(70586007)(356005)(36860700001)(26005)(36756003)(7049001)(55016003)(41300700001)(40480700001)(40460700003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 10:53:59.6495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ca0fcb-1b2b-4c80-2a27-08dc27cb16ff
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR08MB9465

From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>

The CXL 3.0 specification outlines background operations,
and support for handling these operations was added in following patch.

Link: https://lore.kernel.org/all/20230523170927.20685-5-dave@stgolabs.net/

Mailbox commands like ‘Log Populate’ use background operations
to complete the execution of the command.
This can lead to a timeout, since there is currently no option
in the ioctl cxl_send_command structure to specify
a timeout value. The default values being zero can lead
to the driver reporting false negatives to the application.

This patch aims to establish default values, enabling mailbox commands
that operate in the background to continue functioning even
if a timeout is not set in the userspace application.

Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
---
 drivers/cxl/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4fd1f207c84e..82bdff55bb8d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -40,6 +40,10 @@
 /* CXL 2.0 - 8.2.8.4 */
 #define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
 
+/* Default timeout for background operations */
+#define CXL_RC_BG_POLL_CNT		40
+#define CXL_RC_BG_POLL_INTERVAL_MS	1000
+
 /*
  * CXL 2.0 ECN "Add Mailbox Ready Time" defines a capability field to
  * dictate how long to wait for the mailbox to become ready. The new
@@ -312,6 +316,13 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
 
 		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
 			mbox_cmd->opcode);
+		/*
+		 * Set default background operation timeout, if not set already.
+		 */
+		if (!mbox_cmd->poll_count)
+			mbox_cmd->poll_count = CXL_RC_BG_POLL_CNT;
+		if (!mbox_cmd->poll_interval_ms)
+			mbox_cmd->poll_interval_ms = CXL_RC_BG_POLL_INTERVAL_MS;
 
 		timeout = mbox_cmd->poll_interval_ms;
 		for (i = 0; i < mbox_cmd->poll_count; i++) {
-- 
2.43.0

