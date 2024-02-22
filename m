Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93E614C5AB
	for <linux-cxl@vger.kernel.org>; Thu, 22 Feb 2024 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622656; cv=fail; b=IKPSXlMEOT7pNDkFZ4hWotD1mpQ3bpYGT6QEHF7Rez+D5RlHi9WTyOg9HSlyN77BqGG36jjQ5iTK5eM+5BpIDXr1gIosGOmFGl2pftotUcYOgdm4wKlIO2Wa6EDiJCpcJ4+gxymWGWK2rC96BKGiiSdOIKPxcwejnn4HshXRa08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622656; c=relaxed/simple;
	bh=5c/7xnens/vY0g0isotSM0seU4I7PKOZm8JkXh6dC5A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qsd/fo2d0XQu24a3uoP7upoH07C/31hd1rQY2na084zOUVd92JXUhcE+Ri36Md0G7ECS0sIQnPteEUIvXXD82Sw2IFhV8S6fdLff7n3xxWdvbYEs5F1XmcsOnGpI/ZnnZzEii70je5u6hwf5bPyIkOAIp+BPz4qazBsLVtoMMdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=jdfomfw1; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="jdfomfw1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTZocoHiiVD2lPjHMucMySMKE1A6QgPPFApXxtZiBqKDwxbR4xfKxl56B2IKcFLPA6r5EXq2VfEGiAKjjD3NpkZJAx2ifl6RDfJ4B2LBbfXS0m9g7nTJwLAN17dZGS1X8YE6FcPPDfDJTTx+qp1lDwTys9nUUfUF8dTraxX8wISm0+ExaFvb+EwqekYasuEPfUPETI0EfX9tHQEtbzA3t+f+7WrjOo54UD53NC+5Kg8oG6JgiImnH21/DHlsN0GPkWR87jUYJdPN26qHa033Efr4pkASEi5EhKp0wVTgSaWVo/kYADsro20Qir+rKps77dhWoDzOo6Wd7waX4e/QIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuWhdQOqlezmz3qxBPu4GdsWgw2q0aWTUi/R4/o2MlE=;
 b=G59mizBHNMR7B3kSR+lUB48c3dTI7B9CqIEGYaXUBKeNOTCpubLgAWdClCvez3V3eIkYOimzhTWQZaxpn8eT7+GNlGSw72EVwQJ2Uet+jT0ecRv+odemeVTUE9tLDoa+f8I6xD63HSCJPVbqJY++fxhGtBzY+aNrekiA0w6L/mCKpn0CZEQ0zsCrT/Knze0WlSwLzx3lgeQuApHZmVzK8Os9/cpKZ1Pb1pd+HM8obJYFlYJjk1TZ7YENy7I9icOVNx1OpmUzI8/8pQFxiLcXp+ajStrpYVJoOx+3apg4B1kPMT/aJJdWqtNjXUPby+nYwAgpbQMsAf4P1IqjDd601A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuWhdQOqlezmz3qxBPu4GdsWgw2q0aWTUi/R4/o2MlE=;
 b=jdfomfw1aTg4qCp/Dx8B9tGWkjuhZSlGvcJs4lydp04hclGEJmTkdhkSwtxbM+jZslXoXIVWHn0E1gR9hxbaMUc60JWtmF+d7jW064dDGXHahdJVm4U8avQTzj5+74QqlFs8sOxubYJAgv4W19D+t/Qsg887NZkWkh0+D1syfJPLpcHmrbc+XYi92HLtXO9QcwEvhpgmCUNQuEbiN18XH9JfhKN97QIhfA25D9x89MwWjcUfFV3Hg+XrvF9yceZrrr9EJ+8RJOg329YegWrDasW0bBqXpAkJZUYGNNRgWlzBGqYT0nfhIOKDleiU4rKmy3+PLuLLi9q+rxhxyl+8uw==
