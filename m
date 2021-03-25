Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F37C433C1
	for <linux-cxl@archiver.kernel.org>; Thu, 25 Mar 2021 17:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C5761A1A
	for <linux-cxl@archiver.kernel.org>; Thu, 25 Mar 2021 17:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCYRLp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 25 Mar 2021 13:11:45 -0400
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com ([40.107.223.70]:40697
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229734AbhCYRL3 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 25 Mar 2021 13:11:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZHo8EDX4AZXdZCrG1Jg8jKfSQY1fqWW2/UPjVsRDueq7bmSorsO/TtumWhzmTSkh6SsydJ8AuAQep87lGdZas4SiZ144gkzdB7sMokUh1yrnTbIGxlKaa7dT48WGlw/5o0UBeD60DLLEJc7RyvJJKKyslJOGWjzDAw47h54RkfJ7/egCixQsFjPGkIfssDUeKwF4ZHWvmqBxieZBY91BIWwtzTlUbnKyKBQoBrbp1MC9U7zJdWmJD9AS/AYk70q8d27O4KLdBK596gdFbzlzWZKi/WgS5jTf3o4Zu3oUG0p28nHOUEXLrW8yQBSpxbEw7rhYWxJ1n631Tg5XyBOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wECcuz/ez3qqxqdlDXxvrDjPLpQl5+3+MJV99aOVOM8=;
 b=KX+PwemN38ua6VFBxSmtuxNS9t9fl2u0lPV5EgD1jBfmsaU7NWprz+9TpiJm7u4y7EzY58PPY+cUl39lkvsCqYG9DImGd/nIcBeC7Oxaoub0tEyma4vPPEEnshiILnJdWSCbxEaawF5Lhd8+05QHUOJzwbOxTh4gevAiqH/wUMstQaU0ShTb3eOoFlFHz8YjIWc0LyHAJm1z96I8KvFZCxTAOBIDPouhv7gONGD2DFZnb8XWaK/mnD/SEjoEkAGZ4DfDnyQpCkhOkUC9gdhgy97vGD3X2jst2IdLxlxmw/PmuxEapARIU+06FFhYI7arktk5brX9EiGLy/oMVgLY/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wECcuz/ez3qqxqdlDXxvrDjPLpQl5+3+MJV99aOVOM8=;
 b=FNztyw/gypcsrB/X64idi0yKDBVVVI/GcVjjqPZ5R4OfuaVe6sOCn49G5VocZQSq6AiOUv4HmVDMdbk+1LZdwvmikUzmF/I+KlWuXIV159lWTBKG9HMB8pWREoUpy+bpbWOxpgG6rlONjCeC5DdU6H9UXsJb9/oIjIGFpazV2rIAnt3nliawlqRg1TigT3fNO8J6P6WAmFf2Za9iIJGIjENHeC1W2JwXNlh1De47OslvhiU0Me86beleXa7SSLsohkr/Ozz0wX+BCaDCyNUvfJaZS8sbiIsbI4OS5r21k0P/xY8KPoZrTWGBfgZnreQ3v28SFkWvxtb4h6u6AXrtGQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 25 Mar
 2021 17:11:28 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Thu, 25 Mar 2021
 17:11:27 +0000
Date:   Thu, 25 Mar 2021 14:11:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] cxl/mem: Fix cdev_device_add() error handling
Message-ID: <20210325171126.GD2356281@nvidia.com>
References: <161661970558.1721612.10441826898835759137.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161661971651.1721612.7457823773061754064.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161661971651.1721612.7457823773061754064.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:610:cf::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR03CA0131.namprd03.prod.outlook.com (2603:10b6:610:cf::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Thu, 25 Mar 2021 17:11:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPTW2-002k8j-5x; Thu, 25 Mar 2021 14:11:26 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 651982e4-f836-46e6-329a-08d8efb106d4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3308:
X-Microsoft-Antispam-PRVS: <DM6PR12MB33081691E09DDA9219A27607C2629@DM6PR12MB3308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MTwb34yzJpylpltM4blYvopi22rHoqMBZ18GJiKUUWBShI+q3RB01SgQiUUmoqgT/PuiHieMsnHv3/WUJ+CN7kecbYhD9XWVPrcgLTH3/umvySjc6MJALDCCl1n/zUwEx0ANtJy2Pmg14DZ03YIb4MGbb2OGL2Bc1/Jbi8ChrvwLacK6a5vW+MNtbYKLacja94bzJXhuMDn/0dvtWFFVxxnq7/TxbFzQt5IBVQuxwGA9sPZlDTBGBavrcEdaVSnDelA7AeunIpGf2MlBtikSjgMQXvuYsJ/kvTKyfuVWFwJSMeWoAjwSpOQdF4IH3iyv8kIZ8mmYAinIO4mgPvFiZoqJ3uTz/VIigr34ozwGU3qTEGDqJiE6i+Iani58l2pVRJjrFB3zrBf+e0qs8giPKnzcbbm2A+3BlPzO2HmvIPXCqzlWxb0K03LRlani1LM7162cGuAAb4LcIh+2qqnWOIXyJaN2ESQPgnMe688Wkop+Q93vf7cUkZ/F32HJqz0DF90jYhmhyPy7ltBbjxuEiBD4a0VFJz9O96J0D8iuM7X/wbBks/NLlArsOmjGDoMv84XPYBQMdD2X9eJYSRzSmGgXGc5KRhyVFsE7sOeHDmQ0jt7dQe3zM6dWyfiR0QPGuJJ3E6TeTMf6IZ9zMij22bykiw2/q1Vv5cUkf44trAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(2906002)(66476007)(66946007)(66556008)(33656002)(86362001)(83380400001)(316002)(38100700001)(36756003)(26005)(9746002)(8936002)(1076003)(6916009)(478600001)(9786002)(5660300002)(4326008)(2616005)(186003)(8676002)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?I07MT0ctyYTUeOghVKa2Y9/lLfOQOzp7+rd6LUeXRyjuinKomXbFC2IDRBsi?=
 =?us-ascii?Q?CkEyFR5xxB8+UT7fXW1pT9hq5dTJHQ9sv+esbFzS599yyCbu01W9MidNGi7+?=
 =?us-ascii?Q?EfOHwEl2Op+vrZNP2dHkam4dQo/3FVgVU70Wzbip7p4/IySjhJNc0NoIZXBa?=
 =?us-ascii?Q?PUWjCX9RCZYFNlxTUD2bsFAEVcxts8S4VI3oMTHTOgyeyOejlNKvstIHZgTp?=
 =?us-ascii?Q?sBN8TNdsm96leeLehYXIgk+7pFrzGaLPBRHqQkJ5rna5HplYh9RzABgL2lN4?=
 =?us-ascii?Q?pj+fsU3G4wnPiwBXvutTR7GedhB/UUO62V5RIQazU5ZdLfJ/F6M46JXK+PwZ?=
 =?us-ascii?Q?6rdcHiZC9QQ4u97GgS7ZAC2D6jY4ZXoVt+4Z4rYnVvu8Gq5LVz3LziBZT0Cl?=
 =?us-ascii?Q?Btz2khmwNzCNFQ4nrt/uFjcwcMk3ol+ty/0PwA+CMClqelHBiGSqH8CXS/7r?=
 =?us-ascii?Q?zh+MKhJbdZ/p6FWhmZKo3ZPp2h8y35D1tGJxSac88hjEAxq7gZrgqDvZH72T?=
 =?us-ascii?Q?AfdFQKNln+R382f0onTTYXscc7v2IWn+lIH4Tn4x6wg0ZF5dt40bSgZCtddl?=
 =?us-ascii?Q?M7BDi+IXsB14Am5r/GE+rJlmZJUtiKkucx81T6A4XW71clUwNyt5QuF1RwX+?=
 =?us-ascii?Q?UCzZCwRq84apvtQW6dcCYXfgqejo03N3XxRFCOWKEGaOpMYEbjp/NGCdYnYt?=
 =?us-ascii?Q?MD0NmThFfaeZCEm4MlsDOhgwJUB2OC0SfCdjgpnJs4LqKVC5DwbLDAoSXdpR?=
 =?us-ascii?Q?+ZWuCoImuye8rVGLqaHNkOXLjVeM5ERI+6ZpmadFVEtRHP4D1hHiSv16vosg?=
 =?us-ascii?Q?pW++uDX5BXvZQux5cAzvNJaMHQD+FI217A7+NpfxtT1mC8yraYc3jlrnRv5T?=
 =?us-ascii?Q?Jl3V0WzeZwX0/A2mwYr2d4jIWLfD+Iqm6SZCZeEVR7D7yuRm0QN1MYnDNNmG?=
 =?us-ascii?Q?yOwJbQxF/8KNGygKQcoZdIf9++3bJgiM3tDgdMj2n8of3MWhACPtKvDltfQ2?=
 =?us-ascii?Q?x9JwZhOLms4YNzr/fygzsTm0Nc4XWuxw+xhHMtLGlu7cIquTvvYkJedGDiA6?=
 =?us-ascii?Q?DpIrtBhVMTE0yigBwQRvlV2WwhZ1zQV198mOgWESzrxlouc+bYntmPCHtdHx?=
 =?us-ascii?Q?MvtiWK7I8P6lTKglzvTm2J7vVlDnssHGdvMLil1r4+UntJU40dYSFdV93TXS?=
 =?us-ascii?Q?JkxGQ9LleRAeSLlgVZXIqTjsK8QlUsFnT4HXxcCxL6reSFJUT/KAKK7GzwUk?=
 =?us-ascii?Q?GnU+L5XcyPuyC977m3yr8mbWdH1Mrl4S0cl/li9/EmWmUu/nA9ot54rME961?=
 =?us-ascii?Q?rqMw09Hb49vRfTwF2YFLbM8h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651982e4-f836-46e6-329a-08d8efb106d4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 17:11:27.8293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5JffYDR0QACWiIGcSVAN6E6CDU2zxB4ilH7CUQa0SpmTxiIfUb2fGpDPiyKbMNf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3308
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 24, 2021 at 02:01:56PM -0700, Dan Williams wrote:
> If cdev_device_add() fails then the allocation performed by
> dev_set_name() is leaked. Use put_device(), not open coded release, for
> device_add() failures.
> 
> The comment is obsolete because direct err_id failures need not worry
> about the device being live.
> 
> The release method expects the percpu_ref is already dead, so
> percpu_ref_kill() is needed before put_device(). However, given that the
> cdev was partially live wait_for_completion() also belongs in the
> release method.
> 
> Fixes: b39cb1052a5c ("cxl/mem: Register CXL memX devices")
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>  drivers/cxl/mem.c |   16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 30bf4f0f3c17..e53d573ae4ab 100644
> +++ b/drivers/cxl/mem.c
> @@ -1049,6 +1049,7 @@ static void cxl_memdev_release(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  
> +	wait_for_completion(&cxlmd->ops_dead);

This only works because the fops stuff is not right, a kref shouldn't
have a completion like this.

Also, don't use devm for unregister. That just makes it extra-hard to
write the driver remove function correctly.

> @@ -1157,7 +1158,6 @@ static void cxlmdev_unregister(void *_cxlmd)
>  
>  	percpu_ref_kill(&cxlmd->ops_active);
>  	cdev_device_del(&cxlmd->cdev, dev);
> -	wait_for_completion(&cxlmd->ops_dead);
>  	cxlmd->cxlm = NULL;
>  	put_device(dev);
>  }
> @@ -1210,20 +1210,16 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
>  	cdev_init(cdev, &cxl_memdev_fops);
>  
>  	rc = cdev_device_add(cdev, dev);
> -	if (rc)
> -		goto err_add;
> +	if (rc) {
> +		percpu_ref_kill(&cxlmd->ops_active);
> +		put_device(dev);

This must be one high performance ioctl to warrant the percpu ref.. If
it is not high performance use a rwsem, otherwise I'd suggest srcu as
a faster/simpler alternative.

This is a use-after-free:

static long cxl_memdev_ioctl(struct file *file, unsigned int cmd,
			     unsigned long arg)
{
	struct cxl_memdev *cxlmd;
	struct inode *inode;
	int rc = -ENOTTY;

	inode = file_inode(file);
	cxlmd = container_of(inode->i_cdev, typeof(*cxlmd), cdev);
       ^^^^^ can be freed memory

ioctl needs to store the cxlmd in file->private_data and
open()/release() need to do get/put device on it so the memory stays
around. This is why open gets the inode as an argument and ioctl/etc
does not.

The ordering cxlmdev_unregister should mirror the ordering in create
so cdev_device_del should be first

Jason
