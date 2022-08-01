Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1A3C00144
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Aug 2022 10:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiHAKVZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Aug 2022 06:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiHAKVY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Aug 2022 06:21:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B5C14031;
        Mon,  1 Aug 2022 03:21:23 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271A0Juo003148;
        Mon, 1 Aug 2022 10:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2022-7-12; bh=RQBXb0JdSg5pfO2KK2+p7/c0U9rL4SQCRXl11ErLCS8=;
 b=q0E439QK465PbI/h7D9iGnHQhIx+ubhYxFxSoX3KZEkU0OYB3TjDkP24DNBYXDCanPUS
 o3KeaPL6G7B96J8XCaOTUCmK2zA2Y/4U94/bhK6nFDpHfctT42a5iys9f0qoeiRw63lg
 fpUm3UgLaGyJriVKZ0gpv1MEiq/64AYcKa2IkycSZwHGMCu/5Wzwv9Im80rhPv4m7UAI
 ypMz2ZPCo5OvjES2c79dllEdDlzQT0PoRCjRkGHXj0/h2TNOY/+qMRfC2DxsqkATCHAo
 WrViGv1Lf/6ZNe+y3wnH7JBjEKd5LxTvqFH4fGtrqYvQ62t3+vqwVJYhJnrReKmdEdRY NA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmv8s37ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 10:21:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2719sY0R002985;
        Mon, 1 Aug 2022 10:21:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu314hj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 10:21:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsrkuKDWY10bbK8xXGu7rXvqufBfl1/B07nguAklDbWWYZJK/6R4rDFD7Ja6e4eVGgQPbMEre34p8MDQiIvNvW7HIjBBjD2moa1jEhXpd811IrQ0ky2hUuPKb3G7VxQlxLJAZHmB+egElfAVoodM1N5ZGSrJ0zKPmqqM1obXsGbpy5NEUfenbcQePwCOifwTy0ZoL9jwS2FxwcvPEH77vB7FJVDpDZceAYq+84/d+H3ro0uKTOqv6ukGafpR0eJne/6GUjBPh1JmkMUFy+qSe3PZISKp8MGOolM4HJbgAiR+rCo5WrcPXVLUxQJFC+zTMQQsm9RYOQQBaB7DODw+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQBXb0JdSg5pfO2KK2+p7/c0U9rL4SQCRXl11ErLCS8=;
 b=gJWzesc88O6M7StjQFPGXVi+UzY1sXzhBvwewPfL81Mhe0yqGuJAkcCWxkdE+dMJD35bqpWinKIFLdVCKOUfPD/VMxcZ8ROOrnKK2nwdbzz3KCTD4IGHkC4gvlWrWU2wPw6+Y1jMNn5Ot6aL7m1sbgaZx/M1RpA7xIMkBEJazoOLhfVPcykKvKIP4ZmZ22d0rKxXYjbdsI9bCs+/3K0dBQxzb50+Nj839ZDPz0i1zIWiLAJfo8RUlwhwh7S8JmDhhsI31zoM+0UxyIieXUdcQgWMbWOCUUBIFSZvTf3wWg9m3NLriWiXCvxGWCfCGJ4Qgr10EyvU7yzjR7a8U859wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQBXb0JdSg5pfO2KK2+p7/c0U9rL4SQCRXl11ErLCS8=;
 b=ZCyVx94nyRZlB/AxHUWeV4gKtuSipN49DzIreS7OkUdHnp+nV6BQaoruASNoWZyJdndEryMghzJF7V4BfpaGrqzg28eSRVRaYyvL/R3XZyDsX7niqBw+SkMSqZ/j8WPTy6PKRgajrOaDbX7bAZyIi5UOMrA11SpaAfG8G1bCnDs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1314.namprd10.prod.outlook.com
 (2603:10b6:404:45::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Mon, 1 Aug
 2022 10:21:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 10:21:09 +0000
Date:   Mon, 1 Aug 2022 13:20:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 3/3] cxl/region: decrement ->nr_targets on error in
 cxl_region_attach()
