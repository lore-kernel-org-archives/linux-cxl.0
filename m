Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BABC38A2D
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Oct 2022 20:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbiJZUtL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Oct 2022 16:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiJZUtG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Oct 2022 16:49:06 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0C8143A71
        for <linux-cxl@vger.kernel.org>; Wed, 26 Oct 2022 13:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6Cr9MCX9lamr8QesIXw5iVKuYhwkoULhzsCon5T95ULXxwW741yyknOTrGWmOitZJMgaMx9Tq6AbwPl9N6OccCfetxMLaM7m4AN8NeeANX+DUR6sBLRJv1lhQRPdOALGNoPNefkcUHZvIQDtlQf3759da0T3q9MaecWmneetVMrUvAalbhu//++HwAXRkku1YVsmp+5xs4b6z18GHV8UGhL4gPGnVIVV8Mgzn01Emvyjb0nlSBgF3feKi/Ue47dlMipi+REGieVLG3vLK58U0XNgDsm32jpX7Sze7kI+ifXua7FJcwtDzS1s48vLDaNPiG+sJEsAkq5/1R8RfunTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcPglBSoDpyWpEXqeRa11HQZoOOG5kB+Bk4/BoJMfPE=;
 b=kuX8qCg4MBp266D7UpVwQrrWfzQwrwR+tns42wIVYofSfj0Dsslm6siuJzp0PlD4F1K/7otmK32naP9wfG/8/JHZIjsE04BftlFsI0K2ItuylszYe40a2qB8+HgKHXtWXaK7z2Pp+2Jl/t2hdYmG0pnqnqNovb46WlE0giAfCPUjt57lLXusLw12zDyETXYX7EfbPrr1xKPZOKQJ1cEKnndXgKHX0urfaY0Ky+WPCnnaoUxJ+hYynHvXi51/7AEh6kFD5JqxRtGai6Oo7Z1B0Jgbeb2Q9C5nIKY023ZUmyfq4YQAK+90F3eZ2fNkJwSb7ENUQQZDeJKBZ2qS9uvdRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcPglBSoDpyWpEXqeRa11HQZoOOG5kB+Bk4/BoJMfPE=;
 b=Emy33xGfPS6T5gt+Vb/CYbR87LYHay475FgggXujyiqz9bbG1mhqBo0smEB6gFLiPXKxcFMjZ7iFCzZ8HnG+7X1Va98OgxUjFlf8XiEdUVC46YkAjkrre5WSh2PBg+fJvTGXUm8U+4UMK1lxkUWlyVqNxeVl8BxXzoHPjMZxXvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by MW4PR17MB4793.namprd17.prod.outlook.com (2603:10b6:303:10a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 20:49:02 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::138a:e3a2:9ec4:a18]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::138a:e3a2:9ec4:a18%7]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 20:49:02 +0000
Date:   Wed, 26 Oct 2022 16:48:55 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org,
        jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        marcel.apfelbaum@gmail.com, imammedo@redhat.com, ani@anisinha.ca,
        alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
        ira.weiny@intel.com
Subject: Re: [PATCH 0/4 v3] Multi-Region and Volatile Memory support for CXL
 Type-3 Devices
