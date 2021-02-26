Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87438C433DB
	for <linux-cxl@archiver.kernel.org>; Fri, 26 Feb 2021 21:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EE4464F13
	for <linux-cxl@archiver.kernel.org>; Fri, 26 Feb 2021 21:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhBZVSA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 Feb 2021 16:18:00 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46948 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhBZVR7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 Feb 2021 16:17:59 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QLBPGV166855;
        Fri, 26 Feb 2021 21:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=2llRLZIHWL+pGmQec56AjHC5rGXF8U2vaL9IgQ1wczk=;
 b=a1fV4Muj1X2M+lyJbt2X2CFNkM4RYiRxloLQUuY+GiV1JdzwAqryOj6WmS6eSdNbTERV
 MFZ3xPyWnSOCkfpwBzx9TrHnuCw2DHBTpWGXZ862xaPhJGe1ZF625pZdKcvCNo2nQxkF
 eE0IGVxEvK4PVTtO2E3IR5Yc6ofRW5EeXayrQG06czGJPgMfAQmT/2aSUAr/v4wnk4ny
 Rj3IsHvva4LAjdz+CEKs5gIjkOr64mvgxx0iqlRdxzrAQfdb9nmddFsE033weQEJ/Qnv
 btYWc8u9SHbDcpKJXUiW2IT8aJfQKD2Rhc2a+3dm2NC2VZKEgHgNTuO7MzzzJl6S35T0 RA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36xqkfavb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 21:17:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QLAlxq045394;
        Fri, 26 Feb 2021 21:17:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 36ucb3vy69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 21:17:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0c56xU+X9tzwb6zrYqJxx3zdT9SjZ7QzS6HjV9ptqgkurTVzrb8fxQs8uyFLB3FdwHIhH9EJjtOeiQGEg17waqHur2MQogauSe6JhEpatTYwwNQl+pDzDL2YLsCjnJ0Q/lTnXBXIaTIQDtC00JaEreQNphTeoUk4H0CKRWcD97M56GWo2SgzTMbNu5r5dCP/crPT464BpTrycF1AhWcKagNos/OsmpQtKfc4cvZmenyvSpvak7kYVPKjWkRAL86GDW5Je4+egMJ3LjaQKLS696n+irdhe3hdi3FGrICTn6YSqLjIWjYS51Wxj9F4lQst+1As2TcLQ3TE/vJF/0FWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2llRLZIHWL+pGmQec56AjHC5rGXF8U2vaL9IgQ1wczk=;
 b=PiAcoI2meS8bMIOP2dF9zwul/YZBu/wfL6zMz8ByTlawEnVfDoSTj4x/uVjZhousmAC9PAQ8/4vs1LiYcuMH8qKNXJ/u3otxJd4OPfXeAyGplgk3hFKjfX6VftewIYDNlcom6Qr1KaGuAoC2uae5+SdeeJObJ6Dqo7r6YJaIE3/axy/VPTOgkEw+FsJTUwMdViBP5teWtgX04PjTYl/Adj0L1xhEUifRKUK165nfVvvUYzYFEhyQoI+dHPpHLuUrhj51mTZFVAvxaNi7wkq5kue0Df6aP3ED4Jb8X7vjDX36xKCW7zYDQwBIKAnXwgeYJqW/9yL1BvFqgnHtuIpusw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2llRLZIHWL+pGmQec56AjHC5rGXF8U2vaL9IgQ1wczk=;
 b=TatxP9FFGqiy4gvej/ShnaLPJhDvXrDyyprjh4bG4jPyXt0S0SnBWRyjlUpzIszbjpmPW6fLTi29fjg20wtaez1UEdH01CWBPKnfHjBgPHoDn3ICD+QzSYyPwEXtZ9w1t0DJb9+TZAAcNPMx5yLoJdwYKbKiR+ncyt7bZAObxQs=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by SJ0PR10MB4733.namprd10.prod.outlook.com (2603:10b6:a03:2ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 26 Feb
 2021 21:17:08 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 21:17:08 +0000
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, ben.widawsky@intel.com,
        dan.j.williams@intel.com, linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH v2] cxl: Make loop variable be 'i' instead of 'j'
