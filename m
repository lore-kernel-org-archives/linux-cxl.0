Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A95C3F6B0
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Aug 2022 10:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiHAKUm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Aug 2022 06:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiHAKUl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Aug 2022 06:20:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CC813DD4;
        Mon,  1 Aug 2022 03:20:40 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271AChvg029375;
        Mon, 1 Aug 2022 10:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2022-7-12; bh=1kvutj+ISWtpU/wC1mbVdjVwlXauHKOJ0st9ThctLqE=;
 b=ps9u9t/WKXPskyl4KudTd43UC7M0KXES9KVVRAmuC1s+Oy0ktJoOBhr7gjIyP2DqzsrK
 Xeo5lSv2Q0emAdwfChNGoURA4NQnUigBrfoneBtQbmTBmxLdoRbW3VOElZVDxJHDTeC2
 4S+DsvKEfUO5jRmmKFVSw579HH84cr14U6+PB8tXVmh9q6wFvA3Y2kVqMhOcAjChisA1
 dBH///pBX0MZ5ajR2+uqUwWYy2BfpUAoc+3mFtJUG7DfPiu7JJFltTrcZeyTNcp2G+gt
 iefsAMjOeb92Vj0zcPKzeR8x5SKOyKyszQQxLevgMahFIJyzJJ5HDv7s+6GMnRF76e0A 5w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu80u9g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 10:20:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2719LgqU003269;
        Mon, 1 Aug 2022 10:20:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu314gtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 10:20:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KATt+lCVIQIKQHzOby6lH1vPDpnNpit5zhlp4wWSeHHjXCk4VO3ysi8Jl6jVkZ9RoQ6hFwrE8EzTGfu7VXhgA0XVosZIGtgs2veHE77LtwaoEJO2d0/6wEvkSguH9y9DZKJDPlSR6HDwz1lU82CCYoOAq0NrNXGeHnDYzmfqP4DWRYI79znu3YlAqee2hGRsHMzz4RAYzdx5V5AQymcn6q+a4GGCVpXtVsCdU8sfLCAjOWSfQPQUJoGkDAiILDuWKSm/GnDbEYZwf8UwdyUiIkmUW053xquevUueNRXiVTsZFFubVXjusCng2Lll5CGuGYxgFOLsLIvnNOAC/QGpMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kvutj+ISWtpU/wC1mbVdjVwlXauHKOJ0st9ThctLqE=;
 b=jtXZ5cuAdai4aHLKW401LPRl83U9GiDSWLnaMcfp6owxgy72plhl88uQRaVkYtzUEXHb+5P1V4jKs2NDfyUdPJYdyoB1fTAkHMBzIvVmyjGIhfCeIeqDaGaS+lOeY0LE7m3amxMIJ4RtWlwzG/Optae88sYIAmqN3XMZisuLwDWdOWjLvq+aWjfCfREs6mfU+9sskSHl1h8aOft2yvOiJhJU3A00eUQVfHkTmbqsE1bygX4iWVA0IsXGXaClI65o4VvpE1et4VuIwhblLW3F01VkOwlesmwUFDzuXJzQ6zuXU6CUvEjNHQSWpVk2aRfiFDFVecy8cpR8A9wUdflRpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kvutj+ISWtpU/wC1mbVdjVwlXauHKOJ0st9ThctLqE=;
 b=ipqLgr+U6eHQrweITi3pJkGn1uyRjoAZQiXnRa7gJWe9H663EoeDzixBqr/0R+BRSu2y1IY8kkRxsyIUvSjcXu3eXSVYZzBUpi+kYJMp6BGhu8/+nrDdEIfTcrI/lDspZg+SSh/D+LJO4qbqKGqZReh5uFt9YmAGdng8Dr8l/iQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1314.namprd10.prod.outlook.com
 (2603:10b6:404:45::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Mon, 1 Aug
 2022 10:20:25 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 10:20:25 +0000
Date:   Mon, 1 Aug 2022 13:20:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/3] cxl/region: prevent underflow in ways_to_cxl()
Message-ID: <Yueo3NV2hFCXx1iV@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yueor88I/DkVSOtL@kili>
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0083.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ccb942d-5e69-4c21-a972-08da73a772e0
X-MS-TrafficTypeDiagnostic: BN6PR10MB1314:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BDUyQojeK4zV9l9ZRrYAXm9Su2wDdG0081LlfNWL4PeQry+S/AxG+lLqhQLtO1PauooldrL2f7hD87i5b74+HuB06GMk3KUeII/PBdwHzI4P0zUUdcFbcKSNYJNJUpNOJ1UoZdvObE6CRb9FcUfhfdcUnbGs7BGhabudMAoEydIucovhLc+RWBiwAR3bniPi0cDmhDiXqAHb6VjzyMqs6RYD5WUF3lRnX0zwJJESrzn9ykaBkrYobFuA5hTXbjkPsadkzGjyjspFZO5v/4tdO/sK//kIKK1ErFH0J9d1JEwCjnVDhZexzloH2GMkfSd8JWclDb4f806LGF6W6vNdaQJUlV9MfhAmRORwFf5ljI3dfHz+RoUKkfR/vISbsHvV/WjVtHZ4rAMAm/a1Yd4stkTLaI9YNaH6d7i5w6hPo2avdwlzSytquoF/rL0uee7k7GCzWbvsjqxlwBfYK+gYPBM9RH/0ZzYj5NbBUHQcxEMD8OY9VDyQYFEFCKjYrVsCGZklLqXBUx3TzkUlSWSgxgOoD7aeW7NaA6uHktIjvFbtx2EB5u7evdq9ajBnVr/byrJTV210eMQ93l+HHDunal3hPToZPkQYPPIq7iPQFRK31p8hAjuEHnKA+amqFfllkvvi7qfzQuwvHViVr25yFZSH/1IBB7dYdNxMc9IzenatxbCqRisUgPY3fyi1dZA/zXfO5fiT2Qlc9OEQaN8XDjpeeFkK9V8xZq8ZedX6nbpiP577e9e3rIBDdlbnP4iho2QYecT7l5QW6nXkKQyAvKXDx86e80m3RLhqOneJPgOcV2YEpDX61bTpc/1Wfqpl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(136003)(396003)(346002)(39860400002)(5660300002)(4744005)(54906003)(110136005)(44832011)(316002)(6486002)(66946007)(8936002)(478600001)(66476007)(66556008)(4326008)(8676002)(6506007)(9686003)(2906002)(6666004)(6512007)(86362001)(186003)(83380400001)(38350700002)(52116002)(26005)(33716001)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RhMt4Wnu5eziXgRrMvdrg31ID7JFNsA+ZgmvO9ngCi/jtIX8pJwvg/aS3cGq?=
 =?us-ascii?Q?UpGH5j5DhQO8tpUZkNH67AhEb29LRPPPhJ2uSi2JNHFTjv9oPVG1Cxv/2/FX?=
 =?us-ascii?Q?yyTC+PRcftSW654WiGrskTADRQS2AxMp4q71WUN+z8DsdC3hmKJFIkcjx8cN?=
 =?us-ascii?Q?9L+8wfbWgnYtgupLmKZwTuv5b6KWn8jdglNDS5I515P7mBtbiyVPKCZyjsRF?=
 =?us-ascii?Q?r9bNf6Sv8d2C9jw3Yc5LIHdsMmfOqtI5qr16tugdXEa3OVjEZJ8aCkAEy/QP?=
 =?us-ascii?Q?ffxbopd5Mb1X/CA/FhA9S23br8LmjlljiAfXVm4I/4olX7936h6nhaXevFwr?=
 =?us-ascii?Q?kqvv+ojRVtkYpMN7iUvjTeLi44tJo7Zh0iMMgTIcp0IFqkrbhRpIknUYdith?=
 =?us-ascii?Q?emw6x/oAJEINvVRP6usNLsCu7ZErXMxtYEZm7a+SpdT1EyfCsKuI5XrjjJFF?=
 =?us-ascii?Q?xltL5hCjQuPJJ/nXIyUvsvx4u8FYnvyvWoQJqUSs8CsLFZpcGGLrm6ps3fN8?=
 =?us-ascii?Q?It9GWXNMF0AyNxsulN/y0GVdlLUJMjCHAhQFZxk5LinoV+WnZo/AAJfzGAwM?=
 =?us-ascii?Q?4ZiOnAfkN6iJ2cxp2AsNHl6rVr0VWu2Hfw4iCizEwkIfOye/qkNqQG3nA1Yz?=
 =?us-ascii?Q?Dt3X2Ln8iBaZjv6GSDg6+gwaa7+X+eBozSCxUZwBEdwLDzy8+PpksNpv2POX?=
 =?us-ascii?Q?JfqfiiKXTogAhOJFuKUgXczKdqx0Gk84nSfUsj/6bZ5J7XHr5RPb//SKqtEX?=
 =?us-ascii?Q?+JrXVV+ZRJQWcUor1lArom4Mcchsq9bA0iwvqvxJX2oRTFRxViE6Egee7mo9?=
 =?us-ascii?Q?EfAmhp1VNkQivIARqCGxJJZQRlAyh/+d2Cz7F3AWGQPJuoBHt1icGb0yaAU2?=
 =?us-ascii?Q?NMly8v7RTkeL/VgYh8DZaNiBdoqROWyja9JvXmk7W8UR7PZskT9/KLlNVpqU?=
 =?us-ascii?Q?AGdV3B2DFpLNLUS1GcGSbB1Nlm+YB52psLX49LbRzVPfeDXCM8C9NmsNJd55?=
 =?us-ascii?Q?F8xFWYUkksLwaYZh2RgTAMq0nMV+a2JTY2rcIVG+lQFmNeig9ISIJESViyWz?=
 =?us-ascii?Q?uIdX2z7A78KHE96AtVu7jVG89ZWwWREE+tOQL1o5UDkrx7BCN+fhJ2WwyUrb?=
 =?us-ascii?Q?j9ocD1x555jsPgwQUab5Z869zpfLyl4oO+OGxDT09hCG/gOdPPkgfs3y9ERY?=
 =?us-ascii?Q?ysZTqPUBkc2qg9e0HzY4WMqXezZMJxMG4L/9zvJaYNgljXSSOq2tTHGr4N5z?=
 =?us-ascii?Q?8z/JJVK4v0lQ3cgDEkQceb7M5vQebFeqoZgJdzDl8lubk/O+HXlFZvk1yYwr?=
 =?us-ascii?Q?WhkeS6xYUW8L5FlB2N+WbK7zbsSqbxuTXwAHBGTem9c256FA959ZODrqRVnx?=
 =?us-ascii?Q?6wrLkQ3SVzYrl6QGLjrMmzGHeD+hbt+A5MuuYGZ/FtbpT1jkFQYHe/cZiHch?=
 =?us-ascii?Q?R6p8g25cvBQhqtotyQpQX1cUcuFbC1L3yNqCdzZy2xnBfcs2H1cHR2cnzHv7?=
 =?us-ascii?Q?pQGikf2TUyWzAJEEiiFB23rFfuEEp+guIeqtR/k4Lhe+S7tTe66MbvzYvBn3?=
 =?us-ascii?Q?hM6zGYBKYpEJiZzAxXiWBsjnVawqdHwvd3eJv/fsswUlCMLt08CZ/KoiFVtA?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccb942d-5e69-4c21-a972-08da73a772e0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 10:20:25.1498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0FC3iVUcqhxE0MV4zQVG4qVBCvv4goNjNtU53+Ctb7Sm+Bf2wIRazTU4pCWIm+cOaO7EvqURZZIGEXts0pVt+6mBdqXpwI4Z9LMBjkprwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_05,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010050
X-Proofpoint-ORIG-GUID: WD0hlE9x6xB0svA02mxe9HQeKBLKEXP5
X-Proofpoint-GUID: WD0hlE9x6xB0svA02mxe9HQeKBLKEXP5
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The "ways" variable comes from the user.  The ways_to_cxl() function
has an upper bound but it doesn't check for negatives.  Make
the "ways" variable an unsigned int to fix this bug.

Fixes: 80d10a6cee05 ("cxl/region: Add interleave geometry attributes")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/cxl/cxl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 75674400cc8d..969953ce2609 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -102,7 +102,7 @@ static inline int granularity_to_cxl(int g, u16 *ig)
 	return 0;
 }
 
-static inline int ways_to_cxl(int ways, u8 *iw)
+static inline int ways_to_cxl(unsigned int ways, u8 *iw)
 {
 	if (ways > 16)
 		return -EINVAL;
-- 
2.35.1

