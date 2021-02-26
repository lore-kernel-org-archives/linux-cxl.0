Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B08C433DB
	for <linux-cxl@archiver.kernel.org>; Fri, 26 Feb 2021 20:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F60864F2F
	for <linux-cxl@archiver.kernel.org>; Fri, 26 Feb 2021 20:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhBZUrX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 Feb 2021 15:47:23 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:38194 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbhBZUrW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 Feb 2021 15:47:22 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QKjcZP107745;
        Fri, 26 Feb 2021 20:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=GCWBaAOT0C1eOqpOXXVvJWF3E/qOn7J2h/2smWamOUs=;
 b=AI2/9pVhw17L1SZCJlJKyOfusPWDDH4oEnKbaQ+slEGHdBouyxMbJ/+QdKHkMQmNukKn
 Nk+6tZjf1TaFP6WrGI1zUfMldcHGr464OjEqU1Ukb8khB2J2iw7zEy9dybi3xeumv5hQ
 r8dKj+Sh8xj7uB0a8rFzzL2sIaKO8tDdoAA7gxlq25s9887oqgsg7KyLfIqUJO+So5iP
 EY5URCbZG+Z+MSsN/NjTOhwlYOAJH+SSvF4Ci9f/7oc8Y/J7mNfotqaZfYxY8R59Zu7H
 A95eKFvNaBKLZSKPmPu9ZGNr397rUR7R6kH5L9Zeq1BEUfVQHJ3uS0wY0ZSiCMnZeR/2 FA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36vr62dn30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 20:46:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QKkJAb069132;
        Fri, 26 Feb 2021 20:46:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3020.oracle.com with ESMTP id 36uc6wbw41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 20:46:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtpN7S1AcuKt06jUK0eQ9ab3ZlErncaysrOm5CBp0UUwO0qsslE6Q3vlGUulTrk88FjQXp9mtoNioZODKeWUv7oJPkeZCYP3b9yqiXMtnRkmEos8HBsGpfJIeUDMW0wktpMjFJjAX3Nd2Kb0jcgZ3WyZGfX6YhNYhIIQKVxTquqWTx7Cm5n6Wvx3IN5loXaEnwSs6dZXVlxCtVnG0RhfDPInZHnqgJAS4aiCT4WtLx+22gW0o3ldvv7MKCY8DMjVbX4ZVsoqvL0u2iOcyAQhENY54gJAaFFj+QxcgM8rKUFw/08U5RYTvIt5xinrwV1/mdZeIeRZbwMZoTr4XzLn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCWBaAOT0C1eOqpOXXVvJWF3E/qOn7J2h/2smWamOUs=;
 b=h2fIJTDmmEWee6lp5u9sUFB68qjIef3bWE0xE/bpowuiHlOf/rNse6OS5qpiNHOzHT+EAmY0XKzufWLzIA7BuLmWvNaBgKfZto44hZxr5DBj+Cf2HFjK3/43GJdId/gtrn0ubwa4XXDIc7XUERosb9gY1g/da9AkCOh5YeqM7hOfPIsCE5BElraayVOGfyq3Buma8YMfkbUo+hreLSpGekNuawWr3x9BIZuF+zDnbK3dEvlMEBKl6FivzVc2mkEYBQ7l0WxKznaLbaNuJ5R6/bFL0BGs1NT0PITfuzqLldiJIaOvT6nTvqptL+kKXR8jt7XNRubf5iVaoCx1ZBo8Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCWBaAOT0C1eOqpOXXVvJWF3E/qOn7J2h/2smWamOUs=;
 b=Ur09xa6ETMj8pJqgPfVVhoPW0qKmy/sL3bhML1MMEa15VXQsyeiMYVUP4hYR2SQFsZEjVNpzxfObgb3KFmZkne2hm+EQB2np73yWNbNkBBuiHAXYf+ez0PNKIqFnVBfTTMFbGoVYsXpX9uKjOLzseAww3Xx8+Acq1wsdNQvj9nw=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by SJ0PR10MB4671.namprd10.prod.outlook.com (2603:10b6:a03:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 26 Feb
 2021 20:46:36 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 20:46:36 +0000
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, ben.widawsky@intel.com,
        dan.j.williams@intel.com, linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH] cxl: Make loop variable be 'i' instead of 'j'
