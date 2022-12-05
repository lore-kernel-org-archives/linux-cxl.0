Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D27CC4321E
	for <linux-cxl@archiver.kernel.org>; Mon,  5 Dec 2022 12:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiLEMDK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Dec 2022 07:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiLEMDJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Dec 2022 07:03:09 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B204A11158
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 04:03:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyfmP7mYnedZm9U0x4j8W2eg9m1CE9nECEn0HgDUWo8Q4DvsfuF4ynvOKwOVRQ0jwZnKmr312tMM464hv7htXH14GyxidAvyo52Al5zaopXUAe9qbkQLHIlxfNYOBhh/vOEkciz4Xezuz3U1MW8in0rQHguHP5KwmbjeK1szOKheIdl493iry5BLrVchqWzYLRrU/enL5eH7Eif1AtWOH1v1IBL58gOLT5UWaUC+MGTc69i7w9A8fabggBDN7XiwV4hu25DhawznEB4CtRmBkrMwvJcfqyLIbJlb8B91DBE4Im5i/CtZVEPcWdXMOhz6zGdNzlv1EHsV0HG2anHcxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuz8ea7MH9PxJ+jIHekjUONp3GhEKeYJfgWHfEjorhk=;
 b=bbupR37SpH+4elt0DVveUup0LuJF4W/st0gsgcu7EHmmReZ0NJ5U54PH88gsp6B4IhX0ETPbVtXASLpTLCJfRKAYAcd2wcPMbEhc8/uvAD0S3EQvkZyB4gcm0R4QMr7Z99am+wwtEPmdzzvRlmTKHLjwaNkuP5SKJWTUEE2nxuEzjEB4q2iC5WA7xv6c1cXa+BYnUTLQRTjKjxCU7Qa6eKAzRHgkkDkasRfjf7Cmsu/MxZa4DDOki3TZIp7L28Ajm/14Y3q26unW7d7EgkOLrtmeoKk8z+5uzsBh8kzZES2bcv+ovNiD5MnvFav1MM6pkVTWkcTXc3f04qAZLhSKyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuz8ea7MH9PxJ+jIHekjUONp3GhEKeYJfgWHfEjorhk=;
 b=J5V8sSH/d1w6byVrYrCz0l2kqIndl4Q8GjKKdeOKlXTBzf25hOHKoBkXJMVcDyt74Po69X2qIPmIlHuoV25y0MIX8lnrv3LpRTMC1cL1V2+JRDB/SRpJVqZoKFRWcKRCKcCDl/nH4MCjT4jY86eRJ5jgo5ZZ6uxNHsNbYOjpktM=
Received: from BN9PR03CA0163.namprd03.prod.outlook.com (2603:10b6:408:f4::18)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 12:03:05 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::12) by BN9PR03CA0163.outlook.office365.com
 (2603:10b6:408:f4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Mon, 5 Dec 2022 12:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.14 via Frontend Transport; Mon, 5 Dec 2022 12:03:05 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Dec
 2022 06:03:02 -0600
Date:   Mon, 5 Dec 2022 13:02:58 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        <terry.bowman@amd.com>
Subject: Re: [PATCH] cxl/regs: Fix sparse warning
Message-ID: <Y43dznqBLltQ+RXL@rric.localdomain>
References: <167008768190.2516013.11918622906007677341.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167008768190.2516013.11918622906007677341.stgit@dwillia2-xfh.jf.intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|CY5PR12MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: b5708861-73e7-454e-0f46-08dad6b8aac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0VTx/DeEsEWQntXA3aO/vn04h1Bw4VjT10ukxhvqEP2gLoanlXUAc4djv6OcnpkRVR/6VoKBtdYoRalnr4fReP3M+t6eS5u2YhkRqmpPsAE3jbqG5FBOWWwQpzosBPBUOe4Ez/zXU1Dh4J9KG/P3IPaPhAB6ozxdGZxyAl/EwJ6gqOofO5JbMDf5S+dRz7/4qJ0CZqsoxYR5hYKkq+0Hvi3c2t9x6OkwkjD3noe5HQfqoEb1rxEGBkEauuRMvcGoRDktIdgp/qdH/v3HJWroqUgS2sP7yesOSEp6kvXkUECDROvLTOWp1P96bg2k/CmEs/dgFMUHfWYxQIJRj+IaFdcqXQl1P4YXmPWRfJr4JxhpBWW+wXSf8jxZne7lnp4NT4fL+rR6vMvy9XmtnmQaxVNmxSmeQjtsyLGtOXF1fodT9WsMLKkCdsBIsQosJxvM+YzOGMfOhuZhoKrhHsXXlTYe7+Pg7mXG8vEYIU1T40wfC/O52QEuGmbpF1hDcMqc5974S8jUWlzRxvuOd8IfTvfEYHqK9oFHvb7VsSbUxOjnPUEvdoVppkDIPCFvI4MJOdXTd1ZTZUDhgvm7r9Ff2D7FMj2HIW9NvMWHJyEiPbEn0EKfcaIe3V/OOL7tVuD1eylTOmlmpnIyP5DHVEZzeA3pJfP7SUtzdHL3Fvgtc46XGGfrHa0mGPH0F38EFp9Uu5vFujRd0KFexeATv5xBP3IaDEyxD8ePqUhhLD7S3RapYZIRgboLGyO3ewpxhjqEkSmdlzcfj87rfP/8uHsZSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(16526019)(186003)(41300700001)(336012)(356005)(81166007)(82740400003)(2906002)(47076005)(83380400001)(82310400005)(36860700001)(426003)(5660300002)(8936002)(40460700003)(4744005)(7696005)(478600001)(6666004)(9686003)(8676002)(4326008)(26005)(55016003)(316002)(70586007)(70206006)(54906003)(6916009)(53546011)(40480700001)(67856001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 12:03:05.2983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5708861-73e7-454e-0f46-08dad6b8aac1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 03.12.22 09:14:41, Dan Williams wrote:
> The 0day robot belatedly points out that @addr is not properly tagged as
> an iomap pointer:
> 
> "drivers/cxl/core/regs.c:332:14: sparse: sparse: incorrect type in
> assignment (different address spaces) @@     expected void *addr @@
> got void [noderef] __iomem * @@"
> 
> Fixes: 1168271ca054 ("cxl/acpi: Extract component registers of restricted hosts from RCRB")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Robert Richter <rrichter@amd.com>

> ---
>  drivers/cxl/core/regs.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
