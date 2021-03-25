Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26CFC433E0
	for <linux-cxl@archiver.kernel.org>; Thu, 25 Mar 2021 17:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB5EA61A0E
	for <linux-cxl@archiver.kernel.org>; Thu, 25 Mar 2021 17:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCYRO4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 25 Mar 2021 13:14:56 -0400
Received: from mail-dm6nam10on2069.outbound.protection.outlook.com ([40.107.93.69]:7168
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229949AbhCYROx (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 25 Mar 2021 13:14:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abABgAy3H27meAE+tcFBSWPAS+UlGsX/PF7xeMlhufgKRsjrCW383jgdfc9rnA+XC5KB/MURD8lJHbobsvnP2qSKlf6iPmOgGYCrOEiXmVz51yCLiUmA/DCbBHsgUMrnd2K25JMrwYRbUR83DA+AUxT+ToUZ3fwNNijGpRNbnNGEfgBbERwP1KfFXmlpATGquXwn+psE6opEuQj7mtKYrcr87wrk5CFU09EPvtJuO2MVV+esbZVmCtrx+/G7pdV1Y3E5/uev9qp474Abld2rtLAVkLrVWBlHovhXwMJv8e5h9fg6iM83hAt+MTn0wQiKrTEC8+iCilXWHjqf9iNiXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czgjo+42uv91p306BrrHvyclFN0Wmeys32RwbyX8Ljc=;
 b=c3rPH/QX2QbGsjHv3YT6/bZ/BFW37L5nVPmfKeJauQhlaZaNDWMXvE2EUd6lL3V5fGyGqQntGWDunn6fke/FfE6rr4Od2uaXq8vsWK3fegxUnedsYwcdxS5j7IpiuhTuLeec53i9nf5IBwdydSYF2UK7UJ1zvYlBoB+rsnCOcaOLX0q049wOBsP8gxmcv7aalxRVGIvI72nU7TsP/cZ42otwA6AYF9gVwFjnsM+Qlx9Ymme223/Pgrt49CPb51Nuut27mvpzKTrWfBh0ssROS+7cMPo3SFWmF9ZB7ljNSMKoFLxEjykXd4BgT5cRpnWi8Ax0RSibH3CLnW8OX32yPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czgjo+42uv91p306BrrHvyclFN0Wmeys32RwbyX8Ljc=;
 b=c4CXcDbbXBeTrA7gt3TWOKIBPXgAb0m7NdgQEb6lmoDsZI1sAD7r9H0obJnQ+aEDB/TS02VyBTsmJqMhiffK5Mhv0eCOSSsF0R44D+eSPYJS7IG0520GtT1tysxfKG/TfaWeax7n59KTn87jhmu9HwmDnSW9VO0560HOeKipTkrJV0PXCBcMQaD78BcraxWpQtL3U5J9i5f2VwY1aATqIps6QrDjm/4k/A3N9czM3V0R9CMfvtXo5HqqyJ7odPzh4qwOtwowL7dCBIcRyFGuBPuy8ojChtgtrLLQRRxptvBGhnR4PGrzogwJFkNoyn17asqyBsKO4fQ4u2xHMGKKgw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2489.namprd12.prod.outlook.com (2603:10b6:3:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 25 Mar
 2021 17:14:47 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Thu, 25 Mar 2021
 17:14:47 +0000
Date:   Thu, 25 Mar 2021 14:14:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] cxl/mem: Do not rely on device_add() side effects
 for dev_set_name() failures
Message-ID: <20210325171445.GE2356281@nvidia.com>
References: <161661970558.1721612.10441826898835759137.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161661972173.1721612.9458160848430375459.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161661972173.1721612.9458160848430375459.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:610:5a::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR08CA0023.namprd08.prod.outlook.com (2603:10b6:610:5a::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Thu, 25 Mar 2021 17:14:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPTZF-002kCw-G6; Thu, 25 Mar 2021 14:14:45 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a88c05c3-e77a-4b96-cad5-08d8efb17d82
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2489:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB248943E414136773E5473A02C2629@DM5PR1201MB2489.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zIKqBHaMot0LqYEiP7zZgOM9aTn1cvWel/1tKpUIPBI1t/50Hb7TKsfKuut8rvGB5RZNCMJA+5u/9yf6sf6Yz3PLhFfNEwgnkNUWhmnCyrHNsVUoR0I8M5T6KOwZMxLEUC492pkuws/73Og0vV1NnJWCO4TxfBUGCAeTyqKZOJzaSXvlpU+2f51K8HuFE38yLvWVvB3yxoPlAagRN4TNERdKKD4DmO5mSZlwSF3k2EhnLS9K20Z+rROgysXDJczQ1kWl+ECtePC7tirrY3m2Deluadze+EvOsz8uUVcxdUwczG+RTRtKbicAC6nI7gZQR3fe6YMm5QCskpykaKkQBUSnyTwoE6AfFE9FkniehRrcHFQV8RHVghBBvz/NgCzz3rDa+qolzt805qWVsyBCZXP850SzdeDvPM3y2nESNySPVsZgPNy+qAafH+BJ8SwqQOJzOEhS80NB13jy78Nl8T4w7F7gFiSXvh0l8QpeyBXvqRqaKBC/iF5qAE/no4Bo3JSKF2tfec62QPvWK6EJ4IWu2pYsWRBGi1gxXbaTBynx48PBPpuaYPD9nNYj8UBOEfalHxAxGP4Sg/qlQKwoZItcrYQd9GUGhXNPoQmyMIAdAyDTcUxHY51+Gmr56AEXVZ8fIv3QYnwAAWmFRxquq+rS4evOE+KUZzLDZjHFK7N5bEezLDhklmN1gRS4zI/I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(5660300002)(426003)(6916009)(478600001)(8936002)(38100700001)(4326008)(36756003)(8676002)(83380400001)(2616005)(1076003)(9786002)(66556008)(2906002)(9746002)(26005)(186003)(66946007)(33656002)(316002)(66476007)(86362001)(56340200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VTLphteE+iJ0iCTw2j3+htf+tptdO4SUyewT0VVeaTvxezhK49v3nD8+NgQ6?=
 =?us-ascii?Q?tU4Xcf5JIkjRBRfRhl60+4xgYjMt3EmcQUMDyxCPTG0hnFp3yFVXQsDcoB6/?=
 =?us-ascii?Q?VAF/f/tj8jG0jmxIPoqQrF0ZcLuexjfXdGABz3RlW1r2epxyuz0YHQKW/ZJZ?=
 =?us-ascii?Q?uoRQjOhYJXpZADtVXe1khTpeLyeHb3bbDtY3gtbm+ngBqf7LppVtpS/bCb0p?=
 =?us-ascii?Q?gTmLzPLV8FQP2fZGQvtATaMhgdZDQ69mtXFOrXnhh8JB00GymOAxLAfzJjc6?=
 =?us-ascii?Q?j9cgQa7mwPgfREqhjTTC/fP9Uv+95v9QSmFB6IGIiGiRijwKaS8bPJe3mJ2y?=
 =?us-ascii?Q?VZh5jBqj7bu19Ns0Id4vONhw+5uF65kSm7dYKxbR3Fq+iR6Z9Exso3Egskpg?=
 =?us-ascii?Q?nPi2L5K+nN0HTxXUjTH+t+zWCme9YVIAAJgdCvXTdAcRzQ0WfCsKrCS32kCr?=
 =?us-ascii?Q?SWZdk5/Yo2POGWUH596cqG0F4DfhCdLZZwhJJbqXHydY43985OZlcxoLb+YS?=
 =?us-ascii?Q?FEGVkVg/SNfHoKSvYobsejVEc5GQh6rxTS2uEqccH9Af9hSL+AyHwnoqhoGf?=
 =?us-ascii?Q?VT56r+AJTqFY/2dH8V7a5YU8EigPDvvSkI3ygdb+Djo7r/QahwozOZUzv26S?=
 =?us-ascii?Q?F1yLIicZJ9ik5s5thiNmPK7PC/S/NhcFM4MVQHorV604aTF7GP7sUHvC1iT0?=
 =?us-ascii?Q?oafkGkx7lldyJsHfqGzkBD35as7EY9qyXmspFSlB2hzcGEFZJOxansuT+cOW?=
 =?us-ascii?Q?xu0Lj9V074hYPMrYnxKMYlIvvg3swbwfF+RG7fL5C+CuiZeYS97Z0MJy99xb?=
 =?us-ascii?Q?RBxNsCu74YRMrEY0nQfRRkQEq8eAmSE7apTI1M1znp5Nv57u6k7z/ZoWiHHO?=
 =?us-ascii?Q?3eUDfnSScM3g8kp4lMhSaBYjVroZ5FGcYsnRMRnEThLljs7+4w4Gp5Fl83W1?=
 =?us-ascii?Q?EstQeTVy11Adoid6A+G0Q/9SHm310y+YsI6hZWg7vThmRtGhshPaT/+r3n/q?=
 =?us-ascii?Q?xx7OHfsXKYrkW+B6sP23R0Il650WyMv0q3UhOUWwHPngN0/odDB50nNLSucA?=
 =?us-ascii?Q?IVLuHitU7s5PadtuA9zE8D0pHiU93oZj9OR0YNQkLhDwc4xd1r4xOk8S5lbJ?=
 =?us-ascii?Q?Rdp+BXc8n1gEeHKdYmXyOIEeznt5dMMjEhkrXDami7rOv+9njyCtr+O9zKQK?=
 =?us-ascii?Q?+KHMIeN9MvV4Nv93kSaS6MpteW4pKKEfIWBt8Ou6TkgeRHbarIDZL+HVnjxK?=
 =?us-ascii?Q?+0oASyrCph+0+2ML1dJLxJ7PRk6+7lZlGOiah9iuS1YFEk7+leu6nxw2rmr7?=
 =?us-ascii?Q?PZilpo8gsiQLAreNRtDFtlcF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88c05c3-e77a-4b96-cad5-08d8efb17d82
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 17:14:47.0036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNyJONqHi5gDkBfrGWRvJNcuZGvLPXYmoFNjPuvp6rsRQmbrmhvf01yMf0oFZfV9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2489
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 24, 2021 at 02:02:01PM -0700, Dan Williams wrote:
> While device_add() will happen to catch dev_set_name() failures it is a
> broken pattern to follow given that the core may try to fall back to a
> different name.
> 
> Add explicit checking for dev_set_name() failures to be cleaned up by
> put_device(). Skip cdev_device_add() and proceed directly to
> put_device() if the name set failure.
> 
> Fixes: b39cb1052a5c ("cxl/mem: Register CXL memX devices")
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>  drivers/cxl/mem.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index e53d573ae4ab..d615f183520c 100644
> +++ b/drivers/cxl/mem.c
> @@ -1204,12 +1204,14 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
>  	dev->bus = &cxl_bus_type;
>  	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
>  	dev->type = &cxl_memdev_type;
> -	dev_set_name(dev, "mem%d", cxlmd->id);
>  
>  	cdev = &cxlmd->cdev;
>  	cdev_init(cdev, &cxl_memdev_fops);
>  
> -	rc = cdev_device_add(cdev, dev);
> +	rc = dev_set_name(dev, "mem%d", cxlmd->id);
> +	if (rc == 0)
> +		rc = cdev_device_add(cdev, dev);

Success oriented flow please

This is much nicer if you split the allocation, then this flow is
clean and simple. cxl_alloc_memdev() is undone by cxl_memdev_release()

and I would reorder the code so they are above/below each other, it is
easy to check and understand when logically paired functions are on
the same screen.

static struct cxl_memdev *cxl_alloc_memdev(struct cxl_mem *cxlm)
{
	struct cxl_memdev *cxlmd;
	struct device *dev;

	cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);
	if (!cxlmd)
		return PTR_ERR(-ENOMEM);

	init_completion(&cxlmd->ops_dead);
	cxlmd->cxlm = cxlm;

	rc = ida_alloc_range(&cxl_memdev_ida, 0, CXL_MEM_MAX_DEVS, GFP_KERNEL);
	if (rc < 0)
		goto err_free;
	cxlmd->id = rc;

	/*
	 * @cxlm is deallocated when the driver unbinds so operations
	 * that are using it need to hold a live reference.
	 */
	rc = percpu_ref_init(&cxlmd->ops_active, cxlmdev_ops_active_release, 0,
			     GFP_KERNEL);
	if (rc)
		goto err_id;

	dev = &cxlmd->dev;
	dev->parent = &pdev->dev;
	dev->bus = &cxl_bus_type;
	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
	dev->type = &cxl_memdev_type;
	device_initialize(dev);
	return cxlmd;

err_id:
	ida_free(&cxl_memdev_ida, cxlmd->id);
err_free:
	kfree(cxlmd);
	return PTR_ERR(rc);
}

static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
{
	struct pci_dev *pdev = cxlm->pdev;
	struct cdev *cdev;
	int rc;

	cxlmd = cxl_alloc_memdev(cxlm);
	if (IS_ERR(cxlmd))
		return ERR_PTR(cxlmd)

	rc = dev_set_name(dev, "mem%d", cxlmd->id);
	if (rc)
		goto err;

	cdev = &cxlmd->cdev;
	cdev_init(cdev, &cxl_memdev_fops);

	// Must be last
	rc = cdev_device_add(cdev, dev);
	if (rc)
		goto err;

	return devm_add_action_or_reset(dev->parent, cxlmdev_unregister, cxlmd);
err:
	put_device(&cxlmd->dev);
	return rc;
}
