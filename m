Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBA8C61DA4
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Feb 2023 18:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjBBSro (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Feb 2023 13:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjBBSra (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Feb 2023 13:47:30 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D121E2ED71
        for <linux-cxl@vger.kernel.org>; Thu,  2 Feb 2023 10:46:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WccnbRe0DnVdUStRWmdkrfqwoeAwvjd0CM+8lIChtxOrbVSWDLao+LMJZ2jm3+q3Y/kh5PopTGV9MVZzCe4VYXEr8wY9EHE4e2yZaP/R/pbvlYAkLNKGl9mI7Dkug7un45PhF5OJ54GkV96BMrxpoboteb/RzAnNsOh2LuriGtnFKk4smyvwWnaRqk+UZb95iuE0Ihjg2Fg4hd4z+ORBjEfcuJ9uoxKg+7UIfOASYBb+KsPHeFsEe1sFsV021CbIrF654uDm9kX/4AnNkgyqy+GchRAsr/FLecSbrKYEbZkIRUtPooh3kUFxbi87SOK8q+vJCV2SZERBzf3tfTRjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWvWszwl3hV95vZ/uhQtHfpfiX3+mL57/gGeLtZGQ6k=;
 b=jKlA2IAnuL8TaFjA4Nn1QBQa/Gmgrv+FKmP5E3xKh0SoamKTETUlAfSSn/y1qgSnMiXiAiS42oEWLOyNlHbOrFKHJyRyGZZMoniy7O5HfuOeLBGdRsfEVY+bxGQcQCQmKIpA9qLmsHjDlZy3KWFpvFEktAlBFIKx2rMat4htoIcthEmJuITTT7SK6EpSd4L5bnqIUFMWXZrYBQ5iTJDKLJa1srmsIIFe7gB7z3ifhmWmL3Z0/bEEeed5nfltSJWostZdrjGTIOoHMVefnZiKi0XqqXWhJ+0SeUQR6Y3u8tD0Qg0zgqZ17cL94yIQSfM3Wpbq1Zqn5d6Q0JfZGmHPGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWvWszwl3hV95vZ/uhQtHfpfiX3+mL57/gGeLtZGQ6k=;
 b=FDPW6EUXFFwe/X9T7TMa0FhJjTMOqA5IgXyhzWOhGmfe+bLWbw24JULbVo61m12hzZ4O5+8GDG02IkQwN7D00XcWBr2JI9Z9kHfCBOGJvs13fzQbm4f1LqF29kXcGE52IVzSokqiKU0KpBEJLI/19gq9//VN0N8L6U2CCNxoVjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by CH3PR17MB6667.namprd17.prod.outlook.com (2603:10b6:610:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 18:46:56 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6064.027; Thu, 2 Feb 2023
 18:46:56 +0000
Date:   Wed, 1 Feb 2023 19:35:18 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: DAX system-ram usage by the kernel
Message-ID: <Y9sFRvrI5024NxUj@memverge.com>
References: <DM6PR18MB2844FB8086757984EA312AE3AFD69@DM6PR18MB2844.namprd18.prod.outlook.com>
 <DM6PR18MB2844A9ED953484909A27850EAFD69@DM6PR18MB2844.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR18MB2844A9ED953484909A27850EAFD69@DM6PR18MB2844.namprd18.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::21) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|CH3PR17MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: b09fb548-2de3-483f-c379-08db054ddbc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYP9xHJWdqxPGy8Mt6OaVhD5nK0vQz3y7AliuMLPgv3HoeKedqFTPJKWcVQZRw1yjtsON6c06O6L+D9S6N5Xm+BO/dID3RBpqrWlrIxD/tUmkuv4CvMmF6Q5iRMZu43eygjK8t03ChU7OfP47Qbx4sDeBoY0OFKCyUls83imFQtn/6N/PYtaPwcuthQ0cDqwLogTf/kDhY32AZcANOGljITKdSDSSKSYuS5dE3hrU0l1+o4K4Fp4TMgQMJl5LYjCVKAQo8Kjsurtw+HtPWPx6OqEpclNuhtMQ4SRn6h0vni7C1nA3T+oZqHycJREj+Ue5jEKdOWxiX5JAaP1sJMr8m3q3p7iU/zAileLlkHONW2cNNlA3mdMLpQ4GnYXyldrPlUcEVHKGx0XPj5E2y6lctQj2wNiF9mJvOmLygs0ZlNqAx//ZI1cNlUqADrcjnffndhNiuvYgtStrReXcEN5RXA0AEDFu45tTtJDZvTsA6PMwrhEbjz4vuAMcJ2lw30KYMAjwieMRuknUj53ydLZ6VQb0tNYcA0/VxRiq8/DIScFwVfOC55uhOXTnHw15LLEid4yqCGCqUw0r3ziKJCFNxiAd4tPfdnQraoWPewMuyASjUanrBjYjP6epUPM3NJUHMqzeB7mmi4OYWtr4TcEop1MXXuLJXgBUsBQROY0YxE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39840400004)(396003)(376002)(366004)(346002)(451199018)(44832011)(4744005)(6506007)(26005)(186003)(86362001)(316002)(38100700002)(6666004)(966005)(478600001)(6486002)(4326008)(6916009)(8676002)(41300700001)(5660300002)(8936002)(66476007)(83380400001)(66556008)(53546011)(36756003)(6512007)(66946007)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?VFI/4EjXqvb4+KpCoJc1BXMyUVZ0T21Vm06d93/hsguksKsFnze/dn1rfg?=
 =?iso-8859-1?Q?JY51DgWkvXC/Lc1PNQHpcH9AtHqhcXbDjrc/j1tVbV87jvLmVwCSYHQCvn?=
 =?iso-8859-1?Q?aIpNdCq0OvXnR2BVY1Dw+7io3NlFiE5ll+A9XuApvX2FnxUUNAYjKP3PyB?=
 =?iso-8859-1?Q?o8xwGqFa8pJ557EHiYaPhM09GX7sj/PonF61vJAhARHL16kGOqU8LFv53J?=
 =?iso-8859-1?Q?vrstcayP9vqZLfk+esrRM6sA3ccBY/PJoWP45Dw20av3K2RGTFlR4UMe59?=
 =?iso-8859-1?Q?Ndc1JN/FnL9gy2z1nxz0jj3BhF+MS0I1dndIr/qhsPrp1w+dPgUnmZBKEr?=
 =?iso-8859-1?Q?NCIlgHdOu3qn6ssFGHDCFEYG4Sk3lfu96OD/3kmVjzSOowGIr2uzBYwDjc?=
 =?iso-8859-1?Q?H/IPqlYCeF9gwwzphvLKCdzg4YxeJJioLDcqe+0AHGHao9g2aXsknqZFTw?=
 =?iso-8859-1?Q?6yHTuqesFyHvRkSsCJiD8+RQNWeKl+UhbKevUccQeqfEPAE2hDRjYxOPoh?=
 =?iso-8859-1?Q?LVxI4e5rfxE0eEdOepG5YeP4iOVtq+TQG+4XzzRWt96Q/8Twfh423fhntk?=
 =?iso-8859-1?Q?EhP+J/irGXB3BGyH9waB5wQ2inSP1NC5MG5QIovCnkwBKf+ZBRT7YvME/g?=
 =?iso-8859-1?Q?AKFHWABIRos+A7aMwralUT5+2ivryFOBAO3O/DvhQgeOegOrMWGpoe1LPc?=
 =?iso-8859-1?Q?RGMPRAq64qr+emy5vFLdqNgCY/sj75KGWJAgqcYo6nsfQ/c7BVMxZ0hKoW?=
 =?iso-8859-1?Q?FzGm4m7wrWmZW0tDeK/gQqQVwndETb0+KuOMO7pR8FfJLnGlT5LOVeD2Rt?=
 =?iso-8859-1?Q?VsoBHUh25pM9PrYd72sjaGTf7GUsVdsUboax5AlMBaARGoFg2z5pmqDSYi?=
 =?iso-8859-1?Q?3w/096pSjXkorxMtF8frC9osEl8dmQq3JZgmcpawJcapZjcrzAwz8wTo5a?=
 =?iso-8859-1?Q?apkdP0pgf8keax5IyNPjzfiO4g0U4aZ9a5GChg4lOKKJ1IhEs82rZhTQ+u?=
 =?iso-8859-1?Q?eprGRJo47MgvT6YvOPZhh5sbzR2/yXzttlx+Hi7YHYgHFBvzue74vkn/Mh?=
 =?iso-8859-1?Q?vwYruyWee2COPLJqa4XoVNyMjmjGX8K/9vK1g44lmWJokt7FqscvDTexG+?=
 =?iso-8859-1?Q?pr0BWx1rC92Lu2yUc4x1iZUC4IStAMccaRhj8cY+eXaDskC7jzSpxkG3cZ?=
 =?iso-8859-1?Q?bv2qFQDlcq1Hg8WKd0pZnkpfKZDbp6M3v8H9xbRse5niN6XTBuKY0b5l9u?=
 =?iso-8859-1?Q?eExZsENxi1n3EHVDzrHbCtw8N/xOTFhRJXcIDqS5VV224sq/ZdSCbSaB5Q?=
 =?iso-8859-1?Q?Lwf9nJR6q+oxOgILxx/9ZLkja1jbEhyoWze4OXEXTMFybt3qxzQpHZGcWR?=
 =?iso-8859-1?Q?jZP8Mvya8O0dAa2kuDKz4ixPmloZ4/2qSCpY8p/90F326hzYzL01drCYCa?=
 =?iso-8859-1?Q?roQVKlOi5gjIP4cai/IFnQBWJWOmS/44vaD4vLth/VDUg7SGoov5/5GfV1?=
 =?iso-8859-1?Q?IJV44d6BHhMWxxrWtZ2sTSLHgY2pH638rafJjP2a81JUdYcVcmk/fa77SO?=
 =?iso-8859-1?Q?hH59dX9I7YnhlbUWHpMBF1Q1rsYnUNYin6ep0dsnaOpJy8FMUEFp4sbU3j?=
 =?iso-8859-1?Q?nunuy5UdUFEipJEugPcIyzx6qcERJIYa9DrE+SSo1AHSee/6RNL81juA?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09fb548-2de3-483f-c379-08db054ddbc8
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 18:46:56.3545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9tm0QAKMOTZ1c1pq31/fGdU1RWSiDgP9mutUP+DPMOYPtXTw5fNzWlsJlQAt3gYdhUCGR4q0MdE+PKO6SDmyA1Wt5JjCWmn45fz4c5djxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR17MB6667
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Feb 02, 2023 at 05:56:21PM +0000, Shesha Bhushan Sreenivasamurthy wrote:
> 
> 
> 
> From: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
> Sent: Thursday, February 2, 2023 9:35 AM
> To: linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>
> Subject: DAX system-ram usage by the kernel 
>  
> Hello All,
>     When a CXL memory is assigned as system-ram using daxctl after boot, can kernel allocate memory from this memory range which cannot be moved and prevent this device from being made offline ?
> 
> After some reading, i found that this memory's valid zone will be "movable" and not "normal". Therefore, kernel's kmalloc, mmp and page-tables will only allocate from normal zone. Correct me if I am wrong.
> 
> Thanks,
> Shesha.

There are a variety of reasons that moveable zones can fail to offline.

https://docs.kernel.org/admin-guide/mm/memory-hotplug.html#memory-offlining-and-zone-movable
