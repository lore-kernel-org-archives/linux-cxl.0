Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C935DC433E9
	for <linux-cxl@archiver.kernel.org>; Fri, 26 Feb 2021 22:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 753E764EC8
	for <linux-cxl@archiver.kernel.org>; Fri, 26 Feb 2021 22:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhBZWWp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 Feb 2021 17:22:45 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54472 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhBZWWo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 Feb 2021 17:22:44 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QMLnvi088879;
        Fri, 26 Feb 2021 22:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=NQzwPx+2d0OvECVrM3JDJxZZhgV/n4USc5U3Za9qDoA=;
 b=pFAcN391Rlbj+nyXUcmvarDYYsfYlLTl5IvHUZ5TiuDfe4nBu3dcTAYtra4ZZIj7AVkh
 Ec4YemwbFVjiz+1BBa9E+TTPoqTA9OYmeXea96RKmsCAO43I8xd5bApBE6sMxdf7m9nW
 MglIQGjvzBep46/jCiZmMH+8IG50Oc7vkK5FIUOtILUamj76D1xDgw+/fCJAS4GDqfPD
 TGPqcOz5uH/jZiTcV1UDoDKIE83YnuX3tGIQijefWC5Z8h+lz2/Or04QobJN0hnm4MCU
 9NvT5/74nJwT4oaH3DkmSsanbDjO/EvPiZwT7Hx9IyKEITJHUjWuaPaViGWkWBz+lute 6w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36xqkfb0px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 22:22:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QMKKSL016794;
        Fri, 26 Feb 2021 22:21:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3020.oracle.com with ESMTP id 36uc6wef4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 22:21:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFnqH1a+rZjJ66I+lA8+MbFEgJR3SWqPQ4baJ79h1XUs0byPW5JjJ3Z7B6wAv0pJREYPev3f052/P1/m/TLGxUsKp45QPBWL5DhAfISc/T+w3sdKPDj/gSyV6H5XPJ2kiN5rYfJUgFWzInJmZaYXXoduDC7DmlEfZgKVzhYritCqpHK52SHqFzTYjKxWya1baI22pQimJ3mvZ9VP8schMNyi29at2V7rEdVeVKXr/ohNhLQRJtC+tanK00N93d2ZrYQRCWZwNUTkynlSohc+GnW8WT6nvw8xq3Z/nrChS8ZZbyYvBzuwMT/nuNNgt8DGXd8JRHfmpSZUcP2OA0fusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQzwPx+2d0OvECVrM3JDJxZZhgV/n4USc5U3Za9qDoA=;
 b=XGU44uJrfjYFL1L2fhO1/Gp2FaFnXx2RTxRxjyKffvFiOwgeC+tj2wgU5SD9zwauiKR2mRgWPkt6M81HjQGFpPoV+L6BXsNAq2Zh+v/0dIguAoLVOy91EOFUYRJGXj3F2d+Ziwv6LBRNGbBbOBbCo38UCQIA5NaXvT+imO4yP3X20/y/4gJikcpWTwQJRTu3GAHUAd14KCyq6txd3Bn1AeIPA6wETpz53raceCzap4ipm5ZEFe5Us8hjFMMWXjtvK/hjjyu04IOb7zZxur2DDMtXcTe0vfVU5WZzN7M83Rsz4UWRzthH8dBFcSqgDonEWAwyTQ6kbgv4951cp24dQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQzwPx+2d0OvECVrM3JDJxZZhgV/n4USc5U3Za9qDoA=;
 b=vGcfttAsjI0uzSfzLZvHUXlqLn/YD3Lvxf99/8SEknl2BNRSpY308udn8YW9VfMJWi12EfrOyVnp1cy+k/88ChgiZssynP7p5fZqyu59DIoUy9H0RCgwmLUICDsb/wFI3f+8imEbm4SBsAX9mUeB+5fu4RE+N92QpznavnRhZ4M=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB4372.namprd10.prod.outlook.com (2603:10b6:a03:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Fri, 26 Feb
 2021 22:21:57 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 22:21:57 +0000
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, ben.widawsky@intel.com,
        dan.j.williams@intel.com, linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH v3] cxl: Make loop variable be 'i' instead of 'j'
