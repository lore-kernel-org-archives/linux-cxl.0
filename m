Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC47C05027
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 11:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbjAZLrt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 06:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbjAZLrs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 06:47:48 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3BE46AA
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jan 2023 03:47:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzhahjUHD4fd9up15wo7ZGrvr4VVM6pjpk7RuCFOJA9Ghzfl7S19qGdyGdxaLNHuVRk7sUzCycHsqIopZWmdpiyi3Myr1daEg/wscIsMIpcjtY3xuuWbHXwE0T8bZYalcAGrLUzmV74hWqlMMf9ZyvvwbrppvH732jdnV4lS0aiMHnut4mriHDc0mJKmjoLWYumDJscW4ywIfxhLT4qW7YEMr76QaTS1doiqfQhQI+v8eqrFDEay0VwjMaMTJB49yOVXSOpj3hOUVhOVP4RPcll3nQNi7+e7Ek6e1h66OxsBbSMfJXyQHpxfMzy7uj3yXXfyksSzza/cLrJlkNjxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hu8C7lbXi+xXuJ+UeJKHTzXf08u1P+TWS/mlNYMYhK0=;
 b=BTi9irEQWrD5WNg+Tlkq/X7DU30RP0cA17K+BrvPb/ebvYxcUJcm1c0vWVD9hKoYhlye4OoCRUqyBDyWNx01KrXuXg3tqSxJ6lfIEbuHphdCDcp0F9HUr9/Hb7+cuvGGlMS0IBEwkcd4gNprDg7wKos2NQDYZ/8qIkz+henYza7fi5RuG85xokRetUVYyAJtN34E0JeLJjNMtnNiD+3cil4rYt7igslEdij7LNASdlNnoAAWOccnoJEOEjFOj98s4iZp7ywRNBEhg5zw86f3/HhLAhONfEo1eOUnoJzv6z5t0vKILLZ37kAN+hB4db+rYlUR4RngKPeAP64oRq47kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu8C7lbXi+xXuJ+UeJKHTzXf08u1P+TWS/mlNYMYhK0=;
 b=y9uR2po9HC+pQSw6AGS4lqcV63z+kBGJLRraV79zwT45H6tlut+0Gj78S/V6NYx35BgABYx8F2Fq9XB17TVn0HSxT8LG2bVQiexi+jpDF5RRh6Ov6R8mcA3qbP0JdbW96Z/k9b4b2wgHQJfL7rN4s+2O7ccpB8tyloBYiIEIijE=
Received: from BN9PR03CA0673.namprd03.prod.outlook.com (2603:10b6:408:10e::18)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 11:47:45 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::22) by BN9PR03CA0673.outlook.office365.com
 (2603:10b6:408:10e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22 via Frontend
 Transport; Thu, 26 Jan 2023 11:47:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Thu, 26 Jan 2023 11:47:44 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 05:47:43 -0600
Date:   Thu, 26 Jan 2023 12:47:40 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 1/3] cxl/mem: Quiet port walking warnings
Message-ID: <Y9JoXPVjqTuEglfu@rric.localdomain>
References: <20230113110441.0000657e@Huawei.com>
 <167468465444.586774.9409731200278259584.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167468465444.586774.9409731200278259584.stgit@dwillia2-xfh.jf.intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT097:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c33fd2-67e2-4a96-3fee-08daff93235a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pjC1ZRk2Df7YctTHimr+C2pz3kC0P8xd+IflJoQWjR5bj9COK5K02oA6qVCFwAdCN408el3PudLU8SAQhddJfxUnqrimY/fL4Zp61Fzw4p+Vbtawrm/xU76HRdMTHtPcmU9twdAcC1/mW2AWffe5QPQ+cu8tadCaFr8ee57h3RrQgDBjCMesTbwoT3mqHeMpRcBXdFFwpVSqnloJJ9PLQk8+FECRaaQE1mUAFgphAHVucyqquIv7OTAjEU88lDPCQm5MaTNNNbXwfP1UOKtyuzltBsF/pmaNnI/EstkiCiWZSZrZ83mZb+orDezDEX2W7E8mHb6ebgGDZjMMCKe/xRo9Xc8xFt99q4k5BMif5PGm6VEl5MU+a9KiSxXavM6lgaMned8z/pQswaGQbFFkkRmbdqobgMh9miMMr87rBRkQYjnxzipW+YINr0B5nYK9QK1YDwR1Sn+vgcFd0npkBiAcKbPvhCKOBaJycNIFMl7dP4k4G3p2/EKvyocS2jqMwrJDmTBbe+W4NASc5VydxXhJCQq6bdABCBguSbRqb3Yv5V2kLK5/nhuTnwjmfjp1O7otxBMY/zlOYq9sJFbwoV4Nm2S5rbV2+l1xWZgBHaY/ZDZMwe9hoVXC5o6nuqOE+/G80YNlgk4Cy48elIXC4g3wfUXETBZYhCdUqWMCYgwLRbzae6VN4KyUzhfiyIZca7NTiz/BgBz4muF4IekmqDmBcxNT5NGWw1mW9jgJ3EM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(82310400005)(4744005)(81166007)(36860700001)(40460700003)(356005)(2906002)(316002)(8936002)(478600001)(54906003)(82740400003)(41300700001)(7696005)(40480700001)(55016003)(426003)(83380400001)(9686003)(26005)(16526019)(186003)(53546011)(70586007)(70206006)(8676002)(5660300002)(47076005)(336012)(4326008)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 11:47:44.4270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c33fd2-67e2-4a96-3fee-08daff93235a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 25.01.23 14:11:17, Dan Williams wrote:
> The cxl_mem driver attempts to establish, or revalidate, the cxl_port
> hierarcy to attach a cxl_memdev to a CXL platform topology. There is a
> natural race (on ACPI platforms) between when the cxl_mem driver
> attempts to attach and when the cxl_acpi driver establishes the root of
> the topology.
> 
> If cxl_mem_probe() runs first it will iterate to the top of the device
> topology without finding the CXL platform root. That situation is benign
> / expected, so stop warning about it. The cxl_acpi driver will poke
> cxl_mem_probe() to try again once the CXL platform root is established.
> 
> Suppress any upper level errors by making it clear that this is merely a
> probe deferral event, not a hard error.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Robert Richter <rrichter@amd.com>
