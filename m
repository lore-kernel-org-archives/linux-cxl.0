Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D24C433DB
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Mar 2021 14:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF16C61962
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Mar 2021 14:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbhCXORq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Mar 2021 10:17:46 -0400
Received: from mail-eopbgr760080.outbound.protection.outlook.com ([40.107.76.80]:12955
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236145AbhCXORO (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 24 Mar 2021 10:17:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ej2K3eJmbyITJwsKXL0muCRLyY6wD6joTilQEDKt0PJOJQCTM8/8hXQgbCQ1smtE+7wTFW/STnPyU2z762ggtFStueEe+7XQ7JFXOWREkEiWCX2E1tmmNY0sRc8qUYmQAalBE4cOyTbSNoX1oMIqRPtS7347b3xvxpiBZykmu3lp1y33JRRPma1AuR0lSQ4g23BSDpm/hQww0kMxGkAUL1jERlxE9hR4WZK/DpFCuHSQ6e0di6mU0Fiwukuef9e5XsGGPt+0jVNCXmN9ridkBMy8KH1h6B3sy2SmsEDwLBXFe9h4aK2q1MgTEKIMq62lI7FEqqeBO7o+ZRPDI96E+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HFOY8EmIJsTlUGGdQiSlUuoV6geWN+cMSPKdXcwdis=;
 b=Y8BWvtHbVekxBXeDhwePwHILK6b+j2D18oNVa1W0l7T1DsMhgieZYUlocSaNz5znmHPMC4HkzLThinSSHav/PqTAdmW9M6LdN2auHAbOhZ9izA2tfU6gGBvAu+4oaWkPOk0CXU+Vtuwx9hbMhOzwsUWtgHOEFA0mghItXYCy7TTlMSYZ7bu4/77Lj+HJ3gJ6fDbcPHnGzLafT447ZV9lwNU0EIZUoMTGEuyLqIOlCtN9gxJshhsgK2//gF30TI3mkRch3Qw+AEISUqwAJGPwcAL+eP9qMHc8uNJATbo6O5YNChzuMiebmi4C9b1CoiPKeWpS0GsgWizI7LeRtcsIQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HFOY8EmIJsTlUGGdQiSlUuoV6geWN+cMSPKdXcwdis=;
 b=T/Z14wXmyA2n3J2bOhF6Wj8DyGKMaqEO76heOFbFT1V+8dgzFWNqNVdloRtQ3DRy7En+4/I1HaXm8Be+0Kwg7J2u5uirt0E1hwqhBxuSL5EKEDGZv5nYPxFqAYzDtIenwK4WKce56OVpM2MPzcY/rEWk2huzwaR6i+QolmpyQRo=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by DM5PR12MB1689.namprd12.prod.outlook.com (2603:10b6:4:3::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25; Wed, 24 Mar 2021 14:17:12 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::404b:b894:fe44:1878]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::404b:b894:fe44:1878%6]) with mapi id 15.20.3977.025; Wed, 24 Mar 2021
 14:17:12 +0000
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Robert Richter <rrichter@amd.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cxl/mem: Force array size of mem_commands[] to CXL_MEM_COMMAND_ID_MAX
Date:   Wed, 24 Mar 2021 15:16:35 +0100
Message-Id: <20210324141635.22335-1-rrichter@amd.com>
X-Mailer: git-send-email 2.29.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [77.11.141.19]
X-ClientProxiedBy: AM6PR05CA0002.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::15) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (77.11.141.19) by AM6PR05CA0002.eurprd05.prod.outlook.com (2603:10a6:20b:2e::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Wed, 24 Mar 2021 14:17:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 235a5238-b350-464b-7a73-08d8eecf8471
X-MS-TrafficTypeDiagnostic: DM5PR12MB1689:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB168994E17F14811E3DBE48699C639@DM5PR12MB1689.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZXgEFsdjHCF1LX+TIY9CVuUDyTE5XM9/gojooXDZ9dUMetyjcw3gbgk3yuyurmdlCM5XOpTye+IqeFqf9M758gxuZVwB93/P2NlOvmcy3vQklP3EQ1dDnkXnAIUVU7dK+QRhtX393SdvYbhw7gDdztvXzDe6h+4oebkYnlOo99siOLz98PqXFD/XKXoBrXFwl9Ra1CaFpIiZqvV/ou3kq+rhtwgrHvaLaHkiX4SM2hRLVE2xNGMNSPS8wNAziq6+as4Rp3HGtn3DjlK5/v9qW8mJcySilYnPPAFBTCGzw6kXpFcGxlJ1U7B24g5RHxYQIA96JW8qAS2S78QU0ou9PEFYqZ3+DRz6ZGGx1jYU2ChxHhdZUpnKd7kX5oBgofrgvryx9vJMwNk6RHUNMU/pRw5HYO+/th5hwrKNVsBo4FpsJKCfPkE46MFfQ1g62NQ0Pl9ryVVEeFaYaEWS0/by4GdA4yo13hrkSiU3iqXX8t1UBcNBV4Or3BKOx0TpKmTkCn/H81hbuJzqxOcdf1KgZI4oKU9+V4l/UBMsAIiZ5uP2wRq4KY379fdzFIdwBv0yHeeebPkpdafCd45eNJXyU48J0oErpI6yr324KNQ5dQMOOGyTuzaBnNmXaNKA7Ei0blp4ZTYMwrW9sLu8ln5tHdhtUnQquYKOLT9N/OcqXI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(1076003)(66556008)(66476007)(66946007)(2616005)(36756003)(83380400001)(38100700001)(8936002)(8676002)(5660300002)(956004)(6506007)(6486002)(478600001)(52116002)(2906002)(316002)(6512007)(16526019)(110136005)(26005)(6666004)(4326008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DgGOHuuLgC/B5B1kH/VlP15zlaVwRjhW31cRMcnnlre8f3fRlqK8w6hcDYsF?=
 =?us-ascii?Q?s57a/ib7Z881q/8i8P183/p79vvnrcf+pvqQ4tHqrpdlBqugV/kQo76vujMc?=
 =?us-ascii?Q?NFcWoWSzNIZZ6lUFcp3DAc9t6VYthNv8q7GLGX51DbTgHDyT2qYBSOhq/spM?=
 =?us-ascii?Q?+Ai5CFclsPktMr2t7m9xVCKMwwYcXXcMTrAkfryLKiRdnKyjGrDkYzzlZM0l?=
 =?us-ascii?Q?3YdZcZm2+reuiMvXWO00fzHrzAVPEaU9YpMuSkGU1Ljm2PM2dKrPXY4XBPak?=
 =?us-ascii?Q?SvZMZgxZpAPDHATKH7N8ayTvKV5ytsvuThDpE4Hu0D2bTimRMEtu2qVyQCZR?=
 =?us-ascii?Q?keRXlI5fJOfUHLfvb1SzBFmYGobwQ3giUCmFhyORJrQSkg9yHYJRo+GgQAyJ?=
 =?us-ascii?Q?CQAm5FUBX0FWep0hki5pfhGyXEQen0ui9DpyllHUXwLVS7KiYguLlgfxmWeF?=
 =?us-ascii?Q?MDuS0EKd8Q/MbNncaaiuzt2qc0H40h14SyxXLGKm+0eCR2HnYSMv0pg7u6bf?=
 =?us-ascii?Q?IntCgh6Ruawv7IElorEvOSwusilX3Vz5mgvaWJtL5e2Gs+eeAVpInMcyxixc?=
 =?us-ascii?Q?xxldlVFEs8/PmW0C5tTh9oge/vbZp29FaPh+6Z807479wwspg6IYnGi48v1Q?=
 =?us-ascii?Q?eC2SZpXWG0zqzhwqantqPY3vKEGjScIL7Q5d3QoZeCZH2KoK9qQ/3cBKxS0L?=
 =?us-ascii?Q?OfCA0w/LzCTeTBmvKyzttmsGgsGmywI586EbSpRzGVReZLMmb6t+PK11jufj?=
 =?us-ascii?Q?c7lDYV2DyAj8cigCygZcM0O1UjoH/1IlDvFx9Z3BpQkEoYJsaibaTFUH2sLx?=
 =?us-ascii?Q?pDj8K6ATSVanUXkvqDhDw93U046aJOaljcJiQqV6WTEhph0x5UDUP8onjuRC?=
 =?us-ascii?Q?QRCHJhV6VGsIdX/o16or6V2yHPUEqiNPsnkAIdWY0N6vsKuA8q9bNyxwz743?=
 =?us-ascii?Q?KgcNAo77PSjpsWnA+bswf927TWuH86jtsess2NEONe7d+EjDHY60knQ203aN?=
 =?us-ascii?Q?r8L8yfmYRou/b3rTlJkMPVWDPW1gC10YOaUzIX1FD4QANlabF0C96ccO6yRo?=
 =?us-ascii?Q?EvbYokooQu/IexDaZ4MQK1rlybMN6TbQAhTF7uBCd4RwKV5xxTt444gySE0F?=
 =?us-ascii?Q?cUKOA4edn5giz49dvCAClCAQvB/yKIeTBHys1HvhVG6e2X2hQcswffXKrYfn?=
 =?us-ascii?Q?/BEykjKY3bmEdkHqsHafR3lFkizizGU1ntC8q+Lkq/ypbi2FAHmgA+Glf/JM?=
 =?us-ascii?Q?EmPQgDKNFld135NITgYFFkieX1crXsdkISCFS3FGDzN0QSiP7A+FctG25bhU?=
 =?us-ascii?Q?/dAwtKX+TOdfgI39TV3VHNM9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 235a5238-b350-464b-7a73-08d8eecf8471
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 14:17:12.3463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: teK+8dNCXp4ZxO6Ary1scIBnoGV2IPniiw1M5/koQVyOXqRZqidEAt+IlS8zfS4G1q6hkJxaYNT8WR3b2kgSpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1689
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Typically the mem_commands[] array is in sync with 'enum { CXL_CMDS }'.
Current code works well.

However, the array size of mem_commands[] may not strictly be the same
as CXL_MEM_COMMAND_ID_MAX. E.g. if a new CXL_CMD() is added that is
guarded by #ifdefs, the array could be shorter. This could lead then
further to an out-of-bounds array access in cxl_validate_cmd_from_user().

Fix this by forcing the array size to CXL_MEM_COMMAND_ID_MAX. This
also adds range checks for array items in mem_commands[] at compile
time.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 244cb7d89678..ecfc9ccdba8d 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -169,7 +169,7 @@ struct cxl_mem_command {
  * table will be validated against the user's input. For example, if size_in is
  * 0, and the user passed in 1, it is an error.
  */
-static struct cxl_mem_command mem_commands[] = {
+static struct cxl_mem_command mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(IDENTIFY, 0, 0x43, CXL_CMD_FLAG_FORCE_ENABLE),
 #ifdef CONFIG_CXL_MEM_RAW_COMMANDS
 	CXL_CMD(RAW, ~0, ~0, 0),
-- 
2.29.2

