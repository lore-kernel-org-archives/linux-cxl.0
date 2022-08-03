Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDCCC19F2C
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Aug 2022 09:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbiHCJIX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Aug 2022 05:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiHCJIW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Aug 2022 05:08:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B1812762;
        Wed,  3 Aug 2022 02:08:20 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27393Njp031998;
        Wed, 3 Aug 2022 09:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=Sk8ScgTGe5P6G4WB4zfL2mxaWjV4tx1rWHCFUphe4NU=;
 b=A1UMptZeFr+hpxSbVrUPBG3dy16wBDq83MoISaSmIgzDH1mXez1lw1RaEaceKd1ZTXTn
 AbuufJWChU9ploM++ISC/3512s5lNFe2qwNsmnT1bGNLhiJz7ki19BuPQrZ7HKWfWZUV
 1/TkhcysOODIACB50UOMEupAIEHebt/jTSUdVvm4gAHAAQrPM1DmjWZvSxrqFKADgKL6
 ivmWPR4yQn+/fTyiJR1rYlOCczHxjs3iHrxn7/TIj++U4aHe6TNBCl1FF5p7Xx1O/74v
 0xV5MQfghehxDt9lZ9YloUyevNOlyvxp1qktxGSgvtw3ySg7X0rIm1T0Qvi2dEXxrNXc ZA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmv8s9cbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 09:08:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2737Bv49007338;
        Wed, 3 Aug 2022 09:08:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu32vrac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 09:08:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNnfKL0X4fNXZIAXJ01FCCUkEamdLZVKs87pk3++98hM7SPQEe+lmPyCWE/sZCAjDx5zoOWgQ0THNv/lvAfEH69Y1HszFmLrRzK3jZBq6PmwKI9AsOIO8buNfj8h9vCGJo2kA65imqHR7av2xWTmEGmRO/3l9HWg7bBWnSis6opOktr0S+dyNtr27wx2WipT+T0VqEVhFIi0aH609Yk9nCluDKtnFQ+8IliqWP0+6wlJL6pDsMe9n8PaBujrNji6aNU7KUELw1K0xAWyYL641fy76/XizAvusl3ohdVF+RJGLk96CofCnq0aIlw2vNPRlIDkKXehhe8752zEiqaMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sk8ScgTGe5P6G4WB4zfL2mxaWjV4tx1rWHCFUphe4NU=;
 b=m1M+2UQLijXFxT/HNpvCIHXsPCb9MiNXXu/0M7/Dvff04L16d6aeN6M/Oc0THatGpJRIbvpB/hcVvnDdH3JCeSaf4KxCIKfgspI5KvovUFVxnZpYlg7aSew42v+UTzSkKOBtmvIkRBTLuN6AffRaO1euZJ+Gv++aC/i8Zhs5LjeKe4rN0el/NRNfYQeTp3j8gYWmKXAqhk2hOd+iP2M0Phzurp4epcjUgBQ4crcBbCPSGDcc5jvF9rdBN1N+B0IJbQsqH3kXSoxYl/R/Yx2HBgyLfXlJ8I3YyLqbYEvN2K8NufuZhq1/DCj+AM6eL4txKFVm+f1iQe4iQQ+VmZJDtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk8ScgTGe5P6G4WB4zfL2mxaWjV4tx1rWHCFUphe4NU=;
 b=Yk53V2GnF5/PUDILds5teRaJ8xyVVI7uSQw09fUubLbncsgR3JysRBn5/TwwzhKcSvo0Ct53b9cHjWR4ocnSOPtTb86T07EeBD/hKv/TiEX+lFFxPOfOjS87ulbt4yYZzHcjcg4rAis8KHRhWGBxK/XNDrxAZEtAudY8NaSvjyA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB2735.namprd10.prod.outlook.com
 (2603:10b6:805:46::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 09:08:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 09:08:01 +0000
Date:   Wed, 3 Aug 2022 12:07:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] cxl/region: Fix IS_ERR() vs NULL check
Message-ID: <Yuo65lq2WtfdGJ0X@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0147.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3b6dac8-3aee-4a31-ba7f-08da752faa61
X-MS-TrafficTypeDiagnostic: SN6PR10MB2735:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azimwO6bRnvJ5Wqfufwcv/w+qODLxblsna86Pt4V/Ma8V/OQO9pWwiUGEVmIWCgGJ5VZIL7pWJX5EsoOu4EHjuBDz+N7fN2JA02dVHEyIzVICXdz/pOqMYU1R3wUaKP8uhWFn+nfMjMPkUSuSN/n+aY/1qAx6OIrdA0pgAIoXXiTLNdhVbKbaqM92DdjlpkH9fALvXVxzN0MWcZ/KEdFV3qomiZUKVVmJEWCWQPJ7Ljxag60TABfS7nqN5xe9nhB9m987peqgqxa9j47bebbcK5BoPTaCdSWp8vCvNDClE050z0GhmkFnKguwYuyZW9JnlCjfT9nMdPLftvIJXASAypuekpSwnbFHQ3AwJJw4f8zD2m/hjtA+gJtUM9Pi+r/fcG6s/iNfDfNUvvxyoW/ViGgaDeRSdBo2oEEERzHmrdpSSocwtu0tuuB+JryehtgnOd7YgT3dh8ia3CjQYe5qTdEbMY6jQzg8yxmxW6L0FDSrA7kRfLuLSqq+E7JxJdjfsSPwbZ2UxDSUwT7kA2zRB+9QLQDuWf4WRWRMrikv8WoYpo55Y6cEpmf33ogCrkh8ey3KRVJNxGztRxZ8EwwnohrMaeHywXaRPh0O9189sTaTQ71Z+klhWMALZoWXrSL5EnS0IXtWygaOAfB/TZ7aZrANaPZTpp81NrAIi9VarsNJJoIdW3m0c+f5FPgCnRC8Qf+myunxwQLl3+ODdfa4hvgcTt5b5hp/RrhN+THl1tZ+PhmCdUw4XibeUccVQhmYcvtsx44OPnlsLBOWe3QcFsUtYX6hmTWkdNmOS/mq0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(136003)(39860400002)(346002)(366004)(396003)(8936002)(6666004)(41300700001)(4326008)(6512007)(86362001)(66556008)(66946007)(9686003)(2906002)(26005)(4744005)(5660300002)(66476007)(44832011)(52116002)(33716001)(38350700002)(38100700002)(83380400001)(186003)(6486002)(54906003)(6506007)(110136005)(478600001)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0V+aRHnhnw0Sj2IMnKCQkw0jRYwr9GRKhiUr81EFfHxpZaa6fON1IGnufWYW?=
 =?us-ascii?Q?1P9Kga+ZNPsG3MCkKYcXde715VKSDRrlI+l46aQvbKe03Uye4QmX9xHaAt1y?=
 =?us-ascii?Q?/xpyhjcSaGP0AhnA6en4Osr8HYFz0iB1Y7XyjTKx3bNtpeRgpz63II4lYhyL?=
 =?us-ascii?Q?He1EYf/xDZNDxRKI2ZOamcuLdhBxSLMpaTsWdo46CkN/DIlUTG/DR3W1zFkU?=
 =?us-ascii?Q?LTrj4gmMv5ZidhKKPPcsDGWF7GFRukSTO5m1A3BEiEF5bd2sxOWJEe+Gjp3W?=
 =?us-ascii?Q?OalF8j7pzKx1G9Gafxmz6mWzjpFAolFSdA1puH6opNw8iEajzT5ddvbD1TUP?=
 =?us-ascii?Q?ktFMP/mvcRxdvizGUwzcQAAaTkgS1UlDDSmLjIaFBnhfl8cMGSEtrqGFn2o7?=
 =?us-ascii?Q?Ux6kh+eOCnFmddrhbJeuxGrQuMXB0y2OnQI/pyGInJuBIpC0Yl4i0CF72MlI?=
 =?us-ascii?Q?xT8Gm/TDdSmUQieI5racxubSDjQo1kpHgBiQkkM2OAsOZ/jGbAUXjluXQ/iH?=
 =?us-ascii?Q?WdZTM3/BNnFlEW3fGYB6ZDVMudPULZERvh5/iaY922Bsp3wQr232MU4uBJLQ?=
 =?us-ascii?Q?xauP9j2Wq+oy+j+paQOPvhwjewcZ089u7lr8CjYeFqemhOBoyASDq0NZb2Rm?=
 =?us-ascii?Q?5RuvH3n9v4bIUWa6IxMppHjT4GAyzAVz+f9cw7ccLV1evEog7Ui62iET3ToV?=
 =?us-ascii?Q?XaHczvfupjK2uqt15IGODEOmsvO9fUFKO1FaAmZ8wXYv+wvWO0gl6mL58T/D?=
 =?us-ascii?Q?cVMlmwXEzrDACp7kphrHw7xn+YX9w6m5CXMxTqdWJaKG0Ro3hkhmqP45OLFC?=
 =?us-ascii?Q?Zpj1tXe6w8DpDcA0PrsvcBhJiynKivfDrNiPzZYhYSufMgP14Lv6sHao26Ou?=
 =?us-ascii?Q?1xFqOQk1eZ9jM7RmDxOk8AIuwF0mYmLgyCWgQ9dYLhnI8+/4UnXmgRNvprVE?=
 =?us-ascii?Q?9vxMY7CHCW/s4UTPHIeY7gmlaw5zEOU5IEC0IUZFUHXHqrnjn6DCUfUmjXFY?=
 =?us-ascii?Q?kFMz/tAz7ORfotJVYrQm2v6E7HzE0KTsoYeeaVKtDNWf47b8GqBG0ngi1t/8?=
 =?us-ascii?Q?jJsnjCW5hLgfW3Sswcbzhws0VFJm9W6ERw9lvd+pFA/2YdfWcYoNa16770ib?=
 =?us-ascii?Q?DQ6u1qEe2t9C4xbhhCghT05xFwM2A01mpGaaJ1mZz15pzNfAt9yBJMg33m9D?=
 =?us-ascii?Q?tqA2tGJftVWQj3JEZpToTyRsvQ1KRsQR6wigboMIf1vutg0rRxL8ai1AiN7B?=
 =?us-ascii?Q?O2yZecFW2KnIB1U4q2eXdrpyMl5liaYsSQvHP/uAcy+HGe7yehSDoOlpRXdX?=
 =?us-ascii?Q?mSNKLMvrMvFJh4+P7KLbBqf+NojXFqseNrEN3nuwCQ2TSrWUCvu4yR61yWcw?=
 =?us-ascii?Q?bjBtDWzqVmjiavY4AwvMADJP8qMUbS+z9eYinXuWdR3Z6SJ0p6T0qbMK611b?=
 =?us-ascii?Q?OfFsmjLli4kmF6SCJrhC0XWuCwBQRdyaHoUwjAFQMuF0o/Q06Oluq4PrlAbq?=
 =?us-ascii?Q?hoFfkiz1RPA2afLezTb6tWtwCAQN5drsC48OX2tp2qukvSluw3x1kaSACzVm?=
 =?us-ascii?Q?5WgMSZGxWhx9BQOqxrF6kwdu7GdnzPJHwTMOKgeQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b6dac8-3aee-4a31-ba7f-08da752faa61
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 09:08:01.0040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DW8yQlguxre2QxiD6CW9glxPkm8YeIaeH8AWPY6r68fzCRMvhML9ewbyUDfM4gMse+UTyTXa43ApXPjCF2pEcr5+q3fgmfTgzltwozL8c4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_03,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208030041
X-Proofpoint-GUID: zo1IJ21olTi5riuKEc1wypm9Hy6yb3c4
X-Proofpoint-ORIG-GUID: zo1IJ21olTi5riuKEc1wypm9Hy6yb3c4
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The nvdimm_pmem_region_create() function returns NULL on error.  It does
not return error pointers.

Fixes: 04ad63f086d1 ("cxl/region: Introduce cxl_pmem_region objects")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/cxl/pmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index e69f99a0747d..7dc0a2fa1a6b 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -525,8 +525,8 @@ static int cxl_pmem_region_probe(struct device *dev)
 
 	cxlr_pmem->nd_region =
 		nvdimm_pmem_region_create(cxl_nvb->nvdimm_bus, &ndr_desc);
-	if (IS_ERR(cxlr_pmem->nd_region)) {
-		rc = PTR_ERR(cxlr_pmem->nd_region);
+	if (!cxlr_pmem->nd_region) {
+		rc = -ENOMEM;
 		goto err;
 	}
 
-- 
2.35.1

