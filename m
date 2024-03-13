Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32A714A8C
	for <linux-cxl@vger.kernel.org>; Wed, 13 Mar 2024 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710313953; cv=fail; b=GDcWHx58orBOHwNa9d/MWlB5FVCKzErNKtJjaehZkX67YVS/5o74JLkUtfNh+OVbOVjg7lQqVFLRqCl/rMY6tS+bBd+uED4CUMqINNAve0c4GkwMAlE0ti0SGJG6T2l8v5IiGFNLmb9PFRcfnY9oLdWxyk9SLERP7tTDmdGZEKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710313953; c=relaxed/simple;
	bh=8Ktfg66/i3Zbu1emOI5V5OB1RqqxPpCUEDJRj5WrJ8w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nNMwiSrGvrDs2U2/zygsGdM3zjeW+TTBoYI1rqrJvn5qYWeqnGdZBWrx5bzaOHsRh4Knvw6NR0QrKI8QDv2CUZ3Czeq9uTY8XRj2E03eRtuCKcA84akNl4JZgpkrDaMWiItUZankfR1FOsqnNc4Q+RjaCILlK0fRgnAjhBwM0bQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=iLSSg0Ng; arc=fail smtp.client-ip=40.107.212.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="iLSSg0Ng"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlW63d/eh4H78VyeZsaNSOIkUvKnS3pZdHdb07ykSjAyHp1gH7901dfMUf4h+aZzgTJNVOf1hPjCloq2qRCiIcw3SKfz2c3a/pTf2HTO5+1DDnXy7rXqjZxV97+VqicgPg4CpqpApya+J47uc6yBSp+4g79EXtCVBr2ouLSwZ9CCv1EGfMjYVOugvxREY1n4iQm1gLbXxLISgn3M8m3fNia10qn7t+uLYUMrKMlYqtaYuQJRNZViSLsNqrIYmaVGghy/8+DbUYVupqHg9zrEOeSHZuCDW3F18JTQJJaZy9FnnS0tz6o+a/s0FrDbwHuy5QJ5AyKe1w4vua8ROTzxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9PyeiWeZ0yGvJXmf46NJjYvZthGx3NDYEdXFbk5mP0=;
 b=GfkYjhoqlKfGtRshcZsDwmMeNL5QyMfNvrjv1a77IzlW9/wK0W+B4OHC4VhbiKLRN2kkYZ9S2D4dDVVMNohfh1rQO2E1pCtWFRl9M1Xeo1+jpucRIqVXATC5zvg2DjZXyp4O4yNwVwStlU6S8LquPyLI5FQ8gpiUHPD/VHQsqVnGGIM49FGXDAbUcMWMuhKdo7OsbS79dV9/Bvc1SgZYtaVcl4Ww8Jy2d3856nIYeIo6wMMF8oTiBZLpAoLgPz4iIsMA7QK0cRIpMTZkJ0TRHxTi/m+SV0dfsokrFNr4rCaFjWknPFg6OU3IIRkaf5lAOssvr4K4w1F7XSGCKh3rOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9PyeiWeZ0yGvJXmf46NJjYvZthGx3NDYEdXFbk5mP0=;
 b=iLSSg0NgSoa25yWrK0FlFQV7icCnosOQRfdLWUiKNDe0lhkiFOSEkAI5uRHsNeoncEoOeP0j5ayperSYIQh3uDvQWaPmODK/6j0IiEhsX3vH/KNV3z4LTaugU8mRmdt2XRRfFgVWEZXw6ncV0q83Ny0F3mhGMmHmKUOMzgIzAE7vgFZHsrjUhd/DeZg1DmCwZznAi+utWhHT0KXwhi2YFy0xgRujTiZcZocnTjqNFnXJjbQjMsyObyHlrog2ZihRxrmFdIYz2Zxft5fSi6VyLX1bKDwgKYsAUpdY1CL38SC9UT5mgzMNgNV3mI5jkMZZLHK3JVt7JExYmsR2NBNKjw==