Message-ID: <YuepCvUAoCtdpcoO@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yueor88I/DkVSOtL@kili>
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0037.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::6) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f25a9aee-8903-4d82-4fbf-08da73a78d09
X-MS-TrafficTypeDiagnostic: BN6PR10MB1314:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0QKkTiwTnwtEB/vEfCAMSOfFugRNNmUJeMqtDOFyPwk8eole66FPg+JUEBb51gzS7vUpaDWPkmXjiotbKbuNAyd5vumrmd5yKlkCKgY+q1AfIFWb91n+kY1aQK6fsCdBErV263yX8gtNfL38JQUH1kEE4z93J+AFxCghIMsiMem15t+chXfJ1CZYZfZb0ZI8FjAy4RX9JbxKQyzhDZxD2Fc8fVwwJiv0IEY94fIpIrdJla6KER8zNOhvw/FbPZ5FAqDeQ2GLN6i+LsyEY2dgCCrojaMx81KG6G6uC/ZZEeaCD6RQromX1sTuT4fv6SnLXkvEpFYBh5xDHSNKkjd5h4JYy4y8WSqd2Fe2ArgoEFYVcQNKuqRIDdOcpXJmzAcHfw849Fh9VGE+Vh3Gp/XHZ2Ff+IRja0P5klIe5m6g3noUVfldLOTjXx1wMFNtdfYp2rbLUIr1d2dbC/E8f4rfL6SNUIM2/GjeqxRSGXy7oJw4vY9PIPH58x4A0CfYMuljlxSMyKUj53pK2E5W02E01X6Im1/PzmEUS3yemm/an37uxPZkcrjeQEuHFCVRZr/JXzodDtqUmNpMeUR1dot3LJ3eBJk/SQ8/+9ZG4HKhyFFhqX87lLGk61QU6r4mlMVP78sGbzfkED4yHhv/PUvmX5uAjD9RYMEU3k88XHpeljBkj4a6GK+9XITJ+MmumXz/Rv4YYpInW9C63e7lRZriLjkwih6ugiABCmjT96Uv//U3hFOZDSjKR3wVkE+Aj2quGh2IyVMZGmx1yRnBq+iz4ggoy6NyrHIO8J8xemyPqoKpPoSkMdaDzY3Eyz60mjUB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(136003)(396003)(346002)(39860400002)(5660300002)(4744005)(54906003)(110136005)(44832011)(316002)(6486002)(66946007)(8936002)(478600001)(66476007)(66556008)(4326008)(8676002)(6506007)(9686003)(2906002)(6666004)(6512007)(86362001)(186003)(83380400001)(38350700002)(52116002)(26005)(33716001)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z02IBXY4MXju03Hdvv62wCg3BfQI86oDBvmdGran44d9XflFQpdrOGmTC4ME?=
 =?us-ascii?Q?AH6ZJY9t8RCSbx9oOS1OCGgCDsnVOQ05pYlVLXkaXx0Mnb4aRZphwLXnMZmu?=
 =?us-ascii?Q?AxlbNmz7LoEcaKkwIuGcLolHO5JGuut3EepA2BGElIND2HmFpvwnk8VGruwx?=
 =?us-ascii?Q?0L3yLqsbHny8uN/cJGygbg3XJzRbQOl+0bP95ESFiKCW3R1ji0zFXusZMGM7?=
 =?us-ascii?Q?XNjnryyk/Hua65sqGFn+9VtKO3oaSHhFij9ACEH9CJmQH4KO3iwE/k+TrfWN?=
 =?us-ascii?Q?T9cmHqa9POmQMBheoYp21gVYb071B6yJ0fr4pt5i9eATBCC25fyoO0KVXXC+?=
 =?us-ascii?Q?iYBapVyf7NgehXYqWCtamZbIs1fQa9ExURjJYNv/poV9TWTCN7wgoWx6ly3g?=
 =?us-ascii?Q?Iho4c7sSTaujPiBMr19aE+daLdjVaskqKr7f5fO0U/c1BhtVCPr1xaEu+VuB?=
 =?us-ascii?Q?9y9zCaBWGfK4egcjpqeTDmsk8OLILzZdnI9w/FFBMq06deDbflLoBwummx6d?=
 =?us-ascii?Q?kvcjkFtvjaIl3rkQ5xF2kT3BBKvM2a3oKg15myi0f5VtZxhs9HBscLroD1Vo?=
 =?us-ascii?Q?j7ltrPySV3c7QCGcJV66w8VUvvTEgtBHc0ln5E/wk08iC9s0FTfZE92z85mF?=
 =?us-ascii?Q?x01VHiiWHyukhXEw8f2SFlzB52NKOL1DXPRyL4ERZFXRGsO8/pu4UynwnInq?=
 =?us-ascii?Q?Eb6keK1EI+oVtUUGdQ6UUwqAOlqjckPckTLv2CU6RT90fkf/mHiX0DHOZ4hL?=
 =?us-ascii?Q?Z8oklS1TEBZ/35jbrvUheEAjsDGF9czhHU98TFXTbJabIWMQlyROhB+HQ5ro?=
 =?us-ascii?Q?DZjOz8yuSoUhT6HYz4Hm+x/9m4oSJvGXsxwWBX8vbVQsISz+V4fEt7szDyUu?=
 =?us-ascii?Q?/lKQbbW0rBmeSRV8VZgpEQZV/1A2y0EZ4F4K1q/HFxSPt6B2vDdSF8OsioFH?=
 =?us-ascii?Q?3MMxRpgcg5epsn/1N/XzfMWazuQF3wcSnfQEtC+SCCmkdGaLDI18vyGS82np?=
 =?us-ascii?Q?YPwz3hnlh9lP/iI7W8ntrViQSuJziM+HARUgqohXwU5pmj9VEYEP2j0MEMU2?=
 =?us-ascii?Q?DAFRQPZI1APsv3JYwfpdt2MybJAlIpPG6MxDpgY1wLMqd2zUV6fW59ZEeOF5?=
 =?us-ascii?Q?cWNXB/mIOGOYaEfyA7pqQ+0Rsz47IZNdjjj9tGGdcAtU2coXuX7+8W5pClpG?=
 =?us-ascii?Q?QJsdXu5eNtSWvEgIinDP9PyLyKLHIZUpEEwv3QY7CYGHblxFldtkW8lVBsmD?=
 =?us-ascii?Q?od3XhFCnFOC8R7i9XqtL+ATr5zEwlhoJlckl7lwl8xM9tGZKQqMKrthEmhMX?=
 =?us-ascii?Q?imrvyAr5jM3G23WzW3oXA8nf78ZpFr3ZMAHF4fGncJoChc3eAFflcpgepjpk?=
 =?us-ascii?Q?H7SDfmSh+wYO2jXqRn6nGwqi0EyZaNtxdvcBoZoQo3msPz3m82Cz4e1OZyCu?=
 =?us-ascii?Q?07KtQ/2CMxyR258YNpmgyXBiwbKE2r5UvyaCJDUyjbIwAaiMKkJUQPUm5p1A?=
 =?us-ascii?Q?Wngu6UiX8SK4AZ4/T/kGeLNRkJ5CQ28nzhZSW9ki0DfFIYe3M6YUz9pocMK1?=
 =?us-ascii?Q?lHStNx72u2+dRbxiP+EE3wuRP8m6bpjm9cKrXg7ySeW+OYvN0B9EGHClPMdI?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25a9aee-8903-4d82-4fbf-08da73a78d09
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 10:21:09.1932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QibYDt/A5Zhiem/Ujo+N6TlH0k/2cnpgJAS0obqtO9Cyqcjulv9xvh6nw28g1W9OC2pAs7zOg3WJpgiGClxlc6g2/nJAI+HUBt88oyQ4MQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_05,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010050
X-Proofpoint-GUID: hbLRlZKbjcBayo_d2TKMVD8RkhzU7Wva
X-Proofpoint-ORIG-GUID: hbLRlZKbjcBayo_d2TKMVD8RkhzU7Wva
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The ++ needs a match -- on the clean up path.  If the p->nr_targets
value gets to be more than 16 it leads to uninitialized data in
cxl_port_setup_targets().

drivers/cxl/core/region.c:995 cxl_port_setup_targets() error: uninitialized symbol 'eiw'.

Fixes: 27b3f8d13830 ("cxl/region: Program target lists")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/cxl/core/region.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c80932bca667..0450354bff4d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1217,12 +1217,14 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	if (p->nr_targets == p->interleave_ways) {
 		rc = cxl_region_setup_targets(cxlr);
 		if (rc)
-			goto err;
+			goto err_decrement;
 		p->state = CXL_CONFIG_ACTIVE;
 	}
 
 	return 0;
 
+err_decrement:
+	p->nr_targets--;
 err:
 	for (iter = ep_port; !is_cxl_root(iter);
 	     iter = to_cxl_port(iter->dev.parent))
-- 
2.35.1

