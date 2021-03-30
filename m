Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C59C433DB
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 19:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 794A061998
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 19:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhC3T0U (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Mar 2021 15:26:20 -0400
Received: from mail-bn7nam10on2086.outbound.protection.outlook.com ([40.107.92.86]:3808
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233092AbhC3T0L (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 30 Mar 2021 15:26:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kk9GK/KL0lnaKFFonO4YRScO7aEaSGna7twh7xXLmFmov/bYzRFbvcqtInvCZEZqOZeBxjnC8TUMjEeZNxtF/+wslh/BMNwymCG5yTXTaLK/7tYWblAFLtAdXZVm03tVj+6X1kcAq4X76XlxPG6v3Th7UHPPQFvEgWY2IQ6wp5oDIgR/QaGWqwWeEhmra8l09jwWipcRj6GZRUY/vo4zd4YnVox12RKWi9u6mxwezZ1jvaRmmNiWnxQL+4IxQJqrJUknHAPFjXbl4dblZExvaEI9YJyXf14I2euGPzF2KbsM0v/SVfdyuzx898A+9Ec0pjdOvC9IU4VVx+J7iFeHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KY1u/qnC6SPkhbrytHlbMSRBq3z2Siih5em5LGy9A0U=;
 b=K/XiVaB7o5h3bdfZKYPq/KaI5ZmB57JwIyXOHZpUPzSBQvMcx20G2NljffHYAwSAGnPocLItmYgY/aDMPAxG6BU1R4xBCSu+GQr3u/2EaUHvtGoL0AzrTRzCsrq/DIPu0bcjQkZGs4eSUUW+3AnZqO1eESGhmXjUz7SnA+xMh+kxpxKrHI03lHS3YsVHVQ7JFWDDQfyDkEg98L8YVyeZVg6F5cwyXqxTcpHNQGvmGg/SIkBoQziBkgbPtXtIcPfQyBLeW/earQ9FjTleiBXrnwCjCfwjA/JOAsY1u/FqGpHvbBipS6lnguFrm/AWIAC94Z2rqrojHBoGTiRm+LCUXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KY1u/qnC6SPkhbrytHlbMSRBq3z2Siih5em5LGy9A0U=;
 b=t//ficrp5pDf4PCFWO7eDu6Q2XEBY/RuJy0W+2nS/+Oivl6IfykO9Wzr0UGvA119sUBeYyax99vaFmjrrVDQCTZhz5HKrt1dC16/LJQHvNrr1g9W/+2MKKRhPDmfbV6evbn6WeYu8IswvoK/DH6dcZ/jFGdo+qZvIWSIujIegHNyl1JBuQlcqYTsLwI38cbvBQFenrzVd8QF1e1HBRwADoEl4RXdrQHWAL3r3ZGXegOOHDrfXEtqW2ZDizA8YLzIZ678SIvKgoRF0iSoAWJsyqQZShTTNm5PERXurWoF/hPVrcfZtN2KLrcUQB6Mfs3/+LYhyWRAP72TeGsoUqiWDQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 19:26:10 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 19:26:10 +0000
Date:   Tue, 30 Mar 2021 16:26:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Subject: Re: [PATCH v2 2/4] cxl/mem: Fix synchronization mechanism for device
 removal vs ioctl operations
Message-ID: <20210330192608.GA1430856@nvidia.com>
References: <161707245893.2072157.6743322596719518693.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161707246948.2072157.2116502455691653472.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210330111620.GK2356281@nvidia.com>
 <CAPcyv4iGByX1+CoUnc3SJahvoT0NGNnbkcDLyEkSJ8YFC9PBUg@mail.gmail.com>
 <20210330154712.GR2356281@nvidia.com>
 <CAPcyv4hL-B=1hostoj9t6EE5impmcDR2-wsgahvBKdzL9LbqLg@mail.gmail.com>
 <20210330170253.GU2356281@nvidia.com>
 <CAPcyv4ixD=+PejHErT_FLtEyXsm4mk+93R7mQ0uFtd_kd-fs1w@mail.gmail.com>
 <20210330175431.GX2356281@nvidia.com>
 <CAPcyv4igMvwfZNgi-Uap_QUJi+uocMUD3KZBhXUy56AuHZQtqw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4igMvwfZNgi-Uap_QUJi+uocMUD3KZBhXUy56AuHZQtqw@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BLAPR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:208:32a::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0115.namprd03.prod.outlook.com (2603:10b6:208:32a::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 19:26:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRK08-0060oI-FS; Tue, 30 Mar 2021 16:26:08 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a3f729a-602f-46bb-627b-08d8f3b1ac3f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42502DAF7922202FE64AE09EC27D9@DM6PR12MB4250.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Ddis3q+o031SCaacVWZBC0PacP8AYrTWnhWPFB1dz6Grs0NmmiYHlxiHR3kC/kbhHF6QzYdusa/1RwTmP5AMkz4FhGYFgqqLG4phWvEAAS5KDHRDk0RANngFKwWjoiV4N6tKVDJOK+qCIIac1Zxc+/uTig+eNDjkNySgDfmOsp/GuIjZXGIiYsX7hnWjslxpEQxrF72cf60V2roGjJZdzdGkBq7hh4q3uQzvSgVP/Spq5DaZGlWNyrL0iDS42JxLpCBoJotbm3bk4sGwzLBROao5QK1j4+TQKE97+ahVH2Mwzm0VvhpKno/GY9vcpfpbe1eZPY4iLVOTddGuC3dprpzqQdX6IaxCmy1dSoKajk8gIsMGXUHdIx1RLjffQFTH3in2PDq23HdWxlmL5phqGEbM1W5EM3d0OKmPSQXFwodjFnmAJz3cuRm/yBlxvldwrCy42wOkekNDXcMUs+urDxO0Y0XIBmN++4+wECjE5IBQkn99yuenKHGpDMuAQzRi38g6cycmZo4LLH9d6OfKBRDxO7RdU3pHTOe6WbXF72NxZlSjnZrHMhnBB8ZhjC+b9xEy55zBrD68z21rZA4g8WsSU+a35+AglUe9baNd8/03yQytc16MASe0KRa1FBb3/3EOTwjpXCduWHK1OTIa+4AsN5QziYbfLm0pGR4irc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(5660300002)(33656002)(186003)(36756003)(86362001)(1076003)(54906003)(66556008)(478600001)(26005)(9746002)(316002)(2616005)(2906002)(8936002)(8676002)(4326008)(6916009)(66476007)(426003)(38100700001)(83380400001)(66946007)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oizjGeoud2A0stjLYSzd6GtvvDuuahe/tIOASXb4D7rAtYZfQP9Ll18s1Kmk?=
 =?us-ascii?Q?27CXxkRYyudnrZQVVHDHA5qxsphHBJ6iXNpQf7/czHfBQJ2eDXNAKi4CwA1W?=
 =?us-ascii?Q?RggYAPP1nfux4XBRbEHW2VPw8bt8n4Ry9y6CozfWbMyMqlblJOTjNEyYYiXt?=
 =?us-ascii?Q?MH+PTwVCartcAvtPs86gqquLpafnY8C/dfjHEiaFLT8Fe//o+RKhE+W/EI4k?=
 =?us-ascii?Q?/Pn+DHNqmDjHz4Vh/SxhT8R/WqOLyk0uEVMyDdOGhc7qiitF7TnQElxvYPv9?=
 =?us-ascii?Q?VyVMDl0c7CilB65QqVM99yJ3T832YoejLmS0trABv9nDYdx9WFtsXh6lHSKB?=
 =?us-ascii?Q?xNZ1gdYMhD41ZXGn+wfViBDqkqgr/RnKGyPPEMBjvrLTT4K8TxK1WfQBu0a4?=
 =?us-ascii?Q?m/g7m88OEcFWsZm5Ip+WpjhE9RH9i2nK2GXz2I6vyKBQi8phY/f4Ug/VmdRS?=
 =?us-ascii?Q?J5hxFavqlVjW7f6lgfH1wbRYwh2CyTxEh6EFq7/GN54CejcPifRe93oG6Kj3?=
 =?us-ascii?Q?c+2tZZxx9Nvz9ipo0twrKJfkqniZQ++IQwiDYtEr6MTP5+vBIip39z1blFfc?=
 =?us-ascii?Q?eyvNftgD8E67A5AXWJpea8dBwXKQNCNrieiJdyaghdhwsh67PNeYKzxqUiyV?=
 =?us-ascii?Q?fO64YaqaL2fdyLbYwIFNZI46u6KV2bJEa8cHltFvgiz9NOhNZmIIu/Zfr44a?=
 =?us-ascii?Q?ONNzGqO7kxgCBtFNnhSJyEQLOqtDDfAzP5aQyAOA51f1eZj8seLIglg4NDda?=
 =?us-ascii?Q?yVU03Mz49/RFc4IaGuMYNaAq8KRT6/oFsg7nJLnsC6UYVie5lCAqTT5tF/9x?=
 =?us-ascii?Q?MO2EQ235cIbmc58LXXdllc3uewig1mIyizkIzs56F7kDXNw2JZtLi23AjAQf?=
 =?us-ascii?Q?8Bln8uvtsPhL3n3aFFnrzGIiIt6D2CoCWV54nGJQmAC+zR3r/NJSZnPx1HFs?=
 =?us-ascii?Q?VWe/UiiPFIxZGDgq1JVKA3FC7mGZ642nTMP4IrgSRkTITM/9pUU+nB8Xi0M3?=
 =?us-ascii?Q?3tHl0KRtWr+1ij0Fma4ghmWxRd5hHS6BTlk/Rx720qQqHHM5dl70UekFomx8?=
 =?us-ascii?Q?B4+nh2Xv2xcdtOQ7UpD0oaAKXJl/XanNkhhsLSoQyy3swI3dlgmAUtciUQWZ?=
 =?us-ascii?Q?PbGqf0BDBo5AqVWpE9spwgLJWx1xEO4VawpFz4boHkZUymfetrUPMn7+jbbT?=
 =?us-ascii?Q?0fxLu3NO0BqnR7RRGzRy9bxAekUweHGho9Vgfsl7YaFGhs34soYuB3+vgSCo?=
 =?us-ascii?Q?+iDNPIY96q9e7FyQ6s5hXrTDOJqJTSxGa39w3zl9g0viOM2flHSYljGY6jyn?=
 =?us-ascii?Q?5gDCmrcWjGnTRGqy3GsXc60hXpS6fIJrNA1991T2jYfvgQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3f729a-602f-46bb-627b-08d8f3b1ac3f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 19:26:09.9789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hy42yDeRmpyZWHLinil5tZznTHp1bm492VW3O2O0Md8Obr9JoQjfD2XCh8iNcgvF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Mar 30, 2021 at 12:00:23PM -0700, Dan Williams wrote:

> > > > IMHO this can't use 'dev->kobj.state_in_sysfs' as the RCU protected data.
> > >
> > > This usage of srcu is functionally equivalent to replacing
> > > srcu_read_lock() with down_read() and the shutdown path with:
> >
> > Sort of, but the rules for load/store under RCU are different than for
> > load/store under a normal barriered lock. All the data is unstable for
> > instance and minimially needs READ_ONCE.
> 
> The data is unstable under the srcu_read_lock until the end of the
> next rcu grace period, synchronize_rcu() ensures all active
> srcu_read_lock() sections have completed.

No, that isn't how I would phrase it. *any* write side data under RCU
is always unstable by definition in the read side because the write
side can always race with any reader. Thus one should use the RCU
accessors to deal with that data race, and get some acquire/release
semantics when pointer chasing (though this doesn't matter here)

> Unless Paul and I misunderstood each other, this scheme of
> synchronizing object state is also used in kill_dax(), and I put
> that comment there the last time this question was raised. If srcu
> was being used to synchronize the liveness of an rcu object like
> @cxlm or a new ops object then I would expect rcu_dereference +
> rcu_assign_pointer around usages of that object. The liveness of the
> object in this case is handled by kobject reference, or inode
> reference in the case of kill_dax() outside of srcu.

It was probably a mis-understanding as I don't think Paul would say
you should read data in thread A and write to it in B without using
READ_ONCE/WRITE_ONCE or a stronger atomic to manage the data race.

The LWN articles on the "big bad compiler" are informative here. You
don't want the compiler to do a transformation where it loads
state_in_sysfs multiple times and gets different answers. This is what
READ_ONCE is aiming to prevent.

Here is it just a boolean flag, and the flag is only cleared, so risks
are low, but it still isn't a technically correct way to use RCU.

(and yes the kernel is full of examples of not following the memory
model strictly)

> > > cdev_device_del(...);
> > > down_write(...):
> > > up_write(...);
> >
> > The lock would have to enclose the store to state_in_sysfs, otherwise
> > as written it has the same data race problems.
> 
> There's no race above. The rule is that any possible observation of
> ->state_in_sysfs == 1, or rcu_dereference() != NULL, must be
> flushed.

It is not about the flushing.

Jason
