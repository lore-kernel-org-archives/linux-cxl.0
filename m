Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFFFC433B4
	for <linux-cxl@archiver.kernel.org>; Wed, 31 Mar 2021 13:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B33361989
	for <linux-cxl@archiver.kernel.org>; Wed, 31 Mar 2021 13:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbhCaNHo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 31 Mar 2021 09:07:44 -0400
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com ([40.107.93.84]:42352
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235686AbhCaNHZ (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 31 Mar 2021 09:07:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rk2+FPJlpBoEdJfvRv0euMxIdXo/u2S+o1h5BK+4KjuJk+tnaRvw4LH/0H7YJKrJjOR9tdNK9wuArh+eNY4bNeleGbEMkRB4V0+Gt97CH80cVGJhj4oPBnYaSjmVJPUguCqYn7GyLMiHlbYp9iG4EfOommTMn0qluB6V66qItTt0xqkuCaM2cDBz0IoRx4DWrb9ndQe8WBf5UpOn6xUoR4RxqkfagtXpXJvAsT0nC6G2eEP81whTOTPa4OHYPQWkEEmWZXlGB/0Hja0HRj6kpbq+lYcB0hvtT5ORwbWHERPKP/Hty6ysWAPmCDjUnh+gNjU74hzBJADha7Exty0y+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7WsDly/Q5HK74Rrtd6EImaXbYNuwpm66+pAbT0/ox8=;
 b=FGRHyP6GotX1mnDxsPaxQ8CF1jSPKxD+gQQHCAgT53SPKL1reIPg7bDOreNT5A0LVUemS4tEe79LprFE75k+FCmx4La9ytbrVY2aMsYJEGCwxA94z38cAvErK0uXOivPxoABwegZnt9aSCj49EBNx0B2cMyeqER/8zhsgRIH06IYdNPDbG34P52H8G6vCvaAn3/6zBrwtgEpKi3lqnCaxoi4ChI5i1nhdzXr6jOlvTTzfSfpWAgmlnSLtPLj0PBOLjemDsYpNnzO0+BCUGPwvJNdK2EE8uINKHc46T0TjfdSdHYuaJEQ5UwDL9Wrcc5n1P5S9Q66p3C5D1aopLytJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7WsDly/Q5HK74Rrtd6EImaXbYNuwpm66+pAbT0/ox8=;
 b=jynI6jlQ+1SSVcKaS/w+6rRMoKimk3hd9WUZ14/9zfBI+53NqR/7tN0+WLkGprv3U0Y1ppK99vaJ5k6fk7jeUhMO6kCayjMfIYqFX2WIJu8L0BkjfNMzGrCCfAxcIhL5T74vp/fzug91XKMPsdY9w7AJ1pbDYusRYtXVSdRO506SYeV1UXT0OFUTVb8FQBm3n9Fau6Bpk+WsBH5lcZM5HNdE5VOok0hDgp2zVSVJGxMfpcRHkCI1Ce29TkrDA7bM0xzYzMRwqLiVmgLGl8l9pEfTixJOmCZ9KsxQzm/zkk9zf9P2EwvfV43eRZfyAo5panHz3HyJ3ysKBJK5nNOPHw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB3351.namprd12.prod.outlook.com (2603:10b6:a03:de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 31 Mar
 2021 13:07:23 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 13:07:23 +0000
Date:   Wed, 31 Mar 2021 10:07:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com
Subject: Re: [PATCH v3 2/4] cxl/mem: Fix synchronization mechanism for device
 removal vs ioctl operations
Message-ID: <20210331130720.GF1463678@nvidia.com>
References: <161714738634.2168142.10860201861152789544.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161714739718.2168142.17960000558666300914.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161714739718.2168142.17960000558666300914.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR14CA0030.namprd14.prod.outlook.com
 (2603:10b6:208:23e::35) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR14CA0030.namprd14.prod.outlook.com (2603:10b6:208:23e::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30 via Frontend Transport; Wed, 31 Mar 2021 13:07:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRaZ6-006KrP-VO; Wed, 31 Mar 2021 10:07:20 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06166ddb-c46a-45f2-b48f-08d8f445ec2c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3351:
X-Microsoft-Antispam-PRVS: <BYAPR12MB33519E09D0EC9B8A2BF22F0FC27C9@BYAPR12MB3351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xg1HpsFqG4Qy3SESZdrVN+Eytmm07MIImnTIguTVSbmHLo1VlUEJk1Fg882KpVnxE7liTHvKb2AAoUNyb8wdWao/dJogtd5I++mEgoGgGGuqm3Jygo2sRuWGcNRrwm6qB8B4C8bm44ppuW1A+F7Iupi8x+9xqLypFJ2wnXAjJvT/aEAMRUJlo8WYHW/3aKDYA1fCbAft3JqMhfbW6fpamVBvK2vCfBC19M4GZkVbvv0akaY7ac34ctbiB7toQAvBBAJeJB+eDHc/A3Oy8IZkCqgH3N87iOadCBiL3cHY3MxJN3zfarKA6Qh4XJhjegaxgJTRzr1JNi22znp8SnKQmETy/6JDcYkvnKBzBauYFg5ZYoIKyDfcFG5mL85TKeBpohbBNtJPIIvdyEASEN//X83dyC/Dewys6VyHsjis/rGKUJmIndb9Pkm1gi1XjcS23Z2xovPIV+u1qa20YZa4WOUY4i/o2X/KOx1bX1nDuFvzZGWlWV/WIsZ8tjGT/oKhWv1emKd/Bu7OdT/VMd96+r2SZQey9DZKKZH3qhAOFonsgZg/0nUkQplkyjmMSLVsmIRmUyL0eM0yYZgOQKh8/msqGAWZ5+lEYzP+myxLprGXb8fcF5fNQDP8gco6qy4Sg1uiATBQfhoGDTHCcfSueiAC5VCN1A7PxVhwEyYZZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(8936002)(478600001)(66556008)(66476007)(5660300002)(4326008)(86362001)(26005)(9746002)(9786002)(83380400001)(33656002)(36756003)(316002)(8676002)(38100700001)(2906002)(426003)(1076003)(186003)(4744005)(66946007)(2616005)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2nBfMz/LFA49ewk7u9HHldd0q+IxdX5MFCrFLKNGxKemdb1/J2enyNKVeDnR?=
 =?us-ascii?Q?J5wUKz73JxmPeNrkItCgaF8+UbIVCzvb/r03gmwptYP9cAZrwEj3fplEaDvi?=
 =?us-ascii?Q?NMT5fURUVbg9axcDeG37ahtMZmEqybdaWx87tWFzevCbW8VjCaTV+0hewEU4?=
 =?us-ascii?Q?5awOBDxNTQ4oF7B9+bWRih/1I8GZ2c6eCxXdcPeQwoC7jxlOw/Xn6Mzd5+Ap?=
 =?us-ascii?Q?hSCTyjt+7nuYhFvwm7VLvsHDyoqE1nj5DWhqHLpPIKgyo9dfap5t766ptDar?=
 =?us-ascii?Q?pStrRkqWBn3JhIhIXz+XmOj1uslb/qi5Y2yXqwxuuVeihpxijF2S+zpw9yId?=
 =?us-ascii?Q?WQiCTqovMzNYTdKlkVlE1nZQbebwQBgBOY/T+MY0Bt+Dzx8k11cmrXkJ5K4y?=
 =?us-ascii?Q?fUHF7YIpuOsDdxfztR5ayVzlukFd6FNTxJgcw+GMkgNuuyL2d4jK8ZL3J1fF?=
 =?us-ascii?Q?st49IopRbInNF8ZSBk8sF7T06tUkO7JcSxBBURxmCfCC18zH2CXZv9MDBD/h?=
 =?us-ascii?Q?SE5ynRpBDD4m5ZZUMHiDUMd5X4Z2Z9jitwaC1uFBYZJG08QfeqlqnHiVpzuD?=
 =?us-ascii?Q?5FDukI5+uav8ytjaqRWAPWt8CacQNRkm04XREkk+Pt4nB/S4WfLXOqy65vIN?=
 =?us-ascii?Q?i9E/HTQLbSZ3Zu8RBgnP02oe2Z+d10br1aVbdqL/ircJ0LJ3c3/sxPPlXTZu?=
 =?us-ascii?Q?jIqA+58ABFQsHYjZcZKeqkTG42V2NW1vmf/2+X+7rM1a8G8c8O5G7YxXHQsE?=
 =?us-ascii?Q?ykzGDAKqQsaxSIIlLs1a+AFWu6pmQAgtIdL/exdujdO9XJS3GWnMDxcNsL2T?=
 =?us-ascii?Q?TXqHuMzCCZB23FAYhDTFxvXgyh2Q/lZYSbSmNCbfbq+pCtLaJu4MH1alW7h/?=
 =?us-ascii?Q?GffMmO1/MYKyLXVETK6JScFV9oq2w1/RB6wNM8auQQbxGQbFUYnZqYDF+l9c?=
 =?us-ascii?Q?wi6y/Fxkt0FPudRUQB0gqxjGAAGzMihn3ADdIXUVQ1TfYrJMg8C7/alhIOXt?=
 =?us-ascii?Q?OZbCvTF1J+3QqAcr8bShK6UkPpLfsCujRXitOahYi0R9IqDSDAk+XxJCyNOi?=
 =?us-ascii?Q?6zTgIszK40me2CW80I/HEeBejp+tajXLrbF8Uzt3bG2c+N01z2aKTlPZ6HJ3?=
 =?us-ascii?Q?tlDow043unDHONR+B6Q30z2E6PuLhp2CELsB0cIgaotMgE0+mGf75eohUbk5?=
 =?us-ascii?Q?yV+aUwsTH/53db9A/u9OcOAf1lRl9IqskSER4ILFF/tOG+RjrWxoYXs9suKi?=
 =?us-ascii?Q?7f1xAoj3neSlTk526RpWqcI77FGMRAqry8iBHdT8XX/CJum8yLtNATaImB17?=
 =?us-ascii?Q?qH8zcckif/mEpCYvhhG8pVMr4Szq7tIdT1gz1E098JZYQg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06166ddb-c46a-45f2-b48f-08d8f445ec2c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 13:07:23.0015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFngqq6dhvWzymOGUqDCzBgCq73TcWTD98j88pkfTC2WSHYjhq7JPKTGwghbHIb6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3351
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Mar 30, 2021 at 04:36:37PM -0700, Dan Williams wrote:
> -static void cxlmdev_unregister(void *_cxlmd)
> +static void cxl_memdev_activate(struct cxl_memdev *cxlmd, struct cxl_mem *cxlm)
>  {
> -	struct cxl_memdev *cxlmd = _cxlmd;
> -	struct device *dev = &cxlmd->dev;
> +	cxlmd->cxlm = cxlm;
> +	down_write(&cxl_memdev_rwsem);
> +	up_write(&cxl_memdev_rwsem);
> +}

No reason not to put the assignment inside the lock. Though using the
lock at all is overkill as the pointer hasn't left the local stack
frame at this point.

>  err_add:
> -	ida_free(&cxl_memdev_ida, cxlmd->id);
> -err_id:
>  	/*
> -	 * Theoretically userspace could have already entered the fops,
> -	 * so flush ops_active.
> +	 * The cdev was briefly live, shutdown any ioctl operations that
> +	 * saw that state.
>  	 */

Wow it is really subtle that cdev_device_add has this tiny hole where
it can fail but have already allowed open() :<

Other than the lock it looks OK

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