Date:   Fri, 26 Feb 2021 15:45:52 -0500
Message-Id: <20210226204552.45399-2-konrad.wilk@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210226204552.45399-1-konrad.wilk@oracle.com>
References: <20210226204552.45399-1-konrad.wilk@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: CY4PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:910:60::33) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (209.6.208.110) by CY4PR16CA0046.namprd16.prod.outlook.com (2603:10b6:910:60::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 20:46:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b12910e0-d23c-4cb3-c39b-08d8da979b98
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4671:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4671D1AB555D38FEFF3A7847899D9@SJ0PR10MB4671.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G6/sju5qilUDECNj3iQoUPMc5BZvhmp3c5IPO1cEQBIgiSuzAC+d7FsmrPdFYoSsEehKHhGWrleN7aWqTOZ4GsjwKH8M07vaYs/2hrig4sSaxKQ38TrmjuAbV1MrecprvbnaGuPfXLrqEjdnurJlLEiZY4ubccSa/ACifLGcRnYn0DgK38ObCdhiX54zD19NMJiwCpl3Ghwm0hM+cxKuOGqCMR8hHFa0/DD/Yf1Dgy8iy9pc619ijQuZn7ivKX66KavTqDFgzQQ+pLNbERvJI4CPDcJhvIGARBqktdfRKWJgRIJYpI4dFSpGpwxaJJVs9nrijzIvCM78ANm8Qj5vBTp5UXal4ev8QvmBG37D4/SCIQrTwX7xK1sfiyj/nsL56+zTNkRdLXdT4nF3dMWaht9pTfRNC5aHSsN0e4XHbV4kHJnTLzlnQKY3yfWNxNKfiBmAOdB7zpcyCi3MZUcdXBSxGkPXo6upXaZa5gf9n0HaVhMpCdATbdjxGUvhdhyHmM5nV6U+RJhcJOJSz+dDwg1g/R/24aUHImzmuKq8kEabvMMQA5dfQvwM2+lRrhHOGVv+dYyY5xyxB11MsW6u+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(39860400002)(346002)(396003)(478600001)(66946007)(66556008)(956004)(6666004)(6506007)(16526019)(52116002)(2616005)(36756003)(1076003)(8936002)(186003)(2906002)(5660300002)(8676002)(66476007)(83380400001)(6486002)(6512007)(26005)(316002)(69590400012)(107886003)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?s+uEv79cxjEsywrvGkJKzjLfJ2Lk4OhUCN+wfTjRbw081i5gGwuQvB2YUmRK?=
 =?us-ascii?Q?9iSJ7v+7llMiwAfIWK302Ki8xyD3EMcEack6K4XLGu2ZdApWW0LvFyYx3Oex?=
 =?us-ascii?Q?3CCZYOWnFjSJtqIPaF/0zVfcVDk8v1ekKtTCPLOoivwib1vzWGsjH7otjtXN?=
 =?us-ascii?Q?3/TCc6sKxwK1RKSdq86/GggrVUgNZkzB7Q94iN7Nz/8Ep7HY/3G0Yg8xjHyv?=
 =?us-ascii?Q?CJyvZy3DcfmXMD0Q9nOAuMGzRR5B7cDG5g31nb0Re9olOtYLfoX173xfeRc9?=
 =?us-ascii?Q?ONylUBfgOItiFyr4SFnuFsG7leoRPt9me28rJDlK2RpUTT9oqA2tyBD0xFIq?=
 =?us-ascii?Q?1pOtDlUA5eS4C9N6lecpVvJ3Ekh9HO4lJuYV4lmQQZf9P42inwFs/KjIYFvN?=
 =?us-ascii?Q?jJ/4ohSOC0meJOiDzK6Z7WvB63YpL9orlht5sAFZlkWrsmrKuBAU916906su?=
 =?us-ascii?Q?MuT4uJUBDFJ0itMP9tqMd4jljC/Y4PEj75xwmG8AsvCHfn8tPnZbSrs7Ara5?=
 =?us-ascii?Q?4AFQiaLZSf64pMIknR1X+SA+4G5fbEjYoPHCaKZ0KCesqT5TM2632ygqOd04?=
 =?us-ascii?Q?al3sgOqgH+VTiIxmaBLgNcSshbDES8Gj17XYooCny1v7gWg2cNfU0NFWJwe2?=
 =?us-ascii?Q?jpnPrK2wovz/OclnHHgY/wS8ORg5UrVZhGxPS/GoHVVD3Yv/1K2baTujqlBv?=
 =?us-ascii?Q?nnzyhdm6rSxdJVE7nJqmlY9cyfD6wABHyymrk/lz4GJ8d/P2ZEgZ6ctS9Iix?=
 =?us-ascii?Q?EYzdtGbOsWOdExcQFCySoz3lQQg2DKdPmdUBze+PwU9kQ9EajJAFCEF8yLF4?=
 =?us-ascii?Q?ETHiYoowLcOvU5Y0UHC3i1CVN6gz1oQ/LIS9EiXA/D2tu4gqE4jD2tukFyje?=
 =?us-ascii?Q?pt17II4fP1uCgUW30MwNP8KRLuqUHyRpSAWidgX2MUWWrxINsOe8JDwqEZLv?=
 =?us-ascii?Q?J5gdAgRW2ryzVraRhDuUZpMlbqr1Bs/eR2tk/32s3dYd41zWSOiQ11ka78lZ?=
 =?us-ascii?Q?QVtnHnozxOZhF+nRxFPsE2CxLcKhY6T2flK6fgc4skOxbEXrkQLoyKGwNUGX?=
 =?us-ascii?Q?x6CWItpNNe+gOqgrXADTL1hBiUA9PyX0k0Jqix/C54ZDhrxhE8/9KUjqsG1u?=
 =?us-ascii?Q?pTCfLOwvAq9ZeBQ7t5Pp5qghqOukpUa6CenyF9tFjSp5hD1u5b+LfIE0l0Hq?=
 =?us-ascii?Q?9f3Jd84nWq8O69JSVRUuiunFthbUqJtEomsN1P9UGo1q+K+XQzJfa3C1H/8g?=
 =?us-ascii?Q?gJM+nVnCoY+6KjppBeEcnYfGZCxQb1GEjr5CbXZYsveF/1pwpl62Pik2pYWH?=
 =?us-ascii?Q?iTM+JmRAtDE+jxCgGVFFKs8M?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12910e0-d23c-4cb3-c39b-08d8da979b98
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 20:46:36.0450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZBiqcJZBsklX8r6+oYAiT7+G/2bhG+jx6/E5jOhhBRbcl/e3EDuTSrPbeIrXamFpNaGnHufMgGOSIKjT5IinA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4671
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9907 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260155
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9907 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260155
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

.. otherwise people spend extra cycles looking for the
inner loop and wondering 'why j'?

This was an over-sight when initial work was rebased
so lets fix it here.

Fixes: 583fa5e71cae ("cxl/mem: Add basic IOCTL interface")
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 drivers/cxl/mem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 244cb7d89678..2b8265b03b0d 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -698,7 +698,7 @@ static int cxl_query_cmd(struct cxl_memdev *cxlmd,
 	struct device *dev = &cxlmd->dev;
 	struct cxl_mem_command *cmd;
 	u32 n_commands;
-	int j = 0;
+	int i = 0;
 
 	dev_dbg(dev, "Query IOCTL\n");
 
@@ -716,10 +716,10 @@ static int cxl_query_cmd(struct cxl_memdev *cxlmd,
 	cxl_for_each_cmd(cmd) {
 		const struct cxl_command_info *info = &cmd->info;
 
-		if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
+		if (copy_to_user(&q->commands[i++], info, sizeof(*info)))
 			return -EFAULT;
 
-		if (j == n_commands)
+		if (i == n_commands)
 			break;
 	}
 
-- 
2.13.6

