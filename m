Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B94C433C1
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 11:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E14B61994
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 11:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhC3LQd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Mar 2021 07:16:33 -0400
Received: from mail-mw2nam10on2079.outbound.protection.outlook.com ([40.107.94.79]:60452
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231743AbhC3LQZ (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 30 Mar 2021 07:16:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoRKg8tEG+ibXutHkDs91mkXafJxl8bUAK035sI/couBROpu9oaNC6ShKolgu2CV9WY/KZO7yqDplsuxTPjqGWMDXd1dzLVTYOTRQRvGeGwac8q2vy3bJ1IRxDsRuc1pcUJPw/CzrouuUvIy//ICsgNAa+C6wSuSpoOruRKCFT/c6akjQe0Z5gCNfPrMJxPnaozknEDBfsKDt71sEZ01RqS22DmggIpdPrkpNGRlTIMUMA/vbY7o66xGsff7Acse4pwVBBEsl4vlUDTPU3McU8QJPwAlUFD/MW9tR9seDuxJHwzjqto+njHjMF8R3uVbKv4mro8cFSdSotwHI906nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/z+3j6wk1UmW1hx6djB3ti4vxhmN/1XmOUNfzLzdN0s=;
 b=FaiXDbiA1oNbrBC2SUPMOf7Z154b4ENpyun37paLWthPFuArrSCpoad2RFRVnTMa9H0NnKxMbWcQVBfk+ha0MFxA49EvRZNHNQswNVWBhOT0JJ5gsT4Sj737cj63qe3/zG2DfoBl12aQTre7pf4iBNPQsHoVKpdpUl+i9Y/HVcEjZ9V627VIum6MvARi7YLbAa4f0Z5X/TySoAdiMir+RlvZnFlMv+ZpGccdaGLKak516kwHQvlTucWC06JpIYJRR2BZR99fsjCBlkd6xdVI7amP9oWVj8nlWGSbd63OqK8zd3d9gNX/T+9JzGCnD+MiRR4FsZiEQxSYaPcWy0fCAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/z+3j6wk1UmW1hx6djB3ti4vxhmN/1XmOUNfzLzdN0s=;
 b=mVGZqBS6WEAoBEpKb5qK1OE76Zz1SriLInJz7axWpB/IQJioPMKBegxYr5nR8FO+8GYqKGSabFh3xTMR8DDg0n+vT9V0jMpRjyZkwyQwbpnyuuEXDyFOAgPkk9Zv+nesYN22heF/JDrBFHBAGhTlWzJX5T1sZIzm4aH+/9X7MnutglE4NBF6pBnZqu2YBse46GET1jDSyUdHRN3HsF12wJ9TL64qo8p5wn4NNS+JOMNqkDTyGkAj5ISm/phGHUo34QZHvHphyuGlje8QhlSjeWYBJbUTaaR3XVZKQlWVey5iuiMGy64tB8306auRVjgBoJlKFdJyX9dc5LmC9Wndcw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0108.namprd12.prod.outlook.com (2603:10b6:4:58::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 11:16:22 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 11:16:22 +0000
Date:   Tue, 30 Mar 2021 08:16:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com
Subject: Re: [PATCH v2 2/4] cxl/mem: Fix synchronization mechanism for device
 removal vs ioctl operations
Message-ID: <20210330111620.GK2356281@nvidia.com>
References: <161707245893.2072157.6743322596719518693.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161707246948.2072157.2116502455691653472.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161707246948.2072157.2116502455691653472.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::8) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.31 via Frontend Transport; Tue, 30 Mar 2021 11:16:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRCM8-005qN4-Mq; Tue, 30 Mar 2021 08:16:20 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ee534fb-0363-40c1-ae65-08d8f36d400d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0108:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0108B5FDE9D6D8C1B026B3AAC27D9@DM5PR1201MB0108.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UF++gLaPLae1F1QFPqLp871oyk2KBNDEN/yMYFx5xtBX4DPJSJ7aYG4xUoFrd1T9CaOFbjtLNhT3NGTCTN+YKsg/kxTGbV5+pQ73p09k5XNy+xw4ZKU69Tnqj1oAEKx08YxuzDRvzM234WNB7BOKzqBUUPFz430vrPz3+aF9WqU7edU37xPmDtxePy1jRg2gjr9icJZ9OI26SZEpAQO/xfQVakmqQea6ZsnobdnN2k0oeIMfMM4t7NJQH9dkNXt+4K1wKoxdpGWl7onjcuufmLh4RVtMku5R1DuyiykFisKkhiWo3lRibW2bQxsKa83k3XyZydU3xUf9Y/jo3Ar1Mngfg0SCQYcvIKcXwJma3/9RG3znnoZNIgWOPMGziMgsV7y3q/BOty877jVkZNJ4iv9WwA+VGq+HYssGLN9gRauMTtVR0I5prZ+E+dPuWs7Dv7SIARw0WdFYtvw/+zgoBCKXQ2QDYh0W5m6xLMuAkBt2Xqj63vdhLLP2E4xYzNtjIn0LD3OJrT2sYfnGNLJSgKy5mOJyWW7qjKy1TrfRuKEl4/ed/B5aR7Qn9CKj1QpYWXMUdWko7p9WlqbI8CILEmLOQgz+9ZM7nxSbUsnIIUUimUqThwzXBgMY4OIDbnhRnxWCuIzV0MKCbt037pGG6hFrZoR5981TW5XUaCg2si4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(26005)(186003)(9786002)(5660300002)(38100700001)(86362001)(9746002)(478600001)(1076003)(4744005)(2906002)(8676002)(316002)(426003)(6916009)(4326008)(83380400001)(8936002)(66556008)(66946007)(2616005)(66476007)(36756003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0IGeUMDXTyzmMB4T7yds9uEmjp415+ooHAcnKD2CvQLkqOl8ybpljDyb+tEZ?=
 =?us-ascii?Q?rBkC6ISBjj/jwzErRUVtOiCHS5CRjx5BopsPzCTqOJXKHJL9v7hqR27Egylx?=
 =?us-ascii?Q?eW1L5LtCBbhVMAfboMR15oyNfKQP1fDn95bp+McdwvjJ6NK/z4scyqajFRPI?=
 =?us-ascii?Q?nS+ZF4Nazld85rt9/9tv4vGJKLh0HQHGS6HAyTNYLTL1UBfCM8di6aDpj9Vt?=
 =?us-ascii?Q?QnuV6RGCpnIcISCQf4TcTUsvt247r0SayuLAG8hPLuxcJFopXULyOVo1MSB1?=
 =?us-ascii?Q?l6Ow13lbrz6EhZ3GCsEF72MSAkfbdcLAMowJol2qNoujafUyCVifMB+cLq2O?=
 =?us-ascii?Q?367MDkpFtmZKDnOB1vWORw652ezll3Fvc+lkL74aN4suGf9+vHzL0MQwanmF?=
 =?us-ascii?Q?z+lEvnHVhZcrS/8UGjR7TKmErhM8GFPiX0/HTgEKy1BuC0p8xacQtllqxZE9?=
 =?us-ascii?Q?iP2dB7oBZsa4eEIVawctxR3riCw1l+3jLGeN9JYhazHx6LDwWF6QBPniaR3O?=
 =?us-ascii?Q?QQ+hv7vop0u9LMrFh63vdZGLlP6ejwOT5ely7u74npEVWHYRayy69wO/pc4z?=
 =?us-ascii?Q?G1TUoMPDR3wR4OQOJrgyO+bj/6RzrP5cb4LbxyepZ+GCEGpmVk9Q7f7cywU7?=
 =?us-ascii?Q?Zk1nUgWPBhGGJdG7ofC+mnSxPIb2ltv4BykKfUjexTtN/0idmNRlYuJBxDn/?=
 =?us-ascii?Q?WvXL6M6v8BUwlTYQ8yji0pJga2zENrNThrPeZ/Kz5TsIdcZp1jI8iSHgIy5S?=
 =?us-ascii?Q?vo//p9rOD62TIy7h2FNlW8zFXFiJkuH/1KBNXODOE5j6o9zVdYhx1ro6pI1b?=
 =?us-ascii?Q?g2DK8lfwyCbJ/tIDOpVJXtZJcKJnvuUdGBjrl3s9BPgCHJOosSjon1WNmw3C?=
 =?us-ascii?Q?cIKfw94c/T0cZfptsZLZYV1oaN7VhWjRWRvPUT3mrUgZKfs2eyvt6xopgli4?=
 =?us-ascii?Q?T8Hr7Hx8Cr/C/sWg5/zj7ycuB34dtabqBirObzkTP2dPTpBMFdjfV0c08c82?=
 =?us-ascii?Q?tn9Hnn6m5sLnq3+urNYI+mQTCj86yLtG4GqAgjEGTGKYS5aqeBuMff0KoWQp?=
 =?us-ascii?Q?pd+TnA2s/gzGeW2Pofuo5xivmHlqZs2jZ9+eHM3rNAVplLcpz08FbFl+iuiY?=
 =?us-ascii?Q?bGPJUYNmKJlg5vtTlV98Zdh7pc7cXcjC/ClbNqJ23eyC3P9yzl5uLqCVzSUF?=
 =?us-ascii?Q?mC+qGfVJkrr+40Jili+sry3Px/HqTuIhdzfKn8Ckeeo1UJa+VFP6jSuC3dHr?=
 =?us-ascii?Q?jtPlouSX9L5hzn6qSdHwbBIJKcMtptoofkl6436tL5laXtTvcGhNCjctNxAI?=
 =?us-ascii?Q?dan7h9EQ5amrkePkNxnGt59d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee534fb-0363-40c1-ae65-08d8f36d400d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 11:16:22.6897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OoOUVa0DZ+Onhxd8i/AEpD1+ngow7NN38oCBRglz4lIUzuIdiMJxbEODNx+Vasw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0108
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Mar 29, 2021 at 07:47:49PM -0700, Dan Williams wrote:

> @@ -1155,21 +1175,12 @@ static void cxlmdev_unregister(void *_cxlmd)
>  	struct cxl_memdev *cxlmd = _cxlmd;
>  	struct device *dev = &cxlmd->dev;
>  
> -	percpu_ref_kill(&cxlmd->ops_active);
>  	cdev_device_del(&cxlmd->cdev, dev);
> -	wait_for_completion(&cxlmd->ops_dead);
> +	synchronize_srcu(&cxl_memdev_srcu);

This needs some kind of rcu protected pointer for SRCU to to
work.. The write side has to null the pointer and the read side has to
copy the pointer to the stack and check for NULL. 

Otherwise the read side can't detect when the write side is shutting
down.

Basically you must use rcu_derference(), rcu_assign_pointer(), etc
when working with RCU.

Something like 'ops' is usually a reasonable choice

This really can't just be a simple rwsem?

Jason
