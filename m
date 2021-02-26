Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FA9C433E0
	for <linux-cxl@archiver.kernel.org>; Fri, 26 Feb 2021 20:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0702D64EDC
	for <linux-cxl@archiver.kernel.org>; Fri, 26 Feb 2021 20:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhBZUrR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 Feb 2021 15:47:17 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:38154 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhBZUrQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 Feb 2021 15:47:16 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QKiqVg106796;
        Fri, 26 Feb 2021 20:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=k3OOrUDCsqBlN2/SBiePKXwen648MyuGanwEym7AVZM=;
 b=z1tT/tanJgiBaIrVza/uzaBIeQDWp5f6Q1xG3qr860OmAZFLkiHtJsAexEeGQvzjguXJ
 7l4tjk/OMyQWffNM2SIIs6XJTcxHozOk3/W6tskKQmiCrLl9oSozuLsfgtvf6Alm4cUr
 5IQD+Uk+0j20oTRRCCjNBZ18x/dGeoy1tamersKpvocyA5uxfIf6m8hwgYR5gjwMlrCt
 +MSTRHPqhQqTR/EdCrV7R4LeU1mj8wtQjBmrxVrcwyxwupL/fHzSwnPRT2+EzRr1WG8l
 97rQNO3FU5smkkbbgWW0Sbc2Opi+WEoCKo3TTnqhf4xUhjCT7dbp9lc75G2lDwAQ+hmZ Qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36vr62dn2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 20:46:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QKkJWg069060;
        Fri, 26 Feb 2021 20:46:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 36uc6wbw2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 20:46:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtH8tls0Ueh2EwO2325tkts6XDjVdw4/qqL9Nw7x59XbBtufLcXrGnwnvN2yhtmg3yAsrl5Rwz5iGh9kDE9CMlEaHfHerMm55hq+QxkdaVgQz3N2m8Ph5B1J9CrTU9bvDFJBcboQwWv0Dj994EKg8euCdtK0p72daKrme7yOBBzaaJcY5iFgNcf530nIwzKtwmiffFYQPyRt8Vw6TIzeKKgxTRrGiQFqaW/pDd9pADGQCLJNwVuaqqXIcupi9OBaZkbTs0tmQFmGV5j+rXMFiDNdJraZQT54Z8mI37KxfC9z7iOeodEsKCjP28nzrmKiezE7tIv/w3RUYq7lUKSMPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3OOrUDCsqBlN2/SBiePKXwen648MyuGanwEym7AVZM=;
 b=ddTXwQTi0hMrqvh/GAibvPMQaY1tvJFA9eq2hISnxUYJKTsi2qLFhSQABnZj6deojVzmXolFVRpVQB3TI/NwaBHB3bCpYlrMN146ZdUXKf8aWiB+4+0wx3EkCApeaLVT1BSU83Bg+zwvTB6qjjSoSLiO41FUuQnF45siC+JZRceMzPAg2ZNqkC33gUxcUU1tAmuwSpx04LFrrIpv1VkH4jkCDNIlGj0k31Cd+5SK0tRZrGFTdQv2PA1rfvGGABNvL8entekhQS///8Bp+4+QEzajT3qFYSm8cCPEdvcOE8eD6jMXgktjLzdvDYsQoXYL2Tjxi01FHhdCIyEKn2PaGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3OOrUDCsqBlN2/SBiePKXwen648MyuGanwEym7AVZM=;
 b=dKCGkjvQM4RQo108ee/CT6qvlFZDKhz1waoYV4uoC4Iqwv1Klv4fZ5ZjLedIAQuyfSm94fGFbkghBp9OX5Hj2A3ZB++t9LKF9hS5mxn3LkuIGp+nQi46dHt2UgHLWYxrufnvBp/XMUYpTRzu0BkCM4uc855Q6zSltXh/bIEx+z8=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by SJ0PR10MB4671.namprd10.prod.outlook.com (2603:10b6:a03:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 26 Feb
 2021 20:46:31 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 20:46:31 +0000
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, ben.widawsky@intel.com,
        dan.j.williams@intel.com, linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v1] Little fix that missed the merge window.