Date:   Fri, 26 Feb 2021 16:16:56 -0500
Message-Id: <20210226211656.46359-1-konrad.wilk@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <CAPcyv4iXhsOK0ZdHuHkQ-FwZbvT6H2M+FHRoZVr=Pv8SUdpT+g@mail.gmail.com>
References: <CAPcyv4iXhsOK0ZdHuHkQ-FwZbvT6H2M+FHRoZVr=Pv8SUdpT+g@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: SJ0PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:a03:331::19) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (209.6.208.110) by SJ0PR03CA0074.namprd03.prod.outlook.com (2603:10b6:a03:331::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 21:17:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47e99ae4-7f72-4f39-228a-08d8da9bdfdc
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4733:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4733825241A8B29D2BB7C693899D9@SJ0PR10MB4733.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qEI5fPkK6+qdi0FIJmtCAoY7Wo2xmg7d/2W+B0vLvcdytirxhaUpbp1YVx4H/yv2abMYpbIHcfEGrvhh+sg4793NvgeMPAmmcmBLyVRHn7Fb9aSXxratkBrrVGZJoohhbZatfkj2B8mMSSsJ2TYmEUZ3mEbZ95rar54AIwv5JBWY8i98rkEPqoLGb5o3g2xc1w42tYRGrtGEBrT84JgcXCcfqodwL2jf+O2djk3Injk7ffCoIn01JEWslr9SQE6tzmf2RBpD7271NW0aRPr8eo+393yMgQV1lNELP9lVkV2uvrEtnf2qcaVjUpbnqCTHeKeO2aeG2JGNrWgm+84DfJWO22XH8acXc8Y96wnI3/ioqt8k3Z+XGZ6HxkdKjc6+1BK320xZAN8BzuXSssbCOBznDqr3iPBpbaPw3Q77ToutBY6EHTfLmTunHZHgbCi+jFl6sMPVxs2eJ0P+0o/c6ArjxvQbumdxKi5Xz5+JwxE7Q9SlYLpPveDKBLeQElkbqtOLZN5Ben8vnq3Xeq3d38jPcaQrOvP9uGsW1dDNKFwiz/ZAnCeILSKN7XXEuL0sF6x+fY5F+uluyhTvN12ZuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(376002)(396003)(346002)(36756003)(4326008)(6666004)(107886003)(186003)(16526019)(26005)(6486002)(2616005)(66476007)(66556008)(956004)(66946007)(1076003)(5660300002)(2906002)(69590400012)(52116002)(6506007)(8676002)(316002)(83380400001)(478600001)(86362001)(6512007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1Xp9R2qgWQrIkhAs3CtQxTrQ32EdsbaD3ja4MDxfyIyA/X2PvmShA+3NjtHgGQdLhkac4Qibh16npxEx+pf81cEGMA74czup1ZYwwCQBQuJt94rF+fEnUTMn1zRAYvCOli6WX+Lsn8JwwDTUQDUS0n4UgKAak7vWrkDArV7ne5h1KcJRjNg3EZXtpaM6cNCfTZGwGOp8szsSRd+0Q8dF8QIuih382GWkf2i/z4/vnYlU+aHnHTKZ8IsyBcFxt4/siVgkqc3TCbUA6zq7xZN19iZQmYNfO2UgkmGHLZk5rQvl75y4G77TF4XDp5zGe8svSM289UVPCRDZqE6OTPgV6/l7xNRBOT1uM6S7XRaxbpYTJ7Ad+KE/jQIi85j6oA0GqDd9od1wJLjTIpt9zIGMNvP732gyiZ7L0yqfhLnkyfj286Pb3Dg4jIzC172j2uBl9nVTLfn8O6Ft+oMOBDBDOXLbz+IbRVIDJiGlVZzPfC6OQA6N3Qzkv9a+e+g9xZsXkldTshH50bmmPEKqt26WGmp9lQB6UN/5OO3vVOA5TJ1Q1WuvkBjUNWGKRmb6Z7E/l7XFmH/8rZI2WbRSAU90mwdtQJCbYXGOAogfgDUzi8YBmznnRDFTBKsT9eSoZtkDKeFesiXPAUUedi/36KHTQtdpMfPGg+1VPP+zpE8Tb/0Dx3vBgkAV2Q9StEIx4O0KSlm9qzL7wXT+BUTQiYH+Y6wBYGMY0nmLKnG7cPhPICLrK20dOTF0P9j6AUdpyusP
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e99ae4-7f72-4f39-228a-08d8da9bdfdc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 21:17:08.6155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Qgj9toq86DebFBz6Uo5t4FhvFzAO5L2ajBUmTw34UHPjtUFu/G/iQlXo51A9w5JM8f+wBmOsiGaVWrDeQtLNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4733
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9907 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260158
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9907 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260158
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

.. otherwise people spend extra cycles looking for the
inner loop and wondering 'why j'?

This was an oversight when initial work was rebased
so let's fix it here.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
v1: Initial posting
v2: Fix per Dan's request
---
 drivers/cxl/mem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 244cb7d89678..d43197a193ce 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -698,7 +698,6 @@ static int cxl_query_cmd(struct cxl_memdev *cxlmd,
 	struct device *dev = &cxlmd->dev;
 	struct cxl_mem_command *cmd;
 	u32 n_commands;
-	int j = 0;
 
 	dev_dbg(dev, "Query IOCTL\n");
 
@@ -715,11 +714,12 @@ static int cxl_query_cmd(struct cxl_memdev *cxlmd,
 	 */
 	cxl_for_each_cmd(cmd) {
 		const struct cxl_command_info *info = &cmd->info;
+		int i = 0;
 
-		if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
+		if (copy_to_user(&q->commands[i++], info, sizeof(*info)))
 			return -EFAULT;
 
-		if (j == n_commands)
+		if (i == n_commands)
 			break;
 	}
 
-- 
2.13.6

