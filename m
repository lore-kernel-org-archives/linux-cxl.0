Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502CBC3F6B0
	for <linux-cxl@archiver.kernel.org>; Tue, 16 Aug 2022 14:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiHPO43 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 Aug 2022 10:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiHPO41 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 Aug 2022 10:56:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F18F8305C;
        Tue, 16 Aug 2022 07:56:27 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GDdndu001659;
        Tue, 16 Aug 2022 14:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=We5+j+//EueNJLzb6WiI5lJyYcsl0v7Tt5tlsZyRhRg=;
 b=bsFfpyr2XHwlqM3GHxw+NqrVhkvgsUi33d7gQjsOkfr3d7jeyeKnG3CJi/zBTlZCnJAP
 QoBBQsel9hE3QLl4zUUS4gHEfABVBB1dEpaWDprOO0lh4GaoyoxUyAZ8+LRz6u5le+mW
 hdMXmaVVr6g96PO9iu59qym1mlpFnV0fEMRffG6PNz8GEcD0G8Ge+HT8m7VGpSYOHsnQ
 gQyT7FkIcxnjKg9Uov7OsBK09iVllmEr3mRPsjveG9wmSfjo+tLol/4fbhkffEI3cJhT
 zRQ078OQZL5lVbZxpsz6fq8ENerwr4zqorWm0VRKKnaefxF4hJL3FQYIVRBARdIqMWe2 NQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx4gt635g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 14:56:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27GCfe2l029234;
        Tue, 16 Aug 2022 14:56:10 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d2hqba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 14:56:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbBZlWqNtGw2hNy3xyQi5Zls+LqBm1BM5T8FPbBj6CtJ7JXsHYj2J9Nyfgjzl8dBgISlCQ0qpPYkVX9K8HhB2pM+9HviobmOMNEGuUbCtDqA8UBaSY7SUrrI3K2S+ucqtNt1YDbKAcBkpH04LpzrVZHkyF13PmAvsYa9aCGVaGYMDSjnynipZZFYtU4y/QfaxkWOvRXJQLYK3pYue3P+NMqSWW2hV1wTGnuBrsOjPOs9NwJcF8q62gZOjTXp4tZeg4635hCkZghydesov5QTh0BnjOgIlpyuyfe5/iQ+vDEIUJ2sOOq1eBD+7I2oZkAHGtkNEEaJCFGHU9+U1urNiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=We5+j+//EueNJLzb6WiI5lJyYcsl0v7Tt5tlsZyRhRg=;
 b=AAohiJocNmQsv1OipgwB5GGmbwodxII3vIrJBZrNTk2SRWdV2zdSsPeByhC5l4KpDkWbU61cL+4JWCeD9EBkauxN/hEA/SUjQQgX3Gwk5eZqFB9PmZZPUMFc4D/1yiZ3oiVUsW2HgXT1OctY2IBp80nEUu4gEHIHufE2jNJqr6VouMDSZG2lA7zfNp1u5DuV9p6Smxid2GZZhDKO0EmEu9nd7nRek9YlCUFJRXyhckZVt+kesgMZObjr47+/7XICnz1qgwHmwN64ZSp93a1hbDQCtKxTZF+Pvnywlk2DvuROSuuqsA2Q+TuMl/TCLN5u+WQc59sxhNvwctScXmdofA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=We5+j+//EueNJLzb6WiI5lJyYcsl0v7Tt5tlsZyRhRg=;
 b=JVpudhfMC4EAODH3esWZI+NZHlA0F2hWThrsrT1NIjJSQZeGEjnGTUNCXggdwRH/sPfZ9fqTVDJWRcH7crHB08hTUeZXO11LkCXcba7Oas5YrV/JakSuip0Tu2YhmSyU+BDUZLaD+rvQ2ayl8DfzieHThOoHNZZKo5glrdnzySM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB4286.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 14:56:08 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 14:56:08 +0000
