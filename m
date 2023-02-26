Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B12C678D4
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Mar 2023 20:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjCAUFC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 15:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjCAUEz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 15:04:55 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464C04D62A
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 12:04:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLWB8R3OGk0VC23HeSB30f0mUj0mqs6/HG/IcU1p5+FGzKUYfzRpXfLvhtJ7LKZwSYyi14OzsrfVxjdwzGZx6HqLcnc9nnPXwrRgS85RSyNikKoTo1DsemMyUgRoCIW/JHeeKgZv6YfZyGItaahwXk96kaZfnkGK49xLZUY7zaueiREHNcQa/nfV+7vDMAVDf2awx4xKC4NSADVjcfZIYLBXtu81In8Xvh6m2Atk5aeF25ddroBnlZGDIuGN0pfCSe0H5wzFSxewCiMEUt2IDO4HE4Y15puUz+3SoBs6bBh2goL9/gcCnHKMnYr9tXzJf8E+SHoJl/8KPlpkDC/7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeRgI0U0w5VDwzGBEViEzQVd0JFEaXea/r/uVIWopXI=;
 b=I9W0rbzgm0ro8KV+T1bGbg40/3TWnmYVA5DbFfPI00BK9PCaCagPIZjcRpnkfTLaO9oitnTiFbRysmVjvJ/EisEYXir75o4MneBIPD4Stu4ooWDSawakDNU28QJWXoGqgLacI78dYwN9ZC00qhbK4A8JxGoEzUpmzrEhitJG3AsQHOCcESZV/+omZ/XVq1CU1iF7uEEqWPbTFHtXYFN3N8AX9XjRemdbxgH1fRjJZF3Fm6cn6+Q577eIlXN6BTmOwJjC+rJbvHauDFisnwvxzVESN8eKIIDEx809+W6cZENLZcrGOgDwUVpF3HF3zMGc4Wug83PamnSINI8teGcq6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeRgI0U0w5VDwzGBEViEzQVd0JFEaXea/r/uVIWopXI=;
 b=Sykve9eKMKyI1YDJBSCZn5f4+gBq9Ajl7khQ5uV56uoubfl3BpXkt4vCFI66suVvNcN7icPwgGxklLUnc+88KlheckssDd5T4M4u83GqhpW0s8IvL5Z5by7hfme+XOmqmeUSRDK8claTfgrLJ08TjtBdOQghMy9DGHsBqWsYwM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by PH8PR17MB6767.namprd17.prod.outlook.com (2603:10b6:510:25e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 20:04:49 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%3]) with mapi id 15.20.6156.018; Wed, 1 Mar 2023
 20:04:49 +0000
