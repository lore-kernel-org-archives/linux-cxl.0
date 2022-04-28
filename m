Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096B6C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 28 Apr 2022 09:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiD1Ju1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 28 Apr 2022 05:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348859AbiD1JmK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 28 Apr 2022 05:42:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D9E972B8;
        Thu, 28 Apr 2022 02:38:56 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S9S9X7032133;
        Thu, 28 Apr 2022 09:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=f3IBmG+KYnR10P3n/TcpNBkyH/RMZ5V2F2eqrlVJPjM=;
 b=XQwWoOAEwK6ferD3pqNKf6EBUEEaDQbdHxDM/nBJnAzcXeoJl+TO1TjZutH6rI23/W8B
 ciAWNo003mIKyRaLHm1cYBCRRQ+hyxwHZAd25szcu0WyB7ryxN/rLpbawIc5ovHV0oAD
 1qbZD6C/owO+hcR1Qq6ydKrOj08/ls6anVpEFw5T2mCX0/8QpnnWhkTWGOC+PDvBuHCq
 r8DUVc6x18Zp/CRShSvjVkOYgGFi/q8i+GDcFynvZiFGnq860ucP3OEjJkikgSiLw9kH
 fD4zD1coXSN1c36tKKBR780SvQhjKFD72A3JUF3n196AghBSMejWbehClPqBJ5IiJ2t/ 2Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1030hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 09:38:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23S9ab4l036475;
        Thu, 28 Apr 2022 09:38:39 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yndapk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 09:38:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0TE4EK4BYKWy+e9jI1vB1SpyA2HvKwgYBh8FAxzmxiQp+Oie6AWyOhUFlRSAOzs0e2OgYHhrhKN636aYr30itx1jrq4ADE4o1TTE8ed2tv7bFXrC9SC7h8HwFtTkL4wqftZl90LLIe2tgBenx72mOE9dhQpyxtuRcNE1SxclJ193CHb0XgDnVU7f+7sGkKk++mL1Kh6lD9KFAJ4q0E5nVeMIBvEZRdCBEfh+XWYboyIbghrOYrqePEiLzEDzcY2/RHnF+UBH8OQDVAklg5sFYm0M3DskQVUXPUmXGkjukxAvFi3yfnx4vuA13bpI9gaV1iTZhxLfjXajsJBVAp0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3IBmG+KYnR10P3n/TcpNBkyH/RMZ5V2F2eqrlVJPjM=;
 b=JvfvDToYMDN8qSQW7d3fjfpRY8t7Dbm7LxxJIikyo7PEISMXew/qmFSzJOPsIQv4FEkszUUHK+HYl3DIg2naIuN0iQUu6xVCc++CyFkRvPryPxtRmOACAQFhv5uQmPAq4jHahGpTP9o+KGfAYvzhCCtGq6KIPB5T3h+UxMgDt6jN6Jiw3JdTTmRTZ1MQ+ZPVIqjBeQ9BzbDgzL+xysZh4OYFOBfIFNzz5UUYYQQ1JDff3/6GiuwcQ55fKp0OK/QdRlJeQHjxJsCptJF771v41lmKnox8KWVFtGeQX0QVhHkE2539U+REIvzcqnFaDLV9cZ3wQbLqEroBONXVMDhxAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3IBmG+KYnR10P3n/TcpNBkyH/RMZ5V2F2eqrlVJPjM=;
 b=BgjuqzE4txeWUxJFazEV3wa6aFBIk+P2JG22NslLYCj2Y40eGkvtbLbP8Qz5cwxDp2qFiLdYPKV+YE4OemLs4ve7agBJTmvvZb0Cy/CX0GXKV2ZyHYPofrqqjh47OGs2WympUkXN5cGZkwukUBsly6g0YDwgDqEwP4nUUEz0Sh0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3099.namprd10.prod.outlook.com
 (2603:10b6:5:1ad::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 09:38:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Thu, 28 Apr 2022
 09:38:37 +0000
Date:   Thu, 28 Apr 2022 12:38:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] cxl/mbox: fix logical vs bitwise typo
Message-ID: <YmpgkbbQ1Yxu36uO@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0004.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4242b325-7ec5-45cb-1360-08da28fadeb3
X-MS-TrafficTypeDiagnostic: DM6PR10MB3099:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB30991F9742677BF8B8936B508EFD9@DM6PR10MB3099.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GN2h9zARY+52GWPErHO65yLKtFpqkzZlXc7Z246c7OvwtspjFm1qFYZbGtWb33MJ9veYCBJKBhD6fUpVQNZ1hI2IzTyQ7DsMyy6toCVIgiZSS8cgRFQVrisowFFgv7LmHNturF8waf03wfK+DDtOnjE+t6JS2y5auIZ+X4f930YDp3OzptHaVPO0VG/WHvKio+c0SaXk20L2AMM+Y6yMcfUN6PAZXNDLXzfZlQPzfD9/kG/9p1aucQ4xi0lMGJ142OcEp10a0kRwIW17u/b7YpPgDtbiiYLwjrc3vUXvnuJEnaNW5tyuD1bGOFe9CZPqrFPXEKnsGfI2060/XAe7ZYJ0E/+7A9ubniaGp86Ct+yxWgIJmX5NU1SV00uuH723vpDuYWN0gwSYdgxx9gn6qafqNQCEh3HTzwdfPoD/x/3opxWqogH/iRemc6APSEl5dpmNv0AjwvZaiBO3qP1jHy+Mx21FSe3oJhCQtSZz9sLRib7egfu7h+NW4DdjlKJ1V3378Lvfg3wR1UqnNTq7UgkszqRxJx5Pog8JMDu/Z1DauJuSGWHBpfKtJtBdejKzZMnp1E7yQWFkhpR8jdHBUSdVmSmeqIycAresHbGNzzQkMO7SXkXNfFXxxJHMuQK3ipHBIDkuOoqU5ERoIHtQCuyKEvVy7Lld41ohKIV7CE16dwzu+R0xrULtL1vIeKv6yUJb7aXp+bUJhhcvGMOSmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4326008)(6506007)(186003)(6666004)(2906002)(6512007)(5660300002)(9686003)(33716001)(44832011)(26005)(4744005)(6916009)(54906003)(66556008)(66476007)(8936002)(8676002)(508600001)(66946007)(83380400001)(38350700002)(38100700002)(316002)(52116002)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PhKXSSRtzB0D9dpW4t6w++T7lUOXJ/GT0Mjf/HBKmpeZoqKjQS0hAKPhuFq3?=
 =?us-ascii?Q?RqFTDzFJGCTahbdUQCo5/171u7uOaL3MPNyVs6Q9tgepNYOykm85HK4EjqO6?=
 =?us-ascii?Q?+CB8TQQ3xaZJJQYqh0BqPlpBjOpsOV1qrmwJD2Xoe1ycAMALDEUjSntKGbJl?=
 =?us-ascii?Q?pg6YE7JiJnDyoSbVZJmuT7/NsNDWJvOIKKK42WGuL5JKIdNBskTgY0EEqE+x?=
 =?us-ascii?Q?UNOYJd519QeS/v3MLEObNEUPHihxpWM7sMHXe+UANyudZ4eboamw9c/pl6Eo?=
 =?us-ascii?Q?aFTr/jxs6xOk/mKp+xfDxoxYcQ/Bcvp9gOEdn44M37y1kzYP3UG9FS/n87T5?=
 =?us-ascii?Q?mr35bnu3pcd7z0uPejMm1wYOCllDth2pxLwQslQKwjdI6LRV0lykRvC20Mbr?=
 =?us-ascii?Q?r7QvLNsFAdLBVn9D1mMbRBmBCIC1/Em/qrORkgiRYWv7aYw0rrULS6yS7W6A?=
 =?us-ascii?Q?rLulYEzhcVo84lZrOwaVH0vzj8ONbF5NhzuasDlrD3h4TFoSylnUiwqzBkET?=
 =?us-ascii?Q?lJvJ8iIvNTejL8tPC5qfCM059TWu+9uaWXz1ZVfVGPLTfFAjRyPMXYe1VJV/?=
 =?us-ascii?Q?97gbDSRVo33IY7dhS7BC4r6E1vvAIXI7GAxyQiOmUft3nqaa5pxJyRoZAd/K?=
 =?us-ascii?Q?4YUUlDkgY2ZJYw/zAMsAaLAfo4xhhVmpVqGSwcYM0D3WRKFnDeNHLQzmrnbU?=
 =?us-ascii?Q?PJkA5V1gf//JqgyeOI7QlxVsX52Wf9MBCeBQpUy+H51JHyB/fea7q6kUwi0E?=
 =?us-ascii?Q?xtVxdXzDuBgI+vmTqOUXARpG7tKWnc5I8QwkEOJLLmWhXDmUpecUmZcp6fmN?=
 =?us-ascii?Q?yvYQ30A4kxLkD4jSMfA3Uw3u+ItzUgHG8SWO1sFjcLB4kq/AiFxe2dklh3Wb?=
 =?us-ascii?Q?/8mxIq9VWvmbVbKjg9rJbXVkZIvXnEWjfQZiCAtWg30SOvAyQrkYKD2zWWDX?=
 =?us-ascii?Q?+Utuhk22XcJyw+YG9wBsn0X/i4dJ6cyulai/XyqmJFF3UeJZ/DsLHjGjLwoX?=
 =?us-ascii?Q?ISQ0ft8SZqbd/mmtpXCkZ7ZwLdr+x84JIb8TPi7BBYLcLstP71Ml8wg0WS/Z?=
 =?us-ascii?Q?XzM7I6l55c2nPdRDBxFneGYuX5j6vOX4Ryeqz2F2ftB8359mXAgrxMvuMzA7?=
 =?us-ascii?Q?5iSE7jLWRGRjuL90rad0ITc3ZUTsIbEOBqC0Sl4T2nVrPLBts2ZjU68U2PCo?=
 =?us-ascii?Q?YpZXTfhC2MKILGvEfQxuAm3H2TG49sqvg/jbnqRnQPxYpepKJNukChxwSLSX?=
 =?us-ascii?Q?V4f1Hf0JAffCFjN46fJWcM54Z5R5Uy1FtUTsaygeRdHBbXgaYilRx5GRjSHN?=
 =?us-ascii?Q?19GqbjKD3JrGjgwBMZN6gXEJKhP0JxOjjVFwdTQs5yd2QLggaUg0gOB9FZuI?=
 =?us-ascii?Q?vU/9MkZCWJpGRHS7MrDHhQKghcwts6gK8VDtJIUPnxXbvWb+NtkD54rksEME?=
 =?us-ascii?Q?gr3b/POulTe2wEKXdJ36Hq0/gVk1LPaVcl28ltJNSonHHN0f7Jyy3IX8EMpO?=
 =?us-ascii?Q?eqHCqsrEfu/Wdg4g5HZ6FEPSH8bY2x6yVGYrm/NjERhSMliV7rPGUs1HbyOR?=
 =?us-ascii?Q?EIGSOcnYwOIKeT1O3t/7qRPDr2PLT0R0FCj4i8iPcynQ887uR5xJMVpfoOSa?=
 =?us-ascii?Q?0p5jhqWRw6FJALOWG+ox5pYDiQyqF9vffJA5TPYz/khWA/ByAiDLrNvItAzL?=
 =?us-ascii?Q?z7E/lmuw41oR9axJqfOQxOsK23Gp9xMDKQVVzUkGukVCA224d4iEymT8X8tg?=
 =?us-ascii?Q?L1cxgnN5DC0IVhKKiiy7Zo8d+BJcjdg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4242b325-7ec5-45cb-1360-08da28fadeb3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 09:38:37.0809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwPxz+hIPaBTKH7/C9K+4QXuNcH9sVjrMMpVq/tJFRwJ/UgVouzidfq4O8xSVpUciFaEkXAguiuJwMJRBIX9sRti+4m+Bs2rGfN0QZeLInQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3099
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-28_01:2022-04-27,2022-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280058
X-Proofpoint-ORIG-GUID: vlYLoFrY3dW5QI6QzWTCYQDY3obhyduW
X-Proofpoint-GUID: vlYLoFrY3dW5QI6QzWTCYQDY3obhyduW
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This should be bitwise & instead of &&.

Fixes: 6179045ccc0c ("cxl/mbox: Block immediate mode in SET_PARTITION_INFO command")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/cxl/core/mbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 731cb43b570e..54f434733b56 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -243,7 +243,7 @@ static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in)
 	case CXL_MBOX_OP_SET_PARTITION_INFO: {
 		struct cxl_mbox_set_partition_info *pi = payload_in;
 
-		if (pi->flags && CXL_SET_PARTITION_IMMEDIATE_FLAG)
+		if (pi->flags & CXL_SET_PARTITION_IMMEDIATE_FLAG)
 			return false;
 		break;
 	}
-- 
2.35.1

