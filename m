Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF09EC433ED
	for <linux-cxl@archiver.kernel.org>; Wed, 31 Mar 2021 13:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE15F6196C
	for <linux-cxl@archiver.kernel.org>; Wed, 31 Mar 2021 13:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbhCaNK1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 31 Mar 2021 09:10:27 -0400
Received: from mail-mw2nam10on2043.outbound.protection.outlook.com ([40.107.94.43]:39809
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235666AbhCaNJ6 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 31 Mar 2021 09:09:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqsfCtPTSKaxonDsGzF7wfq+6xUxnVEy7F7Pu49Dksh4mD+qyIM22rSYET1ot0xLWpRmGNhnwI0htLLbgrO+JVL1IzWrAv9lL/HnEIIw+gbmZBMudtFK/0/qm0RaOVHKyzAJo5UWSgj5NYJrkIPydvbe+/C5qPZSpuAp1A+XXtAd0A6NhqjnCRdk+rfTed+0PcUF5I6Jc1XLq/cRT73XXIKsrB56qZF1N9jGGcsILalH0mSxDmoajebFU4YE7xsVqd/VunujWKd7zkPfIt+Ke08gV8poyZ504cXGalhQ7dCBl9stnsUlGyAFdWTxC5TVxAIR8fwobudr6pxRx810dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKDoYVOoTkhGS2PL0o7CV7kxMVXLvRc7/dDkZ5zh9Qk=;
 b=fw5hYxIBNe7IPYO8LUfqEVcky0KXB/umZMtxeFkTMNNhsOJRV3htHAG5sAdZUgXoKGleVFc9sO62w+B9KwiXF542LXWLUOvixgTNumpVsyHWShqi9OhSi/zT0jr4a4QEKWl5o0Q/wJ035PsNp89RBTNDIY0O7Ai13nFXV5oAjNMqQRRPwVk+nIFJ5s3/SP+OajErWJL8SFkgypPrnEIUUhznc6BIK7yTq+fp6qpAveYNecNCeMiSI6b2HyWGxq4qRdXc9K4aqDumZKjonB5XpcfGgT6LlYauEE391dn1AFfSKNScTnxsRGI1oNzSZnEDyS4UXvggYFtv9Hq7xyVX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKDoYVOoTkhGS2PL0o7CV7kxMVXLvRc7/dDkZ5zh9Qk=;
 b=QXR7hSDn9n/wLTrpZgvsy4VLnMaQiqIBsWIKRil5vVe7WcZemO/pLgmIpX95guA2jYKCoiJ9Bp6j3pcDW6+U6hQO4v4PxQVXHpmaHSAh87Ae9iuRziHUKetZ8lJCE3DYuyWC4fsWhnnraqyNvs7gdQML0+dkE/S1ewm29uR7x6Z7/waBAsHUjD1TpjozPhvIHLxkU77Qn+DYs+RLp1gX/Oijhu1Rjd2f+m3gnxCkftgqqKKiZXh0WFe4jODz1vJ3yEAHT5CDVld6UaVrIZszvq5kMxfHAgID7QGYkqYWQP1d5Au1RFyneJ8ZBMGsckjdOF4sdCf8SAQ3QVl2wL2vYQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BY5PR12MB3681.namprd12.prod.outlook.com (2603:10b6:a03:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.31; Wed, 31 Mar
 2021 13:09:56 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 13:09:56 +0000
Date:   Wed, 31 Mar 2021 10:09:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com
Subject: Re: [PATCH v3 3/4] cxl/mem: Do not rely on device_add() side effects
 for dev_set_name() failures
Message-ID: <20210331130953.GG1463678@nvidia.com>
References: <161714738634.2168142.10860201861152789544.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161714740233.2168142.11116065966198937093.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161714740233.2168142.11116065966198937093.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:208:23d::28) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR06CA0023.namprd06.prod.outlook.com (2603:10b6:208:23d::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Wed, 31 Mar 2021 13:09:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRabZ-006KwV-OW; Wed, 31 Mar 2021 10:09:53 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a02ee0f9-b5ee-49c6-46a7-08d8f446477d
X-MS-TrafficTypeDiagnostic: BY5PR12MB3681:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3681D7A0F6E558113822F421C27C9@BY5PR12MB3681.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LbynFBENwxwEzALuMkOXjZX627+L6Ei2/18aiqgY7maASUPfrh/cvf5KOa6EoRsZuH+2WfOEjZmcJsP5BIBkggaNMvVcbU5rH1XgouVgu9n4xIGSH0eQziExRdYsBZ1/HhAP4MVaBZ83T+br65RdX3Rv6XuKtKdazXxLjL/BMsW/qiOnAKwrftW0hYkJJPSE1ZWOP2+nzM8YnElWHhOrqkLfKP95Vtkozz2A/EBKe26L9aIRUGfhnY92A2PAV1olhqz3xHXDAF+gVrzUCRTcth81nvExuiJXhFb9vFUJa+M9Dg3EO2T/sNlsZZWBleuI/QFCZcqKPgxhgrrGw9vRl14pEJAQDB+PuaJKf8EZSGki7t9gAZkTfd41WYNb1y5Zdq8vUwg44xfJlUVJyAXrQb5kD0FHWTnVktupAdOOpw8vOERiIkZLU/ScVo9sg+BY7GuxegMYuFkVQ4I7jOCi6x3v2of2pYlynN06Xn72y4msAH+sUyFcbZLvQJ97XNdmml1lAXP1rYXO7y9HPonwRpb2xdn+byYWYP7WkzAgUoIn6DFK0g6URuNhSfJLRPRNipG62ZzJ9YThp1SzHmkigDn6S6DJHIAQ+xpJcdU+6ONujhqaHFOHewbKiZ3QIE2ZmaIF3nz9qYbFFV3++1XwoBGs6BQ9iQl1fY0Q1+hKcvE5H0XRjS5oEv86+k47lgIZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(2616005)(36756003)(8936002)(1076003)(9786002)(9746002)(86362001)(38100700001)(4326008)(186003)(426003)(26005)(83380400001)(8676002)(316002)(2906002)(66556008)(66476007)(478600001)(6916009)(66946007)(33656002)(5660300002)(56340200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9HnCxRTO0XqZwlvy5NGLGY7D69/SUHkSPYScT3XaL4GhGAwHsTif9ToWr78d?=
 =?us-ascii?Q?IIXN3zJq8XPyOYvdxQaZxrNvpbDzN+R4uOaRT/X7A60N3X6uq2tH+dOAz+pE?=
 =?us-ascii?Q?5fhYKbpErTa26I57Lu3HG2vtOQmkUYkiIZAHwD2wmR1HTFKyAd2f7JOoiiut?=
 =?us-ascii?Q?8GUKXMXuWLjb4OFL306vJRsRmb4SM7L9dIKJO0VHTk0gS7qAK1SI4Ma+tkoh?=
 =?us-ascii?Q?L4rSqp6+tIZkmQWd5KLEd26HnlF9uDIl3x16P9Fy1uWbiDiZuNuOB9M8ns0+?=
 =?us-ascii?Q?viQByH8UsHmsdDGoWOk9KNkEehtX+CzsoF6HiGLZ8ERNUhY6pxiY+7Y+Qix5?=
 =?us-ascii?Q?dpvvB0QuLhYsW6EHeTqTACWBBCRs8bvx3PsRAxC6E9PCvHe1UfMwmm0xZMNN?=
 =?us-ascii?Q?srKw2STSAghTj9KkVfbx8/mHy/4YMnaTmrJmdEh1NoLg3J1LVaOUt/II/Zc7?=
 =?us-ascii?Q?XMRMTIIb7Jht1FwfjVKQR16spfKVtoA6iCaf3Qv63S0qRMFSTEzbyRpoh3fp?=
 =?us-ascii?Q?owHVAJP2JFyX9ecMKqbYxoRUXlJRX+u/+cUybFN36O4BVB7G6maH8+EllSik?=
 =?us-ascii?Q?02v5PL/P6iJDazmA3IFj1ulBAv5J3PPv+MWKUeYBtM58QMOMNsHsm1zfni81?=
 =?us-ascii?Q?kAQhgNAo4apNH4BYBmQF6tlHywj/f374pE4gr+WlMJsigYxd50CmpCizOAoF?=
 =?us-ascii?Q?FQ7yIm4ZBRLzMDj9j2tor0/gkUVFHZUAfb92Yrz1gi+j07nojyNc6eiSBt4g?=
 =?us-ascii?Q?pm894HgR9YwISbLCLFQaG5eMLam0KGZYaW6kez9Xc1MCv+jXxbJzLYh0Wjtl?=
 =?us-ascii?Q?ufhOpiFgtl5LiHAf+ExicbpHGLfUMRNSejmcA+pFRXS9J9bvoDULgsdnCLki?=
 =?us-ascii?Q?2r3pI3P2dy7U13ExcRr0lIw0jpJeFiW2e5kAJiuGRjv8m42EFhS00ZOlQwGU?=
 =?us-ascii?Q?4ICK7U/w3UywxylLJz0fhbMH4ETBDHgV/KFVee+LlcywMzaFtIWN6b03x5PK?=
 =?us-ascii?Q?kY4eWV2YQ7klULWcXPmtm0v19I5hThi4vPOiZf4WsoG1e3zRDzXwsSZKVMkW?=
 =?us-ascii?Q?tm1xLpqIxfAnxIn5aEqAZlSB7/EXhJA4kYywETPUSMBYPYyIJLT5vEkIW7Ax?=
 =?us-ascii?Q?S0kAE6L+rJp0fgdNShGSk+InhmouS7WHoXrLiiNvtMz9McgfqJfrV6eiHymT?=
 =?us-ascii?Q?WRsF/BAEY3w2wYL36BLmCK/5FlhMYyKXp5NMBo/lIeIWVLplSKAMMYMLhrCu?=
 =?us-ascii?Q?BcLeFtrtNFJszdn86PwngLhI0fTkJA7zrhxrVelDGtNjT4Tvsn8sKjGxPXTe?=
 =?us-ascii?Q?AtjukUXa+hQrsdWt1qTM8ccdNmm7gXwUvBN+YuO2eeAP0g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02ee0f9-b5ee-49c6-46a7-08d8f446477d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 13:09:55.9904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwFVFolCnWDd8Ab2YH567pr1A2lLRYoPrelmnEmze6uSYZPEK4CKD70KqVsPS5sA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3681
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Mar 30, 2021 at 04:36:42PM -0700, Dan Williams wrote:
> +static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
> +{
> +	struct cxl_memdev *cxlmd;
> +	struct device *dev;
> +	struct cdev *cdev;
> +	int rc;
> +
> +	cxlmd = cxl_memdev_alloc(cxlm);
> +	if (IS_ERR(cxlmd))
> +		return PTR_ERR(cxlmd);
> +
> +	dev = &cxlmd->dev;
> +	rc = dev_set_name(dev, "mem%d", cxlmd->id);
> +	if (rc)
> +		goto err;
>  
> +	cdev = &cxlmd->cdev;
>  	cxl_memdev_activate(cxlmd, cxlm);
>  	rc = cdev_device_add(cdev, dev);
>  	if (rc)
> -		goto err_add;
> +		goto err;

It might read nicer to have the error unwind here just call cxl_memdev_unregister()

> -	return devm_add_action_or_reset(&pdev->dev, cxl_memdev_unregister,
> +	return devm_add_action_or_reset(dev->parent, cxl_memdev_unregister,
>  					cxlmd);

Since that is what the error unwind does at this point.

>  
> -err_add:
> +err:
>  	/*
>  	 * The cdev was briefly live, shutdown any ioctl operations that
>  	 * saw that state.
>  	 */
>  	cxl_memdev_shutdown(cxlmd);

Then this doesn't need to be a function

But it is OK as is

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
