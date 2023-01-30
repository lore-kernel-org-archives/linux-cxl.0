Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255F5C54EED
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 17:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbjA3RCW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 12:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237028AbjA3RCV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 12:02:21 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6A4402CA
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 09:02:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pm4nIRiXKuZXACTqB3MyYUn757rdPg6kIcbt7cmTdZamNwPgg4oKVfYgJowHu+5H/RbFbGgCxdWUs/0ALUMkZGlt3a4FPFMG7HKVbszz8/bidyYMKvuH4Lj8WnLmu+1kM04trIiMkPzo0tlW0ruO50FuyOXN8V+ZjqAZhpmGjmT6ASivXb1Sw7DbRlfEN/uodlHH5ia0tp9A9+Kaeg7qiKMLRXJ3fc3aRfYAgGc0YA1jRPxcrGKk69Rcld+RDZMEx42VpeCApp16ggTJ8u5+8FPf6XR5ojOEp2cI3zpLJ7XfgD5OlKEPhlEehU1am0803fKwhYMRMY6hbl5804/tJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwTsmSJcQxSsA8cA0otB8g0YGbrUJNMTGuU91eUFIZ0=;
 b=k1spfhOAMbDnn3rWNtp2GFa7iV7f6ZB7F1Zn0gNB69STO4vSvXm1b5FK7woc27Wt1+7YjsBHO0ChEOrdTx58OJSy0LhHUmeaTWZw9TkUDyTdDj9uOkYfwv/jSIbhV46Ll08WMwngZuIsqfl3W1ZRqu1XGPOo9F76YbXUaoAnTiICHsBWXVVFT1YnEJI3hJ1wwH8q5YW5XDxboeVeoq1M8pm8CZNWUrsmeAmQ/Auhn6Uq+rPFyuxP1VaK5tDvb5/T8Akj9zLESz0wJPxpDKF9cGIUbiDm3GidtxjIqM4yFDlpDnRhlHm7CeRFUhV4pK4DtSjJBDc6Z2vAP7VbMcx5ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwTsmSJcQxSsA8cA0otB8g0YGbrUJNMTGuU91eUFIZ0=;
 b=fVxu1dySxu7DF7D7elPHtm3gguIu0oFI5RBWIaHWMgLVLnGH9Pg7GIL0cSrJpCKMbBqUKGbhgHQwULXOp7py6u/y7BJIavF9qWyhLWjEIFl+MgSUZiKBnmxRpEhfMeIOg0XmqPmIEjJjFe/xD3znMn/oym+JpToRlXUuQfzyrM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by PH0PR17MB6530.namprd17.prod.outlook.com (2603:10b6:510:2a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 17:02:12 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6043.028; Mon, 30 Jan 2023
 17:02:12 +0000
Date:   Mon, 30 Jan 2023 09:23:54 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <Y9fS+vJft+P0FYWQ@memverge.com>
References: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
 <63d21dbb62f2f_ea22229441@dwillia2-xfh.jf.intel.com.notmuch>
 <20230126185025.000016a0@huawei.com>
 <20230126193424.00005034@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126193424.00005034@huawei.com>
X-ClientProxiedBy: BYAPR01CA0034.prod.exchangelabs.com (2603:10b6:a02:80::47)
 To BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|PH0PR17MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a20975-8e33-48de-d0df-08db02e3bb3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UTLEP86iBngFBbPdpYb++T9VL18Ez/p/T54YmzXgb9oAFSaS2Ip5b6DdLnlEF789IoXCyCE8YYrjzzrZ1DUoR9jmrKnqZwFvOo6r1MyjOBtRXm5mkK3mpkt8z/5Pps+8V3+lJL7/hcUxNG2bHInNcKYl79vTwqXfuxRW5dkJrEN8ngC+Cw0rLRCefjW1YkdwsjkInwahwn650xFW2PEO2q6QhU4mVWMDali0qjSTCaYts2mbNgCRzTIDaKOk91uHDye4C4nY3LpCLRojRILUhDy6OpeP+CmXvXLdBVVB8uds33L8kblNX6BelUm+Xejj6OMjYdQpPGE9GtlOpxCLzbaZ6pGxAWHbWrD+noX95I4r9pYQEjMbPppv7WGk8ueMcvo1MDN5l3NnRhZkYbNsrfllSD8v/CvIRa6WEVW7iDc18QR3XHTD2xKRkwB4iobnWNOQ+b3LWc+D3Nemv9SfqydzzMiM/WBpiQZQ/QUSMpE01L71xQ05DuExmqB62f/MoZg7KeX90CvjKbrRYocr8dT46O7IrvkAe2hI48g284UgCy1oeFyZB2Ls7rd2qkJYp3QUd9kgO634rwFo4XlPvRqE+t/8+BQVg433bc2/NrDx7Cy5hrFY9Uvwo5TYVXiSnCBK0G2Khwhe6YOpIReJ7olvU0wj/c+68f+Jh1TNdEX4DCRTKBdwlIaZPrBQKtOi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(39840400004)(376002)(346002)(451199018)(2906002)(6486002)(86362001)(966005)(478600001)(6666004)(41300700001)(38100700002)(36756003)(2616005)(6506007)(4744005)(66556008)(4326008)(6916009)(316002)(44832011)(66946007)(8936002)(5660300002)(8676002)(66476007)(26005)(6512007)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?02CeO/1+miONbp2XsqvCkq+gjGuL5H7BD9fLsI60q6EGiFTB2WFPOEHfxHV5?=
 =?us-ascii?Q?DL8YW+vtfo4bSiyvRlwRR8XBe2Li2B0ghWgIYgFuU1TKO+r4rQUb5fstHx7P?=
 =?us-ascii?Q?KE7DQhXXKwp5kYMqDjBRuAjVqCQOxlUBOtin08CMhUwvMfEN8+RCezuHOqqb?=
 =?us-ascii?Q?V7bE71YWt/pxIKCDRRYvqrP/FLVxUecXB+xySVm5jCnrx+IxYWn84uLRgspE?=
 =?us-ascii?Q?GWorDaJCtIprYANcw+/hzdF608+mESGbvOPI1UT3fGo4I4D8vlkjj80XXdyj?=
 =?us-ascii?Q?Yi48gAoiAmCef8lfpxprg/8dXmu1oZXiCeBE43//BoZqQ2orTWPCjrEBdAVA?=
 =?us-ascii?Q?nTsjL7AEHNOvITwiYweQ5TmCBCkdHuBrlOHCW0xJ7Tav7V8HtNYpdPgU5B39?=
 =?us-ascii?Q?XlNxRSliVt9EHKFNSQDbUNSVKxJmy4oMRuwfAsKLzeC8NjtA86gl6smL0st0?=
 =?us-ascii?Q?yyc6TaD3Zd2M4ETe3Da6FZVPEg+o8BXEh1yHDqf1r7647Z3yq5S0D/YxHutG?=
 =?us-ascii?Q?/lYco4kkKaiMAIXKrFUDbzJHGEnjtrDZ9LGmnie0g3vwuLjN1qIiedduMs2E?=
 =?us-ascii?Q?AZ1Jxx1YwLX2J91YLfHpVwRVXfdKL2znX4SxaAf4tvYGSroH7lTZw3SByx9Y?=
 =?us-ascii?Q?gb0mX5r6ZrWeiRlgs1mC/7IaUcqrwY1TvTQrNrs27ZN0MF+yTcpSatPRPOat?=
 =?us-ascii?Q?nOAFKRYjW6dXoqCz0KhdLS1wu9QBMD5v72vVZLB34gAvIuFzZPYgDQe3EYxO?=
 =?us-ascii?Q?MSqa++1Bx1aUKL56yN9oajf65Ijir+bdrsXaW4ly/Z85DpumvId5wRZ0GOtz?=
 =?us-ascii?Q?HZMTk29zNjsZHeLdUyNZbaJMJ8KCDRJafXCzc7aKo1kriFmwy62skEHJGt80?=
 =?us-ascii?Q?bGvH44/6CFN5u+u/NIILFVbyCN4bgjAE8X0Wjqi7ShxoB9LzUL1kEPYrYFOr?=
 =?us-ascii?Q?X2n3fWmmf5yPo1jAmH9TM1kPQvFGW/RBwdJQOuL81H1/jF/34KU1VfQ/OZMd?=
 =?us-ascii?Q?IBrnXyOUrZIojtrtFXZAYnYD3YmTes5VWsPt2YxkVtVySuPQq0rIH7qZSbp0?=
 =?us-ascii?Q?6qMBM8PmNML2dE18r/f0s+MJuqemWq+kyWfnjClS8Ve0+Ox4IPaZAqgk8bZY?=
 =?us-ascii?Q?vjKQb0yEhpmOtqMMI9RMAzZsGXjXYPGkZcAfDGOy4g7xscOsRaqK/E2lwOJq?=
 =?us-ascii?Q?6g8uL7y4DaT8/t8eINYF/tpycZwbcrmyPuMenw9oa57nOvhRLguj4blYlAT8?=
 =?us-ascii?Q?B4lVcQz2CMre8I+QIfRZgmFIlHEvy0pChVVdxNRi47/+ftn+5mPjBa707j4e?=
 =?us-ascii?Q?5M//q5dUn+/m27pY1o/ZkVEfJ8gEL3wJyyKUd3gAhLITJs6hBY84ZE/KLvFT?=
 =?us-ascii?Q?WEvAI/rkJB3Utad5rPEXw6MiubYpzmQQqOqq3dDHEbJA/Q0p4NOyKgSUZk6S?=
 =?us-ascii?Q?ZEWnx67LJ0Zz+iZlO9L8n0t7yyhZZRZtBoggwDIZR8abtBsPFjJKP3mkL0WJ?=
 =?us-ascii?Q?q07cuIaRJ/q8P23UBsTW2aZ+SFly0hgZbkxgj2K8hHvIIZ1gnrHb5TBnYM6R?=
 =?us-ascii?Q?+4PWJzuLYEOOtdyAr73gRHeIWE768xx1IAanFLm0wdwMTUoavTr55B76Vn3q?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a20975-8e33-48de-d0df-08db02e3bb3b
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 17:02:12.7960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0UvkpJpPjqjzHaKrNPASpIcgd5DNxQEsNCIALFLXZ/+j1bDk1I/NScqIj6Q0baLB7286JF1JxDuRxnH6O1f1cEP+ah1lfq6WWMjxwOFUFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB6530
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 26, 2023 at 07:34:24PM +0000, Jonathan Cameron wrote:
> Looks like decoders are programmed correctly as I can read and write from
> the HPA using devmem2.
> 
> This is against http://gitlab.com/jic23/qemu cxl-2023-01-26 which has been
> 

Johnathan, can you explain how you're accessing the memory? I don't
quite follow.

Extra Notes
1) Tested against Jonathan's QEMU 01-26 branch above
2) Tested w/ the Linux preview branch rebased on top of the DOE fixes
   that were causing other bugs.