Date:   Tue, 16 Aug 2022 17:55:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        linux-cxl@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] cxl/hdm: unlock on error in cxl_decoder_commit()
Message-ID: <Yvuv9wQrtXBy4Ddr@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0099.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f05f5b98-73b2-4297-0ce4-08da7f97722a
X-MS-TrafficTypeDiagnostic: MN2PR10MB4286:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ksAfLLOjZkv0SgQ4iMoy39TrVBNEu/J67aa9zKG+2U4MXViZcgYF+ccayMEQTXrhWlQ/kIacJj9izMOpI/dhanS8zQiwZd4iGs6T4yanr8ckHNnUPPULIDJzNrM92Udb+fLPQkp1hfrv6jbS7nMqvKI27bHBBTlfVxIInOUh0ve25/vhIlFBL54/J3VX0kOzLZUIJ5zAAaNXfowaNlz7i/3V796jSfVZA0ScPY0ID9DSk13nzU6KVyjzXn+4XXluci1sLwXcLEFmsxU4pwUl85upmWoKIxS2xEGi2F9IiGIlgTJsxOUvZ2caan7Fs2LCHnHgdnkG3DQQ2cX30s0HXF3vndxng+DbZddz1ihgU/OOAUAeVAPdPGV7jJNnq7DHXWT6+wnik4fGkEDr7ZQaJcnzQDqGCAxJhuZpkgYAjN/4EyWSBk8+fa+G97mig3ZXDRXAKjhq4dSH/3AKO4kLOKq07s/puv7gMNeSDvHwWbz+ExeGe2vOkQMfQLa3opOwXxQGqpWtdqGLV+BeDP9n7cs149nkeNHLWk1xIExAGUhkcRCTZ8vpo+yMMLai3TowFlPzEC0e88sa9PRy0CpdREYMrcURfzZF+SHc/c+z0jXc+fhWVZIwXy8MW5s/EWRy7J+/GyI7fvBvdm01+QQw02nz+0wjJ/4uBgEACmKEkM0UCNeZ+V1oIUrg7Yo2v/29zYIDvrVnf7s4bBTHz5DHqR7wgbs0g7yu6LCJKeSFwaZeFgO2GaiXo0ggfJDY55+eSnBAWayr0a/89r+V0PLpGlxPYEwuwB+4pPpPb0xMw5Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(39860400002)(366004)(376002)(136003)(2906002)(6486002)(44832011)(5660300002)(478600001)(66476007)(4744005)(66946007)(66556008)(38350700002)(8936002)(38100700002)(8676002)(86362001)(6506007)(6666004)(9686003)(26005)(186003)(6512007)(54906003)(52116002)(41300700001)(4326008)(33716001)(110136005)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DSoyTcVaHxO5OxIxqhp4YZ+t0nHKOv+3//EVKf/te/mfIfNI0agBFb7V8rlS?=
 =?us-ascii?Q?KZ1I/4C/P4Jq+qv2KF97xMP+QvcoNhM7lnzCZ2mluDkELKondbWdRUlYaJwb?=
 =?us-ascii?Q?bp0dFnwax8RjvKBsYHxakcSihNsR631e6r5dlO4cwKeJTFuDqfTerjZHm5d4?=
 =?us-ascii?Q?tu8C25V/7s/o/BXl/K/h+l2/5eSL6AWt3UYa+18HmHl9vfhY2zrsgeVrPnER?=
 =?us-ascii?Q?4MtJGLEtyVZKGSdR34FlJZ9/cW/w35aIRB1Xc1SLVRbZCPWRhoxksHkpA9UJ?=
 =?us-ascii?Q?e8dHiqbw1pMRV5Y15Oi3ad+9H6nC2s/Snu0oUYHYZEWB6MHLs1AlBmLROwLE?=
 =?us-ascii?Q?zIdlABjw5QKYnqCqsMBxV3eLMOTEPzunY9M11noWzaRV6YOlHfS41QZ/iAzL?=
 =?us-ascii?Q?b/Yc9wS98tsGxXls+CmR3E15wGGz478Y1g9+Z154Yi43i14HMXvag+B62AGV?=
 =?us-ascii?Q?fK1v3WkKkhTX0+wm0R2dmYOLawnVGqMiyRXB0HOQWJ9QNO9soBXd2+pRDQFh?=
 =?us-ascii?Q?m/Aivw4g+4xDXmb7Uvy4Mg+FAVMIvUFi9z9xD3SSLd+kdolhDD/jeZKEcGdD?=
 =?us-ascii?Q?Yk42l6F2qvDOYLoouTGvSCoWlcH1p0QN5fjdNQePLFFvmJGQb5khUrGo5rDf?=
 =?us-ascii?Q?hPpI8BfPOiq+KNX90HtTpr5F1HAwxC8qBKnRDHUNbPg1aeN51+U+M/we0kZ1?=
 =?us-ascii?Q?cSkxyB5lNOr2aQWq0M3Moj6/jbIRrsI8OgWMOJg8Yd7si5MbAOOKATPXI2BE?=
 =?us-ascii?Q?azldhXzM16oqNoe+/xPNRXUZnW7f1+BBxzgV1XFePK272PwhBwZst/H/fPZo?=
 =?us-ascii?Q?MwdcCGdeDkWE0vlmhY1s9qJOC9f1AO6frtBF7iwXNLDd7Soc3YDuAuOqhWOP?=
 =?us-ascii?Q?WxnaLFsIFjes0P2u0UYiCrFzoen4h3Pz+FFls5aEBVHDOhyCbiIB378k9H8S?=
 =?us-ascii?Q?WP2sY/tJCESVpkJCo0C3/U4mwujabpiJJu5aUcjZcU9aSlHQMc41HQnqN6xh?=
 =?us-ascii?Q?NkRNAXIcrvDJAWXk30toKF8eV8r7CvyMXiIREVQc2C8Ek3+z5g5UqO1GwIQl?=
 =?us-ascii?Q?w49AnlVork/HJ2Lr1NFdU//T6bF0sbPbn2tH/Gui82OpnqykE0neKLh4wqKh?=
 =?us-ascii?Q?uM1q1Ik8vuh1OrasNRKlRr4CtOdcAT7yVhz5jByEQvsicS2p3eMSd3gQS4VV?=
 =?us-ascii?Q?gqVWo3yz7NU/IWW0oevQjstxPqfZZ3AnBktAZtxt7GKLM/21dldWyWLMQ42r?=
 =?us-ascii?Q?IsQsBsDMYhXPP/ocJYzgVLj8r17JjDu+KTpoImbsKOaHjckEn07lF/XlDzfl?=
 =?us-ascii?Q?1tEPsSXoyyAPLV49aOmTe8ICctywpVqq0FuK+YJQt5uHtW9jERKgD0TG0C4L?=
 =?us-ascii?Q?Z6YuZo/Be5Ss+fOb+583tEjSCeCYhfFvf6zi9f/ucm1UAhs3XruX0KNVIVzR?=
 =?us-ascii?Q?0KyGw/ahZCX+7GdVg+0DM/UCNdZWTLUF4ugvsi2VIBZrcg9uz9orE2JPSfKh?=
 =?us-ascii?Q?LjGURHcwiHJwtXv5rNQkZeyC8LbtivurR6uLqgiqG8O+s9ZlFYCcttwSK9Bm?=
 =?us-ascii?Q?HtrObhMY80dvpISdu8pIZLu7iLOhgTUDz3CHtUlK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?DiKIDzkmOgwef13s29sRlHgd4vNto3hcaKxl3JPoBw+ZnbNhEruwQ6KR9omd?=
 =?us-ascii?Q?WYD7es5PBd1hHB1sowgNPrGzAx86qzqTOpQAsnGrnnrRm+Wj6o7lBcQ5JzwG?=
 =?us-ascii?Q?xWi8sBAhCRstV+8wEM8PF75AhmurBYpLjGLecSXz2LOlRqIoGS8UQvCZJsn0?=
 =?us-ascii?Q?SDen/Nr1rPJS/+TYzarADvjnTnrqGZ4vE9mKgtHptez6/ANyEYXOtoL+YOZ9?=
 =?us-ascii?Q?aWgt+vGhamHXVGgCjS3xmfsIYXe+tl4w0cwefX8m1hLJkNPtXLC8P4jHqDPI?=
 =?us-ascii?Q?jZjgX/zpjoC3P1E/c5N72pKu3DhHVV/0XnWPrBFUSp/y2KbLrBfz7OO2ufNF?=
 =?us-ascii?Q?vO/1wlEllyJcX7laROnos3O70cIrI6iGp4K6Z8fPWQNFjbb4Q4IG+XcFU/09?=
 =?us-ascii?Q?F7DfmY7Q+33GVrqlHcd+r/3Izg0cszZrrek34SU+kGWOeFwHmK8S3bhewKkT?=
 =?us-ascii?Q?jl7A846drEgaLCtSO8+fmcdXqmQQEsqOtAq519JsduA3kI87n49exUT+SxTx?=
 =?us-ascii?Q?CfrdEXq9zejVjPd4q+O2pt/yLwUmguHiKuxTProKaOayglggCyCbRzFRxP+b?=
 =?us-ascii?Q?exTzOhaSxePu68tpblebZpYnJfc2yTt9TSCllNXvzfvvlv/G2t0ujN1+Da0Z?=
 =?us-ascii?Q?7H15UsppG0OX1MpMKL3pr98D3YzzRvzLASm3zkuB6ZERogn/A3GEE9bqc2EU?=
 =?us-ascii?Q?WbfytTSaYBwcd0iu0yOU1zqqTC6yyXtchYHne8JWDlcmtr1wWpDseEApVRGq?=
 =?us-ascii?Q?0GemiV8VzVuiQ97FCSSJMp748PfMMXpeTlrlpmFHGOprfrhmCgOqTbFNLpUw?=
 =?us-ascii?Q?5ZJLOcYm7rp/1ZQd+R+QpsOnxY0Bvt9L3xSeyXxNGb9TGUwAQ1JLBHVM4/AI?=
 =?us-ascii?Q?MfANa0WZMuQurN2VJpBwDz6O/5F/wxgA1NuzuxSyyWWcRP0BgdV1D5fX+b5V?=
 =?us-ascii?Q?TUnRo+iomGagFiD2gSSwDGwF5XZFGhedVRm+VLwwj+MbSZlDCswpJ4Sc6h9q?=
 =?us-ascii?Q?lsOUZ8ymcF622254/J/nUvV9tojk0ei9K/vs4V0SsVG4TyU8YUcNz0Y4ptyJ?=
 =?us-ascii?Q?CDEhkfrRqFVcrbuT1gbQsM7+ysl0OqudZaGHS04iesC7ZO8dhWurgJ/Ef4jB?=
 =?us-ascii?Q?j9jBmesvechK679G8svBwLnZwS7lxLP6CdvOemUl8xjiCibHhCQ8yswCn1gq?=
 =?us-ascii?Q?RJkyodaVDYWweYARHZ9NeLNoZPRNzU3whY6bq+Kd61ol8W8UnOdSUXz5Nz3a?=
 =?us-ascii?Q?IAzpzD47kI/+yACP9MYl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05f5b98-73b2-4297-0ce4-08da7f97722a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 14:56:08.1773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJKdjhxK45e+h9v4VdXp2jVQPeRxvC8ttbsWioWZis/UZ222MH5jE8s7tPJJ4yS4WTM7rkkLZ4v1MvUO5+QtYuHFAKPdE6LzU8XGvG7agWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4286
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160057
X-Proofpoint-GUID: qWHlBFWuDocNubk3F0fl-kRZPE7NuEn6
X-Proofpoint-ORIG-GUID: qWHlBFWuDocNubk3F0fl-kRZPE7NuEn6
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Unlock on this error path before returning.

Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/cxl/core/hdm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d1d2caea5c62..873c07386064 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -605,6 +605,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 
 		rc = cxlsd_set_targets(cxlsd, &targets);
 		if (rc) {
+			up_read(&cxl_dpa_rwsem);
 			dev_dbg(&port->dev, "%s: target configuration error\n",
 				dev_name(&cxld->dev));
 			goto err;
-- 
2.35.1