Received: from BL0PR05CA0007.namprd05.prod.outlook.com (2603:10b6:208:91::17)
 by LV8PR08MB9698.namprd08.prod.outlook.com (2603:10b6:408:1fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 07:12:26 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::22) by BL0PR05CA0007.outlook.office365.com
 (2603:10b6:208:91::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Wed, 13 Mar 2024 07:12:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 07:12:26 +0000
Received: from BOW17EX19A.micron.com (137.201.21.218) by BOW17EX19B.micron.com
 (137.201.21.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 13 Mar
 2024 01:12:24 -0600
Received: from micron.com (10.68.136.12) by RestrictedRelay17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28 via Frontend
 Transport; Wed, 13 Mar 2024 01:12:21 -0600
From: <sthanneeru.opensrc@micron.com>
To: <linux-cxl@vger.kernel.org>, <sthanneeru.opensrc@micron.com>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<john@jagalactic.com>, <emirakhur@micron.com>, <ajayjoshi@micron.com>,
	<Ravis.OpenSrc@micron.com>, <sthanneeru@micron.com>
Subject: [PATCH v3 0/2] Add log related mailbox commands
Date: Wed, 13 Mar 2024 12:42:16 +0530
Message-ID: <20240313071218.729-1-sthanneeru.opensrc@micron.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|LV8PR08MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 07185785-9c0c-4970-9d50-08dc432ceff6
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cMzAWbo3N/0IeYTKBf6LkKei9JcRvH9qf51jt3ZD/mLQtVVtI0LkKFY1mgvgbuqZjm0bve2aD+GOVJEvHaQ34I9tPJVmAd5skoEayMJcFfqQpmjjVj0dD/euxQiXlDNVvvELwkkQvIq6fXyX99tdOqmKHAjlr24VB+6F7M2MAiF39uPuNJEyN9tmz+KureaOgKvuaBJ+34d9UQsCfp9lj9eqGfYGKwLwAIyvOraUU3Qqq/NNkjEVKeP0Rxgvgy65DcQvxT2o9bbzkgmzF4BmtxkwTUIihiowrk491Gi+kF+1ptyDo9ephlwrlvHht0WiZWiq3CFWpFaafa4ZrsJAkFX9nu6U6HaPib4vy44ZIPYyAyhpmvo608gac3191RIsXxjOQwHk+z55ZEdPGRBT0oN+OtfupzZSYcAEFnxh/yaeQlMS/dobKQ8OM+pkO5DOHnxFKbF0YAbRDQWQ7gHcBR0LEl3DhlY4iYMX4p4oN4t4w4Kam2IfT7352ZRnLbccWVsERQJyWGV6PQckJ8+8CQ0fJk31vJ6Q5afZ/LAourd/siDIKDxPlakNR8R8eurhpJwjMk/ZBmxDIPaDTUjZUTIwEk8diX4J+U1O2zRcCgn4bEYLDwz+f8Lkqr+KJF8ydPfm/mXUY09ulUnWMGYkFc8yAfQ/pWdIfAovyAIcEYXSkkCLRetPX184zc5+G5q508wtjzAwFs3fzxWUBna0cw==
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 07:12:26.2056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07185785-9c0c-4970-9d50-08dc432ceff6
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR08MB9698

From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>

Add support to expose following mailbox commands to userspace
for clearing and populating the Vendor debug log in certain
scenarios, allowing for the aggregation of results over time.

1. CXL r3.1 8.2.9.5.3 Get Log Capabilities.
2. CXL r3.1 8.2.9.5.4 Clear Log commands.
3. CXL r3.1 8.2.9.5.6 Get Supported Logs Sub-List.

---
Changes in v3:
- 'Component State Dump log' has several caveats for ioctl()
   not being a suitable ABI as pointed in v2.(Dan Williams)
- Remove Component State Dump from Clear log filter.
- Implement a seperate patch(yet to do) to address issues as pointed in v2.
- Link to v2:
https://lore.kernel.org/linux-mm/65e631951ff61_b62b294e1@dwillia2-mobl3.amr.corp.intel.com.notmuch/

Changes in v2:
Suggested by Jonathan Cameron:
- Add description for exposing these mailbox log commands to ioctl.
- Create separate patch for 'Clear log'.
- Restrict the ‘Clear log’ action to only apply to
  Vendor debug logs and Component state dump logs.
- Rename get log sublist to get supported log sublist.
- Link to v1: https://lore.kernel.org/linux-mm/20240207103634.199-1-sthanneeru.opensrc@micron.com/
---

*** BLURB HERE ***

Srinivasulu Thanneeru (2):
  cxl/mbox: Add Get Log Capabilities and Get Supported Logs Sub-List
    commands
  cxl/mbox: Add Clear Log mailbox command

 drivers/cxl/core/mbox.c      | 12 ++++++++++++
 drivers/cxl/cxlmem.h         |  3 +++
 include/uapi/linux/cxl_mem.h |  3 +++
 3 files changed, 18 insertions(+)

-- 
2.25.1