Received: from MW3PR06CA0030.namprd06.prod.outlook.com (2603:10b6:303:2a::35)
 by LV3PR08MB9560.namprd08.prod.outlook.com (2603:10b6:408:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 17:24:07 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:2a:cafe::3b) by MW3PR06CA0030.outlook.office365.com
 (2603:10b6:303:2a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.41 via Frontend
 Transport; Thu, 22 Feb 2024 17:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.0 via Frontend Transport; Thu, 22 Feb 2024 17:24:07 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Thu, 22 Feb
 2024 10:24:04 -0700
Received: from micron.com (10.3.107.163) by RestrictedRelay17EX19B.micron.com
 (137.201.21.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28 via Frontend
 Transport; Thu, 22 Feb 2024 10:24:01 -0700
From: <sthanneeru.opensrc@micron.com>
To: <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>,
	<sthanneeru.opensrc@micron.com>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<john@jagalactic.com>, <emirakhur@micron.com>, <ajayjoshi@micron.com>,
	<Ravis.OpenSrc@micron.com>, <sthanneeru@micron.com>
Subject: [PATCH v2 0/2] Add log related mailbox commands
Date: Thu, 22 Feb 2024 22:53:48 +0530
Message-ID: <20240222172350.512-1-sthanneeru.opensrc@micron.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|LV3PR08MB9560:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6374d4-67b0-429d-fc77-08dc33cb1317
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vorUit7nLT2YwnK2gZincXhXEEL9EfW55lqVtBQN6zWgp//LPb3yBbjgLZS8SwX721JoAh3n7RxxvQASkVA6jR3VHVVzqbM/aiK4OnKlYpEXSv0fwbeVEz6QycrsPDW01IicTwqkWKgNB+qCzdgLpIPxdN/AwAEUDjv3k52XszMryOlWVp6WppJOAtElu7iToOXCE8+NVww4o0nUfmff4vBDWCvguzvipq03bb0X8oW5dDHJsSWGx/fvlhhEgFkl0aMMbayUlKNVfZFJ34rR1IFKhCteqNH+ae5uDxTYJ1N296AowBN1M0vlELhlcxUCPSnfA1m6BxTs9HMTwssTJjnJ3DywDD451x+x911sxFcVwALq6KFhbInp06OPUrpCkzXYU9HFC77EAbG5YdEurf/zo+tNAsxW0P4nmjxjbEB0mS8CEw0pwQZeUlNTulHMEG0Wd+vhoUX6wXqRf031FtC58KGp5y9nT2Ob3G/bizCxQBg4ISxxs4kQRpKGRK46HFK+B0uk7IeK3McG7PHT1mVO5iewqtGfbltTMES08XU3gvdOqcBVL90Hd/Ejlrr1feeliEC433ND3kUbaaMiHPvFUu4h1whKbRyMLxJRzPioa4Ko85mBYC49yBsn9HdBkcl+xNqQPxBf0qhnmIf78w==
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 17:24:07.0390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6374d4-67b0-429d-fc77-08dc33cb1317
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR08MB9560

From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>

Add support to expose following mailbox commands to userspace
for clearing and populating the Vendor debug log and
Component State dump log in certain scenarios,
allowing for the aggregation of results over time.

1. CXL r3.1 8.2.9.5.3 Get Log Capabilities.
2. CXL r3.1 8.2.9.5.4 Clear Log commands.
3. CXL r3.1 8.2.9.5.6 Get Supported Logs Sub-List.

---
Changes in v2:
- Add descption for exposing these mailbox log commands to ioctl.
- Create seperate patch for 'Clear log'.
- Restrict the ‘Clear log’ action to only apply to
Vendor debug logs and Component state dump logs.
- Rename get log sublist to get supported log sublist.
- Link to v1: https://lore.kernel.org/linux-mm/20240207103634.199-1-sthanneeru.opensrc@micron.com/
---

Srinivasulu Thanneeru (2):
  cxl/mbox: Add Get Log Capabilities and Get Supported Logs Sub-List
    commands
  cxl/mbox: Add Clear Log mailbox command

 drivers/cxl/core/mbox.c      | 13 +++++++++++++
 drivers/cxl/cxlmem.h         |  6 ++++++
 include/uapi/linux/cxl_mem.h |  3 +++
 3 files changed, 22 insertions(+)

-- 
2.25.1