Date:   Sun, 26 Feb 2023 02:28:49 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dave.jiang@intel.com
Subject: Re: [PATCH 0/2] cxl: DVSEC Range emulation fixups
Message-ID: <Y/sKMTesKWH20Ig9@memverge.com>
References: <167703067373.185722.16579529992799939220.stgit@dwillia2-xfh.jf.intel.com>
 <Y/gPhE3hDnTEd6PI@memverge.com>
 <63ff9d85215e_495bc294e2@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63ff9d85215e_495bc294e2@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR06CA0040.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::17) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|PH8PR17MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b70b71-7953-403a-b856-08db1a903652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zMkwFz+6FR3/W1PwK+8gkZi5LH4OiASgdTIgrwd38bTHLpsCNuG48qVEVPHAk91xgaU0s+vIo6dQmC7WZLCGExqLrSjGKdzfov7o+QbXkGM4LynWs+6Xt40cNvQ0jpH7IoXNIubkmFKPhPyku/5hoRoH7GBaYNqO8wjHVat+ocvGbDZx/azvT1QdJoHFoE0dRZ+do5F8ht9454Oqx8JKROLEejWxW4Jy4hmkOplJWVAPOhs0DMQVNdZbsoCjjtW5NdE14aocAMaNQCPg8N8BFlqzVI/kkikiAOlh8HZ19Ta9q2kyWtz+5Gaq4NjCjwGu28ppLQx9uDIysBMqvxIKm+s/0j2xCjCeIdkuI4SoelvdbYx5/+GFklthtb1CmUU2xsuVGkHODD1oeWNqTUcqWhwcQ2GsNx3oF1u7DvT3WSdnwhb82W0oL3BpZzlBvx6mFZf+rydWdOq/GvY61AE5k+TwlINoRB99BE5Ur+0pxbM4HeGdgVkPDAQNmLPJZg+hBk6q9gUhA6VZZCWCSR62MRGvAKv8hSM/JA/f/X6Svv5giRsHIBTiFwtjp2OdQ2IUNlUVCAcWaoDz8UvAr3NHf5eka2pYRIEo9xC4ThypeUW/93K/HyM3EkHiC7K6399wst3ZHzVN137Z0LKWKbXPgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39840400004)(376002)(136003)(346002)(396003)(451199018)(38100700002)(4326008)(86362001)(44832011)(36756003)(41300700001)(66476007)(6916009)(5660300002)(66946007)(66556008)(8936002)(2906002)(8676002)(2616005)(26005)(6506007)(6512007)(186003)(83380400001)(478600001)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CZNKDlOH8QORYXcJMkepADZhfWTKA6eTKREPouqqyT0NCYgzc7HbT7Ggz8Tb?=
 =?us-ascii?Q?yJVaRvj7rnMazPPCZp8Qx7ReGI7osGTLUXEhW9wGbfHnyCzJYjZ8VfOGQP8t?=
 =?us-ascii?Q?EEnd8DgGZPYbh8rAQM/Pmcf8XngPSzErKHArIEPsvS2FB9RxaHe9pvy2VtPN?=
 =?us-ascii?Q?EhczFGxcJitJEVhm3nJ+j8VqbokxIciSu+KsFCSUb3AWCWF9Y/tWOHEQE2bc?=
 =?us-ascii?Q?vThUjDky4HKjeXJq3xQ1SryUsyGGVJ9C2emPsMO0pKqjSSDxX9xQa7Y741tU?=
 =?us-ascii?Q?WHGan+vnAKNi9sOMhD3E9qbMwE7Bnc4QScHBKJr9hLnPowD0uKELx136MIxI?=
 =?us-ascii?Q?eicljAIda3Unkvm++tLlU4FU/7ARf2pvmfsnmSdqyGX7mtkRrUd6jEeINIF2?=
 =?us-ascii?Q?8+cyaLg4l0vhimKBCohmOhL4eKWWlGVFAGqYd1lmsNgsn+3nUR7CUl/ZRwan?=
 =?us-ascii?Q?NRPgs9uxCSqEhi7/AnZDcHc5AF8bpIhXAxrOPDZ18Mv70FKJ4IMEhWlHyzzK?=
 =?us-ascii?Q?2btzZ/LuCY1tdPtn/+UNgQ4Nx+LTdCQrrV7sH4IfbxTnfqH4Ws/w4v3Lz8HZ?=
 =?us-ascii?Q?BWCovVN0ZvkmrW8w/g7bAvlkLikgmJ5v1B8I9N1xE/JDTz08WnmSDHngxxTi?=
 =?us-ascii?Q?DmEFB1SRHmkLKs5UhuTi7g8IO6ngQT7kEOF4qfhE3AQR8cHuX+mQIgAsUKM1?=
 =?us-ascii?Q?temfcQv/rWu6x2QiI4I/lHRZcTcLSDvsX5dmAB8UiGvcgosWghUj9iE/71ef?=
 =?us-ascii?Q?NmvXIUy7rIzr1iYm9mk07W0qC4fDkJBzVPnAVp9234I5IJKqrbnchqgRj90A?=
 =?us-ascii?Q?+t/WL3FpdfznlVjXC+cMLuA00kQOBiCvHCa7bh0Gz/6KL5otE5AlPamo8t9B?=
 =?us-ascii?Q?tYVT7N+DTKDYVCnizi86dLprf7lwMN+/hdxQpIPrvAtoGRHluRRzYov3HBhI?=
 =?us-ascii?Q?l/jnlZCA7BwhmLahiN04hSWIcb2f6MqJBtZGMdPJSgxTj971qnwkAdiN81P8?=
 =?us-ascii?Q?zMl/PqIv8Ck5spsq7vhpFdui1fyKDsRao36uF2E5za926GfbkDQgRwPiYIBz?=
 =?us-ascii?Q?fzaE8WjTVTRcknQE8fGSpoJO/MJXCZpvYJUZ8f2GHDflmeXlNjOelKNwqY44?=
 =?us-ascii?Q?G0eb3mHzCSk6gAyhgBSwFmOYjyCjhcQMskzkEAePO5m0VzNirX+ybWp2V8H/?=
 =?us-ascii?Q?47H6sKN7zbZnfYCYSxGdHBo06z8RQBj6aQlydGRHNeSw/uZ9tq5JTcouaB1b?=
 =?us-ascii?Q?c9ShBBiIia33SINkBaJ8GNBy/UY6P8CN2k5IQDnKA2tI8Qpxx8QYF0wX+f33?=
 =?us-ascii?Q?bCjPuAo+bkBZ1uZ/ZPyfMmW/SYrKlylXF/BB9ofc4XNCmrF/hCgQgpm98akH?=
 =?us-ascii?Q?uD+N3pqi9oRWecMeoUwElpMm4ZwfC1uVhInEAAHyszv3xFMhs8P8Q/o7jjd4?=
 =?us-ascii?Q?CIPy7uG4SNLMw96QZ697rc/YgAhc0rD8m4c97drRxa65MnJIl4gcHbFyOH8F?=
 =?us-ascii?Q?ZbkkEm+7EMv+y1sT1DmBIRk//EfzgOy2zzPIztY0nhtNGsr/BUUPdvig0+jq?=
 =?us-ascii?Q?dflN3cuSt3NjmQnhhV71fkr1SiAB6s6v60KZxRZj4r14jmPDXhOnJD7ehcBP?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b70b71-7953-403a-b856-08db1a903652
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 20:04:49.5185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vT5sNdMUj0mYVQzpknM4zA8CH8dWbM2nzfKN0lT2vgKSCnblbppV1K70V+iSJLZzy9pR2S/StW3Jypfxrb0leIpfuTZ4tqNL3gEBcyqqK1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR17MB6767
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 01, 2023 at 10:46:29AM -0800, Dan Williams wrote:
> Hi Gregory,
[...]
> Would be interesting to know if decoder_populate_targets() is returning
> -EINVAL or -ENXIO.

