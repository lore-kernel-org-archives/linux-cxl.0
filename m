Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B5CC43461
	for <linux-cxl@archiver.kernel.org>; Wed, 31 Mar 2021 16:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A996105A
	for <linux-cxl@archiver.kernel.org>; Wed, 31 Mar 2021 16:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbhCaQSP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 31 Mar 2021 12:18:15 -0400
Received: from mail-bn7nam10on2088.outbound.protection.outlook.com ([40.107.92.88]:4065
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233817AbhCaQSE (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 31 Mar 2021 12:18:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiycDNYSLd1YVHOO1ZFPq+wtKvM9fEvX1anvbFl6GjCu7gDwO4fdmalZOIjndnjKEtzcTGtT3+6Q5wQmTxo9jK8pFxxei8n8KQbHbN+Op6qOGExaxRJ8BrrxE4WHZSM5xrhdkOFGGPIog8mpmZG5nRD0GGJ7tEQyKWmsfHa8WSW1qGZlEC3FkPdw3kFNZn1kjz+Dusd7UYQTwpJt1cvSviWk5cr8tU4QSHVGP1nSlTbT9qWC4mnpXGoFb4HOa0JFQbmTeAMkwL+NnHscCZIAUtRYHzg3wZEq9L7SQV1oW/UnYQqeHe6b+cU3ZkCiYUw17Q41azrPXLbimzFtQAYEpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymiA9dYule/d7L8Xwg71qDhDZP0+q+BW9896mIFY8lU=;
 b=EojNZCWrjX68mbs7zihnPwHjoz1aMsH6ERrxiejxemhM0941j9D7IxmRidh9GszaEwLZce9EQDC0OPNuuLx1XRzXA6R/wjXcWZhslJ2OyUO/jvXetB9rOljvxnZzrJUJkfB+5Nn7uN7AW/aILL4pOUA8kuqbcflJYl3M5XGAOEQqT1O+d9bCMcmFuM/pvg13YZfdwKOBzWtYwQcseJIlJeUpg6H1RgjBPs9TS3ePaZUZvn80vyo7Lr1y3ZOlHBQWhwwAnyRTq1WAkHr8L2/kLEBOFWGoT+ST7nCNgenvh6emNulEL1/7Y6kDp+Yc520mvDSN0f2VY2Iab9gcp2fBMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymiA9dYule/d7L8Xwg71qDhDZP0+q+BW9896mIFY8lU=;
 b=k0QTLWaRNRzLmqMay20qYIhCffidNvldXqADzzkVmzBqCEz/L/N4V7KzavCKqz9jeX5wJucM5dqpKct6BQUX+b4sX4lRjmGs4XgviEKGILkmWx5GOzsINhkMqgI+jaKx8/BJCerQ0KE9mRvMuezQ5mdn0VXkiUyL74bBsNYhnKP/0oNYF0LGDtkac2fUFLeFe/+JDLQWNp3FPOIpPcwvJJtaQax7T7pRYL1kjNAlTS+Iu3N/65Xwz9D6aTDhv3+oizRYl95uRGcBaZix7SZk1vh9aSfWqwuJXCpTCdeVxnvWBynjOFtVg/5sXP/5srHTkha3U8kBU5NUtLZxlkT4LA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 31 Mar
 2021 16:18:03 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 16:18:02 +0000
Date:   Wed, 31 Mar 2021 13:17:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Subject: Re: [PATCH v3 3/4] cxl/mem: Do not rely on device_add() side effects
 for dev_set_name() failures
Message-ID: <20210331161759.GL1463678@nvidia.com>
References: <161714738634.2168142.10860201861152789544.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161714740233.2168142.11116065966198937093.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210331130953.GG1463678@nvidia.com>
 <CAPcyv4inZaSRk-eiyeRLfUOrwyD=YVLW6bdUVJ239X099n1S=Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4inZaSRk-eiyeRLfUOrwyD=YVLW6bdUVJ239X099n1S=Q@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0323.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::28) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0323.namprd13.prod.outlook.com (2603:10b6:208:2c1::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.18 via Frontend Transport; Wed, 31 Mar 2021 16:18:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRdXb-006Nkt-Im; Wed, 31 Mar 2021 13:17:59 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 383cdd1f-b68e-4a4b-82c9-08d8f4608e77
X-MS-TrafficTypeDiagnostic: BY5PR12MB4242:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4242C866D928FB785C2D9BA7C27C9@BY5PR12MB4242.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WzhZT82oSXrHMxFUlcXcid/hVr+7mLrkrTSDNFleZ94aOPrnnuS/Oufb9RI/ZcMdVjmTnD893xtuh+1yvreqUgrxbMNNShi/rqi/HtO0ybXQDaVTnmR0Ul6UyOPayHtNNSQnK3mmKNYuMwRxXnUdVyhaQZauEw0GB6bkzP0ova/vl8V19XsJb0OlBSptUyNjZ7tGwQsaQRoha26foTLdW3hbrhggN3G+/Z5CbXTDPQGbR86TPuzam/gXqvkllu8gJf4fY9e4Fy80RBa+/KxP/7DP5Wq68+8CdlLkBGLWUWQpDf5lh/xsHpNeWrk7bhHbuox1oeNtJyhqixrrckAzHIiiHApU/CQi6yHETuIXD24+ZUDSpd10bZYoFUM4gUPyzYt/MGMNa2kFAXIjlYdjSJiVfyPV/curIpDcAOXr/t/Fw8/En85r8ZLS1TrEMpc/jQrcrOo0g0aeyCISKTodNcYQeE9WBnCQzrnV0PYzNan9jnyVQQvvLUEfRBehOGwksMJMW0MYSNBrvhNY8Xhkiogp5yDHCd5VijvVnkrdWyc+v3SrK9cHBNHuXy7Ee8k0Hmi9ZEIc3upEb5fYLZsKvfa4KS6N5coWgHSzTtENYhDr1I9mZ4mbTPC3iNZZIzBSfwRN47NLA29QP+5AmhqqztZZNUxkGeGaYAJdm2T+x3nmre26ZGXnPEPdR5cx1pV4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(36756003)(38100700001)(2616005)(8936002)(4326008)(54906003)(478600001)(316002)(9786002)(9746002)(2906002)(66556008)(1076003)(66946007)(8676002)(66476007)(5660300002)(86362001)(53546011)(426003)(186003)(6916009)(26005)(33656002)(83380400001)(56340200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bsNesRR3F2Gj4Ky8JHKf//CHmajcrKG52yhgUg+pQU6p1kfBKgI2M9fuITGW?=
 =?us-ascii?Q?rq87eU+W5QgpihXSYhr7xVSwaNUyLGTZYIbccSyXDDW8m3P0BmO5C5w5iuMn?=
 =?us-ascii?Q?mNabKrXYHymcQfCPlWrezqXInfVi2jbFwakPOaG0HaqKUYlPjdtTGtjHmoPD?=
 =?us-ascii?Q?siIcRXFpIn79+KtriH5mIerKNOUPJBAzkuisyJj7VY9MtC5N391a8PZV3zkq?=
 =?us-ascii?Q?GhMIRbiHBoP4Ugo3km7ctUsZ3JXBWVjd0Bv8Oa56pyKylRj1zUI0QDJVtkU3?=
 =?us-ascii?Q?VTQLMh6eDUQMCHcXSUbHe3hShOA/rt0koiLAksfLc88Fj9UCGFnfLrOAs9rx?=
 =?us-ascii?Q?fJJABXq6Hl07dhtJbl6C9V8s+0H8g+GgFpNPUMICVOVjSw5Uw7St1x8Ainv5?=
 =?us-ascii?Q?NnQROOFqrFxSGpB6E1kdJ9vFQBbivy+r+cZxYKqtcwPfyKLMKaK+6QJYgdZo?=
 =?us-ascii?Q?7jKYMkFiwXqZQd4QqcJLQCFPeGvEnWbxVzB1XjN1rFVriojy8XA+h6mygGpR?=
 =?us-ascii?Q?9eM+W4TANpCRTHf3Jr5Ge7Caekx7QcVqM1vQxL2j5R6Jmfk13GjlS24en5ac?=
 =?us-ascii?Q?ij+QY/X7uHLgdMMfMuJrwK4vgGoj06fcOnRelIoWrTjqoHjGJ3o1I5s2rmEZ?=
 =?us-ascii?Q?7107RDICBlXduj3oMNf90Ha3H6S/7pNKKPT53d5Yq2uLvgyZ46gcwZJuNs3b?=
 =?us-ascii?Q?50Qv4hhHfvaYYXsI5Q7O2Yn6PJEHK/VYmDpw0QMaexHINzfEGoM7axxQm//f?=
 =?us-ascii?Q?0Wo7U3t/L5DVH5CYLN+6l9Ej4eF0wUdovDqgUA5cJwgf+kkx/P3Hw2/3RRD8?=
 =?us-ascii?Q?YKn/eJ5ES9Ui4MciMgQ/JQ2+5Blf3CiZXE1EqG0aYvzNpW8pPscX2MTh+mOY?=
 =?us-ascii?Q?PbjVtu4M+HfsQwOZm8/RVeZTld8Nml1LKUTtLqr2mx+IYSYvA5uTgcjPnAGz?=
 =?us-ascii?Q?yTr6eIGbY1D+le5xdwzAV2T0jK2vQAydC23kGGoLCFfUaHGD+nlN7Gpg37Ce?=
 =?us-ascii?Q?h6KI3uDh0WuNKTnJgAcMMCoFgpWkQlIeJUedV40tR5LBdsQRN6SiFWTvNXuA?=
 =?us-ascii?Q?lkloq+S3Y/KUAZbQ7x5ghIM2bvnOv7+YCbjwES/olIZfDqxtraBEISx6xRSC?=
 =?us-ascii?Q?QeFGGUIGpTyoerTj0U1kV1WJYQX0zFxUzQ/YHsicj8SJpf4BR95A/3FOZZ6d?=
 =?us-ascii?Q?bm+9GHO0yiEbEIzy36LWHJ5QdiWz2IdYN2q3cQ8+7Wq2NbnVRKsVrpcr1tAv?=
 =?us-ascii?Q?DNwbbw8X5PqipHzcCQja4WcLCCDL+3ti4qCcgNWYYjj37hBE7b6xce1V71wu?=
 =?us-ascii?Q?NjNJh4agZlj4OXYDbl3WppszeOEXVUBZGB6TzZjzJnXq1Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383cdd1f-b68e-4a4b-82c9-08d8f4608e77
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 16:18:02.7893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfGgb0m2UxetsMys+RN5Y4PNXIRsJ5/G1Mo7KUcT1chmWlxGzbqz2xhhNthrHDpV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 31, 2021 at 09:04:32AM -0700, Dan Williams wrote:
> On Wed, Mar 31, 2021 at 6:10 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Mar 30, 2021 at 04:36:42PM -0700, Dan Williams wrote:
> > > +static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
> > > +{
> > > +     struct cxl_memdev *cxlmd;
> > > +     struct device *dev;
> > > +     struct cdev *cdev;
> > > +     int rc;
> > > +
> > > +     cxlmd = cxl_memdev_alloc(cxlm);
> > > +     if (IS_ERR(cxlmd))
> > > +             return PTR_ERR(cxlmd);
> > > +
> > > +     dev = &cxlmd->dev;
> > > +     rc = dev_set_name(dev, "mem%d", cxlmd->id);
> > > +     if (rc)
> > > +             goto err;
> > >
> > > +     cdev = &cxlmd->cdev;
> > >       cxl_memdev_activate(cxlmd, cxlm);
> > >       rc = cdev_device_add(cdev, dev);
> > >       if (rc)
> > > -             goto err_add;
> > > +             goto err;
> >
> > It might read nicer to have the error unwind here just call cxl_memdev_unregister()
> 
> Perhaps, but I don't think cdev_del() and device_del() are prepared to
> deal with an object that was not successfully added.

Oh, probably not, yuk yuk yuk.

Ideally cdev_device_add should not fail in a way that allows an open,
I think that is just an artifact of it being composed of smaller
functions..

For instance if we replace the kobj_map with xarray then we can
use xa_reserve and xa_store to avoid this condition.

This actually looks like a good fit because the dev_t has pretty
"lumpy" allocations and this isn't really performance sensitive.

A clever person could then make the dev_t self allocating and solve
another pain point with this interface. Hum..

Jason
