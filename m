Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9CCC433DB
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 17:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EBFC619D8
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 17:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhC3Ryv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:54:51 -0400
Received: from mail-dm6nam11on2072.outbound.protection.outlook.com ([40.107.223.72]:32801
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232524AbhC3Rye (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 30 Mar 2021 13:54:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AADG2m7hqurew/jsjJR9/r3RTKkc/+Sh3ZO7o2wkxtUG0RgYd0+pvK+KIjC+zHpXWSsqks7brRm5g2ULL993G8fyWr/ya7JLuYNZqOyclwQ034ihCxBp4TSN6PWbc6ubHgkEscfPPmG+UHU7eoq0UN2aJLuweeQkV3FkhfChemHag6uZrWH4bXyeNtqmKjDFeUJPk+OgHdTJb1MHxf46//6MlrRxm0oPBb+mGuQDZIvZkytR1sIfFG10FuD3ysaH8iFj2mFbGglJnfrufIJvPIWPXS1G6fHgDdJ5cakmfq3ki2Oh/8zf+L3CV2Xk0rpPhfrDS/VF3X3k6qe1y6FTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUvMyWr9VDzM3RelPet5fdrL0Q3kYaJRxEBDeQCj9sE=;
 b=msTqSFUoqW1nhbZ0v7BxIDop/b/gThwFpZjAEEeifS3gTbOwrmISoaYGc0x9e4B46yzIlkklrol2hWriza2hGbWSjGTnNIud4FjhUfoNinxzkmbXqEiDbRPBGekRW9QV3uh4Ces5IW3mclo4P/k2DCuQUXPcoRTW1Gzuat0HbYzJlnIhwgDgNIU99Az5ijPbH4gtn/yJCkmhUO4JdqYLny6IX9F8PaP2bsVwASEqvQi63CrcZhA36lL5btkwg7FME1kFk+LUm9Diq6+SmRao35Tf46OUW+nYywrGvlzfVp0IX0Js741vizyYTr3oV6sBRvnB25wjfmIgvzij0LOWJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUvMyWr9VDzM3RelPet5fdrL0Q3kYaJRxEBDeQCj9sE=;
 b=SDUxAUsj1zqc2zVrcpDrXpjCVUH90DyuTWId+qyO80omDUbIMFFx3W1jT7/DjGp7LNpJkmBNHm2vZnKLSgMsJKLYVrKg4OlNc1FcIRz03kyGIIx86pPPdWa+StaBKWvHE5uhceDWoakEBYI2LEL4yi2vjwYWTgyBaDCmEJg2IhUn71o1fldyHSX48CCA7ZfwzH9aLBr7jarIYrXcOxwCvVxsrcOoNjdlYKUaePpaEFl1+RkqWTbjnztND21rTaTtJqEybSt/+YtCSBALQcB5iFROnd7aiMD7HIXWvUFYJkZDU2zdyMbyubAhl78HL8U0Ybi8TxWR6lh37RYSDJ7FXA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2581.namprd12.prod.outlook.com (2603:10b6:4:b2::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 17:54:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 17:54:33 +0000
Date:   Tue, 30 Mar 2021 14:54:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Subject: Re: [PATCH v2 2/4] cxl/mem: Fix synchronization mechanism for device
 removal vs ioctl operations
Message-ID: <20210330175431.GX2356281@nvidia.com>
References: <161707245893.2072157.6743322596719518693.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161707246948.2072157.2116502455691653472.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210330111620.GK2356281@nvidia.com>
 <CAPcyv4iGByX1+CoUnc3SJahvoT0NGNnbkcDLyEkSJ8YFC9PBUg@mail.gmail.com>
 <20210330154712.GR2356281@nvidia.com>
 <CAPcyv4hL-B=1hostoj9t6EE5impmcDR2-wsgahvBKdzL9LbqLg@mail.gmail.com>
 <20210330170253.GU2356281@nvidia.com>
 <CAPcyv4ixD=+PejHErT_FLtEyXsm4mk+93R7mQ0uFtd_kd-fs1w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ixD=+PejHErT_FLtEyXsm4mk+93R7mQ0uFtd_kd-fs1w@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR07CA0020.namprd07.prod.outlook.com (2603:10b6:208:1a0::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 17:54:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRIZT-005ya5-Hu; Tue, 30 Mar 2021 14:54:31 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ea5e0fe-7e9c-4be7-98d2-08d8f3a4dfce
X-MS-TrafficTypeDiagnostic: DM5PR12MB2581:
X-Microsoft-Antispam-PRVS: <DM5PR12MB25814FC4DE09E30B44BF07EDC27D9@DM5PR12MB2581.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V0SoZgoPPhhdqi18KCskb4FUKkrsKEaRSNYAYHAg6/u/baIYYrKUPZOY80k1/PsOP9Dy/CwJFSY/Fl2YlI6axiMSF4rxIDyqH91cyr65RUBlMmFschAovv9n3XLkHnu6vI9sU2DV3XQxKqvyov1ST+DmUcM8bDk6G5Gcko759abWzydFlfhcckJywh5/iPwlykRBZ29y1oJyXrVK6gGzaoG5yegl+UgylVoZMLdj34e3jDF1gmdUSC1/l8/HEYv7GxgXWV+UWVMEF7ZhcgSjflu9GL26Bl/RpVmQhpn1TqKUo7ohNbUzwvYXizYE7XAvK2xfarE+Rc7eYAwbtih+P7J8aGMyuMeiEk5C+guRBlqhVRW5IUNJbLR8OERnR9zEdl27b39svZuugMUbTyaxNWICGAN7axDVzqIXiOLNj/3k7mlnme2HHfOZ+5Rm4XpsCrl/Ky0tEoIPHic+mzoA1y3MdBUWLH+pxp8CQN1C4MhV191Perx1gLM8IJd3oxqSFcYPxEa0eLXm02rLHPMY1oaSe+nGJ9wiP3tEvkGHB5FhDC4TAnPFZTysSR8OiyUylGJWVLElDKJa/V8JhBRIh20LhDVJkt9i80bUfXTjhe0kGrf3rlwRznPbG8wlU/ckMbRQd78vlTorRdwOeTr4IVyn+jy5KexDvIUGpKdCw7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(26005)(36756003)(426003)(1076003)(186003)(2616005)(38100700001)(2906002)(316002)(66556008)(54906003)(478600001)(9746002)(4326008)(8676002)(53546011)(9786002)(86362001)(8936002)(6916009)(33656002)(66946007)(66476007)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OA21p0pSd3tmbUUfS+earAvPKA/N7zgbw9KSog0KKt+Ca12JH0nc781nv9iw?=
 =?us-ascii?Q?7rqV0BLvWUvhOah4Y71KyrzooWc0OCAaWgrAdyKDRvL65JKCINpkJHJ62N/H?=
 =?us-ascii?Q?HHLSBH3QnDjqKjPKZHkxv3oiHO7aKhbfSpTruuIR3wNjPvJJd9Q0Zjww46V5?=
 =?us-ascii?Q?XGPtEdWslMtOTDDGzg8dnzLAQv7p4D9TMs84kXYgEd9fUk8t3MqzLq0QVYYA?=
 =?us-ascii?Q?QxOMFNQjRMko+uaOg3QZ8TB+QWUmrBjon3jDeiKCa2SsPsKZBr2nycv+3fEC?=
 =?us-ascii?Q?eref/2bc3WKj5XHa77qNVSDf7nJAVDbRc48yjWrCdlZpgyCs9GKUzdmHJ17B?=
 =?us-ascii?Q?QNkATIewZBmRGs99ZzfQJekCGtDWX5g50NTvOL/9jzVA9Hjkzdd2isuZ03xX?=
 =?us-ascii?Q?TGpKLR4U7Q3gbWs5WS5a36jEOtt83Kt9cLyA+5GPxPYAGs6KvyXL3zTKpC1m?=
 =?us-ascii?Q?m2Sn661Lv7TwbN/q+dLJ8pjnrXfXtF+1kX5AQ6ewy3Ns4Y6cDXxAO9uDei+w?=
 =?us-ascii?Q?Y5NY4AaQddl7hQ/JSvlgBy9zEz7r9m8A0OGMhECZWs4YTeowMJ5Fff7LF5dO?=
 =?us-ascii?Q?JF/TgS4tabDztsiiruZOCH3H67nvijeEYLuFsosm0uP4pVTH/O6W2VJjCTez?=
 =?us-ascii?Q?pHKCJYEO9XLAuu6ZYAbMTfYonwIQcKikGRej/6QEOmeuT6KumRxp9LanT4gW?=
 =?us-ascii?Q?bToWMe1ZlQfgJfgLY/vueHe6DbnvWFqk20otTovrZbQuUhR9VSaPtZkmW0YF?=
 =?us-ascii?Q?FmXQYCIu8qcEGFn6d4nuV5/XPfDUYUiGyM9+nYkhizYi2JEl0bwYub1+033Y?=
 =?us-ascii?Q?GH8rap/KShDrC2sATmIv66YCWh09SqRc76LxHLHIBAW2UoN77ijh6sb5qx5N?=
 =?us-ascii?Q?g7p9synSUGPhKERjXtrrTmHcdEGkHsMz2eMWONmZQ/lTQLsfBLzJjb+Szw1l?=
 =?us-ascii?Q?UBSmIJ9H/J+uGX6ryEU+zsg8Jg1eHwXgRGeg0Eeed+bocw51KyaMgzgdwrCI?=
 =?us-ascii?Q?FqXb7tNBf0hDTyv3twovEnUxfOK99MSmSp+gvK8pNA+Xz7YxJwpWnJpL45t0?=
 =?us-ascii?Q?3MfZqH+dU0zDVkR7VRe33mBAJYBk6Qqn4LHnu+Qsj4/VqOtH9lvzDhqaJUaq?=
 =?us-ascii?Q?5UAH/NEf2AZ960DWxhj/1akmAPC2RSZ2qaanN5DpUfK+L93j95HriJx1uJBM?=
 =?us-ascii?Q?tQv0PbT6xWrsPVWKO7b+f4g62t5Z2OMGU3loz2EHXE4aX6S8HvSrIiGQpwtz?=
 =?us-ascii?Q?5tFaCRGEyqLhGZ9Qr6cC5E6QrgdJ6vjaC4vnl3eAZao4pmkdO6BIjRbI+6/+?=
 =?us-ascii?Q?2sXPzpF1Ryy4+s7S/IqzE6UoYHlQgrCM5AlRMWnXW/5Czg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea5e0fe-7e9c-4be7-98d2-08d8f3a4dfce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 17:54:33.0078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: If5oJ7ja8E80mhVmSAHn8AO3jnmoKt4XMnkaKHAGOaeMbRi2Kty/ch8IFd4tVQMf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2581
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Mar 30, 2021 at 10:31:15AM -0700, Dan Williams wrote:
> On Tue, Mar 30, 2021 at 10:03 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Mar 30, 2021 at 09:05:29AM -0700, Dan Williams wrote:
> >
> > > > If you can't clearly point to the *data* under RCU protection it is
> > > > being used wrong.
> > >
> > > Agree.
> > >
> > > The data being protected is the value of
> > > dev->kobj.state_in_sysfs. The
> >
> > So where is that read under:
> >
> > +       idx = srcu_read_lock(&cxl_memdev_srcu);
> > +       rc = __cxl_memdev_ioctl(cxlmd, cmd, arg);
> > +       srcu_read_unlock(&cxl_memdev_srcu, idx);
> >
> > ?
> 
> device_is_registered() inside __cxl_memdev_ioctl().

Oh, I see, I missed that

> > It can't read the RCU protected data outside the RCU critical region,
> > and it can't read/write RCU protected data without using the helper
> > macros which insert the required barriers.
> 
> The required barriers are there. srcu_read_lock() +
> device_is_registered() is paired with cdev_device_del() +
> synchronize_rcu().

RCU needs barriers on the actual load/store just a naked
device_is_registered() alone is not strong enough.

> > IMHO this can't use 'dev->kobj.state_in_sysfs' as the RCU protected data.
> 
> This usage of srcu is functionally equivalent to replacing
> srcu_read_lock() with down_read() and the shutdown path with:

Sort of, but the rules for load/store under RCU are different than for
load/store under a normal barriered lock. All the data is unstable for
instance and minimially needs READ_ONCE.

> cdev_device_del(...);
> down_write(...):
> up_write(...);

The lock would have to enclose the store to state_in_sysfs, otherwise
as written it has the same data race problems.

Jason
