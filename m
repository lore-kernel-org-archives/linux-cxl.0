Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45069C432BE
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Aug 2021 10:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 186D96101A
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Aug 2021 10:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241276AbhHZKaj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Aug 2021 06:30:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23780 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241268AbhHZKaf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Aug 2021 06:30:35 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17Q7c7Hm006537;
        Thu, 26 Aug 2021 10:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ArPz3vJh9fzRmugnkzaFbiQ60EkstdT8p0kyKCOWM0Y=;
 b=rhO6DDRZ8jyuQMx30Ix7W8QeB7UK68A39STOmPCChTDja0JYLcu6jY8vyuXB7w+Jc5iN
 YchA2Pd0VmVf2wrAnL3AH8K4IQz43PeX49LFho9rmFicOxyNUiZh8pQL08rmtj9+T+Xz
 bgyY9vJjssfkXRsnUxOJE8HbrnJpLgWeHY04sU3qGYZjwxktNuQMJ5VnvcctCsBfrSZY
 QNBp+DoZ65aXaGCUkhpEhIWiDWa3uiiLowzSIAIypzsmq1a3oP9Ll6zZCif/6GIXf/Og
 qfg9PIIAFBzURskatfOwt7ihEAGCudI5HAIUotiX1vXUUCubaB9d7RuRJ4nb2kdNv+y9 kA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=ArPz3vJh9fzRmugnkzaFbiQ60EkstdT8p0kyKCOWM0Y=;
 b=XQbOq5LnOHQJbXrC/rnrP0Y/3yuzxcyQ7ZRLyXz1Fj3iLb22+bYULUZelKIEhzfq392t
 WENbcNfCXDlGE5ZU5Uf2bdtsfEuiMsm9eVrHjndGdv+nVGnwclB7mFSmHMzJj2KAqDWB
 C3OZqsgW+OUmvsFUGtUGHN/8jxXmN11s+asnLgsQVrqom5EJoBS0AcJjG0JGvbCtj2Jw
 f8akoYp2fJYcjKA3ozIXN5wVf5c4ZTlHqTQH8PNgsPExn5vbFuLj/HUzTKAC0KQOBC6f
 TDJTvnpwkCYVZNoGuji66gTJUrLinMK/Nt/blPdfu2C1A2Gd+TLj767eo+SvGIVsR8JT Dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap1r5gv0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 10:29:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17QAPSLR089141;
        Thu, 26 Aug 2021 10:29:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3030.oracle.com with ESMTP id 3ajqhjbwy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 10:29:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4VeAlVhNOCFJHUnAmRC0DlzlLLzXdMnXg1Q/dREB7ORNlxOfJauLGBdMyRilkF4MSRXO2Pwrq1TlTBhWCT5XKl4XfjS1CIY2bIJ2pGGTIMQH4oj2zLn1xPT+1KCakGNbVRhUHSEmcqYh8rXCI/vUvsYgES8h8YCySqGNadfDZkEERwJCg8mCvM4uVY1Gi2vbd+d+qnu1y60d+zUU/8fyO3TbQVHFizC5mzJZIo+NzKvcsmOQZbl9RBBMCsgQDK4McUXYstSTNhwPed1A6Tr+JBdcA3ihlAJv6MyWRGFdy9nO4u3zjQEzbS9SR6SAmH/4nFnu8O2JA5dNVsDvYTq3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArPz3vJh9fzRmugnkzaFbiQ60EkstdT8p0kyKCOWM0Y=;
 b=FpGq3pp7+nGtJ2eanzCNGi7nvUyg9h2z2NfRNKSSaI47uQRnMvQfJXk3rp9M6Qo+Yxq6HsVyg0Iwg2F7FJgos8Mq2iV/nQaG/iVSlPJwHawVegRZWVvDWT21NAzwap4xma8kP0qTrvsLjAKsKRdAX6ekbxKvOi96CphkD4SPYkVhqZr47aZKaT92BmoQdgAHGUVzNnD/BbYh0Qt1lphUVdujtkpgB10M24xNwHlmgQ9CNl+xeGTYx7hTP6tg1LsgXh+IgyaeQek1dHdmB0hCWrzMBARkinjd5vz6xgHzzLS5gmMddCjxWDuRCf2car9Sfwej8koo3fGYwg0FN+xEOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArPz3vJh9fzRmugnkzaFbiQ60EkstdT8p0kyKCOWM0Y=;
 b=WkPW8L8hgm1MdIQZEgrUivRorP15eo/YRiYAORZHrJYB06yzbyVfylFpZbL3Tav9nrmSsv5U+e2IBDqRdgYqk7WOmdndBzLV0zOMrIyPg7wvtquYM1Fn3IY9qxWGD0/iH6LH2Dby35WJ8Mpe5IdDC7MsK0kLTim6aaUSWTnz/wg=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2096.namprd10.prod.outlook.com
 (2603:10b6:301:2c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Thu, 26 Aug
 2021 10:29:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.019; Thu, 26 Aug 2021
 10:29:42 +0000
Date:   Thu, 26 Aug 2021 13:29:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     dan.j.williams@intel.com
Cc:     linux-cxl@vger.kernel.org
Subject: [bug report] cxl/acpi: Introduce cxl_decoder objects
Message-ID: <20210826102932.GA29711@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0044.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (62.8.83.99) by ZR0P278CA0044.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Thu, 26 Aug 2021 10:29:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b726a6b-5ff5-42cd-7de1-08d9687c6ac1
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB209650BA71A14471054613AB8EC79@MWHPR1001MB2096.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L++PDkA0NqCL3eGeYLPM97OpQs6FMPy9HIM6kBTqUVlDOMFOXH0p6GvbzwgWkoaDr6V0P2hPi+C7BU/dD8qk35ZTEy5HgoJTipcoJ9tvIsp6Msfx5txCts55sgh1V1mMkv2B6za1CrwDiZw2qGQTm/s0zNlE9YvPIH6hI+/r5YALvnRn6toP1QIds+jWrNHm0+5zTVcHc80OVUGbWTkQu7pbYBPZFt/4KIKUiEXe5AqaV5FfT5XwprqAaBfPANwLz3KcoIdgF71k2zDZ7G/4FFjVmzXn4Lb0bvfiAi6rGDGXJMe2SOxlV0KfEXFTmeaetgaw1+t3LgjRsZm30eWLXlQc7ScjcXK9c2BkJPwI2PCYqc9SwCkUQUectEHqoudnH6Mfk9NffCnGp61CEuZryqamVofkhLNomsyJXi5guL4j+XxpzAiaqWjt5NKaGWF4FVzqLZILbjCZ+EnA2a/cICulR9psmMO/YPsaWVcfdeWITp0YTwo3LouZ/2kuvMDuAQJkPjKWRI4otQNo3mfzqWwSj3H87w3tbbRFf4sTk5VkmNYJ0SPl0r1XjxQ4kFNtwl5yEK9qHgJd0OXpHtvybzDp2b/rwUrD9DVt4XTjITRIWd55qeeurCYA1NtYC7VezCDvJ5adKERj1yY+/BDoByjosq3rlyGhrdqHPCiZDtlleCudMFIi18rLhkPjiT0HZNsssDVGkDRezPMrixKiSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(39860400002)(396003)(136003)(316002)(4326008)(6496006)(44832011)(5660300002)(4744005)(52116002)(2906002)(956004)(38100700002)(186003)(26005)(8676002)(86362001)(478600001)(66556008)(66476007)(6666004)(38350700002)(9576002)(6916009)(66946007)(55016002)(1076003)(83380400001)(8936002)(33656002)(33716001)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u0VIyschYWwn4dGSaKByXt8IRTzK2QoBk+y158NtaSiy5NeyRp8tq2kGmFcs?=
 =?us-ascii?Q?+LM/s4Sndh2tZUfEpc5D3lHTwIjju+4L519xfoBDNybxTY6NYYFb/juQ21Yt?=
 =?us-ascii?Q?vrsvNXmxNPSznDvWnKanKIIzYwDYXVaaL6nV++lrQ/IUAsLtaeNXgRaHffkN?=
 =?us-ascii?Q?pkhu8GQNU93HR99mHsp2Oo0a5ifvjp9Ij3cmvNOMivClyoU7YSCuXCWvv4Ng?=
 =?us-ascii?Q?ZFWx0hgLEESztm0oPPUFEs92MWvCvhJ/rIEeO5a+GvF2QQ8vbf37IHL0/t4v?=
 =?us-ascii?Q?iNOfZPEvQyyoErEBv+hqV6UHGV+703Uzv8zBBACe9bWwRCTU6lq4/x4lyvwf?=
 =?us-ascii?Q?Xk1wNOVdhxwPIO5y2QgJF1ebcK5pszIFzDMO9Tb55sGwlBZBn37aymS1OxNB?=
 =?us-ascii?Q?4CBMcBxsVgjsaJmC8O45SDqrVZ7ZG1kcJQOgIH11eSN3shzYXWiUfDVOYT6v?=
 =?us-ascii?Q?bBJWaDJobIzSFJGJ8vkm8pXYNSQgnQqzAimUSgYdTio6b9T90G19kc2Ki1/1?=
 =?us-ascii?Q?g8nGUiIsHPWr3lw0luiNAxEOduDmGpm6OSssw3XdMefVbvE5jqwp04R7TVKs?=
 =?us-ascii?Q?7i4wq5uSlEQ4olc4tcuDZ3qQj7YIpywIMg8wjNP3v7Bl9M0glusucqvMwQS9?=
 =?us-ascii?Q?NF65PbfqkGdDtHuHfJ4sm9a88QJuq3MaCuO74/jIkBkSDkn4q4xfZ6p7zfpD?=
 =?us-ascii?Q?uMnr2SqDn7dePax1xfb4j3k6ZLDvsmH1a4PEHd+j75hEICSapeWhF1oyL56D?=
 =?us-ascii?Q?BjaS6UskZA+E4KSa3AJPFetIVnMPfZpRPtKC3VZ32lpY+tlL7IuZvXh8Oz/3?=
 =?us-ascii?Q?n/OX/aTIfFy96t283qQxMuuxji891mIX7ayB3Gbxrw7EQLrWbicp4UF3trUl?=
 =?us-ascii?Q?ZXZCEBZ++lWEoP32iu1JQB0BJyRyL1S6dGzeXx1VeYxhLF4hf1m7uMPHoL9g?=
 =?us-ascii?Q?Lfi1tKO2oZvCcgCT4wuPGdunouGnXoiLnw10w5ctNvXSx7bheY+y4ZyzF+T9?=
 =?us-ascii?Q?rXQ8eJrkVm1smV8cMtGzxig7DHpx2G5Jyce93PpvKYi4lYgIzUdriX6INjfS?=
 =?us-ascii?Q?RjX/vJ7zzUj7F7VwurzJihxMe76yV+jelP4BxyNHaZxmXLjns8yFhIE1bUXD?=
 =?us-ascii?Q?v9NTfecmQmBHszydyiazTro3kGtYtNH5zyedpmK69gPNpAOTmio1TcJ7ZBEh?=
 =?us-ascii?Q?kmryQJDXBE8EDKQftwSdQ0zGaaYYobV1Oo8F7Q4jYXYqztTVJKVr5UxBXzjA?=
 =?us-ascii?Q?QbxuGiOMk8vJNrUY7glNBgGuGl7wMVBHQe9c5T73vJgyiq0jfIOSTQ2QOQNo?=
 =?us-ascii?Q?H284dWW5ZvTlw+eR0rGZj0gP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b726a6b-5ff5-42cd-7de1-08d9687c6ac1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 10:29:42.7052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7GqB/2oR9mTueKnp7IWiLfHHU35WvPggKz3Z4iPS6w0IKgjSg5UHdrVfyveCeM0GpetcQyVz3LXoynd+5IaK2cfs6ww5jd0gsKNaAesjHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2096
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10087 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=800 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108260063
X-Proofpoint-GUID: dc4JNDtVeBY1lnsYrOrKrsJj_82BfotP
X-Proofpoint-ORIG-GUID: dc4JNDtVeBY1lnsYrOrKrsJj_82BfotP
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello Dan Williams,

The patch 40ba17afdfab: "cxl/acpi: Introduce cxl_decoder objects"
from Jun 9, 2021, leads to the following
Smatch static checker warning:

	drivers/cxl/core/bus.c:504 devm_cxl_add_decoder()
	warn: 'cxld' isn't an ERR_PTR

drivers/cxl/core/bus.c
    494 int devm_cxl_add_decoder(struct device *host, struct cxl_decoder *cxld,
    495                          int *target_map)
    496 {
    497         struct cxl_port *port = to_cxl_port(cxld->dev.parent);
                                                    ^^^^^^^^^^^^^^^^
Dereference

    498         struct device *dev;
    499         int rc = 0, i;
    500 
    501         if (!cxld)
                    ^^^^^

    502                 return -EINVAL;
    503 
--> 504         if (IS_ERR(cxld))
                    ^^^^^^^^^^^^
These are too late.  But fortunately "cxld" is always valid.

    505                 return PTR_ERR(cxld);
    506 
    507         if (cxld->interleave_ways < 1) {
    508                 rc = -EINVAL;
    509                 goto err;
    510         }

regards,
dan carpenter
