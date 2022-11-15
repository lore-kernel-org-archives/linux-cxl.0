Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2E0C4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 15 Nov 2022 10:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiKOKd7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 15 Nov 2022 05:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbiKOKdt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 15 Nov 2022 05:33:49 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F601142
        for <linux-cxl@vger.kernel.org>; Tue, 15 Nov 2022 02:33:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZf2jCaxJD6TiLtzHy/N5N/6Iq+3GLLkLP3eaFxBkdFIMilpdjPdeBtLtCtYQZPO7iGX2HtGs6ccWY9AmWJ+TXcYldmSy49ID9pD2sHt1CfzO4UkGAlUDCNYpsmlxQvACqwJKF7Jc38rvUR2o029xI8BadgIeyk4oggp6UNM4BV9+7TQ7E3guc44FKLthtiPLOZfwuFA9gn5sMS00VJDOc9qRtl6I89VQcuPtZ52Tm/qFHOJyss8UncGtfV9e1n/sPAGoZ3zAOumHmL7BNoH2xYm1QhePVu2r6QxmtZihJrl1sEb/xu9Pxq2b0rCWGhmCg9Taq3JDNp5EHFTuWTFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11TM5zBMqMoPgMg2q5cV47W6T+WQAmRT49U9OYZ+u2M=;
 b=TN99/h0UivrO4hQyHrsxjmzVR5y4t4Nr3rlsL0g5PUyLoOajSKjfKxFcITohe1CrmquwylPbJSXGfTbljbxrzmujdmgDdTK6oM5ocNk+TDNRFo0S+kH7op0sXOslYpZoSlAxNhEdu/jR+IHFvuwULQKmdzoyha1jzg0SRnhyQrRDiGUflSuIS/BlSI6605cwa9+vqzUplvpK7YCu0uswC23FFj3ZjGY0u/c/bUzj4Jms4XL+lQSXnu6sIQPddPgiw3vE4qtNOoqeyy0EddOe+ch4OcAmGV0N49c+lmWfWfGWXelRHM1pO6ot1WDeB8kjwha7ot4r1sudpAxraFagfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11TM5zBMqMoPgMg2q5cV47W6T+WQAmRT49U9OYZ+u2M=;
 b=a16K7WLWRO7Vgh+YZWB7IiaUz94L98UdGNGLaql51y5kUkqVnJEx+TRAhk9eOPrSeDO61ylP7+5F3fE0nMT7lI1BLAgKeFjxYAcKi5ARbNEvRrfSOpjvzELDPYEftMb0awlZb6+m72cnZoOKvbTZDfthV+ZR7x34kYMpMD1iCRo=
Received: from DS7PR05CA0067.namprd05.prod.outlook.com (2603:10b6:8:57::12) by
 SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 10:33:46 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::f4) by DS7PR05CA0067.outlook.office365.com
 (2603:10b6:8:57::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14 via Frontend
 Transport; Tue, 15 Nov 2022 10:33:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Tue, 15 Nov 2022 10:33:46 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 15 Nov
 2022 04:33:44 -0600
Date:   Tue, 15 Nov 2022 11:33:42 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] tools/testing/cxl: Add bridge mocking support
Message-ID: <Y3NebjaQzcHTvmtk@rric.localdomain>
References: <20221018132341.76259-6-rrichter@amd.com>
 <166845667383.1449826.14492184009399164787.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <166845667383.1449826.14492184009399164787.stgit@dwillia2-xfh.jf.intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|SN7PR12MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 423fc91b-fa5f-40cd-de59-08dac6f4e052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N9NeVOKFIjJtHT5BRd3Y9VoKm+BaKL440SnykuEVjEMaHB0Reyft6v8knikirTTPXpLD2WhLQMguxNq2o6ZJAvHqZt4ZzS7qsoOOi2Iw6foQoVnHGNTk6QOIWWcz7tDt+HmvR+obUhJufN/Kf4Tv4ArOetTiHoFmxwa7WVw33peBTTUkpGNtX9l7jsJDKX9RX3Ea9TWLVkCgkjI5Xj/EuZaKKwLFVmJJHiwAAeePlpBOOaHyncDQVkKPM1qV1EJV0SE+X7MzwRLZs1NwnSXGKzSxVtzKWnpHtKg6HHWAajrmQxjtnStM4/p6A4hscIKajjIm9HpTj+6H7zhYHVUNBo2DOHwDbpw4mcqRBNDJnyyHbT2eks71gEXVM+/iZ+uZe1RXaFDC2bGpVfsjbu5GI0IqYHaFTfRAEjFZkdPJRa3UzYnGURPpgt/u8y+0o019WoA8l4xM3wfNzfeP0nS/IL+rYIoczFwtjmwX46myhN2k0FA6qYM8eAZI5eSNHx2aYfWjpouCyfipyMyYsxTvOKMQyY2JKiX6Eqf90kUIz20aoQ+M6aZYgX9LzYrZmfgFfXBP9/6FEDJabTNd3a9roHvlQ8sBL++5Ou2Vpoif3D0p2yCGuUtYlLAlIiatz55luWXQ265SgHSvCme/PK/OQNG5YW4KRSTicnIcIwVo1OTDW1jUmK5fce+tPf38NIOEGJe5smw1OuHnOX05z+pY7wYWyq7ghb8h/XuwdSIGUl+wb5cVrit4+s6DkvjtHk515aBBx2S/ksfxPEmIaEqoIiidBzEykBlff7wimhgnbcpamLuM9WVRcTYOj2RnwcGii3BgLkrPUYo9M+HOnbEq7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(40470700004)(46966006)(36840700001)(9686003)(55016003)(6916009)(316002)(53546011)(36860700001)(7696005)(81166007)(2906002)(356005)(40460700003)(26005)(16526019)(70586007)(4744005)(8676002)(186003)(5660300002)(47076005)(8936002)(426003)(70206006)(41300700001)(336012)(4326008)(82310400005)(966005)(478600001)(40480700001)(82740400003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 10:33:46.3256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 423fc91b-fa5f-40cd-de59-08dac6f4e052
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 14.11.22 12:11:13, Dan Williams wrote:
> In preparation for cxl_acpi walking pci_root->bus->bridge, add that
> association to the mock pci_root instances.
> 
> Note that the missing 3rd entry in mock_pci_root[] was not noticed until
> now given that the test version of to_cxl_host_bridge()
> (tools/testing/cxl/mock_acpi.c), obviated the need for that entry.
> However, "cxl/acpi: Improve debug messages in cxl_acpi_probe()" [1]
> needs pci_root->bus->bridge to be populated.

Patch looks good to me, though we might want to move the
mock_pci_root[] fix into e41c8452b9b2 or on top as a separate change.

For patch logistics, could you merge that changes into the rch tree as
a new base? Right now I have cherry picked e41c8452b9b2 and this one
as pre-requisites of my series.

-Robert

> 
> Link: https://lore.kernel.org/r/20221018132341.76259-6-rrichter@amd.com [1]
> Cc: Robert Richter <rrichter@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