Message-ID: <Y1mdNxXMzIT3zg55@memverge.com>
References: <20221026004737.3646-1-gregory.price@memverge.com>
 <20221026161815-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026161815-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: BYAPR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:a03:74::47) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|MW4PR17MB4793:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e724947-0216-41d0-07cd-08dab7938355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Un25+lohTs4YJf5LHrxTuKyBaPVlVbkLnPe7czTiFcjVK3/fULtnLffJaUIPFQGW//gP6bpKT5JyGPiap/t9GCh9dt94CQJZJLXg/IehhKeyC3W2SMQ3p3FBSNJUFiKZQn4nJUnvbUUrToYdxeF6cvY4xgRhw6uJSQtpndq+CDleBiHk1VIPaFrL167y5wQsjZVUY6PXFTRoYwf1lQSXp6z53D9OLhkirXFSXhwLduShjzsweLXWG7ZIQqn7z0d/8ggJbdpkLOMTnVpd/zJp1mYUjW0pkcWt4EajWVx6mYDRTKiDGPb8EBhHUBf60/XGMYeKdYaQS5svTtFBPanWSkvxpCwxnODIJ12GFSLydswfiEQhccMc+K6tExlL3dSduWqPFegklBM9lFtwVB7ibczYiAc67iibZM2hLuGOEoFX+4eAmLJ3fWaLwJ/Q4Kpn1AYCwMjvGVrhm/vBczv4ZSjfJX80iSrKf/SgHAlLPi8opJDRA/7gafLrl97St4qq4cGTZDZmoVt41jVvCZo/jLd0/wxS11TuRFQwPnvm7vTRvTMZMjAujJrwiI15wjJZUOiAhulj2VhBu59M0umIMM0+OG85bPEQhy4HYbzsDpKDoOs7CXp+I2eVApgZYFlD/3d9uN/7+CdGVZiYe9gcHDwDw85F21ogFsFjGfvQXo0ER+1ayPZjz96c74ZzADFz6K0THh7XHiRB/J06KwBqOqqVZ+zF+nHcFUPmxGutU5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39840400004)(346002)(366004)(396003)(376002)(136003)(451199015)(36756003)(86362001)(966005)(41300700001)(6486002)(66476007)(38100700002)(83380400001)(66556008)(8936002)(66946007)(2616005)(44832011)(186003)(4001150100001)(2906002)(6666004)(6512007)(6506007)(26005)(5660300002)(478600001)(4326008)(7416002)(4744005)(316002)(6916009)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WiGPlKX3B9OlB8QKF9LoiywqgmiIR1OmuG1cqz8BOIDujlTQO8vZ73Ys/MQp?=
 =?us-ascii?Q?4REdkdcDtmZZHyp/9Brv0BHF0y6XDNiRoXeI3td1ajwYWWe804GI12AO5pyI?=
 =?us-ascii?Q?t9jv6OVT5/ldlUql5LYfetJ23aYDNyJPufk/0XKHXumRK1PIryjGEEktLXMW?=
 =?us-ascii?Q?nLSEGEDV+CEhCUsSJwrcY+cL2CP612dJzKglWaOANR9Lryt2hJykrZ5emyS9?=
 =?us-ascii?Q?wpCDK+uiuWOFrl1IamBOoafm9oVZC1xhLTSf8hlAhw2IpZy+bD9hToAmv8UJ?=
 =?us-ascii?Q?+4wR0tcURv4MLJJQg5t0PatihOOCrKLLZ5268eXVmaUMrjZdBs0wrtZqPpZq?=
 =?us-ascii?Q?M0IaZUarsCzvgRwpDb4Hd1zHXevErsAtQOwZ8NVGcuz3fHtu9o/Li3Z/Nf5t?=
 =?us-ascii?Q?P/GBQ70yZslaQ1Upv8KHSw/D/AJtwfc71ki49+ArFuWbit41YmXw2CFj5Dyx?=
 =?us-ascii?Q?M2+66vPz2KjUhs21pR18ODIU10kmsfXlfRDZYqlqqpswd1catij2gcaX1fU5?=
 =?us-ascii?Q?Djf+JWnmb1/73dh3B+uWfy59D7A1ntvCku1aEDBtJ2Hden4VmKil2/G9Xp9T?=
 =?us-ascii?Q?9Pgnk6dRZnMU0nIUr1dXmmzm7sjJML+7JH0PrzD4R1c29XLF/+EWKYsBaJFF?=
 =?us-ascii?Q?RJkXQ4mgcskMkikETVLNPPa48Cb9hdt67IxJjqS9GTIwuhwZ8CZawEWnCrK9?=
 =?us-ascii?Q?LN627Y7wccAZ++2KyK1mMS7MiQ1ZypalXYWhF8xnemxf3HdVHQwSyEymOiK0?=
 =?us-ascii?Q?Q6IbhnxNJiwQcwOGt2XwbNmwyiGT8Mh+omjpfmLPPP+G0vB6hN3muaL8X/4E?=
 =?us-ascii?Q?Cg9JXUIhlA56XPHORhk68VLuhbCwfbN87qUQiMIb0oquFLk8w1uUEyICPSdp?=
 =?us-ascii?Q?NyEuteQWYO/RQs3FPkgA7TdLVpvg4P2WbPQmliT7lXX6cAicS4eTWSkzDUYE?=
 =?us-ascii?Q?1++ViVOqTiPDWyfNDwp0PQNDz2Vyf5AyTqDaOVn/LFhtI5yQ/VrP7gFIOTwo?=
 =?us-ascii?Q?Sb2clDDuhX24hoRqAPLJgo3ZelWOgxa+BKVfd7Gc3zgG2x8IY9oJxcUF/z5z?=
 =?us-ascii?Q?wNfPombBxIaaIPT+lac8qzENOrS9y+wO+gI40uTEDiQFt1684hmAAbfDnObJ?=
 =?us-ascii?Q?NYP/Re1QckRNuYR8nEfeOw/GP7p3o/G6cRP3QTF/ANcWdSvPRY5bY/A73+Su?=
 =?us-ascii?Q?o4R5uxwb+OqEXJc9PRZ8uwHK21xUU3SJcgJCsCWS7xR6n829O5RBAWEgpdMw?=
 =?us-ascii?Q?cT4GaROgeJeRUl8uFFHAiqNsyyE0DVYsfHQWIq3RSMwPLDbg0xWnIqP1Hp3W?=
 =?us-ascii?Q?Ucz460/Yv1XCynFSE6wgOYy4tKjuaK71u6DtgSwRmuk9CCY4o165FdjTyqAh?=
 =?us-ascii?Q?Su1qwBl5abtab84sNT+Xnqr+f/wvJ1eHwokO/cRavf3JBcad425Bg/Vv4Vnr?=
 =?us-ascii?Q?g+IxWvXZwXavTIAoo1BCYH3aB+EKwm8ScZLpYIQn8pGU+wQ2zVqKgz/th+nY?=
 =?us-ascii?Q?hrOJNO9iQyvjazbpJDOXJLjRnoWIjV4Dh0lidsfy3Urf1gqMVtWlXMJQaVXF?=
 =?us-ascii?Q?4IeIazbbuEsrEkLKjtf66S5etPZTc6gb//gY0ZyPsueJdGnxxVFOOereyE34?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e724947-0216-41d0-07cd-08dab7938355
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 20:49:01.9372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Chkrdr0uKbAEYIlSe8jRXb9YJkodMAZzmLOged8OFrk18MCsQykRLoFKIUaRlVPAAIZ1/8ZrZJXD2ifZcCFR/Ikei33P6vHhSL5NiiuFwf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4793
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Oct 26, 2022 at 04:20:40PM -0400, Michael S. Tsirkin wrote:
> On Tue, Oct 25, 2022 at 08:47:33PM -0400, Gregory Price wrote:
> > Submitted as an extention to the multi-feature branch maintained
> > by Jonathan Cameron at:
> > https://gitlab.com/jic23/qemu/-/tree/cxl-2022-10-24 
> > 
> 
> I am not supposed to merge this patchset yet, right?
> That branch has a bunch of patches not yet posted for review.
> Pls add "RFC" in the subject when that is the case.
> 
> Thanks!
> 
> 

Correct, sorry, Jonathan asked me to send out a new round to incorporate
into his branch, I should have marked it RFC.

I will push up separate patch requests for the E820 and PCI_MEMORY_CXL
bug fixes.