Date:   Fri, 26 Feb 2021 15:45:51 -0500
Message-Id: <20210226204552.45399-1-konrad.wilk@oracle.com>
X-Mailer: git-send-email 2.29.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: CY4PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:910:60::33) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (209.6.208.110) by CY4PR16CA0046.namprd16.prod.outlook.com (2603:10b6:910:60::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 20:46:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fd13ae9-5425-408d-469e-08d8da9798a5
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4671:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB46712298B124F9A7F035EC79899D9@SJ0PR10MB4671.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8FBQ2xnQchhb7d0OqQOrBVcQ2mR92nXvbDDZw4ph54ablbd7k2p+d/luOcPaYOgYiQoGOEaFie5/yICmKt0LtjEB2r1nn/KMrvZrEKf7e8ObdrES1A2U3g+KzjCfyJnYxf4F+symHOKcFZ1XjzybNPN+WDH/qlaALHx8z56JI7ZjeCewzBVKW/wRGho9tzX0XGGcvW5YbuFt25wzE/t7mnti/+5Qj+08BcmDng7CPgp7Yk0/mWaMoBmHEsmkO2onVjE1xNiO4OK33KyGTHMJGom21EjFsYyGhSvObMUgQWLqShqILIkj3du3JNCTJWY1u97DJD4QRZp7Y8PvRmacQ3mITIbhrXHg7ixxjpcqDwSTLVyxhTrcgZc+QM0hOJE68Fsl6UxkI9mDfL7IKUFHT+Ran6ioHCFfM1w85McFlRwBD1TrHQYlisQmbU95mZaHczbZBZBE16tI8lngjHr2kTXYlC3TVSarVZZ4iX5eTb2O8IPz0zMFSPO1T2yvhDAD+A+Qb5348JD+VmhuFKbXDTsIqyxMEbjt63Q2ztnRevqOMcm5TtnvGnv7FShSCpg8voQW3PL4bxVeAaaU9GC9NQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(39860400002)(346002)(396003)(478600001)(66946007)(66556008)(956004)(6666004)(6506007)(16526019)(52116002)(2616005)(36756003)(1076003)(558084003)(8936002)(186003)(2906002)(5660300002)(8676002)(66476007)(83380400001)(6486002)(6512007)(26005)(316002)(69590400012)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?r8H/GE9VOHO4ImHbpDrZxLsjHc0JPyQFD8VhtFjjTD4R+C//mh3eCT7P5CAE?=
 =?us-ascii?Q?nJ7kOhZqkMytpOdsx/LiyJQ3UYZP6EHdsY5jimYRsCbXeqOqPiMLGSwPdxdX?=
 =?us-ascii?Q?JJ6TwB9YKu3yt9GwQ883FOmo9YmwiigW/zuOaQVjJRl6Rdb0KLlErNfqxQCf?=
 =?us-ascii?Q?utHm+ow9FZu/a3llfILDf+HVOTnqIXLmG/AJBVzTOwcvC5dc8b5BiPQAXaAG?=
 =?us-ascii?Q?FWzWINQT4tyWgbBLTJpEtK4v27u+vVvpZVxhBo9tlpdKCCQsDXyPuqBQ/30o?=
 =?us-ascii?Q?SVib8wUX77N4sQJ+axFHYeci6jK17B2iKppn4wcze55a1bLl/F681hj4ctWZ?=
 =?us-ascii?Q?3dDCbruPXF+9UeEq7jxk+LaXtLVEzybtAYXJerEx95gljRtNrzvmo+BJXkNF?=
 =?us-ascii?Q?8R2CfOob1rI+XdfCHFO99a+fVDXlocsFFVooKQrHsmEr69AsDAzwTRCKi5wm?=
 =?us-ascii?Q?MNeK7A/JRAu0VlYtTAuNljOY7+OlkGku2guvKN60eb2tcU0tUW/DxVs3wRZk?=
 =?us-ascii?Q?p2kGtkHZ8pTP6NoPOTMj82vMjec+nvW1qtgw1VzdH0nhwxcsxIRJ2tzsCSmr?=
 =?us-ascii?Q?6yJ6tNJWqCmrJ9+txh/jwV4yjFtKHWZLoHUvI6UP2fAAdt3+d+69VrFBeFgB?=
 =?us-ascii?Q?aLXtzHT3njPqnoeAj6ElQycKBXSVcgmoJCkKH15iUp/RCRq1S0CHM2ZwzCFJ?=
 =?us-ascii?Q?WdsTLL5zw4G2Wy0G6rBgz/3QU65Kujdxu6WO5IL3i1/OcBboBBRDpbe1Iueu?=
 =?us-ascii?Q?W+UsZUVooySqTXL3GxONfJhjx+XDWLdLkvXd85lnwRPqfZXfMxRijroaVG3R?=
 =?us-ascii?Q?44uFa5PYIauiuWPwUGn9AjwqK+8sN+UgT1toSDS+VwKw9fjaRy534c/OK9LW?=
 =?us-ascii?Q?wz7wJrvjBl8xrVb7Rp/NA6hYXSo47dCYdeBqvEA/g67cdYck9ePGXOkYcU2V?=
 =?us-ascii?Q?cFrZWt74d2rFDSb7FO3NMiIR/OLqlZ9nvDtI3vtTqqu4ozRNd/1rfx9QzL1c?=
 =?us-ascii?Q?oIHMA2oKQv+6sCTJIuVNiH0AbvkUnIDqkVz8Cq6gAH9XSZhGBwQxofRM1Q/J?=
 =?us-ascii?Q?sp7iPpCriNsexj1K9S2Y1VL3MX/0rvQrCtaVT8mblpVj7fQBIlh6thYzh03V?=
 =?us-ascii?Q?pm7L7BgxoGRMW1YMm7yIhVAhKsBOXwGSVKAf/Dne1wICVRmYVirIf8sW9+YK?=
 =?us-ascii?Q?p3Ic+/EwSgrXHjVW/c8FEqjR78THgxifswOZP7u7yJx0OtRt+65f6+D1+J2Z?=
 =?us-ascii?Q?M2shpwfXzmicICuj82ffyeZnIXQROpEmOd7jWuAb34TLysOHXuDKxV88X5GQ?=
 =?us-ascii?Q?VKD0w+EnHwlsLlqYE8MOLspj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd13ae9-5425-408d-469e-08d8da9798a5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 20:46:31.0829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bE8VXGnN7pGNH5J5U1WGsqjWXw1huWpwyRB168ZvQBuQ0IeaMdhvFXmUH07KsrppPljjS0wA1ZuXoERFm8igHQ==
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

When the last set of patches were posted for review right before the
merge window this fix was deferred.

Please at your convience pick it up.

 drivers/cxl/mem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Konrad Rzeszutek Wilk (1):
      cxl: Make loop variable be 'i' instead of 'j'