Date:   Fri, 26 Feb 2021 17:21:52 -0500
Message-Id: <20210226222152.48467-1-konrad.wilk@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <CAPcyv4iXhsOK0ZdHuHkQ-FwZbvT6H2M+FHRoZVr=Pv8SUdpT+g@mail.gmail.com>
References: <CAPcyv4iXhsOK0ZdHuHkQ-FwZbvT6H2M+FHRoZVr=Pv8SUdpT+g@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: MN2PR14CA0022.namprd14.prod.outlook.com
 (2603:10b6:208:23e::27) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from konrads-mbp.lan (209.6.208.110) by MN2PR14CA0022.namprd14.prod.outlook.com (2603:10b6:208:23e::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 22:21:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 310b0b7c-4976-46f1-0098-08d8daa4edfb
X-MS-TrafficTypeDiagnostic: BY5PR10MB4372:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB43724466090E84F1FC187109899D9@BY5PR10MB4372.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1+sAvFSoHKnD2VtKMo5Jhcw5qpJavR8hmpoPrtU4E8e6b5upttFf2IHHJydGNgi6dAeefNRQpAsSe8fRCnZkyPUJDG+TorPZyk63ewaIZ42NujPl6Xeqcd7ZGz05h5HXLKtNqV+DEehDjXBF0atVprW86ZbL93iX883oCrSigCLCBWl5dGuGiHgYt5VScGHlNiIF7UzYO4SMbA+kNMZigXmXrzsadnPbuGDAssuQtKW6HzdiMTNhu2P4jtibC+aZ4UwA3xIj7NYanB42o/wJGx76JyTUKD4/Zfj+8IUJ1UiScu8aNcfS6pzM96HL39TewhRU/LQ9BrP0VxLDsaxV+dlriZ6pfVTQoaOycjaiODwSq9zLuvkIOpkQDGWcHqkCQSx8GGklsFPZ6jkrGlaNtQDBiaJpHf2eRgIK5H9F/YDhKmn00Q9CgLtSKP9KtbIhnTjNhH7gGUIn7QmrQYcMZUP540OQkrKFc1XnwsRhxgn65JXlpJQNrMVCjo2qm7bbwuEO9GxpYS6cdrDmoTcTKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(39860400002)(396003)(107886003)(6666004)(6512007)(5660300002)(1076003)(26005)(86362001)(36756003)(66556008)(66476007)(66946007)(2616005)(4326008)(2906002)(8936002)(478600001)(8886007)(16526019)(186003)(8676002)(6486002)(956004)(6506007)(316002)(52116002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wFjMAV6bXyp8jCTuTlbAfRNIaop3Z1Uzfy+xfCCD1TZE+/ajyK6icx3+CyXy?=
 =?us-ascii?Q?gj9M+4sBUYArMpkTha69egpRkaGy+PMu+YcuzmCOt3bELjALuMw5ln8dwDrg?=
 =?us-ascii?Q?W5BtJleQWwarMyaW8i2gmbIhZPeKjUsvP2gBS5WqjpmpmLtf20z4zViH3hW8?=
 =?us-ascii?Q?8T7yRSfVjAa36gXUPt+gEK8Oym/49Eb2vSr2hiNOA0RLCKuJLLmJs1cNrlgT?=
 =?us-ascii?Q?6z6GwDC2H+Uad3vJh0Ox/RPK0sN7UVcN36HyPaklBXxYhVAe9tdLsenOVFHT?=
 =?us-ascii?Q?uwo43JPXvjXvoN4VfcR2ysYzJd6CTIPDnG5ocy4swDmVGs6uWmgvs2Gtwcyd?=
 =?us-ascii?Q?yGxgN0DISX5+dVAVDzPTwMjrgKxGNRCxDieC9pwHjEIzFT4hpl3PiXLGgQZC?=
 =?us-ascii?Q?DxRCKZ8bjHT0LOUspBWyQhFJpoXYc7aF1QhK8z9XVcPw2GPt8VHKTugGpB2Z?=
 =?us-ascii?Q?mdv6ZRLFLAeaB2qIHMQUvR0npdJyr+0hPMxTlJ1vO4IOa1gUvXsp+cS0liKG?=
 =?us-ascii?Q?vWOoYpOa9/5Nc7Ns2gq43SOmqB6dEtE0Vq93tE7l3orz8KHRa1kECLD0GKE+?=
 =?us-ascii?Q?vuXMMEAQnFCjKGSyI5OFSXXYGCoQKc6A1Fl9voME1iCXv03ZsV3Hzf11ls0r?=
 =?us-ascii?Q?bCb4m+UskBdte8hcaJcy5KYaWyx2KlTLobL3sfuBtTJWwrY45fL/6MixBDAg?=
 =?us-ascii?Q?GIdCArAO6K/0uO3WaiO1MnZWtBn8yYz1Z6Iv5YdWF8+YakPjJCIWyfWZX0fr?=
 =?us-ascii?Q?RTXsGhFXOw95ZLQ7lzOzIcGSoRQYTbbqPDoaJhcAbE6c/o9M1vgkhxaaYTC9?=
 =?us-ascii?Q?olGaSa1BuI/M4lssSVJ0VWIO+NdqPav90b5nfc5BW4SXtt5AijnXfbEe6XXy?=
 =?us-ascii?Q?jRra9HlHfxOw5KkdE6WsCFfsM9tLUlDijaS6P5hpuKbX1IIQBEHFl7R5rU9I?=
 =?us-ascii?Q?GtWo+RkTS3ZiCFzZcRgjAALFuUTVMjlwa+OHJlObPB06eeefxaa6KDV20HNt?=
 =?us-ascii?Q?RZmQb2A/87ec+C1auMkYKfF03dkW8hGmr/nXlTSk2hbOfu349onF1E54wai9?=
 =?us-ascii?Q?L0eNbTkZO03P/OVy1QeYJS5Dr/EXrSvl1Juok/nn7g+pC8vr1qW56mUsJBWJ?=
 =?us-ascii?Q?1mf2Me54Z55f1FBvBlinYGR15nQvfc2pnzq5Os3SGili50wulQ+tFZ0sILyG?=
 =?us-ascii?Q?aBii356mbirrb5GuuG2qcPt5jpk23jkFNGVl3jikXdTLwOTfYgUvsYVLH4kg?=
 =?us-ascii?Q?3th8++74zt2u1ZbK3FN4sDCj4dnXjmYBxhimYcZC5sBafRblkA3F67yiGuq2?=
 =?us-ascii?Q?Atv7lDxFnSUIJE2nUYksitR8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310b0b7c-4976-46f1-0098-08d8daa4edfb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 22:21:57.7295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncgYGQ1DQ5410xaBKThMnVzVPmNHQDlLOyYS5uFgF6ksF4Y5riMKi39xKlLDhikwoxOgx/ByJq5NiYK1+eiqfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4372
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9907 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260164
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9907 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260164
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
v3: Duh, don't initialize i in the loop, but do it outside of it.
---
 drivers/cxl/mem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 244cb7d89678..e7246e585e62 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -698,7 +698,7 @@ static int cxl_query_cmd(struct cxl_memdev *cxlmd,
 	struct device *dev = &cxlmd->dev;
 	struct cxl_mem_command *cmd;
 	u32 n_commands;
-	int j = 0;
+	int i;
 
 	dev_dbg(dev, "Query IOCTL\n");
 
@@ -713,13 +713,14 @@ static int cxl_query_cmd(struct cxl_memdev *cxlmd,
 	 * otherwise, return max(n_commands, total commands) cxl_command_info
 	 * structures.
 	 */
+	i = 0;
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
2.29.2

