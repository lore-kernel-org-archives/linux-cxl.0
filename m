Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038B0C3F6B0
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Aug 2022 10:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiHAKTw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Aug 2022 06:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiHAKTu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Aug 2022 06:19:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1E11209D;
        Mon,  1 Aug 2022 03:19:50 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271AChvG029375;
        Mon, 1 Aug 2022 10:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=DxxDCYhnYzzEHFdpNEHc5RLzNoi/NMxpfoBaiUzjVr8=;
 b=LTKRyvUg+936fOboTJscBdeN8c9fr/C8rteC48C9UL9bvXAs+uTdn41F/IOoWMLtMZlw
 sPVnjJGp7nKkUnkZELZue4F0V7nTurZniOlagf5Yfrj1YAu7KMzYsEWfLg4FfAdxgzl0
 hfUAUviDBjsOe2XToxxc2C+RUgFDW4tGT0hBN8DXF8PVkJACIENiglMa50Hwx+cuIe0P
 fmtO+MC/59sS4GnsidKqCqbDr5OukmlC0rCq8QahK/EaITr9c76AXxAVdaTUbCOkp+P1
 F9iQPdhyoca3S33/mRK3Wnp3cNjiOCLc2UWM1FNgJGxURhvcLsKLzareL8xpI89lkyXz 9w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu80u9dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 10:19:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2718ZRSO007447;
        Mon, 1 Aug 2022 10:19:41 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu30w0yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 10:19:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZ/bN64pYZ4HBqsJHTpZr+PCvpgM2g07SWLtAM1gN9QlszZsWpw1uJD/DxKNOvwy7guJwtS/blWnm7hs5c+8Uc/zabitx9vtlBKgyk9g8sQZlVelm9WCW3KwgSZGqgNxEdOgnRu7Ej4W9n6RqnThW8QC80Y1S68d6KRSgRXmO6CPIUXfnS4CqPYSNt+J6al88tXnC4kRyykah7mlsuR44ccjthdO2O3lCHf0grSOlrTOuh0a3s5V9USwMTlX7/joHUZaz+GSJDA2lXqJ6jz7G6ewjpZKDwRaZqeAe7hnl/1fskx0Ux1g8Fv4LHXqRkQCQ9v6yoThG4IGUJ71o7fs9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxxDCYhnYzzEHFdpNEHc5RLzNoi/NMxpfoBaiUzjVr8=;
 b=KUvQz/vMEH4cnwvi5jhXKQ0xWuUPPGXOyquXUjd51PNu0bbKHmEB43xneck0eNi/cJREJ+R7d7tNFMsjuo3cWtZi1397JTkLhE9bHbrZq8I/m1qFwv0clbiMw4UgjO11EswKCclIXb24qbmyx0dCArwZalwpENu5uyS7jesbc+gTcpXDMquX8d/VZRAh9bHWS4MXtX9oQxSyc/pz13CHTI66xJiBEMIyR+EeFtQTscECHOhGtI14Zc9GwUttz8wna0Y7pK9J650ZAUq952R2D3pEtd2zvSbA5azT6T8nGksHzX0XQ2QsJT6FOn2LR0EPcEM9dvzBw97r70zbFAPZlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxxDCYhnYzzEHFdpNEHc5RLzNoi/NMxpfoBaiUzjVr8=;
 b=Zq6ymV7nvVjZJpJ0QncBcXI6w9nSWz1rANwHWSsc2SjNvkv0kDC8DoGgFdnk1S9MmNmae13dyWZ82NIeaCrAyK0CQU64kgdFL/EueonviRXH7QCYCYgxpS6ZB8Emik9kuy5z+P4vHetVTNTk9WHg835o/fE7txtvCAzrLmOXKbw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1314.namprd10.prod.outlook.com
 (2603:10b6:404:45::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Mon, 1 Aug
 2022 10:19:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 10:19:39 +0000
Date:   Mon, 1 Aug 2022 13:19:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/3] cxl/region: uninitialized variable in alloc_hpa()
Message-ID: <Yueor88I/DkVSOtL@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0050.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cb82cfe-3cb2-436d-b78b-08da73a75760
X-MS-TrafficTypeDiagnostic: BN6PR10MB1314:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJHU6ASdAH744d/RYuMs8VETn9TSwePEZqjHcGdALQByNrU3itFOx1U1xNJla/HuCYS5VkRqkTReshq1V9LbEnsZp2kS5fyVdBiTUUTGhIHKX2cR+vjpXDtVGG1STwOTMM4V1ttjUR5KHJPurONdsMgZ3A3/tpqW0wAsDOoZfTeWbzjCxdf7WLp8avPnWLwNMUlCVawCEBb74gZGUMeifjwwa7BxB2lTuYdajGXY6EKdZWuacOkINzFCdG9mCtDfrJNnV/X/09xFU0WvDNKA/WFmnqx2HuA/zYwmrdJUMoJYCyRZhq+uF5Ffg/CLGnRcMultnhI6Y4JpjZAfcv2EpqHTdf/Y9PIVxnhu4wQWNVCHSQGh2mk3psoQB0e7Ky+M8XJ+0uzupcWQnAGRNIJcg36lpGSKQXST8EIrLeuYTQpscASE4dxH4s/i2AtOgDL3JQrlPIlub7hjO75qp9Sd83uGBGZAhY5e6TAScRmtHWUQONAZySkjthKVF0a/HWpiGY2RWB4K2tNPfhlKMAmlSOEtIuDHIUC8/A6ZxNP4GmUXu5+r0XulXyFIBp6BGhGdyD5YmYUQeYtjk9YEd8li6Sng0MODcc79Bz9j6kfNDUT8uwqD6lXUqBsynVrCVSZOsUEI5caPBys6KgiY/s5TRFivjcV1Nls9sLJQuWU7sEsrvjVt3utmgHY1fhotLrVXEYQSE4FUNhZgOVMfu5TrO/oRu4K0ZqNWxkR/r7OLTd0HuM99oNy9rbejPvav9EWqg3mUBileAglKkT+88nVgS8jGTGFXOxOpaToeCTlutsMo6OyFVNHo3UtfKTUvVmVQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(136003)(396003)(346002)(39860400002)(5660300002)(4744005)(54906003)(110136005)(44832011)(316002)(6486002)(66946007)(8936002)(478600001)(66476007)(66556008)(4326008)(8676002)(6506007)(9686003)(2906002)(6666004)(6512007)(86362001)(186003)(83380400001)(38350700002)(52116002)(26005)(33716001)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pbEG9S++1/OBivH1b/L2/1q19+CrtitGuLmZeqoIJlE5PdmMpXNAacN1mpy6?=
 =?us-ascii?Q?iMFRbkG+c+J6R5yyzYs4rSPnxNraTL5fg/2FHAIkTFaKLRSltt7/bhyo47yJ?=
 =?us-ascii?Q?J2wBVOdtVV+TF7ceoxGIbQttwb/O8fELhZ9Odb+EaHWKE4hVsqSASI7PK0ra?=
 =?us-ascii?Q?exbX41EvsWxaNlXlaYRYTjRGyZ1zTm54L/gEmW7yIK4ra60fHxbBIhOAQ4Dm?=
 =?us-ascii?Q?cjluW9LDYt57b7BeyfMOlbzqwn0jhaAMuFhUx8qLt4w7rqtthMrLourTSDlV?=
 =?us-ascii?Q?9Vu+23HDa8It0r5OYzJACOBKkzExZpEWrZ8s+q2dNvJwWc+zjXMyw7i+5StK?=
 =?us-ascii?Q?wCgZn6KGTK3Ny7FSa7nJLblbqIVOUn37SyiRfryNWBZIMED59L92E07Ql8je?=
 =?us-ascii?Q?oR0hgSXpsV/XLqTX0YgrlS6sY21YF1nTrNPJTPaB8JKIRvgWTtQQUXmatflJ?=
 =?us-ascii?Q?PGo5++yziIhFE1zqQo4afcqkRjUBJTv0FY+FLUvPmb/KbVuDwwy1e6F3FXos?=
 =?us-ascii?Q?uVfdNLwwL6gg6s6xnRbwnY2CeNaxwiKkLs0FztIwYeif/ageBT7Wg1OC26g/?=
 =?us-ascii?Q?yOIY3XUgXUfg8JCEYQaD3kBWvqYysgsRe48Cu7DeoI6cbEgilFHXjYdNMplS?=
 =?us-ascii?Q?Qi1b9SQpfLGpSDoyg/iC4OTyv4Hox4SAl83ZjMFEjn57wlskRX/69WRN0OG+?=
 =?us-ascii?Q?8oIbAUFDPddl1IU7im1ufggvr9JyMdmtcW7uuBI+yCAlygWXvv0fUz0ANa14?=
 =?us-ascii?Q?umFCKP5dIihWpylYCTKptyyT9zkJnhdMsSc0ImLcjESSwSStiP/vdbhJYykK?=
 =?us-ascii?Q?ANNQ4ksED0EGwicqD+avf2kKyBVn4k9zQd5WgrnGXm2N5WcLEewlLAoP4ry1?=
 =?us-ascii?Q?LlDUz44pcpt6WvRarshOsyPH323S1fhOo/r86ySZRwuhg4u++myN4NfDqvlx?=
 =?us-ascii?Q?WfjZbktZBeUTJ6/ETAr9a3hkHn0Zx/E8dvs+AunIU0hlzp5PLkbYM8MmpgtN?=
 =?us-ascii?Q?Vegh+46bEK3X9kbsMdP7pb429b7Sxs+UapIrQyv0eETDzTFzlMd88rFaFLEN?=
 =?us-ascii?Q?e2/wuNnA8WBtnIp5XYZJ0XtqkyPlJtAqgx9v/ul/RBJ71YU9BNqDhuWSdcow?=
 =?us-ascii?Q?gz6y5LQtkS/z5lnhi/jDCF33RDjkSuyQyiTLbtRlbRTkoPSd493cVei8bwcE?=
 =?us-ascii?Q?hDGS+/gve3+bYhmsoWBXww947/1Q2nMjB4OEc2Q9aAFGR2iLcAIm6HsegkOJ?=
 =?us-ascii?Q?roQkeVbsn6Xvj1iyRZUR9pwJAGmfxMNY+WWAHBzQx2sDbGwHpGeJ/X5a4MbP?=
 =?us-ascii?Q?BVEGemF2AGyu2ZklPUmWV2hS9LemubVzt/ZppjXHoCeelP6qfFekifji1yT3?=
 =?us-ascii?Q?gdNj03pB+/rKqc4jvVtFY/nDYLR2rjYGiSH+d6f8mtwTF/Y3LhziTMYEvQsR?=
 =?us-ascii?Q?ZFo5khVj9dV2jARFP0eL2hPDYENJrstqktMxylgiuJVboNCFDOwCScGNDBzO?=
 =?us-ascii?Q?OZ8R+Utd4CBxm3LXhMglgJoOgJ6pn+EGBSZ+M8hXBssvv3d84xLCH34It40i?=
 =?us-ascii?Q?zd2RQYs/iYdSENDzxOLNJg8pSmfkySXF6FCBai4JsglA7/PAAy7ElgCrL0Sf?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb82cfe-3cb2-436d-b78b-08da73a75760
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 10:19:38.9972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6kl0ecgHpgE9lRXNKzAirzPR7qAKFnH+J4Ku9FSt2Ie8nZzdxG095QdNSVIADPGkGXG8EZ6AcwjQTf4PntnF8OP/0gVr7s278mt8en6fB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_05,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208010050
X-Proofpoint-ORIG-GUID: HX3phkSYi7mVF-PUFSJw2RotHCVRw1zR
X-Proofpoint-GUID: HX3phkSYi7mVF-PUFSJw2RotHCVRw1zR
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This should check "p->res" instead of "res" (which is uninitialized).

Fixes: 23a22cd1c98b ("cxl/region: Allocate HPA capacity to regions")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index dc71ec457608..c80932bca667 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -454,7 +454,7 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 	lockdep_assert_held_write(&cxl_region_rwsem);
 
 	/* Nothing to do... */
-	if (p->res && resource_size(res) == size)
+	if (p->res && resource_size(p->res) == size)
 		return 0;
 
 	/* To change size the old size must be freed first */
-- 
2.35.1