It returns -ENXIO.  We have one attached device to the complex, and that
device appears to populate as expected, just not any root decoder
device.

> > [... snip ...]
> > [   21.965126] cxl_pci 0000:3f:00.0: No component registers (-19)
> > [   22.001597] cxl_pci 0000:3f:00.0: DOE: [d80] failed to cache protocols : -5
> > [   22.002351] cxl_pci 0000:3f:00.0: Failed to create MB object for MB @ d80
> > [   22.003265] cxl_pci 0000:3f:00.0: Failed to request region 0x0000000000001fff-0x000000000010201e
> > [... snip ...]
> > [   22.339973] BUG: unable to handle page fault for address: 0000000000001000
> > [   22.340584] #PF: supervisor read access in kernel mode
> > [   22.346801] #PF: error_code(0x0000) - not-present page
> > [   22.349059] PGD 1339ec067 P4D 0
> > [   22.350877] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [   22.354558] CPU: 45 PID: 1351 Comm: systemd-udevd Not tainted 6.2.0+ #7
> > [   22.358357] RIP: 0010:cxl_probe_component_regs+0x23/0x180 [cxl_core]
> 
> Can you send the output of:
> 
> scripts/faddr2line drivers/cxl/core/cxl_core.ko cxl_probe_component_regs+0x23
> 
> ...from your kernel build directory?
> 
> I suspect this crash can be avoided with an explicit earlier check for
> missing component registers, but that's not really a fix for this
> failure.
> 
> Can you also send the log without these patches applied for comparison?

I will have to get back to you with this, we had to pivot the box to
another test and I have some personal things creeping up on me.  Likely
sometime next week at earliest.

